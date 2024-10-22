Return-Path: <linux-rdma+bounces-5474-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E54B9AA0F7
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Oct 2024 13:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F4A91C22078
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Oct 2024 11:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D618719B5BE;
	Tue, 22 Oct 2024 11:16:37 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A472199FAB;
	Tue, 22 Oct 2024 11:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729595797; cv=none; b=TrFoKxT+e7Y6jT3dOAbG+87kbZ/aKlKqfZfXzZ8YEwyP4hL5bs+zwZ4dIaQtuVKThOoBExbGaeAa8M5P4L4Wmz0k0qXxF1DEKQ3nHaC8bSETCKcgcIIR/LQoWUz81P/iWcMNtVFQxIOS2oI8hwZhGvhCT+cHwBXVaB8m/aA0vA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729595797; c=relaxed/simple;
	bh=fnJFw8/dw+J9LLrAwqDGjdaFaer2pfGYPU+XrXW9JRg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lxxqw/ZfGL1pdb3/cVYMy+ujImRVQNSwubSH0lBThlcvB6WWyXW7lMMjhCMFNZ2UoyoJZUzmpg27FU/udLOkYHrQOrcyms/ygY++RLhnMbZ7sFt4A6sBMWjZB3xg78eDRQWB5Ij9wthO9D54ywYW1qMgSdTasLllR5GpIJlIYMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4XXqNX2ZYyzQrl0;
	Tue, 22 Oct 2024 19:15:40 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 3D3CC140390;
	Tue, 22 Oct 2024 19:16:31 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 22 Oct 2024 19:16:30 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>,
	<tangchengchang@huawei.com>
Subject: [PATCH for-rc 1/5] RDMA/hns: Fix an AEQE overflow error caused by untimely update of eq_db_ci
Date: Tue, 22 Oct 2024 19:10:13 +0800
Message-ID: <20241022111017.946170-2-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241022111017.946170-1-huangjunxian6@hisilicon.com>
References: <20241022111017.946170-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemf100018.china.huawei.com (7.202.181.17)

From: wenglianfa <wenglianfa@huawei.com>

eq_db_ci is updated only after all AEQEs are processed in the AEQ
interrupt handler, which is not timely enough and may result in
AEQ overflow. Two optimization methods are proposed:
1. Set an upper limit for AEQE processing.
2. Move time-consuming operations such as printings to the bottom
half of the interrupt.

cmd events and flush_cqe events are still fully processed in the top half
to ensure timely handling.

Fixes: a5073d6054f7 ("RDMA/hns: Add eq support of hip08")
Signed-off-by: wenglianfa <wenglianfa@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h |  1 +
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 75 ++++++++++++++-------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  5 ++
 drivers/infiniband/hw/hns/hns_roce_qp.c     | 54 +++++++++------
 4 files changed, 91 insertions(+), 44 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 0b1e21cb6d2d..73c78005901e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -1289,6 +1289,7 @@ void hns_roce_cq_completion(struct hns_roce_dev *hr_dev, u32 cqn);
 void hns_roce_cq_event(struct hns_roce_dev *hr_dev, u32 cqn, int event_type);
 void flush_cqe(struct hns_roce_dev *dev, struct hns_roce_qp *qp);
 void hns_roce_qp_event(struct hns_roce_dev *hr_dev, u32 qpn, int event_type);
+void hns_roce_flush_cqe(struct hns_roce_dev *hr_dev, u32 qpn);
 void hns_roce_srq_event(struct hns_roce_dev *hr_dev, u32 srqn, int event_type);
 void hns_roce_handle_device_err(struct hns_roce_dev *hr_dev);
 int hns_roce_init(struct hns_roce_dev *hr_dev);
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 24e906b9d3ae..e85c450e1809 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -5967,11 +5967,10 @@ static int hns_roce_v2_query_mpt(struct hns_roce_dev *hr_dev, u32 key,
 	return ret;
 }
 
