Return-Path: <linux-rdma+bounces-1573-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A4188CB2E
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Mar 2024 18:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8521B24EF0
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Mar 2024 17:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBE2208BC;
	Tue, 26 Mar 2024 17:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MzwCGOPt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEB4A95B
	for <linux-rdma@vger.kernel.org>; Tue, 26 Mar 2024 17:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711475081; cv=none; b=BJtHiB/rHhko6mGuNtYQr4gEcBnZJvXFoHOEmyNskE/wSpZiPrrXKF+S6q/cYI7vJe+Un7w19291jd/te8cPAWANHUs7zptEBeykS044yAVGuhHmv/N1JhIXxFJXDV+paJ8YnO1HdXIGnmUdH530AtgjTVHA1Bck5D41qsNzRJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711475081; c=relaxed/simple;
	bh=t50X/6Tszd41e46zl3EW21Kgj0HeSS3Z6HC8xX/f1eY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iMRveeCKnHETcZtPPO/xlPDdETNfqXnUKFIwRwfEuNT9CypzPZZVdqz2u4zpZz6d+8VznM7B1Covmxi8MNkXj41k2eOaq8D9WKzhV5WyJD6s2PAVFt3cfAaGTRiYhbUJxKrdsIUZTNzpisAexEwzMemV2TMgpbGYMdjTXKu2Qm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MzwCGOPt; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5a4789684abso3275469eaf.0
        for <linux-rdma@vger.kernel.org>; Tue, 26 Mar 2024 10:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711475077; x=1712079877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0BiPmDBurHeOCjGjOgWR1zSxn97Z8ryeitoC4oy0wck=;
        b=MzwCGOPtK6nJCnVMY57dqpkeZKCY8oSr8dsLlql8c/8P7I37T0Mc5SwEqJDg3ZYYAV
         hZ2L/9NR9Ced3nIiBT8I7EFPt8MFUpbUpPuMphsuQEgYLc8uKKpgPa/zHHkoMo8w8/K1
         EHpXPLHeOovXNanVUbkjU/nbFvgp0hwR+YlpQ6vUXxFWHHn9D2O3Ba6QxWSL27dZG1XN
         7zAnt7etecqq5p0BS+FKsav4jud086RAYQXBQHQqx7hqCCdX48GVGE5mbZrCZHlT6OuJ
         Vbqa96hwlpZsH7PZqqkCoEBV/nrdItfpMkON6gYJrvRtZPDMgmCdUjqWgeYZt6WbB/UF
         KDSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711475077; x=1712079877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0BiPmDBurHeOCjGjOgWR1zSxn97Z8ryeitoC4oy0wck=;
        b=dJyT42x7jlFFV7fOYxVyJoyGyN7zXOlEJ7DlIyzluj8KQYoMFeSBgfoT8ZLwrnDs4s
         itX61nVejFw3zbgoezZVHJR2k3HO7YXrCUe4gug1f2qTr8iM1dnwqiDzg3qWcZ0id1S9
         Vre2g0JL+JIqRz2ifAZ020+SiJ6GbJMjQrj+VBLnPm0RM4QQeXR90jLrmT5+xk/FHYAA
         zmXucIF5+mRFsr0vo3AwQdssHQIinqg2vI8TJQiu9b1J9pGMIQelj7FUxgX+aMNcI0Pb
         sgG/9pU2c6++5ANfo/XPMPfHQXGGaX3w1uzV0hBJRam8alacZTF8dXSzmfN6sO6gtrCD
         KtgA==
X-Forwarded-Encrypted: i=1; AJvYcCXo5nbZANZrsVRx2Im+HgpRbf60lWj83bVVQ/nvOz/X6kF1eVbWGuHX5mp5oPVOrVOwXxP+3/0vfrDhAcvWWw8TwoLS0672AGhLwA==
X-Gm-Message-State: AOJu0Yxm5FyFp1kiff0eMuRzswS8BAPC/i5Z8gnm/c3zSFv79Iz60XfO
	kaGEmYAMcNMJh0pu3KSSijx/k+Dx+o5dkWn/UFBH83dnkzVpme/A
