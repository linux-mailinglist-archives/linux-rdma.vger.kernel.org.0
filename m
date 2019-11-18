Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 611E5FFD24
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Nov 2019 03:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbfKRCi3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 17 Nov 2019 21:38:29 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:6689 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726068AbfKRCi3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 17 Nov 2019 21:38:29 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 765AC31DA5A4C0243FBC;
        Mon, 18 Nov 2019 10:38:24 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Mon, 18 Nov 2019 10:38:14 +0800
From:   Weihang Li <liweihang@hisilicon.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH for-next 2/4] RDMA/hns: Redefine the member of hns_roce_cq struct
Date:   Mon, 18 Nov 2019 10:34:51 +0800
Message-ID: <1574044493-46984-3-git-send-email-liweihang@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1574044493-46984-1-git-send-email-liweihang@hisilicon.com>
References: <1574044493-46984-1-git-send-email-liweihang@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yixian Liu <liuyixian@huawei.com>

There is no need to package buf and mtt into hns_roce_cq_buf,
which will make code more complex, just delete this struct
and move buf and mtt into hns_roce_cq. Furthermore, we add
size member for hns_roce_buf to avoid repeatly calculating
where needed it.

Signed-off-by: Yixian Liu <liuyixian@huawei.com>
Signed-off-by: Weihang Li <liweihang@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_cq.c     | 73 ++++++++++++-----------------
 drivers/infiniband/hw/hns/hns_roce_device.h |  9 ++--
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c  |  9 ++--
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  3 +-
 4 files changed, 38 insertions(+), 56 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_cq.c b/drivers/infiniband/hw/hns/hns_roce_cq.c
