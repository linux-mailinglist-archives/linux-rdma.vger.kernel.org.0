Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D134C439D
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Feb 2022 12:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240105AbiBYL1Q (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Feb 2022 06:27:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240121AbiBYL1O (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 25 Feb 2022 06:27:14 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701071E4826
        for <linux-rdma@vger.kernel.org>; Fri, 25 Feb 2022 03:26:25 -0800 (PST)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4K4nVt3GJszdZhC;
        Fri, 25 Feb 2022 19:24:54 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 25 Feb 2022 19:26:07 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 25 Feb 2022 19:26:07 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>
Subject: [PATCH v2 for-next 9/9] RDMA/hns: Refactor the alloc_cqc()
Date:   Fri, 25 Feb 2022 19:25:59 +0800
Message-ID: <20220225112559.43300-10-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220225112559.43300-1-liangwenpeng@huawei.com>
References: <20220225112559.43300-1-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Abstract the alloc_cqc() into several parts and separate the process
unrelated to allocating CQC.

Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_cq.c | 65 ++++++++++++++-----------
 1 file changed, 37 insertions(+), 28 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_cq.c b/drivers/infiniband/hw/hns/hns_roce_cq.c
index 3d10300cab85..8acd599ffac1 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cq.c
@@ -100,12 +100,39 @@ static void free_cqn(struct hns_roce_dev *hr_dev, unsigned long cqn)
 	mutex_unlock(&cq_table->bank_mutex);
 }
 
+static int hns_roce_create_cqc(struct hns_roce_dev *hr_dev,
+			       struct hns_roce_cq *hr_cq,
+			       u64 *mtts, dma_addr_t dma_handle)
+{
+	struct ib_device *ibdev = &hr_dev->ib_dev;
+	struct hns_roce_cmd_mailbox *mailbox;
+	int ret;
+
+	mailbox = hns_roce_alloc_cmd_mailbox(hr_dev);
+	if (IS_ERR(mailbox)) {
+		ibdev_err(ibdev, "failed to alloc mailbox for CQC.\n");
+		return PTR_ERR(mailbox);
+	}
+
+	hr_dev->hw->write_cqc(hr_dev, hr_cq, mailbox->buf, mtts, dma_handle);
+
+	ret = hns_roce_create_hw_ctx(hr_dev, mailbox, HNS_ROCE_CMD_CREATE_CQC,
+				     hr_cq->cqn);
+	if (ret)
+		ibdev_err(ibdev,
+			  "failed to send create cmd for CQ(0x%lx), ret = %d.\n",
+			  hr_cq->cqn, ret);
+
+	hns_roce_free_cmd_mailbox(hr_dev, mailbox);
+
+	return ret;
+}
+
 static int alloc_cqc(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq)
 {
 	struct hns_roce_cq_table *cq_table = &hr_dev->cq_table;
 	struct ib_device *ibdev = &hr_dev->ib_dev;
-	struct hns_roce_cmd_mailbox *mailbox;
-	u64 mtts[MTT_MIN_COUNT] = { 0 };
+	u64 mtts[MTT_MIN_COUNT] = {};
 	dma_addr_t dma_handle;
 	int ret;
 
@@ -121,7 +148,7 @@ static int alloc_cqc(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq)
 	if (ret) {
 		ibdev_err(ibdev, "failed to get CQ(0x%lx) context, ret = %d.\n",
 			  hr_cq->cqn, ret);
-		goto err_out;
+		return ret;
 	}
 
 	ret = xa_err(xa_store(&cq_table->array, hr_cq->cqn, hr_cq, GFP_KERNEL));
@@ -130,40 +157,17 @@ static int alloc_cqc(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq)
 		goto err_put;
 	}
 
-	/* Allocate mailbox memory */
-	mailbox = hns_roce_alloc_cmd_mailbox(hr_dev);
-	if (IS_ERR(mailbox)) {
-		ret = PTR_ERR(mailbox);
-		goto err_xa;
-	}
-
-	hr_dev->hw->write_cqc(hr_dev, hr_cq, mailbox->buf, mtts, dma_handle);
-
-	ret = hns_roce_create_hw_ctx(hr_dev, mailbox, HNS_ROCE_CMD_CREATE_CQC,
-				     hr_cq->cqn);
-	hns_roce_free_cmd_mailbox(hr_dev, mailbox);
-	if (ret) {
-		ibdev_err(ibdev,
-			  "failed to send create cmd for CQ(0x%lx), ret = %d.\n",
-			  hr_cq->cqn, ret);
+	ret = hns_roce_create_cqc(hr_dev, hr_cq, mtts, dma_handle);
+	if (ret)
 		goto err_xa;
-	}
-
-	hr_cq->cons_index = 0;
-	hr_cq->arm_sn = 1;
-
-	refcount_set(&hr_cq->refcount, 1);
-	init_completion(&hr_cq->free);
 
 	return 0;
 
 err_xa:
 	xa_erase(&cq_table->array, hr_cq->cqn);
-
 err_put:
 	hns_roce_table_put(hr_dev, &cq_table->table, hr_cq->cqn);
 
-err_out:
 	return ret;
 }
 
@@ -411,6 +415,11 @@ int hns_roce_create_cq(struct ib_cq *ib_cq, const struct ib_cq_init_attr *attr,
 			goto err_cqc;
 	}
 
+	hr_cq->cons_index = 0;
+	hr_cq->arm_sn = 1;
+	refcount_set(&hr_cq->refcount, 1);
+	init_completion(&hr_cq->free);
+
 	return 0;
 
 err_cqc:
-- 
2.33.0

