Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE152A0482
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Oct 2020 12:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgJ3LlP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 30 Oct 2020 07:41:15 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7114 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbgJ3LlP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 30 Oct 2020 07:41:15 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CN0kZ3nsczLn4R;
        Fri, 30 Oct 2020 19:41:10 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Fri, 30 Oct 2020 19:41:01 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 8/8] RDMA/hns: Add support for UD inline
Date:   Fri, 30 Oct 2020 19:39:35 +0800
Message-ID: <1604057975-23388-9-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1604057975-23388-1-git-send-email-liweihang@huawei.com>
References: <1604057975-23388-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

HIP09 supports UD inline up to size of 1024 Bytes. When data size is
smaller than 8 bytes, they will be stored in sqwqe. Otherwise, the data
will be filled into extended sges.

Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h |   3 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 111 ++++++++++++++++++++++++++--
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  14 ++++
 drivers/infiniband/hw/hns/hns_roce_qp.c     |   6 ++
 4 files changed, 126 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 23f8fe7..bd19bee 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -133,6 +133,7 @@ enum hns_roce_qp_caps {
 	HNS_ROCE_QP_CAP_RQ_RECORD_DB = BIT(0),
 	HNS_ROCE_QP_CAP_SQ_RECORD_DB = BIT(1),
 	HNS_ROCE_QP_CAP_OWNER_DB = BIT(2),
+	HNS_ROCE_QP_CAP_UD_SQ_INL = BIT(3),
 };
 
 enum hns_roce_cq_flags {
@@ -223,8 +224,8 @@ enum {
 	HNS_ROCE_CAP_FLAG_QP_FLOW_CTRL		= BIT(9),
 	HNS_ROCE_CAP_FLAG_ATOMIC		= BIT(10),
 	HNS_ROCE_CAP_FLAG_UD			= BIT(11),
+	HNS_ROCE_CAP_FLAG_UD_SQ_INL		= BIT(13),
 	HNS_ROCE_CAP_FLAG_SDI_MODE		= BIT(14),
-
 };
 
 #define HNS_ROCE_DB_TYPE_COUNT			2
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 29cbf9f..2de9519 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -428,9 +428,6 @@ static int fill_ud_av(struct hns_roce_v2_ud_send_wqe *ud_sq_wqe,
 	struct ib_device *ib_dev = ah->ibah.device;
 	struct hns_roce_dev *hr_dev = to_hr_dev(ib_dev);
 
-	roce_set_field(ud_sq_wqe->byte_24, V2_UD_SEND_WQE_BYTE_24_UDPSPN_M,
-		       V2_UD_SEND_WQE_BYTE_24_UDPSPN_S, ah->av.udp_sport);
-
 	roce_set_field(ud_sq_wqe->byte_36, V2_UD_SEND_WQE_BYTE_36_HOPLIMIT_M,
 		       V2_UD_SEND_WQE_BYTE_36_HOPLIMIT_S, ah->av.hop_limit);
 	roce_set_field(ud_sq_wqe->byte_36, V2_UD_SEND_WQE_BYTE_36_TCLASS_M,
@@ -464,6 +461,90 @@ static int fill_ud_av(struct hns_roce_v2_ud_send_wqe *ud_sq_wqe,
 	return 0;
 }
 
+static void fill_ud_inn_inl_data(const struct ib_send_wr *wr,
+				 struct hns_roce_v2_ud_send_wqe *ud_sq_wqe)
+{
+	u8 data[HNS_ROCE_V2_MAX_UD_INL_INN_SZ] = {0};
+	u32 *loc = (u32 *)data;
+	void *tmp = data;
+	unsigned int i;
+	u32 tmp_data;
+
+	for (i = 0; i < wr->num_sge; i++) {
+		memcpy(tmp, ((void *)wr->sg_list[i].addr),
+		       wr->sg_list[i].length);
+		tmp += wr->sg_list[i].length;
+	}
+
+	roce_set_field(ud_sq_wqe->msg_len,
+		       V2_UD_SEND_WQE_BYTE_8_INL_DATA_15_0_M,
+		       V2_UD_SEND_WQE_BYTE_8_INL_DATA_15_0_S,
+		       *loc & 0xffff);
+
+	roce_set_field(ud_sq_wqe->byte_16,
+		       V2_UD_SEND_WQE_BYTE_16_INL_DATA_23_16_M,
+		       V2_UD_SEND_WQE_BYTE_16_INL_DATA_23_16_S,
+		       (*loc >> 16) & 0xff);
+
+	tmp_data = *loc >> 24;
+	loc++;
+	tmp_data |= ((*loc & 0xffff) << 8);
+
+	roce_set_field(ud_sq_wqe->byte_20,
+		       V2_UD_SEND_WQE_BYTE_20_INL_DATA_47_24_M,
+		       V2_UD_SEND_WQE_BYTE_20_INL_DATA_47_24_S,
+		       tmp_data);
+
+	roce_set_field(ud_sq_wqe->byte_24,
+		       V2_UD_SEND_WQE_BYTE_24_INL_DATA_63_48_M,
+		       V2_UD_SEND_WQE_BYTE_24_INL_DATA_63_48_S,
+		       *loc >> 16);
+}
+
+static int set_ud_inl(struct hns_roce_qp *qp, const struct ib_send_wr *wr,
+		      struct hns_roce_v2_ud_send_wqe *ud_sq_wqe,
+		      unsigned int *sge_idx)
+{
+	struct hns_roce_dev *hr_dev = to_hr_dev(qp->ibqp.device);
+	u32 msg_len = le32_to_cpu(ud_sq_wqe->msg_len);
+	struct ib_device *ibdev = &hr_dev->ib_dev;
+	unsigned int curr_idx = *sge_idx;
+	int ret;
+
+	if (!(qp->en_flags & HNS_ROCE_QP_CAP_UD_SQ_INL)) {
+		ibdev_err(ibdev, "not support UD SQ inline!\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (!check_inl_data_len(qp, msg_len))
+		return -EINVAL;
+
+	roce_set_bit(ud_sq_wqe->byte_4, V2_UD_SEND_WQE_BYTE_4_INL_S, 1);
+
+	if (msg_len <= HNS_ROCE_V2_MAX_UD_INL_INN_SZ) {
+		roce_set_bit(ud_sq_wqe->byte_20,
+			     V2_UD_SEND_WQE_BYTE_20_INL_TYPE_S, 0);
+
+		fill_ud_inn_inl_data(wr, ud_sq_wqe);
+	} else {
+		roce_set_bit(ud_sq_wqe->byte_20,
+			     V2_UD_SEND_WQE_BYTE_20_INL_TYPE_S, 1);
+
+		ret = fill_ext_sge_inl_data(qp, wr, &curr_idx, msg_len);
+		if (ret)
+			return ret;
+
+		roce_set_field(ud_sq_wqe->byte_16,
+			       V2_UD_SEND_WQE_BYTE_16_SGE_NUM_M,
+			       V2_UD_SEND_WQE_BYTE_16_SGE_NUM_S,
+			       curr_idx - *sge_idx);
+	}
+
+	*sge_idx = curr_idx;
+
+	return 0;
+}
+
 static inline int set_ud_wqe(struct hns_roce_qp *qp,
 			     const struct ib_send_wr *wr,
 			     void *wqe, unsigned int *sge_idx,
@@ -494,9 +575,6 @@ static inline int set_ud_wqe(struct hns_roce_qp *qp,
 	roce_set_field(ud_sq_wqe->byte_16, V2_UD_SEND_WQE_BYTE_16_PD_M,
 		       V2_UD_SEND_WQE_BYTE_16_PD_S, to_hr_pd(qp->ibqp.pd)->pdn);
 
-	roce_set_field(ud_sq_wqe->byte_16, V2_UD_SEND_WQE_BYTE_16_SGE_NUM_M,
-		       V2_UD_SEND_WQE_BYTE_16_SGE_NUM_S, valid_num_sge);
-
 	roce_set_field(ud_sq_wqe->byte_20,
 		       V2_UD_SEND_WQE_BYTE_20_MSG_START_SGE_IDX_M,
 		       V2_UD_SEND_WQE_BYTE_20_MSG_START_SGE_IDX_S,
@@ -511,7 +589,23 @@ static inline int set_ud_wqe(struct hns_roce_qp *qp,
 	if (ret)
 		return ret;
 
-	set_extend_sge(qp, wr, &curr_idx, valid_num_sge);
+	if (wr->send_flags & IB_SEND_INLINE) {
+		ret = set_ud_inl(qp, wr, ud_sq_wqe, &curr_idx);
+		if (ret)
+			return ret;
+	} else {
+		roce_set_field(ud_sq_wqe->byte_16,
+			       V2_UD_SEND_WQE_BYTE_16_SGE_NUM_M,
+			       V2_UD_SEND_WQE_BYTE_16_SGE_NUM_S,
+			       valid_num_sge);
+
+		roce_set_field(ud_sq_wqe->byte_24,
+			       V2_UD_SEND_WQE_BYTE_24_UDPSPN_M,
+			       V2_UD_SEND_WQE_BYTE_24_UDPSPN_S,
+			       ah->av.udp_sport);
+
+		set_extend_sge(qp, wr, &curr_idx, valid_num_sge);
+	}
 
 	/*
 	 * The pipeline can sequentially post all valid WQEs into WQ buffer,
@@ -1924,6 +2018,8 @@ static void set_default_caps(struct hns_roce_dev *hr_dev)
 		caps->gmv_buf_pg_sz = 0;
 		caps->gid_table_len[0] = caps->gmv_bt_num * (HNS_HW_PAGE_SIZE /
 					 caps->gmv_entry_sz);
+		caps->flags |= HNS_ROCE_CAP_FLAG_UD_SQ_INL;
+		caps->max_sq_inline = HNS_ROCE_V2_MAX_SQ_INL_EXT;
 	}
 }
 
@@ -5131,6 +5227,7 @@ static int hns_roce_v2_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
 	qp_attr->cur_qp_state = qp_attr->qp_state;
 	qp_attr->cap.max_recv_wr = hr_qp->rq.wqe_cnt;
 	qp_attr->cap.max_recv_sge = hr_qp->rq.max_gs;
+	qp_attr->cap.max_inline_data = hr_qp->max_inline_data;
 
 	if (!ibqp->uobject) {
 		qp_attr->cap.max_send_wr = hr_qp->sq.wqe_cnt;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index c068517..1c1a773 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -61,6 +61,8 @@
 #define HNS_ROCE_V2_MAX_SQ_SGE_NUM		64
 #define HNS_ROCE_V2_MAX_EXTEND_SGE_NUM		0x200000
 #define HNS_ROCE_V2_MAX_SQ_INLINE		0x20
+#define HNS_ROCE_V2_MAX_SQ_INL_EXT		0x400
+#define HNS_ROCE_V2_MAX_UD_INL_INN_SZ		8
 #define HNS_ROCE_V2_MAX_RC_INL_INN_SZ		32
 #define HNS_ROCE_V2_UAR_NUM			256
 #define HNS_ROCE_V2_PHY_UAR_NUM			1
@@ -1126,6 +1128,18 @@ struct hns_roce_v2_ud_send_wqe {
 
 #define	V2_UD_SEND_WQE_BYTE_40_LBI_S 31
 
+#define V2_UD_SEND_WQE_BYTE_4_INL_S 12
+#define V2_UD_SEND_WQE_BYTE_20_INL_TYPE_S 31
+
+#define V2_UD_SEND_WQE_BYTE_8_INL_DATA_15_0_S 16
+#define V2_UD_SEND_WQE_BYTE_8_INL_DATA_15_0_M GENMASK(31, 16)
+#define V2_UD_SEND_WQE_BYTE_16_INL_DATA_23_16_S 24
+#define V2_UD_SEND_WQE_BYTE_16_INL_DATA_23_16_M GENMASK(31, 24)
+#define V2_UD_SEND_WQE_BYTE_20_INL_DATA_47_24_S 0
+#define V2_UD_SEND_WQE_BYTE_20_INL_DATA_47_24_M GENMASK(23, 0)
+#define V2_UD_SEND_WQE_BYTE_24_INL_DATA_63_48_S 0
+#define V2_UD_SEND_WQE_BYTE_24_INL_DATA_63_48_M GENMASK(15, 0)
+
 struct hns_roce_v2_rc_send_wqe {
 	__le32		byte_4;
 	__le32		msg_len;
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 9ffd92a..2dd325c 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -862,6 +862,9 @@ static int set_qp_param(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 		return ret;
 	}
 
+	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_UD_SQ_INL)
+		hr_qp->en_flags |= HNS_ROCE_QP_CAP_UD_SQ_INL;
+
 	if (udata) {
 		if (ib_copy_from_udata(ucmd, udata, sizeof(*ucmd))) {
 			ibdev_err(ibdev, "Failed to copy QP ucmd\n");
@@ -946,6 +949,9 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 	}
 
 	if (udata) {
+		if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_UD_SQ_INL)
+			resp.cap_flags |= HNS_ROCE_QP_CAP_UD_SQ_INL;
+
 		ret = ib_copy_to_udata(udata, &resp,
 				       min(udata->outlen, sizeof(resp)));
 		if (ret) {
-- 
2.8.1

