Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE553801CE
	for <lists+linux-rdma@lfdr.de>; Fri, 14 May 2021 04:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhENCNG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 May 2021 22:13:06 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2729 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbhENCNF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 May 2021 22:13:05 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FhBm773h0z1BMNK;
        Fri, 14 May 2021 10:09:11 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Fri, 14 May 2021 10:11:43 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Weihang Li <liweihang@huawei.com>
Subject: [PATCH for-next 2/6] RDMA/hns: Use refcount_t instead of atomic_t for reference counting
Date:   Fri, 14 May 2021 10:11:35 +0800
Message-ID: <1620958299-4869-3-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1620958299-4869-1-git-send-email-liweihang@huawei.com>
References: <1620958299-4869-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The refcount_t API will WARN on underflow and overflow of a reference
counter, and avoid use-after-free risks, so the type of refcnt in
QP/CQ/SRQ is changed from atomic_t to refcount_t.

Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_cq.c     |  8 ++++----
 drivers/infiniband/hw/hns/hns_roce_device.h |  6 +++---
 drivers/infiniband/hw/hns/hns_roce_qp.c     | 12 ++++++------
 drivers/infiniband/hw/hns/hns_roce_srq.c    |  8 ++++----
 4 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_cq.c b/drivers/infiniband/hw/hns/hns_roce_cq.c
index 800884b..0763082 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cq.c
@@ -154,7 +154,7 @@ static int alloc_cqc(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq)
 	hr_cq->cons_index = 0;
 	hr_cq->arm_sn = 1;
 
-	atomic_set(&hr_cq->refcount, 1);
+	refcount_set(&hr_cq->refcount, 1);
 	init_completion(&hr_cq->free);
 
 	return 0;
@@ -188,7 +188,7 @@ static void free_cqc(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq)
 	synchronize_irq(hr_dev->eq_table.eq[hr_cq->vector].irq);
 
 	/* wait for all interrupt processed */
-	if (atomic_dec_and_test(&hr_cq->refcount))
+	if (refcount_dec_and_test(&hr_cq->refcount))
 		complete(&hr_cq->free);
 	wait_for_completion(&hr_cq->free);
 
@@ -481,7 +481,7 @@ void hns_roce_cq_event(struct hns_roce_dev *hr_dev, u32 cqn, int event_type)
 		return;
 	}
 
-	atomic_inc(&hr_cq->refcount);
+	refcount_inc(&hr_cq->refcount);
 
 	ibcq = &hr_cq->ib_cq;
 	if (ibcq->event_handler) {
@@ -491,7 +491,7 @@ void hns_roce_cq_event(struct hns_roce_dev *hr_dev, u32 cqn, int event_type)
 		ibcq->event_handler(&event, ibcq->cq_context);
 	}
 
