Return-Path: <linux-rdma+bounces-485-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 247A281DEEB
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Dec 2023 08:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47CA81C21783
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Dec 2023 07:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F62D15B0;
	Mon, 25 Dec 2023 07:57:51 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309A1846D;
	Mon, 25 Dec 2023 07:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Sz9HB6WDsz1wpLt;
	Mon, 25 Dec 2023 15:57:26 +0800 (CST)
Received: from kwepemi500006.china.huawei.com (unknown [7.221.188.68])
	by mail.maildlp.com (Postfix) with ESMTPS id C64E41A019F;
	Mon, 25 Dec 2023 15:57:31 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 25 Dec 2023 15:57:16 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH for-next 2/6] RDMA/hns: Refactor mtr_init_buf_cfg()
Date: Mon, 25 Dec 2023 15:53:26 +0800
Message-ID: <20231225075330.4116470-3-huangjunxian6@hisilicon.com>
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

page_shift and page_cnt is only used in mtr_map_bufs(). And these
parameter could be calculated indepedently.

Strip the computation of page_shift and page_cnt from mtr_init_buf_cfg(),
reducing the number of parameters of it. This helps reducing coupling
between mtr_init_buf_cfg() and mtr_map_bufs().

Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_mr.c | 76 +++++++++++++++----------
 1 file changed, 45 insertions(+), 31 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index 9537a2c00bb6..adc401aea8df 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -707,14 +707,37 @@ static int mtr_alloc_bufs(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 	return 0;
 }
 
