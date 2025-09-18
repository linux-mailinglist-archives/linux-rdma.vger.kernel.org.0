Return-Path: <linux-rdma+bounces-12958-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE1DB3869E
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Aug 2025 17:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7438163DE4
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Aug 2025 15:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0883C286D52;
	Wed, 27 Aug 2025 15:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Htk5gNG7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D483D284886
	for <linux-rdma@vger.kernel.org>; Wed, 27 Aug 2025 15:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756308418; cv=none; b=abXa9rCY6Kd4Vjcr45klVQezXnL5hZKhCtX6F6TdgPc1O1Fz6NMn57mSLpAooiTLOPaEIpFPPdDNEJh8BNYj4VgC5pQBay6EDle+XNf6fRJO+nnzo0VhriDj7Uu3IC7cPI5eoDYjisMJ659J5i/ZT/cDYYUD5QFqA/V3+jFF+Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756308418; c=relaxed/simple;
	bh=vSgiTIwvj6Ji4h1k4l13a/8FkrfU5CPPd7rTagDINT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G0WrFSPmeFyMDIGEtkwTLktS875goHuEPqj89fZwvwCwABrb4SGb4j6AKScKuTMvSZwNcIw7LfP4h0cszI3CF7oWH4tGjbbwzTp0lQj4uL4/TlNq9SobRvNJsBvzj+crNoxacNOwmG2FzDpKBTdtiyAFW3DPs0kzCNAr5Ms6x2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Htk5gNG7; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756308416; x=1787844416;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vSgiTIwvj6Ji4h1k4l13a/8FkrfU5CPPd7rTagDINT8=;
  b=Htk5gNG7oJOD5znWegQ51lHnXIsCY5J+cKFp8CJwQ3QJ9Zu/PUTOj93a
   PUDk4RjuoK+mBAnPH7TKrwBMT6NWn4zUDe5sF8A+JBt4ojqNSpnwejNs0
   FO3T7Y1ZkRMov0zEPJz+vAyutx04mUsjgI09aNKjQFZLq3wyNX8ceQMKS
   YZmSrwVC9zanFdOsIDry/iNAP4EPIzCb6kSEtNC8t0x6PTcTRZpid2Ssf
   GBGeYay5axTt99KR1jIFVph1R6TlJto9rXovywvZGWiBF65o8x3g7HJ8W
   n7taQsn9Ef/XfqvmTSLeQmvrKBPFOQ0UAvPKCvhdhYQthPUZ37YycaDpp
   w==;
X-CSE-ConnectionGUID: ylGW3gezQtm+vC8Cy6fhpg==
X-CSE-MsgGUID: /nTJTh6NQ+i6wo2/PXckAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="76162771"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="76162771"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 08:26:42 -0700
X-CSE-ConnectionGUID: jw1ZWWCjR96RU2a3XKFaeA==
X-CSE-MsgGUID: qlCjrHCXSMyNcTiJV8eXDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="174206791"
Received: from pthorat-mobl.amr.corp.intel.com (HELO soc-PF51RAGT.clients.intel.com) ([10.246.116.180])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 08:26:36 -0700
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	tatyana.e.nikolova@intel.com,
	krzysztof.czurylo@intel.com
Subject: [for-next 04/16] RDMA/irdma: Add GEN3 CQP support with deferred completions
Date: Wed, 27 Aug 2025 10:25:33 -0500
Message-ID: <20250827152545.2056-5-tatyana.e.nikolova@intel.com>
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

From: Krzysztof Czurylo <krzysztof.czurylo@intel.com>

GEN3 introduces asynchronous handling of Control QP (CQP) operations to
minimize head-of-line blocking. Create the CQP using the updated GEN3-
specific descriptor fields and implement the necessary support for this
deferred completion mechanism.

Signed-off-by: Krzysztof Czurylo <krzysztof.czurylo@intel.com>
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
---
 drivers/infiniband/hw/irdma/ctrl.c   | 253 ++++++++++++++++++++++++++-
 drivers/infiniband/hw/irdma/defs.h   |  15 ++
 drivers/infiniband/hw/irdma/hw.c     |  89 ++++++++--
 drivers/infiniband/hw/irdma/main.h   |   2 +
 drivers/infiniband/hw/irdma/protos.h |   1 +
 drivers/infiniband/hw/irdma/type.h   |  43 ++++-
 drivers/infiniband/hw/irdma/utils.c  |  50 +++++-
 7 files changed, 438 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/ctrl.c b/drivers/infiniband/hw/irdma/ctrl.c
index dd174e771786..0fd2b6869ecd 100644
--- a/drivers/infiniband/hw/irdma/ctrl.c
+++ b/drivers/infiniband/hw/irdma/ctrl.c
@@ -2741,6 +2741,89 @@ static inline void irdma_get_cqp_reg_info(struct irdma_sc_cqp *cqp, u32 *val,
 	*error = FIELD_GET(IRDMA_CQPTAIL_CQP_OP_ERR, *val);
 }
 
