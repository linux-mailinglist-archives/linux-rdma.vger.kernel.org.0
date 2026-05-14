Return-Path: <linux-rdma+bounces-20715-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id XGpmIKj5BWrFdwIAu9opvQ
	(envelope-from <linux-rdma+bounces-20715-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 18:34:48 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D41544C3A
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 18:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 919AB303AB45
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 16:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63DA33C532;
	Thu, 14 May 2026 16:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TnZdJurL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0805633A03F
	for <linux-rdma@vger.kernel.org>; Thu, 14 May 2026 16:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778776392; cv=none; b=bYzil87cFWjrarZJmoQfeuLUwhXdtePtHlzOutpEDG472rQmaicC1H2g6M52dAPFamPfwGKWr+DY/mzTSAJltZWg21xzMHqHBaVQwUhFc2cgt9g1ARZJcb1Z5O0nUDhPHG0y93VxQmCe40itgdgfRhvQ2bLZActfp9sLmRd198s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778776392; c=relaxed/simple;
	bh=by8kdr0ToLcdnOXT6dfB3aGTidl/jIJj+yuzxSt5X3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fvt2Kz7JEAHoB9TX2lZ7BZXOvY7H3V3sN6nYdlE6dQd/VKbsqn7Qv2vXFpkfT1DshlZnxc4SSCo0MPxHZhjKoDKNMvnDvwYsZByFhq1PcXsA5AcNsbxZO+tyk2tu7CGSYATgnDnvFm+3Bjc79vzyP2V7EHd+KNg4Rc/IkKBKrxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=TnZdJurL; arc=none smtp.client-ip=209.85.216.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-36900945df5so1414461a91.0
        for <linux-rdma@vger.kernel.org>; Thu, 14 May 2026 09:33:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778776390; x=1779381190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2OBzOD5Fh5QN/lhRnsWUQ4sJbNhcYaCzE7hFUCoG1Bw=;
        b=hbWV1dAxQrEcreI1kP2LDWz8a93oHlRRRqTFiKuoty+Y3CMiY3tFDvxNEyPiaO6Aul
         tOMF73pDg7lYZ+5Xm6O8LqEqaqrv7pE/x3bkbh+LbluSQU0/SfIOC9KLyI5/RDSLtL05
         /UDzYv7dhnxVS91jnyZmyjAdgCZASmdKI3Abgk0vPx22Pj8v+8Gb/RUr/MArSU8hstC1
         txxiLgXaEMJNvYv981LScAUpx4pux5453JeDhZzvCG95Vd8zzspm2LZCAPnDckQgkSXc
         ZxCY1a5EcAmQr5aSKCYBxHZ78MyZI4jfWEGLi9XRJBJnnEtZ14F5/rb60GlQAayM0GZo
         AHJw==
X-Gm-Message-State: AOJu0YzR2kb/Nt359j/0ggD/37m1dP4NCqoS2k4T8Y7GufjCJZ6VwUQK
	TxeuKHWoeNry9vpvNYUYJV+bh58/MMhbar4ixWhkzRFzWnnf87O2HNWaTrycPGuXgK1AGX+QSGB
	MBkRXGZN84VuD13egwO4m0gKLDXzeKDgz/6GicTFaSxzIlWu7NsT09jugk8yriQwm8Cz+3dqOYf
	jUfCiuRix9NLAlqwAuQFvOCn1mbQlVzAwfyhz7JF8eRfB3AxpHPyEy/ro2IL37paM48I4mrb+4b
	PgsCSo8r7Wh6P0OtgnKHNpthOV5
X-Gm-Gg: Acq92OGtmUxgmW8FNOPyKzXRKqXVkOSqFz0BOn0y62W5e4ndDtOj7Ve+lZduuws/asr
	MZCwQq/HqVanHUEIYNe5ifoF7OLdwmzV+uzMON6LMdfecTDCc88qo2JkWKqeMqtjCdcWfUAhHL1
	ByRpd+U50/Pf+qF1xQylh/65339s2hr2HGAU0N1hwOGfyLOd5vLrYIZ9J36tWMI+US8i53YiBlS
	cETU0gXI3Ez/mnQR1XcrGWmdjw6gv5Tf+kbuuATFv8yEcQe1agnLxUcdVKmbThL/3I/XU1Uvnsl
	h3Qrd5TW8Lu72XRQv3IfSG9SVHORokv9NwMmfHr9tCYUJunzdYeUmx80j9fHrEiWdiqT76j1DO6
	/LXqaGULzU1Rm4VmPHZDZPFqI/U7cJSLBquiebrGW+dlfBa2ywwbNlzsa+G50j2V2JXamFeCNYt
	KRkiDfWhAU1abAmjY5+fpsVOVImBORz1AGVz+gfm/fPZPKUIRWFB11730e00AD3if8Brov
X-Received: by 2002:a17:90b:1b05:b0:366:132:fda3 with SMTP id 98e67ed59e1d1-369519c4b9cmr138417a91.11.1778776390000;
        Thu, 14 May 2026 09:33:10 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-21.dlp.protect.broadcom.com. [144.49.247.21])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2bd5bd6967bsm2282005ad.3.2026.05.14.09.33.09
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 May 2026 09:33:09 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b9a3c3c4eeso88129005ad.3
        for <linux-rdma@vger.kernel.org>; Thu, 14 May 2026 09:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1778776388; x=1779381188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2OBzOD5Fh5QN/lhRnsWUQ4sJbNhcYaCzE7hFUCoG1Bw=;
        b=TnZdJurLEI6VqkAom4ptsCGN7D+2exAic87w/g3s8yoPb9Bgi8Qgfh2PiyV88yqkrv
         jYaf5RpQe6ARekfLuyn+Ude/FErh9KwvsIAGrmHdFlqCELqajbz8mNz2MmIQ4tChchI1
         cyAsAb3P+DovSB44dE+wj4M6us66xtkcXWXhw=
