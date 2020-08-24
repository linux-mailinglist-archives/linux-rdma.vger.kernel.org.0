Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD0024FBD2
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Aug 2020 12:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbgHXKpN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Aug 2020 06:45:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:35700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727768AbgHXKo6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 24 Aug 2020 06:44:58 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51A442071E;
        Mon, 24 Aug 2020 10:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598265897;
        bh=wDQYQwRx7G9YKWSRdRlKgWxfywnGh6m4JIJA0cVQHUU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zUePegq/10RK4QJqMt8ZOIG/4tHJX4GcrIZ3SoqzLhpVB+Z1Ub3zRB/aDc0O9wRfg
         JvVqaoWY7Hy9rhHfObUtNEcmY6LwFbVDZhFvjd1uGyR4C4jCgWJNy2jjgDNPkgQq5A
         uGWZQZ4jXUDSomfsyg3Jw7+C3G7NrphdE6ykaI8Q=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org,
        Mark Zhang <markz@nvidia.com>
Subject: [PATCH rdma-next 11/14] RDMA/restrack: Make restrack DB mandatory for IB objects
Date:   Mon, 24 Aug 2020 13:44:12 +0300
Message-Id: <20200824104415.1090901-12-leon@kernel.org>
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

Restrack stores the IB objects in the internal xarray and insertion
where can fail. As long as restrack was helper tool for the
debuggability, such failure were ignored.

In the following patches, the ib_core will be changed to manage allocated
IB objects in restrack DB for the proper memory lifetime. It requires to
ensure that insertion errors are not ignored.

