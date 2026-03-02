Return-Path: <linux-rdma+bounces-17376-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEPlCf1vpWmSBAYAu9opvQ
	(envelope-from <linux-rdma+bounces-17376-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Mar 2026 12:09:49 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D60811D73D2
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Mar 2026 12:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 03C113032DD0
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Mar 2026 11:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D8635FF61;
	Mon,  2 Mar 2026 11:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VzCCB7Wn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f225.google.com (mail-yw1-f225.google.com [209.85.128.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C776C3603C3
	for <linux-rdma@vger.kernel.org>; Mon,  2 Mar 2026 11:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772449773; cv=none; b=c9U9eQSxp+gqYDr0SwSzFAYs1Aju3V1KqrCc9Gupd8yiU37NhNGg4uGZnoABnRB2m+MgT691w30G+NuAdH3HvaPQnFRIkw0y1hOu+jVfpqshFXpXG47/He1n5C44FDZ5Kqml/NwBfkBnM4HZRB9H1D53c4SOl8uSOXdWF+aFZ3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772449773; c=relaxed/simple;
	bh=uCTxfxvBTG6oarmzKlatMlQSMq9eYJNh5SOyUiDfARs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L2LmhWJVAGcedaL18LIm5BkA9EcbS+AJDWGZ/yGaXcn/ALCKgQVpeEVqgy6Vr2KqDlCyTDxbXBQxbmvYOOCqVKqPqV3T7HuFwDgsf9K+U5zHkpo1j//wVhg0zWuarfw/N89BL9G4H3iPwLqdedVVGFm4AhQ1FxkMexL9FLEmqao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VzCCB7Wn; arc=none smtp.client-ip=209.85.128.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f225.google.com with SMTP id 00721157ae682-79868eae536so41020897b3.0
        for <linux-rdma@vger.kernel.org>; Mon, 02 Mar 2026 03:09:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772449771; x=1773054571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ACah+YHJAEfihYUDUIqxh4x4GOjdlTZRtnyHgDoDLK0=;
        b=UfMJsek94gIy3/QmBua/NhNMrAl4GyMLibpYzyHgO16IlL06Y97WV5y/I2GOQ7QLXI
         qczSVSgek8JcVRV0rdmCgB8W7fUUqohPFFqzruJ8WGLmS+XybfnbA+ecbo+9D4HMX6gK
         RFMRRcMBOb/bLFXKGPYXoT2vFwzyLGWbSTRJl/crZ+wOgVsaL6JBwR+SAuiHF95RROdW
         jlQ4aiYS8vYZsESa+RcW/mQANXWDCHXSXki6llgQ3H0gOetmmq9gLel5WVhRfYntthPJ
         t7F30v3bbFqujTeIAlMPtq5l0PWioVTyOe/4/gY6WNT5OnzXAxBaTgIqTXEdXIeKTR/V
         78mQ==
X-Gm-Message-State: AOJu0YyEdrF/G5Xxr3VnRZ5sqUoAZ/llwgTrKD1hLVDobKnNmZR56U/w
	oj0pUamShYNIXE4GyADdcv6SIzJC3+YCj8TqAS6nMfZBJHdkVcRPVxCVu+ppwOPY8HoKkyXqGtI
	C0zY1DobrlgoP/UdVjAWDofDMcWB/fKxtcyhNEa5Flpjdh6zVIzTikY2C28CkhGisiYbPqUp6qM
	3BSUS5tsWIQ6vlXKrQUw1feXbQ0iszXXGJTPhgzqH96tgd0XCsY4sOjPz58qyphs49K28lVW5ux
	53o/bVY80ZqcT9OkvdW4LXPGKAJ
X-Gm-Gg: ATEYQzxWAqs5pJTnwoshZolhxSA6DnhwM5g1HFBGC4n4UCQkwAFP8Zxw1eTdxh6VS7j
	f0pP9o7h7NRmEVU8004R9TJYF4tC/KxljVHTzp9zFeGdHGBzk8LlTzKcHLsHmflRGYslPRWjONj
	gAkMTHxuJ6bMfPMMaKhawXdT9EdhxXkylmm0PqLThU5xLMAzCXca1aKEMPGmTDb2ZhHEnXiMV77
	K1tzG+hHJNmE3YQh+uhk/mmJHdySbTDzRL0faa+XdpJy0hn2Mva00O3jAnwu+ITNhO1zNVKxIDW
	50YY21IJozDEue5hV1l+x4EDutLPMAVehTXCRtnvS1cbtHhkPbZKNNoYoI//idLPcIexo3bI9JN
	7H0lyV2wC05nuMu4TPL7l/JtvMMrNqYTRSeD/rxTSJZA/ZHsJuwpLaxGrpkps2U04jB88v5furK
	J0ujqdaRL86XgDynK3G1jypjphuGYSMrzwKBMfqGsq62iPW9iVhm4jfxK4XK6BRLLErA==
X-Received: by 2002:a05:690c:c08:b0:798:6898:9717 with SMTP id 00721157ae682-798854f22c8mr116199227b3.27.1772449770691;
        Mon, 02 Mar 2026 03:09:30 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-79876c4d3c6sm15091077b3.24.2026.03.02.03.09.30
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Mar 2026 03:09:30 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ae405e95f5so17892115ad.2
        for <linux-rdma@vger.kernel.org>; Mon, 02 Mar 2026 03:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772449769; x=1773054569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ACah+YHJAEfihYUDUIqxh4x4GOjdlTZRtnyHgDoDLK0=;
        b=VzCCB7WnvTTedtNbSXlL4qMJn8bFMaE2ExVn+7voEfnFuqdYCXRRAdlkD6MfMBdXNS
         bzB21o4vyg8dqbrWK2d/ZcmLgnZNHTNiJvuMzrgDbKtYwKKcWmVmdKqBFVVA5pt/9eOH
         jOxDZ9UpTWBE4BQxhNbOpPchiBWskKIx0rrrw=
X-Received: by 2002:a17:902:d510:b0:2ad:d77c:bf6a with SMTP id d9443c01a7336-2ae2e3d674dmr138047995ad.26.1772449769336;
        Mon, 02 Mar 2026 03:09:29 -0800 (PST)
X-Received: by 2002:a17:902:d510:b0:2ad:d77c:bf6a with SMTP id d9443c01a7336-2ae2e3d674dmr138047725ad.26.1772449768886;
        Mon, 02 Mar 2026 03:09:28 -0800 (PST)
Received: from dhcp-10-123-157-187.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae4651e409sm58391755ad.44.2026.03.02.03.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 03:09:28 -0800 (PST)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v14 3/6] RDMA/bnxt_re: Support doorbell extensions
Date: Mon,  2 Mar 2026 16:30:33 +0530
Message-ID: <20260302110036.36387-4-sriharsha.basavapatna@broadcom.com>
X-Mailer: git-send-email 2.51.2.636.ga99f379adf
In-Reply-To: <20260302110036.36387-1-sriharsha.basavapatna@broadcom.com>
References: <20260302110036.36387-1-sriharsha.basavapatna@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17376-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,broadcom.com:mid,broadcom.com:dkim,broadcom.com:email];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D60811D73D2
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
index 41ad8c2018fd..0fb7413c63c1 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.c
@@ -683,6 +683,49 @@ static int bnxt_qplib_alloc_pd_tbl(struct bnxt_qplib_res *res,
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
index 0145882e49f6..3eaee7101615 100644
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
+	obj = kzalloc_obj(*obj);
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
index 66d7edc88f88..b5d2e3d7fd7e 100644
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


