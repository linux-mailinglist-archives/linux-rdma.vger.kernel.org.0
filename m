Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A82D259BDC4
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Aug 2022 12:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiHVKpn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Aug 2022 06:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233794AbiHVKpg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Aug 2022 06:45:36 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454622CE15
        for <linux-rdma@vger.kernel.org>; Mon, 22 Aug 2022 03:45:32 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MB87H2gQCz1N7Wh;
        Mon, 22 Aug 2022 18:42:03 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
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
Subject: [PATCH v2 for-next 7/7] RDMA/hns: Support MR's restrack raw ops for hns driver
Date:   Mon, 22 Aug 2022 18:44:55 +0800
Message-ID: <20220822104455.2311053-8-liangwenpeng@huawei.com>
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

The MR raw restrack attributes come from the queue context maintained by
the ROCEE.

For example:

$ rdma res show mr dev hns_0 mrn 6 -dd -jp -r
[ {
        "ifindex": 4,
        "ifname": "hns_0",
        "data": [ 1,0,0,0,2,0,0,0,0,3,0,0,0,0,2,0,0,0,0,0,32,0,0,0,2,0,0,0,
		  2,0,0,0,0,0,0,0 ]
    } ]

Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h   |  2 ++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c    | 29 +++++++++++++++++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h    |  3 +-
 drivers/infiniband/hw/hns/hns_roce_main.c     |  1 +
 drivers/infiniband/hw/hns/hns_roce_restrack.c | 31 +++++++++++++++++++
 5 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 30a67bc70f1a..1bcecc5589fa 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -896,6 +896,7 @@ struct hns_roce_hw {
 	int (*write_srqc)(struct hns_roce_srq *srq, void *mb_buf);
 	int (*query_cqc)(struct hns_roce_dev *hr_dev, u32 cqn, void *buffer);
 	int (*query_qpc)(struct hns_roce_dev *hr_dev, u32 qpn, void *buffer);
+	int (*query_mpt)(struct hns_roce_dev *hr_dev, u32 key, void *buffer);
 	const struct ib_device_ops *hns_roce_dev_ops;
 	const struct ib_device_ops *hns_roce_dev_srq_ops;
 };
@@ -1229,6 +1230,7 @@ int hns_roce_fill_res_cq_entry_raw(struct sk_buff *msg, struct ib_cq *ib_cq);
 int hns_roce_fill_res_qp_entry(struct sk_buff *msg, struct ib_qp *ib_qp);
 int hns_roce_fill_res_qp_entry_raw(struct sk_buff *msg, struct ib_qp *ib_qp);
 int hns_roce_fill_res_mr_entry(struct sk_buff *msg, struct ib_mr *ib_mr);
