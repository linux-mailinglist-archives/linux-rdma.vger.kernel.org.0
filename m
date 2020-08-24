Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 007DF24FBC9
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Aug 2020 12:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbgHXKot (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Aug 2020 06:44:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:35324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726854AbgHXKol (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 24 Aug 2020 06:44:41 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DF13206B5;
        Mon, 24 Aug 2020 10:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598265879;
        bh=xCPM/qRqgMO+6Iiu1Pk4Xcd8uqt9KT7B+VihQwTkmTk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hAYVa/6xpjcOPncrpkNXvWjoDOTdmFzAvVQVgsftAmBGUVD6HV+8O+MiGHUVuZNJk
         lIukISCosEbD59QYnpDLzxnX+/6qbIdfg/jn9XhYBclJCOLTTkswV5CHmwtl2cZC0f
         +90oSWHosUc4limFY3NsbMdzI9F8gj4snMbK3hmQ=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 06/14] RDMA/restrack: Improve readability in task name management
Date:   Mon, 24 Aug 2020 13:44:07 +0300
Message-Id: <20200824104415.1090901-7-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200824104415.1090901-1-leon@kernel.org>
References: <20200824104415.1090901-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Reduce ambiguity in interfaces to set resource names and manage
struct task reference counters.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cma.c                 | 15 ++--
 drivers/infiniband/core/core_priv.h           | 12 +--
 drivers/infiniband/core/counters.c            |  9 +--
 drivers/infiniband/core/cq.c                  |  2 +-
 drivers/infiniband/core/restrack.c            | 73 ++++++++++---------
 drivers/infiniband/core/restrack.h            |  6 +-
 drivers/infiniband/core/uverbs_cmd.c          | 14 +++-
 drivers/infiniband/core/uverbs_std_types_cq.c |  4 +-
 drivers/infiniband/core/verbs.c               | 10 +--
 include/rdma/restrack.h                       | 11 ---
 10 files changed, 75 insertions(+), 81 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index bf6694287e2e..7e3451fe8309 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -467,10 +467,13 @@ static void _cma_attach_to_dev(struct rdma_id_private *id_priv,
 	id_priv->id.route.addr.dev_addr.transport =
 		rdma_node_get_transport(cma_dev->device->node_type);
 	list_add_tail(&id_priv->list, &cma_dev->id_list);
-	if (id_priv->res.kern_name)
-		rdma_restrack_add(&id_priv->res);
-	else
-		rdma_restrack_uadd(&id_priv->res);
+	/*
+	 * For example UCMA doesn't set kern_name and below function will
+	 * attach to "current" task.
+	 */
+	rdma_restrack_set_name(&id_priv->res, id_priv->res.kern_name);
+	rdma_restrack_add(&id_priv->res);
+
 	trace_cm_id_attach(id_priv, cma_dev->device);
 }
 
@@ -875,7 +878,7 @@ struct rdma_cm_id *__rdma_create_id(struct net *net,
 	id_priv->seq_num &= 0x00ffffff;
 
 	rdma_restrack_new(&id_priv->res, RDMA_RESTRACK_CM_ID);
-	rdma_restrack_set_task(&id_priv->res, caller);
+	rdma_restrack_set_name(&id_priv->res, caller);
 
 	return &id_priv->id;
 }
@@ -4161,7 +4164,7 @@ int __rdma_accept(struct rdma_cm_id *id, struct rdma_conn_param *conn_param,
 
 	lockdep_assert_held(&id_priv->handler_mutex);
 
-	rdma_restrack_set_task(&id_priv->res, caller);
+	rdma_restrack_set_name(&id_priv->res, caller);
 
 	if (READ_ONCE(id_priv->state) != RDMA_CM_CONNECT)
 		return -EINVAL;
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
index e0aa80769143..7959ae3c4e8d 100644
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
index 533729c798f7..6d5dd6cd7315 100644
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
+			       struct rdma_restrack_entry *parent)
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
index d35c4c41d2ff..49c1d84cca2d 100644
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
+			       struct rdma_restrack_entry *parent);
 #endif /* _RDMA_CORE_RESTRACK_H_ */
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 5fbf05ce7ccb..5dd3d72d594d 100644
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
@@ -1000,10 +1004,12 @@ static int create_cq(struct uverbs_attr_bundle *attrs,
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
index f3a94f368a58..77164629baf2 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -273,7 +273,7 @@ struct ib_pd *__ib_alloc_pd(struct ib_device *device, unsigned int flags,
 	pd->flags = flags;
 
 	rdma_restrack_new(&pd->res, RDMA_RESTRACK_PD);
-	rdma_restrack_set_task(&pd->res, caller);
+	rdma_restrack_set_name(&pd->res, caller);
 
 	ret = device->ops.alloc_pd(pd, NULL);
 	if (ret) {
@@ -2002,7 +2002,7 @@ struct ib_cq *__ib_create_cq(struct ib_device *device,
 	atomic_set(&cq->usecnt, 0);
 
 	rdma_restrack_new(&cq->res, RDMA_RESTRACK_CQ);
-	rdma_restrack_set_task(&cq->res, caller);
+	rdma_restrack_set_name(&cq->res, caller);
 
 	ret = device->ops.create_cq(cq, cq_attr, NULL);
 	if (ret) {
@@ -2084,7 +2084,7 @@ struct ib_mr *ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 	atomic_inc(&pd->usecnt);
 
 	rdma_restrack_new(&mr->res, RDMA_RESTRACK_MR);
-	rdma_restrack_set_task(&mr->res, pd->res.kern_name);
+	rdma_restrack_parent_name(&mr->res, &pd->res);
 	rdma_restrack_add(&mr->res);
 
 	return mr;
@@ -2168,7 +2168,7 @@ struct ib_mr *ib_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
 	mr->sig_attrs = NULL;
 
 	rdma_restrack_new(&mr->res, RDMA_RESTRACK_MR);
-	rdma_restrack_set_task(&mr->res, pd->res.kern_name);
+	rdma_restrack_parent_name(&mr->res, &pd->res);
 	rdma_restrack_add(&mr->res);
 out:
 	trace_mr_alloc(pd, mr_type, max_num_sg, mr);
@@ -2229,7 +2229,7 @@ struct ib_mr *ib_alloc_mr_integrity(struct ib_pd *pd,
 	mr->sig_attrs = sig_attrs;
 
 	rdma_restrack_new(&mr->res, RDMA_RESTRACK_MR);
-	rdma_restrack_set_task(&mr->res, pd->res.kern_name);
+	rdma_restrack_parent_name(&mr->res, &pd->res);
 	rdma_restrack_add(&mr->res);
 out:
 	trace_mr_integ_alloc(pd, max_num_data_sg, max_num_meta_sg, mr);
diff --git a/include/rdma/restrack.h b/include/rdma/restrack.h
index db59e208f5e8..10bfed0fcd32 100644
--- a/include/rdma/restrack.h
+++ b/include/rdma/restrack.h
@@ -106,9 +106,6 @@ struct rdma_restrack_entry {
 
 int rdma_restrack_count(struct ib_device *dev,
 			enum rdma_restrack_type type);
-
-void rdma_restrack_uadd(struct rdma_restrack_entry *res);
-
 /**
  * rdma_is_kernel_res() - check the owner of resource
  * @res:  resource entry
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

