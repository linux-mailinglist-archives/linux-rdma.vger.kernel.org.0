Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3497727CFC
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Jun 2023 12:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236156AbjFHKhh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Jun 2023 06:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235695AbjFHKhd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Jun 2023 06:37:33 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBF319AC
        for <linux-rdma@vger.kernel.org>; Thu,  8 Jun 2023 03:37:22 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-51452556acdso171131a12.2
        for <linux-rdma@vger.kernel.org>; Thu, 08 Jun 2023 03:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1686220641; x=1688812641;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jOXsEoYtLnSSwCR/KPNwP+poRh7SwQECvWJsNVX177k=;
        b=M407A7X70+RGpnxRj2z6KGxgI+obbDVX7v7Bs/3j0dVg9MZVgkB7dd5SCh/l6fZyOR
         W5iCeIABn+Bjqf27B02LNBYmY3GPsE1yguTOnhKUoX1r3PN+s231ClY3MkmieeZKN+W8
         fH8lKdM98z4/Q6Jfk0Wa2vcSH5fnPQWRMoDLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686220641; x=1688812641;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jOXsEoYtLnSSwCR/KPNwP+poRh7SwQECvWJsNVX177k=;
        b=ATUl8skgdGri1sguE8SQogeAiIXdvddAZ7vg2fxC+/LL0x1C/5zI63DFPzPC1oNBsx
         8xuLzvu1SXToTHAUMkawwLdPtuwy12rKaAYInY7/5x2QGk/wIOyXne9Wnna0bzi3HG4F
         I45U7Cl0iZsioQOnlH2HgYCEyHfZX/J9mZork6x41TpP3yYkmsN4Dw+jEaLeFLymTP8q
         1otvN4kFj3mopHnnSc5kkJRPw6igyLFIxgHwmI+e8JcAI9NKma6hjy8U+o/0jlcHbvs5
         uiEWx67bNZ0uh7UOwwnWDveZD0An4rBY5GD311ikf1S/d5A8s6C59p4dFKqXAFL4KrqF
         uhag==
X-Gm-Message-State: AC+VfDz9iqlqdTDVcCgK8CxlAPHBTDjNff/B4Tz6CObJeYqdq9OvRtd6
        v173ozQ4veKbnC2P/6zaahYE3A==
X-Google-Smtp-Source: ACHHUZ4FypsE7tBOlHWG79KpcNtmJxq1dpazBl2nxN5POaDKffTp9zsR/tzBAYncZR6kmf1uWbmuDg==
X-Received: by 2002:a17:902:ee82:b0:1ae:2b97:f387 with SMTP id a2-20020a170902ee8200b001ae2b97f387mr4808268pld.21.1686220641146;
        Thu, 08 Jun 2023 03:37:21 -0700 (PDT)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id jj11-20020a170903048b00b001a980a23802sm1128510plb.111.2023.06.08.03.37.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Jun 2023 03:37:20 -0700 (PDT)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next 09/17] RDMA/bnxt_re: add helper function __poll_for_resp
Date:   Thu,  8 Jun 2023 03:25:00 -0700
Message-Id: <1686219908-11181-10-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1686219908-11181-1-git-send-email-selvin.xavier@broadcom.com>
References: <1686219908-11181-1-git-send-email-selvin.xavier@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000059c37705fd9bd6c3"
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

--00000000000059c37705fd9bd6c3

From: Kashyap Desai <kashyap.desai@broadcom.com>

This interface will be used if the driver has not enabled interrupt
and/or interrupt is disabled for a short period of time.
Completion is not possible from interrupt so this interface does
self-polling.

Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 44 +++++++++++++++++++++++++++++-
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h |  1 +
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index 15f6793..3215f8a 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -260,6 +260,44 @@ static int __send_message(struct bnxt_qplib_rcfw *rcfw,
 	return 0;
 }
 
