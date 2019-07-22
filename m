Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4106570354
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jul 2019 17:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbfGVPOj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Jul 2019 11:14:39 -0400
Received: from os.inf.tu-dresden.de ([141.76.48.99]:58244 "EHLO
        os.inf.tu-dresden.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728128AbfGVPOj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Jul 2019 11:14:39 -0400
Received: from [195.176.96.199] (helo=jupiter)
        by os.inf.tu-dresden.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92)
        id 1hpa1L-00089b-B6; Mon, 22 Jul 2019 17:14:35 +0200
From:   Maksym Planeta <mplaneta@os.inf.tu-dresden.de>
To:     Moni Shoua <monis@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Maksym Planeta <mplaneta@os.inf.tu-dresden.de>
Subject: [PATCH 03/10] Make pool interface more type safe
Date:   Mon, 22 Jul 2019 17:14:19 +0200
Message-Id: <20190722151426.5266-4-mplaneta@os.inf.tu-dresden.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190722151426.5266-1-mplaneta@os.inf.tu-dresden.de>
References: <20190722151426.5266-1-mplaneta@os.inf.tu-dresden.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Replace void* with rxe_pool_entry* for some functions.

Change macro to inline function.

Signed-off-by: Maksym Planeta <mplaneta@os.inf.tu-dresden.de>
---
 drivers/infiniband/sw/rxe/rxe_comp.c  | 18 ++++----
 drivers/infiniband/sw/rxe/rxe_mcast.c | 20 ++++----
 drivers/infiniband/sw/rxe/rxe_mr.c    |  8 ++--
 drivers/infiniband/sw/rxe/rxe_net.c   |  6 +--
 drivers/infiniband/sw/rxe/rxe_pool.c  | 12 ++---
 drivers/infiniband/sw/rxe/rxe_pool.h  | 16 ++++---
 drivers/infiniband/sw/rxe/rxe_qp.c    | 32 ++++++-------
 drivers/infiniband/sw/rxe/rxe_recv.c  |  8 ++--
 drivers/infiniband/sw/rxe/rxe_req.c   |  8 ++--
 drivers/infiniband/sw/rxe/rxe_resp.c  | 22 ++++-----
 drivers/infiniband/sw/rxe/rxe_verbs.c | 66 +++++++++++++--------------
 11 files changed, 108 insertions(+), 108 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index 5f3a43cfeb63..bdeb288673f3 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -534,7 +534,7 @@ static void rxe_drain_resp_pkts(struct rxe_qp *qp, bool notify)
 	struct rxe_send_wqe *wqe;
 
 	while ((skb = skb_dequeue(&qp->resp_pkts))) {
-		rxe_drop_ref(qp);
+		rxe_drop_ref(&qp->pelem);
 		kfree_skb(skb);
 	}
 
@@ -557,7 +557,7 @@ int rxe_completer(void *arg)
 	struct rxe_pkt_info *pkt = NULL;
 	enum comp_state state;
 
