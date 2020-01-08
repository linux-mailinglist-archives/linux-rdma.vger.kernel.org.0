Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF52E13493F
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jan 2020 18:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729771AbgAHRWl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Jan 2020 12:22:41 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:41793 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729755AbgAHRWl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Jan 2020 12:22:41 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from yishaih@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 8 Jan 2020 19:22:31 +0200
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [10.7.2.17])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 008HMV7D009590;
        Wed, 8 Jan 2020 19:22:31 +0200
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [127.0.0.1])
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8) with ESMTP id 008HMVE8009527;
        Wed, 8 Jan 2020 19:22:31 +0200
Received: (from yishaih@localhost)
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8/Submit) id 008HMVet009520;
        Wed, 8 Jan 2020 19:22:31 +0200
From:   Yishai Hadas <yishaih@mellanox.com>
To:     linux-rdma@vger.kernel.org, jgg@mellanox.com, dledford@redhat.com
Cc:     yishaih@mellanox.com, maorg@mellanox.com, michaelgur@mellanox.com
Subject: [PATCH rdma-next 01/14] RDMA/mlx5: Use RCU and direct refcounts to keep memory alive
Date:   Wed,  8 Jan 2020 19:21:53 +0200
Message-Id: <1578504126-9400-2-git-send-email-yishaih@mellanox.com>
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1578504126-9400-1-git-send-email-yishaih@mellanox.com>
References: <1578504126-9400-1-git-send-email-yishaih@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

dispatch_event_fd() runs from a notifier with minimal locking, and relies
on RCU and a file refcount to keep the uobject and eventfd alive.

As the next patch wants to remove the file_operations release function
from the drivers, re-organize things so that the devx_event_notifier()
path uses the existing RCU to manage the lifetime of the uobject and
eventfd.

Move the refcount puts to a call_rcu so that the objects are guaranteed to
exist and remove the indirect file refcount.

Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/infiniband/core/rdma_core.c | 11 ++++++-----
 drivers/infiniband/core/rdma_core.h | 15 ---------------
 drivers/infiniband/hw/mlx5/devx.c   | 34 +++++++++++++++++-----------------
 include/rdma/uverbs_types.h         | 12 ++++++++++++
 4 files changed, 35 insertions(+), 37 deletions(-)

diff --git a/drivers/infiniband/core/rdma_core.c b/drivers/infiniband/core/rdma_core.c
index 6c72773..a5c29e3 100644
--- a/drivers/infiniband/core/rdma_core.c
+++ b/drivers/infiniband/core/rdma_core.c
@@ -42,11 +42,6 @@
 #include "core_priv.h"
 #include "rdma_core.h"
 
-void uverbs_uobject_get(struct ib_uobject *uobject)
-{
-	kref_get(&uobject->ref);
-}
-
 static void uverbs_uobject_free(struct kref *ref)
 {
 	struct ib_uobject *uobj =
@@ -58,10 +53,16 @@ static void uverbs_uobject_free(struct kref *ref)
 		kfree(uobj);
 }
 
+/*
+ * In order to indicate we no longer needs this uobject, uverbs_uobject_put
+ * is called. When the reference count is decreased, the uobject is freed.
+ * For example, this is used when attaching a completion channel to a CQ.
+ */
 void uverbs_uobject_put(struct ib_uobject *uobject)
 {
 	kref_put(&uobject->ref, uverbs_uobject_free);
 }
+EXPORT_SYMBOL(uverbs_uobject_put);
 
 static int uverbs_try_lock_object(struct ib_uobject *uobj,
 				  enum rdma_lookup_mode mode)
diff --git a/drivers/infiniband/core/rdma_core.h b/drivers/infiniband/core/rdma_core.h
index e63fbda..d5d58a1 100644
--- a/drivers/infiniband/core/rdma_core.h
+++ b/drivers/infiniband/core/rdma_core.h
@@ -50,21 +50,6 @@ void uverbs_destroy_ufile_hw(struct ib_uverbs_file *ufile,
 
 int uobj_destroy(struct ib_uobject *uobj, struct uverbs_attr_bundle *attrs);
 
-/*
- * uverbs_uobject_get is called in order to increase the reference count on
- * an uobject. This is useful when a handler wants to keep the uobject's memory
- * alive, regardless if this uobject is still alive in the context's objects
- * repository. Objects are put via uverbs_uobject_put.
- */
-void uverbs_uobject_get(struct ib_uobject *uobject);
-
-/*
- * In order to indicate we no longer needs this uobject, uverbs_uobject_put
- * is called. When the reference count is decreased, the uobject is freed.
- * For example, this is used when attaching a completion channel to a CQ.
- */
-void uverbs_uobject_put(struct ib_uobject *uobject);
-
 /* Indicate this fd is no longer used by this consumer, but its memory isn't
  * necessarily released yet. When the last reference is put, we release the
  * memory. After this call is executed, calling uverbs_uobject_get isn't
diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
index 9d0a18c..968fff0 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -72,7 +72,6 @@ struct devx_event_subscription {
 	struct rcu_head	rcu;
 	u64 cookie;
 	struct devx_async_event_file *ev_file;
-	struct file *filp; /* Upon hot unplug we need a direct access to */
 	struct eventfd_ctx *eventfd;
 };
 
