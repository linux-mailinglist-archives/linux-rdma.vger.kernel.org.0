Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3701D719ADE
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Jun 2023 13:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjFALWa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Jun 2023 07:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbjFALW3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Jun 2023 07:22:29 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2827124
        for <linux-rdma@vger.kernel.org>; Thu,  1 Jun 2023 04:22:27 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b0236ee816so6160135ad.1
        for <linux-rdma@vger.kernel.org>; Thu, 01 Jun 2023 04:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1685618547; x=1688210547;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=c+u/BBo4fpntI8i52q2dNUTwRLbVZZGyImR22dcQ17o=;
        b=RkoPh/NF8+kGldcfcVHKPFtAkbai0o+fhS+gcdXSybL13iDlTx8zHg+XGL5INCHU4A
         mxYQ4Dmebb2TaPLJnfjRX8QKBTqqmY+xzgJhff79WOgLoDFHj4qfZJn4bg24q0q2tRnL
         sK+ykqet+6STZbD1FPNT4loYm07jCbNYJRKkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685618547; x=1688210547;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c+u/BBo4fpntI8i52q2dNUTwRLbVZZGyImR22dcQ17o=;
        b=bZZ52CRyUceEsJaG+66K+i7nNvnF6R55Y57k/jXfXCvneUmbG0Y6SmrNHiz1sCkXyH
         ZO5QTGDEF6xZuf0t8Czc0exy6sE3UohAYa9LRxyEcpdKkHWzaNqEqX31GNMZOiaQZDLV
         MZf0Alqrd/pmlW3xbrJN+SySLXV/lv36xL1HOYit1Iop+hDRdBDtSRPL/jJUyoS1vFA3
         uAVjYxYCyz3VRw5BCy3VYotsvxr9gGmclseiAhfxnz+hCIW2aGLxCih17pvkPhO2N8d+
         fYhq6AJcNj9SZoQ6FgpkHHDdM754OJoDBYalAT7tTY9QfViFngGjEO9DGBdLsPp71PCo
         VGSQ==
X-Gm-Message-State: AC+VfDyyIg+b8akGSNDqJbHSiy/H9MYbnjXaujVQpZAxjG5zaFTGpT7R
        n9n0QEnlBXLWtcMDbNmQXaDIOZmrl82yX22TtH0=
X-Google-Smtp-Source: ACHHUZ5PjpXcxCvzpmapnehgvbHPbTVEBGLV29OtA8HBrgkREfViZyHTZ8vy559Xv/sn2cWFv3ll2A==
X-Received: by 2002:a17:902:d386:b0:1af:e302:123 with SMTP id e6-20020a170902d38600b001afe3020123mr1587065pld.3.1685618547274;
        Thu, 01 Jun 2023 04:22:27 -0700 (PDT)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id n3-20020a170902e54300b001ac55a5e5eesm3216496plf.121.2023.06.01.04.22.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Jun 2023 04:22:26 -0700 (PDT)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH v4 for-next 1/6] RDMA/bnxt_re: Use the common mmap helper functions
Date:   Thu,  1 Jun 2023 04:10:32 -0700
Message-Id: <1685617837-15725-2-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1685617837-15725-1-git-send-email-selvin.xavier@broadcom.com>
References: <1685617837-15725-1-git-send-email-selvin.xavier@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000c2ed7205fd0fa6b8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        MIME_HEADER_CTYPE_ONLY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_TVD_MIME_NO_HEADERS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--000000000000c2ed7205fd0fa6b8

Replace the mmap handling function with common code in
IB core. Create rdma_user_mmap_entry for each mmap
resource and add to the ib_core mmap list. Add mmap_free
verb support. Also, use rdma_user_mmap_io while mapping
Doorbell pages.

Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c  | 113 ++++++++++++++++++++++++------
 drivers/infiniband/hw/bnxt_re/ib_verbs.h  |  15 ++++
 drivers/infiniband/hw/bnxt_re/main.c      |   1 +
 drivers/infiniband/hw/bnxt_re/qplib_res.c |   2 +-
 4 files changed, 107 insertions(+), 24 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index e86afec..2434174 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -533,12 +533,43 @@ static int bnxt_re_create_fence_mr(struct bnxt_re_pd *pd)
 	return rc;
 }
 
