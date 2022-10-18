Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2B2602352
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Oct 2022 06:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiJREgX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Oct 2022 00:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiJREgU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Oct 2022 00:36:20 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D63DA0244
        for <linux-rdma@vger.kernel.org>; Mon, 17 Oct 2022 21:36:18 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id a16-20020a056830101000b006619dba7fd4so6981175otp.12
        for <linux-rdma@vger.kernel.org>; Mon, 17 Oct 2022 21:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k536cdm23n4LIka7KeODZwz+qCdnz3UYNGSBkjqH9DY=;
        b=qvK+46MFcRdV9YREJK/MMODf+L07v1Js+7dQ9EqMxu5T02BjOY7MqQGJx9ebxCWb0P
         X3pXB9I7w4RvmUsTc45xNO4HYJTm1YUJr50TBOSy20WZf3oC9WqP190LkonnHofK1UoJ
         JRS7hI5rWgf3HuP++oj3ZF6zyE2rGwbgwM8+Uq7W/OAm0acnxdewMSGhTt0xtrI/izdF
         wuFyywXjJo4FJt60gMBbujJIuWzt9SjDcoZMWlTaBVfZ9Hu5lPwj/yLh7Gtsk7YjeQwM
         Fw9EBnLrsu/RCPlYXCJCvLV5ygD61HnnAfvS3GDOONiz5/bfwTjYebV7OqSERGWJI7W2
         38Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k536cdm23n4LIka7KeODZwz+qCdnz3UYNGSBkjqH9DY=;
        b=LB8f+O7B/BYCXZJTw1SH3TQMcNxsY0wmXTgr2d5JB4fipgZjK0RbFvrhyHY1rNS4CZ
         CIlmXx1qgphD6Iwps4nHA6xdQ1I+4IxD9fBh+BFs31mpXeo622ubgi65JP27G/4C+YCW
         MR5UnYsuvbucbULRL35UHBxYWJqlVYkYLl2HuW+aRxhDsSecDYGTK/6fypyxqyXrRWeM
         arguVfuk7YHY5P+MWGEoUqA866z8RAhCUYYjSw1/ixPlqzc+hrZ4ZLncEzYLnnpezVfg
         aRCcAPY/sIGOzTdLyD2ugFYd6Pc6wHdQpIQOZSDEvUYSvHocQxw4P55ti6A+Tewg7+mO
         cHnw==
X-Gm-Message-State: ACrzQf17eB/nqvKfJVI5Odq5nihuVI/+0eferakDEyrmxHVIzyGYCQf5
        ypjGFXkeF1ajzLYs9adIykQ=
X-Google-Smtp-Source: AMsMyM6vV2rhxJVKG2K+CP3LOAPTPfxSFzZXwYB3x3L6xX6Nm2MlbrKY08jpQrYzivn2CZLiMWZVfA==
X-Received: by 2002:a05:6830:6002:b0:660:7be2:59b2 with SMTP id bx2-20020a056830600200b006607be259b2mr512323otb.183.1666067777337;
        Mon, 17 Oct 2022 21:36:17 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-290b-8972-ce76-602c.res6.spectrum.com. [2603:8081:140c:1a00:290b:8972:ce76:602c])
        by smtp.googlemail.com with ESMTPSA id e96-20020a9d01e9000000b006618ca5caa0sm5480333ote.78.2022.10.17.21.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 21:36:16 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, matsuda-daisuke@fujitsu.com,
        lizhijian@fujitsu.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        jenny.hack@hpe.com, ian.ziemba@hpe.com
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 03/16] RDMA/rxe: Split rxe_run_task() into two subroutines
Date:   Mon, 17 Oct 2022 23:33:34 -0500
Message-Id: <20221018043345.4033-4-rpearsonhpe@gmail.com>
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

Split rxe_run_task(task, sched) into rxe_run_task(task) and
rxe_sched_task(task).

Signed-off-by: Ian Ziemba <ian.ziemba@hpe.com>
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_comp.c  | 19 +++++++++++--------
 drivers/infiniband/sw/rxe/rxe_net.c   |  4 ++--
 drivers/infiniband/sw/rxe/rxe_qp.c    | 10 +++++-----
 drivers/infiniband/sw/rxe/rxe_req.c   | 10 +++++-----
 drivers/infiniband/sw/rxe/rxe_resp.c  |  5 ++++-
 drivers/infiniband/sw/rxe/rxe_task.c  | 15 ++++++++++-----
 drivers/infiniband/sw/rxe/rxe_task.h  |  7 +++----
 drivers/infiniband/sw/rxe/rxe_verbs.c |  8 ++++----
 8 files changed, 44 insertions(+), 34 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index fb0c008af78c..d2a250123617 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -118,7 +118,7 @@ void retransmit_timer(struct timer_list *t)
 
 	if (qp->valid) {
 		qp->comp.timeout = 1;
-		rxe_run_task(&qp->comp.task, 1);
+		rxe_sched_task(&qp->comp.task);
 	}
 }
 
