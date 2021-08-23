Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A22F23F46E5
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Aug 2021 10:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235529AbhHWIvw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Aug 2021 04:51:52 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:49797 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235573AbhHWIvv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Aug 2021 04:51:51 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ATh3MPa7/S7YxQro8pAPXwCDXdLJyesId70hD?=
 =?us-ascii?q?6qhwISY6TiX+rbHLoB17726StN9/YhEdcLy7VJVoIkmskKKdg7NhXotKNTOO0A?=
 =?us-ascii?q?DDQb2KhrGC/9SPIULDH5ZmpMVdmrZFeabNJGk/ncDn+xO5Dtpl5NGG9ZqjjeDY?=
 =?us-ascii?q?w2wFd3ASV4hQqxd+Fh2AElB7AC1PBZ8CHpKa4cZd4xW6f3B/VLXCOlA1G/jEu8?=
 =?us-ascii?q?bQlI/rJToPBxsc4gGIij+yrJ7WeiLouCsjbw=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.84,344,1620662400"; 
   d="scan'208";a="113319359"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 23 Aug 2021 16:51:08 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 5C17E4D0D9DF;
        Mon, 23 Aug 2021 16:51:06 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Mon, 23 Aug 2021 16:50:57 +0800
Received: from Fedora-31.g08.fujitsu.local (10.167.220.99) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Mon, 23 Aug 2021 16:50:56 +0800
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <rpearsonhpe@gmail.com>, <zyjzyj2000@gmail.com>, <jgg@nvidia.com>,
        <leon@kernel.org>, Xiao Yang <yangx.jy@fujitsu.com>
Subject: [PATCH 2/3] RDMA/rxe: Remove the common is_user member of struct rxe_qp
Date:   Mon, 23 Aug 2021 17:22:55 +0800
Message-ID: <20210823092256.287154-3-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210823092256.287154-1-yangx.jy@fujitsu.com>
References: <20210823092256.287154-1-yangx.jy@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 5C17E4D0D9DF.AC7FA
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The following commit introduced separate is_user members for struct
rxe_sq/rxe_rq/rxe_srq but no code uses the separate is_user member
of struct rxe_sq and lots of code still use the common is_user member
of struct rxe_qp.  So it is clear to make all code use separate is_user
members uniformly and remove the common is_user member.

