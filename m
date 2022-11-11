Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC378625692
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Nov 2022 10:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233541AbiKKJZI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Nov 2022 04:25:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233509AbiKKJZG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Nov 2022 04:25:06 -0500
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com [139.138.36.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44B46AEFA
        for <linux-rdma@vger.kernel.org>; Fri, 11 Nov 2022 01:25:04 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="83748118"
X-IronPort-AV: E=Sophos;i="5.96,156,1665414000"; 
   d="scan'208";a="83748118"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP; 11 Nov 2022 18:23:55 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
        by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id BF348D500B;
        Fri, 11 Nov 2022 18:23:54 +0900 (JST)
Received: from m3004.s.css.fujitsu.com (m3004.s.css.fujitsu.com [10.128.233.124])
        by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id CAEC1F0FD6;
        Fri, 11 Nov 2022 18:23:53 +0900 (JST)
Received: from localhost.localdomain (unknown [10.19.3.107])
        by m3004.s.css.fujitsu.com (Postfix) with ESMTP id 8AD0D20607A2;
        Fri, 11 Nov 2022 18:23:53 +0900 (JST)
From:   Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
To:     linux-rdma@vger.kernel.org, leonro@nvidia.com, jgg@nvidia.com,
        zyjzyj2000@gmail.com
Cc:     nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
        rpearsonhpe@gmail.com, yangx.jy@fujitsu.com, lizhijian@fujitsu.com,
        y-goto@fujitsu.com, Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: [RFC PATCH v2 2/7] RDMA/rxe: Convert the triple tasklets to workqueues
Date:   Fri, 11 Nov 2022 18:22:23 +0900
Message-Id: <cbe38d40a228bb78ba85c0d010b2a10ae28c6c8e.1668157436.git.matsuda-daisuke@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1668157436.git.matsuda-daisuke@fujitsu.com>
References: <cover.1668157436.git.matsuda-daisuke@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In order to implement On-Demand Paging on the rxe driver, triple tasklets
(requester, responder, and completer) must be allowed to sleep so that they
can trigger page fault when pages being accessed are not present.

This patch replaces the tasklets with workqueues, but still allows direct-
call of works from softirq context if it is obvious that MRs are not going
to be accessed and there is no work being processed in the workqueue.

As counterparts to tasklet_disable() and tasklet_enable() are missing for
workqueues, an atomic value is introduced to get works suspended while qp
reset is in progress.

Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
---
 drivers/infiniband/sw/rxe/Makefile    |   2 +-
 drivers/infiniband/sw/rxe/rxe_comp.c  |  42 ++++---
 drivers/infiniband/sw/rxe/rxe_loc.h   |   4 +-
 drivers/infiniband/sw/rxe/rxe_net.c   |   4 +-
 drivers/infiniband/sw/rxe/rxe_param.h |   2 +-
 drivers/infiniband/sw/rxe/rxe_qp.c    |  71 ++++++------
 drivers/infiniband/sw/rxe/rxe_recv.c  |   4 +-
 drivers/infiniband/sw/rxe/rxe_req.c   |  14 +--
 drivers/infiniband/sw/rxe/rxe_resp.c  |  22 ++--
 drivers/infiniband/sw/rxe/rxe_verbs.c |   8 +-
 drivers/infiniband/sw/rxe/rxe_verbs.h |   8 +-
 drivers/infiniband/sw/rxe/rxe_wq.c    | 160 ++++++++++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_wq.h    |  70 +++++++++++
 13 files changed, 329 insertions(+), 82 deletions(-)
 create mode 100644 drivers/infiniband/sw/rxe/rxe_wq.c
 create mode 100644 drivers/infiniband/sw/rxe/rxe_wq.h

diff --git a/drivers/infiniband/sw/rxe/Makefile b/drivers/infiniband/sw/rxe/Makefile
index 5395a581f4bb..358f6b06aa64 100644
--- a/drivers/infiniband/sw/rxe/Makefile
+++ b/drivers/infiniband/sw/rxe/Makefile
@@ -20,6 +20,6 @@ rdma_rxe-y := \
 	rxe_mmap.o \
 	rxe_icrc.o \
 	rxe_mcast.o \
-	rxe_task.o \
+	rxe_wq.o \
 	rxe_net.o \
 	rxe_hw_counters.o
diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index c9170dd99f3a..880305e6e649 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -9,7 +9,7 @@
 #include "rxe.h"
 #include "rxe_loc.h"
 #include "rxe_queue.h"
-#include "rxe_task.h"
+#include "rxe_wq.h"
 
 enum comp_state {
 	COMPST_GET_ACK,
@@ -118,21 +118,37 @@ void retransmit_timer(struct timer_list *t)
 
 	if (qp->valid) {
 		qp->comp.timeout = 1;
-		rxe_run_task(&qp->comp.task, 1);
+		rxe_run_work(&qp->comp.work, 1);
 	}
 }
 
-void rxe_comp_queue_pkt(struct rxe_qp *qp, struct sk_buff *skb)
+void rxe_comp_queue_pkt(struct rxe_pkt_info *pkt, struct sk_buff *skb)
 {
+	struct rxe_qp *qp = pkt->qp;
 	int must_sched;
 
 	skb_queue_tail(&qp->resp_pkts, skb);
 
-	must_sched = skb_queue_len(&qp->resp_pkts) > 1;
+	/* Schedule a workqueue when processing READ and ATOMIC acks.
+	 * In these cases, completer may sleep to access ODP-enabled MRs.
+	 */
+	switch (pkt->opcode) {
+	case IB_OPCODE_RC_RDMA_READ_RESPONSE_FIRST:
+	case IB_OPCODE_RC_RDMA_READ_RESPONSE_LAST:
+	case IB_OPCODE_RC_RDMA_READ_RESPONSE_ONLY:
+	case IB_OPCODE_RC_RDMA_READ_RESPONSE_MIDDLE:
+	case IB_OPCODE_RC_ATOMIC_ACKNOWLEDGE:
+		must_sched = 1;
+		break;
+
+	default:
+		must_sched = skb_queue_len(&qp->resp_pkts) > 1;
+	}
+
 	if (must_sched != 0)
 		rxe_counter_inc(SKB_TO_PKT(skb)->rxe, RXE_CNT_COMPLETER_SCHED);
 
-	rxe_run_task(&qp->comp.task, must_sched);
+	rxe_run_work(&qp->comp.work, must_sched);
 }
 
 static inline enum comp_state get_wqe(struct rxe_qp *qp,
@@ -313,7 +329,7 @@ static inline enum comp_state check_ack(struct rxe_qp *qp,
 					qp->comp.psn = pkt->psn;
 					if (qp->req.wait_psn) {
 						qp->req.wait_psn = 0;
-						rxe_run_task(&qp->req.task, 0);
+						rxe_run_work(&qp->req.work, 0);
 					}
 				}
 				return COMPST_ERROR_RETRY;
@@ -460,7 +476,7 @@ static void do_complete(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 	 */
 	if (qp->req.wait_fence) {
 		qp->req.wait_fence = 0;
-		rxe_run_task(&qp->req.task, 0);
+		rxe_run_work(&qp->req.work, 0);
 	}
 }
 
@@ -474,7 +490,7 @@ static inline enum comp_state complete_ack(struct rxe_qp *qp,
 		if (qp->req.need_rd_atomic) {
 			qp->comp.timeout_retry = 0;
 			qp->req.need_rd_atomic = 0;
-			rxe_run_task(&qp->req.task, 0);
+			rxe_run_work(&qp->req.work, 0);
 		}
 	}
 
@@ -520,7 +536,7 @@ static inline enum comp_state complete_wqe(struct rxe_qp *qp,
 
 		if (qp->req.wait_psn) {
 			qp->req.wait_psn = 0;
-			rxe_run_task(&qp->req.task, 1);
+			rxe_run_work(&qp->req.work, 1);
 		}
 	}
 
@@ -654,7 +670,7 @@ int rxe_completer(void *arg)
 
 			if (qp->req.wait_psn) {
 				qp->req.wait_psn = 0;
-				rxe_run_task(&qp->req.task, 1);
+				rxe_run_work(&qp->req.work, 1);
 			}
 
 			state = COMPST_DONE;
@@ -722,7 +738,7 @@ int rxe_completer(void *arg)
 							RXE_CNT_COMP_RETRY);
 					qp->req.need_retry = 1;
 					qp->comp.started_retry = 1;
-					rxe_run_task(&qp->req.task, 0);
+					rxe_run_work(&qp->req.work, 0);
 				}
 				goto done;
 
