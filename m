Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C3E6DC631
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Apr 2023 13:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjDJLM4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Apr 2023 07:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjDJLMz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 Apr 2023 07:12:55 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA64461A1
        for <linux-rdma@vger.kernel.org>; Mon, 10 Apr 2023 04:12:27 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-244acf4a2f5so227402a91.3
        for <linux-rdma@vger.kernel.org>; Mon, 10 Apr 2023 04:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1681125146; x=1683717146;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I8yJbNj2w6Ac5Iug87lm1/x6+H54f/cBnMyU6pMi5UQ=;
        b=d4JMqSha40zfneLu8fct1vQQxZFraW/GvTi5t0g07kqwLT3cNfV9kyxCmxcGC3xPUo
         NeHsHmrY+FFBF1KT3DtnKO0k84+3usvqEfrLxr3kQaUf69mXPsr4u3ueMHJb4IxnXYF9
         UuzXyYkxQwgTSaP55rPSII/dB47+iuEaHglEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681125146; x=1683717146;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I8yJbNj2w6Ac5Iug87lm1/x6+H54f/cBnMyU6pMi5UQ=;
        b=O8MWLKWQhwThBRoX22IfNRTu4RswXbaNDJzFsC6MkFaI3MdRCLzZJn9O7f1C7pHXPH
         7LmQiqy+K7bxD2hkHBKBP3mYYv+i39rA6vi1Y0czV8E/0sTfVI1QXRVQcfRaGNVMRJ7I
         HPq4vnHkzTgjkMbSDncgoHaqMXhme4ZRCGQvUXlLFVb96RmB4m6LhpLa7pswRZgtNAmB
         WqMy8Re/mFrNkeDOAJJjNHflu8ZyhBBTlwE42W84H0RqpNO734pLG2N0hAByjVnqmVdF
         9NOA/RFRhNw2WLpeQlgvI2p0+rPPEQWsQ8RVcSTD6C6h8RmUk1ZZA0dkJDWxHhjdcVu2
         xWkw==
X-Gm-Message-State: AAQBX9c2vb4eww0Q7VokCqC3Bfn65+43qlsGucppUyeUMtzzcRBnhglN
        ObGFMk7NeHFQ/HZVAOokDjrjmQ==
X-Google-Smtp-Source: AKy350ZKKHxhTptGx+VO0QxKDVpK/T2734FudSYEXr2F2CORjIm1vkqLymr0QamrJJ1WGv1+U0zaIA==
X-Received: by 2002:a62:84c6:0:b0:62d:9b86:632 with SMTP id k189-20020a6284c6000000b0062d9b860632mr13317776pfd.9.1681125146411;
        Mon, 10 Apr 2023 04:12:26 -0700 (PDT)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id y10-20020aa7854a000000b005ded4825201sm7641875pfn.112.2023.04.10.04.12.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Apr 2023 04:12:25 -0700 (PDT)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next 6/6] RDMA/bnxt_re: Enable low latency push
Date:   Mon, 10 Apr 2023 04:11:55 -0700
Message-Id: <1681125115-7127-7-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1681125115-7127-1-git-send-email-selvin.xavier@broadcom.com>
References: <1681125115-7127-1-git-send-email-selvin.xavier@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000031dc4305f8f973e7"
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MIME_HEADER_CTYPE_ONLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_TVD_MIME_NO_HEADERS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--00000000000031dc4305f8f973e7

Enabling the low latency push in Gen P5 adapters for small
packets. This is supported only for the user space QPs.
Introduce new mmap flag for write combine buffers.
Allocate separate Write Combine pages from BAR when Low
latency push mode is enabled in HW.

Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c  | 43 +++++++++++++++++++++++++++++++
 drivers/infiniband/hw/bnxt_re/ib_verbs.h  |  4 ++-
 drivers/infiniband/hw/bnxt_re/main.c      | 10 +++++++
 drivers/infiniband/hw/bnxt_re/qplib_res.c |  3 +++
 drivers/infiniband/hw/bnxt_re/qplib_res.h |  3 ++-
 include/uapi/rdma/bnxt_re-abi.h           |  9 +++++++
 6 files changed, 70 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index e2468b8..591ee82 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -566,6 +566,9 @@ int bnxt_re_dealloc_pd(struct ib_pd *ib_pd, struct ib_udata *udata)
 
 	if (udata) {
 		rdma_user_mmap_entry_remove(pd->pd_db_mmap);
+		if (pd->pd_wcdb_mmap)
+			rdma_user_mmap_entry_remove(pd->pd_wcdb_mmap);
+		pd->pd_wcdb_mmap = NULL;
 		pd->pd_db_mmap = NULL;
 	}
 
