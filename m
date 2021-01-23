Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45DEE301459
	for <lists+linux-rdma@lfdr.de>; Sat, 23 Jan 2021 10:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbhAWJu7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 23 Jan 2021 04:50:59 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11183 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbhAWJu7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 23 Jan 2021 04:50:59 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DNBCg5Skdzl7q2;
        Sat, 23 Jan 2021 17:48:47 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Sat, 23 Jan 2021 17:50:09 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: [PATCH v2 for-next 1/3] RDMA/hns: Refactor the MTR creation flow
Date:   Sat, 23 Jan 2021 17:48:00 +0800
Message-ID: <1611395282-991-2-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1611395282-991-1-git-send-email-liweihang@huawei.com>
References: <1611395282-991-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

Split the hns_roce_mtr_create() into serval small functions, remove unused
member in 'struct hns_roce_buf_attr' and delete unnecessary MTR page count
check flow to make the MTR creation related codes clearer.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_cq.c     |   1 -
 drivers/infiniband/hw/hns/hns_roce_device.h |   1 -
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |   1 -
 drivers/infiniband/hw/hns/hns_roce_mr.c     | 291 ++++++++++++----------------
 drivers/infiniband/hw/hns/hns_roce_qp.c     |   1 -
 drivers/infiniband/hw/hns/hns_roce_srq.c    |   2 -
 6 files changed, 125 insertions(+), 172 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_cq.c b/drivers/infiniband/hw/hns/hns_roce_cq.c
