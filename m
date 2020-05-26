Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1541B5C35
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2020 15:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgDWNNM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Apr 2020 09:13:12 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:36020 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726224AbgDWNNM (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 23 Apr 2020 09:13:12 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 81E1DEE13BE110D2275D;
        Thu, 23 Apr 2020 21:13:01 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Thu, 23 Apr 2020 21:12:53 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH v2 for-next 3/5] RDMA/hns: Optimize WQE buffer size calculating process
Date:   Thu, 23 Apr 2020 21:12:48 +0800
Message-ID: <1587647570-46972-4-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1587647570-46972-1-git-send-email-liweihang@huawei.com>
References: <1587647570-46972-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

Optimize the QP's WQE buffer parameters calculating process to make the
codes more readable mainly by merging calculation of extended sge space
of kernel and userspace. In addition, add some inline functions to simply
codes about multi-hop addressing.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h |  25 +++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 109 ++++------
 drivers/infiniband/hw/hns/hns_roce_qp.c     | 313 +++++++++++-----------------
 3 files changed, 182 insertions(+), 265 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 6185f8c..a5706c9 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -1079,6 +1079,8 @@ static inline dma_addr_t hns_roce_buf_page(struct hns_roce_buf *buf, int idx)
 		return buf->page_list[idx].map;
 }
 
+#define hr_hw_page_align(x)		ALIGN(x, 1 << PAGE_ADDR_SHIFT)
+
 static inline u64 to_hr_hw_page_addr(u64 addr)
 {
 	return addr >> PAGE_ADDR_SHIFT;
@@ -1089,6 +1091,29 @@ static inline u32 to_hr_hw_page_shift(u32 page_shift)
 	return page_shift - PAGE_ADDR_SHIFT;
 }
 
