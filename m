Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1D4E1A6606
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2020 13:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbgDML6Y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Apr 2020 07:58:24 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:53158 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729303AbgDML6V (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 13 Apr 2020 07:58:21 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7BF0B187178FE4FF3C79;
        Mon, 13 Apr 2020 19:58:17 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Mon, 13 Apr 2020 19:58:11 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 5/6] RDMA/hns: Support 0 hop addressing for SRQ buffer
Date:   Mon, 13 Apr 2020 19:58:10 +0800
Message-ID: <1586779091-51410-6-git-send-email-liweihang@huawei.com>
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

Add the zero hop addressing support by using mtr interface for SRQ buffer,
so the hns driver can support addressing hopnum between 0 to 3 for SRQ.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h |  12 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  20 +-
 drivers/infiniband/hw/hns/hns_roce_srq.c    | 365 +++++++++++-----------------
 3 files changed, 153 insertions(+), 244 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 5df4ee3..39af736 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -528,11 +528,8 @@ struct hns_roce_cq {
 };
 
 struct hns_roce_idx_que {
-	struct hns_roce_buf		idx_buf;
+	struct hns_roce_mtr		mtr;
 	int				entry_sz;
-	u32				buf_size;
-	struct ib_umem			*umem;
-	struct hns_roce_mtt		mtt;
 	unsigned long			*bitmap;
 };
 
@@ -547,12 +544,9 @@ struct hns_roce_srq {
 	atomic_t		refcount;
 	struct completion	free;
 
-	struct hns_roce_buf	buf;
+	struct hns_roce_mtr	buf_mtr;
+
 	u64		       *wrid;
-	struct ib_umem	       *umem;
-	u32			buf_size;
-	int			page_shift;
-	struct hns_roce_mtt	mtt;
 	struct hns_roce_idx_que idx_que;
 	spinlock_t		lock;
 	int			head;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 42bca0a..42be8a2 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -2699,7 +2699,7 @@ static struct hns_roce_v2_cqe *next_cqe_sw_v2(struct hns_roce_cq *hr_cq)
 
 static void *get_srq_wqe(struct hns_roce_srq *srq, int n)
 {
-	return hns_roce_buf_offset(&srq->buf, n << srq->wqe_shift);
+	return hns_roce_buf_offset(srq->buf_mtr.kmem, n << srq->wqe_shift);
 }
 
 static void hns_roce_free_srq_wqe(struct hns_roce_srq *srq, int wqe_index)
@@ -5699,11 +5699,11 @@ static void hns_roce_v2_write_srqc(struct hns_roce_dev *hr_dev,
 		       dma_handle_idx >> 35);
 
 	srq_context->idx_cur_blk_addr =
-		cpu_to_le32(mtts_idx[0] >> PAGE_ADDR_SHIFT);
+		cpu_to_le32(to_hr_hw_page_addr(mtts_idx[0]));
 	roce_set_field(srq_context->byte_44_idxbufpgsz_addr,
 		       SRQC_BYTE_44_SRQ_IDX_CUR_BLK_ADDR_M,
 		       SRQC_BYTE_44_SRQ_IDX_CUR_BLK_ADDR_S,
-		       mtts_idx[0] >> (32 + PAGE_ADDR_SHIFT));
+		       upper_32_bits(to_hr_hw_page_addr(mtts_idx[0])));
 	roce_set_field(srq_context->byte_44_idxbufpgsz_addr,
 		       SRQC_BYTE_44_SRQ_IDX_HOP_NUM_M,
 		       SRQC_BYTE_44_SRQ_IDX_HOP_NUM_S,
@@ -5713,29 +5713,29 @@ static void hns_roce_v2_write_srqc(struct hns_roce_dev *hr_dev,
 	roce_set_field(srq_context->byte_44_idxbufpgsz_addr,
 		       SRQC_BYTE_44_SRQ_IDX_BA_PG_SZ_M,
 		       SRQC_BYTE_44_SRQ_IDX_BA_PG_SZ_S,
-		       hr_dev->caps.idx_ba_pg_sz + PG_SHIFT_OFFSET);
+		       to_hr_hw_page_shift(srq->idx_que.mtr.hem_cfg.ba_pg_shift));
 	roce_set_field(srq_context->byte_44_idxbufpgsz_addr,
 		       SRQC_BYTE_44_SRQ_IDX_BUF_PG_SZ_M,
 		       SRQC_BYTE_44_SRQ_IDX_BUF_PG_SZ_S,
-		       hr_dev->caps.idx_buf_pg_sz + PG_SHIFT_OFFSET);
+		       to_hr_hw_page_shift(srq->idx_que.mtr.hem_cfg.buf_pg_shift));
 
 	srq_context->idx_nxt_blk_addr =
