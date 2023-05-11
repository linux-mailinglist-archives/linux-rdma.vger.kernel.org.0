Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C206FECFE
	for <lists+linux-rdma@lfdr.de>; Thu, 11 May 2023 09:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237327AbjEKHid (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 May 2023 03:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237420AbjEKHib (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 11 May 2023 03:38:31 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE65530F1
        for <linux-rdma@vger.kernel.org>; Thu, 11 May 2023 00:38:29 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-24e14a24c9dso5967531a91.0
        for <linux-rdma@vger.kernel.org>; Thu, 11 May 2023 00:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1683790709; x=1686382709;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Zazt+WbCHZDLJS1np2gSGTrz8Ohkc1wdXIT+Vc0nhz0=;
        b=PrIRocUX/yLozWEeYTK0bCCzg+C8K9TDpx6MSVbQRjfk8dh6kc2U9r++C1JyY29FYM
         M2rU4NKDWT/k8zYwYOwg7qzH9Y+/88ds6I5Ub2vvrg2NqOGZe8D1ZRC2rHA4q+HqNRCL
         HUiLbmFBTIngSfNXtt0jfp+AlF1Fj6nvCmcZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683790709; x=1686382709;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zazt+WbCHZDLJS1np2gSGTrz8Ohkc1wdXIT+Vc0nhz0=;
        b=icrqVJ0+6er/hVh+PAqwVNevzbzmQapsibHFweyJeDH0bBNf05TS8VAGfOfvF5EBxU
         8KdQtyQCoMYJJIZSjySCp+B4EmeOA587CG+0l2rivW8XkJPf+Ovz4c33KW7DSps63h/C
         faEX6BD/qX0PoLyzF6Z2kYaieZstNGWW1TlVVV8sa139EEncZZoFCxwKHISQYSao8u9v
         kuhMjcvm9SRHjHdQf0QHYiUOB96sC/1oE03rHzWwp880LgqktFXjN5qprGxmr2kD2SBq
         HpYAeoTagLqs9wZlWF42DeU/NOYihystaf25DS86FJtqPN2onBWjI7FVpBsNFNB1GcTO
         JuBg==
X-Gm-Message-State: AC+VfDwu5who2sb8+/dW5p4UfvGnNH8feyjVRssn5LtqfqxH4c+dMtgV
        9LmHSA6/cyFRTY7yAkEYjWrZFwdv8Uibh2+3gmU=
X-Google-Smtp-Source: ACHHUZ6baBwoWxC3WCzIxIek3faTYnOKw2S/++WQTR+vupifK8wRK9YhOmzSLKpTuBwWXn6zW80kWQ==
X-Received: by 2002:a17:90a:890a:b0:250:ce6a:cf1a with SMTP id u10-20020a17090a890a00b00250ce6acf1amr5664550pjn.38.1683790709293;
        Thu, 11 May 2023 00:38:29 -0700 (PDT)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id n14-20020a65488e000000b00502f4c62fd3sm4174332pgs.33.2023.05.11.00.38.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 May 2023 00:38:28 -0700 (PDT)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com,
        Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-rc 04/10] RDMA/bnxt_re: Use unique names while registering interrupts
Date:   Thu, 11 May 2023 00:26:19 -0700
Message-Id: <1683789985-22917-5-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1683789985-22917-1-git-send-email-selvin.xavier@broadcom.com>
References: <1683789985-22917-1-git-send-email-selvin.xavier@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000001fe5d105fb66130f"
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

--0000000000001fe5d105fb66130f

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

bnxt_re currently uses the names "bnxt_qplib_creq" and "bnxt_qplib_nq-0"
while registering IRQs. There is no way to distinguish the IRQs of
different device ports when there are multiple IB devices registered.
This could make the scenarios worse where one want to pin IRQs of a
device port to certain CPUs.

Fixed the code to use unique names which has PCI BDF information
while registering interrupts like: "bnxt_re-nq-0@pci:0000:65:00.0"
and "bnxt_re-creq@pci:0000:65:00.1".

Fixes: 1ac5a4047975 ("RDMA/bnxt_re: Add bnxt_re RoCE driver")
Reviewed-by: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_fp.c   | 12 ++++++++++--
 drivers/infiniband/hw/bnxt_re/qplib_fp.h   |  2 +-
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 15 +++++++++++++--
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h |  1 +
 4 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index 3c4a3bb..607ed69 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -412,6 +412,8 @@ void bnxt_qplib_nq_stop_irq(struct bnxt_qplib_nq *nq, bool kill)
 
 	irq_set_affinity_hint(nq->msix_vec, NULL);
 	free_irq(nq->msix_vec, nq);
+	kfree(nq->name);
+	nq->name = NULL;
 	nq->requested = false;
 }
 
