Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A90BAEFBAD
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Nov 2019 11:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388148AbfKEKno (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Nov 2019 05:43:44 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:5713 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388645AbfKEKno (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 5 Nov 2019 05:43:44 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 30B7375D47998DBA2482;
        Tue,  5 Nov 2019 18:43:39 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Tue, 5 Nov 2019 18:43:29 +0800
From:   Weihang Li <liweihang@hisilicon.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH for-next 4/9] {topost} RDMA/hns: Modify fields of struct hns_roce_srq
Date:   Tue, 5 Nov 2019 18:39:49 +0800
Message-ID: <1572950394-42910-5-git-send-email-liweihang@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1572950394-42910-1-git-send-email-liweihang@hisilicon.com>
References: <1572950394-42910-1-git-send-email-liweihang@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yixian Liu <liuyixian@huawei.com>

Use wqe_cnt instead of max which means the queue size of srq, and remove
wqe_ctr which is not used.

Signed-off-by: Yixian Liu <liuyixian@huawei.com>
Signed-off-by: Weihang Li <liweihang@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h |  5 ++---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 12 ++++++------
 drivers/infiniband/hw/hns/hns_roce_srq.c    | 26 +++++++++++++-------------
 3 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 3800fea..5b499a9 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -519,9 +519,8 @@ struct hns_roce_idx_que {
 
 struct hns_roce_srq {
 	struct ib_srq		ibsrq;
-	void (*event)(struct hns_roce_srq *srq, enum hns_roce_event event);
 	unsigned long		srqn;
-	int			max;
+	u32			wqe_cnt;
 	int			max_gs;
 	int			wqe_shift;
 	void __iomem		*db_reg_l;
@@ -537,8 +536,8 @@ struct hns_roce_srq {
 	spinlock_t		lock;
 	int			head;
 	int			tail;
-	u16			wqe_ctr;
 	struct mutex		mutex;
+	void (*event)(struct hns_roce_srq *srq, enum hns_roce_event event);
 };
 
 struct hns_roce_uar_table {
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 9b6b046..266d746d 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -6040,7 +6040,7 @@ static void hns_roce_v2_write_srqc(struct hns_roce_dev *hr_dev,
 		       hr_dev->caps.srqwqe_hop_num));
 	roce_set_field(srq_context->byte_4_srqn_srqst,
 		       SRQC_BYTE_4_SRQ_SHIFT_M, SRQC_BYTE_4_SRQ_SHIFT_S,
-		       ilog2(srq->max));
+		       ilog2(srq->wqe_cnt));
 
 	roce_set_field(srq_context->byte_4_srqn_srqst, SRQC_BYTE_4_SRQN_M,
 		       SRQC_BYTE_4_SRQN_S, srq->srqn);
@@ -6126,7 +6126,7 @@ static int hns_roce_v2_modify_srq(struct ib_srq *ibsrq,
 	int ret;
 
 	if (srq_attr_mask & IB_SRQ_LIMIT) {
-		if (srq_attr->srq_limit >= srq->max)
+		if (srq_attr->srq_limit >= srq->wqe_cnt)
 			return -EINVAL;
 
 		mailbox = hns_roce_alloc_cmd_mailbox(hr_dev);
@@ -6186,7 +6186,7 @@ static int hns_roce_v2_query_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr)
 				  SRQC_BYTE_8_SRQ_LIMIT_WL_S);
 
 	attr->srq_limit = limit_wl;
-	attr->max_wr    = srq->max - 1;
+	attr->max_wr    = srq->wqe_cnt - 1;
 	attr->max_sge   = srq->max_gs;
 
 	memcpy(srq_context, mailbox->buf, sizeof(*srq_context));
@@ -6239,7 +6239,7 @@ static int hns_roce_v2_post_srq_recv(struct ib_srq *ibsrq,
 
 	spin_lock_irqsave(&srq->lock, flags);
 
-	ind = srq->head & (srq->max - 1);
+	ind = srq->head & (srq->wqe_cnt - 1);
 
 	for (nreq = 0; wr; ++nreq, wr = wr->next) {
 		if (unlikely(wr->num_sge > srq->max_gs)) {
@@ -6254,7 +6254,7 @@ static int hns_roce_v2_post_srq_recv(struct ib_srq *ibsrq,
 			break;
 		}
 
-		wqe_idx = find_empty_entry(&srq->idx_que, srq->max);
+		wqe_idx = find_empty_entry(&srq->idx_que, srq->wqe_cnt);
 		if (wqe_idx < 0) {
 			ret = -ENOMEM;
 			*bad_wr = wr;
@@ -6278,7 +6278,7 @@ static int hns_roce_v2_post_srq_recv(struct ib_srq *ibsrq,
 		}
 
 		srq->wrid[wqe_idx] = wr->wr_id;
-		ind = (ind + 1) & (srq->max - 1);
+		ind = (ind + 1) & (srq->wqe_cnt - 1);
 	}
 
 	if (likely(nreq)) {
diff --git a/drivers/infiniband/hw/hns/hns_roce_srq.c b/drivers/infiniband/hw/hns/hns_roce_srq.c
index d96041d..6f9d1d2 100644
--- a/drivers/infiniband/hw/hns/hns_roce_srq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_srq.c
@@ -255,7 +255,7 @@ static int hns_roce_create_idx_que(struct ib_pd *pd, struct hns_roce_srq *srq,
 	struct hns_roce_dev *hr_dev = to_hr_dev(pd->device);
 	struct hns_roce_idx_que *idx_que = &srq->idx_que;
 
-	idx_que->bitmap = bitmap_zalloc(srq->max, GFP_KERNEL);
+	idx_que->bitmap = bitmap_zalloc(srq->wqe_cnt, GFP_KERNEL);
 	if (!idx_que->bitmap)
 		return -ENOMEM;
 
@@ -281,7 +281,7 @@ static int create_kernel_srq(struct hns_roce_srq *srq, int srq_buf_size)
 		return -ENOMEM;
 
 	srq->head = 0;
-	srq->tail = srq->max - 1;
+	srq->tail = srq->wqe_cnt - 1;
 
 	ret = hns_roce_mtt_init(hr_dev, srq->buf.npages, srq->buf.page_shift,
 				&srq->mtt);
@@ -312,7 +312,7 @@ static int create_kernel_srq(struct hns_roce_srq *srq, int srq_buf_size)
 	if (ret)
 		goto err_kernel_idx_buf;
 
-	srq->wrid = kvmalloc_array(srq->max, sizeof(u64), GFP_KERNEL);
+	srq->wrid = kvmalloc_array(srq->wqe_cnt, sizeof(u64), GFP_KERNEL);
 	if (!srq->wrid) {
 		ret = -ENOMEM;
 		goto err_kernel_idx_buf;
@@ -358,7 +358,7 @@ static void destroy_kernel_srq(struct hns_roce_dev *hr_dev,
 }
 
 int hns_roce_create_srq(struct ib_srq *ib_srq,
-			struct ib_srq_init_attr *srq_init_attr,
+			struct ib_srq_init_attr *init_attr,
 			struct ib_udata *udata)
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(ib_srq->device);
@@ -370,24 +370,24 @@ int hns_roce_create_srq(struct ib_srq *ib_srq,
 	u32 cqn;
 
 	/* Check the actual SRQ wqe and SRQ sge num */
-	if (srq_init_attr->attr.max_wr >= hr_dev->caps.max_srq_wrs ||
-	    srq_init_attr->attr.max_sge > hr_dev->caps.max_srq_sges)
+	if (init_attr->attr.max_wr >= hr_dev->caps.max_srq_wrs ||
+	    init_attr->attr.max_sge > hr_dev->caps.max_srq_sges)
 		return -EINVAL;
 
 	mutex_init(&srq->mutex);
 	spin_lock_init(&srq->lock);
 
-	srq->max = roundup_pow_of_two(srq_init_attr->attr.max_wr + 1);
-	srq->max_gs = srq_init_attr->attr.max_sge;
+	srq->wqe_cnt = roundup_pow_of_two(init_attr->attr.max_wr + 1);
+	srq->max_gs = init_attr->attr.max_sge;
 
 	srq_desc_size = max(16, 16 * srq->max_gs);
 
 	srq->wqe_shift = ilog2(srq_desc_size);
 
-	srq_buf_size = srq->max * srq_desc_size;
+	srq_buf_size = srq->wqe_cnt * srq_desc_size;
 
 	srq->idx_que.entry_sz = HNS_ROCE_IDX_QUE_ENTRY_SZ;
-	srq->idx_que.buf_size = srq->max * srq->idx_que.entry_sz;
+	srq->idx_que.buf_size = srq->wqe_cnt * srq->idx_que.entry_sz;
 	srq->mtt.mtt_type = MTT_TYPE_SRQWQE;
 	srq->idx_que.mtt.mtt_type = MTT_TYPE_IDX;
 
@@ -405,8 +405,8 @@ int hns_roce_create_srq(struct ib_srq *ib_srq,
 		}
 	}
 
-	cqn = ib_srq_has_cq(srq_init_attr->srq_type) ?
-	      to_hr_cq(srq_init_attr->ext.cq)->cqn : 0;
+	cqn = ib_srq_has_cq(init_attr->srq_type) ?
+	      to_hr_cq(init_attr->ext.cq)->cqn : 0;
 
 	srq->db_reg_l = hr_dev->reg_base + SRQ_DB_REG;
 
@@ -453,7 +453,7 @@ void hns_roce_destroy_srq(struct ib_srq *ibsrq, struct ib_udata *udata)
 		hns_roce_mtt_cleanup(hr_dev, &srq->idx_que.mtt);
 	} else {
 		kvfree(srq->wrid);
-		hns_roce_buf_free(hr_dev, srq->max << srq->wqe_shift,
+		hns_roce_buf_free(hr_dev, srq->wqe_cnt << srq->wqe_shift,
 				  &srq->buf);
 	}
 	ib_umem_release(srq->idx_que.umem);
-- 
2.8.1

