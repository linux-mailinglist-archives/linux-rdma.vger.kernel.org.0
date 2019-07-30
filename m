Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3778F7A38D
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2019 11:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731227AbfG3JA5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Jul 2019 05:00:57 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:54048 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730510AbfG3JA5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 30 Jul 2019 05:00:57 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8CB52B671135E9B4F922;
        Tue, 30 Jul 2019 17:00:53 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.439.0; Tue, 30 Jul 2019 17:00:46 +0800
From:   Lijun Ou <oulijun@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 09/13] RDMA/hns: Refactor irq request code
Date:   Tue, 30 Jul 2019 16:56:46 +0800
Message-ID: <1564477010-29804-10-git-send-email-oulijun@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1564477010-29804-1-git-send-email-oulijun@huawei.com>
References: <1564477010-29804-1-git-send-email-oulijun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lang Cheng <chenglang@huawei.com>

Remove unnecessary if...else..., to make the code look simpler.

Signed-off-by: Lang Cheng <chenglang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 85e0687a..1186e34 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -5749,18 +5749,19 @@ static int __hns_roce_request_irq(struct hns_roce_dev *hr_dev, int irq_num,
 	}
 
 	/* irq contains: abnormal + AEQ + CEQ */
-	for (j = 0; j < irq_num; j++)
-		if (j < other_num)
-			snprintf((char *)hr_dev->irq_names[j],
-				 HNS_ROCE_INT_NAME_LEN, "hns-abn-%d", j);
-		else if (j < (other_num + aeq_num))
-			snprintf((char *)hr_dev->irq_names[j],
-				 HNS_ROCE_INT_NAME_LEN, "hns-aeq-%d",
-				 j - other_num);
-		else
-			snprintf((char *)hr_dev->irq_names[j],
-				 HNS_ROCE_INT_NAME_LEN, "hns-ceq-%d",
-				 j - other_num - aeq_num);
+	for (j = 0; j < other_num; j++)
+		snprintf((char *)hr_dev->irq_names[j],
+			 HNS_ROCE_INT_NAME_LEN, "hns-abn-%d", j);
+
+	for (j = other_num; j < (other_num + aeq_num); j++)
+		snprintf((char *)hr_dev->irq_names[j],
+			 HNS_ROCE_INT_NAME_LEN, "hns-aeq-%d",
+			 j - other_num);
+
+	for (j = (other_num + aeq_num); j < irq_num; j++)
+		snprintf((char *)hr_dev->irq_names[j],
+			 HNS_ROCE_INT_NAME_LEN, "hns-ceq-%d",
+			 j - other_num - aeq_num);
 
 	for (j = 0; j < irq_num; j++) {
 		if (j < other_num)
-- 
1.9.1