@@ -765,8 +781,8 @@ int rxe_completer(void *arg)
 		}
 	}
 
-	/* A non-zero return value will cause rxe_do_task to
-	 * exit its loop and end the tasklet. A zero return
+	/* A non-zero return value will cause rxe_do_work to
+	 * exit its loop and end the work. A zero return
 	 * will continue looping and return to rxe_completer
 	 */
 done:
diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index c2a5c8814a48..993aa6a8003d 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -179,9 +179,9 @@ int rxe_icrc_init(struct rxe_dev *rxe);
 int rxe_icrc_check(struct sk_buff *skb, struct rxe_pkt_info *pkt);
 void rxe_icrc_generate(struct sk_buff *skb, struct rxe_pkt_info *pkt);
 
-void rxe_resp_queue_pkt(struct rxe_qp *qp, struct sk_buff *skb);
+void rxe_resp_queue_pkt(struct rxe_pkt_info *pkt, struct sk_buff *skb);
 
-void rxe_comp_queue_pkt(struct rxe_qp *qp, struct sk_buff *skb);
+void rxe_comp_queue_pkt(struct rxe_pkt_info *pkt, struct sk_buff *skb);
 
 static inline unsigned int wr_opcode_mask(int opcode, struct rxe_qp *qp)
 {
diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index 35f327b9d4b8..4f74341be57a 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -345,7 +345,7 @@ static void rxe_skb_tx_dtor(struct sk_buff *skb)
 
 	if (unlikely(qp->need_req_skb &&
 		     skb_out < RXE_INFLIGHT_SKBS_PER_QP_LOW))
-		rxe_run_task(&qp->req.task, 1);
+		rxe_run_work(&qp->req.work, 1);
 
 	rxe_put(qp);
 }
