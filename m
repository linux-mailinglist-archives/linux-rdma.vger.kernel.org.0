Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBFF25CDCA
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Sep 2020 00:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729353AbgICWl4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Sep 2020 18:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728486AbgICWlr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Sep 2020 18:41:47 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8D3C061245
        for <linux-rdma@vger.kernel.org>; Thu,  3 Sep 2020 15:41:46 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id i17so4735782oig.10
        for <linux-rdma@vger.kernel.org>; Thu, 03 Sep 2020 15:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hPPLIU7w4zlg+uqFZTB04qwcFQvR04r359zsYVuV3AY=;
        b=FwEZ8LkvjXlwc1CpLjMw/O8a8vaYqPYeQG9YMSCz1H/V/gdXUrLRIRdYmj6w9YgFF+
         jIkq2jU2zbprQTMyF7kiEcYYJ3xoMMcXjPWWG+wbLlADnLU6kZ4bVejk9QsRJiR5kk2s
         oQsKfEPhWWfSIfeviWAePkxI66fRE6DI/y17zDJmYZhytD3oIXdjVtOt+37RTvkNbWrR
         aJgjrxUCizAfQGO4HGo3kKiD6o+YhNd8vstFhY4wXpp/99QOB7rGdIYDJecCY6gvU1Nd
         DycZeQK8OXaBxFjF7mju2RzAjQKd1oLFgfyRN7UsCLMMQCQyToXTSSiH3201fijQVJHu
         2UoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hPPLIU7w4zlg+uqFZTB04qwcFQvR04r359zsYVuV3AY=;
        b=tTFG3eVpKZEFZx7UTJALA41pcZzzSQCjvIOAu3odVrzwNgbkLrCcWCPoPNkdc9QqTG
         lCoVbdPXpj1Tp/mRh1hp7nno5xkcj22GdMNR5un5PtaA0G7HFFNL/073w4Ei65gxi7Pg
         FV0GqfCH3TadE9YSBvyOFZsTgSPScoaiLeZpxMdI1kglVaNzjifk3IVcZvs48MewlLOH
         LUdtNdCcw2BeBw6/M+5sd8x5/SciFRUEycHt1CPE9mxMrxPHbQYav6F2T68gooXfhUcH
         JuyOA1+mXxSIoeHgPePErX9V5DPjN34KOOwklfNW+P25WZC0qrIQEssfbJWGzL/icA+N
         +Tjw==
X-Gm-Message-State: AOAM530E4hfe4nZJGYiB3JfMO704WD9wtPs95FW4RIBKr5hjXByQ1nNy
        n5V5mujhnqPbl4+XC04knIU=
X-Google-Smtp-Source: ABdhPJzvLP+widMJfT2rw7XW1n43bu+EJIunYvzs805oEXE6dEiZMhJqmJwwNmoP9oG/t1pJjQnCsw==
X-Received: by 2002:aca:3a08:: with SMTP id h8mr3495454oia.164.1599172905727;
        Thu, 03 Sep 2020 15:41:45 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:6a3a:fc5c:851c:306a])
        by smtp.gmail.com with ESMTPSA id v7sm801873oie.9.2020.09.03.15.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 15:41:45 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH v4 for-next 7/7] rdma_rxe: add memory access through MWs
Date:   Thu,  3 Sep 2020 17:40:40 -0500
Message-Id: <20200903224039.437391-8-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200903224039.437391-1-rpearson@hpe.com>
References: <20200903224039.437391-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Implemented memory access through MWs.
Added rules checks from IBA.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_loc.h   | 17 +++---
 drivers/infiniband/sw/rxe/rxe_mr.c    | 74 ++++++++++++++++--------
 drivers/infiniband/sw/rxe/rxe_mw.c    | 57 +++++++++++++++---
 drivers/infiniband/sw/rxe/rxe_req.c   | 16 ++----
 drivers/infiniband/sw/rxe/rxe_resp.c  | 83 ++++++++++++++++++++-------
 drivers/infiniband/sw/rxe/rxe_verbs.h |  1 +
 6 files changed, 176 insertions(+), 72 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index d9a4004fddaa..bd8fe4086fd4 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -100,25 +100,28 @@ enum lookup_type {
 	lookup_remote,
 };
 
-struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
-			   enum lookup_type type);
+int advance_dma_data(struct rxe_dma_info *dma, unsigned int length);
 
-int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length);
+int rxe_mr_check_access(struct rxe_qp *qp, struct rxe_mr *mr,
+			int access, u64 va, u32 resid);
 
 void rxe_mr_cleanup(struct rxe_pool_entry *arg);
 
