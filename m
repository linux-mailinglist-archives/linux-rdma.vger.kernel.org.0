Return-Path: <linux-rdma+bounces-22400-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aihEJma9OGpqhQcAu9opvQ
	(envelope-from <linux-rdma+bounces-22400-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jun 2026 06:43:18 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDA86AC993
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jun 2026 06:43:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=RcdGTu0o;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22400-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22400-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1FA6300A632
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jun 2026 04:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76863546DE;
	Mon, 22 Jun 2026 04:43:14 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ot1-f98.google.com (mail-ot1-f98.google.com [209.85.210.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2850933ADB3
	for <linux-rdma@vger.kernel.org>; Mon, 22 Jun 2026 04:43:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782103394; cv=none; b=Lx20MABgV+bPqq/kknjf67BY8b90nqrtuZmcURQR8eF0i5+pTrrpUFmGuqvvh+K6h5ryR8aBmbtxZC5ZDhNg7Rq1bn0QRNKqi15JeqS4y/3527ptMJZAGtAqzGSskFWQ6nbfUg0SXdJGWdq5RJuDRFYR4ATjBCy+CadWTQB4gFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782103394; c=relaxed/simple;
	bh=zOjE786rVJ/ob1/FltyoBpjzY/+2YifNbUqUhe73z5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S629g0qk3dySa3AzTq5noVBGh9sJnuFdOND4G9kOB1yxDqJpHeJSbikUYh8SCXgLEYUJ19xcR5/5U0yv4+2SRws+SGx7KY2UCmt1srQqt24G6xtYWT/XEFEiMUws2g5ESXGjLU1npWdjHQXx9wWL/S6Y1Ek9aUl5do0k2iZC8Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=RcdGTu0o; arc=none smtp.client-ip=209.85.210.98
Received: by mail-ot1-f98.google.com with SMTP id 46e09a7af769-7e6e9408e30so3524733a34.2
        for <linux-rdma@vger.kernel.org>; Sun, 21 Jun 2026 21:43:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782103392; x=1782708192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+t+z3HgUfvygpLIXVucj2RCBcM5wvIk0MxN/oFxilmY=;
        b=lOGKOu+E7wY8grzVjYcm3O58Dx05BiPZ0p3MzAeNoT7SeAf0pX6oZRJ/3VyqL1eHXq
         UDZ9G+0SFq0JULf8tE6wY8T+zzvMvLu5bO/QKKoB5lpT21gXbJRzs687aXwsrUnhUaM0
         3jy1EJfXiLQ6hubfy5wG5ttSj87emFKhTCZ7NbFFFdkjbZ3TiFJkpp/9w2+VYQ4PoRXw
         9xcZMmpNdx8moKPS8Lu6axP10d12QdwBpjIL4lJDW3VVYeI8AHTobtPrhALBFuPcNpi4
         gndgE8B+v5awYn+zog0ko6hPYApj7J+9GENvw4fh8ThbzBh4Icv5vGaiMEuFz/KWxVth
         5VDw==
X-Gm-Message-State: AOJu0YyY0wPB+UU6US6kUW1aZXpK2K2uvfz1k8lD5bklqJCZqpZCNbqZ
	8JzA71SrpVum/wSrCsIoEMfwujnJnQSaApPOr0/6Qs9qBb/9icWu9P1wwQPnd9K2HMtSg65n+mm
	ppJN0IdwVqoNVsCQIvHz89Fjh2mye2aDQUUH1oBXBbCSp7j07uM6XnHbnQ2sUH9uFfO/5yCE9ML
	DsPpNd0xm14yH9INbruLnqd4N7nKEluMke3MNUMJ8aKCgALVomeWzcatwTW7dApAt1mIO46rZwD
	DOiyYJdjN+s5NceaA==
X-Gm-Gg: AfdE7clHyD3oFPZa7W1UB6G1rtwoMZBeqS3sNdnvkaANMYzD6C9qoiMxPO0uEJkvX2j
	zWg63iU8rZaA4ZlzVMckb9r96LnQhfHev5ZQuq+OiKfJYlkHxwPGoDQZulJtrRXbSoy+WgISfgi
	zzcaf/PGQ2fkIyJsqmWm846bYdeMiOLaEFo2TiQ5ytLUiJWkAwDm/G5xM3LPn9OpqCT4KTnuNfV
	kPQHJ1AH0772AoKnXfE3P5j+psbbtbvpx6nGoM5fvBWTA6oPWiEvkTSj7VT6BlKcduuQmde+lIt
	a+MMBWowNqX2w5DfLqrqvyWXbshjU65LaWMTAI1KaGVLOhBa5ZN9WM7V8iheyC+nVTkYzzAAy7H
	ivEFSkdsFiyZ+wOvyuPy8SQnbdgOvgg19noLO8JwRATDHXdfs/UkQBKa/B0cxdzlo1RrMbgORrg
	4znorYudPJ3/CPMQOGfNkaRAmfrbxVP4WCAMHVEZDyhcaoLZU=
X-Received: by 2002:a05:6830:2641:b0:7e6:cc17:c7ac with SMTP id 46e09a7af769-7e92d9d0145mr12571045a34.22.1782103392028;
        Sun, 21 Jun 2026 21:43:12 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-18.dlp.protect.broadcom.com. [144.49.247.18])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-7e944205639sm477891a34.3.2026.06.21.21.43.11
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Jun 2026 21:43:12 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2c0d0516ad7so43007015ad.0
        for <linux-rdma@vger.kernel.org>; Sun, 21 Jun 2026 21:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1782103390; x=1782708190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+t+z3HgUfvygpLIXVucj2RCBcM5wvIk0MxN/oFxilmY=;
        b=RcdGTu0oF17tycClOQZPQ7VjfNHJtatK9XSd6UNN/R+y/kp5AotCG6wXUS1yyD5FHR
         VizChYjsbBiwzk0URADsqDFdoTOjpuklp0QQGsXHkijg+/fDswePSKje6XhQY/NfTbNS
         ZpFGhjdNO2ghO5RP/sNJfxuHN+6h43DifXyXU=
X-Received: by 2002:a17:902:f64e:b0:2c2:8659:da44 with SMTP id d9443c01a7336-2c719054d47mr146981475ad.36.1782103390497;
        Sun, 21 Jun 2026 21:43:10 -0700 (PDT)
X-Received: by 2002:a17:902:f64e:b0:2c2:8659:da44 with SMTP id d9443c01a7336-2c719054d47mr146981175ad.36.1782103390007;
        Sun, 21 Jun 2026 21:43:10 -0700 (PDT)
Received: from dhcp-10-123-156-114.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7439f901bsm60607475ad.44.2026.06.21.21.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 21:43:09 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	sriharsha.basavapatna@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH for-next 2/2] RDMA/bnxt_re: Add uverbs object handle path for CQ/SRQ toggle page
Date: Mon, 22 Jun 2026 03:05:28 -0700
Message-Id: <20260622100528.132463-3-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260622100528.132463-1-selvin.xavier@broadcom.com>
References: <20260622100528.132463-1-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_DMARC(-7.00)[broadcom.com:D:+];
	DATE_IN_FUTURE(4.00)[5];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-22400-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:jgg@ziepe.ca,m:linux-rdma@vger.kernel.org,m:andrew.gospodarek@broadcom.com,m:kalesh-anakkur.purayil@broadcom.com,m:sriharsha.basavapatna@broadcom.com,m:selvin.xavier@broadcom.com,m:jgg@nvidia.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[selvin.xavier@broadcom.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[selvin.xavier@broadcom.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ECDA86AC993

The current GET_TOGGLE_MEM ioctl requires the caller to supply
a type enum and a raw hardware queue ID (RES_ID). The kernel
looks up the CQ or SRQ by that ID without verifying that the
caller owns the resource.

Add a new, preferred code path that accepts standard uverbs
object handles (BNXT_RE_TOGGLE_MEM_CQ_HANDLE /
BNXT_RE_TOGGLE_MEM_SRQ_HANDLE) instead.

Only newer rdma-core versions support this path. Capability is
negotiated during context creation using the req mask
(BNXT_RE_COMP_MASK_REQ_UCNTX_TOGGLE_MEM_UOBJ_SUPPORT) and resp
mask (BNXT_RE_UCNTX_CMASK_TOGGLE_MEM_UOBJ_SUPPORT).
The existing TYPE + RES_ID path is retained for backward
compatibility with older rdma-core.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c |  7 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.h |  1 +
 drivers/infiniband/hw/bnxt_re/uapi.c     | 95 ++++++++++++++++--------
 include/uapi/rdma/bnxt_re-abi.h          |  4 +
 4 files changed, 74 insertions(+), 33 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 72b4c47d694a..301116dcf55f 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -4825,7 +4825,8 @@ int bnxt_re_alloc_ucontext(struct ib_ucontext *ctx, struct ib_udata *udata)
 		rc = ib_copy_validate_udata_in_cm(
 			udata, ureq, comp_mask,
 			BNXT_RE_COMP_MASK_REQ_UCNTX_POW2_SUPPORT |
-				BNXT_RE_COMP_MASK_REQ_UCNTX_VAR_WQE_SUPPORT);
+				BNXT_RE_COMP_MASK_REQ_UCNTX_VAR_WQE_SUPPORT |
+				BNXT_RE_COMP_MASK_REQ_UCNTX_TOGGLE_MEM_UOBJ_SUPPORT);
 		if (rc)
 			goto cfail;
 		if (ureq.comp_mask & BNXT_RE_COMP_MASK_REQ_UCNTX_POW2_SUPPORT) {
@@ -4838,6 +4839,10 @@ int bnxt_re_alloc_ucontext(struct ib_ucontext *ctx, struct ib_udata *udata)
 			if (resp.mode == BNXT_QPLIB_WQE_MODE_VARIABLE)
 				uctx->cmask |= BNXT_RE_UCNTX_CAP_VAR_WQE_ENABLED;
 		}
+		if (ureq.comp_mask & BNXT_RE_COMP_MASK_REQ_UCNTX_TOGGLE_MEM_UOBJ_SUPPORT) {
+			uctx->cmask |= BNXT_RE_UCNTX_CAP_TOGGLE_MEM_UOBJ;
+			resp.comp_mask |= BNXT_RE_UCNTX_CMASK_TOGGLE_MEM_UOBJ_SUPPORT;
+		}
 	}
 
 	xa_init(&uctx->cq_xa);
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
index 76f407cd3435..85e594a25448 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
@@ -193,6 +193,7 @@ static inline u16 bnxt_re_get_rwqe_size(int nsge)
 enum {
 	BNXT_RE_UCNTX_CAP_POW2_DISABLED = 0x1ULL,
 	BNXT_RE_UCNTX_CAP_VAR_WQE_ENABLED = 0x2ULL,
+	BNXT_RE_UCNTX_CAP_TOGGLE_MEM_UOBJ = 0x4ULL,
 };
 
 static inline u32 bnxt_re_init_depth(u32 ent, u32 max,
diff --git a/drivers/infiniband/hw/bnxt_re/uapi.c b/drivers/infiniband/hw/bnxt_re/uapi.c
index 9485aa890b04..3109bd511f58 100644
--- a/drivers/infiniband/hw/bnxt_re/uapi.c
+++ b/drivers/infiniband/hw/bnxt_re/uapi.c
@@ -216,53 +216,76 @@ static int UVERBS_HANDLER(BNXT_RE_METHOD_GET_TOGGLE_MEM)(struct uverbs_attr_bund
 {
 	struct ib_uobject *uobj = uverbs_attr_get_uobject(attrs, BNXT_RE_TOGGLE_MEM_HANDLE);
 	enum bnxt_re_mmap_flag mmap_flag = BNXT_RE_MMAP_TOGGLE_PAGE;
-	enum bnxt_re_get_toggle_mem_type res_type;
 	struct bnxt_re_user_mmap_entry *entry;
 	struct bnxt_re_ucontext *uctx;
 	struct ib_ucontext *ib_uctx;
+	struct ib_uobject *res_uobj;
 	u32 length = PAGE_SIZE;
-	struct bnxt_re_srq *srq;
-	struct bnxt_re_cq *cq;
 	u64 mem_offset;
 	u32 offset = 0;
 	u64 addr = 0;
-	u32 res_id;
 	int err;
 
 	ib_uctx = ib_uverbs_get_ucontext(attrs);
 	if (IS_ERR(ib_uctx))
 		return PTR_ERR(ib_uctx);
 
-	err = uverbs_get_const(&res_type, attrs, BNXT_RE_TOGGLE_MEM_TYPE);
-	if (err)
-		return err;
-
 	uctx = container_of(ib_uctx, struct bnxt_re_ucontext, ib_uctx);
-	err = uverbs_copy_from(&res_id, attrs, BNXT_RE_TOGGLE_MEM_RES_ID);
-	if (err)
-		return err;
+	res_uobj = uverbs_attr_get_uobject(attrs, BNXT_RE_TOGGLE_MEM_CQ_HANDLE);
+	if (!IS_ERR(res_uobj)) {
+		struct bnxt_re_cq *cq =
+			container_of((struct ib_cq *)res_uobj->object,
+				     struct bnxt_re_cq, ib_cq);
 
-	switch (res_type) {
-	case BNXT_RE_CQ_TOGGLE_MEM:
-		cq = xa_load(&uctx->cq_xa, res_id);
-		if (!cq)
-			return -EINVAL;
 		addr = (u64)cq->uctx_cq_page;
-		if (!addr)
-			return -EOPNOTSUPP;
-		break;
-	case BNXT_RE_SRQ_TOGGLE_MEM:
-		srq = xa_load(&uctx->srq_xa, res_id);
-		if (!srq)
-			return -EINVAL;
-		addr = (u64)srq->uctx_srq_page;
-		if (!addr)
-			return -EOPNOTSUPP;
-		break;
-	default:
-		return -EOPNOTSUPP;
+	} else {
+		res_uobj = uverbs_attr_get_uobject(attrs, BNXT_RE_TOGGLE_MEM_SRQ_HANDLE);
+		if (!IS_ERR(res_uobj)) {
+			struct bnxt_re_srq *srq =
+				container_of((struct ib_srq *)res_uobj->object,
+					     struct bnxt_re_srq, ib_srq);
+
+			addr = (u64)srq->uctx_srq_page;
+		} else {
+			/*
+			 * Legacy path: old libbnxt_re sends TYPE + RES_ID.
+			 * Look up the CQ or SRQ in the per-context XArray
+			 */
+			enum bnxt_re_get_toggle_mem_type res_type;
+			u32 res_id;
+
+			err = uverbs_get_const(&res_type, attrs,
+					       BNXT_RE_TOGGLE_MEM_TYPE);
+			if (err)
+				return err;
+			err = uverbs_copy_from(&res_id, attrs,
+					       BNXT_RE_TOGGLE_MEM_RES_ID);
+			if (err)
+				return err;
+
+			if (res_type == BNXT_RE_CQ_TOGGLE_MEM) {
+				struct bnxt_re_cq *cq =
+					xa_load(&uctx->cq_xa, res_id);
+
+				if (!cq)
+					return -EINVAL;
+				addr = (u64)cq->uctx_cq_page;
+			} else if (res_type == BNXT_RE_SRQ_TOGGLE_MEM) {
+				struct bnxt_re_srq *srq =
+					xa_load(&uctx->srq_xa, res_id);
+
+				if (!srq)
+					return -EINVAL;
+				addr = (u64)srq->uctx_srq_page;
+			} else {
+				return -EOPNOTSUPP;
+			}
+		}
 	}
 
+	if (!addr)
+		return -EOPNOTSUPP;
+
 	entry = bnxt_re_mmap_entry_insert(uctx, addr, mmap_flag, &mem_offset);
 	if (!entry)
 		return -ENOMEM;
@@ -304,10 +327,10 @@ DECLARE_UVERBS_NAMED_METHOD(BNXT_RE_METHOD_GET_TOGGLE_MEM,
 					    UA_MANDATORY),
 			    UVERBS_ATTR_CONST_IN(BNXT_RE_TOGGLE_MEM_TYPE,
 						 enum bnxt_re_get_toggle_mem_type,
-						 UA_MANDATORY),
+						 UA_OPTIONAL),
 			    UVERBS_ATTR_PTR_IN(BNXT_RE_TOGGLE_MEM_RES_ID,
 					       UVERBS_ATTR_TYPE(u32),
-					       UA_MANDATORY),
+					       UA_OPTIONAL),
 			    UVERBS_ATTR_PTR_OUT(BNXT_RE_TOGGLE_MEM_MMAP_PAGE,
 						UVERBS_ATTR_TYPE(u64),
 						UA_MANDATORY),
@@ -316,7 +339,15 @@ DECLARE_UVERBS_NAMED_METHOD(BNXT_RE_METHOD_GET_TOGGLE_MEM,
 						UA_MANDATORY),
 			    UVERBS_ATTR_PTR_OUT(BNXT_RE_TOGGLE_MEM_MMAP_LENGTH,
 						UVERBS_ATTR_TYPE(u32),
-						UA_MANDATORY));
+						UA_MANDATORY),
+			    UVERBS_ATTR_IDR(BNXT_RE_TOGGLE_MEM_CQ_HANDLE,
+					    UVERBS_OBJECT_CQ,
+					    UVERBS_ACCESS_READ,
+					    UA_OPTIONAL),
+			    UVERBS_ATTR_IDR(BNXT_RE_TOGGLE_MEM_SRQ_HANDLE,
+					    UVERBS_OBJECT_SRQ,
+					    UVERBS_ACCESS_READ,
+					    UA_OPTIONAL));
 
 DECLARE_UVERBS_NAMED_METHOD_DESTROY(BNXT_RE_METHOD_RELEASE_TOGGLE_MEM,
 				    UVERBS_ATTR_IDR(BNXT_RE_RELEASE_TOGGLE_MEM_HANDLE,
diff --git a/include/uapi/rdma/bnxt_re-abi.h b/include/uapi/rdma/bnxt_re-abi.h
index a4599d7b736a..a6cfd68ed8f5 100644
--- a/include/uapi/rdma/bnxt_re-abi.h
+++ b/include/uapi/rdma/bnxt_re-abi.h
@@ -57,6 +57,7 @@ enum {
 	BNXT_RE_UCNTX_CMASK_POW2_DISABLED = 0x10ULL,
 	BNXT_RE_UCNTX_CMASK_MSN_TABLE_ENABLED = 0x40,
 	BNXT_RE_UCNTX_CMASK_QP_RATE_LIMIT_ENABLED = 0x80ULL,
+	BNXT_RE_UCNTX_CMASK_TOGGLE_MEM_UOBJ_SUPPORT = 0x400000ULL,
 };
 
 enum bnxt_re_wqe_mode {
@@ -68,6 +69,7 @@ enum bnxt_re_wqe_mode {
 enum {
 	BNXT_RE_COMP_MASK_REQ_UCNTX_POW2_SUPPORT = 0x01,
 	BNXT_RE_COMP_MASK_REQ_UCNTX_VAR_WQE_SUPPORT = 0x02,
+	BNXT_RE_COMP_MASK_REQ_UCNTX_TOGGLE_MEM_UOBJ_SUPPORT = 0x20,
 };
 
 struct bnxt_re_uctx_req {
@@ -218,6 +220,8 @@ enum bnxt_re_var_toggle_mem_attrs {
 	BNXT_RE_TOGGLE_MEM_MMAP_PAGE,
 	BNXT_RE_TOGGLE_MEM_MMAP_OFFSET,
 	BNXT_RE_TOGGLE_MEM_MMAP_LENGTH,
+	BNXT_RE_TOGGLE_MEM_CQ_HANDLE,
+	BNXT_RE_TOGGLE_MEM_SRQ_HANDLE,
 };
 
 enum bnxt_re_toggle_mem_attrs {
-- 
2.39.3


