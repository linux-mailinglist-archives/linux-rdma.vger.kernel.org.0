Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7A0134940
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jan 2020 18:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729755AbgAHRWm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Jan 2020 12:22:42 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:41809 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729772AbgAHRWl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Jan 2020 12:22:41 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from yishaih@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 8 Jan 2020 19:22:32 +0200
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [10.7.2.17])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 008HMWY7009628;
        Wed, 8 Jan 2020 19:22:32 +0200
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [127.0.0.1])
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8) with ESMTP id 008HMWEE009567;
        Wed, 8 Jan 2020 19:22:32 +0200
Received: (from yishaih@localhost)
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8/Submit) id 008HMWqB009566;
        Wed, 8 Jan 2020 19:22:32 +0200
From:   Yishai Hadas <yishaih@mellanox.com>
To:     linux-rdma@vger.kernel.org, jgg@mellanox.com, dledford@redhat.com
Cc:     yishaih@mellanox.com, maorg@mellanox.com, michaelgur@mellanox.com
Subject: [PATCH rdma-next 10/14] RDMA/core: Simplify type usage for ib_uverbs_async_handler()
Date:   Wed,  8 Jan 2020 19:22:02 +0200
Message-Id: <1578504126-9400-11-git-send-email-yishaih@mellanox.com>
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1578504126-9400-1-git-send-email-yishaih@mellanox.com>
References: <1578504126-9400-1-git-send-email-yishaih@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

This function works on an ib_uverbs_async_file. Accept that as a parameter
instead of the struct ib_uverbs_file.

Consoldiate all the callers working from an ib_uevent_object to a single
function and locate the async_file directly from the struct ib_uobject
instead of using context_ptr.

Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/infiniband/core/uverbs.h      |  2 -
 drivers/infiniband/core/uverbs_cmd.c  |  9 +---
 drivers/infiniband/core/uverbs_main.c | 79 +++++++++++++++--------------------
 3 files changed, 34 insertions(+), 56 deletions(-)

