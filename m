Return-Path: <linux-rdma+bounces-20921-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLmsIt01C2o9EwUAu9opvQ
	(envelope-from <linux-rdma+bounces-20921-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 17:53:01 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC885705A1
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 17:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CB67B301AF2C
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 15:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DB74949E6;
	Mon, 18 May 2026 15:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Q8AG09Bs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f227.google.com (mail-yw1-f227.google.com [209.85.128.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B1148BD56
	for <linux-rdma@vger.kernel.org>; Mon, 18 May 2026 15:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779119237; cv=none; b=V5UwvJJxULeDCeWKPfmllMFKtf0Jg+tIqQCh1WuE8JAMm9sdAzOp+YFN6L+dhdNwQy8wNU6lASoYVe3Fo9cAbdVrae9Qvl+YS821YpmQeiRVqMk0Bd13vzoXv2WWuBJqnFj6sZo4ZfJU818x1EIDuYjXdJXskiJmiUx/0dHxxEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779119237; c=relaxed/simple;
	bh=rDPqScUtoCeTOv+EeH/oYWIK+JUDtVCbQtwx0TUnOQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SInCj/5zNNlutAFbKSjWnKCj7Jzqj6FsEIVj9N7sfJf/RSM5sF5ifagkBvggCpfpRr1KyFLK6c54953BN3EKsw/FnfYXhyE+T/0MQs2ZdwG+xvfGOpWgSaF3MojXBghLHg2SFdJYl3ksQ3y8IokFwgJ2pxS3SakbVDv9bAPXVLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Q8AG09Bs; arc=none smtp.client-ip=209.85.128.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f227.google.com with SMTP id 00721157ae682-7bde9d73678so20093177b3.0
        for <linux-rdma@vger.kernel.org>; Mon, 18 May 2026 08:47:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779119226; x=1779724026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OkA8Luc6kZ7Jjriqx1ihlvgSrtTxpPGzglkGTjr8hUc=;
        b=shpZozIMWjn2wYoITwA+Q4qufYJU42mIej1NnyLIq2rO/aNZskF4TczLVbc5o/jHdF
         ayXGIZm0Yfqas8V7N6YnOQUbHfoqB0Q5Rla95OX+Q0ea4YyiqRkt9OEAzhzZb9nwLSyw
         V1rhLcZwIQI8t04kZAlhQe8KNMBh9hfejfdLSHKwiJdfKzdYODwKGxq9azLvttbfTnTA
         4bYib9M0W6tfgt+006rDAcskSkEYx/V+NYlSsPDxKdCre1MEych7nVAFB2v8iKr6OOur
         4u/nYjln+URuDvJXdUQE6fcOgPgS+kgOMn+tkU0qDLxpzaw3q1lKU27WpOezx4VH87/z
         520w==
X-Gm-Message-State: AOJu0Yy+aTnD3To5AU6Npcp5L8ZF955kISsHe6e7CbKWNazQRE3dGciQ
	rZByyEOs1Gfu4njWxtpppweay7HIys4n6PCAR/7j8GwfERixqdFoXKegRTPt5cEe0vAmYTWjztj
	czwZxTQkHfp4DeWEZP2snot/nfK8Kd/63LB5eRgo8Opoc785tjUdNaL0ZDHlxAzE5d8b0JjicEH
	/MyexAA012kTOJMEris5bDYiEcwQGCeQVheVtnvJt26x8WnqOaH5fkBHiCERkEaX4IfuLD8Hi0z
	F5GED1RmVL7FHh5QagjckRFrBYk
X-Gm-Gg: Acq92OERcI/Tdyl6sAhpSUy8uX3wfVvPB0ZuSzLsAnYArVHr0WfduhDLNsWvZS1IsRH
	lQ58iHcgc2LqNURRiCVKdhXXu/z8sykOZem0zxOG1C1mpfFwPJwl1VXHRagTtAZxY7gex1dxptV
	LFvLKn9cOVz50yvI8GLqF5DUyAy+mdPPkRwIBCAHTu9aqZY/lrdZCg3Wvna9BcU9g/yeq9v48TO
	nKuZxMzOeQ7+SyNPxRIQahnBKAe+F57DQGlYQ73wOOrejurd0n3XVCOkIRc8VcXYqp8pJl8C1n6
	RAMk1VsZ6LDfjI4zuw9qAaOAB4qwXmwFs+I9+aLnZbZrETwASIamYfddCzKk+id1OGfx2aqb5li
	Q/XivBNaY9QQLyKnjboYooVM/DCM+Pb65SduexxB/TnT9yvLIuvduPpuOiyVsTrTrTdHVmh6cyM
	vqEhkDDKUQ5HQIGJHI+uXX6s9WpBynkz+iGgoMXLHA0VLA+ftxQzvZywkNH1zDbuiiKOZH
X-Received: by 2002:a05:690c:e197:10b0:7b9:ed52:def2 with SMTP id 00721157ae682-7c9496d6541mr92128287b3.21.1779119225926;
        Mon, 18 May 2026 08:47:05 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-7cc9bc10fadsm3429627b3.28.2026.05.18.08.47.05
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 May 2026 08:47:05 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2babbeff9e4so26563415ad.0
        for <linux-rdma@vger.kernel.org>; Mon, 18 May 2026 08:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1779119224; x=1779724024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OkA8Luc6kZ7Jjriqx1ihlvgSrtTxpPGzglkGTjr8hUc=;
        b=Q8AG09BsRkf6oGWuE3rjschSR7/BtrCyWDc4a8otLc5FsyUg7qhIwymlo9cNQ/jyzV
         25/oAGeBbEF6YJTO35LDFFw+/fVnDtjCh7ndIizGAVSPtay/DBhJ6JrfjrciS4zlJJCv
         o3ddTt3mefLxhlLYH7ThdJP1atK/5hFkj2JHc=
X-Received: by 2002:a17:903:1b45:b0:2b2:9a70:3f0a with SMTP id d9443c01a7336-2bd7e7f4367mr128601735ad.4.1779119224479;
        Mon, 18 May 2026 08:47:04 -0700 (PDT)
X-Received: by 2002:a17:903:1b45:b0:2b2:9a70:3f0a with SMTP id d9443c01a7336-2bd7e7f4367mr128601555ad.4.1779119224007;
        Mon, 18 May 2026 08:47:04 -0700 (PDT)
Received: from dhcp-10-123-156-119.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d2360e8sm163954285ad.82.2026.05.18.08.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 08:47:03 -0700 (PDT)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v6 8/9] RDMA/bnxt_re: Support doorbells for app allocated QPs
Date: Mon, 18 May 2026 21:07:20 +0530
Message-ID: <20260518153721.183749-9-sriharsha.basavapatna@broadcom.com>
X-Mailer: git-send-email 2.51.2.636.ga99f379adf
In-Reply-To: <20260518153721.183749-1-sriharsha.basavapatna@broadcom.com>
References: <20260518153721.183749-1-sriharsha.basavapatna@broadcom.com>
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
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20921-lists,linux-rdma=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,broadcom.com:mid,broadcom.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8EC885705A1
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
 drivers/infiniband/hw/bnxt_re/uapi.c     | 24 ++++++++++++++++
 include/uapi/rdma/bnxt_re-abi.h          |  4 +++
 4 files changed, 59 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index b8e46feafee7..ba8f7f94131b 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1024,6 +1024,9 @@ int bnxt_re_destroy_qp(struct ib_qp *ib_qp, struct ib_udata *udata)
 	if (rc)
 		ibdev_err(&rdev->ibdev, "Failed to destroy HW QP");
 
+	if (qp->dbr_obj)
+		kref_put(&qp->dbr_obj->usecnt, bnxt_re_dbr_kref_release);
+
 	if (rdma_is_kernel_res(&qp->ib_qp.res)) {
 		flags = bnxt_re_lock_cqs(qp);
 		bnxt_qplib_clean_qp(&qp->qplib_qp);
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
 
@@ -1709,7 +1716,8 @@ static void bnxt_re_qp_calculate_msn_psn_size(struct bnxt_re_qp *qp,
 static int bnxt_re_init_qp_attr(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
 				struct ib_qp_init_attr *init_attr,
 				struct bnxt_re_ucontext *uctx,
-				struct bnxt_re_qp_req *ureq)
+				struct bnxt_re_qp_req *ureq,
+				struct bnxt_re_dbr_obj *dbr_obj)
 {
 	struct bnxt_qplib_dev_attr *dev_attr;
 	struct bnxt_qplib_qp *qplqp;
@@ -1776,7 +1784,8 @@ static int bnxt_re_init_qp_attr(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
 		bnxt_re_adjust_gsi_sq_attr(qp, init_attr, uctx);
 
 	if (uctx) { /* This will update DPI and qp_handle */
-		rc = bnxt_re_init_user_qp(rdev, pd, qp, uctx, ureq, fixed_que_attr);
+		rc = bnxt_re_init_user_qp(rdev, pd, qp, uctx, ureq, fixed_que_attr,
+					  dbr_obj);
 		if (rc)
 			return rc;
 	}
@@ -1912,7 +1921,9 @@ static int bnxt_re_add_unique_gid(struct bnxt_re_dev *rdev)
 int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 		      struct ib_udata *udata)
 {
+	struct bnxt_re_dbr_obj *dbr_obj = NULL;
 	struct bnxt_qplib_dev_attr *dev_attr;
+	struct uverbs_attr_bundle *attrs;
 	struct bnxt_re_ucontext *uctx;
 	struct bnxt_re_qp_req ureq;
 	struct bnxt_re_dev *rdev;
@@ -1933,6 +1944,17 @@ int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
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
+			kref_get(&dbr_obj->usecnt);
+			qp->dbr_obj = dbr_obj;
+		}
 	}
 
 	rc = bnxt_re_test_qp_limits(rdev, qp_init_attr, dev_attr);
@@ -1942,7 +1964,8 @@ int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 	}
 
 	qp->rdev = rdev;
-	rc = bnxt_re_init_qp_attr(qp, pd, qp_init_attr, uctx, &ureq);
+	rc = bnxt_re_init_qp_attr(qp, pd, qp_init_attr, uctx, &ureq,
+				  dbr_obj);
 	if (rc)
 		goto fail;
 
@@ -2012,6 +2035,8 @@ int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 	bnxt_qplib_free_qp_res(&rdev->qplib_res, &qp->qplib_qp);
 	bnxt_re_qp_free_umem(qp);
 fail:
+	if (dbr_obj)
+		kref_put(&dbr_obj->usecnt, bnxt_re_dbr_kref_release);
 	return rc;
 }
 
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
index 1caef68a5c38..89cd5d946f30 100644
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
index 866df9206f5a..b9a89c419746 100644
--- a/drivers/infiniband/hw/bnxt_re/uapi.c
+++ b/drivers/infiniband/hw/bnxt_re/uapi.c
@@ -417,6 +417,15 @@ static int bnxt_re_dbr_cleanup(struct ib_uobject *uobject,
 {
 	struct bnxt_re_dbr_obj *obj = uobject->object;
 
+	/* If it is being destroyed explicitly while QPs still hold a
+	 * reference (> 1), reject it with EBUSY. If no QP references
+	 * or implicit teardown (process exit, driver removal), drop
+	 * the uobject reference unconditionally. The object gets freed
+	 * (bnxt_re_dbr_kref_release) when the usecnt goes to zero.
+	 */
+	if (why == RDMA_REMOVE_DESTROY && kref_read(&obj->usecnt) > 1)
+		return -EBUSY;
+
 	kref_put(&obj->usecnt, bnxt_re_dbr_kref_release);
 	return 0;
 }
@@ -477,11 +486,26 @@ DECLARE_UVERBS_NAMED_METHOD(BNXT_RE_METHOD_GET_DEFAULT_DBR,
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


