Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70B2B2BF7E
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2019 08:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbfE1GfB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 May 2019 02:35:01 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:17590 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726973AbfE1GfB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 28 May 2019 02:35:01 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5AF26392BFF468FF1FE3;
        Tue, 28 May 2019 14:34:58 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Tue, 28 May 2019 14:34:49 +0800
From:   Lijun Ou <oulijun@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH V2 for-next 3/3] RDMA/hns: Fix bug when wqe num is larger than 16K
Date:   Tue, 28 May 2019 14:33:33 +0800
Message-ID: <1559025213-128535-4-git-send-email-oulijun@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1559025213-128535-1-git-send-email-oulijun@huawei.com>
References: <1559025213-128535-1-git-send-email-oulijun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

hip08 can support up to 32768 wqes in one qp. currently if the wqe num
is larger than 16384, the driver will lead a calltrace as follows.

[21361.393725] Call trace:
[21361.398605]  hns_roce_v2_modify_qp+0xbcc/0x1360 [hns_roce_hw_v2]
[21361.410627]  hns_roce_modify_qp+0x1d8/0x2f8 [hns_roce]
[21361.420906]  _ib_modify_qp+0x70/0x118
[21361.428222]  ib_modify_qp+0x14/0x1c
[21361.435193]  rt_ktest_modify_qp+0xb8/0x650 [rdma_test]
[21361.445472]  exec_modify_qp_cmd+0x110/0x4d8 [rdma_test]
[21361.455924]  rt_ktest_dispatch_cmd_3+0xa94/0x2edc [rdma_test]
[21361.467422]  rt_ktest_dispatch_cmd_2+0x9c/0x108 [rdma_test]
[21361.478570]  rt_ktest_dispatch_cmd+0x138/0x904 [rdma_test]
[21361.489545]  rt_ktest_dev_write+0x328/0x4b0 [rdma_test]
[21361.499998]  __vfs_write+0x38/0x15c
[21361.506966]  vfs_write+0xa8/0x1a0
[21361.513586]  ksys_write+0x50/0xb0
[21361.520206]  sys_write+0xc/0x14
[21361.526479]  el0_svc_naked+0x30/0x34
[21361.533622] Code: 1ac10841 d37d7c22 0b000021 d37df021 (f86268c0)
[21361.545815] ---[ end trace e2a1feb2c3d7f13c ]---

When the wqe num is larger than 16384, hns_roce_table_find will return an
invalid mtt, this will lead an kernel paging requet error if the driver try
to access it. It's the mtt design defect which can't support up to the max
wqe num of hip08.

This patch fixs it by replacing mtt with mtr for wqe.

