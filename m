Return-Path: <linux-rdma+bounces-12965-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E78B3869F
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Aug 2025 17:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B693D1C20184
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Aug 2025 15:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3BA28488D;
	Wed, 27 Aug 2025 15:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GclO/3nU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4B9286D7F
	for <linux-rdma@vger.kernel.org>; Wed, 27 Aug 2025 15:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756308426; cv=none; b=CJe0wNH+4CwfZQ/GgZmImdcpq06/SS6pHpC9YhaoBGgYSjYT9Mh0nZtlsnfdAZ5dF6vLVVI0dDabSPtbv0hamdx2Tdj0w6xG4Yf+dnJ4cwDU2N4P6UZPQWnQYSt32WznLzeCkgPzlHZiLV6NQTcFEgo10XQBjG6b9VfWYK8nHGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756308426; c=relaxed/simple;
	bh=3yu3+c/czjUKuGocMxDVDj4tnS86xYZ44NyXfhXi4jM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NTRbP6UR2/CNkXwnRqP917MhweGvPKLba7+6Fq9xLAYHVvotk0Rve/ghhgVHJBHIdEAnMiI5/hUzgXvepdGe0cTmvy5MsUuC9p6VHW0aQ8aoh1cCCwAMcq6hiZ3vU+6/xD0BwMIsHhI7k7UkHqIP80wnD44ULQxKrjLOYUiN2u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GclO/3nU; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756308425; x=1787844425;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3yu3+c/czjUKuGocMxDVDj4tnS86xYZ44NyXfhXi4jM=;
  b=GclO/3nUGNoczTzNj+1APzNmbiIprUIfu2pjp6OwwqmwTRbf88AGwUCI
   K2Y3amBwTnsNeezeLIvKxkg5iUUx0AYCPLtOU+ygSwZX/HL1bJqzbsABo
   iZ309k7kMCXSKvOEIifY6yNk4yRRetbu/gvmnDcaFEv3ACv34wSkf9zaF
   PKlgR5kqc55x+lg+Xv5UbjfejaBPvnF9BTI7sRSZdh38Ihty9Ge+BUM3p
   KKGzf575rybM9dJ4+BHr+H8gmD8wP250WeGWmzdZObbDiyVyoIKXiRAMT
   eVXvmj/YjEWGnP/eC3/xpJmZxQgSnzbZuldzi7aXHkRGI4fo3ePhsom2G
   w==;
X-CSE-ConnectionGUID: 9eYt8F4oQS23CmZHh3SOow==
X-CSE-MsgGUID: 2PI7dklTQUaZPqrrZhrNeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="76162797"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="76162797"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 08:26:43 -0700
X-CSE-ConnectionGUID: i+55Y8WJToCDKj4VAp3zyQ==
X-CSE-MsgGUID: JdSVf8mcRaSnTv7K46KEIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="174206863"
Received: from pthorat-mobl.amr.corp.intel.com (HELO soc-PF51RAGT.clients.intel.com) ([10.246.116.180])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 08:26:42 -0700
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	tatyana.e.nikolova@intel.com,
	krzysztof.czurylo@intel.com
Subject: [for-next 13/16] RDMA/irdma: Restrict Memory Window and CQE Timestamping to GEN3
Date: Wed, 27 Aug 2025 10:25:42 -0500
Message-ID: <20250827152545.2056-14-tatyana.e.nikolova@intel.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250827152545.2056-1-tatyana.e.nikolova@intel.com>
References: <20250827152545.2056-1-tatyana.e.nikolova@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shiraz Saleem <shiraz.saleem@intel.com>

