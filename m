Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1519245EDFE
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Nov 2021 13:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377492AbhKZMi3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 26 Nov 2021 07:38:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234633AbhKZMg3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 26 Nov 2021 07:36:29 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B82C08EA70;
        Fri, 26 Nov 2021 03:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=uFkJ4coOuJs8MZM0mjjmaO2O9RaMqiZrB6AeS46Mv/0=; b=g2kQe3ju5FIntq5kwlYSknO9C6
        W89rqIuqF5WCJF83hXAPqNR1XmqQaEcN4I7vpO01jjamJ3/3POesnhqpM5AxBcnQ7AE+pSwkpUTtN
        63kNJc+ubeR5HxUnpzflT9m50e3/5iA3JcCOWIrtFlj0jcT28T0zHEYzgdRdq4pwnT3MLotPwS2To
        kjmMUD2qSLRM70IiZQO5HqzNgpNP1WBIaq8QALivtrOc0U8nznvF92gx7ZSchHCfBBZfDLdRBrMXq
        dSFalbuVgZDpAcMgRtwfNRsOGgSBQmPiTiup4p5hJ5e3yVWsSm51on4eVvEoNwR4y9nNNiI9U6pA/
        GsY3UIoQ==;
Received: from [2001:4bb8:191:f9ce:bae8:5658:102a:5491] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mqZrz-00ASHx-7t; Fri, 26 Nov 2021 11:58:24 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Paolo Valente <paolo.valente@linaro.org>, Jan Kara <jack@suse.cz>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: [PATCH 03/14] bfq: simplify bfq_bic_lookup
Date:   Fri, 26 Nov 2021 12:58:06 +0100
Message-Id: <20211126115817.2087431-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211126115817.2087431-1-hch@lst.de>
References: <20211126115817.2087431-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Remove the unused bfqd argument, and hardcode ioc to current->io_context.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bfq-iosched.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 85554b8009703..c990c6409c119 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -433,26 +433,21 @@ static struct bfq_io_cq *icq_to_bic(struct io_cq *icq)
 
 /**
  * bfq_bic_lookup - search into @ioc a bic associated to @bfqd.
- * @bfqd: the lookup key.
- * @ioc: the io_context of the process doing I/O.
  * @q: the request queue.
  */
-static struct bfq_io_cq *bfq_bic_lookup(struct bfq_data *bfqd,
-					struct io_context *ioc,
-					struct request_queue *q)
+static struct bfq_io_cq *bfq_bic_lookup(struct request_queue *q)
 {
-	if (ioc) {
-		unsigned long flags;
-		struct bfq_io_cq *icq;
+	struct bfq_io_cq *icq;
+	unsigned long flags;
 
-		spin_lock_irqsave(&q->queue_lock, flags);
-		icq = icq_to_bic(ioc_lookup_icq(ioc, q));
-		spin_unlock_irqrestore(&q->queue_lock, flags);
+	if (!current->io_context)
+		return NULL;
 
-		return icq;
-	}
+	spin_lock_irqsave(&q->queue_lock, flags);
+	icq = icq_to_bic(ioc_lookup_icq(current->io_context, q));
+	spin_unlock_irqrestore(&q->queue_lock, flags);
 
-	return NULL;
+	return icq;
 }
 
 /*
@@ -2457,7 +2452,7 @@ static bool bfq_bio_merge(struct request_queue *q, struct bio *bio,
 	 * returned by bfq_bic_lookup does not go away before
 	 * bfqd->lock is taken.
 	 */
-	struct bfq_io_cq *bic = bfq_bic_lookup(bfqd, current->io_context, q);
+	struct bfq_io_cq *bic = bfq_bic_lookup(q);
 	bool ret;
 
 	spin_lock_irq(&bfqd->lock);
-- 
2.30.2

