Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 322543AE479
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jun 2021 10:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbhFUIDe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Jun 2021 04:03:34 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:5413 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbhFUIDa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Jun 2021 04:03:30 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G7hj54ymcz72Zc;
        Mon, 21 Jun 2021 15:58:01 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 21 Jun 2021 16:01:14 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 21 Jun 2021 16:01:13 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Lang Cheng <chenglang@huawei.com>,
        Weihang Li <liweihang@huawei.com>
Subject: [PATCH v5 for-next 6/9] RDMA/hns: Use new interface to get CQE fields
Date:   Mon, 21 Jun 2021 16:00:40 +0800
Message-ID: <1624262443-24528-7-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1624262443-24528-1-git-send-email-liweihang@huawei.com>
References: <1624262443-24528-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggema753-chm.china.huawei.com (10.1.198.195)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lang Cheng <chenglang@huawei.com>

WQE_INDEX and OPCODE and QPN of CQE use redundant masks. Just remove them.

Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 68 +++++++++-----------------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h | 77 ++++++++++--------------------
 2 files changed, 48 insertions(+), 97 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index e0870f9..2266f9a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -3285,8 +3285,8 @@ static void *get_sw_cqe_v2(struct hns_roce_cq *hr_cq, unsigned int n)
 	struct hns_roce_v2_cqe *cqe = get_cqe_v2(hr_cq, n & hr_cq->ib_cq.cqe);
 
 	/* Get cqe when Owner bit is Conversely with the MSB of cons_idx */
