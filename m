Return-Path: <linux-rdma+bounces-15654-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE6FD38D33
	for <lists+linux-rdma@lfdr.de>; Sat, 17 Jan 2026 09:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 13B493008DC9
	for <lists+linux-rdma@lfdr.de>; Sat, 17 Jan 2026 08:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A197C313E25;
	Sat, 17 Jan 2026 08:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="clG0JmHd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-vs1-f99.google.com (mail-vs1-f99.google.com [209.85.217.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0ED9331A7A
	for <linux-rdma@vger.kernel.org>; Sat, 17 Jan 2026 08:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768637348; cv=none; b=VTEH9ZwzT1q3ejctE/nH9zTEPgwfpFnfIzs2ZSi0jHRFEp38kw+9fArtFLF0L7fQg5QjjsWD2et1Ps78DWP3WUziBZ35Y2eyO42myKMPCOgJdfZlSp9tSYge8pe+BlnoS3U4aEJg2gW1/Ur2aVHIUrowLM4/HoG0QfFQ8xxTBmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768637348; c=relaxed/simple;
	bh=zoFJJHOMdtnUuV3Ygl9ukiPax9oA8wi88xpnPlnlPrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c/KUR/4uTW0IegdhZrPaPR+Az2OGkrj+DUySHW0rQFSfa+Lbo9qSyDP0oPZoGIWC2PI+h1U3G7dP+VBgvfetVJVubwquvd7v29IVm6Woeb8TWxRMQJEe+BfHbBSQgUPkSjIMwfnxS4xJXCR+WKiZ4e476usC//HSjp4RegLLRIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=clG0JmHd; arc=none smtp.client-ip=209.85.217.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vs1-f99.google.com with SMTP id ada2fe7eead31-5ecddf73062so1768978137.1
        for <linux-rdma@vger.kernel.org>; Sat, 17 Jan 2026 00:09:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768637345; x=1769242145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cnIwRFvVu4P36nGMzs02jymTsYNnL95oBzKzHbR6VLc=;
        b=a6r0uf7yfQiFXa/92eDJTXJqjtByQlJEjSfFtQztTSRbvhN5XBbmFUvutjoSCZ8aHe
         DW0d8l06TLyq3737KYcE+jjzR3ecxaWuprj+haNvuPtKs6O0/77mOzHSNvHXYEBvIN2b
         qAw+z6RtKux5idZJfy/y1j+wyjdqD9uV+wka7x46Qlg74c7vSMJ/oLk4bE/DerMhVivP
         q7jNeTe4QSMqKy7Nwtvi7fQKe2Jd9PInjQiTBLo6NwjY449gFvyviDxKY4psieQADlU3
         jwlBXdTqkAU0XQNBkSIQP9XkWobF4sUWKBY/yop4wtkRSrNkz89JdRwj717d+D7F+HBa
         AUmw==
X-Gm-Message-State: AOJu0YwAO+5JAsdbq1hvAKA+IyJWysZAtKzUMP20tmiXBJ9CJVjXcpR8
	tn28uzMa54J6i3Z2wNwj/lMD/7BROJ3H+or/q9TF9cTJrYsWV0SEEBxJ+bHa4Ngngpt7//zQpud
	0epdLitAr/0VsD3SJSnoEsedIKu84I77BSVaCXWO2vj7ZmtuV1Exs3Hucqf8xYHi3rCQHGSHDzG
	i633nzyYjkrtRJtsGphKQ7UVxt5+qwXJFKtgRWVBLwuTT8ULo+Af+jjhqNRDsvmS6PmIApy9so3
	YCTL2zxeOJZxd4b3FkTrwTHZQJr
X-Gm-Gg: AY/fxX7MO+NQulZwI210+eZlwQHiF9yF5+NMlmXze7/PTt0YFA3n8ruiG/wJCrHH5v/
	jT2QNDoG714i3Ye30sRY46lv2CYko0EvqcR6kA9oCSXSS2Dz1IKRAS5vNAilPZPJ1AV5axiq6IH
	ScYwnlLlxksO0tqYV8+pPcZ1T8rSo8GnlKkzLwnozk9HLVQw7eqeTXB+V6xhMGciRUPEq1I+9g8
	8XSLv7Gm6QJSSbs8OvmIuGV4uGxE5kNdWjsZLGftI50OXtYey47Yl7DSV8wKE2/LAm2OYp9JKzX
	AvmMhCx5waFMyw0ekp1KLpaRZPSwhz/XcEmqj+NfwVmB7QJeN8nMesOLgUxIvAEwnT2zw/+AV7G
	7uyBBjZQ9AOHx+6JWx0n3jF98BSHjN+xhCR2NjckqQP4lv2YdAolWBYlEazfiNrQP+kIN2wuuDw
	vlEsNaXo9fI5EXSnzJG1su7Hmcvviyjp1Y6N/A/yaYwMxKV8Eyg89GlA==