-		cpu_to_le32(mtts_idx[1] >> PAGE_ADDR_SHIFT);
+		cpu_to_le32(to_hr_hw_page_addr(mtts_idx[1]));
 	roce_set_field(srq_context->rsv_idxnxtblkaddr,
 		       SRQC_BYTE_52_SRQ_IDX_NXT_BLK_ADDR_M,
 		       SRQC_BYTE_52_SRQ_IDX_NXT_BLK_ADDR_S,
-		       mtts_idx[1] >> (32 + PAGE_ADDR_SHIFT));
+		       upper_32_bits(to_hr_hw_page_addr(mtts_idx[1])));
 	roce_set_field(srq_context->byte_56_xrc_cqn,
 		       SRQC_BYTE_56_SRQ_XRC_CQN_M, SRQC_BYTE_56_SRQ_XRC_CQN_S,
 		       cqn);
 	roce_set_field(srq_context->byte_56_xrc_cqn,
 		       SRQC_BYTE_56_SRQ_WQE_BA_PG_SZ_M,
 		       SRQC_BYTE_56_SRQ_WQE_BA_PG_SZ_S,
-		       hr_dev->caps.srqwqe_ba_pg_sz + PG_SHIFT_OFFSET);
+		       to_hr_hw_page_shift(srq->buf_mtr.hem_cfg.ba_pg_shift));
 	roce_set_field(srq_context->byte_56_xrc_cqn,
 		       SRQC_BYTE_56_SRQ_WQE_BUF_PG_SZ_M,
 		       SRQC_BYTE_56_SRQ_WQE_BUF_PG_SZ_S,
-		       hr_dev->caps.srqwqe_buf_pg_sz + PG_SHIFT_OFFSET);
+		       to_hr_hw_page_shift(srq->buf_mtr.hem_cfg.buf_pg_shift));
 
 	roce_set_bit(srq_context->db_record_addr_record_en,
 		     SRQC_BYTE_60_SRQ_RECORD_EN_S, 0);
