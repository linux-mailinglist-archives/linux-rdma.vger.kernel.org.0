Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33CF92FFB2
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2019 17:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbfE3P5Z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 May 2019 11:57:25 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:18059 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725961AbfE3P5Z (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 30 May 2019 11:57:25 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 11EE6F998111FDAD3213;
        Thu, 30 May 2019 23:57:22 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Thu, 30 May 2019 23:57:13 +0800
From:   Lijun Ou <oulijun@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH V2 for-next] RDMA/hns: Bugfix for posting multiple srq work request
Date:   Thu, 30 May 2019 23:55:53 +0800
Message-ID: <1559231753-81837-1-git-send-email-oulijun@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

When the user submits more than 32 work request to a srq queue
at a time, it needs to find the corresponding number of entries
in the bitmap in the idx queue. However, the original lookup
function named ffs only processes 32 bits of the array element,
When the number of srq wqe issued exceeds 32, the ffs will only
process the lower 32 bits of the elements, it will not be able
to get the correct wqe index for srq wqe.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Lijun Ou <oulijun@huawei.com>
---
V1->V2:
1. Use bitmap function instead of __ffs64()
---
 drivers/infiniband/hw/hns/hns_roce_device.h |  2 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 29 +++++++++++++----------------
 drivers/infiniband/hw/hns/hns_roce_srq.c    | 15 +++------------
 3 files changed, 17 insertions(+), 29 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 1b5acc0..05cc24b 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -512,7 +512,7 @@ struct hns_roce_idx_que {
 	u32				buf_size;
 	struct ib_umem			*umem;
 	struct hns_roce_mtt		mtt;
-	u64				*bitmap;
+	unsigned long			*bitmap;
 };
 
 struct hns_roce_srq {
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 5de5ae5..135c703 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -2343,15 +2343,10 @@ static void *get_srq_wqe(struct hns_roce_srq *srq, int n)
 
 static void hns_roce_free_srq_wqe(struct hns_roce_srq *srq, int wqe_index)
 {
-	u32 bitmap_num;
-	int bit_num;
-
 	/* always called with interrupts disabled. */
 	spin_lock(&srq->lock);
 
-	bitmap_num = wqe_index / (sizeof(u64) * 8);
-	bit_num = wqe_index % (sizeof(u64) * 8);
-	srq->idx_que.bitmap[bitmap_num] |= (1ULL << bit_num);
+	bitmap_clear(srq->idx_que.bitmap, wqe_index, 1);
 	srq->tail++;
 
 	spin_unlock(&srq->lock);
@@ -6013,18 +6008,19 @@ static int hns_roce_v2_query_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr)
 	return ret;
 }
 
-static int find_empty_entry(struct hns_roce_idx_que *idx_que)
+static int find_empty_entry(struct hns_roce_idx_que *idx_que,
+			    unsigned long size)
 {
-	int bit_num;
-	int i;
+	int wqe_idx;
 
-	/* bitmap[i] is set zero if all bits are allocated */
-	for (i = 0; idx_que->bitmap[i] == 0; ++i)
-		;
-	bit_num = ffs(idx_que->bitmap[i]);
-	idx_que->bitmap[i] &= ~(1ULL << (bit_num - 1));
+	if (unlikely(bitmap_full(idx_que->bitmap, size)))
+		bitmap_zero(idx_que->bitmap, size);
 
-	return i * BITS_PER_LONG_LONG + (bit_num - 1);
+	wqe_idx = find_first_zero_bit(idx_que->bitmap, size);
+
+	bitmap_set(idx_que->bitmap, wqe_idx, 1);
+
+	return wqe_idx;
 }
 
 static void fill_idx_queue(struct hns_roce_idx_que *idx_que,
@@ -6070,7 +6066,8 @@ static int hns_roce_v2_post_srq_recv(struct ib_srq *ibsrq,
 			break;
 		}
 
-		wqe_idx = find_empty_entry(&srq->idx_que);
+		wqe_idx = find_empty_entry(&srq->idx_que, srq->max);
+
 		fill_idx_queue(&srq->idx_que, ind, wqe_idx);
 		wqe = get_srq_wqe(srq, wqe_idx);
 		dseg = (struct hns_roce_v2_wqe_data_seg *)wqe;
diff --git a/drivers/infiniband/hw/hns/hns_roce_srq.c b/drivers/infiniband/hw/hns/hns_roce_srq.c
index ad15b41..c222f24 100644
--- a/drivers/infiniband/hw/hns/hns_roce_srq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_srq.c
@@ -181,28 +181,19 @@ static int hns_roce_create_idx_que(struct ib_pd *pd, struct hns_roce_srq *srq,
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(pd->device);
 	struct hns_roce_idx_que *idx_que = &srq->idx_que;
-	u32 bitmap_num;
-	int i;
 
-	bitmap_num = HNS_ROCE_ALOGN_UP(srq->max, 8 * sizeof(u64));
-
-	idx_que->bitmap = kcalloc(1, bitmap_num / 8, GFP_KERNEL);
+	idx_que->bitmap = bitmap_zalloc(srq->max, GFP_KERNEL);
 	if (!idx_que->bitmap)
 		return -ENOMEM;
 
-	bitmap_num = bitmap_num / (8 * sizeof(u64));
-
 	idx_que->buf_size = srq->idx_que.buf_size;
 
 	if (hns_roce_buf_alloc(hr_dev, idx_que->buf_size, (1 << page_shift) * 2,
 			       &idx_que->idx_buf, page_shift)) {
-		kfree(idx_que->bitmap);
+		bitmap_free(idx_que->bitmap);
 		return -ENOMEM;
 	}
 
-	for (i = 0; i < bitmap_num; i++)
-		idx_que->bitmap[i] = ~(0UL);
-
 	return 0;
 }
 
@@ -395,7 +386,7 @@ int hns_roce_create_srq(struct ib_srq *ib_srq,
 err_create_idx:
 	hns_roce_buf_free(hr_dev, srq->idx_que.buf_size,
 			  &srq->idx_que.idx_buf);
-	kfree(srq->idx_que.bitmap);
+	bitmap_free(srq->idx_que.bitmap);
 
 err_srq_mtt:
 	hns_roce_mtt_cleanup(hr_dev, &srq->mtt);
-- 
1.9.1