@@ -429,7 +429,7 @@ int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
 	if ((qp_type(qp) != IB_QPT_RC) &&
 	    (pkt->mask & RXE_END_MASK)) {
 		pkt->wqe->state = wqe_state_done;
-		rxe_run_task(&qp->comp.task, 1);
+		rxe_run_work(&qp->comp.work, 1);
 	}
 
 	rxe_counter_inc(rxe, RXE_CNT_SENT_PKTS);
diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
index 86c7a8bf3cbb..1c0251812fc8 100644
--- a/drivers/infiniband/sw/rxe/rxe_param.h
+++ b/drivers/infiniband/sw/rxe/rxe_param.h
@@ -105,7 +105,7 @@ enum rxe_device_param {
 	RXE_INFLIGHT_SKBS_PER_QP_HIGH	= 64,
 	RXE_INFLIGHT_SKBS_PER_QP_LOW	= 16,
 
-	/* Max number of interations of each tasklet
+	/* Max number of interations of each work
 	 * before yielding the cpu to let other
 	 * work make progress
 	 */
diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index a62bab88415c..defa4dfe1c98 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -13,7 +13,7 @@
 #include "rxe.h"
 #include "rxe_loc.h"
 #include "rxe_queue.h"
-#include "rxe_task.h"
+#include "rxe_wq.h"
 
 static int rxe_qp_chk_cap(struct rxe_dev *rxe, struct ib_qp_cap *cap,
 			  int has_srq)
@@ -172,9 +172,9 @@ static void rxe_qp_init_misc(struct rxe_dev *rxe, struct rxe_qp *qp,
 
 	spin_lock_init(&qp->state_lock);
 
-	spin_lock_init(&qp->req.task.state_lock);
-	spin_lock_init(&qp->resp.task.state_lock);
-	spin_lock_init(&qp->comp.task.state_lock);
+	spin_lock_init(&qp->req.work.state_lock);
+	spin_lock_init(&qp->resp.work.state_lock);
+	spin_lock_init(&qp->comp.work.state_lock);
 
 	spin_lock_init(&qp->sq.sq_lock);
 	spin_lock_init(&qp->rq.producer_lock);
@@ -242,10 +242,10 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
 
 	skb_queue_head_init(&qp->req_pkts);
 
-	rxe_init_task(&qp->req.task, qp,
-		      rxe_requester, "req");
-	rxe_init_task(&qp->comp.task, qp,
-		      rxe_completer, "comp");
+	rxe_init_work(&qp->req.work, qp,
+		      rxe_requester, "rxe_req");
+	rxe_init_work(&qp->comp.work, qp,
+		      rxe_completer, "rxe_comp");
 
 	qp->qp_timeout_jiffies = 0; /* Can't be set for UD/UC in modify_qp */
 	if (init->qp_type == IB_QPT_RC) {
@@ -292,8 +292,8 @@ static int rxe_qp_init_resp(struct rxe_dev *rxe, struct rxe_qp *qp,
 
 	skb_queue_head_init(&qp->resp_pkts);
 
-	rxe_init_task(&qp->resp.task, qp,
-		      rxe_responder, "resp");
+	rxe_init_work(&qp->resp.work, qp,
+		      rxe_responder, "rxe_resp");
 
 	qp->resp.opcode		= OPCODE_NONE;
 	qp->resp.msn		= 0;
@@ -480,14 +480,14 @@ int rxe_qp_chk_attr(struct rxe_dev *rxe, struct rxe_qp *qp,
 /* move the qp to the reset state */
 static void rxe_qp_reset(struct rxe_qp *qp)
 {
-	/* stop tasks from running */
-	rxe_disable_task(&qp->resp.task);
+	/* flush workqueue and stop works from running */
+	rxe_disable_work(&qp->resp.work);
 
 	/* stop request/comp */
 	if (qp->sq.queue) {
 		if (qp_type(qp) == IB_QPT_RC)
-			rxe_disable_task(&qp->comp.task);
-		rxe_disable_task(&qp->req.task);
+			rxe_disable_work(&qp->comp.work);
+		rxe_disable_work(&qp->req.work);
 	}
 
 	/* move qp to the reset state */
@@ -498,11 +498,11 @@ static void rxe_qp_reset(struct rxe_qp *qp)
 	/* let state machines reset themselves drain work and packet queues
 	 * etc.
 	 */
-	__rxe_do_task(&qp->resp.task);
+	__rxe_do_work(&qp->resp.work);
 
 	if (qp->sq.queue) {
-		__rxe_do_task(&qp->comp.task);
-		__rxe_do_task(&qp->req.task);
+		__rxe_do_work(&qp->comp.work);
+		__rxe_do_work(&qp->req.work);
 		rxe_queue_reset(qp->sq.queue);
 	}
 
@@ -525,14 +525,14 @@ static void rxe_qp_reset(struct rxe_qp *qp)
 
 	cleanup_rd_atomic_resources(qp);
 
-	/* reenable tasks */
-	rxe_enable_task(&qp->resp.task);
+	/* reenable workqueue */
+	rxe_enable_work(&qp->resp.work);
 
 	if (qp->sq.queue) {
 		if (qp_type(qp) == IB_QPT_RC)
-			rxe_enable_task(&qp->comp.task);
+			rxe_enable_work(&qp->comp.work);
 
-		rxe_enable_task(&qp->req.task);
+		rxe_enable_work(&qp->req.work);
 	}
 }
 
@@ -543,10 +543,10 @@ static void rxe_qp_drain(struct rxe_qp *qp)
 		if (qp->req.state != QP_STATE_DRAINED) {
 			qp->req.state = QP_STATE_DRAIN;
 			if (qp_type(qp) == IB_QPT_RC)
-				rxe_run_task(&qp->comp.task, 1);
+				rxe_run_work(&qp->comp.work, 1);
 			else
-				__rxe_do_task(&qp->comp.task);
-			rxe_run_task(&qp->req.task, 1);
+				__rxe_do_work(&qp->comp.work);
+			rxe_run_work(&qp->req.work, 1);
 		}
 	}
 }
@@ -560,13 +560,13 @@ void rxe_qp_error(struct rxe_qp *qp)
 	qp->attr.qp_state = IB_QPS_ERR;
 
 	/* drain work and packet queues */
-	rxe_run_task(&qp->resp.task, 1);
+	rxe_run_work(&qp->resp.work, 1);
 
 	if (qp_type(qp) == IB_QPT_RC)
-		rxe_run_task(&qp->comp.task, 1);
+		rxe_run_work(&qp->comp.work, 1);
 	else
-		__rxe_do_task(&qp->comp.task);
-	rxe_run_task(&qp->req.task, 1);
+		__rxe_do_work(&qp->comp.work);
+	rxe_run_work(&qp->req.work, 1);
 }
 
 /* called by the modify qp verb */
@@ -785,23 +785,24 @@ static void rxe_qp_do_cleanup(struct work_struct *work)
 
 	qp->valid = 0;
 	qp->qp_timeout_jiffies = 0;
-	rxe_cleanup_task(&qp->resp.task);
+	rxe_cleanup_work(&qp->resp.work);
 
 	if (qp_type(qp) == IB_QPT_RC) {
 		del_timer_sync(&qp->retrans_timer);
 		del_timer_sync(&qp->rnr_nak_timer);
 	}
 
-	rxe_cleanup_task(&qp->req.task);
-	rxe_cleanup_task(&qp->comp.task);
+	rxe_cleanup_work(&qp->req.work);
+	rxe_cleanup_work(&qp->comp.work);
 
 	/* flush out any receive wr's or pending requests */
-	if (qp->req.task.func)
-		__rxe_do_task(&qp->req.task);
+
+	if (qp->req.work.func)
+		__rxe_do_work(&qp->req.work);
 
 	if (qp->sq.queue) {
-		__rxe_do_task(&qp->comp.task);
-		__rxe_do_task(&qp->req.task);
+		__rxe_do_work(&qp->comp.work);
+		__rxe_do_work(&qp->req.work);
 	}
 
 	if (qp->sq.queue)
diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
index 434a693cd4a5..01d07572a56f 100644
--- a/drivers/infiniband/sw/rxe/rxe_recv.c
+++ b/drivers/infiniband/sw/rxe/rxe_recv.c
@@ -174,9 +174,9 @@ static int hdr_check(struct rxe_pkt_info *pkt)
 static inline void rxe_rcv_pkt(struct rxe_pkt_info *pkt, struct sk_buff *skb)
 {
 	if (pkt->mask & RXE_REQ_MASK)
-		rxe_resp_queue_pkt(pkt->qp, skb);
+		rxe_resp_queue_pkt(pkt, skb);
 	else
-		rxe_comp_queue_pkt(pkt->qp, skb);
+		rxe_comp_queue_pkt(pkt, skb);
 }
 
 static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index f63771207970..bd05dd3de499 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -105,7 +105,7 @@ void rnr_nak_timer(struct timer_list *t)
 	/* request a send queue retry */
 	qp->req.need_retry = 1;
 	qp->req.wait_for_rnr_timer = 0;
-	rxe_run_task(&qp->req.task, 1);
+	rxe_run_work(&qp->req.work, 1);
 }
 
 static struct rxe_send_wqe *req_next_wqe(struct rxe_qp *qp)
@@ -608,7 +608,7 @@ static int rxe_do_local_ops(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 	 * which can lead to a deadlock. So go ahead and complete
 	 * it now.
 	 */
-	rxe_run_task(&qp->comp.task, 1);
+	rxe_run_work(&qp->comp.work, 1);
 
 	return 0;
 }
@@ -733,7 +733,7 @@ int rxe_requester(void *arg)
 						       qp->req.wqe_index);
 			wqe->state = wqe_state_done;
 			wqe->status = IB_WC_SUCCESS;
