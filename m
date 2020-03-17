Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F28C7187855
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2020 04:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgCQD7g (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Mar 2020 23:59:36 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41514 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726192AbgCQD7g (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 16 Mar 2020 23:59:36 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 88B36F2E64D6C5ACD4A1;
        Tue, 17 Mar 2020 11:59:15 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Tue, 17 Mar 2020 11:59:06 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 2/2] RDMA/hns: Optimize mhop put flow for multi-hop addressing
Date:   Tue, 17 Mar 2020 11:55:24 +0800
Message-ID: <1584417324-2255-3-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1584417324-2255-1-git-send-email-liweihang@huawei.com>
References: <1584417324-2255-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

Optimizes hns_roce_table_mhop_get() by encapsulating code about clearing
hem into clear_mhop_hem(), which will make the code flow clearer.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hem.c | 161 ++++++++++++-------------------
 1 file changed, 61 insertions(+), 100 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.c b/drivers/infiniband/hw/hns/hns_roce_hem.c
index cc557f1..c963787 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.c
@@ -94,25 +94,27 @@ bool hns_roce_check_whether_mhop(struct hns_roce_dev *hr_dev, u32 type)
 	return hop_num ? true : false;
 }
 
-static bool hns_roce_check_hem_null(struct hns_roce_hem **hem, u64 start_idx,
-			    u32 bt_chunk_num, u64 hem_max_num)
+static bool hns_roce_check_hem_null(struct hns_roce_hem **hem, u64 hem_idx,
+				    u32 bt_chunk_num, u64 hem_max_num)
 {
+	u64 start_idx = round_down(hem_idx, bt_chunk_num);
 	u64 check_max_num = start_idx + bt_chunk_num;
 	u64 i;
 
 	for (i = start_idx; (i < check_max_num) && (i < hem_max_num); i++)
-		if (hem[i])
+		if (i != hem_idx && hem[i])
 			return false;
 
 	return true;
 }
 
