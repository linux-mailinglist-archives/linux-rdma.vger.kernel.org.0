Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A743AFB60
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Sep 2019 13:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbfIKLap (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Sep 2019 07:30:45 -0400
Received: from mga11.intel.com ([192.55.52.93]:61804 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727565AbfIKLao (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 11 Sep 2019 07:30:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Sep 2019 04:30:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,492,1559545200"; 
   d="scan'208";a="175621253"
Received: from sedona.ch.intel.com ([10.2.136.157])
  by orsmga007.jf.intel.com with ESMTP; 11 Sep 2019 04:30:43 -0700
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id x8BBUgMS065278;
        Wed, 11 Sep 2019 04:30:42 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id x8BBUfQ3126111;
        Wed, 11 Sep 2019 07:30:41 -0400
Subject: [PATCH for-next 1/3] IB/hfi1: Add traces for TID RDMA READ
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Kaike Wan <kaike.wan@intel.com>
Date:   Wed, 11 Sep 2019 07:30:41 -0400
Message-ID: <20190911113041.126040.64541.stgit@awfm-01.aw.intel.com>
In-Reply-To: <20190911112912.126040.72184.stgit@awfm-01.aw.intel.com>
References: <20190911112912.126040.72184.stgit@awfm-01.aw.intel.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Kaike Wan <kaike.wan@intel.com>

This patch adds traces to debug packet loss and retry for TID RDMA READ
protocol.

Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Kaike Wan <kaike.wan@intel.com>
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
---
 drivers/infiniband/hw/hfi1/rc.c        |    5 ++++
 drivers/infiniband/hw/hfi1/tid_rdma.c  |    8 +++++++
 drivers/infiniband/hw/hfi1/trace_tid.h |   38 ++++++++++++++++++++++++++++++++
 3 files changed, 51 insertions(+)

diff --git a/drivers/infiniband/hw/hfi1/rc.c b/drivers/infiniband/hw/hfi1/rc.c
index 024a7c2..eeca08d 100644
--- a/drivers/infiniband/hw/hfi1/rc.c
+++ b/drivers/infiniband/hw/hfi1/rc.c
@@ -1483,6 +1483,11 @@ static void update_num_rd_atomic(struct rvt_qp *qp, u32 psn,
 			req->ack_pending = cur_seg - req->comp_seg;
 			priv->pending_tid_r_segs += req->ack_pending;
 			qp->s_num_rd_atomic += req->ack_pending;
+			trace_hfi1_tid_req_update_num_rd_atomic(qp, 0,
+								wqe->wr.opcode,
+								wqe->psn,
+								wqe->lpsn,
+								req);
 		} else {
 			priv->pending_tid_r_segs += req->total_segs;
 			qp->s_num_rd_atomic += req->total_segs;
diff --git a/drivers/infiniband/hw/hfi1/tid_rdma.c b/drivers/infiniband/hw/hfi1/tid_rdma.c
index 04061d5..ab126b1 100644
--- a/drivers/infiniband/hw/hfi1/tid_rdma.c
+++ b/drivers/infiniband/hw/hfi1/tid_rdma.c
@@ -2687,6 +2687,9 @@ static bool handle_read_kdeth_eflags(struct hfi1_ctxtdata *rcd,
 	u32 fpsn;
 
 	lockdep_assert_held(&qp->r_lock);
+	trace_hfi1_rsp_read_kdeth_eflags(qp, ibpsn);
+	trace_hfi1_sender_read_kdeth_eflags(qp);
+	trace_hfi1_tid_read_sender_kdeth_eflags(qp, 0);
 	spin_lock(&qp->s_lock);
 	/* If the psn is out of valid range, drop the packet */
 	if (cmp_psn(ibpsn, qp->s_last_psn) < 0 ||
@@ -2748,6 +2751,8 @@ static bool handle_read_kdeth_eflags(struct hfi1_ctxtdata *rcd,
 		goto s_unlock;
 
 	req = wqe_to_tid_req(wqe);
+	trace_hfi1_tid_req_read_kdeth_eflags(qp, 0, wqe->wr.opcode, wqe->psn,
+					     wqe->lpsn, req);
 	switch (rcv_type) {
 	case RHF_RCV_TYPE_EXPECTED:
 		switch (rte) {
@@ -2762,6 +2767,9 @@ static bool handle_read_kdeth_eflags(struct hfi1_ctxtdata *rcd,
 			 * packets that could be still in the fabric.
 			 */
 			flow = &req->flows[req->clear_tail];
+			trace_hfi1_tid_flow_read_kdeth_eflags(qp,
+							      req->clear_tail,
+							      flow);
 			if (priv->s_flags & HFI1_R_TID_SW_PSN) {
 				diff = cmp_psn(psn,
 					       flow->flow_state.r_next_psn);
diff --git a/drivers/infiniband/hw/hfi1/trace_tid.h b/drivers/infiniband/hw/hfi1/trace_tid.h
index 4388b59..343fb98 100644
--- a/drivers/infiniband/hw/hfi1/trace_tid.h
+++ b/drivers/infiniband/hw/hfi1/trace_tid.h
@@ -627,6 +627,12 @@
 	TP_ARGS(qp, index, flow)
 );
 
+DEFINE_EVENT(/* event */
+	hfi1_tid_flow_template, hfi1_tid_flow_read_kdeth_eflags,
+	TP_PROTO(struct rvt_qp *qp, int index, struct tid_rdma_flow *flow),
+	TP_ARGS(qp, index, flow)
+);
+
 DECLARE_EVENT_CLASS(/* tid_node */
 	hfi1_tid_node_template,
 	TP_PROTO(struct rvt_qp *qp, const char *msg, u32 index, u32 base,
@@ -851,6 +857,12 @@
 	TP_ARGS(qp, psn)
 );
 
+DEFINE_EVENT(/* event */
+	hfi1_responder_info_template, hfi1_rsp_read_kdeth_eflags,
+	TP_PROTO(struct rvt_qp *qp, u32 psn),
+	TP_ARGS(qp, psn)
+);
+
 DECLARE_EVENT_CLASS(/* sender_info */
 	hfi1_sender_info_template,
 	TP_PROTO(struct rvt_qp *qp),
@@ -955,6 +967,12 @@
 	TP_ARGS(qp)
 );
 
+DEFINE_EVENT(/* event */
+	hfi1_sender_info_template, hfi1_sender_read_kdeth_eflags,
+	TP_PROTO(struct rvt_qp *qp),
+	TP_ARGS(qp)
+);
+
 DECLARE_EVENT_CLASS(/* tid_read_sender */
 	hfi1_tid_read_sender_template,
 	TP_PROTO(struct rvt_qp *qp, char newreq),
@@ -1015,6 +1033,12 @@
 	TP_ARGS(qp, newreq)
 );
 
+DEFINE_EVENT(/* event */
+	hfi1_tid_read_sender_template, hfi1_tid_read_sender_kdeth_eflags,
+	TP_PROTO(struct rvt_qp *qp, char newreq),
+	TP_ARGS(qp, newreq)
+);
+
 DECLARE_EVENT_CLASS(/* tid_rdma_request */
 	hfi1_tid_rdma_request_template,
 	TP_PROTO(struct rvt_qp *qp, char newreq, u8 opcode, u32 psn, u32 lpsn,
@@ -1216,6 +1240,13 @@
 );
 
 DEFINE_EVENT(/* event */
+	hfi1_tid_rdma_request_template, hfi1_tid_req_read_kdeth_eflags,
+	TP_PROTO(struct rvt_qp *qp, char newreq, u8 opcode, u32 psn, u32 lpsn,
+		 struct tid_rdma_request *req),
+	TP_ARGS(qp, newreq, opcode, psn, lpsn, req)
+);
+
+DEFINE_EVENT(/* event */
 	hfi1_tid_rdma_request_template, hfi1_tid_req_make_rc_ack_write,
 	TP_PROTO(struct rvt_qp *qp, char newreq, u8 opcode, u32 psn, u32 lpsn,
 		 struct tid_rdma_request *req),
@@ -1229,6 +1260,13 @@
 	TP_ARGS(qp, newreq, opcode, psn, lpsn, req)
 );
 
+DEFINE_EVENT(/* event */
+	hfi1_tid_rdma_request_template, hfi1_tid_req_update_num_rd_atomic,
+	TP_PROTO(struct rvt_qp *qp, char newreq, u8 opcode, u32 psn, u32 lpsn,
+		 struct tid_rdma_request *req),
+	TP_ARGS(qp, newreq, opcode, psn, lpsn, req)
+);
+
 DECLARE_EVENT_CLASS(/* rc_rcv_err */
 	hfi1_rc_rcv_err_template,
 	TP_PROTO(struct rvt_qp *qp, u32 opcode, u32 psn, int diff),

