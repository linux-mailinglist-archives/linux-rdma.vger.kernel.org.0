Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC459EFC2A
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Nov 2019 12:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388735AbfKELLw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Nov 2019 06:11:52 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:6155 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388734AbfKELLv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 5 Nov 2019 06:11:51 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6F17D9AF5CE12CF98B65;
        Tue,  5 Nov 2019 19:11:49 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.439.0; Tue, 5 Nov 2019 19:11:38 +0800
From:   Weihang Li <liweihang@hisilicon.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH v2 for-next 8/9] RDMA/hns: Fix non-standard error codes
Date:   Tue, 5 Nov 2019 19:08:01 +0800
Message-ID: <1572952082-6681-9-git-send-email-liweihang@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1572952082-6681-1-git-send-email-liweihang@hisilicon.com>
References: <1572952082-6681-1-git-send-email-liweihang@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yixian Liu <liuyixian@huawei.com>

It is better to return a linux error code than define a private constant.

Signed-off-by: Yixian Liu <liuyixian@huawei.com>
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
Signed-off-by: Weihang Li <liweihang@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_alloc.c |  4 ++--
 drivers/infiniband/hw/hns/hns_roce_cq.c    |  4 ++--
 drivers/infiniband/hw/hns/hns_roce_mr.c    | 15 ++++++++-------
 drivers/infiniband/hw/hns/hns_roce_pd.c    |  2 +-
 drivers/infiniband/hw/hns/hns_roce_srq.c   |  2 +-
 5 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_alloc.c b/drivers/infiniband/hw/hns/hns_roce_alloc.c
index 8c063c5..da574c2 100644
--- a/drivers/infiniband/hw/hns/hns_roce_alloc.c
+++ b/drivers/infiniband/hw/hns/hns_roce_alloc.c
@@ -55,7 +55,7 @@ int hns_roce_bitmap_alloc(struct hns_roce_bitmap *bitmap, unsigned long *obj)
 			bitmap->last = 0;
 		*obj |= bitmap->top;
 	} else {
-		ret = -1;
+		ret = -EINVAL;
 	}
 
 	spin_unlock(&bitmap->lock);
@@ -100,7 +100,7 @@ int hns_roce_bitmap_alloc_range(struct hns_roce_bitmap *bitmap, int cnt,
 		}
 		*obj |= bitmap->top;
 	} else {
-		ret = -1;
+		ret = -EINVAL;
 	}
 
 	spin_unlock(&bitmap->lock);
diff --git a/drivers/infiniband/hw/hns/hns_roce_cq.c b/drivers/infiniband/hw/hns/hns_roce_cq.c
index 713df1f..699c987 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cq.c
@@ -116,9 +116,9 @@ static int hns_roce_cq_alloc(struct hns_roce_dev *hr_dev, int nent,
 	hr_cq->vector = vector;
 
 	ret = hns_roce_bitmap_alloc(&cq_table->bitmap, &hr_cq->cqn);
-	if (ret == -1) {
+	if (ret) {
 		dev_err(dev, "CQ alloc.Failed to alloc index.\n");
-		return -ENOMEM;
+		return ret;
 	}
 
 	/* Get CQC memory HEM(Hardware Entry Memory) table */
diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index 577946b..6589e28 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -83,7 +83,7 @@ static int hns_roce_buddy_alloc(struct hns_roce_buddy *buddy, int order,
 		}
 	}
 	spin_unlock(&buddy->lock);
-	return -1;
+	return -EINVAL;
 
  found:
 	clear_bit(*seg, buddy->bits[o]);
@@ -206,13 +206,14 @@ static int hns_roce_alloc_mtt_range(struct hns_roce_dev *hr_dev, int order,
 	}
 
 	ret = hns_roce_buddy_alloc(buddy, order, seg);
-	if (ret == -1)
-		return -1;
+	if (ret)
+		return ret;
 
-	if (hns_roce_table_get_range(hr_dev, table, *seg,
-				     *seg + (1 << order) - 1)) {
+	ret = hns_roce_table_get_range(hr_dev, table, *seg,
+				       *seg + (1 << order) - 1);
+	if (ret) {
 		hns_roce_buddy_free(buddy, *seg, order);
-		return -1;
+		return ret;
 	}
 
 	return 0;
@@ -578,7 +579,7 @@ static int hns_roce_mr_alloc(struct hns_roce_dev *hr_dev, u32 pd, u64 iova,
 
 	/* Allocate a key for mr from mr_table */
 	ret = hns_roce_bitmap_alloc(&hr_dev->mr_table.mtpt_bitmap, &index);
-	if (ret == -1)
+	if (ret)
 		return -ENOMEM;
 
 	mr->iova = iova;			/* MR va starting addr */
diff --git a/drivers/infiniband/hw/hns/hns_roce_pd.c b/drivers/infiniband/hw/hns/hns_roce_pd.c
index 912b89b4..780c780 100644
--- a/drivers/infiniband/hw/hns/hns_roce_pd.c
+++ b/drivers/infiniband/hw/hns/hns_roce_pd.c
@@ -96,7 +96,7 @@ int hns_roce_uar_alloc(struct hns_roce_dev *hr_dev, struct hns_roce_uar *uar)
 
 	/* Using bitmap to manager UAR index */
 	ret = hns_roce_bitmap_alloc(&hr_dev->uar_table.bitmap, &uar->logic_idx);
-	if (ret == -1)
+	if (ret)
 		return -ENOMEM;
 
 	if (uar->logic_idx > 0 && hr_dev->caps.phy_num_uars > 1)
diff --git a/drivers/infiniband/hw/hns/hns_roce_srq.c b/drivers/infiniband/hw/hns/hns_roce_srq.c
index d275818..96ff782 100644
--- a/drivers/infiniband/hw/hns/hns_roce_srq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_srq.c
@@ -111,7 +111,7 @@ static int hns_roce_srq_alloc(struct hns_roce_dev *hr_dev, u32 pdn, u32 cqn,
 	}
 
 	ret = hns_roce_bitmap_alloc(&srq_table->bitmap, &srq->srqn);
-	if (ret == -1) {
+	if (ret) {
 		dev_err(hr_dev->dev, "SRQ alloc.Failed to alloc index.\n");
 		return -ENOMEM;
 	}
-- 
2.8.1

