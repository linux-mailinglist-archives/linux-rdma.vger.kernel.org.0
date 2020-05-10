Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAC861CCBB2
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2020 16:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbgEJO4N (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 10 May 2020 10:56:13 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:45490 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728714AbgEJO4N (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 10 May 2020 10:56:13 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from yaminf@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 10 May 2020 17:56:07 +0300
Received: from arch012.mtl.labs.mlnx. (arch012.mtl.labs.mlnx [10.7.13.12])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 04AEu6eG007532;
        Sun, 10 May 2020 17:56:06 +0300
From:   Yamin Friedman <yaminf@mellanox.com>
To:     Jason Gunthorpe <jgg@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-rdma@vger.kernel.org, Yamin Friedman <yaminf@mellanox.com>
Subject: [PATCH 1/4] infiniband/core: Add protection for shared CQs used by ULPs
Date:   Sun, 10 May 2020 17:55:54 +0300
Message-Id: <1589122557-88996-2-git-send-email-yaminf@mellanox.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1589122557-88996-1-git-send-email-yaminf@mellanox.com>
References: <1589122557-88996-1-git-send-email-yaminf@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

A pre-step for adding shared CQs. Add the infra-structure to prevent
shared CQ users from altering the CQ configurations. For now all cqs are
marked as private (non-shared). The core driver should use the new force
functions to perform resize/destroy/moderation changes that are not
allowed for users of shared CQs.

Signed-off-by: Yamin Friedman <yaminf@mellanox.com>
Reviewed-by: Or Gerlitz <ogerlitz@mellanox.com>
---
 drivers/infiniband/core/cq.c    | 25 ++++++++++++++++++-------
 drivers/infiniband/core/verbs.c | 37 ++++++++++++++++++++++++++++++++++---
 include/rdma/ib_verbs.h         | 20 +++++++++++++++++++-
 3 files changed, 71 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
index 4f25b24..443a9cd 100644
--- a/drivers/infiniband/core/cq.c
+++ b/drivers/infiniband/core/cq.c
@@ -37,6 +37,7 @@ static void ib_cq_rdma_dim_work(struct work_struct *w)
 {
 	struct dim *dim = container_of(w, struct dim, work);
 	struct ib_cq *cq = dim->priv;
+	int ret;
 
 	u16 usec = rdma_dim_prof[dim->profile_ix].usec;
 	u16 comps = rdma_dim_prof[dim->profile_ix].comps;
@@ -44,7 +45,10 @@ static void ib_cq_rdma_dim_work(struct work_struct *w)
 	dim->state = DIM_START_MEASURE;
 
 	trace_cq_modify(cq, comps, usec);
-	cq->device->ops.modify_cq(cq, comps, usec);
+	ret = rdma_set_cq_moderation_force(cq, comps, usec);
+	if (ret)
+		WARN_ONCE(1, "Failed set moderation for CQ 0x%p\n", cq);
+
 }
 
 static void rdma_dim_init(struct ib_cq *cq)
@@ -218,6 +222,7 @@ struct ib_cq *__ib_alloc_cq_user(struct ib_device *dev, void *private,
 	cq->cq_context = private;
 	cq->poll_ctx = poll_ctx;
 	atomic_set(&cq->usecnt, 0);
+	cq->cq_type = IB_CQ_PRIVATE;
 
 	cq->wc = kmalloc_array(IB_POLL_BATCH, sizeof(*cq->wc), GFP_KERNEL);
 	if (!cq->wc)
@@ -300,12 +305,7 @@ struct ib_cq *__ib_alloc_cq_any(struct ib_device *dev, void *private,
 }
 EXPORT_SYMBOL(__ib_alloc_cq_any);
 
-/**
- * ib_free_cq_user - free a completion queue
- * @cq:		completion queue to free.
- * @udata:	User data or NULL for kernel object
- */
-void ib_free_cq_user(struct ib_cq *cq, struct ib_udata *udata)
+static void _ib_free_cq_user(struct ib_cq *cq, struct ib_udata *udata)
 {
 	if (WARN_ON_ONCE(atomic_read(&cq->usecnt)))
 		return;
@@ -333,4 +333,15 @@ void ib_free_cq_user(struct ib_cq *cq, struct ib_udata *udata)
 	kfree(cq->wc);
 	kfree(cq);
 }
+
+/**
+ * ib_free_cq_user - free a completion queue
+ * @cq:		completion queue to free.
+ * @udata:	User data or NULL for kernel object
+ */
+void ib_free_cq_user(struct ib_cq *cq, struct ib_udata *udata)
+{
+	if (!WARN_ON_ONCE(cq->cq_type != IB_CQ_PRIVATE))
+		_ib_free_cq_user(cq, udata);
+}
 EXPORT_SYMBOL(ib_free_cq_user);
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index bf0249f..39c012f 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -1988,15 +1988,29 @@ struct ib_cq *__ib_create_cq(struct ib_device *device,
 }
 EXPORT_SYMBOL(__ib_create_cq);
 
-int rdma_set_cq_moderation(struct ib_cq *cq, u16 cq_count, u16 cq_period)
+static int _rdma_set_cq_moderation(struct ib_cq *cq, u16 cq_count,
+				   u16 cq_period)
 {
 	return cq->device->ops.modify_cq ?
 		cq->device->ops.modify_cq(cq, cq_count,
 					  cq_period) : -EOPNOTSUPP;
 }
+
+int rdma_set_cq_moderation(struct ib_cq *cq, u16 cq_count, u16 cq_period)
+{
+	if (WARN_ON_ONCE(cq->cq_type != IB_CQ_PRIVATE))
+		return -EOPNOTSUPP;
+	else
+		return _rdma_set_cq_moderation(cq, cq_count, cq_period);
+}
 EXPORT_SYMBOL(rdma_set_cq_moderation);
 
-int ib_destroy_cq_user(struct ib_cq *cq, struct ib_udata *udata)
+int rdma_set_cq_moderation_force(struct ib_cq *cq, u16 cq_count, u16 cq_period)
+{
+	return _rdma_set_cq_moderation(cq, cq_count, cq_period);
+}
+
+static int _ib_destroy_cq_user(struct ib_cq *cq, struct ib_udata *udata)
 {
 	if (atomic_read(&cq->usecnt))
 		return -EBUSY;
@@ -2004,15 +2018,32 @@ int ib_destroy_cq_user(struct ib_cq *cq, struct ib_udata *udata)
 	rdma_restrack_del(&cq->res);
 	cq->device->ops.destroy_cq(cq, udata);
 	kfree(cq);
+
 	return 0;
 }
+
+int ib_destroy_cq_user(struct ib_cq *cq, struct ib_udata *udata)
+{
+	if (WARN_ON_ONCE(cq->cq_type != IB_CQ_PRIVATE))
+		return -EOPNOTSUPP;
+	else
+		return _ib_destroy_cq_user(cq, udata);
+}
 EXPORT_SYMBOL(ib_destroy_cq_user);
 
-int ib_resize_cq(struct ib_cq *cq, int cqe)
+static int _ib_resize_cq(struct ib_cq *cq, int cqe)
 {
 	return cq->device->ops.resize_cq ?
 		cq->device->ops.resize_cq(cq, cqe, NULL) : -EOPNOTSUPP;
 }
+
+int ib_resize_cq(struct ib_cq *cq, int cqe)
+{
+	if (WARN_ON_ONCE(cq->cq_type != IB_CQ_PRIVATE))
+		return -EOPNOTSUPP;
+	else
+		return _ib_resize_cq(cq, cqe);
+}
 EXPORT_SYMBOL(ib_resize_cq);
 
 /* Memory regions */
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 4c488ca..c889415 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1557,6 +1557,10 @@ enum ib_poll_context {
 	IB_POLL_UNBOUND_WORKQUEUE, /* poll from unbound workqueue */
 };
 
+enum ib_cq_type {
+	IB_CQ_PRIVATE,	/* CQ will be used by only one user */
+};
+
 struct ib_cq {
 	struct ib_device       *device;
 	struct ib_ucq_object   *uobject;
@@ -1582,6 +1586,7 @@ struct ib_cq {
 	 * Implementation details of the RDMA core, don't use in drivers:
 	 */
 	struct rdma_restrack_entry res;
+	enum ib_cq_type cq_type;
 };
 
 struct ib_srq {
@@ -3832,6 +3837,7 @@ static inline struct ib_cq *ib_alloc_cq_any(struct ib_device *dev,
  * @cq: The CQ to free
  *
  * NOTE: for user cq use ib_free_cq_user with valid udata!
+ * NOTE: this will fail for shared cqs
  */
 static inline void ib_free_cq(struct ib_cq *cq)
 {
@@ -3881,7 +3887,19 @@ struct ib_cq *__ib_create_cq(struct ib_device *device,
 int rdma_set_cq_moderation(struct ib_cq *cq, u16 cq_count, u16 cq_period);
 
 /**
- * ib_destroy_cq_user - Destroys the specified CQ.
+ * rdma_set_cq_moderation_force - Modifies moderation params of the CQ.
+ * Meant for use in core driver to work for shared CQs.
+ * @cq: The CQ to modify.
+ * @cq_count: number of CQEs that will trigger an event
+ * @cq_period: max period of time in usec before triggering an event
+ *
+ */
+int rdma_set_cq_moderation_force(struct ib_cq *cq, u16 cq_count,
+				 u16 cq_period);
+
+/**
+ * ib_destroy_cq_user - Destroys the specified CQ. If the CQ is not
+ * PRIVATE this function will fail.
  * @cq: The CQ to destroy.
  * @udata: Valid user data or NULL for kernel objects
  */
-- 
1.8.3.1

