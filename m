Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46F9DD8894
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Oct 2019 08:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731020AbfJPGXk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Oct 2019 02:23:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:57612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730793AbfJPGXk (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 16 Oct 2019 02:23:40 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 506DF20873;
        Wed, 16 Oct 2019 06:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571207019;
        bh=AuN27xd95CurJ72wjqYKq5zMYg45LvzPhaAkybiv6ig=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qWa/xFtTsFZ4v6fEOl2Ie+v3ECpN0oCHkcod0Xhmc3WKARIb6UaZ7yutkXRJvU3pn
         rwbVUkrtYpzK7lzQcvto9CIeaDncuA4xe/LR6ZAgArUvqdWRJPSv1ZLtBr+emWVCx9
         Rk9XDct8yb5FanL0H/FOsyAEDGzrimy0TkKfpHGQ=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Erez Alfasi <ereza@mellanox.com>
Subject: [PATCH rdma-next v3 1/4] IB/mlx5: Introduce ODP diagnostic counters
Date:   Wed, 16 Oct 2019 09:23:05 +0300
Message-Id: <20191016062308.11886-2-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191016062308.11886-1-leon@kernel.org>
References: <20191016062308.11886-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Erez Alfasi <ereza@mellanox.com>

Introduce ODP diagnostic counters and count the following
per MR within IB/mlx5 driver:
 1) Page faults:
	Total number of faulted pages.
 2) Page invalidations:
	Total number of pages invalidated by the OS during all
	invalidation events. The translations can be no longer
	valid due to either non-present pages or mapping changes.

Signed-off-by: Erez Alfasi <ereza@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  4 ++++
 drivers/infiniband/hw/mlx5/odp.c     | 15 +++++++++++++++
 include/rdma/ib_verbs.h              |  5 +++++
 3 files changed, 24 insertions(+)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index bf30d53d94dc..5aae05ebf64b 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -585,6 +585,9 @@ struct mlx5_ib_dm {
 					  IB_ACCESS_REMOTE_READ   |\
 					  IB_ZERO_BASED)

+#define mlx5_update_odp_stats(mr, counter_name, value)		\
+	atomic64_add(value, &((mr)->odp_stats.counter_name))
+
 struct mlx5_ib_mr {
 	struct ib_mr		ibmr;
 	void			*descs;
@@ -622,6 +625,7 @@ struct mlx5_ib_mr {
 	wait_queue_head_t       q_leaf_free;
 	struct mlx5_async_work  cb_work;
 	atomic_t		num_pending_prefetch;
+	struct ib_odp_counters	odp_stats;
 };

 static inline bool is_odp_mr(struct mlx5_ib_mr *mr)
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 95cf0249b015..3601c6ad96f9 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -224,6 +224,7 @@ void mlx5_ib_invalidate_range(struct ib_umem_odp *umem_odp, unsigned long start,
 	const u64 umr_block_mask = (MLX5_UMR_MTT_ALIGNMENT /
 				    sizeof(struct mlx5_mtt)) - 1;
 	u64 idx = 0, blk_start_idx = 0;
+	u64 invalidations = 0;
 	int in_block = 0;
 	u64 addr;

@@ -261,6 +262,9 @@ void mlx5_ib_invalidate_range(struct ib_umem_odp *umem_odp, unsigned long start,
 				blk_start_idx = idx;
 				in_block = 1;
 			}
+
+			/* Count page invalidations */
+			invalidations += idx - blk_start_idx + 1;
 		} else {
 			u64 umr_offset = idx & umr_block_mask;

@@ -279,6 +283,9 @@ void mlx5_ib_invalidate_range(struct ib_umem_odp *umem_odp, unsigned long start,
 				   MLX5_IB_UPD_XLT_ZAP |
 				   MLX5_IB_UPD_XLT_ATOMIC);
 	mutex_unlock(&umem_odp->umem_mutex);
+
+	mlx5_update_odp_stats(mr, invalidations, invalidations);
+
 	/*
 	 * We are now sure that the device will not access the
 	 * memory. We can safely unmap it, and mark it as dirty if
@@ -287,6 +294,7 @@ void mlx5_ib_invalidate_range(struct ib_umem_odp *umem_odp, unsigned long start,

 	ib_umem_odp_unmap_dma_pages(umem_odp, start, end);

+
 	if (unlikely(!umem_odp->npages && mr->parent &&
 		     !umem_odp->dying)) {
 		WRITE_ONCE(umem_odp->dying, 1);
@@ -801,6 +809,13 @@ static int pagefault_single_data_segment(struct mlx5_ib_dev *dev,
 		if (ret < 0)
 			goto srcu_unlock;

+		/*
+		 * When prefetching a page, page fault is generated
+		 * in order to bring the page to the main memory.
+		 * In the current flow, page faults are being counted.
+		 */
+		mlx5_update_odp_stats(mr, faults, ret);
+
 		npages += ret;
 		ret = 0;
 		break;
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 6a47ba85c54c..26600dfb345d 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2218,6 +2218,11 @@ struct rdma_netdev_alloc_params {
 				      struct net_device *netdev, void *param);
 };

+struct ib_odp_counters {
+	atomic64_t faults;
+	atomic64_t invalidations;
+};
+
 struct ib_counters {
 	struct ib_device	*device;
 	struct ib_uobject	*uobject;
--
2.20.1

