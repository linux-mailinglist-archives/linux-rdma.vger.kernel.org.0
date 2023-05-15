Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAF970285A
	for <lists+linux-rdma@lfdr.de>; Mon, 15 May 2023 11:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237651AbjEOJXQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 15 May 2023 05:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239936AbjEOJWU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 15 May 2023 05:22:20 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA405E5D
        for <linux-rdma@vger.kernel.org>; Mon, 15 May 2023 02:18:44 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-643465067d1so9177582b3a.0
        for <linux-rdma@vger.kernel.org>; Mon, 15 May 2023 02:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1684142324; x=1686734324;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zYbXOJKl1Z7gXY+QlsDzkZRz5qWf9Pz0U+G5Dc4See8=;
        b=fFjnibgMjiUE/AO4vJ9FMtmnLMmJ3K1ATG8gxItRo+6P65dJd06+g/pJNJSMOtGcPo
         CgzWGsrbgKjbVBcjOQ5b42GFUkWzZZa/h9jInpl6E8F1Wta7u9zp9poDeCSxU23iEvv9
         OTZVjTDk8tYQrcil9eD+IpLHduG/EpZOk/VZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684142324; x=1686734324;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zYbXOJKl1Z7gXY+QlsDzkZRz5qWf9Pz0U+G5Dc4See8=;
        b=DsIFhSYFb3lWVVS47R/oW7XjMGs4Xle3PPsW4PkthjxparV4imkFaDVV+TnBylcKNU
         Q2y/RbvMPOARPbso7J2Q6AC+0e1pn08SJVglY9hu6Ci12vJpah2wVtAzfJsRdLXQQsz1
         QulfxrI3tnSyug9szFplJoi1QE9okTNJr59+NBz2LlAnXXHRGVPdEj8VyvvH3f0lxb98
         P+DNIwTpKYCggkW1H8FhPJswh60xDdFssHm1Sd3Vi9sXubbfUzt7HxTmtzr/+423aacx
         0spgWqibsOWdBESjcvEWVRy2rZp0xJao1cA4EVz9MCVjvao8Tl3YEPwPBfDQupR0GuMN
         heSw==
X-Gm-Message-State: AC+VfDyYoLPPGL2IXOkh+c24YWdjSNRVsxyNW8eS2xn39UcrqogmLUnd
        Fy5zdKeUBhpyzMvEzBAiwoLvfg==
X-Google-Smtp-Source: ACHHUZ5cKUlMEBcbuqi2gO62VeqhROOh992tsUzJmiKGSFdGiT0xM7v3Gk/Rs+YPdIEXQqmATklehQ==
X-Received: by 2002:a05:6a20:3d06:b0:100:900f:74a5 with SMTP id y6-20020a056a203d0600b00100900f74a5mr32132332pzi.56.1684142324109;
        Mon, 15 May 2023 02:18:44 -0700 (PDT)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id q7-20020a654947000000b00520f316ebe3sm10402169pgs.62.2023.05.15.02.18.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 May 2023 02:18:43 -0700 (PDT)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH v3 for-next 6/6] RDMA/bnxt_re: Enable low latency push
Date:   Mon, 15 May 2023 02:06:50 -0700
Message-Id: <1684141610-17588-7-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1684141610-17588-1-git-send-email-selvin.xavier@broadcom.com>
References: <1684141610-17588-1-git-send-email-selvin.xavier@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000000ebea05fbb7f17a"
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

--00000000000000ebea05fbb7f17a

Introduce driver specific uapi functionalites. Added
a alloc_page functionality for user library to allocate
specific pages. Currently added support for allocating
write combine pages for push functinality. This interface
shall be extended for other page allocations.

Allocate a WC page using the uapi hook for enabling the low latency
push in Gen P5 adapters for small packets. This is supported only
for the user space QPs.

Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/bnxt_re.h   |   3 +
 drivers/infiniband/hw/bnxt_re/ib_verbs.c  | 149 ++++++++++++++++++++++++++++++
 drivers/infiniband/hw/bnxt_re/ib_verbs.h  |   4 +
 drivers/infiniband/hw/bnxt_re/main.c      |  17 +++-
 drivers/infiniband/hw/bnxt_re/qplib_res.c |   3 +
 drivers/infiniband/hw/bnxt_re/qplib_res.h |   3 +-
 include/uapi/rdma/bnxt_re-abi.h           |  32 +++++++
 7 files changed, 209 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
