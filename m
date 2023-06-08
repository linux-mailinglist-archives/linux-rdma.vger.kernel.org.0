Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 773EF727CF6
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Jun 2023 12:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjFHKhR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Jun 2023 06:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236031AbjFHKhO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Jun 2023 06:37:14 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46ABE6C
        for <linux-rdma@vger.kernel.org>; Thu,  8 Jun 2023 03:37:10 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-25690e009c8so213257a91.0
        for <linux-rdma@vger.kernel.org>; Thu, 08 Jun 2023 03:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1686220630; x=1688812630;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5SOsUE+OI2hVxdrf4xvI3ntlBJ4TpipHVqKAc0N8Hok=;
        b=H/tPlTYt1dU8jd2n1kM+NgxP8Fr02ywN3f0EWvTIrm9ZBpCJky+GpJT0w2ViRfZ4o4
         bW0MJOEYwiQntTv884XNLt0UUASZ/GMBsDnyuJa1rmlt1cukDKf+1Nlc+5+lCs0Bz99S
         4H8HGe8Lul1Y0xK65B4J6wO8JuokgX7ko/Bpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686220630; x=1688812630;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5SOsUE+OI2hVxdrf4xvI3ntlBJ4TpipHVqKAc0N8Hok=;
        b=LCX1wrIkNZpNky7wEafos28zc880ioGY4r5S5e5RumGqm/kMFPxllymUoXVYADJmoz
         TTqJeW/t+iXVM3gJkwMeZrYmB/PC9XvhYUjZUTGhosUZI+pGYChhDCD0NiYO46zLcW7Q
         RwvH3IUG+H5qEjKquMW97slxdv0p9CezkXjYN5bOYrSNW0Xd20GT4KFzGhRqBGFG2iST
         UaP5vd7rdw0xHECxX0jhS4D5Mukg3piRYdn7TqP0R5bO7+zTBcrvkKJHMLE6k5euHOdv
         +eevy1EBrWVX8iDOhjnqtvqyEKOT9UqEGErlEOnj4HwVKFXpcm9mOYvuKN45R7d0DtVS
         At9g==
X-Gm-Message-State: AC+VfDxRrBRI45RhCytkjNKrJWFqlU2tzGNnLrhxp8ihcBcb0NoXv8LG
        ANrk7mBBwOlfUdKdfCnfaDX3MQ==
X-Google-Smtp-Source: ACHHUZ5o76ww0DXdwubhJk7D3r0iVV2V1LMOPcB/LkXJmfn4Z+ikMxsPMgVAFuTQydMhDXU5ML/aoA==
X-Received: by 2002:a17:90b:38c5:b0:253:828a:28f8 with SMTP id nn5-20020a17090b38c500b00253828a28f8mr3759740pjb.25.1686220630243;
        Thu, 08 Jun 2023 03:37:10 -0700 (PDT)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id jj11-20020a170903048b00b001a980a23802sm1128510plb.111.2023.06.08.03.37.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Jun 2023 03:37:09 -0700 (PDT)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next 05/17] RDMA/bnxt_re: Enhance the existing functions that wait for FW responses
Date:   Thu,  8 Jun 2023 03:24:56 -0700
Message-Id: <1686219908-11181-6-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1686219908-11181-1-git-send-email-selvin.xavier@broadcom.com>
References: <1686219908-11181-1-git-send-email-selvin.xavier@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000b3ad9c05fd9bd5ce"
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

--000000000000b3ad9c05fd9bd5ce

From: Kashyap Desai <kashyap.desai@broadcom.com>

Use jiffies based timewait instead of counting iteration for
commands that block for FW response.

Also add a poll routine for control path commands. This is for
polling completion if the waiting commands timeout. This avoids cases
where the driver misses completion interrupts.

Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 65 +++++++++++++++++++++++-------
 1 file changed, 51 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index 66121fb..3b242cc 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -53,37 +53,74 @@
 
 static void bnxt_qplib_service_creq(struct tasklet_struct *t);
 
