Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 598902C35D5
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Nov 2020 01:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbgKYA4q (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Nov 2020 19:56:46 -0500
Received: from mga07.intel.com ([134.134.136.100]:24261 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727255AbgKYA4q (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 24 Nov 2020 19:56:46 -0500
IronPort-SDR: B22FtJJI4vo8G9emyU5lxP/iY4JdXgamrga6yaKYtXW3sAXuHEmVRrsBXudYnJsyO6p9mE0cwu
 GWKZaq+m7O9Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9815"; a="236179428"
X-IronPort-AV: E=Sophos;i="5.78,367,1599548400"; 
   d="scan'208";a="236179428"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 16:56:45 -0800
IronPort-SDR: NF2dFyJz9iEj4k90qXN78hX1IQgIlZm3V1F+cdiYwVmzAQqNjuKw74YNk8YWVRIDomFU7HvnhT
 BI2tRQJJNsRA==
X-IronPort-AV: E=Sophos;i="5.78,367,1599548400"; 
   d="scan'208";a="370647826"
Received: from ssaleem-mobl.amr.corp.intel.com ([10.212.134.32])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 16:56:45 -0800
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     dledford@redhat.com, jgg@nvidia.com
Cc:     linux-rdma@vger.kernel.org, stable@kernel.org,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH v2 2/2] RDMA/i40iw: Remove push code from i40iw
Date:   Tue, 24 Nov 2020 18:56:17 -0600
Message-Id: <20201125005616.1800-3-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201125005616.1800-1-shiraz.saleem@intel.com>
References: <20201125005616.1800-1-shiraz.saleem@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The push feature does not work as expected in x722 and
has historically been disabled in the driver.

Purge all remaining code related to the push feature in i40iw.

Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/hw/i40iw/i40iw.h        |    1 -
 drivers/infiniband/hw/i40iw/i40iw_ctrl.c   |   52 +----------------
 drivers/infiniband/hw/i40iw/i40iw_d.h      |   35 ++++-------
 drivers/infiniband/hw/i40iw/i40iw_status.h |    1 -
 drivers/infiniband/hw/i40iw/i40iw_type.h   |   18 ------
 drivers/infiniband/hw/i40iw/i40iw_uk.c     |   41 +------------
 drivers/infiniband/hw/i40iw/i40iw_user.h   |    8 ---
 drivers/infiniband/hw/i40iw/i40iw_verbs.c  |   86 +---------------------------
 8 files changed, 18 insertions(+), 224 deletions(-)

diff --git a/drivers/infiniband/hw/i40iw/i40iw.h b/drivers/infiniband/hw/i40iw/i40iw.h
index 832b80d..6a79502 100644
--- a/drivers/infiniband/hw/i40iw/i40iw.h
+++ b/drivers/infiniband/hw/i40iw/i40iw.h
@@ -274,7 +274,6 @@ struct i40iw_device {
 	u8 max_sge;
 	u8 iw_status;
 	u8 send_term_ok;
-	bool push_mode;		/* Initialized from parameter passed to driver */
 
 	/* x710 specific */
 	struct mutex pbl_mutex;
diff --git a/drivers/infiniband/hw/i40iw/i40iw_ctrl.c b/drivers/infiniband/hw/i40iw/i40iw_ctrl.c
index 86d3f8a..1fafd41 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_ctrl.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_ctrl.c
@@ -820,46 +820,6 @@ static enum i40iw_status_code i40iw_sc_poll_for_cqp_op_done(
 }
 
 /**
- * i40iw_sc_manage_push_page - Handle push page
- * @cqp: struct for cqp hw
- * @info: push page info
- * @scratch: u64 saved to be used during cqp completion
- * @post_sq: flag for cqp db to ring
- */
-static enum i40iw_status_code i40iw_sc_manage_push_page(
-				struct i40iw_sc_cqp *cqp,
-				struct i40iw_cqp_manage_push_page_info *info,
-				u64 scratch,
-				bool post_sq)
-{
-	u64 *wqe;
-	u64 header;
-
-	if (info->push_idx >= I40IW_MAX_PUSH_PAGE_COUNT)
-		return I40IW_ERR_INVALID_PUSH_PAGE_INDEX;
-
-	wqe = i40iw_sc_cqp_get_next_send_wqe(cqp, scratch);
-	if (!wqe)
-		return I40IW_ERR_RING_FULL;
-
-	set_64bit_val(wqe, 16, info->qs_handle);
-
-	header = LS_64(info->push_idx, I40IW_CQPSQ_MPP_PPIDX) |
-		 LS_64(I40IW_CQP_OP_MANAGE_PUSH_PAGES, I40IW_CQPSQ_OPCODE) |
-		 LS_64(cqp->polarity, I40IW_CQPSQ_WQEVALID) |
-		 LS_64(info->free_page, I40IW_CQPSQ_MPP_FREE_PAGE);
-
-	i40iw_insert_wqe_hdr(wqe, header);
-
-	i40iw_debug_buf(cqp->dev, I40IW_DEBUG_WQE, "MANAGE_PUSH_PAGES WQE",
-			wqe, I40IW_CQP_WQE_SIZE * 8);
-
-	if (post_sq)
-		i40iw_sc_cqp_post_sq(cqp);
-	return 0;
-}
-
-/**
  * i40iw_sc_manage_hmc_pm_func_table - manage of function table
  * @cqp: struct for cqp hw
  * @scratch: u64 saved to be used during cqp completion
@@ -2859,9 +2819,7 @@ static enum i40iw_status_code i40iw_sc_qp_setctx(
 	      LS_64(qp->rcv_tph_en, I40IWQPC_RCVTPHEN) |
 	      LS_64(qp->xmit_tph_en, I40IWQPC_XMITTPHEN) |
 	      LS_64(qp->rq_tph_en, I40IWQPC_RQTPHEN) |
-	      LS_64(qp->sq_tph_en, I40IWQPC_SQTPHEN) |
-	      LS_64(info->push_idx, I40IWQPC_PPIDX) |
-	      LS_64(info->push_mode_en, I40IWQPC_PMENA);
+	      LS_64(qp->sq_tph_en, I40IWQPC_SQTPHEN);
 
 	set_64bit_val(qp_ctx, 8, qp->sq_pa);
 	set_64bit_val(qp_ctx, 16, qp->rq_pa);
@@ -4291,13 +4249,6 @@ static enum i40iw_status_code i40iw_exec_cqp_cmd(struct i40iw_sc_dev *dev,
 				pcmdinfo->in.u.add_arp_cache_entry.scratch,
 				pcmdinfo->post_sq);
 		break;
-	case OP_MANAGE_PUSH_PAGE:
-		status = i40iw_sc_manage_push_page(
-				pcmdinfo->in.u.manage_push_page.cqp,
-				&pcmdinfo->in.u.manage_push_page.info,
-				pcmdinfo->in.u.manage_push_page.scratch,
-				pcmdinfo->post_sq);
-		break;
 	case OP_UPDATE_PE_SDS:
 		/* case I40IW_CQP_OP_UPDATE_PE_SDS */
 		status = i40iw_update_pe_sds(
@@ -5173,7 +5124,6 @@ void i40iw_vsi_stats_free(struct i40iw_sc_vsi *vsi)
 };
 
 static struct i40iw_cqp_misc_ops iw_cqp_misc_ops = {
-	.manage_push_page = i40iw_sc_manage_push_page,
 	.manage_hmc_pm_func_table = i40iw_sc_manage_hmc_pm_func_table,
 	.set_hmc_resource_profile = i40iw_sc_set_hmc_resource_profile,
 	.commit_fpm_values = i40iw_sc_commit_fpm_values,
diff --git a/drivers/infiniband/hw/i40iw/i40iw_d.h b/drivers/infiniband/hw/i40iw/i40iw_d.h
index e8367d6..86d5a33 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_d.h
+++ b/drivers/infiniband/hw/i40iw/i40iw_d.h
@@ -40,11 +40,6 @@
 #define I40IW_DB_ADDR_OFFSET    (4 * 1024 * 1024 - 64 * 1024)
 #define I40IW_VF_DB_ADDR_OFFSET (64 * 1024)
 
-#define I40IW_PUSH_OFFSET       (4 * 1024 * 1024)
-#define I40IW_PF_FIRST_PUSH_PAGE_INDEX 16
-#define I40IW_VF_PUSH_OFFSET    ((8 + 64) * 1024)
-#define I40IW_VF_FIRST_PUSH_PAGE_INDEX 2
-
 #define I40IW_PE_DB_SIZE_4M     1
 #define I40IW_PE_DB_SIZE_8M     2
 
@@ -402,7 +397,6 @@
 #define I40IW_CQP_OP_MANAGE_LOC_MAC_IP_TABLE    0x0e
 #define I40IW_CQP_OP_MANAGE_ARP                 0x0f
 #define I40IW_CQP_OP_MANAGE_VF_PBLE_BP          0x10
-#define I40IW_CQP_OP_MANAGE_PUSH_PAGES          0x11
 #define I40IW_CQP_OP_QUERY_RDMA_FEATURES	0x12
 #define I40IW_CQP_OP_UPLOAD_CONTEXT             0x13
 #define I40IW_CQP_OP_ALLOCATE_LOC_MAC_IP_TABLE_ENTRY 0x14
@@ -843,7 +837,6 @@
 #define I40IW_CQPSQ_MVPBP_PD_PLPBA_MASK \
 	(0x1fffffffffffffffULL << I40IW_CQPSQ_MVPBP_PD_PLPBA_SHIFT)
 
-/* Manage Push Page - MPP */
 #define I40IW_INVALID_PUSH_PAGE_INDEX 0xffff
 
 #define I40IW_CQPSQ_MPP_QS_HANDLE_SHIFT 0
@@ -1352,9 +1345,6 @@
 #define I40IWQPSQ_ADDFRAGCNT_SHIFT 38
 #define I40IWQPSQ_ADDFRAGCNT_MASK (0x7ULL << I40IWQPSQ_ADDFRAGCNT_SHIFT)
 
-#define I40IWQPSQ_PUSHWQE_SHIFT 56
-#define I40IWQPSQ_PUSHWQE_MASK (1ULL << I40IWQPSQ_PUSHWQE_SHIFT)
-
 #define I40IWQPSQ_STREAMMODE_SHIFT 58
 #define I40IWQPSQ_STREAMMODE_MASK (1ULL << I40IWQPSQ_STREAMMODE_SHIFT)
 
@@ -1740,18 +1730,17 @@ enum i40iw_alignment {
 #define OP_MW_ALLOC                             20
 #define OP_QP_FLUSH_WQES                        21
 #define OP_ADD_ARP_CACHE_ENTRY                  22
-#define OP_MANAGE_PUSH_PAGE                     23
-#define OP_UPDATE_PE_SDS                        24
-#define OP_MANAGE_HMC_PM_FUNC_TABLE             25
-#define OP_SUSPEND                              26
-#define OP_RESUME                               27
-#define OP_MANAGE_VF_PBLE_BP                    28
-#define OP_QUERY_FPM_VALUES                     29
-#define OP_COMMIT_FPM_VALUES                    30
-#define OP_REQUESTED_COMMANDS                   31
-#define OP_COMPLETED_COMMANDS                   32
-#define OP_GEN_AE                               33
-#define OP_QUERY_RDMA_FEATURES                  34
-#define OP_SIZE_CQP_STAT_ARRAY			35
+#define OP_UPDATE_PE_SDS                        23
+#define OP_MANAGE_HMC_PM_FUNC_TABLE             24
+#define OP_SUSPEND                              25
+#define OP_RESUME                               26
+#define OP_MANAGE_VF_PBLE_BP                    27
+#define OP_QUERY_FPM_VALUES                     28
+#define OP_COMMIT_FPM_VALUES                    29
+#define OP_REQUESTED_COMMANDS                   30
+#define OP_COMPLETED_COMMANDS                   31
+#define OP_GEN_AE                               32
+#define OP_QUERY_RDMA_FEATURES                  33
+#define OP_SIZE_CQP_STAT_ARRAY			34
 
 #endif
diff --git a/drivers/infiniband/hw/i40iw/i40iw_status.h b/drivers/infiniband/hw/i40iw/i40iw_status.h
index d1c5855..36a19c4 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_status.h
+++ b/drivers/infiniband/hw/i40iw/i40iw_status.h
@@ -61,7 +61,6 @@ enum i40iw_status_code {
 	I40IW_ERR_QUEUE_EMPTY = -22,
 	I40IW_ERR_INVALID_ALIGNMENT = -23,
 	I40IW_ERR_FLUSHED_QUEUE = -24,
-	I40IW_ERR_INVALID_PUSH_PAGE_INDEX = -25,
 	I40IW_ERR_INVALID_INLINE_DATA_SIZE = -26,
 	I40IW_ERR_TIMEOUT = -27,
 	I40IW_ERR_OPCODE_MISMATCH = -28,
diff --git a/drivers/infiniband/hw/i40iw/i40iw_type.h b/drivers/infiniband/hw/i40iw/i40iw_type.h
index c3babf3..49d9038 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_type.h
+++ b/drivers/infiniband/hw/i40iw/i40iw_type.h
@@ -387,7 +387,6 @@ struct i40iw_sc_qp {
 	u8 *q2_buf;
 	u64 qp_compl_ctx;
 	u16 qs_handle;
-	u16 push_idx;
 	u8 sq_tph_val;
 	u8 rq_tph_val;
 	u8 qp_state;
@@ -749,8 +748,6 @@ struct i40iw_qp_host_ctx_info {
 	struct i40iwarp_offload_info *iwarp_info;
 	u32 send_cq_num;
 	u32 rcv_cq_num;
-	u16 push_idx;
-	bool push_mode_en;
 	bool tcp_info_valid;
 	bool iwarp_info_valid;
 	bool err_rq_idx_valid;
@@ -937,12 +934,6 @@ struct i40iw_local_mac_ipaddr_entry_info {
 	u8 entry_idx;
 };
 
-struct i40iw_cqp_manage_push_page_info {
-	u32 push_idx;
-	u16 qs_handle;
-	u8 free_page;
-};
-
 struct i40iw_qp_flush_info {
 	u16 sq_minor_code;
 	u16 sq_major_code;
@@ -1114,9 +1105,6 @@ struct i40iw_mr_ops {
 };
 
 struct i40iw_cqp_misc_ops {
-	enum i40iw_status_code (*manage_push_page)(struct i40iw_sc_cqp *,
-						   struct i40iw_cqp_manage_push_page_info *,
-						   u64, bool);
 	enum i40iw_status_code (*manage_hmc_pm_func_table)(struct i40iw_sc_cqp *,
 							   u64, u8, bool, bool);
 	enum i40iw_status_code (*set_hmc_resource_profile)(struct i40iw_sc_cqp *,
@@ -1254,12 +1242,6 @@ struct cqp_info {
 		} manage_vf_pble_bp;
 
 		struct {
-			struct i40iw_sc_cqp *cqp;
-			struct i40iw_cqp_manage_push_page_info info;
-			u64 scratch;
-		} manage_push_page;
-
-		struct {
 			struct i40iw_sc_dev *dev;
 			struct i40iw_upload_context_info info;
 			u64 scratch;
diff --git a/drivers/infiniband/hw/i40iw/i40iw_uk.c b/drivers/infiniband/hw/i40iw/i40iw_uk.c
index 8afa5a6..c3633c9 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_uk.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_uk.c
@@ -115,17 +115,6 @@ void i40iw_qp_post_wr(struct i40iw_qp_uk *qp)
 }
 
 /**
- * i40iw_qp_ring_push_db -  ring qp doorbell
- * @qp: hw qp ptr
- * @wqe_idx: wqe index
- */
-static void i40iw_qp_ring_push_db(struct i40iw_qp_uk *qp, u32 wqe_idx)
-{
-	set_32bit_val(qp->push_db, 0, LS_32((wqe_idx >> 2), I40E_PFPE_WQEALLOC_WQE_DESC_INDEX) | qp->qp_id);
-	qp->initial_ring.head = I40IW_RING_GETCURRENT_HEAD(qp->sq_ring);
-}
-
-/**
  * i40iw_qp_get_next_send_wqe - return next wqe ptr
  * @qp: hw qp ptr
  * @wqe_idx: return wqe index
@@ -426,7 +415,6 @@ static enum i40iw_status_code i40iw_inline_rdma_write(struct i40iw_qp_uk *qp,
 	u64 *wqe;
 	u8 *dest, *src;
 	struct i40iw_inline_rdma_write *op_info;
-	u64 *push;
 	u64 header = 0;
 	u32 wqe_idx;
 	enum i40iw_status_code ret_code;
@@ -453,7 +441,6 @@ static enum i40iw_status_code i40iw_inline_rdma_write(struct i40iw_qp_uk *qp,
 		 LS_64(I40IWQP_OP_RDMA_WRITE, I40IWQPSQ_OPCODE) |
 		 LS_64(op_info->len, I40IWQPSQ_INLINEDATALEN) |
 		 LS_64(1, I40IWQPSQ_INLINEDATAFLAG) |
-		 LS_64((qp->push_db ? 1 : 0), I40IWQPSQ_PUSHWQE) |
 		 LS_64(read_fence, I40IWQPSQ_READFENCE) |
 		 LS_64(info->local_fence, I40IWQPSQ_LOCALFENCE) |
 		 LS_64(info->signaled, I40IWQPSQ_SIGCOMPL) |
@@ -475,14 +462,8 @@ static enum i40iw_status_code i40iw_inline_rdma_write(struct i40iw_qp_uk *qp,
 
 	set_64bit_val(wqe, 24, header);
 
-	if (qp->push_db) {
-		push = (u64 *)((uintptr_t)qp->push_wqe + (wqe_idx & 0x3) * 0x20);
-		memcpy(push, wqe, (op_info->len > 16) ? op_info->len + 16 : 32);
-		i40iw_qp_ring_push_db(qp, wqe_idx);
-	} else {
-		if (post_sq)
-			i40iw_qp_post_wr(qp);
-	}
+	if (post_sq)
+		i40iw_qp_post_wr(qp);
 
 	return 0;
 }
@@ -507,7 +488,6 @@ static enum i40iw_status_code i40iw_inline_send(struct i40iw_qp_uk *qp,
 	enum i40iw_status_code ret_code;
 	bool read_fence = false;
 	u8 wqe_size;
-	u64 *push;
 
 	op_info = &info->op.inline_send;
 	if (op_info->len > I40IW_MAX_INLINE_DATA_SIZE)
@@ -526,7 +506,6 @@ static enum i40iw_status_code i40iw_inline_send(struct i40iw_qp_uk *qp,
 	    LS_64(info->op_type, I40IWQPSQ_OPCODE) |
 	    LS_64(op_info->len, I40IWQPSQ_INLINEDATALEN) |
 	    LS_64(1, I40IWQPSQ_INLINEDATAFLAG) |
-	    LS_64((qp->push_db ? 1 : 0), I40IWQPSQ_PUSHWQE) |
 	    LS_64(read_fence, I40IWQPSQ_READFENCE) |
 	    LS_64(info->local_fence, I40IWQPSQ_LOCALFENCE) |
 	    LS_64(info->signaled, I40IWQPSQ_SIGCOMPL) |
@@ -548,14 +527,8 @@ static enum i40iw_status_code i40iw_inline_send(struct i40iw_qp_uk *qp,
 
 	set_64bit_val(wqe, 24, header);
 
-	if (qp->push_db) {
-		push = (u64 *)((uintptr_t)qp->push_wqe + (wqe_idx & 0x3) * 0x20);
-		memcpy(push, wqe, (op_info->len > 16) ? op_info->len + 16 : 32);
-		i40iw_qp_ring_push_db(qp, wqe_idx);
-	} else {
-		if (post_sq)
-			i40iw_qp_post_wr(qp);
-	}
+	if (post_sq)
+		i40iw_qp_post_wr(qp);
 
 	return 0;
 }
@@ -772,7 +745,6 @@ static enum i40iw_status_code i40iw_cq_poll_completion(struct i40iw_cq_uk *cq,
 
 	q_type = (u8)RS_64(qword3, I40IW_CQ_SQ);
 	info->error = (bool)RS_64(qword3, I40IW_CQ_ERROR);
-	info->push_dropped = (bool)RS_64(qword3, I40IWCQ_PSHDROP);
 	if (info->error) {
 		info->comp_status = I40IW_COMPL_STATUS_FLUSHED;
 		info->major_err = (bool)RS_64(qword3, I40IW_CQ_MAJERR);
@@ -951,7 +923,6 @@ enum i40iw_status_code i40iw_get_rqdepth(u32 rq_size, u8 shift, u32 *rqdepth)
 
 static const struct i40iw_qp_uk_ops iw_qp_uk_ops = {
 	.iw_qp_post_wr = i40iw_qp_post_wr,
-	.iw_qp_ring_push_db = i40iw_qp_ring_push_db,
 	.iw_rdma_write = i40iw_rdma_write,
 	.iw_rdma_read = i40iw_rdma_read,
 	.iw_send = i40iw_send,
@@ -1009,11 +980,7 @@ enum i40iw_status_code i40iw_qp_uk_init(struct i40iw_qp_uk *qp,
 
 	qp->wqe_alloc_reg = info->wqe_alloc_reg;
 	qp->qp_id = info->qp_id;
-
 	qp->sq_size = info->sq_size;
-	qp->push_db = info->push_db;
-	qp->push_wqe = info->push_wqe;
-
 	qp->max_sq_frag_cnt = info->max_sq_frag_cnt;
 	sq_ring_size = qp->sq_size << sqshift;
 
diff --git a/drivers/infiniband/hw/i40iw/i40iw_user.h b/drivers/infiniband/hw/i40iw/i40iw_user.h
index b125925..93fc308 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_user.h
+++ b/drivers/infiniband/hw/i40iw/i40iw_user.h
@@ -64,13 +64,11 @@ enum i40iw_device_capabilities_const {
 	I40IW_MAX_SGE_RD =			1,
 	I40IW_MAX_OUTBOUND_MESSAGE_SIZE =	2147483647,
 	I40IW_MAX_INBOUND_MESSAGE_SIZE =	2147483647,
-	I40IW_MAX_PUSH_PAGE_COUNT =		4096,
 	I40IW_MAX_PE_ENABLED_VF_COUNT =		32,
 	I40IW_MAX_VF_FPM_ID =			47,
 	I40IW_MAX_VF_PER_PF =			127,
 	I40IW_MAX_SQ_PAYLOAD_SIZE =		2145386496,
 	I40IW_MAX_INLINE_DATA_SIZE =		48,
-	I40IW_MAX_PUSHMODE_INLINE_DATA_SIZE =	48,
 	I40IW_MAX_IRD_SIZE =			64,
 	I40IW_MAX_ORD_SIZE =			127,
 	I40IW_MAX_WQ_ENTRIES =			2048,
@@ -272,7 +270,6 @@ struct i40iw_cq_poll_info {
 	u16 minor_err;
 	u8 op_type;
 	bool stag_invalid_set;
-	bool push_dropped;
 	bool error;
 	bool is_srq;
 	bool solicited_event;
@@ -280,7 +277,6 @@ struct i40iw_cq_poll_info {
 
 struct i40iw_qp_uk_ops {
 	void (*iw_qp_post_wr)(struct i40iw_qp_uk *);
-	void (*iw_qp_ring_push_db)(struct i40iw_qp_uk *, u32);
 	enum i40iw_status_code (*iw_rdma_write)(struct i40iw_qp_uk *,
 						struct i40iw_post_sq_info *, bool);
 	enum i40iw_status_code (*iw_rdma_read)(struct i40iw_qp_uk *,
@@ -340,8 +336,6 @@ struct i40iw_qp_uk {
 	struct i40iw_sq_uk_wr_trk_info *sq_wrtrk_array;
 	u64 *rq_wrid_array;
 	u64 *shadow_area;
-	u32 *push_db;
-	u64 *push_wqe;
 	struct i40iw_ring sq_ring;
 	struct i40iw_ring rq_ring;
 	struct i40iw_ring initial_ring;
@@ -381,8 +375,6 @@ struct i40iw_qp_uk_init_info {
 	u64 *shadow_area;
 	struct i40iw_sq_uk_wr_trk_info *sq_wrtrk_array;
 	u64 *rq_wrid_array;
-	u32 *push_db;
-	u64 *push_wqe;
 	u32 qp_id;
 	u32 sq_size;
 	u32 rq_size;
diff --git a/drivers/infiniband/hw/i40iw/i40iw_verbs.c b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
index 533f3ca..f4fcff4 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
@@ -180,78 +180,6 @@ static int i40iw_mmap(struct ib_ucontext *context, struct vm_area_struct *vma)
 }
 
 /**
- * i40iw_alloc_push_page - allocate a push page for qp
- * @iwdev: iwarp device
- * @qp: hardware control qp
- */
-static void i40iw_alloc_push_page(struct i40iw_device *iwdev, struct i40iw_sc_qp *qp)
-{
-	struct i40iw_cqp_request *cqp_request;
-	struct cqp_commands_info *cqp_info;
-	enum i40iw_status_code status;
-
-	if (qp->push_idx != I40IW_INVALID_PUSH_PAGE_INDEX)
-		return;
-
-	cqp_request = i40iw_get_cqp_request(&iwdev->cqp, true);
-	if (!cqp_request)
-		return;
-
-	atomic_inc(&cqp_request->refcount);
-
-	cqp_info = &cqp_request->info;
-	cqp_info->cqp_cmd = OP_MANAGE_PUSH_PAGE;
-	cqp_info->post_sq = 1;
-
-	cqp_info->in.u.manage_push_page.info.qs_handle = qp->qs_handle;
-	cqp_info->in.u.manage_push_page.info.free_page = 0;
-	cqp_info->in.u.manage_push_page.cqp = &iwdev->cqp.sc_cqp;
-	cqp_info->in.u.manage_push_page.scratch = (uintptr_t)cqp_request;
-
-	status = i40iw_handle_cqp_op(iwdev, cqp_request);
-	if (!status)
-		qp->push_idx = cqp_request->compl_info.op_ret_val;
-	else
-		i40iw_pr_err("CQP-OP Push page fail");
-	i40iw_put_cqp_request(&iwdev->cqp, cqp_request);
-}
-
-/**
- * i40iw_dealloc_push_page - free a push page for qp
- * @iwdev: iwarp device
- * @qp: hardware control qp
- */
-static void i40iw_dealloc_push_page(struct i40iw_device *iwdev, struct i40iw_sc_qp *qp)
-{
-	struct i40iw_cqp_request *cqp_request;
-	struct cqp_commands_info *cqp_info;
-	enum i40iw_status_code status;
-
-	if (qp->push_idx == I40IW_INVALID_PUSH_PAGE_INDEX)
-		return;
-
-	cqp_request = i40iw_get_cqp_request(&iwdev->cqp, false);
-	if (!cqp_request)
-		return;
-
-	cqp_info = &cqp_request->info;
-	cqp_info->cqp_cmd = OP_MANAGE_PUSH_PAGE;
-	cqp_info->post_sq = 1;
-
-	cqp_info->in.u.manage_push_page.info.push_idx = qp->push_idx;
-	cqp_info->in.u.manage_push_page.info.qs_handle = qp->qs_handle;
-	cqp_info->in.u.manage_push_page.info.free_page = 1;
-	cqp_info->in.u.manage_push_page.cqp = &iwdev->cqp.sc_cqp;
-	cqp_info->in.u.manage_push_page.scratch = (uintptr_t)cqp_request;
-
-	status = i40iw_handle_cqp_op(iwdev, cqp_request);
-	if (!status)
-		qp->push_idx = I40IW_INVALID_PUSH_PAGE_INDEX;
-	else
-		i40iw_pr_err("CQP-OP Push page fail");
-}
-
-/**
  * i40iw_alloc_pd - allocate protection domain
  * @pd: PD pointer
  * @udata: user data
@@ -348,7 +276,6 @@ void i40iw_free_qp_resources(struct i40iw_qp *iwqp)
 	u32 qp_num = iwqp->ibqp.qp_num;
 
 	i40iw_ieq_cleanup_qp(iwdev->vsi.ieq, &iwqp->sc_qp);
-	i40iw_dealloc_push_page(iwdev, &iwqp->sc_qp);
 	if (qp_num)
 		i40iw_free_resource(iwdev, iwdev->allocated_qps, qp_num);
 	if (iwpbl->pbl_allocated)
@@ -561,8 +488,6 @@ static int i40iw_setup_kmode_qp(struct i40iw_device *iwdev,
 
 	qp = &iwqp->sc_qp;
 	qp->back_qp = (void *)iwqp;
-	qp->push_idx = I40IW_INVALID_PUSH_PAGE_INDEX;
-
 	iwqp->iwdev = iwdev;
 	iwqp->ctx_info.iwarp_info = &iwqp->iwarp_info;
 
@@ -606,8 +531,6 @@ static int i40iw_setup_kmode_qp(struct i40iw_device *iwdev,
 		err_code = -EOPNOTSUPP;
 		goto error;
 	}
-	if (iwdev->push_mode)
-		i40iw_alloc_push_page(iwdev, qp);
 	if (udata) {
 		err_code = ib_copy_from_udata(&req, udata, sizeof(req));
 		if (err_code) {
@@ -666,13 +589,6 @@ static int i40iw_setup_kmode_qp(struct i40iw_device *iwdev,
 	ctx_info->iwarp_info_valid = true;
 	ctx_info->send_cq_num = iwqp->iwscq->sc_cq.cq_uk.cq_id;
 	ctx_info->rcv_cq_num = iwqp->iwrcq->sc_cq.cq_uk.cq_id;
-	if (qp->push_idx == I40IW_INVALID_PUSH_PAGE_INDEX) {
-		ctx_info->push_mode_en = false;
-	} else {
-		ctx_info->push_mode_en = true;
-		ctx_info->push_idx = qp->push_idx;
-	}
-
 	ret = dev->iw_priv_qp_ops->qp_setctx(&iwqp->sc_qp,
 					     (u64 *)iwqp->host_ctx.va,
 					     ctx_info);
@@ -712,7 +628,7 @@ static int i40iw_setup_kmode_qp(struct i40iw_device *iwdev,
 		uresp.actual_sq_size = sq_size;
 		uresp.actual_rq_size = rq_size;
 		uresp.qp_id = qp_num;
-		uresp.push_idx = qp->push_idx;
+		uresp.push_idx = I40IW_INVALID_PUSH_PAGE_INDEX;
 		err_code = ib_copy_to_udata(udata, &uresp, sizeof(uresp));
 		if (err_code) {
 			i40iw_pr_err("copy_to_udata failed\n");
-- 
1.7.1

