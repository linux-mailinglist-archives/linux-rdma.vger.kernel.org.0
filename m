Return-Path: <linux-rdma+bounces-3795-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4947492D321
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jul 2024 15:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEF961F243DF
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jul 2024 13:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5EA4193460;
	Wed, 10 Jul 2024 13:42:30 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C8E18EFDC;
	Wed, 10 Jul 2024 13:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720618950; cv=none; b=QRVT4yLVSRilZtniTXYjAlcMgRi6c/Mg4KfbinphRWyO7654Ww5BwNGwWgc6Ix1VdRDnJRSIYJi/upwvO/BsLhPtEUKYbRNzHvOHA04lT2W16+TyC7hHbTfirW11y5qpM/F7JmbwA0Ac4x0gUuzVvrgveMuLt6h185eKda9q3Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720618950; c=relaxed/simple;
	bh=ogdrkRvit/re/c45w1VUdcStsjjDgF65FlFx3Dta8dY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uLlo5GT6CkrRQTz/ONIvLkcCO5Zq049Rp+aYGMPAGziaqJmwizzQqRpwbL8eHIxQjoN+vxwkR+hKl2oTLa5IFvl4XuNrLOd46zQwdCqF8+EpmWM266Ve486sb+7SMwU02apqvl60v7MehfPB3+ajaJ5xVbzGT4DTilVPfwW5nSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WJzSX2dZfzxVwH;
	Wed, 10 Jul 2024 21:37:48 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id AB2E5180ADC;
	Wed, 10 Jul 2024 21:42:23 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 10 Jul 2024 21:42:23 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH v2 for-rc 2/8] RDMA/hns: Fix soft lockup under heavy CEQE load
Date: Wed, 10 Jul 2024 21:36:59 +0800
Message-ID: <20240710133705.896445-3-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240710133705.896445-1-huangjunxian6@hisilicon.com>
References: <20240710133705.896445-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemf100018.china.huawei.com (7.202.181.17)

CEQEs are handled in interrupt handler currently. This may cause the
CPU core staying in interrupt context too long and lead to soft lockup
under heavy load.

Handle CEQEs in BH workqueue and set an upper limit for the number of
CEQE handled by a single call of work handler.

Fixes: a5073d6054f7 ("RDMA/hns: Add eq support of hip08")
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h |  1 +
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 89 ++++++++++++---------
 2 files changed, 54 insertions(+), 36 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 05005079258c..f8451e5ab107 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -717,6 +717,7 @@ struct hns_roce_eq {
 	int				shift;
 	int				event_type;
 	int				sub_type;
+	struct work_struct		work;
 };
 
 struct hns_roce_eq_table {
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index eb6052ee8938..2f16554c96be 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -36,6 +36,7 @@
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
+#include <linux/workqueue.h>
 #include <net/addrconf.h>
 #include <rdma/ib_addr.h>
 #include <rdma/ib_cache.h>
@@ -6140,33 +6141,11 @@ static struct hns_roce_ceqe *next_ceqe_sw_v2(struct hns_roce_eq *eq)
 		!!(eq->cons_index & eq->entries)) ? ceqe : NULL;
 }
 
-static irqreturn_t hns_roce_v2_ceq_int(struct hns_roce_dev *hr_dev,
-				       struct hns_roce_eq *eq)
+static irqreturn_t hns_roce_v2_ceq_int(struct hns_roce_eq *eq)
 {
-	struct hns_roce_ceqe *ceqe = next_ceqe_sw_v2(eq);
-	irqreturn_t ceqe_found = IRQ_NONE;
-	u32 cqn;
-
-	while (ceqe) {
-		/* Make sure we read CEQ entry after we have checked the
-		 * ownership bit
-		 */
-		dma_rmb();
-
-		cqn = hr_reg_read(ceqe, CEQE_CQN);
-
-		hns_roce_cq_completion(hr_dev, cqn);
-
-		++eq->cons_index;
-		ceqe_found = IRQ_HANDLED;
-		atomic64_inc(&hr_dev->dfx_cnt[HNS_ROCE_DFX_CEQE_CNT]);
-
-		ceqe = next_ceqe_sw_v2(eq);
-	}
+	queue_work(system_bh_wq, &eq->work);
 
-	update_eq_db(eq);
-
-	return IRQ_RETVAL(ceqe_found);
+	return IRQ_HANDLED;
 }
 
 static irqreturn_t hns_roce_v2_msix_interrupt_eq(int irq, void *eq_ptr)
@@ -6177,7 +6156,7 @@ static irqreturn_t hns_roce_v2_msix_interrupt_eq(int irq, void *eq_ptr)
 
 	if (eq->type_flag == HNS_ROCE_CEQ)
 		/* Completion event interrupt */