index ffb7f7e..74fc494 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cq.c
@@ -206,7 +206,6 @@ static int alloc_cq_buf(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq,
 	buf_attr.region[0].size = hr_cq->cq_depth * hr_cq->cqe_size;
 	buf_attr.region[0].hopnum = hr_dev->caps.cqe_hop_num;
 	buf_attr.region_count = 1;
-	buf_attr.fixed_page = true;
 
 	ret = hns_roce_mtr_create(hr_dev, &hr_cq->mtr, &buf_attr,
 				  hr_dev->caps.cqe_ba_pg_sz + HNS_HW_PAGE_SHIFT,
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index c46b330..ffed82d 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -335,7 +335,6 @@ struct hns_roce_buf_attr {
 	} region[HNS_ROCE_MAX_BT_REGION];
 	unsigned int region_count; /* valid region count */
 	unsigned int page_shift;  /* buffer page shift */
-	bool fixed_page; /* decide page shift is fixed-size or maximum size */
 	unsigned int user_access; /* umem access flag */
 	bool mtt_only; /* only alloc buffer-required MTT memory */
 };
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 4c06889..110354b 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -5948,7 +5948,6 @@ static int alloc_eq_buf(struct hns_roce_dev *hr_dev, struct hns_roce_eq *eq)
 	buf_attr.region[0].size = eq->entries * eq->eqe_size;
 	buf_attr.region[0].hopnum = eq->hop_num;
 	buf_attr.region_count = 1;
-	buf_attr.fixed_page = true;
 
 	err = hns_roce_mtr_create(hr_dev, &eq->mtr, &buf_attr,
 				  hr_dev->caps.eqe_ba_pg_sz +
diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index 1fbfa3a..45ceeab 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -124,7 +124,6 @@ static int alloc_mr_pbl(struct hns_roce_dev *hr_dev, struct hns_roce_mr *mr,
 	buf_attr.region[0].size = length;
 	buf_attr.region[0].hopnum = mr->pbl_hop_num;
 	buf_attr.region_count = 1;
-	buf_attr.fixed_page = true;
 	buf_attr.user_access = access;
 	/* fast MR's buffer is alloced before mapping, not at creation */
 	buf_attr.mtt_only = is_fast;
@@ -729,25 +728,15 @@ static void mtr_free_bufs(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr)
 }
 
 static int mtr_alloc_bufs(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
-			  struct hns_roce_buf_attr *buf_attr, bool is_direct,
+			  struct hns_roce_buf_attr *buf_attr,
 			  struct ib_udata *udata, unsigned long user_addr)
 {
 	struct ib_device *ibdev = &hr_dev->ib_dev;
-	unsigned int best_pg_shift;
-	int all_pg_count = 0;
 	size_t total_size;
-	int ret;
 
 	total_size = mtr_bufs_size(buf_attr);
-	if (total_size < 1) {
-		ibdev_err(ibdev, "failed to check mtr size\n.");
-		return -EINVAL;
-	}
 
 	if (udata) {
-		unsigned long pgsz_bitmap;
-		unsigned long page_size;
-
 		mtr->kmem = NULL;
 		mtr->umem = ib_umem_get(ibdev, user_addr, total_size,
 					buf_attr->user_access);
@@ -756,76 +745,67 @@ static int mtr_alloc_bufs(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 				  PTR_ERR(mtr->umem));
 			return -ENOMEM;
 		}
-		if (buf_attr->fixed_page)
-			pgsz_bitmap = 1 << buf_attr->page_shift;
-		else
-			pgsz_bitmap = GENMASK(buf_attr->page_shift, PAGE_SHIFT);
-
-		page_size = ib_umem_find_best_pgsz(mtr->umem, pgsz_bitmap,
-						   user_addr);
-		if (!page_size)
-			return -EINVAL;
-		best_pg_shift = order_base_2(page_size);
-		all_pg_count = ib_umem_num_dma_blocks(mtr->umem, page_size);
-		ret = 0;
 	} else {
 		mtr->umem = NULL;
-		mtr->kmem =
-			hns_roce_buf_alloc(hr_dev, total_size,
-					   buf_attr->page_shift,
-					   is_direct ? HNS_ROCE_BUF_DIRECT : 0);
+		mtr->kmem = hns_roce_buf_alloc(hr_dev, total_size,
+					       buf_attr->page_shift,
+					       mtr->hem_cfg.is_direct ?
+					       HNS_ROCE_BUF_DIRECT : 0);
 		if (IS_ERR(mtr->kmem)) {
 			ibdev_err(ibdev, "failed to alloc kmem, ret = %ld.\n",
 				  PTR_ERR(mtr->kmem));
 			return PTR_ERR(mtr->kmem);
 		}
-
-		best_pg_shift = buf_attr->page_shift;
-		all_pg_count = mtr->kmem->npages;
 	}
 
-	/* must bigger than minimum hardware page shift */
-	if (best_pg_shift < HNS_HW_PAGE_SHIFT || all_pg_count < 1) {
-		ret = -EINVAL;
-		ibdev_err(ibdev,
-			  "failed to check mtr, page shift = %u count = %d.\n",
-			  best_pg_shift, all_pg_count);
-		goto err_alloc_mem;
-	}
-
-	mtr->hem_cfg.buf_pg_shift = best_pg_shift;
-	mtr->hem_cfg.buf_pg_count = all_pg_count;
-
 	return 0;
-err_alloc_mem:
-	mtr_free_bufs(hr_dev, mtr);
-	return ret;
 }
 
-static int mtr_get_pages(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
-			 dma_addr_t *pages, int count, unsigned int page_shift)
+static int mtr_map_bufs(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
+			int page_count, unsigned int page_shift)
 {
 	struct ib_device *ibdev = &hr_dev->ib_dev;
+	dma_addr_t *pages;
 	int npage;
-	int err;
+	int ret;
+
+	/* alloc a tmp array to store buffer's dma address */
+	pages = kvcalloc(page_count, sizeof(dma_addr_t), GFP_KERNEL);
+	if (!pages)
+		return -ENOMEM;
 
 	if (mtr->umem)
-		npage = hns_roce_get_umem_bufs(hr_dev, pages, count, 0,
+		npage = hns_roce_get_umem_bufs(hr_dev, pages, page_count, 0,
 					       mtr->umem, page_shift);
 	else
-		npage = hns_roce_get_kmem_bufs(hr_dev, pages, count, 0,
+		npage = hns_roce_get_kmem_bufs(hr_dev, pages, page_count, 0,
 					       mtr->kmem);
 
+	if (npage != page_count) {
+		ibdev_err(ibdev, "failed to get mtr page %d != %d.\n", npage,
+			  page_count);
+		ret = -ENOBUFS;
+		goto err_alloc_list;
+	}
+
 	if (mtr->hem_cfg.is_direct && npage > 1) {
-		err = mtr_check_direct_pages(pages, npage, page_shift);
-		if (err) {
-			ibdev_err(ibdev, "Failed to check %s direct page-%d\n",
-				  mtr->umem ? "user" : "kernel", err);
-			npage = err;
+		ret = mtr_check_direct_pages(pages, npage, page_shift);
+		if (ret) {
+			ibdev_err(ibdev, "failed to check %s mtr, idx = %d.\n",
+				  mtr->umem ? "user" : "kernel", ret);
+			ret = -ENOBUFS;
+			goto err_alloc_list;
 		}
 	}
 
-	return npage;
+	ret = hns_roce_mtr_map(hr_dev, mtr, pages, page_count);
+	if (ret)
+		ibdev_err(ibdev, "failed to map mtr pages, ret = %d.\n", ret);
+
+err_alloc_list:
+	kvfree(pages);
+
+	return ret;
 }
 
 int hns_roce_mtr_map(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
@@ -928,65 +908,88 @@ int hns_roce_mtr_find(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 static int mtr_init_buf_cfg(struct hns_roce_dev *hr_dev,
 			    struct hns_roce_buf_attr *attr,
 			    struct hns_roce_hem_cfg *cfg,
-			    unsigned int *buf_page_shift)
+			    unsigned int *buf_page_shift, int unalinged_size)
 {
 	struct hns_roce_buf_region *r;
+	int first_region_padding;
+	int page_cnt, region_cnt;
 	unsigned int page_shift;
-	int page_cnt = 0;
 	size_t buf_size;
-	int region_cnt;
 
+	/* If mtt is disabled, all pages must be within a continuous range */
+	cfg->is_direct = !mtr_has_mtt(attr);
+	buf_size = mtr_bufs_size(attr);
 	if (cfg->is_direct) {
-		buf_size = cfg->buf_pg_count << cfg->buf_pg_shift;
-		page_cnt = DIV_ROUND_UP(buf_size, HNS_HW_PAGE_SIZE);
-		/*
-		 * When HEM buffer use level-0 addressing, the page size equals
-		 * the buffer size, and the the page size = 4K * 2^N.
+		/* When HEM buffer uses 0-level addressing, the page size is
+		 * equal to the whole buffer size, and we split the buffer into
+		 * small pages which is used to check whether the adjacent
+		 * units are in the continuous space and its size is fixed to
+		 * 4K based on hns ROCEE's requirement.
 		 */
-		cfg->buf_pg_shift = HNS_HW_PAGE_SHIFT + order_base_2(page_cnt);
-		if (attr->region_count > 1) {
-			cfg->buf_pg_count = page_cnt;
-			page_shift = HNS_HW_PAGE_SHIFT;
-		} else {
-			cfg->buf_pg_count = 1;
-			page_shift = cfg->buf_pg_shift;
-			if (buf_size != 1 << page_shift) {
-				ibdev_err(&hr_dev->ib_dev,
-					  "failed to check direct size %zu shift %d.\n",
-					  buf_size, page_shift);
-				return -EINVAL;
-			}
-		}
+		page_shift = HNS_HW_PAGE_SHIFT;
+
+		/* The ROCEE requires the page size to be 4K * 2 ^ N. */
+		cfg->buf_pg_count = 1;
+		cfg->buf_pg_shift = HNS_HW_PAGE_SHIFT +
+			order_base_2(DIV_ROUND_UP(buf_size, HNS_HW_PAGE_SIZE));
+		first_region_padding = 0;
 	} else {
-		page_shift = cfg->buf_pg_shift;
+		page_shift = attr->page_shift;
+		cfg->buf_pg_count = DIV_ROUND_UP(buf_size + unalinged_size,
+						 1 << page_shift);
+		cfg->buf_pg_shift = page_shift;
+		first_region_padding = unalinged_size;
 	}
 
-	/* convert buffer size to page index and page count */
-	for (page_cnt = 0, region_cnt = 0; page_cnt < cfg->buf_pg_count &&
-	     region_cnt < attr->region_count &&
+	/* Convert buffer size to page index and page count for each region and
+	 * the buffer's offset needs to be appended to the first region.
+	 */
+	for (page_cnt = 0, region_cnt = 0; region_cnt < attr->region_count &&
 	     region_cnt < ARRAY_SIZE(cfg->region); region_cnt++) {
 		r = &cfg->region[region_cnt];
 		r->offset = page_cnt;
-		buf_size = hr_hw_page_align(attr->region[region_cnt].size);
+		buf_size = hr_hw_page_align(attr->region[region_cnt].size +
+					    first_region_padding);
 		r->count = DIV_ROUND_UP(buf_size, 1 << page_shift);
+		first_region_padding = 0;
 		page_cnt += r->count;
 		r->hopnum = to_hr_hem_hopnum(attr->region[region_cnt].hopnum,
 					     r->count);
 	}
 
-	if (region_cnt < 1) {
-		ibdev_err(&hr_dev->ib_dev,
-			  "failed to check mtr region count, pages = %d.\n",
-			  cfg->buf_pg_count);
-		return -ENOBUFS;
-	}
-
 	cfg->region_count = region_cnt;
 	*buf_page_shift = page_shift;
 
 	return page_cnt;
 }
 
+static int mtr_alloc_mtt(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
+			 unsigned int ba_page_shift)
+{
+	struct hns_roce_hem_cfg *cfg = &mtr->hem_cfg;
+	int ret;
+
+	hns_roce_hem_list_init(&mtr->hem_list);
+	if (!cfg->is_direct) {
+		ret = hns_roce_hem_list_request(hr_dev, &mtr->hem_list,
+						cfg->region, cfg->region_count,
+						ba_page_shift);
+		if (ret)
+			return ret;
+		cfg->root_ba = mtr->hem_list.root_ba;
+		cfg->ba_pg_shift = ba_page_shift;
+	} else {
+		cfg->ba_pg_shift = cfg->buf_pg_shift;
+	}
+
+	return 0;
+}
+
+static void mtr_free_mtt(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr)
+{
+	hns_roce_hem_list_release(hr_dev, &mtr->hem_list);
+}
+
 /**
  * hns_roce_mtr_create - Create hns memory translate region.
  *
@@ -1002,95 +1005,51 @@ int hns_roce_mtr_create(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 			unsigned int ba_page_shift, struct ib_udata *udata,
 			unsigned long user_addr)
 {
-	struct hns_roce_hem_cfg *cfg = &mtr->hem_cfg;
 	struct ib_device *ibdev = &hr_dev->ib_dev;
 	unsigned int buf_page_shift = 0;
-	dma_addr_t *pages = NULL;
-	int all_pg_cnt;
-	int get_pg_cnt;
-	int ret = 0;
-
-	/* if disable mtt, all pages must in a continuous address range */
-	cfg->is_direct = !mtr_has_mtt(buf_attr);
-
-	/* if buffer only need mtt, just init the hem cfg */
-	if (buf_attr->mtt_only) {
-		cfg->buf_pg_shift = buf_attr->page_shift;
-		cfg->buf_pg_count = mtr_bufs_size(buf_attr) >>
-				    buf_attr->page_shift;
-		mtr->umem = NULL;
-		mtr->kmem = NULL;
-	} else {
-		ret = mtr_alloc_bufs(hr_dev, mtr, buf_attr, cfg->is_direct,
-				     udata, user_addr);
-		if (ret) {
-			ibdev_err(ibdev,
-				  "failed to alloc mtr bufs, ret = %d.\n", ret);
-			return ret;
-		}
-	}
+	int buf_page_cnt;
+	int ret;
 
-	all_pg_cnt = mtr_init_buf_cfg(hr_dev, buf_attr, cfg, &buf_page_shift);
-	if (all_pg_cnt < 1) {
-		ret = -ENOBUFS;
-		ibdev_err(ibdev, "failed to init mtr buf cfg.\n");
-		goto err_alloc_bufs;
+	buf_page_cnt = mtr_init_buf_cfg(hr_dev, buf_attr, &mtr->hem_cfg,
+					&buf_page_shift,
+					udata ? user_addr & ~PAGE_MASK : 0);
+	if (buf_page_cnt < 1 || buf_page_shift < HNS_HW_PAGE_SHIFT) {
+		ibdev_err(ibdev, "failed to init mtr cfg, count %d shift %d.\n",
+			  buf_page_cnt, buf_page_shift);
+		return -EINVAL;
 	}
 
-	hns_roce_hem_list_init(&mtr->hem_list);
-	if (!cfg->is_direct) {
-		ret = hns_roce_hem_list_request(hr_dev, &mtr->hem_list,
-						cfg->region, cfg->region_count,
-						ba_page_shift);
-		if (ret) {
-			ibdev_err(ibdev, "failed to request mtr hem, ret = %d.\n",
-				  ret);
-			goto err_alloc_bufs;
-		}
-		cfg->root_ba = mtr->hem_list.root_ba;
-		cfg->ba_pg_shift = ba_page_shift;
-	} else {
-		cfg->ba_pg_shift = cfg->buf_pg_shift;
+	ret = mtr_alloc_mtt(hr_dev, mtr, ba_page_shift);
+	if (ret) {
+		ibdev_err(ibdev, "failed to alloc mtr mtt, ret = %d.\n", ret);
+		return ret;
 	}
 
-	/* no buffer to map */
-	if (buf_attr->mtt_only)
+	/* The caller has its own buffer list and invokes the hns_roce_mtr_map()
+	 * to finish the MTT configuration.
+	 */
+	if (buf_attr->mtt_only) {
+		mtr->umem = NULL;
+		mtr->kmem = NULL;
 		return 0;
-
-	/* alloc a tmp array to store buffer's dma address */
-	pages = kvcalloc(all_pg_cnt, sizeof(dma_addr_t), GFP_KERNEL);
-	if (!pages) {
-		ret = -ENOMEM;
-		ibdev_err(ibdev, "failed to alloc mtr page list %d.\n",
-			  all_pg_cnt);
-		goto err_alloc_hem_list;
-	}
-
-	get_pg_cnt = mtr_get_pages(hr_dev, mtr, pages, all_pg_cnt,
-				   buf_page_shift);
-	if (get_pg_cnt != all_pg_cnt) {
-		ibdev_err(ibdev, "failed to get mtr page %d != %d.\n",
-			  get_pg_cnt, all_pg_cnt);
-		ret = -ENOBUFS;
-		goto err_alloc_page_list;
 	}
 
-	/* write buffer's dma address to BA table */
-	ret = hns_roce_mtr_map(hr_dev, mtr, pages, all_pg_cnt);
+	ret = mtr_alloc_bufs(hr_dev, mtr, buf_attr, udata, user_addr);
 	if (ret) {
-		ibdev_err(ibdev, "failed to map mtr pages, ret = %d.\n", ret);
-		goto err_alloc_page_list;
+		ibdev_err(ibdev, "failed to alloc mtr bufs, ret = %d.\n", ret);
+		goto err_alloc_mtt;
 	}
 
-	/* drop tmp array */
-	kvfree(pages);
-	return 0;
-err_alloc_page_list:
-	kvfree(pages);
-err_alloc_hem_list:
-	hns_roce_hem_list_release(hr_dev, &mtr->hem_list);
-err_alloc_bufs:
+	/* Write buffer's dma address to MTT */
+	ret = mtr_map_bufs(hr_dev, mtr, buf_page_cnt, buf_page_shift);
+	if (ret)
+		ibdev_err(ibdev, "failed to map mtr bufs, ret = %d.\n", ret);
+	else
+		return 0;
+
 	mtr_free_bufs(hr_dev, mtr);
+err_alloc_mtt:
+	mtr_free_mtt(hr_dev, mtr);
 	return ret;
 }
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index d8e2fe5..9988ca9 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -599,7 +599,6 @@ static int set_wqe_buf_attr(struct hns_roce_dev *hr_dev,
 		return -EINVAL;
 
 	buf_attr->page_shift = HNS_HW_PAGE_SHIFT + hr_dev->caps.mtt_buf_pg_sz;
-	buf_attr->fixed_page = true;
 	buf_attr->region_count = idx;
 
 	return 0;
diff --git a/drivers/infiniband/hw/hns/hns_roce_srq.c b/drivers/infiniband/hw/hns/hns_roce_srq.c
index c4ae57e..9403828 100644
--- a/drivers/infiniband/hw/hns/hns_roce_srq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_srq.c
@@ -194,7 +194,6 @@ static int alloc_srq_buf(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq,
 							 srq->wqe_shift);
 	buf_attr.region[0].hopnum = hr_dev->caps.srqwqe_hop_num;
 	buf_attr.region_count = 1;
-	buf_attr.fixed_page = true;
 
 	err = hns_roce_mtr_create(hr_dev, &srq->buf_mtr, &buf_attr,
 				  hr_dev->caps.srqwqe_ba_pg_sz +
@@ -226,7 +225,6 @@ static int alloc_srq_idx(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq,
 					srq->idx_que.entry_shift);
 	buf_attr.region[0].hopnum = hr_dev->caps.idx_hop_num;
 	buf_attr.region_count = 1;
-	buf_attr.fixed_page = true;
 
 	err = hns_roce_mtr_create(hr_dev, &idx_que->mtr, &buf_attr,
 				  hr_dev->caps.idx_ba_pg_sz + HNS_HW_PAGE_SHIFT,
-- 
2.8.1

