Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9086F1D41
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Apr 2023 19:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbjD1RO4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Apr 2023 13:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346389AbjD1ROy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Apr 2023 13:14:54 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEDB211E
        for <linux-rdma@vger.kernel.org>; Fri, 28 Apr 2023 10:14:52 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-18807540d5aso174608fac.3
        for <linux-rdma@vger.kernel.org>; Fri, 28 Apr 2023 10:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682702092; x=1685294092;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t/VYdoLv1cc1VgEnfJcIKE7u/8RasI4doepP2F30V/k=;
        b=TyrVbtbi2AxZBEdoA77e1+T3C24Kf5jJ9CS3UWUMQwZy4Xnez/Ckedl5yEI5IzmwbX
         tzdT2HHRiZbYnSoJYhXJzC2MK4epbSyCmrPtgxobCoztpR4SgJFMTzxA3Cb/qHDdTX/b
         WaM3Rm9k/oN2hDgrOhUTPfsTwq14XSObgpjMEVocePoCxkTFOIOO76yf5CBQ/w07kQIi
         3eYzDSnD2TFu5fHEeQKUMu/d5f7FWMinOzBHrJTajiC+Ke9yOcKlPOxVqNH1F9LXB3ao
         33XqhSrJzjFdHp5QHWKrkbbw+cLjIIEoI4zbH0g5XolByY6edoG9eHmllH6pkh3BRQm8
         DXBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682702092; x=1685294092;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t/VYdoLv1cc1VgEnfJcIKE7u/8RasI4doepP2F30V/k=;
        b=SQnLF7gtd6Qr42bl9Yt9OC9V6VU/MWCJWHITlUOXGVJ1HdxFUoaItV2EAQQ2L1V4qR
         yUj5SMXLQ7ogoLz39MFP1AbdDsjXYCJxeKww4PXc8k0KFbxgQIILzUHxNyAy/WFd3xeW
         mZAXSJS5DdSqMpMkibRPy7hJJoxGWh0UJMGjgiNM2QZYcaJi6Iy9ku6iMmdaohw1ZDul
         PuTa38iztiSibnLg9Rx0bHWhNnV97BrynkML+TF4zEuzpYKI1/YoPeJs9iqNQhWND1XH
         8dcKT/jU2ywHfP+VvybvpUh6vkUQnJUQ4ft2EV1OiFVvc0Dfdbtv1YxOW5NWpVZU+LD8
         Rdmg==
X-Gm-Message-State: AC+VfDwu8S83xfAQdbWp6Ke/U2gUI1p1eQucqOazYIOcAyi29F4OD6Fo
        py9c6yUHJuL+waNO8AjJAIE=
X-Google-Smtp-Source: ACHHUZ6UvnQasX99wqVsvD5oMdIUC8c+02GHwPgB1eEi/HxCwWRqWm0P+twUQtWy8KI9zvDYIooffA==
X-Received: by 2002:a05:6870:5156:b0:18e:2b7e:a846 with SMTP id z22-20020a056870515600b0018e2b7ea846mr3457971oak.50.1682702092002;
        Fri, 28 Apr 2023 10:14:52 -0700 (PDT)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-575b-17ab-6f59-c2c3.res6.spectrum.com. [2603:8081:140c:1a00:575b:17ab:6f59:c2c3])
        by smtp.gmail.com with ESMTPSA id 63-20020a4a0642000000b0049fd5c02d25sm9683586ooj.12.2023.04.28.10.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 10:14:51 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     matsuda-daisuke@fujitsu.com, jgg@nvidia.com, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        Ian Ziemba <ian.ziemba@hpe.com>
Subject: [PATCH v8 for-next] RDMA/rxe: Add workqueue support for tasks
Date:   Fri, 28 Apr 2023 12:13:22 -0500
Message-Id: <20230428171321.5774-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Replace tasklets by work queues for the three main rxe tasklets:
rxe_requester, rxe_completer and rxe_responder.

Rebased to current for-next branch with changes, below, applied.

Link: https://lore.kernel.org/linux-rdma/20230329193308.7489-1-rpearsonhpe@gmail.com/
Signed-off-by: Ian Ziemba <ian.ziemba@hpe.com>
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
v8:
  Corrected a soft cpu lockup by testing return value from task->func
  for all task states.
  Removed WQ_CPU_INTENSIVE flag from alloc_workqueue() since documentation
  shows that this has no effect if WQ_UNBOUND is set.
  Removed work_pending() call in __reserve_if_idle() since by design
  a task cannot be pending and idle at the same time.
  Renamed __do_task() to do_work() per a comment by Diasuke Matsuda.
v7:
  Adjusted so patch applies after changes to rxe_task.c.
v6:
  Fixed left over references to tasklets in the comments.
  Added WQ_UNBOUND to the parameters for alloc_workqueue(). This shows
  a significant performance improvement.
v5:
  Based on corrected task logic for tasklets and simplified to only
  convert from tasklets to workqueues and not provide a flexible
  interface.
---
 drivers/infiniband/sw/rxe/rxe.c      |   9 ++-
 drivers/infiniband/sw/rxe/rxe_task.c | 108 +++++++++++++++------------
 drivers/infiniband/sw/rxe/rxe_task.h |   6 +-
 3 files changed, 75 insertions(+), 48 deletions(-)

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
index fb9a6bc8e620..e2c13d3d0e47 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.c
+++ b/drivers/infiniband/sw/rxe/rxe_task.c
@@ -6,8 +6,24 @@
 
 #include "rxe.h"
 
