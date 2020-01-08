Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29B4D134938
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jan 2020 18:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729767AbgAHRWi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Jan 2020 12:22:38 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:41829 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729765AbgAHRWi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Jan 2020 12:22:38 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from yishaih@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 8 Jan 2020 19:22:32 +0200
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [10.7.2.17])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 008HMW3l009640;
        Wed, 8 Jan 2020 19:22:32 +0200
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [127.0.0.1])
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8) with ESMTP id 008HMWR3009583;
        Wed, 8 Jan 2020 19:22:32 +0200
Received: (from yishaih@localhost)
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8/Submit) id 008HMWif009582;
        Wed, 8 Jan 2020 19:22:32 +0200
From:   Yishai Hadas <yishaih@mellanox.com>
To:     linux-rdma@vger.kernel.org, jgg@mellanox.com, dledford@redhat.com
Cc:     yishaih@mellanox.com, maorg@mellanox.com, michaelgur@mellanox.com
Subject: [PATCH rdma-next 14/14] RDMA/core: Use READ_ONCE for ib_ufile.async_file
Date:   Wed,  8 Jan 2020 19:22:06 +0200
Message-Id: <1578504126-9400-15-git-send-email-yishaih@mellanox.com>
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1578504126-9400-1-git-send-email-yishaih@mellanox.com>
References: <1578504126-9400-1-git-send-email-yishaih@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

The writer for async_file holds the ucontext_lock, while the readers are
left unlocked. Most readers rely on an implicit locking, either by having
a uobject (which cannot be created before a context) or by holding the
ib_ufile kref.

However ib_uverbs_free_hw_resources() has no implicit lock and has a
possible race. Make this all clear and sane by using READ_ONCE
consistently.

Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/infiniband/core/uverbs.h              |  6 ++----
 drivers/infiniband/core/uverbs_cmd.c          |  2 +-
 drivers/infiniband/core/uverbs_main.c         | 29 +++++++++++----------------
 drivers/infiniband/core/uverbs_std_types.c    |  6 +++---
 drivers/infiniband/core/uverbs_std_types_cq.c |  1 -
 5 files changed, 18 insertions(+), 26 deletions(-)

