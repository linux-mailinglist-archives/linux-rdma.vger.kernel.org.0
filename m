Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA0E18B6BE
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2020 14:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbgCSN3F (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Mar 2020 09:29:05 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12161 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729721AbgCSN3C (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 19 Mar 2020 09:29:02 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id ED6DB98776C969207F89;
        Thu, 19 Mar 2020 21:28:52 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Thu, 19 Mar 2020 21:28:44 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 08/11] RDMA/hns: Remove meaningless prints
Date:   Thu, 19 Mar 2020 21:24:55 +0800
Message-ID: <1584624298-23841-9-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1584624298-23841-1-git-send-email-liweihang@huawei.com>
References: <1584624298-23841-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Wenpeng Liang <liangwenpeng@huawei.com>

ceq and aeq is a ring buffer, consumer index of them will be set to zero
after reaching the maximum value. The warning should be removed or it may
mislead the users.

Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c | 9 ++-------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 5 +----
 2 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
index 2e53045..5ff028d 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -3935,10 +3935,8 @@ static int hns_roce_v1_aeq_int(struct hns_roce_dev *hr_dev,
 		eq->cons_index++;
 		aeqes_found = 1;
 
-		if (eq->cons_index > 2 * hr_dev->caps.aeqe_depth - 1) {
-			dev_warn(dev, "cons_index overflow, set back to 0.\n");
+		if (eq->cons_index > 2 * hr_dev->caps.aeqe_depth - 1)
 			eq->cons_index = 0;
-		}
 	}
 
 	set_eq_cons_index_v1(eq, 0);
@@ -3988,11 +3986,8 @@ static int hns_roce_v1_ceq_int(struct hns_roce_dev *hr_dev,
 		ceqes_found = 1;
 
 		if (eq->cons_index >
-		    EQ_DEPTH_COEFF * hr_dev->caps.ceqe_depth - 1) {
-			dev_warn(&eq->hr_dev->pdev->dev,
-				"cons_index overflow, set back to 0.\n");
+		    EQ_DEPTH_COEFF * hr_dev->caps.ceqe_depth - 1)
 			eq->cons_index = 0;
-		}
 	}
 
 	set_eq_cons_index_v1(eq, 0);
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index aff7c5d..bd14e71 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -5361,7 +5361,6 @@ static struct hns_roce_ceqe *next_ceqe_sw_v2(struct hns_roce_eq *eq)
 static int hns_roce_v2_ceq_int(struct hns_roce_dev *hr_dev,
 			       struct hns_roce_eq *eq)
 {
-	struct device *dev = hr_dev->dev;
 	struct hns_roce_ceqe *ceqe = next_ceqe_sw_v2(eq);
 	int ceqe_found = 0;
 	u32 cqn;
@@ -5380,10 +5379,8 @@ static int hns_roce_v2_ceq_int(struct hns_roce_dev *hr_dev,
 		++eq->cons_index;
 		ceqe_found = 1;
 
-		if (eq->cons_index > (EQ_DEPTH_COEFF * eq->entries - 1)) {
-			dev_warn(dev, "cons_index overflow, set back to 0.\n");
+		if (eq->cons_index > (EQ_DEPTH_COEFF * eq->entries - 1))
 			eq->cons_index = 0;
-		}
 
 		ceqe = next_ceqe_sw_v2(eq);
 	}
-- 
2.8.1

