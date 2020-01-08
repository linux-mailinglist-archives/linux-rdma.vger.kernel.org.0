Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C82F13493A
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jan 2020 18:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729765AbgAHRWi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Jan 2020 12:22:38 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:41800 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729771AbgAHRWh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Jan 2020 12:22:37 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from yishaih@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 8 Jan 2020 19:22:32 +0200
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [10.7.2.17])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 008HMWoE009622;
        Wed, 8 Jan 2020 19:22:32 +0200
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [127.0.0.1])
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8) with ESMTP id 008HMVHP009558;
        Wed, 8 Jan 2020 19:22:31 +0200
Received: (from yishaih@localhost)
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8/Submit) id 008HMVPA009557;
        Wed, 8 Jan 2020 19:22:31 +0200
From:   Yishai Hadas <yishaih@mellanox.com>
To:     linux-rdma@vger.kernel.org, jgg@mellanox.com, dledford@redhat.com
Cc:     yishaih@mellanox.com, maorg@mellanox.com, michaelgur@mellanox.com
Subject: [PATCH rdma-next 08/14] RDMA/core: Do not erase the type of ib_srq.uobject
Date:   Wed,  8 Jan 2020 19:22:00 +0200
Message-Id: <1578504126-9400-9-git-send-email-yishaih@mellanox.com>
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1578504126-9400-1-git-send-email-yishaih@mellanox.com>
References: <1578504126-9400-1-git-send-email-yishaih@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

This is a struct ib_usrq_object pointer, instead of using container_of()
all over the place just store it with its actual type.

Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/infiniband/core/uverbs_cmd.c  | 17 +++++++++++------
 drivers/infiniband/core/uverbs_main.c |  3 +--
 include/rdma/ib_verbs.h               |  3 ++-
 3 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 4d84d08..8350e02 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -1492,7 +1492,8 @@ static int create_qp(struct uverbs_attr_bundle *attrs,
 		rdma_lookup_put_uobject(&rcq->uobject->uevent.uobject,
 					UVERBS_LOOKUP_READ);
 	if (srq)
-		uobj_put_obj_read(srq);
+		rdma_lookup_put_uobject(&srq->uobject->uevent.uobject,
+					UVERBS_LOOKUP_READ);
 	if (ind_tbl)
 		uobj_put_obj_read(ind_tbl);
 
@@ -1513,7 +1514,8 @@ static int create_qp(struct uverbs_attr_bundle *attrs,
 		rdma_lookup_put_uobject(&rcq->uobject->uevent.uobject,
 					UVERBS_LOOKUP_READ);
 	if (srq)
-		uobj_put_obj_read(srq);
+		rdma_lookup_put_uobject(&srq->uobject->uevent.uobject,
+					UVERBS_LOOKUP_READ);
 	if (ind_tbl)
 		uobj_put_obj_read(ind_tbl);
 
@@ -2390,7 +2392,8 @@ static int ib_uverbs_post_srq_recv(struct uverbs_attr_bundle *attrs)
 	resp.bad_wr = 0;
 	ret = srq->device->ops.post_srq_recv(srq, wr, &bad_wr);
 
-	uobj_put_obj_read(srq);
+	rdma_lookup_put_uobject(&srq->uobject->uevent.uobject,
+				UVERBS_LOOKUP_READ);
 
 	if (ret)
 		for (next = wr; next; next = next->next) {
@@ -3458,7 +3461,7 @@ static int __uverbs_create_xsrq(struct uverbs_attr_bundle *attrs,
 	srq->device        = pd->device;
 	srq->pd            = pd;
 	srq->srq_type	   = cmd->srq_type;
-	srq->uobject       = &obj->uevent.uobject;
+	srq->uobject       = obj;
 	srq->event_handler = attr.event_handler;
 	srq->srq_context   = attr.srq_context;
 
@@ -3584,7 +3587,8 @@ static int ib_uverbs_modify_srq(struct uverbs_attr_bundle *attrs)
 	ret = srq->device->ops.modify_srq(srq, &attr, cmd.attr_mask,
 					  &attrs->driver_udata);
 
-	uobj_put_obj_read(srq);
+	rdma_lookup_put_uobject(&srq->uobject->uevent.uobject,
+				UVERBS_LOOKUP_READ);
 
 	return ret;
 }
@@ -3607,7 +3611,8 @@ static int ib_uverbs_query_srq(struct uverbs_attr_bundle *attrs)
 
 	ret = ib_query_srq(srq, &attr);
 
-	uobj_put_obj_read(srq);
+	rdma_lookup_put_uobject(&srq->uobject->uevent.uobject,
+				UVERBS_LOOKUP_READ);
 
 	if (ret)
 		return ret;
diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
index b0e7daa..b7bee1f 100644
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -497,8 +497,7 @@ void ib_uverbs_srq_event_handler(struct ib_event *event, void *context_ptr)
 {
 	struct ib_uevent_object *uobj;
 
-	uobj = container_of(event->element.srq->uobject,
-			    struct ib_uevent_object, uobject);
+	uobj = &event->element.srq->uobject->uevent;
 
 	ib_uverbs_async_handler(context_ptr, uobj->uobject.user_handle,
 				event->event, &uobj->event_list,
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 12e0c92..cfa871b 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -73,6 +73,7 @@
 
 struct ib_umem_odp;
 struct ib_uqp_object;
+struct ib_usrq_object;
 
 extern struct workqueue_struct *ib_wq;
 extern struct workqueue_struct *ib_comp_wq;
@@ -1570,7 +1571,7 @@ struct ib_cq {
 struct ib_srq {
 	struct ib_device       *device;
 	struct ib_pd	       *pd;
-	struct ib_uobject      *uobject;
+	struct ib_usrq_object  *uobject;
 	void		      (*event_handler)(struct ib_event *, void *);
 	void		       *srq_context;
 	enum ib_srq_type	srq_type;
-- 
1.8.3.1