-static void hns_roce_irq_work_handle(struct work_struct *work)
+static void dump_aeqe_log(struct hns_roce_work *irq_work)
 {
-	struct hns_roce_work *irq_work =
-				container_of(work, struct hns_roce_work, work);
-	struct ib_device *ibdev = &irq_work->hr_dev->ib_dev;
+	struct hns_roce_dev *hr_dev = irq_work->hr_dev;
+	struct ib_device *ibdev = &hr_dev->ib_dev;
 
 	switch (irq_work->event_type) {
 	case HNS_ROCE_EVENT_TYPE_PATH_MIG:
@@ -6015,6 +6014,8 @@ static void hns_roce_irq_work_handle(struct work_struct *work)
 	case HNS_ROCE_EVENT_TYPE_DB_OVERFLOW:
 		ibdev_warn(ibdev, "DB overflow.\n");
 		break;
+	case HNS_ROCE_EVENT_TYPE_MB:
+		break;
 	case HNS_ROCE_EVENT_TYPE_FLR:
 		ibdev_warn(ibdev, "function level reset.\n");
 		break;
@@ -6025,8 +6026,46 @@ static void hns_roce_irq_work_handle(struct work_struct *work)
 		ibdev_err(ibdev, "invalid xrceth error.\n");
 		break;
 	default:
+		ibdev_info(ibdev, "Undefined event %d.\n",
+			   irq_work->event_type);
 		break;
 	}
+}
+
+static void hns_roce_irq_work_handle(struct work_struct *work)
+{
+	struct hns_roce_work *irq_work =
+				container_of(work, struct hns_roce_work, work);
+	struct hns_roce_dev *hr_dev = irq_work->hr_dev;
+	int event_type = irq_work->event_type;
+	u32 queue_num = irq_work->queue_num;
+
+	switch (event_type) {
+	case HNS_ROCE_EVENT_TYPE_PATH_MIG:
+	case HNS_ROCE_EVENT_TYPE_PATH_MIG_FAILED:
+	case HNS_ROCE_EVENT_TYPE_COMM_EST:
+	case HNS_ROCE_EVENT_TYPE_SQ_DRAINED:
+	case HNS_ROCE_EVENT_TYPE_WQ_CATAS_ERROR:
+	case HNS_ROCE_EVENT_TYPE_SRQ_LAST_WQE_REACH:
+	case HNS_ROCE_EVENT_TYPE_INV_REQ_LOCAL_WQ_ERROR:
+	case HNS_ROCE_EVENT_TYPE_LOCAL_WQ_ACCESS_ERROR:
+	case HNS_ROCE_EVENT_TYPE_XRCD_VIOLATION:
+	case HNS_ROCE_EVENT_TYPE_INVALID_XRCETH:
+		hns_roce_qp_event(hr_dev, queue_num, event_type);
+		break;
+	case HNS_ROCE_EVENT_TYPE_SRQ_LIMIT_REACH:
+	case HNS_ROCE_EVENT_TYPE_SRQ_CATAS_ERROR:
+		hns_roce_srq_event(hr_dev, queue_num, event_type);
+		break;
+	case HNS_ROCE_EVENT_TYPE_CQ_ACCESS_ERROR:
+	case HNS_ROCE_EVENT_TYPE_CQ_OVERFLOW:
+		hns_roce_cq_event(hr_dev, queue_num, event_type);
+		break;
+	default:
+		break;
+	}
+
+	dump_aeqe_log(irq_work);
 
 	kfree(irq_work);
 }