-int advance_dma_data(struct rxe_dma_info *dma, unsigned int length);
-
 /* rxe_mw.c */
 struct ib_mw *rxe_alloc_mw(struct ib_pd *ibpd, enum ib_mw_type type,
 			   struct ib_udata *udata);
 
 int rxe_dealloc_mw(struct ib_mw *ibmw);
 
-void rxe_mw_cleanup(struct rxe_pool_entry *arg);
-
 int rxe_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe);
 
+int rxe_invalidate_mw(struct rxe_qp *qp, struct rxe_mw *mw);
+
+int rxe_mw_check_access(struct rxe_qp *qp, struct rxe_mw *mw,
+			int access, u64 va, u32 resid);
+
+void rxe_mw_cleanup(struct rxe_pool_entry *arg);
+
 /* rxe_net.c */
 void rxe_loopback(struct sk_buff *skb);
 int rxe_send(struct rxe_pkt_info *pkt, struct sk_buff *skb);
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index f506dff25fdf..9a1fb125679a 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -21,7 +21,7 @@ static void rxe_set_mr_lkey(struct rxe_mr *mr)
 	goto again;
 }
 
-int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length)
+static int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length)
 {
 	switch (mr->type) {
 	case RXE_MR_TYPE_DMA:
@@ -380,6 +380,25 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
 	return err;
 }
 
+static struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 lkey)
+{
+	struct rxe_mr *mr;
+	struct rxe_dev *rxe = to_rdev(pd->ibpd.device);
+
+	mr = rxe_pool_get_key(&rxe->mr_pool, &lkey);
+	if (!mr)
+		return NULL;
+
+	if (unlikely((mr->ibmr.lkey != lkey) || (mr->pd != pd) ||
+		     (access && !(access & mr->access)) ||
+		     (mr->state != RXE_MEM_STATE_VALID))) {
+		rxe_drop_ref(mr);
+		return NULL;
+	}
+
+	return mr;
+}
+
 /* copy data in or out of a wqe, i.e. sg list
  * under the control of a dma descriptor
  */
