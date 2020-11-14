Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF252B2C88
	for <lists+linux-rdma@lfdr.de>; Sat, 14 Nov 2020 11:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgKNKAT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 14 Nov 2020 05:00:19 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8088 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbgKNKAT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 14 Nov 2020 05:00:19 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CY9mv5JLMzLxHp;
        Sat, 14 Nov 2020 17:59:59 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Sat, 14 Nov 2020 18:00:07 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH v2 for-next] RDMA/hns: Refactor the hns_roce_buf allocation flow
Date:   Sat, 14 Nov 2020 17:58:36 +0800
Message-ID: <1605347916-15964-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

Add a group of flags to control the 'struct hns_roce_buf' allocation
flow, this is used to support the caller running in atomic context.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
Changes since v1:
- Fix issues about WARN_ON() and IS_ERR_OR_NULL().
Link: https://patchwork.kernel.org/project/linux-rdma/patch/1603967462-18124-1-git-send-email-liweihang@huawei.com/

 drivers/infiniband/hw/hns/hns_roce_alloc.c  | 128 ++++++++++++++++------------
 drivers/infiniband/hw/hns/hns_roce_device.h |  51 +++++------
 drivers/infiniband/hw/hns/hns_roce_mr.c     |  39 +++------
 3 files changed, 113 insertions(+), 105 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_alloc.c b/drivers/infiniband/hw/hns/hns_roce_alloc.c