@@ -438,6 +440,7 @@ void bnxt_qplib_disable_nq(struct bnxt_qplib_nq *nq)
 int bnxt_qplib_nq_start_irq(struct bnxt_qplib_nq *nq, int nq_indx,
 			    int msix_vector, bool need_init)
 {
+	struct bnxt_qplib_res *res = nq->res;
 	int rc;
 
 	if (nq->requested)
@@ -449,9 +452,14 @@ int bnxt_qplib_nq_start_irq(struct bnxt_qplib_nq *nq, int nq_indx,
 	else
 		tasklet_enable(&nq->nq_tasklet);
 
-	snprintf(nq->name, sizeof(nq->name), "bnxt_qplib_nq-%d", nq_indx);
+	nq->name = kasprintf(GFP_KERNEL, "bnxt_re-nq-%d@pci:%s",
+			     nq_indx, pci_name(res->pdev));
+	if (!nq->name)
+		return -ENOMEM;
 	rc = request_irq(nq->msix_vec, bnxt_qplib_nq_irq, 0, nq->name, nq);
 	if (rc) {
+		kfree(nq->name);
+		nq->name = NULL;
 		tasklet_disable(&nq->nq_tasklet);
 		return rc;
 	}
@@ -465,7 +473,7 @@ int bnxt_qplib_nq_start_irq(struct bnxt_qplib_nq *nq, int nq_indx,
 			 nq->msix_vec, nq_indx);
 	}
 	nq->requested = true;
-	bnxt_qplib_ring_nq_db(&nq->nq_db.dbinfo, nq->res->cctx, true);
+	bnxt_qplib_ring_nq_db(&nq->nq_db.dbinfo, res->cctx, true);
 
 	return rc;
 }
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.h b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
index d74d5ea..a428208 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
@@ -472,7 +472,7 @@ typedef int (*srqn_handler_t)(struct bnxt_qplib_nq *nq,
 struct bnxt_qplib_nq {
 	struct pci_dev			*pdev;
 	struct bnxt_qplib_res		*res;
-	char				name[32];
+	char				*name;
 	struct bnxt_qplib_hwq		hwq;
 	struct bnxt_qplib_nq_db		nq_db;
 	u16				ring_id;
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index a668f87..688eaa0 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -649,6 +649,8 @@ void bnxt_qplib_rcfw_stop_irq(struct bnxt_qplib_rcfw *rcfw, bool kill)
 		tasklet_kill(&creq->creq_tasklet);
 
 	free_irq(creq->msix_vec, rcfw);
+	kfree(creq->irq_name);
+	creq->irq_name = NULL;
 	creq->requested = false;
 }
 
@@ -681,9 +683,11 @@ int bnxt_qplib_rcfw_start_irq(struct bnxt_qplib_rcfw *rcfw, int msix_vector,
 			      bool need_init)
 {
 	struct bnxt_qplib_creq_ctx *creq;
+	struct bnxt_qplib_res *res;
 	int rc;
 
 	creq = &rcfw->creq;
+	res = rcfw->res;
 
 	if (creq->requested)
 		return -EFAULT;
@@ -693,15 +697,22 @@ int bnxt_qplib_rcfw_start_irq(struct bnxt_qplib_rcfw *rcfw, int msix_vector,
 		tasklet_setup(&creq->creq_tasklet, bnxt_qplib_service_creq);
 	else
 		tasklet_enable(&creq->creq_tasklet);
+
+	creq->irq_name = kasprintf(GFP_KERNEL, "bnxt_re-creq@pci:%s",
+				   pci_name(res->pdev));
+	if (!creq->irq_name)
+		return -ENOMEM;
 	rc = request_irq(creq->msix_vec, bnxt_qplib_creq_irq, 0,
-			 "bnxt_qplib_creq", rcfw);
+			 creq->irq_name, rcfw);
 	if (rc) {
+		kfree(creq->irq_name);
+		creq->irq_name = NULL;
 		tasklet_disable(&creq->creq_tasklet);
 		return rc;
 	}
 	creq->requested = true;
 
-	bnxt_qplib_ring_nq_db(&creq->creq_db.dbinfo, rcfw->res->cctx, true);
+	bnxt_qplib_ring_nq_db(&creq->creq_db.dbinfo, res->cctx, true);
 
 	return 0;
 }
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
index dd56514..92f7a25 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
@@ -186,6 +186,7 @@ struct bnxt_qplib_creq_ctx {
 	u16				ring_id;
 	int				msix_vec;
 	bool				requested; /*irq handler installed */
+	char				*irq_name;
 };
 
 /* RCFW Communication Channels */
-- 
2.5.5


--0000000000001fe5d105fb66130f
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
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIFCRJbAcoazU
b3+KrOViutNZj+3nOwQyeOVA3/RfhhDqMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIzMDUxMTA3MzgyOVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQDPC5np+PnVYHcUwdXXeWF7L5Dt9fm/
hebQam9ufLGfg5HUigdzycrjuz9YJzuMeyylhksF3aHUSjz3DG9r2Fuji1PxLrLomn9Gfd1PKaHp
L5EgV5Ni0SGRWdVsYp89wJFXuGG7dQu6Ejzl8DGIbB9KffNYyAeLGhNEufCT7CGFNCPYSoCSb/Sj
cZdxqUA9vZ++uj2buypHQtINaSpFr3xyIC14gV1soGxSXgHifcPxaCUhgs1NVKYs5yQ3q2Okgj5Y
sN8nm9rn2Vu8sSl7Pa5pXxFhcquMQINcoZNTvsxKdDEXAqX28PZhpI+KN6rKo2QfOC0M7nb3Jh9I
BjrdFZ4+
--0000000000001fe5d105fb66130f--
