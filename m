Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74CFC727D01
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Jun 2023 12:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234380AbjFHKhq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Jun 2023 06:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234388AbjFHKhp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Jun 2023 06:37:45 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED152D42
        for <linux-rdma@vger.kernel.org>; Thu,  8 Jun 2023 03:37:30 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b24eba184bso1792525ad.0
        for <linux-rdma@vger.kernel.org>; Thu, 08 Jun 2023 03:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1686220649; x=1688812649;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bkr4h3jmbZEKUu1ORuVEewoKSGIQpNT88aUTHIfD7Gc=;
        b=XT3tC3DG9BVQffRrsRCkV/ouWFlZi+zxF+i8uplUPYDwKPexi2G6wroWohfCi/7ntK
         qMFrQ02lpY13Pucf2BpwkXbpQz7getC+hq9s/dvXL2pXzmi1DggvOrElgtY8urUmCoX/
         wT6dFW/8MpWa8IIpyO/uucssRg+xbhxuGtvXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686220649; x=1688812649;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bkr4h3jmbZEKUu1ORuVEewoKSGIQpNT88aUTHIfD7Gc=;
        b=cgmmLtqE3ujPzZStAZdIjlzuD3BRHVXZZerNeYyMvBwKrUFAI3l+7y89vJqo0NGxra
         95ncGXUGzYKbCcy0vSy7G/XXQgxEPiPE2zOQPRa+tq9RbvbZFC4LjLPkSAikxKCqYeB7
         fCBf1EEk+zOGcOnuwf5Pv4jDegzJ/fcUqLPu0InUGWCrV15S1Z6sJQxiqkXwbD+l5l8G
         XxWS5nfcfEoqXgcrPGzxT5kkIvx4SEuy15XjAOvRiYXO8ZnW8ojS9dYUfHedWQQ8JR7b
         IcpiIzIVJ0DlxPqgTPC1RjB5J0bhTx3ThNltz669KdBtxrP6WXU6yxDt1SwKMDA/oeU3
         os7Q==
X-Gm-Message-State: AC+VfDx2BBKUip4XtrQuHRa+0kD6G85tC3jG1o9U0iDPpqF43GaUYlzJ
        RSRDuuwo3QpyBZVW6CGrS9dv3w==
X-Google-Smtp-Source: ACHHUZ5If6NwLXh43coNDS0nKDP6OWr0/1Zve52rjTIl5KIUaCiTgIl25Pqb668hS+863SMGPwAvLg==
X-Received: by 2002:a17:902:cecb:b0:1b0:3b07:705b with SMTP id d11-20020a170902cecb00b001b03b07705bmr3860600plg.7.1686220649428;
        Thu, 08 Jun 2023 03:37:29 -0700 (PDT)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id jj11-20020a170903048b00b001a980a23802sm1128510plb.111.2023.06.08.03.37.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Jun 2023 03:37:28 -0700 (PDT)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next 12/17] RDMA/bnxt_re: post destroy_ah for delayed completion of AH creation
Date:   Thu,  8 Jun 2023 03:25:03 -0700
Message-Id: <1686219908-11181-13-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1686219908-11181-1-git-send-email-selvin.xavier@broadcom.com>
References: <1686219908-11181-1-git-send-email-selvin.xavier@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000d8207c05fd9bd69f"
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

--000000000000d8207c05fd9bd69f

From: Kashyap Desai <kashyap.desai@broadcom.com>

AH create may be called from interrpt context and driver has a special
timeout (8 sec) for this command. This is to avoid soft lockups when
the FW command takes more time. Driver returns -ETIMEOUT and fail
create AH, without waiting for actual completion from firmware.
When FW completion is received, use is_waiter_alive flag to avoid
a regular completion path.

If create_ah opcode is detected in completion path which does not have
waiter alive, driver will fetch ah_id from successful firmware
completion in the interrupt context and sends destroy_ah command
for same ah_id. This special post is done in quick manner using helper
function __send_message_no_waiter.

timeout_send is only used for debugging purposes.
If timeout_send value keeps incrementing, it indicates out of sync
active ah counter between driver and firmware. This is a limitation
but graceful handling is possible in future.

Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 108 +++++++++++++++++++++++++++++
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h |   2 +
 2 files changed, 110 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index 4d208ac..3461e3b 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -177,6 +177,73 @@ static int __block_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie, u8 opcode)
 	return -ETIMEDOUT;
 };
 
