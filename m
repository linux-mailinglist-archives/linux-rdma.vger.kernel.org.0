Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186BA59BDC2
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Aug 2022 12:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiHVKpm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Aug 2022 06:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233748AbiHVKpe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Aug 2022 06:45:34 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9F52B24F
        for <linux-rdma@vger.kernel.org>; Mon, 22 Aug 2022 03:45:31 -0700 (PDT)
Received: from dggpeml500022.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MB89M6kMkzGpm6;
        Mon, 22 Aug 2022 18:43:51 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 22 Aug 2022 18:45:29 +0800
Received: from localhost.localdomain (10.67.165.2) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 22 Aug 2022 18:45:29 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>
Subject: [PATCH v2 for-next 1/7] RDMA/hns: Remove redundant DFX file and DFX ops structure
Date:   Mon, 22 Aug 2022 18:44:49 +0800
Message-ID: <20220822104455.2311053-2-liangwenpeng@huawei.com>
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

There is no need to use a dedicated DXF file and DFX structure to manage
the interface of the query queue context.

Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 drivers/infiniband/hw/hns/Makefile            |  2 +-
 drivers/infiniband/hw/hns/hns_roce_device.h   | 10 ++----
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c    | 35 ++++++++++++++++---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h    |  3 --
 .../infiniband/hw/hns/hns_roce_hw_v2_dfx.c    | 34 ------------------
 drivers/infiniband/hw/hns/hns_roce_main.c     |  6 +++-
 drivers/infiniband/hw/hns/hns_roce_restrack.c | 35 +++++++------------
 7 files changed, 50 insertions(+), 75 deletions(-)
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
index f848eedc6a23..103d50564b89 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -849,11 +849,6 @@ struct hns_roce_caps {
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
@@ -899,6 +894,7 @@ struct hns_roce_hw {
 	int (*init_eq)(struct hns_roce_dev *hr_dev);
 	void (*cleanup_eq)(struct hns_roce_dev *hr_dev);
 	int (*write_srqc)(struct hns_roce_srq *srq, void *mb_buf);
+	int (*query_cqc)(struct hns_roce_dev *hr_dev, u32 cqn, void *buffer);
 	const struct ib_device_ops *hns_roce_dev_ops;
 	const struct ib_device_ops *hns_roce_dev_srq_ops;
 };
@@ -960,7 +956,6 @@ struct hns_roce_dev {
 	void			*priv;
 	struct workqueue_struct *irq_workq;
 	struct work_struct ecc_work;
-	const struct hns_roce_dfx_hw *dfx;
 	u32 func_num;
 	u32 is_vf;
 	u32 cong_algo_tmpl_id;
@@ -1228,8 +1223,7 @@ u8 hns_get_gid_index(struct hns_roce_dev *hr_dev, u32 port, int gid_index);
 void hns_roce_handle_device_err(struct hns_roce_dev *hr_dev);
 int hns_roce_init(struct hns_roce_dev *hr_dev);
 void hns_roce_exit(struct hns_roce_dev *hr_dev);
-int hns_roce_fill_res_cq_entry(struct sk_buff *msg,
-			       struct ib_cq *ib_cq);
+int hns_roce_fill_res_cq_entry(struct sk_buff *msg, struct ib_cq *ib_cq);
 struct hns_user_mmap_entry *
 hns_roce_user_mmap_entry_insert(struct ib_ucontext *ucontext, u64 address,
 				size_t length,
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index cbdafaac678a..979cd57a72fb 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -5774,6 +5774,35 @@ static int hns_roce_v2_modify_cq(struct ib_cq *cq, u16 cq_count, u16 cq_period)
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
+	ret = hns_roce_cmd_mbox(hr_dev, 0, mailbox->dma,
+				HNS_ROCE_CMD_QUERY_CQC, cqn);
+	if (ret) {
+		ibdev_err(&hr_dev->ib_dev,
+			  "failed to process cmd when querying CQ, ret = %d.\n",
+			  ret);
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
@@ -6575,10 +6604,6 @@ static void hns_roce_v2_cleanup_eq_table(struct hns_roce_dev *hr_dev)
 	kfree(eq_table->eq);
 }
 
-static const struct hns_roce_dfx_hw hns_roce_dfx_hw_v2 = {
-	.query_cqc_info = hns_roce_v2_query_cqc_info,
-};
-
 static const struct ib_device_ops hns_roce_v2_dev_ops = {
 	.destroy_qp = hns_roce_v2_destroy_qp,
 	.modify_cq = hns_roce_v2_modify_cq,
@@ -6619,6 +6644,7 @@ static const struct hns_roce_hw hns_roce_hw_v2 = {
 	.init_eq = hns_roce_v2_init_eq_table,
 	.cleanup_eq = hns_roce_v2_cleanup_eq_table,
 	.write_srqc = hns_roce_v2_write_srqc,
+	.query_cqc = hns_roce_v2_query_cqc,
 	.hns_roce_dev_ops = &hns_roce_v2_dev_ops,
 	.hns_roce_dev_srq_ops = &hns_roce_v2_dev_srq_ops,
 };
@@ -6650,7 +6676,6 @@ static void hns_roce_hw_v2_get_cfg(struct hns_roce_dev *hr_dev,
 	hr_dev->is_vf = id->driver_data;
 	hr_dev->dev = &handle->pdev->dev;
 	hr_dev->hw = &hns_roce_hw_v2;
-	hr_dev->dfx = &hns_roce_dfx_hw_v2;
 	hr_dev->sdb_offset = ROCEE_DB_SQ_L_0_REG;
 	hr_dev->odb_offset = hr_dev->sdb_offset;
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index f96debac30fe..49ec29973ed7 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -1462,9 +1462,6 @@ struct hns_roce_sccc_clr_done {
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
index f7a75a7cda74..000000000000
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2_dfx.c
+++ /dev/null
@@ -1,34 +0,0 @@
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
-	ret = hns_roce_cmd_mbox(hr_dev, 0, mailbox->dma, HNS_ROCE_CMD_QUERY_CQC,
-				cqn);
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
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index c8af4ebd7cbd..caf73e8f4bbe 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -515,7 +515,6 @@ static const struct ib_device_ops hns_roce_dev_ops = {
 	.destroy_ah = hns_roce_destroy_ah,
 	.destroy_cq = hns_roce_destroy_cq,
 	.disassociate_ucontext = hns_roce_disassociate_ucontext,
-	.fill_res_cq_entry = hns_roce_fill_res_cq_entry,
 	.get_dma_mr = hns_roce_get_dma_mr,
 	.get_link_layer = hns_roce_get_link_layer,
 	.get_port_immutable = hns_roce_port_immutable,
@@ -566,6 +565,10 @@ static const struct ib_device_ops hns_roce_dev_xrcd_ops = {
 	INIT_RDMA_OBJ_SIZE(ib_xrcd, hns_roce_xrcd, ibxrcd),
 };
 
+static const struct ib_device_ops hns_roce_dev_restrack_ops = {
+	.fill_res_cq_entry = hns_roce_fill_res_cq_entry,
+};
+
 static int hns_roce_register_device(struct hns_roce_dev *hr_dev)
 {
 	int ret;
@@ -605,6 +608,7 @@ static int hns_roce_register_device(struct hns_roce_dev *hr_dev)
 
 	ib_set_device_ops(ib_dev, hr_dev->hw->hns_roce_dev_ops);
 	ib_set_device_ops(ib_dev, &hns_roce_dev_ops);
+	ib_set_device_ops(ib_dev, &hns_roce_dev_restrack_ops);
 	for (i = 0; i < hr_dev->caps.num_ports; i++) {
 		if (!hr_dev->iboe.netdevs[i])
 			continue;
diff --git a/drivers/infiniband/hw/hns/hns_roce_restrack.c b/drivers/infiniband/hw/hns/hns_roce_restrack.c
index 24a154d64630..83417be15d3f 100644
--- a/drivers/infiniband/hw/hns/hns_roce_restrack.c
+++ b/drivers/infiniband/hw/hns/hns_roce_restrack.c
@@ -55,45 +55,34 @@ static int hns_roce_fill_cq(struct sk_buff *msg,
 	return -EMSGSIZE;
 }
 
-int hns_roce_fill_res_cq_entry(struct sk_buff *msg,
-			       struct ib_cq *ib_cq)
+int hns_roce_fill_res_cq_entry(struct sk_buff *msg, struct ib_cq *ib_cq)
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(ib_cq->device);
 	struct hns_roce_cq *hr_cq = to_hr_cq(ib_cq);
-	struct hns_roce_v2_cq_context *context;
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
-		goto err_cancel_table;
-	}
+	if (hns_roce_fill_cq(msg, &context))
+		goto err;
 
 	nla_nest_end(msg, table_attr);
-	kfree(context);
 
 	return 0;
 
-err_cancel_table:
-	nla_nest_cancel(msg, table_attr);
 err:
-	kfree(context);
-	return ret;
+	nla_nest_cancel(msg, table_attr);
+
+	return -EMSGSIZE;
 }
-- 
2.30.0

