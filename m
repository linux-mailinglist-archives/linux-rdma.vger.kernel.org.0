Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5571654C8E
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Dec 2022 07:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiLWGwW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Dec 2022 01:52:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiLWGwV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 23 Dec 2022 01:52:21 -0500
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com [139.138.36.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93F61DDD3
        for <linux-rdma@vger.kernel.org>; Thu, 22 Dec 2022 22:52:19 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6500,9779,10569"; a="89357418"
X-IronPort-AV: E=Sophos;i="5.96,267,1665414000"; 
   d="scan'208";a="89357418"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP; 23 Dec 2022 15:52:16 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
        by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id EFA35D6476;
        Fri, 23 Dec 2022 15:52:15 +0900 (JST)
Received: from m3003.s.css.fujitsu.com (m3003.s.css.fujitsu.com [10.128.233.114])
        by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 18EE5D94B4;
        Fri, 23 Dec 2022 15:52:15 +0900 (JST)
Received: from localhost.localdomain (unknown [10.19.3.107])
        by m3003.s.css.fujitsu.com (Postfix) with ESMTP id C8420200B2A8;
        Fri, 23 Dec 2022 15:52:14 +0900 (JST)
From:   Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
To:     linux-rdma@vger.kernel.org, leonro@nvidia.com, jgg@nvidia.com,
        zyjzyj2000@gmail.com
Cc:     nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
        rpearsonhpe@gmail.com, yangx.jy@fujitsu.com, lizhijian@fujitsu.com,
        y-goto@fujitsu.com, Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: [PATCH for-next v3 1/7] RDMA/rxe: Convert triple tasklets to use workqueue
Date:   Fri, 23 Dec 2022 15:51:52 +0900
Message-Id: <d2f6b3aca61fe1858a97cda94691eece6b0e60bd.1671772917.git.matsuda-daisuke@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1671772917.git.matsuda-daisuke@fujitsu.com>
References: <cover.1671772917.git.matsuda-daisuke@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In order to implement On-Demand Paging on the rxe driver, triple tasklets
(requester, responder, and completer) must be allowed to sleep so that they
can trigger page fault when pages being accessed are not present.

This patch replaces the tasklets with a workqueue, but still allows direct-
call of works from softirq context if it is obvious that MRs are not going
to be accessed and there is no work being processed in the workqueue.

As counterparts to tasklet_disable() and tasklet_enable() are missing for
workqueues, an atomic value is introduced to prevent work items from being
scheduled while qp reset is in progress.

The way to initialize/destroy workqueue is picked up from the
implementation of Ian Ziemba and Bob Pearson at HPE.

Link: https://lore.kernel.org/all/20221018043345.4033-1-rpearsonhpe@gmail.com/
Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe.c       |  9 ++++-
 drivers/infiniband/sw/rxe/rxe_comp.c  |  2 +-
 drivers/infiniband/sw/rxe/rxe_param.h |  2 +-
 drivers/infiniband/sw/rxe/rxe_qp.c    |  2 +-
 drivers/infiniband/sw/rxe/rxe_req.c   |  2 +-
 drivers/infiniband/sw/rxe/rxe_resp.c  |  2 +-
 drivers/infiniband/sw/rxe/rxe_task.c  | 52 ++++++++++++++++++++-------
 drivers/infiniband/sw/rxe/rxe_task.h  | 15 ++++++--
 8 files changed, 65 insertions(+), 21 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index 136c2efe3466..3c7e42e5b0c7 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -210,10 +210,16 @@ static int __init rxe_module_init(void)
 {
 	int err;
 
-	err = rxe_net_init();
+	err = rxe_alloc_wq();
 	if (err)
 		return err;
 
+	err = rxe_net_init();
+	if (err) {
+		rxe_destroy_wq();
+		return err;
+	}
+
 	rdma_link_register(&rxe_link_ops);
 	pr_info("loaded\n");
 	return 0;
@@ -224,6 +230,7 @@ static void __exit rxe_module_exit(void)
 	rdma_link_unregister(&rxe_link_ops);
 	ib_unregister_driver(RDMA_DRIVER_RXE);
 	rxe_net_exit();
+	rxe_destroy_wq();
 
 	pr_info("unloaded\n");
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index 20737fec392b..046bbacce37c 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -773,7 +773,7 @@ int rxe_completer(void *arg)
 	}
 
 	/* A non-zero return value will cause rxe_do_task to
-	 * exit its loop and end the tasklet. A zero return
+	 * exit its loop and end the work item. A zero return
 	 * will continue looping and return to rxe_completer
 	 */
 done:
diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
index a754fc902e3d..bd8050e99d6b 100644
--- a/drivers/infiniband/sw/rxe/rxe_param.h
+++ b/drivers/infiniband/sw/rxe/rxe_param.h
@@ -112,7 +112,7 @@ enum rxe_device_param {
 	RXE_INFLIGHT_SKBS_PER_QP_HIGH	= 64,
 	RXE_INFLIGHT_SKBS_PER_QP_LOW	= 16,
 
-	/* Max number of interations of each tasklet
+	/* Max number of interations of each work item
 	 * before yielding the cpu to let other
 	 * work make progress
 	 */
diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index ab72db68b58f..e033b2449dfe 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -471,7 +471,7 @@ int rxe_qp_chk_attr(struct rxe_dev *rxe, struct rxe_qp *qp,
 /* move the qp to the reset state */
 static void rxe_qp_reset(struct rxe_qp *qp)
 {
-	/* stop tasks from running */
+	/* flush workqueue and stop tasks from running */
 	rxe_disable_task(&qp->resp.task);
 
 	/* stop request/comp */
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 899c8779f800..2bcd287a2c3b 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -830,7 +830,7 @@ int rxe_requester(void *arg)
 	update_state(qp, &pkt);
 
 	/* A non-zero return value will cause rxe_do_task to
-	 * exit its loop and end the tasklet. A zero return
+	 * exit its loop and end the work item. A zero return
 	 * will continue looping and return to rxe_requester
 	 */
 done:
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index c74972244f08..d9134a00a529 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -1691,7 +1691,7 @@ int rxe_responder(void *arg)
 	}
 
 	/* A non-zero return value will cause rxe_do_task to
-	 * exit its loop and end the tasklet. A zero return
+	 * exit its loop and end the work item. A zero return
 	 * will continue looping and return to rxe_responder
 	 */
 done:
diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw/rxe/rxe_task.c
index 60b90e33a884..b96f72aa9005 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.c
+++ b/drivers/infiniband/sw/rxe/rxe_task.c
@@ -6,6 +6,22 @@
 
 #include "rxe.h"
 
+static struct workqueue_struct *rxe_wq;
+
+int rxe_alloc_wq(void)
+{
+	rxe_wq = alloc_workqueue("rxe_wq", WQ_CPU_INTENSIVE, WQ_MAX_ACTIVE);
+	if (!rxe_wq)
+		return -ENOMEM;
+
+	return 0;
+}
+
+void rxe_destroy_wq(void)
+{
+	destroy_workqueue(rxe_wq);
+}
+
 int __rxe_do_task(struct rxe_task *task)
 
 {
@@ -24,11 +40,11 @@ int __rxe_do_task(struct rxe_task *task)
  * a second caller finds the task already running
  * but looks just after the last call to func
  */
-static void do_task(struct tasklet_struct *t)
+static void do_task(struct work_struct *w)
 {
 	int cont;
 	int ret;
-	struct rxe_task *task = from_tasklet(task, t, tasklet);
+	struct rxe_task *task = container_of(w, typeof(*task), work);
 	struct rxe_qp *qp = (struct rxe_qp *)task->arg;
 	unsigned int iterations = RXE_MAX_ITERATIONS;
 
@@ -64,10 +80,10 @@ static void do_task(struct tasklet_struct *t)
 			} else if (iterations--) {
 				cont = 1;
 			} else {
-				/* reschedule the tasklet and exit
+				/* reschedule the work item and exit
 				 * the loop to give up the cpu
 				 */
-				tasklet_schedule(&task->tasklet);
+				queue_work(task->workq, &task->work);
 				task->state = TASK_STATE_START;
 			}
 			break;
@@ -97,7 +113,8 @@ int rxe_init_task(struct rxe_task *task, void *arg, int (*func)(void *))
 	task->func	= func;
 	task->destroyed	= false;
 
-	tasklet_setup(&task->tasklet, do_task);
+	INIT_WORK(&task->work, do_task);
+	task->workq = rxe_wq;
 
 	task->state = TASK_STATE_START;
 	spin_lock_init(&task->lock);
@@ -111,17 +128,16 @@ void rxe_cleanup_task(struct rxe_task *task)
 
 	/*
 	 * Mark the task, then wait for it to finish. It might be
-	 * running in a non-tasklet (direct call) context.
+	 * running in a non-workqueue (direct call) context.
 	 */
 	task->destroyed = true;
+	flush_workqueue(task->workq);
 
 	do {
 		spin_lock_bh(&task->lock);
 		idle = (task->state == TASK_STATE_START);
 		spin_unlock_bh(&task->lock);
 	} while (!idle);
-
-	tasklet_kill(&task->tasklet);
 }
 
 void rxe_run_task(struct rxe_task *task)
@@ -129,7 +145,7 @@ void rxe_run_task(struct rxe_task *task)
 	if (task->destroyed)
 		return;
 
-	do_task(&task->tasklet);
+	do_task(&task->work);
 }
 
 void rxe_sched_task(struct rxe_task *task)
@@ -137,15 +153,27 @@ void rxe_sched_task(struct rxe_task *task)
 	if (task->destroyed)
 		return;
 
-	tasklet_schedule(&task->tasklet);
+	/*
+	 * busy-loop while qp reset is in progress.
+	 * This may be called from softirq context and thus cannot sleep.
+	 */
+	while (atomic_read(&task->suspended))
+		cpu_relax();
+
+	queue_work(task->workq, &task->work);
 }
 
 void rxe_disable_task(struct rxe_task *task)
 {
-	tasklet_disable(&task->tasklet);
+	/* Alternative to tasklet_disable() */
+	atomic_inc(&task->suspended);
+	smp_mb__after_atomic();
+	flush_workqueue(task->workq);
 }
 
 void rxe_enable_task(struct rxe_task *task)
 {
-	tasklet_enable(&task->tasklet);
+	/* Alternative to tasklet_enable() */
+	smp_mb__before_atomic();
+	atomic_dec(&task->suspended);
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_task.h b/drivers/infiniband/sw/rxe/rxe_task.h
index 7b88129702ac..9aa3f236e886 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.h
+++ b/drivers/infiniband/sw/rxe/rxe_task.h
@@ -19,15 +19,22 @@ enum {
  * called again.
  */
 struct rxe_task {
-	struct tasklet_struct	tasklet;
+	struct workqueue_struct	*workq;
+	struct work_struct	work;
 	int			state;
 	spinlock_t		lock;
 	void			*arg;
 	int			(*func)(void *arg);
 	int			ret;
 	bool			destroyed;
+	/* used to {dis, en}able per-qp work items */
+	atomic_t		suspended;
 };
 
+int rxe_alloc_wq(void);
+
+void rxe_destroy_wq(void);
+
 /*
  * init rxe_task structure
  *	arg  => parameter to pass to fcn
@@ -40,18 +47,20 @@ void rxe_cleanup_task(struct rxe_task *task);
 
 /*
  * raw call to func in loop without any checking
- * can call when tasklets are disabled
+ * can call when tasks are suspended
  */
 int __rxe_do_task(struct rxe_task *task);
 
+/* run a task without scheduling */
 void rxe_run_task(struct rxe_task *task);
 
+/* schedule a task into workqueue */
 void rxe_sched_task(struct rxe_task *task);
 
 /* keep a task from scheduling */
 void rxe_disable_task(struct rxe_task *task);
 
-/* allow task to run */
+/* allow a task to run again */
 void rxe_enable_task(struct rxe_task *task);
 
 #endif /* RXE_TASK_H */
-- 
2.31.1