-/* Hardware communication channel */
+/**
+ * __wait_for_resp   -	Don't hold the cpu context and wait for response
+ * @rcfw      -   rcfw channel instance of rdev
+ * @cookie    -   cookie to track the command
+ *
+ * Wait for command completion in sleepable context.
+ *
+ * Returns:
+ * 0 if command is completed by firmware.
+ * Non zero error code for rest of the case.
+ */
 static int __wait_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie)
 {
 	struct bnxt_qplib_cmdq_ctx *cmdq;
 	u16 cbit;
-	int rc;
+	int ret;
 
 	cmdq = &rcfw->cmdq;
 	cbit = cookie % rcfw->cmdq_depth;
-	rc = wait_event_timeout(cmdq->waitq,
-				!test_bit(cbit, cmdq->cmdq_bitmap),
-				msecs_to_jiffies(RCFW_CMD_WAIT_TIME_MS));
-	return rc ? 0 : -ETIMEDOUT;
+
+	do {
+		/* Non zero means command completed */
+		ret = wait_event_timeout(cmdq->waitq,
+					 !test_bit(cbit, cmdq->cmdq_bitmap),
+					 msecs_to_jiffies(10000));
+
+		if (!test_bit(cbit, cmdq->cmdq_bitmap))
+			return 0;
+
+		bnxt_qplib_service_creq(&rcfw->creq.creq_tasklet);
+
+		if (!test_bit(cbit, cmdq->cmdq_bitmap))
+			return 0;
+
+	} while (true);
 };
 
+/**
+ * __block_for_resp   -	hold the cpu context and wait for response
+ * @rcfw      -   rcfw channel instance of rdev
+ * @cookie    -   cookie to track the command
+ *
+ * This function will hold the cpu (non-sleepable context) and
+ * wait for command completion. Maximum holding interval is 8 second.
+ *
+ * Returns:
+ * -ETIMEOUT if command is not completed in specific time interval.
+ * 0 if command is completed by firmware.
+ */
 static int __block_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie)
 {
-	u32 count = RCFW_BLOCKED_CMD_WAIT_COUNT;
-	struct bnxt_qplib_cmdq_ctx *cmdq;
+	struct bnxt_qplib_cmdq_ctx *cmdq = &rcfw->cmdq;
+	unsigned long issue_time = 0;
 	u16 cbit;
 
-	cmdq = &rcfw->cmdq;
 	cbit = cookie % rcfw->cmdq_depth;
-	if (!test_bit(cbit, cmdq->cmdq_bitmap))
-		goto done;
+	issue_time = jiffies;
+
 	do {
 		udelay(1);
+
 		bnxt_qplib_service_creq(&rcfw->creq.creq_tasklet);
-	} while (test_bit(cbit, cmdq->cmdq_bitmap) && --count);
-done:
-	return count ? 0 : -ETIMEDOUT;
+		if (!test_bit(cbit, cmdq->cmdq_bitmap))
+			return 0;
+
+	} while (time_before(jiffies, issue_time + (8 * HZ)));
+
+	return -ETIMEDOUT;
 };
 
 static int __send_message(struct bnxt_qplib_rcfw *rcfw,
-- 
2.5.5


--000000000000b3ad9c05fd9bd5ce
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
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIKOEc0rMB7dU
3XLg83/zag2YLQBPu4SZEBhbYV2QbeoiMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIzMDYwODEwMzcxMFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCcIE4boNfjT1x2/oM++MGADVwPTfNp
hy7W3vSKEu6Gha4jix1bq7y3U+tk1BgHOhshuG+GB1m9mq7K0/mAMEuyFs0HBzABj0ezy7dBjGSI
RWMUjqLvJULRpiGlLZtT0yGdbnPgdBRITEI/tH7koFPVHF8ADgvQsUEuUGurcl2dHQfU1OjNb/DP
wLkVmUbaMHebEOSFublNZYogmPJuOD5cMVKo4dbuLRCdMm8qeRHn/DCkY5/zR1KA73MX3sHtx++n
0TGThdh6W0m6pBRByXLGACNOk+UTeJ9FWYEqRBzOuFKjh4WNfXbYepdurMqYpF8xl9NdL4Jv//MQ
5jqWzTT0
--000000000000b3ad9c05fd9bd5ce--
