Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5865538C320
	for <lists+linux-rdma@lfdr.de>; Fri, 21 May 2021 11:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234056AbhEUJb6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 May 2021 05:31:58 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4571 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236504AbhEUJbq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 May 2021 05:31:46 -0400
Received: from dggems701-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Fmh8M25fMzqVJr;
        Fri, 21 May 2021 17:27:15 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggems701-chm.china.huawei.com (10.3.19.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 21 May 2021 17:30:02 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 21 May 2021 17:30:02 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, "Xi Wang" <wangxi11@huawei.com>,
        Weihang Li <liweihang@huawei.com>
Subject: [PATCH for-next 1/5] RDMA/hns: Optimize the base address table config for MTR
Date:   Fri, 21 May 2021 17:29:51 +0800
Message-ID: <1621589395-2435-2-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1621589395-2435-1-git-send-email-liweihang@huawei.com>
References: <1621589395-2435-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggema753-chm.china.huawei.com (10.1.198.195)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

The base address table is allocated by dma allocator, and the size is
always aligned to PAGE_SIZE. If a fixed size is used to allocate the table,
the number of base address entries stored in the table will be smaller than
that can actually stored.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_alloc.c  | 51 ++++++++++++-----------------
 drivers/infiniband/hw/hns/hns_roce_cq.c     |  4 +--
 drivers/infiniband/hw/hns/hns_roce_device.h | 15 ++++++---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 26 ++++++++++++---
 drivers/infiniband/hw/hns/hns_roce_mr.c     | 14 ++++----
 drivers/infiniband/hw/hns/hns_roce_qp.c     |  2 +-
 drivers/infiniband/hw/hns/hns_roce_srq.c    | 10 +++---
 7 files changed, 68 insertions(+), 54 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_alloc.c b/drivers/infiniband/hw/hns/hns_roce_alloc.c
index 5d389ed..51374b68 100644
--- a/drivers/infiniband/hw/hns/hns_roce_alloc.c
+++ b/drivers/infiniband/hw/hns/hns_roce_alloc.c
@@ -208,10 +208,10 @@ struct hns_roce_buf *hns_roce_buf_alloc(struct hns_roce_dev *hr_dev, u32 size,
 
 	/* Calc the trunk size and num by required size and page_shift */
 	if (flags & HNS_ROCE_BUF_DIRECT) {
-		buf->trunk_shift = ilog2(ALIGN(size, PAGE_SIZE));
+		buf->trunk_shift = order_base_2(ALIGN(size, PAGE_SIZE));
 		ntrunk = 1;
 	} else {
-		buf->trunk_shift = ilog2(ALIGN(page_size, PAGE_SIZE));
+		buf->trunk_shift = order_base_2(ALIGN(page_size, PAGE_SIZE));
 		ntrunk = DIV_ROUND_UP(size, 1 << buf->trunk_shift);
 	}
 
@@ -252,50 +252,41 @@ struct hns_roce_buf *hns_roce_buf_alloc(struct hns_roce_dev *hr_dev, u32 size,
 }
 
 int hns_roce_get_kmem_bufs(struct hns_roce_dev *hr_dev, dma_addr_t *bufs,
-			   int buf_cnt, int start, struct hns_roce_buf *buf)
+			   int buf_cnt, struct hns_roce_buf *buf,
+			   unsigned int page_shift)
 {
-	int i, end;
-	int total;
-
-	end = start + buf_cnt;
-	if (end > buf->npages) {
-		dev_err(hr_dev->dev,
-			"failed to check kmem bufs, end %d + %d total %u!\n",
-			start, buf_cnt, buf->npages);
+	unsigned int offset, max_size;
+	int total = 0;
+	int i;
+
+	if (page_shift > buf->trunk_shift) {
+		dev_err(hr_dev->dev, "failed to check kmem buf shift %u > %u\n",
+			page_shift, buf->trunk_shift);
 		return -EINVAL;
 	}
 
-	total = 0;
-	for (i = start; i < end; i++)
-		bufs[total++] = hns_roce_buf_page(buf, i);
+	offset = 0;
+	max_size = buf->ntrunks << buf->trunk_shift;
+	for (i = 0; i < buf_cnt && offset < max_size; i++) {
+		bufs[total++] = hns_roce_buf_dma_addr(buf, offset);
+		offset += (1 << page_shift);
+	}
 
 	return total;
 }
 
 int hns_roce_get_umem_bufs(struct hns_roce_dev *hr_dev, dma_addr_t *bufs,
-			   int buf_cnt, int start, struct ib_umem *umem,
+			   int buf_cnt, struct ib_umem *umem,
 			   unsigned int page_shift)
 {
 	struct ib_block_iter biter;
 	int total = 0;
-	int idx = 0;
-	u64 addr;
-
-	if (page_shift < HNS_HW_PAGE_SHIFT) {
-		dev_err(hr_dev->dev, "failed to check umem page shift %u!\n",
-			page_shift);
-		return -EINVAL;
-	}
 
 	/* convert system page cnt to hw page cnt */
 	rdma_umem_for_each_dma_block(umem, &biter, 1 << page_shift) {
-		addr = rdma_block_iter_dma_address(&biter);
-		if (idx >= start) {
-			bufs[total++] = addr;
-			if (total >= buf_cnt)
-				goto done;
-		}
-		idx++;
+		bufs[total++] = rdma_block_iter_dma_address(&biter);
+		if (total >= buf_cnt)
+			goto done;
 	}
 
 done:
diff --git a/drivers/infiniband/hw/hns/hns_roce_cq.c b/drivers/infiniband/hw/hns/hns_roce_cq.c
index 488d86b..a5a74b6 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cq.c
@@ -202,13 +202,13 @@ static int alloc_cq_buf(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq,
 	struct hns_roce_buf_attr buf_attr = {};
 	int ret;
 
-	buf_attr.page_shift = hr_dev->caps.cqe_buf_pg_sz + HNS_HW_PAGE_SHIFT;
+	buf_attr.page_shift = hr_dev->caps.cqe_buf_pg_sz + PAGE_SHIFT;
 	buf_attr.region[0].size = hr_cq->cq_depth * hr_cq->cqe_size;
 	buf_attr.region[0].hopnum = hr_dev->caps.cqe_hop_num;
 	buf_attr.region_count = 1;
 
 	ret = hns_roce_mtr_create(hr_dev, &hr_cq->mtr, &buf_attr,
-				  hr_dev->caps.cqe_ba_pg_sz + HNS_HW_PAGE_SHIFT,
+				  hr_dev->caps.cqe_ba_pg_sz + PAGE_SHIFT,
 				  udata, addr);
 	if (ret)
 		ibdev_err(ibdev, "failed to alloc CQ mtr, ret = %d.\n", ret);
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 111cab5..02fffb7 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -1060,14 +1060,18 @@ static inline void *hns_roce_buf_offset(struct hns_roce_buf *buf,
 			(offset & ((1 << buf->trunk_shift) - 1));
 }
 
-static inline dma_addr_t hns_roce_buf_page(struct hns_roce_buf *buf, u32 idx)
+static inline dma_addr_t hns_roce_buf_dma_addr(struct hns_roce_buf *buf,
+					       unsigned int offset)
 {
-	unsigned int offset = idx << buf->page_shift;
-
 	return buf->trunk_list[offset >> buf->trunk_shift].map +
 			(offset & ((1 << buf->trunk_shift) - 1));
 }
 
+static inline dma_addr_t hns_roce_buf_page(struct hns_roce_buf *buf, u32 idx)
+{
+	return hns_roce_buf_dma_addr(buf, idx << buf->page_shift);
+}
+
 #define hr_hw_page_align(x)		ALIGN(x, 1 << HNS_HW_PAGE_SHIFT)
 
 static inline u64 to_hr_hw_page_addr(u64 addr)
@@ -1204,9 +1208,10 @@ struct hns_roce_buf *hns_roce_buf_alloc(struct hns_roce_dev *hr_dev, u32 size,
 					u32 page_shift, u32 flags);
 
 int hns_roce_get_kmem_bufs(struct hns_roce_dev *hr_dev, dma_addr_t *bufs,
-			   int buf_cnt, int start, struct hns_roce_buf *buf);
+			   int buf_cnt, struct hns_roce_buf *buf,
+			   unsigned int page_shift);
 int hns_roce_get_umem_bufs(struct hns_roce_dev *hr_dev, dma_addr_t *bufs,
-			   int buf_cnt, int start, struct ib_umem *umem,
+			   int buf_cnt, struct ib_umem *umem,
 			   unsigned int page_shift);
 
 int hns_roce_create_srq(struct ib_srq *srq,
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index d5e72e5..0c12d87 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -2018,6 +2018,8 @@ static void set_hem_page_size(struct hns_roce_dev *hr_dev)
 	caps->llm_buf_pg_sz = 0;
 
 	/* MR */
+	caps->mpt_ba_pg_sz = 0;
+	caps->mpt_buf_pg_sz = 0;
 	caps->pbl_ba_pg_sz = HNS_ROCE_BA_PG_SZ_SUPPORTED_16K;
 	caps->pbl_buf_pg_sz = 0;
 	calc_pg_sz(caps->num_mtpts, caps->mtpt_entry_sz, caps->mpt_hop_num,
@@ -2025,8 +2027,12 @@ static void set_hem_page_size(struct hns_roce_dev *hr_dev)
 		   HEM_TYPE_MTPT);
 
 	/* QP */
-	caps->qpc_timer_ba_pg_sz  = 0;
+	caps->qpc_ba_pg_sz = 0;
+	caps->qpc_buf_pg_sz = 0;
+	caps->qpc_timer_ba_pg_sz = 0;
 	caps->qpc_timer_buf_pg_sz = 0;
+	caps->sccc_ba_pg_sz = 0;
+	caps->sccc_buf_pg_sz = 0;
 	caps->mtt_ba_pg_sz = 0;
 	caps->mtt_buf_pg_sz = 0;
 	calc_pg_sz(caps->num_qps, caps->qpc_sz, caps->qpc_hop_num,
@@ -2039,6 +2045,12 @@ static void set_hem_page_size(struct hns_roce_dev *hr_dev)
 			   &caps->sccc_ba_pg_sz, HEM_TYPE_SCCC);
 
 	/* CQ */
+	caps->cqc_ba_pg_sz = 0;
+	caps->cqc_buf_pg_sz = 0;
+	caps->cqc_timer_ba_pg_sz = 0;
+	caps->cqc_timer_buf_pg_sz = 0;
+	caps->cqe_ba_pg_sz = HNS_ROCE_BA_PG_SZ_SUPPORTED_256K;
+	caps->cqe_buf_pg_sz = 0;
 	calc_pg_sz(caps->num_cqs, caps->cqc_entry_sz, caps->cqc_hop_num,
 		   caps->cqc_bt_num, &caps->cqc_buf_pg_sz, &caps->cqc_ba_pg_sz,
 		   HEM_TYPE_CQC);
@@ -2053,6 +2065,12 @@ static void set_hem_page_size(struct hns_roce_dev *hr_dev)
 
 	/* SRQ */
 	if (caps->flags & HNS_ROCE_CAP_FLAG_SRQ) {
+		caps->srqc_ba_pg_sz = 0;
+		caps->srqc_buf_pg_sz = 0;
+		caps->srqwqe_ba_pg_sz = 0;
+		caps->srqwqe_buf_pg_sz = 0;
+		caps->idx_ba_pg_sz = 0;
+		caps->idx_buf_pg_sz = 0;
 		calc_pg_sz(caps->num_srqs, caps->srqc_entry_sz,
 			   caps->srqc_hop_num, caps->srqc_bt_num,
 			   &caps->srqc_buf_pg_sz, &caps->srqc_ba_pg_sz,
@@ -6161,14 +6179,14 @@ static int alloc_eq_buf(struct hns_roce_dev *hr_dev, struct hns_roce_eq *eq)
 	else
 		eq->hop_num = hr_dev->caps.eqe_hop_num;
 
-	buf_attr.page_shift = hr_dev->caps.eqe_buf_pg_sz + HNS_HW_PAGE_SHIFT;
+	buf_attr.page_shift = hr_dev->caps.eqe_buf_pg_sz + PAGE_SHIFT;
 	buf_attr.region[0].size = eq->entries * eq->eqe_size;
 	buf_attr.region[0].hopnum = eq->hop_num;
 	buf_attr.region_count = 1;
 
 	err = hns_roce_mtr_create(hr_dev, &eq->mtr, &buf_attr,
-				  hr_dev->caps.eqe_ba_pg_sz +
-				  HNS_HW_PAGE_SHIFT, NULL, 0);
+				  hr_dev->caps.eqe_ba_pg_sz + PAGE_SHIFT, NULL,
+				  0);
 	if (err)
 		dev_err(hr_dev->dev, "Failed to alloc EQE mtr, err %d\n", err);
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index 79b3c30..8e6b1ae 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -122,7 +122,7 @@ static int alloc_mr_pbl(struct hns_roce_dev *hr_dev, struct hns_roce_mr *mr,
 	buf_attr.mtt_only = is_fast;
 
 	err = hns_roce_mtr_create(hr_dev, &mr->pbl_mtr, &buf_attr,
-				  hr_dev->caps.pbl_ba_pg_sz + HNS_HW_PAGE_SHIFT,
+				  hr_dev->caps.pbl_ba_pg_sz + PAGE_SHIFT,
 				  udata, start);
 	if (err)
 		ibdev_err(ibdev, "failed to alloc pbl mtr, ret = %d.\n", err);
@@ -737,11 +737,11 @@ static int mtr_map_bufs(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 		return -ENOMEM;
 
 	if (mtr->umem)
-		npage = hns_roce_get_umem_bufs(hr_dev, pages, page_count, 0,
+		npage = hns_roce_get_umem_bufs(hr_dev, pages, page_count,
 					       mtr->umem, page_shift);
 	else
-		npage = hns_roce_get_kmem_bufs(hr_dev, pages, page_count, 0,
-					       mtr->kmem);
+		npage = hns_roce_get_kmem_bufs(hr_dev, pages, page_count,
+					       mtr->kmem, page_shift);
 
 	if (npage != page_count) {
 		ibdev_err(ibdev, "failed to get mtr page %d != %d.\n", npage,
@@ -753,8 +753,8 @@ static int mtr_map_bufs(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 	if (mtr->hem_cfg.is_direct && npage > 1) {
 		ret = mtr_check_direct_pages(pages, npage, page_shift);
 		if (ret) {
-			ibdev_err(ibdev, "failed to check %s mtr, idx = %d.\n",
-				  mtr->umem ? "user" : "kernel", ret);
+			ibdev_err(ibdev, "failed to check %s page: %d / %d.\n",
+				  mtr->umem ? "umtr" : "kmtr", ret, npage);
 			ret = -ENOBUFS;
 			goto err_alloc_list;
 		}
@@ -799,7 +799,7 @@ int hns_roce_mtr_map(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 		if (r->offset + r->count > page_cnt) {
 			ret = -EINVAL;
 			ibdev_err(ibdev,
-				  "failed to check mtr%u end %u + %u, max %u.\n",
+				  "failed to check mtr%u count %u + %u > %u.\n",
 				  i, r->offset, r->count, page_cnt);
 			return ret;
 		}
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index c6e120e..9203cf1 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -761,7 +761,7 @@ static int alloc_qp_buf(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 		goto err_inline;
 	}
 	ret = hns_roce_mtr_create(hr_dev, &hr_qp->mtr, &buf_attr,
-				  HNS_HW_PAGE_SHIFT + hr_dev->caps.mtt_ba_pg_sz,
+				  PAGE_SHIFT + hr_dev->caps.mtt_ba_pg_sz,
 				  udata, addr);
 	if (ret) {
 		ibdev_err(ibdev, "failed to create WQE mtr, ret = %d.\n", ret);
diff --git a/drivers/infiniband/hw/hns/hns_roce_srq.c b/drivers/infiniband/hw/hns/hns_roce_srq.c
index 546d182..c842210 100644
--- a/drivers/infiniband/hw/hns/hns_roce_srq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_srq.c
@@ -167,14 +167,14 @@ static int alloc_srq_idx(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq,
 
 	srq->idx_que.entry_shift = ilog2(HNS_ROCE_IDX_QUE_ENTRY_SZ);
 
-	buf_attr.page_shift = hr_dev->caps.idx_buf_pg_sz + HNS_HW_PAGE_SHIFT;
+	buf_attr.page_shift = hr_dev->caps.idx_buf_pg_sz + PAGE_SHIFT;
 	buf_attr.region[0].size = to_hr_hem_entries_size(srq->wqe_cnt,
 					srq->idx_que.entry_shift);
 	buf_attr.region[0].hopnum = hr_dev->caps.idx_hop_num;
 	buf_attr.region_count = 1;
 
 	ret = hns_roce_mtr_create(hr_dev, &idx_que->mtr, &buf_attr,
-				  hr_dev->caps.idx_ba_pg_sz + HNS_HW_PAGE_SHIFT,
+				  hr_dev->caps.idx_ba_pg_sz + PAGE_SHIFT,
 				  udata, addr);
 	if (ret) {
 		ibdev_err(ibdev,
@@ -222,15 +222,15 @@ static int alloc_srq_wqe_buf(struct hns_roce_dev *hr_dev,
 						      HNS_ROCE_SGE_SIZE *
 						      srq->max_gs)));
 
-	buf_attr.page_shift = hr_dev->caps.srqwqe_buf_pg_sz + HNS_HW_PAGE_SHIFT;
+	buf_attr.page_shift = hr_dev->caps.srqwqe_buf_pg_sz + PAGE_SHIFT;
 	buf_attr.region[0].size = to_hr_hem_entries_size(srq->wqe_cnt,
 							 srq->wqe_shift);
 	buf_attr.region[0].hopnum = hr_dev->caps.srqwqe_hop_num;
 	buf_attr.region_count = 1;
 
 	ret = hns_roce_mtr_create(hr_dev, &srq->buf_mtr, &buf_attr,
-				  hr_dev->caps.srqwqe_ba_pg_sz +
-				  HNS_HW_PAGE_SHIFT, udata, addr);
+				  hr_dev->caps.srqwqe_ba_pg_sz + PAGE_SHIFT,
+				  udata, addr);
 	if (ret)
 		ibdev_err(ibdev,
 			  "failed to alloc SRQ buf mtr, ret = %d.\n", ret);
-- 
2.7.4