-			rxe_run_task(&qp->comp.task, 0);
+			rxe_run_work(&qp->comp.work, 0);
 			goto done;
 		}
 		payload = mtu;
@@ -795,7 +795,7 @@ int rxe_requester(void *arg)
 		rollback_state(wqe, qp, &rollback_wqe, rollback_psn);
 
 		if (err == -EAGAIN) {
-			rxe_run_task(&qp->req.task, 1);
+			rxe_run_work(&qp->req.work, 1);
 			goto exit;
 		}
 
@@ -805,8 +805,8 @@ int rxe_requester(void *arg)
 
 	update_state(qp, &pkt);
 
-	/* A non-zero return value will cause rxe_do_task to
-	 * exit its loop and end the tasklet. A zero return
+	/* A non-zero return value will cause rxe_do_work to
+	 * exit its loop and end the work. A zero return
 	 * will continue looping and return to rxe_requester
 	 */
 done:
@@ -817,7 +817,7 @@ int rxe_requester(void *arg)
 	qp->req.wqe_index = queue_next_index(qp->sq.queue, qp->req.wqe_index);
 	wqe->state = wqe_state_error;
 	qp->req.state = QP_STATE_ERROR;
-	rxe_run_task(&qp->comp.task, 0);
+	rxe_run_work(&qp->comp.work, 0);
 exit:
 	ret = -EAGAIN;
 out:
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 95d372db934d..91f935d60160 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -81,17 +81,17 @@ static char *resp_state_name[] = {
 };
 
 /* rxe_recv calls here to add a request packet to the input queue */
