Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3D36FECFD
	for <lists+linux-rdma@lfdr.de>; Thu, 11 May 2023 09:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237402AbjEKHia (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 May 2023 03:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237235AbjEKHi2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 11 May 2023 03:38:28 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284952115
        for <linux-rdma@vger.kernel.org>; Thu, 11 May 2023 00:38:27 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-643a1656b79so5673408b3a.3
        for <linux-rdma@vger.kernel.org>; Thu, 11 May 2023 00:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1683790706; x=1686382706;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vRPzR3hysjgBXHiDIpMGYdQB4V+B83jsUHDv1pqm4+w=;
        b=cRKR9Sresp76gCKme8KyZtThmhIHminUapJSkcvtmahhRauM4smuquByslZe62WjER
         IBjPFoPV0CD2vHR7MksDWrneBWcyN0eP2MnENTfKWTvalJeZt2zmVHCUOw+9IXRWuOPo
         OR5iSJYq5Z9xKM3PHGWViUVyn0HfgvQag+eu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683790706; x=1686382706;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vRPzR3hysjgBXHiDIpMGYdQB4V+B83jsUHDv1pqm4+w=;
        b=Stfjv8PQv2d6UULFvzqyL3Ec0rr5NdyPS5TS+wYIRCXr0MHZrWUIJIal9cMIqt7/rX
         iRgDQKZy7MHSXy/zoer+UMfsMX3bV2ZEQYUQ56hoJnAN2U1w7m5+yVp5VMIpe4HEkv8C
         X8nEhd2eQarxQY+z99+VDXtn3I+bBfW+700skGTnTvuFQqzTja+WRA2SkeoOca2IEG/p
         9NomP6dEED2GiwsjA5I+ugsunKytqA3JLpRPjPdtjAZ+cci+shg7tKZU657T9dBAUyKb
         /hwz7elk0d3HdB0Gnh8E0eGpLtsynOWgNMiuWuxRJOYW8Hk4YwxL6RfAIEqrCOWlIuD/
         F8rQ==
X-Gm-Message-State: AC+VfDw/UZtRAEVjnk2seJpZnSEHvOkEetLS8ZulYGbLOSTOYX6tnCdA
        I24G6r9OoHu4SAiDqzCdSmXsOw==
X-Google-Smtp-Source: ACHHUZ6MtA5m6CrJkClnTMy9/YanrBz3tC8POvPfLTSOi5fEVkVSC0WJOoGu9yjd0IjVZRg1FI2uDQ==
X-Received: by 2002:a05:6a20:12cd:b0:101:7ccd:e197 with SMTP id v13-20020a056a2012cd00b001017ccde197mr9877244pzg.52.1683790706557;
        Thu, 11 May 2023 00:38:26 -0700 (PDT)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id n14-20020a65488e000000b00502f4c62fd3sm4174332pgs.33.2023.05.11.00.38.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 May 2023 00:38:25 -0700 (PDT)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH for-rc 03/10] RDMA/bnxt_re: Disable/kill tasklet only if it is enabled
Date:   Thu, 11 May 2023 00:26:18 -0700
Message-Id: <1683789985-22917-4-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1683789985-22917-1-git-send-email-selvin.xavier@broadcom.com>
References: <1683789985-22917-1-git-send-email-selvin.xavier@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000f6210705fb66121f"
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

--000000000000f6210705fb66121f

When the ulp hook to start the IRQ fails because the rings
are not available, tasklets are not enabled. In this case when
the driver is unloaded, driver calls CREQ tasklet_kill. This
causes an indefinite hang as the tasklet is not enabled.

Driver shouldn't call tasklet_kill if it is not enabled. So
using the creq->requested and nq->requested flags to identify
if both tasklets/irqs are registered. Checking this flag while
scheduling the tasklet from ISR. Also, added a cleanup for
disabling tasklet, in case request_irq fails during start_irq.

Check for return value for bnxt_qplib_rcfw_start_irq and in case
the bnxt_qplib_rcfw_start_irq fails, return bnxt_re_start_irq
without attempting to start NQ IRQs.

Fixes: 1ac5a4047975 ("RDMA/bnxt_re: Add bnxt_re RoCE driver")
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/main.c       | 12 +++++++++---
 drivers/infiniband/hw/bnxt_re/qplib_fp.c   | 16 ++++++++++------
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 14 +++++++++-----
 3 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index b9e2f89..a44f290 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -283,15 +283,21 @@ static void bnxt_re_start_irq(void *handle, struct bnxt_msix_entry *ent)
 	for (indx = 0; indx < rdev->num_msix; indx++)
 		rdev->en_dev->msix_entries[indx].vector = ent[indx].vector;
 
