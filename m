Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7481C6C6305
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Mar 2023 10:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbjCWJNU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Mar 2023 05:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbjCWJNM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 23 Mar 2023 05:13:12 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BCE1A95B
        for <linux-rdma@vger.kernel.org>; Thu, 23 Mar 2023 02:13:09 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id i15so8711239pfo.8
        for <linux-rdma@vger.kernel.org>; Thu, 23 Mar 2023 02:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1679562789;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CXE6NWV1wQ2VAW6XWzTt/QoRXeEA9TZDCJ3HKrwwYSU=;
        b=hA2cWZKaUMzSNqHe/mAl7gWD14za8xX1MhkAV9MrgH8d8V3uhbHOHvWXrlqBwDUavf
         3aowknOtr9gTpFve8iSuNMxIyQIS6mk70T9cCdb7HVuSgOxsgBiXe83onoGPJJje0AOj
         0BvmsAVh1mlcG0UFXlc6P4HQNPapABthfy5BI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679562789;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CXE6NWV1wQ2VAW6XWzTt/QoRXeEA9TZDCJ3HKrwwYSU=;
        b=eLJsxa97sZUMCeyHjG6piX3ph40MB0CvEJAFdMT2BOWc0n/BmStyXKh4G/BrHfuuBC
         iguAirS09bQupNm5iLEYuEmv8L476aoLU3sLKpeZtVXa7rP+nIm98MJc97goTRW/eFRJ
         Ou67Zn56aHBRnYvxLuyJJhm+nNqoySjJmO7Ow85aPYT5fWMdNt8aKmwY/XGqGqJsk5mW
         jxlGEp6yNhETefj6WFd6mvNb7FhKjU9fCpjQoZw+Z3CC8maw/hTC6kxvUrpaUus5fKw/
         DsVIwRkQzEGn7jWBpk7NUcQR/WnxhtIfUz0twrQJt92PbsCj5Ysv64BypySt/SoxfkJe
         T6pA==
X-Gm-Message-State: AO0yUKXXm0HYurd7MXlCTPqPRAgSHYtJ/4SS6fU7ZdR91yMLirj3+Kme
        7R/SmDqMq60Dcq4DYV3CBoafttOIVushdcyDZlE=
X-Google-Smtp-Source: AK7set+oPoxZcOFF0SF01HHDGzNv8a4QsPKpVDxOSfkg7CS/s5QaVVzx7vJ0eut6xLhEoV31KKLKbw==
X-Received: by 2002:a62:62c3:0:b0:5e0:a86:a76f with SMTP id w186-20020a6262c3000000b005e00a86a76fmr6102616pfb.0.1679562788763;
        Thu, 23 Mar 2023 02:13:08 -0700 (PDT)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id l20-20020a62be14000000b00627e9ab34b3sm9055114pff.91.2023.03.23.02.13.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Mar 2023 02:13:07 -0700 (PDT)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next 6/7] RDAM/bnxt_re: Use tlv apis while processing the slow path commands
Date:   Thu, 23 Mar 2023 02:12:18 -0700
Message-Id: <1679562739-24472-7-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1679562739-24472-1-git-send-email-selvin.xavier@broadcom.com>
References: <1679562739-24472-1-git-send-email-selvin.xavier@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000006bebe605f78daf88"
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MIME_HEADER_CTYPE_ONLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_TVD_MIME_NO_HEADERS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--0000000000006bebe605f78daf88

Use the new TLV APIs for existing slow path commands. The TLV
APIs will be used to populate extended headers for some of the
Firmware commands, which will be introduced in the patches that
follow.

Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index 7403a4e..06979f7 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -49,6 +49,7 @@
 #include "qplib_rcfw.h"
 #include "qplib_sp.h"
 #include "qplib_fp.h"
+#include "qplib_tlv.h"
 
 static void bnxt_qplib_service_creq(struct tasklet_struct *t);
 