X-Google-Smtp-Source: AGHT+IF4wEKmY29Fh78KCliB0sblldk6ECalrtqNYRlEyfZBb/Bbfv12IoIi+vCyXC+5ncalycNxog==
X-Received: by 2002:a05:6820:c91:b0:5a5:25b9:dec5 with SMTP id ei17-20020a0568200c9100b005a525b9dec5mr13899617oob.2.1711475076710;
        Tue, 26 Mar 2024 10:44:36 -0700 (PDT)
Received: from bob-pearson-dev.lan (2603-8081-1405-679b-b62e-99ff-fef9-fa2e.res6.spectrum.com. [2603:8081:1405:679b:b62e:99ff:fef9:fa2e])
        by smtp.gmail.com with ESMTPSA id i10-20020a056820138a00b005a53e935171sm1399860oow.35.2024.03.26.10.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 10:44:36 -0700 (PDT)
From: Bob Pearson <rpearsonhpe@gmail.com>
To: yanjun.zhu@linux.dev,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	jhack@hpe.com
Cc: Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 04/11] RDMA/rxe: Merge request and complete tasks
Date: Tue, 26 Mar 2024 12:43:19 -0500
Message-ID: <20240326174325.300849-6-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240326174325.300849-2-rpearsonhpe@gmail.com>
References: <20240326174325.300849-2-rpearsonhpe@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the rxe driver has three work queue tasks per qp.
These are the req.task, comp.task and resp.task which call
rxe_requester(), rxe_completer() and rxe_responder() respectively
directly or on work queues. Each of these subroutines checks to
see if there is work to be performed on the send queue or on the
response packet queue or the request packet queue and will run
until there is no work remaining or yield the cpu and reschedule
itself until there is no work remaining.

This commit combines the req.task and comp.task into a single
send.task and renames the resp.task to the recv.task. The combined
send.task calls rxe_requester() and rxe_completer() serially
and continues until all work on both the send queue and the
response packet queue are done.

In various benchmarks the performance is either improved or
left the same. At high scale there is a significant reduction
in the load on the cpu.

This is the first step in combining these two tasks. Once they are
serialized cross rescheduling of req.task and comp.task
can be more efficiently handled by just letting the send.task
continue to run. This will be done in the next several patches.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_comp.c        | 20 +++++-----
 drivers/infiniband/sw/rxe/rxe_hw_counters.c |  2 +-
 drivers/infiniband/sw/rxe/rxe_hw_counters.h |  2 +-
 drivers/infiniband/sw/rxe/rxe_loc.h         |  3 +-
 drivers/infiniband/sw/rxe/rxe_net.c         |  4 +-
 drivers/infiniband/sw/rxe/rxe_qp.c          | 44 ++++++++-------------
 drivers/infiniband/sw/rxe/rxe_req.c         | 25 ++++++++++--
 drivers/infiniband/sw/rxe/rxe_resp.c        |  6 +--
 drivers/infiniband/sw/rxe/rxe_verbs.c       |  6 +--
 drivers/infiniband/sw/rxe/rxe_verbs.h       |  6 +--
 10 files changed, 63 insertions(+), 55 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index c997b7cbf2a9..ea64a25fe876 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -122,7 +122,7 @@ void retransmit_timer(struct timer_list *t)
 	spin_lock_irqsave(&qp->state_lock, flags);
 	if (qp->valid) {
 		qp->comp.timeout = 1;
-		rxe_sched_task(&qp->comp.task);
+		rxe_sched_task(&qp->send_task);
 	}
 	spin_unlock_irqrestore(&qp->state_lock, flags);
 }
@@ -133,14 +133,14 @@ void rxe_comp_queue_pkt(struct rxe_qp *qp, struct sk_buff *skb)
 
 	must_sched = skb_queue_len(&qp->resp_pkts) > 0;
 	if (must_sched != 0)
