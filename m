Return-Path: <linux-rdma+bounces-18459-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UE6LNQtVvWlr8gIAu9opvQ
	(envelope-from <linux-rdma+bounces-18459-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 15:09:15 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3562DB9A6
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 15:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F79831270BD
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 14:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F64C2620E5;
	Fri, 20 Mar 2026 14:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hyN23BAQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C5D2D595D
	for <linux-rdma@vger.kernel.org>; Fri, 20 Mar 2026 14:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774015448; cv=none; b=PXOmLGGdzdnVtD/kgSc7k+HGE/O+OI2AMQQkSkBoawXG/PXekyd+wyQGn9MwYBVzo0dDdp3ics0h8jDLDCXNL7ciZ9raSrvazXbEm9TYUuHFJnilcvM1KOtg8VELhdJUS9eS5mbZCmQF1TI1U8RLx6Q9DquEKQaj/+XLSLo8EGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774015448; c=relaxed/simple;
	bh=HWWDEw7PNa+1B3M5mvmrx+Xw8XcFVZGHPzqFNuqxS+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I4HrsHoQybGEB9t8klQj1HWmF8mDCFwAlo5TKrFGrLX+OWwp2w1z+wGCktwqvzGcIcPbQZkbYtQMm8huSGhwFY2Y84my1Im9Fh/4eB0uiLpDO7N6Aaocr4tANwAOXx+siN6akRQIsUnEyJtiXS8WOjMKmrpRxQ5EjQwXcTGSi2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hyN23BAQ; arc=none smtp.client-ip=209.85.216.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-35a094cc3e9so1278072a91.3
        for <linux-rdma@vger.kernel.org>; Fri, 20 Mar 2026 07:04:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774015445; x=1774620245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rhI0cyVd5caJEBOOsPLro3E96HXK9jKziJzSuBvPbnY=;
        b=oTaDTO7Dadb+vlNa9ZyJrBnMXAF67V9wQddTOzD0UmCN7YnrPurewWHwD15IHhgCW/
         gYGziK1l8CgtNt4hbp3vxzFL+zLraS2jbYLwMomCVakPFUAfFL03mTB5P4RZ2WD2ATK1
         IiOL0qzdvRsFDeEOaY2SpbLMy2qK2zYH257hWPihefsHTZgbRMEbl2mXAkO76QwzA3fv
         U6+FvbTGykRYLxD60ij7JtMvQKPfs5xNii8W3y+tk5L73x91uX2TmpVfi9Oq9BtiQaeM
         XgJBSq868ZikK2pWqCLh6JjWrfF4LQUkSqzbCUIKGV4+vkrixqb3NyB+jP1jkftABNWn
         j5LA==
X-Gm-Message-State: AOJu0YziufZ1S/FJz7z73dXs0tCdgpnP1zdn6E/fZ6muvVjVUW38uxFl
	ARmA5kZjABVfa0DvwfkppSoaeIA0eFWTytSitfPSznUxrl2m87uNYEMJ21B+BBdcR/vsLGfMmpr
	0zR2ul/SJG8bAMEPN8pbY59yYucSrEIOZxHD5cuwrdOlLP+0Fx90lQjnbSKDEBy/Jd0S7nOClu1
	QdrIgnAvPp8vw/OvYzsKsvAIUIl0FjHzLTA/2jskQxHNJcFzhHotGY7i9nUBzSNJf6vxN40BEUM
	AsjTEYM00UcFDRSy6ZVJLRJj5R2
X-Gm-Gg: ATEYQzxe28itnqp9ahpZS4rnQVguMquU+TMH8o8L5x7jkt2mMS+XAqOvA0MafSkSQqp
	cAqclXsUgC3UZCVoRV+B/ON+mzWSzItSvB3V8MxnkKVDI+WZ7ekQ1+0BzCLv8xCxB5IKUb3T+Iy
	aobTS42yXd9wzdy5PiFemAyuk9Kd8k3E+xrdnM9bzYHe7C13A3H9wx37VRLrcX3CTC0oqaHpVk7
	BZoKFdyCHVoIaaCwyr+oeUQ10GlylBw0mWOaxev0dZfxj9CTfsLTjctj+svGMl66e7j2nokF2Ll
	kQMGkDIJu3rzsnVvODJ2BK3yZPipMCjgkW83TIM3XQrg+fuXa8DD2XKYV7HIgHk8K9Ib7n5g+mP
	3oK6AjHYowa53S/ElMi4lWMQ152gvpepkou2GL/3T++cwqrdZsV9wSVKm0kuy3wrDgKxL/hfbST
	hq7YvSwnog/FwZV+Z/76sIIE0FxAcFNNCHyS/Vp38rb1ZDvTiC7/LIQoXVW6J5qfwxGVuQ
X-Received: by 2002:a17:90b:4fcf:b0:35b:aca5:db39 with SMTP id 98e67ed59e1d1-35bd2c19ea1mr2637268a91.9.1774015444276;
        Fri, 20 Mar 2026 07:04:04 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-20.dlp.protect.broadcom.com. [144.49.247.20])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-35bd3ee992csm229942a91.2.2026.03.20.07.04.03
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Mar 2026 07:04:04 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-82c2054b584so1074541b3a.2
        for <linux-rdma@vger.kernel.org>; Fri, 20 Mar 2026 07:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774015442; x=1774620242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rhI0cyVd5caJEBOOsPLro3E96HXK9jKziJzSuBvPbnY=;
        b=hyN23BAQXB2CUijWUzU4hmM7rduzOnjTdjou4eWCzrWQUBt2FL1JBayP181F4R281Y
         7tkEmNDM/IXWVUb1BEpvnyddYC8yRcHeFHA9uI2ZH/7yesh2eKx3pnnhmTSQxUFWlEd6
         ZqaXdssD0pyCyfsCslc1ANXvlqB6J74ZotOpE=
