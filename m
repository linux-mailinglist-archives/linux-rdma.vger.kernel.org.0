Return-Path: <linux-rdma+bounces-487-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2ADA81DEEF
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Dec 2023 08:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6D4A1C20A9A
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Dec 2023 07:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0BAF258D;
	Mon, 25 Dec 2023 07:58:20 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD91D23D3;
	Mon, 25 Dec 2023 07:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Sz9Gf55q0z1R5p3;
	Mon, 25 Dec 2023 15:56:58 +0800 (CST)
Received: from kwepemi500006.china.huawei.com (unknown [7.221.188.68])
	by mail.maildlp.com (Postfix) with ESMTPS id DF3B11A0198;
	Mon, 25 Dec 2023 15:58:01 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 25 Dec 2023 15:57:17 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH for-next 4/6] RDMA/hns: Support flexible pagesize
Date: Mon, 25 Dec 2023 15:53:28 +0800
Message-ID: <20231225075330.4116470-5-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20231225075330.4116470-1-huangjunxian6@hisilicon.com>
References: <20231225075330.4116470-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500006.china.huawei.com (7.221.188.68)

From: Chengchang Tang <tangchengchang@huawei.com>

In the current implementation, a fixed page size is used to
configure the PBL, which is not flexible enough and is not
conducive to the performance of the HW.

Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_alloc.c  |   6 -
 drivers/infiniband/hw/hns/hns_roce_device.h |   9 ++
 drivers/infiniband/hw/hns/hns_roce_mr.c     | 168 +++++++++++++++-----
 3 files changed, 139 insertions(+), 44 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_alloc.c b/drivers/infiniband/hw/hns/hns_roce_alloc.c
