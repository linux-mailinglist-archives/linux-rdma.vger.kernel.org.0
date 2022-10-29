Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1513D611F9E
	for <lists+linux-rdma@lfdr.de>; Sat, 29 Oct 2022 05:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbiJ2DKt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Oct 2022 23:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiJ2DKp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Oct 2022 23:10:45 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31BEB2A40E
        for <linux-rdma@vger.kernel.org>; Fri, 28 Oct 2022 20:10:19 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id m5-20020a9d73c5000000b0066738ce4f12so4003779otk.12
        for <linux-rdma@vger.kernel.org>; Fri, 28 Oct 2022 20:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EU9/rBYN2hXS/v49sgDZV0QWnssuEz3K4CW9gz24luE=;
        b=Vp86E2FRAefpgsOo9rPP5iHZquewIBiuG0TlFre5tMozafwOmpeb3KG1hEv/rwiJc1
         ZP4+zbehdytLt8+TloQBTgUM7VzeyRcMsi+1TrRa0WvD3bm1tMiL3tWH8ObYyhYgCEDI
         JYTzypZkeGUCalFdULgQZGmP+C+3A9UD/lJMlIliwD3Bz8BUQBPhgRkI5qTU19wV4kvA
         OV4EeGKzzD8WSpVsjBc1otDfl2xWF5luwyuAEEYk1s/jMnK/vO4zkpFU8QNTjP7NlmNu
         BjBnfX/X/QcHJFMwHQNyQzlERNeFESX9dCDv+b32uG1zA3gldAaI8/fdNt78aw6XWmod
         cKIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EU9/rBYN2hXS/v49sgDZV0QWnssuEz3K4CW9gz24luE=;
        b=NbY64xGDtWHd9OqpCJ6DewJt8Z/zx+gRZoo85BCsgVZdDGub8fdN4vb14VQsaVou2h
         DZuOeJaB18tLxn91L/fQL2t338TjGFvYoGFONXNCSZhQYugoAnQXhlf7rDx/eZU6EQ9K
         /5F7tVr5OAjzEBILTOHhzx04fx4/Eu9s/ytH2AxNs5OmF6Uop0Lt92LQoegX7G5XKPik
         biEkV3vlc6fj1fkrHYAoQLfZz6OTROyvInU3xiVrDvC89RR47F8mvXgaUI5tIdAP+iUb
         MzR262ymAWTNvirY+QGJSmPBMUON5seYqVdGGFaYJcpDEV9PUwMQI5ENMmRzvPXUG84S
         IIQA==
X-Gm-Message-State: ACrzQf3i5ZxsMUomUzKtzcVXn7Xj4WptCr5Dz9FK/1T8PBuVYW6nbwTF
        q9ARz+IRdxXN/qUAPg+BavI=
X-Google-Smtp-Source: AMsMyM79ZhR9iZGQYymXFfEAOiKP+hl/hBIFcNF/VNCczcc5PsOT2T46R+g3mrFXIgXgV2lL2ietzQ==
X-Received: by 2002:a05:6830:4486:b0:661:9f14:9b45 with SMTP id r6-20020a056830448600b006619f149b45mr1188221otv.227.1667013018958;
        Fri, 28 Oct 2022 20:10:18 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-5d1e-45f3-e9b5-d771.res6.spectrum.com. [2603:8081:140c:1a00:5d1e:45f3:e9b5:d771])
        by smtp.googlemail.com with ESMTPSA id p3-20020a0568301d4300b006391adb6034sm162493oth.72.2022.10.28.20.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 20:10:18 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, leon@kernel.org, zyjzyj2000@gmail.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        Ian Ziemba <ian.ziemba@hpe.com>
Subject: [PATCH for-next v3 01/13] RDMA/rxe: Make task interface pluggable
Date:   Fri, 28 Oct 2022 22:09:58 -0500
Message-Id: <20221029031009.64467-2-rpearsonhpe@gmail.com>
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

Make the internal interface to the task operations pluggable and
add a new 'inline' type.

Signed-off-by: Ian Ziemba <ian.ziemba@hpe.com>
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_qp.c   |   8 +-
 drivers/infiniband/sw/rxe/rxe_task.c | 160 ++++++++++++++++++++++-----
 drivers/infiniband/sw/rxe/rxe_task.h |  44 +++++---
 3 files changed, 165 insertions(+), 47 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index 3f6d62a80bea..b5e108794aa1 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -238,8 +238,10 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
 
 	skb_queue_head_init(&qp->req_pkts);
 