-	rxe_add_ref(qp);
+	rxe_add_ref(&qp->pelem);
 
 	if (!qp->valid || qp->req.state == QP_STATE_ERROR ||
 	    qp->req.state == QP_STATE_RESET) {
@@ -646,7 +646,7 @@ int rxe_completer(void *arg)
 
 		case COMPST_DONE:
 			if (pkt) {
-				rxe_drop_ref(pkt->qp);
+				rxe_drop_ref(&pkt->qp->pelem);
 				kfree_skb(skb);
 				skb = NULL;
 			}
@@ -694,7 +694,7 @@ int rxe_completer(void *arg)
 			if (qp->comp.started_retry &&
 			    !qp->comp.timeout_retry) {
 				if (pkt) {
-					rxe_drop_ref(pkt->qp);
+					rxe_drop_ref(&pkt->qp->pelem);
 					kfree_skb(skb);
 					skb = NULL;
 				}
@@ -723,7 +723,7 @@ int rxe_completer(void *arg)
 				}
 
 				if (pkt) {
-					rxe_drop_ref(pkt->qp);
+					rxe_drop_ref(&pkt->qp->pelem);
 					kfree_skb(skb);
 					skb = NULL;
 				}
@@ -748,7 +748,7 @@ int rxe_completer(void *arg)
 				mod_timer(&qp->rnr_nak_timer,
 					  jiffies + rnrnak_jiffies(aeth_syn(pkt)
 						& ~AETH_TYPE_MASK));
-				rxe_drop_ref(pkt->qp);
+				rxe_drop_ref(&pkt->qp->pelem);
 				kfree_skb(skb);
 				skb = NULL;
 				goto exit;
@@ -766,7 +766,7 @@ int rxe_completer(void *arg)
 			rxe_qp_error(qp);
 
 			if (pkt) {
-				rxe_drop_ref(pkt->qp);
+				rxe_drop_ref(&pkt->qp->pelem);
 				kfree_skb(skb);
 				skb = NULL;
 			}
@@ -780,7 +780,7 @@ int rxe_completer(void *arg)
 	 * exit from the loop calling us
 	 */
 	WARN_ON_ONCE(skb);
-	rxe_drop_ref(qp);
+	rxe_drop_ref(&qp->pelem);
 	return -EAGAIN;
 
 done:
@@ -788,6 +788,6 @@ int rxe_completer(void *arg)
 	 * us again to see if there is anything else to do
 	 */
 	WARN_ON_ONCE(skb);
-	rxe_drop_ref(qp);
+	rxe_drop_ref(&qp->pelem);
 	return 0;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
index 522a7942c56c..24ebc4ca1b99 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -59,7 +59,7 @@ int rxe_mcast_get_grp(struct rxe_dev *rxe, union ib_gid *mgid,
 	spin_lock_init(&grp->mcg_lock);
 	grp->rxe = rxe;
 
-	rxe_add_key(grp, mgid);
+	rxe_add_key(&grp->pelem, mgid);
 
 	err = rxe_mcast_add(rxe, mgid);
 	if (err)
@@ -70,7 +70,7 @@ int rxe_mcast_get_grp(struct rxe_dev *rxe, union ib_gid *mgid,
 	return 0;
 
 err2:
-	rxe_drop_ref(grp);
+	rxe_drop_ref(&grp->pelem);
 err1:
 	return err;
 }
@@ -103,7 +103,7 @@ int rxe_mcast_add_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 	}
 
 	/* each qp holds a ref on the grp */
-	rxe_add_ref(grp);
+	rxe_add_ref(&grp->pelem);
 
 	grp->num_qp++;
 	elem->qp = qp;
@@ -140,16 +140,16 @@ int rxe_mcast_drop_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 
 			spin_unlock_bh(&grp->mcg_lock);
 			spin_unlock_bh(&qp->grp_lock);
-			rxe_drop_ref(elem);
-			rxe_drop_ref(grp);	/* ref held by QP */
-			rxe_drop_ref(grp);	/* ref from get_key */
+			rxe_drop_ref(&elem->pelem);
+			rxe_drop_ref(&grp->pelem);	/* ref held by QP */
+			rxe_drop_ref(&grp->pelem);	/* ref from get_key */
 			return 0;
 		}
 	}
 
 	spin_unlock_bh(&grp->mcg_lock);
 	spin_unlock_bh(&qp->grp_lock);
-	rxe_drop_ref(grp);			/* ref from get_key */
+	rxe_drop_ref(&grp->pelem);			/* ref from get_key */
 err1:
 	return -EINVAL;
 }
@@ -175,8 +175,8 @@ void rxe_drop_all_mcast_groups(struct rxe_qp *qp)
 		list_del(&elem->qp_list);
 		grp->num_qp--;
 		spin_unlock_bh(&grp->mcg_lock);
-		rxe_drop_ref(grp);
-		rxe_drop_ref(elem);
+		rxe_drop_ref(&grp->pelem);
+		rxe_drop_ref(&elem->pelem);
 	}
 }
 
