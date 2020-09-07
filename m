Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 327B926038C
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Sep 2020 19:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbgIGRuj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Sep 2020 13:50:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:34788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729229AbgIGMJl (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 7 Sep 2020 08:09:41 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D66AB216C4;
        Mon,  7 Sep 2020 12:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599480580;
        bh=OcW0N19CF+WnCrKFGANqcNSvgA8efsoBVlnymA8cc+k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wKfFSZDIQUNSP8Hih7myTF9PyU3Y+Mafy4MvECl8xdrd+/G9COnrXXg8Eiok5Jt51
         teSW8KgnW3Y4aO0bzOwWutalkEOU9/hLwl5sJeJxhvI/L9T0nb2vSclFVf8/3jiyrL
         tVyLXed6roZ0/xoPUg03ZaUjTUkqg84FKFcb0RNs=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v2 5/9] RDMA/core: Delete function indirection for alloc/free kernel CQ
Date:   Mon,  7 Sep 2020 15:09:17 +0300
Message-Id: <20200907120921.476363-6-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200907120921.476363-1-leon@kernel.org>
References: <20200907120921.476363-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

The ib_alloc_cq*() and ib_free_cq*() are solely kernel verbs to manage
CQs and doesn't need extra indirection just to call same functions with
constant parameter NULL as udata.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cq.c | 27 +++++++---------
 include/rdma/ib_verbs.h      | 62 ++++--------------------------------
 2 files changed, 18 insertions(+), 71 deletions(-)

diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
index 513825e424bf..ab556407803c 100644
--- a/drivers/infiniband/core/cq.c
+++ b/drivers/infiniband/core/cq.c
@@ -197,24 +197,22 @@ static void ib_cq_completion_workqueue(struct ib_cq *cq, void *private)
 }
 
 /**
- * __ib_alloc_cq_user - allocate a completion queue
+ * __ib_alloc_cq        allocate a completion queue
  * @dev:		device to allocate the CQ for
  * @private:		driver private data, accessible from cq->cq_context
  * @nr_cqe:		number of CQEs to allocate
  * @comp_vector:	HCA completion vectors for this CQ
  * @poll_ctx:		context to poll the CQ from.
  * @caller:		module owner name.
- * @udata:		Valid user data or NULL for kernel object
  *
  * This is the proper interface to allocate a CQ for in-kernel users. A
  * CQ allocated with this interface will automatically be polled from the
  * specified context. The ULP must use wr->wr_cqe instead of wr->wr_id
  * to use this CQ abstraction.
  */
