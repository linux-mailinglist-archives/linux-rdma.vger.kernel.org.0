Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0ADE727CFB
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Jun 2023 12:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235994AbjFHKha (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Jun 2023 06:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236025AbjFHKh3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Jun 2023 06:37:29 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA4C2D47
        for <linux-rdma@vger.kernel.org>; Thu,  8 Jun 2023 03:37:19 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b02fcde49aso1913685ad.0
        for <linux-rdma@vger.kernel.org>; Thu, 08 Jun 2023 03:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1686220638; x=1688812638;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0WVYXaNV4s7CiTig4zoZw9ITPO8rLwz66S+Xf+1lSY0=;
        b=cel1kwWTIjy2wyXoQBweWhzjxYm7QvyuaSUthIkpWDsPeb+VarEbBJIn5GPdAvhwkd
         M8ZA2A4v+XNUeA3QGrxOPS9Hytrii4afxHX6sfAocgAHa8+YnxpFeb/XPXZ5gANGKGP8
         71DORX26IIlpD+Mm75ItyVQOt8WV86n1N7FIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686220638; x=1688812638;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0WVYXaNV4s7CiTig4zoZw9ITPO8rLwz66S+Xf+1lSY0=;
        b=f4v2AuCfeNVdqIvd0jENokoiAteFT9jv6/auDe+pFBawiiUIIh1CBnuZ/nWqaq+iYx
         36nNOsRK5l8jDRN/UjbbibNg9n8+Q2Gb1I32n+LRKyZKU7ed7+hmtImvwLubjT14xs32
         AGKrrmAVEaFpFrjdQSD2VQK/eEeKdLB9EeQDPbQcYn/xfJlgJYnX8apVsttSdlBGRmxb
         CFEUwWqMtg1m1zpQ97NJa5FUa/SJWPuC9mIwEWBogRhs8h8qjKu8eCamN7YHhFbVeBtw
         ilLuXwq9Kd4JolQQ6cQ3Ht5czkx2sqmeFS57tqEa8h7075omMPGvT4mMUrqviKLlIW39
         DmNg==
X-Gm-Message-State: AC+VfDzSmULSvcnFGP4APUmjWiEa4QRnx2JdGidBPOmmPiOgH3lrBS+s
        vgNejqQvNaENp1UW/CTr0VLKKQ==
X-Google-Smtp-Source: ACHHUZ7ZCPguSOk0+bJKsAoHKvhya7Hwt83VzOrW0xVHmiwLVxpwrsu2AREC7PfgIdDTzf9QO74KAw==
X-Received: by 2002:a17:902:ef91:b0:1aa:ff24:f8f0 with SMTP id iz17-20020a170902ef9100b001aaff24f8f0mr3928755plb.4.1686220638411;
        Thu, 08 Jun 2023 03:37:18 -0700 (PDT)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id jj11-20020a170903048b00b001a980a23802sm1128510plb.111.2023.06.08.03.37.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Jun 2023 03:37:17 -0700 (PDT)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next 08/17] RDMA/bnxt_re: Simplify the function that sends the FW commands
Date:   Thu,  8 Jun 2023 03:24:59 -0700
Message-Id: <1686219908-11181-9-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1686219908-11181-1-git-send-email-selvin.xavier@broadcom.com>
References: <1686219908-11181-1-git-send-email-selvin.xavier@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000003047c005fd9bd612"
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

--0000000000003047c005fd9bd612

