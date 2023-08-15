Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508E677D6A8
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Aug 2023 01:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234151AbjHOX3x (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Aug 2023 19:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240684AbjHOX3s (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Aug 2023 19:29:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16822199A
        for <linux-rdma@vger.kernel.org>; Tue, 15 Aug 2023 16:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692142187; x=1723678187;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SXBp5mwAnUSxHvwJZoGsUtuEu/MDM8SVQ6nkaP1fZeg=;
  b=cYegKHltquhZR6Z5ABssvoXQOQTbKE+WTFeYtY2eTtcEZra4xDMIcaRZ
   yuYUA9LBJotzZOkVqU5uq2mSKOk96tgyy+c+9MYSN7Pn5q3XAFbVB4Q0P
   KjZujuaHH/BCWZKBjzYJ2Z8TNdyFdTjPXxvtopO+rpluj/RGNK8cXa4e1
   HsC5tXLeuDXRdSY1pRiowuHaAryJxtl+vigyz9lYbwIshsv7IAkMCpPYx
   ern5jw42mvMo2NEmbcRDFuZSroKXeTNu1XPIK9GxeChnlGalB9Jy+x3hf
   eNM2CnVy4mrzCQScJZwqhKomj6NmTyWRTml6RmP4GE6z+S60/hVJXDp7f
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="352727372"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="352727372"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 16:29:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="824022851"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="824022851"
Received: from ssaleem-mobl1.amr.corp.intel.com ([10.93.66.152])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 16:29:46 -0700
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     jgg@nvidia.com, leon@kernel.org, linux-rdma@vger.kernel.org
Cc:     Shiraz Saleem <shiraz.saleem@intel.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH for-next] RDMA/irdma: Drop unused kernel push code
Date:   Tue, 15 Aug 2023 18:29:31 -0500
Message-Id: <20230815232931.1690-1-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The driver has code blocks for kernel push WQEs but does not
map the doorbell page rendering this mode non functional [1]

Remove code associated with this feature from the kernel fast
path as there is currently no plan of record to support this.

This also address a sparse issue reported by lkp.

drivers/infiniband/hw/irdma/uk.c:285:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected bool [usertype] push_wqe:1 @@     got restricted __le32 [usertype] *push_db @@
drivers/infiniband/hw/irdma/uk.c:285:24: sparse:     expected bool [usertype] push_wqe:1
drivers/infiniband/hw/irdma/uk.c:285:24: sparse:     got restricted __le32 [usertype] *push_db
drivers/infiniband/hw/irdma/uk.c:386:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected bool [usertype] push_wqe:1 @@     got restricted __le32 [usertype] *push_db @@

[1] https://lore.kernel.org/linux-rdma/20230815051809.GB22185@unreal/T/#t

Fixes: 272bba19d631 ("RDMA: Remove unnecessary ternary operators")
Fixes: 551c46edc769 ("RDMA/irdma: Add user/kernel shared libraries")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202308110251.BV6BcwUR-lkp@intel.com/
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/hw/irdma/ctrl.c |  12 +---
 drivers/infiniband/hw/irdma/type.h |   1 -
 drivers/infiniband/hw/irdma/uk.c   | 115 ++++++-------------------------------
 drivers/infiniband/hw/irdma/user.h |   8 ---
 4 files changed, 19 insertions(+), 117 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/ctrl.c b/drivers/infiniband/hw/irdma/ctrl.c
index b90abdc85057..b1fdddd2fa1a 100644
--- a/drivers/infiniband/hw/irdma/ctrl.c
+++ b/drivers/infiniband/hw/irdma/ctrl.c
@@ -1301,7 +1301,6 @@ int irdma_sc_mr_fast_register(struct irdma_sc_qp *qp,
 
 	sq_info.wr_id = info->wr_id;
 	sq_info.signaled = info->signaled;
-	sq_info.push_wqe = info->push_wqe;
 
 	wqe = irdma_qp_get_next_send_wqe(&qp->qp_uk, &wqe_idx,
 					 IRDMA_QP_WQE_MIN_QUANTA, 0, &sq_info);
@@ -1335,7 +1334,6 @@ int irdma_sc_mr_fast_register(struct irdma_sc_qp *qp,
 	      FIELD_PREP(IRDMAQPSQ_HPAGESIZE, page_size) |
 	      FIELD_PREP(IRDMAQPSQ_STAGRIGHTS, info->access_rights) |
 	      FIELD_PREP(IRDMAQPSQ_VABASEDTO, info->addr_type) |
-	      FIELD_PREP(IRDMAQPSQ_PUSHWQE, (sq_info.push_wqe ? 1 : 0)) |
 	      FIELD_PREP(IRDMAQPSQ_READFENCE, info->read_fence) |
 	      FIELD_PREP(IRDMAQPSQ_LOCALFENCE, info->local_fence) |
 	      FIELD_PREP(IRDMAQPSQ_SIGCOMPL, info->signaled) |
@@ -1346,13 +1344,9 @@ int irdma_sc_mr_fast_register(struct irdma_sc_qp *qp,
 
 	print_hex_dump_debug("WQE: FAST_REG WQE", DUMP_PREFIX_OFFSET, 16, 8,
 			     wqe, IRDMA_QP_WQE_MIN_SIZE, false);
-	if (sq_info.push_wqe) {
-		irdma_qp_push_wqe(&qp->qp_uk, wqe, IRDMA_QP_WQE_MIN_QUANTA,
-				  wqe_idx, post_sq);
-	} else {
-		if (post_sq)
-			irdma_uk_qp_post_wr(&qp->qp_uk);
-	}
+
+	if (post_sq)
+		irdma_uk_qp_post_wr(&qp->qp_uk);
 
 	return 0;
 }
diff --git a/drivers/infiniband/hw/irdma/type.h b/drivers/infiniband/hw/irdma/type.h
index 5ee68604e59f..b49a98c208bf 100644
--- a/drivers/infiniband/hw/irdma/type.h
+++ b/drivers/infiniband/hw/irdma/type.h
@@ -1015,7 +1015,6 @@ struct irdma_fast_reg_stag_info {
 	bool local_fence:1;
 	bool read_fence:1;
 	bool signaled:1;
-	bool push_wqe:1;
 	bool use_hmc_fcn_index:1;
 	u8 hmc_fcn_index;
 	bool use_pf_rid:1;
diff --git a/drivers/infiniband/hw/irdma/uk.c b/drivers/infiniband/hw/irdma/uk.c
index 6f9238c4fe20..e803c30d88d9 100644
--- a/drivers/infiniband/hw/irdma/uk.c
+++ b/drivers/infiniband/hw/irdma/uk.c
@@ -127,10 +127,7 @@ void irdma_uk_qp_post_wr(struct irdma_qp_uk *qp)
 	hw_sq_tail = (u32)FIELD_GET(IRDMA_QP_DBSA_HW_SQ_TAIL, temp);
 	sw_sq_head = IRDMA_RING_CURRENT_HEAD(qp->sq_ring);
 	if (sw_sq_head != qp->initial_ring.head) {
-		if (qp->push_dropped) {
-			writel(qp->qp_id, qp->wqe_alloc_db);
-			qp->push_dropped = false;
-		} else if (sw_sq_head != hw_sq_tail) {
+		if (sw_sq_head != hw_sq_tail) {
 			if (sw_sq_head > qp->initial_ring.head) {
 				if (hw_sq_tail >= qp->initial_ring.head &&
 				    hw_sq_tail < sw_sq_head)
@@ -147,38 +144,6 @@ void irdma_uk_qp_post_wr(struct irdma_qp_uk *qp)
 }
 
 /**
- * irdma_qp_ring_push_db -  ring qp doorbell
- * @qp: hw qp ptr
- * @wqe_idx: wqe index
- */
-static void irdma_qp_ring_push_db(struct irdma_qp_uk *qp, u32 wqe_idx)
-{
-	set_32bit_val(qp->push_db, 0,
-		      FIELD_PREP(IRDMA_WQEALLOC_WQE_DESC_INDEX, wqe_idx >> 3) | qp->qp_id);
-	qp->initial_ring.head = qp->sq_ring.head;
-	qp->push_mode = true;
-	qp->push_dropped = false;
-}
-
-void irdma_qp_push_wqe(struct irdma_qp_uk *qp, __le64 *wqe, u16 quanta,
-		       u32 wqe_idx, bool post_sq)
-{
-	__le64 *push;
-
-	if (IRDMA_RING_CURRENT_HEAD(qp->initial_ring) !=
-		    IRDMA_RING_CURRENT_TAIL(qp->sq_ring) &&
-	    !qp->push_mode) {
-		if (post_sq)
-			irdma_uk_qp_post_wr(qp);
-	} else {
-		push = (__le64 *)((uintptr_t)qp->push_wqe +
-				  (wqe_idx & 0x7) * 0x20);
-		memcpy(push, wqe, quanta * IRDMA_QP_WQE_MIN_SIZE);
-		irdma_qp_ring_push_db(qp, wqe_idx);
-	}
-}
-
-/**
  * irdma_qp_get_next_send_wqe - pad with NOP if needed, return where next WR should go
  * @qp: hw qp ptr
  * @wqe_idx: return wqe index
@@ -214,9 +179,6 @@ __le64 *irdma_qp_get_next_send_wqe(struct irdma_qp_uk *qp, u32 *wqe_idx,
 			irdma_nop_1(qp);
 			IRDMA_RING_MOVE_HEAD_NOCHECK(qp->sq_ring);
 		}
-		if (qp->push_db && info->push_wqe)
-			irdma_qp_push_wqe(qp, qp->sq_base[nop_wqe_idx].elem,
-					  avail_quanta, nop_wqe_idx, true);
 	}
 
 	*wqe_idx = IRDMA_RING_CURRENT_HEAD(qp->sq_ring);
@@ -282,8 +244,6 @@ int irdma_uk_rdma_write(struct irdma_qp_uk *qp, struct irdma_post_sq_info *info,
 	bool read_fence = false;
 	u16 quanta;
 
-	info->push_wqe = qp->push_db;
-
 	op_info = &info->op.rdma_write;
 	if (op_info->num_lo_sges > qp->max_sq_frag_cnt)
 		return -EINVAL;
@@ -344,7 +304,6 @@ int irdma_uk_rdma_write(struct irdma_qp_uk *qp, struct irdma_post_sq_info *info,
 	      FIELD_PREP(IRDMAQPSQ_IMMDATAFLAG, info->imm_data_valid) |
 	      FIELD_PREP(IRDMAQPSQ_REPORTRTT, info->report_rtt) |
 	      FIELD_PREP(IRDMAQPSQ_ADDFRAGCNT, addl_frag_cnt) |
-	      FIELD_PREP(IRDMAQPSQ_PUSHWQE, info->push_wqe) |
 	      FIELD_PREP(IRDMAQPSQ_READFENCE, read_fence) |
 	      FIELD_PREP(IRDMAQPSQ_LOCALFENCE, info->local_fence) |
 	      FIELD_PREP(IRDMAQPSQ_SIGCOMPL, info->signaled) |
@@ -353,12 +312,9 @@ int irdma_uk_rdma_write(struct irdma_qp_uk *qp, struct irdma_post_sq_info *info,
 	dma_wmb(); /* make sure WQE is populated before valid bit is set */
 
 	set_64bit_val(wqe, 24, hdr);
-	if (info->push_wqe) {
-		irdma_qp_push_wqe(qp, wqe, quanta, wqe_idx, post_sq);
-	} else {
-		if (post_sq)
-			irdma_uk_qp_post_wr(qp);
-	}
+
+	if (post_sq)
+		irdma_uk_qp_post_wr(qp);
 
 	return 0;
 }
@@ -383,8 +339,6 @@ int irdma_uk_rdma_read(struct irdma_qp_uk *qp, struct irdma_post_sq_info *info,
 	u16 quanta;
 	u64 hdr;
 
-	info->push_wqe = qp->push_db;
-
 	op_info = &info->op.rdma_read;
 	if (qp->max_sq_frag_cnt < op_info->num_lo_sges)
 		return -EINVAL;
@@ -431,7 +385,6 @@ int irdma_uk_rdma_read(struct irdma_qp_uk *qp, struct irdma_post_sq_info *info,
 	      FIELD_PREP(IRDMAQPSQ_ADDFRAGCNT, addl_frag_cnt) |
 	      FIELD_PREP(IRDMAQPSQ_OPCODE,
 			 (inv_stag ? IRDMAQP_OP_RDMA_READ_LOC_INV : IRDMAQP_OP_RDMA_READ)) |
-	      FIELD_PREP(IRDMAQPSQ_PUSHWQE, info->push_wqe) |
 	      FIELD_PREP(IRDMAQPSQ_READFENCE, info->read_fence) |
 	      FIELD_PREP(IRDMAQPSQ_LOCALFENCE, local_fence) |
 	      FIELD_PREP(IRDMAQPSQ_SIGCOMPL, info->signaled) |
@@ -440,12 +393,9 @@ int irdma_uk_rdma_read(struct irdma_qp_uk *qp, struct irdma_post_sq_info *info,
 	dma_wmb(); /* make sure WQE is populated before valid bit is set */
 
 	set_64bit_val(wqe, 24, hdr);
-	if (info->push_wqe) {
-		irdma_qp_push_wqe(qp, wqe, quanta, wqe_idx, post_sq);
-	} else {
-		if (post_sq)
-			irdma_uk_qp_post_wr(qp);
-	}
+
+	if (post_sq)
+		irdma_uk_qp_post_wr(qp);
 
 	return 0;
 }
@@ -468,8 +418,6 @@ int irdma_uk_send(struct irdma_qp_uk *qp, struct irdma_post_sq_info *info,
 	bool read_fence = false;
 	u16 quanta;
 
-	info->push_wqe = qp->push_db;
-
 	op_info = &info->op.send;
 	if (qp->max_sq_frag_cnt < op_info->num_sges)
 		return -EINVAL;
@@ -530,7 +478,6 @@ int irdma_uk_send(struct irdma_qp_uk *qp, struct irdma_post_sq_info *info,
 	      FIELD_PREP(IRDMAQPSQ_REPORTRTT, (info->report_rtt ? 1 : 0)) |
 	      FIELD_PREP(IRDMAQPSQ_OPCODE, info->op_type) |
 	      FIELD_PREP(IRDMAQPSQ_ADDFRAGCNT, addl_frag_cnt) |
-	      FIELD_PREP(IRDMAQPSQ_PUSHWQE, info->push_wqe) |
 	      FIELD_PREP(IRDMAQPSQ_READFENCE, read_fence) |
 	      FIELD_PREP(IRDMAQPSQ_LOCALFENCE, info->local_fence) |
 	      FIELD_PREP(IRDMAQPSQ_SIGCOMPL, info->signaled) |
@@ -541,12 +488,9 @@ int irdma_uk_send(struct irdma_qp_uk *qp, struct irdma_post_sq_info *info,
 	dma_wmb(); /* make sure WQE is populated before valid bit is set */
 
 	set_64bit_val(wqe, 24, hdr);
-	if (info->push_wqe) {
-		irdma_qp_push_wqe(qp, wqe, quanta, wqe_idx, post_sq);
-	} else {
-		if (post_sq)
-			irdma_uk_qp_post_wr(qp);
-	}
+
+	if (post_sq)
+		irdma_uk_qp_post_wr(qp);
 
 	return 0;
 }
@@ -720,7 +664,6 @@ int irdma_uk_inline_rdma_write(struct irdma_qp_uk *qp,
 	u32 i, total_size = 0;
 	u16 quanta;
 
-	info->push_wqe = qp->push_db;
 	op_info = &info->op.rdma_write;
 
 	if (unlikely(qp->max_sq_frag_cnt < op_info->num_lo_sges))
@@ -750,7 +693,6 @@ int irdma_uk_inline_rdma_write(struct irdma_qp_uk *qp,
 	      FIELD_PREP(IRDMAQPSQ_REPORTRTT, info->report_rtt ? 1 : 0) |
 	      FIELD_PREP(IRDMAQPSQ_INLINEDATAFLAG, 1) |
 	      FIELD_PREP(IRDMAQPSQ_IMMDATAFLAG, info->imm_data_valid ? 1 : 0) |
-	      FIELD_PREP(IRDMAQPSQ_PUSHWQE, info->push_wqe ? 1 : 0) |
 	      FIELD_PREP(IRDMAQPSQ_READFENCE, read_fence) |
 	      FIELD_PREP(IRDMAQPSQ_LOCALFENCE, info->local_fence) |
 	      FIELD_PREP(IRDMAQPSQ_SIGCOMPL, info->signaled) |
@@ -767,12 +709,8 @@ int irdma_uk_inline_rdma_write(struct irdma_qp_uk *qp,
 
 	set_64bit_val(wqe, 24, hdr);
 
-	if (info->push_wqe) {
-		irdma_qp_push_wqe(qp, wqe, quanta, wqe_idx, post_sq);
-	} else {
-		if (post_sq)
-			irdma_uk_qp_post_wr(qp);
-	}
+	if (post_sq)
+		irdma_uk_qp_post_wr(qp);
 
 	return 0;
 }
@@ -794,7 +732,6 @@ int irdma_uk_inline_send(struct irdma_qp_uk *qp,
 	u32 i, total_size = 0;
 	u16 quanta;
 
-	info->push_wqe = qp->push_db;
 	op_info = &info->op.send;
 
 	if (unlikely(qp->max_sq_frag_cnt < op_info->num_sges))
@@ -827,7 +764,6 @@ int irdma_uk_inline_send(struct irdma_qp_uk *qp,
 			 (info->imm_data_valid ? 1 : 0)) |
 	      FIELD_PREP(IRDMAQPSQ_REPORTRTT, (info->report_rtt ? 1 : 0)) |
 	      FIELD_PREP(IRDMAQPSQ_INLINEDATAFLAG, 1) |
-	      FIELD_PREP(IRDMAQPSQ_PUSHWQE, info->push_wqe) |
 	      FIELD_PREP(IRDMAQPSQ_READFENCE, read_fence) |
 	      FIELD_PREP(IRDMAQPSQ_LOCALFENCE, info->local_fence) |
 	      FIELD_PREP(IRDMAQPSQ_SIGCOMPL, info->signaled) |
@@ -845,12 +781,8 @@ int irdma_uk_inline_send(struct irdma_qp_uk *qp,
 
 	set_64bit_val(wqe, 24, hdr);
 
-	if (info->push_wqe) {
-		irdma_qp_push_wqe(qp, wqe, quanta, wqe_idx, post_sq);
-	} else {
-		if (post_sq)
-			irdma_uk_qp_post_wr(qp);
-	}
+	if (post_sq)
+		irdma_uk_qp_post_wr(qp);
 
 	return 0;
 }
@@ -872,7 +804,6 @@ int irdma_uk_stag_local_invalidate(struct irdma_qp_uk *qp,
 	bool local_fence = false;
 	struct ib_sge sge = {};
 
-	info->push_wqe = qp->push_db;
 	op_info = &info->op.inv_local_stag;
 	local_fence = info->local_fence;
 
@@ -889,7 +820,6 @@ int irdma_uk_stag_local_invalidate(struct irdma_qp_uk *qp,
 	set_64bit_val(wqe, 16, 0);
 
 	hdr = FIELD_PREP(IRDMAQPSQ_OPCODE, IRDMA_OP_TYPE_INV_STAG) |
-	      FIELD_PREP(IRDMAQPSQ_PUSHWQE, info->push_wqe) |
 	      FIELD_PREP(IRDMAQPSQ_READFENCE, info->read_fence) |
 	      FIELD_PREP(IRDMAQPSQ_LOCALFENCE, local_fence) |
 	      FIELD_PREP(IRDMAQPSQ_SIGCOMPL, info->signaled) |
@@ -899,13 +829,8 @@ int irdma_uk_stag_local_invalidate(struct irdma_qp_uk *qp,
 
 	set_64bit_val(wqe, 24, hdr);
 
-	if (info->push_wqe) {
-		irdma_qp_push_wqe(qp, wqe, IRDMA_QP_WQE_MIN_QUANTA, wqe_idx,
-				  post_sq);
-	} else {
-		if (post_sq)
-			irdma_uk_qp_post_wr(qp);
-	}
+	if (post_sq)
+		irdma_uk_qp_post_wr(qp);
 
 	return 0;
 }
@@ -1124,7 +1049,6 @@ int irdma_uk_cq_poll_cmpl(struct irdma_cq_uk *cq,
 
 	info->q_type = (u8)FIELD_GET(IRDMA_CQ_SQ, qword3);
 	info->error = (bool)FIELD_GET(IRDMA_CQ_ERROR, qword3);
-	info->push_dropped = (bool)FIELD_GET(IRDMACQ_PSHDROP, qword3);
 	info->ipv4 = (bool)FIELD_GET(IRDMACQ_IPV4, qword3);
 	if (info->error) {
 		info->major_err = FIELD_GET(IRDMA_CQ_MAJERR, qword3);
@@ -1213,11 +1137,6 @@ int irdma_uk_cq_poll_cmpl(struct irdma_cq_uk *cq,
 				return irdma_uk_cq_poll_cmpl(cq, info);
 			}
 		}
-		/*cease posting push mode on push drop*/
-		if (info->push_dropped) {
-			qp->push_mode = false;
-			qp->push_dropped = true;
-		}
 		if (info->comp_status != IRDMA_COMPL_STATUS_FLUSHED) {
 			info->wr_id = qp->sq_wrtrk_array[wqe_idx].wrid;
 			if (!info->comp_status)
@@ -1521,7 +1440,6 @@ int irdma_uk_qp_init(struct irdma_qp_uk *qp, struct irdma_qp_uk_init_info *info)
 	qp->wqe_alloc_db = info->wqe_alloc_db;
 	qp->qp_id = info->qp_id;
 	qp->sq_size = info->sq_size;
-	qp->push_mode = false;
 	qp->max_sq_frag_cnt = info->max_sq_frag_cnt;
 	sq_ring_size = qp->sq_size << info->sq_shift;
 	IRDMA_RING_INIT(qp->sq_ring, sq_ring_size);
@@ -1616,7 +1534,6 @@ int irdma_nop(struct irdma_qp_uk *qp, u64 wr_id, bool signaled, bool post_sq)
 	u32 wqe_idx;
 	struct irdma_post_sq_info info = {};
 
-	info.push_wqe = false;
 	info.wr_id = wr_id;
 	wqe = irdma_qp_get_next_send_wqe(qp, &wqe_idx, IRDMA_QP_WQE_MIN_QUANTA,
 					 0, &info);
diff --git a/drivers/infiniband/hw/irdma/user.h b/drivers/infiniband/hw/irdma/user.h
index dd145ec72a91..36feca57b274 100644
--- a/drivers/infiniband/hw/irdma/user.h
+++ b/drivers/infiniband/hw/irdma/user.h
@@ -216,7 +216,6 @@ struct irdma_post_sq_info {
 	bool local_fence:1;
 	bool inline_data:1;
 	bool imm_data_valid:1;
-	bool push_wqe:1;
 	bool report_rtt:1;
 	bool udp_hdr:1;
 	bool defer_flag:1;
@@ -248,7 +247,6 @@ struct irdma_cq_poll_info {
 	u8 op_type;
 	u8 q_type;
 	bool stag_invalid_set:1; /* or L_R_Key set */
-	bool push_dropped:1;
 	bool error:1;
 	bool solicited_event:1;
 	bool ipv4:1;
@@ -321,8 +319,6 @@ struct irdma_qp_uk {
 	struct irdma_sq_uk_wr_trk_info *sq_wrtrk_array;
 	u64 *rq_wrid_array;
 	__le64 *shadow_area;
-	__le32 *push_db;
-	__le64 *push_wqe;
 	struct irdma_ring sq_ring;
 	struct irdma_ring rq_ring;
 	struct irdma_ring initial_ring;
@@ -342,8 +338,6 @@ struct irdma_qp_uk {
 	u8 rq_wqe_size;
 	u8 rq_wqe_size_multiplier;
 	bool deferred_flag:1;
-	bool push_mode:1; /* whether the last post wqe was pushed */
-	bool push_dropped:1;
 	bool first_sq_wq:1;
 	bool sq_flush_complete:1; /* Indicates flush was seen and SQ was empty after the flush */
 	bool rq_flush_complete:1; /* Indicates flush was seen and RQ was empty after the flush */
@@ -415,7 +409,5 @@ int irdma_get_sqdepth(struct irdma_uk_attrs *uk_attrs, u32 sq_size, u8 shift,
 		      u32 *wqdepth);
 int irdma_get_rqdepth(struct irdma_uk_attrs *uk_attrs, u32 rq_size, u8 shift,
 		      u32 *wqdepth);
-void irdma_qp_push_wqe(struct irdma_qp_uk *qp, __le64 *wqe, u16 quanta,
-		       u32 wqe_idx, bool post_sq);
 void irdma_clr_wqes(struct irdma_qp_uk *qp, u32 qp_wqe_idx);
 #endif /* IRDMA_USER_H */
-- 
1.8.3.1

