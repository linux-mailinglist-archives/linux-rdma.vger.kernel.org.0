Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79528497FC8
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jan 2022 13:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241898AbiAXMqM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Jan 2022 07:46:12 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:31120 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239715AbiAXMqK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Jan 2022 07:46:10 -0500
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Jj8kx0bGcz1FClW;
        Mon, 24 Jan 2022 20:42:17 +0800 (CST)
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
Subject: [PATCH for-next 4/4] RDMA/hns: Add support for MR's restrack attributes
Date:   Mon, 24 Jan 2022 20:46:24 +0800
Message-ID: <20220124124624.55352-5-liangwenpeng@huawei.com>
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

The restrack attributes of MR come from the MPT.

Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h   |  2 +
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c    | 29 ++++++++
 drivers/infiniband/hw/hns/hns_roce_main.c     |  1 +
 drivers/infiniband/hw/hns/hns_roce_restrack.c | 68 +++++++++++++++++++
 4 files changed, 100 insertions(+)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index a34c12970200..84f9eedeab49 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -882,6 +882,7 @@ struct hns_roce_hw {
 	int (*write_srqc)(struct hns_roce_srq *srq, void *mb_buf);
 	int (*query_cqc)(struct hns_roce_dev *hr_dev, u32 cqn, void *buffer);
 	int (*query_qpc)(struct hns_roce_dev *hr_dev, u32 qpn, void *buffer);
+	int (*query_mpt)(struct hns_roce_dev *hr_dev, u32 key, void *buffer);
 	const struct ib_device_ops *hns_roce_dev_ops;
 	const struct ib_device_ops *hns_roce_dev_srq_ops;
 };
@@ -1216,6 +1217,7 @@ int hns_roce_init(struct hns_roce_dev *hr_dev);
 void hns_roce_exit(struct hns_roce_dev *hr_dev);
 int hns_roce_fill_res_cq_entry(struct sk_buff *msg, struct ib_cq *ibcq);
 int hns_roce_fill_res_qp_entry(struct sk_buff *msg, struct ib_qp *ibqp);
