Return-Path: <linux-rdma+bounces-12968-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D00B386A7
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Aug 2025 17:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 329785E54AC
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Aug 2025 15:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4CC283FE9;
	Wed, 27 Aug 2025 15:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z1NIk31A"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E5027E7EE
	for <linux-rdma@vger.kernel.org>; Wed, 27 Aug 2025 15:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756308428; cv=none; b=ixWN4IDAS+X14ZxC7atGbysH7+M2N0NZ34kaLqBr4Hg22EOpMK1SZ0CJ7a1ouZ1M/Cwxws/z8xZDoFGmso88wop14o97/mD97IOORlFGOyYEwCU1rp0lcRF5VsOBgAKgh3iMB7Mv6s+to03oNIeSUlx3Un7OPjyxk73QwHfg7ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756308428; c=relaxed/simple;
	bh=ArPISOayfMIJ+wevO2dLLalPImBXRZmGN541HLx3CMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lfd6M0YF4ru1DoDMPLhrbbcsyhyMk8Df5sdU/BwqZXXEWKGvlzuh3lZY0qXSKQVsW4cViOgtb/5Rrb8JhnUI3GHusHvyozye92G8rjFB8eqoICa7cDEbMNIHoO5KxQHQCOiGgH0A+AWm0g2M4t0qrBrl+iUBWUWFVntfEKlInPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z1NIk31A; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756308427; x=1787844427;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ArPISOayfMIJ+wevO2dLLalPImBXRZmGN541HLx3CMs=;
  b=Z1NIk31AKbYLYPPw+r8zOUDemT7gQEQ/HBjF4c2K5hdf5+7TVX1lFKxt
   p2aAHq3SY57kI1YP+HXZZt8buWaQeKvb+vetJQsEkIvZZOgJ+q7jZCj2M
   HDNFVXMi55BrREAoOhwlKtgjEw+fpjgYHaOH+Waft9AJQ+ZkV6xMPdUfW
   x+em84QZfkBaqPpn//KmVSspCfw5qw0KgkZmIYHA4BhNnPQAHbdSsQjxT
   z8Nhr6i+zxvNiDAlOpuN9NFNPcKfKyld9WmG4Q2Y1Lr8u9I/9VlxJB01j
   uRgxTyiIZP51i1lb2Mc3khJLGI+Bmuq1uA2JnGjClCQ1Fy3hu1rRbqdJZ
   w==;
X-CSE-ConnectionGUID: 2YYjHbGWT0iXWuYao4a49Q==
X-CSE-MsgGUID: RGQejNQQTsCxyJ0CF3lnAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="76162800"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="76162800"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 08:26:43 -0700
X-CSE-ConnectionGUID: vv+PXWKEQB2qYeefU8q0Og==
X-CSE-MsgGUID: RjDaK648S1eYKmdx9PsWpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="174206869"
Received: from pthorat-mobl.amr.corp.intel.com (HELO soc-PF51RAGT.clients.intel.com) ([10.246.116.180])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 08:26:42 -0700
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	tatyana.e.nikolova@intel.com,
	krzysztof.czurylo@intel.com
Subject: [for-next 14/16] RDMA/irdma: Add Atomic Operations support
Date: Wed, 27 Aug 2025 10:25:43 -0500
Message-ID: <20250827152545.2056-15-tatyana.e.nikolova@intel.com>
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

From: Faisal Latif <faisal.latif@intel.com>

Extend irdma to support atomic operations, namely Compare and Swap and
Fetch and Add, for GEN3 devices.

Signed-off-by: Faisal Latif <faisal.latif@intel.com>
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
---

Changes since split:
* Add FEATURE_ATOMIC_OPS checks to protect hardware GEN < GEN3

At [4]:
* Check IRDMA_ATOMICS_ALLOWED_BIT after the feature info has been
read from FW.

 drivers/infiniband/hw/irdma/ctrl.c       |  11 +++
 drivers/infiniband/hw/irdma/defs.h       |  10 ++-
 drivers/infiniband/hw/irdma/ig3rdma_hw.c |   3 -
 drivers/infiniband/hw/irdma/type.h       |   4 +
 drivers/infiniband/hw/irdma/uk.c         | 102 +++++++++++++++++++++++
 drivers/infiniband/hw/irdma/user.h       |  27 ++++++
 drivers/infiniband/hw/irdma/verbs.c      |  48 +++++++++++
 drivers/infiniband/hw/irdma/verbs.h      |   6 ++
 8 files changed, 207 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/ctrl.c b/drivers/infiniband/hw/irdma/ctrl.c
