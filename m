Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 337ED1CA77A
	for <lists+linux-rdma@lfdr.de>; Fri,  8 May 2020 11:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgEHJqZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 8 May 2020 05:46:25 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:37264 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727051AbgEHJqY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 8 May 2020 05:46:24 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id AA25BFC80E24910E5F35;
        Fri,  8 May 2020 17:46:21 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Fri, 8 May 2020 17:46:12 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 8/9] RDMA/hns: Rename macro for defining hns hardware page size
Date:   Fri, 8 May 2020 17:45:58 +0800
Message-ID: <1588931159-56875-9-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1588931159-56875-1-git-send-email-liweihang@huawei.com>
References: <1588931159-56875-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

Rename the PAGE_ADDR_SHIFT as HNS_HW_PAGE_SHIFT to make code more
readable.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_alloc.c  |  6 +++---
 drivers/infiniband/hw/hns/hns_roce_cq.c     |  4 ++--
 drivers/infiniband/hw/hns/hns_roce_device.h | 10 ++++++----
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  4 ++--
 drivers/infiniband/hw/hns/hns_roce_mr.c     |  6 +++---
 drivers/infiniband/hw/hns/hns_roce_qp.c     |  4 ++--
 drivers/infiniband/hw/hns/hns_roce_srq.c    |  8 ++++----
 7 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_alloc.c b/drivers/infiniband/hw/hns/hns_roce_alloc.c