+/**
+ * irdma_sc_cqp_def_cmpl_ae_handler - remove completed requests from pending list
+ * @dev: sc device struct
+ * @info: AE entry info
+ * @first: true if this is the first call to this handler for given AEQE
+ * @scratch: (out) scratch entry pointer
+ * @sw_def_info: (in/out) SW ticket value for this AE
+ *
+ * In case of AE_DEF_CMPL event, this function should be called in a loop
+ * until it returns NULL-ptr via scratch.
+ * For each call, it looks for a matching CQP request on pending list,
+ * removes it from the list and returns the pointer to the associated scratch
+ * entry.
+ * If this is the first call to this function for given AEQE, sw_def_info
+ * value is not used to find matching requests.  Instead, it is populated
+ * with the value from the first matching cqp_request on the list.
+ * For subsequent calls, ooo_op->sw_def_info need to match the value passed
+ * by a caller.
+ *
+ * Return: scratch entry pointer for cqp_request to be released or NULL
+ * if no matching request is found.
+ */
+void irdma_sc_cqp_def_cmpl_ae_handler(struct irdma_sc_dev *dev,
+				      struct irdma_aeqe_info *info,
+				      bool first, u64 *scratch,
+				      u32 *sw_def_info)
+{
+	struct irdma_ooo_cqp_op *ooo_op;
+	unsigned long flags;
+
+	*scratch = 0;
+
+	spin_lock_irqsave(&dev->cqp->ooo_list_lock, flags);
+	list_for_each_entry(ooo_op, &dev->cqp->ooo_pnd, list_entry) {
+		if (ooo_op->deferred &&
+		    ((first && ooo_op->def_info == info->def_info) ||
+		     (!first && ooo_op->sw_def_info == *sw_def_info))) {
+			*sw_def_info = ooo_op->sw_def_info;
+			*scratch = ooo_op->scratch;
+
+			list_move(&ooo_op->list_entry, &dev->cqp->ooo_avail);
+			atomic64_inc(&dev->cqp->completed_ops);
+
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&dev->cqp->ooo_list_lock, flags);
+
+	if (first && !*scratch)
+		ibdev_dbg(to_ibdev(dev),
+			  "AEQ: deferred completion with unknown ticket: def_info 0x%x\n",
+			   info->def_info);
+}
+
+/**
+ * irdma_sc_cqp_cleanup_handler - remove requests from pending list
+ * @dev: sc device struct
+ *
+ * This function should be called in a loop from irdma_cleanup_pending_cqp_op.
+ * For each call, it returns first CQP request on pending list, removes it
+ * from the list and returns the pointer to the associated scratch entry.
+ *
+ * Return: scratch entry pointer for cqp_request to be released or NULL
+ * if pending list is empty.
+ */
+u64 irdma_sc_cqp_cleanup_handler(struct irdma_sc_dev *dev)
+{
+	struct irdma_ooo_cqp_op *ooo_op;
+	u64 scratch = 0;
+
+	list_for_each_entry(ooo_op, &dev->cqp->ooo_pnd, list_entry) {
+		scratch = ooo_op->scratch;
+
+		list_del(&ooo_op->list_entry);
+		list_add(&ooo_op->list_entry, &dev->cqp->ooo_avail);
+		atomic64_inc(&dev->cqp->completed_ops);
+
+		break;
+	}
+
+	return scratch;
+}
+
 /**
  * irdma_cqp_poll_registers - poll cqp registers
  * @cqp: struct for cqp hw
@@ -3126,6 +3209,8 @@ void irdma_sc_remove_cq_ctx(struct irdma_sc_ceq *ceq, struct irdma_sc_cq *cq)
 int irdma_sc_cqp_init(struct irdma_sc_cqp *cqp,
 		      struct irdma_cqp_init_info *info)
 {
+	struct irdma_ooo_cqp_op *ooo_op;
+	u32 num_ooo_ops;
 	u8 hw_sq_size;
 
 	if (info->sq_size > IRDMA_CQP_SW_SQSIZE_2048 ||
@@ -3156,17 +3241,43 @@ int irdma_sc_cqp_init(struct irdma_sc_cqp *cqp,
 	cqp->rocev2_rto_policy = info->rocev2_rto_policy;
 	cqp->protocol_used = info->protocol_used;
 	memcpy(&cqp->dcqcn_params, &info->dcqcn_params, sizeof(cqp->dcqcn_params));
+	if (cqp->dev->hw_attrs.uk_attrs.hw_rev >= IRDMA_GEN_3) {
+		cqp->ooisc_blksize = info->ooisc_blksize;
+		cqp->rrsp_blksize = info->rrsp_blksize;
+		cqp->q1_blksize = info->q1_blksize;
+		cqp->xmit_blksize = info->xmit_blksize;
+		cqp->blksizes_valid = info->blksizes_valid;
+		cqp->ts_shift = info->ts_shift;
+		cqp->ts_override = info->ts_override;
+		cqp->en_fine_grained_timers = info->en_fine_grained_timers;
+		cqp->pe_en_vf_cnt = info->pe_en_vf_cnt;
+		cqp->ooo_op_array = info->ooo_op_array;
+		/* initialize the OOO lists */
+		INIT_LIST_HEAD(&cqp->ooo_avail);
+		INIT_LIST_HEAD(&cqp->ooo_pnd);
+		if (cqp->ooo_op_array) {
+			/* Populate avail list entries */
+			for (num_ooo_ops = 0, ooo_op = info->ooo_op_array;
+			     num_ooo_ops < cqp->sq_size;
+			     num_ooo_ops++, ooo_op++)
+				list_add(&ooo_op->list_entry, &cqp->ooo_avail);
+		}
+	}
 	info->dev->cqp = cqp;
 
 	IRDMA_RING_INIT(cqp->sq_ring, cqp->sq_size);
