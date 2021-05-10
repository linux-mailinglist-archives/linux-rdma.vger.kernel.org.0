Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD69378EC8
	for <lists+linux-rdma@lfdr.de>; Mon, 10 May 2021 15:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240995AbhEJNXg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 May 2021 09:23:36 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:2429 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241766AbhEJMu5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 May 2021 08:50:57 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Ff1671ZTKzCr7x;
        Mon, 10 May 2021 20:47:11 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.498.0; Mon, 10 May 2021 20:49:44 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, "Xi Wang" <wangxi11@huawei.com>,
        Weihang Li <liweihang@huawei.com>
Subject: [PATCH for-next 5/7] RDMA/hns: Setup the configuration of WQE addressing to QPC
Date:   Mon, 10 May 2021 20:48:07 +0800
Message-ID: <1620650889-61650-6-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1620650889-61650-1-git-send-email-liweihang@huawei.com>
References: <1620650889-61650-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

Add a new command to update the configuration of WQE buffer addressing to
QPC in DCA mode.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 153 ++++++++++++++++++++++++++---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h |   1 +
 2 files changed, 139 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 9adac50..2a5d443 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -2788,6 +2788,17 @@ static void hns_roce_v2_exit(struct hns_roce_dev *hr_dev)
 		free_dip_list(hr_dev);
 }
 
+static inline void mbox_desc_init(struct hns_roce_post_mbox *mb, u64 in_param,
+				  u64 out_param, u32 in_modifier,
+				  u8 op_modifier, u16 op)
+{
+	mb->in_param_l = cpu_to_le32(in_param);
+	mb->in_param_h = cpu_to_le32(in_param >> 32);
+	mb->out_param_l = cpu_to_le32(out_param);
+	mb->out_param_h = cpu_to_le32(out_param >> 32);
+	mb->cmd_tag = cpu_to_le32(in_modifier << 8 | op);
+}
+
 static int hns_roce_mbox_post(struct hns_roce_dev *hr_dev, u64 in_param,
 			      u64 out_param, u32 in_modifier, u8 op_modifier,
 			      u16 op, u16 token, int event)
@@ -2796,17 +2807,34 @@ static int hns_roce_mbox_post(struct hns_roce_dev *hr_dev, u64 in_param,
 	struct hns_roce_post_mbox *mb = (struct hns_roce_post_mbox *)desc.data;
 
 	hns_roce_cmq_setup_basic_desc(&desc, HNS_ROCE_OPC_POST_MB, false);
-
-	mb->in_param_l = cpu_to_le32(in_param);
-	mb->in_param_h = cpu_to_le32(in_param >> 32);
-	mb->out_param_l = cpu_to_le32(out_param);
-	mb->out_param_h = cpu_to_le32(out_param >> 32);
-	mb->cmd_tag = cpu_to_le32(in_modifier << 8 | op);
+	mbox_desc_init(mb, in_param, out_param, in_modifier, op_modifier, op);
 	mb->token_event_en = cpu_to_le32(event << 16 | token);
 
 	return hns_roce_cmq_send(hr_dev, &desc, 1);
 }
 
