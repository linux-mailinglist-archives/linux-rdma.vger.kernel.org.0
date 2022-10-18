Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C22860235A
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Oct 2022 06:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbiJREgj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Oct 2022 00:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbiJREg3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Oct 2022 00:36:29 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F33CA024F
        for <linux-rdma@vger.kernel.org>; Mon, 17 Oct 2022 21:36:27 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1370acb6588so15580194fac.9
        for <linux-rdma@vger.kernel.org>; Mon, 17 Oct 2022 21:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hwENGQaZsNNSx3Gv9rNHoDvR95XXZpwgm4cJviWnxVc=;
        b=jy4RbXnciS20q63uUOErGXeZGZadN/zoBxlBocsAMmETBq+pu19M+0Fv/jhBiYasfB
         FCexFk17aFLmYEiPE09rC87L6Ce0/Ma9lSCiI4jDfihrW3Ajpq3XPIC1wq0RMXVwbIYF
         oa7yH8RSP47/nTt35qSE6UfFr/bc3AgKhMPOaiDF9xlUO38bqXD18ia3jJUteW6iJlN6
         uIzlbRzwN+TigI1mmA6XsspxYMOAJO0n+QzHlzigMEl573YojIEI8YaAL38TEMYixr6J
         AqWWRDL4Ze0Cgsly1E1Ibp3R1FjGaGjzIAWuBfataHw1KTR8DlhE2G2IYiEXOnp8vTjQ
         semQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hwENGQaZsNNSx3Gv9rNHoDvR95XXZpwgm4cJviWnxVc=;
        b=JlPTnkjXyJ3WgrMKmtN4tqdTrBZKrlnTsDJgYugzDe5DmI1Rz7f6gFmxWap7p3BQBu
         kU9v4Dl3ntu6k00Wgk29wBrpiQDDxVJBphuugMmQnd7lkfgiUSpWFkVS3tB4SVEbeNQk
         /C+fH5RH6h7dyHgDrkG/XqNyO3BMPdaXYUxmLjO+MXN6Gv5PAKzC6FKlJJ+j4xEd9h65
         66Rr/blEdXw7xc3TCrAw/eDckw1S+6BlQ10Rk4FIkaIpmF2mFteuN6mB6D7QxL+QNrqo
         2g1UT2RRxmg9SkwlLabdI33Lfsdmxcp89WfuaoXfujJKMF78mx2/ZE+thJelxp2LxrBm
         D+HQ==
X-Gm-Message-State: ACrzQf3BBQfhjecVAgaSsxHDQDwsifsSvu5r8kcyJJ9uE06mZ+u0776e
        Sv1a5uz4/WGVkg4a/EKagbIU2v/2uL0pJQ==
X-Google-Smtp-Source: AMsMyM4y9Ur1WFMq5tHtxjLbRvEqoOJZUR36hNE1EQlOzKlpXX7TzoZUGMArkswKq5Pc5zoAc/ZFQw==
X-Received: by 2002:a05:6870:2052:b0:132:7b2:2fe6 with SMTP id l18-20020a056870205200b0013207b22fe6mr642634oad.98.1666067786636;
        Mon, 17 Oct 2022 21:36:26 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-290b-8972-ce76-602c.res6.spectrum.com. [2603:8081:140c:1a00:290b:8972:ce76:602c])
        by smtp.googlemail.com with ESMTPSA id e96-20020a9d01e9000000b006618ca5caa0sm5480333ote.78.2022.10.17.21.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 21:36:26 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, matsuda-daisuke@fujitsu.com,
        lizhijian@fujitsu.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        jenny.hack@hpe.com, ian.ziemba@hpe.com
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 11/16] RDMA/rxe: Remove __rxe_do_task()
Date:   Mon, 17 Oct 2022 23:33:42 -0500
Message-Id: <20221018043345.4033-12-rpearsonhpe@gmail.com>
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

The subroutine __rxe_do_task is not thread safe. It is only
used in the rxe_qp_reset() and rxe_qp_do_cleanup() routines.
After changes in error handling in the tasklet functions the
queues can be drained by calling them once outside of the
tasklet code. This allows __rxe_do_task() to be removed.