-	rxe_init_task(&qp->req.task, qp, rxe_requester);
-	rxe_init_task(&qp->comp.task, qp, rxe_completer);
+	rxe_init_task(&qp->req.task, qp, rxe_requester, RXE_TASK_TYPE_TASKLET);
+	rxe_init_task(&qp->comp.task, qp, rxe_completer,
+			(qp_type(qp) == IB_QPT_RC) ? RXE_TASK_TYPE_TASKLET :
+						     RXE_TASK_TYPE_INLINE);
 
 	qp->qp_timeout_jiffies = 0; /* Can't be set for UD/UC in modify_qp */
 	if (init->qp_type == IB_QPT_RC) {
@@ -286,7 +288,7 @@ static int rxe_qp_init_resp(struct rxe_dev *rxe, struct rxe_qp *qp,
 
 	skb_queue_head_init(&qp->resp_pkts);
 
-	rxe_init_task(&qp->resp.task, qp, rxe_responder);
+	rxe_init_task(&qp->resp.task, qp, rxe_responder, RXE_TASK_TYPE_TASKLET);
 
 	qp->resp.opcode		= OPCODE_NONE;
 	qp->resp.msn		= 0;
diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw/rxe/rxe_task.c
index 0208d833a41b..8dfbfa164eff 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.c
+++ b/drivers/infiniband/sw/rxe/rxe_task.c
@@ -24,12 +24,11 @@ int __rxe_do_task(struct rxe_task *task)
  * a second caller finds the task already running
  * but looks just after the last call to func
  */
-static void do_task(struct tasklet_struct *t)
+static void do_task(struct rxe_task *task)
 {
+	unsigned int iterations = RXE_MAX_ITERATIONS;
 	int cont;
 	int ret;
-	struct rxe_task *task = from_tasklet(task, t, tasklet);
-	unsigned int iterations = RXE_MAX_ITERATIONS;
 
 	spin_lock_bh(&task->lock);
 	switch (task->state) {
@@ -90,28 +89,21 @@ static void do_task(struct tasklet_struct *t)
 	task->ret = ret;
 }
 
-int rxe_init_task(struct rxe_task *task, void *arg, int (*func)(void *))
+static void disable_task(struct rxe_task *task)
 {
-	task->arg	= arg;
-	task->func	= func;
-	task->destroyed	= false;
-
-	tasklet_setup(&task->tasklet, do_task);
-
-	task->state = TASK_STATE_START;
-	spin_lock_init(&task->lock);
+	/* todo */
+}
 
-	return 0;
+static void enable_task(struct rxe_task *task)
+{
+	/* todo */
 }
 
-void rxe_cleanup_task(struct rxe_task *task)
+/* busy wait until any previous tasks are done */
+static void cleanup_task(struct rxe_task *task)
 {
 	bool idle;
 
-	/*
-	 * Mark the task, then wait for it to finish. It might be
-	 * running in a non-tasklet (direct call) context.
-	 */
 	task->destroyed = true;
 
 	do {
@@ -119,32 +111,144 @@ void rxe_cleanup_task(struct rxe_task *task)
 		idle = (task->state == TASK_STATE_START);
 		spin_unlock_bh(&task->lock);
 	} while (!idle);
+}
 
-	tasklet_kill(&task->tasklet);
+/* silently treat schedule as inline for inline tasks */
+static void inline_sched(struct rxe_task *task)
+{
+	do_task(task);
 }
 
-void rxe_run_task(struct rxe_task *task)
+static void inline_run(struct rxe_task *task)
 {
-	if (task->destroyed)
-		return;
+	do_task(task);
+}
 
-	do_task(&task->tasklet);
+static void inline_disable(struct rxe_task *task)
+{
+	disable_task(task);
 }
 
-void rxe_sched_task(struct rxe_task *task)
+static void inline_enable(struct rxe_task *task)
 {
-	if (task->destroyed)
-		return;
+	enable_task(task);
+}
+
+static void inline_cleanup(struct rxe_task *task)
+{
+	cleanup_task(task);
+}
+
+static const struct rxe_task_ops inline_ops = {
+	.sched = inline_sched,
+	.run = inline_run,
+	.enable = inline_enable,
+	.disable = inline_disable,
+	.cleanup = inline_cleanup,
+};
 
+static void inline_init(struct rxe_task *task)
+{
+	task->ops = &inline_ops;
+}
+
+/* use tsklet_xxx to avoid name collisions with tasklet_xxx */
+static void tsklet_sched(struct rxe_task *task)
+{
 	tasklet_schedule(&task->tasklet);
 }
 
-void rxe_disable_task(struct rxe_task *task)
+static void tsklet_do_task(struct tasklet_struct *tasklet)
 {
+	struct rxe_task *task = container_of(tasklet, typeof(*task), tasklet);
+
+	do_task(task);
+}
+
+static void tsklet_run(struct rxe_task *task)
+{
+	do_task(task);
+}
+
+static void tsklet_disable(struct rxe_task *task)
+{
+	disable_task(task);
 	tasklet_disable(&task->tasklet);
 }
 
-void rxe_enable_task(struct rxe_task *task)
+static void tsklet_enable(struct rxe_task *task)
 {
 	tasklet_enable(&task->tasklet);
+	enable_task(task);
+}
+
+static void tsklet_cleanup(struct rxe_task *task)
+{
+	cleanup_task(task);
+	tasklet_kill(&task->tasklet);
+}
+
+static const struct rxe_task_ops tsklet_ops = {
+	.sched = tsklet_sched,
+	.run = tsklet_run,
+	.enable = tsklet_enable,
+	.disable = tsklet_disable,
+	.cleanup = tsklet_cleanup,
+};
+
+static void tsklet_init(struct rxe_task *task)
+{
+	tasklet_setup(&task->tasklet, tsklet_do_task);
+	task->ops = &tsklet_ops;
+}
+
+int rxe_init_task(struct rxe_task *task, void *arg, int (*func)(void *),
+		  enum rxe_task_type type)
+{
+	task->arg	= arg;
+	task->func	= func;
+	task->destroyed	= false;
+	task->type	= type;
+	task->state	= TASK_STATE_START;
+
+	spin_lock_init(&task->lock);
+
+	switch (type) {
+	case RXE_TASK_TYPE_INLINE:
+		inline_init(task);
+		break;
+	case RXE_TASK_TYPE_TASKLET:
+		tsklet_init(task);
+		break;
+	default:
+		pr_debug("%s: invalid task type = %d\n", __func__, type);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+void rxe_sched_task(struct rxe_task *task)
+{
+	task->ops->sched(task);
+}
+
+void rxe_run_task(struct rxe_task *task)
+{
+	task->ops->run(task);
+}
+
+void rxe_enable_task(struct rxe_task *task)
+{
+	task->ops->enable(task);
+}
+
+void rxe_disable_task(struct rxe_task *task)
+{
+	task->ops->disable(task);
+}
+
+void rxe_cleanup_task(struct rxe_task *task)
+{
+	task->ops->cleanup(task);
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_task.h b/drivers/infiniband/sw/rxe/rxe_task.h
index 7b88129702ac..31963129ff7a 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.h
+++ b/drivers/infiniband/sw/rxe/rxe_task.h
@@ -7,6 +7,21 @@
 #ifndef RXE_TASK_H
 #define RXE_TASK_H
 
+struct rxe_task;
+
+struct rxe_task_ops {
+	void (*sched)(struct rxe_task *task);
+	void (*run)(struct rxe_task *task);
+	void (*disable)(struct rxe_task *task);
+	void (*enable)(struct rxe_task *task);
+	void (*cleanup)(struct rxe_task *task);
+};
+
+enum rxe_task_type {
+	RXE_TASK_TYPE_INLINE	= 0,
+	RXE_TASK_TYPE_TASKLET	= 1,
+};
+
 enum {
 	TASK_STATE_START	= 0,
 	TASK_STATE_BUSY		= 1,
@@ -19,24 +34,19 @@ enum {
  * called again.
  */
 struct rxe_task {
-	struct tasklet_struct	tasklet;
-	int			state;
-	spinlock_t		lock;
-	void			*arg;
-	int			(*func)(void *arg);
-	int			ret;
-	bool			destroyed;
+	struct tasklet_struct		tasklet;
+	int				state;
+	spinlock_t			lock;
+	void				*arg;
+	int				(*func)(void *arg);
+	int				ret;
+	bool				destroyed;
+	const struct rxe_task_ops	*ops;
+	enum rxe_task_type		type;
 };
 
-/*
- * init rxe_task structure
- *	arg  => parameter to pass to fcn
- *	func => function to call until it returns != 0
- */
-int rxe_init_task(struct rxe_task *task, void *arg, int (*func)(void *));
-
-/* cleanup task */
-void rxe_cleanup_task(struct rxe_task *task);
+int rxe_init_task(struct rxe_task *task, void *arg, int (*func)(void *),
+		  enum rxe_task_type type);
 
 /*
  * raw call to func in loop without any checking
@@ -54,4 +64,6 @@ void rxe_disable_task(struct rxe_task *task);
 /* allow task to run */
 void rxe_enable_task(struct rxe_task *task);
 
+void rxe_cleanup_task(struct rxe_task *task);
+
 #endif /* RXE_TASK_H */
-- 
2.34.1

