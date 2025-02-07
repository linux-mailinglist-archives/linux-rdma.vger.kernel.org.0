Return-Path: <linux-rdma+bounces-7548-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A3EA2CD32
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 20:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A41CE188830B
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 19:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7ABF1D5ADA;
	Fri,  7 Feb 2025 19:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BkVBOx63"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42EF19D89D;
	Fri,  7 Feb 2025 19:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738957840; cv=none; b=PO6eciOFwp4UDnE64pK9fJZ7kcGSXXf139mxLJMtWgZTItYrWfUbHpgLkPOiDlee9F/QAT9iJ4dMmdmAEyLwLu4RSFZh1lf3BxjyOPcHKyGdAVmRHioElsRyJfUS4dcwU3hXIXIW+EuAS/Bnaqrth2VJbNjuJEiJZoKKgMWoalQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738957840; c=relaxed/simple;
	bh=1njxF/OFVSBb3pfansdKiMVBWz6FlLcT259jhGIRIJY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iUQKHXuXEgJkImtzxNlx+72uhbbFQb5nv2kGgegfe+ht+9+EqB90SHhVoXRWUv9WnzL1PO38qXgBWrEIAqyeo0LlQJyLZk5DD3VADT2Smi5EyBMd3b4FV/kI04fs/goff9Y7yiQS0i7pOcwSb7cpIR3sUxoWdXy4uXIBdzEEu6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BkVBOx63; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738957839; x=1770493839;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1njxF/OFVSBb3pfansdKiMVBWz6FlLcT259jhGIRIJY=;
  b=BkVBOx63e8kAaznTJsLCdWPnpjS9+zpdf41Z8Cs/Iqoqj067TA6vPPmP
   gYrW7zed3+svfuMwrj/bjaqOLLytGhRa7KZtk1axpC7yAd1bVV9uhJBN8
   NiLyXPQ7xT7jSrgfOalBwC1M7v1iKSqTk840mjAUjlbGsk1qv531HZ4S9
   b4CtScmbm2qVmXsiaEFlaDmpthjlgfF3RELG4wMOb1VJqEvylSp0JFacx
   bT1jKScQec41HTQcyOji16+nHQ5mbEVBkZhctPOT8q6+HaTD7yTgN3NgM
   IYLRVFIkf10lhL+oZICx7VAKfy2+Pe0+VsTDxHi2R/4RWNNA2Bx9lFvOV
   w==;
X-CSE-ConnectionGUID: bNF5pMEhTdytAhXayedrTA==
X-CSE-MsgGUID: Imz+OyiGS7m1Iq/6WfOqPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="42451836"
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="42451836"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 11:50:32 -0800
X-CSE-ConnectionGUID: YKpjz0qsRWqU832PMJge3w==
X-CSE-MsgGUID: YmLjrNf2TL6+F1QcX6VgXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="112238245"
Received: from tenikolo-mobl1.amr.corp.intel.com ([10.124.81.134])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 11:50:31 -0800
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org,
	intel-wired-lan@lists.osuosl.org
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Subject: [rdma v3 18/24] RDMA/irdma: Support 64-byte CQEs and GEN3 CQE opcode decoding
Date: Fri,  7 Feb 2025 13:49:25 -0600
Message-Id: <20250207194931.1569-19-tatyana.e.nikolova@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20250207194931.1569-1-tatyana.e.nikolova@intel.com>
References: <20250207194931.1569-1-tatyana.e.nikolova@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shiraz Saleem <shiraz.saleem@intel.com>

Introduce support for 64-byte CQEs in GEN3 devices. Additionally,
implement GEN3-specific CQE opcode decoding.

Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
---

v3:
* Fix detection of CQ empty when avoid_mem_cflct is on.
* In resize CQ, do not double the CQ size if avoid_mem_cflct is on.
* Make CQ size an even number, which is a GEN3 HW requirement.

 drivers/infiniband/hw/irdma/main.h  |  2 +-
 drivers/infiniband/hw/irdma/utils.c |  5 ++++-
 drivers/infiniband/hw/irdma/verbs.c | 30 ++++++++++++++++++++++++-----
 drivers/infiniband/hw/irdma/verbs.h | 13 +++++++++++++
 4 files changed, 43 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/main.h b/drivers/infiniband/hw/irdma/main.h
index f0196aafe59b..0c7f5f730f1f 100644
--- a/drivers/infiniband/hw/irdma/main.h
+++ b/drivers/infiniband/hw/irdma/main.h
@@ -69,7 +69,7 @@ extern struct idc_rdma_core_auxiliary_drv icrdma_core_auxiliary_drv;
 #define IRDMA_MACIP_ADD		1
 #define IRDMA_MACIP_DELETE	2
 
-#define IW_CCQ_SIZE	(IRDMA_CQP_SW_SQSIZE_2048 + 1)
+#define IW_CCQ_SIZE	(IRDMA_CQP_SW_SQSIZE_2048 + 2)
 #define IW_CEQ_SIZE	2048
 #define IW_AEQ_SIZE	2048
 
diff --git a/drivers/infiniband/hw/irdma/utils.c b/drivers/infiniband/hw/irdma/utils.c
index 87c88be47ee3..60ef85e842d1 100644
--- a/drivers/infiniband/hw/irdma/utils.c
+++ b/drivers/infiniband/hw/irdma/utils.c
@@ -2381,7 +2381,10 @@ bool irdma_cq_empty(struct irdma_cq *iwcq)
 	u8 polarity;
 
 	ukcq  = &iwcq->sc_cq.cq_uk;
