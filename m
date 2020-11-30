Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F07C02C7F75
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Nov 2020 08:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgK3H7i (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Nov 2020 02:59:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:56644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726906AbgK3H7i (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 30 Nov 2020 02:59:38 -0500
Received: from localhost (searspoint.nvidia.com [216.228.112.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F3042074A;
        Mon, 30 Nov 2020 07:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606723137;
        bh=z7kC0F0lxMXcjJfKOns+aWbCfqdErDIPfOuvNGsD+ZA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QMB8IpXgy+uNbM8ombz7Eh35IZZOlAno5ffQ3FNvFn3nhsNsCouKWQgvJpoT1nZz2
         iOhfc+uhnRubjyOlqu1+RxK1oieK43grry9GdP0PeUIcsb2lAsLolDjTP9oAs9sBc/
         OqYgp3bLaaUB4xWg6oQzgaPSFg6mzx5M5ALbp5Yo=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 4/5] RDMA/mlx5: Reorganize mlx5_ib_reg_user_mr()
Date:   Mon, 30 Nov 2020 09:58:38 +0200
Message-Id: <20201130075839.278575-5-leon@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201130075839.278575-1-leon@kernel.org>
References: <20201130075839.278575-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>

This function handles an ODP and regular MR flow all mushed together, even
though the two flows are quite different. Split them into two dedicated
functions.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h |   4 +-
 drivers/infiniband/hw/mlx5/mr.c      | 249 ++++++++++++++-------------
 drivers/infiniband/hw/mlx5/odp.c     |  16 +-
 3 files changed, 140 insertions(+), 129 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index ab84d4efbda3..fac495e7834e 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1340,7 +1340,7 @@ void mlx5_odp_populate_xlt(void *xlt, size_t idx, size_t nentries,
 int mlx5_ib_advise_mr_prefetch(struct ib_pd *pd,
 			       enum ib_uverbs_advise_mr_advice advice,
 			       u32 flags, struct ib_sge *sg_list, u32 num_sge);
-int mlx5_ib_init_odp_mr(struct mlx5_ib_mr *mr, bool enable);
+int mlx5_ib_init_odp_mr(struct mlx5_ib_mr *mr);
 #else /* CONFIG_INFINIBAND_ON_DEMAND_PAGING */
 static inline void mlx5_ib_internal_fill_odp_caps(struct mlx5_ib_dev *dev)
 {
@@ -1362,7 +1362,7 @@ mlx5_ib_advise_mr_prefetch(struct ib_pd *pd,
 {
 	return -EOPNOTSUPP;
 }
-static inline int mlx5_ib_init_odp_mr(struct mlx5_ib_mr *mr, bool enable)
+static inline int mlx5_ib_init_odp_mr(struct mlx5_ib_mr *mr)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 5200e93944e7..4905454a41fd 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -56,6 +56,10 @@ enum {
 
 static void
 create_mkey_callback(int status, struct mlx5_async_work *context);
+static struct mlx5_ib_mr *reg_create(struct ib_mr *ibmr, struct ib_pd *pd,
+				     struct ib_umem *umem, u64 iova,
+				     int access_flags, unsigned int page_size,
+				     bool populate);
 
 static void set_mkc_access_pd_addr_fields(void *mkc, int acc, u64 start_addr,
 					  struct ib_pd *pd)
@@ -875,32 +879,6 @@ static int mr_cache_max_order(struct mlx5_ib_dev *dev)
 	return MLX5_MAX_UMR_SHIFT;
 }
 
-static struct ib_umem *mr_umem_get(struct mlx5_ib_dev *dev, u64 start,
-				   u64 length, int access_flags)
-{
-	struct ib_umem *u;
-
-	if (access_flags & IB_ACCESS_ON_DEMAND) {
-		struct ib_umem_odp *odp;
-
-		odp = ib_umem_odp_get(&dev->ib_dev, start, length, access_flags,
-				      &mlx5_mn_ops);
-		if (IS_ERR(odp)) {
-			mlx5_ib_dbg(dev, "umem get failed (%ld)\n",
-				    PTR_ERR(odp));
-			return ERR_CAST(odp);
-		}
-		return &odp->umem;
-	}
-
-	u = ib_umem_get(&dev->ib_dev, start, length, access_flags);
-	if (IS_ERR(u)) {
-		mlx5_ib_dbg(dev, "umem get failed (%ld)\n", PTR_ERR(u));
-		return u;
-	}
-	return u;
-}
-
 static void mlx5_ib_umr_done(struct ib_cq *cq, struct ib_wc *wc)
 {
 	struct mlx5_ib_umr_context *context =
@@ -957,9 +935,18 @@ static struct mlx5_cache_ent *mr_cache_ent_from_order(struct mlx5_ib_dev *dev,
 	return &cache->ent[order];
 }
 
-static struct mlx5_ib_mr *alloc_mr_from_cache(struct ib_pd *pd,
-					      struct ib_umem *umem, u64 iova,
-					      int access_flags)
+static void set_mr_fields(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr,
+			  u64 length, int access_flags)
+{
+	mr->ibmr.lkey = mr->mmkey.key;
+	mr->ibmr.rkey = mr->mmkey.key;
+	mr->ibmr.length = length;
+	mr->access_flags = access_flags;
+}
+
+static struct mlx5_ib_mr *alloc_cacheable_mr(struct ib_pd *pd,
+					     struct ib_umem *umem, u64 iova,
+					     int access_flags)
 {
 	struct mlx5_ib_dev *dev = to_mdev(pd->device);
 	struct mlx5_cache_ent *ent;
@@ -971,16 +958,26 @@ static struct mlx5_ib_mr *alloc_mr_from_cache(struct ib_pd *pd,
 		return ERR_PTR(-EINVAL);
 	ent = mr_cache_ent_from_order(
 		dev, order_base_2(ib_umem_num_dma_blocks(umem, page_size)));
-	if (!ent)
-		return ERR_PTR(-E2BIG);
-
-	/* Matches access in alloc_cache_mr() */
-	if (!mlx5_ib_can_reconfig_with_umr(dev, 0, access_flags))
-		return ERR_PTR(-EOPNOTSUPP);
+	/*
+	 * Matches access in alloc_cache_mr(). If the MR can't come from the
+	 * cache then synchronously create an uncached one.
+	 */
+	if (!ent || ent->limit == 0 ||
+	    !mlx5_ib_can_reconfig_with_umr(dev, 0, access_flags)) {
+		mutex_lock(&dev->slow_path_mutex);
+		mr = reg_create(NULL, pd, umem, iova, access_flags, page_size,
+				false);
+		mutex_unlock(&dev->slow_path_mutex);
+		return mr;
+	}
 
 	mr = get_cache_mr(ent);
 	if (!mr) {
 		mr = create_cache_mr(ent);
+		/*
+		 * The above already tried to do the same stuff as reg_create(),
+		 * no reason to try it again.
+		 */
 		if (IS_ERR(mr))
 			return mr;
 	}
@@ -993,6 +990,8 @@ static struct mlx5_ib_mr *alloc_mr_from_cache(struct ib_pd *pd,
 	mr->mmkey.size = umem->length;
 	mr->mmkey.pd = to_mpd(pd)->pdn;
 	mr->page_shift = order_base_2(page_size);
+	mr->umem = umem;
+	set_mr_fields(dev, mr, umem->length, access_flags);
 
 	return mr;
 }
@@ -1279,10 +1278,10 @@ static int mlx5_ib_update_mr_pas(struct mlx5_ib_mr *mr, unsigned int flags)
  */
 static struct mlx5_ib_mr *reg_create(struct ib_mr *ibmr, struct ib_pd *pd,
 				     struct ib_umem *umem, u64 iova,
-				     int access_flags, bool populate)
+				     int access_flags, unsigned int page_size,
+				     bool populate)
 {
 	struct mlx5_ib_dev *dev = to_mdev(pd->device);
-	unsigned int page_size;
 	struct mlx5_ib_mr *mr;
 	__be64 *pas;
 	void *mkc;
@@ -1291,11 +1290,12 @@ static struct mlx5_ib_mr *reg_create(struct ib_mr *ibmr, struct ib_pd *pd,
 	int err;
 	bool pg_cap = !!(MLX5_CAP_GEN(dev->mdev, pg));
 
-	page_size =
-		mlx5_umem_find_best_pgsz(umem, mkc, log_page_size, 0, iova);
-	if (WARN_ON(!page_size))
-		return ERR_PTR(-EINVAL);
-
+	if (!page_size) {
+		page_size = mlx5_umem_find_best_pgsz(umem, mkc, log_page_size,
+						     0, iova);
+		if (!page_size)
+			return ERR_PTR(-EINVAL);
+	}
 	mr = ibmr ? to_mmr(ibmr) : kzalloc(sizeof(*mr), GFP_KERNEL);
 	if (!mr)
 		return ERR_PTR(-ENOMEM);
@@ -1352,6 +1352,8 @@ static struct mlx5_ib_mr *reg_create(struct ib_mr *ibmr, struct ib_pd *pd,
 	mr->mmkey.type = MLX5_MKEY_MR;
 	mr->desc_size = sizeof(struct mlx5_mtt);
 	mr->dev = dev;
+	mr->umem = umem;
+	set_mr_fields(dev, mr, umem->length, access_flags);
 	kvfree(in);
 
 	mlx5_ib_dbg(dev, "mkey = 0x%x\n", mr->mmkey.key);
@@ -1368,15 +1370,6 @@ static struct mlx5_ib_mr *reg_create(struct ib_mr *ibmr, struct ib_pd *pd,
 	return ERR_PTR(err);
 }
 
-static void set_mr_fields(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr,
-			  u64 length, int access_flags)
-{
-	mr->ibmr.lkey = mr->mmkey.key;
-	mr->ibmr.rkey = mr->mmkey.key;
-	mr->ibmr.length = length;
-	mr->access_flags = access_flags;
-}
-
 static struct ib_mr *mlx5_ib_get_dm_mr(struct ib_pd *pd, u64 start_addr,
 				       u64 length, int acc, int mode)
 {
@@ -1472,70 +1465,32 @@ struct ib_mr *mlx5_ib_reg_dm_mr(struct ib_pd *pd, struct ib_dm *dm,
 				 attr->access_flags, mode);
 }
 
-struct ib_mr *mlx5_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
-				  u64 virt_addr, int access_flags,
-				  struct ib_udata *udata)
+static struct ib_mr *create_real_mr(struct ib_pd *pd, struct ib_umem *umem,
+				    u64 iova, int access_flags)
 {
 	struct mlx5_ib_dev *dev = to_mdev(pd->device);
 	struct mlx5_ib_mr *mr = NULL;
 	bool xlt_with_umr;
-	struct ib_umem *umem;
 	int err;
 
-	if (!IS_ENABLED(CONFIG_INFINIBAND_USER_MEM))
-		return ERR_PTR(-EOPNOTSUPP);
-
-	mlx5_ib_dbg(dev, "start 0x%llx, virt_addr 0x%llx, length 0x%llx, access_flags 0x%x\n",
-		    start, virt_addr, length, access_flags);
-
-	xlt_with_umr = mlx5_ib_can_load_pas_with_umr(dev, length);
-	/* ODP requires xlt update via umr to work. */
-	if (!xlt_with_umr && (access_flags & IB_ACCESS_ON_DEMAND))
-		return ERR_PTR(-EINVAL);
-
-	if (IS_ENABLED(CONFIG_INFINIBAND_ON_DEMAND_PAGING) && !start &&
-	    length == U64_MAX) {
-		if (virt_addr != start)
-			return ERR_PTR(-EINVAL);
-		if (!(access_flags & IB_ACCESS_ON_DEMAND) ||
-		    !(dev->odp_caps.general_caps & IB_ODP_SUPPORT_IMPLICIT))
-			return ERR_PTR(-EINVAL);
-
-		mr = mlx5_ib_alloc_implicit_mr(to_mpd(pd), udata, access_flags);
-		if (IS_ERR(mr))
-			return ERR_CAST(mr);
-		return &mr->ibmr;
-	}
-
-	umem = mr_umem_get(dev, start, length, access_flags);
-	if (IS_ERR(umem))
-		return ERR_CAST(umem);
-
+	xlt_with_umr = mlx5_ib_can_load_pas_with_umr(dev, umem->length);
 	if (xlt_with_umr) {
-		mr = alloc_mr_from_cache(pd, umem, virt_addr, access_flags);
-		if (IS_ERR(mr))
-			mr = NULL;
-	}
-
-	if (!mr) {
+		mr = alloc_cacheable_mr(pd, umem, iova, access_flags);
+	} else {
 		mutex_lock(&dev->slow_path_mutex);
-		mr = reg_create(NULL, pd, umem, virt_addr, access_flags,
-				!xlt_with_umr);
+		mr = reg_create(NULL, pd, umem, iova, access_flags, 0, true);
 		mutex_unlock(&dev->slow_path_mutex);
 	}
-
 	if (IS_ERR(mr)) {
-		err = PTR_ERR(mr);
-		goto error;
+		ib_umem_release(umem);
+		return ERR_CAST(mr);
 	}
 
 	mlx5_ib_dbg(dev, "mkey 0x%x\n", mr->mmkey.key);
 
-	mr->umem = umem;
-	atomic_add(ib_umem_num_pages(mr->umem), &dev->mdev->priv.reg_pages);
-	set_mr_fields(dev, mr, length, access_flags);
+	atomic_add(ib_umem_num_pages(umem), &dev->mdev->priv.reg_pages);
 
-	if (xlt_with_umr && !(access_flags & IB_ACCESS_ON_DEMAND)) {
+	if (xlt_with_umr) {
 		/*
 		 * If the MR was created with reg_create then it will be
 		 * configured properly but left disabled. It is safe to go ahead
@@ -1547,32 +1502,88 @@ struct ib_mr *mlx5_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 			return ERR_PTR(err);
 		}
 	}
+	return &mr->ibmr;
+}
 
-	if (is_odp_mr(mr)) {
-		to_ib_umem_odp(mr->umem)->private = mr;
-		init_waitqueue_head(&mr->q_deferred_work);
-		atomic_set(&mr->num_deferred_work, 0);
-		err = xa_err(xa_store(&dev->odp_mkeys,
-				      mlx5_base_mkey(mr->mmkey.key), &mr->mmkey,
-				      GFP_KERNEL));
-		if (err) {
-			dereg_mr(dev, mr);
-			return ERR_PTR(err);
-		}
+static struct ib_mr *create_user_odp_mr(struct ib_pd *pd, u64 start, u64 length,
+					u64 iova, int access_flags,
+					struct ib_udata *udata)
+{
+	struct mlx5_ib_dev *dev = to_mdev(pd->device);
+	struct ib_umem_odp *odp;
+	struct mlx5_ib_mr *mr;
+	int err;
 
-		err = mlx5_ib_init_odp_mr(mr, xlt_with_umr);
-		if (err) {
-			dereg_mr(dev, mr);
-			return ERR_PTR(err);
-		}
+	if (!IS_ENABLED(CONFIG_INFINIBAND_ON_DEMAND_PAGING))
+		return ERR_PTR(-EOPNOTSUPP);
+
+	if (!start && length == U64_MAX) {
+		if (iova != 0)
+			return ERR_PTR(-EINVAL);
+		if (!(dev->odp_caps.general_caps & IB_ODP_SUPPORT_IMPLICIT))
+			return ERR_PTR(-EINVAL);
+
+		mr = mlx5_ib_alloc_implicit_mr(to_mpd(pd), udata, access_flags);
+		if (IS_ERR(mr))
+			return ERR_CAST(mr);
+		return &mr->ibmr;
 	}
 
+	/* ODP requires xlt update via umr to work. */
+	if (!mlx5_ib_can_load_pas_with_umr(dev, length))
+		return ERR_PTR(-EINVAL);
+
+	odp = ib_umem_odp_get(&dev->ib_dev, start, length, access_flags,
+			      &mlx5_mn_ops);
+	if (IS_ERR(odp))
+		return ERR_CAST(odp);
+
+	mr = alloc_cacheable_mr(pd, &odp->umem, iova, access_flags);
+	if (IS_ERR(mr)) {
+		ib_umem_release(&odp->umem);
+		return ERR_CAST(mr);
+	}
+
+	odp->private = mr;
+	init_waitqueue_head(&mr->q_deferred_work);
+	atomic_set(&mr->num_deferred_work, 0);
+	err = xa_err(xa_store(&dev->odp_mkeys, mlx5_base_mkey(mr->mmkey.key),
+			      &mr->mmkey, GFP_KERNEL));
+	if (err)
+		goto err_dereg_mr;
+
+	err = mlx5_ib_init_odp_mr(mr);
+	if (err)
+		goto err_dereg_mr;
 	return &mr->ibmr;
-error:
-	ib_umem_release(umem);
+
+err_dereg_mr:
+	dereg_mr(dev, mr);
 	return ERR_PTR(err);
 }
 
+struct ib_mr *mlx5_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
+				  u64 iova, int access_flags,
+				  struct ib_udata *udata)
+{
+	struct mlx5_ib_dev *dev = to_mdev(pd->device);
+	struct ib_umem *umem;
+
+	if (!IS_ENABLED(CONFIG_INFINIBAND_USER_MEM))
+		return ERR_PTR(-EOPNOTSUPP);
+
+	mlx5_ib_dbg(dev, "start 0x%llx, iova 0x%llx, length 0x%llx, access_flags 0x%x\n",
+		    start, iova, length, access_flags);
+
+	if (access_flags & IB_ACCESS_ON_DEMAND)
+		return create_user_odp_mr(pd, start, length, iova, access_flags,
+					  udata);
+	umem = ib_umem_get(&dev->ib_dev, start, length, access_flags);
+	if (IS_ERR(umem))
+		return ERR_CAST(umem);
+	return create_real_mr(pd, umem, iova, access_flags);
+}
+
 /**
  * mlx5_mr_cache_invalidate - Fence all DMA on the MR
  * @mr: The MR to fence
@@ -1662,7 +1673,7 @@ struct ib_mr *mlx5_ib_rereg_user_mr(struct ib_mr *ib_mr, int flags, u64 start,
 		atomic_sub(ib_umem_num_pages(mr->umem),
 			   &dev->mdev->priv.reg_pages);
 		ib_umem_release(mr->umem);
-		mr->umem = mr_umem_get(dev, addr, len, access_flags);
+		mr->umem = ib_umem_get(&dev->ib_dev, addr, len, access_flags);
 		if (IS_ERR(mr->umem)) {
 			err = PTR_ERR(mr->umem);
 			mr->umem = NULL;
@@ -1686,7 +1697,7 @@ struct ib_mr *mlx5_ib_rereg_user_mr(struct ib_mr *ib_mr, int flags, u64 start,
 		if (err)
 			goto err;
 
-		mr = reg_create(ib_mr, pd, mr->umem, addr, access_flags, true);
+		mr = reg_create(ib_mr, pd, mr->umem, addr, access_flags, 0, true);
 		if (IS_ERR(mr)) {
 			err = PTR_ERR(mr);
 			mr = to_mmr(ib_mr);
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 5c853ec1b0d8..f4a28a012187 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -536,6 +536,10 @@ struct mlx5_ib_mr *mlx5_ib_alloc_implicit_mr(struct mlx5_ib_pd *pd,
 	struct mlx5_ib_mr *imr;
 	int err;
 
+	if (!mlx5_ib_can_load_pas_with_umr(dev,
+					   MLX5_IMR_MTT_ENTRIES * PAGE_SIZE))
+		return ERR_PTR(-EOPNOTSUPP);
+
 	umem_odp = ib_umem_odp_alloc_implicit(&dev->ib_dev, access_flags);
 	if (IS_ERR(umem_odp))
 		return ERR_CAST(umem_odp);
@@ -831,17 +835,13 @@ static int pagefault_mr(struct mlx5_ib_mr *mr, u64 io_virt, size_t bcnt,
 				     flags);
 }
 
-int mlx5_ib_init_odp_mr(struct mlx5_ib_mr *mr, bool enable)
+int mlx5_ib_init_odp_mr(struct mlx5_ib_mr *mr)
 {
-	u32 flags = MLX5_PF_FLAGS_SNAPSHOT;
 	int ret;
 
-	if (enable)
-		flags |= MLX5_PF_FLAGS_ENABLE;
-
-	ret = pagefault_real_mr(mr, to_ib_umem_odp(mr->umem),
-				mr->umem->address, mr->umem->length, NULL,
-				flags);
+	ret = pagefault_real_mr(mr, to_ib_umem_odp(mr->umem), mr->umem->address,
+				mr->umem->length, NULL,
+				MLX5_PF_FLAGS_SNAPSHOT | MLX5_PF_FLAGS_ENABLE);
 	return ret >= 0 ? 0 : ret;
 }
 
-- 
2.28.0

