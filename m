Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 182B14FD9A5
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Apr 2022 12:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352514AbiDLJ54 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Apr 2022 05:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359464AbiDLHnE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 Apr 2022 03:43:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF7BDEC0
        for <linux-rdma@vger.kernel.org>; Tue, 12 Apr 2022 00:24:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 397F96152A
        for <linux-rdma@vger.kernel.org>; Tue, 12 Apr 2022 07:24:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28CC7C385A1;
        Tue, 12 Apr 2022 07:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649748285;
        bh=q5L1DolPWD/WwHSMWLTE9PdMAs6ForWtPQOPrPh3POU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YCTak1QTS0QUQPZ0TagZ9VDfzp1Lfoqr/v3zikZT+PFzySl7iDdILI+P9XfyV4WlK
         nDw0CfJ2LgK+IFsp7Z35whhym31UY+in2KsXA+BZ1dCkCHZxjd2ydSd2jLH2tYc/yR
         Iol2Iu7Hp+iiFio9HfCh8z511VfnCrGRAFFpG6LhmfzVRa0/cXBJwGcFs1N/N5ftWY
         q8iqcblMfHYhXFiypslXtHbiCidAd91YiGwZMMjDWoS2rTL/Haz99Zr3UBL3nMtihD
         qhTT8fG3hIJX9GwxJImOeZN8E/m/BC7et277XQqVbgkA94oiwSMkF1RTpPGoxqufGs
         A2ZuwYZWnblQQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Aharon Landau <aharonl@nvidia.com>, linux-rdma@vger.kernel.org,
        Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH rdma-next 09/12] RDMA/mlx5: Move creation and free of translation tables to umr.c
Date:   Tue, 12 Apr 2022 10:24:04 +0300
Message-Id: <1d93f1381be82a22aaf1168cdbdfb227eac1ce62.1649747695.git.leonro@nvidia.com>
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

The only use of the translation tables is to update the mkey translation
by a UMR operation. Move the responsibility of creating and freeing them
to umr.c

Signed-off-by: Aharon Landau <aharonl@nvidia.com>
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mr.c  | 103 +----------------------------
 drivers/infiniband/hw/mlx5/umr.c | 109 +++++++++++++++++++++++++++++++
 drivers/infiniband/hw/mlx5/umr.h |   5 ++
 3 files changed, 117 insertions(+), 100 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 50b4ccd38fe2..e7cc32b46851 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -46,13 +46,6 @@
 #include "mlx5_ib.h"
 #include "umr.h"
 
-/*
- * We can't use an array for xlt_emergency_page because dma_map_single doesn't
- * work on kernel modules memory
- */
-void *xlt_emergency_page;
-static DEFINE_MUTEX(xlt_emergency_page_mutex);
-
 enum {
 	MAX_PENDING_REG_MR = 8,
 };
@@ -966,74 +959,6 @@ static struct mlx5_ib_mr *alloc_cacheable_mr(struct ib_pd *pd,
 	return mr;
 }
 
