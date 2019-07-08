Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4D2E61FBA
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2019 15:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729815AbfGHNo6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 8 Jul 2019 09:44:58 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2185 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731414AbfGHNo5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 8 Jul 2019 09:44:57 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7DA06E68EDEF8D113FDB;
        Mon,  8 Jul 2019 21:44:49 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Mon, 8 Jul 2019 21:44:40 +0800
From:   Lijun Ou <oulijun@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 9/9] RDMA/hns: Refactor eq table init for hip08
Date:   Mon, 8 Jul 2019 21:41:25 +0800
Message-ID: <1562593285-8037-10-git-send-email-oulijun@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1562593285-8037-1-git-send-email-oulijun@huawei.com>
References: <1562593285-8037-1-git-send-email-oulijun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yixian Liu <liuyixian@huawei.com>

To make the code more readable, here moves the part of
naming irq and request irq out of eq table init into an
seperate function.

Signed-off-by: Yixian Liu <liuyixian@huawei.com>
Signed-off-by: Lijun Ou <oulijun@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 176 ++++++++++++++++++-----------
 1 file changed, 107 insertions(+), 69 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index c2ddfc1..83c58be 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -5735,6 +5735,94 @@ static int hns_roce_v2_create_eq(struct hns_roce_dev *hr_dev,
 	return ret;
 }
 
