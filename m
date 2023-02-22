Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6104D69FFA2
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Feb 2023 00:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbjBVXfr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Feb 2023 18:35:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232500AbjBVXfq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Feb 2023 18:35:46 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC1E53E0A4
        for <linux-rdma@vger.kernel.org>; Wed, 22 Feb 2023 15:35:41 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id g6-20020a056830308600b0068d4b30536aso1841296ots.9
        for <linux-rdma@vger.kernel.org>; Wed, 22 Feb 2023 15:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4yeJNu8NVnsDXJlSzNvR7x7Dur6l3PHt9yRs8nfiLPA=;
        b=CMXjUfVHGXLD46J7QCrwKe1Ruk7D5eCKPrd/+iEoXQ+Q94GHRuYD8tmWdNWLZFU/YT
         C5ouvATFRcVHBo7GPzGQLR2IGsMul880ueDmBE/on37wAlG6puUulrtQq1R//P+panrO
         jlpxT2fWeCjBfr7+aPfEmSneH78w7p+AmNMAOL8ue3c5LNGlRcLPbZEkleOs0sXzaAlS
         Aigdw3diGeAdxU41+bJ4khw/iHWDBxCHHcV8IL2d/8Lo44D2k1oc/9d1aZHtqXX2+vL0
         J6ioYuuNWKs1aNT8fq9wlFbMtXiPZYzmlKG/sQCPVGmZR9n0avPlUQourZrPH9Hio2qo
         hLkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4yeJNu8NVnsDXJlSzNvR7x7Dur6l3PHt9yRs8nfiLPA=;
        b=QOpRuRDA+IEy1aJ1rqosdGHFvaob7aPEcAokHzElAinbJIfiNIKWxyV565QVNgZLR7
         NPA7i2/AIfdbZQ0fstq4BJwLgKcoR0bBwiX/OyfesoOX5R6bAk2RbXXJV/JpoxcmadCU
         ceaErF7TtfuI/4zOXqjwYng+2YE8mCh+6j2vxQ6sOENLpD2C73sNku5Dd0wniJYG1NNr
         I6KLNmyKCmUXKn0Lu8MxxyaAx1NWPysj1zvV0kyVeKZdg4TVOrkk8HIurbEMQUMOgn/C
         KLybhzQWa+H3D79R4OpXawLt7ymOvJe7A9M+nWQ/hLGxs9vjYRwrjgha/j4Zv+fWvw++
         NXFg==
X-Gm-Message-State: AO0yUKVHvJvLQ55sR6ozkbCplSPwBxmcAITLM1unTDMxWk6oEjrJwa3b
        m8DZeff2MVc90Bgb4a3fm7Q=
X-Google-Smtp-Source: AK7set+kyAWC+Byfd10TAbvnxqvRMWCzqiJlADCfrWcBrGPMamy4W4r3grH4l9rh4vj58B5Hdd6Zhw==
X-Received: by 2002:a05:6830:1f37:b0:68b:d62a:a64a with SMTP id e23-20020a0568301f3700b0068bd62aa64amr5027420oth.29.1677108941216;
        Wed, 22 Feb 2023 15:35:41 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-e92c-8850-3fad-351f.res6.spectrum.com. [2603:8081:140c:1a00:e92c:8850:3fad:351f])
        by smtp.gmail.com with ESMTPSA id l19-20020a9d7093000000b0068663820588sm2723281otj.44.2023.02.22.15.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 15:35:40 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, matsuda-daisuke@fujitsu.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 9/9] RDMA/rxe: Rewrite rxe_task.c
Date:   Wed, 22 Feb 2023 17:32:38 -0600
Message-Id: <20230222233237.48940-10-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230222233237.48940-1-rpearsonhpe@gmail.com>
References: <20230222233237.48940-1-rpearsonhpe@gmail.com>
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
 drivers/infiniband/sw/rxe/rxe_task.c | 270 +++++++++++++++++++++------
 drivers/infiniband/sw/rxe/rxe_task.h |   8 +-
 2 files changed, 222 insertions(+), 56 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw/rxe/rxe_task.c
index 959cc6229a34..e4636cbba01d 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.c
+++ b/drivers/infiniband/sw/rxe/rxe_task.c
@@ -6,6 +6,10 @@
 
 #include "rxe.h"
 
+/* called by rxe_qp_reset or rxe_qp_do_cleanup
+ * while normal task execution is disabled to flush
+ * packet and work queues
+ */
 int __rxe_do_task(struct rxe_task *task)
 
 {
@@ -19,56 +23,128 @@ int __rxe_do_task(struct rxe_task *task)
 	return ret;
 }
 
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
-
-	spin_lock_bh(&task->lock);
-	switch (task->state) {
-	case TASK_STATE_START:
-		task->state = TASK_STATE_BUSY;
-		spin_unlock_bh(&task->lock);
-		break;
+	unsigned int iterations;
+	unsigned long flags;
+	int resched = 0;
 
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
 
@@ -81,72 +157,158 @@ static void do_task(struct tasklet_struct *t)
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
 
-	do_task(&task->tasklet);
+	WARN_ON(rxe_read(task->qp) <= 0);
+
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
 
-	tasklet_schedule(&task->tasklet);
+	WARN_ON(rxe_read(task->qp) <= 0);
+
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
index 41efd5fd49b0..a646c90d193e 100644
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