-	return (roce_get_bit(cqe->byte_4, V2_CQE_BYTE_4_OWNER_S) ^
-		!!(n & hr_cq->cq_depth)) ? cqe : NULL;
+	return (hr_reg_read(cqe, CQE_OWNER) ^ !!(n & hr_cq->cq_depth)) ? cqe :
+									 NULL;
 }
 
 static inline void update_cq_db(struct hns_roce_dev *hr_dev,
@@ -3332,25 +3332,18 @@ static void __hns_roce_v2_cq_clean(struct hns_roce_cq *hr_cq, u32 qpn,
 	 */
 	while ((int) --prod_index - (int) hr_cq->cons_index >= 0) {
 		cqe = get_cqe_v2(hr_cq, prod_index & hr_cq->ib_cq.cqe);
-		if ((roce_get_field(cqe->byte_16, V2_CQE_BYTE_16_LCL_QPN_M,
-				    V2_CQE_BYTE_16_LCL_QPN_S) &
-				    HNS_ROCE_V2_CQE_QPN_MASK) == qpn) {
-			if (srq &&
-			    roce_get_bit(cqe->byte_4, V2_CQE_BYTE_4_S_R_S)) {
-				wqe_index = roce_get_field(cqe->byte_4,
-						     V2_CQE_BYTE_4_WQE_INDX_M,
-						     V2_CQE_BYTE_4_WQE_INDX_S);
+		if (hr_reg_read(cqe, CQE_LCL_QPN) == qpn) {
+			if (srq && hr_reg_read(cqe, CQE_S_R)) {
+				wqe_index = hr_reg_read(cqe, CQE_WQE_IDX);
 				hns_roce_free_srq_wqe(srq, wqe_index);
 			}
 			++nfreed;
 		} else if (nfreed) {
 			dest = get_cqe_v2(hr_cq, (prod_index + nfreed) &
 					  hr_cq->ib_cq.cqe);
-			owner_bit = roce_get_bit(dest->byte_4,
-						 V2_CQE_BYTE_4_OWNER_S);
+			owner_bit = hr_reg_read(dest, CQE_OWNER);
 			memcpy(dest, cqe, sizeof(*cqe));
-			roce_set_bit(dest->byte_4, V2_CQE_BYTE_4_OWNER_S,
-				     owner_bit);
+			hr_reg_write(dest, CQE_OWNER, owner_bit);
 		}
 	}
 
@@ -3455,8 +3448,7 @@ static int hns_roce_handle_recv_inl_wqe(struct hns_roce_v2_cqe *cqe,
 	u32 sge_cnt, data_len, size;
 	void *wqe_buf;
 
-	wr_num = roce_get_field(cqe->byte_4, V2_CQE_BYTE_4_WQE_INDX_M,
-				V2_CQE_BYTE_4_WQE_INDX_S) & 0xffff;
+	wr_num = hr_reg_read(cqe, CQE_WQE_IDX);
 	wr_cnt = wr_num & (qp->rq.wqe_cnt - 1);
 
 	sge_list = qp->rq_inl_buf.wqe_list[wr_cnt].sg_list;
@@ -3555,8 +3547,7 @@ static void get_cqe_status(struct hns_roce_dev *hr_dev, struct hns_roce_qp *qp,
 		{ HNS_ROCE_CQE_V2_GENERAL_ERR, IB_WC_GENERAL_ERR}
 	};
 
-	u32 cqe_status = roce_get_field(cqe->byte_4, V2_CQE_BYTE_4_STATUS_M,
-					V2_CQE_BYTE_4_STATUS_S);
+	u32 cqe_status = hr_reg_read(cqe, CQE_STATUS);
 	int i;
 
 	wc->status = IB_WC_GENERAL_ERR;
@@ -3602,9 +3593,7 @@ static int get_cur_qp(struct hns_roce_cq *hr_cq, struct hns_roce_v2_cqe *cqe,
 	struct hns_roce_qp *hr_qp = *cur_qp;
 	u32 qpn;
 
-	qpn = roce_get_field(cqe->byte_16, V2_CQE_BYTE_16_LCL_QPN_M,
-			     V2_CQE_BYTE_16_LCL_QPN_S) &
-	      HNS_ROCE_V2_CQE_QPN_MASK;
+	qpn = hr_reg_read(cqe, CQE_LCL_QPN);
 
 	if (!hr_qp || qpn != hr_qp->qpn) {
 		hr_qp = __hns_roce_qp_lookup(hr_dev, qpn);
@@ -3678,8 +3667,7 @@ static void fill_send_wc(struct ib_wc *wc, struct hns_roce_v2_cqe *cqe)
 
 	wc->wc_flags = 0;
 
-	hr_opcode = roce_get_field(cqe->byte_4, V2_CQE_BYTE_4_OPCODE_M,
-				   V2_CQE_BYTE_4_OPCODE_S) & 0x1f;
+	hr_opcode = hr_reg_read(cqe, CQE_OPCODE);
 	switch (hr_opcode) {
 	case HNS_ROCE_V2_WQE_OP_RDMA_READ:
 		wc->byte_len = le32_to_cpu(cqe->byte_cnt);
@@ -3711,12 +3699,11 @@ static void fill_send_wc(struct ib_wc *wc, struct hns_roce_v2_cqe *cqe)
 static inline bool is_rq_inl_enabled(struct ib_wc *wc, u32 hr_opcode,
 				     struct hns_roce_v2_cqe *cqe)
 {
-	return wc->qp->qp_type != IB_QPT_UD &&
-	       wc->qp->qp_type != IB_QPT_GSI &&
+	return wc->qp->qp_type != IB_QPT_UD && wc->qp->qp_type != IB_QPT_GSI &&
 	       (hr_opcode == HNS_ROCE_V2_OPCODE_SEND ||
 		hr_opcode == HNS_ROCE_V2_OPCODE_SEND_WITH_IMM ||
 		hr_opcode == HNS_ROCE_V2_OPCODE_SEND_WITH_INV) &&
-	       roce_get_bit(cqe->byte_4, V2_CQE_BYTE_4_RQ_INLINE_S);
+	       hr_reg_read(cqe, CQE_RQ_INLINE);
 }
 
 static int fill_recv_wc(struct ib_wc *wc, struct hns_roce_v2_cqe *cqe)
@@ -3728,8 +3715,7 @@ static int fill_recv_wc(struct ib_wc *wc, struct hns_roce_v2_cqe *cqe)
 
 	wc->byte_len = le32_to_cpu(cqe->byte_cnt);
 
-	hr_opcode = roce_get_field(cqe->byte_4, V2_CQE_BYTE_4_OPCODE_M,
-				   V2_CQE_BYTE_4_OPCODE_S) & 0x1f;
+	hr_opcode = hr_reg_read(cqe, CQE_OPCODE);
 	switch (hr_opcode) {
 	case HNS_ROCE_V2_OPCODE_RDMA_WRITE_IMM:
 	case HNS_ROCE_V2_OPCODE_SEND_WITH_IMM:
@@ -3756,28 +3742,21 @@ static int fill_recv_wc(struct ib_wc *wc, struct hns_roce_v2_cqe *cqe)
 			return ret;
 	}
 
-	wc->sl = roce_get_field(cqe->byte_32, V2_CQE_BYTE_32_SL_M,
-				V2_CQE_BYTE_32_SL_S);
-	wc->src_qp = roce_get_field(cqe->byte_32, V2_CQE_BYTE_32_RMT_QPN_M,
-				    V2_CQE_BYTE_32_RMT_QPN_S);
+	wc->sl = hr_reg_read(cqe, CQE_SL);
+	wc->src_qp = hr_reg_read(cqe, CQE_RMT_QPN);
 	wc->slid = 0;
-	wc->wc_flags |= roce_get_bit(cqe->byte_32, V2_CQE_BYTE_32_GRH_S) ?
-				     IB_WC_GRH : 0;
-	wc->port_num = roce_get_field(cqe->byte_32, V2_CQE_BYTE_32_PORTN_M,
-				      V2_CQE_BYTE_32_PORTN_S);
+	wc->wc_flags |= hr_reg_read(cqe, CQE_GRH) ? IB_WC_GRH : 0;
+	wc->port_num = hr_reg_read(cqe, CQE_PORTN);
 	wc->pkey_index = 0;
 
-	if (roce_get_bit(cqe->byte_28, V2_CQE_BYTE_28_VID_VLD_S)) {
-		wc->vlan_id = roce_get_field(cqe->byte_28, V2_CQE_BYTE_28_VID_M,
-					     V2_CQE_BYTE_28_VID_S);
+	if (hr_reg_read(cqe, CQE_VID_VLD)) {
+		wc->vlan_id = hr_reg_read(cqe, CQE_VID);
 		wc->wc_flags |= IB_WC_WITH_VLAN;
 	} else {
 		wc->vlan_id = 0xffff;
 	}
 
-	wc->network_hdr_type = roce_get_field(cqe->byte_28,
-					      V2_CQE_BYTE_28_PORT_TYPE_M,
-					      V2_CQE_BYTE_28_PORT_TYPE_S);
+	wc->network_hdr_type = hr_reg_read(cqe, CQE_PORT_TYPE);
 
 	return 0;
 }
@@ -3809,10 +3788,9 @@ static int hns_roce_v2_poll_one(struct hns_roce_cq *hr_cq,
 	wc->qp = &qp->ibqp;
 	wc->vendor_err = 0;
 
-	wqe_idx = roce_get_field(cqe->byte_4, V2_CQE_BYTE_4_WQE_INDX_M,
-				 V2_CQE_BYTE_4_WQE_INDX_S);
+	wqe_idx = hr_reg_read(cqe, CQE_WQE_IDX);
 
-	is_send = !roce_get_bit(cqe->byte_4, V2_CQE_BYTE_4_S_R_S);
+	is_send = !hr_reg_read(cqe, CQE_S_R);
 	if (is_send) {
 		wq = &qp->sq;
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index ae3a88e..d398cf08 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -178,8 +178,6 @@ enum {
 
 #define	GID_LEN_V2				16
 
-#define HNS_ROCE_V2_CQE_QPN_MASK		0xfffff
-
 enum {
 	HNS_ROCE_V2_WQE_OP_SEND				= 0x0,
 	HNS_ROCE_V2_WQE_OP_SEND_WITH_INV		= 0x1,
@@ -803,56 +801,31 @@ struct hns_roce_v2_cqe {
 	__le32	rsv[8];
 };
 
-#define	V2_CQE_BYTE_4_OPCODE_S 0
-#define V2_CQE_BYTE_4_OPCODE_M GENMASK(4, 0)
-
-#define	V2_CQE_BYTE_4_RQ_INLINE_S 5
-
-#define	V2_CQE_BYTE_4_S_R_S 6
-
-#define	V2_CQE_BYTE_4_OWNER_S 7
-
-#define	V2_CQE_BYTE_4_STATUS_S 8
-#define V2_CQE_BYTE_4_STATUS_M GENMASK(15, 8)
-
-#define	V2_CQE_BYTE_4_WQE_INDX_S 16
-#define V2_CQE_BYTE_4_WQE_INDX_M GENMASK(31, 16)
-
-#define	V2_CQE_BYTE_12_XRC_SRQN_S 0
-#define V2_CQE_BYTE_12_XRC_SRQN_M GENMASK(23, 0)
-
-#define	V2_CQE_BYTE_16_LCL_QPN_S 0
-#define V2_CQE_BYTE_16_LCL_QPN_M GENMASK(23, 0)
-
-#define	V2_CQE_BYTE_16_SUB_STATUS_S 24
-#define V2_CQE_BYTE_16_SUB_STATUS_M GENMASK(31, 24)
-
-#define	V2_CQE_BYTE_28_SMAC_4_S 0
-#define V2_CQE_BYTE_28_SMAC_4_M	GENMASK(7, 0)
-
-#define	V2_CQE_BYTE_28_SMAC_5_S 8
-#define V2_CQE_BYTE_28_SMAC_5_M	GENMASK(15, 8)
-
-#define	V2_CQE_BYTE_28_PORT_TYPE_S 16
-#define V2_CQE_BYTE_28_PORT_TYPE_M GENMASK(17, 16)
-
-#define V2_CQE_BYTE_28_VID_S 18
-#define V2_CQE_BYTE_28_VID_M GENMASK(29, 18)
-
-#define V2_CQE_BYTE_28_VID_VLD_S 30
-
-#define	V2_CQE_BYTE_32_RMT_QPN_S 0
-#define V2_CQE_BYTE_32_RMT_QPN_M GENMASK(23, 0)
-
-#define	V2_CQE_BYTE_32_SL_S 24
-#define V2_CQE_BYTE_32_SL_M GENMASK(26, 24)
-
-#define	V2_CQE_BYTE_32_PORTN_S 27
-#define V2_CQE_BYTE_32_PORTN_M GENMASK(29, 27)
-
-#define	V2_CQE_BYTE_32_GRH_S 30
-
-#define	V2_CQE_BYTE_32_LPK_S 31
+#define CQE_FIELD_LOC(h, l) FIELD_LOC(struct hns_roce_v2_cqe, h, l)
+
+#define CQE_OPCODE CQE_FIELD_LOC(4, 0)
+#define CQE_RQ_INLINE CQE_FIELD_LOC(5, 5)
+#define CQE_S_R CQE_FIELD_LOC(6, 6)
+#define CQE_OWNER CQE_FIELD_LOC(7, 7)
+#define CQE_STATUS CQE_FIELD_LOC(15, 8)
+#define CQE_WQE_IDX CQE_FIELD_LOC(31, 16)
+#define CQE_RKEY_IMMTDATA CQE_FIELD_LOC(63, 32)
+#define CQE_XRC_SRQN CQE_FIELD_LOC(87, 64)
+#define CQE_RSV0 CQE_FIELD_LOC(95, 88)
+#define CQE_LCL_QPN CQE_FIELD_LOC(119, 96)
+#define CQE_SUB_STATUS CQE_FIELD_LOC(127, 120)
+#define CQE_BYTE_CNT CQE_FIELD_LOC(159, 128)
+#define CQE_SMAC CQE_FIELD_LOC(207, 160)
+#define CQE_PORT_TYPE CQE_FIELD_LOC(209, 208)
+#define CQE_VID CQE_FIELD_LOC(221, 210)
+#define CQE_VID_VLD CQE_FIELD_LOC(222, 222)
+#define CQE_RSV2 CQE_FIELD_LOC(223, 223)
+#define CQE_RMT_QPN CQE_FIELD_LOC(247, 224)
+#define CQE_SL CQE_FIELD_LOC(250, 248)
+#define CQE_PORTN CQE_FIELD_LOC(253, 251)
+#define CQE_GRH CQE_FIELD_LOC(254, 254)
+#define CQE_LPK CQE_FIELD_LOC(255, 255)
+#define CQE_RSV3 CQE_FIELD_LOC(511, 256)
 
 struct hns_roce_v2_mpt_entry {
 	__le32	byte_4_pd_hop_st;
-- 
2.7.4

