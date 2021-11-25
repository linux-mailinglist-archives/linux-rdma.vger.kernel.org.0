Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 021C345E10F
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Nov 2021 20:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351012AbhKYTj2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Nov 2021 14:39:28 -0500
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:52909 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355462AbhKYTh2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Nov 2021 14:37:28 -0500
Received: from pop-os.home ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id qKVambYFrqYovqKVamK5kJ; Thu, 25 Nov 2021 20:34:15 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Thu, 25 Nov 2021 20:34:15 +0100
X-ME-IP: 86.243.171.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     selvin.xavier@broadcom.com, dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 1/2] RDMA/ocrdma: Use bitmap_zalloc() when applicable
Date:   Thu, 25 Nov 2021 20:34:10 +0100
Message-Id: <b157f9e1586fb4d1083cb4058d7ac81b10bb86d7.1637868728.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Use 'bitmap_zalloc()' to simplify code, improve the semantic and avoid some
open-coded arithmetic in allocator arguments.

Also change the corresponding 'kfree()' into 'bitmap_free()' to keep
consistency.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/infiniband/hw/ocrdma/ocrdma_hw.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_hw.c b/drivers/infiniband/hw/ocrdma/ocrdma_hw.c
index c51c3f40700e..265a581133dc 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_hw.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_hw.c
@@ -1506,7 +1506,6 @@ int ocrdma_mbx_dealloc_pd(struct ocrdma_dev *dev, struct ocrdma_pd *pd)
 static int ocrdma_mbx_alloc_pd_range(struct ocrdma_dev *dev)
 {
 	int status = -ENOMEM;
-	size_t pd_bitmap_size;
 	struct ocrdma_alloc_pd_range *cmd;
 	struct ocrdma_alloc_pd_range_rsp *rsp;
 
@@ -1528,10 +1527,8 @@ static int ocrdma_mbx_alloc_pd_range(struct ocrdma_dev *dev)
 			dev->pd_mgr->pd_dpp_start = rsp->dpp_page_pdid &
 					OCRDMA_ALLOC_PD_RNG_RSP_START_PDID_MASK;
 			dev->pd_mgr->max_dpp_pd = rsp->pd_count;
-			pd_bitmap_size =
-				BITS_TO_LONGS(rsp->pd_count) * sizeof(long);
-			dev->pd_mgr->pd_dpp_bitmap = kzalloc(pd_bitmap_size,
-							     GFP_KERNEL);
+			dev->pd_mgr->pd_dpp_bitmap = bitmap_zalloc(rsp->pd_count,
+								   GFP_KERNEL);
 		}
 		kfree(cmd);
 	}
@@ -1547,9 +1544,8 @@ static int ocrdma_mbx_alloc_pd_range(struct ocrdma_dev *dev)
 		dev->pd_mgr->pd_norm_start = rsp->dpp_page_pdid &
 					OCRDMA_ALLOC_PD_RNG_RSP_START_PDID_MASK;
 		dev->pd_mgr->max_normal_pd = rsp->pd_count;
-		pd_bitmap_size = BITS_TO_LONGS(rsp->pd_count) * sizeof(long);
-		dev->pd_mgr->pd_norm_bitmap = kzalloc(pd_bitmap_size,
-						      GFP_KERNEL);
+		dev->pd_mgr->pd_norm_bitmap = bitmap_zalloc(rsp->pd_count,
+							    GFP_KERNEL);
 	}
 	kfree(cmd);
 
@@ -1611,8 +1607,8 @@ void ocrdma_alloc_pd_pool(struct ocrdma_dev *dev)
 static void ocrdma_free_pd_pool(struct ocrdma_dev *dev)
 {
 	ocrdma_mbx_dealloc_pd_range(dev);
-	kfree(dev->pd_mgr->pd_norm_bitmap);
-	kfree(dev->pd_mgr->pd_dpp_bitmap);
+	bitmap_free(dev->pd_mgr->pd_norm_bitmap);
+	bitmap_free(dev->pd_mgr->pd_dpp_bitmap);
 	kfree(dev->pd_mgr);
 }
 
-- 
2.30.2

