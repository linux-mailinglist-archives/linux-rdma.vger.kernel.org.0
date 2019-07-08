Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4EA161FB8
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2019 15:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729856AbfGHNo4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 8 Jul 2019 09:44:56 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2184 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731412AbfGHNo4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 8 Jul 2019 09:44:56 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 788815CD0541EE1020B5;
        Mon,  8 Jul 2019 21:44:49 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Mon, 8 Jul 2019 21:44:40 +0800
From:   Lijun Ou <oulijun@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 8/9] RDMA/hns: Refactor hem table mhop check and calculation
Date:   Mon, 8 Jul 2019 21:41:24 +0800
Message-ID: <1562593285-8037-9-git-send-email-oulijun@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1562593285-8037-1-git-send-email-oulijun@huawei.com>
References: <1562593285-8037-1-git-send-email-oulijun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The calculation of mhop for hem is duplicated in
hns_roce_init_hem_table and hns_roce_calc_hem_mhop,
extracting it from them to a separated function. Moreover,
this patch refactor hns_roce_check_whether_mhop to
reduce complexity.

Signed-off-by: Yixian Liu <liuyixian@huawei.com>
Signed-off-by: Lijun Ou <oulijun@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hem.c | 180 ++++++++++++-------------------
 1 file changed, 70 insertions(+), 110 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.c b/drivers/infiniband/hw/hns/hns_roce_hem.c
index f4da5bd..6150311 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.c
@@ -41,20 +41,47 @@
 
 bool hns_roce_check_whether_mhop(struct hns_roce_dev *hr_dev, u32 type)
 {
-	if ((hr_dev->caps.qpc_hop_num && type == HEM_TYPE_QPC) ||
-	    (hr_dev->caps.mpt_hop_num && type == HEM_TYPE_MTPT) ||
-	    (hr_dev->caps.cqc_hop_num && type == HEM_TYPE_CQC) ||
-	    (hr_dev->caps.srqc_hop_num && type == HEM_TYPE_SRQC) ||
-	    (hr_dev->caps.sccc_hop_num && type == HEM_TYPE_SCCC) ||
-	    (hr_dev->caps.qpc_timer_hop_num && type == HEM_TYPE_QPC_TIMER) ||
-	    (hr_dev->caps.cqc_timer_hop_num && type == HEM_TYPE_CQC_TIMER) ||
-	    (hr_dev->caps.cqe_hop_num && type == HEM_TYPE_CQE) ||
-	    (hr_dev->caps.mtt_hop_num && type == HEM_TYPE_MTT) ||
-	    (hr_dev->caps.srqwqe_hop_num && type == HEM_TYPE_SRQWQE) ||
-	    (hr_dev->caps.idx_hop_num && type == HEM_TYPE_IDX))
-		return true;
-
-	return false;
+	int hop_num = 0;
+
+	switch (type) {
+	case HEM_TYPE_QPC:
+		hop_num = hr_dev->caps.qpc_hop_num;
+		break;
+	case HEM_TYPE_MTPT:
+		hop_num = hr_dev->caps.mpt_hop_num;
+		break;
+	case HEM_TYPE_CQC:
+		hop_num = hr_dev->caps.cqc_hop_num;
+		break;
+	case HEM_TYPE_SRQC:
+		hop_num = hr_dev->caps.srqc_hop_num;
+		break;
+	case HEM_TYPE_SCCC:
+		hop_num = hr_dev->caps.sccc_hop_num;
+		break;
+	case HEM_TYPE_QPC_TIMER:
+		hop_num = hr_dev->caps.qpc_timer_hop_num;
+		break;
+	case HEM_TYPE_CQC_TIMER:
+		hop_num = hr_dev->caps.cqc_timer_hop_num;
+		break;
+	case HEM_TYPE_CQE:
+		hop_num = hr_dev->caps.cqe_hop_num;
+		break;
+	case HEM_TYPE_MTT:
+		hop_num = hr_dev->caps.mtt_hop_num;
+		break;
+	case HEM_TYPE_SRQWQE:
+		hop_num = hr_dev->caps.srqwqe_hop_num;
+		break;
+	case HEM_TYPE_IDX:
+		hop_num = hr_dev->caps.idx_hop_num;
+		break;
+	default:
+		return false;
+	}
+
+	return hop_num ? true : false;
 }
 
 static bool hns_roce_check_hem_null(struct hns_roce_hem **hem, u64 start_idx,
@@ -92,17 +119,13 @@ static int hns_roce_get_bt_num(u32 table_type, u32 hop_num)
 		return 0;
 }
 
