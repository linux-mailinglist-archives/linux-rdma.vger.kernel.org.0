Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E9F727D05
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Jun 2023 12:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235059AbjFHKiB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Jun 2023 06:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233965AbjFHKiA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Jun 2023 06:38:00 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E0A1712
        for <linux-rdma@vger.kernel.org>; Thu,  8 Jun 2023 03:37:41 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b065154b79so12087835ad.1
        for <linux-rdma@vger.kernel.org>; Thu, 08 Jun 2023 03:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1686220660; x=1688812660;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nZORGEz5YcIDqb9yaf9IaIdONJL6308EeG2LuLD1oaY=;
        b=M3+kGAvfjmjNTCVBJ8Qjpa+8wlYdYIBuFRY4l2IbyvxZ62nDD0E/Nfbw5SFmzezk9H
         xT2ZnFlkcf7aqV2XZWmNhXbjZ9eA+AvzG3VMSnYWdOfuYcexHR4OabGqjG1pm+eoyf5S
         hUXSIgPdGNGNl4+afos/2L4E2360Zbw7AquOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686220660; x=1688812660;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nZORGEz5YcIDqb9yaf9IaIdONJL6308EeG2LuLD1oaY=;
        b=PlIA60uk2bR+d8V7G2Rc2Rmhz+bkBcSeR0bVHk05EnblIGbjBMRQTsuDCb06wKPUVg
         v0T8Bh5RXxfEEJbKSWcB3EzGHZTpC2+UKwXMSzFCr8GhoBBSCOao3wVHKKNpmkz1z7vu
         evao0fC0DKFCsb54j6mHvBmjni4k3ioBejAhFcuM98QgAgCMIMmfMoIqcjQV11bpWAzF
         IlI61vcGJCXHkgXpyFC4iqiqFgbXJiRYqqv89rRAUel1yPKpnApOQZBuIF0vtTdFI+GH
         CxxAB2jOjbt6S+iHHRLV+0lxbP5/QSKcI/8WDNlhAYaVg0L/Sv1gqOPyzf38KSQV6TK6
         grxw==
X-Gm-Message-State: AC+VfDwZsOdIRCt9iV45qo6ac9YiiaUTQZLL12Eu5PAyEfKrQmTTjIlS
        CxjLHNJFhRD4ouL1PelJFobv8Q==
X-Google-Smtp-Source: ACHHUZ43RpzWnbeOjiCxvlVikNLkumsRrpuBrUsEQvDkqjkRTERutQv6FJEhd3uKWFh2VUtt7oKBRQ==
X-Received: by 2002:a17:902:ab59:b0:1aa:d235:6dd4 with SMTP id ij25-20020a170902ab5900b001aad2356dd4mr1680386plb.19.1686220660372;
        Thu, 08 Jun 2023 03:37:40 -0700 (PDT)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id jj11-20020a170903048b00b001a980a23802sm1128510plb.111.2023.06.08.03.37.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Jun 2023 03:37:39 -0700 (PDT)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next 16/17] RDMA/bnxt_re: remove redundant cmdq_bitmap
Date:   Thu,  8 Jun 2023 03:25:07 -0700
Message-Id: <1686219908-11181-17-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1686219908-11181-1-git-send-email-selvin.xavier@broadcom.com>
References: <1686219908-11181-1-git-send-email-selvin.xavier@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000080970205fd9bd75f"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        MIME_HEADER_CTYPE_ONLY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_TVD_MIME_NO_HEADERS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--00000000000080970205fd9bd75f

From: Kashyap Desai <kashyap.desai@broadcom.com>

cmdq_bitmap is used to derive the next available index in the CMDQ.
This is not required as the we can get the next index
using the existing bnxt_qplib_crsqe array.

Driver will use bnxt_qplib_crsqe array and flag is_in_used to
derive valid entries. is_in_used  is replacement of cmdq_bitmap.
There is no change in the existing mechanism of the circular buffer
used to get index.

