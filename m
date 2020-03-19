Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8429818B6BD
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2020 14:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbgCSN3F (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Mar 2020 09:29:05 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12154 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727468AbgCSN3D (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 19 Mar 2020 09:29:03 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A81523F168F62DE8A21A;
        Thu, 19 Mar 2020 21:28:47 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Thu, 19 Mar 2020 21:28:41 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 01/11] RDMA/hns: Unify format of prints
Date:   Thu, 19 Mar 2020 21:24:48 +0800
Message-ID: <1584624298-23841-2-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1584624298-23841-1-git-send-email-liweihang@huawei.com>
References: <1584624298-23841-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lijun Ou <oulijun@huawei.com>

Use ibdev_err/dbg/warn() instead of dev_err/dbg/warn(), and modify some
prints into format of "failed to do something, ret = n".

Signed-off-by: Lijun Ou <oulijun@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 156 ++++++++++++++++-------------
 drivers/infiniband/hw/hns/hns_roce_pd.c    |   6 +-
 2 files changed, 89 insertions(+), 73 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 9bd8fbf..94cb2984 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -266,21 +266,24 @@ static int set_rwqe_data_seg(struct ib_qp *ibqp, const struct ib_send_wr *wr,
 static int check_send_valid(struct hns_roce_dev *hr_dev,
 			    struct hns_roce_qp *hr_qp)
 {
+	struct ib_device *ibdev = &hr_dev->ib_dev;
 	struct ib_qp *ibqp = &hr_qp->ibqp;
-	struct device *dev = hr_dev->dev;
 
 	if (unlikely(ibqp->qp_type != IB_QPT_RC &&
 		     ibqp->qp_type != IB_QPT_GSI &&
 		     ibqp->qp_type != IB_QPT_UD)) {
-		dev_err(dev, "Not supported QP(0x%x)type!\n", ibqp->qp_type);
+		ibdev_err(ibdev, "Not supported QP(0x%x)type!\n",
+			  ibqp->qp_type);
 		return -EOPNOTSUPP;
 	} else if (unlikely(hr_qp->state == IB_QPS_RESET ||
 		   hr_qp->state == IB_QPS_INIT ||
 		   hr_qp->state == IB_QPS_RTR)) {
-		dev_err(dev, "Post WQE fail, QP state %d!\n", hr_qp->state);
+		ibdev_err(ibdev, "failed to post WQE, QP state %d!\n",
+			  hr_qp->state);
 		return -EINVAL;
 	} else if (unlikely(hr_dev->state >= HNS_ROCE_DEVICE_STATE_RST_DOWN)) {
-		dev_err(dev, "Post WQE fail, dev state %d!\n", hr_dev->state);
+		ibdev_err(ibdev, "failed to post WQE, dev state %d!\n",
+			  hr_dev->state);
 		return -EIO;
 	}
 
@@ -625,9 +628,9 @@ static int hns_roce_v2_post_recv(struct ib_qp *ibqp,
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
 	struct hns_roce_qp *hr_qp = to_hr_qp(ibqp);
+	struct ib_device *ibdev = &hr_dev->ib_dev;
 	struct hns_roce_v2_wqe_data_seg *dseg;
 	struct hns_roce_rinl_sge *sge_list;
-	struct device *dev = hr_dev->dev;
 	unsigned long flags;
 	void *wqe = NULL;
 	u32 wqe_idx;
@@ -655,8 +658,8 @@ static int hns_roce_v2_post_recv(struct ib_qp *ibqp,
 		wqe_idx = (hr_qp->rq.head + nreq) & (hr_qp->rq.wqe_cnt - 1);
 
 		if (unlikely(wr->num_sge > hr_qp->rq.max_gs)) {
-			dev_err(dev, "rq:num_sge=%d > qp->sq.max_gs=%d\n",
-				wr->num_sge, hr_qp->rq.max_gs);
+			ibdev_err(ibdev, "rq:num_sge=%d >= qp->sq.max_gs=%d\n",
+				  wr->num_sge, hr_qp->rq.max_gs);
 			ret = -EINVAL;
 			*bad_wr = wr;
 			goto out;
@@ -2440,7 +2443,9 @@ static int hns_roce_v2_set_gid(struct hns_roce_dev *hr_dev, u8 port,
 
 	ret = hns_roce_config_sgid_table(hr_dev, gid_index, gid, sgid_type);
 	if (ret)
-		dev_err(hr_dev->dev, "Configure sgid table failed(%d)!\n", ret);
+		ibdev_err(&hr_dev->ib_dev,
+			  "failed to configure sgid table, ret = %d!\n",
+			  ret);
 
 	return ret;
 }
@@ -3022,8 +3027,9 @@ static int hns_roce_v2_poll_one(struct hns_roce_cq *hr_cq,
 	if (!*cur_qp || (qpn & HNS_ROCE_V2_CQE_QPN_MASK) != (*cur_qp)->qpn) {
 		hr_qp = __hns_roce_qp_lookup(hr_dev, qpn);
 		if (unlikely(!hr_qp)) {
-			dev_err(hr_dev->dev, "CQ %06lx with entry for unknown QPN %06x\n",
-				hr_cq->cqn, (qpn & HNS_ROCE_V2_CQE_QPN_MASK));
+			ibdev_err(&hr_dev->ib_dev,
+				  "CQ %06lx with entry for unknown QPN %06x\n",
+				  hr_cq->cqn, qpn & HNS_ROCE_V2_CQE_QPN_MASK);
 			return -EINVAL;
 		}
 		*cur_qp = hr_qp;
@@ -3125,8 +3131,8 @@ static int hns_roce_v2_poll_one(struct hns_roce_cq *hr_cq,
 	 */
 	if (wc->status != IB_WC_SUCCESS &&
 	    wc->status != IB_WC_WR_FLUSH_ERR) {
-		dev_err(hr_dev->dev, "error cqe status is: 0x%x\n",
-			status & HNS_ROCE_V2_CQE_STATUS_MASK);
+		ibdev_err(&hr_dev->ib_dev, "error cqe status is: 0x%x\n",
+			  status & HNS_ROCE_V2_CQE_STATUS_MASK);
 
 		if (!test_and_set_bit(HNS_ROCE_FLUSH_FLAG, &hr_qp->flush_flag))
 			init_flush_work(hr_dev, hr_qp);
@@ -3974,21 +3980,22 @@ static bool check_wqe_rq_mtt_count(struct hns_roce_dev *hr_dev,
 				   struct hns_roce_qp *hr_qp, int mtt_cnt,
 				   u32 page_size)
 {
-	struct device *dev = hr_dev->dev;
+	struct ib_device *ibdev = &hr_dev->ib_dev;
 
 	if (hr_qp->rq.wqe_cnt < 1)
 		return true;
 
 	if (mtt_cnt < 1) {
-		dev_err(dev, "qp(0x%lx) rqwqe buf ba find failed\n",
-			hr_qp->qpn);
+		ibdev_err(ibdev, "failed to find RQWQE buf ba of QP(0x%lx)\n",
+			  hr_qp->qpn);
 		return false;
 	}
 
 	if (mtt_cnt < MTT_MIN_COUNT &&
 		(hr_qp->rq.offset + page_size) < hr_qp->buff_size) {
-		dev_err(dev, "qp(0x%lx) next rqwqe buf ba find failed\n",
-			hr_qp->qpn);
+		ibdev_err(ibdev,
+			  "failed to find next RQWQE buf ba of QP(0x%lx)\n",
+			  hr_qp->qpn);
 		return false;
 	}
 
@@ -4003,7 +4010,7 @@ static int modify_qp_init_to_rtr(struct ib_qp *ibqp,
 	const struct ib_global_route *grh = rdma_ah_read_grh(&attr->ah_attr);
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
 	struct hns_roce_qp *hr_qp = to_hr_qp(ibqp);
-	struct device *dev = hr_dev->dev;
+	struct ib_device *ibdev = &hr_dev->ib_dev;
 	u64 mtts[MTT_MIN_COUNT] = { 0 };
 	dma_addr_t dma_handle_3;
 	dma_addr_t dma_handle_2;
@@ -4030,7 +4037,7 @@ static int modify_qp_init_to_rtr(struct ib_qp *ibqp,
 	mtts_2 = hns_roce_table_find(hr_dev, &hr_dev->qp_table.irrl_table,
 				     hr_qp->qpn, &dma_handle_2);
 	if (!mtts_2) {
-		dev_err(dev, "qp irrl_table find failed\n");
+		ibdev_err(ibdev, "failed to find QP irrl_table\n");
 		return -EINVAL;
 	}
 
@@ -4038,12 +4045,13 @@ static int modify_qp_init_to_rtr(struct ib_qp *ibqp,
 	mtts_3 = hns_roce_table_find(hr_dev, &hr_dev->qp_table.trrl_table,
 				     hr_qp->qpn, &dma_handle_3);
 	if (!mtts_3) {
-		dev_err(dev, "qp trrl_table find failed\n");
+		ibdev_err(ibdev, "failed to find QP trrl_table\n");
 		return -EINVAL;
 	}
 
 	if (attr_mask & IB_QP_ALT_PATH) {
-		dev_err(dev, "INIT2RTR attr_mask (0x%x) error\n", attr_mask);
+		ibdev_err(ibdev, "INIT2RTR attr_mask (0x%x) error\n",
+			  attr_mask);
 		return -EINVAL;
 	}
 
@@ -4246,7 +4254,7 @@ static int modify_qp_rtr_to_rts(struct ib_qp *ibqp,
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
 	struct hns_roce_qp *hr_qp = to_hr_qp(ibqp);
-	struct device *dev = hr_dev->dev;
+	struct ib_device *ibdev = &hr_dev->ib_dev;
 	u64 sge_cur_blk = 0;
 	u64 sq_cur_blk = 0;
 	u32 page_size;
@@ -4255,7 +4263,8 @@ static int modify_qp_rtr_to_rts(struct ib_qp *ibqp,
 	/* Search qp buf's mtts */
 	count = hns_roce_mtr_find(hr_dev, &hr_qp->mtr, 0, &sq_cur_blk, 1, NULL);
 	if (count < 1) {
-		dev_err(dev, "qp(0x%lx) buf pa find failed\n", hr_qp->qpn);
+		ibdev_err(ibdev, "failed to find buf pa of QP(0x%lx)\n",
+			  hr_qp->qpn);
 		return -EINVAL;
 	}
 
@@ -4265,8 +4274,8 @@ static int modify_qp_rtr_to_rts(struct ib_qp *ibqp,
 					  hr_qp->sge.offset / page_size,
 					  &sge_cur_blk, 1, NULL);
 		if (count < 1) {
-			dev_err(dev, "qp(0x%lx) sge pa find failed\n",
-				hr_qp->qpn);
+			ibdev_err(ibdev, "failed to find sge pa of QP(0x%lx)\n",
+				  hr_qp->qpn);
 			return -EINVAL;
 		}
 	}
@@ -4274,7 +4283,7 @@ static int modify_qp_rtr_to_rts(struct ib_qp *ibqp,
 	/* Not support alternate path and path migration */
 	if ((attr_mask & IB_QP_ALT_PATH) ||
 	    (attr_mask & IB_QP_PATH_MIG_STATE)) {
-		dev_err(dev, "RTR2RTS attr_mask (0x%x)error\n", attr_mask);
+		ibdev_err(ibdev, "RTR2RTS attr_mask (0x%x)error\n", attr_mask);
 		return -EINVAL;
 	}
 
@@ -4392,6 +4401,7 @@ static int hns_roce_v2_set_path(struct ib_qp *ibqp,
 	const struct ib_global_route *grh = rdma_ah_read_grh(&attr->ah_attr);
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
 	struct hns_roce_qp *hr_qp = to_hr_qp(ibqp);
+	struct ib_device *ibdev = &hr_dev->ib_dev;
 	const struct ib_gid_attr *gid_attr = NULL;
 	int is_roce_protocol;
 	u16 vlan_id = 0xffff;
@@ -4433,13 +4443,13 @@ static int hns_roce_v2_set_path(struct ib_qp *ibqp,
 		       V2_QPC_BYTE_24_VLAN_ID_S, 0);
 
 	if (grh->sgid_index >= hr_dev->caps.gid_table_len[hr_port]) {
-		dev_err(hr_dev->dev, "sgid_index(%u) too large. max is %d\n",
-			grh->sgid_index, hr_dev->caps.gid_table_len[hr_port]);
+		ibdev_err(ibdev, "sgid_index(%u) too large. max is %d\n",
+			  grh->sgid_index, hr_dev->caps.gid_table_len[hr_port]);
 		return -EINVAL;
 	}
 
 	if (attr->ah_attr.type != RDMA_AH_ATTR_TYPE_ROCE) {
-		dev_err(hr_dev->dev, "ah attr is not RDMA roce type\n");
+		ibdev_err(ibdev, "ah attr is not RDMA roce type\n");
 		return -EINVAL;
 	}
 
@@ -4517,7 +4527,7 @@ static int hns_roce_v2_set_abs_fields(struct ib_qp *ibqp,
 		/* Nothing */
 		;
 	} else {
-		dev_err(hr_dev->dev, "Illegal state for QP!\n");
+		ibdev_err(&hr_dev->ib_dev, "Illegal state for QP!\n");
 		ret = -EINVAL;
 		goto out;
 	}
@@ -4552,8 +4562,8 @@ static int hns_roce_v2_set_opt_fields(struct ib_qp *ibqp,
 				       V2_QPC_BYTE_28_AT_M, V2_QPC_BYTE_28_AT_S,
 				       0);
 		} else {
-			dev_warn(hr_dev->dev,
-				 "Local ACK timeout shall be 0 to 30.\n");
+			ibdev_warn(&hr_dev->ib_dev,
+				   "Local ACK timeout shall be 0 to 30.\n");
 		}
 	}
 
@@ -4721,7 +4731,7 @@ static int hns_roce_v2_modify_qp(struct ib_qp *ibqp,
 	struct hns_roce_v2_qp_context ctx[2];
 	struct hns_roce_v2_qp_context *context = ctx;
 	struct hns_roce_v2_qp_context *qpc_mask = ctx + 1;
-	struct device *dev = hr_dev->dev;
+	struct ib_device *ibdev = &hr_dev->ib_dev;
 	unsigned long sq_flag = 0;
 	unsigned long rq_flag = 0;
 	int ret;
@@ -4785,7 +4795,7 @@ static int hns_roce_v2_modify_qp(struct ib_qp *ibqp,
 	/* SW pass context to HW */
 	ret = hns_roce_v2_qp_modify(hr_dev, ctx, hr_qp);
 	if (ret) {
-		dev_err(dev, "hns_roce_qp_modify failed(%d)\n", ret);
+		ibdev_err(ibdev, "failed to modify QP, ret = %d\n", ret);
 		goto out;
 	}
 
@@ -4842,10 +4852,8 @@ static int hns_roce_v2_query_qpc(struct hns_roce_dev *hr_dev,
 	ret = hns_roce_cmd_mbox(hr_dev, 0, mailbox->dma, hr_qp->qpn, 0,
 				HNS_ROCE_CMD_QUERY_QPC,
 				HNS_ROCE_CMD_TIMEOUT_MSECS);
-	if (ret) {
-		dev_err(hr_dev->dev, "QUERY QP cmd process error\n");
+	if (ret)
 		goto out;
-	}
 
 	memcpy(hr_context, mailbox->buf, sizeof(*hr_context));
 
@@ -4861,7 +4869,7 @@ static int hns_roce_v2_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
 	struct hns_roce_qp *hr_qp = to_hr_qp(ibqp);
 	struct hns_roce_v2_qp_context context = {};
-	struct device *dev = hr_dev->dev;
+	struct ib_device *ibdev = &hr_dev->ib_dev;
 	int tmp_qp_state;
 	int state;
 	int ret;
@@ -4879,7 +4887,7 @@ static int hns_roce_v2_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
 
 	ret = hns_roce_v2_query_qpc(hr_dev, hr_qp, &context);
 	if (ret) {
-		dev_err(dev, "query qpc error\n");
+		ibdev_err(ibdev, "failed to query QPC, ret = %d\n", ret);
 		ret = -EINVAL;
 		goto out;
 	}
@@ -4888,7 +4896,7 @@ static int hns_roce_v2_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
 			       V2_QPC_BYTE_60_QP_ST_M, V2_QPC_BYTE_60_QP_ST_S);
 	tmp_qp_state = to_ib_qp_st((enum hns_roce_v2_qp_state)state);
 	if (tmp_qp_state == -1) {
-		dev_err(dev, "Illegal ib_qp_state\n");
+		ibdev_err(ibdev, "Illegal ib_qp_state\n");
 		ret = -EINVAL;
 		goto out;
 	}
@@ -4986,8 +4994,8 @@ static int hns_roce_v2_destroy_qp_common(struct hns_roce_dev *hr_dev,
 					 struct hns_roce_qp *hr_qp,
 					 struct ib_udata *udata)
 {
-	struct hns_roce_cq *send_cq, *recv_cq;
 	struct ib_device *ibdev = &hr_dev->ib_dev;
+	struct hns_roce_cq *send_cq, *recv_cq;
 	unsigned long flags;
 	int ret = 0;
 
@@ -4996,7 +5004,9 @@ static int hns_roce_v2_destroy_qp_common(struct hns_roce_dev *hr_dev,
 		ret = hns_roce_v2_modify_qp(&hr_qp->ibqp, NULL, 0,
 					    hr_qp->state, IB_QPS_RESET);
 		if (ret)
-			ibdev_err(ibdev, "modify QP to Reset failed.\n");
+			ibdev_err(ibdev,
+				  "failed to modify QP to RST, ret = %d\n",
+				  ret);
 	}
 
 	send_cq = hr_qp->ibqp.send_cq ? to_hr_cq(hr_qp->ibqp.send_cq) : NULL;
@@ -5033,7 +5043,8 @@ static int hns_roce_v2_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 
 	ret = hns_roce_v2_destroy_qp_common(hr_dev, hr_qp, udata);
 	if (ret)
-		ibdev_err(&hr_dev->ib_dev, "Destroy qp 0x%06lx failed(%d)\n",
+		ibdev_err(&hr_dev->ib_dev,
+			  "failed to destroy QP 0x%06lx, ret = %d\n",
 			  hr_qp->qpn, ret);
 
 	hns_roce_qp_destroy(hr_dev, hr_qp, udata);
@@ -5042,8 +5053,9 @@ static int hns_roce_v2_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 }
 
 static int hns_roce_v2_qp_flow_control_init(struct hns_roce_dev *hr_dev,
-						struct hns_roce_qp *hr_qp)
+					    struct hns_roce_qp *hr_qp)
 {
+	struct ib_device *ibdev = &hr_dev->ib_dev;
 	struct hns_roce_sccc_clr_done *resp;
 	struct hns_roce_sccc_clr *clr;
 	struct hns_roce_cmq_desc desc;
@@ -5055,7 +5067,7 @@ static int hns_roce_v2_qp_flow_control_init(struct hns_roce_dev *hr_dev,
 	hns_roce_cmq_setup_basic_desc(&desc, HNS_ROCE_OPC_RESET_SCCC, false);
 	ret =  hns_roce_cmq_send(hr_dev, &desc, 1);
 	if (ret) {
-		dev_err(hr_dev->dev, "Reset SCC ctx  failed(%d)\n", ret);
+		ibdev_err(ibdev, "failed to reset SCC ctx, ret = %d\n", ret);
 		goto out;
 	}
 
@@ -5065,7 +5077,7 @@ static int hns_roce_v2_qp_flow_control_init(struct hns_roce_dev *hr_dev,
 	clr->qpn = cpu_to_le32(hr_qp->qpn);
 	ret =  hns_roce_cmq_send(hr_dev, &desc, 1);
 	if (ret) {
-		dev_err(hr_dev->dev, "Clear SCC ctx failed(%d)\n", ret);
+		ibdev_err(ibdev, "failed to clear SCC ctx, ret = %d\n", ret);
 		goto out;
 	}
 
@@ -5076,7 +5088,8 @@ static int hns_roce_v2_qp_flow_control_init(struct hns_roce_dev *hr_dev,
 					      HNS_ROCE_OPC_QUERY_SCCC, true);
 		ret = hns_roce_cmq_send(hr_dev, &desc, 1);
 		if (ret) {
-			dev_err(hr_dev->dev, "Query clr cmq failed(%d)\n", ret);
+			ibdev_err(ibdev, "failed to query clr cmq, ret = %d\n",
+				  ret);
 			goto out;
 		}
 
@@ -5086,7 +5099,7 @@ static int hns_roce_v2_qp_flow_control_init(struct hns_roce_dev *hr_dev,
 		msleep(20);
 	}
 
-	dev_err(hr_dev->dev, "Query SCC clr done flag overtime.\n");
+	ibdev_err(ibdev, "Query SCC clr done flag overtime.\n");
 	ret = -ETIMEDOUT;
 
 out:
@@ -5130,7 +5143,9 @@ static int hns_roce_v2_modify_cq(struct ib_cq *cq, u16 cq_count, u16 cq_period)
 				HNS_ROCE_CMD_TIMEOUT_MSECS);
 	hns_roce_free_cmd_mailbox(hr_dev, mailbox);
 	if (ret)
-		dev_err(hr_dev->dev, "MODIFY CQ Failed to cmd mailbox.\n");
+		ibdev_err(&hr_dev->ib_dev,
+			  "failed to process cmd when modifying CQ, ret = %d\n",
+			  ret);
 
 	return ret;
 }
@@ -5139,54 +5154,54 @@ static void hns_roce_irq_work_handle(struct work_struct *work)
 {
 	struct hns_roce_work *irq_work =
 				container_of(work, struct hns_roce_work, work);
-	struct device *dev = irq_work->hr_dev->dev;
+	struct ib_device *ibdev = &irq_work->hr_dev->ib_dev;
 	u32 qpn = irq_work->qpn;
 	u32 cqn = irq_work->cqn;
 
 	switch (irq_work->event_type) {
 	case HNS_ROCE_EVENT_TYPE_PATH_MIG:
-		dev_info(dev, "Path migrated succeeded.\n");
+		ibdev_info(ibdev, "Path migrated succeeded.\n");
 		break;
 	case HNS_ROCE_EVENT_TYPE_PATH_MIG_FAILED:
-		dev_warn(dev, "Path migration failed.\n");
+		ibdev_warn(ibdev, "Path migration failed.\n");
 		break;
 	case HNS_ROCE_EVENT_TYPE_COMM_EST:
 		break;
 	case HNS_ROCE_EVENT_TYPE_SQ_DRAINED:
-		dev_warn(dev, "Send queue drained.\n");
+		ibdev_warn(ibdev, "Send queue drained.\n");
 		break;
 	case HNS_ROCE_EVENT_TYPE_WQ_CATAS_ERROR:
-		dev_err(dev, "Local work queue 0x%x catas error, sub_type:%d\n",
-			qpn, irq_work->sub_type);
+		ibdev_err(ibdev, "Local work queue 0x%x catast error, sub_event type is: %d\n",
+			  qpn, irq_work->sub_type);
 		break;
 	case HNS_ROCE_EVENT_TYPE_INV_REQ_LOCAL_WQ_ERROR:
-		dev_err(dev, "Invalid request local work queue 0x%x error.\n",
-			qpn);
+		ibdev_err(ibdev, "Invalid request local work queue 0x%x error.\n",
+			  qpn);
 		break;
 	case HNS_ROCE_EVENT_TYPE_LOCAL_WQ_ACCESS_ERROR:
-		dev_err(dev, "Local access violation work queue 0x%x error, sub_type:%d\n",
-			qpn, irq_work->sub_type);
+		ibdev_err(ibdev, "Local access violation work queue 0x%x error, sub_event type is: %d\n",
+			  qpn, irq_work->sub_type);
 		break;
 	case HNS_ROCE_EVENT_TYPE_SRQ_LIMIT_REACH:
-		dev_warn(dev, "SRQ limit reach.\n");
+		ibdev_warn(ibdev, "SRQ limit reach.\n");
 		break;
 	case HNS_ROCE_EVENT_TYPE_SRQ_LAST_WQE_REACH:
-		dev_warn(dev, "SRQ last wqe reach.\n");
+		ibdev_warn(ibdev, "SRQ last wqe reach.\n");
 		break;
 	case HNS_ROCE_EVENT_TYPE_SRQ_CATAS_ERROR:
-		dev_err(dev, "SRQ catas error.\n");
+		ibdev_err(ibdev, "SRQ catas error.\n");
 		break;
 	case HNS_ROCE_EVENT_TYPE_CQ_ACCESS_ERROR:
-		dev_err(dev, "CQ 0x%x access err.\n", cqn);
+		ibdev_err(ibdev, "CQ 0x%x access err.\n", cqn);
 		break;
 	case HNS_ROCE_EVENT_TYPE_CQ_OVERFLOW:
-		dev_warn(dev, "CQ 0x%x overflow\n", cqn);
+		ibdev_warn(ibdev, "CQ 0x%x overflow\n", cqn);
 		break;
 	case HNS_ROCE_EVENT_TYPE_DB_OVERFLOW:
-		dev_warn(dev, "DB overflow.\n");
+		ibdev_warn(ibdev, "DB overflow.\n");
 		break;
 	case HNS_ROCE_EVENT_TYPE_FLR:
-		dev_warn(dev, "Function level reset.\n");
+		ibdev_warn(ibdev, "Function level reset.\n");
 		break;
 	default:
 		break;
@@ -6119,8 +6134,9 @@ static int hns_roce_v2_modify_srq(struct ib_srq *ibsrq,
 					HNS_ROCE_CMD_TIMEOUT_MSECS);
 		hns_roce_free_cmd_mailbox(hr_dev, mailbox);
 		if (ret) {
-			dev_err(hr_dev->dev,
-				"MODIFY SRQ Failed to cmd mailbox.\n");
+			ibdev_err(&hr_dev->ib_dev,
+				  "failed to process cmd when modifying SRQ, ret = %d\n",
+				  ret);
 			return ret;
 		}
 	}
@@ -6146,7 +6162,9 @@ static int hns_roce_v2_query_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr)
 				HNS_ROCE_CMD_QUERY_SRQC,
 				HNS_ROCE_CMD_TIMEOUT_MSECS);
 	if (ret) {
-		dev_err(hr_dev->dev, "QUERY SRQ cmd process error\n");
+		ibdev_err(&hr_dev->ib_dev,
+			  "failed to process cmd when querying SRQ, ret = %d\n",
+			  ret);
 		goto out;
 	}
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_pd.c b/drivers/infiniband/hw/hns/hns_roce_pd.c
index 780c780..b10c50b 100644
--- a/drivers/infiniband/hw/hns/hns_roce_pd.c
+++ b/drivers/infiniband/hw/hns/hns_roce_pd.c
@@ -60,14 +60,12 @@ void hns_roce_cleanup_pd_table(struct hns_roce_dev *hr_dev)
 int hns_roce_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 {
 	struct ib_device *ib_dev = ibpd->device;
-	struct hns_roce_dev *hr_dev = to_hr_dev(ib_dev);
-	struct device *dev = hr_dev->dev;
 	struct hns_roce_pd *pd = to_hr_pd(ibpd);
 	int ret;
 
 	ret = hns_roce_pd_alloc(to_hr_dev(ib_dev), &pd->pdn);
 	if (ret) {
-		dev_err(dev, "[alloc_pd]hns_roce_pd_alloc failed!\n");
+		ibdev_err(ib_dev, "failed to alloc pd, ret = %d\n", ret);
 		return ret;
 	}
 
@@ -76,7 +74,7 @@ int hns_roce_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 
 		if (ib_copy_to_udata(udata, &uresp, sizeof(uresp))) {
 			hns_roce_pd_free(to_hr_dev(ib_dev), pd->pdn);
-			dev_err(dev, "[alloc_pd]ib_copy_to_udata failed!\n");
+			ibdev_err(ib_dev, "failed to copy to udata\n");
 			return -EFAULT;
 		}
 	}
-- 
2.8.1

