Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3596E5A360
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Jun 2019 20:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726056AbfF1SWO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Jun 2019 14:22:14 -0400
Received: from mga14.intel.com ([192.55.52.115]:7581 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbfF1SWO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 28 Jun 2019 14:22:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jun 2019 11:22:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,428,1557212400"; 
   d="scan'208";a="164735153"
Received: from sedona.ch.intel.com ([10.2.136.157])
  by fmsmga007.fm.intel.com with ESMTP; 28 Jun 2019 11:22:13 -0700
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id x5SIMCFB061094;
        Fri, 28 Jun 2019 11:22:12 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id x5SIMB1t067943;
        Fri, 28 Jun 2019 14:22:11 -0400
Subject: [PATCH for-next v2 4/9] IB/{rdmavt, hfi1,
 qib}: Add helpers to hide SWQE WR details
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>
Date:   Fri, 28 Jun 2019 14:22:11 -0400
Message-ID: <20190628182211.67786.25428.stgit@awfm-01.aw.intel.com>
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

From: Michael J. Ruhl <michael.j.ruhl@intel.com>

Add some helper functions to hide struct rvt_swqe details.

Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
---
 drivers/infiniband/hw/hfi1/qp.c    |    2 +
 drivers/infiniband/hw/hfi1/ud.c    |   29 +++++++++++----------
 drivers/infiniband/hw/qib/qib_qp.c |    2 +
 drivers/infiniband/hw/qib/qib_ud.c |   21 ++++++++-------
 drivers/infiniband/sw/rdmavt/qp.c  |    2 +
 include/rdma/rdmavt_qp.h           |   50 ++++++++++++++++++++++++++++++++++++
 6 files changed, 79 insertions(+), 27 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/qp.c b/drivers/infiniband/hw/hfi1/qp.c
index a84b44a..f8e733a 100644
--- a/drivers/infiniband/hw/hfi1/qp.c
+++ b/drivers/infiniband/hw/hfi1/qp.c
@@ -348,7 +348,7 @@ int hfi1_setup_wqe(struct rvt_qp *qp, struct rvt_swqe *wqe, bool *call_send)
 		break;
 	case IB_QPT_GSI:
 	case IB_QPT_UD:
-		ah = ibah_to_rvtah(wqe->ud_wr.wr.ah);
+		ah = rvt_get_swqe_ah(wqe);
 		if (wqe->length > (1 << ah->log_pmtu))
 			return -EINVAL;
 		if (ibp->sl_to_sc[rdma_ah_get_sl(&ah->attr)] == 0xf)
diff --git a/drivers/infiniband/hw/hfi1/ud.c b/drivers/infiniband/hw/hfi1/ud.c
index f8e796e..e804af7 100644
--- a/drivers/infiniband/hw/hfi1/ud.c
+++ b/drivers/infiniband/hw/hfi1/ud.c
@@ -87,7 +87,7 @@ static void ud_loopback(struct rvt_qp *sqp, struct rvt_swqe *swqe)
 	rcu_read_lock();
 
 	qp = rvt_lookup_qpn(ib_to_rvt(sqp->ibqp.device), &ibp->rvp,
-			    swqe->ud_wr.wr.remote_qpn);
+			    rvt_get_swqe_remote_qpn(swqe));
 	if (!qp) {
 		ibp->rvp.n_pkt_drops++;
 		rcu_read_unlock();
@@ -105,7 +105,7 @@ static void ud_loopback(struct rvt_qp *sqp, struct rvt_swqe *swqe)
 		goto drop;
 	}
 
