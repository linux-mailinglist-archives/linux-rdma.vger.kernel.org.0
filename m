Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1E459BDBF
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Aug 2022 12:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbiHVKpo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Aug 2022 06:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233791AbiHVKpg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Aug 2022 06:45:36 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C992CCBD
        for <linux-rdma@vger.kernel.org>; Mon, 22 Aug 2022 03:45:31 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MB88c6kZ6znTgv;
        Mon, 22 Aug 2022 18:43:12 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
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
Subject: [PATCH v2 for-next 3/7] RDMA/hns: Support CQ's restrack raw ops for hns driver
Date:   Mon, 22 Aug 2022 18:44:51 +0800
Message-ID: <20220822104455.2311053-4-liangwenpeng@huawei.com>
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

The CQ raw restrack attributes come from the queue context maintained by
the ROCEE.

For example:

$ rdma res show cq dev hns_0 cqn 14 -dd -jp -r
[ {
        "ifindex": 4,
        "ifname": "hns_0",
        "data": [ 1,0,0,0,7,0,0,0,0,0,0,0,0,82,6,0,0,82,6,0,0,82,6,0,
		  1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,
		  6,0,0,0,0,0,0,0 ]
    } ]

Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h   |  1 +
 drivers/infiniband/hw/hns/hns_roce_main.c     |  1 +
 drivers/infiniband/hw/hns/hns_roce_restrack.c | 39 +++++++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 103d50564b89..c73adc0d3555 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -1224,6 +1224,7 @@ void hns_roce_handle_device_err(struct hns_roce_dev *hr_dev);
 int hns_roce_init(struct hns_roce_dev *hr_dev);
 void hns_roce_exit(struct hns_roce_dev *hr_dev);
 int hns_roce_fill_res_cq_entry(struct sk_buff *msg, struct ib_cq *ib_cq);
+int hns_roce_fill_res_cq_entry_raw(struct sk_buff *msg, struct ib_cq *ib_cq);
 struct hns_user_mmap_entry *
 hns_roce_user_mmap_entry_insert(struct ib_ucontext *ucontext, u64 address,
 				size_t length,
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index caf73e8f4bbe..1b66ed45350e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -567,6 +567,7 @@ static const struct ib_device_ops hns_roce_dev_xrcd_ops = {
 
 static const struct ib_device_ops hns_roce_dev_restrack_ops = {
 	.fill_res_cq_entry = hns_roce_fill_res_cq_entry,
+	.fill_res_cq_entry_raw = hns_roce_fill_res_cq_entry_raw,
 };
 
 static int hns_roce_register_device(struct hns_roce_dev *hr_dev)
diff --git a/drivers/infiniband/hw/hns/hns_roce_restrack.c b/drivers/infiniband/hw/hns/hns_roce_restrack.c
index 2e8299784bc2..3f9c2f9dfdf6 100644
--- a/drivers/infiniband/hw/hns/hns_roce_restrack.c
+++ b/drivers/infiniband/hw/hns/hns_roce_restrack.c
@@ -9,6 +9,8 @@
 #include "hns_roce_device.h"
 #include "hns_roce_hw_v2.h"
 
+#define MAX_ENTRY_NUM 256
+
 int hns_roce_fill_res_cq_entry(struct sk_buff *msg, struct ib_cq *ib_cq)
 {
 	struct hns_roce_cq *hr_cq = to_hr_cq(ib_cq);
@@ -39,3 +41,40 @@ int hns_roce_fill_res_cq_entry(struct sk_buff *msg, struct ib_cq *ib_cq)
 
 	return -EMSGSIZE;
 }
+
+int hns_roce_fill_res_cq_entry_raw(struct sk_buff *msg, struct ib_cq *ib_cq)
+{
+	struct hns_roce_dev *hr_dev = to_hr_dev(ib_cq->device);
+	struct hns_roce_cq *hr_cq = to_hr_cq(ib_cq);
+	struct hns_roce_v2_cq_context context;
+	u32 data[MAX_ENTRY_NUM] = {};
+	int offset = 0;
+	int ret;
+
+	if (!hr_dev->hw->query_cqc)
+		return -EINVAL;
+
+	ret = hr_dev->hw->query_cqc(hr_dev, hr_cq->cqn, &context);
+	if (ret)
+		return -EINVAL;
+
+	data[offset++] = hr_reg_read(&context, CQC_CQ_ST);
+	data[offset++] = hr_reg_read(&context, CQC_SHIFT);
+	data[offset++] = hr_reg_read(&context, CQC_CQE_SIZE);
+	data[offset++] = hr_reg_read(&context, CQC_CQE_CNT);
+	data[offset++] = hr_reg_read(&context, CQC_CQ_PRODUCER_IDX);
+	data[offset++] = hr_reg_read(&context, CQC_CQ_CONSUMER_IDX);
+	data[offset++] = hr_reg_read(&context, CQC_DB_RECORD_EN);
+	data[offset++] = hr_reg_read(&context, CQC_ARM_ST);
+	data[offset++] = hr_reg_read(&context, CQC_CMD_SN);
+	data[offset++] = hr_reg_read(&context, CQC_CEQN);
+	data[offset++] = hr_reg_read(&context, CQC_CQ_MAX_CNT);
+	data[offset++] = hr_reg_read(&context, CQC_CQ_PERIOD);
+	data[offset++] = hr_reg_read(&context, CQC_CQE_HOP_NUM);
+	data[offset++] = hr_reg_read(&context, CQC_CQE_BAR_PG_SZ);
+	data[offset++] = hr_reg_read(&context, CQC_CQE_BUF_PG_SZ);
+
+	ret = nla_put(msg, RDMA_NLDEV_ATTR_RES_RAW, offset * sizeof(u32), data);
+
+	return ret;
+}
-- 
2.30.0