X-Received: by 2002:a05:6102:2ad5:b0:5dd:c53b:75cc with SMTP id ada2fe7eead31-5f1a553654emr1945938137.13.1768637345514;
        Sat, 17 Jan 2026 00:09:05 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-5f1a6772b9csm558921137.0.2026.01.17.00.09.04
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Jan 2026 00:09:05 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c3dfa080662so1665834a12.1
        for <linux-rdma@vger.kernel.org>; Sat, 17 Jan 2026 00:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768637343; x=1769242143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cnIwRFvVu4P36nGMzs02jymTsYNnL95oBzKzHbR6VLc=;
        b=clG0JmHdlOD9M2VC915+57St6aP3WCzU2s7D3aZR9JB1PJhqSTw6MSxjLZvDSXcnIa
         j/FrTdTyhEXF6M07QS62LnmTrFrAOJLq/qr4PVdgeQpg/LVpzI5a9CmwaMFIyZysZHWE
         ih8w6/6FANDe6Pzy7Hm3Dj+9a/4u6/7Jq17l0=
X-Received: by 2002:a05:6a00:84a:b0:81f:3a05:8a84 with SMTP id d2e1a72fcca58-81fa0663db1mr4756746b3a.11.1768637343472;
        Sat, 17 Jan 2026 00:09:03 -0800 (PST)
X-Received: by 2002:a05:6a00:84a:b0:81f:3a05:8a84 with SMTP id d2e1a72fcca58-81fa0663db1mr4756733b3a.11.1768637343029;
        Sat, 17 Jan 2026 00:09:03 -0800 (PST)
Received: from dhcp-10-123-157-187.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa10bdafdsm3833819b3a.15.2026.01.17.00.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jan 2026 00:09:02 -0800 (PST)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v8 3/4] RDMA/bnxt_re: Direct Verbs: Support DBR verbs
Date: Sat, 17 Jan 2026 13:30:51 +0530
Message-ID: <20260117080052.43279-4-sriharsha.basavapatna@broadcom.com>
X-Mailer: git-send-email 2.51.2.636.ga99f379adf
In-Reply-To: <20260117080052.43279-1-sriharsha.basavapatna@broadcom.com>
References: <20260117080052.43279-1-sriharsha.basavapatna@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

The following Direct Verbs (DV) methods have been implemented in
this patch.

Doorbell Region Direct Verbs:
-----------------------------
- BNXT_RE_METHOD_DBR_ALLOC:
  This will allow the appliation to create extra doorbell regions
  and use the associated doorbell page index in DV_CREATE_QP and
  use the associated DB address while ringing the doorbell.

- BNXT_RE_METHOD_DBR_FREE:
  Free the allocated doorbell region.

- BNXT_RE_METHOD_GET_DEFAULT_DBR:
  Return the default doorbell page index and doorbell page address
  associated with the ucontext.

Co-developed-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Signed-off-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/bnxt_re.h   |   1 +
 drivers/infiniband/hw/bnxt_re/dv.c        | 130 ++++++++++++++++++++++
 drivers/infiniband/hw/bnxt_re/ib_verbs.h  |   7 ++
 drivers/infiniband/hw/bnxt_re/qplib_res.c |  43 +++++++
 drivers/infiniband/hw/bnxt_re/qplib_res.h |   4 +
 include/uapi/rdma/bnxt_re-abi.h           |  29 +++++
 6 files changed, 214 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
