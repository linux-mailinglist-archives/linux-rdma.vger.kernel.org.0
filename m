Return-Path: <linux-rdma+bounces-14153-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 87410C22F6F
	for <lists+linux-rdma@lfdr.de>; Fri, 31 Oct 2025 03:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B2A684ECB24
	for <lists+linux-rdma@lfdr.de>; Fri, 31 Oct 2025 02:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B142741C9;
	Fri, 31 Oct 2025 02:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CvWQ6tUR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA4916CD33
	for <linux-rdma@vger.kernel.org>; Fri, 31 Oct 2025 02:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761877087; cv=none; b=ZU6S+OjSVkb+oOA2ps29bMM+7066hHBKw66mLOi4HKEqt0pScw5Z+8jRG7Lqee/8MkJCq1E7VZJHZ7qlL3hXxJSa6MBu473v0P2aiWRPfLGVLgvYPhXaMQebd18I6bvrF2mPu3L/LjLaYfATS3T7Ffz3sikEKsq8fuaTdZvVOoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761877087; c=relaxed/simple;
	bh=aBYTksIr7jH1PM3iO1D6vrzHmVzkOLcakbGX+HINh88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jQGIfa+NHsfRctxiAugaiQQbiTk/YEww/YaAl/QkUw3SULxmEmKo2+oQAyMKiIDeseIA3qFkdGuepFoXh5hqJsPF4h+uNlpOWCgYRYtwxCtCCawZ3tlniDWz4iab9h6wm+Lck9pjbq9dcFCiOEItgfBv14FZI7DxdBrkjxiTKhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CvWQ6tUR; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761877086; x=1793413086;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aBYTksIr7jH1PM3iO1D6vrzHmVzkOLcakbGX+HINh88=;
  b=CvWQ6tURCThUIzoDkXKouxrcyEcqG+kQDqe4/j+fCWTX2CsCdDyDBksf
   GgzVq2HgqN1Sejp3fhoPHY3W8od/O9dRfq342QNc8k9Y8g0LJKq4en4m1
   hJ1rWnxca8+/2MCcy5hFOP6xVBLOZIke8Pzolrduy96742r9VScfmQ1Np
   vTjUTFZZaf4g7YgFNDdbYeAzdM0GeYF/srmowrx+gJzRBQbnQAxwwFkgh
   2drqpNmm6pVghoTdJoU4Lag0J4aP7VAohZo7sYBcv7ESkaKT/IEEgN8gM
   mi5DrEkuAK0uAmcQ4IUxHQkEBalSRdy5pUiTMDOIfkevOhBIYND0U6q0i
   g==;
X-CSE-ConnectionGUID: WX3tzAaqTMKY86WCsG0eng==
X-CSE-MsgGUID: TsYOfm26QEC1Nvuc0tja5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="64182214"
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="64182214"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 19:18:05 -0700
X-CSE-ConnectionGUID: 358MAvtmTOme86SPb7AWCw==
X-CSE-MsgGUID: 2gejOCJzTn2EeiU7jIc/eQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="216950169"
Received: from pthorat-mobl.amr.corp.intel.com (HELO soc-PF51RAGT.clients.intel.com) ([10.246.116.180])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 19:18:04 -0700
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	krzysztof.czurylo@intel.com,
	Jay Bhat <jay.bhat@intel.com>,
	Jacob Moroni <jmoroni@google.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Subject: [PATCH] RDMA/irdma: Initialize cqp_cmds_info to prevent resource leaks
Date: Thu, 30 Oct 2025 21:17:21 -0500
Message-ID: <20251031021726.1003-2-tatyana.e.nikolova@intel.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20251031021726.1003-1-tatyana.e.nikolova@intel.com>
References: <20251031021726.1003-1-tatyana.e.nikolova@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jay Bhat <jay.bhat@intel.com>

