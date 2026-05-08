Return-Path: <linux-rdma+bounces-20229-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLAbImmp/WmEhAAAu9opvQ
	(envelope-from <linux-rdma+bounces-20229-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 08 May 2026 11:14:17 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E159C4F41DF
	for <lists+linux-rdma@lfdr.de>; Fri, 08 May 2026 11:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82464308067A
	for <lists+linux-rdma@lfdr.de>; Fri,  8 May 2026 09:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B87A35E549;
	Fri,  8 May 2026 09:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CBXkSHe4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oo1-f99.google.com (mail-oo1-f99.google.com [209.85.161.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88ED35CB87
	for <linux-rdma@vger.kernel.org>; Fri,  8 May 2026 09:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778231318; cv=none; b=Dl4Ee15WflYLNwGUR9F+9d8E3/Y0w/GBrhblUcKz9/tzaf2chcjHjr5qX93ZJQQpEY4iQh5kyTF//HWAPMcmBFltQoXlChl+36JmyFK9mVgowANSy0uCvWHbE6BWu9yRwl8RgjoDyjVSMOvOr3gI79NQ/7gqEVLdfBhScjLfxBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778231318; c=relaxed/simple;
	bh=+fasjvUJBQUdumCqfuIeosUuUJmvI2qz5xd6LRzHVYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GqhBVHPCQgSpZ0cY7SM87DClqB5FzHWNyHTWAzzjIcbrbTamv3PFes2xfa327FmeUT9eTGj++hrxIAw4wPjDuDyCWXlu2Ja1JXqfqYPp1Vs41gYBKiFJz8G5ApyuI6Vmg0FSLtzaz3FNmHeA+anMhueSS6Cs5KMSLawBy9X3T/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=CBXkSHe4; arc=none smtp.client-ip=209.85.161.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f99.google.com with SMTP id 006d021491bc7-6949831a7bcso984744eaf.1
        for <linux-rdma@vger.kernel.org>; Fri, 08 May 2026 02:08:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778231316; x=1778836116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eswg78tJrWWoXMM2WePZFlEllZlgtxlSXscRhJJ0+mc=;
        b=FnGoeZLEMMFW+PbJcISg4J9Otb8VbLWee/2RqBPF0LL6avfHFTwI2j1fy68DOgaJE9
         4MUi6LrQcuL6vq9yVnDxmZneDZtNW7yHn32o/KDAqSpU0UHb1C8VDU0Z+Ai9tVT9Ecv6
         L5AO2ifhyslIyQXIbZn/MqQ2bkmfllR5DhueqWvDdbjOFZn/WoYQvpibN5+Rw4sAbkiq
         LdgJ8vuiXQE/XnoKAFxL2r9QJf+JVxarTGAWVrB9+fSooiyhABTXjnqnnWYrgn71lVdp
         XKZ8QX3sst/fi4smeLQmAsTdg6X4pzAqFAyH2bfmcxgIm8SP5iRcguRXED82FpXrcMBB
         7ixw==
X-Gm-Message-State: AOJu0Yya3AwEIfzBXMlMGuuYH2QcXzKOh1O58FJWyFwXkr/k/y+jnf3U
	v2w7si/zuS1NnkCKMr80Z7wfYPZVMxIIQsytU6ONrTWUbHXS8fBCdy0CxXfmuXyPAJJZGyJMBYy
	1ESgQ3Nh7g4psNe3Gqir3800mqixfSYbZRoMxae1mIdCwF3ChZ+uUYynXDqDMVWHhjiC7cA3IYO
	kRQjDm7hYEXjRd+iriTjiOpWorjLEENTB7D6lIRz36Q3ygC3VsoGdrzFE2wx7RbA0y7QGTe+IFa
	NnUAD44WyOE3nn4G6V/J6tYCSdw
X-Gm-Gg: AeBDiesZx3gukokzs8snCOnfVlScWX/cbYHDyfcQBDhwCWJ9Glk9Bg7vdP3syxi+MYC
	1smG6obcviHpipebfNHtzKlir7FdM7zANxyWprLHQF/xZ5C+Hw4enBU8LFYnKiwr23itR+Q+TKk
	L3RYWUgPnck7suyXJqobcNbP4tRHvvlnj28RaVZzuZu1s1yp7lgpk+Iah9S5bLUxdKkU1Pxdzzz
	KqS5IUyFXOAhrJnRl874l50VjXd4HuBHjQ7xt/nlxVoW3ORwzdLWajSXtBxkhf+FsRYtA/KYb7m
	Ft/Ux0gzwsl2GOOYnWkL9ZUC/pqe6ULhhkwlvoLrQNx8iKyXCk50zww1GPfpLmtNgKJADIDPFbu
	AQmOaDqkX0NoPR/ElWK1GLRQapBXdJRv85eHWH6LD51Pwt7Lq1HWpmcxfDA1V/s5OsNBxHbfibp
	9aiTCiYHdiE465bqjWRN9EkNHFWMZo1x5Rub5VGESESE383NBAVm4RRSeJ2GY69zjd9a8t
X-Received: by 2002:a05:6820:184a:b0:696:83be:84a1 with SMTP id 006d021491bc7-69b25d2a68emr987854eaf.56.1778231315799;
        Fri, 08 May 2026 02:08:35 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-21.dlp.protect.broadcom.com. [144.49.247.21])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-43557126c72sm157412fac.4.2026.05.08.02.08.35
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 May 2026 02:08:35 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c798fc1a426so1080652a12.2
        for <linux-rdma@vger.kernel.org>; Fri, 08 May 2026 02:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1778231314; x=1778836114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eswg78tJrWWoXMM2WePZFlEllZlgtxlSXscRhJJ0+mc=;
        b=CBXkSHe4q6VsPDcNv2OrmXlS5AZn7cAxD3frDqBA1GzDR072rV5BibT1nwIjXY2anY
         nzgm4WyPbYYPUNFeDVfqfa/vwEFNXRlM99jB7z1ntAqbXPMTI9eHSsLSIdKWQu2vZtIr
         gUAmmOLHlLIQrdQx53uprsJDgGXE1LfBGYUI4=
X-Received: by 2002:a05:6a20:431b:b0:3a3:bb6:70a1 with SMTP id adf61e73a8af0-3aab136da6emr2045146637.20.1778231313986;
        Fri, 08 May 2026 02:08:33 -0700 (PDT)
X-Received: by 2002:a05:6a20:431b:b0:3a3:bb6:70a1 with SMTP id adf61e73a8af0-3aab136da6emr2045126637.20.1778231313572;
        Fri, 08 May 2026 02:08:33 -0700 (PDT)
Received: from dhcp-10-123-157-187.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839679c80e7sm14419052b3a.31.2026.05.08.02.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 02:08:32 -0700 (PDT)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v4 6/7] RDMA/bnxt_re: Support doorbells for app allocated QPs
Date: Fri,  8 May 2026 14:28:57 +0530
Message-ID: <20260508085858.21060-7-sriharsha.basavapatna@broadcom.com>
X-Mailer: git-send-email 2.51.2.636.ga99f379adf
In-Reply-To: <20260508085858.21060-1-sriharsha.basavapatna@broadcom.com>
References: <20260508085858.21060-1-sriharsha.basavapatna@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: E159C4F41DF
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-20229-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:email,broadcom.com:mid,broadcom.com:dkim];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

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
index a04cbfb36135..5d36a2fc8a10 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1016,6 +1016,9 @@ int bnxt_re_destroy_qp(struct ib_qp *ib_qp, struct ib_udata *udata)
 	if (rc)
 		return rc;
 