+int hns_roce_fill_res_mr_entry(struct sk_buff *msg, struct ib_mr *ibmr);
 struct hns_user_mmap_entry *
 hns_roce_user_mmap_entry_insert(struct ib_ucontext *ucontext, u64 address,
 				size_t length,
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 4912c531ef91..d746747631a0 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -5540,6 +5540,34 @@ static int hns_roce_v2_query_cqc(struct hns_roce_dev *hr_dev, u32 cqn,
 	return ret;
 }
 
+static int hns_roce_v2_query_mpt(struct hns_roce_dev *hr_dev, u32 key,
+				 void *buffer)
+{
+	struct hns_roce_v2_mpt_entry *context;
+	struct hns_roce_cmd_mailbox *mailbox;
+	int ret;
+
+	mailbox = hns_roce_alloc_cmd_mailbox(hr_dev);
+	if (IS_ERR(mailbox))
+		return PTR_ERR(mailbox);
+
+	context = mailbox->buf;
+	ret = hns_roce_cmd_mbox(hr_dev, 0, mailbox->dma, key_to_hw_index(key),
+				0, HNS_ROCE_CMD_QUERY_MPT,
+				HNS_ROCE_CMD_TIMEOUT_MSECS);
+	if (ret) {
+		dev_err(hr_dev->dev, "QUERY mpt cmd process error.\n");
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
@@ -6239,6 +6267,7 @@ static const struct hns_roce_hw hns_roce_hw_v2 = {
 	.write_srqc = hns_roce_v2_write_srqc,
 	.query_cqc = hns_roce_v2_query_cqc,
 	.query_qpc = hns_roce_v2_query_qpc,
+	.query_mpt = hns_roce_v2_query_mpt,
 	.hns_roce_dev_ops = &hns_roce_v2_dev_ops,
 	.hns_roce_dev_srq_ops = &hns_roce_v2_dev_srq_ops,
 };
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index cf33182355c1..ff3e7f58f6c3 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -517,6 +517,7 @@ static const struct ib_device_ops hns_roce_dev_ops = {
 	.disassociate_ucontext = hns_roce_disassociate_ucontext,
 	.fill_res_cq_entry = hns_roce_fill_res_cq_entry,
 	.fill_res_qp_entry = hns_roce_fill_res_qp_entry,
+	.fill_res_mr_entry = hns_roce_fill_res_mr_entry,
 	.get_dma_mr = hns_roce_get_dma_mr,
 	.get_link_layer = hns_roce_get_link_layer,
 	.get_port_immutable = hns_roce_port_immutable,
diff --git a/drivers/infiniband/hw/hns/hns_roce_restrack.c b/drivers/infiniband/hw/hns/hns_roce_restrack.c
index 9bc0b15e8d1a..92229e28504c 100644
--- a/drivers/infiniband/hw/hns/hns_roce_restrack.c
+++ b/drivers/infiniband/hw/hns/hns_roce_restrack.c
@@ -202,3 +202,71 @@ int hns_roce_fill_res_qp_entry(struct sk_buff *msg, struct ib_qp *ibqp)
 	nla_nest_cancel(msg, table_attr);
 	return -EMSGSIZE;
 }
+
+static int hns_roce_fill_mr(struct sk_buff *msg,
+			    struct hns_roce_v2_mpt_entry *context)
+{
+	static struct {
+		char *name;
+		u32 mask;
+		u32 l;
+	} reg[] = {
+		{ "mpt_st", HR_REG_CFG(MPT_ST) },
+		{ "pbl_size", HR_REG_CFG(MPT_PBL_SIZE) },
+		{ "rr_en", HR_REG_CFG(MPT_RR_EN) },
+		{ "rw_en", HR_REG_CFG(MPT_RW_EN) },
+		{ "lw_en", HR_REG_CFG(MPT_LW_EN) },
+		{ "atomic_en", HR_REG_CFG(MPT_ATOMIC_EN) },
+		{ "ra_en", HR_REG_CFG(MPT_RA_EN) },
+		{ "r_inv_en", HR_REG_CFG(MPT_R_INV_EN) },
+		{ "l_inv_en", HR_REG_CFG(MPT_L_INV_EN) },
+	};
+	__le32 *mpt = (void *)context;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(reg); i++)
+		if (rdma_nl_put_driver_u32_hex(
+			    msg, reg[i].name,
+			    (le32_to_cpu(mpt[reg[i].l / 32]) & reg[i].mask) >>
+				    (reg[i].l % 32)))
+			goto err;
+
+	return 0;
+
+err:
+	return -EMSGSIZE;
+}
+
+int hns_roce_fill_res_mr_entry(struct sk_buff *msg, struct ib_mr *ibmr)
+{
+	struct hns_roce_dev *hr_dev = to_hr_dev(ibmr->device);
+	struct hns_roce_mr *hr_mr = to_hr_mr(ibmr);
+	struct hns_roce_v2_mpt_entry context;
+	struct nlattr *table_attr;
+	int ret;
+
+	if (!hr_dev->hw->query_mpt)
+		return -EINVAL;
+
+	ret = hr_dev->hw->query_mpt(hr_dev, hr_mr->key, &context);
+	if (ret)
+		goto err;
+
+	table_attr = nla_nest_start(msg, RDMA_NLDEV_ATTR_DRIVER);
+	if (!table_attr) {
+		ret = -EMSGSIZE;
+		goto err;
+	}
+
+	if (hns_roce_fill_mr(msg, &context))
+		goto err_cancel_table;
+
+	nla_nest_end(msg, table_attr);
+
+	return 0;
+
+err_cancel_table:
+	nla_nest_cancel(msg, table_attr);
+err:
+	return -EMSGSIZE;
+}
-- 
2.33.0

