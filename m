Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE09810976
	for <lists+linux-rdma@lfdr.de>; Wed,  1 May 2019 16:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfEAOpF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 1 May 2019 10:45:05 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:40165 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727084AbfEAOpD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 1 May 2019 10:45:03 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from talgi@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 1 May 2019 17:44:54 +0300
Received: from gen-l-vrt-692.mtl.labs.mlnx (gen-l-vrt-692.mtl.labs.mlnx [10.141.69.20])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x41EisrF019859;
        Wed, 1 May 2019 17:44:54 +0300
Received: from gen-l-vrt-692.mtl.labs.mlnx (localhost [127.0.0.1])
        by gen-l-vrt-692.mtl.labs.mlnx (8.14.7/8.14.7) with ESMTP id x41Eis9u036056;
        Wed, 1 May 2019 17:44:54 +0300
Received: (from talgi@localhost)
        by gen-l-vrt-692.mtl.labs.mlnx (8.14.7/8.14.7/Submit) id x41EirwW036055;
        Wed, 1 May 2019 17:44:53 +0300
From:   Tal Gilboa <talgi@mellanox.com>
To:     linux-rdma@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Cc:     Yishai Hadas <yishaih@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Tal Gilboa <talgi@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Idan Burstein <idanb@mellanox.com>,
        Yamin Friedman <yaminf@mellanox.com>,
        Max Gurtovoy <maxg@mellanox.com>
Subject: [PATCH rdma-for-next 9/9] drivers/infiniband: Use rdma_dim in infiniband driver
Date:   Wed,  1 May 2019 17:44:39 +0300
Message-Id: <1556721879-35987-10-git-send-email-talgi@mellanox.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1556721879-35987-1-git-send-email-talgi@mellanox.com>
References: <1556721879-35987-1-git-send-email-talgi@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yamin Friedman <yaminf@mellanox.com>

Added the interface in the infiniband driver that applies the rdma_dim
adaptive moderation. There is now a special function for allocating an
ib_cq that uses rdma_dim.

Performance improvement (ConnectX-5 100GbE, x86) running FIO benchmark over
NVMf between two equal end-hosts with 56 cores across a Mellanox switch
using null_blk device:

READS without DIM:
blk size | BW       | IOPS | 99th percentile latency  | 99.99th latency
512B     | 3.8GiB/s | 7.7M | 1401  usec               | 2442  usec
4k       | 7.0GiB/s | 1.8M | 4817  usec               | 6587  usec
64k      | 10.7GiB/s| 175k | 9896  usec               | 10028 usec

IO WRITES without DIM:
blk size | BW       | IOPS | 99th percentile latency  | 99.99th latency
512B     | 3.6GiB/s | 7.5M | 1434  usec               | 2474  usec
4k       | 6.3GiB/s | 1.6M | 938   usec               | 1221  usec
64k      | 10.7GiB/s| 175k | 8979  usec               | 12780 usec

IO READS with DIM:
blk size | BW       | IOPS | 99th percentile latency  | 99.99th latency
512B     | 4GiB/s   | 8.2M | 816    usec              | 889   usec
4k       | 10.1GiB/s| 2.65M| 3359   usec              | 5080  usec
64k      | 10.7GiB/s| 175k | 9896   usec              | 10028 usec

IO WRITES with DIM:
blk size | BW       | IOPS  | 99th percentile latency | 99.99th latency
512B     | 3.9GiB/s | 8.1M  | 799   usec              | 922   usec
4k       | 9.6GiB/s | 2.5M  | 717   usec              | 1004  usec
64k      | 10.7GiB/s| 176k  | 8586  usec              | 12256 usec

The rdma_dim algorithm was designed to measure the effectiveness of
moderation on the flow in a general way and thus should be appropriate
for all RDMA storage protocols.