Fixes: 5bcf5a59c41e ("RDMA/rxe: Protext kernel index from user space")
Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_comp.c  |  6 +++---
 drivers/infiniband/sw/rxe/rxe_qp.c    |  5 +++--
 drivers/infiniband/sw/rxe/rxe_req.c   |  4 ++--
 drivers/infiniband/sw/rxe/rxe_resp.c  | 10 +++++-----
 drivers/infiniband/sw/rxe/rxe_verbs.c | 13 ++++---------
 drivers/infiniband/sw/rxe/rxe_verbs.h |  1 -
 6 files changed, 17 insertions(+), 22 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index 58ad9c2644f3..fb7741ec5cd3 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -142,7 +142,7 @@ static inline enum comp_state get_wqe(struct rxe_qp *qp,
 	/* we come here whether or not we found a response packet to see if
 	 * there are any posted WQEs
 	 */
-	if (qp->is_user)
+	if (qp->sq.is_user)
 		wqe = queue_head(qp->sq.queue, QUEUE_TYPE_FROM_USER);
 	else
 		wqe = queue_head(qp->sq.queue, QUEUE_TYPE_KERNEL);
@@ -385,7 +385,7 @@ static void make_send_cqe(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 {
 	memset(cqe, 0, sizeof(*cqe));
 
-	if (!qp->is_user) {
+	if (!qp->sq.is_user) {
 		struct ib_wc		*wc	= &cqe->ibwc;
 
 		wc->wr_id		= wqe->wr.wr_id;
@@ -432,7 +432,7 @@ static void do_complete(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 	if (post)
 		make_send_cqe(qp, wqe, &cqe);
 
-	if (qp->is_user)
+	if (qp->sq.is_user)
 		advance_consumer(qp->sq.queue, QUEUE_TYPE_FROM_USER);
 	else
 		advance_consumer(qp->sq.queue, QUEUE_TYPE_KERNEL);
diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index 1ab6af7ddb25..cfa04e92286a 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -248,7 +248,8 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
 		return err;
 	}
 
-	if (qp->is_user)
+	qp->sq.is_user = uresp ? true : false;
+	if (qp->sq.is_user)
 		qp->req.wqe_index = producer_index(qp->sq.queue,
 						QUEUE_TYPE_FROM_USER);
 	else
@@ -313,7 +314,7 @@ static int rxe_qp_init_resp(struct rxe_dev *rxe, struct rxe_qp *qp,
 	spin_lock_init(&qp->rq.producer_lock);
 	spin_lock_init(&qp->rq.consumer_lock);
 
-	qp->rq.is_user = qp->is_user;
+	qp->rq.is_user = uresp ? true : false;
 
 	skb_queue_head_init(&qp->resp_pkts);
 
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index c57699cc6578..2886709e1823 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -49,7 +49,7 @@ static void req_retry(struct rxe_qp *qp)
 	unsigned int cons;
 	unsigned int prod;
 
-	if (qp->is_user) {
+	if (qp->sq.is_user) {
 		cons = consumer_index(q, QUEUE_TYPE_FROM_USER);
 		prod = producer_index(q, QUEUE_TYPE_FROM_USER);
 	} else {
@@ -121,7 +121,7 @@ static struct rxe_send_wqe *req_next_wqe(struct rxe_qp *qp)
 	unsigned int cons;
 	unsigned int prod;
 
-	if (qp->is_user) {
+	if (qp->sq.is_user) {
 		wqe = queue_head(q, QUEUE_TYPE_FROM_USER);
 		cons = consumer_index(q, QUEUE_TYPE_FROM_USER);
 		prod = producer_index(q, QUEUE_TYPE_FROM_USER);
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 360ec67cb9e1..71406a49fca3 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -303,7 +303,7 @@ static enum resp_states get_srq_wqe(struct rxe_qp *qp)
 
 	spin_lock_bh(&srq->rq.consumer_lock);
 
-	if (qp->is_user)
+	if (srq->is_user)
 		wqe = queue_head(q, QUEUE_TYPE_FROM_USER);
 	else
 		wqe = queue_head(q, QUEUE_TYPE_KERNEL);
@@ -322,7 +322,7 @@ static enum resp_states get_srq_wqe(struct rxe_qp *qp)
 	memcpy(&qp->resp.srq_wqe, wqe, size);
 
 	qp->resp.wqe = &qp->resp.srq_wqe.wqe;
-	if (qp->is_user) {
+	if (srq->is_user) {
 		advance_consumer(q, QUEUE_TYPE_FROM_USER);
 		count = queue_count(q, QUEUE_TYPE_FROM_USER);
 	} else {
@@ -357,7 +357,7 @@ static enum resp_states check_resource(struct rxe_qp *qp,
 			qp->resp.status = IB_WC_WR_FLUSH_ERR;
 			return RESPST_COMPLETE;
 		} else if (!srq) {
-			if (qp->is_user)
+			if (qp->rq.is_user)
 				qp->resp.wqe = queue_head(qp->rq.queue,
 						QUEUE_TYPE_FROM_USER);
 			else
@@ -389,7 +389,7 @@ static enum resp_states check_resource(struct rxe_qp *qp,
 		if (srq)
 			return get_srq_wqe(qp);
 
-		if (qp->is_user)
+		if (qp->rq.is_user)
 			qp->resp.wqe = queue_head(qp->rq.queue,
 					QUEUE_TYPE_FROM_USER);
 		else
@@ -954,7 +954,7 @@ static enum resp_states do_complete(struct rxe_qp *qp,
 
 	/* have copy for srq and reference for !srq */
 	if (!qp->srq) {
-		if (qp->is_user)
+		if (qp->rq.is_user)
 			advance_consumer(qp->rq.queue, QUEUE_TYPE_FROM_USER);
 		else
 			advance_consumer(qp->rq.queue, QUEUE_TYPE_KERNEL);
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index cdded9f64910..4ce4ff6ad80e 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -420,14 +420,9 @@ static struct ib_qp *rxe_create_qp(struct ib_pd *ibpd,
 		goto err1;
 	}
 
-	if (udata) {
-		if (udata->inlen) {
-			err = -EINVAL;
-			goto err2;
-		}
-		qp->is_user = true;
-	} else {
-		qp->is_user = false;
+	if (udata && udata->inlen) {
+		err = -EINVAL;
+		goto err2;
 	}
 
 	rxe_add_index(qp);
@@ -716,7 +711,7 @@ static int rxe_post_send(struct ib_qp *ibqp, const struct ib_send_wr *wr,
 		return -EINVAL;
 	}
 
-	if (qp->is_user) {
+	if (qp->sq.is_user) {
 		/* Utilize process context to do protocol processing */
 		rxe_run_task(&qp->req.task, 0);
 		return 0;
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 959a3260fcab..bb5fb157d073 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -215,7 +215,6 @@ struct rxe_qp {
 	struct ib_qp_attr	attr;
 	unsigned int		valid;
 	unsigned int		mtu;
-	bool			is_user;
 
 	struct rxe_pd		*pd;
 	struct rxe_srq		*srq;
-- 
2.25.1