@@ -409,7 +428,7 @@ int copy_data(
 	}
 
 	if (sge->length && (offset < sge->length)) {
-		mr = lookup_mr(pd, access, sge->lkey, lookup_local);
+		mr = lookup_mr(pd, access, sge->lkey);
 		if (!mr) {
 			err = -EINVAL;
 			goto err1;
@@ -434,8 +453,7 @@ int copy_data(
 			}
 
 			if (sge->length) {
-				mr = lookup_mr(pd, access, sge->lkey,
-						 lookup_local);
+				mr = lookup_mr(pd, access, sge->lkey);
 				if (!mr) {
 					err = -EINVAL;
 					goto err1;
@@ -510,32 +528,38 @@ int advance_dma_data(struct rxe_dma_info *dma, unsigned int length)
 	return 0;
 }
 
-/* (1) find the mr corresponding to lkey/rkey
- *     depending on lookup_type
- * (2) verify that the (qp) pd matches the mr pd
- * (3) verify that the mr can support the requested access
- * (4) verify that mr state is valid
- */
-struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
-			   enum lookup_type type)
+int rxe_invalidate_mr(struct rxe_qp *qp, struct rxe_mr *mr)
 {
-	struct rxe_mr *mr;
-	struct rxe_dev *rxe = to_rdev(pd->ibpd.device);
+	mr->state = RXE_MEM_STATE_FREE;
+	return 0;
+}
 
-	mr = rxe_pool_get_key(&rxe->mr_pool, &key);
-	if (!mr)
-		return NULL;
+int rxe_mr_check_access(struct rxe_qp *qp, struct rxe_mr *mr,
+			int access, u64 va, u32 resid)
+{
+	int ret;
+	struct rxe_pd *pd = to_rpd(mr->ibmr.pd);
 
-	if (unlikely((type == lookup_local && mr->lkey != key) ||
-		     (type == lookup_remote && mr->rkey != key) ||
-		     mr->pd != pd ||
-		     (access && !(access & mr->access)) ||
-		     mr->state != RXE_MEM_STATE_VALID)) {
-		rxe_drop_ref(mr);
-		mr = NULL;
+	if (unlikely(mr->state != RXE_MEM_STATE_VALID)) {
+		pr_err("attempt to access a MR that is not in the valid state\n");
+		return -EINVAL;
 	}
 
-	return mr;
+	/* C10-56 */
+	if (unlikely(pd != qp->pd)) {
+		pr_err("attempt to access a MR with a different PD than the QP\n");
+		return -EINVAL;
+	}
+
+	/* C10-57 */
+	if (unlikely(access && !(access & mr->access))) {
+		pr_err("attempt to access a MR without required access rights\n");
+		return -EINVAL;
+	}
+
+	ret = mr_check_range(mr, va, resid);
+
+	return ret;
 }
 
 void rxe_mr_cleanup(struct rxe_pool_entry *arg)
diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
index 9221726e94c2..c4fda759875a 100644
--- a/drivers/infiniband/sw/rxe/rxe_mw.c
+++ b/drivers/infiniband/sw/rxe/rxe_mw.c
@@ -318,11 +318,6 @@ int rxe_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 
 static int check_invalidate_mw(struct rxe_qp *qp, struct rxe_mw *mw)
 {
-	if (unlikely(mw->state != RXE_MEM_STATE_VALID)) {
-		pr_err_once("attempt to invalidate a MW that is not valid\n");
-		return -EINVAL;
-	}
-
 	/* o10-37.2.26 */
 	if (unlikely(mw->ibmw.type == IB_MW_TYPE_1)) {
 		pr_err_once("attempt to invalidate a type 1 MW\n");
@@ -336,9 +331,11 @@ static void do_invalidate_mw(struct rxe_mw *mw)
 {
 	mw->qp = NULL;
 
-	rxe_drop_ref(mw->mr);
-	atomic_dec(&mw->mr->num_mw);
-	mw->mr = NULL;
+	if (mw->mr) {
+		atomic_dec(&mw->mr->num_mw);
+		mw->mr = NULL;
+		rxe_drop_ref(mw->mr);
+	}
 
 	mw->access = 0;
 	mw->addr = 0;
@@ -364,6 +361,50 @@ int rxe_invalidate_mw(struct rxe_qp *qp, struct rxe_mw *mw)
 	return ret;
 }
 
+int rxe_mw_check_access(struct rxe_qp *qp, struct rxe_mw *mw,
+			int access, u64 va, u32 resid)
+{
+	struct rxe_pd *pd = to_rpd(mw->ibmw.pd);
+
+	if (unlikely(mw->state != RXE_MEM_STATE_VALID)) {
+		pr_err_once("attempt to access a MW that is not valid\n");
+		return -EINVAL;
+	}
+
+	/* C10-76.2.1 */
+	if (unlikely((mw->ibmw.type == IB_MW_TYPE_1) && (pd != qp->pd))) {
+		pr_err_once("attempt to access a type 1 MW with a different PD than the QP\n");
+		return -EINVAL;
+	}
+
+	/* o10-37.2.43 */
+	if (unlikely((mw->ibmw.type == IB_MW_TYPE_2) && (mw->qp != qp))) {
+		pr_err_once("attempt to access a type 2 MW that is associated with a different QP\n");
+		return -EINVAL;
+	}
+
+	/* C10-77 */
+	if (unlikely(access && !(access & mw->access))) {
+		pr_err_once("attempt to access a MW without sufficient access\n");
+		return -EINVAL;
+	}
+
+	if (mw->access & IB_ZERO_BASED) {
+		if (unlikely((va + resid) > mw->length)) {
+			pr_err_once("attempt to access a ZB MW out of bounds\n");
+			return -EINVAL;
+		}
+	} else {
+		if (unlikely((va < mw->addr) ||
+			((va + resid) > (mw->addr + mw->length)))) {
+			pr_err_once("attempt to access a VA MW out of bounds\n");
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
 void rxe_mw_cleanup(struct rxe_pool_entry *arg)
 {
 	struct rxe_mw *mw = container_of(arg, typeof(*mw), pelem);
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 39ca88030d3a..e0dc79b960fa 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -604,7 +604,6 @@ int rxe_requester(void *arg)
 			if (!mr) {
 				pr_err("No mr for key %#x\n",
 				       wqe->wr.ex.invalidate_rkey);
-				wqe->state = wqe_state_error;
 				wqe->status = IB_WC_MW_BIND_ERR;
 				goto err;
 			}
@@ -626,7 +625,6 @@ int rxe_requester(void *arg)
 		case IB_WR_BIND_MW:
 			ret = rxe_bind_mw(qp, wqe);
 			if (ret) {
-				wqe->state = wqe_state_done;
 				wqe->status = IB_WC_MW_BIND_ERR;
 				goto err;
 			}
@@ -636,6 +634,7 @@ int rxe_requester(void *arg)
 		default:
 			pr_err_once("unexpected LOCAL WR opcode = %d\n",
 					wqe->wr.opcode);
+			wqe->status = IB_WC_LOC_QP_OP_ERR;
 			goto err;
 		}
 
@@ -679,13 +678,7 @@ int rxe_requester(void *arg)
 	payload = (mask & RXE_WRITE_OR_SEND) ? wqe->dma.resid : 0;
 	if (payload > mtu) {
 		if (qp_type(qp) == IB_QPT_UD) {
-			/* C10-93.1.1: If the total sum of all the buffer lengths specified for a
-			 * UD message exceeds the MTU of the port as returned by QueryHCA, the CI
-			 * shall not emit any packets for this message. Further, the CI shall not
-			 * generate an error due to this condition.
-			 */
-
-			/* fake a successful UD send */
+			/* C10-93.1.1: fake a successful UD send */
 			wqe->first_psn = qp->req.psn;
 			wqe->last_psn = qp->req.psn;
 			qp->req.psn = (qp->req.psn + 1) & BTH_PSN_MASK;
@@ -750,6 +743,8 @@ int rxe_requester(void *arg)
 	 * to be called again
 	 */
 	wqe->state = wqe_state_error;
+	qp->req.wqe_index = next_index(qp->sq.queue,
+				       qp->req.wqe_index);
 	__rxe_do_task(&qp->comp.task);
 	ret = -EAGAIN;
 	goto done;
@@ -765,8 +760,7 @@ int rxe_requester(void *arg)
 
 again:
 	/* we come here if we are done with the current wqe but want to
-	 * get called again. Mostly we loop back to next wqe so should
-	 * be all one way or the other
+	 * get called again.
 	 */
 	ret = 0;
 	goto done;
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 885b5bf6dc2e..136c7699fed3 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -391,6 +391,8 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 				   struct rxe_pkt_info *pkt)
 {
 	struct rxe_mr *mr = NULL;
+	struct rxe_mw *mw = NULL;
+	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
 	u64 va;
 	u32 rkey;
 	u32 resid;
@@ -398,6 +400,7 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 	int mtu = qp->mtu;
 	enum resp_states state;
 	int access;
+	unsigned long flags;
 
 	if (pkt->mask & (RXE_READ_MASK | RXE_WRITE_MASK)) {
 		if (pkt->mask & RXE_RETH_MASK) {
@@ -405,6 +408,7 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 			qp->resp.rkey = reth_rkey(pkt);
 			qp->resp.resid = reth_len(pkt);
 			qp->resp.length = reth_len(pkt);
+			qp->resp.offset = 0;
 		}
 		access = (pkt->mask & RXE_READ_MASK) ? IB_ACCESS_REMOTE_READ
 						     : IB_ACCESS_REMOTE_WRITE;
@@ -412,6 +416,7 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 		qp->resp.va = atmeth_va(pkt);
 		qp->resp.rkey = atmeth_rkey(pkt);
 		qp->resp.resid = sizeof(u64);
+		qp->resp.offset = 0;
 		access = IB_ACCESS_REMOTE_ATOMIC;
 	} else {
 		return RESPST_EXECUTE;
@@ -429,20 +434,46 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 	resid	= qp->resp.resid;
 	pktlen	= payload_size(pkt);
 
-	mr = lookup_mr(qp->pd, access, rkey, lookup_remote);
-	if (!mr) {
-		state = RESPST_ERR_RKEY_VIOLATION;
-		goto err;
-	}
+	/* check rkey on each packet because someone could
+	 * have invalidated, deallocated or unregistered it
+	 * since the last packet
+	 */
+	if (rkey & IS_MW) {
+		mw = rxe_pool_get_key(&rxe->mw_pool, &rkey);
+		if (!mw) {
+			pr_err_once("no MW found with rkey = 0x%08x\n", rkey);
+			state = RESPST_ERR_RKEY_VIOLATION;
+			goto err;
+		}
 
-	if (unlikely(mr->state == RXE_MEM_STATE_FREE)) {
-		state = RESPST_ERR_RKEY_VIOLATION;
-		goto err;
-	}
+		spin_lock_irqsave(&mw->lock, flags);
+		if (rxe_mw_check_access(qp, mw, access, va, resid)) {
+			spin_unlock_irqrestore(&mw->lock, flags);
+			rxe_drop_ref(mw);
+			state = RESPST_ERR_RKEY_VIOLATION;
+			goto err;
+		}
+
+		mr = mw->mr;
+		rxe_add_ref(mr);
+
+		if (mw->access & IB_ZERO_BASED)
+			qp->resp.offset = mw->addr;
 
-	if (mr_check_range(mr, va, resid)) {
-		state = RESPST_ERR_RKEY_VIOLATION;
-		goto err;
+		spin_unlock_irqrestore(&mw->lock, flags);
+		rxe_drop_ref(mw);
+	} else {
+		mr = rxe_pool_get_key(&rxe->mr_pool, &rkey);
+		if (!mr || (mr->rkey != rkey)) {
+			pr_err_once("no MR found with rkey = 0x%08x\n", rkey);
+			state = RESPST_ERR_RKEY_VIOLATION;
+			goto err;
+		}
+
+		if (rxe_mr_check_access(qp, mr, access, va, resid)) {
+			state = RESPST_ERR_RKEY_VIOLATION;
+			goto err;
+		}
 	}
 
 	if (pkt->mask & RXE_WRITE_MASK)	 {
@@ -498,8 +529,8 @@ static enum resp_states write_data_in(struct rxe_qp *qp,
 	int	err;
 	int data_len = payload_size(pkt);
 
-	err = rxe_mr_copy(qp->resp.mr, qp->resp.va, payload_addr(pkt),
-			   data_len, to_mr_obj, NULL);
+	err = rxe_mr_copy(qp->resp.mr, qp->resp.va + qp->resp.offset,
+			  payload_addr(pkt), data_len, to_mr_obj, NULL);
 	if (err) {
 		rc = RESPST_ERR_RKEY_VIOLATION;
 		goto out;
@@ -518,7 +549,6 @@ static DEFINE_SPINLOCK(atomic_ops_lock);
 static enum resp_states process_atomic(struct rxe_qp *qp,
 				       struct rxe_pkt_info *pkt)
 {
-	u64 iova = atmeth_va(pkt);
 	u64 *vaddr;
 	enum resp_states ret;
 	struct rxe_mr *mr = qp->resp.mr;
@@ -528,7 +558,7 @@ static enum resp_states process_atomic(struct rxe_qp *qp,
 		goto out;
 	}
 
-	vaddr = iova_to_vaddr(mr, iova, sizeof(u64));
+	vaddr = iova_to_vaddr(mr, qp->resp.va + qp->resp.offset, sizeof(u64));
 
 	/* check vaddr is 8 bytes aligned. */
 	if (!vaddr || (uintptr_t)vaddr & 7) {
@@ -653,8 +683,10 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 		res->type		= RXE_READ_MASK;
 		res->replay		= 0;
 
-		res->read.va		= qp->resp.va;
-		res->read.va_org	= qp->resp.va;
+		res->read.va		= qp->resp.va +
+					  qp->resp.offset;
+		res->read.va_org	= qp->resp.va +
+					  qp->resp.offset;
 
 		res->first_psn		= req_pkt->psn;
 
@@ -1300,7 +1332,10 @@ int rxe_responder(void *arg)
 				/* Class C */
 				do_class_ac_error(qp, AETH_NAK_REM_ACC_ERR,
 						  IB_WC_REM_ACCESS_ERR);
-				state = RESPST_COMPLETE;
+				if (qp->resp.wqe)
+					state = RESPST_COMPLETE;
+				else
+					state = RESPST_ACKNOWLEDGE;
 			} else {
 				qp->resp.drop_msg = 1;
 				if (qp->srq) {
@@ -1319,7 +1354,10 @@ int rxe_responder(void *arg)
 				/* Class C */
 				do_class_ac_error(qp, AETH_NAK_INVALID_REQ,
 						  IB_WC_REM_INV_REQ_ERR);
-				state = RESPST_COMPLETE;
+				if (qp->resp.wqe)
+					state = RESPST_COMPLETE;
+				else
+					state = RESPST_ACKNOWLEDGE;
 			} else if (qp->srq) {
 				/* UC/UD - class E */
 				qp->resp.status = IB_WC_REM_INV_REQ_ERR;
@@ -1335,7 +1373,10 @@ int rxe_responder(void *arg)
 			/* All, Class A. */
 			do_class_ac_error(qp, AETH_NAK_REM_OP_ERR,
 					  IB_WC_LOC_QP_OP_ERR);
-			state = RESPST_COMPLETE;
+			if (qp->resp.wqe)
+				state = RESPST_COMPLETE;
+			else
+				state = RESPST_ACKNOWLEDGE;
 			break;
 
 		case RESPST_ERR_CQ_OVERFLOW:
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 2fb5581edd8a..b24a9a0878c2 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -183,6 +183,7 @@ struct rxe_resp_info {
 
 	/* RDMA read / atomic only */
 	u64			va;
+	u64			offset;
 	struct rxe_mr		*mr;
 	u32			resid;
 	u32			rkey;
-- 
2.25.1