X-Received: by 2002:a17:90b:4b8c:b0:368:6159:980c with SMTP id 98e67ed59e1d1-36951b84f49mr130131a91.20.1778776387857;
        Thu, 14 May 2026 09:33:07 -0700 (PDT)
X-Received: by 2002:a17:90b:4b8c:b0:368:6159:980c with SMTP id 98e67ed59e1d1-36951b84f49mr130086a91.20.1778776387270;
        Thu, 14 May 2026 09:33:07 -0700 (PDT)
Received: from dhcp-10-123-156-119.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3695157c3cfsm107728a91.5.2026.05.14.09.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 09:33:06 -0700 (PDT)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v5 6/7] RDMA/bnxt_re: Support doorbells for app allocated QPs
Date: Thu, 14 May 2026 21:53:35 +0530
Message-ID: <20260514162336.72644-7-sriharsha.basavapatna@broadcom.com>
X-Mailer: git-send-email 2.51.2.636.ga99f379adf
In-Reply-To: <20260514162336.72644-1-sriharsha.basavapatna@broadcom.com>
References: <20260514162336.72644-1-sriharsha.basavapatna@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: 17D41544C3A
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
	TAGGED_FROM(0.00)[bounces-20715-lists,linux-rdma=lfdr.de];
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

The current atomic usecnt doesn't handle implicit teardown of
dbr (process-exit/driver-removal), that ignores EBUSY error.
To address this, update this counter to use kref mechanism so
that the uobject (and associated db resource) is freed only when
the usecnt goes to zero.

