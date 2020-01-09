Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45652135921
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jan 2020 13:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730389AbgAIMYI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Jan 2020 07:24:08 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8246 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730371AbgAIMYI (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 9 Jan 2020 07:24:08 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1AC10DBC1C5FC731526A;
        Thu,  9 Jan 2020 20:24:05 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Thu, 9 Jan 2020 20:23:56 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH v4 for-next] RDMA/hns: Add support for reporting wc as software mode
Date:   Thu, 9 Jan 2020 20:20:12 +0800
Message-ID: <1578572412-25756-1-git-send-email-liweihang@huawei.com>
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
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
Sorry to keep sending new version of this patch. It was because some issues
were found since last version or there are some conflicts to apply it to
the branch.

Considering that this patch hasn't got comments from any others in the
community, please forget about previous versions and treat this as a new
one. Any suggestions will be appreciated.

Changes since v3:
- Fix conflicts with recently applied patches.

Changes since v2:
- Fix cq poll failure for qp1 when device reseting and do a rebase.

Changes since v1:
- Remove a deplicate cq_clean statement.

 drivers/infiniband/hw/hns/hns_roce_cq.c     |   2 +
 drivers/infiniband/hw/hns/hns_roce_device.h |  17 +++
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c  |  14 ++-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 158 +++++++++++++++++++++++-----
 drivers/infiniband/hw/hns/hns_roce_main.c   |  47 +++++++++
 drivers/infiniband/hw/hns/hns_roce_qp.c     |  48 ++++++++-
 6 files changed, 252 insertions(+), 34 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_cq.c b/drivers/infiniband/hw/hns/hns_roce_cq.c
