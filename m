Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1DF5A35E
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Jun 2019 20:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfF1SWL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Jun 2019 14:22:11 -0400
Received: from mga17.intel.com ([192.55.52.151]:32055 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbfF1SWL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 28 Jun 2019 14:22:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jun 2019 11:22:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,428,1557212400"; 
   d="scan'208";a="185719439"
Received: from sedona.ch.intel.com ([10.2.136.157])
  by fmsmga004.fm.intel.com with ESMTP; 28 Jun 2019 11:22:07 -0700
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id x5SIM62x061071;
        Fri, 28 Jun 2019 11:22:06 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id x5SIM5mn067934;
        Fri, 28 Jun 2019 14:22:05 -0400
Subject: [PATCH for-next v2 3/9] IB/{rdmavt, hfi1,
 qib}: Remove AH refcount for UD QPs
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>
Date:   Fri, 28 Jun 2019 14:22:04 -0400
Message-ID: <20190628182204.67786.95900.stgit@awfm-01.aw.intel.com>
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

Historically rdmavt destroy_ah() has returned an -EBUSY when the AH
has a non-zero reference count.  IBTA 11.2.2 notes no such return
value or error case:

	Output Modifiers:
	- Verb results:
	- Operation completed successfully.
	- Invalid HCA handle.
	- Invalid address handle.

ULPs never test for this error and this will leak memory.

The reference count exists to allow for driver independent progress
mechanisms to process UD SWQEs in parallel with post sends.  The SWQE
will hold a reference count until the UD SWQE completes and then
drops the reference.

Fix by removing need to reference count the AH.  Add a UD specific
allocation to each SWQE entry to cache the necessary information for
independent progress.  Copy the information during the post send
processing.

Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
---
 drivers/infiniband/hw/hfi1/qp.c    |    4 +-
 drivers/infiniband/hw/hfi1/ud.c    |   30 +++++++++----------
 drivers/infiniband/hw/qib/qib_qp.c |    4 +-
 drivers/infiniband/hw/qib/qib_ud.c |   21 +++++++------
 drivers/infiniband/sw/rdmavt/ah.c  |    6 +---
 drivers/infiniband/sw/rdmavt/qp.c  |   58 ++++++++++++++++++++++++++++++++++--
 include/rdma/rdma_vt.h             |    3 +-
 include/rdma/rdmavt_qp.h           |   22 ++++++++++++--
 8 files changed, 106 insertions(+), 42 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/qp.c b/drivers/infiniband/hw/hfi1/qp.c
index 41261e7..a84b44a 100644
--- a/drivers/infiniband/hw/hfi1/qp.c
+++ b/drivers/infiniband/hw/hfi1/qp.c
@@ -1,5 +1,5 @@
 /*
- * Copyright(c) 2015 - 2018 Intel Corporation.
+ * Copyright(c) 2015 - 2019 Intel Corporation.
  *
  * This file is provided under a dual BSD/GPLv2 license.  When using or
  * redistributing this file, you may do so under either license.
@@ -348,7 +348,7 @@ int hfi1_setup_wqe(struct rvt_qp *qp, struct rvt_swqe *wqe, bool *call_send)
 		break;
 	case IB_QPT_GSI:
 	case IB_QPT_UD:
-		ah = ibah_to_rvtah(wqe->ud_wr.ah);
+		ah = ibah_to_rvtah(wqe->ud_wr.wr.ah);
 		if (wqe->length > (1 << ah->log_pmtu))
 			return -EINVAL;
 		if (ibp->sl_to_sc[rdma_ah_get_sl(&ah->attr)] == 0xf)
diff --git a/drivers/infiniband/hw/hfi1/ud.c b/drivers/infiniband/hw/hfi1/ud.c
index e16d499..f8e796e 100644
--- a/drivers/infiniband/hw/hfi1/ud.c
+++ b/drivers/infiniband/hw/hfi1/ud.c
@@ -1,5 +1,5 @@
 /*
- * Copyright(c) 2015 - 2018 Intel Corporation.
+ * Copyright(c) 2015 - 2019 Intel Corporation.
  *
  * This file is provided under a dual BSD/GPLv2 license.  When using or
  * redistributing this file, you may do so under either license.
@@ -87,7 +87,7 @@ static void ud_loopback(struct rvt_qp *sqp, struct rvt_swqe *swqe)
 	rcu_read_lock();
 
 	qp = rvt_lookup_qpn(ib_to_rvt(sqp->ibqp.device), &ibp->rvp,
-			    swqe->ud_wr.remote_qpn);
+			    swqe->ud_wr.wr.remote_qpn);
 	if (!qp) {
 		ibp->rvp.n_pkt_drops++;
 		rcu_read_unlock();
@@ -105,7 +105,7 @@ static void ud_loopback(struct rvt_qp *sqp, struct rvt_swqe *swqe)
 		goto drop;
 	}
 
-	ah_attr = &ibah_to_rvtah(swqe->ud_wr.ah)->attr;
+	ah_attr = swqe->ud_wr.attr;
 	ppd = ppd_from_ibp(ibp);
 
 	if (qp->ibqp.qp_num > 1) {
@@ -135,8 +135,8 @@ static void ud_loopback(struct rvt_qp *sqp, struct rvt_swqe *swqe)
 	if (qp->ibqp.qp_num) {
 		u32 qkey;
 
-		qkey = (int)swqe->ud_wr.remote_qkey < 0 ?
-			sqp->qkey : swqe->ud_wr.remote_qkey;
+		qkey = (int)swqe->ud_wr.wr.remote_qkey < 0 ?
+			sqp->qkey : swqe->ud_wr.wr.remote_qkey;
 		if (unlikely(qkey != qp->qkey))
 			goto drop; /* silently drop per IBTA spec */
 	}