-void rxe_resp_queue_pkt(struct rxe_qp *qp, struct sk_buff *skb)
+void rxe_resp_queue_pkt(struct rxe_pkt_info *pkt, struct sk_buff *skb)
 {
-	int must_sched;
-	struct rxe_pkt_info *pkt = SKB_TO_PKT(skb);
+	int sched = 1;
 
-	skb_queue_tail(&qp->req_pkts, skb);
-
-	must_sched = (pkt->opcode == IB_OPCODE_RC_RDMA_READ_REQUEST) ||
-			(skb_queue_len(&qp->req_pkts) > 1);
-
-	rxe_run_task(&qp->resp.task, must_sched);
+	/* responder can sleep to access ODP-enabled MRs, Always schedule
+	 * work items for non-zero-byte operations.
+	 */
+	if (unlikely(payload_size(pkt) == 0))
+		sched = 0;
+	skb_queue_tail(&pkt->qp->req_pkts, skb);
+	rxe_run_work(&pkt->qp->resp.work, sched);
 }
 
 static inline enum resp_states get_req(struct rxe_qp *qp,
@@ -1454,8 +1454,8 @@ int rxe_responder(void *arg)
 		}
 	}
 
-	/* A non-zero return value will cause rxe_do_task to
-	 * exit its loop and end the tasklet. A zero return
+	/* A non-zero return value will cause rxe_do_work to
+	 * exit its loop and end the work. A zero return
 	 * will continue looping and return to rxe_responder
 	 */
 done:
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 88825edc7dce..786a3583ac21 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -695,9 +695,9 @@ static int rxe_post_send_kernel(struct rxe_qp *qp, const struct ib_send_wr *wr,
 		wr = next;
 	}
 
