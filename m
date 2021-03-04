Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6660932D29E
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Mar 2021 13:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240115AbhCDMIw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Mar 2021 07:08:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:55520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239866AbhCDMIm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 4 Mar 2021 07:08:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 138C164F2C;
        Thu,  4 Mar 2021 12:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614859681;
        bh=0g7FWrAgn7UlWT/weM2EskLKutksiNNqUajMkOJGYpk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HicEa2bAPJ3hVKGKs83vZpr6TWzQCL/p5xA9N2DyKz8npmjpfHPC9Z7B+6XAbEPGV
         btB2/2uyyqdfP5f+0goilX/ehNuCF4FA5mjs+mWxK0kyslyvKuTrqtD3P5cDRCVim6
         N8Ipd+8W025PpFkhyj46rb7dT1haMpgiV7L3xvy/NZqprqow2dAjq6tmFEJTMKDhqC
         I9W8IUQQpD7pznCD0SssqTNzlnTyHFP/PfhjFhIrotnBxxkhS3rge6DqFm/Vb/wTEU
         Pnh3VNPTTaAV2p3tbhs/8wmpO0HslIbRyMs+TnTPI0IKslJBt/nVsxLg27xCfKK7UF
         ByQe4CObHxjzA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 3/4] RDMA/mlx5: Consolidate MR destruction to mlx5_ib_dereg_mr()
Date:   Thu,  4 Mar 2021 14:07:44 +0200
Message-Id: <20210304120745.1090751-4-leon@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210304120745.1090751-1-leon@kernel.org>
References: <20210304120745.1090751-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>

Now that the SRCU stuff has been removed the entire MR destroy logic can
be made a lot simpler. Currently there are many different ways to destroy a
MR and it makes it really hard to do this task correctly. Route all
destruction through mlx5_ib_dereg_mr() and make it work for all
situations.

Since it turns out all the different MR types do basically the same thing
this removes a lot of knowledge of MR internals from ODP and leaves ODP
just exporting an operation to clean up children.

This fixes a few weird corner cases bugs and firmly uses the correct
ordering of the MR destruction:
 - Stop parallel access to the mkey via the ODP xarray
 - Stop DMA
 - Release the umem
 - Clean up ODP children
 - Free/Recycle the MR

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/umem_dmabuf.c |   4 +
 drivers/infiniband/hw/mlx5/mlx5_ib.h  |   5 +-
 drivers/infiniband/hw/mlx5/mr.c       | 133 +++++++++++------------
 drivers/infiniband/hw/mlx5/odp.c      | 151 ++++----------------------
 4 files changed, 90 insertions(+), 203 deletions(-)

diff --git a/drivers/infiniband/core/umem_dmabuf.c b/drivers/infiniband/core/umem_dmabuf.c
index f9b5162d9260..0d65ce146fc4 100644
--- a/drivers/infiniband/core/umem_dmabuf.c
+++ b/drivers/infiniband/core/umem_dmabuf.c
@@ -168,6 +168,10 @@ void ib_umem_dmabuf_release(struct ib_umem_dmabuf *umem_dmabuf)
 {
 	struct dma_buf *dmabuf = umem_dmabuf->attach->dmabuf;
 
+	dma_resv_lock(dmabuf->resv, NULL);
+	ib_umem_dmabuf_unmap_pages(umem_dmabuf);
+	dma_resv_unlock(dmabuf->resv);
+
 	dma_buf_detach(dmabuf, umem_dmabuf->attach);
 	dma_buf_put(dmabuf);
 	kfree(umem_dmabuf);
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 03deca79c9cf..544a41fec9cd 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1285,8 +1285,7 @@ struct mlx5_ib_mr *mlx5_ib_alloc_implicit_mr(struct mlx5_ib_pd *pd,
 					     struct ib_udata *udata,
 					     int access_flags);
 void mlx5_ib_free_implicit_mr(struct mlx5_ib_mr *mr);
-void mlx5_ib_fence_odp_mr(struct mlx5_ib_mr *mr);
-void mlx5_ib_fence_dmabuf_mr(struct mlx5_ib_mr *mr);
+void mlx5_ib_free_odp_mr(struct mlx5_ib_mr *mr);
 struct ib_mr *mlx5_ib_rereg_user_mr(struct ib_mr *ib_mr, int flags, u64 start,
 				    u64 length, u64 virt_addr, int access_flags,
 				    struct ib_pd *pd, struct ib_udata *udata);
@@ -1334,8 +1333,6 @@ int mlx5_mr_cache_cleanup(struct mlx5_ib_dev *dev);
 
 struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev,
 				       unsigned int entry, int access_flags);
