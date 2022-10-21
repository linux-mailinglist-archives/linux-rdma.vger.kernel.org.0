Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E23607F74
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Oct 2022 22:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbiJUUC5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Oct 2022 16:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbiJUUCX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Oct 2022 16:02:23 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245322623E3
        for <linux-rdma@vger.kernel.org>; Fri, 21 Oct 2022 13:02:17 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-13af2d12469so4857592fac.13
        for <linux-rdma@vger.kernel.org>; Fri, 21 Oct 2022 13:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NLhGIriOec+yW5+uAGQBdRbRCWaKcwXXxn/8Qw9nAnA=;
        b=Gdb9wfXNftCxxsDuinU58kvGLKUuOrkGzWN6ri5MnRjbkCy+o3Bu8HHogMkjSIQlWw
         aJSZKGRHgknTzT+CaIm0IKYbJppSFKxiN30osk70qYXGAWD9SmH0fRhhl56xgYEs494P
         LxdQEJZAeAzdlCYoLhRtfE9Dv3Hkv9DnVqCOLJHUlU2MSvBm0oNO+Hg2DRKynHmsu1DM
         rt3QL+wzwV2ELBxhbIMhbAzZWklPskcmKTas7LA7BMdCN3c6KqJeN77J/mP8UsHbO+NX
         QmW4mq7f7XjE+sdIuCTwPNkW9VmIfFCJkSQTdrpLy8E3K5e0d7Hiq3NdC6yjIpbc3zeU
         mGkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NLhGIriOec+yW5+uAGQBdRbRCWaKcwXXxn/8Qw9nAnA=;
        b=tXuoKUiySq6zSZY0RzPfgk6N9xLlMDZ4cly79i4dW8Ek4Cv4BkL2IYxHlLrj9k06NM
         2l3ifgzhevmAHOSwXJYKYo/YnXs0Ku71zYKjQW1hT6YzdWvsHRwdsnUznEkKzI7LQCUi
         e3jQWgF2AvJoLET8HkkKA4TDkhkpikqnPnJUaBq2iXhfYBPWxKX7h7F3ENky/03fcDtH
         7jKXbstqcz54NpobDOUlCtCMDNdFaeyTW7xj1NO62utlGoQasfC4E4TpSaSziPHo/9tx
         mbEFSrT2IsimhWxdKuzOYvhErerO/DqZKcO6tebuDDvvUNj0dMBcCb1zgGO5c6X/PHXC
         CK9g==
X-Gm-Message-State: ACrzQf3991gNSmqdTl081jW7+H2WrfgwVGeJGqDGYd7jaAhgvfMtfl9L
        +QlHvrl0FmAFuIqy1ZYYLwQ=
X-Google-Smtp-Source: AMsMyM5RovetoJULFu4i2K4/yv4ZAJ99ZF8ppcp+3QSzd6T9sTRmziHnmDJ2G7C+sFrg/gPQrURH8g==
X-Received: by 2002:a05:6870:d6a3:b0:131:8546:5f5d with SMTP id z35-20020a056870d6a300b0013185465f5dmr14001894oap.216.1666382536321;
        Fri, 21 Oct 2022 13:02:16 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-a860-f1d2-9e17-7593.res6.spectrum.com. [2603:8081:140c:1a00:a860:f1d2:9e17:7593])
        by smtp.googlemail.com with ESMTPSA id s23-20020a056870631700b00132f141ef2dsm10674684oao.56.2022.10.21.13.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 13:02:15 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, leon@kernel.org,
        jhack@hpe.com, ian.ziemba@hpe.com, matsuda-daisuke@fujitsu.com,
        lizhijian@fujitsu.com, haris.phnx@gmail.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 12/18] RDMA/rxe: Remove __rxe_do_task()
Date:   Fri, 21 Oct 2022 15:01:13 -0500
Message-Id: <20221021200118.2163-13-rpearsonhpe@gmail.com>
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
index 8dfbfa164eff..120693c9a795 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.c
+++ b/drivers/infiniband/sw/rxe/rxe_task.c
@@ -6,19 +6,6 @@
 
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

