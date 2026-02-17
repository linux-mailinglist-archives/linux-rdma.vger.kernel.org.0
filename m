Return-Path: <linux-rdma+bounces-16939-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eK+bAJ3bk2k89QEAu9opvQ
	(envelope-from <linux-rdma+bounces-16939-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 04:08:13 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9168C148988
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 04:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97B253019B99
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 03:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA82221FCF;
	Tue, 17 Feb 2026 03:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="f4gnt7QL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C51238C03
	for <linux-rdma@vger.kernel.org>; Tue, 17 Feb 2026 03:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771297683; cv=none; b=ioJ1Il3jwgERHNzScGFbtUeg/BPfAf+oRa09wcSPO313HkqbsRG9Ob7THn236DKqKtCVxLuwZq9wqi2Fhu+6njZyfsht8CZmFcjQEiygh//1c1c7KwvgBnInStkAUqf7fHKaBN/88eQn0an9+DRp+fm4ro5hMkB6CDyxuklD4Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771297683; c=relaxed/simple;
	bh=z32b863jvUsqp+OyWDAY9oCGwcpIIjG9wVsgEJMbdq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AqgqW+c1nziDq0QwqmrOjjMOG8OsVfGPNKtTXTRcu7QUm0uujZM/t8NLBgkUVT0QL8YDaKAzVO0/io44eLpKuRIHfn47CG5nOKHwAf9ZCxmNHa5/oAdqXrwQUry5jUsZm5kiBvzwLfdYq5u1wj3fQX0hNVxIsJORtPDlUr4zPw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=f4gnt7QL; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-2a91215c158so21706075ad.0
        for <linux-rdma@vger.kernel.org>; Mon, 16 Feb 2026 19:08:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771297681; x=1771902481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MD5GxYRUKkaR2mjHtmGsWQ0/D29wFSltD837u7dhuBs=;
        b=gVDETXSkEBr1t0B0sMspujPYGvgRInQ0f8CkRGIrncvc+aKUMG9PlXuliSwe55sauS
         T09gYsn12E+fttmmZPW9lRn0sQ2fldMJG7xhV4ICI0TPHVqCdBHL+OyTC7NwrfGwjaV5
         p0ZRNCB7ERQBxRIHnIJN1w41p1ZmUXwUn4k0MDdlhXxZy9EyDZhQCmrpIDCUv3cibz4u
         mUiBizjBgzPbwpYc6EwYMCJC5fLPXI51yE3/hde6lowXjm9bSHDjDN9uMgFo7sAflevL
         Uc8NkqiQKaZ9D96LW9EQw+QCANM4fAJdhZOEEvx47cfxLrptSkp5ap7RjM11LlLoIsTj
         GTsA==
X-Gm-Message-State: AOJu0YxDO4NNJoQXHQHh40bjM+GHS4jDMgbSUQ4FOi8Qj4fO8S/eF4zO
	ahGwsICsxI62KHnombhj4IjaA5UsGxlV1mgZYieS/auYfcJfNCMIdfHI7M+kdnY7gqFqXR7j3XA
	hVoCr9nxm45V1RywEqmFmApzEUfu4o0nqXIOrefnx+o5lpmaSIczP/evVa0M7A6JfL2TNlQAWQt
	Z3Ehmmy04/ZDVQpPbd54yLIV78lbaKXKY38XMfHlvuAc+f7r7Vd800G6urod4JzzlBPiWdM5hY6
	w1hT7FkBczhhN10LRnHfnnLcxgj
X-Gm-Gg: AZuq6aL3L/jC5k09drvIeLDSwG+fh7yEGK0MassqQ4Cc9oG/u1shgys9g/aQw7KfEFb
	W2sWZimfgBGhXBTlFLfM/WZmvrE4EW7YMTAvG+K6pmNloIYEbRKq0Ve4ZkgFnXz4vGqszaoXiRO
	ruA5tsXb6VnFAW4ZNwVLM4cLeCqxb8JPdD6NsSY4XE8+My76aO9rGK1G12hu69z6A3wC74f32kk
	M3pFXhoyZhfh97NGMpMfYOsfhLsg2s9yT4/9JehEZl9C5PRUQGmsCW74J4rVRWf+/wb6RYQvNWe
	W+OqHgQXJLLnM0qsaPBfvC2k+tZ5/KYSLdEJzpYi9eqhBYJXgBD2ZyWQc5APew69Ukovj4rPkFF
	1Ey0ipqkmL9jGB9bYyN8dVhxDuOuc4fXjxd/myXGDidoksuzwIm7D4taRn7NSynH9C7sYAkrALl
	zTnTQou7ZirUvYWG1w1E5j5Q6FMQg4jmtaLzYJ4IfR7zVLL72sWmOAI+47A1gsv+o91d7m
X-Received: by 2002:a17:902:ef46:b0:2aa:d671:fdf9 with SMTP id d9443c01a7336-2ab5056f7ddmr142089275ad.26.1771297681045;
        Mon, 16 Feb 2026 19:08:01 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2ad1a8bf49csm11850355ad.55.2026.02.16.19.08.00
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Feb 2026 19:08:01 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-352de7a89e1so3780133a91.1
        for <linux-rdma@vger.kernel.org>; Mon, 16 Feb 2026 19:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1771297679; x=1771902479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MD5GxYRUKkaR2mjHtmGsWQ0/D29wFSltD837u7dhuBs=;
        b=f4gnt7QLkoF3WYOSZG0bK1OmEhw7zTRhA42IbHeKxR17jkfLerWRELop7nfxUbXlC8
         JIWQuRUVzqAIaoUbn4d3Pq1aXUIwomeKsdEIfR++dEMeAo8q/44Z+Q47h4+xoHNlEHF2
         Txg3qvWYiWaGm+mnKip6qFoAnf4Htn92g93zM=
X-Received: by 2002:a17:90b:1f92:b0:354:7be4:a241 with SMTP id 98e67ed59e1d1-356aabe572dmr12119255a91.15.1771297679016;
        Mon, 16 Feb 2026 19:07:59 -0800 (PST)
X-Received: by 2002:a17:90b:1f92:b0:354:7be4:a241 with SMTP id 98e67ed59e1d1-356aabe572dmr12119244a91.15.1771297678583;
        Mon, 16 Feb 2026 19:07:58 -0800 (PST)
Received: from dhcp-10-123-157-187.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35662e537desm20688167a91.4.2026.02.16.19.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 19:07:58 -0800 (PST)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v13 5/6] RDMA/bnxt_re: Support dmabuf for CQ rings
Date: Tue, 17 Feb 2026 08:29:09 +0530
Message-ID: <20260217025910.15865-6-sriharsha.basavapatna@broadcom.com>
X-Mailer: git-send-email 2.51.2.636.ga99f379adf
In-Reply-To: <20260217025910.15865-1-sriharsha.basavapatna@broadcom.com>
References: <20260217025910.15865-1-sriharsha.basavapatna@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16939-lists,linux-rdma=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9168C148988
X-Rspamd-Action: no action

