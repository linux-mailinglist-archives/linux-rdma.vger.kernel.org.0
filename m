Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4D91273E37
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Sep 2020 11:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgIVJLc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Sep 2020 05:11:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:60220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726424AbgIVJLc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Sep 2020 05:11:32 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEE7F208A9;
        Tue, 22 Sep 2020 09:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600765889;
        bh=XAirzzFlBgG/HxM+ET0lJD9iBsabVM34w4RN3vrr3cs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KJ6GuZIvKOpjvF/Z6WaXwTMe/oJLn8tvccLxsz8nIPUVh7dGCleWwjNEkFs8K3q8o
         bBlxG1qv6ooohCI/UF5dgf/bhPHbe54U8grVezPpOUeue8RQYjOPJ7JFFjB5knNAV6
         CcvDbF1jTwiCNbm5ypnsfoLigrqxVSPRSAW8bFP4=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v3 5/5] RDMA/restrack: Improve readability in task name management
Date:   Tue, 22 Sep 2020 12:11:06 +0300
Message-Id: <20200922091106.2152715-6-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200922091106.2152715-1-leon@kernel.org>
References: <20200922091106.2152715-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Reduce ambiguity in interfaces to set resource names and manage
struct task reference counters.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cma.c                 | 134 ++++++++++++------
 drivers/infiniband/core/core_priv.h           |  12 +-
 drivers/infiniband/core/counters.c            |   9 +-
 drivers/infiniband/core/cq.c                  |   2 +-
 drivers/infiniband/core/restrack.c            |  73 +++++-----
 drivers/infiniband/core/restrack.h            |   6 +-
 drivers/infiniband/core/ucma.c                |   7 +-
 drivers/infiniband/core/uverbs_cmd.c          |  14 +-
 drivers/infiniband/core/uverbs_std_types_cq.c |   4 +-
 drivers/infiniband/core/verbs.c               |  10 +-
 include/rdma/rdma_cm.h                        |  47 ++----
 include/rdma/restrack.h                       |  13 +-
 12 files changed, 172 insertions(+), 159 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 99a8d61bcbb2..6419b798cd2e 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -453,10 +453,8 @@ static void _cma_attach_to_dev(struct rdma_id_private *id_priv,
 	id_priv->id.route.addr.dev_addr.transport =
 		rdma_node_get_transport(cma_dev->device->node_type);
 	list_add_tail(&id_priv->list, &cma_dev->id_list);
-	if (id_priv->res.kern_name)
-		rdma_restrack_add(&id_priv->res);
-	else
-		rdma_restrack_uadd(&id_priv->res);
+	rdma_restrack_add(&id_priv->res);
+
 	trace_cm_id_attach(id_priv, cma_dev->device);
 }
 
@@ -822,10 +820,10 @@ static void cma_id_put(struct rdma_id_private *id_priv)
 		complete(&id_priv->comp);
 }
 
