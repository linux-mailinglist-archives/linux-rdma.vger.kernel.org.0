Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83082607F7B
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Oct 2022 22:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbiJUUDC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Oct 2022 16:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbiJUUCk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Oct 2022 16:02:40 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E378325ED10
        for <linux-rdma@vger.kernel.org>; Fri, 21 Oct 2022 13:02:39 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-13af2d12469so4859026fac.13
        for <linux-rdma@vger.kernel.org>; Fri, 21 Oct 2022 13:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p3kPzmPDjjNhDNGku1w9RH09kAppbd1qvrZUMK/RXkU=;
        b=jKgSmILPz4yCvkYYjr7Ai3tnR5DNcvUIQ+C/+WvekqSI6vSR5o/D6AIlZQ6sBS90dd
         j512nCKxEqpMaFRgdT6POdw6dFUEz6AWGuuT2sMdEi1Askuit3bdJrR1s/zwCU6irFNt
         hWXSuvVxoqdOyGqM/amu4AtvpZdrep2/5hoN/J9ij36i0PcqGcRLGUsPyiX8vl1E07Gs
         pSZ3ZWYLVxN3whXgp0WaWlAlEfeckpMvPag4UU45CKbbyMuyG4ALQ8uAbMfreVJYGm6N
         FOIn+IJt7LLpcMiBDb0zD4fhtu0lme971uQL5+w5dOLpTtB3d8dWnwF53d9Nf5bG5OFL
         lxAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p3kPzmPDjjNhDNGku1w9RH09kAppbd1qvrZUMK/RXkU=;
        b=dX7SsSOaCbdSYZqXlfWGe1jN3FyZGJph/XSJh7ckH4mfJG9E19vXYjZncSUJ5upfNj
         ykBdurr2wg1aDLMVqeTNkG8I8znNlebQv/XiWUhLGryyCNz/MaBKjBzuiD80x5TDiFwn
         CqZXJcUAfqPgouheaTRfnzdHOBDqOHkFjflnycOL9cNGwVsHIjDHp9cQGp2T7olOTxpC
         HTdDmCuVHe/FEV164cAss3Fmi0hi2F2O66pAn9/Y4xKa4Zd/Dkn9vJqW1wRYOaDjb+8X
         BMXemLhyqXZzsshR12jm0laK4avl8f3F4nn07PZ2wPNWsmYFpZq2hS/Dp58WEJh2Ys2X
         F2tg==
X-Gm-Message-State: ACrzQf0Q8QbemuYkgrWtcOllE5N/g3yiM2TWY7MAG290VVNTl4682jQ3
        y+4ACaOwxLoU7PhlDejLCJ3G4guS/HY=
X-Google-Smtp-Source: AMsMyM5VaQ3iBsF7dm3mVuoqS2WC/h4qZlRWOEu+3JpXqZlYTcT0RJ31pfSoCCVHEQILJ1qVcjYhSg==
X-Received: by 2002:a05:6870:538d:b0:136:3cc4:78fa with SMTP id h13-20020a056870538d00b001363cc478famr30749320oan.278.1666382538746;
        Fri, 21 Oct 2022 13:02:18 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-a860-f1d2-9e17-7593.res6.spectrum.com. [2603:8081:140c:1a00:a860:f1d2:9e17:7593])
        by smtp.googlemail.com with ESMTPSA id s23-20020a056870631700b00132f141ef2dsm10674684oao.56.2022.10.21.13.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 13:02:18 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, leon@kernel.org,
        jhack@hpe.com, ian.ziemba@hpe.com, matsuda-daisuke@fujitsu.com,
        lizhijian@fujitsu.com, haris.phnx@gmail.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 14/18] RDMA/rxe: Implement disable/enable_task()
Date:   Fri, 21 Oct 2022 15:01:15 -0500
Message-Id: <20221021200118.2163-15-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221021200118.2163-1-rpearsonhpe@gmail.com>
References: <20221021200118.2163-1-rpearsonhpe@gmail.com>
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

Implement common disable_task() and enable_task() routines by
adding a new PAUSED state to the do_task() state machine.
These replace tasklet_disable and tasklet_enable with code that
can be shared with all the task types. Move rxe_sched_task to
re-schedule the task outside of the locks to avoid a deadlock.

Signed-off-by: Ian Ziemba <ian.ziemba@hpe.com>
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_task.c | 107 ++++++++++++++++-----------
 drivers/infiniband/sw/rxe/rxe_task.h |   1 +
 2 files changed, 66 insertions(+), 42 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw/rxe/rxe_task.c
index 120693c9a795..d824de82f2ae 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.c
+++ b/drivers/infiniband/sw/rxe/rxe_task.c
@@ -6,36 +6,46 @@
 
 #include "rxe.h"
 
