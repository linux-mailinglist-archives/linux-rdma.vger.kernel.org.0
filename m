Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB9AE3F46B6
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Aug 2021 10:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235462AbhHWIg6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Aug 2021 04:36:58 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:46916 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235609AbhHWIgz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Aug 2021 04:36:55 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AESU7P68tQIWZEeEcp0huk+C9I+orL9Y04lQ7?=
 =?us-ascii?q?vn2ZKCY0TiX2ra2TdZggvyMc6wxxZJhDo7+90cC7KBu2yXcc2/hzAV7IZmXbUQ?=
 =?us-ascii?q?WTQr1f0Q=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.84,344,1620662400"; 
   d="scan'208";a="113318452"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 23 Aug 2021 16:36:10 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 525254D0D497;
        Mon, 23 Aug 2021 16:36:06 +0800 (CST)
Received: from G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Mon, 23 Aug 2021 16:35:55 +0800
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Mon, 23 Aug 2021 16:35:57 +0800
Received: from Fedora-31.g08.fujitsu.local (10.167.220.99) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Mon, 23 Aug 2021 16:35:54 +0800
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <rpearsonhpe@gmail.com>, <zyjzyj2000@gmail.com>, <jgg@nvidia.com>,
        <leon@kernel.org>, Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH 1/3] RDMA/rxe: Remove unnecessary check for qp->is_user/cq->is_user
Date:   Mon, 23 Aug 2021 17:08:03 +0800
Message-ID: <20210823090805.286497-2-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210823090805.286497-1-yangx.jy@fujitsu.com>
References: <20210823090805.286497-1-yangx.jy@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 525254D0D497.A6973
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xiao Yang <yangx.jy@cn.fujitsu.com>

1) post_one_send() always processes kernel's send queue.
2) rxe_poll_cq() always processes kernel's completion queue.

Fixes: 5bcf5a59c41e ("RDMA/rxe: Protext kernel index from user space")
Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
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