@@ -185,6 +185,6 @@ void rxe_mc_cleanup(struct rxe_pool_entry *arg)
 	struct rxe_mc_grp *grp = container_of(arg, typeof(*grp), pelem);
 	struct rxe_dev *rxe = grp->rxe;
 
-	rxe_drop_key(grp);
+	rxe_drop_key(&grp->pelem);
 	rxe_mcast_delete(rxe, &grp->mgid);
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index ea6a819b7167..441b01e30afa 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -470,7 +470,7 @@ int copy_data(
 
 		if (offset >= sge->length) {
 			if (mem) {
-				rxe_drop_ref(mem);
+				rxe_drop_ref(&mem->pelem);
 				mem = NULL;
 			}
 			sge++;
@@ -515,13 +515,13 @@ int copy_data(
 	dma->resid	= resid;
 
 	if (mem)
-		rxe_drop_ref(mem);
+		rxe_drop_ref(&mem->pelem);
 
 	return 0;
 
 err2:
 	if (mem)
-		rxe_drop_ref(mem);
+		rxe_drop_ref(&mem->pelem);
 err1:
 	return err;
 }
@@ -581,7 +581,7 @@ struct rxe_mem *lookup_mem(struct rxe_pd *pd, int access, u32 key,
 		     mem->pd != pd ||
 		     (access && !(access & mem->access)) ||
 		     mem->state != RXE_MEM_STATE_VALID)) {
-		rxe_drop_ref(mem);
+		rxe_drop_ref(&mem->pelem);
 		mem = NULL;
 	}
 
diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index e50f19fadcf9..f8c3604bc5ad 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -416,7 +416,7 @@ static void rxe_skb_tx_dtor(struct sk_buff *skb)
 		     skb_out < RXE_INFLIGHT_SKBS_PER_QP_LOW))
 		rxe_run_task(&qp->req.task);
 
-	rxe_drop_ref(qp);
+	rxe_drop_ref(&qp->pelem);
 }
 
 int rxe_send(struct rxe_pkt_info *pkt, struct sk_buff *skb)
@@ -426,7 +426,7 @@ int rxe_send(struct rxe_pkt_info *pkt, struct sk_buff *skb)
 	skb->destructor = rxe_skb_tx_dtor;
 	skb->sk = pkt->qp->sk->sk;
 
-	rxe_add_ref(pkt->qp);
+	rxe_add_ref(&pkt->qp->pelem);
 	atomic_inc(&pkt->qp->skb_out);
 
 	if (skb->protocol == htons(ETH_P_IP)) {
@@ -436,7 +436,7 @@ int rxe_send(struct rxe_pkt_info *pkt, struct sk_buff *skb)
 	} else {
 		pr_err("Unknown layer 3 protocol: %d\n", skb->protocol);
 		atomic_dec(&pkt->qp->skb_out);
-		rxe_drop_ref(pkt->qp);
+		rxe_drop_ref(&pkt->qp->pelem);
 		kfree_skb(skb);
 		return -EINVAL;
 	}
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index fbcbac52290b..efa9bab01e02 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -338,9 +338,8 @@ static void insert_key(struct rxe_pool *pool, struct rxe_pool_entry *new)
 	return;
 }
 
-void rxe_add_key(void *arg, void *key)
+void rxe_add_key(struct rxe_pool_entry *elem, void *key)
 {
-	struct rxe_pool_entry *elem = arg;
 	struct rxe_pool *pool = elem->pool;
 	unsigned long flags;
 
@@ -350,9 +349,8 @@ void rxe_add_key(void *arg, void *key)
 	write_unlock_irqrestore(&pool->pool_lock, flags);
 }
 
-void rxe_drop_key(void *arg)
+void rxe_drop_key(struct rxe_pool_entry *elem)
 {
-	struct rxe_pool_entry *elem = arg;
 	struct rxe_pool *pool = elem->pool;
 	unsigned long flags;
 
@@ -361,9 +359,8 @@ void rxe_drop_key(void *arg)
 	write_unlock_irqrestore(&pool->pool_lock, flags);
 }
 
