Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08743AA34A
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Sep 2019 14:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387435AbfIEMef (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Sep 2019 08:34:35 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6225 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731438AbfIEMee (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 5 Sep 2019 08:34:34 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A5A44CB3963904EA232C;
        Thu,  5 Sep 2019 20:34:31 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Thu, 5 Sep 2019 20:34:25 +0800
From:   Weihang Li <liweihang@hisilicon.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH for-next] RDMA/hns: Bugfix for flush cqe in case softirq and multi-process
Date:   Thu, 5 Sep 2019 20:31:11 +0800
Message-ID: <1567686671-4331-1-git-send-email-liweihang@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yixian Liu <liuyixian@huawei.com>

Hip08 has the feature flush cqe, which help to flush wqe in workqueue
(sq and rq) when error happened by transmitting producer index with
mailbox to hardware. Flush cqe is emplemented in post send and recv
verbs. However, under NVMe cases, these verbs will be called under
softirq context, and it will lead to following calltrace with
current driver as mailbox used by flush cqe can go to sleep.

This patch solves this problem by using workqueue to do flush cqe,
then hip08 can support NVMe case.

[ 5343.812237] Call trace:
[ 5343.815448] [<ffff00000808ab38>] dump_backtrace+0x0/0x280
[ 5343.821115] [<ffff00000808addc>] show_stack+0x24/0x30
[ 5343.826605] [<ffff000008d84cb4>] dump_stack+0x98/0xb8
[ 5343.831966] [<ffff0000080fda44>] __schedule_bug+0x64/0x80
[ 5343.837605] [<ffff000008d9b1ec>] __schedule+0x6bc/0x7fc
[ 5343.843010] [<ffff000008d9b360>] schedule+0x34/0x8c
[ 5343.848133] [<ffff000008d9ee80>] schedule_timeout+0x1d8/0x3cc
[ 5343.854087] [<ffff000008d9d72c>] __down+0x84/0xdc
[ 5343.859114] [<ffff000008124250>] down+0x54/0x6c
[ 5343.866446] [<ffff000001025bd4>] hns_roce_cmd_mbox+0x68/0x2cc [hns_roce]
[ 5343.874439] [<ffff000001063f70>] hns_roce_v2_modify_qp+0x4f4/0x1024
[hns_roce_pci]
[ 5343.882594] [<ffff00000106570c>] hns_roce_v2_post_recv+0x2a4/0x330
[hns_roce_pci]
[ 5343.890872] [<ffff0000010aa138>] nvme_rdma_post_recv+0x88/0xf8 [nvme_rdma]
[ 5343.898156] [<ffff0000010ab3a8>] __nvme_rdma_recv_done.isra.40+0x110/0x1f0
[nvme_rdma]
[ 5343.906453] [<ffff0000010ab4b4>] nvme_rdma_recv_done+0x2c/0x38 [nvme_rdma]
[ 5343.918428] [<ffff000000e34e04>] __ib_process_cq+0x7c/0xf0 [ib_core]
[ 5343.927135] [<ffff000000e34fb8>] ib_poll_handler+0x30/0x90 [ib_core]
[ 5343.933900] [<ffff00000859db94>] irq_poll_softirq+0xf8/0x150
[ 5343.939825] [<ffff0000080818d0>] __do_softirq+0x140/0x2ec
[ 5343.945573] [<ffff0000080d6f10>] run_ksoftirqd+0x48/0x5c
[ 5343.951258] [<ffff0000080f9064>] smpboot_thread_fn+0x190/0x1d4
[ 5343.957311] [<ffff0000080f441c>] kthread+0x10c/0x138
[ 5343.962518] [<ffff0000080855dc>] ret_from_fork+0x10/0x18

Fixes: 0425e3e6e0c7 ("RDMA/hns: Support flush cqe for hip08 in kernel space")

Signed-off-by: Yixian Liu <liuyixian@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h |  11 +++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 124 ++++++++++------------------
 drivers/infiniband/hw/hns/hns_roce_main.c   |  12 +++
 drivers/infiniband/hw/hns/hns_roce_qp.c     |  41 +++++++++
 4 files changed, 107 insertions(+), 81 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 96d1302..84fd70b 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -91,6 +91,7 @@
 #define HNS_ROCE_MAX_PORTS			6
 #define HNS_ROCE_MAX_GID_NUM			16
 #define HNS_ROCE_GID_SIZE			16
+#define HNS_ROCE_WORKQ_NAME_LEN			32
 #define HNS_ROCE_SGE_SIZE			16
 
 #define HNS_ROCE_HOP_NUM_0			0xff
@@ -921,6 +922,12 @@ struct hns_roce_work {
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
@@ -979,6 +986,8 @@ struct hns_roce_hw {
 	int (*modify_cq)(struct ib_cq *cq, u16 cq_count, u16 cq_period);
 	int (*init_eq)(struct hns_roce_dev *hr_dev);
 	void (*cleanup_eq)(struct hns_roce_dev *hr_dev);
+	int (*create_workq)(struct hns_roce_dev *hr_dev);
+	void (*destroy_workq)(struct hns_roce_dev *hr_dev);
 	void (*write_srqc)(struct hns_roce_dev *hr_dev,
 			   struct hns_roce_srq *srq, u32 pdn, u16 xrcd, u32 cqn,
 			   void *mb_buf, u64 *mtts_wqe, u64 *mtts_idx,
@@ -1043,6 +1052,7 @@ struct hns_roce_dev {
 	const struct hns_roce_hw *hw;
 	void			*priv;
 	struct workqueue_struct *irq_workq;
+	struct workqueue_struct *flush_workq;
 	const struct hns_roce_dfx_hw *dfx;
 };
 
@@ -1240,6 +1250,7 @@ struct ib_qp *hns_roce_create_qp(struct ib_pd *ib_pd,
 				 struct ib_udata *udata);
 int hns_roce_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 		       int attr_mask, struct ib_udata *udata);
+void init_flush_work(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp);
 void *get_recv_wqe(struct hns_roce_qp *hr_qp, int n);
 void *get_send_wqe(struct hns_roce_qp *hr_qp, int n);
 void *get_send_extend_sge(struct hns_roce_qp *hr_qp, int n);
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 7a89d66..f796c8b 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -221,11 +221,6 @@ static int set_rwqe_data_seg(struct ib_qp *ibqp, const struct ib_send_wr *wr,
 	return 0;
 }
 
-static int hns_roce_v2_modify_qp(struct ib_qp *ibqp,
-				 const struct ib_qp_attr *attr,
-				 int attr_mask, enum ib_qp_state cur_state,
-				 enum ib_qp_state new_state);
-
 static int hns_roce_v2_post_send(struct ib_qp *ibqp,
 				 const struct ib_send_wr *wr,
 				 const struct ib_send_wr **bad_wr)
@@ -238,14 +233,12 @@ static int hns_roce_v2_post_send(struct ib_qp *ibqp,
 	struct hns_roce_wqe_frmr_seg *fseg;
 	struct device *dev = hr_dev->dev;
 	struct hns_roce_v2_db sq_db;
-	struct ib_qp_attr attr;
 	unsigned int sge_ind;
 	unsigned int owner_bit;
 	unsigned long flags;
 	unsigned int ind;
 	void *wqe = NULL;
 	bool loopback;
-	int attr_mask;
 	u32 tmp_len;
 	int ret = 0;
 	u32 hr_op;
@@ -591,18 +584,8 @@ static int hns_roce_v2_post_send(struct ib_qp *ibqp,
 		qp->sq_next_wqe = ind;
 		qp->next_sge = sge_ind;
 
-		if (qp->state == IB_QPS_ERR) {
-			attr_mask = IB_QP_STATE;
-			attr.qp_state = IB_QPS_ERR;
-
-			ret = hns_roce_v2_modify_qp(&qp->ibqp, &attr, attr_mask,
-						    qp->state, IB_QPS_ERR);
-			if (ret) {
-				spin_unlock_irqrestore(&qp->sq.lock, flags);
-				*bad_wr = wr;
-				return ret;
-			}
-		}
+		if (qp->state == IB_QPS_ERR)
+			init_flush_work(hr_dev, qp);
 	}
 
 	spin_unlock_irqrestore(&qp->sq.lock, flags);
@@ -619,10 +602,8 @@ static int hns_roce_v2_post_recv(struct ib_qp *ibqp,
 	struct hns_roce_v2_wqe_data_seg *dseg;
 	struct hns_roce_rinl_sge *sge_list;
 	struct device *dev = hr_dev->dev;
-	struct ib_qp_attr attr;
 	unsigned long flags;
 	void *wqe = NULL;
-	int attr_mask;
 	int ret = 0;
 	int nreq;
 	int ind;
@@ -692,19 +673,8 @@ static int hns_roce_v2_post_recv(struct ib_qp *ibqp,
 
 		*hr_qp->rdb.db_record = hr_qp->rq.head & 0xffff;
 
-		if (hr_qp->state == IB_QPS_ERR) {
-			attr_mask = IB_QP_STATE;
-			attr.qp_state = IB_QPS_ERR;
-
-			ret = hns_roce_v2_modify_qp(&hr_qp->ibqp, &attr,
-						    attr_mask, hr_qp->state,
-						    IB_QPS_ERR);
-			if (ret) {
-				spin_unlock_irqrestore(&hr_qp->rq.lock, flags);
-				*bad_wr = wr;
-				return ret;
-			}
-		}
+		if (hr_qp->state == IB_QPS_ERR)
+			init_flush_work(hr_dev, hr_qp);
 	}
 	spin_unlock_irqrestore(&hr_qp->rq.lock, flags);
 
@@ -2691,13 +2661,11 @@ static int hns_roce_handle_recv_inl_wqe(struct hns_roce_v2_cqe *cqe,
 static int hns_roce_v2_poll_one(struct hns_roce_cq *hr_cq,
 				struct hns_roce_qp **cur_qp, struct ib_wc *wc)
 {
+	struct hns_roce_dev *hr_dev = to_hr_dev(hr_cq->ib_cq.device);
 	struct hns_roce_srq *srq = NULL;
-	struct hns_roce_dev *hr_dev;
 	struct hns_roce_v2_cqe *cqe;
 	struct hns_roce_qp *hr_qp;
 	struct hns_roce_wq *wq;
-	struct ib_qp_attr attr;
-	int attr_mask;
 	int is_send;
 	u16 wqe_ctr;
 	u32 opcode;
@@ -2721,7 +2689,6 @@ static int hns_roce_v2_poll_one(struct hns_roce_cq *hr_cq,
 				V2_CQE_BYTE_16_LCL_QPN_S);
 
 	if (!*cur_qp || (qpn & HNS_ROCE_V2_CQE_QPN_MASK) != (*cur_qp)->qpn) {
-		hr_dev = to_hr_dev(hr_cq->ib_cq.device);
 		hr_qp = __hns_roce_qp_lookup(hr_dev, qpn);
 		if (unlikely(!hr_qp)) {
 			dev_err(hr_dev->dev, "CQ %06lx with entry for unknown QPN %06x\n",
@@ -2816,13 +2783,12 @@ static int hns_roce_v2_poll_one(struct hns_roce_cq *hr_cq,
 	}
 
 	/* flush cqe if wc status is error, excluding flush error */
-	if ((wc->status != IB_WC_SUCCESS) &&
-	    (wc->status != IB_WC_WR_FLUSH_ERR)) {
-		attr_mask = IB_QP_STATE;
-		attr.qp_state = IB_QPS_ERR;
-		return hns_roce_v2_modify_qp(&(*cur_qp)->ibqp,
-					     &attr, attr_mask,
-					     (*cur_qp)->state, IB_QPS_ERR);
+	if (wc->status != IB_WC_SUCCESS &&
+	    wc->status != IB_WC_WR_FLUSH_ERR) {
+		dev_err(hr_dev->dev, "error cqe status is: 0x%x\n",
+			status & HNS_ROCE_V2_CQE_STATUS_MASK);
+		init_flush_work(hr_dev, *cur_qp);
+		return 0;
 	}
 
 	if (wc->status == IB_WC_WR_FLUSH_ERR)
@@ -4390,6 +4356,8 @@ static int hns_roce_v2_modify_qp(struct ib_qp *ibqp,
 	struct hns_roce_v2_qp_context *context = ctx;
 	struct hns_roce_v2_qp_context *qpc_mask = ctx + 1;
 	struct device *dev = hr_dev->dev;
+	unsigned long sq_flags = 0;
+	unsigned long rq_flags = 0;
 	int ret;
 
 	/*
@@ -4407,6 +4375,7 @@ static int hns_roce_v2_modify_qp(struct ib_qp *ibqp,
 
 	/* When QP state is err, SQ and RQ WQE should be flushed */
 	if (new_state == IB_QPS_ERR) {
+		spin_lock_irqsave(&hr_qp->sq.lock, sq_flags);
 		roce_set_field(context->byte_160_sq_ci_pi,
 			       V2_QPC_BYTE_160_SQ_PRODUCER_IDX_M,
 			       V2_QPC_BYTE_160_SQ_PRODUCER_IDX_S,
@@ -4415,7 +4384,10 @@ static int hns_roce_v2_modify_qp(struct ib_qp *ibqp,
 			       V2_QPC_BYTE_160_SQ_PRODUCER_IDX_M,
 			       V2_QPC_BYTE_160_SQ_PRODUCER_IDX_S, 0);
 
+		hr_qp->state = IB_QPS_ERR;
+		spin_unlock_irqrestore(&hr_qp->sq.lock, sq_flags);
 		if (!ibqp->srq) {
+			spin_lock_irqsave(&hr_qp->rq.lock, rq_flags);
 			roce_set_field(context->byte_84_rq_ci_pi,
 			       V2_QPC_BYTE_84_RQ_PRODUCER_IDX_M,
 			       V2_QPC_BYTE_84_RQ_PRODUCER_IDX_S,
@@ -4423,6 +4395,7 @@ static int hns_roce_v2_modify_qp(struct ib_qp *ibqp,
 			roce_set_field(qpc_mask->byte_84_rq_ci_pi,
 			       V2_QPC_BYTE_84_RQ_PRODUCER_IDX_M,
 			       V2_QPC_BYTE_84_RQ_PRODUCER_IDX_S, 0);
+			spin_unlock_irqrestore(&hr_qp->rq.lock, rq_flags);
 		}
 	}
 
@@ -4833,39 +4806,6 @@ static int hns_roce_v2_modify_cq(struct ib_cq *cq, u16 cq_count, u16 cq_period)
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
@@ -4889,17 +4829,14 @@ static void hns_roce_irq_work_handle(struct work_struct *work)
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
@@ -6026,6 +5963,29 @@ static void hns_roce_v2_cleanup_eq_table(struct hns_roce_dev *hr_dev)
 	destroy_workqueue(hr_dev->irq_workq);
 }
 
+static int hns_roce_v2_create_workq(struct hns_roce_dev *hr_dev)
+{
+	char workq_name[HNS_ROCE_WORKQ_NAME_LEN];
+	struct device *dev = hr_dev->dev;
+
+	snprintf(workq_name, HNS_ROCE_WORKQ_NAME_LEN - 1, "%s_flush_wq",
+		 hr_dev->ib_dev.name);
+
+	hr_dev->flush_workq = create_singlethread_workqueue(workq_name);
+	if (!hr_dev->flush_workq) {
+		dev_err(dev, "Failed to create flush workqueue!\n");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static void hns_roce_v2_destroy_workq(struct hns_roce_dev *hr_dev)
+{
+	flush_workqueue(hr_dev->flush_workq);
+	destroy_workqueue(hr_dev->flush_workq);
+}
+
 static void hns_roce_v2_write_srqc(struct hns_roce_dev *hr_dev,
 				   struct hns_roce_srq *srq, u32 pdn, u16 xrcd,
 				   u32 cqn, void *mb_buf, u64 *mtts_wqe,
@@ -6360,6 +6320,8 @@ static const struct hns_roce_hw hns_roce_hw_v2 = {
 	.poll_cq = hns_roce_v2_poll_cq,
 	.init_eq = hns_roce_v2_init_eq_table,
 	.cleanup_eq = hns_roce_v2_cleanup_eq_table,
+	.create_workq = hns_roce_v2_create_workq,
+	.destroy_workq = hns_roce_v2_destroy_workq,
 	.write_srqc = hns_roce_v2_write_srqc,
 	.modify_srq = hns_roce_v2_modify_srq,
 	.query_srq = hns_roce_v2_query_srq,
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index b5d196c..2dd5ee2 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -942,8 +942,17 @@ int hns_roce_init(struct hns_roce_dev *hr_dev)
 	if (ret)
 		goto error_failed_register_device;
 
+	if (hr_dev->hw->create_workq) {
+		ret = hr_dev->hw->create_workq(hr_dev);
+		if (ret)
+			goto error_failed_create_workq;
+	}
+
 	return 0;
 
+error_failed_create_workq:
+	hns_roce_unregister_device(hr_dev);
+
 error_failed_register_device:
 	if (hr_dev->hw->hw_exit)
 		hr_dev->hw->hw_exit(hr_dev);
@@ -979,6 +988,9 @@ void hns_roce_exit(struct hns_roce_dev *hr_dev)
 {
 	hns_roce_unregister_device(hr_dev);
 
+	if (hr_dev->hw->destroy_workq)
+		hr_dev->hw->destroy_workq(hr_dev);
+
 	if (hr_dev->hw->hw_exit)
 		hr_dev->hw->hw_exit(hr_dev);
 	hns_roce_cleanup_bitmap(hr_dev);
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index bd78ff9..4357c63 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -43,6 +43,40 @@
 
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
+		dev_err(dev, "Modify qp to err for flush cqe fail(%d)\n", ret);
+
+	kfree(flush_work);
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
+	queue_work(hr_dev->flush_workq, &flush_work->work);
+}
+
 void hns_roce_qp_event(struct hns_roce_dev *hr_dev, u32 qpn, int event_type)
 {
 	struct device *dev = hr_dev->dev;
@@ -59,6 +93,13 @@ void hns_roce_qp_event(struct hns_roce_dev *hr_dev, u32 qpn, int event_type)
 		return;
 	}
 
+	if (event_type == HNS_ROCE_EVENT_TYPE_WQ_CATAS_ERROR ||
+	    event_type == HNS_ROCE_EVENT_TYPE_INV_REQ_LOCAL_WQ_ERROR ||
+	    event_type == HNS_ROCE_EVENT_TYPE_LOCAL_WQ_ACCESS_ERROR) {
+		qp->state = IB_QPS_ERR;
+		init_flush_work(hr_dev, qp);
+	}
+
 	qp->event(qp, (enum hns_roce_event)event_type);
 
 	if (atomic_dec_and_test(&qp->refcount))
-- 
2.8.1

