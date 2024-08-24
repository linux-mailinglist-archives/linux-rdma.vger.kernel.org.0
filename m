Return-Path: <linux-rdma+bounces-4551-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2166395DAFB
	for <lists+linux-rdma@lfdr.de>; Sat, 24 Aug 2024 05:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B9061C21EEA
	for <lists+linux-rdma@lfdr.de>; Sat, 24 Aug 2024 03:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBABA13C909;
	Sat, 24 Aug 2024 03:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dkU0xW5O"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E7680604;
	Sat, 24 Aug 2024 03:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724469657; cv=none; b=l8sBP+Uum8DG/lDUccUdZIlQxIIF6RHvKmb36rWJ+6Q8WX+MOPeqybmef50X+fANYB3SGIUglutL35bWdQHMhqKwppKxikh/kkuPYZoOsq72/Xk7mBbvodyyfb4KEEMXc7YmYWmk+6A7qhkwDuyrsviKARKVTIvCXFqROi/I0Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724469657; c=relaxed/simple;
	bh=F3plSp/0HplGlTa+sycP8Fu4hcZxQYOg06Pi4OUFnlU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cnjq0Ma4/KOE6RYPJeEUZ2klHyZIkxtj66kksBSL5aLy7GnzCZAnkZkxlvJEoZNBXaOkwX57I8DhPhcUQvIGs/MjCSLZ2BK1SxLDYMmVl129MIbWy+x6tO/ksdOCqY448z3+temVUCXHXnMxa3XFNK4eqfnS9BlUpoHS/yeiVJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dkU0xW5O; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724469656; x=1756005656;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F3plSp/0HplGlTa+sycP8Fu4hcZxQYOg06Pi4OUFnlU=;
  b=dkU0xW5O/yypdmERsws+8SgInOOoXSw0PRhISLelfa4POvD2C2XeNsNS
   b2iMCFPit7ot9wpSG1Yp8xa1EP/NKKDPuO3+sZOPlBCcpkXRWmrgAD60E
   BHi3Y4vKwq2a92mxsX9ZscZqvzaBMz7LgoYwoK4B1zco/p/uHW6aV7k6z
   0pZyTsoFNaVgKQZwHfxWdclvNWMzs/DY6YsEDAhoFzPw+MTsppuhwnj+G
   wb9+Rcc2ymW4Wi0YlO+flkfcmmdjFn1T+A1zGnVkbwPl/ejtA50h7RjVE
   hAHhBJBW5odN0ysIpL5HNate+BLeisizityCwKF8bUAeIjdB3+YBn4NwZ
   A==;
X-CSE-ConnectionGUID: prOwXhYwQGmlUHwrPz05kw==
X-CSE-MsgGUID: fRkHDsFjTi63DgBa1iVSzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11173"; a="13187831"
X-IronPort-AV: E=Sophos;i="6.10,172,1719903600"; 
   d="scan'208";a="13187831"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 20:20:51 -0700
X-CSE-ConnectionGUID: nsicXgHERcSgCvELOqFwyg==
X-CSE-MsgGUID: pajE4G+SQT64SZn3mFj/lQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,172,1719903600"; 
   d="scan'208";a="99492142"
Received: from tenikolo-mobl1.amr.corp.intel.com ([10.124.36.66])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 20:20:50 -0700
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Faisal Latif <faisal.latif@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Subject: [RFC v2 22/25] RDMA/irdma: Add Atomic Operations support
Date: Fri, 23 Aug 2024 22:19:21 -0500
Message-Id: <20240824031924.421-23-tatyana.e.nikolova@intel.com>
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

From: Faisal Latif <faisal.latif@intel.com>

Extend irdma to support atomic operations, namely Compare and Swap and
Fetch and Add, for GEN3 devices.

Signed-off-by: Faisal Latif <faisal.latif@intel.com>
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
---
 drivers/infiniband/hw/irdma/ctrl.c  |   7 ++
 drivers/infiniband/hw/irdma/defs.h  |  10 ++-
 drivers/infiniband/hw/irdma/type.h  |   4 ++
 drivers/infiniband/hw/irdma/uk.c    | 102 ++++++++++++++++++++++++++++
 drivers/infiniband/hw/irdma/user.h  |  27 ++++++++
 drivers/infiniband/hw/irdma/verbs.c |  38 +++++++++++
 drivers/infiniband/hw/irdma/verbs.h |   6 ++
 7 files changed, 193 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/irdma/ctrl.c b/drivers/infiniband/hw/irdma/ctrl.c
