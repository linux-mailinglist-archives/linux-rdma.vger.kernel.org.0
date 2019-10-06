Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89CDECD33C
	for <lists+linux-rdma@lfdr.de>; Sun,  6 Oct 2019 17:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfJFPwH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 6 Oct 2019 11:52:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:33958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726466AbfJFPwG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 6 Oct 2019 11:52:06 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF81D20867;
        Sun,  6 Oct 2019 15:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570377125;
        bh=Jj/r6XonJZV2mO7Epz5nbXGiZg+0WW9PMc5Mpi3ApFY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=thndVoUXFMKjtVxMnjB1aDmELQ3L6wlF9HNkt4kiuCrC+qHC9odDW9d8z6dGvCOLH
         DAQB3XqPK7WovdEZ7dJeLbWRaQWptDJnhHSbrP3zjFAgeY8/pshBUZ/3yB3MxRCQQA
         cLtP65smZoJSUXkR+51GjKYVc1CzMaelFEPGxH5w=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Erez Alfasi <ereza@mellanox.com>
Subject: [PATCH rdma-next v2 1/4] IB/mlx5: Introduce ODP diagnostic counters
Date:   Sun,  6 Oct 2019 18:51:36 +0300
Message-Id: <20191006155139.30632-2-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191006155139.30632-1-leon@kernel.org>
References: <20191006155139.30632-1-leon@kernel.org>
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
 3) Prefetched pages:
	When prefetching a page, page fault is generated
	in order to bring the page to the main memory.
	The prefetched pages counter will be updated
	during a page fault flow only if it was derived
	from prefetching operation.

Signed-off-by: Erez Alfasi <ereza@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  4 ++++
 drivers/infiniband/hw/mlx5/odp.c     | 18 ++++++++++++++++++
 include/rdma/ib_verbs.h              |  6 ++++++
 3 files changed, 28 insertions(+)

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
index 95cf0249b015..966783bfb557 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -261,6 +261,10 @@ void mlx5_ib_invalidate_range(struct ib_umem_odp *umem_odp, unsigned long start,
 				blk_start_idx = idx;
 				in_block = 1;
 			}
+
+			/* Count page invalidations */
+			mlx5_update_odp_stats(mr, invalidations,
+					      (idx - blk_start_idx + 1));
 		} else {
 			u64 umr_offset = idx & umr_block_mask;
 
@@ -287,6 +291,7 @@ void mlx5_ib_invalidate_range(struct ib_umem_odp *umem_odp, unsigned long start,
 
 	ib_umem_odp_unmap_dma_pages(umem_odp, start, end);
 
+
 	if (unlikely(!umem_odp->npages && mr->parent &&
 		     !umem_odp->dying)) {
 		WRITE_ONCE(umem_odp->dying, 1);
@@ -801,6 +806,19 @@ static int pagefault_single_data_segment(struct mlx5_ib_dev *dev,
 		if (ret < 0)
 			goto srcu_unlock;
 
+		/*
+		 * When prefetching a page, page fault is generated
+		 * in order to bring the page to the main memory.
+		 * In the current flow, page faults are being counted.
+		 * Prefetched pages counter will be updated as well
+		 * only if the current page fault flow was derived
+		 * from prefetching flow.
+		 */
+		mlx5_update_odp_stats(mr, faults, ret);
+
+		if (prefetch)
+			mlx5_update_odp_stats(mr, prefetched, ret);
+
 		npages += ret;
 		ret = 0;
 		break;
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 6a47ba85c54c..3990054656b9 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2218,6 +2218,12 @@ struct rdma_netdev_alloc_params {
 				      struct net_device *netdev, void *param);
 };
 
+struct ib_odp_counters {
+	atomic64_t faults;
+	atomic64_t invalidations;
+	atomic64_t prefetched;
+};
+
 struct ib_counters {
 	struct ib_device	*device;
 	struct ib_uobject	*uobject;
-- 
2.20.1