Added opcode field in bnxt_qplib_crsqe array so that it is easy to map
opcode associated with pending rcfw command.

Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 81 ++++++++++++------------------
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h |  3 +-
 2 files changed, 35 insertions(+), 49 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index 8d08715..45bbf5f 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -95,6 +95,7 @@ static int bnxt_qplib_map_rc(u8 opcode)
  * @cookie    -   cookie to track the command
  * @opcode    -   rcfw submitted for given opcode
  * @cbit      -   bitmap entry of cookie
+ * @in_used   -   command is in used or freed
  *
  * If firmware has not responded any rcfw command within
  * rcfw->max_timeout, consider firmware as stalled.
@@ -104,7 +105,7 @@ static int bnxt_qplib_map_rc(u8 opcode)
  * -ENODEV if firmware is not responding
  */
 static int bnxt_re_is_fw_stalled(struct bnxt_qplib_rcfw *rcfw,
-				 u16 cookie, u8 opcode, u16 cbit)
+				 u16 cookie, u8 opcode, bool in_used)
 {
 	struct bnxt_qplib_cmdq_ctx *cmdq;
 
@@ -117,7 +118,7 @@ static int bnxt_re_is_fw_stalled(struct bnxt_qplib_rcfw *rcfw,
 				     __func__, cookie, opcode,
 				     jiffies_to_msecs(jiffies - cmdq->last_seen),
 				     rcfw->max_timeout * 1000,
-				     test_bit(cbit, cmdq->cmdq_bitmap));
+				     in_used);
 		return -ENODEV;
 	}
 
@@ -139,11 +140,11 @@ static int bnxt_re_is_fw_stalled(struct bnxt_qplib_rcfw *rcfw,
 static int __wait_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie, u8 opcode)
 {
 	struct bnxt_qplib_cmdq_ctx *cmdq;
-	u16 cbit;
+	struct bnxt_qplib_crsqe *crsqe;
 	int ret;
 
 	cmdq = &rcfw->cmdq;
-	cbit = cookie % rcfw->cmdq_depth;
+	crsqe = &rcfw->crsqe_tbl[cookie];
 
 	do {
 		if (test_bit(ERR_DEVICE_DETACHED, &cmdq->flags))
@@ -153,19 +154,19 @@ static int __wait_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie, u8 opcode)
 
 		/* Non zero means command completed */
 		ret = wait_event_timeout(cmdq->waitq,
-					 !test_bit(cbit, cmdq->cmdq_bitmap) ||
+					 !crsqe->is_in_used ||
 					 test_bit(ERR_DEVICE_DETACHED, &cmdq->flags),
 					 msecs_to_jiffies(rcfw->max_timeout * 1000));
 
-		if (!test_bit(cbit, cmdq->cmdq_bitmap))
+		if (!crsqe->is_in_used)
 			return 0;
 
 		bnxt_qplib_service_creq(&rcfw->creq.creq_tasklet);
 
-		if (!test_bit(cbit, cmdq->cmdq_bitmap))
+		if (!crsqe->is_in_used)
 			return 0;
 
-		ret = bnxt_re_is_fw_stalled(rcfw, cookie, opcode, cbit);
+		ret = bnxt_re_is_fw_stalled(rcfw, cookie, opcode, crsqe->is_in_used);
 		if (ret)
 			return ret;
 
@@ -188,11 +189,11 @@ static int __wait_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie, u8 opcode)
 static int __block_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie, u8 opcode)
 {
 	struct bnxt_qplib_cmdq_ctx *cmdq = &rcfw->cmdq;
+	struct bnxt_qplib_crsqe *crsqe;
 	unsigned long issue_time = 0;
-	u16 cbit;
 
-	cbit = cookie % rcfw->cmdq_depth;
 	issue_time = jiffies;
+	crsqe = &rcfw->crsqe_tbl[cookie];
 
 	do {
 		if (test_bit(ERR_DEVICE_DETACHED, &cmdq->flags))
@@ -203,7 +204,7 @@ static int __block_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie, u8 opcode)
 		udelay(1);
 
 		bnxt_qplib_service_creq(&rcfw->creq.creq_tasklet);
-		if (!test_bit(cbit, cmdq->cmdq_bitmap))
+		if (!crsqe->is_in_used)
 			return 0;
 
 	} while (time_before(jiffies, issue_time + (8 * HZ)));
