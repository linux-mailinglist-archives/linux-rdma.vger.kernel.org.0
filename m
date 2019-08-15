Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEABF8EA91
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Aug 2019 13:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbfHOLrJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 15 Aug 2019 07:47:09 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33752 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfHOLrJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 15 Aug 2019 07:47:09 -0400
Received: by mail-pg1-f196.google.com with SMTP id n190so1220426pgn.0
        for <linux-rdma@vger.kernel.org>; Thu, 15 Aug 2019 04:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=+5vF8n7SxP1az+SCvmhumg0EOXYcHdTCSxgtSCl2x20=;
        b=On4+6rYRl+nNZ/+oqqf5wdOgFQHMAGVLlzoFpgCU1rfkz0B/Tu0TJ/p6yTkyQHM33z
         5GW9EFi/FlRDpJvcGRq4S9aDYLtzXsIPLIzv4c+1pNAGkD3ZTy1JguqBWcOdTRD07vP9
         QGQtieyRYY3fe3CBAevz+0CoJWW4IQgIAm8vI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+5vF8n7SxP1az+SCvmhumg0EOXYcHdTCSxgtSCl2x20=;
        b=cfW977mN0LcrfEB+9rCRQviTR6dwqxrlex0Djm+j4BBpJUVu60yWucKqlOmdyUtmVm
         BPqIhe0IA8x9yfJAEHYF+TadjhYdGnoc8SigPuLulcmK4zciIUgh+aNdOphRciV1gOF/
         5oxi2KX9WTJzd+os4cCQj2TbioK0Yuh0ixLvE1krAwV0WFeI1yvQfVFmycHq/Tc8itX3
         MNvnxGMv3jQhU6SB6k69dG90Z9bu2cOSf9OyElJ6D30PmsWTR5gDYd8mOPkccIw4T1dw
         M59GFwl1kOL1/ooLTOZtjz8daDXf1os59gslDFXCVMghIN0YJ/R2zoClOHixK9ulDL2S
         Aa2A==
X-Gm-Message-State: APjAAAVaxJwe53HYyPg/fC0XVj0t2zbeqPT+qqRGUAV84dTx6tRjjL6Y
        9kJAnDpLtdZf9+6Kbi08RpodsqOxCN4JtQ==
X-Google-Smtp-Source: APXvYqzIx8Nbv74mHU3zC/OOK3E5y0IPkZ7M/ACh5TW5Xtjge4Qcq5m9QFD5eY4cwXsCeoFdvLPizg==
X-Received: by 2002:a62:f245:: with SMTP id y5mr5010722pfl.156.1565869628205;
        Thu, 15 Aug 2019 04:47:08 -0700 (PDT)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id p90sm1611058pjp.7.2019.08.15.04.47.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Aug 2019 04:47:07 -0700 (PDT)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-rc] RDMA/bnxt_re: Fix stack-out-of-bounds in bnxt_qplib_rcfw_send_message
Date:   Thu, 15 Aug 2019 04:44:37 -0700
Message-Id: <1565869477-19306-1-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Driver copies FW commands to the HW queue as  multiple of 16 bytes. Some
of the command structures are not exact multiple of 16. So while copying
the data from those structures, the stack out of bounds messages are
reported by KASAN. The following error is reported.

[ 1337.530155] ==================================================================
[ 1337.530277] BUG: KASAN: stack-out-of-bounds in bnxt_qplib_rcfw_send_message+0x40a/0x850 [bnxt_re]
[ 1337.530413] Read of size 16 at addr ffff888725477a48 by task rmmod/2785

