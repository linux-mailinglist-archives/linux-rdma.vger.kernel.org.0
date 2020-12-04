Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E96C2CEC67
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Dec 2020 11:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387556AbgLDKnx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Dec 2020 05:43:53 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8699 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729419AbgLDKnx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 4 Dec 2020 05:43:53 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CnTlz5x6Lzkkfs;
        Fri,  4 Dec 2020 18:41:51 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Fri, 4 Dec 2020 18:42:21 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH v2 for-next 11/11] RDMA/hns: Simplify AEQE process for different types of queue
Date:   Fri, 4 Dec 2020 18:40:36 +0800
Message-ID: <1607078436-26455-12-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1607078436-26455-1-git-send-email-liweihang@huawei.com>
References: <1607078436-26455-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yixian Liu <liuyixian@huawei.com>

There is no need to get queue number repeatly for different queues from an
AEQE entity, as they are the same. Furthermore, redefine the AEQE structure
to make the codes more readable.

In addition, HNS_ROCE_EVENT_TYPE_CEQ_OVERFLOW is removed because the
hardware never reports this event.

Signed-off-by: Yixian Liu <liuyixian@huawei.com>
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h | 26 ++---------------
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c  | 16 ++++-------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 43 ++++++++++-------------------
 3 files changed, 23 insertions(+), 62 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index af73086..42a93c8 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -169,7 +169,6 @@ enum hns_roce_event {
 	/* 0x10 and 0x11 is unused in currently application case */
 	HNS_ROCE_EVENT_TYPE_DB_OVERFLOW               = 0x12,
 	HNS_ROCE_EVENT_TYPE_MB                        = 0x13,
-	HNS_ROCE_EVENT_TYPE_CEQ_OVERFLOW              = 0x14,
 	HNS_ROCE_EVENT_TYPE_FLR			      = 0x15,
 };
 
