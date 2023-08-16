Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369CD77DD2D
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Aug 2023 11:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243294AbjHPJV3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Aug 2023 05:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243287AbjHPJVC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Aug 2023 05:21:02 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71BAA2121;
        Wed, 16 Aug 2023 02:21:00 -0700 (PDT)
Received: from kwepemi500006.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RQjFy3tVzzNmn1;
        Wed, 16 Aug 2023 17:17:26 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 16 Aug 2023 17:20:57 +0800
From:   Junxian Huang <huangjunxian6@hisilicon.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH for-next 1/3] RDMA/hns: Dump whole QP/CQ/MR resource in raw
Date:   Wed, 16 Aug 2023 17:18:10 +0800
Message-ID: <20230816091812.2899366-2-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230816091812.2899366-1-huangjunxian6@hisilicon.com>
References: <20230816091812.2899366-1-huangjunxian6@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500006.china.huawei.com (7.221.188.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Chengchang Tang <tangchengchang@huawei.com>

Currently, some fields in the QP/CQ/MR resource can be dumped by
rdma-tool, but these informations are not enough. It is very
inconvenient to continue to expand on the current field, and it
will also introduce some trouble to parse these raw data.

This patch dump whole resource in raw to avoid the above problems.

Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_restrack.c | 75 +------------------
 1 file changed, 3 insertions(+), 72 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_restrack.c b/drivers/infiniband/hw/hns/hns_roce_restrack.c
index 989a2af2e938..081a01de3055 100644
--- a/drivers/infiniband/hw/hns/hns_roce_restrack.c
+++ b/drivers/infiniband/hw/hns/hns_roce_restrack.c
@@ -9,8 +9,6 @@
 #include "hns_roce_device.h"
 #include "hns_roce_hw_v2.h"
 
-#define MAX_ENTRY_NUM 256
-
 int hns_roce_fill_res_cq_entry(struct sk_buff *msg, struct ib_cq *ib_cq)
 {
 	struct hns_roce_cq *hr_cq = to_hr_cq(ib_cq);
@@ -47,8 +45,6 @@ int hns_roce_fill_res_cq_entry_raw(struct sk_buff *msg, struct ib_cq *ib_cq)
 	struct hns_roce_dev *hr_dev = to_hr_dev(ib_cq->device);
 	struct hns_roce_cq *hr_cq = to_hr_cq(ib_cq);
 	struct hns_roce_v2_cq_context context;
-	u32 data[MAX_ENTRY_NUM] = {};
-	int offset = 0;
 	int ret;
 
 	if (!hr_dev->hw->query_cqc)
@@ -58,23 +54,7 @@ int hns_roce_fill_res_cq_entry_raw(struct sk_buff *msg, struct ib_cq *ib_cq)
 	if (ret)
 		return -EINVAL;
 
-	data[offset++] = hr_reg_read(&context, CQC_CQ_ST);
-	data[offset++] = hr_reg_read(&context, CQC_SHIFT);
-	data[offset++] = hr_reg_read(&context, CQC_CQE_SIZE);
-	data[offset++] = hr_reg_read(&context, CQC_CQE_CNT);
-	data[offset++] = hr_reg_read(&context, CQC_CQ_PRODUCER_IDX);
-	data[offset++] = hr_reg_read(&context, CQC_CQ_CONSUMER_IDX);
-	data[offset++] = hr_reg_read(&context, CQC_DB_RECORD_EN);
-	data[offset++] = hr_reg_read(&context, CQC_ARM_ST);
-	data[offset++] = hr_reg_read(&context, CQC_CMD_SN);
-	data[offset++] = hr_reg_read(&context, CQC_CEQN);
-	data[offset++] = hr_reg_read(&context, CQC_CQ_MAX_CNT);
-	data[offset++] = hr_reg_read(&context, CQC_CQ_PERIOD);
-	data[offset++] = hr_reg_read(&context, CQC_CQE_HOP_NUM);
-	data[offset++] = hr_reg_read(&context, CQC_CQE_BAR_PG_SZ);
-	data[offset++] = hr_reg_read(&context, CQC_CQE_BUF_PG_SZ);
-
-	ret = nla_put(msg, RDMA_NLDEV_ATTR_RES_RAW, offset * sizeof(u32), data);
+	ret = nla_put(msg, RDMA_NLDEV_ATTR_RES_RAW, sizeof(context), &context);
 
 	return ret;
 }
@@ -118,8 +98,6 @@ int hns_roce_fill_res_qp_entry_raw(struct sk_buff *msg, struct ib_qp *ib_qp)
 	struct hns_roce_dev *hr_dev = to_hr_dev(ib_qp->device);
 	struct hns_roce_qp *hr_qp = to_hr_qp(ib_qp);
 	struct hns_roce_v2_qp_context context;
-	u32 data[MAX_ENTRY_NUM] = {};
-	int offset = 0;
 	int ret;
 
 	if (!hr_dev->hw->query_qpc)
@@ -129,42 +107,7 @@ int hns_roce_fill_res_qp_entry_raw(struct sk_buff *msg, struct ib_qp *ib_qp)
 	if (ret)
 		return -EINVAL;
 
-	data[offset++] = hr_reg_read(&context, QPC_QP_ST);
-	data[offset++] = hr_reg_read(&context, QPC_ERR_TYPE);
-	data[offset++] = hr_reg_read(&context, QPC_CHECK_FLG);
-	data[offset++] = hr_reg_read(&context, QPC_SRQ_EN);
-	data[offset++] = hr_reg_read(&context, QPC_SRQN);
-	data[offset++] = hr_reg_read(&context, QPC_QKEY_XRCD);
-	data[offset++] = hr_reg_read(&context, QPC_TX_CQN);
-	data[offset++] = hr_reg_read(&context, QPC_RX_CQN);
-	data[offset++] = hr_reg_read(&context, QPC_SQ_PRODUCER_IDX);
-	data[offset++] = hr_reg_read(&context, QPC_SQ_CONSUMER_IDX);
-	data[offset++] = hr_reg_read(&context, QPC_RQ_RECORD_EN);
-	data[offset++] = hr_reg_read(&context, QPC_RQ_PRODUCER_IDX);
-	data[offset++] = hr_reg_read(&context, QPC_RQ_CONSUMER_IDX);
-	data[offset++] = hr_reg_read(&context, QPC_SQ_SHIFT);
-	data[offset++] = hr_reg_read(&context, QPC_RQWS);
-	data[offset++] = hr_reg_read(&context, QPC_RQ_SHIFT);
-	data[offset++] = hr_reg_read(&context, QPC_SGE_SHIFT);
-	data[offset++] = hr_reg_read(&context, QPC_SQ_HOP_NUM);
-	data[offset++] = hr_reg_read(&context, QPC_RQ_HOP_NUM);
-	data[offset++] = hr_reg_read(&context, QPC_SGE_HOP_NUM);
-	data[offset++] = hr_reg_read(&context, QPC_WQE_SGE_BA_PG_SZ);
-	data[offset++] = hr_reg_read(&context, QPC_WQE_SGE_BUF_PG_SZ);
-	data[offset++] = hr_reg_read(&context, QPC_RETRY_NUM_INIT);
-	data[offset++] = hr_reg_read(&context, QPC_RETRY_CNT);
-	data[offset++] = hr_reg_read(&context, QPC_SQ_CUR_PSN);
-	data[offset++] = hr_reg_read(&context, QPC_SQ_MAX_PSN);
-	data[offset++] = hr_reg_read(&context, QPC_SQ_FLUSH_IDX);
-	data[offset++] = hr_reg_read(&context, QPC_SQ_MAX_IDX);
-	data[offset++] = hr_reg_read(&context, QPC_SQ_TX_ERR);
-	data[offset++] = hr_reg_read(&context, QPC_SQ_RX_ERR);
-	data[offset++] = hr_reg_read(&context, QPC_RQ_RX_ERR);
-	data[offset++] = hr_reg_read(&context, QPC_RQ_TX_ERR);
-	data[offset++] = hr_reg_read(&context, QPC_RQ_CQE_IDX);
-	data[offset++] = hr_reg_read(&context, QPC_RQ_RTY_TX_ERR);
-
-	ret = nla_put(msg, RDMA_NLDEV_ATTR_RES_RAW, offset * sizeof(u32), data);
+	ret = nla_put(msg, RDMA_NLDEV_ATTR_RES_RAW, sizeof(context), &context);
 
 	return ret;
 }
