Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A14B59B2D8
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Aug 2022 10:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiHUItW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 21 Aug 2022 04:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiHUItW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 21 Aug 2022 04:49:22 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA1A2528C
        for <linux-rdma@vger.kernel.org>; Sun, 21 Aug 2022 01:49:20 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6500,9779,10445"; a="276266527"
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="276266527"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2022 01:49:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="637791436"
Received: from unknown (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by orsmga008.jf.intel.com with ESMTP; 21 Aug 2022 01:49:18 -0700
From:   yanjun.zhu@linux.dev
To:     jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org,
        yanjun.zhu@linux.dev, zyjzyj2000@gmail.com
Subject: [PATCH 3/3] RDMA/rxe: Remove the unused variable obj
Date:   Sun, 21 Aug 2022 21:16:15 -0400
Message-Id: <20220822011615.805603-4-yanjun.zhu@linux.dev>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220822011615.805603-1-yanjun.zhu@linux.dev>
References: <20220822011615.805603-1-yanjun.zhu@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=2.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <yanjun.zhu@linux.dev>

The member variable obj in struct rxe_task is not needed.
So remove it to save memory.

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/sw/rxe/rxe_qp.c   | 6 +++---
 drivers/infiniband/sw/rxe/rxe_task.c | 3 +--
 drivers/infiniband/sw/rxe/rxe_task.h | 3 +--
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index b229052ae91a..ee4f7a4a7e01 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -242,9 +242,9 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
 
 	skb_queue_head_init(&qp->req_pkts);
 
-	rxe_init_task(rxe, &qp->req.task, qp,
+	rxe_init_task(&qp->req.task, qp,
 		      rxe_requester, "req");
-	rxe_init_task(rxe, &qp->comp.task, qp,
+	rxe_init_task(&qp->comp.task, qp,
 		      rxe_completer, "comp");
 
 	qp->qp_timeout_jiffies = 0; /* Can't be set for UD/UC in modify_qp */
@@ -292,7 +292,7 @@ static int rxe_qp_init_resp(struct rxe_dev *rxe, struct rxe_qp *qp,
 
 	skb_queue_head_init(&qp->resp_pkts);
 
-	rxe_init_task(rxe, &qp->resp.task, qp,
+	rxe_init_task(&qp->resp.task, qp,
 		      rxe_responder, "resp");
 
 	qp->resp.opcode		= OPCODE_NONE;
diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw/rxe/rxe_task.c
index 2248cf33d776..ec2b7de1c497 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.c
+++ b/drivers/infiniband/sw/rxe/rxe_task.c
@@ -94,10 +94,9 @@ void rxe_do_task(struct tasklet_struct *t)
 	task->ret = ret;
 }
 
-int rxe_init_task(void *obj, struct rxe_task *task,
+int rxe_init_task(struct rxe_task *task,
 		  void *arg, int (*func)(void *), char *name)
 {
-	task->obj	= obj;
 	task->arg	= arg;
 	task->func	= func;
 	snprintf(task->name, sizeof(task->name), "%s", name);
diff --git a/drivers/infiniband/sw/rxe/rxe_task.h b/drivers/infiniband/sw/rxe/rxe_task.h
index 11d183fd3338..7f612a1c68a7 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.h
+++ b/drivers/infiniband/sw/rxe/rxe_task.h
@@ -19,7 +19,6 @@ enum {
  * called again.
  */
 struct rxe_task {
-	void			*obj;
 	struct tasklet_struct	tasklet;
 	int			state;
 	spinlock_t		state_lock; /* spinlock for task state */
@@ -35,7 +34,7 @@ struct rxe_task {
  *	arg  => parameter to pass to fcn
  *	func => function to call until it returns != 0
  */
-int rxe_init_task(void *obj, struct rxe_task *task,
+int rxe_init_task(struct rxe_task *task,
 		  void *arg, int (*func)(void *), char *name);
 
 /* cleanup task */
-- 
2.31.1

