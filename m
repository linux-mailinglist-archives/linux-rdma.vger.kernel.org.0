Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF2327297F6
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Jun 2023 13:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjFILPM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Jun 2023 07:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236561AbjFILOq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Jun 2023 07:14:46 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4138D2737
        for <linux-rdma@vger.kernel.org>; Fri,  9 Jun 2023 04:14:30 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b2439e9004so5256875ad.3
        for <linux-rdma@vger.kernel.org>; Fri, 09 Jun 2023 04:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1686309270; x=1688901270;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1goHtNkDhbstCc5HCdOWnRrRV63nLY8Bax+1w3aZqg8=;
        b=fHWV+29XjKnzUBq36DR7VSwEpmR1QAkoYciw+UeYBzZ8KsUJQaLxnsCdvgnpuTwATy
         xbd2OcFXGQB3xBGxSujGITGyMesoyEuFecEumWqTWDK2EGHtZBtF1QfBlZzXPOgWo6+y
         q4oVcqYIKPt6tjWAxs2g4By6IJvcZUcyC3wYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686309270; x=1688901270;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1goHtNkDhbstCc5HCdOWnRrRV63nLY8Bax+1w3aZqg8=;
        b=LPzQdnTQU35GJqm264WL/N3ZjgL5KyC4vbbJZhBi1ExeYVY6VquSk2QF1dxYlS1z50
         voXU8bq838bszNUG+GVrdDDAuJqrXU/dSoIdyE4FbNglttn9G+T6ZbJLi0UOhh/IIaCP
         Z11mkuz0ZmgTmlVBS9vhxJj9V0HfVVLaGOIHl4g2n/A0ILueA4XcnV6By4rhDPy/HVST
         L5H00aV1AIEh3RhzY78SFxywUaTNy5xgLqJzJw437+f0ZXWPCeLEBNRf/leREGiu9hnK
         yvL3ayUf44apOYG1uUqx76dnh2ngYqq0+T/jXVGBxHBAznndC3uhW8TRRs0Vp3U0s3vL
         vMmg==
X-Gm-Message-State: AC+VfDwMoA9oD/bS9BCFKMEXllBKVxhDgYM9G5Zh1kpfQ5GJe/AR7zsP
        spkYeMdhPCajdueWpqWYSPRfLFeSfoh80fQIauA=
X-Google-Smtp-Source: ACHHUZ75CiD00bnGEac0ClaapyzPI3IFZped8FLqZFcAlFD0YQUuFwnL5BP0yRUoKqrnhZ9zNhILUg==
X-Received: by 2002:a17:902:db0d:b0:1b1:e88b:f63 with SMTP id m13-20020a170902db0d00b001b1e88b0f63mr805202plx.61.1686309269709;
        Fri, 09 Jun 2023 04:14:29 -0700 (PDT)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id q4-20020a170902dac400b001b0142908f7sm2992954plx.291.2023.06.09.04.14.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Jun 2023 04:14:28 -0700 (PDT)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com,
        kashyap.desai@broadcom.com,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH v2 for-next 06/17] RDMA/bnxt_re: Avoid the command wait if firmware is inactive
Date:   Fri,  9 Jun 2023 04:01:43 -0700
Message-Id: <1686308514-11996-7-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1686308514-11996-1-git-send-email-selvin.xavier@broadcom.com>
References: <1686308514-11996-1-git-send-email-selvin.xavier@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000005ad6c05fdb0795b"
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

--00000000000005ad6c05fdb0795b

From: Kashyap Desai <kashyap.desai@broadcom.com>

Add a check to avoid waiting if driver already detects a
FW timeout. Return success for resource destroy in case
the device is detached. Add helper function to map timeout
error code to success.

Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 52 +++++++++++++++++++++++++++---
 1 file changed, 48 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index 3b242cc..3c4f72a 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -54,9 +54,46 @@
 static void bnxt_qplib_service_creq(struct tasklet_struct *t);
 
 /**
+ * bnxt_qplib_map_rc  -  map return type based on opcode
+ * @opcode    -  roce slow path opcode
+ *
+ * In some cases like firmware halt is detected, the driver is supposed to
+ * remap the error code of the timed out command.
+ *
+ * It is not safe to assume hardware is really inactive so certain opcodes
+ * like destroy qp etc are not safe to be returned success, but this function
+ * will be called when FW already reports a timeout. This would be possible
+ * only when FW crashes and resets. This will clear all the HW resources.
+ *
+ * Returns:
+ * 0 to communicate success to caller.
+ * Non zero error code to communicate failure to caller.
+ */
+static int bnxt_qplib_map_rc(u8 opcode)
+{
+	switch (opcode) {
+	case CMDQ_BASE_OPCODE_DESTROY_QP:
+	case CMDQ_BASE_OPCODE_DESTROY_SRQ:
+	case CMDQ_BASE_OPCODE_DESTROY_CQ:
+	case CMDQ_BASE_OPCODE_DEALLOCATE_KEY:
+	case CMDQ_BASE_OPCODE_DEREGISTER_MR:
+	case CMDQ_BASE_OPCODE_DELETE_GID:
+	case CMDQ_BASE_OPCODE_DESTROY_QP1:
+	case CMDQ_BASE_OPCODE_DESTROY_AH:
+	case CMDQ_BASE_OPCODE_DEINITIALIZE_FW:
+	case CMDQ_BASE_OPCODE_MODIFY_ROCE_CC:
+	case CMDQ_BASE_OPCODE_SET_LINK_AGGR_MODE:
+		return 0;
+	default:
+		return -ETIMEDOUT;
+	}
+}
+
+/**
  * __wait_for_resp   -	Don't hold the cpu context and wait for response
  * @rcfw      -   rcfw channel instance of rdev
  * @cookie    -   cookie to track the command
+ * @opcode    -   rcfw submitted for given opcode
  *
  * Wait for command completion in sleepable context.
  *
@@ -64,7 +101,7 @@ static void bnxt_qplib_service_creq(struct tasklet_struct *t);
  * 0 if command is completed by firmware.
  * Non zero error code for rest of the case.
  */