Signed-off-by: Yamin Friedman <yaminf@mellanox.com>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
Signed-off-by: Tal Gilboa <talgi@mellanox.com>
---
 drivers/infiniband/core/cq.c    | 79 +++++++++++++++++++++++++++++++++++++----
 drivers/infiniband/hw/mlx4/qp.c |  2 +-
 drivers/infiniband/hw/mlx5/qp.c |  2 +-
 include/linux/irq_poll.h        |  5 +++
 include/rdma/ib_verbs.h         | 54 +++++++++++++++++++++++++---
 lib/irq_poll.c                  | 15 +++++++-
 6 files changed, 144 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
index a4c8199..6fb3270 100644
--- a/drivers/infiniband/core/cq.c
+++ b/drivers/infiniband/core/cq.c
@@ -14,6 +14,7 @@
 #include <linux/err.h>
 #include <linux/slab.h>
 #include <rdma/ib_verbs.h>
+#include <linux/rdma_dim.h>
 
 /* # of WCs to poll for with a single call to ib_poll_cq */
 #define IB_POLL_BATCH			16
@@ -26,6 +27,47 @@
 #define IB_POLL_FLAGS \
 	(IB_CQ_NEXT_COMP | IB_CQ_REPORT_MISSED_EVENTS)
 
+static int ib_cq_dim_modify_cq(struct ib_cq *cq, unsigned short level)
+{
+	u16 usec = rdma_dim_prof[level].usec;
+	u16 comps = rdma_dim_prof[level].comps;
+
+	return cq->device->ops.modify_cq(cq, comps, usec);
+}
+
+static void update_cq_moderation(struct dim *dim, struct ib_cq *cq)
+{
+	dim->state = DIM_START_MEASURE;
+
+	ib_cq_dim_modify_cq(cq, dim->profile_ix);
+}
+
+static void ib_cq_rdma_dim_workqueue_work(struct work_struct *w)
+{
+	struct dim *dim = container_of(w, struct dim, work);
+	struct ib_cq *cq = container_of(dim, struct ib_cq, workqueue_poll.dim);
+
+	update_cq_moderation(dim, cq);
+}
+
+static void ib_cq_rdma_dim_irqpoll_work(struct work_struct *w)
+{
+	struct dim *dim = container_of(w, struct dim, work);
+	struct irq_poll *iop = container_of(dim, struct irq_poll, dim);
+	struct ib_cq *cq = container_of(iop, struct ib_cq, iop);
+
+	update_cq_moderation(dim, cq);
+}
+
+void rdma_dim_init(struct dim *dim, work_func_t func)
+{
+	memset(dim, 0, sizeof(*dim));
+	dim->state = DIM_START_MEASURE;
+	dim->tune_state = DIM_GOING_RIGHT;
+	dim->profile_ix = RDMA_DIM_START_PROFILE;
+	INIT_WORK(&dim->work, func);
+}
+
 static int __ib_process_cq(struct ib_cq *cq, int budget, struct ib_wc *wcs,
 			   int batch)
 {
@@ -105,19 +147,30 @@ static void ib_cq_completion_softirq(struct ib_cq *cq, void *private)
 
 static void ib_cq_poll_work(struct work_struct *work)
 {
-	struct ib_cq *cq = container_of(work, struct ib_cq, work);
+	struct ib_cq *cq = container_of(work, struct ib_cq,
+					workqueue_poll.work);
 	int completed;
+	struct dim_sample e_sample;
+	struct dim_sample *m_sample = &cq->workqueue_poll.dim.measuring_sample;
 
 	completed = __ib_process_cq(cq, IB_POLL_BUDGET_WORKQUEUE, cq->wc,
 				    IB_POLL_BATCH);
+
+	if (cq->workqueue_poll.dim_used)
+		dim_create_sample(m_sample->event_ctr + 1, m_sample->pkt_ctr,
+				  m_sample->byte_ctr,
+				  m_sample->comp_ctr + completed, &e_sample);
+
 	if (completed >= IB_POLL_BUDGET_WORKQUEUE ||
 	    ib_req_notify_cq(cq, IB_POLL_FLAGS) > 0)
-		queue_work(cq->comp_wq, &cq->work);
+		queue_work(cq->comp_wq, &cq->workqueue_poll.work);
+	else if (cq->workqueue_poll.dim_used)
+		rdma_dim(&cq->workqueue_poll.dim, &e_sample);
 }
 
 static void ib_cq_completion_workqueue(struct ib_cq *cq, void *private)
 {
-	queue_work(cq->comp_wq, &cq->work);
+	queue_work(cq->comp_wq, &cq->workqueue_poll.work);
 }
 
 /**
@@ -129,6 +182,7 @@ static void ib_cq_completion_workqueue(struct ib_cq *cq, void *private)
  * @poll_ctx:		context to poll the CQ from.
  * @caller:		module owner name.
  * @udata:		Valid user data or NULL for kernel object
+ * @use_dim:		use dynamic interrupt moderation
  *
  * This is the proper interface to allocate a CQ for in-kernel users. A
  * CQ allocated with this interface will automatically be polled from the
@@ -138,7 +192,8 @@ static void ib_cq_completion_workqueue(struct ib_cq *cq, void *private)
 struct ib_cq *__ib_alloc_cq_user(struct ib_device *dev, void *private,
 				 int nr_cqe, int comp_vector,
 				 enum ib_poll_context poll_ctx,
-				 const char *caller, struct ib_udata *udata)
+				 const char *caller, struct ib_udata *udata,
+				 bool use_dim)
 {
 	struct ib_cq_init_attr cq_attr = {
 		.cqe		= nr_cqe,
@@ -174,12 +229,22 @@ struct ib_cq *__ib_alloc_cq_user(struct ib_device *dev, void *private,
 		cq->comp_handler = ib_cq_completion_softirq;
 
 		irq_poll_init(&cq->iop, IB_POLL_BUDGET_IRQ, ib_poll_handler);
+		if (cq->device->ops.modify_cq && use_dim) {
+			rdma_dim_init(&cq->iop.dim,
+				      ib_cq_rdma_dim_irqpoll_work);
+			cq->iop.dim_used = true;
+		}
 		ib_req_notify_cq(cq, IB_CQ_NEXT_COMP);
 		break;
 	case IB_POLL_WORKQUEUE:
 	case IB_POLL_UNBOUND_WORKQUEUE:
 		cq->comp_handler = ib_cq_completion_workqueue;
-		INIT_WORK(&cq->work, ib_cq_poll_work);
+		INIT_WORK(&cq->workqueue_poll.work, ib_cq_poll_work);
+		if (cq->device->ops.modify_cq && use_dim) {
+			rdma_dim_init(&cq->workqueue_poll.dim,
+				      ib_cq_rdma_dim_workqueue_work);
+			cq->workqueue_poll.dim_used = true;
+		}
 		ib_req_notify_cq(cq, IB_CQ_NEXT_COMP);
 		cq->comp_wq = (cq->poll_ctx == IB_POLL_WORKQUEUE) ?
 				ib_comp_wq : ib_comp_unbound_wq;
@@ -220,7 +285,9 @@ void ib_free_cq_user(struct ib_cq *cq, struct ib_udata *udata)
 		break;
 	case IB_POLL_WORKQUEUE:
 	case IB_POLL_UNBOUND_WORKQUEUE:
-		cancel_work_sync(&cq->work);
+		cancel_work_sync(&cq->workqueue_poll.work);
+		if (cq->workqueue_poll.dim_used)
+			flush_work(&cq->iop.dim.work);
 		break;
 	default:
 		WARN_ON_ONCE(1);
diff --git a/drivers/infiniband/hw/mlx4/qp.c b/drivers/infiniband/hw/mlx4/qp.c
index 364e16b..b9b550b 100644
--- a/drivers/infiniband/hw/mlx4/qp.c
+++ b/drivers/infiniband/hw/mlx4/qp.c
@@ -4385,7 +4385,7 @@ static void handle_drain_completion(struct ib_cq *cq,
 				irq_poll_enable(&cq->iop);
 				break;
 			case IB_POLL_WORKQUEUE:
-				cancel_work_sync(&cq->work);
+				cancel_work_sync(&cq->workqueue_poll.work);
 				break;
 			default:
 				WARN_ON_ONCE(1);
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index efe1f6f..ccee41a 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -6267,7 +6267,7 @@ static void handle_drain_completion(struct ib_cq *cq,
 				irq_poll_enable(&cq->iop);
 				break;
 			case IB_POLL_WORKQUEUE:
-				cancel_work_sync(&cq->work);
+				cancel_work_sync(&cq->workqueue_poll.work);
 				break;
 			default:
 				WARN_ON_ONCE(1);
diff --git a/include/linux/irq_poll.h b/include/linux/irq_poll.h
index 16aaecc..3601e75 100644
--- a/include/linux/irq_poll.h
+++ b/include/linux/irq_poll.h
@@ -2,6 +2,8 @@
 #ifndef IRQ_POLL_H
 #define IRQ_POLL_H
 
+#include <linux/rdma_dim.h>
+
 struct irq_poll;
 typedef int (irq_poll_fn)(struct irq_poll *, int);
 
@@ -10,6 +12,9 @@ struct irq_poll {
 	unsigned long state;
 	int weight;
 	irq_poll_fn *poll;
+
+	bool dim_used;
+	struct dim dim;
 };
 
 enum {
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 737ef5e..0a92549 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1587,6 +1587,12 @@ enum ib_poll_context {
 	IB_POLL_UNBOUND_WORKQUEUE, /* poll from unbound workqueue */
 };
 
