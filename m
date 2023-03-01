Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4829F6A6725
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Mar 2023 05:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjCAEw4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Feb 2023 23:52:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjCAEwu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 Feb 2023 23:52:50 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A53630B19
        for <linux-rdma@vger.kernel.org>; Tue, 28 Feb 2023 20:52:49 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id bg11so9869771oib.5
        for <linux-rdma@vger.kernel.org>; Tue, 28 Feb 2023 20:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IDnnS1X2195xhN62BFYlB0BCPR/h96fihQQj+cQ9uvQ=;
        b=LSR1b42bBf7YPAowNzCIbOZomgpETe40cy7c9jFLnTw/6N6OyKMbySKpB7Hic0BCI+
         m1j5v2kBEUbsYZYigFWXUn6uMRj0pBq7ZyudPYIUnEy7JTrtnANJXM2ysGvHoboPfvmy
         a/Ji4ITvQP1eNaAXcXF+qq50CMRe7ZNXrgK0wGnxOCtM8X2GbQuTSr3TYmUOp0Ynk5gl
         DtV2g37vh7GoI3eAV5DQRaXQorHNBmfHsqCYxZ0CHg+32Jypzd/5JNsLPq91pFRxLlY8
         5qzP0YrU/QiZjDR6Z4FQhiBX6XmYSinkbUNKvHb2T8fJApvskmBGzRqUxExukW6Z0U3i
         y3QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IDnnS1X2195xhN62BFYlB0BCPR/h96fihQQj+cQ9uvQ=;
        b=pw0NNsMSHnkzjzT1GXMqXCiBS10ezk/t0r27nbG6QKfiuEbrZeYLimhsqV8GB5sF4W
         x8js0KzrrIu9ZiEqtL0Qv5dDFnrtWxp3NNpWNvpfcXmEZtynG8dg6Jdtzrgt8+y3CaFG
         lD/wcCvyLaptmH/0Ix7D/m1c2RdXj+9l5GBHkG5ALYyyQpwjjbLlKt7JdkU4tFHDsFFf
         OEDqVGE6RfyTwBZDCEuYgt+fFl7GYMVSYbbLc3C2VYWD6WbBwS1imU2CJ773LuYOGhci
         vXCxqosGOCD6vfJUZiXmtmqSukScalNKXmL8mOBcBzGwMs+RTbOM+3SEg5HpkXs+sUsc
         N9pg==
X-Gm-Message-State: AO0yUKVuLY0ZsjqNNYqARmnfGrLJbAUIGQwha990MXGnBvR9vdIKHljg
        fCzR1JnPtLGvhvGktmK4j+JeJFPT2FU=
X-Google-Smtp-Source: AK7set9ol+yt+uDT9oOIeQKXCFuLpXktW77WPRXrENOzOdeRueqQ289XgTnBLnFeCXKlKHUNe+fiqA==
X-Received: by 2002:a05:6808:7ce:b0:37d:b19d:320b with SMTP id f14-20020a05680807ce00b0037db19d320bmr2444078oij.51.1677646368159;
        Tue, 28 Feb 2023 20:52:48 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-759b-a469-60fc-ba97.res6.spectrum.com. [2603:8081:140c:1a00:759b:a469:60fc:ba97])
        by smtp.gmail.com with ESMTPSA id ex16-20020a056808299000b0037fcc1fd34bsm5309604oib.13.2023.02.28.20.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 20:52:47 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, jhack@hpe.com,
        matsuda-daisuke@fujitsu.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 8/8] RDMA/rxe: Rewrite rxe_task.c
Date:   Tue, 28 Feb 2023 22:51:55 -0600
Message-Id: <20230301045154.23733-9-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230301045154.23733-1-rpearsonhpe@gmail.com>
References: <20230301045154.23733-1-rpearsonhpe@gmail.com>
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

This patch is a major rewrite of the tasklet routines in rxe_task.c.
The main motivation for this is the realization that the code
violates the safety of the qp pointer by correct reference counting.
When a tasklet is scheduled from a verbs API the calling thread
has a valid reference to the qp and schedules the tasklet to run
at a later time carrying a pointer to the qp. Once the calling
code returns however the qp can be destroyed at any time. In order
to correct this a reference to the qp must be taken when the task
is scheduled and held until it finishes running. This is complicated
by the tasklet library not alwys running a task that is scheduled
depending on whether someone else has scheduled it.

