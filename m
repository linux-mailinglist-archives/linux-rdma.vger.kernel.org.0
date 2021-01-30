Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42F38309344
	for <lists+linux-rdma@lfdr.de>; Sat, 30 Jan 2021 10:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbhA3JX7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 30 Jan 2021 04:23:59 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:12363 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbhA3JXA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 30 Jan 2021 04:23:00 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DSSnF71Bgz7d97;
        Sat, 30 Jan 2021 16:59:13 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Sat, 30 Jan 2021 17:00:24 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: [PATCH for-next 10/12] RDMA/hns: Clear remaining unused sges when post_recv
Date:   Sat, 30 Jan 2021 16:58:08 +0800
Message-ID: <1611997090-48820-11-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1611997090-48820-1-git-send-email-liweihang@huawei.com>
References: <1611997090-48820-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

The HIP09 requires the driver to clear the unused data segments in wqe
buffer to make the hns ROCEE stop reading the remaining invalid sges for
RQ.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 99 ++++++++++++++----------------
 1 file changed, 47 insertions(+), 52 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 1f70422..7eba9b5 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -729,28 +729,42 @@ static int check_recv_valid(struct hns_roce_dev *hr_dev,
 	return 0;
 }
 
-static void fill_rq_wqe(struct hns_roce_qp *hr_qp, const struct ib_recv_wr *wr,
-			u32 wqe_idx)
+static void fill_recv_sge_to_wqe(const struct ib_recv_wr *wr, void *wqe,
+				 u32 max_sge, bool rsv)
 {
-	struct hns_roce_v2_wqe_data_seg *dseg;
-	struct hns_roce_rinl_sge *sge_list;
-	void *wqe = NULL;
-	int i;
+	struct hns_roce_v2_wqe_data_seg *dseg = wqe;
+	u32 i, cnt;
 
-	wqe = hns_roce_get_recv_wqe(hr_qp, wqe_idx);
-	dseg = (struct hns_roce_v2_wqe_data_seg *)wqe;
-	for (i = 0; i < wr->num_sge; i++) {
+	for (i = 0, cnt = 0; i < wr->num_sge; i++) {
+		/* Skip zero-length sge */
 		if (!wr->sg_list[i].length)
 			continue;
-		set_data_seg_v2(dseg, wr->sg_list + i);
-		dseg++;
+		set_data_seg_v2(dseg + cnt, wr->sg_list + i);
+		cnt++;
 	}
 
-	if (hr_qp->rq.rsv_sge) {
-		dseg->lkey = cpu_to_le32(HNS_ROCE_INVALID_LKEY);
-		dseg->addr = 0;
-		dseg->len = cpu_to_le32(HNS_ROCE_INVALID_SGE_LENGTH);
+	/* Fill a reserved sge to make hw stop reading remaining segments */
+	if (rsv) {
+		dseg[cnt].lkey = cpu_to_le32(HNS_ROCE_INVALID_LKEY);
+		dseg[cnt].addr = 0;
+		dseg[cnt].len = cpu_to_le32(HNS_ROCE_INVALID_SGE_LENGTH);
+	} else {
+		/* Clear remaining segments to make ROCEE ignore sges */
+		if (cnt < max_sge)
+			memset(dseg + cnt, 0,
+			       (max_sge - cnt) * HNS_ROCE_SGE_SIZE);
 	}
+}
+
+static void fill_rq_wqe(struct hns_roce_qp *hr_qp, const struct ib_recv_wr *wr,
+			u32 wqe_idx, u32 max_sge)
+{
+	struct hns_roce_rinl_sge *sge_list;
+	void *wqe = NULL;
+	u32 i;
+
+	wqe = hns_roce_get_recv_wqe(hr_qp, wqe_idx);
+	fill_recv_sge_to_wqe(wr, wqe, max_sge, hr_qp->rq.rsv_sge);
 
 	/* rq support inline data */
 	if (hr_qp->rq_inl_buf.wqe_cnt) {
@@ -801,8 +815,7 @@ static int hns_roce_v2_post_recv(struct ib_qp *ibqp,
 		}
 
 		wqe_idx = (hr_qp->rq.head + nreq) & (hr_qp->rq.wqe_cnt - 1);
-		fill_rq_wqe(hr_qp, wr, wqe_idx);
-
+		fill_rq_wqe(hr_qp, wr, wqe_idx, max_sge);
 		hr_qp->rq.wrid[wqe_idx] = wr->wr_id;
 	}
 
@@ -834,18 +847,18 @@ static int hns_roce_v2_post_recv(struct ib_qp *ibqp,
 	return ret;
 }
 
-static void *get_srq_wqe(struct hns_roce_srq *srq, int n)
+static void *get_srq_wqe_buf(struct hns_roce_srq *srq, u32 n)
 {
 	return hns_roce_buf_offset(srq->buf_mtr.kmem, n << srq->wqe_shift);
 }
 
-static void *get_idx_buf(struct hns_roce_idx_que *idx_que, unsigned int n)
+static void *get_idx_buf(struct hns_roce_idx_que *idx_que, u32 n)
 {
 	return hns_roce_buf_offset(idx_que->mtr.kmem,
 				   n << idx_que->entry_shift);
 }
 
-static void hns_roce_free_srq_wqe(struct hns_roce_srq *srq, int wqe_index)
+static void hns_roce_free_srq_wqe(struct hns_roce_srq *srq, u32 wqe_index)
 {
 	/* always called with interrupts disabled. */
 	spin_lock(&srq->lock);
@@ -856,7 +869,7 @@ static void hns_roce_free_srq_wqe(struct hns_roce_srq *srq, int wqe_index)
 	spin_unlock(&srq->lock);
 }
 
-int hns_roce_srqwq_overflow(struct hns_roce_srq *srq, int nreq)
+int hns_roce_srqwq_overflow(struct hns_roce_srq *srq, u32 nreq)
 {
 	struct hns_roce_idx_que *idx_que = &srq->idx_que;
 	unsigned int cur;
@@ -865,19 +878,18 @@ int hns_roce_srqwq_overflow(struct hns_roce_srq *srq, int nreq)
 	return cur + nreq >= srq->wqe_cnt;
 }
 
-static int find_empty_entry(struct hns_roce_idx_que *idx_que,
-			    unsigned long size)
+static int get_srq_wqe_idx(struct hns_roce_srq *srq, u32 *wqe_idx)
 {
-	int wqe_idx;
+	struct hns_roce_idx_que *idx_que = &srq->idx_que;
+	u32 pos;
 
-	if (unlikely(bitmap_full(idx_que->bitmap, size)))
+	pos = find_first_zero_bit(idx_que->bitmap, srq->wqe_cnt);
+	if (unlikely(pos == srq->wqe_cnt))
 		return -ENOSPC;
 
-	wqe_idx = find_first_zero_bit(idx_que->bitmap, size);
-
-	bitmap_set(idx_que->bitmap, wqe_idx, 1);
-
-	return wqe_idx;
+	bitmap_set(idx_que->bitmap, pos, 1);
+	*wqe_idx = pos;
+	return 0;
 }
 
 static int hns_roce_v2_post_srq_recv(struct ib_srq *ibsrq,
@@ -886,17 +898,12 @@ static int hns_roce_v2_post_srq_recv(struct ib_srq *ibsrq,
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibsrq->device);
 	struct hns_roce_srq *srq = to_hr_srq(ibsrq);
-	struct hns_roce_v2_wqe_data_seg *dseg;
+	u32 wqe_idx, ind, nreq, max_sge;
 	struct hns_roce_v2_db srq_db;
 	unsigned long flags;
-	unsigned int ind;
 	__le32 *srq_idx;
 	int ret = 0;
-	int wqe_idx;
-	u32 max_sge;
 	void *wqe;
-	int nreq;
-	int i;
 
 	spin_lock_irqsave(&srq->lock, flags);
 
@@ -919,26 +926,14 @@ static int hns_roce_v2_post_srq_recv(struct ib_srq *ibsrq,
 			break;
 		}
 
-		wqe_idx = find_empty_entry(&srq->idx_que, srq->wqe_cnt);
-		if (unlikely(wqe_idx < 0)) {
-			ret = -ENOMEM;
+		ret = get_srq_wqe_idx(srq, &wqe_idx);
+		if (unlikely(ret)) {
 			*bad_wr = wr;
 			break;
 		}
 
-		wqe = get_srq_wqe(srq, wqe_idx);
-		dseg = (struct hns_roce_v2_wqe_data_seg *)wqe;
-
-		for (i = 0; i < wr->num_sge; ++i) {
-			set_data_seg_v2(dseg, wr->sg_list + i);
-			dseg++;
-		}
-
-		if (srq->rsv_sge) {
-			dseg[i].len = cpu_to_le32(HNS_ROCE_INVALID_SGE_LENGTH);
-			dseg[i].lkey = cpu_to_le32(HNS_ROCE_INVALID_LKEY);
-			dseg[i].addr = 0;
-		}
+		wqe = get_srq_wqe_buf(srq, wqe_idx);
+		fill_recv_sge_to_wqe(wr, wqe, max_sge, srq->rsv_sge);
 
 		srq_idx = get_idx_buf(&srq->idx_que, ind);
 		*srq_idx = cpu_to_le32(wqe_idx);
-- 
2.8.1

