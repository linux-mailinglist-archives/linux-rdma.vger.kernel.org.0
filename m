Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40A75245293
	for <lists+linux-rdma@lfdr.de>; Sat, 15 Aug 2020 23:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbgHOVxC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 15 Aug 2020 17:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729165AbgHOVwo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 15 Aug 2020 17:52:44 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A64C061243
        for <linux-rdma@vger.kernel.org>; Fri, 14 Aug 2020 22:00:07 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id x6so2344135ooe.8
        for <linux-rdma@vger.kernel.org>; Fri, 14 Aug 2020 22:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gVtEoMqulKDOUrrxvXAqf3eIjysZTgBICD+riQ2EMsE=;
        b=KA3TTFWB1XPLkBkzsvLSJpnKE+KE8g2MucR98zp5H1UnuZ4khMQn+jZg21Z4Xm44bS
         9K0LhP7o7FJ8sXqpechZ0z1u8YRPzbnz+v02x4wKkL0kCCbGuif0XyjgXijCSEDJDeOl
         Px54HFuf5bXva27sFtpumylLCVRgLmQ48MAEUq2TUvksK9Isc4K7JKYwAPWqkAmpZo68
         rw5kg+39MR1XxXK3SeBfiniMfiksE73Ae20IKYJS5ZlxoiAgNsEaHk50n3DjwFW1AOx+
         rLDd/pB9HR43mOrjNht4CZBxi4R7C8Rxsd4ownCIhGTstFaQ9XBSzg8+CJvT3qKXLmx7
         lVXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gVtEoMqulKDOUrrxvXAqf3eIjysZTgBICD+riQ2EMsE=;
        b=T+KXJFZU0cAhPl/ykhx/q/prHEXSXiuVCWtGZJaookVPJ69JabkuDCxPpz0BasYHJp
         Gh5IUBO1msDOB7AwQFWZpDusCs15UU3/Kce5QmGcBSZWFFZ3FAiIs+/YlJ8WNDr8I9Ng
         1xqwhciBKpBNaRZTyG5JXRxQ+jfCTttx1zdDioeXWoC8ZrV1KDFdIL5elVM5S/ggcYDj
         uHS9EUgHfr4fki+E+uFxqMBjDqYnnGLEjSlsELLKSy1+UatXjCT4wA3ZgPe1wcnRPi5t
         f4tKywpRSsmPEArU9Ps2TDF6ZO2NCukWxAlgTrFhdrVEnNxB3RJI4p/UzhzhP2rluBZv
         WOqw==
X-Gm-Message-State: AOAM530OY7o4y2yY1tbEyPuychFqU6z/jjuTSwLTkYOLtAmaxh01Ujj6
        yJEF76fnsxLBh+BBakw3GLarroRvNVaqmw==
X-Google-Smtp-Source: ABdhPJwZQx4SXdU/cZkk/qn2eAIfpn6Zv/QrJPF9n7jVWHzLf7NVOtUsK/iintpT0GGD2lQNHeI+PA==
X-Received: by 2002:a4a:9f93:: with SMTP id z19mr4079761ool.58.1597467606895;
        Fri, 14 Aug 2020 22:00:06 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:b453:c5f2:2895:a54c])
        by smtp.gmail.com with ESMTPSA id j2sm2120924ooo.6.2020.08.14.22.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 22:00:06 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH 16/20] Implemented stubbed invalidate APIs
