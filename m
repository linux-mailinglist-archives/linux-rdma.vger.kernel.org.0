Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A57013493B
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jan 2020 18:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729753AbgAHRWj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Jan 2020 12:22:39 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:41821 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729770AbgAHRWi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Jan 2020 12:22:38 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from yishaih@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 8 Jan 2020 19:22:32 +0200
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [10.7.2.17])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 008HMWt8009637;
        Wed, 8 Jan 2020 19:22:32 +0200
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [127.0.0.1])
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8) with ESMTP id 008HMWHu009579;
        Wed, 8 Jan 2020 19:22:32 +0200
Received: (from yishaih@localhost)
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8/Submit) id 008HMWLF009578;
        Wed, 8 Jan 2020 19:22:32 +0200
From:   Yishai Hadas <yishaih@mellanox.com>
To:     linux-rdma@vger.kernel.org, jgg@mellanox.com, dledford@redhat.com
Cc:     yishaih@mellanox.com, maorg@mellanox.com, michaelgur@mellanox.com
Subject: [PATCH rdma-next 13/14] RDMA/core: Make ib_uverbs_async_event_file into a uobject
Date:   Wed,  8 Jan 2020 19:22:05 +0200
Message-Id: <1578504126-9400-14-git-send-email-yishaih@mellanox.com>
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1578504126-9400-1-git-send-email-yishaih@mellanox.com>
References: <1578504126-9400-1-git-send-email-yishaih@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

This makes async events aligned with completion events as both are full
uobjects of FD type and use the same uobject lifecycle.

A bunch of duplicate code is consolidated and the general flow between the
two FDs is now very similar.

Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/infiniband/core/Makefile                   |   3 +-
 drivers/infiniband/core/rdma_core.h                |   1 +
 drivers/infiniband/core/uverbs.h                   |  15 +--
 drivers/infiniband/core/uverbs_cmd.c               |  30 ++---
 drivers/infiniband/core/uverbs_main.c              | 130 ++++-----------------
 drivers/infiniband/core/uverbs_std_types.c         |  25 ++--
 .../infiniband/core/uverbs_std_types_async_fd.c    |  33 ++++++
 drivers/infiniband/core/uverbs_uapi.c              |   1 +
 include/uapi/rdma/ib_user_ioctl_cmds.h             |   1 +
 9 files changed, 96 insertions(+), 143 deletions(-)
 create mode 100644 drivers/infiniband/core/uverbs_std_types_async_fd.c

diff --git a/drivers/infiniband/core/Makefile b/drivers/infiniband/core/Makefile
index 9a8871e..e109c82 100644
--- a/drivers/infiniband/core/Makefile
+++ b/drivers/infiniband/core/Makefile
@@ -33,6 +33,7 @@ ib_uverbs-y :=			uverbs_main.o uverbs_cmd.o uverbs_marshall.o \
 				uverbs_std_types_cq.o \
 				uverbs_std_types_flow_action.o uverbs_std_types_dm.o \
 				uverbs_std_types_mr.o uverbs_std_types_counters.o \
-				uverbs_uapi.o uverbs_std_types_device.o
+				uverbs_uapi.o uverbs_std_types_device.o \
+				uverbs_std_types_async_fd.o
 ib_uverbs-$(CONFIG_INFINIBAND_USER_MEM) += umem.o
 ib_uverbs-$(CONFIG_INFINIBAND_ON_DEMAND_PAGING) += umem_odp.o
diff --git a/drivers/infiniband/core/rdma_core.h b/drivers/infiniband/core/rdma_core.h
index 29f905e..33978e0 100644
--- a/drivers/infiniband/core/rdma_core.h
+++ b/drivers/infiniband/core/rdma_core.h
@@ -151,6 +151,7 @@ void uapi_compute_bundle_size(struct uverbs_api_ioctl_method *method_elm,
 			      unsigned int num_attrs);
 void uverbs_user_mmap_disassociate(struct ib_uverbs_file *ufile);
 
