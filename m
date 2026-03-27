Return-Path: <linux-rdma+bounces-18734-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GC9xCwpOxmmgIAUAu9opvQ
	(envelope-from <linux-rdma+bounces-18734-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Mar 2026 10:29:46 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0AD341B93
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Mar 2026 10:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 560633041872
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Mar 2026 09:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543903CE497;
	Fri, 27 Mar 2026 09:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LzfXMOYq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE923932DD
	for <linux-rdma@vger.kernel.org>; Fri, 27 Mar 2026 09:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774603641; cv=none; b=TaASUP8/KhoDJqLvPyTQnDZ248GyAy5QiE4BrKTrbLcJfg/MHTtfJAjAQLQEBo9bBxjkhabCVNB8CkPFDNoD4U4+KPYNDiVsQXeMoEQexU3A4IrJSbqacK1tmdwVlGjC18KYTmA9tTnGZrc5hcD8hvYezbUaDAGHKvNC060LNfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774603641; c=relaxed/simple;
	bh=Ux5Pyw1+KJ0m+FCByoD6Bv0GChwU0VvfvA5PdE2PoTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ie7nSgxcFNBIozt8egpcHVgO0R3TCRpi6mQ+l7bukHEb/L1C3j3ZzhTuT4uWZeviZbFmWms0hx0eOlzQP6zF3E2WxGPfBCOhDvYDmxWkY//mxS2sHp796KDkWKG0WVJLrGe1x02WyUik8FbBshqNiMc1H6uYfZvkO5O6GCqoBL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LzfXMOYq; arc=none smtp.client-ip=209.85.216.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-35c1107d4b7so1584455a91.1
        for <linux-rdma@vger.kernel.org>; Fri, 27 Mar 2026 02:27:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774603639; x=1775208439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4U4jVQoyP2SDC5EUG7JKnH3c5ERch888f7xtDdotHNw=;
        b=dplxiQg6FrmDBSEaU3HZVGYzjJUYZC0tenrLYq5hBpNUwRKRSk8Uqf9LRnRaA2jgEz
         uYNmpFopAha3RH3XaFpUNE03wFavnBhrY5h7tH739VmxqyRgJEOLNrGVpGTCjud5iTsF
         Cb+SvihUKdevNHSb791pXgztbUMriLLd5nJFadJsnZbsmskPMBuVSt8g6+ljY+Ujd7eI
         dzjOPiFDHMItE3I1d3PdfUfXCciQOfpi/ACdPqBKPuITdadI/qZit2rlo05ZyTO1WlPE
         x1YcOIwh5Zu7Bhn/lmTm8s/y88xfOqNZvwl6DabXQEcZmiauzElcg2subhM9Op97wh8U
         pwTA==
X-Gm-Message-State: AOJu0YyU8Ew3qBQUEzWuvNgL/ZScA2n432ktkrMHJaxeEj3po2CRfQHY
	BCzNmkZwTOJsmRISDEeRutQNEHEbFFXleWAZMs2cEPff6YIIt0KJtgIM8ZM5YyejkzqYgdvzHUt
	R4f8IIArimlz5PLevPmYy4EZorj9TDvoDqLe24hwAK+GNB1d3nNffA5Yv3AiODwKdlkvG6wm7Y7
	+n3o9ML57AYYBmbowJg1thVKNtUWOczjAaHysNEP1RY2vcqVo7MC9xrJSXoexPGEkWI7kVjREj6
	V1Yn/qP6/2ErtRsHwb1HLWagwkv
X-Gm-Gg: ATEYQzwFwKuQYe3LLt2Mih2kX3RdEVFiLnDOWOjbQke2t4RaLwSarQIXCt2Lneg0cLV
	Qp2Q9tftQirFw4Z223r7QD43uKaKP5EqTcoq2wGCoVCUuokBbtJsIuqWiyq9ax18eBYxkmHo54o
	WOre/uzgmK63MbkbDwebRG4SynzfjPUxduAxQr5GGJ6kkvNo9xGwefUSPHXw4vglzPCOly5per3
	h2JRe+T414D2jAAJWeBcNgvllgF8W+PTMi8L0sLg6LcmCLhFjldmMD2OqpDdAVrmi7xKlAOKPu+
	beSf+Bkpdjq3gJAYszurCEL1d4nXEuYxwUkUXzfRj/hMxDHLte0zwShgyAh9KhOGXgEReL787kJ
	7FwmzmUCs1R31e1hBRM1YWRUXUOjjerYzf7/j9cN+LmTLvr7I0rcyokqEk8lvtIazKHvXcjNq00
	NC5HHI5rM257AsJPUOU+1Iim646RyQgZnZFYXB520eepwT325jO68ohX6OEFCGM17tIFkP
X-Received: by 2002:a17:90b:1850:b0:35b:e770:2341 with SMTP id 98e67ed59e1d1-35c2ff6190emr2095756a91.9.1774603639040;
        Fri, 27 Mar 2026 02:27:19 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-35c22b9f47esm519093a91.5.2026.03.27.02.27.18
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Mar 2026 02:27:19 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-798080635ceso30989527b3.3
        for <linux-rdma@vger.kernel.org>; Fri, 27 Mar 2026 02:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774603637; x=1775208437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4U4jVQoyP2SDC5EUG7JKnH3c5ERch888f7xtDdotHNw=;
        b=LzfXMOYqYbVokHzYbW+oGCew3/BrHPxC5igcydGJ8AOVxigdl0QEJRa9MCFMPmPXt9
         b6t5XQW0Pst4S7VTVuvGRZ/ysm+bL/EhrJMzTceAUbpT3tmrMvJPLJz+3Bgun+HsN4JW
         72cTjaJ42aLQBOK+NHRbEJBS0iLyaRHpRZUCk=
X-Received: by 2002:a05:690c:6e85:b0:79b:e4e5:c954 with SMTP id 00721157ae682-79be4e5cc87mr3939017b3.23.1774603637478;
        Fri, 27 Mar 2026 02:27:17 -0700 (PDT)
X-Received: by 2002:a05:690c:6e85:b0:79b:e4e5:c954 with SMTP id 00721157ae682-79be4e5cc87mr3938797b3.23.1774603637015;
        Fri, 27 Mar 2026 02:27:17 -0700 (PDT)
Received: from dhcp-10-123-157-187.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79b17e4a0absm25718307b3.22.2026.03.27.02.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 02:27:16 -0700 (PDT)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v2 7/8] RDMA/bnxt_re: Support doorbells for app allocated QPs
Date: Fri, 27 Mar 2026 14:47:54 +0530
Message-ID: <20260327091755.47754-8-sriharsha.basavapatna@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18734-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2C0AD341B93
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

