Return-Path: <linux-rdma+bounces-3969-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D642393B98F
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2024 01:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6324D1F223A2
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jul 2024 23:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5437143C77;
	Wed, 24 Jul 2024 23:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ie/IcvGC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25741494D7
	for <linux-rdma@vger.kernel.org>; Wed, 24 Jul 2024 23:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721864453; cv=none; b=eCs20ASW0Xfp60w3S/Dt0rTH6/Or4ZHKi6p49DolpYbgOaMuHSgC9LcsTNlyJtdAlytslhr4hJnAkBH65P4m5ATAdh5gEofkDXUTliKJECQvPIab5gV3ebZPHQ9d7ZOjS4fl1W1tpXoSOVWBIglgvjiFKr0mZ80asMbhVqzTckA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721864453; c=relaxed/simple;
	bh=l29p/3BbnxZ+jD81BxeplAP+MiXiUV0uNhGpolCg9Jg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u/LAohKIf72DA1AUoPyAl8m71jYi2KnyAXY2J0a7gS2LiF/ihCo06IdrOt9d7qX8tJ7qNv49xhR9yLvXhkSbZK18HwEEIj1fRgpFSlWb1wAkdXsSxi0ct5l4jzdDf60nDa8SqdTpeNjvF7YlJWXXaGRafjCVSILr3nWZ9xvAc7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ie/IcvGC; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721864452; x=1753400452;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l29p/3BbnxZ+jD81BxeplAP+MiXiUV0uNhGpolCg9Jg=;
  b=Ie/IcvGC9j3CTcaeJL2FbcBRo2D6X3PL4mRAaqVGwmdBYDVQ5AcQpcTk
   2/eMqHTwoM8HjefVSpKQvYWtIZtFJ+3yAoAYSkQJ9g7kafXib1h1gmh7C
   mxzZLTi2arWqz6B5fFWOArfc8ufr/lR1D3D31gpzsXfA7aHJUUzrOpQxw
   /Q/LyOZx4EZza5ViB/U2e2FxAhE1PZ1bg0lnpFUW5n+xxqBn0cVGO+thm
   VmXLKeAQVo0Z7jd7k6gf9JLWWa9pmHctFkaa1r8KtWiu/kT9xF6tEPmcY
   QiKXfd8LhkAeacDSbjxS0vejKoRs9XY5SupLaZn3FJF16gTBtQ2EUArMh
   Q==;
X-CSE-ConnectionGUID: svJ32GkyQhqLrLu2XUYUtg==
X-CSE-MsgGUID: 6peAIfokTg6oNIewwP/fKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="44999798"
X-IronPort-AV: E=Sophos;i="6.09,234,1716274800"; 
   d="scan'208";a="44999798"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 16:40:46 -0700
X-CSE-ConnectionGUID: GBS02B83QF+1JwpY5SNSww==
X-CSE-MsgGUID: eUdYaBN4RiGaq6SajW810Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,234,1716274800"; 
   d="scan'208";a="52426099"
Received: from tenikolo-mobl1.amr.corp.intel.com ([10.124.96.138])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 16:40:45 -0700
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	mustafa.ismail@intel.com,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Subject: [RFC PATCH 21/25] RDMA/irdma: Restrict Memory Window and CQE Timestamping to GEN3
Date: Wed, 24 Jul 2024 18:39:13 -0500
Message-Id: <20240724233917.704-22-tatyana.e.nikolova@intel.com>
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

With the deprecation of Memory Window and Timestamping support in GEN2,
move these features to be exclusive to GEN3. This iteration supports
only Type2 Memory Windows. Additionally, it includes the reporting of
the timestamp mask and Host Channel Adapter (HCA) core clock frequency
via the query device verb.

Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
---
 drivers/infiniband/hw/irdma/verbs.c | 39 ++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 868722b..66439706 100644
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
@@ -59,6 +60,13 @@ static int irdma_query_device(struct ib_device *ibdev,
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
@@ -795,7 +803,8 @@ static void irdma_roce_fill_and_set_qpctx_info(struct irdma_qp *iwqp,
 		roce_info->is_qp1 = true;
 	roce_info->rd_en = true;
 	roce_info->wr_rdresp_en = true;
-	roce_info->bind_en = true;
+	if (dev->hw_attrs.uk_attrs.hw_rev >= IRDMA_GEN_3)
+		roce_info->bind_en = true;
 	roce_info->dcqcn_en = false;
 	roce_info->rtomin = 5;
 
@@ -826,7 +835,6 @@ static void irdma_iw_fill_and_set_qpctx_info(struct irdma_qp *iwqp,
 	ether_addr_copy(iwarp_info->mac_addr, iwdev->netdev->dev_addr);
 	iwarp_info->rd_en = true;
 	iwarp_info->wr_rdresp_en = true;
-	iwarp_info->bind_en = true;
 	iwarp_info->ecn_en = true;
 	iwarp_info->rtomin = 5;
 
@@ -1144,8 +1152,6 @@ static int irdma_get_ib_acc_flags(struct irdma_qp *iwqp)
 		}
 		if (iwqp->iwarp_info.rd_en)
 			acc_flags |= IB_ACCESS_REMOTE_READ;
-		if (iwqp->iwarp_info.bind_en)
-			acc_flags |= IB_ACCESS_MW_BIND;
 	}
 	return acc_flags;
 }
