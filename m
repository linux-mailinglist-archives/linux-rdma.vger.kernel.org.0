Return-Path: <linux-rdma+bounces-16757-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yL4MCOd8jGkcpgAAu9opvQ
	(envelope-from <linux-rdma+bounces-16757-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Feb 2026 13:58:15 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C3B2124994
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Feb 2026 13:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7185E30071F9
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Feb 2026 12:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1751D36B040;
	Wed, 11 Feb 2026 12:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Cpubn6No"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com [209.85.215.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7473536B07C
	for <linux-rdma@vger.kernel.org>; Wed, 11 Feb 2026 12:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770814692; cv=none; b=UiPoTESoXlLsvoAu+UZhcWc6ECga3SobO9JYWULg/8xou9S8C4G0FTn/NMdmb2/sGivj5R4uTqBAM6gVhUuARHQ1ex2cUmTk80WGA3XoaYuDfzMZMM6/GNisrUnJQdijatE4ho8x+Q7swsY7DQF2qXh1wBB/KUltIz7l4snAvIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770814692; c=relaxed/simple;
	bh=YOfQiNH8d7Vynuu+AHkdKWtGlxYxWQJAWbPAe4nP0ys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tYBCWhd5EExdNi2qUaKeeEb8QIZhjVuARTU4mlZG3HOiD0obUWVeRmCQTziYDpfk4o2F7GTqrcHut7wpNP3AGTr9EVfR5QhNB68nA1NffnTb74LF6kuscdxR/gQNKvY2eItKvJa6y7ErpD4fA+XrUXb2v2y8S1idmS53ACq5N+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Cpubn6No; arc=none smtp.client-ip=209.85.215.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f226.google.com with SMTP id 41be03b00d2f7-c6541e35fc0so1054522a12.3
        for <linux-rdma@vger.kernel.org>; Wed, 11 Feb 2026 04:58:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770814691; x=1771419491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ATudAJfgMKmPdSFtMNTawZldMJ08G+Ql57gr9hKflR8=;
        b=M/txzwWVgP2RaBu7A4vI/NKYKcFPwxozToyfE2E4rNdrbDl3R6HUVuv1TEFymf26Vo
         Rf2/5S7DxBjf8gsLOzggFw32/TwwBE/LdhxHQRFiY5aeFy/x9IHdm1NWt+C896nRZ/vl
         ZcwHcI36b+lCDbBCsM1xHMihK4a91K/mRF5f/JCv/ibeY0V8tU0ClKwvCJPSZm3tP1/6
         7N3tjXCFjVA4900GVGjMk6gYcFxbKfD/7qL9aPzVwD6o7B51pDv3r1UBA39Pgndx6zTu
         6mvJTBlv5scLXp0xO4nR3znsu32pZ7pcweFAWGkoRHw+bhoWsfETxt8AFMfd5Rc5g2qt
         hRnQ==
X-Gm-Message-State: AOJu0YzBwZ8Lx9Dd9JeM8M0o7DP7o4gfXLJbtXehaf3jOeWqeA8Zvp2S
	4NKOB1OHbS3o3/B863blqQ7xh1MXBw0VWaWpwn/iB484ioiuZQjMcPg7lgSCM6bK9d1CDdodBCT
	oq0RbhyhAgpCxm1hv+bhm4nai4cW76j0ZV/ffZuH5UE4QMZqfme378LSWMY/k5g/sonN9WP89u1
	1U0cgPUVSnRXzIXVynNnOcV3iYuJrnVTJL6FSPXqD/yNvv6KV4kcDGJfoQtXFN6MVCLy1BSKKut
	W4JfblGyvM7IiE6jLw2peNRRru5
X-Gm-Gg: AZuq6aLMgksqeUnNQvaTUJ8eM8ST4COai0qf/fSuKpN2yvZ7UXPEWLqayuj8mA8aK86
	+rNd2vFgVYs968uWKrXkdUcHKUHz8on0uDOCEXnyp/odpTHyZZr281IZOITMcGThUBZ3KZ9JOB9
	aHPRFDtiYC377bOdVflucQQ1u5WxANh3EoFalGE96jf0XHgPajuFkvrz1IPaVoe/yOqsd7qDAGs
	WeyJ+Ae4Gt1XjUFE6qBQ5HMHkkIv2oDDr67OzzsiuqsD1Xm/89NFtsInMJLIUrnb4yeHwqsBVWJ
	fo7K9JyCbZR3v+qsfCirWm/7YWINI8UZNaRuOrtWYE3YZbLB9VP0+THFfooQX/406q0DdWUIckx
	YzE7oEgV7XyejP0VOxDotRkztUXrKF/p6r0HbLRy5J9f8f0FS5QKUZghFtLwpjxpxU8a1DvJBM4
	7TIxqBJeNXowIwfKQOsAiSu233chF0yhO4oITyYtyMZHOhtBngWzf+ETCuw5ye/apuiyGFP/M=
X-Received: by 2002:a17:90b:4e88:b0:34c:2db6:57d5 with SMTP id 98e67ed59e1d1-354b3ac0385mr14572388a91.0.1770814690762;
        Wed, 11 Feb 2026 04:58:10 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-103.dlp.protect.broadcom.com. [144.49.247.103])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3567e3f5a72sm243025a91.0.2026.02.11.04.58.10
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Feb 2026 04:58:10 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a7b7f04a11so53342775ad.3
        for <linux-rdma@vger.kernel.org>; Wed, 11 Feb 2026 04:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770814689; x=1771419489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ATudAJfgMKmPdSFtMNTawZldMJ08G+Ql57gr9hKflR8=;
        b=Cpubn6NoMZeJ0Olb5KJl7LExuVWy4oOMDa72Vvkgk97yOb3nQc2s0nVBwnUyQVSHtT
         Y/0RssKIyhaNBYogg8ZXARql+ggXfCd46y1eTaOT4cjLCcCSBSwzWQs5L31u7ZOHQbJt
         XO4/31+pRNDUNFmlcR29apdzDiY3iVkzkYzZA=