+static int __hns_roce_request_irq(struct hns_roce_dev *hr_dev, int irq_num,
+				  int comp_num, int aeq_num, int other_num)
+{
+	struct hns_roce_eq_table *eq_table = &hr_dev->eq_table;
+	int i, j;
+	int ret;
+
+	for (i = 0; i < irq_num; i++) {
+		hr_dev->irq_names[i] = kzalloc(HNS_ROCE_INT_NAME_LEN,
+					       GFP_KERNEL);
+		if (!hr_dev->irq_names[i]) {
+			ret = -ENOMEM;
+			goto err_kzalloc_failed;
+		}
+	}
+
+	/* irq contains: abnormal + AEQ + CEQ*/
+	for (j = 0; j < irq_num; j++)
+		if (j < other_num)
+			snprintf((char *)hr_dev->irq_names[j],
+				 HNS_ROCE_INT_NAME_LEN, "hns-abn-%d", j);
+		else if (j < (other_num + aeq_num))
+			snprintf((char *)hr_dev->irq_names[j],
+				 HNS_ROCE_INT_NAME_LEN, "hns-aeq-%d",
+				 j - other_num);
+		else
+			snprintf((char *)hr_dev->irq_names[j],
+				 HNS_ROCE_INT_NAME_LEN, "hns-ceq-%d",
+				 j - other_num - aeq_num);
+
+	for (j = 0; j < irq_num; j++) {
+		if (j < other_num)
+			ret = request_irq(hr_dev->irq[j],
+					  hns_roce_v2_msix_interrupt_abn,
+					  0, hr_dev->irq_names[j], hr_dev);
+
+		else if (j < (other_num + comp_num))
+			ret = request_irq(eq_table->eq[j - other_num].irq,
+					  hns_roce_v2_msix_interrupt_eq,
+					  0, hr_dev->irq_names[j + aeq_num],
+					  &eq_table->eq[j - other_num]);
+		else
+			ret = request_irq(eq_table->eq[j - other_num].irq,
+					  hns_roce_v2_msix_interrupt_eq,
+					  0, hr_dev->irq_names[j - comp_num],
+					  &eq_table->eq[j - other_num]);
+		if (ret) {
+			dev_err(hr_dev->dev, "Request irq error!\n");
+			goto err_request_failed;
+		}
+	}
+
+	return 0;
+
+err_request_failed:
+	for (j -= 1; j >= 0; j--)
+		if (j < other_num)
+			free_irq(hr_dev->irq[j], hr_dev);
+		else
+			free_irq(eq_table->eq[j - other_num].irq,
+				 &eq_table->eq[j - other_num]);
+
+err_kzalloc_failed:
+	for (i -= 1; i >= 0; i--)
+		kfree(hr_dev->irq_names[i]);
+
+	return ret;
+}
+
+static void __hns_roce_free_irq(struct hns_roce_dev *hr_dev)
+{
+	int irq_num;
+	int eq_num;
+	int i;
+
+	eq_num = hr_dev->caps.num_comp_vectors + hr_dev->caps.num_aeq_vectors;
+	irq_num = eq_num + hr_dev->caps.num_other_vectors;
+
+	for (i = 0; i < hr_dev->caps.num_other_vectors; i++)
+		free_irq(hr_dev->irq[i], hr_dev);
+
+	for (i = 0; i < eq_num; i++)
+		free_irq(hr_dev->eq_table.eq[i].irq, &hr_dev->eq_table.eq[i]);
+
+	for (i = 0; i < irq_num; i++)
+		kfree(hr_dev->irq_names[i]);
+}
+
 static int hns_roce_v2_init_eq_table(struct hns_roce_dev *hr_dev)
 {
 	struct hns_roce_eq_table *eq_table = &hr_dev->eq_table;
@@ -5746,7 +5834,7 @@ static int hns_roce_v2_init_eq_table(struct hns_roce_dev *hr_dev)
 	int other_num;
 	int comp_num;
 	int aeq_num;
-	int i, j, k;
+	int i;
 	int ret;
 
 	other_num = hr_dev->caps.num_other_vectors;
@@ -5760,27 +5848,18 @@ static int hns_roce_v2_init_eq_table(struct hns_roce_dev *hr_dev)
 	if (!eq_table->eq)
 		return -ENOMEM;
 
-	for (i = 0; i < irq_num; i++) {
-		hr_dev->irq_names[i] = kzalloc(HNS_ROCE_INT_NAME_LEN,
-					       GFP_KERNEL);
-		if (!hr_dev->irq_names[i]) {
-			ret = -ENOMEM;
-			goto err_failed_kzalloc;
-		}
-	}
-
 	/* create eq */
-	for (j = 0; j < eq_num; j++) {
-		eq = &eq_table->eq[j];
+	for (i = 0; i < eq_num; i++) {
+		eq = &eq_table->eq[i];
 		eq->hr_dev = hr_dev;
-		eq->eqn = j;
-		if (j < comp_num) {
+		eq->eqn = i;
+		if (i < comp_num) {
 			/* CEQ */
 			eq_cmd = HNS_ROCE_CMD_CREATE_CEQC;
 			eq->type_flag = HNS_ROCE_CEQ;
 			eq->entries = hr_dev->caps.ceqe_depth;
 			eq->eqe_size = HNS_ROCE_CEQ_ENTRY_SIZE;
-			eq->irq = hr_dev->irq[j + other_num + aeq_num];
+			eq->irq = hr_dev->irq[i + other_num + aeq_num];
 			eq->eq_max_cnt = HNS_ROCE_CEQ_DEFAULT_BURST_NUM;
 			eq->eq_period = HNS_ROCE_CEQ_DEFAULT_INTERVAL;
 		} else {
@@ -5789,7 +5868,7 @@ static int hns_roce_v2_init_eq_table(struct hns_roce_dev *hr_dev)
 			eq->type_flag = HNS_ROCE_AEQ;
 			eq->entries = hr_dev->caps.aeqe_depth;
 			eq->eqe_size = HNS_ROCE_AEQ_ENTRY_SIZE;
-			eq->irq = hr_dev->irq[j - comp_num + other_num];
+			eq->irq = hr_dev->irq[i - comp_num + other_num];
 			eq->eq_max_cnt = HNS_ROCE_AEQ_DEFAULT_BURST_NUM;
 			eq->eq_period = HNS_ROCE_AEQ_DEFAULT_INTERVAL;
 		}
@@ -5804,40 +5883,11 @@ static int hns_roce_v2_init_eq_table(struct hns_roce_dev *hr_dev)
 	/* enable irq */
 	hns_roce_v2_int_mask_enable(hr_dev, eq_num, EQ_ENABLE);
 
-	/* irq contains: abnormal + AEQ + CEQ*/
-	for (k = 0; k < irq_num; k++)
-		if (k < other_num)
-			snprintf((char *)hr_dev->irq_names[k],
-				 HNS_ROCE_INT_NAME_LEN, "hns-abn-%d", k);
-		else if (k < (other_num + aeq_num))
-			snprintf((char *)hr_dev->irq_names[k],
-				 HNS_ROCE_INT_NAME_LEN, "hns-aeq-%d",
-				 k - other_num);
-		else
-			snprintf((char *)hr_dev->irq_names[k],
-				 HNS_ROCE_INT_NAME_LEN, "hns-ceq-%d",
-				 k - other_num - aeq_num);
-
-	for (k = 0; k < irq_num; k++) {
-		if (k < other_num)
-			ret = request_irq(hr_dev->irq[k],
-					  hns_roce_v2_msix_interrupt_abn,
-					  0, hr_dev->irq_names[k], hr_dev);
-
-		else if (k < (other_num + comp_num))
-			ret = request_irq(eq_table->eq[k - other_num].irq,
-					  hns_roce_v2_msix_interrupt_eq,
-					  0, hr_dev->irq_names[k + aeq_num],
-					  &eq_table->eq[k - other_num]);
-		else
-			ret = request_irq(eq_table->eq[k - other_num].irq,
-					  hns_roce_v2_msix_interrupt_eq,
-					  0, hr_dev->irq_names[k - comp_num],
-					  &eq_table->eq[k - other_num]);
-		if (ret) {
-			dev_err(dev, "Request irq error!\n");
-			goto err_request_irq_fail;
-		}
+	ret = __hns_roce_request_irq(hr_dev, irq_num, comp_num,
+				     aeq_num, other_num);
+	if (ret) {
+		dev_err(dev, "Request irq failed.\n");
+		goto err_request_irq_fail;
 	}
 
 	hr_dev->irq_workq =
@@ -5845,26 +5895,20 @@ static int hns_roce_v2_init_eq_table(struct hns_roce_dev *hr_dev)
 	if (!hr_dev->irq_workq) {
 		dev_err(dev, "Create irq workqueue failed!\n");
 		ret = -ENOMEM;
-		goto err_request_irq_fail;
+		goto err_create_wq_fail;
 	}
 
 	return 0;
 
+err_create_wq_fail:
+	__hns_roce_free_irq(hr_dev);
+
 err_request_irq_fail:
-	for (k -= 1; k >= 0; k--)
-		if (k < other_num)
-			free_irq(hr_dev->irq[k], hr_dev);
-		else
-			free_irq(eq_table->eq[k - other_num].irq,
-				 &eq_table->eq[k - other_num]);
+	hns_roce_v2_int_mask_enable(hr_dev, eq_num, EQ_DISABLE);
 
 err_create_eq_fail:
-	for (j -= 1; j >= 0; j--)
-		hns_roce_v2_free_eq(hr_dev, &eq_table->eq[j]);
-
-err_failed_kzalloc:
 	for (i -= 1; i >= 0; i--)
-		kfree(hr_dev->irq_names[i]);
+		hns_roce_v2_free_eq(hr_dev, &eq_table->eq[i]);
 	kfree(eq_table->eq);
 
 	return ret;
@@ -5883,20 +5927,14 @@ static void hns_roce_v2_cleanup_eq_table(struct hns_roce_dev *hr_dev)
 	/* Disable irq */
 	hns_roce_v2_int_mask_enable(hr_dev, eq_num, EQ_DISABLE);
 
-	for (i = 0; i < hr_dev->caps.num_other_vectors; i++)
-		free_irq(hr_dev->irq[i], hr_dev);
+	__hns_roce_free_irq(hr_dev);
 
 	for (i = 0; i < eq_num; i++) {
 		hns_roce_v2_destroy_eqc(hr_dev, i);
 
-		free_irq(eq_table->eq[i].irq, &eq_table->eq[i]);
-
 		hns_roce_v2_free_eq(hr_dev, &eq_table->eq[i]);
 	}
 
-	for (i = 0; i < irq_num; i++)
-		kfree(hr_dev->irq_names[i]);
-
 	kfree(eq_table->eq);
 
 	flush_workqueue(hr_dev->irq_workq);
-- 
1.9.1

