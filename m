Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9C051C6B99
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2020 10:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbgEFIZF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 May 2020 04:25:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:60102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727956AbgEFIZF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 6 May 2020 04:25:05 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EA412073A;
        Wed,  6 May 2020 08:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588753503;
        bh=3Prd8Kzy8cbISokUNqHAUMi2NypAyqs6KHQcT7hsteA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fvlTp0q+QcjusArsJ37yhTlC2f+bVPgytofOlxeyoLG+2aC1zdzgf44m26WFRn8da
         Q91er+l/tYeQ8rfmrj3jVEwYhDrO/b+1KSld+O79WMkQQlC/uk7oDARWsyKTgqED0/
         A/PuwwdhP/3WADE6xPOGgXPcyk/Q+EPGEIEsaQtY=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Yishai Hadas <yishaih@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v1 02/10] IB/uverbs: Refactor related objects to use their own asynchronous event FD
Date:   Wed,  6 May 2020 11:24:36 +0300
Message-Id: <20200506082444.14502-3-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200506082444.14502-1-leon@kernel.org>
References: <20200506082444.14502-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yishai Hadas <yishaih@mellanox.com>

Refactor related objects to use their own asynchronous event FD.
The ufile event FD will be the default in case an object won't have its own
event FD.

Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/uverbs.h              |  3 ++-
 drivers/infiniband/core/uverbs_cmd.c          | 24 ++++++++++++++++++-
 drivers/infiniband/core/uverbs_main.c         | 16 ++++++-------
 drivers/infiniband/core/uverbs_std_types_cq.c |  6 +++++
 4 files changed, 39 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/core/uverbs.h b/drivers/infiniband/core/uverbs.h
