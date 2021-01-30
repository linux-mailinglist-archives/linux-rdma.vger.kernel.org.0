Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94F8D309333
	for <lists+linux-rdma@lfdr.de>; Sat, 30 Jan 2021 10:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbhA3JVS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 30 Jan 2021 04:21:18 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:11955 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbhA3JSF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 30 Jan 2021 04:18:05 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DSSnQ5LfTzjFBn;
        Sat, 30 Jan 2021 16:59:22 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Sat, 30 Jan 2021 17:00:21 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: [PATCH for-next 02/12] RDMA/hns: Bugfix for checking whether the srq is full when post wr
Date:   Sat, 30 Jan 2021 16:58:00 +0800
Message-ID: <1611997090-48820-3-git-send-email-liweihang@huawei.com>
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

If a user posts WR by wr_list, the head pointer of idx_queue won't be
updated until all wqes are filled, so the judgment of whether head equals
to tail will get a wrong result. Fix above issue and move the head and tail
pointer from the srq structure into the idx_queue structure. After
idx_queue is filled with wqe idx, the head pointer of it will increase.

Fixes: c7bcb13442e1 ("RDMA/hns: Add SRQ support for hip08 kernel mode")
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h |  4 ++--
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 19 ++++++++++++++-----
 drivers/infiniband/hw/hns/hns_roce_srq.c    |  5 +++--
 3 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 72961e4..916e031 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -494,6 +494,8 @@ struct hns_roce_idx_que {
 	struct hns_roce_mtr		mtr;
 	int				entry_shift;
 	unsigned long			*bitmap;
+	u32				head;
+	u32				tail;
 };
 
 struct hns_roce_srq {
@@ -513,8 +515,6 @@ struct hns_roce_srq {
 	u64		       *wrid;
 	struct hns_roce_idx_que idx_que;
 	spinlock_t		lock;
-	u16			head;
-	u16			tail;
 	struct mutex		mutex;
 	void (*event)(struct hns_roce_srq *srq, enum hns_roce_event event);
 };
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 2245d25..b13775a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -849,11 +849,20 @@ static void hns_roce_free_srq_wqe(struct hns_roce_srq *srq, int wqe_index)
 	spin_lock(&srq->lock);
 
 	bitmap_clear(srq->idx_que.bitmap, wqe_index, 1);
-	srq->tail++;
+	srq->idx_que.tail++;
 
 	spin_unlock(&srq->lock);
 }
 
+int hns_roce_srqwq_overflow(struct hns_roce_srq *srq, int nreq)
+{
+	struct hns_roce_idx_que *idx_que = &srq->idx_que;
+	unsigned int cur;
+
+	cur = idx_que->head - idx_que->tail;
+	return cur + nreq >= srq->wqe_cnt - 1;
+}
+
 static int find_empty_entry(struct hns_roce_idx_que *idx_que,
 			    unsigned long size)
 {
@@ -889,7 +898,7 @@ static int hns_roce_v2_post_srq_recv(struct ib_srq *ibsrq,
 
 	spin_lock_irqsave(&srq->lock, flags);
 
-	ind = srq->head & (srq->wqe_cnt - 1);
+	ind = srq->idx_que.head & (srq->wqe_cnt - 1);
 	max_sge = srq->max_gs - srq->rsv_sge;
 
 	for (nreq = 0; wr; ++nreq, wr = wr->next) {
@@ -902,7 +911,7 @@ static int hns_roce_v2_post_srq_recv(struct ib_srq *ibsrq,
 			break;
 		}
 
-		if (unlikely(srq->head == srq->tail)) {
+		if (unlikely(hns_roce_srqwq_overflow(srq, nreq))) {
 			ret = -ENOMEM;
 			*bad_wr = wr;
 			break;
@@ -938,7 +947,7 @@ static int hns_roce_v2_post_srq_recv(struct ib_srq *ibsrq,
 	}
 
 	if (likely(nreq)) {
-		srq->head += nreq;
+		srq->idx_que.head += nreq;
 
 		/*
 		 * Make sure that descriptors are written before
@@ -950,7 +959,7 @@ static int hns_roce_v2_post_srq_recv(struct ib_srq *ibsrq,
 			cpu_to_le32(HNS_ROCE_V2_SRQ_DB << V2_DB_BYTE_4_CMD_S |
 				    (srq->srqn & V2_DB_BYTE_4_TAG_M));
 		srq_db.parameter =
-			cpu_to_le32(srq->head & V2_DB_PARAMETER_IDX_M);
+			cpu_to_le32(srq->idx_que.head & V2_DB_PARAMETER_IDX_M);
 
 		hns_roce_write64(hr_dev, (__le32 *)&srq_db, srq->db_reg_l);
 	}
diff --git a/drivers/infiniband/hw/hns/hns_roce_srq.c b/drivers/infiniband/hw/hns/hns_roce_srq.c
index 1be6812..e622fd1d 100644
--- a/drivers/infiniband/hw/hns/hns_roce_srq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_srq.c
@@ -245,6 +245,9 @@ static int alloc_srq_idx(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq,
 		}
 	}
 
+	idx_que->head = 0;
+	idx_que->tail = 0;
+
 	return 0;
 err_idx_mtr:
 	hns_roce_mtr_destroy(hr_dev, &idx_que->mtr);
@@ -263,8 +266,6 @@ static void free_srq_idx(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq)
 
 static int alloc_srq_wrid(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq)
 {
-	srq->head = 0;
-	srq->tail = srq->wqe_cnt - 1;
 	srq->wrid = kvmalloc_array(srq->wqe_cnt, sizeof(u64), GFP_KERNEL);
 	if (!srq->wrid)
 		return -ENOMEM;
-- 
2.8.1

