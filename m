Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F02FB59BDC5
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Aug 2022 12:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233009AbiHVKpr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Aug 2022 06:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233798AbiHVKpg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Aug 2022 06:45:36 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4F92D1FE
        for <linux-rdma@vger.kernel.org>; Mon, 22 Aug 2022 03:45:31 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MB89N3h99zGpm3;
        Mon, 22 Aug 2022 18:43:52 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 22 Aug 2022 18:45:30 +0800
Received: from localhost.localdomain (10.67.165.2) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 22 Aug 2022 18:45:30 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>
Subject: [PATCH v2 for-next 5/7] RDMA/hns: Support QP's restrack raw ops for hns driver
Date:   Mon, 22 Aug 2022 18:44:53 +0800
Message-ID: <20220822104455.2311053-6-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20220822104455.2311053-1-liangwenpeng@huawei.com>
References: <20220822104455.2311053-1-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The QP raw restrack attributes come from the queue context maintained by
the ROCEE.

For example:

$ rdma res show qp link hns_0 -jp -dd -r
[ {
        "ifindex": 4,
        "ifname": "hns_0",
        "data": [ 2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,0,0,0,
		  5,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,255,156,0,0,63,156,0,0,
		  7,0,0,0,1,0,0,0,9,0,0,0,0,0,0,0,2,0,0,0,2,0,0,0,0,0,0,
		  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
		  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,63,156,0,
		  0,0,0,0,0 ]
    } ]

Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h   |  2 +
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c    | 12 ++--
 drivers/infiniband/hw/hns/hns_roce_main.c     |  1 +
 drivers/infiniband/hw/hns/hns_roce_restrack.c | 56 +++++++++++++++++++
 4 files changed, 65 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 7578c0c6313b..e0395870b819 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -895,6 +895,7 @@ struct hns_roce_hw {
 	void (*cleanup_eq)(struct hns_roce_dev *hr_dev);
 	int (*write_srqc)(struct hns_roce_srq *srq, void *mb_buf);
 	int (*query_cqc)(struct hns_roce_dev *hr_dev, u32 cqn, void *buffer);
+	int (*query_qpc)(struct hns_roce_dev *hr_dev, u32 qpn, void *buffer);
 	const struct ib_device_ops *hns_roce_dev_ops;
 	const struct ib_device_ops *hns_roce_dev_srq_ops;
 };
@@ -1226,6 +1227,7 @@ void hns_roce_exit(struct hns_roce_dev *hr_dev);
 int hns_roce_fill_res_cq_entry(struct sk_buff *msg, struct ib_cq *ib_cq);
 int hns_roce_fill_res_cq_entry_raw(struct sk_buff *msg, struct ib_cq *ib_cq);
 int hns_roce_fill_res_qp_entry(struct sk_buff *msg, struct ib_qp *ib_qp);
+int hns_roce_fill_res_qp_entry_raw(struct sk_buff *msg, struct ib_qp *ib_qp);
 struct hns_user_mmap_entry *
 hns_roce_user_mmap_entry_insert(struct ib_ucontext *ucontext, u64 address,
 				size_t length,
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 979cd57a72fb..319de9a4d2ef 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -5307,9 +5307,8 @@ static int to_ib_qp_st(enum hns_roce_v2_qp_state state)
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
@@ -5319,11 +5318,11 @@ static int hns_roce_v2_query_qpc(struct hns_roce_dev *hr_dev,
 		return PTR_ERR(mailbox);
 
 	ret = hns_roce_cmd_mbox(hr_dev, 0, mailbox->dma, HNS_ROCE_CMD_QUERY_QPC,
-				hr_qp->qpn);
+				qpn);
 	if (ret)
 		goto out;
 
-	memcpy(hr_context, mailbox->buf, hr_dev->caps.qpc_sz);
+	memcpy(buffer, mailbox->buf, hr_dev->caps.qpc_sz);
 
 out:
 	hns_roce_free_cmd_mailbox(hr_dev, mailbox);
@@ -5353,7 +5352,7 @@ static int hns_roce_v2_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
 		goto done;
 	}
 
