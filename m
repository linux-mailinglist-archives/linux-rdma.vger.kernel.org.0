Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B7A6AABAC
	for <lists+linux-rdma@lfdr.de>; Sat,  4 Mar 2023 18:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjCDRqw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 4 Mar 2023 12:46:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjCDRqv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 4 Mar 2023 12:46:51 -0500
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2DE1BAE1
        for <linux-rdma@vger.kernel.org>; Sat,  4 Mar 2023 09:46:49 -0800 (PST)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-17264e9b575so6754323fac.9
        for <linux-rdma@vger.kernel.org>; Sat, 04 Mar 2023 09:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677952009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jv6kagLBc5L/7qIzPYC6G0WZ1fByyFireELn/eI6LR8=;
        b=eJ67j4YJTl33ZIQayc7XTimUd6/APC4oW/7fzX1x1hz2PlpH9Ye1ty63MSWcJ8/YDq
         fjdQD1eQJtRoK33JRtKxTNjqiceVMi4jAQe/R/tQpMsGScv/VDwsoWPJiCNYxfDWfL+q
         26tdYZvnu/B1pW9iY2o088B2jwO9Zq7GPw4F2R39Q/ulNmmcANChmMSAJIOIquNK0ltX
         RH9N/oueBIMuiMwyusdx3r/J3D083nY1OZOa7BPFLVHOl1tFv5Elxt4zNrlvUcLuJZZd
         EVT2oxWuibnDWTlaeWoRFE5Dll41nXP6mCt0lwZ9OYnzSb+6FMgCEylK5ZdpBst1pCLU
         zacQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677952009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jv6kagLBc5L/7qIzPYC6G0WZ1fByyFireELn/eI6LR8=;
        b=xhkGwcgQiOuW5Wn1ekWPngoNBhprl4VsoOr22uwyPDlT3DynoTDph3DKjxfa17uGzs
         HwbACYzDK4TGuIyD7REgKe47JVGhcTpe41De4fsfDjx46JPJDA4WwE1dnHauc/2dCFst
         ylizOly3gIud12g2JFzURE7o+GC9rvmcy76jfyJcrBj4RtY6E0dU3RPMCyqS8UPaAAhl
         i9B4maS87fGUG6bKbJIzwYTNLMlUPDroXTAGSqZdEUU9d7/WCue2j1p1u6lGEpB+lmLH
         M35V8FV5ywaor/jVTyKgGxfWoDcGiVSCsJP+/gX2RfmxPATgCzqAglfM+5n3ykMo2wfb
         Yo0w==
X-Gm-Message-State: AO0yUKVa/PFcpS752Pa76uuw59UA+tT6eiQUYngsr9uy2WNQaWed+dkr
        jSdjqFbP2b0tyCdwxodid+Z8OYOczxc=
X-Google-Smtp-Source: AK7set8EFxi1cHKzHBxmBu9/LfwTko7o8VJjDefScsXujGxbNawYPEq3BtDCWgk43ArLrlBRpr7E3w==
X-Received: by 2002:a05:6870:8a22:b0:176:2533:2164 with SMTP id p34-20020a0568708a2200b0017625332164mr3919671oaq.42.1677952009003;
        Sat, 04 Mar 2023 09:46:49 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-f848-0c36-f4e0-0517.res6.spectrum.com. [2603:8081:140c:1a00:f848:c36:f4e0:517])
        by smtp.gmail.com with ESMTPSA id a1-20020a056830008100b0068bcadcad5bsm2311227oto.57.2023.03.04.09.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Mar 2023 09:46:48 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, jhack@hpe.com,
        matsuda-daisuke@fujitsu.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        Ian Ziemba <ian.ziemba@hpe.com>
Subject: [PATCH for-next v3 6/8] RDMA/rxe: Remove __rxe_do_task()
Date:   Sat,  4 Mar 2023 11:45:32 -0600
Message-Id: <20230304174533.11296-7-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230304174533.11296-1-rpearsonhpe@gmail.com>
References: <20230304174533.11296-1-rpearsonhpe@gmail.com>
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