index ef2e46a22c3f..f2a19a856975 100644
--- a/drivers/infiniband/hw/irdma/ctrl.c
+++ b/drivers/infiniband/hw/irdma/ctrl.c
@@ -1110,6 +1110,8 @@ static void irdma_sc_qp_setctx_roce_gen_3(struct irdma_sc_qp *qp,
 		      FIELD_PREP(IRDMAQPC_UDPRIVCQENABLE,
 				 roce_info->udprivcq_en) |
 		      FIELD_PREP(IRDMAQPC_PRIVEN, roce_info->priv_mode_en) |
+		      FIELD_PREP(IRDMAQPC_REMOTE_ATOMIC_EN,
+				 info->remote_atomics_en) |
 		      FIELD_PREP(IRDMAQPC_TIMELYENABLE, roce_info->timely_en));
 	set_64bit_val(qp_ctx, 168,
 		      FIELD_PREP(IRDMAQPC_QPCOMPCTX, info->qp_compl_ctx));
@@ -1490,6 +1492,8 @@ static int irdma_sc_alloc_stag(struct irdma_sc_dev *dev,
 	      FIELD_PREP(IRDMA_CQPSQ_STAG_REMACCENABLED, info->remote_access) |
 	      FIELD_PREP(IRDMA_CQPSQ_STAG_USEHMCFNIDX, info->use_hmc_fcn_index) |
 	      FIELD_PREP(IRDMA_CQPSQ_STAG_USEPFRID, info->use_pf_rid) |
+	      FIELD_PREP(IRDMA_CQPSQ_STAG_REMOTE_ATOMIC_EN,
+			 info->remote_atomics_en) |
 	      FIELD_PREP(IRDMA_CQPSQ_WQEVALID, cqp->polarity);
 	dma_wmb(); /* make sure WQE is written before valid bit is set */
 
@@ -1582,6 +1586,8 @@ static int irdma_sc_mr_reg_non_shared(struct irdma_sc_dev *dev,
 	      FIELD_PREP(IRDMA_CQPSQ_STAG_VABASEDTO, addr_type) |
 	      FIELD_PREP(IRDMA_CQPSQ_STAG_USEHMCFNIDX, info->use_hmc_fcn_index) |
 	      FIELD_PREP(IRDMA_CQPSQ_STAG_USEPFRID, info->use_pf_rid) |
+	      FIELD_PREP(IRDMA_CQPSQ_STAG_REMOTE_ATOMIC_EN,
+			 info->remote_atomics_en) |
 	      FIELD_PREP(IRDMA_CQPSQ_WQEVALID, cqp->polarity);
 	dma_wmb(); /* make sure WQE is written before valid bit is set */
 
@@ -1740,6 +1746,7 @@ int irdma_sc_mr_fast_register(struct irdma_sc_qp *qp,
 	      FIELD_PREP(IRDMAQPSQ_READFENCE, info->read_fence) |
 	      FIELD_PREP(IRDMAQPSQ_LOCALFENCE, info->local_fence) |
 	      FIELD_PREP(IRDMAQPSQ_SIGCOMPL, info->signaled) |
+	      FIELD_PREP(IRDMAQPSQ_REMOTE_ATOMICS_EN, info->remote_atomics_en) |
 	      FIELD_PREP(IRDMAQPSQ_VALID, qp->qp_uk.swqe_polarity);
 	dma_wmb(); /* make sure WQE is written before valid bit is set */
 
@@ -5542,6 +5549,10 @@ int irdma_get_rdma_features(struct irdma_sc_dev *dev)
 		}
 		dev->feature_info[feat_type] = temp;
 	}
+
+	if (dev->feature_info[IRDMA_FTN_FLAGS] & IRDMA_ATOMICS_ALLOWED_BIT)
+		dev->hw_attrs.uk_attrs.feature_flags |= IRDMA_FEATURE_ATOMIC_OPS;
+
 exit:
 	dma_free_coherent(dev->hw->device, feat_buf.size, feat_buf.va,
 			  feat_buf.pa);
diff --git a/drivers/infiniband/hw/irdma/defs.h b/drivers/infiniband/hw/irdma/defs.h
index 408058b6ba55..3b3680816a65 100644
--- a/drivers/infiniband/hw/irdma/defs.h
+++ b/drivers/infiniband/hw/irdma/defs.h
@@ -189,6 +189,8 @@ enum irdma_protocol_used {
 #define IRDMAQP_OP_RDMA_READ_LOC_INV		0x0b
 #define IRDMAQP_OP_NOP				0x0c
 #define IRDMAQP_OP_RDMA_WRITE_SOL		0x0d
+#define IRDMAQP_OP_ATOMIC_FETCH_ADD		0x0f
+#define IRDMAQP_OP_ATOMIC_COMPARE_SWAP_ADD	0x11
 #define IRDMAQP_OP_GEN_RTS_AE			0x30
 
 enum irdma_cqp_op_type {
@@ -694,7 +696,8 @@ enum irdma_cqp_op_type {
 #define IRDMA_CQPSQ_STAG_USEPFRID BIT_ULL(61)
 
 #define IRDMA_CQPSQ_STAG_PBA IRDMA_CQPHC_QPCTX
-#define IRDMA_CQPSQ_STAG_HMCFNIDX GENMASK_ULL(5, 0)
+#define IRDMA_CQPSQ_STAG_HMCFNIDX GENMASK_ULL(15, 0)
+#define IRDMA_CQPSQ_STAG_REMOTE_ATOMIC_EN BIT_ULL(61)
 
 #define IRDMA_CQPSQ_STAG_FIRSTPMPBLIDX GENMASK_ULL(27, 0)
 #define IRDMA_CQPSQ_QUERYSTAG_IDX IRDMA_CQPSQ_STAG_IDX
@@ -981,6 +984,9 @@ enum irdma_cqp_op_type {
 
 #define IRDMAQPSQ_REMTO IRDMA_CQPHC_QPCTX
 
+#define IRDMAQPSQ_STAG GENMASK_ULL(31, 0)
+#define IRDMAQPSQ_REMOTE_STAG GENMASK_ULL(31, 0)
+
 #define IRDMAQPSQ_STAGRIGHTS GENMASK_ULL(52, 48)
 #define IRDMAQPSQ_VABASEDTO BIT_ULL(53)
 #define IRDMAQPSQ_MEMWINDOWTYPE BIT_ULL(54)
@@ -991,6 +997,8 @@ enum irdma_cqp_op_type {
 
 #define IRDMAQPSQ_BASEVA_TO_FBO IRDMA_CQPHC_QPCTX
 
+#define IRDMAQPSQ_REMOTE_ATOMICS_EN BIT_ULL(55)
+
 #define IRDMAQPSQ_LOCSTAG GENMASK_ULL(31, 0)
 
 #define IRDMAQPSQ_STAGKEY GENMASK_ULL(7, 0)
diff --git a/drivers/infiniband/hw/irdma/ig3rdma_hw.c b/drivers/infiniband/hw/irdma/ig3rdma_hw.c
index 2a3d7144c771..2e8bb475e22a 100644
--- a/drivers/infiniband/hw/irdma/ig3rdma_hw.c
+++ b/drivers/infiniband/hw/irdma/ig3rdma_hw.c
@@ -120,9 +120,6 @@ void ig3rdma_init_hw(struct irdma_sc_dev *dev)
 	dev->hw_attrs.first_hw_vf_fpm_id = 0;
 	dev->hw_attrs.max_hw_vf_fpm_id = IG3_MAX_APFS + IG3_MAX_AVFS;
 	dev->hw_attrs.uk_attrs.feature_flags |= IRDMA_FEATURE_64_BYTE_CQE;
-	if (dev->feature_info[IRDMA_FTN_FLAGS] & IRDMA_ATOMICS_ALLOWED_BIT)
-		dev->hw_attrs.uk_attrs.feature_flags |=
-			IRDMA_FEATURE_ATOMIC_OPS;
 	dev->hw_attrs.uk_attrs.feature_flags |= IRDMA_FEATURE_CQE_TIMESTAMPING;
 
 	dev->hw_attrs.uk_attrs.feature_flags |= IRDMA_FEATURE_SRQ;
diff --git a/drivers/infiniband/hw/irdma/type.h b/drivers/infiniband/hw/irdma/type.h
index 43dcdc7b846c..c11b901ff119 100644
--- a/drivers/infiniband/hw/irdma/type.h
+++ b/drivers/infiniband/hw/irdma/type.h
@@ -1087,6 +1087,7 @@ struct irdma_qp_host_ctx_info {
 	u32 srq_id;
 	u32 rem_endpoint_idx;
 	u16 stats_idx;
+	bool remote_atomics_en:1;
 	bool srq_valid:1;
 	bool tcp_info_valid:1;
 	bool iwarp_info_valid:1;
@@ -1127,6 +1128,7 @@ struct irdma_allocate_stag_info {
 	bool use_hmc_fcn_index:1;
 	bool use_pf_rid:1;
 	bool all_memory:1;
+	bool remote_atomics_en:1;
 	u16 hmc_fcn_index;
 };
 
@@ -1155,6 +1157,7 @@ struct irdma_reg_ns_stag_info {
 	u8 hmc_fcn_index;
 	bool use_pf_rid:1;
 	bool all_memory:1;
+	bool remote_atomics_en:1;
 };
 
 struct irdma_fast_reg_stag_info {
@@ -1178,6 +1181,7 @@ struct irdma_fast_reg_stag_info {
 	u8 hmc_fcn_index;
 	bool use_pf_rid:1;
 	bool defer_flag:1;
+	bool remote_atomics_en:1;
 };
 
 struct irdma_dealloc_stag_info {
diff --git a/drivers/infiniband/hw/irdma/uk.c b/drivers/infiniband/hw/irdma/uk.c
index e7ffde792781..fb944c49f864 100644
--- a/drivers/infiniband/hw/irdma/uk.c
+++ b/drivers/infiniband/hw/irdma/uk.c
@@ -337,6 +337,108 @@ int irdma_uk_rdma_write(struct irdma_qp_uk *qp, struct irdma_post_sq_info *info,
 	return 0;
 }
 
+/**
+ * irdma_uk_atomic_fetch_add - atomic fetch and add operation
+ * @qp: hw qp ptr
+ * @info: post sq information
+ * @post_sq: flag to post sq
+ */
+int irdma_uk_atomic_fetch_add(struct irdma_qp_uk *qp,
+			      struct irdma_post_sq_info *info, bool post_sq)
+{
+	struct irdma_atomic_fetch_add *op_info;
+	u32 total_size = 0;
+	u16 quanta = 2;
+	u32 wqe_idx;
+	__le64 *wqe;
+	u64 hdr;
+
+	op_info = &info->op.atomic_fetch_add;
+	wqe = irdma_qp_get_next_send_wqe(qp, &wqe_idx, quanta, total_size,
+					 info);
+	if (!wqe)
+		return -ENOMEM;
+
+	set_64bit_val(wqe, 0, op_info->tagged_offset);
+	set_64bit_val(wqe, 8,
+		      FIELD_PREP(IRDMAQPSQ_STAG, op_info->stag));
+	set_64bit_val(wqe, 16, op_info->remote_tagged_offset);
+
+	hdr = FIELD_PREP(IRDMAQPSQ_ADDFRAGCNT, 1) |
+	      FIELD_PREP(IRDMAQPSQ_REMOTE_STAG, op_info->remote_stag) |
+	      FIELD_PREP(IRDMAQPSQ_OPCODE, IRDMAQP_OP_ATOMIC_FETCH_ADD) |
+	      FIELD_PREP(IRDMAQPSQ_READFENCE, info->read_fence) |
+	      FIELD_PREP(IRDMAQPSQ_LOCALFENCE, info->local_fence) |
+	      FIELD_PREP(IRDMAQPSQ_SIGCOMPL, info->signaled) |
+	      FIELD_PREP(IRDMAQPSQ_VALID, qp->swqe_polarity);
+
+	set_64bit_val(wqe, 32, op_info->fetch_add_data_bytes);
+	set_64bit_val(wqe, 40, 0);
+	set_64bit_val(wqe, 48, 0);
+	set_64bit_val(wqe, 56,
+		      FIELD_PREP(IRDMAQPSQ_VALID, qp->swqe_polarity));
+
+	dma_wmb(); /* make sure WQE is populated before valid bit is set */
+
+	set_64bit_val(wqe, 24, hdr);
+
+	if (post_sq)
+		irdma_uk_qp_post_wr(qp);
+
+	return 0;
+}
+
+/**
+ * irdma_uk_atomic_compare_swap - atomic compare and swap operation
+ * @qp: hw qp ptr
+ * @info: post sq information
+ * @post_sq: flag to post sq
+ */
+int irdma_uk_atomic_compare_swap(struct irdma_qp_uk *qp,
+				 struct irdma_post_sq_info *info, bool post_sq)
+{
+	struct irdma_atomic_compare_swap *op_info;
+	u32 total_size = 0;
+	u16 quanta = 2;
+	u32 wqe_idx;
+	__le64 *wqe;
+	u64 hdr;
+
+	op_info = &info->op.atomic_compare_swap;
+	wqe = irdma_qp_get_next_send_wqe(qp, &wqe_idx, quanta, total_size,
+					 info);
+	if (!wqe)
+		return -ENOMEM;
+
+	set_64bit_val(wqe, 0, op_info->tagged_offset);
+	set_64bit_val(wqe, 8,
+		      FIELD_PREP(IRDMAQPSQ_STAG, op_info->stag));
+	set_64bit_val(wqe, 16, op_info->remote_tagged_offset);
+
+	hdr = FIELD_PREP(IRDMAQPSQ_ADDFRAGCNT, 1) |
+	      FIELD_PREP(IRDMAQPSQ_REMOTE_STAG, op_info->remote_stag) |
+	      FIELD_PREP(IRDMAQPSQ_OPCODE, IRDMAQP_OP_ATOMIC_COMPARE_SWAP_ADD) |
+	      FIELD_PREP(IRDMAQPSQ_READFENCE, info->read_fence) |
+	      FIELD_PREP(IRDMAQPSQ_LOCALFENCE, info->local_fence) |
+	      FIELD_PREP(IRDMAQPSQ_SIGCOMPL, info->signaled) |
+	      FIELD_PREP(IRDMAQPSQ_VALID, qp->swqe_polarity);
+
+	set_64bit_val(wqe, 32, op_info->swap_data_bytes);
+	set_64bit_val(wqe, 40, op_info->compare_data_bytes);
+	set_64bit_val(wqe, 48, 0);
+	set_64bit_val(wqe, 56,
+		      FIELD_PREP(IRDMAQPSQ_VALID, qp->swqe_polarity));
+
+	dma_wmb(); /* make sure WQE is populated before valid bit is set */
+
+	set_64bit_val(wqe, 24, hdr);
+
+	if (post_sq)
+		irdma_uk_qp_post_wr(qp);
+
+	return 0;
+}
+
 /**
  * irdma_uk_srq_post_receive - post a receive wqe to a shared rq
  * @srq: shared rq ptr
diff --git a/drivers/infiniband/hw/irdma/user.h b/drivers/infiniband/hw/irdma/user.h
index cf324f1c539e..ed7ce98e887b 100644
--- a/drivers/infiniband/hw/irdma/user.h
+++ b/drivers/infiniband/hw/irdma/user.h
@@ -41,6 +41,8 @@
 #define IRDMA_OP_TYPE_INV_STAG			0x0a
 #define IRDMA_OP_TYPE_RDMA_READ_INV_STAG	0x0b
 #define IRDMA_OP_TYPE_NOP			0x0c
+#define IRDMA_OP_TYPE_ATOMIC_FETCH_AND_ADD	0x0f
+#define IRDMA_OP_TYPE_ATOMIC_COMPARE_AND_SWAP	0x11
 #define IRDMA_OP_TYPE_REC	0x3e
 #define IRDMA_OP_TYPE_REC_IMM	0x3f
 
@@ -205,6 +207,24 @@ struct irdma_bind_window {
 	bool ena_writes:1;
 	irdma_stag mw_stag;
 	bool mem_window_type_1:1;
+	bool remote_atomics_en:1;
+};
+
+struct irdma_atomic_fetch_add {
+	u64 tagged_offset;
+	u64 remote_tagged_offset;
+	u64 fetch_add_data_bytes;
+	u32 stag;
+	u32 remote_stag;
+};
+
+struct irdma_atomic_compare_swap {
+	u64 tagged_offset;
+	u64 remote_tagged_offset;
+	u64 swap_data_bytes;
+	u64 compare_data_bytes;
+	u32 stag;
+	u32 remote_stag;
 };
 
 struct irdma_inv_local_stag {
@@ -223,6 +243,7 @@ struct irdma_post_sq_info {
 	bool report_rtt:1;
 	bool udp_hdr:1;
 	bool defer_flag:1;
+	bool remote_atomic_en:1;
 	u32 imm_data;
 	u32 stag_to_inv;
 	union {
@@ -231,6 +252,8 @@ struct irdma_post_sq_info {
 		struct irdma_rdma_read rdma_read;
 		struct irdma_bind_window bind_window;
 		struct irdma_inv_local_stag inv_local_stag;
+		struct irdma_atomic_fetch_add atomic_fetch_add;
+		struct irdma_atomic_compare_swap atomic_compare_swap;
 	} op;
 };
 
@@ -259,6 +282,10 @@ struct irdma_cq_poll_info {
 	bool imm_valid:1;
 };
 
+int irdma_uk_atomic_compare_swap(struct irdma_qp_uk *qp,
+				 struct irdma_post_sq_info *info, bool post_sq);
+int irdma_uk_atomic_fetch_add(struct irdma_qp_uk *qp,
+			      struct irdma_post_sq_info *info, bool post_sq);
 int irdma_uk_inline_rdma_write(struct irdma_qp_uk *qp,
 			       struct irdma_post_sq_info *info, bool post_sq);
 int irdma_uk_inline_send(struct irdma_qp_uk *qp,
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 78f1db759bab..167b5bdc668e 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -60,6 +60,11 @@ static int irdma_query_device(struct ib_device *ibdev,
 	props->max_srq = rf->max_srq - rf->used_srqs;
 	props->max_srq_wr = IRDMA_MAX_SRQ_WRS;
 	props->max_srq_sge = hw_attrs->uk_attrs.max_hw_wq_frags;
+	if (hw_attrs->uk_attrs.feature_flags & IRDMA_FEATURE_ATOMIC_OPS)
+		props->atomic_cap = IB_ATOMIC_HCA;
+	else
+		props->atomic_cap = IB_ATOMIC_NONE;
+	props->masked_atomic_cap = props->atomic_cap;
 	if (hw_attrs->uk_attrs.hw_rev >= IRDMA_GEN_3) {
 #define HCA_CORE_CLOCK_KHZ 1000000UL
 		props->timestamp_mask = GENMASK(31, 0);
@@ -1145,6 +1150,8 @@ static int irdma_get_ib_acc_flags(struct irdma_qp *iwqp)
 			acc_flags |= IB_ACCESS_REMOTE_READ;
 		if (iwqp->roce_info.bind_en)
 			acc_flags |= IB_ACCESS_MW_BIND;
+		if (iwqp->ctx_info.remote_atomics_en)
+			acc_flags |= IB_ACCESS_REMOTE_ATOMIC;
 	} else {
 		if (iwqp->iwarp_info.wr_rdresp_en) {
 			acc_flags |= IB_ACCESS_LOCAL_WRITE;
@@ -1152,6 +1159,8 @@ static int irdma_get_ib_acc_flags(struct irdma_qp *iwqp)
 		}
 		if (iwqp->iwarp_info.rd_en)
 			acc_flags |= IB_ACCESS_REMOTE_READ;
+		if (iwqp->ctx_info.remote_atomics_en)
+			acc_flags |= IB_ACCESS_REMOTE_ATOMIC;
 	}
 	return acc_flags;
 }
@@ -1448,6 +1457,9 @@ int irdma_modify_qp_roce(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 			roce_info->wr_rdresp_en = true;
 		if (attr->qp_access_flags & IB_ACCESS_REMOTE_READ)
 			roce_info->rd_en = true;
+		if (dev->hw_attrs.uk_attrs.feature_flags & IRDMA_FEATURE_ATOMIC_OPS)
+			if (attr->qp_access_flags & IB_ACCESS_REMOTE_ATOMIC)
+				ctx_info->remote_atomics_en = true;
 	}
 
 	wait_event(iwqp->mod_qp_waitq, !atomic_read(&iwqp->hw_mod_qp_pend));
@@ -3250,6 +3262,8 @@ static int irdma_hwreg_mr(struct irdma_device *iwdev, struct irdma_mr *iwmr,
 	stag_info->total_len = iwmr->len;
 	stag_info->access_rights = irdma_get_mr_access(access,
 						       iwdev->rf->sc_dev.hw_attrs.uk_attrs.hw_rev);
+	if (iwdev->rf->sc_dev.hw_attrs.uk_attrs.feature_flags & IRDMA_FEATURE_ATOMIC_OPS)
+		stag_info->remote_atomics_en = (access & IB_ACCESS_REMOTE_ATOMIC) ? 1 : 0;
 	stag_info->pd_id = iwpd->sc_pd.pd_id;
 	stag_info->all_memory = pd->flags & IB_PD_UNSAFE_GLOBAL_RKEY;
 	if (stag_info->access_rights & IRDMA_ACCESS_FLAGS_ZERO_BASED)
@@ -3949,6 +3963,40 @@ static int irdma_post_send(struct ib_qp *ibqp,
 		if (ib_wr->send_flags & IB_SEND_FENCE)
 			info.read_fence = true;
 		switch (ib_wr->opcode) {
+		case IB_WR_ATOMIC_CMP_AND_SWP:
+			if (unlikely(!(dev->hw_attrs.uk_attrs.feature_flags &
+				       IRDMA_FEATURE_ATOMIC_OPS))) {
+				err = EINVAL;
+				break;
+			}
+			info.op_type = IRDMA_OP_TYPE_ATOMIC_COMPARE_AND_SWAP;
+			info.op.atomic_compare_swap.tagged_offset = ib_wr->sg_list[0].addr;
+			info.op.atomic_compare_swap.remote_tagged_offset =
+				atomic_wr(ib_wr)->remote_addr;
+			info.op.atomic_compare_swap.swap_data_bytes = atomic_wr(ib_wr)->swap;
+			info.op.atomic_compare_swap.compare_data_bytes =
+				atomic_wr(ib_wr)->compare_add;
+			info.op.atomic_compare_swap.stag = ib_wr->sg_list[0].lkey;
+			info.op.atomic_compare_swap.remote_stag = atomic_wr(ib_wr)->rkey;
+			err = irdma_uk_atomic_compare_swap(ukqp, &info, false);
+			break;
+		case IB_WR_ATOMIC_FETCH_AND_ADD:
+			if (unlikely(!(dev->hw_attrs.uk_attrs.feature_flags &
+				       IRDMA_FEATURE_ATOMIC_OPS))) {
+				err = EINVAL;
+				break;
+			}
+			info.op_type = IRDMA_OP_TYPE_ATOMIC_FETCH_AND_ADD;
+			info.op.atomic_fetch_add.tagged_offset = ib_wr->sg_list[0].addr;
+			info.op.atomic_fetch_add.remote_tagged_offset =
+				atomic_wr(ib_wr)->remote_addr;
+			info.op.atomic_fetch_add.fetch_add_data_bytes =
+				atomic_wr(ib_wr)->compare_add;
+			info.op.atomic_fetch_add.stag = ib_wr->sg_list[0].lkey;
+			info.op.atomic_fetch_add.remote_stag =
+				atomic_wr(ib_wr)->rkey;
+			err = irdma_uk_atomic_fetch_add(ukqp, &info, false);
+			break;
 		case IB_WR_SEND_WITH_IMM:
 			if (ukqp->qp_caps & IRDMA_SEND_WITH_IMM) {
 				info.imm_data_valid = true;
diff --git a/drivers/infiniband/hw/irdma/verbs.h b/drivers/infiniband/hw/irdma/verbs.h
index 2817122ba989..49972b0600a3 100644
--- a/drivers/infiniband/hw/irdma/verbs.h
+++ b/drivers/infiniband/hw/irdma/verbs.h
@@ -284,6 +284,12 @@ static inline void set_ib_wc_op_sq(struct irdma_cq_poll_info *cq_poll_info,
 	case IRDMA_OP_TYPE_FAST_REG_NSMR:
 		entry->opcode = IB_WC_REG_MR;
 		break;
+	case IRDMA_OP_TYPE_ATOMIC_COMPARE_AND_SWAP:
+		entry->opcode = IB_WC_COMP_SWAP;
+		break;
+	case IRDMA_OP_TYPE_ATOMIC_FETCH_AND_ADD:
+		entry->opcode = IB_WC_FETCH_ADD;
+		break;
 	case IRDMA_OP_TYPE_INV_STAG:
 		entry->opcode = IB_WC_LOCAL_INV;
 		break;
-- 
2.42.0


