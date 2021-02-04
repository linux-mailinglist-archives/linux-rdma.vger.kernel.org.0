Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26DDB30EC75
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Feb 2021 07:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbhBDG0F (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Feb 2021 01:26:05 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:12393 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbhBDG0E (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 4 Feb 2021 01:26:04 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DWT5v1BsPz7gc1;
        Thu,  4 Feb 2021 14:24:03 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Thu, 4 Feb 2021 14:25:20 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: [PATCH for-next 6/6] RDMA/hns: Refactor process of posting CMDQ
Date:   Thu, 4 Feb 2021 14:23:06 +0800
Message-ID: <1612419786-39173-7-git-send-email-liweihang@huawei.com>
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

Simplify __hns_roce_cmq_send() then remove the redundant variables.

Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 39 ++++++++++++------------------
 1 file changed, 16 insertions(+), 23 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 23a69cf..69b210a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1207,25 +1207,20 @@ static int __hns_roce_cmq_send(struct hns_roce_dev *hr_dev,
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
@@ -1235,25 +1230,23 @@ static int __hns_roce_cmq_send(struct hns_roce_dev *hr_dev,
 		if (hns_roce_cmq_csq_done(hr_dev))
 			break;
 		udelay(1);
-		timeout++;
-	} while (timeout < priv->cmq.tx_timeout);
+	} while (++timeout < priv->cmq.tx_timeout);
 
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