@@ -2425,8 +2431,8 @@ static int irdma_query_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr)
 
 static inline int cq_validate_flags(u32 flags, u8 hw_rev)
 {
-	/* GEN1 does not support CQ create flags */
-	if (hw_rev == IRDMA_GEN_1)
+	/* GEN1/2 does not support CQ create flags */
+	if (hw_rev <= IRDMA_GEN_2)
 		return flags ? -EOPNOTSUPP : 0;
 
 	return flags & ~IB_UVERBS_CQ_FLAGS_TIMESTAMP_COMPLETION ? -EOPNOTSUPP : 0;
@@ -2647,8 +2653,9 @@ static int irdma_create_cq(struct ib_cq *ibcq,
 /**
  * irdma_get_mr_access - get hw MR access permissions from IB access flags
  * @access: IB access flags
+ * @hw_rev: Hardware version
  */
-static inline u16 irdma_get_mr_access(int access)
+static inline u16 irdma_get_mr_access(int access, u8 hw_rev)
 {
 	u16 hw_access = 0;
 
@@ -2658,8 +2665,10 @@ static inline u16 irdma_get_mr_access(int access)
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
@@ -3229,7 +3238,8 @@ static int irdma_hwreg_mr(struct irdma_device *iwdev, struct irdma_mr *iwmr,
 	stag_info->stag_idx = iwmr->stag >> IRDMA_CQPSQ_STAG_IDX_S;
 	stag_info->stag_key = (u8)iwmr->stag;
 	stag_info->total_len = iwmr->len;
-	stag_info->access_rights = irdma_get_mr_access(access);
+	stag_info->access_rights = irdma_get_mr_access(access,
+						       iwdev->rf->sc_dev.hw_attrs.uk_attrs.hw_rev);
 	stag_info->pd_id = iwpd->sc_pd.pd_id;
 	stag_info->all_memory = pd->flags & IB_PD_UNSAFE_GLOBAL_RKEY;
 	if (stag_info->access_rights & IRDMA_ACCESS_FLAGS_ZERO_BASED)
@@ -4014,7 +4024,9 @@ static int irdma_post_send(struct ib_qp *ibqp,
 
 			stag_info.signaled = info.signaled;
 			stag_info.read_fence = info.read_fence;
-			stag_info.access_rights = irdma_get_mr_access(reg_wr(ib_wr)->access);
+			stag_info.access_rights =
+				irdma_get_mr_access(reg_wr(ib_wr)->access,
+						    dev->hw_attrs.uk_attrs.hw_rev);
 			stag_info.stag_key = reg_wr(ib_wr)->key & 0xff;
 			stag_info.stag_idx = reg_wr(ib_wr)->key >> 8;
 			stag_info.page_size = reg_wr(ib_wr)->mr->page_size;
@@ -5217,7 +5229,9 @@ static enum rdma_link_layer irdma_get_link_layer(struct ib_device *ibdev,
 };
 
 static const struct ib_device_ops irdma_gen3_dev_ops = {
+	.alloc_mw = irdma_alloc_mw,
 	.create_srq = irdma_create_srq,
+	.dealloc_mw = irdma_dealloc_mw,
 	.destroy_srq = irdma_destroy_srq,
 	.modify_srq = irdma_modify_srq,
 	.post_srq_recv = irdma_post_srq_recv,
@@ -5258,7 +5272,6 @@ static enum rdma_link_layer irdma_get_link_layer(struct ib_device *ibdev,
 
 	.alloc_hw_port_stats = irdma_alloc_hw_port_stats,
 	.alloc_mr = irdma_alloc_mr,
-	.alloc_mw = irdma_alloc_mw,
 	.alloc_pd = irdma_alloc_pd,
 	.alloc_ucontext = irdma_alloc_ucontext,
 	.create_cq = irdma_create_cq,
-- 
1.8.3.1


