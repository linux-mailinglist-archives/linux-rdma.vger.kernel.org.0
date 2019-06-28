Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA9D5A31B
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Jun 2019 20:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfF1SEb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Jun 2019 14:04:31 -0400
Received: from mga02.intel.com ([134.134.136.20]:51948 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726416AbfF1SEb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 28 Jun 2019 14:04:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jun 2019 11:04:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,428,1557212400"; 
   d="scan'208";a="314201893"
Received: from sedona.ch.intel.com ([10.2.136.157])
  by orsmga004.jf.intel.com with ESMTP; 28 Jun 2019 11:04:26 -0700
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id x5SI4Ps5055094;
        Fri, 28 Jun 2019 11:04:25 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id x5SI4Oxo067659;
        Fri, 28 Jun 2019 14:04:24 -0400
Subject: [PATCH for-next v5 2/3] IB/hfi1: Move receive work queue struct
 into uapi directory
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Kamenee Arumugam <kamenee.arumugam@intel.com>
Date:   Fri, 28 Jun 2019 14:04:24 -0400
Message-ID: <20190628180424.67586.44331.stgit@awfm-01.aw.intel.com>
In-Reply-To: <20190628180316.67586.73737.stgit@awfm-01.aw.intel.com>
References: <20190628180316.67586.73737.stgit@awfm-01.aw.intel.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Kamenee Arumugam <kamenee.arumugam@intel.com>

The rvt_rwqe and rvt_rwq struct elements are shared between
rdmavt and the providers but are not in uapi directory.
As per the comment in
https://marc.info/?l=linux-rdma&m=152296522708522&w=2,
The hfi1 driver and the rdma core driver are not using
shared structures in the uapi directory.

Move rvt_rwqe and rvt_rwq struct into rvt-abi.h header in uapi
directory.

Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Reviewed-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
Signed-off-by: Kamenee Arumugam <kamenee.arumugam@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>

---
Changes from v2
Added all the changes related to moving receive work queue into uapi
directory into this patch.

Changes from v1
Fix u32 data types in rvt-abi.h to use __u32.
Changed zero length array to flexible array defined in rvt-abi.h
header file.
---
 drivers/infiniband/sw/rdmavt/qp.c  |  152 ++++++++++++++++++++++++++----------
 drivers/infiniband/sw/rdmavt/qp.h  |    2 
 drivers/infiniband/sw/rdmavt/rc.c  |   10 ++
 drivers/infiniband/sw/rdmavt/srq.c |   59 ++++++++------
 include/rdma/rdmavt_qp.h           |   52 +++++++-----
 include/uapi/rdma/rvt-abi.h        |   29 +++++++
 6 files changed, 212 insertions(+), 92 deletions(-)

diff --git a/drivers/infiniband/sw/rdmavt/qp.c b/drivers/infiniband/sw/rdmavt/qp.c
index 0d804a5..1384060 100644
--- a/drivers/infiniband/sw/rdmavt/qp.c
+++ b/drivers/infiniband/sw/rdmavt/qp.c
@@ -803,6 +803,46 @@ static void rvt_remove_qp(struct rvt_dev_info *rdi, struct rvt_qp *qp)
 }
 
 /**
+ * rvt_alloc_rq - allocate memory for user or kernel buffer
+ * @rq: receive queue data structure
+ * @size: number of request queue entries
+ * @node: The NUMA node
+ * @udata: True if user data is available or not false
+ *
+ * Return: If memory allocation failed, return -ENONEM
+ * This function is used by both shared receive
+ * queues and non-shared receive queues to allocate
+ * memory.
+ */
+int rvt_alloc_rq(struct rvt_rq *rq, u32 size, int node,
+		 struct ib_udata *udata)
+{
+	if (udata) {
+		rq->wq = vmalloc_user(sizeof(struct rvt_rwq) + size);
+		if (!rq->wq)
+			goto bail;
+		/* need kwq with no buffers */
+		rq->kwq = kzalloc_node(sizeof(*rq->kwq), GFP_KERNEL, node);
+		if (!rq->kwq)
+			goto bail;
+		rq->kwq->curr_wq = rq->wq->wq;
+	} else {
+		/* need kwq with buffers */
+		rq->kwq =
+			vzalloc_node(sizeof(struct rvt_krwq) + size, node);
+		if (!rq->kwq)
+			goto bail;
+		rq->kwq->curr_wq = rq->kwq->wq;
+	}
+
+	spin_lock_init(&rq->lock);
+	return 0;
+bail:
+	rvt_free_rq(rq);
+	return -ENOMEM;
+}
+
+/**
  * rvt_init_qp - initialize the QP state to the reset state
  * @qp: the QP to init or reinit
  * @type: the QP type
@@ -852,10 +892,6 @@ static void rvt_init_qp(struct rvt_dev_info *rdi, struct rvt_qp *qp,
 	qp->s_tail_ack_queue = 0;
 	qp->s_acked_ack_queue = 0;
 	qp->s_num_rd_atomic = 0;
-	if (qp->r_rq.wq) {
-		qp->r_rq.wq->head = 0;
-		qp->r_rq.wq->tail = 0;
-	}
 	qp->r_sge.num_sge = 0;
 	atomic_set(&qp->s_reserved_used, 0);
 }
@@ -1046,17 +1082,12 @@ struct ib_qp *rvt_create_qp(struct ib_pd *ibpd,
 			qp->r_rq.max_sge = init_attr->cap.max_recv_sge;
 			sz = (sizeof(struct ib_sge) * qp->r_rq.max_sge) +
 				sizeof(struct rvt_rwqe);
-			if (udata)
-				qp->r_rq.wq = vmalloc_user(
-						sizeof(struct rvt_rwq) +
-						qp->r_rq.size * sz);
-			else
-				qp->r_rq.wq = vzalloc_node(
-						sizeof(struct rvt_rwq) +
-						qp->r_rq.size * sz,
-						rdi->dparms.node);
-			if (!qp->r_rq.wq)
+			err = rvt_alloc_rq(&qp->r_rq, qp->r_rq.size * sz,
+					   rdi->dparms.node, udata);
+			if (err) {
+				ret = ERR_PTR(err);
 				goto bail_driver_priv;
+			}
 		}
 
 		/*
@@ -1202,8 +1233,7 @@ struct ib_qp *rvt_create_qp(struct ib_pd *ibpd,
 	rvt_free_qpn(&rdi->qp_dev->qpn_table, qp->ibqp.qp_num);
 
 bail_rq_wq:
-	if (!qp->ip)
-		vfree(qp->r_rq.wq);
+	rvt_free_rq(&qp->r_rq);
 
 bail_driver_priv:
 	rdi->driver_f.qp_priv_free(rdi, qp);
@@ -1269,19 +1299,26 @@ int rvt_error_qp(struct rvt_qp *qp, enum ib_wc_status err)
 	}
 	wc.status = IB_WC_WR_FLUSH_ERR;
 
-	if (qp->r_rq.wq) {
-		struct rvt_rwq *wq;
+	if (qp->r_rq.kwq) {
 		u32 head;
 		u32 tail;
+		struct rvt_rwq *wq = NULL;
+		struct rvt_krwq *kwq = NULL;
 
 		spin_lock(&qp->r_rq.lock);
-
+		/* qp->ip used to validate if there is a  user buffer mmaped */
+		if (qp->ip) {
+			wq = qp->r_rq.wq;
+			head = RDMA_READ_UAPI_ATOMIC(wq->head);
+			tail = RDMA_READ_UAPI_ATOMIC(wq->tail);
+		} else {
+			kwq = qp->r_rq.kwq;
+			head = kwq->head;
+			tail = kwq->tail;
+		}
 		/* sanity check pointers before trusting them */