-		rxe_counter_inc(SKB_TO_PKT(skb)->rxe, RXE_CNT_COMPLETER_SCHED);
+		rxe_counter_inc(SKB_TO_PKT(skb)->rxe, RXE_CNT_SENDER_SCHED);
 
 	skb_queue_tail(&qp->resp_pkts, skb);
 
 	if (must_sched)
-		rxe_sched_task(&qp->comp.task);
+		rxe_sched_task(&qp->send_task);
 	else
-		rxe_run_task(&qp->comp.task);
+		rxe_run_task(&qp->send_task);
 }
 
 static inline enum comp_state get_wqe(struct rxe_qp *qp,
@@ -325,7 +325,7 @@ static inline enum comp_state check_ack(struct rxe_qp *qp,
 					qp->comp.psn = pkt->psn;
 					if (qp->req.wait_psn) {
 						qp->req.wait_psn = 0;
-						rxe_sched_task(&qp->req.task);
+						rxe_sched_task(&qp->send_task);
 					}
 				}
 				return COMPST_ERROR_RETRY;
@@ -476,7 +476,7 @@ static void do_complete(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 	 */
 	if (qp->req.wait_fence) {
 		qp->req.wait_fence = 0;
-		rxe_sched_task(&qp->req.task);
+		rxe_sched_task(&qp->send_task);
 	}
 }
 
@@ -515,7 +515,7 @@ static inline enum comp_state complete_ack(struct rxe_qp *qp,
 		if (qp->req.need_rd_atomic) {
 			qp->comp.timeout_retry = 0;
 			qp->req.need_rd_atomic = 0;
-			rxe_sched_task(&qp->req.task);
+			rxe_sched_task(&qp->send_task);
 		}
 	}
 
@@ -541,7 +541,7 @@ static inline enum comp_state complete_wqe(struct rxe_qp *qp,
 
 		if (qp->req.wait_psn) {
 			qp->req.wait_psn = 0;
-			rxe_sched_task(&qp->req.task);
+			rxe_sched_task(&qp->send_task);
 		}
 	}
 
@@ -737,7 +737,7 @@ int rxe_completer(struct rxe_qp *qp)
 
 			if (qp->req.wait_psn) {
 				qp->req.wait_psn = 0;
-				rxe_sched_task(&qp->req.task);
+				rxe_sched_task(&qp->send_task);
 			}
 
 			state = COMPST_DONE;
@@ -792,7 +792,7 @@ int rxe_completer(struct rxe_qp *qp)
 							RXE_CNT_COMP_RETRY);
 					qp->req.need_retry = 1;
 					qp->comp.started_retry = 1;
-					rxe_sched_task(&qp->req.task);
+					rxe_sched_task(&qp->send_task);
 				}
 				goto done;
 
