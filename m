Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F127E44E39D
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Nov 2021 10:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234698AbhKLJJc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Nov 2021 04:09:32 -0500
Received: from out02.smtpout.orange.fr ([193.252.22.211]:60347 "EHLO
        out.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233978AbhKLJJc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 12 Nov 2021 04:09:32 -0500
X-Greylist: delayed 451 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Nov 2021 04:09:31 EST
Received: from pop-os.home ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id lSOomwu8HwEZflSOomATNQ; Fri, 12 Nov 2021 09:59:08 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Fri, 12 Nov 2021 09:59:08 +0100
X-ME-IP: 86.243.171.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     selvin.xavier@broadcom.com, dledford@redhat.com, jgg@ziepe.ca,
        sriharsha.basavapatna@broadcom.com, eddie.wai@broadcom.com,
        somnath.kotur@broadcom.com, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] RDMA/bnxt_re: Scan the whole bitmap when checking if "disabling RCFW with pending cmd-bit"
Date:   Fri, 12 Nov 2021 09:59:04 +0100
Message-Id: <47ed717c3070a1d0f53e7b4c768a4fd11caf365d.1636707421.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The 'cmdq->cmdq_bitmap' bitmap is 'rcfw->cmdq_depth' bits long.
The size stored in 'cmdq->bmap_size' is the size of the bitmap in bytes.

Remove this erroneous 'bmap_size' and use 'rcfw->cmdq_depth' directly in
'bnxt_qplib_disable_rcfw_channel()'. Otherwise some error messages may
be missing.

Other uses of 'cmdq_bitmap' already take into account 'rcfw->cmdq_depth'
directly.

Fixes: 1ac5a4047975 ("RDMA/bnxt_re: Add bnxt_re RoCE driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 6 ++----
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h | 1 -
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index 3de854727460..19a0778d38a2 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -618,8 +618,6 @@ int bnxt_qplib_alloc_rcfw_channel(struct bnxt_qplib_res *res,
 	if (!cmdq->cmdq_bitmap)
 		goto fail;
 
-	cmdq->bmap_size = bmap_size;
-
 	/* Allocate one extra to hold the QP1 entries */
 	rcfw->qp_tbl_size = qp_tbl_sz + 1;
 	rcfw->qp_tbl = kcalloc(rcfw->qp_tbl_size, sizeof(struct bnxt_qplib_qp_node),
@@ -667,8 +665,8 @@ void bnxt_qplib_disable_rcfw_channel(struct bnxt_qplib_rcfw *rcfw)
 	iounmap(cmdq->cmdq_mbox.reg.bar_reg);
 	iounmap(creq->creq_db.reg.bar_reg);
 
-	indx = find_first_bit(cmdq->cmdq_bitmap, cmdq->bmap_size);
-	if (indx != cmdq->bmap_size)
+	indx = find_first_bit(cmdq->cmdq_bitmap, rcfw->cmdq_depth);
+	if (indx != rcfw->cmdq_depth)
 		dev_err(&rcfw->pdev->dev,
 			"disabling RCFW with pending cmd-bit %lx\n", indx);
 
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
index 82faa4e4cda8..0a3d8e7da3d4 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
@@ -152,7 +152,6 @@ struct bnxt_qplib_cmdq_ctx {
 	wait_queue_head_t		waitq;
 	unsigned long			flags;
 	unsigned long			*cmdq_bitmap;
-	u32				bmap_size;
 	u32				seq_num;
 };
 
-- 
2.30.2

