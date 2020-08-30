Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D05DA256D4F
	for <lists+linux-rdma@lfdr.de>; Sun, 30 Aug 2020 12:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbgH3KP3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 30 Aug 2020 06:15:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:50150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728779AbgH3KP2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 30 Aug 2020 06:15:28 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED3B62071B;
        Sun, 30 Aug 2020 10:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598782527;
        bh=yGtiKYy84TODuxsgwUj2ix95cFX5fBJYO5ZJk574+wU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2JAqogFEc02mhx1GKR5xS9BYn4ZM22gAH4xGhfXcdjr2GWYmu9/EL4BYQbFFoMw39
         wSCmBZCTIlvaVDVLZi4izmNTS3qasyvQORIFhqmlxxb5y2gXcoPRfUhvyTn9XkvukY
         MeEUxRGlR2Ab04P7+BXMZ2bOWYGAwEHvtiWdYPnw=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org,
        Mark Zhang <markz@nvidia.com>
Subject: [PATCH rdma-next v1 11/13] RDMA/restrack: Support all QP types
Date:   Sun, 30 Aug 2020 13:14:34 +0300
Message-Id: <20200830101436.108487-12-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200830101436.108487-1-leon@kernel.org>
References: <20200830101436.108487-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

The latest changes in restrack name handling allowed to simplify
the QP creation code to support all types of QPs.

For example XRC QP are presented with inbox rdmatool.

[leonro@vm ~]$ ibv_xsrq_pingpong &
[leonro@vm ~]$ rdma res show qp
link ibp0s9/1 lqpn 0 type SMI state RTS sq-psn 0 comm [ib_core]
link ibp0s9/1 lqpn 1 type GSI state RTS sq-psn 0 comm [ib_core]
link ibp0s9/1 lqpn 7 type UD state RTS sq-psn 0 comm [mlx5_ib]
link ibp0s9/1 lqpn 42 type XRC_TGT state INIT sq-psn 0 path-mig-state MIGRATED comm [ib_uverbs]
link ibp0s9/1 lqpn 43 type XRC_INI state INIT sq-psn 0 path-mig-state MIGRATED pdn 197 pid 419 comm ibv_xsrq_pingpong

Reviewed-by: Mark Zhang <markz@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/core_priv.h           | 29 ++++++-------------
 drivers/infiniband/core/uverbs_cmd.c          |  4 +--
 drivers/infiniband/core/uverbs_std_types_qp.c |  4 +--
 drivers/infiniband/core/verbs.c               | 11 +++----
 include/rdma/ib_verbs.h                       | 10 +++++--
 5 files changed, 27 insertions(+), 31 deletions(-)

diff --git a/drivers/infiniband/core/core_priv.h b/drivers/infiniband/core/core_priv.h
index 7f4bb09efab8..3962a54f9178 100644
--- a/drivers/infiniband/core/core_priv.h
+++ b/drivers/infiniband/core/core_priv.h
@@ -318,15 +318,12 @@ struct ib_device *ib_device_get_by_index(const struct net *net, u32 index);
 void nldev_init(void);
 void nldev_exit(void);
 
