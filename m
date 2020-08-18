Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C79A24845F
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Aug 2020 14:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbgHRMFl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Aug 2020 08:05:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:32776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbgHRMFj (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 18 Aug 2020 08:05:39 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F70220786;
        Tue, 18 Aug 2020 12:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597752338;
        bh=L0TluEF/0ar6TCJ/+Q+KwpTItJoHKrJctXbUdoLUf3c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MmwpbJ4ynDUhmt9kgWtXBwhfcRV44pPUz7gkfQwmUbbMNNcz+gOUNEi2QEguEMRJb
         fOkuRvdLWgEXfudggjavxfoKSNKq+TxcNK/4R/XDiPxhIWLH0CYnj8KMM3ZAtDlWmW
         aGzteC4EbirMy5ydR9+5vCWphsNn98UiChHtYqYw=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 03/14] RDMA/ucma: Consolidate the two destroy flows
Date:   Tue, 18 Aug 2020 15:05:15 +0300
Message-Id: <20200818120526.702120-4-leon@kernel.org>
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

ucma_close() is open coding the tail end of ucma_destroy_id(), consolidate
this duplicated code into a function.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/ucma.c | 64 ++++++++++++----------------------
 1 file changed, 22 insertions(+), 42 deletions(-)

diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
index 9b019f31743d..878cbb94065f 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -601,6 +601,26 @@ static int ucma_free_ctx(struct ucma_context *ctx)
 	return events_reported;
 }
 
+static int __destroy_id(struct ucma_context *ctx)
+{
+	mutex_lock(&ctx->file->mut);
+	ctx->destroying = 1;
+	mutex_unlock(&ctx->file->mut);
+
+	flush_workqueue(ctx->file->close_wq);
+	/* At this point it's guaranteed that there is no inflight closing task */
+	xa_lock(&ctx_table);
+	if (!ctx->closing) {
+		xa_unlock(&ctx_table);
+		ucma_put_ctx(ctx);
+		wait_for_completion(&ctx->comp);
+		rdma_destroy_id(ctx->cm_id);
+	} else {
+		xa_unlock(&ctx_table);
+	}
+	return ucma_free_ctx(ctx);
+}
+
 static ssize_t ucma_destroy_id(struct ucma_file *file, const char __user *inbuf,
 			       int in_len, int out_len)
 {
@@ -624,24 +644,7 @@ static ssize_t ucma_destroy_id(struct ucma_file *file, const char __user *inbuf,
 	if (IS_ERR(ctx))
 		return PTR_ERR(ctx);
 
-	mutex_lock(&ctx->file->mut);
-	ctx->destroying = 1;
-	mutex_unlock(&ctx->file->mut);
-
-	flush_workqueue(ctx->file->close_wq);
-	/* At this point it's guaranteed that there is no inflight
-	 * closing task */
-	xa_lock(&ctx_table);
-	if (!ctx->closing) {
-		xa_unlock(&ctx_table);
-		ucma_put_ctx(ctx);
-		wait_for_completion(&ctx->comp);
-		rdma_destroy_id(ctx->cm_id);
-	} else {
-		xa_unlock(&ctx_table);
-	}
-
-	resp.events_reported = ucma_free_ctx(ctx);
+	resp.events_reported = __destroy_id(ctx);
 	if (copy_to_user(u64_to_user_ptr(cmd.response),
 			 &resp, sizeof(resp)))
 		ret = -EFAULT;
@@ -1830,30 +1833,7 @@ static int ucma_close(struct inode *inode, struct file *filp)
 	 */
 	list_for_each_entry_safe(ctx, tmp, &file->ctx_list, list) {
 		xa_erase(&ctx_table, ctx->id);
-
-		mutex_lock(&file->mut);
-		ctx->destroying = 1;
-		mutex_unlock(&file->mut);
-
-		flush_workqueue(file->close_wq);
-		/* At that step once ctx was marked as destroying and workqueue
-		 * was flushed we are safe from any inflights handlers that
-		 * might put other closing task.
-		 */
-		xa_lock(&ctx_table);
-		if (!ctx->closing) {
-			xa_unlock(&ctx_table);
-			ucma_put_ctx(ctx);
-			wait_for_completion(&ctx->comp);
-			/* rdma_destroy_id ensures that no event handlers are
-			 * inflight for that id before releasing it.
-			 */
-			rdma_destroy_id(ctx->cm_id);
-		} else {
-			xa_unlock(&ctx_table);
-		}
-
-		ucma_free_ctx(ctx);
+		__destroy_id(ctx);
 	}
 	destroy_workqueue(file->close_wq);
 	kfree(file);
-- 
2.26.2