-void rxe_add_index(void *arg)
+void rxe_add_index(struct rxe_pool_entry *elem)
 {
-	struct rxe_pool_entry *elem = arg;
 	struct rxe_pool *pool = elem->pool;
 	unsigned long flags;
 
@@ -373,9 +370,8 @@ void rxe_add_index(void *arg)
 	write_unlock_irqrestore(&pool->pool_lock, flags);
 }
 
-void rxe_drop_index(void *arg)
+void rxe_drop_index(struct rxe_pool_entry *elem)
 {
-	struct rxe_pool_entry *elem = arg;
 	struct rxe_pool *pool = elem->pool;
 	unsigned long flags;
 
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index 2f2cff1cbe43..5c6a9429f541 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -138,18 +138,18 @@ int rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_entry *elem);
 /* assign an index to an indexed object and insert object into
  *  pool's rb tree
  */
-void rxe_add_index(void *elem);
+void rxe_add_index(struct rxe_pool_entry *elem);
 
 /* drop an index and remove object from rb tree */
-void rxe_drop_index(void *elem);
+void rxe_drop_index(struct rxe_pool_entry *elem);
 
 /* assign a key to a keyed object and insert object into
  *  pool's rb tree
  */
-void rxe_add_key(void *elem, void *key);
+void rxe_add_key(struct rxe_pool_entry *elem, void *key);
 
 /* remove elem from rb tree */
-void rxe_drop_key(void *elem);
+void rxe_drop_key(struct rxe_pool_entry *elem);
 
 /* lookup an indexed object from index. takes a reference on object */
 void *rxe_pool_get_index(struct rxe_pool *pool, u32 index);
@@ -161,9 +161,13 @@ void *rxe_pool_get_key(struct rxe_pool *pool, void *key);
 void rxe_elem_release(struct kref *kref);
 
 /* take a reference on an object */
-#define rxe_add_ref(elem) kref_get(&(elem)->pelem.ref_cnt)
+static inline void rxe_add_ref(struct rxe_pool_entry *pelem) {
+	kref_get(&pelem->ref_cnt);
+}
 
 /* drop a reference on an object */
-#define rxe_drop_ref(elem) kref_put(&(elem)->pelem.ref_cnt, rxe_elem_release)
+static inline void rxe_drop_ref(struct rxe_pool_entry *pelem) {
+	kref_put(&pelem->ref_cnt, rxe_elem_release);
+}
 
 #endif /* RXE_POOL_H */
diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index 623f44f1d1d5..7cd929185581 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -152,11 +152,11 @@ static void free_rd_atomic_resources(struct rxe_qp *qp)
 void free_rd_atomic_resource(struct rxe_qp *qp, struct resp_res *res)
 {
 	if (res->type == RXE_ATOMIC_MASK) {
-		rxe_drop_ref(qp);
+		rxe_drop_ref(&qp->pelem);
 		kfree_skb(res->atomic.skb);
 	} else if (res->type == RXE_READ_MASK) {
 		if (res->read.mr)
-			rxe_drop_ref(res->read.mr);
+			rxe_drop_ref(&res->read.mr->pelem);
 	}
 	res->type = 0;
 }
