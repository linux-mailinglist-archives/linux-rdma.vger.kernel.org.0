Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCB7113493D
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jan 2020 18:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729768AbgAHRWj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Jan 2020 12:22:39 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:41795 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729756AbgAHRWi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Jan 2020 12:22:38 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from yishaih@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 8 Jan 2020 19:22:31 +0200
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [10.7.2.17])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 008HMVv3009593;
        Wed, 8 Jan 2020 19:22:31 +0200
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [127.0.0.1])
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8) with ESMTP id 008HMVYG009531;
        Wed, 8 Jan 2020 19:22:31 +0200
Received: (from yishaih@localhost)
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8/Submit) id 008HMVL4009530;
        Wed, 8 Jan 2020 19:22:31 +0200
From:   Yishai Hadas <yishaih@mellanox.com>
To:     linux-rdma@vger.kernel.org, jgg@mellanox.com, dledford@redhat.com
Cc:     yishaih@mellanox.com, maorg@mellanox.com, michaelgur@mellanox.com
Subject: [PATCH rdma-next 02/14] RDMA/core: Simplify destruction of FD uobjects
Date:   Wed,  8 Jan 2020 19:21:54 +0200
Message-Id: <1578504126-9400-3-git-send-email-yishaih@mellanox.com>
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1578504126-9400-1-git-send-email-yishaih@mellanox.com>
References: <1578504126-9400-1-git-send-email-yishaih@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

FD uobjects have a weird split between the struct file and uobject
world. Simplify this to make them pure uobjects and use a generic release
method for all struct file operations.

This fixes the control flow so that mlx5_cmd_cleanup_async_ctx() is always
called before erasing the linked list contents to make the concurrancy
simpler to understand.

For this to work the uobject destruction must fence anything that it is
cleaning up - the design must not rely on struct file lifetime.

Only deliver_event() relies on the struct file to when adding new events
to the queue, add a is_destroyed check under lock to block it.

Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/infiniband/core/rdma_core.c        |  34 +++++----
 drivers/infiniband/core/rdma_core.h        |   8 ---
 drivers/infiniband/core/uverbs_main.c      |  23 +-----
 drivers/infiniband/core/uverbs_std_types.c |  23 +++---
 drivers/infiniband/core/uverbs_uapi.c      |   6 +-
 drivers/infiniband/hw/mlx5/devx.c          | 111 +++++++++++++----------------
 include/rdma/uverbs_types.h                |  12 ++--
 7 files changed, 94 insertions(+), 123 deletions(-)

