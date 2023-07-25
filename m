Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB204761DC8
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jul 2023 17:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbjGYPzu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Jul 2023 11:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232373AbjGYPzt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Jul 2023 11:55:49 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134C62126
        for <linux-rdma@vger.kernel.org>; Tue, 25 Jul 2023 08:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690300538; x=1721836538;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Z4nFY+/AtE7kIIKwJVEhCvY0M1IYGtUfGbZAmfeNJis=;
  b=XsNb6GQ0hl0w96TwwVb53jwU1nt/HYNsgVeXMoW/vv+t9T2Oan6T0pay
   r9UgrtZTzQYuB0BHEq/HSHM+hU0Nz3df9Sz/gWWdKdYB0jXmHu4CZnHng
   n7CYBSBhxEtKcleavQwmV9i+zMwXQq7gUjW8VjeirsYBEoLO+pqtaynMU
   FIBR2wydB9sa6xRjdzDFxNttpmJmISAg6FFoJRa+fNYnLJcwBvvpmiL7u
   MgM2ckUJBkndebBPTu558YrH9uAXihoHwkbnaF1IAGGyrPPvIZ0cRhzkX
   E619HL+4s4ZHft4avGMNJySeptSJ5jj2gjAqI0zDzX6os70vC3i+pt+NM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="431574800"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="431574800"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 08:55:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="972743877"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="972743877"
Received: from ssaleem-mobl1.amr.corp.intel.com ([10.93.66.152])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 08:55:36 -0700
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     jgg@nvidia.com, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org,
        Sindhu Devale <sindhu.devale@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH for-next 1/2] RDMA/irdma: Allow accurate reporting on QP max send/recv WR
Date:   Tue, 25 Jul 2023 10:55:24 -0500
Message-Id: <20230725155525.1081-2-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230725155525.1081-1-shiraz.saleem@intel.com>
References: <20230725155525.1081-1-shiraz.saleem@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Sindhu Devale <sindhu.devale@intel.com>

Currently the attribute cap.max_send_wr and cap.max_recv_wr
sent from user-space during create QP are the provider computed
SQ/RQ depth as opposed to raw values passed from application.
This inhibits computation of an accurate value for max_send_wr
and max_recv_wr for this QP in the kernel which matches the value
returned in user create QP. Also these capabilities needs to be
reported from the driver in query QP.

Add support by extending the ABI to allow the raw cap.max_send_wr and
cap.max_recv_wr to be passed from user-space, while keeping compatibility
for the older scheme.

The internal HW depth and shift needed for the WQs needs to be computed
now for both kernel and user-mode QPs. Add new helpers to assist with this:
irdma_uk_calc_depth_shift_sq, irdma_uk_calc_depth_shift_rq and
irdma_uk_calc_depth_shift_wq.

Consolidate all the user mode QP setup into a new function
irdma_setup_umode_qp which keeps it with its counterpart
irdma_setup_kmode_qp.

Signed-off-by: Youvaraj Sagar <youvaraj.sagar@intel.com>
Signed-off-by: Sindhu Devale <sindhu.devale@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/hw/irdma/uk.c    |  89 +++++++++++++++---
 drivers/infiniband/hw/irdma/user.h  |  10 ++
 drivers/infiniband/hw/irdma/verbs.c | 182 ++++++++++++++++++++++--------------
 drivers/infiniband/hw/irdma/verbs.h |   3 +-
 include/uapi/rdma/irdma-abi.h       |   6 ++
 5 files changed, 203 insertions(+), 87 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/uk.c b/drivers/infiniband/hw/irdma/uk.c