For CQs, kernel already supports pinning dmabuf based application
memory, specified through provider attributes. Register a new devop
for create_cq_umem() and process the umem argument. Refactor the
existing create_cq() handler so that code is shared across both
handlers.

Signed-off-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 153 +++++++++++++++--------
 drivers/infiniband/hw/bnxt_re/ib_verbs.h |   2 +
 drivers/infiniband/hw/bnxt_re/main.c     |   1 +
 3 files changed, 106 insertions(+), 50 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 9fa89f330c5a..8ab959d16551 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -3368,8 +3368,8 @@ static int bnxt_re_setup_sginfo(struct bnxt_re_dev *rdev,
 	return 0;
 }
 
-int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
-		      struct uverbs_attr_bundle *attrs)
+int bnxt_re_create_cq_umem(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
+			   struct ib_umem *umem, struct uverbs_attr_bundle *attrs)
 {
 	struct bnxt_re_cq *cq = container_of(ibcq, struct bnxt_re_cq, ib_cq);
 	struct bnxt_re_dev *rdev = to_bnxt_re_dev(ibcq->device, ibdev);
@@ -3378,6 +3378,8 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		rdma_udata_to_drv_context(udata, struct bnxt_re_ucontext, ib_uctx);
 	struct bnxt_qplib_dev_attr *dev_attr = rdev->dev_attr;
 	struct bnxt_qplib_chip_ctx *cctx;
+	struct bnxt_re_cq_resp resp = {};
+	struct bnxt_re_cq_req req;
 	int cqe = attr->cqe;
 	int rc, entries;
 	u32 active_cqs;
@@ -3399,38 +3401,27 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	if (entries > dev_attr->max_cq_wqes + 1)
 		entries = dev_attr->max_cq_wqes + 1;
 
-	if (udata) {
-		struct bnxt_re_cq_req req;
-
-		rc = ib_copy_validate_udata_in(udata, req, cq_handle);
-		if (rc)
-			goto fail;
+	rc = ib_copy_validate_udata_in(udata, req, cq_handle);
+	if (rc)
+		return rc;
 
+	if (umem) {
+		cq->umem = umem;
+	} else {
 		cq->umem = ib_umem_get(&rdev->ibdev, req.cq_va,
 				       entries * sizeof(struct cq_base),
 				       IB_ACCESS_LOCAL_WRITE);
 		if (IS_ERR(cq->umem)) {
 			rc = PTR_ERR(cq->umem);
-			goto fail;
+			return rc;
 		}
-		rc = bnxt_re_setup_sginfo(rdev, cq->umem, &cq->qplib_cq.sg_info);
-		if (rc)
-			goto fail;
+	}
 
-		cq->qplib_cq.dpi = &uctx->dpi;
-	} else {
-		cq->max_cql = min_t(u32, entries, MAX_CQL_PER_POLL);
-		cq->cql = kcalloc(cq->max_cql, sizeof(struct bnxt_qplib_cqe),
-				  GFP_KERNEL);
-		if (!cq->cql) {
-			rc = -ENOMEM;
-			goto fail;
-		}
+	rc = bnxt_re_setup_sginfo(rdev, cq->umem, &cq->qplib_cq.sg_info);
+	if (rc)
+		goto fail;
 
-		cq->qplib_cq.sg_info.pgsize = SZ_4K;
-		cq->qplib_cq.sg_info.pgshft = __builtin_ctz(SZ_4K);
-		cq->qplib_cq.dpi = &rdev->dpi_privileged;
-	}
+	cq->qplib_cq.dpi = &uctx->dpi;
 	cq->qplib_cq.max_wqe = entries;
 	cq->qplib_cq.coalescing = &rdev->cq_coalescing;
 	cq->qplib_cq.nq = bnxt_re_get_nq(rdev);
@@ -3444,43 +3435,105 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 
 	cq->ib_cq.cqe = entries;
 	cq->cq_period = cq->qplib_cq.period;
-
 	active_cqs = atomic_inc_return(&rdev->stats.res.cq_count);
 	if (active_cqs > rdev->stats.res.cq_watermark)
 		rdev->stats.res.cq_watermark = active_cqs;
 	spin_lock_init(&cq->cq_lock);
 
-	if (udata) {
-		struct bnxt_re_cq_resp resp = {};
-
-		if (cctx->modes.toggle_bits & BNXT_QPLIB_CQ_TOGGLE_BIT) {
-			hash_add(rdev->cq_hash, &cq->hash_entry, cq->qplib_cq.id);
-			/* Allocate a page */
-			cq->uctx_cq_page = (void *)get_zeroed_page(GFP_KERNEL);
-			if (!cq->uctx_cq_page) {
-				rc = -ENOMEM;
-				goto c2fail;
-			}
-			resp.comp_mask |= BNXT_RE_CQ_TOGGLE_PAGE_SUPPORT;
-		}
-		resp.cqid = cq->qplib_cq.id;
-		resp.tail = cq->qplib_cq.hwq.cons;
-		resp.phase = cq->qplib_cq.period;
-		resp.rsvd = 0;
-		rc = ib_respond_udata(udata, resp);
-		if (rc) {
-			ibdev_err(&rdev->ibdev, "Failed to copy CQ udata");
-			bnxt_qplib_destroy_cq(&rdev->qplib_res, &cq->qplib_cq);
-			goto free_mem;
+	if (cctx->modes.toggle_bits & BNXT_QPLIB_CQ_TOGGLE_BIT) {
+		hash_add(rdev->cq_hash, &cq->hash_entry, cq->qplib_cq.id);
+		/* Allocate a page */
+		cq->uctx_cq_page = (void *)get_zeroed_page(GFP_KERNEL);
+		if (!cq->uctx_cq_page) {
+			rc = -ENOMEM;
+			goto fail;
 		}
+		resp.comp_mask |= BNXT_RE_CQ_TOGGLE_PAGE_SUPPORT;
+	}
+	resp.cqid = cq->qplib_cq.id;
+	resp.tail = cq->qplib_cq.hwq.cons;
+	resp.phase = cq->qplib_cq.period;
+	resp.rsvd = 0;
+	rc = ib_respond_udata(udata, resp);
+	if (rc) {
+		ibdev_err(&rdev->ibdev, "Failed to copy CQ udata");
+		bnxt_qplib_destroy_cq(&rdev->qplib_res, &cq->qplib_cq);
+		goto free_mem;
 	}
 
 	return 0;
 
 free_mem:
 	free_page((unsigned long)cq->uctx_cq_page);
-c2fail:
-	ib_umem_release(cq->umem);
+fail:
+	if (!umem)
+		ib_umem_release(cq->umem);
+	return rc;
+}
+
+int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
+		      struct uverbs_attr_bundle *attrs)
+{
+	struct bnxt_re_cq *cq = container_of(ibcq, struct bnxt_re_cq, ib_cq);
+	struct bnxt_re_dev *rdev = to_bnxt_re_dev(ibcq->device, ibdev);
+	struct ib_udata *udata = &attrs->driver_udata;
+	struct bnxt_re_ucontext *uctx =
+		rdma_udata_to_drv_context(udata, struct bnxt_re_ucontext, ib_uctx);
+	struct bnxt_qplib_dev_attr *dev_attr = rdev->dev_attr;
+	struct bnxt_qplib_chip_ctx *cctx;
+	int cqe = attr->cqe;
+	int rc, entries;
+	u32 active_cqs;
+
+	if (udata)
+		return bnxt_re_create_cq_umem(ibcq, attr, NULL, attrs);
+
+	if (attr->flags)
+		return -EOPNOTSUPP;
+
+	/* Validate CQ fields */
+	if (cqe < 1 || cqe > dev_attr->max_cq_wqes) {
+		ibdev_err(&rdev->ibdev, "Failed to create CQ -max exceeded");
+		return -EINVAL;
+	}
+
+	cq->rdev = rdev;
+	cctx = rdev->chip_ctx;
+	cq->qplib_cq.cq_handle = (u64)(unsigned long)(&cq->qplib_cq);
+
+	entries = bnxt_re_init_depth(cqe + 1, uctx);
+	if (entries > dev_attr->max_cq_wqes + 1)
+		entries = dev_attr->max_cq_wqes + 1;
+
+	cq->max_cql = min_t(u32, entries, MAX_CQL_PER_POLL);
+	cq->cql = kcalloc(cq->max_cql, sizeof(struct bnxt_qplib_cqe),
+			  GFP_KERNEL);
+	if (!cq->cql)
+		return -ENOMEM;
+
+	cq->qplib_cq.sg_info.pgsize = SZ_4K;
+	cq->qplib_cq.sg_info.pgshft = __builtin_ctz(SZ_4K);
+	cq->qplib_cq.dpi = &rdev->dpi_privileged;
+	cq->qplib_cq.max_wqe = entries;
+	cq->qplib_cq.coalescing = &rdev->cq_coalescing;
+	cq->qplib_cq.nq = bnxt_re_get_nq(rdev);
+	cq->qplib_cq.cnq_hw_ring_id = cq->qplib_cq.nq->ring_id;
+
+	rc = bnxt_qplib_create_cq(&rdev->qplib_res, &cq->qplib_cq);
+	if (rc) {
+		ibdev_err(&rdev->ibdev, "Failed to create HW CQ");
+		goto fail;
+	}
+
+	cq->ib_cq.cqe = entries;
+	cq->cq_period = cq->qplib_cq.period;
+	active_cqs = atomic_inc_return(&rdev->stats.res.cq_count);
+	if (active_cqs > rdev->stats.res.cq_watermark)
+		rdev->stats.res.cq_watermark = active_cqs;
+	spin_lock_init(&cq->cq_lock);
+
+	return 0;
+
 fail:
 	kfree(cq->cql);
 	return rc;
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
index 33e0f66b39eb..27cbe9a1c7e1 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
@@ -254,6 +254,8 @@ int bnxt_re_post_recv(struct ib_qp *qp, const struct ib_recv_wr *recv_wr,
 		      const struct ib_recv_wr **bad_recv_wr);
 int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		      struct uverbs_attr_bundle *attrs);
+int bnxt_re_create_cq_umem(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
+			   struct ib_umem *umem, struct uverbs_attr_bundle *attrs);
 int bnxt_re_resize_cq(struct ib_cq *ibcq, int cqe, struct ib_udata *udata);
 int bnxt_re_destroy_cq(struct ib_cq *cq, struct ib_udata *udata);
 int bnxt_re_poll_cq(struct ib_cq *cq, int num_entries, struct ib_wc *wc);
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 73003ad25ee8..401a481afecc 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -1334,6 +1334,7 @@ static const struct ib_device_ops bnxt_re_dev_ops = {
 	.alloc_ucontext = bnxt_re_alloc_ucontext,
 	.create_ah = bnxt_re_create_ah,
 	.create_cq = bnxt_re_create_cq,
+	.create_cq_umem = bnxt_re_create_cq_umem,
 	.create_qp = bnxt_re_create_qp,
 	.create_srq = bnxt_re_create_srq,
 	.create_user_ah = bnxt_re_create_ah,
-- 
2.51.2.636.ga99f379adf


