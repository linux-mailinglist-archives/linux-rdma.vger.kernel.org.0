Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4304D2805D7
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Oct 2020 19:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732957AbgJARtD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Oct 2020 13:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732995AbgJARtC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Oct 2020 13:49:02 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB96C0613D0
        for <linux-rdma@vger.kernel.org>; Thu,  1 Oct 2020 10:49:01 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id y5so6314140otg.5
        for <linux-rdma@vger.kernel.org>; Thu, 01 Oct 2020 10:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lg8dH5/PFM0TkLth5dQu/aI/g2fJlghNghsOSlEAD3U=;
        b=PSaxvGQuvOaNd1fVO9+k1Qf1s4RhEbAft7/2EPZHyidREvqRrzbIUDoh7szZHTczkN
         0d/CGeRrpmtCjo8i3MSXQ7YPaes2FShi3rQnIXJSk2gB2KlfBqoVsiBTA1NEfz2+JAwL
         erbCoHL8s0/KgXcXM+HsBGj8eLrFfmL/2uiFjU9/Qf6aRAyETbKsi4ZNXZq4pK3Xdw4f
         LGTIVM9QQVo4MKOXgB+YaczK1rng7FE3zh0BxJ9punVrdoMnaRWEl+kx51noDmGz67iJ
         QGNFjv+gdiP+mDhF3CnfWE25BodWb9YOuQN1s7A7LICNpbdcMkpMLzAVz3cNNDZmtIC7
         nr5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lg8dH5/PFM0TkLth5dQu/aI/g2fJlghNghsOSlEAD3U=;
        b=HC45uQFCXzAZ+OoyPfI6FC1XK5VR/PxxRcROCb8+jWD0bo2Tpm+phvxw3WS1yXu7m9
         1Tc3oxeWyKQZJ5bDebufhVxxOIPY0BfAPb/aJk1qAu9ybrNRnwqjyUmfL3/jz8Hatz2u
         lHCVreJkhXPBbv22h8AyA7++hX8jsyTR/1qa6pMLY3S5dl73j+ds+tXGe8MFq0UW0KJx
         bPzUpo1JswDZ+/eatGMVCecJwg1toA+dhcOMqCHiW5asFZ93WsvNXt5pwDMi06EZFFAZ
         7dCgJos3MriDJONIB1R+L28OuHXpA4/8xNX378vnk+0lzGagaQXFbMC8nX2X8VnoKuh6
         G7MA==
X-Gm-Message-State: AOAM530tKdFkjvMQmm0lumjlIIcNoIEEJ1howcnh7hGylMimwqR3hSWM
        urlM+G//FMwqbY2oNLAyhxg=
X-Google-Smtp-Source: ABdhPJwoHz7YCPyuEHtm5CwWdE2Ug/4K1kO3ZW7PLAaQ3Vg6AqFEDePt0CxWruV13MnQ5wIfLBg1QA==
X-Received: by 2002:a9d:5509:: with SMTP id l9mr6199865oth.154.1601574541148;
        Thu, 01 Oct 2020 10:49:01 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:d01f:9a3e:d22f:7a6])
        by smtp.gmail.com with ESMTPSA id q7sm887359oth.57.2020.10.01.10.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 10:49:00 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next v7 08/19] rdma_rxe: Add memory access through MWs
Date:   Thu,  1 Oct 2020 12:48:36 -0500
Message-Id: <20201001174847.4268-9-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201001174847.4268-1-rpearson@hpe.com>
References: <20201001174847.4268-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

v7:
 - adjust for pool API changes
v6:
 - Implement memory access through MWs.
 - Add rules checks from IBA.
Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_loc.h   | 19 +++---
 drivers/infiniband/sw/rxe/rxe_mr.c    | 76 +++++++++++++++---------
 drivers/infiniband/sw/rxe/rxe_mw.c    | 57 +++++++++++++++---
 drivers/infiniband/sw/rxe/rxe_pool.c  | 14 +++--
 drivers/infiniband/sw/rxe/rxe_pool.h  |  3 +-
 drivers/infiniband/sw/rxe/rxe_req.c   | 15 ++---
 drivers/infiniband/sw/rxe/rxe_resp.c  | 83 ++++++++++++++++++++-------
 drivers/infiniband/sw/rxe/rxe_verbs.h |  1 +
 8 files changed, 189 insertions(+), 79 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 0916fc8c541e..fcffd5075b18 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -100,28 +100,29 @@ enum lookup_type {
 	lookup_remote,
 };
 
-struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
-			   enum lookup_type type);
-
-int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length);
-
-void rxe_mr_cleanup(struct rxe_pool_entry *arg);
-
 int advance_dma_data(struct rxe_dma_info *dma, unsigned int length);
 
 int rxe_invalidate_mr(struct rxe_qp *qp, struct rxe_mr *mr);
 
+int rxe_mr_check_access(struct rxe_qp *qp, struct rxe_mr *mr,
+			int access, u64 va, u32 resid);
+
+void rxe_mr_cleanup(struct rxe_pool_entry *arg);
+
 /* rxe_mw.c */
 int rxe_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata);
 
 int rxe_dealloc_mw(struct ib_mw *ibmw);
 
-void rxe_mw_cleanup(struct rxe_pool_entry *arg);
-
 int rxe_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe);
 
 int rxe_invalidate_mw(struct rxe_qp *qp, struct rxe_mw *mw);
 
+int rxe_mw_check_access(struct rxe_qp *qp, struct rxe_mw *mw,
+			int access, u64 va, u32 resid);
+
+void rxe_mw_cleanup(struct rxe_pool_entry *arg);
+
 /* rxe_net.c */
 void rxe_loopback(struct sk_buff *skb);
 int rxe_send(struct rxe_pkt_info *pkt, struct sk_buff *skb);
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index a1aa5e2267d6..c3ad89d85360 100644
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
+	mr = rxe_get_key(&rxe->mr_pool, &lkey);
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
@@ -510,28 +528,6 @@ int advance_dma_data(struct rxe_dma_info *dma, unsigned int length)
 	return 0;
 }
 
-struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
-			   enum lookup_type type)
-{
-	struct rxe_mr *mr;
-	struct rxe_dev *rxe = to_rdev(pd->ibpd.device);
-
-	mr = rxe_get_key(&rxe->mr_pool, &key);
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
 int rxe_invalidate_mr(struct rxe_qp *qp, struct rxe_mr *mr)
 {
 	/* TODO there are API rules being ignored here
@@ -542,6 +538,34 @@ int rxe_invalidate_mr(struct rxe_qp *qp, struct rxe_mr *mr)
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
 void rxe_mr_cleanup(struct rxe_pool_entry *elem)
 {
 	struct rxe_mr *mr = container_of(elem, typeof(*mr), pelem);
diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
index b09a880df35a..22d3570ac184 100644
--- a/drivers/infiniband/sw/rxe/rxe_mw.c
+++ b/drivers/infiniband/sw/rxe/rxe_mw.c
@@ -305,11 +305,6 @@ int rxe_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 
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
@@ -323,9 +318,11 @@ static void do_invalidate_mw(struct rxe_mw *mw)
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
@@ -351,6 +348,50 @@ int rxe_invalidate_mw(struct rxe_qp *qp, struct rxe_mw *mw)
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
 void rxe_mw_cleanup(struct rxe_pool_entry *elem)
 {
 	struct rxe_mw *mw = container_of(elem, typeof(*mw), pelem);
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 43b4f91d86be..5b83b6088975 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -72,6 +72,7 @@ struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
 		.name		= "rxe-mw",
 		.size		= sizeof(struct rxe_mw),
 		.elem_offset	= offsetof(struct rxe_mw, pelem),
+		.cleanup	= rxe_mw_cleanup,
 		.flags		= RXE_POOL_NO_ALLOC
 				| RXE_POOL_INDEX
 				| RXE_POOL_KEY,
@@ -220,11 +221,12 @@ static u32 alloc_index(struct rxe_pool *pool)
 	return index + pool->index.min_index;
 }
 
-static void insert_index(struct rxe_pool *pool, struct rxe_pool_entry *new)
+static int insert_index(struct rxe_pool *pool, struct rxe_pool_entry *new)
 {
 	struct rb_node **link = &pool->index.tree.rb_node;
 	struct rb_node *parent = NULL;
 	struct rxe_pool_entry *elem;
+	int ret = 0;
 
 	while (*link) {
 		parent = *link;
@@ -232,6 +234,7 @@ static void insert_index(struct rxe_pool *pool, struct rxe_pool_entry *new)
 
 		if (elem->index == new->index) {
 			pr_warn("element already exists!\n");
+			ret = -EINVAL;
 			goto out;
 		}
 
@@ -244,7 +247,7 @@ static void insert_index(struct rxe_pool *pool, struct rxe_pool_entry *new)
 	rb_link_node(&new->index_node, parent, link);
 	rb_insert_color(&new->index_node, &pool->index.tree);
 out:
-	return;
+	return ret;
 }
 
 static int insert_key(struct rxe_pool *pool, struct rxe_pool_entry *new)
@@ -302,15 +305,18 @@ void __rxe_drop_key(struct rxe_pool_entry *elem)
 	write_unlock_irqrestore(&pool->pool_lock, flags);
 }
 
-void __rxe_add_index(struct rxe_pool_entry *elem)
+int __rxe_add_index(struct rxe_pool_entry *elem)
 {
 	struct rxe_pool *pool = elem->pool;
 	unsigned long flags;
+	int ret;
 
 	write_lock_irqsave(&pool->pool_lock, flags);
 	elem->index = alloc_index(pool);
-	insert_index(pool, elem);
+	ret = insert_index(pool, elem);
 	write_unlock_irqrestore(&pool->pool_lock, flags);
+
+	return ret;
 }
 
 void __rxe_drop_index(struct rxe_pool_entry *elem)
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index e0e75faca96a..5954fae6cf99 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -113,7 +113,7 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_entry *elem);
 
 #define rxe_add_to_pool(pool, obj) __rxe_add_to_pool(pool, &(obj)->pelem)
 
-void __rxe_add_index(struct rxe_pool_entry *elem);
+int __rxe_add_index(struct rxe_pool_entry *elem);
 
 #define rxe_add_index(obj) __rxe_add_index(&(obj)->pelem)
 
@@ -144,4 +144,5 @@ void rxe_elem_release(struct kref *kref);
 /* drop a reference on an object */
 #define rxe_drop_ref(elem) kref_put(&(elem)->pelem.ref_cnt, rxe_elem_release)
 
+#define rxe_read_ref(elem) kref_read(&(elem)->pelem.ref_cnt)
 #endif /* RXE_POOL_H */
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 7efafb3e21eb..0428965c664b 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -645,7 +645,6 @@ int rxe_requester(void *arg)
 		case IB_WR_BIND_MW:
 			ret = rxe_bind_mw(qp, wqe);
 			if (ret) {
-				wqe->state = wqe_state_done;
 				wqe->status = IB_WC_MW_BIND_ERR;
 				goto err;
 			}
@@ -653,6 +652,7 @@ int rxe_requester(void *arg)
 		default:
 			pr_err_once("unexpected LOCAL WR opcode = %d\n",
 					wqe->wr.opcode);
+			wqe->status = IB_WC_LOC_QP_OP_ERR;
 			goto err;
 		}
 
@@ -698,13 +698,7 @@ int rxe_requester(void *arg)
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
@@ -769,6 +763,8 @@ int rxe_requester(void *arg)
 	 * to be called again
 	 */
 	wqe->state = wqe_state_error;
+	qp->req.wqe_index = next_index(qp->sq.queue,
+				       qp->req.wqe_index);
 	__rxe_do_task(&qp->comp.task);
 	ret = -EAGAIN;
 	goto done;
@@ -784,8 +780,7 @@ int rxe_requester(void *arg)
 
 again:
 	/* we come here if we are done with the current wqe but want to
-	 * get called again. Mostly we loop back to next wqe so should
-	 * be all one way or the other
+	 * get called again.
 	 */
 	ret = 0;
 	goto done;
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 351faa867181..2aae311f9063 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -393,6 +393,8 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 				   struct rxe_pkt_info *pkt)
 {
 	struct rxe_mr *mr = NULL;
+	struct rxe_mw *mw = NULL;
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
+		mw = rxe_get_key(&rxe->mw_pool, &rkey);
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
 
-	if (mr_check_range(mr, va, resid)) {
-		state = RESPST_ERR_RKEY_VIOLATION;
-		goto err;
+		mr = mw->mr;
+		rxe_add_ref(mr);
+
+		if (mw->access & IB_ZERO_BASED)
+			qp->resp.offset = mw->addr;
+
+		spin_unlock_irqrestore(&mw->lock, flags);
+		rxe_drop_ref(mw);
+	} else {
+		mr = rxe_get_key(&rxe->mr_pool, &rkey);
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
 
@@ -1336,7 +1368,10 @@ int rxe_responder(void *arg)
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
@@ -1364,7 +1399,10 @@ int rxe_responder(void *arg)
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
@@ -1380,7 +1418,10 @@ int rxe_responder(void *arg)
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
index 57849df8ccec..e8d9c8388345 100644
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

