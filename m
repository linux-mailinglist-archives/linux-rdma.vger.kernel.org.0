Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4909645E1CA
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Nov 2021 21:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244587AbhKYUro (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Nov 2021 15:47:44 -0500
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:58962 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237305AbhKYUpn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Nov 2021 15:45:43 -0500
Received: from pop-os.home ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id qLZdmbwfgqYovqLZdmKCfE; Thu, 25 Nov 2021 21:42:30 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Thu, 25 Nov 2021 21:42:30 +0100
X-ME-IP: 86.243.171.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     selvin.xavier@broadcom.com, dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] RDMA/bnxt_re: Use bitmap_zalloc() when applicable
Date:   Thu, 25 Nov 2021 21:42:28 +0100
Message-Id: <5c029daf43b92fdc27926fe8a98084843437c498.1637872888.git.christophe.jaillet@wanadoo.fr>
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
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index 19a0778d38a2..061b2895dd9b 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -555,7 +555,7 @@ int bnxt_qplib_init_rcfw(struct bnxt_qplib_rcfw *rcfw,
 
 void bnxt_qplib_free_rcfw_channel(struct bnxt_qplib_rcfw *rcfw)
 {
-	kfree(rcfw->cmdq.cmdq_bitmap);
+	bitmap_free(rcfw->cmdq.cmdq_bitmap);
 	kfree(rcfw->qp_tbl);
 	kfree(rcfw->crsqe_tbl);
 	bnxt_qplib_free_hwq(rcfw->res, &rcfw->cmdq.hwq);
@@ -572,7 +572,6 @@ int bnxt_qplib_alloc_rcfw_channel(struct bnxt_qplib_res *res,
 	struct bnxt_qplib_sg_info sginfo = {};
 	struct bnxt_qplib_cmdq_ctx *cmdq;
 	struct bnxt_qplib_creq_ctx *creq;
-	u32 bmap_size = 0;
 
 	rcfw->pdev = res->pdev;
 	cmdq = &rcfw->cmdq;
@@ -613,8 +612,7 @@ int bnxt_qplib_alloc_rcfw_channel(struct bnxt_qplib_res *res,
 	if (!rcfw->crsqe_tbl)
 		goto fail;
 
-	bmap_size = BITS_TO_LONGS(rcfw->cmdq_depth) * sizeof(unsigned long);
-	cmdq->cmdq_bitmap = kzalloc(bmap_size, GFP_KERNEL);
+	cmdq->cmdq_bitmap = bitmap_zalloc(rcfw->cmdq_depth, GFP_KERNEL);
 	if (!cmdq->cmdq_bitmap)
 		goto fail;
 
-- 
2.30.2

