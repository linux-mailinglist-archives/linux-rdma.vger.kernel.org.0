Return-Path: <linux-rdma+bounces-1210-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B5887159B
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Mar 2024 06:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99C431F210EB
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Mar 2024 05:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33CF79957;
	Tue,  5 Mar 2024 05:57:22 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68FA2AE95;
	Tue,  5 Mar 2024 05:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709618242; cv=none; b=V8I1TZQIh9OOFqN4d1ieflNSlaYcqvaIN49TQsJ2F5ePluvGT3qDJ6cHAKdt0oEHM1PiGjS7Xw5oYK1SNTFD8fZPlPkPHeoo+2GKgYrAitB5dnawAE9CXJC0Nfe3Hp78ShK9FhKNorWqOZ5nJm2eBxRjMpbMqiFlQm3ebbQv7MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709618242; c=relaxed/simple;
	bh=ls+B1ltP0N7/jwz/5QBBYJTT6qIm/m7EuCGiX3tgNZ4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Gv8gwa6CPNPIl/aFxmQrzm4EMNC66/+T+SR9J2tqncfMdS6+mbhKZbPAG+ZUg6Zo+y8OxyxLrnyeBhZF4oSi1AbfUZLXzelC/fTI3Bzj3nSNe2Ak5+zUn166yauyWZcUxW42VnCEw952vmrxJJRgHdyQUNKI21M3NfN/CjSqr68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TplBw2ch5z2BfKn;
	Tue,  5 Mar 2024 13:54:48 +0800 (CST)
Received: from kwepemi500006.china.huawei.com (unknown [7.221.188.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 6F4FE1402CB;
	Tue,  5 Mar 2024 13:57:08 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Mar 2024 13:57:07 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH for-next] RDMA/hns: Append SCC context to the raw dump of QPC
Date: Tue, 5 Mar 2024 13:52:57 +0800
Message-ID: <20240305055257.823513-1-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500006.china.huawei.com (7.221.188.68)

From: wenglianfa <wenglianfa@huawei.com>

SCCC (SCC Context) is a context with QP granularity that contains
information about congestion control. Dump SCCC and QPC together
to improve troubleshooting.

When dumping raw QPC with rdmatool, there will be a total of 576 bytes
data output, where the first 512 bytes is QPC and the last 64 bytes is
SCCC. When congestion control is disabled, the 64 byte SCCC will be all 0.

Example:
$rdma res show qp -jpr
[ {
        "ifindex": 0,
        "ifname": "hns_0",
	"data": [ 67,0,0,0... 512bytes
		  4,0,2... 64bytes]
  },...
} ]

Signed-off-by: wenglianfa <wenglianfa@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_cmd.h      |  3 +++
 drivers/infiniband/hw/hns/hns_roce_device.h   |  1 +
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c    | 25 +++++++++++++++++++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h    |  6 +++++
 drivers/infiniband/hw/hns/hns_roce_restrack.c | 23 ++++++++++++++---
 5 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_cmd.h b/drivers/infiniband/hw/hns/hns_roce_cmd.h