-	if (atomic_dec_and_test(&hr_cq->refcount))
+	if (refcount_dec_and_test(&hr_cq->refcount))
 		complete(&hr_cq->free);
 }
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 97800d2..94c1268 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -446,7 +446,7 @@ struct hns_roce_cq {
 	int				cqe_size;
 	unsigned long			cqn;
 	u32				vector;
-	atomic_t			refcount;
+	refcount_t			refcount;
 	struct completion		free;
 	struct list_head		sq_list; /* all qps on this send cq */
 	struct list_head		rq_list; /* all qps on this recv cq */
@@ -473,7 +473,7 @@ struct hns_roce_srq {
 	u32			xrcdn;
 	void __iomem		*db_reg;
 
-	atomic_t		refcount;
+	refcount_t		refcount;
 	struct completion	free;
 
 	struct hns_roce_mtr	buf_mtr;
@@ -642,7 +642,7 @@ struct hns_roce_qp {
 
 	u32			xrcdn;
 
-	atomic_t		refcount;
+	refcount_t		refcount;
 	struct completion	free;
 
 	struct hns_roce_sge	sge;
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 230a909..6988ffa 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -65,7 +65,7 @@ static void flush_work_handle(struct work_struct *work)
 	 * make sure we signal QP destroy leg that flush QP was completed
 	 * so that it can safely proceed ahead now and destroy QP
 	 */
-	if (atomic_dec_and_test(&hr_qp->refcount))
+	if (refcount_dec_and_test(&hr_qp->refcount))
 		complete(&hr_qp->free);
 }
 
@@ -75,7 +75,7 @@ void init_flush_work(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
 
 	flush_work->hr_dev = hr_dev;
 	INIT_WORK(&flush_work->work, flush_work_handle);
-	atomic_inc(&hr_qp->refcount);
+	refcount_inc(&hr_qp->refcount);
 	queue_work(hr_dev->irq_workq, &flush_work->work);
 }
 
@@ -87,7 +87,7 @@ void hns_roce_qp_event(struct hns_roce_dev *hr_dev, u32 qpn, int event_type)
 	xa_lock(&hr_dev->qp_table_xa);
 	qp = __hns_roce_qp_lookup(hr_dev, qpn);
 	if (qp)
-		atomic_inc(&qp->refcount);
+		refcount_inc(&qp->refcount);
 	xa_unlock(&hr_dev->qp_table_xa);
 
 	if (!qp) {
@@ -108,7 +108,7 @@ void hns_roce_qp_event(struct hns_roce_dev *hr_dev, u32 qpn, int event_type)
 
 	qp->event(qp, (enum hns_roce_event)event_type);
 
-	if (atomic_dec_and_test(&qp->refcount))
+	if (refcount_dec_and_test(&qp->refcount))
 		complete(&qp->free);
 }
 
@@ -1076,7 +1076,7 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 
 	hr_qp->ibqp.qp_num = hr_qp->qpn;
 	hr_qp->event = hns_roce_ib_qp_event;
-	atomic_set(&hr_qp->refcount, 1);
+	refcount_set(&hr_qp->refcount, 1);
 	init_completion(&hr_qp->free);
 
 	return 0;
@@ -1099,7 +1099,7 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 void hns_roce_qp_destroy(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 			 struct ib_udata *udata)
 {
-	if (atomic_dec_and_test(&hr_qp->refcount))
+	if (refcount_dec_and_test(&hr_qp->refcount))
 		complete(&hr_qp->free);
 	wait_for_completion(&hr_qp->free);
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_srq.c b/drivers/infiniband/hw/hns/hns_roce_srq.c
index 546d182..327f7aa 100644
--- a/drivers/infiniband/hw/hns/hns_roce_srq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_srq.c
@@ -17,7 +17,7 @@ void hns_roce_srq_event(struct hns_roce_dev *hr_dev, u32 srqn, int event_type)
 	xa_lock(&srq_table->xa);
 	srq = xa_load(&srq_table->xa, srqn & (hr_dev->caps.num_srqs - 1));
 	if (srq)
-		atomic_inc(&srq->refcount);
+		refcount_inc(&srq->refcount);
 	xa_unlock(&srq_table->xa);
 
 	if (!srq) {
@@ -27,7 +27,7 @@ void hns_roce_srq_event(struct hns_roce_dev *hr_dev, u32 srqn, int event_type)
 
 	srq->event(srq, event_type);
 
-	if (atomic_dec_and_test(&srq->refcount))
+	if (refcount_dec_and_test(&srq->refcount))
 		complete(&srq->free);
 }
 
@@ -149,7 +149,7 @@ static void free_srqc(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq)
 
 	xa_erase(&srq_table->xa, srq->srqn);
 
-	if (atomic_dec_and_test(&srq->refcount))
+	if (refcount_dec_and_test(&srq->refcount))
 		complete(&srq->free);
 	wait_for_completion(&srq->free);
 
@@ -417,7 +417,7 @@ int hns_roce_create_srq(struct ib_srq *ib_srq,
 
 	srq->db_reg = hr_dev->reg_base + SRQ_DB_REG;
 	srq->event = hns_roce_ib_srq_event;
-	atomic_set(&srq->refcount, 1);
+	refcount_set(&srq->refcount, 1);
 	init_completion(&srq->free);
 
 	return 0;
-- 
2.7.4