From: Kashyap Desai <kashyap.desai@broadcom.com>

 - Use __send_message_basic_sanity helper function.
 - Do not retry posting same command if there is a queue full detection.
 - ENXIO is used to indicate controller recovery.
 - In the case of ERR_DEVICE_DETACHED state, the driver should not post
   commands to the firmware, but also return fabricated written code.

Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 125 +++++++++++++++--------------
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h |  22 +++++
 2 files changed, 86 insertions(+), 61 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index f7d1238..15f6793 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -170,34 +170,22 @@ static int __block_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie, u8 opcode)
 static int __send_message(struct bnxt_qplib_rcfw *rcfw,
 			  struct bnxt_qplib_cmdqmsg *msg)
 {
-	struct bnxt_qplib_cmdq_ctx *cmdq = &rcfw->cmdq;
-	struct bnxt_qplib_hwq *hwq = &cmdq->hwq;
+	u32 bsize, opcode, free_slots, required_slots;
+	struct bnxt_qplib_cmdq_ctx *cmdq;
 	struct bnxt_qplib_crsqe *crsqe;
 	struct bnxt_qplib_cmdqe *cmdqe;
+	struct bnxt_qplib_hwq *hwq;
 	u32 sw_prod, cmdq_prod;
 	struct pci_dev *pdev;
 	unsigned long flags;
-	u32 bsize, opcode;
 	u16 cookie, cbit;
 	u8 *preq;
 
+	cmdq = &rcfw->cmdq;
+	hwq = &cmdq->hwq;
 	pdev = rcfw->pdev;
 
 	opcode = __get_cmdq_base_opcode(msg->req, msg->req_sz);
-	if (!test_bit(FIRMWARE_INITIALIZED_FLAG, &cmdq->flags) &&
-	    (opcode != CMDQ_BASE_OPCODE_QUERY_FUNC &&
-	     opcode != CMDQ_BASE_OPCODE_INITIALIZE_FW &&
-	     opcode != CMDQ_BASE_OPCODE_QUERY_VERSION)) {
-		dev_err(&pdev->dev,
-			"RCFW not initialized, reject opcode 0x%x\n", opcode);
-		return -EINVAL;
-	}
-
-	if (test_bit(FIRMWARE_INITIALIZED_FLAG, &cmdq->flags) &&
-	    opcode == CMDQ_BASE_OPCODE_INITIALIZE_FW) {
-		dev_err(&pdev->dev, "RCFW already initialized!\n");
-		return -EINVAL;
-	}
 
 	if (test_bit(FIRMWARE_TIMED_OUT, &cmdq->flags))
 		return -ETIMEDOUT;
@@ -206,40 +194,37 @@ static int __send_message(struct bnxt_qplib_rcfw *rcfw,
 	 * cmdqe
 	 */
 	spin_lock_irqsave(&hwq->lock, flags);
-	if (msg->req->cmd_size >= HWQ_FREE_SLOTS(hwq)) {
-		dev_err(&pdev->dev, "RCFW: CMDQ is full!\n");
+	required_slots = bnxt_qplib_get_cmd_slots(msg->req);
+	free_slots = HWQ_FREE_SLOTS(hwq);
+	cookie = cmdq->seq_num & RCFW_MAX_COOKIE_VALUE;
+	cbit = cookie % rcfw->cmdq_depth;
+
+	if (required_slots >= free_slots ||
+	    test_bit(cbit, cmdq->cmdq_bitmap)) {
+		dev_info_ratelimited(&pdev->dev,
+				     "CMDQ is full req/free %d/%d!",
+				     required_slots, free_slots);
 		spin_unlock_irqrestore(&hwq->lock, flags);
 		return -EAGAIN;
 	}
-
-
-	cookie = cmdq->seq_num & RCFW_MAX_COOKIE_VALUE;
-	cbit = cookie % rcfw->cmdq_depth;
 	if (msg->block)
 		cookie |= RCFW_CMD_IS_BLOCKING;
-
 	set_bit(cbit, cmdq->cmdq_bitmap);
 	__set_cmdq_base_cookie(msg->req, msg->req_sz, cpu_to_le16(cookie));
 	crsqe = &rcfw->crsqe_tbl[cbit];
-	if (crsqe->resp) {
-		spin_unlock_irqrestore(&hwq->lock, flags);
-		return -EBUSY;
-	}
-
-	/* change the cmd_size to the number of 16byte cmdq unit.
-	 * req->cmd_size is modified here
-	 */
 	bsize = bnxt_qplib_set_cmd_slots(msg->req);
-
-	memset(msg->resp, 0, sizeof(*msg->resp));
+	crsqe->free_slots = free_slots;
 	crsqe->resp = (struct creq_qp_event *)msg->resp;
 	crsqe->resp->cookie = cpu_to_le16(cookie);
 	crsqe->req_size = __get_cmdq_base_cmd_size(msg->req, msg->req_sz);
 	if (__get_cmdq_base_resp_size(msg->req, msg->req_sz) && msg->sb) {
 		struct bnxt_qplib_rcfw_sbuf *sbuf = msg->sb;
-		__set_cmdq_base_resp_addr(msg->req, msg->req_sz, cpu_to_le64(sbuf->dma_addr));
+
+		__set_cmdq_base_resp_addr(msg->req, msg->req_sz,
+					  cpu_to_le64(sbuf->dma_addr));
 		__set_cmdq_base_resp_size(msg->req, msg->req_sz,
-					  ALIGN(sbuf->size, BNXT_QPLIB_CMDQE_UNITS));
+					  ALIGN(sbuf->size,
+						BNXT_QPLIB_CMDQE_UNITS));
 	}
 
 	preq = (u8 *)msg->req;
@@ -247,11 +232,6 @@ static int __send_message(struct bnxt_qplib_rcfw *rcfw,
 		/* Locate the next cmdq slot */
 		sw_prod = HWQ_CMP(hwq->prod, hwq);
 		cmdqe = bnxt_qplib_get_qe(hwq, sw_prod, NULL);
-		if (!cmdqe) {
-			dev_err(&pdev->dev,
-				"RCFW request failed with no cmdqe!\n");
-			goto done;
-		}
 		/* Copy a segment of the req cmd to the cmdq */
 		memset(cmdqe, 0, sizeof(*cmdqe));
 		memcpy(cmdqe, preq, min_t(u32, bsize, sizeof(*cmdqe)));
@@ -275,12 +255,43 @@ static int __send_message(struct bnxt_qplib_rcfw *rcfw,
 	wmb();
 	writel(cmdq_prod, cmdq->cmdq_mbox.prod);
 	writel(RCFW_CMDQ_TRIG_VAL, cmdq->cmdq_mbox.db);
-done:
 	spin_unlock_irqrestore(&hwq->lock, flags);
 	/* Return the CREQ response pointer */
 	return 0;
 }
 
+static int __send_message_basic_sanity(struct bnxt_qplib_rcfw *rcfw,
+				       struct bnxt_qplib_cmdqmsg *msg)
+{
+	struct bnxt_qplib_cmdq_ctx *cmdq;
+	u32 opcode;
+
+	cmdq = &rcfw->cmdq;
+	opcode = __get_cmdq_base_opcode(msg->req, msg->req_sz);
+
+	/* Prevent posting if f/w is not in a state to process */
+	if (test_bit(ERR_DEVICE_DETACHED, &rcfw->cmdq.flags))
+		return -ENXIO;
+
+	if (test_bit(FIRMWARE_INITIALIZED_FLAG, &cmdq->flags) &&
+	    opcode == CMDQ_BASE_OPCODE_INITIALIZE_FW) {
+		dev_err(&rcfw->pdev->dev, "QPLIB: RCFW already initialized!");
+		return -EINVAL;
+	}
+
+	if (!test_bit(FIRMWARE_INITIALIZED_FLAG, &cmdq->flags) &&
+	    (opcode != CMDQ_BASE_OPCODE_QUERY_FUNC &&
+	     opcode != CMDQ_BASE_OPCODE_INITIALIZE_FW &&
+	     opcode != CMDQ_BASE_OPCODE_QUERY_VERSION)) {
+		dev_err(&rcfw->pdev->dev,
+			"QPLIB: RCFW not initialized, reject opcode 0x%x",
+			opcode);
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
 /**
  * __bnxt_qplib_rcfw_send_message   -	qplib interface to send
  * and complete rcfw command.
@@ -299,29 +310,21 @@ static int __bnxt_qplib_rcfw_send_message(struct bnxt_qplib_rcfw *rcfw,
 {
 	struct creq_qp_event *evnt = (struct creq_qp_event *)msg->resp;
 	u16 cookie;
-	u8 opcode, retry_cnt = 0xFF;
 	int rc = 0;
+	u8 opcode;
 
-	/* Prevent posting if f/w is not in a state to process */
-	if (test_bit(ERR_DEVICE_DETACHED, &rcfw->cmdq.flags))
-		return 0;
+	opcode = __get_cmdq_base_opcode(msg->req, msg->req_sz);
 
-	do {
-		opcode = __get_cmdq_base_opcode(msg->req, msg->req_sz);
-		rc = __send_message(rcfw, msg);
-		cookie = le16_to_cpu(__get_cmdq_base_cookie(msg->req, msg->req_sz)) &
-				RCFW_MAX_COOKIE_VALUE;
-		if (!rc)
-			break;
-		if (!retry_cnt || (rc != -EAGAIN && rc != -EBUSY)) {
-			/* send failed */
-			dev_err(&rcfw->pdev->dev, "cmdq[%#x]=%#x send failed\n",
-				cookie, opcode);
-			return rc;
-		}
-		msg->block ? mdelay(1) : usleep_range(500, 1000);
+	rc = __send_message_basic_sanity(rcfw, msg);
+	if (rc)
+		return rc == -ENXIO ? bnxt_qplib_map_rc(opcode) : rc;
+
+	rc = __send_message(rcfw, msg);
+	if (rc)
+		return rc;
 
-	} while (retry_cnt--);
+	cookie = le16_to_cpu(__get_cmdq_base_cookie(msg->req, msg->req_sz))
+				& RCFW_MAX_COOKIE_VALUE;
 
 	if (msg->block)
 		rc = __block_for_resp(rcfw, cookie, opcode);
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
index 862bfbf..b7bbbae 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
@@ -89,6 +89,26 @@ static inline u32 bnxt_qplib_cmdqe_page_size(u32 depth)
 	return (bnxt_qplib_cmdqe_npages(depth) * PAGE_SIZE);
 }
 
+/* Get the number of command units required for the req. The
+ * function returns correct value only if called before
+ * setting using bnxt_qplib_set_cmd_slots
+ */
+static inline u32 bnxt_qplib_get_cmd_slots(struct cmdq_base *req)
+{
+	u32 cmd_units = 0;
+
+	if (HAS_TLV_HEADER(req)) {
+		struct roce_tlv *tlv_req = (struct roce_tlv *)req;
+
+		cmd_units = tlv_req->total_size;
+	} else {
+		cmd_units = (req->cmd_size + BNXT_QPLIB_CMDQE_UNITS - 1) /
+			    BNXT_QPLIB_CMDQE_UNITS;
+	}
+
+	return cmd_units;
+}
+
 static inline u32 bnxt_qplib_set_cmd_slots(struct cmdq_base *req)
 {
 	u32 cmd_byte = 0;
@@ -130,6 +150,8 @@ typedef int (*aeq_handler_t)(struct bnxt_qplib_rcfw *, void *, void *);
 struct bnxt_qplib_crsqe {
 	struct creq_qp_event	*resp;
 	u32			req_size;
+	/* Free slots at the time of submission */
+	u32			free_slots;
 };
 
 struct bnxt_qplib_rcfw_sbuf {
-- 
2.5.5


--0000000000003047c005fd9bd612
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
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIICKJdM/Lvp0
cDwoQI7cjz1zr0d5C7UB5Mtsfimk7q7XMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIzMDYwODEwMzcxOFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQDNjFFKEvGwKE0SyHZT7ksFSN3rgHi+
Z9imvWaLxVOtYITk2nHIxOg58VSxLF3E2vSvo0wV+UWVv5O/i1ScBiGYtrOPLVMYJ4duP6JPDTCv
0aR95tV2EytLdD2+fMz9JasHVYMy4TpfXIRtq7WIltUIy0NhR5ed06FA1gXG9Yy+kvBx4iEtoIaz
38+FtF2vaZiuPgkwo/oyRELY4OEMpmiWRq3D40uXG3e8XtEokL+XiAou/MQ/qD5qpATGD79hV5W2
kIKB2LR159hY1S+vpmMaYIjSwj9q/3CcRMRnXszlNxOHvwRvE/O6vTI4pI8CcZMlf43eSe5Swq+h
NYyeSzps
--0000000000003047c005fd9bd612--
