Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2A81A6607
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2020 13:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbgDML6Y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Apr 2020 07:58:24 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:53284 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728560AbgDML6Y (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 13 Apr 2020 07:58:24 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 879E278E8D87A7611CB4;
        Mon, 13 Apr 2020 19:58:17 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Mon, 13 Apr 2020 19:58:10 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 1/6] RDMA/hns: Add support for addressing when hopnum is 0
Date:   Mon, 13 Apr 2020 19:58:06 +0800
Message-ID: <1586779091-51410-2-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1586779091-51410-1-git-send-email-liweihang@huawei.com>
References: <1586779091-51410-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

Currently, WQE and EQE table have already used the mtr interface to config
and access memory by multi-hop addressing when hopnum is from 1 to 3. But
if hopnum is 0, each table need write its own but repetitive logic, and
many duplicate code exists in the mtr interfaces invoke process.

So wraps the public logic as 3 functions: hns_roce_mtr_create(),
hns_roce_mtr_destroy() and hns_roce_mtr_map() to support hopnum ranges from
0 to 3. In addition, makes the mtr interfaces easier to use.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h |  46 ++-
 drivers/infiniband/hw/hns/hns_roce_hem.c    |   9 +-
 drivers/infiniband/hw/hns/hns_roce_hem.h    |   5 +-
 drivers/infiniband/hw/hns/hns_roce_mr.c     | 423 ++++++++++++++++++++++++++--
 4 files changed, 450 insertions(+), 33 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index f6b3cf6..4a7afec 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -271,6 +271,9 @@ enum {
 
 #define PAGE_ADDR_SHIFT				12
 
+/* The minimum page count for hardware access page directly. */
+#define HNS_HW_DIRECT_PAGE_COUNT 2
+
 struct hns_roce_uar {
 	u64		pfn;
 	unsigned long	index;
@@ -357,13 +360,32 @@ struct hns_roce_hem_list {
 	struct list_head mid_bt[HNS_ROCE_MAX_BT_REGION][HNS_ROCE_MAX_BT_LEVEL];
 	struct list_head btm_bt; /* link all bottom bt in @mid_bt */
 	dma_addr_t root_ba; /* pointer to the root ba table */
-	int bt_pg_shift;
+};
+
+struct hns_roce_buf_attr {
+	struct {
+		size_t	size;  /* region size */
+		int	hopnum; /* multi-hop addressing hop num */
+	} region[HNS_ROCE_MAX_BT_REGION];
+	int region_count; /* valid region count */
+	int page_shift;  /* buffer page shift */
+	bool fixed_page; /* decide page shift is fixed-size or maximum size */
+	int user_access; /* umem access flag */
+	bool mtt_only; /* only alloc buffer-required MTT memory */
 };
 
 /* memory translate region */
 struct hns_roce_mtr {
-	struct hns_roce_hem_list hem_list;
-	int buf_pg_shift;
+	struct hns_roce_hem_list hem_list; /* multi-hop addressing resource */
+	struct ib_umem		 *umem; /* user space buffer */
+	struct hns_roce_buf	 *kmem; /* kernel space buffer */
+	struct {
+		dma_addr_t	 root_ba; /* root BA table's address */
+		bool		 is_direct; /* addressing without BA table */
+		int		 ba_pg_shift; /* BA table page shift */
+		int		 buf_pg_shift; /* buffer page shift */
+		int		 buf_pg_count;  /* buffer page count */
+	} hem_cfg; /* config for hardware addressing */
 };
 
 struct hns_roce_mw {
@@ -1113,6 +1135,16 @@ static inline void *hns_roce_buf_offset(struct hns_roce_buf *buf, int offset)
 		       (offset & (page_size - 1));
 }
 
+static inline u64 to_hr_hw_page_addr(u64 addr)
+{
+	return addr >> PAGE_ADDR_SHIFT;
+}
+
+static inline u32 to_hr_hw_page_shift(u32 page_shift)
+{
+	return page_shift - PAGE_ADDR_SHIFT;
+}
+
 int hns_roce_init_uar_table(struct hns_roce_dev *dev);
 int hns_roce_uar_alloc(struct hns_roce_dev *dev, struct hns_roce_uar *uar);
 void hns_roce_uar_free(struct hns_roce_dev *dev, struct hns_roce_uar *uar);
@@ -1144,6 +1176,14 @@ void hns_roce_mtr_cleanup(struct hns_roce_dev *hr_dev,
 #define MTT_MIN_COUNT	 2
 int hns_roce_mtr_find(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 		      int offset, u64 *mtt_buf, int mtt_max, u64 *base_addr);
+int hns_roce_mtr_create(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
+			struct hns_roce_buf_attr *buf_attr, int page_shift,
+			struct ib_udata *udata, unsigned long user_addr);
+void hns_roce_mtr_destroy(struct hns_roce_dev *hr_dev,
+			  struct hns_roce_mtr *mtr);
+int hns_roce_mtr_map(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
+		     struct hns_roce_buf_region *regions, int region_cnt,
+		     dma_addr_t *pages, int page_cnt);
 
 int hns_roce_init_pd_table(struct hns_roce_dev *hr_dev);
 int hns_roce_init_mr_table(struct hns_roce_dev *hr_dev);
diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.c b/drivers/infiniband/hw/hns/hns_roce_hem.c
index 263338b..a245e75 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.c
@@ -1505,7 +1505,7 @@ static int hem_list_alloc_root_bt(struct hns_roce_dev *hr_dev,
 int hns_roce_hem_list_request(struct hns_roce_dev *hr_dev,
 			      struct hns_roce_hem_list *hem_list,
 			      const struct hns_roce_buf_region *regions,
-			      int region_cnt)
+			      int region_cnt, int bt_pg_shift)
 {
 	const struct hns_roce_buf_region *r;
 	int ofs, end;
@@ -1519,7 +1519,7 @@ int hns_roce_hem_list_request(struct hns_roce_dev *hr_dev,
 		return -EINVAL;
 	}
 
-	unit = (1 << hem_list->bt_pg_shift) / BA_BYTE_LEN;
+	unit = (1 << bt_pg_shift) / BA_BYTE_LEN;
 	for (i = 0; i < region_cnt; i++) {
 		r = &regions[i];
 		if (!r->count)
@@ -1566,8 +1566,7 @@ void hns_roce_hem_list_release(struct hns_roce_dev *hr_dev,
 	hem_list->root_ba = 0;
 }
 
-void hns_roce_hem_list_init(struct hns_roce_hem_list *hem_list,
-			    int bt_page_order)
+void hns_roce_hem_list_init(struct hns_roce_hem_list *hem_list)
 {
 	int i, j;
 
@@ -1576,8 +1575,6 @@ void hns_roce_hem_list_init(struct hns_roce_hem_list *hem_list,
 	for (i = 0; i < HNS_ROCE_MAX_BT_REGION; i++)
 		for (j = 0; j < HNS_ROCE_MAX_BT_LEVEL; j++)
 			INIT_LIST_HEAD(&hem_list->mid_bt[i][j]);
-
-	hem_list->bt_pg_shift = bt_page_order;
 }
 
 void *hns_roce_hem_list_find_mtt(struct hns_roce_dev *hr_dev,
diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.h b/drivers/infiniband/hw/hns/hns_roce_hem.h
index 3bb8f78..a00b6c2 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.h
@@ -133,14 +133,13 @@ int hns_roce_calc_hem_mhop(struct hns_roce_dev *hr_dev,
 			   struct hns_roce_hem_mhop *mhop);
 bool hns_roce_check_whether_mhop(struct hns_roce_dev *hr_dev, u32 type);
 
-void hns_roce_hem_list_init(struct hns_roce_hem_list *hem_list,
-			    int bt_page_order);
+void hns_roce_hem_list_init(struct hns_roce_hem_list *hem_list);
 int hns_roce_hem_list_calc_root_ba(const struct hns_roce_buf_region *regions,
 				   int region_cnt, int unit);
 int hns_roce_hem_list_request(struct hns_roce_dev *hr_dev,
 			      struct hns_roce_hem_list *hem_list,
 			      const struct hns_roce_buf_region *regions,
-			      int region_cnt);
+			      int region_cnt, int bt_pg_shift);
 void hns_roce_hem_list_release(struct hns_roce_dev *hr_dev,
 			       struct hns_roce_hem_list *hem_list);
 void *hns_roce_hem_list_find_mtt(struct hns_roce_dev *hr_dev,
diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index 176f346..b3af369 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -1567,8 +1567,9 @@ int hns_roce_dealloc_mw(struct ib_mw *ibmw)
 void hns_roce_mtr_init(struct hns_roce_mtr *mtr, int bt_pg_shift,
 		       int buf_pg_shift)
 {
-	hns_roce_hem_list_init(&mtr->hem_list, bt_pg_shift);
-	mtr->buf_pg_shift = buf_pg_shift;
+	hns_roce_hem_list_init(&mtr->hem_list);
+	mtr->hem_cfg.buf_pg_shift = buf_pg_shift;
+	mtr->hem_cfg.ba_pg_shift = bt_pg_shift;
 }
 
 void hns_roce_mtr_cleanup(struct hns_roce_dev *hr_dev,
@@ -1577,19 +1578,23 @@ void hns_roce_mtr_cleanup(struct hns_roce_dev *hr_dev,
 	hns_roce_hem_list_release(hr_dev, &mtr->hem_list);
 }
 
-static int hns_roce_write_mtr(struct hns_roce_dev *hr_dev,
-			      struct hns_roce_mtr *mtr, dma_addr_t *bufs,
-			      struct hns_roce_buf_region *r)
+static int mtr_map_region(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
+			  dma_addr_t *pages, struct hns_roce_buf_region *region)
 {
+	__le64 *mtts;
 	int offset;
 	int count;
 	int npage;
-	u64 *mtts;
+	u64 addr;
 	int end;
 	int i;
 
-	offset = r->offset;
-	end = offset + r->count;
+	/* if hopnum is 0, buffer cannot store BAs, so skip write mtt */
+	if (!region->hopnum)
+		return 0;
+
+	offset = region->offset;
+	end = offset + region->count;
 	npage = 0;
 	while (offset < end) {
 		mtts = hns_roce_hem_list_find_mtt(hr_dev, &mtr->hem_list,
@@ -1597,13 +1602,13 @@ static int hns_roce_write_mtr(struct hns_roce_dev *hr_dev,
 		if (!mtts)
 			return -ENOBUFS;
 
-		/* Save page addr, low 12 bits : 0 */
 		for (i = 0; i < count; i++) {
 			if (hr_dev->hw_rev == HNS_ROCE_HW_VER1)
-				mtts[i] = bufs[npage] >> PAGE_ADDR_SHIFT;
+				addr = to_hr_hw_page_addr(pages[npage]);
 			else
-				mtts[i] = bufs[npage];
+				addr = pages[npage];
 
+			mtts[i] = cpu_to_le64(addr);
 			npage++;
 		}
 		offset += count;
@@ -1621,13 +1626,14 @@ int hns_roce_mtr_attach(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 	int i;
 
 	ret = hns_roce_hem_list_request(hr_dev, &mtr->hem_list, regions,
-					region_cnt);
+					region_cnt, mtr->hem_cfg.ba_pg_shift);
 	if (ret)
 		return ret;
 
+	mtr->hem_cfg.root_ba = mtr->hem_list.root_ba;
 	for (i = 0; i < region_cnt; i++) {
 		r = &regions[i];
-		ret = hns_roce_write_mtr(hr_dev, mtr, bufs[i], r);
+		ret = mtr_map_region(hr_dev, mtr, bufs[i], r);
 		if (ret) {
 			dev_err(hr_dev->dev,
 				"write mtr[%d/%d] err %d,offset=%d.\n",
@@ -1644,37 +1650,412 @@ int hns_roce_mtr_attach(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 	return ret;
 }
 
+static inline bool mtr_has_mtt(struct hns_roce_buf_attr *attr)
+{
+	int i;
+
+	for (i = 0; i < attr->region_count; i++)
+		if (attr->region[i].hopnum != HNS_ROCE_HOP_NUM_0 &&
+		    attr->region[i].hopnum > 0)
+			return true;
+
+	/* because the mtr only one root base address, when hopnum is 0 means
+	 * root base address equals the first buffer address, thus all alloced
+	 * memory must in a continuous space accessed by direct mode.
+	 */
+	return false;
+}
+
+static inline size_t mtr_bufs_size(struct hns_roce_buf_attr *attr)
+{
+	size_t size = 0;
+	int i;
+
+	for (i = 0; i < attr->region_count; i++)
+		size += attr->region[i].size;
+
+	return size;
+}
+
+static inline int mtr_umem_page_count(struct ib_umem *umem, int page_shift)
+{
+	int count = ib_umem_page_count(umem);
+
+	if (page_shift >= PAGE_SHIFT)
+		count >>= page_shift - PAGE_SHIFT;
+	else
+		count <<= PAGE_SHIFT - page_shift;
+
+	return count;
+}
+
+static inline size_t mtr_kmem_direct_size(bool is_direct, size_t alloc_size,
+					  int page_shift)
+{
+	if (is_direct)
+		return ALIGN(alloc_size, 1 << page_shift);
+	else
+		return HNS_HW_DIRECT_PAGE_COUNT << page_shift;
+}
+
+/*
+ * check the given pages in continuous address space
+ * Returns 0 on success, or the error page num.
+ */
+static inline int mtr_check_direct_pages(dma_addr_t *pages, int page_count,
+					 int page_shift)
+{
+	size_t page_size = 1 << page_shift;
+	int i;
+
+	for (i = 1; i < page_count; i++)
+		if (pages[i] - pages[i - 1] != page_size)
+			return i;
+
+	return 0;
+}
+
+static void mtr_free_bufs(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr)
+{
+	/* release user buffers */
+	if (mtr->umem) {
+		ib_umem_release(mtr->umem);
+		mtr->umem = NULL;
+	}
+
+	/* release kernel buffers */
+	if (mtr->kmem) {
+		hns_roce_buf_free(hr_dev, mtr->kmem);
+		kfree(mtr->kmem);
+		mtr->kmem = NULL;
+	}
+}
+
+static int mtr_alloc_bufs(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
+			  struct hns_roce_buf_attr *buf_attr, bool is_direct,
+			  struct ib_udata *udata, unsigned long user_addr)
+{
+	struct ib_device *ibdev = &hr_dev->ib_dev;
+	int max_pg_shift = buf_attr->page_shift;
+	int best_pg_shift = 0;
+	int all_pg_count = 0;
+	size_t direct_size;
+	size_t total_size;
+	unsigned long tmp;
+	int ret = 0;
+
+	total_size = mtr_bufs_size(buf_attr);
+	if (total_size < 1) {
+		ibdev_err(ibdev, "Failed to check mtr size\n");
+		return -EINVAL;
+	}
+
+	if (udata) {
+		mtr->kmem = NULL;
+		mtr->umem = ib_umem_get(ibdev, user_addr, total_size,
+					buf_attr->user_access);
+		if (IS_ERR_OR_NULL(mtr->umem)) {
+			ibdev_err(ibdev, "Failed to get umem, ret %ld\n",
+				  PTR_ERR(mtr->umem));
+			return -ENOMEM;
+		}
+		if (buf_attr->fixed_page) {
+			best_pg_shift = max_pg_shift;
+		} else {
+			tmp = GENMASK(max_pg_shift, 0);
+			ret = ib_umem_find_best_pgsz(mtr->umem, tmp, user_addr);
+			best_pg_shift = (ret <= PAGE_SIZE) ?
+					PAGE_SHIFT : ilog2(ret);
+		}
+		all_pg_count = mtr_umem_page_count(mtr->umem, best_pg_shift);
+		ret = 0;
+	} else {
+		mtr->umem = NULL;
+		mtr->kmem = kzalloc(sizeof(*mtr->kmem), GFP_KERNEL);
+		if (!mtr->kmem) {
+			ibdev_err(ibdev, "Failed to alloc kmem\n");
+			return -ENOMEM;
+		}
+		direct_size = mtr_kmem_direct_size(is_direct, total_size,
+						   max_pg_shift);
+		ret = hns_roce_buf_alloc(hr_dev, total_size, direct_size,
+					 mtr->kmem, max_pg_shift);
+		if (ret) {
+			ibdev_err(ibdev, "Failed to alloc kmem, ret %d\n", ret);
+			goto err_alloc_mem;
+		} else {
+			best_pg_shift = max_pg_shift;
+			all_pg_count = mtr->kmem->npages;
+		}
+	}
+
+	/* must bigger than minimum hardware page shift */
+	if (best_pg_shift < PAGE_ADDR_SHIFT || all_pg_count < 1) {
+		ret = -EINVAL;
+		ibdev_err(ibdev, "Failed to check mtr page shift %d count %d\n",
+			  best_pg_shift, all_pg_count);
+		goto err_alloc_mem;
+	}
+
+	mtr->hem_cfg.buf_pg_shift = best_pg_shift;
+	mtr->hem_cfg.buf_pg_count = all_pg_count;
+
+	return 0;
+err_alloc_mem:
+	mtr_free_bufs(hr_dev, mtr);
+	return ret;
+}
+
+static int mtr_get_pages(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
+			 dma_addr_t *pages, int count, int page_shift)
+{
+	struct ib_device *ibdev = &hr_dev->ib_dev;
+	int npage;
+	int err;
+
+	if (mtr->umem)
+		npage = hns_roce_get_umem_bufs(hr_dev, pages, count, 0,
+					       mtr->umem, page_shift);
+	else
+		npage = hns_roce_get_kmem_bufs(hr_dev, pages, count, 0,
+					       mtr->kmem);
+
+	if (mtr->hem_cfg.is_direct && npage > 1) {
+		err = mtr_check_direct_pages(pages, npage, page_shift);
+		if (err) {
+			ibdev_err(ibdev, "Failed to check %s direct page-%d\n",
+				  mtr->umem ? "user" : "kernel", err);
+			npage = err;
+		}
+	}
+
+	return npage;
+}
+
+int hns_roce_mtr_map(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
+		     struct hns_roce_buf_region *regions, int region_cnt,
+		     dma_addr_t *pages, int page_cnt)
+{
+	struct ib_device *ibdev = &hr_dev->ib_dev;
+	struct hns_roce_buf_region *r;
+	int err;
+	int i;
+
+	for (i = 0; i < region_cnt; i++) {
+		r = &regions[i];
+		if (r->offset + r->count > page_cnt) {
+			err = -EINVAL;
+			ibdev_err(ibdev,
+				  "Failed to check mtr%d end %d + %d, max %d\n",
+				  i, r->offset, r->count, page_cnt);
+			return err;
+		}
+
+		err = mtr_map_region(hr_dev, mtr, &pages[r->offset], r);
+		if (err) {
+			ibdev_err(ibdev,
+				  "Failed to map mtr%d offset %d, err %d\n",
+				  i, r->offset, err);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
 int hns_roce_mtr_find(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 		      int offset, u64 *mtt_buf, int mtt_max, u64 *base_addr)
 {
-	u64 *mtts = mtt_buf;
 	int mtt_count;
 	int total = 0;
-	u64 *addr;
+	__le64 *mtts;
 	int npage;
+	u64 addr;
 	int left;
 
-	if (mtts == NULL || mtt_max < 1)
+	if (!mtt_buf || mtt_max < 1)
 		goto done;
 
+	/* no mtt memory in direct mode, so just return the buffer address */
+	if (mtr->hem_cfg.is_direct) {
+		npage = offset;
+		for (total = 0; total < mtt_max; total++, npage++) {
+			addr = mtr->hem_cfg.root_ba +
+			       (npage << mtr->hem_cfg.buf_pg_shift);
+
+			if (hr_dev->hw_rev == HNS_ROCE_HW_VER1)
+				mtt_buf[total] = to_hr_hw_page_addr(addr);
+			else
+				mtt_buf[total] = addr;
+		}
+
+		goto done;
+	}
+
 	left = mtt_max;
 	while (left > 0) {
 		mtt_count = 0;
-		addr = hns_roce_hem_list_find_mtt(hr_dev, &mtr->hem_list,
+		mtts = hns_roce_hem_list_find_mtt(hr_dev, &mtr->hem_list,
 						  offset + total,
 						  &mtt_count, NULL);
-		if (!addr || !mtt_count)
+		if (!mtts || !mtt_count)
 			goto done;
 
 		npage = min(mtt_count, left);
-		memcpy(&mtts[total], addr, BA_BYTE_LEN * npage);
 		left -= npage;
-		total += npage;
+		for (mtt_count = 0; mtt_count < npage; mtt_count++)
+			mtt_buf[total++] = le64_to_cpu(mtts[mtt_count]);
 	}
 
 done:
 	if (base_addr)
-		*base_addr = mtr->hem_list.root_ba;
+		*base_addr = mtr->hem_cfg.root_ba;
 
 	return total;
 }
+
+/* convert buffer size to page index and page count */
+static int mtr_init_region(struct hns_roce_buf_attr *attr, int page_cnt,
+			   struct hns_roce_buf_region *regions, int region_cnt,
+			   int page_shift)
+{
+	unsigned int page_size = 1 << page_shift;
+	int max_region = attr->region_count;
+	struct hns_roce_buf_region *r;
+	int page_idx = 0;
+	int i = 0;
+
+	for (; i < region_cnt && i < max_region && page_idx < page_cnt; i++) {
+		r = &regions[i];
+		r->hopnum = attr->region[i].hopnum == HNS_ROCE_HOP_NUM_0 ?
+			    0 : attr->region[i].hopnum;
+		r->offset = page_idx;
+		r->count = DIV_ROUND_UP(attr->region[i].size, page_size);
+		page_idx += r->count;
+	}
+
+	return i;
+}
+
+/**
+ * hns_roce_mtr_create - Create hns memory translate region.
+ *
+ * @mtr: memory translate region
+ * @init_attr: init attribute for creating mtr
+ * @page_shift: page shift for multi-hop base address table
+ * @udata: user space context, if it's NULL, means kernel space
+ * @user_addr: userspace virtual address to start at
+ * @buf_alloced: mtr has private buffer, true means need to alloc
+ */
+int hns_roce_mtr_create(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
+			struct hns_roce_buf_attr *buf_attr, int page_shift,
+			struct ib_udata *udata, unsigned long user_addr)
+{
+	struct hns_roce_buf_region regions[HNS_ROCE_MAX_BT_REGION] = {};
+	struct ib_device *ibdev = &hr_dev->ib_dev;
+	dma_addr_t *pages = NULL;
+	int region_cnt = 0;
+	int all_pg_cnt;
+	int get_pg_cnt;
+	bool has_mtt;
+	int err = 0;
+
+	has_mtt = mtr_has_mtt(buf_attr);
+	/* if buffer only need mtt, just init the hem cfg */
+	if (buf_attr->mtt_only) {
+		mtr->hem_cfg.buf_pg_shift = buf_attr->page_shift;
+		mtr->hem_cfg.buf_pg_count = mtr_bufs_size(buf_attr) >>
+					    buf_attr->page_shift;
+		mtr->umem = NULL;
+		mtr->kmem = NULL;
+	} else {
+		err = mtr_alloc_bufs(hr_dev, mtr, buf_attr, !has_mtt, udata,
+				     user_addr);
+		if (err) {
+			ibdev_err(ibdev, "Failed to alloc mtr bufs, err %d\n",
+				  err);
+			return err;
+		}
+	}
+
+	/* alloc mtt memory */
+	all_pg_cnt = mtr->hem_cfg.buf_pg_count;
+	hns_roce_hem_list_init(&mtr->hem_list);
+	mtr->hem_cfg.is_direct = !has_mtt;
+	mtr->hem_cfg.ba_pg_shift = page_shift;
+	if (has_mtt) {
+		region_cnt = mtr_init_region(buf_attr, all_pg_cnt,
+					     regions, ARRAY_SIZE(regions),
+					     mtr->hem_cfg.buf_pg_shift);
+		if (region_cnt < 1) {
+			err = -ENOBUFS;
+			ibdev_err(ibdev, "Failed to init mtr region %d\n",
+				  region_cnt);
+			goto err_alloc_bufs;
+		}
+		err = hns_roce_hem_list_request(hr_dev, &mtr->hem_list,
+						regions, region_cnt,
+						page_shift);
+		if (err) {
+			ibdev_err(ibdev, "Failed to request mtr hem, err %d\n",
+				  err);
+			goto err_alloc_bufs;
+		}
+		mtr->hem_cfg.root_ba = mtr->hem_list.root_ba;
+	}
+
+	/* no buffer to map */
+	if (buf_attr->mtt_only)
+		return 0;
+
+	/* alloc a tmp array to store buffer's dma address */
+	pages = kvcalloc(all_pg_cnt, sizeof(dma_addr_t), GFP_KERNEL);
+	if (!pages) {
+		err = -ENOMEM;
+		ibdev_err(ibdev, "Failed to alloc mtr page list %d\n",
+			  all_pg_cnt);
+		goto err_alloc_hem_list;
+	}
+
+	get_pg_cnt = mtr_get_pages(hr_dev, mtr, pages, all_pg_cnt,
+				   mtr->hem_cfg.buf_pg_shift);
+	if (get_pg_cnt != all_pg_cnt) {
+		ibdev_err(ibdev, "Failed to get mtr page %d != %d\n",
+			  get_pg_cnt, all_pg_cnt);
+		err = -ENOBUFS;
+		goto err_alloc_page_list;
+	}
+
+	if (!has_mtt) {
+		mtr->hem_cfg.root_ba = pages[0];
+	} else {
+		/* write buffer's dma address to BA table */
+		err = hns_roce_mtr_map(hr_dev, mtr, regions, region_cnt, pages,
+				       all_pg_cnt);
+		if (err) {
+			ibdev_err(ibdev, "Failed to map mtr pages, err %d\n",
+				  err);
+			goto err_alloc_page_list;
+		}
+	}
+
+	/* drop tmp array */
+	kvfree(pages);
+	return 0;
+err_alloc_page_list:
+	kvfree(pages);
+err_alloc_hem_list:
+	hns_roce_hem_list_release(hr_dev, &mtr->hem_list);
+err_alloc_bufs:
+	mtr_free_bufs(hr_dev, mtr);
+	return err;
+}
+
+void hns_roce_mtr_destroy(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr)
+{
+	/* release multi-hop addressing resource */
+	hns_roce_hem_list_release(hr_dev, &mtr->hem_list);
+
+	/* free buffers */
+	mtr_free_bufs(hr_dev, mtr);
+}
-- 
2.8.1

