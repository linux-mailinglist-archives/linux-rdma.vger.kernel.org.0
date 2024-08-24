Return-Path: <linux-rdma+bounces-4553-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D7B95DB00
	for <lists+linux-rdma@lfdr.de>; Sat, 24 Aug 2024 05:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C8EF28110A
	for <lists+linux-rdma@lfdr.de>; Sat, 24 Aug 2024 03:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E1D143C5F;
	Sat, 24 Aug 2024 03:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A66AkPzE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A3513AD11;
	Sat, 24 Aug 2024 03:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724469659; cv=none; b=uT2fDhQVlXKi9zoepAuHCEJxGJ3gWoew0Dg2BGpqK8fbPPzq4NqAiNW1/7b5u+sJ0HSBNOBq1hI7znhHgnfsdoEkJ1rdggp+QJRqVPbWUMARDN/Zl4nIlIaV0QPwhYL8MgXiA4I9K+aPAq8IpNh5DPAlvIcAUl1vhOWHKJoXqmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724469659; c=relaxed/simple;
	bh=E+/oG7TPw2cagk4XVEEURXCcvsaS5O9FGZ8GSfkrUjI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q+saGxuz/7gPdyGLVeOvG0Kwi7tSQ68Ifp0pjiXw8Pzd5phqORTilM0n8Php8UAF9PmQE2cDotFDBrkROr5O3QrAV/04xeyfw0KV3fceq6WonrDgtCCvXs/KxDBHD2P5e9e4d1tJNpkEf5nGyiUhpi24w5w3hS2WD1eF6eVBlaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A66AkPzE; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724469657; x=1756005657;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E+/oG7TPw2cagk4XVEEURXCcvsaS5O9FGZ8GSfkrUjI=;
  b=A66AkPzEFaYoalMvDHh7N4myBKmgSYc36F8km4qizDqmaLRMwSAxssVk
   3EKRdu8+fAAwt9bmYVJOrhzhOYSbpqHtGTctdRvZnvkIzihMGUJbuYhMA
   vUHh8prCAHwEo+Wk/JbV1d5IiR88y3c6ZILN5nBYUxLSYD0Xq3FSTlgUN
   Wm9LCBBWzDq/ZdPZmfuDKO9vi6SSu8isCy6Aupq5rdAuhoQLVdlLGh0lP
   hgoG1mImFVKwSr45y3zmyHOslcbHfnKJzt5agX14HqybGbOpRkSGXYhmn
   EGkiPBwSApLfguD2VqqpYAALF9Izv+70skIkDz7VqqvbUYMC80jgNEbpo
   w==;
X-CSE-ConnectionGUID: FW9WYx+9Tb2tEfrxGpfYRw==
X-CSE-MsgGUID: 2j8RPGiYSgivgyxP5ItqLg==
X-IronPort-AV: E=McAfee;i="6700,10204,11173"; a="13187834"
X-IronPort-AV: E=Sophos;i="6.10,172,1719903600"; 
   d="scan'208";a="13187834"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 20:20:52 -0700
X-CSE-ConnectionGUID: dQXQECZXRHWBOv+sWOtVGg==
X-CSE-MsgGUID: 6/HJMuzBSaOWii4Nh4ZlFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,172,1719903600"; 
   d="scan'208";a="99492145"
Received: from tenikolo-mobl1.amr.corp.intel.com ([10.124.36.66])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 20:20:51 -0700
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Subject: [RFC v2 23/25] RDMA/irdma: Extend CQE Error and Flush Handling for GEN3 Devices
Date: Fri, 23 Aug 2024 22:19:22 -0500
Message-Id: <20240824031924.421-24-tatyana.e.nikolova@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20240824031924.421-1-tatyana.e.nikolova@intel.com>
References: <20240824031924.421-1-tatyana.e.nikolova@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shiraz Saleem <shiraz.saleem@intel.com>

Enhance the CQE error and flush handling specific to GEN3 devices.
Unlike GEN1/2 devices, which depend on software to generate completions
in error, GEN3 devices leverage firmware to generate CQEs in error for
all WQEs posted after a QP moves to an error state.

Key changes include:
- Updating the CQ poll logic to properly advance the CQ head in the
event of a flush CQE.
- Updating the flush logic for GEN3 to pass error WQE idx
for SQ on an AE to flush out unprocessed WQEs in error.
- Isolating the decoding of AE to flush codes into a separate routine
irdma_ae_to_qp_err_code. This routine can now be leveraged to
flush error CQEs on an AE and when error CQE is received for SRQ

Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
---
 drivers/infiniband/hw/irdma/ctrl.c  |   9 ++
 drivers/infiniband/hw/irdma/defs.h  | 105 +--------------
 drivers/infiniband/hw/irdma/hw.c    | 104 +++++----------
 drivers/infiniband/hw/irdma/type.h  |  14 +-
 drivers/infiniband/hw/irdma/uk.c    |  39 +++++-
 drivers/infiniband/hw/irdma/user.h  | 194 +++++++++++++++++++++++++++-
 drivers/infiniband/hw/irdma/verbs.c |  31 +++--
 7 files changed, 297 insertions(+), 199 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/ctrl.c b/drivers/infiniband/hw/irdma/ctrl.c
