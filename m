Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58566AF684
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Sep 2019 09:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfIKHM1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Sep 2019 03:12:27 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:57172 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725747AbfIKHM1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 11 Sep 2019 03:12:27 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 939C63912B6E92E14693;
        Wed, 11 Sep 2019 15:12:24 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Wed, 11 Sep 2019 15:12:17 +0800
From:   Weihang Li <liweihang@hisilicon.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH for-next] RDMA/hns: Add support for reporting wc as software mode
Date:   Wed, 11 Sep 2019 15:09:00 +0800
Message-ID: <1568185740-17872-1-git-send-email-liweihang@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

When hardware is in resetting stage, we may can't poll back all the
expected work completions as the hardware won't generate cqe anymore.

This patch allows the driver to compose the expected wc instead of the
hardware during resetting stage. Once the hardware finished resetting, we
can poll cq from hardware again.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Weihang Li <liweihang@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_cq.c     |   2 +
 drivers/infiniband/hw/hns/hns_roce_device.h |  17 +++
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c  |  14 ++-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 158 +++++++++++++++++++++++-----
 drivers/infiniband/hw/hns/hns_roce_main.c   |  47 +++++++++
 drivers/infiniband/hw/hns/hns_roce_qp.c     |  48 ++++++++-
 6 files changed, 253 insertions(+), 33 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_cq.c b/drivers/infiniband/hw/hns/hns_roce_cq.c
