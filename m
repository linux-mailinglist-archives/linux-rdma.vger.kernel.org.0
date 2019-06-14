Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F407463FF
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Jun 2019 18:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbfFNQZv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 Jun 2019 12:25:51 -0400
Received: from mga04.intel.com ([192.55.52.120]:18753 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbfFNQZv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 14 Jun 2019 12:25:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2019 09:25:50 -0700
X-ExtLoop1: 1
Received: from sedona.ch.intel.com ([10.2.136.157])
  by fmsmga004.fm.intel.com with ESMTP; 14 Jun 2019 09:25:50 -0700
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id x5EGPnJY060583;
        Fri, 14 Jun 2019 09:25:49 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id x5EGPmko044704;
        Fri, 14 Jun 2019 12:25:48 -0400
Subject: [PATCH for-next v4 3/3] IB/rdmavt: Fracture single lock used for
 posting and processing RWQEs
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     Harish Chegondi <harish.chegondi@intel.com>,
        linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Kamenee Arumugam <kamenee.arumugam@intel.com>
Date:   Fri, 14 Jun 2019 12:25:48 -0400
Message-ID: <20190614162547.44620.73336.stgit@awfm-01.aw.intel.com>
In-Reply-To: <20190614162435.44620.72298.stgit@awfm-01.aw.intel.com>
References: <20190614162435.44620.72298.stgit@awfm-01.aw.intel.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Kamenee Arumugam <kamenee.arumugam@intel.com>

Usage of single lock prevents fetching posted and processing receive
work queue entries from progressing simultaneously and impacts overall
performance.

Fracture the single lock used for posting and processing Receive Work
Queue Entries (RWQEs) to allow the circular buffer to be filled and
emptied at the same time. Two new spinlocks - one for the producers
and one for the consumers used for posting and processing RWQEs
simultaneously and the two indices are define on two different cache
lines. The threshold count is used to avoid reading other index
in different cache line every time.

Signed-off-by: Harish Chegondi <harish.chegondi@intel.com>
Signed-off-by: Kamenee Arumugam <kamenee.arumugam@intel.com>
Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
---
Changes from v2
Separate out changes related to moving receive work queue into uapi
directory from locking mechanism implementation

Changes from v1
Changed READ_ONCE/WRITE_ONCE macro to use smp_load_acquire and
smp_store_release.
---
 drivers/infiniband/sw/rdmavt/qp.c  |   97 +++++++++++++++++++++++-------------
 drivers/infiniband/sw/rdmavt/rc.c  |   43 +++++++++-------
 drivers/infiniband/sw/rdmavt/srq.c |   10 ++--
 include/rdma/rdmavt_qp.h           |    7 +++
 4 files changed, 97 insertions(+), 60 deletions(-)

diff --git a/drivers/infiniband/sw/rdmavt/qp.c b/drivers/infiniband/sw/rdmavt/qp.c
index 1cdfb5a..c9b4bd4 100644
--- a/drivers/infiniband/sw/rdmavt/qp.c
+++ b/drivers/infiniband/sw/rdmavt/qp.c
@@ -58,6 +58,8 @@
 #include "vt.h"
 #include "trace.h"
 
+#define RVT_RWQ_COUNT_THRESHOLD 16
+
 static void rvt_rc_timeout(struct timer_list *t);
 
 /*
@@ -834,7 +836,8 @@ int rvt_alloc_rq(struct rvt_rq *rq, u32 size, int node,
 		rq->kwq->curr_wq = rq->kwq->wq;
 	}
 
-	spin_lock_init(&rq->lock);
+	spin_lock_init(&rq->kwq->p_lock);
+	spin_lock_init(&rq->kwq->c_lock);
 	return 0;
 bail:
 	rvt_free_rq(rq);
@@ -891,6 +894,8 @@ static void rvt_init_qp(struct rvt_dev_info *rdi, struct rvt_qp *qp,
 	qp->s_tail_ack_queue = 0;
 	qp->s_acked_ack_queue = 0;
 	qp->s_num_rd_atomic = 0;
+	if (qp->r_rq.kwq)
+		qp->r_rq.kwq->count = qp->r_rq.size;
 	qp->r_sge.num_sge = 0;
 	atomic_set(&qp->s_reserved_used, 0);
 }
@@ -1096,7 +1101,6 @@ struct ib_qp *rvt_create_qp(struct ib_pd *ibpd,
 		spin_lock_init(&qp->r_lock);
 		spin_lock_init(&qp->s_hlock);
 		spin_lock_init(&qp->s_lock);
-		spin_lock_init(&qp->r_rq.lock);
 		atomic_set(&qp->refcount, 0);
 		atomic_set(&qp->local_ops_pending, 0);
 		init_waitqueue_head(&qp->wait);
@@ -1304,7 +1308,7 @@ int rvt_error_qp(struct rvt_qp *qp, enum ib_wc_status err)
 		struct rvt_rwq *wq = NULL;
 		struct rvt_krwq *kwq = NULL;
 
-		spin_lock(&qp->r_rq.lock);
+		spin_lock(&qp->r_rq.kwq->c_lock);
 		/* qp->ip used to validate if there is a  user buffer mmaped */
 		if (qp->ip) {
 			wq = qp->r_rq.wq;
@@ -1330,7 +1334,7 @@ int rvt_error_qp(struct rvt_qp *qp, enum ib_wc_status err)
 			RDMA_WRITE_UAPI_ATOMIC(wq->tail, tail);
 		else
 			kwq->tail = tail;
-		spin_unlock(&qp->r_rq.lock);
+		spin_unlock(&qp->r_rq.kwq->c_lock);
 	} else if (qp->ibqp.event_handler) {
 		ret = 1;
 	}
@@ -1779,12 +1783,12 @@ int rvt_post_recv(struct ib_qp *ibqp, const struct ib_recv_wr *wr,
 			return -EINVAL;
 		}
 
-		spin_lock_irqsave(&qp->r_rq.lock, flags);
+		spin_lock_irqsave(&qp->r_rq.kwq->p_lock, flags);
 		next = wq->head + 1;
 		if (next >= qp->r_rq.size)
 			next = 0;
 		if (next == READ_ONCE(wq->tail)) {
-			spin_unlock_irqrestore(&qp->r_rq.lock, flags);
+			spin_unlock_irqrestore(&qp->r_rq.kwq->p_lock, flags);
 			*bad_wr = wr;
 			return -ENOMEM;
 		}
@@ -1809,7 +1813,7 @@ int rvt_post_recv(struct ib_qp *ibqp, const struct ib_recv_wr *wr,
 			 */
 			smp_store_release(&wq->head, next);
 		}
-		spin_unlock_irqrestore(&qp->r_rq.lock, flags);
+		spin_unlock_irqrestore(&qp->r_rq.kwq->p_lock, flags);
 	}
 	return 0;
 }
