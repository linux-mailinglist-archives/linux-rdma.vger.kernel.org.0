Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8EF47AB60B
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Sep 2023 18:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjIVQch (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Sep 2023 12:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbjIVQcf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 Sep 2023 12:32:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509E1122;
        Fri, 22 Sep 2023 09:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695400349; x=1726936349;
  h=from:to:cc:subject:date:message-id:reply-to:mime-version:
   content-transfer-encoding;
  bh=wsqSBlcmNlstCDEqPVOdELheRmNhoWnLK79tcKk10Pc=;
  b=Q2HiovDBswsuesrEUSgl+hgIV6YpB/GdcDutRj2P4WFqaX7U+ET5omew
   m3c4gM+VBzqihvsPyrTI977MPiDYr/xD0C1eZ2/23ENC2o7eZaATO/Fzv
   FFAz2OTV/kPaVnwzmNOFfQBWfO7wz7Ae3TWNT4kNW/5ikirz4fS4OkqkZ
   KwLXO6pTeCaKL4U52r6v1/IhJjGA+Ut7R+Jjm+MCjRO4N7ZwM091nHNKR
   JcQ/EfohlHZLNiNzUYi/HNpTAXyKfc+sVSng3k/oS8tSoPKAWTlImk+jO
   iNLz17berRmoQQiDLaFmpVB5evsETolcWo7ksNNvTR8FjT0Zxd3/tnb1f
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="383627745"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="383627745"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 09:32:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="837809359"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="837809359"
Received: from unknown (HELO fedora.bj.intel.com) ([10.238.154.52])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Sep 2023 09:32:25 -0700
From:   Zhu Yanjun <yanjun.zhu@intel.com>
To:     zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org, rpearsonhpe@gmail.com,
        matsuda-daisuke@fujitsu.com, bvanassche@acm.org,
        shinichiro.kawasaki@wdc.com, linux-scsi@vger.kernel.org
Cc:     Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: [PATCH 1/1] Revert "RDMA/rxe: Add workqueue support for rxe tasks"
Date:   Fri, 22 Sep 2023 12:32:31 -0400
Message-Id: <20230922163231.2237811-1-yanjun.zhu@intel.com>
X-Mailer: git-send-email 2.40.1
Reply-To: dsg6rd66tyiei32zaxs6ddv5ebefr5vtxjwz6d2ewqrcwisogl@ge7jzan7dg5u
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <yanjun.zhu@linux.dev>

This reverts commit 9b4b7c1f9f54120940e243251e2b1407767b3381.

This commit replaces tasklet with workqueue. But this results
in occasionally pocess hang at the blktests test case srp/002.
After the discussion in the link[1], this commit is reverted.

Link: https://lore.kernel.org/linux-rdma/e8b76fae-780a-470e-8ec4-c6b650793d10@leemhuis.info/T/#t [1]
Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
CC: rpearsonhpe@gmail.com
CC: matsuda-daisuke@fujitsu.com
CC: bvanassche@acm.org
CC: shinichiro.kawasaki@wdc.com
---
 drivers/infiniband/sw/rxe/rxe.c      |   9 +--
 drivers/infiniband/sw/rxe/rxe_task.c | 110 ++++++++++++---------------
 drivers/infiniband/sw/rxe/rxe_task.h |   6 +-
 3 files changed, 49 insertions(+), 76 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index 54c723a6edda..7a7e713de52d 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -212,15 +212,9 @@ static int __init rxe_module_init(void)
 {
 	int err;
 
-	err = rxe_alloc_wq();
-	if (err)
-		return err;
-
 	err = rxe_net_init();
-	if (err) {
-		rxe_destroy_wq();
+	if (err)
 		return err;
-	}
 
 	rdma_link_register(&rxe_link_ops);
 	pr_info("loaded\n");
@@ -232,7 +226,6 @@ static void __exit rxe_module_exit(void)
 	rdma_link_unregister(&rxe_link_ops);
 	ib_unregister_driver(RDMA_DRIVER_RXE);
 	rxe_net_exit();
-	rxe_destroy_wq();
 
 	pr_info("unloaded\n");
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw/rxe/rxe_task.c
index 1501120d4f52..fb9a6bc8e620 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.c
+++ b/drivers/infiniband/sw/rxe/rxe_task.c
@@ -6,24 +6,8 @@
 
 #include "rxe.h"
 
-static struct workqueue_struct *rxe_wq;
-
-int rxe_alloc_wq(void)
-{
-	rxe_wq = alloc_workqueue("rxe_wq", WQ_UNBOUND, WQ_MAX_ACTIVE);
-	if (!rxe_wq)
-		return -ENOMEM;
-
-	return 0;
-}
-
-void rxe_destroy_wq(void)
-{
-	destroy_workqueue(rxe_wq);
-}
-
 /* Check if task is idle i.e. not running, not scheduled in
- * work queue and not draining. If so move to busy to
+ * tasklet queue and not draining. If so move to busy to
  * reserve a slot in do_task() by setting to busy and taking
  * a qp reference to cover the gap from now until the task finishes.
  * state will move out of busy if task returns a non zero value
@@ -37,6 +21,9 @@ static bool __reserve_if_idle(struct rxe_task *task)
 {
 	WARN_ON(rxe_read(task->qp) <= 0);
 
+	if (task->tasklet.state & BIT(TASKLET_STATE_SCHED))
+		return false;
+
 	if (task->state == TASK_STATE_IDLE) {
 		rxe_get(task->qp);
 		task->state = TASK_STATE_BUSY;
@@ -51,7 +38,7 @@ static bool __reserve_if_idle(struct rxe_task *task)
 }
 
 /* check if task is idle or drained and not currently
- * scheduled in the work queue. This routine is
+ * scheduled in the tasklet queue. This routine is
  * called by rxe_cleanup_task or rxe_disable_task to
  * see if the queue is empty.
  * Context: caller should hold task->lock.
@@ -59,7 +46,7 @@ static bool __reserve_if_idle(struct rxe_task *task)
  */
 static bool __is_done(struct rxe_task *task)
 {
-	if (work_pending(&task->work))
+	if (task->tasklet.state & BIT(TASKLET_STATE_SCHED))
 		return false;
 
 	if (task->state == TASK_STATE_IDLE ||
@@ -90,23 +77,23 @@ static bool is_done(struct rxe_task *task)
  * schedules the task. They must call __reserve_if_idle to
  * move the task to busy before calling or scheduling.
  * The task can also be moved to drained or invalid
- * by calls to rxe_cleanup_task or rxe_disable_task.
+ * by calls to rxe-cleanup_task or rxe_disable_task.
  * In that case tasks which get here are not executed but
  * just flushed. The tasks are designed to look to see if
- * there is work to do and then do part of it before returning
+ * there is work to do and do part of it before returning
  * here with a return value of zero until all the work
- * has been consumed then it returns a non-zero value.
+ * has been consumed then it retuens a non-zero value.
  * The number of times the task can be run is limited by
  * max iterations so one task cannot hold the cpu forever.
- * If the limit is hit and work remains the task is rescheduled.
  */
-static void do_task(struct rxe_task *task)
+static void do_task(struct tasklet_struct *t)
 {
+	int cont;
+	int ret;
+	struct rxe_task *task = from_tasklet(task, t, tasklet);
 	unsigned int iterations;
 	unsigned long flags;
 	int resched = 0;
-	int cont;
-	int ret;
 
 	WARN_ON(rxe_read(task->qp) <= 0);
 
@@ -128,22 +115,25 @@ static void do_task(struct rxe_task *task)
 		} while (ret == 0 && iterations-- > 0);
 
 		spin_lock_irqsave(&task->lock, flags);
-		/* we're not done yet but we ran out of iterations.
-		 * yield the cpu and reschedule the task
-		 */
-		if (!ret) {
-			task->state = TASK_STATE_IDLE;
-			resched = 1;
-			goto exit;
-		}
-
 		switch (task->state) {
 		case TASK_STATE_BUSY:
-			task->state = TASK_STATE_IDLE;
+			if (ret) {
+				task->state = TASK_STATE_IDLE;
+			} else {
+				/* This can happen if the client
+				 * can add work faster than the
+				 * tasklet can finish it.
+				 * Reschedule the tasklet and exit
+				 * the loop to give up the cpu
+				 */
+				task->state = TASK_STATE_IDLE;
+				resched = 1;
+			}
 			break;
 
-		/* someone tried to schedule the task while we
-		 * were running, keep going
+		/* someone tried to run the task since the last time we called
+		 * func, so we will call one more time regardless of the
+		 * return value
 		 */
 		case TASK_STATE_ARMED:
 			task->state = TASK_STATE_BUSY;
@@ -151,24 +141,22 @@ static void do_task(struct rxe_task *task)
 			break;
 
 		case TASK_STATE_DRAINING:
-			task->state = TASK_STATE_DRAINED;
+			if (ret)
+				task->state = TASK_STATE_DRAINED;
+			else
+				cont = 1;
 			break;
 
 		default:
 			WARN_ON(1);
-			rxe_dbg_qp(task->qp, "unexpected task state = %d",
-				   task->state);
-			task->state = TASK_STATE_IDLE;
+			rxe_info_qp(task->qp, "unexpected task state = %d", task->state);
 		}
 
-exit:
 		if (!cont) {
 			task->num_done++;
 			if (WARN_ON(task->num_done != task->num_sched))
-				rxe_dbg_qp(
-					task->qp,
-					"%ld tasks scheduled, %ld tasks done",
-					task->num_sched, task->num_done);
+				rxe_err_qp(task->qp, "%ld tasks scheduled, %ld tasks done",
+					   task->num_sched, task->num_done);
 		}
 		spin_unlock_irqrestore(&task->lock, flags);
 	} while (cont);
@@ -181,12 +169,6 @@ static void do_task(struct rxe_task *task)
 	rxe_put(task->qp);
 }
 
-/* wrapper around do_task to fix argument for work queue */
-static void do_work(struct work_struct *work)
-{
-	do_task(container_of(work, struct rxe_task, work));
-}
-
 int rxe_init_task(struct rxe_task *task, struct rxe_qp *qp,
 		  int (*func)(struct rxe_qp *))
 {
@@ -194,9 +176,11 @@ int rxe_init_task(struct rxe_task *task, struct rxe_qp *qp,
 
 	task->qp = qp;
 	task->func = func;
+
+	tasklet_setup(&task->tasklet, do_task);
+
 	task->state = TASK_STATE_IDLE;
 	spin_lock_init(&task->lock);
-	INIT_WORK(&task->work, do_work);
 
 	return 0;
 }
@@ -229,6 +213,8 @@ void rxe_cleanup_task(struct rxe_task *task)
 	while (!is_done(task))
 		cond_resched();
 
+	tasklet_kill(&task->tasklet);
+
 	spin_lock_irqsave(&task->lock, flags);
 	task->state = TASK_STATE_INVALID;
 	spin_unlock_irqrestore(&task->lock, flags);
@@ -240,7 +226,7 @@ void rxe_cleanup_task(struct rxe_task *task)
 void rxe_run_task(struct rxe_task *task)
 {
 	unsigned long flags;
-	bool run;
+	int run;
 
 	WARN_ON(rxe_read(task->qp) <= 0);
 
@@ -249,11 +235,11 @@ void rxe_run_task(struct rxe_task *task)
 	spin_unlock_irqrestore(&task->lock, flags);
 
 	if (run)
-		do_task(task);
+		do_task(&task->tasklet);
 }
 
-/* schedule the task to run later as a work queue entry.
- * the queue_work call can be called holding
+/* schedule the task to run later as a tasklet.
+ * the tasklet)schedule call can be called holding
  * the lock.
  */
 void rxe_sched_task(struct rxe_task *task)
@@ -264,7 +250,7 @@ void rxe_sched_task(struct rxe_task *task)
 
 	spin_lock_irqsave(&task->lock, flags);
 	if (__reserve_if_idle(task))
-		queue_work(rxe_wq, &task->work);
+		tasklet_schedule(&task->tasklet);
 	spin_unlock_irqrestore(&task->lock, flags);
 }
 
@@ -291,9 +277,7 @@ void rxe_disable_task(struct rxe_task *task)
 	while (!is_done(task))
 		cond_resched();
 
-	spin_lock_irqsave(&task->lock, flags);
-	task->state = TASK_STATE_DRAINED;
-	spin_unlock_irqrestore(&task->lock, flags);
+	tasklet_disable(&task->tasklet);
 }
 
 void rxe_enable_task(struct rxe_task *task)
@@ -307,7 +291,7 @@ void rxe_enable_task(struct rxe_task *task)
 		spin_unlock_irqrestore(&task->lock, flags);
 		return;
 	}
-
 	task->state = TASK_STATE_IDLE;
+	tasklet_enable(&task->tasklet);
 	spin_unlock_irqrestore(&task->lock, flags);
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_task.h b/drivers/infiniband/sw/rxe/rxe_task.h
index a63e258b3d66..facb7c8e3729 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.h
+++ b/drivers/infiniband/sw/rxe/rxe_task.h
@@ -22,7 +22,7 @@ enum {
  * called again.
  */
 struct rxe_task {
-	struct work_struct	work;
+	struct tasklet_struct	tasklet;
 	int			state;
 	spinlock_t		lock;
 	struct rxe_qp		*qp;
@@ -32,10 +32,6 @@ struct rxe_task {
 	long			num_done;
 };
 
-int rxe_alloc_wq(void);
-
-void rxe_destroy_wq(void);
-
 /*
  * init rxe_task structure
  *	qp  => parameter to pass to func
-- 
2.40.1

