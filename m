Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBD94443C59
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Nov 2021 06:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbhKCFGU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Nov 2021 01:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbhKCFGS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 3 Nov 2021 01:06:18 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2AA4C06120A
        for <linux-rdma@vger.kernel.org>; Tue,  2 Nov 2021 22:03:42 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id r10-20020a056830448a00b0055ac7767f5eso1976239otv.3
        for <linux-rdma@vger.kernel.org>; Tue, 02 Nov 2021 22:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5uqJ43JC9p1PSiS3eEn18X55axDf5mrslv8VngGIpYE=;
        b=jaCSeYVjGullYL5ZzU1EgFaeRLmdZJM5DS4yDXuWWHo+nLKNBdmEtrmMRAFO1DSVPQ
         aLz5cHWyYJyfC0OGBl2w+nHDWYOgntTy0NkpOxqtPOHdTz9ngkjr8qIagXBRPfpYIEje
         3r1JHzm9stTeaQRAzjVUN8XbVCGxUARPqtjdsmGlnqXDlLMgJMoz999sqjNjxOzi0F1P
         pvARjG9mOGa0dGMxsHInWC4nUWhPy1JbOmVV/QAHE6B6iN4YDzxsv4cwQZiHfAyPr8hG
         SWZI1k1/07nIA0v7iw2C80KUuzYgRuLqa0wYC8RcSej45uCHRXyqpKieeTzG2cXIgmch
         9aXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5uqJ43JC9p1PSiS3eEn18X55axDf5mrslv8VngGIpYE=;
        b=ZVe1ueFqwdEvrL0/iPnvc5wExyVnzByaiQlbcPImtjT4avWHiBkXObDshdtt0LaSvu
         QErtLQ8LmJ0QQlnWByXpunr1cNqtCWp1c/f9Qabrpj2uG9vVbYpQQuvuMuW8iCy9hcXo
         L4AiZ4whn4v5b4lIkyIWuQ0lGQ7yG3YM6DoQaIUeWmMwVXalAZa2oVol5J4bwgbvPkSE
         PpSlNlYqB2i45J3uP5pbNR+5pUBjPHJRyh4n4N0/t5Rv1HqVrMwiRlr2s/RCKJOC499o
         7bdBUARbqKqT3N1/c6pdYy1Cwu5Dy9XpVJzxzCccncj3pmjL3KLFKSUkXAfvDZRXHJ9i
         bAzQ==
X-Gm-Message-State: AOAM5314Bve1Bko0mokSi7Jn68DRgrYtoJujciLOC3LYE0vZkgwjJ2Rw
        1jYblQEA1SvhB8zRFDad7V4=
X-Google-Smtp-Source: ABdhPJwnXaJT5VmgM3hoBv49LRjFet16egaHHsXDtQk9cWNNl/MX5I5giGHRlQEJ3OxMr65R84yaHg==
X-Received: by 2002:a9d:5888:: with SMTP id x8mr1254906otg.277.1635915822321;
        Tue, 02 Nov 2021 22:03:42 -0700 (PDT)
Received: from ubunto-21.tx.rr.com (2603-8081-140c-1a00-b73d-116b-98e4-53b5.res6.spectrum.com. [2603:8081:140c:1a00:b73d:116b:98e4:53b5])
        by smtp.gmail.com with ESMTPSA id r23sm274990ooh.44.2021.11.02.22.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 22:03:42 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v4 12/13] RDMA/rxe: Replace mr by rkey in responder resources
Date:   Wed,  3 Nov 2021 00:02:41 -0500
Message-Id: <20211103050241.61293-13-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211103050241.61293-1-rpearsonhpe@gmail.com>
References: <20211103050241.61293-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Currently rxe saves a copy of MR in responder resources for RDMA reads.
Since the responder resources are never freed just over written if
more are needed this MR may not have a reference freed until the QP
is destroyed. This patch uses the rkey instead of the MR and on
subsequent packets of a multipacket read reply message it looks up the
MR from the rkey for each packet. This makes it possible for a user
to deregister an MR or unbind a MW on the fly and get correct behaviour.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_qp.c    |  10 +--
 drivers/infiniband/sw/rxe/rxe_resp.c  | 123 ++++++++++++++++++--------
 drivers/infiniband/sw/rxe/rxe_verbs.h |   1 -
 3 files changed, 87 insertions(+), 47 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index 864bb3ef145f..4922a26bb5fc 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -135,12 +135,8 @@ static void free_rd_atomic_resources(struct rxe_qp *qp)
 
 void free_rd_atomic_resource(struct rxe_qp *qp, struct resp_res *res)
 {
-	if (res->type == RXE_ATOMIC_MASK) {
+	if (res->type == RXE_ATOMIC_MASK)
 		kfree_skb(res->atomic.skb);
-	} else if (res->type == RXE_READ_MASK) {
-		if (res->read.mr)
-			rxe_drop_ref(res->read.mr);
-	}
 	res->type = 0;
 }
 
@@ -816,10 +812,8 @@ static void rxe_qp_do_cleanup(struct work_struct *work)
 	if (qp->pd)
 		rxe_drop_ref(qp->pd);
 
-	if (qp->resp.mr) {
+	if (qp->resp.mr)
 		rxe_drop_ref(qp->resp.mr);
-		qp->resp.mr = NULL;
-	}
 
 	if (qp_type(qp) == IB_QPT_RC)
 		sk_dst_reset(qp->sk->sk);
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index f589f4dde35c..c776289842e5 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -641,6 +641,78 @@ static struct sk_buff *prepare_ack_packet(struct rxe_qp *qp,
 	return skb;
 }
 
