Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1924FD49A
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Apr 2022 12:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352355AbiDLJ5p (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Apr 2022 05:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359465AbiDLHnE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 Apr 2022 03:43:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CE3B44
        for <linux-rdma@vger.kernel.org>; Tue, 12 Apr 2022 00:24:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB58C6152A
        for <linux-rdma@vger.kernel.org>; Tue, 12 Apr 2022 07:24:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D53CFC385A1;
        Tue, 12 Apr 2022 07:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649748289;
        bh=CDlqlNryDllor4HoZ6eyPTcJY5LFUoAHm7kCYJqvH5I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j/ajHn/fOhartafF8loQwwj77NdhxBTd/GFz8TzvAScF/gmS/gDoblvq3LK4gYLte
         jLoHtTU+HI/nhbM6O99ulRxVGdt0zFHu+6nzPvskEtXkk6syGh2Q2yIUlzMB2czYiN
         5s1wrSqR/ppQ96EKWlieB4rUwmp6EHQhHu/5wWA5N+uTy5YfdPK6WS3MqruyIe+ySC
         5uviPMd8K47GvV5pGQoWiAJgG1y5NeqKvizaiPdzraj5nx1FlYJWU0NvwNesDm/uwX
         7ZYXzS0pZsQe3ukZo3V0+cFb15V1Ly5ZG+GHS2RiJh20kmBd11XGM3xYajqcawPwVt
         qE8Ax3UWAhFGA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Aharon Landau <aharonl@nvidia.com>, linux-rdma@vger.kernel.org,
        Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH rdma-next 10/12] RDMA/mlx5: Use mlx5_umr_post_send_wait() to update MR pas
Date:   Tue, 12 Apr 2022 10:24:05 +0300
Message-Id: <ed8f2ee6c64804072155d727149abf7105f92536.1649747695.git.leonro@nvidia.com>
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

Signed-off-by: Aharon Landau <aharonl@nvidia.com>
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h |   1 -
 drivers/infiniband/hw/mlx5/mr.c      |  76 +------------
 drivers/infiniband/hw/mlx5/odp.c     |   2 +-
 drivers/infiniband/hw/mlx5/umr.c     | 159 +++++++++++++++++++++++++++
 drivers/infiniband/hw/mlx5/umr.h     |   1 +
 5 files changed, 164 insertions(+), 75 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index d77a27503488..ea4d5519df8c 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1289,7 +1289,6 @@ int mlx5_ib_alloc_mw(struct ib_mw *mw, struct ib_udata *udata);
 int mlx5_ib_dealloc_mw(struct ib_mw *mw);
 int mlx5_ib_update_xlt(struct mlx5_ib_mr *mr, u64 idx, int npages,
 		       int page_shift, int flags);
-int mlx5_ib_update_mr_pas(struct mlx5_ib_mr *mr, unsigned int flags);
 struct mlx5_ib_mr *mlx5_ib_alloc_implicit_mr(struct mlx5_ib_pd *pd,
 					     int access_flags);
 void mlx5_ib_free_implicit_mr(struct mlx5_ib_mr *mr);
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index e7cc32b46851..df79fd5be5f2 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1082,76 +1082,6 @@ int mlx5_ib_update_xlt(struct mlx5_ib_mr *mr, u64 idx, int npages,
 	return err;
 }
 
