Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1FB2C3948
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Nov 2020 07:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgKYGqf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Nov 2020 01:46:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:43260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726595AbgKYGqe (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 25 Nov 2020 01:46:34 -0500
Received: from localhost (searspoint.nvidia.com [216.228.112.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED1932067D;
        Wed, 25 Nov 2020 06:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606286793;
        bh=86VZxei8XE01yUAd/Va+H68KT9ZhAzO5jqjISus0IQ8=;
        h=From:To:Cc:Subject:Date:From;
        b=zdGq9rKGtiZKPAYnD2dhqAQEJYBUUeNDSNzzmcsbCvpQar5gysoYx+sBO++rkX5qD
         RxO3MT+qj2576MarnNkgkfQiMxerPJeFdlS9tZ2LkAPpuG81SoLl9PnksjCCDMSZ2n
         oMhBRWF9Ofw0kJDNsY1FRP+rfS+bIQl/V6B/Wljk=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Parav Pandit <parav@nvidia.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v1] IB/mlx5: Use PCI device for dma mappings
Date:   Wed, 25 Nov 2020 08:46:28 +0200
Message-Id: <20201125064628.8431-1-leon@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Parav Pandit <parav@nvidia.com>

DMA operation of the IB device is done using ib_device->dma_device.

Instead of accessing parent of the IB device, use the PCI dma device
which is setup to ib_device->dma_device during IB device registration.

Signed-off-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
Chagenlog:
v1:
 * Use PCI device directly instead of ib_dma API
 * Limited checkpatch to 80 symbols.
v0: https://lore.kernel.org/linux-rdma/20201123082400.351371-1-leon@kernel.org
---
 drivers/infiniband/hw/mlx5/mr.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 090e204ef1e1..b3192da36d5e 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1081,7 +1081,7 @@ static void *mlx5_ib_create_xlt_wr(struct mlx5_ib_mr *mr,
 				   unsigned int flags)
 {
 	struct mlx5_ib_dev *dev = mr->dev;
-	struct device *ddev = dev->ib_dev.dev.parent;
+	struct device *ddev = &dev->mdev->pdev->dev;
 	dma_addr_t dma;
 	void *xlt;

@@ -1118,7 +1118,7 @@ static void *mlx5_ib_create_xlt_wr(struct mlx5_ib_mr *mr,
 static void mlx5_ib_unmap_free_xlt(struct mlx5_ib_dev *dev, void *xlt,
 				   struct ib_sge *sg)
 {
-	struct device *ddev = dev->ib_dev.dev.parent;
+	struct device *ddev = &dev->mdev->pdev->dev;

 	dma_unmap_single(ddev, sg->addr, sg->length, DMA_TO_DEVICE);
 	mlx5_ib_free_xlt(xlt, sg->length);
@@ -1143,7 +1143,7 @@ int mlx5_ib_update_xlt(struct mlx5_ib_mr *mr, u64 idx, int npages,
 		       int page_shift, int flags)
 {
 	struct mlx5_ib_dev *dev = mr->dev;
-	struct device *ddev = dev->ib_dev.dev.parent;
+	struct device *ddev = &dev->mdev->pdev->dev;
 	void *xlt;
 	struct mlx5_umr_wr wr;
 	struct ib_sge sg;
@@ -1222,7 +1222,7 @@ int mlx5_ib_update_xlt(struct mlx5_ib_mr *mr, u64 idx, int npages,
 static int mlx5_ib_update_mr_pas(struct mlx5_ib_mr *mr, unsigned int flags)
 {
 	struct mlx5_ib_dev *dev = mr->dev;
-	struct device *ddev = dev->ib_dev.dev.parent;
+	struct device *ddev = &dev->mdev->pdev->dev;
 	struct ib_block_iter biter;
 	struct mlx5_mtt *cur_mtt;
 	struct mlx5_umr_wr wr;
@@ -1751,6 +1751,8 @@ mlx5_alloc_priv_descs(struct ib_device *device,
 		      int ndescs,
 		      int desc_size)
 {
+	struct mlx5_ib_dev *dev = to_mdev(device);
+	struct device *ddev = &dev->mdev->pdev->dev;
 	int size = ndescs * desc_size;
 	int add_size;
 	int ret;
@@ -1763,9 +1765,8 @@ mlx5_alloc_priv_descs(struct ib_device *device,

 	mr->descs = PTR_ALIGN(mr->descs_alloc, MLX5_UMR_ALIGN);

-	mr->desc_map = dma_map_single(device->dev.parent, mr->descs,
-				      size, DMA_TO_DEVICE);
-	if (dma_mapping_error(device->dev.parent, mr->desc_map)) {
+	mr->desc_map = dma_map_single(ddev, mr->descs, size, DMA_TO_DEVICE);
+	if (dma_mapping_error(ddev, mr->desc_map)) {
 		ret = -ENOMEM;
 		goto err;
 	}
@@ -1783,9 +1784,10 @@ mlx5_free_priv_descs(struct mlx5_ib_mr *mr)
 	if (mr->descs) {
 		struct ib_device *device = mr->ibmr.device;
 		int size = mr->max_descs * mr->desc_size;
+		struct mlx5_ib_dev *dev = to_mdev(device);

-		dma_unmap_single(device->dev.parent, mr->desc_map,
-				 size, DMA_TO_DEVICE);
+		dma_unmap_single(&dev->mdev->pdev->dev, mr->desc_map, size,
+				 DMA_TO_DEVICE);
 		kfree(mr->descs_alloc);
 		mr->descs = NULL;
 	}
--
2.28.0

