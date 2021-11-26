Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 907EB45EE20
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Nov 2021 13:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235151AbhKZMje (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 26 Nov 2021 07:39:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbhKZMh1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 26 Nov 2021 07:37:27 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FADBC08EAE7;
        Fri, 26 Nov 2021 03:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ddHoe7mVTenzSy5UaLglWpZv5uH0jZUNX5NQjcGtb8Y=; b=YK60G6yJ9bp6KelWJx4vEBmXML
        xSvTlBYZciRT5CXutXZZIttj/P5rhjAVGry6nbNLHczOPoAEH3FdLn6foC9wShg1JU7diYZmZ2GwK
        O0ogbh3NoabTqAoMa2+Xr9PTGLS0k/8odouAhpZToprEFVT9gJweJSUX44SF9/ouKM7XGzjmRoPzW
        Cs6h7QO9YrRJba2I17B7N2cfybQHNrk8xgnHjnV4euq6oqevME0X32iiatEmujE0o9/t3Il7TXhJU
        sRFxJgxkTdVYb4r4+8n/EIdhH4Oi1VNdh4eYIFBDnPvNLLSDO35Gf7f4vGvPMPjBLzO5Mh25AnBmM
        84ZQARqw==;
Received: from [2001:4bb8:191:f9ce:bae8:5658:102a:5491] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mqZsA-00ASM0-RE; Fri, 26 Nov 2021 11:58:35 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Paolo Valente <paolo.valente@linaro.org>, Jan Kara <jack@suse.cz>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: [PATCH 12/14] block: return the io_context from create_task_io_context
Date:   Fri, 26 Nov 2021 12:58:15 +0100
Message-Id: <20211126115817.2087431-13-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211126115817.2087431-1-hch@lst.de>
References: <20211126115817.2087431-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Grab a reference to the newly allocated or existing io_context in
create_task_io_context and return it.  This simplifies the callers and
removes the need for double lookups.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-ioc.c | 66 ++++++++++++++++++++++---------------------------
 1 file changed, 30 insertions(+), 36 deletions(-)

diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index f06d1040442c3..5bfe810496fca 100644
--- a/block/blk-ioc.c
+++ b/block/blk-ioc.c
@@ -268,15 +268,14 @@ static struct io_context *alloc_io_context(gfp_t gfp_flags, int node)
 	return ioc;
 }
 
-static int create_task_io_context(struct task_struct *task, gfp_t gfp_flags,
-		int node)
+static struct io_context *create_task_io_context(struct task_struct *task,
+		gfp_t gfp_flags, int node)
 {
 	struct io_context *ioc;
-	int ret;
 
 	ioc = alloc_io_context(gfp_flags, node);
 	if (!ioc)
-		return -ENOMEM;
+		return NULL;
 
 	/*
 	 * Try to install.  ioc shouldn't be installed if someone else
@@ -292,11 +291,11 @@ static int create_task_io_context(struct task_struct *task, gfp_t gfp_flags,
 	else
 		kmem_cache_free(iocontext_cachep, ioc);
 
-	ret = task->io_context ? 0 : -EBUSY;
-
+	ioc = task->io_context;
+	if (ioc)
+		get_io_context(ioc);
 	task_unlock(task);
-
-	return ret;
+	return ioc;
 }
 
 /**
@@ -319,18 +318,15 @@ struct io_context *get_task_io_context(struct task_struct *task,
 
 	might_sleep_if(gfpflags_allow_blocking(gfp_flags));
 
-	do {
-		task_lock(task);
-		ioc = task->io_context;
-		if (likely(ioc)) {
-			get_io_context(ioc);
-			task_unlock(task);
-			return ioc;
-		}
+	task_lock(task);
+	ioc = task->io_context;
+	if (unlikely(!ioc)) {
 		task_unlock(task);
-	} while (!create_task_io_context(task, gfp_flags, node));
-
-	return NULL;
+		return create_task_io_context(task, gfp_flags, node);
+	}
+	get_io_context(ioc);
+	task_unlock(task);
+	return ioc;
 }
 
 int __copy_io(unsigned long clone_flags, struct task_struct *tsk)
@@ -449,30 +445,28 @@ static struct io_cq *ioc_create_icq(struct io_context *ioc,
 
 struct io_cq *ioc_find_get_icq(struct request_queue *q)
 {
-	struct io_context *ioc;
-	struct io_cq *icq;
-
-	/* create task io_context, if we don't have one already */
-	if (unlikely(!current->io_context))
-		create_task_io_context(current, GFP_ATOMIC, q->node);
+	struct io_context *ioc = current->io_context;
+	struct io_cq *icq = NULL;
 
-	/*
-	 * May not have an IO context if it's a passthrough request
-	 */
-	ioc = current->io_context;
-	if (!ioc)
-		return NULL;
+	if (unlikely(!ioc)) {
+		ioc = create_task_io_context(current, GFP_ATOMIC, q->node);
+		if (!ioc)
+			return NULL;
+	} else {
+		get_io_context(ioc);
 
-	spin_lock_irq(&q->queue_lock);
-	icq = ioc_lookup_icq(ioc, q);
-	spin_unlock_irq(&q->queue_lock);
+		spin_lock_irq(&q->queue_lock);
+		icq = ioc_lookup_icq(ioc, q);
+		spin_unlock_irq(&q->queue_lock);
+	}
 
 	if (!icq) {
 		icq = ioc_create_icq(ioc, q, GFP_ATOMIC);
-		if (!icq)
+		if (!icq) {
+			put_io_context(ioc);
 			return NULL;
+		}
 	}
-	get_io_context(icq->ioc);
 	return icq;
 }
 EXPORT_SYMBOL_GPL(ioc_find_get_icq);
-- 
2.30.2