@@ -240,7 +240,7 @@ static void ud_loopback(struct rvt_qp *sqp, struct rvt_swqe *swqe)
 	if (qp->ibqp.qp_type == IB_QPT_GSI || qp->ibqp.qp_type == IB_QPT_SMI) {
 		if (sqp->ibqp.qp_type == IB_QPT_GSI ||
 		    sqp->ibqp.qp_type == IB_QPT_SMI)
-			wc.pkey_index = swqe->ud_wr.pkey_index;
+			wc.pkey_index = swqe->ud_wr.wr.pkey_index;
 		else
 			wc.pkey_index = sqp->s_pkey_index;
 	} else {
@@ -282,20 +282,20 @@ static void hfi1_make_bth_deth(struct rvt_qp *qp, struct rvt_swqe *wqe,
 		bth0 |= IB_BTH_SOLICITED;
 	bth0 |= extra_bytes << 20;
 	if (qp->ibqp.qp_type == IB_QPT_GSI || qp->ibqp.qp_type == IB_QPT_SMI)
-		*pkey = hfi1_get_pkey(ibp, wqe->ud_wr.pkey_index);
+		*pkey = hfi1_get_pkey(ibp, wqe->ud_wr.wr.pkey_index);
 	else
 		*pkey = hfi1_get_pkey(ibp, qp->s_pkey_index);
 	if (!bypass)
 		bth0 |= *pkey;
 	ohdr->bth[0] = cpu_to_be32(bth0);
-	ohdr->bth[1] = cpu_to_be32(wqe->ud_wr.remote_qpn);
+	ohdr->bth[1] = cpu_to_be32(wqe->ud_wr.wr.remote_qpn);
 	ohdr->bth[2] = cpu_to_be32(mask_psn(wqe->psn));
 	/*
 	 * Qkeys with the high order bit set mean use the
 	 * qkey from the QP context instead of the WR (see 10.2.5).
 	 */
-	ohdr->u.ud.deth[0] = cpu_to_be32((int)wqe->ud_wr.remote_qkey < 0 ?
-					 qp->qkey : wqe->ud_wr.remote_qkey);
+	ohdr->u.ud.deth[0] = cpu_to_be32((int)wqe->ud_wr.wr.remote_qkey < 0 ?
+					 qp->qkey : wqe->ud_wr.wr.remote_qkey);
 	ohdr->u.ud.deth[1] = cpu_to_be32(qp->ibqp.qp_num);
 }
 
@@ -315,7 +315,7 @@ void hfi1_make_ud_req_9B(struct rvt_qp *qp, struct hfi1_pkt_state *ps,
 
 	ibp = to_iport(qp->ibqp.device, qp->port_num);
 	ppd = ppd_from_ibp(ibp);
-	ah_attr = &ibah_to_rvtah(wqe->ud_wr.ah)->attr;
+	ah_attr = wqe->ud_wr.attr;
 
 	extra_bytes = -wqe->length & 3;
 	nwords = ((wqe->length + extra_bytes) >> 2) + SIZE_OF_CRC;
@@ -379,7 +379,7 @@ void hfi1_make_ud_req_16B(struct rvt_qp *qp, struct hfi1_pkt_state *ps,
 	struct hfi1_pportdata *ppd;
 	struct hfi1_ibport *ibp;
 	u32 dlid, slid, nwords, extra_bytes;
-	u32 dest_qp = wqe->ud_wr.remote_qpn;
+	u32 dest_qp = wqe->ud_wr.wr.remote_qpn;
 	u32 src_qp = qp->ibqp.qp_num;
 	u16 len, pkey;
 	u8 l4, sc5;
@@ -387,7 +387,7 @@ void hfi1_make_ud_req_16B(struct rvt_qp *qp, struct hfi1_pkt_state *ps,
 
 	ibp = to_iport(qp->ibqp.device, qp->port_num);
 	ppd = ppd_from_ibp(ibp);
-	ah_attr = &ibah_to_rvtah(wqe->ud_wr.ah)->attr;
+	ah_attr = wqe->ud_wr.attr;
 
 	/*
 	 * Build 16B Management Packet if either the destination
@@ -449,7 +449,7 @@ void hfi1_make_ud_req_16B(struct rvt_qp *qp, struct hfi1_pkt_state *ps,
 
 	if (is_mgmt) {
 		l4 = OPA_16B_L4_FM;
-		pkey = hfi1_get_pkey(ibp, wqe->ud_wr.pkey_index);
+		pkey = hfi1_get_pkey(ibp, wqe->ud_wr.wr.pkey_index);
 		hfi1_16B_set_qpn(&ps->s_txreq->phdr.hdr.opah.u.mgmt,
 				 dest_qp, src_qp);
 	} else {
@@ -514,7 +514,7 @@ int hfi1_make_ud_req(struct rvt_qp *qp, struct hfi1_pkt_state *ps)
 	/* Construct the header. */
 	ibp = to_iport(qp->ibqp.device, qp->port_num);
 	ppd = ppd_from_ibp(ibp);
-	ah_attr = &ibah_to_rvtah(wqe->ud_wr.ah)->attr;
+	ah_attr = wqe->ud_wr.attr;
 	priv->hdr_type = hfi1_get_hdr_type(ppd->lid, ah_attr);
 	if ((!hfi1_check_mcast(rdma_ah_get_dlid(ah_attr))) ||
 	    (rdma_ah_get_dlid(ah_attr) == be32_to_cpu(OPA_LID_PERMISSIVE))) {
diff --git a/drivers/infiniband/hw/qib/qib_qp.c b/drivers/infiniband/hw/qib/qib_qp.c
index a81905d..0e1d0d6 100644
--- a/drivers/infiniband/hw/qib/qib_qp.c
+++ b/drivers/infiniband/hw/qib/qib_qp.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2012 - 2017 Intel Corporation.  All rights reserved.
+ * Copyright (c) 2012 - 2019 Intel Corporation.  All rights reserved.
  * Copyright (c) 2006 - 2012 QLogic Corporation.  * All rights reserved.
  * Copyright (c) 2005, 2006 PathScale, Inc. All rights reserved.
  *
@@ -398,7 +398,7 @@ int qib_check_send_wqe(struct rvt_qp *qp,
 	case IB_QPT_SMI:
 	case IB_QPT_GSI:
 	case IB_QPT_UD:
-		ah = ibah_to_rvtah(wqe->ud_wr.ah);
+		ah = ibah_to_rvtah(wqe->ud_wr.wr.ah);
 		if (wqe->length > (1 << ah->log_pmtu))
 			return -EINVAL;
 		/* progress hint */
diff --git a/drivers/infiniband/hw/qib/qib_ud.c b/drivers/infiniband/hw/qib/qib_ud.c
index 32ad0b6..d8c2c968 100644
--- a/drivers/infiniband/hw/qib/qib_ud.c
+++ b/drivers/infiniband/hw/qib/qib_ud.c
@@ -1,4 +1,5 @@
 /*
+ * Copyright (c) 2012 - 2019 Intel Corporation.  All rights reserved.
  * Copyright (c) 2006, 2007, 2008, 2009 QLogic Corporation. All rights reserved.
  * Copyright (c) 2005, 2006 PathScale, Inc. All rights reserved.
  *
@@ -63,7 +64,7 @@ static void qib_ud_loopback(struct rvt_qp *sqp, struct rvt_swqe *swqe)
 	enum ib_qp_type sqptype, dqptype;
 
 	rcu_read_lock();
-	qp = rvt_lookup_qpn(rdi, &ibp->rvp, swqe->ud_wr.remote_qpn);
+	qp = rvt_lookup_qpn(rdi, &ibp->rvp, swqe->ud_wr.wr.remote_qpn);
 	if (!qp) {
 		ibp->rvp.n_pkt_drops++;
 		goto drop;
@@ -80,7 +81,7 @@ static void qib_ud_loopback(struct rvt_qp *sqp, struct rvt_swqe *swqe)
 		goto drop;
 	}
 
-	ah_attr = &ibah_to_rvtah(swqe->ud_wr.ah)->attr;
+	ah_attr = swqe->ud_wr.attr;
 	ppd = ppd_from_ibp(ibp);
 
 	if (qp->ibqp.qp_num > 1) {
@@ -110,8 +111,8 @@ static void qib_ud_loopback(struct rvt_qp *sqp, struct rvt_swqe *swqe)
 	if (qp->ibqp.qp_num) {
 		u32 qkey;
 
-		qkey = (int)swqe->ud_wr.remote_qkey < 0 ?
-			sqp->qkey : swqe->ud_wr.remote_qkey;
+		qkey = (int)swqe->ud_wr.wr.remote_qkey < 0 ?
+			sqp->qkey : swqe->ud_wr.wr.remote_qkey;
 		if (unlikely(qkey != qp->qkey))
 			goto drop;
 	}
@@ -203,7 +204,7 @@ static void qib_ud_loopback(struct rvt_qp *sqp, struct rvt_swqe *swqe)
 	wc.qp = &qp->ibqp;
 	wc.src_qp = sqp->ibqp.qp_num;
 	wc.pkey_index = qp->ibqp.qp_type == IB_QPT_GSI ?
-		swqe->ud_wr.pkey_index : 0;
+		swqe->ud_wr.wr.pkey_index : 0;
 	wc.slid = ppd->lid | (rdma_ah_get_path_bits(ah_attr) &
 				((1 << ppd->lmc) - 1));
 	wc.sl = rdma_ah_get_sl(ah_attr);
@@ -270,7 +271,7 @@ int qib_make_ud_req(struct rvt_qp *qp, unsigned long *flags)
 	/* Construct the header. */
 	ibp = to_iport(qp->ibqp.device, qp->port_num);
 	ppd = ppd_from_ibp(ibp);
-	ah_attr = &ibah_to_rvtah(wqe->ud_wr.ah)->attr;
+	ah_attr = wqe->ud_wr.attr;
 	if (rdma_ah_get_dlid(ah_attr) >= be16_to_cpu(IB_MULTICAST_LID_BASE)) {
 		if (rdma_ah_get_dlid(ah_attr) !=
 				be16_to_cpu(IB_LID_PERMISSIVE))
@@ -362,7 +363,7 @@ int qib_make_ud_req(struct rvt_qp *qp, unsigned long *flags)
 	bth0 |= extra_bytes << 20;
 	bth0 |= qp->ibqp.qp_type == IB_QPT_SMI ? QIB_DEFAULT_P_KEY :
 		qib_get_pkey(ibp, qp->ibqp.qp_type == IB_QPT_GSI ?
-			     wqe->ud_wr.pkey_index : qp->s_pkey_index);
+			     wqe->ud_wr.wr.pkey_index : qp->s_pkey_index);
 	ohdr->bth[0] = cpu_to_be32(bth0);
 	/*
 	 * Use the multicast QP if the destination LID is a multicast LID.
@@ -371,14 +372,14 @@ int qib_make_ud_req(struct rvt_qp *qp, unsigned long *flags)
 			be16_to_cpu(IB_MULTICAST_LID_BASE) &&
 		rdma_ah_get_dlid(ah_attr) != be16_to_cpu(IB_LID_PERMISSIVE) ?
 		cpu_to_be32(QIB_MULTICAST_QPN) :
-		cpu_to_be32(wqe->ud_wr.remote_qpn);
+		cpu_to_be32(wqe->ud_wr.wr.remote_qpn);
 	ohdr->bth[2] = cpu_to_be32(wqe->psn & QIB_PSN_MASK);
 	/*
 	 * Qkeys with the high order bit set mean use the
 	 * qkey from the QP context instead of the WR (see 10.2.5).
 	 */
-	ohdr->u.ud.deth[0] = cpu_to_be32((int)wqe->ud_wr.remote_qkey < 0 ?
-					 qp->qkey : wqe->ud_wr.remote_qkey);
+	ohdr->u.ud.deth[0] = cpu_to_be32((int)wqe->ud_wr.wr.remote_qkey < 0 ?
+					 qp->qkey : wqe->ud_wr.wr.remote_qkey);
 	ohdr->u.ud.deth[1] = cpu_to_be32(qp->ibqp.qp_num);
 
 done:
diff --git a/drivers/infiniband/sw/rdmavt/ah.c b/drivers/infiniband/sw/rdmavt/ah.c
index 0e147b3..fe99da0 100644
--- a/drivers/infiniband/sw/rdmavt/ah.c
+++ b/drivers/infiniband/sw/rdmavt/ah.c
@@ -1,5 +1,5 @@
 /*
- * Copyright(c) 2016 Intel Corporation.
+ * Copyright(c) 2016 - 2019 Intel Corporation.
  *
  * This file is provided under a dual BSD/GPLv2 license.  When using or
  * redistributing this file, you may do so under either license.
@@ -119,8 +119,6 @@ int rvt_create_ah(struct ib_ah *ibah, struct rdma_ah_attr *ah_attr,
 
 	rdma_copy_ah_attr(&ah->attr, ah_attr);
 
-	atomic_set(&ah->refcount, 0);
-
 	if (dev->driver_f.notify_new_ah)
 		dev->driver_f.notify_new_ah(ibah->device, ah_attr, ah);
 
@@ -141,8 +139,6 @@ void rvt_destroy_ah(struct ib_ah *ibah, u32 destroy_flags)
 	struct rvt_ah *ah = ibah_to_rvtah(ibah);
 	unsigned long flags;
 
-	WARN_ON_ONCE(atomic_read(&ah->refcount));
-
 	spin_lock_irqsave(&dev->n_ahs_lock, flags);
 	dev->n_ahs_allocated--;
 	spin_unlock_irqrestore(&dev->n_ahs_lock, flags);
diff --git a/drivers/infiniband/sw/rdmavt/qp.c b/drivers/infiniband/sw/rdmavt/qp.c
index b9035d9..de7d2ed 100644
--- a/drivers/infiniband/sw/rdmavt/qp.c
+++ b/drivers/infiniband/sw/rdmavt/qp.c
@@ -979,6 +979,51 @@ static u8 get_allowed_ops(enum ib_qp_type type)
 }
 
 /**
+ * free_ud_wq_attr - Clean up AH attribute cache for UD QPs
+ * @qp: Valid QP with allowed_ops set
+ *
+ * The rvt_swqe data structure being used is a union, so this is
+ * only valid for UD QPs.
+ */
+static void free_ud_wq_attr(struct rvt_qp *qp)
+{
+	struct rvt_swqe *wqe;
+	int i;
+
+	for (i = 0; qp->allowed_ops == IB_OPCODE_UD && i < qp->s_size; i++) {
+		wqe = rvt_get_swqe_ptr(qp, i);
+		kfree(wqe->ud_wr.attr);
+		wqe->ud_wr.attr = NULL;
+	}
+}
+
+/**
+ * alloc_ud_wq_attr - AH attribute cache for UD QPs
+ * @qp: Valid QP with allowed_ops set
+ * @node: Numa node for allocation
+ *
+ * The rvt_swqe data structure being used is a union, so this is
+ * only valid for UD QPs.
+ */
+static int alloc_ud_wq_attr(struct rvt_qp *qp, int node)
+{
+	struct rvt_swqe *wqe;
+	int i;
+
+	for (i = 0; qp->allowed_ops == IB_OPCODE_UD && i < qp->s_size; i++) {
+		wqe = rvt_get_swqe_ptr(qp, i);
+		wqe->ud_wr.attr = kzalloc_node(sizeof(*wqe->ud_wr.attr),
+					       GFP_KERNEL, node);
+		if (!wqe->ud_wr.attr) {
+			free_ud_wq_attr(qp);
+			return -ENOMEM;
+		}
+	}
+
+	return 0;
+}
+
+/**
  * rvt_create_qp - create a queue pair for a device
  * @ibpd: the protection domain who's device we create the queue pair for
  * @init_attr: the attributes of the queue pair
@@ -1124,6 +1169,11 @@ struct ib_qp *rvt_create_qp(struct ib_pd *ibpd,
 		qp->s_max_sge = init_attr->cap.max_send_sge;
 		if (init_attr->sq_sig_type == IB_SIGNAL_REQ_WR)
 			qp->s_flags = RVT_S_SIGNAL_REQ_WR;
+		err = alloc_ud_wq_attr(qp, rdi->dparms.node);
+		if (err) {
+			ret = (ERR_PTR(err));
+			goto bail_driver_priv;
+		}
 
 		err = alloc_qpn(rdi, &rdi->qp_dev->qpn_table,
 				init_attr->qp_type,
@@ -1227,6 +1277,7 @@ struct ib_qp *rvt_create_qp(struct ib_pd *ibpd,
 
 bail_rq_wq:
 	rvt_free_rq(&qp->r_rq);
+	free_ud_wq_attr(qp);
 
 bail_driver_priv:
 	rdi->driver_f.qp_priv_free(rdi, qp);
@@ -1671,6 +1722,7 @@ int rvt_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 	kfree(qp->s_ack_queue);
 	rdma_destroy_ah_attr(&qp->remote_ah_attr);
 	rdma_destroy_ah_attr(&qp->alt_ah_attr);
+	free_ud_wq_attr(qp);
 	vfree(qp->s_wq);
 	kfree(qp);
 	return 0;
@@ -2037,10 +2089,10 @@ static int rvt_post_one_wr(struct rvt_qp *qp,
 	 */
 	log_pmtu = qp->log_pmtu;
 	if (qp->allowed_ops == IB_OPCODE_UD) {
-		struct rvt_ah *ah = ibah_to_rvtah(wqe->ud_wr.ah);
+		struct rvt_ah *ah = ibah_to_rvtah(wqe->ud_wr.wr.ah);
 
 		log_pmtu = ah->log_pmtu;
-		atomic_inc(&ibah_to_rvtah(ud_wr(wr)->ah)->refcount);
+		rdma_copy_ah_attr(wqe->ud_wr.attr, &ah->attr);
 	}
 
 	if (rdi->post_parms[wr->opcode].flags & RVT_OPERATION_LOCAL) {
@@ -2085,7 +2137,7 @@ static int rvt_post_one_wr(struct rvt_qp *qp,
 
 bail_inval_free_ref:
 	if (qp->allowed_ops == IB_OPCODE_UD)
-		atomic_dec(&ibah_to_rvtah(ud_wr(wr)->ah)->refcount);
+		rdma_destroy_ah_attr(wqe->ud_wr.attr);
 bail_inval_free:
 	/* release mr holds */
 	while (j) {
diff --git a/include/rdma/rdma_vt.h b/include/rdma/rdma_vt.h
index 997f426..525848e 100644
--- a/include/rdma/rdma_vt.h
+++ b/include/rdma/rdma_vt.h
@@ -2,7 +2,7 @@
 #define DEF_RDMA_VT_H
 
 /*
- * Copyright(c) 2016 - 2018 Intel Corporation.
+ * Copyright(c) 2016 - 2019 Intel Corporation.
  *
  * This file is provided under a dual BSD/GPLv2 license.  When using or
  * redistributing this file, you may do so under either license.
@@ -202,7 +202,6 @@ struct rvt_pd {
 struct rvt_ah {
 	struct ib_ah ibah;
 	struct rdma_ah_attr attr;
-	atomic_t refcount;
 	u8 vl;
 	u8 log_pmtu;
 };
diff --git a/include/rdma/rdmavt_qp.h b/include/rdma/rdmavt_qp.h
index e4be869..9531de2 100644
--- a/include/rdma/rdmavt_qp.h
+++ b/include/rdma/rdmavt_qp.h
@@ -2,7 +2,7 @@
 #define DEF_RDMAVT_INCQP_H
 
 /*
- * Copyright(c) 2016 - 2018 Intel Corporation.
+ * Copyright(c) 2016 - 2019 Intel Corporation.
  *
  * This file is provided under a dual BSD/GPLv2 license.  When using or
  * redistributing this file, you may do so under either license.
@@ -157,6 +157,22 @@
 #define RVT_SEND_RESERVE_USED           IB_SEND_RESERVED_START
 #define RVT_SEND_COMPLETION_ONLY	(IB_SEND_RESERVED_START << 1)
 
+/**
+ * rvt_ud_wr - IB UD work plus AH cache
+ * @wr: valid IB work request
+ * @attr: pointer to an allocated AH attribute
+ *
+ * Special case the UD WR so we can keep track of the AH attributes.
+ *
+ * NOTE: This data structure is stricly ordered wr then attr. I.e the attr
+ * MUST come after wr.  The ib_ud_wr is sized and copied in rvt_post_one_wr.
+ * The copy assumes that wr is first.
+ */
+struct rvt_ud_wr {
+	struct ib_ud_wr wr;
+	struct rdma_ah_attr *attr;
+};
+
 /*
  * Send work request queue entry.
  * The size of the sg_list is determined when the QP is created and stored
@@ -165,7 +181,7 @@
 struct rvt_swqe {
 	union {
 		struct ib_send_wr wr;   /* don't use wr.sg_list */
-		struct ib_ud_wr ud_wr;
+		struct rvt_ud_wr ud_wr;
 		struct ib_reg_wr reg_wr;
 		struct ib_rdma_wr rdma_wr;
 		struct ib_atomic_wr atomic_wr;
@@ -700,7 +716,7 @@ static inline void rvt_put_qp_swqe(struct rvt_qp *qp, struct rvt_swqe *wqe)
 {
 	rvt_put_swqe(wqe);
 	if (qp->allowed_ops == IB_OPCODE_UD)
-		atomic_dec(&ibah_to_rvtah(wqe->ud_wr.ah)->refcount);
+		rdma_destroy_ah_attr(wqe->ud_wr.attr);
 }
 
 /**

