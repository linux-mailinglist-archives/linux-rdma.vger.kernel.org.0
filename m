Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82BF52C588
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2019 13:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbfE1Lhw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 May 2019 07:37:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:39524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726579AbfE1Lhv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 28 May 2019 07:37:51 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA1B22070D;
        Tue, 28 May 2019 11:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559043467;
        bh=u2t6QdEqH9ueTuabjfFL1+PBN07WoEeQs4+USKJDO+U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HIt51acKZbGMlxeL1WznA7VAPUW3D7wQ47/8WiIVMA1qUb3cPI7tb8ify2ActsYxs
         W1G14Yk2yM+Pf0Fh8Fp+wJCFeA9ar6+GEvRc6fsn6ATwwRhcHVGP8L4uXhwv8MXHw1
         8TYEYDI2+rvgMA/jaEZ5fRu4Wc7nBXBiH1tAOXBs=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: [PATCH rdma-next v1 3/3] RDMA: Convert CQ allocations to be under core responsibility
Date:   Tue, 28 May 2019 14:37:29 +0300
Message-Id: <20190528113729.13314-4-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190528113729.13314-1-leon@kernel.org>
References: <20190528113729.13314-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Ensure that CQ is allocated and freed by IB/core and not by drivers.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cq.c                  | 28 +++++----
 drivers/infiniband/core/device.c              |  1 +
 drivers/infiniband/core/uverbs_cmd.c          | 15 +++--
 drivers/infiniband/core/uverbs_std_types_cq.c | 19 ++++--
 drivers/infiniband/core/verbs.c               | 32 ++++++----
 drivers/infiniband/hw/bnxt_re/ib_verbs.c      | 20 +++----
 drivers/infiniband/hw/bnxt_re/ib_verbs.h      |  7 +--
 drivers/infiniband/hw/bnxt_re/main.c          |  1 +
 drivers/infiniband/hw/cxgb3/iwch_provider.c   | 43 ++++++-------
 drivers/infiniband/hw/cxgb4/cq.c              | 27 ++++-----
 drivers/infiniband/hw/cxgb4/iw_cxgb4.h        |  5 +-
 drivers/infiniband/hw/cxgb4/provider.c        |  1 +
 drivers/infiniband/hw/efa/efa.h               |  5 +-
 drivers/infiniband/hw/efa/efa_main.c          |  1 +
 drivers/infiniband/hw/efa/efa_verbs.c         | 50 +++++-----------
 drivers/infiniband/hw/hns/hns_roce_cq.c       | 23 +++----
 drivers/infiniband/hw/hns/hns_roce_device.h   |  6 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c    | 21 ++++---
 drivers/infiniband/hw/hns/hns_roce_main.c     |  1 +
 drivers/infiniband/hw/i40iw/i40iw_verbs.c     | 33 ++++------
 drivers/infiniband/hw/mlx4/cq.c               | 25 +++-----
 drivers/infiniband/hw/mlx4/main.c             |  1 +
 drivers/infiniband/hw/mlx4/mlx4_ib.h          |  5 +-
 drivers/infiniband/hw/mlx5/cq.c               | 32 ++++------
 drivers/infiniband/hw/mlx5/main.c             | 21 ++++---
 drivers/infiniband/hw/mlx5/mlx5_ib.h          |  5 +-
 drivers/infiniband/hw/mthca/mthca_provider.c  | 36 +++++------
 drivers/infiniband/hw/nes/nes_verbs.c         | 60 +++++++------------
 drivers/infiniband/hw/ocrdma/ocrdma_main.c    |  1 +
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c   | 29 ++++-----
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.h   |  5 +-
 drivers/infiniband/hw/qedr/main.c             |  1 +
 drivers/infiniband/hw/qedr/verbs.c            | 28 +++------
 drivers/infiniband/hw/qedr/verbs.h            |  5 +-
 drivers/infiniband/hw/usnic/usnic_ib.h        |  4 ++
 drivers/infiniband/hw/usnic/usnic_ib_main.c   |  1 +
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c  | 18 ++----
 drivers/infiniband/hw/usnic/usnic_ib_verbs.h  |  5 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c  | 34 ++++-------
 .../infiniband/hw/vmw_pvrdma/pvrdma_main.c    |  1 +
 .../infiniband/hw/vmw_pvrdma/pvrdma_verbs.h   |  5 +-
 drivers/infiniband/sw/rdmavt/cq.c             | 51 +++++-----------
 drivers/infiniband/sw/rdmavt/cq.h             |  5 +-
 drivers/infiniband/sw/rdmavt/vt.c             |  1 +
 drivers/infiniband/sw/rxe/rxe_pool.c          |  1 +
 drivers/infiniband/sw/rxe/rxe_verbs.c         | 30 ++++------
 drivers/infiniband/sw/rxe/rxe_verbs.h         |  2 +-
 include/rdma/ib_verbs.h                       |  6 +-
 48 files changed, 319 insertions(+), 438 deletions(-)

diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
index 6ee62600a812..3b9412c69565 100644
--- a/drivers/infiniband/core/cq.c
+++ b/drivers/infiniband/core/cq.c
@@ -147,23 +147,26 @@ struct ib_cq *__ib_alloc_cq_user(struct ib_device *dev, void *private,
 	struct ib_cq *cq;
 	int ret = -ENOMEM;
 
-	cq = dev->ops.create_cq(dev, &cq_attr, NULL);
-	if (IS_ERR(cq))
-		return cq;
+	cq = rdma_zalloc_drv_obj(dev, ib_cq);
+	if (!cq)
+		return ERR_PTR(ret);
 
 	cq->device = dev;
-	cq->uobject = NULL;
-	cq->event_handler = NULL;
 	cq->cq_context = private;
 	cq->poll_ctx = poll_ctx;
 	atomic_set(&cq->usecnt, 0);
 
 	cq->wc = kmalloc_array(IB_POLL_BATCH, sizeof(*cq->wc), GFP_KERNEL);
 	if (!cq->wc)
-		goto out_destroy_cq;
+		goto out_free_cq;
 
 	cq->res.type = RDMA_RESTRACK_CQ;
 	rdma_restrack_set_task(&cq->res, caller);
+
+	ret = dev->ops.create_cq(cq, &cq_attr, NULL);
+	if (ret)
+		goto out_free_wc;
+
 	rdma_restrack_kadd(&cq->res);
 
 	switch (cq->poll_ctx) {
@@ -186,16 +189,18 @@ struct ib_cq *__ib_alloc_cq_user(struct ib_device *dev, void *private,
 		break;
 	default:
 		ret = -EINVAL;
-		goto out_free_wc;
+		goto out_destroy_cq;
 	}
 
 	return cq;
 
-out_free_wc:
-	kfree(cq->wc);
-	rdma_restrack_del(&cq->res);
 out_destroy_cq:
+	rdma_restrack_del(&cq->res);
 	cq->device->ops.destroy_cq(cq, udata);
+out_free_wc:
+	kfree(cq->wc);
+out_free_cq:
+	kfree(cq);
 	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL(__ib_alloc_cq_user);
@@ -224,8 +229,9 @@ void ib_free_cq_user(struct ib_cq *cq, struct ib_udata *udata)
 		WARN_ON_ONCE(1);
 	}
 
-	kfree(cq->wc);
 	rdma_restrack_del(&cq->res);
 	cq->device->ops.destroy_cq(cq, udata);
+	kfree(cq->wc);
+	kfree(cq);
 }
 EXPORT_SYMBOL(ib_free_cq_user);
diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 54325d5f997c..f7976286d54b 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2450,6 +2450,7 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
 	SET_DEVICE_OP(dev_ops, counter_update_stats);
 
 	SET_OBJ_SIZE(dev_ops, ib_ah);