@@ -132,7 +132,10 @@ void rxe_comp_queue_pkt(struct rxe_qp *qp, struct sk_buff *skb)
 	if (must_sched != 0)
 		rxe_counter_inc(SKB_TO_PKT(skb)->rxe, RXE_CNT_COMPLETER_SCHED);
 
-	rxe_run_task(&qp->comp.task, must_sched);
+	if (must_sched)
+		rxe_sched_task(&qp->comp.task);
+	else
+		rxe_run_task(&qp->comp.task);
 }
 
 static inline enum comp_state get_wqe(struct rxe_qp *qp,
@@ -305,7 +308,7 @@ static inline enum comp_state check_ack(struct rxe_qp *qp,
 					qp->comp.psn = pkt->psn;
 					if (qp->req.wait_psn) {
 						qp->req.wait_psn = 0;
-						rxe_run_task(&qp->req.task, 0);
+						rxe_run_task(&qp->req.task);
 					}
 				}
 				return COMPST_ERROR_RETRY;
@@ -452,7 +455,7 @@ static void do_complete(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 	 */
 	if (qp->req.wait_fence) {
 		qp->req.wait_fence = 0;
-		rxe_run_task(&qp->req.task, 0);
+		rxe_run_task(&qp->req.task);
 	}
 }
 
@@ -466,7 +469,7 @@ static inline enum comp_state complete_ack(struct rxe_qp *qp,
 		if (qp->req.need_rd_atomic) {
 			qp->comp.timeout_retry = 0;
 			qp->req.need_rd_atomic = 0;
-			rxe_run_task(&qp->req.task, 0);
+			rxe_run_task(&qp->req.task);
 		}
 	}
 
@@ -512,7 +515,7 @@ static inline enum comp_state complete_wqe(struct rxe_qp *qp,
 
 		if (qp->req.wait_psn) {
 			qp->req.wait_psn = 0;
-			rxe_run_task(&qp->req.task, 1);
+			rxe_sched_task(&qp->req.task);
 		}
 	}
 
@@ -646,7 +649,7 @@ int rxe_completer(void *arg)
 
 			if (qp->req.wait_psn) {
 				qp->req.wait_psn = 0;
-				rxe_run_task(&qp->req.task, 1);
+				rxe_sched_task(&qp->req.task);
 			}
 
 			state = COMPST_DONE;
@@ -714,7 +717,7 @@ int rxe_completer(void *arg)
 							RXE_CNT_COMP_RETRY);
 					qp->req.need_retry = 1;
 					qp->comp.started_retry = 1;
-					rxe_run_task(&qp->req.task, 0);
+					rxe_run_task(&qp->req.task);
 				}
 				goto done;
 
diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index 35f327b9d4b8..c36cad9c7a66 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -345,7 +345,7 @@ static void rxe_skb_tx_dtor(struct sk_buff *skb)
 
 	if (unlikely(qp->need_req_skb &&
 		     skb_out < RXE_INFLIGHT_SKBS_PER_QP_LOW))
-		rxe_run_task(&qp->req.task, 1);
+		rxe_sched_task(&qp->req.task);
 
 	rxe_put(qp);
 }
@@ -429,7 +429,7 @@ int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
 	if ((qp_type(qp) != IB_QPT_RC) &&
 	    (pkt->mask & RXE_END_MASK)) {
 		pkt->wqe->state = wqe_state_done;
-		rxe_run_task(&qp->comp.task, 1);
+		rxe_sched_task(&qp->comp.task);
 	}
 
 	rxe_counter_inc(rxe, RXE_CNT_SENT_PKTS);
diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index 03bd9f3e9956..3f6d62a80bea 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -536,10 +536,10 @@ static void rxe_qp_drain(struct rxe_qp *qp)
 		if (qp->req.state != QP_STATE_DRAINED) {
 			qp->req.state = QP_STATE_DRAIN;
 			if (qp_type(qp) == IB_QPT_RC)
-				rxe_run_task(&qp->comp.task, 1);
+				rxe_sched_task(&qp->comp.task);
 			else
 				__rxe_do_task(&qp->comp.task);
-			rxe_run_task(&qp->req.task, 1);
+			rxe_sched_task(&qp->req.task);
 		}
 	}
 }
@@ -553,13 +553,13 @@ void rxe_qp_error(struct rxe_qp *qp)
 	qp->attr.qp_state = IB_QPS_ERR;
 
 	/* drain work and packet queues */
-	rxe_run_task(&qp->resp.task, 1);
+	rxe_sched_task(&qp->resp.task);
 
 	if (qp_type(qp) == IB_QPT_RC)
-		rxe_run_task(&qp->comp.task, 1);
+		rxe_sched_task(&qp->comp.task);
 	else
 		__rxe_do_task(&qp->comp.task);
-	rxe_run_task(&qp->req.task, 1);
+	rxe_sched_task(&qp->req.task);
 }
 
 /* called by the modify qp verb */
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index f63771207970..41f1d84f0acb 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -105,7 +105,7 @@ void rnr_nak_timer(struct timer_list *t)
 	/* request a send queue retry */
 	qp->req.need_retry = 1;
 	qp->req.wait_for_rnr_timer = 0;
