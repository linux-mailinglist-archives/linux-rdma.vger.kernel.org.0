Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6E96A8983
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Mar 2023 20:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjCBTfk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Mar 2023 14:35:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjCBTfj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Mar 2023 14:35:39 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAAE91B542
        for <linux-rdma@vger.kernel.org>; Thu,  2 Mar 2023 11:35:37 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id r40so106413oiw.0
        for <linux-rdma@vger.kernel.org>; Thu, 02 Mar 2023 11:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ul/X4z9n5RJX2bOF7lT5T2ehnAzqXOX0i1Ierr4eK1o=;
        b=g6M9TPmmWmDbJXbaAcmsbJh2lPWH9ZmBzIN0+JbK5LCTrB//tM0O9bjL/D4j9DyWla
         4jth/16NWdhKp4N3yyGDEGKqDNt5ltRQVV5pG36KZEWaVjLgrhXSbosyhetC2qvCCnsf
         Hfghj6xY9e0QJMYhm7PYIBDwxZMnE44i/ux7tM/98zND+WQ98ZNmgkjWLoTHpw+dNqk2
         NOIMrNl/CBecWW74kyLZcjaBdCzYz0hASiAr2BXPDSohVKwLFJ6adLZkCtipfICyT+0D
         e6WM4jJP6ZFryPLeOIOCZJLmov3GXsDmKPeaHg6t0aZaWN6KMSsJ76kX4AyP+ys9tZq4
         kTnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ul/X4z9n5RJX2bOF7lT5T2ehnAzqXOX0i1Ierr4eK1o=;
        b=jYU+6xt2CYtF4SkTPeuZ8y8HaI0/RhP05hHcZ2tNEiBN6KvfwXMdqACpj1YT6yVzHY
         BrCN8SM7I/BQE8qokys+IXph6sKXM8F7ZAJEEk3DbhzUQO60JGadfPdXEDMVRK4z7dRg
         SJpzq6cPmPc7gx36uNmr2IooYEKxVsmQ+HdyftL52lGYXrzUgFIdvLbFRAWyhv53PlaZ
         g7Drf75dHkgxE6AzAZRPLIK8xbPgMF6uKLJG/rJmw/QL6ktaJWnfOuH0WWDsjQaIIBzC
         YgwdggPm3FjVKDC2aHkT91qicpCmQtVaFtUnHZXF1bLnW1yWcCODGMCDr/SFDkCmEftF
         XL6Q==
X-Gm-Message-State: AO0yUKVqNvd6rs4H4/lopzFeIjMf3NQam1UIwaU28STXkih7UvlNOw9s
        oi1WkNYcmPfv5ddUbnx4POKg9Bd7NPg=
X-Google-Smtp-Source: AK7set8yowhGi+ogP3zOclO1r3yn3gK89ZoJgMKvugvrN7CTO5+mDrLWzsIoobSmZSKMSr97mfCBaw==
X-Received: by 2002:a54:470c:0:b0:36c:e637:6791 with SMTP id k12-20020a54470c000000b0036ce6376791mr5723957oik.32.1677785736682;
        Thu, 02 Mar 2023 11:35:36 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-b43a-f9f8-3a4c-b46e.res6.spectrum.com. [2603:8081:140c:1a00:b43a:f9f8:3a4c:b46e])
        by smtp.gmail.com with ESMTPSA id y205-20020aca32d6000000b00383eaf88e75sm17246oiy.39.2023.03.02.11.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 11:35:36 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        Ian Ziemba <ian.ziemba@hpe.com>
Subject: [PATCH for-next v6] RDMA/rxe: Add workqueue support for tasks
Date:   Thu,  2 Mar 2023 13:35:33 -0600
Message-Id: <20230302193533.6174-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Replace tasklets by work queues for the three main rxe tasklets:
rxe_requester, rxe_completer and rxe_responder.

This patch is all that is left from an earlier patch series that also
converted tasklets to workqueues with the same subject.

With this patch the rxe driver does not exhibit the soft lockups
reported by Daisuke Matsuda in the link below.

This patch depends on an earlier patch series titled "RDMA/rxe: Correct
qp reference counting" which corrects the same errors for the current
tasklet version.

Link: https://lore.kernel.org/linux-rdma/TYCPR01MB845522FD536170D75068DD41E5099@TYCPR01MB8455.jpnprd01.prod.outlook.com/
Signed-off-by: Ian Ziemba <ian.ziemba@hpe.com>
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
v6:
  Fixed left over references to tasklets in the comments.
  Added WQ_UNBOUND to the parameters for alloc_workqueue(). This shows
  a significant performance improvement.
v5:
  Based on corrected task logic for tasklets and simplified to only
  convert from tasklets to workqueues and not provide a flexible
  interface.

 drivers/infiniband/sw/rxe/rxe.c      |  9 ++-
 drivers/infiniband/sw/rxe/rxe_task.c | 84 ++++++++++++++++++----------
 drivers/infiniband/sw/rxe/rxe_task.h |  9 ++-
 3 files changed, 69 insertions(+), 33 deletions(-)

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
index fea9a517c8d9..b9815c27cad7 100644
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
 
-	if (task->tasklet.state & TASKLET_STATE_SCHED)
+	if (work_pending(&task->work))
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
-	if (task->tasklet.state & TASKLET_STATE_SCHED)
+	if (work_pending(&task->work))
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
index facb7c8e3729..4e937de9ebcf 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.h
+++ b/drivers/infiniband/sw/rxe/rxe_task.h
@@ -22,23 +22,28 @@ enum {
  * called again.
  */
 struct rxe_task {
-	struct tasklet_struct	tasklet;
+	struct work_struct	work;
 	int			state;
 	spinlock_t		lock;
 	struct rxe_qp		*qp;
+	const char		*name;
 	int			(*func)(struct rxe_qp *qp);
 	int			ret;
 	long			num_sched;
 	long			num_done;
 };
 
+int rxe_alloc_wq(void);
+
+void rxe_destroy_wq(void);
+
 /*
  * init rxe_task structure
  *	qp  => parameter to pass to func
  *	func => function to call until it returns != 0
  */
 int rxe_init_task(struct rxe_task *task, struct rxe_qp *qp,
-		  int (*func)(struct rxe_qp *));
+		  int (*func)(struct rxe_qp *), const char *name);
 
 /* cleanup task */
 void rxe_cleanup_task(struct rxe_task *task);

base-commit: 6a22f7fbde87336002886583d053bfa1cd8ff1d1
-- 
2.37.2

