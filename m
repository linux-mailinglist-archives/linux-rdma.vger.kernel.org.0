Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD111CA779
	for <lists+linux-rdma@lfdr.de>; Fri,  8 May 2020 11:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgEHJqY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 8 May 2020 05:46:24 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:37296 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727071AbgEHJqY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 8 May 2020 05:46:24 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B02E7E53389AD5B9EA9E;
        Fri,  8 May 2020 17:46:21 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Fri, 8 May 2020 17:46:13 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 9/9] RDMA/hns: Reserve one sge in order to avoid local length error
Date:   Fri, 8 May 2020 17:45:59 +0800
Message-ID: <1588931159-56875-10-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1588931159-56875-1-git-send-email-liweihang@huawei.com>
References: <1588931159-56875-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lijun Ou <oulijun@huawei.com>

When rq/srq sge length is smaller than sq sge length, it will produce a
local length error and may cause the bus to hang. Therefore, for rq wqe
and srq wqe, one reserved sge pointing to a reserved mr is used to avoid
this error.

Signed-off-by: Lijun Ou <oulijun@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h | 2 ++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 9 +++++----
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  | 4 +++-
 drivers/infiniband/hw/hns/hns_roce_qp.c     | 5 +++--
 drivers/infiniband/hw/hns/hns_roce_srq.c    | 2 +-
 5 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 543c37a..2f804c18 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -66,6 +66,8 @@
 #define HNS_ROCE_CQE_WCMD_EMPTY_BIT		0x2
 #define HNS_ROCE_MIN_CQE_CNT			16
 
+#define HNS_ROCE_RESERVED_SGE			1
+
 #define HNS_ROCE_MAX_IRQ_NUM			128
 
 #define HNS_ROCE_SGE_IN_WQE			2
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index e7ebe31..6877c1e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -629,7 +629,7 @@ static int hns_roce_v2_post_recv(struct ib_qp *ibqp,
 
 		wqe_idx = (hr_qp->rq.head + nreq) & (hr_qp->rq.wqe_cnt - 1);
 
-		if (unlikely(wr->num_sge > hr_qp->rq.max_gs)) {
+		if (unlikely(wr->num_sge >= hr_qp->rq.max_gs)) {
 			ibdev_err(ibdev, "rq:num_sge=%d >= qp->sq.max_gs=%d\n",
 				  wr->num_sge, hr_qp->rq.max_gs);
 			ret = -EINVAL;
@@ -649,6 +649,7 @@ static int hns_roce_v2_post_recv(struct ib_qp *ibqp,
 		if (i < hr_qp->rq.max_gs) {
 			dseg->lkey = cpu_to_le32(HNS_ROCE_INVALID_LKEY);
 			dseg->addr = 0;
+			dseg->len = cpu_to_le32(HNS_ROCE_INVALID_SGE_LENGTH);
 		}
 
 		/* rq support inline data */
@@ -782,8 +783,8 @@ static int hns_roce_v2_post_srq_recv(struct ib_srq *ibsrq,
 		}
 
 		if (i < srq->max_gs) {
-			dseg[i].len = 0;
-			dseg[i].lkey = cpu_to_le32(0x100);
+			dseg[i].len = cpu_to_le32(HNS_ROCE_INVALID_SGE_LENGTH);
+			dseg[i].lkey = cpu_to_le32(HNS_ROCE_INVALID_LKEY);
 			dseg[i].addr = 0;
 		}
 
@@ -5042,7 +5043,7 @@ static int hns_roce_v2_query_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr)
 
 	attr->srq_limit = limit_wl;
 	attr->max_wr = srq->wqe_cnt - 1;
-	attr->max_sge = srq->max_gs;
+	attr->max_sge = srq->max_gs - HNS_ROCE_RESERVED_SGE;
 
 out:
 	hns_roce_free_cmd_mailbox(hr_dev, mailbox);
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index 05bfe07..a135b09 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -92,7 +92,9 @@
 #define HNS_ROCE_V2_CQC_TIMER_ENTRY_SZ		PAGE_SIZE
 #define HNS_ROCE_V2_PAGE_SIZE_SUPPORTED		0xFFFFF000
 #define HNS_ROCE_V2_MAX_INNER_MTPT_NUM		2
-#define HNS_ROCE_INVALID_LKEY			0x100
+#define HNS_ROCE_INVALID_LKEY			0x0
+#define HNS_ROCE_INVALID_SGE_LENGTH		0x80000000
+
 #define HNS_ROCE_CMQ_TX_TIMEOUT			30000
 #define HNS_ROCE_V2_UC_RC_SGE_NUM_IN_WQE	2
 #define HNS_ROCE_V2_RSV_QPS			8
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index c8334d7..6e5df46 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -386,7 +386,8 @@ static int set_rq_size(struct hns_roce_dev *hr_dev, struct ib_qp_cap *cap,
 		return -EINVAL;
 	}
 
-	hr_qp->rq.max_gs = roundup_pow_of_two(max(1U, cap->max_recv_sge));
+	hr_qp->rq.max_gs = roundup_pow_of_two(max(1U, cap->max_recv_sge) +
+					      HNS_ROCE_RESERVED_SGE);
 
 	if (hr_dev->caps.max_rq_sg <= HNS_ROCE_SGE_IN_WQE)
 		hr_qp->rq.wqe_shift = ilog2(hr_dev->caps.max_rq_desc_sz);
@@ -401,7 +402,7 @@ static int set_rq_size(struct hns_roce_dev *hr_dev, struct ib_qp_cap *cap,
 		hr_qp->rq_inl_buf.wqe_cnt = 0;
 
 	cap->max_recv_wr = cnt;
-	cap->max_recv_sge = hr_qp->rq.max_gs;
+	cap->max_recv_sge = hr_qp->rq.max_gs - HNS_ROCE_RESERVED_SGE;
 
 	return 0;
 }
diff --git a/drivers/infiniband/hw/hns/hns_roce_srq.c b/drivers/infiniband/hw/hns/hns_roce_srq.c
index 03b76e6..3018c98 100644
--- a/drivers/infiniband/hw/hns/hns_roce_srq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_srq.c
@@ -297,7 +297,7 @@ int hns_roce_create_srq(struct ib_srq *ib_srq,
 	spin_lock_init(&srq->lock);
 
 	srq->wqe_cnt = roundup_pow_of_two(init_attr->attr.max_wr + 1);
-	srq->max_gs = init_attr->attr.max_sge;
+	srq->max_gs = init_attr->attr.max_sge + HNS_ROCE_RESERVED_SGE;
 
 	if (udata) {
 		ret = ib_copy_from_udata(&ucmd, udata, sizeof(ucmd));
-- 
2.8.1

