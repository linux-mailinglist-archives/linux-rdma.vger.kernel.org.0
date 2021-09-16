Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A773440D999
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Sep 2021 14:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239161AbhIPMQk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Sep 2021 08:16:40 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:30260 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S239398AbhIPMQj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Sep 2021 08:16:39 -0400
IronPort-Data: =?us-ascii?q?A9a23=3ADQrOpqvs1v5I4pq1rwTsZmEIc+fnVLRcMUV32f8?=
 =?us-ascii?q?akzHdYEJGY0x3mDMZC2qAP/2ONzP1c990Pdzj/B5T7Z7TyIQwHlE5qy1gHilAw?=
 =?us-ascii?q?SbnLY7Hdx+vZUt+DSFioHpPtpxYMp+ZRCwNZie0SiyFb/6x8BGQ6YnSHuClUL+?=
 =?us-ascii?q?dZHgrLeNZYHxJZSxLyrdRbrFA0YDR7zOl4bsekuWHULOX82cc3lE8t8pvnChSU?=
 =?us-ascii?q?MHa41v0iLCRicdj5zcyn1FNZH4WyDrYw3HQGuG4FcbiLwrPIS3Qw4/Xw/stIov?=
 =?us-ascii?q?NfrfTeUtMTKPQPBSVlzxdXK3Kbhpq/3R0i/hkcqFHLxo/ZzahxridzP1cvJq/W?=
 =?us-ascii?q?UErL4XCheYcTwJFVSp5OMWq/ZeeeCTi7pbLkhKun3zEhq8G4FsNFZcA9+9tGmZ?=
 =?us-ascii?q?I9eQVAD8IZxGHwemxxdqTWPhulNUhdpGzZKsQv3hhyXfSCvNOaZTORKPi5tJC2?=
 =?us-ascii?q?jo0wMdUEp72ZcUWQTxxbRjBaltEPVJ/IJY/mvq4w2PzdjRwtl2Yv+w07nLVwQg?=
 =?us-ascii?q?316LiWOc50PTiqd59xx7e/zyZuT+iRExyCTBW8hLdmlrEuwMFtXqTtFouKYCF?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Aj0f4063eLaacXcJbcmV4AwqjBNckLtp133Aq?=
 =?us-ascii?q?2lEZdPU1SKylfq+V8cjzuSWftN9zYhAdcLK7V5VoKEm0nfVICOEqTNSftWLd1F?=
 =?us-ascii?q?dAQrsN0bff?=
X-IronPort-AV: E=Sophos;i="5.85,298,1624291200"; 
   d="scan'208";a="114572057"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 16 Sep 2021 20:15:18 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 997624D0DC79;
        Thu, 16 Sep 2021 20:15:17 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 16 Sep 2021 20:15:12 +0800
Received: from Fedora-31.g08.fujitsu.local (10.167.220.99) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Thu, 16 Sep 2021 20:15:11 +0800
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <linux-rdma@vger.kernel.org>, <jgg@nvidia.com>
CC:     <rpearsonhpe@gmail.com>, <zyjzyj2000@gmail.com>, <leon@kernel.org>,
        "Xiao Yang" <yangx.jy@fujitsu.com>
Subject: [PATCH v3 1/5] RDMA/rxe: Remove unnecessary check for qp->is_user/cq->is_user
Date:   Thu, 16 Sep 2021 20:46:48 +0800
Message-ID: <20210916124652.1304649-2-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210916124652.1304649-1-yangx.jy@fujitsu.com>
References: <20210916124652.1304649-1-yangx.jy@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 997624D0DC79.A8E2B
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
index 267b5a9c345d..548771ecbaf8 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -625,7 +625,6 @@ static int post_one_send(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
 	struct rxe_sq *sq = &qp->sq;
 	struct rxe_send_wqe *send_wqe;
 	unsigned long flags;
-	int full;
 
 	err = validate_send_wr(qp, ibwr, mask, length);
 	if (err)
@@ -633,27 +632,16 @@ static int post_one_send(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
 
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
 
@@ -845,18 +833,13 @@ static int rxe_poll_cq(struct ib_cq *ibcq, int num_entries, struct ib_wc *wc)
 
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



