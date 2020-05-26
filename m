Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6CE1B5C39
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2020 15:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgDWNPJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Apr 2020 09:15:09 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:35898 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726532AbgDWNPI (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 23 Apr 2020 09:15:08 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 64B0BA890D683E3089B3;
        Thu, 23 Apr 2020 21:13:01 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Thu, 23 Apr 2020 21:12:53 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH v2 for-next 2/5] RDMA/hns: Remove unused MTT functions
Date:   Thu, 23 Apr 2020 21:12:47 +0800
Message-ID: <1587647570-46972-3-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1587647570-46972-1-git-send-email-liweihang@huawei.com>
References: <1587647570-46972-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

The MTT (Memory Translate Table) interface is no longer used to configure
the buffer address to BT (Base Address Table) that requires driver mapping.
Because the MTT is not compatible with multi-hop addressing of the hip08,
it is replaced by MTR (Memory Translate Region) interface, and all the MTT
functions should be removed.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_alloc.c  |  43 ---
 drivers/infiniband/hw/hns/hns_roce_device.h |  64 ----
 drivers/infiniband/hw/hns/hns_roce_hem.c    | 105 ------
 drivers/infiniband/hw/hns/hns_roce_hem.h    |   6 -
 drivers/infiniband/hw/hns/hns_roce_main.c   |  70 +---
 drivers/infiniband/hw/hns/hns_roce_mr.c     | 521 ----------------------------
 6 files changed, 2 insertions(+), 807 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_alloc.c b/drivers/infiniband/hw/hns/hns_roce_alloc.c
index e04e759..365e7db 100644
--- a/drivers/infiniband/hw/hns/hns_roce_alloc.c
+++ b/drivers/infiniband/hw/hns/hns_roce_alloc.c
@@ -283,49 +283,6 @@ int hns_roce_get_umem_bufs(struct hns_roce_dev *hr_dev, dma_addr_t *bufs,
 	return total;
 }
 
-void hns_roce_init_buf_region(struct hns_roce_buf_region *region, int hopnum,
-			      int offset, int buf_cnt)
-{
-	if (hopnum == HNS_ROCE_HOP_NUM_0)
-		region->hopnum = 0;
-	else
-		region->hopnum = hopnum;
-
-	region->offset = offset;
-	region->count = buf_cnt;
-}
-
-void hns_roce_free_buf_list(dma_addr_t **bufs, int region_cnt)
-{
-	int i;
-
-	for (i = 0; i < region_cnt; i++) {
-		kfree(bufs[i]);
-		bufs[i] = NULL;
-	}
-}
-
-int hns_roce_alloc_buf_list(struct hns_roce_buf_region *regions,
-			    dma_addr_t **bufs, int region_cnt)
-{
-	struct hns_roce_buf_region *r;
-	int i;
-
-	for (i = 0; i < region_cnt; i++) {
-		r = &regions[i];
-		bufs[i] = kcalloc(r->count, sizeof(dma_addr_t), GFP_KERNEL);
-		if (!bufs[i])
-			goto err_alloc;
-	}
-
-	return 0;
-
-err_alloc:
-	hns_roce_free_buf_list(bufs, i);
-
-	return -ENOMEM;
-}
-
 void hns_roce_cleanup_bitmap(struct hns_roce_dev *hr_dev)
 {
 	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_SRQ)
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 0ef5c2e..6185f8c 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -222,13 +222,6 @@ enum {
 	HNS_ROCE_CAP_FLAG_ATOMIC		= BIT(10),
 };
 
-enum hns_roce_mtt_type {
-	MTT_TYPE_WQE,
-	MTT_TYPE_CQE,
-	MTT_TYPE_SRQWQE,
-	MTT_TYPE_IDX
-};
-
 #define HNS_ROCE_DB_TYPE_COUNT			2
 #define HNS_ROCE_DB_UNIT_SIZE			4
 