[ 1337.530540] CPU: 5 PID: 2785 Comm: rmmod Tainted: G           OE     5.2.0-rc6+ #75
[ 1337.530541] Hardware name: Dell Inc. PowerEdge R730/0599V5, BIOS 1.0.4 08/28/2014
[ 1337.530542] Call Trace:
[ 1337.530548]  dump_stack+0x5b/0x90
[ 1337.530556]  ? bnxt_qplib_rcfw_send_message+0x40a/0x850 [bnxt_re]
[ 1337.530560]  print_address_description+0x65/0x22e
[ 1337.530568]  ? bnxt_qplib_rcfw_send_message+0x40a/0x850 [bnxt_re]
[ 1337.530575]  ? bnxt_qplib_rcfw_send_message+0x40a/0x850 [bnxt_re]
[ 1337.530577]  __kasan_report.cold.3+0x37/0x77
[ 1337.530581]  ? _raw_write_trylock+0x10/0xe0
[ 1337.530588]  ? bnxt_qplib_rcfw_send_message+0x40a/0x850 [bnxt_re]
[ 1337.530590]  kasan_report+0xe/0x20
[ 1337.530592]  memcpy+0x1f/0x50
[ 1337.530600]  bnxt_qplib_rcfw_send_message+0x40a/0x850 [bnxt_re]
[ 1337.530608]  ? bnxt_qplib_creq_irq+0xa0/0xa0 [bnxt_re]
[ 1337.530611]  ? xas_create+0x3aa/0x5f0
[ 1337.530613]  ? xas_start+0x77/0x110
[ 1337.530615]  ? xas_clear_mark+0x34/0xd0
[ 1337.530623]  bnxt_qplib_free_mrw+0x104/0x1a0 [bnxt_re]
[ 1337.530631]  ? bnxt_qplib_destroy_ah+0x110/0x110 [bnxt_re]
[ 1337.530633]  ? bit_wait_io_timeout+0xc0/0xc0
[ 1337.530641]  bnxt_re_dealloc_mw+0x2c/0x60 [bnxt_re]
[ 1337.530648]  bnxt_re_destroy_fence_mr+0x77/0x1d0 [bnxt_re]
[ 1337.530655]  bnxt_re_dealloc_pd+0x25/0x60 [bnxt_re]
[ 1337.530677]  ib_dealloc_pd_user+0xbe/0xe0 [ib_core]
[ 1337.530683]  srpt_remove_one+0x5de/0x690 [ib_srpt]
[ 1337.530689]  ? __srpt_close_all_ch+0xc0/0xc0 [ib_srpt]
[ 1337.530692]  ? xa_load+0x87/0xe0
...
[ 1337.530840]  do_syscall_64+0x6d/0x1f0
[ 1337.530843]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 1337.530845] RIP: 0033:0x7ff5b389035b
[ 1337.530848] Code: 73 01 c3 48 8b 0d 2d 0b 2c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d fd 0a 2c 00 f7 d8 64 89 01 48
[ 1337.530849] RSP: 002b:00007fff83425c28 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
[ 1337.530852] RAX: ffffffffffffffda RBX: 00005596443e6750 RCX: 00007ff5b389035b
[ 1337.530853] RDX: 000000000000000a RSI: 0000000000000800 RDI: 00005596443e67b8
[ 1337.530854] RBP: 0000000000000000 R08: 00007fff83424ba1 R09: 0000000000000000
[ 1337.530856] R10: 00007ff5b3902960 R11: 0000000000000206 R12: 00007fff83425e50
[ 1337.530857] R13: 00007fff8342673c R14: 00005596443e6260 R15: 00005596443e6750

[ 1337.530885] The buggy address belongs to the page:
[ 1337.530962] page:ffffea001c951dc0 refcount:0 mapcount:0 mapping:0000000000000000 index:0x0
[ 1337.530964] flags: 0x57ffffc0000000()
[ 1337.530967] raw: 0057ffffc0000000 0000000000000000 ffffffff1c950101 0000000000000000
[ 1337.530970] raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
[ 1337.530970] page dumped because: kasan: bad access detected

[ 1337.530996] Memory state around the buggy address:
[ 1337.531072]  ffff888725477900: 00 00 00 00 f1 f1 f1 f1 00 00 00 00 00 f2 f2 f2
[ 1337.531180]  ffff888725477980: 00 00 00 00 00 00 00 00 00 00 00 f1 f1 f1 f1 00
[ 1337.531288] >ffff888725477a00: 00 f2 f2 f2 f2 f2 f2 00 00 00 f2 00 00 00 00 00
[ 1337.531393]                                                  ^
[ 1337.531478]  ffff888725477a80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[ 1337.531585]  ffff888725477b00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[ 1337.531691] ==================================================================