+/**
+ * __poll_for_resp   -	self poll completion for rcfw command
+ * @rcfw      -   rcfw channel instance of rdev
+ * @cookie    -   cookie to track the command
+ * @opcode    -   rcfw submitted for given opcode
+ *
+ * It works same as __wait_for_resp except this function will
+ * do self polling in sort interval since interrupt is disabled.
+ * This function can not be called from non-sleepable context.
+ *
+ * Returns:
+ * -ETIMEOUT if command is not completed in specific time interval.
+ * 0 if command is completed by firmware.
+ */
+static int __poll_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie,
+			   u8 opcode)
+{
+	struct bnxt_qplib_cmdq_ctx *cmdq = &rcfw->cmdq;
+	unsigned long issue_time;
+	u16 cbit;
+
+	cbit = cookie % rcfw->cmdq_depth;
+	issue_time = jiffies;
+
+	do {
+		if (test_bit(ERR_DEVICE_DETACHED, &cmdq->flags))
+			return bnxt_qplib_map_rc(opcode);
+
+		usleep_range(1000, 1001);
+
+		bnxt_qplib_service_creq(&rcfw->creq.creq_tasklet);
+		if (!test_bit(cbit, cmdq->cmdq_bitmap))
+			return 0;
+		if (jiffies_to_msecs(jiffies - issue_time) > 10000)
+			return -ETIMEDOUT;
+	} while (true);
+};
+
 static int __send_message_basic_sanity(struct bnxt_qplib_rcfw *rcfw,
 				       struct bnxt_qplib_cmdqmsg *msg)
 {
@@ -328,8 +366,10 @@ static int __bnxt_qplib_rcfw_send_message(struct bnxt_qplib_rcfw *rcfw,
 
 	if (msg->block)
 		rc = __block_for_resp(rcfw, cookie, opcode);
-	else
+	else if (atomic_read(&rcfw->rcfw_intr_enabled))
 		rc = __wait_for_resp(rcfw, cookie, opcode);
+	else
+		rc = __poll_for_resp(rcfw, cookie, opcode);
 	if (rc) {
 		/* timed out */
 		dev_err(&rcfw->pdev->dev, "cmdq[%#x]=%#x timedout (%d)msec\n",
@@ -796,6 +836,7 @@ void bnxt_qplib_rcfw_stop_irq(struct bnxt_qplib_rcfw *rcfw, bool kill)
 	kfree(creq->irq_name);
 	creq->irq_name = NULL;
 	creq->requested = false;
+	atomic_set(&rcfw->rcfw_intr_enabled, 0);
 }
 
 void bnxt_qplib_disable_rcfw_channel(struct bnxt_qplib_rcfw *rcfw)
@@ -857,6 +898,7 @@ int bnxt_qplib_rcfw_start_irq(struct bnxt_qplib_rcfw *rcfw, int msix_vector,
 	creq->requested = true;
 
 	bnxt_qplib_ring_nq_db(&creq->creq_db.dbinfo, res->cctx, true);
+	atomic_inc(&rcfw->rcfw_intr_enabled);
 
 	return 0;
 }
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
index b7bbbae..089e616 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
@@ -221,6 +221,7 @@ struct bnxt_qplib_rcfw {
 	u64 oos_prev;
 	u32 init_oos_stats;
 	u32 cmdq_depth;
+	atomic_t rcfw_intr_enabled;
 	struct semaphore rcfw_inflight;
 };
 
-- 
2.5.5


--00000000000059c37705fd9bd6c3
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
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEILjdsFNhGcCJ
lV+cIXWQyCAAvDiLsarivhhmHAlMiDyvMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIzMDYwODEwMzcyMVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCTMSy8YvPcW3x+VPsE3Nmodzb+ObfP
T6U9TmF7KJ1zBUbQUTxiA8TCn7Usvy/oEXD8V8+BH/FOQ0woSnvYMfhtbtM58FzApcsd0ET6oamZ
k/qJNo2dRgq44jsQiBVEkSfyWi1pSN991zVvUwtMfBVoz5NILh7jQv3atrbSl154MNfnB0E/yq/T
U/IC5cTyPv6WlhmvUYCeaf/9DAPXYj4T3av+xScgcwe39IIc+JGmnAJ+Hh97HeYB/u64krxmG8si
JOhFr9DPZz9Y1v6RmzLmwr7K/6S6EPd3Ta7OwmdIWn33P1b8HAAZG7neXzYopRYmS28a4V7gKes4
77l/3GMM
--00000000000059c37705fd9bd6c3--