Signed-off-by: Ian Ziemba <ian.ziemba@hpe.com>
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_qp.c   | 60 ++++++++++++++--------------
 drivers/infiniband/sw/rxe/rxe_task.c | 13 ------
 drivers/infiniband/sw/rxe/rxe_task.h |  6 ---
 3 files changed, 29 insertions(+), 50 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index 3691eb97c576..50f6b8b8ad9d 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -477,28 +477,23 @@ static void rxe_qp_reset(struct rxe_qp *qp)
 {
 	/* stop tasks from running */
 	rxe_disable_task(&qp->resp.task);
-
-	/* stop request/comp */
-	if (qp->sq.queue) {
-		rxe_disable_task(&qp->comp.task);
-		rxe_disable_task(&qp->req.task);
-	}
+	rxe_disable_task(&qp->comp.task);
+	rxe_disable_task(&qp->req.task);
 
 	/* move qp to the reset state */
 	qp->req.state = QP_STATE_RESET;
 	qp->comp.state = QP_STATE_RESET;
 	qp->resp.state = QP_STATE_RESET;
 
-	/* let state machines reset themselves drain work and packet queues
-	 * etc.
-	 */
-	__rxe_do_task(&qp->resp.task);
+	/* drain work and packet queues */
+	rxe_responder(qp);
+	rxe_completer(qp);
+	rxe_requester(qp);
 
-	if (qp->sq.queue) {
-		__rxe_do_task(&qp->comp.task);
-		__rxe_do_task(&qp->req.task);
+	if (qp->rq.queue)
+		rxe_queue_reset(qp->rq.queue);
+	if (qp->sq.queue)
 		rxe_queue_reset(qp->sq.queue);
-	}
 
 	/* cleanup attributes */
 	atomic_set(&qp->ssn, 0);
@@ -521,11 +516,8 @@ static void rxe_qp_reset(struct rxe_qp *qp)
 
 	/* reenable tasks */
 	rxe_enable_task(&qp->resp.task);
-
-	if (qp->sq.queue) {
-		rxe_enable_task(&qp->comp.task);
-		rxe_enable_task(&qp->req.task);
-	}
+	rxe_enable_task(&qp->comp.task);
+	rxe_enable_task(&qp->req.task);
 }
 
 /* drain the send queue */
@@ -543,15 +535,25 @@ static void rxe_qp_drain(struct rxe_qp *qp)
 /* move the qp to the error state */
 void rxe_qp_error(struct rxe_qp *qp)
 {
+	/* stop tasks from running */
+	rxe_disable_task(&qp->resp.task);
+	rxe_disable_task(&qp->comp.task);
+	rxe_disable_task(&qp->req.task);
+
 	qp->req.state = QP_STATE_ERROR;
 	qp->resp.state = QP_STATE_ERROR;
 	qp->comp.state = QP_STATE_ERROR;
 	qp->attr.qp_state = IB_QPS_ERR;
 
 	/* drain work and packet queues */
-	rxe_sched_task(&qp->resp.task);
-	rxe_sched_task(&qp->comp.task);
-	rxe_sched_task(&qp->req.task);
+	rxe_responder(qp);
+	rxe_completer(qp);
+	rxe_requester(qp);
+
+	/* reenable tasks */
+	rxe_enable_task(&qp->resp.task);
+	rxe_enable_task(&qp->comp.task);
+	rxe_enable_task(&qp->req.task);
 }
 
 /* called by the modify qp verb */
@@ -770,24 +772,20 @@ static void rxe_qp_do_cleanup(struct work_struct *work)
 
 	qp->valid = 0;
 	qp->qp_timeout_jiffies = 0;
-	rxe_cleanup_task(&qp->resp.task);
 
 	if (qp_type(qp) == IB_QPT_RC) {
 		del_timer_sync(&qp->retrans_timer);
 		del_timer_sync(&qp->rnr_nak_timer);
 	}
 
+	rxe_cleanup_task(&qp->resp.task);
 	rxe_cleanup_task(&qp->req.task);
 	rxe_cleanup_task(&qp->comp.task);
 
-	/* flush out any receive wr's or pending requests */
-	if (qp->req.task.func)
-		__rxe_do_task(&qp->req.task);
-
-	if (qp->sq.queue) {
-		__rxe_do_task(&qp->comp.task);
-		__rxe_do_task(&qp->req.task);
-	}
+	/* drain any receive wr's or pending requests */
+	rxe_responder(qp);
+	rxe_completer(qp);
+	rxe_requester(qp);
 
 	if (qp->sq.queue)
 		rxe_queue_cleanup(qp->sq.queue);
diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw/rxe/rxe_task.c
index fcd87114949f..75ec195f4176 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.c
+++ b/drivers/infiniband/sw/rxe/rxe_task.c
@@ -10,19 +10,6 @@
 
 #include "rxe.h"
 
-int __rxe_do_task(struct rxe_task *task)
-
-{
-	int ret;
-
-	while ((ret = task->func(task->arg)) == 0)
-		;
-
-	task->ret = ret;
-
-	return ret;
-}
-
 /*
  * this locking is due to a potential race where
  * a second caller finds the task already running
diff --git a/drivers/infiniband/sw/rxe/rxe_task.h b/drivers/infiniband/sw/rxe/rxe_task.h
index 31963129ff7a..d594468fcf56 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.h
+++ b/drivers/infiniband/sw/rxe/rxe_task.h
@@ -48,12 +48,6 @@ struct rxe_task {
 int rxe_init_task(struct rxe_task *task, void *arg, int (*func)(void *),
 		  enum rxe_task_type type);
 
-/*
- * raw call to func in loop without any checking
- * can call when tasklets are disabled
- */
-int __rxe_do_task(struct rxe_task *task);
-
 void rxe_run_task(struct rxe_task *task);
 
 void rxe_sched_task(struct rxe_task *task);
-- 
2.34.1

