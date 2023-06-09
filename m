Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 493A0729801
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Jun 2023 13:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238739AbjFILPh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Jun 2023 07:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238335AbjFILPc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Jun 2023 07:15:32 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690D12718
        for <linux-rdma@vger.kernel.org>; Fri,  9 Jun 2023 04:15:06 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b00ffb4186so4998335ad.0
        for <linux-rdma@vger.kernel.org>; Fri, 09 Jun 2023 04:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1686309306; x=1688901306;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vUjBbmG0pFsXGBXG1xTfCMoo62fJwX1u/eGxfv/tnUE=;
        b=SbY78acjvrwsop9jL93v3sWNORutXyzphOSJLcWrETEE4/BQ8t0xM2KvUsj/DcpUS2
         OGuuEqCnUETJm2CKygxx/Y+vzCnvDJLimOXW0sktwlv9UG8U1KcX/Y+EEHPD3ecNZ12n
         lcOP2KfMHPCTkL5tK0cSo1ILBX3WpapKObgR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686309306; x=1688901306;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vUjBbmG0pFsXGBXG1xTfCMoo62fJwX1u/eGxfv/tnUE=;
        b=NaWu5rl6/77s9X/3irbhwkpAx//SgX9lXo3QWcH2Y8kKooSrjbHsIiSedpY5NcNZqi
         mPCwsC/Cyt/XvNvzBsnMbrm52FXTRnoDqtdyRPwA19CHJMQxStO8ztmU7xZ/9pXWEPcK
         Qv7NEqy6nG+9zblk6kGQm813WSmC3ziPeKM6VKVTWnFH747ua4bjILM92ddAp6lVUx1g
         Q9jAsbaui2KfHU9XoxEf5OI36CqylmWjLv9MdhkV6F6dlwxJ9+WaT4Qn4uDZhhxcjAOQ
         jCqPEI0BgoCoPz/BeU3XsKBJihEYHYCOVBWiF+ozVJNTr05FsOuvfJMoYzzFqzGwTkXQ
         MZ+A==
X-Gm-Message-State: AC+VfDwaa6K23shHBe5ZkalbNloTUqFCZ8r5iRV5bRtqK/hiSIQ1Ef+u
        Yw41Zxsl0d///4S2KDBPE5boCg==
X-Google-Smtp-Source: ACHHUZ5WvqBRJGjqX3ZFk80qZGXO4yL8PBxcKqQyGDtDW8rP71ktqMQUa7yZOB3Co0iF4vxosJ2ulQ==
X-Received: by 2002:a17:902:ed41:b0:1ae:4bbb:e958 with SMTP id y1-20020a170902ed4100b001ae4bbbe958mr694220plb.14.1686309305637;
        Fri, 09 Jun 2023 04:15:05 -0700 (PDT)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id q4-20020a170902dac400b001b0142908f7sm2992954plx.291.2023.06.09.04.15.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Jun 2023 04:15:05 -0700 (PDT)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com,
        kashyap.desai@broadcom.com,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH v2 for-next 17/17] RDMA/bnxt_re: optimize the parameters passed to helper functions
Date:   Fri,  9 Jun 2023 04:01:54 -0700
Message-Id: <1686308514-11996-18-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1686308514-11996-1-git-send-email-selvin.xavier@broadcom.com>
References: <1686308514-11996-1-git-send-email-selvin.xavier@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000002ab50a05fdb07b7e"
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

--0000000000002ab50a05fdb07b7e

From: Kashyap Desai <kashyap.desai@broadcom.com>

Avoid passing arguments like Opcode which can be retrieved from
bnxt_qplib_crsqe structure.

Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 44 +++++++++++++-----------------
 1 file changed, 19 insertions(+), 25 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index 3ae2f82ff..bb5aeba 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -93,9 +93,6 @@ static int bnxt_qplib_map_rc(u8 opcode)
  * bnxt_re_is_fw_stalled   -	Check firmware health
  * @rcfw      -   rcfw channel instance of rdev
  * @cookie    -   cookie to track the command
- * @opcode    -   rcfw submitted for given opcode
- * @cbit      -   bitmap entry of cookie
- * @in_used   -   command is in used or freed
  *
  * If firmware has not responded any rcfw command within
  * rcfw->max_timeout, consider firmware as stalled.
