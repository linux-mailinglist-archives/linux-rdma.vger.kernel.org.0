Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9297B5BB5CB
	for <lists+linux-rdma@lfdr.de>; Sat, 17 Sep 2022 05:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiIQDLv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Sep 2022 23:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiIQDLW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 16 Sep 2022 23:11:22 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A17BD132
        for <linux-rdma@vger.kernel.org>; Fri, 16 Sep 2022 20:11:20 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id br15-20020a056830390f00b0061c9d73b8bdso16102436otb.6
        for <linux-rdma@vger.kernel.org>; Fri, 16 Sep 2022 20:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Ui/s4dF0I6Izv/NUMyg9qVP6krfiZ0OXxFPfLW8eZPo=;
        b=pNPWxwPwC71W0dm1J4LOKOlw3JaL9ZU9oRrit6y1Lmq0qctkv81Y3H6ty4eR2agJjb
         GFXZXgGlfjLm3fPt8aEPAorOUWylAHl8MnaCntZX5gM10b7zGVnvweJGVu1EcyFYikbn
         kT8GnhVRv8l+FhDSM3vWc9hpH+zzZ6shMtWzuLkHKi8SpdDwdc4h6m21c6Yyi4eB1tz4
         2TVoImD/OGQuJTpDodauha91AaozLkVv2vTDObTkjRo1oA6qxdNuFRi3ioU9yuphbN3K
         XsFPiHRnK3lUHSIn8WpWLb1UpjV+6KjtxGEYwHrNQhtisHECWUT+JneCv0zsKhAvWMkA
         m1iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Ui/s4dF0I6Izv/NUMyg9qVP6krfiZ0OXxFPfLW8eZPo=;
        b=70BCDoZVerMWWwss08ZZAgmBLURJyOLAnN1+rVPDqM7f+rgq2XL4mhGcBTtFuGSzTi
         sRAV00iNGwLndM1Id7QrSvYoS2HLO7yTs0IjOR9yBUE+idzlPtQptFlhlZ2ups2I4r7L
         kwwD46sOtoD027BssKeFGzc5lnevVD34h57D402CKT4+T7xvz2poD7uRYzof1TqD9+/J
         UCOqduir0/YfueFNLg0RYj+k3MspZJVkBK/1PPum7E1bREI5Zwzmcms/9b0JRfuTLOkx
         hEVaOwhZ3l16rXHf698LwWue5kAOpnOHYAVOJ9zbqx/ekMT+oIEzPHgnNqc+I8Fzr7/f
         Mzxg==
X-Gm-Message-State: ACrzQf01w/89UBsS/aa8LEkrk9Haws8ApOjduo/pxnCc7IrFLViMaeqT
        rngiiD7AdKVEZaFbJ8+AI2E=
X-Google-Smtp-Source: AMsMyM7bqSov08aEZR5dlcyl8p8rQxuYcfb7gZGjGV9TVBuZKQHyBN+z0X5/BaumuX9Ciq8GXFOH1Q==
X-Received: by 2002:a9d:6b0e:0:b0:657:1e3:7251 with SMTP id g14-20020a9d6b0e000000b0065701e37251mr3507617otp.267.1663384280420;
        Fri, 16 Sep 2022 20:11:20 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-f9ea-fe1d-a45c-bca2.res6.spectrum.com. [2603:8081:140c:1a00:f9ea:fe1d:a45c:bca2])
        by smtp.googlemail.com with ESMTPSA id q17-20020a4a6c11000000b00475f26931c8sm921422ooc.13.2022.09.16.20.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 20:11:19 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, lizhijian@fujitsu.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 13/13] RDMA/rxe: Extend rxe_resp.c to support xrc qps
Date:   Fri, 16 Sep 2022 22:11:04 -0500
Message-Id: <20220917031104.21222-14-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220917031104.21222-1-rpearsonhpe@gmail.com>
References: <20220917031104.21222-1-rpearsonhpe@gmail.com>
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

