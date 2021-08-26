Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0886B3F8934
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Aug 2021 15:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237433AbhHZNmU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Aug 2021 09:42:20 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:14424 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242696AbhHZNmR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Aug 2021 09:42:17 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GwP6T3Pp6zbdP6;
        Thu, 26 Aug 2021 21:37:37 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 26 Aug 2021 21:41:28 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 26 Aug 2021 21:41:28 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>
Subject: [PATCH for-next 5/7] RDMA/hns: Adjust the order in which irq are requested and enabled
Date:   Thu, 26 Aug 2021 21:37:34 +0800
Message-ID: <1629985056-57004-6-git-send-email-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1629985056-57004-1-git-send-email-liangwenpeng@huawei.com>
References: <1629985056-57004-1-git-send-email-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

It should first alloc workqueue and request irq, and finally enable irq.

Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 85ad937..c27dc68 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -6114,35 +6114,32 @@ static int hns_roce_v2_init_eq_table(struct hns_roce_dev *hr_dev)
 
 		ret = hns_roce_v2_create_eq(hr_dev, eq, eq_cmd);
 		if (ret) {
-			dev_err(dev, "eq create failed.\n");
+			dev_err(dev, "failed to create eq.\n");
 			goto err_create_eq_fail;
 		}
 	}
 
-	/* enable irq */
-	hns_roce_v2_int_mask_enable(hr_dev, eq_num, EQ_ENABLE);
+	hr_dev->irq_workq = alloc_ordered_workqueue("hns_roce_irq_workq", 0);
+	if (!hr_dev->irq_workq) {
+		dev_err(dev, "failed to create irq workqueue.\n");
+		ret = -ENOMEM;
+		goto err_create_eq_fail;
+	}
 
-	ret = __hns_roce_request_irq(hr_dev, irq_num, comp_num,
-				     aeq_num, other_num);
+	ret = __hns_roce_request_irq(hr_dev, irq_num, comp_num, aeq_num,
+				     other_num);
 	if (ret) {
-		dev_err(dev, "Request irq failed.\n");
+		dev_err(dev, "failed to request irq.\n");
 		goto err_request_irq_fail;
 	}
 
-	hr_dev->irq_workq = alloc_ordered_workqueue("hns_roce_irq_workq", 0);
-	if (!hr_dev->irq_workq) {
-		dev_err(dev, "Create irq workqueue failed!\n");
-		ret = -ENOMEM;
-		goto err_create_wq_fail;
-	}
+	/* enable irq */
+	hns_roce_v2_int_mask_enable(hr_dev, eq_num, EQ_ENABLE);
 
 	return 0;
 
-err_create_wq_fail:
-	__hns_roce_free_irq(hr_dev);
-
 err_request_irq_fail:
-	hns_roce_v2_int_mask_enable(hr_dev, eq_num, EQ_DISABLE);
+	destroy_workqueue(hr_dev->irq_workq);
 
 err_create_eq_fail:
 	for (i -= 1; i >= 0; i--)
-- 
2.8.1