index 87d9b0f..e9c9453 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cq.c
@@ -101,9 +101,9 @@ static int hns_roce_cq_alloc(struct hns_roce_dev *hr_dev,
 	else
 		mtt_table = &hr_dev->mr_table.mtt_table;
 
-	mtts = hns_roce_table_find(hr_dev, mtt_table,
-				   hr_cq->hr_buf.hr_mtt.first_seg,
+	mtts = hns_roce_table_find(hr_dev, mtt_table, hr_cq->mtt.first_seg,
 				   &dma_handle);
+
 	if (!mtts) {
 		dev_err(dev, "Failed to find mtt for CQ buf.\n");
 		return -EINVAL;
@@ -207,45 +207,36 @@ static int hns_roce_ib_get_cq_umem(struct hns_roce_dev *hr_dev,
 				   struct hns_roce_ib_create_cq ucmd,
 				   struct ib_udata *udata)
 {
-	struct hns_roce_cq_buf *buf = &hr_cq->hr_buf;
+	struct hns_roce_buf *buf = &hr_cq->buf;
+	struct hns_roce_mtt *mtt = &hr_cq->mtt;
 	struct ib_umem **umem = &hr_cq->umem;
-	u32 page_shift;
 	u32 npages;
 	int ret;
 
-	*umem = ib_umem_get(udata, ucmd.buf_addr,
-			    hr_cq->cq_depth * hr_dev->caps.cq_entry_sz,
+	*umem = ib_umem_get(udata, ucmd.buf_addr, buf->size,
 			    IB_ACCESS_LOCAL_WRITE);
 	if (IS_ERR(*umem))
 		return PTR_ERR(*umem);
 
 	if (hns_roce_check_whether_mhop(hr_dev, HEM_TYPE_CQE))
-		buf->hr_mtt.mtt_type = MTT_TYPE_CQE;
+		mtt->mtt_type = MTT_TYPE_CQE;
 	else
-		buf->hr_mtt.mtt_type = MTT_TYPE_WQE;
-
-	if (hr_dev->caps.cqe_buf_pg_sz) {
-		npages = (ib_umem_page_count(*umem) +
-			(1 << hr_dev->caps.cqe_buf_pg_sz) - 1) /
-			(1 << hr_dev->caps.cqe_buf_pg_sz);
-		page_shift = PAGE_SHIFT + hr_dev->caps.cqe_buf_pg_sz;
-		ret = hns_roce_mtt_init(hr_dev, npages, page_shift,
-					&buf->hr_mtt);
-	} else {
-		ret = hns_roce_mtt_init(hr_dev, ib_umem_page_count(*umem),
-					PAGE_SHIFT, &buf->hr_mtt);
-	}
+		mtt->mtt_type = MTT_TYPE_WQE;
+
+	npages = DIV_ROUND_UP(ib_umem_page_count(*umem),
+			      1 << hr_dev->caps.cqe_buf_pg_sz);
+	ret = hns_roce_mtt_init(hr_dev, npages, buf->page_shift, mtt);
 	if (ret)
 		goto err_buf;
 
-	ret = hns_roce_ib_umem_write_mtt(hr_dev, &buf->hr_mtt, *umem);
+	ret = hns_roce_ib_umem_write_mtt(hr_dev, mtt, *umem);
 	if (ret)
 		goto err_mtt;
 
 	return 0;
 
 err_mtt:
-	hns_roce_mtt_cleanup(hr_dev, &buf->hr_mtt);
+	hns_roce_mtt_cleanup(hr_dev, mtt);
 
 err_buf:
 	ib_umem_release(*umem);
@@ -255,39 +246,36 @@ static int hns_roce_ib_get_cq_umem(struct hns_roce_dev *hr_dev,
 static int hns_roce_ib_alloc_cq_buf(struct hns_roce_dev *hr_dev,
 				    struct hns_roce_cq *hr_cq)
 {
-	struct hns_roce_cq_buf *buf = &hr_cq->hr_buf;
-	u32 page_shift = PAGE_SHIFT + hr_dev->caps.cqe_buf_pg_sz;
-	u32 nent = hr_cq->cq_depth;
+	struct hns_roce_buf *buf = &hr_cq->buf;
+	struct hns_roce_mtt *mtt = &hr_cq->mtt;
 	int ret;
 
-	ret = hns_roce_buf_alloc(hr_dev, nent * hr_dev->caps.cq_entry_sz,
-				 (1 << page_shift) * 2, &buf->hr_buf,
-				 page_shift);
+	ret = hns_roce_buf_alloc(hr_dev, buf->size, (1 << buf->page_shift) * 2,
+				 buf, buf->page_shift);
 	if (ret)
 		goto out;
 
 	if (hns_roce_check_whether_mhop(hr_dev, HEM_TYPE_CQE))
-		buf->hr_mtt.mtt_type = MTT_TYPE_CQE;
+		mtt->mtt_type = MTT_TYPE_CQE;
 	else
-		buf->hr_mtt.mtt_type = MTT_TYPE_WQE;
+		mtt->mtt_type = MTT_TYPE_WQE;
 
-	ret = hns_roce_mtt_init(hr_dev, buf->hr_buf.npages,
-				buf->hr_buf.page_shift, &buf->hr_mtt);
+	ret = hns_roce_mtt_init(hr_dev, buf->npages, buf->page_shift, mtt);
 	if (ret)
 		goto err_buf;
 
-	ret = hns_roce_buf_write_mtt(hr_dev, &buf->hr_mtt, &buf->hr_buf);
+	ret = hns_roce_buf_write_mtt(hr_dev, mtt, buf);
 	if (ret)
 		goto err_mtt;
 
 	return 0;
 
 err_mtt:
-	hns_roce_mtt_cleanup(hr_dev, &buf->hr_mtt);
+	hns_roce_mtt_cleanup(hr_dev, mtt);
 
 err_buf:
-	hns_roce_buf_free(hr_dev, nent * hr_dev->caps.cq_entry_sz,
-			  &buf->hr_buf);
+	hns_roce_buf_free(hr_dev, buf->size, buf);
+
 out:
 	return ret;
 }
@@ -295,8 +283,7 @@ static int hns_roce_ib_alloc_cq_buf(struct hns_roce_dev *hr_dev,
 static void hns_roce_ib_free_cq_buf(struct hns_roce_dev *hr_dev,
 				    struct hns_roce_cq *hr_cq)
 {
-	hns_roce_buf_free(hr_dev, hr_cq->cq_depth * hr_dev->caps.cq_entry_sz,
-			  &hr_cq->hr_buf.hr_buf);
+	hns_roce_buf_free(hr_dev, hr_cq->buf.size, &hr_cq->buf);
 }
 
 static int create_user_cq(struct hns_roce_dev *hr_dev,
@@ -337,7 +324,7 @@ static int create_user_cq(struct hns_roce_dev *hr_dev,
 	return 0;
 
 err_mtt:
-	hns_roce_mtt_cleanup(hr_dev, &hr_cq->hr_buf.hr_mtt);
+	hns_roce_mtt_cleanup(hr_dev, &hr_cq->mtt);
 	ib_umem_release(hr_cq->umem);
 
 	return ret;
@@ -390,14 +377,14 @@ static void destroy_user_cq(struct hns_roce_dev *hr_dev,
 	    (udata->outlen >= sizeof(*resp)))
 		hns_roce_db_unmap_user(context, &hr_cq->db);
 
-	hns_roce_mtt_cleanup(hr_dev, &hr_cq->hr_buf.hr_mtt);
+	hns_roce_mtt_cleanup(hr_dev, &hr_cq->mtt);
 	ib_umem_release(hr_cq->umem);
 }
 
 static void destroy_kernel_cq(struct hns_roce_dev *hr_dev,
 			      struct hns_roce_cq *hr_cq)
 {
-	hns_roce_mtt_cleanup(hr_dev, &hr_cq->hr_buf.hr_mtt);
+	hns_roce_mtt_cleanup(hr_dev, &hr_cq->mtt);
 	hns_roce_ib_free_cq_buf(hr_dev, hr_cq);
 
 	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RECORD_DB)
@@ -433,6 +420,8 @@ int hns_roce_ib_create_cq(struct ib_cq *ib_cq,
 	hr_cq->ib_cq.cqe = cq_entries - 1; /* used as cqe index */
 	hr_cq->cq_depth = cq_entries;
 	hr_cq->vector = vector;
+	hr_cq->buf.size = hr_cq->cq_depth * hr_dev->caps.cq_entry_sz;
+	hr_cq->buf.page_shift = PAGE_SHIFT + hr_dev->caps.cqe_buf_pg_sz;
 	spin_lock_init(&hr_cq->lock);
 
 	if (udata) {
@@ -502,7 +491,7 @@ void hns_roce_ib_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 	}
 
 	hns_roce_free_cq(hr_dev, hr_cq);
-	hns_roce_mtt_cleanup(hr_dev, &hr_cq->hr_buf.hr_mtt);
+	hns_roce_mtt_cleanup(hr_dev, &hr_cq->mtt);
 
 	ib_umem_release(hr_cq->umem);
 	if (udata) {
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 8f628a7..608ec59 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -448,6 +448,7 @@ struct hns_roce_buf {
 	struct hns_roce_buf_list	*page_list;
 	int				nbufs;
 	u32				npages;
+	u32				size;
 	int				page_shift;
 };
 
@@ -479,14 +480,10 @@ struct hns_roce_db {
 	int		order;
 };
 
-struct hns_roce_cq_buf {
-	struct hns_roce_buf hr_buf;
-	struct hns_roce_mtt hr_mtt;
-};
-
 struct hns_roce_cq {
 	struct ib_cq			ib_cq;
-	struct hns_roce_cq_buf		hr_buf;
+	struct hns_roce_buf		buf;
+	struct hns_roce_mtt		mtt;
 	struct hns_roce_db		db;
 	u8				db_en;
 	spinlock_t			lock;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
index 600d9f9..9a00361 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -1980,8 +1980,7 @@ static int hns_roce_v1_write_mtpt(void *mb_buf, struct hns_roce_mr *mr,
 
 static void *get_cqe(struct hns_roce_cq *hr_cq, int n)
 {
-	return hns_roce_buf_offset(&hr_cq->hr_buf.hr_buf,
-				   n * HNS_ROCE_V1_CQE_ENTRY_SIZE);
+	return hns_roce_buf_offset(&hr_cq->buf, n * HNS_ROCE_V1_CQE_ENTRY_SIZE);
 }
 
 static void *get_sw_cqe(struct hns_roce_cq *hr_cq, int n)
@@ -3655,7 +3654,6 @@ static void hns_roce_v1_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 	struct device *dev = &hr_dev->pdev->dev;
 	u32 cqe_cnt_ori;
 	u32 cqe_cnt_cur;
-	u32 cq_buf_size;
 	int wait_time = 0;
 
 	hns_roce_free_cq(hr_dev, hr_cq);
@@ -3683,13 +3681,12 @@ static void hns_roce_v1_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 		wait_time++;
 	}
 
-	hns_roce_mtt_cleanup(hr_dev, &hr_cq->hr_buf.hr_mtt);
+	hns_roce_mtt_cleanup(hr_dev, &hr_cq->mtt);
 
 	ib_umem_release(hr_cq->umem);
 	if (!udata) {
 		/* Free the buff of stored cq */
-		cq_buf_size = (ibcq->cqe + 1) * hr_dev->caps.cq_entry_sz;
-		hns_roce_buf_free(hr_dev, cq_buf_size, &hr_cq->hr_buf.hr_buf);
+		hns_roce_buf_free(hr_dev, hr_cq->buf.size, &hr_cq->buf);
 	}
 }
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 77c9d7f..1026ac6 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -2447,8 +2447,7 @@ static int hns_roce_v2_mw_write_mtpt(void *mb_buf, struct hns_roce_mw *mw)
 
 static void *get_cqe_v2(struct hns_roce_cq *hr_cq, int n)
 {
-	return hns_roce_buf_offset(&hr_cq->hr_buf.hr_buf,
-				   n * HNS_ROCE_V2_CQE_ENTRY_SIZE);
+	return hns_roce_buf_offset(&hr_cq->buf, n * HNS_ROCE_V2_CQE_ENTRY_SIZE);
 }
 
 static void *get_sw_cqe_v2(struct hns_roce_cq *hr_cq, int n)
-- 
2.8.1

