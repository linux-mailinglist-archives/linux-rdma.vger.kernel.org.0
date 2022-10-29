Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA8D611F9D
	for <lists+linux-rdma@lfdr.de>; Sat, 29 Oct 2022 05:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiJ2DKs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Oct 2022 23:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiJ2DKn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Oct 2022 23:10:43 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315BB29814
        for <linux-rdma@vger.kernel.org>; Fri, 28 Oct 2022 20:10:26 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-13ba9a4430cso8323973fac.11
        for <linux-rdma@vger.kernel.org>; Fri, 28 Oct 2022 20:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p3kPzmPDjjNhDNGku1w9RH09kAppbd1qvrZUMK/RXkU=;
        b=IKn7NiEp4Dy+EDfqswhqzMwlT9wMe4wzl53jA+cBUZ8qY+YKc2rYCGXnlXDPflac91
         Zw9L3d6BUvtHTA40foDwHRLByK6+MNVf43jYcsGlZ88c7+mTRnZaBN1JNN1WW86tn/ns
         SSn1MXKpPqyKVstM7+UqboV8Lqy13yxAv8IyNj8vodrMS73sxO4zyWKO8aC4jQYJe2Og
         huu0kTWMpt2laPF/CXUCZhvXKU09aQhhuUaEHafoNxpEi9Ovu1fMvZunDKmiL0niEvbq
         ETEQspaoV5j9Fgv2iyJfZxfI1t2raAEL8KpTha+IMz3K3YaGjXqfNe6RgOYkt+qFk/vZ
         gOIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p3kPzmPDjjNhDNGku1w9RH09kAppbd1qvrZUMK/RXkU=;
        b=JoXzjG2/m9xP0BhmEIGxkBzg9k2pCu/CL/xi0VCmrkxDI+Yk83qCek5q899Ap1HPNx
         CQ45UaNjOqh2Vr8crSoiyWhZN5IgvW20lDF9FgRs6+rdJ3EbHlQUV9fz2rt0X4uiTeVE
         9zPmPdt1n9JMX8L+Caqk6+F8R9+jKjdbwjLV7grfc6sFV9+XDUXK7hiVaekFZmvdyzzT
         tAPKGNfnCCKrOAO/ezt5aN6pUqUQxZi98evPmSIrhiY3QHwVemzbUYimeNh02818QfAH
         OHPk1sKamFcOlu3YdmI54w66KvRphInLlC+4UjT8aiaF3SYIpDCghIA6H6sICR3kR3F5
         Dbgw==
X-Gm-Message-State: ACrzQf3Z99T3cTXA1qcTR47l+PFPBJAPayJ/AB+FrMaWQpY3cky+j5kJ
        5Bqw7uN/LKFolMi4s+TGVFo=
X-Google-Smtp-Source: AMsMyM6USB781BkoCuOQWjg/fgqRSE/QQcmmPHpOypb6zTT2y5a86i/VRFVe3p+ddkxKjwhqJ6GDlg==
X-Received: by 2002:a05:6870:c082:b0:12b:542c:71cf with SMTP id c2-20020a056870c08200b0012b542c71cfmr10666966oad.45.1667013026037;
        Fri, 28 Oct 2022 20:10:26 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-5d1e-45f3-e9b5-d771.res6.spectrum.com. [2603:8081:140c:1a00:5d1e:45f3:e9b5:d771])
        by smtp.googlemail.com with ESMTPSA id p3-20020a0568301d4300b006391adb6034sm162493oth.72.2022.10.28.20.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 20:10:25 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, leon@kernel.org, zyjzyj2000@gmail.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        Ian Ziemba <ian.ziemba@hpe.com>
Subject: [PATCH for-next v3 08/13] RDMA/rxe: Implement disable/enable_task()
Date:   Fri, 28 Oct 2022 22:10:05 -0500
Message-Id: <20221029031009.64467-9-rpearsonhpe@gmail.com>
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

