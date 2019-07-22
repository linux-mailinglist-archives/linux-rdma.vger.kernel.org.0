Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BADEB70362
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jul 2019 17:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbfGVPOt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Jul 2019 11:14:49 -0400
Received: from os.inf.tu-dresden.de ([141.76.48.99]:58324 "EHLO
        os.inf.tu-dresden.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728128AbfGVPOs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Jul 2019 11:14:48 -0400
Received: from [195.176.96.199] (helo=jupiter)
        by os.inf.tu-dresden.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92)
        id 1hpa1O-0008AN-OI; Mon, 22 Jul 2019 17:14:38 +0200
From:   Maksym Planeta <mplaneta@os.inf.tu-dresden.de>
To:     Moni Shoua <monis@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Maksym Planeta <mplaneta@os.inf.tu-dresden.de>
Subject: [PATCH 09/10] Consolidate resetting of QP's tasks into one place
Date:   Mon, 22 Jul 2019 17:14:25 +0200
Message-Id: <20190722151426.5266-10-mplaneta@os.inf.tu-dresden.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190722151426.5266-1-mplaneta@os.inf.tu-dresden.de>
References: <20190722151426.5266-1-mplaneta@os.inf.tu-dresden.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Used in a later patch.

Signed-off-by: Maksym Planeta <mplaneta@os.inf.tu-dresden.de>
---
 drivers/infiniband/sw/rxe/rxe_loc.h  |  1 +
 drivers/infiniband/sw/rxe/rxe_qp.c   | 17 +----------------
 drivers/infiniband/sw/rxe/rxe_req.c  |  1 +
 drivers/infiniband/sw/rxe/rxe_resp.c | 25 ++++++++++++++-----------
 4 files changed, 17 insertions(+), 27 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index b7159d9d5107..e37adde2bced 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -205,6 +205,7 @@ static inline int rcv_wqe_size(int max_sge)
 }
 
 void free_rd_atomic_resource(struct rxe_qp *qp, struct resp_res *res);
+void cleanup_rd_atomic_resources(struct rxe_qp *qp);
 
 static inline void rxe_advance_resp_resource(struct rxe_qp *qp)
 {
diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index 7cd929185581..2fccdede8869 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -161,7 +161,7 @@ void free_rd_atomic_resource(struct rxe_qp *qp, struct resp_res *res)
 	res->type = 0;
 }
 
-static void cleanup_rd_atomic_resources(struct rxe_qp *qp)
+void cleanup_rd_atomic_resources(struct rxe_qp *qp)
 {
 	int i;
 	struct resp_res *res;
@@ -526,21 +526,6 @@ static void rxe_qp_reset(struct rxe_qp *qp)
 
 	/* cleanup attributes */
 	atomic_set(&qp->ssn, 0);
-	qp->req.opcode = -1;
-	qp->req.need_retry = 0;
-	qp->req.noack_pkts = 0;
-	qp->resp.msn = 0;
-	qp->resp.opcode = -1;
-	qp->resp.drop_msg = 0;
-	qp->resp.goto_error = 0;
-	qp->resp.sent_psn_nak = 0;
-
-	if (qp->resp.mr) {
-		rxe_drop_ref(&qp->resp.mr->pelem);
-		qp->resp.mr = NULL;
-	}
-
-	cleanup_rd_atomic_resources(qp);
 
 	/* reenable tasks */
 	rxe_enable_task(&qp->resp.task);
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index c63e66873757..3bb9afdeaee1 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -599,6 +599,7 @@ int rxe_requester(void *arg)
 		goto exit;
 
 	if (unlikely(qp->req.state == QP_STATE_RESET)) {
+		qp->req.noack_pkts = 0;
 		qp->req.wqe_index = consumer_index(qp->sq.queue);
 		qp->req.opcode = -1;
 		qp->req.need_rd_atomic = 0;
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 7be8a362d2ef..eaee68d718ce 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -1214,19 +1214,10 @@ int rxe_responder(void *arg)
 
 	qp->resp.aeth_syndrome = AETH_ACK_UNLIMITED;
 
-	if (!qp->valid) {
-		ret = -EINVAL;
-		goto done;
-	}
-
-	switch (qp->resp.state) {
-	case QP_STATE_RESET:
+	if (!qp->valid || qp->resp.state == QP_STATE_RESET) {
 		state = RESPST_RESET;
-		break;
-
-	default:
+	} else {
 		state = RESPST_GET_REQ;
-		break;
 	}
 
 	while (1) {
@@ -1374,6 +1365,18 @@ int rxe_responder(void *arg)
 		case RESPST_RESET:
 			rxe_drain_req_pkts(qp, false);
 			qp->resp.wqe = NULL;
+			qp->resp.msn = 0;
+			qp->resp.opcode = -1;
+			qp->resp.drop_msg = 0;
+			qp->resp.goto_error = 0;
+			qp->resp.sent_psn_nak = 0;
+
+			if (qp->resp.mr) {
+				rxe_drop_ref(&qp->resp.mr->pelem);
+				qp->resp.mr = NULL;
+			}
+
+			cleanup_rd_atomic_resources(qp);
 			goto exit;
 
 		case RESPST_ERROR:
-- 
2.20.1

