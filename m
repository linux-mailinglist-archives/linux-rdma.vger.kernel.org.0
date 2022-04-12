Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA0834FD63A
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Apr 2022 12:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352584AbiDLJ56 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Apr 2022 05:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359476AbiDLHnE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 Apr 2022 03:43:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0CB1401C
        for <linux-rdma@vger.kernel.org>; Tue, 12 Apr 2022 00:25:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 166A2B81B58
        for <linux-rdma@vger.kernel.org>; Tue, 12 Apr 2022 07:25:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4157AC385A5;
        Tue, 12 Apr 2022 07:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649748300;
        bh=ihN1fbPoqGSDrMxR1NP3cSEjLgtNElSfYSp55crxqec=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rabET+a0OC+MwsFPBuEKCRUXad0EBlOymSWCZXd3AUN80rFa7Qm0RlljJ7WD+QNLI
         lsDnLc+Zg3cSO7WBt/rahp1Lm9AJfFqEQIHk6oEFPazQRoPLU/p6cXflQ1pvHirM0y
         j56FxlUtk5PmSu6jDVVxsZqfSegzbJlh2GgR5o6dnHpIFuppv6A8wby2AlnGOqdATO
         SOWFjGkQCV8x/tJcRXeY5LZbg4ClGJE5rnmLN39geoLUGVmT3P4/3OCR1ekVzZXpgD
         hnZugJSKm4TeUBu+WLLC5AkDvz3cIVUmPgpIK9av9NgoExck/oul96bKIbGC+GrVDp
         OL90eRqZPimJA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Aharon Landau <aharonl@nvidia.com>, linux-rdma@vger.kernel.org,
        Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH rdma-next 11/12] RDMA/mlx5: Use mlx5_umr_post_send_wait() to update xlt
Date:   Tue, 12 Apr 2022 10:24:06 +0300
Message-Id: <55a4972f156aba3592a2fc9bcb33e2059acf295f.1649747695.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1649747695.git.leonro@nvidia.com>
References: <cover.1649747695.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Aharon Landau <aharonl@nvidia.com>

Move mlx5_ib_update_mr_pas logic to umr.c, and use mlx5_umr_post_send_wait()
instead of mlx5_ib_post_send_wait().

Since it is the last use of mlx5_ib_post_send_wait(), remove it.

Signed-off-by: Aharon Landau <aharonl@nvidia.com>
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h |   2 -
 drivers/infiniband/hw/mlx5/mr.c      | 171 ---------------------------
 drivers/infiniband/hw/mlx5/odp.c     |  54 ++++-----
 drivers/infiniband/hw/mlx5/umr.c     |  93 ++++++++++++++-
 drivers/infiniband/hw/mlx5/umr.h     |   7 +-
 5 files changed, 117 insertions(+), 210 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index ea4d5519df8c..10e60c9281b4 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1287,8 +1287,6 @@ int mlx5_ib_advise_mr(struct ib_pd *pd,
 		      struct uverbs_attr_bundle *attrs);
 int mlx5_ib_alloc_mw(struct ib_mw *mw, struct ib_udata *udata);
 int mlx5_ib_dealloc_mw(struct ib_mw *mw);
