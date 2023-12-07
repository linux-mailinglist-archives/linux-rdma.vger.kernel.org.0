Return-Path: <linux-rdma+bounces-302-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 666CA808652
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Dec 2023 12:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEF2C2840C0
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Dec 2023 11:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2587364DD;
	Thu,  7 Dec 2023 11:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fOIb+BEJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3CDE9
	for <linux-rdma@vger.kernel.org>; Thu,  7 Dec 2023 03:04:28 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-5c690c3d113so585124a12.1
        for <linux-rdma@vger.kernel.org>; Thu, 07 Dec 2023 03:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1701947068; x=1702551868; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E+dNalUpscdL0ZyB2UcxWzrslPTMWhM68Xxsxr8FZ2w=;
        b=fOIb+BEJtYnngCJCep1QjWIljMWKzu7kSrnGP6Wf49FRcYrRnRkqkFcmpBW3TnLD9F
         WCrv3mTp+ojVvMAdaIPdnXLCX36HCE6xyXlXE70+XeL8auynHsimdO+1ax4BnehfdJYA
         /lJED2EO4RNXsyVIC+6Fr9JQmS8IoFrnMy74Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701947068; x=1702551868;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E+dNalUpscdL0ZyB2UcxWzrslPTMWhM68Xxsxr8FZ2w=;
        b=Cx6xkrfINjmsIrSa9RR06aIgarBRd4Q9LLqvpgqjB0SlWXcW+xmX0RLGf2uXKTOQjp
         8pmA1U17vSXmGahgGVE6w+j/U7fD9VfQMIdB5fUdowI/LrOQzOQFHh8nLFWB9RB+pFXo
         pEWTk/Y/J0h/M37T4f6ef8qQGKM4kwQeTxMWiW3HJsPwhYBLsrQyzIdG0XI0jXLRXNHl
         oGa/vvAky+RgjGXNt06s+VznFNAgeS60IC46i9f0a+xQTIGS0VGlHN8AuAKaD1YwqBqq
         uaL2VMgw7xlhHashY77kJVZj7p/qx2vFN8fbnlFdqVac5iQgMWYClOY76/05Byy2Bel0
         iBog==
X-Gm-Message-State: AOJu0YxgMe3h3ZcoHvIV4jxaUw3OMiy9ryu+iwxnAnR9Kf1OIhVO3c12
	+EFikvzo0kDUnySB+qaaLkaHYfhGr45wnCYnORY=
X-Google-Smtp-Source: AGHT+IGnwJuBJOnbB9hfmBxKkZlboQc9sNRQEPqBMrDi8XBtFACHkMag10shCYt7fBb1bMQshJeZ4g==
X-Received: by 2002:a17:90b:4cc2:b0:286:6cc0:caea with SMTP id nd2-20020a17090b4cc200b002866cc0caeamr2269086pjb.97.1701947068183;
        Thu, 07 Dec 2023 03:04:28 -0800 (PST)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id pm2-20020a17090b3c4200b00285db538b17sm1034254pjb.41.2023.12.07.03.04.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Dec 2023 03:04:27 -0800 (PST)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next 2/6] RDMA/bnxt_re: Update the BAR offsets
Date: Thu,  7 Dec 2023 02:47:36 -0800
Message-Id: <1701946060-13931-3-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1701946060-13931-1-git-send-email-selvin.xavier@broadcom.com>
References: <1701946060-13931-1-git-send-email-selvin.xavier@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000072fb18060be96ed1"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

--00000000000072fb18060be96ed1

Update the BAR offsets for handling GenP7 adapters.
Use the values populated by L2 driver for getting the
Doorbell offsets.

Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/main.c     | 21 +++++++--------------
 drivers/infiniband/hw/bnxt_re/qplib_sp.c |  5 +++--
 2 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 09c0b2e..b7134d5 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -107,8 +107,11 @@ static void bnxt_re_set_db_offset(struct bnxt_re_dev *rdev)
 		dev_info(rdev_to_dev(rdev),
 			 "Couldn't get DB bar size, Low latency framework is disabled\n");
 	/* set register offsets for both UC and WC */
