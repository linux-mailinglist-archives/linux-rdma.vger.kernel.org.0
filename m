Return-Path: <linux-rdma+bounces-7543-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB3EA2CD28
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 20:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 139FE16BE0B
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 19:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22BE1B4F0A;
	Fri,  7 Feb 2025 19:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iAwrcM98"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F5219ABCE;
	Fri,  7 Feb 2025 19:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738957836; cv=none; b=lU9qSuLLh8qoDYqaEcAFUKe6Kh6L+swdaKUKAdHpLGS4JJIKgS96p3No63SixLZMz8TAKqcX5/JViVumVfcf8zqRB1D5t2pRESTyLs0XpZ1xdhCbxhIDa42jd9YesOrrSiOFnxylc456aNv26MrjIyfLKN6HTPYRi5natHFlEyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738957836; c=relaxed/simple;
	bh=/ZpHRlxJXqDBErjKWDkLkrnLWfDMOlD4yrp///JUUsE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KtYSVFogJOWGwO8QEg4QvojyEaHDIc7OrwLsUVMyh4G4KrzFkr21uo0oSKkM+wjD86rbD17FitLrcd7/qxq6a9Hs67uWb3alIAr3jABZLFkHt/x2LHYpuYQIdh0Swm3vahMt0HoKAlkDV70B+1/Z6Bq4BQ7WnfGUeYbvOsKl3j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iAwrcM98; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738957834; x=1770493834;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/ZpHRlxJXqDBErjKWDkLkrnLWfDMOlD4yrp///JUUsE=;
  b=iAwrcM98UOxALAJIp/SZr9hhp85FYXV74G8FQW9u5g3Xw2EKpgr/97KK
   vGGIGfbzcEyiTigNciZnuJ4mAX0IZAQshi3P1aSsHE/HoM4pwpT1Rezu8
   ZGOFU+7iMHjllP2daH8otdIb7hM6NPSGhxFssBCUPj5SyO0JNYAo/jsDc
   3qQ9p+hWB7NdeB7UYxylaEMS1+AH92batwnWWtwFqsPWlVnwStrMdiZLG
   cg3qKidho4x/kxCckDNiq3TZBMTovE8Sg4pxLKyOLWoCDU2ZleysYi2J5
   /noCvXoVNMqyQ0U5h7LPtOtEona5H0wa+O4v2QJiniorPJbr6/QTATYDg
   A==;
X-CSE-ConnectionGUID: QFdM4N2VStuimh5/gfvmwg==
X-CSE-MsgGUID: iXz0yBGqSPeW+drZLEhSSg==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="42451808"
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="42451808"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 11:50:29 -0800
X-CSE-ConnectionGUID: b/e7JKEETROVwq/IXauAHQ==
X-CSE-MsgGUID: BVHwUiWuRDK3M0J2Udn+3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="112238183"
Received: from tenikolo-mobl1.amr.corp.intel.com ([10.124.81.134])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 11:50:28 -0800
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org,
	intel-wired-lan@lists.osuosl.org
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Subject: [rdma v3 12/24] RDMA/irdma: Add GEN3 support for AEQ and CEQ
Date: Fri,  7 Feb 2025 13:49:19 -0600
Message-Id: <20250207194931.1569-13-tatyana.e.nikolova@intel.com>
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

Extend support for GEN3 devices by programming the necessary hardware
IRQ registers and the updated descriptor fields for the Asynchronous
Event Queue (AEQ) and Completion Event Queue (CEQ). Introduce a RDMA
virtual channel operation with the Control Plane (CP) to associate
interrupt vectors appropriately with AEQ and CEQ. Add new Asynchronous
Event (AE) definitions specific to GEN3.

Additionally, refactor the AEQ and CEQ setup into the irdma_ctrl_init_hw
device control initialization routine.

This completes the PCI device level initialization for RDMA in the core
driver.

Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
---
 drivers/infiniband/hw/irdma/ctrl.c       |  76 ++++++++++---
 drivers/infiniband/hw/irdma/defs.h       |  29 ++++-
 drivers/infiniband/hw/irdma/hw.c         | 130 +++++++++++++----------
 drivers/infiniband/hw/irdma/ig3rdma_hw.c |  45 ++++++++
 drivers/infiniband/hw/irdma/irdma.h      |  11 +-
 drivers/infiniband/hw/irdma/main.h       |   6 +-
 drivers/infiniband/hw/irdma/type.h       |  11 +-
 drivers/infiniband/hw/irdma/virtchnl.c   |  84 +++++++++++++++
 drivers/infiniband/hw/irdma/virtchnl.h   |  19 ++++
 9 files changed, 338 insertions(+), 73 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/ctrl.c b/drivers/infiniband/hw/irdma/ctrl.c
