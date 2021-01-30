Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5594F309360
	for <lists+linux-rdma@lfdr.de>; Sat, 30 Jan 2021 10:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbhA3JYK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 30 Jan 2021 04:24:10 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:12362 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbhA3JXA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 30 Jan 2021 04:23:00 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DSSnG0Styz7d9F;
        Sat, 30 Jan 2021 16:59:14 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Sat, 30 Jan 2021 17:00:23 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: [PATCH for-next 05/12] RDMA/hns: Remove the reserved WQE of SRQ
Date:   Sat, 30 Jan 2021 16:58:03 +0800
Message-ID: <1611997090-48820-6-git-send-email-liweihang@huawei.com>
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

Each SRQs contain an reserved WQE, it is inappropriate and should be
removed.

Fixes: c7bcb13442e1 ("RDMA/hns: Add SRQ support for hip08 kernel mode")
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h | 1 +
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 6 +++---
 drivers/infiniband/hw/hns/hns_roce_srq.c    | 6 ++++--
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 916e031..d6a846b 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -54,6 +54,7 @@
 /* Hardware specification only for v1 engine */
 #define HNS_ROCE_MIN_CQE_NUM			0x40
 #define HNS_ROCE_MIN_WQE_NUM			0x20
+#define HNS_ROCE_MIN_SRQ_WQE_NUM		1
 
 /* Hardware specification only for v1 engine */
 #define HNS_ROCE_MAX_INNER_MTPT_NUM		0x7
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index b13775a..49a8456 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -860,7 +860,7 @@ int hns_roce_srqwq_overflow(struct hns_roce_srq *srq, int nreq)
 	unsigned int cur;
 
 	cur = idx_que->head - idx_que->tail;
-	return cur + nreq >= srq->wqe_cnt - 1;
+	return cur + nreq >= srq->wqe_cnt;
 }
 
 static int find_empty_entry(struct hns_roce_idx_que *idx_que,
@@ -5338,7 +5338,7 @@ static int hns_roce_v2_modify_srq(struct ib_srq *ibsrq,
 		return -EINVAL;
 
 	if (srq_attr_mask & IB_SRQ_LIMIT) {
-		if (srq_attr->srq_limit >= srq->wqe_cnt)
+		if (srq_attr->srq_limit > srq->wqe_cnt)
 			return -EINVAL;
 
 		mailbox = hns_roce_alloc_cmd_mailbox(hr_dev);
@@ -5401,7 +5401,7 @@ static int hns_roce_v2_query_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr)
 				  SRQC_BYTE_8_SRQ_LIMIT_WL_S);
 
 	attr->srq_limit = limit_wl;
-	attr->max_wr = srq->wqe_cnt - 1;
+	attr->max_wr = srq->wqe_cnt;
 	attr->max_sge = srq->max_gs - srq->rsv_sge;
 
 out:
diff --git a/drivers/infiniband/hw/hns/hns_roce_srq.c b/drivers/infiniband/hw/hns/hns_roce_srq.c
index 47e66fe..5d20b30 100644
--- a/drivers/infiniband/hw/hns/hns_roce_srq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_srq.c
@@ -320,7 +320,7 @@ int hns_roce_create_srq(struct ib_srq *ib_srq,
 
 	max_sge = proc_srq_sge(hr_dev, srq, !!udata);
 
-	if (init_attr->attr.max_wr >= hr_dev->caps.max_srq_wrs ||
+	if (init_attr->attr.max_wr > hr_dev->caps.max_srq_wrs ||
 	    init_attr->attr.max_sge > max_sge) {
 		ibdev_err(&hr_dev->ib_dev,
 			  "SRQ config error, depth = %u, sge = %d\n",
@@ -331,7 +331,9 @@ int hns_roce_create_srq(struct ib_srq *ib_srq,
 	mutex_init(&srq->mutex);
 	spin_lock_init(&srq->lock);
 
-	srq->wqe_cnt = roundup_pow_of_two(init_attr->attr.max_wr + 1);
+	init_attr->attr.max_wr = max_t(u32, init_attr->attr.max_wr,
+				       HNS_ROCE_MIN_SRQ_WQE_NUM);
+	srq->wqe_cnt = roundup_pow_of_two(init_attr->attr.max_wr);
 	srq->max_gs =
 		roundup_pow_of_two(init_attr->attr.max_sge + srq->rsv_sge);
 	init_attr->attr.max_wr = srq->wqe_cnt;
-- 
2.8.1

