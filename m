Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3E93732738
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Jun 2023 08:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjFPGTg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Jun 2023 02:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbjFPGTd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 16 Jun 2023 02:19:33 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7B710E9
        for <linux-rdma@vger.kernel.org>; Thu, 15 Jun 2023 23:19:33 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-666669bb882so450535b3a.1
        for <linux-rdma@vger.kernel.org>; Thu, 15 Jun 2023 23:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1686896372; x=1689488372;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=uXPiL1PAF4V7Ybxk1Vbr8Vy8WM9X5iVchsoZ4C341tk=;
        b=aGIf4eRu61eF2wT+QGdNLOb/txjq7DfYGtOVdZ4bQx1qqRjSaDAsQ9NTbK++3s8iyg
         kB2GTxoP8kIvdYt68WO19bbGxtGIMy86q9qA3TVZsxZkoQEnXGCqBzTb4KmisheOZPg4
         4J8sLpGJ55ihisqSrdKvWg1uXkj21yv3LxtqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686896372; x=1689488372;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uXPiL1PAF4V7Ybxk1Vbr8Vy8WM9X5iVchsoZ4C341tk=;
        b=CmZzWqseOSh7Q1M1vz4jpgqfWxA58lOv7Rh6ibAs3cWX5Ybb5d8jr9m6fxYdxS8vS7
         +n914uNgxemhD+qmrtMSy+JUnzJv/NKuxigdlvljAO+VOgXluEOvrlHlwNuaglea4L1o
         ybBiloQ3BLBSlbU/psAafTicB4WX2ptn/ptJqh6Q0styO172OMTD57Eu/uyixpDToTau
         pJqnNNpz3f8GU9+0rZPza8nE2RqitoQOenNqaM6dzqKQqhRcLXwuBhLfkq8bCyEur5Dz
         IL/8TIqq7b+M+RJHmTa5m0WzEwiQY2eSvsKhm68KdGq+Uoy0FgJYcWB3cRKR8CYHiU3H
         94ww==
X-Gm-Message-State: AC+VfDzx/v9iVIGkk/q8esrCYpNg0Ncgwx9/WDU4dt7fJ/Vw4z6vOjsU
        RQ3KLx7wRMGMT7TSEw3GFrIGDt5rpw0KhU8Y8Cac3wmL77iG79b/fIoB10yKV7Lgsui8/pWszIi
        mpwLY1p9oqYfnR3wx3m8bd1hb8gElieNpbvZyo9Y39tjrjpJ3Y6d97CEoZ8l6C4VItkMrHwCjaT
        GLuR1ZcdUkqWE=
X-Google-Smtp-Source: ACHHUZ6ddxXgkYuwF0qk/mcZdqJod8A72SV0cg2SOjLgJ5VAAd3P2U8nkR/vBXsF2WKFhWpWGJx+yQ==
X-Received: by 2002:a05:6a00:14ca:b0:64d:42f6:4c7b with SMTP id w10-20020a056a0014ca00b0064d42f64c7bmr1334543pfu.27.1686896371758;
        Thu, 15 Jun 2023 23:19:31 -0700 (PDT)
Received: from amd_smc.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id c9-20020a62e809000000b0064d48d98260sm12878506pfi.156.2023.06.15.23.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 23:19:31 -0700 (PDT)
From:   Kashyap Desai <kashyap.desai@broadcom.com>
To:     linux-rdma@vger.kernel.org
Cc:     dan.carpenter@linaro.org,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next 2/2] RDMA/bnxt_re: refactor code around bnxt_qplib_map_rc
Date:   Fri, 16 Jun 2023 11:47:00 +0530
Message-Id: <20230616061700.741769-2-kashyap.desai@broadcom.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230616061700.741769-1-kashyap.desai@broadcom.com>
References: <20230616061700.741769-1-kashyap.desai@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000009aa7205fe392bd5"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--00000000000009aa7205fe392bd5
Content-Transfer-Encoding: 8bit

Updated function comment of bnxt_qplib_map_rc
Removed intermediate return value ENXIO and directly called bnxt_qplib_map_rc
from __send_message_basic_sanity.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 23 ++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index 30c6e865d691..a8323054cfee 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -57,13 +57,20 @@ static void bnxt_qplib_service_creq(struct tasklet_struct *t);
  * bnxt_qplib_map_rc  -  map return type based on opcode
  * @opcode    -  roce slow path opcode
  *
