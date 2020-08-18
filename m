Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8009C24846A
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Aug 2020 14:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgHRMGW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Aug 2020 08:06:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:33114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726598AbgHRMGV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 18 Aug 2020 08:06:21 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E53B207DA;
        Tue, 18 Aug 2020 12:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597752380;
        bh=Oxt8KQNSWxdgBQ8ZyZcXEDIsYAwg3CJHsZ4SGjAuJyE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UOYiG88XJrrQQHEBT6kzyT/rPE4b4hUgF019tUgUP8OI+ke7I8IjP4yxmdiCWJcGz
         ejWALyahGVhFcyh1wnE5L9AHmcv6DVlY/PHGtwC3zOk5BM69gYEo+lCD2iR9Z2nmHI
         afEGFV9nwBSiHj72qRPu96iCsjAgRl49smRPP3ts=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 13/14] RDMA/ucma: Rework how new connections are passed through event delivery
Date:   Tue, 18 Aug 2020 15:05:25 +0300
Message-Id: <20200818120526.702120-14-leon@kernel.org>
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

When a new connection is established the RDMA CM creates a new cm_id and
passes it through to the event handler. However inside the UCMA the new ID
is not assigned a ucma_context until the user retrieves the event from a
syscall.

This creates a weird edge condition where a cm_id's context can continue
to point at the listening_id that created it, and a number of additional
edge conditions on event list clean up related to destroying half created
IDs.

There is also a race condition in ucma_get_events() where the
cm_id->context is being assigned without holding the handler_mutex.

Simplify all of this by creating the ucma_context inside the event handler
itself and eliminating the edge case of a half created cm_id. All cm_id's
can be uniformly destroyed via __destroy_id() or via the close_work.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/ucma.c | 222 ++++++++++++++-------------------
 1 file changed, 96 insertions(+), 126 deletions(-)

diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
index 32e82bcffccd..40539c9625d6 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -117,11 +117,10 @@ struct ucma_multicast {
 
 struct ucma_event {
 	struct ucma_context	*ctx;
+	struct ucma_context	*listen_ctx;
 	struct ucma_multicast	*mc;
 	struct list_head	list;
-	struct rdma_cm_id	*cm_id;
 	struct rdma_ucm_event_resp resp;
-	struct work_struct	close_work;
 };
 
 static DEFINE_XARRAY_ALLOC(ctx_table);
@@ -182,14 +181,6 @@ static struct ucma_context *ucma_get_ctx_dev(struct ucma_file *file, int id)
 	return ctx;
 }
 
