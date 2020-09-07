Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52E7E26036B
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Sep 2020 19:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729383AbgIGRtI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Sep 2020 13:49:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:41142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729259AbgIGMWN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 7 Sep 2020 08:22:13 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F1A5215A4;
        Mon,  7 Sep 2020 12:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599481332;
        bh=v8yFt8zhDb317h0c+XINqE4SHgV3XdusoxZatjJIwQM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GHQ2t1WJwJ6qqOUPzoWzjFn4JlIWPBi2k9YGMIigZGpW0IB3bFOGHNF3Y7x5tiMAT
         6TqFDGEM/48Rh3AZgM++hDSmKOcAJtOsQHrhk63rTbVdeKDho7SOlO9ZyyTDVCMtOO
         ZZaGdsxiMUEoA3IlYGhH3eDSKCWtpTQ6lx8shvo4=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v2 04/14] RDMA/restrack: Count references to the verbs objects
Date:   Mon,  7 Sep 2020 15:21:46 +0300
Message-Id: <20200907122156.478360-5-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200907122156.478360-1-leon@kernel.org>
References: <20200907122156.478360-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Refactor the restrack code to make sure that kref inside restrack entry
properly kref the object in which it is embedded. This slight change is
needed for future conversions of MR and QP which are refcounted before
the release and kfree.