@@ -6087,14 +6126,14 @@ static struct hns_roce_aeqe *next_aeqe_sw_v2(struct hns_roce_eq *eq)
 static irqreturn_t hns_roce_v2_aeq_int(struct hns_roce_dev *hr_dev,
 				       struct hns_roce_eq *eq)
 {
-	struct device *dev = hr_dev->dev;
 	struct hns_roce_aeqe *aeqe = next_aeqe_sw_v2(eq);
 	irqreturn_t aeqe_found = IRQ_NONE;
+	int num_aeqes = 0;
 	int event_type;
 	u32 queue_num;
 	int sub_type;
 
-	while (aeqe) {
+	while (aeqe && num_aeqes < HNS_AEQ_POLLING_BUDGET) {
 		/* Make sure we read AEQ entry after we have checked the
 		 * ownership bit
 		 */
@@ -6105,25 +6144,12 @@ static irqreturn_t hns_roce_v2_aeq_int(struct hns_roce_dev *hr_dev,
 		queue_num = hr_reg_read(aeqe, AEQE_EVENT_QUEUE_NUM);
 
 		switch (event_type) {
-		case HNS_ROCE_EVENT_TYPE_PATH_MIG:
-		case HNS_ROCE_EVENT_TYPE_PATH_MIG_FAILED:
-		case HNS_ROCE_EVENT_TYPE_COMM_EST:
-		case HNS_ROCE_EVENT_TYPE_SQ_DRAINED:
 		case HNS_ROCE_EVENT_TYPE_WQ_CATAS_ERROR:
-		case HNS_ROCE_EVENT_TYPE_SRQ_LAST_WQE_REACH:
 		case HNS_ROCE_EVENT_TYPE_INV_REQ_LOCAL_WQ_ERROR:
 		case HNS_ROCE_EVENT_TYPE_LOCAL_WQ_ACCESS_ERROR:
 		case HNS_ROCE_EVENT_TYPE_XRCD_VIOLATION:
 		case HNS_ROCE_EVENT_TYPE_INVALID_XRCETH:
-			hns_roce_qp_event(hr_dev, queue_num, event_type);
-			break;
-		case HNS_ROCE_EVENT_TYPE_SRQ_LIMIT_REACH:
-		case HNS_ROCE_EVENT_TYPE_SRQ_CATAS_ERROR:
-			hns_roce_srq_event(hr_dev, queue_num, event_type);
-			break;
-		case HNS_ROCE_EVENT_TYPE_CQ_ACCESS_ERROR:
-		case HNS_ROCE_EVENT_TYPE_CQ_OVERFLOW:
-			hns_roce_cq_event(hr_dev, queue_num, event_type);
+			hns_roce_flush_cqe(hr_dev, queue_num);
 			break;
 		case HNS_ROCE_EVENT_TYPE_MB:
 			hns_roce_cmd_event(hr_dev,
@@ -6131,12 +6157,7 @@ static irqreturn_t hns_roce_v2_aeq_int(struct hns_roce_dev *hr_dev,
 					aeqe->event.cmd.status,
 					le64_to_cpu(aeqe->event.cmd.out_param));
 			break;
-		case HNS_ROCE_EVENT_TYPE_DB_OVERFLOW:
-		case HNS_ROCE_EVENT_TYPE_FLR:
-			break;
 		default:
-			dev_err(dev, "unhandled event %d on EQ %d at idx %u.\n",
-				event_type, eq->eqn, eq->cons_index);
 			break;
 		}
 
@@ -6150,6 +6171,7 @@ static irqreturn_t hns_roce_v2_aeq_int(struct hns_roce_dev *hr_dev,
 		hns_roce_v2_init_irq_work(hr_dev, eq, queue_num);
 
 		aeqe = next_aeqe_sw_v2(eq);
+		++num_aeqes;
 	}
 
 	update_eq_db(eq);
@@ -6699,6 +6721,9 @@ static int hns_roce_v2_init_eq_table(struct hns_roce_dev *hr_dev)
 	int ret;
 	int i;
 
+	if (hr_dev->caps.aeqe_depth < HNS_AEQ_POLLING_BUDGET)
+		return -EINVAL;
+
 	other_num = hr_dev->caps.num_other_vectors;
 	comp_num = hr_dev->caps.num_comp_vectors;
 	aeq_num = hr_dev->caps.num_aeq_vectors;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index c65f68a14a26..3b3c6259ace0 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -85,6 +85,11 @@
 
 #define HNS_ROCE_V2_TABLE_CHUNK_SIZE		(1 << 18)
 
+/* budget must be smaller than aeqe_depth to guarantee that we update
+ * the ci before we polled all the entries in the EQ.
+ */
+#define HNS_AEQ_POLLING_BUDGET 64
+
 enum {
 	HNS_ROCE_CMD_FLAG_IN = BIT(0),
 	HNS_ROCE_CMD_FLAG_OUT = BIT(1),
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 6b03ba671ff8..dcaa370d4a26 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -39,6 +39,25 @@
 #include "hns_roce_device.h"
 #include "hns_roce_hem.h"
 
+static struct hns_roce_qp *hns_roce_qp_lookup(struct hns_roce_dev *hr_dev,
+					      u32 qpn)
+{
+	struct device *dev = hr_dev->dev;
+	struct hns_roce_qp *qp;
+	unsigned long flags;
+
+	xa_lock_irqsave(&hr_dev->qp_table_xa, flags);
+	qp = __hns_roce_qp_lookup(hr_dev, qpn);
+	if (qp)
+		refcount_inc(&qp->refcount);
+	xa_unlock_irqrestore(&hr_dev->qp_table_xa, flags);
+
+	if (!qp)
+		dev_warn(dev, "async event for bogus QP %08x\n", qpn);
+
+	return qp;
+}
+
 static void flush_work_handle(struct work_struct *work)
 {
 	struct hns_roce_work *flush_work = container_of(work,
@@ -95,31 +114,28 @@ void flush_cqe(struct hns_roce_dev *dev, struct hns_roce_qp *qp)
 
 void hns_roce_qp_event(struct hns_roce_dev *hr_dev, u32 qpn, int event_type)
 {
-	struct device *dev = hr_dev->dev;
 	struct hns_roce_qp *qp;
 
-	xa_lock(&hr_dev->qp_table_xa);
-	qp = __hns_roce_qp_lookup(hr_dev, qpn);
-	if (qp)
-		refcount_inc(&qp->refcount);
-	xa_unlock(&hr_dev->qp_table_xa);
-
-	if (!qp) {
-		dev_warn(dev, "async event for bogus QP %08x\n", qpn);
+	qp = hns_roce_qp_lookup(hr_dev, qpn);
+	if (!qp)
 		return;
-	}
 
-	if (event_type == HNS_ROCE_EVENT_TYPE_WQ_CATAS_ERROR ||
-	    event_type == HNS_ROCE_EVENT_TYPE_INV_REQ_LOCAL_WQ_ERROR ||
-	    event_type == HNS_ROCE_EVENT_TYPE_LOCAL_WQ_ACCESS_ERROR ||
-	    event_type == HNS_ROCE_EVENT_TYPE_XRCD_VIOLATION ||
-	    event_type == HNS_ROCE_EVENT_TYPE_INVALID_XRCETH) {
-		qp->state = IB_QPS_ERR;
+	qp->event(qp, (enum hns_roce_event)event_type);
 
-		flush_cqe(hr_dev, qp);
-	}
+	if (refcount_dec_and_test(&qp->refcount))
+		complete(&qp->free);
+}
 
-	qp->event(qp, (enum hns_roce_event)event_type);
+void hns_roce_flush_cqe(struct hns_roce_dev *hr_dev, u32 qpn)
+{
+	struct hns_roce_qp *qp;
+
+	qp = hns_roce_qp_lookup(hr_dev, qpn);
+	if (!qp)
+		return;
+
+	qp->state = IB_QPS_ERR;
+	flush_cqe(hr_dev, qp);
 
 	if (refcount_dec_and_test(&qp->refcount))
 		complete(&qp->free);
-- 
2.33.0