+static struct resp_res *rxe_prepare_read_res(struct rxe_qp *qp,
+					struct rxe_pkt_info *pkt)
+{
+	struct resp_res *res;
+	u32 pkts;
+
+	res = &qp->resp.resources[qp->resp.res_head];
+	rxe_advance_resp_resource(qp);
+	free_rd_atomic_resource(qp, res);
+
+	res->type = RXE_READ_MASK;
+	res->replay = 0;
+	res->read.va = qp->resp.va + qp->resp.offset;
+	res->read.va_org = qp->resp.va + qp->resp.offset;
+	res->read.resid = qp->resp.resid;
+	res->read.length = qp->resp.resid;
+	res->read.rkey = qp->resp.rkey;
+
+	pkts = max_t(u32, (reth_len(pkt) + qp->mtu - 1)/qp->mtu, 1);
+	res->first_psn = pkt->psn;
+	res->cur_psn = pkt->psn;
+	res->last_psn = (pkt->psn + pkts - 1) & BTH_PSN_MASK;
+
+	res->state = rdatm_res_state_new;
+
+	return res;
+}
+
+/**
+ * rxe_recheck_mr - revalidate MR from rkey and get a reference
+ * @qp: the qp
+ * @rkey: the rkey
+ *
+ * This code allows the MR to be invalidated or deregistered or
+ * the MW if one was used to be invalidated or deallocated.
+ * It is assumed that the access permissions if originally good
+ * are OK and the mappings to be unchanged.
+ *
+ * Return: mr on success else NULL
+ */
+static struct rxe_mr *rxe_recheck_mr(struct rxe_qp *qp, u32 rkey)
+{
+	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
+	struct rxe_mr *mr;
+	struct rxe_mw *mw;
+
+	if (rkey_is_mw(rkey)) {
+		mw = rxe_pool_get_index(&rxe->mw_pool, rkey >> 8);
+		if (!mw || mw->rkey != rkey)
+			return NULL;
+
+		if (mw->state != RXE_MW_STATE_VALID) {
+			rxe_drop_ref(mw);
+			return NULL;
+		}
+
+		mr = mw->mr;
+		rxe_drop_ref(mw);
+	} else {
+		mr = rxe_pool_get_index(&rxe->mr_pool, rkey >> 8);
+		if (!mr || mr->rkey != rkey)
+			return NULL;
+	}
+
+	if (mr->state != RXE_MR_STATE_VALID) {
+		rxe_drop_ref(mr);
+		return NULL;
+	}
+
+	return mr;
+}
+
 /* RDMA read response. If res is not NULL, then we have a current RDMA request
  * being processed or replayed.
  */
@@ -655,53 +727,26 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 	int opcode;
 	int err;
 	struct resp_res *res = qp->resp.res;
+	struct rxe_mr *mr;
 
 	if (!res) {
-		/* This is the first time we process that request. Get a
-		 * resource
-		 */
-		res = &qp->resp.resources[qp->resp.res_head];
-
-		free_rd_atomic_resource(qp, res);
-		rxe_advance_resp_resource(qp);
-
-		res->type		= RXE_READ_MASK;
-		res->replay		= 0;
-
-		res->read.va		= qp->resp.va +
-					  qp->resp.offset;
-		res->read.va_org	= qp->resp.va +
-					  qp->resp.offset;
-
-		res->first_psn		= req_pkt->psn;
-
-		if (reth_len(req_pkt)) {
-			res->last_psn	= (req_pkt->psn +
-					   (reth_len(req_pkt) + mtu - 1) /
-					   mtu - 1) & BTH_PSN_MASK;
-		} else {
-			res->last_psn	= res->first_psn;
-		}
-		res->cur_psn		= req_pkt->psn;
-
-		res->read.resid		= qp->resp.resid;
-		res->read.length	= qp->resp.resid;
-		res->read.rkey		= qp->resp.rkey;
-
-		/* note res inherits the reference to mr from qp */
-		res->read.mr		= qp->resp.mr;
-		qp->resp.mr		= NULL;
-
-		qp->resp.res		= res;
-		res->state		= rdatm_res_state_new;
+		res = rxe_prepare_read_res(qp, req_pkt);
+		qp->resp.res = res;
 	}
 
 	if (res->state == rdatm_res_state_new) {
+		mr = qp->resp.mr;
+		qp->resp.mr = NULL;
+
 		if (res->read.resid <= mtu)
 			opcode = IB_OPCODE_RC_RDMA_READ_RESPONSE_ONLY;
 		else
 			opcode = IB_OPCODE_RC_RDMA_READ_RESPONSE_FIRST;
 	} else {
+		mr = rxe_recheck_mr(qp, res->read.rkey);
+		if (!mr)
+			return RESPST_ERR_RKEY_VIOLATION;
+
 		if (res->read.resid > mtu)
 			opcode = IB_OPCODE_RC_RDMA_READ_RESPONSE_MIDDLE;
 		else
@@ -717,10 +762,12 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 	if (!skb)
 		return RESPST_ERR_RNR;
 
-	err = rxe_mr_copy(res->read.mr, res->read.va, payload_addr(&ack_pkt),
+	err = rxe_mr_copy(mr, res->read.va, payload_addr(&ack_pkt),
 			  payload, RXE_FROM_MR_OBJ);
 	if (err)
 		pr_err("Failed copying memory\n");
+	if (mr)
+		rxe_drop_ref(mr);
 
 	if (bth_pad(&ack_pkt)) {
 		u8 *pad = payload_addr(&ack_pkt) + payload;
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index caf1ce118765..022abba4fb6b 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -157,7 +157,6 @@ struct resp_res {
 			struct sk_buff	*skb;
 		} atomic;
 		struct {
-			struct rxe_mr	*mr;
 			u64		va_org;
 			u32		rkey;
 			u32		length;
-- 
2.30.2

