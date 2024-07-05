Return-Path: <linux-rdma+bounces-3670-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 292639284AE
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jul 2024 11:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9816288D44
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jul 2024 09:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE25149C6A;
	Fri,  5 Jul 2024 09:05:29 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE631448D4;
	Fri,  5 Jul 2024 09:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720170329; cv=none; b=KmCeVeJNX+v4DU+sugSxIWSe2aIEVy6DtugkmW8zYFcV7MhKLspCu5yS412JDR9WpGQWjlO5XlaVWPgaExoZQN+vjoUe5Z2nMyg346oeCoAu991f0P+bo8B1Y6oTbkuNmqqEnfCrsQLcqTo/I0VNG3wU6EQ1sszyMunSG3NZRn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720170329; c=relaxed/simple;
	bh=9+4/0u9ROtiwmHKLiKx78XUD0SbB/NAJbbtoxpmLYp8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EhZPtKO7jFvKIrLwFloNPgNlLwK2ZY9lhbsHyDYJteEpUAckgMIIyNpKBu1/Ae7Oy0nv6zml6qeWnvAJvNLMJNwmX+KB1A/vCNC7Kjft9+C+yY3GIfyhQoOEptPst0kXNyiQT24a8BdXO3mbYGiwFl2BVYr9faoSxLQjO4/HDGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4WFnc94cltz1xtKx;
	Fri,  5 Jul 2024 17:03:21 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 289F7180019;
	Fri,  5 Jul 2024 17:04:55 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 5 Jul 2024 17:04:54 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH for-rc 9/9] RDMA/hns: Fix mbx timing out before CMD execution is completed
Date: Fri, 5 Jul 2024 16:59:37 +0800
Message-ID: <20240705085937.1644229-10-huangjunxian6@hisilicon.com>
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

From: Chengchang Tang <tangchengchang@huawei.com>

When a large number of tasks are issued, the speed of HW processing
mbx will slow down. The standard for judging mbx timeout in the current
firmware is 30ms, and the current timeout standard for the driver is also
30ms.

Considering that firmware scheduling in multi-function scenarios takes a
certain amount of time, this will cause the driver to time out too early
and report a failure before mbx execution times out.

This patch introduces a new mechanism that can set different timeouts for
different cmds and extends the timeout of mbx to 35ms.

Fixes: a04ff739f2a9 ("RDMA/hns: Add command queue support for hip08 RoCE driver")
Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 35 +++++++++++++++++-----
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h |  6 ++++
 2 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 1d72c8d47ae7..0ed6ec2232dc 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1280,12 +1280,38 @@ static int hns_roce_cmd_err_convert_errno(u16 desc_ret)
 	return -EIO;
 }
 
+static u32 hns_roce_cmdq_tx_timeout(u16 opcode, u32 tx_timeout)
+{
+	static const struct hns_roce_cmdq_tx_timeout_map cmdq_tx_timeout[] = {
+		{HNS_ROCE_OPC_POST_MB, HNS_ROCE_OPC_POST_MB_TIMEOUT},
+	};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(cmdq_tx_timeout); i++)
+		if (cmdq_tx_timeout[i].opcode == opcode)
+			return cmdq_tx_timeout[i].tx_timeout;
+
+	return tx_timeout;
+}
+
+static void hns_roce_wait_csq_done(struct hns_roce_dev *hr_dev, u16 opcode)
+{
+	struct hns_roce_v2_priv *priv = hr_dev->priv;
+	u32 tx_timeout = hns_roce_cmdq_tx_timeout(opcode, priv->cmq.tx_timeout);
+	u32 timeout = 0;
+
+	do {
+		if (hns_roce_cmq_csq_done(hr_dev))
+			break;
+		udelay(1);
+	} while (++timeout < tx_timeout);
+}
+
 static int __hns_roce_cmq_send(struct hns_roce_dev *hr_dev,
 			       struct hns_roce_cmq_desc *desc, int num)
 {
 	struct hns_roce_v2_priv *priv = hr_dev->priv;
 	struct hns_roce_v2_cmq_ring *csq = &priv->cmq.csq;
-	u32 timeout = 0;
 	u16 desc_ret;
 	u32 tail;
 	int ret;
@@ -1306,12 +1332,7 @@ static int __hns_roce_cmq_send(struct hns_roce_dev *hr_dev,
 
 	atomic64_inc(&hr_dev->dfx_cnt[HNS_ROCE_DFX_CMDS_CNT]);
 
-	do {
-		if (hns_roce_cmq_csq_done(hr_dev))
-			break;
-		udelay(1);
-	} while (++timeout < priv->cmq.tx_timeout);
-
+	hns_roce_wait_csq_done(hr_dev, le16_to_cpu(desc->opcode));
 	if (hns_roce_cmq_csq_done(hr_dev)) {
 		ret = 0;
 		for (i = 0; i < num; i++) {
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index def1d15a03c7..c65f68a14a26 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -224,6 +224,12 @@ enum hns_roce_opcode_type {
 	HNS_SWITCH_PARAMETER_CFG			= 0x1033,
 };
 
+#define HNS_ROCE_OPC_POST_MB_TIMEOUT 35000
+struct hns_roce_cmdq_tx_timeout_map {
+	u16 opcode;
+	u32 tx_timeout;
+};
+
 enum {
 	TYPE_CRQ,
 	TYPE_CSQ,
-- 
2.33.0