-int mlx5_ib_update_xlt(struct mlx5_ib_mr *mr, u64 idx, int npages,
-		       int page_shift, int flags);
 struct mlx5_ib_mr *mlx5_ib_alloc_implicit_mr(struct mlx5_ib_pd *pd,
 					     int access_flags);
 void mlx5_ib_free_implicit_mr(struct mlx5_ib_mr *mr);
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index df79fd5be5f2..9bfbd8d199ee 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -122,11 +122,6 @@ mlx5_ib_create_mkey_cb(struct mlx5_ib_dev *dev,
 static int mr_cache_max_order(struct mlx5_ib_dev *dev);
 static void queue_adjust_cache_locked(struct mlx5_cache_ent *ent);
 
-static bool umr_can_use_indirect_mkey(struct mlx5_ib_dev *dev)
-{
-	return !MLX5_CAP_GEN(dev->mdev, umr_indirect_mkey_disabled);
-}
-
 static int destroy_mkey(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr)
 {
 	WARN_ON(xa_load(&dev->odp_mkeys, mlx5_base_mkey(mr->mmkey.key)));
@@ -839,49 +834,6 @@ static int mr_cache_max_order(struct mlx5_ib_dev *dev)
 	return MLX5_MAX_UMR_SHIFT;
 }
 
-static void mlx5_ib_umr_done(struct ib_cq *cq, struct ib_wc *wc)
-{
-	struct mlx5_ib_umr_context *context =
-		container_of(wc->wr_cqe, struct mlx5_ib_umr_context, cqe);
-
-	context->status = wc->status;
-	complete(&context->done);
-}
-
-static inline void mlx5_ib_init_umr_context(struct mlx5_ib_umr_context *context)
-{
-	context->cqe.done = mlx5_ib_umr_done;
-	context->status = -1;
-	init_completion(&context->done);
-}
-
-static int mlx5_ib_post_send_wait(struct mlx5_ib_dev *dev,
-				  struct mlx5_umr_wr *umrwr)
-{
-	struct umr_common *umrc = &dev->umrc;
-	const struct ib_send_wr *bad;
-	int err;
-	struct mlx5_ib_umr_context umr_context;
-
-	mlx5_ib_init_umr_context(&umr_context);
-	umrwr->wr.wr_cqe = &umr_context.cqe;
-
-	down(&umrc->sem);
-	err = ib_post_send(umrc->qp, &umrwr->wr, &bad);
-	if (err) {
-		mlx5_ib_warn(dev, "UMR post send failed, err %d\n", err);
-	} else {
-		wait_for_completion(&umr_context.done);
-		if (umr_context.status != IB_WC_SUCCESS) {
-			mlx5_ib_warn(dev, "reg umr failed (%u)\n",
-				     umr_context.status);
-			err = -EFAULT;
-		}
-	}
-	up(&umrc->sem);
-	return err;
-}
-
 static struct mlx5_cache_ent *mr_cache_ent_from_order(struct mlx5_ib_dev *dev,
 						      unsigned int order)
 {
@@ -959,129 +911,6 @@ static struct mlx5_ib_mr *alloc_cacheable_mr(struct ib_pd *pd,
 	return mr;
 }
 
-/*
- * Create a MLX5_IB_SEND_UMR_UPDATE_XLT work request and XLT buffer ready for
- * submission.
- */
-static void *mlx5_ib_create_xlt_wr(struct mlx5_ib_mr *mr,
-				   struct mlx5_umr_wr *wr, struct ib_sge *sg,
-				   size_t nents, size_t ent_size,
-				   unsigned int flags)
-{
-	struct mlx5_ib_dev *dev = mr_to_mdev(mr);
-	void *xlt;
-
-	xlt = mlx5r_umr_create_xlt(dev, sg, nents, ent_size, flags);
-
-	memset(wr, 0, sizeof(*wr));
-	wr->wr.send_flags = MLX5_IB_SEND_UMR_UPDATE_XLT;
-	if (!(flags & MLX5_IB_UPD_XLT_ENABLE))
-		wr->wr.send_flags |= MLX5_IB_SEND_UMR_FAIL_IF_FREE;
-	wr->wr.sg_list = sg;
-	wr->wr.num_sge = 1;
-	wr->wr.opcode = MLX5_IB_WR_UMR;
-	wr->pd = mr->ibmr.pd;
-	wr->mkey = mr->mmkey.key;
-	wr->length = mr->ibmr.length;
-	wr->virt_addr = mr->ibmr.iova;
-	wr->access_flags = mr->access_flags;
-	wr->page_shift = mr->page_shift;
-	wr->xlt_size = sg->length;
-	return xlt;
-}
-
-static unsigned int xlt_wr_final_send_flags(unsigned int flags)
-{
-	unsigned int res = 0;
-
-	if (flags & MLX5_IB_UPD_XLT_ENABLE)
-		res |= MLX5_IB_SEND_UMR_ENABLE_MR |
-		       MLX5_IB_SEND_UMR_UPDATE_PD_ACCESS |
-		       MLX5_IB_SEND_UMR_UPDATE_TRANSLATION;
-	if (flags & MLX5_IB_UPD_XLT_PD || flags & MLX5_IB_UPD_XLT_ACCESS)
-		res |= MLX5_IB_SEND_UMR_UPDATE_PD_ACCESS;
-	if (flags & MLX5_IB_UPD_XLT_ADDR)
-		res |= MLX5_IB_SEND_UMR_UPDATE_TRANSLATION;
-	return res;
-}
-
-int mlx5_ib_update_xlt(struct mlx5_ib_mr *mr, u64 idx, int npages,
-		       int page_shift, int flags)
-{
-	struct mlx5_ib_dev *dev = mr_to_mdev(mr);
-	struct device *ddev = &dev->mdev->pdev->dev;
-	void *xlt;
-	struct mlx5_umr_wr wr;
-	struct ib_sge sg;
-	int err = 0;
-	int desc_size = (flags & MLX5_IB_UPD_XLT_INDIRECT)
-			       ? sizeof(struct mlx5_klm)
-			       : sizeof(struct mlx5_mtt);
-	const int page_align = MLX5_UMR_MTT_ALIGNMENT / desc_size;
-	const int page_mask = page_align - 1;
-	size_t pages_mapped = 0;
-	size_t pages_to_map = 0;
-	size_t pages_iter;
-	size_t size_to_map = 0;
-	size_t orig_sg_length;
-
-	if ((flags & MLX5_IB_UPD_XLT_INDIRECT) &&
-	    !umr_can_use_indirect_mkey(dev))
-		return -EPERM;
-
-	if (WARN_ON(!mr->umem->is_odp))
-		return -EINVAL;
-
-	/* UMR copies MTTs in units of MLX5_UMR_MTT_ALIGNMENT bytes,
-	 * so we need to align the offset and length accordingly
-	 */
-	if (idx & page_mask) {
-		npages += idx & page_mask;
-		idx &= ~page_mask;
-	}
-	pages_to_map = ALIGN(npages, page_align);
-
-	xlt = mlx5_ib_create_xlt_wr(mr, &wr, &sg, npages, desc_size, flags);
-	if (!xlt)
-		return -ENOMEM;
-	pages_iter = sg.length / desc_size;
-	orig_sg_length = sg.length;
-
-	if (!(flags & MLX5_IB_UPD_XLT_INDIRECT)) {
-		struct ib_umem_odp *odp = to_ib_umem_odp(mr->umem);
-		size_t max_pages = ib_umem_odp_num_pages(odp) - idx;
-
-		pages_to_map = min_t(size_t, pages_to_map, max_pages);
-	}
-
-	wr.page_shift = page_shift;
-
-	for (pages_mapped = 0;
-	     pages_mapped < pages_to_map && !err;
-	     pages_mapped += pages_iter, idx += pages_iter) {
-		npages = min_t(int, pages_iter, pages_to_map - pages_mapped);
-		size_to_map = npages * desc_size;
-		dma_sync_single_for_cpu(ddev, sg.addr, sg.length,
-					DMA_TO_DEVICE);
-		mlx5_odp_populate_xlt(xlt, idx, npages, mr, flags);
-		dma_sync_single_for_device(ddev, sg.addr, sg.length,
-					   DMA_TO_DEVICE);
-
-		sg.length = ALIGN(size_to_map, MLX5_UMR_MTT_ALIGNMENT);
-
-		if (pages_mapped + pages_iter >= pages_to_map)
-			wr.wr.send_flags |= xlt_wr_final_send_flags(flags);
-
-		wr.offset = idx * desc_size;
-		wr.xlt_size = sg.length;
-
-		err = mlx5_ib_post_send_wait(dev, &wr);
-	}
-	sg.length = orig_sg_length;
-	mlx5r_umr_unmap_free_xlt(dev, xlt, &sg);
-	return err;
-}
-
 /*
  * If ibmr is NULL it will be allocated by reg_create.
  * Else, the given ibmr will be used.
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index c00e70e74d94..66ac7bdc59f6 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -118,7 +118,7 @@ static void populate_klm(struct mlx5_klm *pklm, size_t idx, size_t nentries,
 	 *
 	 *    xa_store()
 	 *    mutex_lock(umem_mutex)
-	 *     mlx5_ib_update_xlt()
+	 *     mlx5r_umr_update_xlt()
 	 *    mutex_unlock(umem_mutex)
 	 *    destroy lkey
 	 *
@@ -199,9 +199,9 @@ static void free_implicit_child_mr_work(struct work_struct *work)
 	mlx5r_deref_wait_odp_mkey(&mr->mmkey);
 
 	mutex_lock(&odp_imr->umem_mutex);
-	mlx5_ib_update_xlt(mr->parent, ib_umem_start(odp) >> MLX5_IMR_MTT_SHIFT,
-			   1, 0,
-			   MLX5_IB_UPD_XLT_INDIRECT | MLX5_IB_UPD_XLT_ATOMIC);
+	mlx5r_umr_update_xlt(mr->parent,
+			     ib_umem_start(odp) >> MLX5_IMR_MTT_SHIFT, 1, 0,
+			     MLX5_IB_UPD_XLT_INDIRECT | MLX5_IB_UPD_XLT_ATOMIC);
 	mutex_unlock(&odp_imr->umem_mutex);
 	mlx5_ib_dereg_mr(&mr->ibmr, NULL);
 
@@ -283,19 +283,19 @@ static bool mlx5_ib_invalidate_range(struct mmu_interval_notifier *mni,
 			u64 umr_offset = idx & umr_block_mask;
 
 			if (in_block && umr_offset == 0) {
-				mlx5_ib_update_xlt(mr, blk_start_idx,
-						   idx - blk_start_idx, 0,
-						   MLX5_IB_UPD_XLT_ZAP |
-						   MLX5_IB_UPD_XLT_ATOMIC);
+				mlx5r_umr_update_xlt(mr, blk_start_idx,
+						     idx - blk_start_idx, 0,
+						     MLX5_IB_UPD_XLT_ZAP |
+						     MLX5_IB_UPD_XLT_ATOMIC);
 				in_block = 0;
 			}
 		}
 	}
 	if (in_block)
-		mlx5_ib_update_xlt(mr, blk_start_idx,
-				   idx - blk_start_idx + 1, 0,
-				   MLX5_IB_UPD_XLT_ZAP |
-				   MLX5_IB_UPD_XLT_ATOMIC);
+		mlx5r_umr_update_xlt(mr, blk_start_idx,
+				     idx - blk_start_idx + 1, 0,
+				     MLX5_IB_UPD_XLT_ZAP |
+				     MLX5_IB_UPD_XLT_ATOMIC);
 
 	mlx5_update_odp_stats(mr, invalidations, invalidations);
 
@@ -442,11 +442,11 @@ static struct mlx5_ib_mr *implicit_get_child_mr(struct mlx5_ib_mr *imr,
 	 */
 	refcount_set(&mr->mmkey.usecount, 2);
 
-	err = mlx5_ib_update_xlt(mr, 0,
-				 MLX5_IMR_MTT_ENTRIES,
-				 PAGE_SHIFT,
-				 MLX5_IB_UPD_XLT_ZAP |
-				 MLX5_IB_UPD_XLT_ENABLE);
+	err = mlx5r_umr_update_xlt(mr, 0,
+				   MLX5_IMR_MTT_ENTRIES,
+				   PAGE_SHIFT,
+				   MLX5_IB_UPD_XLT_ZAP |
+				   MLX5_IB_UPD_XLT_ENABLE);
 	if (err) {
 		ret = ERR_PTR(err);
 		goto out_mr;
@@ -513,12 +513,12 @@ struct mlx5_ib_mr *mlx5_ib_alloc_implicit_mr(struct mlx5_ib_pd *pd,
 	imr->is_odp_implicit = true;
 	xa_init(&imr->implicit_children);
 
-	err = mlx5_ib_update_xlt(imr, 0,
-				 mlx5_imr_ksm_entries,
-				 MLX5_KSM_PAGE_SHIFT,
-				 MLX5_IB_UPD_XLT_INDIRECT |
-				 MLX5_IB_UPD_XLT_ZAP |
-				 MLX5_IB_UPD_XLT_ENABLE);
+	err = mlx5r_umr_update_xlt(imr, 0,
+				   mlx5_imr_ksm_entries,
+				   MLX5_KSM_PAGE_SHIFT,
+				   MLX5_IB_UPD_XLT_INDIRECT |
+				   MLX5_IB_UPD_XLT_ZAP |
+				   MLX5_IB_UPD_XLT_ENABLE);
 	if (err)
 		goto out_mr;
 
@@ -581,7 +581,7 @@ static int pagefault_real_mr(struct mlx5_ib_mr *mr, struct ib_umem_odp *odp,
 	 * No need to check whether the MTTs really belong to this MR, since
 	 * ib_umem_odp_map_dma_and_lock already checks this.
 	 */
-	ret = mlx5_ib_update_xlt(mr, start_idx, np, page_shift, xlt_flags);
+	ret = mlx5r_umr_update_xlt(mr, start_idx, np, page_shift, xlt_flags);
 	mutex_unlock(&odp->umem_mutex);
 
 	if (ret < 0) {
@@ -679,9 +679,9 @@ static int pagefault_implicit_mr(struct mlx5_ib_mr *imr,
 	 * next pagefault handler will see the new information.
 	 */
 	mutex_lock(&odp_imr->umem_mutex);
-	err = mlx5_ib_update_xlt(imr, upd_start_idx, upd_len, 0,
-				 MLX5_IB_UPD_XLT_INDIRECT |
-					 MLX5_IB_UPD_XLT_ATOMIC);
+	err = mlx5r_umr_update_xlt(imr, upd_start_idx, upd_len, 0,
+				   MLX5_IB_UPD_XLT_INDIRECT |
+					  MLX5_IB_UPD_XLT_ATOMIC);
 	mutex_unlock(&odp_imr->umem_mutex);
 	if (err) {
 		mlx5_ib_err(mr_to_mdev(imr), "Failed to update PAS\n");
diff --git a/drivers/infiniband/hw/mlx5/umr.c b/drivers/infiniband/hw/mlx5/umr.c
index b56e3569c677..ad9e31107901 100644
--- a/drivers/infiniband/hw/mlx5/umr.c
+++ b/drivers/infiniband/hw/mlx5/umr.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /* Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES. */
 
+#include <rdma/ib_umem_odp.h>
 #include "mlx5_ib.h"
 #include "umr.h"
 #include "wr.h"
@@ -455,7 +456,7 @@ static void *mlx5r_umr_alloc_xlt(size_t *nents, size_t ent_size, gfp_t gfp_mask)
 	return xlt_emergency_page;
 }
 
-void mlx5r_umr_free_xlt(void *xlt, size_t length)
+static void mlx5r_umr_free_xlt(void *xlt, size_t length)
 {
 	if (xlt == xlt_emergency_page) {
 		mutex_unlock(&xlt_emergency_page_mutex);
@@ -465,8 +466,8 @@ void mlx5r_umr_free_xlt(void *xlt, size_t length)
 	free_pages((unsigned long)xlt, get_order(length));
 }
 
-void mlx5r_umr_unmap_free_xlt(struct mlx5_ib_dev *dev, void *xlt,
-			     struct ib_sge *sg)
+static void mlx5r_umr_unmap_free_xlt(struct mlx5_ib_dev *dev, void *xlt,
+				     struct ib_sge *sg)
 {
 	struct device *ddev = &dev->mdev->pdev->dev;
 
@@ -477,8 +478,9 @@ void mlx5r_umr_unmap_free_xlt(struct mlx5_ib_dev *dev, void *xlt,
 /*
  * Create an XLT buffer ready for submission.
  */
-void *mlx5r_umr_create_xlt(struct mlx5_ib_dev *dev, struct ib_sge *sg,
-			  size_t nents, size_t ent_size, unsigned int flags)
+static void *mlx5r_umr_create_xlt(struct mlx5_ib_dev *dev, struct ib_sge *sg,
+				  size_t nents, size_t ent_size,
+				  unsigned int flags)
 {
 	struct device *ddev = &dev->mdev->pdev->dev;
 	dma_addr_t dma;
@@ -658,3 +660,84 @@ int mlx5r_umr_update_mr_pas(struct mlx5_ib_mr *mr, unsigned int flags)
 	mlx5r_umr_unmap_free_xlt(dev, mtt, &sg);
 	return err;
 }
+
+static bool umr_can_use_indirect_mkey(struct mlx5_ib_dev *dev)
+{
+	return !MLX5_CAP_GEN(dev->mdev, umr_indirect_mkey_disabled);
+}
+
+int mlx5r_umr_update_xlt(struct mlx5_ib_mr *mr, u64 idx, int npages,
+			 int page_shift, int flags)
+{
+	int desc_size = (flags & MLX5_IB_UPD_XLT_INDIRECT)
+			       ? sizeof(struct mlx5_klm)
+			       : sizeof(struct mlx5_mtt);
+	const int page_align = MLX5_UMR_MTT_ALIGNMENT / desc_size;
+	struct mlx5_ib_dev *dev = mr_to_mdev(mr);
+	struct device *ddev = &dev->mdev->pdev->dev;
+	const int page_mask = page_align - 1;
+	struct mlx5r_umr_wqe wqe = {};
+	size_t pages_mapped = 0;
+	size_t pages_to_map = 0;
+	size_t size_to_map = 0;
+	size_t orig_sg_length;
+	size_t pages_iter;
+	struct ib_sge sg;
+	int err = 0;
+	void *xlt;
+
+	if ((flags & MLX5_IB_UPD_XLT_INDIRECT) &&
+	    !umr_can_use_indirect_mkey(dev))
+		return -EPERM;
+
+	if (WARN_ON(!mr->umem->is_odp))
+		return -EINVAL;
+
+	/* UMR copies MTTs in units of MLX5_UMR_MTT_ALIGNMENT bytes,
+	 * so we need to align the offset and length accordingly
+	 */
+	if (idx & page_mask) {
+		npages += idx & page_mask;
+		idx &= ~page_mask;
+	}
+	pages_to_map = ALIGN(npages, page_align);
+
+	xlt = mlx5r_umr_create_xlt(dev, &sg, npages, desc_size, flags);
+	if (!xlt)
+		return -ENOMEM;
+
+	pages_iter = sg.length / desc_size;
+	orig_sg_length = sg.length;
+
+	if (!(flags & MLX5_IB_UPD_XLT_INDIRECT)) {
+		struct ib_umem_odp *odp = to_ib_umem_odp(mr->umem);
+		size_t max_pages = ib_umem_odp_num_pages(odp) - idx;
+
+		pages_to_map = min_t(size_t, pages_to_map, max_pages);
+	}
+
+	mlx5r_umr_set_update_xlt_ctrl_seg(&wqe.ctrl_seg, flags, &sg);
+	mlx5r_umr_set_update_xlt_mkey_seg(dev, &wqe.mkey_seg, mr, page_shift);
+	mlx5r_umr_set_update_xlt_data_seg(&wqe.data_seg, &sg);
+
+	for (pages_mapped = 0;
+	     pages_mapped < pages_to_map && !err;
+	     pages_mapped += pages_iter, idx += pages_iter) {
+		npages = min_t(int, pages_iter, pages_to_map - pages_mapped);
+		size_to_map = npages * desc_size;
+		dma_sync_single_for_cpu(ddev, sg.addr, sg.length,
+					DMA_TO_DEVICE);
+		mlx5_odp_populate_xlt(xlt, idx, npages, mr, flags);
+		dma_sync_single_for_device(ddev, sg.addr, sg.length,
+					   DMA_TO_DEVICE);
+		sg.length = ALIGN(size_to_map, MLX5_UMR_MTT_ALIGNMENT);
+
+		if (pages_mapped + pages_iter >= pages_to_map)
+			mlx5r_umr_final_update_xlt(dev, &wqe, mr, &sg, flags);
+		mlx5r_umr_update_offset(&wqe.ctrl_seg, idx * desc_size);
+		err = mlx5r_umr_post_send_wait(dev, mr->mmkey.key, &wqe, true);
+	}
+	sg.length = orig_sg_length;
+	mlx5r_umr_unmap_free_xlt(dev, xlt, &sg);
+	return err;
+}
diff --git a/drivers/infiniband/hw/mlx5/umr.h b/drivers/infiniband/hw/mlx5/umr.h
index 3bb251f07f4e..b42e8c93b385 100644
--- a/drivers/infiniband/hw/mlx5/umr.h
+++ b/drivers/infiniband/hw/mlx5/umr.h
@@ -94,11 +94,8 @@ struct mlx5r_umr_wqe {
 int mlx5r_umr_revoke_mr(struct mlx5_ib_mr *mr);
 int mlx5r_umr_rereg_pd_access(struct mlx5_ib_mr *mr, struct ib_pd *pd,
 			      int access_flags);
-void *mlx5r_umr_create_xlt(struct mlx5_ib_dev *dev, struct ib_sge *sg,
-			   size_t nents, size_t ent_size, unsigned int flags);
-void mlx5r_umr_free_xlt(void *xlt, size_t length);
-void mlx5r_umr_unmap_free_xlt(struct mlx5_ib_dev *dev, void *xlt,
-			      struct ib_sge *sg);
 int mlx5r_umr_update_mr_pas(struct mlx5_ib_mr *mr, unsigned int flags);
+int mlx5r_umr_update_xlt(struct mlx5_ib_mr *mr, u64 idx, int npages,
+			 int page_shift, int flags);
 
 #endif /* _MLX5_IB_UMR_H */
-- 
2.35.1