X-Received: by 2002:a17:902:c401:b0:2a0:c1ed:d0d9 with SMTP id d9443c01a7336-2a95197677amr177757295ad.46.1770814688847;
        Wed, 11 Feb 2026 04:58:08 -0800 (PST)
X-Received: by 2002:a17:902:c401:b0:2a0:c1ed:d0d9 with SMTP id d9443c01a7336-2a95197677amr177757175ad.46.1770814688487;
        Wed, 11 Feb 2026 04:58:08 -0800 (PST)
Received: from dhcp-10-123-157-187.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ab299983d0sm22206515ad.79.2026.02.11.04.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 04:58:06 -0800 (PST)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v12 3/6] RDMA/bnxt_re: Support doorbell extensions
Date: Wed, 11 Feb 2026 18:19:24 +0530
Message-ID: <20260211124927.57617-4-sriharsha.basavapatna@broadcom.com>
X-Mailer: git-send-email 2.51.2.636.ga99f379adf
In-Reply-To: <20260211124927.57617-1-sriharsha.basavapatna@broadcom.com>
References: <20260211124927.57617-1-sriharsha.basavapatna@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16757-lists,linux-rdma=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:mid,broadcom.com:dkim,broadcom.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9C3B2124994
X-Rspamd-Action: no action

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

Some applications may need multiple doorbells to support parallel
processing of threads that each operate on a group of resources.

The following uapi methods have been implemented in this patch.

- BNXT_RE_METHOD_DBR_ALLOC:
  This will allow the appliation to create extra doorbell regions
  and use the associated doorbell page index in CREATE_QP and
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
 drivers/infiniband/hw/bnxt_re/ib_verbs.h  |   7 ++
 drivers/infiniband/hw/bnxt_re/qplib_res.c |  43 +++++++
 drivers/infiniband/hw/bnxt_re/qplib_res.h |   4 +
 drivers/infiniband/hw/bnxt_re/uapi.c      | 130 ++++++++++++++++++++++
 include/uapi/rdma/bnxt_re-abi.h           |  29 +++++
 5 files changed, 213 insertions(+)

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
index f01c1bb1fcb4..ffe31c952d50 100644
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
diff --git a/drivers/infiniband/hw/bnxt_re/uapi.c b/drivers/infiniband/hw/bnxt_re/uapi.c
index 0145882e49f6..05444c3bb2f3 100644
--- a/drivers/infiniband/hw/bnxt_re/uapi.c
+++ b/drivers/infiniband/hw/bnxt_re/uapi.c
@@ -331,9 +331,139 @@ DECLARE_UVERBS_NAMED_OBJECT(BNXT_RE_OBJECT_GET_TOGGLE_MEM,
 			    &UVERBS_METHOD(BNXT_RE_METHOD_GET_TOGGLE_MEM),
 			    &UVERBS_METHOD(BNXT_RE_METHOD_RELEASE_TOGGLE_MEM));
 