index 11a78ceae568..60269322ba98 100644
--- a/drivers/infiniband/hw/hns/hns_roce_alloc.c
+++ b/drivers/infiniband/hw/hns/hns_roce_alloc.c
@@ -137,12 +137,6 @@ int hns_roce_get_kmem_bufs(struct hns_roce_dev *hr_dev, dma_addr_t *bufs,
 	int total = 0;
 	int i;
 
-	if (page_shift > buf->trunk_shift) {
-		dev_err(hr_dev->dev, "failed to check kmem buf shift %u > %u\n",
-			page_shift, buf->trunk_shift);
-		return -EINVAL;
-	}
-
 	offset = 0;
 	max_size = buf->ntrunks << buf->trunk_shift;
 	for (i = 0; i < buf_cnt && offset < max_size; i++) {
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index dd652dc090b0..1a8516019516 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -179,6 +179,7 @@ enum {
 
 #define HNS_ROCE_CMD_SUCCESS			1
 
+#define HNS_ROCE_MAX_HOP_NUM			3
 /* The minimum page size is 4K for hardware */
 #define HNS_HW_PAGE_SHIFT			12
 #define HNS_HW_PAGE_SIZE			(1 << HNS_HW_PAGE_SHIFT)
@@ -269,6 +270,11 @@ struct hns_roce_hem_list {
 	dma_addr_t root_ba; /* pointer to the root ba table */
 };
 
+enum mtr_type {
+	MTR_DEFAULT = 0,
+	MTR_PBL,
+};
+
 struct hns_roce_buf_attr {
 	struct {
 		size_t	size;  /* region size */
@@ -277,7 +283,10 @@ struct hns_roce_buf_attr {
 	unsigned int region_count; /* valid region count */
 	unsigned int page_shift;  /* buffer page shift */
 	unsigned int user_access; /* umem access flag */
+	u64 iova;
+	enum mtr_type type;
 	bool mtt_only; /* only alloc buffer-required MTT memory */
+	bool adaptive; /* adaptive for page_shift and hopnum */
 };
 
 struct hns_roce_hem_cfg {
diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index 74ea9d8482b9..d3a8b342c38c 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -32,6 +32,7 @@
  */
 
 #include <linux/vmalloc.h>
+#include <linux/count_zeros.h>
 #include <rdma/ib_umem.h>
 #include <linux/math.h>
 #include "hns_roce_device.h"
@@ -103,6 +104,10 @@ static int alloc_mr_pbl(struct hns_roce_dev *hr_dev, struct hns_roce_mr *mr,
 	buf_attr.user_access = mr->access;
 	/* fast MR's buffer is alloced before mapping, not at creation */
 	buf_attr.mtt_only = is_fast;
+	buf_attr.iova = mr->iova;
+	/* pagesize and hopnum is fixed for fast MR */
+	buf_attr.adaptive = !is_fast;
+	buf_attr.type = MTR_PBL;
 
 	err = hns_roce_mtr_create(hr_dev, &mr->pbl_mtr, &buf_attr,
 				  hr_dev->caps.pbl_ba_pg_sz + PAGE_SHIFT,
@@ -721,6 +726,16 @@ static int cal_mtr_pg_cnt(struct hns_roce_mtr *mtr)
 	return page_cnt;
 }
 
+static bool need_split_huge_page(struct hns_roce_mtr *mtr)
+{
+	/* When HEM buffer uses 0-level addressing, the page size is
+	 * equal to the whole buffer size. If the current MTR has multiple
+	 * regions, we split the buffer into small pages(4k, required by hns
+	 * ROCEE). These pages will be used in multiple regions.
+	 */
+	return mtr->hem_cfg.is_direct && mtr->hem_cfg.region_count > 1;
+}
+
 static int mtr_map_bufs(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr)
 {
 	struct ib_device *ibdev = &hr_dev->ib_dev;
@@ -730,14 +745,8 @@ static int mtr_map_bufs(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr)
 	int npage;
 	int ret;
 
-	/* When HEM buffer uses 0-level addressing, the page size is
-	 * equal to the whole buffer size, and we split the buffer into
-	 * small pages which is used to check whether the adjacent
-	 * units are in the continuous space and its size is fixed to
-	 * 4K based on hns ROCEE's requirement.
-	 */
-	page_shift = mtr->hem_cfg.is_direct ? HNS_HW_PAGE_SHIFT :
-					      mtr->hem_cfg.buf_pg_shift;
+	page_shift = need_split_huge_page(mtr) ? HNS_HW_PAGE_SHIFT :
+						 mtr->hem_cfg.buf_pg_shift;
 	/* alloc a tmp array to store buffer's dma address */
 	pages = kvcalloc(page_count, sizeof(dma_addr_t), GFP_KERNEL);
 	if (!pages)
@@ -757,7 +766,7 @@ static int mtr_map_bufs(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr)
 		goto err_alloc_list;
 	}
 
-	if (mtr->hem_cfg.is_direct && npage > 1) {
+	if (need_split_huge_page(mtr) && npage > 1) {
 		ret = mtr_check_direct_pages(pages, npage, page_shift);
 		if (ret) {
 			ibdev_err(ibdev, "failed to check %s page: %d / %d.\n",
@@ -915,56 +924,136 @@ int hns_roce_mtr_find(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 	return ret;
 }
 
-static int mtr_init_buf_cfg(struct hns_roce_dev *hr_dev,
-			    struct hns_roce_buf_attr *attr,
-			    struct hns_roce_hem_cfg *cfg, u64 unalinged_size)
+/**
+ * hns_roce_find_buf_best_pgsz - Find best page size of the kmem.
+ *
+ * @hr_dev: hns_roce_dev struct
+ * @buf: kmem
+ *
+ * This function helps all DMA regions using multi-level addressing to
+ * find the best page size in kmem.
+ *
+ * Returns 0 if the find the best pagesize failed.
+ */
+static unsigned int hns_roce_find_buf_best_pgsz(struct hns_roce_dev *hr_dev,
+						struct hns_roce_buf *buf)
+{
+	unsigned long pgsz_bitmap = hr_dev->caps.page_size_cap;
+	u64 trunk_size = 1 << buf->trunk_shift;
+	u64 buf_size = trunk_size * buf->ntrunks;
+	dma_addr_t dma_addr = 0;
+	dma_addr_t mask;
+	int i;
+
+	/* trunk_shift determines the size of each buf not PAGE_SIZE. */
+	pgsz_bitmap &= GENMASK(BITS_PER_LONG - 1, buf->trunk_shift);
+	/* Best page size should smaller than the actual size of the block. */
+	mask = pgsz_bitmap &
+	       GENMASK(BITS_PER_LONG - 1,
+		       bits_per((buf_size + dma_addr) ^ dma_addr));
+
+	for (i = 0; i < buf->ntrunks; i++) {
+		/* Walk kmem bufs to make sure that the start address of the
+		 * current DMA block and the end address of the previous DMA
+		 * block have the same offset, otherwise the page will be
+		 * reduced.
+		 */
+		mask |= dma_addr ^ buf->trunk_list[i].map;
+		dma_addr = buf->trunk_list[i].map + trunk_size;
+	}
+
+	if (mask)
+		pgsz_bitmap &= GENMASK(count_trailing_zeros(mask), 0);
+	return pgsz_bitmap ? rounddown_pow_of_two(pgsz_bitmap) : 0;
+}
+
+static int get_best_page_shift(struct hns_roce_dev *hr_dev,
+			       struct hns_roce_mtr *mtr,
+			       struct hns_roce_buf_attr *buf_attr)
+{
+	unsigned int page_sz;
+
+	if (!buf_attr->adaptive || buf_attr->type != MTR_PBL)
+		return 0;
+
+	if (mtr->umem)
+		page_sz = ib_umem_find_best_pgsz(mtr->umem,
+						 hr_dev->caps.page_size_cap,
+						 buf_attr->iova);
+	else
+		page_sz = hns_roce_find_buf_best_pgsz(hr_dev, mtr->kmem);
+
+	if (!page_sz)
+		return -EINVAL;
+
+	buf_attr->page_shift = order_base_2(page_sz);
+	return 0;
+}
+
+static bool is_buf_attr_valid(struct hns_roce_dev *hr_dev,
+			      struct hns_roce_buf_attr *attr)
 {
 	struct ib_device *ibdev = &hr_dev->ib_dev;
+
+	if (attr->region_count > ARRAY_SIZE(attr->region) ||
+	    attr->region_count < 1 || attr->page_shift < HNS_HW_PAGE_SHIFT) {
+		ibdev_err(ibdev,
+			  "invalid buf attr, region count %d, page shift %u.\n",
+			  attr->region_count, attr->page_shift);
+		return false;
+	}
+
+	return true;
+}
+
+static int mtr_init_buf_cfg(struct hns_roce_dev *hr_dev,
+			    struct hns_roce_mtr *mtr,
+			    struct hns_roce_buf_attr *attr)
+{
+	struct hns_roce_hem_cfg *cfg = &mtr->hem_cfg;
 	struct hns_roce_buf_region *r;
-	u64 first_region_padding;
-	int page_cnt, region_cnt;
 	size_t buf_pg_sz;
 	size_t buf_size;
+	int page_cnt, i;
+	u64 pgoff = 0;
+
+	if (!is_buf_attr_valid(hr_dev, attr))
+		return -EINVAL;
 
 	/* If mtt is disabled, all pages must be within a continuous range */
 	cfg->is_direct = !mtr_has_mtt(attr);
+	cfg->region_count = attr->region_count;
 	buf_size = mtr_bufs_size(attr);
-	if (cfg->is_direct) {
+	if (need_split_huge_page(mtr)) {
 		buf_pg_sz = HNS_HW_PAGE_SIZE;
 		cfg->buf_pg_count = 1;
 		/* The ROCEE requires the page size to be 4K * 2 ^ N. */
 		cfg->buf_pg_shift = HNS_HW_PAGE_SHIFT +
 			order_base_2(DIV_ROUND_UP(buf_size, HNS_HW_PAGE_SIZE));
-		first_region_padding = 0;
 	} else {
-		cfg->buf_pg_count = DIV_ROUND_UP(buf_size + unalinged_size,
-						 1 << attr->page_shift);
+		buf_pg_sz = 1 << attr->page_shift;
+		cfg->buf_pg_count = mtr->umem ?
+			ib_umem_num_dma_blocks(mtr->umem, buf_pg_sz) :
+			DIV_ROUND_UP(buf_size, buf_pg_sz);
 		cfg->buf_pg_shift = attr->page_shift;
-		buf_pg_sz = 1 << cfg->buf_pg_shift;
-		first_region_padding = unalinged_size;
+		pgoff = mtr->umem ? mtr->umem->address & ~PAGE_MASK : 0;
 	}
 
 	/* Convert buffer size to page index and page count for each region and
 	 * the buffer's offset needs to be appended to the first region.
 	 */
-	for (page_cnt = 0, region_cnt = 0; region_cnt < attr->region_count &&
-	     region_cnt < ARRAY_SIZE(cfg->region); region_cnt++) {
-		r = &cfg->region[region_cnt];
+	for (page_cnt = 0, i = 0; i < attr->region_count; i++) {
+		r = &cfg->region[i];
 		r->offset = page_cnt;
-		buf_size = hr_hw_page_align(attr->region[region_cnt].size +
-					    first_region_padding);
-		r->count = DIV_ROUND_UP(buf_size, buf_pg_sz);
-		first_region_padding = 0;
-		page_cnt += r->count;
-		r->hopnum = to_hr_hem_hopnum(attr->region[region_cnt].hopnum,
-					     r->count);
-	}
+		buf_size = hr_hw_page_align(attr->region[i].size + pgoff);
+		if (attr->type == MTR_PBL && mtr->umem)
+			r->count = ib_umem_num_dma_blocks(mtr->umem, buf_pg_sz);
+		else
+			r->count = DIV_ROUND_UP(buf_size, buf_pg_sz);
 
-	cfg->region_count = region_cnt;
-	if (cfg->region_count < 1 || cfg->buf_pg_shift < HNS_HW_PAGE_SHIFT) {
-		ibdev_err(ibdev, "failed to init mtr cfg, count %d shift %u.\n",
-			  cfg->region_count, cfg->buf_pg_shift);
-		return -EINVAL;
+		pgoff = 0;
+		page_cnt += r->count;
+		r->hopnum = to_hr_hem_hopnum(attr->region[i].hopnum, r->count);
 	}
 
 	return 0;
@@ -1054,7 +1143,6 @@ int hns_roce_mtr_create(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 			unsigned int ba_page_shift, struct ib_udata *udata,
 			unsigned long user_addr)
 {
-	u64 pgoff = udata ? user_addr & ~PAGE_MASK : 0;
 	struct ib_device *ibdev = &hr_dev->ib_dev;
 	int ret;
 
@@ -1071,9 +1159,13 @@ int hns_roce_mtr_create(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 				  "failed to alloc mtr bufs, ret = %d.\n", ret);
 			return ret;
 		}
+
+		ret = get_best_page_shift(hr_dev, mtr, buf_attr);
+		if (ret)
+			goto err_init_buf;
 	}
 
-	ret = mtr_init_buf_cfg(hr_dev, buf_attr, &mtr->hem_cfg, pgoff);
+	ret = mtr_init_buf_cfg(hr_dev, mtr, buf_attr);
 	if (ret)
 		goto err_init_buf;
 
-- 
2.30.0


