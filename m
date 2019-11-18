Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EECEFFD21
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Nov 2019 03:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbfKRCi0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 17 Nov 2019 21:38:26 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:6690 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725905AbfKRCi0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 17 Nov 2019 21:38:26 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7C01FF108A19D5AABFA6;
        Mon, 18 Nov 2019 10:38:24 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Mon, 18 Nov 2019 10:38:14 +0800
From:   Weihang Li <liweihang@hisilicon.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH for-next 1/4] RDMA/hns: Redefine interfaces used in creating cq
Date:   Mon, 18 Nov 2019 10:34:50 +0800
Message-ID: <1574044493-46984-2-git-send-email-liweihang@hisilicon.com>
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

Some interfaces defined with unnecessary input parameters, such
as "nent" and "vector". This patch redefined these interfaces to
make the code more readable and simple.

Signed-off-by: Yixian Liu <liuyixian@huawei.com>
Signed-off-by: Weihang Li <liweihang@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_cq.c     | 83 ++++++++++++++---------------
 drivers/infiniband/hw/hns/hns_roce_device.h |  6 +--
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c  |  9 ++--
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 10 ++--
 4 files changed, 53 insertions(+), 55 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_cq.c b/drivers/infiniband/hw/hns/hns_roce_cq.c
index cde2960..87d9b0f 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cq.c
@@ -82,9 +82,8 @@ static int hns_roce_hw_create_cq(struct hns_roce_dev *dev,
 				 HNS_ROCE_CMD_TIMEOUT_MSECS);
 }
 
