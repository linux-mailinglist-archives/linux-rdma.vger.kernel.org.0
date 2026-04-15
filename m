Return-Path: <linux-rdma+bounces-19372-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMf/NE4p32lpPgAAu9opvQ
	(envelope-from <linux-rdma+bounces-19372-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2026 07:59:42 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 741BF400ACC
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2026 07:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4F0130421DD
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2026 05:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D0E37CD30;
	Wed, 15 Apr 2026 05:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MRRGVcea"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-dy1-f228.google.com (mail-dy1-f228.google.com [74.125.82.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13F9372B2B
	for <linux-rdma@vger.kernel.org>; Wed, 15 Apr 2026 05:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776232763; cv=none; b=NmrOyy6Yvg6q4PxnGDTVQNoYIRbibooA8gQQ+//IOQDqunEMqLdqXg3dug1heUoeJFn15hLSjfp/74bEnZgr9BhJNsi0g6yOznc3ea0vojGyxw4vs8SXkywo6fXR9rfndhe70dO126Vi7NHLNzkQM6fxeQZk+O9WLYHRlrFzrd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776232763; c=relaxed/simple;
	bh=Dn8qI3mvv4kUF5NXBQiB1e8QLG3Qg9qwLQoxxK5DDdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fE60iL/2iEyvKMyjOlMJFeJqe6gaazD7xQAPd9YFJ1qT4n81aUoXuV89JC223+zumQifeqQm9ZdnahvmKxdMU3GeD5Qd5ssnRdHqF0Ro+oiZboj1+b9GqOCEK8dtwiYFACBUvMLqQZ5yuTBlg9MjbVNh7k6bHm+yGAl4SC3Rt8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MRRGVcea; arc=none smtp.client-ip=74.125.82.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-dy1-f228.google.com with SMTP id 5a478bee46e88-2d832f2f44cso3898244eec.0
        for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2026 22:59:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776232761; x=1776837561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ivbTiwXa7LqoC+saYvrcas0RBaET7n3CiJkoUszzLms=;
        b=sG1sACR+PDxhfAJlCvHufAPGlHAsNv+KTUHFg/tj/XpKjYIEYOASHMXKK5RrzRTMae
         Vil+6wV8p80K6Xr+54jmcofx1z+/9VqWnu6iF53GBGrvzHkjufZrZA+djMR5nyvm72+m
         gsrfast6A4ssKbPUE0iEwntEEsqqLd90cpE6JE2E8/qQi/j98B2pa3NhAOWnpV6v9rJ5
         Qfp9hK8RTpddXl4ALRYT44W8h17GJkcnJj/qs7E2+H79NhdVogq2I3ePIiyapDeXWH35
         gOJzju+/d6OJ67X25CZpb3X5ThuZeTK+phIxxoy/nAiq/l0mWP2uUM+Ns6t2Syp126CZ
         4UfQ==
X-Gm-Message-State: AOJu0Yw4DU1o5sxBiv2f35ToVE2REAti7QEGt30b4flSpH9U/AOZnGod
	vMOPdfWLWJt9I0XueJ5W5DL+9+rGc5/RlW6HWf/EIafg5oQCociDL3kY1MQHIPh2fMCp+z360dF
	fIjLBgph5eBA4X09NGh3fgDbr1qqziKU4oFZoxYs5sKXb6DvOKELhBHcprMtSryAkPou7UcMq5a
	K2NmqLGs0eNXgc7+x8Egr9+lQfi+Ed5U4zCokdTLg1hBhbnWiKdS51kVk9OzlNd+67SE6YJ4XZ3
	EqOsnAjzDdVs99NdaDbxoatTc7b
X-Gm-Gg: AeBDievSjUvC1OaQd/wsiPBA2nKhsRQ5QYnAFmJq4GaAYqDWfvsHs6v7162G2CaxkGw
	TmqhoH3obLP+Plpzj7xf3FTng6FZ6kBcQQw3oH2z0Pn4zEuNoRJfLLROL/L5iagmyt38OBcufYm
	/jQiLsr0GMtytHUJv5BtP22WSqz10smgEl7xSviDAYljCp6QUBRRFudmJvnMjLIqon3WJSInlmP
	/b7qQe+GYALGJO+GLrwpWCvjO6FZKsQicqoBXfXw9LQLDVSUnnoGgKRgzePgVhHDxlKWb+2yh5t
	0lLraVT+HmWZcluZnE+J3alDJOkeVCu3bcSaAmtuqKl+WMNip10pY0zvhupMyNXpwUOW5WTIORv
	KAoW3qLblWMyyMQocVZEbxpNZw/VnwvitI22/jFxVRM/AhiBbt2gIqyEVLlPsi9ZyIZcbA514i0
	lv8wGIJvH6olhGs4QdvXa67pCEX7oGQgkRtoT/sh27mKQLaUInhsvr4jKgblF4UE9xaS9N
X-Received: by 2002:a05:7300:d80d:b0:2dd:649d:751d with SMTP id 5a478bee46e88-2dd649d793amr2102349eec.8.1776232760576;
        Tue, 14 Apr 2026 22:59:20 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-24.dlp.protect.broadcom.com. [144.49.247.24])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-2de8ea8982fsm57081eec.17.2026.04.14.22.59.20
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Apr 2026 22:59:20 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b2d0c1ead1so102271495ad.0
        for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2026 22:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1776232759; x=1776837559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ivbTiwXa7LqoC+saYvrcas0RBaET7n3CiJkoUszzLms=;
        b=MRRGVceaPZOi9oAoYuVznlSEY8eZocbGVR5SfEzDJ41Qf3HCHI4w9xmE9JyMzmKSP4
         B8iELPUPMmOBFmNw9WUE3LboU0QL+5ffHZXAawIaD9AASJJ5fxAE0Ji458Y4AjZNb5ww
         O0eCyQD8/8HDWLcmibsC+RKhyZOeo+OOBFDIE=
X-Received: by 2002:a17:902:8211:b0:2b2:d126:4e77 with SMTP id d9443c01a7336-2b2d5975bdfmr144085515ad.11.1776232758608;
        Tue, 14 Apr 2026 22:59:18 -0700 (PDT)
X-Received: by 2002:a17:902:8211:b0:2b2:d126:4e77 with SMTP id d9443c01a7336-2b2d5975bdfmr144085385ad.11.1776232758147;
        Tue, 14 Apr 2026 22:59:18 -0700 (PDT)
Received: from dhcp-10-123-157-187.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b4780ef365sm8344825ad.1.2026.04.14.22.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 22:59:17 -0700 (PDT)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v3 6/7] RDMA/bnxt_re: Support doorbells for app allocated QPs
Date: Wed, 15 Apr 2026 11:19:56 +0530
Message-ID: <20260415054957.36745-7-sriharsha.basavapatna@broadcom.com>
X-Mailer: git-send-email 2.51.2.636.ga99f379adf
In-Reply-To: <20260415054957.36745-1-sriharsha.basavapatna@broadcom.com>
References: <20260415054957.36745-1-sriharsha.basavapatna@broadcom.com>
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
	TAGGED_FROM(0.00)[bounces-19372-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 741BF400ACC
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
index 1a8cf99c7f72..0036c6160857 100644
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
-				bool app_qp)
+				bool app_qp,
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
-		rc = bnxt_re_init_user_qp(rdev, pd, qp, uctx, ureq, app_qp);
+		rc = bnxt_re_init_user_qp(rdev, pd, qp, uctx, ureq, app_qp,
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