@@ -645,10 +644,9 @@ enum {
 struct hns_roce_work {
 	struct hns_roce_dev *hr_dev;
 	struct work_struct work;
-	u32 qpn;
-	u32 cqn;
 	int event_type;
 	int sub_type;
+	u32 queue_num;
 };
 
 struct hns_roce_qp {
@@ -716,28 +714,10 @@ struct hns_roce_aeqe {
 	__le32 asyn;
 	union {
 		struct {
-			__le32 qp;
+			__le32 num;
 			u32 rsv0;
 			u32 rsv1;
-		} qp_event;
-
-		struct {
-			__le32 srq;
-			u32 rsv0;
-			u32 rsv1;
-		} srq_event;
-
-		struct {
-			__le32 cq;
-			u32 rsv0;
-			u32 rsv1;
-		} cq_event;
-
-		struct {
-			__le32 ceqe;
-			u32 rsv0;
-			u32 rsv1;
-		} ce_event;
+		} queue_event;
 
 		struct {
 			__le64  out_param;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
index b7dd867..cc20231 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -3683,10 +3683,10 @@ static void hns_roce_v1_qp_err_handle(struct hns_roce_dev *hr_dev,
 	int phy_port;
 	int qpn;
 
-	qpn = roce_get_field(aeqe->event.qp_event.qp,
+	qpn = roce_get_field(aeqe->event.queue_event.num,
 			     HNS_ROCE_AEQE_EVENT_QP_EVENT_QP_QPN_M,
 			     HNS_ROCE_AEQE_EVENT_QP_EVENT_QP_QPN_S);
-	phy_port = roce_get_field(aeqe->event.qp_event.qp,
+	phy_port = roce_get_field(aeqe->event.queue_event.num,
 				  HNS_ROCE_AEQE_EVENT_QP_EVENT_PORT_NUM_M,
 				  HNS_ROCE_AEQE_EVENT_QP_EVENT_PORT_NUM_S);
 	if (qpn <= 1)
@@ -3717,9 +3717,9 @@ static void hns_roce_v1_cq_err_handle(struct hns_roce_dev *hr_dev,
 	struct device *dev = &hr_dev->pdev->dev;
 	u32 cqn;
 
-	cqn = roce_get_field(aeqe->event.cq_event.cq,
-			  HNS_ROCE_AEQE_EVENT_CQ_EVENT_CQ_CQN_M,
-			  HNS_ROCE_AEQE_EVENT_CQ_EVENT_CQ_CQN_S);
+	cqn = roce_get_field(aeqe->event.queue_event.num,
+			     HNS_ROCE_AEQE_EVENT_CQ_EVENT_CQ_CQN_M,
+			     HNS_ROCE_AEQE_EVENT_CQ_EVENT_CQ_CQN_S);
 
 	switch (event_type) {
 	case HNS_ROCE_EVENT_TYPE_CQ_ACCESS_ERROR:
@@ -3848,12 +3848,6 @@ static int hns_roce_v1_aeq_int(struct hns_roce_dev *hr_dev,
 		case HNS_ROCE_EVENT_TYPE_DB_OVERFLOW:
 			hns_roce_v1_db_overflow_handle(hr_dev, aeqe);
 			break;
-		case HNS_ROCE_EVENT_TYPE_CEQ_OVERFLOW:
-			dev_warn(dev, "CEQ 0x%lx overflow.\n",
-			roce_get_field(aeqe->event.ce_event.ceqe,
-				     HNS_ROCE_AEQE_EVENT_CE_EVENT_CEQE_CEQN_M,
-				     HNS_ROCE_AEQE_EVENT_CE_EVENT_CEQE_CEQN_S));
-			break;
 		default:
 			dev_warn(dev, "Unhandled event %d on EQ %d at idx %u.\n",
 				 event_type, eq->eqn, eq->cons_index);
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 7f4e725..dca0f60 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -5446,8 +5446,6 @@ static void hns_roce_irq_work_handle(struct work_struct *work)
 	struct hns_roce_work *irq_work =
 				container_of(work, struct hns_roce_work, work);
 	struct ib_device *ibdev = &irq_work->hr_dev->ib_dev;
-	u32 qpn = irq_work->qpn;
-	u32 cqn = irq_work->cqn;
 
 	switch (irq_work->event_type) {
 	case HNS_ROCE_EVENT_TYPE_PATH_MIG:
@@ -5463,15 +5461,15 @@ static void hns_roce_irq_work_handle(struct work_struct *work)
 		break;
 	case HNS_ROCE_EVENT_TYPE_WQ_CATAS_ERROR:
 		ibdev_err(ibdev, "Local work queue 0x%x catast error, sub_event type is: %d\n",
-			  qpn, irq_work->sub_type);
+			  irq_work->queue_num, irq_work->sub_type);
 		break;
 	case HNS_ROCE_EVENT_TYPE_INV_REQ_LOCAL_WQ_ERROR:
 		ibdev_err(ibdev, "Invalid request local work queue 0x%x error.\n",
-			  qpn);
+			  irq_work->queue_num);
 		break;
 	case HNS_ROCE_EVENT_TYPE_LOCAL_WQ_ACCESS_ERROR:
 		ibdev_err(ibdev, "Local access violation work queue 0x%x error, sub_event type is: %d\n",
-			  qpn, irq_work->sub_type);
+			  irq_work->queue_num, irq_work->sub_type);
 		break;
 	case HNS_ROCE_EVENT_TYPE_SRQ_LIMIT_REACH:
 		ibdev_warn(ibdev, "SRQ limit reach.\n");
@@ -5483,10 +5481,10 @@ static void hns_roce_irq_work_handle(struct work_struct *work)
 		ibdev_err(ibdev, "SRQ catas error.\n");
 		break;
 	case HNS_ROCE_EVENT_TYPE_CQ_ACCESS_ERROR:
-		ibdev_err(ibdev, "CQ 0x%x access err.\n", cqn);
+		ibdev_err(ibdev, "CQ 0x%x access err.\n", irq_work->queue_num);
 		break;
 	case HNS_ROCE_EVENT_TYPE_CQ_OVERFLOW:
-		ibdev_warn(ibdev, "CQ 0x%x overflow\n", cqn);
+		ibdev_warn(ibdev, "CQ 0x%x overflow\n", irq_work->queue_num);
 		break;
 	case HNS_ROCE_EVENT_TYPE_DB_OVERFLOW:
 		ibdev_warn(ibdev, "DB overflow.\n");
@@ -5502,8 +5500,7 @@ static void hns_roce_irq_work_handle(struct work_struct *work)
 }
 
 static void hns_roce_v2_init_irq_work(struct hns_roce_dev *hr_dev,
-				      struct hns_roce_eq *eq,
-				      u32 qpn, u32 cqn)
+				      struct hns_roce_eq *eq, u32 queue_num)
 {
 	struct hns_roce_work *irq_work;
 
@@ -5513,10 +5510,9 @@ static void hns_roce_v2_init_irq_work(struct hns_roce_dev *hr_dev,
 
 	INIT_WORK(&(irq_work->work), hns_roce_irq_work_handle);
 	irq_work->hr_dev = hr_dev;
-	irq_work->qpn = qpn;
-	irq_work->cqn = cqn;
 	irq_work->event_type = eq->event_type;
 	irq_work->sub_type = eq->sub_type;
+	irq_work->queue_num = queue_num;
 	queue_work(hr_dev->irq_workq, &(irq_work->work));
 }
 
@@ -5568,10 +5564,8 @@ static int hns_roce_v2_aeq_int(struct hns_roce_dev *hr_dev,
 	struct hns_roce_aeqe *aeqe = next_aeqe_sw_v2(eq);
 	int aeqe_found = 0;
 	int event_type;
+	u32 queue_num;
 	int sub_type;
-	u32 srqn;
-	u32 qpn;
-	u32 cqn;
 
 	while (aeqe) {
 		/* Make sure we read AEQ entry after we have checked the
@@ -5585,15 +5579,9 @@ static int hns_roce_v2_aeq_int(struct hns_roce_dev *hr_dev,
 		sub_type = roce_get_field(aeqe->asyn,
 					  HNS_ROCE_V2_AEQE_SUB_TYPE_M,
 					  HNS_ROCE_V2_AEQE_SUB_TYPE_S);
-		qpn = roce_get_field(aeqe->event.qp_event.qp,
-				     HNS_ROCE_V2_AEQE_EVENT_QUEUE_NUM_M,
-				     HNS_ROCE_V2_AEQE_EVENT_QUEUE_NUM_S);
-		cqn = roce_get_field(aeqe->event.cq_event.cq,
-				     HNS_ROCE_V2_AEQE_EVENT_QUEUE_NUM_M,
-				     HNS_ROCE_V2_AEQE_EVENT_QUEUE_NUM_S);
-		srqn = roce_get_field(aeqe->event.srq_event.srq,
-				     HNS_ROCE_V2_AEQE_EVENT_QUEUE_NUM_M,
-				     HNS_ROCE_V2_AEQE_EVENT_QUEUE_NUM_S);
+		queue_num = roce_get_field(aeqe->event.queue_event.num,
+					   HNS_ROCE_V2_AEQE_EVENT_QUEUE_NUM_M,
+					   HNS_ROCE_V2_AEQE_EVENT_QUEUE_NUM_S);
 
 		switch (event_type) {
 		case HNS_ROCE_EVENT_TYPE_PATH_MIG:
@@ -5604,15 +5592,15 @@ static int hns_roce_v2_aeq_int(struct hns_roce_dev *hr_dev,
 		case HNS_ROCE_EVENT_TYPE_SRQ_LAST_WQE_REACH:
 		case HNS_ROCE_EVENT_TYPE_INV_REQ_LOCAL_WQ_ERROR:
 		case HNS_ROCE_EVENT_TYPE_LOCAL_WQ_ACCESS_ERROR:
-			hns_roce_qp_event(hr_dev, qpn, event_type);
+			hns_roce_qp_event(hr_dev, queue_num, event_type);
 			break;
 		case HNS_ROCE_EVENT_TYPE_SRQ_LIMIT_REACH:
 		case HNS_ROCE_EVENT_TYPE_SRQ_CATAS_ERROR:
-			hns_roce_srq_event(hr_dev, srqn, event_type);
+			hns_roce_srq_event(hr_dev, queue_num, event_type);
 			break;
 		case HNS_ROCE_EVENT_TYPE_CQ_ACCESS_ERROR:
 		case HNS_ROCE_EVENT_TYPE_CQ_OVERFLOW:
-			hns_roce_cq_event(hr_dev, cqn, event_type);
+			hns_roce_cq_event(hr_dev, queue_num, event_type);
 			break;
 		case HNS_ROCE_EVENT_TYPE_MB:
 			hns_roce_cmd_event(hr_dev,
@@ -5621,7 +5609,6 @@ static int hns_roce_v2_aeq_int(struct hns_roce_dev *hr_dev,
 					le64_to_cpu(aeqe->event.cmd.out_param));
 			break;
 		case HNS_ROCE_EVENT_TYPE_DB_OVERFLOW:
-		case HNS_ROCE_EVENT_TYPE_CEQ_OVERFLOW:
 		case HNS_ROCE_EVENT_TYPE_FLR:
 			break;
 		default:
@@ -5638,7 +5625,7 @@ static int hns_roce_v2_aeq_int(struct hns_roce_dev *hr_dev,
 		if (eq->cons_index > (2 * eq->entries - 1))
 			eq->cons_index = 0;
 
-		hns_roce_v2_init_irq_work(hr_dev, eq, qpn, cqn);
+		hns_roce_v2_init_irq_work(hr_dev, eq, queue_num);
 
 		aeqe = next_aeqe_sw_v2(eq);
 	}
-- 
2.8.1