-static inline struct ib_qp *_ib_create_qp(struct ib_device *dev,
-					  struct ib_pd *pd,
-					  struct ib_qp_init_attr *attr,
-					  struct ib_udata *udata,
-					  struct ib_uqp_object *uobj)
+static inline struct ib_qp *
+_ib_create_qp(struct ib_device *dev, struct ib_pd *pd,
+	      struct ib_qp_init_attr *attr, struct ib_udata *udata,
+	      struct ib_uqp_object *uobj, const char *caller)
 {
-	enum ib_qp_type qp_type = attr->qp_type;
 	struct ib_qp *qp;
-	bool is_xrc;
 	int ret;
 
 	if (!dev->ops.create_qp)
@@ -348,7 +345,6 @@ static inline struct ib_qp *_ib_create_qp(struct ib_device *dev,
 	qp->srq = attr->srq;
 	qp->rwq_ind_tbl = attr->rwq_ind_tbl;
 	qp->event_handler = attr->event_handler;
-	qp->qp_type = attr->qp_type;
 	qp->port = attr->port_num;
 
 	atomic_set(&qp->usecnt, 0);
@@ -357,18 +353,11 @@ static inline struct ib_qp *_ib_create_qp(struct ib_device *dev,
 	INIT_LIST_HEAD(&qp->sig_mrs);
 
 	rdma_restrack_new(&qp->res, RDMA_RESTRACK_QP);
-	/*
-	 * We don't track XRC QPs for now, because they don't have PD
-	 * and more importantly they are created internaly by driver,
-	 * see mlx5 create_dev_resources() as an example.
-	 */
-	is_xrc = qp_type == IB_QPT_XRC_INI || qp_type == IB_QPT_XRC_TGT;
-	if ((qp_type < IB_QPT_MAX && !is_xrc) || qp_type == IB_QPT_DRIVER) {
-		rdma_restrack_parent_name(&qp->res, &pd->res);
-		ret = rdma_restrack_add(&qp->res);
-		if (ret)
-			goto err;
-	}
+	WARN_ONCE(!udata && !caller, "Missing kernel QP owner");
+	rdma_restrack_set_name(&qp->res, udata ? NULL : caller);
+	ret = rdma_restrack_add(&qp->res);
+	if (ret)
+		goto err;
 	return qp;
 err:
 	rdma_restrack_put(&qp->res);
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index d7c532154bbd..432e42b3c931 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -1399,8 +1399,8 @@ static int create_qp(struct uverbs_attr_bundle *attrs,
 	if (cmd->qp_type == IB_QPT_XRC_TGT)
 		qp = ib_create_qp(pd, &attr);
 	else
-		qp = _ib_create_qp(device, pd, &attr, &attrs->driver_udata,
-				   obj);
+		qp = _ib_create_qp(device, pd, &attr, &attrs->driver_udata, obj,
+				   NULL);
 
 	if (IS_ERR(qp)) {
 		ret = PTR_ERR(qp);
diff --git a/drivers/infiniband/core/uverbs_std_types_qp.c b/drivers/infiniband/core/uverbs_std_types_qp.c
index 3bf8dcdfe7eb..198c3cd6f8b9 100644
--- a/drivers/infiniband/core/uverbs_std_types_qp.c
+++ b/drivers/infiniband/core/uverbs_std_types_qp.c
@@ -251,8 +251,8 @@ static int UVERBS_HANDLER(UVERBS_METHOD_QP_CREATE)(
 	if (attr.qp_type == IB_QPT_XRC_TGT)
 		qp = ib_create_qp(pd, &attr);
 	else
-		qp = _ib_create_qp(device, pd, &attr, &attrs->driver_udata,
-				   obj);
+		qp = _ib_create_qp(device, pd, &attr, &attrs->driver_udata, obj,
+				   NULL);
 
 	if (IS_ERR(qp)) {
 		ret = PTR_ERR(qp);
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 07e6f5c10d0e..c0b9bf0563bc 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -1195,7 +1195,7 @@ static struct ib_qp *create_xrc_qp_user(struct ib_qp *qp,
 }
 
 /**
- * ib_create_qp - Creates a kernel QP associated with the specified protection
+ * ib_create_named_qp - Creates a kernel QP associated with the specified protection
  *   domain.
  * @pd: The protection domain associated with the QP.
  * @qp_init_attr: A list of initial attributes required to create the
@@ -1204,8 +1204,9 @@ static struct ib_qp *create_xrc_qp_user(struct ib_qp *qp,
  *
  * NOTE: for user qp use ib_create_qp_user with valid udata!
  */
-struct ib_qp *ib_create_qp(struct ib_pd *pd,
-			   struct ib_qp_init_attr *qp_init_attr)
+struct ib_qp *ib_create_named_qp(struct ib_pd *pd,
+				 struct ib_qp_init_attr *qp_init_attr,
+				 const char *caller)
 {
 	struct ib_device *device = pd ? pd->device : qp_init_attr->xrcd->device;
 	struct ib_qp *qp;
@@ -1230,7 +1231,7 @@ struct ib_qp *ib_create_qp(struct ib_pd *pd,
 	if (qp_init_attr->cap.max_rdma_ctxs)
 		rdma_rw_init_qp(device, qp_init_attr);
 
-	qp = _ib_create_qp(device, pd, qp_init_attr, NULL, NULL);
+	qp = _ib_create_qp(device, pd, qp_init_attr, NULL, NULL, caller);
 	if (IS_ERR(qp))
 		return qp;
 
@@ -1296,7 +1297,7 @@ struct ib_qp *ib_create_qp(struct ib_pd *pd,
 	return ERR_PTR(ret);
 
 }
-EXPORT_SYMBOL(ib_create_qp);
+EXPORT_SYMBOL(ib_create_named_qp);
 
 static const struct {
 	int			valid;
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 25c5180f5a79..8cd368305f05 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -3684,8 +3684,14 @@ static inline int ib_post_srq_recv(struct ib_srq *srq,
 					      bad_recv_wr ? : &dummy);
 }
 
-struct ib_qp *ib_create_qp(struct ib_pd *pd,
-			   struct ib_qp_init_attr *qp_init_attr);
+struct ib_qp *ib_create_named_qp(struct ib_pd *pd,
+				 struct ib_qp_init_attr *qp_init_attr,
+				 const char *caller);
+static inline struct ib_qp *ib_create_qp(struct ib_pd *pd,
+					 struct ib_qp_init_attr *init_attr)
+{
+	return ib_create_named_qp(pd, init_attr, KBUILD_MODNAME);
+}
 
 /**
  * ib_modify_qp_with_udata - Modifies the attributes for the specified QP.
-- 
2.26.2

