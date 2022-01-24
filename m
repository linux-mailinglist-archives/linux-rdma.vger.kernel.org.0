Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42B6C497FC5
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jan 2022 13:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241875AbiAXMqL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Jan 2022 07:46:11 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:16735 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241857AbiAXMqK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Jan 2022 07:46:10 -0500
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Jj8kw31tyzZfLq;
        Mon, 24 Jan 2022 20:42:16 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
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
Subject: [PATCH for-next 1/4] RDMA/hns: Refactor the restrack code of CQ
Date:   Mon, 24 Jan 2022 20:46:21 +0800
Message-ID: <20220124124624.55352-2-liangwenpeng@huawei.com>
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

Use macros to construct resource entries to make the code clearer.

Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 drivers/infiniband/hw/hns/Makefile            |   2 +-
 drivers/infiniband/hw/hns/hns_roce_device.h   |   9 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c    |  34 ++++-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h    |  30 -----
 .../infiniband/hw/hns/hns_roce_hw_v2_dfx.c    |  35 -----
 drivers/infiniband/hw/hns/hns_roce_restrack.c | 121 ++++++------------
 6 files changed, 73 insertions(+), 158 deletions(-)
 delete mode 100644 drivers/infiniband/hw/hns/hns_roce_hw_v2_dfx.c

diff --git a/drivers/infiniband/hw/hns/Makefile b/drivers/infiniband/hw/hns/Makefile
index 9f04f25d9631..a7d259238305 100644
--- a/drivers/infiniband/hw/hns/Makefile
+++ b/drivers/infiniband/hw/hns/Makefile
@@ -10,6 +10,6 @@ hns-roce-objs := hns_roce_main.o hns_roce_cmd.o hns_roce_pd.o \
 	hns_roce_cq.o hns_roce_alloc.o hns_roce_db.o hns_roce_srq.o hns_roce_restrack.o
 
 ifdef CONFIG_INFINIBAND_HNS_HIP08
-hns-roce-hw-v2-objs := hns_roce_hw_v2.o hns_roce_hw_v2_dfx.o $(hns-roce-objs)
+hns-roce-hw-v2-objs := hns_roce_hw_v2.o $(hns-roce-objs)
 obj-$(CONFIG_INFINIBAND_HNS) += hns-roce-hw-v2.o
 endif
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 1e0bae136997..43e4b2945bf7 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -834,11 +834,6 @@ struct hns_roce_caps {
 	enum cong_type	cong_type;
 };
 
