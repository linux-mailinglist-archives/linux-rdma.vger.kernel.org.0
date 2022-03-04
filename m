Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1AE54CCA88
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Mar 2022 01:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbiCDAJc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Mar 2022 19:09:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbiCDAJb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Mar 2022 19:09:31 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219D83FBFD
        for <linux-rdma@vger.kernel.org>; Thu,  3 Mar 2022 16:08:44 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id k9-20020a056830242900b005ad25f8ebfdso6048723ots.7
        for <linux-rdma@vger.kernel.org>; Thu, 03 Mar 2022 16:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=262LG4c8BPhcfeH/5lGEIzBQnZBGchpsNYbwxAyCUq8=;
        b=IdWwRrGAfeSpWGPw7KTXt/SxjCsjVg7pUlhUh2Rr2dkPQmXMesZCc3hQ0hSw8v73pJ
         qUoX1qltALxssJkmOIy6+18t1xeIONj2XjT7uq9LqY7pT5mo47GFpTW1w9n5qcGm4Eto
         dQfZQogxKISu5bvY40r48m7kXlNMuklajP+iJzxHF8VnimMLbeFLmjsOtjQnXxxkXjWL
         MKWS1vn+rzvfMnJvKxm1HjPl/iP3DSO3HK8YhCK2t5yTXc39qPT/wdHOjBSvXQaPxC8Q
         DrI5B+WFBkxDiQENkRPLaKhLCmii8bIgOEltxeYitSO6MHGsKk7w9PzuJsDiPdmTRKQf
         Av1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=262LG4c8BPhcfeH/5lGEIzBQnZBGchpsNYbwxAyCUq8=;
        b=KMaVgls9yORpsEub7ep7OqysPmlc/yW2HmiQG2d0s1FAJckYynPdSPCvK3BRvprtzU
         ZVgOm8T4/gtxnBWsoQIq984Xa3KKuZoJX6Oa5FP/EvFf1+vRwtQ8xlf47120+u1FwzWN
         SJxjLrJ22ot7Xq/DDs/aiut5+65Zq+Cw2LdpJxLfhaauQWZxxtDT2V3fhMLN3b14HZ6x
         S0HQKJhMBjJZoHSHbuloALnHqHW8QVJNYx+i8InVY9i6OVws5O1SjYrfGISxsmnpbx09
         lgYcU4gVTeQViC7+faIEQDbtGNmMRDjogcG3OI+NdSkOrll3rFreEVQyxpcdutpu5ISK
         MNFg==
X-Gm-Message-State: AOAM532c4EZwNgrYhm9ecq4Q5RyShbMGZm7loJkcncRF9JPu68sQio6D
        vvr0idvrHna0PSbbKjW1h6bPfLZGnTA=
X-Google-Smtp-Source: ABdhPJyKHXKjworXTT9fEmzb+4qNwK8KFyfu2nn5K+T657ml1A2QTsB8XHdH3+78hOWb7WU2r0dDUw==
X-Received: by 2002:a9d:63d7:0:b0:5af:8b78:6799 with SMTP id e23-20020a9d63d7000000b005af8b786799mr20836358otl.113.1646352523098;
        Thu, 03 Mar 2022 16:08:43 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-4a4e-f957-5a09-0218.res6.spectrum.com. [2603:8081:140c:1a00:4a4e:f957:5a09:218])
        by smtp.googlemail.com with ESMTPSA id n23-20020a9d7417000000b005afc3371166sm1646469otk.81.2022.03.03.16.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 16:08:42 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v11 02/13] RDMA/rxe: Replace mr by rkey in responder resources
Date:   Thu,  3 Mar 2022 18:07:58 -0600
Message-Id: <20220304000808.225811-3-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220304000808.225811-1-rpearsonhpe@gmail.com>
References: <20220304000808.225811-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index 5f270cbf18c6..26d461a8d71c 100644
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
 
@@ -825,10 +821,8 @@ static void rxe_qp_do_cleanup(struct work_struct *work)
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
index b5ebe853748a..b1ec003f0bb8 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -642,6 +642,78 @@ static struct sk_buff *prepare_ack_packet(struct rxe_qp *qp,
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
@@ -656,53 +728,26 @@ static enum resp_states read_reply(struct rxe_qp *qp,
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
@@ -718,10 +763,12 @@ static enum resp_states read_reply(struct rxe_qp *qp,
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
index 6b15251ff67a..e7eff1ca75e9 100644
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
2.32.0