@@ -2190,13 +2194,13 @@ int rvt_post_srq_recv(struct ib_srq *ibsrq, const struct ib_recv_wr *wr,
 			return -EINVAL;
 		}
 
-		spin_lock_irqsave(&srq->rq.lock, flags);
+		spin_lock_irqsave(&srq->rq.kwq->p_lock, flags);
 		wq = srq->rq.kwq;
 		next = wq->head + 1;
 		if (next >= srq->rq.size)
 			next = 0;
 		if (next == READ_ONCE(wq->tail)) {
-			spin_unlock_irqrestore(&srq->rq.lock, flags);
+			spin_unlock_irqrestore(&srq->rq.kwq->p_lock, flags);
 			*bad_wr = wr;
 			return -ENOMEM;
 		}
@@ -2208,7 +2212,7 @@ int rvt_post_srq_recv(struct ib_srq *ibsrq, const struct ib_recv_wr *wr,
 			wqe->sg_list[i] = wr->sg_list[i];
 		/* Make sure queue entry is written before the head index. */
 		smp_store_release(&wq->head, next);
-		spin_unlock_irqrestore(&srq->rq.lock, flags);
+		spin_unlock_irqrestore(&srq->rq.kwq->p_lock, flags);
 	}
 	return 0;
 }
@@ -2265,6 +2269,31 @@ static int init_sge(struct rvt_qp *qp, struct rvt_rwqe *wqe)
 }
 
 /**
+ * get_count - count numbers of request work queue entries
+ * in circular buffer
+ * @rq: data structure for request queue entry
+ * @tail: tail indices of the circular buffer
+ * @head: head indices of the circular buffer
+ *
+ * Return - total number of entries in the circular buffer
+ */
+static u32 get_count(struct rvt_rq *rq, u32 tail, u32 head)
+{
+	u32 count;
+
+	count = head;
+
+	if (count >= rq->size)
+		count = 0;
+	if (count < tail)
+		count += rq->size - tail;
+	else
+		count -= tail;
+
+	return count;
+}
+
+/**
  * get_rvt_head - get head indices of the circular buffer
  * @rq: data structure for request queue entry
  * @ip: the QP
@@ -2297,7 +2326,7 @@ int rvt_get_rwqe(struct rvt_qp *qp, bool wr_id_only)
 {
 	unsigned long flags;
 	struct rvt_rq *rq;
-	struct rvt_krwq *kwq;
+	struct rvt_krwq *kwq = NULL;
 	struct rvt_rwq *wq;
 	struct rvt_srq *srq;
 	struct rvt_rwqe *wqe;
@@ -2319,16 +2348,16 @@ int rvt_get_rwqe(struct rvt_qp *qp, bool wr_id_only)
 		ip = qp->ip;
 	}
 
-	spin_lock_irqsave(&rq->lock, flags);
+	spin_lock_irqsave(&rq->kwq->c_lock, flags);
 	if (!(ib_rvt_state_ops[qp->state] & RVT_PROCESS_RECV_OK)) {
 		ret = 0;
 		goto unlock;
 	}
+	kwq = rq->kwq;
 	if (ip) {
 		wq = rq->wq;
 		tail = RDMA_READ_UAPI_ATOMIC(wq->tail);
 	} else {
-		kwq = rq->kwq;
 		tail = kwq->tail;
 	}
 
@@ -2336,8 +2365,11 @@ int rvt_get_rwqe(struct rvt_qp *qp, bool wr_id_only)
 	if (tail >= rq->size)
 		tail = 0;
 
-	head = get_rvt_head(rq, ip);
-	if (unlikely(tail == head)) {
+	if (kwq->count < RVT_RWQ_COUNT_THRESHOLD) {
+		head = get_rvt_head(rq, ip);
+		kwq->count = get_count(rq, tail, head);
+	}
+	if (unlikely(kwq->count == 0)) {
 		ret = 0;
 		goto unlock;
 	}
@@ -2361,36 +2393,31 @@ int rvt_get_rwqe(struct rvt_qp *qp, bool wr_id_only)
 	}
 	qp->r_wr_id = wqe->wr_id;
 
+	kwq->count--;
 	ret = 1;
 	set_bit(RVT_R_WRID_VALID, &qp->r_aflags);
 	if (handler) {
-		u32 n;
-
 		/*
 		 * Validate head pointer value and compute
 		 * the number of remaining WQEs.
 		 */