+	SET_OBJ_SIZE(dev_ops, ib_cq);
 	SET_OBJ_SIZE(dev_ops, ib_pd);
 	SET_OBJ_SIZE(dev_ops, ib_srq);
 	SET_OBJ_SIZE(dev_ops, ib_ucontext);
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 5a3a1780ceea..5c00d9a5698a 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -1010,12 +1010,11 @@ static struct ib_ucq_object *create_cq(struct uverbs_attr_bundle *attrs,
 	attr.comp_vector = cmd->comp_vector;
 	attr.flags = cmd->flags;
 
-	cq = ib_dev->ops.create_cq(ib_dev, &attr, &attrs->driver_udata);
-	if (IS_ERR(cq)) {
-		ret = PTR_ERR(cq);
+	cq = rdma_zalloc_drv_obj(ib_dev, ib_cq);
+	if (!cq) {
+		ret = -ENOMEM;
 		goto err_file;
 	}
-
 	cq->device        = ib_dev;
 	cq->uobject       = &obj->uobject;
 	cq->comp_handler  = ib_uverbs_comp_handler;
@@ -1023,6 +1022,10 @@ static struct ib_ucq_object *create_cq(struct uverbs_attr_bundle *attrs,
 	cq->cq_context    = ev_file ? &ev_file->ev_queue : NULL;
 	atomic_set(&cq->usecnt, 0);
 
+	ret = ib_dev->ops.create_cq(cq, &attr, &attrs->driver_udata);
+	if (ret)
+		goto err_free;
+
 	obj->uobject.object = cq;
 	memset(&resp, 0, sizeof resp);
 	resp.base.cq_handle = obj->uobject.id;
@@ -1043,7 +1046,9 @@ static struct ib_ucq_object *create_cq(struct uverbs_attr_bundle *attrs,
 
 err_cb:
 	ib_destroy_cq(cq);
-
+	cq = NULL;
+err_free:
+	kfree(cq);
 err_file:
 	if (ev_file)
 		ib_uverbs_release_ucq(attrs->ufile, ev_file, obj);
diff --git a/drivers/infiniband/core/uverbs_std_types_cq.c b/drivers/infiniband/core/uverbs_std_types_cq.c
index db5c46a1bb2d..06b8c7d017b7 100644
--- a/drivers/infiniband/core/uverbs_std_types_cq.c
+++ b/drivers/infiniband/core/uverbs_std_types_cq.c
@@ -111,9 +111,9 @@ static int UVERBS_HANDLER(UVERBS_METHOD_CQ_CREATE)(
 	INIT_LIST_HEAD(&obj->comp_list);
 	INIT_LIST_HEAD(&obj->async_list);
 
-	cq = ib_dev->ops.create_cq(ib_dev, &attr, &attrs->driver_udata);
-	if (IS_ERR(cq)) {
-		ret = PTR_ERR(cq);
+	cq = rdma_zalloc_drv_obj(ib_dev, ib_cq);
+	if (!cq) {
+		ret = -ENOMEM;
 		goto err_event_file;
 	}
 
@@ -122,10 +122,15 @@ static int UVERBS_HANDLER(UVERBS_METHOD_CQ_CREATE)(
 	cq->comp_handler  = ib_uverbs_comp_handler;
 	cq->event_handler = ib_uverbs_cq_event_handler;
 	cq->cq_context    = ev_file ? &ev_file->ev_queue : NULL;
-	obj->uobject.object = cq;
-	obj->uobject.user_handle = user_handle;
 	atomic_set(&cq->usecnt, 0);
 	cq->res.type = RDMA_RESTRACK_CQ;
+
+	ret = ib_dev->ops.create_cq(cq, &attr, &attrs->driver_udata);
+	if (ret)
+		goto err_free;
+
+	obj->uobject.object = cq;
+	obj->uobject.user_handle = user_handle;
 	rdma_restrack_uadd(&cq->res);
 
 	ret = uverbs_copy_to(attrs, UVERBS_ATTR_CREATE_CQ_RESP_CQE, &cq->cqe,
@@ -136,7 +141,9 @@ static int UVERBS_HANDLER(UVERBS_METHOD_CQ_CREATE)(
 	return 0;
 err_cq:
 	ib_destroy_cq(cq);
-
+	cq = NULL;
+err_free:
+	kfree(cq);
 err_event_file:
 	if (ev_file)
 		uverbs_uobject_put(ev_file_uobj);
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 8266625425da..b64c1881f0ab 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -1925,21 +1925,28 @@ struct ib_cq *__ib_create_cq(struct ib_device *device,
 			     const char *caller)
 {
 	struct ib_cq *cq;
+	int ret;
+
+	cq = rdma_zalloc_drv_obj(device, ib_cq);
+	if (!cq)
+		return ERR_PTR(-ENOMEM);
 
-	cq = device->ops.create_cq(device, cq_attr, NULL);
-
-	if (!IS_ERR(cq)) {
-		cq->device        = device;
-		cq->uobject       = NULL;
-		cq->comp_handler  = comp_handler;
-		cq->event_handler = event_handler;
-		cq->cq_context    = cq_context;
-		atomic_set(&cq->usecnt, 0);
-		cq->res.type = RDMA_RESTRACK_CQ;
-		rdma_restrack_set_task(&cq->res, caller);
-		rdma_restrack_kadd(&cq->res);
+	cq->device = device;
+	cq->uobject = NULL;
+	cq->comp_handler = comp_handler;
+	cq->event_handler = event_handler;
+	cq->cq_context = cq_context;
+	atomic_set(&cq->usecnt, 0);
+	cq->res.type = RDMA_RESTRACK_CQ;
+	rdma_restrack_set_task(&cq->res, caller);
+
+	ret = device->ops.create_cq(cq, cq_attr, NULL);
+	if (ret) {
+		kfree(cq);
+		return ERR_PTR(ret);
 	}
 
+	rdma_restrack_kadd(&cq->res);
 	return cq;
 }
 EXPORT_SYMBOL(__ib_create_cq);
@@ -1959,6 +1966,7 @@ int ib_destroy_cq_user(struct ib_cq *cq, struct ib_udata *udata)
 
 	rdma_restrack_del(&cq->res);
 	cq->device->ops.destroy_cq(cq, udata);
+	kfree(cq);
 	return 0;
 }
 EXPORT_SYMBOL(ib_destroy_cq_user);
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index a3c65e45a2bc..2f4fbee880d3 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -2534,16 +2534,14 @@ void bnxt_re_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 	atomic_dec(&rdev->cq_count);
 	nq->budget--;
 	kfree(cq->cql);
-	kfree(cq);
 }
 
-struct ib_cq *bnxt_re_create_cq(struct ib_device *ibdev,
-				const struct ib_cq_init_attr *attr,
-				struct ib_udata *udata)
+int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
+		      struct ib_udata *udata)
 {
-	struct bnxt_re_dev *rdev = to_bnxt_re_dev(ibdev, ibdev);
+	struct bnxt_re_dev *rdev = to_bnxt_re_dev(ibcq->device, ibdev);
 	struct bnxt_qplib_dev_attr *dev_attr = &rdev->dev_attr;
-	struct bnxt_re_cq *cq = NULL;
+	struct bnxt_re_cq *cq = container_of(ibcq, struct bnxt_re_cq, ib_cq);
 	int rc, entries;
 	int cqe = attr->cqe;
 	struct bnxt_qplib_nq *nq = NULL;
@@ -2552,11 +2550,8 @@ struct ib_cq *bnxt_re_create_cq(struct ib_device *ibdev,
 	/* Validate CQ fields */
 	if (cqe < 1 || cqe > dev_attr->max_cq_wqes) {
 		dev_err(rdev_to_dev(rdev), "Failed to create CQ -max exceeded");
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 	}
-	cq = kzalloc(sizeof(*cq), GFP_KERNEL);
-	if (!cq)
-		return ERR_PTR(-ENOMEM);
 
 	cq->rdev = rdev;
 	cq->qplib_cq.cq_handle = (u64)(unsigned long)(&cq->qplib_cq);
@@ -2634,15 +2629,14 @@ struct ib_cq *bnxt_re_create_cq(struct ib_device *ibdev,
 		}
 	}
 
-	return &cq->ib_cq;
+	return 0;
 
 c2fail:
 	if (udata)
 		ib_umem_release(cq->umem);
 fail:
 	kfree(cq->cql);
-	kfree(cq);
-	return ERR_PTR(rc);
+	return rc;
 }
 
 static u8 __req_to_ib_wc_status(u8 qstatus)
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
index 828403ee0104..31662b1ee35a 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
@@ -94,11 +94,11 @@ struct bnxt_re_qp {
 };
 
 struct bnxt_re_cq {
+	struct ib_cq		ib_cq;
 	struct bnxt_re_dev	*rdev;
 	spinlock_t              cq_lock;	/* protect cq */
 	u16			cq_count;
 	u16			cq_period;
-	struct ib_cq		ib_cq;
 	struct bnxt_qplib_cq	qplib_cq;
 	struct bnxt_qplib_cqe	*cql;
 #define MAX_CQL_PER_POLL	1024
@@ -190,9 +190,8 @@ int bnxt_re_post_send(struct ib_qp *qp, const struct ib_send_wr *send_wr,
 		      const struct ib_send_wr **bad_send_wr);
 int bnxt_re_post_recv(struct ib_qp *qp, const struct ib_recv_wr *recv_wr,
 		      const struct ib_recv_wr **bad_recv_wr);
-struct ib_cq *bnxt_re_create_cq(struct ib_device *ibdev,
-				const struct ib_cq_init_attr *attr,
-				struct ib_udata *udata);
+int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
+		      struct ib_udata *udata);
 void bnxt_re_destroy_cq(struct ib_cq *cq, struct ib_udata *udata);
 int bnxt_re_poll_cq(struct ib_cq *cq, int num_entries, struct ib_wc *wc);
 int bnxt_re_req_notify_cq(struct ib_cq *cq, enum ib_cq_notify_flags flags);
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 814f959c7db9..6e1276f50dd6 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -637,6 +637,7 @@ static const struct ib_device_ops bnxt_re_dev_ops = {
 	.reg_user_mr = bnxt_re_reg_user_mr,
 	.req_notify_cq = bnxt_re_req_notify_cq,
 	INIT_RDMA_OBJ_SIZE(ib_ah, bnxt_re_ah, ib_ah),
+	INIT_RDMA_OBJ_SIZE(ib_cq, bnxt_re_cq, ib_cq),
 	INIT_RDMA_OBJ_SIZE(ib_pd, bnxt_re_pd, ib_pd),
 	INIT_RDMA_OBJ_SIZE(ib_srq, bnxt_re_srq, ib_srq),
 	INIT_RDMA_OBJ_SIZE(ib_ucontext, bnxt_re_ucontext, ib_uctx),
diff --git a/drivers/infiniband/hw/cxgb3/iwch_provider.c b/drivers/infiniband/hw/cxgb3/iwch_provider.c
index 28a7cf6007c5..30e9bc3d2e2a 100644
--- a/drivers/infiniband/hw/cxgb3/iwch_provider.c
+++ b/drivers/infiniband/hw/cxgb3/iwch_provider.c
@@ -100,16 +100,16 @@ static void iwch_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 	wait_event(chp->wait, !atomic_read(&chp->refcnt));
 
 	cxio_destroy_cq(&chp->rhp->rdev, &chp->cq);
-	kfree(chp);
 }
 
-static struct ib_cq *iwch_create_cq(struct ib_device *ibdev,
-				    const struct ib_cq_init_attr *attr,
-				    struct ib_udata *udata)
+static int iwch_create_cq(struct ib_cq *ibcq,
+			  const struct ib_cq_init_attr *attr,
+			  struct ib_udata *udata)
 {
+	struct ib_device *ibdev = ibcq->device;
 	int entries = attr->cqe;
-	struct iwch_dev *rhp;
-	struct iwch_cq *chp;
+	struct iwch_dev *rhp = to_iwch_dev(ibcq->device);
+	struct iwch_cq *chp = to_iwch_cq(ibcq);
 	struct iwch_create_cq_resp uresp;
 	struct iwch_create_cq_req ureq;
 	static int warned;
@@ -117,19 +117,13 @@ static struct ib_cq *iwch_create_cq(struct ib_device *ibdev,
 
 	pr_debug("%s ib_dev %p entries %d\n", __func__, ibdev, entries);
 	if (attr->flags)
-		return ERR_PTR(-EINVAL);
-
-	rhp = to_iwch_dev(ibdev);
-	chp = kzalloc(sizeof(*chp), GFP_KERNEL);
-	if (!chp)
-		return ERR_PTR(-ENOMEM);
+		return -EINVAL;
 
 	if (udata) {
 		if (!t3a_device(rhp)) {
-			if (ib_copy_from_udata(&ureq, udata, sizeof(ureq))) {
-				kfree(chp);
-				return ERR_PTR(-EFAULT);
-			}
+			if (ib_copy_from_udata(&ureq, udata, sizeof(ureq)))
+				return  -EFAULT;
+
 			chp->user_rptr_addr = (u32 __user *)(unsigned long)ureq.user_rptr_addr;
 		}
 	}
@@ -150,10 +144,9 @@ static struct ib_cq *iwch_create_cq(struct ib_device *ibdev,
 	entries = roundup_pow_of_two(entries);
 	chp->cq.size_log2 = ilog2(entries);
 
-	if (cxio_create_cq(&rhp->rdev, &chp->cq, !udata)) {
-		kfree(chp);
-		return ERR_PTR(-ENOMEM);
-	}
+	if (cxio_create_cq(&rhp->rdev, &chp->cq, !udata))
+		return -ENOMEM;
+
 	chp->rhp = rhp;
 	chp->ibcq.cqe = 1 << chp->cq.size_log2;
 	spin_lock_init(&chp->lock);
@@ -162,8 +155,7 @@ static struct ib_cq *iwch_create_cq(struct ib_device *ibdev,
 	init_waitqueue_head(&chp->wait);
 	if (xa_store_irq(&rhp->cqs, chp->cq.cqid, chp, GFP_KERNEL)) {
 		cxio_destroy_cq(&chp->rhp->rdev, &chp->cq);
-		kfree(chp);
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 	}
 
 	if (udata) {
@@ -174,7 +166,7 @@ static struct ib_cq *iwch_create_cq(struct ib_device *ibdev,
 		mm = kmalloc(sizeof(*mm), GFP_KERNEL);
 		if (!mm) {
 			iwch_destroy_cq(&chp->ibcq, udata);
-			return ERR_PTR(-ENOMEM);
+			return -ENOMEM;
 		}
 		uresp.cqid = chp->cq.cqid;
 		uresp.size_log2 = chp->cq.size_log2;
@@ -200,14 +192,14 @@ static struct ib_cq *iwch_create_cq(struct ib_device *ibdev,
 		if (ib_copy_to_udata(udata, &uresp, resplen)) {
 			kfree(mm);
 			iwch_destroy_cq(&chp->ibcq, udata);
-			return ERR_PTR(-EFAULT);
+			return -EFAULT;
 		}
 		insert_mmap(ucontext, mm);
 	}
 	pr_debug("created cqid 0x%0x chp %p size 0x%0x, dma_addr %pad\n",
 		 chp->cq.cqid, chp, (1 << chp->cq.size_log2),
 		 &chp->cq.dma_addr);
-	return &chp->ibcq;
+	return 0;
 }
 
 static int iwch_arm_cq(struct ib_cq *ibcq, enum ib_cq_notify_flags flags)
@@ -1273,6 +1265,7 @@ static const struct ib_device_ops iwch_dev_ops = {
 	.reg_user_mr = iwch_reg_user_mr,
 	.req_notify_cq = iwch_arm_cq,
 	INIT_RDMA_OBJ_SIZE(ib_pd, iwch_pd, ibpd),
+	INIT_RDMA_OBJ_SIZE(ib_cq, iwch_cq, ibcq),
 	INIT_RDMA_OBJ_SIZE(ib_ucontext, iwch_ucontext, ibucontext),
 };
 
diff --git a/drivers/infiniband/hw/cxgb4/cq.c b/drivers/infiniband/hw/cxgb4/cq.c
index f49e6d271c42..3cc4d3331a3f 100644
--- a/drivers/infiniband/hw/cxgb4/cq.c
+++ b/drivers/infiniband/hw/cxgb4/cq.c
@@ -986,17 +986,16 @@ void c4iw_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 		   ucontext ? &ucontext->uctx : &chp->cq.rdev->uctx,
 		   chp->destroy_skb, chp->wr_waitp);
 	c4iw_put_wr_wait(chp->wr_waitp);
-	kfree(chp);
 }
 
-struct ib_cq *c4iw_create_cq(struct ib_device *ibdev,
-			     const struct ib_cq_init_attr *attr,
-			     struct ib_udata *udata)
+int c4iw_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
+		   struct ib_udata *udata)
 {
+	struct ib_device *ibdev = ibcq->device;
 	int entries = attr->cqe;
 	int vector = attr->comp_vector;
-	struct c4iw_dev *rhp;
-	struct c4iw_cq *chp;
+	struct c4iw_dev *rhp = to_c4iw_dev(ibcq->device);
+	struct c4iw_cq *chp = to_c4iw_cq(ibcq);
 	struct c4iw_create_cq ucmd;
 	struct c4iw_create_cq_resp uresp;
 	int ret, wr_len;
@@ -1007,22 +1006,16 @@ struct ib_cq *c4iw_create_cq(struct ib_device *ibdev,
 
 	pr_debug("ib_dev %p entries %d\n", ibdev, entries);
 	if (attr->flags)
-		return ERR_PTR(-EINVAL);
-
-	rhp = to_c4iw_dev(ibdev);
+		return -EINVAL;
 
 	if (vector >= rhp->rdev.lldi.nciq)
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 
 	if (udata) {
 		if (udata->inlen < sizeof(ucmd))
 			ucontext->is_32b_cqe = 1;
 	}
 
-	chp = kzalloc(sizeof(*chp), GFP_KERNEL);
-	if (!chp)
-		return ERR_PTR(-ENOMEM);
-
 	chp->wr_waitp = c4iw_alloc_wr_wait(GFP_KERNEL);
 	if (!chp->wr_waitp) {
 		ret = -ENOMEM;
@@ -1132,10 +1125,11 @@ struct ib_cq *c4iw_create_cq(struct ib_device *ibdev,
 		mm2->len = PAGE_SIZE;
 		insert_mmap(ucontext, mm2);
 	}
+
 	pr_debug("cqid 0x%0x chp %p size %u memsize %zu, dma_addr %pad\n",
 		 chp->cq.cqid, chp, chp->cq.size, chp->cq.memsize,
 		 &chp->cq.dma_addr);
-	return &chp->ibcq;
+	return 0;
 err_free_mm2:
 	kfree(mm2);
 err_free_mm:
@@ -1151,8 +1145,7 @@ struct ib_cq *c4iw_create_cq(struct ib_device *ibdev,
 err_free_wr_wait:
 	c4iw_put_wr_wait(chp->wr_waitp);
 err_free_chp:
-	kfree(chp);
-	return ERR_PTR(ret);
+	return ret;
 }
 
 int c4iw_arm_cq(struct ib_cq *ibcq, enum ib_cq_notify_flags flags)
diff --git a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
index 45e720288f0f..7d06b0f8d49a 100644
--- a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
+++ b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
@@ -993,9 +993,8 @@ struct ib_mr *c4iw_reg_user_mr(struct ib_pd *pd, u64 start,
 struct ib_mr *c4iw_get_dma_mr(struct ib_pd *pd, int acc);
 int c4iw_dereg_mr(struct ib_mr *ib_mr, struct ib_udata *udata);
 void c4iw_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata);
-struct ib_cq *c4iw_create_cq(struct ib_device *ibdev,
-			     const struct ib_cq_init_attr *attr,
-			     struct ib_udata *udata);
+int c4iw_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
+		   struct ib_udata *udata);
 int c4iw_arm_cq(struct ib_cq *ibcq, enum ib_cq_notify_flags flags);
 int c4iw_modify_srq(struct ib_srq *ib_srq, struct ib_srq_attr *attr,
 		    enum ib_srq_attr_mask srq_attr_mask,
diff --git a/drivers/infiniband/hw/cxgb4/provider.c b/drivers/infiniband/hw/cxgb4/provider.c
index 8ed75b141521..6c29e8f4b568 100644
--- a/drivers/infiniband/hw/cxgb4/provider.c
+++ b/drivers/infiniband/hw/cxgb4/provider.c
@@ -533,6 +533,7 @@ static const struct ib_device_ops c4iw_dev_ops = {
 	.reg_user_mr = c4iw_reg_user_mr,
 	.req_notify_cq = c4iw_arm_cq,
 	INIT_RDMA_OBJ_SIZE(ib_pd, c4iw_pd, ibpd),
+	INIT_RDMA_OBJ_SIZE(ib_cq, c4iw_cq, ibcq),
 	INIT_RDMA_OBJ_SIZE(ib_srq, c4iw_srq, ibsrq),
 	INIT_RDMA_OBJ_SIZE(ib_ucontext, c4iw_ucontext, ibucontext),
 };
diff --git a/drivers/infiniband/hw/efa/efa.h b/drivers/infiniband/hw/efa/efa.h
index 8d8d3bd47c35..2ceb8067b99a 100644
--- a/drivers/infiniband/hw/efa/efa.h
+++ b/drivers/infiniband/hw/efa/efa.h
@@ -137,9 +137,8 @@ struct ib_qp *efa_create_qp(struct ib_pd *ibpd,
 			    struct ib_qp_init_attr *init_attr,
 			    struct ib_udata *udata);
 void efa_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata);
-struct ib_cq *efa_create_cq(struct ib_device *ibdev,
-			    const struct ib_cq_init_attr *attr,
-			    struct ib_udata *udata);
+int efa_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
+		  struct ib_udata *udata);
 struct ib_mr *efa_reg_mr(struct ib_pd *ibpd, u64 start, u64 length,
 			 u64 virt_addr, int access_flags,
 			 struct ib_udata *udata);
diff --git a/drivers/infiniband/hw/efa/efa_main.c b/drivers/infiniband/hw/efa/efa_main.c
index db974caf1eb1..27f8a473bde9 100644
--- a/drivers/infiniband/hw/efa/efa_main.c
+++ b/drivers/infiniband/hw/efa/efa_main.c
@@ -220,6 +220,7 @@ static const struct ib_device_ops efa_dev_ops = {
 	.reg_user_mr = efa_reg_mr,
 
 	INIT_RDMA_OBJ_SIZE(ib_ah, efa_ah, ibah),
+	INIT_RDMA_OBJ_SIZE(ib_cq, efa_cq, ibcq),
 	INIT_RDMA_OBJ_SIZE(ib_pd, efa_pd, ibpd),
 	INIT_RDMA_OBJ_SIZE(ib_ucontext, efa_ucontext, ibucontext),
 };
diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index e57f8adde174..fef760de0d6d 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -859,8 +859,6 @@ void efa_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 	efa_destroy_cq_idx(dev, cq->cq_idx);
 	dma_unmap_single(&dev->pdev->dev, cq->dma_addr, cq->size,
 			 DMA_FROM_DEVICE);
-
-	kfree(cq);
 }
 
 static int cq_mmap_entries_setup(struct efa_dev *dev, struct efa_cq *cq,
@@ -876,17 +874,20 @@ static int cq_mmap_entries_setup(struct efa_dev *dev, struct efa_cq *cq,
 	return 0;
 }
 
-static struct ib_cq *do_create_cq(struct ib_device *ibdev, int entries,
-				  int vector, struct ib_ucontext *ibucontext,
-				  struct ib_udata *udata)
+int efa_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
+		  struct ib_udata *udata)
 {
+	struct efa_ucontext *ucontext = rdma_udata_to_drv_context(
+		udata, struct efa_ucontext, ibucontext);
 	struct efa_ibv_create_cq_resp resp = {};
 	struct efa_com_create_cq_params params;
 	struct efa_com_create_cq_result result;
+	struct ib_device *ibdev = ibcq->device;
 	struct efa_dev *dev = to_edev(ibdev);
 	struct efa_ibv_create_cq cmd = {};
+	struct efa_cq *cq = to_ecq(ibcq);
 	bool cq_entry_inserted = false;
-	struct efa_cq *cq;
+	int entries = attr->cqe;
 	int err;
 
 	ibdev_dbg(ibdev, "create_cq entries %d\n", entries);
@@ -900,7 +901,7 @@ static struct ib_cq *do_create_cq(struct ib_device *ibdev, int entries,
 	}
 
 	if (!field_avail(cmd, num_sub_cqs, udata->inlen)) {
-		ibdev_dbg(ibdev,
+		ibdev_dbg(ibcq->device,
 			  "Incompatible ABI params, no input udata\n");
 		err = -EINVAL;
 		goto err_out;
@@ -944,19 +945,13 @@ static struct ib_cq *do_create_cq(struct ib_device *ibdev, int entries,
 		goto err_out;
 	}
 
-	cq = kzalloc(sizeof(*cq), GFP_KERNEL);
-	if (!cq) {
-		err = -ENOMEM;
-		goto err_out;
-	}
-
-	cq->ucontext = to_eucontext(ibucontext);
+	cq->ucontext = ucontext;
 	cq->size = PAGE_ALIGN(cmd.cq_entry_size * entries * cmd.num_sub_cqs);
 	cq->cpu_addr = efa_zalloc_mapped(dev, &cq->dma_addr, cq->size,
 					 DMA_FROM_DEVICE);
 	if (!cq->cpu_addr) {
 		err = -ENOMEM;
-		goto err_free_cq;
+		goto err_out;
 	}
 
 	params.uarn = cq->ucontext->uarn;
@@ -975,8 +970,8 @@ static struct ib_cq *do_create_cq(struct ib_device *ibdev, int entries,
 
 	err = cq_mmap_entries_setup(dev, cq, &resp);
 	if (err) {
-		ibdev_dbg(ibdev,
-			  "Could not setup cq[%u] mmap entries\n", cq->cq_idx);
+		ibdev_dbg(ibdev, "Could not setup cq[%u] mmap entries\n",
+			  cq->cq_idx);
 		goto err_destroy_cq;
 	}
 
@@ -992,11 +987,10 @@ static struct ib_cq *do_create_cq(struct ib_device *ibdev, int entries,
 		}
 	}
 
-	ibdev_dbg(ibdev,
-		  "Created cq[%d], cq depth[%u]. dma[%pad] virt[0x%p]\n",
+	ibdev_dbg(ibdev, "Created cq[%d], cq depth[%u]. dma[%pad] virt[0x%p]\n",
 		  cq->cq_idx, result.actual_depth, &cq->dma_addr, cq->cpu_addr);
 
-	return &cq->ibcq;
+	return 0;
 
 err_destroy_cq:
 	efa_destroy_cq_idx(dev, cq->cq_idx);
@@ -1005,23 +999,9 @@ static struct ib_cq *do_create_cq(struct ib_device *ibdev, int entries,
 			 DMA_FROM_DEVICE);
 	if (!cq_entry_inserted)
 		free_pages_exact(cq->cpu_addr, cq->size);
-err_free_cq:
-	kfree(cq);
 err_out:
 	atomic64_inc(&dev->stats.sw_stats.create_cq_err);
-	return ERR_PTR(err);
-}
-
-struct ib_cq *efa_create_cq(struct ib_device *ibdev,
-			    const struct ib_cq_init_attr *attr,
-			    struct ib_udata *udata)
-{
-	struct efa_ucontext *ucontext = rdma_udata_to_drv_context(udata,
-								  struct efa_ucontext,
-								  ibucontext);
-
-	return do_create_cq(ibdev, attr->cqe, attr->comp_vector,
-			    &ucontext->ibucontext, udata);
+	return err;
 }
 
 static int umem_to_page_list(struct efa_dev *dev,
diff --git a/drivers/infiniband/hw/hns/hns_roce_cq.c b/drivers/infiniband/hw/hns/hns_roce_cq.c
index 0eb7c16c007b..7e198c9ffbfe 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cq.c
@@ -299,15 +299,15 @@ static void hns_roce_ib_free_cq_buf(struct hns_roce_dev *hr_dev,
 			  &buf->hr_buf);
 }
 
-struct ib_cq *hns_roce_ib_create_cq(struct ib_device *ib_dev,
-				    const struct ib_cq_init_attr *attr,
-				    struct ib_udata *udata)
+int hns_roce_ib_create_cq(struct ib_cq *ib_cq,
+			  const struct ib_cq_init_attr *attr,
+			  struct ib_udata *udata)
 {
-	struct hns_roce_dev *hr_dev = to_hr_dev(ib_dev);
+	struct hns_roce_dev *hr_dev = to_hr_dev(ib_cq->device);
 	struct device *dev = hr_dev->dev;
 	struct hns_roce_ib_create_cq ucmd;
 	struct hns_roce_ib_create_cq_resp resp = {};
-	struct hns_roce_cq *hr_cq = NULL;
+	struct hns_roce_cq *hr_cq = to_hr_cq(ib_cq);
 	struct hns_roce_uar *uar = NULL;
 	int vector = attr->comp_vector;
 	int cq_entries = attr->cqe;
@@ -318,13 +318,9 @@ struct ib_cq *hns_roce_ib_create_cq(struct ib_device *ib_dev,
 	if (cq_entries < 1 || cq_entries > hr_dev->caps.max_cqes) {
 		dev_err(dev, "Creat CQ failed. entries=%d, max=%d\n",
 			cq_entries, hr_dev->caps.max_cqes);
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 	}
 
-	hr_cq = kzalloc(sizeof(*hr_cq), GFP_KERNEL);
-	if (!hr_cq)
-		return ERR_PTR(-ENOMEM);
-
 	if (hr_dev->caps.min_cqes)
 		cq_entries = max(cq_entries, hr_dev->caps.min_cqes);
 
@@ -415,7 +411,7 @@ struct ib_cq *hns_roce_ib_create_cq(struct ib_device *ib_dev,
 			goto err_cqc;
 	}
 
-	return &hr_cq->ib_cq;
+	return 0;
 
 err_cqc:
 	hns_roce_free_cq(hr_dev, hr_cq);
@@ -438,8 +434,7 @@ struct ib_cq *hns_roce_ib_create_cq(struct ib_device *ib_dev,
 		hns_roce_free_db(hr_dev, &hr_cq->db);
 
 err_cq:
-	kfree(hr_cq);
-	return ERR_PTR(ret);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(hns_roce_ib_create_cq);
 
@@ -471,8 +466,6 @@ void hns_roce_ib_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 		if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RECORD_DB)
 			hns_roce_free_db(hr_dev, &hr_cq->db);
 	}
-
-	kfree(hr_cq);
 }
 EXPORT_SYMBOL_GPL(hns_roce_ib_destroy_cq);
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index fe3962fc7820..2d1e4be22888 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -1205,9 +1205,9 @@ void hns_roce_release_range_qp(struct hns_roce_dev *hr_dev, int base_qpn,
 __be32 send_ieth(const struct ib_send_wr *wr);
 int to_hr_qp_type(int qp_type);
 
-struct ib_cq *hns_roce_ib_create_cq(struct ib_device *ib_dev,
-				    const struct ib_cq_init_attr *attr,
-				    struct ib_udata *udata);
+int hns_roce_ib_create_cq(struct ib_cq *ib_cq,
+			  const struct ib_cq_init_attr *attr,
+			  struct ib_udata *udata);
 
 void hns_roce_ib_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata);
 void hns_roce_free_cq(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq);
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
index 316a58e02942..50a320682bd1 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -717,7 +717,7 @@ static int hns_roce_v1_rsv_lp_qp(struct hns_roce_dev *hr_dev)
 	union ib_gid dgid;
 	u64 subnet_prefix;
 	int attr_mask = 0;
-	int ret = -ENOMEM;
+	int ret;
 	int i, j;
 	u8 queue_en[HNS_ROCE_V1_RESV_QP] = { 0 };
 	u8 phy_port;
@@ -730,10 +730,16 @@ static int hns_roce_v1_rsv_lp_qp(struct hns_roce_dev *hr_dev)
 	/* Reserved cq for loop qp */
 	cq_init_attr.cqe		= HNS_ROCE_MIN_WQE_NUM * 2;
 	cq_init_attr.comp_vector	= 0;
-	cq = hns_roce_ib_create_cq(&hr_dev->ib_dev, &cq_init_attr, NULL);
-	if (IS_ERR(cq)) {
-		dev_err(dev, "Create cq for reserved loop qp failed!");
+
+	ibdev = &hr_dev->ib_dev;
+	cq = rdma_zalloc_drv_obj(ibdev, ib_cq);
+	if (!cq)
 		return -ENOMEM;
+
+	ret = hns_roce_ib_create_cq(cq, &cq_init_attr, NULL);
+	if (ret) {
+		dev_err(dev, "Create cq for reserved loop qp failed!");
+		goto alloc_cq_failed;
 	}
 	free_mr->mr_free_cq = to_hr_cq(cq);
 	free_mr->mr_free_cq->ib_cq.device		= &hr_dev->ib_dev;
@@ -743,7 +749,6 @@ static int hns_roce_v1_rsv_lp_qp(struct hns_roce_dev *hr_dev)
 	free_mr->mr_free_cq->ib_cq.cq_context		= NULL;
 	atomic_set(&free_mr->mr_free_cq->ib_cq.usecnt, 0);
 
-	ibdev = &hr_dev->ib_dev;
 	pd = rdma_zalloc_drv_obj(ibdev, ib_pd);
 	if (!pd)
 		goto alloc_mem_failed;
@@ -866,7 +871,8 @@ static int hns_roce_v1_rsv_lp_qp(struct hns_roce_dev *hr_dev)
 
 alloc_mem_failed:
 	hns_roce_ib_destroy_cq(cq, NULL);
-
+alloc_cq_failed:
+	kfree(cq);
 	return ret;
 }
 
@@ -894,6 +900,7 @@ static void hns_roce_v1_release_lp_qp(struct hns_roce_dev *hr_dev)
 	}
 
 	hns_roce_ib_destroy_cq(&free_mr->mr_free_cq->ib_cq, NULL);
+	kfree(&free_mr->mr_free_cq->ib_cq);
 	hns_roce_dealloc_pd(&free_mr->mr_free_pd->ibpd, NULL);
 	kfree(&free_mr->mr_free_pd->ibpd);
 }
@@ -3695,8 +3702,6 @@ static void hns_roce_v1_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 		cq_buf_size = (ibcq->cqe + 1) * hr_dev->caps.cq_entry_sz;
 		hns_roce_buf_free(hr_dev, cq_buf_size, &hr_cq->hr_buf.hr_buf);
 	}
-
-	kfree(hr_cq);
 }
 
 static void set_eq_cons_index_v1(struct hns_roce_eq *eq, int req_not)
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index a6c5c67d0b87..bc0712badb71 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -442,6 +442,7 @@ static const struct ib_device_ops hns_roce_dev_ops = {
 	.reg_user_mr = hns_roce_reg_user_mr,
 
 	INIT_RDMA_OBJ_SIZE(ib_ah, hns_roce_ah, ibah),
+	INIT_RDMA_OBJ_SIZE(ib_cq, hns_roce_cq, ib_cq),
 	INIT_RDMA_OBJ_SIZE(ib_pd, hns_roce_pd, ibpd),
 	INIT_RDMA_OBJ_SIZE(ib_ucontext, hns_roce_ucontext, ibucontext),
 };
diff --git a/drivers/infiniband/hw/i40iw/i40iw_verbs.c b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
index 3c4f8e015d6a..444820b504a6 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
@@ -1075,27 +1075,27 @@ static void i40iw_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 	cq = &iwcq->sc_cq;
 	i40iw_cq_wq_destroy(iwdev, cq);
 	cq_free_resources(iwdev, iwcq);
-	kfree(iwcq);
 	i40iw_rem_devusecount(iwdev);
 }
 
 /**
  * i40iw_create_cq - create cq
- * @ibdev: device pointer from stack
+ * @ibcq: CQ allocated
  * @attr: attributes for cq
  * @udata: user data
  */
-static struct ib_cq *i40iw_create_cq(struct ib_device *ibdev,
-				     const struct ib_cq_init_attr *attr,
-				     struct ib_udata *udata)
+static int i40iw_create_cq(struct ib_cq *ibcq,
+			   const struct ib_cq_init_attr *attr,
+			   struct ib_udata *udata)
 {
+	struct ib_device *ibdev = ibcq->device;
 	struct i40iw_device *iwdev = to_iwdev(ibdev);
-	struct i40iw_cq *iwcq;
+	struct i40iw_cq *iwcq = to_iwcq(ibcq);
 	struct i40iw_pbl *iwpbl;
 	u32 cq_num = 0;
 	struct i40iw_sc_cq *cq;
 	struct i40iw_sc_dev *dev = &iwdev->sc_dev;
-	struct i40iw_cq_init_info info;
+	struct i40iw_cq_init_info info = {};
 	enum i40iw_status_code status;
 	struct i40iw_cqp_request *cqp_request;
 	struct cqp_commands_info *cqp_info;
@@ -1105,22 +1105,16 @@ static struct ib_cq *i40iw_create_cq(struct ib_device *ibdev,
 	int entries = attr->cqe;
 
 	if (iwdev->closing)
-		return ERR_PTR(-ENODEV);
+		return -ENODEV;
 
 	if (entries > iwdev->max_cqe)
-		return ERR_PTR(-EINVAL);
-
-	iwcq = kzalloc(sizeof(*iwcq), GFP_KERNEL);
-	if (!iwcq)
-		return ERR_PTR(-ENOMEM);
-
-	memset(&info, 0, sizeof(info));
+		return -EINVAL;
 
 	err_code = i40iw_alloc_resource(iwdev, iwdev->allocated_cqs,
 					iwdev->max_cq, &cq_num,
 					&iwdev->next_cq);
 	if (err_code)
-		goto error;
+		return err_code;
 
 	cq = &iwcq->sc_cq;
 	cq->back_cq = (void *)iwcq;
@@ -1227,15 +1221,13 @@ static struct ib_cq *i40iw_create_cq(struct ib_device *ibdev,
 	}
 
 	i40iw_add_devusecount(iwdev);
-	return (struct ib_cq *)iwcq;
+	return 0;
 
 cq_destroy:
 	i40iw_cq_wq_destroy(iwdev, cq);
 cq_free_resources:
 	cq_free_resources(iwdev, iwcq);
-error:
-	kfree(iwcq);
-	return ERR_PTR(err_code);
+	return err_code;
 }
 
 /**
@@ -2688,6 +2680,7 @@ static const struct ib_device_ops i40iw_dev_ops = {
 	.reg_user_mr = i40iw_reg_user_mr,
 	.req_notify_cq = i40iw_req_notify_cq,
 	INIT_RDMA_OBJ_SIZE(ib_pd, i40iw_pd, ibpd),
+	INIT_RDMA_OBJ_SIZE(ib_cq, i40iw_cq, ibcq),
 	INIT_RDMA_OBJ_SIZE(ib_ucontext, i40iw_ucontext, ibucontext),
 };
 
diff --git a/drivers/infiniband/hw/mlx4/cq.c b/drivers/infiniband/hw/mlx4/cq.c
index 8eb7490dabb8..72f238ddafb5 100644
--- a/drivers/infiniband/hw/mlx4/cq.c
+++ b/drivers/infiniband/hw/mlx4/cq.c
@@ -172,14 +172,14 @@ static int mlx4_ib_get_cq_umem(struct mlx4_ib_dev *dev, struct ib_udata *udata,
 }
 
 #define CQ_CREATE_FLAGS_SUPPORTED IB_UVERBS_CQ_FLAGS_TIMESTAMP_COMPLETION
-struct ib_cq *mlx4_ib_create_cq(struct ib_device *ibdev,
-				const struct ib_cq_init_attr *attr,
-				struct ib_udata *udata)
+int mlx4_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
+		      struct ib_udata *udata)
 {
+	struct ib_device *ibdev = ibcq->device;
 	int entries = attr->cqe;
 	int vector = attr->comp_vector;
 	struct mlx4_ib_dev *dev = to_mdev(ibdev);
-	struct mlx4_ib_cq *cq;
+	struct mlx4_ib_cq *cq = to_mcq(ibcq);
 	struct mlx4_uar *uar;
 	void *buf_addr;
 	int err;
@@ -187,14 +187,10 @@ struct ib_cq *mlx4_ib_create_cq(struct ib_device *ibdev,
 		udata, struct mlx4_ib_ucontext, ibucontext);
 
 	if (entries < 1 || entries > dev->dev->caps.max_cqes)
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 
 	if (attr->flags & ~CQ_CREATE_FLAGS_SUPPORTED)
-		return ERR_PTR(-EINVAL);
-
-	cq = kzalloc(sizeof(*cq), GFP_KERNEL);
-	if (!cq)
-		return ERR_PTR(-ENOMEM);
+		return -EINVAL;
 
 	entries      = roundup_pow_of_two(entries + 1);
 	cq->ibcq.cqe = entries - 1;
@@ -269,7 +265,7 @@ struct ib_cq *mlx4_ib_create_cq(struct ib_device *ibdev,
 			goto err_cq_free;
 		}
 
-	return &cq->ibcq;
+	return 0;
 
 err_cq_free:
 	mlx4_cq_free(dev->dev, &cq->mcq);
@@ -289,11 +285,8 @@ struct ib_cq *mlx4_ib_create_cq(struct ib_device *ibdev,
 err_db:
 	if (!udata)
 		mlx4_db_free(dev->dev, &cq->db);
-
 err_cq:
-	kfree(cq);
-
-	return ERR_PTR(err);
+	return err;
 }
 
 static int mlx4_alloc_resize_buf(struct mlx4_ib_dev *dev, struct mlx4_ib_cq *cq,
@@ -506,8 +499,6 @@ void mlx4_ib_destroy_cq(struct ib_cq *cq, struct ib_udata *udata)
 		mlx4_ib_free_cq_buf(dev, &mcq->buf, cq->cqe);
 		mlx4_db_free(dev->dev, &mcq->db);
 	}
-
-	kfree(mcq);
 }
 
 static void dump_cqe(void *cqe)
diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
index 25d09d53b51c..5ea2df8d2424 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -2560,6 +2560,7 @@ static const struct ib_device_ops mlx4_ib_dev_ops = {
 	.resize_cq = mlx4_ib_resize_cq,
 
 	INIT_RDMA_OBJ_SIZE(ib_ah, mlx4_ib_ah, ibah),
+	INIT_RDMA_OBJ_SIZE(ib_cq, mlx4_ib_cq, ibcq),
 	INIT_RDMA_OBJ_SIZE(ib_pd, mlx4_ib_pd, ibpd),
 	INIT_RDMA_OBJ_SIZE(ib_srq, mlx4_ib_srq, ibsrq),
 	INIT_RDMA_OBJ_SIZE(ib_ucontext, mlx4_ib_ucontext, ibucontext),
diff --git a/drivers/infiniband/hw/mlx4/mlx4_ib.h b/drivers/infiniband/hw/mlx4/mlx4_ib.h
index af5ee45a9f19..81b3d85e5167 100644
--- a/drivers/infiniband/hw/mlx4/mlx4_ib.h
+++ b/drivers/infiniband/hw/mlx4/mlx4_ib.h
@@ -743,9 +743,8 @@ int mlx4_ib_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg, int sg_nents,
 		      unsigned int *sg_offset);
 int mlx4_ib_modify_cq(struct ib_cq *cq, u16 cq_count, u16 cq_period);
 int mlx4_ib_resize_cq(struct ib_cq *ibcq, int entries, struct ib_udata *udata);
-struct ib_cq *mlx4_ib_create_cq(struct ib_device *ibdev,
-				const struct ib_cq_init_attr *attr,
-				struct ib_udata *udata);
+int mlx4_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
+		      struct ib_udata *udata);
 void mlx4_ib_destroy_cq(struct ib_cq *cq, struct ib_udata *udata);
 int mlx4_ib_poll_cq(struct ib_cq *ibcq, int num_entries, struct ib_wc *wc);
 int mlx4_ib_arm_cq(struct ib_cq *cq, enum ib_cq_notify_flags flags);
diff --git a/drivers/infiniband/hw/mlx5/cq.c b/drivers/infiniband/hw/mlx5/cq.c
index ebd01bd7f8f6..07b73df0e1a3 100644
--- a/drivers/infiniband/hw/mlx5/cq.c
+++ b/drivers/infiniband/hw/mlx5/cq.c
@@ -884,14 +884,14 @@ static void notify_soft_wc_handler(struct work_struct *work)
 	cq->ibcq.comp_handler(&cq->ibcq, cq->ibcq.cq_context);
 }
 
-struct ib_cq *mlx5_ib_create_cq(struct ib_device *ibdev,
-				const struct ib_cq_init_attr *attr,
-				struct ib_udata *udata)
+int mlx5_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
+		      struct ib_udata *udata)
 {
+	struct ib_device *ibdev = ibcq->device;
 	int entries = attr->cqe;
 	int vector = attr->comp_vector;
 	struct mlx5_ib_dev *dev = to_mdev(ibdev);
-	struct mlx5_ib_cq *cq;
+	struct mlx5_ib_cq *cq = to_mcq(ibcq);
 	int uninitialized_var(index);
 	int uninitialized_var(inlen);
 	u32 *cqb = NULL;
@@ -903,18 +903,14 @@ struct ib_cq *mlx5_ib_create_cq(struct ib_device *ibdev,
 
 	if (entries < 0 ||
 	    (entries > (1 << MLX5_CAP_GEN(dev->mdev, log_max_cq_sz))))
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 
 	if (check_cq_create_flags(attr->flags))
-		return ERR_PTR(-EOPNOTSUPP);
+		return -EOPNOTSUPP;
 
 	entries = roundup_pow_of_two(entries + 1);
 	if (entries > (1 << MLX5_CAP_GEN(dev->mdev, log_max_cq_sz)))
-		return ERR_PTR(-EINVAL);
-
-	cq = kzalloc(sizeof(*cq), GFP_KERNEL);
-	if (!cq)
-		return ERR_PTR(-ENOMEM);
+		return -EINVAL;
 
 	cq->ibcq.cqe = entries - 1;
 	mutex_init(&cq->resize_mutex);
@@ -929,13 +925,13 @@ struct ib_cq *mlx5_ib_create_cq(struct ib_device *ibdev,
 		err = create_cq_user(dev, udata, cq, entries, &cqb, &cqe_size,
 				     &index, &inlen);
 		if (err)
-			goto err_create;
+			return err;
 	} else {
 		cqe_size = cache_line_size() == 128 ? 128 : 64;
 		err = create_cq_kernel(dev, cq, entries, cqe_size, &cqb,
 				       &index, &inlen);
 		if (err)
-			goto err_create;
+			return err;
 
 		INIT_WORK(&cq->notify_work, notify_soft_wc_handler);
 	}
@@ -980,7 +976,7 @@ struct ib_cq *mlx5_ib_create_cq(struct ib_device *ibdev,
 
 
 	kvfree(cqb);
-	return &cq->ibcq;
+	return 0;
 
 err_cmd:
 	mlx5_core_destroy_cq(dev->mdev, &cq->mcq);
@@ -991,11 +987,7 @@ struct ib_cq *mlx5_ib_create_cq(struct ib_device *ibdev,
 		destroy_cq_user(cq, udata);
 	else
 		destroy_cq_kernel(dev, cq);
-
-err_create:
-	kfree(cq);
-
-	return ERR_PTR(err);
+	return err;
 }
 
 void mlx5_ib_destroy_cq(struct ib_cq *cq, struct ib_udata *udata)
@@ -1008,8 +1000,6 @@ void mlx5_ib_destroy_cq(struct ib_cq *cq, struct ib_udata *udata)
 		destroy_cq_user(mcq, udata);
 	else
 		destroy_cq_kernel(dev, mcq);
-
-	kfree(mcq);
 }
 
 static int is_equal_rsn(struct mlx5_cqe64 *cqe64, u32 rsn)
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 4479edfb4860..327c6b79a8c0 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -4891,18 +4891,19 @@ static int create_dev_resources(struct mlx5_ib_resources *devr)
 	if (ret)
 		goto error0;
 
-	devr->c0 = mlx5_ib_create_cq(&dev->ib_dev, &cq_attr, NULL);
-	if (IS_ERR(devr->c0)) {
-		ret = PTR_ERR(devr->c0);
+	devr->c0 = rdma_zalloc_drv_obj(ibdev, ib_cq);
+	if (!devr->c0) {
+		ret = -ENOMEM;
 		goto error1;
 	}
-	devr->c0->device        = &dev->ib_dev;
-	devr->c0->uobject       = NULL;
-	devr->c0->comp_handler  = NULL;
-	devr->c0->event_handler = NULL;
-	devr->c0->cq_context    = NULL;
+
+	devr->c0->device = &dev->ib_dev;
 	atomic_set(&devr->c0->usecnt, 0);
 
+	ret = mlx5_ib_create_cq(devr->c0, &cq_attr, NULL);
+	if (ret)
+		goto err_create_cq;
+
 	devr->x0 = mlx5_ib_alloc_xrcd(&dev->ib_dev, NULL);
 	if (IS_ERR(devr->x0)) {
 		ret = PTR_ERR(devr->x0);
@@ -4994,6 +4995,8 @@ static int create_dev_resources(struct mlx5_ib_resources *devr)
 	mlx5_ib_dealloc_xrcd(devr->x0, NULL);
 error2:
 	mlx5_ib_destroy_cq(devr->c0, NULL);
+err_create_cq:
+	kfree(devr->c0);
 error1:
 	mlx5_ib_dealloc_pd(devr->p0, NULL);
 error0:
@@ -5012,6 +5015,7 @@ static void destroy_dev_resources(struct mlx5_ib_resources *devr)
 	mlx5_ib_dealloc_xrcd(devr->x0, NULL);
 	mlx5_ib_dealloc_xrcd(devr->x1, NULL);
 	mlx5_ib_destroy_cq(devr->c0, NULL);
+	kfree(devr->c0);
 	mlx5_ib_dealloc_pd(devr->p0, NULL);
 	kfree(devr->p0);
 
@@ -6253,6 +6257,7 @@ static const struct ib_device_ops mlx5_ib_dev_ops = {
 	.resize_cq = mlx5_ib_resize_cq,
 
 	INIT_RDMA_OBJ_SIZE(ib_ah, mlx5_ib_ah, ibah),
+	INIT_RDMA_OBJ_SIZE(ib_cq, mlx5_ib_cq, ibcq),
 	INIT_RDMA_OBJ_SIZE(ib_pd, mlx5_ib_pd, ibpd),
 	INIT_RDMA_OBJ_SIZE(ib_srq, mlx5_ib_srq, ibsrq),
 	INIT_RDMA_OBJ_SIZE(ib_ucontext, mlx5_ib_ucontext, ibucontext),
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 3466d0c0c18c..0ecab660ae7e 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1119,9 +1119,8 @@ int mlx5_ib_read_user_wqe_rq(struct mlx5_ib_qp *qp, int wqe_index, void *buffer,
 			     int buflen, size_t *bc);
 int mlx5_ib_read_user_wqe_srq(struct mlx5_ib_srq *srq, int wqe_index,
 			      void *buffer, int buflen, size_t *bc);
-struct ib_cq *mlx5_ib_create_cq(struct ib_device *ibdev,
-				const struct ib_cq_init_attr *attr,
-				struct ib_udata *udata);
+int mlx5_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
+		      struct ib_udata *udata);
 void mlx5_ib_destroy_cq(struct ib_cq *cq, struct ib_udata *udata);
 int mlx5_ib_poll_cq(struct ib_cq *ibcq, int num_entries, struct ib_wc *wc);
 int mlx5_ib_arm_cq(struct ib_cq *ibcq, enum ib_cq_notify_flags flags);
diff --git a/drivers/infiniband/hw/mthca/mthca_provider.c b/drivers/infiniband/hw/mthca/mthca_provider.c
index 2c6a1ee0d6cc..a6eb441ca8f5 100644
--- a/drivers/infiniband/hw/mthca/mthca_provider.c
+++ b/drivers/infiniband/hw/mthca/mthca_provider.c
@@ -601,10 +601,11 @@ static int mthca_destroy_qp(struct ib_qp *qp, struct ib_udata *udata)
 	return 0;
 }
 
-static struct ib_cq *mthca_create_cq(struct ib_device *ibdev,
-				     const struct ib_cq_init_attr *attr,
-				     struct ib_udata *udata)
+static int mthca_create_cq(struct ib_cq *ibcq,
+			   const struct ib_cq_init_attr *attr,
+			   struct ib_udata *udata)
 {
+	struct ib_device *ibdev = ibcq->device;
 	int entries = attr->cqe;
 	struct mthca_create_cq ucmd;
 	struct mthca_cq *cq;
@@ -614,20 +615,20 @@ static struct ib_cq *mthca_create_cq(struct ib_device *ibdev,
 		udata, struct mthca_ucontext, ibucontext);
 
 	if (attr->flags)
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 
 	if (entries < 1 || entries > to_mdev(ibdev)->limits.max_cqes)
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 
 	if (udata) {
-		if (ib_copy_from_udata(&ucmd, udata, sizeof ucmd))
-			return ERR_PTR(-EFAULT);
+		if (ib_copy_from_udata(&ucmd, udata, sizeof(ucmd)))
+			return -EFAULT;
 
 		err = mthca_map_user_db(to_mdev(ibdev), &context->uar,
 					context->db_tab, ucmd.set_db_index,
 					ucmd.set_db_page);
 		if (err)
-			return ERR_PTR(err);
+			return err;
 
 		err = mthca_map_user_db(to_mdev(ibdev), &context->uar,
 					context->db_tab, ucmd.arm_db_index,
@@ -636,11 +637,7 @@ static struct ib_cq *mthca_create_cq(struct ib_device *ibdev,
 			goto err_unmap_set;
 	}
 
-	cq = kzalloc(sizeof(*cq), GFP_KERNEL);
-	if (!cq) {
-		err = -ENOMEM;
-		goto err_unmap_arm;
-	}
+	cq = to_mcq(ibcq);
 
 	if (udata) {
 		cq->buf.mr.ibmr.lkey = ucmd.lkey;
@@ -655,20 +652,17 @@ static struct ib_cq *mthca_create_cq(struct ib_device *ibdev,
 			    udata ? ucmd.pdn : to_mdev(ibdev)->driver_pd.pd_num,
 			    cq);
 	if (err)
-		goto err_free;
+		goto err_unmap_arm;
 
 	if (udata && ib_copy_to_udata(udata, &cq->cqn, sizeof(__u32))) {
 		mthca_free_cq(to_mdev(ibdev), cq);
 		err = -EFAULT;
-		goto err_free;
+		goto err_unmap_arm;
 	}
 
 	cq->resize_buf = NULL;
 
-	return &cq->ibcq;
-
-err_free:
-	kfree(cq);
+	return 0;
 
 err_unmap_arm:
 	if (udata)
@@ -680,7 +674,7 @@ static struct ib_cq *mthca_create_cq(struct ib_device *ibdev,
 		mthca_unmap_user_db(to_mdev(ibdev), &context->uar,
 				    context->db_tab, ucmd.set_db_index);
 
-	return ERR_PTR(err);
+	return err;
 }
 
 static int mthca_alloc_resize_buf(struct mthca_dev *dev, struct mthca_cq *cq,
@@ -823,7 +817,6 @@ static void mthca_destroy_cq(struct ib_cq *cq, struct ib_udata *udata)
 				    to_mcq(cq)->set_ci_db_index);
 	}
 	mthca_free_cq(to_mdev(cq->device), to_mcq(cq));
-	kfree(cq);
 }
 
 static inline u32 convert_access(int acc)
@@ -1183,6 +1176,7 @@ static const struct ib_device_ops mthca_dev_ops = {
 	.resize_cq = mthca_resize_cq,
 
 	INIT_RDMA_OBJ_SIZE(ib_ah, mthca_ah, ibah),
+	INIT_RDMA_OBJ_SIZE(ib_cq, mthca_cq, ibcq),
 	INIT_RDMA_OBJ_SIZE(ib_pd, mthca_pd, ibpd),
 	INIT_RDMA_OBJ_SIZE(ib_ucontext, mthca_ucontext, ibucontext),
 };
diff --git a/drivers/infiniband/hw/nes/nes_verbs.c b/drivers/infiniband/hw/nes/nes_verbs.c
index fc847440502f..85b9d642428a 100644
--- a/drivers/infiniband/hw/nes/nes_verbs.c
+++ b/drivers/infiniband/hw/nes/nes_verbs.c
@@ -1374,16 +1374,17 @@ static int nes_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 /**
  * nes_create_cq
  */
-static struct ib_cq *nes_create_cq(struct ib_device *ibdev,
+static int nes_create_cq(struct ib_cq *ibcq,
 				   const struct ib_cq_init_attr *attr,
 				   struct ib_udata *udata)
 {
+	struct ib_device *ibdev = ibcq->device;
 	int entries = attr->cqe;
 	u64 u64temp;
 	struct nes_vnic *nesvnic = to_nesvnic(ibdev);
 	struct nes_device *nesdev = nesvnic->nesdev;
 	struct nes_adapter *nesadapter = nesdev->nesadapter;
-	struct nes_cq *nescq;
+	struct nes_cq *nescq = to_nescq(ibcq);
 	struct nes_ucontext *nes_ucontext = NULL;
 	struct nes_cqp_request *cqp_request;
 	void *mem = NULL;
@@ -1399,22 +1400,15 @@ static struct ib_cq *nes_create_cq(struct ib_device *ibdev,
 	int ret;
 
 	if (attr->flags)
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 
 	if (entries > nesadapter->max_cqe)
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 
 	err = nes_alloc_resource(nesadapter, nesadapter->allocated_cqs,
 			nesadapter->max_cq, &cq_num, &nesadapter->next_cq, NES_RESOURCE_CQ);
-	if (err) {
-		return ERR_PTR(err);
-	}
-
-	nescq = kzalloc(sizeof(struct nes_cq), GFP_KERNEL);
-	if (!nescq) {
-		nes_free_resource(nesadapter, nesadapter->allocated_cqs, cq_num);
-		return ERR_PTR(-ENOMEM);
-	}
+	if (err)
+		return err;
 
 	nescq->hw_cq.cq_size = max(entries + 1, 5);
 	nescq->hw_cq.cq_number = cq_num;
@@ -1424,10 +1418,10 @@ static struct ib_cq *nes_create_cq(struct ib_device *ibdev,
 		struct nes_ucontext *nes_ucontext = rdma_udata_to_drv_context(
 			udata, struct nes_ucontext, ibucontext);
 
-		if (ib_copy_from_udata(&req, udata, sizeof (struct nes_create_cq_req))) {
+		if (ib_copy_from_udata(&req, udata,
+				       sizeof(struct nes_create_cq_req))) {
 			nes_free_resource(nesadapter, nesadapter->allocated_cqs, cq_num);
-			kfree(nescq);
-			return ERR_PTR(-EFAULT);
+			return -EFAULT;
 		}
 		nesvnic->mcrq_ucontext = nes_ucontext;
 		nes_ucontext->mcrqf = req.mcrqf;
@@ -1441,8 +1435,6 @@ static struct ib_cq *nes_create_cq(struct ib_device *ibdev,
 			nescq->mcrqf = nes_ucontext->mcrqf;
 			nes_free_resource(nesadapter, nesadapter->allocated_cqs, cq_num);
 		}
-		nes_debug(NES_DBG_CQ, "CQ Virtual Address = %08lX, size = %u.\n",
-				(unsigned long)req.user_cq_buffer, entries);
 		err = 1;
 		list_for_each_entry(nespbl, &nes_ucontext->cq_reg_mem_list, list) {
 			if (nespbl->user_base == (unsigned long )req.user_cq_buffer) {
@@ -1455,8 +1447,7 @@ static struct ib_cq *nes_create_cq(struct ib_device *ibdev,
 		}
 		if (err) {
 			nes_free_resource(nesadapter, nesadapter->allocated_cqs, cq_num);
-			kfree(nescq);
-			return ERR_PTR(-EFAULT);
+			return -EFAULT;
 		}
 
 		pbl_entries = nespbl->pbl_size >> 3;
@@ -1472,15 +1463,11 @@ static struct ib_cq *nes_create_cq(struct ib_device *ibdev,
 		if (!mem) {
 			printk(KERN_ERR PFX "Unable to allocate pci memory for cq\n");
 			nes_free_resource(nesadapter, nesadapter->allocated_cqs, cq_num);
-			kfree(nescq);
-			return ERR_PTR(-ENOMEM);
+			return -ENOMEM;
 		}
 
 		nescq->hw_cq.cq_vbase = mem;
 		nescq->hw_cq.cq_head = 0;
-		nes_debug(NES_DBG_CQ, "CQ%u virtual address @ %p, phys = 0x%08X\n",
-				nescq->hw_cq.cq_number, nescq->hw_cq.cq_vbase,
-				(u32)nescq->hw_cq.cq_pbase);
 	}
 
 	nescq->hw_cq.ce_handler = nes_iwarp_ce_handler;
@@ -1500,8 +1487,7 @@ static struct ib_cq *nes_create_cq(struct ib_device *ibdev,
 		}
 
 		nes_free_resource(nesadapter, nesadapter->allocated_cqs, cq_num);
-		kfree(nescq);
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 	}
 	cqp_request->waiting = 1;
 	cqp_wqe = &cqp_request->cqp_wqe;
@@ -1528,8 +1514,7 @@ static struct ib_cq *nes_create_cq(struct ib_device *ibdev,
 					kfree(nespbl);
 				}
 				nes_free_resource(nesadapter, nesadapter->allocated_cqs, cq_num);
-				kfree(nescq);
-				return ERR_PTR(-ENOMEM);
+				return -ENOMEM;
 			} else {
 				opcode |= (NES_CQP_CQ_VIRT | NES_CQP_CQ_4KB_CHUNK);
 				nescq->virtual_cq = 2;
@@ -1550,8 +1535,7 @@ static struct ib_cq *nes_create_cq(struct ib_device *ibdev,
 					kfree(nespbl);
 				}
 				nes_free_resource(nesadapter, nesadapter->allocated_cqs, cq_num);
-				kfree(nescq);
-				return ERR_PTR(-ENOMEM);
+				return -ENOMEM;
 			} else {
 				opcode |= NES_CQP_CQ_VIRT;
 				nescq->virtual_cq = 1;
@@ -1607,8 +1591,7 @@ static struct ib_cq *nes_create_cq(struct ib_device *ibdev,
 			kfree(nespbl);
 		}
 		nes_free_resource(nesadapter, nesadapter->allocated_cqs, cq_num);
-		kfree(nescq);
-		return ERR_PTR(-EIO);
+		return -EIO;
 	}
 	nes_put_cqp_request(nesdev, cqp_request);
 
@@ -1620,17 +1603,16 @@ static struct ib_cq *nes_create_cq(struct ib_device *ibdev,
 		resp.cq_id = nescq->hw_cq.cq_number;
 		resp.cq_size = nescq->hw_cq.cq_size;
 		resp.mmap_db_index = 0;
-		if (ib_copy_to_udata(udata, &resp, sizeof resp - sizeof resp.reserved)) {
+		if (ib_copy_to_udata(udata, &resp,
+				     sizeof(resp) - sizeof(resp.reserved))) {
 			nes_free_resource(nesadapter, nesadapter->allocated_cqs, cq_num);
-			kfree(nescq);
-			return ERR_PTR(-EFAULT);
+			return -EFAULT;
 		}
 	}
 
-	return &nescq->ibcq;
+	return 0;
 }
 
-
 /**
  * nes_destroy_cq
  */
@@ -1700,7 +1682,6 @@ static void nes_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 	if (nescq->cq_mem_size)
 		pci_free_consistent(nesdev->pcidev, nescq->cq_mem_size,
 				    nescq->hw_cq.cq_vbase, nescq->hw_cq.cq_pbase);
-	kfree(nescq);
 }
 
 /**
@@ -3579,6 +3560,7 @@ static const struct ib_device_ops nes_dev_ops = {
 	.reg_user_mr = nes_reg_user_mr,
 	.req_notify_cq = nes_req_notify_cq,
 	INIT_RDMA_OBJ_SIZE(ib_pd, nes_pd, ibpd),
+	INIT_RDMA_OBJ_SIZE(ib_cq, nes_cq, ibcq),
 	INIT_RDMA_OBJ_SIZE(ib_ucontext, nes_ucontext, ibucontext),
 };
 
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_main.c b/drivers/infiniband/hw/ocrdma/ocrdma_main.c
index fc6c0962dea9..79045613862f 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_main.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_main.c
@@ -178,6 +178,7 @@ static const struct ib_device_ops ocrdma_dev_ops = {
 	.resize_cq = ocrdma_resize_cq,
 
 	INIT_RDMA_OBJ_SIZE(ib_ah, ocrdma_ah, ibah),
+	INIT_RDMA_OBJ_SIZE(ib_cq, ocrdma_cq, ibcq),
 	INIT_RDMA_OBJ_SIZE(ib_pd, ocrdma_pd, ibpd),
 	INIT_RDMA_OBJ_SIZE(ib_ucontext, ocrdma_ucontext, ibucontext),
 };
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
index 94e4f7f9b1f7..10b35edb286b 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
@@ -977,12 +977,12 @@ static int ocrdma_copy_cq_uresp(struct ocrdma_dev *dev, struct ocrdma_cq *cq,
 	return status;
 }
 
-struct ib_cq *ocrdma_create_cq(struct ib_device *ibdev,
-			       const struct ib_cq_init_attr *attr,
-			       struct ib_udata *udata)
+int ocrdma_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
+		     struct ib_udata *udata)
 {
+	struct ib_device *ibdev = ibcq->device;
 	int entries = attr->cqe;
-	struct ocrdma_cq *cq;
+	struct ocrdma_cq *cq = get_ocrdma_cq(ibcq);
 	struct ocrdma_dev *dev = get_ocrdma_dev(ibdev);
 	struct ocrdma_ucontext *uctx = rdma_udata_to_drv_context(
 		udata, struct ocrdma_ucontext, ibucontext);
@@ -991,16 +991,13 @@ struct ib_cq *ocrdma_create_cq(struct ib_device *ibdev,
 	struct ocrdma_create_cq_ureq ureq;
 
 	if (attr->flags)
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 
 	if (udata) {
 		if (ib_copy_from_udata(&ureq, udata, sizeof(ureq)))
-			return ERR_PTR(-EFAULT);
+			return -EFAULT;
 	} else
 		ureq.dpp_cq = 0;
-	cq = kzalloc(sizeof(*cq), GFP_KERNEL);
-	if (!cq)
-		return ERR_PTR(-ENOMEM);
 
 	spin_lock_init(&cq->cq_lock);
 	spin_lock_init(&cq->comp_handler_lock);
@@ -1011,10 +1008,9 @@ struct ib_cq *ocrdma_create_cq(struct ib_device *ibdev,
 		pd_id = uctx->cntxt_pd->id;
 
 	status = ocrdma_mbx_create_cq(dev, cq, entries, ureq.dpp_cq, pd_id);
-	if (status) {
-		kfree(cq);
-		return ERR_PTR(status);
-	}
+	if (status)
+		return status;
+
 	if (udata) {
 		status = ocrdma_copy_cq_uresp(dev, cq, udata);
 		if (status)
@@ -1022,12 +1018,11 @@ struct ib_cq *ocrdma_create_cq(struct ib_device *ibdev,
 	}
 	cq->phase = OCRDMA_CQE_VALID;
 	dev->cq_tbl[cq->id] = cq;
-	return &cq->ibcq;
+	return 0;
 
 ctx_err:
 	ocrdma_mbx_destroy_cq(dev, cq);
-	kfree(cq);
-	return ERR_PTR(status);
+	return status;
 }
 
 int ocrdma_resize_cq(struct ib_cq *ibcq, int new_cnt,
@@ -1095,8 +1090,6 @@ void ocrdma_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 				ocrdma_get_db_addr(dev, pdid),
 				dev->nic_info.db_page_size);
 	}
-
-	kfree(cq);
 }
 
 static int ocrdma_add_qpn_map(struct ocrdma_dev *dev, struct ocrdma_qp *qp)
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.h b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.h
index 89cebe05669e..32488da1b752 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.h
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.h
@@ -71,9 +71,8 @@ int ocrdma_mmap(struct ib_ucontext *, struct vm_area_struct *vma);
 int ocrdma_alloc_pd(struct ib_pd *pd, struct ib_udata *udata);
 void ocrdma_dealloc_pd(struct ib_pd *pd, struct ib_udata *udata);
 
-struct ib_cq *ocrdma_create_cq(struct ib_device *ibdev,
-			       const struct ib_cq_init_attr *attr,
-			       struct ib_udata *udata);
+int ocrdma_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
+		     struct ib_udata *udata);
 int ocrdma_resize_cq(struct ib_cq *, int cqe, struct ib_udata *);
 void ocrdma_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata);
 
diff --git a/drivers/infiniband/hw/qedr/main.c b/drivers/infiniband/hw/qedr/main.c
index 083c2c00a8e9..d4b07cbf5d89 100644
--- a/drivers/infiniband/hw/qedr/main.c
+++ b/drivers/infiniband/hw/qedr/main.c
@@ -220,6 +220,7 @@ static const struct ib_device_ops qedr_dev_ops = {
 	.resize_cq = qedr_resize_cq,
 
 	INIT_RDMA_OBJ_SIZE(ib_ah, qedr_ah, ibah),
+	INIT_RDMA_OBJ_SIZE(ib_cq, qedr_cq, ibcq),
 	INIT_RDMA_OBJ_SIZE(ib_pd, qedr_pd, ibpd),
 	INIT_RDMA_OBJ_SIZE(ib_srq, qedr_srq, ibsrq),
 	INIT_RDMA_OBJ_SIZE(ib_ucontext, qedr_ucontext, ibucontext),
diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index be29bbbc4b14..3fc7a4e901c3 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -806,20 +806,20 @@ int qedr_arm_cq(struct ib_cq *ibcq, enum ib_cq_notify_flags flags)
 	return 0;
 }
 
-struct ib_cq *qedr_create_cq(struct ib_device *ibdev,
-			     const struct ib_cq_init_attr *attr,
-			     struct ib_udata *udata)
+int qedr_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
+		   struct ib_udata *udata)
 {
+	struct ib_device *ibdev = ibcq->device;
 	struct qedr_ucontext *ctx = rdma_udata_to_drv_context(
 		udata, struct qedr_ucontext, ibucontext);
 	struct qed_rdma_destroy_cq_out_params destroy_oparams;
 	struct qed_rdma_destroy_cq_in_params destroy_iparams;
 	struct qedr_dev *dev = get_qedr_dev(ibdev);
 	struct qed_rdma_create_cq_in_params params;
-	struct qedr_create_cq_ureq ureq;
+	struct qedr_create_cq_ureq ureq = {};
 	int vector = attr->comp_vector;
 	int entries = attr->cqe;
-	struct qedr_cq *cq;
+	struct qedr_cq *cq = get_qedr_cq(ibcq);
 	int chain_entries;
 	int page_cnt;
 	u64 pbl_ptr;
@@ -834,18 +834,13 @@ struct ib_cq *qedr_create_cq(struct ib_device *ibdev,
 		DP_ERR(dev,
 		       "create cq: the number of entries %d is too high. Must be equal or below %d.\n",
 		       entries, QEDR_MAX_CQES);
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 	}
 
 	chain_entries = qedr_align_cq_entries(entries);
 	chain_entries = min_t(int, chain_entries, QEDR_MAX_CQES);
 
-	cq = kzalloc(sizeof(*cq), GFP_KERNEL);
-	if (!cq)
-		return ERR_PTR(-ENOMEM);
-
 	if (udata) {
-		memset(&ureq, 0, sizeof(ureq));
 		if (ib_copy_from_udata(&ureq, udata, sizeof(ureq))) {
 			DP_ERR(dev,
 			       "create cq: problem copying data from user space\n");
@@ -923,7 +918,7 @@ struct ib_cq *qedr_create_cq(struct ib_device *ibdev,
 		 "create cq: icid=0x%0x, addr=%p, size(entries)=0x%0x\n",
 		 cq->icid, cq, params.cq_size);
 
-	return &cq->ibcq;
+	return 0;
 
 err3:
 	destroy_iparams.icid = cq->icid;
@@ -938,8 +933,7 @@ struct ib_cq *qedr_create_cq(struct ib_device *ibdev,
 	if (udata)
 		ib_umem_release(cq->q.umem);
 err0:
-	kfree(cq);
-	return ERR_PTR(-EINVAL);
+	return -EINVAL;
 }
 
 int qedr_resize_cq(struct ib_cq *ibcq, int new_cnt, struct ib_udata *udata)
@@ -969,7 +963,7 @@ void qedr_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 
 	/* GSIs CQs are handled by driver, so they don't exist in the FW */
 	if (cq->cq_type == QEDR_CQ_TYPE_GSI)
-		goto done;
+		return;
 
 	iparams.icid = cq->icid;
 	dev->ops->rdma_destroy_cq(dev->rdma_ctx, &iparams, &oparams);
@@ -1008,10 +1002,6 @@ void qedr_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 	 * Since the destroy CQ ramrod has also been received on the EQ we can
 	 * be certain that there's no event handler in process.
 	 */
-done:
-	cq->sig = ~cq->sig;
-
-	kfree(cq);
 }
 
 static inline int get_gid_info_from_table(struct ib_qp *ibqp,
diff --git a/drivers/infiniband/hw/qedr/verbs.h b/drivers/infiniband/hw/qedr/verbs.h
index 32d7ce77e339..9aaa90283d6e 100644
--- a/drivers/infiniband/hw/qedr/verbs.h
+++ b/drivers/infiniband/hw/qedr/verbs.h
@@ -50,9 +50,8 @@ int qedr_mmap(struct ib_ucontext *, struct vm_area_struct *vma);
 int qedr_alloc_pd(struct ib_pd *pd, struct ib_udata *udata);
 void qedr_dealloc_pd(struct ib_pd *pd, struct ib_udata *udata);
 
-struct ib_cq *qedr_create_cq(struct ib_device *ibdev,
-			     const struct ib_cq_init_attr *attr,
-			     struct ib_udata *udata);
+int qedr_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
+		   struct ib_udata *udata);
 int qedr_resize_cq(struct ib_cq *, int cqe, struct ib_udata *);
 void qedr_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata);
 int qedr_arm_cq(struct ib_cq *ibcq, enum ib_cq_notify_flags flags);
diff --git a/drivers/infiniband/hw/usnic/usnic_ib.h b/drivers/infiniband/hw/usnic/usnic_ib.h
index 525bf272671e..84dd682d2334 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib.h
+++ b/drivers/infiniband/hw/usnic/usnic_ib.h
@@ -61,6 +61,10 @@ struct usnic_ib_pd {
 	struct usnic_uiom_pd		*umem_pd;
 };
 
+struct usnic_ib_cq {
+	struct ib_cq			ibcq;
+};
+
 struct usnic_ib_mr {
 	struct ib_mr			ibmr;
 	struct usnic_uiom_reg		*umem;
diff --git a/drivers/infiniband/hw/usnic/usnic_ib_main.c b/drivers/infiniband/hw/usnic/usnic_ib_main.c
index d88d9f8a7f9a..dfd50e41d4ee 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_main.c
+++ b/drivers/infiniband/hw/usnic/usnic_ib_main.c
@@ -350,6 +350,7 @@ static const struct ib_device_ops usnic_dev_ops = {
 	.query_qp = usnic_ib_query_qp,
 	.reg_user_mr = usnic_ib_reg_mr,
 	INIT_RDMA_OBJ_SIZE(ib_pd, usnic_ib_pd, ibpd),
+	INIT_RDMA_OBJ_SIZE(ib_cq, usnic_ib_cq, ibcq),
 	INIT_RDMA_OBJ_SIZE(ib_ucontext, usnic_ib_ucontext, ibucontext),
 };
 
diff --git a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
index 5686d14b86fe..eeb07b245ef9 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
+++ b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
@@ -587,26 +587,18 @@ int usnic_ib_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 	return status;
 }
 
-struct ib_cq *usnic_ib_create_cq(struct ib_device *ibdev,
-				 const struct ib_cq_init_attr *attr,
-				 struct ib_udata *udata)
+int usnic_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
+		       struct ib_udata *udata)
 {
-	struct ib_cq *cq;
-
-	usnic_dbg("\n");
 	if (attr->flags)
-		return ERR_PTR(-EINVAL);
-
-	cq = kzalloc(sizeof(*cq), GFP_KERNEL);
-	if (!cq)
-		return ERR_PTR(-EBUSY);
+		return -EINVAL;
 
-	return cq;
+	return 0;
 }
 
 void usnic_ib_destroy_cq(struct ib_cq *cq, struct ib_udata *udata)
 {
-	kfree(cq);
+	return;
 }
 
 struct ib_mr *usnic_ib_reg_mr(struct ib_pd *pd, u64 start, u64 length,
diff --git a/drivers/infiniband/hw/usnic/usnic_ib_verbs.h b/drivers/infiniband/hw/usnic/usnic_ib_verbs.h
index 0b9d993433a7..2aedf78c13cf 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_verbs.h
+++ b/drivers/infiniband/hw/usnic/usnic_ib_verbs.h
@@ -58,9 +58,8 @@ struct ib_qp *usnic_ib_create_qp(struct ib_pd *pd,
 int usnic_ib_destroy_qp(struct ib_qp *qp, struct ib_udata *udata);
 int usnic_ib_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 				int attr_mask, struct ib_udata *udata);
-struct ib_cq *usnic_ib_create_cq(struct ib_device *ibdev,
-				 const struct ib_cq_init_attr *attr,
-				 struct ib_udata *udata);
+int usnic_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
+		       struct ib_udata *udata);
 void usnic_ib_destroy_cq(struct ib_cq *cq, struct ib_udata *udata);
 struct ib_mr *usnic_ib_reg_mr(struct ib_pd *pd, u64 start, u64 length,
 				u64 virt_addr, int access_flags,
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c
index 0682781f6555..38573fc0a9bf 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c
@@ -92,20 +92,19 @@ int pvrdma_req_notify_cq(struct ib_cq *ibcq,
 
 /**
  * pvrdma_create_cq - create completion queue
- * @ibdev: the device
+ * @ibcq: Allocated CQ
  * @attr: completion queue attributes
  * @udata: user data
  *
- * @return: ib_cq completion queue pointer on success,
- *          otherwise returns negative errno.
+ * @return: 0 on success
  */
-struct ib_cq *pvrdma_create_cq(struct ib_device *ibdev,
-			       const struct ib_cq_init_attr *attr,
-			       struct ib_udata *udata)
+int pvrdma_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
+		     struct ib_udata *udata)
 {
+	struct ib_device *ibdev = ibcq->device;
 	int entries = attr->cqe;
 	struct pvrdma_dev *dev = to_vdev(ibdev);
-	struct pvrdma_cq *cq;
+	struct pvrdma_cq *cq = to_vcq(ibcq);
 	int ret;
 	int npages;
 	unsigned long flags;
@@ -113,7 +112,7 @@ struct ib_cq *pvrdma_create_cq(struct ib_device *ibdev,
 	union pvrdma_cmd_resp rsp;
 	struct pvrdma_cmd_create_cq *cmd = &req.create_cq;
 	struct pvrdma_cmd_create_cq_resp *resp = &rsp.create_cq_resp;
-	struct pvrdma_create_cq_resp cq_resp = {0};
+	struct pvrdma_create_cq_resp cq_resp = {};
 	struct pvrdma_create_cq ucmd;
 	struct pvrdma_ucontext *context = rdma_udata_to_drv_context(
 		udata, struct pvrdma_ucontext, ibucontext);
@@ -122,16 +121,10 @@ struct ib_cq *pvrdma_create_cq(struct ib_device *ibdev,
 
 	entries = roundup_pow_of_two(entries);
 	if (entries < 1 || entries > dev->dsr->caps.max_cqe)
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 
 	if (!atomic_add_unless(&dev->num_cqs, 1, dev->dsr->caps.max_cq))
-		return ERR_PTR(-ENOMEM);
-
-	cq = kzalloc(sizeof(*cq), GFP_KERNEL);
-	if (!cq) {
-		atomic_dec(&dev->num_cqs);
-		return ERR_PTR(-ENOMEM);
-	}
+		return -ENOMEM;
 
 	cq->ibcq.cqe = entries;
 	cq->is_kernel = !udata;
@@ -211,11 +204,11 @@ struct ib_cq *pvrdma_create_cq(struct ib_device *ibdev,
 			dev_warn(&dev->pdev->dev,
 				 "failed to copy back udata\n");
 			pvrdma_destroy_cq(&cq->ibcq, udata);
-			return ERR_PTR(-EINVAL);
+			return -EINVAL;
 		}
 	}
 
-	return &cq->ibcq;
+	return 0;
 
 err_page_dir:
 	pvrdma_page_dir_cleanup(dev, &cq->pdir);
@@ -224,9 +217,7 @@ struct ib_cq *pvrdma_create_cq(struct ib_device *ibdev,
 		ib_umem_release(cq->umem);
 err_cq:
 	atomic_dec(&dev->num_cqs);
-	kfree(cq);
-
-	return ERR_PTR(ret);
+	return ret;
 }
 
 static void pvrdma_free_cq(struct pvrdma_dev *dev, struct pvrdma_cq *cq)
@@ -239,7 +230,6 @@ static void pvrdma_free_cq(struct pvrdma_dev *dev, struct pvrdma_cq *cq)
 		ib_umem_release(cq->umem);
 
 	pvrdma_page_dir_cleanup(dev, &cq->pdir);
-	kfree(cq);
 }
 
 /**
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
index 40182297f87f..e3faa5e49f96 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
@@ -178,6 +178,7 @@ static const struct ib_device_ops pvrdma_dev_ops = {
 	.req_notify_cq = pvrdma_req_notify_cq,
 
 	INIT_RDMA_OBJ_SIZE(ib_ah, pvrdma_ah, ibah),
+	INIT_RDMA_OBJ_SIZE(ib_cq, pvrdma_cq, ibcq),
 	INIT_RDMA_OBJ_SIZE(ib_pd, pvrdma_pd, ibpd),
 	INIT_RDMA_OBJ_SIZE(ib_ucontext, pvrdma_ucontext, ibucontext),
 };
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h
index f0dd6e4d058b..e4a48f5c0c85 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h
@@ -409,9 +409,8 @@ struct ib_mr *pvrdma_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
 			      u32 max_num_sg, struct ib_udata *udata);
 int pvrdma_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg,
 		     int sg_nents, unsigned int *sg_offset);
-struct ib_cq *pvrdma_create_cq(struct ib_device *ibdev,
-			       const struct ib_cq_init_attr *attr,
-			       struct ib_udata *udata);
+int pvrdma_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
+		     struct ib_udata *udata);
 void pvrdma_destroy_cq(struct ib_cq *cq, struct ib_udata *udata);
 int pvrdma_poll_cq(struct ib_cq *ibcq, int num_entries, struct ib_wc *wc);
 int pvrdma_req_notify_cq(struct ib_cq *cq, enum ib_cq_notify_flags flags);
diff --git a/drivers/infiniband/sw/rdmavt/cq.c b/drivers/infiniband/sw/rdmavt/cq.c
index 8e76036fad4a..b46714a92b7a 100644
--- a/drivers/infiniband/sw/rdmavt/cq.c
+++ b/drivers/infiniband/sw/rdmavt/cq.c
@@ -166,43 +166,37 @@ static void send_complete(struct work_struct *work)
 
 /**
  * rvt_create_cq - create a completion queue
- * @ibdev: the device this completion queue is attached to
+ * @ibcq: Allocated CQ
  * @attr: creation attributes
  * @udata: user data for libibverbs.so
  *
  * Called by ib_create_cq() in the generic verbs code.
  *
- * Return: pointer to the completion queue or negative errno values
- * for failure.
+ * Return: 0 on success
  */
-struct ib_cq *rvt_create_cq(struct ib_device *ibdev,
-			    const struct ib_cq_init_attr *attr,
-			    struct ib_udata *udata)
+int rvt_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
+		  struct ib_udata *udata)
 {
+	struct ib_device *ibdev = ibcq->device;
 	struct rvt_dev_info *rdi = ib_to_rvt(ibdev);
-	struct rvt_cq *cq;
+	struct rvt_cq *cq = container_of(ibcq, struct rvt_cq, ibcq);
 	struct rvt_cq_wc *wc;
-	struct ib_cq *ret;
 	u32 sz;
 	unsigned int entries = attr->cqe;
 	int comp_vector = attr->comp_vector;
+	int err;
 
 	if (attr->flags)
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 
 	if (entries < 1 || entries > rdi->dparms.props.max_cqe)
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 
 	if (comp_vector < 0)
 		comp_vector = 0;
 
 	comp_vector = comp_vector % rdi->ibdev.num_comp_vectors;
 
-	/* Allocate the completion queue structure. */
-	cq = kzalloc_node(sizeof(*cq), GFP_KERNEL, rdi->dparms.node);
-	if (!cq)
-		return ERR_PTR(-ENOMEM);
-
 	/*
 	 * Allocate the completion queue entries and head/tail pointers.
 	 * This is allocated separately so that it can be resized and
@@ -218,36 +212,29 @@ struct ib_cq *rvt_create_cq(struct ib_device *ibdev,
 	wc = udata ?
 		vmalloc_user(sz) :
 		vzalloc_node(sz, rdi->dparms.node);
-	if (!wc) {
-		ret = ERR_PTR(-ENOMEM);
-		goto bail_cq;
-	}
-
+	if (!wc)
+		return -ENOMEM;
 	/*
 	 * Return the address of the WC as the offset to mmap.
 	 * See rvt_mmap() for details.
 	 */
 	if (udata && udata->outlen >= sizeof(__u64)) {
-		int err;
-
 		cq->ip = rvt_create_mmap_info(rdi, sz, udata, wc);
 		if (!cq->ip) {
-			ret = ERR_PTR(-ENOMEM);
+			err = -ENOMEM;
 			goto bail_wc;
 		}
 
 		err = ib_copy_to_udata(udata, &cq->ip->offset,
 				       sizeof(cq->ip->offset));
-		if (err) {
-			ret = ERR_PTR(err);
+		if (err)
 			goto bail_ip;
-		}
 	}
 
 	spin_lock_irq(&rdi->n_cqs_lock);
 	if (rdi->n_cqs_allocated == rdi->dparms.props.max_cq) {
 		spin_unlock_irq(&rdi->n_cqs_lock);
-		ret = ERR_PTR(-ENOMEM);
+		err = -ENOMEM;
 		goto bail_ip;
 	}
 
@@ -279,19 +266,14 @@ struct ib_cq *rvt_create_cq(struct ib_device *ibdev,
 	INIT_WORK(&cq->comptask, send_complete);
 	cq->queue = wc;
 
-	ret = &cq->ibcq;
-
 	trace_rvt_create_cq(cq, attr);
-	goto done;
+	return 0;
 
 bail_ip:
 	kfree(cq->ip);
 bail_wc:
 	vfree(wc);
-bail_cq:
-	kfree(cq);
-done:
-	return ret;
+	return err;
 }
 
 /**
@@ -314,7 +296,6 @@ void rvt_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 		kref_put(&cq->ip->ref, rvt_release_mmap_info);
 	else
 		vfree(cq->queue);
-	kfree(cq);
 }
 
 /**
diff --git a/drivers/infiniband/sw/rdmavt/cq.h b/drivers/infiniband/sw/rdmavt/cq.h
index 495d8c3e6580..5e26a2eb19a4 100644
--- a/drivers/infiniband/sw/rdmavt/cq.h
+++ b/drivers/infiniband/sw/rdmavt/cq.h
@@ -51,9 +51,8 @@
 #include <rdma/rdma_vt.h>
 #include <rdma/rdmavt_cq.h>
 
-struct ib_cq *rvt_create_cq(struct ib_device *ibdev,
-			    const struct ib_cq_init_attr *attr,
-			    struct ib_udata *udata);
+int rvt_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
+		  struct ib_udata *udata);
 void rvt_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata);
 int rvt_req_notify_cq(struct ib_cq *ibcq, enum ib_cq_notify_flags notify_flags);
 int rvt_resize_cq(struct ib_cq *ibcq, int cqe, struct ib_udata *udata);
diff --git a/drivers/infiniband/sw/rdmavt/vt.c b/drivers/infiniband/sw/rdmavt/vt.c
index 9546a837a8ac..ad571ede4003 100644
--- a/drivers/infiniband/sw/rdmavt/vt.c
+++ b/drivers/infiniband/sw/rdmavt/vt.c
@@ -427,6 +427,7 @@ static const struct ib_device_ops rvt_dev_ops = {
 	.unmap_fmr = rvt_unmap_fmr,
 
 	INIT_RDMA_OBJ_SIZE(ib_ah, rvt_ah, ibah),
+	INIT_RDMA_OBJ_SIZE(ib_cq, rvt_cq, ibcq),
 	INIT_RDMA_OBJ_SIZE(ib_pd, rvt_pd, ibpd),
 	INIT_RDMA_OBJ_SIZE(ib_srq, rvt_srq, ibsrq),
 	INIT_RDMA_OBJ_SIZE(ib_ucontext, rvt_ucontext, ibucontext),
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 56cf18af016a..fbcbac52290b 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -72,6 +72,7 @@ struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
 	[RXE_TYPE_CQ] = {
 		.name		= "rxe-cq",
 		.size		= sizeof(struct rxe_cq),
+		.flags          = RXE_POOL_NO_ALLOC,
 		.cleanup	= rxe_cq_cleanup,
 	},
 	[RXE_TYPE_MR] = {
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 5f30800b33f8..f3a7263a8c98 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -778,45 +778,34 @@ static int rxe_post_recv(struct ib_qp *ibqp, const struct ib_recv_wr *wr,
 	return err;
 }
 
-static struct ib_cq *rxe_create_cq(struct ib_device *dev,
-				   const struct ib_cq_init_attr *attr,
-				   struct ib_udata *udata)
+static int rxe_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
+			 struct ib_udata *udata)
 {
 	int err;
+	struct ib_device *dev = ibcq->device;
 	struct rxe_dev *rxe = to_rdev(dev);
-	struct rxe_cq *cq;
+	struct rxe_cq *cq = to_rcq(ibcq);
 	struct rxe_create_cq_resp __user *uresp = NULL;
 
 	if (udata) {
 		if (udata->outlen < sizeof(*uresp))
-			return ERR_PTR(-EINVAL);
+			return -EINVAL;
 		uresp = udata->outbuf;
 	}
 
 	if (attr->flags)
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 
 	err = rxe_cq_chk_attr(rxe, NULL, attr->cqe, attr->comp_vector);
 	if (err)
-		goto err1;
-
-	cq = rxe_alloc(&rxe->cq_pool);
-	if (!cq) {
-		err = -ENOMEM;
-		goto err1;
-	}
+		return err;
 
 	err = rxe_cq_from_init(rxe, cq, attr->cqe, attr->comp_vector, udata,
 			       uresp);
 	if (err)
-		goto err2;
-
-	return &cq->ibcq;
+		return err;
 
-err2:
-	rxe_drop_ref(cq);
-err1:
-	return ERR_PTR(err);
+	return rxe_add_to_pool(&rxe->cq_pool, &cq->pelem);
 }
 
 static void rxe_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
@@ -1156,6 +1145,7 @@ static const struct ib_device_ops rxe_dev_ops = {
 	.resize_cq = rxe_resize_cq,
 
 	INIT_RDMA_OBJ_SIZE(ib_ah, rxe_ah, ibah),
+	INIT_RDMA_OBJ_SIZE(ib_cq, rxe_cq, ibcq),
 	INIT_RDMA_OBJ_SIZE(ib_pd, rxe_pd, ibpd),
 	INIT_RDMA_OBJ_SIZE(ib_srq, rxe_srq, ibsrq),
 	INIT_RDMA_OBJ_SIZE(ib_ucontext, rxe_ucontext, ibuc),
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index e8be7f44e3be..6c997d39a418 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -85,8 +85,8 @@ struct rxe_cqe {
 };
 
 struct rxe_cq {
-	struct rxe_pool_entry	pelem;
 	struct ib_cq		ibcq;
+	struct rxe_pool_entry	pelem;
 	struct rxe_queue	*queue;
 	spinlock_t		cq_lock;
 	u8			notify;
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index afdb658be3be..5ef2fead4ad9 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2459,9 +2459,8 @@ struct ib_device_ops {
 	int (*query_qp)(struct ib_qp *qp, struct ib_qp_attr *qp_attr,
 			int qp_attr_mask, struct ib_qp_init_attr *qp_init_attr);
 	int (*destroy_qp)(struct ib_qp *qp, struct ib_udata *udata);
-	struct ib_cq *(*create_cq)(struct ib_device *device,
-				   const struct ib_cq_init_attr *attr,
-				   struct ib_udata *udata);
+	int (*create_cq)(struct ib_cq *cq, const struct ib_cq_init_attr *attr,
+			 struct ib_udata *udata);
 	int (*modify_cq)(struct ib_cq *cq, u16 cq_count, u16 cq_period);
 	void (*destroy_cq)(struct ib_cq *cq, struct ib_udata *udata);
 	int (*resize_cq)(struct ib_cq *cq, int cqe, struct ib_udata *udata);
@@ -2626,6 +2625,7 @@ struct ib_device_ops {
 	int (*counter_update_stats)(struct rdma_counter *counter);
 
 	DECLARE_RDMA_OBJ_SIZE(ib_ah);
+	DECLARE_RDMA_OBJ_SIZE(ib_cq);
 	DECLARE_RDMA_OBJ_SIZE(ib_pd);
 	DECLARE_RDMA_OBJ_SIZE(ib_srq);
 	DECLARE_RDMA_OBJ_SIZE(ib_ucontext);
-- 
2.20.1

