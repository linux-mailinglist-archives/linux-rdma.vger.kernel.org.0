Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2AB607F76
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Oct 2022 22:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiJUUC7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Oct 2022 16:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbiJUUCZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Oct 2022 16:02:25 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14DF25ED0F
        for <linux-rdma@vger.kernel.org>; Fri, 21 Oct 2022 13:02:22 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 101-20020a9d0bee000000b00661b54d945fso2433017oth.13
        for <linux-rdma@vger.kernel.org>; Fri, 21 Oct 2022 13:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Z4qyWIMoBUjYRI1MMwuXnIkq79/rYZQuSMRXsWdTRk=;
        b=I2i0yQM736BQRWzDjjJtYRuHvzDXKuvj0XJxmJpj6SW6Bx8ZV+qQahYr3YRKCdV1U9
         1KzqUW7PRSvbLzhIXZxfzBJUZg5exxnM1aD6Jxf0/RN8furpjtEPmcpmxkbZlSsyrn9R
         s3aY80sMB87f2AQnkAGgZsjN/Z7DCtb6mTne0wYYbnjt2CVbPsy5AW1Gw3uCe/AIpsE+
         V6Rp42X0Jz2G5KUEWeW52lhqjvfkWn76qCnWTWfsVmyk0ytPBy7cudQYWnQpedkPbVHv
         LIrmddG44EutYeOltWtTy9/rdtU7wJkS/p8kZfLNM9kvjECSyqhvVnulLiYpzDT4mdYH
         fn4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Z4qyWIMoBUjYRI1MMwuXnIkq79/rYZQuSMRXsWdTRk=;
        b=kF+aMXAYfrc4jCe5hMm9czFHB7uFzGGuzZ2Cwu6WbbT+Thxvs2C8VOiMuo60O8xOq0
         t4avFCC9ySliVX3ZLAe5ob3KUPehJ5c8Y7j9taYs7MJoC6VNS/d7zXnJGxZG0SWJPZGU
         FqL7vDL4e0U+cOG3DER+AMwru6GjZ76/4ge60QOnaDTUhJiCqaQgvserssa7JyAlvWoG
         KD2gk0/LfBO6jerVR1HowcceM5sKvkHEtKKxflspchvyom39r69nYQDSIFYeWuS7lkD6
         fol36yiNd5r/gASk5Cy+RxpNR1Fhpubuy1hDqorSm0yj+eOWPlh6x54m6dJdBQKZg+yf
         QLjQ==
X-Gm-Message-State: ACrzQf3EjzpIroXGwA6+n4QcVuAZ9VK3tK8YAXjSU7RQqG01MdZkIY3W
        2ZXnAfMkTDdxk4d7gRnrojs=
X-Google-Smtp-Source: AMsMyM7eWBocsY68HKL3tVnnxCRSA/K89JiQ2tkk8f5PDsXzqJb5ADCkKSWhAaEmPVHbAnG2Q0K95g==
X-Received: by 2002:a05:6830:2b09:b0:661:c464:3c6f with SMTP id l9-20020a0568302b0900b00661c4643c6fmr10646538otv.90.1666382541235;
        Fri, 21 Oct 2022 13:02:21 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-a860-f1d2-9e17-7593.res6.spectrum.com. [2603:8081:140c:1a00:a860:f1d2:9e17:7593])
        by smtp.googlemail.com with ESMTPSA id s23-20020a056870631700b00132f141ef2dsm10674684oao.56.2022.10.21.13.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 13:02:20 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, leon@kernel.org,
        jhack@hpe.com, ian.ziemba@hpe.com, matsuda-daisuke@fujitsu.com,
        lizhijian@fujitsu.com, haris.phnx@gmail.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 16/18] RDMA/rxe: Replace task->destroyed by task state INVALID.
Date:   Fri, 21 Oct 2022 15:01:17 -0500
Message-Id: <20221021200118.2163-17-rpearsonhpe@gmail.com>
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

