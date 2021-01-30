Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53FB030934B
	for <lists+linux-rdma@lfdr.de>; Sat, 30 Jan 2021 10:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbhA3JYR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 30 Jan 2021 04:24:17 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:11958 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbhA3JXG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 30 Jan 2021 04:23:06 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DSSnQ53pFzjF9W;
        Sat, 30 Jan 2021 16:59:22 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Sat, 30 Jan 2021 17:00:21 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: [PATCH for-next 01/12] RDMA/hns: Allocate one more recv SGE for HIP08
Date:   Sat, 30 Jan 2021 16:57:59 +0800
Message-ID: <1611997090-48820-2-git-send-email-liweihang@huawei.com>
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

From: Lang Cheng <chenglang@huawei.com>

The RQ/SRQ of HIP08 needs one special sge to stop receive reliably. So the
driver needs to allocate at least one SGE when creating RQ/SRQ and ensure
that at least one SGE is filled with the special value during post_recv.

Besides, the kernel driver should only do this for kernel ULP. For
userspace ULP, the userspace driver will allocate the reserved SGE in
buffer, and the kernel driver just needs to pin the corresponding size of
memory based on the userspace driver's requirements.

Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h |  4 +++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 28 +++++++++++++-------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  3 ++-
 drivers/infiniband/hw/hns/hns_roce_qp.c     | 37 +++++++++++++++++++++-----
 drivers/infiniband/hw/hns/hns_roce_srq.c    | 40 ++++++++++++++++++++++++++---
 5 files changed, 93 insertions(+), 19 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index f62851f..72961e4 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -65,6 +65,8 @@
 #define HNS_ROCE_CQE_WCMD_EMPTY_BIT		0x2
 #define HNS_ROCE_MIN_CQE_CNT			16
 
+#define HNS_ROCE_RESERVED_SGE			1
+
 #define HNS_ROCE_MAX_IRQ_NUM			128
 
 #define HNS_ROCE_SGE_IN_WQE			2
