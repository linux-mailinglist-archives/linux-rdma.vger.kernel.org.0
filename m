Return-Path: <linux-rdma+bounces-7580-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D643A2D5BC
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Feb 2025 12:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E35F416A62E
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Feb 2025 11:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EAF02451DC;
	Sat,  8 Feb 2025 11:06:54 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6E418A6A6
	for <linux-rdma@vger.kernel.org>; Sat,  8 Feb 2025 11:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739012814; cv=none; b=mSY4J3vOnrG9kD9QycWgtpvAC0ajmPoE9bFsC0iVpw9EotZQkVDsYfxrr4H/arRjDrsWTSCgbOEoQneDBBQX7iWfoorh4cUQZbuDnOukSpL/mTgGW1MRKPw2mFXsc5aEPqbMOwHgLrqVZo6JHQZgmuBAg+yJS9wzFeyIGal5t/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739012814; c=relaxed/simple;
	bh=xFK6RBYjexSqIRfL9pMhgNdNXNzRB28nu/yBERcEWAA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZLmjql/BWhbfVHfuzNt6OVFTzvZkA32d5euVh4CJqZFkr37zM7WCu14hcWFcVnmW1SDBaEP+lcwAMcDfXbSlfyPBi9dQRjqVYPNvZvaGmGHFm+eitIHuuUge/dN1hGvNOw8TDZMOZo/ACHmi6WA6KK6OYkqKwh+5hR/nsZ8uqR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Yqp075xCNzpTSH;
	Sat,  8 Feb 2025 19:05:11 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 6E4A61402C4;
	Sat,  8 Feb 2025 19:06:47 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 8 Feb 2025 19:06:46 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<huangjunxian6@hisilicon.com>, <tangchengchang@huawei.com>
Subject: [PATCH v2 for-next] RDMA/hns: Fix mbox timing out by adding retry mechanism
Date: Sat, 8 Feb 2025 18:59:30 +0800
Message-ID: <20250208105930.522796-1-huangjunxian6@hisilicon.com>
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
v1 -> v2:
* Use the constant values directly as Leon commented
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 68 +++++++++++++++++-----
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h |  2 +
 2 files changed, 54 insertions(+), 16 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 5c911d1def03..5fa5aa133446 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1282,10 +1282,8 @@ static u32 hns_roce_cmdq_tx_timeout(u16 opcode, u32 tx_timeout)
 	return tx_timeout;
 }

-static void hns_roce_wait_csq_done(struct hns_roce_dev *hr_dev, u16 opcode)
+static void hns_roce_wait_csq_done(struct hns_roce_dev *hr_dev, u32 tx_timeout)
 {
-	struct hns_roce_v2_priv *priv = hr_dev->priv;
-	u32 tx_timeout = hns_roce_cmdq_tx_timeout(opcode, priv->cmq.tx_timeout);
 	u32 timeout = 0;

 	do {
@@ -1295,8 +1293,9 @@ static void hns_roce_wait_csq_done(struct hns_roce_dev *hr_dev, u16 opcode)
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
@@ -1305,8 +1304,6 @@ static int __hns_roce_cmq_send(struct hns_roce_dev *hr_dev,
 	int ret;
 	int i;

-	spin_lock_bh(&csq->lock);
-
 	tail = csq->head;

 	for (i = 0; i < num; i++) {
@@ -1320,22 +1317,17 @@ static int __hns_roce_cmq_send(struct hns_roce_dev *hr_dev,

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
@@ -1350,14 +1342,58 @@ static int __hns_roce_cmq_send(struct hns_roce_dev *hr_dev,
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
+	u32 tx_timeout = hns_roce_cmdq_tx_timeout(opcode, priv->cmq.tx_timeout);
+	u8 try_cnt = HNS_ROCE_OPC_POST_MB_TRY_CNT;
+	u32 rsv_tail;
+	int ret;
+	int i;
+
+	while (try_cnt) {
+		try_cnt--;
+
+		spin_lock_bh(&csq->lock);
+		rsv_tail = csq->head;
+		ret = __hns_roce_cmq_send_one(hr_dev, desc, num, tx_timeout);
+		if (check_cmq_retry(opcode, ret) && try_cnt) {
+			spin_unlock_bh(&csq->lock);
+			mdelay(HNS_ROCE_OPC_POST_MB_RETRY_GAP_MSEC);
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
index cbdbc9edbce6..91a5665465ff 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -230,6 +230,8 @@ enum hns_roce_opcode_type {
 };

 #define HNS_ROCE_OPC_POST_MB_TIMEOUT 35000
+#define HNS_ROCE_OPC_POST_MB_TRY_CNT 8
+#define HNS_ROCE_OPC_POST_MB_RETRY_GAP_MSEC 5
 struct hns_roce_cmdq_tx_timeout_map {
 	u16 opcode;
 	u32 tx_timeout;
--
2.33.0


