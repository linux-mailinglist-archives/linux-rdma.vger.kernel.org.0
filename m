Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFB85497FC7
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jan 2022 13:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241857AbiAXMqL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Jan 2022 07:46:11 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:35859 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241864AbiAXMqK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Jan 2022 07:46:10 -0500
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Jj8pS20cszccT2;
        Mon, 24 Jan 2022 20:45:20 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 24 Jan 2022 20:46:08 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 24 Jan 2022 20:46:08 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>
Subject: [PATCH for-next 3/4] RDMA/hns: Add support for QP's restrack attributes
Date:   Mon, 24 Jan 2022 20:46:23 +0800
Message-ID: <20220124124624.55352-4-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220124124624.55352-1-liangwenpeng@huawei.com>
References: <20220124124624.55352-1-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The restrack attributes of QP come from the QPC and the queue information
maintained by the software code.

Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h   |   2 +
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c    |  16 +--
 drivers/infiniband/hw/hns/hns_roce_main.c     |   1 +
 drivers/infiniband/hw/hns/hns_roce_restrack.c | 116 ++++++++++++++++++
 4 files changed, 128 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 43e4b2945bf7..a34c12970200 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -881,6 +881,7 @@ struct hns_roce_hw {
 	void (*cleanup_eq)(struct hns_roce_dev *hr_dev);
 	int (*write_srqc)(struct hns_roce_srq *srq, void *mb_buf);
 	int (*query_cqc)(struct hns_roce_dev *hr_dev, u32 cqn, void *buffer);
+	int (*query_qpc)(struct hns_roce_dev *hr_dev, u32 qpn, void *buffer);
 	const struct ib_device_ops *hns_roce_dev_ops;
 	const struct ib_device_ops *hns_roce_dev_srq_ops;
 };
@@ -1214,6 +1215,7 @@ void hns_roce_handle_device_err(struct hns_roce_dev *hr_dev);
 int hns_roce_init(struct hns_roce_dev *hr_dev);
 void hns_roce_exit(struct hns_roce_dev *hr_dev);
 int hns_roce_fill_res_cq_entry(struct sk_buff *msg, struct ib_cq *ibcq);
+int hns_roce_fill_res_qp_entry(struct sk_buff *msg, struct ib_qp *ibqp);
 struct hns_user_mmap_entry *
 hns_roce_user_mmap_entry_insert(struct ib_ucontext *ucontext, u64 address,
 				size_t length,
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 3c079fadd1e7..4912c531ef91 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -5050,9 +5050,8 @@ static int to_ib_qp_st(enum hns_roce_v2_qp_state state)
 	return (state < ARRAY_SIZE(map)) ? map[state] : -1;
 }
 