+extern const struct uapi_definition uverbs_def_obj_async_fd[];
 extern const struct uapi_definition uverbs_def_obj_counters[];
 extern const struct uapi_definition uverbs_def_obj_cq[];
 extern const struct uapi_definition uverbs_def_obj_device[];
diff --git a/drivers/infiniband/core/uverbs.h b/drivers/infiniband/core/uverbs.h
index 8384b66..ccde5d2 100644
--- a/drivers/infiniband/core/uverbs.h
+++ b/drivers/infiniband/core/uverbs.h
@@ -111,7 +111,6 @@ struct ib_uverbs_device {
 	struct srcu_struct			disassociate_srcu;
 	struct mutex				lists_mutex; /* protect lists */
 	struct list_head			uverbs_file_list;
-	struct list_head			uverbs_events_file_list;
 	struct uverbs_api			*uapi;
 };
 
@@ -124,10 +123,9 @@ struct ib_uverbs_event_queue {
 };
 
 struct ib_uverbs_async_event_file {
+	struct ib_uobject			uobj;
 	struct ib_uverbs_event_queue		ev_queue;
-	struct ib_uverbs_file		       *uverbs_file;
-	struct kref				ref;
-	struct list_head			list;
+	struct ib_event_handler			event_handler;
 };
 
 struct ib_uverbs_completion_event_file {
@@ -144,8 +142,7 @@ struct ib_uverbs_file {
 	 * ucontext_lock held
 	 */
 	struct ib_ucontext		       *ucontext;
-	struct ib_event_handler			event_handler;
-	struct ib_uverbs_async_event_file       *async_file;
+	struct ib_uverbs_async_event_file      *async_file;
 	struct list_head			list;
 
 	/*
@@ -217,10 +214,10 @@ struct ib_ucq_object {
 };
 
 extern const struct file_operations uverbs_event_fops;
+extern const struct file_operations uverbs_async_event_fops;
 void ib_uverbs_init_event_queue(struct ib_uverbs_event_queue *ev_queue);
-struct file *ib_uverbs_alloc_async_event_file(struct ib_uverbs_file *uverbs_file,
-					      struct ib_device *ib_dev);
-void ib_uverbs_free_async_event_file(struct ib_uverbs_file *uverbs_file);
+void ib_uverbs_init_async_event_file(struct ib_uverbs_async_event_file *ev_file);
+void ib_uverbs_free_event_queue(struct ib_uverbs_event_queue *event_queue);
 void ib_uverbs_flow_resources_free(struct ib_uflow_resources *uflow_res);
 
 void ib_uverbs_release_ucq(struct ib_uverbs_file *file,
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 51117e7..ced1384 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -209,9 +209,9 @@ static int ib_uverbs_get_context(struct uverbs_attr_bundle *attrs)
 	struct ib_uverbs_get_context      cmd;
 	struct ib_uverbs_get_context_resp resp;
 	struct ib_ucontext		 *ucontext;
-	struct file			 *filp;
 	struct ib_rdmacg_object		 cg_obj;
 	struct ib_device *ib_dev;
+	struct ib_uobject *uobj;
 	int ret;
 
 	ret = uverbs_request(attrs, &cmd, sizeof(cmd));
@@ -254,30 +254,28 @@ static int ib_uverbs_get_context(struct uverbs_attr_bundle *attrs)
 
 	xa_init_flags(&ucontext->mmap_xa, XA_FLAGS_ALLOC);
 
-	ret = get_unused_fd_flags(O_CLOEXEC);
-	if (ret < 0)
+	uobj = uobj_alloc(UVERBS_OBJECT_ASYNC_EVENT, attrs, &ib_dev);
+	if (IS_ERR(uobj)) {
+		ret = PTR_ERR(uobj);
 		goto err_free;
-	resp.async_fd = ret;
-
-	filp = ib_uverbs_alloc_async_event_file(file, ib_dev);
-	if (IS_ERR(filp)) {
-		ret = PTR_ERR(filp);
-		goto err_fd;
 	}
 
+	resp.async_fd = uobj->id;
 	resp.num_comp_vectors = file->device->num_comp_vectors;
 
 	ret = uverbs_response(attrs, &resp, sizeof(resp));
 	if (ret)
-		goto err_file;
+		goto err_uobj;
 
 	ret = ib_dev->ops.alloc_ucontext(ucontext, &attrs->driver_udata);
 	if (ret)
-		goto err_file;
+		goto err_uobj;
 
 	rdma_restrack_uadd(&ucontext->res);
 
-	fd_install(resp.async_fd, filp);
+	ib_uverbs_init_async_event_file(
+		container_of(uobj, struct ib_uverbs_async_event_file, uobj));
+	rdma_alloc_commit_uobject(uobj, attrs);
 
 	/*
 	 * Make sure that ib_uverbs_get_ucontext() sees the pointer update
@@ -289,12 +287,8 @@ static int ib_uverbs_get_context(struct uverbs_attr_bundle *attrs)
 
 	return 0;
 
-err_file:
-	ib_uverbs_free_async_event_file(file);
-	fput(filp);
-
-err_fd:
-	put_unused_fd(resp.async_fd);
+err_uobj:
+	rdma_alloc_abort_uobject(uobj, attrs);
 
 err_free:
 	kfree(ucontext);
diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
index 97770e7..121e65f 100644
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -125,14 +125,6 @@ static void ib_uverbs_release_dev(struct device *device)
 	kfree(dev);
 }
 
-static void ib_uverbs_release_async_event_file(struct kref *ref)
-{
-	struct ib_uverbs_async_event_file *file =
-		container_of(ref, struct ib_uverbs_async_event_file, ref);
-
-	kfree(file);
-}
-
 void ib_uverbs_release_ucq(struct ib_uverbs_file *file,
 			  struct ib_uverbs_completion_event_file *ev_file,
 			  struct ib_ucq_object *uobj)
@@ -203,8 +195,7 @@ void ib_uverbs_release_file(struct kref *ref)
 		ib_uverbs_comp_dev(file->device);
 
 	if (file->async_file)
-		kref_put(&file->async_file->ref,
-			 ib_uverbs_release_async_event_file);
+		uverbs_uobject_put(&file->async_file->uobj);
 	put_device(&file->device->dev);
 
 	if (file->disassociate_page)
@@ -339,35 +330,6 @@ static int ib_uverbs_comp_event_fasync(int fd, struct file *filp, int on)
 	return fasync_helper(fd, filp, on, &comp_ev_file->ev_queue.async_queue);
 }
 
-static int ib_uverbs_async_event_close(struct inode *inode, struct file *filp)
-{
-	struct ib_uverbs_async_event_file *file = filp->private_data;
-	struct ib_uverbs_file *uverbs_file = file->uverbs_file;
-	struct ib_uverbs_event *entry, *tmp;
-	int closed_already = 0;
-
-	mutex_lock(&uverbs_file->device->lists_mutex);
-	spin_lock_irq(&file->ev_queue.lock);
-	closed_already = file->ev_queue.is_closed;
-	file->ev_queue.is_closed = 1;
-	list_for_each_entry_safe(entry, tmp, &file->ev_queue.event_list, list) {
-		if (entry->counter)
-			list_del(&entry->obj_list);
-		kfree(entry);
-	}
-	spin_unlock_irq(&file->ev_queue.lock);
-	if (!closed_already) {
-		list_del(&file->list);
-		ib_unregister_event_handler(&uverbs_file->event_handler);
-	}
-	mutex_unlock(&uverbs_file->device->lists_mutex);
-
-	kref_put(&uverbs_file->ref, ib_uverbs_release_file);
-	kref_put(&file->ref, ib_uverbs_release_async_event_file);
-
-	return 0;
-}
-
 const struct file_operations uverbs_event_fops = {
 	.owner	 = THIS_MODULE,
 	.read	 = ib_uverbs_comp_event_read,
@@ -377,11 +339,11 @@ static int ib_uverbs_async_event_close(struct inode *inode, struct file *filp)
 	.llseek	 = no_llseek,
 };
 
-static const struct file_operations uverbs_async_event_fops = {
+const struct file_operations uverbs_async_event_fops = {
 	.owner	 = THIS_MODULE,
 	.read	 = ib_uverbs_async_event_read,
 	.poll    = ib_uverbs_async_event_poll,
-	.release = ib_uverbs_async_event_close,
+	.release = uverbs_uobject_fd_release,
 	.fasync  = ib_uverbs_async_event_fasync,
 	.llseek	 = no_llseek,
 };
@@ -491,17 +453,11 @@ static void ib_uverbs_event_handler(struct ib_event_handler *handler,
 				    struct ib_event *event)
 {
 	ib_uverbs_async_handler(
-		container_of(handler, struct ib_uverbs_file, event_handler)
-			->async_file,
+		container_of(handler, struct ib_uverbs_async_event_file,
+			     event_handler),
 		event->element.port_num, event->event, NULL, NULL);
 }
 
-void ib_uverbs_free_async_event_file(struct ib_uverbs_file *file)
-{
-	kref_put(&file->async_file->ref, ib_uverbs_release_async_event_file);
-	file->async_file = NULL;
-}
-
 void ib_uverbs_init_event_queue(struct ib_uverbs_event_queue *ev_queue)
 {
 	spin_lock_init(&ev_queue->lock);
@@ -511,45 +467,23 @@ void ib_uverbs_init_event_queue(struct ib_uverbs_event_queue *ev_queue)
 	ev_queue->async_queue = NULL;
 }
 
-struct file *ib_uverbs_alloc_async_event_file(struct ib_uverbs_file *uverbs_file,
-					      struct ib_device	*ib_dev)
+void ib_uverbs_init_async_event_file(
+	struct ib_uverbs_async_event_file *async_file)
 {
-	struct ib_uverbs_async_event_file *ev_file;
-	struct file *filp;
-
-	ev_file = kzalloc(sizeof(*ev_file), GFP_KERNEL);
-	if (!ev_file)
-		return ERR_PTR(-ENOMEM);
-
-	ib_uverbs_init_event_queue(&ev_file->ev_queue);
-	ev_file->uverbs_file = uverbs_file;
-	kref_get(&ev_file->uverbs_file->ref);
-	kref_init(&ev_file->ref);
-	filp = anon_inode_getfile("[infinibandevent]", &uverbs_async_event_fops,
-				  ev_file, O_RDONLY);
-	if (IS_ERR(filp))
-		goto err_put_refs;
-
-	mutex_lock(&uverbs_file->device->lists_mutex);
-	list_add_tail(&ev_file->list,
-		      &uverbs_file->device->uverbs_events_file_list);
-	mutex_unlock(&uverbs_file->device->lists_mutex);
-
-	WARN_ON(uverbs_file->async_file);
-	uverbs_file->async_file = ev_file;
-	kref_get(&uverbs_file->async_file->ref);
-	INIT_IB_EVENT_HANDLER(&uverbs_file->event_handler,
-			      ib_dev,
-			      ib_uverbs_event_handler);
-	ib_register_event_handler(&uverbs_file->event_handler);
-	/* At that point async file stuff was fully set */
+	struct ib_uverbs_file *uverbs_file = async_file->uobj.ufile;
+	struct ib_device *ib_dev = async_file->uobj.context->device;
 
-	return filp;
+	ib_uverbs_init_event_queue(&async_file->ev_queue);
 
-err_put_refs:
-	kref_put(&ev_file->uverbs_file->ref, ib_uverbs_release_file);
-	kref_put(&ev_file->ref, ib_uverbs_release_async_event_file);
-	return filp;
+	if (!WARN_ON(uverbs_file->async_file)) {
+		uverbs_file->async_file = async_file;
+		/* Pairs with the put in ib_uverbs_release_file */
+		uverbs_uobject_get(&async_file->uobj);
+	}
+
+	INIT_IB_EVENT_HANDLER(&async_file->event_handler, ib_dev,
+			      ib_uverbs_event_handler);
+	ib_register_event_handler(&async_file->event_handler);
 }
 
 static ssize_t verify_hdr(struct ib_uverbs_cmd_hdr *hdr,
@@ -1178,7 +1112,6 @@ static void ib_uverbs_add_one(struct ib_device *device)
 	mutex_init(&uverbs_dev->xrcd_tree_mutex);
 	mutex_init(&uverbs_dev->lists_mutex);
 	INIT_LIST_HEAD(&uverbs_dev->uverbs_file_list);
-	INIT_LIST_HEAD(&uverbs_dev->uverbs_events_file_list);
 	rcu_assign_pointer(uverbs_dev->ib_dev, device);
 	uverbs_dev->num_comp_vectors = device->num_comp_vectors;
 
@@ -1223,7 +1156,6 @@ static void ib_uverbs_free_hw_resources(struct ib_uverbs_device *uverbs_dev,
 					struct ib_device *ib_dev)
 {
 	struct ib_uverbs_file *file;
-	struct ib_uverbs_async_event_file *event_file;
 	struct ib_event event;
 
 	/* Pending running commands to terminate */
@@ -1246,31 +1178,15 @@ static void ib_uverbs_free_hw_resources(struct ib_uverbs_device *uverbs_dev,
 		 */
 		mutex_unlock(&uverbs_dev->lists_mutex);
 
-		ib_uverbs_event_handler(&file->event_handler, &event);
+		if (file->async_file)
+			ib_uverbs_event_handler(
+				&file->async_file->event_handler, &event);
+
 		uverbs_destroy_ufile_hw(file, RDMA_REMOVE_DRIVER_REMOVE);
 		kref_put(&file->ref, ib_uverbs_release_file);
 
 		mutex_lock(&uverbs_dev->lists_mutex);
 	}
-
-	while (!list_empty(&uverbs_dev->uverbs_events_file_list)) {
-		event_file = list_first_entry(&uverbs_dev->
-					      uverbs_events_file_list,
-					      struct ib_uverbs_async_event_file,
-					      list);
-		spin_lock_irq(&event_file->ev_queue.lock);
-		event_file->ev_queue.is_closed = 1;
-		spin_unlock_irq(&event_file->ev_queue.lock);
-
-		list_del(&event_file->list);
-		ib_unregister_event_handler(
-			&event_file->uverbs_file->event_handler);
-		event_file->uverbs_file->event_handler.device =
-			NULL;
-
-		wake_up_interruptible(&event_file->ev_queue.poll_wait);
-		kill_fasync(&event_file->ev_queue.async_queue, SIGIO, POLL_IN);
-	}
 	mutex_unlock(&uverbs_dev->lists_mutex);
 
 	uverbs_disassociate_api(uverbs_dev->uapi);
diff --git a/drivers/infiniband/core/uverbs_std_types.c b/drivers/infiniband/core/uverbs_std_types.c
index def038a..efe70bc 100644
--- a/drivers/infiniband/core/uverbs_std_types.c
+++ b/drivers/infiniband/core/uverbs_std_types.c
@@ -202,17 +202,15 @@ static int uverbs_free_pd(struct ib_uobject *uobject,
 	return 0;
 }
 
-static int
-uverbs_completion_event_file_destroy_uobj(struct ib_uobject *uobj,
-					  enum rdma_remove_reason why)
+void ib_uverbs_free_event_queue(struct ib_uverbs_event_queue *event_queue)
 {
-	struct ib_uverbs_completion_event_file *file =
-		container_of(uobj, struct ib_uverbs_completion_event_file,
-			     uobj);
-	struct ib_uverbs_event_queue *event_queue = &file->ev_queue;
 	struct ib_uverbs_event *entry, *tmp;
 
 	spin_lock_irq(&event_queue->lock);
+	/*
+	 * The user must ensure that no new items are added to the event_list
+	 * once is_closed is set.
+	 */
 	event_queue->is_closed = 1;
 	spin_unlock_irq(&event_queue->lock);
 	wake_up_interruptible(&event_queue->poll_wait);
@@ -225,8 +223,19 @@ static int uverbs_free_pd(struct ib_uobject *uobject,
 		kfree(entry);
 	}
 	spin_unlock_irq(&event_queue->lock);
+}
+
+static int
+uverbs_completion_event_file_destroy_uobj(struct ib_uobject *uobj,
+					  enum rdma_remove_reason why)
+{
+	struct ib_uverbs_completion_event_file *file =
+		container_of(uobj, struct ib_uverbs_completion_event_file,
+			     uobj);
+
+	ib_uverbs_free_event_queue(&file->ev_queue);
 	return 0;
-};
+}
 
 int uverbs_destroy_def_handler(struct uverbs_attr_bundle *attrs)
 {
diff --git a/drivers/infiniband/core/uverbs_std_types_async_fd.c b/drivers/infiniband/core/uverbs_std_types_async_fd.c
new file mode 100644
index 0000000..31ff968
--- /dev/null
+++ b/drivers/infiniband/core/uverbs_std_types_async_fd.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/*
+ * Copyright (c) 2019, Mellanox Technologies inc.  All rights reserved.
+ */
+
+#include <rdma/uverbs_std_types.h>
+#include <rdma/uverbs_ioctl.h>
+#include "rdma_core.h"
+#include "uverbs.h"
+
+static int uverbs_async_event_destroy_uobj(struct ib_uobject *uobj,
+					   enum rdma_remove_reason why)
+{
+	struct ib_uverbs_async_event_file *event_file =
+		container_of(uobj, struct ib_uverbs_async_event_file, uobj);
+
+	ib_unregister_event_handler(&event_file->event_handler);
+	ib_uverbs_free_event_queue(&event_file->ev_queue);
+	return 0;
+}
+
+DECLARE_UVERBS_NAMED_OBJECT(
+	UVERBS_OBJECT_ASYNC_EVENT,
+	UVERBS_TYPE_ALLOC_FD(sizeof(struct ib_uverbs_async_event_file),
+			     uverbs_async_event_destroy_uobj,
+			     &uverbs_async_event_fops,
+			     "[infinibandevent]",
+			     O_RDONLY));
+
+const struct uapi_definition uverbs_def_obj_async_fd[] = {
+	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(UVERBS_OBJECT_ASYNC_EVENT),
+	{}
+};
diff --git a/drivers/infiniband/core/uverbs_uapi.c b/drivers/infiniband/core/uverbs_uapi.c
index 9b84a12..3f121ac 100644
--- a/drivers/infiniband/core/uverbs_uapi.c
+++ b/drivers/infiniband/core/uverbs_uapi.c
@@ -626,6 +626,7 @@ void uverbs_destroy_api(struct uverbs_api *uapi)
 }
 
 static const struct uapi_definition uverbs_core_api[] = {
+	UAPI_DEF_CHAIN(uverbs_def_obj_async_fd),
 	UAPI_DEF_CHAIN(uverbs_def_obj_counters),
 	UAPI_DEF_CHAIN(uverbs_def_obj_cq),
 	UAPI_DEF_CHAIN(uverbs_def_obj_device),
diff --git a/include/uapi/rdma/ib_user_ioctl_cmds.h b/include/uapi/rdma/ib_user_ioctl_cmds.h
index 64f0e3a..9cfadb5 100644
--- a/include/uapi/rdma/ib_user_ioctl_cmds.h
+++ b/include/uapi/rdma/ib_user_ioctl_cmds.h
@@ -56,6 +56,7 @@ enum uverbs_default_objects {
 	UVERBS_OBJECT_FLOW_ACTION,
 	UVERBS_OBJECT_DM,
 	UVERBS_OBJECT_COUNTERS,
+	UVERBS_OBJECT_ASYNC_EVENT,
 };
 
 enum {
-- 
1.8.3.1