+static struct bnxt_re_user_mmap_entry*
+bnxt_re_mmap_entry_insert(struct bnxt_re_ucontext *uctx, u64 mem_offset,
+			  enum bnxt_re_mmap_flag mmap_flag, u64 *offset)
+{
+	struct bnxt_re_user_mmap_entry *entry;
+	int ret;
+
+	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		return NULL;
+
+	entry->mem_offset = mem_offset;
+	entry->mmap_flag = mmap_flag;
+
+	ret = rdma_user_mmap_entry_insert(&uctx->ib_uctx,
+					  &entry->rdma_entry, PAGE_SIZE);
+	if (ret) {
+		kfree(entry);
+		return NULL;
+	}
+	if (offset)
+		*offset = rdma_user_mmap_get_offset(&entry->rdma_entry);
+
+	return entry;
+}
+
 /* Protection Domains */
 int bnxt_re_dealloc_pd(struct ib_pd *ib_pd, struct ib_udata *udata)
 {
 	struct bnxt_re_pd *pd = container_of(ib_pd, struct bnxt_re_pd, ib_pd);
 	struct bnxt_re_dev *rdev = pd->rdev;
 
+	if (udata) {
+		rdma_user_mmap_entry_remove(pd->pd_db_mmap);
+		pd->pd_db_mmap = NULL;
+	}
+
 	bnxt_re_destroy_fence_mr(pd);
 
 	if (pd->qplib_pd.id) {
@@ -557,7 +588,8 @@ int bnxt_re_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 	struct bnxt_re_ucontext *ucntx = rdma_udata_to_drv_context(
 		udata, struct bnxt_re_ucontext, ib_uctx);
 	struct bnxt_re_pd *pd = container_of(ibpd, struct bnxt_re_pd, ib_pd);
-	int rc;
+	struct bnxt_re_user_mmap_entry *entry = NULL;
+	int rc = 0;
 
 	pd->rdev = rdev;
 	if (bnxt_qplib_alloc_pd(&rdev->qplib_res.pd_tbl, &pd->qplib_pd)) {
@@ -567,7 +599,7 @@ int bnxt_re_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 	}
 
 	if (udata) {
-		struct bnxt_re_pd_resp resp;
+		struct bnxt_re_pd_resp resp = {};
 
 		if (!ucntx->dpi.dbr) {
 			/* Allocate DPI in alloc_pd to avoid failing of
@@ -584,12 +616,21 @@ int bnxt_re_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 		resp.pdid = pd->qplib_pd.id;
 		/* Still allow mapping this DBR to the new user PD. */
 		resp.dpi = ucntx->dpi.dpi;
-		resp.dbr = (u64)ucntx->dpi.umdbr;
 
-		rc = ib_copy_to_udata(udata, &resp, sizeof(resp));
+		entry = bnxt_re_mmap_entry_insert(ucntx, (u64)ucntx->dpi.umdbr,
+						  BNXT_RE_MMAP_UC_DB, &resp.dbr);
+
+		if (!entry) {
+			rc = -ENOMEM;
+			goto dbfail;
+		}
+
+		pd->pd_db_mmap = &entry->rdma_entry;
+
+		rc = ib_copy_to_udata(udata, &resp, min(sizeof(resp), udata->outlen));
 		if (rc) {
-			ibdev_err(&rdev->ibdev,
-				  "Failed to copy user response\n");
+			rdma_user_mmap_entry_remove(pd->pd_db_mmap);
+			rc = -EFAULT;
 			goto dbfail;
 		}
 	}
@@ -3956,6 +3997,7 @@ int bnxt_re_alloc_ucontext(struct ib_ucontext *ctx, struct ib_udata *udata)
 		container_of(ctx, struct bnxt_re_ucontext, ib_uctx);
 	struct bnxt_re_dev *rdev = to_bnxt_re_dev(ibdev, ibdev);
 	struct bnxt_qplib_dev_attr *dev_attr = &rdev->dev_attr;
+	struct bnxt_re_user_mmap_entry *entry;
 	struct bnxt_re_uctx_resp resp = {};
 	u32 chip_met_rev_num = 0;
 	int rc;
@@ -3994,6 +4036,13 @@ int bnxt_re_alloc_ucontext(struct ib_ucontext *ctx, struct ib_udata *udata)
 	resp.comp_mask |= BNXT_RE_UCNTX_CMASK_HAVE_MODE;
 	resp.mode = rdev->chip_ctx->modes.wqe_mode;
 
+	entry = bnxt_re_mmap_entry_insert(uctx, 0, BNXT_RE_MMAP_SH_PAGE, NULL);
+	if (!entry) {
+		rc = -ENOMEM;
+		goto cfail;
+	}
+	uctx->shpage_mmap = &entry->rdma_entry;
+
 	rc = ib_copy_to_udata(udata, &resp, min(udata->outlen, sizeof(resp)));
 	if (rc) {
 		ibdev_err(ibdev, "Failed to copy user context");
@@ -4017,6 +4066,8 @@ void bnxt_re_dealloc_ucontext(struct ib_ucontext *ib_uctx)
 
 	struct bnxt_re_dev *rdev = uctx->rdev;
 
+	rdma_user_mmap_entry_remove(uctx->shpage_mmap);
+	uctx->shpage_mmap = NULL;
 	if (uctx->shpg)
 		free_page((unsigned long)uctx->shpg);
 
@@ -4036,27 +4087,43 @@ int bnxt_re_mmap(struct ib_ucontext *ib_uctx, struct vm_area_struct *vma)
 	struct bnxt_re_ucontext *uctx = container_of(ib_uctx,
 						   struct bnxt_re_ucontext,
 						   ib_uctx);
-	struct bnxt_re_dev *rdev = uctx->rdev;
+	struct bnxt_re_user_mmap_entry *bnxt_entry;
+	struct rdma_user_mmap_entry *rdma_entry;
+	int ret = 0;
 	u64 pfn;
 
-	if (vma->vm_end - vma->vm_start != PAGE_SIZE)
+	rdma_entry = rdma_user_mmap_entry_get(&uctx->ib_uctx, vma);
+	if (!rdma_entry)
 		return -EINVAL;
 
-	if (vma->vm_pgoff) {
-		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
-		if (io_remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
-				       PAGE_SIZE, vma->vm_page_prot)) {
-			ibdev_err(&rdev->ibdev, "Failed to map DPI");
-			return -EAGAIN;
-		}
-	} else {
-		pfn = virt_to_phys(uctx->shpg) >> PAGE_SHIFT;
-		if (remap_pfn_range(vma, vma->vm_start,
-				    pfn, PAGE_SIZE, vma->vm_page_prot)) {
-			ibdev_err(&rdev->ibdev, "Failed to map shared page");
-			return -EAGAIN;
-		}
+	bnxt_entry = container_of(rdma_entry, struct bnxt_re_user_mmap_entry,
+				  rdma_entry);
+
+	switch (bnxt_entry->mmap_flag) {
+	case BNXT_RE_MMAP_UC_DB:
+		pfn = bnxt_entry->mem_offset >> PAGE_SHIFT;
+		ret = rdma_user_mmap_io(ib_uctx, vma, pfn, PAGE_SIZE,
+					pgprot_noncached(vma->vm_page_prot),
+				rdma_entry);
+		break;
+	case BNXT_RE_MMAP_SH_PAGE:
+		ret = vm_insert_page(vma, vma->vm_start, virt_to_page(uctx->shpg));
+		break;
+	default:
+		ret = -EINVAL;
+		break;
 	}
 
-	return 0;
+	rdma_user_mmap_entry_put(rdma_entry);
+	return ret;
+}
+
+void bnxt_re_mmap_free(struct rdma_user_mmap_entry *rdma_entry)
+{
+	struct bnxt_re_user_mmap_entry *bnxt_entry;
+
+	bnxt_entry = container_of(rdma_entry, struct bnxt_re_user_mmap_entry,
+				  rdma_entry);
+
+	kfree(bnxt_entry);
 }
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
index 31f7e34..dcd31ae 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
@@ -60,6 +60,7 @@ struct bnxt_re_pd {
 	struct bnxt_re_dev	*rdev;
 	struct bnxt_qplib_pd	qplib_pd;
 	struct bnxt_re_fence_data fence;
+	struct rdma_user_mmap_entry *pd_db_mmap;
 };
 
 struct bnxt_re_ah {
@@ -136,6 +137,18 @@ struct bnxt_re_ucontext {
 	struct bnxt_qplib_dpi	dpi;
 	void			*shpg;
 	spinlock_t		sh_lock;	/* protect shpg */
+	struct rdma_user_mmap_entry *shpage_mmap;
+};
+
+enum bnxt_re_mmap_flag {
+	BNXT_RE_MMAP_SH_PAGE,
+	BNXT_RE_MMAP_UC_DB,
+};
+
+struct bnxt_re_user_mmap_entry {
+	struct rdma_user_mmap_entry rdma_entry;
+	u64 mem_offset;
+	u8 mmap_flag;
 };
 
 static inline u16 bnxt_re_get_swqe_size(int nsge)
@@ -213,6 +226,8 @@ struct ib_mr *bnxt_re_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 int bnxt_re_alloc_ucontext(struct ib_ucontext *ctx, struct ib_udata *udata);
 void bnxt_re_dealloc_ucontext(struct ib_ucontext *context);
 int bnxt_re_mmap(struct ib_ucontext *context, struct vm_area_struct *vma);
+void bnxt_re_mmap_free(struct rdma_user_mmap_entry *rdma_entry);
+
 
 unsigned long bnxt_re_lock_cqs(struct bnxt_re_qp *qp);
 void bnxt_re_unlock_cqs(struct bnxt_re_qp *qp, unsigned long flags);
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 4718af6..b43acbe 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -545,6 +545,7 @@ static const struct ib_device_ops bnxt_re_dev_ops = {
 	.get_port_immutable = bnxt_re_get_port_immutable,
 	.map_mr_sg = bnxt_re_map_mr_sg,
 	.mmap = bnxt_re_mmap,
+	.mmap_free = bnxt_re_mmap_free,
 	.modify_qp = bnxt_re_modify_qp,
 	.modify_srq = bnxt_re_modify_srq,
 	.poll_cq = bnxt_re_poll_cq,
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.c b/drivers/infiniband/hw/bnxt_re/qplib_res.c
index 126d4f2..920ab87 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.c
@@ -813,7 +813,7 @@ static int bnxt_qplib_alloc_dpi_tbl(struct bnxt_qplib_res     *res,
 	return 0;
 
 unmap_io:
-	pci_iounmap(res->pdev, dpit->dbr_bar_reg_iomem);
+	iounmap(dpit->dbr_bar_reg_iomem);
 	dpit->dbr_bar_reg_iomem = NULL;
 	return -ENOMEM;
 }
-- 
2.5.5


--000000000000c2ed7205fd0fa6b8
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
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIIy2MP6wjjn+
wb6ZsyD3iCoktyF+LlXVEOVYxVjddMJaMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIzMDYwMTExMjIyN1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAwOGxipoCmLabLQx8EfaUZp42xXyD3
cOZwfvvUH+LNxdnUB8Fcw2NCnoVQxEo2g6bq3kCL0OOMei1w6rmyrpq1CuMUkmAfqsxAEc5W6KPl
AQMFbe51GrgkjTJNg5ypCayZWRt1cxi5/iuPEV4g66UuM9M8vlVKldPZ+crP2GZhNMhHnDif8BnW
Qcm5E9Syfs6vg0XSwwoVKPOVLm6u7ZjuM9CNIWFuTt0wtkix18hgkqnQZ/jG6ll/fvSwX5LoUsy0
NvL5p5wRsnnGiLASOLtwQN9//IIxfa0AjJBWsD5RAgSqW2ekKafXkyULuRC0KseBb/yM/6dmLk/e
nmIIjGGE
--000000000000c2ed7205fd0fa6b8--
