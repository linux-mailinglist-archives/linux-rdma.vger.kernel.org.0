Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1FDB268A8E
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Sep 2020 14:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbgINMCh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Sep 2020 08:02:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:51270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726137AbgINLkp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 14 Sep 2020 07:40:45 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69EAF21BE5;
        Mon, 14 Sep 2020 11:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600083602;
        bh=uVQen7gjGriryo8Trih3a/7b8Kl2bU765I8n+GQhiHw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CKoJBpPt9m8UkT6XyPY9GHVYn8Zx5SmV3P2rcnJIeWYe+5UNteHx0ebnyg4lWvLrH
         svPccchHEBu93q1IuYoisgOEYvqLJ8vB37paAVYZsT3rYHIy4s2jdg4rt4EjDVidqD
         zClBFHxkKUn451qNY/N91tw0P179pH6aHeL1kgd4=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Yishai Hadas <yishaih@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 3/4] RDMA/mlx5: Extend advice MR to support non faulting mode
Date:   Mon, 14 Sep 2020 14:39:48 +0300
Message-Id: <20200914113949.346562-4-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200914113949.346562-1-leon@kernel.org>
References: <20200914113949.346562-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yishai Hadas <yishaih@mellanox.com>

Extend advice MR to support non faulting mode, this improves performance
by eliminating page faults and bring only the existing CPU pages.

Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mr.c         | 3 ++-
 drivers/infiniband/hw/mlx5/odp.c        | 7 ++++++-
 include/uapi/rdma/ib_user_ioctl_verbs.h | 1 +
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 6b0d6109afc6..dea65e511a3e 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1321,7 +1321,8 @@ int mlx5_ib_advise_mr(struct ib_pd *pd,
 		      struct uverbs_attr_bundle *attrs)
 {
 	if (advice != IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH &&
-	    advice != IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH_WRITE)
+	    advice != IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH_WRITE &&
+	    advice != IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH_NO_FAULT)
 		return -EOPNOTSUPP;
 
 	return mlx5_ib_advise_mr_prefetch(pd, advice, flags,
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 133d54b6f447..adfb926a7906 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -665,6 +665,7 @@ void mlx5_ib_fence_odp_mr(struct mlx5_ib_mr *mr)
 }
 
 #define MLX5_PF_FLAGS_DOWNGRADE BIT(1)
+#define MLX5_PF_FLAGS_SNAPSHOT BIT(2)
 static int pagefault_real_mr(struct mlx5_ib_mr *mr, struct ib_umem_odp *odp,
 			     u64 user_va, size_t bcnt, u32 *bytes_mapped,
 			     u32 flags)
@@ -673,6 +674,7 @@ static int pagefault_real_mr(struct mlx5_ib_mr *mr, struct ib_umem_odp *odp,
 	bool downgrade = flags & MLX5_PF_FLAGS_DOWNGRADE;
 	u64 access_mask;
 	u64 start_idx;
+	bool fault = !(flags & MLX5_PF_FLAGS_SNAPSHOT);
 
 	page_shift = odp->page_shift;
 	start_idx = (user_va - ib_umem_start(odp)) >> page_shift;
@@ -681,7 +683,7 @@ static int pagefault_real_mr(struct mlx5_ib_mr *mr, struct ib_umem_odp *odp,
 	if (odp->umem.writable && !downgrade)
 		access_mask |= ODP_WRITE_ALLOWED_BIT;
 
-	np = ib_umem_odp_map_dma_and_lock(odp, user_va, bcnt, access_mask, true);
+	np = ib_umem_odp_map_dma_and_lock(odp, user_va, bcnt, access_mask, fault);
 	if (np < 0)
 		return np;
 
@@ -1852,6 +1854,9 @@ int mlx5_ib_advise_mr_prefetch(struct ib_pd *pd,
 	if (advice == IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH)
 		pf_flags |= MLX5_PF_FLAGS_DOWNGRADE;
 
+	if (advice == IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH_NO_FAULT)
+		pf_flags |= MLX5_PF_FLAGS_SNAPSHOT;
+
 	if (flags & IB_UVERBS_ADVISE_MR_FLAG_FLUSH)
 		return mlx5_ib_prefetch_sg_list(pd, advice, pf_flags, sg_list,
 						num_sge);
diff --git a/include/uapi/rdma/ib_user_ioctl_verbs.h b/include/uapi/rdma/ib_user_ioctl_verbs.h
index cfea82acfe57..22483799cd07 100644
--- a/include/uapi/rdma/ib_user_ioctl_verbs.h
+++ b/include/uapi/rdma/ib_user_ioctl_verbs.h
@@ -208,6 +208,7 @@ enum ib_uverbs_read_counters_flags {
 enum ib_uverbs_advise_mr_advice {
 	IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH,
 	IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH_WRITE,
+	IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH_NO_FAULT,
 };
 
 enum ib_uverbs_advise_mr_flag {
-- 
2.26.2