App allocated QPs can use a separate doorbell for each QP.
This doorbell region can be passed through a new driver specific
DBR_HANDLE attribute, during QP creation. When this attribute
is set, associate the QP with the given doorbell region.

While the QP holds a reference to the dbr, the dbr itself
cannot be destroyed and is rejected with EBUSY error.

Signed-off-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 35 ++++++++++++++++++++----
 drivers/infiniband/hw/bnxt_re/ib_verbs.h |  1 +
 drivers/infiniband/hw/bnxt_re/uapi.c     | 18 ++++++++++++
 include/uapi/rdma/bnxt_re-abi.h          |  4 +++
 4 files changed, 53 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 0e865cba2c45..7084f49ec28f 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1010,6 +1010,9 @@ int bnxt_re_destroy_qp(struct ib_qp *ib_qp, struct ib_udata *udata)
 	if (rc)
 		return rc;
 
+	if (qp->dbr_obj)
+		atomic_dec(&qp->dbr_obj->usecnt);
+
 	bnxt_re_debug_rem_qpinfo(rdev, qp);
 
 	bnxt_qplib_flush_cqn_wq(&qp->qplib_qp);
@@ -1183,7 +1186,8 @@ static int bnxt_re_get_psn_bytes(struct bnxt_re_dev *rdev,
 static int bnxt_re_init_user_qp(struct bnxt_re_dev *rdev, struct bnxt_re_pd *pd,
 				struct bnxt_re_qp *qp, struct bnxt_re_ucontext *cntx,
 				struct bnxt_re_qp_req *ureq,
-				bool app_qp)
+				bool app_qp,
+				struct bnxt_re_dbr_obj *dbr_obj)
 {
 	struct bnxt_qplib_qp *qplib_qp;
 	struct ib_umem *umem;
@@ -1230,8 +1234,11 @@ static int bnxt_re_init_user_qp(struct bnxt_re_dev *rdev, struct bnxt_re_pd *pd,
 	qp->rumem = umem;
 
 done:
+	if (dbr_obj)
+		qplib_qp->dpi = &dbr_obj->dpi;
+	else
+		qplib_qp->dpi = &cntx->dpi;
 	qplib_qp->qp_handle = ureq->qp_handle;
-	qplib_qp->dpi = &cntx->dpi;
 	qplib_qp->is_user = true;
 	return 0;
 fail:
@@ -1702,7 +1709,8 @@ static void bnxt_re_qp_calculate_msn_psn_size(struct bnxt_re_qp *qp,
 static int bnxt_re_init_qp_attr(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
 				struct ib_qp_init_attr *init_attr,
 				struct bnxt_re_ucontext *uctx,
-				struct bnxt_re_qp_req *ureq)
+				struct bnxt_re_qp_req *ureq,
+				struct bnxt_re_dbr_obj *dbr_obj)
 {
 	struct bnxt_qplib_dev_attr *dev_attr;
 	struct bnxt_qplib_qp *qplqp;
@@ -1769,7 +1777,8 @@ static int bnxt_re_init_qp_attr(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
 		bnxt_re_adjust_gsi_sq_attr(qp, init_attr, uctx);
 
 	if (uctx) { /* This will update DPI and qp_handle */
-		rc = bnxt_re_init_user_qp(rdev, pd, qp, uctx, ureq, app_qp);
+		rc = bnxt_re_init_user_qp(rdev, pd, qp, uctx, ureq, app_qp,
+					  dbr_obj);
 		if (rc)
 			return rc;
 	}
@@ -1902,7 +1911,9 @@ static int bnxt_re_add_unique_gid(struct bnxt_re_dev *rdev)
 int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 		      struct ib_udata *udata)
 {
+	struct bnxt_re_dbr_obj *dbr_obj = NULL;
 	struct bnxt_qplib_dev_attr *dev_attr;
+	struct uverbs_attr_bundle *attrs;
 	struct bnxt_re_ucontext *uctx;
 	struct bnxt_re_qp_req ureq;
 	struct bnxt_re_dev *rdev;
@@ -1923,6 +1934,17 @@ int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 		rc = ib_copy_validate_udata_in_cm(udata, ureq, qp_handle, 0);
 		if (rc)
 			return rc;
+
+		attrs = rdma_udata_to_uverbs_attr_bundle(udata);
+		if (uverbs_attr_is_valid(attrs,
+					 BNXT_RE_CREATE_QP_ATTR_DBR_HANDLE)) {
+			dbr_obj = uverbs_attr_get_obj(attrs,
+						      BNXT_RE_CREATE_QP_ATTR_DBR_HANDLE);
+			if (IS_ERR(dbr_obj))
+				return PTR_ERR(dbr_obj);
+			atomic_inc(&dbr_obj->usecnt);
+			qp->dbr_obj = dbr_obj;
+		}
 	}
 
 	rc = bnxt_re_test_qp_limits(rdev, qp_init_attr, dev_attr);
@@ -1932,7 +1954,8 @@ int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 	}
 
 	qp->rdev = rdev;
-	rc = bnxt_re_init_qp_attr(qp, pd, qp_init_attr, uctx, &ureq);
+	rc = bnxt_re_init_qp_attr(qp, pd, qp_init_attr, uctx, &ureq,
+				  dbr_obj);
 	if (rc)
 		goto fail;
 
@@ -2001,6 +2024,8 @@ int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 free_hwq:
 	bnxt_qplib_free_qp_res(&rdev->qplib_res, &qp->qplib_qp);
 fail:
+	if (dbr_obj)
+		atomic_dec(&dbr_obj->usecnt);
 	return rc;
 }
 
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
index 08f71a94d55d..fdf3dd4432c1 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
@@ -96,6 +96,7 @@ struct bnxt_re_qp {
 	struct bnxt_re_cq	*scq;
 	struct bnxt_re_cq	*rcq;
 	struct dentry		*dentry;
+	struct bnxt_re_dbr_obj *dbr_obj; /* doorbell region */
 };
 
 struct bnxt_re_cq {
diff --git a/drivers/infiniband/hw/bnxt_re/uapi.c b/drivers/infiniband/hw/bnxt_re/uapi.c
index 3eaee7101615..83e5ddf6ecf6 100644
--- a/drivers/infiniband/hw/bnxt_re/uapi.c
+++ b/drivers/infiniband/hw/bnxt_re/uapi.c
@@ -398,6 +398,9 @@ static int bnxt_re_dbr_cleanup(struct ib_uobject *uobject,
 	struct bnxt_re_dbr_obj *obj = uobject->object;
 	struct bnxt_re_dev *rdev = obj->rdev;
 
+	if (atomic_read(&obj->usecnt))
+		return -EBUSY;
+
 	rdma_user_mmap_entry_remove(&obj->entry->rdma_entry);
 	bnxt_qplib_free_uc_dpi(&rdev->qplib_res, &obj->dpi);
 	return 0;
@@ -459,11 +462,26 @@ DECLARE_UVERBS_NAMED_METHOD(BNXT_RE_METHOD_GET_DEFAULT_DBR,
 DECLARE_UVERBS_GLOBAL_METHODS(BNXT_RE_OBJECT_DEFAULT_DBR,
 			      &UVERBS_METHOD(BNXT_RE_METHOD_GET_DEFAULT_DBR));
 
+ADD_UVERBS_ATTRIBUTES_SIMPLE(
+	bnxt_re_qp_create,
+	UVERBS_OBJECT_QP,
+	UVERBS_METHOD_QP_CREATE,
+	UVERBS_ATTR_IDR(BNXT_RE_CREATE_QP_ATTR_DBR_HANDLE,
+			BNXT_RE_OBJECT_DBR,
+			UVERBS_ACCESS_READ,
+			UA_OPTIONAL));
+
+const struct uapi_definition bnxt_re_create_qp_defs[] = {
+	UAPI_DEF_CHAIN_OBJ_TREE(UVERBS_OBJECT_QP, &bnxt_re_qp_create),
+	{},
+};
+
 const struct uapi_definition bnxt_re_uapi_defs[] = {
 	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(BNXT_RE_OBJECT_ALLOC_PAGE),
 	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(BNXT_RE_OBJECT_NOTIFY_DRV),
 	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(BNXT_RE_OBJECT_GET_TOGGLE_MEM),
 	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(BNXT_RE_OBJECT_DBR),
 	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(BNXT_RE_OBJECT_DEFAULT_DBR),
+	UAPI_DEF_CHAIN(bnxt_re_create_qp_defs),
 	{}
 };
diff --git a/include/uapi/rdma/bnxt_re-abi.h b/include/uapi/rdma/bnxt_re-abi.h
index db8400f2ce3b..4da8cda337dc 100644
--- a/include/uapi/rdma/bnxt_re-abi.h
+++ b/include/uapi/rdma/bnxt_re-abi.h
@@ -138,6 +138,10 @@ struct bnxt_re_qp_req {
 	__u32 sq_npsn;
 };
 
+enum bnxt_re_create_qp_attrs {
+	BNXT_RE_CREATE_QP_ATTR_DBR_HANDLE = UVERBS_ID_DRIVER_NS_WITH_UHW,
+};
+
 struct bnxt_re_qp_resp {
 	__u32 qpid;
 	__u32 rsvd;
-- 
2.51.2.636.ga99f379adf


