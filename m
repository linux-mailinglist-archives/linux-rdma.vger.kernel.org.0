Return-Path: <linux-rdma+bounces-19237-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Db4Dt9f2mlB1AgAu9opvQ
	(envelope-from <linux-rdma+bounces-19237-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Apr 2026 16:51:11 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 992323E0714
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Apr 2026 16:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E11F1306CBFD
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Apr 2026 14:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDD7385520;
	Sat, 11 Apr 2026 14:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="rSkWWDQu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BE0386C3D
	for <linux-rdma@vger.kernel.org>; Sat, 11 Apr 2026 14:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775918974; cv=none; b=G+acKG3wDQpvhTU0WeDyKLcq9c36VIG5ZxNby2hPKgPEX8gA5IgufA6vPty9d26ViBZNxqREljGx/hbng/mwa/do/hcdIcSxe3b8ThqjN74BRN/Tt1jnMXV8fl84xzc+Cs8GfMgYu+S7Q8LoDbVEcoE2b7nQyZsJbKFZJ4hkvKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775918974; c=relaxed/simple;
	bh=NGwe9XWIG83bKUb4MXwNyWTuYo7vR5JA70AWocclRu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sZlcivx7WqyEv6EQB3mu0O3sSxyDhW7tNa9i7GDCfj+6cgMScRMsbud21IAq+IKPLia+iUEErhdF5yRvzsNij5+mSS+xPMu/kT6Nk/QcWOGOjr60gKDn6bK5P7qF7QxJCHTvE79gcjtlbfuG8FQHwP4C0z+HV9B+ML9whfF1zpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=rSkWWDQu; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488a041eae5so21075315e9.1
        for <linux-rdma@vger.kernel.org>; Sat, 11 Apr 2026 07:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1775918972; x=1776523772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BHcJmJSQt3uQCqidXDP28eOLdmqwQ/hPTzKBzDVRZOs=;
        b=rSkWWDQuUxmtyRn3iPRMYl6hnKmfg+oBWD8uJmoC0HnVqeDhA+RXDMOshbHsqm1ifJ
         /pZMPo4Dp2tzNZkwimh9ZI58XxIJcgNgSEgvWLv61VxgQ400zpgb0sAxds7rX5LI9CNB
         yd7qTmCZLzra+2Gu6s6587F928m6yFOseNkE5XDnv3pR1f79eehDi95z8Yu33A15vI+r
         gvCZHf6CB/n7Khz/QJv2PDFlhW0BcvhhBOvWhexBInMN1cQhHIZDvkdbkEVzYbVLv4kd
         5U5YqamMeFc1h3LSSfcxVgcJ91sb30KWNELow9Kh0be3+glGSG4+R5W4h5O+J/4GrSg/
         9J+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775918972; x=1776523772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BHcJmJSQt3uQCqidXDP28eOLdmqwQ/hPTzKBzDVRZOs=;
        b=dBo/BrvVXEhJzTCGA7s/XjG90QM4UtHPbWg/IcWfzTY33CYsGGIvg7dmfUwN9h/8Af
         n2qzfiB1kSoA4V8sSCAFk96SUtN2PRx/xv8QxolILpEwiYIIE6MUMH+ciUjdvRVwp2S1
         64/zGNLjLXdnLlXGcnnkNO3rJLtaxLnYvKwhfzv+ACCkEiABH2eSPfGjxR/ctCmSeq1r
         yB77AdDFzphYrI6XfpCiWq1On3s0i1sUPs8ibLvqGL8u3oiaU2yvOILfMvrGko8tRsW5
         S8KKRiavGXuw7rRm7NaZ1mdruRy97ptnh9eKkeY71GyWiK+XZYenLB2n/6HLVhj7TkdC
         K0zg==
X-Gm-Message-State: AOJu0YyqPjxP6ICIzVzw/HEoujQDDVwSGVJojXX2l1pQksPL/RYpDm1U
	ft7NI/r194VvdasKzim/SM/yvot1C6r9zb0/8C9okNscHl+o8aPb/I5l1bveNU0waMuDbEDm+WY
	xO509
X-Gm-Gg: AeBDieu4gIFR1f7rJkPHTPa39vLLpcSwH8K4YPb2trg3xfrYkJl5Tjfr6TAqx11e730
	uDTAQKzOC6gBEUhYaeOUK/7uHrh+UA80GI4ms93J0+aPTYafTyBZOIWBsp2XQIahXc17ZtFRbFD
	zrX2Qi876W87+M6fb+NkdNJuDxVfWurbF7OzB9df8WQ41A7fLPB9bBxmZVYZK4Ra4LKXti9vAOf
	s3t5z/Uzci5Z6/qU+gatvUUOhT+qYFNkYDbpKDBJGmmJKEGMpn4UQyIMocGQhlFVYgnOR4xlQdk
	uznh0Dsf6pJiHgd3ZLwgoLhdTZqpoh3F9x5vT+2UX4PVEA1TYBpUVj6/WGy2Sc7kEIzaQrLHiRK
	FAqtPDuXp+ty6h8aehdeIQnlNpWoCnNTgzCpdDyDmY31HGQFrCi9KEaQc20T82IXZz2xIZ8XrpH
	veX26jaatlmmItlxUXrF6V0mZXjIRgQ5VC/014erH1i+g=
X-Received: by 2002:a05:600c:3b24:b0:488:aa33:dcbd with SMTP id 5b1f17b1804b1-488d687a645mr92289425e9.26.1775918971660;
        Sat, 11 Apr 2026 07:49:31 -0700 (PDT)
Received: from localhost (78-80-9-176.customers.tmcz.cz. [78.80.9.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488e10d69b2sm12251205e9.8.2026.04.11.07.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 07:49:31 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: linux-rdma@vger.kernel.org
Cc: jgg@ziepe.ca,
	leon@kernel.org,
	mrgolin@amazon.com,
	gal.pressman@linux.dev,
	sleybo@amazon.com,
	parav@nvidia.com,
	mbloch@nvidia.com,
	yanjun.zhu@linux.dev,
	marco.crivellari@suse.com,
	roman.gushchin@linux.dev,
	phaddad@nvidia.com,
	lirongqing@baidu.com,
	ynachum@amazon.com,
	huangjunxian6@hisilicon.com,
	kalesh-anakkur.purayil@broadcom.com,
	ohartoov@nvidia.com,
	michaelgur@nvidia.com,
	shayd@nvidia.com,
	edwards@nvidia.com,
	sriharsha.basavapatna@broadcom.com,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com
Subject: [PATCH rdma-next v2 10/15] RDMA/uverbs: Integrate umem_list into QP creation
Date: Sat, 11 Apr 2026 16:49:10 +0200
Message-ID: <20260411144915.114571-11-jiri@resnulli.us>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260411144915.114571-1-jiri@resnulli.us>
References: <20260411144915.114571-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19237-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[23];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli-us.20251104.gappssmtp.com:dkim,resnulli.us:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 992323E0714
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jiri Pirko <jiri@nvidia.com>

Wire up the generic buffer descriptor infrastructure to the QP create
command. Add umem_list field to struct ib_qp and define the QP buffer
slot enums.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2: Fix umem_list double free
---
 drivers/infiniband/core/core_priv.h           |  1 +
 drivers/infiniband/core/uverbs_cmd.c          |  4 ++--
 drivers/infiniband/core/uverbs_std_types_qp.c | 22 ++++++++++++++++---
 drivers/infiniband/core/verbs.c               | 19 +++++++++++++---
 include/rdma/ib_verbs.h                       |  3 +++
 include/uapi/rdma/ib_user_ioctl_cmds.h        |  8 +++++++
 6 files changed, 49 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/core/core_priv.h b/drivers/infiniband/core/core_priv.h
index a2c36666e6fc..3f7b0803f186 100644
--- a/drivers/infiniband/core/core_priv.h
+++ b/drivers/infiniband/core/core_priv.h
@@ -321,6 +321,7 @@ void nldev_exit(void);
 
 struct ib_qp *ib_create_qp_user(struct ib_device *dev, struct ib_pd *pd,
 				struct ib_qp_init_attr *attr,
+				struct ib_umem_list *umem_list,
 				struct ib_udata *udata,
 				struct ib_uqp_object *uobj, const char *caller);
 
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 60fafa1fb7b4..ce482ed047b0 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -1467,8 +1467,8 @@ static int create_qp(struct uverbs_attr_bundle *attrs,
 		attr.source_qpn = cmd->source_qpn;
 	}
 
-	qp = ib_create_qp_user(device, pd, &attr, &attrs->driver_udata, obj,
-			       KBUILD_MODNAME);
+	qp = ib_create_qp_user(device, pd, &attr, NULL,
+			       &attrs->driver_udata, obj, KBUILD_MODNAME);
 	if (IS_ERR(qp)) {
 		ret = PTR_ERR(qp);
 		goto err_put;
diff --git a/drivers/infiniband/core/uverbs_std_types_qp.c b/drivers/infiniband/core/uverbs_std_types_qp.c
index be0730e8509e..5d76bfac6544 100644
--- a/drivers/infiniband/core/uverbs_std_types_qp.c
+++ b/drivers/infiniband/core/uverbs_std_types_qp.c
@@ -4,6 +4,7 @@
  */
 
 #include <rdma/uverbs_std_types.h>
+#include <rdma/ib_umem.h>
 #include "rdma_core.h"
 #include "uverbs.h"
 #include "core_priv.h"
@@ -96,6 +97,7 @@ static int UVERBS_HANDLER(UVERBS_METHOD_QP_CREATE)(
 	struct ib_xrcd *xrcd = NULL;
 	struct ib_uobject *xrcd_uobj = NULL;
 	struct ib_device *device;
+	struct ib_umem_list *umem_list;
 	u64 user_handle;
 	int ret;
 
@@ -248,14 +250,24 @@ static int UVERBS_HANDLER(UVERBS_METHOD_QP_CREATE)(
 	set_caps(&attr, &cap, true);
 	mutex_init(&obj->mcast_lock);
 
-	qp = ib_create_qp_user(device, pd, &attr, &attrs->driver_udata, obj,
-			       KBUILD_MODNAME);
+	umem_list = ib_umem_list_create(device, attrs, UVERBS_BUF_QP_MAX);
+	if (IS_ERR(umem_list)) {
+		ret = PTR_ERR(umem_list);
+		goto err_put;
+	}
+
+	qp = ib_create_qp_user(device, pd, &attr, umem_list,
+			       &attrs->driver_udata, obj, KBUILD_MODNAME);
 	if (IS_ERR(qp)) {
 		ret = PTR_ERR(qp);
 		goto err_put;
 	}
 	ib_qp_usecnt_inc(qp);
 
+	ret = ib_umem_list_check_consumed(umem_list);
+	if (ret)
+		goto err_destroy_qp;
+
 	if (attr.qp_type == IB_QPT_XRC_TGT) {
 		obj->uxrcd = container_of(xrcd_uobj, struct ib_uxrcd_object,
 					  uobject);
@@ -277,6 +289,9 @@ static int UVERBS_HANDLER(UVERBS_METHOD_QP_CREATE)(
 			     sizeof(qp->qp_num));
 
 	return ret;
+
+err_destroy_qp:
+	ib_destroy_qp_user(qp, &attrs->driver_udata);
 err_put:
 	if (obj->uevent.event_file)
 		uverbs_uobject_put(&obj->uevent.event_file->uobj);
@@ -340,7 +355,8 @@ DECLARE_UVERBS_NAMED_METHOD(
 	UVERBS_ATTR_PTR_OUT(UVERBS_ATTR_CREATE_QP_RESP_QP_NUM,
 			   UVERBS_ATTR_TYPE(u32),
 			   UA_MANDATORY),
-	UVERBS_ATTR_UHW());
+	UVERBS_ATTR_UHW(),
+	UVERBS_ATTR_BUFFERS());
 
 static int UVERBS_HANDLER(UVERBS_METHOD_QP_DESTROY)(
 	struct uverbs_attr_bundle *attrs)
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 35700bad8310..0fe6cb1a9f07 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -1266,6 +1266,7 @@ static struct ib_qp *create_xrc_qp_user(struct ib_qp *qp,
 
 static struct ib_qp *create_qp(struct ib_device *dev, struct ib_pd *pd,
 			       struct ib_qp_init_attr *attr,
+			       struct ib_umem_list *umem_list,
 			       struct ib_udata *udata,
 			       struct ib_uqp_object *uobj, const char *caller)
 {
@@ -1292,6 +1293,7 @@ static struct ib_qp *create_qp(struct ib_device *dev, struct ib_pd *pd,
 	qp->registered_event_handler = attr->event_handler;
 	qp->port = attr->port_num;
 	qp->qp_context = attr->qp_context;
+	qp->umem_list = umem_list;
 
 	spin_lock_init(&qp->mr_lock);
 	INIT_LIST_HEAD(&qp->rdma_mrs);
@@ -1326,6 +1328,7 @@ static struct ib_qp *create_qp(struct ib_device *dev, struct ib_pd *pd,
 	qp->device->ops.destroy_qp(qp, udata ? &dummy : NULL);
 err_create:
 	rdma_restrack_put(&qp->res);
+	ib_umem_list_release(qp->umem_list);
 	kfree(qp);
 	return ERR_PTR(ret);
 
@@ -1339,21 +1342,23 @@ static struct ib_qp *create_qp(struct ib_device *dev, struct ib_pd *pd,
  * @attr: A list of initial attributes required to create the
  *   QP.  If QP creation succeeds, then the attributes are updated to
  *   the actual capabilities of the created QP.
+ * @umem_list: pre-mapped dma-buf umem list, or NULL
  * @udata: User data
  * @uobj: uverbs obect
  * @caller: caller's build-time module name
  */
 struct ib_qp *ib_create_qp_user(struct ib_device *dev, struct ib_pd *pd,
 				struct ib_qp_init_attr *attr,
+				struct ib_umem_list *umem_list,
 				struct ib_udata *udata,
 				struct ib_uqp_object *uobj, const char *caller)
 {
 	struct ib_qp *qp, *xrc_qp;
 
 	if (attr->qp_type == IB_QPT_XRC_TGT)
-		qp = create_qp(dev, pd, attr, NULL, NULL, caller);
+		qp = create_qp(dev, pd, attr, umem_list, NULL, NULL, caller);
 	else
-		qp = create_qp(dev, pd, attr, udata, uobj, NULL);
+		qp = create_qp(dev, pd, attr, umem_list, udata, uobj, NULL);
 	if (attr->qp_type != IB_QPT_XRC_TGT || IS_ERR(qp))
 		return qp;
 
@@ -1415,10 +1420,16 @@ struct ib_qp *ib_create_qp_kernel(struct ib_pd *pd,
 	if (qp_init_attr->cap.max_rdma_ctxs)
 		rdma_rw_init_qp(device, qp_init_attr);
 
-	qp = create_qp(device, pd, qp_init_attr, NULL, NULL, caller);
+	qp = create_qp(device, pd, qp_init_attr, NULL, NULL, NULL, caller);
 	if (IS_ERR(qp))
 		return qp;
 
+	/*
+	 * We are in kernel verbs flow and drivers are not allowed
+	 * to set umem_list pointer, it needs to stay NULL.
+	 */
+	WARN_ON_ONCE(qp->umem_list);
+
 	ib_qp_usecnt_inc(qp);
 
 	if (qp_init_attr->cap.max_rdma_ctxs) {
@@ -2147,6 +2158,7 @@ int ib_destroy_qp_user(struct ib_qp *qp, struct ib_udata *udata)
 {
 	const struct ib_gid_attr *alt_path_sgid_attr = qp->alt_path_sgid_attr;
 	const struct ib_gid_attr *av_sgid_attr = qp->av_sgid_attr;
+	struct ib_umem_list *umem_list = qp->umem_list;
 	struct ib_qp_security *sec;
 	int ret;
 
@@ -2184,6 +2196,7 @@ int ib_destroy_qp_user(struct ib_qp *qp, struct ib_udata *udata)
 
 	rdma_restrack_del(&qp->res);
 	kfree(qp);
+	ib_umem_list_release(umem_list);
 	return ret;
 }
 EXPORT_SYMBOL(ib_destroy_qp_user);
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index cf7fa69415a1..d78f62611a7e 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1524,6 +1524,7 @@ enum ib_mr_rereg_flags {
 };
 
 struct ib_umem;
+struct ib_umem_list;
 
 enum rdma_remove_reason {
 	/*
@@ -1944,6 +1945,8 @@ struct ib_qp {
 
 	/* The counter the qp is bind to */
 	struct rdma_counter    *counter;
+
+	struct ib_umem_list    *umem_list;
 };
 
 struct ib_dm {
diff --git a/include/uapi/rdma/ib_user_ioctl_cmds.h b/include/uapi/rdma/ib_user_ioctl_cmds.h
index 375e4e224f6a..9c5d3f989977 100644
--- a/include/uapi/rdma/ib_user_ioctl_cmds.h
+++ b/include/uapi/rdma/ib_user_ioctl_cmds.h
@@ -167,6 +167,14 @@ enum uverbs_attrs_create_qp_cmd_attr_ids {
 	UVERBS_ATTR_CREATE_QP_RESP_QP_NUM,
 };
 
+enum uverbs_buf_qp_slots {
+	UVERBS_BUF_QP_BUF,
+	UVERBS_BUF_QP_RQ_BUF,
+	UVERBS_BUF_QP_SQ_BUF,
+	__UVERBS_BUF_QP_MAX,
+	UVERBS_BUF_QP_MAX = __UVERBS_BUF_QP_MAX - 1,
+};
+
 enum uverbs_attrs_destroy_qp_cmd_attr_ids {
 	UVERBS_ATTR_DESTROY_QP_HANDLE,
 	UVERBS_ATTR_DESTROY_QP_RESP,
-- 
2.53.0


