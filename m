Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97A1337F693
	for <lists+linux-rdma@lfdr.de>; Thu, 13 May 2021 13:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233253AbhEMLRk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 May 2021 07:17:40 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:2475 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233287AbhEMLRh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 May 2021 07:17:37 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Fgptx4yxpzBv9t;
        Thu, 13 May 2021 19:13:45 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Thu, 13 May 2021 19:16:20 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Lang Cheng <chenglang@huawei.com>,
        Weihang Li <liweihang@huawei.com>
Subject: [PATCH for-next 1/3] RDMA/hns: Rename CMDQ head/tail pointer to PI/CI
Date:   Thu, 13 May 2021 19:16:16 +0800
Message-ID: <1620904578-29829-2-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1620904578-29829-1-git-send-email-liweihang@huawei.com>
References: <1620904578-29829-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lang Cheng <chenglang@huawei.com>

the same name represents opposite meanings in new/old driver, it
is hard to maintain, so rename them to PI/CI.

Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_common.h |  4 ++--
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_common.h b/drivers/infiniband/hw/hns/hns_roce_common.h
index d5fe56c..3a5658f 100644
--- a/drivers/infiniband/hw/hns/hns_roce_common.h
+++ b/drivers/infiniband/hw/hns/hns_roce_common.h
@@ -373,8 +373,8 @@
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
index 49bb4f5..b58d65f 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1255,8 +1255,8 @@ static void hns_roce_cmq_init_regs(struct hns_roce_dev *hr_dev, bool ring_type)
 			   (u32)ring->desc_num >> HNS_ROCE_CMQ_DESC_NUM_S);
 
 		/* Make sure to write tail first and then head */
-		roce_write(hr_dev, ROCEE_TX_CMQ_TAIL_REG, 0);
-		roce_write(hr_dev, ROCEE_TX_CMQ_HEAD_REG, 0);
+		roce_write(hr_dev, ROCEE_TX_CMQ_CI_REG, 0);
+		roce_write(hr_dev, ROCEE_TX_CMQ_PI_REG, 0);
 	} else {
 		roce_write(hr_dev, ROCEE_RX_CMQ_BASEADDR_L_REG, (u32)dma);
 		roce_write(hr_dev, ROCEE_RX_CMQ_BASEADDR_H_REG,
@@ -1338,7 +1338,7 @@ static void hns_roce_cmq_setup_basic_desc(struct hns_roce_cmq_desc *desc,
 
 static int hns_roce_cmq_csq_done(struct hns_roce_dev *hr_dev)
 {
-	u32 tail = roce_read(hr_dev, ROCEE_TX_CMQ_TAIL_REG);
+	u32 tail = roce_read(hr_dev, ROCEE_TX_CMQ_CI_REG);
 	struct hns_roce_v2_priv *priv = hr_dev->priv;
 
 	return tail == priv->cmq.csq.head;
@@ -1366,7 +1366,7 @@ static int __hns_roce_cmq_send(struct hns_roce_dev *hr_dev,
 	}
 
 	/* Write to hardware */
-	roce_write(hr_dev, ROCEE_TX_CMQ_HEAD_REG, csq->head);
+	roce_write(hr_dev, ROCEE_TX_CMQ_PI_REG, csq->head);
 
 	/* If the command is sync, wait for the firmware to write back,
 	 * if multi descriptors to be sent, use the first one to check
@@ -1397,7 +1397,7 @@ static int __hns_roce_cmq_send(struct hns_roce_dev *hr_dev,
 		}
 	} else {
 		/* FW/HW reset or incorrect number of desc */
-		tail = roce_read(hr_dev, ROCEE_TX_CMQ_TAIL_REG);
+		tail = roce_read(hr_dev, ROCEE_TX_CMQ_CI_REG);
 		dev_warn(hr_dev->dev, "CMDQ move tail from %d to %d\n",
 			 csq->head, tail);
 		csq->head = tail;
-- 
2.7.4

