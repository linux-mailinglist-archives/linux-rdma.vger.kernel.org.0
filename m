Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C08623DAEE5
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jul 2021 00:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhG2Waz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Jul 2021 18:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbhG2Way (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 29 Jul 2021 18:30:54 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB71C061765
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jul 2021 15:30:50 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id f20-20020a9d6c140000b02904bb9756274cso7456061otq.6
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jul 2021 15:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oOukb0xs962PsMTS3nc+Yw6DvUUTdInNpaCNo2Sa+q0=;
        b=W2WV+XgdgdfneRSC4kglGoEdu4h21LCqazAXT877BobpvlCvh3POLX63XhP89/4bKV
         M5D8dMVOv7liO2x95XaEQqCbZbZUMlmQULXC8QWPkMgMAvjQcsfJhvgiAvAZIZGlP5bA
         BDPw+0aq8Hc7JtLcQJq1ecdO13yt13ZAjpQoFqxi6w256fi7lIrlKq+fab6chxHnblZv
         1gK4ZLFu3dZtKhzynfGJrmnUHRW6PKcGk3742PVuj+lOxvBKaaK4D+2W3brFJQUjy/Ma
         zEfj2BAXAARuIJeGTyEgCP11WiL+q1LN9wGulvY8AYacg1RMYK7kJP9VfOEhJejxxoaC
         tkPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oOukb0xs962PsMTS3nc+Yw6DvUUTdInNpaCNo2Sa+q0=;
        b=W5rR+iQatH7FNqzrScZGXEedozfSTXt19XPC1/VmTVsDIUXBp9rvWw1vBjmSlOkOVr
         XT5ezsGjygfk2CfILw+D9zdl1LKNI8sWUOKfPwCdIZPaQwqnDcjPWXbu4edG4jUeXQIt
         zjrQH3+pHUZ0iVC/A2pPXtE9QsehKozMYt0od5RK7fLA1dps+nVrQqXV6OziqpymIfzQ
         n1kwSEYPuXUYqHWS+ZyAEIKSrn2VdHN3Ux3kclthfGAgiDQH/AhtjffSIVPLFxDmeoeD
         Tv7urg7pJpakc/ScS2aucVEDwZoS86mj0BgFTZCWnG1opvnYW+uYRVnVRxY7S/2TvTJR
         8EZQ==
X-Gm-Message-State: AOAM53282Jk8+EmbAHpWqM7M2G0nCym1/SO6zMLWrvENSq4Bo/epvAg5
        LAzuxzZHPKfvh/73ndX2uRw=
X-Google-Smtp-Source: ABdhPJxz0M6B/2WFNG0o6y61zDWFUXwQBJQsSoMtu04PWoYHmRix8SxBMFLQfcjyEnDiK9RCPybkGg==
X-Received: by 2002:a05:6830:1d88:: with SMTP id y8mr4779373oti.95.1627597849871;
        Thu, 29 Jul 2021 15:30:49 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-80ca-c9ae-640f-0f9a.res6.spectrum.com. [2603:8081:140c:1a00:80ca:c9ae:640f:f9a])
        by smtp.gmail.com with ESMTPSA id y52sm770268otb.52.2021.07.29.15.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 15:30:49 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 2/2] RDMA/rxe: Let rdma-core manage CQs and SRQs
Date:   Thu, 29 Jul 2021 17:30:11 -0500
Message-Id: <20210729223010.31007-3-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210729223010.31007-1-rpearsonhpe@gmail.com>
References: <20210729223010.31007-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Currently QP rxe objects hold references to CQs and SRQs which are ref-
counted. This replicates work already done by RDMA core which takes
references to these in the ib QP object which is contained in the rxe
QP object. This patch removes these references from rxe QP and removes
reference counting for them except for alloc and dealloc. It also
adds inline extractor routines which return them from the ib objects
and moves extractors for qp type, status ann num from rxe_loc.h to be
in the same place and adds rxe_ prefix so the names are consistent.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_av.c    |  3 +-
 drivers/infiniband/sw/rxe/rxe_comp.c  | 10 ++--
 drivers/infiniband/sw/rxe/rxe_loc.h   | 15 -----
 drivers/infiniband/sw/rxe/rxe_net.c   |  6 +-
 drivers/infiniband/sw/rxe/rxe_qp.c    | 83 +++++++++------------------
 drivers/infiniband/sw/rxe/rxe_recv.c  |  6 +-
 drivers/infiniband/sw/rxe/rxe_req.c   | 20 +++----
 drivers/infiniband/sw/rxe/rxe_resp.c  | 54 ++++++++---------
 drivers/infiniband/sw/rxe/rxe_verbs.c | 12 ++--
 drivers/infiniband/sw/rxe/rxe_verbs.h | 35 +++++++++--
 10 files changed, 115 insertions(+), 129 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_av.c b/drivers/infiniband/sw/rxe/rxe_av.c
index 0bbaff74476b..46cd7e2d2806 100644
--- a/drivers/infiniband/sw/rxe/rxe_av.c
+++ b/drivers/infiniband/sw/rxe/rxe_av.c
@@ -107,7 +107,8 @@ struct rxe_av *rxe_get_av(struct rxe_pkt_info *pkt)
 	if (!pkt || !pkt->qp)
 		return NULL;
 
-	if (qp_type(pkt->qp) == IB_QPT_RC || qp_type(pkt->qp) == IB_QPT_UC)
+	if (rxe_qp_type(pkt->qp) == IB_QPT_RC ||
+	    rxe_qp_type(pkt->qp) == IB_QPT_UC)
 		return &pkt->qp->pri_av;
 
 	if (!pkt->wqe)
diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index b0294f8df94f..1ccd2deff835 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -403,7 +403,7 @@ static void make_send_cqe(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 		    wqe->wr.opcode == IB_WR_SEND_WITH_IMM)
 			uwc->wc_flags = IB_WC_WITH_IMM;
 		uwc->byte_len		= wqe->dma.length;
-		uwc->qp_num		= qp->ibqp.qp_num;
+		uwc->qp_num		= rxe_qp_num(qp);
 	}
 }
 
@@ -432,7 +432,7 @@ static void do_complete(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 	advance_consumer(qp->sq.queue, QUEUE_TYPE_FROM_CLIENT);
 
 	if (post)
-		rxe_cq_post(qp->scq, &cqe, 0);
+		rxe_cq_post(rxe_qp_scq(qp), &cqe, 0);
 
 	if (wqe->wr.opcode == IB_WR_SEND ||
 	    wqe->wr.opcode == IB_WR_SEND_WITH_IMM ||
@@ -584,7 +584,7 @@ int rxe_completer(void *arg)
 	state = COMPST_GET_ACK;
 
 	while (1) {
-		pr_debug("qp#%d state = %s\n", qp_num(qp),
+		pr_debug("qp#%d state = %s\n", rxe_qp_num(qp),
 			 comp_state_name[state]);
 		switch (state) {
 		case COMPST_GET_ACK:
@@ -666,7 +666,7 @@ int rxe_completer(void *arg)
 			 *     timeouts but try to keep them as few as possible)
 			 * (4) the timeout parameter is set
 			 */
-			if ((qp_type(qp) == IB_QPT_RC) &&
+			if ((rxe_qp_type(qp) == IB_QPT_RC) &&
 			    (qp->req.state == QP_STATE_READY) &&
 			    (psn_compare(qp->req.psn, qp->comp.psn) > 0) &&
 			    qp->qp_timeout_jiffies)
@@ -732,7 +732,7 @@ int rxe_completer(void *arg)
 
 				qp->req.need_retry = 1;
 				pr_debug("qp#%d set rnr nak timer\n",
-					 qp_num(qp));
+					 rxe_qp_num(qp));
 				mod_timer(&qp->rnr_nak_timer,
 					  jiffies + rnrnak_jiffies(aeth_syn(pkt)
 						& ~AETH_TYPE_MASK));
diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 000607f4e40c..de75413fb4d9 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -131,21 +131,6 @@ void rxe_qp_destroy(struct rxe_qp *qp);
 
 void rxe_qp_cleanup(struct rxe_pool_entry *arg);
 
-static inline int qp_num(struct rxe_qp *qp)
-{
-	return qp->ibqp.qp_num;
-}
-
-static inline enum ib_qp_type qp_type(struct rxe_qp *qp)
-{
-	return qp->ibqp.qp_type;
-}
-
-static inline enum ib_qp_state qp_state(struct rxe_qp *qp)
-{
-	return qp->attr.qp_state;
-}
-
 static inline int qp_mtu(struct rxe_qp *qp)
 {
 	if (qp->ibqp.qp_type == IB_QPT_RC || qp->ibqp.qp_type == IB_QPT_UC)
diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index 2cb810cb890a..4f96437a2a8e 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -114,7 +114,7 @@ static struct dst_entry *rxe_find_route(struct net_device *ndev,
 {
 	struct dst_entry *dst = NULL;
 
-	if (qp_type(qp) == IB_QPT_RC)
+	if (rxe_qp_type(qp) == IB_QPT_RC)
 		dst = sk_dst_get(qp->sk->sk);
 
 	if (!dst || !dst_check(dst, qp->dst_cookie)) {
@@ -142,7 +142,7 @@ static struct dst_entry *rxe_find_route(struct net_device *ndev,
 #endif
 		}
 
-		if (dst && (qp_type(qp) == IB_QPT_RC)) {
+		if (dst && (rxe_qp_type(qp) == IB_QPT_RC)) {
 			dst_hold(dst);
 			sk_dst_set(qp->sk->sk, dst);
 		}
@@ -449,7 +449,7 @@ int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
 		return err;
 	}
 
-	if ((qp_type(qp) != IB_QPT_RC) &&
+	if ((rxe_qp_type(qp) != IB_QPT_RC) &&
 	    (pkt->mask & RXE_END_MASK)) {
 		pkt->wqe->state = wqe_state_done;
 		rxe_run_task(&qp->comp.task, 1);
diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index ca8d7da74969..177edf684f2a 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -220,7 +220,7 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
 	 * (0xc000 - 0xffff).
 	 */
 	qp->src_port = RXE_ROCE_V2_SPORT +
-		(hash_32_generic(qp_num(qp), 14) & 0x3fff);
+		(hash_32_generic(rxe_qp_num(qp), 14) & 0x3fff);
 	qp->sq.max_wr		= init->cap.max_send_wr;
 
 	/* These caps are limited by rxe_qp_chk_cap() done by the caller */
@@ -280,14 +280,14 @@ static int rxe_qp_init_resp(struct rxe_dev *rxe, struct rxe_qp *qp,
 	int wqe_size;
 	enum queue_type type;
 
-	if (!qp->srq) {
+	if (!rxe_qp_srq(qp)) {
 		qp->rq.max_wr		= init->cap.max_recv_wr;
 		qp->rq.max_sge		= init->cap.max_recv_sge;
 
 		wqe_size = rcv_wqe_size(qp->rq.max_sge);
 
 		pr_debug("qp#%d max_wr = %d, max_sge = %d, wqe_size = %d\n",
-			 qp_num(qp), qp->rq.max_wr, qp->rq.max_sge, wqe_size);
+			 rxe_qp_num(qp), qp->rq.max_wr, qp->rq.max_sge, wqe_size);
 
 		type = QUEUE_TYPE_FROM_CLIENT;
 		qp->rq.queue = rxe_queue_init(rxe, &qp->rq.max_wr,
@@ -330,18 +330,6 @@ int rxe_qp_from_init(struct rxe_dev *rxe, struct rxe_qp *qp,
 		     struct ib_udata *udata)
 {
 	int err;
-	struct rxe_cq *rcq = to_rcq(init->recv_cq);
-	struct rxe_cq *scq = to_rcq(init->send_cq);
-	struct rxe_srq *srq = init->srq ? to_rsrq(init->srq) : NULL;
-
-	rxe_add_ref(rcq);
-	rxe_add_ref(scq);
-	if (srq)
-		rxe_add_ref(srq);
-
-	qp->rcq			= rcq;
-	qp->scq			= scq;
-	qp->srq			= srq;
 
 	rxe_qp_init_misc(rxe, qp, init);
 
@@ -361,15 +349,6 @@ int rxe_qp_from_init(struct rxe_dev *rxe, struct rxe_qp *qp,
 err2:
 	rxe_queue_cleanup(qp->sq.queue);
 err1:
-	qp->rcq = NULL;
-	qp->scq = NULL;
-	qp->srq = NULL;
-
-	if (srq)
-		rxe_drop_ref(srq);
-	rxe_drop_ref(scq);
-	rxe_drop_ref(rcq);
-
 	return err;
 }
 
@@ -386,14 +365,14 @@ int rxe_qp_to_init(struct rxe_qp *qp, struct ib_qp_init_attr *init)
 	init->cap.max_send_sge		= qp->sq.max_sge;
 	init->cap.max_inline_data	= qp->sq.max_inline;
 
-	if (!qp->srq) {
+	if (!rxe_qp_srq(qp)) {
 		init->cap.max_recv_wr		= qp->rq.max_wr;
 		init->cap.max_recv_sge		= qp->rq.max_sge;
 	}
 
 	init->sq_sig_type		= qp->sq_sig_type;
 
-	init->qp_type			= qp->ibqp.qp_type;
+	init->qp_type			= rxe_qp_type(qp);
 	init->port_num			= 1;
 
 	return 0;
@@ -410,7 +389,7 @@ int rxe_qp_chk_attr(struct rxe_dev *rxe, struct rxe_qp *qp,
 	enum ib_qp_state new_state = (mask & IB_QP_STATE) ?
 					attr->qp_state : cur_state;
 
-	if (!ib_modify_qp_is_ok(cur_state, new_state, qp_type(qp), mask)) {
+	if (!ib_modify_qp_is_ok(cur_state, new_state, rxe_qp_type(qp), mask)) {
 		pr_warn("invalid mask or state for qp\n");
 		goto err1;
 	}
@@ -430,7 +409,8 @@ int rxe_qp_chk_attr(struct rxe_dev *rxe, struct rxe_qp *qp,
 		}
 	}
 
-	if (mask & IB_QP_CAP && rxe_qp_chk_cap(rxe, &attr->cap, !!qp->srq))
+	if (mask & IB_QP_CAP && rxe_qp_chk_cap(rxe, &attr->cap,
+				!!rxe_qp_srq(qp)))
 		goto err1;
 
 	if (mask & IB_QP_AV && rxe_av_chk_attr(rxe, &attr->ah_attr))
@@ -495,7 +475,7 @@ static void rxe_qp_reset(struct rxe_qp *qp)
 
 	/* stop request/comp */
 	if (qp->sq.queue) {
-		if (qp_type(qp) == IB_QPT_RC)
+		if (rxe_qp_type(qp) == IB_QPT_RC)
 			rxe_disable_task(&qp->comp.task);
 		rxe_disable_task(&qp->req.task);
 	}
@@ -537,7 +517,7 @@ static void rxe_qp_reset(struct rxe_qp *qp)
 	rxe_enable_task(&qp->resp.task);
 
 	if (qp->sq.queue) {
-		if (qp_type(qp) == IB_QPT_RC)
+		if (rxe_qp_type(qp) == IB_QPT_RC)
 			rxe_enable_task(&qp->comp.task);
 
 		rxe_enable_task(&qp->req.task);
@@ -550,7 +530,7 @@ static void rxe_qp_drain(struct rxe_qp *qp)
 	if (qp->sq.queue) {
 		if (qp->req.state != QP_STATE_DRAINED) {
 			qp->req.state = QP_STATE_DRAIN;
-			if (qp_type(qp) == IB_QPT_RC)
+			if (rxe_qp_type(qp) == IB_QPT_RC)
 				rxe_run_task(&qp->comp.task, 1);
 			else
 				__rxe_do_task(&qp->comp.task);
@@ -569,7 +549,7 @@ void rxe_qp_error(struct rxe_qp *qp)
 	/* drain work and packet queues */
 	rxe_run_task(&qp->resp.task, 1);
 
-	if (qp_type(qp) == IB_QPT_RC)
+	if (rxe_qp_type(qp) == IB_QPT_RC)
 		rxe_run_task(&qp->comp.task, 1);
 	else
 		__rxe_do_task(&qp->comp.task);
@@ -651,27 +631,27 @@ int rxe_qp_from_attr(struct rxe_qp *qp, struct ib_qp_attr *attr, int mask,
 	if (mask & IB_QP_RETRY_CNT) {
 		qp->attr.retry_cnt = attr->retry_cnt;
 		qp->comp.retry_cnt = attr->retry_cnt;
-		pr_debug("qp#%d set retry count = %d\n", qp_num(qp),
+		pr_debug("qp#%d set retry count = %d\n", rxe_qp_num(qp),
 			 attr->retry_cnt);
 	}
 
 	if (mask & IB_QP_RNR_RETRY) {
 		qp->attr.rnr_retry = attr->rnr_retry;
 		qp->comp.rnr_retry = attr->rnr_retry;
-		pr_debug("qp#%d set rnr retry count = %d\n", qp_num(qp),
+		pr_debug("qp#%d set rnr retry count = %d\n", rxe_qp_num(qp),
 			 attr->rnr_retry);
 	}
 
 	if (mask & IB_QP_RQ_PSN) {
 		qp->attr.rq_psn = (attr->rq_psn & BTH_PSN_MASK);
 		qp->resp.psn = qp->attr.rq_psn;
-		pr_debug("qp#%d set resp psn = 0x%x\n", qp_num(qp),
+		pr_debug("qp#%d set resp psn = 0x%x\n", rxe_qp_num(qp),
 			 qp->resp.psn);
 	}
 
 	if (mask & IB_QP_MIN_RNR_TIMER) {
 		qp->attr.min_rnr_timer = attr->min_rnr_timer;
-		pr_debug("qp#%d set min rnr timer = 0x%x\n", qp_num(qp),
+		pr_debug("qp#%d set min rnr timer = 0x%x\n", rxe_qp_num(qp),
 			 attr->min_rnr_timer);
 	}
 
@@ -679,7 +659,8 @@ int rxe_qp_from_attr(struct rxe_qp *qp, struct ib_qp_attr *attr, int mask,
 		qp->attr.sq_psn = (attr->sq_psn & BTH_PSN_MASK);
 		qp->req.psn = qp->attr.sq_psn;
 		qp->comp.psn = qp->attr.sq_psn;
-		pr_debug("qp#%d set req psn = 0x%x\n", qp_num(qp), qp->req.psn);
+		pr_debug("qp#%d set req psn = 0x%x\n",
+			 rxe_qp_num(qp), qp->req.psn);
 	}
 
 	if (mask & IB_QP_PATH_MIG_STATE)
@@ -693,38 +674,38 @@ int rxe_qp_from_attr(struct rxe_qp *qp, struct ib_qp_attr *attr, int mask,
 
 		switch (attr->qp_state) {
 		case IB_QPS_RESET:
-			pr_debug("qp#%d state -> RESET\n", qp_num(qp));
+			pr_debug("qp#%d state -> RESET\n", rxe_qp_num(qp));
 			rxe_qp_reset(qp);
 			break;
 
 		case IB_QPS_INIT:
-			pr_debug("qp#%d state -> INIT\n", qp_num(qp));
+			pr_debug("qp#%d state -> INIT\n", rxe_qp_num(qp));
 			qp->req.state = QP_STATE_INIT;
 			qp->resp.state = QP_STATE_INIT;
 			break;
 
 		case IB_QPS_RTR:
-			pr_debug("qp#%d state -> RTR\n", qp_num(qp));
+			pr_debug("qp#%d state -> RTR\n", rxe_qp_num(qp));
 			qp->resp.state = QP_STATE_READY;
 			break;
 
 		case IB_QPS_RTS:
-			pr_debug("qp#%d state -> RTS\n", qp_num(qp));
+			pr_debug("qp#%d state -> RTS\n", rxe_qp_num(qp));
 			qp->req.state = QP_STATE_READY;
 			break;
 
 		case IB_QPS_SQD:
-			pr_debug("qp#%d state -> SQD\n", qp_num(qp));
+			pr_debug("qp#%d state -> SQD\n", rxe_qp_num(qp));
 			rxe_qp_drain(qp);
 			break;
 
 		case IB_QPS_SQE:
-			pr_warn("qp#%d state -> SQE !!?\n", qp_num(qp));
+			pr_warn("qp#%d state -> SQE !!?\n", rxe_qp_num(qp));
 			/* Not possible from modify_qp. */
 			break;
 
 		case IB_QPS_ERR:
-			pr_debug("qp#%d state -> ERR\n", qp_num(qp));
+			pr_debug("qp#%d state -> ERR\n", rxe_qp_num(qp));
 			rxe_qp_error(qp);
 			break;
 		}
@@ -745,7 +726,7 @@ int rxe_qp_to_attr(struct rxe_qp *qp, struct ib_qp_attr *attr, int mask)
 	attr->cap.max_send_sge			= qp->sq.max_sge;
 	attr->cap.max_inline_data		= qp->sq.max_inline;
 
-	if (!qp->srq) {
+	if (!rxe_qp_srq(qp)) {
 		attr->cap.max_recv_wr		= qp->rq.max_wr;
 		attr->cap.max_recv_sge		= qp->rq.max_sge;
 	}
@@ -776,7 +757,7 @@ void rxe_qp_destroy(struct rxe_qp *qp)
 	qp->qp_timeout_jiffies = 0;
 	rxe_cleanup_task(&qp->resp.task);
 
-	if (qp_type(qp) == IB_QPT_RC) {
+	if (rxe_qp_type(qp) == IB_QPT_RC) {
 		del_timer_sync(&qp->retrans_timer);
 		del_timer_sync(&qp->rnr_nak_timer);
 	}
@@ -802,23 +783,15 @@ static void rxe_qp_do_cleanup(struct work_struct *work)
 	if (qp->sq.queue)
 		rxe_queue_cleanup(qp->sq.queue);
 
-	if (qp->srq)
-		rxe_drop_ref(qp->srq);
-
 	if (qp->rq.queue)
 		rxe_queue_cleanup(qp->rq.queue);
 
-	if (qp->scq)
-		rxe_drop_ref(qp->scq);
-	if (qp->rcq)
-		rxe_drop_ref(qp->rcq);
-
 	if (qp->resp.mr) {
 		rxe_drop_ref(qp->resp.mr);
 		qp->resp.mr = NULL;
 	}
 
-	if (qp_type(qp) == IB_QPT_RC)
+	if (rxe_qp_type(qp) == IB_QPT_RC)
 		sk_dst_reset(qp->sk->sk);
 
 	free_rd_atomic_resources(qp);
diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
index 6a6cc1fa90e4..8ed4f3bcc779 100644
--- a/drivers/infiniband/sw/rxe/rxe_recv.c
+++ b/drivers/infiniband/sw/rxe/rxe_recv.c
@@ -20,7 +20,7 @@ static int check_type_state(struct rxe_dev *rxe, struct rxe_pkt_info *pkt,
 
 	pkt_type = pkt->opcode & 0xe0;
 
-	switch (qp_type(qp)) {
+	switch (rxe_qp_type(qp)) {
 	case IB_QPT_RC:
 		if (unlikely(pkt_type != IB_OPCODE_RC)) {
 			pr_warn_ratelimited("bad qp type\n");
@@ -90,7 +90,7 @@ static int check_keys(struct rxe_dev *rxe, struct rxe_pkt_info *pkt,
 		goto err1;
 	}
 
-	if (qp_type(qp) == IB_QPT_UD || qp_type(qp) == IB_QPT_GSI) {
+	if (rxe_qp_type(qp) == IB_QPT_UD || rxe_qp_type(qp) == IB_QPT_GSI) {
 		u32 qkey = (qpn == 1) ? GSI_QKEY : qp->attr.qkey;
 
 		if (unlikely(deth_qkey(pkt) != qkey)) {
@@ -112,7 +112,7 @@ static int check_addr(struct rxe_dev *rxe, struct rxe_pkt_info *pkt,
 {
 	struct sk_buff *skb = PKT_TO_SKB(pkt);
 
-	if (qp_type(qp) != IB_QPT_RC && qp_type(qp) != IB_QPT_UC)
+	if (rxe_qp_type(qp) != IB_QPT_RC && rxe_qp_type(qp) != IB_QPT_UC)
 		goto done;
 
 	if (unlikely(pkt->port_num != qp->attr.port_num)) {
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 70a238085abb..3eee4d8dbe48 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -103,7 +103,7 @@ void rnr_nak_timer(struct timer_list *t)
 {
 	struct rxe_qp *qp = from_timer(qp, t, rnr_nak_timer);
 
-	pr_debug("qp#%d rnr nak timer fired\n", qp_num(qp));
+	pr_debug("qp#%d rnr nak timer fired\n", rxe_qp_num(qp));
 	rxe_run_task(&qp->req.task, 1);
 }
 
@@ -304,7 +304,7 @@ static int next_opcode(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 {
 	int fits = (wqe->dma.resid <= qp->mtu);
 
-	switch (qp_type(qp)) {
+	switch (rxe_qp_type(qp)) {
 	case IB_QPT_RC:
 		return next_opcode_rc(qp, opcode, fits);
 
@@ -354,7 +354,7 @@ static inline int get_mtu(struct rxe_qp *qp)
 {
 	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
 
-	if ((qp_type(qp) == IB_QPT_RC) || (qp_type(qp) == IB_QPT_UC))
+	if ((rxe_qp_type(qp) == IB_QPT_RC) || (rxe_qp_type(qp) == IB_QPT_UC))
 		return qp->mtu;
 
 	return rxe->port.mtu_cap;
@@ -443,11 +443,11 @@ static struct sk_buff *init_req_packet(struct rxe_qp *qp,
 	}
 
 	if (pkt->mask & RXE_DETH_MASK) {
-		if (qp->ibqp.qp_num == 1)
+		if (rxe_qp_num(qp) == 1)
 			deth_set_qkey(pkt, GSI_QKEY);
 		else
 			deth_set_qkey(pkt, ibwr->wr.ud.remote_qkey);
-		deth_set_sqp(pkt, qp->ibqp.qp_num);
+		deth_set_sqp(pkt, rxe_qp_num(qp));
 	}
 
 	return skb;
@@ -493,7 +493,7 @@ static void update_wqe_state(struct rxe_qp *qp,
 		struct rxe_pkt_info *pkt)
 {
 	if (pkt->mask & RXE_END_MASK) {
-		if (qp_type(qp) == IB_QPT_RC)
+		if (rxe_qp_type(qp) == IB_QPT_RC)
 			wqe->state = wqe_state_pending;
 	} else {
 		wqe->state = wqe_state_processing;
@@ -661,7 +661,7 @@ int rxe_requester(void *arg)
 			goto next_wqe;
 	}
 
-	if (unlikely(qp_type(qp) == IB_QPT_RC &&
+	if (unlikely(rxe_qp_type(qp) == IB_QPT_RC &&
 		psn_compare(qp->req.psn, (qp->comp.psn +
 				RXE_MAX_UNACKED_PSNS)) > 0)) {
 		qp->req.wait_psn = 1;
@@ -690,7 +690,7 @@ int rxe_requester(void *arg)
 	mtu = get_mtu(qp);
 	payload = (mask & RXE_WRITE_OR_SEND) ? wqe->dma.resid : 0;
 	if (payload > mtu) {
-		if (qp_type(qp) == IB_QPT_UD) {
+		if (rxe_qp_type(qp) == IB_QPT_UD) {
 			/* C10-93.1.1: If the total sum of all the buffer lengths specified for a
 			 * UD message exceeds the MTU of the port as returned by QueryHCA, the CI
 			 * shall not emit any packets for this message. Further, the CI shall not
@@ -715,14 +715,14 @@ int rxe_requester(void *arg)
 
 	skb = init_req_packet(qp, wqe, opcode, payload, &pkt);
 	if (unlikely(!skb)) {
-		pr_err("qp#%d Failed allocating skb\n", qp_num(qp));
+		pr_err("qp#%d Failed allocating skb\n", rxe_qp_num(qp));
 		wqe->status = IB_WC_LOC_QP_OP_ERR;
 		goto err;
 	}
 
 	ret = finish_packet(qp, wqe, &pkt, skb, payload);
 	if (unlikely(ret)) {
-		pr_debug("qp#%d Error during finish packet\n", qp_num(qp));
+		pr_debug("qp#%d Error during finish packet\n", rxe_qp_num(qp));
 		if (ret == -EFAULT)
 			wqe->status = IB_WC_LOC_PROT_ERR;
 		else
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 29b56d52e2c7..399678e49d33 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -123,7 +123,7 @@ static enum resp_states check_psn(struct rxe_qp *qp,
 	int diff = psn_compare(pkt->psn, qp->resp.psn);
 	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
 
-	switch (qp_type(qp)) {
+	switch (rxe_qp_type(qp)) {
 	case IB_QPT_RC:
 		if (diff > 0) {
 			if (qp->resp.sent_psn_nak)
@@ -164,7 +164,7 @@ static enum resp_states check_psn(struct rxe_qp *qp,
 static enum resp_states check_op_seq(struct rxe_qp *qp,
 				     struct rxe_pkt_info *pkt)
 {
-	switch (qp_type(qp)) {
+	switch (rxe_qp_type(qp)) {
 	case IB_QPT_RC:
 		switch (qp->resp.opcode) {
 		case IB_OPCODE_RC_SEND_FIRST:
@@ -254,7 +254,7 @@ static enum resp_states check_op_seq(struct rxe_qp *qp,
 static enum resp_states check_op_valid(struct rxe_qp *qp,
 				       struct rxe_pkt_info *pkt)
 {
-	switch (qp_type(qp)) {
+	switch (rxe_qp_type(qp)) {
 	case IB_QPT_RC:
 		if (((pkt->mask & RXE_READ_MASK) &&
 		     !(qp->attr.qp_access_flags & IB_ACCESS_REMOTE_READ)) ||
@@ -291,7 +291,7 @@ static enum resp_states check_op_valid(struct rxe_qp *qp,
 
 static enum resp_states get_srq_wqe(struct rxe_qp *qp)
 {
-	struct rxe_srq *srq = qp->srq;
+	struct rxe_srq *srq = rxe_qp_srq(qp);
 	struct rxe_queue *q = srq->rq.queue;
 	struct rxe_recv_wqe *wqe;
 	struct ib_event ev;
@@ -342,7 +342,7 @@ static enum resp_states get_srq_wqe(struct rxe_qp *qp)
 static enum resp_states check_resource(struct rxe_qp *qp,
 				       struct rxe_pkt_info *pkt)
 {
-	struct rxe_srq *srq = qp->srq;
+	struct rxe_srq *srq = rxe_qp_srq(qp);
 
 	if (qp->resp.state == QP_STATE_ERROR) {
 		if (qp->resp.wqe) {
@@ -388,7 +388,7 @@ static enum resp_states check_resource(struct rxe_qp *qp,
 static enum resp_states check_length(struct rxe_qp *qp,
 				     struct rxe_pkt_info *pkt)
 {
-	switch (qp_type(qp)) {
+	switch (rxe_qp_type(qp)) {
 	case IB_QPT_RC:
 		return RESPST_CHK_RKEY;
 
@@ -770,9 +770,9 @@ static enum resp_states execute(struct rxe_qp *qp, struct rxe_pkt_info *pkt)
 	union rdma_network_hdr hdr;
 
 	if (pkt->mask & RXE_SEND_MASK) {
-		if (qp_type(qp) == IB_QPT_UD ||
-		    qp_type(qp) == IB_QPT_SMI ||
-		    qp_type(qp) == IB_QPT_GSI) {
+		if (rxe_qp_type(qp) == IB_QPT_UD ||
+		    rxe_qp_type(qp) == IB_QPT_SMI ||
+		    rxe_qp_type(qp) == IB_QPT_GSI) {
 			if (skb->protocol == htons(ETH_P_IP)) {
 				memset(&hdr.reserved, 0,
 						sizeof(hdr.reserved));
@@ -825,7 +825,7 @@ static enum resp_states execute(struct rxe_qp *qp, struct rxe_pkt_info *pkt)
 		/* We successfully processed this new request. */
 		qp->resp.msn++;
 		return RESPST_COMPLETE;
-	} else if (qp_type(qp) == IB_QPT_RC)
+	} else if (rxe_qp_type(qp) == IB_QPT_RC)
 		return RESPST_ACKNOWLEDGE;
 	else
 		return RESPST_CLEANUP;
@@ -845,9 +845,9 @@ static enum resp_states do_complete(struct rxe_qp *qp,
 
 	memset(&cqe, 0, sizeof(cqe));
 
-	if (qp->rcq->is_user) {
+	if (rxe_qp_rcq(qp)->is_user) {
 		uwc->status		= qp->resp.status;
-		uwc->qp_num		= qp->ibqp.qp_num;
+		uwc->qp_num		= rxe_qp_num(qp);
 		uwc->wr_id		= wqe->wr_id;
 	} else {
 		wc->status		= qp->resp.status;
@@ -868,7 +868,7 @@ static enum resp_states do_complete(struct rxe_qp *qp,
 		/* fields after byte_len are different between kernel and user
 		 * space
 		 */
-		if (qp->rcq->is_user) {
+		if (rxe_qp_rcq(qp)->is_user) {
 			uwc->wc_flags = IB_WC_GRH;
 
 			if (pkt->mask & RXE_IMMDT_MASK) {
@@ -881,7 +881,7 @@ static enum resp_states do_complete(struct rxe_qp *qp,
 				uwc->ex.invalidate_rkey = ieth_rkey(pkt);
 			}
 
-			uwc->qp_num		= qp->ibqp.qp_num;
+			uwc->qp_num		= rxe_qp_num(qp);
 
 			if (pkt->mask & RXE_DETH_MASK)
 				uwc->src_qp = deth_sqp(pkt);
@@ -920,12 +920,12 @@ static enum resp_states do_complete(struct rxe_qp *qp,
 	}
 
 	/* have copy for srq and reference for !srq */
-	if (!qp->srq)
+	if (!rxe_qp_srq(qp))
 		advance_consumer(qp->rq.queue, QUEUE_TYPE_FROM_CLIENT);
 
 	qp->resp.wqe = NULL;
 
-	if (rxe_cq_post(qp->rcq, &cqe, pkt ? bth_se(pkt) : 1))
+	if (rxe_cq_post(rxe_qp_rcq(qp), &cqe, pkt ? bth_se(pkt) : 1))
 		return RESPST_ERR_CQ_OVERFLOW;
 
 finish:
@@ -933,7 +933,7 @@ static enum resp_states do_complete(struct rxe_qp *qp,
 		return RESPST_CHK_RESOURCE;
 	if (unlikely(!pkt))
 		return RESPST_DONE;
-	if (qp_type(qp) == IB_QPT_RC)
+	if (rxe_qp_type(qp) == IB_QPT_RC)
 		return RESPST_ACKNOWLEDGE;
 	else
 		return RESPST_CLEANUP;
@@ -1000,7 +1000,7 @@ static int send_atomic_ack(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
 static enum resp_states acknowledge(struct rxe_qp *qp,
 				    struct rxe_pkt_info *pkt)
 {
-	if (qp_type(qp) != IB_QPT_RC)
+	if (rxe_qp_type(qp) != IB_QPT_RC)
 		return RESPST_CLEANUP;
 
 	if (qp->resp.aeth_syndrome != AETH_ACK_UNLIMITED)
@@ -1147,7 +1147,7 @@ static void do_class_ac_error(struct rxe_qp *qp, u8 syndrome,
 static enum resp_states do_class_d1e_error(struct rxe_qp *qp)
 {
 	/* UC */
-	if (qp->srq) {
+	if (rxe_qp_srq(qp)) {
 		/* Class E */
 		qp->resp.drop_msg = 1;
 		if (qp->resp.wqe) {
@@ -1192,7 +1192,7 @@ static void rxe_drain_req_pkts(struct rxe_qp *qp, bool notify)
 	if (notify)
 		return;
 
-	while (!qp->srq && q && queue_head(q, q->type))
+	while (!rxe_qp_srq(qp) && q && queue_head(q, q->type))
 		advance_consumer(q, q->type);
 }
 
@@ -1224,7 +1224,7 @@ int rxe_responder(void *arg)
 	}
 
 	while (1) {
-		pr_debug("qp#%d state = %s\n", qp_num(qp),
+		pr_debug("qp#%d state = %s\n", rxe_qp_num(qp),
 			 resp_state_name[state]);
 		switch (state) {
 		case RESPST_GET_REQ:
@@ -1287,7 +1287,7 @@ int rxe_responder(void *arg)
 			state = do_class_d1e_error(qp);
 			break;
 		case RESPST_ERR_RNR:
-			if (qp_type(qp) == IB_QPT_RC) {
+			if (rxe_qp_type(qp) == IB_QPT_RC) {
 				rxe_counter_inc(rxe, RXE_CNT_SND_RNR);
 				/* RC - class B */
 				send_ack(qp, pkt, AETH_RNR_NAK |
@@ -1302,14 +1302,14 @@ int rxe_responder(void *arg)
 			break;
 
 		case RESPST_ERR_RKEY_VIOLATION:
-			if (qp_type(qp) == IB_QPT_RC) {
+			if (rxe_qp_type(qp) == IB_QPT_RC) {
 				/* Class C */
 				do_class_ac_error(qp, AETH_NAK_REM_ACC_ERR,
 						  IB_WC_REM_ACCESS_ERR);
 				state = RESPST_COMPLETE;
 			} else {
 				qp->resp.drop_msg = 1;
-				if (qp->srq) {
+				if (rxe_qp_srq(qp)) {
 					/* UC/SRQ Class D */
 					qp->resp.status = IB_WC_REM_ACCESS_ERR;
 					state = RESPST_COMPLETE;
@@ -1328,12 +1328,12 @@ int rxe_responder(void *arg)
 			break;
 
 		case RESPST_ERR_LENGTH:
-			if (qp_type(qp) == IB_QPT_RC) {
+			if (rxe_qp_type(qp) == IB_QPT_RC) {
 				/* Class C */
 				do_class_ac_error(qp, AETH_NAK_INVALID_REQ,
 						  IB_WC_REM_INV_REQ_ERR);
 				state = RESPST_COMPLETE;
-			} else if (qp->srq) {
+			} else if (rxe_qp_srq(qp)) {
 				/* UC/UD - class E */
 				qp->resp.status = IB_WC_REM_INV_REQ_ERR;
 				state = RESPST_COMPLETE;
@@ -1379,7 +1379,7 @@ int rxe_responder(void *arg)
 
 		case RESPST_ERROR:
 			qp->resp.goto_error = 0;
-			pr_warn("qp#%d moved to error state\n", qp_num(qp));
+			pr_warn("qp#%d moved to error state\n", rxe_qp_num(qp));
 			rxe_qp_error(qp);
 			goto exit;
 
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index bdd350e02d42..7ff98a60ddcd 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -537,15 +537,15 @@ static void init_send_wr(struct rxe_qp *qp, struct rxe_send_wr *wr,
 	wr->opcode = ibwr->opcode;
 	wr->send_flags = ibwr->send_flags;
 
-	if (qp_type(qp) == IB_QPT_UD ||
-	    qp_type(qp) == IB_QPT_SMI ||
-	    qp_type(qp) == IB_QPT_GSI) {
+	if (rxe_qp_type(qp) == IB_QPT_UD ||
+	    rxe_qp_type(qp) == IB_QPT_SMI ||
+	    rxe_qp_type(qp) == IB_QPT_GSI) {
 		struct ib_ah *ibah = ud_wr(ibwr)->ah;
 
 		wr->wr.ud.remote_qpn = ud_wr(ibwr)->remote_qpn;
 		wr->wr.ud.remote_qkey = ud_wr(ibwr)->remote_qkey;
 		wr->wr.ud.ah_num = to_rah(ibah)->ah_num;
-		if (qp_type(qp) == IB_QPT_GSI)
+		if (rxe_qp_type(qp) == IB_QPT_GSI)
 			wr->wr.ud.pkey_index = ud_wr(ibwr)->pkey_index;
 		if (wr->opcode == IB_WR_SEND_WITH_IMM)
 			wr->ex.imm_data = ibwr->ex.imm_data;
@@ -743,13 +743,13 @@ static int rxe_post_recv(struct ib_qp *ibqp, const struct ib_recv_wr *wr,
 	struct rxe_rq *rq = &qp->rq;
 	unsigned long flags;
 
-	if (unlikely((qp_state(qp) < IB_QPS_INIT) || !qp->valid)) {
+	if (unlikely((rxe_qp_state(qp) < IB_QPS_INIT) || !qp->valid)) {
 		*bad_wr = wr;
 		err = -EINVAL;
 		goto err1;
 	}
 
-	if (unlikely(qp->srq)) {
+	if (unlikely(rxe_qp_srq(qp))) {
 		*bad_wr = wr;
 		err = -EINVAL;
 		goto err1;
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 6b2dcbfcd404..0a433f4c0222 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -217,10 +217,6 @@ struct rxe_qp {
 	unsigned int		mtu;
 	bool			is_user;
 
-	struct rxe_srq		*srq;
-	struct rxe_cq		*scq;
-	struct rxe_cq		*rcq;
-
 	enum ib_sig_type	sq_sig_type;
 
 	struct rxe_sq		sq;
@@ -498,11 +494,42 @@ static inline u32 rxe_mw_rkey(struct rxe_mw *mw)
 	return mw->ibmw.rkey;
 }
 
+/* QP extractors */
+static inline int rxe_qp_num(struct rxe_qp *qp)
+{
+	return qp->ibqp.qp_num;
+}
+
 static inline struct rxe_pd *rxe_qp_pd(struct rxe_qp *qp)
 {
 	return to_rpd(qp->ibqp.pd);
 }
 
+static inline struct rxe_cq *rxe_qp_rcq(struct rxe_qp *qp)
+{
+	return to_rcq(qp->ibqp.recv_cq);
+}
+
+static inline struct rxe_cq *rxe_qp_scq(struct rxe_qp *qp)
+{
+	return to_rcq(qp->ibqp.send_cq);
+}
+
+static inline struct rxe_srq *rxe_qp_srq(struct rxe_qp *qp)
+{
+	return to_rsrq(qp->ibqp.srq);
+}
+
+static inline enum ib_qp_state rxe_qp_state(struct rxe_qp *qp)
+{
+	return qp->attr.qp_state;
+}
+
+static inline enum ib_qp_type rxe_qp_type(struct rxe_qp *qp)
+{
+	return qp->ibqp.qp_type;
+}
+
 static inline struct rxe_pd *rxe_srq_pd(struct rxe_srq *srq)
 {
 	return to_rpd(srq->ibsrq.pd);
-- 
2.30.2