X-Received: by 2002:a05:6a00:14c1:b0:824:374a:1424 with SMTP id d2e1a72fcca58-82a8c36f5afmr2778249b3a.58.1774015441609;
        Fri, 20 Mar 2026 07:04:01 -0700 (PDT)
X-Received: by 2002:a05:6a00:14c1:b0:824:374a:1424 with SMTP id d2e1a72fcca58-82a8c36f5afmr2778184b3a.58.1774015440437;
        Fri, 20 Mar 2026 07:04:00 -0700 (PDT)
Received: from dhcp-10-123-157-187.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b040da3dfsm2136099b3a.45.2026.03.20.07.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 07:03:59 -0700 (PDT)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next 8/9] RDMA/bnxt_re: Enable app allocated QPs
Date: Fri, 20 Mar 2026 19:24:36 +0530
Message-ID: <20260320135437.48716-9-sriharsha.basavapatna@broadcom.com>
X-Mailer: git-send-email 2.51.2.636.ga99f379adf
In-Reply-To: <20260320135437.48716-1-sriharsha.basavapatna@broadcom.com>
References: <20260320135437.48716-1-sriharsha.basavapatna@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18459-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3E3562DB9A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The driver supports a new comp_mask: APP_ALLOCATED_QP_ENABLE.
The application sets this comp_mask bit in the CREATE_QP ureq
to indicate direct control of the QP. The driver goes through
the required processing for app allocated QPs. Only variable
WQE mode is supported for these QPs.

