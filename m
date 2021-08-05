Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE0873E14F4
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Aug 2021 14:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233088AbhHEMoD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Aug 2021 08:44:03 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:24858 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233016AbhHEMoD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 5 Aug 2021 08:44:03 -0400
Received: from potato2.blr.asicdesigners.com (potato2.blr.asicdesigners.com [10.193.80.129])
        by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 175Chf7s015571;
        Thu, 5 Aug 2021 05:43:42 -0700
From:   Dakshaja Uppalapati <dakshaja@chelsio.com>
To:     jgg@nvidia.com, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org, bharat@chelsio.com,
        dakshaja@chelsio.com
Subject: [PATCH v1 for-rc] iw_cxgb4: Fix refcount underflow while destroying cqs.
Date:   Thu,  5 Aug 2021 18:13:32 +0530
Message-Id: <1628167412-12114-1-git-send-email-dakshaja@chelsio.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Previous atomic increment decrement logic expects the atomic count
to be '0' after the final decrement. Replacing atomic count with
refcount does not allow that, as refcount_dec() considers count of 1
as underflow. Therefore fix the current refcount logic by decrementing
the refcount and test if it is '0' on the final deref in
c4iw_destroy_cq(). Use wait_for_completion() instead of wait_event().

Fixes: 7183451f846d (RDMA/cxgb4: Use refcount_t instead of atomic_t for reference counting")
Signed-off-by: Dakshaja Uppalapati <dakshaja@chelsio.com>
Reviewed-by: Potnuri Bharat Teja <bharat@chelsio.com>
---
changelog:
v0->v1: used wait for completion instead of wait_event.
---
 drivers/infiniband/hw/cxgb4/cq.c       | 12 +++++++++---
 drivers/infiniband/hw/cxgb4/ev.c       |  6 ++----
 drivers/infiniband/hw/cxgb4/iw_cxgb4.h |  3 ++-
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb4/cq.c b/drivers/infiniband/hw/cxgb4/cq.c
index 6c8c910..53f52fc 100644
--- a/drivers/infiniband/hw/cxgb4/cq.c
+++ b/drivers/infiniband/hw/cxgb4/cq.c
@@ -967,6 +967,12 @@ int c4iw_poll_cq(struct ib_cq *ibcq, int num_entries, struct ib_wc *wc)
 	return !err || err == -ENODATA ? npolled : err;
 }
 
+void c4iw_cq_rem_ref(struct c4iw_cq *chp)
+{
+	if (refcount_dec_and_test(&chp->refcnt))
+                complete(&chp->cq_rel_comp);
+}
+
 int c4iw_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 {
 	struct c4iw_cq *chp;
@@ -976,8 +982,8 @@ int c4iw_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 	chp = to_c4iw_cq(ib_cq);
 
 	xa_erase_irq(&chp->rhp->cqs, chp->cq.cqid);
-	refcount_dec(&chp->refcnt);
-	wait_event(chp->wait, !refcount_read(&chp->refcnt));
+	c4iw_cq_rem_ref(chp);
+	wait_for_completion(&chp->cq_rel_comp);
 
 	ucontext = rdma_udata_to_drv_context(udata, struct c4iw_ucontext,
 					     ibucontext);
@@ -1081,7 +1087,7 @@ int c4iw_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	spin_lock_init(&chp->lock);
 	spin_lock_init(&chp->comp_handler_lock);
 	refcount_set(&chp->refcnt, 1);
-	init_waitqueue_head(&chp->wait);
+	init_completion(&chp->cq_rel_comp);
 	ret = xa_insert_irq(&rhp->cqs, chp->cq.cqid, chp, GFP_KERNEL);
 	if (ret)
 		goto err_destroy_cq;
diff --git a/drivers/infiniband/hw/cxgb4/ev.c b/drivers/infiniband/hw/cxgb4/ev.c
index 7798d090..34211a5 100644
--- a/drivers/infiniband/hw/cxgb4/ev.c
+++ b/drivers/infiniband/hw/cxgb4/ev.c
@@ -213,8 +213,7 @@ void c4iw_ev_dispatch(struct c4iw_dev *dev, struct t4_cqe *err_cqe)
 		break;
 	}
 done:
-	if (refcount_dec_and_test(&chp->refcnt))
-		wake_up(&chp->wait);
+	c4iw_cq_rem_ref(chp);
 	c4iw_qp_rem_ref(&qhp->ibqp);
 out:
 	return;
@@ -234,8 +233,7 @@ int c4iw_ev_handler(struct c4iw_dev *dev, u32 qid)
 		spin_lock_irqsave(&chp->comp_handler_lock, flag);
 		(*chp->ibcq.comp_handler)(&chp->ibcq, chp->ibcq.cq_context);
 		spin_unlock_irqrestore(&chp->comp_handler_lock, flag);
-		if (refcount_dec_and_test(&chp->refcnt))
-			wake_up(&chp->wait);
+		c4iw_cq_rem_ref(chp);
 	} else {
 		pr_debug("unknown cqid 0x%x\n", qid);
 		xa_unlock_irqrestore(&dev->cqs, flag);
diff --git a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
index 3883af3..ac5f581 100644
--- a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
+++ b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
@@ -428,7 +428,7 @@ struct c4iw_cq {
 	spinlock_t lock;
 	spinlock_t comp_handler_lock;
 	refcount_t refcnt;
-	wait_queue_head_t wait;
+	struct completion cq_rel_comp;
 	struct c4iw_wr_wait *wr_waitp;
 };
 
@@ -979,6 +979,7 @@ struct ib_mr *c4iw_reg_user_mr(struct ib_pd *pd, u64 start,
 struct ib_mr *c4iw_get_dma_mr(struct ib_pd *pd, int acc);
 int c4iw_dereg_mr(struct ib_mr *ib_mr, struct ib_udata *udata);
 int c4iw_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata);
+void c4iw_cq_rem_ref(struct c4iw_cq *chp);
 int c4iw_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		   struct ib_udata *udata);
 int c4iw_arm_cq(struct ib_cq *ibcq, enum ib_cq_notify_flags flags);
-- 
1.8.3.1