+	cqp->last_def_cmpl_ticket = 0;
+	cqp->sw_def_cmpl_ticket = 0;
 	cqp->requested_ops = 0;
 	atomic64_set(&cqp->completed_ops, 0);
 	/* for the cqp commands backlog. */
 	INIT_LIST_HEAD(&cqp->dev->cqp_cmd_head);
 
 	writel(0, cqp->dev->hw_regs[IRDMA_CQPTAIL]);
-	writel(0, cqp->dev->hw_regs[IRDMA_CQPDB]);
-	writel(0, cqp->dev->hw_regs[IRDMA_CCQPSTATUS]);
+	if (cqp->dev->hw_attrs.uk_attrs.hw_rev <= IRDMA_GEN_2) {
+		writel(0, cqp->dev->hw_regs[IRDMA_CQPDB]);
+		writel(0, cqp->dev->hw_regs[IRDMA_CCQPSTATUS]);
+	}
 
 	ibdev_dbg(to_ibdev(cqp->dev),
 		  "WQE: sq_size[%04d] hw_sq_size[%04d] sq_base[%p] sq_pa[%p] cqp[%p] polarity[x%04x]\n",
@@ -3198,6 +3309,7 @@ int irdma_sc_cqp_create(struct irdma_sc_cqp *cqp, u16 *maj_err, u16 *min_err)
 		return -ENOMEM;
 
 	spin_lock_init(&cqp->dev->cqp_lock);
+	spin_lock_init(&cqp->ooo_list_lock);
 
 	temp = FIELD_PREP(IRDMA_CQPHC_SQSIZE, cqp->hw_sq_size) |
 	       FIELD_PREP(IRDMA_CQPHC_SVER, cqp->struct_ver) |
@@ -3209,12 +3321,29 @@ int irdma_sc_cqp_create(struct irdma_sc_cqp *cqp, u16 *maj_err, u16 *min_err)
 			FIELD_PREP(IRDMA_CQPHC_PROTOCOL_USED,
 				   cqp->protocol_used);
 	}
+	if (hw_rev >= IRDMA_GEN_3)
+		temp |= FIELD_PREP(IRDMA_CQPHC_EN_FINE_GRAINED_TIMERS,
+				   cqp->en_fine_grained_timers);
 
 	set_64bit_val(cqp->host_ctx, 0, temp);
 	set_64bit_val(cqp->host_ctx, 8, cqp->sq_pa);
 
 	temp = FIELD_PREP(IRDMA_CQPHC_ENABLED_VFS, cqp->ena_vf_count) |
 	       FIELD_PREP(IRDMA_CQPHC_HMC_PROFILE, cqp->hmc_profile);
+
+	if (hw_rev >= IRDMA_GEN_3)
+		temp |= FIELD_PREP(IRDMA_CQPHC_OOISC_BLKSIZE,
+				   cqp->ooisc_blksize) |
+			FIELD_PREP(IRDMA_CQPHC_RRSP_BLKSIZE,
+				   cqp->rrsp_blksize) |
+			FIELD_PREP(IRDMA_CQPHC_Q1_BLKSIZE, cqp->q1_blksize) |
+			FIELD_PREP(IRDMA_CQPHC_XMIT_BLKSIZE,
+				   cqp->xmit_blksize) |
+			FIELD_PREP(IRDMA_CQPHC_BLKSIZES_VALID,
+				   cqp->blksizes_valid) |
+			FIELD_PREP(IRDMA_CQPHC_TIMESTAMP_OVERRIDE,
+				   cqp->ts_override) |
+			FIELD_PREP(IRDMA_CQPHC_TS_SHIFT, cqp->ts_shift);
 	set_64bit_val(cqp->host_ctx, 16, temp);
 	set_64bit_val(cqp->host_ctx, 24, (uintptr_t)cqp);
 	temp = FIELD_PREP(IRDMA_CQPHC_HW_MAJVER, cqp->hw_maj_ver) |
@@ -3375,6 +3504,87 @@ void irdma_sc_ccq_arm(struct irdma_sc_cq *ccq)
 	writel(ccq->cq_uk.cq_id, ccq->dev->cq_arm_db);
 }
 