@@ -395,6 +397,7 @@ struct hns_roce_wq {
 	spinlock_t	lock;
 	u32		wqe_cnt;  /* WQE num */
 	u32		max_gs;
+	u32		rsv_sge;
 	int		offset;
 	int		wqe_shift;	/* WQE size */
 	u32		head;
@@ -498,6 +501,7 @@ struct hns_roce_srq {
 	unsigned long		srqn;
 	u32			wqe_cnt;
 	int			max_gs;
+	u32			rsv_sge;
 	int			wqe_shift;
 	void __iomem		*db_reg_l;
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index a5bbfb1..2245d25 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -741,6 +741,7 @@ static int hns_roce_v2_post_recv(struct ib_qp *ibqp,
 	unsigned long flags;
 	void *wqe = NULL;
 	u32 wqe_idx;
+	u32 max_sge;
 	int nreq;
 	int ret;
 	int i;
@@ -754,6 +755,7 @@ static int hns_roce_v2_post_recv(struct ib_qp *ibqp,
 		goto out;
 	}
 
+	max_sge = hr_qp->rq.max_gs - hr_qp->rq.rsv_sge;
 	for (nreq = 0; wr; ++nreq, wr = wr->next) {
 		if (unlikely(hns_roce_wq_overflow(&hr_qp->rq, nreq,
 						  hr_qp->ibqp.recv_cq))) {
@@ -764,9 +766,9 @@ static int hns_roce_v2_post_recv(struct ib_qp *ibqp,
 
 		wqe_idx = (hr_qp->rq.head + nreq) & (hr_qp->rq.wqe_cnt - 1);
 
-		if (unlikely(wr->num_sge > hr_qp->rq.max_gs)) {
+		if (unlikely(wr->num_sge > max_sge)) {
 			ibdev_err(ibdev, "num_sge = %d >= max_sge = %u.\n",
-				  wr->num_sge, hr_qp->rq.max_gs);
+				  wr->num_sge, max_sge);
 			ret = -EINVAL;
 			*bad_wr = wr;
 			goto out;
@@ -781,9 +783,10 @@ static int hns_roce_v2_post_recv(struct ib_qp *ibqp,
 			dseg++;
 		}
 
-		if (wr->num_sge < hr_qp->rq.max_gs) {
+		if (hr_qp->rq.rsv_sge) {
 			dseg->lkey = cpu_to_le32(HNS_ROCE_INVALID_LKEY);
 			dseg->addr = 0;
+			dseg->len = cpu_to_le32(HNS_ROCE_INVALID_SGE_LENGTH);
 		}
 
 		/* rq support inline data */
@@ -879,6 +882,7 @@ static int hns_roce_v2_post_srq_recv(struct ib_srq *ibsrq,
 	__le32 *srq_idx;
 	int ret = 0;
 	int wqe_idx;
+	u32 max_sge;
 	void *wqe;
 	int nreq;
 	int i;
@@ -886,9 +890,13 @@ static int hns_roce_v2_post_srq_recv(struct ib_srq *ibsrq,
 	spin_lock_irqsave(&srq->lock, flags);
 
 	ind = srq->head & (srq->wqe_cnt - 1);
+	max_sge = srq->max_gs - srq->rsv_sge;
 
 	for (nreq = 0; wr; ++nreq, wr = wr->next) {
-		if (unlikely(wr->num_sge >= srq->max_gs)) {
+		if (unlikely(wr->num_sge > max_sge)) {
+			ibdev_err(&hr_dev->ib_dev,
+				  "srq: num_sge = %d, max_sge = %u.\n",
+				  wr->num_sge, max_sge);
 			ret = -EINVAL;
 			*bad_wr = wr;
 			break;
@@ -916,9 +924,9 @@ static int hns_roce_v2_post_srq_recv(struct ib_srq *ibsrq,
 			dseg[i].addr = cpu_to_le64(wr->sg_list[i].addr);
 		}
 
-		if (wr->num_sge < srq->max_gs) {
-			dseg[i].len = 0;
-			dseg[i].lkey = cpu_to_le32(0x100);
+		if (srq->rsv_sge) {
+			dseg[i].len = cpu_to_le32(HNS_ROCE_INVALID_SGE_LENGTH);
+			dseg[i].lkey = cpu_to_le32(HNS_ROCE_INVALID_LKEY);
 			dseg[i].addr = 0;
 		}
 
@@ -1999,10 +2007,12 @@ static int hns_roce_query_pf_caps(struct hns_roce_dev *hr_dev)
 	caps->max_sq_sg		     = le16_to_cpu(resp_a->max_sq_sg);
 	caps->max_sq_inline	     = le16_to_cpu(resp_a->max_sq_inline);
 	caps->max_rq_sg		     = le16_to_cpu(resp_a->max_rq_sg);
+	caps->max_rq_sg = roundup_pow_of_two(caps->max_rq_sg);
 	caps->max_extend_sg	     = le32_to_cpu(resp_a->max_extend_sg);
 	caps->num_qpc_timer	     = le16_to_cpu(resp_a->num_qpc_timer);
 	caps->num_cqc_timer	     = le16_to_cpu(resp_a->num_cqc_timer);
 	caps->max_srq_sges	     = le16_to_cpu(resp_a->max_srq_sges);
+	caps->max_srq_sges = roundup_pow_of_two(caps->max_srq_sges);
 	caps->num_aeq_vectors	     = resp_a->num_aeq_vectors;
 	caps->num_other_vectors	     = resp_a->num_other_vectors;
 	caps->max_sq_desc_sz	     = resp_a->max_sq_desc_sz;
@@ -5071,7 +5081,7 @@ static int hns_roce_v2_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
 done:
 	qp_attr->cur_qp_state = qp_attr->qp_state;
 	qp_attr->cap.max_recv_wr = hr_qp->rq.wqe_cnt;
-	qp_attr->cap.max_recv_sge = hr_qp->rq.max_gs;
+	qp_attr->cap.max_recv_sge = hr_qp->rq.max_gs - hr_qp->rq.rsv_sge;
 
 	if (!ibqp->uobject) {
 		qp_attr->cap.max_send_wr = hr_qp->sq.wqe_cnt;
@@ -5383,7 +5393,7 @@ static int hns_roce_v2_query_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr)
 
 	attr->srq_limit = limit_wl;
 	attr->max_wr = srq->wqe_cnt - 1;
-	attr->max_sge = srq->max_gs;
+	attr->max_sge = srq->max_gs - srq->rsv_sge;
 
 out:
 	hns_roce_free_cmd_mailbox(hr_dev, mailbox);
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index 69bc072..cd9abdd 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -96,7 +96,8 @@
 #define HNS_ROCE_V2_CQC_TIMER_ENTRY_SZ		PAGE_SIZE
 #define HNS_ROCE_V2_PAGE_SIZE_SUPPORTED		0xFFFFF000
 #define HNS_ROCE_V2_MAX_INNER_MTPT_NUM		2
-#define HNS_ROCE_INVALID_LKEY			0x100
+#define HNS_ROCE_INVALID_LKEY			0x0
+#define HNS_ROCE_INVALID_SGE_LENGTH		0x80000000
 #define HNS_ROCE_CMQ_TX_TIMEOUT			30000
 #define HNS_ROCE_V2_UC_RC_SGE_NUM_IN_WQE	2
 #define HNS_ROCE_V2_RSV_QPS			8
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 9988ca9..8af411f 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -413,9 +413,32 @@ static void free_qpn(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
 	spin_unlock(&hr_dev->qp_table.bank_lock);
 }
 
+static u32 proc_rq_sge(struct hns_roce_dev *dev, struct hns_roce_qp *hr_qp,
+		       bool user)
+{
+	u32 max_sge = dev->caps.max_rq_sg;
+
+	if (dev->pci_dev->revision >= PCI_REVISION_ID_HIP09)
+		return max_sge;
+
+	/* Reserve SGEs only for HIP08 in kernel; The userspace driver will
+	 * calculate number of max_sge with reserved SGEs when allocating wqe
+	 * buf, so there is no need to do this again in kernel. But the number
+	 * may exceed the capacity of SGEs recorded in the firmware, so the
+	 * kernel driver should just adapt the value accordingly.
+	 */
+	if (user)
+		max_sge = roundup_pow_of_two(max_sge + 1);
+	else
+		hr_qp->rq.rsv_sge = 1;
+
+	return max_sge;
+}
+
 static int set_rq_size(struct hns_roce_dev *hr_dev, struct ib_qp_cap *cap,
-		       struct hns_roce_qp *hr_qp, int has_rq)
+		       struct hns_roce_qp *hr_qp, int has_rq, bool user)
 {
+	u32 max_sge = proc_rq_sge(hr_dev, hr_qp, user);
 	u32 cnt;
 
 	/* If srq exist, set zero for relative number of rq */
@@ -431,8 +454,9 @@ static int set_rq_size(struct hns_roce_dev *hr_dev, struct ib_qp_cap *cap,
 
 	/* Check the validity of QP support capacity */
 	if (!cap->max_recv_wr || cap->max_recv_wr > hr_dev->caps.max_wqes ||
-	    cap->max_recv_sge > hr_dev->caps.max_rq_sg) {
-		ibdev_err(&hr_dev->ib_dev, "RQ config error, depth=%u, sge=%d\n",
+	    cap->max_recv_sge > max_sge) {
+		ibdev_err(&hr_dev->ib_dev,
+			  "RQ config error, depth = %u, sge = %u\n",
 			  cap->max_recv_wr, cap->max_recv_sge);
 		return -EINVAL;
 	}
@@ -444,7 +468,8 @@ static int set_rq_size(struct hns_roce_dev *hr_dev, struct ib_qp_cap *cap,
 		return -EINVAL;
 	}
 
-	hr_qp->rq.max_gs = roundup_pow_of_two(max(1U, cap->max_recv_sge));
+	hr_qp->rq.max_gs = roundup_pow_of_two(max(1U, cap->max_recv_sge) +
+					      hr_qp->rq.rsv_sge);
 
 	if (hr_dev->caps.max_rq_sg <= HNS_ROCE_SGE_IN_WQE)
 		hr_qp->rq.wqe_shift = ilog2(hr_dev->caps.max_rq_desc_sz);
@@ -459,7 +484,7 @@ static int set_rq_size(struct hns_roce_dev *hr_dev, struct ib_qp_cap *cap,
 		hr_qp->rq_inl_buf.wqe_cnt = 0;
 
 	cap->max_recv_wr = cnt;
-	cap->max_recv_sge = hr_qp->rq.max_gs;
+	cap->max_recv_sge = hr_qp->rq.max_gs - hr_qp->rq.rsv_sge;
 
 	return 0;
 }
@@ -918,7 +943,7 @@ static int set_qp_param(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 		hr_qp->sq_signal_bits = IB_SIGNAL_REQ_WR;
 
 	ret = set_rq_size(hr_dev, &init_attr->cap, hr_qp,
-			  hns_roce_qp_has_rq(init_attr));
+			  hns_roce_qp_has_rq(init_attr), !!udata);
 	if (ret) {
 		ibdev_err(ibdev, "failed to set user RQ size, ret = %d.\n",
 			  ret);
diff --git a/drivers/infiniband/hw/hns/hns_roce_srq.c b/drivers/infiniband/hw/hns/hns_roce_srq.c
index 9403828..1be6812 100644
--- a/drivers/infiniband/hw/hns/hns_roce_srq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_srq.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2018 Hisilicon Limited.
  */
 
+#include <linux/pci.h>
 #include <rdma/ib_umem.h>
 #include "hns_roce_device.h"
 #include "hns_roce_cmd.h"
@@ -277,6 +278,28 @@ static void free_srq_wrid(struct hns_roce_srq *srq)
 	srq->wrid = NULL;
 }
 
+static u32 proc_srq_sge(struct hns_roce_dev *dev, struct hns_roce_srq *hr_srq,
+			bool user)
+{
+	u32 max_sge = dev->caps.max_srq_sges;
+
+	if (dev->pci_dev->revision >= PCI_REVISION_ID_HIP09)
+		return max_sge;
+
+	/* Reserve SGEs only for HIP08 in kernel; The userspace driver will
+	 * calculate number of max_sge with reserved SGEs when allocating wqe
+	 * buf, so there is no need to do this again in kernel. But the number
+	 * may exceed the capacity of SGEs recorded in the firmware, so the
+	 * kernel driver should just adapt the value accordingly.
+	 */
+	if (user)
+		max_sge = roundup_pow_of_two(max_sge + 1);
+	else
+		hr_srq->rsv_sge = 1;
+
+	return max_sge;
+}
+
 int hns_roce_create_srq(struct ib_srq *ib_srq,
 			struct ib_srq_init_attr *init_attr,
 			struct ib_udata *udata)
@@ -286,6 +309,7 @@ int hns_roce_create_srq(struct ib_srq *ib_srq,
 	struct hns_roce_srq *srq = to_hr_srq(ib_srq);
 	struct ib_device *ibdev = &hr_dev->ib_dev;
 	struct hns_roce_ib_create_srq ucmd = {};
+	u32 max_sge;
 	int ret;
 	u32 cqn;
 
@@ -293,16 +317,24 @@ int hns_roce_create_srq(struct ib_srq *ib_srq,
 	    init_attr->srq_type != IB_SRQT_XRC)
 		return -EOPNOTSUPP;
 
-	/* Check the actual SRQ wqe and SRQ sge num */
+	max_sge = proc_srq_sge(hr_dev, srq, !!udata);
+
 	if (init_attr->attr.max_wr >= hr_dev->caps.max_srq_wrs ||
-	    init_attr->attr.max_sge > hr_dev->caps.max_srq_sges)
+	    init_attr->attr.max_sge > max_sge) {
+		ibdev_err(&hr_dev->ib_dev,
+			  "SRQ config error, depth = %u, sge = %d\n",
+			  init_attr->attr.max_wr, init_attr->attr.max_sge);
 		return -EINVAL;
+	}
 
 	mutex_init(&srq->mutex);
 	spin_lock_init(&srq->lock);
 
 	srq->wqe_cnt = roundup_pow_of_two(init_attr->attr.max_wr + 1);
-	srq->max_gs = init_attr->attr.max_sge;
+	srq->max_gs =
+		roundup_pow_of_two(init_attr->attr.max_sge + srq->rsv_sge);
+	init_attr->attr.max_wr = srq->wqe_cnt;
+	init_attr->attr.max_sge = srq->max_gs;
 
 	if (udata) {
 		ret = ib_copy_from_udata(&ucmd, udata,
@@ -349,6 +381,8 @@ int hns_roce_create_srq(struct ib_srq *ib_srq,
 
 	srq->event = hns_roce_ib_srq_event;
 	resp.srqn = srq->srqn;
+	srq->max_gs = init_attr->attr.max_sge;
+	init_attr->attr.max_sge = srq->max_gs - srq->rsv_sge;
 
 	if (udata) {
 		ret = ib_copy_to_udata(udata, &resp,
-- 
2.8.1

