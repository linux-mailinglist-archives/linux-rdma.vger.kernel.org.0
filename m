Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE7C3727D06
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Jun 2023 12:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233965AbjFHKiG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Jun 2023 06:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235462AbjFHKiE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Jun 2023 06:38:04 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D3D30D0
        for <linux-rdma@vger.kernel.org>; Thu,  8 Jun 2023 03:37:43 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-543c692db30so232852a12.3
        for <linux-rdma@vger.kernel.org>; Thu, 08 Jun 2023 03:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1686220663; x=1688812663;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=H7X2h68Oxs4Gb9veWaY48teMprU/YVNoF3JPTJbDMQo=;
        b=eorCv2W31kAhrQXiWBe5SSZpfed/ikPrYsgVtmYNJ51Z8qhXNNgsBH04cT7H+pgYDN
         6MyYgkMU5amLbICX1KvaatfRHSxkcilb/4eGD7MfiSdKbChjlOi1pKyG8mfwqIB2GCcZ
         nQmLDhuOZHrwI2zMWbnBC5X5iezZPD5j4op7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686220663; x=1688812663;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H7X2h68Oxs4Gb9veWaY48teMprU/YVNoF3JPTJbDMQo=;
        b=ElPZw/Gpe/TFbr9DkQlr75X4/iOmBN+j5Ht6gDJ6SBWlfneljzaRvqzCILZGhUGjem
         Y6ybFYkisxZh5PuOKiSDVA/qtpNZJEeVfsRWZ5YRaeijSySwJcQZf8T0ZaO61WrbHQEC
         aTxtlpzHoPQJoNOtjdEQMrckHBA050TygPh3wpy39T+rOyZvLlyI9EsgxaxQO9sA3W2h
         cKWokMVjXKSs0UGXqsjexjlE5R0ypmGURBVo/ZY6RWmzTLTW3o3gce3KRTp2efZOO+uA
         USXhrVINe3ufC8imp/SWiZJeQzD1VPLSYx+tvuIwKoaCfnVAyZoPvF0AYj4LFI2SHz9m
         VboA==
X-Gm-Message-State: AC+VfDx1lQK8ngW8FvBS9pLwnDp4KIQ9FWtSzFwxmPSW7uZ9RLIMC0Od
        7RTCuY0aHUoKqYd7aGhmze9hPg==
X-Google-Smtp-Source: ACHHUZ7jgF7fRe9SpxSqVcv82A4I7wJFrVIbMdCJRVQj/nZhYFWAB02R69oPWlXdvuNdThc6KAGC2Q==
X-Received: by 2002:a17:90a:4d:b0:255:b07a:3d55 with SMTP id 13-20020a17090a004d00b00255b07a3d55mr7830376pjb.28.1686220663098;
        Thu, 08 Jun 2023 03:37:43 -0700 (PDT)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id jj11-20020a170903048b00b001a980a23802sm1128510plb.111.2023.06.08.03.37.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Jun 2023 03:37:42 -0700 (PDT)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next 17/17] RDMA/bnxt_re: optimize the parameters passed to helper functions
Date:   Thu,  8 Jun 2023 03:25:08 -0700
Message-Id: <1686219908-11181-18-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1686219908-11181-1-git-send-email-selvin.xavier@broadcom.com>
References: <1686219908-11181-1-git-send-email-selvin.xavier@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000a8c4b605fd9bd7f1"
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

--000000000000a8c4b605fd9bd7f1

From: Kashyap Desai <kashyap.desai@broadcom.com>

Avoid passing arguments like Opcode which can be retrieved from
bnxt_qplib_crsqe structure.

Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 44 +++++++++++++-----------------
 1 file changed, 19 insertions(+), 25 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index 45bbf5f..3526518 100644
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
 
@@ -166,7 +164,7 @@ static int __wait_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie, u8 opcode)
 		if (!crsqe->is_in_used)
 			return 0;
 
-		ret = bnxt_re_is_fw_stalled(rcfw, cookie, opcode, crsqe->is_in_used);
+		ret = bnxt_re_is_fw_stalled(rcfw, cookie);
 		if (ret)
 			return ret;
 
@@ -177,7 +175,6 @@ static int __wait_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie, u8 opcode)
  * __block_for_resp   -	hold the cpu context and wait for response
  * @rcfw      -   rcfw channel instance of rdev
  * @cookie    -   cookie to track the command
- * @opcode    -   rcfw submitted for given opcode
  *
  * This function will hold the cpu (non-sleepable context) and
  * wait for command completion. Maximum holding interval is 8 second.