-int hns_roce_calc_hem_mhop(struct hns_roce_dev *hr_dev,
-			   struct hns_roce_hem_table *table, unsigned long *obj,
-			   struct hns_roce_hem_mhop *mhop)
+static int get_hem_table_config(struct hns_roce_dev *hr_dev,
+				struct hns_roce_hem_mhop *mhop,
+				u32 type)
 {
 	struct device *dev = hr_dev->dev;
-	u32 chunk_ba_num;
-	u32 table_idx;
-	u32 bt_num;
-	u32 chunk_size;
 
-	switch (table->type) {
+	switch (type) {
 	case HEM_TYPE_QPC:
 		mhop->buf_chunk_size = 1 << (hr_dev->caps.qpc_buf_pg_sz
 					     + PAGE_SHIFT);
@@ -193,10 +216,26 @@ int hns_roce_calc_hem_mhop(struct hns_roce_dev *hr_dev,
 		break;
 	default:
 		dev_err(dev, "Table %d not support multi-hop addressing!\n",
-			 table->type);
+			type);
 		return -EINVAL;
 	}
 
+	return 0;
+}
+
+int hns_roce_calc_hem_mhop(struct hns_roce_dev *hr_dev,
+			   struct hns_roce_hem_table *table, unsigned long *obj,
+			   struct hns_roce_hem_mhop *mhop)
+{
+	struct device *dev = hr_dev->dev;
+	u32 chunk_ba_num;
+	u32 table_idx;
+	u32 bt_num;
+	u32 chunk_size;
+
+	if (get_hem_table_config(hr_dev, mhop, table->type))
+		return -EINVAL;
+
 	if (!obj)
 		return 0;
 
@@ -887,7 +926,6 @@ int hns_roce_init_hem_table(struct hns_roce_dev *hr_dev,
 			    unsigned long obj_size, unsigned long nobj,
 			    int use_lowmem)
 {
-	struct device *dev = hr_dev->dev;
 	unsigned long obj_per_chunk;
 	unsigned long num_hem;
 
@@ -900,99 +938,21 @@ int hns_roce_init_hem_table(struct hns_roce_dev *hr_dev,
 		if (!table->hem)
 			return -ENOMEM;
 	} else {
+		struct hns_roce_hem_mhop mhop = {};
 		unsigned long buf_chunk_size;
 		unsigned long bt_chunk_size;
 		unsigned long bt_chunk_num;
 		unsigned long num_bt_l0 = 0;
 		u32 hop_num;
 
-		switch (type) {
-		case HEM_TYPE_QPC:
-			buf_chunk_size = 1 << (hr_dev->caps.qpc_buf_pg_sz
-					+ PAGE_SHIFT);
-			bt_chunk_size = 1 << (hr_dev->caps.qpc_ba_pg_sz
-					+ PAGE_SHIFT);
-			num_bt_l0 = hr_dev->caps.qpc_bt_num;
-			hop_num = hr_dev->caps.qpc_hop_num;
-			break;
-		case HEM_TYPE_MTPT:
-			buf_chunk_size = 1 << (hr_dev->caps.mpt_buf_pg_sz
-					+ PAGE_SHIFT);
-			bt_chunk_size = 1 << (hr_dev->caps.mpt_ba_pg_sz
-					+ PAGE_SHIFT);
-			num_bt_l0 = hr_dev->caps.mpt_bt_num;
-			hop_num = hr_dev->caps.mpt_hop_num;
-			break;
-		case HEM_TYPE_CQC:
-			buf_chunk_size = 1 << (hr_dev->caps.cqc_buf_pg_sz
-					+ PAGE_SHIFT);
-			bt_chunk_size = 1 << (hr_dev->caps.cqc_ba_pg_sz
-					+ PAGE_SHIFT);
-			num_bt_l0 = hr_dev->caps.cqc_bt_num;
-			hop_num = hr_dev->caps.cqc_hop_num;
-			break;
-		case HEM_TYPE_SCCC:
-			buf_chunk_size = 1 << (hr_dev->caps.sccc_buf_pg_sz
-					+ PAGE_SHIFT);
-			bt_chunk_size = 1 << (hr_dev->caps.sccc_ba_pg_sz
-					+ PAGE_SHIFT);
-			num_bt_l0 = hr_dev->caps.sccc_bt_num;
-			hop_num = hr_dev->caps.sccc_hop_num;
-			break;
-		case HEM_TYPE_QPC_TIMER:
-			buf_chunk_size = 1 << (hr_dev->caps.qpc_timer_buf_pg_sz
-					+ PAGE_SHIFT);
-			bt_chunk_size = 1 << (hr_dev->caps.qpc_timer_ba_pg_sz
-					+ PAGE_SHIFT);
-			num_bt_l0 = hr_dev->caps.qpc_timer_bt_num;
-			hop_num = hr_dev->caps.qpc_timer_hop_num;
-			break;
-		case HEM_TYPE_CQC_TIMER:
-			buf_chunk_size = 1 << (hr_dev->caps.cqc_timer_buf_pg_sz
-					+ PAGE_SHIFT);
-			bt_chunk_size = 1 << (hr_dev->caps.cqc_timer_ba_pg_sz
-					+ PAGE_SHIFT);
-			num_bt_l0 = hr_dev->caps.cqc_timer_bt_num;
-			hop_num = hr_dev->caps.cqc_timer_hop_num;
-			break;
-		case HEM_TYPE_SRQC:
-			buf_chunk_size = 1 << (hr_dev->caps.srqc_buf_pg_sz
-					+ PAGE_SHIFT);
-			bt_chunk_size = 1 << (hr_dev->caps.srqc_ba_pg_sz
-					+ PAGE_SHIFT);
-			num_bt_l0 = hr_dev->caps.srqc_bt_num;
-			hop_num = hr_dev->caps.srqc_hop_num;
-			break;
-		case HEM_TYPE_MTT:
-			buf_chunk_size = 1 << (hr_dev->caps.mtt_ba_pg_sz
-					+ PAGE_SHIFT);
-			bt_chunk_size = buf_chunk_size;
-			hop_num = hr_dev->caps.mtt_hop_num;
-			break;
-		case HEM_TYPE_CQE:
-			buf_chunk_size = 1 << (hr_dev->caps.cqe_ba_pg_sz
-					+ PAGE_SHIFT);
-			bt_chunk_size = buf_chunk_size;
-			hop_num = hr_dev->caps.cqe_hop_num;
-			break;
-		case HEM_TYPE_SRQWQE:
-			buf_chunk_size = 1 << (hr_dev->caps.srqwqe_ba_pg_sz
-					+ PAGE_SHIFT);
-			bt_chunk_size = buf_chunk_size;
-			hop_num = hr_dev->caps.srqwqe_hop_num;
-			break;
-		case HEM_TYPE_IDX:
-			buf_chunk_size = 1 << (hr_dev->caps.idx_ba_pg_sz
-					+ PAGE_SHIFT);
-			bt_chunk_size = buf_chunk_size;
-			hop_num = hr_dev->caps.idx_hop_num;
-			break;
-		default:
-			dev_err(dev,
-			  "Table %d not support to init hem table here!\n",
-			  type);
+		if (get_hem_table_config(hr_dev, &mhop, type))
 			return -EINVAL;
-		}
+
+		buf_chunk_size = mhop.buf_chunk_size;
+		bt_chunk_size = mhop.bt_chunk_size;
+		num_bt_l0 = mhop.ba_l0_num;
+		hop_num = mhop.hop_num;
+
 		obj_per_chunk = buf_chunk_size / obj_size;
 		num_hem = (nobj + obj_per_chunk - 1) / obj_per_chunk;
 		bt_chunk_num = bt_chunk_size / BA_BYTE_LEN;
-- 
1.9.1

