Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C920535DAD3
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Apr 2021 11:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbhDMJOg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Apr 2021 05:14:36 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:17323 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhDMJOg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 13 Apr 2021 05:14:36 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FKKcF3vq5z9ygL;
        Tue, 13 Apr 2021 17:11:57 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.498.0; Tue, 13 Apr 2021 17:14:03 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Yixian Liu <liuyixian@huawei.com>,
        Weihang Li <liweihang@huawei.com>
Subject: [PATCH for-next] RDMA/hns: Remove unnecessary flush operation for workqueue
Date:   Tue, 13 Apr 2021 17:11:27 +0800
Message-ID: <1618305087-30799-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yixian Liu <liuyixian@huawei.com>

As flush operation is implemented inside destroy workqueue, there is no
need to do flush operation before destroying workqueue.

Fixes: bfcc681bd09d ("IB/hns: Fix the bug when free mr")
Fixes: 0425e3e6e0c7 ("RDMA/hns: Support flush cqe for hip08 in kernel space")
Signed-off-by: Yixian Liu <liuyixian@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c | 2 --
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 1 -
 2 files changed, 3 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
index 8a3fe6d..620acf6 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -1382,7 +1382,6 @@ static int hns_roce_free_mr_init(struct hns_roce_dev *hr_dev)
 	ret = hns_roce_v1_rsv_lp_qp(hr_dev);
 	if (ret) {
 		dev_err(dev, "Reserved loop qp failed(%d)!\n", ret);
-		flush_workqueue(free_mr->free_mr_wq);
 		destroy_workqueue(free_mr->free_mr_wq);
 	}
 
@@ -1394,7 +1393,6 @@ static void hns_roce_free_mr_free(struct hns_roce_dev *hr_dev)
 	struct hns_roce_v1_priv *priv = hr_dev->priv;
 	struct hns_roce_free_mr *free_mr = &priv->free_mr;
 
-	flush_workqueue(free_mr->free_mr_wq);
 	destroy_workqueue(free_mr->free_mr_wq);
 
 	hns_roce_v1_release_lp_qp(hr_dev);
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 1b05ebe..79c535e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -6404,7 +6404,6 @@ static void hns_roce_v2_cleanup_eq_table(struct hns_roce_dev *hr_dev)
 	hns_roce_v2_int_mask_enable(hr_dev, eq_num, EQ_DISABLE);
 
 	__hns_roce_free_irq(hr_dev);
-	flush_workqueue(hr_dev->irq_workq);
 	destroy_workqueue(hr_dev->irq_workq);
 
 	for (i = 0; i < eq_num; i++) {
-- 
2.8.1

