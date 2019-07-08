Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7AEF61FB9
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2019 15:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731412AbfGHNo5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 8 Jul 2019 09:44:57 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2179 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731411AbfGHNo4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 8 Jul 2019 09:44:56 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 63EF4F42B35A99190A5E;
        Mon,  8 Jul 2019 21:44:49 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Mon, 8 Jul 2019 21:44:40 +0800
From:   Lijun Ou <oulijun@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 6/9] RDMA/hns: Optimize hns_roce_mhop_alloc function.
Date:   Mon, 8 Jul 2019 21:41:22 +0800
Message-ID: <1562593285-8037-7-git-send-email-oulijun@huawei.com>
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

From: chenglang <chenglang@huawei.com>

Here packages some lines for allocating multi-hop addressing
into the independent functions in order to add the readability.

Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Lijun Ou <oulijun@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_mr.c | 275 +++++++++++++++++++-------------
 1 file changed, 160 insertions(+), 115 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index 549e1a3..c4b758c 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -347,155 +347,208 @@ static void hns_roce_loop_free(struct hns_roce_dev *hr_dev,
 	mr->pbl_bt_l0 = NULL;
 	mr->pbl_l0_dma_addr = 0;
 }
+static int pbl_1hop_alloc(struct hns_roce_dev *hr_dev, int npages,
+			       struct hns_roce_mr *mr, u32 pbl_bt_sz)
+{
+	struct device *dev = hr_dev->dev;
 
-/* PBL multi hop addressing */
-static int hns_roce_mhop_alloc(struct hns_roce_dev *hr_dev, int npages,
-			       struct hns_roce_mr *mr)
+	if (npages > pbl_bt_sz / 8) {
+		dev_err(dev, "npages %d is larger than buf_pg_sz!",
+			npages);
+		return -EINVAL;
+	}
+	mr->pbl_buf = dma_alloc_coherent(dev, npages * 8,
+					 &(mr->pbl_dma_addr),
+					 GFP_KERNEL);
+	if (!mr->pbl_buf)
+		return -ENOMEM;
+
+	mr->pbl_size = npages;
+	mr->pbl_ba = mr->pbl_dma_addr;
+	mr->pbl_hop_num = 1;
+	mr->pbl_ba_pg_sz = hr_dev->caps.pbl_ba_pg_sz;
+	mr->pbl_buf_pg_sz = hr_dev->caps.pbl_buf_pg_sz;
+	return 0;
+
+}
+
+
+static int pbl_2hop_alloc(struct hns_roce_dev *hr_dev, int npages,
+			       struct hns_roce_mr *mr, u32 pbl_bt_sz)
 {
 	struct device *dev = hr_dev->dev;
-	int mr_alloc_done = 0;
 	int npages_allocated;
-	int i = 0, j = 0;
-	u32 pbl_bt_sz;
-	u32 mhop_num;
 	u64 pbl_last_bt_num;
 	u64 pbl_bt_cnt = 0;
-	u64 bt_idx;
 	u64 size;
+	int i;
 
-	mhop_num = (mr->type == MR_TYPE_FRMR ? 1 : hr_dev->caps.pbl_hop_num);
-	pbl_bt_sz = 1 << (hr_dev->caps.pbl_ba_pg_sz + PAGE_SHIFT);
 	pbl_last_bt_num = (npages + pbl_bt_sz / 8 - 1) / (pbl_bt_sz / 8);
 
-	if (mhop_num == HNS_ROCE_HOP_NUM_0)
-		return 0;
-
-	/* hop_num = 1 */
-	if (mhop_num == 1) {
-		if (npages > pbl_bt_sz / 8) {
-			dev_err(dev, "npages %d is larger than buf_pg_sz!",
-				npages);
-			return -EINVAL;
+	/* alloc L1 BT */
+	for (i = 0; i < pbl_bt_sz / 8; i++) {
+		if (pbl_bt_cnt + 1 < pbl_last_bt_num) {
+			size = pbl_bt_sz;
+		} else {
+			npages_allocated = i * (pbl_bt_sz / 8);
+			size = (npages - npages_allocated) * 8;
 		}
-		mr->pbl_buf = dma_alloc_coherent(dev, npages * 8,
-						 &(mr->pbl_dma_addr),
-						 GFP_KERNEL);
-		if (!mr->pbl_buf)
+		mr->pbl_bt_l1[i] = dma_alloc_coherent(dev, size,
+					    &(mr->pbl_l1_dma_addr[i]),
+					    GFP_KERNEL);
+		if (!mr->pbl_bt_l1[i]) {
+			hns_roce_loop_free(hr_dev, mr, 1, i, 0);
 			return -ENOMEM;
+		}
 
-		mr->pbl_size = npages;
-		mr->pbl_ba = mr->pbl_dma_addr;
-		mr->pbl_hop_num = mhop_num;
-		mr->pbl_ba_pg_sz = hr_dev->caps.pbl_ba_pg_sz;
-		mr->pbl_buf_pg_sz = hr_dev->caps.pbl_buf_pg_sz;
-		return 0;
+		*(mr->pbl_bt_l0 + i) = mr->pbl_l1_dma_addr[i];
+
+		pbl_bt_cnt++;
+		if (pbl_bt_cnt >= pbl_last_bt_num)
+			break;
 	}
 
-	mr->pbl_l1_dma_addr = kcalloc(pbl_bt_sz / 8,
-				      sizeof(*mr->pbl_l1_dma_addr),
+	mr->l0_chunk_last_num = i + 1;
+
+	return 0;
+}
+
+static int pbl_3hop_alloc(struct hns_roce_dev *hr_dev, int npages,
+			       struct hns_roce_mr *mr, u32 pbl_bt_sz)
+{
+	struct device *dev = hr_dev->dev;
+	int mr_alloc_done = 0;
+	int npages_allocated;
+	u64 pbl_last_bt_num;
+	u64 pbl_bt_cnt = 0;
+	u64 bt_idx;
+	u64 size;
+	int i;
+	int j = 0;
+
+	pbl_last_bt_num = (npages + pbl_bt_sz / 8 - 1) / (pbl_bt_sz / 8);
+
+	mr->pbl_l2_dma_addr = kcalloc(pbl_last_bt_num,
+				      sizeof(*mr->pbl_l2_dma_addr),
 				      GFP_KERNEL);
-	if (!mr->pbl_l1_dma_addr)
+	if (!mr->pbl_l2_dma_addr)
 		return -ENOMEM;
 
-	mr->pbl_bt_l1 = kcalloc(pbl_bt_sz / 8, sizeof(*mr->pbl_bt_l1),
+	mr->pbl_bt_l2 = kcalloc(pbl_last_bt_num,
+				sizeof(*mr->pbl_bt_l2),
 				GFP_KERNEL);
-	if (!mr->pbl_bt_l1)
-		goto err_kcalloc_bt_l1;
-
-	if (mhop_num == 3) {
-		mr->pbl_l2_dma_addr = kcalloc(pbl_last_bt_num,
-					      sizeof(*mr->pbl_l2_dma_addr),
-					      GFP_KERNEL);
-		if (!mr->pbl_l2_dma_addr)
-			goto err_kcalloc_l2_dma;
+	if (!mr->pbl_bt_l2)
+		goto err_kcalloc_bt_l2;
+
+	/* alloc L1, L2 BT */
+	for (i = 0; i < pbl_bt_sz / 8; i++) {
+		mr->pbl_bt_l1[i] = dma_alloc_coherent(dev, pbl_bt_sz,
+					    &(mr->pbl_l1_dma_addr[i]),
+					    GFP_KERNEL);
+		if (!mr->pbl_bt_l1[i]) {
+			hns_roce_loop_free(hr_dev, mr, 1, i, 0);
+			goto err_dma_alloc_l0;
+		}
 
-		mr->pbl_bt_l2 = kcalloc(pbl_last_bt_num,
-					sizeof(*mr->pbl_bt_l2),
-					GFP_KERNEL);
-		if (!mr->pbl_bt_l2)
-			goto err_kcalloc_bt_l2;
-	}
+		*(mr->pbl_bt_l0 + i) = mr->pbl_l1_dma_addr[i];
 
-	/* alloc L0 BT */
-	mr->pbl_bt_l0 = dma_alloc_coherent(dev, pbl_bt_sz,
-					   &(mr->pbl_l0_dma_addr),
-					   GFP_KERNEL);
-	if (!mr->pbl_bt_l0)
-		goto err_dma_alloc_l0;
+		for (j = 0; j < pbl_bt_sz / 8; j++) {
+			bt_idx = i * pbl_bt_sz / 8 + j;
 
-	if (mhop_num == 2) {
-		/* alloc L1 BT */
-		for (i = 0; i < pbl_bt_sz / 8; i++) {
 			if (pbl_bt_cnt + 1 < pbl_last_bt_num) {
 				size = pbl_bt_sz;
 			} else {
-				npages_allocated = i * (pbl_bt_sz / 8);
+				npages_allocated = bt_idx *
+						   (pbl_bt_sz / 8);
 				size = (npages - npages_allocated) * 8;
 			}
-			mr->pbl_bt_l1[i] = dma_alloc_coherent(dev, size,
-						    &(mr->pbl_l1_dma_addr[i]),
-						    GFP_KERNEL);
-			if (!mr->pbl_bt_l1[i]) {
-				hns_roce_loop_free(hr_dev, mr, 1, i, 0);
+			mr->pbl_bt_l2[bt_idx] = dma_alloc_coherent(
+				      dev, size,
+				      &(mr->pbl_l2_dma_addr[bt_idx]),
+				      GFP_KERNEL);
+			if (!mr->pbl_bt_l2[bt_idx]) {
+				hns_roce_loop_free(hr_dev, mr, 2, i, j);
 				goto err_dma_alloc_l0;
 			}
 
-			*(mr->pbl_bt_l0 + i) = mr->pbl_l1_dma_addr[i];
+			*(mr->pbl_bt_l1[i] + j) =
+					mr->pbl_l2_dma_addr[bt_idx];
 
 			pbl_bt_cnt++;
-			if (pbl_bt_cnt >= pbl_last_bt_num)
+			if (pbl_bt_cnt >= pbl_last_bt_num) {
+				mr_alloc_done = 1;
 				break;
-		}
-	} else if (mhop_num == 3) {
-		/* alloc L1, L2 BT */
-		for (i = 0; i < pbl_bt_sz / 8; i++) {
-			mr->pbl_bt_l1[i] = dma_alloc_coherent(dev, pbl_bt_sz,
-						    &(mr->pbl_l1_dma_addr[i]),
-						    GFP_KERNEL);
-			if (!mr->pbl_bt_l1[i]) {
-				hns_roce_loop_free(hr_dev, mr, 1, i, 0);
-				goto err_dma_alloc_l0;
 			}
+		}
 
-			*(mr->pbl_bt_l0 + i) = mr->pbl_l1_dma_addr[i];
+		if (mr_alloc_done)
+			break;
+	}
 
-			for (j = 0; j < pbl_bt_sz / 8; j++) {
-				bt_idx = i * pbl_bt_sz / 8 + j;
+	mr->l0_chunk_last_num = i + 1;
+	mr->l1_chunk_last_num = j + 1;
 
-				if (pbl_bt_cnt + 1 < pbl_last_bt_num) {
-					size = pbl_bt_sz;
-				} else {
-					npages_allocated = bt_idx *
-							   (pbl_bt_sz / 8);
-					size = (npages - npages_allocated) * 8;
-				}
-				mr->pbl_bt_l2[bt_idx] = dma_alloc_coherent(
-					      dev, size,
-					      &(mr->pbl_l2_dma_addr[bt_idx]),
-					      GFP_KERNEL);
-				if (!mr->pbl_bt_l2[bt_idx]) {
-					hns_roce_loop_free(hr_dev, mr, 2, i, j);
-					goto err_dma_alloc_l0;
-				}
 
-				*(mr->pbl_bt_l1[i] + j) =
-						mr->pbl_l2_dma_addr[bt_idx];
+	return 0;
 
-				pbl_bt_cnt++;
-				if (pbl_bt_cnt >= pbl_last_bt_num) {
-					mr_alloc_done = 1;
-					break;
-				}
-			}
+err_dma_alloc_l0:
+	kfree(mr->pbl_bt_l2);
+	mr->pbl_bt_l2 = NULL;
 
-			if (mr_alloc_done)
-				break;
-		}
+err_kcalloc_bt_l2:
+	kfree(mr->pbl_l2_dma_addr);
+	mr->pbl_l2_dma_addr = NULL;
+
+	return -ENOMEM;
+}
+
+
+/* PBL multi hop addressing */
+static int hns_roce_mhop_alloc(struct hns_roce_dev *hr_dev, int npages,
+			       struct hns_roce_mr *mr)
+{
+	struct device *dev = hr_dev->dev;
+	u32 pbl_bt_sz;
+	u32 mhop_num;
+
+	mhop_num = (mr->type == MR_TYPE_FRMR ? 1 : hr_dev->caps.pbl_hop_num);
+	pbl_bt_sz = 1 << (hr_dev->caps.pbl_ba_pg_sz + PAGE_SHIFT);
+
+	if (mhop_num == HNS_ROCE_HOP_NUM_0)
+		return 0;
+
+	/* hop_num = 1 */
+	if (mhop_num == 1)
+		return pbl_1hop_alloc(hr_dev, npages, mr, pbl_bt_sz);
+
+	mr->pbl_l1_dma_addr = kcalloc(pbl_bt_sz / 8,
+				      sizeof(*mr->pbl_l1_dma_addr),
+				      GFP_KERNEL);
+	if (!mr->pbl_l1_dma_addr)
+		return -ENOMEM;
+
+	mr->pbl_bt_l1 = kcalloc(pbl_bt_sz / 8, sizeof(*mr->pbl_bt_l1),
+				GFP_KERNEL);
+	if (!mr->pbl_bt_l1)
+		goto err_kcalloc_bt_l1;
+
+	/* alloc L0 BT */
+	mr->pbl_bt_l0 = dma_alloc_coherent(dev, pbl_bt_sz,
+					   &(mr->pbl_l0_dma_addr),
+					   GFP_KERNEL);
+	if (!mr->pbl_bt_l0)
+		goto err_kcalloc_l2_dma;
+
+	if (mhop_num == 2) {
+		if (pbl_2hop_alloc(hr_dev, npages, mr, pbl_bt_sz))
+			goto err_kcalloc_l2_dma;
+	}
+
+	if (mhop_num == 3) {
+		if (pbl_3hop_alloc(hr_dev, npages, mr, pbl_bt_sz))
+			goto err_kcalloc_l2_dma;
 	}
 
-	mr->l0_chunk_last_num = i + 1;
-	if (mhop_num == 3)
-		mr->l1_chunk_last_num = j + 1;
 
 	mr->pbl_size = npages;
 	mr->pbl_ba = mr->pbl_l0_dma_addr;
@@ -505,14 +558,6 @@ static int hns_roce_mhop_alloc(struct hns_roce_dev *hr_dev, int npages,
 
 	return 0;
 
-err_dma_alloc_l0:
-	kfree(mr->pbl_bt_l2);
-	mr->pbl_bt_l2 = NULL;
-
-err_kcalloc_bt_l2:
-	kfree(mr->pbl_l2_dma_addr);
-	mr->pbl_l2_dma_addr = NULL;
-
 err_kcalloc_l2_dma:
 	kfree(mr->pbl_bt_l1);
 	mr->pbl_bt_l1 = NULL;
-- 
1.9.1

