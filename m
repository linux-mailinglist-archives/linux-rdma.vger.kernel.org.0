Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD07A341D88
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Mar 2021 13:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhCSM5R (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Mar 2021 08:57:17 -0400
Received: from mga01.intel.com ([192.55.52.88]:4853 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229914AbhCSM4p (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 19 Mar 2021 08:56:45 -0400
IronPort-SDR: oJLh22uU/mSpCOUqcGIr38t3B0fxvHJFnCL1Vemc+pHW428MBZ7xWyU2NhqJ6OJOc5cGCYB1Pe
 LVvxqdiApyiA==
X-IronPort-AV: E=McAfee;i="6000,8403,9927"; a="209910290"
X-IronPort-AV: E=Sophos;i="5.81,261,1610438400"; 
   d="scan'208";a="209910290"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 05:56:44 -0700
IronPort-SDR: ebvp5i0ki9r+V7neKLN1zjNk/M1DTRDI7zi49TcH3dcUR3Np8bCdu327QMsk3dBhIJekF48lac
 +pFpaSXjyCfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,261,1610438400"; 
   d="scan'208";a="450851749"
Received: from phwfstl014.hd.intel.com ([10.127.241.142])
  by orsmga001.jf.intel.com with ESMTP; 19 Mar 2021 05:56:43 -0700
From:   kaike.wan@intel.com
To:     dledford@redhat.com, jgg@nvidia.com
Cc:     linux-rdma@vger.kernel.org, todd.rimmer@intel.com,
        Kaike Wan <kaike.wan@intel.com>
Subject: [PATCH RFC 7/9] RDMA/rv: Add functions for RDMA transactions
Date:   Fri, 19 Mar 2021 08:56:33 -0400
Message-Id: <20210319125635.34492-8-kaike.wan@intel.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20210319125635.34492-1-kaike.wan@intel.com>
References: <20210319125635.34492-1-kaike.wan@intel.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Kaike Wan <kaike.wan@intel.com>

The only RDMA request used by this module is the RDMA WRITE WITH
IMMEDIATE request. Part of the immediate data is used as a tag to
encode the intended receiving rv_user in the rv_conn object, and
remaining bits are reserved for the user application (eg. to associate
the inbound completion with a specific outstanding rendezvous IO).

This patch adds the following functions:
- Send RDMA write with immediate request.
- Handle the send completion event.
- Receive the RDMA write with immediate request.
- Post events to the event ring.

Signed-off-by: Todd Rimmer <todd.rimmer@intel.com>
Signed-off-by: Kaike Wan <kaike.wan@intel.com>
---
 drivers/infiniband/ulp/rv/rv_rdma.c    | 313 +++++++++++++++++++++++++
 drivers/infiniband/ulp/rv/trace_rdma.h | 125 ++++++++++
 drivers/infiniband/ulp/rv/trace_user.h |  31 +++
 3 files changed, 469 insertions(+)

diff --git a/drivers/infiniband/ulp/rv/rv_rdma.c b/drivers/infiniband/ulp/rv/rv_rdma.c
index 10334c0441a5..c30773e09ffe 100644
--- a/drivers/infiniband/ulp/rv/rv_rdma.c
+++ b/drivers/infiniband/ulp/rv/rv_rdma.c
@@ -6,6 +6,56 @@
 #include "rv.h"
 #include "trace.h"
 
+/*
+ * select next sconn to post and claim WQE by inc outstand_send_write
+ * if all sconn SQs are full, next is left back where it started
+ */
+static struct rv_sconn *rv_conn_next_sconn_to_post(struct rv_conn *conn)
+{
+	unsigned long flags;
+	struct rv_sconn *sconn;
+	u8 i;
+	u32 qp_depth = conn->jdev->qp_depth;
+
+	spin_lock_irqsave(&conn->next_lock, flags);
+	for (i = 0; i < conn->num_conn; i++) {
+		sconn = &conn->sconn_arr[conn->next];
+		conn->next = (conn->next + 1) % conn->num_conn;
+		if (atomic_read(&sconn->stats.outstand_send_write) < qp_depth) {
+			atomic_inc(&sconn->stats.outstand_send_write);
+			goto unlock;
+		}
+	}
+	sconn = NULL;
+unlock:
+	spin_unlock_irqrestore(&conn->next_lock, flags);
+	return sconn;
+}
+
+static int rv_drv_post_write_immed(struct rv_pend_write *pend_wr)
+{
+	struct ib_rdma_wr wr;
+	const struct ib_send_wr *bad_wr;
+	struct ib_sge list;
+	struct rv_mr_cached *mrc = pend_wr->mrc;
+
+	/* we xlat the user space loc_addr to an iova appropriate for the MR */
+	list.addr = mrc->mr.ib_mr->iova + (pend_wr->loc_addr - mrc->addr);
+	list.length = pend_wr->length;
+	list.lkey = mrc->mr.ib_mr->lkey;
+
+	wr.wr.next = NULL;
+	wr.wr.wr_cqe = &pend_wr->cqe;
+	wr.wr.sg_list = &list;
+	wr.wr.num_sge = 1;
+	wr.wr.opcode = IB_WR_RDMA_WRITE_WITH_IMM;
+	wr.wr.send_flags = IB_SEND_SIGNALED;
+	wr.wr.ex.imm_data = cpu_to_be32(pend_wr->immed);
+	wr.remote_addr = pend_wr->rem_addr;
+	wr.rkey = pend_wr->rkey;
+	return ib_post_send(pend_wr->sconn->qp, &wr.wr, &bad_wr);
+}
+
 /*
  * This is called in Soft IRQs for CQE handling.
  * We just report errors here, let the QP Async Event deal with
@@ -22,6 +72,246 @@ void rv_report_cqe_error(struct ib_cq *cq, struct ib_wc *wc,
 			    wc->wr_cqe);
 }
 
+static void rv_user_ring_post_event(struct rv_user_ring *ring,
+				    struct rv_event *ev)
+{
+	unsigned long flags;
+	struct rv_ring_header *hdr = ring->hdr;
+	int next;
+
+	trace_rv_user_ring_post_event(ring->rv_inx, ring->num_entries,
+				      ring->hdr->head, ring->hdr->tail);
+	trace_rv_event_post(ev->event_type, ev->wc.status, ev->wc.imm_data,
+			    ev->wc.wr_id, ev->wc.conn_handle,
+			    ev->wc.byte_len);
+	spin_lock_irqsave(&ring->lock, flags);
+	next = hdr->tail + 1;
+	if (next == ring->num_entries)
+		next = 0;
+	if (next == hdr->head)  {
+		hdr->overflow_cnt++;
+		rv_err(ring->rv_inx, "event ring full: head %u tail %u\n",
+		       hdr->head, hdr->tail);
+		goto unlock;
+	}
+
+	smp_rmb(); /* ensure we read tail before writing event */
+	hdr->entries[hdr->tail] = *ev;
+	smp_wmb(); /* ensure ev written before advance tail */
+
+	hdr->tail = next;
+	if (ev->wc.status) {
+		ring->stats.cqe_fail[ev->event_type]++;
+	} else {
+		ring->stats.cqe[ev->event_type]++;
+		ring->stats.bytes[ev->event_type] += ev->wc.byte_len;
+	}
+unlock:
+	spin_unlock_irqrestore(&ring->lock, flags);
+}
+
+static void rv_post_user_event_by_index(struct rv_job_dev *jdev, u16 index,
+					struct rv_event *ev)
+{
+	unsigned long flags;
+	struct rv_user *rv;
+
+	spin_lock_irqsave(&jdev->user_array_lock, flags);
+	if (index >= jdev->max_users)
+		goto unlock;
+	rv = jdev->user_array[index];
+	if (rv && rv->cqr)
+		rv_user_ring_post_event(rv->cqr, ev);
+unlock:
+	spin_unlock_irqrestore(&jdev->user_array_lock, flags);
+}
+
+/*
+ * We have a rv_conn reference for the pend_wr
+ * pass all failures to PSM to deal with.  We can't attempt
+ * to retry the write in rv since it might have succeeded on remote
+ * end (eg. ack lost) and remote end may be using buffer for something
+ * else already
+ */
+static void rv_rdma_write_done(struct ib_cq *cq, struct ib_wc *wc)
+{
+	struct rv_pend_write *pend_wr = container_of(wc->wr_cqe,
+						struct rv_pend_write, cqe);
+	struct rv_sconn *sconn = pend_wr->sconn;
+	struct rv_event ev = { 0 };
+
+	atomic_dec(&sconn->stats.outstand_send_write);
+	trace_rv_wc_write_done(pend_wr->wr_id, wc->status, wc->opcode,
+			       wc->byte_len, be32_to_cpu(wc->ex.imm_data));
+	trace_rv_pend_write_done(pend_wr->user_index, pend_wr->sconn, pend_wr,
+				 pend_wr->loc_addr, pend_wr->rkey,
+				 pend_wr->rem_addr, pend_wr->length,
+				 pend_wr->immed, pend_wr->wr_id);
+
+	if (unlikely(wc->status != IB_WC_SUCCESS))
+		rv_report_cqe_error(cq, wc, pend_wr->sconn, "RDMA Write");
+	else if (wc->qp != sconn->qp)
+		rv_report_cqe_error(cq, wc, pend_wr->sconn, "Stale RDMA Write");
+
+	ev.event_type = RV_WC_RDMA_WRITE;
+	ev.wc.status = wc->status;
+	ev.wc.wr_id = pend_wr->wr_id;
+	ev.wc.conn_handle = (u64)pend_wr->sconn->parent;
+	ev.wc.byte_len = pend_wr->length;
+	trace_rv_event_write_done(ev.event_type, ev.wc.status, ev.wc.imm_data,
+				  ev.wc.wr_id, ev.wc.conn_handle,
+				  ev.wc.byte_len);
+
+	rv_mr_cache_put(&pend_wr->umrs->cache, pend_wr->mrc);
+
+	rv_post_user_event_by_index(pend_wr->sconn->parent->jdev,
+				    pend_wr->user_index, &ev);
+
+	if (wc->status)
+		atomic64_inc(&sconn->stats.send_write_cqe_fail);
+	else
+		atomic64_inc(&sconn->stats.send_write_cqe);
+
+	/* our rv_conn ref prevents user_mrs_put from triggering job cleanup */
+	rv_user_mrs_put(pend_wr->umrs);
+
+	/* rv_conn_put can put rv_job_dev and trigger whole job cleanup */
+	rv_conn_put(sconn->parent);
+
+	kfree(pend_wr);
+}
+
+/*
+ * we do not need a queue inside rv of unposted writes.  If this fails
+ * PSM will try to repost later.
+ * We use loc_addr/length/access to lookup MR in cache and then verify RDMA is
+ * consistent with loc_addr and length
+ */
+int doit_post_rdma_write(struct rv_user *rv, unsigned long arg)
+{
+	struct rv_post_write_params pparams;
+	struct rv_conn *conn;
+	struct rv_sconn *sconn;
+	struct rv_mr_cached *mrc;
+	struct rv_pend_write *pend_wr;
+	int ret;
+
+	if (copy_from_user(&pparams.in, (void __user *)arg,
+			   sizeof(pparams.in)))
+		return -EFAULT;
+
+	mutex_lock(&rv->mutex);
+
+	conn = user_conn_find(rv, pparams.in.handle);
+	if (!conn) {
+		rv_err(rv->inx, "post_write: No connection found\n");
+		ret = -EINVAL;
+		goto bail_unlock;
+	}
+	sconn = rv_conn_next_sconn_to_post(conn);
+	if (unlikely(!sconn)) {
+		ret = -ENOMEM;
+		goto bail_unlock;
+	}
+
+	mrc = rv_mr_cache_search_get(&rv->umrs->cache, pparams.in.loc_mr_addr,
+				     pparams.in.loc_mr_length,
+				     pparams.in.loc_mr_access, false);
+	if (!mrc) {
+		rv_err(rv->inx, "post_write: bad loc_mr\n");
+		ret = -EINVAL;
+		goto bail_dec;
+	}
+
+	if (mrc->addr > (u64)pparams.in.loc_addr ||
+	    mrc->addr + mrc->len <
+	    (u64)pparams.in.loc_addr + pparams.in.length) {
+		rv_err(rv->inx, "post_write: addr inconsistent with loc_mr\n");
+		ret = -EINVAL;
+		goto bail_put_mr;
+	}
+	if (!(mrc->access & IBV_ACCESS_KERNEL)) {
+		rv_err(rv->inx, "post_write: loc_mr not a kernel MR\n");
+		ret = -EINVAL;
+		goto bail_put_mr;
+	}
+
+	pend_wr = kzalloc(sizeof(*pend_wr), GFP_KERNEL);
+	if (!pend_wr) {
+		ret = -ENOMEM;
+		goto bail_put_mr;
+	}
+	pend_wr->cqe.done = rv_rdma_write_done;
+	pend_wr->user_index = rv->index;
+
+	rv_user_mrs_get(rv->umrs);
+	pend_wr->umrs = rv->umrs;
+
+	rv_conn_get(sconn->parent);
+	pend_wr->sconn = sconn;
+
+	pend_wr->mrc = mrc;
+	pend_wr->loc_addr = (u64)pparams.in.loc_addr;
+	pend_wr->rem_addr = pparams.in.rem_addr;
+	pend_wr->rkey = pparams.in.rkey;
+	pend_wr->length = pparams.in.length;
+	pend_wr->immed = pparams.in.immed;
+	pend_wr->wr_id = pparams.in.wr_id;
+
+	mutex_lock(&sconn->mutex);
+	if (sconn->state != RV_CONNECTED) {
+		if (sconn->state == RV_ERROR)
+			ret = -EIO;
+		else if (test_bit(RV_SCONN_WAS_CONNECTED, &sconn->flags))
+			ret = -EAGAIN;
+		else
+			ret = -EINVAL;
+		mutex_unlock(&sconn->mutex);
+		goto bail_free_pend;
+	}
+
+	trace_rv_pend_write_post(pend_wr->user_index, pend_wr->sconn, pend_wr,
+				 pend_wr->loc_addr, pend_wr->rkey,
+				 pend_wr->rem_addr, pend_wr->length,
+				 pend_wr->immed, pend_wr->wr_id);
+	ret = rv_drv_post_write_immed(pend_wr);
+	if (ret) {
+		sconn->stats.post_write_fail++;
+	} else {
+		sconn->stats.post_write++;
+		sconn->stats.post_write_bytes += pparams.in.length;
+	}
+
+	pparams.out.sconn_index = sconn->index;
+	pparams.out.conn_count = sconn->stats.conn_recovery + 1;
+
+	mutex_unlock(&sconn->mutex);
+	if (ret) {
+		rv_err(rv->inx, "post_write: failed: %d\n", ret);
+		goto bail_free_pend;
+	}
+
+	if (copy_to_user((void __user *)arg, &pparams.out, sizeof(pparams.out)))
+		ret = -EFAULT;
+
+	mutex_unlock(&rv->mutex);
+
+	return 0;
+
+bail_free_pend:
+	rv_conn_put(pend_wr->sconn->parent);
+	rv_user_mrs_put(pend_wr->umrs);
+	kfree(pend_wr);
+
+bail_put_mr:
+	rv_mr_cache_put(&rv->umrs->cache, mrc);
+bail_dec:
+	atomic_dec(&sconn->stats.outstand_send_write);
+bail_unlock:
+	mutex_unlock(&rv->mutex);
+	return ret;
+}
+
 static int rv_drv_post_recv(struct rv_sconn *sconn)
 {
 	struct ib_recv_wr wr;
@@ -54,6 +344,27 @@ int rv_drv_prepost_recv(struct rv_sconn *sconn)
 	return 0;
 }
 
+static void rv_recv_rdma_write(struct rv_sconn *sconn, struct ib_wc *wc)
+{
+	struct rv_job_dev *jdev = sconn->parent->jdev;
+	u32 index = be32_to_cpu(wc->ex.imm_data) >> (32 - jdev->index_bits);
+	struct rv_event ev = { 0 };
+
+	ev.event_type = RV_WC_RECV_RDMA_WITH_IMM;
+	ev.wc.status = wc->status;
+	ev.wc.resv1 = 0;
+	ev.wc.imm_data = be32_to_cpu(wc->ex.imm_data);
+	ev.wc.wr_id = 0;	/* N/A */
+	ev.wc.conn_handle = (u64)sconn->parent;
+	ev.wc.byte_len = wc->byte_len;
+	ev.wc.resv2 = 0;
+	trace_rv_event_recv_write(ev.event_type, ev.wc.status, ev.wc.imm_data,
+				  ev.wc.wr_id, ev.wc.conn_handle,
+				  ev.wc.byte_len);
+
+	rv_post_user_event_by_index(jdev, index, &ev);
+}
+
 /* drain_lock makes sure no recv WQEs get reposted after a drain WQE */
 void rv_recv_done(struct ib_cq *cq, struct ib_wc *wc)
 {
@@ -93,6 +404,8 @@ void rv_recv_done(struct ib_cq *cq, struct ib_wc *wc)
 
 	if (unlikely(wc->opcode != IB_WC_RECV_RDMA_WITH_IMM))
 		rv_report_cqe_error(cq, wc, sconn, "Recv bad opcode");
+	else
+		rv_recv_rdma_write(sconn, wc);
 repost:
 	spin_lock_irqsave(&sconn->drain_lock, flags);
 	if (likely(!test_bit(RV_SCONN_DRAINING, &sconn->flags)))
diff --git a/drivers/infiniband/ulp/rv/trace_rdma.h b/drivers/infiniband/ulp/rv/trace_rdma.h
index 54ea0cf2599c..e662b2246d8c 100644
--- a/drivers/infiniband/ulp/rv/trace_rdma.h
+++ b/drivers/infiniband/ulp/rv/trace_rdma.h
@@ -11,9 +11,74 @@
 #undef TRACE_SYSTEM
 #define TRACE_SYSTEM rv_rdma
 
+#define RV_PEND_WRITE_PRN "user_inx %d sconn %p pend_wr %p loc_addr 0x%llx" \
+			  " rkey 0x%x rem_addr 0x%llx len 0x%llx immed 0x%x" \
+			  " wr_id 0x%llx"
+
 #define RV_SCONN_RECV_PRN "sconn %p index %u qp 0x%x conn %p flags 0x%x " \
 			  " state %u immed 0x%x"
 
+#define RV_EVENT_PRN "type 0x%x status 0x%x immed 0x%x wr_id 0x%llx " \
+		     "conn_handle 0x%llx len 0x%x"
+
+DECLARE_EVENT_CLASS(/* pend_write */
+	rv_pend_write_template,
+	TP_PROTO(int user_inx, void *sconn, void *pend_wr, u64 loc_addr,
+		 u32 rkey, u64 rem_addr, u64 len, u32 immed, u64 wr_id),
+	TP_ARGS(user_inx, sconn, pend_wr, loc_addr, rkey, rem_addr, len, immed,
+		wr_id),
+	TP_STRUCT__entry(/* entry */
+		__field(int, user_inx)
+		__field(void *, sconn)
+		__field(void *, pend_wr)
+		__field(u64, loc_addr)
+		__field(u32, rkey)
+		__field(u64, rem_addr)
+		__field(u64, len)
+		__field(u32, immed)
+		__field(u64, wr_id)
+	),
+	TP_fast_assign(/* assign */
+		__entry->user_inx = user_inx;
+		__entry->sconn = sconn;
+		__entry->pend_wr = pend_wr;
+		__entry->loc_addr = loc_addr;
+		__entry->rkey = rkey;
+		__entry->rem_addr = rem_addr;
+		__entry->len = len;
+		__entry->immed = immed;
+		__entry->wr_id = wr_id;
+	),
+	TP_printk(/* print */
+		RV_PEND_WRITE_PRN,
+		__entry->user_inx,
+		__entry->sconn,
+		__entry->pend_wr,
+		__entry->loc_addr,
+		__entry->rkey,
+		__entry->rem_addr,
+		__entry->len,
+		__entry->immed,
+		__entry->wr_id
+	)
+);
+
+DEFINE_EVENT(/* event */
+	rv_pend_write_template, rv_pend_write_post,
+	TP_PROTO(int user_inx, void *sconn, void *pend_wr, u64 loc_addr,
+		 u32 rkey, u64 rem_addr, u64 len, u32 immed, u64 wr_id),
+	TP_ARGS(user_inx, sconn, pend_wr, loc_addr, rkey, rem_addr, len, immed,
+		wr_id)
+);
+
+DEFINE_EVENT(/* event */
+	rv_pend_write_template, rv_pend_write_done,
+	TP_PROTO(int user_inx, void *sconn, void *pend_wr, u64 loc_addr,
+		 u32 rkey, u64 rem_addr, u64 len, u32 immed, u64 wr_id),
+	TP_ARGS(user_inx, sconn, pend_wr, loc_addr, rkey, rem_addr, len, immed,
+		wr_id)
+);
+
 DECLARE_EVENT_CLASS(/* recv */
 	rv_sconn_recv_template,
 	TP_PROTO(void *ptr, u8 index, u32 qp_num, void *conn, u32 flags,
@@ -77,6 +142,59 @@ DEFINE_EVENT(/* event */
 	TP_ARGS(ptr, index, qp_num, conn, flags, state, immed)
 );
 
+DECLARE_EVENT_CLASS(/* event */
+	rv_event_template,
+	TP_PROTO(u8 type, u8 status, u32 immed, u64 wr_id, u64 conn_handle,
+		 u32 len),
+	TP_ARGS(type, status, immed, wr_id, conn_handle, len),
+	TP_STRUCT__entry(/* entry */
+		__field(u8, type)
+		__field(u8, status)
+		__field(u32, immed)
+		__field(u64, wr_id)
+		__field(u64, conn_handle)
+		__field(u32, len)
+	),
+	TP_fast_assign(/* assign */
+		__entry->type = type;
+		__entry->status = status;
+		__entry->immed = immed;
+		__entry->wr_id = wr_id;
+		__entry->conn_handle = conn_handle;
+		__entry->len = len;
+	),
+	TP_printk(/* print */
+		RV_EVENT_PRN,
+		__entry->type,
+		__entry->status,
+		__entry->immed,
+		__entry->wr_id,
+		__entry->conn_handle,
+		__entry->len
+	)
+);
+
+DEFINE_EVENT(/* event */
+	rv_event_template, rv_event_write_done,
+	TP_PROTO(u8 type, u8 status, u32 immed, u64 wr_id, u64 conn_handle,
+		 u32 len),
+	TP_ARGS(type, status, immed, wr_id, conn_handle, len)
+);
+
+DEFINE_EVENT(/* event */
+	rv_event_template, rv_event_post,
+	TP_PROTO(u8 type, u8 status, u32 immed, u64 wr_id, u64 conn_handle,
+		 u32 len),
+	TP_ARGS(type, status, immed, wr_id, conn_handle, len)
+);
+
+DEFINE_EVENT(/* event */
+	rv_event_template, rv_event_recv_write,
+	TP_PROTO(u8 type, u8 status, u32 immed, u64 wr_id, u64 conn_handle,
+		 u32 len),
+	TP_ARGS(type, status, immed, wr_id, conn_handle, len)
+);
+
 DECLARE_EVENT_CLASS(/* wc */
 	rv_wc_template,
 	TP_PROTO(u64 wr_id, u32 status, u32 opcode, u32 byte_len,
@@ -113,6 +231,13 @@ DEFINE_EVENT(/* event */
 	TP_ARGS(wr_id, status, opcode, byte_len, imm_data)
 );
 
+DEFINE_EVENT(/* event */
+	rv_wc_template, rv_wc_write_done,
+	TP_PROTO(u64 wr_id, u32 status, u32 opcode, u32 byte_len,
+		 u32 imm_data),
+	TP_ARGS(wr_id, status, opcode, byte_len, imm_data)
+);
+
 DEFINE_EVENT(/* event */
 	rv_wc_template, rv_wc_hb_done,
 	TP_PROTO(u64 wr_id, u32 status, u32 opcode, u32 byte_len,
diff --git a/drivers/infiniband/ulp/rv/trace_user.h b/drivers/infiniband/ulp/rv/trace_user.h
index ce62c808ca10..90f67537d249 100644
--- a/drivers/infiniband/ulp/rv/trace_user.h
+++ b/drivers/infiniband/ulp/rv/trace_user.h
@@ -112,6 +112,37 @@ DEFINE_EVENT(/* event */
 	TP_ARGS(rv_inx, jdev, total_size, max_size, refcount)
 );
 
+DECLARE_EVENT_CLASS(/* user_ring */
+	rv_user_ring_template,
+	TP_PROTO(int rv_inx, u32 count, u32 hd, u32 tail),
+	TP_ARGS(rv_inx, count, hd, tail),
+	TP_STRUCT__entry(/* entry */
+		__field(int, rv_inx)
+		__field(u32, count)
+		__field(u32, head)
+		__field(u32, tail)
+	),
+	TP_fast_assign(/* assign */
+		__entry->rv_inx = rv_inx;
+		__entry->count = count;
+		__entry->head = hd;
+		__entry->tail = tail;
+	),
+	TP_printk(/* print */
+		"rv_inx %d entries %u head %u tail %u",
+		__entry->rv_inx,
+		__entry->count,
+		__entry->head,
+		__entry->tail
+	)
+);
+
+DEFINE_EVENT(/* event */
+	rv_user_ring_template, rv_user_ring_post_event,
+	TP_PROTO(int rv_inx, u32 count, u32 hd, u32 tail),
+	TP_ARGS(rv_inx, count, hd, tail)
+);
+
 #endif /* __RV_TRACE_USER_H */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.18.1