Date:   Fri, 14 Aug 2020 23:58:40 -0500
Message-Id: <20200815045912.8626-17-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200815045912.8626-1-rpearson@hpe.com>
References: <20200815045912.8626-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fixed a bug in rxe_req that killed the last WC in error. Added a
teardown/completion routine for MWs. Invalidate routines are still
stubs. Still need to clean up some error path code for both MR and MW.
Added atomics to detect reentrancy in the tasklets for now. Will
go away later.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_comp.c  | 18 ++++--
 drivers/infiniband/sw/rxe/rxe_loc.h   |  3 +
 drivers/infiniband/sw/rxe/rxe_mr.c    | 17 ++++-
 drivers/infiniband/sw/rxe/rxe_mw.c    | 33 +++++++---
 drivers/infiniband/sw/rxe/rxe_pool.c  | 11 ++++
 drivers/infiniband/sw/rxe/rxe_req.c   | 91 +++++++++++++++------------
 drivers/infiniband/sw/rxe/rxe_resp.c  | 57 +++++++++++++----
 drivers/infiniband/sw/rxe/rxe_verbs.c |  4 --
 8 files changed, 162 insertions(+), 72 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index caa8ad990337..d2a094621486 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -563,12 +563,20 @@ int rxe_completer(void *arg)
 	struct sk_buff *skb = NULL;
 	struct rxe_pkt_info *pkt = NULL;
 	enum comp_state state;
+	int entered;
 
 	rxe_add_ref(qp);
 
+	// this code is 'guaranteed' to never be entered more
+	// than once. Check to make sure that this is the case
+	entered = atomic_inc_return(&qp->comp.task.entered);
+	if (entered > 1) {
+		pr_err("rxe_completer: entered %d times\n", entered);
+	}
+
 	if (!qp->valid || qp->req.state == QP_STATE_ERROR ||
 	    qp->req.state == QP_STATE_RESET) {
-		rxe_drain_resp_pkts(qp, qp->valid &&
+			rxe_drain_resp_pkts(qp, qp->valid &&
 				    qp->req.state == QP_STATE_ERROR);
 		goto exit;
 	}
@@ -782,14 +790,14 @@ int rxe_completer(void *arg)
 		}
 	}
 
+	/* these are the same. need to merge them TODO */
 exit:
 	/* we come here if we are done with processing and want the task to
-	 * exit from the loop calling us
+	 * exit from the loop calling us -- to call us again later
 	 */
 	WARN_ON_ONCE(skb);
+	atomic_dec(&qp->comp.task.entered);
 	rxe_drop_ref(qp);
-	// TODO this seems plain backwards
-	// EAGAIN normally means call me again
 	return -EAGAIN;
 
 done:
@@ -797,6 +805,8 @@ int rxe_completer(void *arg)
 	 * us again to see if there is anything else to do
 	 */
 	WARN_ON_ONCE(skb);
+	atomic_dec(&qp->comp.task.entered);
 	rxe_drop_ref(qp);
 	return 0;
+
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 03eb74947d62..1ddd1b5721d8 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -137,6 +137,7 @@ int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length);
 void rxe_mr_cleanup(struct rxe_pool_entry *arg);
 
 int advance_dma_data(struct rxe_dma_info *dma, unsigned int length);
+int rxe_invalidate_mr(struct rxe_mr *mr, int remote);
 
 /* rxe_mw.c */
 void rxe_set_mw_rkey(struct rxe_mw *mw);
@@ -144,6 +145,8 @@ struct ib_mw *rxe_alloc_mw(struct ib_pd *ibpd, enum ib_mw_type type,
 			   struct ib_udata *udata);
 int rxe_dealloc_mw(struct ib_mw *ibmw);
 int rxe_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe);
+void rxe_mw_cleanup(struct rxe_pool_entry *arg);
+int rxe_invalidate_mw(struct rxe_mw *mw, int remote);
 
 /* rxe_net.c */
 void rxe_loopback(struct sk_buff *skb);
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 533b02fc2d0e..bebcce06e804 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -47,7 +47,7 @@ void rxe_set_mr_lkey(struct rxe_mr *mr)
 		if (likely(lkey && (rxe_add_key(mr, &lkey) == 0)))
 			return;
 	} while (tries++ < 10);
-	pr_err("rxe_set_mr_lkey: unable to get random lkey\n");
+	pr_err("unable to get random key for mr\n");
 }
 
 #if 0
@@ -114,7 +114,8 @@ void rxe_mr_cleanup(struct rxe_pool_entry *arg)
 	struct rxe_mr *mr = container_of(arg, typeof(*mr), pelem);
 	int i;
 
