Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5862C249987
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Aug 2020 11:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725804AbgHSJk5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Aug 2020 05:40:57 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:43216 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726876AbgHSJk5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 19 Aug 2020 05:40:57 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E1FE0282A39096AF016A;
        Wed, 19 Aug 2020 17:40:53 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Wed, 19 Aug 2020 17:40:43 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-rc] Revert "RDMA/hns: Reserve one sge in order to avoid local length error"
Date:   Wed, 19 Aug 2020 17:39:44 +0800
Message-ID: <1597829984-20223-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch caused some issues on SEND operation, and it should be reverted
to make the drivers work correctly. There will be a better solution that
has been tested carefully to solve the original problem.

This reverts commit 711195e57d341e58133d92cf8aaab1db24e4768d.

Fixes: 711195e57d34 ("RDMA/hns: Reserve one sge in order to avoid local length error")
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h | 2 --
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 9 ++++-----
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  | 4 +---
 drivers/infiniband/hw/hns/hns_roce_qp.c     | 5 ++---
 drivers/infiniband/hw/hns/hns_roce_srq.c    | 2 +-
 5 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index da9888d..6edcbdc 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -65,8 +65,6 @@
 #define HNS_ROCE_CQE_WCMD_EMPTY_BIT		0x2
 #define HNS_ROCE_MIN_CQE_CNT			16
 
-#define HNS_ROCE_RESERVED_SGE			1
-
 #define HNS_ROCE_MAX_IRQ_NUM			128
 
 #define HNS_ROCE_SGE_IN_WQE			2
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index d296859..4cda95e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -633,7 +633,7 @@ static int hns_roce_v2_post_recv(struct ib_qp *ibqp,
 
 		wqe_idx = (hr_qp->rq.head + nreq) & (hr_qp->rq.wqe_cnt - 1);
 
-		if (unlikely(wr->num_sge >= hr_qp->rq.max_gs)) {
+		if (unlikely(wr->num_sge > hr_qp->rq.max_gs)) {
 			ibdev_err(ibdev, "rq:num_sge=%d >= qp->sq.max_gs=%d\n",
 				  wr->num_sge, hr_qp->rq.max_gs);
 			ret = -EINVAL;
@@ -653,7 +653,6 @@ static int hns_roce_v2_post_recv(struct ib_qp *ibqp,
 		if (wr->num_sge < hr_qp->rq.max_gs) {
 			dseg->lkey = cpu_to_le32(HNS_ROCE_INVALID_LKEY);
 			dseg->addr = 0;
-			dseg->len = cpu_to_le32(HNS_ROCE_INVALID_SGE_LENGTH);
 		}
 
 		/* rq support inline data */
@@ -787,8 +786,8 @@ static int hns_roce_v2_post_srq_recv(struct ib_srq *ibsrq,
 		}
 
 		if (wr->num_sge < srq->max_gs) {
-			dseg[i].len = cpu_to_le32(HNS_ROCE_INVALID_SGE_LENGTH);
-			dseg[i].lkey = cpu_to_le32(HNS_ROCE_INVALID_LKEY);
+			dseg[i].len = 0;
+			dseg[i].lkey = cpu_to_le32(0x100);
 			dseg[i].addr = 0;
 		}
 
@@ -5070,7 +5069,7 @@ static int hns_roce_v2_query_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr)
 
 	attr->srq_limit = limit_wl;
 	attr->max_wr = srq->wqe_cnt - 1;
-	attr->max_sge = srq->max_gs - HNS_ROCE_RESERVED_SGE;
+	attr->max_sge = srq->max_gs;
 
 out:
 	hns_roce_free_cmd_mailbox(hr_dev, mailbox);
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index 1fb1c58..ac29be4 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -92,9 +92,7 @@
 #define HNS_ROCE_V2_CQC_TIMER_ENTRY_SZ		PAGE_SIZE
 #define HNS_ROCE_V2_PAGE_SIZE_SUPPORTED		0xFFFFF000
 #define HNS_ROCE_V2_MAX_INNER_MTPT_NUM		2
-#define HNS_ROCE_INVALID_LKEY			0x0
-#define HNS_ROCE_INVALID_SGE_LENGTH		0x80000000
-
+#define HNS_ROCE_INVALID_LKEY			0x100
 #define HNS_ROCE_CMQ_TX_TIMEOUT			30000
 #define HNS_ROCE_V2_UC_RC_SGE_NUM_IN_WQE	2
 #define HNS_ROCE_V2_RSV_QPS			8
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index e94ca13..c063c45 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -386,8 +386,7 @@ static int set_rq_size(struct hns_roce_dev *hr_dev, struct ib_qp_cap *cap,
 		return -EINVAL;
 	}
 
-	hr_qp->rq.max_gs = roundup_pow_of_two(max(1U, cap->max_recv_sge) +
-					      HNS_ROCE_RESERVED_SGE);
+	hr_qp->rq.max_gs = roundup_pow_of_two(max(1U, cap->max_recv_sge));
 
 	if (hr_dev->caps.max_rq_sg <= HNS_ROCE_SGE_IN_WQE)
 		hr_qp->rq.wqe_shift = ilog2(hr_dev->caps.max_rq_desc_sz);
@@ -402,7 +401,7 @@ static int set_rq_size(struct hns_roce_dev *hr_dev, struct ib_qp_cap *cap,
 		hr_qp->rq_inl_buf.wqe_cnt = 0;
 
 	cap->max_recv_wr = cnt;
-	cap->max_recv_sge = hr_qp->rq.max_gs - HNS_ROCE_RESERVED_SGE;
+	cap->max_recv_sge = hr_qp->rq.max_gs;
 
 	return 0;
 }
diff --git a/drivers/infiniband/hw/hns/hns_roce_srq.c b/drivers/infiniband/hw/hns/hns_roce_srq.c
index f40a000..b9e2dbd 100644
--- a/drivers/infiniband/hw/hns/hns_roce_srq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_srq.c
@@ -297,7 +297,7 @@ int hns_roce_create_srq(struct ib_srq *ib_srq,
 	spin_lock_init(&srq->lock);
 
 	srq->wqe_cnt = roundup_pow_of_two(init_attr->attr.max_wr + 1);
-	srq->max_gs = init_attr->attr.max_sge + HNS_ROCE_RESERVED_SGE;
+	srq->max_gs = init_attr->attr.max_sge;
 
 	if (udata) {
 		ret = ib_copy_from_udata(&ucmd, udata, sizeof(ucmd));
-- 
2.8.1