index af1d882..61f53a8 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cq.c
@@ -370,6 +370,8 @@ int hns_roce_create_cq(struct ib_cq *ib_cq, const struct ib_cq_init_attr *attr,
 	hr_cq->buf.size = hr_cq->cq_depth * hr_dev->caps.cq_entry_sz;
 	hr_cq->buf.page_shift = PAGE_SHIFT + hr_dev->caps.cqe_buf_pg_sz;
 	spin_lock_init(&hr_cq->lock);
+	INIT_LIST_HEAD(&hr_cq->sq_list);
+	INIT_LIST_HEAD(&hr_cq->rq_list);
 
 	if (udata) {
 		ret = create_user_cq(hr_dev, hr_cq, udata, &resp);
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 93c2210..8d2bcd8 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -498,6 +498,10 @@ struct hns_roce_cq {
 	u32				vector;
 	atomic_t			refcount;
 	struct completion		free;
+	struct list_head		sq_list; /* all qps on this send cq */
+	struct list_head		rq_list; /* all qps on this recv cq */
+	int				is_armed; /* cq is armed */
+	struct list_head		node; /* all armed cqs are on a list */
 };
 
 struct hns_roce_idx_que {
@@ -681,6 +685,9 @@ struct hns_roce_qp {
 	u32			next_sge;
 
 	struct hns_roce_rinl_buf rq_inl_buf;
+	struct list_head	node;		/* all qps are on a list */
+	struct list_head	rq_node;	/* all recv qps are on a list */
+	struct list_head	sq_node;	/* all send qps are on a list */
 };
 
 struct hns_roce_ib_iboe {
@@ -910,6 +917,12 @@ struct hns_roce_dfx_hw {
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
@@ -992,6 +1005,9 @@ struct hns_roce_dev {
 	bool			dis_db;
 	unsigned long		reset_cnt;
 	struct hns_roce_ib_iboe iboe;
+	enum hns_roce_device_state state;
+	struct list_head	qp_list; /* list of all qps on this dev */
+	spinlock_t		qp_list_lock; /* protect qp_list */
 
 	struct list_head        pgdir_list;
 	struct mutex            pgdir_mutex;
@@ -1255,6 +1271,7 @@ void hns_roce_cq_event(struct hns_roce_dev *hr_dev, u32 cqn, int event_type);
 void hns_roce_qp_event(struct hns_roce_dev *hr_dev, u32 qpn, int event_type);
 void hns_roce_srq_event(struct hns_roce_dev *hr_dev, u32 srqn, int event_type);
 int hns_get_gid_index(struct hns_roce_dev *hr_dev, u8 port, int gid_index);
+void hns_roce_handle_device_err(struct hns_roce_dev *hr_dev);
 int hns_roce_init(struct hns_roce_dev *hr_dev);
 void hns_roce_exit(struct hns_roce_dev *hr_dev);
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
index a31a214..c6e6658 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -3609,14 +3609,18 @@ int hns_roce_v1_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
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
index 00fd40f..4bc50f8 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -221,6 +221,30 @@ static int hns_roce_v2_modify_qp(struct ib_qp *ibqp,
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
@@ -242,28 +266,21 @@ static int hns_roce_v2_post_send(struct ib_qp *ibqp,
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
 	sge_idx = qp->next_sge;
 
 	for (nreq = 0; wr; ++nreq, wr = wr->next) {
@@ -600,6 +617,17 @@ static int hns_roce_v2_post_send(struct ib_qp *ibqp,
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
@@ -614,16 +642,17 @@ static int hns_roce_v2_post_recv(struct ib_qp *ibqp,
 	void *wqe = NULL;
 	int attr_mask;
 	u32 wqe_idx;
-	int ret = 0;
 	int nreq;
+	int ret;
 	int i;
 
 	spin_lock_irqsave(&hr_qp->rq.lock, flags);
 
-	if (hr_qp->state == IB_QPS_RESET) {
-		spin_unlock_irqrestore(&hr_qp->rq.lock, flags);
+	ret = check_recv_valid(hr_dev, hr_qp);
+	if (ret) {
 		*bad_wr = wr;
-		return -EINVAL;
+		nreq = 0;
+		goto out;
 	}
 
 	for (nreq = 0; wr; ++nreq, wr = wr->next) {
@@ -2664,6 +2693,55 @@ static int hns_roce_handle_recv_inl_wqe(struct hns_roce_v2_cqe *cqe,
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
@@ -2944,6 +3022,7 @@ static int hns_roce_v2_poll_one(struct hns_roce_cq *hr_cq,
 static int hns_roce_v2_poll_cq(struct ib_cq *ibcq, int num_entries,
 			       struct ib_wc *wc)
 {
+	struct hns_roce_dev *hr_dev = to_hr_dev(ibcq->device);
 	struct hns_roce_cq *hr_cq = to_hr_cq(ibcq);
 	struct hns_roce_qp *cur_qp = NULL;
 	unsigned long flags;
@@ -2951,6 +3030,18 @@ static int hns_roce_v2_poll_cq(struct ib_cq *ibcq, int num_entries,
 
 	spin_lock_irqsave(&hr_cq->lock, flags);
 
+	/*
+	 * When the device starts to reset, the state is RST_DOWN. At this time,
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
@@ -2962,6 +3053,7 @@ static int hns_roce_v2_poll_cq(struct ib_cq *ibcq, int num_entries,
 		hns_roce_v2_cq_set_ci(hr_cq, hr_cq->cons_index);
 	}
 
+out:
 	spin_unlock_irqrestore(&hr_cq->lock, flags);
 
 	return npolled;
@@ -4620,6 +4712,7 @@ static int hns_roce_v2_destroy_qp_common(struct hns_roce_dev *hr_dev,
 {
 	struct hns_roce_cq *send_cq, *recv_cq;
 	struct ib_device *ibdev = &hr_dev->ib_dev;
+	unsigned long flags;
 	int ret = 0;
 
 	if (hr_qp->ibqp.qp_type == IB_QPT_RC && hr_qp->state != IB_QPS_RESET) {
@@ -4630,21 +4723,32 @@ static int hns_roce_v2_destroy_qp_common(struct hns_roce_dev *hr_dev,
 			ibdev_err(ibdev, "modify QP to Reset failed.\n");
 	}
 
-	send_cq = to_hr_cq(hr_qp->ibqp.send_cq);
-	recv_cq = to_hr_cq(hr_qp->ibqp.recv_cq);
+	send_cq = hr_qp->ibqp.send_cq ? to_hr_cq(hr_qp->ibqp.send_cq) : NULL;
+	recv_cq = hr_qp->ibqp.recv_cq ? to_hr_cq(hr_qp->ibqp.recv_cq) : NULL;
 
+	spin_lock_irqsave(&hr_dev->qp_list_lock, flags);
 	hns_roce_lock_cqs(send_cq, recv_cq);
 
+	list_del(&hr_qp->node);
+	list_del(&hr_qp->sq_node);
+	list_del(&hr_qp->rq_node);
+
 	if (!udata) {
-		__hns_roce_v2_cq_clean(recv_cq, hr_qp->qpn, hr_qp->ibqp.srq ?
-				       to_hr_srq(hr_qp->ibqp.srq) : NULL);
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
+	spin_unlock_irqrestore(&hr_dev->qp_list_lock, flags);
 
 	hns_roce_qp_free(hr_dev, hr_qp);
 
@@ -6388,6 +6492,10 @@ static void __hns_roce_hw_v2_uninit_instance(struct hnae3_handle *handle,
 		return;
 
 	handle->priv = NULL;
+
+	hr_dev->state = HNS_ROCE_DEVICE_STATE_UNINIT;
+	hns_roce_handle_device_err(hr_dev);
+
 	hns_roce_exit(hr_dev);
 	kfree(hr_dev->priv);
 	ib_dealloc_device(&hr_dev->ib_dev);
@@ -6449,7 +6557,6 @@ static void hns_roce_hw_v2_uninit_instance(struct hnae3_handle *handle,
 static int hns_roce_hw_v2_reset_notify_down(struct hnae3_handle *handle)
 {
 	struct hns_roce_dev *hr_dev;
-	struct ib_event event;
 
 	if (handle->rinfo.instance_state != HNS_ROCE_STATE_INITED) {
 		set_bit(HNS_ROCE_RST_DIRECT_RETURN, &handle->rinfo.state);
@@ -6467,10 +6574,7 @@ static int hns_roce_hw_v2_reset_notify_down(struct hnae3_handle *handle)
 	hr_dev->active = false;
 	hr_dev->dis_db = true;
 
-	event.event = IB_EVENT_DEVICE_FATAL;
-	event.device = &hr_dev->ib_dev;
-	event.element.port_num = 1;
-	ib_dispatch_event(&event);
+	hr_dev->state = HNS_ROCE_DEVICE_STATE_RST_DOWN;
 
 	return 0;
 }
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 84e4707..6e589f2 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -862,6 +862,50 @@ static int hns_roce_setup_hca(struct hns_roce_dev *hr_dev)
 	return ret;
 }
 
+static void check_and_get_armed_cq(struct list_head *cq_list, struct ib_cq *cq)
+{
+	struct hns_roce_cq *hr_cq = to_hr_cq(cq);
+	unsigned long flags;
+
+	spin_lock_irqsave(&hr_cq->lock, flags);
+	if (cq->comp_handler) {
+		if (!hr_cq->is_armed) {
+			hr_cq->is_armed = 1;
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
+	spin_lock_irqsave(&hr_dev->qp_list_lock, flags);
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
+		hns_roce_cq_completion(hr_dev, hr_cq->cqn);
+
+	spin_unlock_irqrestore(&hr_dev->qp_list_lock, flags);
+}
+
 int hns_roce_init(struct hns_roce_dev *hr_dev)
 {
 	int ret;
@@ -932,6 +976,9 @@ int hns_roce_init(struct hns_roce_dev *hr_dev)
 		}
 	}
 
+	INIT_LIST_HEAD(&hr_dev->qp_list);
+	spin_lock_init(&hr_dev->qp_list_lock);
+
 	ret = hns_roce_register_device(hr_dev);
 	if (ret)
 		goto error_failed_register_device;
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index c5b01ec..7c8de1e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -677,6 +677,29 @@ static void free_rq_inline_buf(struct hns_roce_qp *hr_qp)
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
 static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 				     struct ib_pd *ib_pd,
 				     struct ib_qp_init_attr *init_attr,
@@ -946,6 +969,9 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 	}
 
 	hr_qp->event = hns_roce_ib_qp_event;
+
+	add_qp_to_list(hr_dev, hr_qp, init_attr->send_cq, init_attr->recv_cq);
+
 	hns_roce_free_buf_list(buf_list, hr_qp->region_cnt);
 
 	return 0;
@@ -1228,7 +1254,16 @@ int hns_roce_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
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
@@ -1244,7 +1279,16 @@ void hns_roce_unlock_cqs(struct hns_roce_cq *send_cq,
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