index dd428d915c17..a45112a41f59 100644
--- a/drivers/infiniband/hw/irdma/uk.c
+++ b/drivers/infiniband/hw/irdma/uk.c
@@ -1415,6 +1415,78 @@ static void irdma_setup_connection_wqes(struct irdma_qp_uk *qp,
 }
 
 /**
+ * irdma_uk_calc_shift_wq - calculate WQE shift for both SQ and RQ
+ * @ukinfo: qp initialization info
+ * @sq_shift: Returns shift of SQ
+ * @rq_shift: Returns shift of RQ
+ */
+void irdma_uk_calc_shift_wq(struct irdma_qp_uk_init_info *ukinfo, u8 *sq_shift,
+			    u8 *rq_shift)
+{
+	bool imm_support = ukinfo->uk_attrs->hw_rev >= IRDMA_GEN_2 ? true : false;
+
+	irdma_get_wqe_shift(ukinfo->uk_attrs,
+			    imm_support ? ukinfo->max_sq_frag_cnt + 1 :
+					  ukinfo->max_sq_frag_cnt,
+			    ukinfo->max_inline_data, sq_shift);
+
+	irdma_get_wqe_shift(ukinfo->uk_attrs, ukinfo->max_rq_frag_cnt, 0,
+			    rq_shift);
+
+	if (ukinfo->uk_attrs->hw_rev == IRDMA_GEN_1) {
+		if (ukinfo->abi_ver > 4)
+			*rq_shift = IRDMA_MAX_RQ_WQE_SHIFT_GEN1;
+	}
+}
+
+/**
+ * irdma_uk_calc_depth_shift_sq - calculate depth and shift for SQ size.
+ * @ukinfo: qp initialization info
+ * @sq_depth: Returns depth of SQ
+ * @sq_shift: Returns shift of SQ
+ */
+int irdma_uk_calc_depth_shift_sq(struct irdma_qp_uk_init_info *ukinfo,
+				 u32 *sq_depth, u8 *sq_shift)
+{
+	bool imm_support = ukinfo->uk_attrs->hw_rev >= IRDMA_GEN_2 ? true : false;
+	int status;
+
+	irdma_get_wqe_shift(ukinfo->uk_attrs,
+			    imm_support ? ukinfo->max_sq_frag_cnt + 1 :
+			    ukinfo->max_sq_frag_cnt,
+			    ukinfo->max_inline_data, sq_shift);
+	status = irdma_get_sqdepth(ukinfo->uk_attrs, ukinfo->sq_size,
+				   *sq_shift, sq_depth);
+
+	return status;
+}
+
+/**
+ * irdma_uk_calc_depth_shift_rq - calculate depth and shift for RQ size.
+ * @ukinfo: qp initialization info
+ * @rq_depth: Returns depth of RQ
+ * @rq_shift: Returns shift of RQ
+ */
+int irdma_uk_calc_depth_shift_rq(struct irdma_qp_uk_init_info *ukinfo,
+				 u32 *rq_depth, u8 *rq_shift)
+{
+	int status;
+
+	irdma_get_wqe_shift(ukinfo->uk_attrs, ukinfo->max_rq_frag_cnt, 0,
+			    rq_shift);
+
+	if (ukinfo->uk_attrs->hw_rev == IRDMA_GEN_1) {
+		if (ukinfo->abi_ver > 4)
+			*rq_shift = IRDMA_MAX_RQ_WQE_SHIFT_GEN1;
+	}
+
+	status = irdma_get_rqdepth(ukinfo->uk_attrs, ukinfo->rq_size,
+				   *rq_shift, rq_depth);
+
+	return status;
+}
+
+/**
  * irdma_uk_qp_init - initialize shared qp
  * @qp: hw qp (user and kernel)
  * @info: qp initialization info
@@ -1428,23 +1500,12 @@ int irdma_uk_qp_init(struct irdma_qp_uk *qp, struct irdma_qp_uk_init_info *info)
 {
 	int ret_code = 0;
 	u32 sq_ring_size;
-	u8 sqshift, rqshift;
 
 	qp->uk_attrs = info->uk_attrs;
 	if (info->max_sq_frag_cnt > qp->uk_attrs->max_hw_wq_frags ||
 	    info->max_rq_frag_cnt > qp->uk_attrs->max_hw_wq_frags)
 		return -EINVAL;
 
-	irdma_get_wqe_shift(qp->uk_attrs, info->max_rq_frag_cnt, 0, &rqshift);
-	if (qp->uk_attrs->hw_rev == IRDMA_GEN_1) {
-		irdma_get_wqe_shift(qp->uk_attrs, info->max_sq_frag_cnt,
-				    info->max_inline_data, &sqshift);
-		if (info->abi_ver > 4)
-			rqshift = IRDMA_MAX_RQ_WQE_SHIFT_GEN1;
-	} else {
-		irdma_get_wqe_shift(qp->uk_attrs, info->max_sq_frag_cnt + 1,
-				    info->max_inline_data, &sqshift);
-	}
 	qp->qp_caps = info->qp_caps;
 	qp->sq_base = info->sq;
 	qp->rq_base = info->rq;
@@ -1458,7 +1519,7 @@ int irdma_uk_qp_init(struct irdma_qp_uk *qp, struct irdma_qp_uk_init_info *info)
 	qp->sq_size = info->sq_size;
 	qp->push_mode = false;
 	qp->max_sq_frag_cnt = info->max_sq_frag_cnt;
-	sq_ring_size = qp->sq_size << sqshift;
+	sq_ring_size = qp->sq_size << info->sq_shift;
 	IRDMA_RING_INIT(qp->sq_ring, sq_ring_size);
 	IRDMA_RING_INIT(qp->initial_ring, sq_ring_size);
 	if (info->first_sq_wq) {
@@ -1473,9 +1534,9 @@ int irdma_uk_qp_init(struct irdma_qp_uk *qp, struct irdma_qp_uk_init_info *info)
 	qp->rq_size = info->rq_size;
 	qp->max_rq_frag_cnt = info->max_rq_frag_cnt;
 	qp->max_inline_data = info->max_inline_data;
-	qp->rq_wqe_size = rqshift;
+	qp->rq_wqe_size = info->rq_shift;
 	IRDMA_RING_INIT(qp->rq_ring, qp->rq_size);
-	qp->rq_wqe_size_multiplier = 1 << rqshift;
+	qp->rq_wqe_size_multiplier = 1 << info->rq_shift;
 	if (qp->uk_attrs->hw_rev == IRDMA_GEN_1)
 		qp->wqe_ops = iw_wqe_uk_ops_gen_1;
 	else
diff --git a/drivers/infiniband/hw/irdma/user.h b/drivers/infiniband/hw/irdma/user.h
index d0cdf609f5e0..1e0e1a71dbad 100644
--- a/drivers/infiniband/hw/irdma/user.h
+++ b/drivers/infiniband/hw/irdma/user.h
@@ -295,6 +295,12 @@ void irdma_uk_cq_init(struct irdma_cq_uk *cq,
 		      struct irdma_cq_uk_init_info *info);
 int irdma_uk_qp_init(struct irdma_qp_uk *qp,
 		     struct irdma_qp_uk_init_info *info);
+void irdma_uk_calc_shift_wq(struct irdma_qp_uk_init_info *ukinfo, u8 *sq_shift,
+			    u8 *rq_shift);
+int irdma_uk_calc_depth_shift_sq(struct irdma_qp_uk_init_info *ukinfo,
+				 u32 *sq_depth, u8 *sq_shift);
+int irdma_uk_calc_depth_shift_rq(struct irdma_qp_uk_init_info *ukinfo,
+				 u32 *rq_depth, u8 *rq_shift);
 struct irdma_sq_uk_wr_trk_info {
 	u64 wrid;
 	u32 wr_len;
@@ -374,8 +380,12 @@ struct irdma_qp_uk_init_info {
 	u32 max_sq_frag_cnt;
 	u32 max_rq_frag_cnt;
 	u32 max_inline_data;
+	u32 sq_depth;
+	u32 rq_depth;
 	u8 first_sq_wq;
 	u8 type;
+	u8 sq_shift;
+	u8 rq_shift;
 	int abi_ver;
 	bool legacy_mode;
 };
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index a7b82aea4d08..7efe3587690f 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -277,7 +277,7 @@ static int irdma_alloc_ucontext(struct ib_ucontext *uctx,
 	struct irdma_alloc_ucontext_req req = {};
 	struct irdma_alloc_ucontext_resp uresp = {};
 	struct irdma_ucontext *ucontext = to_ucontext(uctx);
-	struct irdma_uk_attrs *uk_attrs;
+	struct irdma_uk_attrs *uk_attrs = &iwdev->rf->sc_dev.hw_attrs.uk_attrs;
 
 	if (udata->inlen < IRDMA_ALLOC_UCTX_MIN_REQ_LEN ||
 	    udata->outlen < IRDMA_ALLOC_UCTX_MIN_RESP_LEN)
@@ -292,7 +292,9 @@ static int irdma_alloc_ucontext(struct ib_ucontext *uctx,
 	ucontext->iwdev = iwdev;
 	ucontext->abi_ver = req.userspace_ver;
 
-	uk_attrs = &iwdev->rf->sc_dev.hw_attrs.uk_attrs;
+	if (req.comp_mask & IRDMA_ALLOC_UCTX_USE_RAW_ATTR)
+		ucontext->use_raw_attrs = true;
+
 	/* GEN_1 legacy support with libi40iw */
 	if (udata->outlen == IRDMA_ALLOC_UCTX_MIN_RESP_LEN) {
 		if (uk_attrs->hw_rev != IRDMA_GEN_1)
@@ -327,6 +329,7 @@ static int irdma_alloc_ucontext(struct ib_ucontext *uctx,
 		uresp.max_hw_cq_size = uk_attrs->max_hw_cq_size;
 		uresp.min_hw_cq_size = uk_attrs->min_hw_cq_size;
 		uresp.hw_rev = uk_attrs->hw_rev;
+		uresp.comp_mask |= IRDMA_ALLOC_UCTX_USE_RAW_ATTR;
 		if (ib_copy_to_udata(udata, &uresp,
 				     min(sizeof(uresp), udata->outlen))) {
 			rdma_user_mmap_entry_remove(ucontext->db_mmap_entry);
@@ -567,6 +570,86 @@ static void irdma_setup_virt_qp(struct irdma_device *iwdev,
 }
 
 /**
+ * irdma_setup_umode_qp - setup sq and rq size in user mode qp
+ * @iwdev: iwarp device
+ * @iwqp: qp ptr (user or kernel)
+ * @info: initialize info to return
+ * @init_attr: Initial QP create attributes
+ */
+static int irdma_setup_umode_qp(struct ib_udata *udata,
+				struct irdma_device *iwdev,
+				struct irdma_qp *iwqp,
+				struct irdma_qp_init_info *info,
+				struct ib_qp_init_attr *init_attr)
+{
+	struct irdma_ucontext *ucontext = rdma_udata_to_drv_context(udata,
+				struct irdma_ucontext, ibucontext);
+	struct irdma_qp_uk_init_info *ukinfo = &info->qp_uk_init_info;
+	struct irdma_create_qp_req req;
+	unsigned long flags;
+	int ret;
+
+	ret = ib_copy_from_udata(&req, udata,
+				 min(sizeof(req), udata->inlen));
+	if (ret) {
+		ibdev_dbg(&iwdev->ibdev, "VERBS: ib_copy_from_data fail\n");
+		return ret;
+	}
+
+	iwqp->ctx_info.qp_compl_ctx = req.user_compl_ctx;
+	iwqp->user_mode = 1;
+	if (req.user_wqe_bufs) {
+		info->qp_uk_init_info.legacy_mode = ucontext->legacy_mode;
+		spin_lock_irqsave(&ucontext->qp_reg_mem_list_lock, flags);
+		iwqp->iwpbl = irdma_get_pbl((unsigned long)req.user_wqe_bufs,
+					    &ucontext->qp_reg_mem_list);
+		spin_unlock_irqrestore(&ucontext->qp_reg_mem_list_lock, flags);
+
+		if (!iwqp->iwpbl) {
+			ret = -ENODATA;
+			ibdev_dbg(&iwdev->ibdev, "VERBS: no pbl info\n");
+			return ret;
+		}
+	}
+
+	if (!ucontext->use_raw_attrs) {
+		/**
+		 * Maintain backward compat with older ABI which passes sq and
+		 * rq depth in quanta in cap.max_send_wr and cap.max_recv_wr.
+		 * There is no way to compute the correct value of
+		 * iwqp->max_send_wr/max_recv_wr in the kernel.
+		 */
+		iwqp->max_send_wr = init_attr->cap.max_send_wr;
+		iwqp->max_recv_wr = init_attr->cap.max_recv_wr;
+		ukinfo->sq_size = init_attr->cap.max_send_wr;
+		ukinfo->rq_size = init_attr->cap.max_recv_wr;
+		irdma_uk_calc_shift_wq(ukinfo, &ukinfo->sq_shift,
+				       &ukinfo->rq_shift);
+	} else {
+		ret = irdma_uk_calc_depth_shift_sq(ukinfo, &ukinfo->sq_depth,
+						   &ukinfo->sq_shift);
+		if (ret)
+			return ret;
+
+		ret = irdma_uk_calc_depth_shift_rq(ukinfo, &ukinfo->rq_depth,
+						   &ukinfo->rq_shift);
+		if (ret)
+			return ret;
+
+		iwqp->max_send_wr =
+			(ukinfo->sq_depth - IRDMA_SQ_RSVD) >> ukinfo->sq_shift;
+		iwqp->max_recv_wr =
+			(ukinfo->rq_depth - IRDMA_RQ_RSVD) >> ukinfo->rq_shift;
+		ukinfo->sq_size = ukinfo->sq_depth >> ukinfo->sq_shift;
+		ukinfo->rq_size = ukinfo->rq_depth >> ukinfo->rq_shift;
+	}
+
+	irdma_setup_virt_qp(iwdev, iwqp, info);
+
+	return 0;
+}
+
+/**
  * irdma_setup_kmode_qp - setup initialization for kernel mode qp
  * @iwdev: iwarp device
  * @iwqp: qp ptr (user or kernel)
@@ -579,40 +662,28 @@ static int irdma_setup_kmode_qp(struct irdma_device *iwdev,
 				struct ib_qp_init_attr *init_attr)
 {
 	struct irdma_dma_mem *mem = &iwqp->kqp.dma_mem;
-	u32 sqdepth, rqdepth;
-	u8 sqshift, rqshift;
 	u32 size;
 	int status;
 	struct irdma_qp_uk_init_info *ukinfo = &info->qp_uk_init_info;
-	struct irdma_uk_attrs *uk_attrs = &iwdev->rf->sc_dev.hw_attrs.uk_attrs;
 
-	irdma_get_wqe_shift(uk_attrs,
-		uk_attrs->hw_rev >= IRDMA_GEN_2 ? ukinfo->max_sq_frag_cnt + 1 :
-						  ukinfo->max_sq_frag_cnt,
-		ukinfo->max_inline_data, &sqshift);
-	status = irdma_get_sqdepth(uk_attrs, ukinfo->sq_size, sqshift,
-				   &sqdepth);
+	status = irdma_uk_calc_depth_shift_sq(ukinfo, &ukinfo->sq_depth,
+					      &ukinfo->sq_shift);
 	if (status)
 		return status;
 
-	if (uk_attrs->hw_rev == IRDMA_GEN_1)
-		rqshift = IRDMA_MAX_RQ_WQE_SHIFT_GEN1;
-	else
-		irdma_get_wqe_shift(uk_attrs, ukinfo->max_rq_frag_cnt, 0,
-				    &rqshift);
-
-	status = irdma_get_rqdepth(uk_attrs, ukinfo->rq_size, rqshift,
-				   &rqdepth);
+	status = irdma_uk_calc_depth_shift_rq(ukinfo, &ukinfo->rq_depth,
+					      &ukinfo->rq_shift);
 	if (status)
 		return status;
 
 	iwqp->kqp.sq_wrid_mem =
-		kcalloc(sqdepth, sizeof(*iwqp->kqp.sq_wrid_mem), GFP_KERNEL);
+		kcalloc(ukinfo->sq_depth, sizeof(*iwqp->kqp.sq_wrid_mem), GFP_KERNEL);
 	if (!iwqp->kqp.sq_wrid_mem)
 		return -ENOMEM;
 
 	iwqp->kqp.rq_wrid_mem =
-		kcalloc(rqdepth, sizeof(*iwqp->kqp.rq_wrid_mem), GFP_KERNEL);
+		kcalloc(ukinfo->rq_depth, sizeof(*iwqp->kqp.rq_wrid_mem), GFP_KERNEL);
+
 	if (!iwqp->kqp.rq_wrid_mem) {
 		kfree(iwqp->kqp.sq_wrid_mem);
 		iwqp->kqp.sq_wrid_mem = NULL;
@@ -622,7 +693,7 @@ static int irdma_setup_kmode_qp(struct irdma_device *iwdev,
 	ukinfo->sq_wrtrk_array = iwqp->kqp.sq_wrid_mem;
 	ukinfo->rq_wrid_array = iwqp->kqp.rq_wrid_mem;
 
-	size = (sqdepth + rqdepth) * IRDMA_QP_WQE_MIN_SIZE;
+	size = (ukinfo->sq_depth + ukinfo->rq_depth) * IRDMA_QP_WQE_MIN_SIZE;
 	size += (IRDMA_SHADOW_AREA_SIZE << 3);
 
 	mem->size = ALIGN(size, 256);
@@ -638,16 +709,19 @@ static int irdma_setup_kmode_qp(struct irdma_device *iwdev,
 
 	ukinfo->sq = mem->va;
 	info->sq_pa = mem->pa;
-	ukinfo->rq = &ukinfo->sq[sqdepth];
-	info->rq_pa = info->sq_pa + (sqdepth * IRDMA_QP_WQE_MIN_SIZE);
-	ukinfo->shadow_area = ukinfo->rq[rqdepth].elem;
-	info->shadow_area_pa = info->rq_pa + (rqdepth * IRDMA_QP_WQE_MIN_SIZE);
-	ukinfo->sq_size = sqdepth >> sqshift;
-	ukinfo->rq_size = rqdepth >> rqshift;
+	ukinfo->rq = &ukinfo->sq[ukinfo->sq_depth];
+	info->rq_pa = info->sq_pa + (ukinfo->sq_depth * IRDMA_QP_WQE_MIN_SIZE);
+	ukinfo->shadow_area = ukinfo->rq[ukinfo->rq_depth].elem;
+	info->shadow_area_pa =
+		info->rq_pa + (ukinfo->rq_depth * IRDMA_QP_WQE_MIN_SIZE);
+	ukinfo->sq_size = ukinfo->sq_depth >> ukinfo->sq_shift;
+	ukinfo->rq_size = ukinfo->rq_depth >> ukinfo->rq_shift;
 	ukinfo->qp_id = iwqp->ibqp.qp_num;
 
-	init_attr->cap.max_send_wr = (sqdepth - IRDMA_SQ_RSVD) >> sqshift;
-	init_attr->cap.max_recv_wr = (rqdepth - IRDMA_RQ_RSVD) >> rqshift;
+	iwqp->max_send_wr = (ukinfo->sq_depth - IRDMA_SQ_RSVD) >> ukinfo->sq_shift;
+	iwqp->max_recv_wr = (ukinfo->rq_depth - IRDMA_RQ_RSVD) >> ukinfo->rq_shift;
+	init_attr->cap.max_send_wr = iwqp->max_send_wr;
+	init_attr->cap.max_recv_wr = iwqp->max_recv_wr;
 
 	return 0;
 }
@@ -803,18 +877,14 @@ static int irdma_create_qp(struct ib_qp *ibqp,
 	struct irdma_device *iwdev = to_iwdev(ibpd->device);
 	struct irdma_pci_f *rf = iwdev->rf;
 	struct irdma_qp *iwqp = to_iwqp(ibqp);
-	struct irdma_create_qp_req req = {};
 	struct irdma_create_qp_resp uresp = {};
 	u32 qp_num = 0;
 	int err_code;
-	int sq_size;
-	int rq_size;
 	struct irdma_sc_qp *qp;
 	struct irdma_sc_dev *dev = &rf->sc_dev;
 	struct irdma_uk_attrs *uk_attrs = &dev->hw_attrs.uk_attrs;
 	struct irdma_qp_init_info init_info = {};
 	struct irdma_qp_host_ctx_info *ctx_info;
-	unsigned long flags;
 
 	err_code = irdma_validate_qp_attrs(init_attr, iwdev);
 	if (err_code)
@@ -824,13 +894,10 @@ static int irdma_create_qp(struct ib_qp *ibqp,
 		      udata->outlen < IRDMA_CREATE_QP_MIN_RESP_LEN))
 		return -EINVAL;
 
-	sq_size = init_attr->cap.max_send_wr;
-	rq_size = init_attr->cap.max_recv_wr;
-
 	init_info.vsi = &iwdev->vsi;
 	init_info.qp_uk_init_info.uk_attrs = uk_attrs;
-	init_info.qp_uk_init_info.sq_size = sq_size;
-	init_info.qp_uk_init_info.rq_size = rq_size;
+	init_info.qp_uk_init_info.sq_size = init_attr->cap.max_send_wr;
+	init_info.qp_uk_init_info.rq_size = init_attr->cap.max_recv_wr;
 	init_info.qp_uk_init_info.max_sq_frag_cnt = init_attr->cap.max_send_sge;
 	init_info.qp_uk_init_info.max_rq_frag_cnt = init_attr->cap.max_recv_sge;
 	init_info.qp_uk_init_info.max_inline_data = init_attr->cap.max_inline_data;
@@ -880,36 +947,9 @@ static int irdma_create_qp(struct ib_qp *ibqp,
 	init_waitqueue_head(&iwqp->mod_qp_waitq);
 
 	if (udata) {
-		err_code = ib_copy_from_udata(&req, udata,
-					      min(sizeof(req), udata->inlen));
-		if (err_code) {
-			ibdev_dbg(&iwdev->ibdev,
-				  "VERBS: ib_copy_from_data fail\n");
-			goto error;
-		}
-
-		iwqp->ctx_info.qp_compl_ctx = req.user_compl_ctx;
-		iwqp->user_mode = 1;
-		if (req.user_wqe_bufs) {
-			struct irdma_ucontext *ucontext =
-				rdma_udata_to_drv_context(udata,
-							  struct irdma_ucontext,
-							  ibucontext);
-
-			init_info.qp_uk_init_info.legacy_mode = ucontext->legacy_mode;
-			spin_lock_irqsave(&ucontext->qp_reg_mem_list_lock, flags);
-			iwqp->iwpbl = irdma_get_pbl((unsigned long)req.user_wqe_bufs,
-						    &ucontext->qp_reg_mem_list);
-			spin_unlock_irqrestore(&ucontext->qp_reg_mem_list_lock, flags);
-
-			if (!iwqp->iwpbl) {
-				err_code = -ENODATA;
-				ibdev_dbg(&iwdev->ibdev, "VERBS: no pbl info\n");
-				goto error;
-			}
-		}
 		init_info.qp_uk_init_info.abi_ver = iwpd->sc_pd.abi_ver;
-		irdma_setup_virt_qp(iwdev, iwqp, &init_info);
+		err_code = irdma_setup_umode_qp(udata, iwdev, iwqp, &init_info,
+						init_attr);
 	} else {
 		INIT_DELAYED_WORK(&iwqp->dwork_flush, irdma_flush_worker);
 		init_info.qp_uk_init_info.abi_ver = IRDMA_ABI_VER;
@@ -964,8 +1004,6 @@ static int irdma_create_qp(struct ib_qp *ibqp,
 	spin_lock_init(&iwqp->sc_qp.pfpdu.lock);
 	iwqp->sig_all = (init_attr->sq_sig_type == IB_SIGNAL_ALL_WR) ? 1 : 0;
 	rf->qp_table[qp_num] = iwqp;
-	iwqp->max_send_wr = sq_size;
-	iwqp->max_recv_wr = rq_size;
 
 	if (rdma_protocol_roce(&iwdev->ibdev, 1)) {
 		if (dev->ws_add(&iwdev->vsi, 0)) {
@@ -986,8 +1024,8 @@ static int irdma_create_qp(struct ib_qp *ibqp,
 			if (rdma_protocol_iwarp(&iwdev->ibdev, 1))
 				uresp.lsmm = 1;
 		}
-		uresp.actual_sq_size = sq_size;
-		uresp.actual_rq_size = rq_size;
+		uresp.actual_sq_size = init_info.qp_uk_init_info.sq_size;
+		uresp.actual_rq_size = init_info.qp_uk_init_info.rq_size;
 		uresp.qp_id = qp_num;
 		uresp.qp_caps = qp->qp_uk.qp_caps;
 
diff --git a/drivers/infiniband/hw/irdma/verbs.h b/drivers/infiniband/hw/irdma/verbs.h
index a536e9fa85eb..a74238199ae8 100644
--- a/drivers/infiniband/hw/irdma/verbs.h
+++ b/drivers/infiniband/hw/irdma/verbs.h
@@ -18,7 +18,8 @@ struct irdma_ucontext {
 	struct list_head qp_reg_mem_list;
 	spinlock_t qp_reg_mem_list_lock; /* protect QP memory list */
 	int abi_ver;
-	bool legacy_mode;
+	bool legacy_mode:1;
+	bool use_raw_attrs:1;
 };
 
 struct irdma_pd {
diff --git a/include/uapi/rdma/irdma-abi.h b/include/uapi/rdma/irdma-abi.h
index a7085e092d34..3a0cde4dcf33 100644
--- a/include/uapi/rdma/irdma-abi.h
+++ b/include/uapi/rdma/irdma-abi.h
@@ -22,10 +22,15 @@ enum irdma_memreg_type {
 	IRDMA_MEMREG_TYPE_CQ   = 2,
 };
 
+enum {
+	IRDMA_ALLOC_UCTX_USE_RAW_ATTR = 1 << 0,
+};
+
 struct irdma_alloc_ucontext_req {
 	__u32 rsvd32;
 	__u8 userspace_ver;
 	__u8 rsvd8[3];
+	__aligned_u64 comp_mask;
 };
 
 struct irdma_alloc_ucontext_resp {
@@ -46,6 +51,7 @@ struct irdma_alloc_ucontext_resp {
 	__u16 max_hw_sq_chunk;
 	__u8 hw_rev;
 	__u8 rsvd2;
+	__aligned_u64 comp_mask;
 };
 
 struct irdma_alloc_pd_resp {
-- 
1.8.3.1