diff --git a/drivers/infiniband/core/uverbs.h b/drivers/infiniband/core/uverbs.h
index 9fa0446..8384b66 100644
--- a/drivers/infiniband/core/uverbs.h
+++ b/drivers/infiniband/core/uverbs.h
@@ -235,8 +235,6 @@ void ib_uverbs_release_uevent(struct ib_uverbs_file *file,
 void ib_uverbs_qp_event_handler(struct ib_event *event, void *context_ptr);
 void ib_uverbs_wq_event_handler(struct ib_event *event, void *context_ptr);
 void ib_uverbs_srq_event_handler(struct ib_event *event, void *context_ptr);
-void ib_uverbs_event_handler(struct ib_event_handler *handler,
-			     struct ib_event *event);
 int ib_uverbs_dealloc_xrcd(struct ib_uobject *uobject, struct ib_xrcd *xrcd,
 			   enum rdma_remove_reason why,
 			   struct uverbs_attr_bundle *attrs);
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 66f86b4..51117e7 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -1378,7 +1378,6 @@ static int create_qp(struct uverbs_attr_bundle *attrs,
 	}
 
 	attr.event_handler = ib_uverbs_qp_event_handler;
-	attr.qp_context    = attrs->ufile;
 	attr.send_cq       = scq;
 	attr.recv_cq       = rcq;
 	attr.srq           = srq;
@@ -1394,7 +1393,6 @@ static int create_qp(struct uverbs_attr_bundle *attrs,
 	attr.cap.max_recv_sge    = cmd->max_recv_sge;
 	attr.cap.max_inline_data = cmd->max_inline_data;
 
-	obj->uevent.events_reported     = 0;
 	INIT_LIST_HEAD(&obj->uevent.event_list);
 	INIT_LIST_HEAD(&obj->mcast_list);
 
@@ -1442,7 +1440,6 @@ static int create_qp(struct uverbs_attr_bundle *attrs,
 		qp->srq		  = attr.srq;
 		qp->rwq_ind_tbl	  = ind_tbl;
 		qp->event_handler = attr.event_handler;
-		qp->qp_context	  = attr.qp_context;
 		qp->qp_type	  = attr.qp_type;
 		atomic_set(&qp->usecnt, 0);
 		atomic_inc(&pd->usecnt);
@@ -1577,7 +1574,7 @@ static int ib_uverbs_open_qp(struct uverbs_attr_bundle *attrs)
 	struct ib_xrcd		       *xrcd;
 	struct ib_uobject	       *uninitialized_var(xrcd_uobj);
 	struct ib_qp                   *qp;
-	struct ib_qp_open_attr          attr;
+	struct ib_qp_open_attr          attr = {};
 	int ret;
 	struct ib_device *ib_dev;
 
@@ -1603,11 +1600,9 @@ static int ib_uverbs_open_qp(struct uverbs_attr_bundle *attrs)
 	}
 
 	attr.event_handler = ib_uverbs_qp_event_handler;
-	attr.qp_context    = attrs->ufile;
 	attr.qp_num        = cmd.qpn;
 	attr.qp_type       = cmd.qp_type;
 
-	obj->uevent.events_reported = 0;
 	INIT_LIST_HEAD(&obj->uevent.event_list);
 	INIT_LIST_HEAD(&obj->mcast_list);
 
@@ -2962,7 +2957,6 @@ static int ib_uverbs_ex_create_wq(struct uverbs_attr_bundle *attrs)
 	wq_init_attr.wq_type = cmd.wq_type;
 	wq_init_attr.event_handler = ib_uverbs_wq_event_handler;
 	wq_init_attr.create_flags = cmd.create_flags;
-	obj->uevent.events_reported = 0;
 	INIT_LIST_HEAD(&obj->uevent.event_list);
 
 	wq = pd->device->ops.create_wq(pd, &wq_init_attr, &attrs->driver_udata);
@@ -3452,7 +3446,6 @@ static int __uverbs_create_xsrq(struct uverbs_attr_bundle *attrs,
 	attr.attr.max_sge   = cmd->max_sge;
 	attr.attr.srq_limit = cmd->srq_limit;
 
-	obj->uevent.events_reported = 0;
 	INIT_LIST_HEAD(&obj->uevent.event_list);
 
 	srq = rdma_zalloc_drv_obj(ib_dev, ib_srq);
diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
index b0aad2e..85dbd81 100644
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -425,92 +425,79 @@ void ib_uverbs_comp_handler(struct ib_cq *cq, void *cq_context)
 	kill_fasync(&ev_queue->async_queue, SIGIO, POLL_IN);
 }
 
-static void ib_uverbs_async_handler(struct ib_uverbs_file *file,
-				    __u64 element, __u64 event,
-				    struct list_head *obj_list,
-				    u32 *counter)
+static void
+ib_uverbs_async_handler(struct ib_uverbs_async_event_file *async_file,
+			__u64 element, __u64 event, struct list_head *obj_list,
+			u32 *counter)
 {
 	struct ib_uverbs_event *entry;
 	unsigned long flags;
 
-	spin_lock_irqsave(&file->async_file->ev_queue.lock, flags);
-	if (file->async_file->ev_queue.is_closed) {
-		spin_unlock_irqrestore(&file->async_file->ev_queue.lock, flags);
+	spin_lock_irqsave(&async_file->ev_queue.lock, flags);
+	if (async_file->ev_queue.is_closed) {
+		spin_unlock_irqrestore(&async_file->ev_queue.lock, flags);
 		return;
 	}
 
 	entry = kmalloc(sizeof(*entry), GFP_ATOMIC);
 	if (!entry) {
-		spin_unlock_irqrestore(&file->async_file->ev_queue.lock, flags);
+		spin_unlock_irqrestore(&async_file->ev_queue.lock, flags);
 		return;
 	}
 
-	entry->desc.async.element    = element;
+	entry->desc.async.element = element;
 	entry->desc.async.event_type = event;
-	entry->desc.async.reserved   = 0;
-	entry->counter               = counter;
+	entry->desc.async.reserved = 0;
+	entry->counter = counter;
 
-	list_add_tail(&entry->list, &file->async_file->ev_queue.event_list);
+	list_add_tail(&entry->list, &async_file->ev_queue.event_list);
 	if (obj_list)
 		list_add_tail(&entry->obj_list, obj_list);
-	spin_unlock_irqrestore(&file->async_file->ev_queue.lock, flags);
+	spin_unlock_irqrestore(&async_file->ev_queue.lock, flags);
 
-	wake_up_interruptible(&file->async_file->ev_queue.poll_wait);
-	kill_fasync(&file->async_file->ev_queue.async_queue, SIGIO, POLL_IN);
+	wake_up_interruptible(&async_file->ev_queue.poll_wait);
+	kill_fasync(&async_file->ev_queue.async_queue, SIGIO, POLL_IN);
 }
 
-void ib_uverbs_cq_event_handler(struct ib_event *event, void *context_ptr)
+static void uverbs_uobj_event(struct ib_uevent_object *eobj,
+			      struct ib_event *event)
 {
-	struct ib_uevent_object *uobj = &event->element.cq->uobject->uevent;
+	ib_uverbs_async_handler(eobj->uobject.ufile->async_file,
+				eobj->uobject.user_handle, event->event,
+				&eobj->event_list, &eobj->events_reported);
+}
 
-	ib_uverbs_async_handler(uobj->uobject.ufile, uobj->uobject.user_handle,
-				event->event, &uobj->event_list,
-				&uobj->events_reported);
+void ib_uverbs_cq_event_handler(struct ib_event *event, void *context_ptr)
+{
+	uverbs_uobj_event(&event->element.cq->uobject->uevent, event);
 }
 
 void ib_uverbs_qp_event_handler(struct ib_event *event, void *context_ptr)
 {
-	struct ib_uevent_object *uobj;
-
 	/* for XRC target qp's, check that qp is live */
 	if (!event->element.qp->uobject)
 		return;
 
-	uobj = &event->element.qp->uobject->uevent;
-
-	ib_uverbs_async_handler(context_ptr, uobj->uobject.user_handle,
-				event->event, &uobj->event_list,
-				&uobj->events_reported);
+	uverbs_uobj_event(&event->element.qp->uobject->uevent, event);
 }
 
 void ib_uverbs_wq_event_handler(struct ib_event *event, void *context_ptr)
 {
-	struct ib_uevent_object *uobj = &event->element.wq->uobject->uevent;
-
-	ib_uverbs_async_handler(context_ptr, uobj->uobject.user_handle,
-				event->event, &uobj->event_list,
-				&uobj->events_reported);
+	uverbs_uobj_event(&event->element.wq->uobject->uevent, event);
 }
 
 void ib_uverbs_srq_event_handler(struct ib_event *event, void *context_ptr)
 {
-	struct ib_uevent_object *uobj;
-
-	uobj = &event->element.srq->uobject->uevent;
-
-	ib_uverbs_async_handler(context_ptr, uobj->uobject.user_handle,
-				event->event, &uobj->event_list,
-				&uobj->events_reported);
+	uverbs_uobj_event(&event->element.srq->uobject->uevent, event);
 }
 
-void ib_uverbs_event_handler(struct ib_event_handler *handler,
-			     struct ib_event *event)
+static void ib_uverbs_event_handler(struct ib_event_handler *handler,
+				    struct ib_event *event)
 {
-	struct ib_uverbs_file *file =
-		container_of(handler, struct ib_uverbs_file, event_handler);
-
-	ib_uverbs_async_handler(file, event->element.port_num, event->event,
-				NULL, NULL);
+	ib_uverbs_async_handler(
+		container_of(handler, struct ib_uverbs_file, event_handler)
+			->async_file,
+		event->element.port_num, event->event, NULL, NULL);
 }
 
 void ib_uverbs_free_async_event_file(struct ib_uverbs_file *file)
-- 
1.8.3.1

