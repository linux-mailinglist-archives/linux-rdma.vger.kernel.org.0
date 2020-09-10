Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA2DF2646DD
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Sep 2020 15:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730068AbgIJNYD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Sep 2020 09:24:03 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:53584 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730694AbgIJNWY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 10 Sep 2020 09:22:24 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0BB16AD385CFA7B6CDCC;
        Thu, 10 Sep 2020 21:22:22 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Thu, 10 Sep 2020 21:22:15 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next] RDMA/hns: Support inline data in extented sge space for RC
Date:   Thu, 10 Sep 2020 21:21:09 +0800
Message-ID: <1599744069-9968-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

HIP08 supports RC inline up to size of 32 Bytes, and all data should be
put into SQWQE. For HIP09, this capability is extended to 1024 Bytes, if
length of data is longer than 32 Bytes, they will be filled into extended
sge space.

Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h |   2 +
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 196 +++++++++++++++++++++-------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |   3 +
 drivers/infiniband/hw/hns/hns_roce_qp.c     |  13 +-
 4 files changed, 162 insertions(+), 52 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 30290a7..7b55c69 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -656,6 +656,8 @@ struct hns_roce_qp {
 
 	struct hns_roce_sge	sge;
 	u32			next_sge;
+	enum ib_mtu		path_mtu;
+	u32			max_inline_data;
 
 	/* 0: flush needed, 1: unneeded */
 	unsigned long		flush_flag;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 3966262..a580ba7 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -153,6 +153,67 @@ static void set_atomic_seg(const struct ib_send_wr *wr,
 		       V2_RC_SEND_WQE_BYTE_16_SGE_NUM_S, valid_num_sge);
 }
 