+	if (qp->dbr_obj)
+		atomic_dec(&qp->dbr_obj->usecnt);
+
 	bnxt_re_debug_rem_qpinfo(rdev, qp);
 
 	bnxt_qplib_flush_cqn_wq(&qp->qplib_qp);
@@ -1191,7 +1194,8 @@ static int bnxt_re_get_psn_bytes(struct bnxt_re_dev *rdev,
 static int bnxt_re_init_user_qp(struct bnxt_re_dev *rdev, struct bnxt_re_pd *pd,
 				struct bnxt_re_qp *qp, struct bnxt_re_ucontext *cntx,
 				struct bnxt_re_qp_req *ureq,
-				bool fixed_que_attr)
+				bool fixed_que_attr,
+				struct bnxt_re_dbr_obj *dbr_obj)
 {
 	struct bnxt_qplib_qp *qplib_qp;
 	struct ib_umem *umem;
@@ -1234,8 +1238,11 @@ static int bnxt_re_init_user_qp(struct bnxt_re_dev *rdev, struct bnxt_re_pd *pd,
 		goto rqfail;
 
 done:
+	if (dbr_obj)
+		qplib_qp->dpi = &dbr_obj->dpi;
+	else
+		qplib_qp->dpi = &cntx->dpi;
 	qplib_qp->qp_handle = ureq->qp_handle;
-	qplib_qp->dpi = &cntx->dpi;
 	qplib_qp->is_user = true;
 	return 0;
 
@@ -1713,7 +1720,8 @@ static void bnxt_re_qp_calculate_msn_psn_size(struct bnxt_re_qp *qp,
 static int bnxt_re_init_qp_attr(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
 				struct ib_qp_init_attr *init_attr,
 				struct bnxt_re_ucontext *uctx,
-				struct bnxt_re_qp_req *ureq)
+				struct bnxt_re_qp_req *ureq,
+				struct bnxt_re_dbr_obj *dbr_obj)
 {
 	struct bnxt_qplib_dev_attr *dev_attr;
 	struct bnxt_qplib_qp *qplqp;
@@ -1780,7 +1788,8 @@ static int bnxt_re_init_qp_attr(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
 		bnxt_re_adjust_gsi_sq_attr(qp, init_attr, uctx);
 
 	if (uctx) { /* This will update DPI and qp_handle */
-		rc = bnxt_re_init_user_qp(rdev, pd, qp, uctx, ureq, fixed_que_attr);
+		rc = bnxt_re_init_user_qp(rdev, pd, qp, uctx, ureq, fixed_que_attr,
+					  dbr_obj);
 		if (rc)
 			return rc;
 	}
@@ -1916,7 +1925,9 @@ static int bnxt_re_add_unique_gid(struct bnxt_re_dev *rdev)
 int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 		      struct ib_udata *udata)
 {
+	struct bnxt_re_dbr_obj *dbr_obj = NULL;
 	struct bnxt_qplib_dev_attr *dev_attr;
+	struct uverbs_attr_bundle *attrs;
 	struct bnxt_re_ucontext *uctx;
 	struct bnxt_re_qp_req ureq;
 	struct bnxt_re_dev *rdev;
@@ -1937,6 +1948,17 @@ int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
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
@@ -1946,7 +1968,8 @@ int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 	}
 
 	qp->rdev = rdev;
-	rc = bnxt_re_init_qp_attr(qp, pd, qp_init_attr, uctx, &ureq);
+	rc = bnxt_re_init_qp_attr(qp, pd, qp_init_attr, uctx, &ureq,
+				  dbr_obj);
 	if (rc)
 		goto fail;
 
@@ -2016,6 +2039,8 @@ int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 	bnxt_qplib_free_qp_res(&rdev->qplib_res, &qp->qplib_qp);
 	bnxt_re_qp_free_umem(qp);
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


