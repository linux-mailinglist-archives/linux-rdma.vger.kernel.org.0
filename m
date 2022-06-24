Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48BDF559853
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Jun 2022 13:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiFXLK0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Jun 2022 07:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbiFXLKY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 Jun 2022 07:10:24 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243C25674C
        for <linux-rdma@vger.kernel.org>; Fri, 24 Jun 2022 04:10:23 -0700 (PDT)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LTvXT5VxQzDsNT;
        Fri, 24 Jun 2022 19:09:45 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 24 Jun 2022 19:10:21 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 24 Jun 2022 19:10:20 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>
Subject: [PATCH for-next 4/5] RDMA/hns: Refactor the abnormal interrupt handler function
Date:   Fri, 24 Jun 2022 19:08:44 +0800
Message-ID: <20220624110845.48184-5-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220624110845.48184-1-liangwenpeng@huawei.com>
References: <20220624110845.48184-1-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Haoyue Xu <xuhaoyue1@hisilicon.com>

Use a single function to handle the same kind of abnormal interrupts.

Signed-off-by: Haoyue Xu <xuhaoyue1@hisilicon.com>
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 35 ++++++++++++++--------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 35bf58fcaeb3..782f09a7f8af 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -5982,24 +5982,19 @@ static irqreturn_t hns_roce_v2_msix_interrupt_eq(int irq, void *eq_ptr)
 	return IRQ_RETVAL(int_work);
 }
 
-static irqreturn_t hns_roce_v2_msix_interrupt_abn(int irq, void *dev_id)
+static irqreturn_t abnormal_interrupt_basic(struct hns_roce_dev *hr_dev,
+					    u32 int_st)
 {
-	struct hns_roce_dev *hr_dev = dev_id;
-	struct device *dev = hr_dev->dev;
+	struct pci_dev *pdev = hr_dev->pci_dev;
+	struct hnae3_ae_dev *ae_dev = pci_get_drvdata(pdev);
+	const struct hnae3_ae_ops *ops = ae_dev->ops;
 	irqreturn_t int_work = IRQ_NONE;
-	u32 int_st;
 	u32 int_en;
 
-	/* Abnormal interrupt */
-	int_st = roce_read(hr_dev, ROCEE_VF_ABN_INT_ST_REG);
 	int_en = roce_read(hr_dev, ROCEE_VF_ABN_INT_EN_REG);
 
 	if (int_st & BIT(HNS_ROCE_V2_VF_INT_ST_AEQ_OVERFLOW_S)) {
-		struct pci_dev *pdev = hr_dev->pci_dev;
-		struct hnae3_ae_dev *ae_dev = pci_get_drvdata(pdev);
-		const struct hnae3_ae_ops *ops = ae_dev->ops;
-
-		dev_err(dev, "AEQ overflow!\n");
+		dev_err(hr_dev->dev, "AEQ overflow!\n");
 
 		roce_write(hr_dev, ROCEE_VF_ABN_INT_ST_REG,
 			   1 << HNS_ROCE_V2_VF_INT_ST_AEQ_OVERFLOW_S);
@@ -6016,12 +6011,28 @@ static irqreturn_t hns_roce_v2_msix_interrupt_abn(int irq, void *dev_id)
 
 		int_work = IRQ_HANDLED;
 	} else {
-		dev_err(dev, "There is no abnormal irq found!\n");
+		dev_err(hr_dev->dev, "there is no basic abn irq found.\n");
 	}
 
 	return IRQ_RETVAL(int_work);
 }
 
+static irqreturn_t hns_roce_v2_msix_interrupt_abn(int irq, void *dev_id)
+{
+	struct hns_roce_dev *hr_dev = dev_id;
+	irqreturn_t int_work = IRQ_NONE;
+	u32 int_st;
+
+	int_st = roce_read(hr_dev, ROCEE_VF_ABN_INT_ST_REG);
+
+	if (int_st)
+		int_work = abnormal_interrupt_basic(hr_dev, int_st);
+	else
+		dev_err(hr_dev->dev, "there is no abnormal irq found.\n");
+
+	return IRQ_RETVAL(int_work);
+}
+
 static void hns_roce_v2_int_mask_enable(struct hns_roce_dev *hr_dev,
 					int eq_num, u32 enable_flag)
 {
-- 
2.33.0