@@ -105,20 +102,22 @@ static int bnxt_qplib_map_rc(u8 opcode)
  * -ENODEV if firmware is not responding
  */
 static int bnxt_re_is_fw_stalled(struct bnxt_qplib_rcfw *rcfw,
-				 u16 cookie, u8 opcode, bool in_used)
+				 u16 cookie)
 {
 	struct bnxt_qplib_cmdq_ctx *cmdq;
+	struct bnxt_qplib_crsqe *crsqe;
 
+	crsqe = &rcfw->crsqe_tbl[cookie];
 	cmdq = &rcfw->cmdq;
 
 	if (time_after(jiffies, cmdq->last_seen +
 		      (rcfw->max_timeout * HZ))) {
 		dev_warn_ratelimited(&rcfw->pdev->dev,
 				     "%s: FW STALL Detected. cmdq[%#x]=%#x waited (%d > %d) msec active %d ",
-				     __func__, cookie, opcode,
+				     __func__, cookie, crsqe->opcode,
 				     jiffies_to_msecs(jiffies - cmdq->last_seen),
 				     rcfw->max_timeout * 1000,
-				     in_used);
+				     crsqe->is_in_used);
 		return -ENODEV;
 	}
 
@@ -129,7 +128,6 @@ static int bnxt_re_is_fw_stalled(struct bnxt_qplib_rcfw *rcfw,
  * __wait_for_resp   -	Don't hold the cpu context and wait for response
  * @rcfw      -   rcfw channel instance of rdev
  * @cookie    -   cookie to track the command
- * @opcode    -   rcfw submitted for given opcode
  *
  * Wait for command completion in sleepable context.
  *
@@ -137,7 +135,7 @@ static int bnxt_re_is_fw_stalled(struct bnxt_qplib_rcfw *rcfw,
  * 0 if command is completed by firmware.
  * Non zero error code for rest of the case.
  */
-static int __wait_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie, u8 opcode)
+static int __wait_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie)
 {
 	struct bnxt_qplib_cmdq_ctx *cmdq;
 	struct bnxt_qplib_crsqe *crsqe;
@@ -148,7 +146,7 @@ static int __wait_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie, u8 opcode)
 
 	do {
 		if (test_bit(ERR_DEVICE_DETACHED, &cmdq->flags))
-			return bnxt_qplib_map_rc(opcode);
+			return bnxt_qplib_map_rc(crsqe->opcode);
 		if (test_bit(FIRMWARE_STALL_DETECTED, &cmdq->flags))
 			return -ETIMEDOUT;
 
@@ -165,7 +163,7 @@ static int __wait_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie, u8 opcode)
 		if (!crsqe->is_in_used)
 			return 0;
 
-		ret = bnxt_re_is_fw_stalled(rcfw, cookie, opcode, crsqe->is_in_used);
+		ret = bnxt_re_is_fw_stalled(rcfw, cookie);
 		if (ret)
 			return ret;
 
@@ -176,7 +174,6 @@ static int __wait_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie, u8 opcode)
  * __block_for_resp   -	hold the cpu context and wait for response
  * @rcfw      -   rcfw channel instance of rdev
  * @cookie    -   cookie to track the command
- * @opcode    -   rcfw submitted for given opcode
  *
  * This function will hold the cpu (non-sleepable context) and
  * wait for command completion. Maximum holding interval is 8 second.
@@ -185,7 +182,7 @@ static int __wait_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie, u8 opcode)
  * -ETIMEOUT if command is not completed in specific time interval.
  * 0 if command is completed by firmware.
  */