With the deprecation of Memory Window and Timestamping support in GEN2,
move these features to be exclusive to GEN3. This iteration supports
only Type2 Memory Windows. Additionally, it includes the reporting of
the timestamp mask and Host Channel Adapter (HCA) core clock frequency
via the query device verb.

Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
---
 drivers/infiniband/hw/irdma/verbs.c | 42 ++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 16 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 1134a3546d91..78f1db759bab 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -41,7 +41,8 @@ static int irdma_query_device(struct ib_device *ibdev,
 	props->max_cq = rf->max_cq - rf->used_cqs;
 	props->max_cqe = rf->max_cqe - 1;
 	props->max_mr = rf->max_mr - rf->used_mrs;
-	props->max_mw = props->max_mr;
+	if (hw_attrs->uk_attrs.hw_rev >= IRDMA_GEN_3)
+		props->max_mw = props->max_mr;
 	props->max_pd = rf->max_pd - rf->used_pds;
 	props->max_sge_rd = hw_attrs->uk_attrs.max_hw_read_sges;
 	props->max_qp_rd_atom = hw_attrs->max_hw_ird;
@@ -56,12 +57,16 @@ static int irdma_query_device(struct ib_device *ibdev,
 	props->max_mcast_qp_attach = IRDMA_MAX_MGS_PER_CTX;
 	props->max_total_mcast_qp_attach = rf->max_qp * IRDMA_MAX_MGS_PER_CTX;
 	props->max_fast_reg_page_list_len = IRDMA_MAX_PAGES_PER_FMR;
-#define HCA_CLOCK_TIMESTAMP_MASK 0x1ffff
-	if (hw_attrs->uk_attrs.hw_rev >= IRDMA_GEN_2)
-		props->timestamp_mask = HCA_CLOCK_TIMESTAMP_MASK;
 	props->max_srq = rf->max_srq - rf->used_srqs;
 	props->max_srq_wr = IRDMA_MAX_SRQ_WRS;
 	props->max_srq_sge = hw_attrs->uk_attrs.max_hw_wq_frags;
+	if (hw_attrs->uk_attrs.hw_rev >= IRDMA_GEN_3) {
+#define HCA_CORE_CLOCK_KHZ 1000000UL
+		props->timestamp_mask = GENMASK(31, 0);
+		props->hca_core_clock = HCA_CORE_CLOCK_KHZ;
+	}
+	if (hw_attrs->uk_attrs.hw_rev >= IRDMA_GEN_3)
+		props->device_cap_flags |= IB_DEVICE_MEM_WINDOW_TYPE_2B;
 
 	return 0;
 }
@@ -798,7 +803,8 @@ static void irdma_roce_fill_and_set_qpctx_info(struct irdma_qp *iwqp,
 		roce_info->is_qp1 = true;
 	roce_info->rd_en = true;
 	roce_info->wr_rdresp_en = true;
-	roce_info->bind_en = true;
+	if (dev->hw_attrs.uk_attrs.hw_rev >= IRDMA_GEN_3)
+		roce_info->bind_en = true;
 	roce_info->dcqcn_en = false;
 	roce_info->rtomin = 5;
 
@@ -829,7 +835,6 @@ static void irdma_iw_fill_and_set_qpctx_info(struct irdma_qp *iwqp,
 	ether_addr_copy(iwarp_info->mac_addr, iwdev->netdev->dev_addr);
 	iwarp_info->rd_en = true;
 	iwarp_info->wr_rdresp_en = true;
-	iwarp_info->bind_en = true;
 	iwarp_info->ecn_en = true;
 	iwarp_info->rtomin = 5;
 
@@ -1147,8 +1152,6 @@ static int irdma_get_ib_acc_flags(struct irdma_qp *iwqp)
 		}
 		if (iwqp->iwarp_info.rd_en)
 			acc_flags |= IB_ACCESS_REMOTE_READ;
-		if (iwqp->iwarp_info.bind_en)
-			acc_flags |= IB_ACCESS_MW_BIND;
 	}
 	return acc_flags;
 }