-struct ib_cq *__ib_alloc_cq_user(struct ib_device *dev, void *private,
-				 int nr_cqe, int comp_vector,
-				 enum ib_poll_context poll_ctx,
-				 const char *caller, struct ib_udata *udata)
+struct ib_cq *__ib_alloc_cq(struct ib_device *dev, void *private, int nr_cqe,
+			    int comp_vector, enum ib_poll_context poll_ctx,
+			    const char *caller)
 {
 	struct ib_cq_init_attr cq_attr = {
 		.cqe		= nr_cqe,
@@ -277,7 +275,7 @@ struct ib_cq *__ib_alloc_cq_user(struct ib_device *dev, void *private,
 out_destroy_cq:
 	rdma_dim_destroy(cq);
 	rdma_restrack_del(&cq->res);
-	cq->device->ops.destroy_cq(cq, udata);
+	cq->device->ops.destroy_cq(cq, NULL);
 out_free_wc:
 	kfree(cq->wc);
 out_free_cq:
@@ -285,7 +283,7 @@ struct ib_cq *__ib_alloc_cq_user(struct ib_device *dev, void *private,
 	trace_cq_alloc_error(nr_cqe, comp_vector, poll_ctx, ret);
 	return ERR_PTR(ret);
 }
-EXPORT_SYMBOL(__ib_alloc_cq_user);
+EXPORT_SYMBOL(__ib_alloc_cq);
 
 /**
  * __ib_alloc_cq_any - allocate a completion queue
@@ -310,17 +308,16 @@ struct ib_cq *__ib_alloc_cq_any(struct ib_device *dev, void *private,
 			atomic_inc_return(&counter) %
 			min_t(int, dev->num_comp_vectors, num_online_cpus());
 
-	return __ib_alloc_cq_user(dev, private, nr_cqe, comp_vector, poll_ctx,
-				  caller, NULL);
+	return __ib_alloc_cq(dev, private, nr_cqe, comp_vector, poll_ctx,
+			     caller);
 }
 EXPORT_SYMBOL(__ib_alloc_cq_any);
 
 /**
- * ib_free_cq_user - free a completion queue
+ * ib_free_cq - free a completion queue
  * @cq:		completion queue to free.
- * @udata:	User data or NULL for kernel object
  */
-void ib_free_cq_user(struct ib_cq *cq, struct ib_udata *udata)
+void ib_free_cq(struct ib_cq *cq)
 {
 	if (WARN_ON_ONCE(atomic_read(&cq->usecnt)))
 		return;
@@ -344,11 +341,11 @@ void ib_free_cq_user(struct ib_cq *cq, struct ib_udata *udata)
 	rdma_dim_destroy(cq);
 	trace_cq_free(cq);
 	rdma_restrack_del(&cq->res);
-	cq->device->ops.destroy_cq(cq, udata);
+	cq->device->ops.destroy_cq(cq, NULL);
 	kfree(cq->wc);
 	kfree(cq);
 }
-EXPORT_SYMBOL(ib_free_cq_user);
+EXPORT_SYMBOL(ib_free_cq);
 
 void ib_cq_pool_init(struct ib_device *dev)
 {
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 6861ae43f7b1..e2e80e9785db 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -3808,46 +3808,15 @@ static inline int ib_post_recv(struct ib_qp *qp,
 	return qp->device->ops.post_recv(qp, recv_wr, bad_recv_wr ? : &dummy);
 }
 
-struct ib_cq *__ib_alloc_cq_user(struct ib_device *dev, void *private,
-				 int nr_cqe, int comp_vector,
-				 enum ib_poll_context poll_ctx,
-				 const char *caller, struct ib_udata *udata);
-
-/**
- * ib_alloc_cq_user: Allocate kernel/user CQ
- * @dev: The IB device
- * @private: Private data attached to the CQE
- * @nr_cqe: Number of CQEs in the CQ
- * @comp_vector: Completion vector used for the IRQs
- * @poll_ctx: Context used for polling the CQ
- * @udata: Valid user data or NULL for kernel objects
- */
-static inline struct ib_cq *ib_alloc_cq_user(struct ib_device *dev,
-					     void *private, int nr_cqe,
-					     int comp_vector,
-					     enum ib_poll_context poll_ctx,
-					     struct ib_udata *udata)
-{
-	return __ib_alloc_cq_user(dev, private, nr_cqe, comp_vector, poll_ctx,
-				  KBUILD_MODNAME, udata);
-}
-
-/**
- * ib_alloc_cq: Allocate kernel CQ
- * @dev: The IB device
- * @private: Private data attached to the CQE
- * @nr_cqe: Number of CQEs in the CQ
- * @comp_vector: Completion vector used for the IRQs
- * @poll_ctx: Context used for polling the CQ
- *
- * NOTE: for user cq use ib_alloc_cq_user with valid udata!
- */
+struct ib_cq *__ib_alloc_cq(struct ib_device *dev, void *private, int nr_cqe,
+			    int comp_vector, enum ib_poll_context poll_ctx,
+			    const char *caller);
 static inline struct ib_cq *ib_alloc_cq(struct ib_device *dev, void *private,
 					int nr_cqe, int comp_vector,
 					enum ib_poll_context poll_ctx)
 {
-	return ib_alloc_cq_user(dev, private, nr_cqe, comp_vector, poll_ctx,
-				NULL);
+	return __ib_alloc_cq(dev, private, nr_cqe, comp_vector, poll_ctx,
+			     KBUILD_MODNAME);
 }
 
 struct ib_cq *__ib_alloc_cq_any(struct ib_device *dev, void *private,
@@ -3869,26 +3838,7 @@ static inline struct ib_cq *ib_alloc_cq_any(struct ib_device *dev,
 				 KBUILD_MODNAME);
 }
 
-/**
- * ib_free_cq_user - Free kernel/user CQ
- * @cq: The CQ to free
- * @udata: Valid user data or NULL for kernel objects
- *
- * NOTE: This function shouldn't be called on shared CQs.
- */
-void ib_free_cq_user(struct ib_cq *cq, struct ib_udata *udata);
-
-/**
- * ib_free_cq - Free kernel CQ
- * @cq: The CQ to free
- *
- * NOTE: for user cq use ib_free_cq_user with valid udata!
- */
-static inline void ib_free_cq(struct ib_cq *cq)
-{
-	ib_free_cq_user(cq, NULL);
-}
-
+void ib_free_cq(struct ib_cq *cq);
 int ib_process_cq_direct(struct ib_cq *cq, int budget);
 
 /**
-- 
2.26.2

