Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E23FD70351
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jul 2019 17:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbfGVPOg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Jul 2019 11:14:36 -0400
Received: from os.inf.tu-dresden.de ([141.76.48.99]:58228 "EHLO
        os.inf.tu-dresden.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728124AbfGVPOg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Jul 2019 11:14:36 -0400
Received: from [195.176.96.199] (helo=jupiter)
        by os.inf.tu-dresden.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92)
        id 1hpa1K-00089M-7j; Mon, 22 Jul 2019 17:14:34 +0200
From:   Maksym Planeta <mplaneta@os.inf.tu-dresden.de>
To:     Moni Shoua <monis@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Maksym Planeta <mplaneta@os.inf.tu-dresden.de>
Subject: [PATCH 01/10] Simplify rxe_run_task interface
Date:   Mon, 22 Jul 2019 17:14:17 +0200
Message-Id: <20190722151426.5266-2-mplaneta@os.inf.tu-dresden.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190722151426.5266-1-mplaneta@os.inf.tu-dresden.de>
References: <20190722151426.5266-1-mplaneta@os.inf.tu-dresden.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Make rxe_run_task only schedule tasks and never run them directly.

This simplification will be used in further patches.

Signed-off-by: Maksym Planeta <mplaneta@os.inf.tu-dresden.de>
---
 drivers/infiniband/sw/rxe/rxe_comp.c  | 16 ++++++++--------
 drivers/infiniband/sw/rxe/rxe_loc.h   |  2 +-
 drivers/infiniband/sw/rxe/rxe_net.c   |  2 +-
 drivers/infiniband/sw/rxe/rxe_qp.c    | 10 +++++-----
 drivers/infiniband/sw/rxe/rxe_req.c   |  6 +++---
 drivers/infiniband/sw/rxe/rxe_resp.c  |  8 +-------
 drivers/infiniband/sw/rxe/rxe_task.c  |  7 ++-----
 drivers/infiniband/sw/rxe/rxe_task.h  |  6 +++---
 drivers/infiniband/sw/rxe/rxe_verbs.c |  8 ++++----
 9 files changed, 28 insertions(+), 37 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index 116cafc9afcf..ad09bd9d0a82 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -142,7 +142,7 @@ void retransmit_timer(struct timer_list *t)
 
 	if (qp->valid) {
 		qp->comp.timeout = 1;
-		rxe_run_task(&qp->comp.task, 1);
+		rxe_run_task(&qp->comp.task);
 	}
 }
 
@@ -156,7 +156,7 @@ void rxe_comp_queue_pkt(struct rxe_qp *qp, struct sk_buff *skb)
 	if (must_sched != 0)
 		rxe_counter_inc(SKB_TO_PKT(skb)->rxe, RXE_CNT_COMPLETER_SCHED);
 
-	rxe_run_task(&qp->comp.task, must_sched);
+	rxe_run_task(&qp->comp.task);
 }
 
 static inline enum comp_state get_wqe(struct rxe_qp *qp,
@@ -329,7 +329,7 @@ static inline enum comp_state check_ack(struct rxe_qp *qp,
 					qp->comp.psn = pkt->psn;
 					if (qp->req.wait_psn) {
 						qp->req.wait_psn = 0;
-						rxe_run_task(&qp->req.task, 1);
+						rxe_run_task(&qp->req.task);
 					}
 				}
 				return COMPST_ERROR_RETRY;
@@ -463,7 +463,7 @@ static void do_complete(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 	 */
 	if (qp->req.wait_fence) {
 		qp->req.wait_fence = 0;
-		rxe_run_task(&qp->req.task, 1);
+		rxe_run_task(&qp->req.task);
 	}
 }
 
@@ -479,7 +479,7 @@ static inline enum comp_state complete_ack(struct rxe_qp *qp,
 		if (qp->req.need_rd_atomic) {
 			qp->comp.timeout_retry = 0;
 			qp->req.need_rd_atomic = 0;
-			rxe_run_task(&qp->req.task, 1);
+			rxe_run_task(&qp->req.task);
 		}
 	}
 
@@ -525,7 +525,7 @@ static inline enum comp_state complete_wqe(struct rxe_qp *qp,
 
 		if (qp->req.wait_psn) {
 			qp->req.wait_psn = 0;
-			rxe_run_task(&qp->req.task, 1);
+			rxe_run_task(&qp->req.task);
 		}
 	}
 
@@ -644,7 +644,7 @@ int rxe_completer(void *arg)
 
 			if (qp->req.wait_psn) {
 				qp->req.wait_psn = 0;
-				rxe_run_task(&qp->req.task, 1);
+				rxe_run_task(&qp->req.task);
 			}
 
 			state = COMPST_DONE;
@@ -725,7 +725,7 @@ int rxe_completer(void *arg)
 							RXE_CNT_COMP_RETRY);
 					qp->req.need_retry = 1;
 					qp->comp.started_retry = 1;
