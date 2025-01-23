Return-Path: <linux-rdma+bounces-7189-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1980FA19C41
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Jan 2025 02:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D52243A7CEE
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Jan 2025 01:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA06F9C1;
	Thu, 23 Jan 2025 01:36:49 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1668335953
	for <linux-rdma@vger.kernel.org>; Thu, 23 Jan 2025 01:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737596209; cv=none; b=I3tFECJqeRlHtqh+GNRwuFtZY4hwcC60ZI5XKdn3LbuUgPiqkA4Ndt1g/8Vx3GZguewEnPRNheoTf569fWwIYWv/1bNnO4L4gr2L28gZSoGZIKC9SGGW5JHLYVW4ghdoST4XmdqMR4rUNzNFvuFZpmDNrpjoDidkHHS2M7wu9xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737596209; c=relaxed/simple;
	bh=vpTLzYedo/PxKkAloWmFxXiIgwibCDCYH9zaGIoUn2Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sscnXZqsTpJfjc0vthYilRbBgiR9bwVLLLxRTKrntu7yObqA4a6A+qWuCo1UvTL8rM8z1GqRoh2utQkhgcwEqrB6aRBlWbWqEesGwY/7VbSoXh7W7PdwJpXsLxgvamvKE3MRkQMyHsSaf+JPtQtBx96yRtiNrDADJnuf4OD+HxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Ydk2s2VHDz1W4Vr;
	Thu, 23 Jan 2025 09:32:37 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 058EE180218;
	Thu, 23 Jan 2025 09:36:38 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 23 Jan 2025 09:36:37 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<huangjunxian6@hisilicon.com>, <tangchengchang@huawei.com>
Subject: [PATCH for-next] RDMA/hns: Fix mbox timing out by adding retry mechanism
Date: Thu, 23 Jan 2025 09:29:30 +0800
Message-ID: <20250123012930.2049043-1-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
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

If a QP is modified to error state and a flush CQE process is triggered,
the subsequent QP destruction mbox can still be successfully posted but
will be blocked in HW until the flush CQE process finishes. This causes
further mbox posting timeouts in driver. The blocking time is related
to QP depth. Considering an extreme case where SQ depth and RQ depth
are both 32K, the blocking time can reach about 135ms.

This patch adds a retry mechanism for mbox posting. For each try, FW
waits 15ms for HW to complete the previous mbox, otherwise return a
timeout error code to driver. Counting other time consumption in FW,
set 8 tries for mbox posting and a 5ms time gap before each retry to
increase to a sufficient timeout limit.

Fixes: 0425e3e6e0c7 ("RDMA/hns: Support flush cqe for hip08 in kernel space")
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 93 ++++++++++++++++------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h |  6 +-
 2 files changed, 74 insertions(+), 25 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 5c911d1def03..512866324f59 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1268,24 +1268,27 @@ static int hns_roce_cmd_err_convert_errno(u16 desc_ret)
 	return -EIO;
 }
 
-static u32 hns_roce_cmdq_tx_timeout(u16 opcode, u32 tx_timeout)
+static void hns_roce_get_cmdq_param(u16 opcode, u32 *tx_timeout, u8 *try_cnt,
+				    u8 *retry_gap_msec)
 {
-	static const struct hns_roce_cmdq_tx_timeout_map cmdq_tx_timeout[] = {
-		{HNS_ROCE_OPC_POST_MB, HNS_ROCE_OPC_POST_MB_TIMEOUT},
+	static const struct hns_roce_cmdq_param_map param[] = {
+		{HNS_ROCE_OPC_POST_MB, HNS_ROCE_OPC_POST_MB_TIMEOUT,
+		 HNS_ROCE_OPC_POST_MB_TRY_CNT,
+		 HNS_ROCE_OPC_POST_MB_RETRY_GAP_MSEC},
 	};
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(cmdq_tx_timeout); i++)
-		if (cmdq_tx_timeout[i].opcode == opcode)
-			return cmdq_tx_timeout[i].tx_timeout;
-
-	return tx_timeout;
+	for (i = 0; i < ARRAY_SIZE(param); i++)
+		if (param[i].opcode == opcode) {
+			*tx_timeout = param[i].tx_timeout;
+			*try_cnt = param[i].try_cnt;
+			*retry_gap_msec = param[i].retry_gap_msec;
+			return;
+		}
 }
 
-static void hns_roce_wait_csq_done(struct hns_roce_dev *hr_dev, u16 opcode)
+static void hns_roce_wait_csq_done(struct hns_roce_dev *hr_dev, u32 tx_timeout)
 {
-	struct hns_roce_v2_priv *priv = hr_dev->priv;
-	u32 tx_timeout = hns_roce_cmdq_tx_timeout(opcode, priv->cmq.tx_timeout);
 	u32 timeout = 0;
 
 	do {
@@ -1295,8 +1298,9 @@ static void hns_roce_wait_csq_done(struct hns_roce_dev *hr_dev, u16 opcode)
 	} while (++timeout < tx_timeout);
 }
 
