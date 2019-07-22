Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDC9570363
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jul 2019 17:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbfGVPOt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Jul 2019 11:14:49 -0400
Received: from os.inf.tu-dresden.de ([141.76.48.99]:58334 "EHLO
        os.inf.tu-dresden.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728275AbfGVPOs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Jul 2019 11:14:48 -0400
Received: from [195.176.96.199] (helo=jupiter)
        by os.inf.tu-dresden.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92)
        id 1hpa1P-0008AR-AQ; Mon, 22 Jul 2019 17:14:39 +0200
From:   Maksym Planeta <mplaneta@os.inf.tu-dresden.de>
To:     Moni Shoua <monis@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Maksym Planeta <mplaneta@os.inf.tu-dresden.de>
Subject: [PATCH 10/10] Replace tasklets with workqueues
Date:   Mon, 22 Jul 2019 17:14:26 +0200
Message-Id: <20190722151426.5266-11-mplaneta@os.inf.tu-dresden.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190722151426.5266-1-mplaneta@os.inf.tu-dresden.de>
References: <20190722151426.5266-1-mplaneta@os.inf.tu-dresden.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Replace tasklets with workqueues in rxe driver.

Ensure that task is called only through a workqueue. This allows to
simplify task logic.

Add additional dependencies to make sure that cleanup tasks do not
happen after object's memory is already reclaimed.

Improve overal stability of the driver by removing multiple race
conditions and use-after-free situations.

Signed-off-by: Maksym Planeta <mplaneta@os.inf.tu-dresden.de>
---
 drivers/infiniband/sw/rxe/rxe_cq.c    |  15 ++-
 drivers/infiniband/sw/rxe/rxe_net.c   |  17 +++-
 drivers/infiniband/sw/rxe/rxe_qp.c    |  73 ++++++++-------
 drivers/infiniband/sw/rxe/rxe_req.c   |   4 +-
 drivers/infiniband/sw/rxe/rxe_task.c  | 126 ++++++++------------------
 drivers/infiniband/sw/rxe/rxe_task.h  |  38 ++------
 drivers/infiniband/sw/rxe/rxe_verbs.c |   7 ++
 drivers/infiniband/sw/rxe/rxe_verbs.h |   7 +-
 8 files changed, 124 insertions(+), 163 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_cq.c b/drivers/infiniband/sw/rxe/rxe_cq.c
index 5693986c8c1b..6c3cf5ba2911 100644
--- a/drivers/infiniband/sw/rxe/rxe_cq.c
+++ b/drivers/infiniband/sw/rxe/rxe_cq.c
@@ -66,9 +66,9 @@ int rxe_cq_chk_attr(struct rxe_dev *rxe, struct rxe_cq *cq,
 	return -EINVAL;
 }
 