Fix this by passing the exact size of each FW command to
bnxt_qplib_rcfw_send_message.

Fixes: 1ac5a4047975 ("RDMA/bnxt_re: Add bnxt_re RoCE driver")
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_fp.c   | 21 +++++++++---------
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 12 ++++++-----
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h |  2 +-
 drivers/infiniband/hw/bnxt_re/qplib_sp.c   | 34 +++++++++++++++++-------------
 4 files changed, 38 insertions(+), 31 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index 958c1ff..ea03c0d 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -522,7 +522,8 @@ void bnxt_qplib_destroy_srq(struct bnxt_qplib_res *res,
 	req.srq_cid = cpu_to_le32(srq->id);
 
 	rc = bnxt_qplib_rcfw_send_message(rcfw, (struct cmdq_base *)&req,
-					  (struct creq_base *)&resp, NULL, 0);
+					  (struct creq_base *)&resp,
+					  sizeof(req), NULL, 0);
 	kfree(srq->swq);
 	if (rc)
 		return;
@@ -583,7 +584,7 @@ int bnxt_qplib_create_srq(struct bnxt_qplib_res *res,
 	req.eventq_id = cpu_to_le16(srq->eventq_hw_ring_id);
 
 	rc = bnxt_qplib_rcfw_send_message(rcfw, (void *)&req,
-					  (void *)&resp, NULL, 0);
+					  (void *)&resp, sizeof(req), NULL, 0);
 	if (rc)
 		goto fail;
 
@@ -650,7 +651,7 @@ int bnxt_qplib_query_srq(struct bnxt_qplib_res *res,
 		return -ENOMEM;
 	sb = sbuf->sb;
 	rc = bnxt_qplib_rcfw_send_message(rcfw, (void *)&req, (void *)&resp,
-					  (void *)sbuf, 0);
+					  sizeof(req), (void *)sbuf, 0);
 	srq->threshold = le16_to_cpu(sb->srq_limit);
 	bnxt_qplib_rcfw_free_sbuf(rcfw, sbuf);
 
@@ -834,7 +835,7 @@ int bnxt_qplib_create_qp1(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	req.pd_id = cpu_to_le32(qp->pd->id);
 
 	rc = bnxt_qplib_rcfw_send_message(rcfw, (void *)&req,
-					  (void *)&resp, NULL, 0);
+					  (void *)&resp, sizeof(req), NULL, 0);
 	if (rc)
 		goto fail;
 
@@ -1058,7 +1059,7 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	req.pd_id = cpu_to_le32(qp->pd->id);
 
 	rc = bnxt_qplib_rcfw_send_message(rcfw, (void *)&req,
-					  (void *)&resp, NULL, 0);
+					  (void *)&resp, sizeof(req), NULL, 0);
 	if (rc)
 		goto fail;
 
@@ -1278,7 +1279,7 @@ int bnxt_qplib_modify_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	req.vlan_pcp_vlan_dei_vlan_id = cpu_to_le16(qp->vlan_id);
 
 	rc = bnxt_qplib_rcfw_send_message(rcfw, (void *)&req,
-					  (void *)&resp, NULL, 0);
+					  (void *)&resp, sizeof(req), NULL, 0);
 	if (rc)
 		return rc;
 	qp->cur_qp_state = qp->state;
@@ -1306,7 +1307,7 @@ int bnxt_qplib_query_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	req.qp_cid = cpu_to_le32(qp->id);
 	req.resp_size = sizeof(*sb) / BNXT_QPLIB_CMDQE_UNITS;
 	rc = bnxt_qplib_rcfw_send_message(rcfw, (void *)&req, (void *)&resp,
-					  (void *)sbuf, 0);
+					  sizeof(req), (void *)sbuf, 0);
 	if (rc)
 		goto bail;
 	/* Extract the context from the side buffer */