-	res->dpi_tbl.ucreg.offset = res->is_vf ? BNXT_QPLIB_DBR_VF_DB_OFFSET :
-						 BNXT_QPLIB_DBR_PF_DB_OFFSET;
+	if (bnxt_qplib_is_chip_gen_p7(cctx))
+		res->dpi_tbl.ucreg.offset = offset;
+	else
+		res->dpi_tbl.ucreg.offset = res->is_vf ? BNXT_QPLIB_DBR_VF_DB_OFFSET :
+							 BNXT_QPLIB_DBR_PF_DB_OFFSET;
 	res->dpi_tbl.wcreg.offset = res->dpi_tbl.ucreg.offset;
 
 	/* If WC mapping is disabled by L2 driver then en_dev->l2_db_size
@@ -1212,16 +1215,6 @@ static int bnxt_re_cqn_handler(struct bnxt_qplib_nq *nq,
 	return 0;
 }
 
-#define BNXT_RE_GEN_P5_PF_NQ_DB		0x10000
-#define BNXT_RE_GEN_P5_VF_NQ_DB		0x4000
-static u32 bnxt_re_get_nqdb_offset(struct bnxt_re_dev *rdev, u16 indx)
-{
-	return bnxt_qplib_is_chip_gen_p5_p7(rdev->chip_ctx) ?
-		(rdev->is_virtfn ? BNXT_RE_GEN_P5_VF_NQ_DB :
-				   BNXT_RE_GEN_P5_PF_NQ_DB) :
-				   rdev->en_dev->msix_entries[indx].db_offset;
-}
-
 static void bnxt_re_cleanup_res(struct bnxt_re_dev *rdev)
 {
 	int i;
@@ -1242,7 +1235,7 @@ static int bnxt_re_init_res(struct bnxt_re_dev *rdev)
 	bnxt_qplib_init_res(&rdev->qplib_res);
 
 	for (i = 1; i < rdev->num_msix ; i++) {
-		db_offt = bnxt_re_get_nqdb_offset(rdev, i);
+		db_offt = rdev->en_dev->msix_entries[i].db_offset;
 		rc = bnxt_qplib_enable_nq(rdev->en_dev->pdev, &rdev->nq[i - 1],
 					  i - 1, rdev->en_dev->msix_entries[i].vector,
 					  db_offt, &bnxt_re_cqn_handler,
@@ -1653,7 +1646,7 @@ static int bnxt_re_dev_init(struct bnxt_re_dev *rdev, u8 wqe_mode)
 		ibdev_err(&rdev->ibdev, "Failed to allocate CREQ: %#x\n", rc);
 		goto free_rcfw;
 	}
-	db_offt = bnxt_re_get_nqdb_offset(rdev, BNXT_RE_AEQ_IDX);
+	db_offt = rdev->en_dev->msix_entries[BNXT_RE_AEQ_IDX].db_offset;
 	vid = rdev->en_dev->msix_entries[BNXT_RE_AEQ_IDX].vector;
 	rc = bnxt_qplib_enable_rcfw_channel(&rdev->rcfw,
 					    vid, db_offt,
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.c b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
index c580bf7..8beeedd 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
@@ -151,8 +151,9 @@ int bnxt_qplib_get_dev_attr(struct bnxt_qplib_rcfw *rcfw,
 	attr->max_srq_sges = sb->max_srq_sge;
 	attr->max_pkey = 1;
 	attr->max_inline_data = le32_to_cpu(sb->max_inline_data);
-	attr->l2_db_size = (sb->l2_db_space_size + 1) *
-			    (0x01 << RCFW_DBR_BASE_PAGE_SHIFT);
+	if (!bnxt_qplib_is_chip_gen_p7(rcfw->res->cctx))
+		attr->l2_db_size = (sb->l2_db_space_size + 1) *
+				    (0x01 << RCFW_DBR_BASE_PAGE_SHIFT);
 	attr->max_sgid = BNXT_QPLIB_NUM_GIDS_SUPPORTED;
 	attr->dev_cap_flags = le16_to_cpu(sb->dev_cap_flags);
 
-- 
2.5.5


--00000000000072fb18060be96ed1
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
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIPxO9SadbliY
VaI7e/0Q0yvVVyrF9eWfTHtrs68wFZ/bMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIzMTIwNzExMDQyOFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQDSDGoYxm/Bwsn15boNexFMTkqwz95E
Ll6fjli872Q8PT6bz5z5STa+MYdoMASQ8bFeI6tEi91Bk0KbXo7JjymKyC48EKlt9n36BArb7+xz
hYiO8XsaE/SbFrmaP+w/GFJykqk6QCHbdLaMixUaNCrqoJJUTsFavr+j6aqgpTBWBKTu8OvISzDI
krY2Gr6ioLZ4nOdb5KSKRpx4Rr2JO6Qu/f+k6gurBPSwTO8VNxfxnKt5e1RvNZjMa21m49nRXS3y
QB3fx+43o1Na3K60/R7IXxxtj8FoTwpo5Lq9WatcsnRIsKD0FlADfZX8RxfV/CnHMunsnbqllHXX
KukWZsJT
--00000000000072fb18060be96ed1--

