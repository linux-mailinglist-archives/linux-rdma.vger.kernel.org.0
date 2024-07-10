Return-Path: <linux-rdma+bounces-3796-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB0A92D327
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jul 2024 15:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5A0B1F2440B
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jul 2024 13:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476E1193476;
	Wed, 10 Jul 2024 13:42:31 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C44187844;
	Wed, 10 Jul 2024 13:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720618951; cv=none; b=h38ancrag7/TDj4v3H4k/m5GvXEBupluVrJ/xasFp6nS/RmgYwHxXW84b+VWlx6k9F3wp4ysRrL6YhIs7Xn8G9R5UWJqlLNlDkKtoQsFUhZM+9Mo8HsVDWj4yFzrMMbSdLlvM7+SSw6KNyJKt+97FAjKU5AoKO5wTTaT45QvmRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720618951; c=relaxed/simple;
	bh=f0IdYP8Ghq/+BSWKh69LdDWg9TexC/0W8jKIIZOVhLM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d2bCpPRXxqUcZ//Qse2Eiv09X4ifCiNg9mdR1EhqZ8J5KOOd7lUsIZqux6ncJomyCDc/wK53csuPVCIrWssLZhsok0X+bEPqiLQJxd0rq+0wuka9ipSoPrRPFL2HkntmD1CiwZjMyxokTfCpvxw3thsqApbYdqdmOIyAfcW8QpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WJzSP1FhCzwWmQ;
	Wed, 10 Jul 2024 21:37:41 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 0ADAF180088;
	Wed, 10 Jul 2024 21:42:24 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 10 Jul 2024 21:42:23 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH v2 for-rc 3/8] RDMA/hns: Fix unmatch exception handling when init eq table fails
Date: Wed, 10 Jul 2024 21:37:00 +0800
Message-ID: <20240710133705.896445-4-huangjunxian6@hisilicon.com>
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

The hw ctx should be destroyed when init eq table fails.

Fixes: a5073d6054f7 ("RDMA/hns: Add eq support of hip08")
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 25 +++++++++++-----------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 2f16554c96be..cbbc142afc1b 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -6368,9 +6368,16 @@ static void hns_roce_v2_int_mask_enable(struct hns_roce_dev *hr_dev,
 	roce_write(hr_dev, ROCEE_VF_ABN_INT_CFG_REG, enable_flag);
 }
 
-static void hns_roce_v2_destroy_eqc(struct hns_roce_dev *hr_dev, u32 eqn)
+static void free_eq_buf(struct hns_roce_dev *hr_dev, struct hns_roce_eq *eq)
+{
+	hns_roce_mtr_destroy(hr_dev, &eq->mtr);
+}
+
+static void hns_roce_v2_destroy_eqc(struct hns_roce_dev *hr_dev,
+				    struct hns_roce_eq *eq)
 {
 	struct device *dev = hr_dev->dev;
+	int eqn = eq->eqn;
 	int ret;
 	u8 cmd;
 
@@ -6381,12 +6388,9 @@ static void hns_roce_v2_destroy_eqc(struct hns_roce_dev *hr_dev, u32 eqn)
 
 	ret = hns_roce_destroy_hw_ctx(hr_dev, cmd, eqn & HNS_ROCE_V2_EQN_M);
 	if (ret)
-		dev_err(dev, "[mailbox cmd] destroy eqc(%u) failed.\n", eqn);
-}
+		dev_err(dev, "[mailbox cmd] destroy eqc(%d) failed.\n", eqn);
 
-static void free_eq_buf(struct hns_roce_dev *hr_dev, struct hns_roce_eq *eq)
-{
-	hns_roce_mtr_destroy(hr_dev, &eq->mtr);
+	free_eq_buf(hr_dev, eq);
 }
 
 static void init_eq_config(struct hns_roce_dev *hr_dev, struct hns_roce_eq *eq)
@@ -6733,7 +6737,7 @@ static int hns_roce_v2_init_eq_table(struct hns_roce_dev *hr_dev)
 
 err_create_eq_fail:
 	for (i -= 1; i >= 0; i--)
-		free_eq_buf(hr_dev, &eq_table->eq[i]);
+		hns_roce_v2_destroy_eqc(hr_dev, &eq_table->eq[i]);
 	kfree(eq_table->eq);
 
 	return ret;
@@ -6753,11 +6757,8 @@ static void hns_roce_v2_cleanup_eq_table(struct hns_roce_dev *hr_dev)
 	__hns_roce_free_irq(hr_dev);
 	destroy_workqueue(hr_dev->irq_workq);
 
-	for (i = 0; i < eq_num; i++) {
-		hns_roce_v2_destroy_eqc(hr_dev, i);
-
-		free_eq_buf(hr_dev, &eq_table->eq[i]);
-	}
+	for (i = 0; i < eq_num; i++)
+		hns_roce_v2_destroy_eqc(hr_dev, &eq_table->eq[i]);
 
 	kfree(eq_table->eq);
 }
-- 
2.33.0


