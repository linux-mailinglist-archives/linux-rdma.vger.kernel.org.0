Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8287613904F
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jan 2020 12:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbgAMLon (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Jan 2020 06:44:43 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8709 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726236AbgAMLon (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 13 Jan 2020 06:44:43 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id F203198C82F5435D7F86;
        Mon, 13 Jan 2020 19:44:40 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Mon, 13 Jan 2020 19:44:34 +0800
From:   Yixian Liu <liuyixian@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH v6 for-next 1/2] RDMA/hns: Add the workqueue framework for flush cqe handler
Date:   Mon, 13 Jan 2020 19:44:34 +0800
Message-ID: <1578915875-26499-2-git-send-email-liuyixian@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1578915875-26499-1-git-send-email-liuyixian@huawei.com>
References: <1578915875-26499-1-git-send-email-liuyixian@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

HiP08 RoCE hardware lacks ability(a known hardware problem) to flush
outstanding WQEs if QP state gets into errored mode for some reason.
To overcome this hardware problem and as a workaround, when QP is
detected to be in errored state during various legs like post send,
post receive etc [1], flush needs to be performed from the driver.

The earlier patch[1] sent to solve the hardware limitation explained
in the cover-letter had a bug in the software flushing leg. It
acquired mutex while modifying QP state to errored state and while
conveying it to the hardware using the mailbox. This caused leg to
sleep while holding spin-lock and caused crash.

Suggested Solution:
we have proposed to defer the flushing of the QP in the Errored state
using the workqueue to get around with the limitation of our hardware.

This patch adds the framework of the workqueue and the flush handler
function.

[1] https://patchwork.kernel.org/patch/10534271/

Signed-off-by: Yixian Liu <liuyixian@huawei.com>
Reviewed-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h |  2 ++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  3 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c     | 43 +++++++++++++++++++++++++++++
 3 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 5617434..a87a838 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -900,6 +900,7 @@ struct hns_roce_caps {
 struct hns_roce_work {
 	struct hns_roce_dev *hr_dev;
 	struct work_struct work;
+	struct hns_roce_qp *hr_qp;
 	u32 qpn;
 	u32 cqn;
 	int event_type;
@@ -1220,6 +1221,7 @@ struct ib_qp *hns_roce_create_qp(struct ib_pd *ib_pd,
 				 struct ib_udata *udata);
 int hns_roce_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 		       int attr_mask, struct ib_udata *udata);
+void init_flush_work(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp);
 void *get_recv_wqe(struct hns_roce_qp *hr_qp, int n);
 void *get_send_wqe(struct hns_roce_qp *hr_qp, int n);
 void *get_send_extend_sge(struct hns_roce_qp *hr_qp, int n);
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 1026ac6..2afcedd 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -5966,8 +5966,7 @@ static int hns_roce_v2_init_eq_table(struct hns_roce_dev *hr_dev)
 		goto err_request_irq_fail;
 	}
 
-	hr_dev->irq_workq =
-		create_singlethread_workqueue("hns_roce_irq_workqueue");
+	hr_dev->irq_workq = alloc_ordered_workqueue("hns_roce_irq_workq", 0);
 	if (!hr_dev->irq_workq) {
 		dev_err(dev, "Create irq workqueue failed!\n");
 		ret = -ENOMEM;
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index a6565b6..0c1e74a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -43,6 +43,49 @@
 
 #define SQP_NUM				(2 * HNS_ROCE_MAX_PORTS)
 
+static void flush_work_handle(struct work_struct *work)
+{
+	struct hns_roce_work *flush_work = container_of(work,
+					struct hns_roce_work, work);
+	struct hns_roce_qp *hr_qp = flush_work->hr_qp;
+	struct device *dev = flush_work->hr_dev->dev;
+	struct ib_qp_attr attr;
+	int attr_mask;
+	int ret;
+
+	attr_mask = IB_QP_STATE;
+	attr.qp_state = IB_QPS_ERR;
+
+	ret = hns_roce_modify_qp(&hr_qp->ibqp, &attr, attr_mask, NULL);
+	if (ret)
+		dev_err(dev, "Modify QP to error state failed(%d) during CQE flush\n",
+			ret);
+
+	kfree(flush_work);
+
+	/*
+	 * make sure we signal QP destroy leg that flush QP was completed
+	 * so that it can safely proceed ahead now and destroy QP
+	 */
+	if (atomic_dec_and_test(&hr_qp->refcount))
+		complete(&hr_qp->free);
+}
+
+void init_flush_work(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
+{
+	struct hns_roce_work *flush_work;
+
+	flush_work = kzalloc(sizeof(struct hns_roce_work), GFP_ATOMIC);
+	if (!flush_work)
+		return;
+
+	flush_work->hr_dev = hr_dev;
+	flush_work->hr_qp = hr_qp;
+	INIT_WORK(&flush_work->work, flush_work_handle);
+	atomic_inc(&hr_qp->refcount);
+	queue_work(hr_dev->irq_workq, &flush_work->work);
+}
+
 void hns_roce_qp_event(struct hns_roce_dev *hr_dev, u32 qpn, int event_type)
 {
 	struct device *dev = hr_dev->dev;
-- 
2.7.4

