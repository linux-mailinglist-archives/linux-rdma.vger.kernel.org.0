Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFC96E72B3
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Apr 2023 07:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbjDSFw7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Apr 2023 01:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjDSFw6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Apr 2023 01:52:58 -0400
Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com [68.232.139.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF488268F;
        Tue, 18 Apr 2023 22:52:55 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="115016401"
X-IronPort-AV: E=Sophos;i="5.99,208,1677510000"; 
   d="scan'208";a="115016401"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa6.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 14:52:52 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
        by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 75F2EEDF38;
        Wed, 19 Apr 2023 14:52:50 +0900 (JST)
Received: from m3003.s.css.fujitsu.com (m3003.s.css.fujitsu.com [10.128.233.114])
        by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 849CED5626;
        Wed, 19 Apr 2023 14:52:49 +0900 (JST)
Received: from localhost.localdomain (unknown [10.118.237.106])
        by m3003.s.css.fujitsu.com (Postfix) with ESMTP id 40B322005334;
        Wed, 19 Apr 2023 14:52:49 +0900 (JST)
From:   Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
To:     linux-rdma@vger.kernel.org, leonro@nvidia.com, jgg@nvidia.com,
        zyjzyj2000@gmail.com
Cc:     linux-kernel@vger.kernel.org, rpearsonhpe@gmail.com,
        yangx.jy@fujitsu.com, lizhijian@fujitsu.com,
        Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: [PATCH for-next v4 1/8] RDMA/rxe: Tentative workqueue implementation
Date:   Wed, 19 Apr 2023 14:51:53 +0900
Message-Id: <75b12beb3f3becd951cdee85ec6e5066a12954b1.1681882651.git.matsuda-daisuke@fujitsu.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1681882651.git.matsuda-daisuke@fujitsu.com>
References: <cover.1681882651.git.matsuda-daisuke@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This is a mock patch and not intended to be merged. In order to implement
ODP on rxe, it is necessary to convert triple tasklets to workqueue. I
expect Bob Pearson will submit his patch to do this very soon.

Link: https://lore.kernel.org/linux-rdma/a74126b4-b527-af72-f23e-c9d6711e5285@gmail.com/
Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe.c      |  9 ++-
 drivers/infiniband/sw/rxe/rxe_task.c | 84 ++++++++++++++++++----------
 drivers/infiniband/sw/rxe/rxe_task.h |  6 +-
 3 files changed, 67 insertions(+), 32 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index 7a7e713de52d..54c723a6edda 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -212,10 +212,16 @@ static int __init rxe_module_init(void)
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
@@ -226,6 +232,7 @@ static void __exit rxe_module_exit(void)
 	rdma_link_unregister(&rxe_link_ops);
 	ib_unregister_driver(RDMA_DRIVER_RXE);
 	rxe_net_exit();
+	rxe_destroy_wq();
 
 	pr_info("unloaded\n");
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw/rxe/rxe_task.c
index fb9a6bc8e620..c8aa1763d1f9 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.c
+++ b/drivers/infiniband/sw/rxe/rxe_task.c
@@ -6,8 +6,25 @@
 
 #include "rxe.h"
 
+static struct workqueue_struct *rxe_wq;
+
+int rxe_alloc_wq(void)
+{
+	rxe_wq = alloc_workqueue("rxe_wq", WQ_CPU_INTENSIVE | WQ_UNBOUND,
+				 WQ_MAX_ACTIVE);
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
 /* Check if task is idle i.e. not running, not scheduled in
- * tasklet queue and not draining. If so move to busy to
+ * work queue and not draining. If so move to busy to
  * reserve a slot in do_task() by setting to busy and taking
  * a qp reference to cover the gap from now until the task finishes.
  * state will move out of busy if task returns a non zero value
@@ -21,7 +38,7 @@ static bool __reserve_if_idle(struct rxe_task *task)
 {
 	WARN_ON(rxe_read(task->qp) <= 0);
 
-	if (task->tasklet.state & BIT(TASKLET_STATE_SCHED))
+	if (task->state & BIT(TASKLET_STATE_SCHED))
 		return false;
 
 	if (task->state == TASK_STATE_IDLE) {
@@ -38,7 +55,7 @@ static bool __reserve_if_idle(struct rxe_task *task)
 }
 
 /* check if task is idle or drained and not currently
- * scheduled in the tasklet queue. This routine is
+ * scheduled in the work queue. This routine is
  * called by rxe_cleanup_task or rxe_disable_task to
  * see if the queue is empty.
  * Context: caller should hold task->lock.
@@ -46,7 +63,7 @@ static bool __reserve_if_idle(struct rxe_task *task)
  */
 static bool __is_done(struct rxe_task *task)
 {
-	if (task->tasklet.state & BIT(TASKLET_STATE_SCHED))
+	if (task->state & BIT(TASKLET_STATE_SCHED))
 		return false;
 
 	if (task->state == TASK_STATE_IDLE ||
@@ -77,23 +94,23 @@ static bool is_done(struct rxe_task *task)
  * schedules the task. They must call __reserve_if_idle to
  * move the task to busy before calling or scheduling.
  * The task can also be moved to drained or invalid
- * by calls to rxe-cleanup_task or rxe_disable_task.
+ * by calls to rxe_cleanup_task or rxe_disable_task.
  * In that case tasks which get here are not executed but
  * just flushed. The tasks are designed to look to see if
- * there is work to do and do part of it before returning
+ * there is work to do and then do part of it before returning
  * here with a return value of zero until all the work
- * has been consumed then it retuens a non-zero value.
+ * has been consumed then it returns a non-zero value.
  * The number of times the task can be run is limited by
  * max iterations so one task cannot hold the cpu forever.
+ * If the limit is hit and work remains the task is rescheduled.
  */
-static void do_task(struct tasklet_struct *t)
+static void do_task(struct rxe_task *task)
 {
-	int cont;
-	int ret;
-	struct rxe_task *task = from_tasklet(task, t, tasklet);
 	unsigned int iterations;
 	unsigned long flags;
 	int resched = 0;
+	int cont;
+	int ret;
 
 	WARN_ON(rxe_read(task->qp) <= 0);
 
@@ -122,8 +139,8 @@ static void do_task(struct tasklet_struct *t)
 			} else {
 				/* This can happen if the client
 				 * can add work faster than the
-				 * tasklet can finish it.
-				 * Reschedule the tasklet and exit
+				 * work queue can finish it.
+				 * Reschedule the task and exit
 				 * the loop to give up the cpu
 				 */
 				task->state = TASK_STATE_IDLE;
@@ -131,9 +148,9 @@ static void do_task(struct tasklet_struct *t)
 			}
 			break;
 
-		/* someone tried to run the task since the last time we called
-		 * func, so we will call one more time regardless of the
-		 * return value
+		/* someone tried to run the task since the last time we
+		 * called func, so we will call one more time regardless
+		 * of the return value
 		 */
 		case TASK_STATE_ARMED:
 			task->state = TASK_STATE_BUSY;
@@ -149,13 +166,16 @@ static void do_task(struct tasklet_struct *t)
 
 		default:
 			WARN_ON(1);
-			rxe_info_qp(task->qp, "unexpected task state = %d", task->state);
+			rxe_dbg_qp(task->qp, "unexpected task state = %d",
+				   task->state);
 		}
 
 		if (!cont) {
 			task->num_done++;
 			if (WARN_ON(task->num_done != task->num_sched))
-				rxe_err_qp(task->qp, "%ld tasks scheduled, %ld tasks done",
+				rxe_dbg_qp(task->qp,
+					   "%ld tasks scheduled, "
+					   "%ld tasks done",
 					   task->num_sched, task->num_done);
 		}
 		spin_unlock_irqrestore(&task->lock, flags);
@@ -169,6 +189,12 @@ static void do_task(struct tasklet_struct *t)
 	rxe_put(task->qp);
 }
 
+/* wrapper around do_task to fix argument */
+static void __do_task(struct work_struct *work)
+{
+	do_task(container_of(work, struct rxe_task, work));
+}
+
 int rxe_init_task(struct rxe_task *task, struct rxe_qp *qp,
 		  int (*func)(struct rxe_qp *))
 {
@@ -176,11 +202,9 @@ int rxe_init_task(struct rxe_task *task, struct rxe_qp *qp,
 
 	task->qp = qp;
 	task->func = func;
-
-	tasklet_setup(&task->tasklet, do_task);
-
 	task->state = TASK_STATE_IDLE;
 	spin_lock_init(&task->lock);
+	INIT_WORK(&task->work, __do_task);
 
 	return 0;
 }
@@ -213,8 +237,6 @@ void rxe_cleanup_task(struct rxe_task *task)
 	while (!is_done(task))
 		cond_resched();
 
-	tasklet_kill(&task->tasklet);
-
 	spin_lock_irqsave(&task->lock, flags);
 	task->state = TASK_STATE_INVALID;
 	spin_unlock_irqrestore(&task->lock, flags);
@@ -226,7 +248,7 @@ void rxe_cleanup_task(struct rxe_task *task)
 void rxe_run_task(struct rxe_task *task)
 {
 	unsigned long flags;
-	int run;
+	bool run;
 
 	WARN_ON(rxe_read(task->qp) <= 0);
 
@@ -235,11 +257,11 @@ void rxe_run_task(struct rxe_task *task)
 	spin_unlock_irqrestore(&task->lock, flags);
 
 	if (run)
-		do_task(&task->tasklet);
+		do_task(task);
 }
 
-/* schedule the task to run later as a tasklet.
- * the tasklet)schedule call can be called holding
+/* schedule the task to run later as a work queue entry.
+ * the queue_work call can be called holding
  * the lock.
  */
 void rxe_sched_task(struct rxe_task *task)
@@ -250,7 +272,7 @@ void rxe_sched_task(struct rxe_task *task)
 
 	spin_lock_irqsave(&task->lock, flags);
 	if (__reserve_if_idle(task))
-		tasklet_schedule(&task->tasklet);
+		queue_work(rxe_wq, &task->work);
 	spin_unlock_irqrestore(&task->lock, flags);
 }
 
@@ -277,7 +299,9 @@ void rxe_disable_task(struct rxe_task *task)
 	while (!is_done(task))
 		cond_resched();
 
-	tasklet_disable(&task->tasklet);
+	spin_lock_irqsave(&task->lock, flags);
+	task->state = TASK_STATE_DRAINED;
+	spin_unlock_irqrestore(&task->lock, flags);
 }
 
 void rxe_enable_task(struct rxe_task *task)
@@ -291,7 +315,7 @@ void rxe_enable_task(struct rxe_task *task)
 		spin_unlock_irqrestore(&task->lock, flags);
 		return;
 	}
+
 	task->state = TASK_STATE_IDLE;
-	tasklet_enable(&task->tasklet);
 	spin_unlock_irqrestore(&task->lock, flags);
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_task.h b/drivers/infiniband/sw/rxe/rxe_task.h
index facb7c8e3729..a63e258b3d66 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.h
+++ b/drivers/infiniband/sw/rxe/rxe_task.h
@@ -22,7 +22,7 @@ enum {
  * called again.
  */
 struct rxe_task {
-	struct tasklet_struct	tasklet;
+	struct work_struct	work;
 	int			state;
 	spinlock_t		lock;
 	struct rxe_qp		*qp;
@@ -32,6 +32,10 @@ struct rxe_task {
 	long			num_done;
 };
 
+int rxe_alloc_wq(void);
+
+void rxe_destroy_wq(void);
+
 /*
  * init rxe_task structure
  *	qp  => parameter to pass to func
-- 
2.39.1

