Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9775730EC78
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Feb 2021 07:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbhBDG0J (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Feb 2021 01:26:09 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12121 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbhBDG0F (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 4 Feb 2021 01:26:05 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DWT5t739Jz163q3;
        Thu,  4 Feb 2021 14:24:02 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Thu, 4 Feb 2021 14:25:19 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: [PATCH for-next 2/6] RDMA/hns: Remove unsupported CMDQ mode
Date:   Thu, 4 Feb 2021 14:23:02 +0800
Message-ID: <1612419786-39173-3-git-send-email-liweihang@huawei.com>
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

HIP08/09 only supports CMDQ in non-interrupt mode, and the firmware always
ignores the flag to indicate the mode. Therefore, remove the dead code.

Fixes: a04ff739f2a9 ("RDMA/hns: Add command queue support for hip08 RoCE driver")
Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 24 ++++++++----------------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h |  2 --
 2 files changed, 8 insertions(+), 18 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 7a5a41d..260c17c 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1197,8 +1197,7 @@ static void hns_roce_cmq_setup_basic_desc(struct hns_roce_cmq_desc *desc,
 {
 	memset((void *)desc, 0, sizeof(struct hns_roce_cmq_desc));
 	desc->opcode = cpu_to_le16(opcode);
-	desc->flag =
-		cpu_to_le16(HNS_ROCE_CMD_FLAG_NO_INTR | HNS_ROCE_CMD_FLAG_IN);
+	desc->flag = cpu_to_le16(HNS_ROCE_CMD_FLAG_IN);
 	if (is_read)
 		desc->flag |= cpu_to_le16(HNS_ROCE_CMD_FLAG_WR);
 	else
@@ -1275,18 +1274,12 @@ static int __hns_roce_cmq_send(struct hns_roce_dev *hr_dev,
 	/* Write to hardware */
 	roce_write(hr_dev, ROCEE_TX_CMQ_TAIL_REG, csq->next_to_use);
 
-	/*
-	 * If the command is sync, wait for the firmware to write back,
-	 * if multi descriptors to be sent, use the first one to check
-	 */
-	if (le16_to_cpu(desc->flag) & HNS_ROCE_CMD_FLAG_NO_INTR) {
-		do {
-			if (hns_roce_cmq_csq_done(hr_dev))
-				break;
-			udelay(1);
-			timeout++;
-		} while (timeout < priv->cmq.tx_timeout);
-	}
+	do {
+		if (hns_roce_cmq_csq_done(hr_dev))
+			break;
+		udelay(1);
+		timeout++;
+	} while (timeout < priv->cmq.tx_timeout);
 
 	if (hns_roce_cmq_csq_done(hr_dev)) {
 		handle = 0;
@@ -1626,8 +1619,7 @@ static int hns_roce_set_vf_switch_param(struct hns_roce_dev *hr_dev, int vf_id)
 	if (ret)
 		return ret;
 
-	desc.flag =
-		cpu_to_le16(HNS_ROCE_CMD_FLAG_NO_INTR | HNS_ROCE_CMD_FLAG_IN);
+	desc.flag = cpu_to_le16(HNS_ROCE_CMD_FLAG_IN);
 	desc.flag &= cpu_to_le16(~HNS_ROCE_CMD_FLAG_WR);
 	roce_set_bit(swt->cfg, VF_SWITCH_DATA_CFG_ALW_LPBK_S, 1);
 	roce_set_bit(swt->cfg, VF_SWITCH_DATA_CFG_ALW_LCL_LPBK_S, 0);
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index 9f97e32..986a287 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -128,14 +128,12 @@
 #define HNS_ROCE_CMD_FLAG_OUT_VALID_SHIFT	1
 #define HNS_ROCE_CMD_FLAG_NEXT_SHIFT		2
 #define HNS_ROCE_CMD_FLAG_WR_OR_RD_SHIFT	3
-#define HNS_ROCE_CMD_FLAG_NO_INTR_SHIFT		4
 #define HNS_ROCE_CMD_FLAG_ERR_INTR_SHIFT	5
 
 #define HNS_ROCE_CMD_FLAG_IN		BIT(HNS_ROCE_CMD_FLAG_IN_VALID_SHIFT)
 #define HNS_ROCE_CMD_FLAG_OUT		BIT(HNS_ROCE_CMD_FLAG_OUT_VALID_SHIFT)
 #define HNS_ROCE_CMD_FLAG_NEXT		BIT(HNS_ROCE_CMD_FLAG_NEXT_SHIFT)
 #define HNS_ROCE_CMD_FLAG_WR		BIT(HNS_ROCE_CMD_FLAG_WR_OR_RD_SHIFT)
-#define HNS_ROCE_CMD_FLAG_NO_INTR	BIT(HNS_ROCE_CMD_FLAG_NO_INTR_SHIFT)
 #define HNS_ROCE_CMD_FLAG_ERR_INTR	BIT(HNS_ROCE_CMD_FLAG_ERR_INTR_SHIFT)
 
 #define HNS_ROCE_CMQ_DESC_NUM_S		3
-- 
2.8.1

