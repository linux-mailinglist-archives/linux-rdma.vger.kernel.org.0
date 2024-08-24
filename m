Return-Path: <linux-rdma+bounces-4549-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3B995DAF8
	for <lists+linux-rdma@lfdr.de>; Sat, 24 Aug 2024 05:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52B191F2298F
	for <lists+linux-rdma@lfdr.de>; Sat, 24 Aug 2024 03:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71B0811EB;
	Sat, 24 Aug 2024 03:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AMjqhJnT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1BA7DA74;
	Sat, 24 Aug 2024 03:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724469655; cv=none; b=sgdB3s+BUJqVTjg7EROVyom5WtpvO8UD7uuxi4F6mmvVYxEw2/kmQaWWIOVkqrV0/Slk98JmBc0SsPLpjJSl+8Yfv73cbJJrkyw5phwAJX2DUl2p2eVBPCBwz0SKGI56xy1zRKZI6otma5o4yBifo2CX/dBcON05E5eLKTYbKZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724469655; c=relaxed/simple;
	bh=sAC3wKZvcX/7SmHj6X/vFBbBlJmpi65c71bKjUJIXys=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=smKEJxfcS9eT02A85zqg2YgyLIvaleVkWIKfmaMsEzidAFuEYh4A/tm0wjtqtg0IhwhqhX8KuoO734Mt8PdLni7QjSTnVToPwARC1Rp7pM4pTolJLagdOZs+s8yUL5CyRRY6aKXKsKS9W5rqjq6zqxFotChEp62MvSxUw+MnFik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AMjqhJnT; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724469654; x=1756005654;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sAC3wKZvcX/7SmHj6X/vFBbBlJmpi65c71bKjUJIXys=;
  b=AMjqhJnTfjNU5LiH7bDftcnrEk6+U8ek5STH/f0uOYhwYQ5obaSE7yJv
   8HZVMdZpByYjYEbqMbfyqtTagJ/UlCfI7VYTX12Y3cuGRLywc7ZdhFrK+
   d8/TdPFrI77TeaEt3pqELuUs+TrpqluliL7AMfKd+9O+2lj+2ap09MLab
   wVhb7cbEDHRxcmvoPz25U3ghKoXevDHT8zxCl9EuiYXMCumQBsdc0S8cQ
   8eGqgqEZil3KJ5uYgbXyxYbTDe4qLymyvkeuwr0o2UTm8BXf/PKab9uqE
   Ar58XmQUK8IT+hFOyfV4LbkF+I52JSqguzZv0EkXo80hz8W+I8nO6Slaa
   A==;
X-CSE-ConnectionGUID: RYtKCEH2RrixHBbTOxNLrg==
X-CSE-MsgGUID: /yXgd5fpTWKB9OSNTnHPLQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11173"; a="13187822"
X-IronPort-AV: E=Sophos;i="6.10,172,1719903600"; 
   d="scan'208";a="13187822"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 20:20:49 -0700
X-CSE-ConnectionGUID: YqAOFIT0RdC6nQE+ps2bYg==
X-CSE-MsgGUID: oR/gG0G1T5KwjmQhgpI5PQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,172,1719903600"; 
   d="scan'208";a="99492132"
Received: from tenikolo-mobl1.amr.corp.intel.com ([10.124.36.66])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 20:20:48 -0700
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Subject: [RFC v2 19/25] RDMA/irdma: Support 64-byte CQEs and GEN3 CQE opcode decoding
Date: Fri, 23 Aug 2024 22:19:18 -0500
Message-Id: <20240824031924.421-20-tatyana.e.nikolova@intel.com>
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

Introduce support for 64-byte CQEs in GEN3 devices. Additionally,
implement GEN3-specific CQE opcode decoding.

Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
---
 drivers/infiniband/hw/irdma/verbs.c | 19 +++++++++++++++----
 drivers/infiniband/hw/irdma/verbs.h | 13 +++++++++++++
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 950d7570a5c6..4c7fbdce4433 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -2115,6 +2115,7 @@ static int irdma_create_cq(struct ib_cq *ibcq,
 	unsigned long flags;
 	int err_code;
 	int entries = attr->cqe;
+	bool cqe_64byte_ena;
 
 	err_code = cq_validate_flags(attr->flags, dev->hw_attrs.uk_attrs.hw_rev);
 	if (err_code)
@@ -2138,6 +2139,9 @@ static int irdma_create_cq(struct ib_cq *ibcq,
 	info.dev = dev;
 	ukinfo->cq_size = max(entries, 4);
 	ukinfo->cq_id = cq_num;
+	cqe_64byte_ena = dev->hw_attrs.uk_attrs.feature_flags & IRDMA_FEATURE_64_BYTE_CQE ?
+			 true : false;
+	ukinfo->avoid_mem_cflct = cqe_64byte_ena;
 	iwcq->ibcq.cqe = info.cq_uk_init_info.cq_size;
 	if (attr->comp_vector < rf->ceqs_count)
 		info.ceq_id = attr->comp_vector;
@@ -2213,11 +2217,14 @@ static int irdma_create_cq(struct ib_cq *ibcq,
 		}
 
 		entries++;
-		if (dev->hw_attrs.uk_attrs.hw_rev >= IRDMA_GEN_2)
+		if (!cqe_64byte_ena && dev->hw_attrs.uk_attrs.hw_rev >= IRDMA_GEN_2)
 			entries *= 2;
 		ukinfo->cq_size = entries;
 
-		rsize = info.cq_uk_init_info.cq_size * sizeof(struct irdma_cqe);
+		if (cqe_64byte_ena)
+			rsize = info.cq_uk_init_info.cq_size * sizeof(struct irdma_extended_cqe);
+		else
+			rsize = info.cq_uk_init_info.cq_size * sizeof(struct irdma_cqe);
 		iwcq->kmem.size = ALIGN(round_up(rsize, 256), 256);
 		iwcq->kmem.va = dma_alloc_coherent(dev->hw->device,
 						   iwcq->kmem.size,
@@ -3775,8 +3782,12 @@ static void irdma_process_cqe(struct ib_wc *entry,
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
2.42.0


