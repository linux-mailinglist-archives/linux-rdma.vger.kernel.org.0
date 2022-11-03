Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84C1D6185DC
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Nov 2022 18:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbiKCRLo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Nov 2022 13:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbiKCRKr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Nov 2022 13:10:47 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B889265D
        for <linux-rdma@vger.kernel.org>; Thu,  3 Nov 2022 10:10:41 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id p127so2623922oih.9
        for <linux-rdma@vger.kernel.org>; Thu, 03 Nov 2022 10:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ADS8K8TlKXvyf1lsN+Hri+aecn1lm0LbJQAXo/GbHo=;
        b=QIj+a87LNmEoLp9q1zH0Fd4osdOOlI9scF2LQwsciPRQlRGxn4xI0NZANq3kIV1S/7
         OuQGf0dwIBnUR8TDjiLHYyGNHXvKIkOPWa33SQ2dVu0SBow5crG4I/1oorrXa8kl2Icp
         C+67maqdVMMh3Gdwl8A+BKJqgLvn0L3nl2riyvKLoXzbYbLlxSD5dRQD/vv96yT6CJ0E
         aiUTpxh6v5QHjBS0BgyiQm1985wusXbp7x2zWJuVK97gQl8GJMcj5o3lcfQtHuSOkjqu
         f29SaOJ0PdAccNukTP2C2aTnpsteijaiYoUG+WT2/m3z+NHlkAURuraolFaQeKep/sim
         wn8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ADS8K8TlKXvyf1lsN+Hri+aecn1lm0LbJQAXo/GbHo=;
        b=nluHVQV0taIUr/FLlTMhT7ZfwIrwvuEls6nZi62kHku4PMMWOEOYDmpq69+RbwUgem
         Jk6LD0tSwjZ2oQoXS0/pckhQdd98sRfDFL16ppmuOkNeAKnIrSaHREsYSrKmdwSylEjF
         6LFv28cieEGtwRX4t4h2OKrU46eRTWCSmPKgeRJEW38xBZAJ81RsTjbtK7gm7CD8Y4Ql
         eNJs8DRiLIFppgB+6mMoyiP7+968QVvQJm62X93rIKv/ER+8PmSfBwmcn3XBVvhtLCDx
         Odd/2eWkhLdhancVxXmp5rNYokfdNlWOtzob7vNHd6saSfuOC3GfwjZRITT8nTeO2iWh
         UBCg==
X-Gm-Message-State: ACrzQf0QoybYi1CYW3AVrDAD4DgNMK3GPKXJPfsR3I4jdhIZEhYvphSv
        XuiqmO3ysJbn+dG67eOMEhc=
X-Google-Smtp-Source: AMsMyM55pWGmM++Ojt9rbpU6Nszo1eQ7/gtKVcw1IjUkcqr6F4CEitL9GvtCHsnJWDBnkyZrOrVDbg==
X-Received: by 2002:aca:2804:0:b0:35a:ff1:b12f with SMTP id 4-20020aca2804000000b0035a0ff1b12fmr11886950oix.207.1667495441230;
        Thu, 03 Nov 2022 10:10:41 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-b254-769c-82c0-77a4.res6.spectrum.com. [2603:8081:140c:1a00:b254:769c:82c0:77a4])
        by smtp.googlemail.com with ESMTPSA id m1-20020a056870a10100b0012b298699dbsm624304oae.1.2022.11.03.10.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 10:10:40 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     leon@kernel.org, jgg@nvidia.com, zyjzyj2000@gmail.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 07/16] RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe_qp.c
Date:   Thu,  3 Nov 2022 12:10:05 -0500
Message-Id: <20221103171013.20659-8-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221103171013.20659-1-rpearsonhpe@gmail.com>
References: <20221103171013.20659-1-rpearsonhpe@gmail.com>
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

