Return-Path: <linux-rdma+bounces-23102-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id clGoAFGlVGr7ogMAu9opvQ
	(envelope-from <linux-rdma+bounces-23102-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 10:44:01 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA0E748DCB
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 10:44:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=LhOxxhai;
	dmarc=pass (policy=reject) header.from=broadcom.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23102-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23102-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D86963055C58
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 08:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67776399CEC;
	Mon, 13 Jul 2026 08:36:59 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31903B3898
	for <linux-rdma@vger.kernel.org>; Mon, 13 Jul 2026 08:36:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783931819; cv=none; b=QJ1AAFt3/0qZfiCUMKrftkBrP3KEFIzJHZrV9m5NbX/QYouXLdt7tDHWIiVHN8za8vPl1FdqZ2Rk4w5Wsd5fAeL2f5twc0w2F4ErEXVx0LebX9n5VQcNOniOL9XCVb27P0YwfeDNu+43lMYf04+RnPcUSosn474wr6pSY2/nwKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783931819; c=relaxed/simple;
	bh=v6Py6piCLbfjk3Yz1PDMFjs0/S0Nk54JNZXcdkQfEOc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lr+Sc7leytETcyD4SX65XHNHTDLJHQsd1dx10OQjYPOZJSQb5XO2R05NZcVmKGGKSC8soqZBZiq1QKqYHVG7ggRDboVPR+xyVm8Z/gk6gyKgtPyIGm7WnYOqsaLrRhym+GPwCCShSQQ55nMW4etDndxp/fiAtGfaAeo2gEwL6cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LhOxxhai; arc=none smtp.client-ip=209.85.216.98
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-38175907a56so2990096a91.0
        for <linux-rdma@vger.kernel.org>; Mon, 13 Jul 2026 01:36:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783931817; x=1784536617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U+gbVVFnkRkL5gRb9a5Pe4EqjjItfnauRx3Kz+IJN7s=;
        b=Z57RFhJqZd+3tgJLvXK9jzAPwP7w1uBP/Wokcmm5WJ022uhJVBm2ZD9TCYBFK9Cykr
         Yb55Wwak92k/ozlOgh52mHqfu9Y2M3pzDxT2akhafxEzoEL6BwiJO74pXejCb3Jg5yAY
         0MMeyoPXfIYkDOZAjEMMr2qosNjWAxHuBhSM+tDQOBBdsAnAU/+45qxQpLm1MsX+PHSz
         qqyk+FhycAcNli3gAd1HavX3r9/nfI7rh06ntsmPY87X4WzI+L4YXf98YpC0YC+m5h8p
         j4rpOJjeEefPedacN73QT01QCzcAjVfc+dsH+X3c3JVyo+iAnxrbTXMhen3WuzwPNBwK
         xOIg==
X-Gm-Message-State: AOJu0Yze8CGPhb5v0zZfLRj6LNcxHVkStARdNJL8Rdm++QCljSgL5Ckx
	4Vv/0qHpe8UhdI4yDAPKz4mBjGVbhrBdUU5BAvdM2OJnbsx9DRJrfsY3Uda1wAK87FaUbGD5QEo
	3PuKFE6hYQ079yWAp1NcpElPVOc6oqyb//CeFNdhWEByRjG6njIDLvTLv2q0uKaQcqcwQg8O28b
	AyXzPFyprq6zhDu48utTiRwLaT+310SqKOuavNQdxR3FTqbX0WVws9bbuEGzgvHTpkzFmrf6JFF
	+xuqk9F5wbL/pZVIg==
X-Gm-Gg: AfdE7clHrZOmUtuX0mIRxCEP8z8sqFfgOlL1La4hqldwgxn9EjOaIDLVvFiBjBunjuF
	Q1jH6f9FKVeWVQEnBJ6gQ2cqUgeyn0tHzNTKM9UITPGwIBwGMHk6V9X7RRI1soPBuyBKS5kzdRe
	tBU9gGM1eAjvWKj1DTkWjo3EyEdtEch33jOa0QOe9iGvVl2T8cM3+GwMa09edQzsmFJMuF1lRZs
	JBgdrcNbJ6CbMDnX7VtVgx4MBJ1uJ2JwxB7Ls4kR0RykDU/muTn1fyDIpMISBZCvMeBO7usTX5y
	pWbplMM16wJ2D/cS7YMt1KKtyXYvCTttez+G+lDWo8rKhAh7WOqsLvVYSbPTQzdnq/dTQc0TR8s
	pvzrFii2qYCSiGAbU6uDM4bxSlJNA8JKVizzMDaru7tPIBwAwGKAKoOjKjFf8qozFHAE2ol8dFq
	K2j5S8Ql2YOn7dd4SAAOYRerCdipuhpLAktfPN5UZZVeIKGyqLfQ==
X-Received: by 2002:a17:90b:3d86:b0:36a:caf2:3815 with SMTP id 98e67ed59e1d1-38d15876f4amr13797476a91.15.1783931816848;
        Mon, 13 Jul 2026 01:36:56 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-31174a86714sm1026585eec.27.2026.07.13.01.36.56
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jul 2026 01:36:56 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cce14a21faso50404515ad.0
        for <linux-rdma@vger.kernel.org>; Mon, 13 Jul 2026 01:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1783931815; x=1784536615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U+gbVVFnkRkL5gRb9a5Pe4EqjjItfnauRx3Kz+IJN7s=;
        b=LhOxxhai2u4KREzhWSAhEuZdiA7z5z2m0mHNJ8CQ+uQdQuuZ22R1KNwQjPDdTxl2Cv
         Kdy82Txgc18v1RwXeFSeVX4AWpS0bLay7+6KchpIzF0wl9ozf48UUrZ/p2kLnOaOwfPa
         We514cGw5Ra8PScfzuUXmtzIAfmJ57KkNPc6A=
X-Received: by 2002:a17:903:2b0d:b0:2ca:e496:5f19 with SMTP id d9443c01a7336-2cea18375e9mr71685495ad.19.1783931815173;
        Mon, 13 Jul 2026 01:36:55 -0700 (PDT)
X-Received: by 2002:a17:903:2b0d:b0:2ca:e496:5f19 with SMTP id d9443c01a7336-2cea18375e9mr71685305ad.19.1783931814636;
        Mon, 13 Jul 2026 01:36:54 -0700 (PDT)
Received: from dhcp-10-123-156-114.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3bbaesm95005385ad.57.2026.07.13.01.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 01:36:54 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	sriharsha.basavapatna@broadcom.com,
	alhouseenyousef@gmail.com,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH for-next v3 4/4] RDMA/bnxt_re: Add uverbs object handle path for CQ/SRQ toggle page