diff --git a/drivers/infiniband/sw/rxe/rxe_hw_counters.c b/drivers/infiniband/sw/rxe/rxe_hw_counters.c
index a012522b577a..437917a7d8f2 100644
--- a/drivers/infiniband/sw/rxe/rxe_hw_counters.c
+++ b/drivers/infiniband/sw/rxe/rxe_hw_counters.c
@@ -14,7 +14,7 @@ static const struct rdma_stat_desc rxe_counter_descs[] = {
 	[RXE_CNT_RCV_RNR].name             =  "rcvd_rnr_err",
 	[RXE_CNT_SND_RNR].name             =  "send_rnr_err",
 	[RXE_CNT_RCV_SEQ_ERR].name         =  "rcvd_seq_err",
-	[RXE_CNT_COMPLETER_SCHED].name     =  "ack_deferred",
+	[RXE_CNT_SENDER_SCHED].name        =  "ack_deferred",
 	[RXE_CNT_RETRY_EXCEEDED].name      =  "retry_exceeded_err",
 	[RXE_CNT_RNR_RETRY_EXCEEDED].name  =  "retry_rnr_exceeded_err",
 	[RXE_CNT_COMP_RETRY].name          =  "completer_retry_err",
diff --git a/drivers/infiniband/sw/rxe/rxe_hw_counters.h b/drivers/infiniband/sw/rxe/rxe_hw_counters.h
index 71f4d4fa9dc8..051f9e1c3852 100644
--- a/drivers/infiniband/sw/rxe/rxe_hw_counters.h
+++ b/drivers/infiniband/sw/rxe/rxe_hw_counters.h
@@ -18,7 +18,7 @@ enum rxe_counters {
 	RXE_CNT_RCV_RNR,
 	RXE_CNT_SND_RNR,
 	RXE_CNT_RCV_SEQ_ERR,
-	RXE_CNT_COMPLETER_SCHED,
+	RXE_CNT_SENDER_SCHED,
 	RXE_CNT_RETRY_EXCEEDED,
 	RXE_CNT_RNR_RETRY_EXCEEDED,
 	RXE_CNT_COMP_RETRY,
diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 746110898a0e..ded46119151b 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -164,7 +164,8 @@ void rxe_dealloc(struct ib_device *ib_dev);
 
 int rxe_completer(struct rxe_qp *qp);
 int rxe_requester(struct rxe_qp *qp);
-int rxe_responder(struct rxe_qp *qp);
+int rxe_sender(struct rxe_qp *qp);
+int rxe_receiver(struct rxe_qp *qp);
 
 /* rxe_icrc.c */
 int rxe_icrc_init(struct rxe_dev *rxe);
diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index cd59666158b1..928508558df4 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -351,7 +351,7 @@ static void rxe_skb_tx_dtor(struct sk_buff *skb)
 
 	if (unlikely(qp->need_req_skb &&
 		     skb_out < RXE_INFLIGHT_SKBS_PER_QP_LOW))
-		rxe_sched_task(&qp->req.task);
+		rxe_sched_task(&qp->send_task);
 
 	rxe_put(qp);
 }
@@ -443,7 +443,7 @@ int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
 	if ((qp_type(qp) != IB_QPT_RC) &&
 	    (pkt->mask & RXE_END_MASK)) {
 		pkt->wqe->state = wqe_state_done;
-		rxe_sched_task(&qp->comp.task);
+		rxe_sched_task(&qp->send_task);
 	}
 
 	rxe_counter_inc(rxe, RXE_CNT_SENT_PKTS);
diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index e3589c02013e..c7d99063594b 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -265,8 +265,7 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
 	qp->req.opcode		= -1;
 	qp->comp.opcode		= -1;
 
-	rxe_init_task(&qp->req.task, qp, rxe_requester);
-	rxe_init_task(&qp->comp.task, qp, rxe_completer);
+	rxe_init_task(&qp->send_task, qp, rxe_sender);
 
 	qp->qp_timeout_jiffies = 0; /* Can't be set for UD/UC in modify_qp */
 	if (init->qp_type == IB_QPT_RC) {
@@ -337,7 +336,7 @@ static int rxe_qp_init_resp(struct rxe_dev *rxe, struct rxe_qp *qp,
 			return err;
 	}
 
-	rxe_init_task(&qp->resp.task, qp, rxe_responder);
+	rxe_init_task(&qp->recv_task, qp, rxe_receiver);
 
 	qp->resp.opcode		= OPCODE_NONE;
 	qp->resp.msn		= 0;
@@ -514,14 +513,12 @@ int rxe_qp_chk_attr(struct rxe_dev *rxe, struct rxe_qp *qp,
 static void rxe_qp_reset(struct rxe_qp *qp)
 {
 	/* stop tasks from running */
-	rxe_disable_task(&qp->resp.task);
-	rxe_disable_task(&qp->comp.task);
-	rxe_disable_task(&qp->req.task);
+	rxe_disable_task(&qp->recv_task);
+	rxe_disable_task(&qp->send_task);
 
 	/* drain work and packet queuesc */
-	rxe_requester(qp);
-	rxe_completer(qp);
-	rxe_responder(qp);
+	rxe_sender(qp);
+	rxe_receiver(qp);
 
 	if (qp->rq.queue)
 		rxe_queue_reset(qp->rq.queue);
@@ -548,9 +545,8 @@ static void rxe_qp_reset(struct rxe_qp *qp)
 	cleanup_rd_atomic_resources(qp);
 
 	/* reenable tasks */
-	rxe_enable_task(&qp->resp.task);
-	rxe_enable_task(&qp->comp.task);
-	rxe_enable_task(&qp->req.task);
+	rxe_enable_task(&qp->recv_task);
+	rxe_enable_task(&qp->send_task);
 }
 
 /* move the qp to the error state */
@@ -562,9 +558,8 @@ void rxe_qp_error(struct rxe_qp *qp)
 	qp->attr.qp_state = IB_QPS_ERR;
 
 	/* drain work and packet queues */
-	rxe_sched_task(&qp->resp.task);
-	rxe_sched_task(&qp->comp.task);
-	rxe_sched_task(&qp->req.task);
+	rxe_sched_task(&qp->recv_task);
+	rxe_sched_task(&qp->send_task);
 	spin_unlock_irqrestore(&qp->state_lock, flags);
 }
 
@@ -575,8 +570,7 @@ static void rxe_qp_sqd(struct rxe_qp *qp, struct ib_qp_attr *attr,
 
 	spin_lock_irqsave(&qp->state_lock, flags);
 	qp->attr.sq_draining = 1;
-	rxe_sched_task(&qp->comp.task);
-	rxe_sched_task(&qp->req.task);
+	rxe_sched_task(&qp->send_task);
 	spin_unlock_irqrestore(&qp->state_lock, flags);
 }
 
@@ -821,19 +815,15 @@ static void rxe_qp_do_cleanup(struct work_struct *work)
 		del_timer_sync(&qp->rnr_nak_timer);
 	}
 
-	if (qp->resp.task.func)
-		rxe_cleanup_task(&qp->resp.task);
+	if (qp->recv_task.func)
+		rxe_cleanup_task(&qp->recv_task);
 
-	if (qp->req.task.func)
-		rxe_cleanup_task(&qp->req.task);
-
-	if (qp->comp.task.func)
-		rxe_cleanup_task(&qp->comp.task);
+	if (qp->send_task.func)
+		rxe_cleanup_task(&qp->send_task);
 
 	/* flush out any receive wr's or pending requests */
-	rxe_requester(qp);
-	rxe_completer(qp);
-	rxe_responder(qp);
+	rxe_sender(qp);
+	rxe_receiver(qp);
 
 	if (qp->sq.queue)
 		rxe_queue_cleanup(qp->sq.queue);
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index d8c41fd626a9..31a611ced3c5 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -108,7 +108,7 @@ void rnr_nak_timer(struct timer_list *t)
 		/* request a send queue retry */
 		qp->req.need_retry = 1;
 		qp->req.wait_for_rnr_timer = 0;
-		rxe_sched_task(&qp->req.task);
+		rxe_sched_task(&qp->send_task);
 	}
 	spin_unlock_irqrestore(&qp->state_lock, flags);
 }
