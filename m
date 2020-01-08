Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBCD134934
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jan 2020 18:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729766AbgAHRWh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Jan 2020 12:22:37 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:41796 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729769AbgAHRWh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Jan 2020 12:22:37 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from yishaih@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 8 Jan 2020 19:22:31 +0200
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [10.7.2.17])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 008HMVlM009612;
        Wed, 8 Jan 2020 19:22:31 +0200
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [127.0.0.1])
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8) with ESMTP id 008HMVkH009549;
        Wed, 8 Jan 2020 19:22:31 +0200
Received: (from yishaih@localhost)
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8/Submit) id 008HMVuG009548;
        Wed, 8 Jan 2020 19:22:31 +0200
From:   Yishai Hadas <yishaih@mellanox.com>
To:     linux-rdma@vger.kernel.org, jgg@mellanox.com, dledford@redhat.com
Cc:     yishaih@mellanox.com, maorg@mellanox.com, michaelgur@mellanox.com
Subject: [PATCH rdma-next 06/14] RDMA/core: Do not erase the type of ib_cq.uobject
Date:   Wed,  8 Jan 2020 19:21:58 +0200
Message-Id: <1578504126-9400-7-git-send-email-yishaih@mellanox.com>
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1578504126-9400-1-git-send-email-yishaih@mellanox.com>
References: <1578504126-9400-1-git-send-email-yishaih@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

This is a struct ib_ucq_object pointer, instead of using container_of()
all over the place just store it with its actual type.

Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/infiniband/core/nldev.c               |  3 +-
 drivers/infiniband/core/uverbs_cmd.c          | 40 +++++++++++++++++----------
 drivers/infiniband/core/uverbs_main.c         |  7 ++---
 drivers/infiniband/core/uverbs_std_types_cq.c |  2 +-
 include/rdma/ib_verbs.h                       |  4 ++-
 5 files changed, 34 insertions(+), 22 deletions(-)

diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index cbf6041..37b433aa 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -41,6 +41,7 @@
 #include "core_priv.h"
 #include "cma_priv.h"
 #include "restrack.h"
+#include "uverbs.h"
 
 typedef int (*res_fill_func_t)(struct sk_buff*, bool,
 			       struct rdma_restrack_entry*, uint32_t);
@@ -599,7 +600,7 @@ static int fill_res_cq_entry(struct sk_buff *msg, bool has_cap_net_admin,
 		goto err;
 	if (!rdma_is_kernel_res(res) &&
 	    nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_CTXN,
-			cq->uobject->context->res.id))
+			cq->uobject->uevent.uobject.context->res.id))
 		goto err;
 
 	if (fill_res_name_pid(msg, res))
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 3a2a278..b08679a 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -1029,7 +1029,7 @@ static struct ib_ucq_object *create_cq(struct uverbs_attr_bundle *attrs,
 		goto err_file;
 	}
 	cq->device        = ib_dev;
-	cq->uobject       = &obj->uevent.uobject;
+	cq->uobject       = obj;
 	cq->comp_handler  = ib_uverbs_comp_handler;
 	cq->event_handler = ib_uverbs_cq_event_handler;
 	cq->cq_context    = ev_file ? &ev_file->ev_queue : NULL;
@@ -1134,7 +1134,8 @@ static int ib_uverbs_resize_cq(struct uverbs_attr_bundle *attrs)
 
 	ret = uverbs_response(attrs, &resp, sizeof(resp));
 out:
-	uobj_put_obj_read(cq);
+	rdma_lookup_put_uobject(&cq->uobject->uevent.uobject,
+				UVERBS_LOOKUP_READ);
 
 	return ret;
 }
@@ -1217,7 +1218,8 @@ static int ib_uverbs_poll_cq(struct uverbs_attr_bundle *attrs)
 		ret = uverbs_output_written(attrs, UVERBS_ATTR_CORE_OUT);
 
 out_put:
-	uobj_put_obj_read(cq);
+	rdma_lookup_put_uobject(&cq->uobject->uevent.uobject,
+				UVERBS_LOOKUP_READ);
 	return ret;
 }
 
@@ -1238,8 +1240,8 @@ static int ib_uverbs_req_notify_cq(struct uverbs_attr_bundle *attrs)
 	ib_req_notify_cq(cq, cmd.solicited_only ?
 			 IB_CQ_SOLICITED : IB_CQ_NEXT_COMP);
 
-	uobj_put_obj_read(cq);
-
+	rdma_lookup_put_uobject(&cq->uobject->uevent.uobject,
+				UVERBS_LOOKUP_READ);
 	return 0;
 }
 