+static int hns_roce_mbox_send(struct hns_roce_dev *hr_dev, u64 in_param,
+			      u64 out_param, u32 in_modifier, u8 op_modifier,
+			      u16 op)
+{
+	struct hns_roce_cmq_desc desc;
+	struct hns_roce_post_mbox *mb = (struct hns_roce_post_mbox *)desc.data;
+
+	hns_roce_cmq_setup_basic_desc(&desc, HNS_ROCE_OPC_SYNC_MB, false);
+
+	mbox_desc_init(mb, in_param, out_param, in_modifier, op_modifier, op);
+
+	/* The hardware doesn't care about the token fields when working in
+	 * sync mode.
+	 */
+	mb->token_event_en = 0;
+
+	/* The cmdq send returns 0 indicates that the hardware has already
+	 * finished the operation defined in this mbox.
+	 */
+	return hns_roce_cmq_send(hr_dev, &desc, 1);
+}
+
 static int v2_wait_mbox_complete(struct hns_roce_dev *hr_dev, u32 timeout,
 				 u8 *complete_status)
 {
@@ -4304,15 +4332,16 @@ static void modify_qp_init_to_init(struct ib_qp *ibqp,
 static int config_qp_rq_buf(struct hns_roce_dev *hr_dev,
 			    struct hns_roce_qp *hr_qp,
 			    struct hns_roce_v2_qp_context *context,
-			    struct hns_roce_v2_qp_context *qpc_mask)
+			    struct hns_roce_v2_qp_context *qpc_mask,
+			    struct hns_roce_dca_attr *dca_attr)
 {
 	u64 mtts[MTT_MIN_COUNT] = { 0 };
 	u64 wqe_sge_ba;
 	int count;
 
 	/* Search qp buf's mtts */
-	count = hns_roce_mtr_find(hr_dev, &hr_qp->mtr, hr_qp->rq.offset, mtts,
-				  MTT_MIN_COUNT, &wqe_sge_ba);
+	count = hns_roce_mtr_find(hr_dev, &hr_qp->mtr, dca_attr->rq_offset,
+				  mtts, ARRAY_SIZE(mtts), &wqe_sge_ba);
 	if (hr_qp->rq.wqe_cnt && count < 1) {
 		ibdev_err(&hr_dev->ib_dev,
 			  "failed to find RQ WQE, QPN = 0x%lx.\n", hr_qp->qpn);
@@ -4403,7 +4432,8 @@ static int config_qp_rq_buf(struct hns_roce_dev *hr_dev,
 static int config_qp_sq_buf(struct hns_roce_dev *hr_dev,
 			    struct hns_roce_qp *hr_qp,
 			    struct hns_roce_v2_qp_context *context,
-			    struct hns_roce_v2_qp_context *qpc_mask)
+			    struct hns_roce_v2_qp_context *qpc_mask,
+			    struct hns_roce_dca_attr *dca_attr)
 {
 	struct ib_device *ibdev = &hr_dev->ib_dev;
 	u64 sge_cur_blk = 0;
@@ -4411,7 +4441,8 @@ static int config_qp_sq_buf(struct hns_roce_dev *hr_dev,
 	int count;
 
 	/* search qp buf's mtts */
-	count = hns_roce_mtr_find(hr_dev, &hr_qp->mtr, 0, &sq_cur_blk, 1, NULL);
+	count = hns_roce_mtr_find(hr_dev, &hr_qp->mtr, dca_attr->sq_offset,
+				  &sq_cur_blk, 1, NULL);
 	if (count < 1) {
 		ibdev_err(ibdev, "failed to find QP(0x%lx) SQ buf.\n",
 			  hr_qp->qpn);
@@ -4419,8 +4450,8 @@ static int config_qp_sq_buf(struct hns_roce_dev *hr_dev,
 	}
 	if (hr_qp->sge.sge_cnt > 0) {
 		count = hns_roce_mtr_find(hr_dev, &hr_qp->mtr,
-					  hr_qp->sge.offset,
-					  &sge_cur_blk, 1, NULL);
+					  dca_attr->sge_offset, &sge_cur_blk, 1,
+					  NULL);
 		if (count < 1) {
 			ibdev_err(ibdev, "failed to find QP(0x%lx) SGE buf.\n",
 				  hr_qp->qpn);
@@ -4486,6 +4517,7 @@ static int modify_qp_init_to_rtr(struct ib_qp *ibqp,
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
 	struct hns_roce_qp *hr_qp = to_hr_qp(ibqp);
 	struct ib_device *ibdev = &hr_dev->ib_dev;
+	struct hns_roce_dca_attr dca_attr = {};
 	dma_addr_t trrl_ba;
 	dma_addr_t irrl_ba;
 	enum ib_mtu mtu;
@@ -4496,7 +4528,8 @@ static int modify_qp_init_to_rtr(struct ib_qp *ibqp,
 	u32 port;
 	int ret;
 
-	ret = config_qp_rq_buf(hr_dev, hr_qp, context, qpc_mask);
+	dca_attr.rq_offset = hr_qp->rq.offset;
+	ret = config_qp_rq_buf(hr_dev, hr_qp, context, qpc_mask, &dca_attr);
 	if (ret) {
 		ibdev_err(ibdev, "failed to config rq buf, ret = %d.\n", ret);
 		return ret;
@@ -4653,6 +4686,7 @@ static int modify_qp_rtr_to_rts(struct ib_qp *ibqp,
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
 	struct hns_roce_qp *hr_qp = to_hr_qp(ibqp);
 	struct ib_device *ibdev = &hr_dev->ib_dev;
+	struct hns_roce_dca_attr dca_attr = {};
 	int ret;
 
 	/* Not support alternate path and path migration */
@@ -4661,7 +4695,9 @@ static int modify_qp_rtr_to_rts(struct ib_qp *ibqp,
 		return -EINVAL;
 	}
 
-	ret = config_qp_sq_buf(hr_dev, hr_qp, context, qpc_mask);
+	dca_attr.sq_offset = hr_qp->sq.offset;
+	dca_attr.sge_offset = hr_qp->sge.offset;
+	ret = config_qp_sq_buf(hr_dev, hr_qp, context, qpc_mask, &dca_attr);
 	if (ret) {
 		ibdev_err(ibdev, "failed to config sq buf, ret = %d.\n", ret);
 		return ret;
@@ -5333,6 +5369,92 @@ static int hns_roce_v2_modify_qp(struct ib_qp *ibqp,
 	return ret;
 }
 
+static int init_dca_buf_attr(struct hns_roce_dev *hr_dev,
+			     struct hns_roce_qp *hr_qp,
+			     struct hns_roce_dca_attr *init_attr,
+			     struct hns_roce_dca_attr *dca_attr)
+{
+	struct ib_device *ibdev = &hr_dev->ib_dev;
+
+	if (hr_qp->sq.wqe_cnt > 0) {
+		dca_attr->sq_offset = hr_qp->sq.offset + init_attr->sq_offset;
+		if (dca_attr->sq_offset >= hr_qp->sge.offset) {
+			ibdev_err(ibdev, "failed to check SQ offset = %u\n",
+				  init_attr->sq_offset);
+			return -EINVAL;
+		}
+	}
+
+	if (hr_qp->sge.sge_cnt > 0) {
+		dca_attr->sge_offset = hr_qp->sge.offset + init_attr->sge_offset;
+		if (dca_attr->sge_offset >= hr_qp->rq.offset) {
+			ibdev_err(ibdev, "failed to check exSGE offset = %u\n",
+				  init_attr->sge_offset);
+			return -EINVAL;
+		}
+	}
+
+	if (hr_qp->rq.wqe_cnt > 0) {
+		dca_attr->rq_offset = hr_qp->rq.offset + init_attr->rq_offset;
+		if (dca_attr->rq_offset >= hr_qp->buff_size) {
+			ibdev_err(ibdev, "failed to check RQ offset = %u\n",
+				  init_attr->rq_offset);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static int hns_roce_v2_set_dca_buf(struct hns_roce_dev *hr_dev,
+				   struct hns_roce_qp *hr_qp,
+				   struct hns_roce_dca_attr *init_attr)
+{
+	struct ib_device *ibdev = &hr_dev->ib_dev;
+	struct hns_roce_v2_qp_context *qpc, *msk;
+	struct hns_roce_dca_attr dca_attr = {};
+	dma_addr_t dma_handle;
+	int qpc_sz;
+	int ret;
+
+	ret = init_dca_buf_attr(hr_dev, hr_qp, init_attr, &dca_attr);
+	if (ret) {
+		ibdev_err(ibdev, "failed to init DCA attr, ret = %d.\n", ret);
+		return ret;
+	}
+
+	qpc_sz = hr_dev->caps.qpc_sz;
+	WARN_ON(2 * qpc_sz > HNS_ROCE_MAILBOX_SIZE);
+	qpc = dma_pool_alloc(hr_dev->cmd.pool, GFP_NOWAIT, &dma_handle);
+	if (!qpc)
+		return -ENOMEM;
+
+	msk = (struct hns_roce_v2_qp_context *)((void *)qpc + qpc_sz);
+	memset(msk, 0xff, qpc_sz);
+
+	ret = config_qp_rq_buf(hr_dev, hr_qp, qpc, msk, &dca_attr);
+	if (ret) {
+		ibdev_err(ibdev, "failed to config rq qpc, ret = %d.\n", ret);
+		goto done;
+	}
+
+	ret = config_qp_sq_buf(hr_dev, hr_qp, qpc, msk, &dca_attr);
+	if (ret) {
+		ibdev_err(ibdev, "failed to config sq qpc, ret = %d.\n", ret);
+		goto done;
+	}
+
+	ret = hns_roce_mbox_send(hr_dev, dma_handle, 0, hr_qp->qpn, 0,
+				 HNS_ROCE_CMD_MODIFY_QPC);
+	if (ret)
+		ibdev_err(ibdev, "failed to modify DCA buf, ret = %d.\n", ret);
+
+done:
+	dma_pool_free(hr_dev->cmd.pool, qpc, dma_handle);
+
+	return ret;
+}
+
 static int to_ib_qp_st(enum hns_roce_v2_qp_state state)
 {
 	static const enum ib_qp_state map[] = {
@@ -6563,6 +6685,7 @@ static const struct hns_roce_hw hns_roce_hw_v2 = {
 	.write_cqc = hns_roce_v2_write_cqc,
 	.set_hem = hns_roce_v2_set_hem,
 	.clear_hem = hns_roce_v2_clear_hem,
+	.set_dca_buf = hns_roce_v2_set_dca_buf,
 	.modify_qp = hns_roce_v2_modify_qp,
 	.qp_flow_control_init = hns_roce_v2_qp_flow_control_init,
 	.init_eq = hns_roce_v2_init_eq_table,
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index eecf27c..9b30a5f 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -251,6 +251,7 @@ enum hns_roce_opcode_type {
 	HNS_ROCE_OPC_QUERY_VF_RES			= 0x850e,
 	HNS_ROCE_OPC_CFG_GMV_TBL			= 0x850f,
 	HNS_ROCE_OPC_CFG_GMV_BT				= 0x8510,
+	HNS_ROCE_OPC_SYNC_MB				= 0x8511,
 	HNS_SWITCH_PARAMETER_CFG			= 0x1033,
 };
 
-- 
2.7.4