Replace calls to pr_xxx() in rxe_qp.c with rxe_dbg_xxx().

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_qp.c | 65 ++++++++++++++----------------
 1 file changed, 30 insertions(+), 35 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index 3f6d62a80bea..bcbfe6068b8b 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -19,33 +19,33 @@ static int rxe_qp_chk_cap(struct rxe_dev *rxe, struct ib_qp_cap *cap,
 			  int has_srq)
 {
 	if (cap->max_send_wr > rxe->attr.max_qp_wr) {
-		pr_debug("invalid send wr = %u > %d\n",
+		rxe_dbg(rxe, "invalid send wr = %u > %d\n",
 			 cap->max_send_wr, rxe->attr.max_qp_wr);
 		goto err1;
 	}
 
 	if (cap->max_send_sge > rxe->attr.max_send_sge) {
-		pr_debug("invalid send sge = %u > %d\n",
+		rxe_dbg(rxe, "invalid send sge = %u > %d\n",
 			 cap->max_send_sge, rxe->attr.max_send_sge);
 		goto err1;
 	}
 
 	if (!has_srq) {
 		if (cap->max_recv_wr > rxe->attr.max_qp_wr) {
-			pr_debug("invalid recv wr = %u > %d\n",
+			rxe_dbg(rxe, "invalid recv wr = %u > %d\n",
 				 cap->max_recv_wr, rxe->attr.max_qp_wr);
 			goto err1;
 		}
 
 		if (cap->max_recv_sge > rxe->attr.max_recv_sge) {
-			pr_debug("invalid recv sge = %u > %d\n",
+			rxe_dbg(rxe, "invalid recv sge = %u > %d\n",
 				 cap->max_recv_sge, rxe->attr.max_recv_sge);
 			goto err1;
 		}
 	}
 
 	if (cap->max_inline_data > rxe->max_inline_data) {
-		pr_debug("invalid max inline data = %u > %d\n",
+		rxe_dbg(rxe, "invalid max inline data = %u > %d\n",
 			 cap->max_inline_data, rxe->max_inline_data);
 		goto err1;
 	}
@@ -73,7 +73,7 @@ int rxe_qp_chk_init(struct rxe_dev *rxe, struct ib_qp_init_attr *init)
 	}
 
 	if (!init->recv_cq || !init->send_cq) {
-		pr_debug("missing cq\n");
+		rxe_dbg(rxe, "missing cq\n");
 		goto err1;
 	}
 
@@ -82,14 +82,14 @@ int rxe_qp_chk_init(struct rxe_dev *rxe, struct ib_qp_init_attr *init)
 
 	if (init->qp_type == IB_QPT_GSI) {
 		if (!rdma_is_port_valid(&rxe->ib_dev, port_num)) {
-			pr_debug("invalid port = %d\n", port_num);
+			rxe_dbg(rxe, "invalid port = %d\n", port_num);
 			goto err1;
 		}
 
 		port = &rxe->port;
 
 		if (init->qp_type == IB_QPT_GSI && port->qp_gsi_index) {
-			pr_debug("GSI QP exists for port %d\n", port_num);
+			rxe_dbg(rxe, "GSI QP exists for port %d\n", port_num);
 			goto err1;
 		}
 	}
@@ -264,9 +264,6 @@ static int rxe_qp_init_resp(struct rxe_dev *rxe, struct rxe_qp *qp,
 
 		wqe_size = rcv_wqe_size(qp->rq.max_sge);
 
-		pr_debug("qp#%d max_wr = %d, max_sge = %d, wqe_size = %d\n",
-			 qp_num(qp), qp->rq.max_wr, qp->rq.max_sge, wqe_size);
-
 		type = QUEUE_TYPE_FROM_CLIENT;
 		qp->rq.queue = rxe_queue_init(rxe, &qp->rq.max_wr,
 					wqe_size, type);
@@ -395,7 +392,7 @@ int rxe_qp_chk_attr(struct rxe_dev *rxe, struct rxe_qp *qp,
 					attr->qp_state : cur_state;
 
 	if (!ib_modify_qp_is_ok(cur_state, new_state, qp_type(qp), mask)) {
-		pr_debug("invalid mask or state for qp\n");
+		rxe_dbg_qp(qp, "invalid mask or state\n");
 		goto err1;
 	}
 
@@ -409,7 +406,7 @@ int rxe_qp_chk_attr(struct rxe_dev *rxe, struct rxe_qp *qp,
 
 	if (mask & IB_QP_PORT) {
 		if (!rdma_is_port_valid(&rxe->ib_dev, attr->port_num)) {
-			pr_debug("invalid port %d\n", attr->port_num);
+			rxe_dbg_qp(qp, "invalid port %d\n", attr->port_num);
 			goto err1;
 		}
 	}
@@ -424,11 +421,11 @@ int rxe_qp_chk_attr(struct rxe_dev *rxe, struct rxe_qp *qp,
 		if (rxe_av_chk_attr(rxe, &attr->alt_ah_attr))
 			goto err1;
 		if (!rdma_is_port_valid(&rxe->ib_dev, attr->alt_port_num))  {
-			pr_debug("invalid alt port %d\n", attr->alt_port_num);
+			rxe_dbg_qp(qp, "invalid alt port %d\n", attr->alt_port_num);
 			goto err1;
 		}
 		if (attr->alt_timeout > 31) {
-			pr_debug("invalid QP alt timeout %d > 31\n",
+			rxe_dbg_qp(qp, "invalid alt timeout %d > 31\n",
 				 attr->alt_timeout);
 			goto err1;
 		}
@@ -441,7 +438,7 @@ int rxe_qp_chk_attr(struct rxe_dev *rxe, struct rxe_qp *qp,
 		enum ib_mtu mtu = attr->path_mtu;
 
 		if (mtu > max_mtu) {
-			pr_debug("invalid mtu (%d) > (%d)\n",
+			rxe_dbg_qp(qp, "invalid mtu (%d) > (%d)\n",
 				 ib_mtu_enum_to_int(mtu),
 				 ib_mtu_enum_to_int(max_mtu));
 			goto err1;
@@ -450,7 +447,7 @@ int rxe_qp_chk_attr(struct rxe_dev *rxe, struct rxe_qp *qp,
 
 	if (mask & IB_QP_MAX_QP_RD_ATOMIC) {
 		if (attr->max_rd_atomic > rxe->attr.max_qp_rd_atom) {
-			pr_debug("invalid max_rd_atomic %d > %d\n",
+			rxe_dbg_qp(qp, "invalid max_rd_atomic %d > %d\n",
 				 attr->max_rd_atomic,
 				 rxe->attr.max_qp_rd_atom);
 			goto err1;
@@ -459,7 +456,8 @@ int rxe_qp_chk_attr(struct rxe_dev *rxe, struct rxe_qp *qp,
 
 	if (mask & IB_QP_TIMEOUT) {
 		if (attr->timeout > 31) {
-			pr_debug("invalid QP timeout %d > 31\n", attr->timeout);
+			rxe_dbg_qp(qp, "invalid timeout %d > 31\n",
+					attr->timeout);
 			goto err1;
 		}
 	}
@@ -637,27 +635,24 @@ int rxe_qp_from_attr(struct rxe_qp *qp, struct ib_qp_attr *attr, int mask,
 	if (mask & IB_QP_RETRY_CNT) {
 		qp->attr.retry_cnt = attr->retry_cnt;
 		qp->comp.retry_cnt = attr->retry_cnt;
-		pr_debug("qp#%d set retry count = %d\n", qp_num(qp),
-			 attr->retry_cnt);
+		rxe_dbg_qp(qp, "set retry count = %d\n", attr->retry_cnt);
 	}
 
 	if (mask & IB_QP_RNR_RETRY) {
 		qp->attr.rnr_retry = attr->rnr_retry;
 		qp->comp.rnr_retry = attr->rnr_retry;
-		pr_debug("qp#%d set rnr retry count = %d\n", qp_num(qp),
-			 attr->rnr_retry);
+		rxe_dbg_qp(qp, "set rnr retry count = %d\n", attr->rnr_retry);
 	}
 
 	if (mask & IB_QP_RQ_PSN) {
 		qp->attr.rq_psn = (attr->rq_psn & BTH_PSN_MASK);
 		qp->resp.psn = qp->attr.rq_psn;
-		pr_debug("qp#%d set resp psn = 0x%x\n", qp_num(qp),
-			 qp->resp.psn);
+		rxe_dbg_qp(qp, "set resp psn = 0x%x\n", qp->resp.psn);
 	}
 
 	if (mask & IB_QP_MIN_RNR_TIMER) {
 		qp->attr.min_rnr_timer = attr->min_rnr_timer;
-		pr_debug("qp#%d set min rnr timer = 0x%x\n", qp_num(qp),
+		rxe_dbg_qp(qp, "set min rnr timer = 0x%x\n",
 			 attr->min_rnr_timer);
 	}
 
@@ -665,7 +660,7 @@ int rxe_qp_from_attr(struct rxe_qp *qp, struct ib_qp_attr *attr, int mask,
 		qp->attr.sq_psn = (attr->sq_psn & BTH_PSN_MASK);
 		qp->req.psn = qp->attr.sq_psn;
 		qp->comp.psn = qp->attr.sq_psn;
-		pr_debug("qp#%d set req psn = 0x%x\n", qp_num(qp), qp->req.psn);
+		rxe_dbg_qp(qp, "set req psn = 0x%x\n", qp->req.psn);
 	}
 
 	if (mask & IB_QP_PATH_MIG_STATE)
@@ -679,40 +674,40 @@ int rxe_qp_from_attr(struct rxe_qp *qp, struct ib_qp_attr *attr, int mask,
 
 		switch (attr->qp_state) {
 		case IB_QPS_RESET:
-			pr_debug("qp#%d state -> RESET\n", qp_num(qp));
+			rxe_dbg_qp(qp, "state -> RESET\n");
 			rxe_qp_reset(qp);
 			break;
 
 		case IB_QPS_INIT:
-			pr_debug("qp#%d state -> INIT\n", qp_num(qp));
+			rxe_dbg_qp(qp, "state -> INIT\n");
 			qp->req.state = QP_STATE_INIT;
 			qp->resp.state = QP_STATE_INIT;
 			qp->comp.state = QP_STATE_INIT;
 			break;
 
 		case IB_QPS_RTR:
-			pr_debug("qp#%d state -> RTR\n", qp_num(qp));
+			rxe_dbg_qp(qp, "state -> RTR\n");
 			qp->resp.state = QP_STATE_READY;
 			break;
 
 		case IB_QPS_RTS:
-			pr_debug("qp#%d state -> RTS\n", qp_num(qp));
+			rxe_dbg_qp(qp, "state -> RTS\n");
 			qp->req.state = QP_STATE_READY;
 			qp->comp.state = QP_STATE_READY;
 			break;
 
 		case IB_QPS_SQD:
-			pr_debug("qp#%d state -> SQD\n", qp_num(qp));
+			rxe_dbg_qp(qp, "state -> SQD\n");
 			rxe_qp_drain(qp);
 			break;
 
 		case IB_QPS_SQE:
-			pr_warn("qp#%d state -> SQE !!?\n", qp_num(qp));
+			rxe_dbg_qp(qp, "state -> SQE !!?\n");
 			/* Not possible from modify_qp. */
 			break;
 
 		case IB_QPS_ERR:
-			pr_debug("qp#%d state -> ERR\n", qp_num(qp));
+			rxe_dbg_qp(qp, "state -> ERR\n");
 			rxe_qp_error(qp);
 			break;
 		}
@@ -752,7 +747,7 @@ int rxe_qp_to_attr(struct rxe_qp *qp, struct ib_qp_attr *attr, int mask)
 		attr->sq_draining = 0;
 	}
 
-	pr_debug("attr->sq_draining = %d\n", attr->sq_draining);
+	rxe_dbg_qp(qp, "attr->sq_draining = %d\n", attr->sq_draining);
 
 	return 0;
 }
@@ -764,7 +759,7 @@ int rxe_qp_chk_destroy(struct rxe_qp *qp)
 	 * will fail immediately.
 	 */
 	if (atomic_read(&qp->mcg_num)) {
-		pr_debug("Attempt to destroy QP while attached to multicast group\n");
+		rxe_dbg_qp(qp, "Attempt to destroy while attached to multicast group\n");
 		return -EBUSY;
 	}
 
-- 
2.34.1