+static inline u32 to_hr_hem_hopnum(u32 hopnum, u32 count)
+{
+	if (count > 0)
+		return hopnum == HNS_ROCE_HOP_NUM_0 ? 0 : hopnum;
+
+	return 0;
+}
+
+static inline u32 to_hr_hem_entries_size(u32 count, u32 buf_shift)
+{
+	return hr_hw_page_align(count << buf_shift);
+}
+
+static inline u32 to_hr_hem_entries_count(u32 count, u32 buf_shift)
+{
+	return hr_hw_page_align(count << buf_shift) >> buf_shift;
+}
+
+static inline u32 to_hr_hem_entries_shift(u32 count, u32 buf_shift)
+{
+	return ilog2(to_hr_hem_entries_count(count, buf_shift));
+}
+
 int hns_roce_init_uar_table(struct hns_roce_dev *dev);
 int hns_roce_uar_alloc(struct hns_roce_dev *dev, struct hns_roce_uar *uar);
 void hns_roce_uar_free(struct hns_roce_dev *dev, struct hns_roce_uar *uar);
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index bdcbb8b..97b8cb3 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -154,47 +154,24 @@ static void set_extend_sge(struct hns_roce_qp *qp, const struct ib_send_wr *wr,
 			   unsigned int *sge_ind, int valid_num_sge)
 {
 	struct hns_roce_v2_wqe_data_seg *dseg;
-	struct ib_sge *sg;
-	int num_in_wqe = 0;
-	int extend_sge_num;
-	int fi_sge_num;
-	int se_sge_num;
-	int shift;
-	int i;
+	struct ib_sge *sge = wr->sg_list;
+	unsigned int idx = *sge_ind;
+	int cnt = valid_num_sge;
 
-	if (qp->ibqp.qp_type == IB_QPT_RC || qp->ibqp.qp_type == IB_QPT_UC)
-		num_in_wqe = HNS_ROCE_V2_UC_RC_SGE_NUM_IN_WQE;
-	extend_sge_num = valid_num_sge - num_in_wqe;
-	sg = wr->sg_list + num_in_wqe;
-	shift = qp->mtr.hem_cfg.buf_pg_shift;
+	if (qp->ibqp.qp_type == IB_QPT_RC || qp->ibqp.qp_type == IB_QPT_UC) {
+		cnt -= HNS_ROCE_SGE_IN_WQE;
+		sge += HNS_ROCE_SGE_IN_WQE;
+	}
 
-	/*
-	 * Check whether wr->num_sge sges are in the same page. If not, we
-	 * should calculate how many sges in the first page and the second
-	 * page.
-	 */
-	dseg = hns_roce_get_extend_sge(qp, (*sge_ind) & (qp->sge.sge_cnt - 1));
-	fi_sge_num = (round_up((uintptr_t)dseg, 1 << shift) -
-		      (uintptr_t)dseg) /
-		      sizeof(struct hns_roce_v2_wqe_data_seg);
-	if (extend_sge_num > fi_sge_num) {
-		se_sge_num = extend_sge_num - fi_sge_num;
-		for (i = 0; i < fi_sge_num; i++) {
-			set_data_seg_v2(dseg++, sg + i);
-			(*sge_ind)++;
-		}
-		dseg = hns_roce_get_extend_sge(qp,
-					   (*sge_ind) & (qp->sge.sge_cnt - 1));
-		for (i = 0; i < se_sge_num; i++) {
-			set_data_seg_v2(dseg++, sg + fi_sge_num + i);
-			(*sge_ind)++;
-		}
-	} else {
-		for (i = 0; i < extend_sge_num; i++) {
-			set_data_seg_v2(dseg++, sg + i);
-			(*sge_ind)++;
-		}
+	while (cnt > 0) {
+		dseg = hns_roce_get_extend_sge(qp, idx & (qp->sge.sge_cnt - 1));
+		set_data_seg_v2(dseg, sge);
+		idx++;
+		sge++;
+		cnt--;
 	}
+
+	*sge_ind = idx;
 }
 
 static int set_rwqe_data_seg(struct ib_qp *ibqp, const struct ib_send_wr *wr,
@@ -232,7 +209,7 @@ static int set_rwqe_data_seg(struct ib_qp *ibqp, const struct ib_send_wr *wr,
 		roce_set_bit(rc_sq_wqe->byte_4, V2_RC_SEND_WQE_BYTE_4_INLINE_S,
 			     1);
 	} else {
-		if (valid_num_sge <= HNS_ROCE_V2_UC_RC_SGE_NUM_IN_WQE) {
+		if (valid_num_sge <= HNS_ROCE_SGE_IN_WQE) {
 			for (i = 0; i < wr->num_sge; i++) {
 				if (likely(wr->sg_list[i].length)) {
 					set_data_seg_v2(dseg, wr->sg_list + i);
@@ -245,8 +222,8 @@ static int set_rwqe_data_seg(struct ib_qp *ibqp, const struct ib_send_wr *wr,
 				     V2_RC_SEND_WQE_BYTE_20_MSG_START_SGE_IDX_S,
 				     (*sge_ind) & (qp->sge.sge_cnt - 1));
 
-			for (i = 0; i < wr->num_sge &&
-			     j < HNS_ROCE_V2_UC_RC_SGE_NUM_IN_WQE; i++) {
+			for (i = 0; i < wr->num_sge && j < HNS_ROCE_SGE_IN_WQE;
+			     i++) {
 				if (likely(wr->sg_list[i].length)) {
 					set_data_seg_v2(dseg, wr->sg_list + i);
 					dseg++;
@@ -675,7 +652,7 @@ static int hns_roce_v2_post_recv(struct ib_qp *ibqp,
 		}
 
 		/* rq support inline data */
-		if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RQ_INLINE) {
+		if (hr_qp->rq_inl_buf.wqe_cnt) {
 			sge_list = hr_qp->rq_inl_buf.wqe_list[wqe_idx].sg_list;
 			hr_qp->rq_inl_buf.wqe_list[wqe_idx].sge_cnt =
 							       (u32)wr->num_sge;
@@ -3491,29 +3468,18 @@ static void set_qpc_wqe_cnt(struct hns_roce_qp *hr_qp,
 			    struct hns_roce_v2_qp_context *context,
 			    struct hns_roce_v2_qp_context *qpc_mask)
 {
-	if (hr_qp->ibqp.qp_type == IB_QPT_GSI)
-		roce_set_field(context->byte_4_sqpn_tst,
-			       V2_QPC_BYTE_4_SGE_SHIFT_M,
-			       V2_QPC_BYTE_4_SGE_SHIFT_S,
-			       ilog2((unsigned int)hr_qp->sge.sge_cnt));
-	else
-		roce_set_field(context->byte_4_sqpn_tst,
-			       V2_QPC_BYTE_4_SGE_SHIFT_M,
-			       V2_QPC_BYTE_4_SGE_SHIFT_S,
-			       hr_qp->sq.max_gs >
-			       HNS_ROCE_V2_UC_RC_SGE_NUM_IN_WQE ?
-			       ilog2((unsigned int)hr_qp->sge.sge_cnt) : 0);
+	roce_set_field(context->byte_4_sqpn_tst,
+		       V2_QPC_BYTE_4_SGE_SHIFT_M, V2_QPC_BYTE_4_SGE_SHIFT_S,
+		       to_hr_hem_entries_shift(hr_qp->sge.sge_cnt,
+					       hr_qp->sge.sge_shift));
 
 	roce_set_field(context->byte_20_smac_sgid_idx,
 		       V2_QPC_BYTE_20_SQ_SHIFT_M, V2_QPC_BYTE_20_SQ_SHIFT_S,
-		       ilog2((unsigned int)hr_qp->sq.wqe_cnt));
+		       ilog2(hr_qp->sq.wqe_cnt));
 
 	roce_set_field(context->byte_20_smac_sgid_idx,
 		       V2_QPC_BYTE_20_RQ_SHIFT_M, V2_QPC_BYTE_20_RQ_SHIFT_S,
-		       (hr_qp->ibqp.qp_type == IB_QPT_XRC_INI ||
-		       hr_qp->ibqp.qp_type == IB_QPT_XRC_TGT ||
-		       hr_qp->ibqp.srq) ? 0 :
-		       ilog2((unsigned int)hr_qp->rq.wqe_cnt));
+		       ilog2(hr_qp->rq.wqe_cnt));
 }
 
 static void modify_qp_reset_to_init(struct ib_qp *ibqp,
@@ -3781,17 +3747,16 @@ static int modify_qp_init_to_rtr(struct ib_qp *ibqp,
 
 	roce_set_field(context->byte_12_sq_hop, V2_QPC_BYTE_12_SQ_HOP_NUM_M,
 		       V2_QPC_BYTE_12_SQ_HOP_NUM_S,
-		       hr_dev->caps.wqe_sq_hop_num == HNS_ROCE_HOP_NUM_0 ?
-		       0 : hr_dev->caps.wqe_sq_hop_num);
+		       to_hr_hem_hopnum(hr_dev->caps.wqe_sq_hop_num,
+					hr_qp->sq.wqe_cnt));
 	roce_set_field(qpc_mask->byte_12_sq_hop, V2_QPC_BYTE_12_SQ_HOP_NUM_M,
 		       V2_QPC_BYTE_12_SQ_HOP_NUM_S, 0);
 
 	roce_set_field(context->byte_20_smac_sgid_idx,
 		       V2_QPC_BYTE_20_SGE_HOP_NUM_M,
 		       V2_QPC_BYTE_20_SGE_HOP_NUM_S,
-		       ((ibqp->qp_type == IB_QPT_GSI) ||
-		       hr_qp->sq.max_gs > HNS_ROCE_V2_UC_RC_SGE_NUM_IN_WQE) ?
-		       hr_dev->caps.wqe_sge_hop_num : 0);
+		       to_hr_hem_hopnum(hr_dev->caps.wqe_sge_hop_num,
+					hr_qp->sge.sge_cnt));
 	roce_set_field(qpc_mask->byte_20_smac_sgid_idx,
 		       V2_QPC_BYTE_20_SGE_HOP_NUM_M,
 		       V2_QPC_BYTE_20_SGE_HOP_NUM_S, 0);
@@ -3799,8 +3764,9 @@ static int modify_qp_init_to_rtr(struct ib_qp *ibqp,
 	roce_set_field(context->byte_20_smac_sgid_idx,
 		       V2_QPC_BYTE_20_RQ_HOP_NUM_M,
 		       V2_QPC_BYTE_20_RQ_HOP_NUM_S,
-		       hr_dev->caps.wqe_rq_hop_num == HNS_ROCE_HOP_NUM_0 ?
-		       0 : hr_dev->caps.wqe_rq_hop_num);
+		       to_hr_hem_hopnum(hr_dev->caps.wqe_rq_hop_num,
+					hr_qp->rq.wqe_cnt));
+
 	roce_set_field(qpc_mask->byte_20_smac_sgid_idx,
 		       V2_QPC_BYTE_20_RQ_HOP_NUM_M,
 		       V2_QPC_BYTE_20_RQ_HOP_NUM_S, 0);
@@ -3977,7 +3943,7 @@ static int modify_qp_rtr_to_rts(struct ib_qp *ibqp,
 		return -EINVAL;
 	}
 
-	if (hr_qp->sge.offset) {
+	if (hr_qp->sge.sge_cnt > 0) {
 		page_size = 1 << hr_qp->mtr.hem_cfg.buf_pg_shift;
 		count = hns_roce_mtr_find(hr_dev, &hr_qp->mtr,
 					  hr_qp->sge.offset / page_size,
@@ -4011,15 +3977,12 @@ static int modify_qp_rtr_to_rts(struct ib_qp *ibqp,
 		       V2_QPC_BYTE_168_SQ_CUR_BLK_ADDR_M,
 		       V2_QPC_BYTE_168_SQ_CUR_BLK_ADDR_S, 0);
 
-	context->sq_cur_sge_blk_addr = ((ibqp->qp_type == IB_QPT_GSI) ||
-		       hr_qp->sq.max_gs > HNS_ROCE_V2_UC_RC_SGE_NUM_IN_WQE) ?
-		       cpu_to_le32(to_hr_hw_page_addr(sge_cur_blk)) : 0;
+	context->sq_cur_sge_blk_addr =
+		cpu_to_le32(to_hr_hw_page_addr(sge_cur_blk));
 	roce_set_field(context->byte_184_irrl_idx,
 		       V2_QPC_BYTE_184_SQ_CUR_SGE_BLK_ADDR_M,
 		       V2_QPC_BYTE_184_SQ_CUR_SGE_BLK_ADDR_S,
-		       ((ibqp->qp_type == IB_QPT_GSI) || hr_qp->sq.max_gs >
-		       HNS_ROCE_V2_UC_RC_SGE_NUM_IN_WQE) ?
-		       upper_32_bits(to_hr_hw_page_addr(sge_cur_blk)) : 0);
+		       upper_32_bits(to_hr_hw_page_addr(sge_cur_blk)));
 	qpc_mask->sq_cur_sge_blk_addr = 0;
 	roce_set_field(qpc_mask->byte_184_irrl_idx,
 		       V2_QPC_BYTE_184_SQ_CUR_SGE_BLK_ADDR_M,
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index d05d3cb..b570759 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -355,16 +355,16 @@ static void free_qpn(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
 	hns_roce_bitmap_free_range(&qp_table->bitmap, hr_qp->qpn, 1, BITMAP_RR);
 }
 
-static int set_rq_size(struct hns_roce_dev *hr_dev,
-				struct ib_qp_cap *cap, bool is_user, int has_rq,
-				struct hns_roce_qp *hr_qp)
+static int set_rq_size(struct hns_roce_dev *hr_dev, struct ib_qp_cap *cap,
+		       struct hns_roce_qp *hr_qp, int has_rq)
 {
-	u32 max_cnt;
+	u32 cnt;
 
 	/* If srq exist, set zero for relative number of rq */
 	if (!has_rq) {
 		hr_qp->rq.wqe_cnt = 0;
 		hr_qp->rq.max_gs = 0;
+		hr_qp->rq_inl_buf.wqe_cnt = 0;
 		cap->max_recv_wr = 0;
 		cap->max_recv_sge = 0;
 
@@ -379,17 +379,14 @@ static int set_rq_size(struct hns_roce_dev *hr_dev,
 		return -EINVAL;
 	}
 
-	max_cnt = max(cap->max_recv_wr, hr_dev->caps.min_wqes);
-
-	hr_qp->rq.wqe_cnt = roundup_pow_of_two(max_cnt);
-	if ((u32)hr_qp->rq.wqe_cnt > hr_dev->caps.max_wqes) {
+	cnt = roundup_pow_of_two(max(cap->max_recv_wr, hr_dev->caps.min_wqes));
+	if (cnt > hr_dev->caps.max_wqes) {
 		ibdev_err(&hr_dev->ib_dev, "rq depth %u too large\n",
 			  cap->max_recv_wr);
 		return -EINVAL;
 	}
 
-	max_cnt = max(1U, cap->max_recv_sge);
-	hr_qp->rq.max_gs = roundup_pow_of_two(max_cnt);
+	hr_qp->rq.max_gs = roundup_pow_of_two(max(1U, cap->max_recv_sge));
 
 	if (hr_dev->caps.max_rq_sg <= HNS_ROCE_SGE_IN_WQE)
 		hr_qp->rq.wqe_shift = ilog2(hr_dev->caps.max_rq_desc_sz);
@@ -397,12 +394,61 @@ static int set_rq_size(struct hns_roce_dev *hr_dev,
 		hr_qp->rq.wqe_shift = ilog2(hr_dev->caps.max_rq_desc_sz *
 					    hr_qp->rq.max_gs);
 
-	cap->max_recv_wr = hr_qp->rq.wqe_cnt;
+	hr_qp->rq.wqe_cnt = cnt;
+	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RQ_INLINE)
+		hr_qp->rq_inl_buf.wqe_cnt = cnt;
+	else
+		hr_qp->rq_inl_buf.wqe_cnt = 0;
+
+	cap->max_recv_wr = cnt;
 	cap->max_recv_sge = hr_qp->rq.max_gs;
 
 	return 0;
 }
 
+static int set_extend_sge_param(struct hns_roce_dev *hr_dev, u32 sq_wqe_cnt,
+				struct hns_roce_qp *hr_qp,
+				struct ib_qp_cap *cap)
+{
+	struct ib_device *ibdev = &hr_dev->ib_dev;
+	u32 cnt;
+
+	cnt = max(1U, cap->max_send_sge);
+	if (hr_dev->hw_rev == HNS_ROCE_HW_VER1) {
+		hr_qp->sq.max_gs = roundup_pow_of_two(cnt);
+		hr_qp->sge.sge_cnt = 0;
+
+		return 0;
+	}
+
+	hr_qp->sq.max_gs = cnt;
+
+	/* UD sqwqe's sge use extend sge */
+	if (hr_qp->ibqp.qp_type == IB_QPT_GSI ||
+	    hr_qp->ibqp.qp_type == IB_QPT_UD) {
+		cnt = roundup_pow_of_two(sq_wqe_cnt * hr_qp->sq.max_gs);
+	} else if (hr_qp->sq.max_gs > HNS_ROCE_SGE_IN_WQE) {
+		cnt = roundup_pow_of_two(sq_wqe_cnt *
+				     (hr_qp->sq.max_gs - HNS_ROCE_SGE_IN_WQE));
+
+		if (hr_dev->pci_dev->revision == PCI_REVISION_ID_HIP08_A) {
+			if (cnt > hr_dev->caps.max_extend_sg) {
+				ibdev_err(ibdev,
+					  "failed to check exSGE num, exSGE num = %d.\n",
+					  cnt);
+				return -EINVAL;
+			}
+		}
+	} else {
+		cnt = 0;
+	}
+
+	hr_qp->sge.sge_shift = HNS_ROCE_SGE_SHIFT;
+	hr_qp->sge.sge_cnt = cnt;
+
+	return 0;
+}
+
 static int check_sq_size_with_integrity(struct hns_roce_dev *hr_dev,
 					struct ib_qp_cap *cap,
 					struct hns_roce_ib_create_qp *ucmd)
@@ -430,82 +476,27 @@ static int set_user_sq_size(struct hns_roce_dev *hr_dev,
 			    struct ib_qp_cap *cap, struct hns_roce_qp *hr_qp,
 			    struct hns_roce_ib_create_qp *ucmd)
 {
-	u32 ex_sge_num;
-	u32 page_size;
-	u32 max_cnt;
+	struct ib_device *ibdev = &hr_dev->ib_dev;
+	u32 cnt = 0;
 	int ret;
 
-	if (check_shl_overflow(1, ucmd->log_sq_bb_count, &hr_qp->sq.wqe_cnt) ||
-	    hr_qp->sq.wqe_cnt > hr_dev->caps.max_wqes)
+	if (check_shl_overflow(1, ucmd->log_sq_bb_count, &cnt) ||
+	    cnt > hr_dev->caps.max_wqes)
 		return -EINVAL;
 
 	ret = check_sq_size_with_integrity(hr_dev, cap, ucmd);
 	if (ret) {
-		ibdev_err(&hr_dev->ib_dev, "Failed to check user SQ size limit\n");
+		ibdev_err(ibdev, "failed to check user SQ size, ret = %d.\n",
+			  ret);
 		return ret;
 	}
 
-	hr_qp->sq.wqe_shift = ucmd->log_sq_stride;
-
-	max_cnt = max(1U, cap->max_send_sge);
-	if (hr_dev->hw_rev == HNS_ROCE_HW_VER1)
-		hr_qp->sq.max_gs = roundup_pow_of_two(max_cnt);
-	else
-		hr_qp->sq.max_gs = max_cnt;
-
-	if (hr_qp->sq.max_gs > HNS_ROCE_SGE_IN_WQE)
-		hr_qp->sge.sge_cnt = roundup_pow_of_two(hr_qp->sq.wqe_cnt *
-							(hr_qp->sq.max_gs - 2));
-
-	if (hr_qp->sq.max_gs > HNS_ROCE_SGE_IN_WQE &&
-	    hr_dev->pci_dev->revision == PCI_REVISION_ID_HIP08_A) {
-		if (hr_qp->sge.sge_cnt > hr_dev->caps.max_extend_sg) {
-			ibdev_err(&hr_dev->ib_dev,
-				  "Failed to check extended SGE size limit %d\n",
-				  hr_qp->sge.sge_cnt);
-			return -EINVAL;
-		}
-	}
-
-	hr_qp->sge.sge_shift = 4;
-	ex_sge_num = hr_qp->sge.sge_cnt;
+	ret = set_extend_sge_param(hr_dev, cnt, hr_qp, cap);
+	if (ret)
+		return ret;
 
-	/* Get buf size, SQ and RQ  are aligned to page_szie */
-	if (hr_dev->hw_rev == HNS_ROCE_HW_VER1) {
-		hr_qp->buff_size = round_up((hr_qp->rq.wqe_cnt <<
-					     hr_qp->rq.wqe_shift), PAGE_SIZE) +
-				   round_up((hr_qp->sq.wqe_cnt <<
-					     hr_qp->sq.wqe_shift), PAGE_SIZE);
-
-		hr_qp->sq.offset = 0;
-		hr_qp->rq.offset = round_up((hr_qp->sq.wqe_cnt <<
-					     hr_qp->sq.wqe_shift), PAGE_SIZE);
-	} else {
-		page_size = 1 << (hr_dev->caps.mtt_buf_pg_sz + PAGE_SHIFT);
-		hr_qp->sge.sge_cnt = ex_sge_num ?
-		   max(page_size / (1 << hr_qp->sge.sge_shift), ex_sge_num) : 0;
-		hr_qp->buff_size = round_up((hr_qp->rq.wqe_cnt <<
-					     hr_qp->rq.wqe_shift), page_size) +
-				   round_up((hr_qp->sge.sge_cnt <<
-					     hr_qp->sge.sge_shift), page_size) +
-				   round_up((hr_qp->sq.wqe_cnt <<
-					     hr_qp->sq.wqe_shift), page_size);
-
-		hr_qp->sq.offset = 0;
-		if (ex_sge_num) {
-			hr_qp->sge.offset = round_up((hr_qp->sq.wqe_cnt <<
-						      hr_qp->sq.wqe_shift),
-						     page_size);
-			hr_qp->rq.offset = hr_qp->sge.offset +
-					   round_up((hr_qp->sge.sge_cnt <<
-						     hr_qp->sge.sge_shift),
-						    page_size);
-		} else {
-			hr_qp->rq.offset = round_up((hr_qp->sq.wqe_cnt <<
-						     hr_qp->sq.wqe_shift),
-						    page_size);
-		}
-	}
+	hr_qp->sq.wqe_shift = ucmd->log_sq_stride;
+	hr_qp->sq.wqe_cnt = cnt;
 
 	return 0;
 }
@@ -514,84 +505,50 @@ static int split_wqe_buf_region(struct hns_roce_dev *hr_dev,
 				struct hns_roce_qp *hr_qp,
 				struct hns_roce_buf_attr *buf_attr)
 {
-	bool is_extend_sge;
 	int buf_size;
 	int idx = 0;
 
-	if (hr_qp->buff_size < 1)
-		return -EINVAL;
-
-	buf_attr->page_shift = PAGE_ADDR_SHIFT + hr_dev->caps.mtt_buf_pg_sz;
-	buf_attr->fixed_page = true;
-	buf_attr->region_count = 0;
-
-	if (hr_qp->sge.sge_cnt > 0)
-		is_extend_sge = true;
-	else
-		is_extend_sge = false;
+	hr_qp->buff_size = 0;
 
 	/* SQ WQE */
-	if (is_extend_sge)
-		buf_size = hr_qp->sge.offset - hr_qp->sq.offset;
-	else
-		buf_size = hr_qp->rq.offset - hr_qp->sq.offset;
-
+	hr_qp->sq.offset = 0;
+	buf_size = to_hr_hem_entries_size(hr_qp->sq.wqe_cnt,
+					  hr_qp->sq.wqe_shift);
 	if (buf_size > 0 && idx < ARRAY_SIZE(buf_attr->region)) {
 		buf_attr->region[idx].size = buf_size;
 		buf_attr->region[idx].hopnum = hr_dev->caps.wqe_sq_hop_num;
 		idx++;
+		hr_qp->buff_size += buf_size;
 	}
 
-	/* extend SGE in SQ WQE */
-	buf_size = hr_qp->rq.offset - hr_qp->sge.offset;
-	if (buf_size > 0 && is_extend_sge &&
-	    idx < ARRAY_SIZE(buf_attr->region)) {
+	/* extend SGE WQE in SQ */
+	hr_qp->sge.offset = hr_qp->buff_size;
+	buf_size = to_hr_hem_entries_size(hr_qp->sge.sge_cnt,
+					  hr_qp->sge.sge_shift);
+	if (buf_size > 0 && idx < ARRAY_SIZE(buf_attr->region)) {
 		buf_attr->region[idx].size = buf_size;
-		buf_attr->region[idx].hopnum =
-					hr_dev->caps.wqe_sge_hop_num;
+		buf_attr->region[idx].hopnum = hr_dev->caps.wqe_sge_hop_num;
 		idx++;
+		hr_qp->buff_size += buf_size;
 	}
 
 	/* RQ WQE */
-	buf_size = hr_qp->buff_size - hr_qp->rq.offset;
+	hr_qp->rq.offset = hr_qp->buff_size;
+	buf_size = to_hr_hem_entries_size(hr_qp->rq.wqe_cnt,
+					  hr_qp->rq.wqe_shift);
 	if (buf_size > 0 && idx < ARRAY_SIZE(buf_attr->region)) {
 		buf_attr->region[idx].size = buf_size;
 		buf_attr->region[idx].hopnum = hr_dev->caps.wqe_rq_hop_num;
 		idx++;
+		hr_qp->buff_size += buf_size;
 	}
 
-	buf_attr->region_count = idx;
-
-	return 0;
-}
-
-static int set_extend_sge_param(struct hns_roce_dev *hr_dev,
-				struct hns_roce_qp *hr_qp)
-{
-	struct device *dev = hr_dev->dev;
-
-	if (hr_qp->sq.max_gs > 2) {
-		hr_qp->sge.sge_cnt = roundup_pow_of_two(hr_qp->sq.wqe_cnt *
-				     (hr_qp->sq.max_gs - 2));
-		hr_qp->sge.sge_shift = 4;
-	}
-
-	/* ud sqwqe's sge use extend sge */
-	if (hr_dev->hw_rev != HNS_ROCE_HW_VER1 &&
-	    hr_qp->ibqp.qp_type == IB_QPT_GSI) {
-		hr_qp->sge.sge_cnt = roundup_pow_of_two(hr_qp->sq.wqe_cnt *
-				     hr_qp->sq.max_gs);
-		hr_qp->sge.sge_shift = 4;
-	}
+	if (hr_qp->buff_size < 1)
+		return -EINVAL;
 
-	if (hr_qp->sq.max_gs > 2 &&
-	    hr_dev->pci_dev->revision == PCI_REVISION_ID_HIP08_A) {
-		if (hr_qp->sge.sge_cnt > hr_dev->caps.max_extend_sg) {
-			dev_err(dev, "The extended sge cnt error! sge_cnt=%d\n",
-				hr_qp->sge.sge_cnt);
-			return -EINVAL;
-		}
-	}
+	buf_attr->page_shift = PAGE_ADDR_SHIFT + hr_dev->caps.mtt_buf_pg_sz;
+	buf_attr->fixed_page = true;
+	buf_attr->region_count = idx;
 
 	return 0;
 }
@@ -599,62 +556,35 @@ static int set_extend_sge_param(struct hns_roce_dev *hr_dev,
 static int set_kernel_sq_size(struct hns_roce_dev *hr_dev,
 			      struct ib_qp_cap *cap, struct hns_roce_qp *hr_qp)
 {
-	u32 page_size;
-	u32 max_cnt;
-	int size;
+	struct ib_device *ibdev = &hr_dev->ib_dev;
+	u32 cnt;
 	int ret;
 
 	if (!cap->max_send_wr || cap->max_send_wr > hr_dev->caps.max_wqes ||
 	    cap->max_send_sge > hr_dev->caps.max_sq_sg ||
 	    cap->max_inline_data > hr_dev->caps.max_sq_inline) {
-		ibdev_err(&hr_dev->ib_dev,
-			  "SQ WR or sge or inline data error!\n");
+		ibdev_err(ibdev,
+			  "failed to check SQ WR, SGE or inline num, ret = %d.\n",
+			  -EINVAL);
 		return -EINVAL;
 	}
 
-	hr_qp->sq.wqe_shift = ilog2(hr_dev->caps.max_sq_desc_sz);
-
-	max_cnt = max(cap->max_send_wr, hr_dev->caps.min_wqes);
-
-	hr_qp->sq.wqe_cnt = roundup_pow_of_two(max_cnt);
-	if ((u32)hr_qp->sq.wqe_cnt > hr_dev->caps.max_wqes) {
-		ibdev_err(&hr_dev->ib_dev,
-			  "while setting kernel sq size, sq.wqe_cnt too large\n");
+	cnt = roundup_pow_of_two(max(cap->max_send_wr, hr_dev->caps.min_wqes));
+	if (cnt > hr_dev->caps.max_wqes) {
+		ibdev_err(ibdev, "failed to check WQE num, WQE num = %d.\n",
+			  cnt);
 		return -EINVAL;
 	}
 
-	/* Get data_seg numbers */
-	max_cnt = max(1U, cap->max_send_sge);
-	if (hr_dev->hw_rev == HNS_ROCE_HW_VER1)
-		hr_qp->sq.max_gs = roundup_pow_of_two(max_cnt);
-	else
-		hr_qp->sq.max_gs = max_cnt;
+	hr_qp->sq.wqe_shift = ilog2(hr_dev->caps.max_sq_desc_sz);
+	hr_qp->sq.wqe_cnt = cnt;
 
-	ret = set_extend_sge_param(hr_dev, hr_qp);
-	if (ret) {
-		ibdev_err(&hr_dev->ib_dev, "set extend sge parameters fail\n");
+	ret = set_extend_sge_param(hr_dev, cnt, hr_qp, cap);
+	if (ret)
 		return ret;
-	}
 
-	/* Get buf size, SQ and RQ are aligned to PAGE_SIZE */
-	page_size = 1 << (hr_dev->caps.mtt_buf_pg_sz + PAGE_SHIFT);
-	hr_qp->sq.offset = 0;
-	size = round_up(hr_qp->sq.wqe_cnt << hr_qp->sq.wqe_shift, page_size);
-
-	if (hr_dev->hw_rev != HNS_ROCE_HW_VER1 && hr_qp->sge.sge_cnt) {
-		hr_qp->sge.sge_cnt = max(page_size/(1 << hr_qp->sge.sge_shift),
-					 (u32)hr_qp->sge.sge_cnt);
-		hr_qp->sge.offset = size;
-		size += round_up(hr_qp->sge.sge_cnt << hr_qp->sge.sge_shift,
-				 page_size);
-	}
-
-	hr_qp->rq.offset = size;
-	size += round_up((hr_qp->rq.wqe_cnt << hr_qp->rq.wqe_shift), page_size);
-	hr_qp->buff_size = size;
-
-	/* Get wr and sge number which send */
-	cap->max_send_wr = hr_qp->sq.wqe_cnt;
+	/* sync the parameters of kernel QP to user's configuration */
+	cap->max_send_wr = cnt;
 	cap->max_send_sge = hr_qp->sq.max_gs;
 
 	/* We don't support inline sends for kernel QPs (yet) */
@@ -685,8 +615,8 @@ static int alloc_rq_inline_buf(struct hns_roce_qp *hr_qp,
 			       struct ib_qp_init_attr *init_attr)
 {
 	u32 max_recv_sge = init_attr->cap.max_recv_sge;
+	u32 wqe_cnt = hr_qp->rq_inl_buf.wqe_cnt;
 	struct hns_roce_rinl_wqe *wqe_list;
-	u32 wqe_cnt = hr_qp->rq.wqe_cnt;
 	int i;
 
 	/* allocate recv inline buf */
@@ -708,7 +638,6 @@ static int alloc_rq_inline_buf(struct hns_roce_qp *hr_qp,
 		wqe_list[i].sg_list = &wqe_list[0].sg_list[i * max_recv_sge];
 
 	hr_qp->rq_inl_buf.wqe_list = wqe_list;
-	hr_qp->rq_inl_buf.wqe_cnt = wqe_cnt;
 
 	return 0;
 
@@ -721,7 +650,8 @@ static int alloc_rq_inline_buf(struct hns_roce_qp *hr_qp,
 
 static void free_rq_inline_buf(struct hns_roce_qp *hr_qp)
 {
-	kfree(hr_qp->rq_inl_buf.wqe_list[0].sg_list);
+	if (hr_qp->rq_inl_buf.wqe_list)
+		kfree(hr_qp->rq_inl_buf.wqe_list[0].sg_list);
 	kfree(hr_qp->rq_inl_buf.wqe_list);
 }
 
@@ -731,36 +661,36 @@ static int alloc_qp_buf(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 {
 	struct ib_device *ibdev = &hr_dev->ib_dev;
 	struct hns_roce_buf_attr buf_attr = {};
-	bool is_rq_buf_inline;
 	int ret;
 
-	is_rq_buf_inline = (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RQ_INLINE) &&
-			   hns_roce_qp_has_rq(init_attr);
-	if (is_rq_buf_inline) {
+	if (!udata && hr_qp->rq_inl_buf.wqe_cnt) {
 		ret = alloc_rq_inline_buf(hr_qp, init_attr);
 		if (ret) {
-			ibdev_err(ibdev, "Failed to alloc inline RQ buffer\n");
+			ibdev_err(ibdev,
+				  "failed to alloc inline buf, ret = %d.\n",
+				  ret);
 			return ret;
 		}
+	} else {
+		hr_qp->rq_inl_buf.wqe_list = NULL;
 	}
 
 	ret = split_wqe_buf_region(hr_dev, hr_qp, &buf_attr);
 	if (ret) {
-		ibdev_err(ibdev, "Failed to split WQE buf, ret %d\n", ret);
+		ibdev_err(ibdev, "failed to split WQE buf, ret = %d.\n", ret);
 		goto err_inline;
 	}
 	ret = hns_roce_mtr_create(hr_dev, &hr_qp->mtr, &buf_attr,
 				  PAGE_ADDR_SHIFT + hr_dev->caps.mtt_ba_pg_sz,
 				  udata, addr);
 	if (ret) {
-		ibdev_err(ibdev, "Failed to create WQE mtr, ret %d\n", ret);
+		ibdev_err(ibdev, "failed to create WQE mtr, ret = %d.\n", ret);
 		goto err_inline;
 	}
 
 	return 0;
 err_inline:
-	if (is_rq_buf_inline)
-		free_rq_inline_buf(hr_qp);
+	free_rq_inline_buf(hr_qp);
 
 	return ret;
 }
@@ -768,9 +698,7 @@ static int alloc_qp_buf(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 static void free_qp_buf(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
 {
 	hns_roce_mtr_destroy(hr_dev, &hr_qp->mtr);
-	if ((hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RQ_INLINE) &&
-	     hr_qp->rq.wqe_cnt)
-		free_rq_inline_buf(hr_qp);
+	free_rq_inline_buf(hr_qp);
 }
 
 static inline bool user_qp_has_sdb(struct hns_roce_dev *hr_dev,
@@ -935,10 +863,11 @@ static int set_qp_param(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 	else
 		hr_qp->sq_signal_bits = IB_SIGNAL_REQ_WR;
 
-	ret = set_rq_size(hr_dev, &init_attr->cap, udata,
-			  hns_roce_qp_has_rq(init_attr), hr_qp);
+	ret = set_rq_size(hr_dev, &init_attr->cap, hr_qp,
+			  hns_roce_qp_has_rq(init_attr));
 	if (ret) {
-		ibdev_err(ibdev, "Failed to set user RQ size\n");
+		ibdev_err(ibdev, "failed to set user RQ size, ret = %d.\n",
+			  ret);
 		return ret;
 	}
 
-- 
2.8.1

