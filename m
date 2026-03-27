Return-Path: <linux-rdma+bounces-18735-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0M8yAGlPxmk2IgUAu9opvQ
	(envelope-from <linux-rdma+bounces-18735-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Mar 2026 10:35:37 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB1B341CB9
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Mar 2026 10:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2B4C30E2650
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Mar 2026 09:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F543CE497;
	Fri, 27 Mar 2026 09:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="E7GLHXhh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f97.google.com (mail-qv1-f97.google.com [209.85.219.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C393B95F6
	for <linux-rdma@vger.kernel.org>; Fri, 27 Mar 2026 09:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774603644; cv=none; b=f/y6FXLXN7I+w7xQ7iYeOpdQ4Zh2OINJX/ph2LEitetBqdfOhFOAiJkAnEpe7W7ZY/mCNy6Ye8TM/EoE+FoKhfBI0hBoZmyQzoU9MkbAwHDI5UdIObrhImmuhzQqc6GrpQaALFdchg3R+rYRQ5GXlBdpvdg6HND55qFYNdR70Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774603644; c=relaxed/simple;
	bh=mh5loXWp2QEfDD4pBB4JWdP5PO4n9SCk/L51J5XFCoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kWySHsIUhcd+FCgcOpF/YSo9sNrjYX6wX/07/ZleBnuNvEIXNtzV7o/iXV552W1nC1QM0MY4gRHOmAqMoI7Y4Xy74pYXsHSaVzAhbiyhJ35bUVc5msluCutXHca47mU9rKiAZEC/Vw9X4QbmM7KK8MYDUgArMb4sIqh4PZVi908=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=E7GLHXhh; arc=none smtp.client-ip=209.85.219.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f97.google.com with SMTP id 6a1803df08f44-899ee87355dso22781536d6.1
        for <linux-rdma@vger.kernel.org>; Fri, 27 Mar 2026 02:27:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774603642; x=1775208442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6DyloPNV6Q6gEpsC+gbGWzxReXyS0dfoXv78nv6KToY=;
        b=FkgsMxv48D7mWjrCMsyBxMXkuAefZdJkTIGAi/GgTiP1M0WPTDeuoyjD0wcb8Tz2tA
         oYXQnYXKFnxfuP4S565BtkjWFuEsJ4xrEbnjuyA1lUnddocpclyd3y0304u+yN8fYHaC
         Lm2DW1XwsilUutVmOiW266gwbNZAtlfpXUbzOoD4pDrsbr/qoijQ9VW2JVHJecg74/r4
         p1tFERdieJVxKC7IKVqtZj1vDSrRjAde7tRQHGY6tMu349X7JVg9Wez3XiKiQ9kG9BUo
         w6YfVziGL1/GqyIvWtFGBkXEhoWq5S9ctbOlfKExzb9d2Txg2+XH9xcZz1/trqOmOqB3
         Ohyg==
X-Gm-Message-State: AOJu0YzGgMhb/dxM1pBhf0sXuLrybLkmaf4+RiZjETYX4nWmPVSg0zK4
	BWxOOZEzvXrlwracrviYEQ0CPBs7dJ2SiR8oLiYMMgal/v+NtBAZlWPc0Z6Iol/l8UqWxlBfGo3
	ttK/FLuFP+L54csrzOyuHHZHv+yk9CzWYL0OQdFXqIeIudaEH9BIOIyyh0QOReiW+G0F9BcT0jZ
	tvHn0a3Bts3aB08f6O+d/F7UIKwShz63Fz2XuOXxswoS3bYs3eiMGmIcLKjzNqYPcfMbSDNMFwE
	rLyE563nJOaaKuypSpokEfhhEhJ
X-Gm-Gg: ATEYQzwLKFKr12tsXowOPh0lAE1Q/opqPiHIkAlLIdxz7/AFAZuUXJsYq43ozUXZa9i
	fSK6omUlAAY4VOfSfmm2Y1/PAgHjDyQHXqXRXg9GJ9MpehxsNneqMWhp77zN4MaYK6IA8i/DKcl
	DvXiBNVhDQe18wdShm0CegAoP0ByWy2LXHBjrtBVC2NgRd/e9+e4JY80Syinq1ujFGTszb0lzuT
	nhN0hf3zjfm7pn3LSHH2S5BRWKqTsxbrgD4gcOMQlywyr3vhEqeNbayBUeMaxlZr7fNJP14Ux4a
	7dZKczrfEjq9/dCSmvB8/cVUTzFwWqUZDGJa7W8BIiQGo8+nJW9qLLxOQVd7rpzIkRIf+2YeC2c
	dZGySmK84g6FN3oJ0hmUVJK59BxnJHEKljeSl/zRpomGDNvd0aNcFE+GZMz77Nm/yp3f6evQwhL
	lzwM+nDwA4YDihzLFu5AwcmqdBWIsWyMff8tMNqJjTzUe3pec5yBVEmbaEz6QTHjOyAO4d
X-Received: by 2002:a05:6214:2b9b:b0:89a:62c4:5dd6 with SMTP id 6a1803df08f44-89ce8d6fff3mr19041626d6.22.1774603641719;
        Fri, 27 Mar 2026 02:27:21 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-89cd59f4deesm6078916d6.25.2026.03.27.02.27.21
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Mar 2026 02:27:21 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-79a670a6032so41359957b3.0
        for <linux-rdma@vger.kernel.org>; Fri, 27 Mar 2026 02:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774603641; x=1775208441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6DyloPNV6Q6gEpsC+gbGWzxReXyS0dfoXv78nv6KToY=;
        b=E7GLHXhh9ohF+nDR5Dh1jbEZuaOGyreCJ5IlnQJ5OYOkQV0jumU9j8Dhi7IBD19e9D
         9iCtUz1MP9ytW0Lt4l50T/al0ayX3q8G3hvURVuI0SWneLl7MxG+3PukrL3k3ACy7c7O
         apW4em2s8GX2DfenstOsgdouAefjClyuUXs/g=
X-Received: by 2002:a05:690c:6e86:b0:79a:b9a5:9e7c with SMTP id 00721157ae682-79bde081e42mr14571577b3.48.1774603640912;
        Fri, 27 Mar 2026 02:27:20 -0700 (PDT)
X-Received: by 2002:a05:690c:6e86:b0:79a:b9a5:9e7c with SMTP id 00721157ae682-79bde081e42mr14571397b3.48.1774603640476;
        Fri, 27 Mar 2026 02:27:20 -0700 (PDT)
Received: from dhcp-10-123-157-187.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79b17e4a0absm25718307b3.22.2026.03.27.02.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 02:27:20 -0700 (PDT)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v2 8/8] RDMA/bnxt_re: Enable app allocated QPs
Date: Fri, 27 Mar 2026 14:47:55 +0530
Message-ID: <20260327091755.47754-9-sriharsha.basavapatna@broadcom.com>
X-Mailer: git-send-email 2.51.2.636.ga99f379adf
In-Reply-To: <20260327091755.47754-1-sriharsha.basavapatna@broadcom.com>
References: <20260327091755.47754-1-sriharsha.basavapatna@broadcom.com>
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
	TAGGED_FROM(0.00)[bounces-18735-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:dkim,broadcom.com:email,broadcom.com:mid];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7AB1B341CB9
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
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 33 ++++++++++++++----------
 include/uapi/rdma/bnxt_re-abi.h          |  1 +
 2 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 7084f49ec28f..35e19157b061 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1710,13 +1710,13 @@ static int bnxt_re_init_qp_attr(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
 				struct ib_qp_init_attr *init_attr,
 				struct bnxt_re_ucontext *uctx,
 				struct bnxt_re_qp_req *ureq,
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
@@ -1734,6 +1734,8 @@ static int bnxt_re_init_qp_attr(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
 		return qptype;
 	qplqp->type = (u8)qptype;
 	qplqp->wqe_mode = bnxt_re_is_var_size_supported(rdev, uctx);
+	if (app_qp && qplqp->wqe_mode != BNXT_QPLIB_WQE_MODE_VARIABLE)
+		return -EOPNOTSUPP;
 	qplqp->dev_cap_flags = dev_attr->dev_cap_flags;
 	qplqp->cctx = rdev->chip_ctx;
 	if (init_attr->qp_type == IB_QPT_RC) {
@@ -1920,6 +1922,7 @@ int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 	struct bnxt_re_pd *pd;
 	struct bnxt_re_qp *qp;
 	struct ib_pd *ib_pd;
+	bool app_qp = false;
 	u32 active_qps;
 	int rc;
 
@@ -1931,19 +1934,23 @@ int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 
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
-			qp->dbr_obj = dbr_obj;
+		if (ureq.comp_mask & BNXT_RE_QP_REQ_MASK_APP_ALLOCATED_QP_ENABLE) {
+			attrs = rdma_udata_to_uverbs_attr_bundle(udata);
+			if (uverbs_attr_is_valid(attrs,
+						 BNXT_RE_CREATE_QP_ATTR_DBR_HANDLE)) {
+				dbr_obj = uverbs_attr_get_obj(attrs,
+							      BNXT_RE_CREATE_QP_ATTR_DBR_HANDLE);
+				if (IS_ERR(dbr_obj))
+					return PTR_ERR(dbr_obj);
+				atomic_inc(&dbr_obj->usecnt);
+				qp->dbr_obj = dbr_obj;
+			}
+			app_qp = true;
 		}
 	}
 
@@ -1955,7 +1962,7 @@ int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 
 	qp->rdev = rdev;
 	rc = bnxt_re_init_qp_attr(qp, pd, qp_init_attr, uctx, &ureq,
-				  dbr_obj);
+				  dbr_obj, app_qp);
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


