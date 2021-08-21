Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 417593F3A0E
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Aug 2021 11:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233654AbhHUJ55 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 21 Aug 2021 05:57:57 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:8760 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbhHUJ54 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 21 Aug 2021 05:57:56 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GsDRz4JK5zYrG5;
        Sat, 21 Aug 2021 17:56:47 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 21 Aug 2021 17:57:15 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 21 Aug 2021 17:57:15 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>
Subject: [PATCH for-next 1/3] RDMA/hns: Remove unsupport cmdq mode
Date:   Sat, 21 Aug 2021 17:53:25 +0800
Message-ID: <1629539607-33217-2-git-send-email-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1629539607-33217-1-git-send-email-liangwenpeng@huawei.com>
References: <1629539607-33217-1-git-send-email-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lang Cheng <chenglang@huawei.com>

CMDQ support un-interrupt mode only, and firmware ignores this mode flag,
so remove it.

Fixes: a04ff739f2a9 ("RDMA/hns: Add command queue support for hip08 RoCE driver")
Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 21 +++++++--------------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h | 20 +++++++-------------
 2 files changed, 14 insertions(+), 27 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 4677c48..514473f 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1255,8 +1255,7 @@ static void hns_roce_cmq_setup_basic_desc(struct hns_roce_cmq_desc *desc,
 {
 	memset((void *)desc, 0, sizeof(struct hns_roce_cmq_desc));
 	desc->opcode = cpu_to_le16(opcode);
-	desc->flag =
-		cpu_to_le16(HNS_ROCE_CMD_FLAG_NO_INTR | HNS_ROCE_CMD_FLAG_IN);
+	desc->flag = cpu_to_le16(HNS_ROCE_CMD_FLAG_IN);
 	if (is_read)
 		desc->flag |= cpu_to_le16(HNS_ROCE_CMD_FLAG_WR);
 	else
@@ -1295,16 +1294,11 @@ static int __hns_roce_cmq_send(struct hns_roce_dev *hr_dev,
 	/* Write to hardware */
 	roce_write(hr_dev, ROCEE_TX_CMQ_PI_REG, csq->head);
 
-	/* If the command is sync, wait for the firmware to write back,
-	 * if multi descriptors to be sent, use the first one to check
-	 */
-	if (le16_to_cpu(desc->flag) & HNS_ROCE_CMD_FLAG_NO_INTR) {
-		do {
-			if (hns_roce_cmq_csq_done(hr_dev))
-				break;
-			udelay(1);
-		} while (++timeout < priv->cmq.tx_timeout);
-	}
+	do {
+		if (hns_roce_cmq_csq_done(hr_dev))
+			break;
+		udelay(1);
+	} while (++timeout < priv->cmq.tx_timeout);
 
 	if (hns_roce_cmq_csq_done(hr_dev)) {
 		for (ret = 0, i = 0; i < num; i++) {
@@ -1768,8 +1762,7 @@ static int __hns_roce_set_vf_switch_param(struct hns_roce_dev *hr_dev,
 	if (ret)
 		return ret;
 
-	desc.flag =
-		cpu_to_le16(HNS_ROCE_CMD_FLAG_NO_INTR | HNS_ROCE_CMD_FLAG_IN);
+	desc.flag = cpu_to_le16(HNS_ROCE_CMD_FLAG_IN);
 	desc.flag &= cpu_to_le16(~HNS_ROCE_CMD_FLAG_WR);
 	roce_set_bit(swt->cfg, VF_SWITCH_DATA_CFG_ALW_LPBK_S, 1);
 	roce_set_bit(swt->cfg, VF_SWITCH_DATA_CFG_ALW_LCL_LPBK_S, 0);
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index 3f758d6..212799d 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -129,19 +129,13 @@
 
 #define HNS_ROCE_V2_TABLE_CHUNK_SIZE		(1 << 18)
 
-#define HNS_ROCE_CMD_FLAG_IN_VALID_SHIFT	0
-#define HNS_ROCE_CMD_FLAG_OUT_VALID_SHIFT	1
-#define HNS_ROCE_CMD_FLAG_NEXT_SHIFT		2
-#define HNS_ROCE_CMD_FLAG_WR_OR_RD_SHIFT	3
-#define HNS_ROCE_CMD_FLAG_NO_INTR_SHIFT		4
-#define HNS_ROCE_CMD_FLAG_ERR_INTR_SHIFT	5
-
-#define HNS_ROCE_CMD_FLAG_IN		BIT(HNS_ROCE_CMD_FLAG_IN_VALID_SHIFT)
-#define HNS_ROCE_CMD_FLAG_OUT		BIT(HNS_ROCE_CMD_FLAG_OUT_VALID_SHIFT)
-#define HNS_ROCE_CMD_FLAG_NEXT		BIT(HNS_ROCE_CMD_FLAG_NEXT_SHIFT)
-#define HNS_ROCE_CMD_FLAG_WR		BIT(HNS_ROCE_CMD_FLAG_WR_OR_RD_SHIFT)
-#define HNS_ROCE_CMD_FLAG_NO_INTR	BIT(HNS_ROCE_CMD_FLAG_NO_INTR_SHIFT)
-#define HNS_ROCE_CMD_FLAG_ERR_INTR	BIT(HNS_ROCE_CMD_FLAG_ERR_INTR_SHIFT)
+enum {
+	HNS_ROCE_CMD_FLAG_IN = BIT(0),
+	HNS_ROCE_CMD_FLAG_OUT = BIT(1),
+	HNS_ROCE_CMD_FLAG_NEXT = BIT(2),
+	HNS_ROCE_CMD_FLAG_WR = BIT(3),
+	HNS_ROCE_CMD_FLAG_ERR_INTR = BIT(5),
+};
 
 #define HNS_ROCE_CMQ_DESC_NUM_S		3
 
-- 
2.8.1

