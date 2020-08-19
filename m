Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E92C24939A
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Aug 2020 05:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbgHSDpB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Aug 2020 23:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbgHSDo7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Aug 2020 23:44:59 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C8BC061389
        for <linux-rdma@vger.kernel.org>; Tue, 18 Aug 2020 20:44:59 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id n128so16028318oif.0
        for <linux-rdma@vger.kernel.org>; Tue, 18 Aug 2020 20:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZZFydMcHFA/gFU5xDRzYpP40Ho/GEXGxKoogfN/SfF0=;
        b=ji4REjZj2P0QD03l1uTicfF2OKJNxuYKm0XQd3GgrBUivIv8JFeTkRSq7/NwCYkI67
         l7tJRXu6GN0ykPupvVRw3H1ZxP0YKi+Qlqq0tzHK90rPBXumRjkA60TbM75Uprqq+99H
         3EfV06l+vRUk+Z/X3Ys8p3GmoSwdWe/UndgZAclS39M0pn8wSVt/Sa/glrzq9EtRGG8T
         wms3NEgoXjl+XVFn047R6/dtBO451zfKd3/uMRWkggb00fZKtjl9eJplm2kgVCUEIsFm
         xopeAhQZR3rkmtnzuxRjGyd5e4DNi4dFthODBOaP37dk9+qUakNMd4xtKNS1hrwmAxVF
         ZcRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZZFydMcHFA/gFU5xDRzYpP40Ho/GEXGxKoogfN/SfF0=;
        b=K3YGT/6d7XWRRKzfh49vtIncxQT6h95tfN2ThqexEFzK6+X1U/bXJHzsYkgB/AdXqu
         aiftG0sqJEDhuZhnswRxiIPsAWLpleQmrmFmdDx/0FDXUUyutnicEPenYt2WqjqZMSxL
         JnP/FFVvKQ1yCCz8wMUGq9HqtdO+8cB6jny9z9TcKDNZP8o5m1fUS//ux7j7wOqOB3vn
         Ikg6xdFz/m8PRl2Z7YGCOrbwBdgVhgrdaZK4Qyv5PFT7sjK1G7B/Q+jmUUEna+EY7nxz
         hvsPOcVFeMjrksqiit+ferKAD/6GPHLZxYiEJDaFxQL12tHgns4af+M9+8RrdIdE6uEF
         s9Mw==
X-Gm-Message-State: AOAM5302vrENhYYBlfFLDfpzmelW1qMRI9B+MZtvg7T1e97x8n83cZz9
        tM8VGQ0SQlCRi+gB0DYUMS0=
X-Google-Smtp-Source: ABdhPJx6/B8pH+0Kgbpq48assaIWDdPRtTVrMx0Ml5r7bdAc88670wPQnAvyrjUqRwvYLOQ75bnp/A==
X-Received: by 2002:aca:b884:: with SMTP id i126mr2135643oif.32.1597808698386;
        Tue, 18 Aug 2020 20:44:58 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:2731:80e6:14c6:1150])
        by smtp.gmail.com with ESMTPSA id w13sm4507394oiw.50.2020.08.18.20.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 20:44:58 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH v2 16/16] rdma_rxe: Implemented read/write/atomic access to MW
Date:   Tue, 18 Aug 2020 22:40:18 -0500
Message-Id: <20200819034002.8835-17-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200819034002.8835-1-rpearson@hpe.com>
References: <20200819034002.8835-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Extended current support for rkeys referencing MRs to include
rkeys referencing MWs.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_loc.h   |  7 ++-
 drivers/infiniband/sw/rxe/rxe_mr.c    | 84 ++++++++++++++++-----------
 drivers/infiniband/sw/rxe/rxe_mw.c    | 44 ++++++++++++++
 drivers/infiniband/sw/rxe/rxe_req.c   |  3 +-
 drivers/infiniband/sw/rxe/rxe_resp.c  | 70 ++++++++++++++++------
 drivers/infiniband/sw/rxe/rxe_verbs.h |  1 +
 6 files changed, 152 insertions(+), 57 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 935c15cd7448..2afd30a4382c 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -86,13 +86,12 @@ int copy_data(struct rxe_pd *pd, int access,
 	      struct rxe_dma_info *dma, void *addr, int length,
 	      enum copy_direction dir, u32 *crcp);
 void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length);
-struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
-			 enum lookup_type type);
-int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length);
 int rxe_mr_map_pages(struct rxe_dev *rxe, struct rxe_mr *mr,
 		     u64 *page, int num_pages, u64 iova);
 int advance_dma_data(struct rxe_dma_info *dma, unsigned int length);
 int rxe_invalidate_mr(struct rxe_qp *qp, struct rxe_mr *mr);
