Return-Path: <linux-rdma+bounces-3665-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E449284A3
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jul 2024 11:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3C1C286C85
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jul 2024 09:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644E91487DD;
	Fri,  5 Jul 2024 09:04:59 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE34145B25;
	Fri,  5 Jul 2024 09:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720170299; cv=none; b=l6W2EU7E30aJnVj08R0RtVFBx+DWDCFQZ5yfNVegMfSEU7SiKGduFleeZJ+0bPP28dHRSQXMMhLvUdgzW9EdyAIra/zuO/W7Z5AiAIAU3QhzB5W1DK2CVrzzz4PtwXkFOTON5yWgld88SWs89otzLIhserdmumVcWKJaAiKw2No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720170299; c=relaxed/simple;
	bh=FHvYkXrMq6p9Xw24fP5yXp9lMYf8oj9aUJ4r/FomiE0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hJm/d4M82SCDaykKJyIejTjhKAWwPZSQmkmZ4enEh9PI3OxMQdr8Xj16+xGt3BGBbxrMrOIkCAuYvPBn+tT7MUn9oGG0zla09LAdwbRPlYdFKrSVICNqFFOsTH5U5v4e34OXw78hYwugnZNXCQ2g0eSe8/sSLoi+MP6vv03MwqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WFnY96Cjvz1j6Cl;
	Fri,  5 Jul 2024 17:00:45 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 9704F1A0188;
	Fri,  5 Jul 2024 17:04:53 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 5 Jul 2024 17:04:53 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH for-rc 4/9] RDMA/hns: Fix unmatch exception handling when init eq table fails
Date: Fri, 5 Jul 2024 16:59:32 +0800
Message-ID: <20240705085937.1644229-5-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240705085937.1644229-1-huangjunxian6@hisilicon.com>
References: <20240705085937.1644229-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemf100018.china.huawei.com (7.202.181.17)

The hw ctx should be destroyed when init eq table fails.

Fixes: a5073d6054f7 ("RDMA/hns: Add eq support of hip08")
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 25 +++++++++++-----------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index f73de06a3ca5..6cdeafef800a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -6373,9 +6373,16 @@ static void hns_roce_v2_int_mask_enable(struct hns_roce_dev *hr_dev,
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
 
@@ -6386,12 +6393,9 @@ static void hns_roce_v2_destroy_eqc(struct hns_roce_dev *hr_dev, u32 eqn)
 
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
@@ -6738,7 +6742,7 @@ static int hns_roce_v2_init_eq_table(struct hns_roce_dev *hr_dev)
 
 err_create_eq_fail:
 	for (i -= 1; i >= 0; i--)
-		free_eq_buf(hr_dev, &eq_table->eq[i]);
+		hns_roce_v2_destroy_eqc(hr_dev, &eq_table->eq[i]);
 	kfree(eq_table->eq);
 
 	return ret;
@@ -6758,11 +6762,8 @@ static void hns_roce_v2_cleanup_eq_table(struct hns_roce_dev *hr_dev)
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