-	bnxt_qplib_rcfw_start_irq(rcfw, msix_ent[BNXT_RE_AEQ_IDX].vector,
-				  false);
+	rc = bnxt_qplib_rcfw_start_irq(rcfw, msix_ent[BNXT_RE_AEQ_IDX].vector,
+				       false);
+	if (rc) {
+		ibdev_warn(&rdev->ibdev, "Failed to reinit CREQ\n");
+		return;
+	}
 	for (indx = BNXT_RE_NQ_IDX ; indx < rdev->num_msix; indx++) {
 		nq = &rdev->nq[indx - 1];
 		rc = bnxt_qplib_nq_start_irq(nq, indx - 1,
 					     msix_ent[indx].vector, false);
-		if (rc)
+		if (rc) {
 			ibdev_warn(&rdev->ibdev, "Failed to reinit NQ index %d\n",
 				   indx - 1);
+			return;
+		}
 	}
 }
 
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index e42c756..3c4a3bb 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -399,6 +399,9 @@ static irqreturn_t bnxt_qplib_nq_irq(int irq, void *dev_instance)
 
 void bnxt_qplib_nq_stop_irq(struct bnxt_qplib_nq *nq, bool kill)
 {
+	if (!nq->requested)
+		return;
+
 	tasklet_disable(&nq->nq_tasklet);
 	/* Mask h/w interrupt */
 	bnxt_qplib_ring_nq_db(&nq->nq_db.dbinfo, nq->res->cctx, false);
@@ -406,11 +409,10 @@ void bnxt_qplib_nq_stop_irq(struct bnxt_qplib_nq *nq, bool kill)
 	synchronize_irq(nq->msix_vec);
 	if (kill)
 		tasklet_kill(&nq->nq_tasklet);
-	if (nq->requested) {
-		irq_set_affinity_hint(nq->msix_vec, NULL);
-		free_irq(nq->msix_vec, nq);
-		nq->requested = false;
-	}
+
+	irq_set_affinity_hint(nq->msix_vec, NULL);
+	free_irq(nq->msix_vec, nq);
+	nq->requested = false;
 }
 
 void bnxt_qplib_disable_nq(struct bnxt_qplib_nq *nq)
@@ -449,8 +451,10 @@ int bnxt_qplib_nq_start_irq(struct bnxt_qplib_nq *nq, int nq_indx,
 
 	snprintf(nq->name, sizeof(nq->name), "bnxt_qplib_nq-%d", nq_indx);
 	rc = request_irq(nq->msix_vec, bnxt_qplib_nq_irq, 0, nq->name, nq);
-	if (rc)
+	if (rc) {
+		tasklet_disable(&nq->nq_tasklet);
 		return rc;
+	}
 
 	cpumask_clear(&nq->mask);
 	cpumask_set_cpu(nq_indx, &nq->mask);
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index de90691..a668f87 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -636,6 +636,10 @@ void bnxt_qplib_rcfw_stop_irq(struct bnxt_qplib_rcfw *rcfw, bool kill)
 	struct bnxt_qplib_creq_ctx *creq;
 
 	creq = &rcfw->creq;
+
+	if (!creq->requested)
+		return;
+
 	tasklet_disable(&creq->creq_tasklet);
 	/* Mask h/w interrupts */
 	bnxt_qplib_ring_nq_db(&creq->creq_db.dbinfo, rcfw->res->cctx, false);
@@ -644,10 +648,8 @@ void bnxt_qplib_rcfw_stop_irq(struct bnxt_qplib_rcfw *rcfw, bool kill)
 	if (kill)
 		tasklet_kill(&creq->creq_tasklet);
 
-	if (creq->requested) {
-		free_irq(creq->msix_vec, rcfw);
-		creq->requested = false;
-	}
+	free_irq(creq->msix_vec, rcfw);
+	creq->requested = false;
 }
 
 void bnxt_qplib_disable_rcfw_channel(struct bnxt_qplib_rcfw *rcfw)
@@ -693,8 +695,10 @@ int bnxt_qplib_rcfw_start_irq(struct bnxt_qplib_rcfw *rcfw, int msix_vector,
 		tasklet_enable(&creq->creq_tasklet);
 	rc = request_irq(creq->msix_vec, bnxt_qplib_creq_irq, 0,
 			 "bnxt_qplib_creq", rcfw);
-	if (rc)
+	if (rc) {
+		tasklet_disable(&creq->creq_tasklet);
 		return rc;
+	}
 	creq->requested = true;
 
 	bnxt_qplib_ring_nq_db(&creq->creq_db.dbinfo, rcfw->res->cctx, true);
-- 
2.5.5


--000000000000f6210705fb66121f
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
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEILEbP/9vdKO8
BpMzFverD15f8X4Fn1yJEuhQOet8nCluMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIzMDUxMTA3MzgyNlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCi0uE+8Vx9lHlN6d4dhCVWplaYzgcC
YJXYW4pMnrYWLhrUTCFBi6nj5J2RgNBNsGFQHqTLxWN3kjsyfQ0JAKTVaQHlFA1/MFIyAR9ekdFf
3Nf+abRIoBZQML9E2HG8OBvhCLenO8YSMLxt7HAckjx0MOUsNsVbN0XxDFkIUNVgRFqAMHrZ6xfS
g2chAmpZMYzp6YH0rC3pqQTOUqeUDJir7DkY/ldvmuxz5NxyYoYnh8TkUm9Srw/RHlcynZFV2Ajb
uOnMvfl4n3inH2f2RRiVgTNJt67cyJAyQ2zEBeDRlZP4Tz8Xah75JNerTvYELz1s17nwgv0aMPYe
50nG6eVJ
--000000000000f6210705fb66121f--
