Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0014F6A673B
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Mar 2023 06:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjCAFGW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 1 Mar 2023 00:06:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjCAFGW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 1 Mar 2023 00:06:22 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0746A32CCA
        for <linux-rdma@vger.kernel.org>; Tue, 28 Feb 2023 21:06:18 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-17264e9b575so13252531fac.9
        for <linux-rdma@vger.kernel.org>; Tue, 28 Feb 2023 21:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cI3D6aUdyFtLeP4UW8K1gV22SP4MeRGwpw+AzSPd42k=;
        b=VkCU/ooKt3wk4Oi5mpm8SBnfaGHmkzvCNSDH0EjIRCwtY/XX3A2zCPCdNKaZCzxpmg
         iZ8ZZNXOqHzO5SEltJelNr6cuuT9pKy5XTWrlQjT8d6rk/7e/5IaYili0mzv3iflre+r
         mYogtrFJwib0WZ/t1/7aG1xYz+0y5Hhavg91PHv16tlpOz937uhRTsaln1Gn4672XC7M
         0eHQvttS8Tho/DHpF07+u25Ibk6gP9C9kPuHpfx3uU8d4w8L9xf+KynTnZnOxOBSUS5N
         om9vBSDs7Uxi5GfICcM+2msoxMrIuOosAz2ECb8GAoxQ2mTQwy3MTU7fuX0GiDXvMdS7
         VuUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cI3D6aUdyFtLeP4UW8K1gV22SP4MeRGwpw+AzSPd42k=;
        b=kHeZjcIb7Us3do9vg7qmxseR0rHIr6rA08uErEot5e9rB2wih8Z3ymBzNdmBh9O+3f
         q2e33+uleEZIi7HzMNkVBFV0eBrM8ASXM61YQE8yrWdSC/gRRBW/N6a1qgBz87rqZEws
         I0rK7XisSQZrLxMBGmLgyLMeJQsY0JBYDM9tnDo+eqvaNnsbk/cORiKN4BN/V7wqvZ8N
         AYw1wNRpb8TtqEtVD0pfpna+Qj9U2wvEtdTBhUihQ/gqTROE3qPlmGUCttzzhY5aTQRr
         GOEnLd3ooOT8Yaqm9atM0zuCbk/4m0NRMWoeOplu6ZB8ozsyVKskjh7DHhu7mAxUuZ47
         KKMQ==
X-Gm-Message-State: AO0yUKUPE9jVOeFAtf+myu1+NHXUswpvWS3bbgA9w/6GQyCLXI6Src1r
        aLZ09XYiVURX+t5Xtr/hfFw=
X-Google-Smtp-Source: AK7set/kn9X+n3lyLhSQdPsbPCTD7q8jB7MezoNHwelL/KMwuD+P/6f9z5tDC86GOADJojt+428Q6g==
X-Received: by 2002:a05:6870:648f:b0:16e:9dd:f059 with SMTP id cz15-20020a056870648f00b0016e09ddf059mr3214229oab.14.1677647177114;
        Tue, 28 Feb 2023 21:06:17 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-759b-a469-60fc-ba97.res6.spectrum.com. [2603:8081:140c:1a00:759b:a469:60fc:ba97])
        by smtp.gmail.com with ESMTPSA id e18-20020a0568301f3200b00684a10970adsm4518080oth.16.2023.02.28.21.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 21:06:16 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, jhack@hpe.com,
        matsuda-daisuke@fujitsu.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        Ian Ziemba <ian.ziemba@hpe.com>
Subject: [PATCH for-next v5] RDMA/rxe: Add workqueue support for tasks
Date:   Tue, 28 Feb 2023 23:04:56 -0600
Message-Id: <20230301050455.24707-1-rpearsonhpe@gmail.com>
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

This patch is all that is left from an eariler patch series that also
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
v5:
  Based on corrected task logic for tasklets and simplified to only
  convert from tasklets to workqueues and not provide a flexible
  interface.

 drivers/infiniband/sw/rxe/rxe.c      |  9 ++++-
 drivers/infiniband/sw/rxe/rxe_task.c | 49 +++++++++++++++++++---------
 drivers/infiniband/sw/rxe/rxe_task.h |  6 +++-
 3 files changed, 47 insertions(+), 17 deletions(-)

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
index fea9a517c8d9..939d158a7a12 100644
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
 /* Check if task is idle i.e. not running, not scheduled in
  * tasklet queue and not draining. If so move to busy to
  * reserve a slot in do_task() by setting to busy and taking
@@ -21,7 +37,7 @@ static bool __reserve_if_idle(struct rxe_task *task)
 {
 	WARN_ON(rxe_read(task->qp) <= 0);
 
-	if (task->tasklet.state & TASKLET_STATE_SCHED)
+	if (work_pending(&task->work))
 		return false;
 
 	if (task->state == TASK_STATE_IDLE) {
@@ -46,7 +62,7 @@ static bool __reserve_if_idle(struct rxe_task *task)
  */
 static bool __is_done(struct rxe_task *task)
 {
-	if (task->tasklet.state & TASKLET_STATE_SCHED)
+	if (work_pending(&task->work))
 		return false;
 
 	if (task->state == TASK_STATE_IDLE ||
@@ -86,14 +102,13 @@ static bool is_done(struct rxe_task *task)
  * The number of times the task can be run is limited by
  * max iterations so one task cannot hold the cpu forever.
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
 
@@ -169,6 +184,12 @@ static void do_task(struct tasklet_struct *t)
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
@@ -176,11 +197,9 @@ int rxe_init_task(struct rxe_task *task, struct rxe_qp *qp,
 
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
@@ -213,8 +232,6 @@ void rxe_cleanup_task(struct rxe_task *task)
 	while (!is_done(task))
 		cond_resched();
 
-	tasklet_kill(&task->tasklet);
-
 	spin_lock_irqsave(&task->lock, flags);
 	task->state = TASK_STATE_INVALID;
 	spin_unlock_irqrestore(&task->lock, flags);
@@ -235,7 +252,7 @@ void rxe_run_task(struct rxe_task *task)
 	spin_unlock_irqrestore(&task->lock, flags);
 
 	if (run)
-		do_task(&task->tasklet);
+		do_task(task);
 }
 
 /* schedule the task to run later as a tasklet.
@@ -250,7 +267,7 @@ void rxe_sched_task(struct rxe_task *task)
 
 	spin_lock_irqsave(&task->lock, flags);
 	if (__reserve_if_idle(task))
-		tasklet_schedule(&task->tasklet);
+		queue_work(rxe_wq, &task->work);
 	spin_unlock_irqrestore(&task->lock, flags);
 }
 
@@ -277,7 +294,9 @@ void rxe_disable_task(struct rxe_task *task)
 	while (!is_done(task))
 		cond_resched();
 
-	tasklet_disable(&task->tasklet);
+	spin_lock_irqsave(&task->lock, flags);
+	task->state = TASK_STATE_DRAINED;
+	spin_unlock_irqrestore(&task->lock, flags);
 }
 
 void rxe_enable_task(struct rxe_task *task)
@@ -291,7 +310,7 @@ void rxe_enable_task(struct rxe_task *task)
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
2.37.2