-/*
- * Send the DMA list to the HW for a normal MR using UMR.
- * Dmabuf MR is handled in a similar way, except that the MLX5_IB_UPD_XLT_ZAP
- * flag may be used.
- */
-int mlx5_ib_update_mr_pas(struct mlx5_ib_mr *mr, unsigned int flags)
-{
-	struct mlx5_ib_dev *dev = mr_to_mdev(mr);
-	struct device *ddev = &dev->mdev->pdev->dev;
-	struct ib_block_iter biter;
-	struct mlx5_mtt *cur_mtt;
-	struct mlx5_umr_wr wr;
-	size_t orig_sg_length;
-	struct mlx5_mtt *mtt;
-	size_t final_size;
-	struct ib_sge sg;
-	int err = 0;
-
-	if (WARN_ON(mr->umem->is_odp))
-		return -EINVAL;
-
-	mtt = mlx5_ib_create_xlt_wr(mr, &wr, &sg,
-				    ib_umem_num_dma_blocks(mr->umem,
-							   1 << mr->page_shift),
-				    sizeof(*mtt), flags);
-	if (!mtt)
-		return -ENOMEM;
-	orig_sg_length = sg.length;
-
-	cur_mtt = mtt;
-	rdma_for_each_block (mr->umem->sgt_append.sgt.sgl, &biter,
-			     mr->umem->sgt_append.sgt.nents,
-			     BIT(mr->page_shift)) {
-		if (cur_mtt == (void *)mtt + sg.length) {
-			dma_sync_single_for_device(ddev, sg.addr, sg.length,
-						   DMA_TO_DEVICE);
-			err = mlx5_ib_post_send_wait(dev, &wr);
-			if (err)
-				goto err;
-			dma_sync_single_for_cpu(ddev, sg.addr, sg.length,
-						DMA_TO_DEVICE);
-			wr.offset += sg.length;
-			cur_mtt = mtt;
-		}
-
-		cur_mtt->ptag =
-			cpu_to_be64(rdma_block_iter_dma_address(&biter) |
-				    MLX5_IB_MTT_PRESENT);
-
-		if (mr->umem->is_dmabuf && (flags & MLX5_IB_UPD_XLT_ZAP))
-			cur_mtt->ptag = 0;
-
-		cur_mtt++;
-	}
-
-	final_size = (void *)cur_mtt - (void *)mtt;
-	sg.length = ALIGN(final_size, MLX5_UMR_MTT_ALIGNMENT);
-	memset(cur_mtt, 0, sg.length - final_size);
-	wr.wr.send_flags |= xlt_wr_final_send_flags(flags);
-	wr.xlt_size = sg.length;
-
-	dma_sync_single_for_device(ddev, sg.addr, sg.length, DMA_TO_DEVICE);
-	err = mlx5_ib_post_send_wait(dev, &wr);
-
-err:
-	sg.length = orig_sg_length;
-	mlx5r_umr_unmap_free_xlt(dev, mtt, &sg);
-	return err;
-}
-
 /*
  * If ibmr is NULL it will be allocated by reg_create.
  * Else, the given ibmr will be used.
@@ -1368,7 +1298,7 @@ static struct ib_mr *create_real_mr(struct ib_pd *pd, struct ib_umem *umem,
 		 * configured properly but left disabled. It is safe to go ahead
 		 * and configure it again via UMR while enabling it.
 		 */
-		err = mlx5_ib_update_mr_pas(mr, MLX5_IB_UPD_XLT_ENABLE);
+		err = mlx5r_umr_update_mr_pas(mr, MLX5_IB_UPD_XLT_ENABLE);
 		if (err) {
 			mlx5_ib_dereg_mr(&mr->ibmr, NULL);
 			return ERR_PTR(err);
@@ -1467,7 +1397,7 @@ static void mlx5_ib_dmabuf_invalidate_cb(struct dma_buf_attachment *attach)
 	if (!umem_dmabuf->sgt)
 		return;
 
-	mlx5_ib_update_mr_pas(mr, MLX5_IB_UPD_XLT_ZAP);
+	mlx5r_umr_update_mr_pas(mr, MLX5_IB_UPD_XLT_ZAP);
 	ib_umem_dmabuf_unmap_pages(umem_dmabuf);
 }
 