-static bool hns_roce_check_bt_null(u64 **bt, u64 start_idx, u32 bt_chunk_num)
+static bool hns_roce_check_bt_null(u64 **bt, u64 ba_idx, u32 bt_chunk_num)
 {
+	u64 start_idx = round_down(ba_idx, bt_chunk_num);
 	int i;
 
 	for (i = 0; i < bt_chunk_num; i++)
-		if (bt[start_idx + i])
+		if (i != ba_idx && bt[start_idx + i])
 			return false;
 
 	return true;
@@ -723,116 +725,75 @@ int hns_roce_table_get(struct hns_roce_dev *hr_dev,
 	return ret;
 }
 
+static void clear_mhop_hem(struct hns_roce_dev *hr_dev,
+			   struct hns_roce_hem_table *table, unsigned long obj,
+			   struct hns_roce_hem_mhop *mhop,
+			   struct hns_roce_hem_index *index)
+{
+	struct ib_device *ibdev = &hr_dev->ib_dev;
+	u32 hop_num = mhop->hop_num;
+	u32 chunk_ba_num;
+	int step_idx;
+
+	index->inited = HEM_INDEX_BUF;
+	chunk_ba_num = mhop->bt_chunk_size / BA_BYTE_LEN;
+	if (check_whether_bt_num_2(table->type, hop_num)) {
+		if (hns_roce_check_hem_null(table->hem, index->buf,
+					    chunk_ba_num, table->num_hem))
+			index->inited |= HEM_INDEX_L0;
+	} else if (check_whether_bt_num_3(table->type, hop_num)) {
+		if (hns_roce_check_hem_null(table->hem, index->buf,
+					    chunk_ba_num, table->num_hem)) {
+			index->inited |= HEM_INDEX_L1;
+			if (hns_roce_check_bt_null(table->bt_l1, index->l1,
+						   chunk_ba_num))
+				index->inited |= HEM_INDEX_L0;
+		}
+	}
+
+	if (table->type < HEM_TYPE_MTT) {
+		if (hop_num == HNS_ROCE_HOP_NUM_0)
+			step_idx = 0;
+		else
+			step_idx = hop_num;
+
+		if (hr_dev->hw->clear_hem(hr_dev, table, obj, step_idx))
+			ibdev_warn(ibdev, "Clear hop%d HEM failed.\n", hop_num);
+
+		if (index->inited & HEM_INDEX_L1)
+			if (hr_dev->hw->clear_hem(hr_dev, table, obj, 1))
+				ibdev_warn(ibdev, "Clear HEM step 1 failed.\n");
+
+		if (index->inited & HEM_INDEX_L0)
+			if (hr_dev->hw->clear_hem(hr_dev, table, obj, 0))
+				ibdev_warn(ibdev, "Clear HEM step 0 failed.\n");
+	}
+}
+
 static void hns_roce_table_mhop_put(struct hns_roce_dev *hr_dev,
 				    struct hns_roce_hem_table *table,
 				    unsigned long obj,
 				    int check_refcount)
 {
-	struct device *dev = hr_dev->dev;
-	struct hns_roce_hem_mhop mhop;
-	unsigned long mhop_obj = obj;
-	u32 bt_chunk_size;
-	u32 chunk_ba_num;
-	u32 hop_num;
-	u32 start_idx;
-	u32 bt_num;
-	u64 hem_idx;
-	u64 bt_l1_idx = 0;
+	struct ib_device *ibdev = &hr_dev->ib_dev;
+	struct hns_roce_hem_index index = {};
+	struct hns_roce_hem_mhop mhop = {};
 	int ret;
 
-	ret = hns_roce_calc_hem_mhop(hr_dev, table, &mhop_obj, &mhop);
-	if (ret)
-		return;
-
-	bt_chunk_size = mhop.bt_chunk_size;
-	hop_num = mhop.hop_num;
-	chunk_ba_num = bt_chunk_size / BA_BYTE_LEN;
-
-	bt_num = hns_roce_get_bt_num(table->type, hop_num);
-	switch (bt_num) {
-	case 3:
-		hem_idx = mhop.l0_idx * chunk_ba_num * chunk_ba_num +
-			  mhop.l1_idx * chunk_ba_num + mhop.l2_idx;
-		bt_l1_idx = mhop.l0_idx * chunk_ba_num + mhop.l1_idx;
-		break;
-	case 2:
-		hem_idx = mhop.l0_idx * chunk_ba_num + mhop.l1_idx;
-		break;
-	case 1:
-		hem_idx = mhop.l0_idx;
-		break;
-	default:
-		dev_err(dev, "Table %d not support hop_num = %d!\n",
-			     table->type, hop_num);
+	ret = calc_hem_config(hr_dev, table, obj, &mhop, &index);
+	if (ret) {
+		ibdev_err(ibdev, "calc hem config failed!\n");
 		return;
 	}
 
 	mutex_lock(&table->mutex);
-
-	if (check_refcount && (--table->hem[hem_idx]->refcount > 0)) {
+	if (check_refcount && (--table->hem[index.buf]->refcount > 0)) {
 		mutex_unlock(&table->mutex);
 		return;
 	}
 
-	if (table->type < HEM_TYPE_MTT && hop_num == 1) {
-		if (hr_dev->hw->clear_hem(hr_dev, table, obj, 1))
-			dev_warn(dev, "Clear HEM base address failed.\n");
-	} else if (table->type < HEM_TYPE_MTT && hop_num == 2) {
-		if (hr_dev->hw->clear_hem(hr_dev, table, obj, 2))
-			dev_warn(dev, "Clear HEM base address failed.\n");
-	} else if (table->type < HEM_TYPE_MTT &&
-		   hop_num == HNS_ROCE_HOP_NUM_0) {
-		if (hr_dev->hw->clear_hem(hr_dev, table, obj, 0))
-			dev_warn(dev, "Clear HEM base address failed.\n");
-	}
-
-	/*
-	 * free buffer space chunk for QPC/MTPT/CQC/SRQC/SCCC.
-	 * free bt space chunk for MTT/CQE.
-	 */
-	hns_roce_free_hem(hr_dev, table->hem[hem_idx]);
-	table->hem[hem_idx] = NULL;
-
-	if (check_whether_bt_num_2(table->type, hop_num)) {
-		start_idx = mhop.l0_idx * chunk_ba_num;
-		if (hns_roce_check_hem_null(table->hem, start_idx,
-					    chunk_ba_num, table->num_hem)) {
-			if (table->type < HEM_TYPE_MTT &&
-			    hr_dev->hw->clear_hem(hr_dev, table, obj, 0))
-				dev_warn(dev, "Clear HEM base address failed.\n");
-
-			dma_free_coherent(dev, bt_chunk_size,
-					  table->bt_l0[mhop.l0_idx],
-					  table->bt_l0_dma_addr[mhop.l0_idx]);
-			table->bt_l0[mhop.l0_idx] = NULL;
-		}
-	} else if (check_whether_bt_num_3(table->type, hop_num)) {
-		start_idx = mhop.l0_idx * chunk_ba_num * chunk_ba_num +
-			    mhop.l1_idx * chunk_ba_num;
-		if (hns_roce_check_hem_null(table->hem, start_idx,
-					    chunk_ba_num, table->num_hem)) {
-			if (hr_dev->hw->clear_hem(hr_dev, table, obj, 1))
-				dev_warn(dev, "Clear HEM base address failed.\n");
-
-			dma_free_coherent(dev, bt_chunk_size,
-					  table->bt_l1[bt_l1_idx],
-					  table->bt_l1_dma_addr[bt_l1_idx]);
-			table->bt_l1[bt_l1_idx] = NULL;
-
-			start_idx = mhop.l0_idx * chunk_ba_num;
-			if (hns_roce_check_bt_null(table->bt_l1, start_idx,
-						   chunk_ba_num)) {
-				if (hr_dev->hw->clear_hem(hr_dev, table, obj,
-							  0))
-					dev_warn(dev, "Clear HEM base address failed.\n");
-
-				dma_free_coherent(dev, bt_chunk_size,
-					    table->bt_l0[mhop.l0_idx],
-					    table->bt_l0_dma_addr[mhop.l0_idx]);
-				table->bt_l0[mhop.l0_idx] = NULL;
-			}
-		}
-	}
+	clear_mhop_hem(hr_dev, table, obj, &mhop, &index);
+	free_mhop_hem(hr_dev, table, &mhop, &index);
 
 	mutex_unlock(&table->mutex);
 }
-- 
2.8.1

