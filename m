Return-Path: <linux-rdma+bounces-622-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1317482CAAF
	for <lists+linux-rdma@lfdr.de>; Sat, 13 Jan 2024 10:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C70C1F23420
	for <lists+linux-rdma@lfdr.de>; Sat, 13 Jan 2024 09:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC91A1EF09;
	Sat, 13 Jan 2024 09:03:41 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9848A17554;
	Sat, 13 Jan 2024 09:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4TBsqk70X2zsVqY;
	Sat, 13 Jan 2024 17:02:42 +0800 (CST)
Received: from kwepemi500006.china.huawei.com (unknown [7.221.188.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 549801402E2;
	Sat, 13 Jan 2024 17:03:31 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 13 Jan 2024 17:03:30 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH v2 for-next 4/6] RDMA/hns: Support flexible umem page size
Date: Sat, 13 Jan 2024 16:59:33 +0800
Message-ID: <20240113085935.2838701-5-huangjunxian6@hisilicon.com>
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

From: Chengchang Tang <tangchengchang@huawei.com>

In the current implementation, a fixed page size is used to
configure the umem PBL, which is not flexible enough and is
not conducive to the performance of the HW. Find a best page
size to get better performance.

Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h |   9 ++
 drivers/infiniband/hw/hns/hns_roce_mr.c     | 121 ++++++++++++++------
 2 files changed, 92 insertions(+), 38 deletions(-)

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
index 74ea9d8482b9..d00b4aa7214b 100644
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
@@ -915,56 +924,89 @@ int hns_roce_mtr_find(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 	return ret;
 }
 
-static int mtr_init_buf_cfg(struct hns_roce_dev *hr_dev,
-			    struct hns_roce_buf_attr *attr,
-			    struct hns_roce_hem_cfg *cfg, u64 unalinged_size)
+static int get_best_page_shift(struct hns_roce_dev *hr_dev,
+			       struct hns_roce_mtr *mtr,
+			       struct hns_roce_buf_attr *buf_attr)
+{
+	unsigned int page_sz;
+
+	if (!buf_attr->adaptive || buf_attr->type != MTR_PBL || !mtr->umem)
+		return 0;
+
+	page_sz = ib_umem_find_best_pgsz(mtr->umem,
+					 hr_dev->caps.page_size_cap,
+					 buf_attr->iova);
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
@@ -1054,7 +1096,6 @@ int hns_roce_mtr_create(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 			unsigned int ba_page_shift, struct ib_udata *udata,
 			unsigned long user_addr)
 {
-	u64 pgoff = udata ? user_addr & ~PAGE_MASK : 0;
 	struct ib_device *ibdev = &hr_dev->ib_dev;
 	int ret;
 
@@ -1071,9 +1112,13 @@ int hns_roce_mtr_create(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
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