Fixes: 926a01dc000d ("RDMA/hns: Add QP operations support for hip08 SoC")
Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Lijun Ou <oulijun@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h |  11 ++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 118 +++++++++++------
 drivers/infiniband/hw/hns/hns_roce_qp.c     | 189 +++++++++++++++++++++-------
 3 files changed, 235 insertions(+), 83 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index f946ece..1b5acc0 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -660,6 +660,14 @@ struct hns_roce_qp {
 
 	struct ib_umem		*umem;
 	struct hns_roce_mtt	mtt;
+	struct hns_roce_mtr	mtr;
+
+	/* this define must less than HNS_ROCE_MAX_BT_REGION */
+#define HNS_ROCE_WQE_REGION_MAX	 3
+	struct hns_roce_buf_region regions[HNS_ROCE_WQE_REGION_MAX];
+	int			region_cnt;
+	int                     wqe_bt_pg_shift;
+
 	u32			buff_size;
 	struct mutex		mutex;
 	u8			port;
@@ -870,6 +878,9 @@ struct hns_roce_caps {
 	u32		mtt_ba_pg_sz;
 	u32		mtt_buf_pg_sz;
 	u32		mtt_hop_num;
+	u32		wqe_sq_hop_num;
+	u32		wqe_sge_hop_num;
+	u32		wqe_rq_hop_num;
 	u32		sccc_ba_pg_sz;
 	u32		sccc_buf_pg_sz;
 	u32		sccc_hop_num;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 7fcec99..76ac8d4 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1574,6 +1574,9 @@ static int hns_roce_v2_profile(struct hns_roce_dev *hr_dev)
 	caps->mtt_ba_pg_sz	= 0;
 	caps->mtt_buf_pg_sz	= 0;
 	caps->mtt_hop_num	= HNS_ROCE_MTT_HOP_NUM;
+	caps->wqe_sq_hop_num	= 2;
+	caps->wqe_sge_hop_num	= 1;
+	caps->wqe_rq_hop_num	= 2;
 	caps->cqe_ba_pg_sz	= 0;
 	caps->cqe_buf_pg_sz	= 0;
 	caps->cqe_hop_num	= HNS_ROCE_CQE_HOP_NUM;
@@ -3026,7 +3029,6 @@ static int hns_roce_v2_clear_hem(struct hns_roce_dev *hr_dev,
 }
 
 static int hns_roce_v2_qp_modify(struct hns_roce_dev *hr_dev,
-				 struct hns_roce_mtt *mtt,
 				 enum ib_qp_state cur_state,
 				 enum ib_qp_state new_state,
 				 struct hns_roce_v2_qp_context *context,
@@ -3522,6 +3524,31 @@ static void modify_qp_init_to_init(struct ib_qp *ibqp,
 	}
 }
 
+static bool check_wqe_rq_mtt_count(struct hns_roce_dev *hr_dev,
+				   struct hns_roce_qp *hr_qp, int mtt_cnt,
+				   u32 page_size)
+{
+	struct device *dev = hr_dev->dev;
+
+	if (hr_qp->rq.wqe_cnt < 1)
+		return true;
+
+	if (mtt_cnt < 1) {
+		dev_err(dev, "qp(0x%lx) rqwqe buf ba find failed\n",
+			hr_qp->qpn);
+		return false;
+	}
+
+	if (mtt_cnt < MTT_MIN_COUNT &&
+		(hr_qp->rq.offset + page_size) < hr_qp->buff_size) {
+		dev_err(dev, "qp(0x%lx) next rqwqe buf ba find failed\n",
+			hr_qp->qpn);
+		return false;
+	}
+
+	return true;
+}
+
 static int modify_qp_init_to_rtr(struct ib_qp *ibqp,
 				 const struct ib_qp_attr *attr, int attr_mask,
 				 struct hns_roce_v2_qp_context *context,
@@ -3531,25 +3558,27 @@ static int modify_qp_init_to_rtr(struct ib_qp *ibqp,
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
 	struct hns_roce_qp *hr_qp = to_hr_qp(ibqp);
 	struct device *dev = hr_dev->dev;
+	u64 mtts[MTT_MIN_COUNT] = { 0 };
 	dma_addr_t dma_handle_3;
 	dma_addr_t dma_handle_2;
-	dma_addr_t dma_handle;
+	u64 wqe_sge_ba;
 	u32 page_size;
 	u8 port_num;
 	u64 *mtts_3;
 	u64 *mtts_2;
-	u64 *mtts;
+	int count;
 	u8 *dmac;
 	u8 *smac;
 	int port;
 
 	/* Search qp buf's mtts */
-	mtts = hns_roce_table_find(hr_dev, &hr_dev->mr_table.mtt_table,
-				   hr_qp->mtt.first_seg, &dma_handle);
-	if (!mtts) {
-		dev_err(dev, "qp buf pa find failed\n");
-		return -EINVAL;
-	}
+	page_size = 1 << (hr_dev->caps.mtt_buf_pg_sz + PAGE_SHIFT);
+	count = hns_roce_mtr_find(hr_dev, &hr_qp->mtr,
+				  hr_qp->rq.offset / page_size, mtts,
+				  MTT_MIN_COUNT, &wqe_sge_ba);
+	if (!ibqp->srq)
+		if (!check_wqe_rq_mtt_count(hr_dev, hr_qp, count, page_size))
+			return -EINVAL;
 
 	/* Search IRRL's mtts */
 	mtts_2 = hns_roce_table_find(hr_dev, &hr_dev->qp_table.irrl_table,
@@ -3573,7 +3602,7 @@ static int modify_qp_init_to_rtr(struct ib_qp *ibqp,
 	}
 
 	dmac = (u8 *)attr->ah_attr.roce.dmac;
-	context->wqe_sge_ba = (u32)(dma_handle >> 3);
+	context->wqe_sge_ba = (u32)(wqe_sge_ba >> 3);
 	qpc_mask->wqe_sge_ba = 0;
 
 	/*
@@ -3583,22 +3612,23 @@ static int modify_qp_init_to_rtr(struct ib_qp *ibqp,
 	 * 0 at the same time, else set them to 0x1.
 	 */
 	roce_set_field(context->byte_12_sq_hop, V2_QPC_BYTE_12_WQE_SGE_BA_M,
-		       V2_QPC_BYTE_12_WQE_SGE_BA_S, dma_handle >> (32 + 3));
+		       V2_QPC_BYTE_12_WQE_SGE_BA_S, wqe_sge_ba >> (32 + 3));
 	roce_set_field(qpc_mask->byte_12_sq_hop, V2_QPC_BYTE_12_WQE_SGE_BA_M,
 		       V2_QPC_BYTE_12_WQE_SGE_BA_S, 0);
 
 	roce_set_field(context->byte_12_sq_hop, V2_QPC_BYTE_12_SQ_HOP_NUM_M,
 		       V2_QPC_BYTE_12_SQ_HOP_NUM_S,
-		       hr_dev->caps.mtt_hop_num == HNS_ROCE_HOP_NUM_0 ?
-		       0 : hr_dev->caps.mtt_hop_num);
+		       hr_dev->caps.wqe_sq_hop_num == HNS_ROCE_HOP_NUM_0 ?
+		       0 : hr_dev->caps.wqe_sq_hop_num);
 	roce_set_field(qpc_mask->byte_12_sq_hop, V2_QPC_BYTE_12_SQ_HOP_NUM_M,
 		       V2_QPC_BYTE_12_SQ_HOP_NUM_S, 0);
 
 	roce_set_field(context->byte_20_smac_sgid_idx,
 		       V2_QPC_BYTE_20_SGE_HOP_NUM_M,
 		       V2_QPC_BYTE_20_SGE_HOP_NUM_S,
-		       ((ibqp->qp_type == IB_QPT_GSI) || hr_qp->sq.max_gs > 2) ?
-		       hr_dev->caps.mtt_hop_num : 0);
+		       ((ibqp->qp_type == IB_QPT_GSI) ||
+		       hr_qp->sq.max_gs > HNS_ROCE_V2_UC_RC_SGE_NUM_IN_WQE) ?
+		       hr_dev->caps.wqe_sge_hop_num : 0);
 	roce_set_field(qpc_mask->byte_20_smac_sgid_idx,
 		       V2_QPC_BYTE_20_SGE_HOP_NUM_M,
 		       V2_QPC_BYTE_20_SGE_HOP_NUM_S, 0);
@@ -3606,8 +3636,8 @@ static int modify_qp_init_to_rtr(struct ib_qp *ibqp,
 	roce_set_field(context->byte_20_smac_sgid_idx,
 		       V2_QPC_BYTE_20_RQ_HOP_NUM_M,
 		       V2_QPC_BYTE_20_RQ_HOP_NUM_S,
-		       hr_dev->caps.mtt_hop_num == HNS_ROCE_HOP_NUM_0 ?
-		       0 : hr_dev->caps.mtt_hop_num);
+		       hr_dev->caps.wqe_rq_hop_num == HNS_ROCE_HOP_NUM_0 ?
+		       0 : hr_dev->caps.wqe_rq_hop_num);
 	roce_set_field(qpc_mask->byte_20_smac_sgid_idx,
 		       V2_QPC_BYTE_20_RQ_HOP_NUM_M,
 		       V2_QPC_BYTE_20_RQ_HOP_NUM_S, 0);
@@ -3615,7 +3645,7 @@ static int modify_qp_init_to_rtr(struct ib_qp *ibqp,
 	roce_set_field(context->byte_16_buf_ba_pg_sz,
 		       V2_QPC_BYTE_16_WQE_SGE_BA_PG_SZ_M,
 		       V2_QPC_BYTE_16_WQE_SGE_BA_PG_SZ_S,
-		       hr_dev->caps.mtt_ba_pg_sz + PG_SHIFT_OFFSET);
+		       hr_dev->caps.wqe_bt_pg_shift + PG_SHIFT_OFFSET);
 	roce_set_field(qpc_mask->byte_16_buf_ba_pg_sz,
 		       V2_QPC_BYTE_16_WQE_SGE_BA_PG_SZ_M,
 		       V2_QPC_BYTE_16_WQE_SGE_BA_PG_SZ_S, 0);
@@ -3628,29 +3658,24 @@ static int modify_qp_init_to_rtr(struct ib_qp *ibqp,
 		       V2_QPC_BYTE_16_WQE_SGE_BUF_PG_SZ_M,
 		       V2_QPC_BYTE_16_WQE_SGE_BUF_PG_SZ_S, 0);
 
-	page_size = 1 << (hr_dev->caps.mtt_buf_pg_sz + PAGE_SHIFT);
-	context->rq_cur_blk_addr = (u32)(mtts[hr_qp->rq.offset / page_size]
-				    >> PAGE_ADDR_SHIFT);
+	context->rq_cur_blk_addr = (u32)(mtts[0] >> PAGE_ADDR_SHIFT);
 	qpc_mask->rq_cur_blk_addr = 0;
 
 	roce_set_field(context->byte_92_srq_info,
 		       V2_QPC_BYTE_92_RQ_CUR_BLK_ADDR_M,
 		       V2_QPC_BYTE_92_RQ_CUR_BLK_ADDR_S,
-		       mtts[hr_qp->rq.offset / page_size]
-		       >> (32 + PAGE_ADDR_SHIFT));
+		       mtts[0] >> (32 + PAGE_ADDR_SHIFT));
 	roce_set_field(qpc_mask->byte_92_srq_info,
 		       V2_QPC_BYTE_92_RQ_CUR_BLK_ADDR_M,
 		       V2_QPC_BYTE_92_RQ_CUR_BLK_ADDR_S, 0);
 
-	context->rq_nxt_blk_addr = (u32)(mtts[hr_qp->rq.offset / page_size + 1]
-				    >> PAGE_ADDR_SHIFT);
+	context->rq_nxt_blk_addr = (u32)(mtts[1] >> PAGE_ADDR_SHIFT);
 	qpc_mask->rq_nxt_blk_addr = 0;
 
 	roce_set_field(context->byte_104_rq_sge,
 		       V2_QPC_BYTE_104_RQ_NXT_BLK_ADDR_M,
 		       V2_QPC_BYTE_104_RQ_NXT_BLK_ADDR_S,
-		       mtts[hr_qp->rq.offset / page_size + 1]
-		       >> (32 + PAGE_ADDR_SHIFT));
+		       mtts[1] >> (32 + PAGE_ADDR_SHIFT));
 	roce_set_field(qpc_mask->byte_104_rq_sge,
 		       V2_QPC_BYTE_104_RQ_NXT_BLK_ADDR_M,
 		       V2_QPC_BYTE_104_RQ_NXT_BLK_ADDR_S, 0);