-static int hns_roce_v2_query_qpc(struct hns_roce_dev *hr_dev,
-				 struct hns_roce_qp *hr_qp,
-				 struct hns_roce_v2_qp_context *hr_context)
+static int hns_roce_v2_query_qpc(struct hns_roce_dev *hr_dev, u32 qpn,
+				 void *buffer)
 {
 	struct hns_roce_cmd_mailbox *mailbox;
 	int ret;
@@ -5061,13 +5060,15 @@ static int hns_roce_v2_query_qpc(struct hns_roce_dev *hr_dev,
 	if (IS_ERR(mailbox))
 		return PTR_ERR(mailbox);
 
-	ret = hns_roce_cmd_mbox(hr_dev, 0, mailbox->dma, hr_qp->qpn, 0,
+	ret = hns_roce_cmd_mbox(hr_dev, 0, mailbox->dma, qpn, 0,
 				HNS_ROCE_CMD_QUERY_QPC,
 				HNS_ROCE_CMD_TIMEOUT_MSECS);
-	if (ret)
+	if (ret) {
+		dev_err(hr_dev->dev, "QUERY qpc cmd process error.\n");
 		goto out;
+	}
 
-	memcpy(hr_context, mailbox->buf, hr_dev->caps.qpc_sz);
+	memcpy(buffer, mailbox->buf, hr_dev->caps.qpc_sz);
 
 out:
 	hns_roce_free_cmd_mailbox(hr_dev, mailbox);
@@ -5097,7 +5098,7 @@ static int hns_roce_v2_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
 		goto done;
 	}
 
-	ret = hns_roce_v2_query_qpc(hr_dev, hr_qp, &context);
+	ret = hns_roce_v2_query_qpc(hr_dev, hr_qp->qpn, &context);
 	if (ret) {
 		ibdev_err(ibdev, "failed to query QPC, ret = %d.\n", ret);
 		ret = -EINVAL;
@@ -6237,6 +6238,7 @@ static const struct hns_roce_hw hns_roce_hw_v2 = {
 	.cleanup_eq = hns_roce_v2_cleanup_eq_table,
 	.write_srqc = hns_roce_v2_write_srqc,
 	.query_cqc = hns_roce_v2_query_cqc,
+	.query_qpc = hns_roce_v2_query_qpc,
 	.hns_roce_dev_ops = &hns_roce_v2_dev_ops,
 	.hns_roce_dev_srq_ops = &hns_roce_v2_dev_srq_ops,
 };
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index f73ba619f375..cf33182355c1 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -516,6 +516,7 @@ static const struct ib_device_ops hns_roce_dev_ops = {
 	.destroy_cq = hns_roce_destroy_cq,
 	.disassociate_ucontext = hns_roce_disassociate_ucontext,
 	.fill_res_cq_entry = hns_roce_fill_res_cq_entry,
+	.fill_res_qp_entry = hns_roce_fill_res_qp_entry,
 	.get_dma_mr = hns_roce_get_dma_mr,
 	.get_link_layer = hns_roce_get_link_layer,
 	.get_port_immutable = hns_roce_port_immutable,
diff --git a/drivers/infiniband/hw/hns/hns_roce_restrack.c b/drivers/infiniband/hw/hns/hns_roce_restrack.c
index a0d601cd2cb6..9bc0b15e8d1a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_restrack.c
+++ b/drivers/infiniband/hw/hns/hns_roce_restrack.c
@@ -86,3 +86,119 @@ int hns_roce_fill_res_cq_entry(struct sk_buff *msg, struct ib_cq *ibcq)
 	nla_nest_cancel(msg, table_attr);
 	return -EMSGSIZE;
 }
+
+static int hns_roce_fill_qp(struct hns_roce_qp *hr_qp,
+			    struct sk_buff *msg,
+			    struct hns_roce_v2_qp_context *context)
+{
+	static struct {
+		char *name;
+		u32 mask;
+		u32 l;
+	} reg[] = {
+		{ "tst", HR_REG_CFG(QPC_TST) },
+		{ "qp_st", HR_REG_CFG(QPC_QP_ST) },
+		{ "chk_flg", HR_REG_CFG(QPC_CHECK_FLG) },
+		{ "err_type", HR_REG_CFG(QPC_ERR_TYPE) },
+		{ "srq_en", HR_REG_CFG(QPC_SRQ_EN) },
+		{ "srqn", HR_REG_CFG(QPC_SRQN) },
+		{ "qkey_xrcd", HR_REG_CFG(QPC_QKEY_XRCD) },
+		{ "tx_cqn", HR_REG_CFG(QPC_TX_CQN) },
+		{ "rx_cqn", HR_REG_CFG(QPC_RX_CQN) },
+		{ "sq_pi", HR_REG_CFG(QPC_SQ_PRODUCER_IDX) },
+		{ "sq_ci", HR_REG_CFG(QPC_SQ_CONSUMER_IDX) },
+		{ "rq_pi", HR_REG_CFG(QPC_RQ_PRODUCER_IDX) },
+		{ "rq_ci", HR_REG_CFG(QPC_RQ_CONSUMER_IDX) },
+		{ "sq_shift", HR_REG_CFG(QPC_SQ_SHIFT) },
+		{ "rqws", HR_REG_CFG(QPC_RQWS) },
+		{ "rq_shift", HR_REG_CFG(QPC_RQ_SHIFT) },
+		{ "sge_shift", HR_REG_CFG(QPC_SGE_SHIFT) },
+		{ "max_ird", HR_REG_CFG(QPC_SR_MAX) },
+		{ "max_ord", HR_REG_CFG(QPC_RR_MAX) },
+		{ "gmv_idx", HR_REG_CFG(QPC_GMV_IDX) },
+		{ "sq_vlan_en", HR_REG_CFG(QPC_SQ_VLAN_EN) },
+		{ "rq_vlan_en", HR_REG_CFG(QPC_RQ_VLAN_EN) },
+		{ "vlan_id", HR_REG_CFG(QPC_VLAN_ID) },
+		{ "mtu", HR_REG_CFG(QPC_MTU) },
+		{ "hop_limit", HR_REG_CFG(QPC_HOPLIMIT) },
+		{ "tc", HR_REG_CFG(QPC_TC) },
+		{ "fl", HR_REG_CFG(QPC_FL) },
+		{ "sl", HR_REG_CFG(QPC_SL) },
+		{ "rre", HR_REG_CFG(QPC_RRE) },
+		{ "rwe", HR_REG_CFG(QPC_RWE) },
+		{ "ate", HR_REG_CFG(QPC_ATE) },
+		{ "ext_ate", HR_REG_CFG(QPC_EXT_ATE) },
+		{ "fre", HR_REG_CFG(QPC_FRE) },
+		{ "rmt_e2e", HR_REG_CFG(QPC_RMT_E2E) },
+		{ "retry_num_init", HR_REG_CFG(QPC_RETRY_NUM_INIT) },
+		{ "retry_cnt", HR_REG_CFG(QPC_RETRY_CNT) },
+		{ "flush_idx", HR_REG_CFG(QPC_SQ_FLUSH_IDX) },
+		{ "sq_max_idx", HR_REG_CFG(QPC_SQ_MAX_IDX) },
+		{ "sq_tx_err", HR_REG_CFG(QPC_SQ_TX_ERR) },
+		{ "sq_rx_err", HR_REG_CFG(QPC_SQ_RX_ERR) },
+		{ "rq_rx_err", HR_REG_CFG(QPC_RQ_RX_ERR) },
+		{ "rq_tx_err", HR_REG_CFG(QPC_RQ_TX_ERR) },
+		{ "rq_cqeidx", HR_REG_CFG(QPC_RQ_CQE_IDX) },
+		{ "rq_rty_tx_err", HR_REG_CFG(QPC_RQ_RTY_TX_ERR) },
+	};
+	__le32 *qpc = (void *)context;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(reg); i++)
+		if (rdma_nl_put_driver_u32_hex(
+			msg, reg[i].name,
+			(le32_to_cpu(qpc[reg[i].l / 32]) & reg[i].mask) >>
+				(reg[i].l % 32)))
+			goto err;
+
+	if (rdma_nl_put_driver_u32_hex(msg, "soft_sq_head_wqe", hr_qp->sq.head))
+		goto err;
+
+	if (rdma_nl_put_driver_u32_hex(msg, "soft_sq_tail_wqe", hr_qp->sq.tail))
+		goto err;
+
+	if (rdma_nl_put_driver_u32_hex(msg, "soft_rq_head_wqe", hr_qp->rq.head))
+		goto err;
+
+	if (rdma_nl_put_driver_u32_hex(msg, "soft_rq_tail_wqe", hr_qp->rq.tail))
+		goto err;
+
+	if (rdma_nl_put_driver_u32_hex(msg, "soft_next_sge", hr_qp->next_sge))
+		goto err;
+
+	return 0;
+
+err:
+	return -EMSGSIZE;
+}
+
+int hns_roce_fill_res_qp_entry(struct sk_buff *msg, struct ib_qp *ibqp)
+{
+	struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
+	struct hns_roce_qp *hr_qp = to_hr_qp(ibqp);
+	struct hns_roce_v2_qp_context context;
+	struct nlattr *table_attr;
+	int ret;
+
+	if (!hr_dev->hw->query_qpc)
+		return -EINVAL;
+
+	ret = hr_dev->hw->query_qpc(hr_dev, hr_qp->qpn, &context);
+	if (ret)
+		return -EINVAL;
+
+	table_attr = nla_nest_start(msg, RDMA_NLDEV_ATTR_DRIVER);
+	if (!table_attr)
+		return -EMSGSIZE;
+
+	if (hns_roce_fill_qp(hr_qp, msg, &context))
+		goto err_cancel_table;
+
+	nla_nest_end(msg, table_attr);
+
+	return 0;
+
+err_cancel_table:
+	nla_nest_cancel(msg, table_attr);
+	return -EMSGSIZE;
+}
-- 
2.33.0