-	cqe = IRDMA_GET_CURRENT_CQ_ELEM(ukcq);
+	if (ukcq->avoid_mem_cflct)
+		cqe = IRDMA_GET_CURRENT_EXTENDED_CQ_ELEM(ukcq);
+	else
+		cqe = IRDMA_GET_CURRENT_CQ_ELEM(ukcq);
 	get_64bit_val(cqe, 24, &qword3);
 	polarity = (u8)FIELD_GET(IRDMA_CQ_VALID, qword3);
 
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index b5fe5f2fa68b..82a7cec25b52 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -1971,8 +1971,13 @@ static int irdma_resize_cq(struct ib_cq *ibcq, int entries,
 
 	if (!iwcq->user_mode) {
 		entries++;
-		if (rf->sc_dev.hw_attrs.uk_attrs.hw_rev >= IRDMA_GEN_2)
+
+		if (!iwcq->sc_cq.cq_uk.avoid_mem_cflct &&
+		    dev->hw_attrs.uk_attrs.hw_rev >= IRDMA_GEN_2)
 			entries *= 2;
+
+		if (entries & 1)
+			entries += 1; /* cq size must be an even number */
 	}
 
 	info.cq_size = max(entries, 4);
@@ -2115,6 +2120,7 @@ static int irdma_create_cq(struct ib_cq *ibcq,
 	unsigned long flags;
 	int err_code;
 	int entries = attr->cqe;
+	bool cqe_64byte_ena;
 
 	err_code = cq_validate_flags(attr->flags, dev->hw_attrs.uk_attrs.hw_rev);
 	if (err_code)
@@ -2138,6 +2144,9 @@ static int irdma_create_cq(struct ib_cq *ibcq,
 	info.dev = dev;
 	ukinfo->cq_size = max(entries, 4);
 	ukinfo->cq_id = cq_num;
+	cqe_64byte_ena = dev->hw_attrs.uk_attrs.feature_flags & IRDMA_FEATURE_64_BYTE_CQE ?
+			 true : false;
+	ukinfo->avoid_mem_cflct = cqe_64byte_ena;
 	iwcq->ibcq.cqe = info.cq_uk_init_info.cq_size;
 	if (attr->comp_vector < rf->ceqs_count)
 		info.ceq_id = attr->comp_vector;
@@ -2213,11 +2222,18 @@ static int irdma_create_cq(struct ib_cq *ibcq,
 		}
 
 		entries++;
-		if (dev->hw_attrs.uk_attrs.hw_rev >= IRDMA_GEN_2)
+		if (!cqe_64byte_ena && dev->hw_attrs.uk_attrs.hw_rev >= IRDMA_GEN_2)
 			entries *= 2;
+
+		if (entries & 1)
+			entries += 1; /* cq size must be an even number */
+
 		ukinfo->cq_size = entries;
 
-		rsize = info.cq_uk_init_info.cq_size * sizeof(struct irdma_cqe);
+		if (cqe_64byte_ena)
+			rsize = info.cq_uk_init_info.cq_size * sizeof(struct irdma_extended_cqe);
+		else
+			rsize = info.cq_uk_init_info.cq_size * sizeof(struct irdma_cqe);
 		iwcq->kmem.size = ALIGN(round_up(rsize, 256), 256);
 		iwcq->kmem.va = dma_alloc_coherent(dev->hw->device,
 						   iwcq->kmem.size,
@@ -3775,8 +3791,12 @@ static void irdma_process_cqe(struct ib_wc *entry,
 	if (cq_poll_info->q_type == IRDMA_CQE_QTYPE_SQ) {
 		set_ib_wc_op_sq(cq_poll_info, entry);
 	} else {
-		set_ib_wc_op_rq(cq_poll_info, entry,
-				qp->qp_uk.qp_caps & IRDMA_SEND_WITH_IMM);
+		if (qp->dev->hw_attrs.uk_attrs.hw_rev <= IRDMA_GEN_2)
+			set_ib_wc_op_rq(cq_poll_info, entry,
+					qp->qp_uk.qp_caps & IRDMA_SEND_WITH_IMM ?
+					true : false);
+		else
+			set_ib_wc_op_rq_gen_3(cq_poll_info, entry);
 		if (qp->qp_uk.qp_type != IRDMA_QP_TYPE_ROCE_UD &&
 		    cq_poll_info->stag_invalid_set) {
 			entry->ex.invalidate_rkey = cq_poll_info->inv_stag;
diff --git a/drivers/infiniband/hw/irdma/verbs.h b/drivers/infiniband/hw/irdma/verbs.h
index cfa140b36395..fcb163c45252 100644
--- a/drivers/infiniband/hw/irdma/verbs.h
+++ b/drivers/infiniband/hw/irdma/verbs.h
@@ -267,6 +267,19 @@ static inline void set_ib_wc_op_sq(struct irdma_cq_poll_info *cq_poll_info,
 	}
 }
 
+static inline void set_ib_wc_op_rq_gen_3(struct irdma_cq_poll_info *info,
+					 struct ib_wc *entry)
+{
+	switch (info->op_type) {
+	case IRDMA_OP_TYPE_RDMA_WRITE:
+	case IRDMA_OP_TYPE_RDMA_WRITE_SOL:
+		entry->opcode = IB_WC_RECV_RDMA_WITH_IMM;
+		break;
+	default:
+		entry->opcode = IB_WC_RECV;
+	}
+}
+
 static inline void set_ib_wc_op_rq(struct irdma_cq_poll_info *cq_poll_info,
 				   struct ib_wc *entry, bool send_imm_support)
 {
-- 
2.37.3


