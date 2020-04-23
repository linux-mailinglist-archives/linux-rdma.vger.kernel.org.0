Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA8311B5A35
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2020 13:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbgDWLQD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Apr 2020 07:16:03 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:49402 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727862AbgDWLQC (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 23 Apr 2020 07:16:02 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8ECFC90A767B05BBCC8B;
        Thu, 23 Apr 2020 19:16:00 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Thu, 23 Apr 2020 19:15:54 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 5/5] RDMA/hns: Optimize SRQ buffer size calculating process
Date:   Thu, 23 Apr 2020 19:15:50 +0800
Message-ID: <1587640550-16777-6-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1587640550-16777-1-git-send-email-liweihang@huawei.com>
References: <1587640550-16777-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

Optimizes the SRQ's WQE buffer parameters calculating process to make the
codes more readable.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h |  2 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 29 ++++++++++++++---------------
 drivers/infiniband/hw/hns/hns_roce_srq.c    | 16 ++++++++--------
 3 files changed, 23 insertions(+), 24 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index eaebd4b..ecaaad1 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -472,7 +472,7 @@ struct hns_roce_cq {
 
 struct hns_roce_idx_que {
 	struct hns_roce_mtr		mtr;
-	int				entry_sz;
+	int				entry_shift;
 	unsigned long			*bitmap;
 };
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 0b79daf..f70370d 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -699,6 +699,12 @@ static void *get_srq_wqe(struct hns_roce_srq *srq, int n)
 	return hns_roce_buf_offset(srq->buf_mtr.kmem, n << srq->wqe_shift);
 }
 