-static void ucma_close_event_id(struct work_struct *work)
-{
-	struct ucma_event *uevent_close =  container_of(work, struct ucma_event, close_work);
-
-	rdma_destroy_id(uevent_close->cm_id);
-	kfree(uevent_close);
-}
-
 static void ucma_close_id(struct work_struct *work)
 {
 	struct ucma_context *ctx =  container_of(work, struct ucma_context, close_work);
@@ -263,10 +254,15 @@ static void ucma_copy_ud_event(struct ib_device *device,
 	dst->qkey = src->qkey;
 }
 
-static void ucma_set_event_context(struct ucma_context *ctx,
-				   struct rdma_cm_event *event,
-				   struct ucma_event *uevent)
+static struct ucma_event *ucma_create_uevent(struct ucma_context *ctx,
+					     struct rdma_cm_event *event)
 {
+	struct ucma_event *uevent;
+
+	uevent = kzalloc(sizeof(*uevent), GFP_KERNEL);
+	if (!uevent)
+		return NULL;
+
 	uevent->ctx = ctx;
 	switch (event->event) {
 	case RDMA_CM_EVENT_MULTICAST_JOIN:
@@ -281,45 +277,56 @@ static void ucma_set_event_context(struct ucma_context *ctx,
 		uevent->resp.id = ctx->id;
 		break;
 	}
+	uevent->resp.event = event->event;
+	uevent->resp.status = event->status;
+	if (ctx->cm_id->qp_type == IB_QPT_UD)
+		ucma_copy_ud_event(ctx->cm_id->device, &uevent->resp.param.ud,
+				   &event->param.ud);
+	else
+		ucma_copy_conn_event(&uevent->resp.param.conn,
+				     &event->param.conn);
+
+	uevent->resp.ece.vendor_id = event->ece.vendor_id;
+	uevent->resp.ece.attr_mod = event->ece.attr_mod;
+	return uevent;
 }
 
-static void ucma_removal_event_handler(struct rdma_cm_id *cm_id)
+static int ucma_connect_event_handler(struct rdma_cm_id *cm_id,
+				      struct rdma_cm_event *event)
 {
-	struct ucma_context *ctx = cm_id->context;
-	struct ucma_event *con_req_eve;
-	int event_found = 0;
+	struct ucma_context *listen_ctx = cm_id->context;
+	struct ucma_context *ctx;
+	struct ucma_event *uevent;
 
-	if (ctx->destroying)
-		return;
+	if (!atomic_add_unless(&listen_ctx->backlog, -1, 0))
+		return -ENOMEM;
+	ctx = ucma_alloc_ctx(listen_ctx->file);
+	if (!ctx)
+		goto err_backlog;
+	ctx->cm_id = cm_id;
 
-	/* only if context is pointing to cm_id that it owns it and can be
-	 * queued to be closed, otherwise that cm_id is an inflight one that
-	 * is part of that context event list pending to be detached and
-	 * reattached to its new context as part of ucma_get_event,
-	 * handled separately below.
-	 */
-	if (ctx->cm_id == cm_id) {
-		xa_lock(&ctx_table);
-		ctx->closing = 1;
-		xa_unlock(&ctx_table);
-		queue_work(ctx->file->close_wq, &ctx->close_work);
-		return;
-	}
+	uevent = ucma_create_uevent(listen_ctx, event);
+	if (!uevent)
+		goto err_alloc;
+	uevent->listen_ctx = listen_ctx;
+	uevent->resp.id = ctx->id;
+
+	ctx->cm_id->context = ctx;
 
 	mutex_lock(&ctx->file->mut);
-	list_for_each_entry(con_req_eve, &ctx->file->event_list, list) {
-		if (con_req_eve->cm_id == cm_id &&
-		    con_req_eve->resp.event == RDMA_CM_EVENT_CONNECT_REQUEST) {
-			list_del(&con_req_eve->list);
-			INIT_WORK(&con_req_eve->close_work, ucma_close_event_id);
-			queue_work(ctx->file->close_wq, &con_req_eve->close_work);
-			event_found = 1;
-			break;
-		}
-	}
+	ucma_finish_ctx(ctx);
+	list_add_tail(&uevent->list, &ctx->file->event_list);
 	mutex_unlock(&ctx->file->mut);
-	if (!event_found)
-		pr_err("ucma_removal_event_handler: warning: connect request event wasn't found\n");
+	wake_up_interruptible(&ctx->file->poll_wait);
+	return 0;
+
+err_alloc:
+	xa_erase(&ctx_table, ctx->id);
+	kfree(ctx);
+err_backlog:
+	atomic_inc(&listen_ctx->backlog);
+	/* Returning error causes the new ID to be destroyed */
+	return -ENOMEM;
 }
 
 static int ucma_event_handler(struct rdma_cm_id *cm_id,
@@ -328,61 +335,41 @@ static int ucma_event_handler(struct rdma_cm_id *cm_id,
 	struct ucma_event *uevent;
 	struct ucma_context *ctx = cm_id->context;
 
-	uevent = kzalloc(sizeof(*uevent), GFP_KERNEL);
-	if (!uevent)
-		return event->event == RDMA_CM_EVENT_CONNECT_REQUEST;
+	if (event->event == RDMA_CM_EVENT_CONNECT_REQUEST)
+		return ucma_connect_event_handler(cm_id, event);
 
-	uevent->cm_id = cm_id;
-	ucma_set_event_context(ctx, event, uevent);
-	uevent->resp.event = event->event;
-	uevent->resp.status = event->status;
-	if (cm_id->qp_type == IB_QPT_UD)
-		ucma_copy_ud_event(cm_id->device, &uevent->resp.param.ud,
-				   &event->param.ud);
-	else
-		ucma_copy_conn_event(&uevent->resp.param.conn,
-				     &event->param.conn);
-
-	uevent->resp.ece.vendor_id = event->ece.vendor_id;
-	uevent->resp.ece.attr_mod = event->ece.attr_mod;
-
-	if (event->event == RDMA_CM_EVENT_CONNECT_REQUEST) {
-		if (!atomic_add_unless(&ctx->backlog, -1, 0)) {
-			kfree(uevent);
-			return -ENOMEM;
-		}
-	} else if (!ctx->uid || ctx->cm_id != cm_id) {
-		/*
-		 * We ignore events for new connections until userspace has set
-		 * their context.  This can only happen if an error occurs on a
-		 * new connection before the user accepts it.  This is okay,
-		 * since the accept will just fail later. However, we do need
-		 * to release the underlying HW resources in case of a device
-		 * removal event.
-		 */
-		if (event->event == RDMA_CM_EVENT_DEVICE_REMOVAL)
-			ucma_removal_event_handler(cm_id);
-
-		kfree(uevent);
-		return 0;
+	/*
+	 * We ignore events for new connections until userspace has set their
+	 * context.  This can only happen if an error occurs on a new connection
+	 * before the user accepts it.  This is okay, since the accept will just
+	 * fail later. However, we do need to release the underlying HW
+	 * resources in case of a device removal event.
+	 */
+	if (ctx->uid) {
+		uevent = ucma_create_uevent(ctx, event);
+		if (!uevent)
+			return 0;
+
+		mutex_lock(&ctx->file->mut);
+		list_add_tail(&uevent->list, &ctx->file->event_list);
+		mutex_unlock(&ctx->file->mut);
+		wake_up_interruptible(&ctx->file->poll_wait);
 	}
 
-	mutex_lock(&ctx->file->mut);
-	list_add_tail(&uevent->list, &ctx->file->event_list);
-	mutex_unlock(&ctx->file->mut);
-	wake_up_interruptible(&ctx->file->poll_wait);
-	if (event->event == RDMA_CM_EVENT_DEVICE_REMOVAL)
-		ucma_removal_event_handler(cm_id);
+	if (event->event == RDMA_CM_EVENT_DEVICE_REMOVAL && !ctx->destroying) {
+		xa_lock(&ctx_table);
+		ctx->closing = 1;
+		xa_unlock(&ctx_table);
+		queue_work(ctx->file->close_wq, &ctx->close_work);
+	}
 	return 0;
 }
 
 static ssize_t ucma_get_event(struct ucma_file *file, const char __user *inbuf,
 			      int in_len, int out_len)
 {
-	struct ucma_context *ctx = NULL;
 	struct rdma_ucm_get_event cmd;
 	struct ucma_event *uevent;
-	int ret = 0;
 
 	/*
 	 * Old 32 bit user space does not send the 4 byte padding in the
@@ -411,46 +398,23 @@ static ssize_t ucma_get_event(struct ucma_file *file, const char __user *inbuf,
 
 	uevent = list_first_entry(&file->event_list, struct ucma_event, list);
 
-	if (uevent->resp.event == RDMA_CM_EVENT_CONNECT_REQUEST) {
-		ctx = ucma_alloc_ctx(file);
-		if (!ctx) {
-			ret = -ENOMEM;
-			goto err_unlock;
-		}
-		uevent->resp.id = ctx->id;
-		ctx->cm_id = uevent->cm_id;
-	}
-
 	if (copy_to_user(u64_to_user_ptr(cmd.response),
 			 &uevent->resp,
 			 min_t(size_t, out_len, sizeof(uevent->resp)))) {
-		ret = -EFAULT;
-		goto err_ctx;
-	}
-
-	if (ctx) {
-		atomic_inc(&uevent->ctx->backlog);
-		uevent->cm_id->context = ctx;
-		ucma_finish_ctx(ctx);
+		mutex_unlock(&file->mut);
+		return -EFAULT;
 	}
 
 	list_del(&uevent->list);
 	uevent->ctx->events_reported++;
 	if (uevent->mc)
 		uevent->mc->events_reported++;
+	if (uevent->resp.event == RDMA_CM_EVENT_CONNECT_REQUEST)
+		atomic_inc(&uevent->ctx->backlog);
 	mutex_unlock(&file->mut);
 
 	kfree(uevent);
 	return 0;
-
-err_ctx:
-	if (ctx) {
-		xa_erase(&ctx_table, ctx->id);
-		kfree(ctx);
-	}
-err_unlock:
-	mutex_unlock(&file->mut);
-	return ret;
 }
 
 static int ucma_get_qp_type(struct rdma_ucm_create_id *cmd, enum ib_qp_type *qp_type)
@@ -562,10 +526,6 @@ static void ucma_cleanup_mc_events(struct ucma_multicast *mc)
  * this point, no new events will be reported from the hardware. However, we
  * still need to cleanup the UCMA context for this ID. Specifically, there
  * might be events that have not yet been consumed by the user space software.
- * These might include pending connect requests which we have not completed
- * processing.  We cannot call rdma_destroy_id while holding the lock of the
- * context (file->mut), as it might cause a deadlock. We therefore extract all
- * relevant events from the context pending events list while holding the
  * mutex. After that we release them as needed.
  */
 static int ucma_free_ctx(struct ucma_context *ctx)
@@ -574,23 +534,27 @@ static int ucma_free_ctx(struct ucma_context *ctx)
 	struct ucma_event *uevent, *tmp;
 	LIST_HEAD(list);
 
-
 	ucma_cleanup_multicast(ctx);
 
 	/* Cleanup events not yet reported to the user. */
 	mutex_lock(&ctx->file->mut);
 	list_for_each_entry_safe(uevent, tmp, &ctx->file->event_list, list) {
-		if (uevent->ctx == ctx)
+		if (uevent->ctx == ctx || uevent->listen_ctx == ctx)
 			list_move_tail(&uevent->list, &list);
 	}
 	list_del(&ctx->list);
 	events_reported = ctx->events_reported;
 	mutex_unlock(&ctx->file->mut);
 
+	/*
+	 * If this was a listening ID then any connections spawned from it
+	 * that have not been delivered to userspace are cleaned up too.
+	 * Must be done outside any locks.
+	 */
 	list_for_each_entry_safe(uevent, tmp, &list, list) {
 		list_del(&uevent->list);
 		if (uevent->resp.event == RDMA_CM_EVENT_CONNECT_REQUEST)
-			rdma_destroy_id(uevent->cm_id);
+			__destroy_id(uevent->ctx);
 		kfree(uevent);
 	}
 
@@ -1845,13 +1809,19 @@ static int ucma_open(struct inode *inode, struct file *filp)
 static int ucma_close(struct inode *inode, struct file *filp)
 {
 	struct ucma_file *file = filp->private_data;
-	struct ucma_context *ctx, *tmp;
 
 	/*
-	 * ctx_list can only be mutated under the write(), which is no longer
-	 * possible, so no locking needed.
+	 * All paths that touch ctx_list or ctx_list starting from write() are
+	 * prevented by this being a FD release function. The list_add_tail() in
+	 * ucma_connect_event_handler() can run concurrently, however it only
+	 * adds to the list *after* a listening ID. By only reading the first of
+	 * the list, and relying on __destroy_id() to block
+	 * ucma_connect_event_handler(), no additional locking is needed.
 	 */
-	list_for_each_entry_safe(ctx, tmp, &file->ctx_list, list) {
+	while (!list_empty(&file->ctx_list)) {
+		struct ucma_context *ctx = list_first_entry(
+			&file->ctx_list, struct ucma_context, list);
+
 		xa_erase(&ctx_table, ctx->id);
 		__destroy_id(ctx);
 	}
-- 
2.26.2

