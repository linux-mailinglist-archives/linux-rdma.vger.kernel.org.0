Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD1C32EA99F
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Jan 2021 12:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbhAELOP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Jan 2021 06:14:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:39852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728507AbhAELOO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 5 Jan 2021 06:14:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D0C3C229C5;
        Tue,  5 Jan 2021 11:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609845212;
        bh=pMiJl12ThNKyg2dQS8d42ALSs1X30tWTy5MUjWck434=;
        h=From:To:Cc:Subject:Date:From;
        b=pD3L8D8QR3xIv1RnHm5C8FmFrai48x6UYsoM00SaVrTXRlHPYgO1WI8pgwLU+pwsd
         DKQf7TlXq3pUl1mrSmw1wT8Qtzc8wxBy37J7xRzEwGOr179LTxi/043Ezj+AX9HIrS
         lFWUK8WsG3mXrGdl3mC698vA2nX+7Yh9me3wovgNyuDua3vrDaSFC7mZzoIQwxvghk
         NmJS088FWhLXZMipZ+EcWYxFwFWRX61lYgO03n/FRyRnHawWJl+E2C9GgeMkIS+HIh
         gzm+SYWgmtvsEBNA4h6TO6QdSie1eK3EI8+aFyVCe7X2CDs6wf5WJ2FlboMZcxiCxZ
         l2XixmPWLqBkA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH rdma-rc] RDMA/ucma: Do not miss ctx destruction steps in some cases
Date:   Tue,  5 Jan 2021 13:13:27 +0200
Message-Id: <20210105111327.230270-1-leon@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>

The destruction flow is very complicated here because the cm_id can be
destroyed from the event handler at any time if the device is
hot-removed. This leaves behind a partial ctx with no cm_id in the xarray.

Make everything consistent in this flow in all places:

 - Return the xarray back to XA_ZERO_ENTRY before beginning any
   destruction. The thread that reaches this first is responsible to
   kfree, everyone else does nothing.

 - Test the xarray during the special hot-removal case to block the
   queue_work, this has much simpler locking and doesn't require a
   'destroying'

 - Fix the ref initialization so that it is only positive if cm_id !=
   NULL, then rely on that to guide the destruction process in all cases.

Now the new ucma_destroy_private_ctx() can be called in all places that
want to free the ctx, including all the error unwinds, and none of the
details are missed.

Fixes: a1d33b70dbbc ("RDMA/ucma: Rework how new connections are passed through event delivery")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/ucma.c | 135 ++++++++++++++++++---------------
 1 file changed, 72 insertions(+), 63 deletions(-)

diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
index 7dab9a27a145..da2512c30ffd 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -95,8 +95,6 @@ struct ucma_context {
 	u64			uid;

 	struct list_head	list;
-	/* sync between removal event and id destroy, protected by file mut */
-	int			destroying;
 	struct work_struct	close_work;
 };

@@ -122,7 +120,7 @@ static DEFINE_XARRAY_ALLOC(ctx_table);
 static DEFINE_XARRAY_ALLOC(multicast_table);

 static const struct file_operations ucma_fops;
-static int __destroy_id(struct ucma_context *ctx);
+static int ucma_destroy_private_ctx(struct ucma_context *ctx);

 static inline struct ucma_context *_ucma_find_context(int id,
 						      struct ucma_file *file)
@@ -179,19 +177,14 @@ static void ucma_close_id(struct work_struct *work)

 	/* once all inflight tasks are finished, we close all underlying
 	 * resources. The context is still alive till its explicit destryoing
-	 * by its creator.
+	 * by its creator. This puts back the xarray's reference.
 	 */
 	ucma_put_ctx(ctx);
 	wait_for_completion(&ctx->comp);
 	/* No new events will be generated after destroying the id. */
 	rdma_destroy_id(ctx->cm_id);

-	/*
-	 * At this point ctx->ref is zero so the only place the ctx can be is in
-	 * a uevent or in __destroy_id(). Since the former doesn't touch
-	 * ctx->cm_id and the latter sync cancels this, there is no races with
-	 * this store.
-	 */
+	/* Reading the cm_id without holding a positive ref is not allowed */
 	ctx->cm_id = NULL;
 }

@@ -204,7 +197,6 @@ static struct ucma_context *ucma_alloc_ctx(struct ucma_file *file)
 		return NULL;

 	INIT_WORK(&ctx->close_work, ucma_close_id);
-	refcount_set(&ctx->ref, 1);
 	init_completion(&ctx->comp);
 	/* So list_del() will work if we don't do ucma_finish_ctx() */
 	INIT_LIST_HEAD(&ctx->list);
@@ -218,6 +210,13 @@ static struct ucma_context *ucma_alloc_ctx(struct ucma_file *file)
 	return ctx;
 }