@@ -2433,8 +2436,8 @@ static int irdma_query_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr)
 
 static inline int cq_validate_flags(u32 flags, u8 hw_rev)
 {
-	/* GEN1 does not support CQ create flags */
-	if (hw_rev == IRDMA_GEN_1)
+	/* GEN1/2 does not support CQ create flags */
+	if (hw_rev <= IRDMA_GEN_2)
 		return flags ? -EOPNOTSUPP : 0;
 
 	return flags & ~IB_UVERBS_CQ_FLAGS_TIMESTAMP_COMPLETION ? -EOPNOTSUPP : 0;
@@ -2660,8 +2663,9 @@ static int irdma_create_cq(struct ib_cq *ibcq,
 /**
  * irdma_get_mr_access - get hw MR access permissions from IB access flags
  * @access: IB access flags
+ * @hw_rev: Hardware version
  */
-static inline u16 irdma_get_mr_access(int access)
+static inline u16 irdma_get_mr_access(int access, u8 hw_rev)
 {
 	u16 hw_access = 0;
 
@@ -2671,8 +2675,10 @@ static inline u16 irdma_get_mr_access(int access)
 		     IRDMA_ACCESS_FLAGS_REMOTEWRITE : 0;
 	hw_access |= (access & IB_ACCESS_REMOTE_READ) ?
 		     IRDMA_ACCESS_FLAGS_REMOTEREAD : 0;
-	hw_access |= (access & IB_ACCESS_MW_BIND) ?
-		     IRDMA_ACCESS_FLAGS_BIND_WINDOW : 0;
+	if (hw_rev >= IRDMA_GEN_3) {
+		hw_access |= (access & IB_ACCESS_MW_BIND) ?
+			     IRDMA_ACCESS_FLAGS_BIND_WINDOW : 0;
+	}
 	hw_access |= (access & IB_ZERO_BASED) ?
 		     IRDMA_ACCESS_FLAGS_ZERO_BASED : 0;
 	hw_access |= IRDMA_ACCESS_FLAGS_LOCALREAD;
@@ -3242,7 +3248,8 @@ static int irdma_hwreg_mr(struct irdma_device *iwdev, struct irdma_mr *iwmr,
 	stag_info->stag_idx = iwmr->stag >> IRDMA_CQPSQ_STAG_IDX_S;
 	stag_info->stag_key = (u8)iwmr->stag;
 	stag_info->total_len = iwmr->len;
-	stag_info->access_rights = irdma_get_mr_access(access);
+	stag_info->access_rights = irdma_get_mr_access(access,
+						       iwdev->rf->sc_dev.hw_attrs.uk_attrs.hw_rev);
 	stag_info->pd_id = iwpd->sc_pd.pd_id;
 	stag_info->all_memory = pd->flags & IB_PD_UNSAFE_GLOBAL_RKEY;
 	if (stag_info->access_rights & IRDMA_ACCESS_FLAGS_ZERO_BASED)
@@ -4036,7 +4043,9 @@ static int irdma_post_send(struct ib_qp *ibqp,
 
 			stag_info.signaled = info.signaled;
 			stag_info.read_fence = info.read_fence;
-			stag_info.access_rights = irdma_get_mr_access(reg_wr(ib_wr)->access);
+			stag_info.access_rights =
+				irdma_get_mr_access(reg_wr(ib_wr)->access,
+						    dev->hw_attrs.uk_attrs.hw_rev);
 			stag_info.stag_key = reg_wr(ib_wr)->key & 0xff;
 			stag_info.stag_idx = reg_wr(ib_wr)->key >> 8;
 			stag_info.page_size = reg_wr(ib_wr)->mr->page_size;
@@ -5239,7 +5248,9 @@ static const struct ib_device_ops irdma_gen1_dev_ops = {
 };
 
 static const struct ib_device_ops irdma_gen3_dev_ops = {
+	.alloc_mw = irdma_alloc_mw,
 	.create_srq = irdma_create_srq,
+	.dealloc_mw = irdma_dealloc_mw,
 	.destroy_srq = irdma_destroy_srq,
 	.modify_srq = irdma_modify_srq,
 	.post_srq_recv = irdma_post_srq_recv,
@@ -5280,7 +5291,6 @@ static const struct ib_device_ops irdma_dev_ops = {
 
 	.alloc_hw_port_stats = irdma_alloc_hw_port_stats,
 	.alloc_mr = irdma_alloc_mr,
-	.alloc_mw = irdma_alloc_mw,
 	.alloc_pd = irdma_alloc_pd,
 	.alloc_ucontext = irdma_alloc_ucontext,
 	.create_cq = irdma_create_cq,
-- 
2.42.0


