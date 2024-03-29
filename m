Return-Path: <linux-rdma+bounces-1673-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A29F6892019
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Mar 2024 16:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F2921F2822A
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Mar 2024 15:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F0114B07E;
	Fri, 29 Mar 2024 14:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVzg+61Y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31AC14B07A
	for <linux-rdma@vger.kernel.org>; Fri, 29 Mar 2024 14:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711724158; cv=none; b=hXgBrNNEroHVxT9I9hf077dbq23IpVFVJcruzSPLwDFwdd5q6mKekBw7YuXP8rfR2LIdNFIaoGW86ubQcgTW/VCYnblEVyvl7HFBzF9Z+0QRb1mB5wt++Co3/2sERg1+OYlgsZZLlwXYl4TvUE3h9mf+75POABv7WveZryDAGdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711724158; c=relaxed/simple;
	bh=t50X/6Tszd41e46zl3EW21Kgj0HeSS3Z6HC8xX/f1eY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UVhn9XSpUY1Vg/H4Fq4MRVJ/9oIsXoAPNCTF2AeK6PME/pyX0TGaj5EKl3FoTflDNVrHYSSyxJRvifcmelCx/W6WCVKP6tDBDoUtF6yfaBpSOD4RTccgNFO/vEnR/Glo9j7vLHnNFdUZZIhJnqsJsyT0IlI/Gso1mmoYmHX7i/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NVzg+61Y; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3c3f3806d88so339978b6e.3
        for <linux-rdma@vger.kernel.org>; Fri, 29 Mar 2024 07:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711724156; x=1712328956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0BiPmDBurHeOCjGjOgWR1zSxn97Z8ryeitoC4oy0wck=;
        b=NVzg+61YccljpDjjNwklEjdR07fZbVmMcHlAZ2JF7SwFXWVZI5XcSjoc3bCgnglM4Z
         Q7GHVjDztdg0OLJ/gkXSkn7kzr+5eNnD+u3qxuy/1TKPTtrWFcZDVh4GgI7aahPrpSsR
         UE6IYq7qHWr1a7LZHbDrVtiM8AtEcvcyXPD3lnmADdVev8Hb5HIq+IA/MZRddY20WsH+
         xMe3AuopvyytPe9Y4p0IcJucVxcpe02SQk8zIHKeE8qvvDfmcQTeeMKwBQt1LXrgOkND
         FxXiM+9jiE41pdT8HjTv9YzZy2v4sX+MPMigz9YdPv1vDtR+WokcVVajtyJlR2U+T4Xs
         J2cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711724156; x=1712328956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0BiPmDBurHeOCjGjOgWR1zSxn97Z8ryeitoC4oy0wck=;
        b=enuzejmwXl4mHZWosdMzVs3GfllrXgiSp1UtQ4tAEPQFhkgcKAwmmgexT8Bf8dRk56
         aDQaPWQI5Va46QtBeziC3zuej7mXLRRlprP47JMqq294OaXdOBV7grueilXpB7aaF7TB
         MQOq6+x957cN1FAz3wAPfQkuurihHVFlZc73E/+G1qM64tRyOi4uQR5G8L2+DYDx39XS
         F+nCqgP5vbHMa6HMTBjpRU5QVezqck5TyizW2hyRggtCeE+t7XsDIH+9KgFlafGP30QH
         6AAt/HgmOOOsmG33BmoPeyXwkPHyZgo/6W0KFNwQj8o44YrzobJdt0kAICeuPw9wTYKu
         9GYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGqkOJKjMSe0H2xQem/5tquavDc7JFq/Z2jwS6ieUKifD0OTL/UN+73Rc2XKoJfnldcnGpRHMJFRJIC2bRu+hgHLTh05Il6vrx5Q==
X-Gm-Message-State: AOJu0YzbbhEsSVG/1axq8nmaJpssCQPUcgl/TfEOKxe5UvzWFogg+fAw
	Uui/MR0ky5Y8zfG/eXLuvXlW5K848616V0J7VdxaHJ8FrJmteWxmLleUBPqYyuQ=
X-Google-Smtp-Source: AGHT+IGUYby+qtVbpbqECXP9K+A8eF4tVlaG3UUPxs4n7GM/OO9qWEGFeM/MOcD8SAVfpzhY0ouEYw==
X-Received: by 2002:a05:6870:41c4:b0:22a:a21e:6d74 with SMTP id z4-20020a05687041c400b0022aa21e6d74mr2507729oac.39.1711724155666;
        Fri, 29 Mar 2024 07:55:55 -0700 (PDT)
Received: from bob-pearson-dev.lan (2603-8081-1405-679b-75b6-1a40-9b4e-0264.res6.spectrum.com. [2603:8081:1405:679b:75b6:1a40:9b4e:264])
        by smtp.gmail.com with ESMTPSA id fl9-20020a056870494900b0022a58ffa4a3sm1006249oab.23.2024.03.29.07.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 07:55:55 -0700 (PDT)
From: Bob Pearson <rpearsonhpe@gmail.com>
To: yanjun.zhu@linux.dev,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	jhack@hpe.com
Cc: Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v3 04/12] RDMA/rxe: Merge request and complete tasks
Date: Fri, 29 Mar 2024 09:55:07 -0500
Message-ID: <20240329145513.35381-7-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329145513.35381-2-rpearsonhpe@gmail.com>
References: <20240329145513.35381-2-rpearsonhpe@gmail.com>
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


