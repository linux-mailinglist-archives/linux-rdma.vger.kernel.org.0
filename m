Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00C713F46E3
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Aug 2021 10:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhHWIvq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Aug 2021 04:51:46 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:49797 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235577AbhHWIvp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Aug 2021 04:51:45 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Al/uFQa0ugtpsg04V1lA6sAqjBFokLtp133Aq?=
 =?us-ascii?q?2lEZdPRUGvb3qynIpoV+6faUskd3ZJhOo7C90cW7LU80lqQFhLX5X43SPzUO0V?=
 =?us-ascii?q?HAROoJgLcKqAeAJ8SRzIFgPN9bAspD4cPLfCNHpPe/8A+lCMwh3dXC1KipgN3V?=
 =?us-ascii?q?x3BrQRoCUdAY0y5JThacDlZtRBRLQb4wFJ+n7MJBoDa6PVsNaMDTPAh8Y8Hz48?=
 =?us-ascii?q?3MiIn9YQMLQzou6Ay1hzuu77LgVzi0ty1uNQ9y/Q=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.84,344,1620662400"; 
   d="scan'208";a="113319348"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 23 Aug 2021 16:51:02 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 8B2D44D0D9DC;
        Mon, 23 Aug 2021 16:50:56 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Mon, 23 Aug 2021 16:50:58 +0800
Received: from Fedora-31.g08.fujitsu.local (10.167.220.99) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Mon, 23 Aug 2021 16:50:55 +0800
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <rpearsonhpe@gmail.com>, <zyjzyj2000@gmail.com>, <jgg@nvidia.com>,
        <leon@kernel.org>, Xiao Yang <yangx.jy@fujitsu.com>
Subject: [PATCH 1/3] RDMA/rxe: Remove unnecessary check for qp->is_user/cq->is_user
Date:   Mon, 23 Aug 2021 17:22:54 +0800
Message-ID: <20210823092256.287154-2-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210823092256.287154-1-yangx.jy@fujitsu.com>
References: <20210823092256.287154-1-yangx.jy@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 8B2D44D0D9DC.AB32C
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

1) post_one_send() always processes kernel's send queue.
2) rxe_poll_cq() always processes kernel's completion queue.

Fixes: 5bcf5a59c41e ("RDMA/rxe: Protext kernel index from user space")
Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_verbs.c | 29 ++++++---------------------
 1 file changed, 6 insertions(+), 23 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index c223959ac174..cdded9f64910 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -632,7 +632,6 @@ static int post_one_send(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
 	struct rxe_sq *sq = &qp->sq;
 	struct rxe_send_wqe *send_wqe;
 	unsigned long flags;
-	int full;
 
 	err = validate_send_wr(qp, ibwr, mask, length);
 	if (err)
@@ -640,27 +639,16 @@ static int post_one_send(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
 
 	spin_lock_irqsave(&qp->sq.sq_lock, flags);
 
-	if (qp->is_user)
-		full = queue_full(sq->queue, QUEUE_TYPE_FROM_USER);
-	else
-		full = queue_full(sq->queue, QUEUE_TYPE_KERNEL);
-
-	if (unlikely(full)) {
+	if (unlikely(queue_full(sq->queue, QUEUE_TYPE_KERNEL))) {
 		spin_unlock_irqrestore(&qp->sq.sq_lock, flags);
 		return -ENOMEM;
 	}
 
-	if (qp->is_user)
-		send_wqe = producer_addr(sq->queue, QUEUE_TYPE_FROM_USER);
-	else
-		send_wqe = producer_addr(sq->queue, QUEUE_TYPE_KERNEL);
+	send_wqe = producer_addr(sq->queue, QUEUE_TYPE_KERNEL);
 
 	init_send_wqe(qp, ibwr, mask, length, send_wqe);
 
-	if (qp->is_user)
-		advance_producer(sq->queue, QUEUE_TYPE_FROM_USER);
-	else
-		advance_producer(sq->queue, QUEUE_TYPE_KERNEL);
+	advance_producer(sq->queue, QUEUE_TYPE_KERNEL);
 
 	spin_unlock_irqrestore(&qp->sq.sq_lock, flags);
 
@@ -852,18 +840,13 @@ static int rxe_poll_cq(struct ib_cq *ibcq, int num_entries, struct ib_wc *wc)
 
 	spin_lock_irqsave(&cq->cq_lock, flags);
 	for (i = 0; i < num_entries; i++) {
-		if (cq->is_user)
-			cqe = queue_head(cq->queue, QUEUE_TYPE_TO_USER);
-		else
-			cqe = queue_head(cq->queue, QUEUE_TYPE_KERNEL);
+		cqe = queue_head(cq->queue, QUEUE_TYPE_KERNEL);
 		if (!cqe)
 			break;
 
 		memcpy(wc++, &cqe->ibwc, sizeof(*wc));
-		if (cq->is_user)
-			advance_consumer(cq->queue, QUEUE_TYPE_TO_USER);
-		else
-			advance_consumer(cq->queue, QUEUE_TYPE_KERNEL);
+
+		advance_consumer(cq->queue, QUEUE_TYPE_KERNEL);
 	}
 	spin_unlock_irqrestore(&cq->cq_lock, flags);
 
-- 
2.25.1



