Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDD59276B2
	for <lists+linux-rdma@lfdr.de>; Thu, 23 May 2019 09:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbfEWHGg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 May 2019 03:06:36 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:45119 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbfEWHGg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 23 May 2019 03:06:36 -0400
Received: from localhost (r10.asicdesigners.com [10.192.194.10])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id x4N75mMR003867;
        Thu, 23 May 2019 00:05:48 -0700
From:   Nirranjan Kirubaharan <nirranjan@chelsio.com>
To:     nirranjan@chelsio.com, bharat@chelsio.com, dledford@redhat.com,
        jgg@mellanox.com
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH for-next v5] iw_cxgb4: Fix qpid leak
Date:   Thu, 23 May 2019 00:05:39 -0700
Message-Id: <815c6128bcd5a60949f2418db9c6c0d3925b06aa.1558592047.git.nirranjan@chelsio.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In iw_cxgb4, Added wait in destroy_qp() so that all references to
qp are dereferenced and qp is freed in destroy_qp() itself.
This ensures freeing of all QPs before invocation of
dealloc_ucontext(), which prevents loss of in use qpids stored
in ucontext.

Signed-off-by: Nirranjan Kirubaharan <nirranjan@chelsio.com>
Reviewed-by: Potnuri Bharat Teja <bharat@chelsio.com>
---
v2:
- Used kref instead of qid count.
---
v3:
- Ensured freeing of qp in destroy_qp() itself.
---
v4:
- Change c4iw_qp_rem_ref() to use a refcount not kref and trigger
complete() when the refcount goes to 0.
- Move all of queue_qp_free into c4iw_destroy_qp()
---
v5:
- Used refcount_t instead of atomic_t
---
 drivers/infiniband/hw/cxgb4/iw_cxgb4.h |  4 +--
 drivers/infiniband/hw/cxgb4/qp.c       | 48 ++++++++++++----------------------
 2 files changed, 19 insertions(+), 33 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
index 916ef982172e..cf7512b2c4c0 100644
--- a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
+++ b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
@@ -490,13 +490,13 @@ struct c4iw_qp {
 	struct t4_wq wq;
 	spinlock_t lock;
 	struct mutex mutex;
-	struct kref kref;
 	wait_queue_head_t wait;
 	int sq_sig_all;
 	struct c4iw_srq *srq;
-	struct work_struct free_work;
 	struct c4iw_ucontext *ucontext;
 	struct c4iw_wr_wait *wr_waitp;
+	struct completion qp_rel_comp;
+	refcount_t qp_refcnt;
 };
 
 static inline struct c4iw_qp *to_c4iw_qp(struct ib_qp *ibqp)
diff --git a/drivers/infiniband/hw/cxgb4/qp.c b/drivers/infiniband/hw/cxgb4/qp.c
index e92b9544357a..7453a06b4dae 100644
--- a/drivers/infiniband/hw/cxgb4/qp.c
+++ b/drivers/infiniband/hw/cxgb4/qp.c
@@ -890,43 +890,17 @@ static int build_inv_stag(union t4_wr *wqe, const struct ib_send_wr *wr,
 	return 0;
 }
 
-static void free_qp_work(struct work_struct *work)
-{
-	struct c4iw_ucontext *ucontext;
-	struct c4iw_qp *qhp;
-	struct c4iw_dev *rhp;
-
-	qhp = container_of(work, struct c4iw_qp, free_work);
-	ucontext = qhp->ucontext;
-	rhp = qhp->rhp;
-
-	pr_debug("qhp %p ucontext %p\n", qhp, ucontext);
-	destroy_qp(&rhp->rdev, &qhp->wq,
-		   ucontext ? &ucontext->uctx : &rhp->rdev.uctx, !qhp->srq);
-
-	c4iw_put_wr_wait(qhp->wr_waitp);
-	kfree(qhp);
-}
-
-static void queue_qp_free(struct kref *kref)
-{
-	struct c4iw_qp *qhp;
-
-	qhp = container_of(kref, struct c4iw_qp, kref);
-	pr_debug("qhp %p\n", qhp);
-	queue_work(qhp->rhp->rdev.free_workq, &qhp->free_work);
-}
-
 void c4iw_qp_add_ref(struct ib_qp *qp)
 {
 	pr_debug("ib_qp %p\n", qp);
-	kref_get(&to_c4iw_qp(qp)->kref);
+	refcount_inc(&to_c4iw_qp(qp)->qp_refcnt);
 }
 
 void c4iw_qp_rem_ref(struct ib_qp *qp)
 {
 	pr_debug("ib_qp %p\n", qp);
-	kref_put(&to_c4iw_qp(qp)->kref, queue_qp_free);
+	if (refcount_dec_and_test(&to_c4iw_qp(qp)->qp_refcnt))
+		complete(&to_c4iw_qp(qp)->qp_rel_comp);
 }
 
 static void add_to_fc_list(struct list_head *head, struct list_head *entry)
@@ -2099,10 +2073,12 @@ int c4iw_destroy_qp(struct ib_qp *ib_qp, struct ib_udata *udata)
 {
 	struct c4iw_dev *rhp;
 	struct c4iw_qp *qhp;
+	struct c4iw_ucontext *ucontext;
 	struct c4iw_qp_attributes attrs;
 
 	qhp = to_c4iw_qp(ib_qp);
 	rhp = qhp->rhp;
+	ucontext = qhp->ucontext;
 
 	attrs.next_state = C4IW_QP_STATE_ERROR;
 	if (qhp->attr.state == C4IW_QP_STATE_TERMINATE)
@@ -2120,7 +2096,17 @@ int c4iw_destroy_qp(struct ib_qp *ib_qp, struct ib_udata *udata)
 
 	c4iw_qp_rem_ref(ib_qp);
 
+	wait_for_completion(&qhp->qp_rel_comp);
+
 	pr_debug("ib_qp %p qpid 0x%0x\n", ib_qp, qhp->wq.sq.qid);
+	pr_debug("qhp %p ucontext %p\n", qhp, ucontext);
+
+	destroy_qp(&rhp->rdev, &qhp->wq,
+		   ucontext ? &ucontext->uctx : &rhp->rdev.uctx, !qhp->srq);
+
+	c4iw_put_wr_wait(qhp->wr_waitp);
+
+	kfree(qhp);
 	return 0;
 }
 
@@ -2230,8 +2216,8 @@ struct ib_qp *c4iw_create_qp(struct ib_pd *pd, struct ib_qp_init_attr *attrs,
 	spin_lock_init(&qhp->lock);
 	mutex_init(&qhp->mutex);
 	init_waitqueue_head(&qhp->wait);
-	kref_init(&qhp->kref);
-	INIT_WORK(&qhp->free_work, free_qp_work);
+	init_completion(&qhp->qp_rel_comp);
+	refcount_set(&qhp->qp_refcnt, 1);
 
 	ret = xa_insert_irq(&rhp->qps, qhp->wq.sq.qid, qhp, GFP_KERNEL);
 	if (ret)
-- 
1.8.3.1