-		int_work = hns_roce_v2_ceq_int(hr_dev, eq);
+		int_work = hns_roce_v2_ceq_int(eq);
 	else
 		/* Asynchronous event interrupt */
 		int_work = hns_roce_v2_aeq_int(hr_dev, eq);
@@ -6545,6 +6524,34 @@ static int hns_roce_v2_create_eq(struct hns_roce_dev *hr_dev,
 	return ret;
 }
 
+static void hns_roce_ceq_work(struct work_struct *work)
+{
+	struct hns_roce_eq *eq = from_work(eq, work, work);
+	struct hns_roce_ceqe *ceqe = next_ceqe_sw_v2(eq);
+	struct hns_roce_dev *hr_dev = eq->hr_dev;
+	int ceqe_num = 0;
+	u32 cqn;
+
+	while (ceqe && ceqe_num < hr_dev->caps.ceqe_depth) {
+		/* Make sure we read CEQ entry after we have checked the
+		 * ownership bit
+		 */
+		dma_rmb();
+
+		cqn = hr_reg_read(ceqe, CEQE_CQN);
+
+		hns_roce_cq_completion(hr_dev, cqn);
+
+		++eq->cons_index;
+		++ceqe_num;
+		atomic64_inc(&hr_dev->dfx_cnt[HNS_ROCE_DFX_CEQE_CNT]);
+
+		ceqe = next_ceqe_sw_v2(eq);
+	}
+
+	update_eq_db(eq);
+}
+
 static int __hns_roce_request_irq(struct hns_roce_dev *hr_dev, int irq_num,
 				  int comp_num, int aeq_num, int other_num)
 {
@@ -6576,21 +6583,24 @@ static int __hns_roce_request_irq(struct hns_roce_dev *hr_dev, int irq_num,
 			 j - other_num - aeq_num);
 
 	for (j = 0; j < irq_num; j++) {
-		if (j < other_num)
+		if (j < other_num) {
 			ret = request_irq(hr_dev->irq[j],
 					  hns_roce_v2_msix_interrupt_abn,
 					  0, hr_dev->irq_names[j], hr_dev);
-
-		else if (j < (other_num + comp_num))
+		} else if (j < (other_num + comp_num)) {
+			INIT_WORK(&eq_table->eq[j - other_num].work,
+				  hns_roce_ceq_work);
 			ret = request_irq(eq_table->eq[j - other_num].irq,
 					  hns_roce_v2_msix_interrupt_eq,
 					  0, hr_dev->irq_names[j + aeq_num],
 					  &eq_table->eq[j - other_num]);
-		else
+		} else {
 			ret = request_irq(eq_table->eq[j - other_num].irq,
 					  hns_roce_v2_msix_interrupt_eq,
 					  0, hr_dev->irq_names[j - comp_num],
 					  &eq_table->eq[j - other_num]);
+		}
+
 		if (ret) {
 			dev_err(hr_dev->dev, "request irq error!\n");
 			goto err_request_failed;
@@ -6600,12 +6610,16 @@ static int __hns_roce_request_irq(struct hns_roce_dev *hr_dev, int irq_num,
 	return 0;
 
 err_request_failed:
-	for (j -= 1; j >= 0; j--)
-		if (j < other_num)
+	for (j -= 1; j >= 0; j--) {
+		if (j < other_num) {
 			free_irq(hr_dev->irq[j], hr_dev);
-		else
-			free_irq(eq_table->eq[j - other_num].irq,
-				 &eq_table->eq[j - other_num]);
+			continue;
+		}
+		free_irq(eq_table->eq[j - other_num].irq,
+			 &eq_table->eq[j - other_num]);
+		if (j < other_num + comp_num)
+			cancel_work_sync(&eq_table->eq[j - other_num].work);
+	}
 
 err_kzalloc_failed:
 	for (i -= 1; i >= 0; i--)
@@ -6626,8 +6640,11 @@ static void __hns_roce_free_irq(struct hns_roce_dev *hr_dev)
 	for (i = 0; i < hr_dev->caps.num_other_vectors; i++)
 		free_irq(hr_dev->irq[i], hr_dev);
 
-	for (i = 0; i < eq_num; i++)
+	for (i = 0; i < eq_num; i++) {
 		free_irq(hr_dev->eq_table.eq[i].irq, &hr_dev->eq_table.eq[i]);
+		if (i < hr_dev->caps.num_comp_vectors)
+			cancel_work_sync(&hr_dev->eq_table.eq[i].work);
+	}
 
 	for (i = 0; i < irq_num; i++)
 		kfree(hr_dev->irq_names[i]);
-- 
2.33.0


