Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 883BD7A390
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2019 11:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731237AbfG3JBN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Jul 2019 05:01:13 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:54028 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730144AbfG3JBM (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 30 Jul 2019 05:01:12 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 88A6EDD70A2120345A29;
        Tue, 30 Jul 2019 17:00:53 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.439.0; Tue, 30 Jul 2019 17:00:47 +0800
From:   Lijun Ou <oulijun@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 11/13] RDMA/hns: Refactor hns_roce_v2_set_hem for hip08
Date:   Tue, 30 Jul 2019 16:56:48 +0800
Message-ID: <1564477010-29804-12-git-send-email-oulijun@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1564477010-29804-1-git-send-email-oulijun@huawei.com>
References: <1564477010-29804-1-git-send-email-oulijun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yangyang Li <liyangyang20@huawei.com>

In order to reduce the complexity of hns_roce_v2_set_hem, extract
the implementation of op as a function.

Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 75 +++++++++++++++++-------------
 1 file changed, 42 insertions(+), 33 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 07ddfae..8f4430b 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -2903,11 +2903,49 @@ static int hns_roce_v2_poll_cq(struct ib_cq *ibcq, int num_entries,
 	return npolled;
 }
 
+static int get_op_for_set_hem(struct hns_roce_dev *hr_dev, u32 type,
+			      int step_idx)
+{
+	int op;
+
+	if (type == HEM_TYPE_SCCC && step_idx)
+		return -EINVAL;
+
+	switch (type) {
+	case HEM_TYPE_QPC:
+		op = HNS_ROCE_CMD_WRITE_QPC_BT0;
+		break;
+	case HEM_TYPE_MTPT:
+		op = HNS_ROCE_CMD_WRITE_MPT_BT0;
+		break;
+	case HEM_TYPE_CQC:
+		op = HNS_ROCE_CMD_WRITE_CQC_BT0;
+		break;
+	case HEM_TYPE_SRQC:
+		op = HNS_ROCE_CMD_WRITE_SRQC_BT0;
+		break;
+	case HEM_TYPE_SCCC:
+		op = HNS_ROCE_CMD_WRITE_SCCC_BT0;
+		break;
+	case HEM_TYPE_QPC_TIMER:
+		op = HNS_ROCE_CMD_WRITE_QPC_TIMER_BT0;
+		break;
+	case HEM_TYPE_CQC_TIMER:
+		op = HNS_ROCE_CMD_WRITE_CQC_TIMER_BT0;
+		break;
+	default:
+		dev_warn(hr_dev->dev,
+			 "Table %d not to be written by mailbox!\n", type);
+		return -EINVAL;
+	}
+
+	return op + step_idx;
+}
+
 static int hns_roce_v2_set_hem(struct hns_roce_dev *hr_dev,
 			       struct hns_roce_hem_table *table, int obj,
 			       int step_idx)
 {
-	struct device *dev = hr_dev->dev;
 	struct hns_roce_cmd_mailbox *mailbox;
 	struct hns_roce_hem_iter iter;
 	struct hns_roce_hem_mhop mhop;
@@ -2920,7 +2958,7 @@ static int hns_roce_v2_set_hem(struct hns_roce_dev *hr_dev,
 	u64 bt_ba = 0;
 	u32 chunk_ba_num;
 	u32 hop_num;
-	u16 op = 0xff;
+	int op;
 
 	if (!hns_roce_check_whether_mhop(hr_dev, table->type))
 		return 0;
@@ -2942,38 +2980,9 @@ static int hns_roce_v2_set_hem(struct hns_roce_dev *hr_dev,
 		hem_idx = i;
 	}
 
-	switch (table->type) {
-	case HEM_TYPE_QPC:
-		op = HNS_ROCE_CMD_WRITE_QPC_BT0;
-		break;
-	case HEM_TYPE_MTPT:
-		op = HNS_ROCE_CMD_WRITE_MPT_BT0;
-		break;
-	case HEM_TYPE_CQC:
-		op = HNS_ROCE_CMD_WRITE_CQC_BT0;
-		break;
-	case HEM_TYPE_SRQC:
-		op = HNS_ROCE_CMD_WRITE_SRQC_BT0;
-		break;
-	case HEM_TYPE_SCCC:
-		op = HNS_ROCE_CMD_WRITE_SCCC_BT0;
-		break;
-	case HEM_TYPE_QPC_TIMER:
-		op = HNS_ROCE_CMD_WRITE_QPC_TIMER_BT0;
-		break;
-	case HEM_TYPE_CQC_TIMER:
-		op = HNS_ROCE_CMD_WRITE_CQC_TIMER_BT0;
-		break;
-	default:
-		dev_warn(dev, "Table %d not to be written by mailbox!\n",
-			 table->type);
+	op = get_op_for_set_hem(hr_dev, table->type, step_idx);
+	if (op == -EINVAL)
 		return 0;
-	}
-
-	if (table->type == HEM_TYPE_SCCC && step_idx)
-		return 0;
-
-	op += step_idx;
 
 	mailbox = hns_roce_alloc_cmd_mailbox(hr_dev);
 	if (IS_ERR(mailbox))
-- 
1.9.1

