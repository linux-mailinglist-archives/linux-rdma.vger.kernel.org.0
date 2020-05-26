Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09EFA1A6604
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2020 13:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbgDML6X (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Apr 2020 07:58:23 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:53194 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729302AbgDML6U (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 13 Apr 2020 07:58:20 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8D108E2429A7FEBA1851;
        Mon, 13 Apr 2020 19:58:17 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Mon, 13 Apr 2020 19:58:10 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 2/6] RDMA/hns: Optimize hns buffer allocation flow
Date:   Mon, 13 Apr 2020 19:58:07 +0800
Message-ID: <1586779091-51410-3-git-send-email-liweihang@huawei.com>
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

When the value of nbufs is 1, the buffer is in direct mode, which may cause
confusion. So optimizes current codes to make it easier to maintain and
understand.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_alloc.c  | 103 +++++++++++++---------------
 drivers/infiniband/hw/hns/hns_roce_cq.c     |  18 ++---
 drivers/infiniband/hw/hns/hns_roce_device.h |  32 ++++++---
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c  |   2 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  43 +++++-------
 drivers/infiniband/hw/hns/hns_roce_mr.c     |   8 +--
 drivers/infiniband/hw/hns/hns_roce_qp.c     |   6 +-
 drivers/infiniband/hw/hns/hns_roce_srq.c    |  37 +++++-----
 8 files changed, 121 insertions(+), 128 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_alloc.c b/drivers/infiniband/hw/hns/hns_roce_alloc.c
index da574c2..e04e759 100644
--- a/drivers/infiniband/hw/hns/hns_roce_alloc.c
+++ b/drivers/infiniband/hw/hns/hns_roce_alloc.c
@@ -157,84 +157,78 @@ void hns_roce_bitmap_cleanup(struct hns_roce_bitmap *bitmap)
 	kfree(bitmap->table);
 }
 