-static int __block_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie, u8 opcode)
+static int __block_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie)
 {
 	struct bnxt_qplib_cmdq_ctx *cmdq = &rcfw->cmdq;
 	struct bnxt_qplib_crsqe *crsqe;
@@ -196,7 +193,7 @@ static int __block_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie, u8 opcode)
 
 	do {
 		if (test_bit(ERR_DEVICE_DETACHED, &cmdq->flags))
-			return bnxt_qplib_map_rc(opcode);
+			return bnxt_qplib_map_rc(crsqe->opcode);
 		if (test_bit(FIRMWARE_STALL_DETECTED, &cmdq->flags))
 			return -ETIMEDOUT;
 
@@ -372,7 +369,6 @@ static int __send_message(struct bnxt_qplib_rcfw *rcfw,
  * __poll_for_resp   -	self poll completion for rcfw command
  * @rcfw      -   rcfw channel instance of rdev
  * @cookie    -   cookie to track the command
- * @opcode    -   rcfw submitted for given opcode
  *
  * It works same as __wait_for_resp except this function will
  * do self polling in sort interval since interrupt is disabled.
@@ -382,8 +378,7 @@ static int __send_message(struct bnxt_qplib_rcfw *rcfw,
  * -ETIMEOUT if command is not completed in specific time interval.
  * 0 if command is completed by firmware.
  */
-static int __poll_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie,
-			   u8 opcode)
+static int __poll_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie)
 {
 	struct bnxt_qplib_cmdq_ctx *cmdq = &rcfw->cmdq;
 	struct bnxt_qplib_crsqe *crsqe;
@@ -395,7 +390,7 @@ static int __poll_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie,
 
 	do {
 		if (test_bit(ERR_DEVICE_DETACHED, &cmdq->flags))
-			return bnxt_qplib_map_rc(opcode);
+			return bnxt_qplib_map_rc(crsqe->opcode);
 		if (test_bit(FIRMWARE_STALL_DETECTED, &cmdq->flags))
 			return -ETIMEDOUT;
 
@@ -406,7 +401,7 @@ static int __poll_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie,
 			return 0;
 		if (jiffies_to_msecs(jiffies - issue_time) >
 		    (rcfw->max_timeout * 1000)) {
-			ret = bnxt_re_is_fw_stalled(rcfw, cookie, opcode, crsqe->is_in_used);
+			ret = bnxt_re_is_fw_stalled(rcfw, cookie);
 			if (ret)
 				return ret;
 		}
@@ -414,13 +409,12 @@ static int __poll_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie,
 };
 
 static int __send_message_basic_sanity(struct bnxt_qplib_rcfw *rcfw,
-				       struct bnxt_qplib_cmdqmsg *msg)
+				       struct bnxt_qplib_cmdqmsg *msg,
+				       u8 opcode)
 {
 	struct bnxt_qplib_cmdq_ctx *cmdq;
-	u32 opcode;
 
 	cmdq = &rcfw->cmdq;
-	opcode = __get_cmdq_base_opcode(msg->req, msg->req_sz);
 
 	/* Prevent posting if f/w is not in a state to process */
 	if (test_bit(ERR_DEVICE_DETACHED, &rcfw->cmdq.flags))
@@ -492,7 +486,7 @@ static int __bnxt_qplib_rcfw_send_message(struct bnxt_qplib_rcfw *rcfw,
 
 	opcode = __get_cmdq_base_opcode(msg->req, msg->req_sz);
 
-	rc = __send_message_basic_sanity(rcfw, msg);
+	rc = __send_message_basic_sanity(rcfw, msg, opcode);
 	if (rc)
 		return rc == -ENXIO ? bnxt_qplib_map_rc(opcode) : rc;
 
@@ -504,11 +498,11 @@ static int __bnxt_qplib_rcfw_send_message(struct bnxt_qplib_rcfw *rcfw,
 				& RCFW_MAX_COOKIE_VALUE;
 
 	if (msg->block)
-		rc = __block_for_resp(rcfw, cookie, opcode);
+		rc = __block_for_resp(rcfw, cookie);
 	else if (atomic_read(&rcfw->rcfw_intr_enabled))
-		rc = __wait_for_resp(rcfw, cookie, opcode);
+		rc = __wait_for_resp(rcfw, cookie);
 	else
-		rc = __poll_for_resp(rcfw, cookie, opcode);
+		rc = __poll_for_resp(rcfw, cookie);
 	if (rc) {
 		/* timed out */
 		dev_err(&rcfw->pdev->dev, "cmdq[%#x]=%#x timedout (%d)msec\n",
-- 
2.5.5


--0000000000002ab50a05fdb07b7e
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
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIPVkLHVZqWLq
iDsZxuhZr/187HRfiPRgUe5dwfkx5Iu2MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIzMDYwOTExMTUwNlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBT00mUf+Mxbt62BNShcYSSJciWrcWZ
VwTGcVQ5AvPM+rzl6svE4eYr45UYE9xoHj0Kw9QoI5NPKVNHsx+EEpoL3G+ps7G+d0omxLBNRWWe
SaTzldIZISgVW5OhRC3R+Z9eTF1hq66/VaVT+PhbMxj2PUF+gcdg5NbM2Um8Ts10dhO8AWAqLHSx
jOT60XA1/sSAOGGgE7C/aZCMy+0V8NjRxatzeNGKiANOX2DBdFq3ftX5EumdFU7lOf/0EHR8Gr3K
/UahmQAxNNiQwAKEWsLLpCr1BMp+RKNtw282PFwrOFT2HtweHEX6TTlRXL6RHCHA44Jxopk9Onhc
AJnGWhnj
--0000000000002ab50a05fdb07b7e--