index 3a7ce4729fcf..0999a42c678c 100644
--- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
+++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
@@ -160,6 +160,7 @@ struct bnxt_re_nq_record {
 
 #define MAX_CQ_HASH_BITS		(16)
 #define MAX_SRQ_HASH_BITS		(16)
+#define MAX_DPI_HASH_BITS		(16)
 
 static inline bool bnxt_re_chip_gen_p7(u16 chip_num)
 {
diff --git a/drivers/infiniband/hw/bnxt_re/dv.c b/drivers/infiniband/hw/bnxt_re/dv.c
index 5655c6176af4..db69f25e294f 100644
--- a/drivers/infiniband/hw/bnxt_re/dv.c
+++ b/drivers/infiniband/hw/bnxt_re/dv.c
@@ -331,9 +331,139 @@ DECLARE_UVERBS_NAMED_OBJECT(BNXT_RE_OBJECT_GET_TOGGLE_MEM,
 			    &UVERBS_METHOD(BNXT_RE_METHOD_GET_TOGGLE_MEM),
 			    &UVERBS_METHOD(BNXT_RE_METHOD_RELEASE_TOGGLE_MEM));
 
+static int UVERBS_HANDLER(BNXT_RE_METHOD_DBR_ALLOC)(struct uverbs_attr_bundle *attrs)
+{
+	struct bnxt_re_dv_db_region dbr = {};
+	struct bnxt_re_ucontext *uctx;
+	struct bnxt_re_dbr_obj *obj;
+	struct ib_ucontext *ib_uctx;
+	struct bnxt_qplib_dpi *dpi;
+	struct bnxt_re_dev *rdev;
+	struct ib_uobject *uobj;
+	u64 mmap_offset;
+	int ret;
+
+	ib_uctx = ib_uverbs_get_ucontext(attrs);
+	if (IS_ERR(ib_uctx))
+		return PTR_ERR(ib_uctx);
+
+	uctx = container_of(ib_uctx, struct bnxt_re_ucontext, ib_uctx);
+	rdev = uctx->rdev;
+	uobj = uverbs_attr_get_uobject(attrs, BNXT_RE_DV_ALLOC_DBR_HANDLE);
+
+	obj = kzalloc(sizeof(*obj), GFP_KERNEL);
+	if (!obj)
+		return -ENOMEM;
+
+	dpi = &obj->dpi;
+	ret = bnxt_qplib_alloc_uc_dpi(&rdev->qplib_res, dpi);
+	if (ret)
+		goto free_mem;
+
+	obj->entry = bnxt_re_mmap_entry_insert(uctx, dpi->umdbr,
+					       BNXT_RE_MMAP_UC_DB,
+					       &mmap_offset);
+	if (!obj->entry) {
+		ret = -ENOMEM;
+		goto free_dpi;
+	}
+
+	obj->rdev = rdev;
+	uobj->object = obj;
+	uverbs_finalize_uobj_create(attrs, BNXT_RE_DV_ALLOC_DBR_HANDLE);
+
+	dbr.umdbr = dpi->umdbr;
+	dbr.dpi = dpi->dpi;
+	ret = uverbs_copy_to_struct_or_zero(attrs, BNXT_RE_DV_ALLOC_DBR_ATTR,
+					    &dbr, sizeof(dbr));
+	if (ret)
+		return ret;
+
+	ret = uverbs_copy_to(attrs, BNXT_RE_DV_ALLOC_DBR_OFFSET,
+			     &mmap_offset, sizeof(mmap_offset));
+	if (ret)
+		return ret;
+	return 0;
+free_dpi:
+	bnxt_qplib_free_uc_dpi(&rdev->qplib_res, dpi);
+free_mem:
+	kfree(obj);
+	return ret;
+}
+
+static int bnxt_re_dv_dbr_cleanup(struct ib_uobject *uobject,
+				  enum rdma_remove_reason why,
+				  struct uverbs_attr_bundle *attrs)
+{
+	struct bnxt_re_dbr_obj *obj = uobject->object;
+	struct bnxt_re_dev *rdev = obj->rdev;
+
+	rdma_user_mmap_entry_remove(&obj->entry->rdma_entry);
+	bnxt_qplib_free_uc_dpi(&rdev->qplib_res, &obj->dpi);
+	return 0;
+}
+
+static int UVERBS_HANDLER(BNXT_RE_METHOD_GET_DEFAULT_DBR)(struct uverbs_attr_bundle *attrs)
+{
+	struct bnxt_re_dv_db_region dpi = {};
+	struct bnxt_re_ucontext *uctx;
+	struct ib_ucontext *ib_uctx;
+	int ret;
+
+	ib_uctx = ib_uverbs_get_ucontext(attrs);
+	if (IS_ERR(ib_uctx))
+		return PTR_ERR(ib_uctx);
+
+	uctx = container_of(ib_uctx, struct bnxt_re_ucontext, ib_uctx);
+	dpi.umdbr = uctx->dpi.umdbr;
+	dpi.dpi = uctx->dpi.dpi;
+
+	ret = uverbs_copy_to_struct_or_zero(attrs, BNXT_RE_DV_DEFAULT_DBR_ATTR,
+					    &dpi, sizeof(dpi));
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+DECLARE_UVERBS_NAMED_METHOD(BNXT_RE_METHOD_DBR_ALLOC,
+			    UVERBS_ATTR_IDR(BNXT_RE_DV_ALLOC_DBR_HANDLE,
+					    BNXT_RE_OBJECT_DBR,
+					    UVERBS_ACCESS_NEW,
+					    UA_MANDATORY),
+			    UVERBS_ATTR_PTR_OUT(BNXT_RE_DV_ALLOC_DBR_ATTR,
+						UVERBS_ATTR_STRUCT(struct bnxt_re_dv_db_region,
+								   umdbr),
+								   UA_MANDATORY),
+			    UVERBS_ATTR_PTR_OUT(BNXT_RE_DV_ALLOC_DBR_OFFSET,
+						UVERBS_ATTR_TYPE(u64),
+						UA_MANDATORY));
+
+DECLARE_UVERBS_NAMED_METHOD_DESTROY(BNXT_RE_METHOD_DBR_FREE,
+				    UVERBS_ATTR_IDR(BNXT_RE_DV_FREE_DBR_HANDLE,
+						    BNXT_RE_OBJECT_DBR,
+						    UVERBS_ACCESS_DESTROY,
+						    UA_MANDATORY));
+
+DECLARE_UVERBS_NAMED_OBJECT(BNXT_RE_OBJECT_DBR,
+			    UVERBS_TYPE_ALLOC_IDR(bnxt_re_dv_dbr_cleanup),
+			    &UVERBS_METHOD(BNXT_RE_METHOD_DBR_ALLOC),
+			    &UVERBS_METHOD(BNXT_RE_METHOD_DBR_FREE));
+
+DECLARE_UVERBS_NAMED_METHOD(BNXT_RE_METHOD_GET_DEFAULT_DBR,
+			    UVERBS_ATTR_PTR_OUT(BNXT_RE_DV_DEFAULT_DBR_ATTR,
+						UVERBS_ATTR_STRUCT(struct bnxt_re_dv_db_region,
+								   umdbr),
+						UA_MANDATORY));
+
+DECLARE_UVERBS_GLOBAL_METHODS(BNXT_RE_OBJECT_DEFAULT_DBR,
+			      &UVERBS_METHOD(BNXT_RE_METHOD_GET_DEFAULT_DBR));
+
 const struct uapi_definition bnxt_re_uapi_defs[] = {
 	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(BNXT_RE_OBJECT_ALLOC_PAGE),
 	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(BNXT_RE_OBJECT_NOTIFY_DRV),
 	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(BNXT_RE_OBJECT_GET_TOGGLE_MEM),
+	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(BNXT_RE_OBJECT_DBR),
+	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(BNXT_RE_OBJECT_DEFAULT_DBR),
 	{}
 };
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
index a11f56730a31..33e0f66b39eb 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
@@ -164,6 +164,13 @@ struct bnxt_re_user_mmap_entry {
 	u8 mmap_flag;
 };
 
+struct bnxt_re_dbr_obj {
+	struct bnxt_re_dev *rdev;
+	struct bnxt_qplib_dpi dpi;
+	struct bnxt_re_user_mmap_entry *entry;
+	atomic_t usecnt; /* QPs using this dbr */
+};
+
 struct bnxt_re_flow {
 	struct ib_flow		ib_flow;
 	struct bnxt_re_dev	*rdev;
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.c b/drivers/infiniband/hw/bnxt_re/qplib_res.c
index 875d7b52c06a..30cc2d64a9ae 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.c
@@ -685,6 +685,49 @@ static int bnxt_qplib_alloc_pd_tbl(struct bnxt_qplib_res *res,
 }
 
 /* DPIs */
+int bnxt_qplib_alloc_uc_dpi(struct bnxt_qplib_res *res, struct bnxt_qplib_dpi *dpi)
+{
+	struct bnxt_qplib_dpi_tbl *dpit = &res->dpi_tbl;
+	struct bnxt_qplib_reg_desc *reg;
+	u32 bit_num;
+	int rc = 0;
+
+	reg = &dpit->wcreg;
+	mutex_lock(&res->dpi_tbl_lock);
+	bit_num = find_first_bit(dpit->tbl, dpit->max);
+	if (bit_num >= dpit->max) {
+		rc = -ENOMEM;
+		goto unlock;
+	}
+	/* Found unused DPI */
+	clear_bit(bit_num, dpit->tbl);
+	dpi->bit = bit_num;
+	dpi->dpi = bit_num + (reg->offset - dpit->ucreg.offset) / PAGE_SIZE;
+	dpi->umdbr = reg->bar_base + reg->offset + bit_num * PAGE_SIZE;
+unlock:
+	mutex_unlock(&res->dpi_tbl_lock);
+	return rc;
+}
+
+int bnxt_qplib_free_uc_dpi(struct bnxt_qplib_res *res, struct bnxt_qplib_dpi *dpi)
+{
+	struct bnxt_qplib_dpi_tbl *dpit = &res->dpi_tbl;
+	int rc = 0;
+
+	mutex_lock(&res->dpi_tbl_lock);
+	if (dpi->bit >= dpit->max) {
+		rc = -EINVAL;
+		goto unlock;
+	}
+
+	if (test_and_set_bit(dpi->bit, dpit->tbl))
+		rc = -EINVAL;
+	memset(dpi, 0, sizeof(*dpi));
+unlock:
+	mutex_unlock(&res->dpi_tbl_lock);
+	return rc;
+}
+
 int bnxt_qplib_alloc_dpi(struct bnxt_qplib_res *res,
 			 struct bnxt_qplib_dpi *dpi,
 			 void *app, u8 type)
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.h b/drivers/infiniband/hw/bnxt_re/qplib_res.h
index ccdab938d707..3a8162ef4c33 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.h
@@ -436,6 +436,10 @@ int bnxt_qplib_alloc_dpi(struct bnxt_qplib_res *res,
 			 void *app, u8 type);
 int bnxt_qplib_dealloc_dpi(struct bnxt_qplib_res *res,
 			   struct bnxt_qplib_dpi *dpi);
+int bnxt_qplib_alloc_uc_dpi(struct bnxt_qplib_res *res,
+			    struct bnxt_qplib_dpi *dpi);
+int bnxt_qplib_free_uc_dpi(struct bnxt_qplib_res *res,
+			   struct bnxt_qplib_dpi *dpi);
 void bnxt_qplib_cleanup_res(struct bnxt_qplib_res *res);
 int bnxt_qplib_init_res(struct bnxt_qplib_res *res);
 void bnxt_qplib_free_res(struct bnxt_qplib_res *res);
diff --git a/include/uapi/rdma/bnxt_re-abi.h b/include/uapi/rdma/bnxt_re-abi.h
index faa9d62b3b30..51f8614a7c4f 100644
--- a/include/uapi/rdma/bnxt_re-abi.h
+++ b/include/uapi/rdma/bnxt_re-abi.h
@@ -162,6 +162,8 @@ enum bnxt_re_objects {
 	BNXT_RE_OBJECT_ALLOC_PAGE = (1U << UVERBS_ID_NS_SHIFT),
 	BNXT_RE_OBJECT_NOTIFY_DRV,
 	BNXT_RE_OBJECT_GET_TOGGLE_MEM,
+	BNXT_RE_OBJECT_DBR,
+	BNXT_RE_OBJECT_DEFAULT_DBR,
 };
 
 enum bnxt_re_alloc_page_type {
@@ -215,4 +217,31 @@ enum bnxt_re_toggle_mem_methods {
 	BNXT_RE_METHOD_GET_TOGGLE_MEM = (1U << UVERBS_ID_NS_SHIFT),
 	BNXT_RE_METHOD_RELEASE_TOGGLE_MEM,
 };
+
+struct bnxt_re_dv_db_region {
+	__u32 dpi;
+	__u32 reserved;
+	__aligned_u64 umdbr;
+};
+
+enum bnxt_re_obj_dbr_alloc_attrs {
+	BNXT_RE_DV_ALLOC_DBR_HANDLE = (1U << UVERBS_ID_NS_SHIFT),
+	BNXT_RE_DV_ALLOC_DBR_ATTR,
+	BNXT_RE_DV_ALLOC_DBR_OFFSET,
+};
+
+enum bnxt_re_obj_dbr_free_attrs {
+	BNXT_RE_DV_FREE_DBR_HANDLE = (1U << UVERBS_ID_NS_SHIFT),
+};
+
+enum bnxt_re_obj_default_dbr_attrs {
+	BNXT_RE_DV_DEFAULT_DBR_ATTR = (1U << UVERBS_ID_NS_SHIFT),
+};
+
+enum bnxt_re_obj_dpi_methods {
+	BNXT_RE_METHOD_DBR_ALLOC = (1U << UVERBS_ID_NS_SHIFT),
+	BNXT_RE_METHOD_DBR_FREE,
+	BNXT_RE_METHOD_GET_DEFAULT_DBR,
+};
+
 #endif /* __BNXT_RE_UVERBS_ABI_H__*/
-- 
2.51.2.636.ga99f379adf