@@ -5847,7 +5847,7 @@ static void fill_idx_queue(struct hns_roce_idx_que *idx_que,
 {
 	unsigned int *addr;
 
-	addr = (unsigned int *)hns_roce_buf_offset(&idx_que->idx_buf,
+	addr = (unsigned int *)hns_roce_buf_offset(idx_que->mtr.kmem,
 						   cur_idx * idx_que->entry_sz);
 	*addr = wqe_idx;
 }
diff --git a/drivers/infiniband/hw/hns/hns_roce_srq.c b/drivers/infiniband/hw/hns/hns_roce_srq.c
index 9851d76..e413a97 100644
--- a/drivers/infiniband/hw/hns/hns_roce_srq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_srq.c
@@ -77,56 +77,56 @@ static int hns_roce_hw_destroy_srq(struct hns_roce_dev *dev,
 				 HNS_ROCE_CMD_TIMEOUT_MSECS);
 }
 
-static int hns_roce_srq_alloc(struct hns_roce_dev *hr_dev, u32 pdn, u32 cqn,
-			      u16 xrcd, struct hns_roce_mtt *hr_mtt,
-			      u64 db_rec_addr, struct hns_roce_srq *srq)
+static int alloc_srqc(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq,
+		      u32 pdn, u32 cqn, u16 xrcd, u64 db_rec_addr)
 {
 	struct hns_roce_srq_table *srq_table = &hr_dev->srq_table;
+	struct ib_device *ibdev = &hr_dev->ib_dev;
 	struct hns_roce_cmd_mailbox *mailbox;
-	dma_addr_t dma_handle_wqe;
-	dma_addr_t dma_handle_idx;
-	u64 *mtts_wqe;
-	u64 *mtts_idx;
+	u64 mtts_wqe[MTT_MIN_COUNT] = { 0 };
+	u64 mtts_idx[MTT_MIN_COUNT] = { 0 };
+	dma_addr_t dma_handle_wqe = 0;
+	dma_addr_t dma_handle_idx = 0;
 	int ret;
 
 	/* Get the physical address of srq buf */
-	mtts_wqe = hns_roce_table_find(hr_dev,
-				       &hr_dev->mr_table.mtt_srqwqe_table,
-				       srq->mtt.first_seg,
-				       &dma_handle_wqe);
-	if (!mtts_wqe) {
-		dev_err(hr_dev->dev, "Failed to find mtt for srq buf.\n");
-		return -EINVAL;
+	ret = hns_roce_mtr_find(hr_dev, &srq->buf_mtr, 0, mtts_wqe,
+				ARRAY_SIZE(mtts_wqe), &dma_handle_wqe);
+	if (ret < 1) {
+		ibdev_err(ibdev, "Failed to find mtr for SRQ WQE\n");
+		return -ENOBUFS;
 	}
 
 	/* Get physical address of idx que buf */
-	mtts_idx = hns_roce_table_find(hr_dev, &hr_dev->mr_table.mtt_idx_table,
-				       srq->idx_que.mtt.first_seg,
-				       &dma_handle_idx);
-	if (!mtts_idx) {
-		dev_err(hr_dev->dev,
-			"Failed to find mtt for srq idx queue buf.\n");
-		return -EINVAL;
+	ret = hns_roce_mtr_find(hr_dev, &srq->idx_que.mtr, 0, mtts_idx,
+				ARRAY_SIZE(mtts_idx), &dma_handle_idx);
+	if (ret < 1) {
+		ibdev_err(ibdev, "Failed to find mtr for SRQ idx\n");
+		return -ENOBUFS;
 	}
 
 	ret = hns_roce_bitmap_alloc(&srq_table->bitmap, &srq->srqn);
 	if (ret) {
-		dev_err(hr_dev->dev,
-			"Failed to alloc a bit from srq bitmap.\n");
+		ibdev_err(ibdev, "Failed to alloc SRQ number, err %d\n", ret);
 		return -ENOMEM;
 	}
 
 	ret = hns_roce_table_get(hr_dev, &srq_table->table, srq->srqn);
-	if (ret)
+	if (ret) {
+		ibdev_err(ibdev, "Failed to get SRQC table, err %d\n", ret);
 		goto err_out;
+	}
 
 	ret = xa_err(xa_store(&srq_table->xa, srq->srqn, srq, GFP_KERNEL));
-	if (ret)
+	if (ret) {
+		ibdev_err(ibdev, "Failed to store SRQC, err %d\n", ret);
 		goto err_put;
+	}
 
 	mailbox = hns_roce_alloc_cmd_mailbox(hr_dev);
-	if (IS_ERR(mailbox)) {
-		ret = PTR_ERR(mailbox);
+	if (IS_ERR_OR_NULL(mailbox)) {
+		ret = -ENOMEM;
+		ibdev_err(ibdev, "Failed to alloc mailbox for SRQC\n");
 		goto err_xa;
 	}
 
@@ -136,8 +136,10 @@ static int hns_roce_srq_alloc(struct hns_roce_dev *hr_dev, u32 pdn, u32 cqn,
 
 	ret = hns_roce_hw_create_srq(hr_dev, mailbox, srq->srqn);
 	hns_roce_free_cmd_mailbox(hr_dev, mailbox);
-	if (ret)
+	if (ret) {
+		ibdev_err(ibdev, "Failed to config SRQC, err %d\n", ret);
 		goto err_xa;
+	}
 
 	atomic_set(&srq->refcount, 1);
 	init_completion(&srq->free);
@@ -154,8 +156,7 @@ static int hns_roce_srq_alloc(struct hns_roce_dev *hr_dev, u32 pdn, u32 cqn,
 	return ret;
 }
 
-static void hns_roce_srq_free(struct hns_roce_dev *hr_dev,
-			      struct hns_roce_srq *srq)
+static void free_srqc(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq)
 {
 	struct hns_roce_srq_table *srq_table = &hr_dev->srq_table;
 	int ret;
@@ -175,185 +176,104 @@ static void hns_roce_srq_free(struct hns_roce_dev *hr_dev,
 	hns_roce_bitmap_free(&srq_table->bitmap, srq->srqn, BITMAP_NO_RR);
 }
 
-static int create_user_srq(struct hns_roce_srq *srq, struct ib_udata *udata,
-			   int srq_buf_size)
+static int alloc_srq_buf(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq,
+			 struct ib_udata *udata, unsigned long addr)
 {
-	struct hns_roce_dev *hr_dev = to_hr_dev(srq->ibsrq.device);
-	struct hns_roce_ib_create_srq  ucmd;
-	int page_shift;
-	int page_count;
-	int ret;
-
-	if (ib_copy_from_udata(&ucmd, udata, sizeof(ucmd)))
-		return -EFAULT;
+	struct ib_device *ibdev = &hr_dev->ib_dev;
+	struct hns_roce_buf_attr buf_attr = {};
+	int sge_size;
+	int err;
 
-	srq->umem =
-		ib_umem_get(srq->ibsrq.device, ucmd.buf_addr, srq_buf_size, 0);
-	if (IS_ERR(srq->umem))
-		return PTR_ERR(srq->umem);
+	sge_size = roundup_pow_of_two(max(HNS_ROCE_SGE_SIZE,
+					  HNS_ROCE_SGE_SIZE * srq->max_gs));
 
-	page_count = (ib_umem_page_count(srq->umem) +
-		      (1 << hr_dev->caps.srqwqe_buf_pg_sz) - 1) /
-		      (1 << hr_dev->caps.srqwqe_buf_pg_sz);
-	page_shift = PAGE_SHIFT + hr_dev->caps.srqwqe_buf_pg_sz;
-	ret = hns_roce_mtt_init(hr_dev, page_count, page_shift,
-				&srq->mtt);
-	if (ret)
-		goto err_user_buf;
+	srq->wqe_shift = ilog2(sge_size);
 
-	ret = hns_roce_ib_umem_write_mtt(hr_dev, &srq->mtt, srq->umem);
-	if (ret)
-		goto err_user_srq_mtt;
-
-	/* config index queue BA */
-	srq->idx_que.umem = ib_umem_get(srq->ibsrq.device, ucmd.que_addr,
-					srq->idx_que.buf_size, 0);
-	if (IS_ERR(srq->idx_que.umem)) {
-		dev_err(hr_dev->dev, "ib_umem_get error for index queue\n");
-		ret = PTR_ERR(srq->idx_que.umem);
-		goto err_user_srq_mtt;
-	}
+	buf_attr.page_shift = hr_dev->caps.srqwqe_buf_pg_sz + PAGE_ADDR_SHIFT;
+	buf_attr.region[0].size = srq->wqe_cnt * sge_size;
+	buf_attr.region[0].hopnum = hr_dev->caps.srqwqe_hop_num;
+	buf_attr.region_count = 1;
+	buf_attr.fixed_page = true;
 
-	page_count = DIV_ROUND_UP(ib_umem_page_count(srq->idx_que.umem),
-				  1 << hr_dev->caps.idx_buf_pg_sz);
-	page_shift = PAGE_SHIFT + hr_dev->caps.idx_buf_pg_sz;
-	ret = hns_roce_mtt_init(hr_dev, page_count, page_shift,
-				&srq->idx_que.mtt);
-	if (ret) {
-		dev_err(hr_dev->dev, "hns_roce_mtt_init error for idx que\n");
-		goto err_user_idx_mtt;
-	}
-
-	ret = hns_roce_ib_umem_write_mtt(hr_dev, &srq->idx_que.mtt,
-					 srq->idx_que.umem);
-	if (ret) {
-		dev_err(hr_dev->dev,
-			"hns_roce_ib_umem_write_mtt error for idx que\n");
-		goto err_user_idx_buf;
-	}
+	err = hns_roce_mtr_create(hr_dev, &srq->buf_mtr, &buf_attr,
+				  hr_dev->caps.srqwqe_ba_pg_sz +
+				  PAGE_ADDR_SHIFT, udata, addr);
+	if (err)
+		ibdev_err(ibdev, "Failed to alloc SRQ buf mtr, err %d\n", err);
 
-	return 0;
-
-err_user_idx_buf:
-	hns_roce_mtt_cleanup(hr_dev, &srq->idx_que.mtt);
-
-err_user_idx_mtt:
-	ib_umem_release(srq->idx_que.umem);
-
-err_user_srq_mtt:
-	hns_roce_mtt_cleanup(hr_dev, &srq->mtt);
-
-err_user_buf:
-	ib_umem_release(srq->umem);
+	return err;
+}
 
-	return ret;
+static void free_srq_buf(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq)
+{
+	hns_roce_mtr_destroy(hr_dev, &srq->buf_mtr);
 }
 
-static int hns_roce_create_idx_que(struct ib_pd *pd, struct hns_roce_srq *srq,
-				   u32 page_shift)
+static int alloc_srq_idx(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq,
+			 struct ib_udata *udata, unsigned long addr)
 {
-	struct hns_roce_dev *hr_dev = to_hr_dev(pd->device);
 	struct hns_roce_idx_que *idx_que = &srq->idx_que;
+	struct ib_device *ibdev = &hr_dev->ib_dev;
+	struct hns_roce_buf_attr buf_attr = {};
+	int err;
 
-	idx_que->bitmap = bitmap_zalloc(srq->wqe_cnt, GFP_KERNEL);
-	if (!idx_que->bitmap)
-		return -ENOMEM;
+	srq->idx_que.entry_sz = HNS_ROCE_IDX_QUE_ENTRY_SZ;
+
+	buf_attr.page_shift = hr_dev->caps.idx_buf_pg_sz + PAGE_ADDR_SHIFT;
+	buf_attr.region[0].size = srq->wqe_cnt * HNS_ROCE_IDX_QUE_ENTRY_SZ;
+	buf_attr.region[0].hopnum = hr_dev->caps.idx_hop_num;
+	buf_attr.region_count = 1;
+	buf_attr.fixed_page = true;
+
+	err = hns_roce_mtr_create(hr_dev, &idx_que->mtr, &buf_attr,
+				  hr_dev->caps.idx_ba_pg_sz + PAGE_ADDR_SHIFT,
+				  udata, addr);
+	if (err) {
+		ibdev_err(ibdev, "Failed to alloc SRQ idx mtr, err %d\n", err);
+		return err;
+	}
 
-	idx_que->buf_size = srq->idx_que.buf_size;
+	if (!udata) {
+		idx_que->bitmap = bitmap_zalloc(srq->wqe_cnt, GFP_KERNEL);
+		if (!idx_que->bitmap) {
+			ibdev_err(ibdev, "Failed to alloc SRQ idx bitmap\n");
+			err = -ENOMEM;
+			goto err_idx_mtr;
+		}
 
-	if (hns_roce_buf_alloc(hr_dev, idx_que->buf_size, (1 << page_shift) * 2,
-			       &idx_que->idx_buf, page_shift)) {
-		bitmap_free(idx_que->bitmap);
-		return -ENOMEM;
 	}
 
 	return 0;
+err_idx_mtr:
+	hns_roce_mtr_destroy(hr_dev, &idx_que->mtr);
+
+	return err;
 }
 
-static int create_kernel_srq(struct hns_roce_srq *srq, int srq_buf_size)
+static void free_srq_idx(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq)
 {
-	struct hns_roce_dev *hr_dev = to_hr_dev(srq->ibsrq.device);
-	u32 page_shift = PAGE_SHIFT + hr_dev->caps.srqwqe_buf_pg_sz;
-	int ret;
+	struct hns_roce_idx_que *idx_que = &srq->idx_que;
 
-	if (hns_roce_buf_alloc(hr_dev, srq_buf_size, (1 << page_shift) * 2,
-			       &srq->buf, page_shift))
-		return -ENOMEM;
+	bitmap_free(idx_que->bitmap);
+	idx_que->bitmap = NULL;
+	hns_roce_mtr_destroy(hr_dev, &idx_que->mtr);
+}
 
+static int alloc_srq_wrid(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq)
+{
 	srq->head = 0;
 	srq->tail = srq->wqe_cnt - 1;
-
-	ret = hns_roce_mtt_init(hr_dev, srq->buf.npages, srq->buf.page_shift,
-				&srq->mtt);
-	if (ret)
-		goto err_kernel_buf;
-
-	ret = hns_roce_buf_write_mtt(hr_dev, &srq->mtt, &srq->buf);
-	if (ret)
-		goto err_kernel_srq_mtt;
-
-	page_shift = PAGE_SHIFT + hr_dev->caps.idx_buf_pg_sz;
-	ret = hns_roce_create_idx_que(srq->ibsrq.pd, srq, page_shift);
-	if (ret) {
-		dev_err(hr_dev->dev, "Create idx queue fail(%d)!\n", ret);
-		goto err_kernel_srq_mtt;
-	}
-
-	/* Init mtt table for idx_que */
-	ret = hns_roce_mtt_init(hr_dev, srq->idx_que.idx_buf.npages,
-				srq->idx_que.idx_buf.page_shift,
-				&srq->idx_que.mtt);
-	if (ret)
-		goto err_kernel_create_idx;
-
-	/* Write buffer address into the mtt table */
-	ret = hns_roce_buf_write_mtt(hr_dev, &srq->idx_que.mtt,
-				     &srq->idx_que.idx_buf);
-	if (ret)
-		goto err_kernel_idx_buf;
-
 	srq->wrid = kvmalloc_array(srq->wqe_cnt, sizeof(u64), GFP_KERNEL);
-	if (!srq->wrid) {
-		ret = -ENOMEM;
-		goto err_kernel_idx_buf;
-	}
+	if (!srq->wrid)
+		return -ENOMEM;
 
 	return 0;
-
-err_kernel_idx_buf:
-	hns_roce_mtt_cleanup(hr_dev, &srq->idx_que.mtt);
-
-err_kernel_create_idx:
-	hns_roce_buf_free(hr_dev, &srq->idx_que.idx_buf);
-	kfree(srq->idx_que.bitmap);
-
-err_kernel_srq_mtt:
-	hns_roce_mtt_cleanup(hr_dev, &srq->mtt);
-
-err_kernel_buf:
-	hns_roce_buf_free(hr_dev, &srq->buf);
-
-	return ret;
-}
-
-static void destroy_user_srq(struct hns_roce_dev *hr_dev,
-			     struct hns_roce_srq *srq)
-{
-	hns_roce_mtt_cleanup(hr_dev, &srq->idx_que.mtt);
-	ib_umem_release(srq->idx_que.umem);
-	hns_roce_mtt_cleanup(hr_dev, &srq->mtt);
-	ib_umem_release(srq->umem);
 }
 
-static void destroy_kernel_srq(struct hns_roce_dev *hr_dev,
-			       struct hns_roce_srq *srq)
+static void free_srq_wrid(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq)
 {
-	kvfree(srq->wrid);
-	hns_roce_mtt_cleanup(hr_dev, &srq->idx_que.mtt);
-	hns_roce_buf_free(hr_dev, &srq->idx_que.idx_buf);
-	kfree(srq->idx_que.bitmap);
-	hns_roce_mtt_cleanup(hr_dev, &srq->mtt);
-	hns_roce_buf_free(hr_dev, &srq->buf);
+	kfree(srq->wrid);
+	srq->wrid = NULL;
 }
 
 int hns_roce_create_srq(struct ib_srq *ib_srq,
@@ -363,8 +283,8 @@ int hns_roce_create_srq(struct ib_srq *ib_srq,
 	struct hns_roce_dev *hr_dev = to_hr_dev(ib_srq->device);
 	struct hns_roce_ib_create_srq_resp resp = {};
 	struct hns_roce_srq *srq = to_hr_srq(ib_srq);
-	int srq_desc_size;
-	int srq_buf_size;
+	struct ib_device *ibdev = &hr_dev->ib_dev;
+	struct hns_roce_ib_create_srq ucmd = {};
 	int ret = 0;
 	u32 cqn;
 
@@ -379,41 +299,45 @@ int hns_roce_create_srq(struct ib_srq *ib_srq,
 	srq->wqe_cnt = roundup_pow_of_two(init_attr->attr.max_wr + 1);
 	srq->max_gs = init_attr->attr.max_sge;
 
-	srq_desc_size = roundup_pow_of_two(max(HNS_ROCE_SGE_SIZE,
-					HNS_ROCE_SGE_SIZE * srq->max_gs));
-
-	srq->wqe_shift = ilog2(srq_desc_size);
-
-	srq_buf_size = srq->wqe_cnt * srq_desc_size;
-
-	srq->idx_que.entry_sz = HNS_ROCE_IDX_QUE_ENTRY_SZ;
-	srq->idx_que.buf_size = srq->wqe_cnt * srq->idx_que.entry_sz;
-	srq->mtt.mtt_type = MTT_TYPE_SRQWQE;
-	srq->idx_que.mtt.mtt_type = MTT_TYPE_IDX;
-
 	if (udata) {
-		ret = create_user_srq(srq, udata, srq_buf_size);
+		ret = ib_copy_from_udata(&ucmd, udata, sizeof(ucmd));
 		if (ret) {
-			dev_err(hr_dev->dev, "Create user srq failed\n");
-			goto err_srq;
+			ibdev_err(ibdev, "Failed to copy SRQ udata, err %d\n",
+				  ret);
+			return ret;
 		}
-	} else {
-		ret = create_kernel_srq(srq, srq_buf_size);
+	}
+
+	ret = alloc_srq_buf(hr_dev, srq, udata, ucmd.buf_addr);
+	if (ret) {
+		ibdev_err(ibdev, "Failed to alloc SRQ buffer, err %d\n", ret);
+		return ret;
+	}
+
+	ret = alloc_srq_idx(hr_dev, srq, udata, ucmd.que_addr);
+	if (ret) {
+		ibdev_err(ibdev, "Failed to alloc SRQ idx, err %d\n", ret);
+		goto err_buf_alloc;
+	}
+
+	if (!udata) {
+		ret = alloc_srq_wrid(hr_dev, srq);
 		if (ret) {
-			dev_err(hr_dev->dev, "Create kernel srq failed\n");
-			goto err_srq;
+			ibdev_err(ibdev, "Failed to alloc SRQ wrid, err %d\n",
+				  ret);
+			goto err_idx_alloc;
 		}
 	}
 
 	cqn = ib_srq_has_cq(init_attr->srq_type) ?
 	      to_hr_cq(init_attr->ext.cq)->cqn : 0;
-
 	srq->db_reg_l = hr_dev->reg_base + SRQ_DB_REG;
 
-	ret = hns_roce_srq_alloc(hr_dev, to_hr_pd(ib_srq->pd)->pdn, cqn, 0,
-				 &srq->mtt, 0, srq);
-	if (ret)
-		goto err_wrid;
+	ret = alloc_srqc(hr_dev, srq, to_hr_pd(ib_srq->pd)->pdn, cqn, 0, 0);
+	if (ret) {
+		ibdev_err(ibdev, "Failed to alloc SRQ context, err %d\n", ret);
+		goto err_wrid_alloc;
+	}
 
 	srq->event = hns_roce_ib_srq_event;
 	resp.srqn = srq->srqn;
@@ -429,15 +353,13 @@ int hns_roce_create_srq(struct ib_srq *ib_srq,
 	return 0;
 
 err_srqc_alloc:
-	hns_roce_srq_free(hr_dev, srq);
-
-err_wrid:
-	if (udata)
-		destroy_user_srq(hr_dev, srq);
-	else
-		destroy_kernel_srq(hr_dev, srq);
-
-err_srq:
+	free_srqc(hr_dev, srq);
+err_wrid_alloc:
+	free_srq_wrid(hr_dev, srq);
+err_idx_alloc:
+	free_srq_idx(hr_dev, srq);
+err_buf_alloc:
+	free_srq_buf(hr_dev, srq);
 	return ret;
 }
 
@@ -446,17 +368,10 @@ void hns_roce_destroy_srq(struct ib_srq *ibsrq, struct ib_udata *udata)
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibsrq->device);
 	struct hns_roce_srq *srq = to_hr_srq(ibsrq);
 
-	hns_roce_srq_free(hr_dev, srq);
-	hns_roce_mtt_cleanup(hr_dev, &srq->mtt);
-
-	if (udata) {
-		hns_roce_mtt_cleanup(hr_dev, &srq->idx_que.mtt);
-	} else {
-		kvfree(srq->wrid);
-		hns_roce_buf_free(hr_dev, &srq->buf);
-	}
-	ib_umem_release(srq->idx_que.umem);
-	ib_umem_release(srq->umem);
+	free_srqc(hr_dev, srq);
+	free_srq_idx(hr_dev, srq);
+	free_srq_wrid(hr_dev, srq);
+	free_srq_buf(hr_dev, srq);
 }
 
 int hns_roce_init_srq_table(struct hns_roce_dev *hr_dev)
-- 
2.8.1

