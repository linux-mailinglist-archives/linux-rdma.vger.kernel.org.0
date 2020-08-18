Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0827824846C
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Aug 2020 14:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgHRMGa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Aug 2020 08:06:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:33168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726568AbgHRMG3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 18 Aug 2020 08:06:29 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 493E9207DA;
        Tue, 18 Aug 2020 12:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597752388;
        bh=zHOHiUIxNYpf5WrkCJQrvEi7r97s010Z3j2jbJ3EXkc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kHcAXPDg7nOl4asSXUsG1lyquYSI5Y/KUA29LMU/GbJ6rVMjuQAs7UWqZYPyWxre8
         XNtHGC5PrD4EFLV+ttOS6g9sZn/xu65NXB03Apwb5EhW+OctBmH1X9M/cADTI4b5Sk
         deWtKbeB0TCesDyTcUixwdyfS0W7CiWmy/wKicTE=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 14/14] RDMA/ucma: Remove closing and the close_wq
Date:   Tue, 18 Aug 2020 15:05:26 +0300
Message-Id: <20200818120526.702120-15-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200818120526.702120-1-leon@kernel.org>
References: <20200818120526.702120-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>

Use cancel_work_sync() to ensure that the wq is not running and simply
assign NULL to ctx->cm_id to indicate if the work ran or not. Delete the
close_wq since flush_workqueue() is no longer needed.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/ucma.c | 49 +++++++++++-----------------------
 1 file changed, 15 insertions(+), 34 deletions(-)

diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
index 40539c9625d6..46d37e470e98 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -80,7 +80,6 @@ struct ucma_file {
 	struct list_head	ctx_list;
 	struct list_head	event_list;
 	wait_queue_head_t	poll_wait;
-	struct workqueue_struct	*close_wq;
 };
 
 struct ucma_context {
@@ -96,10 +95,6 @@ struct ucma_context {
 	u64			uid;
 
 	struct list_head	list;
-	/* mark that device is in process of destroying the internal HW
-	 * resources, protected by the ctx_table lock
-	 */
-	int			closing;
 	/* sync between removal event and id destroy, protected by file mut */
 	int			destroying;
 	struct work_struct	close_work;
@@ -148,12 +143,9 @@ static struct ucma_context *ucma_get_ctx(struct ucma_file *file, int id)
 
 	xa_lock(&ctx_table);
 	ctx = _ucma_find_context(id, file);
-	if (!IS_ERR(ctx)) {
-		if (ctx->closing)
-			ctx = ERR_PTR(-EIO);
-		else if (!refcount_inc_not_zero(&ctx->ref))
+	if (!IS_ERR(ctx))
+		if (!refcount_inc_not_zero(&ctx->ref))
 			ctx = ERR_PTR(-ENXIO);
-	}
 	xa_unlock(&ctx_table);
 	return ctx;
 }
@@ -193,6 +185,14 @@ static void ucma_close_id(struct work_struct *work)
 	wait_for_completion(&ctx->comp);
 	/* No new events will be generated after destroying the id. */
 	rdma_destroy_id(ctx->cm_id);
+
+	/*
+	 * At this point ctx->ref is zero so the only place the ctx can be is in
+	 * a uevent or in __destroy_id(). Since the former doesn't touch
+	 * ctx->cm_id and the latter sync cancels this, there is no races with
+	 * this store.
+	 */
+	ctx->cm_id = NULL;
 }
 
 static struct ucma_context *ucma_alloc_ctx(struct ucma_file *file)
@@ -356,12 +356,8 @@ static int ucma_event_handler(struct rdma_cm_id *cm_id,
 		wake_up_interruptible(&ctx->file->poll_wait);
 	}
 
-	if (event->event == RDMA_CM_EVENT_DEVICE_REMOVAL && !ctx->destroying) {
-		xa_lock(&ctx_table);
-		ctx->closing = 1;
-		xa_unlock(&ctx_table);
-		queue_work(ctx->file->close_wq, &ctx->close_work);
-	}
+	if (event->event == RDMA_CM_EVENT_DEVICE_REMOVAL && !ctx->destroying)
+		queue_work(system_unbound_wq, &ctx->close_work);
 	return 0;
 }
 
@@ -577,17 +573,10 @@ static int __destroy_id(struct ucma_context *ctx)
 		ucma_put_ctx(ctx);
 	}
 
-	flush_workqueue(ctx->file->close_wq);
+	cancel_work_sync(&ctx->close_work);
 	/* At this point it's guaranteed that there is no inflight closing task */
-	xa_lock(&ctx_table);
-	if (!ctx->closing) {
-		xa_unlock(&ctx_table);
-		ucma_put_ctx(ctx);
-		wait_for_completion(&ctx->comp);
-		rdma_destroy_id(ctx->cm_id);
-	} else {
-		xa_unlock(&ctx_table);
-	}
+	if (ctx->cm_id)
+		ucma_close_id(&ctx->close_work);
 	return ucma_free_ctx(ctx);
 }
 
@@ -1788,13 +1777,6 @@ static int ucma_open(struct inode *inode, struct file *filp)
 	if (!file)
 		return -ENOMEM;
 
-	file->close_wq = alloc_ordered_workqueue("ucma_close_id",
-						 WQ_MEM_RECLAIM);
-	if (!file->close_wq) {
-		kfree(file);
-		return -ENOMEM;
-	}
-
 	INIT_LIST_HEAD(&file->event_list);
 	INIT_LIST_HEAD(&file->ctx_list);
 	init_waitqueue_head(&file->poll_wait);
@@ -1825,7 +1807,6 @@ static int ucma_close(struct inode *inode, struct file *filp)
 		xa_erase(&ctx_table, ctx->id);
 		__destroy_id(ctx);
 	}
-	destroy_workqueue(file->close_wq);
 	kfree(file);
 	return 0;
 }
-- 
2.26.2

