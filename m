Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42FFD59BDC0
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Aug 2022 12:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiHVKpm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Aug 2022 06:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233753AbiHVKpe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Aug 2022 06:45:34 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442302B256
        for <linux-rdma@vger.kernel.org>; Mon, 22 Aug 2022 03:45:31 -0700 (PDT)
Received: from dggpeml500022.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MB86K4plrzXdvW;
        Mon, 22 Aug 2022 18:41:13 +0800 (CST)
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
Subject: [PATCH v2 for-next 2/7] RDMA/hns: Add or remove CQ's restrack attributes
Date:   Mon, 22 Aug 2022 18:44:50 +0800
Message-ID: <20220822104455.2311053-3-liangwenpeng@huawei.com>
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

Remove the resttrack attributes from the queue context held by ROCEE, and
add the resttrack attributes from the queue information maintained by the
driver.

For example:

$ rdma res show cq dev hns_0 cqn 14 -dd -jp
[ {
        "ifindex": 4,
        "ifname": "hns_0",
        "cqn": 14,
        "cqe": 127,
        "users": 1,
        "adaptive-moderation": false,
        "ctxn": 8,
        "pid": 1524,
        "comm": "ib_send_bw"
    },
    "drv_cq_depth": 128,
    "drv_cons_index": 0,
    "drv_cqe_size": 32,
    "drv_arm_sn": 1
}

Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_restrack.c | 67 +++----------------
 1 file changed, 10 insertions(+), 57 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_restrack.c b/drivers/infiniband/hw/hns/hns_roce_restrack.c
index 83417be15d3f..2e8299784bc2 100644
--- a/drivers/infiniband/hw/hns/hns_roce_restrack.c
+++ b/drivers/infiniband/hw/hns/hns_roce_restrack.c
@@ -9,72 +9,25 @@
 #include "hns_roce_device.h"
 #include "hns_roce_hw_v2.h"
 
-static int hns_roce_fill_cq(struct sk_buff *msg,
-			    struct hns_roce_v2_cq_context *context)
-{
-	if (rdma_nl_put_driver_u32(msg, "state",
-				   hr_reg_read(context, CQC_ARM_ST)))
-
-		goto err;
-
-	if (rdma_nl_put_driver_u32(msg, "ceqn",
-				   hr_reg_read(context, CQC_CEQN)))
-		goto err;
-
-	if (rdma_nl_put_driver_u32(msg, "cqn",
-				   hr_reg_read(context, CQC_CQN)))
-		goto err;
-
-	if (rdma_nl_put_driver_u32(msg, "hopnum",
-				   hr_reg_read(context, CQC_CQE_HOP_NUM)))
-		goto err;
-
-	if (rdma_nl_put_driver_u32(msg, "pi",
-				   hr_reg_read(context, CQC_CQ_PRODUCER_IDX)))
-		goto err;
-
-	if (rdma_nl_put_driver_u32(msg, "ci",
-				   hr_reg_read(context, CQC_CQ_CONSUMER_IDX)))
-		goto err;
-
-	if (rdma_nl_put_driver_u32(msg, "coalesce",
-				   hr_reg_read(context, CQC_CQ_MAX_CNT)))
-		goto err;
-
-	if (rdma_nl_put_driver_u32(msg, "period",
-				   hr_reg_read(context, CQC_CQ_PERIOD)))
-		goto err;
-
-	if (rdma_nl_put_driver_u32(msg, "cnt",
-				   hr_reg_read(context, CQC_CQE_CNT)))
-		goto err;
-
-	return 0;
-
-err:
-	return -EMSGSIZE;
-}
-
 int hns_roce_fill_res_cq_entry(struct sk_buff *msg, struct ib_cq *ib_cq)
 {
-	struct hns_roce_dev *hr_dev = to_hr_dev(ib_cq->device);
 	struct hns_roce_cq *hr_cq = to_hr_cq(ib_cq);
-	struct hns_roce_v2_cq_context context;
 	struct nlattr *table_attr;
-	int ret;
-
-	if (!hr_dev->hw->query_cqc)
-		return -EINVAL;
-
-	ret = hr_dev->hw->query_cqc(hr_dev, hr_cq->cqn, &context);
-	if (ret)
-		return -EINVAL;
 
 	table_attr = nla_nest_start(msg, RDMA_NLDEV_ATTR_DRIVER);
 	if (!table_attr)
 		return -EMSGSIZE;
 
-	if (hns_roce_fill_cq(msg, &context))
+	if (rdma_nl_put_driver_u32(msg, "cq_depth", hr_cq->cq_depth))
+		goto err;
+
+	if (rdma_nl_put_driver_u32(msg, "cons_index", hr_cq->cons_index))
+		goto err;
+
+	if (rdma_nl_put_driver_u32(msg, "cqe_size", hr_cq->cqe_size))
+		goto err;
+
+	if (rdma_nl_put_driver_u32(msg, "arm_sn", hr_cq->arm_sn))
 		goto err;
 
 	nla_nest_end(msg, table_attr);
-- 
2.30.0