@@ -344,11 +344,11 @@ int rxe_qp_from_init(struct rxe_dev *rxe, struct rxe_qp *qp, struct rxe_pd *pd,
 	struct rxe_cq *scq = to_rcq(init->send_cq);
 	struct rxe_srq *srq = init->srq ? to_rsrq(init->srq) : NULL;
 
-	rxe_add_ref(pd);
-	rxe_add_ref(rcq);
-	rxe_add_ref(scq);
+	rxe_add_ref(&pd->pelem);
+	rxe_add_ref(&rcq->pelem);
+	rxe_add_ref(&scq->pelem);
 	if (srq)
-		rxe_add_ref(srq);
+		rxe_add_ref(&srq->pelem);
 
 	qp->pd			= pd;
 	qp->rcq			= rcq;
@@ -374,10 +374,10 @@ int rxe_qp_from_init(struct rxe_dev *rxe, struct rxe_qp *qp, struct rxe_pd *pd,
 	rxe_queue_cleanup(qp->sq.queue);
 err1:
 	if (srq)
-		rxe_drop_ref(srq);
-	rxe_drop_ref(scq);
-	rxe_drop_ref(rcq);
-	rxe_drop_ref(pd);
+		rxe_drop_ref(&srq->pelem);
+	rxe_drop_ref(&scq->pelem);
+	rxe_drop_ref(&rcq->pelem);
+	rxe_drop_ref(&pd->pelem);
 
 	return err;
 }
@@ -536,7 +536,7 @@ static void rxe_qp_reset(struct rxe_qp *qp)
 	qp->resp.sent_psn_nak = 0;
 
 	if (qp->resp.mr) {
-		rxe_drop_ref(qp->resp.mr);
+		rxe_drop_ref(&qp->resp.mr->pelem);
 		qp->resp.mr = NULL;
 	}
 
@@ -812,20 +812,20 @@ static void rxe_qp_do_cleanup(struct work_struct *work)
 		rxe_queue_cleanup(qp->sq.queue);
 
 	if (qp->srq)
-		rxe_drop_ref(qp->srq);
+		rxe_drop_ref(&qp->srq->pelem);
 
 	if (qp->rq.queue)
 		rxe_queue_cleanup(qp->rq.queue);
 
 	if (qp->scq)
-		rxe_drop_ref(qp->scq);
+		rxe_drop_ref(&qp->scq->pelem);
 	if (qp->rcq)
-		rxe_drop_ref(qp->rcq);
+		rxe_drop_ref(&qp->rcq->pelem);
 	if (qp->pd)
-		rxe_drop_ref(qp->pd);
+		rxe_drop_ref(&qp->pd->pelem);
 
 	if (qp->resp.mr) {
-		rxe_drop_ref(qp->resp.mr);
+		rxe_drop_ref(&qp->resp.mr->pelem);
 		qp->resp.mr = NULL;
 	}
 
diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
index f9a492ed900b..bd8dc133a722 100644
--- a/drivers/infiniband/sw/rxe/rxe_recv.c
+++ b/drivers/infiniband/sw/rxe/rxe_recv.c
@@ -261,7 +261,7 @@ static int hdr_check(struct rxe_pkt_info *pkt)
 	return 0;
 
 err2:
-	rxe_drop_ref(qp);
+	rxe_drop_ref(&qp->pelem);
 err1:
 	return -EINVAL;
 }
@@ -316,13 +316,13 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
 			skb_get(skb);
 
 		pkt->qp = qp;
-		rxe_add_ref(qp);
+		rxe_add_ref(&qp->pelem);
 		rxe_rcv_pkt(pkt, skb);
 	}
 
 	spin_unlock_bh(&mcg->mcg_lock);
 
-	rxe_drop_ref(mcg);	/* drop ref from rxe_pool_get_key. */
+	rxe_drop_ref(&mcg->pelem);	/* drop ref from rxe_pool_get_key. */
 
 err1:
 	kfree_skb(skb);
@@ -415,7 +415,7 @@ void rxe_rcv(struct sk_buff *skb)
 
 drop:
 	if (pkt->qp)
-		rxe_drop_ref(pkt->qp);
+		rxe_drop_ref(&pkt->qp->pelem);
 
 	kfree_skb(skb);
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index a84c0407545b..0d018adbe512 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -594,7 +594,7 @@ int rxe_requester(void *arg)
 	struct rxe_send_wqe rollback_wqe;
 	u32 rollback_psn;
 
-	rxe_add_ref(qp);
+	rxe_add_ref(&qp->pelem);
 
 next_wqe:
 	if (unlikely(!qp->valid || qp->req.state == QP_STATE_ERROR))