@@ -1602,7 +1532,7 @@ static int umr_rereg_pas(struct mlx5_ib_mr *mr, struct ib_pd *pd,
 	mr->ibmr.length = new_umem->length;
 	mr->page_shift = order_base_2(page_size);
 	mr->umem = new_umem;
-	err = mlx5_ib_update_mr_pas(mr, upd_flags);
+	err = mlx5r_umr_update_mr_pas(mr, upd_flags);
 	if (err) {
 		/*
 		 * The MR is revoked at this point so there is no issue to free
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 99dc06f589d4..c00e70e74d94 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -715,7 +715,7 @@ static int pagefault_dmabuf_mr(struct mlx5_ib_mr *mr, size_t bcnt,
 		ib_umem_dmabuf_unmap_pages(umem_dmabuf);
 		err = -EINVAL;
 	} else {
-		err = mlx5_ib_update_mr_pas(mr, xlt_flags);
+		err = mlx5r_umr_update_mr_pas(mr, xlt_flags);
 	}
 	dma_resv_unlock(umem_dmabuf->attach->dmabuf->resv);
 
diff --git a/drivers/infiniband/hw/mlx5/umr.c b/drivers/infiniband/hw/mlx5/umr.c
index ba61e6280cb5..b56e3569c677 100644
--- a/drivers/infiniband/hw/mlx5/umr.c
+++ b/drivers/infiniband/hw/mlx5/umr.c
@@ -499,3 +499,162 @@ void *mlx5r_umr_create_xlt(struct mlx5_ib_dev *dev, struct ib_sge *sg,
 
 	return xlt;
 }
+
+static void
+mlx5r_umr_set_update_xlt_ctrl_seg(struct mlx5_wqe_umr_ctrl_seg *ctrl_seg,
+				  unsigned int flags, struct ib_sge *sg)
+{
+	if (!(flags & MLX5_IB_UPD_XLT_ENABLE))
+		/* fail if free */
+		ctrl_seg->flags = MLX5_UMR_CHECK_FREE;
+	else
+		/* fail if not free */
+		ctrl_seg->flags = MLX5_UMR_CHECK_NOT_FREE;
+	ctrl_seg->xlt_octowords =
+		cpu_to_be16(mlx5r_umr_get_xlt_octo(sg->length));
+}
+
+static void mlx5r_umr_set_update_xlt_mkey_seg(struct mlx5_ib_dev *dev,
+					      struct mlx5_mkey_seg *mkey_seg,
+					      struct mlx5_ib_mr *mr,
+					      unsigned int page_shift)
+{
+	mlx5r_umr_set_access_flags(dev, mkey_seg, mr->access_flags);
+	MLX5_SET(mkc, mkey_seg, pd, to_mpd(mr->ibmr.pd)->pdn);
+	MLX5_SET64(mkc, mkey_seg, start_addr, mr->ibmr.iova);
+	MLX5_SET64(mkc, mkey_seg, len, mr->ibmr.length);
+	MLX5_SET(mkc, mkey_seg, log_page_size, page_shift);
+	MLX5_SET(mkc, mkey_seg, qpn, 0xffffff);
+	MLX5_SET(mkc, mkey_seg, mkey_7_0, mlx5_mkey_variant(mr->mmkey.key));
+}
+
+static void
+mlx5r_umr_set_update_xlt_data_seg(struct mlx5_wqe_data_seg *data_seg,
+				  struct ib_sge *sg)
+{
+	data_seg->byte_count = cpu_to_be32(sg->length);
+	data_seg->lkey = cpu_to_be32(sg->lkey);
+	data_seg->addr = cpu_to_be64(sg->addr);
+}
+
+static void mlx5r_umr_update_offset(struct mlx5_wqe_umr_ctrl_seg *ctrl_seg,
+				    u64 offset)
+{
+	u64 octo_offset = mlx5r_umr_get_xlt_octo(offset);
+
+	ctrl_seg->xlt_offset = cpu_to_be16(octo_offset & 0xffff);
+	ctrl_seg->xlt_offset_47_16 = cpu_to_be32(octo_offset >> 16);
+	ctrl_seg->flags |= MLX5_UMR_TRANSLATION_OFFSET_EN;
+}
+
+static void mlx5r_umr_final_update_xlt(struct mlx5_ib_dev *dev,
+				       struct mlx5r_umr_wqe *wqe,
+				       struct mlx5_ib_mr *mr, struct ib_sge *sg,
+				       unsigned int flags)
+{
+	bool update_pd_access, update_translation;
+
+	if (flags & MLX5_IB_UPD_XLT_ENABLE)
+		wqe->ctrl_seg.mkey_mask |= get_umr_enable_mr_mask();
+
+	update_pd_access = flags & MLX5_IB_UPD_XLT_ENABLE ||
+			   flags & MLX5_IB_UPD_XLT_PD ||
+			   flags & MLX5_IB_UPD_XLT_ACCESS;
+
+	if (update_pd_access) {
+		wqe->ctrl_seg.mkey_mask |= get_umr_update_access_mask(dev);
+		wqe->ctrl_seg.mkey_mask |= get_umr_update_pd_mask();
+	}
+
+	update_translation =
+		flags & MLX5_IB_UPD_XLT_ENABLE || flags & MLX5_IB_UPD_XLT_ADDR;
+
+	if (update_translation) {
+		wqe->ctrl_seg.mkey_mask |= get_umr_update_translation_mask();
+		if (!mr->ibmr.length)
+			MLX5_SET(mkc, &wqe->mkey_seg, length64, 1);
+	}
+
+	wqe->ctrl_seg.xlt_octowords =
+		cpu_to_be16(mlx5r_umr_get_xlt_octo(sg->length));
+	wqe->data_seg.byte_count = cpu_to_be32(sg->length);
+}
+
+/*
+ * Send the DMA list to the HW for a normal MR using UMR.
+ * Dmabuf MR is handled in a similar way, except that the MLX5_IB_UPD_XLT_ZAP
+ * flag may be used.
+ */
+int mlx5r_umr_update_mr_pas(struct mlx5_ib_mr *mr, unsigned int flags)
+{
+	struct mlx5_ib_dev *dev = mr_to_mdev(mr);
+	struct device *ddev = &dev->mdev->pdev->dev;
+	struct mlx5r_umr_wqe wqe = {};
+	struct ib_block_iter biter;
+	struct mlx5_mtt *cur_mtt;
+	size_t orig_sg_length;
+	struct mlx5_mtt *mtt;
+	size_t final_size;
+	struct ib_sge sg;
+	u64 offset = 0;
+	int err = 0;
+
+	if (WARN_ON(mr->umem->is_odp))
+		return -EINVAL;
+
+	mtt = mlx5r_umr_create_xlt(
+		dev, &sg, ib_umem_num_dma_blocks(mr->umem, 1 << mr->page_shift),
+		sizeof(*mtt), flags);
+	if (!mtt)
+		return -ENOMEM;
+
+	orig_sg_length = sg.length;
+
+	mlx5r_umr_set_update_xlt_ctrl_seg(&wqe.ctrl_seg, flags, &sg);
+	mlx5r_umr_set_update_xlt_mkey_seg(dev, &wqe.mkey_seg, mr,
+					  mr->page_shift);
+	mlx5r_umr_set_update_xlt_data_seg(&wqe.data_seg, &sg);
+
+	cur_mtt = mtt;
+	rdma_for_each_block(mr->umem->sgt_append.sgt.sgl, &biter,
+			    mr->umem->sgt_append.sgt.nents,
+			    BIT(mr->page_shift)) {
+		if (cur_mtt == (void *)mtt + sg.length) {
+			dma_sync_single_for_device(ddev, sg.addr, sg.length,
+						   DMA_TO_DEVICE);
+
+			err = mlx5r_umr_post_send_wait(dev, mr->mmkey.key, &wqe,
+						       true);
+			if (err)
+				goto err;
+			dma_sync_single_for_cpu(ddev, sg.addr, sg.length,
+						DMA_TO_DEVICE);
+			offset += sg.length;
+			mlx5r_umr_update_offset(&wqe.ctrl_seg, offset);
+
+			cur_mtt = mtt;
+		}
+
+		cur_mtt->ptag =
+			cpu_to_be64(rdma_block_iter_dma_address(&biter) |
+				    MLX5_IB_MTT_PRESENT);
+
+		if (mr->umem->is_dmabuf && (flags & MLX5_IB_UPD_XLT_ZAP))
+			cur_mtt->ptag = 0;
+
+		cur_mtt++;
+	}
+
+	final_size = (void *)cur_mtt - (void *)mtt;
+	sg.length = ALIGN(final_size, MLX5_UMR_MTT_ALIGNMENT);
+	memset(cur_mtt, 0, sg.length - final_size);
+	mlx5r_umr_final_update_xlt(dev, &wqe, mr, &sg, flags);
+
+	dma_sync_single_for_device(ddev, sg.addr, sg.length, DMA_TO_DEVICE);
+	err = mlx5r_umr_post_send_wait(dev, mr->mmkey.key, &wqe, true);
+
+err:
+	sg.length = orig_sg_length;
+	mlx5r_umr_unmap_free_xlt(dev, mtt, &sg);
+	return err;
+}
diff --git a/drivers/infiniband/hw/mlx5/umr.h b/drivers/infiniband/hw/mlx5/umr.h
index 2485379fec32..3bb251f07f4e 100644
--- a/drivers/infiniband/hw/mlx5/umr.h
+++ b/drivers/infiniband/hw/mlx5/umr.h
@@ -99,5 +99,6 @@ void *mlx5r_umr_create_xlt(struct mlx5_ib_dev *dev, struct ib_sge *sg,
 void mlx5r_umr_free_xlt(void *xlt, size_t length);
 void mlx5r_umr_unmap_free_xlt(struct mlx5_ib_dev *dev, void *xlt,
 			      struct ib_sge *sg);
+int mlx5r_umr_update_mr_pas(struct mlx5_ib_mr *mr, unsigned int flags);
 
 #endif /* _MLX5_IB_UMR_H */
-- 
2.35.1

