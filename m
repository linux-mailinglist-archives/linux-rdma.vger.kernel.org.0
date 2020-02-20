Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB72165B24
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2020 11:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgBTKIZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Feb 2020 05:08:25 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:54708 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726501AbgBTKIZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Feb 2020 05:08:25 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from maxg@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 20 Feb 2020 12:08:20 +0200
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx [10.209.102.136])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 01KA8J3o011773;
        Thu, 20 Feb 2020 12:08:19 +0200
From:   Max Gurtovoy <maxg@mellanox.com>
To:     jgg@mellanox.com, leon@kernel.org, linux-rdma@vger.kernel.org
Cc:     israelr@mellanox.com, logang@deltatee.com,
        Max Gurtovoy <maxg@mellanox.com>
Subject: [PATCH v2 2/2] RDMA/rw: map P2P memory correctly for signature operations
Date:   Thu, 20 Feb 2020 12:08:19 +0200
Message-Id: <20200220100819.41860-2-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200220100819.41860-1-maxg@mellanox.com>
References: <20200220100819.41860-1-maxg@mellanox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Since RDMA rw API support operations with P2P memory sg list, make sure
to map/unmap the scatter list for signature operation correctly.

Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
---
 drivers/infiniband/core/rw.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/core/rw.c b/drivers/infiniband/core/rw.c
index 69513b484507..6eba8453f206 100644
--- a/drivers/infiniband/core/rw.c
+++ b/drivers/infiniband/core/rw.c
@@ -392,13 +392,13 @@ int rdma_rw_ctx_signature_init(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
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
@@ -467,9 +467,9 @@ int rdma_rw_ctx_signature_init(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
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
@@ -629,9 +629,9 @@ void rdma_rw_ctx_destroy_signature(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
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
2.20.1

