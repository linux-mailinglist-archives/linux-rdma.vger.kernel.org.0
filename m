Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 764155A35C
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Jun 2019 20:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfF1SV5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Jun 2019 14:21:57 -0400
Received: from mga09.intel.com ([134.134.136.24]:44730 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbfF1SV4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 28 Jun 2019 14:21:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jun 2019 11:21:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,428,1557212400"; 
   d="scan'208";a="165142563"
Received: from sedona.ch.intel.com ([10.2.136.157])
  by orsmga003.jf.intel.com with ESMTP; 28 Jun 2019 11:21:54 -0700
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id x5SILsgM061065;
        Fri, 28 Jun 2019 11:21:54 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id x5SILqXS067913;
        Fri, 28 Jun 2019 14:21:52 -0400
Subject: [PATCH for-next v2 1/9] IB/{hfi1, qib,
 rdmavt}: Put qp in error state when cq is full
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Kamenee Arumugam <kamenee.arumugam@intel.com>
Date:   Fri, 28 Jun 2019 14:21:52 -0400
Message-ID: <20190628182152.67786.83052.stgit@awfm-01.aw.intel.com>
In-Reply-To: <20190628181900.67786.4463.stgit@awfm-01.aw.intel.com>
References: <20190628181900.67786.4463.stgit@awfm-01.aw.intel.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Kamenee Arumugam <kamenee.arumugam@intel.com>

When a completion queue is full, the associated queue pairs
are not put into the error state. According to the IBTA
specification, this is a violation.

Quote from IBTA spec:
C9-218: A Requester Class F error occurs when the CQ is
inaccessible or full and an attempt is made to complete a WQE.
The Affected QP shall be moved to the error state and affiliated
asynchronous errors generated as described in 11.6.3.1
Affiliated Asynchronous Events on page 678. The current WQE and
any subsequent WQEs are left in an unknown state.

C11-37: The CI shall generate a CQ Error when a CQ overrun
is detected. This condition will result in an Affiliated
Asynchronous Error for any associated Work Queues when
they attempt to use that CQ. Completions can no longer be
added to the CQ. It is not guaranteed that completions
present in the CQ at the time the error occurred can be
retrieved. Possible causes include a CQ overrun or a CQ
protection error.

Put the qp in error state when cq is full. Implement a state
called full to continue to put other associated QPs in error
state.

Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Reviewed-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
Signed-off-by: Kamenee Arumugam <kamenee.arumugam@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
---
 drivers/infiniband/hw/hfi1/rc.c    |    3 +-
 drivers/infiniband/hw/hfi1/uc.c    |    3 +-
 drivers/infiniband/hw/hfi1/ud.c    |    5 ++--
 drivers/infiniband/hw/qib/qib_rc.c |    3 +-
 drivers/infiniband/hw/qib/qib_uc.c |    3 +-
 drivers/infiniband/hw/qib/qib_ud.c |    6 ++---
 drivers/infiniband/sw/rdmavt/cq.c  |   15 +++++++++--
 drivers/infiniband/sw/rdmavt/qp.c  |    3 +-
 drivers/infiniband/sw/rdmavt/vt.h  |    9 +++++++
 include/rdma/rdmavt_cq.h           |    3 ++
 include/rdma/rdmavt_qp.h           |   47 +++++++++++++++++++++++++++++++++---
 11 files changed, 75 insertions(+), 25 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/rc.c b/drivers/infiniband/hw/hfi1/rc.c
index 235bdbc..0477c14 100644
--- a/drivers/infiniband/hw/hfi1/rc.c
+++ b/drivers/infiniband/hw/hfi1/rc.c
@@ -3008,8 +3008,7 @@ void hfi1_rc_rcv(struct hfi1_packet *packet)
 		wc.dlid_path_bits = 0;
 		wc.port_num = 0;
 		/* Signal completion event if the solicited bit is set. */
-		rvt_cq_enter(ibcq_to_rvtcq(qp->ibqp.recv_cq), &wc,
-			     ib_bth_is_solicited(ohdr));
+		rvt_recv_cq(qp, &wc, ib_bth_is_solicited(ohdr));
 		break;
 
 	case OP(RDMA_WRITE_ONLY):
diff --git a/drivers/infiniband/hw/hfi1/uc.c b/drivers/infiniband/hw/hfi1/uc.c
index 4ed4fcf..0c77f18 100644
--- a/drivers/infiniband/hw/hfi1/uc.c
+++ b/drivers/infiniband/hw/hfi1/uc.c
@@ -476,8 +476,7 @@ void hfi1_uc_rcv(struct hfi1_packet *packet)
 		wc.dlid_path_bits = 0;
 		wc.port_num = 0;
 		/* Signal completion event if the solicited bit is set. */
-		rvt_cq_enter(ibcq_to_rvtcq(qp->ibqp.recv_cq), &wc,
-			     ib_bth_is_solicited(ohdr));
+		rvt_recv_cq(qp, &wc, ib_bth_is_solicited(ohdr));
 		break;
 
 	case OP(RDMA_WRITE_FIRST):
diff --git a/drivers/infiniband/hw/hfi1/ud.c b/drivers/infiniband/hw/hfi1/ud.c
index 4cb0fce..e16d499 100644
--- a/drivers/infiniband/hw/hfi1/ud.c
+++ b/drivers/infiniband/hw/hfi1/ud.c
@@ -255,8 +255,7 @@ static void ud_loopback(struct rvt_qp *sqp, struct rvt_swqe *swqe)
 	wc.dlid_path_bits = rdma_ah_get_dlid(ah_attr) & ((1 << ppd->lmc) - 1);
 	wc.port_num = qp->port_num;
 	/* Signal completion event if the solicited bit is set. */
-	rvt_cq_enter(ibcq_to_rvtcq(qp->ibqp.recv_cq), &wc,
-		     swqe->wr.send_flags & IB_SEND_SOLICITED);
+	rvt_recv_cq(qp, &wc, swqe->wr.send_flags & IB_SEND_SOLICITED);
 	ibp->rvp.n_loop_pkts++;
 bail_unlock:
 	spin_unlock_irqrestore(&qp->r_lock, flags);
@@ -1061,7 +1060,7 @@ void hfi1_ud_rcv(struct hfi1_packet *packet)
 		dlid & ((1 << ppd_from_ibp(ibp)->lmc) - 1);
 	wc.port_num = qp->port_num;
 	/* Signal completion event if the solicited bit is set. */
-	rvt_cq_enter(ibcq_to_rvtcq(qp->ibqp.recv_cq), &wc, solicited);
+	rvt_recv_cq(qp, &wc, solicited);
 	return;
 
 drop:
diff --git a/drivers/infiniband/hw/qib/qib_rc.c b/drivers/infiniband/hw/qib/qib_rc.c
index 8d9a94d..1d5e2d4 100644
--- a/drivers/infiniband/hw/qib/qib_rc.c
+++ b/drivers/infiniband/hw/qib/qib_rc.c
@@ -1891,8 +1891,7 @@ void qib_rc_rcv(struct qib_ctxtdata *rcd, struct ib_header *hdr,
 		wc.dlid_path_bits = 0;
 		wc.port_num = 0;
 		/* Signal completion event if the solicited bit is set. */
-		rvt_cq_enter(ibcq_to_rvtcq(qp->ibqp.recv_cq), &wc,
-			     ib_bth_is_solicited(ohdr));
+		rvt_recv_cq(qp, &wc, ib_bth_is_solicited(ohdr));
 		break;
 
 	case OP(RDMA_WRITE_FIRST):
diff --git a/drivers/infiniband/hw/qib/qib_uc.c b/drivers/infiniband/hw/qib/qib_uc.c
index 30c70ad..e17b91e 100644
--- a/drivers/infiniband/hw/qib/qib_uc.c
+++ b/drivers/infiniband/hw/qib/qib_uc.c
@@ -400,8 +400,7 @@ void qib_uc_rcv(struct qib_ibport *ibp, struct ib_header *hdr,
 		wc.dlid_path_bits = 0;
 		wc.port_num = 0;
 		/* Signal completion event if the solicited bit is set. */
-		rvt_cq_enter(ibcq_to_rvtcq(qp->ibqp.recv_cq), &wc,
-			     ib_bth_is_solicited(ohdr));
+		rvt_recv_cq(qp, &wc, ib_bth_is_solicited(ohdr));
 		break;
 
 	case OP(RDMA_WRITE_FIRST):
diff --git a/drivers/infiniband/hw/qib/qib_ud.c b/drivers/infiniband/hw/qib/qib_ud.c
index 5cdedba..32ad0b6 100644
--- a/drivers/infiniband/hw/qib/qib_ud.c
+++ b/drivers/infiniband/hw/qib/qib_ud.c
@@ -210,8 +210,7 @@ static void qib_ud_loopback(struct rvt_qp *sqp, struct rvt_swqe *swqe)
 	wc.dlid_path_bits = rdma_ah_get_dlid(ah_attr) & ((1 << ppd->lmc) - 1);
 	wc.port_num = qp->port_num;
 	/* Signal completion event if the solicited bit is set. */
-	rvt_cq_enter(ibcq_to_rvtcq(qp->ibqp.recv_cq), &wc,
-		     swqe->wr.send_flags & IB_SEND_SOLICITED);
+	rvt_recv_cq(qp, &wc, swqe->wr.send_flags & IB_SEND_SOLICITED);
 	ibp->rvp.n_loop_pkts++;
 bail_unlock:
 	spin_unlock_irqrestore(&qp->r_lock, flags);
@@ -573,8 +572,7 @@ void qib_ud_rcv(struct qib_ibport *ibp, struct ib_header *hdr,
 		dlid & ((1 << ppd_from_ibp(ibp)->lmc) - 1);
 	wc.port_num = qp->port_num;
 	/* Signal completion event if the solicited bit is set. */
-	rvt_cq_enter(ibcq_to_rvtcq(qp->ibqp.recv_cq), &wc,
-		     ib_bth_is_solicited(ohdr));
+	rvt_recv_cq(qp, &wc, ib_bth_is_solicited(ohdr));
 	return;
 
 drop:
diff --git a/drivers/infiniband/sw/rdmavt/cq.c b/drivers/infiniband/sw/rdmavt/cq.c
index 2602ad8..fac87b1 100644
--- a/drivers/infiniband/sw/rdmavt/cq.c
+++ b/drivers/infiniband/sw/rdmavt/cq.c
@@ -60,8 +60,11 @@
  * @solicited: true if @entry is solicited
  *
  * This may be called with qp->s_lock held.
+ *
+ * Return: return true on success, else return
+ * false if cq is full.
  */
-void rvt_cq_enter(struct rvt_cq *cq, struct ib_wc *entry, bool solicited)
+bool rvt_cq_enter(struct rvt_cq *cq, struct ib_wc *entry, bool solicited)
 {
 	struct ib_uverbs_wc *uqueue = NULL;
 	struct ib_wc *kqueue = NULL;
@@ -97,7 +100,12 @@ void rvt_cq_enter(struct rvt_cq *cq, struct ib_wc *entry, bool solicited)
 		next = head + 1;
 	}
 
-	if (unlikely(next == tail)) {
+	if (unlikely(next == tail || cq->cq_full)) {
+		struct rvt_dev_info *rdi = cq->rdi;
+
+		if (!cq->cq_full)
+			rvt_pr_err_ratelimited(rdi, "CQ is full!\n");
+		cq->cq_full = true;
 		spin_unlock_irqrestore(&cq->lock, flags);
 		if (cq->ibcq.event_handler) {
 			struct ib_event ev;
@@ -107,7 +115,7 @@ void rvt_cq_enter(struct rvt_cq *cq, struct ib_wc *entry, bool solicited)
 			ev.event = IB_EVENT_CQ_ERR;
 			cq->ibcq.event_handler(&ev, cq->ibcq.cq_context);
 		}
-		return;
+		return false;
 	}
 	trace_rvt_cq_enter(cq, entry, head);
 	if (uqueue) {
@@ -146,6 +154,7 @@ void rvt_cq_enter(struct rvt_cq *cq, struct ib_wc *entry, bool solicited)
 	}
 
 	spin_unlock_irqrestore(&cq->lock, flags);
+	return true;
 }
 EXPORT_SYMBOL(rvt_cq_enter);
 
diff --git a/drivers/infiniband/sw/rdmavt/qp.c b/drivers/infiniband/sw/rdmavt/qp.c
index 200b292..17e192a 100644
--- a/drivers/infiniband/sw/rdmavt/qp.c
+++ b/drivers/infiniband/sw/rdmavt/qp.c
@@ -3103,8 +3103,7 @@ void rvt_ruc_loopback(struct rvt_qp *sqp)
 	wc.sl = rdma_ah_get_sl(&qp->remote_ah_attr);
 	wc.port_num = 1;
 	/* Signal completion event if the solicited bit is set. */
-	rvt_cq_enter(ibcq_to_rvtcq(qp->ibqp.recv_cq), &wc,
-		     wqe->wr.send_flags & IB_SEND_SOLICITED);
+	rvt_recv_cq(qp, &wc, wqe->wr.send_flags & IB_SEND_SOLICITED);
 
 send_comp:
 	spin_unlock_irqrestore(&qp->r_lock, flags);
diff --git a/drivers/infiniband/sw/rdmavt/vt.h b/drivers/infiniband/sw/rdmavt/vt.h
index 0675ea6..d19ff81 100644
--- a/drivers/infiniband/sw/rdmavt/vt.h
+++ b/drivers/infiniband/sw/rdmavt/vt.h
@@ -78,6 +78,12 @@
 		     fmt, \
 		     ##__VA_ARGS__)
 
+#define rvt_pr_err_ratelimited(rdi, fmt, ...) \
+	__rvt_pr_err_ratelimited((rdi)->driver_f.get_pci_dev(rdi), \
+				 rvt_get_ibdev_name(rdi), \
+				 fmt, \
+				 ##__VA_ARGS__)
+
 #define __rvt_pr_info(pdev, name, fmt, ...) \
 	dev_info(&pdev->dev, "%s: " fmt, name, ##__VA_ARGS__)
 
@@ -87,6 +93,9 @@
 #define __rvt_pr_err(pdev, name, fmt, ...) \
 	dev_err(&pdev->dev, "%s: " fmt, name, ##__VA_ARGS__)
 
+#define __rvt_pr_err_ratelimited(pdev, name, fmt, ...) \
+	dev_err_ratelimited(&(pdev)->dev, "%s: " fmt, name, ##__VA_ARGS__)
+
 static inline int ibport_num_to_idx(struct ib_device *ibdev, u8 port_num)
 {
 	struct rvt_dev_info *rdi = ib_to_rvt(ibdev);
diff --git a/include/rdma/rdmavt_cq.h b/include/rdma/rdmavt_cq.h
index ab22860..04c519e 100644
--- a/include/rdma/rdmavt_cq.h
+++ b/include/rdma/rdmavt_cq.h
@@ -93,6 +93,7 @@ struct rvt_cq {
 	spinlock_t lock; /* protect changes in this struct */
 	u8 notify;
 	u8 triggered;
+	u8 cq_full;
 	int comp_vector_cpu;
 	struct rvt_dev_info *rdi;
 	struct rvt_cq_wc *queue;
@@ -105,6 +106,6 @@ static inline struct rvt_cq *ibcq_to_rvtcq(struct ib_cq *ibcq)
 	return container_of(ibcq, struct rvt_cq, ibcq);
 }
 
-void rvt_cq_enter(struct rvt_cq *cq, struct ib_wc *entry, bool solicited);
+bool rvt_cq_enter(struct rvt_cq *cq, struct ib_wc *entry, bool solicited);
 
 #endif          /* DEF_RDMAVT_INCCQH */
diff --git a/include/rdma/rdmavt_qp.h b/include/rdma/rdmavt_qp.h
index de5915b..e4be869 100644
--- a/include/rdma/rdmavt_qp.h
+++ b/include/rdma/rdmavt_qp.h
@@ -718,6 +718,48 @@ static inline void rvt_put_qp_swqe(struct rvt_qp *qp, struct rvt_swqe *wqe)
 	return val;
 }
 
+int rvt_error_qp(struct rvt_qp *qp, enum ib_wc_status err);
+
+/**
+ * rvt_recv_cq - add a new entry to completion queue
+ *			by receive queue
+ * @qp: receive queue
+ * @wc: work completion entry to add
+ * @solicited: true if @entry is solicited
+ *
+ * This is wrapper function for rvt_enter_cq function call by
+ * receive queue. If rvt_cq_enter return false, it means cq is
+ * full and the qp is put into error state.
+ */
+static inline void rvt_recv_cq(struct rvt_qp *qp, struct ib_wc *wc,
+			       bool solicited)
+{
+	struct rvt_cq *cq = ibcq_to_rvtcq(qp->ibqp.recv_cq);
+
+	if (unlikely(!rvt_cq_enter(cq, wc, solicited)))
+		rvt_error_qp(qp, IB_WC_LOC_QP_OP_ERR);
+}
+
+/**
+ * rvt_send_cq - add a new entry to completion queue
+ *                        by send queue
+ * @qp: send queue
+ * @wc: work completion entry to add
+ * @solicited: true if @entry is solicited
+ *
+ * This is wrapper function for rvt_enter_cq function call by
+ * send queue. If rvt_cq_enter return false, it means cq is
+ * full and the qp is put into error state.
+ */
+static inline void rvt_send_cq(struct rvt_qp *qp, struct ib_wc *wc,
+			       bool solicited)
+{
+	struct rvt_cq *cq = ibcq_to_rvtcq(qp->ibqp.send_cq);
+
+	if (unlikely(!rvt_cq_enter(cq, wc, solicited)))
+		rvt_error_qp(qp, IB_WC_LOC_QP_OP_ERR);
+}
+
 /**
  * rvt_qp_complete_swqe - insert send completion
  * @qp - the qp
@@ -768,9 +810,7 @@ static inline void rvt_put_qp_swqe(struct rvt_qp *qp, struct rvt_swqe *wqe)
 			.qp = &qp->ibqp,
 			.byte_len = byte_len,
 		};
-
-		rvt_cq_enter(ibcq_to_rvtcq(qp->ibqp.send_cq), &w,
-			     status != IB_WC_SUCCESS);
+		rvt_send_cq(qp, &w, status != IB_WC_SUCCESS);
 	}
 	return last;
 }
@@ -780,7 +820,6 @@ static inline void rvt_put_qp_swqe(struct rvt_qp *qp, struct rvt_swqe *wqe)
 struct rvt_dev_info;
 int rvt_get_rwqe(struct rvt_qp *qp, bool wr_id_only);
 void rvt_comm_est(struct rvt_qp *qp);
-int rvt_error_qp(struct rvt_qp *qp, enum ib_wc_status err);
 void rvt_rc_error(struct rvt_qp *qp, enum ib_wc_status err);
 unsigned long rvt_rnr_tbl_to_usec(u32 index);
 enum hrtimer_restart rvt_rc_rnr_retry(struct hrtimer *t);