diff --git a/drivers/infiniband/core/uverbs.h b/drivers/infiniband/core/uverbs.h
index ccde5d2..aaa5c75 100644
--- a/drivers/infiniband/core/uverbs.h
+++ b/drivers/infiniband/core/uverbs.h
@@ -220,11 +220,9 @@ struct ib_ucq_object {
 void ib_uverbs_free_event_queue(struct ib_uverbs_event_queue *event_queue);
 void ib_uverbs_flow_resources_free(struct ib_uflow_resources *uflow_res);
 
-void ib_uverbs_release_ucq(struct ib_uverbs_file *file,
-			   struct ib_uverbs_completion_event_file *ev_file,
+void ib_uverbs_release_ucq(struct ib_uverbs_completion_event_file *ev_file,
 			   struct ib_ucq_object *uobj);
-void ib_uverbs_release_uevent(struct ib_uverbs_file *file,
-			      struct ib_uevent_object *uobj);
+void ib_uverbs_release_uevent(struct ib_uevent_object *uobj);
 void ib_uverbs_release_file(struct kref *ref);
 
 void ib_uverbs_comp_handler(struct ib_cq *cq, void *cq_context);
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index ced1384..29b1b5a 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -1056,7 +1056,7 @@ static struct ib_ucq_object *create_cq(struct uverbs_attr_bundle *attrs,
 	kfree(cq);
 err_file:
 	if (ev_file)
-		ib_uverbs_release_ucq(attrs->ufile, ev_file, obj);
+		ib_uverbs_release_ucq(ev_file, obj);
 
 err:
 	uobj_alloc_abort(&obj->uevent.uobject, attrs);
diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
index 121e65f..1f279b0a 100644
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -125,9 +125,8 @@ static void ib_uverbs_release_dev(struct device *device)
 	kfree(dev);
 }
 
-void ib_uverbs_release_ucq(struct ib_uverbs_file *file,
-			  struct ib_uverbs_completion_event_file *ev_file,
-			  struct ib_ucq_object *uobj)
+void ib_uverbs_release_ucq(struct ib_uverbs_completion_event_file *ev_file,
+			   struct ib_ucq_object *uobj)
 {
 	struct ib_uverbs_event *evt, *tmp;
 
@@ -142,20 +141,21 @@ void ib_uverbs_release_ucq(struct ib_uverbs_file *file,
 		uverbs_uobject_put(&ev_file->uobj);
 	}
 
-	ib_uverbs_release_uevent(file, &uobj->uevent);
+	ib_uverbs_release_uevent(&uobj->uevent);
 }
 
-void ib_uverbs_release_uevent(struct ib_uverbs_file *file,
-			      struct ib_uevent_object *uobj)
+void ib_uverbs_release_uevent(struct ib_uevent_object *uobj)
 {
+	struct ib_uverbs_async_event_file *async_file =
+		READ_ONCE(uobj->uobject.ufile->async_file);
 	struct ib_uverbs_event *evt, *tmp;
 
-	spin_lock_irq(&file->async_file->ev_queue.lock);
+	spin_lock_irq(&async_file->ev_queue.lock);
 	list_for_each_entry_safe(evt, tmp, &uobj->event_list, obj_list) {
 		list_del(&evt->list);
 		kfree(evt);
 	}
-	spin_unlock_irq(&file->async_file->ev_queue.lock);
+	spin_unlock_irq(&async_file->ev_queue.lock);
 }
 
 void ib_uverbs_detach_umcast(struct ib_qp *qp,
@@ -420,7 +420,7 @@ void ib_uverbs_comp_handler(struct ib_cq *cq, void *cq_context)
 static void uverbs_uobj_event(struct ib_uevent_object *eobj,
 			      struct ib_event *event)
 {
-	ib_uverbs_async_handler(eobj->uobject.ufile->async_file,
+	ib_uverbs_async_handler(READ_ONCE(eobj->uobject.ufile->async_file),
 				eobj->uobject.user_handle, event->event,
 				&eobj->event_list, &eobj->events_reported);
 }
@@ -476,9 +476,9 @@ void ib_uverbs_init_async_event_file(
 	ib_uverbs_init_event_queue(&async_file->ev_queue);
 
 	if (!WARN_ON(uverbs_file->async_file)) {
-		uverbs_file->async_file = async_file;
 		/* Pairs with the put in ib_uverbs_release_file */
 		uverbs_uobject_get(&async_file->uobj);
+		smp_store_release(&uverbs_file->async_file, async_file);
 	}
 
 	INIT_IB_EVENT_HANDLER(&async_file->event_handler, ib_dev,
@@ -1156,13 +1156,9 @@ static void ib_uverbs_free_hw_resources(struct ib_uverbs_device *uverbs_dev,
 					struct ib_device *ib_dev)
 {
 	struct ib_uverbs_file *file;
-	struct ib_event event;
 
 	/* Pending running commands to terminate */
 	uverbs_disassociate_api_pre(uverbs_dev);
-	event.event = IB_EVENT_DEVICE_FATAL;
-	event.element.port_num = 0;
-	event.device = ib_dev;
 
 	mutex_lock(&uverbs_dev->lists_mutex);
 	while (!list_empty(&uverbs_dev->uverbs_file_list)) {
@@ -1178,9 +1174,8 @@ static void ib_uverbs_free_hw_resources(struct ib_uverbs_device *uverbs_dev,
 		 */
 		mutex_unlock(&uverbs_dev->lists_mutex);
 
-		if (file->async_file)
-			ib_uverbs_event_handler(
-				&file->async_file->event_handler, &event);
+		ib_uverbs_async_handler(READ_ONCE(file->async_file), 0,
+					IB_EVENT_DEVICE_FATAL, NULL, NULL);
 
 		uverbs_destroy_ufile_hw(file, RDMA_REMOVE_DRIVER_REMOVE);
 		kref_put(&file->ref, ib_uverbs_release_file);
diff --git a/drivers/infiniband/core/uverbs_std_types.c b/drivers/infiniband/core/uverbs_std_types.c
index efe70bc..994d874 100644
--- a/drivers/infiniband/core/uverbs_std_types.c
+++ b/drivers/infiniband/core/uverbs_std_types.c
@@ -105,7 +105,7 @@ static int uverbs_free_qp(struct ib_uobject *uobject,
 	if (uqp->uxrcd)
 		atomic_dec(&uqp->uxrcd->refcnt);
 
-	ib_uverbs_release_uevent(attrs->ufile, &uqp->uevent);
+	ib_uverbs_release_uevent(&uqp->uevent);
 	return ret;
 }
 
@@ -138,7 +138,7 @@ static int uverbs_free_wq(struct ib_uobject *uobject,
 	if (ib_is_destroy_retryable(ret, why, uobject))
 		return ret;
 
-	ib_uverbs_release_uevent(attrs->ufile, &uwq->uevent);
+	ib_uverbs_release_uevent(&uwq->uevent);
 	return ret;
 }
 
@@ -163,7 +163,7 @@ static int uverbs_free_srq(struct ib_uobject *uobject,
 		atomic_dec(&us->uxrcd->refcnt);
 	}
 
-	ib_uverbs_release_uevent(attrs->ufile, uevent);
+	ib_uverbs_release_uevent(uevent);
 	return ret;
 }
 
diff --git a/drivers/infiniband/core/uverbs_std_types_cq.c b/drivers/infiniband/core/uverbs_std_types_cq.c
index a41c758..da4110a 100644
--- a/drivers/infiniband/core/uverbs_std_types_cq.c
+++ b/drivers/infiniband/core/uverbs_std_types_cq.c
@@ -49,7 +49,6 @@ static int uverbs_free_cq(struct ib_uobject *uobject,
 		return ret;
 
 	ib_uverbs_release_ucq(
-		attrs->ufile,
 		ev_queue ? container_of(ev_queue,
 					struct ib_uverbs_completion_event_file,
 					ev_queue) :
-- 
1.8.3.1

