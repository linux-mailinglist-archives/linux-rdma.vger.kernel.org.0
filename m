Return-Path: <linux-rdma+bounces-20983-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLDxGo1+DGoSiQUAu9opvQ
	(envelope-from <linux-rdma+bounces-20983-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 17:15:25 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D860C5813A2
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 17:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 600443072DCD
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 15:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB7631F983;
	Tue, 19 May 2026 15:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KHz1Dc6Q"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1AF3769FE
	for <linux-rdma@vger.kernel.org>; Tue, 19 May 2026 15:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779203433; cv=none; b=XcDsvhlj/JDd9E/scIRK0NUOmJ/VS+jIXFVkgFTuB2AaVwAUds0C//a961y2fDX6idYjRPyZPtvJTKUmhp8WPyQFfab2RQoT2kz859Gz6QXrkesAhoO3FNGHywAHU+tHIoYPPYYdO7I33TbUb5XeQnsdp9XD8O3Z4XipBfXHSX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779203433; c=relaxed/simple;
	bh=zY9R0V6UQihRX7v0FsBFDzFh+iO922wZcTUMHq4Qy7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L3fzi127zLZ9mviSqdEij3J6W9sO+uoNaL3gl115AZXBrPC9qphLmtVcGIbKkgQsusCqAuRl1n0kWCvErkj7pjxJ/rZEC8U+pjMD2K7N0JsR2YwwV7KySejMM8BPWTrlrYEU7q4FJgaqXkHNMlsZEU/8p4Yq0pxpXJW1Pjl6/6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KHz1Dc6Q; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-2ba928852a5so25735805ad.1
        for <linux-rdma@vger.kernel.org>; Tue, 19 May 2026 08:10:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779203426; x=1779808226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZmHib4Ohna8NjTFHf6C2nDeVemtUHTmYHeUTVThJBj4=;
        b=OBv3koW+LpOdO3ZuIRWIjFc8H80gcL0StI6evweSGAqbj7dSVJdg6M/G0P+pJ0q2po
         FWHXuJlg8dppCZq2c/qc0ni6UzDQb2mc9Ya3wNi8gj7buUG7XvCGAfXhxmo5j4eXnnDL
         gEmc4wI6fToEAmP8nok2anqDyYU/pSiCzNd+CHv0+Z1f9uJi9/QEASJEa1WtAJW8eo4W
         DxT485XRNi7sbdJZWsRtjvoU2eLep8hzB2+nxQS4i2LGEqwvshkF4Ma7/bhd/qrdYCW+
         IkA/S5bRnBlut7GId3ojaaqSZtVv6Ncq7cuHSTq//T9PULLqBydrD9QeH7cJ7tiAB0rX
         1cDA==
X-Gm-Message-State: AOJu0YwbxE0HWpeZMnbWRLuTNA6ENoIHgYjZW4wD2JXKbwHoO95Hhnoq
	Z88A00orfypSZq1jD6pY+NGxBTiF06vOgObgld6Fvpz6hHu3zUr4WF5bcbagAdGHh/4o2uNc85A
	Ue/HkAygv4P543wvHOG7XaHFLHVofZMEnTQh5yXC/KDDGyrCtelVkUZwpkYcXA3tgIn8gVzayFc
	IlwrQr3s9oa2Xg50WDsINoAr14LDEelJM9mkdHWDu+rcefI8dK7gSlLUglwkcP9XMRbKPEhhi9x
	3cpAWI5OFhmq8Cc6352ZaC6MBf2
X-Gm-Gg: Acq92OGVSByNeGb6Z0UCbpAmQrud64N/29bcymmLM0H94TUJ6L7czJhhv6s/AEpPbM6
	N4Z7tZX1zkKAPycS9Sy1w3rv/Zob9ZKOaH3TQ0cgWFKFFxq7oF1KcpVHbh9yRjTv2bs1qVZONE8
	NO/M4oKjkidh3TxmfKpgwgKIoFv0bHzP+jU52VqUcUXAibzuzDJeRs9+AxiJfHWnK2svdvDYSIg
	S/bqtyr0OiXoaFY3Bss1GSTrgOKxiOU0lS6Yc6u7Vi+/Tp2AcUB/7oEQ+qfVw6Bb3KKV0ABb5Hd
	8HGmNtsc/qQYADFctGwLsGauqzKFkWhzlbvgIWFiSyWpnTYVR19bs0fPGPMCCHAjW3kKYPLPL9e
	RlckZ1QcEIRY3wNQZ2tuuDdw9qQOROsSyxEYPeHhf8VxkLlaL2Za0Awz7r8u64SI6txGKPF2zGE
	nmUfUg7CMQRX3W3qvl5lSY425efnSkMKvUd09syz+t60TY9iYJZfRUCERG9Rb3YJgkqZxe
X-Received: by 2002:a17:902:c943:b0:2b2:b117:1e1b with SMTP id d9443c01a7336-2bd7e8133e4mr211191675ad.17.1779203425753;
        Tue, 19 May 2026 08:10:25 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-24.dlp.protect.broadcom.com. [144.49.247.24])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2bd5c06527fsm13280445ad.15.2026.05.19.08.10.25
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 May 2026 08:10:25 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2bd6cc53fd6so37894415ad.3
        for <linux-rdma@vger.kernel.org>; Tue, 19 May 2026 08:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1779203424; x=1779808224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZmHib4Ohna8NjTFHf6C2nDeVemtUHTmYHeUTVThJBj4=;
        b=KHz1Dc6Q3rHTMVZMLNWkkryVpNZjO1gx29eHREJOehr5zRuTa200X1N6BHGwIQ+MKO
         ZI02ul1OBMoTJhSNkKyJatmwHHJs1Y8/2gMYlYjyR6a0lREQ8J15J7H+snpi6+lW3Fbt
         eVL3eB4vYGOYx4FdiJq7kmcRPSwyTpD3xmGYY=
