Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53AF545EE23
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Nov 2021 13:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345276AbhKZMjf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 26 Nov 2021 07:39:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234489AbhKZMha (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 26 Nov 2021 07:37:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3264BC08EAE9;
        Fri, 26 Nov 2021 03:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=+tBLAaFkzip4baS+mnayza4tDle8mH9Q1mxOznfall8=; b=jofJ4mr/aWX50ISkivAC4mMZjg
        9yDX3lKG8CQDkQbkULZYzvH4ikPNadZxYaL56H+yRZdns+aCqgoMArWgA1ys8AvWo4QjnQSuw3Tg8
        lqWYo3X+n9CJRKjw+Sltyh9IC+roO6eTS6miYpqcjx4ySuMGwyPzle36FxImWmBmdATjwlM7xqTdk
        hVxr33F6AddUlij+gBOvE1hMx6oWLho9jvGqYS/iR5VxPc4JxPScPlQWMMF/frlbfkUkNJfiObEPl
        jd/L/s3tYsFEf108L8K03f5zYouCiviQwERYfnbDxV35A78GOrGplCkWxdQHUFJayR9yUWvVb9HmS
        lO24UhmQ==;
Received: from [2001:4bb8:191:f9ce:bae8:5658:102a:5491] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mqZsD-00ASMq-HZ; Fri, 26 Nov 2021 11:58:38 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Paolo Valente <paolo.valente@linaro.org>, Jan Kara <jack@suse.cz>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: [PATCH 14/14] block: simplify ioc_lookup_icq
Date:   Fri, 26 Nov 2021 12:58:17 +0100
Message-Id: <20211126115817.2087431-15-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211126115817.2087431-1-hch@lst.de>
References: <20211126115817.2087431-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Remove the ioc argument as it always points to current->io_context.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bfq-iosched.c | 2 +-
 block/blk-ioc.c     | 8 ++++----
 block/blk.h         | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 8295b0f96cbfe..0c612a9116967 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -444,7 +444,7 @@ static struct bfq_io_cq *bfq_bic_lookup(struct request_queue *q)
 		return NULL;
 
 	spin_lock_irqsave(&q->queue_lock, flags);
-	icq = icq_to_bic(ioc_lookup_icq(current->io_context, q));
+	icq = icq_to_bic(ioc_lookup_icq(q));
 	spin_unlock_irqrestore(&q->queue_lock, flags);
 
 	return icq;
diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index c56648f7cad47..536fb496ad763 100644
--- a/block/blk-ioc.c
+++ b/block/blk-ioc.c
@@ -353,14 +353,14 @@ int __copy_io(unsigned long clone_flags, struct task_struct *tsk)
 
 /**
  * ioc_lookup_icq - lookup io_cq from ioc
- * @ioc: the associated io_context
  * @q: the associated request_queue
  *
  * Look up io_cq associated with @ioc - @q pair from @ioc.  Must be called
  * with @q->queue_lock held.
  */
-struct io_cq *ioc_lookup_icq(struct io_context *ioc, struct request_queue *q)
+struct io_cq *ioc_lookup_icq(struct request_queue *q)
 {
+	struct io_context *ioc = current->io_context;
 	struct io_cq *icq;
 
 	lockdep_assert_held(&q->queue_lock);
@@ -430,7 +430,7 @@ static struct io_cq *ioc_create_icq(struct request_queue *q)
 			et->ops.init_icq(icq);
 	} else {
 		kmem_cache_free(et->icq_cache, icq);
-		icq = ioc_lookup_icq(ioc, q);
+		icq = ioc_lookup_icq(q);
 		if (!icq)
 			printk(KERN_ERR "cfq: icq link failed!\n");
 	}
@@ -454,7 +454,7 @@ struct io_cq *ioc_find_get_icq(struct request_queue *q)
 		get_io_context(ioc);
 
 		spin_lock_irq(&q->queue_lock);
-		icq = ioc_lookup_icq(ioc, q);
+		icq = ioc_lookup_icq(q);
 		spin_unlock_irq(&q->queue_lock);
 	}
 
diff --git a/block/blk.h b/block/blk.h
index 187cb2654ffde..3be0fdf76c9a5 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -364,7 +364,7 @@ static inline unsigned int bio_aligned_discard_max_sectors(
  * Internal io_context interface
  */
 struct io_cq *ioc_find_get_icq(struct request_queue *q);
-struct io_cq *ioc_lookup_icq(struct io_context *ioc, struct request_queue *q);
+struct io_cq *ioc_lookup_icq(struct request_queue *q);
 void ioc_clear_queue(struct request_queue *q);
 
 #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
-- 
2.30.2