-struct hns_roce_dfx_hw {
-	int (*query_cqc_info)(struct hns_roce_dev *hr_dev, u32 cqn,
-			      int *buffer);
-};
-
 enum hns_roce_device_state {
 	HNS_ROCE_DEVICE_STATE_INITED,
 	HNS_ROCE_DEVICE_STATE_RST_DOWN,
@@ -885,6 +880,7 @@ struct hns_roce_hw {
 	int (*init_eq)(struct hns_roce_dev *hr_dev);
 	void (*cleanup_eq)(struct hns_roce_dev *hr_dev);
 	int (*write_srqc)(struct hns_roce_srq *srq, void *mb_buf);
+	int (*query_cqc)(struct hns_roce_dev *hr_dev, u32 cqn, void *buffer);
 	const struct ib_device_ops *hns_roce_dev_ops;
 	const struct ib_device_ops *hns_roce_dev_srq_ops;
 };
@@ -1217,8 +1213,7 @@ u8 hns_get_gid_index(struct hns_roce_dev *hr_dev, u32 port, int gid_index);
 void hns_roce_handle_device_err(struct hns_roce_dev *hr_dev);
 int hns_roce_init(struct hns_roce_dev *hr_dev);
 void hns_roce_exit(struct hns_roce_dev *hr_dev);
-int hns_roce_fill_res_cq_entry(struct sk_buff *msg,
-			       struct ib_cq *ib_cq);
+int hns_roce_fill_res_cq_entry(struct sk_buff *msg, struct ib_cq *ibcq);
 struct hns_user_mmap_entry *
 hns_roce_user_mmap_entry_insert(struct ib_ucontext *ucontext, u64 address,
 				size_t length,
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 1e539e228315..3c079fadd1e7 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -5511,6 +5511,34 @@ static int hns_roce_v2_modify_cq(struct ib_cq *cq, u16 cq_count, u16 cq_period)
 	return ret;
 }
 
+static int hns_roce_v2_query_cqc(struct hns_roce_dev *hr_dev, u32 cqn,
+				 void *buffer)
+{
+	struct hns_roce_v2_cq_context *context;
+	struct hns_roce_cmd_mailbox *mailbox;
+	int ret;
+
+	mailbox = hns_roce_alloc_cmd_mailbox(hr_dev);
+	if (IS_ERR(mailbox))
+		return PTR_ERR(mailbox);
+
+	context = mailbox->buf;
+	ret = hns_roce_cmd_mbox(hr_dev, 0, mailbox->dma, cqn, 0,
+				HNS_ROCE_CMD_QUERY_CQC,
+				HNS_ROCE_CMD_TIMEOUT_MSECS);
+	if (ret) {
+		dev_err(hr_dev->dev, "QUERY cqc cmd process error.\n");
+		goto err_mailbox;
+	}
+
+	memcpy(buffer, context, sizeof(*context));
+
+err_mailbox:
+	hns_roce_free_cmd_mailbox(hr_dev, mailbox);
+
+	return ret;
+}
+
 static void hns_roce_irq_work_handle(struct work_struct *work)
 {
 	struct hns_roce_work *irq_work =
@@ -6169,10 +6197,6 @@ static void hns_roce_v2_cleanup_eq_table(struct hns_roce_dev *hr_dev)
 	kfree(eq_table->eq);
 }
 
-static const struct hns_roce_dfx_hw hns_roce_dfx_hw_v2 = {
-	.query_cqc_info = hns_roce_v2_query_cqc_info,
-};
-
 static const struct ib_device_ops hns_roce_v2_dev_ops = {
 	.destroy_qp = hns_roce_v2_destroy_qp,
 	.modify_cq = hns_roce_v2_modify_cq,
@@ -6212,6 +6236,7 @@ static const struct hns_roce_hw hns_roce_hw_v2 = {
 	.init_eq = hns_roce_v2_init_eq_table,
 	.cleanup_eq = hns_roce_v2_cleanup_eq_table,
 	.write_srqc = hns_roce_v2_write_srqc,
+	.query_cqc = hns_roce_v2_query_cqc,
 	.hns_roce_dev_ops = &hns_roce_v2_dev_ops,
 	.hns_roce_dev_srq_ops = &hns_roce_v2_dev_srq_ops,
 };
@@ -6243,7 +6268,6 @@ static void hns_roce_hw_v2_get_cfg(struct hns_roce_dev *hr_dev,
 	hr_dev->is_vf = id->driver_data;
 	hr_dev->dev = &handle->pdev->dev;
 	hr_dev->hw = &hns_roce_hw_v2;
-	hr_dev->dfx = &hns_roce_dfx_hw_v2;
 	hr_dev->sdb_offset = ROCEE_DB_SQ_L_0_REG;
 	hr_dev->odb_offset = hr_dev->sdb_offset;
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index e9a73c34389b..fb47a6730e1c 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -291,33 +291,6 @@ struct hns_roce_v2_cq_context {
 #define HNS_ROCE_V2_CQ_DEFAULT_BURST_NUM 0x0
 #define HNS_ROCE_V2_CQ_DEFAULT_INTERVAL	0x0
 
-#define	V2_CQC_BYTE_4_ARM_ST_S 6
-#define V2_CQC_BYTE_4_ARM_ST_M GENMASK(7, 6)
-
-#define	V2_CQC_BYTE_4_CEQN_S 15
-#define V2_CQC_BYTE_4_CEQN_M GENMASK(23, 15)
-
-#define	V2_CQC_BYTE_8_CQN_S 0
-#define V2_CQC_BYTE_8_CQN_M GENMASK(23, 0)
-
-#define	V2_CQC_BYTE_16_CQE_HOP_NUM_S 30
-#define V2_CQC_BYTE_16_CQE_HOP_NUM_M GENMASK(31, 30)
-
-#define	V2_CQC_BYTE_28_CQ_PRODUCER_IDX_S 0
-#define V2_CQC_BYTE_28_CQ_PRODUCER_IDX_M GENMASK(23, 0)
-
-#define	V2_CQC_BYTE_32_CQ_CONSUMER_IDX_S 0
-#define V2_CQC_BYTE_32_CQ_CONSUMER_IDX_M GENMASK(23, 0)
-
-#define	V2_CQC_BYTE_52_CQE_CNT_S 0
-#define	V2_CQC_BYTE_52_CQE_CNT_M GENMASK(23, 0)
-
-#define	V2_CQC_BYTE_56_CQ_MAX_CNT_S 0
-#define V2_CQC_BYTE_56_CQ_MAX_CNT_M GENMASK(15, 0)
-
-#define	V2_CQC_BYTE_56_CQ_PERIOD_S 16
-#define V2_CQC_BYTE_56_CQ_PERIOD_M GENMASK(31, 16)
-
 #define CQC_FIELD_LOC(h, l) FIELD_LOC(struct hns_roce_v2_cq_context, h, l)
 
 #define CQC_CQ_ST CQC_FIELD_LOC(1, 0)
@@ -1545,9 +1518,6 @@ struct hns_roce_sccc_clr_done {
 	__le32 rsv[5];
 };
 
-int hns_roce_v2_query_cqc_info(struct hns_roce_dev *hr_dev, u32 cqn,
-			       int *buffer);
-
 static inline void hns_roce_write64(struct hns_roce_dev *hr_dev, __le32 val[2],
 				    void __iomem *dest)
 {
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2_dfx.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2_dfx.c
deleted file mode 100644
index 5a97b5a0b7be..000000000000
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2_dfx.c
+++ /dev/null
@@ -1,35 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
-// Copyright (c) 2019 Hisilicon Limited.
-
-#include "hnae3.h"
-#include "hns_roce_device.h"
-#include "hns_roce_cmd.h"
-#include "hns_roce_hw_v2.h"
-
-int hns_roce_v2_query_cqc_info(struct hns_roce_dev *hr_dev, u32 cqn,
-			       int *buffer)
-{
-	struct hns_roce_v2_cq_context *cq_context;
-	struct hns_roce_cmd_mailbox *mailbox;
-	int ret;
-
-	mailbox = hns_roce_alloc_cmd_mailbox(hr_dev);
-	if (IS_ERR(mailbox))
-		return PTR_ERR(mailbox);
-
-	cq_context = mailbox->buf;
-	ret = hns_roce_cmd_mbox(hr_dev, 0, mailbox->dma, cqn, 0,
-				HNS_ROCE_CMD_QUERY_CQC,
-				HNS_ROCE_CMD_TIMEOUT_MSECS);
-	if (ret) {
-		dev_err(hr_dev->dev, "QUERY cqc cmd process error\n");
-		goto err_mailbox;
-	}
-
-	memcpy(buffer, cq_context, sizeof(*cq_context));
-
-err_mailbox:
-	hns_roce_free_cmd_mailbox(hr_dev, mailbox);
-
-	return ret;
-}
diff --git a/drivers/infiniband/hw/hns/hns_roce_restrack.c b/drivers/infiniband/hw/hns/hns_roce_restrack.c
index 259444c0a630..4420639445a1 100644
--- a/drivers/infiniband/hw/hns/hns_roce_restrack.c
+++ b/drivers/infiniband/hw/hns/hns_roce_restrack.c
@@ -9,66 +9,39 @@
 #include "hns_roce_device.h"
 #include "hns_roce_hw_v2.h"
 
+#define _HR_REG_MASK(h, l)                                                     \
+	(GENMASK((h) % 32, (l) % 32) +                                         \
+	 BUILD_BUG_ON_ZERO(((h) / 32) != ((l) / 32)))
+#define _HR_REG_CFG(type, h, l) _HR_REG_MASK(h, l), l
+#define HR_REG_CFG(field) _HR_REG_CFG(field)
+
 static int hns_roce_fill_cq(struct sk_buff *msg,
 			    struct hns_roce_v2_cq_context *context)
 {
-	if (rdma_nl_put_driver_u32(msg, "state",
-				   roce_get_field(context->byte_4_pg_ceqn,
-						  V2_CQC_BYTE_4_ARM_ST_M,
-						  V2_CQC_BYTE_4_ARM_ST_S)))
-		goto err;
-
-	if (rdma_nl_put_driver_u32(msg, "ceqn",
-				   roce_get_field(context->byte_4_pg_ceqn,
-						  V2_CQC_BYTE_4_CEQN_M,
-						  V2_CQC_BYTE_4_CEQN_S)))
-		goto err;
-
-	if (rdma_nl_put_driver_u32(msg, "cqn",
-				   roce_get_field(context->byte_8_cqn,
-						  V2_CQC_BYTE_8_CQN_M,
-						  V2_CQC_BYTE_8_CQN_S)))
-		goto err;
-
-	if (rdma_nl_put_driver_u32(msg, "hopnum",
-				   roce_get_field(context->byte_16_hop_addr,
-						  V2_CQC_BYTE_16_CQE_HOP_NUM_M,
-						  V2_CQC_BYTE_16_CQE_HOP_NUM_S)))
-		goto err;
-
-	if (rdma_nl_put_driver_u32(
-		    msg, "pi",
-		    roce_get_field(context->byte_28_cq_pi,
-				   V2_CQC_BYTE_28_CQ_PRODUCER_IDX_M,
-				   V2_CQC_BYTE_28_CQ_PRODUCER_IDX_S)))
-		goto err;
-
-	if (rdma_nl_put_driver_u32(
-		    msg, "ci",
-		    roce_get_field(context->byte_32_cq_ci,
-				   V2_CQC_BYTE_32_CQ_CONSUMER_IDX_M,
-				   V2_CQC_BYTE_32_CQ_CONSUMER_IDX_S)))
-		goto err;
-
-	if (rdma_nl_put_driver_u32(
-		    msg, "coalesce",
-		    roce_get_field(context->byte_56_cqe_period_maxcnt,
-				   V2_CQC_BYTE_56_CQ_MAX_CNT_M,
-				   V2_CQC_BYTE_56_CQ_MAX_CNT_S)))
-		goto err;
-
-	if (rdma_nl_put_driver_u32(
-		    msg, "period",
-		    roce_get_field(context->byte_56_cqe_period_maxcnt,
-				   V2_CQC_BYTE_56_CQ_PERIOD_M,
-				   V2_CQC_BYTE_56_CQ_PERIOD_S)))
-		goto err;
-
-	if (rdma_nl_put_driver_u32(msg, "cnt",
-				   roce_get_field(context->byte_52_cqe_cnt,
-						  V2_CQC_BYTE_52_CQE_CNT_M,
-						  V2_CQC_BYTE_52_CQE_CNT_S)))
-		goto err;
+	static struct {
+		char *name;
+		u32 mask;
+		u32 l;
+	} reg[] = {
+		{ "cq_st", HR_REG_CFG(CQC_CQ_ST) },
+		{ "ceqn", HR_REG_CFG(CQC_CEQN) },
+		{ "cqn", HR_REG_CFG(CQC_CQN) },
+		{ "hopnum", HR_REG_CFG(CQC_CQE_HOP_NUM) },
+		{ "pi", HR_REG_CFG(CQC_CQ_PRODUCER_IDX) },
+		{ "ci", HR_REG_CFG(CQC_CQ_CONSUMER_IDX) },
+		{ "coalesce", HR_REG_CFG(CQC_CQ_MAX_CNT) },
+		{ "period", HR_REG_CFG(CQC_CQ_PERIOD) },
+		{ "cnt", HR_REG_CFG(CQC_CQE_CNT) },
+	};
+	__le32 *cqc = (void *)context;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(reg); i++)
+		if (rdma_nl_put_driver_u32_hex(
+			msg, reg[i].name,
+			(le32_to_cpu(cqc[reg[i].l / 32]) & reg[i].mask) >>
+				(reg[i].l % 32)))
+			goto err;
 
 	return 0;
 
@@ -76,45 +49,33 @@ static int hns_roce_fill_cq(struct sk_buff *msg,
 	return -EMSGSIZE;
 }
 
-int hns_roce_fill_res_cq_entry(struct sk_buff *msg,
-			       struct ib_cq *ib_cq)
+int hns_roce_fill_res_cq_entry(struct sk_buff *msg, struct ib_cq *ibcq)
 {
-	struct hns_roce_dev *hr_dev = to_hr_dev(ib_cq->device);
-	struct hns_roce_cq *hr_cq = to_hr_cq(ib_cq);
-	struct hns_roce_v2_cq_context *context;
+	struct hns_roce_dev *hr_dev = to_hr_dev(ibcq->device);
+	struct hns_roce_cq *hr_cq = to_hr_cq(ibcq);
+	struct hns_roce_v2_cq_context context;
 	struct nlattr *table_attr;
 	int ret;
 
-	if (!hr_dev->dfx->query_cqc_info)
+	if (!hr_dev->hw->query_cqc)
 		return -EINVAL;
 
-	context = kzalloc(sizeof(struct hns_roce_v2_cq_context), GFP_KERNEL);
-	if (!context)
-		return -ENOMEM;
-
-	ret = hr_dev->dfx->query_cqc_info(hr_dev, hr_cq->cqn, (int *)context);
+	ret = hr_dev->hw->query_cqc(hr_dev, hr_cq->cqn, &context);
 	if (ret)
-		goto err;
+		return -EINVAL;
 
 	table_attr = nla_nest_start(msg, RDMA_NLDEV_ATTR_DRIVER);
-	if (!table_attr) {
-		ret = -EMSGSIZE;
-		goto err;
-	}
+	if (!table_attr)
+		return -EMSGSIZE;
 
-	if (hns_roce_fill_cq(msg, context)) {
-		ret = -EMSGSIZE;
+	if (hns_roce_fill_cq(msg, &context))
 		goto err_cancel_table;
-	}
 
 	nla_nest_end(msg, table_attr);
-	kfree(context);
 
 	return 0;
 
 err_cancel_table:
 	nla_nest_cancel(msg, table_attr);
-err:
-	kfree(context);
-	return ret;
+	return -EMSGSIZE;
 }
-- 
2.33.0