+/*  __send_message_no_waiter -	get cookie and post the message.
+ * @rcfw      -   rcfw channel instance of rdev
+ * @msg      -    qplib message internal
+ *
+ * This function will just post and don't bother about completion.
+ * Current design of this function is -
+ * user must hold the completion queue hwq->lock.
+ * user must have used existing completion and free the resources.
+ * this function will not check queue full condition.
+ * this function will explicitly set is_waiter_alive=false.
+ * current use case is - send destroy_ah if create_ah is return
+ * after waiter of create_ah is lost. It can be extended for other
+ * use case as well.
+ *
+ * Returns: Nothing
+ *
+ */
+static void __send_message_no_waiter(struct bnxt_qplib_rcfw *rcfw,
+				     struct bnxt_qplib_cmdqmsg *msg)
+{
+	struct bnxt_qplib_cmdq_ctx *cmdq = &rcfw->cmdq;
+	struct bnxt_qplib_hwq *hwq = &cmdq->hwq;
+	struct bnxt_qplib_crsqe *crsqe;
+	struct bnxt_qplib_cmdqe *cmdqe;
+	u32 sw_prod, cmdq_prod;
+	u16 cookie, cbit;
+	u32 bsize;
+	u8 *preq;
+
+	cookie = cmdq->seq_num & RCFW_MAX_COOKIE_VALUE;
+	cbit = cookie % rcfw->cmdq_depth;
+
+	set_bit(cbit, cmdq->cmdq_bitmap);
+	__set_cmdq_base_cookie(msg->req, msg->req_sz, cpu_to_le16(cookie));
+	crsqe = &rcfw->crsqe_tbl[cbit];
+
+	/* Set cmd_size in terms of 16B slots in req. */
+	bsize = bnxt_qplib_set_cmd_slots(msg->req);
+	/* GET_CMD_SIZE would return number of slots in either case of tlv
+	 * and non-tlv commands after call to bnxt_qplib_set_cmd_slots()
+	 */
+	crsqe->is_internal_cmd = true;
+	crsqe->is_waiter_alive = false;
+	crsqe->req_size = __get_cmdq_base_cmd_size(msg->req, msg->req_sz);
+
+	preq = (u8 *)msg->req;
+	do {
+		/* Locate the next cmdq slot */
+		sw_prod = HWQ_CMP(hwq->prod, hwq);
+		cmdqe = bnxt_qplib_get_qe(hwq, sw_prod, NULL);
+		/* Copy a segment of the req cmd to the cmdq */
+		memset(cmdqe, 0, sizeof(*cmdqe));
+		memcpy(cmdqe, preq, min_t(u32, bsize, sizeof(*cmdqe)));
+		preq += min_t(u32, bsize, sizeof(*cmdqe));
+		bsize -= min_t(u32, bsize, sizeof(*cmdqe));
+		hwq->prod++;
+	} while (bsize > 0);
+	cmdq->seq_num++;
+
+	cmdq_prod = hwq->prod;
+	atomic_inc(&rcfw->timeout_send);
+	/* ring CMDQ DB */
+	wmb();
+	writel(cmdq_prod, cmdq->cmdq_mbox.prod);
+	writel(RCFW_CMDQ_TRIG_VAL, cmdq->cmdq_mbox.db);
+}
+
 static int __send_message(struct bnxt_qplib_rcfw *rcfw,
 			  struct bnxt_qplib_cmdqmsg *msg)
 {
@@ -223,6 +290,7 @@ static int __send_message(struct bnxt_qplib_rcfw *rcfw,
 	crsqe->free_slots = free_slots;
 	crsqe->resp = (struct creq_qp_event *)msg->resp;
 	crsqe->resp->cookie = cpu_to_le16(cookie);
+	crsqe->is_internal_cmd = false;
 	crsqe->is_waiter_alive = true;
 	crsqe->req_size = __get_cmdq_base_cmd_size(msg->req, msg->req_sz);
 	if (__get_cmdq_base_resp_size(msg->req, msg->req_sz) && msg->sb) {
@@ -347,6 +415,26 @@ static int __send_message_basic_sanity(struct bnxt_qplib_rcfw *rcfw,
 	return 0;
 }
 
+/* This function will just post and do not bother about completion */
+static void __destroy_timedout_ah(struct bnxt_qplib_rcfw *rcfw,
+				  struct creq_create_ah_resp *create_ah_resp)
+{
+	struct bnxt_qplib_cmdqmsg msg = {};
+	struct cmdq_destroy_ah req = {};
+
+	bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
+				 CMDQ_BASE_OPCODE_DESTROY_AH,
+				 sizeof(req));
+	req.ah_cid = create_ah_resp->xid;
+	msg.req = (struct cmdq_base *)&req;
+	msg.req_sz = sizeof(req);
+	__send_message_no_waiter(rcfw, &msg);
+	dev_info_ratelimited(&rcfw->pdev->dev,
+			     "From %s: ah_cid = %d timeout_send %d\n",
+			     __func__, req.ah_cid,
+			     atomic_read(&rcfw->timeout_send));
+}
+
 /**
  * __bnxt_qplib_rcfw_send_message   -	qplib interface to send
  * and complete rcfw command.
@@ -568,6 +656,8 @@ static int bnxt_qplib_process_qp_event(struct bnxt_qplib_rcfw *rcfw,
 		if (!test_and_clear_bit(cbit, rcfw->cmdq.cmdq_bitmap))
 			dev_warn(&pdev->dev,
 				 "CMD bit %d was not requested\n", cbit);
+		if (crsqe->is_internal_cmd && !qp_event->status)
+			atomic_dec(&rcfw->timeout_send);
 
 		if (crsqe->is_waiter_alive) {
 			if (crsqe->resp)
@@ -584,6 +674,24 @@ static int bnxt_qplib_process_qp_event(struct bnxt_qplib_rcfw *rcfw,
 			crsqe->resp = NULL;
 
 		hwq->cons += req_size;
+
+		/* This is a case to handle below scenario -
+		 * Create AH is completed successfully by firmware,
+		 * but completion took more time and driver already lost
+		 * the context of create_ah from caller.
+		 * We have already return failure for create_ah verbs,
+		 * so let's destroy the same address vector since it is
+		 * no more used in stack. We don't care about completion
+		 * in __send_message_no_waiter.
+		 * If destroy_ah is failued by firmware, there will be AH
+		 * resource leak and relatively not critical +  unlikely
+		 * scenario. Current design is not to handle such case.
+		 */
+		if (!is_waiter_alive && !qp_event->status &&
+		    qp_event->event == CREQ_QP_EVENT_EVENT_CREATE_AH)
+			__destroy_timedout_ah(rcfw,
+					      (struct creq_create_ah_resp *)
+					      qp_event);
 		spin_unlock_irqrestore(&hwq->lock, flags);
 	}
 	*num_wait += wait_cmds;
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
index 54576f1..338bf6a 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
@@ -153,6 +153,7 @@ struct bnxt_qplib_crsqe {
 	/* Free slots at the time of submission */
 	u32			free_slots;
 	bool			is_waiter_alive;
+	bool			is_internal_cmd;
 };
 
 struct bnxt_qplib_rcfw_sbuf {
@@ -225,6 +226,7 @@ struct bnxt_qplib_rcfw {
 	u32 cmdq_depth;
 	atomic_t rcfw_intr_enabled;
 	struct semaphore rcfw_inflight;
+	atomic_t timeout_send;
 };
 
 struct bnxt_qplib_cmdqmsg {
-- 
2.5.5


--000000000000d8207c05fd9bd69f
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
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
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEILLWXzdMYgVq
J79rG4SflvpRVqaW9YPGn/0kbil1gyjEMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIzMDYwODEwMzcyOVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQDZFlFvE6/y1xLdzq2gM9d5wJLlzBLC
KjktDISA6bSiRIOqgR2yma0Ze53p8wN0m4le39O5az1DvRAw+QOXXaQPxSpm/UGvs/LUWpl3h+FB
I66ttJSaoPbo4NIKqS9IuWW3anrR8dNXJV/SkyqATQE4m6ab5xfIsNTP/I7+gXEF55II6XZl1ZDk
8wtGojuQoa04XFVFpd+vLr/xsF2yGsXLTngmi4bW408WMzVaRVyqFY4Vh+OfhbUnVcqn5SbYEJc+
wpFxHqzv89oFmJ9uZMJFQpqDmY25XhnI64KAMtG84b+QlYS2DhXGDOSDTzsbAZlhVUUX7F93dHdF
eUReV9jB
--000000000000d8207c05fd9bd69f--
