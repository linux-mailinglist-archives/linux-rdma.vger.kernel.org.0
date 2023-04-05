Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1654F6D735A
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Apr 2023 06:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236696AbjDEE0o (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Apr 2023 00:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236689AbjDEE0n (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Apr 2023 00:26:43 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74BE172C
        for <linux-rdma@vger.kernel.org>; Tue,  4 Apr 2023 21:26:42 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id l18so25813167oic.13
        for <linux-rdma@vger.kernel.org>; Tue, 04 Apr 2023 21:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680668802;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tZw/e3Zy7PQFJtPm84yb5P9q2Zu9EmpszPG7N5mmwsM=;
        b=kC/zWCEoLUUfPEgQjHXvic0O962EKDbygGgk4kr/KK74ySFL0197xE+S11QA4/QK13
         99qK7HlKeiA8g8u0wtp3BCdPyujgrKT5oZ5xxhWnhop9E7lmtwu9I11vaCBO6+uuT/7h
         SGcxlC7/QLXKcRLDx8L943cF3S2B1wzJoPc6mkWh7JhXpIVVl1DMUftbwSlJYiJzN4Fv
         /VBCuOVfFt3Q0GOmcrpMBoChLWdmRWxYs3YmWo9yq1AW+GUxWzPKU5Pvcnhbch/ZWfxU
         ItJhEkzc/rPztX5vdoubh8/aznw+uCOfULPMWSgLwVwo6vh/F0gTHLwaqbE/kIR1qrG1
         d0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680668802;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tZw/e3Zy7PQFJtPm84yb5P9q2Zu9EmpszPG7N5mmwsM=;
        b=cQgiluc2s55q+4ejslL8cgm4OFYU3l/Y7c/VXGsY+zBUw18V50V07ihnAmtnToqYxn
         Kai9FzmZfmc534SDsFFBHAZ16iHfeYA3pVTIWJ8ycOPA1Y6ZtCsmv4I/Rushqng0tUxe
         QcbUaH5v6SDP9QfQG27DZNMbZiPitK0t4eG9qF4u5yiiXqJtbS6Mhq7K4Z8jQxt3zlLC
         5hQF6JuCDn1nYCtMmjfbMvcIiKLnmcSwm5MSbq1k74KFiJ1J3Nm/VXSLvdPm9yPHSNhU
         A2+picJ3td9rdFt5SSNN0gwKl8h3hYpxYKtUGl9KPELuwvoWeOvcum/HBxINpJYOxzqA
         dVnw==
X-Gm-Message-State: AAQBX9f0T8KjjRkHujKAVG5t37LAPd2joYrUsQrSNPx4H1gZTuIIspNh
        cGi/WmiONODxzVpiFzOcbhw=
X-Google-Smtp-Source: AKy350Y9btaLinUAchtcubGtqMDW7Ro17rVNdPp1KLoEWM+4pJiZ2mmTxXO0glW1+Vo7LD7o1nOE+w==
X-Received: by 2002:a05:6808:3a96:b0:386:eec2:957a with SMTP id fb22-20020a0568083a9600b00386eec2957amr2296195oib.9.1680668802038;
        Tue, 04 Apr 2023 21:26:42 -0700 (PDT)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.gmail.com with ESMTPSA id x80-20020a4a4153000000b0053d9be4be68sm6321326ooa.19.2023.04.04.21.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 21:26:27 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, leon@kernel.org,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 1/5] RDMA/rxe: Remove qp->resp.state
Date:   Tue,  4 Apr 2023 23:26:07 -0500
Message-Id: <20230405042611.6467-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The rxe driver has four different QP state variables,
    qp->attr.qp_state,
    qp->req.state,
    qp->comp.state, and
    qp->resp.state.
All of these basically carry the same information.

This patch replaces uses of qp->resp.state by qp->attr.qp_state.
This is the first of three patches which will remove all but the
qp->attr.qp_state variable. This will bring the driver closer
to the IBA description.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_net.c   |  2 +-
 drivers/infiniband/sw/rxe/rxe_qp.c    |  5 -----
 drivers/infiniband/sw/rxe/rxe_recv.c  |  2 +-
 drivers/infiniband/sw/rxe/rxe_resp.c  | 10 +++++-----
 drivers/infiniband/sw/rxe/rxe_verbs.c |  2 +-
 drivers/infiniband/sw/rxe/rxe_verbs.h |  1 -
 6 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index a2ace42e9536..2be2425083ce 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -414,7 +414,7 @@ int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
 	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
 
 	if ((is_request && (qp->req.state != QP_STATE_READY)) ||
-	    (!is_request && (qp->resp.state != QP_STATE_READY))) {
+	    (!is_request && (qp_state(qp) <= IB_QPS_RTR))) {
 		rxe_dbg_qp(qp, "Packet dropped. QP is not in ready state\n");
 		goto drop;
 	}
diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index 49891f8ed4e6..38694b355bed 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -287,7 +287,6 @@ static int rxe_qp_init_resp(struct rxe_dev *rxe, struct rxe_qp *qp,
 
 	qp->resp.opcode		= OPCODE_NONE;
 	qp->resp.msn		= 0;
-	qp->resp.state		= QP_STATE_RESET;
 
 	return 0;
 }
@@ -479,7 +478,6 @@ static void rxe_qp_reset(struct rxe_qp *qp)
 	/* move qp to the reset state */
 	qp->req.state = QP_STATE_RESET;
 	qp->comp.state = QP_STATE_RESET;
-	qp->resp.state = QP_STATE_RESET;
 
 	/* drain work and packet queuesc */
 	rxe_requester(qp);
@@ -532,7 +530,6 @@ static void rxe_qp_drain(struct rxe_qp *qp)
 void rxe_qp_error(struct rxe_qp *qp)
 {
 	qp->req.state = QP_STATE_ERROR;
-	qp->resp.state = QP_STATE_ERROR;
 	qp->comp.state = QP_STATE_ERROR;
 	qp->attr.qp_state = IB_QPS_ERR;
 
@@ -663,13 +660,11 @@ int rxe_qp_from_attr(struct rxe_qp *qp, struct ib_qp_attr *attr, int mask,
 		case IB_QPS_INIT:
 			rxe_dbg_qp(qp, "state -> INIT\n");
 			qp->req.state = QP_STATE_INIT;
-			qp->resp.state = QP_STATE_INIT;
 			qp->comp.state = QP_STATE_INIT;
 			break;
 
 		case IB_QPS_RTR:
 			rxe_dbg_qp(qp, "state -> RTR\n");
-			qp->resp.state = QP_STATE_READY;
 			break;
 
 		case IB_QPS_RTS:
diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
index 434a693cd4a5..ac42ceccf71f 100644
--- a/drivers/infiniband/sw/rxe/rxe_recv.c
+++ b/drivers/infiniband/sw/rxe/rxe_recv.c
@@ -39,7 +39,7 @@ static int check_type_state(struct rxe_dev *rxe, struct rxe_pkt_info *pkt,
 	}
 
 	if (pkt->mask & RXE_REQ_MASK) {
-		if (unlikely(qp->resp.state != QP_STATE_READY))
+		if (unlikely(qp_state(qp) <= IB_QPS_RTR))
 			return -EINVAL;
 	} else if (unlikely(qp->req.state < QP_STATE_READY ||
 				qp->req.state > QP_STATE_DRAINED))
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 01e3cbea8445..67eac616235c 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -1137,7 +1137,7 @@ static enum resp_states do_complete(struct rxe_qp *qp,
 		return RESPST_ERR_CQ_OVERFLOW;
 
 finish:
-	if (unlikely(qp->resp.state == QP_STATE_ERROR))
+	if (unlikely(qp_state(qp) == IB_QPS_ERR))
 		return RESPST_CHK_RESOURCE;
 	if (unlikely(!pkt))
 		return RESPST_DONE;
@@ -1464,10 +1464,10 @@ int rxe_responder(struct rxe_qp *qp)
 	struct rxe_pkt_info *pkt = NULL;
 	int ret;
 
-	if (!qp->valid || qp->resp.state == QP_STATE_ERROR ||
-	    qp->resp.state == QP_STATE_RESET) {
-		bool notify = qp->valid &&
-				(qp->resp.state == QP_STATE_ERROR);
+	if (!qp->valid || qp_state(qp) == IB_QPS_ERR ||
+	    qp_state(qp) == IB_QPS_RESET) {
+		bool notify = qp->valid && (qp_state(qp) == IB_QPS_ERR);
+
 		drain_req_pkts(qp);
 		flush_recv_queue(qp, notify);
 		goto exit;
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 4e2db7c2e4ed..2a5da3160db9 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -1012,7 +1012,7 @@ static int rxe_post_recv(struct ib_qp *ibqp, const struct ib_recv_wr *wr,
 
 	spin_unlock_irqrestore(&rq->producer_lock, flags);
 
-	if (qp->resp.state == QP_STATE_ERROR)
+	if (qp_state(qp) == IB_QPS_ERR)
 		rxe_sched_task(&qp->resp.task);
 
 err_out:
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index d812093a3916..12594cb2a9cf 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -173,7 +173,6 @@ struct resp_res {
 };
 
 struct rxe_resp_info {
-	enum rxe_qp_state	state;
 	u32			msn;
 	u32			psn;
 	u32			ack_psn;
-- 
2.37.2