@@ -267,8 +260,6 @@ enum {
 #define HNS_ROCE_PORT_DOWN			0
 #define HNS_ROCE_PORT_UP			1
 
-#define HNS_ROCE_MTT_ENTRY_PER_SEG		8
-
 #define PAGE_ADDR_SHIFT				12
 
 /* The minimum page count for hardware access page directly. */
@@ -303,22 +294,6 @@ struct hns_roce_bitmap {
 	unsigned long		*table;
 };
 
-/* Order bitmap length -- bit num compute formula: 1 << (max_order - order) */
-/* Order = 0: bitmap is biggest, order = max bitmap is least (only a bit) */
-/* Every bit repesent to a partner free/used status in bitmap */
-/*
- * Initial, bits of other bitmap are all 0 except that a bit of max_order is 1
- * Bit = 1 represent to idle and available; bit = 0: not available
- */
-struct hns_roce_buddy {
-	/* Members point to every order level bitmap */
-	unsigned long **bits;
-	/* Represent to avail bits of the order level bitmap */
-	u32            *num_free;
-	int             max_order;
-	spinlock_t      lock;
-};
-
 /* For Hardware Entry Memory */
 struct hns_roce_hem_table {
 	/* HEM type: 0 = qpc, 1 = mtt, 2 = cqc, 3 = srq, 4 = other */
@@ -339,13 +314,6 @@ struct hns_roce_hem_table {
 	dma_addr_t	*bt_l0_dma_addr;
 };
 
-struct hns_roce_mtt {
-	unsigned long		first_seg;
-	int			order;
-	int			page_shift;
-	enum hns_roce_mtt_type	mtt_type;
-};
-
 struct hns_roce_buf_region {
 	int offset; /* page offset */
 	u32 count; /* page count */
@@ -418,15 +386,7 @@ struct hns_roce_mr {
 
 struct hns_roce_mr_table {
 	struct hns_roce_bitmap		mtpt_bitmap;
-	struct hns_roce_buddy		mtt_buddy;
-	struct hns_roce_hem_table	mtt_table;
 	struct hns_roce_hem_table	mtpt_table;
-	struct hns_roce_buddy		mtt_cqe_buddy;
-	struct hns_roce_hem_table	mtt_cqe_table;
-	struct hns_roce_buddy		mtt_srqwqe_buddy;
-	struct hns_roce_hem_table	mtt_srqwqe_table;
-	struct hns_roce_buddy		mtt_idx_buddy;
-	struct hns_roce_hem_table	mtt_idx_table;
 };
 
 struct hns_roce_wq {
@@ -1141,21 +1101,6 @@ void hns_roce_cmd_event(struct hns_roce_dev *hr_dev, u16 token, u8 status,
 int hns_roce_cmd_use_events(struct hns_roce_dev *hr_dev);
 void hns_roce_cmd_use_polling(struct hns_roce_dev *hr_dev);
 
-int hns_roce_mtt_init(struct hns_roce_dev *hr_dev, int npages, int page_shift,
-		      struct hns_roce_mtt *mtt);
-void hns_roce_mtt_cleanup(struct hns_roce_dev *hr_dev,
-			  struct hns_roce_mtt *mtt);
-int hns_roce_buf_write_mtt(struct hns_roce_dev *hr_dev,
-			   struct hns_roce_mtt *mtt, struct hns_roce_buf *buf);
-
-void hns_roce_mtr_init(struct hns_roce_mtr *mtr, int bt_pg_shift,
-		       int buf_pg_shift);
-int hns_roce_mtr_attach(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
-			dma_addr_t **bufs, struct hns_roce_buf_region *regions,
-			int region_cnt);
-void hns_roce_mtr_cleanup(struct hns_roce_dev *hr_dev,
-			  struct hns_roce_mtr *mtr);
-
 /* hns roce hw need current block and next block addr from mtt */
 #define MTT_MIN_COUNT	 2
 int hns_roce_mtr_find(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
@@ -1228,15 +1173,6 @@ void hns_roce_buf_free(struct hns_roce_dev *hr_dev, struct hns_roce_buf *buf);
 int hns_roce_buf_alloc(struct hns_roce_dev *hr_dev, u32 size, u32 max_direct,
 		       struct hns_roce_buf *buf, u32 page_shift);
 
-int hns_roce_ib_umem_write_mtt(struct hns_roce_dev *hr_dev,
-			       struct hns_roce_mtt *mtt, struct ib_umem *umem);
-
-void hns_roce_init_buf_region(struct hns_roce_buf_region *region, int hopnum,
-			      int offset, int buf_cnt);
-int hns_roce_alloc_buf_list(struct hns_roce_buf_region *regions,
-			    dma_addr_t **bufs, int count);
-void hns_roce_free_buf_list(dma_addr_t **bufs, int count);
-
 int hns_roce_get_kmem_bufs(struct hns_roce_dev *hr_dev, dma_addr_t *bufs,
 			   int buf_cnt, int start, struct hns_roce_buf *buf);
 int hns_roce_get_umem_bufs(struct hns_roce_dev *hr_dev, dma_addr_t *bufs,
diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.c b/drivers/infiniband/hw/hns/hns_roce_hem.c
index a245e75..37d101e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.c
@@ -75,18 +75,6 @@ bool hns_roce_check_whether_mhop(struct hns_roce_dev *hr_dev, u32 type)
 	case HEM_TYPE_CQC_TIMER:
 		hop_num = hr_dev->caps.cqc_timer_hop_num;
 		break;
-	case HEM_TYPE_CQE:
-		hop_num = hr_dev->caps.cqe_hop_num;
-		break;
-	case HEM_TYPE_MTT:
-		hop_num = hr_dev->caps.mtt_hop_num;
-		break;
-	case HEM_TYPE_SRQWQE:
-		hop_num = hr_dev->caps.srqwqe_hop_num;
-		break;
-	case HEM_TYPE_IDX:
-		hop_num = hr_dev->caps.idx_hop_num;
-		break;
 	default:
 		return false;
 	}
@@ -195,38 +183,6 @@ static int get_hem_table_config(struct hns_roce_dev *hr_dev,
 		mhop->ba_l0_num = hr_dev->caps.srqc_bt_num;
 		mhop->hop_num = hr_dev->caps.srqc_hop_num;
 		break;
-	case HEM_TYPE_MTT:
-		mhop->buf_chunk_size = 1 << (hr_dev->caps.mtt_buf_pg_sz
-					     + PAGE_SHIFT);
-		mhop->bt_chunk_size = 1 << (hr_dev->caps.mtt_ba_pg_sz
-					     + PAGE_SHIFT);
-		mhop->ba_l0_num = mhop->bt_chunk_size / BA_BYTE_LEN;
-		mhop->hop_num = hr_dev->caps.mtt_hop_num;
-		break;
-	case HEM_TYPE_CQE:
-		mhop->buf_chunk_size = 1 << (hr_dev->caps.cqe_buf_pg_sz
-					     + PAGE_SHIFT);
-		mhop->bt_chunk_size = 1 << (hr_dev->caps.cqe_ba_pg_sz
-					     + PAGE_SHIFT);
-		mhop->ba_l0_num = mhop->bt_chunk_size / BA_BYTE_LEN;
-		mhop->hop_num = hr_dev->caps.cqe_hop_num;
-		break;
-	case HEM_TYPE_SRQWQE:
-		mhop->buf_chunk_size = 1 << (hr_dev->caps.srqwqe_buf_pg_sz
-					    + PAGE_SHIFT);
-		mhop->bt_chunk_size = 1 << (hr_dev->caps.srqwqe_ba_pg_sz
-					    + PAGE_SHIFT);
-		mhop->ba_l0_num = mhop->bt_chunk_size / BA_BYTE_LEN;
-		mhop->hop_num = hr_dev->caps.srqwqe_hop_num;
-		break;
-	case HEM_TYPE_IDX:
-		mhop->buf_chunk_size = 1 << (hr_dev->caps.idx_buf_pg_sz
-				       + PAGE_SHIFT);
-		mhop->bt_chunk_size = 1 << (hr_dev->caps.idx_ba_pg_sz
-				       + PAGE_SHIFT);
-		mhop->ba_l0_num = mhop->bt_chunk_size / BA_BYTE_LEN;
-		mhop->hop_num = hr_dev->caps.idx_hop_num;
-		break;
 	default:
 		dev_err(dev, "Table %d not support multi-hop addressing!\n",
 			type);
@@ -899,57 +855,6 @@ void *hns_roce_table_find(struct hns_roce_dev *hr_dev,
 	return addr;
 }
 
-int hns_roce_table_get_range(struct hns_roce_dev *hr_dev,
-			     struct hns_roce_hem_table *table,
-			     unsigned long start, unsigned long end)
-{
-	struct hns_roce_hem_mhop mhop;
-	unsigned long inc = table->table_chunk_size / table->obj_size;
-	unsigned long i = 0;
-	int ret;
-
-	if (hns_roce_check_whether_mhop(hr_dev, table->type)) {
-		ret = hns_roce_calc_hem_mhop(hr_dev, table, NULL, &mhop);
-		if (ret)
-			goto fail;
-		inc = mhop.bt_chunk_size / table->obj_size;
-	}
-
-	/* Allocate MTT entry memory according to chunk(128K) */
-	for (i = start; i <= end; i += inc) {
-		ret = hns_roce_table_get(hr_dev, table, i);
-		if (ret)
-			goto fail;
-	}
-
-	return 0;
-
-fail:
-	while (i > start) {
-		i -= inc;
-		hns_roce_table_put(hr_dev, table, i);
-	}
-	return ret;
-}
-
-void hns_roce_table_put_range(struct hns_roce_dev *hr_dev,
-			      struct hns_roce_hem_table *table,
-			      unsigned long start, unsigned long end)
-{
-	struct hns_roce_hem_mhop mhop;
-	unsigned long inc = table->table_chunk_size / table->obj_size;
-	unsigned long i;
-
-	if (hns_roce_check_whether_mhop(hr_dev, table->type)) {
-		if (hns_roce_calc_hem_mhop(hr_dev, table, NULL, &mhop))
-			return;
-		inc = mhop.bt_chunk_size / table->obj_size;
-	}
-
-	for (i = start; i <= end; i += inc)
-		hns_roce_table_put(hr_dev, table, i);
-}
-
 int hns_roce_init_hem_table(struct hns_roce_dev *hr_dev,
 			    struct hns_roce_hem_table *table, u32 type,
 			    unsigned long obj_size, unsigned long nobj,
@@ -1112,12 +1017,6 @@ void hns_roce_cleanup_hem_table(struct hns_roce_dev *hr_dev,
 
 void hns_roce_cleanup_hem(struct hns_roce_dev *hr_dev)
 {
-	if ((hr_dev->caps.num_idx_segs))
-		hns_roce_cleanup_hem_table(hr_dev,
-					   &hr_dev->mr_table.mtt_idx_table);
-	if (hr_dev->caps.num_srqwqe_segs)
-		hns_roce_cleanup_hem_table(hr_dev,
-					   &hr_dev->mr_table.mtt_srqwqe_table);
 	if (hr_dev->caps.srqc_entry_sz)
 		hns_roce_cleanup_hem_table(hr_dev,
 					   &hr_dev->srq_table.table);
@@ -1137,10 +1036,6 @@ void hns_roce_cleanup_hem(struct hns_roce_dev *hr_dev)
 	hns_roce_cleanup_hem_table(hr_dev, &hr_dev->qp_table.irrl_table);
 	hns_roce_cleanup_hem_table(hr_dev, &hr_dev->qp_table.qp_table);
 	hns_roce_cleanup_hem_table(hr_dev, &hr_dev->mr_table.mtpt_table);
-	if (hns_roce_check_whether_mhop(hr_dev, HEM_TYPE_CQE))
-		hns_roce_cleanup_hem_table(hr_dev,
-					   &hr_dev->mr_table.mtt_cqe_table);
-	hns_roce_cleanup_hem_table(hr_dev, &hr_dev->mr_table.mtt_table);
 }
 
 struct roce_hem_item {
diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.h b/drivers/infiniband/hw/hns/hns_roce_hem.h
index a00b6c2..1fa0bdc 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.h
@@ -115,12 +115,6 @@ void hns_roce_table_put(struct hns_roce_dev *hr_dev,
 void *hns_roce_table_find(struct hns_roce_dev *hr_dev,
 			  struct hns_roce_hem_table *table, unsigned long obj,
 			  dma_addr_t *dma_handle);
-int hns_roce_table_get_range(struct hns_roce_dev *hr_dev,
-			     struct hns_roce_hem_table *table,
-			     unsigned long start, unsigned long end);
-void hns_roce_table_put_range(struct hns_roce_dev *hr_dev,
-			      struct hns_roce_hem_table *table,
-			      unsigned long start, unsigned long end);
 int hns_roce_init_hem_table(struct hns_roce_dev *hr_dev,
 			    struct hns_roce_hem_table *table, u32 type,
 			    unsigned long obj_size, unsigned long nobj,
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index d0031d5..fd3581e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -579,33 +579,12 @@ static int hns_roce_init_hem(struct hns_roce_dev *hr_dev)
 	int ret;
 	struct device *dev = hr_dev->dev;
 
-	ret = hns_roce_init_hem_table(hr_dev, &hr_dev->mr_table.mtt_table,
-				      HEM_TYPE_MTT, hr_dev->caps.mtt_entry_sz,
-				      hr_dev->caps.num_mtt_segs, 1);
-	if (ret) {
-		dev_err(dev, "Failed to init MTT context memory, aborting.\n");
-		return ret;
-	}
-
-	if (hns_roce_check_whether_mhop(hr_dev, HEM_TYPE_CQE)) {
-		ret = hns_roce_init_hem_table(hr_dev,
-					      &hr_dev->mr_table.mtt_cqe_table,
-					      HEM_TYPE_CQE,
-					      hr_dev->caps.mtt_entry_sz,
-					      hr_dev->caps.num_cqe_segs, 1);
-		if (ret) {
-			dev_err(dev,
-				"Failed to init CQE context memory, aborting.\n");
-			goto err_unmap_cqe;
-		}
-	}
-
 	ret = hns_roce_init_hem_table(hr_dev, &hr_dev->mr_table.mtpt_table,
 				      HEM_TYPE_MTPT, hr_dev->caps.mtpt_entry_sz,
 				      hr_dev->caps.num_mtpts, 1);
 	if (ret) {
 		dev_err(dev, "Failed to init MTPT context memory, aborting.\n");
-		goto err_unmap_mtt;
+		return ret;
 	}
 
 	ret = hns_roce_init_hem_table(hr_dev, &hr_dev->qp_table.qp_table,
@@ -660,32 +639,6 @@ static int hns_roce_init_hem(struct hns_roce_dev *hr_dev)
 		}
 	}
 
-	if (hr_dev->caps.num_srqwqe_segs) {
-		ret = hns_roce_init_hem_table(hr_dev,
-					     &hr_dev->mr_table.mtt_srqwqe_table,
-					     HEM_TYPE_SRQWQE,
-					     hr_dev->caps.mtt_entry_sz,
-					     hr_dev->caps.num_srqwqe_segs, 1);
-		if (ret) {
-			dev_err(dev,
-				"Failed to init MTT srqwqe memory, aborting.\n");
-			goto err_unmap_srq;
-		}
-	}
-
-	if (hr_dev->caps.num_idx_segs) {
-		ret = hns_roce_init_hem_table(hr_dev,
-					      &hr_dev->mr_table.mtt_idx_table,
-					      HEM_TYPE_IDX,
-					      hr_dev->caps.idx_entry_sz,
-					      hr_dev->caps.num_idx_segs, 1);
-		if (ret) {
-			dev_err(dev,
-				"Failed to init MTT idx memory, aborting.\n");
-			goto err_unmap_srqwqe;
-		}
-	}
-
 	if (hr_dev->caps.sccc_entry_sz) {
 		ret = hns_roce_init_hem_table(hr_dev,
 					      &hr_dev->qp_table.sccc_table,
@@ -695,7 +648,7 @@ static int hns_roce_init_hem(struct hns_roce_dev *hr_dev)
 		if (ret) {
 			dev_err(dev,
 				"Failed to init SCC context memory, aborting.\n");
-			goto err_unmap_idx;
+			goto err_unmap_srq;
 		}
 	}
 
@@ -733,17 +686,6 @@ static int hns_roce_init_hem(struct hns_roce_dev *hr_dev)
 	if (hr_dev->caps.sccc_entry_sz)
 		hns_roce_cleanup_hem_table(hr_dev,
 					   &hr_dev->qp_table.sccc_table);
-
-err_unmap_idx:
-	if (hr_dev->caps.num_idx_segs)
-		hns_roce_cleanup_hem_table(hr_dev,
-					   &hr_dev->mr_table.mtt_idx_table);
-
-err_unmap_srqwqe:
-	if (hr_dev->caps.num_srqwqe_segs)
-		hns_roce_cleanup_hem_table(hr_dev,
-					   &hr_dev->mr_table.mtt_srqwqe_table);
-
 err_unmap_srq:
 	if (hr_dev->caps.srqc_entry_sz)
 		hns_roce_cleanup_hem_table(hr_dev, &hr_dev->srq_table.table);
@@ -765,14 +707,6 @@ static int hns_roce_init_hem(struct hns_roce_dev *hr_dev)
 err_unmap_dmpt:
 	hns_roce_cleanup_hem_table(hr_dev, &hr_dev->mr_table.mtpt_table);
 
-err_unmap_mtt:
-	if (hns_roce_check_whether_mhop(hr_dev, HEM_TYPE_CQE))
-		hns_roce_cleanup_hem_table(hr_dev,
-					   &hr_dev->mr_table.mtt_cqe_table);
-
-err_unmap_cqe:
-	hns_roce_cleanup_hem_table(hr_dev, &hr_dev->mr_table.mtt_table);
-
 	return ret;
 }
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index be86568..702af74 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -66,233 +66,6 @@ int hns_roce_hw_destroy_mpt(struct hns_roce_dev *hr_dev,
 				 HNS_ROCE_CMD_TIMEOUT_MSECS);
 }
 
-static int hns_roce_buddy_alloc(struct hns_roce_buddy *buddy, int order,
-				unsigned long *seg)
-{
-	int o;
-	u32 m;
-
-	spin_lock(&buddy->lock);
-
-	for (o = order; o <= buddy->max_order; ++o) {
-		if (buddy->num_free[o]) {
-			m = 1 << (buddy->max_order - o);
-			*seg = find_first_bit(buddy->bits[o], m);
-			if (*seg < m)
-				goto found;
-		}
-	}
-	spin_unlock(&buddy->lock);
-	return -EINVAL;
-
- found:
-	clear_bit(*seg, buddy->bits[o]);
-	--buddy->num_free[o];
-
-	while (o > order) {
-		--o;
-		*seg <<= 1;
-		set_bit(*seg ^ 1, buddy->bits[o]);
-		++buddy->num_free[o];
-	}
-
-	spin_unlock(&buddy->lock);
-
-	*seg <<= order;
-	return 0;
-}
-
-static void hns_roce_buddy_free(struct hns_roce_buddy *buddy, unsigned long seg,
-				int order)
-{
-	seg >>= order;
-
-	spin_lock(&buddy->lock);
-
-	while (test_bit(seg ^ 1, buddy->bits[order])) {
-		clear_bit(seg ^ 1, buddy->bits[order]);
-		--buddy->num_free[order];
-		seg >>= 1;
-		++order;
-	}
-
-	set_bit(seg, buddy->bits[order]);
-	++buddy->num_free[order];
-
-	spin_unlock(&buddy->lock);
-}
-
-static int hns_roce_buddy_init(struct hns_roce_buddy *buddy, int max_order)
-{
-	int i, s;
-
-	buddy->max_order = max_order;
-	spin_lock_init(&buddy->lock);
-	buddy->bits = kcalloc(buddy->max_order + 1,
-			      sizeof(*buddy->bits),
-			      GFP_KERNEL);
-	buddy->num_free = kcalloc(buddy->max_order + 1,
-				  sizeof(*buddy->num_free),
-				  GFP_KERNEL);
-	if (!buddy->bits || !buddy->num_free)
-		goto err_out;
-
-	for (i = 0; i <= buddy->max_order; ++i) {
-		s = BITS_TO_LONGS(1 << (buddy->max_order - i));
-		buddy->bits[i] = kcalloc(s, sizeof(long), GFP_KERNEL |
-					 __GFP_NOWARN);
-		if (!buddy->bits[i]) {
-			buddy->bits[i] = vzalloc(array_size(s, sizeof(long)));
-			if (!buddy->bits[i])
-				goto err_out_free;
-		}
-	}
-
-	set_bit(0, buddy->bits[buddy->max_order]);
-	buddy->num_free[buddy->max_order] = 1;
-
-	return 0;
-
-err_out_free:
-	for (i = 0; i <= buddy->max_order; ++i)
-		kvfree(buddy->bits[i]);
-
-err_out:
-	kfree(buddy->bits);
-	kfree(buddy->num_free);
-	return -ENOMEM;
-}
-
-static void hns_roce_buddy_cleanup(struct hns_roce_buddy *buddy)
-{
-	int i;
-
-	for (i = 0; i <= buddy->max_order; ++i)
-		kvfree(buddy->bits[i]);
-
-	kfree(buddy->bits);
-	kfree(buddy->num_free);
-}
-
-static int hns_roce_alloc_mtt_range(struct hns_roce_dev *hr_dev, int order,
-				    unsigned long *seg, u32 mtt_type)
-{
-	struct hns_roce_mr_table *mr_table = &hr_dev->mr_table;
-	struct hns_roce_hem_table *table;
-	struct hns_roce_buddy *buddy;
-	int ret;
-
-	switch (mtt_type) {
-	case MTT_TYPE_WQE:
-		buddy = &mr_table->mtt_buddy;
-		table = &mr_table->mtt_table;
-		break;
-	case MTT_TYPE_CQE:
-		buddy = &mr_table->mtt_cqe_buddy;
-		table = &mr_table->mtt_cqe_table;
-		break;
-	case MTT_TYPE_SRQWQE:
-		buddy = &mr_table->mtt_srqwqe_buddy;
-		table = &mr_table->mtt_srqwqe_table;
-		break;
-	case MTT_TYPE_IDX:
-		buddy = &mr_table->mtt_idx_buddy;
-		table = &mr_table->mtt_idx_table;
-		break;
-	default:
-		dev_err(hr_dev->dev, "Unsupport MTT table type: %d\n",
-			mtt_type);
-		return -EINVAL;
-	}
-
-	ret = hns_roce_buddy_alloc(buddy, order, seg);
-	if (ret)
-		return ret;
-
-	ret = hns_roce_table_get_range(hr_dev, table, *seg,
-				       *seg + (1 << order) - 1);
-	if (ret) {
-		hns_roce_buddy_free(buddy, *seg, order);
-		return ret;
-	}
-
-	return 0;
-}
-
-int hns_roce_mtt_init(struct hns_roce_dev *hr_dev, int npages, int page_shift,
-		      struct hns_roce_mtt *mtt)
-{
-	int ret;
-	int i;
-
-	/* Page num is zero, correspond to DMA memory register */
-	if (!npages) {
-		mtt->order = -1;
-		mtt->page_shift = HNS_ROCE_HEM_PAGE_SHIFT;
-		return 0;
-	}
-
-	/* Note: if page_shift is zero, FAST memory register */
-	mtt->page_shift = page_shift;
-
-	/* Compute MTT entry necessary */
-	for (mtt->order = 0, i = HNS_ROCE_MTT_ENTRY_PER_SEG; i < npages;
-	     i <<= 1)
-		++mtt->order;
-
-	/* Allocate MTT entry */
-	ret = hns_roce_alloc_mtt_range(hr_dev, mtt->order, &mtt->first_seg,
-				       mtt->mtt_type);
-	if (ret)
-		return -ENOMEM;
-
-	return 0;
-}
-
-void hns_roce_mtt_cleanup(struct hns_roce_dev *hr_dev, struct hns_roce_mtt *mtt)
-{
-	struct hns_roce_mr_table *mr_table = &hr_dev->mr_table;
-
-	if (mtt->order < 0)
-		return;
-
-	switch (mtt->mtt_type) {
-	case MTT_TYPE_WQE:
-		hns_roce_buddy_free(&mr_table->mtt_buddy, mtt->first_seg,
-				    mtt->order);
-		hns_roce_table_put_range(hr_dev, &mr_table->mtt_table,
-					mtt->first_seg,
-					mtt->first_seg + (1 << mtt->order) - 1);
-		break;
-	case MTT_TYPE_CQE:
-		hns_roce_buddy_free(&mr_table->mtt_cqe_buddy, mtt->first_seg,
-				    mtt->order);
-		hns_roce_table_put_range(hr_dev, &mr_table->mtt_cqe_table,
-					mtt->first_seg,
-					mtt->first_seg + (1 << mtt->order) - 1);
-		break;
-	case MTT_TYPE_SRQWQE:
-		hns_roce_buddy_free(&mr_table->mtt_srqwqe_buddy, mtt->first_seg,
-				    mtt->order);
-		hns_roce_table_put_range(hr_dev, &mr_table->mtt_srqwqe_table,
-					mtt->first_seg,
-					mtt->first_seg + (1 << mtt->order) - 1);
-		break;
-	case MTT_TYPE_IDX:
-		hns_roce_buddy_free(&mr_table->mtt_idx_buddy, mtt->first_seg,
-				    mtt->order);
-		hns_roce_table_put_range(hr_dev, &mr_table->mtt_idx_table,
-					mtt->first_seg,
-					mtt->first_seg + (1 << mtt->order) - 1);
-		break;
-	default:
-		dev_err(hr_dev->dev,
-			"Unsupport mtt type %d, clean mtt failed\n",
-			mtt->mtt_type);
-		break;
-	}
-}
-
 static int alloc_mr_key(struct hns_roce_dev *hr_dev, struct hns_roce_mr *mr,
 			u32 pd, u64 iova, u64 size, u32 access)
 {
@@ -432,131 +205,6 @@ static int hns_roce_mr_enable(struct hns_roce_dev *hr_dev,
 	return ret;
 }
 
-static int hns_roce_write_mtt_chunk(struct hns_roce_dev *hr_dev,
-				    struct hns_roce_mtt *mtt, u32 start_index,
-				    u32 npages, u64 *page_list)
-{
-	struct hns_roce_hem_table *table;
-	dma_addr_t dma_handle;
-	__le64 *mtts;
-	u32 bt_page_size;
-	u32 i;
-
-	switch (mtt->mtt_type) {
-	case MTT_TYPE_WQE:
-		table = &hr_dev->mr_table.mtt_table;
-		bt_page_size = 1 << (hr_dev->caps.mtt_ba_pg_sz + PAGE_SHIFT);
-		break;
-	case MTT_TYPE_CQE:
-		table = &hr_dev->mr_table.mtt_cqe_table;
-		bt_page_size = 1 << (hr_dev->caps.cqe_ba_pg_sz + PAGE_SHIFT);
-		break;
-	case MTT_TYPE_SRQWQE:
-		table = &hr_dev->mr_table.mtt_srqwqe_table;
-		bt_page_size = 1 << (hr_dev->caps.srqwqe_ba_pg_sz + PAGE_SHIFT);
-		break;
-	case MTT_TYPE_IDX:
-		table = &hr_dev->mr_table.mtt_idx_table;
-		bt_page_size = 1 << (hr_dev->caps.idx_ba_pg_sz + PAGE_SHIFT);
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	/* All MTTs must fit in the same page */
-	if (start_index / (bt_page_size / sizeof(u64)) !=
-		(start_index + npages - 1) / (bt_page_size / sizeof(u64)))
-		return -EINVAL;
-
-	if (start_index & (HNS_ROCE_MTT_ENTRY_PER_SEG - 1))
-		return -EINVAL;
-
-	mtts = hns_roce_table_find(hr_dev, table,
-				mtt->first_seg +
-				start_index / HNS_ROCE_MTT_ENTRY_PER_SEG,
-				&dma_handle);
-	if (!mtts)
-		return -ENOMEM;
-
-	/* Save page addr, low 12 bits : 0 */
-	for (i = 0; i < npages; ++i) {
-		if (!hr_dev->caps.mtt_hop_num)
-			mtts[i] = cpu_to_le64(page_list[i] >> PAGE_ADDR_SHIFT);
-		else
-			mtts[i] = cpu_to_le64(page_list[i]);
-	}
-
-	return 0;
-}
-
-static int hns_roce_write_mtt(struct hns_roce_dev *hr_dev,
-			      struct hns_roce_mtt *mtt, u32 start_index,
-			      u32 npages, u64 *page_list)
-{
-	int chunk;
-	int ret;
-	u32 bt_page_size;
-
-	if (mtt->order < 0)
-		return -EINVAL;
-
-	switch (mtt->mtt_type) {
-	case MTT_TYPE_WQE:
-		bt_page_size = 1 << (hr_dev->caps.mtt_ba_pg_sz + PAGE_SHIFT);
-		break;
-	case MTT_TYPE_CQE:
-		bt_page_size = 1 << (hr_dev->caps.cqe_ba_pg_sz + PAGE_SHIFT);
-		break;
-	case MTT_TYPE_SRQWQE:
-		bt_page_size = 1 << (hr_dev->caps.srqwqe_ba_pg_sz + PAGE_SHIFT);
-		break;
-	case MTT_TYPE_IDX:
-		bt_page_size = 1 << (hr_dev->caps.idx_ba_pg_sz + PAGE_SHIFT);
-		break;
-	default:
-		dev_err(hr_dev->dev,
-			"Unsupport mtt type %d, write mtt failed\n",
-			mtt->mtt_type);
-		return -EINVAL;
-	}
-
-	while (npages > 0) {
-		chunk = min_t(int, bt_page_size / sizeof(u64), npages);
-
-		ret = hns_roce_write_mtt_chunk(hr_dev, mtt, start_index, chunk,
-					       page_list);
-		if (ret)
-			return ret;
-
-		npages -= chunk;
-		start_index += chunk;
-		page_list += chunk;
-	}
-
-	return 0;
-}
-
-int hns_roce_buf_write_mtt(struct hns_roce_dev *hr_dev,
-			   struct hns_roce_mtt *mtt, struct hns_roce_buf *buf)
-{
-	u64 *page_list;
-	int ret;
-	u32 i;
-
-	page_list = kmalloc_array(buf->npages, sizeof(*page_list), GFP_KERNEL);
-	if (!page_list)
-		return -ENOMEM;
-
-	for (i = 0; i < buf->npages; ++i)
-		page_list[i] = hns_roce_buf_page(buf, i);
-
-	ret = hns_roce_write_mtt(hr_dev, mtt, 0, buf->npages, page_list);
-
-	kfree(page_list);
-
-	return ret;
-}
-
 int hns_roce_init_mr_table(struct hns_roce_dev *hr_dev)
 {
 	struct hns_roce_mr_table *mr_table = &hr_dev->mr_table;
@@ -566,50 +214,6 @@ int hns_roce_init_mr_table(struct hns_roce_dev *hr_dev)
 				   hr_dev->caps.num_mtpts,
 				   hr_dev->caps.num_mtpts - 1,
 				   hr_dev->caps.reserved_mrws, 0);
-	if (ret)
-		return ret;
-
-	ret = hns_roce_buddy_init(&mr_table->mtt_buddy,
-				  ilog2(hr_dev->caps.num_mtt_segs));
-	if (ret)
-		goto err_buddy;
-
-	if (hns_roce_check_whether_mhop(hr_dev, HEM_TYPE_CQE)) {
-		ret = hns_roce_buddy_init(&mr_table->mtt_cqe_buddy,
-					  ilog2(hr_dev->caps.num_cqe_segs));
-		if (ret)
-			goto err_buddy_cqe;
-	}
-
-	if (hr_dev->caps.num_srqwqe_segs) {
-		ret = hns_roce_buddy_init(&mr_table->mtt_srqwqe_buddy,
-					  ilog2(hr_dev->caps.num_srqwqe_segs));
-		if (ret)
-			goto err_buddy_srqwqe;
-	}
-
-	if (hr_dev->caps.num_idx_segs) {
-		ret = hns_roce_buddy_init(&mr_table->mtt_idx_buddy,
-					  ilog2(hr_dev->caps.num_idx_segs));
-		if (ret)
-			goto err_buddy_idx;
-	}
-
-	return 0;
-
-err_buddy_idx:
-	if (hr_dev->caps.num_srqwqe_segs)
-		hns_roce_buddy_cleanup(&mr_table->mtt_srqwqe_buddy);
-
-err_buddy_srqwqe:
-	if (hns_roce_check_whether_mhop(hr_dev, HEM_TYPE_CQE))
-		hns_roce_buddy_cleanup(&mr_table->mtt_cqe_buddy);
-
-err_buddy_cqe:
-	hns_roce_buddy_cleanup(&mr_table->mtt_buddy);
-
-err_buddy:
-	hns_roce_bitmap_cleanup(&mr_table->mtpt_bitmap);
 	return ret;
 }
 
@@ -617,13 +221,6 @@ void hns_roce_cleanup_mr_table(struct hns_roce_dev *hr_dev)
 {
 	struct hns_roce_mr_table *mr_table = &hr_dev->mr_table;
 
-	if (hr_dev->caps.num_idx_segs)
-		hns_roce_buddy_cleanup(&mr_table->mtt_idx_buddy);
-	if (hr_dev->caps.num_srqwqe_segs)
-		hns_roce_buddy_cleanup(&mr_table->mtt_srqwqe_buddy);
-	hns_roce_buddy_cleanup(&mr_table->mtt_buddy);
-	if (hns_roce_check_whether_mhop(hr_dev, HEM_TYPE_CQE))
-		hns_roce_buddy_cleanup(&mr_table->mtt_cqe_buddy);
 	hns_roce_bitmap_cleanup(&mr_table->mtpt_bitmap);
 }
 
@@ -660,77 +257,6 @@ struct ib_mr *hns_roce_get_dma_mr(struct ib_pd *pd, int acc)
 	return ERR_PTR(ret);
 }
 
-int hns_roce_ib_umem_write_mtt(struct hns_roce_dev *hr_dev,
-			       struct hns_roce_mtt *mtt, struct ib_umem *umem)
-{
-	struct device *dev = hr_dev->dev;
-	struct sg_dma_page_iter sg_iter;
-	unsigned int order;
-	int npage = 0;
-	int ret = 0;
-	int i;
-	u64 page_addr;
-	u64 *pages;
-	u32 bt_page_size;
-	u32 n;
-
-	switch (mtt->mtt_type) {
-	case MTT_TYPE_WQE:
-		order = hr_dev->caps.mtt_ba_pg_sz;
-		break;
-	case MTT_TYPE_CQE:
-		order = hr_dev->caps.cqe_ba_pg_sz;
-		break;
-	case MTT_TYPE_SRQWQE:
-		order = hr_dev->caps.srqwqe_ba_pg_sz;
-		break;
-	case MTT_TYPE_IDX:
-		order = hr_dev->caps.idx_ba_pg_sz;
-		break;
-	default:
-		dev_err(dev, "Unsupport mtt type %d, write mtt failed\n",
-			mtt->mtt_type);
-		return -EINVAL;
-	}
-
-	bt_page_size = 1 << (order + PAGE_SHIFT);
-
-	pages = (u64 *) __get_free_pages(GFP_KERNEL, order);
-	if (!pages)
-		return -ENOMEM;
-
-	i = n = 0;
-
-	for_each_sg_dma_page(umem->sg_head.sgl, &sg_iter, umem->nmap, 0) {
-		page_addr = sg_page_iter_dma_address(&sg_iter);
-		if (!(npage % (1 << (mtt->page_shift - PAGE_SHIFT)))) {
-			if (page_addr & ((1 << mtt->page_shift) - 1)) {
-				dev_err(dev,
-					"page_addr is not page_shift %d alignment!\n",
-					mtt->page_shift);
-				ret = -EINVAL;
-				goto out;
-			}
-			pages[i++] = page_addr;
-		}
-		npage++;
-		if (i == bt_page_size / sizeof(u64)) {
-			ret = hns_roce_write_mtt(hr_dev, mtt, n, i, pages);
-			if (ret)
-				goto out;
-			n += i;
-			i = 0;
-		}
-	}
-
-	if (i)
-		ret = hns_roce_write_mtt(hr_dev, mtt, n, i, pages);
-
-out:
-	free_pages((unsigned long) pages, order);
-	return ret;
-}
-
 struct ib_mr *hns_roce_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 				   u64 virt_addr, int access_flags,
 				   struct ib_udata *udata)
@@ -1111,20 +637,6 @@ int hns_roce_dealloc_mw(struct ib_mw *ibmw)
 	return 0;
 }
 
-void hns_roce_mtr_init(struct hns_roce_mtr *mtr, int bt_pg_shift,
-		       int buf_pg_shift)
-{
-	hns_roce_hem_list_init(&mtr->hem_list);
-	mtr->hem_cfg.buf_pg_shift = buf_pg_shift;
-	mtr->hem_cfg.ba_pg_shift = bt_pg_shift;
-}
-
-void hns_roce_mtr_cleanup(struct hns_roce_dev *hr_dev,
-			  struct hns_roce_mtr *mtr)
-{
-	hns_roce_hem_list_release(hr_dev, &mtr->hem_list);
-}
-
 static int mtr_map_region(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 			  dma_addr_t *pages, struct hns_roce_buf_region *region)
 {
@@ -1164,39 +676,6 @@ static int mtr_map_region(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 	return 0;
 }
 
-int hns_roce_mtr_attach(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
-			dma_addr_t **bufs, struct hns_roce_buf_region *regions,
-			int region_cnt)
-{
-	struct hns_roce_buf_region *r;
-	int ret;
-	int i;
-
-	ret = hns_roce_hem_list_request(hr_dev, &mtr->hem_list, regions,
-					region_cnt, mtr->hem_cfg.ba_pg_shift);
-	if (ret)
-		return ret;
-
-	mtr->hem_cfg.root_ba = mtr->hem_list.root_ba;
-	for (i = 0; i < region_cnt; i++) {
-		r = &regions[i];
-		ret = mtr_map_region(hr_dev, mtr, bufs[i], r);
-		if (ret) {
-			dev_err(hr_dev->dev,
-				"write mtr[%d/%d] err %d,offset=%d.\n",
-				i, region_cnt, ret,  r->offset);
-			goto err_write;
-		}
-	}
-
-	return 0;
-
-err_write:
-	hns_roce_hem_list_release(hr_dev, &mtr->hem_list);
-
-	return ret;
-}
-
 static inline bool mtr_has_mtt(struct hns_roce_buf_attr *attr)
 {
 	int i;
-- 
2.8.1