-void hns_roce_buf_free(struct hns_roce_dev *hr_dev, u32 size,
-		       struct hns_roce_buf *buf)
+void hns_roce_buf_free(struct hns_roce_dev *hr_dev, struct hns_roce_buf *buf)
 {
-	int i;
 	struct device *dev = hr_dev->dev;
+	u32 size = buf->size;
+	int i;
+
+	if (size == 0)
+		return;
+
+	buf->size = 0;
 
-	if (buf->nbufs == 1) {
+	if (hns_roce_buf_is_direct(buf)) {
 		dma_free_coherent(dev, size, buf->direct.buf, buf->direct.map);
 	} else {
-		for (i = 0; i < buf->nbufs; ++i)
+		for (i = 0; i < buf->npages; ++i)
 			if (buf->page_list[i].buf)
 				dma_free_coherent(dev, 1 << buf->page_shift,
 						  buf->page_list[i].buf,
 						  buf->page_list[i].map);
 		kfree(buf->page_list);
+		buf->page_list = NULL;
 	}
 }
 
 int hns_roce_buf_alloc(struct hns_roce_dev *hr_dev, u32 size, u32 max_direct,
 		       struct hns_roce_buf *buf, u32 page_shift)
 {
-	int i = 0;
-	dma_addr_t t;
+	struct hns_roce_buf_list *buf_list;
 	struct device *dev = hr_dev->dev;
-	u32 page_size = 1 << page_shift;
-	u32 order;
+	u32 page_size;
+	int i;
+
+	/* The minimum shift of the page accessed by hw is PAGE_ADDR_SHIFT */
+	buf->page_shift = max_t(int, PAGE_ADDR_SHIFT, page_shift);
 
-	/* SQ/RQ buf lease than one page, SQ + RQ = 8K */
+	page_size = 1 << buf->page_shift;
+	buf->npages = DIV_ROUND_UP(size, page_size);
+
+	/* required size is not bigger than one trunk size */
 	if (size <= max_direct) {
-		buf->nbufs = 1;
-		/* Npages calculated by page_size */
-		order = get_order(size);
-		if (order <= page_shift - PAGE_SHIFT)
-			order = 0;
-		else
-			order -= page_shift - PAGE_SHIFT;
-		buf->npages = 1 << order;
-		buf->page_shift = page_shift;
-		/* MTT PA must be recorded in 4k alignment, t is 4k aligned */
-		buf->direct.buf = dma_alloc_coherent(dev, size, &t,
+		buf->page_list = NULL;
+		buf->direct.buf = dma_alloc_coherent(dev, size,
+						     &buf->direct.map,
 						     GFP_KERNEL);
 		if (!buf->direct.buf)
 			return -ENOMEM;
-
-		buf->direct.map = t;
-
-		while (t & ((1 << buf->page_shift) - 1)) {
-			--buf->page_shift;
-			buf->npages *= 2;
-		}
 	} else {
-		buf->nbufs = (size + page_size - 1) / page_size;
-		buf->npages = buf->nbufs;
-		buf->page_shift = page_shift;
-		buf->page_list = kcalloc(buf->nbufs, sizeof(*buf->page_list),
-					 GFP_KERNEL);
-
-		if (!buf->page_list)
+		buf_list = kcalloc(buf->npages, sizeof(*buf_list), GFP_KERNEL);
+		if (!buf_list)
 			return -ENOMEM;
 
-		for (i = 0; i < buf->nbufs; ++i) {
-			buf->page_list[i].buf = dma_alloc_coherent(dev,
-								   page_size,
-								   &t,
-								   GFP_KERNEL);
-
-			if (!buf->page_list[i].buf)
-				goto err_free;
+		for (i = 0; i < buf->npages; i++) {
+			buf_list[i].buf = dma_alloc_coherent(dev, page_size,
+							     &buf_list[i].map,
+							     GFP_KERNEL);
+			if (!buf_list[i].buf)
+				break;
+		}
 
-			buf->page_list[i].map = t;
+		if (i != buf->npages && i > 0) {
+			while (i-- > 0)
+				dma_free_coherent(dev, page_size,
+						  buf_list[i].buf,
+						  buf_list[i].map);
+			kfree(buf_list);
+			return -ENOMEM;
 		}
+		buf->page_list = buf_list;
 	}
+	buf->size = size;
 
 	return 0;
-
-err_free:
-	hns_roce_buf_free(hr_dev, size, buf);
-	return -ENOMEM;
 }
 
 int hns_roce_get_kmem_bufs(struct hns_roce_dev *hr_dev, dma_addr_t *bufs,
@@ -246,18 +240,14 @@ int hns_roce_get_kmem_bufs(struct hns_roce_dev *hr_dev, dma_addr_t *bufs,
 	end = start + buf_cnt;
 	if (end > buf->npages) {
 		dev_err(hr_dev->dev,
-			"invalid kmem region,offset %d,buf_cnt %d,total %d!\n",
+			"Failed to check kmem bufs, end %d + %d total %d!\n",
 			start, buf_cnt, buf->npages);
 		return -EINVAL;
 	}
 
 	total = 0;
 	for (i = start; i < end; i++)
-		if (buf->nbufs == 1)
-			bufs[total++] = buf->direct.map +
-					((dma_addr_t)i << buf->page_shift);
-		else
-			bufs[total++] = buf->page_list[i].map;
+		bufs[total++] = hns_roce_buf_page(buf, i);
 
 	return total;
 }
@@ -271,8 +261,9 @@ int hns_roce_get_umem_bufs(struct hns_roce_dev *hr_dev, dma_addr_t *bufs,
 	int idx = 0;
 	u64 addr;
 
-	if (page_shift < PAGE_SHIFT) {
-		dev_err(hr_dev->dev, "invalid page shift %d!\n", page_shift);
+	if (page_shift < PAGE_ADDR_SHIFT) {
+		dev_err(hr_dev->dev, "Failed to check umem page shift %d!\n",
+			page_shift);
 		return -EINVAL;
 	}
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_cq.c b/drivers/infiniband/hw/hns/hns_roce_cq.c
index 5bfb52f..92798ff 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cq.c
@@ -157,13 +157,12 @@ static int get_cq_umem(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq,
 		       struct hns_roce_ib_create_cq ucmd,
 		       struct ib_udata *udata)
 {
-	struct hns_roce_buf *buf = &hr_cq->buf;
 	struct hns_roce_mtt *mtt = &hr_cq->mtt;
 	struct ib_umem **umem = &hr_cq->umem;
 	u32 npages;
 	int ret;
 
-	*umem = ib_umem_get(&hr_dev->ib_dev, ucmd.buf_addr, buf->size,
+	*umem = ib_umem_get(&hr_dev->ib_dev, ucmd.buf_addr, hr_cq->buf_size,
 			    IB_ACCESS_LOCAL_WRITE);
 	if (IS_ERR(*umem))
 		return PTR_ERR(*umem);
@@ -175,7 +174,7 @@ static int get_cq_umem(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq,
 
 	npages = DIV_ROUND_UP(ib_umem_page_count(*umem),
 			      1 << hr_dev->caps.cqe_buf_pg_sz);
-	ret = hns_roce_mtt_init(hr_dev, npages, buf->page_shift, mtt);
+	ret = hns_roce_mtt_init(hr_dev, npages, hr_cq->page_shift, mtt);
 	if (ret)
 		goto err_buf;
 
@@ -199,8 +198,9 @@ static int alloc_cq_buf(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq)
 	struct hns_roce_mtt *mtt = &hr_cq->mtt;
 	int ret;
 
-	ret = hns_roce_buf_alloc(hr_dev, buf->size, (1 << buf->page_shift) * 2,
-				 buf, buf->page_shift);
+	ret = hns_roce_buf_alloc(hr_dev, hr_cq->buf_size,
+				 (1 << hr_cq->page_shift) * 2,
+				 buf, hr_cq->page_shift);
 	if (ret)
 		goto out;
 
@@ -223,7 +223,7 @@ static int alloc_cq_buf(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq)
 	hns_roce_mtt_cleanup(hr_dev, mtt);
 
 err_buf:
-	hns_roce_buf_free(hr_dev, buf->size, buf);
+	hns_roce_buf_free(hr_dev, buf);
 
 out:
 	return ret;
@@ -231,7 +231,7 @@ static int alloc_cq_buf(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq)
 
 static void free_cq_buf(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq)
 {
-	hns_roce_buf_free(hr_dev, hr_cq->buf.size, &hr_cq->buf);
+	hns_roce_buf_free(hr_dev, &hr_cq->buf);
 }
 
 static int create_user_cq(struct hns_roce_dev *hr_dev,
@@ -367,8 +367,8 @@ int hns_roce_create_cq(struct ib_cq *ib_cq, const struct ib_cq_init_attr *attr,
 	hr_cq->ib_cq.cqe = cq_entries - 1; /* used as cqe index */
 	hr_cq->cq_depth = cq_entries;
 	hr_cq->vector = vector;
-	hr_cq->buf.size = hr_cq->cq_depth * hr_dev->caps.cq_entry_sz;
-	hr_cq->buf.page_shift = PAGE_SHIFT + hr_dev->caps.cqe_buf_pg_sz;
+	hr_cq->buf_size = hr_cq->cq_depth * hr_dev->caps.cq_entry_sz;
+	hr_cq->page_shift = PAGE_SHIFT + hr_dev->caps.cqe_buf_pg_sz;
 	spin_lock_init(&hr_cq->lock);
 	INIT_LIST_HEAD(&hr_cq->sq_list);
 	INIT_LIST_HEAD(&hr_cq->rq_list);
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 4a7afec..c37617d 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -468,7 +468,6 @@ struct hns_roce_buf_list {
 struct hns_roce_buf {
 	struct hns_roce_buf_list	direct;
 	struct hns_roce_buf_list	*page_list;
-	int				nbufs;
 	u32				npages;
 	u32				size;
 	int				page_shift;
@@ -510,6 +509,8 @@ struct hns_roce_cq {
 	u8				db_en;
 	spinlock_t			lock;
 	struct ib_umem			*umem;
+	u32				buf_size;
+	int				page_shift;
 	u32				cq_depth;
 	u32				cons_index;
 	u32				*set_ci_db;
@@ -549,6 +550,8 @@ struct hns_roce_srq {
 	struct hns_roce_buf	buf;
 	u64		       *wrid;
 	struct ib_umem	       *umem;
+	u32			buf_size;
+	int			page_shift;
 	struct hns_roce_mtt	mtt;
 	struct hns_roce_idx_que idx_que;
 	spinlock_t		lock;
@@ -1124,15 +1127,29 @@ static inline struct hns_roce_qp
 	return xa_load(&hr_dev->qp_table_xa, qpn & (hr_dev->caps.num_qps - 1));
 }
 
+static inline bool hns_roce_buf_is_direct(struct hns_roce_buf *buf)
+{
+	if (buf->page_list)
+		return false;
+
+	return true;
+}
+
 static inline void *hns_roce_buf_offset(struct hns_roce_buf *buf, int offset)
 {
-	u32 page_size = 1 << buf->page_shift;
+	if (hns_roce_buf_is_direct(buf))
+		return (char *)(buf->direct.buf) + (offset & (buf->size - 1));
 
-	if (buf->nbufs == 1)
-		return (char *)(buf->direct.buf) + offset;
+	return (char *)(buf->page_list[offset >> buf->page_shift].buf) +
+	       (offset & ((1 << buf->page_shift) - 1));
+}
+
+static inline dma_addr_t hns_roce_buf_page(struct hns_roce_buf *buf, int idx)
+{
+	if (hns_roce_buf_is_direct(buf))
+		return buf->direct.map + ((dma_addr_t)idx << buf->page_shift);
 	else
-		return (char *)(buf->page_list[offset >> buf->page_shift].buf) +
-		       (offset & (page_size - 1));
+		return buf->page_list[idx].map;
 }
 
 static inline u64 to_hr_hw_page_addr(u64 addr)
@@ -1240,8 +1257,7 @@ struct ib_mw *hns_roce_alloc_mw(struct ib_pd *pd, enum ib_mw_type,
 				struct ib_udata *udata);
 int hns_roce_dealloc_mw(struct ib_mw *ibmw);
 
-void hns_roce_buf_free(struct hns_roce_dev *hr_dev, u32 size,
-		       struct hns_roce_buf *buf);
+void hns_roce_buf_free(struct hns_roce_dev *hr_dev, struct hns_roce_buf *buf);
 int hns_roce_buf_alloc(struct hns_roce_dev *hr_dev, u32 size, u32 max_direct,
 		       struct hns_roce_buf *buf, u32 page_shift);
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
index 5ff028d..4b54906 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -3666,7 +3666,7 @@ static void hns_roce_v1_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 	ib_umem_release(hr_cq->umem);
 	if (!udata) {
 		/* Free the buff of stored cq */
-		hns_roce_buf_free(hr_dev, hr_cq->buf.size, &hr_cq->buf);
+		hns_roce_buf_free(hr_dev, &hr_cq->buf);
 	}
 }
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index c331667..998015d 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -4989,24 +4989,14 @@ static void set_eq_cons_index_v2(struct hns_roce_eq *eq)
 	hns_roce_write64(hr_dev, doorbell, eq->doorbell);
 }
 
-static inline void *get_eqe_buf(struct hns_roce_eq *eq, unsigned long offset)
-{
-	u32 buf_chk_sz;
-
-	buf_chk_sz = 1 << (eq->eqe_buf_pg_sz + PAGE_SHIFT);
-	if (eq->buf.nbufs == 1)
-		return eq->buf.direct.buf + offset % buf_chk_sz;
-	else
-		return eq->buf.page_list[offset / buf_chk_sz].buf +
-		       offset % buf_chk_sz;
-}
-
 static struct hns_roce_aeqe *next_aeqe_sw_v2(struct hns_roce_eq *eq)
 {
 	struct hns_roce_aeqe *aeqe;
 
-	aeqe = get_eqe_buf(eq, (eq->cons_index & (eq->entries - 1)) *
-			   HNS_ROCE_AEQ_ENTRY_SIZE);
+	aeqe = hns_roce_buf_offset(&eq->buf,
+				   (eq->cons_index & (eq->entries - 1)) *
+				   HNS_ROCE_AEQ_ENTRY_SIZE);
+
 	return (roce_get_bit(aeqe->asyn, HNS_ROCE_V2_AEQ_AEQE_OWNER_S) ^
 		!!(eq->cons_index & eq->entries)) ? aeqe : NULL;
 }
@@ -5103,8 +5093,9 @@ static struct hns_roce_ceqe *next_ceqe_sw_v2(struct hns_roce_eq *eq)
 {
 	struct hns_roce_ceqe *ceqe;
 
-	ceqe = get_eqe_buf(eq, (eq->cons_index & (eq->entries - 1)) *
-			   HNS_ROCE_CEQ_ENTRY_SIZE);
+	ceqe = hns_roce_buf_offset(&eq->buf,
+				   (eq->cons_index & (eq->entries - 1)) *
+				   HNS_ROCE_CEQ_ENTRY_SIZE);
 	return (!!(roce_get_bit(ceqe->comp, HNS_ROCE_V2_CEQ_CEQE_OWNER_S))) ^
 		(!!(eq->cons_index & eq->entries)) ? ceqe : NULL;
 }
@@ -5265,7 +5256,7 @@ static void free_eq_buf(struct hns_roce_dev *hr_dev, struct hns_roce_eq *eq)
 {
 	if (!eq->hop_num || eq->hop_num == HNS_ROCE_HOP_NUM_0)
 		hns_roce_mtr_cleanup(hr_dev, &eq->mtr);
-	hns_roce_buf_free(hr_dev, eq->buf.size, &eq->buf);
+	hns_roce_buf_free(hr_dev, &eq->buf);
 }
 
 static void hns_roce_config_eqc(struct hns_roce_dev *hr_dev,
@@ -5290,7 +5281,8 @@ static void hns_roce_config_eqc(struct hns_roce_dev *hr_dev,
 	eq->eqe_buf_pg_sz = hr_dev->caps.eqe_buf_pg_sz;
 	eq->shift = ilog2((unsigned int)eq->entries);
 
-	/* if not muti-hop, eqe buffer only use one trunk */
+	/* if not multi-hop, eqe buffer only use one trunk */
+	eq->eqe_buf_pg_sz = eq->buf.page_shift - PAGE_ADDR_SHIFT;
 	if (!eq->hop_num || eq->hop_num == HNS_ROCE_HOP_NUM_0) {
 		eq->eqe_ba = eq->buf.direct.map;
 		eq->cur_eqe_ba = eq->eqe_ba;
@@ -5432,7 +5424,7 @@ static int map_eq_buf(struct hns_roce_dev *hr_dev, struct hns_roce_eq *eq,
 		goto done;
 	}
 
-	hns_roce_mtr_init(&eq->mtr, PAGE_SHIFT + hr_dev->caps.eqe_ba_pg_sz,
+	hns_roce_mtr_init(&eq->mtr, PAGE_ADDR_SHIFT + hr_dev->caps.eqe_ba_pg_sz,
 			  page_shift);
 	ret = hns_roce_mtr_attach(hr_dev, &eq->mtr, &buf_list, &region, 1);
 	if (ret)
@@ -5454,23 +5446,24 @@ static int alloc_eq_buf(struct hns_roce_dev *hr_dev, struct hns_roce_eq *eq)
 	u32 page_shift;
 	u32 mhop_num;
 	u32 max_size;
+	u32 buf_size;
 	int ret;
 
-	page_shift = PAGE_SHIFT + hr_dev->caps.eqe_buf_pg_sz;
+	page_shift = PAGE_ADDR_SHIFT + hr_dev->caps.eqe_buf_pg_sz;
 	mhop_num = hr_dev->caps.eqe_hop_num;
 	if (!mhop_num) {
 		max_size = 1 << page_shift;
-		buf->size = max_size;
+		buf_size = max_size;
 	} else if (mhop_num == HNS_ROCE_HOP_NUM_0) {
 		max_size = eq->entries * eq->eqe_size;
-		buf->size = max_size;
+		buf_size = max_size;
 	} else {
 		max_size = 1 << page_shift;
-		buf->size = PAGE_ALIGN(eq->entries * eq->eqe_size);
+		buf_size = round_up(eq->entries * eq->eqe_size, max_size);
 		is_mhop = true;
 	}
 
-	ret = hns_roce_buf_alloc(hr_dev, buf->size, max_size, buf, page_shift);
+	ret = hns_roce_buf_alloc(hr_dev, buf_size, max_size, buf, page_shift);
 	if (ret) {
 		dev_err(hr_dev->dev, "alloc eq buf error\n");
 		return ret;
@@ -5486,7 +5479,7 @@ static int alloc_eq_buf(struct hns_roce_dev *hr_dev, struct hns_roce_eq *eq)
 
 	return 0;
 err_alloc:
-	hns_roce_buf_free(hr_dev, buf->size, buf);
+	hns_roce_buf_free(hr_dev, buf);
 	return ret;
 }
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index b3af369..99e3876 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -900,13 +900,9 @@ int hns_roce_buf_write_mtt(struct hns_roce_dev *hr_dev,
 	if (!page_list)
 		return -ENOMEM;
 
-	for (i = 0; i < buf->npages; ++i) {
-		if (buf->nbufs == 1)
-			page_list[i] = buf->direct.map + (i << buf->page_shift);
-		else
-			page_list[i] = buf->page_list[i].map;
+	for (i = 0; i < buf->npages; ++i)
+		page_list[i] = hns_roce_buf_page(buf, i);
 
-	}
 	ret = hns_roce_write_mtt(hr_dev, mtt, 0, buf->npages, page_list);
 
 	kfree(page_list);
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 6317901..1667f37 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -839,7 +839,7 @@ static int alloc_qp_buf(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 		ib_umem_release(hr_qp->umem);
 		hr_qp->umem = NULL;
 	} else {
-		hns_roce_buf_free(hr_dev, hr_qp->buff_size, &hr_qp->hr_buf);
+		hns_roce_buf_free(hr_dev, &hr_qp->hr_buf);
 	}
 
 	ibdev_err(ibdev, "Failed to alloc WQE buffer, ret %d.\n", ret);
@@ -855,8 +855,8 @@ static void free_qp_buf(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
 		hr_qp->umem = NULL;
 	}
 
-	if (hr_qp->hr_buf.nbufs > 0)
-		hns_roce_buf_free(hr_dev, hr_qp->buff_size, &hr_qp->hr_buf);
+	if (hr_qp->hr_buf.npages > 0)
+		hns_roce_buf_free(hr_dev, &hr_qp->hr_buf);
 
 	if ((hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RQ_INLINE) &&
 	     hr_qp->rq.wqe_cnt)
diff --git a/drivers/infiniband/hw/hns/hns_roce_srq.c b/drivers/infiniband/hw/hns/hns_roce_srq.c
index 5b3dd1a..9851d76 100644
--- a/drivers/infiniband/hw/hns/hns_roce_srq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_srq.c
@@ -180,7 +180,8 @@ static int create_user_srq(struct hns_roce_srq *srq, struct ib_udata *udata,
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(srq->ibsrq.device);
 	struct hns_roce_ib_create_srq  ucmd;
-	struct hns_roce_buf *buf;
+	int page_shift;
+	int page_count;
 	int ret;
 
 	if (ib_copy_from_udata(&ucmd, udata, sizeof(ucmd)))
@@ -191,12 +192,11 @@ static int create_user_srq(struct hns_roce_srq *srq, struct ib_udata *udata,
 	if (IS_ERR(srq->umem))
 		return PTR_ERR(srq->umem);
 
-	buf = &srq->buf;
-	buf->npages = (ib_umem_page_count(srq->umem) +
-		       (1 << hr_dev->caps.srqwqe_buf_pg_sz) - 1) /
+	page_count = (ib_umem_page_count(srq->umem) +
+		      (1 << hr_dev->caps.srqwqe_buf_pg_sz) - 1) /
 		      (1 << hr_dev->caps.srqwqe_buf_pg_sz);
-	buf->page_shift = PAGE_SHIFT + hr_dev->caps.srqwqe_buf_pg_sz;
-	ret = hns_roce_mtt_init(hr_dev, buf->npages, buf->page_shift,
+	page_shift = PAGE_SHIFT + hr_dev->caps.srqwqe_buf_pg_sz;
+	ret = hns_roce_mtt_init(hr_dev, page_count, page_shift,
 				&srq->mtt);
 	if (ret)
 		goto err_user_buf;
@@ -214,11 +214,10 @@ static int create_user_srq(struct hns_roce_srq *srq, struct ib_udata *udata,
 		goto err_user_srq_mtt;
 	}
 
-	buf = &srq->idx_que.idx_buf;
-	buf->npages = DIV_ROUND_UP(ib_umem_page_count(srq->idx_que.umem),
-				   1 << hr_dev->caps.idx_buf_pg_sz);
-	buf->page_shift = PAGE_SHIFT + hr_dev->caps.idx_buf_pg_sz;
-	ret = hns_roce_mtt_init(hr_dev, buf->npages, buf->page_shift,
+	page_count = DIV_ROUND_UP(ib_umem_page_count(srq->idx_que.umem),
+				  1 << hr_dev->caps.idx_buf_pg_sz);
+	page_shift = PAGE_SHIFT + hr_dev->caps.idx_buf_pg_sz;
+	ret = hns_roce_mtt_init(hr_dev, page_count, page_shift,
 				&srq->idx_que.mtt);
 	if (ret) {
 		dev_err(hr_dev->dev, "hns_roce_mtt_init error for idx que\n");
@@ -325,15 +324,14 @@ static int create_kernel_srq(struct hns_roce_srq *srq, int srq_buf_size)
 	hns_roce_mtt_cleanup(hr_dev, &srq->idx_que.mtt);
 
 err_kernel_create_idx:
-	hns_roce_buf_free(hr_dev, srq->idx_que.buf_size,
-			  &srq->idx_que.idx_buf);
+	hns_roce_buf_free(hr_dev, &srq->idx_que.idx_buf);
 	kfree(srq->idx_que.bitmap);
 
 err_kernel_srq_mtt:
 	hns_roce_mtt_cleanup(hr_dev, &srq->mtt);
 
 err_kernel_buf:
-	hns_roce_buf_free(hr_dev, srq_buf_size, &srq->buf);
+	hns_roce_buf_free(hr_dev, &srq->buf);
 
 	return ret;
 }
@@ -348,14 +346,14 @@ static void destroy_user_srq(struct hns_roce_dev *hr_dev,
 }
 
 static void destroy_kernel_srq(struct hns_roce_dev *hr_dev,
-			       struct hns_roce_srq *srq, int srq_buf_size)
+			       struct hns_roce_srq *srq)
 {
 	kvfree(srq->wrid);
 	hns_roce_mtt_cleanup(hr_dev, &srq->idx_que.mtt);
-	hns_roce_buf_free(hr_dev, srq->idx_que.buf_size, &srq->idx_que.idx_buf);
+	hns_roce_buf_free(hr_dev, &srq->idx_que.idx_buf);
 	kfree(srq->idx_que.bitmap);
 	hns_roce_mtt_cleanup(hr_dev, &srq->mtt);
-	hns_roce_buf_free(hr_dev, srq_buf_size, &srq->buf);
+	hns_roce_buf_free(hr_dev, &srq->buf);
 }
 
 int hns_roce_create_srq(struct ib_srq *ib_srq,
@@ -437,7 +435,7 @@ int hns_roce_create_srq(struct ib_srq *ib_srq,
 	if (udata)
 		destroy_user_srq(hr_dev, srq);
 	else
-		destroy_kernel_srq(hr_dev, srq, srq_buf_size);
+		destroy_kernel_srq(hr_dev, srq);
 
 err_srq:
 	return ret;
@@ -455,8 +453,7 @@ void hns_roce_destroy_srq(struct ib_srq *ibsrq, struct ib_udata *udata)
 		hns_roce_mtt_cleanup(hr_dev, &srq->idx_que.mtt);
 	} else {
 		kvfree(srq->wrid);
-		hns_roce_buf_free(hr_dev, srq->wqe_cnt << srq->wqe_shift,
-				  &srq->buf);
+		hns_roce_buf_free(hr_dev, &srq->buf);
 	}
 	ib_umem_release(srq->idx_que.umem);
 	ib_umem_release(srq->umem);
-- 
2.8.1

