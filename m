Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7A3187858
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2020 04:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgCQD7n (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Mar 2020 23:59:43 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41508 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726587AbgCQD7n (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 16 Mar 2020 23:59:43 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 821528EBD38FD237DA81;
        Tue, 17 Mar 2020 11:59:15 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Tue, 17 Mar 2020 11:59:06 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 1/2] RDMA/hns: Optimize mhop get flow for multi-hop addressing
Date:   Tue, 17 Mar 2020 11:55:23 +0800
Message-ID: <1584417324-2255-2-git-send-email-liweihang@huawei.com>
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

Splits hns_roce_table_mhop_get() into 4 sub-functions to make the code flow
clearer.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hem.c | 297 +++++++++++++++++++------------
 1 file changed, 182 insertions(+), 115 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.c b/drivers/infiniband/hw/hns/hns_roce_hem.c
index 8380d71..cc557f1 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.c
@@ -39,6 +39,16 @@
 #define DMA_ADDR_T_SHIFT		12
 #define BT_BA_SHIFT			32
 
+#define HEM_INDEX_BUF			BIT(0)
+#define HEM_INDEX_L0			BIT(1)
+#define HEM_INDEX_L1			BIT(2)
+struct hns_roce_hem_index {
+	u64 buf;
+	u64 l0;
+	u64 l1;
+	u32 inited; /* indicate which index is available */
+};
+
 bool hns_roce_check_whether_mhop(struct hns_roce_dev *hr_dev, u32 type)
 {
 	int hop_num = 0;
@@ -434,178 +444,235 @@ static int hns_roce_set_hem(struct hns_roce_dev *hr_dev,
 	return ret;
 }
 
-static int hns_roce_table_mhop_get(struct hns_roce_dev *hr_dev,
-				   struct hns_roce_hem_table *table,
-				   unsigned long obj)
+static int calc_hem_config(struct hns_roce_dev *hr_dev,
+			   struct hns_roce_hem_table *table, unsigned long obj,
+			   struct hns_roce_hem_mhop *mhop,
+			   struct hns_roce_hem_index *index)
 {
-	struct device *dev = hr_dev->dev;
-	struct hns_roce_hem_mhop mhop;
-	struct hns_roce_hem_iter iter;
-	u32 buf_chunk_size;
-	u32 bt_chunk_size;
+	struct ib_device *ibdev = &hr_dev->ib_dev;
+	unsigned long mhop_obj = obj;
+	u32 l0_idx, l1_idx, l2_idx;
 	u32 chunk_ba_num;
-	u32 hop_num;
-	u32 size;
 	u32 bt_num;
-	u64 hem_idx;
-	u64 bt_l1_idx = 0;
-	u64 bt_l0_idx = 0;
-	u64 bt_ba;
-	unsigned long mhop_obj = obj;
-	int bt_l1_allocated = 0;
-	int bt_l0_allocated = 0;
-	int step_idx;
 	int ret;
 
-	ret = hns_roce_calc_hem_mhop(hr_dev, table, &mhop_obj, &mhop);
+	ret = hns_roce_calc_hem_mhop(hr_dev, table, &mhop_obj, mhop);
 	if (ret)
 		return ret;
 
-	buf_chunk_size = mhop.buf_chunk_size;
-	bt_chunk_size = mhop.bt_chunk_size;
-	hop_num = mhop.hop_num;
-	chunk_ba_num = bt_chunk_size / BA_BYTE_LEN;
-
-	bt_num = hns_roce_get_bt_num(table->type, hop_num);
+	l0_idx = mhop->l0_idx;
+	l1_idx = mhop->l1_idx;
+	l2_idx = mhop->l2_idx;
+	chunk_ba_num = mhop->bt_chunk_size / BA_BYTE_LEN;
+	bt_num = hns_roce_get_bt_num(table->type, mhop->hop_num);
 	switch (bt_num) {
 	case 3:
-		hem_idx = mhop.l0_idx * chunk_ba_num * chunk_ba_num +
-			  mhop.l1_idx * chunk_ba_num + mhop.l2_idx;
-		bt_l1_idx = mhop.l0_idx * chunk_ba_num + mhop.l1_idx;
-		bt_l0_idx = mhop.l0_idx;
+		index->l1 = l0_idx * chunk_ba_num + l1_idx;
+		index->l0 = l0_idx;
+		index->buf = l0_idx * chunk_ba_num * chunk_ba_num +
+			     l1_idx * chunk_ba_num + l2_idx;
 		break;
 	case 2:
-		hem_idx = mhop.l0_idx * chunk_ba_num + mhop.l1_idx;
-		bt_l0_idx = mhop.l0_idx;
+		index->l0 = l0_idx;
+		index->buf = l0_idx * chunk_ba_num + l1_idx;
 		break;
 	case 1:
-		hem_idx = mhop.l0_idx;
+		index->buf = l0_idx;
 		break;
 	default:
-		dev_err(dev, "Table %d not support hop_num = %d!\n",
-			     table->type, hop_num);
+		ibdev_err(ibdev, "Table %d not support mhop.hop_num = %d!\n",
+			  table->type, mhop->hop_num);
 		return -EINVAL;
 	}
 
-	if (unlikely(hem_idx >= table->num_hem)) {
-		dev_err(dev, "Table %d exceed hem limt idx = %llu,max = %lu!\n",
-			     table->type, hem_idx, table->num_hem);
+	if (unlikely(index->buf >= table->num_hem)) {
+		ibdev_err(ibdev, "Table %d exceed hem limt idx %llu,max %lu!\n",
+			  table->type, index->buf, table->num_hem);
 		return -EINVAL;
 	}
 
-	mutex_lock(&table->mutex);
+	return 0;
+}
 
-	if (table->hem[hem_idx]) {
-		++table->hem[hem_idx]->refcount;
-		goto out;
+static void free_mhop_hem(struct hns_roce_dev *hr_dev,
+			  struct hns_roce_hem_table *table,
+			  struct hns_roce_hem_mhop *mhop,
+			  struct hns_roce_hem_index *index)
+{
+	u32 bt_size = mhop->bt_chunk_size;
+	struct device *dev = hr_dev->dev;
+
+	if (index->inited & HEM_INDEX_BUF) {
+		hns_roce_free_hem(hr_dev, table->hem[index->buf]);
+		table->hem[index->buf] = NULL;
+	}
+
+	if (index->inited & HEM_INDEX_L1) {
+		dma_free_coherent(dev, bt_size, table->bt_l1[index->l1],
+				  table->bt_l1_dma_addr[index->l1]);
+		table->bt_l1[index->l1] = NULL;
 	}
 
+	if (index->inited & HEM_INDEX_L0) {
+		dma_free_coherent(dev, bt_size, table->bt_l0[index->l0],
+				  table->bt_l0_dma_addr[index->l0]);
+		table->bt_l0[index->l0] = NULL;
+	}
+}
+
+static int alloc_mhop_hem(struct hns_roce_dev *hr_dev,
+			  struct hns_roce_hem_table *table,
+			  struct hns_roce_hem_mhop *mhop,
+			  struct hns_roce_hem_index *index)
+{
+	u32 bt_size = mhop->bt_chunk_size;
+	struct device *dev = hr_dev->dev;
+	struct hns_roce_hem_iter iter;
+	gfp_t flag;
+	u64 bt_ba;
+	u32 size;
+	int ret;
+
 	/* alloc L1 BA's chunk */
-	if ((check_whether_bt_num_3(table->type, hop_num) ||
-		check_whether_bt_num_2(table->type, hop_num)) &&
-		!table->bt_l0[bt_l0_idx]) {
-		table->bt_l0[bt_l0_idx] = dma_alloc_coherent(dev, bt_chunk_size,
-					    &(table->bt_l0_dma_addr[bt_l0_idx]),
+	if ((check_whether_bt_num_3(table->type, mhop->hop_num) ||
+	     check_whether_bt_num_2(table->type, mhop->hop_num)) &&
+	     !table->bt_l0[index->l0]) {
+		table->bt_l0[index->l0] = dma_alloc_coherent(dev, bt_size,
+					    &table->bt_l0_dma_addr[index->l0],
 					    GFP_KERNEL);
-		if (!table->bt_l0[bt_l0_idx]) {
+		if (!table->bt_l0[index->l0]) {
 			ret = -ENOMEM;
 			goto out;
 		}
-		bt_l0_allocated = 1;
-
-		/* set base address to hardware */
-		if (table->type < HEM_TYPE_MTT) {
-			step_idx = 0;
-			if (hr_dev->hw->set_hem(hr_dev, table, obj, step_idx)) {
-				ret = -ENODEV;
-				dev_err(dev, "set HEM base address to HW failed!\n");
-				goto err_dma_alloc_l1;
-			}
-		}
+		index->inited |= HEM_INDEX_L0;
 	}
 
 	/* alloc L2 BA's chunk */
-	if (check_whether_bt_num_3(table->type, hop_num) &&
-	    !table->bt_l1[bt_l1_idx])  {
-		table->bt_l1[bt_l1_idx] = dma_alloc_coherent(dev, bt_chunk_size,
-					    &(table->bt_l1_dma_addr[bt_l1_idx]),
+	if (check_whether_bt_num_3(table->type, mhop->hop_num) &&
+	    !table->bt_l1[index->l1])  {
+		table->bt_l1[index->l1] = dma_alloc_coherent(dev, bt_size,
+					    &table->bt_l1_dma_addr[index->l1],
 					    GFP_KERNEL);
-		if (!table->bt_l1[bt_l1_idx]) {
+		if (!table->bt_l1[index->l1]) {
 			ret = -ENOMEM;
-			goto err_dma_alloc_l1;
-		}
-		bt_l1_allocated = 1;
-		*(table->bt_l0[bt_l0_idx] + mhop.l1_idx) =
-					       table->bt_l1_dma_addr[bt_l1_idx];
-
-		/* set base address to hardware */
-		step_idx = 1;
-		if (hr_dev->hw->set_hem(hr_dev, table, obj, step_idx)) {
-			ret = -ENODEV;
-			dev_err(dev, "set HEM base address to HW failed!\n");
-			goto err_alloc_hem_buf;
+			goto err_alloc_hem;
 		}
+		index->inited |= HEM_INDEX_L1;
+		*(table->bt_l0[index->l0] + mhop->l1_idx) =
+					       table->bt_l1_dma_addr[index->l1];
 	}
 
 	/*
 	 * alloc buffer space chunk for QPC/MTPT/CQC/SRQC/SCCC.
 	 * alloc bt space chunk for MTT/CQE.
 	 */
-	size = table->type < HEM_TYPE_MTT ? buf_chunk_size : bt_chunk_size;
-	table->hem[hem_idx] = hns_roce_alloc_hem(hr_dev,
-						size >> PAGE_SHIFT,
-						size,
-						(table->lowmem ? GFP_KERNEL :
-						GFP_HIGHUSER) | __GFP_NOWARN);
-	if (!table->hem[hem_idx]) {
+	size = table->type < HEM_TYPE_MTT ? mhop->buf_chunk_size : bt_size;
+	flag = (table->lowmem ? GFP_KERNEL : GFP_HIGHUSER) | __GFP_NOWARN;
+	table->hem[index->buf] = hns_roce_alloc_hem(hr_dev, size >> PAGE_SHIFT,
+						    size, flag);
+	if (!table->hem[index->buf]) {
 		ret = -ENOMEM;
-		goto err_alloc_hem_buf;
+		goto err_alloc_hem;
 	}
 
-	hns_roce_hem_first(table->hem[hem_idx], &iter);
+	index->inited |= HEM_INDEX_BUF;
+	hns_roce_hem_first(table->hem[index->buf], &iter);
 	bt_ba = hns_roce_hem_addr(&iter);
-
 	if (table->type < HEM_TYPE_MTT) {
-		if (hop_num == 2) {
-			*(table->bt_l1[bt_l1_idx] + mhop.l2_idx) = bt_ba;
-			step_idx = 2;
-		} else if (hop_num == 1) {
-			*(table->bt_l0[bt_l0_idx] + mhop.l1_idx) = bt_ba;
-			step_idx = 1;
-		} else if (hop_num == HNS_ROCE_HOP_NUM_0) {
-			step_idx = 0;
-		} else {
-			ret = -EINVAL;
-			goto err_dma_alloc_l1;
+		if (mhop->hop_num == 2)
+			*(table->bt_l1[index->l1] + mhop->l2_idx) = bt_ba;
+		else if (mhop->hop_num == 1)
+			*(table->bt_l0[index->l0] + mhop->l1_idx) = bt_ba;
+	} else if (mhop->hop_num == 2) {
+		*(table->bt_l0[index->l0] + mhop->l1_idx) = bt_ba;
+	}
+
+	return 0;
+err_alloc_hem:
+	free_mhop_hem(hr_dev, table, mhop, index);
+out:
+	return ret;
+}
+
+static int set_mhop_hem(struct hns_roce_dev *hr_dev,
+			struct hns_roce_hem_table *table, unsigned long obj,
+			struct hns_roce_hem_mhop *mhop,
+			struct hns_roce_hem_index *index)
+{
+	struct ib_device *ibdev = &hr_dev->ib_dev;
+	int step_idx;
+	int ret;
+
+	if (index->inited & HEM_INDEX_L0) {
+		ret = hr_dev->hw->set_hem(hr_dev, table, obj, 0);
+		if (ret) {
+			ibdev_err(ibdev, "set HEM step 0 failed!\n");
+			goto out;
 		}
+	}
 
-		/* set HEM base address to hardware */
-		if (hr_dev->hw->set_hem(hr_dev, table, obj, step_idx)) {
-			ret = -ENODEV;
-			dev_err(dev, "set HEM base address to HW failed!\n");
-			goto err_alloc_hem_buf;
+	if (index->inited & HEM_INDEX_L1) {
+		ret = hr_dev->hw->set_hem(hr_dev, table, obj, 1);
+		if (ret) {
+			ibdev_err(ibdev, "set HEM step 1 failed!\n");
+			goto out;
 		}
-	} else if (hop_num == 2) {
-		*(table->bt_l0[bt_l0_idx] + mhop.l1_idx) = bt_ba;
 	}
 
-	++table->hem[hem_idx]->refcount;
-	goto out;
+	if (index->inited & HEM_INDEX_BUF) {
+		if (mhop->hop_num == HNS_ROCE_HOP_NUM_0)
+			step_idx = 0;
+		else
+			step_idx = mhop->hop_num;
+		ret = hr_dev->hw->set_hem(hr_dev, table, obj, step_idx);
+		if (ret)
+			ibdev_err(ibdev, "set HEM step last failed!\n");
+	}
+out:
+	return ret;
+}
 
-err_alloc_hem_buf:
-	if (bt_l1_allocated) {
-		dma_free_coherent(dev, bt_chunk_size, table->bt_l1[bt_l1_idx],
-				  table->bt_l1_dma_addr[bt_l1_idx]);
-		table->bt_l1[bt_l1_idx] = NULL;
+static int hns_roce_table_mhop_get(struct hns_roce_dev *hr_dev,
+				   struct hns_roce_hem_table *table,
+				   unsigned long obj)
+{
+	struct ib_device *ibdev = &hr_dev->ib_dev;
+	struct hns_roce_hem_index index = {};
+	struct hns_roce_hem_mhop mhop = {};
+	int ret;
+
+	ret = calc_hem_config(hr_dev, table, obj, &mhop, &index);
+	if (ret) {
+		ibdev_err(ibdev, "calc hem config failed!\n");
+		return ret;
 	}
 
-err_dma_alloc_l1:
-	if (bt_l0_allocated) {
-		dma_free_coherent(dev, bt_chunk_size, table->bt_l0[bt_l0_idx],
-				  table->bt_l0_dma_addr[bt_l0_idx]);
-		table->bt_l0[bt_l0_idx] = NULL;
+	mutex_lock(&table->mutex);
+	if (table->hem[index.buf]) {
+		++table->hem[index.buf]->refcount;
+		goto out;
+	}
+
+	ret = alloc_mhop_hem(hr_dev, table, &mhop, &index);
+	if (ret) {
+		ibdev_err(ibdev, "alloc mhop hem failed!\n");
+		goto out;
+	}
+
+	/* set HEM base address to hardware */
+	if (table->type < HEM_TYPE_MTT) {
+		ret = set_mhop_hem(hr_dev, table, obj, &mhop, &index);
+		if (ret) {
+			ibdev_err(ibdev, "set HEM address to HW failed!\n");
+			goto err_alloc;
+		}
 	}
 
+	++table->hem[index.buf]->refcount;
+	goto out;
+
+err_alloc:
+	free_mhop_hem(hr_dev, table, &mhop, &index);
 out:
 	mutex_unlock(&table->mutex);
 	return ret;
-- 
2.8.1