@@ -101,7 +102,7 @@ static int __send_message(struct bnxt_qplib_rcfw *rcfw,
 
 	pdev = rcfw->pdev;
 
-	opcode = msg->req->opcode;
+	opcode = __get_cmdq_base_opcode(msg->req, msg->req_sz);
 	if (!test_bit(FIRMWARE_INITIALIZED_FLAG, &cmdq->flags) &&
 	    (opcode != CMDQ_BASE_OPCODE_QUERY_FUNC &&
 	     opcode != CMDQ_BASE_OPCODE_INITIALIZE_FW &&
@@ -137,7 +138,7 @@ static int __send_message(struct bnxt_qplib_rcfw *rcfw,
 		cookie |= RCFW_CMD_IS_BLOCKING;
 
 	set_bit(cbit, cmdq->cmdq_bitmap);
-	msg->req->cookie = cpu_to_le16(cookie);
+	__set_cmdq_base_cookie(msg->req, msg->req_sz, cpu_to_le16(cookie));
 	crsqe = &rcfw->crsqe_tbl[cbit];
 	if (crsqe->resp) {
 		spin_unlock_irqrestore(&hwq->lock, flags);
@@ -153,13 +154,12 @@ static int __send_message(struct bnxt_qplib_rcfw *rcfw,
 	memset(msg->resp, 0, sizeof(*msg->resp));
 	crsqe->resp = (struct creq_qp_event *)msg->resp;
 	crsqe->resp->cookie = msg->req->cookie;
-	crsqe->req_size = msg->req->cmd_size;
-	if (msg->req->resp_size && msg->sb) {
+	crsqe->req_size = __get_cmdq_base_cmd_size(msg->req, msg->req_sz);
+	if (__get_cmdq_base_resp_size(msg->req, msg->req_sz) && msg->sb) {
 		struct bnxt_qplib_rcfw_sbuf *sbuf = msg->sb;
-
-		msg->req->resp_addr = cpu_to_le64(sbuf->dma_addr);
-		msg->req->resp_size = (sbuf->size + BNXT_QPLIB_CMDQE_UNITS - 1) /
-				  BNXT_QPLIB_CMDQE_UNITS;
+		__set_cmdq_base_resp_addr(msg->req, msg->req_sz, cpu_to_le64(sbuf->dma_addr));
+		__set_cmdq_base_resp_size(msg->req, msg->req_sz,
+					  ALIGN(sbuf->size, BNXT_QPLIB_CMDQE_UNITS));
 	}
 
 	preq = (u8 *)msg->req;
@@ -214,12 +214,12 @@ int bnxt_qplib_rcfw_send_message(struct bnxt_qplib_rcfw *rcfw,
 		return 0;
 
 	do {
-		opcode = msg->req->opcode;
+		opcode = __get_cmdq_base_opcode(msg->req, msg->req_sz);
 		rc = __send_message(rcfw, msg);
-		cookie = le16_to_cpu(msg->req->cookie) & RCFW_MAX_COOKIE_VALUE;
+		cookie = le16_to_cpu(__get_cmdq_base_cookie(msg->req, msg->req_sz)) &
+				RCFW_MAX_COOKIE_VALUE;
 		if (!rc)
 			break;
-
 		if (!retry_cnt || (rc != -EAGAIN && rc != -EBUSY)) {
 			/* send failed */
 			dev_err(&rcfw->pdev->dev, "cmdq[%#x]=%#x send failed\n",
-- 
2.5.5


--0000000000006bebe605f78daf88
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
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIOEf56DqjVlm
GvHT0yjveC/KEeK/DuTbWq9Q9AjH1z76MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIzMDMyMzA5MTMwOVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBJlY8yoyhcGgB+EyaDNKrwq+k1sJZs
kHgDutpYo5/+QtsxlbUsImf51BIpFY4oj+YZBFSEHoR/Sb0wCrw4S2nZpjxHSmZNnBvwcveWAeWV
oYA6cA6szdOc4CSSR876itwQlQDUoGKql/KeVE+okaBeO7wLQHeraZzeogiWsrrAGY2J0NJPr2Az
Al9AuZtQBQD0XE3jd4xjDUbvBDx4UPE4oGiTrOT+Z68Z+5AYJ90uiEZGGUel5SMl8VtReo5Hlmcq
zb3ggxDRlffwzS6hS7MaN7UlRYkKps2yhKnwlo2dCjPhVeAD6S18S1sCfZv7w9Jw7Wira5Q6yonA
Qn4L1Bf0
--0000000000006bebe605f78daf88--