Reviewed-by: Mark Zhang <markz@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cma.c                 |  9 ++-
 drivers/infiniband/core/core_priv.h           |  9 ++-
 drivers/infiniband/core/counters.c            | 37 ++++++-----
 drivers/infiniband/core/cq.c                  | 17 ++++-
 drivers/infiniband/core/rdma_core.c           |  3 +-
 drivers/infiniband/core/restrack.c            | 26 +++++---
 drivers/infiniband/core/restrack.h            |  2 +-
 drivers/infiniband/core/uverbs_cmd.c          | 27 ++++++--
 drivers/infiniband/core/uverbs_std_types_cq.c |  6 +-
 drivers/infiniband/core/verbs.c               | 63 ++++++++++++++-----
 10 files changed, 147 insertions(+), 52 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 613c204ad749..0dfbaf293c8e 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -461,6 +461,8 @@ static int cma_igmp_send(struct net_device *ndev, union ib_gid *mgid, bool join)
 static int _cma_attach_to_dev(struct rdma_id_private *id_priv,
 			      struct cma_device *cma_dev)
 {
+	int ret;
+
 	cma_dev_get(cma_dev);
 	id_priv->cma_dev = cma_dev;
 	id_priv->id.device = cma_dev->device;
@@ -472,7 +474,12 @@ static int _cma_attach_to_dev(struct rdma_id_private *id_priv,
 	 * attach to "current" task.
 	 */
 	rdma_restrack_set_name(&id_priv->res, id_priv->res.kern_name);
-	rdma_restrack_add(&id_priv->res);
+	ret = rdma_restrack_add(&id_priv->res);
+	if (ret) {
+		list_del(&cma_dev->id_list);
+		cma_dev_put(cma_dev);
+		return ret;
+	}
 
 	trace_cm_id_attach(id_priv, cma_dev->device);
 	return 0;
diff --git a/drivers/infiniband/core/core_priv.h b/drivers/infiniband/core/core_priv.h
index 7c4752c47f80..7f4bb09efab8 100644
--- a/drivers/infiniband/core/core_priv.h
+++ b/drivers/infiniband/core/core_priv.h
@@ -327,6 +327,7 @@ static inline struct ib_qp *_ib_create_qp(struct ib_device *dev,
 	enum ib_qp_type qp_type = attr->qp_type;
 	struct ib_qp *qp;
 	bool is_xrc;
+	int ret;
 
 	if (!dev->ops.create_qp)
 		return ERR_PTR(-EOPNOTSUPP);
@@ -364,9 +365,15 @@ static inline struct ib_qp *_ib_create_qp(struct ib_device *dev,
 	is_xrc = qp_type == IB_QPT_XRC_INI || qp_type == IB_QPT_XRC_TGT;
 	if ((qp_type < IB_QPT_MAX && !is_xrc) || qp_type == IB_QPT_DRIVER) {
 		rdma_restrack_parent_name(&qp->res, &pd->res);
-		rdma_restrack_add(&qp->res);
+		ret = rdma_restrack_add(&qp->res);
+		if (ret)
+			goto err;
 	}
 	return qp;
+err:
+	rdma_restrack_put(&qp->res);
+	dev->ops.destroy_qp(qp, udata);
+	return ERR_PTR(ret);
 }
 
 struct rdma_dev_addr;
diff --git a/drivers/infiniband/core/counters.c b/drivers/infiniband/core/counters.c
index e208cc6d3cb0..4a0607872e54 100644
--- a/drivers/infiniband/core/counters.c
+++ b/drivers/infiniband/core/counters.c
@@ -95,6 +95,21 @@ static int __rdma_counter_bind_qp(struct rdma_counter *counter,
 	return ret;
 }
 
+static int __rdma_counter_unbind_qp(struct ib_qp *qp)
+{
+	struct rdma_counter *counter = qp->counter;
+	int ret;
+
+	if (!qp->device->ops.counter_unbind_qp)
+		return -EOPNOTSUPP;
+
+	mutex_lock(&counter->lock);
+	ret = qp->device->ops.counter_unbind_qp(qp);
+	mutex_unlock(&counter->lock);
+
+	return ret;
+}
+
 static struct rdma_counter *alloc_and_bind(struct ib_device *dev, u8 port,
 					   struct ib_qp *qp,
 					   enum rdma_nl_counter_mode mode)
@@ -147,9 +162,14 @@ static struct rdma_counter *alloc_and_bind(struct ib_device *dev, u8 port,
 		goto err_mode;
 
 	rdma_restrack_parent_name(&counter->res, &qp->res);
-	rdma_restrack_add(&counter->res);
+	ret = rdma_restrack_add(&counter->res);
+	if (ret)
+		goto err_restrack;
+
 	return counter;
 
+err_restrack:
+	__rdma_counter_unbind_qp(qp);
 err_mode:
 	mutex_unlock(&port_counter->lock);
 	kfree(counter->stats);
@@ -194,21 +214,6 @@ static bool auto_mode_match(struct ib_qp *qp, struct rdma_counter *counter,
 	return match;
 }
 
-static int __rdma_counter_unbind_qp(struct ib_qp *qp)
-{
-	struct rdma_counter *counter = qp->counter;
-	int ret;
-
-	if (!qp->device->ops.counter_unbind_qp)
-		return -EOPNOTSUPP;
-
-	mutex_lock(&counter->lock);
-	ret = qp->device->ops.counter_unbind_qp(qp);
-	mutex_unlock(&counter->lock);
-
-	return ret;
-}
-
 static void counter_history_stat_update(struct rdma_counter *counter)
 {
 	struct ib_device *dev = counter->device;
diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
index 7959ae3c4e8d..6a8092caa9c0 100644
--- a/drivers/infiniband/core/cq.c
+++ b/drivers/infiniband/core/cq.c
@@ -267,10 +267,25 @@ struct ib_cq *__ib_alloc_cq(struct ib_device *dev, void *private, int nr_cqe,
 		goto out_destroy_cq;
 	}
 
-	rdma_restrack_add(&cq->res);
+	ret = rdma_restrack_add(&cq->res);
+	if (ret)
+		goto out_poll_cq;
+
 	trace_cq_alloc(cq, nr_cqe, comp_vector, poll_ctx);
 	return cq;
 
+out_poll_cq:
+	switch (cq->poll_ctx) {
+	case IB_POLL_SOFTIRQ:
+		irq_poll_disable(&cq->iop);
+		break;
+	case IB_POLL_WORKQUEUE:
+	case IB_POLL_UNBOUND_WORKQUEUE:
+		cancel_work_sync(&cq->work);
+		break;
+	default:
+		break;
+	}
 out_destroy_cq:
 	rdma_dim_destroy(cq);
 	cq->device->ops.destroy_cq(cq, NULL);
diff --git a/drivers/infiniband/core/rdma_core.c b/drivers/infiniband/core/rdma_core.c
index 6d3ed7c6e19e..56b031358d47 100644
--- a/drivers/infiniband/core/rdma_core.c
+++ b/drivers/infiniband/core/rdma_core.c
@@ -831,10 +831,9 @@ static void ufile_destroy_ucontext(struct ib_uverbs_file *ufile,
 	ib_rdmacg_uncharge(&ucontext->cg_obj, ib_dev,
 			   RDMACG_RESOURCE_HCA_HANDLE);
 
-	rdma_restrack_del(&ucontext->res);
-
 	ib_dev->ops.dealloc_ucontext(ucontext);
 	WARN_ON(!xa_empty(&ucontext->mmap_xa));
+	rdma_restrack_del(&ucontext->res);
 	kfree(ucontext);
 
 	ufile->ucontext = NULL;
diff --git a/drivers/infiniband/core/restrack.c b/drivers/infiniband/core/restrack.c
index 94266d8eee04..4caaa6312105 100644
--- a/drivers/infiniband/core/restrack.c
+++ b/drivers/infiniband/core/restrack.c
@@ -217,21 +217,22 @@ EXPORT_SYMBOL(rdma_restrack_new);
  * rdma_restrack_add() - add object to the reource tracking database
  * @res:  resource entry
  */
-void rdma_restrack_add(struct rdma_restrack_entry *res)
+int __must_check rdma_restrack_add(struct rdma_restrack_entry *res)
 {
 	struct ib_device *dev = res_to_dev(res);
 	struct rdma_restrack_root *rt;
 	int ret = 0;
 
 	if (!dev)
-		return;
+		return -ENODEV;
 
 	if (res->no_track)
 		goto out;
 
 	rt = &dev->res[res->type];
 
-	if (res->type == RDMA_RESTRACK_QP) {
+	switch (res->type) {
+	case RDMA_RESTRACK_QP: {
 		/* Special case to ensure that LQPN points to right QP */
 		struct ib_qp *qp = container_of(res, struct ib_qp, res);
 
@@ -244,21 +245,26 @@ void rdma_restrack_add(struct rdma_restrack_entry *res)
 		ret = xa_insert(&rt->xa, res->id, res, GFP_KERNEL);
 		if (ret)
 			res->id = 0;
-	} else if (res->type == RDMA_RESTRACK_COUNTER) {
+	} break;
+	case RDMA_RESTRACK_COUNTER: {
 		/* Special case to ensure that cntn points to right counter */
-		struct rdma_counter *counter;
+		struct rdma_counter *counter = container_of(res, struct rdma_counter, res);
 
-		counter = container_of(res, struct rdma_counter, res);
 		ret = xa_insert(&rt->xa, counter->id, res, GFP_KERNEL);
-		res->id = ret ? 0 : counter->id;
-	} else {
+		if (ret)
+			break;
+		res->id = counter->id;
+	} break;
+	default:
 		ret = xa_alloc_cyclic(&rt->xa, &res->id, res, xa_limit_32b,
 				      &rt->next_id, GFP_KERNEL);
 	}
 
 out:
-	if (!ret)
-		res->valid = true;
+	if (ret)
+		return ret;
+	res->valid = true;
+	return 0;
 }
 EXPORT_SYMBOL(rdma_restrack_add);
 
diff --git a/drivers/infiniband/core/restrack.h b/drivers/infiniband/core/restrack.h
index 49c1d84cca2d..7e593ed8999f 100644
--- a/drivers/infiniband/core/restrack.h
+++ b/drivers/infiniband/core/restrack.h
@@ -25,7 +25,7 @@ struct rdma_restrack_root {
 
 int rdma_restrack_init(struct ib_device *dev);
 void rdma_restrack_clean(struct ib_device *dev);
-void rdma_restrack_add(struct rdma_restrack_entry *res);
+int __must_check rdma_restrack_add(struct rdma_restrack_entry *res);
 void rdma_restrack_del(struct rdma_restrack_entry *res);
 void rdma_restrack_new(struct rdma_restrack_entry *res,
 		       enum rdma_restrack_type type);
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 5dd3d72d594d..d7c532154bbd 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -252,7 +252,9 @@ int ib_init_ucontext(struct uverbs_attr_bundle *attrs)
 	if (ret)
 		goto err_uncharge;
 
-	rdma_restrack_add(&ucontext->res);
+	ret = rdma_restrack_add(&ucontext->res);
+	if (ret)
+		goto err_restrack;
 
 	/*
 	 * Make sure that ib_uverbs_get_ucontext() sees the pointer update
@@ -264,6 +266,8 @@ int ib_init_ucontext(struct uverbs_attr_bundle *attrs)
 	up_read(&file->hw_destroy_rwsem);
 	return 0;
 
+err_restrack:
+	ucontext->device->ops.dealloc_ucontext(ucontext);
 err_uncharge:
 	ib_rdmacg_uncharge(&ucontext->cg_obj, ucontext->device,
 			   RDMACG_RESOURCE_HCA_HANDLE);
@@ -449,7 +453,10 @@ static int ib_uverbs_alloc_pd(struct uverbs_attr_bundle *attrs)
 	ret = ib_dev->ops.alloc_pd(pd, &attrs->driver_udata);
 	if (ret)
 		goto err_alloc;
-	rdma_restrack_add(&pd->res);
+
+	ret = rdma_restrack_add(&pd->res);
+	if (ret)
+		goto err_restrack;
 
 	uobj->object = pd;
 	uobj_finalize_uobj_create(uobj, attrs);
@@ -457,6 +464,9 @@ static int ib_uverbs_alloc_pd(struct uverbs_attr_bundle *attrs)
 	resp.pd_handle = uobj->id;
 	return uverbs_response(attrs, &resp, sizeof(resp));
 
+err_restrack:
+	ib_dev->ops.dealloc_pd(pd, &attrs->driver_udata);
+
 err_alloc:
 	rdma_restrack_put(&pd->res);
 	kfree(pd);
@@ -752,7 +762,9 @@ static int ib_uverbs_reg_mr(struct uverbs_attr_bundle *attrs)
 
 	rdma_restrack_new(&mr->res, RDMA_RESTRACK_MR);
 	rdma_restrack_set_name(&mr->res, NULL);
-	rdma_restrack_add(&mr->res);
+	ret = rdma_restrack_add(&mr->res);
+	if (ret)
+		goto err_restrack;
 
 	uobj->object = mr;
 	uobj_put_obj_read(pd);
@@ -763,6 +775,8 @@ static int ib_uverbs_reg_mr(struct uverbs_attr_bundle *attrs)
 	resp.mr_handle = uobj->id;
 	return uverbs_response(attrs, &resp, sizeof(resp));
 
+err_restrack:
+	pd->device->ops.dereg_mr(mr, &attrs->driver_udata);
 err_put:
 	uobj_put_obj_read(pd);
 err_free:
@@ -1009,7 +1023,10 @@ static int create_cq(struct uverbs_attr_bundle *attrs,
 	ret = ib_dev->ops.create_cq(cq, &attr, &attrs->driver_udata);
 	if (ret)
 		goto err_free;
-	rdma_restrack_add(&cq->res);
+
+	ret = rdma_restrack_add(&cq->res);
+	if (ret)
+		goto err_restrack;
 
 	obj->uevent.uobject.object = cq;
 	obj->uevent.event_file = READ_ONCE(attrs->ufile->default_async_file);
@@ -1022,6 +1039,8 @@ static int create_cq(struct uverbs_attr_bundle *attrs,
 	resp.response_length = uverbs_response_length(attrs, sizeof(resp));
 	return uverbs_response(attrs, &resp, sizeof(resp));
 
+err_restrack:
+	ib_dev->ops.destroy_cq(cq, &attrs->driver_udata);
 err_free:
 	rdma_restrack_put(&cq->res);
 	kfree(cq);
diff --git a/drivers/infiniband/core/uverbs_std_types_cq.c b/drivers/infiniband/core/uverbs_std_types_cq.c
index 8dabd05988b2..838201f5e921 100644
--- a/drivers/infiniband/core/uverbs_std_types_cq.c
+++ b/drivers/infiniband/core/uverbs_std_types_cq.c
@@ -131,16 +131,20 @@ static int UVERBS_HANDLER(UVERBS_METHOD_CQ_CREATE)(
 	ret = ib_dev->ops.create_cq(cq, &attr, &attrs->driver_udata);
 	if (ret)
 		goto err_free;
+	ret = rdma_restrack_add(&cq->res);
+	if (ret)
+		goto err_restrack;
 
 	obj->uevent.uobject.object = cq;
 	obj->uevent.uobject.user_handle = user_handle;
-	rdma_restrack_add(&cq->res);
 	uverbs_finalize_uobj_create(attrs, UVERBS_ATTR_CREATE_CQ_HANDLE);
 
 	ret = uverbs_copy_to(attrs, UVERBS_ATTR_CREATE_CQ_RESP_CQE, &cq->cqe,
 			     sizeof(cq->cqe));
 	return ret;
 
+err_restrack:
+	ib_dev->ops.destroy_cq(cq, &attrs->driver_udata);
 err_free:
 	rdma_restrack_put(&cq->res);
 	kfree(cq);
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 77164629baf2..4b614e9bee9a 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -276,12 +276,12 @@ struct ib_pd *__ib_alloc_pd(struct ib_device *device, unsigned int flags,
 	rdma_restrack_set_name(&pd->res, caller);
 
 	ret = device->ops.alloc_pd(pd, NULL);
-	if (ret) {
-		rdma_restrack_put(&pd->res);
-		kfree(pd);
-		return ERR_PTR(ret);
-	}
-	rdma_restrack_add(&pd->res);
+	if (ret)
+		goto err_alloc;
+
+	ret = rdma_restrack_add(&pd->res);
+	if (ret)
+		goto err_restrack;
 
 	if (device->attrs.device_cap_flags & IB_DEVICE_LOCAL_DMA_LKEY)
 		pd->local_dma_lkey = device->local_dma_lkey;
@@ -318,6 +318,13 @@ struct ib_pd *__ib_alloc_pd(struct ib_device *device, unsigned int flags,
 	}
 
 	return pd;
+
+err_restrack:
+	device->ops.dealloc_pd(pd, NULL);
+err_alloc:
+	rdma_restrack_put(&pd->res);
+	kfree(pd);
+	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL(__ib_alloc_pd);
 
@@ -2005,14 +2012,21 @@ struct ib_cq *__ib_create_cq(struct ib_device *device,
 	rdma_restrack_set_name(&cq->res, caller);
 
 	ret = device->ops.create_cq(cq, cq_attr, NULL);
-	if (ret) {
-		rdma_restrack_put(&cq->res);
-		kfree(cq);
-		return ERR_PTR(ret);
-	}
+	if (ret)
+		goto err_create;
+
+	ret = rdma_restrack_add(&cq->res);
+	if (ret)
+		goto err_restrack;
 
-	rdma_restrack_add(&cq->res);
 	return cq;
+
+err_restrack:
+	device->ops.destroy_cq(cq, NULL);
+err_create:
+	rdma_restrack_put(&cq->res);
+	kfree(cq);
+	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL(__ib_create_cq);
 
@@ -2063,6 +2077,7 @@ struct ib_mr *ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 			     u64 virt_addr, int access_flags)
 {
 	struct ib_mr *mr;
+	int ret;
 
 	if (access_flags & IB_ACCESS_ON_DEMAND) {
 		if (!(pd->device->attrs.device_cap_flags &
@@ -2085,7 +2100,12 @@ struct ib_mr *ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 
 	rdma_restrack_new(&mr->res, RDMA_RESTRACK_MR);
 	rdma_restrack_parent_name(&mr->res, &pd->res);
-	rdma_restrack_add(&mr->res);
+	ret = rdma_restrack_add(&mr->res);
+	if (ret) {
+		rdma_restrack_put(&mr->res);
+		pd->device->ops.dereg_mr(mr, NULL);
+		mr = ERR_PTR(ret);
+	}
 
 	return mr;
 }
@@ -2142,6 +2162,7 @@ struct ib_mr *ib_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
 			  u32 max_num_sg)
 {
 	struct ib_mr *mr;
+	int ret;
 
 	if (!pd->device->ops.alloc_mr) {
 		mr = ERR_PTR(-EOPNOTSUPP);
@@ -2169,7 +2190,13 @@ struct ib_mr *ib_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
 
 	rdma_restrack_new(&mr->res, RDMA_RESTRACK_MR);
 	rdma_restrack_parent_name(&mr->res, &pd->res);
-	rdma_restrack_add(&mr->res);
+	ret = rdma_restrack_add(&mr->res);
+	if (ret) {
+		rdma_restrack_put(&mr->res);
+		pd->device->ops.dereg_mr(mr, NULL);
+		mr = ERR_PTR(ret);
+	}
+
 out:
 	trace_mr_alloc(pd, mr_type, max_num_sg, mr);
 	return mr;
@@ -2194,6 +2221,7 @@ struct ib_mr *ib_alloc_mr_integrity(struct ib_pd *pd,
 {
 	struct ib_mr *mr;
 	struct ib_sig_attrs *sig_attrs;
+	int ret;
 
 	if (!pd->device->ops.alloc_mr_integrity ||
 	    !pd->device->ops.map_mr_sg_pi) {
@@ -2230,7 +2258,12 @@ struct ib_mr *ib_alloc_mr_integrity(struct ib_pd *pd,
 
 	rdma_restrack_new(&mr->res, RDMA_RESTRACK_MR);
 	rdma_restrack_parent_name(&mr->res, &pd->res);
-	rdma_restrack_add(&mr->res);
+	ret = rdma_restrack_add(&mr->res);
+	if (ret) {
+		rdma_restrack_put(&mr->res);
+		pd->device->ops.dereg_mr(mr, NULL);
+		mr = ERR_PTR(ret);
+	}
 out:
 	trace_mr_integ_alloc(pd, max_num_data_sg, max_num_meta_sg, mr);
 	return mr;
-- 
2.26.2

