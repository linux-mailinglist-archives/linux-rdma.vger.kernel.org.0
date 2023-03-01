Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF306A6723
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Mar 2023 05:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjCAEww (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Feb 2023 23:52:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjCAEws (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 Feb 2023 23:52:48 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB8338015
        for <linux-rdma@vger.kernel.org>; Tue, 28 Feb 2023 20:52:46 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id bm20so9872529oib.7
        for <linux-rdma@vger.kernel.org>; Tue, 28 Feb 2023 20:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jv6kagLBc5L/7qIzPYC6G0WZ1fByyFireELn/eI6LR8=;
        b=cp3ba4MS1pT7O+ORK67moLm5dMPLCKef9at6iZ0VfgAhIQffB+t9oNel+ajY4w7F30
         sAbMRWeUdP7xeTRI9a7NsnxmJ8gOnUManBFo01ZkKtl/S0tBD+g85Kkj8RgktphxcCLR
         zeWGNmFK0E2RXRKO1bTwmidWuO2Ux+ckj74HngZt+xN+erkVxvyT1JfTvcLRoCErIep1
         kOTqftXhkJX4578SaizaAgv8GokNpUobYJIJZ/JAIEZfe7Lp17hvsFPqxLwouH+Rupnb
         7yC6EBDfCwIUsqyFMPijlngGUUJP2J2z+e6bP+dLxZeRXz1m37q23IJaV8gPnRo7Oqi7
         KroQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jv6kagLBc5L/7qIzPYC6G0WZ1fByyFireELn/eI6LR8=;
        b=KkaUlZ6N8ggeK4cCq1oa6uBIMsVBk+K4Ux+lbNOHHYknq6hopR2WonpJfbIYYmiHfj
         Op6UiSKVvzXDvdMx4ThyjqEFtToCAIRdQiQn/sWKbZGEJL5JyxnPTpLrkuY4xvf6XsjU
         r0a7OIZhHHuVKGFllDDFN7AzDMWlZUfdam90LuvwofAYoVxVYm+QudTc0I13pkXyaVxO
         80AdnrSm6HREledVSSCFYRU91DCUkiG7b7kSRGYFicGzhZNPqnue/58CXVT1qT+Zy3pA
         9mVcVK+k5RI1t28HyzVDMUlU1G7M62HxInvkEg1IR+2cCRdDKgXi2KNRuUqIqsNjT0+x
         nyjQ==
X-Gm-Message-State: AO0yUKURECkWfKDlwgcE6espWOBSiZGld1s0VUzq/d56ZqznaB7t9CrP
        JlnS7KlWNDGUMCms9JfSaw0=
X-Google-Smtp-Source: AK7set8mEJwCsw6KJkwSwxQ5uPVCa7fgA5ZERKGysHuqNwngkzxUT85LzxzsO0lfZ9IjgtSwYlrFqg==
X-Received: by 2002:a05:6808:3c7:b0:384:24d7:cdcd with SMTP id o7-20020a05680803c700b0038424d7cdcdmr2687182oie.50.1677646366029;
        Tue, 28 Feb 2023 20:52:46 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-759b-a469-60fc-ba97.res6.spectrum.com. [2603:8081:140c:1a00:759b:a469:60fc:ba97])
        by smtp.gmail.com with ESMTPSA id ex16-20020a056808299000b0037fcc1fd34bsm5309604oib.13.2023.02.28.20.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 20:52:45 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, jhack@hpe.com,
        matsuda-daisuke@fujitsu.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        Ian Ziemba <ian.ziemba@hpe.com>
Subject: [PATCH for-next v2 6/8] RDMA/rxe: Remove __rxe_do_task()
Date:   Tue, 28 Feb 2023 22:51:53 -0600
Message-Id: <20230301045154.23733-7-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230301045154.23733-1-rpearsonhpe@gmail.com>
References: <20230301045154.23733-1-rpearsonhpe@gmail.com>
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

The subroutine __rxe_do_task is not thread safe and it has
no way to guarantee that the tasks, which are designed
with the assumption that they are non-reentrant, are not
reentered. All of its uses are non-performance critical.

This patch replaces calls to __rxe_do_task with calls to
rxe_sched_task. It also removes irrelevant or unneeded
if tests.

Instead of calling the task machinery a single call to
the tasklet function (rxe_requester, etc.) is sufficient
to draing the queues if task execution has been disabled
or stopped.

Together these changes allow the removal of __rxe_do_task.

Signed-off-by: Ian Ziemba <ian.ziemba@hpe.com>
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_qp.c   | 56 +++++++++-------------------
 drivers/infiniband/sw/rxe/rxe_task.c | 13 -------
 drivers/infiniband/sw/rxe/rxe_task.h |  6 ---
 3 files changed, 17 insertions(+), 58 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index c954dd9394ba..49891f8ed4e6 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -473,29 +473,23 @@ static void rxe_qp_reset(struct rxe_qp *qp)
 {
 	/* stop tasks from running */
 	rxe_disable_task(&qp->resp.task);
-
-	/* stop request/comp */
-	if (qp->sq.queue) {
-		if (qp_type(qp) == IB_QPT_RC)
-			rxe_disable_task(&qp->comp.task);
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
+	/* drain work and packet queuesc */
+	rxe_requester(qp);
+	rxe_completer(qp);
+	rxe_responder(qp);
 
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
@@ -518,13 +512,8 @@ static void rxe_qp_reset(struct rxe_qp *qp)
 
 	/* reenable tasks */
 	rxe_enable_task(&qp->resp.task);
-
-	if (qp->sq.queue) {
-		if (qp_type(qp) == IB_QPT_RC)
-			rxe_enable_task(&qp->comp.task);
-
-		rxe_enable_task(&qp->req.task);
-	}
+	rxe_enable_task(&qp->comp.task);
+	rxe_enable_task(&qp->req.task);
 }
 
 /* drain the send queue */
@@ -533,10 +522,7 @@ static void rxe_qp_drain(struct rxe_qp *qp)
 	if (qp->sq.queue) {
 		if (qp->req.state != QP_STATE_DRAINED) {
 			qp->req.state = QP_STATE_DRAIN;
-			if (qp_type(qp) == IB_QPT_RC)
-				rxe_sched_task(&qp->comp.task);
-			else
-				__rxe_do_task(&qp->comp.task);
+			rxe_sched_task(&qp->comp.task);
 			rxe_sched_task(&qp->req.task);
 		}
 	}
@@ -552,11 +538,7 @@ void rxe_qp_error(struct rxe_qp *qp)
 
 	/* drain work and packet queues */
 	rxe_sched_task(&qp->resp.task);
-
-	if (qp_type(qp) == IB_QPT_RC)
-		rxe_sched_task(&qp->comp.task);
-	else
-		__rxe_do_task(&qp->comp.task);
+	rxe_sched_task(&qp->comp.task);
 	rxe_sched_task(&qp->req.task);
 }
 
@@ -773,24 +755,20 @@ static void rxe_qp_do_cleanup(struct work_struct *work)
 
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
 
 	/* flush out any receive wr's or pending requests */
-	if (qp->req.task.func)
-		__rxe_do_task(&qp->req.task);
-
-	if (qp->sq.queue) {
-		__rxe_do_task(&qp->comp.task);
-		__rxe_do_task(&qp->req.task);
-	}
+	rxe_requester(qp);
+	rxe_completer(qp);
+	rxe_responder(qp);
 
 	if (qp->sq.queue)
 		rxe_queue_cleanup(qp->sq.queue);
diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw/rxe/rxe_task.c
index 959cc6229a34..a67f48545443 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.c
+++ b/drivers/infiniband/sw/rxe/rxe_task.c
@@ -6,19 +6,6 @@
 
 #include "rxe.h"
 
-int __rxe_do_task(struct rxe_task *task)
-
-{
-	int ret;
-
-	while ((ret = task->func(task->qp)) == 0)
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
index 41efd5fd49b0..99585e40cef9 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.h
+++ b/drivers/infiniband/sw/rxe/rxe_task.h
@@ -39,12 +39,6 @@ int rxe_init_task(struct rxe_task *task, struct rxe_qp *qp,
 /* cleanup task */
 void rxe_cleanup_task(struct rxe_task *task);
 
-/*
- * raw call to func in loop without any checking
- * can call when tasklets are disabled
- */
-int __rxe_do_task(struct rxe_task *task);
-
 void rxe_run_task(struct rxe_task *task);
 
 void rxe_sched_task(struct rxe_task *task);
-- 
2.37.2

