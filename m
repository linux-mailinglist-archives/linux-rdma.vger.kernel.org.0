Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1040A61FB7
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2019 15:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731415AbfGHNo4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 8 Jul 2019 09:44:56 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2180 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729856AbfGHNo4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 8 Jul 2019 09:44:56 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5E1A76AB677ECD6CFA26;
        Mon,  8 Jul 2019 21:44:49 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Mon, 8 Jul 2019 21:44:39 +0800
From:   Lijun Ou <oulijun@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 2/9] RDMA/hns: Refactor the code of creating srq
Date:   Mon, 8 Jul 2019 21:41:18 +0800
Message-ID: <1562593285-8037-3-git-send-email-oulijun@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1562593285-8037-1-git-send-email-oulijun@huawei.com>
References: <1562593285-8037-1-git-send-email-oulijun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Here moves the relatived codes of creating user srq and
kernel srq into the two independent functions as well as
removes some unused codes and optimizes some codes.

Signed-off-by: Lijun Ou <oulijun@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_srq.c | 310 ++++++++++++++++++-------------
 1 file changed, 183 insertions(+), 127 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_srq.c b/drivers/infiniband/hw/hns/hns_roce_srq.c
index 38bb548..c011422 100644
--- a/drivers/infiniband/hw/hns/hns_roce_srq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_srq.c
@@ -175,6 +175,91 @@ static void hns_roce_srq_free(struct hns_roce_dev *hr_dev,
 	hns_roce_bitmap_free(&srq_table->bitmap, srq->srqn, BITMAP_NO_RR);
 }
 