index 052a3d60905a..11dbbabebdc9 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cmd.h
+++ b/drivers/infiniband/hw/hns/hns_roce_cmd.h
@@ -108,6 +108,9 @@ enum {
 	HNS_ROCE_CMD_QUERY_CEQC		= 0x92,
 	HNS_ROCE_CMD_DESTROY_CEQC	= 0x93,
 
+	/* SCC CTX commands */
+	HNS_ROCE_CMD_QUERY_SCCC		= 0xa2,
+
 	/* SCC CTX BT commands */
 	HNS_ROCE_CMD_READ_SCCC_BT0	= 0xa4,
 	HNS_ROCE_CMD_WRITE_SCCC_BT0	= 0xa5,
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index bc015901a7d3..c3cbd0a494bf 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -947,6 +947,7 @@ struct hns_roce_hw {
 	int (*query_qpc)(struct hns_roce_dev *hr_dev, u32 qpn, void *buffer);
 	int (*query_mpt)(struct hns_roce_dev *hr_dev, u32 key, void *buffer);
 	int (*query_srqc)(struct hns_roce_dev *hr_dev, u32 srqn, void *buffer);
+	int (*query_sccc)(struct hns_roce_dev *hr_dev, u32 qpn, void *buffer);
 	int (*query_hw_counter)(struct hns_roce_dev *hr_dev,
 				u64 *stats, u32 port, int *hw_counters);
 	const struct ib_device_ops *hns_roce_dev_ops;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 38e426f4afb5..ba7ae792d279 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -5317,6 +5317,30 @@ static int hns_roce_v2_query_srqc(struct hns_roce_dev *hr_dev, u32 srqn,
 	return ret;
 }
 
+static int hns_roce_v2_query_sccc(struct hns_roce_dev *hr_dev, u32 qpn,
+				  void *buffer)
+{
+	struct hns_roce_v2_scc_context *context;
+	struct hns_roce_cmd_mailbox *mailbox;
+	int ret;
+
+	mailbox = hns_roce_alloc_cmd_mailbox(hr_dev);
+	if (IS_ERR(mailbox))
+		return PTR_ERR(mailbox);
+
+	ret = hns_roce_cmd_mbox(hr_dev, 0, mailbox->dma, HNS_ROCE_CMD_QUERY_SCCC,
+				qpn);
+	if (ret)
+		goto out;
+
+	context = mailbox->buf;
+	memcpy(buffer, context, sizeof(*context));
+
+out:
+	hns_roce_free_cmd_mailbox(hr_dev, mailbox);
+	return ret;
+}
+
 static u8 get_qp_timeout_attr(struct hns_roce_dev *hr_dev,
 			      struct hns_roce_v2_qp_context *context)
 {
@@ -6709,6 +6733,7 @@ static const struct hns_roce_hw hns_roce_hw_v2 = {
 	.query_qpc = hns_roce_v2_query_qpc,
 	.query_mpt = hns_roce_v2_query_mpt,
 	.query_srqc = hns_roce_v2_query_srqc,
+	.query_sccc = hns_roce_v2_query_sccc,
 	.query_hw_counter = hns_roce_hw_v2_query_counter,
 	.hns_roce_dev_ops = &hns_roce_v2_dev_ops,
 	.hns_roce_dev_srq_ops = &hns_roce_v2_dev_srq_ops,
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index 359a74672ba1..df04bc8ede57 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -646,6 +646,12 @@ struct hns_roce_v2_qp_context {
 #define QPCEX_SQ_RQ_NOT_FORBID_EN QPCEX_FIELD_LOC(23, 23)
 #define QPCEX_STASH QPCEX_FIELD_LOC(82, 82)
 
+#define SCC_CONTEXT_SIZE 16
+
+struct hns_roce_v2_scc_context {
+	__le32 data[SCC_CONTEXT_SIZE];
+};
+
 #define	V2_QP_RWE_S 1 /* rdma write enable */
 #define	V2_QP_RRE_S 2 /* rdma read enable */
 #define	V2_QP_ATE_S 3 /* rdma atomic enable */
diff --git a/drivers/infiniband/hw/hns/hns_roce_restrack.c b/drivers/infiniband/hw/hns/hns_roce_restrack.c
index f7f3c4cc7426..356d98816949 100644
--- a/drivers/infiniband/hw/hns/hns_roce_restrack.c
+++ b/drivers/infiniband/hw/hns/hns_roce_restrack.c
@@ -97,16 +97,33 @@ int hns_roce_fill_res_qp_entry_raw(struct sk_buff *msg, struct ib_qp *ib_qp)
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(ib_qp->device);
 	struct hns_roce_qp *hr_qp = to_hr_qp(ib_qp);
-	struct hns_roce_v2_qp_context context;
+	struct hns_roce_full_qp_ctx {
+		struct hns_roce_v2_qp_context qpc;
+		struct hns_roce_v2_scc_context sccc;
+	} context = {};
 	int ret;
 
 	if (!hr_dev->hw->query_qpc)
 		return -EINVAL;
 
-	ret = hr_dev->hw->query_qpc(hr_dev, hr_qp->qpn, &context);
+	ret = hr_dev->hw->query_qpc(hr_dev, hr_qp->qpn, &context.qpc);
 	if (ret)
-		return -EINVAL;
+		return ret;
+
+	/* If SCC is disabled or the query fails, the queried SCCC will
+	 * be all 0.
+	 */
+	if (!(hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_QP_FLOW_CTRL) ||
+	    !hr_dev->hw->query_sccc)
+		goto out;
+
+	ret = hr_dev->hw->query_sccc(hr_dev, hr_qp->qpn, &context.sccc);
+	if (ret)
+		ibdev_warn_ratelimited(&hr_dev->ib_dev,
+				       "failed to query SCCC, ret = %d.\n",
+				       ret);
 
+out:
 	ret = nla_put(msg, RDMA_NLDEV_ATTR_RES_RAW, sizeof(context), &context);
 
 	return ret;
-- 
2.30.0