+struct ib_cq_workqueue_poll {
+	struct dim              dim;
+	struct work_struct      work;
+	bool                    dim_used;
+};
+
 struct ib_cq {
 	struct ib_device       *device;
 	struct ib_uobject      *uobject;
@@ -1598,8 +1604,8 @@ struct ib_cq {
 	enum ib_poll_context	poll_ctx;
 	struct ib_wc		*wc;
 	union {
-		struct irq_poll		iop;
-		struct work_struct	work;
+		struct irq_poll			iop;
+		struct ib_cq_workqueue_poll	workqueue_poll;
 	};
 	struct workqueue_struct *comp_wq;
 	/*
@@ -3628,7 +3634,8 @@ static inline int ib_post_recv(struct ib_qp *qp,
 struct ib_cq *__ib_alloc_cq_user(struct ib_device *dev, void *private,
 				 int nr_cqe, int comp_vector,
 				 enum ib_poll_context poll_ctx,
-				 const char *caller, struct ib_udata *udata);
+				 const char *caller, struct ib_udata *udata,
+				 bool use_dim);
 
 /**
  * ib_alloc_cq_user: Allocate kernel/user CQ
@@ -3646,7 +3653,27 @@ static inline struct ib_cq *ib_alloc_cq_user(struct ib_device *dev,
 					     struct ib_udata *udata)
 {
 	return __ib_alloc_cq_user(dev, private, nr_cqe, comp_vector, poll_ctx,
-				  KBUILD_MODNAME, udata);
+				  KBUILD_MODNAME, udata, false);
+}
+
+/**
+ * ib_alloc_cq_user_dim: Allocate kernel/user CQ with dynamic interrupt
+ * moderation
+ * @dev: The IB device
+ * @private: Private data attached to the CQE
+ * @nr_cqe: Number of CQEs in the CQ
+ * @comp_vector: Completion vector used for the IRQs
+ * @poll_ctx: Context used for polling the CQ
+ * @udata: Valid user data or NULL for kernel objects
+ */
+static inline struct ib_cq *ib_alloc_cq_user_dim(struct ib_device *dev,
+						 void *private, int nr_cqe,
+						 int comp_vector,
+						 enum ib_poll_context poll_ctx,
+						 struct ib_udata *udata)
+{
+	return __ib_alloc_cq_user(dev, private, nr_cqe, comp_vector, poll_ctx,
+				  KBUILD_MODNAME, udata, true);
 }
 
 /**
@@ -3668,6 +3695,25 @@ static inline struct ib_cq *ib_alloc_cq(struct ib_device *dev, void *private,
 }
 
 /**
+ * ib_alloc_cq_dim: Allocate kernel CQ with dynamic interrupt moderation
+ * @dev: The IB device
+ * @private: Private data attached to the CQE
+ * @nr_cqe: Number of CQEs in the CQ
+ * @comp_vector: Completion vector used for the IRQs
+ * @poll_ctx: Context used for polling the CQ
+ *
+ * NOTE: for user cq use ib_alloc_cq_user with valid udata!
+ */
+static inline struct ib_cq *ib_alloc_cq_dim(struct ib_device *dev,
+					    void *private, int nr_cqe,
+					    int comp_vector,
+					    enum ib_poll_context poll_ctx)
+{
+	return ib_alloc_cq_user_dim(dev, private, nr_cqe, comp_vector,
+				    poll_ctx, NULL);
+}
+
+/**
  * ib_free_cq_user - Free kernel/user CQ
  * @cq: The CQ to free
  * @udata: Valid user data or NULL for kernel objects
diff --git a/lib/irq_poll.c b/lib/irq_poll.c
index 2f17b48..c63bc9b 100644
--- a/lib/irq_poll.c
+++ b/lib/irq_poll.c
@@ -50,6 +50,8 @@ void irq_poll_sched(struct irq_poll *iop)
  **/
 static void __irq_poll_complete(struct irq_poll *iop)
 {
+	if (iop->dim_used)
+		rdma_dim(&iop->dim, &iop->dim.measuring_sample);
 	list_del(&iop->list);
 	smp_mb__before_atomic();
 	clear_bit_unlock(IRQ_POLL_F_SCHED, &iop->state);
@@ -86,6 +88,7 @@ static void __latent_entropy irq_poll_softirq(struct softirq_action *h)
 	while (!list_empty(list)) {
 		struct irq_poll *iop;
 		int work, weight;
+		struct dim_sample *m_sample;
 
 		/*
 		 * If softirq window is exhausted then punt.
@@ -104,10 +107,18 @@ static void __latent_entropy irq_poll_softirq(struct softirq_action *h)
 		 */
 		iop = list_entry(list->next, struct irq_poll, list);
 
+		m_sample = &iop->dim.measuring_sample;
 		weight = iop->weight;
 		work = 0;
-		if (test_bit(IRQ_POLL_F_SCHED, &iop->state))
+		if (test_bit(IRQ_POLL_F_SCHED, &iop->state)) {
 			work = iop->poll(iop, weight);
+			if (iop->dim_used)
+				dim_create_sample(m_sample->event_ctr + 1,
+						  m_sample->pkt_ctr,
+						  m_sample->byte_ctr,
+						  m_sample->comp_ctr + work,
+						  &iop->dim.measuring_sample);
+		}
 
 		budget -= work;
 
@@ -144,6 +155,8 @@ static void __latent_entropy irq_poll_softirq(struct softirq_action *h)
  **/
 void irq_poll_disable(struct irq_poll *iop)
 {
+	if (iop->dim_used)
+		flush_work(&iop->dim.work);
 	set_bit(IRQ_POLL_F_DISABLE, &iop->state);
 	while (test_and_set_bit(IRQ_POLL_F_SCHED, &iop->state))
 		msleep(1);
-- 
1.8.3.1

