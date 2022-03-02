Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 913BA4C9DF9
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Mar 2022 07:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239744AbiCBGt1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Mar 2022 01:49:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239745AbiCBGt0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Mar 2022 01:49:26 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01AEBB2D62
        for <linux-rdma@vger.kernel.org>; Tue,  1 Mar 2022 22:48:43 -0800 (PST)
Received: from dggpeml500022.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4K7l2T48Dwz1GByH;
        Wed,  2 Mar 2022 14:44:01 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 2 Mar 2022 14:48:41 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 2 Mar 2022 14:48:40 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>
Subject: [PATCH v3 for-next 7/9] RDMA/hns: Clean up the return value check of hns_roce_alloc_cmd_mailbox()
Date:   Wed, 2 Mar 2022 14:48:28 +0800
Message-ID: <20220302064830.61706-8-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220302064830.61706-1-liangwenpeng@huawei.com>
References: <20220302064830.61706-1-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

hns_roce_alloc_cmd_mailbox() never returns NULL, so the check should be
IS_ERR(). And the error code should be converted as the function's return
value.

Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 4 ++--
 drivers/infiniband/hw/hns/hns_roce_mr.c    | 6 ++----
 drivers/infiniband/hw/hns/hns_roce_srq.c   | 4 ++--
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 631f6e233492..06eb4f00428c 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -5981,8 +5981,8 @@ static int hns_roce_v2_create_eq(struct hns_roce_dev *hr_dev,
 
 	/* Allocate mailbox memory */
 	mailbox = hns_roce_alloc_cmd_mailbox(hr_dev);
-	if (IS_ERR_OR_NULL(mailbox))
-		return -ENOMEM;
+	if (IS_ERR(mailbox))
+		return PTR_ERR(mailbox);
 
 	ret = alloc_eq_buf(hr_dev, eq);
 	if (ret)
diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index 39de862666d7..b58b869339cc 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -148,10 +148,8 @@ static int hns_roce_mr_enable(struct hns_roce_dev *hr_dev,
 
 	/* Allocate mailbox memory */
 	mailbox = hns_roce_alloc_cmd_mailbox(hr_dev);
-	if (IS_ERR(mailbox)) {
-		ret = PTR_ERR(mailbox);
-		return ret;
-	}
+	if (IS_ERR(mailbox))
+		return PTR_ERR(mailbox);
 
 	if (mr->type != MR_TYPE_FRMR)
 		ret = hr_dev->hw->write_mtpt(hr_dev, mailbox->buf, mr);
diff --git a/drivers/infiniband/hw/hns/hns_roce_srq.c b/drivers/infiniband/hw/hns/hns_roce_srq.c
index e316276e18c2..97032a357b00 100644
--- a/drivers/infiniband/hw/hns/hns_roce_srq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_srq.c
@@ -89,9 +89,9 @@ static int alloc_srqc(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq)
 	}
 
 	mailbox = hns_roce_alloc_cmd_mailbox(hr_dev);
-	if (IS_ERR_OR_NULL(mailbox)) {
+	if (IS_ERR(mailbox)) {
 		ibdev_err(ibdev, "failed to alloc mailbox for SRQC.\n");
-		ret = -ENOMEM;
+		ret = PTR_ERR(mailbox);
 		goto err_xa;
 	}
 
-- 
2.33.0

