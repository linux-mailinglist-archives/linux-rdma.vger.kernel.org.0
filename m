Return-Path: <linux-rdma+bounces-18629-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cO+YNHMFxGnOvQQAu9opvQ
	(envelope-from <linux-rdma+bounces-18629-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 16:55:31 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B55C328831
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 16:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AE090330A402
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 15:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E5A401A07;
	Wed, 25 Mar 2026 15:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="vmfPihsF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5924014B6
	for <linux-rdma@vger.kernel.org>; Wed, 25 Mar 2026 15:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774450870; cv=none; b=sw6/lQLgbxxSEO1aObQSKKZVpVIuFGo16Mmpar6quO1lLvEOxoTxv4ztz9okzq1a5Zn98SbCfYT1BESqS6mPFudKejvdbFazzfNUlcpDzPAYADswwy9scPReNjbUO0hwI98s05rViC4edlYFpO2X+Mn4dIf4ecg8l3X6WYr0Bsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774450870; c=relaxed/simple;
	bh=fnOz+CMY1WxeYjze+WbkIG9KV+eLkNm2WhHxZJNuNW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gxUza7rbOO7GJNHxiQeSx8gc9B5Ug369TKunhpVUYVry09YR/fmWILxKPdceO5FtHf2m1Vs5hZ511IrafGfga26wIO5AVSn/V8stA9cdAYidJFYs5w37+u2mIk9H1yTA5ZOaB1jsjinLHjrLpH3NY2QKZVPXXFVEfuX2Sg6n878=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=vmfPihsF; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48702d51cd0so53359145e9.2
        for <linux-rdma@vger.kernel.org>; Wed, 25 Mar 2026 08:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1774450867; x=1775055667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m34YOW1a+uWC8JDfU7NoJtDrpJZtQ1XcpyolOeKKVu8=;
        b=vmfPihsFktcDXzgqfsUjIr8h1cQZrOKsa/+aSSXJmaG3NMYyuYsVHpMgRzPfHpa5hz
         eEjE5PAP8AX7iEhtEdC+kOXyEN1FjzBpRZetJk/hg0HBHCL8vDcd9BYIuFZepMBmuWBi
         begHOcbaDSPO2Jeo1LYf9wTW0ShpsOO1vAGQKUf+MRHz5CGlFJSNQGnWXlSKm7GywG8P
         Pwksc5vbWReOLXTxwELeH/UEnFHYhS0ugh3u1KEeDDM3phVmvFwmpKpiz4yRqwC4rAeT
         rKTlIg9Lsc0EFHVphpGwf7eQN2uXC5CcSDFZQICboN2LBPM1FiC2Lg8mRHMBlN/5OFYD
         j0JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774450867; x=1775055667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m34YOW1a+uWC8JDfU7NoJtDrpJZtQ1XcpyolOeKKVu8=;
        b=bgDulwKYjduHqem7y1fjsBzol2qWESHEVJ3Z4fnTFBUGvoj7meEWjGQ4vTNUkZMgMR
         q/0UnnjmUkus5MO/ZyVw0V7GWfdp4jlShXr/NQStd5wK6rSQmRFpw56HVLXt/sN7jmMv
         bUObbzAqEa156TRRK/8cHWJGIUj9IFEF/TNKDwQqT/ptJYw3pFAlOfqD/rJZ/2ervOZf
         Fwx2B8UcRYqSsqjmXDxBPYlXnP0JvqtcL2rQLjA5UzUcIOsPytiXSWDHxwDdVnZGC5J2
         J3+zy/kKOl5F/f5wRM5LulnlXViv7TKoDUCGyEpDTKC6XqvT2OMDtcY4IWu2/1qLHkrb
         OPyw==
X-Gm-Message-State: AOJu0YzOA/rqGyCo7QYMy+EwE2aRTKybhK2rB+TA3dtXg5buJso1fl2R
	N0gFeHX0ABNdDscoL4fK47oW8vQXW1cnGbT95gAQKy1GVczmU1mS1bZ323ekiNvMewrr4AIGFR4
	K6VIJZks=
X-Gm-Gg: ATEYQzxsI/2huVH+AAnXb0HGwndGZiq76tzSNuf8qI4gXA3bz5RVoo198PLKQ1EPBWF
	FpfGZyes/wzXrPSFP1XNncWs6NNA5A/Sqftpmot+rzGU1PCog9TSnYysQou3pjySsm9/08Taezj
	Unb8gVSrAuGdeW3ju8PEDm2idXUFvVEkVjDKYNv/Scjpg5sTataffrS/Z+d0nIQaVb6C+x8+T9A
	dlfWTKuBP4nN/6iCm9k3Ug6beE91sq7QlXIla/I1LEkyk2GyBz+JBJip/CMhI+dnJUyDfja1fKp
	ZInSbyqHXGJ80v/iH+TqBtbysIFREnjfelw0uWxWbVO9ibsQ9b4f1lV9TlGM4D75sqA/wK1FTpx
	ZZpv2citjLwjI+I9YYBMk8Sv99lpoioG40GKImxSyLQNX0WtrNJmSGoEE+HOnx6qsabBMCfQIx0
	5ur96so1m8X96e6A==
X-Received: by 2002:a05:600c:6089:b0:485:3f72:324d with SMTP id 5b1f17b1804b1-48716008471mr55508365e9.14.1774450866409;
        Wed, 25 Mar 2026 08:01:06 -0700 (PDT)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487113d73c0sm152581495e9.0.2026.03.25.08.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 08:01:05 -0700 (PDT)
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
	wangliang74@huawei.com,
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
Subject: [PATCH rdma-next 10/15] RDMA/uverbs: Integrate umem_list into QP creation
Date: Wed, 25 Mar 2026 16:00:43 +0100
Message-ID: <20260325150048.168341-11-jiri@resnulli.us>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260325150048.168341-1-jiri@resnulli.us>
References: <20260325150048.168341-1-jiri@resnulli.us>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18629-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[24];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,resnulli-us.20230601.gappssmtp.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2B55C328831
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jiri Pirko <jiri@nvidia.com>

Wire up the generic buffer descriptor infrastructure to the QP create
command. Add umem_list field to struct ib_qp and define the QP buffer
slot enums.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/infiniband/core/core_priv.h           |  1 +
 drivers/infiniband/core/uverbs_cmd.c          |  4 +--
 drivers/infiniband/core/uverbs_std_types_qp.c | 26 ++++++++++++++++---
 drivers/infiniband/core/verbs.c               | 18 ++++++++++---
 include/rdma/ib_verbs.h                       |  3 +++
 include/uapi/rdma/ib_user_ioctl_cmds.h        |  8 ++++++
 6 files changed, 51 insertions(+), 9 deletions(-)

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
index be0730e8509e..09f4922f3883 100644
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
-		goto err_put;
+		goto err_release_umem_list;
 	}
 	ib_qp_usecnt_inc(qp);
 