-	ib_umem_release(mr->umem);
+	if (mr->umem)
+		ib_umem_release(mr->umem);
 
 	if (mr->map) {
 		for (i = 0; i < mr->num_map; i++)
@@ -122,6 +123,9 @@ void rxe_mr_cleanup(struct rxe_pool_entry *arg)
 
 		kfree(mr->map);
 	}
+
+	rxe_drop_index(mr);
+	rxe_drop_key(mr);
 }
 
 static int rxe_mr_alloc(struct rxe_mr *mr, int num_buf)
@@ -602,3 +606,12 @@ struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
 
 	return mr;
 }
+
+int rxe_invalidate_mr(struct rxe_mr *mr, int remote)
+{
+	// more TODO here, can fail
+
+	mr->state = RXE_MEM_STATE_FREE;
+
+	return 0;
+}
diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
index a0ff2543d0cd..7092045a2691 100644
--- a/drivers/infiniband/sw/rxe/rxe_mw.c
+++ b/drivers/infiniband/sw/rxe/rxe_mw.c
@@ -49,7 +49,7 @@ void rxe_set_mw_rkey(struct rxe_mw *mw)
 			   (rxe_add_key(mw, &rkey) == 0)))
 			return;
 	} while (tries++ < 10);
-	pr_err("rxe_set_mw_rkey: unable to get random rkey\n");
+	pr_err("unable to get random rkey for mw\n");
 }
 
 