-/*
- * this locking is due to a potential race where
- * a second caller finds the task already running
- * but looks just after the last call to func
- */
-static void do_task(struct rxe_task *task)
+static bool task_is_idle(struct rxe_task *task)
 {
-	unsigned int iterations = RXE_MAX_ITERATIONS;
-	int cont;
-	int ret;
+	if (task->destroyed)
+		return false;
 
 	spin_lock_bh(&task->lock);
 	switch (task->state) {
 	case TASK_STATE_START:
 		task->state = TASK_STATE_BUSY;
 		spin_unlock_bh(&task->lock);
-		break;
-
+		return true;
 	case TASK_STATE_BUSY:
 		task->state = TASK_STATE_ARMED;
 		fallthrough;
 	case TASK_STATE_ARMED:
-		spin_unlock_bh(&task->lock);
-		return;
-
+	case TASK_STATE_PAUSED:
+		break;
 	default:
+		WARN_ON(1);
+		break;
+	}
+	spin_unlock_bh(&task->lock);
+
+	return false;
+}
+
+static void do_task(struct rxe_task *task)
+{
+	unsigned int iterations = RXE_MAX_ITERATIONS;
+	bool resched = false;
+	int cont;
+	int ret;
+
+	/* flush out pending tasks */
+	spin_lock_bh(&task->lock);
+	if (task->state == TASK_STATE_PAUSED) {
 		spin_unlock_bh(&task->lock);
-		pr_warn("%s failed with bad state %d\n", __func__, task->state);
 		return;
 	}
+	spin_unlock_bh(&task->lock);
 
 	do {
 		cont = 0;
@@ -43,47 +53,52 @@ static void do_task(struct rxe_task *task)
 
 		spin_lock_bh(&task->lock);
 		switch (task->state) {
+		case TASK_STATE_START:
 		case TASK_STATE_BUSY:
 			if (ret) {
 				task->state = TASK_STATE_START;
-			} else if (iterations--) {
+			} else if (task->type == RXE_TASK_TYPE_INLINE ||
+					iterations--) {
 				cont = 1;
 			} else {
-				/* reschedule the tasklet and exit
-				 * the loop to give up the cpu
-				 */
-				tasklet_schedule(&task->tasklet);
 				task->state = TASK_STATE_START;
+				resched = true;
 			}
 			break;
-
-		/* someone tried to run the task since the last time we called
-		 * func, so we will call one more time regardless of the
-		 * return value
-		 */
 		case TASK_STATE_ARMED:
 			task->state = TASK_STATE_BUSY;
 			cont = 1;
 			break;
-
+		case TASK_STATE_PAUSED:
+			break;
 		default:
-			pr_warn("%s failed with bad state %d\n", __func__,
-				task->state);
+			WARN_ON(1);
+			break;
 		}
 		spin_unlock_bh(&task->lock);
 	} while (cont);
 
+	if (resched)
+		rxe_sched_task(task);
+
 	task->ret = ret;
 }
 
 static void disable_task(struct rxe_task *task)
 {
-	/* todo */
+	spin_lock_bh(&task->lock);
+	task->state = TASK_STATE_PAUSED;
+	spin_unlock_bh(&task->lock);
 }
 
 static void enable_task(struct rxe_task *task)
 {
-	/* todo */
+	spin_lock_bh(&task->lock);
+	task->state = TASK_STATE_START;
+	spin_unlock_bh(&task->lock);
+
+	/* restart task in case */
+	rxe_run_task(task);
 }
 
 /* busy wait until any previous tasks are done */
@@ -95,7 +110,8 @@ static void cleanup_task(struct rxe_task *task)
 
 	do {
 		spin_lock_bh(&task->lock);
-		idle = (task->state == TASK_STATE_START);
+		idle = (task->state == TASK_STATE_START ||
+			task->state == TASK_STATE_PAUSED);
 		spin_unlock_bh(&task->lock);
 	} while (!idle);
 }
@@ -103,22 +119,26 @@ static void cleanup_task(struct rxe_task *task)
 /* silently treat schedule as inline for inline tasks */
 static void inline_sched(struct rxe_task *task)
 {
-	do_task(task);
+	if (task_is_idle(task))
+		do_task(task);
 }
 
 static void inline_run(struct rxe_task *task)
 {
-	do_task(task);
+	if (task_is_idle(task))
+		do_task(task);
 }
 
 static void inline_disable(struct rxe_task *task)
 {
-	disable_task(task);
+	if (!task->destroyed)
+		disable_task(task);
 }
 
 static void inline_enable(struct rxe_task *task)
 {
-	enable_task(task);
+	if (!task->destroyed)
+		enable_task(task);
 }
 
 static void inline_cleanup(struct rxe_task *task)
@@ -142,31 +162,34 @@ static void inline_init(struct rxe_task *task)
 /* use tsklet_xxx to avoid name collisions with tasklet_xxx */
 static void tsklet_sched(struct rxe_task *task)
 {
-	tasklet_schedule(&task->tasklet);
+	if (task_is_idle(task))
+		tasklet_schedule(&task->tasklet);
 }
 
 static void tsklet_do_task(struct tasklet_struct *tasklet)
 {
 	struct rxe_task *task = container_of(tasklet, typeof(*task), tasklet);
 
-	do_task(task);
+	if (!task->destroyed)
+		do_task(task);
 }
 
 static void tsklet_run(struct rxe_task *task)
 {
-	do_task(task);
+	if (task_is_idle(task))
+		do_task(task);
 }
 
 static void tsklet_disable(struct rxe_task *task)
 {
-	disable_task(task);
-	tasklet_disable(&task->tasklet);
+	if (!task->destroyed)
+		disable_task(task);
 }
 
 static void tsklet_enable(struct rxe_task *task)
 {
-	tasklet_enable(&task->tasklet);
-	enable_task(task);
+	if (!task->destroyed)
+		enable_task(task);
 }
 
 static void tsklet_cleanup(struct rxe_task *task)
diff --git a/drivers/infiniband/sw/rxe/rxe_task.h b/drivers/infiniband/sw/rxe/rxe_task.h
index d594468fcf56..792832786456 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.h
+++ b/drivers/infiniband/sw/rxe/rxe_task.h
@@ -26,6 +26,7 @@ enum {
 	TASK_STATE_START	= 0,
 	TASK_STATE_BUSY		= 1,
 	TASK_STATE_ARMED	= 2,
+	TASK_STATE_PAUSED	= 3,
 };
 
 /*
-- 
2.34.1