@@ -204,8 +147,6 @@ int hns_roce_fill_res_mr_entry_raw(struct sk_buff *msg, struct ib_mr *ib_mr)
 	struct hns_roce_dev *hr_dev = to_hr_dev(ib_mr->device);
 	struct hns_roce_mr *hr_mr = to_hr_mr(ib_mr);
 	struct hns_roce_v2_mpt_entry context;
-	u32 data[MAX_ENTRY_NUM] = {};
-	int offset = 0;
 	int ret;
 
 	if (!hr_dev->hw->query_mpt)
@@ -215,17 +156,7 @@ int hns_roce_fill_res_mr_entry_raw(struct sk_buff *msg, struct ib_mr *ib_mr)
 	if (ret)
 		return -EINVAL;
 
-	data[offset++] = hr_reg_read(&context, MPT_ST);
-	data[offset++] = hr_reg_read(&context, MPT_PD);
-	data[offset++] = hr_reg_read(&context, MPT_LKEY);
-	data[offset++] = hr_reg_read(&context, MPT_LEN_L);
-	data[offset++] = hr_reg_read(&context, MPT_LEN_H);
-	data[offset++] = hr_reg_read(&context, MPT_PBL_SIZE);
-	data[offset++] = hr_reg_read(&context, MPT_PBL_HOP_NUM);
-	data[offset++] = hr_reg_read(&context, MPT_PBL_BA_PG_SZ);
-	data[offset++] = hr_reg_read(&context, MPT_PBL_BUF_PG_SZ);
-
-	ret = nla_put(msg, RDMA_NLDEV_ATTR_RES_RAW, offset * sizeof(u32), data);
+	ret = nla_put(msg, RDMA_NLDEV_ATTR_RES_RAW, sizeof(context), &context);
 
 	return ret;
 }
-- 
2.30.0

