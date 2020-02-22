Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC43168E3E
	for <lists+linux-rdma@lfdr.de>; Sat, 22 Feb 2020 11:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbgBVK0b (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 22 Feb 2020 05:26:31 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:43680 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727463AbgBVK0b (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 22 Feb 2020 05:26:31 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 52A36A38950018075950;
        Sat, 22 Feb 2020 18:26:26 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Sat, 22 Feb 2020 18:26:18 +0800
From:   Yixian Liu <liuyixian@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH for-next 1/2] RDMA/hns: Use flush framework for the case in aeq
Date:   Sat, 22 Feb 2020 18:25:57 +0800
Message-ID: <1582367158-27030-2-git-send-email-liuyixian@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582367158-27030-1-git-send-email-liuyixian@huawei.com>
References: <1582367158-27030-1-git-send-email-liuyixian@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

As now we already have flush framework, using it instead of current
flush process for qp error in asynchronized interrupt (aeq).

Signed-off-by: Yixian Liu <liuyixian@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 36 ------------------------------
 drivers/infiniband/hw/hns/hns_roce_qp.c    |  9 ++++++++
 2 files changed, 9 insertions(+), 36 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index dee1cc8..2c48f67 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -5186,39 +5186,6 @@ static int hns_roce_v2_modify_cq(struct ib_cq *cq, u16 cq_count, u16 cq_period)
 	return ret;
 }
 
-static void hns_roce_set_qps_to_err(struct hns_roce_dev *hr_dev, u32 qpn)
-{
-	struct hns_roce_qp *hr_qp;
-	struct ib_qp_attr attr;
-	int attr_mask;
-	int ret;
-
-	hr_qp = __hns_roce_qp_lookup(hr_dev, qpn);
-	if (!hr_qp) {
-		dev_warn(hr_dev->dev, "no hr_qp can be found!\n");
-		return;
-	}
-
-	if (hr_qp->ibqp.uobject) {
-		if (hr_qp->sdb_en == 1) {
-			hr_qp->sq.head = *(int *)(hr_qp->sdb.virt_addr);
-			if (hr_qp->rdb_en == 1)
-				hr_qp->rq.head = *(int *)(hr_qp->rdb.virt_addr);
-		} else {
-			dev_warn(hr_dev->dev, "flush cqe is unsupported in userspace!\n");
-			return;
-		}
-	}
-
-	attr_mask = IB_QP_STATE;
-	attr.qp_state = IB_QPS_ERR;
-	ret = hns_roce_v2_modify_qp(&hr_qp->ibqp, &attr, attr_mask,
-				    hr_qp->state, IB_QPS_ERR);
-	if (ret)
-		dev_err(hr_dev->dev, "failed to modify qp %d to err state.\n",
-			qpn);
-}
-
 static void hns_roce_irq_work_handle(struct work_struct *work)
 {
 	struct hns_roce_work *irq_work =
@@ -5242,17 +5209,14 @@ static void hns_roce_irq_work_handle(struct work_struct *work)
 	case HNS_ROCE_EVENT_TYPE_WQ_CATAS_ERROR:
 		dev_err(dev, "Local work queue 0x%x catas error, sub_type:%d\n",
 			qpn, irq_work->sub_type);
-		hns_roce_set_qps_to_err(irq_work->hr_dev, qpn);
 		break;
 	case HNS_ROCE_EVENT_TYPE_INV_REQ_LOCAL_WQ_ERROR:
 		dev_err(dev, "Invalid request local work queue 0x%x error.\n",
 			qpn);
-		hns_roce_set_qps_to_err(irq_work->hr_dev, qpn);
 		break;
 	case HNS_ROCE_EVENT_TYPE_LOCAL_WQ_ACCESS_ERROR:
 		dev_err(dev, "Local access violation work queue 0x%x error, sub_type:%d\n",
 			qpn, irq_work->sub_type);
-		hns_roce_set_qps_to_err(irq_work->hr_dev, qpn);
 		break;
 	case HNS_ROCE_EVENT_TYPE_SRQ_LIMIT_REACH:
 		dev_warn(dev, "SRQ limit reach.\n");
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index c52e1b0..6c3f0f7 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -98,6 +98,15 @@ void hns_roce_qp_event(struct hns_roce_dev *hr_dev, u32 qpn, int event_type)
 		return;
 	}
 
+	if (hr_dev->hw_rev != HNS_ROCE_HW_VER1 &&
+	    (event_type == HNS_ROCE_EVENT_TYPE_WQ_CATAS_ERROR ||
+	     event_type == HNS_ROCE_EVENT_TYPE_INV_REQ_LOCAL_WQ_ERROR ||
+	     event_type == HNS_ROCE_EVENT_TYPE_LOCAL_WQ_ACCESS_ERROR)) {
+		qp->state = IB_QPS_ERR;
+		if (!test_and_set_bit(HNS_ROCE_FLUSH_FLAG, &qp->flush_flag))
+			init_flush_work(hr_dev, qp);
+	}
+
 	qp->event(qp, (enum hns_roce_event)event_type);
 
 	if (atomic_dec_and_test(&qp->refcount))
-- 
2.7.4