+static void *get_idx_buf(struct hns_roce_idx_que *idx_que, int n)
+{
+	return hns_roce_buf_offset(idx_que->mtr.kmem,
+				   n << idx_que->entry_shift);
+}
+
 static void hns_roce_free_srq_wqe(struct hns_roce_srq *srq, int wqe_index)
 {
 	/* always called with interrupts disabled. */
@@ -725,16 +731,6 @@ static int find_empty_entry(struct hns_roce_idx_que *idx_que,
 	return wqe_idx;
 }
 
-static void fill_idx_queue(struct hns_roce_idx_que *idx_que,
-			   int cur_idx, int wqe_idx)
-{
-	unsigned int *addr;
-
-	addr = (unsigned int *)hns_roce_buf_offset(idx_que->mtr.kmem,
-						   cur_idx * idx_que->entry_sz);
-	*addr = wqe_idx;
-}
-
 static int hns_roce_v2_post_srq_recv(struct ib_srq *ibsrq,
 				     const struct ib_recv_wr *wr,
 				     const struct ib_recv_wr **bad_wr)
@@ -744,6 +740,7 @@ static int hns_roce_v2_post_srq_recv(struct ib_srq *ibsrq,
 	struct hns_roce_v2_wqe_data_seg *dseg;
 	struct hns_roce_v2_db srq_db;
 	unsigned long flags;
+	__le32 *srq_idx;
 	int ret = 0;
 	int wqe_idx;
 	void *wqe;
@@ -775,7 +772,6 @@ static int hns_roce_v2_post_srq_recv(struct ib_srq *ibsrq,
 			break;
 		}
 
-		fill_idx_queue(&srq->idx_que, ind, wqe_idx);
 		wqe = get_srq_wqe(srq, wqe_idx);
 		dseg = (struct hns_roce_v2_wqe_data_seg *)wqe;
 
@@ -791,6 +787,9 @@ static int hns_roce_v2_post_srq_recv(struct ib_srq *ibsrq,
 			dseg[i].addr = 0;
 		}
 
+		srq_idx = get_idx_buf(&srq->idx_que, ind);
+		*srq_idx = cpu_to_le32(wqe_idx);
+
 		srq->wrid[wqe_idx] = wr->wr_id;
 		ind = (ind + 1) & (srq->wqe_cnt - 1);
 	}
@@ -4901,8 +4900,8 @@ static void hns_roce_v2_write_srqc(struct hns_roce_dev *hr_dev,
 	roce_set_field(srq_context->byte_4_srqn_srqst,
 		       SRQC_BYTE_4_SRQ_WQE_HOP_NUM_M,
 		       SRQC_BYTE_4_SRQ_WQE_HOP_NUM_S,
-		       (hr_dev->caps.srqwqe_hop_num == HNS_ROCE_HOP_NUM_0 ? 0 :
-		       hr_dev->caps.srqwqe_hop_num));
+		       to_hr_hem_hopnum(hr_dev->caps.srqwqe_hop_num,
+					srq->wqe_cnt));
 	roce_set_field(srq_context->byte_4_srqn_srqst,
 		       SRQC_BYTE_4_SRQ_SHIFT_M, SRQC_BYTE_4_SRQ_SHIFT_S,
 		       ilog2(srq->wqe_cnt));
@@ -4944,8 +4943,8 @@ static void hns_roce_v2_write_srqc(struct hns_roce_dev *hr_dev,
 	roce_set_field(srq_context->byte_44_idxbufpgsz_addr,
 		       SRQC_BYTE_44_SRQ_IDX_HOP_NUM_M,
 		       SRQC_BYTE_44_SRQ_IDX_HOP_NUM_S,
-		       hr_dev->caps.idx_hop_num == HNS_ROCE_HOP_NUM_0 ? 0 :
-		       hr_dev->caps.idx_hop_num);
+		       to_hr_hem_hopnum(hr_dev->caps.idx_hop_num,
+					srq->wqe_cnt));
 
 	roce_set_field(srq_context->byte_44_idxbufpgsz_addr,
 		       SRQC_BYTE_44_SRQ_IDX_BA_PG_SZ_M,
diff --git a/drivers/infiniband/hw/hns/hns_roce_srq.c b/drivers/infiniband/hw/hns/hns_roce_srq.c
index e413a97..6e5a2ad 100644
--- a/drivers/infiniband/hw/hns/hns_roce_srq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_srq.c
@@ -181,16 +181,15 @@ static int alloc_srq_buf(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq,
 {
 	struct ib_device *ibdev = &hr_dev->ib_dev;
 	struct hns_roce_buf_attr buf_attr = {};
-	int sge_size;
 	int err;
 
-	sge_size = roundup_pow_of_two(max(HNS_ROCE_SGE_SIZE,
-					  HNS_ROCE_SGE_SIZE * srq->max_gs));
-
-	srq->wqe_shift = ilog2(sge_size);
+	srq->wqe_shift = ilog2(roundup_pow_of_two(max(HNS_ROCE_SGE_SIZE,
+						      HNS_ROCE_SGE_SIZE *
+						      srq->max_gs)));
 
 	buf_attr.page_shift = hr_dev->caps.srqwqe_buf_pg_sz + PAGE_ADDR_SHIFT;
-	buf_attr.region[0].size = srq->wqe_cnt * sge_size;
+	buf_attr.region[0].size = to_hr_hem_entries_size(srq->wqe_cnt,
+							 srq->wqe_shift);
 	buf_attr.region[0].hopnum = hr_dev->caps.srqwqe_hop_num;
 	buf_attr.region_count = 1;
 	buf_attr.fixed_page = true;
@@ -217,10 +216,11 @@ static int alloc_srq_idx(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq,
 	struct hns_roce_buf_attr buf_attr = {};
 	int err;
 
-	srq->idx_que.entry_sz = HNS_ROCE_IDX_QUE_ENTRY_SZ;
+	srq->idx_que.entry_shift = ilog2(HNS_ROCE_IDX_QUE_ENTRY_SZ);
 
 	buf_attr.page_shift = hr_dev->caps.idx_buf_pg_sz + PAGE_ADDR_SHIFT;
-	buf_attr.region[0].size = srq->wqe_cnt * HNS_ROCE_IDX_QUE_ENTRY_SZ;
+	buf_attr.region[0].size = to_hr_hem_entries_size(srq->wqe_cnt,
+					srq->idx_que.entry_shift);
 	buf_attr.region[0].hopnum = hr_dev->caps.idx_hop_num;
 	buf_attr.region_count = 1;
 	buf_attr.fixed_page = true;
-- 
2.8.1