index 22541d1..5ff7fe3 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cq.c
@@ -430,6 +430,8 @@ int hns_roce_ib_create_cq(struct ib_cq *ib_cq,
 	cq_entries = roundup_pow_of_two((unsigned int)cq_entries);
 	hr_cq->ib_cq.cqe = cq_entries - 1;
 	spin_lock_init(&hr_cq->lock);
+	INIT_LIST_HEAD(&hr_cq->sq_list);
+	INIT_LIST_HEAD(&hr_cq->rq_list);
 
 	if (udata) {
 		ret = create_user_cq(hr_dev, hr_cq, udata, &resp, cq_entries);
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 96d1302..31abf7d 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -508,6 +508,10 @@ struct hns_roce_cq {
 	u32				vector;
 	atomic_t			refcount;
 	struct completion		free;
+	struct list_head		sq_list; /* all qps on this send cq */
+	struct list_head		rq_list; /* all qps on this recv cq */
+	int				comp_state;
+	struct list_head		node; /* all armed cqs are on a list */
 };
 
 struct hns_roce_idx_que {
@@ -693,6 +697,9 @@ struct hns_roce_qp {
 	u32			next_sge;
 
 	struct hns_roce_rinl_buf rq_inl_buf;
+	struct list_head	node;		/* all qps are on a list */
+	struct list_head	rq_node;	/* all recv qps are on a list */
+	struct list_head	sq_node;	/* all send qps are on a list */
 };
 
 struct hns_roce_sqp {
@@ -926,6 +933,12 @@ struct hns_roce_dfx_hw {
 			      int *buffer);
 };
 
+enum hns_roce_device_state {
+	HNS_ROCE_DEVICE_STATE_INITED,
+	HNS_ROCE_DEVICE_STATE_RST_DOWN,
+	HNS_ROCE_DEVICE_STATE_UNINIT,
+};
+
 struct hns_roce_hw {
 	int (*reset)(struct hns_roce_dev *hr_dev, bool enable);
 	int (*cmq_init)(struct hns_roce_dev *hr_dev);
@@ -1008,6 +1021,9 @@ struct hns_roce_dev {
 	bool			dis_db;
 	unsigned long		reset_cnt;
 	struct hns_roce_ib_iboe iboe;
+	enum hns_roce_device_state state;
+	struct list_head	qp_list; /* list of all qps on this dev */
+	spinlock_t		qp_lock; /* protect qp_list */
 
 	struct list_head        pgdir_list;
 	struct mutex            pgdir_mutex;
@@ -1278,6 +1294,7 @@ void hns_roce_cq_event(struct hns_roce_dev *hr_dev, u32 cqn, int event_type);
 void hns_roce_qp_event(struct hns_roce_dev *hr_dev, u32 qpn, int event_type);
 void hns_roce_srq_event(struct hns_roce_dev *hr_dev, u32 srqn, int event_type);
 int hns_get_gid_index(struct hns_roce_dev *hr_dev, u8 port, int gid_index);
+void hns_roce_handle_device_err(struct hns_roce_dev *hr_dev);
 int hns_roce_init(struct hns_roce_dev *hr_dev);
 void hns_roce_exit(struct hns_roce_dev *hr_dev);
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
index 07b7206..63314b3e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -3615,14 +3615,18 @@ int hns_roce_v1_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 	if (ret)
 		return ret;
 
-	send_cq = to_hr_cq(hr_qp->ibqp.send_cq);
-	recv_cq = to_hr_cq(hr_qp->ibqp.recv_cq);
+	send_cq = hr_qp->ibqp.send_cq ? to_hr_cq(hr_qp->ibqp.send_cq) : NULL;
+	recv_cq = hr_qp->ibqp.recv_cq ? to_hr_cq(hr_qp->ibqp.recv_cq) : NULL;
 
 	hns_roce_lock_cqs(send_cq, recv_cq);
 	if (!udata) {
-		__hns_roce_v1_cq_clean(recv_cq, hr_qp->qpn, hr_qp->ibqp.srq ?
-				       to_hr_srq(hr_qp->ibqp.srq) : NULL);
-		if (send_cq != recv_cq)
+		if (recv_cq)
+			__hns_roce_v1_cq_clean(recv_cq, hr_qp->qpn,
+					       (hr_qp->ibqp.srq ?
+						to_hr_srq(hr_qp->ibqp.srq) :
+						NULL));
+
+		if (send_cq && send_cq != recv_cq)
 			__hns_roce_v1_cq_clean(send_cq, hr_qp->qpn, NULL);
 	}
 	hns_roce_unlock_cqs(send_cq, recv_cq);
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 7a89d66..ba9c6ec 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -226,6 +226,30 @@ static int hns_roce_v2_modify_qp(struct ib_qp *ibqp,
 				 int attr_mask, enum ib_qp_state cur_state,
 				 enum ib_qp_state new_state);
 
+static int check_send_valid(struct hns_roce_dev *hr_dev,
+			    struct hns_roce_qp *hr_qp)
+{
+	struct ib_qp *ibqp = &hr_qp->ibqp;
+	struct device *dev = hr_dev->dev;
+
+	if (unlikely(ibqp->qp_type != IB_QPT_RC &&
+		     ibqp->qp_type != IB_QPT_GSI &&
+		     ibqp->qp_type != IB_QPT_UD)) {
+		dev_err(dev, "Not supported QP(0x%x)type!\n", ibqp->qp_type);
+		return -EOPNOTSUPP;
+	} else if (unlikely(hr_qp->state == IB_QPS_RESET ||
+		   hr_qp->state == IB_QPS_INIT ||
+		   hr_qp->state == IB_QPS_RTR)) {
+		dev_err(dev, "Post WQE fail, QP state %d!\n", hr_qp->state);
+		return -EINVAL;
+	} else if (unlikely(hr_dev->state >= HNS_ROCE_DEVICE_STATE_RST_DOWN)) {
+		dev_err(dev, "Post WQE fail, dev state %d!\n", hr_dev->state);
+		return -EIO;
+	}
+
+	return 0;
+}
+
 static int hns_roce_v2_post_send(struct ib_qp *ibqp,
 				 const struct ib_send_wr *wr,
 				 const struct ib_send_wr **bad_wr)
@@ -247,28 +271,21 @@ static int hns_roce_v2_post_send(struct ib_qp *ibqp,
 	bool loopback;
 	int attr_mask;
 	u32 tmp_len;
-	int ret = 0;
 	u32 hr_op;
 	u8 *smac;
 	int nreq;
+	int ret;
 	int i;
 
-	if (unlikely(ibqp->qp_type != IB_QPT_RC &&
-		     ibqp->qp_type != IB_QPT_GSI &&
-		     ibqp->qp_type != IB_QPT_UD)) {
-		dev_err(dev, "Not supported QP(0x%x)type!\n", ibqp->qp_type);
-		*bad_wr = wr;
-		return -EOPNOTSUPP;
-	}
+	spin_lock_irqsave(&qp->sq.lock, flags);
 
-	if (unlikely(qp->state == IB_QPS_RESET || qp->state == IB_QPS_INIT ||
-		     qp->state == IB_QPS_RTR)) {
-		dev_err(dev, "Post WQE fail, QP state %d err!\n", qp->state);
+	ret = check_send_valid(hr_dev, qp);
+	if (ret) {
 		*bad_wr = wr;
-		return -EINVAL;
+		nreq = 0;
+		goto out;
 	}
 
-	spin_lock_irqsave(&qp->sq.lock, flags);
 	ind = qp->sq_next_wqe;
 	sge_ind = qp->next_sge;
 
@@ -610,6 +627,17 @@ static int hns_roce_v2_post_send(struct ib_qp *ibqp,
 	return ret;
 }
 
+static int check_recv_valid(struct hns_roce_dev *hr_dev,
+			    struct hns_roce_qp *hr_qp)
+{
+	if (unlikely(hr_dev->state >= HNS_ROCE_DEVICE_STATE_RST_DOWN))
+		return -EIO;
+	else if (hr_qp->state == IB_QPS_RESET)
+		return -EINVAL;
+
+	return 0;
+}
+
 static int hns_roce_v2_post_recv(struct ib_qp *ibqp,
 				 const struct ib_recv_wr *wr,
 				 const struct ib_recv_wr **bad_wr)
@@ -623,20 +651,22 @@ static int hns_roce_v2_post_recv(struct ib_qp *ibqp,
 	unsigned long flags;
 	void *wqe = NULL;
 	int attr_mask;
-	int ret = 0;
 	int nreq;
 	int ind;
+	int ret;
 	int i;
 
 	spin_lock_irqsave(&hr_qp->rq.lock, flags);
-	ind = hr_qp->rq.head & (hr_qp->rq.wqe_cnt - 1);
 
-	if (hr_qp->state == IB_QPS_RESET) {
-		spin_unlock_irqrestore(&hr_qp->rq.lock, flags);
+	ret = check_recv_valid(hr_dev, hr_qp);
+	if (ret) {
 		*bad_wr = wr;
-		return -EINVAL;
+		nreq = 0;
+		goto out;
 	}
 
+	ind = hr_qp->rq.head & (hr_qp->rq.wqe_cnt - 1);
+
 	for (nreq = 0; wr; ++nreq, wr = wr->next) {
 		if (hns_roce_wq_overflow(&hr_qp->rq, nreq,
 			hr_qp->ibqp.recv_cq)) {
@@ -2688,6 +2718,55 @@ static int hns_roce_handle_recv_inl_wqe(struct hns_roce_v2_cqe *cqe,
 	return 0;
 }
 
+static int sw_comp(struct hns_roce_qp *hr_qp, struct hns_roce_wq *wq,
+		   int num_entries, struct ib_wc *wc)
+{
+	unsigned int left;
+	int npolled = 0;
+
+	left = wq->head - wq->tail;
+	if (left == 0)
+		return 0;
+
+	left = min_t(unsigned int, (unsigned int)num_entries, left);
+	while (npolled < left) {
+		wc->wr_id = wq->wrid[wq->tail & (wq->wqe_cnt - 1)];
+		wc->status = IB_WC_WR_FLUSH_ERR;
+		wc->vendor_err = 0;
+		wc->qp = &hr_qp->ibqp;
+
+		wq->tail++;
+		wc++;
+		npolled++;
+	}
+
+	return npolled;
+}
+
+static int hns_roce_v2_sw_poll_cq(struct hns_roce_cq *hr_cq, int num_entries,
+				  struct ib_wc *wc)
+{
+	struct hns_roce_qp *hr_qp;
+	int npolled = 0;
+
+	list_for_each_entry(hr_qp, &hr_cq->sq_list, sq_node) {
+		npolled += sw_comp(hr_qp, &hr_qp->sq,
+				   num_entries - npolled, wc + npolled);
+		if (npolled >= num_entries)
+			goto out;
+	}
+
+	list_for_each_entry(hr_qp, &hr_cq->rq_list, rq_node) {
+		npolled += sw_comp(hr_qp, &hr_qp->rq,
+				   num_entries - npolled, wc + npolled);
+		if (npolled >= num_entries)
+			goto out;
+	}
+
+out:
+	return npolled;
+}
+
 static int hns_roce_v2_poll_one(struct hns_roce_cq *hr_cq,
 				struct hns_roce_qp **cur_qp, struct ib_wc *wc)
 {
@@ -2968,6 +3047,7 @@ static int hns_roce_v2_poll_one(struct hns_roce_cq *hr_cq,
 static int hns_roce_v2_poll_cq(struct ib_cq *ibcq, int num_entries,
 			       struct ib_wc *wc)
 {
+	struct hns_roce_dev *hr_dev = to_hr_dev(ibcq->device);
 	struct hns_roce_cq *hr_cq = to_hr_cq(ibcq);
 	struct hns_roce_qp *cur_qp = NULL;
 	unsigned long flags;
@@ -2975,6 +3055,17 @@ static int hns_roce_v2_poll_cq(struct ib_cq *ibcq, int num_entries,
 
 	spin_lock_irqsave(&hr_cq->lock, flags);
 
+	/* When the device starts to reset, the state is RST_DOWN. At this time,
+	 * there may still be some valid CQEs in the hardware that are not
+	 * polled. Therefore, it is not allowed to switch to the software mode
+	 * immediately. When the state changes to UNINIT, CQE no longer exists
+	 * in the hardware, and then switch to software mode.
+	 */
+	if (hr_dev->state == HNS_ROCE_DEVICE_STATE_UNINIT) {
+		npolled = hns_roce_v2_sw_poll_cq(hr_cq, num_entries, wc);
+		goto out;
+	}
+
 	for (npolled = 0; npolled < num_entries; ++npolled) {
 		if (hns_roce_v2_poll_one(hr_cq, &cur_qp, wc + npolled))
 			break;
@@ -2986,6 +3077,7 @@ static int hns_roce_v2_poll_cq(struct ib_cq *ibcq, int num_entries,
 		hns_roce_v2_cq_set_ci(hr_cq, hr_cq->cons_index);
 	}
 
+out:
 	spin_unlock_irqrestore(&hr_cq->lock, flags);
 
 	return npolled;
@@ -4650,6 +4742,7 @@ static int hns_roce_v2_destroy_qp_common(struct hns_roce_dev *hr_dev,
 {
 	struct hns_roce_cq *send_cq, *recv_cq;
 	struct ib_device *ibdev = &hr_dev->ib_dev;
+	unsigned long flags;
 	int ret;
 
 	if (hr_qp->ibqp.qp_type == IB_QPT_RC && hr_qp->state != IB_QPS_RESET) {
@@ -4662,21 +4755,34 @@ static int hns_roce_v2_destroy_qp_common(struct hns_roce_dev *hr_dev,
 		}
 	}
 
-	send_cq = to_hr_cq(hr_qp->ibqp.send_cq);
-	recv_cq = to_hr_cq(hr_qp->ibqp.recv_cq);
+	send_cq = hr_qp->ibqp.send_cq ? to_hr_cq(hr_qp->ibqp.send_cq) : NULL;
+	recv_cq = hr_qp->ibqp.recv_cq ? to_hr_cq(hr_qp->ibqp.recv_cq) : NULL;
 
+	spin_lock_irqsave(&hr_dev->qp_lock, flags);
 	hns_roce_lock_cqs(send_cq, recv_cq);
 
+	list_del(&hr_qp->node);
+	list_del(&hr_qp->sq_node);
+	list_del(&hr_qp->rq_node);
+
 	if (!udata) {
 		__hns_roce_v2_cq_clean(recv_cq, hr_qp->qpn, hr_qp->ibqp.srq ?
 				       to_hr_srq(hr_qp->ibqp.srq) : NULL);
-		if (send_cq != recv_cq)
+		if (recv_cq)
+			__hns_roce_v2_cq_clean(recv_cq, hr_qp->qpn,
+					       (hr_qp->ibqp.srq ?
+						to_hr_srq(hr_qp->ibqp.srq) :
+						NULL));
+
+		if (send_cq && send_cq != recv_cq)
 			__hns_roce_v2_cq_clean(send_cq, hr_qp->qpn, NULL);
+
 	}
 
 	hns_roce_qp_remove(hr_dev, hr_qp);
 
 	hns_roce_unlock_cqs(send_cq, recv_cq);
+	spin_unlock_irqrestore(&hr_dev->qp_lock, flags);
 
 	hns_roce_qp_free(hr_dev, hr_qp);
 
@@ -6466,6 +6572,9 @@ static void __hns_roce_hw_v2_uninit_instance(struct hnae3_handle *handle,
 		return;
 
 	handle->priv = NULL;
+
+	hr_dev->state = HNS_ROCE_DEVICE_STATE_UNINIT;
+
 	hns_roce_exit(hr_dev);
 	kfree(hr_dev->priv);
 	ib_dealloc_device(&hr_dev->ib_dev);
@@ -6527,7 +6636,6 @@ static void hns_roce_hw_v2_uninit_instance(struct hnae3_handle *handle,
 static int hns_roce_hw_v2_reset_notify_down(struct hnae3_handle *handle)
 {
 	struct hns_roce_dev *hr_dev;
-	struct ib_event event;
 
 	if (handle->rinfo.instance_state != HNS_ROCE_STATE_INITED) {
 		set_bit(HNS_ROCE_RST_DIRECT_RETURN, &handle->rinfo.state);
@@ -6545,10 +6653,8 @@ static int hns_roce_hw_v2_reset_notify_down(struct hnae3_handle *handle)
 	hr_dev->active = false;
 	hr_dev->dis_db = true;
 
-	event.event = IB_EVENT_DEVICE_FATAL;
-	event.device = &hr_dev->ib_dev;
-	event.element.port_num = 1;
-	ib_dispatch_event(&event);
+	hr_dev->state = HNS_ROCE_DEVICE_STATE_RST_DOWN;
+	hns_roce_handle_device_err(hr_dev);
 
 	return 0;
 }
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index b5d196c..665ce24 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -868,6 +868,50 @@ static int hns_roce_setup_hca(struct hns_roce_dev *hr_dev)
 	return ret;
 }
 
+static void check_and_get_armed_cq(struct list_head *cq_list, struct ib_cq *cq)
+{
+	struct hns_roce_cq *hr_cq = to_hr_cq(cq);
+	unsigned long flags;
+
+	spin_lock_irqsave(&hr_cq->lock, flags);
+	if (hr_cq->comp && cq->comp_handler) {
+		if (!hr_cq->comp_state) {
+			hr_cq->comp_state = 1;
+			list_add_tail(&hr_cq->node, cq_list);
+		}
+	}
+	spin_unlock_irqrestore(&hr_cq->lock, flags);
+}
+
+void hns_roce_handle_device_err(struct hns_roce_dev *hr_dev)
+{
+	struct hns_roce_qp *hr_qp;
+	struct hns_roce_cq *hr_cq;
+	struct list_head cq_list;
+	unsigned long flags_qp;
+	unsigned long flags;
+
+	INIT_LIST_HEAD(&cq_list);
+
+	spin_lock_irqsave(&hr_dev->qp_lock, flags);
+	list_for_each_entry(hr_qp, &hr_dev->qp_list, node) {
+		spin_lock_irqsave(&hr_qp->sq.lock, flags_qp);
+		if (hr_qp->sq.tail != hr_qp->sq.head)
+			check_and_get_armed_cq(&cq_list, hr_qp->ibqp.send_cq);
+		spin_unlock_irqrestore(&hr_qp->sq.lock, flags_qp);
+
+		spin_lock_irqsave(&hr_qp->rq.lock, flags_qp);
+		if ((!hr_qp->ibqp.srq) && (hr_qp->rq.tail != hr_qp->rq.head))
+			check_and_get_armed_cq(&cq_list, hr_qp->ibqp.recv_cq);
+		spin_unlock_irqrestore(&hr_qp->rq.lock, flags_qp);
+	}
+
+	list_for_each_entry(hr_cq, &cq_list, node)
+		hr_cq->comp(hr_cq);
+
+	spin_unlock_irqrestore(&hr_dev->qp_lock, flags);
+}
+
 int hns_roce_init(struct hns_roce_dev *hr_dev)
 {
 	int ret;
@@ -938,6 +982,9 @@ int hns_roce_init(struct hns_roce_dev *hr_dev)
 		}
 	}
 
+	INIT_LIST_HEAD(&hr_dev->qp_list);
+	spin_lock_init(&hr_dev->qp_lock);
+
 	ret = hns_roce_register_device(hr_dev);
 	if (ret)
 		goto error_failed_register_device;
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index bd78ff9..c4fae14 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -679,6 +679,29 @@ static void free_rq_inline_buf(struct hns_roce_qp *hr_qp)
 	kfree(hr_qp->rq_inl_buf.wqe_list);
 }
 
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
+	spin_lock_irqsave(&hr_dev->qp_lock, flags);
+	hns_roce_lock_cqs(hr_send_cq, hr_recv_cq);
+
+	list_add_tail(&hr_qp->node, &hr_dev->qp_list);
+	if (hr_send_cq)
+		list_add_tail(&hr_qp->sq_node, &hr_send_cq->sq_list);
+	if (hr_recv_cq)
+		list_add_tail(&hr_qp->rq_node, &hr_recv_cq->rq_list);
+
+	hns_roce_unlock_cqs(hr_send_cq, hr_recv_cq);
+	spin_unlock_irqrestore(&hr_dev->qp_lock, flags);
+}
+
 static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 				     struct ib_pd *ib_pd,
 				     struct ib_qp_init_attr *init_attr,
@@ -948,6 +971,9 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 	}
 
 	hr_qp->event = hns_roce_ib_qp_event;
+
+	add_qp_to_list(hr_dev, hr_qp, init_attr->send_cq, init_attr->recv_cq);
+
 	hns_roce_free_buf_list(buf_list, hr_qp->region_cnt);
 
 	return 0;
@@ -1232,7 +1258,16 @@ int hns_roce_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 void hns_roce_lock_cqs(struct hns_roce_cq *send_cq, struct hns_roce_cq *recv_cq)
 		       __acquires(&send_cq->lock) __acquires(&recv_cq->lock)
 {
-	if (send_cq == recv_cq) {
+	if (unlikely(send_cq == NULL && recv_cq == NULL)) {
+		__acquire(&send_cq->lock);
+		__acquire(&recv_cq->lock);
+	} else if (unlikely(send_cq != NULL && recv_cq == NULL)) {
+		spin_lock_irq(&send_cq->lock);
+		__acquire(&recv_cq->lock);
+	} else if (unlikely(send_cq == NULL && recv_cq != NULL)) {
+		spin_lock_irq(&recv_cq->lock);
+		__acquire(&send_cq->lock);
+	} else if (send_cq == recv_cq) {
 		spin_lock_irq(&send_cq->lock);
 		__acquire(&recv_cq->lock);
 	} else if (send_cq->cqn < recv_cq->cqn) {
@@ -1248,7 +1283,16 @@ void hns_roce_unlock_cqs(struct hns_roce_cq *send_cq,
 			 struct hns_roce_cq *recv_cq) __releases(&send_cq->lock)
 			 __releases(&recv_cq->lock)
 {
-	if (send_cq == recv_cq) {
+	if (unlikely(send_cq == NULL && recv_cq == NULL)) {
+		__release(&recv_cq->lock);
+		__release(&send_cq->lock);
+	} else if (unlikely(send_cq != NULL && recv_cq == NULL)) {
+		__release(&recv_cq->lock);
+		spin_unlock(&send_cq->lock);
+	} else if (unlikely(send_cq == NULL && recv_cq != NULL)) {
+		__release(&send_cq->lock);
+		spin_unlock(&recv_cq->lock);
+	} else if (send_cq == recv_cq) {
 		__release(&recv_cq->lock);
 		spin_unlock_irq(&send_cq->lock);
 	} else if (send_cq->cqn < recv_cq->cqn) {
-- 
2.8.1