Extend code in rxe_resp.c to support xrc qp types.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_loc.h  |   3 +-
 drivers/infiniband/sw/rxe/rxe_mw.c   |  14 +--
 drivers/infiniband/sw/rxe/rxe_resp.c | 161 +++++++++++++++++++++------
 3 files changed, 138 insertions(+), 40 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index c6fb93a749ad..9381c76bff87 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -87,7 +87,8 @@ int rxe_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata);
 int rxe_dealloc_mw(struct ib_mw *ibmw);
 int rxe_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe);
 int rxe_invalidate_mw(struct rxe_qp *qp, u32 rkey);
-struct rxe_mw *rxe_lookup_mw(struct rxe_qp *qp, int access, u32 rkey);
+struct rxe_mw *rxe_lookup_mw(struct rxe_pd *pd, struct rxe_qp *qp,
+			     int access, u32 rkey);
 void rxe_mw_cleanup(struct rxe_pool_elem *elem);
 
 /* rxe_net.c */
diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
index 104993801a80..2a7493526ec2 100644
--- a/drivers/infiniband/sw/rxe/rxe_mw.c
+++ b/drivers/infiniband/sw/rxe/rxe_mw.c
@@ -280,10 +280,10 @@ int rxe_invalidate_mw(struct rxe_qp *qp, u32 rkey)
 	return ret;
 }
 
