Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E92D730934C
	for <lists+linux-rdma@lfdr.de>; Sat, 30 Jan 2021 10:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbhA3JYT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 30 Jan 2021 04:24:19 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:12361 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbhA3JXM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 30 Jan 2021 04:23:12 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DSSnG0l0Lz7d9P;
        Sat, 30 Jan 2021 16:59:14 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Sat, 30 Jan 2021 17:00:24 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: [PATCH for-next 09/12] RDMA/hns: Refactor post recv flow
Date:   Sat, 30 Jan 2021 16:58:07 +0800
Message-ID: <1611997090-48820-10-git-send-email-liweihang@huawei.com>
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

Refactor post recv flow by removing unnecessary checking and removing
duplicated code.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 81 +++++++++++++++---------------
 1 file changed, 41 insertions(+), 40 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 105019c5..1f70422 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -48,8 +48,8 @@
 #include "hns_roce_hem.h"
 #include "hns_roce_hw_v2.h"
 
-static void set_data_seg_v2(struct hns_roce_v2_wqe_data_seg *dseg,
-			    struct ib_sge *sg)
+static inline void set_data_seg_v2(struct hns_roce_v2_wqe_data_seg *dseg,
+				   struct ib_sge *sg)
 {
 	dseg->lkey = cpu_to_le32(sg->lkey);
 	dseg->addr = cpu_to_le64(sg->addr);
@@ -729,6 +729,40 @@ static int check_recv_valid(struct hns_roce_dev *hr_dev,
 	return 0;
 }
 
+static void fill_rq_wqe(struct hns_roce_qp *hr_qp, const struct ib_recv_wr *wr,
+			u32 wqe_idx)
+{
+	struct hns_roce_v2_wqe_data_seg *dseg;
+	struct hns_roce_rinl_sge *sge_list;
+	void *wqe = NULL;
+	int i;
+
+	wqe = hns_roce_get_recv_wqe(hr_qp, wqe_idx);
+	dseg = (struct hns_roce_v2_wqe_data_seg *)wqe;
+	for (i = 0; i < wr->num_sge; i++) {
+		if (!wr->sg_list[i].length)
+			continue;
+		set_data_seg_v2(dseg, wr->sg_list + i);
+		dseg++;
+	}
+
+	if (hr_qp->rq.rsv_sge) {
+		dseg->lkey = cpu_to_le32(HNS_ROCE_INVALID_LKEY);
+		dseg->addr = 0;
+		dseg->len = cpu_to_le32(HNS_ROCE_INVALID_SGE_LENGTH);
+	}
+
+	/* rq support inline data */
+	if (hr_qp->rq_inl_buf.wqe_cnt) {
+		sge_list = hr_qp->rq_inl_buf.wqe_list[wqe_idx].sg_list;
+		hr_qp->rq_inl_buf.wqe_list[wqe_idx].sge_cnt = (u32)wr->num_sge;
+		for (i = 0; i < wr->num_sge; i++) {
+			sge_list[i].addr = (void *)(u64)wr->sg_list[i].addr;
+			sge_list[i].len = wr->sg_list[i].length;
+		}
+	}
+}
+
 static int hns_roce_v2_post_recv(struct ib_qp *ibqp,
 				 const struct ib_recv_wr *wr,
 				 const struct ib_recv_wr **bad_wr)
@@ -736,15 +770,9 @@ static int hns_roce_v2_post_recv(struct ib_qp *ibqp,
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
 	struct hns_roce_qp *hr_qp = to_hr_qp(ibqp);
 	struct ib_device *ibdev = &hr_dev->ib_dev;
-	struct hns_roce_v2_wqe_data_seg *dseg;
-	struct hns_roce_rinl_sge *sge_list;
+	u32 wqe_idx, nreq, max_sge;
 	unsigned long flags;
-	void *wqe = NULL;
-	u32 wqe_idx;
-	u32 max_sge;
-	int nreq;
 	int ret;
-	int i;
 
 	spin_lock_irqsave(&hr_qp->rq.lock, flags);
 
@@ -764,8 +792,6 @@ static int hns_roce_v2_post_recv(struct ib_qp *ibqp,
 			goto out;
 		}
 
-		wqe_idx = (hr_qp->rq.head + nreq) & (hr_qp->rq.wqe_cnt - 1);
-
 		if (unlikely(wr->num_sge > max_sge)) {
 			ibdev_err(ibdev, "num_sge = %d >= max_sge = %u.\n",
 				  wr->num_sge, max_sge);
@@ -774,32 +800,8 @@ static int hns_roce_v2_post_recv(struct ib_qp *ibqp,
 			goto out;
 		}
 
-		wqe = hns_roce_get_recv_wqe(hr_qp, wqe_idx);
-		dseg = (struct hns_roce_v2_wqe_data_seg *)wqe;
-		for (i = 0; i < wr->num_sge; i++) {
-			if (!wr->sg_list[i].length)
-				continue;
-			set_data_seg_v2(dseg, wr->sg_list + i);
-			dseg++;
-		}
-
-		if (hr_qp->rq.rsv_sge) {
-			dseg->lkey = cpu_to_le32(HNS_ROCE_INVALID_LKEY);
-			dseg->addr = 0;
-			dseg->len = cpu_to_le32(HNS_ROCE_INVALID_SGE_LENGTH);
-		}
-
-		/* rq support inline data */
-		if (hr_qp->rq_inl_buf.wqe_cnt) {
-			sge_list = hr_qp->rq_inl_buf.wqe_list[wqe_idx].sg_list;
-			hr_qp->rq_inl_buf.wqe_list[wqe_idx].sge_cnt =
-							       (u32)wr->num_sge;
-			for (i = 0; i < wr->num_sge; i++) {
-				sge_list[i].addr =
-					       (void *)(u64)wr->sg_list[i].addr;
-				sge_list[i].len = wr->sg_list[i].length;
-			}
-		}
+		wqe_idx = (hr_qp->rq.head + nreq) & (hr_qp->rq.wqe_cnt - 1);
+		fill_rq_wqe(hr_qp, wr, wqe_idx);
 
 		hr_qp->rq.wrid[wqe_idx] = wr->wr_id;
 	}
@@ -928,9 +930,8 @@ static int hns_roce_v2_post_srq_recv(struct ib_srq *ibsrq,
 		dseg = (struct hns_roce_v2_wqe_data_seg *)wqe;
 
 		for (i = 0; i < wr->num_sge; ++i) {
-			dseg[i].len = cpu_to_le32(wr->sg_list[i].length);
-			dseg[i].lkey = cpu_to_le32(wr->sg_list[i].lkey);
-			dseg[i].addr = cpu_to_le64(wr->sg_list[i].addr);
+			set_data_seg_v2(dseg, wr->sg_list + i);
+			dseg++;
 		}
 
 		if (srq->rsv_sge) {
-- 
2.8.1

