Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A53230EC73
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Feb 2021 07:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbhBDG0E (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Feb 2021 01:26:04 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:12394 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbhBDG0E (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 4 Feb 2021 01:26:04 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DWT5v0vs7z7gXj;
        Thu,  4 Feb 2021 14:24:03 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Thu, 4 Feb 2021 14:25:20 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: [PATCH for-next 5/6] RDMA/hns: Adjust fields and variables about CMDQ tail/head
Date:   Thu, 4 Feb 2021 14:23:05 +0800
Message-ID: <1612419786-39173-6-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1612419786-39173-1-git-send-email-liweihang@huawei.com>
References: <1612419786-39173-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lang Cheng <chenglang@huawei.com>

The register 0x07014 is actually the head pointer of CMDQ, and 0x07010
means tail pointer. Current definitions are confusing, so rename them and
related variables.

The next_to_use of structure hns_roce_v2_cmq_ring has the same semantics as
head, merge them into one member. The next_to_clean of structure
hns_roce_v2_cmq_ring has the same semantics as tail. After deleting
next_to_clean, tail should also be deleted.

Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_common.h |  4 ++--
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 37 +++++++++++++++--------------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  3 ---
 3 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_common.h b/drivers/infiniband/hw/hns/hns_roce_common.h
index 3ca6e88..23c438c 100644
--- a/drivers/infiniband/hw/hns/hns_roce_common.h
+++ b/drivers/infiniband/hw/hns/hns_roce_common.h
@@ -364,8 +364,8 @@
 #define ROCEE_TX_CMQ_BASEADDR_L_REG		0x07000
 #define ROCEE_TX_CMQ_BASEADDR_H_REG		0x07004
 #define ROCEE_TX_CMQ_DEPTH_REG			0x07008
-#define ROCEE_TX_CMQ_TAIL_REG			0x07010
-#define ROCEE_TX_CMQ_HEAD_REG			0x07014
+#define ROCEE_TX_CMQ_HEAD_REG			0x07010
+#define ROCEE_TX_CMQ_TAIL_REG			0x07014
 
 #define ROCEE_RX_CMQ_BASEADDR_L_REG		0x07018
 #define ROCEE_RX_CMQ_BASEADDR_H_REG		0x0701c
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 04ff0ec..23a69cf 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1098,7 +1098,7 @@ static int hns_roce_init_cmq_ring(struct hns_roce_dev *hr_dev, bool ring_type)
 					    &priv->cmq.csq : &priv->cmq.crq;
 
 	ring->flag = ring_type;
-	ring->next_to_use = 0;
+	ring->head = 0;
 
 	return hns_roce_alloc_cmq_desc(hr_dev, ring);
 }
@@ -1196,10 +1196,10 @@ static void hns_roce_cmq_setup_basic_desc(struct hns_roce_cmq_desc *desc,
 
 static int hns_roce_cmq_csq_done(struct hns_roce_dev *hr_dev)
 {
-	u32 head = roce_read(hr_dev, ROCEE_TX_CMQ_HEAD_REG);
+	u32 tail = roce_read(hr_dev, ROCEE_TX_CMQ_TAIL_REG);
 	struct hns_roce_v2_priv *priv = hr_dev->priv;
 
-	return head == priv->cmq.csq.next_to_use;
+	return tail == priv->cmq.csq.head;
 }
 
 static int __hns_roce_cmq_send(struct hns_roce_dev *hr_dev,
@@ -1211,25 +1211,25 @@ static int __hns_roce_cmq_send(struct hns_roce_dev *hr_dev,
 	u32 timeout = 0;
 	int handle = 0;
 	u16 desc_ret;
+	u32 tail;
 	int ret;
-	int ntc;
 
 	spin_lock_bh(&csq->lock);
 
-	ntc = csq->next_to_use;
+	tail = csq->head;
 
 	while (handle < num) {
-		desc_to_use = &csq->desc[csq->next_to_use];
+		desc_to_use = &csq->desc[csq->head];
 		*desc_to_use = desc[handle];
 		dev_dbg(hr_dev->dev, "set cmq desc:\n");
-		csq->next_to_use++;
-		if (csq->next_to_use == csq->desc_num)
-			csq->next_to_use = 0;
+		csq->head++;
+		if (csq->head == csq->desc_num)
+			csq->head = 0;
 		handle++;
 	}
 
 	/* Write to hardware */
-	roce_write(hr_dev, ROCEE_TX_CMQ_TAIL_REG, csq->next_to_use);
+	roce_write(hr_dev, ROCEE_TX_CMQ_HEAD_REG, csq->head);
 
 	do {
 		if (hns_roce_cmq_csq_done(hr_dev))
@@ -1243,24 +1243,25 @@ static int __hns_roce_cmq_send(struct hns_roce_dev *hr_dev,
 		ret = 0;
 		while (handle < num) {
 			/* get the result of hardware write back */
-			desc_to_use = &csq->desc[ntc];
+			desc_to_use = &csq->desc[tail];
 			desc[handle] = *desc_to_use;
 			dev_dbg(hr_dev->dev, "Get cmq desc:\n");
 			desc_ret = le16_to_cpu(desc[handle].retval);
 			if (unlikely(desc_ret != CMD_EXEC_SUCCESS))
 				ret = -EIO;
 
-			ntc++;
+			tail++;
 			handle++;
-			if (ntc == csq->desc_num)
-				ntc = 0;
+			if (tail == csq->desc_num)
+				tail = 0;
 		}
 	} else {
 		/* FW/HW reset or incorrect number of desc */
-		ntc = roce_read(hr_dev, ROCEE_TX_CMQ_HEAD_REG);
-		dev_warn(hr_dev->dev, "CMDQ move head from %d to %d\n",
-			 csq->next_to_use, ntc);
-		csq->next_to_use = ntc;
+		tail = roce_read(hr_dev, ROCEE_TX_CMQ_TAIL_REG);
+		dev_warn(hr_dev->dev, "CMDQ move tail from %d to %d\n",
+			 csq->head, tail);
+		csq->head = tail;
+
 		ret = -EAGAIN;
 	}
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index db77d2c..691b757 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -1823,11 +1823,8 @@ struct hns_roce_v2_cmq_ring {
 	dma_addr_t desc_dma_addr;
 	struct hns_roce_cmq_desc *desc;
 	u32 head;
-	u32 tail;
-
 	u16 buf_size;
 	u16 desc_num;
-	int next_to_use;
 	u8 flag;
 	spinlock_t lock; /* command queue lock */
 };
-- 
2.8.1