@@ -597,6 +600,7 @@ int bnxt_re_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 	}
 
 	if (udata) {
+		struct bnxt_qplib_chip_ctx *cctx = rdev->chip_ctx;
 		struct bnxt_re_pd_resp resp = {};
 
 		if (!ucntx->dpi.dbr) {
@@ -606,9 +610,23 @@ int bnxt_re_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 			 */
 			if (bnxt_qplib_alloc_dpi(&rdev->qplib_res,
 						 &ucntx->dpi, ucntx, BNXT_QPLIB_DPI_TYPE_UC)) {
+				dev_err(rdev_to_dev(rdev), "DP alloc failed");
 				rc = -ENOMEM;
 				goto dbfail;
 			}
+			if (cctx->modes.db_push) {
+				rc = bnxt_qplib_alloc_dpi(&rdev->qplib_res, &ucntx->wcdpi,
+							  ucntx, BNXT_QPLIB_DPI_TYPE_WC);
+				if (rc) {
+					dev_err(rdev_to_dev(rdev), "push dp alloc failed");
+					bnxt_qplib_dealloc_dpi(&rdev->qplib_res, &ucntx->dpi);
+					ucntx->dpi.dbr = NULL;
+					rc = -ENOMEM;
+					goto dbfail;
+				}
+				resp.wcdpi = ucntx->wcdpi.dpi;
+				resp.comp_mask = BNXT_RE_COMP_MASK_PD_HAS_WC_DPI;
+			}
 		}
 
 		resp.pdid = pd->qplib_pd.id;
@@ -625,6 +643,16 @@ int bnxt_re_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 			goto dbfail;
 		}
 