+static void ucma_set_ctx_cm_id(struct ucma_context *ctx,
+			       struct rdma_cm_id *cm_id)
+{
+	refcount_set(&ctx->ref, 1);
+	ctx->cm_id = cm_id;
+}
+
 static void ucma_finish_ctx(struct ucma_context *ctx)
 {
 	lockdep_assert_held(&ctx->file->mut);
@@ -303,7 +302,7 @@ static int ucma_connect_event_handler(struct rdma_cm_id *cm_id,
 	ctx = ucma_alloc_ctx(listen_ctx->file);
 	if (!ctx)
 		goto err_backlog;
-	ctx->cm_id = cm_id;
+	ucma_set_ctx_cm_id(ctx, cm_id);

 	uevent = ucma_create_uevent(listen_ctx, event);
 	if (!uevent)
@@ -321,8 +320,7 @@ static int ucma_connect_event_handler(struct rdma_cm_id *cm_id,
 	return 0;

 err_alloc:
-	xa_erase(&ctx_table, ctx->id);
-	kfree(ctx);
+	ucma_destroy_private_ctx(ctx);
 err_backlog:
 	atomic_inc(&listen_ctx->backlog);
 	/* Returning error causes the new ID to be destroyed */
@@ -356,8 +354,12 @@ static int ucma_event_handler(struct rdma_cm_id *cm_id,
 		wake_up_interruptible(&ctx->file->poll_wait);
 	}

-	if (event->event == RDMA_CM_EVENT_DEVICE_REMOVAL && !ctx->destroying)
-		queue_work(system_unbound_wq, &ctx->close_work);
+	if (event->event == RDMA_CM_EVENT_DEVICE_REMOVAL) {
+		xa_lock(&ctx_table);
+		if (xa_load(&ctx_table, ctx->id) == ctx)
+			queue_work(system_unbound_wq, &ctx->close_work);
+		xa_unlock(&ctx_table);
+	}
 	return 0;
 }

@@ -461,13 +463,12 @@ static ssize_t ucma_create_id(struct ucma_file *file, const char __user *inbuf,
 		ret = PTR_ERR(cm_id);
 		goto err1;
 	}
-	ctx->cm_id = cm_id;
+	ucma_set_ctx_cm_id(ctx, cm_id);

 	resp.id = ctx->id;
 	if (copy_to_user(u64_to_user_ptr(cmd.response),
 			 &resp, sizeof(resp))) {
-		xa_erase(&ctx_table, ctx->id);
-		__destroy_id(ctx);
+		ucma_destroy_private_ctx(ctx);
 		return -EFAULT;
 	}

@@ -477,8 +478,7 @@ static ssize_t ucma_create_id(struct ucma_file *file, const char __user *inbuf,
 	return 0;

 err1:
-	xa_erase(&ctx_table, ctx->id);
-	kfree(ctx);
+	ucma_destroy_private_ctx(ctx);
 	return ret;
 }

@@ -516,68 +516,73 @@ static void ucma_cleanup_mc_events(struct ucma_multicast *mc)
 	rdma_unlock_handler(mc->ctx->cm_id);
 }

-/*
- * ucma_free_ctx is called after the underlying rdma CM-ID is destroyed. At
- * this point, no new events will be reported from the hardware. However, we
- * still need to cleanup the UCMA context for this ID. Specifically, there
- * might be events that have not yet been consumed by the user space software.
- * mutex. After that we release them as needed.
- */
-static int ucma_free_ctx(struct ucma_context *ctx)
+static int ucma_cleanup_ctx_events(struct ucma_context *ctx)
 {
 	int events_reported;
 	struct ucma_event *uevent, *tmp;
 	LIST_HEAD(list);

-	ucma_cleanup_multicast(ctx);
-
-	/* Cleanup events not yet reported to the user. */
+	/* Cleanup events not yet reported to the user.*/
 	mutex_lock(&ctx->file->mut);
 	list_for_each_entry_safe(uevent, tmp, &ctx->file->event_list, list) {
-		if (uevent->ctx == ctx || uevent->conn_req_ctx == ctx)
+		if (uevent->ctx != ctx)
+			continue;
+
+		if (uevent->resp.event == RDMA_CM_EVENT_CONNECT_REQUEST &&
+		    xa_cmpxchg(&ctx_table, uevent->conn_req_ctx->id,
+			       uevent->conn_req_ctx, XA_ZERO_ENTRY,
+			       GFP_KERNEL) == uevent->conn_req_ctx) {
 			list_move_tail(&uevent->list, &list);
+			continue;
+		}
+		list_del(&uevent->list);
+		kfree(uevent);
 	}
 	list_del(&ctx->list);
 	events_reported = ctx->events_reported;
 	mutex_unlock(&ctx->file->mut);

 	/*
-	 * If this was a listening ID then any connections spawned from it
-	 * that have not been delivered to userspace are cleaned up too.
-	 * Must be done outside any locks.
+	 * If this was a listening ID then any connections spawned from it that
+	 * have not been delivered to userspace are cleaned up too. Must be done
+	 * outside any locks.
 	 */
 	list_for_each_entry_safe(uevent, tmp, &list, list) {
-		list_del(&uevent->list);
-		if (uevent->resp.event == RDMA_CM_EVENT_CONNECT_REQUEST &&
-		    uevent->conn_req_ctx != ctx)
-			__destroy_id(uevent->conn_req_ctx);
+		ucma_destroy_private_ctx(uevent->conn_req_ctx);
 		kfree(uevent);
 	}
-
-	mutex_destroy(&ctx->mutex);
-	kfree(ctx);
 	return events_reported;
 }

-static int __destroy_id(struct ucma_context *ctx)
+/*
+ * When this is called the xarray must have a XA_ZERO_ENTRY in the ctx->id (ie
+ * the ctx is not public to the user). This either because:
+ *  - ucma_finish_ctx() hasn't been called
+ *  - xa_cmpxchg() succeed to remove the entry (only one thread can succeed)
+ */
+static int ucma_destroy_private_ctx(struct ucma_context *ctx)
 {
+	int events_reported;
+
 	/*
-	 * If the refcount is already 0 then ucma_close_id() has already
-	 * destroyed the cm_id, otherwise holding the refcount keeps cm_id
-	 * valid. Prevent queue_work() from being called.
+	 * Destroy the underlying cm_id. New work queuing is prevented now by
+	 * the removal from the xarray. Once the work is cancled ref will either
+	 * be 0 because the work ran to completion and consumed the ref from the
+	 * xarray, or it will be positive because we still have the ref from the
+	 * xarray. This can also be 0 in cases where cm_id was never set
 	 */
-	if (refcount_inc_not_zero(&ctx->ref)) {
-		rdma_lock_handler(ctx->cm_id);
-		ctx->destroying = 1;
-		rdma_unlock_handler(ctx->cm_id);
-		ucma_put_ctx(ctx);
-	}
-
 	cancel_work_sync(&ctx->close_work);
-	/* At this point it's guaranteed that there is no inflight closing task */
-	if (ctx->cm_id)
+	if (refcount_read(&ctx->ref))
 		ucma_close_id(&ctx->close_work);
-	return ucma_free_ctx(ctx);
+
+	events_reported = ucma_cleanup_ctx_events(ctx);
+	ucma_cleanup_multicast(ctx);
+
+	WARN_ON(xa_cmpxchg(&ctx_table, ctx->id, XA_ZERO_ENTRY, NULL,
+			   GFP_KERNEL) != NULL);
+	mutex_destroy(&ctx->mutex);
+	kfree(ctx);
+	return events_reported;
 }

 static ssize_t ucma_destroy_id(struct ucma_file *file, const char __user *inbuf,
@@ -596,14 +601,17 @@ static ssize_t ucma_destroy_id(struct ucma_file *file, const char __user *inbuf,

 	xa_lock(&ctx_table);
 	ctx = _ucma_find_context(cmd.id, file);
-	if (!IS_ERR(ctx))
-		__xa_erase(&ctx_table, ctx->id);
+	if (!IS_ERR(ctx)) {
+		if (__xa_cmpxchg(&ctx_table, ctx->id, ctx, XA_ZERO_ENTRY,
+				 GFP_KERNEL) != ctx)
+			ctx = ERR_PTR(-ENOENT);
+	}
 	xa_unlock(&ctx_table);

 	if (IS_ERR(ctx))
 		return PTR_ERR(ctx);

-	resp.events_reported = __destroy_id(ctx);
+	resp.events_reported = ucma_destroy_private_ctx(ctx);
 	if (copy_to_user(u64_to_user_ptr(cmd.response),
 			 &resp, sizeof(resp)))
 		ret = -EFAULT;
@@ -1777,15 +1785,16 @@ static int ucma_close(struct inode *inode, struct file *filp)
 	 * prevented by this being a FD release function. The list_add_tail() in
 	 * ucma_connect_event_handler() can run concurrently, however it only
 	 * adds to the list *after* a listening ID. By only reading the first of
-	 * the list, and relying on __destroy_id() to block
+	 * the list, and relying on ucma_destroy_private_ctx() to block
 	 * ucma_connect_event_handler(), no additional locking is needed.
 	 */
 	while (!list_empty(&file->ctx_list)) {
 		struct ucma_context *ctx = list_first_entry(
 			&file->ctx_list, struct ucma_context, list);

-		xa_erase(&ctx_table, ctx->id);
-		__destroy_id(ctx);
+		WARN_ON(xa_cmpxchg(&ctx_table, ctx->id, ctx, XA_ZERO_ENTRY,
+				   GFP_KERNEL) != ctx);
+		ucma_destroy_private_ctx(ctx);
 	}
 	kfree(file);
 	return 0;
--
2.29.2