-void mlx5_mr_cache_free(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr);
-int mlx5_mr_cache_invalidate(struct mlx5_ib_mr *mr);
 
 int mlx5_ib_check_mr_status(struct ib_mr *ibmr, u32 check_mask,
 			    struct ib_mr_status *mr_status);
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 54fd38b01a7e..6304ba54a42d 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -119,8 +119,6 @@ mlx5_ib_create_mkey_cb(struct mlx5_ib_dev *dev,
 				create_mkey_callback, context);
 }
 
-static void clean_mr(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr);
-static void dereg_mr(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr);
 static int mr_cache_max_order(struct mlx5_ib_dev *dev);
 static void queue_adjust_cache_locked(struct mlx5_cache_ent *ent);
 
@@ -627,30 +625,10 @@ static struct mlx5_ib_mr *get_cache_mr(struct mlx5_cache_ent *req_ent)
 	return NULL;
 }
 
-static void detach_mr_from_cache(struct mlx5_ib_mr *mr)
+static void mlx5_mr_cache_free(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr)
 {
 	struct mlx5_cache_ent *ent = mr->cache_ent;
 
-	mr->cache_ent = NULL;
-	spin_lock_irq(&ent->lock);
-	ent->total_mrs--;
-	spin_unlock_irq(&ent->lock);
-}
-
-void mlx5_mr_cache_free(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr)
-{
-	struct mlx5_cache_ent *ent = mr->cache_ent;
-
-	if (!ent)
-		return;
-
-	if (mlx5_mr_cache_invalidate(mr)) {
-		detach_mr_from_cache(mr);
-		destroy_mkey(dev, mr);
-		kfree(mr);
-		return;
-	}
-
 	spin_lock_irq(&ent->lock);
 	list_add_tail(&mr->list, &ent->head);
 	ent->available_mrs++;
@@ -1503,7 +1481,7 @@ static struct ib_mr *create_real_mr(struct ib_pd *pd, struct ib_umem *umem,
 		 */
 		err = mlx5_ib_update_mr_pas(mr, MLX5_IB_UPD_XLT_ENABLE);
 		if (err) {
-			dereg_mr(dev, mr);
+			mlx5_ib_dereg_mr(&mr->ibmr, NULL);
 			return ERR_PTR(err);
 		}
 	}
@@ -1560,7 +1538,7 @@ static struct ib_mr *create_user_odp_mr(struct ib_pd *pd, u64 start, u64 length,
 	return &mr->ibmr;
 
 err_dereg_mr:
-	dereg_mr(dev, mr);
+	mlx5_ib_dereg_mr(&mr->ibmr, NULL);
 	return ERR_PTR(err);
 }
 
@@ -1657,7 +1635,7 @@ struct ib_mr *mlx5_ib_reg_user_mr_dmabuf(struct ib_pd *pd, u64 offset,
 	return &mr->ibmr;
 
 err_dereg_mr:
-	dereg_mr(dev, mr);
+	mlx5_ib_dereg_mr(&mr->ibmr, NULL);
 	return ERR_PTR(err);
 }
 
@@ -1669,7 +1647,7 @@ struct ib_mr *mlx5_ib_reg_user_mr_dmabuf(struct ib_pd *pd, u64 offset,
  * and any DMA inprogress will be completed. Failure of this function
  * indicates the HW has failed catastrophically.
  */
-int mlx5_mr_cache_invalidate(struct mlx5_ib_mr *mr)
+static int mlx5_mr_cache_invalidate(struct mlx5_ib_mr *mr)
 {
 	struct mlx5_umr_wr umrwr = {};
 
@@ -1941,69 +1919,82 @@ mlx5_free_priv_descs(struct mlx5_ib_mr *mr)
 	}
 }
 
-static void clean_mr(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr)
+int mlx5_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 {
-	if (mr->ibmr.type == IB_MR_TYPE_INTEGRITY) {
+	struct mlx5_ib_mr *mr = to_mmr(ibmr);
+	struct mlx5_ib_dev *dev = to_mdev(ibmr->device);
+	int rc;
+
+	/*
+	 * Any async use of the mr must hold the refcount, once the refcount
+	 * goes to zero no other thread, such as ODP page faults, prefetch, any
+	 * UMR activity, etc can touch the mkey. Thus it is safe to destroy it.
+	 */
+	if (IS_ENABLED(CONFIG_INFINIBAND_ON_DEMAND_PAGING) &&
+	    refcount_read(&mr->mmkey.usecount) != 0 &&
+	    xa_erase(&mr_to_mdev(mr)->odp_mkeys, mlx5_base_mkey(mr->mmkey.key)))
+		mlx5r_deref_wait_odp_mkey(&mr->mmkey);
+
+	if (ibmr->type == IB_MR_TYPE_INTEGRITY) {
+		xa_cmpxchg(&dev->sig_mrs, mlx5_base_mkey(mr->mmkey.key), ibmr,
+			   NULL, GFP_KERNEL);
+
+		if (mr->mtt_mr) {
+			rc = mlx5_ib_dereg_mr(&mr->mtt_mr->ibmr, NULL);
+			if (rc)
+				return rc;
+			mr->mtt_mr = NULL;
+		}
+		if (mr->klm_mr) {
+			mlx5_ib_dereg_mr(&mr->klm_mr->ibmr, NULL);
+			if (rc)
+				return rc;
+			mr->klm_mr = NULL;
+		}
+
 		if (mlx5_core_destroy_psv(dev->mdev,
 					  mr->sig->psv_memory.psv_idx))
 			mlx5_ib_warn(dev, "failed to destroy mem psv %d\n",
 				     mr->sig->psv_memory.psv_idx);
-		if (mlx5_core_destroy_psv(dev->mdev,
-					  mr->sig->psv_wire.psv_idx))
+		if (mlx5_core_destroy_psv(dev->mdev, mr->sig->psv_wire.psv_idx))
 			mlx5_ib_warn(dev, "failed to destroy wire psv %d\n",
 				     mr->sig->psv_wire.psv_idx);
-		xa_erase(&dev->sig_mrs, mlx5_base_mkey(mr->mmkey.key));
 		kfree(mr->sig);
 		mr->sig = NULL;
 	}
 
+	/* Stop DMA */
+	if (mr->cache_ent) {
+		if (mlx5_mr_cache_invalidate(mr)) {
+			spin_lock_irq(&mr->cache_ent->lock);
+			mr->cache_ent->total_mrs--;
+			spin_unlock_irq(&mr->cache_ent->lock);
+			mr->cache_ent = NULL;
+		}
+	}
 	if (!mr->cache_ent) {
-		destroy_mkey(dev, mr);
-		mlx5_free_priv_descs(mr);
+		rc = destroy_mkey(to_mdev(mr->ibmr.device), mr);
+		if (rc)
+			return rc;
 	}
-}
-
-static void dereg_mr(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr)
-{
-	struct ib_umem *umem = mr->umem;
 
-	/* Stop all DMA */
-	if (is_odp_mr(mr))
-		mlx5_ib_fence_odp_mr(mr);
-	else if (is_dmabuf_mr(mr))
-		mlx5_ib_fence_dmabuf_mr(mr);
-	else
-		clean_mr(dev, mr);
+	if (mr->umem) {
+		bool is_odp = is_odp_mr(mr);
 
-	if (umem) {
-		if (!is_odp_mr(mr))
-			atomic_sub(ib_umem_num_pages(umem),
+		if (!is_odp)
+			atomic_sub(ib_umem_num_pages(mr->umem),
 				   &dev->mdev->priv.reg_pages);
-		ib_umem_release(umem);
+		ib_umem_release(mr->umem);
+		if (is_odp)
+			mlx5_ib_free_odp_mr(mr);
 	}
 
-	if (mr->cache_ent)
+	if (mr->cache_ent) {
 		mlx5_mr_cache_free(dev, mr);
-	else
+	} else {
+		mlx5_free_priv_descs(mr);
 		kfree(mr);
-}
-
-int mlx5_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
-{
-	struct mlx5_ib_mr *mmr = to_mmr(ibmr);
-
-	if (ibmr->type == IB_MR_TYPE_INTEGRITY) {
-		dereg_mr(to_mdev(mmr->mtt_mr->ibmr.device), mmr->mtt_mr);
-		dereg_mr(to_mdev(mmr->klm_mr->ibmr.device), mmr->klm_mr);
-	}
-
-	if (is_odp_mr(mmr) && to_ib_umem_odp(mmr->umem)->is_implicit_odp) {
-		mlx5_ib_free_implicit_mr(mmr);
-		return 0;
 	}
-
-	dereg_mr(to_mdev(ibmr->device), mmr);
-
 	return 0;
 }
 
@@ -2175,10 +2166,10 @@ static int mlx5_alloc_integrity_descs(struct ib_pd *pd, struct mlx5_ib_mr *mr,
 	destroy_mkey(dev, mr);
 	mlx5_free_priv_descs(mr);
 err_free_mtt_mr:
-	dereg_mr(to_mdev(mr->mtt_mr->ibmr.device), mr->mtt_mr);
+	mlx5_ib_dereg_mr(&mr->mtt_mr->ibmr, NULL);
 	mr->mtt_mr = NULL;
 err_free_klm_mr:
-	dereg_mr(to_mdev(mr->klm_mr->ibmr.device), mr->klm_mr);
+	mlx5_ib_dereg_mr(&mr->klm_mr->ibmr, NULL);
 	mr->klm_mr = NULL;
 err_destroy_psv:
 	if (mlx5_core_destroy_psv(dev->mdev, mr->sig->psv_memory.psv_idx))
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index d98755e78362..3008d1539ad4 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -181,63 +181,29 @@ void mlx5_odp_populate_xlt(void *xlt, size_t idx, size_t nentries,
 	}
 }
 
-static void dma_fence_odp_mr(struct mlx5_ib_mr *mr)
-{
-	struct ib_umem_odp *odp = to_ib_umem_odp(mr->umem);
-
-	/* Ensure mlx5_ib_invalidate_range() will not touch the MR any more */
-	mutex_lock(&odp->umem_mutex);
-	if (odp->npages) {
-		mlx5_mr_cache_invalidate(mr);
-		ib_umem_odp_unmap_dma_pages(odp, ib_umem_start(odp),
-					    ib_umem_end(odp));
-		WARN_ON(odp->npages);
-	}
-	odp->private = NULL;
-	mutex_unlock(&odp->umem_mutex);
-
-	if (!mr->cache_ent) {
-		mlx5_core_destroy_mkey(mr_to_mdev(mr)->mdev, &mr->mmkey);
-		WARN_ON(mr->descs);
-	}
-}
-
 /*
  * This must be called after the mr has been removed from implicit_children.
  * NOTE: The MR does not necessarily have to be
  * empty here, parallel page faults could have raced with the free process and
  * added pages to it.
  */
-static void free_implicit_child_mr(struct mlx5_ib_mr *mr, bool need_imr_xlt)
+static void free_implicit_child_mr_work(struct work_struct *work)
 {
+	struct mlx5_ib_mr *mr =
+		container_of(work, struct mlx5_ib_mr, odp_destroy.work);
 	struct mlx5_ib_mr *imr = mr->parent;
 	struct ib_umem_odp *odp_imr = to_ib_umem_odp(imr->umem);
 	struct ib_umem_odp *odp = to_ib_umem_odp(mr->umem);
-	unsigned long idx = ib_umem_start(odp) >> MLX5_IMR_MTT_SHIFT;
 
 	mlx5r_deref_wait_odp_mkey(&mr->mmkey);
 
-	if (need_imr_xlt) {
-		mutex_lock(&odp_imr->umem_mutex);
-		mlx5_ib_update_xlt(mr->parent, idx, 1, 0,
-				   MLX5_IB_UPD_XLT_INDIRECT |
-				   MLX5_IB_UPD_XLT_ATOMIC);
-		mutex_unlock(&odp_imr->umem_mutex);
-	}
-
-	dma_fence_odp_mr(mr);
-
-	mlx5_mr_cache_free(mr_to_mdev(mr), mr);
-	ib_umem_odp_release(odp);
-}
-
-static void free_implicit_child_mr_work(struct work_struct *work)
-{
-	struct mlx5_ib_mr *mr =
-		container_of(work, struct mlx5_ib_mr, odp_destroy.work);
-	struct mlx5_ib_mr *imr = mr->parent;
+	mutex_lock(&odp_imr->umem_mutex);
+	mlx5_ib_update_xlt(mr->parent, ib_umem_start(odp) >> MLX5_IMR_MTT_SHIFT,
+			   1, 0,
+			   MLX5_IB_UPD_XLT_INDIRECT | MLX5_IB_UPD_XLT_ATOMIC);
+	mutex_unlock(&odp_imr->umem_mutex);
+	mlx5_ib_dereg_mr(&mr->ibmr, NULL);
 
-	free_implicit_child_mr(mr, true);
 	mlx5r_deref_odp_mkey(&imr->mmkey);
 }
 
@@ -454,8 +420,10 @@ static struct mlx5_ib_mr *implicit_get_child_mr(struct mlx5_ib_mr *imr,
 
 	ret = mr = mlx5_mr_cache_alloc(
 		mr_to_mdev(imr), MLX5_IMR_MTT_CACHE_ENTRY, imr->access_flags);
-	if (IS_ERR(mr))
-		goto out_umem;
+	if (IS_ERR(mr)) {
+		ib_umem_odp_release(odp);
+		return mr;
+	}
 
 	mr->ibmr.pd = imr->ibmr.pd;
 	mr->ibmr.device = &mr_to_mdev(imr)->ib_dev;
@@ -505,9 +473,7 @@ static struct mlx5_ib_mr *implicit_get_child_mr(struct mlx5_ib_mr *imr,
 out_lock:
 	xa_unlock(&imr->implicit_children);
 out_mr:
-	mlx5_mr_cache_free(mr_to_mdev(imr), mr);
-out_umem:
-	ib_umem_odp_release(odp);
+	mlx5_ib_dereg_mr(&mr->ibmr, NULL);
 	return ret;
 }
 
@@ -530,8 +496,8 @@ struct mlx5_ib_mr *mlx5_ib_alloc_implicit_mr(struct mlx5_ib_pd *pd,
 
 	imr = mlx5_mr_cache_alloc(dev, MLX5_IMR_KSM_CACHE_ENTRY, access_flags);
 	if (IS_ERR(imr)) {
-		err = PTR_ERR(imr);
-		goto out_umem;
+		ib_umem_odp_release(umem_odp);
+		return imr;
 	}
 
 	imr->ibmr.pd = &pd->ibpd;
@@ -561,93 +527,22 @@ struct mlx5_ib_mr *mlx5_ib_alloc_implicit_mr(struct mlx5_ib_pd *pd,
 	return imr;
 out_mr:
 	mlx5_ib_err(dev, "Failed to register MKEY %d\n", err);
-	mlx5_mr_cache_free(dev, imr);
-out_umem:
-	ib_umem_odp_release(umem_odp);
+	mlx5_ib_dereg_mr(&imr->ibmr, NULL);
 	return ERR_PTR(err);
 }
 
-void mlx5_ib_free_implicit_mr(struct mlx5_ib_mr *imr)
+void mlx5_ib_free_odp_mr(struct mlx5_ib_mr *mr)
 {
-	struct ib_umem_odp *odp_imr = to_ib_umem_odp(imr->umem);
-	struct mlx5_ib_dev *dev = mr_to_mdev(imr);
 	struct mlx5_ib_mr *mtt;
 	unsigned long idx;
 
-	xa_erase(&dev->odp_mkeys, mlx5_base_mkey(imr->mmkey.key));
 	/*
-	 * All work on the prefetch list must be completed, xa_erase() prevented
-	 * new work from being created.
+	 * If this is an implicit MR it is already invalidated so we can just
+	 * delete the children mkeys.
 	 */
-	mlx5r_deref_wait_odp_mkey(&imr->mmkey);
-	/*
-	 * At this point it is forbidden for any other thread to enter
-	 * pagefault_mr() on this imr. It is already forbidden to call
-	 * pagefault_mr() on an implicit child. Due to this additions to
-	 * implicit_children are prevented.
-	 * In addition, any new call to destroy_unused_implicit_child_mr()
-	 * may return immediately.
-	 */
-
-	/*
-	 * Fence the imr before we destroy the children. This allows us to
-	 * skip updating the XLT of the imr during destroy of the child mkey
-	 * the imr points to.
-	 */
-	mlx5_mr_cache_invalidate(imr);
-
-	xa_for_each(&imr->implicit_children, idx, mtt) {
-		xa_erase(&imr->implicit_children, idx);
-		free_implicit_child_mr(mtt, false);
-	}
-
-	mlx5_mr_cache_free(dev, imr);
-	ib_umem_odp_release(odp_imr);
-}
-
-/**
- * mlx5_ib_fence_odp_mr - Stop all access to the ODP MR
- * @mr: to fence
- *
- * On return no parallel threads will be touching this MR and no DMA will be
- * active.
- */
-void mlx5_ib_fence_odp_mr(struct mlx5_ib_mr *mr)
-{
-	/* Prevent new page faults and prefetch requests from succeeding */
-	xa_erase(&mr_to_mdev(mr)->odp_mkeys, mlx5_base_mkey(mr->mmkey.key));
-
-	/* Wait for all running page-fault handlers to finish. */
-	mlx5r_deref_wait_odp_mkey(&mr->mmkey);
-
-	dma_fence_odp_mr(mr);
-}
-
-/**
- * mlx5_ib_fence_dmabuf_mr - Stop all access to the dmabuf MR
- * @mr: to fence
- *
- * On return no parallel threads will be touching this MR and no DMA will be
- * active.
- */
-void mlx5_ib_fence_dmabuf_mr(struct mlx5_ib_mr *mr)
-{
-	struct ib_umem_dmabuf *umem_dmabuf = to_ib_umem_dmabuf(mr->umem);
-
-	/* Prevent new page faults and prefetch requests from succeeding */
-	xa_erase(&mr_to_mdev(mr)->odp_mkeys, mlx5_base_mkey(mr->mmkey.key));
-
-	mlx5r_deref_wait_odp_mkey(&mr->mmkey);
-
-	dma_resv_lock(umem_dmabuf->attach->dmabuf->resv, NULL);
-	mlx5_mr_cache_invalidate(mr);
-	umem_dmabuf->private = NULL;
-	ib_umem_dmabuf_unmap_pages(umem_dmabuf);
-	dma_resv_unlock(umem_dmabuf->attach->dmabuf->resv);
-
-	if (!mr->cache_ent) {
-		mlx5_core_destroy_mkey(mr_to_mdev(mr)->mdev, &mr->mmkey);
-		WARN_ON(mr->descs);
+	xa_for_each(&mr->implicit_children, idx, mtt) {
+		xa_erase(&mr->implicit_children, idx);
+		mlx5_ib_dereg_mr(&mtt->ibmr, NULL);
 	}
 }
 
-- 
2.29.2