+		pd->pd_wcdb_mmap = bnxt_re_mmap_entry_insert(ucntx, (u64)ucntx->wcdpi.umdbr,
+							     BNXT_RE_MMAP_WC_DB, &resp.wcdbr);
+
+		if (!pd->pd_wcdb_mmap) {
+			ibdev_err(&rdev->ibdev,
+				  "Failed to insert mmap entry\n");
+			rc = -ENOMEM;
+			goto dbfail;
+		}
+
 		rc = ib_copy_to_udata(udata, &resp, min(sizeof(resp), udata->outlen));
 		if (rc) {
 			ibdev_err(&rdev->ibdev,
@@ -4035,6 +4063,9 @@ int bnxt_re_alloc_ucontext(struct ib_ucontext *ctx, struct ib_udata *udata)
 	resp.comp_mask |= BNXT_RE_UCNTX_CMASK_HAVE_MODE;
 	resp.mode = rdev->chip_ctx->modes.wqe_mode;
 
+	if (rdev->chip_ctx->modes.db_push)
+		resp.comp_mask |= BNXT_RE_UCNTX_CMASK_WC_DPI_ENABLED;
+
 	uctx->shpage_mmap = bnxt_re_mmap_entry_insert(uctx, 0, BNXT_RE_MMAP_SH_PAGE, NULL);
 	if (!uctx->shpage_mmap) {
 		ibdev_err(ibdev, "Failed to create mmap entry for shared page\n");
@@ -4074,6 +4105,10 @@ void bnxt_re_dealloc_ucontext(struct ib_ucontext *ib_uctx)
 		/* Free DPI only if this is the first PD allocated by the
 		 * application and mark the context dpi as NULL
 		 */
+		if (uctx->wcdpi.dbr) {
+			bnxt_qplib_dealloc_dpi(&rdev->qplib_res, &uctx->wcdpi);
+			uctx->wcdpi.dbr = NULL;
+		}
 		bnxt_qplib_dealloc_dpi(&rdev->qplib_res, &uctx->dpi);
 		uctx->dpi.dbr = NULL;
 	}
@@ -4103,6 +4138,14 @@ int bnxt_re_mmap(struct ib_ucontext *ib_uctx, struct vm_area_struct *vma)
 				  rdma_entry);
 
 	switch (bnxt_entry->mmap_flag) {
+	case BNXT_RE_MMAP_WC_DB:
+		pfn = bnxt_entry->mem_offset >> PAGE_SHIFT;
+		ret = rdma_user_mmap_io(ib_uctx, vma, pfn, PAGE_SIZE,
+					pgprot_writecombine(vma->vm_page_prot),
+					rdma_entry);
+		if (ret)
+			ibdev_err(&rdev->ibdev, "Failed to map WC DB");
+		break;
 	case BNXT_RE_MMAP_UC_DB:
 		pfn = bnxt_entry->mem_offset >> PAGE_SHIFT;
 		ret = rdma_user_mmap_io(ib_uctx, vma, pfn, PAGE_SIZE,
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
index dcd31ae..faf1481 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
@@ -61,6 +61,7 @@ struct bnxt_re_pd {
 	struct bnxt_qplib_pd	qplib_pd;
 	struct bnxt_re_fence_data fence;
 	struct rdma_user_mmap_entry *pd_db_mmap;
+	struct rdma_user_mmap_entry *pd_wcdb_mmap;
 };
 
 struct bnxt_re_ah {
@@ -135,6 +136,7 @@ struct bnxt_re_ucontext {
 	struct ib_ucontext      ib_uctx;
 	struct bnxt_re_dev	*rdev;
 	struct bnxt_qplib_dpi	dpi;
+	struct bnxt_qplib_dpi   wcdpi;
 	void			*shpg;
 	spinlock_t		sh_lock;	/* protect shpg */
 	struct rdma_user_mmap_entry *shpage_mmap;
@@ -143,6 +145,7 @@ struct bnxt_re_ucontext {
 enum bnxt_re_mmap_flag {
 	BNXT_RE_MMAP_SH_PAGE,
 	BNXT_RE_MMAP_UC_DB,
+	BNXT_RE_MMAP_WC_DB,
 };
 
 struct bnxt_re_user_mmap_entry {
@@ -228,7 +231,6 @@ void bnxt_re_dealloc_ucontext(struct ib_ucontext *context);
 int bnxt_re_mmap(struct ib_ucontext *context, struct vm_area_struct *vma);
 void bnxt_re_mmap_free(struct rdma_user_mmap_entry *rdma_entry);
 
-
 unsigned long bnxt_re_lock_cqs(struct bnxt_re_qp *qp);
 void bnxt_re_unlock_cqs(struct bnxt_re_qp *qp, unsigned long flags);
 #endif /* __BNXT_RE_IB_VERBS_H__ */
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index cfd3708..824dc3b 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -117,6 +117,11 @@ static void bnxt_re_set_db_offset(struct bnxt_re_dev *rdev)
 	 * in such cases and DB-push will be disabled.
 	 */
 	barlen = pci_resource_len(res->pdev, RCFW_DBR_PCI_BAR_REGION);
+	if (cctx->modes.db_push && l2db_len && en_dev->l2_db_size != barlen) {
+		res->dpi_tbl.wcreg.offset = en_dev->l2_db_size;
+		dev_info(rdev_to_dev(rdev),
+			 "Low latency framework is enabled\n");
+	}
 }
 
 static void bnxt_re_set_drv_mode(struct bnxt_re_dev *rdev, u8 mode)
@@ -430,6 +435,11 @@ int bnxt_re_hwrm_qcaps(struct bnxt_re_dev *rdev)
 			"Failed to query capabilities, rc = %#x", rc);
 		return rc;
 	}
+	cctx->modes.db_push = le32_to_cpu(resp.flags) & FUNC_QCAPS_RESP_FLAGS_WCB_PUSH_MODE;
+
+	if (cctx->modes.db_push)
+		ibdev_dbg(&rdev->ibdev, "DB push enabled");
+
 	return 0;
 }
 
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.c b/drivers/infiniband/hw/bnxt_re/qplib_res.c
index bb3087d..5483778 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.c
@@ -741,6 +741,9 @@ int bnxt_qplib_alloc_dpi(struct bnxt_qplib_res *res,
 		dpi->dbr = dpit->priv_db;
 		dpi->dpi = dpi->bit;
 		break;
+	case BNXT_QPLIB_DPI_TYPE_WC:
+		dpi->dbr = ioremap_wc(umaddr, PAGE_SIZE);
+		break;
 	default:
 		dpi->dbr = ioremap(umaddr, PAGE_SIZE);
 		break;
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.h b/drivers/infiniband/hw/bnxt_re/qplib_res.h
index 95b1d6c..dc39f67 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.h
@@ -47,7 +47,7 @@ extern const struct bnxt_qplib_gid bnxt_qplib_gid_zero;
 
 struct bnxt_qplib_drv_modes {
 	u8	wqe_mode;
-	/* Other modes to follow here */
+	bool db_push;
 };
 
 struct bnxt_qplib_chip_ctx {
@@ -193,6 +193,7 @@ struct bnxt_qplib_sgid_tbl {
 enum {
 	BNXT_QPLIB_DPI_TYPE_KERNEL      = 0,
 	BNXT_QPLIB_DPI_TYPE_UC          = 1,
+	BNXT_QPLIB_DPI_TYPE_WC          = 2
 };
 
 struct bnxt_qplib_dpi {
diff --git a/include/uapi/rdma/bnxt_re-abi.h b/include/uapi/rdma/bnxt_re-abi.h
index c4e9077..719f1fe 100644
--- a/include/uapi/rdma/bnxt_re-abi.h
+++ b/include/uapi/rdma/bnxt_re-abi.h
@@ -51,6 +51,7 @@
 enum {
 	BNXT_RE_UCNTX_CMASK_HAVE_CCTX = 0x1ULL,
 	BNXT_RE_UCNTX_CMASK_HAVE_MODE = 0x02ULL,
+	BNXT_RE_UCNTX_CMASK_WC_DPI_ENABLED = 0x04ULL,
 };
 
 enum bnxt_re_wqe_mode {
@@ -78,10 +79,18 @@ struct bnxt_re_uctx_resp {
  * not 8 byted aligned. To avoid undesired padding in various cases we have to
  * set this struct to packed.
  */
+enum {
+	BNXT_RE_COMP_MASK_PD_HAS_WC_DPI = 0x01,
+};
+
 struct bnxt_re_pd_resp {
 	__u32 pdid;
 	__u32 dpi;
 	__u64 dbr;
+	__u64 comp_mask;
+	__u32 rsvd;
+	__u32 wcdpi;
+	__u64 wcdbr;
 } __attribute__((packed, aligned(4)));
 
 struct bnxt_re_cq_req {
-- 
2.5.5


--00000000000031dc4305f8f973e7
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
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEINN9VGMriN0b
e0kNymq6jiF5aop9Wow7VfqlA+VuUkNWMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIzMDQxMDExMTIyNlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBEqaFtYsJrmvddcl/04nLiI4iWVzfe
PDzMq/98Lpc3M7DYkknLo7i5P0ZsQ5WK0eva+E2KTfEr+TIlYn89ap7XsKA4H1+hw03+9wTZQifu
i7ShMqQP7hkCsSy3fptFTWSE48DZMsV8MMNNpYHTg3S4yIDZNoozO+6H8U0rY+F0sjUKNr5XW5s2
0pNv0KGuqjkUCKMbJbkWY6esvnkKUm9qpDjKXlO1HKMMJDaoom9PQ5TjwHGdSQ0VKpmMT+27Z5q3
SSlPVgLJzYxOL6LT63mY7NQOBdBMmNaco9acyAhD1GFbhiYMP+AxfkvtcIDryRLd7ZiEl3zOOO1m
I+/NBROq
--00000000000031dc4305f8f973e7--
