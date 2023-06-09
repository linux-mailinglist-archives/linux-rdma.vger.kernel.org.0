Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B1C7297FA
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Jun 2023 13:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbjFILPR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Jun 2023 07:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239883AbjFILPC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Jun 2023 07:15:02 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CAF30DB
        for <linux-rdma@vger.kernel.org>; Fri,  9 Jun 2023 04:14:41 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1b24ff03400so5465575ad.3
        for <linux-rdma@vger.kernel.org>; Fri, 09 Jun 2023 04:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1686309280; x=1688901280;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ao0zK15fllfuSn1jC+qWX0jyODnvLp5uOPgYh5rmPC0=;
        b=GLa0dx1bBeeWRBaOR4LkD3LVIpZbuiKex76ihWUctDVScEYr9nfFhZshmJboX5UHnZ
         Hl/vKHngBDIlsKNr6qw2wO+/OoYJI3EpFrUGKhmRb8NtdF2dYD3UeQtBvc6qvxMVCmod
         +KFXuWv43FJF1NANpKAdZ1n3RAVuX+4FJEzXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686309280; x=1688901280;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ao0zK15fllfuSn1jC+qWX0jyODnvLp5uOPgYh5rmPC0=;
        b=bKuvDQY8B7AhU2g3K/8UP+fpYglLGW3lAxJrMGWry9VbBVHdzvHO2Y6mVLX7cSFTHO
         Nfo/rRjv3TinK+m3liZaqSfjSVwWbAHxa9pPtOK5aZbZY2EwDVBXEiRwnAISQJGgXuwO
         qDJCjgY1NK4ZyVIP44boS/k9kJdLOkHssanyyO7T+Mz2Jy4yV6fEF/SviSZfy4xyaNAt
         8GS5k/ZGWtoDAazHNfULF+2aeOxOseYyK9dmDf+w+D+JW5NEdb47hDVKX2tueypGMEdw
         04FaQf0pcPOVPNYAoxo05ij1LZ0I34exz/dqVAL41jIG1dMgjFqGL2xCPMrQQsua62Wk
         vEOQ==
X-Gm-Message-State: AC+VfDwi4NT1SyRUq3s37CJeoWaJ8ZlI5wF+kV+4udOlAbAVui34VvgE
        ebWUte3HaL63sgfykLLTW8gsTypCpGjAGx0wMlg=
X-Google-Smtp-Source: ACHHUZ6NGzeFYBJV0twVVaAN4dOPXf3RtnQidJyl8PI7rYD/exhGGvHBsBDBHes4FXWZD1OYo5NjmQ==
X-Received: by 2002:a17:902:e5d2:b0:1b1:e863:9e77 with SMTP id u18-20020a170902e5d200b001b1e8639e77mr767473plf.18.1686309280498;
        Fri, 09 Jun 2023 04:14:40 -0700 (PDT)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id q4-20020a170902dac400b001b0142908f7sm2992954plx.291.2023.06.09.04.14.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Jun 2023 04:14:39 -0700 (PDT)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com,
        kashyap.desai@broadcom.com,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH v2 for-next 10/17] RDMA/bnxt_re: handle command completions after driver detect a timedout
Date:   Fri,  9 Jun 2023 04:01:47 -0700
Message-Id: <1686308514-11996-11-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1686308514-11996-1-git-send-email-selvin.xavier@broadcom.com>
References: <1686308514-11996-1-git-send-email-selvin.xavier@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000aab97505fdb079df"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        MIME_HEADER_CTYPE_ONLY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--000000000000aab97505fdb079df

From: Kashyap Desai <kashyap.desai@broadcom.com>

If calling context detect command timeout, associated memory stored on
stack will not be valid. If firmware complete the same command later,
this causes incorrect memory access by driver.

Added is_waiter_alive to handle delayed completion by firmware.
is_waiter_alive is set and reset under command queue lock.

Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 59 +++++++++++++++++-------------
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h |  1 +
 2 files changed, 34 insertions(+), 26 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index 3215f8a..4e5f66e 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -105,7 +105,6 @@ static int __wait_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie, u8 opcode)
 {
 	struct bnxt_qplib_cmdq_ctx *cmdq;
 	u16 cbit;
-	int ret;
 
 	cmdq = &rcfw->cmdq;
 	cbit = cookie % rcfw->cmdq_depth;
@@ -115,9 +114,9 @@ static int __wait_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie, u8 opcode)
 			return bnxt_qplib_map_rc(opcode);
 
 		/* Non zero means command completed */
