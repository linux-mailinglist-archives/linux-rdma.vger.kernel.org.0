Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6552C3DAF87
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jul 2021 00:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234607AbhG2Wut (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Jul 2021 18:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234601AbhG2Wut (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 29 Jul 2021 18:50:49 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6765EC06179A
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jul 2021 15:50:44 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id f1-20020a4a8f410000b0290251d599f19bso1974322ool.8
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jul 2021 15:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DMTzWY4JWpShhPLpYnMAD0zgMb/zgEZb1eODd6dIWqA=;
        b=D5cjTCLGcJI7x9nERNuxB4O/Ir/Y6CNj6/3GpwiFPrgYqDDHgiYyisIShfDmDGyBat
         7NvBO1Gpl7wyQz4pBPsoVyhHdT2/aX8MHmZYL70EJb3bOtMtL/2EggZ/vaDeAU+eQFBC
         JU9HINsxWlw95g0pDHKGuh4DaDu4nSc/B0jdqUssxaJuzfBkfA3gfsUAtUohXwV1VAR9
         dYwqBnWMHsxyFew9ko/ljAF2E1UCSfTSfEjsHsRPyGoBDaHGu8nf6nqGZESo/QhDdiJd
         d0Op2XVzs4b7BKgpK8ddu6xeGRp9K632rB5KyhniF9D8cm03KFoCTHJN8Co/2GvL3TRj
         t1kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DMTzWY4JWpShhPLpYnMAD0zgMb/zgEZb1eODd6dIWqA=;
        b=XubEcTa1SDHCEptxO4VWKs/lYVdz1Qp4G/3fuP3doatkKI/qGvT1Zjf4WcEZV7K0h8
         4JMQnB7IKyfSgDRkHS35NCHwt7K2bCfpWlTq0sYBbeQV0tzcE+HDrziHAy8/80Y8XJIt
         5mtmkZS95lSBxbWMbJcvt3U1oqmKAX0JJGeEYM/AS+bNFHQp/swzu0V0RZmdxlAPRXDb
         IYD87l5tHKgDGeBDSFmXtSGmjwLcJi1HDqmMPXI/yx+twaRAReD+7aKc5ix6QByuHOwT
         P89V7zs4icqbJVIL9ltNst2TQiHAGzrmq7PBE6/J9+aawy7h64Ub+IZCbHNsBPLm7YIE
         l2Pw==
X-Gm-Message-State: AOAM532/h3W7znTEnfGEY6LVq34blxtkHSyW3o3XPJgVLRRwtI+HNxFa
        +d6p7PQmPxFrvRLW6+92dFYZup5uSNY=
X-Google-Smtp-Source: ABdhPJxNB3QVP/UTPARaw32Q/Ir+9OX6b4HQrr89dLlRtAbe4k7RdoQewJ4ktWNA916KtRdefQgfvA==
X-Received: by 2002:a4a:b481:: with SMTP id b1mr4506364ooo.79.1627599043655;
        Thu, 29 Jul 2021 15:50:43 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-80ca-c9ae-640f-0f9a.res6.spectrum.com. [2603:8081:140c:1a00:80ca:c9ae:640f:f9a])
        by smtp.gmail.com with ESMTPSA id j202sm864127oih.6.2021.07.29.15.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 15:50:43 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 13/13] RDMA/rxe: Enable receiving XRC packets
Date:   Thu, 29 Jul 2021 17:49:16 -0500
Message-Id: <20210729224915.38986-14-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210729224915.38986-1-rpearsonhpe@gmail.com>
References: <20210729224915.38986-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Extend rxe to support receiving XRC trafic.
  - Extend lists of QP types where appropriate.
  - Add an error state for invalid XRCETH header.
  - Add code to handle srq, pd amd rcq coming from XRCSRQ for XRC packets
    Save pointers in pkt info struct for later use and dropping refs.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_av.c     |   2 +
 drivers/infiniband/sw/rxe/rxe_comp.c   |  27 +++-
 drivers/infiniband/sw/rxe/rxe_hdr.h    |   9 +-
 drivers/infiniband/sw/rxe/rxe_loc.h    |   3 +-
 drivers/infiniband/sw/rxe/rxe_mw.c     |   6 +-
 drivers/infiniband/sw/rxe/rxe_net.c    |   8 ++
 drivers/infiniband/sw/rxe/rxe_opcode.c |   1 -
 drivers/infiniband/sw/rxe/rxe_recv.c   |  22 ++-
 drivers/infiniband/sw/rxe/rxe_req.c    |   3 +-
 drivers/infiniband/sw/rxe/rxe_resp.c   | 191 ++++++++++++++++++++-----
 drivers/infiniband/sw/rxe/rxe_verbs.h  |  16 ++-
 11 files changed, 232 insertions(+), 56 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_av.c b/drivers/infiniband/sw/rxe/rxe_av.c
index 05d4cb772dc6..673b65d415b8 100644
--- a/drivers/infiniband/sw/rxe/rxe_av.c
+++ b/drivers/infiniband/sw/rxe/rxe_av.c
@@ -122,9 +122,11 @@ struct rxe_av *rxe_get_av(struct rxe_pkt_info *pkt)
 		ah = rxe_pool_get_index(&pkt->rxe->ah_pool, ah_num);
 		if (!ah || ah->ah_num != ah_num ||
 		    rxe_ah_pd(ah) != rxe_qp_pd(pkt->qp)) {
+			rxe_drop_ref(ah);
 			pr_warn("Unable to find AH matching ah_num\n");
 			return NULL;
 		}
