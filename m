Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D118134939
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jan 2020 18:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729769AbgAHRWi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Jan 2020 12:22:38 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:41792 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729753AbgAHRWh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Jan 2020 12:22:37 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from yishaih@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 8 Jan 2020 19:22:32 +0200
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [10.7.2.17])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 008HMV9r009615;
        Wed, 8 Jan 2020 19:22:31 +0200
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [127.0.0.1])
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8) with ESMTP id 008HMVRV009553;
        Wed, 8 Jan 2020 19:22:31 +0200
Received: (from yishaih@localhost)
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8/Submit) id 008HMVlF009552;
        Wed, 8 Jan 2020 19:22:31 +0200
From:   Yishai Hadas <yishaih@mellanox.com>
To:     linux-rdma@vger.kernel.org, jgg@mellanox.com, dledford@redhat.com
Cc:     yishaih@mellanox.com, maorg@mellanox.com, michaelgur@mellanox.com
Subject: [PATCH rdma-next 07/14] RDMA/core: Do not erase the type of ib_qp.uobject
Date:   Wed,  8 Jan 2020 19:21:59 +0200
Message-Id: <1578504126-9400-8-git-send-email-yishaih@mellanox.com>
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1578504126-9400-1-git-send-email-yishaih@mellanox.com>
References: <1578504126-9400-1-git-send-email-yishaih@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

This is a struct ib_uqp_object pointer, instead of using container_of()
all over the place just store it with its actual type.

Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/infiniband/core/core_priv.h   |  2 +-
 drivers/infiniband/core/uverbs_cmd.c  | 34 +++++++++++++++++++++-------------
 drivers/infiniband/core/uverbs_main.c |  3 +--
 include/rdma/ib_verbs.h               |  3 ++-
 4 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/drivers/infiniband/core/core_priv.h b/drivers/infiniband/core/core_priv.h
