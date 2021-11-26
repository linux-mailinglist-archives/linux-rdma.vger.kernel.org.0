Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 911EE45EE18
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Nov 2021 13:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236177AbhKZMj0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 26 Nov 2021 07:39:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235419AbhKZMhZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 26 Nov 2021 07:37:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C90C08EA75;
        Fri, 26 Nov 2021 03:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=PDMej3uV0A69WfPJSYZoi9ft4XTEBwKSjC8fReC4QEY=; b=HYRwctFE5c7GTgKbjdufN09ivL
        jki4BjRwgcrxQGeAIQ/XL6jSkI4XAkVJm2fitp4ZcTAL4QNlfUbT4ZJfmQoDq6lwUFYojHBxpcEt+
        HOPQ4KfIW4aM8+JypqsTh9SiOGwLYJC2cgjcK34qq9QtFoEscXslIbVEGd6i7ghjStUe2zHo0KDjn
        oO+DxSrizS8XIZFJcAs5bN5ynAWXzXJ2DPdO/vxpiecZg7JAATxwyfJofnW7mQXynnyi36o6F5MWg
        I8tORaOKdsLUHvT1xFtPt1YkPrfj9axAGd8i48Gk/jDrSuWAOiSRv9pfHFUisxTAZu1wJJpUDEwed
        T+JeSlWg==;
Received: from [2001:4bb8:191:f9ce:bae8:5658:102a:5491] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mqZs5-00ASKG-KU; Fri, 26 Nov 2021 11:58:30 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Paolo Valente <paolo.valente@linaro.org>, Jan Kara <jack@suse.cz>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: [PATCH 08/14] block: move the remaining elv.icq handling to the I/O scheduler
Date:   Fri, 26 Nov 2021 12:58:11 +0100
Message-Id: <20211126115817.2087431-9-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211126115817.2087431-1-hch@lst.de>
References: <20211126115817.2087431-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

After the prepare side has been moved to the only I/O scheduler that
cares, do the same for the cleanup and the NULL initialization.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bfq-iosched.c | 12 +++++++++++-
 block/blk-ioc.c     |  1 +
 block/blk-mq.c      | 14 +++-----------
 3 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 2d484d3f7f22a..8295b0f96cbfe 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -6569,6 +6569,16 @@ static void bfq_finish_requeue_request(struct request *rq)
 	rq->elv.priv[1] = NULL;
 }
 
+static void bfq_finish_request(struct request *rq)
+{
+	bfq_finish_requeue_request(rq);
+
+	if (rq->elv.icq) {
+		put_io_context(rq->elv.icq->ioc);
+		rq->elv.icq = NULL;
+	}
+}
+
 /*
  * Removes the association between the current task and bfqq, assuming
  * that bic points to the bfq iocontext of the task.
@@ -7388,7 +7398,7 @@ static struct elevator_type iosched_bfq_mq = {
 		.limit_depth		= bfq_limit_depth,
 		.prepare_request	= bfq_prepare_request,
 		.requeue_request        = bfq_finish_requeue_request,
-		.finish_request		= bfq_finish_requeue_request,
+		.finish_request		= bfq_finish_request,
 		.exit_icq		= bfq_exit_icq,
 		.insert_requests	= bfq_insert_requests,
 		.dispatch_request	= bfq_dispatch_request,
diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index f4f84a2072be7..3ba15c867dfa6 100644
--- a/block/blk-ioc.c
+++ b/block/blk-ioc.c
@@ -167,6 +167,7 @@ void put_io_context(struct io_context *ioc)
 	if (free_ioc)
 		kmem_cache_free(iocontext_cachep, ioc);
 }
+EXPORT_SYMBOL_GPL(put_io_context);
 
 /**
  * put_io_context_active - put active reference on ioc
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 82491ab676fb1..7bdef269a5d94 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -400,7 +400,6 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 	if (rq->rq_flags & RQF_ELV) {
 		struct elevator_queue *e = data->q->elevator;
 
-		rq->elv.icq = NULL;
 		INIT_HLIST_NODE(&rq->hash);
 		RB_CLEAR_NODE(&rq->rb_node);
 
@@ -631,16 +630,9 @@ void blk_mq_free_request(struct request *rq)
 	struct request_queue *q = rq->q;
 	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
 
-	if (rq->rq_flags & RQF_ELVPRIV) {
-		struct elevator_queue *e = q->elevator;
-
-		if (e->type->ops.finish_request)
-			e->type->ops.finish_request(rq);
-		if (rq->elv.icq) {
-			put_io_context(rq->elv.icq->ioc);
-			rq->elv.icq = NULL;
-		}
-	}
+	if ((rq->rq_flags & RQF_ELVPRIV) &&
+	    q->elevator->type->ops.finish_request)
+		q->elevator->type->ops.finish_request(rq);
 
 	if (rq->rq_flags & RQF_MQ_INFLIGHT)
 		__blk_mq_dec_active_requests(hctx);
-- 
2.30.2

