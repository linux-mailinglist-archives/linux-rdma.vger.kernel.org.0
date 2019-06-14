Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 556C1463FB
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Jun 2019 18:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725801AbfFNQZi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 Jun 2019 12:25:38 -0400
Received: from mga04.intel.com ([192.55.52.120]:18718 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbfFNQZi (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 14 Jun 2019 12:25:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2019 09:25:37 -0700
X-ExtLoop1: 1
Received: from sedona.ch.intel.com ([10.2.136.157])
  by fmsmga004.fm.intel.com with ESMTP; 14 Jun 2019 09:25:37 -0700
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id x5EGPawg060538;
        Fri, 14 Jun 2019 09:25:36 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id x5EGPZAV044682;
        Fri, 14 Jun 2019 12:25:35 -0400
Subject: [PATCH for-next v4 1/3] IB/hfi1: Move rvt_cq_wc struct into uapi
 directory
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Kamenee Arumugam <kamenee.arumugam@intel.com>
Date:   Fri, 14 Jun 2019 12:25:35 -0400
Message-ID: <20190614162534.44620.52872.stgit@awfm-01.aw.intel.com>
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

The rvt_cq_wc struct elements are shared between rdmavt
and the providers but not in uapi directory.
As per the comment in
https://marc.info/?l=linux-rdma&m=152296522708522&w=2
The hfi1 driver and the rdma core driver are not using
shared structures in the uapi directory.

In that case, move rvt_cq_wc struct into the rvt-abi.h
header file and create a rvt_k_cq_w for the kernel
completion queue.

Signed-off-by: Kamenee Arumugam <kamenee.arumugam@intel.com>
Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>

---
Changes from v3
Changed zero length array to flexible array defined in rvt-abi.h
header file.
Moved the smp_load_acquire/ smp_store_release macro definition to
rdmavt_cq.h header file.

Changes from v2 (https://patchwork.kernel.org/patch/10714369/)
Changed READ_ONCE/WRITE_ONCE macro to use smp_load_acquire and
smp_store_release.

Changes from v1
Introduce READ_ONCE/WRITE_ONCE macro for reading/writing head and tail
of the circular buffer.
---
 drivers/infiniband/hw/hfi1/qp.c   |    4 -
 drivers/infiniband/sw/rdmavt/cq.c |  191 ++++++++++++++++++++++++-------------
 include/rdma/rdmavt_cq.h          |   22 +++-
 include/rdma/rdmavt_qp.h          |   32 ++++++
 include/uapi/rdma/rvt-abi.h       |   32 ++++++
 5 files changed, 204 insertions(+), 77 deletions(-)
 create mode 100644 include/uapi/rdma/rvt-abi.h

diff --git a/drivers/infiniband/hw/hfi1/qp.c b/drivers/infiniband/hw/hfi1/qp.c
index 4e0e9fc..41261e7 100644
--- a/drivers/infiniband/hw/hfi1/qp.c
+++ b/drivers/infiniband/hw/hfi1/qp.c
@@ -702,8 +702,8 @@ void qp_iter_print(struct seq_file *s, struct rvt_qp_iter *iter)
 		   sde ? sde->this_idx : 0,
 		   send_context,
 		   send_context ? send_context->sw_index : 0,
-		   ibcq_to_rvtcq(qp->ibqp.send_cq)->queue->head,
-		   ibcq_to_rvtcq(qp->ibqp.send_cq)->queue->tail,
+		   ib_cq_head(qp->ibqp.send_cq),
+		   ib_cq_tail(qp->ibqp.send_cq),
 		   qp->pid,
 		   qp->s_state,
 		   qp->s_ack_state,
diff --git a/drivers/infiniband/sw/rdmavt/cq.c b/drivers/infiniband/sw/rdmavt/cq.c
index a06e6da..9c2afd8 100644
--- a/drivers/infiniband/sw/rdmavt/cq.c
+++ b/drivers/infiniband/sw/rdmavt/cq.c
@@ -63,19 +63,33 @@
  */
 void rvt_cq_enter(struct rvt_cq *cq, struct ib_wc *entry, bool solicited)
 {
-	struct rvt_cq_wc *wc;
+	struct ib_uverbs_wc *uqueue = NULL;
+	struct ib_wc *kqueue = NULL;
+	struct rvt_cq_wc *u_wc = NULL;
+	struct rvt_k_cq_wc *k_wc = NULL;
 	unsigned long flags;
 	u32 head;
 	u32 next;
+	u32 tail;
 
 	spin_lock_irqsave(&cq->lock, flags);
 
+	if (cq->ip) {
+		u_wc = cq->queue;
+		uqueue = &u_wc->uqueue[0];
+		head = RDMA_READ_UAPI_ATOMIC(u_wc->head);
+		tail = RDMA_READ_UAPI_ATOMIC(u_wc->tail);
+	} else {
+		k_wc = cq->kqueue;
+		kqueue = &k_wc->kqueue[0];
+		head = k_wc->head;
+		tail = k_wc->tail;
+	}
+
 	/*
-	 * Note that the head pointer might be writable by user processes.
-	 * Take care to verify it is a sane value.
+	 * Note that the head pointer might be writable by
+	 * user processes.Take care to verify it is a sane value.
 	 */
-	wc = cq->queue;
-	head = wc->head;
 	if (head >= (unsigned)cq->ibcq.cqe) {
 		head = cq->ibcq.cqe;
 		next = 0;
@@ -83,7 +97,7 @@ void rvt_cq_enter(struct rvt_cq *cq, struct ib_wc *entry, bool solicited)
 		next = head + 1;
 	}
 
-	if (unlikely(next == wc->tail)) {
+	if (unlikely(next == tail)) {
 		spin_unlock_irqrestore(&cq->lock, flags);
 		if (cq->ibcq.event_handler) {
 			struct ib_event ev;
@@ -96,27 +110,27 @@ void rvt_cq_enter(struct rvt_cq *cq, struct ib_wc *entry, bool solicited)
 		return;
 	}
 	trace_rvt_cq_enter(cq, entry, head);
-	if (cq->ip) {
-		wc->uqueue[head].wr_id = entry->wr_id;
-		wc->uqueue[head].status = entry->status;
-		wc->uqueue[head].opcode = entry->opcode;
-		wc->uqueue[head].vendor_err = entry->vendor_err;
-		wc->uqueue[head].byte_len = entry->byte_len;
-		wc->uqueue[head].ex.imm_data = entry->ex.imm_data;
-		wc->uqueue[head].qp_num = entry->qp->qp_num;
-		wc->uqueue[head].src_qp = entry->src_qp;
-		wc->uqueue[head].wc_flags = entry->wc_flags;
-		wc->uqueue[head].pkey_index = entry->pkey_index;
-		wc->uqueue[head].slid = ib_lid_cpu16(entry->slid);
-		wc->uqueue[head].sl = entry->sl;
-		wc->uqueue[head].dlid_path_bits = entry->dlid_path_bits;
-		wc->uqueue[head].port_num = entry->port_num;
+	if (uqueue) {
+		uqueue[head].wr_id = entry->wr_id;
+		uqueue[head].status = entry->status;
+		uqueue[head].opcode = entry->opcode;
+		uqueue[head].vendor_err = entry->vendor_err;
+		uqueue[head].byte_len = entry->byte_len;
+		uqueue[head].ex.imm_data = entry->ex.imm_data;
+		uqueue[head].qp_num = entry->qp->qp_num;
+		uqueue[head].src_qp = entry->src_qp;
+		uqueue[head].wc_flags = entry->wc_flags;
+		uqueue[head].pkey_index = entry->pkey_index;
+		uqueue[head].slid = ib_lid_cpu16(entry->slid);
+		uqueue[head].sl = entry->sl;
+		uqueue[head].dlid_path_bits = entry->dlid_path_bits;
+		uqueue[head].port_num = entry->port_num;
 		/* Make sure entry is written before the head index. */
-		smp_wmb();
+		RDMA_WRITE_UAPI_ATOMIC(u_wc->head, next);
 	} else {
-		wc->kqueue[head] = *entry;
+		kqueue[head] = *entry;
+		k_wc->head = next;
 	}
-	wc->head = next;
 
 	if (cq->notify == IB_CQ_NEXT_COMP ||
 	    (cq->notify == IB_CQ_SOLICITED &&
@@ -181,7 +195,8 @@ struct ib_cq *rvt_create_cq(struct ib_device *ibdev,
 {
 	struct rvt_dev_info *rdi = ib_to_rvt(ibdev);
 	struct rvt_cq *cq;
-	struct rvt_cq_wc *wc;
+	struct rvt_cq_wc *u_wc = NULL;
+	struct rvt_k_cq_wc *k_wc = NULL;
 	struct ib_cq *ret;
 	u32 sz;
 	unsigned int entries = attr->cqe;
@@ -210,17 +225,22 @@ struct ib_cq *rvt_create_cq(struct ib_device *ibdev,
 	 * We need to use vmalloc() in order to support mmap and large
 	 * numbers of entries.
 	 */
-	sz = sizeof(*wc);
-	if (udata && udata->outlen >= sizeof(__u64))
-		sz += sizeof(struct ib_uverbs_wc) * (entries + 1);
-	else
-		sz += sizeof(struct ib_wc) * (entries + 1);
-	wc = udata ?
-		vmalloc_user(sz) :
-		vzalloc_node(sz, rdi->dparms.node);
-	if (!wc) {
-		ret = ERR_PTR(-ENOMEM);
-		goto bail_cq;
+	if (udata && udata->outlen >= sizeof(__u64)) {
+		sz = sizeof(struct ib_uverbs_wc) * (entries + 1);
+		sz += sizeof(*u_wc);
+		u_wc = vmalloc_user(sz);
+		if (!u_wc) {
+			ret = ERR_PTR(-ENOMEM);
+			goto bail_cq;
+		}
+	} else {
+		sz = sizeof(struct ib_wc) * (entries + 1);
+		sz += sizeof(*k_wc);
+		k_wc = vzalloc_node(sz, rdi->dparms.node);
+		if (!k_wc) {
+			ret = ERR_PTR(-ENOMEM);
+			goto bail_cq;
+		}
 	}
 
 	/*
@@ -230,7 +250,7 @@ struct ib_cq *rvt_create_cq(struct ib_device *ibdev,
 	if (udata && udata->outlen >= sizeof(__u64)) {
 		int err;
 
-		cq->ip = rvt_create_mmap_info(rdi, sz, udata, wc);
+		cq->ip = rvt_create_mmap_info(rdi, sz, udata, u_wc);
 		if (!cq->ip) {
 			ret = ERR_PTR(-ENOMEM);
 			goto bail_wc;
@@ -277,7 +297,10 @@ struct ib_cq *rvt_create_cq(struct ib_device *ibdev,
 	cq->notify = RVT_CQ_NONE;
 	spin_lock_init(&cq->lock);
 	INIT_WORK(&cq->comptask, send_complete);
-	cq->queue = wc;
+	if (u_wc)
+		cq->queue = u_wc;
+	else
+		cq->kqueue = k_wc;
 
 	ret = &cq->ibcq;
 
@@ -287,7 +310,8 @@ struct ib_cq *rvt_create_cq(struct ib_device *ibdev,
 bail_ip:
 	kfree(cq->ip);
 bail_wc:
-	vfree(wc);
+	vfree(u_wc);
+	vfree(k_wc);
 bail_cq:
 	kfree(cq);
 done:
@@ -345,9 +369,16 @@ int rvt_req_notify_cq(struct ib_cq *ibcq, enum ib_cq_notify_flags notify_flags)
 	if (cq->notify != IB_CQ_NEXT_COMP)
 		cq->notify = notify_flags & IB_CQ_SOLICITED_MASK;
 
-	if ((notify_flags & IB_CQ_REPORT_MISSED_EVENTS) &&
-	    cq->queue->head != cq->queue->tail)
-		ret = 1;
+	if (notify_flags & IB_CQ_REPORT_MISSED_EVENTS) {
+		if (cq->queue) {
+			if (RDMA_READ_UAPI_ATOMIC(cq->queue->head) !=
+				RDMA_READ_UAPI_ATOMIC(cq->queue->tail))
+				ret = 1;
+		} else {
+			if (cq->kqueue->head != cq->kqueue->tail)
+				ret = 1;
+		}
+	}
 
 	spin_unlock_irqrestore(&cq->lock, flags);
 
@@ -363,12 +394,14 @@ int rvt_req_notify_cq(struct ib_cq *ibcq, enum ib_cq_notify_flags notify_flags)
 int rvt_resize_cq(struct ib_cq *ibcq, int cqe, struct ib_udata *udata)
 {
 	struct rvt_cq *cq = ibcq_to_rvtcq(ibcq);
-	struct rvt_cq_wc *old_wc;
-	struct rvt_cq_wc *wc;
 	u32 head, tail, n;
 	int ret;
 	u32 sz;
 	struct rvt_dev_info *rdi = cq->rdi;
+	struct rvt_cq_wc *u_wc = NULL;
+	struct rvt_cq_wc *old_u_wc = NULL;
+	struct rvt_k_cq_wc *k_wc = NULL;
+	struct rvt_k_cq_wc *old_k_wc = NULL;
 
 	if (cqe < 1 || cqe > rdi->dparms.props.max_cqe)
 		return -EINVAL;
@@ -376,17 +409,19 @@ int rvt_resize_cq(struct ib_cq *ibcq, int cqe, struct ib_udata *udata)
 	/*
 	 * Need to use vmalloc() if we want to support large #s of entries.
 	 */
-	sz = sizeof(*wc);
-	if (udata && udata->outlen >= sizeof(__u64))
-		sz += sizeof(struct ib_uverbs_wc) * (cqe + 1);
-	else
-		sz += sizeof(struct ib_wc) * (cqe + 1);
-	wc = udata ?
-		vmalloc_user(sz) :
-		vzalloc_node(sz, rdi->dparms.node);
-	if (!wc)
-		return -ENOMEM;
-
+	if (udata && udata->outlen >= sizeof(__u64)) {
+		sz = sizeof(struct ib_uverbs_wc) * (cqe + 1);
+		sz += sizeof(*u_wc);
+		u_wc = vmalloc_user(sz);
+		if (!u_wc)
+			return -ENOMEM;
+	} else {
+		sz = sizeof(struct ib_wc) * (cqe + 1);
+		sz += sizeof(*k_wc);
+		k_wc = vzalloc_node(sz, rdi->dparms.node);
+		if (!k_wc)
+			return -ENOMEM;
+	}
 	/* Check that we can write the offset to mmap. */
 	if (udata && udata->outlen >= sizeof(__u64)) {
 		__u64 offset = 0;
@@ -401,11 +436,18 @@ int rvt_resize_cq(struct ib_cq *ibcq, int cqe, struct ib_udata *udata)
 	 * Make sure head and tail are sane since they
 	 * might be user writable.
 	 */
-	old_wc = cq->queue;
-	head = old_wc->head;
+	if (u_wc) {
+		old_u_wc = cq->queue;
+		head = RDMA_READ_UAPI_ATOMIC(old_u_wc->head);
+		tail = RDMA_READ_UAPI_ATOMIC(old_u_wc->tail);
+	} else {
+		old_k_wc = cq->kqueue;
+		head = old_k_wc->head;
+		tail = old_k_wc->tail;
+	}
+
 	if (head > (u32)cq->ibcq.cqe)
 		head = (u32)cq->ibcq.cqe;
-	tail = old_wc->tail;
 	if (tail > (u32)cq->ibcq.cqe)
 		tail = (u32)cq->ibcq.cqe;
 	if (head < tail)
@@ -417,27 +459,36 @@ int rvt_resize_cq(struct ib_cq *ibcq, int cqe, struct ib_udata *udata)
 		goto bail_unlock;
 	}
 	for (n = 0; tail != head; n++) {
-		if (cq->ip)
-			wc->uqueue[n] = old_wc->uqueue[tail];
+		if (u_wc)
+			u_wc->uqueue[n] = old_u_wc->uqueue[tail];
 		else
-			wc->kqueue[n] = old_wc->kqueue[tail];
+			k_wc->kqueue[n] = old_k_wc->kqueue[tail];
 		if (tail == (u32)cq->ibcq.cqe)
 			tail = 0;
 		else
 			tail++;
 	}
 	cq->ibcq.cqe = cqe;
-	wc->head = n;
-	wc->tail = 0;
-	cq->queue = wc;
+	if (u_wc) {
+		RDMA_WRITE_UAPI_ATOMIC(u_wc->head, n);
+		RDMA_WRITE_UAPI_ATOMIC(u_wc->tail, 0);
+		cq->queue = u_wc;
+	} else {
+		k_wc->head = n;
+		k_wc->tail = 0;
+		cq->kqueue = k_wc;
+	}
 	spin_unlock_irq(&cq->lock);
 
-	vfree(old_wc);
+	if (u_wc)
+		vfree(old_u_wc);
+	else
+		vfree(old_k_wc);
 
 	if (cq->ip) {
 		struct rvt_mmap_info *ip = cq->ip;
 
-		rvt_update_mmap_info(rdi, ip, sz, wc);
+		rvt_update_mmap_info(rdi, ip, sz, u_wc);
 
 		/*
 		 * Return the offset to mmap.
@@ -461,7 +512,9 @@ int rvt_resize_cq(struct ib_cq *ibcq, int cqe, struct ib_udata *udata)
 bail_unlock:
 	spin_unlock_irq(&cq->lock);
 bail_free:
-	vfree(wc);
+	vfree(u_wc);
+	vfree(k_wc);
+
 	return ret;
 }
 
@@ -479,7 +532,7 @@ int rvt_resize_cq(struct ib_cq *ibcq, int cqe, struct ib_udata *udata)
 int rvt_poll_cq(struct ib_cq *ibcq, int num_entries, struct ib_wc *entry)
 {
 	struct rvt_cq *cq = ibcq_to_rvtcq(ibcq);
-	struct rvt_cq_wc *wc;
+	struct rvt_k_cq_wc *wc;
 	unsigned long flags;
 	int npolled;
 	u32 tail;
@@ -490,7 +543,7 @@ int rvt_poll_cq(struct ib_cq *ibcq, int num_entries, struct ib_wc *entry)
 
 	spin_lock_irqsave(&cq->lock, flags);
 
-	wc = cq->queue;
+	wc = cq->kqueue;
 	tail = wc->tail;
 	if (tail > (u32)cq->ibcq.cqe)
 		tail = (u32)cq->ibcq.cqe;
diff --git a/include/rdma/rdmavt_cq.h b/include/rdma/rdmavt_cq.h
index 75dc65c..ab22860 100644
--- a/include/rdma/rdmavt_cq.h
+++ b/include/rdma/rdmavt_cq.h
@@ -61,18 +61,27 @@
 #define RVT_CQ_NONE      (IB_CQ_NEXT_COMP + 1)
 
 /*
+ * Define read macro that apply smp_load_acquire memory barrier
+ * when reading indice of circular buffer that mmaped to user space.
+ */
+#define RDMA_READ_UAPI_ATOMIC(member) smp_load_acquire(&(member).val)
+
+/*
+ * Define write macro that uses smp_store_release memory barrier
+ * when writing indice of circular buffer that mmaped to user space.
+ */
+#define RDMA_WRITE_UAPI_ATOMIC(member, x) smp_store_release(&(member).val, x)
+#include <rdma/rvt-abi.h>
+
+/*
  * This structure is used to contain the head pointer, tail pointer,
  * and completion queue entries as a single memory allocation so
  * it can be mmap'ed into user space.
  */
-struct rvt_cq_wc {
+struct rvt_k_cq_wc {
 	u32 head;               /* index of next entry to fill */
 	u32 tail;               /* index of next ib_poll_cq() entry */
-	union {
-		/* these are actually size ibcq.cqe + 1 */
-		struct ib_uverbs_wc uqueue[0];
-		struct ib_wc kqueue[0];
-	};
+	struct ib_wc kqueue[];
 };
 
 /*
@@ -88,6 +97,7 @@ struct rvt_cq {
 	struct rvt_dev_info *rdi;
 	struct rvt_cq_wc *queue;
 	struct rvt_mmap_info *ip;
+	struct rvt_k_cq_wc *kqueue;
 };
 
 static inline struct rvt_cq *ibcq_to_rvtcq(struct ib_cq *ibcq)
diff --git a/include/rdma/rdmavt_qp.h b/include/rdma/rdmavt_qp.h
index 84d0f36..7fcd687 100644
--- a/include/rdma/rdmavt_qp.h
+++ b/include/rdma/rdmavt_qp.h
@@ -820,6 +820,38 @@ struct rvt_qp_iter {
 	int n;
 };
 
+/**
+ * ib_cq_tail - Return tail index of cq buffer
+ * @send_cq - The cq for send
+ *
+ * This is called in qp_iter_print to get tail
+ * of cq buffer.
+ */
+static inline u32 ib_cq_tail(struct ib_cq *send_cq)
+{
+	struct rvt_cq *cq = ibcq_to_rvtcq(send_cq);
+
+	return ibcq_to_rvtcq(send_cq)->ip ?
+	       RDMA_READ_UAPI_ATOMIC(cq->queue->tail) :
+	       ibcq_to_rvtcq(send_cq)->kqueue->tail;
+}
+
+/**
+ * ib_cq_head - Return head index of cq buffer
+ * @send_cq - The cq for send
+ *
+ * This is called in qp_iter_print to get head
+ * of cq buffer.
+ */
+static inline u32 ib_cq_head(struct ib_cq *send_cq)
+{
+	struct rvt_cq *cq = ibcq_to_rvtcq(send_cq);
+
+	return ibcq_to_rvtcq(send_cq)->ip ?
+	       RDMA_READ_UAPI_ATOMIC(cq->queue->head) :
+	       ibcq_to_rvtcq(send_cq)->kqueue->head;
+}
+
 struct rvt_qp_iter *rvt_qp_iter_init(struct rvt_dev_info *rdi,
 				     u64 v,
 				     void (*cb)(struct rvt_qp *qp, u64 v));
diff --git a/include/uapi/rdma/rvt-abi.h b/include/uapi/rdma/rvt-abi.h
new file mode 100644
index 0000000..8e5f7e0
--- /dev/null
+++ b/include/uapi/rdma/rvt-abi.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
+
+/*
+ * This file contains defines, structures, etc. that are used
+ * to communicate between kernel and user code.
+ */
+
+#ifndef RVT_ABI_USER_H
+#define RVT_ABI_USER_H
+
+#include <linux/types.h>
+#include <rdma/ib_user_verbs.h>
+#ifndef RDMA_ATOMIC_UAPI
+#define RDMA_ATOMIC_UAPI(_type, _name) struct{ _type val; } _name
+#endif
+
+/*
+ * This structure is used to contain the head pointer, tail pointer,
+ * and completion queue entries as a single memory allocation so
+ * it can be mmap'ed into user space.
+ */
+struct rvt_cq_wc {
+	/* index of next entry to fill */
+	RDMA_ATOMIC_UAPI(__u32, head);
+	/* index of next ib_poll_cq() entry */
+	RDMA_ATOMIC_UAPI(__u32, tail);
+
+	/* these are actually size ibcq.cqe + 1 */
+	struct ib_uverbs_wc uqueue[];
+};
+
+#endif /* RVT_ABI_USER_H */