+static struct workqueue_struct *rxe_wq;
+
+int rxe_alloc_wq(void)
+{
+	rxe_wq = alloc_workqueue("rxe_wq", WQ_UNBOUND, WQ_MAX_ACTIVE);
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
@@ -21,9 +37,6 @@ static bool __reserve_if_idle(struct rxe_task *task)
 {
 	WARN_ON(rxe_read(task->qp) <= 0);
 
-	if (task->tasklet.state & BIT(TASKLET_STATE_SCHED))
-		return false;
-
 	if (task->state == TASK_STATE_IDLE) {
 		rxe_get(task->qp);
 		task->state = TASK_STATE_BUSY;
@@ -38,7 +51,7 @@ static bool __reserve_if_idle(struct rxe_task *task)
 }
 
 /* check if task is idle or drained and not currently
- * scheduled in the tasklet queue. This routine is
+ * scheduled in the work queue. This routine is
  * called by rxe_cleanup_task or rxe_disable_task to
  * see if the queue is empty.
  * Context: caller should hold task->lock.
@@ -46,7 +59,7 @@ static bool __reserve_if_idle(struct rxe_task *task)
  */
 static bool __is_done(struct rxe_task *task)
 {
-	if (task->tasklet.state & BIT(TASKLET_STATE_SCHED))
+	if (work_pending(&task->work))
 		return false;
 
 	if (task->state == TASK_STATE_IDLE ||
@@ -77,23 +90,23 @@ static bool is_done(struct rxe_task *task)
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
 
@@ -115,25 +128,22 @@ static void do_task(struct tasklet_struct *t)
 		} while (ret == 0 && iterations-- > 0);
 
 		spin_lock_irqsave(&task->lock, flags);
+		/* we're not done yet but we ran out of iterations.
+		 * yield the cpu and reschedule the task
+		 */
+		if (!ret) {
+			task->state = TASK_STATE_IDLE;
+			resched = 1;
+			goto exit;
+		}
+
 		switch (task->state) {
 		case TASK_STATE_BUSY:
-			if (ret) {
-				task->state = TASK_STATE_IDLE;
-			} else {
-				/* This can happen if the client
-				 * can add work faster than the
-				 * tasklet can finish it.
-				 * Reschedule the tasklet and exit
-				 * the loop to give up the cpu
-				 */
-				task->state = TASK_STATE_IDLE;
-				resched = 1;
-			}
+			task->state = TASK_STATE_IDLE;
 			break;
 
-		/* someone tried to run the task since the last time we called
-		 * func, so we will call one more time regardless of the
-		 * return value
+		/* someone tried to schedule the task while we
+		 * were running, keep going
 		 */
 		case TASK_STATE_ARMED:
 			task->state = TASK_STATE_BUSY;
@@ -141,21 +151,23 @@ static void do_task(struct tasklet_struct *t)
 			break;
 
 		case TASK_STATE_DRAINING:
-			if (ret)
-				task->state = TASK_STATE_DRAINED;
-			else
-				cont = 1;
+			task->state = TASK_STATE_DRAINED;
 			break;
 
 		default:
 			WARN_ON(1);
-			rxe_info_qp(task->qp, "unexpected task state = %d", task->state);
+			rxe_dbg_qp(task->qp, "unexpected task state = %d",
+				   task->state);
+			task->state = TASK_STATE_IDLE;
 		}
 
+exit:
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
@@ -169,6 +181,12 @@ static void do_task(struct tasklet_struct *t)
 	rxe_put(task->qp);
 }
 
+/* wrapper around do_task to fix argument for work queue */
+static void do_work(struct work_struct *work)
+{
+	do_task(container_of(work, struct rxe_task, work));
+}
+
 int rxe_init_task(struct rxe_task *task, struct rxe_qp *qp,
 		  int (*func)(struct rxe_qp *))
 {
@@ -176,11 +194,9 @@ int rxe_init_task(struct rxe_task *task, struct rxe_qp *qp,
 
 	task->qp = qp;
 	task->func = func;
-
-	tasklet_setup(&task->tasklet, do_task);
-
 	task->state = TASK_STATE_IDLE;
 	spin_lock_init(&task->lock);
+	INIT_WORK(&task->work, do_work);
 
 	return 0;
 }
@@ -213,8 +229,6 @@ void rxe_cleanup_task(struct rxe_task *task)
 	while (!is_done(task))
 		cond_resched();
 
-	tasklet_kill(&task->tasklet);
-
 	spin_lock_irqsave(&task->lock, flags);
 	task->state = TASK_STATE_INVALID;
 	spin_unlock_irqrestore(&task->lock, flags);
@@ -226,7 +240,7 @@ void rxe_cleanup_task(struct rxe_task *task)
 void rxe_run_task(struct rxe_task *task)
 {
 	unsigned long flags;
-	int run;
+	bool run;
 
 	WARN_ON(rxe_read(task->qp) <= 0);
 
@@ -235,11 +249,11 @@ void rxe_run_task(struct rxe_task *task)
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
@@ -250,7 +264,7 @@ void rxe_sched_task(struct rxe_task *task)
 
 	spin_lock_irqsave(&task->lock, flags);
 	if (__reserve_if_idle(task))
-		tasklet_schedule(&task->tasklet);
+		queue_work(rxe_wq, &task->work);
 	spin_unlock_irqrestore(&task->lock, flags);
 }
 
@@ -277,7 +291,9 @@ void rxe_disable_task(struct rxe_task *task)
 	while (!is_done(task))
 		cond_resched();
 
-	tasklet_disable(&task->tasklet);
+	spin_lock_irqsave(&task->lock, flags);
+	task->state = TASK_STATE_DRAINED;
+	spin_unlock_irqrestore(&task->lock, flags);
 }
 
 void rxe_enable_task(struct rxe_task *task)
@@ -291,7 +307,7 @@ void rxe_enable_task(struct rxe_task *task)
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

base-commit: 531094dc7164718d28ebb581d729807d7e846363
-- 
2.37.2