-					rxe_run_task(&qp->req.task, 1);
+					rxe_run_task(&qp->req.task);
 				}
 
 				if (pkt) {
diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 775c23becaec..b7159d9d5107 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -277,7 +277,7 @@ static inline int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
 	if ((qp_type(qp) != IB_QPT_RC) &&
 	    (pkt->mask & RXE_END_MASK)) {
 		pkt->wqe->state = wqe_state_done;
-		rxe_run_task(&qp->comp.task, 1);
+		rxe_run_task(&qp->comp.task);
 	}
 
 	rxe_counter_inc(rxe, RXE_CNT_SENT_PKTS);
diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index 5a3474f9351b..e50f19fadcf9 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -414,7 +414,7 @@ static void rxe_skb_tx_dtor(struct sk_buff *skb)
 
 	if (unlikely(qp->need_req_skb &&
 		     skb_out < RXE_INFLIGHT_SKBS_PER_QP_LOW))
-		rxe_run_task(&qp->req.task, 1);
+		rxe_run_task(&qp->req.task);
 
 	rxe_drop_ref(qp);
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index e2c6d1cedf41..623f44f1d1d5 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -560,10 +560,10 @@ static void rxe_qp_drain(struct rxe_qp *qp)
 		if (qp->req.state != QP_STATE_DRAINED) {
 			qp->req.state = QP_STATE_DRAIN;
 			if (qp_type(qp) == IB_QPT_RC)
-				rxe_run_task(&qp->comp.task, 1);
+				rxe_run_task(&qp->comp.task);
 			else
 				__rxe_do_task(&qp->comp.task);
-			rxe_run_task(&qp->req.task, 1);
+			rxe_run_task(&qp->req.task);
 		}
 	}
 }
@@ -576,13 +576,13 @@ void rxe_qp_error(struct rxe_qp *qp)
 	qp->attr.qp_state = IB_QPS_ERR;
 
 	/* drain work and packet queues */
-	rxe_run_task(&qp->resp.task, 1);
+	rxe_run_task(&qp->resp.task);
 
 	if (qp_type(qp) == IB_QPT_RC)
-		rxe_run_task(&qp->comp.task, 1);
+		rxe_run_task(&qp->comp.task);
 	else
 		__rxe_do_task(&qp->comp.task);
-	rxe_run_task(&qp->req.task, 1);
+	rxe_run_task(&qp->req.task);
 }
 
 /* called by the modify qp verb */
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index c5d9b558fa90..a84c0407545b 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -126,7 +126,7 @@ void rnr_nak_timer(struct timer_list *t)
 	struct rxe_qp *qp = from_timer(qp, t, rnr_nak_timer);
 
 	pr_debug("qp#%d rnr nak timer fired\n", qp_num(qp));
-	rxe_run_task(&qp->req.task, 1);
+	rxe_run_task(&qp->req.task);
 }
 
 static struct rxe_send_wqe *req_next_wqe(struct rxe_qp *qp)
@@ -651,7 +651,7 @@ int rxe_requester(void *arg)
 		}
 		if ((wqe->wr.send_flags & IB_SEND_SIGNALED) ||
 		    qp->sq_sig_type == IB_SIGNAL_ALL_WR)
-			rxe_run_task(&qp->comp.task, 1);
+			rxe_run_task(&qp->comp.task);
 		qp->req.wqe_index = next_index(qp->sq.queue,
 						qp->req.wqe_index);
 		goto next_wqe;
