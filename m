Return-Path: <linux-rdma+bounces-3800-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9EE292D336
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jul 2024 15:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A80A11C22FB2
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jul 2024 13:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B98194A67;
	Wed, 10 Jul 2024 13:42:35 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52EE194145;
	Wed, 10 Jul 2024 13:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720618955; cv=none; b=W32b7nA7NaZX6pNMPmQkrY3/9OAGWKylqqcDBjenDHBe1DbFGERd5exeqwU6khoaZwkYxIFXKN5yv3oJOt5sOep4E/0AQvj4DolVIVJdiLLFFuJdWtm1IEYKQcnNhztE8H/uug4LpaBRBDyeZw4T5erY1zuIqW+kLTYmkj8MBWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720618955; c=relaxed/simple;
	bh=IrET6SJcvqLFD/xHfsUKDv0n4sdBIoR7mhvWUiHWpx0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HIgwMKGKX22CxWfQD4LQAkRQbR35AROBBIf0kTRyohcE/RDxW/OCUiHmW6kKrnc0v5WwabUlD4F1KP3EwFRrVDE92jvg4OR61a2FkyITfrKH90y9sYv8jpJx/nqvRvtrdpdySOe+Guzx2nZXGOOKYWe0VSBX0rnAcJr7iv/2p9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WJzTK5bKbzQlCx;
	Wed, 10 Jul 2024 21:38:29 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id B5A29140257;
	Wed, 10 Jul 2024 21:42:25 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 10 Jul 2024 21:42:25 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH v2 for-rc 8/8] RDMA/hns: Fix mbx timing out before CMD execution is completed
Date: Wed, 10 Jul 2024 21:37:05 +0800
Message-ID: <20240710133705.896445-9-huangjunxian6@hisilicon.com>
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
index aecd137c1e60..621b057fb9da 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1275,12 +1275,38 @@ static int hns_roce_cmd_err_convert_errno(u16 desc_ret)
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
@@ -1301,12 +1327,7 @@ static int __hns_roce_cmq_send(struct hns_roce_dev *hr_dev,
 
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


