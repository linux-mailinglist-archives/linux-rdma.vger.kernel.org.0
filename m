Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6851D20F6AA
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2020 16:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730358AbgF3OCg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Jun 2020 10:02:36 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7319 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727796AbgF3OCg (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 30 Jun 2020 10:02:36 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id BB3CD2F04CD56C7041E1;
        Tue, 30 Jun 2020 22:02:15 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Tue, 30 Jun 2020 22:02:07 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next] RDMA/hns: Optimize MTR level-0 addressing to access huge page
Date:   Tue, 30 Jun 2020 22:01:36 +0800
Message-ID: <1593525696-12570-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

If hns ROCEE is set to level-0 addressing, the length of the entire buffer
can be used as the page size. The driver needn't to split the buffer into
small units because all pages are continuous.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h |  20 +--
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c  |   7 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  44 +-----
 drivers/infiniband/hw/hns/hns_roce_mr.c     | 208 +++++++++++++++++-----------
 4 files changed, 147 insertions(+), 132 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index a61f0c4..c0bc8c4 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -348,20 +348,22 @@ struct hns_roce_buf_attr {
 	bool mtt_only; /* only alloc buffer-required MTT memory */
 };
 
+struct hns_roce_hem_cfg {
+	dma_addr_t	root_ba; /* root BA table's address */
+	bool		is_direct; /* addressing without BA table */
+	unsigned int	ba_pg_shift; /* BA table page shift */
+	unsigned int	buf_pg_shift; /* buffer page shift */
+	unsigned int	buf_pg_count;  /* buffer page count */
+	struct hns_roce_buf_region region[HNS_ROCE_MAX_BT_REGION];
+	int		region_count;
+};
+
 /* memory translate region */
 struct hns_roce_mtr {
 	struct hns_roce_hem_list hem_list; /* multi-hop addressing resource */
 	struct ib_umem		*umem; /* user space buffer */
 	struct hns_roce_buf	*kmem; /* kernel space buffer */
-	struct {
-		dma_addr_t	root_ba; /* root BA table's address */
-		bool		is_direct; /* addressing without BA table */
-		unsigned int	ba_pg_shift; /* BA table page shift */
-		unsigned int	buf_pg_shift; /* buffer page shift */
-		int		buf_pg_count;  /* buffer page count */
-		struct hns_roce_buf_region region[HNS_ROCE_MAX_BT_REGION];
-		unsigned int	region_count;
-	} hem_cfg; /* config for hardware addressing */
+	struct hns_roce_hem_cfg  hem_cfg; /* config for hardware addressing */
 };
 
 struct hns_roce_mw {
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
index d02207c..ef7f8b3 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -2483,7 +2483,6 @@ static int find_wqe_mtt(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 			u64 *sq_ba, u64 *rq_ba, dma_addr_t *bt_ba)
 {
 	struct ib_device *ibdev = &hr_dev->ib_dev;
-	int rq_pa_start;
 	int count;
 
 	count = hns_roce_mtr_find(hr_dev, &hr_qp->mtr, 0, sq_ba, 1, bt_ba);
@@ -2491,9 +2490,9 @@ static int find_wqe_mtt(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 		ibdev_err(ibdev, "Failed to find SQ ba\n");
 		return -ENOBUFS;
 	}
-	rq_pa_start = hr_qp->rq.offset >> hr_qp->mtr.hem_cfg.buf_pg_shift;
-	count = hns_roce_mtr_find(hr_dev, &hr_qp->mtr, rq_pa_start, rq_ba, 1,
-				  NULL);
+
+	count = hns_roce_mtr_find(hr_dev, &hr_qp->mtr, hr_qp->rq.offset, rq_ba,
+				  1, NULL);
 	if (!count) {
 		ibdev_err(ibdev, "Failed to find RQ ba\n");
 		return -ENOBUFS;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index c597d72..2b0b676 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -3744,51 +3744,23 @@ static void modify_qp_init_to_init(struct ib_qp *ibqp,
 	}
 }
 
-static bool check_wqe_rq_mtt_count(struct hns_roce_dev *hr_dev,
-				   struct hns_roce_qp *hr_qp, int mtt_cnt,
-				   u32 page_size)
-{
-	struct ib_device *ibdev = &hr_dev->ib_dev;
-
-	if (hr_qp->rq.wqe_cnt < 1)
-		return true;
-
-	if (mtt_cnt < 1) {
-		ibdev_err(ibdev, "failed to find RQWQE buf ba of QP(0x%lx)\n",
-			  hr_qp->qpn);
-		return false;
-	}
-
-	if (mtt_cnt < MTT_MIN_COUNT &&
-		(hr_qp->rq.offset + page_size) < hr_qp->buff_size) {
-		ibdev_err(ibdev,
-			  "failed to find next RQWQE buf ba of QP(0x%lx)\n",
-			  hr_qp->qpn);
-		return false;
-	}
-
-	return true;
-}
-
 static int config_qp_rq_buf(struct hns_roce_dev *hr_dev,
 			    struct hns_roce_qp *hr_qp,
 			    struct hns_roce_v2_qp_context *context,
 			    struct hns_roce_v2_qp_context *qpc_mask)
 {
-	struct ib_qp *ibqp = &hr_qp->ibqp;
 	u64 mtts[MTT_MIN_COUNT] = { 0 };
 	u64 wqe_sge_ba;
-	u32 page_size;
 	int count;
 
 	/* Search qp buf's mtts */
-	page_size = 1 << hr_qp->mtr.hem_cfg.buf_pg_shift;
-	count = hns_roce_mtr_find(hr_dev, &hr_qp->mtr,
-				  hr_qp->rq.offset / page_size, mtts,
+	count = hns_roce_mtr_find(hr_dev, &hr_qp->mtr, hr_qp->rq.offset, mtts,
 				  MTT_MIN_COUNT, &wqe_sge_ba);
-	if (!ibqp->srq)
-		if (!check_wqe_rq_mtt_count(hr_dev, hr_qp, count, page_size))
-			return -EINVAL;
+	if (hr_qp->rq.wqe_cnt && count < 1) {
+		ibdev_err(&hr_dev->ib_dev,
+			  "failed to find RQ WQE, QPN = 0x%lx.\n", hr_qp->qpn);
+		return -EINVAL;
+	}
 
 	context->wqe_sge_ba = cpu_to_le32(wqe_sge_ba >> 3);
 	qpc_mask->wqe_sge_ba = 0;
@@ -3890,7 +3862,6 @@ static int config_qp_sq_buf(struct hns_roce_dev *hr_dev,
 	struct ib_device *ibdev = &hr_dev->ib_dev;
 	u64 sge_cur_blk = 0;
 	u64 sq_cur_blk = 0;
-	u32 page_size;
 	int count;
 
 	/* search qp buf's mtts */
@@ -3901,9 +3872,8 @@ static int config_qp_sq_buf(struct hns_roce_dev *hr_dev,
 		return -EINVAL;
 	}
 	if (hr_qp->sge.sge_cnt > 0) {
-		page_size = 1 << hr_qp->mtr.hem_cfg.buf_pg_shift;
 		count = hns_roce_mtr_find(hr_dev, &hr_qp->mtr,
-					  hr_qp->sge.offset / page_size,
+					  hr_qp->sge.offset,
 					  &sge_cur_blk, 1, NULL);
 		if (count < 1) {
 			ibdev_err(ibdev, "failed to find QP(0x%lx) SGE buf.\n",
diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index 4c0bbb1..057bcde 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -870,6 +870,15 @@ int hns_roce_mtr_map(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 	int err;
 	int i;
 
+	/*
+	 * Only use the first page address as root ba when hopnum is 0, this
+	 * is because the addresses of all pages are consecutive in this case.
+	 */
+	if (mtr->hem_cfg.is_direct) {
+		mtr->hem_cfg.root_ba = pages[0];
+		return 0;
+	}
+
 	for (i = 0; i < mtr->hem_cfg.region_count; i++) {
 		r = &mtr->hem_cfg.region[i];
 		if (r->offset + r->count > page_cnt) {
@@ -895,6 +904,8 @@ int hns_roce_mtr_map(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 int hns_roce_mtr_find(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 		      int offset, u64 *mtt_buf, int mtt_max, u64 *base_addr)
 {
+	struct hns_roce_hem_cfg *cfg = &mtr->hem_cfg;
+	int start_index;
 	int mtt_count;
 	int total = 0;
 	__le64 *mtts;
@@ -906,26 +917,32 @@ int hns_roce_mtr_find(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 		goto done;
 
 	/* no mtt memory in direct mode, so just return the buffer address */
-	if (mtr->hem_cfg.is_direct) {
-		npage = offset;
-		for (total = 0; total < mtt_max; total++, npage++) {
-			addr = mtr->hem_cfg.root_ba +
-			       (npage << mtr->hem_cfg.buf_pg_shift);
-
+	if (cfg->is_direct) {
+		start_index = offset >> HNS_HW_PAGE_SHIFT;
+		for (mtt_count = 0; mtt_count < cfg->region_count &&
+		     total < mtt_max; mtt_count++) {
+			npage = cfg->region[mtt_count].offset;
+			if (npage < start_index)
+				continue;
+
+			addr = cfg->root_ba + (npage << HNS_HW_PAGE_SHIFT);
 			if (hr_dev->hw_rev == HNS_ROCE_HW_VER1)
 				mtt_buf[total] = to_hr_hw_page_addr(addr);
 			else
 				mtt_buf[total] = addr;
+
+			total++;
 		}
 
 		goto done;
 	}
 
+	start_index = offset >> cfg->buf_pg_shift;
 	left = mtt_max;
 	while (left > 0) {
 		mtt_count = 0;
 		mtts = hns_roce_hem_list_find_mtt(hr_dev, &mtr->hem_list,
-						  offset + total,
+						  start_index + total,
 						  &mtt_count, NULL);
 		if (!mtts || !mtt_count)
 			goto done;
@@ -938,104 +955,136 @@ int hns_roce_mtr_find(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 
 done:
 	if (base_addr)
-		*base_addr = mtr->hem_cfg.root_ba;
+		*base_addr = cfg->root_ba;
 
 	return total;
 }
 
-/* convert buffer size to page index and page count */
-static unsigned int mtr_init_region(struct hns_roce_buf_attr *attr,
-				    int page_cnt,
-				    struct hns_roce_buf_region *regions,
-				    int region_cnt, unsigned int page_shift)
+static int mtr_init_buf_cfg(struct hns_roce_dev *hr_dev,
+			    struct hns_roce_buf_attr *attr,
+			    struct hns_roce_hem_cfg *cfg,
+			    unsigned int *buf_page_shift)
 {
-	unsigned int page_size = 1 << page_shift;
-	int max_region = attr->region_count;
 	struct hns_roce_buf_region *r;
-	unsigned int i = 0;
-	int page_idx = 0;
-
-	for (; i < region_cnt && i < max_region && page_idx < page_cnt; i++) {
-		r = &regions[i];
-		r->hopnum = attr->region[i].hopnum == HNS_ROCE_HOP_NUM_0 ?
-			    0 : attr->region[i].hopnum;
-		r->offset = page_idx;
-		r->count = DIV_ROUND_UP(attr->region[i].size, page_size);
-		page_idx += r->count;
+	unsigned int page_shift = 0;
+	int page_cnt = 0;
+	size_t buf_size;
+	int region_cnt;
+
+	if (cfg->is_direct) {
+		buf_size = cfg->buf_pg_count << cfg->buf_pg_shift;
+		page_cnt = DIV_ROUND_UP(buf_size, HNS_HW_PAGE_SIZE);
+		/*
+		 * When HEM buffer use level-0 addressing, the page size equals
+		 * the buffer size, and the the page size = 4K * 2^N.
+		 */
+		cfg->buf_pg_shift = HNS_HW_PAGE_SHIFT + order_base_2(page_cnt);
+		if (attr->region_count > 1) {
+			cfg->buf_pg_count = page_cnt;
+			page_shift = HNS_HW_PAGE_SHIFT;
+		} else {
+			cfg->buf_pg_count = 1;
+			page_shift = cfg->buf_pg_shift;
+			if (buf_size != 1 << page_shift) {
+				ibdev_err(&hr_dev->ib_dev,
+					  "failed to check direct size %zu shift %d.\n",
+					  buf_size, page_shift);
+				return -EINVAL;
+			}
+		}
+	} else {
+		page_shift = cfg->buf_pg_shift;
+	}
+
+	/* convert buffer size to page index and page count */
+	for (page_cnt = 0, region_cnt = 0; page_cnt < cfg->buf_pg_count &&
+	     region_cnt < attr->region_count &&
+	     region_cnt < ARRAY_SIZE(cfg->region); region_cnt++) {
+		r = &cfg->region[region_cnt];
+		r->offset = page_cnt;
+		buf_size = hr_hw_page_align(attr->region[region_cnt].size);
+		r->count = DIV_ROUND_UP(buf_size, 1 << page_shift);
+		page_cnt += r->count;
+		r->hopnum = to_hr_hem_hopnum(attr->region[region_cnt].hopnum,
+					     r->count);
+	}
+
+	if (region_cnt < 1) {
+		ibdev_err(&hr_dev->ib_dev,
+			  "failed to check mtr region count, pages = %d.\n",
+			  cfg->buf_pg_count);
+		return -ENOBUFS;
 	}
 
-	return i;
+	cfg->region_count = region_cnt;
+	*buf_page_shift = page_shift;
+
+	return page_cnt;
 }
 
 /**
  * hns_roce_mtr_create - Create hns memory translate region.
  *
  * @mtr: memory translate region
- * @init_attr: init attribute for creating mtr
- * @page_shift: page shift for multi-hop base address table
+ * @buf_attr: buffer attribute for creating mtr
+ * @ba_page_shift: page shift for multi-hop base address table
  * @udata: user space context, if it's NULL, means kernel space
  * @user_addr: userspace virtual address to start at
- * @buf_alloced: mtr has private buffer, true means need to alloc
  */
 int hns_roce_mtr_create(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 			struct hns_roce_buf_attr *buf_attr,
-			unsigned int page_shift, struct ib_udata *udata,
+			unsigned int ba_page_shift, struct ib_udata *udata,
 			unsigned long user_addr)
 {
+	struct hns_roce_hem_cfg *cfg = &mtr->hem_cfg;
 	struct ib_device *ibdev = &hr_dev->ib_dev;
+	unsigned int buf_page_shift = 0;
 	dma_addr_t *pages = NULL;
-	int region_cnt = 0;
 	int all_pg_cnt;
 	int get_pg_cnt;
-	bool has_mtt;
-	int err = 0;
+	int ret = 0;
+
+	/* if disable mtt, all pages must in a continuous address range */
+	cfg->is_direct = !mtr_has_mtt(buf_attr);
 
-	has_mtt = mtr_has_mtt(buf_attr);
 	/* if buffer only need mtt, just init the hem cfg */
 	if (buf_attr->mtt_only) {
-		mtr->hem_cfg.buf_pg_shift = buf_attr->page_shift;
-		mtr->hem_cfg.buf_pg_count = mtr_bufs_size(buf_attr) >>
-					    buf_attr->page_shift;
+		cfg->buf_pg_shift = buf_attr->page_shift;
+		cfg->buf_pg_count = mtr_bufs_size(buf_attr) >>
+				    buf_attr->page_shift;
 		mtr->umem = NULL;
 		mtr->kmem = NULL;
 	} else {
-		err = mtr_alloc_bufs(hr_dev, mtr, buf_attr, !has_mtt, udata,
-				     user_addr);
-		if (err) {
-			ibdev_err(ibdev, "Failed to alloc mtr bufs, err %d\n",
-				  err);
-			return err;
+		ret = mtr_alloc_bufs(hr_dev, mtr, buf_attr, cfg->is_direct,
+				     udata, user_addr);
+		if (ret) {
+			ibdev_err(ibdev,
+				  "failed to alloc mtr bufs, ret = %d.\n", ret);
+			return ret;
 		}
 	}
 
-	/* alloc mtt memory */
-	all_pg_cnt = mtr->hem_cfg.buf_pg_count;
-	hns_roce_hem_list_init(&mtr->hem_list);
-	mtr->hem_cfg.is_direct = !has_mtt;
-	mtr->hem_cfg.ba_pg_shift = page_shift;
-	mtr->hem_cfg.region_count = 0;
-	region_cnt = mtr_init_region(buf_attr, all_pg_cnt,
-				     mtr->hem_cfg.region,
-				     ARRAY_SIZE(mtr->hem_cfg.region),
-				     mtr->hem_cfg.buf_pg_shift);
-	if (region_cnt < 1) {
-		err = -ENOBUFS;
-		ibdev_err(ibdev, "failed to init mtr region %d\n", region_cnt);
+	all_pg_cnt = mtr_init_buf_cfg(hr_dev, buf_attr, cfg, &buf_page_shift);
+	if (all_pg_cnt < 1) {
+		ret = -ENOBUFS;
+		ibdev_err(ibdev, "failed to init mtr buf cfg.\n");
 		goto err_alloc_bufs;
 	}
 
-	mtr->hem_cfg.region_count = region_cnt;
-
-	if (has_mtt) {
-		err = hns_roce_hem_list_request(hr_dev, &mtr->hem_list,
-						mtr->hem_cfg.region, region_cnt,
-						page_shift);
-		if (err) {
-			ibdev_err(ibdev, "Failed to request mtr hem, err %d\n",
-				  err);
+	hns_roce_hem_list_init(&mtr->hem_list);
+	if (!cfg->is_direct) {
+		ret = hns_roce_hem_list_request(hr_dev, &mtr->hem_list,
+						cfg->region, cfg->region_count,
+						ba_page_shift);
+		if (ret) {
+			ibdev_err(ibdev, "failed to request mtr hem, ret = %d.\n",
+				  ret);
 			goto err_alloc_bufs;
 		}
-		mtr->hem_cfg.root_ba = mtr->hem_list.root_ba;
+		cfg->root_ba = mtr->hem_list.root_ba;
+		cfg->ba_pg_shift = ba_page_shift;
+	} else {
+		cfg->ba_pg_shift = cfg->buf_pg_shift;
 	}
 
 	/* no buffer to map */
@@ -1045,31 +1094,26 @@ int hns_roce_mtr_create(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 	/* alloc a tmp array to store buffer's dma address */
 	pages = kvcalloc(all_pg_cnt, sizeof(dma_addr_t), GFP_KERNEL);
 	if (!pages) {
-		err = -ENOMEM;
-		ibdev_err(ibdev, "Failed to alloc mtr page list %d\n",
+		ret = -ENOMEM;
+		ibdev_err(ibdev, "failed to alloc mtr page list %d.\n",
 			  all_pg_cnt);
 		goto err_alloc_hem_list;
 	}
 
 	get_pg_cnt = mtr_get_pages(hr_dev, mtr, pages, all_pg_cnt,
-				   mtr->hem_cfg.buf_pg_shift);
+				   buf_page_shift);
 	if (get_pg_cnt != all_pg_cnt) {
-		ibdev_err(ibdev, "Failed to get mtr page %d != %d\n",
+		ibdev_err(ibdev, "failed to get mtr page %d != %d.\n",
 			  get_pg_cnt, all_pg_cnt);
-		err = -ENOBUFS;
+		ret = -ENOBUFS;
 		goto err_alloc_page_list;
 	}
 
-	if (!has_mtt) {
-		mtr->hem_cfg.root_ba = pages[0];
-	} else {
-		/* write buffer's dma address to BA table */
-		err = hns_roce_mtr_map(hr_dev, mtr, pages, all_pg_cnt);
-		if (err) {
-			ibdev_err(ibdev, "Failed to map mtr pages, err %d\n",
-				  err);
-			goto err_alloc_page_list;
-		}
+	/* write buffer's dma address to BA table */
+	ret = hns_roce_mtr_map(hr_dev, mtr, pages, all_pg_cnt);
+	if (ret) {
+		ibdev_err(ibdev, "failed to map mtr pages, ret = %d.\n", ret);
+		goto err_alloc_page_list;
 	}
 
 	/* drop tmp array */
@@ -1081,7 +1125,7 @@ int hns_roce_mtr_create(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 	hns_roce_hem_list_release(hr_dev, &mtr->hem_list);
 err_alloc_bufs:
 	mtr_free_bufs(hr_dev, mtr);
-	return err;
+	return ret;
 }
 
 void hns_roce_mtr_destroy(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr)
-- 
2.8.1