-	rxe_run_task(&qp->req.task, 1);
+	rxe_run_work(&qp->req.work, 1);
 	if (unlikely(qp->req.state == QP_STATE_ERROR))
-		rxe_run_task(&qp->comp.task, 1);
+		rxe_run_work(&qp->comp.work, 1);
 
 	return err;
 }
@@ -719,7 +719,7 @@ static int rxe_post_send(struct ib_qp *ibqp, const struct ib_send_wr *wr,
 
 	if (qp->is_user) {
 		/* Utilize process context to do protocol processing */
-		rxe_run_task(&qp->req.task, 0);
+		rxe_run_work(&qp->req.work, 0);
 		return 0;
 	} else
 		return rxe_post_send_kernel(qp, wr, bad_wr);
@@ -759,7 +759,7 @@ static int rxe_post_recv(struct ib_qp *ibqp, const struct ib_recv_wr *wr,
 	spin_unlock_irqrestore(&rq->producer_lock, flags);
 
 	if (qp->resp.state == QP_STATE_ERROR)
-		rxe_run_task(&qp->resp.task, 1);
+		rxe_run_work(&qp->resp.work, 1);
 
 err1:
 	return err;
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 22a299b0a9f0..60d0cdb5465a 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -10,7 +10,7 @@
 #include <linux/interrupt.h>
 #include <linux/workqueue.h>
 #include "rxe_pool.h"
-#include "rxe_task.h"
+#include "rxe_wq.h"
 #include "rxe_hw_counters.h"
 
 static inline int pkey_match(u16 key1, u16 key2)
@@ -125,7 +125,7 @@ struct rxe_req_info {
 	int			need_retry;
 	int			wait_for_rnr_timer;
 	int			noack_pkts;
-	struct rxe_task		task;
+	struct rxe_work		work;
 };
 
 struct rxe_comp_info {
@@ -137,7 +137,7 @@ struct rxe_comp_info {
 	int			started_retry;
 	u32			retry_cnt;
 	u32			rnr_retry;
-	struct rxe_task		task;
+	struct rxe_work		work;
 };
 
 enum rdatm_res_state {
@@ -204,7 +204,7 @@ struct rxe_resp_info {
 	unsigned int		res_head;
 	unsigned int		res_tail;
 	struct resp_res		*res;
-	struct rxe_task		task;
+	struct rxe_work		work;
 };
 
 struct rxe_qp {
diff --git a/drivers/infiniband/sw/rxe/rxe_wq.c b/drivers/infiniband/sw/rxe/rxe_wq.c
new file mode 100644
index 000000000000..d976fb413396
--- /dev/null
+++ b/drivers/infiniband/sw/rxe/rxe_wq.c
@@ -0,0 +1,160 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/*
+ * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
+ * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
+ */
+
+#include <linux/kernel.h>
+#include <linux/interrupt.h>
+#include <linux/hardirq.h>
+
+#include "rxe.h"
+
+int __rxe_do_work(struct rxe_work *work)
+
+{
+	int ret;
+
+	while ((ret = work->func(work->arg)) == 0)
+		;
+
+	work->ret = ret;
+
+	return ret;
+}
+
+/*
+ * this locking is due to a potential race where
+ * a second caller finds the work already running
+ * but looks just after the last call to func
+ */
+void rxe_do_work(struct work_struct *w)
+{
+	int cont;
+	int ret;
+
+	struct rxe_work *work = container_of(w, typeof(*work), work);
+	unsigned int iterations = RXE_MAX_ITERATIONS;
+
+	spin_lock_bh(&work->state_lock);
+	switch (work->state) {
+	case WQ_STATE_START:
+		work->state = WQ_STATE_BUSY;
+		spin_unlock_bh(&work->state_lock);
+		break;
+
+	case WQ_STATE_BUSY:
+		work->state = WQ_STATE_ARMED;
+		fallthrough;
+	case WQ_STATE_ARMED:
+		spin_unlock_bh(&work->state_lock);
+		return;
+
+	default:
+		spin_unlock_bh(&work->state_lock);
+		pr_warn("%s failed with bad state %d\n", __func__, work->state);
+		return;
+	}
+
+	do {
+		cont = 0;
+		ret = work->func(work->arg);
+
+		spin_lock_bh(&work->state_lock);
+		switch (work->state) {
+		case WQ_STATE_BUSY:
+			if (ret) {
+				work->state = WQ_STATE_START;
+			} else if (iterations--) {
+				cont = 1;
+			} else {
+				/* reschedule the work and exit
+				 * the loop to give up the cpu
+				 */
+				queue_work(work->worker, &work->work);
+				work->state = WQ_STATE_START;
+			}
+			break;
+
+		/* someone tried to run the work since the last time we called
+		 * func, so we will call one more time regardless of the
+		 * return value
+		 */
+		case WQ_STATE_ARMED:
+			work->state = WQ_STATE_BUSY;
+			cont = 1;
+			break;
+
+		default:
+			pr_warn("%s failed with bad state %d\n", __func__,
+				work->state);
+		}
+		spin_unlock_bh(&work->state_lock);
+	} while (cont);
+
+	work->ret = ret;
+}
+
+int rxe_init_work(struct rxe_work *work,
+		  void *arg, int (*func)(void *), char *name)
+{
+	work->arg	= arg;
+	work->func	= func;
+	snprintf(work->name, sizeof(work->name), "%s", name);
+	work->destroyed	= false;
+	atomic_set(&work->suspended, 0);
+
+	work->worker = create_singlethread_workqueue(name);
+	INIT_WORK(&work->work, rxe_do_work);
+
+	work->state = WQ_STATE_START;
+	spin_lock_init(&work->state_lock);
+
+	return 0;
+}
+
+void rxe_cleanup_work(struct rxe_work *work)
+{
+	bool idle;
+
+	/*
+	 * Mark the work, then wait for it to finish. It might be
+	 * running in a non-workqueue (direct call) context.
+	 */
+	work->destroyed = true;
+	flush_workqueue(work->worker);
+
+	do {
+		spin_lock_bh(&work->state_lock);
+		idle = (work->state == WQ_STATE_START);
+		spin_unlock_bh(&work->state_lock);
+	} while (!idle);
+
+	destroy_workqueue(work->worker);
+}
+
+void rxe_run_work(struct rxe_work *work, int sched)
+{
+	if (work->destroyed)
+		return;
+
+	/* busy-loop while qp reset is in progress */
+	while (atomic_read(&work->suspended))
+		continue;
+
+	if (sched)
+		queue_work(work->worker, &work->work);
+	else
+		rxe_do_work(&work->work);
+}
+
+void rxe_disable_work(struct rxe_work *work)
+{
+	atomic_inc(&work->suspended);
+	flush_workqueue(work->worker);
+}
+
+void rxe_enable_work(struct rxe_work *work)
+{
+	atomic_dec(&work->suspended);
+}
diff --git a/drivers/infiniband/sw/rxe/rxe_wq.h b/drivers/infiniband/sw/rxe/rxe_wq.h
new file mode 100644
index 000000000000..03b5579cf2ca
--- /dev/null
+++ b/drivers/infiniband/sw/rxe/rxe_wq.h
@@ -0,0 +1,70 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/*
+ * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
+ * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
+ */
+
+#ifndef RXE_WQ_H
+#define RXE_WQ_H
+
+enum {
+	WQ_STATE_START	= 0,
+	WQ_STATE_BUSY		= 1,
+	WQ_STATE_ARMED	= 2,
+};
+
+/*
+ * data structure to describe a 'work' which is a short
+ * function that returns 0 as long as it needs to be
+ * called again.
+ */
+struct rxe_work {
+	struct workqueue_struct	*worker;
+	struct work_struct	work;
+	int			state;
+	spinlock_t		state_lock; /* spinlock for work state */
+	void			*arg;
+	int			(*func)(void *arg);
+	int			ret;
+	char			name[16];
+	bool			destroyed;
+	atomic_t		suspended; /* used to {dis,en}able workqueue */
+};
+
+/*
+ * init rxe_work structure
+ *	arg  => parameter to pass to fcn
+ *	func => function to call until it returns != 0
+ */
+int rxe_init_work(struct rxe_work *work,
+		  void *arg, int (*func)(void *), char *name);
+
+/* cleanup work */
+void rxe_cleanup_work(struct rxe_work *work);
+
+/*
+ * raw call to func in loop without any checking
+ * can call when workqueues are suspended.
+ */
+int __rxe_do_work(struct rxe_work *work);
+
+/*
+ * common function called by any of the main workqueues
+ * If there is any chance that there is additional
+ * work to do someone must reschedule the work before
+ * leaving
+ */
+void rxe_do_work(struct work_struct *w);
+
+/* run a work, else schedule it to run as a workqueue, The decision
+ * to run or schedule workqueue is based on the parameter sched.
+ */
+void rxe_run_work(struct rxe_work *work, int sched);
+
+/* keep a work from scheduling */
+void rxe_disable_work(struct rxe_work *work);
+
+/* allow work to run */
+void rxe_enable_work(struct rxe_work *work);
+
+#endif /* RXE_WQ_H */
-- 
2.31.1