+	ret = ib_umem_list_check_consumed(umem_list);
+	if (ret)
+		goto err_destroy_qp;
+
 	if (attr.qp_type == IB_QPT_XRC_TGT) {
 		obj->uxrcd = container_of(xrcd_uobj, struct ib_uxrcd_object,
 					  uobject);
@@ -277,6 +289,11 @@ static int UVERBS_HANDLER(UVERBS_METHOD_QP_CREATE)(
 			     sizeof(qp->qp_num));
 
 	return ret;
+
+err_destroy_qp:
+	ib_destroy_qp_user(qp, &attrs->driver_udata);
+err_release_umem_list:
+	ib_umem_list_release(umem_list);
 err_put:
 	if (obj->uevent.event_file)
 		uverbs_uobject_put(&obj->uevent.event_file->uobj);
@@ -340,7 +357,8 @@ DECLARE_UVERBS_NAMED_METHOD(
 	UVERBS_ATTR_PTR_OUT(UVERBS_ATTR_CREATE_QP_RESP_QP_NUM,
 			   UVERBS_ATTR_TYPE(u32),
 			   UA_MANDATORY),
-	UVERBS_ATTR_UHW());
+	UVERBS_ATTR_UHW(),
+	UVERBS_ATTR_BUFFERS());
 
 static int UVERBS_HANDLER(UVERBS_METHOD_QP_DESTROY)(
 	struct uverbs_attr_bundle *attrs)
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 35700bad8310..0c9cef4744f5 100644
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
@@ -1339,21 +1341,23 @@ static struct ib_qp *create_qp(struct ib_device *dev, struct ib_pd *pd,
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
 
@@ -1415,10 +1419,16 @@ struct ib_qp *ib_create_qp_kernel(struct ib_pd *pd,
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
@@ -2147,6 +2157,7 @@ int ib_destroy_qp_user(struct ib_qp *qp, struct ib_udata *udata)
 {
 	const struct ib_gid_attr *alt_path_sgid_attr = qp->alt_path_sgid_attr;
 	const struct ib_gid_attr *av_sgid_attr = qp->av_sgid_attr;
+	struct ib_umem_list *umem_list = qp->umem_list;
 	struct ib_qp_security *sec;
 	int ret;
 
@@ -2184,6 +2195,7 @@ int ib_destroy_qp_user(struct ib_qp *qp, struct ib_udata *udata)
 
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
2.51.1


