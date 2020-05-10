Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC25B1CCBB1
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2020 16:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgEJO4K (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 10 May 2020 10:56:10 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:45493 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728360AbgEJO4J (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 10 May 2020 10:56:09 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from yaminf@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 10 May 2020 17:56:07 +0300
Received: from arch012.mtl.labs.mlnx. (arch012.mtl.labs.mlnx [10.7.13.12])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 04AEu6eI007532;
        Sun, 10 May 2020 17:56:07 +0300
From:   Yamin Friedman <yaminf@mellanox.com>
To:     Jason Gunthorpe <jgg@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-rdma@vger.kernel.org, Yamin Friedman <yaminf@mellanox.com>
Subject: [PATCH 3/4] nvme-rdma: use new shared CQ mechanism
Date:   Sun, 10 May 2020 17:55:56 +0300
Message-Id: <1589122557-88996-4-git-send-email-yaminf@mellanox.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1589122557-88996-1-git-send-email-yaminf@mellanox.com>
References: <1589122557-88996-1-git-send-email-yaminf@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Has the driver use shared CQs providing ~10%-50% improvement as seen in the
patch introducing shared CQs. Instead of opening a CQ on each core per NS
connected, a CQ for each core will be provided by the core driver that will
be shared between the QPs on that core reducing interrupt overhead.

Signed-off-by: Yamin Friedman <yaminf@mellanox.com>
Reviewed-by: Or Gerlitz <ogerlitz@mellanox.com>
---
 drivers/nvme/host/rdma.c | 65 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 43 insertions(+), 22 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index cac8a93..23eefd7 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -85,6 +85,7 @@ struct nvme_rdma_queue {
 	struct rdma_cm_id	*cm_id;
 	int			cm_error;
 	struct completion	cm_done;
+	int			cq_size;
 };
 
 struct nvme_rdma_ctrl {
@@ -261,6 +262,7 @@ static int nvme_rdma_create_qp(struct nvme_rdma_queue *queue, const int factor)
 	init_attr.qp_type = IB_QPT_RC;
 	init_attr.send_cq = queue->ib_cq;
 	init_attr.recv_cq = queue->ib_cq;
+	init_attr.qp_context = queue;
 
 	ret = rdma_create_qp(queue->cm_id, dev->pd, &init_attr);
 
@@ -389,6 +391,15 @@ static int nvme_rdma_dev_get(struct nvme_rdma_device *dev)
 	return NULL;
 }
 
+static void nvme_rdma_free_cq(struct nvme_rdma_queue *queue)
+{
+	if (nvme_rdma_poll_queue(queue))
+		ib_free_cq(queue->ib_cq);
+	else {
+		ib_cq_pool_put(queue->ib_cq, queue->cq_size);
+	}
+}
+
 static void nvme_rdma_destroy_queue_ib(struct nvme_rdma_queue *queue)
 {
 	struct nvme_rdma_device *dev;
@@ -408,7 +419,7 @@ static void nvme_rdma_destroy_queue_ib(struct nvme_rdma_queue *queue)
 	 * the destruction of the QP shouldn't use rdma_cm API.
 	 */
 	ib_destroy_qp(queue->qp);
-	ib_free_cq(queue->ib_cq);
+	nvme_rdma_free_cq(queue);
 
 	nvme_rdma_free_ring(ibdev, queue->rsp_ring, queue->queue_size,
 			sizeof(struct nvme_completion), DMA_FROM_DEVICE);
@@ -422,13 +433,35 @@ static int nvme_rdma_get_max_fr_pages(struct ib_device *ibdev)
 		     ibdev->attrs.max_fast_reg_page_list_len - 1);
 }
 
+static void nvme_rdma_create_cq(struct ib_device *ibdev,
+				struct nvme_rdma_queue *queue)
+{
+	int comp_vector, idx = nvme_rdma_queue_idx(queue);
+	enum ib_poll_context poll_ctx;
+
+	/*
+	 * Spread I/O queues completion vectors according their queue index.
+	 * Admin queues can always go on completion vector 0.
+	 */
+	comp_vector = idx == 0 ? idx : idx - 1;
+
+	/* Polling queues need direct cq polling context */
+	if (nvme_rdma_poll_queue(queue)) {
+		poll_ctx = IB_POLL_DIRECT;
+		queue->ib_cq = ib_alloc_cq(ibdev, queue, queue->cq_size,
+					   comp_vector, poll_ctx);
+	} else {
+		poll_ctx = IB_POLL_SOFTIRQ;
+		queue->ib_cq = ib_cq_pool_get(ibdev, queue->cq_size,
+					      comp_vector, poll_ctx);
+	}
+}
+
 static int nvme_rdma_create_queue_ib(struct nvme_rdma_queue *queue)
 {
 	struct ib_device *ibdev;
 	const int send_wr_factor = 3;			/* MR, SEND, INV */
 	const int cq_factor = send_wr_factor + 1;	/* + RECV */
-	int comp_vector, idx = nvme_rdma_queue_idx(queue);
-	enum ib_poll_context poll_ctx;
 	int ret, pages_per_mr;
 
 	queue->device = nvme_rdma_find_get_device(queue->cm_id);
@@ -439,22 +472,10 @@ static int nvme_rdma_create_queue_ib(struct nvme_rdma_queue *queue)
 	}
 	ibdev = queue->device->dev;
 
-	/*
-	 * Spread I/O queues completion vectors according their queue index.
-	 * Admin queues can always go on completion vector 0.
-	 */
-	comp_vector = idx == 0 ? idx : idx - 1;
-
-	/* Polling queues need direct cq polling context */
-	if (nvme_rdma_poll_queue(queue))
-		poll_ctx = IB_POLL_DIRECT;
-	else
-		poll_ctx = IB_POLL_SOFTIRQ;
-
 	/* +1 for ib_stop_cq */
-	queue->ib_cq = ib_alloc_cq(ibdev, queue,
-				cq_factor * queue->queue_size + 1,
-				comp_vector, poll_ctx);
+	queue->cq_size = cq_factor * queue->queue_size + 1;
+
+	nvme_rdma_create_cq(ibdev, queue);
 	if (IS_ERR(queue->ib_cq)) {
 		ret = PTR_ERR(queue->ib_cq);
 		goto out_put_dev;
@@ -484,7 +505,7 @@ static int nvme_rdma_create_queue_ib(struct nvme_rdma_queue *queue)
 	if (ret) {
 		dev_err(queue->ctrl->ctrl.device,
 			"failed to initialize MR pool sized %d for QID %d\n",
-			queue->queue_size, idx);
+			queue->queue_size, nvme_rdma_queue_idx(queue));
 		goto out_destroy_ring;
 	}
 
@@ -498,7 +519,7 @@ static int nvme_rdma_create_queue_ib(struct nvme_rdma_queue *queue)
 out_destroy_qp:
 	rdma_destroy_qp(queue->cm_id);
 out_destroy_ib_cq:
-	ib_free_cq(queue->ib_cq);
+	nvme_rdma_free_cq(queue);
 out_put_dev:
 	nvme_rdma_dev_put(queue->device);
 	return ret;
@@ -1093,7 +1114,7 @@ static void nvme_rdma_error_recovery(struct nvme_rdma_ctrl *ctrl)
 static void nvme_rdma_wr_error(struct ib_cq *cq, struct ib_wc *wc,
 		const char *op)
 {
-	struct nvme_rdma_queue *queue = cq->cq_context;
+	struct nvme_rdma_queue *queue = wc->qp->qp_context;
 	struct nvme_rdma_ctrl *ctrl = queue->ctrl;
 
 	if (ctrl->ctrl.state == NVME_CTRL_LIVE)
@@ -1481,7 +1502,7 @@ static void nvme_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc)
 {
 	struct nvme_rdma_qe *qe =
 		container_of(wc->wr_cqe, struct nvme_rdma_qe, cqe);
-	struct nvme_rdma_queue *queue = cq->cq_context;
+	struct nvme_rdma_queue *queue = wc->qp->qp_context;
 	struct ib_device *ibdev = queue->device->dev;
 	struct nvme_completion *cqe = qe->data;
 	const size_t len = sizeof(struct nvme_completion);
-- 
1.8.3.1