+static int fill_ext_sge_inl_data(struct hns_roce_qp *qp,
+				 const struct ib_send_wr *wr,
+				 unsigned int *sge_idx, u32 msg_len)
+{
+	struct ib_device *ibdev = &(to_hr_dev(qp->ibqp.device))->ib_dev;
+	unsigned int dseg_len = sizeof(struct hns_roce_v2_wqe_data_seg);
+	unsigned int ext_sge_sz = qp->sq.max_gs * dseg_len;
+	unsigned int left_len_in_pg;
+	unsigned int idx = *sge_idx;
+	unsigned int i = 0;
+	unsigned int len;
+	void *addr;
+	void *dseg;
+
+	if (msg_len > ext_sge_sz) {
+		ibdev_err(ibdev,
+			  "no enough extended sge space for inline data.\n");
+		return -EINVAL;
+	}
+
+	dseg = hns_roce_get_extend_sge(qp, idx & (qp->sge.sge_cnt - 1));
+	left_len_in_pg = hr_hw_page_align((uintptr_t)dseg) - (uintptr_t)dseg;
+	len = wr->sg_list[0].length;
+	addr = (void *)(unsigned long)(wr->sg_list[0].addr);
+
+	/* When copying data to extended sge space, the left length in page may
+	 * not long enough for current user's sge. So the data should be
+	 * splited into several parts, one in the first page, and the others in
+	 * the subsequent pages.
+	 */
+	while (1) {
+		if (len <= left_len_in_pg) {
+			memcpy(dseg, addr, len);
+
+			idx += len / dseg_len;
+
+			i++;
+			if (i >= wr->num_sge)
+				break;
+
+			left_len_in_pg -= len;
+			len = wr->sg_list[i].length;
+			addr = (void *)(unsigned long)(wr->sg_list[i].addr);
+			dseg += len;
+		} else {
+			memcpy(dseg, addr, left_len_in_pg);
+
+			len -= left_len_in_pg;
+			addr += left_len_in_pg;
+			idx += left_len_in_pg / dseg_len;
+			dseg = hns_roce_get_extend_sge(qp,
+						idx & (qp->sge.sge_cnt - 1));
+			left_len_in_pg = 1 << HNS_HW_PAGE_SHIFT;
+		}
+	}
+
+	*sge_idx = idx;
+
+	return 0;
+}
+
 static void set_extend_sge(struct hns_roce_qp *qp, const struct ib_send_wr *wr,
 			   unsigned int *sge_ind, unsigned int valid_num_sge)
 {
@@ -177,73 +238,115 @@ static void set_extend_sge(struct hns_roce_qp *qp, const struct ib_send_wr *wr,
 	*sge_ind = idx;
 }
 
+static bool check_inl_data_len(struct hns_roce_qp *qp, unsigned int len)
+{
+	struct hns_roce_dev *hr_dev = to_hr_dev(qp->ibqp.device);
+	int mtu = ib_mtu_enum_to_int(qp->path_mtu);
+
+	if (len > qp->max_inline_data || len > mtu) {
+		ibdev_err(&hr_dev->ib_dev,
+			  "invalid length of data, data len = %u, max inline len = %u, path mtu = %d.\n",
+			  len, qp->max_inline_data, mtu);
+		return false;
+	}
+
+	return true;
+}
+
+static int set_rc_inl(struct hns_roce_qp *qp, const struct ib_send_wr *wr,
+		      struct hns_roce_v2_rc_send_wqe *rc_sq_wqe,
+		      unsigned int *sge_idx)
+{
+	struct hns_roce_dev *hr_dev = to_hr_dev(qp->ibqp.device);
+	u32 msg_len = le32_to_cpu(rc_sq_wqe->msg_len);
+	struct ib_device *ibdev = &hr_dev->ib_dev;
+	unsigned int curr_idx = *sge_idx;
+	void *dseg = rc_sq_wqe;
+	unsigned int i;
+	int ret;
+
+	if (unlikely(wr->opcode == IB_WR_RDMA_READ)) {
+		ibdev_err(ibdev, "invalid inline parameters!\n");
+		return -EINVAL;
+	}
+
+	if (!check_inl_data_len(qp, msg_len))
+		return -EINVAL;
+
+	dseg += sizeof(struct hns_roce_v2_rc_send_wqe);
+
+	roce_set_bit(rc_sq_wqe->byte_4, V2_RC_SEND_WQE_BYTE_4_INLINE_S, 1);
+
+	if (msg_len <= HNS_ROCE_V2_MAX_RC_INL_INN_SZ) {
+		roce_set_bit(rc_sq_wqe->byte_20,
+			     V2_RC_SEND_WQE_BYTE_20_INL_TYPE_S, 0);
+
+		for (i = 0; i < wr->num_sge; i++) {
+			memcpy(dseg, ((void *)wr->sg_list[i].addr),
+			       wr->sg_list[i].length);
+			dseg += wr->sg_list[i].length;
+		}
+	} else {
+		roce_set_bit(rc_sq_wqe->byte_20,
+			     V2_RC_SEND_WQE_BYTE_20_INL_TYPE_S, 1);
+
+		ret = fill_ext_sge_inl_data(qp, wr, &curr_idx, msg_len);
+		if (ret)
+			return ret;
+
+		roce_set_field(rc_sq_wqe->byte_16,
+			       V2_RC_SEND_WQE_BYTE_16_SGE_NUM_M,
+			       V2_RC_SEND_WQE_BYTE_16_SGE_NUM_S,
+			       curr_idx - *sge_idx);
+	}
+
+	*sge_idx = curr_idx;
+
+	return 0;
+}
+
 static int set_rwqe_data_seg(struct ib_qp *ibqp, const struct ib_send_wr *wr,
 			     struct hns_roce_v2_rc_send_wqe *rc_sq_wqe,
 			     unsigned int *sge_ind,
 			     unsigned int valid_num_sge)
 {
-	struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
 	struct hns_roce_v2_wqe_data_seg *dseg =
 		(void *)rc_sq_wqe + sizeof(struct hns_roce_v2_rc_send_wqe);
-	struct ib_device *ibdev = &hr_dev->ib_dev;
 	struct hns_roce_qp *qp = to_hr_qp(ibqp);
-	void *wqe = dseg;
 	int j = 0;
 	int i;
 
-	if (wr->send_flags & IB_SEND_INLINE && valid_num_sge) {
-		if (unlikely(le32_to_cpu(rc_sq_wqe->msg_len) >
-			     hr_dev->caps.max_sq_inline)) {
-			ibdev_err(ibdev, "inline len(1-%d)=%d, illegal",
-				  rc_sq_wqe->msg_len,
-				  hr_dev->caps.max_sq_inline);
-			return -EINVAL;
-		}
+	roce_set_field(rc_sq_wqe->byte_20,
+		       V2_RC_SEND_WQE_BYTE_20_MSG_START_SGE_IDX_M,
+		       V2_RC_SEND_WQE_BYTE_20_MSG_START_SGE_IDX_S,
+		       (*sge_ind) & (qp->sge.sge_cnt - 1));
 
-		if (unlikely(wr->opcode == IB_WR_RDMA_READ)) {
-			ibdev_err(ibdev, "Not support inline data!\n");
-			return -EINVAL;
-		}
+	if (wr->send_flags & IB_SEND_INLINE)
+		return set_rc_inl(qp, wr, rc_sq_wqe, sge_ind);
 
+	if (valid_num_sge <= HNS_ROCE_SGE_IN_WQE) {
 		for (i = 0; i < wr->num_sge; i++) {
-			memcpy(wqe, ((void *)wr->sg_list[i].addr),
-			       wr->sg_list[i].length);
-			wqe += wr->sg_list[i].length;
+			if (likely(wr->sg_list[i].length)) {
+				set_data_seg_v2(dseg, wr->sg_list + i);
+				dseg++;
+			}
 		}
-
-		roce_set_bit(rc_sq_wqe->byte_4, V2_RC_SEND_WQE_BYTE_4_INLINE_S,
-			     1);
 	} else {
-		if (valid_num_sge <= HNS_ROCE_SGE_IN_WQE) {
-			for (i = 0; i < wr->num_sge; i++) {
-				if (likely(wr->sg_list[i].length)) {
-					set_data_seg_v2(dseg, wr->sg_list + i);
-					dseg++;
-				}
+		for (i = 0; i < wr->num_sge && j < HNS_ROCE_SGE_IN_WQE; i++) {
+			if (likely(wr->sg_list[i].length)) {
+				set_data_seg_v2(dseg, wr->sg_list + i);
+				dseg++;
+				j++;
 			}
-		} else {
-			roce_set_field(rc_sq_wqe->byte_20,
-				     V2_RC_SEND_WQE_BYTE_20_MSG_START_SGE_IDX_M,
-				     V2_RC_SEND_WQE_BYTE_20_MSG_START_SGE_IDX_S,
-				     (*sge_ind) & (qp->sge.sge_cnt - 1));
-
-			for (i = 0; i < wr->num_sge && j < HNS_ROCE_SGE_IN_WQE;
-			     i++) {
-				if (likely(wr->sg_list[i].length)) {
-					set_data_seg_v2(dseg, wr->sg_list + i);
-					dseg++;
-					j++;
-				}
-			}
-
-			set_extend_sge(qp, wr, sge_ind, valid_num_sge);
 		}
 
-		roce_set_field(rc_sq_wqe->byte_16,
-			       V2_RC_SEND_WQE_BYTE_16_SGE_NUM_M,
-			       V2_RC_SEND_WQE_BYTE_16_SGE_NUM_S, valid_num_sge);
+		set_extend_sge(qp, wr, sge_ind, valid_num_sge);
 	}
 
+	roce_set_field(rc_sq_wqe->byte_16,
+		       V2_RC_SEND_WQE_BYTE_16_SGE_NUM_M,
+		       V2_RC_SEND_WQE_BYTE_16_SGE_NUM_S, valid_num_sge);
+
 	return 0;
 }
 
@@ -4052,6 +4155,7 @@ static int modify_qp_init_to_rtr(struct ib_qp *ibqp,
 		       V2_QPC_BYTE_52_DMAC_S, 0);
 
 	mtu = get_mtu(ibqp, attr);
+	hr_qp->path_mtu = mtu;
 
 	if (attr_mask & IB_QP_PATH_MTU) {
 		roce_set_field(context->byte_24_mtu_tc, V2_QPC_BYTE_24_MTU_M,
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index ac29be4..8673d21 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -60,6 +60,7 @@
 #define HNS_ROCE_V2_MAX_SQ_SGE_NUM		64
 #define HNS_ROCE_V2_MAX_EXTEND_SGE_NUM		0x200000
 #define HNS_ROCE_V2_MAX_SQ_INLINE		0x20
+#define HNS_ROCE_V2_MAX_RC_INL_INN_SZ		32
 #define HNS_ROCE_V2_UAR_NUM			256
 #define HNS_ROCE_V2_PHY_UAR_NUM			1
 #define HNS_ROCE_V2_MAX_IRQ_NUM			65
@@ -1187,6 +1188,8 @@ struct hns_roce_v2_rc_send_wqe {
 #define V2_RC_SEND_WQE_BYTE_20_MSG_START_SGE_IDX_S 0
 #define V2_RC_SEND_WQE_BYTE_20_MSG_START_SGE_IDX_M GENMASK(23, 0)
 
+#define V2_RC_SEND_WQE_BYTE_20_INL_TYPE_S 31
+
 struct hns_roce_wqe_frmr_seg {
 	__le32	pbl_size;
 	__le32	mode_buf_pg_sz;
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 975281f..bfd513d 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -551,10 +551,9 @@ static int set_kernel_sq_size(struct hns_roce_dev *hr_dev,
 	int ret;
 
 	if (!cap->max_send_wr || cap->max_send_wr > hr_dev->caps.max_wqes ||
-	    cap->max_send_sge > hr_dev->caps.max_sq_sg ||
-	    cap->max_inline_data > hr_dev->caps.max_sq_inline) {
+	    cap->max_send_sge > hr_dev->caps.max_sq_sg) {
 		ibdev_err(ibdev,
-			  "failed to check SQ WR, SGE or inline num, ret = %d.\n",
+			  "failed to check SQ WR or SGE num, ret = %d.\n",
 			  -EINVAL);
 		return -EINVAL;
 	}
@@ -577,9 +576,6 @@ static int set_kernel_sq_size(struct hns_roce_dev *hr_dev,
 	cap->max_send_wr = cnt;
 	cap->max_send_sge = hr_qp->sq.max_gs;
 
-	/* We don't support inline sends for kernel QPs (yet) */
-	cap->max_inline_data = 0;
-
 	return 0;
 }
 
@@ -847,6 +843,11 @@ static int set_qp_param(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 
 	hr_qp->ibqp.qp_type = init_attr->qp_type;
 
+	if (init_attr->cap.max_inline_data > hr_dev->caps.max_sq_inline)
+		init_attr->cap.max_inline_data = hr_dev->caps.max_sq_inline;
+
+	hr_qp->max_inline_data = init_attr->cap.max_inline_data;
+
 	if (init_attr->sq_sig_type == IB_SIGNAL_ALL_WR)
 		hr_qp->sq_signal_bits = IB_SIGNAL_ALL_WR;
 	else
-- 
2.8.1

