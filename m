Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B72A1700E0
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2020 15:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgBZOOX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Feb 2020 09:14:23 -0500
Received: from stargate.chelsio.com ([12.32.117.8]:62697 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbgBZOOX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 Feb 2020 09:14:23 -0500
Received: from localhost (pvp1.blr.asicdesigners.com [10.193.80.26])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id 01QEDYOm024545;
        Wed, 26 Feb 2020 06:13:35 -0800
From:   Krishnamraju Eraparaju <krishna2@chelsio.com>
To:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de
Cc:     linux-rdma@vger.kernel.org, nirranjan@chelsio.com,
        bharat@chelsio.com, krishna2@chelsio.com
Subject: [PATCH for-rc] nvme-rdma/nvmet-rdma: Allocate sufficient RW ctxs to match hosts pgs len
Date:   Wed, 26 Feb 2020 19:43:18 +0530
Message-Id: <20200226141318.28519-1-krishna2@chelsio.com>
X-Mailer: git-send-email 2.23.0.rc0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Current nvmet-rdma code allocates MR pool budget based on host's SQ
size, assuming both host and target use the same "max_pages_per_mr"
count. But if host's max_pages_per_mr is greater than target's, then
target can run out of MRs while processing larger IO WRITEs.

That is, say host's SQ size is 100, then the MR pool budget allocated
currently at target will also be 100 MRs. But 100 IO WRITE Requests
with 256 sg_count(IO size above 1MB) require 200 MRs when target's
"max_pages_per_mr" is 128.

The proposed patch enables host to advertise the max_fr_pages(via
nvme_rdma_cm_req) such that target can allocate that many number of
RW ctxs(if host's max_fr_pages is higher than target's).

Signed-off-by: Krishnamraju Eraparaju <krishna2@chelsio.com>
---
 drivers/nvme/host/rdma.c   |  2 ++
 drivers/nvme/target/rdma.c | 23 ++++++++++++++++++++---
 include/linux/nvme-rdma.h  |  4 +++-
 3 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 2a47c6c5007e..5970f0eedbd6 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1614,6 +1614,8 @@ static int nvme_rdma_route_resolved(struct nvme_rdma_queue *queue)
 		priv.hsqsize = cpu_to_le16(queue->ctrl->ctrl.sqsize);
 	}
 
+	priv.hmax_fr_pages = cpu_to_le32(ctrl->max_fr_pages);
+
 	ret = rdma_connect(queue->cm_id, &param);
 	if (ret) {
 		dev_err(ctrl->ctrl.device,
diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 37d262a65877..2a3893e3c4e7 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -98,6 +98,7 @@ struct nvmet_rdma_queue {
 	int			host_qid;
 	int			recv_queue_size;
 	int			send_queue_size;
+	int			rdma_rw_ctxs_factor;
 
 	struct list_head	queue_list;
 };
@@ -1008,7 +1009,8 @@ static int nvmet_rdma_create_queue_ib(struct nvmet_rdma_queue *queue)
 	qp_attr.qp_type = IB_QPT_RC;
 	/* +1 for drain */
 	qp_attr.cap.max_send_wr = queue->send_queue_size + 1;
-	qp_attr.cap.max_rdma_ctxs = queue->send_queue_size;
+	qp_attr.cap.max_rdma_ctxs = queue->send_queue_size *
+					queue->rdma_rw_ctxs_factor;
 	qp_attr.cap.max_send_sge = max(ndev->device->attrs.max_sge_rd,
 					ndev->device->attrs.max_send_sge);
 
@@ -1094,6 +1096,7 @@ nvmet_rdma_parse_cm_connect_req(struct rdma_conn_param *conn,
 				struct nvmet_rdma_queue *queue)
 {
 	struct nvme_rdma_cm_req *req;
+	u32 host_fr_pages_len, tgt_fr_pages_len;
 
 	req = (struct nvme_rdma_cm_req *)conn->private_data;
 	if (!req || conn->private_data_len == 0)
@@ -1111,6 +1114,19 @@ nvmet_rdma_parse_cm_connect_req(struct rdma_conn_param *conn,
 	queue->recv_queue_size = le16_to_cpu(req->hsqsize) + 1;
 	queue->send_queue_size = le16_to_cpu(req->hrqsize);
 
+	host_fr_pages_len = le32_to_cpu(req->hmax_fr_pages),
+	tgt_fr_pages_len = queue->dev->device->attrs.max_fast_reg_page_list_len;
+
+	if (host_fr_pages_len > tgt_fr_pages_len)
+		/*
+		 * Allocate more RW contexts as more MRs are required when
+		 * host_fr_pages_len is higher than target's.
+		 */
+		queue->rdma_rw_ctxs_factor =
+			DIV_ROUND_UP(host_fr_pages_len, tgt_fr_pages_len);
+	else
+		queue->rdma_rw_ctxs_factor = 1;
+
 	if (!queue->host_qid && queue->recv_queue_size > NVME_AQ_DEPTH)
 		return NVME_RDMA_CM_INVALID_HSQSIZE;
 
@@ -1147,6 +1163,9 @@ nvmet_rdma_alloc_queue(struct nvmet_rdma_device *ndev,
 		goto out_reject;
 	}
 
+	queue->dev = ndev;
+	queue->cm_id = cm_id;
+
 	ret = nvmet_sq_init(&queue->nvme_sq);
 	if (ret) {
 		ret = NVME_RDMA_CM_NO_RSC;
@@ -1162,8 +1181,6 @@ nvmet_rdma_alloc_queue(struct nvmet_rdma_device *ndev,
 	 * inside a CM callback would trigger a deadlock. (great API design..)
 	 */
 	INIT_WORK(&queue->release_work, nvmet_rdma_release_queue_work);
-	queue->dev = ndev;
-	queue->cm_id = cm_id;
 
 	spin_lock_init(&queue->state_lock);
 	queue->state = NVMET_RDMA_Q_CONNECTING;
diff --git a/include/linux/nvme-rdma.h b/include/linux/nvme-rdma.h
index 3ec8e50efa16..2d6f2cf1e319 100644
--- a/include/linux/nvme-rdma.h
+++ b/include/linux/nvme-rdma.h
@@ -52,13 +52,15 @@ static inline const char *nvme_rdma_cm_msg(enum nvme_rdma_cm_status status)
  * @qid:           queue Identifier for the Admin or I/O Queue
  * @hrqsize:       host receive queue size to be created
  * @hsqsize:       host send queue size to be created
+ * @hmax_fr_pages: host maximum pages per fast reg
  */
 struct nvme_rdma_cm_req {
 	__le16		recfmt;
 	__le16		qid;
 	__le16		hrqsize;
 	__le16		hsqsize;
-	u8		rsvd[24];
+	__le32		hmax_fr_pages;
+	u8		rsvd[20];
 };
 
 /**
-- 
2.23.0.rc0