@@ -633,7 +633,7 @@ int rxe_requester(void *arg)
 				goto exit;
 			}
 			rmr->state = RXE_MEM_STATE_FREE;
-			rxe_drop_ref(rmr);
+			rxe_drop_ref(&rmr->pelem);
 			wqe->state = wqe_state_done;
 			wqe->status = IB_WC_SUCCESS;
 		} else if (wqe->wr.opcode == IB_WR_REG_MR) {
@@ -702,7 +702,7 @@ int rxe_requester(void *arg)
 			wqe->state = wqe_state_done;
 			wqe->status = IB_WC_SUCCESS;
 			__rxe_do_task(&qp->comp.task);
-			rxe_drop_ref(qp);
+			rxe_drop_ref(&qp->pelem);
 			return 0;
 		}
 		payload = mtu;
@@ -753,6 +753,6 @@ int rxe_requester(void *arg)
 	__rxe_do_task(&qp->comp.task);
 
 exit:
-	rxe_drop_ref(qp);
+	rxe_drop_ref(&qp->pelem);
 	return -EAGAIN;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index d4b5535b8517..f038bae1bd70 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -118,7 +118,7 @@ static inline enum resp_states get_req(struct rxe_qp *qp,
 
 	if (qp->resp.state == QP_STATE_ERROR) {
 		while ((skb = skb_dequeue(&qp->req_pkts))) {
-			rxe_drop_ref(qp);
+			rxe_drop_ref(&qp->pelem);
 			kfree_skb(skb);
 		}
 
@@ -494,7 +494,7 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 
 err:
 	if (mem)
-		rxe_drop_ref(mem);
+		rxe_drop_ref(&mem->pelem);
 	return state;
 }
 
@@ -910,7 +910,7 @@ static enum resp_states do_complete(struct rxe_qp *qp,
 					return RESPST_ERROR;
 				}
 				rmr->state = RXE_MEM_STATE_FREE;
-				rxe_drop_ref(rmr);
+				rxe_drop_ref(&rmr->pelem);
 			}
 
 			wc->qp			= &qp->ibqp;
@@ -980,7 +980,7 @@ static int send_atomic_ack(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
 		goto out;
 	}
 
-	rxe_add_ref(qp);
+	rxe_add_ref(&qp->pelem);
 
 	res = &qp->resp.resources[qp->resp.res_head];
 	free_rd_atomic_resource(qp, res);