index 40868b58063d..73cab77d60de 100644
--- a/drivers/infiniband/hw/irdma/ctrl.c
+++ b/drivers/infiniband/hw/irdma/ctrl.c
@@ -2670,6 +2670,12 @@ int irdma_sc_qp_flush_wqes(struct irdma_sc_qp *qp,
 		info->ae_code | FIELD_PREP(IRDMA_CQPSQ_FWQE_AESOURCE,
 					   info->ae_src) : 0;
 	set_64bit_val(wqe, 8, temp);
+	if (cqp->dev->hw_attrs.uk_attrs.hw_rev >= IRDMA_GEN_3) {
+		set_64bit_val(wqe, 40,
+			      FIELD_PREP(IRDMA_CQPSQ_FWQE_ERR_SQ_IDX, info->err_sq_idx));
+		set_64bit_val(wqe, 48,
+			      FIELD_PREP(IRDMA_CQPSQ_FWQE_ERR_RQ_IDX, info->err_rq_idx));
+	}
 
 	hdr = qp->qp_uk.qp_id |
 	      FIELD_PREP(IRDMA_CQPSQ_OPCODE, IRDMA_CQP_OP_FLUSH_WQES) |
@@ -2678,6 +2684,9 @@ int irdma_sc_qp_flush_wqes(struct irdma_sc_qp *qp,
 	      FIELD_PREP(IRDMA_CQPSQ_FWQE_FLUSHSQ, flush_sq) |
 	      FIELD_PREP(IRDMA_CQPSQ_FWQE_FLUSHRQ, flush_rq) |
 	      FIELD_PREP(IRDMA_CQPSQ_WQEVALID, cqp->polarity);
+	if (cqp->dev->hw_attrs.uk_attrs.hw_rev >= IRDMA_GEN_3)
+		hdr |= FIELD_PREP(IRDMA_CQPSQ_FWQE_ERR_SQ_IDX_VALID, info->err_sq_idx_valid) |
+		       FIELD_PREP(IRDMA_CQPSQ_FWQE_ERR_RQ_IDX_VALID, info->err_rq_idx_valid);
 	dma_wmb(); /* make sure WQE is written before valid bit is set */
 
 	set_64bit_val(wqe, 24, hdr);
diff --git a/drivers/infiniband/hw/irdma/defs.h b/drivers/infiniband/hw/irdma/defs.h
index 9c0fd4603a82..e75dd8bbd86b 100644
--- a/drivers/infiniband/hw/irdma/defs.h
+++ b/drivers/infiniband/hw/irdma/defs.h
@@ -301,107 +301,6 @@ enum irdma_cqp_op_type {
 #define IRDMA_CQP_OP_GATHER_STATS			0x2e
 #define IRDMA_CQP_OP_UP_MAP				0x2f
 
-/* Async Events codes */
-#define IRDMA_AE_AMP_UNALLOCATED_STAG					0x0102
-#define IRDMA_AE_AMP_INVALID_STAG					0x0103
-#define IRDMA_AE_AMP_BAD_QP						0x0104
-#define IRDMA_AE_AMP_BAD_PD						0x0105
-#define IRDMA_AE_AMP_BAD_STAG_KEY					0x0106
-#define IRDMA_AE_AMP_BAD_STAG_INDEX					0x0107
-#define IRDMA_AE_AMP_BOUNDS_VIOLATION					0x0108
-#define IRDMA_AE_AMP_RIGHTS_VIOLATION					0x0109
-#define IRDMA_AE_AMP_TO_WRAP						0x010a
-#define IRDMA_AE_AMP_FASTREG_VALID_STAG					0x010c
-#define IRDMA_AE_AMP_FASTREG_MW_STAG					0x010d
-#define IRDMA_AE_AMP_FASTREG_INVALID_RIGHTS				0x010e
-#define IRDMA_AE_AMP_FASTREG_INVALID_LENGTH				0x0110
-#define IRDMA_AE_AMP_INVALIDATE_SHARED					0x0111
-#define IRDMA_AE_AMP_INVALIDATE_NO_REMOTE_ACCESS_RIGHTS			0x0112
-#define IRDMA_AE_AMP_INVALIDATE_MR_WITH_BOUND_WINDOWS			0x0113
-#define IRDMA_AE_AMP_MWBIND_VALID_STAG					0x0114
-#define IRDMA_AE_AMP_MWBIND_OF_MR_STAG					0x0115
-#define IRDMA_AE_AMP_MWBIND_TO_ZERO_BASED_STAG				0x0116
-#define IRDMA_AE_AMP_MWBIND_TO_MW_STAG					0x0117
-#define IRDMA_AE_AMP_MWBIND_INVALID_RIGHTS				0x0118
-#define IRDMA_AE_AMP_MWBIND_INVALID_BOUNDS				0x0119
-#define IRDMA_AE_AMP_MWBIND_TO_INVALID_PARENT				0x011a
-#define IRDMA_AE_AMP_MWBIND_BIND_DISABLED				0x011b
-#define IRDMA_AE_PRIV_OPERATION_DENIED					0x011c
-#define IRDMA_AE_AMP_INVALIDATE_TYPE1_MW				0x011d
-#define IRDMA_AE_AMP_MWBIND_ZERO_BASED_TYPE1_MW				0x011e
-#define IRDMA_AE_AMP_FASTREG_INVALID_PBL_HPS_CFG			0x011f
-#define IRDMA_AE_AMP_MWBIND_WRONG_TYPE					0x0120
-#define IRDMA_AE_AMP_FASTREG_PBLE_MISMATCH				0x0121
-#define IRDMA_AE_UDA_XMIT_DGRAM_TOO_LONG				0x0132
-#define IRDMA_AE_UDA_XMIT_BAD_PD					0x0133
-#define IRDMA_AE_UDA_XMIT_DGRAM_TOO_SHORT				0x0134
-#define IRDMA_AE_UDA_L4LEN_INVALID					0x0135
-#define IRDMA_AE_BAD_CLOSE						0x0201
-#define IRDMA_AE_RDMAP_ROE_BAD_LLP_CLOSE				0x0202
-#define IRDMA_AE_CQ_OPERATION_ERROR					0x0203
-#define IRDMA_AE_RDMA_READ_WHILE_ORD_ZERO				0x0205
-#define IRDMA_AE_STAG_ZERO_INVALID					0x0206
-#define IRDMA_AE_IB_RREQ_AND_Q1_FULL					0x0207
-#define IRDMA_AE_IB_INVALID_REQUEST					0x0208
-#define IRDMA_AE_SRQ_LIMIT						0x0209
-#define IRDMA_AE_WQE_UNEXPECTED_OPCODE					0x020a
-#define IRDMA_AE_WQE_INVALID_PARAMETER					0x020b
-#define IRDMA_AE_WQE_INVALID_FRAG_DATA					0x020c
-#define IRDMA_AE_IB_REMOTE_ACCESS_ERROR					0x020d
-#define IRDMA_AE_IB_REMOTE_OP_ERROR					0x020e
-#define IRDMA_AE_SRQ_CATASTROPHIC_ERROR					0x020f
-#define IRDMA_AE_WQE_LSMM_TOO_LONG					0x0220
-#define IRDMA_AE_ATOMIC_ALIGNMENT					0x0221
-#define IRDMA_AE_ATOMIC_MASK						0x0222
-#define IRDMA_AE_INVALID_REQUEST					0x0223
-#define IRDMA_AE_PCIE_ATOMIC_DISABLE					0x0224
-#define IRDMA_AE_DDP_INVALID_MSN_GAP_IN_MSN				0x0301
-#define IRDMA_AE_DDP_UBE_DDP_MESSAGE_TOO_LONG_FOR_AVAILABLE_BUFFER	0x0303
-#define IRDMA_AE_DDP_UBE_INVALID_DDP_VERSION				0x0304
-#define IRDMA_AE_DDP_UBE_INVALID_MO					0x0305
-#define IRDMA_AE_DDP_UBE_INVALID_MSN_NO_BUFFER_AVAILABLE		0x0306
-#define IRDMA_AE_DDP_UBE_INVALID_QN					0x0307
-#define IRDMA_AE_DDP_NO_L_BIT						0x0308
-#define IRDMA_AE_RDMAP_ROE_INVALID_RDMAP_VERSION			0x0311
-#define IRDMA_AE_RDMAP_ROE_UNEXPECTED_OPCODE				0x0312
-#define IRDMA_AE_ROE_INVALID_RDMA_READ_REQUEST				0x0313
-#define IRDMA_AE_ROE_INVALID_RDMA_WRITE_OR_READ_RESP			0x0314
-#define IRDMA_AE_ROCE_RSP_LENGTH_ERROR					0x0316
-#define IRDMA_AE_ROCE_EMPTY_MCG						0x0380
-#define IRDMA_AE_ROCE_BAD_MC_IP_ADDR					0x0381
-#define IRDMA_AE_ROCE_BAD_MC_QPID					0x0382
-#define IRDMA_AE_MCG_QP_PROTOCOL_MISMATCH				0x0383
-#define IRDMA_AE_INVALID_ARP_ENTRY					0x0401
-#define IRDMA_AE_INVALID_TCP_OPTION_RCVD				0x0402
-#define IRDMA_AE_STALE_ARP_ENTRY					0x0403
-#define IRDMA_AE_INVALID_AH_ENTRY					0x0406
-#define IRDMA_AE_LLP_CLOSE_COMPLETE					0x0501
-#define IRDMA_AE_LLP_CONNECTION_RESET					0x0502
-#define IRDMA_AE_LLP_FIN_RECEIVED					0x0503
-#define IRDMA_AE_LLP_RECEIVED_MARKER_AND_LENGTH_FIELDS_DONT_MATCH	0x0504
-#define IRDMA_AE_LLP_RECEIVED_MPA_CRC_ERROR				0x0505
-#define IRDMA_AE_LLP_SEGMENT_TOO_SMALL					0x0507
-#define IRDMA_AE_LLP_SYN_RECEIVED					0x0508
-#define IRDMA_AE_LLP_TERMINATE_RECEIVED					0x0509
-#define IRDMA_AE_LLP_TOO_MANY_RETRIES					0x050a
-#define IRDMA_AE_LLP_TOO_MANY_KEEPALIVE_RETRIES				0x050b
-#define IRDMA_AE_LLP_DOUBT_REACHABILITY					0x050c
-#define IRDMA_AE_LLP_CONNECTION_ESTABLISHED				0x050e
-#define IRDMA_AE_LLP_TOO_MANY_RNRS					0x050f
-#define IRDMA_AE_RESOURCE_EXHAUSTION					0x0520
-#define IRDMA_AE_RESET_SENT						0x0601
-#define IRDMA_AE_TERMINATE_SENT						0x0602
-#define IRDMA_AE_RESET_NOT_SENT						0x0603
-#define IRDMA_AE_LCE_QP_CATASTROPHIC					0x0700
-#define IRDMA_AE_LCE_FUNCTION_CATASTROPHIC				0x0701
-#define IRDMA_AE_LCE_CQ_CATASTROPHIC					0x0702
-#define IRDMA_AE_REMOTE_QP_CATASTROPHIC					0x0703
-#define IRDMA_AE_LOCAL_QP_CATASTROPHIC					0x0704
-#define IRDMA_AE_RCE_QP_CATASTROPHIC					0x0705
-#define IRDMA_AE_QP_SUSPEND_COMPLETE					0x0900
-#define IRDMA_AE_CQP_DEFERRED_COMPLETE					0x0901
-#define IRDMA_AE_ADAPTER_CATASTROPHIC					0x0B0B
-
 #define FLD_LS_64(dev, val, field)	\
 	(((u64)(val) << (dev)->hw_shifts[field ## _S]) & (dev)->hw_masks[field ## _M])
 #define FLD_RS_64(dev, val, field)	\
@@ -778,6 +677,10 @@ enum irdma_cqp_op_type {
 #define IRDMA_CQPSQ_FWQE_USERFLCODE BIT_ULL(60)
 #define IRDMA_CQPSQ_FWQE_FLUSHSQ BIT_ULL(61)
 #define IRDMA_CQPSQ_FWQE_FLUSHRQ BIT_ULL(62)
+#define IRDMA_CQPSQ_FWQE_ERR_SQ_IDX_VALID BIT_ULL(42)
+#define IRDMA_CQPSQ_FWQE_ERR_SQ_IDX GENMASK_ULL(49, 32)
+#define IRDMA_CQPSQ_FWQE_ERR_RQ_IDX_VALID BIT_ULL(43)
+#define IRDMA_CQPSQ_FWQE_ERR_RQ_IDX GENMASK_ULL(46, 32)
 #define IRDMA_CQPSQ_MAPT_PORT GENMASK_ULL(15, 0)
 #define IRDMA_CQPSQ_MAPT_ADDPORT BIT_ULL(62)
 #define IRDMA_CQPSQ_UPESD_SDCMD GENMASK_ULL(31, 0)
diff --git a/drivers/infiniband/hw/irdma/hw.c b/drivers/infiniband/hw/irdma/hw.c
index 524fe5dba760..4daaefa596cd 100644
--- a/drivers/infiniband/hw/irdma/hw.c
+++ b/drivers/infiniband/hw/irdma/hw.c
@@ -133,78 +133,26 @@ static void irdma_process_ceq(struct irdma_pci_f *rf, struct irdma_ceq *ceq)
 }
 
 static void irdma_set_flush_fields(struct irdma_sc_qp *qp,
-				   struct irdma_aeqe_info *info)
+				   struct irdma_aeqe_info *info,
+				   struct irdma_qp_host_ctx_info *ctx_info)
 {
+	struct qp_err_code qp_err;
+
 	qp->sq_flush_code = info->sq;
 	qp->rq_flush_code = info->rq;
-	qp->event_type = IRDMA_QP_EVENT_CATASTROPHIC;
-
-	switch (info->ae_id) {
-	case IRDMA_AE_AMP_BOUNDS_VIOLATION:
-	case IRDMA_AE_AMP_INVALID_STAG:
-	case IRDMA_AE_AMP_RIGHTS_VIOLATION:
-	case IRDMA_AE_AMP_UNALLOCATED_STAG:
-	case IRDMA_AE_AMP_BAD_PD:
-	case IRDMA_AE_AMP_BAD_QP:
-	case IRDMA_AE_AMP_BAD_STAG_KEY:
-	case IRDMA_AE_AMP_BAD_STAG_INDEX:
-	case IRDMA_AE_AMP_TO_WRAP:
-	case IRDMA_AE_PRIV_OPERATION_DENIED:
-		qp->flush_code = FLUSH_PROT_ERR;
-		qp->event_type = IRDMA_QP_EVENT_ACCESS_ERR;
-		break;
-	case IRDMA_AE_UDA_XMIT_BAD_PD:
-	case IRDMA_AE_WQE_UNEXPECTED_OPCODE:
-		qp->flush_code = FLUSH_LOC_QP_OP_ERR;
-		qp->event_type = IRDMA_QP_EVENT_CATASTROPHIC;
-		break;
-	case IRDMA_AE_UDA_XMIT_DGRAM_TOO_LONG:
-	case IRDMA_AE_UDA_XMIT_DGRAM_TOO_SHORT:
-	case IRDMA_AE_UDA_L4LEN_INVALID:
-	case IRDMA_AE_DDP_UBE_INVALID_MO:
-	case IRDMA_AE_DDP_UBE_DDP_MESSAGE_TOO_LONG_FOR_AVAILABLE_BUFFER:
-		qp->flush_code = FLUSH_LOC_LEN_ERR;
-		qp->event_type = IRDMA_QP_EVENT_CATASTROPHIC;
-		break;
-	case IRDMA_AE_AMP_INVALIDATE_NO_REMOTE_ACCESS_RIGHTS:
-	case IRDMA_AE_IB_REMOTE_ACCESS_ERROR:
-		qp->flush_code = FLUSH_REM_ACCESS_ERR;
-		qp->event_type = IRDMA_QP_EVENT_ACCESS_ERR;
-		break;
-	case IRDMA_AE_LLP_SEGMENT_TOO_SMALL:
-	case IRDMA_AE_LLP_RECEIVED_MPA_CRC_ERROR:
-	case IRDMA_AE_ROCE_RSP_LENGTH_ERROR:
-	case IRDMA_AE_IB_REMOTE_OP_ERROR:
-		qp->flush_code = FLUSH_REM_OP_ERR;
-		qp->event_type = IRDMA_QP_EVENT_CATASTROPHIC;
-		break;
-	case IRDMA_AE_LCE_QP_CATASTROPHIC:
-		qp->flush_code = FLUSH_FATAL_ERR;
-		qp->event_type = IRDMA_QP_EVENT_CATASTROPHIC;
-		break;
-	case IRDMA_AE_IB_RREQ_AND_Q1_FULL:
-		qp->flush_code = FLUSH_GENERAL_ERR;
-		break;
-	case IRDMA_AE_LLP_TOO_MANY_RETRIES:
-		qp->flush_code = FLUSH_RETRY_EXC_ERR;
-		qp->event_type = IRDMA_QP_EVENT_CATASTROPHIC;
-		break;
-	case IRDMA_AE_AMP_MWBIND_INVALID_RIGHTS:
-	case IRDMA_AE_AMP_MWBIND_BIND_DISABLED:
-	case IRDMA_AE_AMP_MWBIND_INVALID_BOUNDS:
-	case IRDMA_AE_AMP_MWBIND_VALID_STAG:
-		qp->flush_code = FLUSH_MW_BIND_ERR;
-		qp->event_type = IRDMA_QP_EVENT_ACCESS_ERR;
-		break;
-	case IRDMA_AE_IB_INVALID_REQUEST:
-		qp->flush_code = FLUSH_REM_INV_REQ_ERR;
-		qp->event_type = IRDMA_QP_EVENT_REQ_ERR;
-		break;
-	default:
-		qp->flush_code = FLUSH_GENERAL_ERR;
-		qp->event_type = IRDMA_QP_EVENT_CATASTROPHIC;
-		break;
+	if (info->sq && qp->qp_uk.uk_attrs->hw_rev >= IRDMA_GEN_3) {
+		qp->err_sq_idx_valid = true;
+		qp->err_sq_idx = info->wqe_idx;
+	}
+	if (ctx_info->roce_info->err_rq_idx_valid && qp->qp_uk.uk_attrs->hw_rev >= IRDMA_GEN_3) {
+		qp->err_rq_idx_valid = true;
+		qp->err_rq_idx = ctx_info->roce_info->err_rq_idx;
 	}
+
+	qp_err = irdma_ae_to_qp_err_code(info->ae_id);
+
+	qp->flush_code = qp_err.flush_code;
+	qp->event_type = qp_err.event_type;
 }
 
 /**
@@ -465,14 +413,16 @@ static void irdma_process_aeq(struct irdma_pci_f *rf)
 		default:
 			ibdev_err(&iwdev->ibdev, "abnormal ae_id = 0x%x bool qp=%d qp_id = %d, ae_src=%d\n",
 				  info->ae_id, info->qp, info->qp_cq_id, info->ae_src);
-			if (rdma_protocol_roce(&iwdev->ibdev, 1)) {
-				ctx_info->roce_info->err_rq_idx_valid = info->rq;
-				if (info->rq) {
+			ctx_info = &iwqp->ctx_info;
+			if (rdma_protocol_roce(&iwqp->iwdev->ibdev, 1)) {
+				ctx_info->roce_info->err_rq_idx_valid =
+					ctx_info->srq_valid ? false : info->err_rq_idx_valid;
+				if (ctx_info->roce_info->err_rq_idx_valid) {
 					ctx_info->roce_info->err_rq_idx = info->wqe_idx;
 					irdma_sc_qp_setctx_roce(&iwqp->sc_qp, iwqp->host_ctx.va,
 								ctx_info);
 				}
-				irdma_set_flush_fields(qp, info);
+				irdma_set_flush_fields(qp, info, ctx_info);
 				irdma_cm_disconn(iwqp);
 				break;
 			}
@@ -2831,7 +2781,9 @@ void irdma_flush_wqes(struct irdma_qp *iwqp, u32 flush_mask)
 	struct irdma_pci_f *rf = iwqp->iwdev->rf;
 	u8 flush_code = iwqp->sc_qp.flush_code;
 
-	if (!(flush_mask & IRDMA_FLUSH_SQ) && !(flush_mask & IRDMA_FLUSH_RQ))
+	if ((!(flush_mask & IRDMA_FLUSH_SQ) &&
+	     !(flush_mask & IRDMA_FLUSH_RQ)) ||
+	    ((flush_mask & IRDMA_REFLUSH) && rf->rdma_ver >= IRDMA_GEN_3))
 		return;
 
 	/* Set flush info fields*/
@@ -2844,6 +2796,10 @@ void irdma_flush_wqes(struct irdma_qp *iwqp, u32 flush_mask)
 	info.rq_major_code = IRDMA_FLUSH_MAJOR_ERR;
 	info.rq_minor_code = FLUSH_GENERAL_ERR;
 	info.userflushcode = true;
+	info.err_sq_idx_valid = iwqp->sc_qp.err_sq_idx_valid;
+	info.err_sq_idx = iwqp->sc_qp.err_sq_idx;
+	info.err_rq_idx_valid = iwqp->sc_qp.err_rq_idx_valid;
+	info.err_rq_idx = iwqp->sc_qp.err_rq_idx;
 
 	if (flush_mask & IRDMA_REFLUSH) {
 		if (info.sq)
@@ -2857,7 +2813,7 @@ void irdma_flush_wqes(struct irdma_qp *iwqp, u32 flush_mask)
 			if (info.rq && iwqp->sc_qp.rq_flush_code)
 				info.rq_minor_code = flush_code;
 		}
-		if (!iwqp->user_mode)
+		if (!iwqp->user_mode && rf->rdma_ver <= IRDMA_GEN_2)
 			queue_delayed_work(iwqp->iwdev->cleanup_wq,
 					   &iwqp->dwork_flush,
 					   msecs_to_jiffies(IRDMA_FLUSH_DELAY_MS));
diff --git a/drivers/infiniband/hw/irdma/type.h b/drivers/infiniband/hw/irdma/type.h
index 52aa1dd3cbb7..99160910f24b 100644
--- a/drivers/infiniband/hw/irdma/type.h
+++ b/drivers/infiniband/hw/irdma/type.h
@@ -97,12 +97,6 @@ enum irdma_term_mpa_errors {
 	MPA_REQ_RSP = 0x04,
 };
 
-enum irdma_qp_event_type {
-	IRDMA_QP_EVENT_CATASTROPHIC,
-	IRDMA_QP_EVENT_ACCESS_ERR,
-	IRDMA_QP_EVENT_REQ_ERR,
-};
-
 enum irdma_hw_stats_index {
 	/* gen1 - 32-bit */
 	IRDMA_HW_STAT_INDEX_IP4RXDISCARD	= 0,
@@ -573,6 +567,10 @@ struct irdma_sc_qp {
 	bool virtual_map:1;
 	bool flush_sq:1;
 	bool flush_rq:1;
+	bool err_sq_idx_valid:1;
+	bool err_rq_idx_valid:1;
+	u32 err_sq_idx;
+	u32 err_rq_idx;
 	bool sq_flush_code:1;
 	bool rq_flush_code:1;
 	u32 pkt_limit;
@@ -1296,6 +1294,8 @@ struct irdma_cqp_manage_push_page_info {
 };
 
 struct irdma_qp_flush_info {
+	u32 err_sq_idx;
+	u32 err_rq_idx;
 	u16 sq_minor_code;
 	u16 sq_major_code;
 	u16 rq_minor_code;
@@ -1306,6 +1306,8 @@ struct irdma_qp_flush_info {
 	bool rq:1;
 	bool userflushcode:1;
 	bool generate_ae:1;
+	bool err_sq_idx_valid:1;
+	bool err_rq_idx_valid:1;
 };
 
 struct irdma_gen_ae_info {
diff --git a/drivers/infiniband/hw/irdma/uk.c b/drivers/infiniband/hw/irdma/uk.c
index 24e8df0f8033..682e848b4db2 100644
--- a/drivers/infiniband/hw/irdma/uk.c
+++ b/drivers/infiniband/hw/irdma/uk.c
@@ -1148,6 +1148,7 @@ int irdma_uk_cq_poll_cmpl(struct irdma_cq_uk *cq,
 	__le64 *cqe;
 	struct irdma_qp_uk *qp;
 	struct irdma_srq_uk *srq;
+	struct qp_err_code qp_err;
 	u8 is_srq;
 	struct irdma_ring *pring = NULL;
 	u32 wqe_idx;
@@ -1233,16 +1234,35 @@ int irdma_uk_cq_poll_cmpl(struct irdma_cq_uk *cq,
 	if (info->error) {
 		info->major_err = FIELD_GET(IRDMA_CQ_MAJERR, qword3);
 		info->minor_err = FIELD_GET(IRDMA_CQ_MINERR, qword3);
-		if (info->major_err == IRDMA_FLUSH_MAJOR_ERR) {
-			info->comp_status = IRDMA_COMPL_STATUS_FLUSHED;
+		switch (info->major_err) {
+		case IRDMA_SRQFLUSH_RSVD_MAJOR_ERR:
+			qp_err = irdma_ae_to_qp_err_code(info->minor_err);
+			info->minor_err = qp_err.flush_code;
+			fallthrough;
+		case IRDMA_FLUSH_MAJOR_ERR:
 			/* Set the min error to standard flush error code for remaining cqes */
 			if (info->minor_err != FLUSH_GENERAL_ERR) {
 				qword3 &= ~IRDMA_CQ_MINERR;
 				qword3 |= FIELD_PREP(IRDMA_CQ_MINERR, FLUSH_GENERAL_ERR);
 				set_64bit_val(cqe, 24, qword3);
 			}
-		} else {
-			info->comp_status = IRDMA_COMPL_STATUS_UNKNOWN;
+			info->comp_status = IRDMA_COMPL_STATUS_FLUSHED;
+			break;
+		default:
+#define IRDMA_CIE_SIGNATURE 0xE
+#define IRDMA_CQMAJERR_HIGH_NIBBLE GENMASK(15, 12)
+			if (info->q_type == IRDMA_CQE_QTYPE_SQ &&
+			    qp->qp_type == IRDMA_QP_TYPE_ROCE_UD &&
+			    FIELD_GET(IRDMA_CQMAJERR_HIGH_NIBBLE, info->major_err)
+			    == IRDMA_CIE_SIGNATURE) {
+				info->error = 0;
+				info->major_err = 0;
+				info->minor_err = 0;
+				info->comp_status = IRDMA_COMPL_STATUS_SUCCESS;
+			} else {
+				info->comp_status = IRDMA_COMPL_STATUS_UNKNOWN;
+			}
+			break;
 		}
 	} else {
 		info->comp_status = IRDMA_COMPL_STATUS_SUCCESS;
@@ -1251,7 +1271,6 @@ int irdma_uk_cq_poll_cmpl(struct irdma_cq_uk *cq,
 	get_64bit_val(cqe, 0, &qword0);
 	get_64bit_val(cqe, 16, &qword2);
 
-	info->tcp_seq_num_rtt = (u32)FIELD_GET(IRDMACQ_TCPSEQNUMRTT, qword0);
 	info->qp_id = (u32)FIELD_GET(IRDMACQ_QPID, qword2);
 	info->ud_src_qpn = (u32)FIELD_GET(IRDMACQ_UDSRCQPN, qword2);
 
@@ -1377,9 +1396,15 @@ int irdma_uk_cq_poll_cmpl(struct irdma_cq_uk *cq,
 	ret_code = 0;
 
 exit:
-	if (!ret_code && info->comp_status == IRDMA_COMPL_STATUS_FLUSHED)
+	if (!ret_code && info->comp_status == IRDMA_COMPL_STATUS_FLUSHED) {
 		if (pring && IRDMA_RING_MORE_WORK(*pring))
-			move_cq_head = false;
+		/* Park CQ head during a flush to generate additional CQEs
+		 * from SW for all unprocessed WQEs. For GEN3 and beyond
+		 * FW will generate/flush these CQEs so move to the next CQE
+		 */
+			move_cq_head = qp->uk_attrs->hw_rev <= IRDMA_GEN_2 ?
+						false : true;
+	}
 
 	if (move_cq_head) {
 		IRDMA_RING_MOVE_HEAD_NOCHECK(cq->cq_ring);
diff --git a/drivers/infiniband/hw/irdma/user.h b/drivers/infiniband/hw/irdma/user.h
index 96dea01e83db..a2029f5f0284 100644
--- a/drivers/infiniband/hw/irdma/user.h
+++ b/drivers/infiniband/hw/irdma/user.h
@@ -46,7 +46,109 @@
 #define IRDMA_OP_TYPE_REC	0x3e
 #define IRDMA_OP_TYPE_REC_IMM	0x3f
 
-#define IRDMA_FLUSH_MAJOR_ERR	1
+#define IRDMA_FLUSH_MAJOR_ERR 1
+#define IRDMA_SRQFLUSH_RSVD_MAJOR_ERR 0xfffe
+
+/* Async Events codes */
+#define IRDMA_AE_AMP_UNALLOCATED_STAG					0x0102
+#define IRDMA_AE_AMP_INVALID_STAG					0x0103
+#define IRDMA_AE_AMP_BAD_QP						0x0104
+#define IRDMA_AE_AMP_BAD_PD						0x0105
+#define IRDMA_AE_AMP_BAD_STAG_KEY					0x0106
+#define IRDMA_AE_AMP_BAD_STAG_INDEX					0x0107
+#define IRDMA_AE_AMP_BOUNDS_VIOLATION					0x0108
+#define IRDMA_AE_AMP_RIGHTS_VIOLATION					0x0109
+#define IRDMA_AE_AMP_TO_WRAP						0x010a
+#define IRDMA_AE_AMP_FASTREG_VALID_STAG					0x010c
+#define IRDMA_AE_AMP_FASTREG_MW_STAG					0x010d
+#define IRDMA_AE_AMP_FASTREG_INVALID_RIGHTS				0x010e
+#define IRDMA_AE_AMP_FASTREG_INVALID_LENGTH				0x0110
+#define IRDMA_AE_AMP_INVALIDATE_SHARED					0x0111
+#define IRDMA_AE_AMP_INVALIDATE_NO_REMOTE_ACCESS_RIGHTS			0x0112
+#define IRDMA_AE_AMP_INVALIDATE_MR_WITH_BOUND_WINDOWS			0x0113
+#define IRDMA_AE_AMP_MWBIND_VALID_STAG					0x0114
+#define IRDMA_AE_AMP_MWBIND_OF_MR_STAG					0x0115
+#define IRDMA_AE_AMP_MWBIND_TO_ZERO_BASED_STAG				0x0116
+#define IRDMA_AE_AMP_MWBIND_TO_MW_STAG					0x0117
+#define IRDMA_AE_AMP_MWBIND_INVALID_RIGHTS				0x0118
+#define IRDMA_AE_AMP_MWBIND_INVALID_BOUNDS				0x0119
+#define IRDMA_AE_AMP_MWBIND_TO_INVALID_PARENT				0x011a
+#define IRDMA_AE_AMP_MWBIND_BIND_DISABLED				0x011b
+#define IRDMA_AE_PRIV_OPERATION_DENIED					0x011c
+#define IRDMA_AE_AMP_INVALIDATE_TYPE1_MW				0x011d
+#define IRDMA_AE_AMP_MWBIND_ZERO_BASED_TYPE1_MW				0x011e
+#define IRDMA_AE_AMP_FASTREG_INVALID_PBL_HPS_CFG			0x011f
+#define IRDMA_AE_AMP_MWBIND_WRONG_TYPE					0x0120
+#define IRDMA_AE_AMP_FASTREG_PBLE_MISMATCH				0x0121
+#define IRDMA_AE_UDA_XMIT_DGRAM_TOO_LONG				0x0132
+#define IRDMA_AE_UDA_XMIT_BAD_PD					0x0133
+#define IRDMA_AE_UDA_XMIT_DGRAM_TOO_SHORT				0x0134
+#define IRDMA_AE_UDA_L4LEN_INVALID					0x0135
+#define IRDMA_AE_BAD_CLOSE						0x0201
+#define IRDMA_AE_RDMAP_ROE_BAD_LLP_CLOSE				0x0202
+#define IRDMA_AE_CQ_OPERATION_ERROR					0x0203
+#define IRDMA_AE_RDMA_READ_WHILE_ORD_ZERO				0x0205
+#define IRDMA_AE_STAG_ZERO_INVALID					0x0206
+#define IRDMA_AE_IB_RREQ_AND_Q1_FULL					0x0207
+#define IRDMA_AE_IB_INVALID_REQUEST					0x0208
+#define IRDMA_AE_SRQ_LIMIT						0x0209
+#define IRDMA_AE_WQE_UNEXPECTED_OPCODE					0x020a
+#define IRDMA_AE_WQE_INVALID_PARAMETER					0x020b
+#define IRDMA_AE_WQE_INVALID_FRAG_DATA					0x020c
+#define IRDMA_AE_IB_REMOTE_ACCESS_ERROR					0x020d
+#define IRDMA_AE_IB_REMOTE_OP_ERROR					0x020e
+#define IRDMA_AE_SRQ_CATASTROPHIC_ERROR					0x020f
+#define IRDMA_AE_WQE_LSMM_TOO_LONG					0x0220
+#define IRDMA_AE_ATOMIC_ALIGNMENT					0x0221
+#define IRDMA_AE_ATOMIC_MASK						0x0222
+#define IRDMA_AE_INVALID_REQUEST					0x0223
+#define IRDMA_AE_PCIE_ATOMIC_DISABLE					0x0224
+#define IRDMA_AE_DDP_INVALID_MSN_GAP_IN_MSN				0x0301
+#define IRDMA_AE_DDP_UBE_DDP_MESSAGE_TOO_LONG_FOR_AVAILABLE_BUFFER	0x0303
+#define IRDMA_AE_DDP_UBE_INVALID_DDP_VERSION				0x0304
+#define IRDMA_AE_DDP_UBE_INVALID_MO					0x0305
+#define IRDMA_AE_DDP_UBE_INVALID_MSN_NO_BUFFER_AVAILABLE		0x0306
+#define IRDMA_AE_DDP_UBE_INVALID_QN					0x0307
+#define IRDMA_AE_DDP_NO_L_BIT						0x0308
+#define IRDMA_AE_RDMAP_ROE_INVALID_RDMAP_VERSION			0x0311
+#define IRDMA_AE_RDMAP_ROE_UNEXPECTED_OPCODE				0x0312
+#define IRDMA_AE_ROE_INVALID_RDMA_READ_REQUEST				0x0313
+#define IRDMA_AE_ROE_INVALID_RDMA_WRITE_OR_READ_RESP			0x0314
+#define IRDMA_AE_ROCE_RSP_LENGTH_ERROR					0x0316
+#define IRDMA_AE_ROCE_EMPTY_MCG						0x0380
+#define IRDMA_AE_ROCE_BAD_MC_IP_ADDR					0x0381
+#define IRDMA_AE_ROCE_BAD_MC_QPID					0x0382
+#define IRDMA_AE_MCG_QP_PROTOCOL_MISMATCH				0x0383
+#define IRDMA_AE_INVALID_ARP_ENTRY					0x0401
+#define IRDMA_AE_INVALID_TCP_OPTION_RCVD				0x0402
+#define IRDMA_AE_STALE_ARP_ENTRY					0x0403
+#define IRDMA_AE_INVALID_AH_ENTRY					0x0406
+#define IRDMA_AE_LLP_CLOSE_COMPLETE					0x0501
+#define IRDMA_AE_LLP_CONNECTION_RESET					0x0502
+#define IRDMA_AE_LLP_FIN_RECEIVED					0x0503
+#define IRDMA_AE_LLP_RECEIVED_MARKER_AND_LENGTH_FIELDS_DONT_MATCH	0x0504
+#define IRDMA_AE_LLP_RECEIVED_MPA_CRC_ERROR				0x0505
+#define IRDMA_AE_LLP_SEGMENT_TOO_SMALL					0x0507
+#define IRDMA_AE_LLP_SYN_RECEIVED					0x0508
+#define IRDMA_AE_LLP_TERMINATE_RECEIVED					0x0509
+#define IRDMA_AE_LLP_TOO_MANY_RETRIES					0x050a
+#define IRDMA_AE_LLP_TOO_MANY_KEEPALIVE_RETRIES				0x050b
+#define IRDMA_AE_LLP_DOUBT_REACHABILITY					0x050c
+#define IRDMA_AE_LLP_CONNECTION_ESTABLISHED				0x050e
+#define IRDMA_AE_LLP_TOO_MANY_RNRS					0x050f
+#define IRDMA_AE_RESOURCE_EXHAUSTION					0x0520
+#define IRDMA_AE_RESET_SENT						0x0601
+#define IRDMA_AE_TERMINATE_SENT						0x0602
+#define IRDMA_AE_RESET_NOT_SENT						0x0603
+#define IRDMA_AE_LCE_QP_CATASTROPHIC					0x0700
+#define IRDMA_AE_LCE_FUNCTION_CATASTROPHIC				0x0701
+#define IRDMA_AE_LCE_CQ_CATASTROPHIC					0x0702
+#define IRDMA_AE_REMOTE_QP_CATASTROPHIC					0x0703
+#define IRDMA_AE_LOCAL_QP_CATASTROPHIC					0x0704
+#define IRDMA_AE_RCE_QP_CATASTROPHIC					0x0705
+#define IRDMA_AE_QP_SUSPEND_COMPLETE					0x0900
+#define IRDMA_AE_CQP_DEFERRED_COMPLETE					0x0901
+#define IRDMA_AE_ADAPTER_CATASTROPHIC					0x0B0B
 
 enum irdma_device_caps_const {
 	IRDMA_WQE_SIZE =			4,
@@ -107,6 +209,13 @@ enum irdma_flush_opcode {
 	FLUSH_RETRY_EXC_ERR,
 	FLUSH_MW_BIND_ERR,
 	FLUSH_REM_INV_REQ_ERR,
+	FLUSH_RNR_RETRY_EXC_ERR,
+};
+
+enum irdma_qp_event_type {
+	IRDMA_QP_EVENT_CATASTROPHIC,
+	IRDMA_QP_EVENT_ACCESS_ERR,
+	IRDMA_QP_EVENT_REQ_ERR,
 };
 
 enum irdma_cmpl_status {
@@ -280,6 +389,11 @@ struct irdma_cq_poll_info {
 	bool imm_valid:1;
 };
 
+struct qp_err_code {
+	enum irdma_flush_opcode flush_code;
+	enum irdma_qp_event_type event_type;
+};
+
 int irdma_uk_atomic_compare_swap(struct irdma_qp_uk *qp,
 				 struct irdma_post_sq_info *info, bool post_sq);
 int irdma_uk_atomic_fetch_add(struct irdma_qp_uk *qp,
@@ -477,4 +591,82 @@ int irdma_get_rqdepth(struct irdma_uk_attrs *uk_attrs, u32 rq_size, u8 shift,
 int irdma_get_srqdepth(struct irdma_uk_attrs *uk_attrs, u32 srq_size, u8 shift,
 		       u32 *srqdepth);
 void irdma_clr_wqes(struct irdma_qp_uk *qp, u32 qp_wqe_idx);
+
+static inline struct qp_err_code irdma_ae_to_qp_err_code(u16 ae_id)
+{
+	struct qp_err_code qp_err = {};
+
+	switch (ae_id) {
+	case IRDMA_AE_AMP_BOUNDS_VIOLATION:
+	case IRDMA_AE_AMP_INVALID_STAG:
+	case IRDMA_AE_AMP_RIGHTS_VIOLATION:
+	case IRDMA_AE_AMP_UNALLOCATED_STAG:
+	case IRDMA_AE_AMP_BAD_PD:
+	case IRDMA_AE_AMP_BAD_QP:
+	case IRDMA_AE_AMP_BAD_STAG_KEY:
+	case IRDMA_AE_AMP_BAD_STAG_INDEX:
+	case IRDMA_AE_AMP_TO_WRAP:
+	case IRDMA_AE_PRIV_OPERATION_DENIED:
+		qp_err.flush_code = FLUSH_PROT_ERR;
+		qp_err.event_type = IRDMA_QP_EVENT_ACCESS_ERR;
+		break;
+	case IRDMA_AE_UDA_XMIT_BAD_PD:
+	case IRDMA_AE_WQE_UNEXPECTED_OPCODE:
+		qp_err.flush_code = FLUSH_LOC_QP_OP_ERR;
+		qp_err.event_type = IRDMA_QP_EVENT_CATASTROPHIC;
+		break;
+	case IRDMA_AE_UDA_XMIT_DGRAM_TOO_SHORT:
+	case IRDMA_AE_UDA_XMIT_DGRAM_TOO_LONG:
+	case IRDMA_AE_UDA_L4LEN_INVALID:
+	case IRDMA_AE_DDP_UBE_INVALID_MO:
+	case IRDMA_AE_DDP_UBE_DDP_MESSAGE_TOO_LONG_FOR_AVAILABLE_BUFFER:
+		qp_err.flush_code = FLUSH_LOC_LEN_ERR;
+		qp_err.event_type = IRDMA_QP_EVENT_CATASTROPHIC;
+		break;
+	case IRDMA_AE_AMP_INVALIDATE_NO_REMOTE_ACCESS_RIGHTS:
+	case IRDMA_AE_IB_REMOTE_ACCESS_ERROR:
+		qp_err.flush_code = FLUSH_REM_ACCESS_ERR;
+		qp_err.event_type = IRDMA_QP_EVENT_ACCESS_ERR;
+		break;
+	case IRDMA_AE_AMP_MWBIND_INVALID_RIGHTS:
+	case IRDMA_AE_AMP_MWBIND_BIND_DISABLED:
+	case IRDMA_AE_AMP_MWBIND_INVALID_BOUNDS:
+	case IRDMA_AE_AMP_MWBIND_VALID_STAG:
+		qp_err.flush_code = FLUSH_MW_BIND_ERR;
+		qp_err.event_type = IRDMA_QP_EVENT_ACCESS_ERR;
+		break;
+	case IRDMA_AE_LLP_TOO_MANY_RETRIES:
+		qp_err.flush_code = FLUSH_RETRY_EXC_ERR;
+		qp_err.event_type = IRDMA_QP_EVENT_CATASTROPHIC;
+		break;
+	case IRDMA_AE_IB_INVALID_REQUEST:
+		qp_err.flush_code = FLUSH_REM_INV_REQ_ERR;
+		qp_err.event_type = IRDMA_QP_EVENT_REQ_ERR;
+		break;
+	case IRDMA_AE_LLP_SEGMENT_TOO_SMALL:
+	case IRDMA_AE_LLP_RECEIVED_MPA_CRC_ERROR:
+	case IRDMA_AE_ROCE_RSP_LENGTH_ERROR:
+	case IRDMA_AE_IB_REMOTE_OP_ERROR:
+		qp_err.flush_code = FLUSH_REM_OP_ERR;
+		qp_err.event_type = IRDMA_QP_EVENT_CATASTROPHIC;
+		break;
+	case IRDMA_AE_LLP_TOO_MANY_RNRS:
+		qp_err.flush_code = FLUSH_RNR_RETRY_EXC_ERR;
+		qp_err.event_type = IRDMA_QP_EVENT_CATASTROPHIC;
+		break;
+	case IRDMA_AE_LCE_QP_CATASTROPHIC:
+	case IRDMA_AE_REMOTE_QP_CATASTROPHIC:
+	case IRDMA_AE_LOCAL_QP_CATASTROPHIC:
+	case IRDMA_AE_RCE_QP_CATASTROPHIC:
+		qp_err.flush_code = FLUSH_FATAL_ERR;
+		qp_err.event_type = IRDMA_QP_EVENT_CATASTROPHIC;
+		break;
+	default:
+		qp_err.flush_code = FLUSH_GENERAL_ERR;
+		qp_err.event_type = IRDMA_QP_EVENT_CATASTROPHIC;
+		break;
+	}
+
+	return qp_err;
+}
 #endif /* IRDMA_USER_H */
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 25e46aefe147..982483e641f4 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -542,10 +542,10 @@ static int irdma_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 
 	iwqp->sc_qp.qp_uk.destroy_pending = true;
 
-	if (iwqp->iwarp_state == IRDMA_QP_STATE_RTS)
+	if (iwqp->iwarp_state >= IRDMA_QP_STATE_IDLE)
 		irdma_modify_qp_to_err(&iwqp->sc_qp);
 
-	if (!iwqp->user_mode)
+	if (iwdev->rf->rdma_ver <= IRDMA_GEN_2 && !iwqp->user_mode)
 		cancel_delayed_work_sync(&iwqp->dwork_flush);
 
 	if (!iwqp->user_mode) {
@@ -1043,7 +1043,9 @@ static int irdma_create_qp(struct ib_qp *ibqp,
 		err_code = irdma_setup_umode_qp(udata, iwdev, iwqp, &init_info,
 						init_attr);
 	} else {
-		INIT_DELAYED_WORK(&iwqp->dwork_flush, irdma_flush_worker);
+		if (uk_attrs->hw_rev <= IRDMA_GEN_2)
+			INIT_DELAYED_WORK(&iwqp->dwork_flush,
+					  irdma_flush_worker);
 		init_info.qp_uk_init_info.abi_ver = IRDMA_ABI_VER;
 		err_code = irdma_setup_kmode_qp(iwdev, iwqp, &init_info, init_attr);
 	}
@@ -4095,15 +4097,22 @@ static int irdma_post_send(struct ib_qp *ibqp,
 		ib_wr = ib_wr->next;
 	}
 
-	if (!iwqp->flush_issued) {
-		if (iwqp->hw_iwarp_state <= IRDMA_QP_STATE_RTS)
-			irdma_uk_qp_post_wr(ukqp);
-		spin_unlock_irqrestore(&iwqp->lock, flags);
+	if (ukqp->uk_attrs->hw_rev <= IRDMA_GEN_2) {
+		if (!iwqp->flush_issued) {
+			if (iwqp->hw_iwarp_state <= IRDMA_QP_STATE_RTS)
+				irdma_uk_qp_post_wr(ukqp);
+			spin_unlock_irqrestore(&iwqp->lock, flags);
+		} else {
+			spin_unlock_irqrestore(&iwqp->lock, flags);
+			mod_delayed_work(iwqp->iwdev->cleanup_wq,
+					 &iwqp->dwork_flush,
+					 msecs_to_jiffies(IRDMA_FLUSH_DELAY_MS));
+		}
 	} else {
+		irdma_uk_qp_post_wr(ukqp);
 		spin_unlock_irqrestore(&iwqp->lock, flags);
-		mod_delayed_work(iwqp->iwdev->cleanup_wq, &iwqp->dwork_flush,
-				 msecs_to_jiffies(IRDMA_FLUSH_DELAY_MS));
 	}
+
 	if (err)
 		*bad_wr = ib_wr;
 
@@ -4192,7 +4201,7 @@ static int irdma_post_recv(struct ib_qp *ibqp,
 
 out:
 	spin_unlock_irqrestore(&iwqp->lock, flags);
-	if (iwqp->flush_issued)
+	if (ukqp->uk_attrs->hw_rev <= IRDMA_GEN_2 && iwqp->flush_issued)
 		mod_delayed_work(iwqp->iwdev->cleanup_wq, &iwqp->dwork_flush,
 				 msecs_to_jiffies(IRDMA_FLUSH_DELAY_MS));
 
@@ -4227,6 +4236,8 @@ static enum ib_wc_status irdma_flush_err_to_ib_wc_status(enum irdma_flush_opcode
 		return IB_WC_MW_BIND_ERR;
 	case FLUSH_REM_INV_REQ_ERR:
 		return IB_WC_REM_INV_REQ_ERR;
+	case FLUSH_RNR_RETRY_EXC_ERR:
+		return IB_WC_RNR_RETRY_EXC_ERR;
 	case FLUSH_FATAL_ERR:
 	default:
 		return IB_WC_FATAL_ERR;
-- 
2.42.0