@@ -91,9 +91,6 @@ struct ib_mw *rxe_alloc_mw(struct ib_pd *ibpd, enum ib_mw_type type,
 	rxe_add_index(mw);
 	rxe_set_mw_rkey(mw);
 
-	pr_info("rxe_alloc_mw: index = 0x%08x, rkey = 0x%08x\n",
-			mw->pelem.index, mw->ibmw.rkey);
-
 	spin_lock_init(&mw->lock);
 
 	if (type == IB_MW_TYPE_2) {
@@ -120,8 +117,6 @@ struct ib_mw *rxe_alloc_mw(struct ib_pd *ibpd, enum ib_mw_type type,
 
 	return &mw->ibmw;
 err2:
-	rxe_drop_key(mw);
-	rxe_drop_index(mw);
 	rxe_drop_ref(mw);
 	rxe_drop_ref(pd);
 err1:
@@ -138,8 +133,6 @@ int rxe_dealloc_mw(struct ib_mw *ibmw)
 	mw->state = RXE_MW_STATE_INVALID;
 	spin_unlock_irqrestore(&mw->lock, flags);
 
-	rxe_drop_key(mw);
-	rxe_drop_index(mw);
 	rxe_drop_ref(pd);
 	rxe_drop_ref(mw);
 
@@ -151,8 +144,6 @@ int rxe_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 	struct rxe_mw *mw;
 	struct rxe_mr *mr;
 
-	pr_info("rxe_bind_mw: called\n");
-
 	if (qp->is_user) {
 	} else {
 		mw = to_rmw(wqe->wr.wr.kmw.ibmw);
@@ -186,3 +177,25 @@ int rxe_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 #endif
 	return 0;
 }
+
+void rxe_mw_cleanup(struct rxe_pool_entry *arg)
+{
+	struct rxe_mw *mw = container_of(arg, typeof(*mw), pelem);
+
+	rxe_drop_index(mw);
+	rxe_drop_key(mw);
+}
+
+int rxe_invalidate_mw(struct rxe_mw *mw, int remote)
+{
+	/* type 1 MWs don't support invalidate */
+	if (mw->ibmw.type == IB_MW_TYPE_1) {
+		pr_err("attempt to %s-invalidate a type 1 mw\n",
+			remote ? "send" : "local");
+		return -EINVAL;
+	}
+
+	mw->state = RXE_MEM_STATE_FREE;
+
+	return 0;
+}
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 35e9646e104c..df3e2a514ce3 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -85,6 +85,7 @@ struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
 	[RXE_TYPE_MW] = {
 		.name		= "rxe-mw",
 		.size		= sizeof(struct rxe_mw),
+		.cleanup	= rxe_mw_cleanup,
 		.flags		= RXE_POOL_INDEX
 				| RXE_POOL_KEY,
 		.max_index	= RXE_MAX_MW_INDEX,
@@ -365,6 +366,11 @@ void rxe_drop_key(void *arg)
 	struct rxe_pool *pool = elem->pool;
 	unsigned long flags;
 
+	if (elem == NULL) {
+		pr_warn("rxe_drop_key: called with null pointer\n");
+		return;
+	}
+
 	write_lock_irqsave(&pool->pool_lock, flags);
 	rb_erase(&elem->key_node, &pool->key.tree);
 	write_unlock_irqrestore(&pool->pool_lock, flags);
@@ -388,6 +394,11 @@ void rxe_drop_index(void *arg)
 	struct rxe_pool *pool = elem->pool;
 	unsigned long flags;
 
+	if (elem == NULL) {
+		pr_warn("rxe_drop_index: called with null pointer\n");
+		return;
+	}
+
 	write_lock_irqsave(&pool->pool_lock, flags);
 	clear_bit(elem->index - pool->index.min_index, pool->index.table);
 	rb_erase(&elem->index_node, &pool->index.tree);
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index e0564d7b0ff7..2a38b7cdf4a8 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -583,11 +583,32 @@ static void update_state(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 			  jiffies + qp->qp_timeout_jiffies);
 }
 
+static int local_invalidate(struct rxe_dev *rxe, struct rxe_send_wqe *wqe)
+{
+	int ret;
+	struct rxe_mr *mr;
+	struct rxe_mw *mw;
+	u32 key = wqe->wr.ex.invalidate_rkey;
+
+	if ((mr = rxe_pool_get_key(&rxe->mr_pool, &key))) {
+		ret = rxe_invalidate_mr(mr, 0);
+		rxe_drop_ref(mr);
+	} else if ((mw = rxe_pool_get_key(&rxe->mw_pool, &key))) {
+		ret = rxe_invalidate_mw(mw, 0);
+		rxe_drop_ref(mw);
+	} else {
+		ret = -EINVAL;
+		pr_err("No mr/mw for rkey %#x\n", key);
+	}
+
+	return ret;
+}
+
 int rxe_requester(void *arg)
 {
 	struct rxe_qp *qp = (struct rxe_qp *)arg;
 	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
-	struct rxe_mr *rmr;
+	struct rxe_mr *mr;
 	struct rxe_pkt_info pkt;
 	struct sk_buff *skb;
 	struct rxe_send_wqe *wqe;
@@ -600,6 +621,8 @@ int rxe_requester(void *arg)
 	u32 rollback_psn;
 	int entered;
 
+	pr_info("rxe_requester: called\n");
+
 	rxe_add_ref(qp);
 
 	// this code is 'guaranteed' to never be entered more
@@ -631,57 +654,47 @@ int rxe_requester(void *arg)
 	if (unlikely(!wqe))
 		goto exit;
 
+	/* process local operations */
 	if (wqe->mask & WR_LOCAL_MASK) {
+		wqe->state = wqe_state_done;
+		wqe->status = IB_WC_SUCCESS;
+
 		switch (wqe->wr.opcode) {
 		case IB_WR_LOCAL_INV:
-			rmr = rxe_pool_get_index(&rxe->mr_pool,
-				 wqe->wr.ex.invalidate_rkey >> 8);
-			if (!rmr) {
-				pr_err("No mr for key %#x\n",
-				       wqe->wr.ex.invalidate_rkey);
-				wqe->state = wqe_state_error;
-				wqe->status = IB_WC_MW_BIND_ERR;
-				goto exit;
-			}
-			// TODO this can race with external access
-			// to the MR in rxe_resp unless you can know
-			// that all accesses are done
-			rmr->state = RXE_MEM_STATE_FREE;
-			rxe_drop_ref(rmr);
-			wqe->state = wqe_state_done;
-			wqe->status = IB_WC_SUCCESS;
+			if ((ret = local_invalidate(rxe, wqe)))
+				wqe->status = IB_WC_LOC_QP_OP_ERR;
 			break;
 		case IB_WR_REG_MR:
-			rmr = to_rmr(wqe->wr.wr.reg.mr);
-			rmr->state = RXE_MEM_STATE_VALID;
-			rmr->access = wqe->wr.wr.reg.access;
-			rmr->lkey = wqe->wr.wr.reg.key;
-			rmr->rkey = wqe->wr.wr.reg.key;
-			rmr->iova = wqe->wr.wr.reg.mr->iova;
-			wqe->state = wqe_state_done;
-			wqe->status = IB_WC_SUCCESS;
+			mr = to_rmr(wqe->wr.wr.reg.mr);
+			mr->state = RXE_MEM_STATE_VALID;
+			mr->access = wqe->wr.wr.reg.access;
+			mr->lkey = wqe->wr.wr.reg.key;
+			mr->rkey = wqe->wr.wr.reg.key;
+			mr->iova = wqe->wr.wr.reg.mr->iova;
 			break;
 		case IB_WR_BIND_MW:
-			ret = rxe_bind_mw(qp, wqe);
-			if (ret) {
-				wqe->state = wqe_state_done;
+			if ((ret = rxe_bind_mw(qp, wqe)))
 				wqe->status = IB_WC_MW_BIND_ERR;
-				// TODO err: will change status
-				// probably should not
-				goto err;
-			}
-			wqe->state = wqe_state_done;
-			wqe->status = IB_WC_SUCCESS;
 			break;
 		default:
-			pr_err("rxe_requester: unexpected LOCAL WR opcode = %d\n", wqe->wr.opcode);
-			goto exit;
+			pr_err("rxe_requester: unexpected local WR opcode = %d\n",
+				wqe->wr.opcode);
+			wqe->status = IB_WC_LOC_QP_OP_ERR;
 		}
+
+		/* we're done processing the wqe so move index */
+		qp->req.wqe_index = next_index(qp->sq.queue, qp->req.wqe_index);
+
+		/* if an error occurred do a completion pass now
+		 * (below) and then quit processing more wqes */
+		if (wqe->status != IB_WC_SUCCESS)
+			goto err;
+
+		/* if the wqe is signalled schedule a completion pass */
 		if ((wqe->wr.send_flags & IB_SEND_SIGNALED) ||
-		    qp->sq_sig_type == IB_SIGNAL_ALL_WR)
+		    (qp->sq_sig_type == IB_SIGNAL_ALL_WR))
 			rxe_run_task(&qp->comp.task, 1);
-		qp->req.wqe_index = next_index(qp->sq.queue,
-						qp->req.wqe_index);
+
 		goto next_wqe;
 	}
 
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index d54b5e7dad39..aac50c0a43c7 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -834,14 +834,38 @@ static enum resp_states execute(struct rxe_qp *qp, struct rxe_pkt_info *pkt)
 		return RESPST_CLEANUP;
 }
 
+static int send_invalidate(struct rxe_dev *rxe, u32 rkey)
+{
+	int ret;
+	struct rxe_mr *mr;
+	struct rxe_mw *mw;
+
+	pr_info("send_invalidate: called\n");
+
+	if ((mr = rxe_pool_get_key(&rxe->mr_pool, &rkey))) {
+		ret = rxe_invalidate_mr(mr, 1);
+		rxe_drop_ref(mr);
+	} else if ((mw = rxe_pool_get_key(&rxe->mw_pool, &rkey))) {
+		ret = rxe_invalidate_mw(mw, 1);
+		rxe_drop_ref(mw);
+	} else {
+		pr_err("send invalidate failed for rkey = 0x%x\n", rkey);
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
 static enum resp_states do_complete(struct rxe_qp *qp,
 				    struct rxe_pkt_info *pkt)
 {
+	int ret;
 	struct rxe_cqe cqe;
 	struct ib_wc *wc = &cqe.ibwc;
 	struct ib_uverbs_wc *uwc = &cqe.uibwc;
 	struct rxe_recv_wqe *wqe = qp->resp.wqe;
 	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
+	u32 rkey = ieth_rkey(pkt);
 
 	if (unlikely(!wqe))
 		return RESPST_CLEANUP;
@@ -858,6 +882,14 @@ static enum resp_states do_complete(struct rxe_qp *qp,
 		wc->wr_id               = wqe->wr_id;
 	}
 
+	if (pkt->mask & RXE_IETH_MASK) {
+		ret = send_invalidate(rxe, rkey);
+		if (ret) {
+			pr_err("do_complete: send invalidate failed\n");
+			// TODO
+		}
+	}
+
 	if (wc->status == IB_WC_SUCCESS) {
 		rxe_counter_inc(rxe, RXE_CNT_RDMA_RECV);
 		wc->opcode = (pkt->mask & RXE_IMMDT_MASK &&
@@ -881,7 +913,7 @@ static enum resp_states do_complete(struct rxe_qp *qp,
 
 			if (pkt->mask & RXE_IETH_MASK) {
 				uwc->wc_flags |= IB_WC_WITH_INVALIDATE;
-				uwc->ex.invalidate_rkey = ieth_rkey(pkt);
+				uwc->ex.invalidate_rkey = rkey;
 			}
 
 			uwc->qp_num		= qp->ibqp.qp_num;
@@ -910,20 +942,8 @@ static enum resp_states do_complete(struct rxe_qp *qp,
 			}
 
 			if (pkt->mask & RXE_IETH_MASK) {
-				struct rxe_mr *rmr;
-
 				wc->wc_flags |= IB_WC_WITH_INVALIDATE;
 				wc->ex.invalidate_rkey = ieth_rkey(pkt);
-
-				rmr = rxe_pool_get_index(&rxe->mr_pool,
-							 wc->ex.invalidate_rkey >> 8);
-				if (unlikely(!rmr)) {
-					pr_err("Bad rkey %#x invalidation\n",
-					       wc->ex.invalidate_rkey);
-					return RESPST_ERROR;
-				}
-				rmr->state = RXE_MEM_STATE_FREE;
-				rxe_drop_ref(rmr);
 			}
 
 			wc->qp			= &qp->ibqp;
@@ -933,6 +953,8 @@ static enum resp_states do_complete(struct rxe_qp *qp,
 
 			wc->port_num		= qp->attr.port_num;
 		}
+	} else {
+		// TODO what???
 	}
 
 	/* have copy for srq and reference for !srq */
@@ -1224,9 +1246,17 @@ int rxe_responder(void *arg)
 	enum resp_states state;
 	struct rxe_pkt_info *pkt = NULL;
 	int ret = 0;
+	int entered;
 
 	rxe_add_ref(qp);
 
+	// this code is 'guaranteed' to never be entered more
+	// than once. Check to make sure that this is the case
+	entered = atomic_inc_return(&qp->resp.task.entered);
+	if (entered > 1) {
+		pr_err("rxe_responder: entered %d times\n", entered);
+	}
+
 	qp->resp.aeth_syndrome = AETH_ACK_UNLIMITED;
 
 	if (!qp->valid) {
@@ -1405,6 +1435,7 @@ int rxe_responder(void *arg)
 exit:
 	ret = -EAGAIN;
 done:
+	atomic_dec(&qp->resp.task.entered);
 	rxe_drop_ref(qp);
 	return ret;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 476d90e3f91f..b11ab3ae87a3 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -970,7 +970,6 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
 	return &mr->ibmr;
 
 err3:
-	rxe_drop_index(mr);
 	rxe_drop_ref(mr);
 	rxe_drop_ref(pd);
 err2:
@@ -985,8 +984,6 @@ static int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 
 	mr->state = RXE_MEM_STATE_ZOMBIE;
 	rxe_drop_ref(mr->pd);
-	rxe_drop_index(mr);
-	rxe_drop_key(mr);
 	rxe_drop_ref(mr);
 	return 0;
 }
@@ -1020,7 +1017,6 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
 
 err2:
 	rxe_drop_ref(pd);
-	rxe_drop_index(mr);
 	rxe_drop_ref(mr);
 err1:
 	return ERR_PTR(err);
-- 
2.25.1

