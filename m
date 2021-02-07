Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C92393122ED
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Feb 2021 09:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbhBGI6n (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 7 Feb 2021 03:58:43 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:12442 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhBGI6n (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 7 Feb 2021 03:58:43 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DYNLt3RftzjJfh;
        Sun,  7 Feb 2021 16:56:54 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Sun, 7 Feb 2021 16:57:59 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: [PATCH v2 for-next 5/5] RDMA/hns: Refactor process of posting CMDQ
Date:   Sun, 7 Feb 2021 16:55:43 +0800
Message-ID: <1612688143-28226-6-git-send-email-liweihang@huawei.com>
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

Simplify __hns_roce_cmq_send() then remove the redundant variables.

Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 42 ++++++++++++------------------
 1 file changed, 17 insertions(+), 25 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 0fb9896..791935c 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1208,32 +1208,26 @@ static int __hns_roce_cmq_send(struct hns_roce_dev *hr_dev,
 {
 	struct hns_roce_v2_priv *priv = hr_dev->priv;
 	struct hns_roce_v2_cmq_ring *csq = &priv->cmq.csq;
-	struct hns_roce_cmq_desc *desc_to_use;
 	u32 timeout = 0;
-	int handle = 0;
 	u16 desc_ret;
 	u32 tail;
 	int ret;
+	int i;
 
 	spin_lock_bh(&csq->lock);
 
 	tail = csq->head;
 
-	while (handle < num) {
-		desc_to_use = &csq->desc[csq->head];
-		*desc_to_use = desc[handle];
-		dev_dbg(hr_dev->dev, "set cmq desc:\n");
-		csq->head++;
+	for (i = 0; i < num; i++) {
+		csq->desc[csq->head++] = desc[i];
 		if (csq->head == csq->desc_num)
 			csq->head = 0;
-		handle++;
 	}
 
 	/* Write to hardware */
 	roce_write(hr_dev, ROCEE_TX_CMQ_HEAD_REG, csq->head);
 
-	/*
-	 * If the command is sync, wait for the firmware to write back,
+	/* If the command is sync, wait for the firmware to write back,
 	 * if multi descriptors to be sent, use the first one to check
 	 */
 	if (le16_to_cpu(desc->flag) & HNS_ROCE_CMD_FLAG_NO_INTR) {
@@ -1241,26 +1235,24 @@ static int __hns_roce_cmq_send(struct hns_roce_dev *hr_dev,
 			if (hns_roce_cmq_csq_done(hr_dev))
 				break;
 			udelay(1);
-			timeout++;
-		} while (timeout < priv->cmq.tx_timeout);
+		} while (++timeout < priv->cmq.tx_timeout);
 	}
 
 	if (hns_roce_cmq_csq_done(hr_dev)) {
-		handle = 0;
-		ret = 0;
-		while (handle < num) {
-			/* get the result of hardware write back */
-			desc_to_use = &csq->desc[tail];
-			desc[handle] = *desc_to_use;
-			dev_dbg(hr_dev->dev, "Get cmq desc:\n");
-			desc_ret = le16_to_cpu(desc[handle].retval);
-			if (unlikely(desc_ret != CMD_EXEC_SUCCESS))
-				ret = -EIO;
-
-			tail++;
-			handle++;
+		for (ret = 0, i = 0; i < num; i++) {
+			/* check the result of hardware write back */
+			desc[i] = csq->desc[tail++];
 			if (tail == csq->desc_num)
 				tail = 0;
+
+			desc_ret = le16_to_cpu(desc[i].retval);
+			if (likely(desc_ret == CMD_EXEC_SUCCESS))
+				continue;
+
+			dev_err_ratelimited(hr_dev->dev,
+					    "Cmdq IO error, opcode = %x, return = %x\n",
+					    desc->opcode, desc_ret);
+			ret = -EIO;
 		}
 	} else {
 		/* FW/HW reset or incorrect number of desc */
-- 
2.8.1

