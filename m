Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508C0628F0F
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Nov 2022 02:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232137AbiKOBRQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Nov 2022 20:17:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232173AbiKOBRL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Nov 2022 20:17:11 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA5B15A1E
        for <linux-rdma@vger.kernel.org>; Mon, 14 Nov 2022 17:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668475030; x=1700011030;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WiwtSfdwTrsiKtOZeig+0gEpng0j4B9HbTSI+Su8X2o=;
  b=dFM0BbslMyD8ipxDgjwfcUrd8pajz7Gef/gttcUGoFcIFY9OuouLxzMv
   5im4t85MkRqn+ge9u5wZ94sPzCg+uLfAJmM/1uGkyFGeo5zqyTidCDGA5
   zheHNZLFXBwI+oMJv6DVkoFLi9LLmaFRm+8cY0w7wkPqWNjLLUGHiIN2w
   rl/ebzs2evZ45HijMfvY2y/wwYKKoae9XrvZ9N4CQQFZZwdZNZhATfcma
   diM5BFanP6ts0VyqkJqci20yszrKt/B6YCmVfVJMZWFep+fj5VnEcI7ft
   eGg6wO4M+lntcM3nKKWqgJPhjRqodcv4Y0vHfQxvGKe5D4HkgXY/thkLm
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="309755411"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="309755411"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 17:17:10 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="727755020"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="727755020"
Received: from ssaleem-mobl1.amr.corp.intel.com ([10.255.34.85])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 17:17:09 -0800
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     jgg@nvidia.com, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH v2 for-next 2/3] RDMA/irdma: Fix RQ completion opcode
Date:   Mon, 14 Nov 2022 19:17:00 -0600
Message-Id: <20221115011701.1379-3-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20221115011701.1379-1-shiraz.saleem@intel.com>
References: <20221115011701.1379-1-shiraz.saleem@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mustafa Ismail <mustafa.ismail@intel.com>

The opcode written by HW, in the RQ CQE, is the
RoCEv2/iWARP protocol opcode from the received
packet and not the SW opcode as currently assumed.
Fix this by returning the raw operation type and
queue type in the CQE to irdma_process_cqe and add
2 helpers set_ib_wc_op_sq set_ib_wc_op_rq to map
IRDMA HW op types to IB op types.

Note that for iWARP, only Write with Immediate is
supported so the opcode can only be IB_WC_RECV_RDMA_WITH_IMM
when there is immediate data present.

Fixes: b48c24c2d710 ("RDMA/irdma: Implement device supported verb APIs")
Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/hw/irdma/uk.c    | 21 +++++++--------
 drivers/infiniband/hw/irdma/user.h  |  1 +
 drivers/infiniband/hw/irdma/utils.c |  2 ++
 drivers/infiniband/hw/irdma/verbs.c | 39 +++++----------------------
 drivers/infiniband/hw/irdma/verbs.h | 53 +++++++++++++++++++++++++++++++++++++
 5 files changed, 71 insertions(+), 45 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/uk.c b/drivers/infiniband/hw/irdma/uk.c
