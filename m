Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C83D13122F0
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Feb 2021 09:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbhBGI6r (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 7 Feb 2021 03:58:47 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11692 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhBGI6o (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 7 Feb 2021 03:58:44 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DYNL94ZK7zlH8r;
        Sun,  7 Feb 2021 16:56:17 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Sun, 7 Feb 2021 16:57:58 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: [PATCH v2 for-next 3/5] RDMA/hns: Remove redundant operations on CMDQ
Date:   Sun, 7 Feb 2021 16:55:41 +0800
Message-ID: <1612688143-28226-4-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1612688143-28226-1-git-send-email-liweihang@huawei.com>
References: <1612688143-28226-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lang Cheng <chenglang@huawei.com>

CMDQ works serially, after each successful transmission, the head and tail
pointers will be equal, so there is no need to check whether the queue is
full. At the same time, since the descriptor of each transmission is new,
there is no need to perform a cleanup operation. Then, the field named
next_to_clean in structure hns_roce_v2_cmq_ring is redundant.

Fixes: a04ff739f2a9 ("RDMA/hns: Add command queue support for hip08 RoCE driver")
Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 54 +++---------------------------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h |  1 -
 2 files changed, 5 insertions(+), 50 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 79cb2d6..1945730 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1059,15 +1059,6 @@ static int hns_roce_v2_rst_process_cmd(struct hns_roce_dev *hr_dev)
 	return 0;
 }
 
-static int hns_roce_cmq_space(struct hns_roce_v2_cmq_ring *ring)
-{
-	int ntu = ring->next_to_use;
-	int ntc = ring->next_to_clean;
-	int used = (ntu - ntc + ring->desc_num) % ring->desc_num;
-
-	return ring->desc_num - used - 1;
-}
-
 static int hns_roce_alloc_cmq_desc(struct hns_roce_dev *hr_dev,
 				   struct hns_roce_v2_cmq_ring *ring)
 {
@@ -1107,7 +1098,6 @@ static int hns_roce_init_cmq_ring(struct hns_roce_dev *hr_dev, bool ring_type)
 					    &priv->cmq.csq : &priv->cmq.crq;
 
 	ring->flag = ring_type;
-	ring->next_to_clean = 0;
 	ring->next_to_use = 0;
 
 	return hns_roce_alloc_cmq_desc(hr_dev, ring);
@@ -1213,30 +1203,6 @@ static int hns_roce_cmq_csq_done(struct hns_roce_dev *hr_dev)
 	return head == priv->cmq.csq.next_to_use;
 }
 
-static int hns_roce_cmq_csq_clean(struct hns_roce_dev *hr_dev)
-{
-	struct hns_roce_v2_priv *priv = hr_dev->priv;
-	struct hns_roce_v2_cmq_ring *csq = &priv->cmq.csq;
-	struct hns_roce_cmq_desc *desc;
-	u16 ntc = csq->next_to_clean;
-	u32 head;
-	int clean = 0;
-
-	desc = &csq->desc[ntc];
-	head = roce_read(hr_dev, ROCEE_TX_CMQ_HEAD_REG);
-	while (head != ntc) {
-		memset(desc, 0, sizeof(*desc));
-		ntc++;
-		if (ntc == csq->desc_num)
-			ntc = 0;
-		desc = &csq->desc[ntc];
-		clean++;
-	}
-	csq->next_to_clean = ntc;
-
-	return clean;
-}
-
 static int __hns_roce_cmq_send(struct hns_roce_dev *hr_dev,
 			       struct hns_roce_cmq_desc *desc, int num)
 {
@@ -1251,15 +1217,6 @@ static int __hns_roce_cmq_send(struct hns_roce_dev *hr_dev,
 
 	spin_lock_bh(&csq->lock);
 
-	if (num > hns_roce_cmq_space(csq)) {
-		spin_unlock_bh(&csq->lock);
-		return -EBUSY;
-	}
-
-	/*
-	 * Record the location of desc in the cmq for this time
-	 * which will be use for hardware to write back
-	 */
 	ntc = csq->next_to_use;
 
 	while (handle < num) {
@@ -1306,15 +1263,14 @@ static int __hns_roce_cmq_send(struct hns_roce_dev *hr_dev,
 				ntc = 0;
 		}
 	} else {
+		/* FW/HW reset or incorrect number of desc */
+		ntc = roce_read(hr_dev, ROCEE_TX_CMQ_HEAD_REG);
+		dev_warn(hr_dev->dev, "CMDQ move head from %d to %d\n",
+			 csq->next_to_use, ntc);
+		csq->next_to_use = ntc;
 		ret = -EAGAIN;
 	}
 
-	/* clean the command send queue */
-	handle = hns_roce_cmq_csq_clean(hr_dev);
-	if (handle != num)
-		dev_warn(hr_dev->dev, "Cleaned %d, need to clean %d\n",
-			 handle, num);
-
 	spin_unlock_bh(&csq->lock);
 
 	return ret;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index 9f97e32..7714fa4 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -1830,7 +1830,6 @@ struct hns_roce_v2_cmq_ring {
 	u16 buf_size;
 	u16 desc_num;
 	int next_to_use;
-	int next_to_clean;
 	u8 flag;
 	spinlock_t lock; /* command queue lock */
 };
-- 
2.8.1