-static void rxe_send_complete(unsigned long data)
+static void rxe_send_complete(struct work_struct *work)
 {
-	struct rxe_cq *cq = (struct rxe_cq *)data;
+	struct rxe_cq *cq = container_of(work, typeof(*cq), work);
 	unsigned long flags;
 
 	spin_lock_irqsave(&cq->cq_lock, flags);
@@ -106,8 +106,12 @@ int rxe_cq_from_init(struct rxe_dev *rxe, struct rxe_cq *cq, int cqe,
 		cq->is_user = 1;
 
 	cq->is_dying = false;
+	INIT_WORK(&cq->work, rxe_send_complete);
 
-	tasklet_init(&cq->comp_task, rxe_send_complete, (unsigned long)cq);
+	cq->wq = alloc_ordered_workqueue("cq:send_complete", 0);
+	if (!cq->wq) {
+		return -ENOMEM;
+	}
 
 	spin_lock_init(&cq->cq_lock);
 	cq->ibcq.cqe = cqe;
@@ -161,7 +165,7 @@ int rxe_cq_post(struct rxe_cq *cq, struct rxe_cqe *cqe, int solicited)
 	if ((cq->notify == IB_CQ_NEXT_COMP) ||
 	    (cq->notify == IB_CQ_SOLICITED && solicited)) {
 		cq->notify = 0;
-		tasklet_schedule(&cq->comp_task);
+		queue_work(cq->wq, &cq->work);
 	}
 
 	return 0;
@@ -183,5 +187,8 @@ void rxe_cq_cleanup(struct rxe_pool_entry *arg)
 	if (cq->queue)
 		rxe_queue_cleanup(cq->queue);
 
+	if (cq->wq)
+		destroy_workqueue(cq->wq);
+
 	rxe_elem_cleanup(arg);
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index f8c3604bc5ad..2997edc27592 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -410,13 +410,20 @@ static void rxe_skb_tx_dtor(struct sk_buff *skb)
 {
 	struct sock *sk = skb->sk;
 	struct rxe_qp *qp = sk->sk_user_data;
-	int skb_out = atomic_dec_return(&qp->skb_out);
+	int skb_out = atomic_read(&qp->skb_out);
 
-	if (unlikely(qp->need_req_skb &&
-		     skb_out < RXE_INFLIGHT_SKBS_PER_QP_LOW))
-		rxe_run_task(&qp->req.task);
+	atomic_inc(&qp->pending_skb_down);
+	skb_out = atomic_read(&qp->pending_skb_down);
+	if (!rxe_drop_ref(&qp->pelem)) {
+		atomic_dec(&qp->pending_skb_down);
+		atomic_dec(&qp->skb_out);
 
-	rxe_drop_ref(&qp->pelem);
+		if (unlikely(qp->need_req_skb &&
+			     skb_out < RXE_INFLIGHT_SKBS_PER_QP_LOW))
+			rxe_run_task(&qp->req.task);
+
+		skb_out = atomic_read(&qp->pending_skb_down);
+	}
 }
 
 int rxe_send(struct rxe_pkt_info *pkt, struct sk_buff *skb)
diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index 2fccdede8869..2bb25360319e 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -214,6 +214,7 @@ static void rxe_qp_init_misc(struct rxe_dev *rxe, struct rxe_qp *qp,
 
 	atomic_set(&qp->ssn, 0);
 	atomic_set(&qp->skb_out, 0);
+	atomic_set(&qp->pending_skb_down, 0);
 }
 
 static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
@@ -332,6 +333,8 @@ static int rxe_qp_init_resp(struct rxe_dev *rxe, struct rxe_qp *qp,
 	return 0;
 }
 
+void rxe_qp_do_cleanup(struct work_struct *work);
+
 /* called by the create qp verb */
 int rxe_qp_from_init(struct rxe_dev *rxe, struct rxe_qp *qp, struct rxe_pd *pd,
 		     struct ib_qp_init_attr *init,
@@ -368,6 +371,9 @@ int rxe_qp_from_init(struct rxe_dev *rxe, struct rxe_qp *qp, struct rxe_pd *pd,
 	qp->attr.qp_state = IB_QPS_RESET;
 	qp->valid = 1;
 
+	INIT_WORK(&qp->cleanup_work, rxe_qp_do_cleanup);
+	qp->cleanup_completion = NULL;
+
 	return 0;
 
 err2:
@@ -499,16 +505,6 @@ int rxe_qp_chk_attr(struct rxe_dev *rxe, struct rxe_qp *qp,
 /* move the qp to the reset state */
 static void rxe_qp_reset(struct rxe_qp *qp)
 {
-	/* stop tasks from running */
-	rxe_disable_task(&qp->resp.task);
-
-	/* stop request/comp */
-	if (qp->sq.queue) {
-		if (qp_type(qp) == IB_QPT_RC)
-			rxe_disable_task(&qp->comp.task);
-		rxe_disable_task(&qp->req.task);
-	}
-
 	/* move qp to the reset state */
 	qp->req.state = QP_STATE_RESET;
 	qp->resp.state = QP_STATE_RESET;
@@ -516,26 +512,16 @@ static void rxe_qp_reset(struct rxe_qp *qp)
 	/* let state machines reset themselves drain work and packet queues
 	 * etc.
 	 */
-	__rxe_do_task(&qp->resp.task);
+	rxe_run_task_wait(&qp->req.task);
 
 	if (qp->sq.queue) {
-		__rxe_do_task(&qp->comp.task);
-		__rxe_do_task(&qp->req.task);
+		rxe_run_task_wait(&qp->comp.task);
+		rxe_run_task_wait(&qp->req.task);
 		rxe_queue_reset(qp->sq.queue);
 	}
 
 	/* cleanup attributes */
 	atomic_set(&qp->ssn, 0);
-
-	/* reenable tasks */
-	rxe_enable_task(&qp->resp.task);
-
-	if (qp->sq.queue) {
-		if (qp_type(qp) == IB_QPT_RC)
-			rxe_enable_task(&qp->comp.task);
-
-		rxe_enable_task(&qp->req.task);
-	}
 }
 
 /* drain the send queue */
@@ -547,7 +533,7 @@ static void rxe_qp_drain(struct rxe_qp *qp)
 			if (qp_type(qp) == IB_QPT_RC)
 				rxe_run_task(&qp->comp.task);
 			else
-				__rxe_do_task(&qp->comp.task);
+				rxe_run_task_wait(&qp->comp.task);
 			rxe_run_task(&qp->req.task);
 		}
 	}
@@ -566,7 +552,7 @@ void rxe_qp_error(struct rxe_qp *qp)
 	if (qp_type(qp) == IB_QPT_RC)
 		rxe_run_task(&qp->comp.task);
 	else
-		__rxe_do_task(&qp->comp.task);
+		rxe_run_task_wait(&qp->comp.task);
 	rxe_run_task(&qp->req.task);
 }
 
@@ -778,18 +764,22 @@ void rxe_qp_destroy(struct rxe_qp *qp)
 	rxe_cleanup_task(&qp->req.task);
 	rxe_cleanup_task(&qp->comp.task);
 
-	/* flush out any receive wr's or pending requests */
-	__rxe_do_task(&qp->req.task);
-	if (qp->sq.queue) {
-		__rxe_do_task(&qp->comp.task);
-		__rxe_do_task(&qp->req.task);
+	while (true) {
+		int skb_out;
+		skb_out = atomic_read(&qp->skb_out);
+		pr_debug("Waiting until %d skb's to flush at qp#%d\n", skb_out, qp_num(qp));
+		if (skb_out > 0)
+			msleep(10);
+		else
+			break;
 	}
 }
 
 /* called when the last reference to the qp is dropped */
-static void rxe_qp_do_cleanup(struct work_struct *work)
+void rxe_qp_do_cleanup(struct work_struct *work)
 {
-	struct rxe_qp *qp = container_of(work, typeof(*qp), cleanup_work.work);
+	int pending;
+	struct rxe_qp *qp = container_of(work, typeof(*qp), cleanup_work);
 
 	rxe_drop_all_mcast_groups(qp);
 
@@ -821,12 +811,25 @@ static void rxe_qp_do_cleanup(struct work_struct *work)
 
 	kernel_sock_shutdown(qp->sk, SHUT_RDWR);
 	sock_release(qp->sk);
+
+	do {
+		pending = atomic_dec_return(&qp->pending_skb_down);
+		if (pending < 0) {
+			atomic_inc(&qp->pending_skb_down);
+			break;
+		}
+
+		atomic_dec(&qp->skb_out);
+	} while (pending);
+
+	BUG_ON(!qp->cleanup_completion);
+	complete(qp->cleanup_completion);
+
+	rxe_elem_cleanup(&qp->pelem);
 }
 
-/* called when the last reference to the qp is dropped */
 void rxe_qp_cleanup(struct rxe_pool_entry *arg)
 {
 	struct rxe_qp *qp = container_of(arg, typeof(*qp), pelem);
-
-	execute_in_process_context(rxe_qp_do_cleanup, &qp->cleanup_work);
+	queue_work(system_highpri_wq, &qp->cleanup_work);
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 3bb9afdeaee1..829e37208b8e 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -700,7 +700,7 @@ int rxe_requester(void *arg)
 						       qp->req.wqe_index);
 			wqe->state = wqe_state_done;
 			wqe->status = IB_WC_SUCCESS;
-			__rxe_do_task(&qp->comp.task);
+			rxe_run_task_wait(&qp->comp.task);
 			return 0;
 		}
 		payload = mtu;
@@ -748,7 +748,7 @@ int rxe_requester(void *arg)
 err:
 	wqe->status = IB_WC_LOC_PROT_ERR;
 	wqe->state = wqe_state_error;
-	__rxe_do_task(&qp->comp.task);
+	rxe_run_task_wait(&qp->comp.task);
 
 exit:
 	return -EAGAIN;
diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw/rxe/rxe_task.c
index 9d6b8ad08a3a..df6920361865 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.c
+++ b/drivers/infiniband/sw/rxe/rxe_task.c
@@ -38,81 +38,39 @@
 #include "rxe.h"
 #include "rxe_task.h"
 
-int __rxe_do_task(struct rxe_task *task)
-
+/*
+ * common function called by any of the main tasklets
+ * If there is any chance that there is additional
+ * work to do someone must reschedule the task before
+ * leaving
+ */
+static void rxe_do_task(struct work_struct *work)
 {
+	struct rxe_task *task = container_of(work, typeof(*task), work);
+	struct rxe_qp *qp = (struct rxe_qp *)task->arg;
 	int ret;
 
-	while ((ret = task->func(task->arg)) == 0)
-		;
+	do {
+		if (task->destroyed) {
+			pr_debug("Running a destroyed task %p\n", task);
+		}
 
-	task->ret = ret;
+		if (!qp->valid) {
+			pr_debug("Running a task %p with an invalid qp#%d\n", task, qp_num(qp));
+		}
+
+		ret = task->func(task->arg);
+	} while (!ret);
 
-	return ret;
 }
 
-/*
- * this locking is due to a potential race where
- * a second caller finds the task already running
- * but looks just after the last call to func
- */
-void rxe_do_task(unsigned long data)
+static void rxe_do_task_notify(struct work_struct *work)
 {
-	int cont;
-	int ret;
-	unsigned long flags;
-	struct rxe_task *task = (struct rxe_task *)data;
-
-	spin_lock_irqsave(&task->state_lock, flags);
-	switch (task->state) {
-	case TASK_STATE_START:
-		task->state = TASK_STATE_BUSY;
-		spin_unlock_irqrestore(&task->state_lock, flags);
-		break;
-
-	case TASK_STATE_BUSY:
-		task->state = TASK_STATE_ARMED;
-		/* fall through */
-	case TASK_STATE_ARMED:
-		spin_unlock_irqrestore(&task->state_lock, flags);
-		return;
-
-	default:
-		spin_unlock_irqrestore(&task->state_lock, flags);
-		pr_warn("%s failed with bad state %d\n", __func__, task->state);
-		return;
-	}
+	struct rxe_task *task = container_of(work, typeof(*task), wait_work);
 
-	do {
-		cont = 0;
-		ret = task->func(task->arg);
-
-		spin_lock_irqsave(&task->state_lock, flags);
-		switch (task->state) {
-		case TASK_STATE_BUSY:
-			if (ret)
-				task->state = TASK_STATE_START;
-			else
-				cont = 1;
-			break;
-
-		/* soneone tried to run the task since the last time we called
-		 * func, so we will call one more time regardless of the
-		 * return value
-		 */
-		case TASK_STATE_ARMED:
-			task->state = TASK_STATE_BUSY;
-			cont = 1;
-			break;
-
-		default:
-			pr_warn("%s failed with bad state %d\n", __func__,
-				task->state);
-		}
-		spin_unlock_irqrestore(&task->state_lock, flags);
-	} while (cont);
+	rxe_do_task(&task->work);
 
-	task->ret = ret;
+	complete_all(&task->completion);
 }
 
 int rxe_init_task(void *obj, struct rxe_task *task,
@@ -125,18 +83,21 @@ int rxe_init_task(void *obj, struct rxe_task *task,
 	task->destroyed	= false;
 
 	rxe_add_ref(&qp->pelem);
-	tasklet_init(&task->tasklet, rxe_do_task, (unsigned long)task);
+	init_completion(&task->completion);
+
+	INIT_WORK(&task->work, rxe_do_task);
+	INIT_WORK(&task->wait_work, rxe_do_task_notify);
 
-	task->state = TASK_STATE_START;
-	spin_lock_init(&task->state_lock);
+	task->wq = alloc_ordered_workqueue("qp#%d:%s", 0, qp_num(qp), name);
+	if (!task->wq) {
+		return -ENOMEM;
+	}
 
 	return 0;
 }
 
 void rxe_cleanup_task(struct rxe_task *task)
 {
-	unsigned long flags;
-	bool idle;
 	struct rxe_qp *qp = (struct rxe_qp *)task->arg;
 
 	/*
@@ -145,30 +106,23 @@ void rxe_cleanup_task(struct rxe_task *task)
 	 */
 	task->destroyed = true;
 
-	do {
-		spin_lock_irqsave(&task->state_lock, flags);
-		idle = (task->state == TASK_STATE_START);
-		spin_unlock_irqrestore(&task->state_lock, flags);
-	} while (!idle);
+	rxe_run_task(task);
+
+	destroy_workqueue(task->wq);
 
-	tasklet_kill(&task->tasklet);
 	rxe_drop_ref(&qp->pelem);
 }
 
 void rxe_run_task(struct rxe_task *task)
 {
-	if (task->destroyed)
-		return;
-
-	tasklet_schedule(&task->tasklet);
+	queue_work(task->wq, &task->work);
 }
 
-void rxe_disable_task(struct rxe_task *task)
+void rxe_run_task_wait(struct rxe_task *task)
 {
-	tasklet_disable(&task->tasklet);
-}
+	reinit_completion(&task->completion);
 
-void rxe_enable_task(struct rxe_task *task)
-{
-	tasklet_enable(&task->tasklet);
+	queue_work(task->wq, &task->wait_work);
+
+	wait_for_completion(&task->completion);
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_task.h b/drivers/infiniband/sw/rxe/rxe_task.h
index 671b1774b577..c1568a05fb24 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.h
+++ b/drivers/infiniband/sw/rxe/rxe_task.h
@@ -34,12 +34,6 @@
 #ifndef RXE_TASK_H
 #define RXE_TASK_H
 
-enum {
-	TASK_STATE_START	= 0,
-	TASK_STATE_BUSY		= 1,
-	TASK_STATE_ARMED	= 2,
-};
-
 /*
  * data structure to describe a 'task' which is a short
  * function that returns 0 as long as it needs to be
@@ -47,14 +41,14 @@ enum {
  */
 struct rxe_task {
 	void			*obj;
-	struct tasklet_struct	tasklet;
-	int			state;
-	spinlock_t		state_lock; /* spinlock for task state */
+	struct workqueue_struct	*wq;
 	void			*arg;
 	int			(*func)(void *arg);
-	int			ret;
 	char			name[16];
 	bool			destroyed;
+	struct work_struct	work;
+	struct work_struct	wait_work;
+	struct completion	completion;
 };
 
 /*
@@ -69,28 +63,14 @@ int rxe_init_task(void *obj, struct rxe_task *task,
 void rxe_cleanup_task(struct rxe_task *task);
 
 /*
- * raw call to func in loop without any checking
- * can call when tasklets are disabled
- */
-int __rxe_do_task(struct rxe_task *task);
-
-/*
- * common function called by any of the main tasklets
- * If there is any chance that there is additional
- * work to do someone must reschedule the task before
- * leaving
+ * schedule task to run on a workqueue.
  */
-void rxe_do_task(unsigned long data);
+void rxe_run_task(struct rxe_task *task);
 
 /*
- * schedule task to run as a tasklet.
+ * Run a task and wait until it completes. Recursive dependencies should be
+ * avoided.
  */
-void rxe_run_task(struct rxe_task *task);
-
-/* keep a task from scheduling */
-void rxe_disable_task(struct rxe_task *task);
-
-/* allow task to run */
-void rxe_enable_task(struct rxe_task *task);
+void rxe_run_task_wait(struct rxe_task *task);
 
 #endif /* RXE_TASK_H */
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 545eff108070..ce54d44034f6 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -493,10 +493,17 @@ static int rxe_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 static int rxe_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 {
 	struct rxe_qp *qp = to_rqp(ibqp);
+	DECLARE_COMPLETION_ONSTACK(cleanup_completion);
+
+	BUG_ON(qp->cleanup_completion);
+	qp->cleanup_completion = &cleanup_completion;
 
 	rxe_qp_destroy(qp);
 	rxe_drop_index(&qp->pelem);
 	rxe_drop_ref(&qp->pelem);
+
+	wait_for_completion(&cleanup_completion);
+
 	return 0;
 }
 
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 8dd65c2a7c72..d022826a2895 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -91,7 +91,8 @@ struct rxe_cq {
 	u8			notify;
 	bool			is_dying;
 	int			is_user;
-	struct tasklet_struct	comp_task;
+	struct workqueue_struct	*wq;
+	struct work_struct	work;
 };
 
 enum wqe_state {
@@ -270,6 +271,7 @@ struct rxe_qp {
 
 	atomic_t		ssn;
 	atomic_t		skb_out;
+	atomic_t		pending_skb_down;
 	int			need_req_skb;
 
 	/* Timer for retranmitting packet when ACKs have been lost. RC
@@ -285,7 +287,8 @@ struct rxe_qp {
 
 	spinlock_t		state_lock; /* guard requester and completer */
 
-	struct execute_work	cleanup_work;
+	struct work_struct	cleanup_work;
+	struct completion	*cleanup_completion;
 };
 
 enum rxe_mem_state {
-- 
2.20.1