X-Received: by 2002:a17:903:24f:b0:2ae:5629:ac55 with SMTP id d9443c01a7336-2bd7e887498mr207699345ad.21.1779203423785;
        Tue, 19 May 2026 08:10:23 -0700 (PDT)
X-Received: by 2002:a17:903:24f:b0:2ae:5629:ac55 with SMTP id d9443c01a7336-2bd7e887498mr207698995ad.21.1779203423306;
        Tue, 19 May 2026 08:10:23 -0700 (PDT)
Received: from dhcp-10-123-156-119.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d1062e9sm190739735ad.67.2026.05.19.08.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 08:10:22 -0700 (PDT)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v7 8/9] RDMA/bnxt_re: Support doorbells for app allocated QPs
Date: Tue, 19 May 2026 20:30:40 +0530
Message-ID: <20260519150041.7251-9-sriharsha.basavapatna@broadcom.com>
X-Mailer: git-send-email 2.51.2.636.ga99f379adf
In-Reply-To: <20260519150041.7251-1-sriharsha.basavapatna@broadcom.com>
References: <20260519150041.7251-1-sriharsha.basavapatna@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20983-lists,linux-rdma=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,broadcom.com:email,broadcom.com:mid,broadcom.com:dkim];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D860C5813A2
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
index 66cc4b3e1ef9..dc7f4c019bba 100644
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
index 6a5bcc3fb289..ebc393e6da4f 100644
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
index 1d44d6225da0..9e68b4a7e952 100644
--- a/drivers/infiniband/hw/bnxt_re/uapi.c
+++ b/drivers/infiniband/hw/bnxt_re/uapi.c
@@ -418,6 +418,15 @@ static int bnxt_re_dbr_cleanup(struct ib_uobject *uobject,
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
@@ -478,11 +487,26 @@ DECLARE_UVERBS_NAMED_METHOD(BNXT_RE_METHOD_GET_DEFAULT_DBR,
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


