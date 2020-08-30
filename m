Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4D70256D48
	for <lists+linux-rdma@lfdr.de>; Sun, 30 Aug 2020 12:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbgH3KPE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 30 Aug 2020 06:15:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:49564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728773AbgH3KPE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 30 Aug 2020 06:15:04 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DFA8207DA;
        Sun, 30 Aug 2020 10:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598782503;
        bh=yxkmpZX0+B4GpISjz3WkPoN2cP1MjlfivJ+LZE+Pq7s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=09uUTL+rW1DYmFmfwrU9CP/KTd5NEYZfSqQaEq3wco0qB69Kcen967X1qGb/RzLot
         OnS6Z+UrwVVYI/l/NnCP6UWBxy0o2nq1tIkOTomASlNP3WHnlqETwbyEYlSb1HSOeA
         E9kwpY9Oayzv2885AYZzEs12V/gpmMpKnGpMBmC0=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v1 04/13] RDMA/restrack: Simplify restrack tracking in kernel flows
Date:   Sun, 30 Aug 2020 13:14:27 +0300
Message-Id: <20200830101436.108487-5-leon@kernel.org>
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

There is no need to do an extra function indirection just to add
restrack entry to the DB. This patch prepares the code to the future
requirement of making restrack is mandatory for managing ib objects.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cma.c       |  2 +-
 drivers/infiniband/core/core_priv.h |  6 ++--
 drivers/infiniband/core/counters.c  |  2 +-
 drivers/infiniband/core/cq.c        |  2 +-
 drivers/infiniband/core/restrack.c  | 46 ++++-------------------------
 drivers/infiniband/core/restrack.h  |  1 +
 drivers/infiniband/core/verbs.c     | 13 ++++----
 include/rdma/restrack.h             |  1 -
 8 files changed, 22 insertions(+), 51 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 8a027dfff0ff..f0ac62331b27 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -468,7 +468,7 @@ static void _cma_attach_to_dev(struct rdma_id_private *id_priv,
 		rdma_node_get_transport(cma_dev->device->node_type);
 	list_add_tail(&id_priv->list, &cma_dev->id_list);
 	if (id_priv->res.kern_name)
-		rdma_restrack_kadd(&id_priv->res);
+		rdma_restrack_add(&id_priv->res);
 	else
 		rdma_restrack_uadd(&id_priv->res);
 	trace_cm_id_attach(id_priv, cma_dev->device);
diff --git a/drivers/infiniband/core/core_priv.h b/drivers/infiniband/core/core_priv.h
index 2ad276cd9781..cf5a50cefa39 100644
--- a/drivers/infiniband/core/core_priv.h
+++ b/drivers/infiniband/core/core_priv.h
@@ -363,8 +363,10 @@ static inline struct ib_qp *_ib_create_qp(struct ib_device *dev,
 	if ((qp_type < IB_QPT_MAX && !is_xrc) || qp_type == IB_QPT_DRIVER) {
 		if (uobj)
 			rdma_restrack_uadd(&qp->res);
-		else
-			rdma_restrack_kadd(&qp->res);
+		else {
+			rdma_restrack_set_task(&qp->res, pd->res.kern_name);
+			rdma_restrack_add(&qp->res);
+		}
 	} else
 		qp->res.valid = false;
 
diff --git a/drivers/infiniband/core/counters.c b/drivers/infiniband/core/counters.c
index c059de99d19c..e13c500a9ec0 100644
--- a/drivers/infiniband/core/counters.c
+++ b/drivers/infiniband/core/counters.c
@@ -252,7 +252,7 @@ static void rdma_counter_res_add(struct rdma_counter *counter,
 {
 	if (rdma_is_kernel_res(&qp->res)) {
 		rdma_restrack_set_task(&counter->res, qp->res.kern_name);
-		rdma_restrack_kadd(&counter->res);
+		rdma_restrack_add(&counter->res);
 	} else {
 		rdma_restrack_attach_task(&counter->res, qp->res.task);
 		rdma_restrack_uadd(&counter->res);
diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
index 8ffc26520add..e0aa80769143 100644
--- a/drivers/infiniband/core/cq.c
+++ b/drivers/infiniband/core/cq.c
@@ -267,7 +267,7 @@ struct ib_cq *__ib_alloc_cq(struct ib_device *dev, void *private, int nr_cqe,
 		goto out_destroy_cq;
 	}
 
-	rdma_restrack_kadd(&cq->res);
+	rdma_restrack_add(&cq->res);
 	trace_cq_alloc(cq, nr_cqe, comp_vector, poll_ctx);
 	return cq;
 
diff --git a/drivers/infiniband/core/restrack.c b/drivers/infiniband/core/restrack.c
index ec9fe8cc1698..533729c798f7 100644
--- a/drivers/infiniband/core/restrack.c
+++ b/drivers/infiniband/core/restrack.c
@@ -123,32 +123,6 @@ int rdma_restrack_count(struct ib_device *dev, enum rdma_restrack_type type)
 }
 EXPORT_SYMBOL(rdma_restrack_count);
 
-static void set_kern_name(struct rdma_restrack_entry *res)
-{
-	struct ib_pd *pd;
-
-	switch (res->type) {
-	case RDMA_RESTRACK_QP:
-		pd = container_of(res, struct ib_qp, res)->pd;
-		if (!pd) {
-			WARN_ONCE(true, "XRC QPs are not supported\n");
-			/* Survive, despite the programmer's error */
-			res->kern_name = " ";
-		}
-		break;
-	case RDMA_RESTRACK_MR:
-		pd = container_of(res, struct ib_mr, res)->pd;
-		break;
-	default:
-		/* Other types set kern_name directly */
-		pd = NULL;
-		break;
-	}
-
-	if (pd)
-		res->kern_name = pd->res.kern_name;
-}
-
 static struct ib_device *res_to_dev(struct rdma_restrack_entry *res)
 {
 	switch (res->type) {
@@ -217,7 +191,11 @@ void rdma_restrack_new(struct rdma_restrack_entry *res,
 }
 EXPORT_SYMBOL(rdma_restrack_new);
 
-static void rdma_restrack_add(struct rdma_restrack_entry *res)
+/**
+ * rdma_restrack_add() - add object to the reource tracking database
+ * @res:  resource entry
+ */
+void rdma_restrack_add(struct rdma_restrack_entry *res)
 {
 	struct ib_device *dev = res_to_dev(res);
 	struct rdma_restrack_root *rt;
@@ -249,19 +227,7 @@ static void rdma_restrack_add(struct rdma_restrack_entry *res)
 	if (!ret)
 		res->valid = true;
 }
-
-/**
- * rdma_restrack_kadd() - add kernel object to the reource tracking database
- * @res:  resource entry
- */
-void rdma_restrack_kadd(struct rdma_restrack_entry *res)
-{
-	res->task = NULL;
-	set_kern_name(res);
-	res->user = false;
-	rdma_restrack_add(res);
-}
-EXPORT_SYMBOL(rdma_restrack_kadd);
+EXPORT_SYMBOL(rdma_restrack_add);
 
 /**
  * rdma_restrack_uadd() - add user object to the reource tracking database
diff --git a/drivers/infiniband/core/restrack.h b/drivers/infiniband/core/restrack.h
index 16006a5e7408..d35c4c41d2ff 100644
--- a/drivers/infiniband/core/restrack.h
+++ b/drivers/infiniband/core/restrack.h
@@ -25,6 +25,7 @@ struct rdma_restrack_root {
 
 int rdma_restrack_init(struct ib_device *dev);
 void rdma_restrack_clean(struct ib_device *dev);
+void rdma_restrack_add(struct rdma_restrack_entry *res);
 void rdma_restrack_del(struct rdma_restrack_entry *res);
 void rdma_restrack_new(struct rdma_restrack_entry *res,
 		       enum rdma_restrack_type type);
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index e7938e99b6f4..35645ad0a6d7 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -281,7 +281,7 @@ struct ib_pd *__ib_alloc_pd(struct ib_device *device, unsigned int flags,
 		kfree(pd);
 		return ERR_PTR(ret);
 	}
-	rdma_restrack_kadd(&pd->res);
+	rdma_restrack_add(&pd->res);
 
 	if (device->attrs.device_cap_flags & IB_DEVICE_LOCAL_DMA_LKEY)
 		pd->local_dma_lkey = device->local_dma_lkey;
@@ -2008,7 +2008,7 @@ struct ib_cq *__ib_create_cq(struct ib_device *device,
 		return ERR_PTR(ret);
 	}
 
-	rdma_restrack_kadd(&cq->res);
+	rdma_restrack_add(&cq->res);
 	return cq;
 }
 EXPORT_SYMBOL(__ib_create_cq);
@@ -2081,7 +2081,8 @@ struct ib_mr *ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 	atomic_inc(&pd->usecnt);
 
 	rdma_restrack_new(&mr->res, RDMA_RESTRACK_MR);
-	rdma_restrack_kadd(&mr->res);
+	rdma_restrack_set_task(&mr->res, pd->res.kern_name);
+	rdma_restrack_add(&mr->res);
 
 	return mr;
 }
@@ -2164,7 +2165,8 @@ struct ib_mr *ib_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
 	mr->sig_attrs = NULL;
 
 	rdma_restrack_new(&mr->res, RDMA_RESTRACK_MR);
-	rdma_restrack_kadd(&mr->res);
+	rdma_restrack_set_task(&mr->res, pd->res.kern_name);
+	rdma_restrack_add(&mr->res);
 out:
 	trace_mr_alloc(pd, mr_type, max_num_sg, mr);
 	return mr;
@@ -2224,7 +2226,8 @@ struct ib_mr *ib_alloc_mr_integrity(struct ib_pd *pd,
 	mr->sig_attrs = sig_attrs;
 
 	rdma_restrack_new(&mr->res, RDMA_RESTRACK_MR);
-	rdma_restrack_kadd(&mr->res);
+	rdma_restrack_set_task(&mr->res, pd->res.kern_name);
+	rdma_restrack_add(&mr->res);
 out:
 	trace_mr_integ_alloc(pd, max_num_data_sg, max_num_meta_sg, mr);
 	return mr;
diff --git a/include/rdma/restrack.h b/include/rdma/restrack.h
index d7c166237939..db59e208f5e8 100644
--- a/include/rdma/restrack.h
+++ b/include/rdma/restrack.h
@@ -107,7 +107,6 @@ struct rdma_restrack_entry {
 int rdma_restrack_count(struct ib_device *dev,
 			enum rdma_restrack_type type);
 
-void rdma_restrack_kadd(struct rdma_restrack_entry *res);
 void rdma_restrack_uadd(struct rdma_restrack_entry *res);
 
 /**
-- 
2.26.2