index 5a2baf4..d436327 100644
--- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
+++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
@@ -39,6 +39,7 @@
 
 #ifndef __BNXT_RE_H__
 #define __BNXT_RE_H__
+#include <rdma/uverbs_ioctl.h>
 #include "hw_counters.h"
 #define ROCE_DRV_MODULE_NAME		"bnxt_re"
 
@@ -187,4 +188,6 @@ static inline struct device *rdev_to_dev(struct bnxt_re_dev *rdev)
 		return  &rdev->ibdev.dev;
 	return NULL;
 }
+
+extern const struct uapi_definition bnxt_re_uapi_defs[];
 #endif
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index bc85433..60169fc 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -61,6 +61,15 @@
 
 #include "bnxt_re.h"
 #include "ib_verbs.h"
+
+#include <rdma/uverbs_types.h>
+#include <rdma/uverbs_std_types.h>
+
+#include <rdma/ib_user_ioctl_cmds.h>
+
+#define UVERBS_MODULE_NAME bnxt_re
+#include <rdma/uverbs_named_ioctl.h>
+
 #include <rdma/bnxt_re-abi.h>
 
 static int __from_ib_access_flags(int iflags)
@@ -546,6 +555,7 @@ bnxt_re_mmap_entry_insert(struct bnxt_re_ucontext *uctx, u64 mem_offset,
 
 	entry->mem_offset = mem_offset;
 	entry->mmap_flag = mmap_flag;
+	entry->uctx = uctx;
 
 	ret = rdma_user_mmap_entry_insert(&uctx->ib_uctx,
 					  &entry->rdma_entry, PAGE_SIZE);
@@ -599,6 +609,7 @@ int bnxt_re_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 	}
 
 	if (udata) {
+		struct bnxt_qplib_chip_ctx *cctx = rdev->chip_ctx;
 		struct bnxt_re_pd_resp resp = {};
 
 		if (!ucntx->dpi.dbr) {
@@ -611,6 +622,9 @@ int bnxt_re_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 				rc = -ENOMEM;
 				goto dbfail;
 			}
+			/* Set the comp_mask to indicate users to enable WC DPI */
+			if (cctx->modes.db_push)
+				resp.comp_mask = BNXT_RE_COMP_MASK_PD_WC_DPI_SUP;
 		}
 
 		resp.pdid = pd->qplib_pd.id;
@@ -4036,6 +4050,9 @@ int bnxt_re_alloc_ucontext(struct ib_ucontext *ctx, struct ib_udata *udata)
 	resp.comp_mask |= BNXT_RE_UCNTX_CMASK_HAVE_MODE;
 	resp.mode = rdev->chip_ctx->modes.wqe_mode;
 