index 1a57ed9..16183e8 100644
--- a/drivers/infiniband/hw/irdma/uk.c
+++ b/drivers/infiniband/hw/irdma/uk.c
@@ -1049,11 +1049,10 @@ int irdma_uk_cq_poll_cmpl(struct irdma_cq_uk *cq,
 	__le64 *cqe;
 	struct irdma_qp_uk *qp;
 	struct irdma_ring *pring = NULL;
-	u32 wqe_idx, q_type;
+	u32 wqe_idx;
 	int ret_code;
 	bool move_cq_head = true;
 	u8 polarity;
-	u8 op_type;
 	bool ext_valid;
 	__le64 *ext_cqe;
 
@@ -1121,7 +1120,7 @@ int irdma_uk_cq_poll_cmpl(struct irdma_cq_uk *cq,
 		info->ud_vlan_valid = false;
 	}
 
-	q_type = (u8)FIELD_GET(IRDMA_CQ_SQ, qword3);
+	info->q_type = (u8)FIELD_GET(IRDMA_CQ_SQ, qword3);
 	info->error = (bool)FIELD_GET(IRDMA_CQ_ERROR, qword3);
 	info->push_dropped = (bool)FIELD_GET(IRDMACQ_PSHDROP, qword3);
 	info->ipv4 = (bool)FIELD_GET(IRDMACQ_IPV4, qword3);
@@ -1160,8 +1159,9 @@ int irdma_uk_cq_poll_cmpl(struct irdma_cq_uk *cq,
 	}
 	wqe_idx = (u32)FIELD_GET(IRDMA_CQ_WQEIDX, qword3);
 	info->qp_handle = (irdma_qp_handle)(unsigned long)qp;
+	info->op_type = (u8)FIELD_GET(IRDMA_CQ_SQ, qword3);
 
-	if (q_type == IRDMA_CQE_QTYPE_RQ) {
+	if (info->q_type == IRDMA_CQE_QTYPE_RQ) {
 		u32 array_idx;
 
 		array_idx = wqe_idx / qp->rq_wqe_size_multiplier;
@@ -1181,10 +1181,6 @@ int irdma_uk_cq_poll_cmpl(struct irdma_cq_uk *cq,
 
 		info->bytes_xfered = (u32)FIELD_GET(IRDMACQ_PAYLDLEN, qword0);
 
-		if (info->imm_valid)
-			info->op_type = IRDMA_OP_TYPE_REC_IMM;
-		else
-			info->op_type = IRDMA_OP_TYPE_REC;
 		if (qword3 & IRDMACQ_STAG) {
 			info->stag_invalid_set = true;
 			info->inv_stag = (u32)FIELD_GET(IRDMACQ_INVSTAG, qword2);
@@ -1242,17 +1238,18 @@ int irdma_uk_cq_poll_cmpl(struct irdma_cq_uk *cq,
 				sw_wqe = qp->sq_base[tail].elem;
 				get_64bit_val(sw_wqe, 24,
 					      &wqe_qword);
-				op_type = (u8)FIELD_GET(IRDMAQPSQ_OPCODE, wqe_qword);
-				info->op_type = op_type;
+				info->op_type = (u8)FIELD_GET(IRDMAQPSQ_OPCODE,
+							      wqe_qword);
 				IRDMA_RING_SET_TAIL(qp->sq_ring,
 						    tail + qp->sq_wrtrk_array[tail].quanta);
-				if (op_type != IRDMAQP_OP_NOP) {
+				if (info->op_type != IRDMAQP_OP_NOP) {
 					info->wr_id = qp->sq_wrtrk_array[tail].wrid;
 					info->bytes_xfered = qp->sq_wrtrk_array[tail].wr_len;
 					break;
 				}
 			} while (1);
-			if (op_type == IRDMA_OP_TYPE_BIND_MW && info->minor_err == FLUSH_PROT_ERR)
+			if (info->op_type == IRDMA_OP_TYPE_BIND_MW &&
+			    info->minor_err == FLUSH_PROT_ERR)
 				info->minor_err = FLUSH_MW_BIND_ERR;
 			qp->sq_flush_seen = true;
 			if (!IRDMA_RING_MORE_WORK(qp->sq_ring))
diff --git a/drivers/infiniband/hw/irdma/user.h b/drivers/infiniband/hw/irdma/user.h
index 424d4aa..d0cdf609 100644
--- a/drivers/infiniband/hw/irdma/user.h
+++ b/drivers/infiniband/hw/irdma/user.h
@@ -245,6 +245,7 @@ struct irdma_cq_poll_info {
 	u16 ud_vlan;
 	u8 ud_smac[6];
 	u8 op_type;
+	u8 q_type;
 	bool stag_invalid_set:1; /* or L_R_Key set */
 	bool push_dropped:1;
 	bool error:1;
diff --git a/drivers/infiniband/hw/irdma/utils.c b/drivers/infiniband/hw/irdma/utils.c
index 8dfc9e1..445e69e8 100644
--- a/drivers/infiniband/hw/irdma/utils.c
+++ b/drivers/infiniband/hw/irdma/utils.c
@@ -2591,6 +2591,7 @@ void irdma_generate_flush_completions(struct irdma_qp *iwqp)
 			sw_wqe = qp->sq_base[wqe_idx].elem;
 			get_64bit_val(sw_wqe, 24, &wqe_qword);
 			cmpl->cpi.op_type = (u8)FIELD_GET(IRDMAQPSQ_OPCODE, IRDMAQPSQ_OPCODE);
+			cmpl->cpi.q_type = IRDMA_CQE_QTYPE_SQ;
 			/* remove the SQ WR by moving SQ tail*/
 			IRDMA_RING_SET_TAIL(*sq_ring,
 				sq_ring->tail + qp->sq_wrtrk_array[sq_ring->tail].quanta);
@@ -2629,6 +2630,7 @@ void irdma_generate_flush_completions(struct irdma_qp *iwqp)
 
 			cmpl->cpi.wr_id = qp->rq_wrid_array[wqe_idx];
 			cmpl->cpi.op_type = IRDMA_OP_TYPE_REC;
+			cmpl->cpi.q_type = IRDMA_CQE_QTYPE_RQ;
 			/* remove the RQ WR by moving RQ tail */
 			IRDMA_RING_SET_TAIL(*rq_ring, rq_ring->tail + 1);
 			ibdev_dbg(iwqp->iwrcq->ibcq.device,
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index e252f43..01d0dc4 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -3334,7 +3334,6 @@ static enum ib_wc_status irdma_flush_err_to_ib_wc_status(enum irdma_flush_opcode
 static void irdma_process_cqe(struct ib_wc *entry,
 			      struct irdma_cq_poll_info *cq_poll_info)
 {
-	struct irdma_qp *iwqp;
 	struct irdma_sc_qp *qp;
 
 	entry->wc_flags = 0;
@@ -3342,7 +3341,6 @@ static void irdma_process_cqe(struct ib_wc *entry,
 	entry->wr_id = cq_poll_info->wr_id;
 
 	qp = cq_poll_info->qp_handle;
-	iwqp = qp->qp_uk.back_qp;
 	entry->qp = qp->qp_uk.back_qp;
 
 	if (cq_poll_info->error) {
@@ -3375,42 +3373,17 @@ static void irdma_process_cqe(struct ib_wc *entry,
 		}
 	}
 
-	switch (cq_poll_info->op_type) {
-	case IRDMA_OP_TYPE_RDMA_WRITE:
-	case IRDMA_OP_TYPE_RDMA_WRITE_SOL:
-		entry->opcode = IB_WC_RDMA_WRITE;
-		break;
-	case IRDMA_OP_TYPE_RDMA_READ_INV_STAG:
-	case IRDMA_OP_TYPE_RDMA_READ:
-		entry->opcode = IB_WC_RDMA_READ;
-		break;
-	case IRDMA_OP_TYPE_SEND_INV:
-	case IRDMA_OP_TYPE_SEND_SOL:
-	case IRDMA_OP_TYPE_SEND_SOL_INV:
-	case IRDMA_OP_TYPE_SEND:
-		entry->opcode = IB_WC_SEND;
-		break;
-	case IRDMA_OP_TYPE_FAST_REG_NSMR:
-		entry->opcode = IB_WC_REG_MR;
-		break;
-	case IRDMA_OP_TYPE_INV_STAG:
-		entry->opcode = IB_WC_LOCAL_INV;
-		break;
-	case IRDMA_OP_TYPE_REC_IMM:
-	case IRDMA_OP_TYPE_REC:
-		entry->opcode = cq_poll_info->op_type == IRDMA_OP_TYPE_REC_IMM ?
-			IB_WC_RECV_RDMA_WITH_IMM : IB_WC_RECV;
+	if (cq_poll_info->q_type == IRDMA_CQE_QTYPE_SQ) {
+		set_ib_wc_op_sq(cq_poll_info, entry);
+	} else {
+		set_ib_wc_op_rq(cq_poll_info, entry,
+				qp->qp_uk.qp_caps & IRDMA_SEND_WITH_IMM ?
+				true : false);
 		if (qp->qp_uk.qp_type != IRDMA_QP_TYPE_ROCE_UD &&
 		    cq_poll_info->stag_invalid_set) {
 			entry->ex.invalidate_rkey = cq_poll_info->inv_stag;
 			entry->wc_flags |= IB_WC_WITH_INVALIDATE;
 		}
-		break;
-	default:
-		ibdev_err(&iwqp->iwdev->ibdev,
-			  "Invalid opcode = %d in CQE\n", cq_poll_info->op_type);
-		entry->status = IB_WC_GENERAL_ERR;
-		return;
 	}
 
 	if (qp->qp_uk.qp_type == IRDMA_QP_TYPE_ROCE_UD) {
diff --git a/drivers/infiniband/hw/irdma/verbs.h b/drivers/infiniband/hw/irdma/verbs.h
index 4309b71..a536e9f 100644
--- a/drivers/infiniband/hw/irdma/verbs.h
+++ b/drivers/infiniband/hw/irdma/verbs.h
@@ -232,6 +232,59 @@ static inline u16 irdma_fw_minor_ver(struct irdma_sc_dev *dev)
 	return (u16)FIELD_GET(IRDMA_FW_VER_MINOR, dev->feature_info[IRDMA_FEATURE_FW_INFO]);
 }
 
+static inline void set_ib_wc_op_sq(struct irdma_cq_poll_info *cq_poll_info,
+				   struct ib_wc *entry)
+{
+	switch (cq_poll_info->op_type) {
+	case IRDMA_OP_TYPE_RDMA_WRITE:
+	case IRDMA_OP_TYPE_RDMA_WRITE_SOL:
+		entry->opcode = IB_WC_RDMA_WRITE;
+		break;
+	case IRDMA_OP_TYPE_RDMA_READ_INV_STAG:
+	case IRDMA_OP_TYPE_RDMA_READ:
+		entry->opcode = IB_WC_RDMA_READ;
+		break;
+	case IRDMA_OP_TYPE_SEND_SOL:
+	case IRDMA_OP_TYPE_SEND_SOL_INV:
+	case IRDMA_OP_TYPE_SEND_INV:
+	case IRDMA_OP_TYPE_SEND:
+		entry->opcode = IB_WC_SEND;
+		break;
+	case IRDMA_OP_TYPE_FAST_REG_NSMR:
+		entry->opcode = IB_WC_REG_MR;
+		break;
+	case IRDMA_OP_TYPE_INV_STAG:
+		entry->opcode = IB_WC_LOCAL_INV;
+		break;
+	default:
+		entry->status = IB_WC_GENERAL_ERR;
+	}
+}
+
+static inline void set_ib_wc_op_rq(struct irdma_cq_poll_info *cq_poll_info,
+				   struct ib_wc *entry, bool send_imm_support)
+{
+	/**
+	 * iWARP does not support sendImm, so the presence of Imm data
+	 * must be WriteImm.
+	 */
+	if (!send_imm_support) {
+		entry->opcode = cq_poll_info->imm_valid ?
+					IB_WC_RECV_RDMA_WITH_IMM :
+					IB_WC_RECV;
+		return;
+	}
+
+	switch (cq_poll_info->op_type) {
+	case IB_OPCODE_RDMA_WRITE_ONLY_WITH_IMMEDIATE:
+	case IB_OPCODE_RDMA_WRITE_LAST_WITH_IMMEDIATE:
+		entry->opcode = IB_WC_RECV_RDMA_WITH_IMM;
+		break;
+	default:
+		entry->opcode = IB_WC_RECV;
+	}
+}
+
 void irdma_mcast_mac(u32 *ip_addr, u8 *mac, bool ipv4);
 int irdma_ib_register_device(struct irdma_device *iwdev);
 void irdma_ib_unregister_device(struct irdma_device *iwdev);
-- 
1.8.3.1

