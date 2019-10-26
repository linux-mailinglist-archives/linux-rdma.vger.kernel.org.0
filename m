Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37DDFE58EA
	for <lists+linux-rdma@lfdr.de>; Sat, 26 Oct 2019 09:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbfJZHAP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 26 Oct 2019 03:00:15 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56882 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726010AbfJZHAP (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 26 Oct 2019 03:00:15 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id CE0DF788287DA706FBD9;
        Sat, 26 Oct 2019 15:00:12 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Sat, 26 Oct 2019 15:00:05 +0800
From:   Weihang Li <liweihang@hisilicon.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH for-rc 1/2] RDMA/hns: Fix memory leaks about mr
Date:   Sat, 26 Oct 2019 14:56:34 +0800
Message-ID: <1572072995-11277-2-git-send-email-liweihang@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1572072995-11277-1-git-send-email-liweihang@hisilicon.com>
References: <1572072995-11277-1-git-send-email-liweihang@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lijun Ou <oulijun@huawei.com>

In hns_roce_v1_dereg_mr(), 'mr_work' is not freed in some cases, for
example, try_wait_for_completion() runs fail, which will cause memory
leaks.

Fixes: bfcc681bd09d ("IB/hns: Fix the bug when free mr")
Signed-off-by: Lijun Ou <oulijun@huawei.com>
Signed-off-by: Weihang Li <liweihang@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
index 5f74bf5..88c1cd9 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -1094,7 +1094,6 @@ static void hns_roce_v1_mr_free_work_fn(struct work_struct *work)
 free_work:
 	if (mr_work->comp_flag)
 		complete(mr_work->comp);
-	kfree(mr_work);
 }
 
 static int hns_roce_v1_dereg_mr(struct hns_roce_dev *hr_dev,
@@ -1137,18 +1136,21 @@ static int hns_roce_v1_dereg_mr(struct hns_roce_dev *hr_dev,
 
 	while (end > 0) {
 		if (try_wait_for_completion(&comp))
-			goto free_mr;
+			goto err;
 		msleep(HNS_ROCE_V1_FREE_MR_WAIT_VALUE);
 		end -= HNS_ROCE_V1_FREE_MR_WAIT_VALUE;
 	}
 
 	mr_work->comp_flag = 0;
 	if (try_wait_for_completion(&comp))
-		goto free_mr;
+		goto err;
 
 	dev_warn(dev, "Free mr work 0x%x over 50s and failed!\n", mr->key);
 	ret = -ETIMEDOUT;
 
+err:
+	kfree(mr_work);
+
 free_mr:
 	dev_dbg(dev, "Free mr 0x%x use 0x%x us.\n",
 		mr->key, jiffies_to_usecs(jiffies) - jiffies_to_usecs(start));
-- 
2.8.1