-		n = get_rvt_head(rq, ip);
-		if (n >= rq->size)
-			n = 0;
-		if (n < tail)
-			n += rq->size - tail;
-		else
-			n -= tail;
-		if (n < srq->limit) {
-			struct ib_event ev;
-
-			srq->limit = 0;
-			spin_unlock_irqrestore(&rq->lock, flags);
-			ev.device = qp->ibqp.device;
-			ev.element.srq = qp->ibqp.srq;
-			ev.event = IB_EVENT_SRQ_LIMIT_REACHED;
-			handler(&ev, srq->ibsrq.srq_context);
-			goto bail;
+		if (kwq->count < srq->limit) {
+			kwq->count = get_count(rq, tail, get_rvt_head(rq, ip));
+			if (kwq->count < srq->limit) {
+				struct ib_event ev;
+
+				srq->limit = 0;
+				spin_unlock_irqrestore(&rq->kwq->c_lock, flags);
+				ev.device = qp->ibqp.device;
+				ev.element.srq = qp->ibqp.srq;
+				ev.event = IB_EVENT_SRQ_LIMIT_REACHED;
+				handler(&ev, srq->ibsrq.srq_context);
+				goto bail;
+			}
 		}
 	}
 unlock:
-	spin_unlock_irqrestore(&rq->lock, flags);
+	spin_unlock_irqrestore(&rq->kwq->c_lock, flags);
 bail:
 	return ret;
 }
diff --git a/drivers/infiniband/sw/rdmavt/rc.c b/drivers/infiniband/sw/rdmavt/rc.c
index 44cc7ee..890d7b7 100644
--- a/drivers/infiniband/sw/rdmavt/rc.c
+++ b/drivers/infiniband/sw/rdmavt/rc.c
@@ -107,27 +107,30 @@ __be32 rvt_compute_aeth(struct rvt_qp *qp)
 		u32 head;
 		u32 tail;
 