+static int UVERBS_HANDLER(BNXT_RE_METHOD_DBR_ALLOC)(struct uverbs_attr_bundle *attrs)
+{
+	struct bnxt_re_db_region dbr = {};
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
+	uobj = uverbs_attr_get_uobject(attrs, BNXT_RE_ALLOC_DBR_HANDLE);
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
+	uverbs_finalize_uobj_create(attrs, BNXT_RE_ALLOC_DBR_HANDLE);
+
+	dbr.umdbr = dpi->umdbr;
+	dbr.dpi = dpi->dpi;
+	ret = uverbs_copy_to_struct_or_zero(attrs, BNXT_RE_ALLOC_DBR_ATTR,
+					    &dbr, sizeof(dbr));
+	if (ret)
+		return ret;
+
+	ret = uverbs_copy_to(attrs, BNXT_RE_ALLOC_DBR_OFFSET,
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
+static int bnxt_re_dbr_cleanup(struct ib_uobject *uobject,
+			       enum rdma_remove_reason why,
+			       struct uverbs_attr_bundle *attrs)
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
+	struct bnxt_re_db_region dpi = {};
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
+	ret = uverbs_copy_to_struct_or_zero(attrs, BNXT_RE_DEFAULT_DBR_ATTR,
+					    &dpi, sizeof(dpi));
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+DECLARE_UVERBS_NAMED_METHOD(BNXT_RE_METHOD_DBR_ALLOC,
+			    UVERBS_ATTR_IDR(BNXT_RE_ALLOC_DBR_HANDLE,
+					    BNXT_RE_OBJECT_DBR,
+					    UVERBS_ACCESS_NEW,
+					    UA_MANDATORY),
+			    UVERBS_ATTR_PTR_OUT(BNXT_RE_ALLOC_DBR_ATTR,
+						UVERBS_ATTR_STRUCT(struct bnxt_re_db_region,
+								   umdbr),
+								   UA_MANDATORY),
+			    UVERBS_ATTR_PTR_OUT(BNXT_RE_ALLOC_DBR_OFFSET,
+						UVERBS_ATTR_TYPE(u64),
+						UA_MANDATORY));
+
+DECLARE_UVERBS_NAMED_METHOD_DESTROY(BNXT_RE_METHOD_DBR_FREE,
+				    UVERBS_ATTR_IDR(BNXT_RE_FREE_DBR_HANDLE,
+						    BNXT_RE_OBJECT_DBR,
+						    UVERBS_ACCESS_DESTROY,
+						    UA_MANDATORY));
+
+DECLARE_UVERBS_NAMED_OBJECT(BNXT_RE_OBJECT_DBR,
+			    UVERBS_TYPE_ALLOC_IDR(bnxt_re_dbr_cleanup),
+			    &UVERBS_METHOD(BNXT_RE_METHOD_DBR_ALLOC),
+			    &UVERBS_METHOD(BNXT_RE_METHOD_DBR_FREE));
+
+DECLARE_UVERBS_NAMED_METHOD(BNXT_RE_METHOD_GET_DEFAULT_DBR,
+			    UVERBS_ATTR_PTR_OUT(BNXT_RE_DEFAULT_DBR_ATTR,
+						UVERBS_ATTR_STRUCT(struct bnxt_re_db_region,
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
diff --git a/include/uapi/rdma/bnxt_re-abi.h b/include/uapi/rdma/bnxt_re-abi.h
index d15afa58963b..1f7685665db1 100644
--- a/include/uapi/rdma/bnxt_re-abi.h
+++ b/include/uapi/rdma/bnxt_re-abi.h
@@ -164,6 +164,8 @@ enum bnxt_re_objects {
 	BNXT_RE_OBJECT_ALLOC_PAGE = (1U << UVERBS_ID_NS_SHIFT),
 	BNXT_RE_OBJECT_NOTIFY_DRV,
 	BNXT_RE_OBJECT_GET_TOGGLE_MEM,
+	BNXT_RE_OBJECT_DBR,
+	BNXT_RE_OBJECT_DEFAULT_DBR,
 };
 
 enum bnxt_re_alloc_page_type {
@@ -232,4 +234,31 @@ struct bnxt_re_packet_pacing_caps {
 struct bnxt_re_query_device_ex_resp {
 	struct bnxt_re_packet_pacing_caps packet_pacing_caps;
 };
+
+struct bnxt_re_db_region {
+	__u32 dpi;
+	__u32 reserved;
+	__aligned_u64 umdbr;
+};
+
+enum bnxt_re_obj_dbr_alloc_attrs {
+	BNXT_RE_ALLOC_DBR_HANDLE = (1U << UVERBS_ID_NS_SHIFT),
+	BNXT_RE_ALLOC_DBR_ATTR,
+	BNXT_RE_ALLOC_DBR_OFFSET,
+};
+
+enum bnxt_re_obj_dbr_free_attrs {
+	BNXT_RE_FREE_DBR_HANDLE = (1U << UVERBS_ID_NS_SHIFT),
+};
+
+enum bnxt_re_obj_default_dbr_attrs {
+	BNXT_RE_DEFAULT_DBR_ATTR = (1U << UVERBS_ID_NS_SHIFT),
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