@@ -1426,7 +1427,7 @@ int bnxt_qplib_destroy_qp(struct bnxt_qplib_res *res,
 
 	req.qp_cid = cpu_to_le32(qp->id);
 	rc = bnxt_qplib_rcfw_send_message(rcfw, (void *)&req,
-					  (void *)&resp, NULL, 0);
+					  (void *)&resp, sizeof(req), NULL, 0);
 	if (rc) {
 		rcfw->qp_tbl[qp->id].qp_id = qp->id;
 		rcfw->qp_tbl[qp->id].qp_handle = qp;
@@ -1971,7 +1972,7 @@ int bnxt_qplib_create_cq(struct bnxt_qplib_res *res, struct bnxt_qplib_cq *cq)
 			 CMDQ_CREATE_CQ_CNQ_ID_SFT);
 
 	rc = bnxt_qplib_rcfw_send_message(rcfw, (void *)&req,
-					  (void *)&resp, NULL, 0);
+					  (void *)&resp, sizeof(req), NULL, 0);
 	if (rc)
 		goto fail;
 
@@ -2005,7 +2006,7 @@ int bnxt_qplib_destroy_cq(struct bnxt_qplib_res *res, struct bnxt_qplib_cq *cq)
 
 	req.cq_cid = cpu_to_le32(cq->id);
 	rc = bnxt_qplib_rcfw_send_message(rcfw, (void *)&req,
-					  (void *)&resp, NULL, 0);
+					  (void *)&resp, sizeof(req), NULL, 0);
 	if (rc)
 		return rc;
 	bnxt_qplib_free_hwq(res->pdev, &cq->hwq);
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index 48b04d2..32c259e 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -82,7 +82,8 @@ static int __block_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie)
 };
 
 static int __send_message(struct bnxt_qplib_rcfw *rcfw, struct cmdq_base *req,
-			  struct creq_base *resp, void *sb, u8 is_block)
+			  struct creq_base *resp, u32 req_size,
+			  void *sb, u8 is_block)
 {
 	struct bnxt_qplib_cmdqe *cmdqe, **cmdq_ptr;
 	struct bnxt_qplib_hwq *cmdq = &rcfw->cmdq;
@@ -150,7 +151,7 @@ static int __send_message(struct bnxt_qplib_rcfw *rcfw, struct cmdq_base *req,
 
 	cmdq_ptr = (struct bnxt_qplib_cmdqe **)cmdq->pbl_ptr;
 	preq = (u8 *)req;
-	size = req->cmd_size * BNXT_QPLIB_CMDQE_UNITS;
+	size = req_size;
 	do {
 		/* Locate the next cmdq slot */
 		sw_prod = HWQ_CMP(cmdq->prod, cmdq);
@@ -198,6 +199,7 @@ static int __send_message(struct bnxt_qplib_rcfw *rcfw, struct cmdq_base *req,
 int bnxt_qplib_rcfw_send_message(struct bnxt_qplib_rcfw *rcfw,
 				 struct cmdq_base *req,
 				 struct creq_base *resp,
+				 u32 req_size,
 				 void *sb, u8 is_block)
 {
 	struct creq_qp_event *evnt = (struct creq_qp_event *)resp;
@@ -207,7 +209,7 @@ int bnxt_qplib_rcfw_send_message(struct bnxt_qplib_rcfw *rcfw,
 
 	do {
 		opcode = req->opcode;
-		rc = __send_message(rcfw, req, resp, sb, is_block);
+		rc = __send_message(rcfw, req, resp, req_size, sb, is_block);
 		cookie = le16_to_cpu(req->cookie) & RCFW_MAX_COOKIE_VALUE;
 		if (!rc)
 			break;
@@ -442,7 +444,7 @@ int bnxt_qplib_deinit_rcfw(struct bnxt_qplib_rcfw *rcfw)
 
 	RCFW_CMD_PREP(req, DEINITIALIZE_FW, cmd_flags);
 	rc = bnxt_qplib_rcfw_send_message(rcfw, (void *)&req, (void *)&resp,
-					  NULL, 0);
+					  sizeof(req), NULL, 0);
 	if (rc)
 		return rc;
 
@@ -543,7 +545,7 @@ int bnxt_qplib_init_rcfw(struct bnxt_qplib_rcfw *rcfw,
 skip_ctx_setup:
 	req.stat_ctx_id = cpu_to_le32(ctx->stats.fw_id);
 	rc = bnxt_qplib_rcfw_send_message(rcfw, (void *)&req, (void *)&resp,
-					  NULL, 0);
+					  sizeof(req), NULL, 0);
 	if (rc)
 		return rc;
 	set_bit(FIRMWARE_INITIALIZED_FLAG, &rcfw->flags);
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
index 2138533..ea5144f 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
@@ -285,7 +285,7 @@ void bnxt_qplib_rcfw_free_sbuf(struct bnxt_qplib_rcfw *rcfw,
 			       struct bnxt_qplib_rcfw_sbuf *sbuf);
 int bnxt_qplib_rcfw_send_message(struct bnxt_qplib_rcfw *rcfw,
 				 struct cmdq_base *req, struct creq_base *resp,
-				 void *sbuf, u8 is_block);
+				 u32 req_size, void *sbuf, u8 is_block);
 
 int bnxt_qplib_deinit_rcfw(struct bnxt_qplib_rcfw *rcfw);
 int bnxt_qplib_init_rcfw(struct bnxt_qplib_rcfw *rcfw,
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.c b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
index 40296b9..0d89334 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
@@ -65,7 +65,7 @@ static void bnxt_qplib_query_version(struct bnxt_qplib_rcfw *rcfw,
 	RCFW_CMD_PREP(req, QUERY_VERSION, cmd_flags);
 
 	rc = bnxt_qplib_rcfw_send_message(rcfw, (void *)&req,
-					  (void *)&resp, NULL, 0);
+					  (void *)&resp, sizeof(req), NULL, 0);
 	if (rc)
 		return;
 	fw_ver[0] = resp.fw_maj;
@@ -98,7 +98,7 @@ int bnxt_qplib_get_dev_attr(struct bnxt_qplib_rcfw *rcfw,
 	sb = sbuf->sb;
 	req.resp_size = sizeof(*sb) / BNXT_QPLIB_CMDQE_UNITS;
 	rc = bnxt_qplib_rcfw_send_message(rcfw, (void *)&req, (void *)&resp,
-					  (void *)sbuf, 0);
+					  sizeof(req), (void *)sbuf, 0);
 	if (rc)
 		goto bail;
 
@@ -194,7 +194,7 @@ int bnxt_qplib_set_func_resources(struct bnxt_qplib_res *res,
 	req.max_gid_per_vf = cpu_to_le32(ctx->vf_res.max_gid_per_vf);
 
 	rc = bnxt_qplib_rcfw_send_message(rcfw, (void *)&req,
-					  (void *)&resp,
+					  (void *)&resp, sizeof(req),
 					  NULL, 0);
 	if (rc) {
 		dev_err(&res->pdev->dev, "Failed to set function resources\n");
@@ -259,7 +259,8 @@ int bnxt_qplib_del_sgid(struct bnxt_qplib_sgid_tbl *sgid_tbl,
 		}
 		req.gid_index = cpu_to_le16(sgid_tbl->hw_id[index]);
 		rc = bnxt_qplib_rcfw_send_message(rcfw, (void *)&req,
-						  (void *)&resp, NULL, 0);
+						  (void *)&resp,
+						  sizeof(req), NULL, 0);
 		if (rc)
 			return rc;
 	}
@@ -347,7 +348,8 @@ int bnxt_qplib_add_sgid(struct bnxt_qplib_sgid_tbl *sgid_tbl,
 		req.src_mac[2] = cpu_to_be16(((u16 *)smac)[2]);
 
 		rc = bnxt_qplib_rcfw_send_message(rcfw, (void *)&req,
-						  (void *)&resp, NULL, 0);
+						  (void *)&resp, sizeof(req),
+						  NULL, 0);
 		if (rc)
 			return rc;
 		sgid_tbl->hw_id[free_idx] = le32_to_cpu(resp.xid);
@@ -401,7 +403,7 @@ int bnxt_qplib_update_sgid(struct bnxt_qplib_sgid_tbl *sgid_tbl,
 	req.gid_index = cpu_to_le16(gid_idx);
 
 	rc = bnxt_qplib_rcfw_send_message(rcfw, (void *)&req,
-					  (void *)&resp, NULL, 0);
+					  (void *)&resp, sizeof(req), NULL, 0);
 	return rc;
 }
 
@@ -528,7 +530,7 @@ int bnxt_qplib_create_ah(struct bnxt_qplib_res *res, struct bnxt_qplib_ah *ah,
 	req.dest_mac[2] = cpu_to_le16(temp16[2]);
 
 	rc = bnxt_qplib_rcfw_send_message(rcfw, (void *)&req, (void *)&resp,
-					  NULL, block);
+					  sizeof(req), NULL, block);
 	if (rc)
 		return rc;
 
@@ -549,8 +551,8 @@ void bnxt_qplib_destroy_ah(struct bnxt_qplib_res *res, struct bnxt_qplib_ah *ah,
 
 	req.ah_cid = cpu_to_le32(ah->id);
 
-	bnxt_qplib_rcfw_send_message(rcfw, (void *)&req, (void *)&resp, NULL,
-				     block);
+	bnxt_qplib_rcfw_send_message(rcfw, (void *)&req, (void *)&resp,
+				     sizeof(req), NULL, block);
 }
 
 /* MRW */
@@ -579,7 +581,7 @@ int bnxt_qplib_free_mrw(struct bnxt_qplib_res *res, struct bnxt_qplib_mrw *mrw)
 		req.key = cpu_to_le32(mrw->lkey);
 
 	rc = bnxt_qplib_rcfw_send_message(rcfw, (void *)&req, (void *)&resp,
-					  NULL, 0);
+					  sizeof(req), NULL, 0);
 	if (rc)
 		return rc;
 
@@ -612,7 +614,7 @@ int bnxt_qplib_alloc_mrw(struct bnxt_qplib_res *res, struct bnxt_qplib_mrw *mrw)
 	req.mrw_handle = cpu_to_le64(tmp);
 
 	rc = bnxt_qplib_rcfw_send_message(rcfw, (void *)&req,
-					  (void *)&resp, NULL, 0);
+					  (void *)&resp, sizeof(req), NULL, 0);
 	if (rc)
 		return rc;
 
@@ -638,7 +640,8 @@ int bnxt_qplib_dereg_mrw(struct bnxt_qplib_res *res, struct bnxt_qplib_mrw *mrw,
 
 	req.lkey = cpu_to_le32(mrw->lkey);
 	rc = bnxt_qplib_rcfw_send_message(rcfw, (void *)&req,
-					  (void *)&resp, NULL, block);
+					  (void *)&resp, sizeof(req),
+					  NULL, block);
 	if (rc)
 		return rc;
 
@@ -726,7 +729,8 @@ int bnxt_qplib_reg_mr(struct bnxt_qplib_res *res, struct bnxt_qplib_mrw *mr,
 	req.mr_size = cpu_to_le64(mr->total_size);
 
 	rc = bnxt_qplib_rcfw_send_message(rcfw, (void *)&req,
-					  (void *)&resp, NULL, block);
+					  (void *)&resp, sizeof(req),
+					  NULL, block);
 	if (rc)
 		goto fail;
 
@@ -782,7 +786,7 @@ int bnxt_qplib_map_tc2cos(struct bnxt_qplib_res *res, u16 *cids)
 	req.cos1 = cpu_to_le16(cids[1]);
 
 	return bnxt_qplib_rcfw_send_message(rcfw, (void *)&req, (void *)&resp,
-						NULL, 0);
+					    sizeof(req), NULL, 0);
 }
 
 int bnxt_qplib_get_roce_stats(struct bnxt_qplib_rcfw *rcfw,
@@ -807,7 +811,7 @@ int bnxt_qplib_get_roce_stats(struct bnxt_qplib_rcfw *rcfw,
 	sb = sbuf->sb;
 	req.resp_size = sizeof(*sb) / BNXT_QPLIB_CMDQE_UNITS;
 	rc = bnxt_qplib_rcfw_send_message(rcfw, (void *)&req, (void *)&resp,
-					  (void *)sbuf, 0);
+					  sizeof(req), (void *)sbuf, 0);
 	if (rc)
 		goto bail;
 	/* Extract the context from the side buffer */
-- 
2.5.5