@@ -1484,9 +1486,11 @@ static int create_qp(struct uverbs_attr_bundle *attrs,
 	if (pd)
 		uobj_put_obj_read(pd);
 	if (scq)
-		uobj_put_obj_read(scq);
+		rdma_lookup_put_uobject(&scq->uobject->uevent.uobject,
+					UVERBS_LOOKUP_READ);
 	if (rcq && rcq != scq)
-		uobj_put_obj_read(rcq);
+		rdma_lookup_put_uobject(&rcq->uobject->uevent.uobject,
+					UVERBS_LOOKUP_READ);
 	if (srq)
 		uobj_put_obj_read(srq);
 	if (ind_tbl)
@@ -1503,9 +1507,11 @@ static int create_qp(struct uverbs_attr_bundle *attrs,
 	if (pd)
 		uobj_put_obj_read(pd);
 	if (scq)
-		uobj_put_obj_read(scq);
+		rdma_lookup_put_uobject(&scq->uobject->uevent.uobject,
+					UVERBS_LOOKUP_READ);
 	if (rcq && rcq != scq)
-		uobj_put_obj_read(rcq);
+		rdma_lookup_put_uobject(&rcq->uobject->uevent.uobject,
+					UVERBS_LOOKUP_READ);
 	if (srq)
 		uobj_put_obj_read(srq);
 	if (ind_tbl)
@@ -2980,14 +2986,16 @@ static int ib_uverbs_ex_create_wq(struct uverbs_attr_bundle *attrs)
 		goto err_copy;
 
 	uobj_put_obj_read(pd);
-	uobj_put_obj_read(cq);
+	rdma_lookup_put_uobject(&cq->uobject->uevent.uobject,
+				UVERBS_LOOKUP_READ);
 	rdma_alloc_commit_uobject(&obj->uevent.uobject, attrs);
 	return 0;
 
 err_copy:
 	ib_destroy_wq(wq, uverbs_get_cleared_udata(attrs));
 err_put_cq:
-	uobj_put_obj_read(cq);
+	rdma_lookup_put_uobject(&cq->uobject->uevent.uobject,
+				UVERBS_LOOKUP_READ);
 err_put_pd:
 	uobj_put_obj_read(pd);
 err_uobj:
@@ -3481,7 +3489,8 @@ static int __uverbs_create_xsrq(struct uverbs_attr_bundle *attrs,
 		uobj_put_read(xrcd_uobj);
 
 	if (ib_srq_has_cq(cmd->srq_type))
-		uobj_put_obj_read(attr.ext.cq);
+		rdma_lookup_put_uobject(&attr.ext.cq->uobject->uevent.uobject,
+					UVERBS_LOOKUP_READ);
 
 	uobj_put_obj_read(pd);
 	rdma_alloc_commit_uobject(&obj->uevent.uobject, attrs);
@@ -3498,7 +3507,8 @@ static int __uverbs_create_xsrq(struct uverbs_attr_bundle *attrs,
 
 err_put_cq:
 	if (ib_srq_has_cq(cmd->srq_type))
-		uobj_put_obj_read(attr.ext.cq);
+		rdma_lookup_put_uobject(&attr.ext.cq->uobject->uevent.uobject,
+					UVERBS_LOOKUP_READ);
 
 err_put_xrcd:
 	if (cmd->srq_type == IB_SRQT_XRC) {
@@ -3714,8 +3724,8 @@ static int ib_uverbs_ex_modify_cq(struct uverbs_attr_bundle *attrs)
 
 	ret = rdma_set_cq_moderation(cq, cmd.attr.cq_count, cmd.attr.cq_period);
 
-	uobj_put_obj_read(cq);
-
+	rdma_lookup_put_uobject(&cq->uobject->uevent.uobject,
+				UVERBS_LOOKUP_READ);
 	return ret;
 }
 
diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
index 8fd8b48..bf13591 100644
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -412,9 +412,9 @@ void ib_uverbs_comp_handler(struct ib_cq *cq, void *cq_context)
 		return;
 	}
 
-	uobj = container_of(cq->uobject, struct ib_ucq_object, uevent.uobject);
+	uobj = cq->uobject;
 
-	entry->desc.comp.cq_handle = cq->uobject->user_handle;
+	entry->desc.comp.cq_handle = cq->uobject->uevent.uobject.user_handle;
 	entry->counter		   = &uobj->comp_events_reported;
 
 	list_add_tail(&entry->list, &ev_queue->event_list);
@@ -461,8 +461,7 @@ static void ib_uverbs_async_handler(struct ib_uverbs_file *file,
 
 void ib_uverbs_cq_event_handler(struct ib_event *event, void *context_ptr)
 {
-	struct ib_uevent_object *uobj = container_of(
-		event->element.cq->uobject, struct ib_uevent_object, uobject);
+	struct ib_uevent_object *uobj = &event->element.cq->uobject->uevent;
 
 	ib_uverbs_async_handler(uobj->uobject.ufile, uobj->uobject.user_handle,
 				event->event, &uobj->event_list,
diff --git a/drivers/infiniband/core/uverbs_std_types_cq.c b/drivers/infiniband/core/uverbs_std_types_cq.c
index fbc605a..a41c758 100644
--- a/drivers/infiniband/core/uverbs_std_types_cq.c
+++ b/drivers/infiniband/core/uverbs_std_types_cq.c
@@ -116,7 +116,7 @@ static int UVERBS_HANDLER(UVERBS_METHOD_CQ_CREATE)(
 	}
 
 	cq->device        = ib_dev;
-	cq->uobject       = &obj->uevent.uobject;
+	cq->uobject       = obj;
 	cq->comp_handler  = ib_uverbs_comp_handler;
 	cq->event_handler = ib_uverbs_cq_event_handler;
 	cq->cq_context    = ev_file ? &ev_file->ev_queue : NULL;
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 5608e14..81bc259 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -77,6 +77,8 @@
 extern struct workqueue_struct *ib_comp_wq;
 extern struct workqueue_struct *ib_comp_unbound_wq;
 
+struct ib_ucq_object;
+
 __printf(3, 4) __cold
 void ibdev_printk(const char *level, const struct ib_device *ibdev,
 		  const char *format, ...);
@@ -1544,7 +1546,7 @@ enum ib_poll_context {
 
 struct ib_cq {
 	struct ib_device       *device;
-	struct ib_uobject      *uobject;
+	struct ib_ucq_object   *uobject;
 	ib_comp_handler   	comp_handler;
 	void                  (*event_handler)(struct ib_event *, void *);
 	void                   *cq_context;
-- 
1.8.3.1

