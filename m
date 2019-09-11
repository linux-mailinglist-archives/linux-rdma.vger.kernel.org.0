Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 462E5AFB61
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Sep 2019 13:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbfIKLau (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Sep 2019 07:30:50 -0400
Received: from mga18.intel.com ([134.134.136.126]:41273 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727565AbfIKLau (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 11 Sep 2019 07:30:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Sep 2019 04:30:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,492,1559545200"; 
   d="scan'208";a="189648181"
Received: from sedona.ch.intel.com ([10.2.136.157])
  by orsmga006.jf.intel.com with ESMTP; 11 Sep 2019 04:30:49 -0700
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id x8BBUnUd065284;
        Wed, 11 Sep 2019 04:30:49 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id x8BBUlJE126120;
        Wed, 11 Sep 2019 07:30:47 -0400
Subject: [PATCH for-next 2/3] IB/{rdmavt, hfi1,
 qib}: Add a counter for credit waits
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Kaike Wan <kaike.wan@intel.com>
Date:   Wed, 11 Sep 2019 07:30:47 -0400
Message-ID: <20190911113047.126040.10857.stgit@awfm-01.aw.intel.com>
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

This patch adds a counter for credit waits to assist field debugging.

Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Kaike Wan <kaike.wan@intel.com>
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
---
 drivers/infiniband/hw/hfi1/chip.c     |    2 ++
 drivers/infiniband/hw/hfi1/chip.h     |    1 +
 drivers/infiniband/hw/hfi1/rc.c       |   10 ++-------
 drivers/infiniband/hw/qib/qib_rc.c    |   10 ++-------
 drivers/infiniband/hw/qib/qib_sysfs.c |    2 ++
 include/rdma/rdma_vt.h                |    1 +
 include/rdma/rdmavt_qp.h              |   35 +++++++++++++++++++++++++++++++++
 7 files changed, 45 insertions(+), 16 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/chip.c b/drivers/infiniband/hw/hfi1/chip.c
index 67052dc..9b1fb84 100644
--- a/drivers/infiniband/hw/hfi1/chip.c
+++ b/drivers/infiniband/hw/hfi1/chip.c
@@ -4101,6 +4101,7 @@ static u64 access_dc_rcv_err_cnt(const struct cntr_entry *entry,
 def_access_ibp_counter(rdma_seq);
 def_access_ibp_counter(unaligned);
 def_access_ibp_counter(seq_naks);
+def_access_ibp_counter(rc_crwaits);
 
 static struct cntr_entry dev_cntrs[DEV_CNTR_LAST] = {
 [C_RCV_OVF] = RXE32_DEV_CNTR_ELEM(RcvOverflow, RCV_BUF_OVFL_CNT, CNTR_SYNTH),
@@ -5119,6 +5120,7 @@ static u64 access_dc_rcv_err_cnt(const struct cntr_entry *entry,
 [C_SW_IBP_RDMA_SEQ] = SW_IBP_CNTR(RdmaSeq, rdma_seq),
 [C_SW_IBP_UNALIGNED] = SW_IBP_CNTR(Unaligned, unaligned),
 [C_SW_IBP_SEQ_NAK] = SW_IBP_CNTR(SeqNak, seq_naks),
+[C_SW_IBP_RC_CRWAITS] = SW_IBP_CNTR(RcCrWait, rc_crwaits),
 [C_SW_CPU_RC_ACKS] = CNTR_ELEM("RcAcks", 0, 0, CNTR_NORMAL,
 			       access_sw_cpu_rc_acks),
 [C_SW_CPU_RC_QACKS] = CNTR_ELEM("RcQacks", 0, 0, CNTR_NORMAL,
diff --git a/drivers/infiniband/hw/hfi1/chip.h b/drivers/infiniband/hw/hfi1/chip.h
index b76cf81..4ca5ac8 100644
--- a/drivers/infiniband/hw/hfi1/chip.h
+++ b/drivers/infiniband/hw/hfi1/chip.h
@@ -1245,6 +1245,7 @@ enum {
 	C_SW_IBP_RDMA_SEQ,
 	C_SW_IBP_UNALIGNED,
 	C_SW_IBP_SEQ_NAK,
+	C_SW_IBP_RC_CRWAITS,
 	C_SW_CPU_RC_ACKS,
 	C_SW_CPU_RC_QACKS,
 	C_SW_CPU_RC_DELAYED_COMP,
diff --git a/drivers/infiniband/hw/hfi1/rc.c b/drivers/infiniband/hw/hfi1/rc.c
index eeca08d..513a8aa 100644
--- a/drivers/infiniband/hw/hfi1/rc.c
+++ b/drivers/infiniband/hw/hfi1/rc.c
@@ -595,11 +595,8 @@ int hfi1_make_rc_req(struct rvt_qp *qp, struct hfi1_pkt_state *ps)
 		case IB_WR_SEND_WITH_IMM:
 		case IB_WR_SEND_WITH_INV:
 			/* If no credit, return. */
-			if (!(qp->s_flags & RVT_S_UNLIMITED_CREDIT) &&
-			    rvt_cmp_msn(wqe->ssn, qp->s_lsn + 1) > 0) {
-				qp->s_flags |= RVT_S_WAIT_SSN_CREDIT;
+			if (!rvt_rc_credit_avail(qp, wqe))
 				goto bail;
-			}
 			if (len > pmtu) {
 				qp->s_state = OP(SEND_FIRST);
 				len = pmtu;
@@ -632,11 +629,8 @@ int hfi1_make_rc_req(struct rvt_qp *qp, struct hfi1_pkt_state *ps)
 			goto no_flow_control;
 		case IB_WR_RDMA_WRITE_WITH_IMM:
 			/* If no credit, return. */
-			if (!(qp->s_flags & RVT_S_UNLIMITED_CREDIT) &&
-			    rvt_cmp_msn(wqe->ssn, qp->s_lsn + 1) > 0) {
-				qp->s_flags |= RVT_S_WAIT_SSN_CREDIT;
+			if (!rvt_rc_credit_avail(qp, wqe))
 				goto bail;
-			}
 no_flow_control:
 			put_ib_reth_vaddr(
 				wqe->rdma_wr.remote_addr,
diff --git a/drivers/infiniband/hw/qib/qib_rc.c b/drivers/infiniband/hw/qib/qib_rc.c
index 1d5e2d4..aaf7438 100644
--- a/drivers/infiniband/hw/qib/qib_rc.c
+++ b/drivers/infiniband/hw/qib/qib_rc.c
@@ -313,11 +313,8 @@ int qib_make_rc_req(struct rvt_qp *qp, unsigned long *flags)
 		case IB_WR_SEND:
 		case IB_WR_SEND_WITH_IMM:
 			/* If no credit, return. */
-			if (!(qp->s_flags & RVT_S_UNLIMITED_CREDIT) &&
-			    rvt_cmp_msn(wqe->ssn, qp->s_lsn + 1) > 0) {
-				qp->s_flags |= RVT_S_WAIT_SSN_CREDIT;
+			if (!rvt_rc_credit_avail(qp, wqe))
 				goto bail;
-			}
 			if (len > pmtu) {
 				qp->s_state = OP(SEND_FIRST);
 				len = pmtu;
@@ -344,11 +341,8 @@ int qib_make_rc_req(struct rvt_qp *qp, unsigned long *flags)
 			goto no_flow_control;
 		case IB_WR_RDMA_WRITE_WITH_IMM:
 			/* If no credit, return. */
-			if (!(qp->s_flags & RVT_S_UNLIMITED_CREDIT) &&
-			    rvt_cmp_msn(wqe->ssn, qp->s_lsn + 1) > 0) {
-				qp->s_flags |= RVT_S_WAIT_SSN_CREDIT;
+			if (!rvt_rc_credit_avail(qp, wqe))
 				goto bail;
-			}
 no_flow_control:
 			ohdr->u.rc.reth.vaddr =
 				cpu_to_be64(wqe->rdma_wr.remote_addr);
diff --git a/drivers/infiniband/hw/qib/qib_sysfs.c b/drivers/infiniband/hw/qib/qib_sysfs.c
index 905206a..3926be7 100644
--- a/drivers/infiniband/hw/qib/qib_sysfs.c
+++ b/drivers/infiniband/hw/qib/qib_sysfs.c
@@ -436,6 +436,7 @@ struct qib_diagc_attr {
 QIB_DIAGC_ATTR(unaligned);
 QIB_DIAGC_ATTR(rc_dupreq);
 QIB_DIAGC_ATTR(rc_seqnak);
+QIB_DIAGC_ATTR(rc_crwaits);
 
 static struct attribute *diagc_default_attributes[] = {
 	&qib_diagc_attr_rc_resends.attr,
@@ -453,6 +454,7 @@ struct qib_diagc_attr {
 	&qib_diagc_attr_unaligned.attr,
 	&qib_diagc_attr_rc_dupreq.attr,
 	&qib_diagc_attr_rc_seqnak.attr,
+	&qib_diagc_attr_rc_crwaits.attr,
 	NULL
 };
 
diff --git a/include/rdma/rdma_vt.h b/include/rdma/rdma_vt.h
index 525848e..ac5a943 100644
--- a/include/rdma/rdma_vt.h
+++ b/include/rdma/rdma_vt.h
@@ -116,6 +116,7 @@ struct rvt_ibport {
 	u64 n_unaligned;
 	u64 n_rc_dupreq;
 	u64 n_rc_seqnak;
+	u64 n_rc_crwaits;
 	u16 pkey_violations;
 	u16 qkey_violations;
 	u16 mkey_violations;
diff --git a/include/rdma/rdmavt_qp.h b/include/rdma/rdmavt_qp.h
index e06c77d..b550ae8 100644
--- a/include/rdma/rdmavt_qp.h
+++ b/include/rdma/rdmavt_qp.h
@@ -973,6 +973,41 @@ static inline void rvt_free_rq(struct rvt_rq *rq)
 	rq->wq = NULL;
 }
 
+/**
+ * rvt_to_iport - Get the ibport pointer
+ * @qp: the qp pointer
+ *
+ * This function returns the ibport pointer from the qp pointer.
+ */
+static inline struct rvt_ibport *rvt_to_iport(struct rvt_qp *qp)
+{
+	struct rvt_dev_info *rdi = ib_to_rvt(qp->ibqp.device);
+
+	return rdi->ports[qp->port_num - 1];
+}
+
+/**
+ * rvt_rc_credit_avail - Check if there are enough RC credits for the request
+ * @qp: the qp
+ * @wqe: the request
+ *
+ * This function returns false when there are not enough credits for the given
+ * request and true otherwise.
+ */
+static inline bool rvt_rc_credit_avail(struct rvt_qp *qp, struct rvt_swqe *wqe)
+{
+	lockdep_assert_held(&qp->s_lock);
+	if (!(qp->s_flags & RVT_S_UNLIMITED_CREDIT) &&
+	    rvt_cmp_msn(wqe->ssn, qp->s_lsn + 1) > 0) {
+		struct rvt_ibport *rvp = rvt_to_iport(qp);
+
+		qp->s_flags |= RVT_S_WAIT_SSN_CREDIT;
+		rvp->n_rc_crwaits++;
+		return false;
+	}
+	return true;
+}
+
 struct rvt_qp_iter *rvt_qp_iter_init(struct rvt_dev_info *rdi,
 				     u64 v,
 				     void (*cb)(struct rvt_qp *qp, u64 v));