- * In some cases like firmware halt is detected, the driver is supposed to
- * remap the error code of the timed out command.
+ * case #1
+ * Firmware initiated error recovery is a safe state machine and
+ * driver can consider all the underlying rdma resources are free.
+ * In this state, it is safe to return success for opcodes related to
+ * destroying rdma resources (like destroy qp, destroy cq etc.).
  *
- * It is not safe to assume hardware is really inactive so certain opcodes
- * like destroy qp etc are not safe to be returned success, but this function
- * will be called when FW already reports a timeout. This would be possible
- * only when FW crashes and resets. This will clear all the HW resources.
+ * case #2
+ * If driver detect potential firmware stall, it is not safe state machine
+ * and the driver can not consider all the underlying rdma resources are
+ * freed.
+ * In this state, it is not safe to return success for opcodes related to
+ * destroying rdma resources (like destroy qp, destroy cq etc.).
+ *
+ * Scope of this helper function is only for case #1.
  *
  * Returns:
  * 0 to communicate success to caller.
@@ -418,7 +425,7 @@ static int __send_message_basic_sanity(struct bnxt_qplib_rcfw *rcfw,
 
 	/* Prevent posting if f/w is not in a state to process */
 	if (test_bit(ERR_DEVICE_DETACHED, &rcfw->cmdq.flags))
-		return -ENXIO;
+		return bnxt_qplib_map_rc(opcode);
 	if (test_bit(FIRMWARE_STALL_DETECTED, &cmdq->flags))
 		return -ETIMEDOUT;
 
@@ -488,7 +495,7 @@ static int __bnxt_qplib_rcfw_send_message(struct bnxt_qplib_rcfw *rcfw,
 
 	rc = __send_message_basic_sanity(rcfw, msg, opcode);
 	if (rc)
-		return rc == -ENXIO ? bnxt_qplib_map_rc(opcode) : rc;
+		return rc;
 
 	rc = __send_message(rcfw, msg);
 	if (rc)
-- 
2.27.0


--00000000000009aa7205fe392bd5
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
//gyd5clTejfGxz7u6TjAKPT7G/PY9BaxKSEf8zLsYtlHAJMVeCFF20jzwQHb5/L+5h2CkPOrrSB
JSieWyW6UjDpmJdXnnM3sqAtuQHYoZ76TqNQWkummLSqMwIDAQABo4IB2zCCAdcwDgYDVR0PAQH/
BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9i
YWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUF
BzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xv
YmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAlBgNV
HREEHjAcgRprYXNoeWFwLmRlc2FpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAf
BgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUuFb0TqXOZcrcNo5g7TmU
kbW0uVQwDQYJKoZIhvcNAQELBQADggEBAEpkK1pEFLXwM8dPS+Y+gSbbTOhzvfHfnB1tKMepSjVT
Sh0CvvfRgpBkaqZJv2+/9W5dfZejA+3xFc/G/lurpofq2yVp2Zik+RbO/FjpFfg24MHjkSr2foJm
RImddZVt810u7w3qtY2pQQ/QHCS9fHkLtz5dKfmePAebpPuX2BJ+FmPfFZyHLpLHr4CJwUU9ETgH
GRRQamqDhA+VgD34fZSymk33umJA6SDgqaX9pDs276nwbY0g8TSOZwohc/6eTzU0Gsl1jSuJezXm
/bctt3Fx6+DwYeO9905PrJUE+iBLLHPm5cHBNF9yWCy/FrP9ZMFvsUvcPiWyEWFPYhsVxAMxggJt
MIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYD
VQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwQyr9ygXXwrg7q
ph4wDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIAXjxHGHHZGhMEtWVWSnumEDofdO
KfdmluBMuQZIDnqPMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIz
MDYxNjA2MTkzMlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQCj1IkiP6IadQnUdzDYqDEPwrL1MkPOdbMfA0szdu172xqB
+CnTfgoLGhzKZVBYTjFaZder9xPRDI/sFiKYwxrQ++ifZtW1jaKNENSUWWTIoMCypa4mP+kIkdpB
dk0KC7qF07eY8Y2d6Rti1gJz6UVSKp7XYOsgKk4b+3NrQdZVbGWVTCSI2KsRIx2sf2xUSK8j/af1
jU+JABL8DlK31WrNZe4Ujwgi7zLdw5mMSzQWw1w3jubRJFtF7V/zGHRjKOLIrggHR6kjqu2aA/OQ
lgF9bLI2IRLKwV3NWHT8f1AvLnM4tqFkn6PZFWMQbzo5QH9DKu2f4xtGuMEFXaEEXyyN
--00000000000009aa7205fe392bd5--