-static int __wait_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie)
+static int __wait_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie, u8 opcode)
 {
 	struct bnxt_qplib_cmdq_ctx *cmdq;
 	u16 cbit;
@@ -74,6 +111,9 @@ static int __wait_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie)
 	cbit = cookie % rcfw->cmdq_depth;
 
 	do {
+		if (test_bit(ERR_DEVICE_DETACHED, &cmdq->flags))
+			return bnxt_qplib_map_rc(opcode);
+
 		/* Non zero means command completed */
 		ret = wait_event_timeout(cmdq->waitq,
 					 !test_bit(cbit, cmdq->cmdq_bitmap),
@@ -94,6 +134,7 @@ static int __wait_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie)
  * __block_for_resp   -	hold the cpu context and wait for response
  * @rcfw      -   rcfw channel instance of rdev
  * @cookie    -   cookie to track the command
+ * @opcode    -   rcfw submitted for given opcode
  *
  * This function will hold the cpu (non-sleepable context) and
  * wait for command completion. Maximum holding interval is 8 second.
@@ -102,7 +143,7 @@ static int __wait_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie)
  * -ETIMEOUT if command is not completed in specific time interval.
  * 0 if command is completed by firmware.
  */
-static int __block_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie)
+static int __block_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie, u8 opcode)
 {
 	struct bnxt_qplib_cmdq_ctx *cmdq = &rcfw->cmdq;
 	unsigned long issue_time = 0;
@@ -112,6 +153,9 @@ static int __block_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie)
 	issue_time = jiffies;
 
 	do {
+		if (test_bit(ERR_DEVICE_DETACHED, &cmdq->flags))
+			return bnxt_qplib_map_rc(opcode);
+
 		udelay(1);
 
 		bnxt_qplib_service_creq(&rcfw->creq.creq_tasklet);
@@ -267,9 +311,9 @@ int bnxt_qplib_rcfw_send_message(struct bnxt_qplib_rcfw *rcfw,
 	} while (retry_cnt--);
 
 	if (msg->block)
-		rc = __block_for_resp(rcfw, cookie);
+		rc = __block_for_resp(rcfw, cookie, opcode);
 	else
-		rc = __wait_for_resp(rcfw, cookie);
+		rc = __wait_for_resp(rcfw, cookie, opcode);
 	if (rc) {
 		/* timed out */
 		dev_err(&rcfw->pdev->dev, "cmdq[%#x]=%#x timedout (%d)msec\n",
-- 
2.5.5


--00000000000005ad6c05fdb0795b
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
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIAWZQwMb0XYW
q8TaMwJwefya2wAyG06bKLU2j0A0BxU/MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIzMDYwOTExMTQzMFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCcNnCVYMtzbTjMte//AW05fG5GuFGL
5moOnTnHf28ld2ZM2rIcQPMmV5Hi+0uHfvcy1W19K5RQaVrp6NBey2tcPjEQpbxXXTpoY01uUGf8
zGmJ49LzM5rzWzqH/tBiEnDv+/lz3vHxAtjCjsEv9dti+oOTTCdPN0GR8/vYQuIji1KtOPqH0QmB
3azoF1apbnsFyO80xVQ/DkzSrQ7bubTczPOqIDYQ3xvGcpiNXE5HttW4tKcWnmoCdSdpYZv4x9xh
alLvRctuNtx6WYv91Eu8uF13BJllf2Xah/yie0eQwVbXVmG52i53w8pA74yZW3lJUam4TnNd5tZp
D5KyILho
--00000000000005ad6c05fdb0795b--