Failure to initialize info.create field to false in certain cases
was resulting in incorrect status code going to rdma-core when dereg_mr
failed during reset.  To fix this, memset entire cqp_request->info
in irdma_alloc_and_get_cqp_request() function, so that this is not spread
all over the code.

Signed-off-by: Bhat, Jay <jay.bhat@intel.com>
Reviewed-by: Jacob Moroni <jmoroni@google.com>
Signed-off-by: Krzysztof Czurylo <krzysztof.czurylo@intel.com>
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
---
 drivers/infiniband/hw/irdma/hw.c    | 3 ---
 drivers/infiniband/hw/irdma/utils.c | 6 +-----
 drivers/infiniband/hw/irdma/verbs.c | 4 ----
 3 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/hw.c b/drivers/infiniband/hw/irdma/hw.c
index 7bad0e38786a..d1fc5726b979 100644
--- a/drivers/infiniband/hw/irdma/hw.c
+++ b/drivers/infiniband/hw/irdma/hw.c
@@ -2365,7 +2365,6 @@ static int irdma_cqp_manage_apbvt_cmd(struct irdma_device *iwdev,
 
 	cqp_info = &cqp_request->info;
 	info = &cqp_info->in.u.manage_apbvt_entry.info;
-	memset(info, 0, sizeof(*info));
 	info->add = add_port;
 	info->port = accel_local_port;
 	cqp_info->cqp_cmd = IRDMA_OP_MANAGE_APBVT_ENTRY;
@@ -2474,7 +2473,6 @@ void irdma_manage_arp_cache(struct irdma_pci_f *rf,
 	if (action == IRDMA_ARP_ADD) {
 		cqp_info->cqp_cmd = IRDMA_OP_ADD_ARP_CACHE_ENTRY;
 		info = &cqp_info->in.u.add_arp_cache_entry.info;
-		memset(info, 0, sizeof(*info));
 		info->arp_index = (u16)arp_index;
 		info->permanent = true;
 		ether_addr_copy(info->mac_addr, mac_addr);
@@ -2533,7 +2531,6 @@ int irdma_manage_qhash(struct irdma_device *iwdev, struct irdma_cm_info *cminfo,
 
 	cqp_info = &cqp_request->info;
 	info = &cqp_info->in.u.manage_qhash_table_entry.info;
-	memset(info, 0, sizeof(*info));
 	info->vsi = &iwdev->vsi;
 	info->manage = mtype;
 	info->entry_type = etype;
diff --git a/drivers/infiniband/hw/irdma/utils.c b/drivers/infiniband/hw/irdma/utils.c
index 8b94d87b0192..3b19e2b997b0 100644
--- a/drivers/infiniband/hw/irdma/utils.c
+++ b/drivers/infiniband/hw/irdma/utils.c
@@ -452,6 +452,7 @@ struct irdma_cqp_request *irdma_alloc_and_get_cqp_request(struct irdma_cqp *cqp,
 	cqp_request->waiting = wait;
 	refcount_set(&cqp_request->refcnt, 1);
 	memset(&cqp_request->compl_info, 0, sizeof(cqp_request->compl_info));
+	memset(&cqp_request->info, 0, sizeof(cqp_request->info));
 
 	return cqp_request;
 }
@@ -1068,7 +1069,6 @@ int irdma_cqp_qp_create_cmd(struct irdma_sc_dev *dev, struct irdma_sc_qp *qp)
 
 	cqp_info = &cqp_request->info;
 	qp_info = &cqp_request->info.in.u.qp_create.info;
-	memset(qp_info, 0, sizeof(*qp_info));
 	qp_info->cq_num_valid = true;
 	qp_info->next_iwarp_state = IRDMA_QP_STATE_RTS;
 	cqp_info->cqp_cmd = IRDMA_OP_QP_CREATE;
@@ -1343,7 +1343,6 @@ int irdma_cqp_qp_destroy_cmd(struct irdma_sc_dev *dev, struct irdma_sc_qp *qp)
 		return -ENOMEM;
 
 	cqp_info = &cqp_request->info;
-	memset(cqp_info, 0, sizeof(*cqp_info));
 	cqp_info->cqp_cmd = IRDMA_OP_QP_DESTROY;
 	cqp_info->post_sq = 1;
 	cqp_info->in.u.qp_destroy.qp = qp;
@@ -1749,7 +1748,6 @@ int irdma_cqp_gather_stats_cmd(struct irdma_sc_dev *dev,
 		return -ENOMEM;
 
 	cqp_info = &cqp_request->info;
-	memset(cqp_info, 0, sizeof(*cqp_info));
 	cqp_info->cqp_cmd = IRDMA_OP_STATS_GATHER;
 	cqp_info->post_sq = 1;
 	cqp_info->in.u.stats_gather.info = pestat->gather_info;
@@ -1789,7 +1787,6 @@ int irdma_cqp_stats_inst_cmd(struct irdma_sc_vsi *vsi, u8 cmd,
 		return -ENOMEM;
 
 	cqp_info = &cqp_request->info;
-	memset(cqp_info, 0, sizeof(*cqp_info));
 	cqp_info->cqp_cmd = cmd;
 	cqp_info->post_sq = 1;
 	cqp_info->in.u.stats_manage.info = *stats_info;
@@ -1890,7 +1887,6 @@ int irdma_cqp_ws_node_cmd(struct irdma_sc_dev *dev, u8 cmd,
 		return -ENOMEM;
 
 	cqp_info = &cqp_request->info;
-	memset(cqp_info, 0, sizeof(*cqp_info));
 	cqp_info->cqp_cmd = cmd;
 	cqp_info->post_sq = 1;
 	cqp_info->in.u.ws_node.info = *node_info;
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 76ce6137f2ba..8a6dd3abec40 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -771,7 +771,6 @@ static int irdma_cqp_create_qp_cmd(struct irdma_qp *iwqp)
 
 	cqp_info = &cqp_request->info;
 	qp_info = &cqp_request->info.in.u.qp_create.info;
-	memset(qp_info, 0, sizeof(*qp_info));
 	qp_info->mac_valid = true;
 	qp_info->cq_num_valid = true;
 	qp_info->next_iwarp_state = IRDMA_QP_STATE_IDLE;
@@ -3102,7 +3101,6 @@ static int irdma_hw_alloc_stag(struct irdma_device *iwdev,
 
 	cqp_info = &cqp_request->info;
 	info = &cqp_info->in.u.alloc_stag.info;
-	memset(info, 0, sizeof(*info));
 	info->page_size = PAGE_SIZE;
 	info->stag_idx = iwmr->stag >> IRDMA_CQPSQ_STAG_IDX_S;
 	info->pd_id = iwpd->sc_pd.pd_id;
@@ -3252,7 +3250,6 @@ static int irdma_hwreg_mr(struct irdma_device *iwdev, struct irdma_mr *iwmr,
 
 	cqp_info = &cqp_request->info;
 	stag_info = &cqp_info->in.u.mr_reg_non_shared.info;
-	memset(stag_info, 0, sizeof(*stag_info));
 	stag_info->va = iwpbl->user_base;
 	stag_info->stag_idx = iwmr->stag >> IRDMA_CQPSQ_STAG_IDX_S;
 	stag_info->stag_key = (u8)iwmr->stag;
@@ -3646,7 +3643,6 @@ static int irdma_hwdereg_mr(struct ib_mr *ib_mr)
 
 	cqp_info = &cqp_request->info;
 	info = &cqp_info->in.u.dealloc_stag.info;
-	memset(info, 0, sizeof(*info));
 	info->pd_id = iwpd->sc_pd.pd_id;
 	info->stag_idx = ib_mr->rkey >> IRDMA_CQPSQ_STAG_IDX_S;
 	info->mr = true;
-- 
2.31.1