@@ -736,7 +736,7 @@ int rxe_requester(void *arg)
 		rollback_state(wqe, qp, &rollback_wqe, rollback_psn);
 
 		if (ret == -EAGAIN) {
-			rxe_run_task(&qp->req.task, 1);
+			rxe_run_task(&qp->req.task);
 			goto exit;
 		}
 
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 1cbfbd98eb22..d4b5535b8517 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -106,15 +106,9 @@ static char *resp_state_name[] = {
 /* rxe_recv calls here to add a request packet to the input queue */
 void rxe_resp_queue_pkt(struct rxe_qp *qp, struct sk_buff *skb)
 {
-	int must_sched;
-	struct rxe_pkt_info *pkt = SKB_TO_PKT(skb);
-
 	skb_queue_tail(&qp->req_pkts, skb);
 
-	must_sched = (pkt->opcode == IB_OPCODE_RC_RDMA_READ_REQUEST) ||
-			(skb_queue_len(&qp->req_pkts) > 1);
-
-	rxe_run_task(&qp->resp.task, must_sched);
+	rxe_run_task(&qp->resp.task);
 }
 
 static inline enum resp_states get_req(struct rxe_qp *qp,
diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw/rxe/rxe_task.c
index 08f05ac5f5d5..7c2b6e4595f5 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.c
+++ b/drivers/infiniband/sw/rxe/rxe_task.c
@@ -151,15 +151,12 @@ void rxe_cleanup_task(struct rxe_task *task)
 	tasklet_kill(&task->tasklet);
 }
 
-void rxe_run_task(struct rxe_task *task, int sched)
+void rxe_run_task(struct rxe_task *task)
 {
 	if (task->destroyed)
 		return;
 
-	if (sched)
-		tasklet_schedule(&task->tasklet);
-	else
-		rxe_do_task((unsigned long)task);
+	tasklet_schedule(&task->tasklet);
 }
 
 void rxe_disable_task(struct rxe_task *task)
diff --git a/drivers/infiniband/sw/rxe/rxe_task.h b/drivers/infiniband/sw/rxe/rxe_task.h
index 08ff42d451c6..5c1fc7d5b953 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.h
+++ b/drivers/infiniband/sw/rxe/rxe_task.h
@@ -82,10 +82,10 @@ int __rxe_do_task(struct rxe_task *task);
  */
 void rxe_do_task(unsigned long data);
 
-/* run a task, else schedule it to run as a tasklet, The decision
- * to run or schedule tasklet is based on the parameter sched.
+/*
+ * schedule task to run as a tasklet.
  */
-void rxe_run_task(struct rxe_task *task, int sched);
+void rxe_run_task(struct rxe_task *task);
 
 /* keep a task from scheduling */
 void rxe_disable_task(struct rxe_task *task);
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 4ebdfcf4d33e..f6b25b409d12 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -708,9 +708,9 @@ static int rxe_post_send_kernel(struct rxe_qp *qp, const struct ib_send_wr *wr,
 		wr = wr->next;
 	}
 
-	rxe_run_task(&qp->req.task, 1);
+	rxe_run_task(&qp->req.task);
 	if (unlikely(qp->req.state == QP_STATE_ERROR))
-		rxe_run_task(&qp->comp.task, 1);
+		rxe_run_task(&qp->comp.task);
 
 	return err;
 }
@@ -732,7 +732,7 @@ static int rxe_post_send(struct ib_qp *ibqp, const struct ib_send_wr *wr,
 
 	if (qp->is_user) {
 		/* Utilize process context to do protocol processing */
-		rxe_run_task(&qp->req.task, 0);
+		rxe_run_task(&qp->req.task);
 		return 0;
 	} else
 		return rxe_post_send_kernel(qp, wr, bad_wr);
@@ -772,7 +772,7 @@ static int rxe_post_recv(struct ib_qp *ibqp, const struct ib_recv_wr *wr,
 	spin_unlock_irqrestore(&rq->producer_lock, flags);
 
 	if (qp->resp.state == QP_STATE_ERROR)
-		rxe_run_task(&qp->resp.task, 1);
+		rxe_run_task(&qp->resp.task);
 
 err1:
 	return err;
-- 
2.20.1

