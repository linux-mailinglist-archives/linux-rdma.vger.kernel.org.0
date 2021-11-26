Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0D6445EE0D
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Nov 2021 13:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377537AbhKZMi4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 26 Nov 2021 07:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbhKZMg4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 26 Nov 2021 07:36:56 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9530FC08EA72;
        Fri, 26 Nov 2021 03:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=u0+ePx08fdN0TLP47LRnrql+1HJ4ogpHxxrOWZhKaak=; b=kEh2Xran84vn+1SYDvp7aE9Kli
        X/fY/S8hIaYl0mM9zwrd4oSE8Bi0YF0c2IKpB142P2a6M+j4PSeznmi5T0FnS4tBtz7ZOIL675pLj
        BuXBD26B48IRaFT1gRKGyFxMtHOVfJ5nBWQ6ygJxBAVzFcBGu27Ks6jAEhQhEqOyPfHdYSRrCuaO0
        wOJXB1YFKbqB9pijbdqhoRXu3yx6q2P1FqRa1SbUj1WML+UNN73WkVa1gtyCZD1i5bjNQRCsMXSbm
        OWufKqCjiwvY1eVdsuZTPCdOaZFtsumqSlA27S7hlzn3ePyTSRIlamXKcF807oiFBf1NpZMYc6nKu
        u1v1fuVA==;
Received: from [2001:4bb8:191:f9ce:bae8:5658:102a:5491] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mqZs1-00ASIq-RZ; Fri, 26 Nov 2021 11:58:26 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Paolo Valente <paolo.valente@linaro.org>, Jan Kara <jack@suse.cz>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: [PATCH 05/14] Revert "block: Provide blk_mq_sched_get_icq()"
Date:   Fri, 26 Nov 2021 12:58:08 +0100
Message-Id: <20211126115817.2087431-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211126115817.2087431-1-hch@lst.de>
References: <20211126115817.2087431-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This reverts commit 4896c4e64ba5d5d5acdbcf68c5910dd4f6d8fa62.

The helper is not needed any more.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq-sched.c | 26 +++++++++++---------------
 block/blk-mq-sched.h |  1 -
 2 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 98c6a97729f24..b942b38000e53 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -18,8 +18,9 @@
 #include "blk-mq-tag.h"
 #include "blk-wbt.h"
 
-struct io_cq *blk_mq_sched_get_icq(struct request_queue *q)
+void blk_mq_sched_assign_ioc(struct request *rq)
 {
+	struct request_queue *q = rq->q;
 	struct io_context *ioc;
 	struct io_cq *icq;
 
@@ -27,27 +28,22 @@ struct io_cq *blk_mq_sched_get_icq(struct request_queue *q)
 	if (unlikely(!current->io_context))
 		create_task_io_context(current, GFP_ATOMIC, q->node);
 
-	/* May not have an IO context if context creation failed */
+	/*
+	 * May not have an IO context if it's a passthrough request
+	 */
 	ioc = current->io_context;
 	if (!ioc)
-		return NULL;
+		return;
 
 	spin_lock_irq(&q->queue_lock);
 	icq = ioc_lookup_icq(ioc, q);
 	spin_unlock_irq(&q->queue_lock);
-	if (icq)
-		return icq;
-	return ioc_create_icq(ioc, q, GFP_ATOMIC);
-}
-EXPORT_SYMBOL(blk_mq_sched_get_icq);
 
-void blk_mq_sched_assign_ioc(struct request *rq)
-{
-	struct io_cq *icq;
-
-	icq = blk_mq_sched_get_icq(rq->q);
-	if (!icq)
-		return;
+	if (!icq) {
+		icq = ioc_create_icq(ioc, q, GFP_ATOMIC);
+		if (!icq)
+			return;
+	}
 	get_io_context(icq->ioc);
 	rq->elv.icq = icq;
 }
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index add651ec06da7..25d1034952b65 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -8,7 +8,6 @@
 
 #define MAX_SCHED_RQ (16 * BLKDEV_DEFAULT_RQ)
 
-struct io_cq *blk_mq_sched_get_icq(struct request_queue *q);
 void blk_mq_sched_assign_ioc(struct request *rq);
 
 bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio,
-- 
2.30.2