index 3645e09..34feb68 100644
--- a/drivers/infiniband/core/core_priv.h
+++ b/drivers/infiniband/core/core_priv.h
@@ -320,7 +320,7 @@ static inline struct ib_qp *_ib_create_qp(struct ib_device *dev,
 					  struct ib_pd *pd,
 					  struct ib_qp_init_attr *attr,
 					  struct ib_udata *udata,
-					  struct ib_uobject *uobj)
+					  struct ib_uqp_object *uobj)
 {
 	enum ib_qp_type qp_type = attr->qp_type;
 	struct ib_qp *qp;
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index b08679a..4d84d08 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -1424,7 +1424,7 @@ static int create_qp(struct uverbs_attr_bundle *attrs,
 		qp = ib_create_qp(pd, &attr);
 	else
 		qp = _ib_create_qp(device, pd, &attr, &attrs->driver_udata,
-				   &obj->uevent.uobject);
+				   obj);
 
 	if (IS_ERR(qp)) {
 		ret = PTR_ERR(qp);
@@ -1457,7 +1457,7 @@ static int create_qp(struct uverbs_attr_bundle *attrs,
 			atomic_inc(&ind_tbl->usecnt);
 	} else {
 		/* It is done in _ib_create_qp for other QP types */
-		qp->uobject = &obj->uevent.uobject;
+		qp->uobject = obj;
 	}
 
 	obj->uevent.uobject.object = qp;
@@ -1628,7 +1628,7 @@ static int ib_uverbs_open_qp(struct uverbs_attr_bundle *attrs)
 
 	obj->uxrcd = container_of(xrcd_uobj, struct ib_uxrcd_object, uobject);
 	atomic_inc(&obj->uxrcd->refcnt);
-	qp->uobject = &obj->uevent.uobject;
+	qp->uobject = obj;
 	uobj_put_read(xrcd_uobj);
 
 	rdma_alloc_commit_uobject(&obj->uevent.uobject, attrs);
@@ -1693,7 +1693,8 @@ static int ib_uverbs_query_qp(struct uverbs_attr_bundle *attrs)
 
 	ret = ib_query_qp(qp, attr, cmd.attr_mask, init_attr);
 
-	uobj_put_obj_read(qp);
+	rdma_lookup_put_uobject(&qp->uobject->uevent.uobject,
+				UVERBS_LOOKUP_READ);
 
 	if (ret)
 		goto out;
@@ -1930,7 +1931,8 @@ static int modify_qp(struct uverbs_attr_bundle *attrs,
 				      &attrs->driver_udata);
 
 release_qp:
-	uobj_put_obj_read(qp);
+	rdma_lookup_put_uobject(&qp->uobject->uevent.uobject,
+				UVERBS_LOOKUP_READ);
 out:
 	kfree(attr);
 
@@ -2194,7 +2196,8 @@ static int ib_uverbs_post_send(struct uverbs_attr_bundle *attrs)
 		ret = ret2;
 
 out_put:
-	uobj_put_obj_read(qp);
+	rdma_lookup_put_uobject(&qp->uobject->uevent.uobject,
+				UVERBS_LOOKUP_READ);
 
 	while (wr) {
 		if (is_ud && ud_wr(wr)->ah)
@@ -2336,7 +2339,8 @@ static int ib_uverbs_post_recv(struct uverbs_attr_bundle *attrs)
 	resp.bad_wr = 0;
 	ret = qp->device->ops.post_recv(qp->real_qp, wr, &bad_wr);
 
-	uobj_put_obj_read(qp);
+	rdma_lookup_put_uobject(&qp->uobject->uevent.uobject,
+				UVERBS_LOOKUP_READ);
 	if (ret) {
 		for (next = wr; next; next = next->next) {
 			++resp.bad_wr;
@@ -2517,7 +2521,7 @@ static int ib_uverbs_attach_mcast(struct uverbs_attr_bundle *attrs)
 	if (!qp)
 		return -EINVAL;
 
-	obj = container_of(qp->uobject, struct ib_uqp_object, uevent.uobject);
+	obj = qp->uobject;
 
 	mutex_lock(&obj->mcast_lock);
 	list_for_each_entry(mcast, &obj->mcast_list, list)
@@ -2544,7 +2548,8 @@ static int ib_uverbs_attach_mcast(struct uverbs_attr_bundle *attrs)
 
 out_put:
 	mutex_unlock(&obj->mcast_lock);
-	uobj_put_obj_read(qp);
+	rdma_lookup_put_uobject(&qp->uobject->uevent.uobject,
+				UVERBS_LOOKUP_READ);
 
 	return ret;
 }
@@ -2566,7 +2571,7 @@ static int ib_uverbs_detach_mcast(struct uverbs_attr_bundle *attrs)
 	if (!qp)
 		return -EINVAL;
 
-	obj = container_of(qp->uobject, struct ib_uqp_object, uevent.uobject);
+	obj = qp->uobject;
 	mutex_lock(&obj->mcast_lock);
 
 	list_for_each_entry(mcast, &obj->mcast_list, list)
@@ -2587,7 +2592,8 @@ static int ib_uverbs_detach_mcast(struct uverbs_attr_bundle *attrs)
 
 out_put:
 	mutex_unlock(&obj->mcast_lock);
-	uobj_put_obj_read(qp);
+	rdma_lookup_put_uobject(&qp->uobject->uevent.uobject,
+				UVERBS_LOOKUP_READ);
 	return ret;
 }
 
@@ -3339,7 +3345,8 @@ static int ib_uverbs_ex_create_flow(struct uverbs_attr_bundle *attrs)
 	if (err)
 		goto err_copy;
 
-	uobj_put_obj_read(qp);
+	rdma_lookup_put_uobject(&qp->uobject->uevent.uobject,
+				UVERBS_LOOKUP_READ);
 	kfree(flow_attr);
 	if (cmd.flow_attr.num_of_specs)
 		kfree(kern_flow_attr);
@@ -3353,7 +3360,8 @@ static int ib_uverbs_ex_create_flow(struct uverbs_attr_bundle *attrs)
 err_free_flow_attr:
 	kfree(flow_attr);
 err_put:
-	uobj_put_obj_read(qp);
+	rdma_lookup_put_uobject(&qp->uobject->uevent.uobject,
+				UVERBS_LOOKUP_READ);
 err_uobj:
 	uobj_alloc_abort(uobj, attrs);
 err_free_attr:
diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
index bf13591..b0e7daa 100644
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -476,8 +476,7 @@ void ib_uverbs_qp_event_handler(struct ib_event *event, void *context_ptr)
 	if (!event->element.qp->uobject)
 		return;
 
-	uobj = container_of(event->element.qp->uobject,
-			    struct ib_uevent_object, uobject);
+	uobj = &event->element.qp->uobject->uevent;
 
 	ib_uverbs_async_handler(context_ptr, uobj->uobject.user_handle,
 				event->event, &uobj->event_list,
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 81bc259..12e0c92 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -72,6 +72,7 @@
 #define IB_FW_VERSION_NAME_MAX	ETHTOOL_FWVERS_LEN
 
 struct ib_umem_odp;
+struct ib_uqp_object;
 
 extern struct workqueue_struct *ib_wq;
 extern struct workqueue_struct *ib_comp_wq;
@@ -1730,7 +1731,7 @@ struct ib_qp {
 	atomic_t		usecnt;
 	struct list_head	open_list;
 	struct ib_qp           *real_qp;
-	struct ib_uobject      *uobject;
+	struct ib_uqp_object   *uobject;
 	void                  (*event_handler)(struct ib_event *, void *);
 	void		       *qp_context;
 	/* sgid_attrs associated with the AV's */
-- 
1.8.3.1

