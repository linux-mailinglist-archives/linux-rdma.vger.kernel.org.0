Return-Path: <linux-rdma+bounces-619-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EED82CAA8
	for <lists+linux-rdma@lfdr.de>; Sat, 13 Jan 2024 10:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C2BD1F22D63
	for <lists+linux-rdma@lfdr.de>; Sat, 13 Jan 2024 09:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493DA1EEEF;
	Sat, 13 Jan 2024 09:03:37 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D427E8;
	Sat, 13 Jan 2024 09:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TBsps4YxNz2LXJg;
	Sat, 13 Jan 2024 17:01:57 +0800 (CST)
Received: from kwepemi500006.china.huawei.com (unknown [7.221.188.68])
	by mail.maildlp.com (Postfix) with ESMTPS id F247B1A0190;
	Sat, 13 Jan 2024 17:03:31 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 13 Jan 2024 17:03:31 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH v2 for-next 6/6] RDMA/hns: Simplify 'struct hns_roce_hem' allocation
Date: Sat, 13 Jan 2024 16:59:35 +0800
Message-ID: <20240113085935.2838701-7-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240113085935.2838701-1-huangjunxian6@hisilicon.com>
References: <20240113085935.2838701-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500006.china.huawei.com (7.221.188.68)

From: Yunsheng Lin <linyunsheng@huawei.com>

'struct hns_roce_hem' is used to refer to the last level of
dma buffer managed by the hw, pointed by a single BA(base
address) in the previous level of BT(base table), so the dma
buffer in 'struct hns_roce_hem' must be contiguous.

Right now the size of dma buffer in 'struct hns_roce_hem' is
decided by mhop->buf_chunk_size in get_hem_table_config(),
which ensure the mhop->buf_chunk_size is power of two of
PAGE_SIZE, so there will be only one contiguous dma buffer
allocated in hns_roce_alloc_hem(), which means hem->chunk_list
and chunk->mem for linking multi dma buffers is unnecessary.

This patch removes the hem->chunk_list and chunk->mem and other
related macro and function accordingly.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_hem.c   | 95 +++++-----------------
 drivers/infiniband/hw/hns/hns_roce_hem.h   | 56 +------------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c |  9 +-
 3 files changed, 24 insertions(+), 136 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.c b/drivers/infiniband/hw/hns/hns_roce_hem.c