index 7df71983212d..55b47f110183 100644
--- a/drivers/infiniband/core/uverbs.h
+++ b/drivers/infiniband/core/uverbs.h
@@ -142,7 +142,7 @@ struct ib_uverbs_file {
 	 * ucontext_lock held
 	 */
 	struct ib_ucontext		       *ucontext;
-	struct ib_uverbs_async_event_file      *async_file;
+	struct ib_uverbs_async_event_file      *default_async_file;
 	struct list_head			list;
 
 	/*
@@ -180,6 +180,7 @@ struct ib_uverbs_mcast_entry {
 
 struct ib_uevent_object {
 	struct ib_uobject	uobject;
+	struct ib_uverbs_async_event_file *event_file;
 	/* List member for ib_uverbs_async_event_file list */
 	struct list_head	event_list;
 	u32			events_reported;
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 7959f618b8a5..1d147beaf4cc 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -1051,6 +1051,10 @@ static struct ib_ucq_object *create_cq(struct uverbs_attr_bundle *attrs,
 		goto err_free;
 
 	obj->uevent.uobject.object = cq;
+	obj->uevent.event_file = attrs->ufile->default_async_file;
+	if (obj->uevent.event_file)
+		uverbs_uobject_get(&obj->uevent.event_file->uobj);
+
 	memset(&resp, 0, sizeof resp);
 	resp.base.cq_handle = obj->uevent.uobject.id;
 	resp.base.cqe       = cq->cqe;
@@ -1067,6 +1071,8 @@ static struct ib_ucq_object *create_cq(struct uverbs_attr_bundle *attrs,
 	return obj;
 
 err_cb:
+	if (obj->uevent.event_file)
+		uverbs_uobject_put(&obj->uevent.event_file->uobj);
 	ib_destroy_cq_user(cq, uverbs_get_cleared_udata(attrs));
 	cq = NULL;
 err_free:
@@ -1460,6 +1466,9 @@ static int create_qp(struct uverbs_attr_bundle *attrs,
 	}
 
 	obj->uevent.uobject.object = qp;
+	obj->uevent.event_file = attrs->ufile->default_async_file;
+	if (obj->uevent.event_file)
+		uverbs_uobject_get(&obj->uevent.event_file->uobj);
 
 	memset(&resp, 0, sizeof resp);
 	resp.base.qpn             = qp->qp_num;
@@ -1473,7 +1482,7 @@ static int create_qp(struct uverbs_attr_bundle *attrs,
 
 	ret = uverbs_response(attrs, &resp, sizeof(resp));
 	if (ret)
-		goto err_cb;
+		goto err_uevent;
 
 	if (xrcd) {
 		obj->uxrcd = container_of(xrcd_uobj, struct ib_uxrcd_object,
@@ -1498,6 +1507,9 @@ static int create_qp(struct uverbs_attr_bundle *attrs,
 
 	rdma_alloc_commit_uobject(&obj->uevent.uobject, attrs);
 	return 0;
+err_uevent:
+	if (obj->uevent.event_file)
+		uverbs_uobject_put(&obj->uevent.event_file->uobj);
 err_cb:
 	ib_destroy_qp_user(qp, uverbs_get_cleared_udata(attrs));
 
@@ -2978,6 +2990,9 @@ static int ib_uverbs_ex_create_wq(struct uverbs_attr_bundle *attrs)
 	atomic_inc(&cq->usecnt);
 	wq->uobject = obj;
 	obj->uevent.uobject.object = wq;
+	obj->uevent.event_file = attrs->ufile->default_async_file;
+	if (obj->uevent.event_file)
+		uverbs_uobject_get(&obj->uevent.event_file->uobj);
 
 	memset(&resp, 0, sizeof(resp));
 	resp.wq_handle = obj->uevent.uobject.id;
@@ -2996,6 +3011,8 @@ static int ib_uverbs_ex_create_wq(struct uverbs_attr_bundle *attrs)
 	return 0;
 
 err_copy:
+	if (obj->uevent.event_file)
+		uverbs_uobject_put(&obj->uevent.event_file->uobj);
 	ib_destroy_wq(wq, uverbs_get_cleared_udata(attrs));
 err_put_cq:
 	rdma_lookup_put_uobject(&cq->uobject->uevent.uobject,
@@ -3481,6 +3498,9 @@ static int __uverbs_create_xsrq(struct uverbs_attr_bundle *attrs,
 
 	obj->uevent.uobject.object = srq;
 	obj->uevent.uobject.user_handle = cmd->user_handle;
+	obj->uevent.event_file = attrs->ufile->default_async_file;
+	if (obj->uevent.event_file)
+		uverbs_uobject_get(&obj->uevent.event_file->uobj);
 
 	memset(&resp, 0, sizeof resp);
 	resp.srq_handle = obj->uevent.uobject.id;
@@ -3505,6 +3525,8 @@ static int __uverbs_create_xsrq(struct uverbs_attr_bundle *attrs,
 	return 0;
 
 err_copy:
+	if (obj->uevent.event_file)
+		uverbs_uobject_put(&obj->uevent.event_file->uobj);
 	ib_destroy_srq_user(srq, uverbs_get_cleared_udata(attrs));
 	/* It was released in ib_destroy_srq_user */
 	srq = NULL;
diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
index d52eb870533b..267904e41837 100644
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -146,8 +146,7 @@ void ib_uverbs_release_ucq(struct ib_uverbs_completion_event_file *ev_file,
 
 void ib_uverbs_release_uevent(struct ib_uevent_object *uobj)
 {
-	struct ib_uverbs_async_event_file *async_file =
-		READ_ONCE(uobj->uobject.ufile->async_file);
+	struct ib_uverbs_async_event_file *async_file = uobj->event_file;
 	struct ib_uverbs_event *evt, *tmp;
 
 	if (!async_file)
@@ -159,6 +158,7 @@ void ib_uverbs_release_uevent(struct ib_uevent_object *uobj)
 		kfree(evt);
 	}
 	spin_unlock_irq(&async_file->ev_queue.lock);
+	uverbs_uobject_put(&async_file->uobj);
 }
 
 void ib_uverbs_detach_umcast(struct ib_qp *qp,
@@ -197,8 +197,8 @@ void ib_uverbs_release_file(struct kref *ref)
 	if (atomic_dec_and_test(&file->device->refcount))
 		ib_uverbs_comp_dev(file->device);
 
-	if (file->async_file)
-		uverbs_uobject_put(&file->async_file->uobj);
+	if (file->default_async_file)
+		uverbs_uobject_put(&file->default_async_file->uobj);
 	put_device(&file->device->dev);
 
 	if (file->disassociate_page)
@@ -428,7 +428,7 @@ ib_uverbs_async_handler(struct ib_uverbs_async_event_file *async_file,
 static void uverbs_uobj_event(struct ib_uevent_object *eobj,
 			      struct ib_event *event)
 {
-	ib_uverbs_async_handler(READ_ONCE(eobj->uobject.ufile->async_file),
+	ib_uverbs_async_handler(eobj->event_file,
 				eobj->uobject.user_handle, event->event,
 				&eobj->event_list, &eobj->events_reported);
 }
@@ -485,10 +485,10 @@ void ib_uverbs_init_async_event_file(
 
 	/* The first async_event_file becomes the default one for the file. */
 	mutex_lock(&uverbs_file->ucontext_lock);
-	if (!uverbs_file->async_file) {
+	if (!uverbs_file->default_async_file) {
 		/* Pairs with the put in ib_uverbs_release_file */
 		uverbs_uobject_get(&async_file->uobj);
-		smp_store_release(&uverbs_file->async_file, async_file);
+		smp_store_release(&uverbs_file->default_async_file, async_file);
 	}
 	mutex_unlock(&uverbs_file->ucontext_lock);
 
@@ -1188,7 +1188,7 @@ static void ib_uverbs_free_hw_resources(struct ib_uverbs_device *uverbs_dev,
 		 */
 		mutex_unlock(&uverbs_dev->lists_mutex);
 
-		ib_uverbs_async_handler(READ_ONCE(file->async_file), 0,
+		ib_uverbs_async_handler(READ_ONCE(file->default_async_file), 0,
 					IB_EVENT_DEVICE_FATAL, NULL, NULL);
 
 		uverbs_destroy_ufile_hw(file, RDMA_REMOVE_DRIVER_REMOVE);
diff --git a/drivers/infiniband/core/uverbs_std_types_cq.c b/drivers/infiniband/core/uverbs_std_types_cq.c
index 47b98b0e1464..59617c8b88ea 100644
--- a/drivers/infiniband/core/uverbs_std_types_cq.c
+++ b/drivers/infiniband/core/uverbs_std_types_cq.c
@@ -100,6 +100,10 @@ static int UVERBS_HANDLER(UVERBS_METHOD_CQ_CREATE)(
 		uverbs_uobject_get(ev_file_uobj);
 	}
 
+	obj->uevent.event_file = attrs->ufile->default_async_file;
+	if (obj->uevent.event_file)
+		uverbs_uobject_get(&obj->uevent.event_file->uobj);
+
 	if (attr.comp_vector >= attrs->ufile->device->num_comp_vectors) {
 		ret = -EINVAL;
 		goto err_event_file;
@@ -138,6 +142,8 @@ static int UVERBS_HANDLER(UVERBS_METHOD_CQ_CREATE)(
 err_free:
 	kfree(cq);
 err_event_file:
+	if (obj->uevent.event_file)
+		uverbs_uobject_put(&obj->uevent.event_file->uobj);
 	if (ev_file)
 		uverbs_uobject_put(ev_file_uobj);
 	return ret;
-- 
2.26.2