-		wq = qp->r_rq.wq;
-		head = wq->head;
 		if (head >= qp->r_rq.size)
 			head = 0;
-		tail = wq->tail;
 		if (tail >= qp->r_rq.size)
 			tail = 0;
 		while (tail != head) {
@@ -1290,8 +1327,10 @@ int rvt_error_qp(struct rvt_qp *qp, enum ib_wc_status err)
 				tail = 0;
 			rvt_cq_enter(ibcq_to_rvtcq(qp->ibqp.recv_cq), &wc, 1);
 		}
-		wq->tail = tail;
-
+		if (qp->ip)
+			RDMA_WRITE_UAPI_ATOMIC(wq->tail, tail);
+		else
+			kwq->tail = tail;
 		spin_unlock(&qp->r_rq.lock);
 	} else if (qp->ibqp.event_handler) {
 		ret = 1;
@@ -1634,8 +1673,7 @@ int rvt_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 
 	if (qp->ip)
 		kref_put(&qp->ip->ref, rvt_release_mmap_info);
-	else
-		vfree(qp->r_rq.wq);
+	kvfree(qp->r_rq.kwq);
 	rdi->driver_f.qp_priv_free(rdi, qp);
 	kfree(qp->s_ack_queue);
 	rdma_destroy_ah_attr(&qp->remote_ah_attr);
@@ -1721,7 +1759,7 @@ int rvt_post_recv(struct ib_qp *ibqp, const struct ib_recv_wr *wr,
 		  const struct ib_recv_wr **bad_wr)
 {
 	struct rvt_qp *qp = ibqp_to_rvtqp(ibqp);
-	struct rvt_rwq *wq = qp->r_rq.wq;
+	struct rvt_krwq *wq = qp->r_rq.kwq;
 	unsigned long flags;
 	int qp_err_flush = (ib_rvt_state_ops[qp->state] & RVT_FLUSH_RECV) &&
 				!qp->ibqp.srq;
@@ -1746,7 +1784,7 @@ int rvt_post_recv(struct ib_qp *ibqp, const struct ib_recv_wr *wr,
 		next = wq->head + 1;
 		if (next >= qp->r_rq.size)
 			next = 0;
-		if (next == wq->tail) {
+		if (next == READ_ONCE(wq->tail)) {
 			spin_unlock_irqrestore(&qp->r_rq.lock, flags);
 			*bad_wr = wr;
 			return -ENOMEM;
@@ -1770,8 +1808,7 @@ int rvt_post_recv(struct ib_qp *ibqp, const struct ib_recv_wr *wr,
 			 * Make sure queue entry is written
 			 * before the head index.
 			 */
-			smp_wmb();
-			wq->head = next;
+			smp_store_release(&wq->head, next);
 		}
 		spin_unlock_irqrestore(&qp->r_rq.lock, flags);
 	}
@@ -2141,7 +2178,7 @@ int rvt_post_srq_recv(struct ib_srq *ibsrq, const struct ib_recv_wr *wr,
 		      const struct ib_recv_wr **bad_wr)
 {
 	struct rvt_srq *srq = ibsrq_to_rvtsrq(ibsrq);
-	struct rvt_rwq *wq;
+	struct rvt_krwq *wq;
 	unsigned long flags;
 
 	for (; wr; wr = wr->next) {
@@ -2155,11 +2192,11 @@ int rvt_post_srq_recv(struct ib_srq *ibsrq, const struct ib_recv_wr *wr,
 		}
 
 		spin_lock_irqsave(&srq->rq.lock, flags);
-		wq = srq->rq.wq;
+		wq = srq->rq.kwq;
 		next = wq->head + 1;
 		if (next >= srq->rq.size)
 			next = 0;
-		if (next == wq->tail) {
+		if (next == READ_ONCE(wq->tail)) {
 			spin_unlock_irqrestore(&srq->rq.lock, flags);
 			*bad_wr = wr;
 			return -ENOMEM;
@@ -2171,8 +2208,7 @@ int rvt_post_srq_recv(struct ib_srq *ibsrq, const struct ib_recv_wr *wr,
 		for (i = 0; i < wr->num_sge; i++)
 			wqe->sg_list[i] = wr->sg_list[i];
 		/* Make sure queue entry is written before the head index. */
-		smp_wmb();
-		wq->head = next;
+		smp_store_release(&wq->head, next);
 		spin_unlock_irqrestore(&srq->rq.lock, flags);
 	}
 	return 0;
@@ -2230,6 +2266,25 @@ static int init_sge(struct rvt_qp *qp, struct rvt_rwqe *wqe)
 }
 
 /**
+ * get_rvt_head - get head indices of the circular buffer
+ * @rq: data structure for request queue entry
+ * @ip: the QP
+ *
+ * Return - head index value
+ */
+static inline u32 get_rvt_head(struct rvt_rq *rq, void *ip)
+{
+	u32 head;
+
+	if (ip)
+		head = RDMA_READ_UAPI_ATOMIC(rq->wq->head);
+	else
+		head = rq->kwq->head;
+
+	return head;
+}
+
+/**
  * rvt_get_rwqe - copy the next RWQE into the QP's RWQE
  * @qp: the QP
  * @wr_id_only: update qp->r_wr_id only, not qp->r_sge
@@ -2243,21 +2298,26 @@ int rvt_get_rwqe(struct rvt_qp *qp, bool wr_id_only)
 {
 	unsigned long flags;
 	struct rvt_rq *rq;
+	struct rvt_krwq *kwq;
 	struct rvt_rwq *wq;
 	struct rvt_srq *srq;
 	struct rvt_rwqe *wqe;
 	void (*handler)(struct ib_event *, void *);
 	u32 tail;
+	u32 head;
 	int ret;
+	void *ip = NULL;
 
 	if (qp->ibqp.srq) {
 		srq = ibsrq_to_rvtsrq(qp->ibqp.srq);
 		handler = srq->ibsrq.event_handler;
 		rq = &srq->rq;
+		ip = srq->ip;
 	} else {
 		srq = NULL;
 		handler = NULL;
 		rq = &qp->r_rq;
+		ip = qp->ip;
 	}
 
 	spin_lock_irqsave(&rq->lock, flags);
@@ -2265,17 +2325,24 @@ int rvt_get_rwqe(struct rvt_qp *qp, bool wr_id_only)
 		ret = 0;
 		goto unlock;
 	}
+	if (ip) {
+		wq = rq->wq;
+		tail = RDMA_READ_UAPI_ATOMIC(wq->tail);
+	} else {
+		kwq = rq->kwq;
+		tail = kwq->tail;
+	}
 
-	wq = rq->wq;
-	tail = wq->tail;
 	/* Validate tail before using it since it is user writable. */
 	if (tail >= rq->size)
 		tail = 0;
-	if (unlikely(tail == wq->head)) {
+
+	head = get_rvt_head(rq, ip);
+	if (unlikely(tail == head)) {
 		ret = 0;
 		goto unlock;
 	}
-	/* Make sure entry is read after head index is read. */
+	/* Make sure entry is read after the count is read. */
 	smp_rmb();
 	wqe = rvt_get_rwqe_ptr(rq, tail);
 	/*
@@ -2285,7 +2352,10 @@ int rvt_get_rwqe(struct rvt_qp *qp, bool wr_id_only)
 	 */
 	if (++tail >= rq->size)
 		tail = 0;
-	wq->tail = tail;
+	if (ip)
+		RDMA_WRITE_UAPI_ATOMIC(wq->tail, tail);
+	else
+		kwq->tail = tail;
 	if (!wr_id_only && !init_sge(qp, wqe)) {
 		ret = -1;
 		goto unlock;
@@ -2301,7 +2371,7 @@ int rvt_get_rwqe(struct rvt_qp *qp, bool wr_id_only)
 		 * Validate head pointer value and compute
 		 * the number of remaining WQEs.
 		 */
-		n = wq->head;
+		n = get_rvt_head(rq, ip);
 		if (n >= rq->size)
 			n = 0;
 		if (n < tail)
diff --git a/drivers/infiniband/sw/rdmavt/qp.h b/drivers/infiniband/sw/rdmavt/qp.h
index 6db1619..2cdba12 100644
--- a/drivers/infiniband/sw/rdmavt/qp.h
+++ b/drivers/infiniband/sw/rdmavt/qp.h
@@ -68,4 +68,6 @@ int rvt_post_srq_recv(struct ib_srq *ibsrq, const struct ib_recv_wr *wr,
 		      const struct ib_recv_wr **bad_wr);
 int rvt_wss_init(struct rvt_dev_info *rdi);
 void rvt_wss_exit(struct rvt_dev_info *rdi);
+int rvt_alloc_rq(struct rvt_rq *rq, u32 size, int node,
+		 struct ib_udata *udata);
 #endif          /* DEF_RVTQP_H */
diff --git a/drivers/infiniband/sw/rdmavt/rc.c b/drivers/infiniband/sw/rdmavt/rc.c
index 09f0cf5..44cc7ee 100644
--- a/drivers/infiniband/sw/rdmavt/rc.c
+++ b/drivers/infiniband/sw/rdmavt/rc.c
@@ -104,15 +104,19 @@ __be32 rvt_compute_aeth(struct rvt_qp *qp)
 	} else {
 		u32 min, max, x;
 		u32 credits;
-		struct rvt_rwq *wq = qp->r_rq.wq;
 		u32 head;
 		u32 tail;
 
 		/* sanity check pointers before trusting them */
-		head = wq->head;
+		if (qp->ip) {
+			head = RDMA_READ_UAPI_ATOMIC(qp->r_rq.wq->head);
+			tail = RDMA_READ_UAPI_ATOMIC(qp->r_rq.wq->tail);
+		} else {
+			head = READ_ONCE(qp->r_rq.kwq->head);
+			tail = READ_ONCE(qp->r_rq.kwq->tail);
+		}
 		if (head >= qp->r_rq.size)
 			head = 0;
-		tail = wq->tail;
 		if (tail >= qp->r_rq.size)
 			tail = 0;
 		/*
diff --git a/drivers/infiniband/sw/rdmavt/srq.c b/drivers/infiniband/sw/rdmavt/srq.c
index 8d6b3e7..d306f65 100644
--- a/drivers/infiniband/sw/rdmavt/srq.c
+++ b/drivers/infiniband/sw/rdmavt/srq.c
@@ -52,7 +52,7 @@
 
 #include "srq.h"
 #include "vt.h"
-
+#include "qp.h"
 /**
  * rvt_driver_srq_init - init srq resources on a per driver basis
  * @rdi: rvt dev structure
@@ -97,11 +97,8 @@ int rvt_create_srq(struct ib_srq *ibsrq, struct ib_srq_init_attr *srq_init_attr,
 	srq->rq.max_sge = srq_init_attr->attr.max_sge;
 	sz = sizeof(struct ib_sge) * srq->rq.max_sge +
 		sizeof(struct rvt_rwqe);
-	srq->rq.wq = udata ?
-		vmalloc_user(sizeof(struct rvt_rwq) + srq->rq.size * sz) :
-		vzalloc_node(sizeof(struct rvt_rwq) + srq->rq.size * sz,
-			     dev->dparms.node);
-	if (!srq->rq.wq) {
+	if (rvt_alloc_rq(&srq->rq, srq->rq.size * sz,
+			 dev->dparms.node, udata)) {
 		ret = -ENOMEM;
 		goto bail_srq;
 	}
@@ -152,7 +149,7 @@ int rvt_create_srq(struct ib_srq *ibsrq, struct ib_srq_init_attr *srq_init_attr,
 bail_ip:
 	kfree(srq->ip);
 bail_wq:
-	vfree(srq->rq.wq);
+	rvt_free_rq(&srq->rq);
 bail_srq:
 	return ret;
 }
@@ -172,11 +169,12 @@ int rvt_modify_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr,
 {
 	struct rvt_srq *srq = ibsrq_to_rvtsrq(ibsrq);
 	struct rvt_dev_info *dev = ib_to_rvt(ibsrq->device);
-	struct rvt_rwq *wq;
+	struct rvt_rq tmp_rq = {};
 	int ret = 0;
 
 	if (attr_mask & IB_SRQ_MAX_WR) {
-		struct rvt_rwq *owq;
+		struct rvt_krwq *okwq = NULL;
+		struct rvt_rwq *owq = NULL;
 		struct rvt_rwqe *p;
 		u32 sz, size, n, head, tail;
 
@@ -185,17 +183,12 @@ int rvt_modify_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr,
 		    ((attr_mask & IB_SRQ_LIMIT) ?
 		     attr->srq_limit : srq->limit) > attr->max_wr)
 			return -EINVAL;
-
 		sz = sizeof(struct rvt_rwqe) +
 			srq->rq.max_sge * sizeof(struct ib_sge);
 		size = attr->max_wr + 1;
-		wq = udata ?
-			vmalloc_user(sizeof(struct rvt_rwq) + size * sz) :
-			vzalloc_node(sizeof(struct rvt_rwq) + size * sz,
-				     dev->dparms.node);
-		if (!wq)
+		if (rvt_alloc_rq(&tmp_rq, size * sz, dev->dparms.node,
+				 udata))
 			return -ENOMEM;
-
 		/* Check that we can write the offset to mmap. */
 		if (udata && udata->inlen >= sizeof(__u64)) {
 			__u64 offset_addr;
@@ -218,9 +211,15 @@ int rvt_modify_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr,
 		 * validate head and tail pointer values and compute
 		 * the number of remaining WQEs.
 		 */
-		owq = srq->rq.wq;
-		head = owq->head;
-		tail = owq->tail;
+		if (udata) {
+			owq = srq->rq.wq;
+			head = RDMA_READ_UAPI_ATOMIC(owq->head);
+			tail = RDMA_READ_UAPI_ATOMIC(owq->tail);
+		} else {
+			okwq = srq->rq.kwq;
+			head = okwq->head;
+			tail = okwq->tail;
+		}
 		if (head >= srq->rq.size || tail >= srq->rq.size) {
 			ret = -EINVAL;
 			goto bail_unlock;
@@ -235,7 +234,7 @@ int rvt_modify_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr,
 			goto bail_unlock;
 		}
 		n = 0;
-		p = wq->wq;
+		p = tmp_rq.kwq->curr_wq;
 		while (tail != head) {
 			struct rvt_rwqe *wqe;
 			int i;
@@ -250,22 +249,29 @@ int rvt_modify_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr,
 			if (++tail >= srq->rq.size)
 				tail = 0;
 		}
-		srq->rq.wq = wq;
+		srq->rq.kwq = tmp_rq.kwq;
+		if (udata) {
+			srq->rq.wq = tmp_rq.wq;
+			RDMA_WRITE_UAPI_ATOMIC(tmp_rq.wq->head, n);
+			RDMA_WRITE_UAPI_ATOMIC(tmp_rq.wq->tail, 0);
+		} else {
+			tmp_rq.kwq->head = n;
+			tmp_rq.kwq->tail = 0;
+		}
 		srq->rq.size = size;
-		wq->head = n;
-		wq->tail = 0;
 		if (attr_mask & IB_SRQ_LIMIT)
 			srq->limit = attr->srq_limit;
 		spin_unlock_irq(&srq->rq.lock);
 
 		vfree(owq);
+		kvfree(okwq);
 
 		if (srq->ip) {
 			struct rvt_mmap_info *ip = srq->ip;
 			struct rvt_dev_info *dev = ib_to_rvt(srq->ibsrq.device);
 			u32 s = sizeof(struct rvt_rwq) + size * sz;
 
-			rvt_update_mmap_info(dev, ip, s, wq);
+			rvt_update_mmap_info(dev, ip, s, tmp_rq.wq);
 
 			/*
 			 * Return the offset to mmap.
@@ -301,7 +307,7 @@ int rvt_modify_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr,
 bail_unlock:
 	spin_unlock_irq(&srq->rq.lock);
 bail_free:
-	vfree(wq);
+	rvt_free_rq(&tmp_rq);
 	return ret;
 }
 
@@ -336,6 +342,5 @@ void rvt_destroy_srq(struct ib_srq *ibsrq, struct ib_udata *udata)
 	spin_unlock(&dev->n_srqs_lock);
 	if (srq->ip)
 		kref_put(&srq->ip->ref, rvt_release_mmap_info);
-	else
-		vfree(srq->rq.wq);
+	kvfree(srq->rq.kwq);
 }
diff --git a/include/rdma/rdmavt_qp.h b/include/rdma/rdmavt_qp.h
index 7fcd687..ee55fd0 100644
--- a/include/rdma/rdmavt_qp.h
+++ b/include/rdma/rdmavt_qp.h
@@ -52,6 +52,7 @@
 #include <rdma/ib_pack.h>
 #include <rdma/ib_verbs.h>
 #include <rdma/rdmavt_cq.h>
+#include <rdma/rvt-abi.h>
 /*
  * Atomic bit definitions for r_aflags.
  */
@@ -177,33 +178,27 @@ struct rvt_swqe {
 	struct rvt_sge sg_list[0];
 };
 
-/*
- * Receive work request queue entry.
- * The size of the sg_list is determined when the QP (or SRQ) is created
- * and stored in qp->r_rq.max_sge (or srq->rq.max_sge).
+/**
+ * struct rvt_krwq - kernel struct receive work request
+ * @head: index of next entry to fill
+ * @tail: index of next entry to pull
+ * @count: count is aproximate of total receive enteries posted
+ * @rvt_rwqe: struct of receive work request queue entry
+ *
+ * This structure is used to contain the head pointer,
+ * tail pointer and receive work queue entries for kernel
+ * mode user.
  */
-struct rvt_rwqe {
-	u64 wr_id;
-	u8 num_sge;
-	struct ib_sge sg_list[0];
-};
-
-/*
- * This structure is used to contain the head pointer, tail pointer,
- * and receive work queue entries as a single memory allocation so
- * it can be mmap'ed into user space.
- * Note that the wq array elements are variable size so you can't
- * just index into the array to get the N'th element;
- * use get_rwqe_ptr() instead.
- */
-struct rvt_rwq {
+struct rvt_krwq {
 	u32 head;               /* new work requests posted to the head */
 	u32 tail;               /* receives pull requests from here. */
-	struct rvt_rwqe wq[0];
+	struct rvt_rwqe *curr_wq;
+	struct rvt_rwqe wq[];
 };
 
 struct rvt_rq {
 	struct rvt_rwq *wq;
+	struct rvt_krwq *kwq;
 	u32 size;               /* size of RWQE array */
 	u8 max_sge;
 	/* protect changes in this struct */
@@ -472,7 +467,7 @@ static inline struct rvt_swqe *rvt_get_swqe_ptr(struct rvt_qp *qp,
 static inline struct rvt_rwqe *rvt_get_rwqe_ptr(struct rvt_rq *rq, unsigned n)
 {
 	return (struct rvt_rwqe *)
-		((char *)rq->wq->wq +
+		((char *)rq->kwq->curr_wq +
 		 (sizeof(struct rvt_rwqe) +
 		  rq->max_sge * sizeof(struct ib_sge)) * n);
 }
@@ -852,6 +847,21 @@ static inline u32 ib_cq_head(struct ib_cq *send_cq)
 	       ibcq_to_rvtcq(send_cq)->kqueue->head;
 }
 
+/**
+ * rvt_free_rq - free memory allocated for rvt_rq struct
+ * @rvt_rq: request queue data structure
+ *
+ * This function should only be called if the rvt_mmap_info()
+ * has not succeeded.
+ */
+static inline void rvt_free_rq(struct rvt_rq *rq)
+{
+	kvfree(rq->kwq);
+	rq->kwq = NULL;
+	vfree(rq->wq);
+	rq->wq = NULL;
+}
+
 struct rvt_qp_iter *rvt_qp_iter_init(struct rvt_dev_info *rdi,
 				     u64 v,
 				     void (*cb)(struct rvt_qp *qp, u64 v));
diff --git a/include/uapi/rdma/rvt-abi.h b/include/uapi/rdma/rvt-abi.h
index 8e5f7e0..d2e35d2 100644
--- a/include/uapi/rdma/rvt-abi.h
+++ b/include/uapi/rdma/rvt-abi.h
@@ -10,6 +10,7 @@
 
 #include <linux/types.h>
 #include <rdma/ib_user_verbs.h>
+#include <rdma/ib_verbs.h>
 #ifndef RDMA_ATOMIC_UAPI
 #define RDMA_ATOMIC_UAPI(_type, _name) struct{ _type val; } _name
 #endif
@@ -29,4 +30,32 @@ struct rvt_cq_wc {
 	struct ib_uverbs_wc uqueue[];
 };
 
+/*
+ * Receive work request queue entry.
+ * The size of the sg_list is determined when the QP (or SRQ) is created
+ * and stored in qp->r_rq.max_sge (or srq->rq.max_sge).
+ */
+struct rvt_rwqe {
+	__u64 wr_id;
+	__u8 num_sge;
+	__u8 padding[7];
+	struct ib_sge sg_list[];
+};
+
+/*
+ * This structure is used to contain the head pointer, tail pointer,
+ * and receive work queue entries as a single memory allocation so
+ * it can be mmap'ed into user space.
+ * Note that the wq array elements are variable size so you can't
+ * just index into the array to get the N'th element;
+ * use get_rwqe_ptr() for user space and rvt_get_rwqe_ptr()
+ * for kernel space.
+ */
+struct rvt_rwq {
+	/* new work requests posted to the head */
+	RDMA_ATOMIC_UAPI(__u32, head);
+	/* receives pull requests from here. */
+	RDMA_ATOMIC_UAPI(__u32, tail);
+	struct rvt_rwqe wq[];
+};
 #endif /* RVT_ABI_USER_H */