-static int __hns_roce_cmq_send(struct hns_roce_dev *hr_dev,
-			       struct hns_roce_cmq_desc *desc, int num)
+static int __hns_roce_cmq_send_one(struct hns_roce_dev *hr_dev,
+				   struct hns_roce_cmq_desc *desc,
+				   int num, u32 tx_timeout)
 {
 	struct hns_roce_v2_priv *priv = hr_dev->priv;
 	struct hns_roce_v2_cmq_ring *csq = &priv->cmq.csq;
@@ -1305,8 +1309,6 @@ static int __hns_roce_cmq_send(struct hns_roce_dev *hr_dev,
 	int ret;
 	int i;
 
-	spin_lock_bh(&csq->lock);
-
 	tail = csq->head;
 
 	for (i = 0; i < num; i++) {
@@ -1320,22 +1322,17 @@ static int __hns_roce_cmq_send(struct hns_roce_dev *hr_dev,
 
 	atomic64_inc(&hr_dev->dfx_cnt[HNS_ROCE_DFX_CMDS_CNT]);
 
-	hns_roce_wait_csq_done(hr_dev, le16_to_cpu(desc->opcode));
+	hns_roce_wait_csq_done(hr_dev, tx_timeout);
 	if (hns_roce_cmq_csq_done(hr_dev)) {
 		ret = 0;
 		for (i = 0; i < num; i++) {
 			/* check the result of hardware write back */
-			desc[i] = csq->desc[tail++];
+			desc_ret = le16_to_cpu(csq->desc[tail++].retval);
 			if (tail == csq->desc_num)
 				tail = 0;
-
-			desc_ret = le16_to_cpu(desc[i].retval);
 			if (likely(desc_ret == CMD_EXEC_SUCCESS))
 				continue;
 
-			dev_err_ratelimited(hr_dev->dev,
-					    "Cmdq IO error, opcode = 0x%x, return = 0x%x.\n",
-					    desc->opcode, desc_ret);
 			ret = hns_roce_cmd_err_convert_errno(desc_ret);
 		}
 	} else {
@@ -1350,14 +1347,62 @@ static int __hns_roce_cmq_send(struct hns_roce_dev *hr_dev,
 		ret = -EAGAIN;
 	}
 
-	spin_unlock_bh(&csq->lock);
-
 	if (ret)
 		atomic64_inc(&hr_dev->dfx_cnt[HNS_ROCE_DFX_CMDS_ERR_CNT]);
 
 	return ret;
 }
 
+static bool check_cmq_retry(u16 opcode, int ret)
+{
+	return opcode == HNS_ROCE_OPC_POST_MB && ret == -ETIME;
+}
+
+static int __hns_roce_cmq_send(struct hns_roce_dev *hr_dev,
+			       struct hns_roce_cmq_desc *desc, int num)
+{
+	struct hns_roce_v2_priv *priv = hr_dev->priv;
+	struct hns_roce_v2_cmq_ring *csq = &priv->cmq.csq;
+	u16 opcode = le16_to_cpu(desc->opcode);
+	u32 tx_timeout = priv->cmq.tx_timeout;
+	u8 retry_gap_msec = 0;
+	u8 try_cnt = 1;
+	u32 rsv_tail;
+	int ret;
+	int i;
+
+	hns_roce_get_cmdq_param(opcode, &tx_timeout,
+				&try_cnt, &retry_gap_msec);
+
+	while (try_cnt) {
+		try_cnt--;
+
+		spin_lock_bh(&csq->lock);
+		rsv_tail = csq->head;
+		ret = __hns_roce_cmq_send_one(hr_dev, desc, num, tx_timeout);
+		if (check_cmq_retry(opcode, ret) && try_cnt) {
+			spin_unlock_bh(&csq->lock);
+			mdelay(retry_gap_msec);
+			continue;
+		}
+
+		for (i = 0; i < num; i++) {
+			desc[i] = csq->desc[rsv_tail++];
+			if (rsv_tail == csq->desc_num)
+				rsv_tail = 0;
+		}
+		spin_unlock_bh(&csq->lock);
+		break;
+	}
+
+	if (ret)
+		dev_err_ratelimited(hr_dev->dev,
+				    "Cmdq IO error, opcode = 0x%x, return = %d.\n",
+				    opcode, ret);
+
+	return ret;
+}
+
 static int hns_roce_cmq_send(struct hns_roce_dev *hr_dev,
 			     struct hns_roce_cmq_desc *desc, int num)
 {
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index cbdbc9edbce6..2e91babf333c 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -230,9 +230,13 @@ enum hns_roce_opcode_type {
 };
 
 #define HNS_ROCE_OPC_POST_MB_TIMEOUT 35000
-struct hns_roce_cmdq_tx_timeout_map {
+#define HNS_ROCE_OPC_POST_MB_TRY_CNT 8
+#define HNS_ROCE_OPC_POST_MB_RETRY_GAP_MSEC 5
+struct hns_roce_cmdq_param_map {
 	u16 opcode;
 	u32 tx_timeout;
+	u8 try_cnt;
+	u8 retry_gap_msec;
 };
 
 enum {
-- 
2.33.0


