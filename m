Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0620245EE15
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Nov 2021 13:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377574AbhKZMj0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 26 Nov 2021 07:39:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236177AbhKZMhZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 26 Nov 2021 07:37:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036C5C08EA74;
        Fri, 26 Nov 2021 03:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=90gN+8A6JEywMJ3UpPZQ7B+PFcu57iDbBHkoNmyeA0w=; b=JxeJ+8tfnpMtAc9TsF9sB4h51l
        sOoK1GY3Ps30tXWbYE5KZSdLGsL1EEZDry+uFtR9T+saBxkHJPB/WaxnMjKxmHvdyVJbsDfiFKW3t
        yoevZ8Svzu7poSJvRNNclM9pWBazBmid5MnocN79XSfq1YYvy9on/mMqhRRt2Z1Gs8vAaI7yfeX2Q
        pM4eaXNS5t+/v9yWUVgaBKj1rp4avJoPPBI1lDl4o3R+PJl1DM6GzRZTILJdHJsqvshR+S0rzwWOe
        BKBYA9CUXRzNRSIv6cLabT+4ZKsBl/9b706gDUX/44xynzZpYzyRHburd7ovhkLHqi0LMp0wTuUnc
        naby8mmA==;
Received: from [2001:4bb8:191:f9ce:bae8:5658:102a:5491] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mqZs4-00ASJm-An; Fri, 26 Nov 2021 11:58:29 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Paolo Valente <paolo.valente@linaro.org>, Jan Kara <jack@suse.cz>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: [PATCH 07/14] block: move blk_mq_sched_assign_ioc to blk-ioc.c
Date:   Fri, 26 Nov 2021 12:58:10 +0100
Message-Id: <20211126115817.2087431-8-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211126115817.2087431-1-hch@lst.de>
References: <20211126115817.2087431-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Move blk_mq_sched_assign_ioc so that many interfaces from the file can
be marked static.  Rename the function to ioc_find_get_icq as well and
return the icq to simplify the interface.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bfq-iosched.c  |  2 +-
 block/blk-ioc.c      | 39 +++++++++++++++++++++++++++++++++++----
 block/blk-mq-sched.c | 31 -------------------------------
 block/blk-mq-sched.h |  2 --
 block/blk.h          |  6 +-----
 5 files changed, 37 insertions(+), 43 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index ecc2e57e68630..2d484d3f7f22a 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -6666,7 +6666,7 @@ static struct bfq_queue *bfq_get_bfqq_handle_split(struct bfq_data *bfqd,
  */
 static void bfq_prepare_request(struct request *rq)
 {
-	blk_mq_sched_assign_ioc(rq);
+	rq->elv.icq = ioc_find_get_icq(rq->q);
 
 	/*
 	 * Regardless of whether we have an icq attached, we have to
diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index f3ff495756cb4..f4f84a2072be7 100644
--- a/block/blk-ioc.c
+++ b/block/blk-ioc.c
@@ -24,7 +24,7 @@ static struct kmem_cache *iocontext_cachep;
  *
  * Increment reference count to @ioc.
  */
-void get_io_context(struct io_context *ioc)
+static void get_io_context(struct io_context *ioc)
 {
 	BUG_ON(atomic_long_read(&ioc->refcount) <= 0);
 	atomic_long_inc(&ioc->refcount);
@@ -248,7 +248,8 @@ void ioc_clear_queue(struct request_queue *q)
 	__ioc_clear_queue(&icq_list);
 }
 
-int create_task_io_context(struct task_struct *task, gfp_t gfp_flags, int node)
+static int create_task_io_context(struct task_struct *task, gfp_t gfp_flags,
+		int node)
 {
 	struct io_context *ioc;
 	int ret;
@@ -397,8 +398,8 @@ EXPORT_SYMBOL(ioc_lookup_icq);
  * The caller is responsible for ensuring @ioc won't go away and @q is
  * alive and will stay alive until this function returns.
  */
-struct io_cq *ioc_create_icq(struct io_context *ioc, struct request_queue *q,
-			     gfp_t gfp_mask)
+static struct io_cq *ioc_create_icq(struct io_context *ioc,
+		struct request_queue *q, gfp_t gfp_mask)
 {
 	struct elevator_type *et = q->elevator->type;
 	struct io_cq *icq;
@@ -441,6 +442,36 @@ struct io_cq *ioc_create_icq(struct io_context *ioc, struct request_queue *q,
 	return icq;
 }
 
+struct io_cq *ioc_find_get_icq(struct request_queue *q)
+{
+	struct io_context *ioc;
+	struct io_cq *icq;
+
+	/* create task io_context, if we don't have one already */
+	if (unlikely(!current->io_context))
+		create_task_io_context(current, GFP_ATOMIC, q->node);
+
+	/*
+	 * May not have an IO context if it's a passthrough request
+	 */
+	ioc = current->io_context;
+	if (!ioc)
+		return NULL;
+
+	spin_lock_irq(&q->queue_lock);
+	icq = ioc_lookup_icq(ioc, q);
+	spin_unlock_irq(&q->queue_lock);
+
+	if (!icq) {
+		icq = ioc_create_icq(ioc, q, GFP_ATOMIC);
+		if (!icq)
+			return NULL;
+	}
+	get_io_context(icq->ioc);
+	return icq;
+}
+EXPORT_SYMBOL_GPL(ioc_find_get_icq);
+
 static int __init blk_ioc_init(void)
 {
 	iocontext_cachep = kmem_cache_create("blkdev_ioc",
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index b942b38000e53..0d7257848f7ef 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -18,37 +18,6 @@
 #include "blk-mq-tag.h"
 #include "blk-wbt.h"
 
-void blk_mq_sched_assign_ioc(struct request *rq)
-{
-	struct request_queue *q = rq->q;
-	struct io_context *ioc;
-	struct io_cq *icq;
-
-	/* create task io_context, if we don't have one already */
-	if (unlikely(!current->io_context))
-		create_task_io_context(current, GFP_ATOMIC, q->node);
-
-	/*
-	 * May not have an IO context if it's a passthrough request
-	 */
-	ioc = current->io_context;
-	if (!ioc)
-		return;
-
-	spin_lock_irq(&q->queue_lock);
-	icq = ioc_lookup_icq(ioc, q);
-	spin_unlock_irq(&q->queue_lock);
-
-	if (!icq) {
-		icq = ioc_create_icq(ioc, q, GFP_ATOMIC);
-		if (!icq)
-			return;
-	}
-	get_io_context(icq->ioc);
-	rq->elv.icq = icq;
-}
-EXPORT_SYMBOL_GPL(blk_mq_sched_assign_ioc);
-
 /*
  * Mark a hardware queue as needing a restart. For shared queues, maintain
  * a count of how many hardware queues are marked for restart.
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index 25d1034952b65..0250139724539 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -8,8 +8,6 @@
 
 #define MAX_SCHED_RQ (16 * BLKDEV_DEFAULT_RQ)
 
-void blk_mq_sched_assign_ioc(struct request *rq);
-
 bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio,
 		unsigned int nr_segs, struct request **merged_request);
 bool blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio,
diff --git a/block/blk.h b/block/blk.h
index a57c84654d0a1..187cb2654ffde 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -363,14 +363,10 @@ static inline unsigned int bio_aligned_discard_max_sectors(
 /*
  * Internal io_context interface
  */
-void get_io_context(struct io_context *ioc);
+struct io_cq *ioc_find_get_icq(struct request_queue *q);
 struct io_cq *ioc_lookup_icq(struct io_context *ioc, struct request_queue *q);
-struct io_cq *ioc_create_icq(struct io_context *ioc, struct request_queue *q,
-			     gfp_t gfp_mask);
 void ioc_clear_queue(struct request_queue *q);
 
-int create_task_io_context(struct task_struct *task, gfp_t gfp_mask, int node);
-
 #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
 extern ssize_t blk_throtl_sample_time_show(struct request_queue *q, char *page);
 extern ssize_t blk_throtl_sample_time_store(struct request_queue *q,
-- 
2.30.2

