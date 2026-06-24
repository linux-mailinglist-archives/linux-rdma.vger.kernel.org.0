Return-Path: <linux-rdma+bounces-22452-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id q+09BBwRPGrNjQgAu9opvQ
	(envelope-from <linux-rdma+bounces-22452-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jun 2026 19:17:16 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 717AD6C049E
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jun 2026 19:17:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=VdYv9vj0;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22452-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22452-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 629C23028E88
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jun 2026 17:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5022340403;
	Wed, 24 Jun 2026 17:17:11 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9512F7EE8
	for <linux-rdma@vger.kernel.org>; Wed, 24 Jun 2026 17:17:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782321431; cv=none; b=X0JMZUP4WlQiNYHg3sZQjAn/0uyp3fptgcqKk2FeVT09My9h5xFawtRDr5WrgH+v+844GfNWVBOz5d2Xn8Uf6M2ONnjzIMW9CDCCPW5Reoy/d5Oy/em6nv8N93ccl6WAsJuNjQnq4waSExIKp0DC3N+nGstKcpUVo5iziGJrQdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782321431; c=relaxed/simple;
	bh=LYwD8YrVpFcpAzR7gGL+c4jqj1wm6gISgQUwmZ1yqGs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BT6nkTFyxmuWX59HTeGMmn2HTpRnihO3Ky7cnSGe53U21tCqR3tcej2Bk0QZ3yqTargJnrfJ32ooSwxXEYyden5yegrduO6jNkQCYNjrZz5OMV6dBvXuYUQOt8d2dDZ1lfR1xQqS1tZY7PXYp/omJV0/U3mjNaLHeW3Gekbeznk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VdYv9vj0; arc=none smtp.client-ip=209.85.216.100
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-37df416c45cso85057a91.2
        for <linux-rdma@vger.kernel.org>; Wed, 24 Jun 2026 10:17:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782321429; x=1782926229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t/roxUsbh60Eaj0AvP4E/1iDBEB1sH8LxmGM1NIg3d0=;
        b=RZ5amDayDHnfV4BDIGk7xJEUHPTXeahalIYot1xf+eExbWdxIjTXlQC1/v/kkuESBt
         XPWveslXjsRK/wsici5ShPEj6xZPDDqfE6mdEpPDRYDjUYDmvsT/7OPCMY9IK5OvcaNx
         Yf5FgStM//lZCSetXd0d8VczpOaBbPrPhubMOe40h+AD5av5I7IGqGZMUsXhvxnCW0yF
         BZDsmOpOxgOmaBQdJ0PtEyWuZDRoxoN87M1Eshy6dmuJZpiqEfSCxovgVP2wyccVLQBZ
         jsCDhCed0sUt5Wz6QoZNT+beBSJn4Jel4xcwdyF5HYzTsc3BHO+Mssk4WUmpDM3askty
         Gi5Q==
X-Gm-Message-State: AOJu0Yx8TFQX5VYBXl8/olAsCvcKCgX7ITOPWcftkHG47q1a3vRLin8a
	c0fRAH/fHPtccgByEc+Lxt+jbg+X7wfyvLM1d9XwVAngK0U6EZOI6yQjL4yvOAQVAHACeYZKByU
	nspI4mUCAQisfQuP6a6zKEj/XwCiTHZIWnnUKsDPOwx+nHM+ZU4VOisUk7Wu7fdFzw5dUXPNV57
	mgAfjG77rU1l/39v1eXWWwKofyfFIWTbv3mNRUU5yQm+XnVp69nueQ+9Lr7Rwh4/LCYztaq/REa
	6PC9ZRFnCmvOQY6CM+1
X-Gm-Gg: AfdE7cko6NUeUeYVAnQHqwAIaCN2fWZMBxC87FfS0nFw2kn6JGGA4Q7neKXRTOstsUd
	OZxKQ7BhUE3AS3GxhZYlMB+1XiFLsgBSgWxdWai7Io/nq8OY+m4zNru2dYqRtNX2dfn2J/S9UZz
	qM1jNa8YUonwZlfPmve3HX4BI6ziS8uJE6vnxsatM8Aqqs9PsSzzazWOKufisfAtEjHVtc7Lg+6
	8fbOxNtpdn8GsMQMOa3RCZ58oXtIc38BGuzPhMjxpo6SXbU4fHHpDdhNvHOF60q8raqPSbvn2w0
	bEz9nsBvTY2iA0l9Qc5E0GKop1GR78yIX1+0PjzXDfiPssypA83HgpONiDApSVrcVLIeMhYI7yY
	9lSRicPCPtnUKwZtmpxcCVUnHvPRhAUGlbMv+AiZKaAM0O6G60BBaGuvPSlr1WUyZil4x4V8/x6
	128q9kmQ4FqZqZAwWrD8V+qcTaZDzoCTmr9uAT6gUa4GwSL3ahsw==
X-Received: by 2002:a17:902:ec90:b0:2c6:b40a:d0c7 with SMTP id d9443c01a7336-2c7e14148c1mr42261055ad.7.1782321429171;
        Wed, 24 Jun 2026 10:17:09 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2c7f588d260sm294735ad.0.2026.06.24.10.17.08
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jun 2026 10:17:09 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2c76be5dd09so8806755ad.3
        for <linux-rdma@vger.kernel.org>; Wed, 24 Jun 2026 10:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1782321427; x=1782926227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t/roxUsbh60Eaj0AvP4E/1iDBEB1sH8LxmGM1NIg3d0=;
        b=VdYv9vj0IsB+jdsnGnqjd01WEPOapMtTn0QKB8EswPDUloEQfdqg0S5Go+DyBzI7/l
         GtnwwaQK/LPTv49NP+bizaC0ix4K1Q743qNknfzn2aHwcWjINlI4bHxmAbAJWYKSUKES
         nJ2+cK7jX6k4lQ0vwghVz+Q73EJbgpkis4yDI=
X-Received: by 2002:a17:903:988:b0:2c2:bd0d:3cf0 with SMTP id d9443c01a7336-2c7e157f332mr43460845ad.25.1782321427445;
        Wed, 24 Jun 2026 10:17:07 -0700 (PDT)
X-Received: by 2002:a17:903:988:b0:2c2:bd0d:3cf0 with SMTP id d9443c01a7336-2c7e157f332mr43460385ad.25.1782321426754;
        Wed, 24 Jun 2026 10:17:06 -0700 (PDT)
Received: from dhcp-10-123-156-114.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7f5afbbd9sm3004965ad.28.2026.06.24.10.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 10:17:06 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	sriharsha.basavapatna@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH for-next v2 2/2] RDMA/bnxt_re: Add uverbs object handle path for CQ/SRQ toggle page
Date: Wed, 24 Jun 2026 15:39:27 -0700
Message-Id: <20260624223927.521882-3-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260624223927.521882-1-selvin.xavier@broadcom.com>
References: <20260624223927.521882-1-selvin.xavier@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-22452-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 717AD6C049E

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
 drivers/infiniband/hw/bnxt_re/uapi.c     | 99 +++++++++++++++---------
 include/uapi/rdma/bnxt_re-abi.h          |  4 +
 4 files changed, 74 insertions(+), 37 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index d1eebd7b56f4..423c8f3184bb 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -4846,7 +4846,8 @@ int bnxt_re_alloc_ucontext(struct ib_ucontext *ctx, struct ib_udata *udata)
 		rc = ib_copy_validate_udata_in_cm(
 			udata, ureq, comp_mask,
 			BNXT_RE_COMP_MASK_REQ_UCNTX_POW2_SUPPORT |
-				BNXT_RE_COMP_MASK_REQ_UCNTX_VAR_WQE_SUPPORT);
+				BNXT_RE_COMP_MASK_REQ_UCNTX_VAR_WQE_SUPPORT |
+				BNXT_RE_COMP_MASK_REQ_UCNTX_TOGGLE_MEM_UOBJ_SUPPORT);
 		if (rc)
 			goto cfail;
 		if (ureq.comp_mask & BNXT_RE_COMP_MASK_REQ_UCNTX_POW2_SUPPORT) {
@@ -4859,6 +4860,10 @@ int bnxt_re_alloc_ucontext(struct ib_ucontext *ctx, struct ib_udata *udata)
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
index 7e2acd0933f7..45dcaa49d6a8 100644
--- a/drivers/infiniband/hw/bnxt_re/uapi.c
+++ b/drivers/infiniband/hw/bnxt_re/uapi.c
@@ -216,57 +216,76 @@ static int UVERBS_HANDLER(BNXT_RE_METHOD_GET_TOGGLE_MEM)(struct uverbs_attr_bund
 {
 	struct ib_uobject *uobj = uverbs_attr_get_uobject(attrs, BNXT_RE_TOGGLE_MEM_HANDLE);
 	enum bnxt_re_mmap_flag mmap_flag = BNXT_RE_MMAP_TOGGLE_PAGE;
-	enum bnxt_re_get_toggle_mem_type res_type;
 	struct bnxt_re_user_mmap_entry *entry;
 	struct bnxt_re_ucontext *uctx;
 	struct ib_ucontext *ib_uctx;
+	struct ib_uobject *res_uobj;
 	u32 length = PAGE_SIZE;
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
-
-	switch (res_type) {
-	case BNXT_RE_CQ_TOGGLE_MEM:
-		struct bnxt_re_cq *cq;
+	res_uobj = uverbs_attr_get_uobject(attrs, BNXT_RE_TOGGLE_MEM_CQ_HANDLE);
+	if (!IS_ERR(res_uobj)) {
+		struct bnxt_re_cq *cq =
+			container_of((struct ib_cq *)res_uobj->object,
+				     struct bnxt_re_cq, ib_cq);
+
+		addr = (u64)cq->uctx_cq_page;
+	} else {
+		res_uobj = uverbs_attr_get_uobject(attrs, BNXT_RE_TOGGLE_MEM_SRQ_HANDLE);
+		if (!IS_ERR(res_uobj)) {
+			struct bnxt_re_srq *srq =
+				container_of((struct ib_srq *)res_uobj->object,
+					     struct bnxt_re_srq, ib_srq);
 
-		xa_lock(&uctx->cq_xa);
-		cq = xa_load(&uctx->cq_xa, res_id);
-		if (cq)
-			addr = (u64)cq->uctx_cq_page;
-		xa_unlock(&uctx->cq_xa);
-		if (!addr)
-			return -EINVAL;
-		break;
-	case BNXT_RE_SRQ_TOGGLE_MEM:
-		struct bnxt_re_srq *srq;
-
-		xa_lock(&uctx->srq_xa);
-		srq = xa_load(&uctx->srq_xa, res_id);
-		if (srq)
 			addr = (u64)srq->uctx_srq_page;
-		xa_unlock(&uctx->srq_xa);
-		if (!addr)
-			return -EINVAL;
-		break;
-	default:
-		return -EOPNOTSUPP;
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
+				struct bnxt_re_cq *cq;
+
+				xa_lock(&uctx->cq_xa);
+				cq = xa_load(&uctx->cq_xa, res_id);
+				if (cq)
+					addr = (u64)cq->uctx_cq_page;
+				xa_unlock(&uctx->cq_xa);
+			} else if (res_type == BNXT_RE_SRQ_TOGGLE_MEM) {
+				struct bnxt_re_srq *srq;
+
+				xa_lock(&uctx->srq_xa);
+				srq = xa_load(&uctx->srq_xa, res_id);
+				if (srq)
+					addr = (u64)srq->uctx_srq_page;
+				xa_unlock(&uctx->srq_xa);
+			}
+		}
 	}
 
+	if (!addr)
+		return -EOPNOTSUPP;
+
 	entry = bnxt_re_mmap_entry_insert(uctx, addr, mmap_flag, &mem_offset);
 	if (!entry)
 		return -ENOMEM;
@@ -308,10 +327,10 @@ DECLARE_UVERBS_NAMED_METHOD(BNXT_RE_METHOD_GET_TOGGLE_MEM,
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
@@ -320,7 +339,15 @@ DECLARE_UVERBS_NAMED_METHOD(BNXT_RE_METHOD_GET_TOGGLE_MEM,
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