-static int hns_roce_cq_alloc(struct hns_roce_dev *hr_dev, int nent,
-			     struct hns_roce_mtt *hr_mtt,
-			     struct hns_roce_cq *hr_cq, int vector)
+static int hns_roce_cq_alloc(struct hns_roce_dev *hr_dev,
+			     struct hns_roce_cq *hr_cq)
 {
 	struct hns_roce_cmd_mailbox *mailbox;
 	struct hns_roce_hem_table *mtt_table;
@@ -103,18 +102,13 @@ static int hns_roce_cq_alloc(struct hns_roce_dev *hr_dev, int nent,
 		mtt_table = &hr_dev->mr_table.mtt_table;
 
 	mtts = hns_roce_table_find(hr_dev, mtt_table,
-				   hr_mtt->first_seg, &dma_handle);
+				   hr_cq->hr_buf.hr_mtt.first_seg,
+				   &dma_handle);
 	if (!mtts) {
 		dev_err(dev, "Failed to find mtt for CQ buf.\n");
 		return -EINVAL;
 	}
 
-	if (vector >= hr_dev->caps.num_comp_vectors) {
-		dev_err(dev, "Invalid vector(0x%x) for CQ alloc.\n", vector);
-		return -EINVAL;
-	}
-	hr_cq->vector = vector;
-
 	ret = hns_roce_bitmap_alloc(&cq_table->bitmap, &hr_cq->cqn);
 	if (ret) {
 		dev_err(dev, "Num of CQ out of range.\n");
@@ -143,8 +137,7 @@ static int hns_roce_cq_alloc(struct hns_roce_dev *hr_dev, int nent,
 		goto err_xa;
 	}
 
-	hr_dev->hw->write_cqc(hr_dev, hr_cq, mailbox->buf, mtts, dma_handle,
-			      nent, vector);
+	hr_dev->hw->write_cqc(hr_dev, hr_cq, mailbox->buf, mtts, dma_handle);
 
 	/* Send mailbox to hw */
 	ret = hns_roce_hw_create_cq(hr_dev, mailbox, hr_cq->cqn);
@@ -210,15 +203,18 @@ void hns_roce_free_cq(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq)
 }
 
 static int hns_roce_ib_get_cq_umem(struct hns_roce_dev *hr_dev,
-				   struct ib_udata *udata,
-				   struct hns_roce_cq_buf *buf,
-				   struct ib_umem **umem, u64 buf_addr, int cqe)
+				   struct hns_roce_cq *hr_cq,
+				   struct hns_roce_ib_create_cq ucmd,
+				   struct ib_udata *udata)
 {
-	int ret;
+	struct hns_roce_cq_buf *buf = &hr_cq->hr_buf;
+	struct ib_umem **umem = &hr_cq->umem;
 	u32 page_shift;
 	u32 npages;
+	int ret;
 
-	*umem = ib_umem_get(udata, buf_addr, cqe * hr_dev->caps.cq_entry_sz,
+	*umem = ib_umem_get(udata, ucmd.buf_addr,
+			    hr_cq->cq_depth * hr_dev->caps.cq_entry_sz,
 			    IB_ACCESS_LOCAL_WRITE);
 	if (IS_ERR(*umem))
 		return PTR_ERR(*umem);
@@ -257,10 +253,12 @@ static int hns_roce_ib_get_cq_umem(struct hns_roce_dev *hr_dev,
 }
 
 static int hns_roce_ib_alloc_cq_buf(struct hns_roce_dev *hr_dev,
-				    struct hns_roce_cq_buf *buf, u32 nent)
+				    struct hns_roce_cq *hr_cq)
 {
-	int ret;
+	struct hns_roce_cq_buf *buf = &hr_cq->hr_buf;
 	u32 page_shift = PAGE_SHIFT + hr_dev->caps.cqe_buf_pg_sz;
+	u32 nent = hr_cq->cq_depth;
+	int ret;
 
 	ret = hns_roce_buf_alloc(hr_dev, nent * hr_dev->caps.cq_entry_sz,
 				 (1 << page_shift) * 2, &buf->hr_buf,
@@ -295,17 +293,16 @@ static int hns_roce_ib_alloc_cq_buf(struct hns_roce_dev *hr_dev,
 }
 
 static void hns_roce_ib_free_cq_buf(struct hns_roce_dev *hr_dev,
-				    struct hns_roce_cq_buf *buf, int cqe)
+				    struct hns_roce_cq *hr_cq)
 {
-	hns_roce_buf_free(hr_dev, (cqe + 1) * hr_dev->caps.cq_entry_sz,
-			  &buf->hr_buf);
+	hns_roce_buf_free(hr_dev, hr_cq->cq_depth * hr_dev->caps.cq_entry_sz,
+			  &hr_cq->hr_buf.hr_buf);
 }
 
 static int create_user_cq(struct hns_roce_dev *hr_dev,
 			  struct hns_roce_cq *hr_cq,
 			  struct ib_udata *udata,
-			  struct hns_roce_ib_create_cq_resp *resp,
-			  int cq_entries)
+			  struct hns_roce_ib_create_cq_resp *resp)
 {
 	struct hns_roce_ib_create_cq ucmd;
 	struct device *dev = hr_dev->dev;
@@ -319,9 +316,7 @@ static int create_user_cq(struct hns_roce_dev *hr_dev,
 	}
 
 	/* Get user space address, write it into mtt table */
-	ret = hns_roce_ib_get_cq_umem(hr_dev, udata, &hr_cq->hr_buf,
-				      &hr_cq->umem, ucmd.buf_addr,
-				      cq_entries);
+	ret = hns_roce_ib_get_cq_umem(hr_dev, hr_cq, ucmd, udata);
 	if (ret) {
 		dev_err(dev, "Failed to get_cq_umem.\n");
 		return ret;
@@ -349,7 +344,7 @@ static int create_user_cq(struct hns_roce_dev *hr_dev,
 }
 
 static int create_kernel_cq(struct hns_roce_dev *hr_dev,
-			    struct hns_roce_cq *hr_cq, int cq_entries)
+			    struct hns_roce_cq *hr_cq)
 {
 	struct device *dev = hr_dev->dev;
 	int ret;
@@ -365,7 +360,7 @@ static int create_kernel_cq(struct hns_roce_dev *hr_dev,
 	}
 
 	/* Init mtt table and write buff address to mtt table */
-	ret = hns_roce_ib_alloc_cq_buf(hr_dev, &hr_cq->hr_buf, cq_entries);
+	ret = hns_roce_ib_alloc_cq_buf(hr_dev, hr_cq);
 	if (ret) {
 		dev_err(dev, "Failed to alloc_cq_buf.\n");
 		goto err_db;
@@ -403,7 +398,7 @@ static void destroy_kernel_cq(struct hns_roce_dev *hr_dev,
 			      struct hns_roce_cq *hr_cq)
 {
 	hns_roce_mtt_cleanup(hr_dev, &hr_cq->hr_buf.hr_mtt);
-	hns_roce_ib_free_cq_buf(hr_dev, &hr_cq->hr_buf, hr_cq->ib_cq.cqe);
+	hns_roce_ib_free_cq_buf(hr_dev, hr_cq);
 
 	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RECORD_DB)
 		hns_roce_free_db(hr_dev, &hr_cq->db);
@@ -414,11 +409,11 @@ int hns_roce_ib_create_cq(struct ib_cq *ib_cq,
 			  struct ib_udata *udata)
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(ib_cq->device);
-	struct device *dev = hr_dev->dev;
 	struct hns_roce_ib_create_cq_resp resp = {};
 	struct hns_roce_cq *hr_cq = to_hr_cq(ib_cq);
+	struct device *dev = hr_dev->dev;
 	int vector = attr->comp_vector;
-	int cq_entries = attr->cqe;
+	u32 cq_entries = attr->cqe;
 	int ret;
 
 	if (cq_entries < 1 || cq_entries > hr_dev->caps.max_cqes) {
@@ -427,21 +422,27 @@ int hns_roce_ib_create_cq(struct ib_cq *ib_cq,
 		return -EINVAL;
 	}
 
-	if (hr_dev->caps.min_cqes)
-		cq_entries = max(cq_entries, hr_dev->caps.min_cqes);
+	if (vector >= hr_dev->caps.num_comp_vectors) {
+		dev_err(dev, "Create CQ failed, vector=%d, max=%d\n",
+			vector, hr_dev->caps.num_comp_vectors);
+		return -EINVAL;
+	}
 
-	cq_entries = roundup_pow_of_two((unsigned int)cq_entries);
-	hr_cq->ib_cq.cqe = cq_entries - 1;
+	cq_entries = max(cq_entries, hr_dev->caps.min_cqes);
+	cq_entries = roundup_pow_of_two(cq_entries);
+	hr_cq->ib_cq.cqe = cq_entries - 1; /* used as cqe index */
+	hr_cq->cq_depth = cq_entries;
+	hr_cq->vector = vector;
 	spin_lock_init(&hr_cq->lock);
 
 	if (udata) {
-		ret = create_user_cq(hr_dev, hr_cq, udata, &resp, cq_entries);
+		ret = create_user_cq(hr_dev, hr_cq, udata, &resp);
 		if (ret) {
 			dev_err(dev, "Create cq failed in user mode!\n");
 			goto err_cq;
 		}
 	} else {
-		ret = create_kernel_cq(hr_dev, hr_cq, cq_entries);
+		ret = create_kernel_cq(hr_dev, hr_cq);
 		if (ret) {
 			dev_err(dev, "Create cq failed in kernel mode!\n");
 			goto err_cq;
@@ -449,8 +450,7 @@ int hns_roce_ib_create_cq(struct ib_cq *ib_cq,
 	}
 
 	/* Allocate cq index, fill cq_context */
-	ret = hns_roce_cq_alloc(hr_dev, cq_entries, &hr_cq->hr_buf.hr_mtt,
-				hr_cq, vector);
+	ret = hns_roce_cq_alloc(hr_dev,	hr_cq);
 	if (ret) {
 		dev_err(dev, "Alloc CQ failed(%d).\n", ret);
 		goto err_dbmap;
@@ -468,7 +468,6 @@ int hns_roce_ib_create_cq(struct ib_cq *ib_cq,
 	/* Get created cq handler and carry out event */
 	hr_cq->comp = hns_roce_ib_cq_comp;
 	hr_cq->event = hns_roce_ib_cq_event;
-	hr_cq->cq_depth = cq_entries;
 
 	if (udata) {
 		resp.cqn = hr_cq->cqn;
@@ -515,7 +514,7 @@ void hns_roce_ib_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 					       &hr_cq->db);
 	} else {
 		/* Free the buff of stored cq */
-		hns_roce_ib_free_cq_buf(hr_dev, &hr_cq->hr_buf, ib_cq->cqe);
+		hns_roce_ib_free_cq_buf(hr_dev, hr_cq);
 		if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RECORD_DB)
 			hns_roce_free_db(hr_dev, &hr_cq->db);
 	}
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index a1b712e..8f628a7 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -812,8 +812,8 @@ struct hns_roce_caps {
 	int		max_qp_init_rdma;
 	int		max_qp_dest_rdma;
 	int		num_cqs;
-	int		max_cqes;
-	int		min_cqes;
+	u32		max_cqes;
+	u32		min_cqes;
 	u32		min_wqes;
 	int		reserved_cqs;
 	int		reserved_srqs;
@@ -944,7 +944,7 @@ struct hns_roce_hw {
 	int (*mw_write_mtpt)(void *mb_buf, struct hns_roce_mw *mw);
 	void (*write_cqc)(struct hns_roce_dev *hr_dev,
 			  struct hns_roce_cq *hr_cq, void *mb_buf, u64 *mtts,
-			  dma_addr_t dma_handle, int nent, u32 vector);
+			  dma_addr_t dma_handle);
 	int (*set_hem)(struct hns_roce_dev *hr_dev,
 		       struct hns_roce_hem_table *table, int obj, int step_idx);
 	int (*clear_hem)(struct hns_roce_dev *hr_dev,
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
index 89a4c3a..600d9f9 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -1990,7 +1990,7 @@ static void *get_sw_cqe(struct hns_roce_cq *hr_cq, int n)
 
 	/* Get cqe when Owner bit is Conversely with the MSB of cons_idx */
 	return (roce_get_bit(hr_cqe->cqe_byte_4, CQE_BYTE_4_OWNER_S) ^
-		!!(n & (hr_cq->ib_cq.cqe + 1))) ? hr_cqe : NULL;
+		!!(n & hr_cq->cq_depth)) ? hr_cqe : NULL;
 }
 
 static struct hns_roce_cqe *next_cqe_sw(struct hns_roce_cq *hr_cq)
@@ -2073,8 +2073,7 @@ static void hns_roce_v1_cq_clean(struct hns_roce_cq *hr_cq, u32 qpn,
 
 static void hns_roce_v1_write_cqc(struct hns_roce_dev *hr_dev,
 				  struct hns_roce_cq *hr_cq, void *mb_buf,
-				  u64 *mtts, dma_addr_t dma_handle, int nent,
-				  u32 vector)
+				  u64 *mtts, dma_addr_t dma_handle)
 {
 	struct hns_roce_cq_context *cq_context = NULL;
 	struct hns_roce_buf_list *tptr_buf;
@@ -2109,9 +2108,9 @@ static void hns_roce_v1_write_cqc(struct hns_roce_dev *hr_dev,
 	roce_set_field(cq_context->cqc_byte_12,
 		       CQ_CONTEXT_CQC_BYTE_12_CQ_CQE_SHIFT_M,
 		       CQ_CONTEXT_CQC_BYTE_12_CQ_CQE_SHIFT_S,
-		       ilog2((unsigned int)nent));
+		       ilog2(hr_cq->cq_depth));
 	roce_set_field(cq_context->cqc_byte_12, CQ_CONTEXT_CQC_BYTE_12_CEQN_M,
-		       CQ_CONTEXT_CQC_BYTE_12_CEQN_S, vector);
+		       CQ_CONTEXT_CQC_BYTE_12_CEQN_S, hr_cq->vector);
 
 	cq_context->cur_cqe_ba0_l = cpu_to_le32((u32)(mtts[0]));
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 907c951..77c9d7f 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -2457,7 +2457,7 @@ static void *get_sw_cqe_v2(struct hns_roce_cq *hr_cq, int n)
 
 	/* Get cqe when Owner bit is Conversely with the MSB of cons_idx */
 	return (roce_get_bit(cqe->byte_4, V2_CQE_BYTE_4_OWNER_S) ^
-		!!(n & (hr_cq->ib_cq.cqe + 1))) ? cqe : NULL;
+		!!(n & hr_cq->cq_depth)) ? cqe : NULL;
 }
 
 static struct hns_roce_v2_cqe *next_cqe_sw_v2(struct hns_roce_cq *hr_cq)
@@ -2550,8 +2550,7 @@ static void hns_roce_v2_cq_clean(struct hns_roce_cq *hr_cq, u32 qpn,
 
 static void hns_roce_v2_write_cqc(struct hns_roce_dev *hr_dev,
 				  struct hns_roce_cq *hr_cq, void *mb_buf,
-				  u64 *mtts, dma_addr_t dma_handle, int nent,
-				  u32 vector)
+				  u64 *mtts, dma_addr_t dma_handle)
 {
 	struct hns_roce_v2_cq_context *cq_context;
 
@@ -2563,9 +2562,10 @@ static void hns_roce_v2_write_cqc(struct hns_roce_dev *hr_dev,
 	roce_set_field(cq_context->byte_4_pg_ceqn, V2_CQC_BYTE_4_ARM_ST_M,
 		       V2_CQC_BYTE_4_ARM_ST_S, REG_NXT_CEQE);
 	roce_set_field(cq_context->byte_4_pg_ceqn, V2_CQC_BYTE_4_SHIFT_M,
-		       V2_CQC_BYTE_4_SHIFT_S, ilog2((unsigned int)nent));
+		       V2_CQC_BYTE_4_SHIFT_S,
+		       ilog2(hr_cq->cq_depth));
 	roce_set_field(cq_context->byte_4_pg_ceqn, V2_CQC_BYTE_4_CEQN_M,
-		       V2_CQC_BYTE_4_CEQN_S, vector);
+		       V2_CQC_BYTE_4_CEQN_S, hr_cq->vector);
 
 	roce_set_field(cq_context->byte_8_cqn, V2_CQC_BYTE_8_CQN_M,
 		       V2_CQC_BYTE_8_CQN_S, hr_cq->cqn);
-- 
2.8.1