The ideal flow from ib_core perspective as follows:
* Allocate ib_* structure with rdma_zalloc_*.
* Set everything that is known to ib_core to that newly created object.
* Initialize kref with restrack help
* Call to driver specific allocation functions.
* Insert into restrack DB
....
* Return and release restrack with restrack_put.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cma.c                 |  5 ++-
 drivers/infiniband/core/core_priv.h           |  3 +-
 drivers/infiniband/core/counters.c            |  6 ++-
 drivers/infiniband/core/cq.c                  |  7 ++--
 drivers/infiniband/core/restrack.c            | 42 ++++++++++++++-----
 drivers/infiniband/core/restrack.h            |  3 ++
 drivers/infiniband/core/uverbs_cmd.c          | 13 ++++--
 drivers/infiniband/core/uverbs_std_types_cq.c |  4 +-
 drivers/infiniband/core/verbs.c               | 18 ++++----
 include/rdma/restrack.h                       |  7 ----
 10 files changed, 70 insertions(+), 38 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 24e09416de4f..a483d906c2e2 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -855,8 +855,6 @@ struct rdma_cm_id *__rdma_create_id(struct net *net,
 	if (!id_priv)
 		return ERR_PTR(-ENOMEM);
 
-	rdma_restrack_set_task(&id_priv->res, caller);
-	id_priv->res.type = RDMA_RESTRACK_CM_ID;
 	id_priv->state = RDMA_CM_IDLE;
 	id_priv->id.context = context;
 	id_priv->id.event_handler = event_handler;
@@ -876,6 +874,9 @@ struct rdma_cm_id *__rdma_create_id(struct net *net,
 	id_priv->id.route.addr.dev_addr.net = get_net(net);
 	id_priv->seq_num &= 0x00ffffff;
 
+	rdma_restrack_new(&id_priv->res, RDMA_RESTRACK_CM_ID);
+	rdma_restrack_set_task(&id_priv->res, caller);
+
 	return &id_priv->id;
 }
 EXPORT_SYMBOL(__rdma_create_id);
diff --git a/drivers/infiniband/core/core_priv.h b/drivers/infiniband/core/core_priv.h
index a1e6a67b2c4a..2ad276cd9781 100644
--- a/drivers/infiniband/core/core_priv.h
+++ b/drivers/infiniband/core/core_priv.h
@@ -44,6 +44,7 @@
 #include <rdma/ib_mad.h>
 #include <rdma/restrack.h>
 #include "mad_priv.h"
+#include "restrack.h"
 
 /* Total number of ports combined across all struct ib_devices's */
 #define RDMA_MAX_PORTS 8192
@@ -352,6 +353,7 @@ static inline struct ib_qp *_ib_create_qp(struct ib_device *dev,
 	INIT_LIST_HEAD(&qp->rdma_mrs);
 	INIT_LIST_HEAD(&qp->sig_mrs);
 
+	rdma_restrack_new(&qp->res, RDMA_RESTRACK_QP);
 	/*
 	 * We don't track XRC QPs for now, because they don't have PD
 	 * and more importantly they are created internaly by driver,
@@ -359,7 +361,6 @@ static inline struct ib_qp *_ib_create_qp(struct ib_device *dev,
 	 */
 	is_xrc = qp_type == IB_QPT_XRC_INI || qp_type == IB_QPT_XRC_TGT;
 	if ((qp_type < IB_QPT_MAX && !is_xrc) || qp_type == IB_QPT_DRIVER) {
-		qp->res.type = RDMA_RESTRACK_QP;
 		if (uobj)
 			rdma_restrack_uadd(&qp->res);
 		else
diff --git a/drivers/infiniband/core/counters.c b/drivers/infiniband/core/counters.c
index 636166880442..c059de99d19c 100644
--- a/drivers/infiniband/core/counters.c
+++ b/drivers/infiniband/core/counters.c
@@ -80,8 +80,9 @@ static struct rdma_counter *rdma_counter_alloc(struct ib_device *dev, u8 port,
 
 	counter->device    = dev;
 	counter->port      = port;
-	counter->res.type  = RDMA_RESTRACK_COUNTER;
-	counter->stats     = dev->ops.counter_alloc_stats(counter);
+
+	rdma_restrack_new(&counter->res, RDMA_RESTRACK_COUNTER);
+	counter->stats = dev->ops.counter_alloc_stats(counter);
 	if (!counter->stats)
 		goto err_stats;
 
@@ -107,6 +108,7 @@ static struct rdma_counter *rdma_counter_alloc(struct ib_device *dev, u8 port,
 	mutex_unlock(&port_counter->lock);
 	kfree(counter->stats);
 err_stats:
+	rdma_restrack_put(&counter->res);
 	kfree(counter);
 	return NULL;
 }
diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
index 11edf7308eac..8bebd29a81bd 100644
--- a/drivers/infiniband/core/cq.c
+++ b/drivers/infiniband/core/cq.c
@@ -235,15 +235,13 @@ struct ib_cq *__ib_alloc_cq(struct ib_device *dev, void *private, int nr_cqe,
 	if (!cq->wc)
 		goto out_free_cq;
 
-	cq->res.type = RDMA_RESTRACK_CQ;
+	rdma_restrack_new(&cq->res, RDMA_RESTRACK_CQ);
 	rdma_restrack_set_task(&cq->res, caller);
 
 	ret = dev->ops.create_cq(cq, &cq_attr, NULL);
 	if (ret)
 		goto out_free_wc;
 
-	rdma_restrack_kadd(&cq->res);
-
 	rdma_dim_init(cq);
 
 	switch (cq->poll_ctx) {
@@ -269,14 +267,15 @@ struct ib_cq *__ib_alloc_cq(struct ib_device *dev, void *private, int nr_cqe,
 		goto out_destroy_cq;
 	}
 
+	rdma_restrack_kadd(&cq->res);
 	trace_cq_alloc(cq, nr_cqe, comp_vector, poll_ctx);
 	return cq;
 
 out_destroy_cq:
 	rdma_dim_destroy(cq);
-	rdma_restrack_del(&cq->res);
 	cq->device->ops.destroy_cq(cq, NULL);
 out_free_wc:
+	rdma_restrack_put(&cq->res);
 	kfree(cq->wc);
 out_free_cq:
 	kfree(cq);
diff --git a/drivers/infiniband/core/restrack.c b/drivers/infiniband/core/restrack.c
index 62fbb0ae9cb4..22c658e8c157 100644
--- a/drivers/infiniband/core/restrack.c
+++ b/drivers/infiniband/core/restrack.c
@@ -202,6 +202,21 @@ void rdma_restrack_attach_task(struct rdma_restrack_entry *res,
 	res->task = task;
 }
 
+/**
+ * rdma_restrack_new() - Initializes new restrack entry to allow _put() interface
+ * to release memory in fully automatic way.
+ * @res - Entry to initialize
+ * @type - REstrack type
+ */
+void rdma_restrack_new(struct rdma_restrack_entry *res,
+		       enum rdma_restrack_type type)
+{
+	kref_init(&res->kref);
+	init_completion(&res->comp);
+	res->type = type;
+}
+EXPORT_SYMBOL(rdma_restrack_new);
+
 static void rdma_restrack_add(struct rdma_restrack_entry *res)
 {
 	struct ib_device *dev = res_to_dev(res);
@@ -213,8 +228,6 @@ static void rdma_restrack_add(struct rdma_restrack_entry *res)
 
 	rt = &dev->res[res->type];
 
-	kref_init(&res->kref);
-	init_completion(&res->comp);
 	if (res->type == RDMA_RESTRACK_QP) {
 		/* Special case to ensure that LQPN points to right QP */
 		struct ib_qp *qp = container_of(res, struct ib_qp, res);
@@ -305,6 +318,10 @@ static void restrack_release(struct kref *kref)
 	struct rdma_restrack_entry *res;
 
 	res = container_of(kref, struct rdma_restrack_entry, kref);
+	if (res->task) {
+		put_task_struct(res->task);
+		res->task = NULL;
+	}
 	complete(&res->comp);
 }
 
@@ -314,14 +331,23 @@ int rdma_restrack_put(struct rdma_restrack_entry *res)
 }
 EXPORT_SYMBOL(rdma_restrack_put);
 
+/**
+ * rdma_restrack_del() - delete object from the reource tracking database
+ * @res:  resource entry
+ */
 void rdma_restrack_del(struct rdma_restrack_entry *res)
 {
 	struct rdma_restrack_entry *old;
 	struct rdma_restrack_root *rt;
 	struct ib_device *dev;
 
-	if (!res->valid)
-		goto out;
+	if (!res->valid) {
+		if (res->task) {
+			put_task_struct(res->task);
+			res->task = NULL;
+		}
+		return;
+	}
 
 	dev = res_to_dev(res);
 	if (WARN_ON(!dev))
@@ -330,16 +356,12 @@ void rdma_restrack_del(struct rdma_restrack_entry *res)
 	rt = &dev->res[res->type];
 
 	old = xa_erase(&rt->xa, res->id);
+	if (res->type == RDMA_RESTRACK_MR || res->type == RDMA_RESTRACK_QP)
+		return;
 	WARN_ON(old != res);
 	res->valid = false;
 
 	rdma_restrack_put(res);
 	wait_for_completion(&res->comp);
-
-out:
-	if (res->task) {
-		put_task_struct(res->task);
-		res->task = NULL;
-	}
 }
 EXPORT_SYMBOL(rdma_restrack_del);
diff --git a/drivers/infiniband/core/restrack.h b/drivers/infiniband/core/restrack.h
index d084e5f89849..16006a5e7408 100644
--- a/drivers/infiniband/core/restrack.h
+++ b/drivers/infiniband/core/restrack.h
@@ -25,6 +25,9 @@ struct rdma_restrack_root {
 
 int rdma_restrack_init(struct ib_device *dev);
 void rdma_restrack_clean(struct ib_device *dev);
+void rdma_restrack_del(struct rdma_restrack_entry *res);
+void rdma_restrack_new(struct rdma_restrack_entry *res,
+		       enum rdma_restrack_type type);
 void rdma_restrack_attach_task(struct rdma_restrack_entry *res,
 			       struct task_struct *task);
 #endif /* _RDMA_CORE_RESTRACK_H_ */
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 0f359f8ae4db..5fbf05ce7ccb 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -218,10 +218,11 @@ int ib_alloc_ucontext(struct uverbs_attr_bundle *attrs)
 	if (!ucontext)
 		return -ENOMEM;
 
-	ucontext->res.type = RDMA_RESTRACK_CTX;
 	ucontext->device = ib_dev;
 	ucontext->ufile = ufile;
 	xa_init_flags(&ucontext->mmap_xa, XA_FLAGS_ALLOC);
+
+	rdma_restrack_new(&ucontext->res, RDMA_RESTRACK_CTX);
 	attrs->context = ucontext;
 	return 0;
 }
@@ -313,6 +314,7 @@ static int ib_uverbs_get_context(struct uverbs_attr_bundle *attrs)
 err_uobj:
 	rdma_alloc_abort_uobject(uobj, attrs, false);
 err_ucontext:
+	rdma_restrack_put(&attrs->context->res);
 	kfree(attrs->context);
 	attrs->context = NULL;
 	return ret;
@@ -439,8 +441,8 @@ static int ib_uverbs_alloc_pd(struct uverbs_attr_bundle *attrs)
 	pd->device  = ib_dev;
 	pd->uobject = uobj;
 	atomic_set(&pd->usecnt, 0);
-	pd->res.type = RDMA_RESTRACK_PD;
 
+	rdma_restrack_new(&pd->res, RDMA_RESTRACK_PD);
 	ret = ib_dev->ops.alloc_pd(pd, &attrs->driver_udata);
 	if (ret)
 		goto err_alloc;
@@ -453,6 +455,7 @@ static int ib_uverbs_alloc_pd(struct uverbs_attr_bundle *attrs)
 	return uverbs_response(attrs, &resp, sizeof(resp));
 
 err_alloc:
+	rdma_restrack_put(&pd->res);
 	kfree(pd);
 err:
 	uobj_alloc_abort(uobj, attrs);
@@ -742,8 +745,9 @@ static int ib_uverbs_reg_mr(struct uverbs_attr_bundle *attrs)
 	mr->sig_attrs = NULL;
 	mr->uobject = uobj;
 	atomic_inc(&pd->usecnt);
-	mr->res.type = RDMA_RESTRACK_MR;
 	mr->iova = cmd.hca_va;
+
+	rdma_restrack_new(&mr->res, RDMA_RESTRACK_MR);
 	rdma_restrack_uadd(&mr->res);
 
 	uobj->object = mr;
@@ -994,8 +998,8 @@ static int create_cq(struct uverbs_attr_bundle *attrs,
 	cq->event_handler = ib_uverbs_cq_event_handler;
 	cq->cq_context    = ev_file ? &ev_file->ev_queue : NULL;
 	atomic_set(&cq->usecnt, 0);
-	cq->res.type = RDMA_RESTRACK_CQ;
 
+	rdma_restrack_new(&cq->res, RDMA_RESTRACK_CQ);
 	ret = ib_dev->ops.create_cq(cq, &attr, &attrs->driver_udata);
 	if (ret)
 		goto err_free;
@@ -1013,6 +1017,7 @@ static int create_cq(struct uverbs_attr_bundle *attrs,
 	return uverbs_response(attrs, &resp, sizeof(resp));
 
 err_free:
+	rdma_restrack_put(&cq->res);
 	kfree(cq);
 err_file:
 	if (ev_file)
diff --git a/drivers/infiniband/core/uverbs_std_types_cq.c b/drivers/infiniband/core/uverbs_std_types_cq.c
index b1c7dacc02de..3a5fd6c9ba72 100644
--- a/drivers/infiniband/core/uverbs_std_types_cq.c
+++ b/drivers/infiniband/core/uverbs_std_types_cq.c
@@ -33,6 +33,7 @@
 #include <rdma/uverbs_std_types.h>
 #include "rdma_core.h"
 #include "uverbs.h"
+#include "restrack.h"
 
 static int uverbs_free_cq(struct ib_uobject *uobject,
 			  enum rdma_remove_reason why,
@@ -123,8 +124,8 @@ static int UVERBS_HANDLER(UVERBS_METHOD_CQ_CREATE)(
 	cq->event_handler = ib_uverbs_cq_event_handler;
 	cq->cq_context    = ev_file ? &ev_file->ev_queue : NULL;
 	atomic_set(&cq->usecnt, 0);
-	cq->res.type = RDMA_RESTRACK_CQ;
 
+	rdma_restrack_new(&cq->res, RDMA_RESTRACK_CQ);
 	ret = ib_dev->ops.create_cq(cq, &attr, &attrs->driver_udata);
 	if (ret)
 		goto err_free;
@@ -139,6 +140,7 @@ static int UVERBS_HANDLER(UVERBS_METHOD_CQ_CREATE)(
 	return ret;
 
 err_free:
+	rdma_restrack_put(&cq->res);
 	kfree(cq);
 err_event_file:
 	if (obj->uevent.event_file)
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 8fb5c5c40c8b..f613f60299eb 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -272,11 +272,12 @@ struct ib_pd *__ib_alloc_pd(struct ib_device *device, unsigned int flags,
 	atomic_set(&pd->usecnt, 0);
 	pd->flags = flags;
 
-	pd->res.type = RDMA_RESTRACK_PD;
+	rdma_restrack_new(&pd->res, RDMA_RESTRACK_PD);
 	rdma_restrack_set_task(&pd->res, caller);
 
 	ret = device->ops.alloc_pd(pd, NULL);
 	if (ret) {
+		rdma_restrack_put(&pd->res);
 		kfree(pd);
 		return ERR_PTR(ret);
 	}
@@ -1996,11 +1997,13 @@ struct ib_cq *__ib_create_cq(struct ib_device *device,
 	cq->event_handler = event_handler;
 	cq->cq_context = cq_context;
 	atomic_set(&cq->usecnt, 0);
-	cq->res.type = RDMA_RESTRACK_CQ;
+
+	rdma_restrack_new(&cq->res, RDMA_RESTRACK_CQ);
 	rdma_restrack_set_task(&cq->res, caller);
 
 	ret = device->ops.create_cq(cq, cq_attr, NULL);
 	if (ret) {
+		rdma_restrack_put(&cq->res);
 		kfree(cq);
 		return ERR_PTR(ret);
 	}
@@ -2076,7 +2079,8 @@ struct ib_mr *ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 	mr->pd = pd;
 	mr->dm = NULL;
 	atomic_inc(&pd->usecnt);
-	mr->res.type = RDMA_RESTRACK_MR;
+
+	rdma_restrack_new(&mr->res, RDMA_RESTRACK_MR);
 	rdma_restrack_kadd(&mr->res);
 
 	return mr;
@@ -2156,11 +2160,11 @@ struct ib_mr *ib_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
 	mr->uobject = NULL;
 	atomic_inc(&pd->usecnt);
 	mr->need_inval = false;
-	mr->res.type = RDMA_RESTRACK_MR;
-	rdma_restrack_kadd(&mr->res);
 	mr->type = mr_type;
 	mr->sig_attrs = NULL;
 
+	rdma_restrack_new(&mr->res, RDMA_RESTRACK_MR);
+	rdma_restrack_kadd(&mr->res);
 out:
 	trace_mr_alloc(pd, mr_type, max_num_sg, mr);
 	return mr;
@@ -2216,11 +2220,11 @@ struct ib_mr *ib_alloc_mr_integrity(struct ib_pd *pd,
 	mr->uobject = NULL;
 	atomic_inc(&pd->usecnt);
 	mr->need_inval = false;
-	mr->res.type = RDMA_RESTRACK_MR;
-	rdma_restrack_kadd(&mr->res);
 	mr->type = IB_MR_TYPE_INTEGRITY;
 	mr->sig_attrs = sig_attrs;
 
+	rdma_restrack_new(&mr->res, RDMA_RESTRACK_MR);
+	rdma_restrack_kadd(&mr->res);
 out:
 	trace_mr_integ_alloc(pd, max_num_data_sg, max_num_meta_sg, mr);
 	return mr;
diff --git a/include/rdma/restrack.h b/include/rdma/restrack.h
index 7682d1bcf789..d7c166237939 100644
--- a/include/rdma/restrack.h
+++ b/include/rdma/restrack.h
@@ -110,13 +110,6 @@ int rdma_restrack_count(struct ib_device *dev,
 void rdma_restrack_kadd(struct rdma_restrack_entry *res);
 void rdma_restrack_uadd(struct rdma_restrack_entry *res);
 
-/**
- * rdma_restrack_del() - delete object from the reource tracking database
- * @res:  resource entry
- * @type: actual type of object to operate
- */
-void rdma_restrack_del(struct rdma_restrack_entry *res);
-
 /**
  * rdma_is_kernel_res() - check the owner of resource
  * @res:  resource entry
-- 
2.26.2

