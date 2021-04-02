Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5212B35283E
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Apr 2021 11:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234640AbhDBJKV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Apr 2021 05:10:21 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14679 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234872AbhDBJKS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 2 Apr 2021 05:10:18 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FBZ2H3SVVznY7p;
        Fri,  2 Apr 2021 17:07:35 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Fri, 2 Apr 2021 17:10:06 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Wenpeng Liang <liangwenpeng@huawei.com>,
        Weihang Li <liweihang@huawei.com>
Subject: [PATCH for-next 4/9] RDMA/hns: Delete redundant abnormal interrupt status
Date:   Fri, 2 Apr 2021 17:07:29 +0800
Message-ID: <1617354454-47840-5-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1617354454-47840-1-git-send-email-liweihang@huawei.com>
References: <1617354454-47840-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Wenpeng Liang <liangwenpeng@huawei.com>

The hardware supports only two types of abnormal interrupts.

Fixes: a5073d6054f7 ("RDMA/hns: Add eq support of hip08")
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 19 +++++--------------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h |  3 +--
 2 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 807c90c..4240aea 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -6031,28 +6031,19 @@ static irqreturn_t hns_roce_v2_msix_interrupt_abn(int irq, void *dev_id)
 		roce_write(hr_dev, ROCEE_VF_ABN_INT_EN_REG, int_en);
 
 		int_work = 1;
-	} else if (int_st & BIT(HNS_ROCE_V2_VF_INT_ST_BUS_ERR_S)) {
-		dev_err(dev, "BUS ERR!\n");
+	} else if (int_st & BIT(HNS_ROCE_V2_VF_INT_ST_RAS_INT_S)) {
+		dev_err(dev, "RAS interrupt!\n");
 
-		int_st |= 1 << HNS_ROCE_V2_VF_INT_ST_BUS_ERR_S;
+		int_st |= 1 << HNS_ROCE_V2_VF_INT_ST_RAS_INT_S;
 		roce_write(hr_dev, ROCEE_VF_ABN_INT_ST_REG, int_st);
 
 		int_en |= 1 << HNS_ROCE_V2_VF_ABN_INT_EN_S;
 		roce_write(hr_dev, ROCEE_VF_ABN_INT_EN_REG, int_en);
 
 		int_work = 1;
-	} else if (int_st & BIT(HNS_ROCE_V2_VF_INT_ST_OTHER_ERR_S)) {
-		dev_err(dev, "OTHER ERR!\n");
-
-		int_st |= 1 << HNS_ROCE_V2_VF_INT_ST_OTHER_ERR_S;
-		roce_write(hr_dev, ROCEE_VF_ABN_INT_ST_REG, int_st);
-
-		int_en |= 1 << HNS_ROCE_V2_VF_ABN_INT_EN_S;
-		roce_write(hr_dev, ROCEE_VF_ABN_INT_EN_REG, int_en);
-
-		int_work = 1;
-	} else
+	} else {
 		dev_err(dev, "There is no abnormal irq found!\n");
+	}
 
 	return IRQ_RETVAL(int_work);
 }
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index 44a3abdd..88b44f7 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -1956,8 +1956,7 @@ struct hns_roce_dip {
 #define HNS_ROCE_V2_ASYNC_EQE_NUM		0x1000
 
 #define HNS_ROCE_V2_VF_INT_ST_AEQ_OVERFLOW_S	0
-#define HNS_ROCE_V2_VF_INT_ST_BUS_ERR_S		1
-#define HNS_ROCE_V2_VF_INT_ST_OTHER_ERR_S	2
+#define HNS_ROCE_V2_VF_INT_ST_RAS_INT_S		1
 
 #define HNS_ROCE_EQ_DB_CMD_AEQ			0x0
 #define HNS_ROCE_EQ_DB_CMD_AEQ_ARMED		0x1
-- 
2.8.1

