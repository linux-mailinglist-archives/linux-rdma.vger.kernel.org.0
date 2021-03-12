Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 990293388D6
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Mar 2021 10:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232892AbhCLJll (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Mar 2021 04:41:41 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:13884 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232956AbhCLJlQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 12 Mar 2021 04:41:16 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Dxgkj2PFfz8x51;
        Fri, 12 Mar 2021 17:39:25 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Fri, 12 Mar 2021 17:41:12 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: [PATCH for-rc] RDMA/hns: Fix bug during CMDQ initialization
Date:   Fri, 12 Mar 2021 17:38:53 +0800
Message-ID: <1615541933-35798-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lang Cheng <chenglang@huawei.com>

When reloading driver, the head/tail pointer of CMDQ may be not at position
0. Then during initialization of CMDQ, if head is reset first, the firmware
will start to handle CMDQ because the head is not equal to the tail. The
driver can reset tail first since the firmware will be triggerred only by
head. This bug is introduced by changing macros of head/tail register
without changing the order of initialization.

Besides, the same name represents opposite meanings in new/old driver, it
is hard to maintain, so rename them to PI/CI.

Fixes: 292b3352bd5b ("RDMA/hns: Adjust fields and variables about CMDQ tail/head")
Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_common.h |  4 ++--
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 12 +++++++-----
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_common.h b/drivers/infiniband/hw/hns/hns_roce_common.h
index 23c438c..8a18aa1 100644
--- a/drivers/infiniband/hw/hns/hns_roce_common.h
+++ b/drivers/infiniband/hw/hns/hns_roce_common.h
@@ -364,8 +364,8 @@
 #define ROCEE_TX_CMQ_BASEADDR_L_REG		0x07000
 #define ROCEE_TX_CMQ_BASEADDR_H_REG		0x07004
 #define ROCEE_TX_CMQ_DEPTH_REG			0x07008
-#define ROCEE_TX_CMQ_HEAD_REG			0x07010
-#define ROCEE_TX_CMQ_TAIL_REG			0x07014
+#define ROCEE_TX_CMQ_PI_REG			0x07010
+#define ROCEE_TX_CMQ_CI_REG			0x07014
 
 #define ROCEE_RX_CMQ_BASEADDR_L_REG		0x07018
 #define ROCEE_RX_CMQ_BASEADDR_H_REG		0x0701c
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index c3934ab..c359f09 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1194,8 +1194,10 @@ static void hns_roce_cmq_init_regs(struct hns_roce_dev *hr_dev, bool ring_type)
 			   upper_32_bits(dma));
 		roce_write(hr_dev, ROCEE_TX_CMQ_DEPTH_REG,
 			   (u32)ring->desc_num >> HNS_ROCE_CMQ_DESC_NUM_S);
-		roce_write(hr_dev, ROCEE_TX_CMQ_HEAD_REG, 0);
-		roce_write(hr_dev, ROCEE_TX_CMQ_TAIL_REG, 0);
+
+		/* Make sure to write CI first and then PI */
+		roce_write(hr_dev, ROCEE_TX_CMQ_CI_REG, 0);
+		roce_write(hr_dev, ROCEE_TX_CMQ_PI_REG, 0);
 	} else {
 		roce_write(hr_dev, ROCEE_RX_CMQ_BASEADDR_L_REG, (u32)dma);
 		roce_write(hr_dev, ROCEE_RX_CMQ_BASEADDR_H_REG,
@@ -1275,7 +1277,7 @@ static void hns_roce_cmq_setup_basic_desc(struct hns_roce_cmq_desc *desc,
 
 static int hns_roce_cmq_csq_done(struct hns_roce_dev *hr_dev)
 {
-	u32 tail = roce_read(hr_dev, ROCEE_TX_CMQ_TAIL_REG);
+	u32 tail = roce_read(hr_dev, ROCEE_TX_CMQ_CI_REG);
 	struct hns_roce_v2_priv *priv = hr_dev->priv;
 
 	return tail == priv->cmq.csq.head;
@@ -1303,7 +1305,7 @@ static int __hns_roce_cmq_send(struct hns_roce_dev *hr_dev,
 	}
 
 	/* Write to hardware */
-	roce_write(hr_dev, ROCEE_TX_CMQ_HEAD_REG, csq->head);
+	roce_write(hr_dev, ROCEE_TX_CMQ_PI_REG, csq->head);
 
 	/* If the command is sync, wait for the firmware to write back,
 	 * if multi descriptors to be sent, use the first one to check
@@ -1334,7 +1336,7 @@ static int __hns_roce_cmq_send(struct hns_roce_dev *hr_dev,
 		}
 	} else {
 		/* FW/HW reset or incorrect number of desc */
-		tail = roce_read(hr_dev, ROCEE_TX_CMQ_TAIL_REG);
+		tail = roce_read(hr_dev, ROCEE_TX_CMQ_CI_REG);
 		dev_warn(hr_dev->dev, "CMDQ move tail from %d to %d\n",
 			 csq->head, tail);
 		csq->head = tail;
-- 
2.8.1