This patch moves the logic for deciding whether to run or schedule
a task outside of do_task() and guarantees that there is only
one copy of the task scheduled or running at a time.

Secondly the separate flags controlling teardown and draining of
the task are included in the task state machine and all references
to the state are protected by spinlocks to avoid consistency and
memory barrier issues.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_task.c | 266 +++++++++++++++++++++------
 drivers/infiniband/sw/rxe/rxe_task.h |   8 +-
 2 files changed, 218 insertions(+), 56 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw/rxe/rxe_task.c
index a67f48545443..fea9a517c8d9 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.c
+++ b/drivers/infiniband/sw/rxe/rxe_task.c
@@ -6,56 +6,128 @@
 
 #include "rxe.h"
 
-/*
- * this locking is due to a potential race where
- * a second caller finds the task already running
- * but looks just after the last call to func
+/* Check if task is idle i.e. not running, not scheduled in
+ * tasklet queue and not draining. If so move to busy to
+ * reserve a slot in do_task() by setting to busy and taking
+ * a qp reference to cover the gap from now until the task finishes.
+ * state will move out of busy if task returns a non zero value
+ * in do_task(). If state is already busy it is raised to armed
+ * to indicate to do_task that additional pass should be made
+ * over the task.
+ * Context: caller should hold task->lock.
+ * Returns: true if state transitioned from idle to busy else false.
+ */
+static bool __reserve_if_idle(struct rxe_task *task)
+{
+	WARN_ON(rxe_read(task->qp) <= 0);
+
+	if (task->tasklet.state & TASKLET_STATE_SCHED)
+		return false;
+
+	if (task->state == TASK_STATE_IDLE) {
+		rxe_get(task->qp);
+		task->state = TASK_STATE_BUSY;
+		task->num_sched++;
+		return true;
+	}
+
+	if (task->state == TASK_STATE_BUSY)
+		task->state = TASK_STATE_ARMED;
+
+	return false;
+}
+
+/* check if task is idle or drained and not currently
+ * scheduled in the tasklet queue. This routine is
+ * called by rxe_cleanup_task or rxe_disable_task to
+ * see if the queue is empty.
+ * Context: caller should hold task->lock.
+ * Returns true if done else false.
+ */
+static bool __is_done(struct rxe_task *task)
+{
+	if (task->tasklet.state & TASKLET_STATE_SCHED)
+		return false;
+
+	if (task->state == TASK_STATE_IDLE ||
+	    task->state == TASK_STATE_DRAINED) {
+		return true;
+	}
+
+	return false;
+}
+
+/* a locked version of __is_done */
+static bool is_done(struct rxe_task *task)
+{
+	unsigned long flags;
+	int done;
+
+	spin_lock_irqsave(&task->lock, flags);
+	done = __is_done(task);
+	spin_unlock_irqrestore(&task->lock, flags);
+
+	return done;
+}
+
+/* do_task is a wrapper for the three tasks (requester,
+ * completer, responder) and calls them in a loop until
+ * they return a non-zero value. It is called either
+ * directly by rxe_run_task or indirectly if rxe_sched_task
+ * schedules the task. They must call __reserve_if_idle to
+ * move the task to busy before calling or scheduling.
+ * The task can also be moved to drained or invalid
+ * by calls to rxe-cleanup_task or rxe_disable_task.
+ * In that case tasks which get here are not executed but
+ * just flushed. The tasks are designed to look to see if
+ * there is work to do and do part of it before returning
+ * here with a return value of zero until all the work
+ * has been consumed then it retuens a non-zero value.
+ * The number of times the task can be run is limited by
+ * max iterations so one task cannot hold the cpu forever.
  */
 static void do_task(struct tasklet_struct *t)
 {
 	int cont;
 	int ret;
 	struct rxe_task *task = from_tasklet(task, t, tasklet);
-	struct rxe_qp *qp = (struct rxe_qp *)task->qp;
-	unsigned int iterations = RXE_MAX_ITERATIONS;
+	unsigned int iterations;
+	unsigned long flags;
+	int resched = 0;
 
-	spin_lock_bh(&task->lock);
-	switch (task->state) {
-	case TASK_STATE_START:
-		task->state = TASK_STATE_BUSY;
-		spin_unlock_bh(&task->lock);
-		break;
-
-	case TASK_STATE_BUSY:
-		task->state = TASK_STATE_ARMED;
-		fallthrough;
-	case TASK_STATE_ARMED:
-		spin_unlock_bh(&task->lock);
-		return;
+	WARN_ON(rxe_read(task->qp) <= 0);
 
-	default:
-		spin_unlock_bh(&task->lock);
-		rxe_dbg_qp(qp, "failed with bad state %d\n", task->state);
+	spin_lock_irqsave(&task->lock, flags);
+	if (task->state >= TASK_STATE_DRAINED) {
+		rxe_put(task->qp);
+		task->num_done++;
+		spin_unlock_irqrestore(&task->lock, flags);
 		return;
 	}
+	spin_unlock_irqrestore(&task->lock, flags);
 
 	do {
+		iterations = RXE_MAX_ITERATIONS;
 		cont = 0;
-		ret = task->func(task->qp);
 
-		spin_lock_bh(&task->lock);
+		do {
+			ret = task->func(task->qp);
+		} while (ret == 0 && iterations-- > 0);
+
+		spin_lock_irqsave(&task->lock, flags);
 		switch (task->state) {
 		case TASK_STATE_BUSY:
 			if (ret) {
-				task->state = TASK_STATE_START;
-			} else if (iterations--) {
-				cont = 1;
+				task->state = TASK_STATE_IDLE;
 			} else {
-				/* reschedule the tasklet and exit
+				/* This can happen if the client
+				 * can add work faster than the
+				 * tasklet can finish it.
+				 * Reschedule the tasklet and exit
 				 * the loop to give up the cpu
 				 */
-				tasklet_schedule(&task->tasklet);
-				task->state = TASK_STATE_START;
+				task->state = TASK_STATE_IDLE;
+				resched = 1;
 			}
 			break;
 
@@ -68,72 +140,158 @@ static void do_task(struct tasklet_struct *t)
 			cont = 1;
 			break;
 
+		case TASK_STATE_DRAINING:
+			if (ret)
+				task->state = TASK_STATE_DRAINED;
+			else
+				cont = 1;
+			break;
+
 		default:
-			rxe_dbg_qp(qp, "failed with bad state %d\n",
-					task->state);
+			WARN_ON(1);
+			rxe_info_qp(task->qp, "unexpected task state = %d", task->state);
+		}
+
+		if (!cont) {
+			task->num_done++;
+			if (WARN_ON(task->num_done != task->num_sched))
+				rxe_err_qp(task->qp, "%ld tasks scheduled, %ld tasks done",
+					   task->num_sched, task->num_done);
 		}
-		spin_unlock_bh(&task->lock);
+		spin_unlock_irqrestore(&task->lock, flags);
 	} while (cont);
 
 	task->ret = ret;
+
+	if (resched)
+		rxe_sched_task(task);
+
+	rxe_put(task->qp);
 }
 
 int rxe_init_task(struct rxe_task *task, struct rxe_qp *qp,
 		  int (*func)(struct rxe_qp *))
 {
-	task->qp	= qp;
-	task->func	= func;
-	task->destroyed	= false;
+	WARN_ON(rxe_read(qp) <= 0);
+
+	task->qp = qp;
+	task->func = func;
 
 	tasklet_setup(&task->tasklet, do_task);
 
-	task->state = TASK_STATE_START;
+	task->state = TASK_STATE_IDLE;
 	spin_lock_init(&task->lock);
 
 	return 0;
 }
 
+/* rxe_cleanup_task is only called from rxe_do_qp_cleanup in
+ * process context. The qp is already completed with no
+ * remaining references. Once the queue is drained the
+ * task is moved to invalid and returns. The qp cleanup
+ * code then calls the task functions directly without
+ * using the task struct to drain any late arriving packets
+ * or work requests.
+ */
 void rxe_cleanup_task(struct rxe_task *task)
 {
-	bool idle;
+	unsigned long flags;
 
-	/*
-	 * Mark the task, then wait for it to finish. It might be
-	 * running in a non-tasklet (direct call) context.
-	 */
-	task->destroyed = true;
+	spin_lock_irqsave(&task->lock, flags);
+	if (!__is_done(task) && task->state < TASK_STATE_DRAINED) {
+		task->state = TASK_STATE_DRAINING;
+	} else {
+		task->state = TASK_STATE_INVALID;
+		spin_unlock_irqrestore(&task->lock, flags);
+		return;
+	}
+	spin_unlock_irqrestore(&task->lock, flags);
 
-	do {
-		spin_lock_bh(&task->lock);
-		idle = (task->state == TASK_STATE_START);
-		spin_unlock_bh(&task->lock);
-	} while (!idle);
+	/* now the task cannot be scheduled or run just wait
+	 * for the previously scheduled tasks to finish.
+	 */
+	while (!is_done(task))
+		cond_resched();
 
 	tasklet_kill(&task->tasklet);
+
+	spin_lock_irqsave(&task->lock, flags);
+	task->state = TASK_STATE_INVALID;
+	spin_unlock_irqrestore(&task->lock, flags);
 }
 
+/* run the task inline if it is currently idle
+ * cannot call do_task holding the lock
+ */
 void rxe_run_task(struct rxe_task *task)
 {
-	if (task->destroyed)
-		return;
+	unsigned long flags;
+	int run;
+
+	WARN_ON(rxe_read(task->qp) <= 0);
 
-	do_task(&task->tasklet);
+	spin_lock_irqsave(&task->lock, flags);
+	run = __reserve_if_idle(task);
+	spin_unlock_irqrestore(&task->lock, flags);
+
+	if (run)
+		do_task(&task->tasklet);
 }
 
+/* schedule the task to run later as a tasklet.
+ * the tasklet)schedule call can be called holding
+ * the lock.
+ */
 void rxe_sched_task(struct rxe_task *task)
 {
-	if (task->destroyed)
-		return;
+	unsigned long flags;
+
+	WARN_ON(rxe_read(task->qp) <= 0);
 
-	tasklet_schedule(&task->tasklet);
+	spin_lock_irqsave(&task->lock, flags);
+	if (__reserve_if_idle(task))
+		tasklet_schedule(&task->tasklet);
+	spin_unlock_irqrestore(&task->lock, flags);
 }
 
+/* rxe_disable/enable_task are only called from
+ * rxe_modify_qp in process context. Task is moved
+ * to the drained state by do_task.
+ */
 void rxe_disable_task(struct rxe_task *task)
 {
+	unsigned long flags;
+
+	WARN_ON(rxe_read(task->qp) <= 0);
+
+	spin_lock_irqsave(&task->lock, flags);
+	if (!__is_done(task) && task->state < TASK_STATE_DRAINED) {
+		task->state = TASK_STATE_DRAINING;
+	} else {
+		task->state = TASK_STATE_DRAINED;
+		spin_unlock_irqrestore(&task->lock, flags);
+		return;
+	}
+	spin_unlock_irqrestore(&task->lock, flags);
+
+	while (!is_done(task))
+		cond_resched();
+
 	tasklet_disable(&task->tasklet);
 }
 
 void rxe_enable_task(struct rxe_task *task)
 {
+	unsigned long flags;
+
+	WARN_ON(rxe_read(task->qp) <= 0);
+
+	spin_lock_irqsave(&task->lock, flags);
+	if (task->state == TASK_STATE_INVALID) {
+		spin_unlock_irqrestore(&task->lock, flags);
+		return;
+	}
+	task->state = TASK_STATE_IDLE;
 	tasklet_enable(&task->tasklet);
+	spin_unlock_irqrestore(&task->lock, flags);
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_task.h b/drivers/infiniband/sw/rxe/rxe_task.h
index 99585e40cef9..facb7c8e3729 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.h
+++ b/drivers/infiniband/sw/rxe/rxe_task.h
@@ -8,9 +8,12 @@
 #define RXE_TASK_H
 
 enum {
-	TASK_STATE_START	= 0,
+	TASK_STATE_IDLE		= 0,
 	TASK_STATE_BUSY		= 1,
 	TASK_STATE_ARMED	= 2,
+	TASK_STATE_DRAINING	= 3,
+	TASK_STATE_DRAINED	= 4,
+	TASK_STATE_INVALID	= 5,
 };
 
 /*
@@ -25,7 +28,8 @@ struct rxe_task {
 	struct rxe_qp		*qp;
 	int			(*func)(struct rxe_qp *qp);
 	int			ret;
-	bool			destroyed;
+	long			num_sched;
+	long			num_done;
 };
 
 /*
-- 
2.37.2