+/**
+ * irdma_sc_process_def_cmpl - process deferred or pending completion
+ * @cqp: CQP sc struct
+ * @info: CQP CQE info
+ * @wqe_idx: CQP WQE descriptor index
+ * @def_info: deferred op ticket value or out-of-order completion id
+ * @def_cmpl: true for deferred completion, false for pending (RCA)
+ */
+static void irdma_sc_process_def_cmpl(struct irdma_sc_cqp *cqp,
+				      struct irdma_ccq_cqe_info *info,
+				      u32 wqe_idx, u32 def_info, bool def_cmpl)
+{
+	struct irdma_ooo_cqp_op *ooo_op;
+	unsigned long flags;
+
+	/* Deferred and out-of-order completions share the same list of pending
+	 * completions.  Since the list can be also accessed from AE handler,
+	 * it must be protected by a lock.
+	 */
+	spin_lock_irqsave(&cqp->ooo_list_lock, flags);
+
+	/* For deferred completions bump up SW completion ticket value. */
+	if (def_cmpl) {
+		cqp->last_def_cmpl_ticket = def_info;
+		cqp->sw_def_cmpl_ticket++;
+	}
+	if (!list_empty(&cqp->ooo_avail)) {
+		ooo_op = (struct irdma_ooo_cqp_op *)
+			 list_entry(cqp->ooo_avail.next,
+				    struct irdma_ooo_cqp_op, list_entry);
+
+		list_del(&ooo_op->list_entry);
+		ooo_op->scratch = info->scratch;
+		ooo_op->def_info = def_info;
+		ooo_op->sw_def_info = cqp->sw_def_cmpl_ticket;
+		ooo_op->deferred = def_cmpl;
+		ooo_op->wqe_idx = wqe_idx;
+		/* Pending completions must be chronologically ordered,
+		 * so adding at the end of list.
+		 */
+		list_add_tail(&ooo_op->list_entry, &cqp->ooo_pnd);
+	}
+	spin_unlock_irqrestore(&cqp->ooo_list_lock, flags);
+
+	info->pending = true;
+}
+
+/**
+ * irdma_sc_process_ooo_cmpl - process out-of-order (final) completion
+ * @cqp: CQP sc struct
+ * @info: CQP CQE info
+ * @def_info: out-of-order completion id
+ */
+static void irdma_sc_process_ooo_cmpl(struct irdma_sc_cqp *cqp,
+				      struct irdma_ccq_cqe_info *info,
+				      u32 def_info)
+{
+	struct irdma_ooo_cqp_op *ooo_op_tmp;
+	struct irdma_ooo_cqp_op *ooo_op;
+	unsigned long flags;
+
+	info->scratch = 0;
+
+	spin_lock_irqsave(&cqp->ooo_list_lock, flags);
+	list_for_each_entry_safe(ooo_op, ooo_op_tmp, &cqp->ooo_pnd,
+				 list_entry) {
+		if (!ooo_op->deferred && ooo_op->def_info == def_info) {
+			list_del(&ooo_op->list_entry);
+			info->scratch = ooo_op->scratch;
+			list_add(&ooo_op->list_entry, &cqp->ooo_avail);
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&cqp->ooo_list_lock, flags);
+
+	if (!info->scratch)
+		ibdev_dbg(to_ibdev(cqp->dev),
+			  "CQP: DEBUG_FW_OOO out-of-order completion with unknown def_info = 0x%x\n",
+			  def_info);
+}
+
 /**
  * irdma_sc_ccq_get_cqe_info - get ccq's cq entry
  * @ccq: ccq sc struct
@@ -3383,6 +3593,10 @@ void irdma_sc_ccq_arm(struct irdma_sc_cq *ccq)
 int irdma_sc_ccq_get_cqe_info(struct irdma_sc_cq *ccq,
 			      struct irdma_ccq_cqe_info *info)
 {
+	u32 def_info;
+	bool def_cmpl = false;
+	bool pend_cmpl = false;
+	bool ooo_final_cmpl = false;
 	u64 qp_ctx, temp, temp1;
 	__le64 *cqe;
 	struct irdma_sc_cqp *cqp;
@@ -3390,6 +3604,7 @@ int irdma_sc_ccq_get_cqe_info(struct irdma_sc_cq *ccq,
 	u32 error;
 	u8 polarity;
 	int ret_code = 0;
+	unsigned long flags;
 
 	if (ccq->cq_uk.avoid_mem_cflct)
 		cqe = IRDMA_GET_CURRENT_EXTENDED_CQ_ELEM(&ccq->cq_uk);
@@ -3421,6 +3636,25 @@ int irdma_sc_ccq_get_cqe_info(struct irdma_sc_cq *ccq,
 
 	get_64bit_val(cqe, 16, &temp1);
 	info->op_ret_val = (u32)FIELD_GET(IRDMA_CCQ_OPRETVAL, temp1);
+	if (cqp->dev->hw_attrs.uk_attrs.hw_rev >= IRDMA_GEN_3) {
+		def_cmpl = info->maj_err_code == IRDMA_CQPSQ_MAJ_NO_ERROR &&
+			   info->min_err_code == IRDMA_CQPSQ_MIN_DEF_CMPL;
+		def_info = (u32)FIELD_GET(IRDMA_CCQ_DEFINFO, temp1);
+
+		pend_cmpl = info->maj_err_code == IRDMA_CQPSQ_MAJ_NO_ERROR &&
+			    info->min_err_code == IRDMA_CQPSQ_MIN_OOO_CMPL;
+
+		ooo_final_cmpl = (bool)FIELD_GET(IRDMA_OOO_CMPL, temp);
+
+		if (def_cmpl || pend_cmpl || ooo_final_cmpl) {
+			if (ooo_final_cmpl)
+				irdma_sc_process_ooo_cmpl(cqp, info, def_info);
+			else
+				irdma_sc_process_def_cmpl(cqp, info, wqe_idx,
+							  def_info, def_cmpl);
+		}
+	}
+
 	get_64bit_val(cqp->sq_base[wqe_idx].elem, 24, &temp1);
 	info->op_code = (u8)FIELD_GET(IRDMA_CQPSQ_OPCODE, temp1);
 	info->cqp = cqp;
@@ -3437,7 +3671,16 @@ int irdma_sc_ccq_get_cqe_info(struct irdma_sc_cq *ccq,
 
 	dma_wmb(); /* make sure shadow area is updated before moving tail */
 
-	IRDMA_RING_MOVE_TAIL(cqp->sq_ring);
+	spin_lock_irqsave(&cqp->dev->cqp_lock, flags);
+	if (!ooo_final_cmpl)
+		IRDMA_RING_MOVE_TAIL(cqp->sq_ring);
+	spin_unlock_irqrestore(&cqp->dev->cqp_lock, flags);
+
+	/* Do not increment completed_ops counter on pending or deferred
+	 * completions.
+	 */
+	if (pend_cmpl || def_cmpl)
+		return ret_code;
 	atomic64_inc(&cqp->completed_ops);
 
 	return ret_code;
@@ -4123,6 +4366,10 @@ int irdma_sc_get_next_aeqe(struct irdma_sc_aeq *aeq,
 		info->compl_ctx = compl_ctx << 1;
 		ae_src = IRDMA_AE_SOURCE_RSVD;
 		break;
+	case IRDMA_AE_CQP_DEFERRED_COMPLETE:
+		info->def_info = info->wqe_idx;
+		ae_src = IRDMA_AE_SOURCE_RSVD;
+		break;
 	case IRDMA_AE_ROCE_EMPTY_MCG:
 	case IRDMA_AE_ROCE_BAD_MC_IP_ADDR:
 	case IRDMA_AE_ROCE_BAD_MC_QPID:
diff --git a/drivers/infiniband/hw/irdma/defs.h b/drivers/infiniband/hw/irdma/defs.h
index 425bcd17abe9..1239776c6ba3 100644
--- a/drivers/infiniband/hw/irdma/defs.h
+++ b/drivers/infiniband/hw/irdma/defs.h
@@ -367,6 +367,7 @@ enum irdma_cqp_op_type {
 #define IRDMA_AE_LCE_FUNCTION_CATASTROPHIC				0x0701
 #define IRDMA_AE_LCE_CQ_CATASTROPHIC					0x0702
 #define IRDMA_AE_QP_SUSPEND_COMPLETE					0x0900
+#define IRDMA_AE_CQP_DEFERRED_COMPLETE					0x0901
 
 #define FLD_LS_64(dev, val, field)	\
 	(((u64)(val) << (dev)->hw_shifts[field ## _S]) & (dev)->hw_masks[field ## _M])
@@ -464,6 +465,16 @@ enum irdma_cqp_op_type {
 #define IRDMA_CQPHC_SVER GENMASK_ULL(31, 24)
 #define IRDMA_CQPHC_SQBASE GENMASK_ULL(63, 9)
 
+#define IRDMA_CQPHC_TIMESTAMP_OVERRIDE BIT_ULL(5)
+#define IRDMA_CQPHC_TS_SHIFT GENMASK_ULL(12, 8)
+#define IRDMA_CQPHC_EN_FINE_GRAINED_TIMERS BIT_ULL(0)
+
+#define IRDMA_CQPHC_OOISC_BLKSIZE GENMASK_ULL(63, 60)
+#define IRDMA_CQPHC_RRSP_BLKSIZE GENMASK_ULL(59, 56)
+#define IRDMA_CQPHC_Q1_BLKSIZE GENMASK_ULL(55, 52)
+#define IRDMA_CQPHC_XMIT_BLKSIZE GENMASK_ULL(51, 48)
+#define IRDMA_CQPHC_BLKSIZES_VALID BIT_ULL(4)
+
 #define IRDMA_CQPHC_QPCTX GENMASK_ULL(63, 0)
 #define IRDMA_QP_DBSA_HW_SQ_TAIL GENMASK_ULL(14, 0)
 #define IRDMA_CQ_DBSA_CQEIDX GENMASK_ULL(19, 0)
@@ -477,6 +488,8 @@ enum irdma_cqp_op_type {
 
 #define IRDMA_CCQ_OPRETVAL GENMASK_ULL(31, 0)
 
+#define IRDMA_CCQ_DEFINFO GENMASK_ULL(63, 32)
+
 #define IRDMA_CQ_MINERR GENMASK_ULL(15, 0)
 #define IRDMA_CQ_MAJERR GENMASK_ULL(31, 16)
 #define IRDMA_CQ_WQEIDX GENMASK_ULL(46, 32)
@@ -708,6 +721,8 @@ enum irdma_cqp_op_type {
 
 #define IRDMA_CQPSQ_MIN_STAG_INVALID 0x0001
 #define IRDMA_CQPSQ_MIN_SUSPEND_PND 0x0005
+#define IRDMA_CQPSQ_MIN_DEF_CMPL 0x0006
+#define IRDMA_CQPSQ_MIN_OOO_CMPL 0x0007
 
 #define IRDMA_CQPSQ_MAJ_NO_ERROR 0x0000
 #define IRDMA_CQPSQ_MAJ_OBJCACHE_ERROR 0xF000
diff --git a/drivers/infiniband/hw/irdma/hw.c b/drivers/infiniband/hw/irdma/hw.c
index 2aa5f53a46a7..caad1b1f2ee3 100644
--- a/drivers/infiniband/hw/irdma/hw.c
+++ b/drivers/infiniband/hw/irdma/hw.c
@@ -207,6 +207,51 @@ static void irdma_set_flush_fields(struct irdma_sc_qp *qp,
 	}
 }
 
+/**
+ * irdma_complete_cqp_request - perform post-completion cleanup
+ * @cqp: device CQP
+ * @cqp_request: CQP request
+ *
+ * Mark CQP request as done, wake up waiting thread or invoke
+ * callback function and release/free CQP request.
+ */
+static void irdma_complete_cqp_request(struct irdma_cqp *cqp,
+				       struct irdma_cqp_request *cqp_request)
+{
+	if (cqp_request->waiting) {
+		WRITE_ONCE(cqp_request->request_done, true);
+		wake_up(&cqp_request->waitq);
+	} else if (cqp_request->callback_fcn) {
+		cqp_request->callback_fcn(cqp_request);
+	}
+	irdma_put_cqp_request(cqp, cqp_request);
+}
+
+/**
+ * irdma_process_ae_def_cmpl - handle IRDMA_AE_CQP_DEFERRED_COMPLETE event
+ * @rf: RDMA PCI function
+ * @info: AEQ entry info
+ */
+static void irdma_process_ae_def_cmpl(struct irdma_pci_f *rf,
+				      struct irdma_aeqe_info *info)
+{
+	u32 sw_def_info;
+	u64 scratch;
+
+	irdma_cqp_ce_handler(rf, &rf->ccq.sc_cq);
+
+	irdma_sc_cqp_def_cmpl_ae_handler(&rf->sc_dev, info, true,
+					 &scratch, &sw_def_info);
+	while (scratch) {
+		struct irdma_cqp_request *cqp_request =
+			(struct irdma_cqp_request *)(uintptr_t)scratch;
+
+		irdma_complete_cqp_request(&rf->cqp, cqp_request);
+		irdma_sc_cqp_def_cmpl_ae_handler(&rf->sc_dev, info, false,
+						 &scratch, &sw_def_info);
+	}
+}
+
 /**
  * irdma_process_aeq - handle aeq events
  * @rf: RDMA PCI function
@@ -269,7 +314,8 @@ static void irdma_process_aeq(struct irdma_pci_f *rf)
 			spin_unlock_irqrestore(&iwqp->lock, flags);
 			ctx_info = &iwqp->ctx_info;
 		} else {
-			if (info->ae_id != IRDMA_AE_CQ_OPERATION_ERROR)
+			if (info->ae_id != IRDMA_AE_CQ_OPERATION_ERROR &&
+			    info->ae_id != IRDMA_AE_CQP_DEFERRED_COMPLETE)
 				continue;
 		}
 
@@ -364,6 +410,12 @@ static void irdma_process_aeq(struct irdma_pci_f *rf)
 			}
 			irdma_cq_rem_ref(&iwcq->ibcq);
 			break;
+		case IRDMA_AE_CQP_DEFERRED_COMPLETE:
+			/* Remove completed CQP requests from pending list
+			 * and notify about those CQP ops completion.
+			 */
+			irdma_process_ae_def_cmpl(rf, info);
+			break;
 		case IRDMA_AE_RESET_NOT_SENT:
 		case IRDMA_AE_LLP_DOUBT_REACHABILITY:
 		case IRDMA_AE_RESOURCE_EXHAUSTION:
@@ -600,6 +652,8 @@ static void irdma_destroy_cqp(struct irdma_pci_f *rf)
 	dma_free_coherent(dev->hw->device, cqp->sq.size, cqp->sq.va,
 			  cqp->sq.pa);
 	cqp->sq.va = NULL;
+	kfree(cqp->oop_op_array);
+	cqp->oop_op_array = NULL;
 	kfree(cqp->scratch_array);
 	cqp->scratch_array = NULL;
 	kfree(cqp->cqp_requests);
@@ -943,6 +997,13 @@ static int irdma_create_cqp(struct irdma_pci_f *rf)
 		goto err_scratch;
 	}
 
+	cqp->oop_op_array = kcalloc(sqsize, sizeof(*cqp->oop_op_array),
+				    GFP_KERNEL);
+	if (!cqp->oop_op_array) {
+		status = -ENOMEM;
+		goto err_oop;
+	}
+	cqp_init_info.ooo_op_array = cqp->oop_op_array;
 	dev->cqp = &cqp->sc_cqp;
 	dev->cqp->dev = dev;
 	cqp->sq.size = ALIGN(sizeof(struct irdma_cqp_sq_wqe) * sqsize,
@@ -979,6 +1040,10 @@ static int irdma_create_cqp(struct irdma_pci_f *rf)
 	case IRDMA_GEN_2:
 		cqp_init_info.hw_maj_ver = IRDMA_CQPHC_HW_MAJVER_GEN_2;
 		break;
+	case IRDMA_GEN_3:
+		cqp_init_info.hw_maj_ver = IRDMA_CQPHC_HW_MAJVER_GEN_3;
+		cqp_init_info.ts_override = 1;
+		break;
 	}
 	status = irdma_sc_cqp_init(dev->cqp, &cqp_init_info);
 	if (status) {
@@ -1013,6 +1078,9 @@ static int irdma_create_cqp(struct irdma_pci_f *rf)
 			  cqp->sq.va, cqp->sq.pa);
 	cqp->sq.va = NULL;
 err_sq:
+	kfree(cqp->oop_op_array);
+	cqp->oop_op_array = NULL;
+err_oop:
 	kfree(cqp->scratch_array);
 	cqp->scratch_array = NULL;
 err_scratch:
@@ -2104,15 +2172,16 @@ void irdma_cqp_ce_handler(struct irdma_pci_f *rf, struct irdma_sc_cq *cq)
 			cqp_request->compl_info.op_ret_val = info.op_ret_val;
 			cqp_request->compl_info.error = info.error;
 
-			if (cqp_request->waiting) {
-				WRITE_ONCE(cqp_request->request_done, true);
-				wake_up(&cqp_request->waitq);
-				irdma_put_cqp_request(&rf->cqp, cqp_request);
-			} else {
-				if (cqp_request->callback_fcn)
-					cqp_request->callback_fcn(cqp_request);
-				irdma_put_cqp_request(&rf->cqp, cqp_request);
-			}
+			/*
+			 * If this is deferred or pending completion, then mark
+			 * CQP request as pending to not block the CQ, but don't
+			 * release CQP request, as it is still on the OOO list.
+			 */
+			if (info.pending)
+				cqp_request->pending = true;
+			else
+				irdma_complete_cqp_request(&rf->cqp,
+							   cqp_request);
 		}
 
 		cqe_count++;
diff --git a/drivers/infiniband/hw/irdma/main.h b/drivers/infiniband/hw/irdma/main.h
index efc7c13e29df..7414e0ec6306 100644
--- a/drivers/infiniband/hw/irdma/main.h
+++ b/drivers/infiniband/hw/irdma/main.h
@@ -168,6 +168,7 @@ struct irdma_cqp_request {
 	bool request_done; /* READ/WRITE_ONCE macros operate on it */
 	bool waiting:1;
 	bool dynamic:1;
+	bool pending:1;
 };
 
 struct irdma_cqp {
@@ -180,6 +181,7 @@ struct irdma_cqp {
 	struct irdma_dma_mem host_ctx;
 	u64 *scratch_array;
 	struct irdma_cqp_request *cqp_requests;
+	struct irdma_ooo_cqp_op *oop_op_array;
 	struct list_head cqp_avail_reqs;
 	struct list_head cqp_pending_reqs;
 };
diff --git a/drivers/infiniband/hw/irdma/protos.h b/drivers/infiniband/hw/irdma/protos.h
index c0c9441885d3..324cfbf21764 100644
--- a/drivers/infiniband/hw/irdma/protos.h
+++ b/drivers/infiniband/hw/irdma/protos.h
@@ -10,6 +10,7 @@
 #define ALL_TC2PFC		0xff
 #define CQP_COMPL_WAIT_TIME_MS	10
 #define CQP_TIMEOUT_THRESHOLD	500
+#define CQP_DEF_CMPL_TIMEOUT_THRESHOLD	2500
 
 /* init operations */
 int irdma_sc_dev_init(enum irdma_vers ver, struct irdma_sc_dev *dev,
diff --git a/drivers/infiniband/hw/irdma/type.h b/drivers/infiniband/hw/irdma/type.h
index bb241a4ff5f9..e779ad8dcba5 100644
--- a/drivers/infiniband/hw/irdma/type.h
+++ b/drivers/infiniband/hw/irdma/type.h
@@ -262,12 +262,22 @@ struct irdma_cqp_init_info {
 	__le64 *host_ctx;
 	u64 *scratch_array;
 	u32 sq_size;
+	struct irdma_ooo_cqp_op *ooo_op_array;
+	u32 pe_en_vf_cnt;
 	u16 hw_maj_ver;
 	u16 hw_min_ver;
 	u8 struct_ver;
 	u8 hmc_profile;
 	u8 ena_vf_count;
 	u8 ceqs_per_vf;
+	u8 ooisc_blksize;
+	u8 rrsp_blksize;
+	u8 q1_blksize;
+	u8 xmit_blksize;
+	u8 ts_override;
+	u8 ts_shift;
+	u8 en_fine_grained_timers;
+	u8 blksizes_valid;
 	bool en_datacenter_tcp:1;
 	bool disable_packed:1;
 	bool rocev2_rto_policy:1;
@@ -392,7 +402,21 @@ struct irdma_cqp_quanta {
 	__le64 elem[IRDMA_CQP_WQE_SIZE];
 };
 
+struct irdma_ooo_cqp_op {
+	struct list_head list_entry;
+	u64 scratch;
+	u32 def_info;
+	u32 sw_def_info;
+	u32 wqe_idx;
+	bool deferred:1;
+};
+
 struct irdma_sc_cqp {
+	spinlock_t ooo_list_lock; /* protects list of pending completions */
+	struct list_head ooo_avail;
+	struct list_head ooo_pnd;
+	u32 last_def_cmpl_ticket;
+	u32 sw_def_cmpl_ticket;
 	u32 size;
 	u64 sq_pa;
 	u64 host_ctx_pa;
@@ -408,8 +432,10 @@ struct irdma_sc_cqp {
 	u64 *scratch_array;
 	u64 requested_ops;
 	atomic64_t completed_ops;
+	struct irdma_ooo_cqp_op *ooo_op_array;
 	u32 cqp_id;
 	u32 sq_size;
+	u32 pe_en_vf_cnt;
 	u32 hw_sq_size;
 	u16 hw_maj_ver;
 	u16 hw_min_ver;
@@ -419,6 +445,14 @@ struct irdma_sc_cqp {
 	u8 ena_vf_count;
 	u8 timeout_count;
 	u8 ceqs_per_vf;
+	u8 ooisc_blksize;
+	u8 rrsp_blksize;
+	u8 q1_blksize;
+	u8 xmit_blksize;
+	u8 ts_override;
+	u8 ts_shift;
+	u8 en_fine_grained_timers;
+	u8 blksizes_valid;
 	bool en_datacenter_tcp:1;
 	bool disable_packed:1;
 	bool rocev2_rto_policy:1;
@@ -723,7 +757,8 @@ struct irdma_ccq_cqe_info {
 	u16 maj_err_code;
 	u16 min_err_code;
 	u8 op_code;
-	bool error;
+	bool error:1;
+	bool pending:1;
 };
 
 struct irdma_dcb_app_info {
@@ -998,6 +1033,7 @@ struct irdma_qp_host_ctx_info {
 struct irdma_aeqe_info {
 	u64 compl_ctx;
 	u32 qp_cq_id;
+	u32 def_info;	/* only valid for DEF_CMPL */
 	u16 ae_id;
 	u16 wqe_idx;
 	u8 tcp_state;
@@ -1242,6 +1278,11 @@ void irdma_sc_pd_init(struct irdma_sc_dev *dev, struct irdma_sc_pd *pd, u32 pd_i
 void irdma_cfg_aeq(struct irdma_sc_dev *dev, u32 idx, bool enable);
 void irdma_check_cqp_progress(struct irdma_cqp_timeout *cqp_timeout,
 			      struct irdma_sc_dev *dev);
+void irdma_sc_cqp_def_cmpl_ae_handler(struct irdma_sc_dev *dev,
+				      struct irdma_aeqe_info *info,
+				      bool first, u64 *scratch,
+				      u32 *sw_def_info);
+u64 irdma_sc_cqp_cleanup_handler(struct irdma_sc_dev *dev);
 int irdma_sc_cqp_create(struct irdma_sc_cqp *cqp, u16 *maj_err, u16 *min_err);
 int irdma_sc_cqp_destroy(struct irdma_sc_cqp *cqp);
 int irdma_sc_cqp_init(struct irdma_sc_cqp *cqp,
diff --git a/drivers/infiniband/hw/irdma/utils.c b/drivers/infiniband/hw/irdma/utils.c
index b510ef747399..d4c51b56ed22 100644
--- a/drivers/infiniband/hw/irdma/utils.c
+++ b/drivers/infiniband/hw/irdma/utils.c
@@ -481,6 +481,7 @@ void irdma_free_cqp_request(struct irdma_cqp *cqp,
 		WRITE_ONCE(cqp_request->request_done, false);
 		cqp_request->callback_fcn = NULL;
 		cqp_request->waiting = false;
+		cqp_request->pending = false;
 
 		spin_lock_irqsave(&cqp->req_lock, flags);
 		list_add_tail(&cqp_request->list, &cqp->cqp_avail_reqs);
@@ -520,6 +521,22 @@ irdma_free_pending_cqp_request(struct irdma_cqp *cqp,
 	irdma_put_cqp_request(cqp, cqp_request);
 }
 
+/**
+ * irdma_cleanup_deferred_cqp_ops - clean-up cqp with no completions
+ * @dev: sc_dev
+ * @cqp: cqp
+ */
+static void irdma_cleanup_deferred_cqp_ops(struct irdma_sc_dev *dev,
+					   struct irdma_cqp *cqp)
+{
+	u64 scratch;
+
+	/* process all CQP requests with deferred/pending completions */
+	while ((scratch = irdma_sc_cqp_cleanup_handler(dev)))
+		irdma_free_pending_cqp_request(cqp, (struct irdma_cqp_request *)
+						    (uintptr_t)scratch);
+}
+
 /**
  * irdma_cleanup_pending_cqp_op - clean-up cqp with no
  * completions
@@ -533,6 +550,8 @@ void irdma_cleanup_pending_cqp_op(struct irdma_pci_f *rf)
 	struct cqp_cmds_info *pcmdinfo = NULL;
 	u32 i, pending_work, wqe_idx;
 
+	if (dev->hw_attrs.uk_attrs.hw_rev >= IRDMA_GEN_3)
+		irdma_cleanup_deferred_cqp_ops(dev, cqp);
 	pending_work = IRDMA_RING_USED_QUANTA(cqp->sc_cqp.sq_ring);
 	wqe_idx = IRDMA_RING_CURRENT_TAIL(cqp->sc_cqp.sq_ring);
 	for (i = 0; i < pending_work; i++) {
@@ -552,6 +571,26 @@ void irdma_cleanup_pending_cqp_op(struct irdma_pci_f *rf)
 	}
 }
 
+static int irdma_get_timeout_threshold(struct irdma_sc_dev *dev)
+{
+	u16 time_s = dev->vc_caps.cqp_timeout_s;
+
+	if (!time_s)
+		return CQP_TIMEOUT_THRESHOLD;
+
+	return time_s * 1000 / dev->hw_attrs.max_cqp_compl_wait_time_ms;
+}
+
+static int irdma_get_def_timeout_threshold(struct irdma_sc_dev *dev)
+{
+	u16 time_s = dev->vc_caps.cqp_def_timeout_s;
+
+	if (!time_s)
+		return CQP_DEF_CMPL_TIMEOUT_THRESHOLD;
+
+	return time_s * 1000 / dev->hw_attrs.max_cqp_compl_wait_time_ms;
+}
+
 /**
  * irdma_wait_event - wait for completion
  * @rf: RDMA PCI function
@@ -561,6 +600,7 @@ static int irdma_wait_event(struct irdma_pci_f *rf,
 			    struct irdma_cqp_request *cqp_request)
 {
 	struct irdma_cqp_timeout cqp_timeout = {};
+	int timeout_threshold = irdma_get_timeout_threshold(&rf->sc_dev);
 	bool cqp_error = false;
 	int err_code = 0;
 
@@ -572,9 +612,17 @@ static int irdma_wait_event(struct irdma_pci_f *rf,
 				       msecs_to_jiffies(CQP_COMPL_WAIT_TIME_MS)))
 			break;
 
+		if (cqp_request->pending)
+			/* There was a deferred or pending completion
+			 * received for this CQP request, so we need
+			 * to wait longer than usual.
+			 */
+			timeout_threshold =
+				irdma_get_def_timeout_threshold(&rf->sc_dev);
+
 		irdma_check_cqp_progress(&cqp_timeout, &rf->sc_dev);
 
-		if (cqp_timeout.count < CQP_TIMEOUT_THRESHOLD)
+		if (cqp_timeout.count < timeout_threshold)
 			continue;
 
 		if (!rf->reset) {
-- 
2.42.0