index 96d7a5d34515..55080b56311b 100644
--- a/drivers/infiniband/hw/irdma/ctrl.c
+++ b/drivers/infiniband/hw/irdma/ctrl.c
@@ -2566,6 +2566,9 @@ static int irdma_sc_cq_create(struct irdma_sc_cq *cq, u64 scratch,
 	      FIELD_PREP(IRDMA_CQPSQ_CQ_LPBLSIZE, cq->pbl_chunk_size) |
 	      FIELD_PREP(IRDMA_CQPSQ_CQ_CHKOVERFLOW, check_overflow) |
 	      FIELD_PREP(IRDMA_CQPSQ_CQ_VIRTMAP, cq->virtual_map) |
+	      FIELD_PREP(IRDMA_CQPSQ_CQ_CQID_HIGH, cq->cq_uk.cq_id >> 22) |
+	      FIELD_PREP(IRDMA_CQPSQ_CQ_CEQID_HIGH,
+			 (cq->ceq_id_valid ? cq->ceq_id : 0) >> 10) |
 	      FIELD_PREP(IRDMA_CQPSQ_CQ_ENCEQEMASK, cq->ceqe_mask) |
 	      FIELD_PREP(IRDMA_CQPSQ_CQ_CEQIDVALID, cq->ceq_id_valid) |
 	      FIELD_PREP(IRDMA_CQPSQ_TPHEN, cq->tph_en) |
@@ -3928,7 +3931,7 @@ int irdma_sc_ceq_init(struct irdma_sc_ceq *ceq,
 	ceq->pbl_list = (ceq->virtual_map ? info->pbl_list : NULL);
 	ceq->tph_en = info->tph_en;
 	ceq->tph_val = info->tph_val;
-	ceq->vsi = info->vsi;
+	ceq->vsi_idx = info->vsi_idx;
 	ceq->polarity = 1;
 	IRDMA_RING_INIT(ceq->ceq_ring, ceq->elem_cnt);
 	ceq->dev->ceq[info->ceq_id] = ceq;
@@ -3961,13 +3964,16 @@ static int irdma_sc_ceq_create(struct irdma_sc_ceq *ceq, u64 scratch,
 		      (ceq->virtual_map ? ceq->first_pm_pbl_idx : 0));
 	set_64bit_val(wqe, 56,
 		      FIELD_PREP(IRDMA_CQPSQ_TPHVAL, ceq->tph_val) |
-		      FIELD_PREP(IRDMA_CQPSQ_VSIIDX, ceq->vsi->vsi_idx));
+		      FIELD_PREP(IRDMA_CQPSQ_PASID, ceq->pasid) |
+		      FIELD_PREP(IRDMA_CQPSQ_VSIIDX, ceq->vsi_idx));
 	hdr = FIELD_PREP(IRDMA_CQPSQ_CEQ_CEQID, ceq->ceq_id) |
+	      FIELD_PREP(IRDMA_CQPSQ_CEQ_CEQID_HIGH, ceq->ceq_id >> 10) |
 	      FIELD_PREP(IRDMA_CQPSQ_OPCODE, IRDMA_CQP_OP_CREATE_CEQ) |
 	      FIELD_PREP(IRDMA_CQPSQ_CEQ_LPBLSIZE, ceq->pbl_chunk_size) |
 	      FIELD_PREP(IRDMA_CQPSQ_CEQ_VMAP, ceq->virtual_map) |
 	      FIELD_PREP(IRDMA_CQPSQ_CEQ_ITRNOEXPIRE, ceq->itr_no_expire) |
 	      FIELD_PREP(IRDMA_CQPSQ_TPHEN, ceq->tph_en) |
+	      FIELD_PREP(IRDMA_CQPSQ_PASID_VALID, ceq->pasid_valid) |
 	      FIELD_PREP(IRDMA_CQPSQ_WQEVALID, cqp->polarity);
 	dma_wmb(); /* make sure WQE is written before valid bit is set */
 
@@ -4022,7 +4028,7 @@ int irdma_sc_cceq_create(struct irdma_sc_ceq *ceq, u64 scratch)
 	int ret_code;
 	struct irdma_sc_dev *dev = ceq->dev;
 
-	dev->ccq->vsi = ceq->vsi;
+	dev->ccq->vsi_idx = ceq->vsi_idx;
 	if (ceq->reg_cq) {
 		ret_code = irdma_sc_add_cq_ctx(ceq, ceq->dev->ccq);
 		if (ret_code)
@@ -4055,11 +4061,14 @@ int irdma_sc_ceq_destroy(struct irdma_sc_ceq *ceq, u64 scratch, bool post_sq)
 
 	set_64bit_val(wqe, 16, ceq->elem_cnt);
 	set_64bit_val(wqe, 48, ceq->first_pm_pbl_idx);
+	set_64bit_val(wqe, 56,
+		      FIELD_PREP(IRDMA_CQPSQ_PASID, ceq->pasid));
 	hdr = ceq->ceq_id |
 	      FIELD_PREP(IRDMA_CQPSQ_OPCODE, IRDMA_CQP_OP_DESTROY_CEQ) |
 	      FIELD_PREP(IRDMA_CQPSQ_CEQ_LPBLSIZE, ceq->pbl_chunk_size) |
 	      FIELD_PREP(IRDMA_CQPSQ_CEQ_VMAP, ceq->virtual_map) |
 	      FIELD_PREP(IRDMA_CQPSQ_TPHEN, ceq->tph_en) |
+	      FIELD_PREP(IRDMA_CQPSQ_PASID_VALID, ceq->pasid_valid) |
 	      FIELD_PREP(IRDMA_CQPSQ_WQEVALID, cqp->polarity);
 	dma_wmb(); /* make sure WQE is written before valid bit is set */
 
@@ -4223,10 +4232,13 @@ static int irdma_sc_aeq_create(struct irdma_sc_aeq *aeq, u64 scratch,
 		      (aeq->virtual_map ? 0 : aeq->aeq_elem_pa));
 	set_64bit_val(wqe, 48,
 		      (aeq->virtual_map ? aeq->first_pm_pbl_idx : 0));
+	set_64bit_val(wqe, 56,
+		      FIELD_PREP(IRDMA_CQPSQ_PASID, aeq->pasid));
 
 	hdr = FIELD_PREP(IRDMA_CQPSQ_OPCODE, IRDMA_CQP_OP_CREATE_AEQ) |
 	      FIELD_PREP(IRDMA_CQPSQ_AEQ_LPBLSIZE, aeq->pbl_chunk_size) |
 	      FIELD_PREP(IRDMA_CQPSQ_AEQ_VMAP, aeq->virtual_map) |
+	      FIELD_PREP(IRDMA_CQPSQ_PASID_VALID, aeq->pasid_valid) |
 	      FIELD_PREP(IRDMA_CQPSQ_WQEVALID, cqp->polarity);
 	dma_wmb(); /* make sure WQE is written before valid bit is set */
 
@@ -4255,7 +4267,8 @@ static int irdma_sc_aeq_destroy(struct irdma_sc_aeq *aeq, u64 scratch,
 	u64 hdr;
 
 	dev = aeq->dev;
-	writel(0, dev->hw_regs[IRDMA_PFINT_AEQCTL]);
+	if (dev->privileged)
+		writel(0, dev->hw_regs[IRDMA_PFINT_AEQCTL]);
 
 	cqp = dev->cqp;
 	wqe = irdma_sc_cqp_get_next_send_wqe(cqp, scratch);
@@ -4263,9 +4276,12 @@ static int irdma_sc_aeq_destroy(struct irdma_sc_aeq *aeq, u64 scratch,
 		return -ENOMEM;
 	set_64bit_val(wqe, 16, aeq->elem_cnt);
 	set_64bit_val(wqe, 48, aeq->first_pm_pbl_idx);
+	set_64bit_val(wqe, 56,
+		      FIELD_PREP(IRDMA_CQPSQ_PASID, aeq->pasid));
 	hdr = FIELD_PREP(IRDMA_CQPSQ_OPCODE, IRDMA_CQP_OP_DESTROY_AEQ) |
 	      FIELD_PREP(IRDMA_CQPSQ_AEQ_LPBLSIZE, aeq->pbl_chunk_size) |
 	      FIELD_PREP(IRDMA_CQPSQ_AEQ_VMAP, aeq->virtual_map) |
+	      FIELD_PREP(IRDMA_CQPSQ_PASID_VALID, aeq->pasid_valid) |
 	      FIELD_PREP(IRDMA_CQPSQ_WQEVALID, cqp->polarity);
 	dma_wmb(); /* make sure WQE is written before valid bit is set */
 
@@ -4306,18 +4322,39 @@ int irdma_sc_get_next_aeqe(struct irdma_sc_aeq *aeq,
 	print_hex_dump_debug("WQE: AEQ_ENTRY WQE", DUMP_PREFIX_OFFSET, 16, 8,
 			     aeqe, 16, false);
 
-	ae_src = (u8)FIELD_GET(IRDMA_AEQE_AESRC, temp);
-	info->wqe_idx = (u16)FIELD_GET(IRDMA_AEQE_WQDESCIDX, temp);
-	info->qp_cq_id = (u32)FIELD_GET(IRDMA_AEQE_QPCQID_LOW, temp) |
+	if (aeq->dev->hw_attrs.uk_attrs.hw_rev >= IRDMA_GEN_3) {
+		ae_src = (u8)FIELD_GET(IRDMA_AEQE_AESRC_GEN_3, temp);
+		info->wqe_idx = (u16)FIELD_GET(IRDMA_AEQE_WQDESCIDX_GEN_3,
+					       temp);
+		info->qp_cq_id = (u32)FIELD_GET(IRDMA_AEQE_QPCQID_GEN_3, temp);
+		info->ae_id = (u16)FIELD_GET(IRDMA_AEQE_AECODE_GEN_3, temp);
+		info->tcp_state = (u8)FIELD_GET(IRDMA_AEQE_TCPSTATE_GEN_3, compl_ctx);
+		info->iwarp_state = (u8)FIELD_GET(IRDMA_AEQE_IWSTATE_GEN_3, temp);
+		info->q2_data_written = (u8)FIELD_GET(IRDMA_AEQE_Q2DATA_GEN_3, compl_ctx);
+		info->aeqe_overflow = (bool)FIELD_GET(IRDMA_AEQE_OVERFLOW_GEN_3, temp);
+		info->compl_ctx = FIELD_GET(IRDMA_AEQE_CMPL_CTXT, compl_ctx);
+		compl_ctx = FIELD_GET(IRDMA_AEQE_CMPL_CTXT, compl_ctx) << IRDMA_AEQE_CMPL_CTXT_S;
+	} else {
+		ae_src = (u8)FIELD_GET(IRDMA_AEQE_AESRC, temp);
+		info->wqe_idx = (u16)FIELD_GET(IRDMA_AEQE_WQDESCIDX, temp);
+		info->qp_cq_id = (u32)FIELD_GET(IRDMA_AEQE_QPCQID_LOW, temp) |
 			 ((u32)FIELD_GET(IRDMA_AEQE_QPCQID_HI, temp) << 18);
-	info->ae_id = (u16)FIELD_GET(IRDMA_AEQE_AECODE, temp);
-	info->tcp_state = (u8)FIELD_GET(IRDMA_AEQE_TCPSTATE, temp);
-	info->iwarp_state = (u8)FIELD_GET(IRDMA_AEQE_IWSTATE, temp);
-	info->q2_data_written = (u8)FIELD_GET(IRDMA_AEQE_Q2DATA, temp);
-	info->aeqe_overflow = (bool)FIELD_GET(IRDMA_AEQE_OVERFLOW, temp);
+		info->ae_id = (u16)FIELD_GET(IRDMA_AEQE_AECODE, temp);
+		info->tcp_state = (u8)FIELD_GET(IRDMA_AEQE_TCPSTATE, temp);
+		info->iwarp_state = (u8)FIELD_GET(IRDMA_AEQE_IWSTATE, temp);
+		info->q2_data_written = (u8)FIELD_GET(IRDMA_AEQE_Q2DATA, temp);
+		info->aeqe_overflow = (bool)FIELD_GET(IRDMA_AEQE_OVERFLOW,
+						      temp);
+	}
 
 	info->ae_src = ae_src;
 	switch (info->ae_id) {
+	case IRDMA_AE_SRQ_LIMIT:
+		info->srq = true;
+		/* [63:6] from CMPL_CTXT, [5:0] from WQDESCIDX. */
+		info->compl_ctx = compl_ctx | info->wqe_idx;
+		ae_src = IRDMA_AE_SOURCE_RSVD;
+		break;
 	case IRDMA_AE_PRIV_OPERATION_DENIED:
 	case IRDMA_AE_AMP_INVALIDATE_TYPE1_MW:
 	case IRDMA_AE_AMP_MWBIND_ZERO_BASED_TYPE1_MW:
@@ -4350,6 +4387,10 @@ int irdma_sc_get_next_aeqe(struct irdma_sc_aeq *aeq,
 	case IRDMA_AE_LLP_RECEIVED_MPA_CRC_ERROR:
 	case IRDMA_AE_LLP_SEGMENT_TOO_SMALL:
 	case IRDMA_AE_LLP_TOO_MANY_RETRIES:
+	case IRDMA_AE_LLP_TOO_MANY_RNRS:
+	case IRDMA_AE_REMOTE_QP_CATASTROPHIC:
+	case IRDMA_AE_LOCAL_QP_CATASTROPHIC:
+	case IRDMA_AE_RCE_QP_CATASTROPHIC:
 	case IRDMA_AE_LLP_DOUBT_REACHABILITY:
 	case IRDMA_AE_LLP_CONNECTION_ESTABLISHED:
 	case IRDMA_AE_RESET_SENT:
@@ -4395,6 +4436,7 @@ int irdma_sc_get_next_aeqe(struct irdma_sc_aeq *aeq,
 		info->qp = true;
 		info->rq = true;
 		info->compl_ctx = compl_ctx;
+		info->err_rq_idx_valid = true;
 		break;
 	case IRDMA_AE_SOURCE_CQ:
 	case IRDMA_AE_SOURCE_CQ_0110:
@@ -4410,8 +4452,18 @@ int irdma_sc_get_next_aeqe(struct irdma_sc_aeq *aeq,
 		info->compl_ctx = compl_ctx;
 		break;
 	case IRDMA_AE_SOURCE_IN_RR_WR:
+		info->qp = true;
+		if (aeq->dev->hw_attrs.uk_attrs.hw_rev >= IRDMA_GEN_3)
+			info->err_rq_idx_valid = true;
+		info->compl_ctx = compl_ctx;
+		info->in_rdrsp_wr = true;
+		break;
 	case IRDMA_AE_SOURCE_IN_RR_WR_1011:
 		info->qp = true;
+		if (aeq->dev->hw_attrs.uk_attrs.hw_rev >= IRDMA_GEN_3) {
+			info->sq = true;
+			info->err_rq_idx_valid = true;
+		}
 		info->compl_ctx = compl_ctx;
 		info->in_rdrsp_wr = true;
 		break;
diff --git a/drivers/infiniband/hw/irdma/defs.h b/drivers/infiniband/hw/irdma/defs.h
index 1239776c6ba3..52ace06912eb 100644
--- a/drivers/infiniband/hw/irdma/defs.h
+++ b/drivers/infiniband/hw/irdma/defs.h
@@ -319,13 +319,18 @@ enum irdma_cqp_op_type {
 #define IRDMA_AE_STAG_ZERO_INVALID					0x0206
 #define IRDMA_AE_IB_RREQ_AND_Q1_FULL					0x0207
 #define IRDMA_AE_IB_INVALID_REQUEST					0x0208
+#define IRDMA_AE_SRQ_LIMIT						0x0209
 #define IRDMA_AE_WQE_UNEXPECTED_OPCODE					0x020a
 #define IRDMA_AE_WQE_INVALID_PARAMETER					0x020b
 #define IRDMA_AE_WQE_INVALID_FRAG_DATA					0x020c
 #define IRDMA_AE_IB_REMOTE_ACCESS_ERROR					0x020d
 #define IRDMA_AE_IB_REMOTE_OP_ERROR					0x020e
+#define IRDMA_AE_SRQ_CATASTROPHIC_ERROR					0x020f
 #define IRDMA_AE_WQE_LSMM_TOO_LONG					0x0220
+#define IRDMA_AE_ATOMIC_ALIGNMENT					0x0221
+#define IRDMA_AE_ATOMIC_MASK						0x0222
 #define IRDMA_AE_INVALID_REQUEST					0x0223
+#define IRDMA_AE_PCIE_ATOMIC_DISABLE					0x0224
 #define IRDMA_AE_DDP_INVALID_MSN_GAP_IN_MSN				0x0301
 #define IRDMA_AE_DDP_UBE_DDP_MESSAGE_TOO_LONG_FOR_AVAILABLE_BUFFER	0x0303
 #define IRDMA_AE_DDP_UBE_INVALID_DDP_VERSION				0x0304
@@ -366,8 +371,12 @@ enum irdma_cqp_op_type {
 #define IRDMA_AE_LCE_QP_CATASTROPHIC					0x0700
 #define IRDMA_AE_LCE_FUNCTION_CATASTROPHIC				0x0701
 #define IRDMA_AE_LCE_CQ_CATASTROPHIC					0x0702
+#define IRDMA_AE_REMOTE_QP_CATASTROPHIC					0x0703
+#define IRDMA_AE_LOCAL_QP_CATASTROPHIC					0x0704
+#define IRDMA_AE_RCE_QP_CATASTROPHIC					0x0705
 #define IRDMA_AE_QP_SUSPEND_COMPLETE					0x0900
 #define IRDMA_AE_CQP_DEFERRED_COMPLETE					0x0901
+#define IRDMA_AE_ADAPTER_CATASTROPHIC					0x0B0B
 
 #define FLD_LS_64(dev, val, field)	\
 	(((u64)(val) << (dev)->hw_shifts[field ## _S]) & (dev)->hw_masks[field ## _M])
@@ -535,6 +544,17 @@ enum irdma_cqp_op_type {
 #define IRDMA_AEQE_Q2DATA GENMASK_ULL(62, 61)
 #define IRDMA_AEQE_VALID BIT_ULL(63)
 
+#define IRDMA_AEQE_Q2DATA_GEN_3 GENMASK_ULL(5, 4)
+#define IRDMA_AEQE_TCPSTATE_GEN_3 GENMASK_ULL(3, 0)
+#define IRDMA_AEQE_QPCQID_GEN_3 GENMASK_ULL(24, 0)
+#define IRDMA_AEQE_AECODE_GEN_3 GENMASK_ULL(61, 50)
+#define IRDMA_AEQE_OVERFLOW_GEN_3 BIT_ULL(62)
+#define IRDMA_AEQE_WQDESCIDX_GEN_3 GENMASK_ULL(49, 32)
+#define IRDMA_AEQE_IWSTATE_GEN_3 GENMASK_ULL(31, 29)
+#define IRDMA_AEQE_AESRC_GEN_3 GENMASK_ULL(28, 25)
+#define IRDMA_AEQE_CMPL_CTXT_S 6
+#define IRDMA_AEQE_CMPL_CTXT GENMASK_ULL(63, 6)
+
 #define IRDMA_UDA_QPSQ_NEXT_HDR GENMASK_ULL(23, 16)
 #define IRDMA_UDA_QPSQ_OPCODE GENMASK_ULL(37, 32)
 #define IRDMA_UDA_QPSQ_L4LEN GENMASK_ULL(45, 42)
@@ -557,11 +577,14 @@ enum irdma_cqp_op_type {
 #define IRDMA_CQPSQ_WQEVALID BIT_ULL(63)
 #define IRDMA_CQPSQ_TPHVAL GENMASK_ULL(7, 0)
 
-#define IRDMA_CQPSQ_VSIIDX GENMASK_ULL(17, 8)
+#define IRDMA_CQPSQ_VSIIDX GENMASK_ULL(23, 8)
 #define IRDMA_CQPSQ_TPHEN BIT_ULL(60)
 
 #define IRDMA_CQPSQ_PBUFADDR IRDMA_CQPHC_QPCTX
 
+#define IRDMA_CQPSQ_PASID GENMASK_ULL(51, 32)
+#define IRDMA_CQPSQ_PASID_VALID BIT_ULL(62)
+
 /* Create/Modify/Destroy QP */
 
 #define IRDMA_CQPSQ_QP_NEWMSS GENMASK_ULL(45, 32)
@@ -597,6 +620,8 @@ enum irdma_cqp_op_type {
 #define IRDMA_CQPSQ_CQ_CQCTX GENMASK_ULL(62, 0)
 #define IRDMA_CQPSQ_CQ_SHADOW_READ_THRESHOLD GENMASK(17, 0)
 
+#define IRDMA_CQPSQ_CQ_CQID_HIGH GENMASK_ULL(52, 50)
+#define IRDMA_CQPSQ_CQ_CEQID_HIGH GENMASK_ULL(59, 54)
 #define IRDMA_CQPSQ_CQ_OP GENMASK_ULL(37, 32)
 #define IRDMA_CQPSQ_CQ_CQRESIZE BIT_ULL(43)
 #define IRDMA_CQPSQ_CQ_LPBLSIZE GENMASK_ULL(45, 44)
@@ -676,6 +701,8 @@ enum irdma_cqp_op_type {
 #define IRDMA_CQPSQ_CEQ_CEQSIZE GENMASK_ULL(21, 0)
 #define IRDMA_CQPSQ_CEQ_CEQID GENMASK_ULL(9, 0)
 
+#define IRDMA_CQPSQ_CEQ_CEQID_HIGH GENMASK_ULL(15, 10)
+
 #define IRDMA_CQPSQ_CEQ_LPBLSIZE IRDMA_CQPSQ_CQ_LPBLSIZE
 #define IRDMA_CQPSQ_CEQ_VMAP BIT_ULL(47)
 #define IRDMA_CQPSQ_CEQ_ITRNOEXPIRE BIT_ULL(46)
diff --git a/drivers/infiniband/hw/irdma/hw.c b/drivers/infiniband/hw/irdma/hw.c
index 7e549d9e9baf..c8f81a6245be 100644
--- a/drivers/infiniband/hw/irdma/hw.c
+++ b/drivers/infiniband/hw/irdma/hw.c
@@ -282,6 +282,13 @@ static void irdma_process_aeq(struct irdma_pci_f *rf)
 		if (ret)
 			break;
 
+		if (info->aeqe_overflow) {
+			ibdev_err(&iwdev->ibdev, "AEQ has overflowed\n");
+			rf->reset = true;
+			rf->gen_ops.request_reset(rf);
+			return;
+		}
+
 		aeqcnt++;
 		ibdev_dbg(&iwdev->ibdev,
 			  "AEQ: ae_id = 0x%x bool qp=%d qp_id = %d tcp_state=%d iwarp_state=%d ae_src=%d\n",
@@ -442,6 +449,9 @@ static void irdma_process_aeq(struct irdma_pci_f *rf)
 		case IRDMA_AE_LCE_FUNCTION_CATASTROPHIC:
 		case IRDMA_AE_LLP_TOO_MANY_RNRS:
 		case IRDMA_AE_LCE_CQ_CATASTROPHIC:
+		case IRDMA_AE_REMOTE_QP_CATASTROPHIC:
+		case IRDMA_AE_LOCAL_QP_CATASTROPHIC:
+		case IRDMA_AE_RCE_QP_CATASTROPHIC:
 		case IRDMA_AE_UDA_XMIT_DGRAM_TOO_LONG:
 		default:
 			ibdev_err(&iwdev->ibdev, "abnormal ae_id = 0x%x bool qp=%d qp_id = %d, ae_src=%d\n",
@@ -688,7 +698,9 @@ static void irdma_destroy_aeq(struct irdma_pci_f *rf)
 	int status = -EBUSY;
 
 	if (!rf->msix_shared) {
-		rf->sc_dev.irq_ops->irdma_cfg_aeq(&rf->sc_dev, rf->iw_msixtbl->idx, false);
+		if (rf->sc_dev.privileged)
+			rf->sc_dev.irq_ops->irdma_cfg_aeq(&rf->sc_dev,
+							  rf->iw_msixtbl->idx, false);
 		irdma_destroy_irq(rf, rf->iw_msixtbl, rf);
 	}
 	if (rf->reset)
@@ -754,9 +766,10 @@ static void irdma_del_ceq_0(struct irdma_pci_f *rf)
 
 	if (rf->msix_shared) {
 		msix_vec = &rf->iw_msixtbl[0];
-		rf->sc_dev.irq_ops->irdma_cfg_ceq(&rf->sc_dev,
-						  msix_vec->ceq_id,
-						  msix_vec->idx, false);
+		if (rf->sc_dev.privileged)
+			rf->sc_dev.irq_ops->irdma_cfg_ceq(&rf->sc_dev,
+							  msix_vec->ceq_id,
+							  msix_vec->idx, false);
 		irdma_destroy_irq(rf, msix_vec, rf);
 	} else {
 		msix_vec = &rf->iw_msixtbl[1];
@@ -787,8 +800,10 @@ static void irdma_del_ceqs(struct irdma_pci_f *rf)
 		msix_vec = &rf->iw_msixtbl[2];
 
 	for (i = 1; i < rf->ceqs_count; i++, msix_vec++, iwceq++) {
-		rf->sc_dev.irq_ops->irdma_cfg_ceq(&rf->sc_dev, msix_vec->ceq_id,
-						  msix_vec->idx, false);
+		if (rf->sc_dev.privileged)
+			rf->sc_dev.irq_ops->irdma_cfg_ceq(&rf->sc_dev,
+							  msix_vec->ceq_id,
+							  msix_vec->idx, false);
 		irdma_destroy_irq(rf, msix_vec, iwceq);
 		irdma_cqp_ceq_cmd(&rf->sc_dev, &iwceq->sc_ceq,
 				  IRDMA_OP_CEQ_DESTROY);
@@ -1211,9 +1226,13 @@ static int irdma_cfg_ceq_vector(struct irdma_pci_f *rf, struct irdma_ceq *iwceq,
 	}
 
 	msix_vec->ceq_id = ceq_id;
-	rf->sc_dev.irq_ops->irdma_cfg_ceq(&rf->sc_dev, ceq_id, msix_vec->idx, true);
-
-	return 0;
+	if (rf->sc_dev.privileged)
+		rf->sc_dev.irq_ops->irdma_cfg_ceq(&rf->sc_dev, ceq_id,
+						  msix_vec->idx, true);
+	else
+		status = irdma_vchnl_req_ceq_vec_map(&rf->sc_dev, ceq_id,
+						     msix_vec->idx);
+	return status;
 }
 
 /**
@@ -1226,7 +1245,7 @@ static int irdma_cfg_ceq_vector(struct irdma_pci_f *rf, struct irdma_ceq *iwceq,
 static int irdma_cfg_aeq_vector(struct irdma_pci_f *rf)
 {
 	struct irdma_msix_vector *msix_vec = rf->iw_msixtbl;
-	u32 ret = 0;
+	int ret = 0;
 
 	if (!rf->msix_shared) {
 		snprintf(msix_vec->name, sizeof(msix_vec->name) - 1,
@@ -1237,12 +1256,16 @@ static int irdma_cfg_aeq_vector(struct irdma_pci_f *rf)
 	}
 	if (ret) {
 		ibdev_dbg(&rf->iwdev->ibdev, "ERR: aeq irq config fail\n");
-		return -EINVAL;
+		return ret;
 	}
 
-	rf->sc_dev.irq_ops->irdma_cfg_aeq(&rf->sc_dev, msix_vec->idx, true);
+	if (rf->sc_dev.privileged)
+		rf->sc_dev.irq_ops->irdma_cfg_aeq(&rf->sc_dev, msix_vec->idx,
+						  true);
+	else
+		ret = irdma_vchnl_req_aeq_vec_map(&rf->sc_dev, msix_vec->idx);
 
-	return 0;
+	return ret;
 }
 
 /**
@@ -1250,13 +1273,13 @@ static int irdma_cfg_aeq_vector(struct irdma_pci_f *rf)
  * @rf: RDMA PCI function
  * @iwceq: pointer to the ceq resources to be created
  * @ceq_id: the id number of the iwceq
- * @vsi: SC vsi struct
+ * @vsi_idx: vsi idx
  *
  * Return 0, if the ceq and the resources associated with it
  * are successfully created, otherwise return error
  */
 static int irdma_create_ceq(struct irdma_pci_f *rf, struct irdma_ceq *iwceq,
-			    u32 ceq_id, struct irdma_sc_vsi *vsi)
+			    u32 ceq_id, u16 vsi_idx)
 {
 	int status;
 	struct irdma_ceq_init_info info = {};
@@ -1280,7 +1303,7 @@ static int irdma_create_ceq(struct irdma_pci_f *rf, struct irdma_ceq *iwceq,
 	info.elem_cnt = ceq_size;
 	iwceq->sc_ceq.ceq_id = ceq_id;
 	info.dev = dev;
-	info.vsi = vsi;
+	info.vsi_idx = vsi_idx;
 	status = irdma_sc_ceq_init(&iwceq->sc_ceq, &info);
 	if (!status) {
 		if (dev->ceq_valid)
@@ -1323,7 +1346,7 @@ static int irdma_setup_ceq_0(struct irdma_pci_f *rf)
 	}
 
 	iwceq = &rf->ceqlist[0];
-	status = irdma_create_ceq(rf, iwceq, 0, &rf->default_vsi);
+	status = irdma_create_ceq(rf, iwceq, 0, rf->default_vsi.vsi_idx);
 	if (status) {
 		ibdev_dbg(&rf->iwdev->ibdev, "ERR: create ceq status = %d\n",
 			  status);
@@ -1358,13 +1381,13 @@ static int irdma_setup_ceq_0(struct irdma_pci_f *rf)
 /**
  * irdma_setup_ceqs - manage the device ceq's and their interrupt resources
  * @rf: RDMA PCI function
- * @vsi: VSI structure for this CEQ
+ * @vsi_idx: vsi_idx for this CEQ
  *
  * Allocate a list for all device completion event queues
  * Create the ceq's and configure their msix interrupt vectors
  * Return 0, if ceqs are successfully set up, otherwise return error
  */
-static int irdma_setup_ceqs(struct irdma_pci_f *rf, struct irdma_sc_vsi *vsi)
+static int irdma_setup_ceqs(struct irdma_pci_f *rf, u16 vsi_idx)
 {
 	u32 i;
 	u32 ceq_id;
@@ -1377,7 +1400,7 @@ static int irdma_setup_ceqs(struct irdma_pci_f *rf, struct irdma_sc_vsi *vsi)
 	i = (rf->msix_shared) ? 1 : 2;
 	for (ceq_id = 1; i < num_ceqs; i++, ceq_id++) {
 		iwceq = &rf->ceqlist[ceq_id];
-		status = irdma_create_ceq(rf, iwceq, ceq_id, vsi);
+		status = irdma_create_ceq(rf, iwceq, ceq_id, vsi_idx);
 		if (status) {
 			ibdev_dbg(&rf->iwdev->ibdev,
 				  "ERR: create ceq status = %d\n", status);
@@ -1458,7 +1481,10 @@ static int irdma_create_aeq(struct irdma_pci_f *rf)
 	aeq_size = multiplier * hmc_info->hmc_obj[IRDMA_HMC_IW_QP].cnt +
 		   hmc_info->hmc_obj[IRDMA_HMC_IW_CQ].cnt;
 	aeq_size = min(aeq_size, dev->hw_attrs.max_hw_aeq_size);
-
+	/* GEN_3 does not support virtual AEQ. Cap at max Kernel alloc size */
+	if (rf->rdma_ver == IRDMA_GEN_3)
+		aeq_size = min(aeq_size, (u32)((PAGE_SIZE << MAX_PAGE_ORDER) /
+			       sizeof(struct irdma_sc_aeqe)));
 	aeq->mem.size = ALIGN(sizeof(struct irdma_sc_aeqe) * aeq_size,
 			      IRDMA_AEQ_ALIGNMENT);
 	aeq->mem.va = dma_alloc_coherent(dev->hw->device, aeq->mem.size,
@@ -1466,6 +1492,8 @@ static int irdma_create_aeq(struct irdma_pci_f *rf)
 					 GFP_KERNEL | __GFP_NOWARN);
 	if (aeq->mem.va)
 		goto skip_virt_aeq;
+	else if (rf->rdma_ver == IRDMA_GEN_3)
+		return -ENOMEM;
 
 	/* physically mapped aeq failed. setup virtual aeq */
 	status = irdma_create_virt_aeq(rf, aeq_size);
@@ -1739,9 +1767,6 @@ void irdma_rt_deinit_hw(struct irdma_device *iwdev)
 			irdma_del_local_mac_entry(iwdev->rf,
 						  (u8)iwdev->mac_ip_table_idx);
 		fallthrough;
-	case AEQ_CREATED:
-	case PBLE_CHUNK_MEM:
-	case CEQS_CREATED:
 	case IEQ_CREATED:
 		if (!iwdev->roce_mode)
 			irdma_puda_dele_rsrc(&iwdev->vsi, IRDMA_PUDA_RSRC_TYPE_IEQ,
@@ -1824,13 +1849,17 @@ void irdma_ctrl_deinit_hw(struct irdma_pci_f *rf)
 	enum init_completion_state state = rf->init_state;
 
 	rf->init_state = INVALID_STATE;
-	if (rf->rsrc_created) {
+
+	switch (state) {
+	case AEQ_CREATED:
 		irdma_destroy_aeq(rf);
+		fallthrough;
+	case PBLE_CHUNK_MEM:
 		irdma_destroy_pble_prm(rf->pble_rsrc);
+		fallthrough;
+	case CEQS_CREATED:
 		irdma_del_ceqs(rf);
-		rf->rsrc_created = false;
-	}
-	switch (state) {
+		fallthrough;
 	case CEQ0_CREATED:
 		irdma_del_ceq_0(rf);
 		fallthrough;
@@ -1909,32 +1938,6 @@ int irdma_rt_init_hw(struct irdma_device *iwdev,
 				break;
 			iwdev->init_state = IEQ_CREATED;
 		}
-		if (!rf->rsrc_created) {
-			status = irdma_setup_ceqs(rf, &iwdev->vsi);
-			if (status)
-				break;
-
-			iwdev->init_state = CEQS_CREATED;
-
-			status = irdma_hmc_init_pble(&rf->sc_dev,
-						     rf->pble_rsrc);
-			if (status) {
-				irdma_del_ceqs(rf);
-				break;
-			}
-
-			iwdev->init_state = PBLE_CHUNK_MEM;
-
-			status = irdma_setup_aeq(rf);
-			if (status) {
-				irdma_destroy_pble_prm(rf->pble_rsrc);
-				irdma_del_ceqs(rf);
-				break;
-			}
-			iwdev->init_state = AEQ_CREATED;
-			rf->rsrc_created = true;
-		}
-
 		if (iwdev->rf->sc_dev.hw_attrs.uk_attrs.hw_rev == IRDMA_GEN_1)
 			irdma_alloc_set_mac(iwdev);
 		irdma_add_ip(iwdev);
@@ -2016,6 +2019,25 @@ int irdma_ctrl_init_hw(struct irdma_pci_f *rf)
 		}
 		INIT_WORK(&rf->cqp_cmpl_work, cqp_compl_worker);
 		irdma_sc_ccq_arm(dev->ccq);
+
+		status = irdma_setup_ceqs(rf, rf->iwdev ? rf->iwdev->vsi_num : 0);
+		if (status)
+			break;
+
+		rf->init_state = CEQS_CREATED;
+
+		status = irdma_hmc_init_pble(&rf->sc_dev,
+					     rf->pble_rsrc);
+		if (status)
+			break;
+
+		rf->init_state = PBLE_CHUNK_MEM;
+
+		status = irdma_setup_aeq(rf);
+		if (status)
+			break;
+		rf->init_state = AEQ_CREATED;
+
 		return 0;
 	} while (0);
 
diff --git a/drivers/infiniband/hw/irdma/ig3rdma_hw.c b/drivers/infiniband/hw/irdma/ig3rdma_hw.c
index 83ef6af82a8f..1d582c50e4d2 100644
--- a/drivers/infiniband/hw/irdma/ig3rdma_hw.c
+++ b/drivers/infiniband/hw/irdma/ig3rdma_hw.c
@@ -5,8 +5,53 @@
 #include "protos.h"
 #include "ig3rdma_hw.h"
 
+/**
+ * ig3rdma_ena_irq - Enable interrupt
+ * @dev: pointer to the device structure
+ * @idx: vector index
+ */
+static void ig3rdma_ena_irq(struct irdma_sc_dev *dev, u32 idx)
+{
+	u32 val;
+	u32 int_stride = 1; /* one u32 per register */
+
+	if (dev->is_pf)
+		int_stride = 0x400;
+	else
+		idx--; /* VFs use DYN_CTL_N */
+
+	val = FIELD_PREP(IRDMA_GLINT_DYN_CTL_INTENA, 1) |
+	      FIELD_PREP(IRDMA_GLINT_DYN_CTL_CLEARPBA, 1);
+
+	writel(val, dev->hw_regs[IRDMA_GLINT_DYN_CTL] + (idx * int_stride));
+}
+
+/**
+ * ig3rdma_disable_irq - Disable interrupt
+ * @dev: pointer to the device structure
+ * @idx: vector index
+ */
+static void ig3rdma_disable_irq(struct irdma_sc_dev *dev, u32 idx)
+{
+	u32 int_stride = 1; /* one u32 per register */
+
+	if (dev->is_pf)
+		int_stride = 0x400;
+	else
+		idx--; /* VFs use DYN_CTL_N */
+
+	writel(0, dev->hw_regs[IRDMA_GLINT_DYN_CTL] + (idx * int_stride));
+}
+
+static const struct irdma_irq_ops ig3rdma_irq_ops = {
+	.irdma_dis_irq = ig3rdma_disable_irq,
+	.irdma_en_irq = ig3rdma_ena_irq,
+};
+
 void ig3rdma_init_hw(struct irdma_sc_dev *dev)
 {
+	dev->irq_ops = &ig3rdma_irq_ops;
+
 	dev->hw_attrs.uk_attrs.hw_rev = IRDMA_GEN_3;
 	dev->hw_attrs.uk_attrs.max_hw_wq_frags = IG3RDMA_MAX_WQ_FRAGMENT_COUNT;
 	dev->hw_attrs.uk_attrs.max_hw_read_sges = IG3RDMA_MAX_SGE_RD;
diff --git a/drivers/infiniband/hw/irdma/irdma.h b/drivers/infiniband/hw/irdma/irdma.h
index 7e3214904488..e012f795bce8 100644
--- a/drivers/infiniband/hw/irdma/irdma.h
+++ b/drivers/infiniband/hw/irdma/irdma.h
@@ -32,7 +32,16 @@
 #define IRDMA_PFHMC_SDDATALOW_PMSDDATALOW GENMASK(31, 12)
 #define IRDMA_PFHMC_SDCMD_PMSDWR BIT(31)
 
-#define IRDMA_INVALID_CQ_IDX			0xffffffff
+#define IRDMA_INVALID_CQ_IDX 0xffffffff
+#define IRDMA_Q_INVALID_IDX 0xffff
+
+enum irdma_dyn_idx_t {
+	IRDMA_IDX_ITR0 = 0,
+	IRDMA_IDX_ITR1 = 1,
+	IRDMA_IDX_ITR2 = 2,
+	IRDMA_IDX_NOITR = 3,
+};
+
 enum irdma_registers {
 	IRDMA_CQPTAIL,
 	IRDMA_CQPDB,
diff --git a/drivers/infiniband/hw/irdma/main.h b/drivers/infiniband/hw/irdma/main.h
index 5d1371891c4c..17169338045a 100644
--- a/drivers/infiniband/hw/irdma/main.h
+++ b/drivers/infiniband/hw/irdma/main.h
@@ -127,12 +127,12 @@ enum init_completion_state {
 	HMC_OBJS_CREATED,
 	HW_RSRC_INITIALIZED,
 	CCQ_CREATED,
-	CEQ0_CREATED, /* Last state of probe */
-	ILQ_CREATED,
-	IEQ_CREATED,
+	CEQ0_CREATED,
 	CEQS_CREATED,
 	PBLE_CHUNK_MEM,
 	AEQ_CREATED,
+	ILQ_CREATED,
+	IEQ_CREATED, /* Last state of probe */
 	IP_ADDR_REGISTERED,  /* Last state of open */
 };
 
diff --git a/drivers/infiniband/hw/irdma/type.h b/drivers/infiniband/hw/irdma/type.h
index a1c83d5c8012..30c0e74f2c90 100644
--- a/drivers/infiniband/hw/irdma/type.h
+++ b/drivers/infiniband/hw/irdma/type.h
@@ -472,6 +472,8 @@ struct irdma_sc_aeq {
 	u32 msix_idx;
 	u8 polarity;
 	bool virtual_map:1;
+	bool pasid_valid:1;
+	u32 pasid;
 };
 
 struct irdma_sc_ceq {
@@ -487,13 +489,15 @@ struct irdma_sc_ceq {
 	u8 tph_val;
 	u32 first_pm_pbl_idx;
 	u8 polarity;
-	struct irdma_sc_vsi *vsi;
+	u16 vsi_idx;
 	struct irdma_sc_cq **reg_cq;
 	u32 reg_cq_size;
 	spinlock_t req_cq_lock; /* protect access to reg_cq array */
 	bool virtual_map:1;
 	bool tph_en:1;
 	bool itr_no_expire:1;
+	bool pasid_valid:1;
+	u32 pasid;
 };
 
 struct irdma_sc_cq {
@@ -501,6 +505,7 @@ struct irdma_sc_cq {
 	u64 cq_pa;
 	u64 shadow_area_pa;
 	struct irdma_sc_dev *dev;
+	u16 vsi_idx;
 	struct irdma_sc_vsi *vsi;
 	void *pbl_list;
 	void *back_cq;
@@ -834,8 +839,8 @@ struct irdma_ceq_init_info {
 	bool itr_no_expire:1;
 	u8 pbl_chunk_size;
 	u8 tph_val;
+	u16 vsi_idx;
 	u32 first_pm_pbl_idx;
-	struct irdma_sc_vsi *vsi;
 	struct irdma_sc_cq **reg_cq;
 	u32 reg_cq_idx;
 };
@@ -1042,9 +1047,11 @@ struct irdma_aeqe_info {
 	bool cq:1;
 	bool sq:1;
 	bool rq:1;
+	bool srq:1;
 	bool in_rdrsp_wr:1;
 	bool out_rdrsp:1;
 	bool aeqe_overflow:1;
+	bool err_rq_idx_valid:1;
 	u8 q2_data_written;
 	u8 ae_src;
 };
diff --git a/drivers/infiniband/hw/irdma/virtchnl.c b/drivers/infiniband/hw/irdma/virtchnl.c
index f0ff3b29c329..4f5c0a369cc7 100644
--- a/drivers/infiniband/hw/irdma/virtchnl.c
+++ b/drivers/infiniband/hw/irdma/virtchnl.c
@@ -108,6 +108,8 @@ static int irdma_vchnl_req_verify_resp(struct irdma_vchnl_req *vchnl_req,
 			return -EBADMSG;
 		break;
 	case IRDMA_VCHNL_OP_GET_REG_LAYOUT:
+	case IRDMA_VCHNL_OP_QUEUE_VECTOR_MAP:
+	case IRDMA_VCHNL_OP_QUEUE_VECTOR_UNMAP:
 		break;
 	default:
 		return -EOPNOTSUPP;
@@ -313,6 +315,88 @@ int irdma_vchnl_req_get_reg_layout(struct irdma_sc_dev *dev)
 	return 0;
 }
 
+/**
+ * irdma_vchnl_req_aeq_vec_map - Map AEQ to vector on this function
+ * @dev: RDMA device pointer
+ * @v_idx: vector index
+ */
+int irdma_vchnl_req_aeq_vec_map(struct irdma_sc_dev *dev, u32 v_idx)
+{
+	struct irdma_vchnl_req_init_info info = {};
+	struct irdma_vchnl_qvlist_info *qvl;
+	struct irdma_vchnl_qv_info *qv;
+	u16 qvl_size, num_vectors = 1;
+	int ret;
+
+	if (!dev->vchnl_up)
+		return -EBUSY;
+
+	qvl_size = struct_size(qvl, qv_info, num_vectors);
+
+	qvl = kzalloc(qvl_size, GFP_KERNEL);
+	if (!qvl)
+		return -ENOMEM;
+
+	qvl->num_vectors = 1;
+	qv = qvl->qv_info;
+
+	qv->ceq_idx = IRDMA_Q_INVALID_IDX;
+	qv->v_idx = v_idx;
+	qv->itr_idx = IRDMA_IDX_ITR0;
+
+	info.op_code = IRDMA_VCHNL_OP_QUEUE_VECTOR_MAP;
+	info.op_ver = IRDMA_VCHNL_OP_QUEUE_VECTOR_MAP_V0;
+	info.req_parm = qvl;
+	info.req_parm_len = qvl_size;
+
+	ret = irdma_vchnl_req_send_sync(dev, &info);
+	kfree(qvl);
+
+	return ret;
+}
+
+/**
+ * irdma_vchnl_req_ceq_vec_map - Map CEQ to vector on this function
+ * @dev: RDMA device pointer
+ * @ceq_id: CEQ index
+ * @v_idx: vector index
+ */
+int irdma_vchnl_req_ceq_vec_map(struct irdma_sc_dev *dev, u16 ceq_id, u32 v_idx)
+{
+	struct irdma_vchnl_req_init_info info = {};
+	struct irdma_vchnl_qvlist_info *qvl;
+	struct irdma_vchnl_qv_info *qv;
+	u16 qvl_size, num_vectors = 1;
+	int ret;
+
+	if (!dev->vchnl_up)
+		return -EBUSY;
+
+	qvl_size = struct_size(qvl, qv_info, num_vectors);
+
+	qvl = kzalloc(qvl_size, GFP_KERNEL);
+	if (!qvl)
+		return -ENOMEM;
+
+	qvl->num_vectors = num_vectors;
+	qv = qvl->qv_info;
+
+	qv->aeq_idx = IRDMA_Q_INVALID_IDX;
+	qv->ceq_idx = ceq_id;
+	qv->v_idx = v_idx;
+	qv->itr_idx = IRDMA_IDX_ITR0;
+
+	info.op_code = IRDMA_VCHNL_OP_QUEUE_VECTOR_MAP;
+	info.op_ver = IRDMA_VCHNL_OP_QUEUE_VECTOR_MAP_V0;
+	info.req_parm = qvl;
+	info.req_parm_len = qvl_size;
+
+	ret = irdma_vchnl_req_send_sync(dev, &info);
+	kfree(qvl);
+
+	return ret;
+}
+
 /**
  * irdma_vchnl_req_get_ver - Request Channel version
  * @dev: RDMA device pointer
diff --git a/drivers/infiniband/hw/irdma/virtchnl.h b/drivers/infiniband/hw/irdma/virtchnl.h
index 20526c0b4285..3af725587754 100644
--- a/drivers/infiniband/hw/irdma/virtchnl.h
+++ b/drivers/infiniband/hw/irdma/virtchnl.h
@@ -15,6 +15,8 @@
 #define IRDMA_VCHNL_OP_GET_HMC_FCN_V2 2
 #define IRDMA_VCHNL_OP_PUT_HMC_FCN_V0 0
 #define IRDMA_VCHNL_OP_GET_REG_LAYOUT_V0 0
+#define IRDMA_VCHNL_OP_QUEUE_VECTOR_MAP_V0 0
+#define IRDMA_VCHNL_OP_QUEUE_VECTOR_UNMAP_V0 0
 #define IRDMA_VCHNL_OP_GET_RDMA_CAPS_V0 0
 #define IRDMA_VCHNL_OP_GET_RDMA_CAPS_MIN_SIZE 1
 
@@ -53,6 +55,8 @@ enum irdma_vchnl_ops {
 	IRDMA_VCHNL_OP_PUT_HMC_FCN = 2,
 	IRDMA_VCHNL_OP_GET_REG_LAYOUT = 11,
 	IRDMA_VCHNL_OP_GET_RDMA_CAPS = 13,
+	IRDMA_VCHNL_OP_QUEUE_VECTOR_MAP = 14,
+	IRDMA_VCHNL_OP_QUEUE_VECTOR_UNMAP = 15,
 };
 
 struct irdma_vchnl_req_hmc_info {
@@ -65,6 +69,18 @@ struct irdma_vchnl_resp_hmc_info {
 	u16 qs_handle[IRDMA_MAX_USER_PRIORITY];
 } __packed;
 
+struct irdma_vchnl_qv_info {
+	u32 v_idx;
+	u16 ceq_idx;
+	u16 aeq_idx;
+	u8 itr_idx;
+};
+
+struct irdma_vchnl_qvlist_info {
+	u32 num_vectors;
+	struct irdma_vchnl_qv_info qv_info[];
+};
+
 struct irdma_vchnl_op_buf {
 	u16 op_code;
 	u16 op_ver;
@@ -137,4 +153,7 @@ int irdma_vchnl_req_get_caps(struct irdma_sc_dev *dev);
 int irdma_vchnl_req_get_resp(struct irdma_sc_dev *dev,
 			     struct irdma_vchnl_req *vc_req);
 int irdma_vchnl_req_get_reg_layout(struct irdma_sc_dev *dev);
+int irdma_vchnl_req_aeq_vec_map(struct irdma_sc_dev *dev, u32 v_idx);
+int irdma_vchnl_req_ceq_vec_map(struct irdma_sc_dev *dev, u16 ceq_id,
+				u32 v_idx);
 #endif /* IRDMA_VIRTCHNL_H */
-- 
2.37.3