Signed-off-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 35 ++++++++++++++++++---
 drivers/infiniband/hw/bnxt_re/ib_verbs.h |  4 ++-
 drivers/infiniband/hw/bnxt_re/uapi.c     | 39 ++++++++++++++++++++++--
 include/uapi/rdma/bnxt_re-abi.h          |  4 +++
 4 files changed, 73 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 9fd85d81bcea..9905f1c039d7 100644
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
index 08f71a94d55d..cdc403bf9e5d 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
@@ -96,6 +96,7 @@ struct bnxt_re_qp {
 	struct bnxt_re_cq	*scq;
 	struct bnxt_re_cq	*rcq;
 	struct dentry		*dentry;
+	struct bnxt_re_dbr_obj *dbr_obj; /* doorbell region */
 };
 
 struct bnxt_re_cq {
@@ -167,7 +168,7 @@ struct bnxt_re_dbr_obj {
 	struct bnxt_re_dev *rdev;
 	struct bnxt_qplib_dpi dpi;
 	struct bnxt_re_user_mmap_entry *entry;
-	atomic_t usecnt; /* QPs using this dbr */
+	struct kref usecnt; /* 1 (uobject) + n (QPs using this dbr) */
 };
 
 struct bnxt_re_flow {
@@ -308,4 +309,5 @@ void bnxt_re_unlock_cqs(struct bnxt_re_qp *qp, unsigned long flags);
 struct bnxt_re_user_mmap_entry*
 bnxt_re_mmap_entry_insert(struct bnxt_re_ucontext *uctx, u64 mem_offset,
 			  enum bnxt_re_mmap_flag mmap_flag, u64 *offset);
+void bnxt_re_dbr_kref_release(struct kref *ref);
 #endif /* __BNXT_RE_IB_VERBS_H__ */
diff --git a/drivers/infiniband/hw/bnxt_re/uapi.c b/drivers/infiniband/hw/bnxt_re/uapi.c
index 3eaee7101615..1b3116dd1fcf 100644
--- a/drivers/infiniband/hw/bnxt_re/uapi.c
+++ b/drivers/infiniband/hw/bnxt_re/uapi.c
@@ -369,6 +369,7 @@ static int UVERBS_HANDLER(BNXT_RE_METHOD_DBR_ALLOC)(struct uverbs_attr_bundle *a
 	}
 
 	obj->rdev = rdev;
+	kref_init(&obj->usecnt);
 	uobj->object = obj;
 	uverbs_finalize_uobj_create(attrs, BNXT_RE_ALLOC_DBR_HANDLE);
 
@@ -391,15 +392,32 @@ static int UVERBS_HANDLER(BNXT_RE_METHOD_DBR_ALLOC)(struct uverbs_attr_bundle *a
 	return ret;
 }
 
+void bnxt_re_dbr_kref_release(struct kref *ref)
+{
+	struct bnxt_re_dbr_obj *obj =
+		container_of(ref, struct bnxt_re_dbr_obj, usecnt);
+
+	rdma_user_mmap_entry_remove(&obj->entry->rdma_entry);
+	bnxt_qplib_free_uc_dpi(&obj->rdev->qplib_res, &obj->dpi);
+	kfree(obj);
+}
+
 static int bnxt_re_dbr_cleanup(struct ib_uobject *uobject,
 			       enum rdma_remove_reason why,
 			       struct uverbs_attr_bundle *attrs)
 {
 	struct bnxt_re_dbr_obj *obj = uobject->object;
-	struct bnxt_re_dev *rdev = obj->rdev;
 
-	rdma_user_mmap_entry_remove(&obj->entry->rdma_entry);
-	bnxt_qplib_free_uc_dpi(&rdev->qplib_res, &obj->dpi);
+	/* If it is being destroyed explicitly while QPs still hold a
+	 * reference (> 1), reject it with EBUSY. If no QP references
+	 * or implicit teardown (process exit, driver removal), drop
+	 * the uobject reference unconditionally. The object gets freed
+	 * (bnxt_re_dbr_kref_release) when the usecnt goes to zero.
+	 */
+	if (why == RDMA_REMOVE_DESTROY && kref_read(&obj->usecnt) > 1)
+		return -EBUSY;
+
+	kref_put(&obj->usecnt, bnxt_re_dbr_kref_release);
 	return 0;
 }
 
@@ -459,11 +477,26 @@ DECLARE_UVERBS_NAMED_METHOD(BNXT_RE_METHOD_GET_DEFAULT_DBR,
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


