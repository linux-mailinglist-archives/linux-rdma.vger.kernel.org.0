Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49A8913493C
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jan 2020 18:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729770AbgAHRWj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Jan 2020 12:22:39 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:41798 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729768AbgAHRWj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Jan 2020 12:22:39 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from yishaih@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 8 Jan 2020 19:22:31 +0200
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [10.7.2.17])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 008HMVRv009609;
        Wed, 8 Jan 2020 19:22:31 +0200
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [127.0.0.1])
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8) with ESMTP id 008HMVlY009543;
        Wed, 8 Jan 2020 19:22:31 +0200
Received: (from yishaih@localhost)
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8/Submit) id 008HMVju009542;
        Wed, 8 Jan 2020 19:22:31 +0200
From:   Yishai Hadas <yishaih@mellanox.com>
To:     linux-rdma@vger.kernel.org, jgg@mellanox.com, dledford@redhat.com
Cc:     yishaih@mellanox.com, maorg@mellanox.com, michaelgur@mellanox.com
Subject: [PATCH rdma-next 05/14] RDMA/core: Make ib_ucq_object use ib_uevent_object
Date:   Wed,  8 Jan 2020 19:21:57 +0200
Message-Id: <1578504126-9400-6-git-send-email-yishaih@mellanox.com>
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1578504126-9400-1-git-send-email-yishaih@mellanox.com>
References: <1578504126-9400-1-git-send-email-yishaih@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

Any uobject that sends events into the async_event_file should be using
ib_uevent_object so it can use the standard uevent based helper
functions. CQ pushes events into both the async_event and the comp_channel
in an open coded way. Move the async events related stuff to
ib_uevent_object.

Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/infiniband/core/uverbs.h              |  5 ++---
 drivers/infiniband/core/uverbs_cmd.c          | 20 +++++++++-----------
 drivers/infiniband/core/uverbs_main.c         | 17 ++++++-----------
 drivers/infiniband/core/uverbs_std_types_cq.c | 18 ++++++++----------
 4 files changed, 25 insertions(+), 35 deletions(-)

diff --git a/drivers/infiniband/core/uverbs.h b/drivers/infiniband/core/uverbs.h
index 63f7f7d..9fa0446 100644
--- a/drivers/infiniband/core/uverbs.h
+++ b/drivers/infiniband/core/uverbs.h
@@ -183,6 +183,7 @@ struct ib_uverbs_mcast_entry {
 
 struct ib_uevent_object {
 	struct ib_uobject	uobject;
+	/* List member for ib_uverbs_async_event_file list */
 	struct list_head	event_list;
 	u32			events_reported;
 };
@@ -210,11 +211,9 @@ struct ib_uwq_object {
 };
 
 struct ib_ucq_object {
-	struct ib_uobject	uobject;
+	struct ib_uevent_object uevent;
 	struct list_head	comp_list;
-	struct list_head	async_list;
 	u32			comp_events_reported;
-	u32			async_events_reported;
 };
 
 extern const struct file_operations uverbs_event_fops;
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 74f6ae4..3a2a278 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -1015,11 +1015,9 @@ static struct ib_ucq_object *create_cq(struct uverbs_attr_bundle *attrs,
 		}
 	}
 
-	obj->uobject.user_handle = cmd->user_handle;
-	obj->comp_events_reported  = 0;
-	obj->async_events_reported = 0;
+	obj->uevent.uobject.user_handle = cmd->user_handle;
 	INIT_LIST_HEAD(&obj->comp_list);
-	INIT_LIST_HEAD(&obj->async_list);
+	INIT_LIST_HEAD(&obj->uevent.event_list);
 
 	attr.cqe = cmd->cqe;
 	attr.comp_vector = cmd->comp_vector;
@@ -1031,7 +1029,7 @@ static struct ib_ucq_object *create_cq(struct uverbs_attr_bundle *attrs,
 		goto err_file;
 	}
 	cq->device        = ib_dev;