Date: Mon, 13 Jul 2026 06:58:30 -0700
Message-Id: <20260713135830.1934471-5-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260713135830.1934471-1-selvin.xavier@broadcom.com>
References: <20260713135830.1934471-1-selvin.xavier@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,broadcom.com,gmail.com,nvidia.com];
	TAGGED_FROM(0.00)[bounces-23102-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:jgg@ziepe.ca,m:linux-rdma@vger.kernel.org,m:andrew.gospodarek@broadcom.com,m:kalesh-anakkur.purayil@broadcom.com,m:sriharsha.basavapatna@broadcom.com,m:alhouseenyousef@gmail.com,m:selvin.xavier@broadcom.com,m:jgg@nvidia.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[selvin.xavier@broadcom.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[selvin.xavier@broadcom.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,nvidia.com:email];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6AA0E748DCB

The current GET_TOGGLE_MEM ioctl requires the caller to supply
a type enum and a raw hardware queue ID (RES_ID). The kernel
looks up the CQ or SRQ by that ID without verifying that the
caller owns the resource.

Add a new, preferred code path that accepts standard uverbs
object handles (BNXT_RE_TOGGLE_MEM_CQ_HANDLE /
BNXT_RE_TOGGLE_MEM_SRQ_HANDLE) instead. The uverbs core validates
that the handle belongs to the calling context as part of resolving
it, so this path no longer needs the driver's own XArray lookup for
ownership checking. As with the legacy path, the toggle_entry's own
mmap-entry refcount (not a CQ/SRQ uobject reference) is what pins
the toggle page for the life of the GET_TOGGLE_MEM handle.

Only newer rdma-core versions support this path, if the
driver reports the supported resp mask
(BNXT_RE_UCNTX_CMASK_TOGGLE_MEM_UOBJ_SUPPORT).
The existing TYPE + RES_ID path is retained for backward
compatibility with older rdma-core.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c |  2 +
 drivers/infiniband/hw/bnxt_re/uapi.c     | 55 +++++++++++++++++++++---
 include/uapi/rdma/bnxt_re-abi.h          |  4 ++
 3 files changed, 56 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 9ee2cd0fcda8..a65f0c9ee6d7 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -4862,6 +4862,8 @@ int bnxt_re_alloc_ucontext(struct ib_ucontext *ctx, struct ib_udata *udata)
 	if (_is_modify_qp_rate_limit_supported(dev_attr->dev_cap_flags2))
 		resp.comp_mask |= BNXT_RE_UCNTX_CMASK_QP_RATE_LIMIT_ENABLED;
 
+	resp.comp_mask |= BNXT_RE_UCNTX_CMASK_TOGGLE_MEM_UOBJ_SUPPORT;
+
 	if (udata->inlen) {
 		rc = ib_copy_validate_udata_in_cm(
 			udata, ureq, comp_mask,
diff --git a/drivers/infiniband/hw/bnxt_re/uapi.c b/drivers/infiniband/hw/bnxt_re/uapi.c
index c13497b187b5..c740059ff1ed 100644
--- a/drivers/infiniband/hw/bnxt_re/uapi.c
+++ b/drivers/infiniband/hw/bnxt_re/uapi.c
@@ -237,16 +237,52 @@ static int UVERBS_HANDLER(BNXT_RE_METHOD_GET_TOGGLE_MEM)(struct uverbs_attr_bund
 	if (IS_ERR(ib_uctx))
 		return PTR_ERR(ib_uctx);
 
+	uctx = container_of(ib_uctx, struct bnxt_re_ucontext, ib_uctx);
+
+	/* New path: updated libbnxt_re passes the CQ or SRQ uverbs handle */
+	if (uverbs_attr_is_valid(attrs, BNXT_RE_TOGGLE_MEM_CQ_HANDLE)) {
+		struct bnxt_re_cq *cq;
+
+		res_uobj = uverbs_attr_get_uobject(attrs,
+						   BNXT_RE_TOGGLE_MEM_CQ_HANDLE);
+		if (IS_ERR(res_uobj))
+			return PTR_ERR(res_uobj);
+		cq = container_of(res_uobj->object, struct bnxt_re_cq, ib_cq);
+		if (!cq->toggle_entry)
+			return -EOPNOTSUPP;
+		mmap_offset = rdma_user_mmap_get_offset(&cq->toggle_entry->rdma_entry);
+		if (!mmap_offset)
+			return -EOPNOTSUPP;
+		kref_get(&cq->toggle_entry->rdma_entry.ref);
+		toggle_entry = cq->toggle_entry;
+		goto alloc_tmem;
+	} else if (uverbs_attr_is_valid(attrs, BNXT_RE_TOGGLE_MEM_SRQ_HANDLE)) {
+		struct bnxt_re_srq *srq;
+
+		res_uobj = uverbs_attr_get_uobject(attrs,
+						   BNXT_RE_TOGGLE_MEM_SRQ_HANDLE);
+		if (IS_ERR(res_uobj))
+			return PTR_ERR(res_uobj);
+		srq = container_of(res_uobj->object, struct bnxt_re_srq, ib_srq);
+		if (!srq->toggle_entry)
+			return -EOPNOTSUPP;
+		mmap_offset = rdma_user_mmap_get_offset(&srq->toggle_entry->rdma_entry);
+		if (!mmap_offset)
+			return -EOPNOTSUPP;
+		kref_get(&srq->toggle_entry->rdma_entry.ref);
+		toggle_entry = srq->toggle_entry;
+		goto alloc_tmem;
+	}
+
 	err = uverbs_get_const(&res_type, attrs, BNXT_RE_TOGGLE_MEM_TYPE);
 	if (err)
 		return err;
-
-	uctx = container_of(ib_uctx, struct bnxt_re_ucontext, ib_uctx);
 	err = uverbs_copy_from(&res_id, attrs, BNXT_RE_TOGGLE_MEM_RES_ID);
 	if (err)
 		return err;
 
 	/*
+	 * Legacy path: old libbnxt_re sends TYPE + RES_ID.
 	 * Hold xa_lock across xa_load + kref_get so that a concurrent
 	 * bnxt_re_destroy_cq/srq cannot call __xa_erase and remove the
 	 * toggle_entry between our load and our reference on it.
@@ -290,6 +326,7 @@ static int UVERBS_HANDLER(BNXT_RE_METHOD_GET_TOGGLE_MEM)(struct uverbs_attr_bund
 	if (!mmap_offset)
 		return -EOPNOTSUPP;
 
+alloc_tmem:
 	tmem = kzalloc_obj(*tmem);
 	if (!tmem) {
 		rdma_user_mmap_entry_put(&toggle_entry->rdma_entry);
@@ -336,10 +373,10 @@ DECLARE_UVERBS_NAMED_METHOD(BNXT_RE_METHOD_GET_TOGGLE_MEM,
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
@@ -348,7 +385,15 @@ DECLARE_UVERBS_NAMED_METHOD(BNXT_RE_METHOD_GET_TOGGLE_MEM,
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
index a4599d7b736a..c0ee9ce389ac 100644
--- a/include/uapi/rdma/bnxt_re-abi.h
+++ b/include/uapi/rdma/bnxt_re-abi.h
@@ -57,6 +57,8 @@ enum {
 	BNXT_RE_UCNTX_CMASK_POW2_DISABLED = 0x10ULL,
 	BNXT_RE_UCNTX_CMASK_MSN_TABLE_ENABLED = 0x40,
 	BNXT_RE_UCNTX_CMASK_QP_RATE_LIMIT_ENABLED = 0x80ULL,
+	 /* Some reserved fields to manage compatibility with Out of tree drivers */
+	BNXT_RE_UCNTX_CMASK_TOGGLE_MEM_UOBJ_SUPPORT = 0x400000ULL,
 };
 
 enum bnxt_re_wqe_mode {
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


