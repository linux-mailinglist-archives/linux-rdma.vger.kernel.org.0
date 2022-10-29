Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF4F1611FA2
	for <lists+linux-rdma@lfdr.de>; Sat, 29 Oct 2022 05:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiJ2DKw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Oct 2022 23:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJ2DKp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Oct 2022 23:10:45 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D9E2A411
        for <linux-rdma@vger.kernel.org>; Fri, 28 Oct 2022 20:10:28 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-13b103a3e5dso8355326fac.2
        for <linux-rdma@vger.kernel.org>; Fri, 28 Oct 2022 20:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Z4qyWIMoBUjYRI1MMwuXnIkq79/rYZQuSMRXsWdTRk=;
        b=qD42AWLtOmlILqRP5T0YeDkfw5HSWAAlLgkLPVQtmiLRgJuKDjdkMambHrgndwAdMJ
         Gjh2rTxr8w/khKrorBtYXMzjkzWgyIpMA83dUgn9JAaO+YQZW/BCXapjXvL9XsPxHnmA
         f2ws6KoJ4TQE3H1aNbF2GaPZ5nFglqaRRMvCzMcrT9rnouCKBd5Dg5y0Ux2giaJ0ADjQ
         WlHyusdckG9ATZ7xPN9D7jwzX4j/yjE7mNc0AfhKwXSM/IBY7Of6qED9/P3liOvAoSBJ
         zb+FBmzanebsSX1fQx78S4kol+B855bIy2AZCE7izs+XAfpT3psjzxr9LfCtaoD4+L36
         VVDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Z4qyWIMoBUjYRI1MMwuXnIkq79/rYZQuSMRXsWdTRk=;
        b=P7JaFUQ4Z49hzdQkcpPpYnp7VI9OGE2vkjCxsdQVsqltdrl8t3Xrn22hG8BM1CsoJf
         cAX6NiVsw7zOWDZws2i9ugzDCp3ou3Z8vOvkrsS4Lc8Jk8hByBrZh1cn77iO0L8NJVJH
         kDHGCYXq5obP9ZUaNJHI0KsX75QiVVOKxLnXkixgwdXIgjD3xopMqW8H6MKy4rbnGKqu
         k2A2KLBhf9lgmHKpR2zvKJbSBOhNIX1QP3XLXn6OT4vNzc6Zmqq+JuX+lJOswGCWeNIf
         dD4eOt4zLX2r7DeikFa2HjycXshegtQF0L2vxJscajhq4lpmG51CY0HzlgsWAyR8rgw6
         anzQ==
X-Gm-Message-State: ACrzQf3oV7KlhsDfL651lBWI5tBp4U8JYfYv5vbz1V0z08f+8aohnB98
        gR2DdCA7rP7aJn58B7zXUV73vHJUK2g=
X-Google-Smtp-Source: AMsMyM7Qwpe3H+nxEdO9v14M5MiRG4bdHLnNAYUhACl+6jFUdLulRQw1yBv67mziLpsV4jttreq5eg==
X-Received: by 2002:a05:6870:f201:b0:13b:2f1f:865b with SMTP id t1-20020a056870f20100b0013b2f1f865bmr11399373oao.205.1667013028132;
        Fri, 28 Oct 2022 20:10:28 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-5d1e-45f3-e9b5-d771.res6.spectrum.com. [2603:8081:140c:1a00:5d1e:45f3:e9b5:d771])
        by smtp.googlemail.com with ESMTPSA id p3-20020a0568301d4300b006391adb6034sm162493oth.72.2022.10.28.20.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 20:10:27 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, leon@kernel.org, zyjzyj2000@gmail.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        Ian Ziemba <ian.ziemba@hpe.com>
Subject: [PATCH for-next v3 10/13] RDMA/rxe: Replace task->destroyed by task state INVALID.
Date:   Fri, 28 Oct 2022 22:10:07 -0500
Message-Id: <20221029031009.64467-11-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221029031009.64467-1-rpearsonhpe@gmail.com>
References: <20221029031009.64467-1-rpearsonhpe@gmail.com>
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

Add a new state TASK_STATE_INVALID to replace the flag task->destroyed.
Make changes to task->state proteted by task->lock now including
TASK_STATE_INVALID.

Signed-off-by: Ian Ziemba <ian.ziemba@hpe.com>
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_task.c | 49 ++++++++++------------------
 drivers/infiniband/sw/rxe/rxe_task.h |  3 +-
 2 files changed, 19 insertions(+), 33 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw/rxe/rxe_task.c
