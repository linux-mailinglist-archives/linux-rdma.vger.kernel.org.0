Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27F469FF9C
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Feb 2023 00:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbjBVXfl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Feb 2023 18:35:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232782AbjBVXfk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Feb 2023 18:35:40 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7909D1E5F2
        for <linux-rdma@vger.kernel.org>; Wed, 22 Feb 2023 15:35:29 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id v1-20020a9d6041000000b0068d4a8a8d2dso1881288otj.12
        for <linux-rdma@vger.kernel.org>; Wed, 22 Feb 2023 15:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k9BoHEwgKUbosGePv1yHqss3X8jvJed/Fb/ZUDuPZtQ=;
        b=MrbO9VGpCu/nPeMVWXJ4Pe64yMZn5HznoyNXfFRzYeETN6Tn6iplU682ayRPYQuXrV
         7exHTFSDbsZUgHzqAqvaQFzwg8KD3OVZlIiXm3GfSPLO0RoS9QFknJWpt/9REjpE3XaL
         pP+zhkp0vOdiEnUmZzUTa80U9VGK8oxf8OxfzxYolLloZhSZwLJibQ9aDqa/NXxUGW6F
         jTmRWPY8YMyyH8FVFScP2FTtzpCh1lnSTBjbefq2sz6G5x538+4EH8GJAF7S8ImvFYtd
         kPla9XWXETDVIdPxlfbk9nQ/sKPs6+Nd5a6kX9+FTQaxMnbiV6QJgGY6KMKUEJtvJaun
         rb/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k9BoHEwgKUbosGePv1yHqss3X8jvJed/Fb/ZUDuPZtQ=;
        b=fVk4wQ/usSVp9LrTF9P28ZcfU+7zM5X0OzYl7gj+2vXQbCmqYEeQ5zo1q9UmienRMa
         jP6AUqy5mFIsvk9vpVqfHqkRHcTQAZ8uoJCzO0U9xCs+oAc9AQoh+oencFJJ/hCI81CM
         Zq3auU2Fm5PJCLtgYJi2bb6KwzVNPIBhwSZh/fDoSEa2H2jX4dgXd2+H4FPwraoCECcX
         jJVbIScfm60SEXW2SbvocaolqG7XyIQSYv+gzMd/JJ+7VKl7LmxpCDIrDQL+5q9p9EzO
         Z8LShLqbgf10kzvEhh42NpCUv2a0gB5QS+vI376YxgTY6mCMc2hFC/q3jMvzhA7wymyT
         ZLog==
X-Gm-Message-State: AO0yUKUhEVaUmPdEDT4mz28WDaMU029wiSmJ2Da3VF3wRLw8whOPsXeP
        f0ae8el8yXB/ZLv2LnZeEVo=
X-Google-Smtp-Source: AK7set97fNM3DoYFnqjGOvkXdn3EN5Ox3tAs38kDtMhHsIkkCHbPJ9pSkJWnrRsuTArnhiad/+iWkA==
X-Received: by 2002:a05:6830:1f5d:b0:693:ccf8:c118 with SMTP id u29-20020a0568301f5d00b00693ccf8c118mr1471318oth.23.1677108928829;
        Wed, 22 Feb 2023 15:35:28 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-e92c-8850-3fad-351f.res6.spectrum.com. [2603:8081:140c:1a00:e92c:8850:3fad:351f])
        by smtp.gmail.com with ESMTPSA id l19-20020a9d7093000000b0068663820588sm2723281otj.44.2023.02.22.15.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 15:35:27 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, matsuda-daisuke@fujitsu.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 3/9] RDMA/rxe: Convert tasklet args to queue pairs
Date:   Wed, 22 Feb 2023 17:32:32 -0600
Message-Id: <20230222233237.48940-4-rpearsonhpe@gmail.com>
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

Originally is was thought that the tasklet machinery in rxe_task.c
would be used in other applications but that has not happened for
years. This patch replaces the 'void *arg' by struct 'rxe_qp *qp' in
the parameters to the tasklet calls. This change will have no
affect on performance but may make the code a little clearer.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_comp.c |  3 +--
 drivers/infiniband/sw/rxe/rxe_loc.h  |  6 +++---
 drivers/infiniband/sw/rxe/rxe_req.c  |  3 +--
 drivers/infiniband/sw/rxe/rxe_resp.c |  3 +--
 drivers/infiniband/sw/rxe/rxe_task.c | 11 ++++++-----
 drivers/infiniband/sw/rxe/rxe_task.h |  9 +++++----
 6 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index 876057e3ee3c..cbfa16b3a490 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -575,9 +575,8 @@ static void free_pkt(struct rxe_pkt_info *pkt)
 	ib_device_put(dev);
 }
 