+	if (rdev->chip_ctx->modes.db_push)
+		resp.comp_mask |= BNXT_RE_UCNTX_CMASK_WC_DPI_ENABLED;
+
 	entry = bnxt_re_mmap_entry_insert(uctx, 0, BNXT_RE_MMAP_SH_PAGE, NULL);
 	if (!entry) {
 		rc = -ENOMEM;
@@ -4099,6 +4116,12 @@ int bnxt_re_mmap(struct ib_ucontext *ib_uctx, struct vm_area_struct *vma)
 				  rdma_entry);
 
 	switch (bnxt_entry->mmap_flag) {
+	case BNXT_RE_MMAP_WC_DB:
+		pfn = bnxt_entry->mem_offset >> PAGE_SHIFT;
+		ret = rdma_user_mmap_io(ib_uctx, vma, pfn, PAGE_SIZE,
+					pgprot_writecombine(vma->vm_page_prot),
+					rdma_entry);
+		break;
 	case BNXT_RE_MMAP_UC_DB:
 		pfn = bnxt_entry->mem_offset >> PAGE_SHIFT;
 		ret = rdma_user_mmap_io(ib_uctx, vma, pfn, PAGE_SIZE,
@@ -4126,3 +4149,129 @@ void bnxt_re_mmap_free(struct rdma_user_mmap_entry *rdma_entry)
 
 	kfree(bnxt_entry);
 }
+
+static int UVERBS_HANDLER(BNXT_RE_METHOD_ALLOC_PAGE)(struct uverbs_attr_bundle *attrs)
+{
+	struct ib_uobject *uobj = uverbs_attr_get_uobject(attrs, BNXT_RE_ALLOC_PAGE_HANDLE);
+	enum bnxt_re_alloc_page_type alloc_type;
+	struct bnxt_re_user_mmap_entry *entry;
+	enum bnxt_re_mmap_flag mmap_flag;
+	struct bnxt_qplib_chip_ctx *cctx;
+	struct bnxt_re_ucontext *uctx;
+	struct bnxt_re_dev *rdev;
+	u64 mmap_offset;
+	u32 length;
+	u32 dpi;
+	u64 dbr;
+	int err;
+
+	uctx = container_of(ib_uverbs_get_ucontext(attrs), struct bnxt_re_ucontext, ib_uctx);
+	if (IS_ERR(uctx))
+		return PTR_ERR(uctx);
+
+	err = uverbs_get_const(&alloc_type, attrs, BNXT_RE_ALLOC_PAGE_TYPE);
+	if (err)
+		return err;
+
+	rdev = uctx->rdev;
+	cctx = rdev->chip_ctx;
+
+	switch (alloc_type) {
+	case BNXT_RE_ALLOC_WC_PAGE:
+		if (cctx->modes.db_push)  {
+			if (bnxt_qplib_alloc_dpi(&rdev->qplib_res, &uctx->wcdpi,
+						 uctx, BNXT_QPLIB_DPI_TYPE_WC))
+				return -ENOMEM;
+		}
+		length = PAGE_SIZE;
+		dpi = uctx->wcdpi.dpi;
+		dbr = (u64)uctx->wcdpi.umdbr;
+		mmap_flag = BNXT_RE_MMAP_WC_DB;
+
+		break;
+
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	entry = bnxt_re_mmap_entry_insert(uctx, dbr, mmap_flag, &mmap_offset);
+	if (IS_ERR(entry))
+		return PTR_ERR(entry);
+
+	uobj->object = entry;
+	uverbs_finalize_uobj_create(attrs, BNXT_RE_ALLOC_PAGE_HANDLE);
+	err = uverbs_copy_to(attrs, BNXT_RE_ALLOC_PAGE_MMAP_OFFSET,
+			     &mmap_offset, sizeof(mmap_offset));
+	if (err)
+		return err;
+
+	err = uverbs_copy_to(attrs, BNXT_RE_ALLOC_PAGE_MMAP_LENGTH,
+			     &length, sizeof(length));
+	if (err)
+		return err;
+
+	err = uverbs_copy_to(attrs, BNXT_RE_ALLOC_PAGE_DPI,
+			     &dpi, sizeof(length));
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static int alloc_page_obj_cleanup(struct ib_uobject *uobject,
+				  enum rdma_remove_reason why,
+			    struct uverbs_attr_bundle *attrs)
+{
+	struct  bnxt_re_user_mmap_entry *entry = uobject->object;
+	struct bnxt_re_ucontext *uctx = entry->uctx;
+
+	switch (entry->mmap_flag) {
+	case BNXT_RE_MMAP_WC_DB:
+		if (uctx && uctx->wcdpi.dbr) {
+			struct bnxt_re_dev *rdev = uctx->rdev;
+
+			bnxt_qplib_dealloc_dpi(&rdev->qplib_res, &uctx->wcdpi);
+			uctx->wcdpi.dbr = NULL;
+		}
+		break;
+	default:
+		goto exit;
+	}
+	rdma_user_mmap_entry_remove(&entry->rdma_entry);
+exit:
+	return 0;
+}
+
+DECLARE_UVERBS_NAMED_METHOD(BNXT_RE_METHOD_ALLOC_PAGE,
+			    UVERBS_ATTR_IDR(BNXT_RE_ALLOC_PAGE_HANDLE,
+					    BNXT_RE_OBJECT_ALLOC_PAGE,
+					    UVERBS_ACCESS_NEW,
+					    UA_MANDATORY),
+			    UVERBS_ATTR_CONST_IN(BNXT_RE_ALLOC_PAGE_TYPE,
+						 enum bnxt_re_alloc_page_type,
+						 UA_MANDATORY),
+			    UVERBS_ATTR_PTR_OUT(BNXT_RE_ALLOC_PAGE_MMAP_OFFSET,
+						UVERBS_ATTR_TYPE(u64),
+						UA_MANDATORY),
+			    UVERBS_ATTR_PTR_OUT(BNXT_RE_ALLOC_PAGE_MMAP_LENGTH,
+						UVERBS_ATTR_TYPE(u32),
+						UA_MANDATORY),
+			    UVERBS_ATTR_PTR_OUT(BNXT_RE_ALLOC_PAGE_DPI,
+						UVERBS_ATTR_TYPE(u32),
+						UA_MANDATORY));
+
+DECLARE_UVERBS_NAMED_METHOD_DESTROY(BNXT_RE_METHOD_DESTROY_PAGE,
+				    UVERBS_ATTR_IDR(BNXT_RE_DESTROY_PAGE_HANDLE,
+						    BNXT_RE_OBJECT_ALLOC_PAGE,
+						    UVERBS_ACCESS_DESTROY,
+						    UA_MANDATORY));
+
+DECLARE_UVERBS_NAMED_OBJECT(BNXT_RE_OBJECT_ALLOC_PAGE,
+			    UVERBS_TYPE_ALLOC_IDR(alloc_page_obj_cleanup),
+			    &UVERBS_METHOD(BNXT_RE_METHOD_ALLOC_PAGE),
+			    &UVERBS_METHOD(BNXT_RE_METHOD_DESTROY_PAGE));
+
+const struct uapi_definition bnxt_re_uapi_defs[] = {
+	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(BNXT_RE_OBJECT_ALLOC_PAGE),
+	{}
+};
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
index dcd31ae..32d9e9d 100644
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
@@ -143,10 +145,12 @@ struct bnxt_re_ucontext {
 enum bnxt_re_mmap_flag {
 	BNXT_RE_MMAP_SH_PAGE,
 	BNXT_RE_MMAP_UC_DB,
+	BNXT_RE_MMAP_WC_DB,
 };
 
 struct bnxt_re_user_mmap_entry {
 	struct rdma_user_mmap_entry rdma_entry;
+	struct bnxt_re_ucontext *uctx;
 	u64 mem_offset;
 	u8 mmap_flag;
 };
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 69d4d8a..3744cda 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -66,6 +66,7 @@
 #include <rdma/bnxt_re-abi.h>
 #include "bnxt.h"
 #include "hw_counters.h"
+#include "ib_verbs.h"
 
 static char version[] =
 		BNXT_RE_DESC "\n";
@@ -117,6 +118,10 @@ static void bnxt_re_set_db_offset(struct bnxt_re_dev *rdev)
 	 * in such cases and DB-push will be disabled.
 	 */
 	barlen = pci_resource_len(res->pdev, RCFW_DBR_PCI_BAR_REGION);
+	if (cctx->modes.db_push && l2db_len && en_dev->l2_db_size != barlen) {
+		res->dpi_tbl.wcreg.offset = en_dev->l2_db_size;
+		dev_info(rdev_to_dev(rdev),  "Low latency framework is enabled\n");
+	}
 }
 
 static void bnxt_re_set_drv_mode(struct bnxt_re_dev *rdev, u8 mode)
@@ -411,6 +416,7 @@ int bnxt_re_hwrm_qcaps(struct bnxt_re_dev *rdev)
 	struct hwrm_func_qcaps_input req = {0};
 	struct bnxt_qplib_chip_ctx *cctx;
 	struct bnxt_fw_msg fw_msg;
+	int rc;
 
 	cctx = rdev->chip_ctx;
 	memset(&fw_msg, 0, sizeof(fw_msg));
@@ -419,7 +425,13 @@ int bnxt_re_hwrm_qcaps(struct bnxt_re_dev *rdev)
 	req.fid = cpu_to_le16(0xffff);
 	bnxt_re_fill_fw_msg(&fw_msg, (void *)&req, sizeof(req), (void *)&resp,
 			    sizeof(resp), DFLT_HWRM_CMD_TIMEOUT);
-	return bnxt_send_msg(en_dev, &fw_msg);
+
+	rc = bnxt_send_msg(en_dev, &fw_msg);
+	if (rc)
+		return rc;
+	cctx->modes.db_push = le32_to_cpu(resp.flags) & FUNC_QCAPS_RESP_FLAGS_WCB_PUSH_MODE;
+
+	return 0;
 }
 
 static int bnxt_re_net_ring_free(struct bnxt_re_dev *rdev,
@@ -673,6 +685,9 @@ static int bnxt_re_register_ib(struct bnxt_re_dev *rdev)
 	ibdev->dev.parent = &rdev->en_dev->pdev->dev;
 	ibdev->local_dma_lkey = BNXT_QPLIB_RSVD_LKEY;
 
+	if (IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS))
+		ibdev->driver_def = bnxt_re_uapi_defs;
+
 	ib_set_device_ops(ibdev, &bnxt_re_dev_ops);
 	ret = ib_device_set_netdev(&rdev->ibdev, rdev->netdev, 1);
 	if (ret)
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.c b/drivers/infiniband/hw/bnxt_re/qplib_res.c
index e1cbe59..174db83 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.c
@@ -740,6 +740,9 @@ int bnxt_qplib_alloc_dpi(struct bnxt_qplib_res *res,
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
index c4e9077..3efc068 100644
--- a/include/uapi/rdma/bnxt_re-abi.h
+++ b/include/uapi/rdma/bnxt_re-abi.h
@@ -41,6 +41,7 @@
 #define __BNXT_RE_UVERBS_ABI_H__
 
 #include <linux/types.h>
+#include <rdma/ib_user_ioctl_cmds.h>
 
 #define BNXT_RE_ABI_VERSION	1
 
@@ -51,6 +52,7 @@
 enum {
 	BNXT_RE_UCNTX_CMASK_HAVE_CCTX = 0x1ULL,
 	BNXT_RE_UCNTX_CMASK_HAVE_MODE = 0x02ULL,
+	BNXT_RE_UCNTX_CMASK_WC_DPI_ENABLED = 0x04ULL,
 };
 
 enum bnxt_re_wqe_mode {
@@ -78,10 +80,15 @@ struct bnxt_re_uctx_resp {
  * not 8 byted aligned. To avoid undesired padding in various cases we have to
  * set this struct to packed.
  */
+enum {
+	BNXT_RE_COMP_MASK_PD_WC_DPI_SUP = 0x01,
+};
+
 struct bnxt_re_pd_resp {
 	__u32 pdid;
 	__u32 dpi;
 	__u64 dbr;
+	__u64 comp_mask;
 } __attribute__((packed, aligned(4)));
 
 struct bnxt_re_cq_req {
@@ -127,4 +134,29 @@ enum bnxt_re_shpg_offt {
 	BNXT_RE_END_RESV_OFFT	= 0xFF0
 };
 
+enum bnxt_re_objects {
+	BNXT_RE_OBJECT_ALLOC_PAGE = (1U << UVERBS_ID_NS_SHIFT),
+};
+
+enum bnxt_re_alloc_page_type {
+	BNXT_RE_ALLOC_WC_PAGE = 0,
+};
+
+enum bnxt_re_var_alloc_page_attrs {
+	BNXT_RE_ALLOC_PAGE_HANDLE = (1U << UVERBS_ID_NS_SHIFT),
+	BNXT_RE_ALLOC_PAGE_TYPE,
+	BNXT_RE_ALLOC_PAGE_DPI,
+	BNXT_RE_ALLOC_PAGE_MMAP_OFFSET,
+	BNXT_RE_ALLOC_PAGE_MMAP_LENGTH,
+};
+
+enum bnxt_re_alloc_page_attrs {
+	BNXT_RE_DESTROY_PAGE_HANDLE = (1U << UVERBS_ID_NS_SHIFT),
+};
+
+enum bnxt_re_alloc_page_methods {
+	BNXT_RE_METHOD_ALLOC_PAGE = (1U << UVERBS_ID_NS_SHIFT),
+	BNXT_RE_METHOD_DESTROY_PAGE,
+};
+
 #endif /* __BNXT_RE_UVERBS_ABI_H__*/
-- 
2.5.5


--00000000000000ebea05fbb7f17a
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
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEINB3gpHgJZUH
RJbyiUURYYG/KfwSc8Sut63LIlL/H6CzMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIzMDUxNTA5MTg0NFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBuG28mtYXBPKzUuFB7KFSg6RG216Wy
kii/DI36g7SR3rLDViv+aADaiPnC0Gu3Lfb0QTCuvMl0wGcauESlai5nAHW9yshbXm+fIheXHUFc
kSheV9mVBDL2FsHIFJjhu9j0X/n0u2rg+rnwupUcVfzs1yQx6m4GBkcuYhuq0N3OdlXlwIfauJJv
WTfY2bTLN1eUx1/VqY2YsVvtja2JEiGmaOCzDewhH+rN6oaXy7xslk3JWfMA8HFNHzO340UxoviP
Redx2WupYYgBugvWBBit+8HqF7oQ9vC+O494dhAo3Tov4RRUdxPDeIXD3UBNMo2BZMmVJ2Kw7wN9
CVAmPW6O
--00000000000000ebea05fbb7f17a--