+static int create_user_srq(struct hns_roce_srq *srq, struct ib_udata *udata,
+			   int srq_buf_size)
+{
+	struct hns_roce_dev *hr_dev = to_hr_dev(srq->ibsrq.device);
+	struct hns_roce_ib_create_srq  ucmd;
+	u32 page_shift;
+	u32 npages;
+	int ret;
+
+	if (ib_copy_from_udata(&ucmd, udata, sizeof(ucmd)))
+		return -EFAULT;
+
+	srq->umem = ib_umem_get(udata, ucmd.buf_addr, srq_buf_size, 0, 0);
+	if (IS_ERR(srq->umem))
+		return PTR_ERR(srq->umem);
+
+	if (hr_dev->caps.srqwqe_buf_pg_sz) {
+		npages = (ib_umem_page_count(srq->umem) +
+			 (1 << hr_dev->caps.srqwqe_buf_pg_sz) - 1) /
+			 (1 << hr_dev->caps.srqwqe_buf_pg_sz);
+		page_shift = PAGE_SHIFT + hr_dev->caps.srqwqe_buf_pg_sz;
+		ret = hns_roce_mtt_init(hr_dev, npages, page_shift, &srq->mtt);
+	} else
+		ret = hns_roce_mtt_init(hr_dev, ib_umem_page_count(srq->umem),
+					PAGE_SHIFT, &srq->mtt);
+	if (ret)
+		goto err_user_buf;
+
+	ret = hns_roce_ib_umem_write_mtt(hr_dev, &srq->mtt, srq->umem);
+	if (ret)
+		goto err_user_srq_mtt;
+
+	/* config index queue BA */
+	srq->idx_que.umem = ib_umem_get(udata, ucmd.que_addr,
+					srq->idx_que.buf_size, 0, 0);
+	if (IS_ERR(srq->idx_que.umem)) {
+		dev_err(hr_dev->dev, "ib_umem_get error for index queue\n");
+		ret = PTR_ERR(srq->idx_que.umem);
+		goto err_user_srq_mtt;
+	}
+
+	if (hr_dev->caps.idx_buf_pg_sz) {
+		npages = (ib_umem_page_count(srq->idx_que.umem) +
+			 (1 << hr_dev->caps.idx_buf_pg_sz) - 1) /
+			 (1 << hr_dev->caps.idx_buf_pg_sz);
+		page_shift = PAGE_SHIFT + hr_dev->caps.idx_buf_pg_sz;
+		ret = hns_roce_mtt_init(hr_dev, npages, page_shift,
+					&srq->idx_que.mtt);
+	} else {
+		ret = hns_roce_mtt_init(hr_dev,
+					ib_umem_page_count(srq->idx_que.umem),
+					PAGE_SHIFT,
+					&srq->idx_que.mtt);
+	}
+
+	if (ret) {
+		dev_err(hr_dev->dev, "hns_roce_mtt_init error for idx que\n");
+		goto err_user_idx_mtt;
+	}
+
+	ret = hns_roce_ib_umem_write_mtt(hr_dev, &srq->idx_que.mtt,
+					 srq->idx_que.umem);
+	if (ret) {
+		dev_err(hr_dev->dev,
+			"hns_roce_ib_umem_write_mtt error for idx que\n");
+		goto err_user_idx_buf;
+	}
+
+	return 0;
+
+err_user_idx_buf:
+	hns_roce_mtt_cleanup(hr_dev, &srq->idx_que.mtt);
+
+err_user_idx_mtt:
+	ib_umem_release(srq->idx_que.umem);
+
+err_user_srq_mtt:
+	hns_roce_mtt_cleanup(hr_dev, &srq->mtt);
+
+err_user_buf:
+	ib_umem_release(srq->umem);
+
+	return ret;
+}
+
 static int hns_roce_create_idx_que(struct ib_pd *pd, struct hns_roce_srq *srq,
 				   u32 page_shift)
 {
@@ -196,6 +281,93 @@ static int hns_roce_create_idx_que(struct ib_pd *pd, struct hns_roce_srq *srq,
 	return 0;
 }
 
+static int create_kernel_srq(struct hns_roce_srq *srq, int srq_buf_size)
+{
+	struct hns_roce_dev *hr_dev = to_hr_dev(srq->ibsrq.device);
+	u32 page_shift = PAGE_SHIFT + hr_dev->caps.srqwqe_buf_pg_sz;
+	int ret;
+
+	if (hns_roce_buf_alloc(hr_dev, srq_buf_size, (1 << page_shift) * 2,
+			       &srq->buf, page_shift))
+		return -ENOMEM;
+
+	srq->head = 0;
+	srq->tail = srq->max - 1;
+
+	ret = hns_roce_mtt_init(hr_dev, srq->buf.npages, srq->buf.page_shift,
+				&srq->mtt);
+	if (ret)
+		goto err_kernel_buf;
+
+	ret = hns_roce_buf_write_mtt(hr_dev, &srq->mtt, &srq->buf);
+	if (ret)
+		goto err_kernel_srq_mtt;
+
+	page_shift = PAGE_SHIFT + hr_dev->caps.idx_buf_pg_sz;
+	ret = hns_roce_create_idx_que(srq->ibsrq.pd, srq, page_shift);
+	if (ret) {
+		dev_err(hr_dev->dev, "Create idx queue fail(%d)!\n", ret);
+		goto err_kernel_srq_mtt;
+	}
+
+	/* Init mtt table for idx_que */
+	ret = hns_roce_mtt_init(hr_dev, srq->idx_que.idx_buf.npages,
+				srq->idx_que.idx_buf.page_shift,
+				&srq->idx_que.mtt);
+	if (ret)
+		goto err_kernel_create_idx;
+
+	/* Write buffer address into the mtt table */
+	ret = hns_roce_buf_write_mtt(hr_dev, &srq->idx_que.mtt,
+				     &srq->idx_que.idx_buf);
+	if (ret)
+		goto err_kernel_idx_buf;
+
+	srq->wrid = kvmalloc_array(srq->max, sizeof(u64), GFP_KERNEL);
+	if (!srq->wrid) {
+		ret = -ENOMEM;
+		goto err_kernel_idx_buf;
+	}
+
+	return 0;
+
+err_kernel_idx_buf:
+	hns_roce_mtt_cleanup(hr_dev, &srq->idx_que.mtt);
+
+err_kernel_create_idx:
+	hns_roce_buf_free(hr_dev, srq->idx_que.buf_size,
+			  &srq->idx_que.idx_buf);
+	kfree(srq->idx_que.bitmap);
+
+err_kernel_srq_mtt:
+	hns_roce_mtt_cleanup(hr_dev, &srq->mtt);
+
+err_kernel_buf:
+	hns_roce_buf_free(hr_dev, srq_buf_size, &srq->buf);
+
+	return ret;
+}
+
+static void destroy_user_srq(struct hns_roce_dev *hr_dev,
+			     struct hns_roce_srq *srq)
+{
+	hns_roce_mtt_cleanup(hr_dev, &srq->idx_que.mtt);
+	ib_umem_release(srq->idx_que.umem);
+	hns_roce_mtt_cleanup(hr_dev, &srq->mtt);
+	ib_umem_release(srq->umem);
+}
+
+static void destroy_kernel_srq(struct hns_roce_dev *hr_dev,
+			       struct hns_roce_srq *srq, int srq_buf_size)
+{
+	kvfree(srq->wrid);
+	hns_roce_mtt_cleanup(hr_dev, &srq->idx_que.mtt);
+	hns_roce_buf_free(hr_dev, srq->idx_que.buf_size, &srq->idx_que.idx_buf);
+	kfree(srq->idx_que.bitmap);
+	hns_roce_mtt_cleanup(hr_dev, &srq->mtt);
+	hns_roce_buf_free(hr_dev, srq_buf_size, &srq->buf);
+}
+
 int hns_roce_create_srq(struct ib_srq *ib_srq,
 			struct ib_srq_init_attr *srq_init_attr,
 			struct ib_udata *udata)
@@ -205,9 +377,7 @@ int hns_roce_create_srq(struct ib_srq *ib_srq,
 	struct hns_roce_srq *srq = to_hr_srq(ib_srq);
 	int srq_desc_size;
 	int srq_buf_size;
-	u32 page_shift;
 	int ret = 0;
-	u32 npages;
 	u32 cqn;
 
 	/* Check the actual SRQ wqe and SRQ sge num */
@@ -233,115 +403,16 @@ int hns_roce_create_srq(struct ib_srq *ib_srq,
 	srq->idx_que.mtt.mtt_type = MTT_TYPE_IDX;
 
 	if (udata) {
-		struct hns_roce_ib_create_srq  ucmd;
-
-		if (ib_copy_from_udata(&ucmd, udata, sizeof(ucmd)))
-			return -EFAULT;
-
-		srq->umem =
-			ib_umem_get(udata, ucmd.buf_addr, srq_buf_size, 0, 0);
-		if (IS_ERR(srq->umem))
-			return PTR_ERR(srq->umem);
-
-		if (hr_dev->caps.srqwqe_buf_pg_sz) {
-			npages = (ib_umem_page_count(srq->umem) +
-				  (1 << hr_dev->caps.srqwqe_buf_pg_sz) - 1) /
-				  (1 << hr_dev->caps.srqwqe_buf_pg_sz);
-			page_shift = PAGE_SHIFT + hr_dev->caps.srqwqe_buf_pg_sz;
-			ret = hns_roce_mtt_init(hr_dev, npages,
-						page_shift,
-						&srq->mtt);
-		} else
-			ret = hns_roce_mtt_init(hr_dev,
-						ib_umem_page_count(srq->umem),
-						PAGE_SHIFT, &srq->mtt);
-		if (ret)
-			goto err_buf;
-
-		ret = hns_roce_ib_umem_write_mtt(hr_dev, &srq->mtt, srq->umem);
-		if (ret)
-			goto err_srq_mtt;
-
-		/* config index queue BA */
-		srq->idx_que.umem = ib_umem_get(udata, ucmd.que_addr,
-						srq->idx_que.buf_size, 0, 0);
-		if (IS_ERR(srq->idx_que.umem)) {
-			dev_err(hr_dev->dev,
-				"ib_umem_get error for index queue\n");
-			ret = PTR_ERR(srq->idx_que.umem);
-			goto err_srq_mtt;
-		}
-
-		if (hr_dev->caps.idx_buf_pg_sz) {
-			npages = (ib_umem_page_count(srq->idx_que.umem) +
-				  (1 << hr_dev->caps.idx_buf_pg_sz) - 1) /
-				  (1 << hr_dev->caps.idx_buf_pg_sz);
-			page_shift = PAGE_SHIFT + hr_dev->caps.idx_buf_pg_sz;
-			ret = hns_roce_mtt_init(hr_dev, npages,
-						page_shift, &srq->idx_que.mtt);
-		} else {
-			ret = hns_roce_mtt_init(
-				hr_dev, ib_umem_page_count(srq->idx_que.umem),
-				PAGE_SHIFT, &srq->idx_que.mtt);
-		}
-
-		if (ret) {
-			dev_err(hr_dev->dev,
-				"hns_roce_mtt_init error for idx que\n");
-			goto err_idx_mtt;
-		}
-
-		ret = hns_roce_ib_umem_write_mtt(hr_dev, &srq->idx_que.mtt,
-						 srq->idx_que.umem);
+		ret = create_user_srq(srq, udata, srq_buf_size);
 		if (ret) {
-			dev_err(hr_dev->dev,
-			      "hns_roce_ib_umem_write_mtt error for idx que\n");
-			goto err_idx_buf;
+			dev_err(hr_dev->dev, "Create user srq failed\n");
+			goto err_srq;
 		}
 	} else {
-		page_shift = PAGE_SHIFT + hr_dev->caps.srqwqe_buf_pg_sz;
-		if (hns_roce_buf_alloc(hr_dev, srq_buf_size,
-				       (1 << page_shift) * 2, &srq->buf,
-				       page_shift))
-			return -ENOMEM;
-
-		srq->head = 0;
-		srq->tail = srq->max - 1;
-
-		ret = hns_roce_mtt_init(hr_dev, srq->buf.npages,
-					srq->buf.page_shift, &srq->mtt);
-		if (ret)
-			goto err_buf;
-
-		ret = hns_roce_buf_write_mtt(hr_dev, &srq->mtt, &srq->buf);
-		if (ret)
-			goto err_srq_mtt;
-
-		page_shift = PAGE_SHIFT + hr_dev->caps.idx_buf_pg_sz;
-		ret = hns_roce_create_idx_que(ib_srq->pd, srq, page_shift);
+		ret = create_kernel_srq(srq, srq_buf_size);
 		if (ret) {
-			dev_err(hr_dev->dev, "Create idx queue fail(%d)!\n",
-				ret);
-			goto err_srq_mtt;
-		}
-
-		/* Init mtt table for idx_que */
-		ret = hns_roce_mtt_init(hr_dev, srq->idx_que.idx_buf.npages,
-					srq->idx_que.idx_buf.page_shift,
-					&srq->idx_que.mtt);
-		if (ret)
-			goto err_create_idx;
-
-		/* Write buffer address into the mtt table */
-		ret = hns_roce_buf_write_mtt(hr_dev, &srq->idx_que.mtt,
-					     &srq->idx_que.idx_buf);
-		if (ret)
-			goto err_idx_buf;
-
-		srq->wrid = kvmalloc_array(srq->max, sizeof(u64), GFP_KERNEL);
-		if (!srq->wrid) {
-			ret = -ENOMEM;
-			goto err_idx_buf;
+			dev_err(hr_dev->dev, "Create kernel srq failed\n");
+			goto err_srq;
 		}
 	}
 
@@ -373,27 +444,12 @@ int hns_roce_create_srq(struct ib_srq *ib_srq,
 	hns_roce_srq_free(hr_dev, srq);
 
 err_wrid:
-	kvfree(srq->wrid);
-
-err_idx_buf:
-	hns_roce_mtt_cleanup(hr_dev, &srq->idx_que.mtt);
-
-err_idx_mtt:
-	ib_umem_release(srq->idx_que.umem);
-
-err_create_idx:
-	hns_roce_buf_free(hr_dev, srq->idx_que.buf_size,
-			  &srq->idx_que.idx_buf);
-	bitmap_free(srq->idx_que.bitmap);
-
-err_srq_mtt:
-	hns_roce_mtt_cleanup(hr_dev, &srq->mtt);
-
-err_buf:
-	ib_umem_release(srq->umem);
-	if (!udata)
-		hns_roce_buf_free(hr_dev, srq_buf_size, &srq->buf);
+	if (udata)
+		destroy_user_srq(hr_dev, srq);
+	else
+		destroy_kernel_srq(hr_dev, srq, srq_buf_size);
 
+err_srq:
 	return ret;
 }
 
-- 
1.9.1