@@ -236,16 +237,13 @@ static void __send_message_no_waiter(struct bnxt_qplib_rcfw *rcfw,
 	struct bnxt_qplib_crsqe *crsqe;
 	struct bnxt_qplib_cmdqe *cmdqe;
 	u32 sw_prod, cmdq_prod;
-	u16 cookie, cbit;
+	u16 cookie;
 	u32 bsize;
 	u8 *preq;
 
 	cookie = cmdq->seq_num & RCFW_MAX_COOKIE_VALUE;
-	cbit = cookie % rcfw->cmdq_depth;
-
-	set_bit(cbit, cmdq->cmdq_bitmap);
 	__set_cmdq_base_cookie(msg->req, msg->req_sz, cpu_to_le16(cookie));
-	crsqe = &rcfw->crsqe_tbl[cbit];
+	crsqe = &rcfw->crsqe_tbl[cookie];
 
 	/* Set cmd_size in terms of 16B slots in req. */
 	bsize = bnxt_qplib_set_cmd_slots(msg->req);
@@ -254,6 +252,7 @@ static void __send_message_no_waiter(struct bnxt_qplib_rcfw *rcfw,
 	 */
 	crsqe->is_internal_cmd = true;
 	crsqe->is_waiter_alive = false;
+	crsqe->is_in_used = true;
 	crsqe->req_size = __get_cmdq_base_cmd_size(msg->req, msg->req_sz);
 
 	preq = (u8 *)msg->req;
@@ -281,7 +280,7 @@ static void __send_message_no_waiter(struct bnxt_qplib_rcfw *rcfw,
 static int __send_message(struct bnxt_qplib_rcfw *rcfw,
 			  struct bnxt_qplib_cmdqmsg *msg)
 {
-	u32 bsize, opcode, free_slots, required_slots;
+	u32 bsize, free_slots, required_slots;
 	struct bnxt_qplib_cmdq_ctx *cmdq;
 	struct bnxt_qplib_crsqe *crsqe;
 	struct bnxt_qplib_cmdqe *cmdqe;
@@ -289,7 +288,8 @@ static int __send_message(struct bnxt_qplib_rcfw *rcfw,
 	u32 sw_prod, cmdq_prod;
 	struct pci_dev *pdev;
 	unsigned long flags;
-	u16 cookie, cbit;
+	u16 cookie;
+	u8 opcode;
 	u8 *preq;
 
 	cmdq = &rcfw->cmdq;
@@ -305,10 +305,9 @@ static int __send_message(struct bnxt_qplib_rcfw *rcfw,
 	required_slots = bnxt_qplib_get_cmd_slots(msg->req);
 	free_slots = HWQ_FREE_SLOTS(hwq);
 	cookie = cmdq->seq_num & RCFW_MAX_COOKIE_VALUE;
-	cbit = cookie % rcfw->cmdq_depth;
+	crsqe = &rcfw->crsqe_tbl[cookie];
 
-	if (required_slots >= free_slots ||
-	    test_bit(cbit, cmdq->cmdq_bitmap)) {
+	if (required_slots >= free_slots) {
 		dev_info_ratelimited(&pdev->dev,
 				     "CMDQ is full req/free %d/%d!",
 				     required_slots, free_slots);
@@ -317,15 +316,17 @@ static int __send_message(struct bnxt_qplib_rcfw *rcfw,
 	}
 	if (msg->block)
 		cookie |= RCFW_CMD_IS_BLOCKING;
-	set_bit(cbit, cmdq->cmdq_bitmap);
 	__set_cmdq_base_cookie(msg->req, msg->req_sz, cpu_to_le16(cookie));
-	crsqe = &rcfw->crsqe_tbl[cbit];
+
 	bsize = bnxt_qplib_set_cmd_slots(msg->req);
 	crsqe->free_slots = free_slots;
 	crsqe->resp = (struct creq_qp_event *)msg->resp;
 	crsqe->resp->cookie = cpu_to_le16(cookie);
 	crsqe->is_internal_cmd = false;
 	crsqe->is_waiter_alive = true;
+	crsqe->is_in_used = true;
+	crsqe->opcode = opcode;
+
 	crsqe->req_size = __get_cmdq_base_cmd_size(msg->req, msg->req_sz);
 	if (__get_cmdq_base_resp_size(msg->req, msg->req_sz) && msg->sb) {
 		struct bnxt_qplib_rcfw_sbuf *sbuf = msg->sb;
@@ -388,12 +389,12 @@ static int __poll_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie,
 			   u8 opcode)
 {
 	struct bnxt_qplib_cmdq_ctx *cmdq = &rcfw->cmdq;
+	struct bnxt_qplib_crsqe *crsqe;
 	unsigned long issue_time;
-	u16 cbit;
 	int ret;
 
-	cbit = cookie % rcfw->cmdq_depth;
 	issue_time = jiffies;
+	crsqe = &rcfw->crsqe_tbl[cookie];
 
 	do {
 		if (test_bit(ERR_DEVICE_DETACHED, &cmdq->flags))
@@ -404,11 +405,11 @@ static int __poll_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie,
 		usleep_range(1000, 1001);
 
 		bnxt_qplib_service_creq(&rcfw->creq.creq_tasklet);
-		if (!test_bit(cbit, cmdq->cmdq_bitmap))
+		if (!crsqe->is_in_used)
 			return 0;
 		if (jiffies_to_msecs(jiffies - issue_time) >
 		    (rcfw->max_timeout * 1000)) {
-			ret = bnxt_re_is_fw_stalled(rcfw, cookie, opcode, cbit);
+			ret = bnxt_re_is_fw_stalled(rcfw, cookie, opcode, crsqe->is_in_used);
 			if (ret)
 				return ret;
 		}
@@ -488,7 +489,7 @@ static int __bnxt_qplib_rcfw_send_message(struct bnxt_qplib_rcfw *rcfw,
 	struct creq_qp_event *evnt = (struct creq_qp_event *)msg->resp;
 	struct bnxt_qplib_crsqe *crsqe;
 	unsigned long flags;
-	u16 cookie, cbit;
+	u16 cookie;
 	int rc = 0;
 	u8 opcode;
 
@@ -504,7 +505,6 @@ static int __bnxt_qplib_rcfw_send_message(struct bnxt_qplib_rcfw *rcfw,
 
 	cookie = le16_to_cpu(__get_cmdq_base_cookie(msg->req, msg->req_sz))
 				& RCFW_MAX_COOKIE_VALUE;
-	cbit = cookie % rcfw->cmdq_depth;
 
 	if (msg->block)
 		rc = __block_for_resp(rcfw, cookie, opcode);
@@ -521,7 +521,7 @@ static int __bnxt_qplib_rcfw_send_message(struct bnxt_qplib_rcfw *rcfw,
 
 	if (rc) {
 		spin_lock_irqsave(&rcfw->cmdq.hwq.lock, flags);
-		crsqe = &rcfw->crsqe_tbl[cbit];
+		crsqe = &rcfw->crsqe_tbl[cookie];
 		crsqe->is_waiter_alive = false;
 		if (rc == -ENODEV)
 			set_bit(FIRMWARE_STALL_DETECTED, &rcfw->cmdq.flags);
@@ -633,13 +633,12 @@ static int bnxt_qplib_process_qp_event(struct bnxt_qplib_rcfw *rcfw,
 	struct bnxt_qplib_crsqe *crsqe;
 	u32 qp_id, tbl_indx, req_size;
 	struct bnxt_qplib_qp *qp;
-	u16 cbit, blocked = 0;
+	u16 cookie, blocked = 0;
 	bool is_waiter_alive;
 	struct pci_dev *pdev;
 	unsigned long flags;
 	u32 wait_cmds = 0;
 	__le16  mcookie;
-	u16 cookie;
 	int rc = 0;
 
 	pdev = rcfw->pdev;
@@ -675,8 +674,8 @@ static int bnxt_qplib_process_qp_event(struct bnxt_qplib_rcfw *rcfw,
 		mcookie = qp_event->cookie;
 		blocked = cookie & RCFW_CMD_IS_BLOCKING;
 		cookie &= RCFW_MAX_COOKIE_VALUE;
-		cbit = cookie % rcfw->cmdq_depth;
-		crsqe = &rcfw->crsqe_tbl[cbit];
+		crsqe = &rcfw->crsqe_tbl[cookie];
+		crsqe->is_in_used = false;
 
 		if (WARN_ONCE(test_bit(FIRMWARE_STALL_DETECTED,
 				       &rcfw->cmdq.flags),
@@ -687,9 +686,6 @@ static int bnxt_qplib_process_qp_event(struct bnxt_qplib_rcfw *rcfw,
 			return rc;
 		}
 
-		if (!test_and_clear_bit(cbit, rcfw->cmdq.cmdq_bitmap))
-			dev_warn(&pdev->dev,
-				 "CMD bit %d was not requested\n", cbit);
 		if (crsqe->is_internal_cmd && !qp_event->status)
 			atomic_dec(&rcfw->timeout_send);
 
@@ -924,7 +920,6 @@ int bnxt_qplib_init_rcfw(struct bnxt_qplib_rcfw *rcfw,
 
 void bnxt_qplib_free_rcfw_channel(struct bnxt_qplib_rcfw *rcfw)
 {
-	bitmap_free(rcfw->cmdq.cmdq_bitmap);
 	kfree(rcfw->qp_tbl);
 	kfree(rcfw->crsqe_tbl);
 	bnxt_qplib_free_hwq(rcfw->res, &rcfw->cmdq.hwq);
@@ -979,10 +974,6 @@ int bnxt_qplib_alloc_rcfw_channel(struct bnxt_qplib_res *res,
 	if (!rcfw->crsqe_tbl)
 		goto fail;
 
-	cmdq->cmdq_bitmap = bitmap_zalloc(rcfw->cmdq_depth, GFP_KERNEL);
-	if (!cmdq->cmdq_bitmap)
-		goto fail;
-
 	/* Allocate one extra to hold the QP1 entries */
 	rcfw->qp_tbl_size = qp_tbl_sz + 1;
 	rcfw->qp_tbl = kcalloc(rcfw->qp_tbl_size, sizeof(struct bnxt_qplib_qp_node),
@@ -1027,7 +1018,6 @@ void bnxt_qplib_disable_rcfw_channel(struct bnxt_qplib_rcfw *rcfw)
 {
 	struct bnxt_qplib_creq_ctx *creq;
 	struct bnxt_qplib_cmdq_ctx *cmdq;
-	unsigned long indx;
 
 	creq = &rcfw->creq;
 	cmdq = &rcfw->cmdq;
@@ -1037,11 +1027,6 @@ void bnxt_qplib_disable_rcfw_channel(struct bnxt_qplib_rcfw *rcfw)
 	iounmap(cmdq->cmdq_mbox.reg.bar_reg);
 	iounmap(creq->creq_db.reg.bar_reg);
 
-	indx = find_first_bit(cmdq->cmdq_bitmap, rcfw->cmdq_depth);
-	if (indx != rcfw->cmdq_depth)
-		dev_err(&rcfw->pdev->dev,
-			"disabling RCFW with pending cmd-bit %lx\n", indx);
-
 	cmdq->cmdq_mbox.reg.bar_reg = NULL;
 	creq->creq_db.reg.bar_reg = NULL;
 	creq->aeq_handler = NULL;
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
index b644dcc..f46de07 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
@@ -152,8 +152,10 @@ struct bnxt_qplib_crsqe {
 	u32			req_size;
 	/* Free slots at the time of submission */
 	u32			free_slots;
+	u8			opcode;
 	bool			is_waiter_alive;
 	bool			is_internal_cmd;
+	bool			is_in_used;
 };
 
 struct bnxt_qplib_rcfw_sbuf {
@@ -185,7 +187,6 @@ struct bnxt_qplib_cmdq_ctx {
 	struct bnxt_qplib_cmdq_mbox	cmdq_mbox;
 	wait_queue_head_t		waitq;
 	unsigned long			flags;
-	unsigned long			*cmdq_bitmap;
 	unsigned long			last_seen;
 	u32				seq_num;
 };
-- 
2.5.5


--00000000000080970205fd9bd75f
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQfAYJKoZIhvcNAQcCoIIQbTCCEGkCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg3TMIIFDTCCA/WgAwIBAgIQeEqpED+lv77edQixNJMdADANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA5MTYwMDAwMDBaFw0yODA5MTYwMDAwMDBaMFsxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBS
MyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
vbCmXCcsbZ/a0fRIQMBxp4gJnnyeneFYpEtNydrZZ+GeKSMdHiDgXD1UnRSIudKo+moQ6YlCOu4t
rVWO/EiXfYnK7zeop26ry1RpKtogB7/O115zultAz64ydQYLe+a1e/czkALg3sgTcOOcFZTXk38e
aqsXsipoX1vsNurqPtnC27TWsA7pk4uKXscFjkeUE8JZu9BDKaswZygxBOPBQBwrA5+20Wxlk6k1
e6EKaaNaNZUy30q3ArEf30ZDpXyfCtiXnupjSK8WU2cK4qsEtj09JS4+mhi0CTCrCnXAzum3tgcH
cHRg0prcSzzEUDQWoFxyuqwiwhHu3sPQNmFOMwIDAQABo4IB2jCCAdYwDgYDVR0PAQH/BAQDAgGG
MGAGA1UdJQRZMFcGCCsGAQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNxQCAgYKKwYBBAGCNwoDBAYJ
KwYBBAGCNxUGBgorBgEEAYI3CgMMBggrBgEFBQcDBwYIKwYBBQUHAxEwEgYDVR0TAQH/BAgwBgEB
/wIBADAdBgNVHQ4EFgQUljPR5lgXWzR1ioFWZNW+SN6hj88wHwYDVR0jBBgwFoAUj/BLf6guRSSu
TVD6Y5qL3uLdG7wwegYIKwYBBQUHAQEEbjBsMC0GCCsGAQUFBzABhiFodHRwOi8vb2NzcC5nbG9i
YWxzaWduLmNvbS9yb290cjMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjMuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yMy5jcmwwWgYDVR0gBFMwUTALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgEo
CjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAN
BgkqhkiG9w0BAQsFAAOCAQEAdAXk/XCnDeAOd9nNEUvWPxblOQ/5o/q6OIeTYvoEvUUi2qHUOtbf
jBGdTptFsXXe4RgjVF9b6DuizgYfy+cILmvi5hfk3Iq8MAZsgtW+A/otQsJvK2wRatLE61RbzkX8
9/OXEZ1zT7t/q2RiJqzpvV8NChxIj+P7WTtepPm9AIj0Keue+gS2qvzAZAY34ZZeRHgA7g5O4TPJ
/oTd+4rgiU++wLDlcZYd/slFkaT3xg4qWDepEMjT4T1qFOQIL+ijUArYS4owpPg9NISTKa1qqKWJ
jFoyms0d0GwOniIIbBvhI2MJ7BSY9MYtWVT5jJO3tsVHwj4cp92CSFuGwunFMzCCA18wggJHoAMC
AQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUAMEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9v
dCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5
MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEgMB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENB
IC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0E
XyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuul9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+J
J5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJpij2aTv2y8gokeWdimFXN6x0FNx04Druci8u
nPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTv
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBVswggRDoAMCAQICDHL4K7jH/uUzTPFjtzANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAwODE4NDdaFw0yNTA5MTAwODE4NDdaMIGc
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xIjAgBgNVBAMTGVNlbHZpbiBUaHlwYXJhbXBpbCBYYXZpZXIx
KTAnBgkqhkiG9w0BCQEWGnNlbHZpbi54YXZpZXJAYnJvYWRjb20uY29tMIIBIjANBgkqhkiG9w0B
AQEFAAOCAQ8AMIIBCgKCAQEA4/0O+hycwcsNi4j4tTBav8CvSVzv5i1Zk0tYtK7mzA3r8Ij35v5j
L2NsFikHjmHCDfvkP6XrWLSnobeEI4CV0PyrqRVpjZ3XhMPi2M2abxd8BWSGDhd0d8/j8VcjRTuT
fqtDSVGh1z3bqKegUA5r3mbucVWPoIMnjjCLCCim0sJQFblBP+3wkgAWdBcRr/apKCrKhnk0FjpC
FYMZp2DojLAq9f4Oi2OBetbnWxo0WGycXpmq/jC4PUx2u9mazQ79i80VLagGRshWniESXuf+SYG8
+zBimjld9ZZnwm7itHAZdtme4YYFxx+EHa4PUxPV8t+hPHhsiIjirPa1pVXPbQIDAQABo4IB2zCC
AdcwDgYDVR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDov
L3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAu
Y3J0MEEGCCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29u
YWxzaWduMmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0
cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBA
MD6gPKA6hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2Ey
MDIwLmNybDAlBgNVHREEHjAcgRpzZWx2aW4ueGF2aWVyQGJyb2FkY29tLmNvbTATBgNVHSUEDDAK
BggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU3TaH
dsgUhTW3LwObmZ20fj+8Xj8wDQYJKoZIhvcNAQELBQADggEBAAbt6Sptp6ZlTnhM2FDhkVXks68/
iqvfL/e8wSPVdBxOuiP+8EXGLV3E72KfTTJXMbkcmFpK2K11poBDQJhz0xyOGTESjXNnN6Eqq+iX
hQtF8xG2lzPq8MijKI4qXk5Vy5DYfwsVfcF0qJw5AhC32nU9uuIPJq8/mQbZfqmoanV/yadootGr
j1Ze9ndr+YDXPpCymOsynmmw0ErHZGGW1OmMpAEt0A+613glWCURLDlP8HONi1wnINV6aDiEf0ad
9NMGxDsp+YWiRXD3txfo2OMQbpIxM90QfhKKacX8t1J1oAAWxDrLVTJBXBNvz5tr+D1sYwuye93r
hImmkM1unboxggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWdu
IG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIw
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIMB9HJFnQXX9
M+XM4Fs19ejXcMeWRXmOPuQ4VY5+0yvnMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIzMDYwODEwMzc0MFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCfjtWvfDj/xZC+83CZBq9qx1WJymdL
xEUYjA/8poS/xrbpigZ4Nh5CdEz4jJGHsVLKzZqmBSurhbwaG5/xw/w1MHA5rFRxQOdrCldqRGuZ
wz3vPYYnlBCjG/NhTy7a4AaKjBBqTY6ZMwc6i5/NKEUhVajndg4mAxo4ITRKhcixDRw2qXVIDCyZ
OBkW03hswuq5dKtf0VdhzxzaBFPqAOc5uwLGXPocuWRTto9S5t1OkZ0zYe1QARj1++4YkZEdDr2C
0c6xG2CykVBOPRC1LjNveylVcJgEYfcZ0GfAobGQ3Y4/HJWSYzcjm8MhTsoVZF39RIs8v/2etw00
3o8JfK8O
--00000000000080970205fd9bd75f--