index a6b23de..dad2b9b 100644
--- a/drivers/infiniband/hw/hns/hns_roce_alloc.c
+++ b/drivers/infiniband/hw/hns/hns_roce_alloc.c
@@ -159,76 +159,96 @@ void hns_roce_bitmap_cleanup(struct hns_roce_bitmap *bitmap)
 
 void hns_roce_buf_free(struct hns_roce_dev *hr_dev, struct hns_roce_buf *buf)
 {
-	struct device *dev = hr_dev->dev;
-	u32 size = buf->size;
-	int i;
+	struct hns_roce_buf_list *trunks;
+	u32 i;
 
-	if (size == 0)
+	if (!buf)
 		return;
 
-	buf->size = 0;
+	trunks = buf->trunk_list;
+	if (trunks) {
+		buf->trunk_list = NULL;
+		for (i = 0; i < buf->ntrunks; i++)
+			dma_free_coherent(hr_dev->dev, 1 << buf->trunk_shift,
+					  trunks[i].buf, trunks[i].map);
 
-	if (hns_roce_buf_is_direct(buf)) {
-		dma_free_coherent(dev, size, buf->direct.buf, buf->direct.map);
-	} else {
-		for (i = 0; i < buf->npages; ++i)
-			if (buf->page_list[i].buf)
-				dma_free_coherent(dev, 1 << buf->page_shift,
-						  buf->page_list[i].buf,
-						  buf->page_list[i].map);
-		kfree(buf->page_list);
-		buf->page_list = NULL;
+		kfree(trunks);
 	}
+
+	kfree(buf);
 }
 
-int hns_roce_buf_alloc(struct hns_roce_dev *hr_dev, u32 size, u32 max_direct,
-		       struct hns_roce_buf *buf, u32 page_shift)
+/*
+ * Allocate the dma buffer for storing ROCEE table entries
+ *
+ * @size: required size
+ * @page_shift: the unit size in a continuous dma address range
+ * @flags: HNS_ROCE_BUF_ flags to control the allocation flow.
+ */
+struct hns_roce_buf *hns_roce_buf_alloc(struct hns_roce_dev *hr_dev, u32 size,
+					u32 page_shift, u32 flags)
 {
-	struct hns_roce_buf_list *buf_list;
-	struct device *dev = hr_dev->dev;
-	u32 page_size;
-	int i;
+	u32 trunk_size, page_size, alloced_size;
+	struct hns_roce_buf_list *trunks;
+	struct hns_roce_buf *buf;
+	gfp_t gfp_flags;
+	u32 ntrunk, i;
 
 	/* The minimum shift of the page accessed by hw is HNS_HW_PAGE_SHIFT */
-	buf->page_shift = max_t(int, HNS_HW_PAGE_SHIFT, page_shift);
+	if (WARN_ON(page_shift < HNS_HW_PAGE_SHIFT))
+		return ERR_PTR(-EINVAL);
+
+	gfp_flags = (flags & HNS_ROCE_BUF_NOSLEEP) ? GFP_ATOMIC : GFP_KERNEL;
+	buf = kzalloc(sizeof(*buf), gfp_flags);
+	if (!buf)
+		return ERR_PTR(-ENOMEM);
 
+	buf->page_shift = page_shift;
 	page_size = 1 << buf->page_shift;
-	buf->npages = DIV_ROUND_UP(size, page_size);
-
-	/* required size is not bigger than one trunk size */
-	if (size <= max_direct) {
-		buf->page_list = NULL;
-		buf->direct.buf = dma_alloc_coherent(dev, size,
-						     &buf->direct.map,
-						     GFP_KERNEL);
-		if (!buf->direct.buf)
-			return -ENOMEM;
+
+	/* Calc the trunk size and num by required size and page_shift */
+	if (flags & HNS_ROCE_BUF_DIRECT) {
+		buf->trunk_shift = ilog2(ALIGN(size, PAGE_SIZE));
+		ntrunk = 1;
 	} else {
-		buf_list = kcalloc(buf->npages, sizeof(*buf_list), GFP_KERNEL);
-		if (!buf_list)
-			return -ENOMEM;
-
-		for (i = 0; i < buf->npages; i++) {
-			buf_list[i].buf = dma_alloc_coherent(dev, page_size,
-							     &buf_list[i].map,
-							     GFP_KERNEL);
-			if (!buf_list[i].buf)
-				break;
-		}
+		buf->trunk_shift = ilog2(ALIGN(page_size, PAGE_SIZE));
+		ntrunk = DIV_ROUND_UP(size, 1 << buf->trunk_shift);
+	}
 
-		if (i != buf->npages && i > 0) {
-			while (i-- > 0)
-				dma_free_coherent(dev, page_size,
-						  buf_list[i].buf,
-						  buf_list[i].map);
-			kfree(buf_list);
-			return -ENOMEM;
-		}
-		buf->page_list = buf_list;
+	trunks = kcalloc(ntrunk, sizeof(*trunks), gfp_flags);
+	if (!trunks) {
+		kfree(buf);
+		return ERR_PTR(-ENOMEM);
 	}
-	buf->size = size;
 
-	return 0;
+	trunk_size = 1 << buf->trunk_shift;
+	alloced_size = 0;
+	for (i = 0; i < ntrunk; i++) {
+		trunks[i].buf = dma_alloc_coherent(hr_dev->dev, trunk_size,
+						   &trunks[i].map, gfp_flags);
+		if (!trunks[i].buf)
+			break;
+
+		alloced_size += trunk_size;
+	}
+
+	buf->ntrunks = i;
+
+	/* In nofail mode, it's only failed when the alloced size is 0 */
+	if ((flags & HNS_ROCE_BUF_NOFAIL) ? i == 0 : i != ntrunk) {
+		for (i = 0; i < buf->ntrunks; i++)
+			dma_free_coherent(hr_dev->dev, trunk_size,
+					  trunks[i].buf, trunks[i].map);
+
+		kfree(trunks);
+		kfree(buf);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	buf->npages = DIV_ROUND_UP(alloced_size, page_size);
+	buf->trunk_list = trunks;
+
+	return buf;
 }
 
 int hns_roce_get_kmem_bufs(struct hns_roce_dev *hr_dev, dma_addr_t *bufs,
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 1d99022..11a137f 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -267,9 +267,6 @@ enum {
 #define HNS_HW_PAGE_SHIFT			12
 #define HNS_HW_PAGE_SIZE			(1 << HNS_HW_PAGE_SHIFT)
 
-/* The minimum page count for hardware access page directly. */
-#define HNS_HW_DIRECT_PAGE_COUNT 2
-
 struct hns_roce_uar {
 	u64		pfn;
 	unsigned long	index;
@@ -421,11 +418,26 @@ struct hns_roce_buf_list {
 	dma_addr_t	map;
 };
 
+/*
+ * %HNS_ROCE_BUF_DIRECT indicates that the all memory must be in a continuous
+ * dma address range.
+ *
+ * %HNS_ROCE_BUF_NOSLEEP indicates that the caller cannot sleep.
+ *
+ * %HNS_ROCE_BUF_NOFAIL allocation only failed when allocated size is zero, even
+ * the allocated size is smaller than the required size.
+ */
+enum {
+	HNS_ROCE_BUF_DIRECT = BIT(0),
+	HNS_ROCE_BUF_NOSLEEP = BIT(1),
+	HNS_ROCE_BUF_NOFAIL = BIT(2),
+};
+
 struct hns_roce_buf {
-	struct hns_roce_buf_list	direct;
-	struct hns_roce_buf_list	*page_list;
+	struct hns_roce_buf_list	*trunk_list;
+	u32				ntrunks;
 	u32				npages;
-	u32				size;
+	unsigned int			trunk_shift;
 	unsigned int			page_shift;
 };
 
@@ -1081,29 +1093,18 @@ static inline struct hns_roce_qp
 	return xa_load(&hr_dev->qp_table_xa, qpn & (hr_dev->caps.num_qps - 1));
 }
 
-static inline bool hns_roce_buf_is_direct(struct hns_roce_buf *buf)
-{
-	if (buf->page_list)
-		return false;
-
-	return true;
-}
-
 static inline void *hns_roce_buf_offset(struct hns_roce_buf *buf, int offset)
 {
-	if (hns_roce_buf_is_direct(buf))
-		return (char *)(buf->direct.buf) + (offset & (buf->size - 1));
-
-	return (char *)(buf->page_list[offset >> buf->page_shift].buf) +
-	       (offset & ((1 << buf->page_shift) - 1));
+	return (char *)(buf->trunk_list[offset >> buf->trunk_shift].buf) +
+			(offset & ((1 << buf->trunk_shift) - 1));
 }
 
 static inline dma_addr_t hns_roce_buf_page(struct hns_roce_buf *buf, int idx)
 {
-	if (hns_roce_buf_is_direct(buf))
-		return buf->direct.map + ((dma_addr_t)idx << buf->page_shift);
-	else
-		return buf->page_list[idx].map;
+	int offset = idx << buf->page_shift;
+
+	return buf->trunk_list[offset >> buf->trunk_shift].map +
+			(offset & ((1 << buf->trunk_shift) - 1));
 }
 
 #define hr_hw_page_align(x)		ALIGN(x, 1 << HNS_HW_PAGE_SHIFT)
@@ -1227,8 +1228,8 @@ int hns_roce_alloc_mw(struct ib_mw *mw, struct ib_udata *udata);
 int hns_roce_dealloc_mw(struct ib_mw *ibmw);
 
 void hns_roce_buf_free(struct hns_roce_dev *hr_dev, struct hns_roce_buf *buf);
-int hns_roce_buf_alloc(struct hns_roce_dev *hr_dev, u32 size, u32 max_direct,
-		       struct hns_roce_buf *buf, u32 page_shift);
+struct hns_roce_buf *hns_roce_buf_alloc(struct hns_roce_dev *hr_dev, u32 size,
+					u32 page_shift, u32 flags);
 
 int hns_roce_get_kmem_bufs(struct hns_roce_dev *hr_dev, dma_addr_t *bufs,
 			   int buf_cnt, int start, struct hns_roce_buf *buf);
diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index 7f81a69..87e2e62 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -695,15 +695,6 @@ static inline size_t mtr_bufs_size(struct hns_roce_buf_attr *attr)
 	return size;
 }
 
-static inline size_t mtr_kmem_direct_size(bool is_direct, size_t alloc_size,
-					  unsigned int page_shift)
-{
-	if (is_direct)
-		return ALIGN(alloc_size, 1 << page_shift);
-	else
-		return HNS_HW_DIRECT_PAGE_COUNT << page_shift;
-}
-
 /*
  * check the given pages in continuous address space
  * Returns 0 on success, or the error page num.
@@ -732,7 +723,6 @@ static void mtr_free_bufs(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr)
 	/* release kernel buffers */
 	if (mtr->kmem) {
 		hns_roce_buf_free(hr_dev, mtr->kmem);
-		kfree(mtr->kmem);
 		mtr->kmem = NULL;
 	}
 }
@@ -744,13 +734,12 @@ static int mtr_alloc_bufs(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 	struct ib_device *ibdev = &hr_dev->ib_dev;
 	unsigned int best_pg_shift;
 	int all_pg_count = 0;
-	size_t direct_size;
 	size_t total_size;
 	int ret;
 
 	total_size = mtr_bufs_size(buf_attr);
 	if (total_size < 1) {
-		ibdev_err(ibdev, "Failed to check mtr size\n");
+		ibdev_err(ibdev, "failed to check mtr size\n.");
 		return -EINVAL;
 	}
 
@@ -762,7 +751,7 @@ static int mtr_alloc_bufs(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 		mtr->umem = ib_umem_get(ibdev, user_addr, total_size,
 					buf_attr->user_access);
 		if (IS_ERR_OR_NULL(mtr->umem)) {
-			ibdev_err(ibdev, "Failed to get umem, ret %ld\n",
+			ibdev_err(ibdev, "failed to get umem, ret = %ld.\n",
 				  PTR_ERR(mtr->umem));
 			return -ENOMEM;
 		}
@@ -780,19 +769,16 @@ static int mtr_alloc_bufs(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 		ret = 0;
 	} else {
 		mtr->umem = NULL;
-		mtr->kmem = kzalloc(sizeof(*mtr->kmem), GFP_KERNEL);
-		if (!mtr->kmem) {
-			ibdev_err(ibdev, "Failed to alloc kmem\n");
-			return -ENOMEM;
-		}
-		direct_size = mtr_kmem_direct_size(is_direct, total_size,
-						   buf_attr->page_shift);
-		ret = hns_roce_buf_alloc(hr_dev, total_size, direct_size,
-					 mtr->kmem, buf_attr->page_shift);
-		if (ret) {
-			ibdev_err(ibdev, "Failed to alloc kmem, ret %d\n", ret);
-			goto err_alloc_mem;
+		mtr->kmem =
+			hns_roce_buf_alloc(hr_dev, total_size,
+					   buf_attr->page_shift,
+					   is_direct ? HNS_ROCE_BUF_DIRECT : 0);
+		if (IS_ERR(mtr->kmem)) {
+			ibdev_err(ibdev, "failed to alloc kmem, ret = %ld.\n",
+				  PTR_ERR(mtr->kmem));
+			return PTR_ERR(mtr->kmem);
 		}
+
 		best_pg_shift = buf_attr->page_shift;
 		all_pg_count = mtr->kmem->npages;
 	}
@@ -800,7 +786,8 @@ static int mtr_alloc_bufs(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 	/* must bigger than minimum hardware page shift */
 	if (best_pg_shift < HNS_HW_PAGE_SHIFT || all_pg_count < 1) {
 		ret = -EINVAL;
-		ibdev_err(ibdev, "Failed to check mtr page shift %d count %d\n",
+		ibdev_err(ibdev,
+			  "failed to check mtr, page shift = %u count = %d.\n",
 			  best_pg_shift, all_pg_count);
 		goto err_alloc_mem;
 	}
-- 
2.8.1