index 365e7db..742aee8 100644
--- a/drivers/infiniband/hw/hns/hns_roce_alloc.c
+++ b/drivers/infiniband/hw/hns/hns_roce_alloc.c
@@ -189,8 +189,8 @@ int hns_roce_buf_alloc(struct hns_roce_dev *hr_dev, u32 size, u32 max_direct,
 	u32 page_size;
 	int i;
 
-	/* The minimum shift of the page accessed by hw is PAGE_ADDR_SHIFT */
-	buf->page_shift = max_t(int, PAGE_ADDR_SHIFT, page_shift);
+	/* The minimum shift of the page accessed by hw is HNS_HW_PAGE_SHIFT */
+	buf->page_shift = max_t(int, HNS_HW_PAGE_SHIFT, page_shift);
 
 	page_size = 1 << buf->page_shift;
 	buf->npages = DIV_ROUND_UP(size, page_size);
@@ -261,7 +261,7 @@ int hns_roce_get_umem_bufs(struct hns_roce_dev *hr_dev, dma_addr_t *bufs,
 	int idx = 0;
 	u64 addr;
 
-	if (page_shift < PAGE_ADDR_SHIFT) {
+	if (page_shift < HNS_HW_PAGE_SHIFT) {
 		dev_err(hr_dev->dev, "Failed to check umem page shift %d!\n",
 			page_shift);
 		return -EINVAL;
diff --git a/drivers/infiniband/hw/hns/hns_roce_cq.c b/drivers/infiniband/hw/hns/hns_roce_cq.c
index d2d7074..6dd8dea 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cq.c
@@ -149,14 +149,14 @@ static int alloc_cq_buf(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq,
 	struct hns_roce_buf_attr buf_attr = {};
 	int err;
 
-	buf_attr.page_shift = hr_dev->caps.cqe_buf_pg_sz + PAGE_ADDR_SHIFT;
+	buf_attr.page_shift = hr_dev->caps.cqe_buf_pg_sz + HNS_HW_PAGE_SHIFT;
 	buf_attr.region[0].size = hr_cq->cq_depth * hr_dev->caps.cq_entry_sz;
 	buf_attr.region[0].hopnum = hr_dev->caps.cqe_hop_num;
 	buf_attr.region_count = 1;
 	buf_attr.fixed_page = true;
 
 	err = hns_roce_mtr_create(hr_dev, &hr_cq->mtr, &buf_attr,
-				  hr_dev->caps.cqe_ba_pg_sz + PAGE_ADDR_SHIFT,
+				  hr_dev->caps.cqe_ba_pg_sz + HNS_HW_PAGE_SHIFT,
 				  udata, addr);
 	if (err)
 		ibdev_err(ibdev, "Failed to alloc CQ mtr, err %d\n", err);
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 5564773..543c37a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -260,7 +260,9 @@ enum {
 #define HNS_ROCE_PORT_DOWN			0
 #define HNS_ROCE_PORT_UP			1
 
-#define PAGE_ADDR_SHIFT				12
+/* The minimum page size is 4K for hardware */
+#define HNS_HW_PAGE_SHIFT			12
+#define HNS_HW_PAGE_SIZE			(1 << HNS_HW_PAGE_SHIFT)
 
 /* The minimum page count for hardware access page directly. */
 #define HNS_HW_DIRECT_PAGE_COUNT 2
@@ -1079,16 +1081,16 @@ static inline dma_addr_t hns_roce_buf_page(struct hns_roce_buf *buf, int idx)
 		return buf->page_list[idx].map;
 }
 
-#define hr_hw_page_align(x)		ALIGN(x, 1 << PAGE_ADDR_SHIFT)
+#define hr_hw_page_align(x)		ALIGN(x, 1 << HNS_HW_PAGE_SHIFT)
 
 static inline u64 to_hr_hw_page_addr(u64 addr)
 {
-	return addr >> PAGE_ADDR_SHIFT;
+	return addr >> HNS_HW_PAGE_SHIFT;
 }
 
 static inline u32 to_hr_hw_page_shift(u32 page_shift)
 {
-	return page_shift - PAGE_ADDR_SHIFT;
+	return page_shift - HNS_HW_PAGE_SHIFT;
 }
 
 static inline u32 to_hr_hem_hopnum(u32 hopnum, u32 count)
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index d137abc..e7ebe31 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -5603,7 +5603,7 @@ static int alloc_eq_buf(struct hns_roce_dev *hr_dev, struct hns_roce_eq *eq)
 	else
 		eq->hop_num = hr_dev->caps.eqe_hop_num;
 
-	buf_attr.page_shift = hr_dev->caps.eqe_buf_pg_sz + PAGE_ADDR_SHIFT;
+	buf_attr.page_shift = hr_dev->caps.eqe_buf_pg_sz + HNS_HW_PAGE_SHIFT;
 	buf_attr.region[0].size = eq->entries * eq->eqe_size;
 	buf_attr.region[0].hopnum = eq->hop_num;
 	buf_attr.region_count = 1;
@@ -5611,7 +5611,7 @@ static int alloc_eq_buf(struct hns_roce_dev *hr_dev, struct hns_roce_eq *eq)
 
 	err = hns_roce_mtr_create(hr_dev, &eq->mtr, &buf_attr,
 				  hr_dev->caps.eqe_ba_pg_sz +
-				  PAGE_ADDR_SHIFT, NULL, 0);
+				  HNS_HW_PAGE_SHIFT, NULL, 0);
 	if (err)
 		dev_err(hr_dev->dev, "Failed to alloc EQE mtr, err %d\n", err);
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index f727b18..3075e845 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -120,7 +120,7 @@ static int alloc_mr_pbl(struct hns_roce_dev *hr_dev, struct hns_roce_mr *mr,
 
 	mr->pbl_hop_num = is_fast ? 1 : hr_dev->caps.pbl_hop_num;
 	buf_attr.page_shift = is_fast ? PAGE_SHIFT :
-			      hr_dev->caps.pbl_buf_pg_sz + PAGE_ADDR_SHIFT;
+			      hr_dev->caps.pbl_buf_pg_sz + HNS_HW_PAGE_SHIFT;
 	buf_attr.region[0].size = length;
 	buf_attr.region[0].hopnum = mr->pbl_hop_num;
 	buf_attr.region_count = 1;
@@ -130,7 +130,7 @@ static int alloc_mr_pbl(struct hns_roce_dev *hr_dev, struct hns_roce_mr *mr,
 	buf_attr.mtt_only = is_fast;
 
 	err = hns_roce_mtr_create(hr_dev, &mr->pbl_mtr, &buf_attr,
-				  hr_dev->caps.pbl_ba_pg_sz + PAGE_ADDR_SHIFT,
+				  hr_dev->caps.pbl_ba_pg_sz + HNS_HW_PAGE_SHIFT,
 				  udata, start);
 	if (err)
 		ibdev_err(ibdev, "failed to alloc pbl mtr, ret = %d.\n", err);
@@ -819,7 +819,7 @@ static int mtr_alloc_bufs(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 	}
 
 	/* must bigger than minimum hardware page shift */
-	if (best_pg_shift < PAGE_ADDR_SHIFT || all_pg_count < 1) {
+	if (best_pg_shift < HNS_HW_PAGE_SHIFT || all_pg_count < 1) {
 		ret = -EINVAL;
 		ibdev_err(ibdev, "Failed to check mtr page shift %d count %d\n",
 			  best_pg_shift, all_pg_count);
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index b570759..c8334d7 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -546,7 +546,7 @@ static int split_wqe_buf_region(struct hns_roce_dev *hr_dev,
 	if (hr_qp->buff_size < 1)
 		return -EINVAL;
 
-	buf_attr->page_shift = PAGE_ADDR_SHIFT + hr_dev->caps.mtt_buf_pg_sz;
+	buf_attr->page_shift = HNS_HW_PAGE_SHIFT + hr_dev->caps.mtt_buf_pg_sz;
 	buf_attr->fixed_page = true;
 	buf_attr->region_count = idx;
 
@@ -681,7 +681,7 @@ static int alloc_qp_buf(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 		goto err_inline;
 	}
 	ret = hns_roce_mtr_create(hr_dev, &hr_qp->mtr, &buf_attr,
-				  PAGE_ADDR_SHIFT + hr_dev->caps.mtt_ba_pg_sz,
+				  HNS_HW_PAGE_SHIFT + hr_dev->caps.mtt_ba_pg_sz,
 				  udata, addr);
 	if (ret) {
 		ibdev_err(ibdev, "failed to create WQE mtr, ret = %d.\n", ret);
diff --git a/drivers/infiniband/hw/hns/hns_roce_srq.c b/drivers/infiniband/hw/hns/hns_roce_srq.c
index 6e5a2ad..03b76e6 100644
--- a/drivers/infiniband/hw/hns/hns_roce_srq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_srq.c
@@ -187,7 +187,7 @@ static int alloc_srq_buf(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq,
 						      HNS_ROCE_SGE_SIZE *
 						      srq->max_gs)));
 
-	buf_attr.page_shift = hr_dev->caps.srqwqe_buf_pg_sz + PAGE_ADDR_SHIFT;
+	buf_attr.page_shift = hr_dev->caps.srqwqe_buf_pg_sz + HNS_HW_PAGE_SHIFT;
 	buf_attr.region[0].size = to_hr_hem_entries_size(srq->wqe_cnt,
 							 srq->wqe_shift);
 	buf_attr.region[0].hopnum = hr_dev->caps.srqwqe_hop_num;
@@ -196,7 +196,7 @@ static int alloc_srq_buf(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq,
 
 	err = hns_roce_mtr_create(hr_dev, &srq->buf_mtr, &buf_attr,
 				  hr_dev->caps.srqwqe_ba_pg_sz +
-				  PAGE_ADDR_SHIFT, udata, addr);
+				  HNS_HW_PAGE_SHIFT, udata, addr);
 	if (err)
 		ibdev_err(ibdev, "Failed to alloc SRQ buf mtr, err %d\n", err);
 
@@ -218,7 +218,7 @@ static int alloc_srq_idx(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq,
 
 	srq->idx_que.entry_shift = ilog2(HNS_ROCE_IDX_QUE_ENTRY_SZ);
 
-	buf_attr.page_shift = hr_dev->caps.idx_buf_pg_sz + PAGE_ADDR_SHIFT;
+	buf_attr.page_shift = hr_dev->caps.idx_buf_pg_sz + HNS_HW_PAGE_SHIFT;
 	buf_attr.region[0].size = to_hr_hem_entries_size(srq->wqe_cnt,
 					srq->idx_que.entry_shift);
 	buf_attr.region[0].hopnum = hr_dev->caps.idx_hop_num;
@@ -226,7 +226,7 @@ static int alloc_srq_idx(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq,
 	buf_attr.fixed_page = true;
 
 	err = hns_roce_mtr_create(hr_dev, &idx_que->mtr, &buf_attr,
-				  hr_dev->caps.idx_ba_pg_sz + PAGE_ADDR_SHIFT,
+				  hr_dev->caps.idx_ba_pg_sz + HNS_HW_PAGE_SHIFT,
 				  udata, addr);
 	if (err) {
 		ibdev_err(ibdev, "Failed to alloc SRQ idx mtr, err %d\n", err);
-- 
2.8.1

