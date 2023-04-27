Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E5A6F08C7
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Apr 2023 17:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244064AbjD0Pxs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Apr 2023 11:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243711AbjD0Pxr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Apr 2023 11:53:47 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5B7131
        for <linux-rdma@vger.kernel.org>; Thu, 27 Apr 2023 08:53:45 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-38de3338abeso4754644b6e.1
        for <linux-rdma@vger.kernel.org>; Thu, 27 Apr 2023 08:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682610825; x=1685202825;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lHAydtl4AVlSYNJzseDW/xWIXCYitM+lhrv4qUTNh8s=;
        b=IoW0wzXkCwFYnnKv9+PToBIYJSrVDqoXFWQjxR+8vI7rjGUtKtz7+wemEmJwM06uBP
         i3SEFPiifyGbeOYiynJ9bAQPWKcLJpfOpXqC+6DJqWKsuqKSATRTUUn7RRuuyJArtB0/
         f+gVWWCSUrOmZzKGDv+1YlNU5u3Ah+ycK2NQse6MpqzBU/9C20weKBQy/+6kFzUclsgq
         ehXRRtrHqeKWj043UDr7FLmOQQL/xBCuVpbZvG4+JIpXApjdErvH4D0AtqSB/IgapSL8
         1EYynBTdIllrzsicFdJmM5QRp77ZIQp5bgYA5uguLkRQrHzXNLr0JYuFAE8Jl0Ra8Zmi
         VHWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682610825; x=1685202825;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lHAydtl4AVlSYNJzseDW/xWIXCYitM+lhrv4qUTNh8s=;
        b=bdDMU8UQ10z5TcS2jrbUbmRyyn8J0wgXJp0AcCK68xnzfLV/v/yByORTljxmHS1Nif
         inRp5OMmM/Ogc4t5PwztF3KWwfUKRs4MsHqAlkbBUcNG9/gk8N3FKu/53CqXGk74jYFo
         uoUujAobCJ094hCite+cA1hfdalreeM55R7Iwwt5011ob3pEpZb55Mn7dGunfe9/e/yb
         5Dl+2OV1EL1QyWFt9wV9ObnUzbL6mdqkRD1Xkugvwhmwei9L5w+NXvbKgdjhTacIfCNE
         /8uW8frsuvEFVGin7MA4Ro7lPqSVYhuWIM0gBbKoxe0AaWPAJVfBbtH/d4KkQrUD5hr8
         PVnQ==
X-Gm-Message-State: AC+VfDxL0r2kTOpggD0ds+L/eQY+pfc/dUI3i4bBaTsaGP+5wAd6XTwU
        TAEoguY3xyCUODoLJnZ2avY=
X-Google-Smtp-Source: ACHHUZ4rpWeSjlM/Roz31Z5XWzWYM9QwxSnJlCMkX8Xh3ZAc41A2++WdZT/U1m3l3xZ/bx73suy5Bw==
X-Received: by 2002:a05:6808:3946:b0:38e:acd7:d9e0 with SMTP id en6-20020a056808394600b0038eacd7d9e0mr866451oib.20.1682610824980;
        Thu, 27 Apr 2023 08:53:44 -0700 (PDT)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-d311-e3b9-f687-8c9f.res6.spectrum.com. [2603:8081:140c:1a00:d311:e3b9:f687:8c9f])
        by smtp.gmail.com with ESMTPSA id o66-20020acaf045000000b00386b8b1448dsm7923136oih.34.2023.04.27.08.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 08:53:44 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     matsuda-daisuke@fujitsu.com, jgg@nvidia.com, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        Ian Ziemba <ian.ziemba@hpe.com>
Subject: [PATCH for next v7] RDMA/rxe: Add workqueue support for tasks
Date:   Thu, 27 Apr 2023 10:53:23 -0500
Message-Id: <20230427155322.11414-1-rpearsonhpe@gmail.com>
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
 
-	if (task->tasklet.state & BIT(TASKLET_STATE_SCHED))
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
-	if (task->tasklet.state & BIT(TASKLET_STATE_SCHED))
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

base-commit: 209558abea74e37402fcc3d1217c6c1043d91335
-- 
2.37.2

