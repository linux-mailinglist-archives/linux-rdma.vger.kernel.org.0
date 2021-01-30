Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C53EA309361
	for <lists+linux-rdma@lfdr.de>; Sat, 30 Jan 2021 10:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbhA3JYM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 30 Jan 2021 04:24:12 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:12365 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbhA3JXB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 30 Jan 2021 04:23:01 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DSSnF4th5z7cbQ;
        Sat, 30 Jan 2021 16:59:13 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Sat, 30 Jan 2021 17:00:25 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: [PATCH for-next 11/12] RDMA/hns: Refactor hns_roce_v2_post_srq_recv()
Date:   Sat, 30 Jan 2021 16:58:09 +0800
Message-ID: <1611997090-48820-12-git-send-email-liweihang@huawei.com>
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

From: Wenpeng Liang <liangwenpeng@huawei.com>

The SRQ in the hns driver consists of the following four parts:
* wqe buf: the buffer to store WQE.
* wqe_idx buf: the cqe of SRQ may be not generated in the order of wqe, so
the wqe_idx corresponding to the idle WQE needs to be pushed into the index
queue which is a FIFO, then it instructs the hardware to obtain the
corresponding WQE.
* bitmap: bitmap is used to generate and release wqe_idx. When the user has
a new WR, the driver finds the idx of the idle wqe in bitmap. When the CQE
of wqe is generated, the driver will release the idx.
* wr_id buf: wr_id buf is used to store the user's wr_id, then return it to
the user when poll_cq verb is invoked.

The process of post SRQ recv is refactored to make preceding code clearer.

Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 69 +++++++++++++++++++-----------
 1 file changed, 43 insertions(+), 26 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 7eba9b5..d5a63e4 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -869,13 +869,32 @@ static void hns_roce_free_srq_wqe(struct hns_roce_srq *srq, u32 wqe_index)
 	spin_unlock(&srq->lock);
 }
 
-int hns_roce_srqwq_overflow(struct hns_roce_srq *srq, u32 nreq)
+static int hns_roce_srqwq_overflow(struct hns_roce_srq *srq)
 {
 	struct hns_roce_idx_que *idx_que = &srq->idx_que;
-	unsigned int cur;
 
-	cur = idx_que->head - idx_que->tail;
-	return cur + nreq >= srq->wqe_cnt;
+	return idx_que->head - idx_que->tail >= srq->wqe_cnt;
+}
+
+static int check_post_srq_valid(struct hns_roce_srq *srq, u32 max_sge,
+				const struct ib_recv_wr *wr)
+{
+	struct ib_device *ib_dev = srq->ibsrq.device;
+
+	if (unlikely(wr->num_sge > max_sge)) {
+		ibdev_err(ib_dev,
+			  "failed to check sge, wr->num_sge = %d, max_sge = %u.\n",
+			  wr->num_sge, max_sge);
+		return -EINVAL;
+	}
+
+	if (unlikely(hns_roce_srqwq_overflow(srq))) {
+		ibdev_err(ib_dev,
+			  "failed to check srqwq status, srqwq is full.\n");
+		return -ENOMEM;
+	}
+
+	return 0;
 }
 
 static int get_srq_wqe_idx(struct hns_roce_srq *srq, u32 *wqe_idx)
@@ -892,36 +911,40 @@ static int get_srq_wqe_idx(struct hns_roce_srq *srq, u32 *wqe_idx)
 	return 0;
 }
 
+static void fill_wqe_idx(struct hns_roce_srq *srq, unsigned int wqe_idx)
+{
+	struct hns_roce_idx_que *idx_que = &srq->idx_que;
+	unsigned int head;
+	__le32 *buf;
+
+	head = idx_que->head & (srq->wqe_cnt - 1);
+
+	buf = get_idx_buf(idx_que, head);
+	*buf = cpu_to_le32(wqe_idx);
+
+	idx_que->head++;
+}
+
 static int hns_roce_v2_post_srq_recv(struct ib_srq *ibsrq,
 				     const struct ib_recv_wr *wr,
 				     const struct ib_recv_wr **bad_wr)
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibsrq->device);
 	struct hns_roce_srq *srq = to_hr_srq(ibsrq);
-	u32 wqe_idx, ind, nreq, max_sge;
 	struct hns_roce_v2_db srq_db;
 	unsigned long flags;
-	__le32 *srq_idx;
 	int ret = 0;
+	u32 max_sge;
+	u32 wqe_idx;
 	void *wqe;
+	u32 nreq;
 
 	spin_lock_irqsave(&srq->lock, flags);
 
-	ind = srq->idx_que.head & (srq->wqe_cnt - 1);
 	max_sge = srq->max_gs - srq->rsv_sge;
-
 	for (nreq = 0; wr; ++nreq, wr = wr->next) {
-		if (unlikely(wr->num_sge > max_sge)) {
-			ibdev_err(&hr_dev->ib_dev,
-				  "srq: num_sge = %d, max_sge = %u.\n",
-				  wr->num_sge, max_sge);
-			ret = -EINVAL;
-			*bad_wr = wr;
-			break;
-		}
-
-		if (unlikely(hns_roce_srqwq_overflow(srq, nreq))) {
-			ret = -ENOMEM;
+		ret = check_post_srq_valid(srq, max_sge, wr);
+		if (ret) {
 			*bad_wr = wr;
 			break;
 		}
@@ -934,17 +957,11 @@ static int hns_roce_v2_post_srq_recv(struct ib_srq *ibsrq,
 
 		wqe = get_srq_wqe_buf(srq, wqe_idx);
 		fill_recv_sge_to_wqe(wr, wqe, max_sge, srq->rsv_sge);
-
-		srq_idx = get_idx_buf(&srq->idx_que, ind);
-		*srq_idx = cpu_to_le32(wqe_idx);
-
+		fill_wqe_idx(srq, wqe_idx);
 		srq->wrid[wqe_idx] = wr->wr_id;
-		ind = (ind + 1) & (srq->wqe_cnt - 1);
 	}
 
 	if (likely(nreq)) {
-		srq->idx_que.head += nreq;
-
 		/*
 		 * Make sure that descriptors are written before
 		 * doorbell record.
-- 
2.8.1

