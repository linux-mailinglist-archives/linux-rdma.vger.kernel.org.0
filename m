Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09B7559852
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Jun 2022 13:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbiFXLKY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Jun 2022 07:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbiFXLKX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 Jun 2022 07:10:23 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5482D562CF
        for <linux-rdma@vger.kernel.org>; Fri, 24 Jun 2022 04:10:22 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LTvVf4jYYzdZLQ;
        Fri, 24 Jun 2022 19:08:10 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 24 Jun 2022 19:10:20 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 24 Jun 2022 19:10:20 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>
Subject: [PATCH for-next 2/5] RDMA/hns: Fix the wrong type of return value of the interrupt handler
Date:   Fri, 24 Jun 2022 19:08:42 +0800
Message-ID: <20220624110845.48184-3-liangwenpeng@huawei.com>
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

The type of return value of the interrupt handler should be irqreturn_t.

Signed-off-by: Haoyue Xu <xuhaoyue1@hisilicon.com>
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 27 +++++++++++-----------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 617713084383..bb6073635c53 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -5855,12 +5855,12 @@ static struct hns_roce_aeqe *next_aeqe_sw_v2(struct hns_roce_eq *eq)
 		!!(eq->cons_index & eq->entries)) ? aeqe : NULL;
 }
 
-static int hns_roce_v2_aeq_int(struct hns_roce_dev *hr_dev,
-			       struct hns_roce_eq *eq)
+static irqreturn_t hns_roce_v2_aeq_int(struct hns_roce_dev *hr_dev,
+				       struct hns_roce_eq *eq)
 {
 	struct device *dev = hr_dev->dev;
 	struct hns_roce_aeqe *aeqe = next_aeqe_sw_v2(eq);
-	int aeqe_found = 0;
+	irqreturn_t aeqe_found = IRQ_NONE;
 	int event_type;
 	u32 queue_num;
 	int sub_type;
@@ -5914,7 +5914,7 @@ static int hns_roce_v2_aeq_int(struct hns_roce_dev *hr_dev,
 		eq->event_type = event_type;
 		eq->sub_type = sub_type;
 		++eq->cons_index;
-		aeqe_found = 1;
+		aeqe_found = IRQ_HANDLED;
 
 		hns_roce_v2_init_irq_work(hr_dev, eq, queue_num);
 
@@ -5922,7 +5922,8 @@ static int hns_roce_v2_aeq_int(struct hns_roce_dev *hr_dev,
 	}
 
 	update_eq_db(eq);
-	return aeqe_found;
+
+	return IRQ_RETVAL(aeqe_found);
 }
 
 static struct hns_roce_ceqe *next_ceqe_sw_v2(struct hns_roce_eq *eq)
@@ -5937,11 +5938,11 @@ static struct hns_roce_ceqe *next_ceqe_sw_v2(struct hns_roce_eq *eq)
 		!!(eq->cons_index & eq->entries)) ? ceqe : NULL;
 }
 
-static int hns_roce_v2_ceq_int(struct hns_roce_dev *hr_dev,
-			       struct hns_roce_eq *eq)
+static irqreturn_t hns_roce_v2_ceq_int(struct hns_roce_dev *hr_dev,
+				       struct hns_roce_eq *eq)
 {
 	struct hns_roce_ceqe *ceqe = next_ceqe_sw_v2(eq);
-	int ceqe_found = 0;
+	irqreturn_t ceqe_found = IRQ_NONE;
 	u32 cqn;
 
 	while (ceqe) {
@@ -5955,21 +5956,21 @@ static int hns_roce_v2_ceq_int(struct hns_roce_dev *hr_dev,
 		hns_roce_cq_completion(hr_dev, cqn);
 
 		++eq->cons_index;
-		ceqe_found = 1;
+		ceqe_found = IRQ_HANDLED;
 
 		ceqe = next_ceqe_sw_v2(eq);
 	}
 
 	update_eq_db(eq);
 
-	return ceqe_found;
+	return IRQ_RETVAL(ceqe_found);
 }
 
 static irqreturn_t hns_roce_v2_msix_interrupt_eq(int irq, void *eq_ptr)
 {
 	struct hns_roce_eq *eq = eq_ptr;
 	struct hns_roce_dev *hr_dev = eq->hr_dev;
-	int int_work;
+	irqreturn_t int_work;
 
 	if (eq->type_flag == HNS_ROCE_CEQ)
 		/* Completion event interrupt */
@@ -5985,7 +5986,7 @@ static irqreturn_t hns_roce_v2_msix_interrupt_abn(int irq, void *dev_id)
 {
 	struct hns_roce_dev *hr_dev = dev_id;
 	struct device *dev = hr_dev->dev;
-	int int_work = 0;
+	irqreturn_t int_work = IRQ_NONE;
 	u32 int_st;
 	u32 int_en;
 
@@ -6013,7 +6014,7 @@ static irqreturn_t hns_roce_v2_msix_interrupt_abn(int irq, void *dev_id)
 		int_en |= 1 << HNS_ROCE_V2_VF_ABN_INT_EN_S;
 		roce_write(hr_dev, ROCEE_VF_ABN_INT_EN_REG, int_en);
 
-		int_work = 1;
+		int_work = IRQ_HANDLED;
 	} else {
 		dev_err(dev, "There is no abnormal irq found!\n");
 	}
-- 
2.33.0

