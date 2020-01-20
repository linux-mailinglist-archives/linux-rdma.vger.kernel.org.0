Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C67421424F5
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Jan 2020 09:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbgATIXh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Jan 2020 03:23:37 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9668 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726587AbgATIXh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 Jan 2020 03:23:37 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D692DF08DFF874D0DE47;
        Mon, 20 Jan 2020 16:23:31 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Mon, 20 Jan 2020 16:23:25 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 2/7] RDMA/hns: Optimize qp context create and destroy flow
Date:   Mon, 20 Jan 2020 16:19:32 +0800
Message-ID: <1579508377-55818-3-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1579508377-55818-1-git-send-email-liweihang@huawei.com>
References: <1579508377-55818-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

Rename the qp context related functions and adjusts the code location to
distinguish between the qp context and the entire qp.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c |   4 -
 drivers/infiniband/hw/hns/hns_roce_qp.c    | 156 ++++++++++++++---------------
 2 files changed, 76 insertions(+), 84 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 5dbff86..83ac906 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -5011,10 +5011,6 @@ static int hns_roce_v2_destroy_qp_common(struct hns_roce_dev *hr_dev,
 	spin_lock_irqsave(&hr_dev->qp_list_lock, flags);
 	hns_roce_lock_cqs(send_cq, recv_cq);
 
-	list_del(&hr_qp->node);
-	list_del(&hr_qp->sq_node);
-	list_del(&hr_qp->rq_node);
-
 	if (!udata) {
 		if (recv_cq)
 			__hns_roce_v2_cq_clean(recv_cq, hr_qp->qpn,
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 748a867..c8f6985 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -139,38 +139,63 @@ enum hns_roce_qp_state to_hns_roce_state(enum ib_qp_state state)
 	}
 }
 
-static int hns_roce_gsi_qp_alloc(struct hns_roce_dev *hr_dev, unsigned long qpn,
-				 struct hns_roce_qp *hr_qp)
+static void add_qp_to_list(struct hns_roce_dev *hr_dev,
+			   struct hns_roce_qp *hr_qp,
+			   struct ib_cq *send_cq, struct ib_cq *recv_cq)
+{
+	struct hns_roce_cq *hr_send_cq, *hr_recv_cq;
+	unsigned long flags;
+
+	hr_send_cq = send_cq ? to_hr_cq(send_cq) : NULL;
+	hr_recv_cq = recv_cq ? to_hr_cq(recv_cq) : NULL;
+
+	spin_lock_irqsave(&hr_dev->qp_list_lock, flags);
+	hns_roce_lock_cqs(hr_send_cq, hr_recv_cq);
+
+	list_add_tail(&hr_qp->node, &hr_dev->qp_list);
+	if (hr_send_cq)
+		list_add_tail(&hr_qp->sq_node, &hr_send_cq->sq_list);
+	if (hr_recv_cq)
+		list_add_tail(&hr_qp->rq_node, &hr_recv_cq->rq_list);
+
+	hns_roce_unlock_cqs(hr_send_cq, hr_recv_cq);
+	spin_unlock_irqrestore(&hr_dev->qp_list_lock, flags);
+}
+
+static int hns_roce_qp_store(struct hns_roce_dev *hr_dev,
+			     struct hns_roce_qp *hr_qp,
+			     struct ib_qp_init_attr *init_attr)
 {
 	struct xarray *xa = &hr_dev->qp_table_xa;
 	int ret;
 
-	if (!qpn)
+	if (!hr_qp->qpn)
 		return -EINVAL;
 
-	hr_qp->qpn = qpn;
-	atomic_set(&hr_qp->refcount, 1);
-	init_completion(&hr_qp->free);
-
-	ret = xa_err(xa_store_irq(xa, hr_qp->qpn & (hr_dev->caps.num_qps - 1),
-				hr_qp, GFP_KERNEL));
+	ret = xa_err(xa_store_irq(xa, hr_qp->qpn, hr_qp, GFP_KERNEL));
 	if (ret)
 		dev_err(hr_dev->dev, "QPC xa_store failed\n");
+	else
+		/* add qp to the roce device's qp list for softwc */
+		add_qp_to_list(hr_dev, hr_qp, init_attr->send_cq,
+			       init_attr->recv_cq);
 
 	return ret;
 }
 
-static int hns_roce_qp_alloc(struct hns_roce_dev *hr_dev, unsigned long qpn,
-			     struct hns_roce_qp *hr_qp)
+static int alloc_qpc(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
 {
 	struct hns_roce_qp_table *qp_table = &hr_dev->qp_table;
 	struct device *dev = hr_dev->dev;
 	int ret;
 
-	if (!qpn)
+	if (!hr_qp->qpn)
 		return -EINVAL;
 
-	hr_qp->qpn = qpn;
+	/* In v1 engine, GSI QP context is saved in the RoCE hw's register */
+	if (hr_qp->ibqp.qp_type == IB_QPT_GSI &&
+	    hr_dev->hw_rev == HNS_ROCE_HW_VER1)
+		return 0;
 
 	/* Alloc memory for QPC */
 	ret = hns_roce_table_get(hr_dev, &qp_table->qp_table, hr_qp->qpn);
@@ -206,17 +231,8 @@ static int hns_roce_qp_alloc(struct hns_roce_dev *hr_dev, unsigned long qpn,
 		}
 	}
 
-	ret = hns_roce_gsi_qp_alloc(hr_dev, qpn, hr_qp);
-	if (ret)
-		goto err_put_sccc;
-
 	return 0;
 
-err_put_sccc:
-	if (hr_dev->caps.sccc_entry_sz)
-		hns_roce_table_put(hr_dev, &qp_table->sccc_table,
-				   hr_qp->qpn);
-
 err_put_trrl:
 	if (hr_dev->caps.trrl_entry_sz)
 		hns_roce_table_put(hr_dev, &qp_table->trrl_table, hr_qp->qpn);
@@ -236,25 +252,27 @@ void hns_roce_qp_remove(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
 	struct xarray *xa = &hr_dev->qp_table_xa;
 	unsigned long flags;
 
+	list_del(&hr_qp->node);
+	list_del(&hr_qp->sq_node);
+	list_del(&hr_qp->rq_node);
+
 	xa_lock_irqsave(xa, flags);
 	__xa_erase(xa, hr_qp->qpn & (hr_dev->caps.num_qps - 1));
 	xa_unlock_irqrestore(xa, flags);
 }
 
-void hns_roce_qp_free(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
+static void free_qpc(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
 {
 	struct hns_roce_qp_table *qp_table = &hr_dev->qp_table;
 
-	if (atomic_dec_and_test(&hr_qp->refcount))
-		complete(&hr_qp->free);
-	wait_for_completion(&hr_qp->free);
+	/* In v1 engine, GSI QP context is saved in the RoCE hw's register */
+	if (hr_qp->ibqp.qp_type == IB_QPT_GSI &&
+	    hr_dev->hw_rev == HNS_ROCE_HW_VER1)
+		return;
 
-	if ((hr_qp->ibqp.qp_type) != IB_QPT_GSI) {
-		if (hr_dev->caps.trrl_entry_sz)
-			hns_roce_table_put(hr_dev, &qp_table->trrl_table,
-					   hr_qp->qpn);
-		hns_roce_table_put(hr_dev, &qp_table->irrl_table, hr_qp->qpn);
-	}
+	if (hr_dev->caps.trrl_entry_sz)
+		hns_roce_table_put(hr_dev, &qp_table->trrl_table, hr_qp->qpn);
+	hns_roce_table_put(hr_dev, &qp_table->irrl_table, hr_qp->qpn);
 }
 
 void hns_roce_release_range_qp(struct hns_roce_dev *hr_dev, int base_qpn,
@@ -677,29 +695,6 @@ static void free_rq_inline_buf(struct hns_roce_qp *hr_qp)
 	kfree(hr_qp->rq_inl_buf.wqe_list);
 }
 
-static void add_qp_to_list(struct hns_roce_dev *hr_dev,
-			   struct hns_roce_qp *hr_qp,
-			   struct ib_cq *send_cq, struct ib_cq *recv_cq)
-{
-	struct hns_roce_cq *hr_send_cq, *hr_recv_cq;
-	unsigned long flags;
-
-	hr_send_cq = send_cq ? to_hr_cq(send_cq) : NULL;
-	hr_recv_cq = recv_cq ? to_hr_cq(recv_cq) : NULL;
-
-	spin_lock_irqsave(&hr_dev->qp_list_lock, flags);
-	hns_roce_lock_cqs(hr_send_cq, hr_recv_cq);
-
-	list_add_tail(&hr_qp->node, &hr_dev->qp_list);
-	if (hr_send_cq)
-		list_add_tail(&hr_qp->sq_node, &hr_send_cq->sq_list);
-	if (hr_recv_cq)
-		list_add_tail(&hr_qp->rq_node, &hr_recv_cq->rq_list);
-
-	hns_roce_unlock_cqs(hr_send_cq, hr_recv_cq);
-	spin_unlock_irqrestore(&hr_dev->qp_list_lock, flags);
-}
-
 static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 				     struct ib_pd *ib_pd,
 				     struct ib_qp_init_attr *init_attr,
@@ -923,6 +918,8 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 		}
 	}
 
+	hr_qp->qpn = qpn;
+
 	hr_qp->wqe_bt_pg_shift = calc_wqe_bt_page_shift(hr_dev, hr_qp->regions,
 							hr_qp->region_cnt);
 	hns_roce_mtr_init(&hr_qp->mtr, PAGE_SHIFT + hr_qp->wqe_bt_pg_shift,
@@ -934,20 +931,16 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 		goto err_mtr;
 	}
 
-	if (init_attr->qp_type == IB_QPT_GSI &&
-	    hr_dev->hw_rev == HNS_ROCE_HW_VER1) {
-		/* In v1 engine, GSI QP context in RoCE engine's register */
-		ret = hns_roce_gsi_qp_alloc(hr_dev, qpn, hr_qp);
-		if (ret) {
-			dev_err(dev, "hns_roce_qp_alloc failed!\n");
-			goto err_qpn;
-		}
-	} else {
-		ret = hns_roce_qp_alloc(hr_dev, qpn, hr_qp);
-		if (ret) {
-			dev_err(dev, "hns_roce_qp_alloc failed!\n");
-			goto err_qpn;
-		}
+	ret = alloc_qpc(hr_dev, hr_qp);
+	if (ret) {
+		ibdev_err(&hr_dev->ib_dev, "alloc qpc failed!\n");
+		goto err_qpn;
+	}
+
+	ret = hns_roce_qp_store(hr_dev, hr_qp, init_attr);
+	if (ret) {
+		ibdev_err(&hr_dev->ib_dev, "add qp failed!\n");
+		goto err_qpc;
 	}
 
 	if (sqpn)
@@ -959,29 +952,28 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 		ret = ib_copy_to_udata(udata, &resp,
 				       min(udata->outlen, sizeof(resp)));
 		if (ret)
-			goto err_qp;
+			goto err_store;
 	}
 
 	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_QP_FLOW_CTRL) {
 		ret = hr_dev->hw->qp_flow_control_init(hr_dev, hr_qp);
 		if (ret)
-			goto err_qp;
+			goto err_store;
 	}
 
 	hr_qp->event = hns_roce_ib_qp_event;
-
-	add_qp_to_list(hr_dev, hr_qp, init_attr->send_cq, init_attr->recv_cq);
+	atomic_set(&hr_qp->refcount, 1);
+	init_completion(&hr_qp->free);
 
 	hns_roce_free_buf_list(buf_list, hr_qp->region_cnt);
 
 	return 0;
 
-err_qp:
-	if (init_attr->qp_type == IB_QPT_GSI &&
-		hr_dev->hw_rev == HNS_ROCE_HW_VER1)
-		hns_roce_qp_remove(hr_dev, hr_qp);
-	else
-		hns_roce_qp_free(hr_dev, hr_qp);
+err_store:
+	hns_roce_qp_remove(hr_dev, hr_qp);
+
+err_qpc:
+	free_qpc(hr_dev, hr_qp);
 
 err_qpn:
 	if (!sqpn)
@@ -1038,7 +1030,11 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 void hns_roce_qp_destroy(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 			 struct ib_udata *udata)
 {
-	hns_roce_qp_free(hr_dev, hr_qp);
+	if (atomic_dec_and_test(&hr_qp->refcount))
+		complete(&hr_qp->free);
+	wait_for_completion(&hr_qp->free);
+
+	free_qpc(hr_dev, hr_qp);
 
 	/* Not special_QP, free their QPN */
 	if (hr_qp->ibqp.qp_type != IB_QPT_GSI)
-- 
2.8.1