-struct rdma_cm_id *__rdma_create_id(struct net *net,
-				    rdma_cm_event_handler event_handler,
-				    void *context, enum rdma_ucm_port_space ps,
-				    enum ib_qp_type qp_type, const char *caller)
+static struct rdma_id_private *
+__rdma_create_id(struct net *net, rdma_cm_event_handler event_handler,
+		 void *context, enum rdma_ucm_port_space ps,
+		 enum ib_qp_type qp_type, const struct rdma_id_private *parent)
 {
 	struct rdma_id_private *id_priv;
 
@@ -853,11 +851,44 @@ struct rdma_cm_id *__rdma_create_id(struct net *net,
 	id_priv->seq_num &= 0x00ffffff;
 
 	rdma_restrack_new(&id_priv->res, RDMA_RESTRACK_CM_ID);
-	rdma_restrack_set_task(&id_priv->res, caller);
+	if (parent)
+		rdma_restrack_parent_name(&id_priv->res, &parent->res);
 
-	return &id_priv->id;
+	return id_priv;
+}
+
+struct rdma_cm_id *
+__rdma_create_kernel_id(struct net *net, rdma_cm_event_handler event_handler,
+			void *context, enum rdma_ucm_port_space ps,
+			enum ib_qp_type qp_type, const char *caller)
+{
+	struct rdma_id_private *ret;
+
+	ret = __rdma_create_id(net, event_handler, context, ps, qp_type, NULL);
+	if (IS_ERR(ret))
+		return ERR_CAST(ret);
+
+	rdma_restrack_set_name(&ret->res, caller);
+	return &ret->id;
+}
+EXPORT_SYMBOL(__rdma_create_kernel_id);
+
+struct rdma_cm_id *rdma_create_user_id(rdma_cm_event_handler event_handler,
+				       void *context,
+				       enum rdma_ucm_port_space ps,
+				       enum ib_qp_type qp_type)
+{
+	struct rdma_id_private *ret;
+
+	ret = __rdma_create_id(current->nsproxy->net_ns, event_handler, context,
+			       ps, qp_type, NULL);
+	if (IS_ERR(ret))
+		return ERR_CAST(ret);
+
+	rdma_restrack_set_name(&ret->res, NULL);
+	return &ret->id;
 }
-EXPORT_SYMBOL(__rdma_create_id);
+EXPORT_SYMBOL(rdma_create_user_id);
 
 static int cma_init_ud_qp(struct rdma_id_private *id_priv, struct ib_qp *qp)
 {
@@ -2029,14 +2060,15 @@ cma_ib_new_conn_id(const struct rdma_cm_id *listen_id,
 	int ret;
 
 	listen_id_priv = container_of(listen_id, struct rdma_id_private, id);
-	id = __rdma_create_id(listen_id->route.addr.dev_addr.net,
-			    listen_id->event_handler, listen_id->context,
-			    listen_id->ps, ib_event->param.req_rcvd.qp_type,
-			    listen_id_priv->res.kern_name);
-	if (IS_ERR(id))
+	id_priv = __rdma_create_id(listen_id->route.addr.dev_addr.net,
+				   listen_id->event_handler, listen_id->context,
+				   listen_id->ps,
+				   ib_event->param.req_rcvd.qp_type,
+				   listen_id_priv);
+	if (IS_ERR(id_priv))
 		return NULL;
 
-	id_priv = container_of(id, struct rdma_id_private, id);
+	id = &id_priv->id;
 	if (cma_save_net_info((struct sockaddr *)&id->route.addr.src_addr,
 			      (struct sockaddr *)&id->route.addr.dst_addr,
 			      listen_id, ib_event, ss_family, service_id))
@@ -2090,13 +2122,13 @@ cma_ib_new_udp_id(const struct rdma_cm_id *listen_id,
 	int ret;
 
 	listen_id_priv = container_of(listen_id, struct rdma_id_private, id);
-	id = __rdma_create_id(net, listen_id->event_handler, listen_id->context,
-			      listen_id->ps, IB_QPT_UD,
-			      listen_id_priv->res.kern_name);
-	if (IS_ERR(id))
+	id_priv = __rdma_create_id(net, listen_id->event_handler,
+				   listen_id->context, listen_id->ps, IB_QPT_UD,
+				   listen_id_priv);
+	if (IS_ERR(id_priv))
 		return NULL;
 
-	id_priv = container_of(id, struct rdma_id_private, id);
+	id = &id_priv->id;
 	if (cma_save_net_info((struct sockaddr *)&id->route.addr.src_addr,
 			      (struct sockaddr *)&id->route.addr.dst_addr,
 			      listen_id, ib_event, ss_family,
@@ -2332,7 +2364,6 @@ static int cma_iw_handler(struct iw_cm_id *iw_id, struct iw_cm_event *iw_event)
 static int iw_conn_req_handler(struct iw_cm_id *cm_id,
 			       struct iw_cm_event *iw_event)
 {
-	struct rdma_cm_id *new_cm_id;
 	struct rdma_id_private *listen_id, *conn_id;
 	struct rdma_cm_event event = {};
 	int ret = -ECONNABORTED;
@@ -2352,16 +2383,14 @@ static int iw_conn_req_handler(struct iw_cm_id *cm_id,
 		goto out;
 
 	/* Create a new RDMA id for the new IW CM ID */
-	new_cm_id = __rdma_create_id(listen_id->id.route.addr.dev_addr.net,
-				     listen_id->id.event_handler,
-				     listen_id->id.context,
-				     RDMA_PS_TCP, IB_QPT_RC,
-				     listen_id->res.kern_name);
-	if (IS_ERR(new_cm_id)) {
+	conn_id = __rdma_create_id(listen_id->id.route.addr.dev_addr.net,
+				   listen_id->id.event_handler,
+				   listen_id->id.context, RDMA_PS_TCP,
+				   IB_QPT_RC, listen_id);
+	if (IS_ERR(conn_id)) {
 		ret = -ENOMEM;
 		goto out;
 	}
-	conn_id = container_of(new_cm_id, struct rdma_id_private, id);
 	mutex_lock_nested(&conn_id->handler_mutex, SINGLE_DEPTH_NESTING);
 	conn_id->state = RDMA_CM_CONNECT;
 
@@ -2466,7 +2495,6 @@ static void cma_listen_on_dev(struct rdma_id_private *id_priv,
 			      struct cma_device *cma_dev)
 {
 	struct rdma_id_private *dev_id_priv;
-	struct rdma_cm_id *id;
 	struct net *net = id_priv->id.route.addr.dev_addr.net;
 	int ret;
 
@@ -2475,13 +2503,12 @@ static void cma_listen_on_dev(struct rdma_id_private *id_priv,
 	if (cma_family(id_priv) == AF_IB && !rdma_cap_ib_cm(cma_dev->device, 1))
 		return;
 
-	id = __rdma_create_id(net, cma_listen_handler, id_priv, id_priv->id.ps,
-			      id_priv->id.qp_type, id_priv->res.kern_name);
-	if (IS_ERR(id))
+	dev_id_priv =
+		__rdma_create_id(net, cma_listen_handler, id_priv,
+				 id_priv->id.ps, id_priv->id.qp_type, id_priv);
+	if (IS_ERR(dev_id_priv))
 		return;
 
-	dev_id_priv = container_of(id, struct rdma_id_private, id);
-
 	dev_id_priv->state = RDMA_CM_ADDR_BOUND;
 	memcpy(cma_src_addr(dev_id_priv), cma_src_addr(id_priv),
 	       rdma_addr_size(cma_src_addr(id_priv)));
@@ -2494,7 +2521,7 @@ static void cma_listen_on_dev(struct rdma_id_private *id_priv,
 	dev_id_priv->tos_set = id_priv->tos_set;
 	dev_id_priv->tos = id_priv->tos;
 
-	ret = rdma_listen(id, id_priv->backlog);
+	ret = rdma_listen(&dev_id_priv->id, id_priv->backlog);
 	if (ret)
 		dev_warn(&cma_dev->device->dev,
 			 "RDMA CMA: cma_listen_on_dev, error %d\n", ret);
@@ -4149,8 +4176,25 @@ static int cma_send_sidr_rep(struct rdma_id_private *id_priv,
 	return ib_send_cm_sidr_rep(id_priv->cm_id.ib, &rep);
 }
 
-int __rdma_accept(struct rdma_cm_id *id, struct rdma_conn_param *conn_param,
-		  const char *caller)
+/**
+ * rdma_accept - Called to accept a connection request or response.
+ * @id: Connection identifier associated with the request.
+ * @conn_param: Information needed to establish the connection.  This must be
+ *   provided if accepting a connection request.  If accepting a connection
+ *   response, this parameter must be NULL.
+ *
+ * Typically, this routine is only called by the listener to accept a connection
+ * request.  It must also be called on the active side of a connection if the
+ * user is performing their own QP transitions.
+ *
+ * In the case of error, a reject message is sent to the remote side and the
+ * state of the qp associated with the id is modified to error, such that any
+ * previously posted receive buffers would be flushed.
+ *
+ * This function is for use by kernel ULPs and must be called from under the
+ * handler callback.
+ */
+int rdma_accept(struct rdma_cm_id *id, struct rdma_conn_param *conn_param)
 {
 	struct rdma_id_private *id_priv =
 		container_of(id, struct rdma_id_private, id);
@@ -4158,8 +4202,6 @@ int __rdma_accept(struct rdma_cm_id *id, struct rdma_conn_param *conn_param,
 
 	lockdep_assert_held(&id_priv->handler_mutex);
 
-	rdma_restrack_set_task(&id_priv->res, caller);
-
 	if (READ_ONCE(id_priv->state) != RDMA_CM_CONNECT)
 		return -EINVAL;
 
@@ -4198,10 +4240,10 @@ int __rdma_accept(struct rdma_cm_id *id, struct rdma_conn_param *conn_param,
 	rdma_reject(id, NULL, 0, IB_CM_REJ_CONSUMER_DEFINED);
 	return ret;
 }
-EXPORT_SYMBOL(__rdma_accept);
+EXPORT_SYMBOL(rdma_accept);
 
-int __rdma_accept_ece(struct rdma_cm_id *id, struct rdma_conn_param *conn_param,
-		      const char *caller, struct rdma_ucm_ece *ece)
+int rdma_accept_ece(struct rdma_cm_id *id, struct rdma_conn_param *conn_param,
+		    struct rdma_ucm_ece *ece)
 {
 	struct rdma_id_private *id_priv =
 		container_of(id, struct rdma_id_private, id);
@@ -4209,9 +4251,9 @@ int __rdma_accept_ece(struct rdma_cm_id *id, struct rdma_conn_param *conn_param,
 	id_priv->ece.vendor_id = ece->vendor_id;
 	id_priv->ece.attr_mod = ece->attr_mod;
 
-	return __rdma_accept(id, conn_param, caller);
+	return rdma_accept(id, conn_param);
 }
-EXPORT_SYMBOL(__rdma_accept_ece);
+EXPORT_SYMBOL(rdma_accept_ece);
 
 void rdma_lock_handler(struct rdma_cm_id *id)
 {
diff --git a/drivers/infiniband/core/core_priv.h b/drivers/infiniband/core/core_priv.h
index cf5a50cefa39..e84b0fedaacb 100644
--- a/drivers/infiniband/core/core_priv.h
+++ b/drivers/infiniband/core/core_priv.h
@@ -361,15 +361,9 @@ static inline struct ib_qp *_ib_create_qp(struct ib_device *dev,
 	 */
 	is_xrc = qp_type == IB_QPT_XRC_INI || qp_type == IB_QPT_XRC_TGT;
 	if ((qp_type < IB_QPT_MAX && !is_xrc) || qp_type == IB_QPT_DRIVER) {
-		if (uobj)
-			rdma_restrack_uadd(&qp->res);
-		else {
-			rdma_restrack_set_task(&qp->res, pd->res.kern_name);
-			rdma_restrack_add(&qp->res);
-		}
-	} else
-		qp->res.valid = false;
-
+		rdma_restrack_parent_name(&qp->res, &pd->res);
+		rdma_restrack_add(&qp->res);
+	}
 	return qp;
 }
 
diff --git a/drivers/infiniband/core/counters.c b/drivers/infiniband/core/counters.c
index e13c500a9ec0..e4ff0d3328b6 100644
--- a/drivers/infiniband/core/counters.c
+++ b/drivers/infiniband/core/counters.c
@@ -250,13 +250,8 @@ static struct rdma_counter *rdma_get_counter_auto_mode(struct ib_qp *qp,
 static void rdma_counter_res_add(struct rdma_counter *counter,
 				 struct ib_qp *qp)
 {
-	if (rdma_is_kernel_res(&qp->res)) {
-		rdma_restrack_set_task(&counter->res, qp->res.kern_name);
-		rdma_restrack_add(&counter->res);
-	} else {
-		rdma_restrack_attach_task(&counter->res, qp->res.task);
-		rdma_restrack_uadd(&counter->res);
-	}
+	rdma_restrack_parent_name(&counter->res, &qp->res);
+	rdma_restrack_add(&counter->res);
 }
 
 static void counter_release(struct kref *kref)
diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
index 620cf7c2696d..12ebacf52958 100644
--- a/drivers/infiniband/core/cq.c
+++ b/drivers/infiniband/core/cq.c
@@ -236,7 +236,7 @@ struct ib_cq *__ib_alloc_cq(struct ib_device *dev, void *private, int nr_cqe,
 		goto out_free_cq;
 
 	rdma_restrack_new(&cq->res, RDMA_RESTRACK_CQ);
-	rdma_restrack_set_task(&cq->res, caller);
+	rdma_restrack_set_name(&cq->res, caller);
 
 	ret = dev->ops.create_cq(cq, &cq_attr, NULL);
 	if (ret)
diff --git a/drivers/infiniband/core/restrack.c b/drivers/infiniband/core/restrack.c
index 88d3852676a9..4aeeaaed0f17 100644
--- a/drivers/infiniband/core/restrack.c
+++ b/drivers/infiniband/core/restrack.c
@@ -147,34 +147,56 @@ static struct ib_device *res_to_dev(struct rdma_restrack_entry *res)
 	}
 }
 
-void rdma_restrack_set_task(struct rdma_restrack_entry *res,
-			    const char *caller)
+/**
+ * rdma_restrack_attach_task() - attach the task onto this resource,
+ * valid for user space restrack entries.
+ * @res:  resource entry
+ * @task: the task to attach
+ */
+static void rdma_restrack_attach_task(struct rdma_restrack_entry *res,
+				      struct task_struct *task)
 {
-	if (caller) {
-		res->kern_name = caller;
+	if (WARN_ON_ONCE(!task))
 		return;
-	}
 
 	if (res->task)
 		put_task_struct(res->task);
-	get_task_struct(current);
-	res->task = current;
+	get_task_struct(task);
+	res->task = task;
+	res->user = true;
 }
-EXPORT_SYMBOL(rdma_restrack_set_task);
 
 /**
- * rdma_restrack_attach_task() - attach the task onto this resource
+ * rdma_restrack_set_name() - set the task for this resource
  * @res:  resource entry
- * @task: the task to attach, the current task will be used if it is NULL.
+ * @caller: kernel name, the current task will be used if the caller is NULL.
  */
-void rdma_restrack_attach_task(struct rdma_restrack_entry *res,
-			       struct task_struct *task)
+void rdma_restrack_set_name(struct rdma_restrack_entry *res, const char *caller)
 {
-	if (res->task)
-		put_task_struct(res->task);
-	get_task_struct(task);
-	res->task = task;
+	if (caller) {
+		res->kern_name = caller;
+		return;
+	}
+
+	rdma_restrack_attach_task(res, current);
+}
+EXPORT_SYMBOL(rdma_restrack_set_name);
+
+/**
+ * rdma_restrack_parent_name() - set the restrack name properties based
+ * on parent restrack
+ * @dst: destination resource entry
+ * @parent: parent resource entry
+ */
+void rdma_restrack_parent_name(struct rdma_restrack_entry *dst,
+			       const struct rdma_restrack_entry *parent)
+{
+	if (rdma_is_kernel_res(parent))
+		dst->kern_name = parent->kern_name;
+	else
+		rdma_restrack_attach_task(dst, parent->task);
 }
+EXPORT_SYMBOL(rdma_restrack_parent_name);
 
 /**
  * rdma_restrack_new() - Initializes new restrack entry to allow _put() interface
@@ -229,25 +251,6 @@ void rdma_restrack_add(struct rdma_restrack_entry *res)
 }
 EXPORT_SYMBOL(rdma_restrack_add);
 
-/**
- * rdma_restrack_uadd() - add user object to the reource tracking database
- * @res:  resource entry
- */
-void rdma_restrack_uadd(struct rdma_restrack_entry *res)
-{
-	if ((res->type != RDMA_RESTRACK_CM_ID) &&
-	    (res->type != RDMA_RESTRACK_COUNTER))
-		res->task = NULL;
-
-	if (!res->task)
-		rdma_restrack_set_task(res, NULL);
-	res->kern_name = NULL;
-
-	res->user = true;
-	rdma_restrack_add(res);
-}
-EXPORT_SYMBOL(rdma_restrack_uadd);
-
 int __must_check rdma_restrack_get(struct rdma_restrack_entry *res)
 {
 	return kref_get_unless_zero(&res->kref);
diff --git a/drivers/infiniband/core/restrack.h b/drivers/infiniband/core/restrack.h
index d35c4c41d2ff..6a04fc41f738 100644
--- a/drivers/infiniband/core/restrack.h
+++ b/drivers/infiniband/core/restrack.h
@@ -29,6 +29,8 @@ void rdma_restrack_add(struct rdma_restrack_entry *res);
 void rdma_restrack_del(struct rdma_restrack_entry *res);
 void rdma_restrack_new(struct rdma_restrack_entry *res,
 		       enum rdma_restrack_type type);
-void rdma_restrack_attach_task(struct rdma_restrack_entry *res,
-			       struct task_struct *task);
+void rdma_restrack_set_name(struct rdma_restrack_entry *res,
+			    const char *caller);
+void rdma_restrack_parent_name(struct rdma_restrack_entry *dst,
+			       const struct rdma_restrack_entry *parent);
 #endif /* _RDMA_CORE_RESTRACK_H_ */
diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
index b3a7dbb12f25..08a628246bd6 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -456,8 +456,7 @@ static ssize_t ucma_create_id(struct ucma_file *file, const char __user *inbuf,
 		return -ENOMEM;
 
 	ctx->uid = cmd.uid;
-	cm_id = __rdma_create_id(current->nsproxy->net_ns,
-				 ucma_event_handler, ctx, cmd.ps, qp_type, NULL);
+	cm_id = rdma_create_user_id(ucma_event_handler, ctx, cmd.ps, qp_type);
 	if (IS_ERR(cm_id)) {
 		ret = PTR_ERR(cm_id);
 		goto err1;
@@ -1126,7 +1125,7 @@ static ssize_t ucma_accept(struct ucma_file *file, const char __user *inbuf,
 		ucma_copy_conn_param(ctx->cm_id, &conn_param, &cmd.conn_param);
 		mutex_lock(&ctx->mutex);
 		rdma_lock_handler(ctx->cm_id);
-		ret = __rdma_accept_ece(ctx->cm_id, &conn_param, NULL, &ece);
+		ret = rdma_accept_ece(ctx->cm_id, &conn_param, &ece);
 		if (!ret) {
 			/* The uid must be set atomically with the handler */
 			ctx->uid = cmd.uid;
@@ -1136,7 +1135,7 @@ static ssize_t ucma_accept(struct ucma_file *file, const char __user *inbuf,
 	} else {
 		mutex_lock(&ctx->mutex);
 		rdma_lock_handler(ctx->cm_id);
-		ret = __rdma_accept_ece(ctx->cm_id, NULL, NULL, &ece);
+		ret = rdma_accept_ece(ctx->cm_id, NULL, &ece);
 		rdma_unlock_handler(ctx->cm_id);
 		mutex_unlock(&ctx->mutex);
 	}
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 6ddd26548da8..7b8d6b3409d5 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -223,6 +223,7 @@ int ib_alloc_ucontext(struct uverbs_attr_bundle *attrs)
 	xa_init_flags(&ucontext->mmap_xa, XA_FLAGS_ALLOC);
 
 	rdma_restrack_new(&ucontext->res, RDMA_RESTRACK_CTX);
+	rdma_restrack_set_name(&ucontext->res, NULL);
 	attrs->context = ucontext;
 	return 0;
 }
@@ -251,7 +252,7 @@ int ib_init_ucontext(struct uverbs_attr_bundle *attrs)
 	if (ret)
 		goto err_uncharge;
 
-	rdma_restrack_uadd(&ucontext->res);
+	rdma_restrack_add(&ucontext->res);
 
 	/*
 	 * Make sure that ib_uverbs_get_ucontext() sees the pointer update
@@ -443,10 +444,12 @@ static int ib_uverbs_alloc_pd(struct uverbs_attr_bundle *attrs)
 	atomic_set(&pd->usecnt, 0);
 
 	rdma_restrack_new(&pd->res, RDMA_RESTRACK_PD);
+	rdma_restrack_set_name(&pd->res, NULL);
+
 	ret = ib_dev->ops.alloc_pd(pd, &attrs->driver_udata);
 	if (ret)
 		goto err_alloc;
-	rdma_restrack_uadd(&pd->res);
+	rdma_restrack_add(&pd->res);
 
 	uobj->object = pd;
 	uobj_finalize_uobj_create(uobj, attrs);
@@ -748,7 +751,8 @@ static int ib_uverbs_reg_mr(struct uverbs_attr_bundle *attrs)
 	mr->iova = cmd.hca_va;
 
 	rdma_restrack_new(&mr->res, RDMA_RESTRACK_MR);
-	rdma_restrack_uadd(&mr->res);
+	rdma_restrack_set_name(&mr->res, NULL);
+	rdma_restrack_add(&mr->res);
 
 	uobj->object = mr;
 	uobj_put_obj_read(pd);
@@ -1008,10 +1012,12 @@ static int create_cq(struct uverbs_attr_bundle *attrs,
 	atomic_set(&cq->usecnt, 0);
 
 	rdma_restrack_new(&cq->res, RDMA_RESTRACK_CQ);
+	rdma_restrack_set_name(&cq->res, NULL);
+
 	ret = ib_dev->ops.create_cq(cq, &attr, &attrs->driver_udata);
 	if (ret)
 		goto err_free;
-	rdma_restrack_uadd(&cq->res);
+	rdma_restrack_add(&cq->res);
 
 	obj->uevent.uobject.object = cq;
 	obj->uevent.event_file = READ_ONCE(attrs->ufile->default_async_file);
diff --git a/drivers/infiniband/core/uverbs_std_types_cq.c b/drivers/infiniband/core/uverbs_std_types_cq.c
index 3a5fd6c9ba72..8dabd05988b2 100644
--- a/drivers/infiniband/core/uverbs_std_types_cq.c
+++ b/drivers/infiniband/core/uverbs_std_types_cq.c
@@ -126,13 +126,15 @@ static int UVERBS_HANDLER(UVERBS_METHOD_CQ_CREATE)(
 	atomic_set(&cq->usecnt, 0);
 
 	rdma_restrack_new(&cq->res, RDMA_RESTRACK_CQ);
+	rdma_restrack_set_name(&cq->res, NULL);
+
 	ret = ib_dev->ops.create_cq(cq, &attr, &attrs->driver_udata);
 	if (ret)
 		goto err_free;
 
 	obj->uevent.uobject.object = cq;
 	obj->uevent.uobject.user_handle = user_handle;
-	rdma_restrack_uadd(&cq->res);
+	rdma_restrack_add(&cq->res);
 	uverbs_finalize_uobj_create(attrs, UVERBS_ATTR_CREATE_CQ_HANDLE);
 
 	ret = uverbs_copy_to(attrs, UVERBS_ATTR_CREATE_CQ_RESP_CQE, &cq->cqe,
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 8117e551a866..53dd8284260a 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -273,7 +273,7 @@ struct ib_pd *__ib_alloc_pd(struct ib_device *device, unsigned int flags,
 	pd->flags = flags;
 
 	rdma_restrack_new(&pd->res, RDMA_RESTRACK_PD);
-	rdma_restrack_set_task(&pd->res, caller);
+	rdma_restrack_set_name(&pd->res, caller);
 
 	ret = device->ops.alloc_pd(pd, NULL);
 	if (ret) {
@@ -1999,7 +1999,7 @@ struct ib_cq *__ib_create_cq(struct ib_device *device,
 	atomic_set(&cq->usecnt, 0);
 
 	rdma_restrack_new(&cq->res, RDMA_RESTRACK_CQ);
-	rdma_restrack_set_task(&cq->res, caller);
+	rdma_restrack_set_name(&cq->res, caller);
 
 	ret = device->ops.create_cq(cq, cq_attr, NULL);
 	if (ret) {
@@ -2081,7 +2081,7 @@ struct ib_mr *ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 	atomic_inc(&pd->usecnt);
 
 	rdma_restrack_new(&mr->res, RDMA_RESTRACK_MR);
-	rdma_restrack_set_task(&mr->res, pd->res.kern_name);
+	rdma_restrack_parent_name(&mr->res, &pd->res);
 	rdma_restrack_add(&mr->res);
 
 	return mr;
@@ -2165,7 +2165,7 @@ struct ib_mr *ib_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
 	mr->sig_attrs = NULL;
 
 	rdma_restrack_new(&mr->res, RDMA_RESTRACK_MR);
-	rdma_restrack_set_task(&mr->res, pd->res.kern_name);
+	rdma_restrack_parent_name(&mr->res, &pd->res);
 	rdma_restrack_add(&mr->res);
 out:
 	trace_mr_alloc(pd, mr_type, max_num_sg, mr);
@@ -2226,7 +2226,7 @@ struct ib_mr *ib_alloc_mr_integrity(struct ib_pd *pd,
 	mr->sig_attrs = sig_attrs;
 
 	rdma_restrack_new(&mr->res, RDMA_RESTRACK_MR);
-	rdma_restrack_set_task(&mr->res, pd->res.kern_name);
+	rdma_restrack_parent_name(&mr->res, &pd->res);
 	rdma_restrack_add(&mr->res);
 out:
 	trace_mr_integ_alloc(pd, max_num_data_sg, max_num_meta_sg, mr);
diff --git a/include/rdma/rdma_cm.h b/include/rdma/rdma_cm.h
index c1334c9a7aa8..c672ae1da26b 100644
--- a/include/rdma/rdma_cm.h
+++ b/include/rdma/rdma_cm.h
@@ -110,11 +110,14 @@ struct rdma_cm_id {
 	u8			 port_num;
 };
 
-struct rdma_cm_id *__rdma_create_id(struct net *net,
-				    rdma_cm_event_handler event_handler,
-				    void *context, enum rdma_ucm_port_space ps,
-				    enum ib_qp_type qp_type,
-				    const char *caller);
+struct rdma_cm_id *
+__rdma_create_kernel_id(struct net *net, rdma_cm_event_handler event_handler,
+			void *context, enum rdma_ucm_port_space ps,
+			enum ib_qp_type qp_type, const char *caller);
+struct rdma_cm_id *rdma_create_user_id(rdma_cm_event_handler event_handler,
+				       void *context,
+				       enum rdma_ucm_port_space ps,
+				       enum ib_qp_type qp_type);
 
 /**
  * rdma_create_id - Create an RDMA identifier.
@@ -132,9 +135,9 @@ struct rdma_cm_id *__rdma_create_id(struct net *net,
  * The event handler callback serializes on the id's mutex and is
  * allowed to sleep.
  */
-#define rdma_create_id(net, event_handler, context, ps, qp_type) \
-	__rdma_create_id((net), (event_handler), (context), (ps), (qp_type), \
-			 KBUILD_MODNAME)
+#define rdma_create_id(net, event_handler, context, ps, qp_type)               \
+	__rdma_create_kernel_id(net, event_handler, context, ps, qp_type,      \
+				KBUILD_MODNAME)
 
 /**
   * rdma_destroy_id - Destroys an RDMA identifier.
@@ -250,34 +253,12 @@ int rdma_connect_ece(struct rdma_cm_id *id, struct rdma_conn_param *conn_param,
  */
 int rdma_listen(struct rdma_cm_id *id, int backlog);
 
-int __rdma_accept(struct rdma_cm_id *id, struct rdma_conn_param *conn_param,
-		  const char *caller);
+int rdma_accept(struct rdma_cm_id *id, struct rdma_conn_param *conn_param);
 
 void rdma_lock_handler(struct rdma_cm_id *id);
 void rdma_unlock_handler(struct rdma_cm_id *id);
-int __rdma_accept_ece(struct rdma_cm_id *id, struct rdma_conn_param *conn_param,
-		      const char *caller, struct rdma_ucm_ece *ece);
-
-/**
- * rdma_accept - Called to accept a connection request or response.
- * @id: Connection identifier associated with the request.
- * @conn_param: Information needed to establish the connection.  This must be
- *   provided if accepting a connection request.  If accepting a connection
- *   response, this parameter must be NULL.
- *
- * Typically, this routine is only called by the listener to accept a connection
- * request.  It must also be called on the active side of a connection if the
- * user is performing their own QP transitions.
- *
- * In the case of error, a reject message is sent to the remote side and the
- * state of the qp associated with the id is modified to error, such that any
- * previously posted receive buffers would be flushed.
- *
- * This function is for use by kernel ULPs and must be called from under the
- * handler callback.
- */
-#define rdma_accept(id, conn_param) \
-	__rdma_accept((id), (conn_param),  KBUILD_MODNAME)
+int rdma_accept_ece(struct rdma_cm_id *id, struct rdma_conn_param *conn_param,
+		    struct rdma_ucm_ece *ece);
 
 /**
  * rdma_notify - Notifies the RDMA CM of an asynchronous event that has
diff --git a/include/rdma/restrack.h b/include/rdma/restrack.h
index db59e208f5e8..d3a1cc5be7bc 100644
--- a/include/rdma/restrack.h
+++ b/include/rdma/restrack.h
@@ -106,14 +106,11 @@ struct rdma_restrack_entry {
 
 int rdma_restrack_count(struct ib_device *dev,
 			enum rdma_restrack_type type);
-
-void rdma_restrack_uadd(struct rdma_restrack_entry *res);
-
 /**
  * rdma_is_kernel_res() - check the owner of resource
  * @res:  resource entry
  */
-static inline bool rdma_is_kernel_res(struct rdma_restrack_entry *res)
+static inline bool rdma_is_kernel_res(const struct rdma_restrack_entry *res)
 {
 	return !res->user;
 }
@@ -130,14 +127,6 @@ int __must_check rdma_restrack_get(struct rdma_restrack_entry *res);
  */
 int rdma_restrack_put(struct rdma_restrack_entry *res);
 
-/**
- * rdma_restrack_set_task() - set the task for this resource
- * @res:  resource entry
- * @caller: kernel name, the current task will be used if the caller is NULL.
- */
-void rdma_restrack_set_task(struct rdma_restrack_entry *res,
-			    const char *caller);
-
 /*
  * Helper functions for rdma drivers when filling out
  * nldev driver attributes.
-- 
2.26.2

