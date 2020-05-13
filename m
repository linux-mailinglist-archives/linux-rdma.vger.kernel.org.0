Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4BAF1D11D5
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2020 13:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731493AbgEMLxD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 May 2020 07:53:03 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:41418 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731447AbgEMLxC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 13 May 2020 07:53:02 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from yaminf@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 13 May 2020 14:52:55 +0300
Received: from arch012.mtl.labs.mlnx. (arch012.mtl.labs.mlnx [10.7.13.12])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 04DBqs6h006542;
        Wed, 13 May 2020 14:52:54 +0300
From:   Yamin Friedman <yaminf@mellanox.com>
To:     Jason Gunthorpe <jgg@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
Cc:     linux-rdma@vger.kernel.org, Yamin Friedman <yaminf@mellanox.com>
Subject: [PATCH V2 3/4] nvme-rdma: use new shared CQ mechanism
Date:   Wed, 13 May 2020 14:52:42 +0300
Message-Id: <1589370763-81205-4-git-send-email-yaminf@mellanox.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1589370763-81205-1-git-send-email-yaminf@mellanox.com>
References: <1589370763-81205-1-git-send-email-yaminf@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Has the driver use shared CQs providing ~10%-20% improvement as seen in the
patch introducing shared CQs. Instead of opening a CQ for each QP per
controller connected, a CQ for each QP will be provided by the RDMA core
driver that will be shared between the QPs on that core reducing interrupt
overhead.

Signed-off-by: Yamin Friedman <yaminf@mellanox.com>
Reviewed-by: Or Gerlitz <ogerlitz@mellanox.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
---
 drivers/nvme/host/rdma.c | 75 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 50 insertions(+), 25 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index cac8a93..83d5f29 100644
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
 
@@ -389,6 +391,14 @@ static int nvme_rdma_dev_get(struct nvme_rdma_device *dev)
 	return NULL;
 }
 
+static void nvme_rdma_free_cq(struct nvme_rdma_queue *queue)
+{
+	if (nvme_rdma_poll_queue(queue))
+		ib_free_cq(queue->ib_cq);
+	else
+		ib_cq_pool_put(queue->ib_cq, queue->cq_size);
+}
+
 static void nvme_rdma_destroy_queue_ib(struct nvme_rdma_queue *queue)
 {
 	struct nvme_rdma_device *dev;
@@ -408,7 +418,7 @@ static void nvme_rdma_destroy_queue_ib(struct nvme_rdma_queue *queue)
 	 * the destruction of the QP shouldn't use rdma_cm API.
 	 */
 	ib_destroy_qp(queue->qp);
-	ib_free_cq(queue->ib_cq);
+	nvme_rdma_free_cq(queue);
 
 	nvme_rdma_free_ring(ibdev, queue->rsp_ring, queue->queue_size,
 			sizeof(struct nvme_completion), DMA_FROM_DEVICE);
@@ -422,13 +432,42 @@ static int nvme_rdma_get_max_fr_pages(struct ib_device *ibdev)
 		     ibdev->attrs.max_fast_reg_page_list_len - 1);
 }
 
+static int nvme_rdma_create_cq(struct ib_device *ibdev,
+				struct nvme_rdma_queue *queue)
+{
+	int ret, comp_vector, idx = nvme_rdma_queue_idx(queue);
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
+
+	if (IS_ERR(queue->ib_cq)) {
+		ret = PTR_ERR(queue->ib_cq);
+		return ret;
+	}
+
+	return 0;
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
@@ -439,26 +478,12 @@ static int nvme_rdma_create_queue_ib(struct nvme_rdma_queue *queue)
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
-	if (IS_ERR(queue->ib_cq)) {
-		ret = PTR_ERR(queue->ib_cq);
+	queue->cq_size = cq_factor * queue->queue_size + 1;
+
+	ret = nvme_rdma_create_cq(ibdev, queue);
+	if (ret)
 		goto out_put_dev;
-	}
 
 	ret = nvme_rdma_create_qp(queue, send_wr_factor);
 	if (ret)
@@ -484,7 +509,7 @@ static int nvme_rdma_create_queue_ib(struct nvme_rdma_queue *queue)
 	if (ret) {
 		dev_err(queue->ctrl->ctrl.device,
 			"failed to initialize MR pool sized %d for QID %d\n",
-			queue->queue_size, idx);
+			queue->queue_size, nvme_rdma_queue_idx(queue));
 		goto out_destroy_ring;
 	}
 
@@ -498,7 +523,7 @@ static int nvme_rdma_create_queue_ib(struct nvme_rdma_queue *queue)
 out_destroy_qp:
 	rdma_destroy_qp(queue->cm_id);
 out_destroy_ib_cq:
-	ib_free_cq(queue->ib_cq);
+	nvme_rdma_free_cq(queue);
 out_put_dev:
 	nvme_rdma_dev_put(queue->device);
 	return ret;
@@ -1093,7 +1118,7 @@ static void nvme_rdma_error_recovery(struct nvme_rdma_ctrl *ctrl)
 static void nvme_rdma_wr_error(struct ib_cq *cq, struct ib_wc *wc,
 		const char *op)
 {
-	struct nvme_rdma_queue *queue = cq->cq_context;
+	struct nvme_rdma_queue *queue = wc->qp->qp_context;
 	struct nvme_rdma_ctrl *ctrl = queue->ctrl;
 
 	if (ctrl->ctrl.state == NVME_CTRL_LIVE)
@@ -1481,7 +1506,7 @@ static void nvme_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc)
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

