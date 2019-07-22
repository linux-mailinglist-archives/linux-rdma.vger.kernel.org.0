Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5A670356
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jul 2019 17:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbfGVPOl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Jul 2019 11:14:41 -0400
Received: from os.inf.tu-dresden.de ([141.76.48.99]:58286 "EHLO
        os.inf.tu-dresden.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728180AbfGVPOl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Jul 2019 11:14:41 -0400
Received: from [195.176.96.199] (helo=jupiter)
        by os.inf.tu-dresden.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92)
        id 1hpa1M-00089p-E8; Mon, 22 Jul 2019 17:14:36 +0200
From:   Maksym Planeta <mplaneta@os.inf.tu-dresden.de>
To:     Moni Shoua <monis@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Maksym Planeta <mplaneta@os.inf.tu-dresden.de>
Subject: [PATCH 05/10] Fix reference counting for rxe tasklets
Date:   Mon, 22 Jul 2019 17:14:21 +0200
Message-Id: <20190722151426.5266-6-mplaneta@os.inf.tu-dresden.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190722151426.5266-1-mplaneta@os.inf.tu-dresden.de>
References: <20190722151426.5266-1-mplaneta@os.inf.tu-dresden.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Reference should be aquired *before* the tasklet is run. The best time
to increment the reference counter is at initialisation. Otherwise, the
object may not exists anymore by the time tasklet is run.

Signed-off-by: Maksym Planeta <mplaneta@os.inf.tu-dresden.de>
---
 drivers/infiniband/sw/rxe/rxe_comp.c | 4 ----
 drivers/infiniband/sw/rxe/rxe_req.c  | 4 ----
 drivers/infiniband/sw/rxe/rxe_resp.c | 3 ---
 drivers/infiniband/sw/rxe/rxe_task.c | 8 ++++++--
 drivers/infiniband/sw/rxe/rxe_task.h | 2 +-
 5 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index bdeb288673f3..3a1a33286f87 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -557,8 +557,6 @@ int rxe_completer(void *arg)
 	struct rxe_pkt_info *pkt = NULL;
 	enum comp_state state;
 
-	rxe_add_ref(&qp->pelem);
-
 	if (!qp->valid || qp->req.state == QP_STATE_ERROR ||
 	    qp->req.state == QP_STATE_RESET) {
 		rxe_drain_resp_pkts(qp, qp->valid &&
@@ -780,7 +778,6 @@ int rxe_completer(void *arg)
 	 * exit from the loop calling us
 	 */
 	WARN_ON_ONCE(skb);
-	rxe_drop_ref(&qp->pelem);
 	return -EAGAIN;
 
 done:
@@ -788,6 +785,5 @@ int rxe_completer(void *arg)
 	 * us again to see if there is anything else to do
 	 */
 	WARN_ON_ONCE(skb);
-	rxe_drop_ref(&qp->pelem);
 	return 0;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 0d018adbe512..c63e66873757 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -594,8 +594,6 @@ int rxe_requester(void *arg)
 	struct rxe_send_wqe rollback_wqe;
 	u32 rollback_psn;
 
-	rxe_add_ref(&qp->pelem);
-
 next_wqe:
 	if (unlikely(!qp->valid || qp->req.state == QP_STATE_ERROR))
 		goto exit;
@@ -702,7 +700,6 @@ int rxe_requester(void *arg)
 			wqe->state = wqe_state_done;
 			wqe->status = IB_WC_SUCCESS;
 			__rxe_do_task(&qp->comp.task);
-			rxe_drop_ref(&qp->pelem);
 			return 0;
 		}
 		payload = mtu;
@@ -753,6 +750,5 @@ int rxe_requester(void *arg)
 	__rxe_do_task(&qp->comp.task);
 
 exit:
-	rxe_drop_ref(&qp->pelem);
 	return -EAGAIN;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index f038bae1bd70..7be8a362d2ef 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -1212,8 +1212,6 @@ int rxe_responder(void *arg)
 	struct rxe_pkt_info *pkt = NULL;
 	int ret = 0;
 
-	rxe_add_ref(&qp->pelem);
-
 	qp->resp.aeth_syndrome = AETH_ACK_UNLIMITED;
 
 	if (!qp->valid) {
@@ -1392,6 +1390,5 @@ int rxe_responder(void *arg)
 exit:
 	ret = -EAGAIN;
 done:
-	rxe_drop_ref(&qp->pelem);
 	return ret;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw/rxe/rxe_task.c
index 7c2b6e4595f5..9d6b8ad08a3a 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.c
+++ b/drivers/infiniband/sw/rxe/rxe_task.c
@@ -35,6 +35,7 @@
 #include <linux/interrupt.h>
 #include <linux/hardirq.h>
 
+#include "rxe.h"
 #include "rxe_task.h"
 
 int __rxe_do_task(struct rxe_task *task)
@@ -115,14 +116,15 @@ void rxe_do_task(unsigned long data)
 }
 
 int rxe_init_task(void *obj, struct rxe_task *task,
-		  void *arg, int (*func)(void *), char *name)
+		  struct rxe_qp *qp, int (*func)(void *), char *name)
 {
 	task->obj	= obj;
-	task->arg	= arg;
+	task->arg	= qp;
 	task->func	= func;
 	snprintf(task->name, sizeof(task->name), "%s", name);
 	task->destroyed	= false;
 
+	rxe_add_ref(&qp->pelem);
 	tasklet_init(&task->tasklet, rxe_do_task, (unsigned long)task);
 
 	task->state = TASK_STATE_START;
@@ -135,6 +137,7 @@ void rxe_cleanup_task(struct rxe_task *task)
 {
 	unsigned long flags;
 	bool idle;
+	struct rxe_qp *qp = (struct rxe_qp *)task->arg;
 
 	/*
 	 * Mark the task, then wait for it to finish. It might be
@@ -149,6 +152,7 @@ void rxe_cleanup_task(struct rxe_task *task)
 	} while (!idle);
 
 	tasklet_kill(&task->tasklet);
+	rxe_drop_ref(&qp->pelem);
 }
 
 void rxe_run_task(struct rxe_task *task)
diff --git a/drivers/infiniband/sw/rxe/rxe_task.h b/drivers/infiniband/sw/rxe/rxe_task.h
index 5c1fc7d5b953..671b1774b577 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.h
+++ b/drivers/infiniband/sw/rxe/rxe_task.h
@@ -63,7 +63,7 @@ struct rxe_task {
  *	fcn  => function to call until it returns != 0
  */
 int rxe_init_task(void *obj, struct rxe_task *task,
-		  void *arg, int (*func)(void *), char *name);
+		  struct rxe_qp *qp, int (*func)(void *), char *name);
 
 /* cleanup task */
 void rxe_cleanup_task(struct rxe_task *task);
-- 
2.20.1

