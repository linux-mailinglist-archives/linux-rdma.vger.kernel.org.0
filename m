Return-Path: <linux-rdma+bounces-18458-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGkgG1FUvWlr8gIAu9opvQ
	(envelope-from <linux-rdma+bounces-18458-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 15:06:09 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 880462DB926
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 15:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 876AE302A400
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 14:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780DE2E1F0E;
	Fri, 20 Mar 2026 14:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Mmxk4yp4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ua1-f98.google.com (mail-ua1-f98.google.com [209.85.222.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87ACF31AF1B
	for <linux-rdma@vger.kernel.org>; Fri, 20 Mar 2026 14:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774015444; cv=none; b=ZdOrgSyBErBbTuu2NFtYSaugVKe8SvAd8P3BRwG2Ll16G+s7S7NJXh14DdAzkSVnHKJPzdmGw7SZBT/jAgMJgE7U/58Zk6AvQ2O5RqspbuCYlCdIk4IXjIpVwyuccw4sKUmgm1L0VTJrdElObR723qDjTcoo52PAbS/4vRbwCV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774015444; c=relaxed/simple;
	bh=gF1hUJi5wHB/6o1sjlKC8dyBtXc+kYO9zlyc7aJKfOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jSXMPydXVge44IZVnvFje+KqJhq3k8EIckV2R34CmdJXZPV0okNhI9c+PwTvke50Bs0B5RMZALGkvlAgypaRZKM/F8ptngYuTDKEP4hwjLnQm10q3oXRMi6DqK+u5BFjSPGwCmvKKA0k7I2bYPpqpYUbMskGj5hqzIJbvTOyV8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Mmxk4yp4; arc=none smtp.client-ip=209.85.222.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ua1-f98.google.com with SMTP id a1e0cc1a2514c-950cd03fb5eso502155241.0
        for <linux-rdma@vger.kernel.org>; Fri, 20 Mar 2026 07:04:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774015440; x=1774620240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e4S1RO/L4wcYlZ8HWpNlvA7R/wiNTLbDB4kv7B5W/YQ=;
        b=bgx/eQmsG33nZfsHkzh/MUEdaxiprEChrvcAVqWo1JfdDoxeBEN/Q3kOfvDwj3NdD1
         u7ydlDeKwn5pLblTM5AGpXG0xj1E1/gLkQG64uns6IGLx1ZztiPRbpnSedHvr98ifzPJ
         1OB2bayYy25IoifCrofeeGlqeVf/ckLQPIeIxU0j8+1WFrnmNk6d77cGji3Z60UG/t5H
         un5W51qnt+srbe7ddU37fq4mup83AMfGo5BvsPJgyeLD+pXYQw8DYljjUxzpJILt6YzU
         XOt4gERuPJO6Pn3s9YkEgifElWVr2tjF/1JxBK1ziEjNWcnHgxditnBk5H2rg75KPiRd
         rPMw==
X-Gm-Message-State: AOJu0YzMX6WxoQS5POn7z5B1iEQUn8YdWA6b48e5BzdzJYTcG68E2MDs
	IaiLxuEAj6ACghixq3Q4T/rW7C+gdDmpMW+gv536V2Rrm9KdW03ygetQ2QacSgNmXA1TCL4P9xf
	XntRPPhR2M2dddgrZB/Etq7Gy6uk7RhAx8200oeLRONgf7b4wbgculR9bFM5PMbBamG2EONo1mo
	ZOfwIprm/ImAZAL6ifqlzhlF7kdapHcMi1qhCm/DBHV0OtPOhcwALK4dlEcC+kWchOqOlZHMq3o
	zt0dC2hAB2DNMMOOASh3yel0DaQ
X-Gm-Gg: ATEYQzyB7Hi6YE1yB84SlKB0Vsgxs90K/gIYcARrtunUcTbgBHaxKtOQQChHHciKahH
	MfGmp54kGnPfEbX4RFIGn5zu39idIIJ/AzYQdmtgTbukQatBtENkOxooZWyeirmejVuPkx99MTv
	hPNt9k9TghfFHcLFr+16IV7wBinhhOKrH491qWwhYlooEs1MEb5wQkO/yQTYcZib9tnb09gv8d/
	oUBEupe04YhAKqncbfbSh0xpZ55I9i66CuhKg7vy8v8rn0QKYbUEgPRjqC2raKbNgbrVVtQuQUT
	jTF6qWQ84HgmJFQpX73otDyXqKA8HYoFUK44ek0vuUwLl3yeqQfQUj3JiV/aMTNFAm1ie9xsPVs
	gT42JVVV9oMLvL4Iac/01ty8WlzLUWIARQF9uDXjx6pC104foIDWjef7jYck4ruZ2WhFPEC5TuR
	KcLerbyjh0ZTXlsMDN7jQq236k2co/36ofWqT7FE5dOl0hN0D2+1DJsbil9Y+zTb4Ht7DOEJY=
X-Received: by 2002:a05:6122:3a0e:b0:56c:da22:6921 with SMTP id 71dfb90a1353d-56cde35a597mr1553041e0c.5.1774015439812;
        Fri, 20 Mar 2026 07:03:59 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-102.dlp.protect.broadcom.com. [144.49.247.102])
        by smtp-relay.gmail.com with ESMTPS id a1e0cc1a2514c-95136b4c0d9sm148556241.1.2026.03.20.07.03.59
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Mar 2026 07:03:59 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-82a0686edbcso1148531b3a.3
        for <linux-rdma@vger.kernel.org>; Fri, 20 Mar 2026 07:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774015438; x=1774620238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e4S1RO/L4wcYlZ8HWpNlvA7R/wiNTLbDB4kv7B5W/YQ=;
        b=Mmxk4yp4LSBrALoeQRu9kSvCTXnspWqXOVBPNJzA03jHQTm5iWUuDAfZR4zgK92ybE
         LkM2G/u+fHQag2llao7WaAY+SKARXD4TZzMQZIyAs116fb5H6WmYIIkqeuZY/C2rCTD2
         BjADQTuZRo/87zUspjEk2zvIzZtl3Rje3f0kU=
X-Received: by 2002:aa7:8896:0:b0:82a:60ad:874 with SMTP id d2e1a72fcca58-82a8c285087mr2808823b3a.19.1774015438237;
        Fri, 20 Mar 2026 07:03:58 -0700 (PDT)
X-Received: by 2002:aa7:8896:0:b0:82a:60ad:874 with SMTP id d2e1a72fcca58-82a8c285087mr2808725b3a.19.1774015436730;
        Fri, 20 Mar 2026 07:03:56 -0700 (PDT)
Received: from dhcp-10-123-157-187.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b040da3dfsm2136099b3a.45.2026.03.20.07.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 07:03:56 -0700 (PDT)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next 7/9] RDMA/bnxt_re: Support doorbells for app allocated QPs
Date: Fri, 20 Mar 2026 19:24:35 +0530
Message-ID: <20260320135437.48716-8-sriharsha.basavapatna@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18458-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 880462DB926
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
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 32 ++++++++++++++++++++----
 drivers/infiniband/hw/bnxt_re/ib_verbs.h |  1 +
 drivers/infiniband/hw/bnxt_re/uapi.c     | 18 +++++++++++++
 include/uapi/rdma/bnxt_re-abi.h          |  4 +++
 4 files changed, 50 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index f14d8270c711..deeb294e4742 100644
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
@@ -1183,7 +1186,8 @@ static int bnxt_re_init_user_qp(struct bnxt_re_dev *rdev, struct bnxt_re_pd *pd,
 				struct bnxt_re_qp *qp, struct bnxt_re_ucontext *cntx,
 				struct bnxt_re_qp_req *ureq,
 				struct ib_umem *sq_umem,
-				struct ib_umem *rq_umem)
+				struct ib_umem *rq_umem,
+				struct bnxt_re_dbr_obj *dbr_obj)
 {
 	struct bnxt_qplib_qp *qplib_qp;
 	struct ib_umem *umem;
@@ -1236,8 +1240,11 @@ static int bnxt_re_init_user_qp(struct bnxt_re_dev *rdev, struct bnxt_re_pd *pd,
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
 
@@ -1721,7 +1728,8 @@ static int bnxt_re_init_qp_attr(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
 				struct bnxt_re_ucontext *uctx,
 				struct bnxt_re_qp_req *ureq,
 				struct ib_umem *sq_umem,
-				struct ib_umem *rq_umem)
+				struct ib_umem *rq_umem,
+				struct bnxt_re_dbr_obj *dbr_obj)
 {
 	struct bnxt_qplib_dev_attr *dev_attr;
 	struct bnxt_qplib_qp *qplqp;
@@ -1789,7 +1797,7 @@ static int bnxt_re_init_qp_attr(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
 
 	if (uctx) { /* This will update DPI and qp_handle */
 		rc = bnxt_re_init_user_qp(rdev, pd, qp, uctx, ureq,
-					  sq_umem, rq_umem);
+					  sq_umem, rq_umem, dbr_obj);
 		if (rc)
 			return rc;
 	}
@@ -1925,7 +1933,9 @@ static int bnxt_re_add_unique_gid(struct bnxt_re_dev *rdev)
 int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 		      struct ib_udata *udata)
 {
+	struct bnxt_re_dbr_obj *dbr_obj = NULL;
 	struct bnxt_qplib_dev_attr *dev_attr;
+	struct uverbs_attr_bundle *attrs;
 	struct ib_umem *sq_umem = NULL;
 	struct ib_umem *rq_umem = NULL;
 	struct bnxt_re_ucontext *uctx;
@@ -1948,6 +1958,16 @@ int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
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
+		}
 	}
 
 	rc = bnxt_re_test_qp_limits(rdev, qp_init_attr, dev_attr);
@@ -1958,7 +1978,7 @@ int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 
 	qp->rdev = rdev;
 	rc = bnxt_re_init_qp_attr(qp, pd, qp_init_attr, uctx, &ureq,
-				  sq_umem, rq_umem);
+				  sq_umem, rq_umem, dbr_obj);
 	if (rc)
 		goto fail;
 
@@ -2028,6 +2048,8 @@ int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 	bnxt_qplib_free_qp_res(&rdev->qplib_res, &qp->qplib_qp);
 	bnxt_re_qp_free_umem(qp);
 fail:
+	if (dbr_obj)
+		atomic_dec(&dbr_obj->usecnt);
 	return rc;
 }
 
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
index 3d02c16f54b6..8b106d6dd112 100644
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