-int rxe_completer(void *arg)
+int rxe_completer(struct rxe_qp *qp)
 {
-	struct rxe_qp *qp = (struct rxe_qp *)arg;
 	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
 	struct rxe_send_wqe *wqe = NULL;
 	struct sk_buff *skb = NULL;
diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 839de34cf4c9..804b15e929dd 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -170,9 +170,9 @@ void rxe_srq_cleanup(struct rxe_pool_elem *elem);
 
 void rxe_dealloc(struct ib_device *ib_dev);
 
-int rxe_completer(void *arg);
-int rxe_requester(void *arg);
-int rxe_responder(void *arg);
+int rxe_completer(struct rxe_qp *qp);
+int rxe_requester(struct rxe_qp *qp);
+int rxe_responder(struct rxe_qp *qp);
 
 /* rxe_icrc.c */
 int rxe_icrc_init(struct rxe_dev *rxe);
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 899c8779f800..f2dc2d191e16 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -635,9 +635,8 @@ static int rxe_do_local_ops(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 	return 0;
 }
 
-int rxe_requester(void *arg)
+int rxe_requester(struct rxe_qp *qp)
 {
-	struct rxe_qp *qp = (struct rxe_qp *)arg;
 	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
 	struct rxe_pkt_info pkt;
 	struct sk_buff *skb;
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 4217eec03a94..7cb1b962d665 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -1443,9 +1443,8 @@ static void rxe_drain_req_pkts(struct rxe_qp *qp, bool notify)
 		queue_advance_consumer(q, q->type);
 }
 
-int rxe_responder(void *arg)
+int rxe_responder(struct rxe_qp *qp)
 {
-	struct rxe_qp *qp = (struct rxe_qp *)arg;
 	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
 	enum resp_states state;
 	struct rxe_pkt_info *pkt = NULL;
diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw/rxe/rxe_task.c
index 60b90e33a884..959cc6229a34 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.c
+++ b/drivers/infiniband/sw/rxe/rxe_task.c
@@ -11,7 +11,7 @@ int __rxe_do_task(struct rxe_task *task)
 {
 	int ret;
 
-	while ((ret = task->func(task->arg)) == 0)
+	while ((ret = task->func(task->qp)) == 0)
 		;
 
 	task->ret = ret;
@@ -29,7 +29,7 @@ static void do_task(struct tasklet_struct *t)
 	int cont;
 	int ret;
 	struct rxe_task *task = from_tasklet(task, t, tasklet);
-	struct rxe_qp *qp = (struct rxe_qp *)task->arg;
+	struct rxe_qp *qp = (struct rxe_qp *)task->qp;
 	unsigned int iterations = RXE_MAX_ITERATIONS;
 
 	spin_lock_bh(&task->lock);
@@ -54,7 +54,7 @@ static void do_task(struct tasklet_struct *t)
 
 	do {
 		cont = 0;
-		ret = task->func(task->arg);
+		ret = task->func(task->qp);
 
 		spin_lock_bh(&task->lock);
 		switch (task->state) {
@@ -91,9 +91,10 @@ static void do_task(struct tasklet_struct *t)
 	task->ret = ret;
 }
 
-int rxe_init_task(struct rxe_task *task, void *arg, int (*func)(void *))
+int rxe_init_task(struct rxe_task *task, struct rxe_qp *qp,
+		  int (*func)(struct rxe_qp *))
 {
-	task->arg	= arg;
+	task->qp	= qp;
 	task->func	= func;
 	task->destroyed	= false;
 
diff --git a/drivers/infiniband/sw/rxe/rxe_task.h b/drivers/infiniband/sw/rxe/rxe_task.h
index 7b88129702ac..41efd5fd49b0 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.h
+++ b/drivers/infiniband/sw/rxe/rxe_task.h
@@ -22,18 +22,19 @@ struct rxe_task {
 	struct tasklet_struct	tasklet;
 	int			state;
 	spinlock_t		lock;
-	void			*arg;
-	int			(*func)(void *arg);
+	struct rxe_qp		*qp;
+	int			(*func)(struct rxe_qp *qp);
 	int			ret;
 	bool			destroyed;
 };
 
 /*
  * init rxe_task structure
- *	arg  => parameter to pass to fcn
+ *	qp  => parameter to pass to func
  *	func => function to call until it returns != 0
  */
-int rxe_init_task(struct rxe_task *task, void *arg, int (*func)(void *));
+int rxe_init_task(struct rxe_task *task, struct rxe_qp *qp,
+		  int (*func)(struct rxe_qp *));
 
 /* cleanup task */
 void rxe_cleanup_task(struct rxe_task *task);
-- 
2.37.2