@@ -3778,18 +3803,30 @@ static int modify_qp_rtr_to_rts(struct ib_qp *ibqp,
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
 	struct hns_roce_qp *hr_qp = to_hr_qp(ibqp);
 	struct device *dev = hr_dev->dev;
-	dma_addr_t dma_handle;
+	u64 sge_cur_blk = 0;
+	u64 sq_cur_blk = 0;
 	u32 page_size;
-	u64 *mtts;
+	int count;
 
 	/* Search qp buf's mtts */
-	mtts = hns_roce_table_find(hr_dev, &hr_dev->mr_table.mtt_table,
-				   hr_qp->mtt.first_seg, &dma_handle);
-	if (!mtts) {
-		dev_err(dev, "qp buf pa find failed\n");
+	count = hns_roce_mtr_find(hr_dev, &hr_qp->mtr, 0, &sq_cur_blk, 1, NULL);
+	if (count < 1) {
+		dev_err(dev, "qp(0x%lx) buf pa find failed\n", hr_qp->qpn);
 		return -EINVAL;
 	}
 
+	if (hr_qp->sge.offset) {
+		page_size = 1 << (hr_dev->caps.mtt_buf_pg_sz + PAGE_SHIFT);
+		count = hns_roce_mtr_find(hr_dev, &hr_qp->mtr,
+					  hr_qp->sge.offset / page_size,
+					  &sge_cur_blk, 1, NULL);
+		if (count < 1) {
+			dev_err(dev, "qp(0x%lx) sge pa find failed\n",
+				hr_qp->qpn);
+			return -EINVAL;
+		}
+	}
+
 	/* Not support alternate path and path migration */
 	if ((attr_mask & IB_QP_ALT_PATH) ||
 	    (attr_mask & IB_QP_PATH_MIG_STATE)) {
@@ -3803,38 +3840,37 @@ static int modify_qp_rtr_to_rts(struct ib_qp *ibqp,
 	 * we should set all bits of the relevant fields in context mask to
 	 * 0 at the same time, else set them to 0x1.
 	 */
-	context->sq_cur_blk_addr = (u32)(mtts[0] >> PAGE_ADDR_SHIFT);
+	context->sq_cur_blk_addr = (u32)(sq_cur_blk >> PAGE_ADDR_SHIFT);
 	roce_set_field(context->byte_168_irrl_idx,
 		       V2_QPC_BYTE_168_SQ_CUR_BLK_ADDR_M,
 		       V2_QPC_BYTE_168_SQ_CUR_BLK_ADDR_S,
-		       mtts[0] >> (32 + PAGE_ADDR_SHIFT));
+		       sq_cur_blk >> (32 + PAGE_ADDR_SHIFT));
 	qpc_mask->sq_cur_blk_addr = 0;
 	roce_set_field(qpc_mask->byte_168_irrl_idx,
 		       V2_QPC_BYTE_168_SQ_CUR_BLK_ADDR_M,
 		       V2_QPC_BYTE_168_SQ_CUR_BLK_ADDR_S, 0);
 
-	page_size = 1 << (hr_dev->caps.mtt_buf_pg_sz + PAGE_SHIFT);
 	context->sq_cur_sge_blk_addr = ((ibqp->qp_type == IB_QPT_GSI) ||
 		       hr_qp->sq.max_gs > HNS_ROCE_V2_UC_RC_SGE_NUM_IN_WQE) ?
-		       ((u32)(mtts[hr_qp->sge.offset / page_size] >>
+		       ((u32)(sge_cur_blk >>
 		       PAGE_ADDR_SHIFT)) : 0;
 	roce_set_field(context->byte_184_irrl_idx,
 		       V2_QPC_BYTE_184_SQ_CUR_SGE_BLK_ADDR_M,
 		       V2_QPC_BYTE_184_SQ_CUR_SGE_BLK_ADDR_S,
 		       ((ibqp->qp_type == IB_QPT_GSI) || hr_qp->sq.max_gs >
 		       HNS_ROCE_V2_UC_RC_SGE_NUM_IN_WQE) ?
-		       (mtts[hr_qp->sge.offset / page_size] >>
+		       (sge_cur_blk >>
 		       (32 + PAGE_ADDR_SHIFT)) : 0);
 	qpc_mask->sq_cur_sge_blk_addr = 0;
 	roce_set_field(qpc_mask->byte_184_irrl_idx,
 		       V2_QPC_BYTE_184_SQ_CUR_SGE_BLK_ADDR_M,
 		       V2_QPC_BYTE_184_SQ_CUR_SGE_BLK_ADDR_S, 0);
 
-	context->rx_sq_cur_blk_addr = (u32)(mtts[0] >> PAGE_ADDR_SHIFT);
+	context->rx_sq_cur_blk_addr = (u32)(sq_cur_blk >> PAGE_ADDR_SHIFT);
 	roce_set_field(context->byte_232_irrl_sge,
 		       V2_QPC_BYTE_232_RX_SQ_CUR_BLK_ADDR_M,
 		       V2_QPC_BYTE_232_RX_SQ_CUR_BLK_ADDR_S,
-		       mtts[0] >> (32 + PAGE_ADDR_SHIFT));
+		       sq_cur_blk >> (32 + PAGE_ADDR_SHIFT));
 	qpc_mask->rx_sq_cur_blk_addr = 0;
 	roce_set_field(qpc_mask->byte_232_irrl_sge,
 		       V2_QPC_BYTE_232_RX_SQ_CUR_BLK_ADDR_M,
@@ -4235,7 +4271,7 @@ static int hns_roce_v2_modify_qp(struct ib_qp *ibqp,
 		       V2_QPC_BYTE_60_QP_ST_S, 0);
 
 	/* SW pass context to HW */
-	ret = hns_roce_v2_qp_modify(hr_dev, &hr_qp->mtt, cur_state, new_state,
+	ret = hns_roce_v2_qp_modify(hr_dev, cur_state, new_state,
 				    context, hr_qp);
 	if (ret) {
 		dev_err(dev, "hns_roce_qp_modify failed(%d)\n", ret);
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 8db2817..99ec5d4 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -422,6 +422,91 @@ static int hns_roce_set_user_sq_size(struct hns_roce_dev *hr_dev,
 	return 0;
 }
 
+static int split_wqe_buf_region(struct hns_roce_dev *hr_dev,
+				struct hns_roce_qp *hr_qp,
+				struct hns_roce_buf_region *regions,
+				int region_max, int page_shift)
+{
+	int page_size = 1 << page_shift;
+	bool is_extend_sge;
+	int region_cnt = 0;
+	int buf_size;
+	int buf_cnt;
+
+	if (hr_qp->buff_size < 1 || region_max < 1)
+		return region_cnt;
+
+	if (hr_qp->sge.sge_cnt > 0)
+		is_extend_sge = true;
+	else
+		is_extend_sge = false;
+
+	/* sq region */
+	if (is_extend_sge)
+		buf_size = hr_qp->sge.offset - hr_qp->sq.offset;
+	else
+		buf_size = hr_qp->rq.offset - hr_qp->sq.offset;
+
+	if (buf_size > 0 && region_cnt < region_max) {
+		buf_cnt = DIV_ROUND_UP(buf_size, page_size);
+		hns_roce_init_buf_region(&regions[region_cnt],
+					 hr_dev->caps.wqe_sq_hop_num,
+					 hr_qp->sq.offset / page_size,
+					 buf_cnt);
+		region_cnt++;
+	}
+
+	/* sge region */
+	if (is_extend_sge) {
+		buf_size = hr_qp->rq.offset - hr_qp->sge.offset;
+		if (buf_size > 0 && region_cnt < region_max) {
+			buf_cnt = DIV_ROUND_UP(buf_size, page_size);
+			hns_roce_init_buf_region(&regions[region_cnt],
+						 hr_dev->caps.wqe_sge_hop_num,
+						 hr_qp->sge.offset / page_size,
+						 buf_cnt);
+			region_cnt++;
+		}
+	}
+
+	/* rq region */
+	buf_size = hr_qp->buff_size - hr_qp->rq.offset;
+	if (buf_size > 0) {
+		buf_cnt = DIV_ROUND_UP(buf_size, page_size);
+		hns_roce_init_buf_region(&regions[region_cnt],
+					 hr_dev->caps.wqe_rq_hop_num,
+					 hr_qp->rq.offset / page_size,
+					 buf_cnt);
+		region_cnt++;
+	}
+
+	return region_cnt;
+}
+
+static int calc_wqe_bt_page_shift(struct hns_roce_dev *hr_dev,
+				  struct hns_roce_buf_region *regions,
+				  int region_cnt)
+{
+	int bt_pg_shift;
+	int ba_num;
+	int ret;
+
+	bt_pg_shift = PAGE_SHIFT + hr_dev->caps.mtt_ba_pg_sz;
+
+	/* all root ba entries must in one bt page */
+	do {
+		ba_num = (1 << bt_pg_shift) / BA_BYTE_LEN;
+		ret = hns_roce_hem_list_calc_root_ba(regions, region_cnt,
+						     ba_num);
+		if (ret <= ba_num)
+			break;
+
+		bt_pg_shift++;
+	} while (ret > ba_num);
+
+	return bt_pg_shift - PAGE_SHIFT;
+}
+
 static int hns_roce_set_kernel_sq_size(struct hns_roce_dev *hr_dev,
 				       struct ib_qp_cap *cap,
 				       struct hns_roce_qp *hr_qp)
@@ -534,15 +619,17 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 				     struct ib_udata *udata, unsigned long sqpn,
 				     struct hns_roce_qp *hr_qp)
 {
+	dma_addr_t *buf_list[ARRAY_SIZE(hr_qp->regions)] = { 0 };
 	struct device *dev = hr_dev->dev;
 	struct hns_roce_ib_create_qp ucmd;
 	struct hns_roce_ib_create_qp_resp resp = {};
 	struct hns_roce_ucontext *uctx = rdma_udata_to_drv_context(
 		udata, struct hns_roce_ucontext, ibucontext);
+	struct hns_roce_buf_region *r;
 	unsigned long qpn = 0;
-	int ret = 0;
 	u32 page_shift;
-	u32 npages;
+	int buf_count;
+	int ret;
 	int i;
 
 	mutex_init(&hr_qp->mutex);
@@ -596,6 +683,7 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 				init_attr->cap.max_recv_sge];
 	}
 
+	page_shift = PAGE_SHIFT + hr_dev->caps.mtt_buf_pg_sz;
 	if (udata) {
 		if (ib_copy_from_udata(&ucmd, udata, sizeof(ucmd))) {
 			dev_err(dev, "ib_copy_from_udata error for create qp\n");
@@ -617,32 +705,28 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 			ret = PTR_ERR(hr_qp->umem);
 			goto err_rq_sge_list;
 		}
-
-		hr_qp->mtt.mtt_type = MTT_TYPE_WQE;
-		page_shift = PAGE_SHIFT;
-		if (hr_dev->caps.mtt_buf_pg_sz) {
-			npages = (ib_umem_page_count(hr_qp->umem) +
-				  (1 << hr_dev->caps.mtt_buf_pg_sz) - 1) /
-				 (1 << hr_dev->caps.mtt_buf_pg_sz);
-			page_shift += hr_dev->caps.mtt_buf_pg_sz;
-			ret = hns_roce_mtt_init(hr_dev, npages,
-				    page_shift,
-				    &hr_qp->mtt);
-		} else {
-			ret = hns_roce_mtt_init(hr_dev,
-						ib_umem_page_count(hr_qp->umem),
-						page_shift, &hr_qp->mtt);
-		}
+		hr_qp->region_cnt = split_wqe_buf_region(hr_dev, hr_qp,
+				hr_qp->regions, ARRAY_SIZE(hr_qp->regions),
+				page_shift);
+		ret = hns_roce_alloc_buf_list(hr_qp->regions, buf_list,
+					      hr_qp->region_cnt);
 		if (ret) {
-			dev_err(dev, "hns_roce_mtt_init error for create qp\n");
-			goto err_buf;
+			dev_err(dev, "alloc buf_list error for create qp\n");
+			goto err_alloc_list;
 		}
 
-		ret = hns_roce_ib_umem_write_mtt(hr_dev, &hr_qp->mtt,
-						 hr_qp->umem);
-		if (ret) {
-			dev_err(dev, "hns_roce_ib_umem_write_mtt error for create qp\n");
-			goto err_mtt;
+		for (i = 0; i < hr_qp->region_cnt; i++) {
+			r = &hr_qp->regions[i];
+			buf_count = hns_roce_get_umem_bufs(hr_dev,
+					buf_list[i], r->count, r->offset,
+					hr_qp->umem, page_shift);
+			if (buf_count != r->count) {
+				dev_err(dev,
+					"get umem buf err, expect %d,ret %d.\n",
+					r->count, buf_count);
+				ret = -ENOBUFS;
+				goto err_get_bufs;
+			}
 		}
 
 		if ((hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_SQ_RECORD_DB) &&
@@ -653,7 +737,7 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 						   &hr_qp->sdb);
 			if (ret) {
 				dev_err(dev, "sq record doorbell map failed!\n");
-				goto err_mtt;
+				goto err_get_bufs;
 			}
 
 			/* indicate kernel supports sq record db */
@@ -715,7 +799,6 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 		}
 
 		/* Allocate QP buf */
-		page_shift = PAGE_SHIFT + hr_dev->caps.mtt_buf_pg_sz;
 		if (hns_roce_buf_alloc(hr_dev, hr_qp->buff_size,
 				       (1 << page_shift) * 2,
 				       &hr_qp->hr_buf, page_shift)) {
@@ -723,21 +806,28 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 			ret = -ENOMEM;
 			goto err_db;
 		}
-
-		hr_qp->mtt.mtt_type = MTT_TYPE_WQE;
-		/* Write MTT */
-		ret = hns_roce_mtt_init(hr_dev, hr_qp->hr_buf.npages,
-					hr_qp->hr_buf.page_shift, &hr_qp->mtt);
+		hr_qp->region_cnt = split_wqe_buf_region(hr_dev, hr_qp,
+				hr_qp->regions, ARRAY_SIZE(hr_qp->regions),
+				page_shift);
+		ret = hns_roce_alloc_buf_list(hr_qp->regions, buf_list,
+					      hr_qp->region_cnt);
 		if (ret) {
-			dev_err(dev, "hns_roce_mtt_init error for kernel create qp\n");
-			goto err_buf;
+			dev_err(dev, "alloc buf_list error for create qp!\n");
+			goto err_alloc_list;
 		}
 
-		ret = hns_roce_buf_write_mtt(hr_dev, &hr_qp->mtt,
-					     &hr_qp->hr_buf);
-		if (ret) {
-			dev_err(dev, "hns_roce_buf_write_mtt error for kernel create qp\n");
-			goto err_mtt;
+		for (i = 0; i < hr_qp->region_cnt; i++) {
+			r = &hr_qp->regions[i];
+			buf_count = hns_roce_get_kmem_bufs(hr_dev,
+					buf_list[i], r->count, r->offset,
+					&hr_qp->hr_buf);
+			if (buf_count != r->count) {
+				dev_err(dev,
+					"get kmem buf err, expect %d,ret %d.\n",
+					r->count, buf_count);
+				ret = -ENOBUFS;
+				goto err_get_bufs;
+			}
 		}
 
 		hr_qp->sq.wrid = kcalloc(hr_qp->sq.wqe_cnt, sizeof(u64),
@@ -761,6 +851,17 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 		}
 	}
 
+	hr_qp->wqe_bt_pg_shift = calc_wqe_bt_page_shift(hr_dev, hr_qp->regions,
+							hr_qp->region_cnt);
+	hns_roce_mtr_init(&hr_qp->mtr, PAGE_SHIFT + hr_qp->wqe_bt_pg_shift,
+			  page_shift);
+	ret = hns_roce_mtr_attach(hr_dev, &hr_qp->mtr, buf_list,
+				  hr_qp->regions, hr_qp->region_cnt);
+	if (ret) {
+		dev_err(dev, "mtr attatch error for create qp\n");
+		goto err_mtr;
+	}
+
 	if (init_attr->qp_type == IB_QPT_GSI &&
 	    hr_dev->hw_rev == HNS_ROCE_HW_VER1) {
 		/* In v1 engine, GSI QP context in RoCE engine's register */
@@ -796,6 +897,7 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 	}
 
 	hr_qp->event = hns_roce_ib_qp_event;
+	hns_roce_free_buf_list(buf_list, hr_qp->region_cnt);
 
 	return 0;
 
@@ -810,6 +912,9 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 	if (!sqpn)
 		hns_roce_release_range_qp(hr_dev, qpn, 1);
 
+err_mtr:
+	hns_roce_mtr_cleanup(hr_dev, &hr_qp->mtr);
+
 err_wrid:
 	if (udata) {
 		if ((hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RECORD_DB) &&
@@ -829,10 +934,10 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 		    hns_roce_qp_has_sq(init_attr))
 			hns_roce_db_unmap_user(uctx, &hr_qp->sdb);
 
-err_mtt:
-	hns_roce_mtt_cleanup(hr_dev, &hr_qp->mtt);
+err_get_bufs:
+	hns_roce_free_buf_list(buf_list, hr_qp->region_cnt);
 
-err_buf:
+err_alloc_list:
 	if (hr_qp->umem)
 		ib_umem_release(hr_qp->umem);
 	else
-- 
1.9.1

