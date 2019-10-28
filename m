Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC040E6F4A
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2019 10:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388030AbfJ1JpR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Oct 2019 05:45:17 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:37990 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730486AbfJ1JpR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 28 Oct 2019 05:45:17 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A7ACBF952FA7275EA17C;
        Mon, 28 Oct 2019 17:45:14 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Mon, 28 Oct 2019 17:45:04 +0800
From:   Yixian Liu <liuyixian@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH for-next 1/2] RDMA/hns: Add the workqueue framework for flush cqe handler
Date:   Mon, 28 Oct 2019 17:45:44 +0800
Message-ID: <1572255945-20297-2-git-send-email-liuyixian@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1572255945-20297-1-git-send-email-liuyixian@huawei.com>
References: <1572255945-20297-1-git-send-email-liuyixian@huawei.com>
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
 drivers/infiniband/hw/hns/hns_roce_device.h | 10 +++++++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 16 +++++++++++
 drivers/infiniband/hw/hns/hns_roce_qp.c     | 43 +++++++++++++++++++++++++++++
 3 files changed, 69 insertions(+)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index cbd75e4..0d979e8 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -45,6 +45,8 @@
 
 #define HNS_ROCE_MAX_MSG_LEN			0x80000000
 
+#define HNS_ROCE_WORKQ_NAME_LEN			32
+
 #define HNS_ROCE_ALIGN_UP(a, b) ((((a) + (b) - 1) / (b)) * (b))
 
 #define HNS_ROCE_IB_MIN_SQ_STRIDE		6
@@ -921,6 +923,12 @@ struct hns_roce_work {
 	int sub_type;
 };
 
+struct hns_roce_flush_work {
+	struct hns_roce_dev *hr_dev;
+	struct work_struct work;
+	struct hns_roce_qp *hr_qp;
+};
+
 struct hns_roce_dfx_hw {
 	int (*query_cqc_info)(struct hns_roce_dev *hr_dev, u32 cqn,
 			      int *buffer);
@@ -1043,6 +1051,7 @@ struct hns_roce_dev {
 	const struct hns_roce_hw *hw;
 	void			*priv;
 	struct workqueue_struct *irq_workq;
+	struct workqueue_struct *flush_workq;
 	const struct hns_roce_dfx_hw *dfx;
 };
 
@@ -1240,6 +1249,7 @@ struct ib_qp *hns_roce_create_qp(struct ib_pd *ib_pd,
 				 struct ib_udata *udata);
 int hns_roce_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 		       int attr_mask, struct ib_udata *udata);
+void init_flush_work(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp);
 void *get_recv_wqe(struct hns_roce_qp *hr_qp, int n);
 void *get_send_wqe(struct hns_roce_qp *hr_qp, int n);
 void *get_send_extend_sge(struct hns_roce_qp *hr_qp, int n);
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 14e24b4..396c896 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1960,6 +1960,8 @@ static void hns_roce_free_link_table(struct hns_roce_dev *hr_dev,
 static int hns_roce_v2_init(struct hns_roce_dev *hr_dev)
 {
 	struct hns_roce_v2_priv *priv = hr_dev->priv;
+	char workq_name[HNS_ROCE_WORKQ_NAME_LEN];
+	static int device_id;
 	int qpc_count, cqc_count;
 	int ret, i;
 
@@ -1998,6 +2000,17 @@ static int hns_roce_v2_init(struct hns_roce_dev *hr_dev)
 		}
 	}
 
+	snprintf(workq_name, HNS_ROCE_WORKQ_NAME_LEN - 1,
+		 "hns_roce_%d_flush_wq", device_id);
+	device_id++;
+
+	hr_dev->flush_workq = alloc_workqueue(workq_name, WQ_HIGHPRI, 0);
+	if (!hr_dev->flush_workq) {
+		dev_err(hr_dev->dev, "Failed to create flush workqueue!\n");
+		ret = -ENOMEM;
+		goto err_cqc_timer_failed;
+	}
+
 	return 0;
 
 err_cqc_timer_failed:
@@ -2020,6 +2033,9 @@ static void hns_roce_v2_exit(struct hns_roce_dev *hr_dev)
 {
 	struct hns_roce_v2_priv *priv = hr_dev->priv;
 
+	flush_workqueue(hr_dev->flush_workq);
+	destroy_workqueue(hr_dev->flush_workq);
+
 	if (hr_dev->pci_dev->revision == 0x21)
 		hns_roce_function_clear(hr_dev);
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index bec48f2..2c8f726 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -43,6 +43,49 @@
 
 #define SQP_NUM				(2 * HNS_ROCE_MAX_PORTS)
 
+static void flush_work_handle(struct work_struct *work)
+{
+	struct hns_roce_flush_work *flush_work = container_of(work,
+					struct hns_roce_flush_work, work);
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
+	struct hns_roce_flush_work *flush_work;
+
+	flush_work = kzalloc(sizeof(struct hns_roce_flush_work), GFP_ATOMIC);
+	if (!flush_work)
+		return;
+
+	flush_work->hr_dev = hr_dev;
+	flush_work->hr_qp = hr_qp;
+	INIT_WORK(&flush_work->work, flush_work_handle);
+	atomic_inc(&hr_qp->refcount);
+	queue_work(hr_dev->flush_workq, &flush_work->work);
+}
+
 void hns_roce_qp_event(struct hns_roce_dev *hr_dev, u32 qpn, int event_type)
 {
 	struct device *dev = hr_dev->dev;
-- 
2.7.4

