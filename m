Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3AAF134932
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jan 2020 18:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729773AbgAHRWh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Jan 2020 12:22:37 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:41799 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729760AbgAHRWh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Jan 2020 12:22:37 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from yishaih@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 8 Jan 2020 19:22:32 +0200
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [10.7.2.17])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 008HMWO8009625;
        Wed, 8 Jan 2020 19:22:32 +0200
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [127.0.0.1])
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8) with ESMTP id 008HMW8d009562;
        Wed, 8 Jan 2020 19:22:32 +0200
Received: (from yishaih@localhost)
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8/Submit) id 008HMWff009561;
        Wed, 8 Jan 2020 19:22:32 +0200
From:   Yishai Hadas <yishaih@mellanox.com>
To:     linux-rdma@vger.kernel.org, jgg@mellanox.com, dledford@redhat.com
Cc:     yishaih@mellanox.com, maorg@mellanox.com, michaelgur@mellanox.com
Subject: [PATCH rdma-next 09/14] RDMA/core: Do not erase the type of ib_wq.uobject
Date:   Wed,  8 Jan 2020 19:22:01 +0200
Message-Id: <1578504126-9400-10-git-send-email-yishaih@mellanox.com>
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1578504126-9400-1-git-send-email-yishaih@mellanox.com>
References: <1578504126-9400-1-git-send-email-yishaih@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

This is a struct ib_uwq_object pointer, instead of using container_of()
all over the place just store it with its actual type.

Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/infiniband/core/uverbs_cmd.c  | 13 ++++++++-----
 drivers/infiniband/core/uverbs_main.c |  3 +--
 include/rdma/ib_verbs.h               |  3 ++-
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 8350e02..66f86b4 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -2971,7 +2971,7 @@ static int ib_uverbs_ex_create_wq(struct uverbs_attr_bundle *attrs)
 		goto err_put_cq;
 	}
 
-	wq->uobject = &obj->uevent.uobject;
+	wq->uobject = obj;
 	obj->uevent.uobject.object = wq;
 	wq->wq_type = wq_init_attr.wq_type;
 	wq->cq = cq;
@@ -2981,7 +2981,7 @@ static int ib_uverbs_ex_create_wq(struct uverbs_attr_bundle *attrs)
 	atomic_set(&wq->usecnt, 0);
 	atomic_inc(&pd->usecnt);
 	atomic_inc(&cq->usecnt);
-	wq->uobject = &obj->uevent.uobject;
+	wq->uobject = obj;
 	obj->uevent.uobject.object = wq;
 
 	memset(&resp, 0, sizeof(resp));
@@ -3070,7 +3070,8 @@ static int ib_uverbs_ex_modify_wq(struct uverbs_attr_bundle *attrs)
 	}
 	ret = wq->device->ops.modify_wq(wq, &wq_attr, cmd.attr_mask,
 					&attrs->driver_udata);
-	uobj_put_obj_read(wq);
+	rdma_lookup_put_uobject(&wq->uobject->uevent.uobject,
+				UVERBS_LOOKUP_READ);
 	return ret;
 }
 
@@ -3171,7 +3172,8 @@ static int ib_uverbs_ex_create_rwq_ind_table(struct uverbs_attr_bundle *attrs)
 	kfree(wqs_handles);
 
 	for (j = 0; j < num_read_wqs; j++)
-		uobj_put_obj_read(wqs[j]);
+		rdma_lookup_put_uobject(&wqs[j]->uobject->uevent.uobject,
+					UVERBS_LOOKUP_READ);
 
 	rdma_alloc_commit_uobject(uobj, attrs);
 	return 0;
@@ -3182,7 +3184,8 @@ static int ib_uverbs_ex_create_rwq_ind_table(struct uverbs_attr_bundle *attrs)
 	uobj_alloc_abort(uobj, attrs);
 put_wqs:
 	for (j = 0; j < num_read_wqs; j++)
-		uobj_put_obj_read(wqs[j]);
+		rdma_lookup_put_uobject(&wqs[j]->uobject->uevent.uobject,
+					UVERBS_LOOKUP_READ);
 err_free:
 	kfree(wqs_handles);
 	kfree(wqs);
diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
index b7bee1f..b0aad2e 100644
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -485,8 +485,7 @@ void ib_uverbs_qp_event_handler(struct ib_event *event, void *context_ptr)
 
 void ib_uverbs_wq_event_handler(struct ib_event *event, void *context_ptr)
 {
-	struct ib_uevent_object *uobj = container_of(event->element.wq->uobject,
-						  struct ib_uevent_object, uobject);
+	struct ib_uevent_object *uobj = &event->element.wq->uobject->uevent;
 
 	ib_uverbs_async_handler(context_ptr, uobj->uobject.user_handle,
 				event->event, &uobj->event_list,
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index cfa871b..08cc7dc 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -74,6 +74,7 @@
 struct ib_umem_odp;
 struct ib_uqp_object;
 struct ib_usrq_object;
+struct ib_uwq_object;
 
 extern struct workqueue_struct *ib_wq;
 extern struct workqueue_struct *ib_comp_wq;
@@ -1616,7 +1617,7 @@ enum ib_wq_state {
 
 struct ib_wq {
 	struct ib_device       *device;
-	struct ib_uobject      *uobject;
+	struct ib_uwq_object   *uobject;
 	void		    *wq_context;
 	void		    (*event_handler)(struct ib_event *, void *);
 	struct ib_pd	       *pd;
-- 
1.8.3.1