diff --git a/drivers/infiniband/core/rdma_core.c b/drivers/infiniband/core/rdma_core.c
index a5c29e3..e8ee89d 100644
--- a/drivers/infiniband/core/rdma_core.c
+++ b/drivers/infiniband/core/rdma_core.c
@@ -359,9 +359,9 @@ static int idr_add_uobj(struct ib_uobject *uobj)
 
 	uobject = f->private_data;
 	/*
-	 * fget(id) ensures we are not currently running uverbs_close_fd,
-	 * and the caller is expected to ensure that uverbs_close_fd is never
-	 * done while a call top lookup is possible.
+	 * fget(id) ensures we are not currently running
+	 * uverbs_uobject_fd_release(), and the caller is expected to ensure
+	 * that release is never done while a call to lookup is possible.
 	 */
 	if (f->f_op != fd_type->fops) {
 		fput(f);
@@ -554,7 +554,7 @@ static int __must_check destroy_hw_fd_uobject(struct ib_uobject *uobj,
 {
 	const struct uverbs_obj_fd_type *fd_type = container_of(
 		uobj->uapi_object->type_attrs, struct uverbs_obj_fd_type, type);
-	int ret = fd_type->context_closed(uobj, why);
+	int ret = fd_type->destroy_object(uobj, why);
 
 	if (ib_is_destroy_retryable(ret, why, uobj))
 		return ret;
@@ -593,9 +593,9 @@ static int alloc_commit_fd_uobject(struct ib_uobject *uobj)
 
 	/*
 	 * The kref for uobj is moved into filp->private data and put in
-	 * uverbs_close_fd(). Once alloc_commit() succeeds uverbs_close_fd()
-	 * must be guaranteed to be called from the provided fops release
-	 * callback.
+	 * uverbs_close_fd(). Once alloc_commit() succeeds
+	 * uverbs_uobject_fd_release() must be guaranteed to be called from
+	 * the provided fops release callback.
 	 */
 	filp = anon_inode_getfile(fd_type->name,
 				  fd_type->fops,
@@ -606,7 +606,7 @@ static int alloc_commit_fd_uobject(struct ib_uobject *uobj)
 
 	uobj->object = filp;
 
-	/* Matching put will be done in uverbs_close_fd() */
+	/* Matching put will be done in uverbs_uobject_fd_release() */
 	kref_get(&uobj->ufile->ref);
 
 	/* This shouldn't be used anymore. Use the file object instead */
@@ -614,7 +614,7 @@ static int alloc_commit_fd_uobject(struct ib_uobject *uobj)
 
 	/*
 	 * NOTE: Once we install the file we loose ownership of our kref on
-	 * uobj. It will be put by uverbs_close_fd()
+	 * uobj. It will be put by uverbs_uobject_fd_release()
 	 */
 	fd_install(fd, filp);
 
@@ -682,7 +682,10 @@ static void lookup_put_fd_uobject(struct ib_uobject *uobj,
 	struct file *filp = uobj->object;
 
 	WARN_ON(mode != UVERBS_LOOKUP_READ);
-	/* This indirectly calls uverbs_close_fd and free the object */
+	/*
+	 * This indirectly calls uverbs_uobject_fd_release() and free the
+	 * object
+	 */
 	fput(filp);
 }
 
@@ -762,9 +765,13 @@ void release_ufile_idr_uobject(struct ib_uverbs_file *ufile)
 };
 EXPORT_SYMBOL(uverbs_idr_class);
 
-void uverbs_close_fd(struct file *f)
+/*
+ * Users of UVERBS_TYPE_ALLOC_FD should set this function as the struct
+ * file_operations release method.
+ */
+int uverbs_uobject_fd_release(struct inode *inode, struct file *filp)
 {
-	struct ib_uobject *uobj = f->private_data;
+	struct ib_uobject *uobj = filp->private_data;
 	struct ib_uverbs_file *ufile = uobj->ufile;
 	struct uverbs_attr_bundle attrs = {
 		.context = uobj->context,
@@ -788,8 +795,9 @@ void uverbs_close_fd(struct file *f)
 
 	/* Pairs with filp->private_data in alloc_begin_fd_uobject */
 	uverbs_uobject_put(uobj);
+	return 0;
 }
-EXPORT_SYMBOL(uverbs_close_fd);
+EXPORT_SYMBOL(uverbs_uobject_fd_release);
 
 /*
  * Drop the ucontext off the ufile and completely disconnect it from the
diff --git a/drivers/infiniband/core/rdma_core.h b/drivers/infiniband/core/rdma_core.h
index d5d58a1..9269425 100644
--- a/drivers/infiniband/core/rdma_core.h
+++ b/drivers/infiniband/core/rdma_core.h
@@ -50,14 +50,6 @@ void uverbs_destroy_ufile_hw(struct ib_uverbs_file *ufile,
 
 int uobj_destroy(struct ib_uobject *uobj, struct uverbs_attr_bundle *attrs);
 
-/* Indicate this fd is no longer used by this consumer, but its memory isn't
- * necessarily released yet. When the last reference is put, we release the
- * memory. After this call is executed, calling uverbs_uobject_get isn't
- * allowed.
- * This must be called from the release file_operations of the file!
- */
-void uverbs_close_fd(struct file *f);
-
 /*
  * Get an ib_uobject that corresponds to the given id from ufile, assuming
  * the object is from the given type. Lock it to the required access when
diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
index 970d8e3..290a91e 100644
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -377,32 +377,11 @@ static int ib_uverbs_async_event_close(struct inode *inode, struct file *filp)
 	return 0;
 }
 
-static int ib_uverbs_comp_event_close(struct inode *inode, struct file *filp)
-{
-	struct ib_uobject *uobj = filp->private_data;
-	struct ib_uverbs_completion_event_file *file = container_of(
-		uobj, struct ib_uverbs_completion_event_file, uobj);
-	struct ib_uverbs_event *entry, *tmp;
-
-	spin_lock_irq(&file->ev_queue.lock);
-	list_for_each_entry_safe(entry, tmp, &file->ev_queue.event_list, list) {
-		if (entry->counter)
-			list_del(&entry->obj_list);
-		kfree(entry);
-	}
-	file->ev_queue.is_closed = 1;
-	spin_unlock_irq(&file->ev_queue.lock);
-
-	uverbs_close_fd(filp);
-
-	return 0;
-}
-
 const struct file_operations uverbs_event_fops = {
 	.owner	 = THIS_MODULE,
 	.read	 = ib_uverbs_comp_event_read,
 	.poll    = ib_uverbs_comp_event_poll,
-	.release = ib_uverbs_comp_event_close,
+	.release = uverbs_uobject_fd_release,
 	.fasync  = ib_uverbs_comp_event_fasync,
 	.llseek	 = no_llseek,
 };
diff --git a/drivers/infiniband/core/uverbs_std_types.c b/drivers/infiniband/core/uverbs_std_types.c
index 35b2e2c..def038a 100644
--- a/drivers/infiniband/core/uverbs_std_types.c
+++ b/drivers/infiniband/core/uverbs_std_types.c
@@ -202,22 +202,29 @@ static int uverbs_free_pd(struct ib_uobject *uobject,
 	return 0;
 }
 
-static int uverbs_hot_unplug_completion_event_file(struct ib_uobject *uobj,
-						   enum rdma_remove_reason why)
+static int
+uverbs_completion_event_file_destroy_uobj(struct ib_uobject *uobj,
+					  enum rdma_remove_reason why)
 {
-	struct ib_uverbs_completion_event_file *comp_event_file =
+	struct ib_uverbs_completion_event_file *file =
 		container_of(uobj, struct ib_uverbs_completion_event_file,
 			     uobj);
-	struct ib_uverbs_event_queue *event_queue = &comp_event_file->ev_queue;
+	struct ib_uverbs_event_queue *event_queue = &file->ev_queue;
+	struct ib_uverbs_event *entry, *tmp;
 
 	spin_lock_irq(&event_queue->lock);
 	event_queue->is_closed = 1;
 	spin_unlock_irq(&event_queue->lock);
+	wake_up_interruptible(&event_queue->poll_wait);
+	kill_fasync(&event_queue->async_queue, SIGIO, POLL_IN);
 
-	if (why == RDMA_REMOVE_DRIVER_REMOVE) {
-		wake_up_interruptible(&event_queue->poll_wait);
-		kill_fasync(&event_queue->async_queue, SIGIO, POLL_IN);
+	spin_lock_irq(&event_queue->lock);
+	list_for_each_entry_safe(entry, tmp, &event_queue->event_list, list) {
+		if (entry->counter)
+			list_del(&entry->obj_list);
+		kfree(entry);
 	}
+	spin_unlock_irq(&event_queue->lock);
 	return 0;
 };
 
@@ -230,7 +237,7 @@ int uverbs_destroy_def_handler(struct uverbs_attr_bundle *attrs)
 DECLARE_UVERBS_NAMED_OBJECT(
 	UVERBS_OBJECT_COMP_CHANNEL,
 	UVERBS_TYPE_ALLOC_FD(sizeof(struct ib_uverbs_completion_event_file),
-			     uverbs_hot_unplug_completion_event_file,
+			     uverbs_completion_event_file_destroy_uobj,
 			     &uverbs_event_fops,
 			     "[infinibandevent]",
 			     O_RDONLY));
diff --git a/drivers/infiniband/core/uverbs_uapi.c b/drivers/infiniband/core/uverbs_uapi.c
index 00c54788..9b84a12 100644
--- a/drivers/infiniband/core/uverbs_uapi.c
+++ b/drivers/infiniband/core/uverbs_uapi.c
@@ -195,9 +195,9 @@ static int uapi_merge_obj_tree(struct uverbs_api *uapi,
 		 * disassociation, and the FD types require the driver to use
 		 * struct file_operations.owner to prevent the driver module
 		 * code from unloading while the file is open. This provides
-		 * enough safety that uverbs_close_fd() will continue to work.
-		 * Drivers using FD are responsible to handle disassociation of
-		 * the device on their own.
+		 * enough safety that uverbs_uobject_fd_release() will
+		 * continue to work.  Drivers using FD are responsible to
+		 * handle disassociation of the device on their own.
 		 */
 		if (WARN_ON(is_driver &&
 			    obj->type_attrs->type_class != &uverbs_idr_class &&
diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
index 968fff0..02125d8 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -2328,6 +2328,9 @@ static int deliver_event(struct devx_event_subscription *event_sub,
 			return 0;
 		}
 
+		/* is_destroyed is ignored here because we don't have any memory
+		 * allocation to clean up for the omit_data case
+		 */
 		list_add_tail(&event_sub->event_list, &ev_file->event_list);
 		spin_unlock_irqrestore(&ev_file->lock, flags);
 		wake_up_interruptible(&ev_file->poll_wait);
@@ -2347,7 +2350,10 @@ static int deliver_event(struct devx_event_subscription *event_sub,
 	memcpy(event_data->hdr.out_data, data, sizeof(struct mlx5_eqe));
 
 	spin_lock_irqsave(&ev_file->lock, flags);
-	list_add_tail(&event_data->list, &ev_file->event_list);
+	if (!ev_file->is_destroyed)
+		list_add_tail(&event_data->list, &ev_file->event_list);
+	else
+		kfree(event_data);
 	spin_unlock_irqrestore(&ev_file->lock, flags);
 	wake_up_interruptible(&ev_file->poll_wait);
 
@@ -2501,23 +2507,6 @@ static ssize_t devx_async_cmd_event_read(struct file *filp, char __user *buf,
 	return ret;
 }
 
-static int devx_async_cmd_event_close(struct inode *inode, struct file *filp)
-{
-	struct ib_uobject *uobj = filp->private_data;
-	struct devx_async_cmd_event_file *comp_ev_file = container_of(
-		uobj, struct devx_async_cmd_event_file, uobj);
-	struct devx_async_data *entry, *tmp;
-
-	spin_lock_irq(&comp_ev_file->ev_queue.lock);
-	list_for_each_entry_safe(entry, tmp,
-				 &comp_ev_file->ev_queue.event_list, list)
-		kvfree(entry);
-	spin_unlock_irq(&comp_ev_file->ev_queue.lock);
-
-	uverbs_close_fd(filp);
-	return 0;
-}
-
 static __poll_t devx_async_cmd_event_poll(struct file *filp,
 					      struct poll_table_struct *wait)
 {
@@ -2541,7 +2530,7 @@ static __poll_t devx_async_cmd_event_poll(struct file *filp,
 	.owner	 = THIS_MODULE,
 	.read	 = devx_async_cmd_event_read,
 	.poll    = devx_async_cmd_event_poll,
-	.release = devx_async_cmd_event_close,
+	.release = uverbs_uobject_fd_release,
 	.llseek	 = no_llseek,
 };
 
@@ -2656,78 +2645,74 @@ static void devx_free_subscription(struct rcu_head *rcu)
 	kfree(event_sub);
 }
 
-static int devx_async_event_close(struct inode *inode, struct file *filp)
-{
-	struct devx_async_event_file *ev_file = filp->private_data;
-	struct devx_event_subscription *event_sub, *event_sub_tmp;
-	struct devx_async_event_data *entry, *tmp;
-	struct mlx5_ib_dev *dev = ev_file->dev;
-
-	mutex_lock(&dev->devx_event_table.event_xa_lock);
-	/* delete the subscriptions which are related to this FD */
-	list_for_each_entry_safe(event_sub, event_sub_tmp,
-				 &ev_file->subscribed_events_list, file_list) {
-		devx_cleanup_subscription(dev, event_sub);
-		list_del_rcu(&event_sub->file_list);
-		/* subscription may not be used by the read API any more */
-		call_rcu(&event_sub->rcu, devx_free_subscription);
-	}
-
-	mutex_unlock(&dev->devx_event_table.event_xa_lock);
-
-	/* free the pending events allocation */
-	if (!ev_file->omit_data) {
-		spin_lock_irq(&ev_file->lock);
-		list_for_each_entry_safe(entry, tmp,
-					 &ev_file->event_list, list)
-			kfree(entry); /* read can't come any more */
-		spin_unlock_irq(&ev_file->lock);
-	}
-
-	uverbs_close_fd(filp);
-	put_device(&dev->ib_dev.dev);
-	return 0;
-}
-
 static const struct file_operations devx_async_event_fops = {
 	.owner	 = THIS_MODULE,
 	.read	 = devx_async_event_read,
 	.poll    = devx_async_event_poll,
-	.release = devx_async_event_close,
+	.release = uverbs_uobject_fd_release,
 	.llseek	 = no_llseek,
 };
 
-static int devx_hot_unplug_async_cmd_event_file(struct ib_uobject *uobj,
-						   enum rdma_remove_reason why)
+static int devx_async_cmd_event_destroy_uobj(struct ib_uobject *uobj,
+					     enum rdma_remove_reason why)
 {
 	struct devx_async_cmd_event_file *comp_ev_file =
 		container_of(uobj, struct devx_async_cmd_event_file,
 			     uobj);
 	struct devx_async_event_queue *ev_queue = &comp_ev_file->ev_queue;
+	struct devx_async_data *entry, *tmp;
 
 	spin_lock_irq(&ev_queue->lock);
 	ev_queue->is_destroyed = 1;
 	spin_unlock_irq(&ev_queue->lock);
-
-	if (why == RDMA_REMOVE_DRIVER_REMOVE)
-		wake_up_interruptible(&ev_queue->poll_wait);
+	wake_up_interruptible(&ev_queue->poll_wait);
 
 	mlx5_cmd_cleanup_async_ctx(&comp_ev_file->async_ctx);
+
+	spin_lock_irq(&comp_ev_file->ev_queue.lock);
+	list_for_each_entry_safe(entry, tmp,
+				 &comp_ev_file->ev_queue.event_list, list)
+		kvfree(entry);
+	spin_unlock_irq(&comp_ev_file->ev_queue.lock);
 	return 0;
 };
 
-static int devx_hot_unplug_async_event_file(struct ib_uobject *uobj,
-					    enum rdma_remove_reason why)
+static int devx_async_event_destroy_uobj(struct ib_uobject *uobj,
+					 enum rdma_remove_reason why)
 {
 	struct devx_async_event_file *ev_file =
 		container_of(uobj, struct devx_async_event_file,
 			     uobj);
+	struct devx_event_subscription *event_sub, *event_sub_tmp;
+	struct devx_async_event_data *entry, *tmp;
+	struct mlx5_ib_dev *dev = ev_file->dev;
 
 	spin_lock_irq(&ev_file->lock);
 	ev_file->is_destroyed = 1;
 	spin_unlock_irq(&ev_file->lock);
-
 	wake_up_interruptible(&ev_file->poll_wait);
+
+	mutex_lock(&dev->devx_event_table.event_xa_lock);
+	/* delete the subscriptions which are related to this FD */
+	list_for_each_entry_safe(event_sub, event_sub_tmp,
+				 &ev_file->subscribed_events_list, file_list) {
+		devx_cleanup_subscription(dev, event_sub);
+		list_del_rcu(&event_sub->file_list);
+		/* subscription may not be used by the read API any more */
+		call_rcu(&event_sub->rcu, devx_free_subscription);
+	}
+	mutex_unlock(&dev->devx_event_table.event_xa_lock);
+
+	/* free the pending events allocation */
+	if (!ev_file->omit_data) {
+		spin_lock_irq(&ev_file->lock);
+		list_for_each_entry_safe(entry, tmp,
+					 &ev_file->event_list, list)
+			kfree(entry); /* read can't come any more */
+		spin_unlock_irq(&ev_file->lock);
+	}
+
+	put_device(&dev->ib_dev.dev);
 	return 0;
 };
 
@@ -2913,7 +2898,7 @@ static int devx_hot_unplug_async_event_file(struct ib_uobject *uobj,
 DECLARE_UVERBS_NAMED_OBJECT(
 	MLX5_IB_OBJECT_DEVX_ASYNC_CMD_FD,
 	UVERBS_TYPE_ALLOC_FD(sizeof(struct devx_async_cmd_event_file),
-			     devx_hot_unplug_async_cmd_event_file,
+			     devx_async_cmd_event_destroy_uobj,
 			     &devx_async_cmd_event_fops, "[devx_async_cmd]",
 			     O_RDONLY),
 	&UVERBS_METHOD(MLX5_IB_METHOD_DEVX_ASYNC_CMD_FD_ALLOC));
@@ -2931,7 +2916,7 @@ static int devx_hot_unplug_async_event_file(struct ib_uobject *uobj,
 DECLARE_UVERBS_NAMED_OBJECT(
 	MLX5_IB_OBJECT_DEVX_ASYNC_EVENT_FD,
 	UVERBS_TYPE_ALLOC_FD(sizeof(struct devx_async_event_file),
-			     devx_hot_unplug_async_event_file,
+			     devx_async_event_destroy_uobj,
 			     &devx_async_event_fops, "[devx_async_event]",
 			     O_RDONLY),
 	&UVERBS_METHOD(MLX5_IB_METHOD_DEVX_ASYNC_EVENT_FD_ALLOC));
diff --git a/include/rdma/uverbs_types.h b/include/rdma/uverbs_types.h
index 388ffee..657c313 100644
--- a/include/rdma/uverbs_types.h
+++ b/include/rdma/uverbs_types.h
@@ -162,11 +162,11 @@ struct uverbs_obj_fd_type {
 	 * In fd based objects, uverbs_obj_type_ops points to generic
 	 * fd operations. In order to specialize the underlying types (e.g.
 	 * completion_channel), we use fops, name and flags for fd creation.
-	 * context_closed is called when the context is closed either when
-	 * the driver is removed or the process terminated.
+	 * destroy_object is called when the uobject is to be destroyed,
+	 * because the driver is removed or the FD is closed.
 	 */
 	struct uverbs_obj_type  type;
-	int (*context_closed)(struct ib_uobject *uobj,
+	int (*destroy_object)(struct ib_uobject *uobj,
 			      enum rdma_remove_reason why);
 	const struct file_operations	*fops;
 	const char			*name;
@@ -175,11 +175,11 @@ struct uverbs_obj_fd_type {
 
 extern const struct uverbs_obj_type_class uverbs_idr_class;
 extern const struct uverbs_obj_type_class uverbs_fd_class;
-void uverbs_close_fd(struct file *f);
+int uverbs_uobject_fd_release(struct inode *inode, struct file *filp);
 
 #define UVERBS_BUILD_BUG_ON(cond) (sizeof(char[1 - 2 * !!(cond)]) -	\
 				   sizeof(char))
-#define UVERBS_TYPE_ALLOC_FD(_obj_size, _context_closed, _fops, _name, _flags)\
+#define UVERBS_TYPE_ALLOC_FD(_obj_size, _destroy_object, _fops, _name, _flags) \
 	((&((const struct uverbs_obj_fd_type)				\
 	 {.type = {							\
 		.type_class = &uverbs_fd_class,				\
@@ -187,7 +187,7 @@ struct uverbs_obj_fd_type {
 			UVERBS_BUILD_BUG_ON((_obj_size) <               \
 					    sizeof(struct ib_uobject)), \
 	 },								\
-	 .context_closed = _context_closed,				\
+	 .destroy_object = _destroy_object,				\
 	 .fops = _fops,							\
 	 .name = _name,							\
 	 .flags = _flags}))->type)
-- 
1.8.3.1

