Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDBFC2C0167
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Nov 2020 09:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgKWIYH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Nov 2020 03:24:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:54596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725320AbgKWIYH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 23 Nov 2020 03:24:07 -0500
Received: from localhost (searspoint.nvidia.com [216.228.112.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62E7620719;
        Mon, 23 Nov 2020 08:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606119846;
        bh=L7NR3V7+RnIUxxDxpLw0DNhC1uWCEMm960A0zm2a+rU=;
        h=From:To:Cc:Subject:Date:From;
        b=Za5pEij03t9b/P+KuFf6PQaywYlUW1DpWFNWNrlMM5sOZoM0TQ42nT+DsSO0tcHZr
         E+rw6OZH9i3JjzC2280ET27VFeWFEm+CCkEnO6Qkh+HGt5rwjsxhTvxMwUhla8hPxu
         IXBpw4dHAEDkQ9p74STHF8Qa8TV6QsdSZWENifi8=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Parav Pandit <parav@nvidia.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next] IB/mlx5: Use ib_dma APIs instead of open access to parent device
Date:   Mon, 23 Nov 2020 10:24:00 +0200
Message-Id: <20201123082400.351371-1-leon@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Parav Pandit <parav@nvidia.com>

DMA operation of the IB device is done using ib_device->dma_device.
This is well abstracted using ib_dma APIs.

Hence, instead of doing open access to parent device, use IB core
provided dma mapping APIs.

Signed-off-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mr.c | 40 +++++++++++++--------------------
 1 file changed, 15 insertions(+), 25 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 090e204ef1e1..d24ac339c053 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -42,7 +42,7 @@
 #include "mlx5_ib.h"
 
 /*
- * We can't use an array for xlt_emergency_page because dma_map_single doesn't
+ * We can't use an array for xlt_emergency_page because ib_dma_map_single doesn't
  * work on kernel modules memory
  */
 void *xlt_emergency_page;
@@ -1081,7 +1081,6 @@ static void *mlx5_ib_create_xlt_wr(struct mlx5_ib_mr *mr,
 				   unsigned int flags)
 {
 	struct mlx5_ib_dev *dev = mr->dev;
-	struct device *ddev = dev->ib_dev.dev.parent;
 	dma_addr_t dma;
 	void *xlt;
 
@@ -1089,8 +1088,8 @@ static void *mlx5_ib_create_xlt_wr(struct mlx5_ib_mr *mr,
 				flags & MLX5_IB_UPD_XLT_ATOMIC ? GFP_ATOMIC :
 								 GFP_KERNEL);
 	sg->length = nents * ent_size;
-	dma = dma_map_single(ddev, xlt, sg->length, DMA_TO_DEVICE);
-	if (dma_mapping_error(ddev, dma)) {
+	dma = ib_dma_map_single(&dev->ib_dev, xlt, sg->length, DMA_TO_DEVICE);
+	if (ib_dma_mapping_error(&dev->ib_dev, dma)) {
 		mlx5_ib_err(dev, "unable to map DMA during XLT update.\n");
 		mlx5_ib_free_xlt(xlt, sg->length);
 		return NULL;
@@ -1118,9 +1117,7 @@ static void *mlx5_ib_create_xlt_wr(struct mlx5_ib_mr *mr,
 static void mlx5_ib_unmap_free_xlt(struct mlx5_ib_dev *dev, void *xlt,
 				   struct ib_sge *sg)
 {
-	struct device *ddev = dev->ib_dev.dev.parent;
-
-	dma_unmap_single(ddev, sg->addr, sg->length, DMA_TO_DEVICE);
+	ib_dma_unmap_single(&dev->ib_dev, sg->addr, sg->length, DMA_TO_DEVICE);
 	mlx5_ib_free_xlt(xlt, sg->length);
 }
 
@@ -1143,7 +1140,6 @@ int mlx5_ib_update_xlt(struct mlx5_ib_mr *mr, u64 idx, int npages,
 		       int page_shift, int flags)
 {
 	struct mlx5_ib_dev *dev = mr->dev;
-	struct device *ddev = dev->ib_dev.dev.parent;
 	void *xlt;
 	struct mlx5_umr_wr wr;
 	struct ib_sge sg;
@@ -1195,11 +1191,9 @@ int mlx5_ib_update_xlt(struct mlx5_ib_mr *mr, u64 idx, int npages,
 	     pages_mapped += pages_iter, idx += pages_iter) {
 		npages = min_t(int, pages_iter, pages_to_map - pages_mapped);
 		size_to_map = npages * desc_size;
-		dma_sync_single_for_cpu(ddev, sg.addr, sg.length,
-					DMA_TO_DEVICE);
+		ib_dma_sync_single_for_cpu(&dev->ib_dev, sg.addr, sg.length, DMA_TO_DEVICE);
 		mlx5_odp_populate_xlt(xlt, idx, npages, mr, flags);
-		dma_sync_single_for_device(ddev, sg.addr, sg.length,
-					   DMA_TO_DEVICE);
+		ib_dma_sync_single_for_device(&dev->ib_dev, sg.addr, sg.length, DMA_TO_DEVICE);
 
 		sg.length = ALIGN(size_to_map, MLX5_UMR_MTT_ALIGNMENT);
 
@@ -1222,7 +1216,6 @@ int mlx5_ib_update_xlt(struct mlx5_ib_mr *mr, u64 idx, int npages,
 static int mlx5_ib_update_mr_pas(struct mlx5_ib_mr *mr, unsigned int flags)
 {
 	struct mlx5_ib_dev *dev = mr->dev;
-	struct device *ddev = dev->ib_dev.dev.parent;
 	struct ib_block_iter biter;
 	struct mlx5_mtt *cur_mtt;
 	struct mlx5_umr_wr wr;
@@ -1247,13 +1240,13 @@ static int mlx5_ib_update_mr_pas(struct mlx5_ib_mr *mr, unsigned int flags)
 	rdma_for_each_block (mr->umem->sg_head.sgl, &biter, mr->umem->nmap,
 			     BIT(mr->page_shift)) {
 		if (cur_mtt == (void *)mtt + sg.length) {
-			dma_sync_single_for_device(ddev, sg.addr, sg.length,
-						   DMA_TO_DEVICE);
+			ib_dma_sync_single_for_device(&dev->ib_dev, sg.addr, sg.length,
+						      DMA_TO_DEVICE);
 			err = mlx5_ib_post_send_wait(dev, &wr);
 			if (err)
 				goto err;
-			dma_sync_single_for_cpu(ddev, sg.addr, sg.length,
-						DMA_TO_DEVICE);
+			ib_dma_sync_single_for_cpu(&dev->ib_dev, sg.addr, sg.length,
+						   DMA_TO_DEVICE);
 			wr.offset += sg.length;
 			cur_mtt = mtt;
 		}
@@ -1270,7 +1263,7 @@ static int mlx5_ib_update_mr_pas(struct mlx5_ib_mr *mr, unsigned int flags)
 	wr.wr.send_flags |= xlt_wr_final_send_flags(flags);
 	wr.xlt_size = sg.length;
 
-	dma_sync_single_for_device(ddev, sg.addr, sg.length, DMA_TO_DEVICE);
+	ib_dma_sync_single_for_device(&dev->ib_dev, sg.addr, sg.length, DMA_TO_DEVICE);
 	err = mlx5_ib_post_send_wait(dev, &wr);
 
 err:
@@ -1763,12 +1756,10 @@ mlx5_alloc_priv_descs(struct ib_device *device,
 
 	mr->descs = PTR_ALIGN(mr->descs_alloc, MLX5_UMR_ALIGN);
 
-	mr->desc_map = dma_map_single(device->dev.parent, mr->descs,
-				      size, DMA_TO_DEVICE);
-	if (dma_mapping_error(device->dev.parent, mr->desc_map)) {
-		ret = -ENOMEM;
+	mr->desc_map = ib_dma_map_single(device, mr->descs, size, DMA_TO_DEVICE);
+	ret = ib_dma_mapping_error(device, mr->desc_map);
+	if (ret)
 		goto err;
-	}
 
 	return 0;
 err:
@@ -1784,8 +1775,7 @@ mlx5_free_priv_descs(struct mlx5_ib_mr *mr)
 		struct ib_device *device = mr->ibmr.device;
 		int size = mr->max_descs * mr->desc_size;
 
-		dma_unmap_single(device->dev.parent, mr->desc_map,
-				 size, DMA_TO_DEVICE);
+		ib_dma_unmap_single(device, mr->desc_map, size, DMA_TO_DEVICE);
 		kfree(mr->descs_alloc);
 		mr->descs = NULL;
 	}
-- 
2.28.0