index c4ac06a33869..a4b3f19161dc 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.c
@@ -249,61 +249,34 @@ int hns_roce_calc_hem_mhop(struct hns_roce_dev *hr_dev,
 }
 
 static struct hns_roce_hem *hns_roce_alloc_hem(struct hns_roce_dev *hr_dev,
-					       int npages,
 					       unsigned long hem_alloc_size,
 					       gfp_t gfp_mask)
 {
-	struct hns_roce_hem_chunk *chunk = NULL;
 	struct hns_roce_hem *hem;
-	struct scatterlist *mem;
 	int order;
 	void *buf;
 
 	WARN_ON(gfp_mask & __GFP_HIGHMEM);
 
+	order = get_order(hem_alloc_size);
+	if (PAGE_SIZE << order != hem_alloc_size) {
+		dev_err(hr_dev->dev, "invalid hem_alloc_size: %lu!\n",
+			hem_alloc_size);
+		return NULL;
+	}
+
 	hem = kmalloc(sizeof(*hem),
 		      gfp_mask & ~(__GFP_HIGHMEM | __GFP_NOWARN));
 	if (!hem)
 		return NULL;
 
-	INIT_LIST_HEAD(&hem->chunk_list);
-
-	order = get_order(hem_alloc_size);
-
-	while (npages > 0) {
-		if (!chunk) {
-			chunk = kmalloc(sizeof(*chunk),
-				gfp_mask & ~(__GFP_HIGHMEM | __GFP_NOWARN));
-			if (!chunk)
-				goto fail;
-
-			sg_init_table(chunk->mem, HNS_ROCE_HEM_CHUNK_LEN);
-			chunk->npages = 0;
-			chunk->nsg = 0;
-			memset(chunk->buf, 0, sizeof(chunk->buf));
-			list_add_tail(&chunk->list, &hem->chunk_list);
-		}
+	buf = dma_alloc_coherent(hr_dev->dev, hem_alloc_size,
+				 &hem->dma, gfp_mask);
+	if (!buf)
+		goto fail;
 
-		while (1 << order > npages)
-			--order;
-
-		/*
-		 * Alloc memory one time. If failed, don't alloc small block
-		 * memory, directly return fail.
-		 */
-		mem = &chunk->mem[chunk->npages];
-		buf = dma_alloc_coherent(hr_dev->dev, PAGE_SIZE << order,
-				&sg_dma_address(mem), gfp_mask);
-		if (!buf)
-			goto fail;
-
-		chunk->buf[chunk->npages] = buf;
-		sg_dma_len(mem) = PAGE_SIZE << order;
-
-		++chunk->npages;
-		++chunk->nsg;
-		npages -= 1 << order;
-	}
+	hem->buf = buf;
+	hem->size = hem_alloc_size;
 
 	return hem;
 
@@ -314,20 +287,10 @@ static struct hns_roce_hem *hns_roce_alloc_hem(struct hns_roce_dev *hr_dev,
 
 void hns_roce_free_hem(struct hns_roce_dev *hr_dev, struct hns_roce_hem *hem)
 {
-	struct hns_roce_hem_chunk *chunk, *tmp;
-	int i;
-
 	if (!hem)
 		return;
 
-	list_for_each_entry_safe(chunk, tmp, &hem->chunk_list, list) {
-		for (i = 0; i < chunk->npages; ++i)
-			dma_free_coherent(hr_dev->dev,
-				   sg_dma_len(&chunk->mem[i]),
-				   chunk->buf[i],
-				   sg_dma_address(&chunk->mem[i]));
-		kfree(chunk);
-	}
+	dma_free_coherent(hr_dev->dev, hem->size, hem->buf, hem->dma);
 
 	kfree(hem);
 }
@@ -415,7 +378,6 @@ static int alloc_mhop_hem(struct hns_roce_dev *hr_dev,
 {
 	u32 bt_size = mhop->bt_chunk_size;
 	struct device *dev = hr_dev->dev;
-	struct hns_roce_hem_iter iter;
 	gfp_t flag;
 	u64 bt_ba;
 	u32 size;
@@ -456,16 +418,15 @@ static int alloc_mhop_hem(struct hns_roce_dev *hr_dev,
 	 */
 	size = table->type < HEM_TYPE_MTT ? mhop->buf_chunk_size : bt_size;
 	flag = GFP_KERNEL | __GFP_NOWARN;
-	table->hem[index->buf] = hns_roce_alloc_hem(hr_dev, size >> PAGE_SHIFT,
-						    size, flag);
+	table->hem[index->buf] = hns_roce_alloc_hem(hr_dev, size, flag);
 	if (!table->hem[index->buf]) {
 		ret = -ENOMEM;
 		goto err_alloc_hem;
 	}
 
 	index->inited |= HEM_INDEX_BUF;
-	hns_roce_hem_first(table->hem[index->buf], &iter);
-	bt_ba = hns_roce_hem_addr(&iter);
+	bt_ba = table->hem[index->buf]->dma;
+
 	if (table->type < HEM_TYPE_MTT) {
 		if (mhop->hop_num == 2)
 			*(table->bt_l1[index->l1] + mhop->l2_idx) = bt_ba;
@@ -586,7 +547,6 @@ int hns_roce_table_get(struct hns_roce_dev *hr_dev,
 	}
 
 	table->hem[i] = hns_roce_alloc_hem(hr_dev,
-				       table->table_chunk_size >> PAGE_SHIFT,
 				       table->table_chunk_size,
 				       GFP_KERNEL | __GFP_NOWARN);
 	if (!table->hem[i]) {
@@ -725,7 +685,6 @@ void *hns_roce_table_find(struct hns_roce_dev *hr_dev,
 			  struct hns_roce_hem_table *table,
 			  unsigned long obj, dma_addr_t *dma_handle)
 {
-	struct hns_roce_hem_chunk *chunk;
 	struct hns_roce_hem_mhop mhop;
 	struct hns_roce_hem *hem;
 	unsigned long mhop_obj = obj;
@@ -734,7 +693,6 @@ void *hns_roce_table_find(struct hns_roce_dev *hr_dev,
 	int offset, dma_offset;
 	void *addr = NULL;
 	u32 hem_idx = 0;
-	int length;
 	int i, j;
 
 	mutex_lock(&table->mutex);
@@ -767,23 +725,8 @@ void *hns_roce_table_find(struct hns_roce_dev *hr_dev,
 	if (!hem)
 		goto out;
 
-	list_for_each_entry(chunk, &hem->chunk_list, list) {
-		for (i = 0; i < chunk->npages; ++i) {
-			length = sg_dma_len(&chunk->mem[i]);
-			if (dma_handle && dma_offset >= 0) {
-				if (length > (u32)dma_offset)
-					*dma_handle = sg_dma_address(
-						&chunk->mem[i]) + dma_offset;
-				dma_offset -= length;
-			}
-
-			if (length > (u32)offset) {
-				addr = chunk->buf[i] + offset;
-				goto out;
-			}
-			offset -= length;
-		}
-	}
+	*dma_handle = hem->dma + dma_offset;
+	addr = hem->buf + offset;
 
 out:
 	mutex_unlock(&table->mutex);
diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.h b/drivers/infiniband/hw/hns/hns_roce_hem.h
index 7d23d3c51da4..6fb51db9682b 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.h
@@ -56,10 +56,6 @@ enum {
 	HEM_TYPE_TRRL,
 };
 
-#define HNS_ROCE_HEM_CHUNK_LEN	\
-	 ((256 - sizeof(struct list_head) - 2 * sizeof(int)) /	 \
-	 (sizeof(struct scatterlist) + sizeof(void *)))
-
 #define check_whether_bt_num_3(type, hop_num) \
 	(type < HEM_TYPE_MTT && hop_num == 2)
 
@@ -72,25 +68,13 @@ enum {
 	(type >= HEM_TYPE_MTT && hop_num == 1) || \
 	(type >= HEM_TYPE_MTT && hop_num == HNS_ROCE_HOP_NUM_0))
 
-struct hns_roce_hem_chunk {
-	struct list_head	 list;
-	int			 npages;
-	int			 nsg;
-	struct scatterlist	 mem[HNS_ROCE_HEM_CHUNK_LEN];
-	void			 *buf[HNS_ROCE_HEM_CHUNK_LEN];
-};
-
 struct hns_roce_hem {
-	struct list_head chunk_list;
+	void *buf;
+	dma_addr_t dma;
+	unsigned long size;
 	refcount_t refcount;
 };
 
-struct hns_roce_hem_iter {
-	struct hns_roce_hem		 *hem;
-	struct hns_roce_hem_chunk	 *chunk;
-	int				 page_idx;
-};
-
 struct hns_roce_hem_mhop {
 	u32	hop_num;
 	u32	buf_chunk_size;
@@ -133,38 +117,4 @@ void *hns_roce_hem_list_find_mtt(struct hns_roce_dev *hr_dev,
 				 struct hns_roce_hem_list *hem_list,
 				 int offset, int *mtt_cnt);
 
-static inline void hns_roce_hem_first(struct hns_roce_hem *hem,
-				      struct hns_roce_hem_iter *iter)
-{
-	iter->hem = hem;
-	iter->chunk = list_empty(&hem->chunk_list) ? NULL :
-				 list_entry(hem->chunk_list.next,
-					    struct hns_roce_hem_chunk, list);
-	iter->page_idx = 0;
-}
-
-static inline int hns_roce_hem_last(struct hns_roce_hem_iter *iter)
-{
-	return !iter->chunk;
-}
-
-static inline void hns_roce_hem_next(struct hns_roce_hem_iter *iter)
-{
-	if (++iter->page_idx >= iter->chunk->nsg) {
-		if (iter->chunk->list.next == &iter->hem->chunk_list) {
-			iter->chunk = NULL;
-			return;
-		}
-
-		iter->chunk = list_entry(iter->chunk->list.next,
-					 struct hns_roce_hem_chunk, list);
-		iter->page_idx = 0;
-	}
-}
-
-static inline dma_addr_t hns_roce_hem_addr(struct hns_roce_hem_iter *iter)
-{
-	return sg_dma_address(&iter->chunk->mem[iter->page_idx]);
-}
-
 #endif /* _HNS_ROCE_HEM_H */
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 94e9e6a237cf..de56dc6e3226 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -4058,7 +4058,6 @@ static int hns_roce_v2_set_hem(struct hns_roce_dev *hr_dev,
 			       struct hns_roce_hem_table *table, int obj,
 			       u32 step_idx)
 {
-	struct hns_roce_hem_iter iter;
 	struct hns_roce_hem_mhop mhop;
 	struct hns_roce_hem *hem;
 	unsigned long mhop_obj = obj;
@@ -4095,12 +4094,8 @@ static int hns_roce_v2_set_hem(struct hns_roce_dev *hr_dev,
 
 	if (check_whether_last_step(hop_num, step_idx)) {
 		hem = table->hem[hem_idx];
-		for (hns_roce_hem_first(hem, &iter);
-		     !hns_roce_hem_last(&iter); hns_roce_hem_next(&iter)) {
-			bt_ba = hns_roce_hem_addr(&iter);
-			ret = set_hem_to_hw(hr_dev, obj, bt_ba, table->type,
-					    step_idx);
-		}
+
+		ret = set_hem_to_hw(hr_dev, obj, hem->dma, table->type, step_idx);
 	} else {
 		if (step_idx == 0)
 			bt_ba = table->bt_l0_dma_addr[i];
-- 
2.30.0