index 0fd0d97e8272..da175f2a0dbf 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.c
+++ b/drivers/infiniband/sw/rxe/rxe_task.c
@@ -8,9 +8,6 @@
 
 static bool task_is_idle(struct rxe_task *task)
 {
-	if (task->destroyed)
-		return false;
-
 	spin_lock_bh(&task->lock);
 	switch (task->state) {
 	case TASK_STATE_IDLE:
@@ -19,12 +16,8 @@ static bool task_is_idle(struct rxe_task *task)
 		return true;
 	case TASK_STATE_BUSY:
 		task->state = TASK_STATE_ARMED;
-		fallthrough;
-	case TASK_STATE_ARMED:
-	case TASK_STATE_PAUSED:
 		break;
 	default:
-		WARN_ON(1);
 		break;
 	}
 	spin_unlock_bh(&task->lock);
@@ -41,7 +34,8 @@ static void do_task(struct rxe_task *task)
 
 	/* flush out pending tasks */
 	spin_lock_bh(&task->lock);
-	if (task->state == TASK_STATE_PAUSED) {
+	if (task->state == TASK_STATE_PAUSED ||
+	    task->state == TASK_STATE_INVALID) {
 		spin_unlock_bh(&task->lock);
 		return;
 	}
@@ -69,10 +63,7 @@ static void do_task(struct rxe_task *task)
 			task->state = TASK_STATE_BUSY;
 			cont = 1;
 			break;
-		case TASK_STATE_PAUSED:
-			break;
 		default:
-			WARN_ON(1);
 			break;
 		}
 		spin_unlock_bh(&task->lock);
@@ -87,14 +78,16 @@ static void do_task(struct rxe_task *task)
 static void disable_task(struct rxe_task *task)
 {
 	spin_lock_bh(&task->lock);
-	task->state = TASK_STATE_PAUSED;
+	if (task->state != TASK_STATE_INVALID)
+		task->state = TASK_STATE_PAUSED;
 	spin_unlock_bh(&task->lock);
 }
 
 static void enable_task(struct rxe_task *task)
 {
 	spin_lock_bh(&task->lock);
-	task->state = TASK_STATE_IDLE;
+	if (task->state != TASK_STATE_INVALID)
+		task->state = TASK_STATE_IDLE;
 	spin_unlock_bh(&task->lock);
 
 	/* restart task in case */
@@ -104,16 +97,16 @@ static void enable_task(struct rxe_task *task)
 /* busy wait until any previous tasks are done */
 static void cleanup_task(struct rxe_task *task)
 {
-	bool idle;
-
-	task->destroyed = true;
+	bool busy;
 
 	do {
 		spin_lock_bh(&task->lock);
-		idle = (task->state == TASK_STATE_IDLE ||
-			task->state == TASK_STATE_PAUSED);
+		busy = (task->state == TASK_STATE_BUSY ||
+			task->state == TASK_STATE_ARMED);
+		if (!busy)
+			task->state = TASK_STATE_INVALID;
 		spin_unlock_bh(&task->lock);
-	} while (!idle);
+	} while (busy);
 }
 
 /* silently treat schedule as inline for inline tasks */
@@ -131,14 +124,12 @@ static void inline_run(struct rxe_task *task)
 
 static void inline_disable(struct rxe_task *task)
 {
-	if (!task->destroyed)
-		disable_task(task);
+	disable_task(task);
 }
 
 static void inline_enable(struct rxe_task *task)
 {
-	if (!task->destroyed)
-		enable_task(task);
+	enable_task(task);
 }
 
 static void inline_cleanup(struct rxe_task *task)
@@ -168,10 +159,7 @@ static void tsklet_sched(struct rxe_task *task)
 
 static void tsklet_do_task(struct tasklet_struct *tasklet)
 {
-	struct rxe_task *task = container_of(tasklet, typeof(*task), tasklet);
-
-	if (!task->destroyed)
-		do_task(task);
+	do_task(container_of(tasklet, struct rxe_task, tasklet));
 }
 
 static void tsklet_run(struct rxe_task *task)
@@ -182,14 +170,12 @@ static void tsklet_run(struct rxe_task *task)
 
 static void tsklet_disable(struct rxe_task *task)
 {
-	if (!task->destroyed)
-		disable_task(task);
+	disable_task(task);
 }
 
 static void tsklet_enable(struct rxe_task *task)
 {
-	if (!task->destroyed)
-		enable_task(task);
+	enable_task(task);
 }
 
 static void tsklet_cleanup(struct rxe_task *task)
@@ -217,7 +203,6 @@ int rxe_init_task(struct rxe_task *task, void *arg, int (*func)(void *),
 {
 	task->arg	= arg;
 	task->func	= func;
-	task->destroyed	= false;
 	task->type	= type;
 	task->state	= TASK_STATE_IDLE;
 
diff --git a/drivers/infiniband/sw/rxe/rxe_task.h b/drivers/infiniband/sw/rxe/rxe_task.h
index 0146307fc517..2c4ef4d339f1 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.h
+++ b/drivers/infiniband/sw/rxe/rxe_task.h
@@ -27,6 +27,7 @@ enum {
 	TASK_STATE_BUSY		= 1,
 	TASK_STATE_ARMED	= 2,
 	TASK_STATE_PAUSED	= 3,
+	TASK_STATE_INVALID	= 4,
 };
 
 /*
@@ -41,7 +42,7 @@ struct rxe_task {
 	void				*arg;
 	int				(*func)(void *arg);
 	int				ret;
-	bool				destroyed;
+	bool				invalid;
 	const struct rxe_task_ops	*ops;
 	enum rxe_task_type		type;
 };
-- 
2.34.1