-static int mtr_map_bufs(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
-			int page_count, unsigned int page_shift)
+static int cal_mtr_pg_cnt(struct hns_roce_mtr *mtr)
+{
+	struct hns_roce_buf_region *region;
+	int page_cnt = 0;
+	int i;
+
+	for (i = 0; i < mtr->hem_cfg.region_count; i++) {
+		region = &mtr->hem_cfg.region[i];
+		page_cnt += region->count;
+	}
+
+	return page_cnt;
+}
+
+static int mtr_map_bufs(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr)
 {
 	struct ib_device *ibdev = &hr_dev->ib_dev;
+	int page_count = cal_mtr_pg_cnt(mtr);
+	unsigned int page_shift;
 	dma_addr_t *pages;
 	int npage;
 	int ret;
 
+	/* When HEM buffer uses 0-level addressing, the page size is
+	 * equal to the whole buffer size, and we split the buffer into
+	 * small pages which is used to check whether the adjacent
+	 * units are in the continuous space and its size is fixed to
+	 * 4K based on hns ROCEE's requirement.
+	 */
+	page_shift = mtr->hem_cfg.is_direct ? HNS_HW_PAGE_SHIFT :
+					      mtr->hem_cfg.buf_pg_shift;
 	/* alloc a tmp array to store buffer's dma address */
 	pages = kvcalloc(page_count, sizeof(dma_addr_t), GFP_KERNEL);
 	if (!pages)
@@ -894,37 +917,30 @@ int hns_roce_mtr_find(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 
 static int mtr_init_buf_cfg(struct hns_roce_dev *hr_dev,
 			    struct hns_roce_buf_attr *attr,
-			    struct hns_roce_hem_cfg *cfg,
-			    unsigned int *buf_page_shift, u64 unalinged_size)
+			    struct hns_roce_hem_cfg *cfg, u64 unalinged_size)
 {
+	struct ib_device *ibdev = &hr_dev->ib_dev;
 	struct hns_roce_buf_region *r;
 	u64 first_region_padding;
 	int page_cnt, region_cnt;
-	unsigned int page_shift;
+	size_t buf_pg_sz;
 	size_t buf_size;
 
 	/* If mtt is disabled, all pages must be within a continuous range */
 	cfg->is_direct = !mtr_has_mtt(attr);
 	buf_size = mtr_bufs_size(attr);
 	if (cfg->is_direct) {
-		/* When HEM buffer uses 0-level addressing, the page size is
-		 * equal to the whole buffer size, and we split the buffer into
-		 * small pages which is used to check whether the adjacent
-		 * units are in the continuous space and its size is fixed to
-		 * 4K based on hns ROCEE's requirement.
-		 */
-		page_shift = HNS_HW_PAGE_SHIFT;
-
-		/* The ROCEE requires the page size to be 4K * 2 ^ N. */
+		buf_pg_sz = HNS_HW_PAGE_SIZE;
 		cfg->buf_pg_count = 1;
+		/* The ROCEE requires the page size to be 4K * 2 ^ N. */
 		cfg->buf_pg_shift = HNS_HW_PAGE_SHIFT +
 			order_base_2(DIV_ROUND_UP(buf_size, HNS_HW_PAGE_SIZE));
 		first_region_padding = 0;
 	} else {
-		page_shift = attr->page_shift;
 		cfg->buf_pg_count = DIV_ROUND_UP(buf_size + unalinged_size,
-						 1 << page_shift);
-		cfg->buf_pg_shift = page_shift;
+						 1 << attr->page_shift);
+		cfg->buf_pg_shift = attr->page_shift;
+		buf_pg_sz = 1 << cfg->buf_pg_shift;
 		first_region_padding = unalinged_size;
 	}
 
@@ -937,7 +953,7 @@ static int mtr_init_buf_cfg(struct hns_roce_dev *hr_dev,
 		r->offset = page_cnt;
 		buf_size = hr_hw_page_align(attr->region[region_cnt].size +
 					    first_region_padding);
-		r->count = DIV_ROUND_UP(buf_size, 1 << page_shift);
+		r->count = DIV_ROUND_UP(buf_size, buf_pg_sz);
 		first_region_padding = 0;
 		page_cnt += r->count;
 		r->hopnum = to_hr_hem_hopnum(attr->region[region_cnt].hopnum,
@@ -945,9 +961,13 @@ static int mtr_init_buf_cfg(struct hns_roce_dev *hr_dev,
 	}
 
 	cfg->region_count = region_cnt;
-	*buf_page_shift = page_shift;
+	if (cfg->region_count < 1 || cfg->buf_pg_shift < HNS_HW_PAGE_SHIFT) {
+		ibdev_err(ibdev, "failed to init mtr cfg, count %d shift %u.\n",
+			  cfg->region_count, cfg->buf_pg_shift);
+		return -EINVAL;
+	}
 
-	return page_cnt;
+	return 0;
 }
 
 static u64 cal_pages_per_l1ba(unsigned int ba_per_bt, unsigned int hopnum)
@@ -1035,18 +1055,12 @@ int hns_roce_mtr_create(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 			unsigned long user_addr)
 {
 	struct ib_device *ibdev = &hr_dev->ib_dev;
-	unsigned int buf_page_shift = 0;
-	int buf_page_cnt;
 	int ret;
 
-	buf_page_cnt = mtr_init_buf_cfg(hr_dev, buf_attr, &mtr->hem_cfg,
-					&buf_page_shift,
-					udata ? user_addr & ~PAGE_MASK : 0);
-	if (buf_page_cnt < 1 || buf_page_shift < HNS_HW_PAGE_SHIFT) {
-		ibdev_err(ibdev, "failed to init mtr cfg, count %d shift %u.\n",
-			  buf_page_cnt, buf_page_shift);
-		return -EINVAL;
-	}
+	ret = mtr_init_buf_cfg(hr_dev, buf_attr, &mtr->hem_cfg,
+			       udata ? user_addr & ~PAGE_MASK : 0);
+	if (ret)
+		return ret;
 
 	ret = mtr_alloc_mtt(hr_dev, mtr, ba_page_shift);
 	if (ret) {
@@ -1070,7 +1084,7 @@ int hns_roce_mtr_create(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 	}
 
 	/* Write buffer's dma address to MTT */
-	ret = mtr_map_bufs(hr_dev, mtr, buf_page_cnt, buf_page_shift);
+	ret = mtr_map_bufs(hr_dev, mtr);
 	if (ret)
 		ibdev_err(ibdev, "failed to map mtr bufs, ret = %d.\n", ret);
 	else
-- 
2.30.0


