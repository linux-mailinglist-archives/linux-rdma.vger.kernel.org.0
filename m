Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D4960235C
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Oct 2022 06:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiJREgl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Oct 2022 00:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbiJREgb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Oct 2022 00:36:31 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A03A0244
        for <linux-rdma@vger.kernel.org>; Mon, 17 Oct 2022 21:36:30 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1324e7a1284so15590969fac.10
        for <linux-rdma@vger.kernel.org>; Mon, 17 Oct 2022 21:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ebsTGF8eEEinSFVudIsRB2osA85CvNiD6HhTY4AJp0I=;
        b=m5dSK5P0E8omzcj5t6+vurYAVn3rUoX/oZvBCrJKiYlrqdHOleU6xZHFyiMFB3DzLB
         nFQWKR7u4jMRabz8J8Cp/UDFZ/AEIZLZBvq4JDqMQWS97bzs6dVMFoH9VKSUfvPS4Bb+
         ez0nunRgn8iSoUZ3C/z6F3rDVUkJIJwLFkGQdfArKOG6SemM/0/T4VIt4/Kt1b6FdE1V
         ktXKrBDgJkZVcsdrICZDB7fqxjJ5NLMcFTC8zxmgnwhTE5QIJ506qleljC6O7dXlx/sm
         OEbSyHhb9O4SnT1jNFDIWD7wsLglW0Eh1ceR+uMc6ajEHFKqbJWISui4OqXh69W84hxD
         URZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ebsTGF8eEEinSFVudIsRB2osA85CvNiD6HhTY4AJp0I=;
        b=LyBmeBAqOxr6L5tzN86RssOLApfp03jaLmDc32KSsFecriXQFVnFQwkZ/eYhJQttLa
         gxuAiNIH77xBpIZKgCcGX7BRcED7ryjZVyvoA7foZdPbicw870yzhSjcnhU/vVPMkWgG
         GI9uCp28bhes0KNfhq8cQR/16qWSpcm70z6EdK4c77ZlRhS1SI6/vJI7O0vnFCNpdgpC
         Y/lqjpd+2qExbgboZ1ByZfC7cmVEhYH+Ncq6MlDb0REHRzW/oVNp9f2JeBcIuz4TvSYG
         6ziKHD/b1LzLELq3j4z5ciQjoEYnldDMMo4+cDFzGquPfkVbgyaSa+B+Kg6YKDqj31Yg
         EZZg==
X-Gm-Message-State: ACrzQf389CxILCaL/LK6CrWBwAYVZCppoW+hZqGi8eAAa8vlu6ydikUI
        hTdGnrY5kVKdbBolGMagWoY=
X-Google-Smtp-Source: AMsMyM5Ik9CrWIJ4VpV8ElnUlGGGUz2t3P5vEeOyx9M7t4NGMDwGjsUUywn5yEsalD9H1qtzivPHAg==
X-Received: by 2002:a05:6871:79e:b0:132:e1f1:c75f with SMTP id o30-20020a056871079e00b00132e1f1c75fmr17726866oap.234.1666067789264;
        Mon, 17 Oct 2022 21:36:29 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-290b-8972-ce76-602c.res6.spectrum.com. [2603:8081:140c:1a00:290b:8972:ce76:602c])
        by smtp.googlemail.com with ESMTPSA id e96-20020a9d01e9000000b006618ca5caa0sm5480333ote.78.2022.10.17.21.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 21:36:28 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, matsuda-daisuke@fujitsu.com,
        lizhijian@fujitsu.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        jenny.hack@hpe.com, ian.ziemba@hpe.com
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 13/16] RDMA/rxe: Implement disable/enable_task()
Date:   Mon, 17 Oct 2022 23:33:44 -0500
Message-Id: <20221018043345.4033-14-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221018043345.4033-1-rpearsonhpe@gmail.com>
References: <20221018043345.4033-1-rpearsonhpe@gmail.com>
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

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_task.c | 107 ++++++++++++++++-----------
 drivers/infiniband/sw/rxe/rxe_task.h |   1 +
 2 files changed, 66 insertions(+), 42 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw/rxe/rxe_task.c
index 75ec195f4176..a9eb66d69cb7 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.c
+++ b/drivers/infiniband/sw/rxe/rxe_task.c
@@ -10,36 +10,46 @@
 
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
@@ -47,47 +57,52 @@ static void do_task(struct rxe_task *task)
 
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
@@ -99,7 +114,8 @@ static void cleanup_task(struct rxe_task *task)
 
 	do {
 		spin_lock_bh(&task->lock);
-		idle = (task->state == TASK_STATE_START);
+		idle = (task->state == TASK_STATE_START ||
+			task->state == TASK_STATE_PAUSED);
 		spin_unlock_bh(&task->lock);
 	} while (!idle);
 }
@@ -107,22 +123,26 @@ static void cleanup_task(struct rxe_task *task)
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
@@ -146,31 +166,34 @@ static void inline_init(struct rxe_task *task)
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

