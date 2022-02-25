Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11D54C4399
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Feb 2022 12:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239160AbiBYL1P (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Feb 2022 06:27:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240020AbiBYL1N (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 25 Feb 2022 06:27:13 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592491E4824
        for <linux-rdma@vger.kernel.org>; Fri, 25 Feb 2022 03:26:25 -0800 (PST)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4K4nR20Sx0z1FDbW;
        Fri, 25 Feb 2022 19:21:34 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
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
Subject: [PATCH v2 for-next 8/9] RDMA/hns: Refactor the alloc_srqc()
Date:   Fri, 25 Feb 2022 19:25:58 +0800
Message-ID: <20220225112559.43300-9-liangwenpeng@huawei.com>
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

From: Chengchang Tang <tangchengchang@huawei.com>

Abstract the alloc_srqc() into several parts and separate the alloc_srqn()
from the alloc_srqc().

Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_srq.c | 80 +++++++++++++++---------
 1 file changed, 52 insertions(+), 28 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_srq.c b/drivers/infiniband/hw/hns/hns_roce_srq.c
index 97032a357b00..8dae98f827eb 100644
--- a/drivers/infiniband/hw/hns/hns_roce_srq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_srq.c
@@ -59,40 +59,39 @@ static void hns_roce_ib_srq_event(struct hns_roce_srq *srq,
 	}
 }
 
-static int alloc_srqc(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq)
+static int alloc_srqn(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq)
 {
-	struct hns_roce_srq_table *srq_table = &hr_dev->srq_table;
 	struct hns_roce_ida *srq_ida = &hr_dev->srq_table.srq_ida;
-	struct ib_device *ibdev = &hr_dev->ib_dev;
-	struct hns_roce_cmd_mailbox *mailbox;
-	int ret;
 	int id;
 
 	id = ida_alloc_range(&srq_ida->ida, srq_ida->min, srq_ida->max,
 			     GFP_KERNEL);
 	if (id < 0) {
-		ibdev_err(ibdev, "failed to alloc srq(%d).\n", id);
+		ibdev_err(&hr_dev->ib_dev, "failed to alloc srq(%d).\n", id);
 		return -ENOMEM;
 	}
-	srq->srqn = (unsigned long)id;
 
-	ret = hns_roce_table_get(hr_dev, &srq_table->table, srq->srqn);
-	if (ret) {
-		ibdev_err(ibdev, "failed to get SRQC table, ret = %d.\n", ret);
-		goto err_out;
-	}
+	srq->srqn = id;
 
-	ret = xa_err(xa_store(&srq_table->xa, srq->srqn, srq, GFP_KERNEL));
-	if (ret) {
-		ibdev_err(ibdev, "failed to store SRQC, ret = %d.\n", ret);
-		goto err_put;
-	}
+	return 0;
+}
+
+static void free_srqn(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq)
+{
+	ida_free(&hr_dev->srq_table.srq_ida.ida, (int)srq->srqn);
+}
+
+static int hns_roce_create_srqc(struct hns_roce_dev *hr_dev,
+				struct hns_roce_srq *srq)
+{
+	struct ib_device *ibdev = &hr_dev->ib_dev;
+	struct hns_roce_cmd_mailbox *mailbox;
+	int ret;
 
 	mailbox = hns_roce_alloc_cmd_mailbox(hr_dev);
 	if (IS_ERR(mailbox)) {
 		ibdev_err(ibdev, "failed to alloc mailbox for SRQC.\n");
-		ret = PTR_ERR(mailbox);
-		goto err_xa;
+		return PTR_ERR(mailbox);
 	}
 
 	ret = hr_dev->hw->write_srqc(srq, mailbox->buf);
@@ -103,23 +102,42 @@ static int alloc_srqc(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq)
 
 	ret = hns_roce_create_hw_ctx(hr_dev, mailbox, HNS_ROCE_CMD_CREATE_SRQ,
 				     srq->srqn);
-	if (ret) {
+	if (ret)
 		ibdev_err(ibdev, "failed to config SRQC, ret = %d.\n", ret);
-		goto err_mbox;
-	}
 
+err_mbox:
 	hns_roce_free_cmd_mailbox(hr_dev, mailbox);
+	return ret;
+}
+
+static int alloc_srqc(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq)
+{
+	struct hns_roce_srq_table *srq_table = &hr_dev->srq_table;
+	struct ib_device *ibdev = &hr_dev->ib_dev;
+	int ret;
+
+	ret = hns_roce_table_get(hr_dev, &srq_table->table, srq->srqn);
+	if (ret) {
+		ibdev_err(ibdev, "failed to get SRQC table, ret = %d.\n", ret);
+		return ret;
+	}
+
+	ret = xa_err(xa_store(&srq_table->xa, srq->srqn, srq, GFP_KERNEL));
+	if (ret) {
+		ibdev_err(ibdev, "failed to store SRQC, ret = %d.\n", ret);
+		goto err_put;
+	}
+
+	ret = hns_roce_create_srqc(hr_dev, srq);
+	if (ret)
+		goto err_xa;
 
 	return 0;
 
-err_mbox:
-	hns_roce_free_cmd_mailbox(hr_dev, mailbox);
 err_xa:
 	xa_erase(&srq_table->xa, srq->srqn);
 err_put:
 	hns_roce_table_put(hr_dev, &srq_table->table, srq->srqn);
-err_out:
-	ida_free(&srq_ida->ida, id);
 
 	return ret;
 }
@@ -142,7 +160,6 @@ static void free_srqc(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq)
 	wait_for_completion(&srq->free);
 
 	hns_roce_table_put(hr_dev, &srq_table->table, srq->srqn);
-	ida_free(&srq_table->srq_ida.ida, (int)srq->srqn);
 }
 
 static int alloc_srq_idx(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq,
@@ -390,10 +407,14 @@ int hns_roce_create_srq(struct ib_srq *ib_srq,
 	if (ret)
 		return ret;
 
-	ret = alloc_srqc(hr_dev, srq);
+	ret = alloc_srqn(hr_dev, srq);
 	if (ret)
 		goto err_srq_buf;
 
+	ret = alloc_srqc(hr_dev, srq);
+	if (ret)
+		goto err_srqn;
+
 	if (udata) {
 		resp.srqn = srq->srqn;
 		if (ib_copy_to_udata(udata, &resp,
@@ -412,6 +433,8 @@ int hns_roce_create_srq(struct ib_srq *ib_srq,
 
 err_srqc:
 	free_srqc(hr_dev, srq);
+err_srqn:
+	free_srqn(hr_dev, srq);
 err_srq_buf:
 	free_srq_buf(hr_dev, srq);
 
@@ -424,6 +447,7 @@ int hns_roce_destroy_srq(struct ib_srq *ibsrq, struct ib_udata *udata)
 	struct hns_roce_srq *srq = to_hr_srq(ibsrq);
 
 	free_srqc(hr_dev, srq);
+	free_srqn(hr_dev, srq);
 	free_srq_buf(hr_dev, srq);
 	return 0;
 }
-- 
2.33.0