Signed-off-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 31 +++++++++++++++---------
 include/uapi/rdma/bnxt_re-abi.h          |  1 +
 2 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index deeb294e4742..ed597382e421 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1729,13 +1729,13 @@ static int bnxt_re_init_qp_attr(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
 				struct bnxt_re_qp_req *ureq,
 				struct ib_umem *sq_umem,
 				struct ib_umem *rq_umem,
-				struct bnxt_re_dbr_obj *dbr_obj)
+				struct bnxt_re_dbr_obj *dbr_obj,
+				bool app_qp)
 {
 	struct bnxt_qplib_dev_attr *dev_attr;
 	struct bnxt_qplib_qp *qplqp;
 	struct bnxt_re_dev *rdev;
 	struct bnxt_re_cq *cq;
-	bool app_qp = false;
 	int rc = 0, qptype;
 
 	rdev = qp->rdev;
@@ -1753,6 +1753,8 @@ static int bnxt_re_init_qp_attr(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
 		return qptype;
 	qplqp->type = (u8)qptype;
 	qplqp->wqe_mode = bnxt_re_is_var_size_supported(rdev, uctx);
+	if (app_qp && qplqp->wqe_mode != BNXT_QPLIB_WQE_MODE_VARIABLE)
+		return -EOPNOTSUPP;
 	qplqp->dev_cap_flags = dev_attr->dev_cap_flags;
 	qplqp->cctx = rdev->chip_ctx;
 	if (init_attr->qp_type == IB_QPT_RC) {
@@ -1944,6 +1946,7 @@ int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 	struct bnxt_re_pd *pd;
 	struct bnxt_re_qp *qp;
 	struct ib_pd *ib_pd;
+	bool app_qp = false;
 	u32 active_qps;
 	int rc;
 
@@ -1955,18 +1958,22 @@ int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 
 	uctx = rdma_udata_to_drv_context(udata, struct bnxt_re_ucontext, ib_uctx);
 	if (udata) {
-		rc = ib_copy_validate_udata_in_cm(udata, ureq, qp_handle, 0);
+		rc = ib_copy_validate_udata_in_cm(udata, ureq, qp_handle,
+						  BNXT_RE_QP_REQ_MASK_APP_ALLOCATED_QP_ENABLE);
 		if (rc)
 			return rc;
 
-		attrs = rdma_udata_to_uverbs_attr_bundle(udata);
-		if (uverbs_attr_is_valid(attrs,
-					 BNXT_RE_CREATE_QP_ATTR_DBR_HANDLE)) {
-			dbr_obj = uverbs_attr_get_obj(attrs,
-						      BNXT_RE_CREATE_QP_ATTR_DBR_HANDLE);
-			if (IS_ERR(dbr_obj))
-				return PTR_ERR(dbr_obj);
-			atomic_inc(&dbr_obj->usecnt);
+		if (ureq.comp_mask & BNXT_RE_QP_REQ_MASK_APP_ALLOCATED_QP_ENABLE) {
+			attrs = rdma_udata_to_uverbs_attr_bundle(udata);
+			if (uverbs_attr_is_valid(attrs,
+						 BNXT_RE_CREATE_QP_ATTR_DBR_HANDLE)) {
+				dbr_obj = uverbs_attr_get_obj(attrs,
+							      BNXT_RE_CREATE_QP_ATTR_DBR_HANDLE);
+				if (IS_ERR(dbr_obj))
+					return PTR_ERR(dbr_obj);
+				atomic_inc(&dbr_obj->usecnt);
+			}
+			app_qp = true;
 		}
 	}
 
@@ -1978,7 +1985,7 @@ int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 
 	qp->rdev = rdev;
 	rc = bnxt_re_init_qp_attr(qp, pd, qp_init_attr, uctx, &ureq,
-				  sq_umem, rq_umem, dbr_obj);
+				  sq_umem, rq_umem, dbr_obj, app_qp);
 	if (rc)
 		goto fail;
 
diff --git a/include/uapi/rdma/bnxt_re-abi.h b/include/uapi/rdma/bnxt_re-abi.h
index 4da8cda337dc..edb0329b700e 100644
--- a/include/uapi/rdma/bnxt_re-abi.h
+++ b/include/uapi/rdma/bnxt_re-abi.h
@@ -127,6 +127,7 @@ struct bnxt_re_resize_cq_req {
 
 enum bnxt_re_qp_mask {
 	BNXT_RE_QP_REQ_MASK_VAR_WQE_SQ_SLOTS = 0x1,
+	BNXT_RE_QP_REQ_MASK_APP_ALLOCATED_QP_ENABLE = 0x2,
 };
 
 struct bnxt_re_qp_req {
-- 
2.51.2.636.ga99f379adf


