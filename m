Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABA745EE1A
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Nov 2021 13:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377579AbhKZMj2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 26 Nov 2021 07:39:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377198AbhKZMh0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 26 Nov 2021 07:37:26 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05030C08EA77;
        Fri, 26 Nov 2021 03:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=+BFx8j7M87EAoFMxSgcYqvBCcWuO6nRbLCHiZUMRy8o=; b=sRM/131K2LBUYEpJ9EwYqxibDM
        yD+zYnd5iNTEs6xAhhaHMvnUOXk2Vb+HAR45SbSmBMVtI58FntJkLzIFn5HYjwXM6SnBI3wstPFGT
        C2mPQkaaqsHFxYLTRrKBGw+BmIbFL8t2JVwposFx4iRwH1zTr4ID7ZsD4bYgBeXGPTRYbTTyNa9+a
        wnzk/sDnWw+jNsxk++pP7/FSZ1HDzM0PdbtJDsjK38TBFDDCpoVEj6ZIKLJESfUDqpl603hOi41iS
        0s3xZU2ziNShT9UVzViyaw/ZeARS+F5PRaIn6YvWIL8g2RtYqgeROOgkPCxvodvCdSyTqix7ha3e7
        X6auSHeg==;
Received: from [2001:4bb8:191:f9ce:bae8:5658:102a:5491] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mqZs8-00ASL6-9V; Fri, 26 Nov 2021 11:58:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Paolo Valente <paolo.valente@linaro.org>, Jan Kara <jack@suse.cz>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: [PATCH 10/14] block: factor out a alloc_io_context helper
Date:   Fri, 26 Nov 2021 12:58:13 +0100
Message-Id: <20211126115817.2087431-11-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211126115817.2087431-1-hch@lst.de>
References: <20211126115817.2087431-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Factor out a helper that just allocate an I/O context.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-ioc.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index cc4eb2ba87f74..b42fbb82d5c0c 100644
--- a/block/blk-ioc.c
+++ b/block/blk-ioc.c
@@ -249,18 +249,15 @@ void ioc_clear_queue(struct request_queue *q)
 	__ioc_clear_queue(&icq_list);
 }
 
-static int create_task_io_context(struct task_struct *task, gfp_t gfp_flags,
-		int node)
+static struct io_context *alloc_io_context(gfp_t gfp_flags, int node)
 {
 	struct io_context *ioc;
-	int ret;
 
 	ioc = kmem_cache_alloc_node(iocontext_cachep, gfp_flags | __GFP_ZERO,
 				    node);
 	if (unlikely(!ioc))
-		return -ENOMEM;
+		return NULL;
 
-	/* initialize */
 	atomic_long_set(&ioc->refcount, 1);
 	atomic_set(&ioc->nr_tasks, 1);
 	atomic_set(&ioc->active_ref, 1);
@@ -268,6 +265,18 @@ static int create_task_io_context(struct task_struct *task, gfp_t gfp_flags,
 	INIT_RADIX_TREE(&ioc->icq_tree, GFP_ATOMIC);
 	INIT_HLIST_HEAD(&ioc->icq_list);
 	INIT_WORK(&ioc->release_work, ioc_release_fn);
+	return ioc;
+}
+
+static int create_task_io_context(struct task_struct *task, gfp_t gfp_flags,
+		int node)
+{
+	struct io_context *ioc;
+	int ret;
+
+	ioc = alloc_io_context(gfp_flags, node);
+	if (!ioc)
+		return -ENOMEM;
 
 	/*
 	 * Try to install.  ioc shouldn't be installed if someone else
-- 
2.30.2