+int hns_roce_fill_res_mr_entry_raw(struct sk_buff *msg, struct ib_mr *ib_mr);
 struct hns_user_mmap_entry *
 hns_roce_user_mmap_entry_insert(struct ib_ucontext *ucontext, u64 address,
 				size_t length,
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 319de9a4d2ef..f59176561420 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -5802,6 +5802,34 @@ static int hns_roce_v2_query_cqc(struct hns_roce_dev *hr_dev, u32 cqn,
 	return ret;
 }
 
+int hns_roce_v2_query_mpt(struct hns_roce_dev *hr_dev, u32 key, void *buffer)
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
+	ret = hns_roce_cmd_mbox(hr_dev, 0, mailbox->dma, HNS_ROCE_CMD_QUERY_MPT,
+				key_to_hw_index(key));
+	if (ret) {
+		ibdev_err(&hr_dev->ib_dev,
+			  "failed to process cmd when querying MPT, ret = %d.\n",
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
@@ -6645,6 +6673,7 @@ static const struct hns_roce_hw hns_roce_hw_v2 = {
 	.write_srqc = hns_roce_v2_write_srqc,
 	.query_cqc = hns_roce_v2_query_cqc,
 	.query_qpc = hns_roce_v2_query_qpc,
+	.query_mpt = hns_roce_v2_query_mpt,
 	.hns_roce_dev_ops = &hns_roce_v2_dev_ops,
 	.hns_roce_dev_srq_ops = &hns_roce_v2_dev_srq_ops,
 };
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index 49ec29973ed7..ae29780dd63a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -758,7 +758,8 @@ struct hns_roce_v2_mpt_entry {
 #define MPT_INNER_PA_VLD MPT_FIELD_LOC(71, 71)
 #define MPT_MW_BIND_QPN MPT_FIELD_LOC(95, 72)
 #define MPT_BOUND_LKEY MPT_FIELD_LOC(127, 96)
-#define MPT_LEN MPT_FIELD_LOC(191, 128)
+#define MPT_LEN_L MPT_FIELD_LOC(159, 128)
+#define MPT_LEN_H MPT_FIELD_LOC(191, 160)
 #define MPT_LKEY MPT_FIELD_LOC(223, 192)
 #define MPT_VA MPT_FIELD_LOC(287, 224)
 #define MPT_PBL_SIZE MPT_FIELD_LOC(319, 288)
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index ff4386b5c064..9de3a522980a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -571,6 +571,7 @@ static const struct ib_device_ops hns_roce_dev_restrack_ops = {
 	.fill_res_qp_entry = hns_roce_fill_res_qp_entry,
 	.fill_res_qp_entry_raw = hns_roce_fill_res_qp_entry_raw,
 	.fill_res_mr_entry = hns_roce_fill_res_mr_entry,
+	.fill_res_mr_entry_raw = hns_roce_fill_res_mr_entry_raw,
 };
 
 static int hns_roce_register_device(struct hns_roce_dev *hr_dev)
diff --git a/drivers/infiniband/hw/hns/hns_roce_restrack.c b/drivers/infiniband/hw/hns/hns_roce_restrack.c
index 84f942e19743..989a2af2e938 100644
--- a/drivers/infiniband/hw/hns/hns_roce_restrack.c
+++ b/drivers/infiniband/hw/hns/hns_roce_restrack.c
@@ -198,3 +198,34 @@ int hns_roce_fill_res_mr_entry(struct sk_buff *msg, struct ib_mr *ib_mr)
 
 	return -EMSGSIZE;
 }
+
+int hns_roce_fill_res_mr_entry_raw(struct sk_buff *msg, struct ib_mr *ib_mr)
+{
+	struct hns_roce_dev *hr_dev = to_hr_dev(ib_mr->device);
+	struct hns_roce_mr *hr_mr = to_hr_mr(ib_mr);
+	struct hns_roce_v2_mpt_entry context;
+	u32 data[MAX_ENTRY_NUM] = {};
+	int offset = 0;
+	int ret;
+
+	if (!hr_dev->hw->query_mpt)
+		return -EINVAL;
+
+	ret = hr_dev->hw->query_mpt(hr_dev, hr_mr->key, &context);
+	if (ret)
+		return -EINVAL;
+
+	data[offset++] = hr_reg_read(&context, MPT_ST);
+	data[offset++] = hr_reg_read(&context, MPT_PD);
+	data[offset++] = hr_reg_read(&context, MPT_LKEY);
+	data[offset++] = hr_reg_read(&context, MPT_LEN_L);
+	data[offset++] = hr_reg_read(&context, MPT_LEN_H);
+	data[offset++] = hr_reg_read(&context, MPT_PBL_SIZE);
+	data[offset++] = hr_reg_read(&context, MPT_PBL_HOP_NUM);
+	data[offset++] = hr_reg_read(&context, MPT_PBL_BA_PG_SZ);
+	data[offset++] = hr_reg_read(&context, MPT_PBL_BUF_PG_SZ);
+
+	ret = nla_put(msg, RDMA_NLDEV_ATTR_RES_RAW, offset * sizeof(u32), data);
+
+	return ret;
+}
-- 
2.30.0