-		/* sanity check pointers before trusting them */
-		if (qp->ip) {
-			head = RDMA_READ_UAPI_ATOMIC(qp->r_rq.wq->head);
-			tail = RDMA_READ_UAPI_ATOMIC(qp->r_rq.wq->tail);
-		} else {
-			head = READ_ONCE(qp->r_rq.kwq->head);
-			tail = READ_ONCE(qp->r_rq.kwq->tail);
+		credits = READ_ONCE(qp->r_rq.kwq->count);
+		if (credits == 0) {
+			/* sanity check pointers before trusting them */
+			if (qp->ip) {
+				head = RDMA_READ_UAPI_ATOMIC(qp->r_rq.wq->head);
+				tail = RDMA_READ_UAPI_ATOMIC(qp->r_rq.wq->tail);
+			} else {
+				head = READ_ONCE(qp->r_rq.kwq->head);
+				tail = READ_ONCE(qp->r_rq.kwq->tail);
+			}
+			if (head >= qp->r_rq.size)
+				head = 0;
+			if (tail >= qp->r_rq.size)
+				tail = 0;
+			/*
+			 * Compute the number of credits available (RWQEs).
+			 * There is a small chance that the pair of reads are
+			 * not atomic, which is OK, since the fuzziness is
+			 * resolved as further ACKs go out.
+			 */
+			credits = head - tail;
+			if ((int)credits < 0)
+				credits += qp->r_rq.size;
 		}
-		if (head >= qp->r_rq.size)
-			head = 0;
-		if (tail >= qp->r_rq.size)
-			tail = 0;
-		/*
-		 * Compute the number of credits available (RWQEs).
-		 * There is a small chance that the pair of reads are
-		 * not atomic, which is OK, since the fuzziness is
-		 * resolved as further ACKs go out.
-		 */
-		credits = head - tail;
-		if ((int)credits < 0)
-			credits += qp->r_rq.size;
 		/*
 		 * Binary search the credit table to find the code to
 		 * use.
diff --git a/drivers/infiniband/sw/rdmavt/srq.c b/drivers/infiniband/sw/rdmavt/srq.c
index d306f65..24fef02 100644
--- a/drivers/infiniband/sw/rdmavt/srq.c
+++ b/drivers/infiniband/sw/rdmavt/srq.c
@@ -206,7 +206,7 @@ int rvt_modify_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr,
 				goto bail_free;
 		}
 
-		spin_lock_irq(&srq->rq.lock);
+		spin_lock_irq(&srq->rq.kwq->c_lock);
 		/*
 		 * validate head and tail pointer values and compute
 		 * the number of remaining WQEs.
@@ -261,7 +261,7 @@ int rvt_modify_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr,
 		srq->rq.size = size;
 		if (attr_mask & IB_SRQ_LIMIT)
 			srq->limit = attr->srq_limit;
-		spin_unlock_irq(&srq->rq.lock);
+		spin_unlock_irq(&srq->rq.kwq->c_lock);
 
 		vfree(owq);
 		kvfree(okwq);
@@ -295,17 +295,17 @@ int rvt_modify_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr,
 			spin_unlock_irq(&dev->pending_lock);
 		}
 	} else if (attr_mask & IB_SRQ_LIMIT) {
-		spin_lock_irq(&srq->rq.lock);
+		spin_lock_irq(&srq->rq.kwq->c_lock);
 		if (attr->srq_limit >= srq->rq.size)
 			ret = -EINVAL;
 		else
 			srq->limit = attr->srq_limit;
-		spin_unlock_irq(&srq->rq.lock);
+		spin_unlock_irq(&srq->rq.kwq->c_lock);
 	}
 	return ret;
 
 bail_unlock:
-	spin_unlock_irq(&srq->rq.lock);
+	spin_unlock_irq(&srq->rq.kwq->c_lock);
 bail_free:
 	rvt_free_rq(&tmp_rq);
 	return ret;
diff --git a/include/rdma/rdmavt_qp.h b/include/rdma/rdmavt_qp.h
index ee55fd0..de5915b 100644
--- a/include/rdma/rdmavt_qp.h
+++ b/include/rdma/rdmavt_qp.h
@@ -180,7 +180,9 @@ struct rvt_swqe {
 
 /**
  * struct rvt_krwq - kernel struct receive work request
+ * @p_lock: lock to protect producer of the kernel buffer
  * @head: index of next entry to fill
+ * @c_lock:lock to protect consumer of the kernel buffer
  * @tail: index of next entry to pull
  * @count: count is aproximate of total receive enteries posted
  * @rvt_rwqe: struct of receive work request queue entry
@@ -190,8 +192,13 @@ struct rvt_swqe {
  * mode user.
  */
 struct rvt_krwq {
+	spinlock_t p_lock;	/* protect producer */
 	u32 head;               /* new work requests posted to the head */
+
+	/* protect consumer */
+	spinlock_t c_lock ____cacheline_aligned_in_smp;
 	u32 tail;               /* receives pull requests from here. */
+	u32 count;		/* approx count of receive entries posted */
 	struct rvt_rwqe *curr_wq;
 	struct rvt_rwqe wq[];
 };

