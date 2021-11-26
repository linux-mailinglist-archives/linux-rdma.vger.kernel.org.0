Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C51B645EE1D
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Nov 2021 13:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377198AbhKZMjb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 26 Nov 2021 07:39:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353151AbhKZMh1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 26 Nov 2021 07:37:27 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ABD9C08EA78;
        Fri, 26 Nov 2021 03:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=UqCtwnOlJ4I/jJrVI1zrTSkH7vvwV/GW4x2e0d3vkK0=; b=KQ/j8Kf9ed3SFkU4qrdKptnIqr
        TOG1RoJ3aEDHFZV1kWn86VxfI3/oIdVE6b4omkNdGF/h2oFnEm6ohlZi9YLq7/aLlTsBd2La6Y9Ax
        NDitrODOHgx1/f9gLqsAQ0y3CPqXikWl/zkURFqwPtzgYUIgYd9dQVO6ATDtDJwyXuU8qCMkj2+y6
        Dfv9NsdgZdfcqGNOP7bSjG0XlhrRt07eYZlReWPH1xcsD8+tricYwbLUqPUt988HOsyaqWNcNGYtL
        xLnntbZjA0am5CTwvnFgj/CDGiEofv8hoQJvR2y3qexM1oqZQlt245mmW0j7JVtIy3bgR7/1HJWt5
        X7dDtRgA==;
Received: from [2001:4bb8:191:f9ce:bae8:5658:102a:5491] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mqZs9-00ASLZ-Jr; Fri, 26 Nov 2021 11:58:34 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Paolo Valente <paolo.valente@linaro.org>, Jan Kara <jack@suse.cz>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: [PATCH 11/14] block: use alloc_io_context in __copy_io
Date:   Fri, 26 Nov 2021 12:58:14 +0100
Message-Id: <20211126115817.2087431-12-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211126115817.2087431-1-hch@lst.de>
References: <20211126115817.2087431-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In __copy_io we know that the newly allocate task_struct does not have
an I/O context yet and is not exiting.  So just allocate the I/O context
struct and install it directly.  There is no need to lock the task
either as it is just being created.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-ioc.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index b42fbb82d5c0c..f06d1040442c3 100644
--- a/block/blk-ioc.c
+++ b/block/blk-ioc.c
@@ -336,7 +336,6 @@ struct io_context *get_task_io_context(struct task_struct *task,
 int __copy_io(unsigned long clone_flags, struct task_struct *tsk)
 {
 	struct io_context *ioc = current->io_context;
-	struct io_context *new_ioc;
 
 	/*
 	 * Share io context with parent, if CLONE_IO is set
@@ -347,12 +346,10 @@ int __copy_io(unsigned long clone_flags, struct task_struct *tsk)
 		atomic_inc(&ioc->nr_tasks);
 		tsk->io_context = ioc;
 	} else if (ioprio_valid(ioc->ioprio)) {
-		new_ioc = get_task_io_context(tsk, GFP_KERNEL, NUMA_NO_NODE);
-		if (unlikely(!new_ioc))
+		tsk->io_context = alloc_io_context(GFP_KERNEL, NUMA_NO_NODE);
+		if (!tsk->io_context)
 			return -ENOMEM;
-
-		new_ioc->ioprio = ioc->ioprio;
-		put_io_context(new_ioc);
+		tsk->io_context->ioprio = ioc->ioprio;
 	}
 
 	return 0;
-- 
2.30.2