@@ -1000,7 +1000,7 @@ static int send_atomic_ack(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
 	rc = rxe_xmit_packet(qp, &ack_pkt, skb);
 	if (rc) {
 		pr_err_ratelimited("Failed sending ack\n");
-		rxe_drop_ref(qp);
+		rxe_drop_ref(&qp->pelem);
 	}
 out:
 	return rc;
@@ -1029,12 +1029,12 @@ static enum resp_states cleanup(struct rxe_qp *qp,
 
 	if (pkt) {
 		skb = skb_dequeue(&qp->req_pkts);
-		rxe_drop_ref(qp);
+		rxe_drop_ref(&qp->pelem);
 		kfree_skb(skb);
 	}
 
 	if (qp->resp.mr) {
-		rxe_drop_ref(qp->resp.mr);
+		rxe_drop_ref(&qp->resp.mr->pelem);
 		qp->resp.mr = NULL;
 	}
 
@@ -1180,7 +1180,7 @@ static enum resp_states do_class_d1e_error(struct rxe_qp *qp)
 		}
 
 		if (qp->resp.mr) {
-			rxe_drop_ref(qp->resp.mr);
+			rxe_drop_ref(&qp->resp.mr->pelem);
 			qp->resp.mr = NULL;
 		}
 
@@ -1193,7 +1193,7 @@ static void rxe_drain_req_pkts(struct rxe_qp *qp, bool notify)
 	struct sk_buff *skb;
 
 	while ((skb = skb_dequeue(&qp->req_pkts))) {
-		rxe_drop_ref(qp);
+		rxe_drop_ref(&qp->pelem);
 		kfree_skb(skb);
 	}
 
@@ -1212,7 +1212,7 @@ int rxe_responder(void *arg)
 	struct rxe_pkt_info *pkt = NULL;
 	int ret = 0;
 
-	rxe_add_ref(qp);
+	rxe_add_ref(&qp->pelem);
 
 	qp->resp.aeth_syndrome = AETH_ACK_UNLIMITED;
 
@@ -1392,6 +1392,6 @@ int rxe_responder(void *arg)
 exit:
 	ret = -EAGAIN;
 done:
-	rxe_drop_ref(qp);
+	rxe_drop_ref(&qp->pelem);
 	return ret;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index f6b25b409d12..545eff108070 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -154,7 +154,7 @@ static void rxe_dealloc_ucontext(struct ib_ucontext *ibuc)
 {
 	struct rxe_ucontext *uc = to_ruc(ibuc);
 
-	rxe_drop_ref(uc);
+	rxe_drop_ref(&uc->pelem);
 }
 
 static int rxe_port_immutable(struct ib_device *dev, u8 port_num,
@@ -188,7 +188,7 @@ static void rxe_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 {
 	struct rxe_pd *pd = to_rpd(ibpd);
 
-	rxe_drop_ref(pd);
+	rxe_drop_ref(&pd->pelem);
 }
 
 static int rxe_create_ah(struct ib_ah *ibah, struct rdma_ah_attr *attr,
@@ -239,7 +239,7 @@ static void rxe_destroy_ah(struct ib_ah *ibah, u32 flags)
 {
 	struct rxe_ah *ah = to_rah(ibah);
 
-	rxe_drop_ref(ah);
+	rxe_drop_ref(&ah->pelem);
 }
 
 static int post_one_recv(struct rxe_rq *rq, const struct ib_recv_wr *ibwr)
@@ -312,7 +312,7 @@ static int rxe_create_srq(struct ib_srq *ibsrq, struct ib_srq_init_attr *init,
 	if (err)
 		goto err1;
 
-	rxe_add_ref(pd);
+	rxe_add_ref(&pd->pelem);
 	srq->pd = pd;
 
 	err = rxe_srq_from_init(rxe, srq, init, udata, uresp);
@@ -322,8 +322,8 @@ static int rxe_create_srq(struct ib_srq *ibsrq, struct ib_srq_init_attr *init,
 	return 0;
 
 err2:
-	rxe_drop_ref(pd);
-	rxe_drop_ref(srq);
+	rxe_drop_ref(&pd->pelem);
+	rxe_drop_ref(&srq->pelem);
 err1:
 	return err;
 }
@@ -380,8 +380,8 @@ static void rxe_destroy_srq(struct ib_srq *ibsrq, struct ib_udata *udata)
 	if (srq->rq.queue)
 		rxe_queue_cleanup(srq->rq.queue);
 
-	rxe_drop_ref(srq->pd);
-	rxe_drop_ref(srq);
+	rxe_drop_ref(&srq->pd->pelem);
+	rxe_drop_ref(&srq->pelem);
 }
 
 static int rxe_post_srq_recv(struct ib_srq *ibsrq, const struct ib_recv_wr *wr,
@@ -442,7 +442,7 @@ static struct ib_qp *rxe_create_qp(struct ib_pd *ibpd,
 		qp->is_user = 1;
 	}
 
-	rxe_add_index(qp);
+	rxe_add_index(&qp->pelem);
 
 	err = rxe_qp_from_init(rxe, qp, pd, init, uresp, ibpd, udata);
 	if (err)
@@ -451,9 +451,9 @@ static struct ib_qp *rxe_create_qp(struct ib_pd *ibpd,
 	return &qp->ibqp;
 
 err3:
-	rxe_drop_index(qp);
+	rxe_drop_index(&qp->pelem);
 err2:
-	rxe_drop_ref(qp);
+	rxe_drop_ref(&qp->pelem);
 err1:
 	return ERR_PTR(err);
 }
@@ -495,8 +495,8 @@ static int rxe_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 	struct rxe_qp *qp = to_rqp(ibqp);
 
 	rxe_qp_destroy(qp);
-	rxe_drop_index(qp);
-	rxe_drop_ref(qp);
+	rxe_drop_index(&qp->pelem);
+	rxe_drop_ref(&qp->pelem);
 	return 0;
 }
 
@@ -814,7 +814,7 @@ static void rxe_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 
 	rxe_cq_disable(cq);
 
-	rxe_drop_ref(cq);
+	rxe_drop_ref(&cq->pelem);
 }
 
 static int rxe_resize_cq(struct ib_cq *ibcq, int cqe, struct ib_udata *udata)
@@ -904,9 +904,9 @@ static struct ib_mr *rxe_get_dma_mr(struct ib_pd *ibpd, int access)
 		goto err1;
 	}
 
-	rxe_add_index(mr);
+	rxe_add_index(&mr->pelem);
 
-	rxe_add_ref(pd);
+	rxe_add_ref(&pd->pelem);
 
 	err = rxe_mem_init_dma(pd, access, mr);
 	if (err)
@@ -915,9 +915,9 @@ static struct ib_mr *rxe_get_dma_mr(struct ib_pd *ibpd, int access)
 	return &mr->ibmr;
 
 err2:
-	rxe_drop_ref(pd);
-	rxe_drop_index(mr);
-	rxe_drop_ref(mr);
+	rxe_drop_ref(&pd->pelem);
+	rxe_drop_index(&mr->pelem);
+	rxe_drop_ref(&mr->pelem);
 err1:
 	return ERR_PTR(err);
 }