-	cq->uobject       = &obj->uobject;
+	cq->uobject       = &obj->uevent.uobject;
 	cq->comp_handler  = ib_uverbs_comp_handler;
 	cq->event_handler = ib_uverbs_cq_event_handler;
 	cq->cq_context    = ev_file ? &ev_file->ev_queue : NULL;
@@ -1041,9 +1039,9 @@ static struct ib_ucq_object *create_cq(struct uverbs_attr_bundle *attrs,
 	if (ret)
 		goto err_free;
 
-	obj->uobject.object = cq;
+	obj->uevent.uobject.object = cq;
 	memset(&resp, 0, sizeof resp);
-	resp.base.cq_handle = obj->uobject.id;
+	resp.base.cq_handle = obj->uevent.uobject.id;
 	resp.base.cqe       = cq->cqe;
 	resp.response_length = uverbs_response_length(attrs, sizeof(resp));
 
@@ -1054,7 +1052,7 @@ static struct ib_ucq_object *create_cq(struct uverbs_attr_bundle *attrs,
 	if (ret)
 		goto err_cb;
 
-	rdma_alloc_commit_uobject(&obj->uobject, attrs);
+	rdma_alloc_commit_uobject(&obj->uevent.uobject, attrs);
 	return obj;
 
 err_cb:
@@ -1067,7 +1065,7 @@ static struct ib_ucq_object *create_cq(struct uverbs_attr_bundle *attrs,
 		ib_uverbs_release_ucq(attrs->ufile, ev_file, obj);
 
 err:
-	uobj_alloc_abort(&obj->uobject, attrs);
+	uobj_alloc_abort(&obj->uevent.uobject, attrs);
 
 	return ERR_PTR(ret);
 }
@@ -1261,10 +1259,10 @@ static int ib_uverbs_destroy_cq(struct uverbs_attr_bundle *attrs)
 	if (IS_ERR(uobj))
 		return PTR_ERR(uobj);
 
-	obj = container_of(uobj, struct ib_ucq_object, uobject);
+	obj = container_of(uobj, struct ib_ucq_object, uevent.uobject);
 	memset(&resp, 0, sizeof(resp));
 	resp.comp_events_reported  = obj->comp_events_reported;
-	resp.async_events_reported = obj->async_events_reported;
+	resp.async_events_reported = obj->uevent.events_reported;
 
 	uobj_put_destroy(uobj);
 
diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
index 290a91e..8fd8b48 100644
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -150,12 +150,7 @@ void ib_uverbs_release_ucq(struct ib_uverbs_file *file,
 		uverbs_uobject_put(&ev_file->uobj);
 	}
 
-	spin_lock_irq(&file->async_file->ev_queue.lock);
-	list_for_each_entry_safe(evt, tmp, &uobj->async_list, obj_list) {
-		list_del(&evt->list);
-		kfree(evt);
-	}
-	spin_unlock_irq(&file->async_file->ev_queue.lock);
+	ib_uverbs_release_uevent(file, &uobj->uevent);
 }
 
 void ib_uverbs_release_uevent(struct ib_uverbs_file *file,
@@ -417,7 +412,7 @@ void ib_uverbs_comp_handler(struct ib_cq *cq, void *cq_context)
 		return;
 	}
 
-	uobj = container_of(cq->uobject, struct ib_ucq_object, uobject);
+	uobj = container_of(cq->uobject, struct ib_ucq_object, uevent.uobject);
 
 	entry->desc.comp.cq_handle = cq->uobject->user_handle;
 	entry->counter		   = &uobj->comp_events_reported;
@@ -466,12 +461,12 @@ static void ib_uverbs_async_handler(struct ib_uverbs_file *file,
 
 void ib_uverbs_cq_event_handler(struct ib_event *event, void *context_ptr)
 {
-	struct ib_ucq_object *uobj = container_of(event->element.cq->uobject,
-						  struct ib_ucq_object, uobject);
+	struct ib_uevent_object *uobj = container_of(
+		event->element.cq->uobject, struct ib_uevent_object, uobject);
 
 	ib_uverbs_async_handler(uobj->uobject.ufile, uobj->uobject.user_handle,
-				event->event, &uobj->async_list,
-				&uobj->async_events_reported);
+				event->event, &uobj->event_list,
+				&uobj->events_reported);
 }
 
 void ib_uverbs_qp_event_handler(struct ib_event *event, void *context_ptr)
diff --git a/drivers/infiniband/core/uverbs_std_types_cq.c b/drivers/infiniband/core/uverbs_std_types_cq.c
index e39fe6a..fbc605a 100644
--- a/drivers/infiniband/core/uverbs_std_types_cq.c
+++ b/drivers/infiniband/core/uverbs_std_types_cq.c
@@ -41,7 +41,7 @@ static int uverbs_free_cq(struct ib_uobject *uobject,
 	struct ib_cq *cq = uobject->object;
 	struct ib_uverbs_event_queue *ev_queue = cq->cq_context;
 	struct ib_ucq_object *ucq =
-		container_of(uobject, struct ib_ucq_object, uobject);
+		container_of(uobject, struct ib_ucq_object, uevent.uobject);
 	int ret;
 
 	ret = ib_destroy_cq_user(cq, &attrs->driver_udata);
@@ -63,7 +63,7 @@ static int UVERBS_HANDLER(UVERBS_METHOD_CQ_CREATE)(
 {
 	struct ib_ucq_object *obj = container_of(
 		uverbs_attr_get_uobject(attrs, UVERBS_ATTR_CREATE_CQ_HANDLE),
-		typeof(*obj), uobject);
+		typeof(*obj), uevent.uobject);
 	struct ib_device *ib_dev = attrs->context->device;
 	int ret;
 	u64 user_handle;
@@ -106,10 +106,8 @@ static int UVERBS_HANDLER(UVERBS_METHOD_CQ_CREATE)(
 		goto err_event_file;
 	}
 
-	obj->comp_events_reported  = 0;
-	obj->async_events_reported = 0;
 	INIT_LIST_HEAD(&obj->comp_list);
-	INIT_LIST_HEAD(&obj->async_list);
+	INIT_LIST_HEAD(&obj->uevent.event_list);
 
 	cq = rdma_zalloc_drv_obj(ib_dev, ib_cq);
 	if (!cq) {
@@ -118,7 +116,7 @@ static int UVERBS_HANDLER(UVERBS_METHOD_CQ_CREATE)(
 	}
 
 	cq->device        = ib_dev;
-	cq->uobject       = &obj->uobject;
+	cq->uobject       = &obj->uevent.uobject;
 	cq->comp_handler  = ib_uverbs_comp_handler;
 	cq->event_handler = ib_uverbs_cq_event_handler;
 	cq->cq_context    = ev_file ? &ev_file->ev_queue : NULL;
@@ -129,8 +127,8 @@ static int UVERBS_HANDLER(UVERBS_METHOD_CQ_CREATE)(
 	if (ret)
 		goto err_free;
 
-	obj->uobject.object = cq;
-	obj->uobject.user_handle = user_handle;
+	obj->uevent.uobject.object = cq;
+	obj->uevent.uobject.user_handle = user_handle;
 	rdma_restrack_uadd(&cq->res);
 
 	ret = uverbs_copy_to(attrs, UVERBS_ATTR_CREATE_CQ_RESP_CQE, &cq->cqe,
@@ -182,10 +180,10 @@ static int UVERBS_HANDLER(UVERBS_METHOD_CQ_DESTROY)(
 	struct ib_uobject *uobj =
 		uverbs_attr_get_uobject(attrs, UVERBS_ATTR_DESTROY_CQ_HANDLE);
 	struct ib_ucq_object *obj =
-		container_of(uobj, struct ib_ucq_object, uobject);
+		container_of(uobj, struct ib_ucq_object, uevent.uobject);
 	struct ib_uverbs_destroy_cq_resp resp = {
 		.comp_events_reported = obj->comp_events_reported,
-		.async_events_reported = obj->async_events_reported
+		.async_events_reported = obj->uevent.events_reported
 	};
 
 	return uverbs_copy_to(attrs, UVERBS_ATTR_DESTROY_CQ_RESP, &resp,
-- 
1.8.3.1