-#define MLX5_MAX_UMR_CHUNK ((1 << (MLX5_MAX_UMR_SHIFT + 4)) - \
-			    MLX5_UMR_MTT_ALIGNMENT)
-#define MLX5_SPARE_UMR_CHUNK 0x10000
-
-/*
- * Allocate a temporary buffer to hold the per-page information to transfer to
- * HW. For efficiency this should be as large as it can be, but buffer
- * allocation failure is not allowed, so try smaller sizes.
- */
-static void *mlx5_ib_alloc_xlt(size_t *nents, size_t ent_size, gfp_t gfp_mask)
-{
-	const size_t xlt_chunk_align =
-		MLX5_UMR_MTT_ALIGNMENT / ent_size;
-	size_t size;
-	void *res = NULL;
-
-	static_assert(PAGE_SIZE % MLX5_UMR_MTT_ALIGNMENT == 0);
-
-	/*
-	 * MLX5_IB_UPD_XLT_ATOMIC doesn't signal an atomic context just that the
-	 * allocation can't trigger any kind of reclaim.
-	 */
-	might_sleep();
-
-	gfp_mask |= __GFP_ZERO | __GFP_NORETRY;
-
-	/*
-	 * If the system already has a suitable high order page then just use
-	 * that, but don't try hard to create one. This max is about 1M, so a
-	 * free x86 huge page will satisfy it.
-	 */
-	size = min_t(size_t, ent_size * ALIGN(*nents, xlt_chunk_align),
-		     MLX5_MAX_UMR_CHUNK);
-	*nents = size / ent_size;
-	res = (void *)__get_free_pages(gfp_mask | __GFP_NOWARN,
-				       get_order(size));
-	if (res)
-		return res;
-
-	if (size > MLX5_SPARE_UMR_CHUNK) {
-		size = MLX5_SPARE_UMR_CHUNK;
-		*nents = size / ent_size;
-		res = (void *)__get_free_pages(gfp_mask | __GFP_NOWARN,
-					       get_order(size));
-		if (res)
-			return res;
-	}
-
-	*nents = PAGE_SIZE / ent_size;
-	res = (void *)__get_free_page(gfp_mask);
-	if (res)
-		return res;
-
-	mutex_lock(&xlt_emergency_page_mutex);
-	memset(xlt_emergency_page, 0, PAGE_SIZE);
-	return xlt_emergency_page;
-}
-
-static void mlx5_ib_free_xlt(void *xlt, size_t length)
-{
-	if (xlt == xlt_emergency_page) {
-		mutex_unlock(&xlt_emergency_page_mutex);
-		return;
-	}
-
-	free_pages((unsigned long)xlt, get_order(length));
-}
-
 /*
  * Create a MLX5_IB_SEND_UMR_UPDATE_XLT work request and XLT buffer ready for
  * submission.
@@ -1044,22 +969,9 @@ static void *mlx5_ib_create_xlt_wr(struct mlx5_ib_mr *mr,
 				   unsigned int flags)
 {
 	struct mlx5_ib_dev *dev = mr_to_mdev(mr);
-	struct device *ddev = &dev->mdev->pdev->dev;
-	dma_addr_t dma;
 	void *xlt;
 
-	xlt = mlx5_ib_alloc_xlt(&nents, ent_size,
-				flags & MLX5_IB_UPD_XLT_ATOMIC ? GFP_ATOMIC :
-								 GFP_KERNEL);
-	sg->length = nents * ent_size;
-	dma = dma_map_single(ddev, xlt, sg->length, DMA_TO_DEVICE);
-	if (dma_mapping_error(ddev, dma)) {
-		mlx5_ib_err(dev, "unable to map DMA during XLT update.\n");
-		mlx5_ib_free_xlt(xlt, sg->length);
-		return NULL;
-	}
-	sg->addr = dma;
-	sg->lkey = dev->umrc.pd->local_dma_lkey;
+	xlt = mlx5r_umr_create_xlt(dev, sg, nents, ent_size, flags);
 
 	memset(wr, 0, sizeof(*wr));
 	wr->wr.send_flags = MLX5_IB_SEND_UMR_UPDATE_XLT;
@@ -1078,15 +990,6 @@ static void *mlx5_ib_create_xlt_wr(struct mlx5_ib_mr *mr,
 	return xlt;
 }
 
-static void mlx5_ib_unmap_free_xlt(struct mlx5_ib_dev *dev, void *xlt,
-				   struct ib_sge *sg)
-{
-	struct device *ddev = &dev->mdev->pdev->dev;
-
-	dma_unmap_single(ddev, sg->addr, sg->length, DMA_TO_DEVICE);
-	mlx5_ib_free_xlt(xlt, sg->length);
-}
-
 static unsigned int xlt_wr_final_send_flags(unsigned int flags)
 {
 	unsigned int res = 0;
@@ -1175,7 +1078,7 @@ int mlx5_ib_update_xlt(struct mlx5_ib_mr *mr, u64 idx, int npages,
 		err = mlx5_ib_post_send_wait(dev, &wr);
 	}
 	sg.length = orig_sg_length;
-	mlx5_ib_unmap_free_xlt(dev, xlt, &sg);
+	mlx5r_umr_unmap_free_xlt(dev, xlt, &sg);
 	return err;
 }
 
@@ -1245,7 +1148,7 @@ int mlx5_ib_update_mr_pas(struct mlx5_ib_mr *mr, unsigned int flags)
 
 err:
 	sg.length = orig_sg_length;
-	mlx5_ib_unmap_free_xlt(dev, mtt, &sg);
+	mlx5r_umr_unmap_free_xlt(dev, mtt, &sg);
 	return err;
 }
 
diff --git a/drivers/infiniband/hw/mlx5/umr.c b/drivers/infiniband/hw/mlx5/umr.c
index 716c35258e33..ba61e6280cb5 100644
--- a/drivers/infiniband/hw/mlx5/umr.c
+++ b/drivers/infiniband/hw/mlx5/umr.c
@@ -5,6 +5,13 @@
 #include "umr.h"
 #include "wr.h"
 
+/*
+ * We can't use an array for xlt_emergency_page because dma_map_single doesn't
+ * work on kernel modules memory
+ */
+void *xlt_emergency_page;
+static DEFINE_MUTEX(xlt_emergency_page_mutex);
+
 static __be64 get_umr_enable_mr_mask(void)
 {
 	u64 result;
@@ -390,3 +397,105 @@ int mlx5r_umr_rereg_pd_access(struct mlx5_ib_mr *mr, struct ib_pd *pd,
 	mr->access_flags = access_flags;
 	return 0;
 }
+
+#define MLX5_MAX_UMR_CHUNK                                                     \
+	((1 << (MLX5_MAX_UMR_SHIFT + 4)) - MLX5_UMR_MTT_ALIGNMENT)
+#define MLX5_SPARE_UMR_CHUNK 0x10000
+
+/*
+ * Allocate a temporary buffer to hold the per-page information to transfer to
+ * HW. For efficiency this should be as large as it can be, but buffer
+ * allocation failure is not allowed, so try smaller sizes.
+ */
+static void *mlx5r_umr_alloc_xlt(size_t *nents, size_t ent_size, gfp_t gfp_mask)
+{
+	const size_t xlt_chunk_align = MLX5_UMR_MTT_ALIGNMENT / ent_size;
+	size_t size;
+	void *res = NULL;
+
+	static_assert(PAGE_SIZE % MLX5_UMR_MTT_ALIGNMENT == 0);
+
+	/*
+	 * MLX5_IB_UPD_XLT_ATOMIC doesn't signal an atomic context just that the
+	 * allocation can't trigger any kind of reclaim.
+	 */
+	might_sleep();
+
+	gfp_mask |= __GFP_ZERO | __GFP_NORETRY;
+
+	/*
+	 * If the system already has a suitable high order page then just use
+	 * that, but don't try hard to create one. This max is about 1M, so a
+	 * free x86 huge page will satisfy it.
+	 */
+	size = min_t(size_t, ent_size * ALIGN(*nents, xlt_chunk_align),
+		     MLX5_MAX_UMR_CHUNK);
+	*nents = size / ent_size;
+	res = (void *)__get_free_pages(gfp_mask | __GFP_NOWARN,
+				       get_order(size));
+	if (res)
+		return res;
+
+	if (size > MLX5_SPARE_UMR_CHUNK) {
+		size = MLX5_SPARE_UMR_CHUNK;
+		*nents = size / ent_size;
+		res = (void *)__get_free_pages(gfp_mask | __GFP_NOWARN,
+					       get_order(size));
+		if (res)
+			return res;
+	}
+
+	*nents = PAGE_SIZE / ent_size;
+	res = (void *)__get_free_page(gfp_mask);
+	if (res)
+		return res;
+
+	mutex_lock(&xlt_emergency_page_mutex);
+	memset(xlt_emergency_page, 0, PAGE_SIZE);
+	return xlt_emergency_page;
+}
+
+void mlx5r_umr_free_xlt(void *xlt, size_t length)
+{
+	if (xlt == xlt_emergency_page) {
+		mutex_unlock(&xlt_emergency_page_mutex);
+		return;
+	}
+
+	free_pages((unsigned long)xlt, get_order(length));
+}
+
+void mlx5r_umr_unmap_free_xlt(struct mlx5_ib_dev *dev, void *xlt,
+			     struct ib_sge *sg)
+{
+	struct device *ddev = &dev->mdev->pdev->dev;
+
+	dma_unmap_single(ddev, sg->addr, sg->length, DMA_TO_DEVICE);
+	mlx5r_umr_free_xlt(xlt, sg->length);
+}
+
+/*
+ * Create an XLT buffer ready for submission.
+ */
+void *mlx5r_umr_create_xlt(struct mlx5_ib_dev *dev, struct ib_sge *sg,
+			  size_t nents, size_t ent_size, unsigned int flags)
+{
+	struct device *ddev = &dev->mdev->pdev->dev;
+	dma_addr_t dma;
+	void *xlt;
+
+	xlt = mlx5r_umr_alloc_xlt(&nents, ent_size,
+				 flags & MLX5_IB_UPD_XLT_ATOMIC ? GFP_ATOMIC :
+								  GFP_KERNEL);
+	sg->length = nents * ent_size;
+	dma = dma_map_single(ddev, xlt, sg->length, DMA_TO_DEVICE);
+	if (dma_mapping_error(ddev, dma)) {
+		mlx5_ib_err(dev, "unable to map DMA during XLT update.\n");
+		mlx5r_umr_free_xlt(xlt, sg->length);
+		return NULL;
+	}
+	sg->addr = dma;
+	sg->lkey = dev->umrc.pd->local_dma_lkey;
+
+	return xlt;
+}
diff --git a/drivers/infiniband/hw/mlx5/umr.h b/drivers/infiniband/hw/mlx5/umr.h
index 53816316cb1f..2485379fec32 100644
--- a/drivers/infiniband/hw/mlx5/umr.h
+++ b/drivers/infiniband/hw/mlx5/umr.h
@@ -94,5 +94,10 @@ struct mlx5r_umr_wqe {
 int mlx5r_umr_revoke_mr(struct mlx5_ib_mr *mr);
 int mlx5r_umr_rereg_pd_access(struct mlx5_ib_mr *mr, struct ib_pd *pd,
 			      int access_flags);
+void *mlx5r_umr_create_xlt(struct mlx5_ib_dev *dev, struct ib_sge *sg,
+			   size_t nents, size_t ent_size, unsigned int flags);
+void mlx5r_umr_free_xlt(void *xlt, size_t length);
+void mlx5r_umr_unmap_free_xlt(struct mlx5_ib_dev *dev, void *xlt,
+			      struct ib_sge *sg);
 
 #endif /* _MLX5_IB_UMR_H */
-- 
2.35.1

