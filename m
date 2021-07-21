Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEBB13D08AF
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jul 2021 08:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233792AbhGUFej (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Jul 2021 01:34:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:34350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233366AbhGUFdA (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 21 Jul 2021 01:33:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A1B116120C;
        Wed, 21 Jul 2021 06:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626848015;
        bh=XDXSIfpQiYiHZAZz04Rwc8JQLhSX9BpvH+OCpuH49vA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AYUKZXyyVVerYzSioVTsAGvqdta8rRoFplbuStcJHlts2mf6P80hSvIGd5s+gGRlV
         auB+nFeXaGJptQm3O++0tEcXy48RbfPXWcmlXT0BWVH0UgzoIP4HCNw4POS9rqtJ77
         gmus6obaeprERGF4N420F9msUsn2/Spc6iv7o00ttxJf22T/j1unpcaUG8zk36P6d3
         n01rpr5gL1O8tu6PbOF6Yqp57pySwqaqlq8eIBvLlFMiAEShjXvjC/DugZXCjYDCXh
         PkTqa1JjXAbnO/aYBlMchbcJjQuld1WB9h7i2QXC/ys4Ba/LgnIJCWmu/LnebgjMwL
         9j3UHVcR8aJ2Q==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Mark Zhang <markz@mellanox.com>
Subject: [PATCH rdma-next 7/7] RDMA/core: Create clean QP creations interface for uverbs
Date:   Wed, 21 Jul 2021 09:13:06 +0300
Message-Id: <8eaf125d3bfb463e1641b6f2794203cc93d76c90.1626846795.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626846795.git.leonro@nvidia.com>
References: <cover.1626846795.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Unify create QP creation interface to make clean approach to create
XRC_TGT and regular QPs.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/core_priv.h           | 21 +++++-
 drivers/infiniband/core/uverbs_cmd.c          | 12 +--
 drivers/infiniband/core/uverbs_std_types_qp.c |  9 +--
 drivers/infiniband/core/verbs.c               | 73 +++++++++++--------
 4 files changed, 63 insertions(+), 52 deletions(-)

diff --git a/drivers/infiniband/core/core_priv.h b/drivers/infiniband/core/core_priv.h
index d8f464b43dbc..dd4c2e560b59 100644
--- a/drivers/infiniband/core/core_priv.h
+++ b/drivers/infiniband/core/core_priv.h
@@ -316,10 +316,23 @@ struct ib_device *ib_device_get_by_index(const struct net *net, u32 index);
 void nldev_init(void);
 void nldev_exit(void);
 
-struct ib_qp *_ib_create_qp(struct ib_device *dev, struct ib_pd *pd,
-			    struct ib_qp_init_attr *attr,
-			    struct ib_udata *udata, struct ib_uqp_object *uobj,
-			    const char *caller);
+struct ib_qp *ib_create_qp_user(struct ib_device *dev, struct ib_pd *pd,
+				struct ib_qp_init_attr *attr,
+				struct ib_udata *udata,
+				struct ib_uqp_object *uobj, const char *caller);
+static inline struct ib_qp *ib_create_qp_uverbs(struct ib_device *dev,
+						struct ib_pd *pd,
+						struct ib_qp_init_attr *attr,
+						struct ib_udata *udata,
+						struct ib_uqp_object *uobj)
+{
+	if (attr->qp_type == IB_QPT_XRC_TGT)
+		return ib_create_qp_user(dev, pd, attr, NULL, uobj,
+					 KBUILD_MODNAME);
+
+	return ib_create_qp_user(dev, pd, attr, udata, uobj, NULL);
+}
+
 void ib_qp_usecnt_inc(struct ib_qp *qp);
 void ib_qp_usecnt_dec(struct ib_qp *qp);
 
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 62cafd768d89..39206ecdeaad 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -1435,23 +1435,13 @@ static int create_qp(struct uverbs_attr_bundle *attrs,
 		attr.source_qpn = cmd->source_qpn;
 	}
 
-	if (cmd->qp_type == IB_QPT_XRC_TGT)
-		qp = ib_create_qp(pd, &attr);
-	else
-		qp = _ib_create_qp(device, pd, &attr, &attrs->driver_udata, obj,
-				   NULL);
-
+	qp = ib_create_qp_uverbs(device, pd, &attr, &attrs->driver_udata, obj);
 	if (IS_ERR(qp)) {
 		ret = PTR_ERR(qp);
 		goto err_put;
 	}
 	ib_qp_usecnt_inc(qp);
 
-	if (cmd->qp_type == IB_QPT_XRC_TGT) {
-		/* It is done in _ib_create_qp for other QP types */
-		qp->uobject = obj;
-	}
-
 	obj->uevent.uobject.object = qp;
 	obj->uevent.event_file = READ_ONCE(attrs->ufile->default_async_file);
 	if (obj->uevent.event_file)
diff --git a/drivers/infiniband/core/uverbs_std_types_qp.c b/drivers/infiniband/core/uverbs_std_types_qp.c
index a0e734735ba5..15ea00188363 100644
--- a/drivers/infiniband/core/uverbs_std_types_qp.c
+++ b/drivers/infiniband/core/uverbs_std_types_qp.c
@@ -248,12 +248,7 @@ static int UVERBS_HANDLER(UVERBS_METHOD_QP_CREATE)(
 	set_caps(&attr, &cap, true);
 	mutex_init(&obj->mcast_lock);
 
-	if (attr.qp_type == IB_QPT_XRC_TGT)
-		qp = ib_create_qp(pd, &attr);
-	else
-		qp = _ib_create_qp(device, pd, &attr, &attrs->driver_udata, obj,
-				   NULL);
-
+	qp = ib_create_qp_uverbs(device, pd, &attr, &attrs->driver_udata, obj);
 	if (IS_ERR(qp)) {
 		ret = PTR_ERR(qp);
 		goto err_put;
@@ -264,8 +259,6 @@ static int UVERBS_HANDLER(UVERBS_METHOD_QP_CREATE)(
 		obj->uxrcd = container_of(xrcd_uobj, struct ib_uxrcd_object,
 					  uobject);
 		atomic_inc(&obj->uxrcd->refcnt);
-		/* It is done in _ib_create_qp for other QP types */
-		qp->uobject = obj;
 	}
 
 	obj->uevent.uobject.object = qp;
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index acf866038277..9414fa8b54c4 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -1200,21 +1200,10 @@ static struct ib_qp *create_xrc_qp_user(struct ib_qp *qp,
 	return qp;
 }
 
-/**
- * _ib_create_qp - Creates a QP associated with the specified protection domain
- * @dev: IB device
- * @pd: The protection domain associated with the QP.
- * @attr: A list of initial attributes required to create the
- *   QP.  If QP creation succeeds, then the attributes are updated to
- *   the actual capabilities of the created QP.
- * @udata: User data
- * @uobj: uverbs obect
- * @caller: caller's build-time module name
- */
-struct ib_qp *_ib_create_qp(struct ib_device *dev, struct ib_pd *pd,
-			    struct ib_qp_init_attr *attr,
-			    struct ib_udata *udata, struct ib_uqp_object *uobj,
-			    const char *caller)
+static struct ib_qp *create_qp(struct ib_device *dev, struct ib_pd *pd,
+			       struct ib_qp_init_attr *attr,
+			       struct ib_udata *udata,
+			       struct ib_uqp_object *uobj, const char *caller)
 {
 	struct ib_udata dummy = {};
 	struct ib_qp *qp;
@@ -1273,7 +1262,44 @@ struct ib_qp *_ib_create_qp(struct ib_device *dev, struct ib_pd *pd,
 	return ERR_PTR(ret);
 
 }
-EXPORT_SYMBOL(_ib_create_qp);
+
+/**
+ * ib_create_qp_user - Creates a QP associated with the specified protection
+ *   domain.
+ * @dev: IB device
+ * @pd: The protection domain associated with the QP.
+ * @attr: A list of initial attributes required to create the
+ *   QP.  If QP creation succeeds, then the attributes are updated to
+ *   the actual capabilities of the created QP.
+ * @udata: User data
+ * @uobj: uverbs obect
+ * @caller: caller's build-time module name
+ */
+struct ib_qp *ib_create_qp_user(struct ib_device *dev, struct ib_pd *pd,
+				struct ib_qp_init_attr *attr,
+				struct ib_udata *udata,
+				struct ib_uqp_object *uobj, const char *caller)
+{
+	struct ib_uqp_object *obj = uobj;
+	struct ib_qp *qp, *xrc_qp;
+
+	if (attr->qp_type == IB_QPT_XRC_TGT)
+		obj = NULL;
+
+	qp = create_qp(dev, pd, attr, udata, obj, caller);
+	if (attr->qp_type != IB_QPT_XRC_TGT || IS_ERR(qp))
+		return qp;
+
+	xrc_qp = create_xrc_qp_user(qp, attr);
+	if (IS_ERR(xrc_qp)) {
+		ib_destroy_qp(qp);
+		return xrc_qp;
+	}
+
+	xrc_qp->uobject = uobj;
+	return xrc_qp;
+}
+EXPORT_SYMBOL(ib_create_qp_user);
 
 void ib_qp_usecnt_inc(struct ib_qp *qp)
 {
@@ -1318,7 +1344,7 @@ struct ib_qp *ib_create_qp_kernel(struct ib_pd *pd,
 				  struct ib_qp_init_attr *qp_init_attr,
 				  const char *caller)
 {
-	struct ib_device *device = pd ? pd->device : qp_init_attr->xrcd->device;
+	struct ib_device *device = pd->device;
 	struct ib_qp *qp;
 	int ret;
 
@@ -1331,21 +1357,10 @@ struct ib_qp *ib_create_qp_kernel(struct ib_pd *pd,
 	if (qp_init_attr->cap.max_rdma_ctxs)
 		rdma_rw_init_qp(device, qp_init_attr);
 
-	qp = _ib_create_qp(device, pd, qp_init_attr, NULL, NULL, caller);
+	qp = create_qp(device, pd, qp_init_attr, NULL, NULL, caller);
 	if (IS_ERR(qp))
 		return qp;
 
-	if (qp_init_attr->qp_type == IB_QPT_XRC_TGT) {
-		struct ib_qp *xrc_qp =
-			create_xrc_qp_user(qp, qp_init_attr);
-
-		if (IS_ERR(xrc_qp)) {
-			ret = PTR_ERR(xrc_qp);
-			goto err;
-		}
-		return xrc_qp;
-	}
-
 	ib_qp_usecnt_inc(qp);
 
 	if (qp_init_attr->cap.max_rdma_ctxs) {
-- 
2.31.1