+int rxe_mr_check_access(struct rxe_qp *qp, struct rxe_mr *mr,
+			int access, u64 va, u32 resid);
 void rxe_mr_cleanup(struct rxe_pool_entry *arg);
 
 /* rxe_mw.c */
@@ -101,6 +100,8 @@ struct ib_mw *rxe_alloc_mw(struct ib_pd *ibpd, enum ib_mw_type type,
 int rxe_dealloc_mw(struct ib_mw *ibmw);
 int rxe_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe);
 int rxe_invalidate_mw(struct rxe_qp *qp, struct rxe_mw *mw);
+int rxe_mw_check_access(struct rxe_qp *qp, struct rxe_mw *mw,
+			int access, u64 va, u32 resid);
 void rxe_mw_cleanup(struct rxe_pool_entry *arg);
 
 /* rxe_net.c */
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 660547522c7a..2fb929ad7798 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -26,7 +26,7 @@ static void rxe_set_mr_lkey(struct rxe_mr *mr)
 	pr_err("unable to get random lkey for mr\n");
 }
 
-int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length)
+static int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length)
 {
 	switch (mr->type) {
 	case RXE_MR_TYPE_DMA:
@@ -387,6 +387,25 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
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
@@ -416,7 +435,7 @@ int copy_data(
 	}
 
 	if (sge->length && (offset < sge->length)) {
-		mr = lookup_mr(pd, access, sge->lkey, lookup_local);
+		mr = lookup_mr(pd, access, sge->lkey);
 		if (!mr) {
 			err = -EINVAL;
 			goto err1;
@@ -441,8 +460,7 @@ int copy_data(
 			}
 
 			if (sge->length) {
-				mr = lookup_mr(pd, access, sge->lkey,
-						 lookup_local);
+				mr = lookup_mr(pd, access, sge->lkey);
 				if (!mr) {
 					err = -EINVAL;
 					goto err1;
@@ -517,34 +535,6 @@ int advance_dma_data(struct rxe_dma_info *dma, unsigned int length)
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
-{
-	struct rxe_mr *mr;
-	struct rxe_dev *rxe = to_rdev(pd->ibpd.device);
-
-	mr = rxe_pool_get_key(&rxe->mr_pool, &key);
-	if (!mr)
-		return NULL;
-
-	if (unlikely((type == lookup_local && mr->lkey != key) ||
-		     (type == lookup_remote && mr->rkey != key) ||
-		     mr->pd != pd ||
-		     (access && !(access & mr->access)) ||
-		     mr->state != RXE_MEM_STATE_VALID)) {
-		rxe_drop_ref(mr);
-		mr = NULL;
-	}
-
-	return mr;
-}
-
 int rxe_mr_map_pages(struct rxe_dev *rxe, struct rxe_mr *mr,
 		      u64 *page, int num_pages, u64 iova)
 {
@@ -589,13 +579,41 @@ int rxe_mr_map_pages(struct rxe_dev *rxe, struct rxe_mr *mr,
 	return err;
 }
 
-/* stub for invalidate MR */
+/* TODO this needs additional validation */
 int rxe_invalidate_mr(struct rxe_qp *qp, struct rxe_mr *mr)
 {
 	mr->state = RXE_MEM_STATE_FREE;
 	return 0;
 }
 
+int rxe_mr_check_access(struct rxe_qp *qp, struct rxe_mr *mr,
+			int access, u64 va, u32 resid)
+{
+	int ret;
+	struct rxe_pd *pd = to_rpd(mr->ibmr.pd);
+
+	if (unlikely(mr->state != RXE_MEM_STATE_VALID)) {
+		pr_err("attempt to access a MR that is not in the valid state\n");
+		return -EINVAL;
+	}
+
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
+}
+
 void rxe_mr_cleanup(struct rxe_pool_entry *arg)
 {
 	struct rxe_mr *mr = container_of(arg, typeof(*mr), pelem);
diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
index 37496e06a477..5417664d1c7b 100644
--- a/drivers/infiniband/sw/rxe/rxe_mw.c
+++ b/drivers/infiniband/sw/rxe/rxe_mw.c
@@ -373,6 +373,50 @@ int rxe_invalidate_mw(struct rxe_qp *qp, struct rxe_mw *mw)
 	return ret;
 }
 
+int rxe_mw_check_access(struct rxe_qp *qp, struct rxe_mw *mw,
+			int access, u64 va, u32 resid)
+{
+	struct rxe_pd *pd = to_rpd(mw->ibmw.pd);
+
+	if (unlikely(mw->state != RXE_MEM_STATE_VALID)) {
+		pr_err_once("attempt to access a MW that is not in the valid state\n");
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
index dc9957d0b05e..706a44e639dd 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -761,8 +761,7 @@ int rxe_requester(void *arg)
 
 again:
 	/* we come here if we are done with the current wqe but want to
-	 * get called again. Mostly we loop back to next wqe so should
-	 * be all one way or the other
+	 * get called again.
 	 */
 	ret = 0;
 	goto done;
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 9997eaab235d..d6e957a34910 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -392,7 +392,9 @@ static enum resp_states check_length(struct rxe_qp *qp,
 static enum resp_states check_rkey(struct rxe_qp *qp,
 				   struct rxe_pkt_info *pkt)
 {
-	struct rxe_mr *mr = NULL;
+	struct rxe_mr *mr;
+	struct rxe_mw *mw;
+	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
 	u64 va;
 	u32 rkey;
 	u32 resid;
@@ -400,6 +402,7 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 	int mtu = qp->mtu;
 	enum resp_states state;
 	int access;
+	unsigned long flags;
 
 	if (pkt->mask & (RXE_READ_MASK | RXE_WRITE_MASK)) {
 		if (pkt->mask & RXE_RETH_MASK) {
@@ -407,6 +410,7 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 			qp->resp.rkey = reth_rkey(pkt);
 			qp->resp.resid = reth_len(pkt);
 			qp->resp.length = reth_len(pkt);
+			qp->resp.offset = 0;
 		}
 		access = (pkt->mask & RXE_READ_MASK) ? IB_ACCESS_REMOTE_READ
 						     : IB_ACCESS_REMOTE_WRITE;
@@ -414,6 +418,7 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 		qp->resp.va = atmeth_va(pkt);
 		qp->resp.rkey = atmeth_rkey(pkt);
 		qp->resp.resid = sizeof(u64);
+		qp->resp.offset = 0;
 		access = IB_ACCESS_REMOTE_ATOMIC;
 	} else {
 		return RESPST_EXECUTE;
@@ -431,20 +436,46 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
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
 
-	if (mr_check_range(mr, va, resid)) {
-		state = RESPST_ERR_RKEY_VIOLATION;
-		goto err;
+		if (mw->access & IB_ZERO_BASED)
+			qp->resp.offset = mw->addr;
+
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
@@ -500,8 +531,8 @@ static enum resp_states write_data_in(struct rxe_qp *qp,
 	int	err;
 	int data_len = payload_size(pkt);
 
-	err = rxe_mr_copy(qp->resp.mr, qp->resp.va, payload_addr(pkt),
-			   data_len, to_mr_obj, NULL);
+	err = rxe_mr_copy(qp->resp.mr, qp->resp.va + qp->resp.offset,
+			  payload_addr(pkt), data_len, to_mr_obj, NULL);
 	if (err) {
 		rc = RESPST_ERR_RKEY_VIOLATION;
 		goto out;
@@ -520,7 +551,6 @@ static DEFINE_SPINLOCK(atomic_ops_lock);
 static enum resp_states process_atomic(struct rxe_qp *qp,
 				       struct rxe_pkt_info *pkt)
 {
-	u64 iova = atmeth_va(pkt);
 	u64 *vaddr;
 	enum resp_states ret;
 	struct rxe_mr *mr = qp->resp.mr;
@@ -530,7 +560,7 @@ static enum resp_states process_atomic(struct rxe_qp *qp,
 		goto out;
 	}
 
-	vaddr = iova_to_vaddr(mr, iova, sizeof(u64));
+	vaddr = iova_to_vaddr(mr, qp->resp.va + qp->resp.offset, sizeof(u64));
 
 	/* check vaddr is 8 bytes aligned. */
 	if (!vaddr || (uintptr_t)vaddr & 7) {
@@ -655,8 +685,10 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 		res->type		= RXE_READ_MASK;
 		res->replay		= 0;
 
-		res->read.va		= qp->resp.va;
-		res->read.va_org	= qp->resp.va;
+		res->read.va		= qp->resp.va +
+					  qp->resp.offset;
+		res->read.va_org	= qp->resp.va +
+					  qp->resp.offset;
 
 		res->first_psn		= req_pkt->psn;
 
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 7b3f9dff3839..c83b1e6d6701 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -185,6 +185,7 @@ struct rxe_resp_info {
 
 	/* RDMA read / atomic only */
 	u64			va;
+	u64			offset;
 	struct rxe_mr		*mr;
 	u32			resid;
 	u32			rkey;
-- 
2.25.1

