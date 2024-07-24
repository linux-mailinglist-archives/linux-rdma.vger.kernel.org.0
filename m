Return-Path: <linux-rdma+bounces-3968-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6439593B98E
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2024 01:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95A421C218F2
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jul 2024 23:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDFB149C41;
	Wed, 24 Jul 2024 23:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XKg8wHme"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA2B1494CB
	for <linux-rdma@vger.kernel.org>; Wed, 24 Jul 2024 23:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721864452; cv=none; b=uVbYW6xbcdcc1T7u+MREfBzodIVaMKYjLzuPvCfh/M0pniRnX+t8AsO22zuYL3cs17t+WHPPsW9PiFI2f9kz8NwpXQW2b8Z7xIRbZbOdz7z1PruP2UHo3SbLKlQDc2kORCVFcdShHc9HcsDSJvokFKTmUy0/X1SBHegnenguCAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721864452; c=relaxed/simple;
	bh=LYLaJegv9oWYBGlquMfKlvWmPTfWuJJ7rV6pJay7R08=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ASVjUKFDwoa/d1VuR3cskW2jvip6GWSO9TLmXH3P3Zi3z9LOOssvOTGdlMaHZh3gtNNyUd4S/sQlXvlHysf4t3fwlnkgnaq50ZXbDxMxdv2UQftia9co3mSb6jwI40kZJvgG3uiXU5rrdgjdzNbsIdBW77+63qAeIFDQaut+xrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XKg8wHme; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721864450; x=1753400450;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LYLaJegv9oWYBGlquMfKlvWmPTfWuJJ7rV6pJay7R08=;
  b=XKg8wHmewQzXsGaQGRaA5RZzZ2gnE6Dwo0tJ1AhnwnxZvHlGQiUCUbTh
   DzXqXR7UuiSZCZcD9B+ML+kaigp5z/NPBRvPeVW4nqUtI6n9IpNJSCDoC
   BDU0Cz9XXdQxQKuQIzoUsGr7FAa63IGavS8nlmJDBzLuRgo6piY6VbNtj
   u+mkSZNPRR9TNEJ4faP05p61TWxtBl14DUvYPlqA7JC8UuRTPdZ6/2/83
   KSr+tZALRPv5LIZ7KoqNhd4+wDrlOKETGujjtYJ6ZYxPP58PpI+mpJxFW
   vWoQUFToYamhdX5Cz8MdoxwAJ/sQb3cxy3ZLT6l3mjLdIHeOXjj4Eh3e5
   Q==;
X-CSE-ConnectionGUID: 6J34YGetSWOf7D8+x6Nsmw==
X-CSE-MsgGUID: lK8pTDXDSSucShR7Kvigpg==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="44999791"
X-IronPort-AV: E=Sophos;i="6.09,234,1716274800"; 
   d="scan'208";a="44999791"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 16:40:45 -0700
X-CSE-ConnectionGUID: 8Q5oNfTrSo2tVa+Ws6acIA==
X-CSE-MsgGUID: wZ9/miywRCa4jmPpAZOgUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,234,1716274800"; 
   d="scan'208";a="52426092"
Received: from tenikolo-mobl1.amr.corp.intel.com ([10.124.96.138])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 16:40:44 -0700
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	mustafa.ismail@intel.com,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Subject: [RFC PATCH 19/25] RDMA/irdma: Support 64-byte CQEs and GEN3 CQE opcode decoding
Date: Wed, 24 Jul 2024 18:39:11 -0500
Message-Id: <20240724233917.704-20-tatyana.e.nikolova@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20240724233917.704-1-tatyana.e.nikolova@intel.com>
References: <20240724233917.704-1-tatyana.e.nikolova@intel.com>
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
index 70652ab..593dbbd 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -2114,6 +2114,7 @@ static int irdma_create_cq(struct ib_cq *ibcq,
 	unsigned long flags;
 	int err_code;
 	int entries = attr->cqe;
+	bool cqe_64byte_ena;
 
 	err_code = cq_validate_flags(attr->flags, dev->hw_attrs.uk_attrs.hw_rev);
 	if (err_code)
@@ -2137,6 +2138,9 @@ static int irdma_create_cq(struct ib_cq *ibcq,
 	info.dev = dev;
 	ukinfo->cq_size = max(entries, 4);
 	ukinfo->cq_id = cq_num;
+	cqe_64byte_ena = dev->hw_attrs.uk_attrs.feature_flags & IRDMA_FEATURE_64_BYTE_CQE ?
+			 true : false;
+	ukinfo->avoid_mem_cflct = cqe_64byte_ena;
 	iwcq->ibcq.cqe = info.cq_uk_init_info.cq_size;
 	if (attr->comp_vector < rf->ceqs_count)
 		info.ceq_id = attr->comp_vector;
@@ -2212,11 +2216,14 @@ static int irdma_create_cq(struct ib_cq *ibcq,
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
@@ -3774,8 +3781,12 @@ static void irdma_process_cqe(struct ib_wc *entry,
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
index cfa140b..fcb163c 100644
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
1.8.3.1