@@ -939,9 +939,9 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
 		goto err2;
 	}
 
-	rxe_add_index(mr);
+	rxe_add_index(&mr->pelem);
 
-	rxe_add_ref(pd);
+	rxe_add_ref(&pd->pelem);
 
 	err = rxe_mem_init_user(pd, start, length, iova,
 				access, udata, mr);
@@ -951,9 +951,9 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
 	return &mr->ibmr;
 
 err3:
-	rxe_drop_ref(pd);
-	rxe_drop_index(mr);
-	rxe_drop_ref(mr);
+	rxe_drop_ref(&pd->pelem);
+	rxe_drop_index(&mr->pelem);
+	rxe_drop_ref(&mr->pelem);
 err2:
 	return ERR_PTR(err);
 }
@@ -963,9 +963,9 @@ static int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 	struct rxe_mem *mr = to_rmr(ibmr);
 
 	mr->state = RXE_MEM_STATE_ZOMBIE;
-	rxe_drop_ref(mr->pd);
-	rxe_drop_index(mr);
-	rxe_drop_ref(mr);
+	rxe_drop_ref(&mr->pd->pelem);
+	rxe_drop_index(&mr->pelem);
+	rxe_drop_ref(&mr->pelem);
 	return 0;
 }
 
@@ -986,9 +986,9 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
 		goto err1;
 	}
 
-	rxe_add_index(mr);
+	rxe_add_index(&mr->pelem);
 
-	rxe_add_ref(pd);
+	rxe_add_ref(&pd->pelem);
 
 	err = rxe_mem_init_fast(pd, max_num_sg, mr);
 	if (err)
@@ -997,9 +997,9 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
 	return &mr->ibmr;
 
 err2:
-	rxe_drop_ref(pd);
-	rxe_drop_index(mr);
-	rxe_drop_ref(mr);
+	rxe_drop_ref(&pd->pelem);
+	rxe_drop_index(&mr->pelem);
+	rxe_drop_ref(&mr->pelem);
 err1:
 	return ERR_PTR(err);
 }
@@ -1057,7 +1057,7 @@ static int rxe_attach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid)
 
 	err = rxe_mcast_add_grp_elem(rxe, qp, grp);
 
-	rxe_drop_ref(grp);
+	rxe_drop_ref(&grp->pelem);
 	return err;
 }
 
-- 
2.20.1

