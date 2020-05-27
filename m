Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 172291E3C1C
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2020 10:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387859AbgE0IfA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 May 2020 04:35:00 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:49897 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388074AbgE0IfA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 27 May 2020 04:35:00 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from yaminf@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 27 May 2020 11:34:57 +0300
Received: from arch012.mtl.labs.mlnx. (arch012.mtl.labs.mlnx [10.7.13.12])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 04R8YvRZ003290;
        Wed, 27 May 2020 11:34:57 +0300
From:   Yamin Friedman <yaminf@mellanox.com>
To:     Jason Gunthorpe <jgg@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>,
        Leon Romanovsky <leonro@mellanox.com>
Cc:     linux-rdma@vger.kernel.org, Yamin Friedman <yaminf@mellanox.com>
Subject: [PATCH V4 4/4] nvmet-rdma: use new shared CQ mechanism
Date:   Wed, 27 May 2020 11:34:55 +0300
Message-Id: <1590568495-101621-5-git-send-email-yaminf@mellanox.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1590568495-101621-1-git-send-email-yaminf@mellanox.com>
References: <1590568495-101621-1-git-send-email-yaminf@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Has the driver use shared CQs providing ~10%-20% improvement when multiple
disks are used. Instead of opening a CQ for each QP per controller, a CQ
for each core will be provided by the RDMA core driver that will be shared
between the QPs on that core reducing interrupt overhead.

Signed-off-by: Yamin Friedman <yaminf@mellanox.com>
Reviewed-by: Or Gerlitz <ogerlitz@mellanox.com>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/rdma.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index fd47de0..50e4c40 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -588,7 +588,7 @@ static void nvmet_rdma_read_data_done(struct ib_cq *cq, struct ib_wc *wc)
 {
 	struct nvmet_rdma_rsp *rsp =
 		container_of(wc->wr_cqe, struct nvmet_rdma_rsp, read_cqe);
-	struct nvmet_rdma_queue *queue = cq->cq_context;
+	struct nvmet_rdma_queue *queue = wc->qp->qp_context;
 
 	WARN_ON(rsp->n_rdma <= 0);
 	atomic_add(rsp->n_rdma, &queue->sq_wr_avail);
@@ -793,7 +793,7 @@ static void nvmet_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc)
 {
 	struct nvmet_rdma_cmd *cmd =
 		container_of(wc->wr_cqe, struct nvmet_rdma_cmd, cqe);
-	struct nvmet_rdma_queue *queue = cq->cq_context;
+	struct nvmet_rdma_queue *queue = wc->qp->qp_context;
 	struct nvmet_rdma_rsp *rsp;
 
 	if (unlikely(wc->status != IB_WC_SUCCESS)) {
@@ -995,9 +995,8 @@ static int nvmet_rdma_create_queue_ib(struct nvmet_rdma_queue *queue)
 	 */
 	nr_cqe = queue->recv_queue_size + 2 * queue->send_queue_size;
 
-	queue->cq = ib_alloc_cq(ndev->device, queue,
-			nr_cqe + 1, comp_vector,
-			IB_POLL_WORKQUEUE);
+	queue->cq = ib_cq_pool_get(ndev->device, nr_cqe + 1, comp_vector,
+				   IB_POLL_WORKQUEUE);
 	if (IS_ERR(queue->cq)) {
 		ret = PTR_ERR(queue->cq);
 		pr_err("failed to create CQ cqe= %d ret= %d\n",
@@ -1056,7 +1055,7 @@ static int nvmet_rdma_create_queue_ib(struct nvmet_rdma_queue *queue)
 err_destroy_qp:
 	rdma_destroy_qp(queue->cm_id);
 err_destroy_cq:
-	ib_free_cq(queue->cq);
+	ib_cq_pool_put(queue->cq, nr_cqe + 1);
 	goto out;
 }
 
@@ -1066,7 +1065,8 @@ static void nvmet_rdma_destroy_queue_ib(struct nvmet_rdma_queue *queue)
 	if (queue->cm_id)
 		rdma_destroy_id(queue->cm_id);
 	ib_destroy_qp(queue->qp);
-	ib_free_cq(queue->cq);
+	ib_cq_pool_put(queue->cq, queue->recv_queue_size + 2 *
+		       queue->send_queue_size + 1);
 }
 
 static void nvmet_rdma_free_queue(struct nvmet_rdma_queue *queue)
-- 
1.8.3.1