@@ -186,7 +183,7 @@ static int __wait_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie, u8 opcode)
  * -ETIMEOUT if command is not completed in specific time interval.
  * 0 if command is completed by firmware.
  */
-static int __block_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie, u8 opcode)
+static int __block_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie)
 {
 	struct bnxt_qplib_cmdq_ctx *cmdq = &rcfw->cmdq;
 	struct bnxt_qplib_crsqe *crsqe;
@@ -197,7 +194,7 @@ static int __block_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie, u8 opcode)
 
 	do {
 		if (test_bit(ERR_DEVICE_DETACHED, &cmdq->flags))
-			return bnxt_qplib_map_rc(opcode);
+			return bnxt_qplib_map_rc(crsqe->opcode);
 		if (test_bit(FIRMWARE_STALL_DETECTED, &cmdq->flags))
 			return -ETIMEDOUT;
 
@@ -375,7 +372,6 @@ static int __send_message(struct bnxt_qplib_rcfw *rcfw,
  * __poll_for_resp   -	self poll completion for rcfw command
  * @rcfw      -   rcfw channel instance of rdev
  * @cookie    -   cookie to track the command
- * @opcode    -   rcfw submitted for given opcode
  *
  * It works same as __wait_for_resp except this function will
  * do self polling in sort interval since interrupt is disabled.
@@ -385,8 +381,7 @@ static int __send_message(struct bnxt_qplib_rcfw *rcfw,
  * -ETIMEOUT if command is not completed in specific time interval.
  * 0 if command is completed by firmware.
  */
-static int __poll_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie,
-			   u8 opcode)
+static int __poll_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie)
 {
 	struct bnxt_qplib_cmdq_ctx *cmdq = &rcfw->cmdq;
 	struct bnxt_qplib_crsqe *crsqe;
@@ -398,7 +393,7 @@ static int __poll_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie,
 
 	do {
 		if (test_bit(ERR_DEVICE_DETACHED, &cmdq->flags))
-			return bnxt_qplib_map_rc(opcode);
+			return bnxt_qplib_map_rc(crsqe->opcode);
 		if (test_bit(FIRMWARE_STALL_DETECTED, &cmdq->flags))
 			return -ETIMEDOUT;
 
@@ -409,7 +404,7 @@ static int __poll_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie,
 			return 0;
 		if (jiffies_to_msecs(jiffies - issue_time) >
 		    (rcfw->max_timeout * 1000)) {
-			ret = bnxt_re_is_fw_stalled(rcfw, cookie, opcode, crsqe->is_in_used);
+			ret = bnxt_re_is_fw_stalled(rcfw, cookie);
 			if (ret)
 				return ret;
 		}
@@ -417,13 +412,12 @@ static int __poll_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie,
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
@@ -495,7 +489,7 @@ static int __bnxt_qplib_rcfw_send_message(struct bnxt_qplib_rcfw *rcfw,
 
 	opcode = __get_cmdq_base_opcode(msg->req, msg->req_sz);
 
-	rc = __send_message_basic_sanity(rcfw, msg);
+	rc = __send_message_basic_sanity(rcfw, msg, opcode);
 	if (rc)
 		return rc == -ENXIO ? bnxt_qplib_map_rc(opcode) : rc;
 
@@ -507,11 +501,11 @@ static int __bnxt_qplib_rcfw_send_message(struct bnxt_qplib_rcfw *rcfw,
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


--000000000000a8c4b605fd9bd7f1
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
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIFJZEwXMgxPy
maOnVkH/R2vYNF2+Odg2dWkYfuvrFIwVMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIzMDYwODEwMzc0M1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCJEwM+WGTriAnjQrTiGmBx3kqL3TYd
ZKD+OTrZ6tt25yc6sPamBASMT0fW8ZtVmte2tmrc+wVny7cpGKhCVN5hmmEjBM6QrBjaejZCzotP
YLr93mnSZ50YNKrbK9553QlTxaFgUqKaJjRtwVmDigwr+uMHSPJCcVnUnSSa/b9W+z4E3BMxTkIt
C7N0oNw7NMyg32dE8z9khxfS8dqTNim/YOmyR3MDijBbZT6/YN13HAxUX03M2yehdL6LVsc1uAKi
905/OXV4oDVYl93o6edguXGrloVJaXFeOu5k5FDmWlG4U2EteyaDRYSNhpY2htJvMI/AEF/YSard
G1RV5vQ1
--000000000000a8c4b605fd9bd7f1--