-struct rxe_mw *rxe_lookup_mw(struct rxe_qp *qp, int access, u32 rkey)
+struct rxe_mw *rxe_lookup_mw(struct rxe_pd *pd, struct rxe_qp *qp,
+			     int access, u32 rkey)
 {
 	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
-	struct rxe_pd *pd = to_rpd(qp->ibqp.pd);
 	struct rxe_mw *mw;
 	int index = rkey >> 8;
 
@@ -291,11 +291,11 @@ struct rxe_mw *rxe_lookup_mw(struct rxe_qp *qp, int access, u32 rkey)
 	if (!mw)
 		return NULL;
 
-	if (unlikely((mw->rkey != rkey) || rxe_mw_pd(mw) != pd ||
-		     (mw->ibmw.type == IB_MW_TYPE_2 && mw->qp != qp) ||
-		     (mw->length == 0) ||
-		     (access && !(access & mw->access)) ||
-		     mw->state != RXE_MW_STATE_VALID)) {
+	if ((mw->rkey != rkey) || rxe_mw_pd(mw) != pd ||
+	    (mw->ibmw.type == IB_MW_TYPE_2 &&
+	     (mw->qp != qp || qp_type(qp) == IB_QPT_XRC_TGT)) ||
+	    (mw->length == 0) || (access && !(access & mw->access)) ||
+	    mw->state != RXE_MW_STATE_VALID) {
 		rxe_put(mw);
 		return NULL;
 	}
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index cb560cbe418d..b0a97074bc5a 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -88,7 +88,8 @@ void rxe_resp_queue_pkt(struct rxe_qp *qp, struct sk_buff *skb)
 
 	skb_queue_tail(&qp->req_pkts, skb);
 
-	must_sched = (pkt->opcode == IB_OPCODE_RC_RDMA_READ_REQUEST) ||
+	/* mask off opcode type bits */
+	must_sched = ((pkt->opcode & 0x1f) == IB_OPCODE_RDMA_READ_REQUEST) ||
 			(skb_queue_len(&qp->req_pkts) > 1);
 
 	rxe_run_task(&qp->resp.task, must_sched);
@@ -127,6 +128,7 @@ static enum resp_states check_psn(struct rxe_qp *qp,
 
 	switch (qp_type(qp)) {
 	case IB_QPT_RC:
+	case IB_QPT_XRC_TGT:
 		if (diff > 0) {
 			if (qp->resp.sent_psn_nak)
 				return RESPST_CLEANUP;
@@ -156,6 +158,7 @@ static enum resp_states check_psn(struct rxe_qp *qp,
 			return RESPST_CLEANUP;
 		}
 		break;
+
 	default:
 		break;
 	}
@@ -248,6 +251,47 @@ static enum resp_states check_op_seq(struct rxe_qp *qp,
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
@@ -258,6 +302,7 @@ static enum resp_states check_op_valid(struct rxe_qp *qp,
 {
 	switch (qp_type(qp)) {
 	case IB_QPT_RC:
+	case IB_QPT_XRC_TGT:
 		if (((pkt->mask & RXE_READ_MASK) &&
 		     !(qp->attr.qp_access_flags & IB_ACCESS_REMOTE_READ)) ||
 		    ((pkt->mask & RXE_WRITE_MASK) &&
@@ -290,9 +335,22 @@ static enum resp_states check_op_valid(struct rxe_qp *qp,
 	return RESPST_CHK_RESOURCE;
 }
 
-static enum resp_states get_srq_wqe(struct rxe_qp *qp)
+static struct rxe_srq *get_srq(struct rxe_qp *qp, struct rxe_pkt_info *pkt)
+{
+	struct rxe_srq *srq;
+
+	if (qp_type(qp) == IB_QPT_XRC_TGT)
+		srq = pkt->srq;
+	else if (qp->srq)
+		srq = qp->srq;
+	else
+		srq = NULL;
+
+	return srq;
+}
+
+static enum resp_states get_srq_wqe(struct rxe_qp *qp, struct rxe_srq *srq)
 {
-	struct rxe_srq *srq = qp->srq;
 	struct rxe_queue *q = srq->rq.queue;
 	struct rxe_recv_wqe *wqe;
 	struct ib_event ev;
@@ -344,7 +402,7 @@ static enum resp_states get_srq_wqe(struct rxe_qp *qp)
 static enum resp_states check_resource(struct rxe_qp *qp,
 				       struct rxe_pkt_info *pkt)
 {
-	struct rxe_srq *srq = qp->srq;
+	struct rxe_srq *srq = get_srq(qp, pkt);
 
 	if (qp->resp.state == QP_STATE_ERROR) {
 		if (qp->resp.wqe) {
@@ -377,7 +435,7 @@ static enum resp_states check_resource(struct rxe_qp *qp,
 
 	if (pkt->mask & RXE_RWR_MASK) {
 		if (srq)
-			return get_srq_wqe(qp);
+			return get_srq_wqe(qp, srq);
 
 		qp->resp.wqe = queue_head(qp->rq.queue,
 				QUEUE_TYPE_FROM_CLIENT);
@@ -387,6 +445,7 @@ static enum resp_states check_resource(struct rxe_qp *qp,
 	return RESPST_CHK_LENGTH;
 }
 
+/* TODO this should actually do what it says per IBA spec */
 static enum resp_states check_length(struct rxe_qp *qp,
 				     struct rxe_pkt_info *pkt)
 {
@@ -397,6 +456,9 @@ static enum resp_states check_length(struct rxe_qp *qp,
 	case IB_QPT_UC:
 		return RESPST_CHK_RKEY;
 
+	case IB_QPT_XRC_TGT:
+		return RESPST_CHK_RKEY;
+
 	default:
 		return RESPST_CHK_RKEY;
 	}
@@ -407,6 +469,7 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 {
 	struct rxe_mr *mr = NULL;
 	struct rxe_mw *mw = NULL;
+	struct rxe_pd *pd;
 	u64 va;
 	u32 rkey;
 	u32 resid;
@@ -447,8 +510,11 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 	resid	= qp->resp.resid;
 	pktlen	= payload_size(pkt);
 
+	/* we have ref counts on qp and pkt->srq so this is just a temp */
+	pd = (qp_type(qp) == IB_QPT_XRC_TGT) ? pkt->srq->pd : qp->pd;
+
 	if (rkey_is_mw(rkey)) {
-		mw = rxe_lookup_mw(qp, access, rkey);
+		mw = rxe_lookup_mw(pd, qp, access, rkey);
 		if (!mw) {
 			pr_debug("%s: no MW matches rkey %#x\n",
 					__func__, rkey);
@@ -469,7 +535,7 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 		rxe_put(mw);
 		rxe_get(mr);
 	} else {
-		mr = lookup_mr(qp->pd, access, rkey, RXE_LOOKUP_REMOTE);
+		mr = lookup_mr(pd, access, rkey, RXE_LOOKUP_REMOTE);
 		if (!mr) {
 			pr_debug("%s: no MR matches rkey %#x\n",
 					__func__, rkey);
@@ -518,12 +584,12 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 	return state;
 }
 
-static enum resp_states send_data_in(struct rxe_qp *qp, void *data_addr,
-				     int data_len)
+static enum resp_states send_data_in(struct rxe_pd *pd, struct rxe_qp *qp,
+				     void *data_addr, int data_len)
 {
 	int err;
 
-	err = copy_data(qp->pd, IB_ACCESS_LOCAL_WRITE, &qp->resp.wqe->dma,
+	err = copy_data(pd, IB_ACCESS_LOCAL_WRITE, &qp->resp.wqe->dma,
 			data_addr, data_len, RXE_TO_MR_OBJ);
 	if (unlikely(err))
 		return (err == -ENOSPC) ? RESPST_ERR_LENGTH
@@ -627,7 +693,8 @@ static enum resp_states atomic_reply(struct rxe_qp *qp,
 		spin_lock_bh(&atomic_ops_lock);
 		res->atomic.orig_val = value = *vaddr;
 
-		if (pkt->opcode == IB_OPCODE_RC_COMPARE_SWAP) {
+		if (pkt->opcode == IB_OPCODE_RC_COMPARE_SWAP ||
+		    pkt->opcode == IB_OPCODE_XRC_COMPARE_SWAP) {
 			if (value == atmeth_comp(pkt))
 				value = atmeth_swap_add(pkt);
 		} else {
@@ -786,24 +853,30 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 		}
 
 		if (res->read.resid <= mtu)
-			opcode = IB_OPCODE_RC_RDMA_READ_RESPONSE_ONLY;
+			opcode = IB_OPCODE_RDMA_READ_RESPONSE_ONLY;
 		else
-			opcode = IB_OPCODE_RC_RDMA_READ_RESPONSE_FIRST;
+			opcode = IB_OPCODE_RDMA_READ_RESPONSE_FIRST;
 	} else {
 		mr = rxe_recheck_mr(qp, res->read.rkey);
 		if (!mr)
 			return RESPST_ERR_RKEY_VIOLATION;
 
 		if (res->read.resid > mtu)
-			opcode = IB_OPCODE_RC_RDMA_READ_RESPONSE_MIDDLE;
+			opcode = IB_OPCODE_RDMA_READ_RESPONSE_MIDDLE;
 		else
-			opcode = IB_OPCODE_RC_RDMA_READ_RESPONSE_LAST;
+			opcode = IB_OPCODE_RDMA_READ_RESPONSE_LAST;
 	}
 
 	res->state = rdatm_res_state_next;
 
 	payload = min_t(int, res->read.resid, mtu);
 
+	/* fixup opcode type */
+	if (qp_type(qp) == IB_QPT_XRC_TGT)
+		opcode |= IB_OPCODE_XRC;
+	else
+		opcode |= IB_OPCODE_RC;
+
 	skb = prepare_ack_packet(qp, &ack_pkt, opcode, payload,
 				 res->cur_psn, AETH_ACK_UNLIMITED);
 	if (!skb)
@@ -858,6 +931,8 @@ static enum resp_states execute(struct rxe_qp *qp, struct rxe_pkt_info *pkt)
 	enum resp_states err;
 	struct sk_buff *skb = PKT_TO_SKB(pkt);
 	union rdma_network_hdr hdr;
+	struct rxe_pd *pd = (qp_type(qp) == IB_QPT_XRC_TGT) ?
+						pkt->srq->pd : qp->pd;
 
 	if (pkt->mask & RXE_SEND_MASK) {
 		if (qp_type(qp) == IB_QPT_UD ||
@@ -867,15 +942,15 @@ static enum resp_states execute(struct rxe_qp *qp, struct rxe_pkt_info *pkt)
 						sizeof(hdr.reserved));
 				memcpy(&hdr.roce4grh, ip_hdr(skb),
 						sizeof(hdr.roce4grh));
-				err = send_data_in(qp, &hdr, sizeof(hdr));
+				err = send_data_in(pd, qp, &hdr, sizeof(hdr));
 			} else {
-				err = send_data_in(qp, ipv6_hdr(skb),
+				err = send_data_in(pd, qp, ipv6_hdr(skb),
 						sizeof(hdr));
 			}
 			if (err)
 				return err;
 		}
-		err = send_data_in(qp, payload_addr(pkt), payload_size(pkt));
+		err = send_data_in(pd, qp, payload_addr(pkt), payload_size(pkt));
 		if (err)
 			return err;
 	} else if (pkt->mask & RXE_WRITE_MASK) {
@@ -914,7 +989,7 @@ static enum resp_states execute(struct rxe_qp *qp, struct rxe_pkt_info *pkt)
 
 	if (pkt->mask & RXE_COMP_MASK)
 		return RESPST_COMPLETE;
-	else if (qp_type(qp) == IB_QPT_RC)
+	else if (qp_type(qp) == IB_QPT_RC || qp_type(qp) == IB_QPT_XRC_TGT)
 		return RESPST_ACKNOWLEDGE;
 	else
 		return RESPST_CLEANUP;
@@ -928,13 +1003,21 @@ static enum resp_states do_complete(struct rxe_qp *qp,
 	struct ib_uverbs_wc *uwc = &cqe.uibwc;
 	struct rxe_recv_wqe *wqe = qp->resp.wqe;
 	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
+	struct rxe_cq *cq;
+	struct rxe_srq *srq;
 
 	if (!wqe)
 		goto finish;
 
 	memset(&cqe, 0, sizeof(cqe));
 
-	if (qp->rcq->is_user) {
+	/* srq and cq if != 0 are protected by references held by qp or pkt */
+	srq = (qp_type(qp) == IB_QPT_XRC_TGT) ? pkt->srq : qp->srq;
+	cq = (qp_type(qp) == IB_QPT_XRC_TGT) ? pkt->srq->cq : qp->rcq;
+
+	WARN_ON(!cq);
+
+	if (cq->is_user) {
 		uwc->status		= qp->resp.status;
 		uwc->qp_num		= qp->ibqp.qp_num;
 		uwc->wr_id		= wqe->wr_id;
@@ -956,7 +1039,7 @@ static enum resp_states do_complete(struct rxe_qp *qp,
 		/* fields after byte_len are different between kernel and user
 		 * space
 		 */
-		if (qp->rcq->is_user) {
+		if (cq->is_user) {
 			uwc->wc_flags = IB_WC_GRH;
 
 			if (pkt->mask & RXE_IMMDT_MASK) {
@@ -1005,12 +1088,13 @@ static enum resp_states do_complete(struct rxe_qp *qp,
 	}
 
 	/* have copy for srq and reference for !srq */
-	if (!qp->srq)
+	if (!srq)
 		queue_advance_consumer(qp->rq.queue, QUEUE_TYPE_FROM_CLIENT);
 
 	qp->resp.wqe = NULL;
 
-	if (rxe_cq_post(qp->rcq, &cqe, pkt ? bth_se(pkt) : 1))
+	/* either qp or srq is holding a reference to cq */
+	if (rxe_cq_post(cq, &cqe, pkt ? bth_se(pkt) : 1))
 		return RESPST_ERR_CQ_OVERFLOW;
 
 finish:
@@ -1018,7 +1102,7 @@ static enum resp_states do_complete(struct rxe_qp *qp,
 		return RESPST_CHK_RESOURCE;
 	if (unlikely(!pkt))
 		return RESPST_DONE;
-	if (qp_type(qp) == IB_QPT_RC)
+	if (qp_type(qp) == IB_QPT_RC || qp_type(qp) == IB_QPT_XRC_TGT)
 		return RESPST_ACKNOWLEDGE;
 	else
 		return RESPST_CLEANUP;
@@ -1029,9 +1113,13 @@ static int send_ack(struct rxe_qp *qp, u8 syndrome, u32 psn)
 	int err = 0;
 	struct rxe_pkt_info ack_pkt;
 	struct sk_buff *skb;
+	int opcode;
+
+	opcode = (qp_type(qp) == IB_QPT_XRC_TGT) ?
+				IB_OPCODE_XRC_ACKNOWLEDGE :
+				IB_OPCODE_RC_ACKNOWLEDGE;
 
-	skb = prepare_ack_packet(qp, &ack_pkt, IB_OPCODE_RC_ACKNOWLEDGE,
-				 0, psn, syndrome);
+	skb = prepare_ack_packet(qp, &ack_pkt, opcode, 0, psn, syndrome);
 	if (!skb) {
 		err = -ENOMEM;
 		goto err1;
@@ -1050,9 +1138,13 @@ static int send_atomic_ack(struct rxe_qp *qp, u8 syndrome, u32 psn)
 	int err = 0;
 	struct rxe_pkt_info ack_pkt;
 	struct sk_buff *skb;
+	int opcode;
+
+	opcode = (qp_type(qp) == IB_QPT_XRC_TGT) ?
+				IB_OPCODE_XRC_ATOMIC_ACKNOWLEDGE :
+				IB_OPCODE_RC_ATOMIC_ACKNOWLEDGE;
 
-	skb = prepare_ack_packet(qp, &ack_pkt, IB_OPCODE_RC_ATOMIC_ACKNOWLEDGE,
-				 0, psn, syndrome);
+	skb = prepare_ack_packet(qp, &ack_pkt, opcode, 0, psn, syndrome);
 	if (!skb) {
 		err = -ENOMEM;
 		goto out;
@@ -1073,7 +1165,7 @@ static int send_atomic_ack(struct rxe_qp *qp, u8 syndrome, u32 psn)
 static enum resp_states acknowledge(struct rxe_qp *qp,
 				    struct rxe_pkt_info *pkt)
 {
-	if (qp_type(qp) != IB_QPT_RC)
+	if (qp_type(qp) != IB_QPT_RC && qp_type(qp) != IB_QPT_XRC_TGT)
 		return RESPST_CLEANUP;
 
 	if (qp->resp.aeth_syndrome != AETH_ACK_UNLIMITED)
@@ -1094,6 +1186,8 @@ static enum resp_states cleanup(struct rxe_qp *qp,
 	if (pkt) {
 		skb = skb_dequeue(&qp->req_pkts);
 		rxe_put(qp);
+		if (pkt->srq)
+			rxe_put(pkt->srq);
 		kfree_skb(skb);
 		ib_device_put(qp->ibqp.device);
 	}
@@ -1359,7 +1453,8 @@ int rxe_responder(void *arg)
 			state = do_class_d1e_error(qp);
 			break;
 		case RESPST_ERR_RNR:
-			if (qp_type(qp) == IB_QPT_RC) {
+			if (qp_type(qp) == IB_QPT_RC ||
+			    qp_type(qp) == IB_QPT_XRC_TGT) {
 				rxe_counter_inc(rxe, RXE_CNT_SND_RNR);
 				/* RC - class B */
 				send_ack(qp, AETH_RNR_NAK |
@@ -1374,7 +1469,8 @@ int rxe_responder(void *arg)
 			break;
 
 		case RESPST_ERR_RKEY_VIOLATION:
-			if (qp_type(qp) == IB_QPT_RC) {
+			if (qp_type(qp) == IB_QPT_RC ||
+			    qp_type(qp) == IB_QPT_XRC_TGT) {
 				/* Class C */
 				do_class_ac_error(qp, AETH_NAK_REM_ACC_ERR,
 						  IB_WC_REM_ACCESS_ERR);
@@ -1400,7 +1496,8 @@ int rxe_responder(void *arg)
 			break;
 
 		case RESPST_ERR_LENGTH:
-			if (qp_type(qp) == IB_QPT_RC) {
+			if (qp_type(qp) == IB_QPT_RC ||
+			    qp_type(qp) == IB_QPT_XRC_TGT) {
 				/* Class C */
 				do_class_ac_error(qp, AETH_NAK_INVALID_REQ,
 						  IB_WC_REM_INV_REQ_ERR);
-- 
2.34.1

