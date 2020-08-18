Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1BEF248460
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Aug 2020 14:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgHRMFq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Aug 2020 08:05:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:32806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbgHRMFp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 18 Aug 2020 08:05:45 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D06CB204EA;
        Tue, 18 Aug 2020 12:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597752344;
        bh=OAGzcvhyCdoSk1NHeE8HGg657zA+zLFwhv5LLYf9V1M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bqpKJkSb+yXv0vEz8GsqOYZD2ApEvlO2yoVcFTLefbY3RCAtyeW1HQ6Dbso4L2N/z
         LgPzDYRwY3vhuJrdH0EwHs6jutQ/gNUNgnsugTbqs2N9zowaHRXC5wVB+x8Cd3E8Zl
         2DVX57oIvfURhM2YY2Q06FmK1Xnw8iubbfAeB7PE=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 04/14] RDMA/ucma: Fix error cases around ucma_alloc_ctx()
Date:   Tue, 18 Aug 2020 15:05:16 +0300
Message-Id: <20200818120526.702120-5-leon@kernel.org>
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

The store to ctx->cm_id was based on the idea that _ucma_find_context()
would not return the ctx until it was fully setup.

Without locking this doesn't work properly.

Split things so that the xarray is allocated with NULL to reserve the ID
and once everything is final set the cm_id and store.

Along the way this shows that the error unwind in ucma_get_event() if a
new ctx is created is wrong, fix it up.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/ucma.c | 68 +++++++++++++++++++++-------------
 1 file changed, 42 insertions(+), 26 deletions(-)

diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
index 878cbb94065f..7416a5a6aa69 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -130,6 +130,7 @@ static DEFINE_XARRAY_ALLOC(ctx_table);
 static DEFINE_XARRAY_ALLOC(multicast_table);
 
 static const struct file_operations ucma_fops;
+static int __destroy_id(struct ucma_context *ctx);
 
 static inline struct ucma_context *_ucma_find_context(int id,
 						      struct ucma_file *file)
@@ -139,7 +140,7 @@ static inline struct ucma_context *_ucma_find_context(int id,
 	ctx = xa_load(&ctx_table, id);
 	if (!ctx)
 		ctx = ERR_PTR(-ENOENT);
-	else if (ctx->file != file || !ctx->cm_id)
+	else if (ctx->file != file)
 		ctx = ERR_PTR(-EINVAL);
 	return ctx;
 }
@@ -217,18 +218,23 @@ static struct ucma_context *ucma_alloc_ctx(struct ucma_file *file)
 	refcount_set(&ctx->ref, 1);
 	init_completion(&ctx->comp);
 	INIT_LIST_HEAD(&ctx->mc_list);
+	/* So list_del() will work if we don't do ucma_finish_ctx() */
+	INIT_LIST_HEAD(&ctx->list);
 	ctx->file = file;
 	mutex_init(&ctx->mutex);
 
-	if (xa_alloc(&ctx_table, &ctx->id, ctx, xa_limit_32b, GFP_KERNEL))
-		goto error;
-
-	list_add_tail(&ctx->list, &file->ctx_list);
+	if (xa_alloc(&ctx_table, &ctx->id, NULL, xa_limit_32b, GFP_KERNEL)) {
+		kfree(ctx);
+		return NULL;
+	}
 	return ctx;
+}
 
-error:
-	kfree(ctx);
-	return NULL;
+static void ucma_finish_ctx(struct ucma_context *ctx)
+{
+	lockdep_assert_held(&ctx->file->mut);
+	list_add_tail(&ctx->list, &ctx->file->ctx_list);
+	xa_store(&ctx_table, ctx->id, ctx, GFP_KERNEL);
 }
 
 static struct ucma_multicast* ucma_alloc_multicast(struct ucma_context *ctx)
@@ -399,7 +405,7 @@ static int ucma_event_handler(struct rdma_cm_id *cm_id,
 static ssize_t ucma_get_event(struct ucma_file *file, const char __user *inbuf,
 			      int in_len, int out_len)
 {
-	struct ucma_context *ctx;
+	struct ucma_context *ctx = NULL;
 	struct rdma_ucm_get_event cmd;
 	struct ucma_event *uevent;
 	int ret = 0;
@@ -429,33 +435,46 @@ static ssize_t ucma_get_event(struct ucma_file *file, const char __user *inbuf,
 		mutex_lock(&file->mut);
 	}
 
-	uevent = list_entry(file->event_list.next, struct ucma_event, list);
+	uevent = list_first_entry(&file->event_list, struct ucma_event, list);
 
 	if (uevent->resp.event == RDMA_CM_EVENT_CONNECT_REQUEST) {
 		ctx = ucma_alloc_ctx(file);
 		if (!ctx) {
 			ret = -ENOMEM;
-			goto done;
+			goto err_unlock;
 		}
-		uevent->ctx->backlog++;
-		ctx->cm_id = uevent->cm_id;
-		ctx->cm_id->context = ctx;
 		uevent->resp.id = ctx->id;
+		ctx->cm_id = uevent->cm_id;
 	}
 
 	if (copy_to_user(u64_to_user_ptr(cmd.response),
 			 &uevent->resp,
 			 min_t(size_t, out_len, sizeof(uevent->resp)))) {
 		ret = -EFAULT;
-		goto done;
+		goto err_ctx;
+	}
+
+	if (ctx) {
+		uevent->ctx->backlog++;
+		uevent->cm_id->context = ctx;
+		ucma_finish_ctx(ctx);
 	}
 
 	list_del(&uevent->list);
 	uevent->ctx->events_reported++;
 	if (uevent->mc)
 		uevent->mc->events_reported++;
+	mutex_unlock(&file->mut);
+
 	kfree(uevent);
-done:
+	return 0;
+
+err_ctx:
+	if (ctx) {
+		xa_erase(&ctx_table, ctx->id);
+		kfree(ctx);
+	}
+err_unlock:
 	mutex_unlock(&file->mut);
 	return ret;
 }
@@ -498,9 +517,7 @@ static ssize_t ucma_create_id(struct ucma_file *file, const char __user *inbuf,
 	if (ret)
 		return ret;
 
-	mutex_lock(&file->mut);
 	ctx = ucma_alloc_ctx(file);
-	mutex_unlock(&file->mut);
 	if (!ctx)
 		return -ENOMEM;
 
@@ -511,24 +528,23 @@ static ssize_t ucma_create_id(struct ucma_file *file, const char __user *inbuf,
 		ret = PTR_ERR(cm_id);
 		goto err1;
 	}
+	ctx->cm_id = cm_id;
 
 	resp.id = ctx->id;
 	if (copy_to_user(u64_to_user_ptr(cmd.response),
 			 &resp, sizeof(resp))) {
-		ret = -EFAULT;
-		goto err2;
+		xa_erase(&ctx_table, ctx->id);
+		__destroy_id(ctx);
+		return -EFAULT;
 	}
 
-	ctx->cm_id = cm_id;
+	mutex_lock(&file->mut);
+	ucma_finish_ctx(ctx);
+	mutex_unlock(&file->mut);
 	return 0;
 
-err2:
-	rdma_destroy_id(cm_id);
 err1:
 	xa_erase(&ctx_table, ctx->id);
-	mutex_lock(&file->mut);
-	list_del(&ctx->list);
-	mutex_unlock(&file->mut);
 	kfree(ctx);
 	return ret;
 }
-- 
2.26.2