-		ret = wait_event_timeout(cmdq->waitq,
-					 !test_bit(cbit, cmdq->cmdq_bitmap),
-					 msecs_to_jiffies(10000));
+		wait_event_timeout(cmdq->waitq,
+				   !test_bit(cbit, cmdq->cmdq_bitmap),
+				   msecs_to_jiffies(10000));
 
 		if (!test_bit(cbit, cmdq->cmdq_bitmap))
 			return 0;
@@ -170,7 +169,7 @@ static int __block_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie, u8 opcode)
 static int __send_message(struct bnxt_qplib_rcfw *rcfw,
 			  struct bnxt_qplib_cmdqmsg *msg)
 {
-	u32 bsize, opcode, free_slots, required_slots;
+	u32 bsize, free_slots, required_slots;
 	struct bnxt_qplib_cmdq_ctx *cmdq;
 	struct bnxt_qplib_crsqe *crsqe;
 	struct bnxt_qplib_cmdqe *cmdqe;
@@ -185,8 +184,6 @@ static int __send_message(struct bnxt_qplib_rcfw *rcfw,
 	hwq = &cmdq->hwq;
 	pdev = rcfw->pdev;
 
-	opcode = __get_cmdq_base_opcode(msg->req, msg->req_sz);
-
 	if (test_bit(FIRMWARE_TIMED_OUT, &cmdq->flags))
 		return -ETIMEDOUT;
 
@@ -216,6 +213,7 @@ static int __send_message(struct bnxt_qplib_rcfw *rcfw,
 	crsqe->free_slots = free_slots;
 	crsqe->resp = (struct creq_qp_event *)msg->resp;
 	crsqe->resp->cookie = cpu_to_le16(cookie);
+	crsqe->is_waiter_alive = true;
 	crsqe->req_size = __get_cmdq_base_cmd_size(msg->req, msg->req_sz);
 	if (__get_cmdq_base_resp_size(msg->req, msg->req_sz) && msg->sb) {
 		struct bnxt_qplib_rcfw_sbuf *sbuf = msg->sb;
@@ -347,7 +345,9 @@ static int __bnxt_qplib_rcfw_send_message(struct bnxt_qplib_rcfw *rcfw,
 					  struct bnxt_qplib_cmdqmsg *msg)
 {
 	struct creq_qp_event *evnt = (struct creq_qp_event *)msg->resp;
-	u16 cookie;
+	struct bnxt_qplib_crsqe *crsqe;
+	unsigned long flags;
+	u16 cookie, cbit;
 	int rc = 0;
 	u8 opcode;
 
@@ -363,6 +363,7 @@ static int __bnxt_qplib_rcfw_send_message(struct bnxt_qplib_rcfw *rcfw,
 
 	cookie = le16_to_cpu(__get_cmdq_base_cookie(msg->req, msg->req_sz))
 				& RCFW_MAX_COOKIE_VALUE;
+	cbit = cookie % rcfw->cmdq_depth;
 
 	if (msg->block)
 		rc = __block_for_resp(rcfw, cookie, opcode);
@@ -378,6 +379,14 @@ static int __bnxt_qplib_rcfw_send_message(struct bnxt_qplib_rcfw *rcfw,
 		return rc;
 	}
 
+	if (rc) {
+		spin_lock_irqsave(&rcfw->cmdq.hwq.lock, flags);
+		crsqe = &rcfw->crsqe_tbl[cbit];
+		crsqe->is_waiter_alive = false;
+		spin_unlock_irqrestore(&rcfw->cmdq.hwq.lock, flags);
+		return -ETIMEDOUT;
+	}
+
 	if (evnt->status) {
 		/* failed with status */
 		dev_err(&rcfw->pdev->dev, "cmdq[%#x]=%#x status %#x\n",
@@ -480,15 +489,15 @@ static int bnxt_qplib_process_qp_event(struct bnxt_qplib_rcfw *rcfw,
 	struct creq_qp_error_notification *err_event;
 	struct bnxt_qplib_hwq *hwq = &rcfw->cmdq.hwq;
 	struct bnxt_qplib_crsqe *crsqe;
+	u32 qp_id, tbl_indx, req_size;
 	struct bnxt_qplib_qp *qp;
 	u16 cbit, blocked = 0;
+	bool is_waiter_alive;
 	struct pci_dev *pdev;
 	unsigned long flags;
 	u32 wait_cmds = 0;
-	__le16  mcookie;
 	u16 cookie;
 	int rc = 0;
-	u32 qp_id, tbl_indx;
 
 	pdev = rcfw->pdev;
 	switch (qp_event->event) {
@@ -520,31 +529,29 @@ static int bnxt_qplib_process_qp_event(struct bnxt_qplib_rcfw *rcfw,
 		spin_lock_irqsave_nested(&hwq->lock, flags,
 					 SINGLE_DEPTH_NESTING);
 		cookie = le16_to_cpu(qp_event->cookie);
-		mcookie = qp_event->cookie;
 		blocked = cookie & RCFW_CMD_IS_BLOCKING;
 		cookie &= RCFW_MAX_COOKIE_VALUE;
 		cbit = cookie % rcfw->cmdq_depth;
 		crsqe = &rcfw->crsqe_tbl[cbit];
-		if (crsqe->resp &&
-		    crsqe->resp->cookie  == mcookie) {
-			memcpy(crsqe->resp, qp_event, sizeof(*qp_event));
-			crsqe->resp = NULL;
-		} else {
-			if (crsqe->resp && crsqe->resp->cookie)
-				dev_err(&pdev->dev,
-					"CMD %s cookie sent=%#x, recd=%#x\n",
-					crsqe->resp ? "mismatch" : "collision",
-					crsqe->resp ? crsqe->resp->cookie : 0,
-					mcookie);
-		}
 		if (!test_and_clear_bit(cbit, rcfw->cmdq.cmdq_bitmap))
 			dev_warn(&pdev->dev,
 				 "CMD bit %d was not requested\n", cbit);
-		hwq->cons += crsqe->req_size;
+
+		if (crsqe->is_waiter_alive) {
+			if (crsqe->resp)
+				memcpy(crsqe->resp, qp_event, sizeof(*qp_event));
+			if (!blocked)
+				wait_cmds++;
+		}
+
+		req_size = crsqe->req_size;
+		is_waiter_alive = crsqe->is_waiter_alive;
+
 		crsqe->req_size = 0;
+		if (!is_waiter_alive)
+			crsqe->resp = NULL;
 
-		if (!blocked)
-			wait_cmds++;
+		hwq->cons += req_size;
 		spin_unlock_irqrestore(&hwq->lock, flags);
 	}
 	*num_wait += wait_cmds;
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
index 089e616..6ed81c1 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
@@ -152,6 +152,7 @@ struct bnxt_qplib_crsqe {
 	u32			req_size;
 	/* Free slots at the time of submission */
 	u32			free_slots;
+	bool			is_waiter_alive;
 };
 
 struct bnxt_qplib_rcfw_sbuf {
-- 
2.5.5


--000000000000aab97505fdb079df
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
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIG8VJ7PBxx/O
nmtoVbw8zLLuUy3LjDbzClot3SiU5P6EMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIzMDYwOTExMTQ0MFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQC4Uf/74dodqsPo21oICk0r0ZW1aBGp
CzyfR3gamH1MTfxoppuPZsq3UrCpN0BjHXdDdxsNu7ONwMni7S+vPON7mZuwtBRTvXWzSHG1qzyN
GGJ9PYauzISMSxj3EY55k6O4JkA5Vq3WC+vEhSwC/eC0PbOjRIh1/l1M3TK9d2pPD/YULBg3BoSn
f2IX+2yHi484/NVEZ630/5IyGXJgYdWpYFhOLU1JUSrKlCWuqLszsl5ECsFLJJ3/1Ks7u3ertJRq
meioNmVrPCoOux9acbvHc10Sik/3vzyyeYh2XcST1NS869LKLgwbHYiXtAw3sE1fDqgUXmrBzVCm
NDsuXzWA
--000000000000aab97505fdb079df--