-	rxe_run_task(&qp->req.task, 1);
+	rxe_sched_task(&qp->req.task);
 }
 
 static struct rxe_send_wqe *req_next_wqe(struct rxe_qp *qp)
@@ -608,7 +608,7 @@ static int rxe_do_local_ops(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 	 * which can lead to a deadlock. So go ahead and complete
 	 * it now.
 	 */
-	rxe_run_task(&qp->comp.task, 1);
+	rxe_sched_task(&qp->comp.task);
 
 	return 0;
 }
@@ -733,7 +733,7 @@ int rxe_requester(void *arg)
 						       qp->req.wqe_index);
 			wqe->state = wqe_state_done;
 			wqe->status = IB_WC_SUCCESS;
-			rxe_run_task(&qp->comp.task, 0);
+			rxe_run_task(&qp->comp.task);
 			goto done;
 		}
 		payload = mtu;
@@ -795,7 +795,7 @@ int rxe_requester(void *arg)
 		rollback_state(wqe, qp, &rollback_wqe, rollback_psn);
 
 		if (err == -EAGAIN) {
-			rxe_run_task(&qp->req.task, 1);
+			rxe_sched_task(&qp->req.task);
 			goto exit;
 		}
 
@@ -817,7 +817,7 @@ int rxe_requester(void *arg)
 	qp->req.wqe_index = queue_next_index(qp->sq.queue, qp->req.wqe_index);
 	wqe->state = wqe_state_error;
 	qp->req.state = QP_STATE_ERROR;
-	rxe_run_task(&qp->comp.task, 0);
+	rxe_run_task(&qp->comp.task);
 exit:
 	ret = -EAGAIN;
 out:
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index ed5a09e86417..2a2a50de51b2 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -91,7 +91,10 @@ void rxe_resp_queue_pkt(struct rxe_qp *qp, struct sk_buff *skb)
 	must_sched = (pkt->opcode == IB_OPCODE_RC_RDMA_READ_REQUEST) ||
 			(skb_queue_len(&qp->req_pkts) > 1);
 
-	rxe_run_task(&qp->resp.task, must_sched);
+	if (must_sched)
+		rxe_sched_task(&qp->resp.task);
+	else
+		rxe_run_task(&qp->resp.task);
 }
 
 static inline enum resp_states get_req(struct rxe_qp *qp,
diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw/rxe/rxe_task.c
index 182d0532a8ab..446ee2c3d381 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.c
+++ b/drivers/infiniband/sw/rxe/rxe_task.c
@@ -127,15 +127,20 @@ void rxe_cleanup_task(struct rxe_task *task)
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
-		rxe_do_task(&task->tasklet);
+	rxe_do_task(&task->tasklet);
+}
+
+void rxe_sched_task(struct rxe_task *task)
+{
+	if (task->destroyed)
+		return;
+
+	tasklet_schedule(&task->tasklet);
 }
 
 void rxe_disable_task(struct rxe_task *task)
diff --git a/drivers/infiniband/sw/rxe/rxe_task.h b/drivers/infiniband/sw/rxe/rxe_task.h
index b3dfd970d1dc..590b1c1d7e7c 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.h
+++ b/drivers/infiniband/sw/rxe/rxe_task.h
@@ -52,10 +52,9 @@ int __rxe_do_task(struct rxe_task *task);
  */
 void rxe_do_task(struct tasklet_struct *t);
 
-/* run a task, else schedule it to run as a tasklet, The decision
- * to run or schedule tasklet is based on the parameter sched.
- */
-void rxe_run_task(struct rxe_task *task, int sched);
+void rxe_run_task(struct rxe_task *task);
+
+void rxe_sched_task(struct rxe_task *task);
 
 /* keep a task from scheduling */
 void rxe_disable_task(struct rxe_task *task);
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 88825edc7dce..f2f82efbaf6d 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -695,9 +695,9 @@ static int rxe_post_send_kernel(struct rxe_qp *qp, const struct ib_send_wr *wr,
 		wr = next;
 	}
 
-	rxe_run_task(&qp->req.task, 1);
+	rxe_sched_task(&qp->req.task);
 	if (unlikely(qp->req.state == QP_STATE_ERROR))
-		rxe_run_task(&qp->comp.task, 1);
+		rxe_sched_task(&qp->comp.task);
 
 	return err;
 }
@@ -719,7 +719,7 @@ static int rxe_post_send(struct ib_qp *ibqp, const struct ib_send_wr *wr,
 
 	if (qp->is_user) {
 		/* Utilize process context to do protocol processing */
-		rxe_run_task(&qp->req.task, 0);
+		rxe_run_task(&qp->req.task);
 		return 0;
 	} else
 		return rxe_post_send_kernel(qp, wr, bad_wr);
@@ -759,7 +759,7 @@ static int rxe_post_recv(struct ib_qp *ibqp, const struct ib_recv_wr *wr,
 	spin_unlock_irqrestore(&rq->producer_lock, flags);
 
 	if (qp->resp.state == QP_STATE_ERROR)
-		rxe_run_task(&qp->resp.task, 1);
+		rxe_sched_task(&qp->resp.task);
 
 err1:
 	return err;
-- 
2.34.1

