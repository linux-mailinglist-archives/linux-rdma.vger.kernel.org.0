Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6F9B1648E4
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2020 16:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgBSPlo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Feb 2020 10:41:44 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:59897 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726604AbgBSPlo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Feb 2020 10:41:44 -0500
Received: from Internal Mail-Server by MTLPINE2 (envelope-from maxg@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 19 Feb 2020 17:41:42 +0200
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx [10.209.102.136])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 01JFfgkt030371;
        Wed, 19 Feb 2020 17:41:42 +0200
From:   Max Gurtovoy <maxg@mellanox.com>
To:     jgg@mellanox.com, leon@kernel.org, linux-rdma@vger.kernel.org
Cc:     Max Gurtovoy <maxg@mellanox.com>
Subject: [PATCH 1/1] RDMA/rw: map P2P memory correctly for signature operations
Date:   Wed, 19 Feb 2020 17:41:42 +0200
Message-Id: <20200219154142.9894-1-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Since RDMA rw API support operations with P2P memory sg list, make sure
to map/unmap the scatter list for signature operation correctly. while
we're here, fix an error flow that doesn't unmap the sg list according
to the memory type.

Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
Signed-off-by: Israel Rukshin <israelr@mellanox.com>
---
 drivers/infiniband/core/rw.c | 44 +++++++++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 17 deletions(-)

diff --git a/drivers/infiniband/core/rw.c b/drivers/infiniband/core/rw.c
index 4fad732..6eba845 100644
--- a/drivers/infiniband/core/rw.c
+++ b/drivers/infiniband/core/rw.c
@@ -273,6 +273,24 @@ static int rdma_rw_init_single_wr(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 	return 1;
 }
 
+static void rdma_rw_unmap_sg(struct ib_device *dev, struct scatterlist *sg,
+		u32 sg_cnt, enum dma_data_direction dir)
+{
+	if (is_pci_p2pdma_page(sg_page(sg)))
+		pci_p2pdma_unmap_sg(dev->dma_device, sg, sg_cnt, dir);
+	else
+		ib_dma_unmap_sg(dev, sg, sg_cnt, dir);
+}
+
+static int rdma_rw_map_sg(struct ib_device *dev, struct scatterlist *sg,
+		u32 sg_cnt, enum dma_data_direction dir)
+{
+	if (is_pci_p2pdma_page(sg_page(sg)))
+		return pci_p2pdma_map_sg(dev->dma_device, sg, sg_cnt, dir);
+	else
+		return ib_dma_map_sg(dev, sg, sg_cnt, dir);
+}
+
 /**
  * rdma_rw_ctx_init - initialize a RDMA READ/WRITE context
  * @ctx:	context to initialize
@@ -295,11 +313,7 @@ int rdma_rw_ctx_init(struct rdma_rw_ctx *ctx, struct ib_qp *qp, u8 port_num,
 	struct ib_device *dev = qp->pd->device;
 	int ret;
 
-	if (is_pci_p2pdma_page(sg_page(sg)))
-		ret = pci_p2pdma_map_sg(dev->dma_device, sg, sg_cnt, dir);
-	else
-		ret = ib_dma_map_sg(dev, sg, sg_cnt, dir);
-
+	ret = rdma_rw_map_sg(dev, sg, sg_cnt, dir);
 	if (!ret)
 		return -ENOMEM;
 	sg_cnt = ret;
@@ -338,7 +352,7 @@ int rdma_rw_ctx_init(struct rdma_rw_ctx *ctx, struct ib_qp *qp, u8 port_num,
 	return ret;
 
 out_unmap_sg:
-	ib_dma_unmap_sg(dev, sg, sg_cnt, dir);
+	rdma_rw_unmap_sg(dev, sg, sg_cnt, dir);
 	return ret;
 }
 EXPORT_SYMBOL(rdma_rw_ctx_init);
@@ -378,13 +392,13 @@ int rdma_rw_ctx_signature_init(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 		return -EINVAL;
 	}
 
-	ret = ib_dma_map_sg(dev, sg, sg_cnt, dir);
+	ret = rdma_rw_map_sg(dev, sg, sg_cnt, dir);
 	if (!ret)
 		return -ENOMEM;
 	sg_cnt = ret;
 
 	if (prot_sg_cnt) {
-		ret = ib_dma_map_sg(dev, prot_sg, prot_sg_cnt, dir);
+		ret = rdma_rw_map_sg(dev, prot_sg, prot_sg_cnt, dir);
 		if (!ret) {
 			ret = -ENOMEM;
 			goto out_unmap_sg;
@@ -453,9 +467,9 @@ int rdma_rw_ctx_signature_init(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 	kfree(ctx->reg);
 out_unmap_prot_sg:
 	if (prot_sg_cnt)
-		ib_dma_unmap_sg(dev, prot_sg, prot_sg_cnt, dir);
+		rdma_rw_unmap_sg(dev, prot_sg, prot_sg_cnt, dir);
 out_unmap_sg:
-	ib_dma_unmap_sg(dev, sg, sg_cnt, dir);
+	rdma_rw_unmap_sg(dev, sg, sg_cnt, dir);
 	return ret;
 }
 EXPORT_SYMBOL(rdma_rw_ctx_signature_init);
@@ -588,11 +602,7 @@ void rdma_rw_ctx_destroy(struct rdma_rw_ctx *ctx, struct ib_qp *qp, u8 port_num,
 		break;
 	}
 
-	if (is_pci_p2pdma_page(sg_page(sg)))
-		pci_p2pdma_unmap_sg(qp->pd->device->dma_device, sg,
-				    sg_cnt, dir);
-	else
-		ib_dma_unmap_sg(qp->pd->device, sg, sg_cnt, dir);
+	rdma_rw_unmap_sg(qp->pd->device, sg, sg_cnt, dir);
 }
 EXPORT_SYMBOL(rdma_rw_ctx_destroy);
 
@@ -619,9 +629,9 @@ void rdma_rw_ctx_destroy_signature(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 	ib_mr_pool_put(qp, &qp->sig_mrs, ctx->reg->mr);
 	kfree(ctx->reg);
 
-	ib_dma_unmap_sg(qp->pd->device, sg, sg_cnt, dir);
 	if (prot_sg_cnt)
-		ib_dma_unmap_sg(qp->pd->device, prot_sg, prot_sg_cnt, dir);
+		rdma_rw_unmap_sg(qp->pd->device, prot_sg, prot_sg_cnt, dir);
+	rdma_rw_unmap_sg(qp->pd->device, sg, sg_cnt, dir);
 }
 EXPORT_SYMBOL(rdma_rw_ctx_destroy_signature);
 
-- 
1.8.3.1