@@ -659,7 +659,7 @@ static int rxe_do_local_ops(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 	 * which can lead to a deadlock. So go ahead and complete
 	 * it now.
 	 */
-	rxe_sched_task(&qp->comp.task);
+	rxe_sched_task(&qp->send_task);
 
 	return 0;
 }
@@ -786,7 +786,7 @@ int rxe_requester(struct rxe_qp *qp)
 						       qp->req.wqe_index);
 			wqe->state = wqe_state_done;
 			wqe->status = IB_WC_SUCCESS;
-			rxe_sched_task(&qp->comp.task);
+			rxe_sched_task(&qp->send_task);
 			goto done;
 		}
 		payload = mtu;
@@ -855,7 +855,7 @@ int rxe_requester(struct rxe_qp *qp)
 		 */
 		qp->need_req_skb = 1;
 
-		rxe_sched_task(&qp->req.task);
+		rxe_sched_task(&qp->send_task);
 		goto exit;
 	}
 
@@ -878,3 +878,20 @@ int rxe_requester(struct rxe_qp *qp)
 out:
 	return ret;
 }
+
+int rxe_sender(struct rxe_qp *qp)
+{
+	int req_ret;
+	int comp_ret;
+
+	/* process the send queue */
+	req_ret = rxe_requester(qp);
+
+	/* process the response queue */
+	comp_ret = rxe_completer(qp);
+
+	/* exit the task loop if both requester and completer
+	 * are ready
+	 */
+	return (req_ret && comp_ret) ? -EAGAIN : 0;
+}
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 963382f625d7..3ce7a32b5dcf 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -58,9 +58,9 @@ void rxe_resp_queue_pkt(struct rxe_qp *qp, struct sk_buff *skb)
 			(skb_queue_len(&qp->req_pkts) > 1);
 
 	if (must_sched)
