Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB8462307E0
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Jul 2020 12:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbgG1KnY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Jul 2020 06:43:24 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8838 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728638AbgG1KnW (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 28 Jul 2020 06:43:22 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 907EBE59AC3F94586273;
        Tue, 28 Jul 2020 18:43:16 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Tue, 28 Jul 2020 18:43:09 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH v2 for-next 2/7] RDMA/hns: Refactor hns_roce_v2_set_hem()
Date:   Tue, 28 Jul 2020 18:42:16 +0800
Message-ID: <1595932941-40613-3-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1595932941-40613-1-git-send-email-liweihang@huawei.com>
References: <1595932941-40613-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The parts about preparing and sending mailbox to hardware is not strongly
related to other codes in hns_roce_v2_set_hem(), and can be encapsulated
into a separate function.

Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 45 +++++++++++++++++-------------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 35d46b7..516e246 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -3373,11 +3373,33 @@ static int get_op_for_set_hem(struct hns_roce_dev *hr_dev, u32 type,
 	return op + step_idx;
 }
 
+static int set_hem_to_hw(struct hns_roce_dev *hr_dev, int obj, u64 bt_ba,
+			 u32 hem_type, int step_idx)
+{
+	struct hns_roce_cmd_mailbox *mailbox;
+	int ret;
+	int op;
+
+	op = get_op_for_set_hem(hr_dev, hem_type, step_idx);
+	if (op < 0)
+		return 0;
+
+	mailbox = hns_roce_alloc_cmd_mailbox(hr_dev);
+	if (IS_ERR(mailbox))
+		return PTR_ERR(mailbox);
+
+	ret = hns_roce_cmd_mbox(hr_dev, bt_ba, mailbox->dma, obj,
+				0, op, HNS_ROCE_CMD_TIMEOUT_MSECS);
+
+	hns_roce_free_cmd_mailbox(hr_dev, mailbox);
+
+	return ret;
+}
+
 static int hns_roce_v2_set_hem(struct hns_roce_dev *hr_dev,
 			       struct hns_roce_hem_table *table, int obj,
 			       int step_idx)
 {
-	struct hns_roce_cmd_mailbox *mailbox;
 	struct hns_roce_hem_iter iter;
 	struct hns_roce_hem_mhop mhop;
 	struct hns_roce_hem *hem;
@@ -3389,7 +3411,6 @@ static int hns_roce_v2_set_hem(struct hns_roce_dev *hr_dev,
 	u64 bt_ba = 0;
 	u32 chunk_ba_num;
 	u32 hop_num;
-	int op;
 
 	if (!hns_roce_check_whether_mhop(hr_dev, table->type))
 		return 0;
@@ -3411,14 +3432,6 @@ static int hns_roce_v2_set_hem(struct hns_roce_dev *hr_dev,
 		hem_idx = i;
 	}
 
-	op = get_op_for_set_hem(hr_dev, table->type, step_idx);
-	if (op == -EINVAL)
-		return 0;
-
-	mailbox = hns_roce_alloc_cmd_mailbox(hr_dev);
-	if (IS_ERR(mailbox))
-		return PTR_ERR(mailbox);
-
 	if (table->type == HEM_TYPE_SCCC)
 		obj = mhop.l0_idx;
 
@@ -3427,11 +3440,8 @@ static int hns_roce_v2_set_hem(struct hns_roce_dev *hr_dev,
 		for (hns_roce_hem_first(hem, &iter);
 		     !hns_roce_hem_last(&iter); hns_roce_hem_next(&iter)) {
 			bt_ba = hns_roce_hem_addr(&iter);
-
-			/* configure the ba, tag, and op */
-			ret = hns_roce_cmd_mbox(hr_dev, bt_ba, mailbox->dma,
-						obj, 0, op,
-						HNS_ROCE_CMD_TIMEOUT_MSECS);
+			ret = set_hem_to_hw(hr_dev, obj, bt_ba, table->type,
+					    step_idx);
 		}
 	} else {
 		if (step_idx == 0)
@@ -3439,12 +3449,9 @@ static int hns_roce_v2_set_hem(struct hns_roce_dev *hr_dev,
 		else if (step_idx == 1 && hop_num == 2)
 			bt_ba = table->bt_l1_dma_addr[l1_idx];
 
-		/* configure the ba, tag, and op */
-		ret = hns_roce_cmd_mbox(hr_dev, bt_ba, mailbox->dma, obj,
-					0, op, HNS_ROCE_CMD_TIMEOUT_MSECS);
+		ret = set_hem_to_hw(hr_dev, obj, bt_ba, table->type, step_idx);
 	}
 
-	hns_roce_free_cmd_mailbox(hr_dev, mailbox);
 	return ret;
 }
 
-- 
2.8.1