@@ -2032,6 +2031,7 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_DEVX_SUBSCRIBE_EVENT)(
 			goto err;
 
 		list_add_tail(&event_sub->event_list, &sub_list);
+		uverbs_uobject_get(&ev_file->uobj);
 		if (use_eventfd) {
 			event_sub->eventfd =
 				eventfd_ctx_fdget(redirect_fd);
@@ -2045,7 +2045,6 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_DEVX_SUBSCRIBE_EVENT)(
 
 		event_sub->cookie = cookie;
 		event_sub->ev_file = ev_file;
-		event_sub->filp = fd_uobj->object;
 		/* May be needed upon cleanup the devx object/subscription */
 		event_sub->xa_key_level1 = key_level1;
 		event_sub->xa_key_level2 = obj_id;
@@ -2099,7 +2098,7 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_DEVX_SUBSCRIBE_EVENT)(
 
 		if (event_sub->eventfd)
 			eventfd_ctx_put(event_sub->eventfd);
-
+		uverbs_uobject_put(&event_sub->ev_file->uobj);
 		kfree(event_sub);
 	}
 
@@ -2361,17 +2360,10 @@ static void dispatch_event_fd(struct list_head *fd_list,
 	struct devx_event_subscription *item;
 
 	list_for_each_entry_rcu(item, fd_list, xa_list) {
-		if (!get_file_rcu(item->filp))
-			continue;
-
-		if (item->eventfd) {
+		if (item->eventfd)
 			eventfd_signal(item->eventfd, 1);
-			fput(item->filp);
-			continue;
-		}
-
-		deliver_event(item, data);
-		fput(item->filp);
+		else
+			deliver_event(item, data);
 	}
 }
 
@@ -2653,6 +2645,17 @@ static __poll_t devx_async_event_poll(struct file *filp,
 	return pollflags;
 }
 
+static void devx_free_subscription(struct rcu_head *rcu)
+{
+	struct devx_event_subscription *event_sub =
+		container_of(rcu, struct devx_event_subscription, rcu);
+
+	if (event_sub->eventfd)
+		eventfd_ctx_put(event_sub->eventfd);
+	uverbs_uobject_put(&event_sub->ev_file->uobj);
+	kfree(event_sub);
+}
+
 static int devx_async_event_close(struct inode *inode, struct file *filp)
 {
 	struct devx_async_event_file *ev_file = filp->private_data;
@@ -2665,12 +2668,9 @@ static int devx_async_event_close(struct inode *inode, struct file *filp)
 	list_for_each_entry_safe(event_sub, event_sub_tmp,
 				 &ev_file->subscribed_events_list, file_list) {
 		devx_cleanup_subscription(dev, event_sub);
-		if (event_sub->eventfd)
-			eventfd_ctx_put(event_sub->eventfd);
-
 		list_del_rcu(&event_sub->file_list);
 		/* subscription may not be used by the read API any more */
-		kfree_rcu(event_sub, rcu);
+		call_rcu(&event_sub->rcu, devx_free_subscription);
 	}
 
 	mutex_unlock(&dev->devx_event_table.event_xa_lock);
diff --git a/include/rdma/uverbs_types.h b/include/rdma/uverbs_types.h
index d57a5ba..388ffee 100644
--- a/include/rdma/uverbs_types.h
+++ b/include/rdma/uverbs_types.h
@@ -145,6 +145,18 @@ void rdma_alloc_abort_uobject(struct ib_uobject *uobj,
 int __must_check rdma_alloc_commit_uobject(struct ib_uobject *uobj,
 					   struct uverbs_attr_bundle *attrs);
 
+/*
+ * uverbs_uobject_get is called in order to increase the reference count on
+ * an uobject. This is useful when a handler wants to keep the uobject's memory
+ * alive, regardless if this uobject is still alive in the context's objects
+ * repository. Objects are put via uverbs_uobject_put.
+ */
+static inline void uverbs_uobject_get(struct ib_uobject *uobject)
+{
+	kref_get(&uobject->ref);
+}
+void uverbs_uobject_put(struct ib_uobject *uobject);
+
 struct uverbs_obj_fd_type {
 	/*
 	 * In fd based objects, uverbs_obj_type_ops points to generic
-- 
1.8.3.1

