Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7517326DA05
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Sep 2020 13:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbgIQLWQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Sep 2020 07:22:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:45928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726757AbgIQLWN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 17 Sep 2020 07:22:13 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E6E220771;
        Thu, 17 Sep 2020 11:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600341732;
        bh=i1j9Hhbbgbzhaa9xAmeyb2t/T0RQsbJlNgRAggdx/1E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N0k9/N13dVmBMFUTbW4k+xsqaPHIL69yxhp8Qy1gx5KYZ3F0hJgLNh5l2ZDoa4ZcN
         Z5GkGPKOODKhfZmfYPfaFRIuA1Sx3Dlx+75A+U9GsWoGgbtAGz0KYSNStmpapmXhN1
         qVqDF7u4a4cffaWxhCFfyd20HwqW5ofmBWTsYFB0=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Yishai Hadas <yishaih@nvidia.com>, linux-rdma@vger.kernel.org,
        Yishai Hadas <yishaih@nvida.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH rdma-next v1 4/4] RDMA/mlx5: Sync device with CPU pages upon ODP MR registration
Date:   Thu, 17 Sep 2020 14:21:52 +0300
Message-Id: <20200917112152.1075974-5-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200917112152.1075974-1-leon@kernel.org>
References: <20200917112152.1075974-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yishai Hadas <yishaih@nvidia.com>

Sync device with CPU pages upon ODP MR registration.
This reduce potential page faults down the road and improve performance.

Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  6 ++++++
 drivers/infiniband/hw/mlx5/mr.c      | 11 +++++++----
 drivers/infiniband/hw/mlx5/odp.c     | 22 +++++++++++++++++++++-
 3 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 6ab3efb75b21..8e77a262e44c 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1283,6 +1283,7 @@ void mlx5_odp_populate_xlt(void *xlt, size_t idx, size_t nentries,
 int mlx5_ib_advise_mr_prefetch(struct ib_pd *pd,
 			       enum ib_uverbs_advise_mr_advice advice,
 			       u32 flags, struct ib_sge *sg_list, u32 num_sge);
+int mlx5_ib_init_odp_mr(struct mlx5_ib_mr *mr, u64 user_va, size_t bcnt, bool enable);
 #else /* CONFIG_INFINIBAND_ON_DEMAND_PAGING */
 static inline void mlx5_ib_internal_fill_odp_caps(struct mlx5_ib_dev *dev)
 {
@@ -1304,6 +1305,11 @@ mlx5_ib_advise_mr_prefetch(struct ib_pd *pd,
 {
 	return -EOPNOTSUPP;
 }
+static inline int mlx5_ib_init_odp_mr(struct mlx5_ib_mr *mr, u64 user_va,
+				      size_t bcnt, bool enable)
+{
+	return -EOPNOTSUPP;
+}
 #endif /* CONFIG_INFINIBAND_ON_DEMAND_PAGING */

 extern const struct mmu_interval_notifier_ops mlx5_mn_ops;
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index dea65e511a3e..234a5d25a072 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1431,7 +1431,7 @@ struct ib_mr *mlx5_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 	mr->umem = umem;
 	set_mr_fields(dev, mr, npages, length, access_flags);

-	if (xlt_with_umr) {
+	if (xlt_with_umr && !(access_flags & IB_ACCESS_ON_DEMAND)) {
 		/*
 		 * If the MR was created with reg_create then it will be
 		 * configured properly but left disabled. It is safe to go ahead
@@ -1439,9 +1439,6 @@ struct ib_mr *mlx5_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 		 */
 		int update_xlt_flags = MLX5_IB_UPD_XLT_ENABLE;

-		if (access_flags & IB_ACCESS_ON_DEMAND)
-			update_xlt_flags |= MLX5_IB_UPD_XLT_ZAP;
-
 		err = mlx5_ib_update_xlt(mr, 0, ncont, page_shift,
 					 update_xlt_flags);
 		if (err) {
@@ -1467,6 +1464,12 @@ struct ib_mr *mlx5_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 			dereg_mr(dev, mr);
 			return ERR_PTR(err);
 		}
+
+		err = mlx5_ib_init_odp_mr(mr, start, length, xlt_with_umr);
+		if (err) {
+			dereg_mr(dev, mr);
+			return ERR_PTR(err);
+		}
 	}

 	return &mr->ibmr;
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 28b7227d31bf..61bff5ecb356 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -666,6 +666,7 @@ void mlx5_ib_fence_odp_mr(struct mlx5_ib_mr *mr)

 #define MLX5_PF_FLAGS_DOWNGRADE BIT(1)
 #define MLX5_PF_FLAGS_SNAPSHOT BIT(2)
+#define MLX5_PF_FLAGS_ENABLE BIT(3)
 static int pagefault_real_mr(struct mlx5_ib_mr *mr, struct ib_umem_odp *odp,
 			     u64 user_va, size_t bcnt, u32 *bytes_mapped,
 			     u32 flags)
@@ -675,6 +676,10 @@ static int pagefault_real_mr(struct mlx5_ib_mr *mr, struct ib_umem_odp *odp,
 	u64 access_mask;
 	u64 start_idx;
 	bool fault = !(flags & MLX5_PF_FLAGS_SNAPSHOT);
+	u32 xlt_flags = MLX5_IB_UPD_XLT_ATOMIC;
+
+	if (flags & MLX5_PF_FLAGS_ENABLE)
+		xlt_flags |= MLX5_IB_UPD_XLT_ENABLE;

 	page_shift = odp->page_shift;
 	start_idx = (user_va - ib_umem_start(odp)) >> page_shift;
@@ -692,7 +697,7 @@ static int pagefault_real_mr(struct mlx5_ib_mr *mr, struct ib_umem_odp *odp,
 	 * ib_umem_odp_map_dma_and_lock already checks this.
 	 */
 	ret = mlx5_ib_update_xlt(mr, start_idx, np,
-				 page_shift, MLX5_IB_UPD_XLT_ATOMIC);
+				 page_shift, xlt_flags);
 	mutex_unlock(&odp->umem_mutex);

 	if (ret < 0) {
@@ -827,6 +832,21 @@ static int pagefault_mr(struct mlx5_ib_mr *mr, u64 io_virt, size_t bcnt,
 				     flags);
 }

+int mlx5_ib_init_odp_mr(struct mlx5_ib_mr *mr, u64 user_va, size_t bcnt,
+			bool enable)
+{
+	u32 flags = MLX5_PF_FLAGS_SNAPSHOT;
+	int ret;
+
+	if (enable)
+		flags |= MLX5_PF_FLAGS_ENABLE;
+
+	ret = pagefault_real_mr(mr, to_ib_umem_odp(mr->umem),
+				user_va, bcnt, NULL,
+				flags);
+	return ret >= 0 ? 0 : ret;
+}
+
 struct pf_frame {
 	struct pf_frame *next;
 	u32 key;
--
2.26.2

