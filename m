Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146D9602356
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Oct 2022 06:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbiJREgc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Oct 2022 00:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbiJREg1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Oct 2022 00:36:27 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1820A0261
        for <linux-rdma@vger.kernel.org>; Mon, 17 Oct 2022 21:36:21 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1321a1e94b3so15615249fac.1
        for <linux-rdma@vger.kernel.org>; Mon, 17 Oct 2022 21:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CuLsuXZ7cplicFlCz9EKGPq647h3L7v9Bx7lFVIXiJw=;
        b=HHzeNrrWRNhnD2rVy4d4ha7mz7a9F2rXJca+GI1+2tCSRhOFYSwoaUeOme1XLqM9jH
         1uTpYuZ5skMZKSKu6ZonsM0oAJ96QVFonFGgo+Yd54FvmRHQldbCB0jcZG6NyzTpzCQF
         Sg4PLnObNzvSH6G4HtALgzYsRe99Yg7pbdwZdX0A9jRsQgxFh92V+HDJ8jnI8/zvSouk
         qZhn0I1rOK1RZwrlg2s7uhdS4OOY+/wBZBAnk0S+WvbDpEVNM8H2rFYGbCBdGheyostd
         7H/lvGHgPSfYB3CMKNWoCygmQaE2+uDAuhgSngvXq0AiLI4MoJsrnILxbE3SDIb4tI3q
         0/sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CuLsuXZ7cplicFlCz9EKGPq647h3L7v9Bx7lFVIXiJw=;
        b=k1iz6KRPF/jBUZp1BEmcbRLUwhsS/c+EaF1eZr+lEDgM49rSo1ngVBoDstUOmnKFA0
         v0eO2v4bMsnt8DasXF2bge8hU1Dg838RX9bKl07eUmhdXZ8S/WSRn1TpiyeDScGiKfJI
         eSy6VT1ataaGZJHH9zcCK+ik+ETGWQ4+5siXyKz8Vk5EOxWaIUs5/A5/7sD7BG2flR9U
         hW8KA5PLYHX2DwfOsOglxR8FZmGh9r28kq+kQwHz9Gh8Jj75u2oIKtQxl47yHeTBjxZx
         M1AsEAJyoDXl1DXNLjyO2CxmffzLrWP9oiFa94uZhrVqlFNsUtgQqie2KUS2gHipKnag
         QqRQ==
X-Gm-Message-State: ACrzQf3Qsl72gK98/pExD8MCwIEOZ4Dux8WYCKxWnm69kkz+tXHQknEO
        7nz8SqszyTWBh6ERpP8Fjf4=
X-Google-Smtp-Source: AMsMyM5ighnX/nITZob4nJE19YSD6LkjzSpZxQVK2q1Mg3CNGcwrpomf4iLtrfBfZjWWc/fkn6ndiA==
X-Received: by 2002:a05:6870:601e:b0:132:7ced:b20e with SMTP id t30-20020a056870601e00b001327cedb20emr591363oaa.124.1666067780693;
        Mon, 17 Oct 2022 21:36:20 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-290b-8972-ce76-602c.res6.spectrum.com. [2603:8081:140c:1a00:290b:8972:ce76:602c])
        by smtp.googlemail.com with ESMTPSA id e96-20020a9d01e9000000b006618ca5caa0sm5480333ote.78.2022.10.17.21.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 21:36:20 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, matsuda-daisuke@fujitsu.com,
        lizhijian@fujitsu.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        jenny.hack@hpe.com, ian.ziemba@hpe.com
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 06/16] RDMA/rxe: Make task interface pluggable
Date:   Mon, 17 Oct 2022 23:33:37 -0500
Message-Id: <20221018043345.4033-7-rpearsonhpe@gmail.com>
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
index 42442ede99e8..fcd87114949f 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.c
+++ b/drivers/infiniband/sw/rxe/rxe_task.c
@@ -28,12 +28,11 @@ int __rxe_do_task(struct rxe_task *task)
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
@@ -94,28 +93,21 @@ static void do_task(struct tasklet_struct *t)
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
@@ -123,32 +115,144 @@ void rxe_cleanup_task(struct rxe_task *task)
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