-	ret = hns_roce_v2_query_qpc(hr_dev, hr_qp, &context);
+	ret = hns_roce_v2_query_qpc(hr_dev, hr_qp->qpn, &context);
 	if (ret) {
 		ibdev_err(ibdev, "failed to query QPC, ret = %d.\n", ret);
 		ret = -EINVAL;
@@ -6645,6 +6644,7 @@ static const struct hns_roce_hw hns_roce_hw_v2 = {
 	.cleanup_eq = hns_roce_v2_cleanup_eq_table,
 	.write_srqc = hns_roce_v2_write_srqc,
 	.query_cqc = hns_roce_v2_query_cqc,
+	.query_qpc = hns_roce_v2_query_qpc,
 	.hns_roce_dev_ops = &hns_roce_v2_dev_ops,
 	.hns_roce_dev_srq_ops = &hns_roce_v2_dev_srq_ops,
 };
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 87442027b808..17bc73c108f2 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -569,6 +569,7 @@ static const struct ib_device_ops hns_roce_dev_restrack_ops = {
 	.fill_res_cq_entry = hns_roce_fill_res_cq_entry,
 	.fill_res_cq_entry_raw = hns_roce_fill_res_cq_entry_raw,
 	.fill_res_qp_entry = hns_roce_fill_res_qp_entry,
+	.fill_res_qp_entry_raw = hns_roce_fill_res_qp_entry_raw,
 };
 
 static int hns_roce_register_device(struct hns_roce_dev *hr_dev)
diff --git a/drivers/infiniband/hw/hns/hns_roce_restrack.c b/drivers/infiniband/hw/hns/hns_roce_restrack.c
index e8fef37f810d..9bafc627864b 100644
--- a/drivers/infiniband/hw/hns/hns_roce_restrack.c
+++ b/drivers/infiniband/hw/hns/hns_roce_restrack.c
@@ -112,3 +112,59 @@ int hns_roce_fill_res_qp_entry(struct sk_buff *msg, struct ib_qp *ib_qp)
 
 	return -EMSGSIZE;
 }
+
+int hns_roce_fill_res_qp_entry_raw(struct sk_buff *msg, struct ib_qp *ib_qp)
+{
+	struct hns_roce_dev *hr_dev = to_hr_dev(ib_qp->device);
+	struct hns_roce_qp *hr_qp = to_hr_qp(ib_qp);
+	struct hns_roce_v2_qp_context context;
+	u32 data[MAX_ENTRY_NUM] = {};
+	int offset = 0;
+	int ret;
+
+	if (!hr_dev->hw->query_qpc)
+		return -EINVAL;
+
+	ret = hr_dev->hw->query_qpc(hr_dev, hr_qp->qpn, &context);
+	if (ret)
+		return -EINVAL;
+
+	data[offset++] = hr_reg_read(&context, QPC_QP_ST);
+	data[offset++] = hr_reg_read(&context, QPC_ERR_TYPE);
+	data[offset++] = hr_reg_read(&context, QPC_CHECK_FLG);
+	data[offset++] = hr_reg_read(&context, QPC_SRQ_EN);
+	data[offset++] = hr_reg_read(&context, QPC_SRQN);
+	data[offset++] = hr_reg_read(&context, QPC_QKEY_XRCD);
+	data[offset++] = hr_reg_read(&context, QPC_TX_CQN);
+	data[offset++] = hr_reg_read(&context, QPC_RX_CQN);
+	data[offset++] = hr_reg_read(&context, QPC_SQ_PRODUCER_IDX);
+	data[offset++] = hr_reg_read(&context, QPC_SQ_CONSUMER_IDX);
+	data[offset++] = hr_reg_read(&context, QPC_RQ_RECORD_EN);
+	data[offset++] = hr_reg_read(&context, QPC_RQ_PRODUCER_IDX);
+	data[offset++] = hr_reg_read(&context, QPC_RQ_CONSUMER_IDX);
+	data[offset++] = hr_reg_read(&context, QPC_SQ_SHIFT);
+	data[offset++] = hr_reg_read(&context, QPC_RQWS);
+	data[offset++] = hr_reg_read(&context, QPC_RQ_SHIFT);
+	data[offset++] = hr_reg_read(&context, QPC_SGE_SHIFT);
+	data[offset++] = hr_reg_read(&context, QPC_SQ_HOP_NUM);
+	data[offset++] = hr_reg_read(&context, QPC_RQ_HOP_NUM);
+	data[offset++] = hr_reg_read(&context, QPC_SGE_HOP_NUM);
+	data[offset++] = hr_reg_read(&context, QPC_WQE_SGE_BA_PG_SZ);
+	data[offset++] = hr_reg_read(&context, QPC_WQE_SGE_BUF_PG_SZ);
+	data[offset++] = hr_reg_read(&context, QPC_RETRY_NUM_INIT);
+	data[offset++] = hr_reg_read(&context, QPC_RETRY_CNT);
+	data[offset++] = hr_reg_read(&context, QPC_SQ_CUR_PSN);
+	data[offset++] = hr_reg_read(&context, QPC_SQ_MAX_PSN);
+	data[offset++] = hr_reg_read(&context, QPC_SQ_FLUSH_IDX);
+	data[offset++] = hr_reg_read(&context, QPC_SQ_MAX_IDX);
+	data[offset++] = hr_reg_read(&context, QPC_SQ_TX_ERR);
+	data[offset++] = hr_reg_read(&context, QPC_SQ_RX_ERR);
+	data[offset++] = hr_reg_read(&context, QPC_RQ_RX_ERR);
+	data[offset++] = hr_reg_read(&context, QPC_RQ_TX_ERR);
+	data[offset++] = hr_reg_read(&context, QPC_RQ_CQE_IDX);
+	data[offset++] = hr_reg_read(&context, QPC_RQ_RTY_TX_ERR);
+
+	ret = nla_put(msg, RDMA_NLDEV_ATTR_RES_RAW, offset * sizeof(u32), data);
+
+	return ret;
+}
-- 
2.30.0