-	ah_attr = swqe->ud_wr.attr;
+	ah_attr = rvt_get_swqe_ah_attr(swqe);
 	ppd = ppd_from_ibp(ibp);
 
 	if (qp->ibqp.qp_num > 1) {
@@ -135,8 +135,8 @@ static void ud_loopback(struct rvt_qp *sqp, struct rvt_swqe *swqe)
 	if (qp->ibqp.qp_num) {
 		u32 qkey;
 
-		qkey = (int)swqe->ud_wr.wr.remote_qkey < 0 ?
-			sqp->qkey : swqe->ud_wr.wr.remote_qkey;
+		qkey = (int)rvt_get_swqe_remote_qkey(swqe) < 0 ?
+			sqp->qkey : rvt_get_swqe_remote_qkey(swqe);
 		if (unlikely(qkey != qp->qkey))
 			goto drop; /* silently drop per IBTA spec */
 	}
@@ -240,7 +240,7 @@ static void ud_loopback(struct rvt_qp *sqp, struct rvt_swqe *swqe)
 	if (qp->ibqp.qp_type == IB_QPT_GSI || qp->ibqp.qp_type == IB_QPT_SMI) {
 		if (sqp->ibqp.qp_type == IB_QPT_GSI ||
 		    sqp->ibqp.qp_type == IB_QPT_SMI)
-			wc.pkey_index = swqe->ud_wr.wr.pkey_index;
+			wc.pkey_index = rvt_get_swqe_pkey_index(swqe);
 		else
 			wc.pkey_index = sqp->s_pkey_index;
 	} else {
@@ -282,20 +282,21 @@ static void hfi1_make_bth_deth(struct rvt_qp *qp, struct rvt_swqe *wqe,
 		bth0 |= IB_BTH_SOLICITED;
 	bth0 |= extra_bytes << 20;
 	if (qp->ibqp.qp_type == IB_QPT_GSI || qp->ibqp.qp_type == IB_QPT_SMI)
-		*pkey = hfi1_get_pkey(ibp, wqe->ud_wr.wr.pkey_index);
+		*pkey = hfi1_get_pkey(ibp, rvt_get_swqe_pkey_index(wqe));
 	else
 		*pkey = hfi1_get_pkey(ibp, qp->s_pkey_index);
 	if (!bypass)
 		bth0 |= *pkey;
 	ohdr->bth[0] = cpu_to_be32(bth0);
-	ohdr->bth[1] = cpu_to_be32(wqe->ud_wr.wr.remote_qpn);
+	ohdr->bth[1] = cpu_to_be32(rvt_get_swqe_remote_qpn(wqe));
 	ohdr->bth[2] = cpu_to_be32(mask_psn(wqe->psn));
 	/*
 	 * Qkeys with the high order bit set mean use the
 	 * qkey from the QP context instead of the WR (see 10.2.5).
 	 */
-	ohdr->u.ud.deth[0] = cpu_to_be32((int)wqe->ud_wr.wr.remote_qkey < 0 ?
-					 qp->qkey : wqe->ud_wr.wr.remote_qkey);
+	ohdr->u.ud.deth[0] =
+		cpu_to_be32((int)rvt_get_swqe_remote_qkey(wqe) < 0 ? qp->qkey :
+			    rvt_get_swqe_remote_qkey(wqe));
 	ohdr->u.ud.deth[1] = cpu_to_be32(qp->ibqp.qp_num);
 }
 
@@ -315,7 +316,7 @@ void hfi1_make_ud_req_9B(struct rvt_qp *qp, struct hfi1_pkt_state *ps,
 
 	ibp = to_iport(qp->ibqp.device, qp->port_num);
 	ppd = ppd_from_ibp(ibp);
-	ah_attr = wqe->ud_wr.attr;
+	ah_attr = rvt_get_swqe_ah_attr(wqe);
 
 	extra_bytes = -wqe->length & 3;
 	nwords = ((wqe->length + extra_bytes) >> 2) + SIZE_OF_CRC;
@@ -379,7 +380,7 @@ void hfi1_make_ud_req_16B(struct rvt_qp *qp, struct hfi1_pkt_state *ps,
 	struct hfi1_pportdata *ppd;
 	struct hfi1_ibport *ibp;
 	u32 dlid, slid, nwords, extra_bytes;
-	u32 dest_qp = wqe->ud_wr.wr.remote_qpn;
+	u32 dest_qp = rvt_get_swqe_remote_qpn(wqe);
 	u32 src_qp = qp->ibqp.qp_num;
 	u16 len, pkey;
 	u8 l4, sc5;
@@ -387,7 +388,7 @@ void hfi1_make_ud_req_16B(struct rvt_qp *qp, struct hfi1_pkt_state *ps,
 
 	ibp = to_iport(qp->ibqp.device, qp->port_num);
 	ppd = ppd_from_ibp(ibp);
-	ah_attr = wqe->ud_wr.attr;
+	ah_attr = rvt_get_swqe_ah_attr(wqe);
 
 	/*
 	 * Build 16B Management Packet if either the destination
@@ -449,7 +450,7 @@ void hfi1_make_ud_req_16B(struct rvt_qp *qp, struct hfi1_pkt_state *ps,
 
 	if (is_mgmt) {
 		l4 = OPA_16B_L4_FM;
-		pkey = hfi1_get_pkey(ibp, wqe->ud_wr.wr.pkey_index);
+		pkey = hfi1_get_pkey(ibp, rvt_get_swqe_pkey_index(wqe));
 		hfi1_16B_set_qpn(&ps->s_txreq->phdr.hdr.opah.u.mgmt,
 				 dest_qp, src_qp);
 	} else {
@@ -514,7 +515,7 @@ int hfi1_make_ud_req(struct rvt_qp *qp, struct hfi1_pkt_state *ps)
 	/* Construct the header. */
 	ibp = to_iport(qp->ibqp.device, qp->port_num);
 	ppd = ppd_from_ibp(ibp);
-	ah_attr = wqe->ud_wr.attr;
+	ah_attr = rvt_get_swqe_ah_attr(wqe);
 	priv->hdr_type = hfi1_get_hdr_type(ppd->lid, ah_attr);
 	if ((!hfi1_check_mcast(rdma_ah_get_dlid(ah_attr))) ||
 	    (rdma_ah_get_dlid(ah_attr) == be32_to_cpu(OPA_LID_PERMISSIVE))) {
diff --git a/drivers/infiniband/hw/qib/qib_qp.c b/drivers/infiniband/hw/qib/qib_qp.c
index 0e1d0d6..8d0563e 100644
--- a/drivers/infiniband/hw/qib/qib_qp.c
+++ b/drivers/infiniband/hw/qib/qib_qp.c
@@ -398,7 +398,7 @@ int qib_check_send_wqe(struct rvt_qp *qp,
 	case IB_QPT_SMI:
 	case IB_QPT_GSI:
 	case IB_QPT_UD:
-		ah = ibah_to_rvtah(wqe->ud_wr.wr.ah);
+		ah = rvt_get_swqe_ah(wqe);
 		if (wqe->length > (1 << ah->log_pmtu))
 			return -EINVAL;
 		/* progress hint */
diff --git a/drivers/infiniband/hw/qib/qib_ud.c b/drivers/infiniband/hw/qib/qib_ud.c
index d8c2c968..93ca213 100644
--- a/drivers/infiniband/hw/qib/qib_ud.c
+++ b/drivers/infiniband/hw/qib/qib_ud.c
@@ -64,7 +64,7 @@ static void qib_ud_loopback(struct rvt_qp *sqp, struct rvt_swqe *swqe)
 	enum ib_qp_type sqptype, dqptype;
 
 	rcu_read_lock();
-	qp = rvt_lookup_qpn(rdi, &ibp->rvp, swqe->ud_wr.wr.remote_qpn);
+	qp = rvt_lookup_qpn(rdi, &ibp->rvp, rvt_get_swqe_remote_qpn(swqe));
 	if (!qp) {
 		ibp->rvp.n_pkt_drops++;
 		goto drop;
@@ -81,7 +81,7 @@ static void qib_ud_loopback(struct rvt_qp *sqp, struct rvt_swqe *swqe)
 		goto drop;
 	}
 
-	ah_attr = swqe->ud_wr.attr;
+	ah_attr = rvt_get_swqe_ah_attr(swqe);
 	ppd = ppd_from_ibp(ibp);
 
 	if (qp->ibqp.qp_num > 1) {
@@ -111,8 +111,8 @@ static void qib_ud_loopback(struct rvt_qp *sqp, struct rvt_swqe *swqe)
 	if (qp->ibqp.qp_num) {
 		u32 qkey;
 
-		qkey = (int)swqe->ud_wr.wr.remote_qkey < 0 ?
-			sqp->qkey : swqe->ud_wr.wr.remote_qkey;
+		qkey = (int)rvt_get_swqe_remote_qkey(swqe) < 0 ?
+			sqp->qkey : rvt_get_swqe_remote_qkey(swqe);
 		if (unlikely(qkey != qp->qkey))
 			goto drop;
 	}
@@ -204,7 +204,7 @@ static void qib_ud_loopback(struct rvt_qp *sqp, struct rvt_swqe *swqe)
 	wc.qp = &qp->ibqp;
 	wc.src_qp = sqp->ibqp.qp_num;
 	wc.pkey_index = qp->ibqp.qp_type == IB_QPT_GSI ?
-		swqe->ud_wr.wr.pkey_index : 0;
+		rvt_get_swqe_pkey_index(swqe) : 0;
 	wc.slid = ppd->lid | (rdma_ah_get_path_bits(ah_attr) &
 				((1 << ppd->lmc) - 1));
 	wc.sl = rdma_ah_get_sl(ah_attr);
@@ -271,7 +271,7 @@ int qib_make_ud_req(struct rvt_qp *qp, unsigned long *flags)
 	/* Construct the header. */
 	ibp = to_iport(qp->ibqp.device, qp->port_num);
 	ppd = ppd_from_ibp(ibp);
-	ah_attr = wqe->ud_wr.attr;
+	ah_attr = rvt_get_swqe_ah_attr(wqe);
 	if (rdma_ah_get_dlid(ah_attr) >= be16_to_cpu(IB_MULTICAST_LID_BASE)) {
 		if (rdma_ah_get_dlid(ah_attr) !=
 				be16_to_cpu(IB_LID_PERMISSIVE))
@@ -363,7 +363,7 @@ int qib_make_ud_req(struct rvt_qp *qp, unsigned long *flags)
 	bth0 |= extra_bytes << 20;
 	bth0 |= qp->ibqp.qp_type == IB_QPT_SMI ? QIB_DEFAULT_P_KEY :
 		qib_get_pkey(ibp, qp->ibqp.qp_type == IB_QPT_GSI ?
-			     wqe->ud_wr.wr.pkey_index : qp->s_pkey_index);
+			     rvt_get_swqe_pkey_index(wqe) : qp->s_pkey_index);
 	ohdr->bth[0] = cpu_to_be32(bth0);
 	/*
 	 * Use the multicast QP if the destination LID is a multicast LID.
@@ -372,14 +372,15 @@ int qib_make_ud_req(struct rvt_qp *qp, unsigned long *flags)
 			be16_to_cpu(IB_MULTICAST_LID_BASE) &&
 		rdma_ah_get_dlid(ah_attr) != be16_to_cpu(IB_LID_PERMISSIVE) ?
 		cpu_to_be32(QIB_MULTICAST_QPN) :
-		cpu_to_be32(wqe->ud_wr.wr.remote_qpn);
+		cpu_to_be32(rvt_get_swqe_remote_qpn(wqe));
 	ohdr->bth[2] = cpu_to_be32(wqe->psn & QIB_PSN_MASK);
 	/*
 	 * Qkeys with the high order bit set mean use the
 	 * qkey from the QP context instead of the WR (see 10.2.5).
 	 */
-	ohdr->u.ud.deth[0] = cpu_to_be32((int)wqe->ud_wr.wr.remote_qkey < 0 ?
-					 qp->qkey : wqe->ud_wr.wr.remote_qkey);
+	ohdr->u.ud.deth[0] =
+		cpu_to_be32((int)rvt_get_swqe_remote_qkey(wqe) < 0 ? qp->qkey :
+			    rvt_get_swqe_remote_qkey(wqe));
 	ohdr->u.ud.deth[1] = cpu_to_be32(qp->ibqp.qp_num);
 
 done:
diff --git a/drivers/infiniband/sw/rdmavt/qp.c b/drivers/infiniband/sw/rdmavt/qp.c
index de7d2ed..11b4d3c 100644
--- a/drivers/infiniband/sw/rdmavt/qp.c
+++ b/drivers/infiniband/sw/rdmavt/qp.c
@@ -2089,7 +2089,7 @@ static int rvt_post_one_wr(struct rvt_qp *qp,
 	 */
 	log_pmtu = qp->log_pmtu;
 	if (qp->allowed_ops == IB_OPCODE_UD) {
-		struct rvt_ah *ah = ibah_to_rvtah(wqe->ud_wr.wr.ah);
+		struct rvt_ah *ah = rvt_get_swqe_ah(wqe);
 
 		log_pmtu = ah->log_pmtu;
 		rdma_copy_ah_attr(wqe->ud_wr.attr, &ah->attr);
diff --git a/include/rdma/rdmavt_qp.h b/include/rdma/rdmavt_qp.h
index 9531de2..0eeea52 100644
--- a/include/rdma/rdmavt_qp.h
+++ b/include/rdma/rdmavt_qp.h
@@ -219,6 +219,56 @@ struct rvt_krwq {
 	struct rvt_rwqe wq[];
 };
 
+/*
+ * rvt_get_swqe_ah - Return the pointer to the struct rvt_ah
+ * @swqe: valid Send WQE
+ *
+ */
+static inline struct rvt_ah *rvt_get_swqe_ah(struct rvt_swqe *swqe)
+{
+	return ibah_to_rvtah(swqe->ud_wr.wr.ah);
+}
+
+/**
+ * rvt_get_swqe_ah_attr - Return the cached ah attribute information
+ * @swqe: valid Send WQE
+ *
+ */
+static inline struct rdma_ah_attr *rvt_get_swqe_ah_attr(struct rvt_swqe *swqe)
+{
+	return swqe->ud_wr.attr;
+}
+
+/**
+ * rvt_get_swqe_remote_qpn - Access the remote QPN value
+ * @swqe: valid Send WQE
+ *
+ */
+static inline u32 rvt_get_swqe_remote_qpn(struct rvt_swqe *swqe)
+{
+	return swqe->ud_wr.wr.remote_qpn;
+}
+
+/**
+ * rvt_get_swqe_remote_qkey - Acces the remote qkey value
+ * @swqe: valid Send WQE
+ *
+ */
+static inline u32 rvt_get_swqe_remote_qkey(struct rvt_swqe *swqe)
+{
+	return swqe->ud_wr.wr.remote_qkey;
+}
+
+/**
+ * rvt_get_swqe_pkey_index - Access the pkey index
+ * @swqe: valid Send WQE
+ *
+ */
+static inline u16 rvt_get_swqe_pkey_index(struct rvt_swqe *swqe)
+{
+	return swqe->ud_wr.wr.pkey_index;
+}
+
 struct rvt_rq {
 	struct rvt_rwq *wq;
 	struct rvt_krwq *kwq;