index d7165bd7f142..40868b58063d 100644
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
@@ -1489,6 +1491,8 @@ static int irdma_sc_alloc_stag(struct irdma_sc_dev *dev,
 	      FIELD_PREP(IRDMA_CQPSQ_STAG_REMACCENABLED, info->remote_access) |
 	      FIELD_PREP(IRDMA_CQPSQ_STAG_USEHMCFNIDX, info->use_hmc_fcn_index) |
 	      FIELD_PREP(IRDMA_CQPSQ_STAG_USEPFRID, info->use_pf_rid) |
+	      FIELD_PREP(IRDMA_CQPSQ_STAG_REMOTE_ATOMIC_EN,
+			 info->remote_atomics_en) |
 	      FIELD_PREP(IRDMA_CQPSQ_WQEVALID, cqp->polarity);
 	dma_wmb(); /* make sure WQE is written before valid bit is set */
 
@@ -1580,6 +1584,8 @@ static int irdma_sc_mr_reg_non_shared(struct irdma_sc_dev *dev,
 	      FIELD_PREP(IRDMA_CQPSQ_STAG_VABASEDTO, addr_type) |
 	      FIELD_PREP(IRDMA_CQPSQ_STAG_USEHMCFNIDX, info->use_hmc_fcn_index) |
 	      FIELD_PREP(IRDMA_CQPSQ_STAG_USEPFRID, info->use_pf_rid) |
+	      FIELD_PREP(IRDMA_CQPSQ_STAG_REMOTE_ATOMIC_EN,
+			 info->remote_atomics_en) |
 	      FIELD_PREP(IRDMA_CQPSQ_WQEVALID, cqp->polarity);
 	dma_wmb(); /* make sure WQE is written before valid bit is set */
 
@@ -1736,6 +1742,7 @@ int irdma_sc_mr_fast_register(struct irdma_sc_qp *qp,
 	      FIELD_PREP(IRDMAQPSQ_READFENCE, info->read_fence) |
 	      FIELD_PREP(IRDMAQPSQ_LOCALFENCE, info->local_fence) |
 	      FIELD_PREP(IRDMAQPSQ_SIGCOMPL, info->signaled) |
+	      FIELD_PREP(IRDMAQPSQ_REMOTE_ATOMICS_EN, info->remote_atomics_en) |
 	      FIELD_PREP(IRDMAQPSQ_VALID, qp->qp_uk.swqe_polarity);
 	dma_wmb(); /* make sure WQE is written before valid bit is set */
 
diff --git a/drivers/infiniband/hw/irdma/defs.h b/drivers/infiniband/hw/irdma/defs.h
index 8ead170a8930..9c0fd4603a82 100644
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
@@ -696,7 +698,8 @@ enum irdma_cqp_op_type {
 #define IRDMA_CQPSQ_STAG_USEPFRID BIT_ULL(61)
 
 #define IRDMA_CQPSQ_STAG_PBA IRDMA_CQPHC_QPCTX
-#define IRDMA_CQPSQ_STAG_HMCFNIDX GENMASK_ULL(5, 0)
+#define IRDMA_CQPSQ_STAG_HMCFNIDX GENMASK_ULL(15, 0)
+#define IRDMA_CQPSQ_STAG_REMOTE_ATOMIC_EN BIT_ULL(61)
 
 #define IRDMA_CQPSQ_STAG_FIRSTPMPBLIDX GENMASK_ULL(27, 0)
 #define IRDMA_CQPSQ_QUERYSTAG_IDX IRDMA_CQPSQ_STAG_IDX
@@ -986,6 +989,9 @@ enum irdma_cqp_op_type {
 
 #define IRDMAQPSQ_REMTO IRDMA_CQPHC_QPCTX
 
+#define IRDMAQPSQ_STAG GENMASK_ULL(31, 0)
+#define IRDMAQPSQ_REMOTE_STAG GENMASK_ULL(31, 0)
+
 #define IRDMAQPSQ_STAGRIGHTS GENMASK_ULL(52, 48)
 #define IRDMAQPSQ_VABASEDTO BIT_ULL(53)
 #define IRDMAQPSQ_MEMWINDOWTYPE BIT_ULL(54)
@@ -996,6 +1002,8 @@ enum irdma_cqp_op_type {
 
 #define IRDMAQPSQ_BASEVA_TO_FBO IRDMA_CQPHC_QPCTX
 
+#define IRDMAQPSQ_REMOTE_ATOMICS_EN BIT_ULL(55)
+
 #define IRDMAQPSQ_LOCSTAG GENMASK_ULL(31, 0)
 
 #define IRDMAQPSQ_STAGKEY GENMASK_ULL(7, 0)
diff --git a/drivers/infiniband/hw/irdma/type.h b/drivers/infiniband/hw/irdma/type.h
index adfc528a268e..52aa1dd3cbb7 100644
--- a/drivers/infiniband/hw/irdma/type.h
+++ b/drivers/infiniband/hw/irdma/type.h
@@ -1094,6 +1094,7 @@ struct irdma_qp_host_ctx_info {
 	u32 srq_id;
 	u32 rem_endpoint_idx;
 	u16 stats_idx;
+	bool remote_atomics_en:1;
 	bool srq_valid:1;
 	bool tcp_info_valid:1;
 	bool iwarp_info_valid:1;
@@ -1134,6 +1135,7 @@ struct irdma_allocate_stag_info {
 	bool use_hmc_fcn_index:1;
 	bool use_pf_rid:1;
 	bool all_memory:1;
+	bool remote_atomics_en:1;
 	u16 hmc_fcn_index;
 };
 
@@ -1162,6 +1164,7 @@ struct irdma_reg_ns_stag_info {
 	u8 hmc_fcn_index;
 	bool use_pf_rid:1;
 	bool all_memory:1;
+	bool remote_atomics_en:1;
 };
 
 struct irdma_fast_reg_stag_info {
@@ -1185,6 +1188,7 @@ struct irdma_fast_reg_stag_info {
 	u8 hmc_fcn_index;
 	bool use_pf_rid:1;
 	bool defer_flag:1;
+	bool remote_atomics_en:1;
 };
 
 struct irdma_dealloc_stag_info {
diff --git a/drivers/infiniband/hw/irdma/uk.c b/drivers/infiniband/hw/irdma/uk.c
index 26f3475f6453..24e8df0f8033 100644
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
index af15529643e9..96dea01e83db 100644
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
 
@@ -203,6 +205,24 @@ struct irdma_bind_window {
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
@@ -221,6 +241,7 @@ struct irdma_post_sq_info {
 	bool report_rtt:1;
 	bool udp_hdr:1;
 	bool defer_flag:1;
+	bool remote_atomic_en:1;
 	u32 imm_data;
 	u32 stag_to_inv;
 	union {
@@ -229,6 +250,8 @@ struct irdma_post_sq_info {
 		struct irdma_rdma_read rdma_read;
 		struct irdma_bind_window bind_window;
 		struct irdma_inv_local_stag inv_local_stag;
+		struct irdma_atomic_fetch_add atomic_fetch_add;
+		struct irdma_atomic_compare_swap atomic_compare_swap;
 	} op;
 };
 
@@ -257,6 +280,10 @@ struct irdma_cq_poll_info {
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
index 66e67be2e67b..25e46aefe147 100644
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
@@ -1448,6 +1457,8 @@ int irdma_modify_qp_roce(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 			roce_info->wr_rdresp_en = true;
 		if (attr->qp_access_flags & IB_ACCESS_REMOTE_READ)
 			roce_info->rd_en = true;
+		if (attr->qp_access_flags & IB_ACCESS_REMOTE_ATOMIC)
+			ctx_info->remote_atomics_en = true;
 	}
 
 	wait_event(iwqp->mod_qp_waitq, !atomic_read(&iwqp->hw_mod_qp_pend));
@@ -1778,6 +1789,8 @@ int irdma_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr, int attr_mask,
 			offload_info->wr_rdresp_en = true;
 		if (attr->qp_access_flags & IB_ACCESS_REMOTE_READ)
 			offload_info->rd_en = true;
+		if (attr->qp_access_flags & IB_ACCESS_REMOTE_ATOMIC)
+			ctx_info->remote_atomics_en = true;
 	}
 
 	if (ctx_info->iwarp_info_valid) {
@@ -3241,6 +3254,7 @@ static int irdma_hwreg_mr(struct irdma_device *iwdev, struct irdma_mr *iwmr,
 	stag_info->total_len = iwmr->len;
 	stag_info->access_rights = irdma_get_mr_access(access,
 						       iwdev->rf->sc_dev.hw_attrs.uk_attrs.hw_rev);
+	stag_info->remote_atomics_en = (access & IB_ACCESS_REMOTE_ATOMIC) ? 1 : 0;
 	stag_info->pd_id = iwpd->sc_pd.pd_id;
 	stag_info->all_memory = pd->flags & IB_PD_UNSAFE_GLOBAL_RKEY;
 	if (stag_info->access_rights & IRDMA_ACCESS_FLAGS_ZERO_BASED)
@@ -3931,6 +3945,30 @@ static int irdma_post_send(struct ib_qp *ibqp,
 		if (ib_wr->send_flags & IB_SEND_FENCE)
 			info.read_fence = true;
 		switch (ib_wr->opcode) {
+		case IB_WR_ATOMIC_CMP_AND_SWP:
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
index 157dfa2d1a05..0922a22fbede 100644
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