+		pkt->ah = ah;
 		return &ah->av;
 	}
 
diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index 4d62e5bdf820..987bd8e67fb6 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -242,6 +242,23 @@ static inline enum comp_state check_ack(struct rxe_qp *qp,
 			return COMPST_ERROR;
 		}
 		break;
+
+	case IB_OPCODE_XRC_RDMA_READ_RESPONSE_FIRST:
+	case IB_OPCODE_XRC_RDMA_READ_RESPONSE_MIDDLE:
+		if (pkt->opcode != IB_OPCODE_XRC_RDMA_READ_RESPONSE_MIDDLE &&
+		    pkt->opcode != IB_OPCODE_XRC_RDMA_READ_RESPONSE_LAST) {
+			if ((pkt->psn == wqe->first_psn &&
+			     pkt->opcode ==
+			     IB_OPCODE_XRC_RDMA_READ_RESPONSE_FIRST) ||
+			    (wqe->first_psn == wqe->last_psn &&
+			     pkt->opcode ==
+			     IB_OPCODE_XRC_RDMA_READ_RESPONSE_ONLY))
+				break;
+
+			return COMPST_ERROR;
+		}
+		break;
+
 	default:
 		WARN_ON_ONCE(1);
 	}
@@ -251,6 +268,9 @@ static inline enum comp_state check_ack(struct rxe_qp *qp,
 	case IB_OPCODE_RC_RDMA_READ_RESPONSE_FIRST:
 	case IB_OPCODE_RC_RDMA_READ_RESPONSE_LAST:
 	case IB_OPCODE_RC_RDMA_READ_RESPONSE_ONLY:
+	case IB_OPCODE_XRC_RDMA_READ_RESPONSE_FIRST:
+	case IB_OPCODE_XRC_RDMA_READ_RESPONSE_LAST:
+	case IB_OPCODE_XRC_RDMA_READ_RESPONSE_ONLY:
 		syn = aeth_syn(pkt);
 
 		if ((syn & AETH_TYPE_MASK) != AETH_ACK)
@@ -260,6 +280,7 @@ static inline enum comp_state check_ack(struct rxe_qp *qp,
 		/* (IB_OPCODE_RC_RDMA_READ_RESPONSE_MIDDLE doesn't have an AETH)
 		 */
 	case IB_OPCODE_RC_RDMA_READ_RESPONSE_MIDDLE:
+	case IB_OPCODE_XRC_RDMA_READ_RESPONSE_MIDDLE:
 		if (wqe->wr.opcode != IB_WR_RDMA_READ &&
 		    wqe->wr.opcode != IB_WR_RDMA_READ_WITH_INV) {
 			wqe->status = IB_WC_FATAL_ERR;
@@ -269,6 +290,7 @@ static inline enum comp_state check_ack(struct rxe_qp *qp,
 		return COMPST_READ;
 
 	case IB_OPCODE_RC_ATOMIC_ACKNOWLEDGE:
+	case IB_OPCODE_XRC_ATOMIC_ACKNOWLEDGE:
 		syn = aeth_syn(pkt);
 
 		if ((syn & AETH_TYPE_MASK) != AETH_ACK)
@@ -281,6 +303,7 @@ static inline enum comp_state check_ack(struct rxe_qp *qp,
 		return COMPST_ATOMIC;
 
 	case IB_OPCODE_RC_ACKNOWLEDGE:
+	case IB_OPCODE_XRC_ACKNOWLEDGE:
 		syn = aeth_syn(pkt);
 		switch (syn & AETH_TYPE_MASK) {
 		case AETH_ACK:
@@ -570,8 +593,8 @@ int rxe_completer(void *arg)
 	state = COMPST_GET_ACK;
 
 	while (1) {
-		pr_debug("qp#%d state = %s\n", rxe_qp_num(qp),
-			 comp_state_name[state]);
+		pr_debug("qp#%d type %d state = %s\n", rxe_qp_num(qp),
+			 rxe_qp_type(qp), comp_state_name[state]);
 		switch (state) {
 		case COMPST_GET_ACK:
 			skb = skb_dequeue(&qp->resp_pkts);
diff --git a/drivers/infiniband/sw/rxe/rxe_hdr.h b/drivers/infiniband/sw/rxe/rxe_hdr.h
index 499807b11405..db6033f49697 100644
--- a/drivers/infiniband/sw/rxe/rxe_hdr.h
+++ b/drivers/infiniband/sw/rxe/rxe_hdr.h
@@ -14,7 +14,14 @@
 struct rxe_pkt_info {
 	struct sk_buff		*skb;		/* back pointer to skb */
 	struct rxe_dev		*rxe;		/* device that owns packet */
-	struct rxe_qp		*qp;		/* qp that owns packet */
+
+	/* these are objects that need references dropped when pkt freed */
+	struct rxe_ah		*ah;
+	struct rxe_qp		*qp;
+	struct rxe_srq		*srq;
+
+	struct rxe_pd		*pd;
+	struct rxe_cq		*rcq;
 	struct rxe_send_wqe	*wqe;		/* send wqe */
 	u8			*hdr;		/* points to bth */
 	u32			mask;		/* useful info about pkt */
diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 790884a5e9d5..2580273c1806 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -94,7 +94,8 @@ int rxe_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata);
 int rxe_dealloc_mw(struct ib_mw *ibmw);
 int rxe_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe);
 int rxe_invalidate_mw(struct rxe_qp *qp, u32 rkey);
-struct rxe_mw *rxe_lookup_mw(struct rxe_qp *qp, int access, u32 rkey);
+struct rxe_mw *rxe_lookup_mw(struct rxe_pd *pd, struct rxe_qp *qp,
+			     int access, u32 rkey);
 void rxe_mw_cleanup(struct rxe_pool_entry *arg);
 
 /* rxe_net.c */
diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
index 17936a0b8320..0de65c89b7c5 100644
--- a/drivers/infiniband/sw/rxe/rxe_mw.c
+++ b/drivers/infiniband/sw/rxe/rxe_mw.c
@@ -305,10 +305,10 @@ int rxe_invalidate_mw(struct rxe_qp *qp, u32 rkey)
 	return ret;
 }
 
-struct rxe_mw *rxe_lookup_mw(struct rxe_qp *qp, int access, u32 rkey)
+struct rxe_mw *rxe_lookup_mw(struct rxe_pd *pd, struct rxe_qp *qp,
+			     int access, u32 rkey)
 {
-	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
-	struct rxe_pd *pd = rxe_qp_pd(qp);
+	struct rxe_dev *rxe = to_rdev(pd->ibpd.device);
 	struct rxe_mw *mw;
 	int index = rkey >> 8;
 
diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index b1353d456a4c..1597d5313af3 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -424,6 +424,14 @@ static int rxe_loopback(struct sk_buff *skb, struct rxe_pkt_info *pkt)
 
 	new_pkt = kzalloc(sizeof(*new_pkt), GFP_ATOMIC);
 	memcpy(new_pkt, pkt, sizeof(*pkt));
+
+	/* don't keep the references */
+	new_pkt->ah = NULL;
+	new_pkt->qp = NULL;
+	new_pkt->srq = NULL;
+	new_pkt->pd = NULL;
+	new_pkt->rcq = NULL;
+
 	RXE_CB(skb)->pkt = new_pkt;
 	new_pkt->skb = skb;
 
diff --git a/drivers/infiniband/sw/rxe/rxe_opcode.c b/drivers/infiniband/sw/rxe/rxe_opcode.c
index af8e05bc63b2..1685a29efaf7 100644
--- a/drivers/infiniband/sw/rxe/rxe_opcode.c
+++ b/drivers/infiniband/sw/rxe/rxe_opcode.c
@@ -88,7 +88,6 @@ struct rxe_wr_opcode_info rxe_wr_opcode_info[] = {
 		.name	= "IB_WR_RDMA_READ_WITH_INV",
 		.mask	= {
 			[IB_QPT_RC]	 = WR_READ_MASK,
-			/* TODO get rid of this no such thing for RoCE */
 		},
 	},
 	[IB_WR_LOCAL_INV]				= {
diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
index cf5ac6bba59c..7ac40857def3 100644
--- a/drivers/infiniband/sw/rxe/rxe_recv.c
+++ b/drivers/infiniband/sw/rxe/rxe_recv.c
@@ -12,10 +12,13 @@
 void rxe_free_pkt(struct rxe_pkt_info *pkt)
 {
 	struct sk_buff *skb = PKT_TO_SKB(pkt);
-	struct rxe_qp *qp = pkt->qp;
 
-	if (qp)
-		rxe_drop_ref(qp);
+	if (pkt->qp)
+		rxe_drop_ref(pkt->qp);
+	if (pkt->srq)
+		rxe_drop_ref(pkt->srq);
+	if (pkt->ah)
+		rxe_drop_ref(pkt->ah);
 
 	ib_device_put(&pkt->rxe->ib_dev);
 
@@ -37,13 +40,13 @@ static int check_type_state(struct rxe_dev *rxe, struct rxe_pkt_info *pkt,
 	switch (rxe_qp_type(qp)) {
 	case IB_QPT_RC:
 		if (unlikely(pkt_type != IB_OPCODE_RC)) {
-			pr_warn_ratelimited("bad qp type\n");
+			pr_warn_ratelimited("bad qp type for RC packet\n");
 			goto err1;
 		}
 		break;
 	case IB_QPT_UC:
 		if (unlikely(pkt_type != IB_OPCODE_UC)) {
-			pr_warn_ratelimited("bad qp type\n");
+			pr_warn_ratelimited("bad qp type for UC packet\n");
 			goto err1;
 		}
 		break;
@@ -51,7 +54,14 @@ static int check_type_state(struct rxe_dev *rxe, struct rxe_pkt_info *pkt,
 	case IB_QPT_SMI:
 	case IB_QPT_GSI:
 		if (unlikely(pkt_type != IB_OPCODE_UD)) {
-			pr_warn_ratelimited("bad qp type\n");
+			pr_warn_ratelimited("bad qp type for UD packet\n");
+			goto err1;
+		}
+		break;
+	case IB_QPT_XRC_INI:
+	case IB_QPT_XRC_TGT:
+		if (unlikely(pkt_type != IB_OPCODE_XRC)) {
+			pr_warn_ratelimited("bad qp type for XRC packet\n");
 			goto err1;
 		}
 		break;
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 166d4aeef5e9..592101ea0461 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -451,6 +451,7 @@ static struct sk_buff *init_req_packet(struct rxe_qp *qp,
 	paylen = rxe_opcode[opcode].length + payload + pad + RXE_ICRC_SIZE;
 
 	/* pkt->hdr, port_num and mask are initialized in ifc layer */
+	memset(pkt, 0, sizeof(*pkt));
 	pkt->rxe	= rxe;
 	pkt->opcode	= opcode;
 	pkt->qp		= qp;
@@ -507,7 +508,7 @@ static struct sk_buff *init_req_packet(struct rxe_qp *qp,
 	if (pkt->mask & RXE_ATMETH_MASK) {
 		atmeth_set_va(pkt, wqe->iova);
 		if (opcode == IB_OPCODE_RC_COMPARE_SWAP ||
-		    opcode == IB_OPCODE_RD_COMPARE_SWAP) {
+		    opcode == IB_OPCODE_XRC_COMPARE_SWAP) {
 			atmeth_set_swap_add(pkt, ibwr->wr.atomic.swap);
 			atmeth_set_comp(pkt, ibwr->wr.atomic.compare_add);
 		} else {
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index ac8d823eb416..4c57e5495d4c 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -35,6 +35,7 @@ enum resp_states {
 	RESPST_ERR_TOO_MANY_RDMA_ATM_REQ,
 	RESPST_ERR_RNR,
 	RESPST_ERR_RKEY_VIOLATION,
+	RESPST_ERR_INVALID_XRCETH,
 	RESPST_ERR_INVALIDATE_RKEY,
 	RESPST_ERR_LENGTH,
 	RESPST_ERR_CQ_OVERFLOW,
@@ -69,6 +70,7 @@ static char *resp_state_name[] = {
 	[RESPST_ERR_TOO_MANY_RDMA_ATM_REQ]	= "ERR_TOO_MANY_RDMA_ATM_REQ",
 	[RESPST_ERR_RNR]			= "ERR_RNR",
 	[RESPST_ERR_RKEY_VIOLATION]		= "ERR_RKEY_VIOLATION",
+	[RESPST_ERR_INVALID_XRCETH]		= "ERR_INVALID_XRCETH",
 	[RESPST_ERR_INVALIDATE_RKEY]		= "ERR_INVALIDATE_RKEY_VIOLATION",
 	[RESPST_ERR_LENGTH]			= "ERR_LENGTH",
 	[RESPST_ERR_CQ_OVERFLOW]		= "ERR_CQ_OVERFLOW",
@@ -122,6 +124,7 @@ static enum resp_states check_psn(struct rxe_qp *qp,
 
 	switch (rxe_qp_type(qp)) {
 	case IB_QPT_RC:
+	case IB_QPT_XRC_TGT:
 		if (diff > 0) {
 			if (qp->resp.sent_psn_nak)
 				return RESPST_CLEANUP;
@@ -243,6 +246,47 @@ static enum resp_states check_op_seq(struct rxe_qp *qp,
 		}
 		break;
 
+	case IB_QPT_XRC_TGT:
+		switch (qp->resp.opcode) {
+		case IB_OPCODE_XRC_SEND_FIRST:
+		case IB_OPCODE_XRC_SEND_MIDDLE:
+			switch (pkt->opcode) {
+			case IB_OPCODE_XRC_SEND_MIDDLE:
+			case IB_OPCODE_XRC_SEND_LAST:
+			case IB_OPCODE_XRC_SEND_LAST_WITH_IMMEDIATE:
+			case IB_OPCODE_XRC_SEND_LAST_WITH_INVALIDATE:
+				return RESPST_CHK_OP_VALID;
+			default:
+				return RESPST_ERR_MISSING_OPCODE_LAST_C;
+			}
+
+		case IB_OPCODE_XRC_RDMA_WRITE_FIRST:
+		case IB_OPCODE_XRC_RDMA_WRITE_MIDDLE:
+			switch (pkt->opcode) {
+			case IB_OPCODE_XRC_RDMA_WRITE_MIDDLE:
+			case IB_OPCODE_XRC_RDMA_WRITE_LAST:
+			case IB_OPCODE_XRC_RDMA_WRITE_LAST_WITH_IMMEDIATE:
+				return RESPST_CHK_OP_VALID;
+			default:
+				return RESPST_ERR_MISSING_OPCODE_LAST_C;
+			}
+
+		default:
+			switch (pkt->opcode) {
+			case IB_OPCODE_XRC_SEND_MIDDLE:
+			case IB_OPCODE_XRC_SEND_LAST:
+			case IB_OPCODE_XRC_SEND_LAST_WITH_IMMEDIATE:
+			case IB_OPCODE_XRC_SEND_LAST_WITH_INVALIDATE:
+			case IB_OPCODE_XRC_RDMA_WRITE_MIDDLE:
+			case IB_OPCODE_XRC_RDMA_WRITE_LAST:
+			case IB_OPCODE_XRC_RDMA_WRITE_LAST_WITH_IMMEDIATE:
+				return RESPST_ERR_MISSING_OPCODE_FIRST;
+			default:
+				return RESPST_CHK_OP_VALID;
+			}
+		}
+		break;
+
 	default:
 		return RESPST_CHK_OP_VALID;
 	}
@@ -253,6 +297,7 @@ static enum resp_states check_op_valid(struct rxe_qp *qp,
 {
 	switch (rxe_qp_type(qp)) {
 	case IB_QPT_RC:
+	case IB_QPT_XRC_TGT:
 		if (((pkt->mask & RXE_READ_MASK) &&
 		     !(qp->attr.qp_access_flags & IB_ACCESS_REMOTE_READ)) ||
 		    ((pkt->mask & RXE_WRITE_MASK) &&
@@ -286,9 +331,8 @@ static enum resp_states check_op_valid(struct rxe_qp *qp,
 	return RESPST_CHK_RESOURCE;
 }
 
-static enum resp_states get_srq_wqe(struct rxe_qp *qp)
+static enum resp_states get_srq_wqe(struct rxe_qp *qp, struct rxe_srq *srq)
 {
-	struct rxe_srq *srq = rxe_qp_srq(qp);
 	struct rxe_queue *q = srq->rq.queue;
 	struct rxe_recv_wqe *wqe;
 	struct ib_event ev;
@@ -339,8 +383,11 @@ static enum resp_states get_srq_wqe(struct rxe_qp *qp)
 static enum resp_states check_resource(struct rxe_qp *qp,
 				       struct rxe_pkt_info *pkt)
 {
-	struct rxe_srq *srq = rxe_qp_srq(qp);
+	struct rxe_srq *srq = NULL;
 
+	/* can come here from get_req() with no packet
+	 * to drain/flush recv work request queue
+	 */
 	if (qp->resp.state == QP_STATE_ERROR) {
 		if (qp->resp.wqe) {
 			qp->resp.status = IB_WC_WR_FLUSH_ERR;
@@ -359,6 +406,37 @@ static enum resp_states check_resource(struct rxe_qp *qp,
 		}
 	}
 
+	/* not supposed to happen */
+	if (WARN_ON_ONCE(!pkt))
+		return RESPST_EXIT;
+
+	/*
+	 * srq, pd and rcq can come from XRCSRQ or QP
+	 * decide which and store in pkt
+	 */
+	if (pkt->mask & RXE_XRCETH_MASK) {
+		int srq_num = xrceth_xrcsrq(pkt);
+
+		srq = rxe_pool_get_index(&pkt->rxe->srq_pool, srq_num);
+		if (!srq || rxe_qp_xrcd(qp) != rxe_srq_xrcd(srq)) {
+			pr_warn("Unable to get srq from xrceth\n");
+			return RESPST_ERR_INVALID_XRCETH;
+		}
+
+		pkt->srq = srq;
+		pkt->pd = rxe_srq_pd(srq);
+		pkt->rcq = rxe_srq_cq(srq);
+	} else {
+		srq = rxe_qp_srq(qp);
+		pkt->pd = rxe_qp_pd(qp);
+		pkt->rcq = rxe_qp_rcq(qp);
+	}
+
+	if (!pkt->pd)
+		pr_info("%s: no PD for pkt\n", __func__);
+	if (!pkt->rcq)
+		pr_info("%s: no RCQ for pkt\n", __func__);
+
 	if (pkt->mask & RXE_READ_OR_ATOMIC) {
 		/* it is the requesters job to not send
 		 * too many read/atomic ops, we just
@@ -372,7 +450,7 @@ static enum resp_states check_resource(struct rxe_qp *qp,
 
 	if (pkt->mask & RXE_RWR_MASK) {
 		if (srq)
-			return get_srq_wqe(qp);
+			return get_srq_wqe(qp, srq);
 
 		qp->resp.wqe = queue_head(qp->rq.queue,
 				QUEUE_TYPE_FROM_CLIENT);
@@ -387,6 +465,7 @@ static enum resp_states check_length(struct rxe_qp *qp,
 {
 	switch (rxe_qp_type(qp)) {
 	case IB_QPT_RC:
+	case IB_QPT_XRC_TGT:
 		return RESPST_CHK_RKEY;
 
 	case IB_QPT_UC:
@@ -443,16 +522,16 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 	pktlen	= payload_size(pkt);
 
 	if (rkey_is_mw(rkey)) {
-		mw = rxe_lookup_mw(qp, access, rkey);
+		mw = rxe_lookup_mw(pkt->pd, qp, access, rkey);
 		if (!mw) {
-			pr_err("%s: no MW matches rkey %#x\n", __func__, rkey);
+			pr_warn("%s: no MW matches rkey %#x\n", __func__, rkey);
 			state = RESPST_ERR_RKEY_VIOLATION;
 			goto err;
 		}
 
 		mr = mw->mr;
 		if (!mr) {
-			pr_err("%s: MW doesn't have an MR\n", __func__);
+			pr_warn("%s: MW doesn't have an MR\n", __func__);
 			state = RESPST_ERR_RKEY_VIOLATION;
 			goto err;
 		}
@@ -463,9 +542,9 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 		rxe_drop_ref(mw);
 		rxe_add_ref(mr);
 	} else {
-		mr = lookup_mr(rxe_qp_pd(qp), access, rkey, RXE_LOOKUP_REMOTE);
+		mr = lookup_mr(pkt->pd, access, rkey, RXE_LOOKUP_REMOTE);
 		if (!mr) {
-			pr_err("%s: no MR matches rkey %#x\n", __func__, rkey);
+			pr_warn("%s: no MR matches rkey %#x\n", __func__, rkey);
 			state = RESPST_ERR_RKEY_VIOLATION;
 			goto err;
 		}
@@ -511,12 +590,12 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 	return state;
 }
 
-static enum resp_states send_data_in(struct rxe_qp *qp, void *data_addr,
-				     int data_len)
+static enum resp_states send_data_in(struct rxe_pd *pd, struct rxe_qp *qp,
+				     void *data_addr, int data_len)
 {
 	int err;
 
-	err = copy_data(rxe_qp_pd(qp), IB_ACCESS_LOCAL_WRITE, &qp->resp.wqe->dma,
+	err = copy_data(pd, IB_ACCESS_LOCAL_WRITE, &qp->resp.wqe->dma,
 			data_addr, data_len, RXE_TO_MR_OBJ);
 	if (unlikely(err))
 		return (err == -ENOSPC) ? RESPST_ERR_LENGTH
@@ -574,7 +653,7 @@ static enum resp_states process_atomic(struct rxe_qp *qp,
 	qp->resp.atomic_orig = *vaddr;
 
 	if (pkt->opcode == IB_OPCODE_RC_COMPARE_SWAP ||
-	    pkt->opcode == IB_OPCODE_RD_COMPARE_SWAP) {
+	    pkt->opcode == IB_OPCODE_XRC_COMPARE_SWAP) {
 		if (*vaddr == atmeth_comp(pkt))
 			*vaddr = atmeth_swap_add(pkt);
 	} else {
@@ -705,6 +784,10 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 			opcode = IB_OPCODE_RC_RDMA_READ_RESPONSE_LAST;
 	}
 
+	/* fixup opcode if this is XRC add 0xa0 */
+	if (rxe_qp_type(qp) == IB_QPT_XRC_TGT)
+		opcode += IB_OPCODE_XRC;
+
 	res->state = rdatm_res_state_next;
 
 	payload = min_t(int, res->read.resid, mtu);
@@ -717,7 +800,7 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 	err = rxe_mr_copy(res->read.mr, res->read.va, payload_addr(&ack_pkt),
 			  payload, RXE_FROM_MR_OBJ);
 	if (err)
-		pr_err("Failed copying memory\n");
+		pr_warn("Failed copying memory\n");
 
 	if (bth_pad(&ack_pkt)) {
 		u8 *pad = payload_addr(&ack_pkt) + payload;
@@ -727,7 +810,7 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 
 	err = rxe_xmit_packet(qp, &ack_pkt, skb);
 	if (err) {
-		pr_err("Failed sending RDMA reply.\n");
+		pr_warn("Failed sending RDMA reply.\n");
 		return RESPST_ERR_RNR;
 	}
 
@@ -775,15 +858,17 @@ static enum resp_states execute(struct rxe_qp *qp, struct rxe_pkt_info *pkt)
 						sizeof(hdr.reserved));
 				memcpy(&hdr.roce4grh, ip_hdr(skb),
 						sizeof(hdr.roce4grh));
-				err = send_data_in(qp, &hdr, sizeof(hdr));
+				err = send_data_in(pkt->pd, qp, &hdr,
+						   sizeof(hdr));
 			} else {
-				err = send_data_in(qp, ipv6_hdr(skb),
-						sizeof(hdr));
+				err = send_data_in(pkt->pd, qp, ipv6_hdr(skb),
+						   sizeof(hdr));
 			}
 			if (err)
 				return err;
 		}
-		err = send_data_in(qp, payload_addr(pkt), payload_size(pkt));
+		err = send_data_in(pkt->pd, qp, payload_addr(pkt),
+				   payload_size(pkt));
 		if (err)
 			return err;
 	} else if (pkt->mask & RXE_WRITE_MASK) {
@@ -822,7 +907,8 @@ static enum resp_states execute(struct rxe_qp *qp, struct rxe_pkt_info *pkt)
 		/* We successfully processed this new request. */
 		qp->resp.msn++;
 		return RESPST_COMPLETE;
-	} else if (rxe_qp_type(qp) == IB_QPT_RC)
+	} else if (rxe_qp_type(qp) == IB_QPT_RC ||
+		   rxe_qp_type(qp) == IB_QPT_XRC_TGT)
 		return RESPST_ACKNOWLEDGE;
 	else
 		return RESPST_CLEANUP;
@@ -836,13 +922,19 @@ static enum resp_states do_complete(struct rxe_qp *qp,
 	struct ib_uverbs_wc *uwc = &cqe.uibwc;
 	struct rxe_recv_wqe *wqe = qp->resp.wqe;
 	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
+	struct rxe_cq *rcq;
+
+	/* can come here from check_resources to flush the
+	 * recv work queue entries. Otherwise pkt will be there
+	 */
+	rcq = pkt ? pkt->rcq : rxe_qp_rcq(qp);
 
 	if (!wqe)
 		goto finish;
 
 	memset(&cqe, 0, sizeof(cqe));
 
-	if (rxe_qp_rcq(qp)->is_user) {
+	if (rcq->is_user) {
 		uwc->status		= qp->resp.status;
 		uwc->qp_num		= rxe_qp_num(qp);
 		uwc->wr_id		= wqe->wr_id;
@@ -865,7 +957,7 @@ static enum resp_states do_complete(struct rxe_qp *qp,
 		/* fields after byte_len are different between kernel and user
 		 * space
 		 */
-		if (rxe_qp_rcq(qp)->is_user) {
+		if (rcq->is_user) {
 			uwc->wc_flags = IB_WC_GRH;
 
 			if (pkt->mask & RXE_IMMDT_MASK) {
@@ -917,12 +1009,12 @@ static enum resp_states do_complete(struct rxe_qp *qp,
 	}
 
 	/* have copy for srq and reference for !srq */
-	if (!rxe_qp_srq(qp))
+	if (qp->rq.queue)
 		advance_consumer(qp->rq.queue, QUEUE_TYPE_FROM_CLIENT);
 
 	qp->resp.wqe = NULL;
 
-	if (rxe_cq_post(rxe_qp_rcq(qp), &cqe, pkt ? bth_se(pkt) : 1))
+	if (rxe_cq_post(rcq, &cqe, pkt ? bth_se(pkt) : 1))
 		return RESPST_ERR_CQ_OVERFLOW;
 
 finish:
@@ -930,7 +1022,8 @@ static enum resp_states do_complete(struct rxe_qp *qp,
 		return RESPST_CHK_RESOURCE;
 	if (unlikely(!pkt))
 		return RESPST_DONE;
-	if (rxe_qp_type(qp) == IB_QPT_RC)
+	if (rxe_qp_type(qp) == IB_QPT_RC ||
+	    rxe_qp_type(qp) == IB_QPT_XRC_TGT)
 		return RESPST_ACKNOWLEDGE;
 	else
 		return RESPST_CLEANUP;
@@ -942,8 +1035,13 @@ static int send_ack(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
 	int err = 0;
 	struct rxe_pkt_info ack_pkt;
 	struct sk_buff *skb;
+	int opcode;
+
+	opcode = (rxe_qp_type(qp) == IB_QPT_XRC_TGT) ?
+		IB_OPCODE_XRC_ACKNOWLEDGE :
+		IB_OPCODE_RC_ACKNOWLEDGE;
 
-	skb = prepare_ack_packet(qp, pkt, &ack_pkt, IB_OPCODE_RC_ACKNOWLEDGE,
+	skb = prepare_ack_packet(qp, pkt, &ack_pkt, opcode,
 				 0, psn, syndrome);
 	if (!skb) {
 		err = -ENOMEM;
@@ -952,7 +1050,7 @@ static int send_ack(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
 
 	err = rxe_xmit_packet(qp, &ack_pkt, skb);
 	if (err)
-		pr_err_ratelimited("Failed sending ack\n");
+		pr_warn("Failed sending ack\n");
 
 err1:
 	return err;
@@ -987,7 +1085,7 @@ static int send_atomic_ack(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
 
 	rc = rxe_xmit_packet(qp, &ack_pkt, skb);
 	if (rc) {
-		pr_err_ratelimited("Failed sending ack\n");
+		pr_warn("Failed sending ack\n");
 		rxe_drop_ref(qp);
 	}
 out:
@@ -997,7 +1095,8 @@ static int send_atomic_ack(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
 static enum resp_states acknowledge(struct rxe_qp *qp,
 				    struct rxe_pkt_info *pkt)
 {
-	if (rxe_qp_type(qp) != IB_QPT_RC)
+	if (rxe_qp_type(qp) != IB_QPT_RC &&
+	    rxe_qp_type(qp) != IB_QPT_XRC_TGT)
 		return RESPST_CLEANUP;
 
 	if (qp->resp.aeth_syndrome != AETH_ACK_UNLIMITED)
@@ -1114,7 +1213,7 @@ static enum resp_states duplicate_request(struct rxe_qp *qp,
 			/* Resend the result. */
 			rc = rxe_xmit_packet(qp, pkt, res->atomic.skb);
 			if (rc) {
-				pr_err("Failed resending result. This flow is not handled - skb ignored\n");
+				pr_warn("Failed resending result. This flow is not handled - skb ignored\n");
 				rc = RESPST_CLEANUP;
 				goto out;
 			}
@@ -1176,7 +1275,7 @@ static enum resp_states do_class_d1e_error(struct rxe_qp *qp)
 static void rxe_drain_req_pkts(struct rxe_qp *qp, bool notify)
 {
 	struct sk_buff *skb;
-	struct rxe_queue *q = qp->rq.queue;
+	struct rxe_queue *q;
 
 	while ((skb = skb_dequeue(&qp->req_pkts)))
 		rxe_free_pkt(SKB_TO_PKT(skb));
@@ -1184,7 +1283,11 @@ static void rxe_drain_req_pkts(struct rxe_qp *qp, bool notify)
 	if (notify)
 		return;
 
-	while (!rxe_qp_srq(qp) && q && queue_head(q, q->type))
+	q = qp->rq.queue;
+	if (!q)
+		return;
+
+	while (queue_head(q, q->type))
 		advance_consumer(q, q->type);
 }
 
@@ -1216,8 +1319,8 @@ int rxe_responder(void *arg)
 	}
 
 	while (1) {
-		pr_debug("qp#%d state = %s\n", rxe_qp_num(qp),
-			 resp_state_name[state]);
+		pr_debug("qp#%d type=%d state = %s\n", rxe_qp_num(qp),
+			 rxe_qp_type(qp), resp_state_name[state]);
 		switch (state) {
 		case RESPST_GET_REQ:
 			state = get_req(qp, &pkt);
@@ -1279,7 +1382,8 @@ int rxe_responder(void *arg)
 			state = do_class_d1e_error(qp);
 			break;
 		case RESPST_ERR_RNR:
-			if (rxe_qp_type(qp) == IB_QPT_RC) {
+			if (rxe_qp_type(qp) == IB_QPT_RC ||
+			    rxe_qp_type(qp) == IB_QPT_XRC_TGT) {
 				rxe_counter_inc(rxe, RXE_CNT_SND_RNR);
 				/* RC - class B */
 				send_ack(qp, pkt, AETH_RNR_NAK |
@@ -1294,7 +1398,8 @@ int rxe_responder(void *arg)
 			break;
 
 		case RESPST_ERR_RKEY_VIOLATION:
-			if (rxe_qp_type(qp) == IB_QPT_RC) {
+			if (rxe_qp_type(qp) == IB_QPT_RC ||
+			    rxe_qp_type(qp) == IB_QPT_XRC_TGT) {
 				/* Class C */
 				do_class_ac_error(qp, AETH_NAK_REM_ACC_ERR,
 						  IB_WC_REM_ACCESS_ERR);
@@ -1312,6 +1417,17 @@ int rxe_responder(void *arg)
 			}
 			break;
 
+		case RESPST_ERR_INVALID_XRCETH:
+			if (rxe_qp_type(qp) == IB_QPT_XRC_TGT) {
+				do_class_ac_error(qp, AETH_NAK_REM_ACC_ERR,
+						  IB_WC_REM_ACCESS_ERR);
+				state = RESPST_COMPLETE;
+			} else {
+				pr_info("can't happen\n");
+				state = RESPST_CLEANUP;
+			}
+			break;
+
 		case RESPST_ERR_INVALIDATE_RKEY:
 			/* RC - Class J. */
 			qp->resp.goto_error = 1;
@@ -1320,7 +1436,8 @@ int rxe_responder(void *arg)
 			break;
 
 		case RESPST_ERR_LENGTH:
-			if (rxe_qp_type(qp) == IB_QPT_RC) {
+			if (rxe_qp_type(qp) == IB_QPT_RC ||
+			    rxe_qp_type(qp) == IB_QPT_XRC_TGT) {
 				/* Class C */
 				do_class_ac_error(qp, AETH_NAK_INVALID_REQ,
 						  IB_WC_REM_INV_REQ_ERR);
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 52599f398ddd..1fdd07d6a94d 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -475,11 +475,13 @@ static inline struct rxe_mw *to_rmw(struct ib_mw *mw)
 	return mw ? container_of(mw, struct rxe_mw, ibmw) : NULL;
 }
 
+/* AH extractors */
 static inline struct rxe_pd *rxe_ah_pd(struct rxe_ah *ah)
 {
 	return to_rpd(ah->ibah.pd);
 }
 
+/* MR extractors */
 static inline struct rxe_pd *rxe_mr_pd(struct rxe_mr *mr)
 {
 	return to_rpd(mr->ibmr.pd);
@@ -495,6 +497,7 @@ static inline u32 rxe_mr_rkey(struct rxe_mr *mr)
 	return mr->ibmr.rkey;
 }
 
+/* MW extractors */
 static inline struct rxe_pd *rxe_mw_pd(struct rxe_mw *mw)
 {
 	return to_rpd(mw->ibmw.pd);
@@ -531,6 +534,11 @@ static inline struct rxe_srq *rxe_qp_srq(struct rxe_qp *qp)
 	return to_rsrq(qp->ibqp.srq);
 }
 
+static inline struct rxe_xrcd *rxe_qp_xrcd(struct rxe_qp *qp)
+{
+	return to_rxrcd(qp->ibqp.xrcd);
+}
+
 static inline enum ib_qp_state rxe_qp_state(struct rxe_qp *qp)
 {
 	return qp->attr.qp_state;
@@ -557,14 +565,14 @@ static inline struct rxe_pd *rxe_srq_pd(struct rxe_srq *srq)
 	return to_rpd(srq->ibsrq.pd);
 }
 
-static inline enum ib_srq_type rxe_srq_type(struct rxe_srq *srq)
+static inline struct rxe_xrcd *rxe_srq_xrcd(struct rxe_srq *srq)
 {
-	return srq->ibsrq.srq_type;
+	return to_rxrcd(srq->ibsrq.ext.xrc.xrcd);
 }
 
-static inline struct rxe_xrcd *rxe_srq_xrcd(struct rxe_srq *srq)
+static inline enum ib_srq_type rxe_srq_type(struct rxe_srq *srq)
 {
-	return to_rxrcd(srq->ibsrq.ext.xrc.xrcd);
+	return srq->ibsrq.srq_type;
 }
 
 int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name);
-- 
2.30.2