-		rxe_sched_task(&qp->resp.task);
+		rxe_sched_task(&qp->recv_task);
 	else
-		rxe_run_task(&qp->resp.task);
+		rxe_run_task(&qp->recv_task);
 }
 
 static inline enum resp_states get_req(struct rxe_qp *qp,
@@ -1485,7 +1485,7 @@ static void flush_recv_queue(struct rxe_qp *qp, bool notify)
 	qp->resp.wqe = NULL;
 }
 
-int rxe_responder(struct rxe_qp *qp)
+int rxe_receiver(struct rxe_qp *qp)
 {
 	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
 	enum resp_states state;
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 71b0f834030f..d07f7bd3b2ae 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -905,7 +905,7 @@ static int rxe_post_send_kernel(struct rxe_qp *qp,
 
 	/* kickoff processing of any posted wqes */
 	if (good)
-		rxe_sched_task(&qp->req.task);
+		rxe_sched_task(&qp->send_task);
 
 	return err;
 }
@@ -935,7 +935,7 @@ static int rxe_post_send(struct ib_qp *ibqp, const struct ib_send_wr *wr,
 
 	if (qp->is_user) {
 		/* Utilize process context to do protocol processing */
-		rxe_run_task(&qp->req.task);
+		rxe_run_task(&qp->send_task);
 	} else {
 		err = rxe_post_send_kernel(qp, wr, bad_wr);
 		if (err)
@@ -1045,7 +1045,7 @@ static int rxe_post_recv(struct ib_qp *ibqp, const struct ib_recv_wr *wr,
 
 	spin_lock_irqsave(&qp->state_lock, flags);
 	if (qp_state(qp) == IB_QPS_ERR)
-		rxe_sched_task(&qp->resp.task);
+		rxe_sched_task(&qp->recv_task);
 	spin_unlock_irqrestore(&qp->state_lock, flags);
 
 	return err;
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index ccb9d19ffe8a..af8939b8c7a1 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -113,7 +113,6 @@ struct rxe_req_info {
 	int			need_retry;
 	int			wait_for_rnr_timer;
 	int			noack_pkts;
-	struct rxe_task		task;
 };
 
 struct rxe_comp_info {
@@ -124,7 +123,6 @@ struct rxe_comp_info {
 	int			started_retry;
 	u32			retry_cnt;
 	u32			rnr_retry;
-	struct rxe_task		task;
 };
 
 enum rdatm_res_state {
@@ -196,7 +194,6 @@ struct rxe_resp_info {
 	unsigned int		res_head;
 	unsigned int		res_tail;
 	struct resp_res		*res;
-	struct rxe_task		task;
 };
 
 struct rxe_qp {
@@ -229,6 +226,9 @@ struct rxe_qp {
 	struct sk_buff_head	req_pkts;
 	struct sk_buff_head	resp_pkts;
 
+	struct rxe_task		send_task;
+	struct rxe_task		recv_task;
+
 	struct rxe_req_info	req;
 	struct rxe_comp_info	comp;
 	struct rxe_resp_info	resp;
-- 
2.43.0


