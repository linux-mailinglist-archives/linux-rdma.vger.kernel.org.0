Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E187B1C6A38
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2020 09:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbgEFHlP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 May 2020 03:41:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:39152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726897AbgEFHlP (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 6 May 2020 03:41:15 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF56A206E6;
        Wed,  6 May 2020 07:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588750874;
        bh=cjaApOfgUbV1WzFFys6DHazCfxwSR9iSW8Y2SrTdpIw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pK02tD2+ltTC2+ivKu8xq1mXGSRiukL2xWCfLGKTp1CSogZHk+MMh63c4wexXn4nc
         OqMhIQlQlZBT/07h/TOadub8Itksr+AOCcilqDHjuKJcH7l+BKTtUcMl41iSge0eLQ
         lawWXctqBH4NZYmpDXnFsG1dihiue2X/6Uzzl8Xs=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org, Yishai Hadas <yishaih@mellanox.com>
Subject: [PATCH rdma-next 5/9] RDMA/core: Consolidate ib_create_srq flows
Date:   Wed,  6 May 2020 10:40:45 +0300
Message-Id: <20200506074049.8347-6-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200506074049.8347-1-leon@kernel.org>
References: <20200506074049.8347-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

The uverbs layer largely duplicate the code in ib_create_srq(), with the
slight difference that it passes in a udata. Move all the code together
into ib_create_srq_user() and provide an inline for kernel users,
similar to other create calls.

Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/uverbs_cmd.c | 40 +++++-----------------------
 drivers/infiniband/core/verbs.c      | 29 +++++++++++++++-----
 include/rdma/ib_verbs.h              | 27 +++++++++----------
 3 files changed, 40 insertions(+), 56 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 4cdc9bebd114..d1971169d9b0 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -3462,38 +3462,15 @@ static int __uverbs_create_xsrq(struct uverbs_attr_bundle *attrs,
 	attr.attr.srq_limit = cmd->srq_limit;
 
 	INIT_LIST_HEAD(&obj->uevent.event_list);
+	obj->uevent.uobject.user_handle = cmd->user_handle;
 
-	srq = rdma_zalloc_drv_obj(ib_dev, ib_srq);
-	if (!srq) {
-		ret = -ENOMEM;
-		goto err_put;
-	}
-
-	srq->device        = pd->device;
-	srq->pd            = pd;
-	srq->srq_type	   = cmd->srq_type;
-	srq->uobject       = obj;
-	srq->event_handler = attr.event_handler;
-
-	ret = pd->device->ops.create_srq(srq, &attr, udata);
-	if (ret)
-		goto err_free;
-
-	if (ib_srq_has_cq(cmd->srq_type)) {
-		srq->ext.cq       = attr.ext.cq;
-		atomic_inc(&attr.ext.cq->usecnt);
-	}
-
-	if (cmd->srq_type == IB_SRQT_XRC) {
-		srq->ext.xrc.xrcd = attr.ext.xrc.xrcd;
-		atomic_inc(&attr.ext.xrc.xrcd->usecnt);
+	srq = ib_create_srq_user(pd, &attr, obj, udata);
+	if (IS_ERR(srq)) {
+		ret = PTR_ERR(srq);
+		goto err_put_pd;
 	}
 
-	atomic_inc(&pd->usecnt);
-	atomic_set(&srq->usecnt, 0);
-
 	obj->uevent.uobject.object = srq;
-	obj->uevent.uobject.user_handle = cmd->user_handle;
 	obj->uevent.event_file = attrs->ufile->default_async_file;
 	if (obj->uevent.event_file)
 		uverbs_uobject_get(&obj->uevent.event_file->uobj);
@@ -3524,13 +3501,8 @@ static int __uverbs_create_xsrq(struct uverbs_attr_bundle *attrs,
 	if (obj->uevent.event_file)
 		uverbs_uobject_put(&obj->uevent.event_file->uobj);
 	ib_destroy_srq_user(srq, uverbs_get_cleared_udata(attrs));
-	/* It was released in ib_destroy_srq_user */
-	srq = NULL;
-err_free:
-	kfree(srq);
-err_put:
+err_put_pd:
 	uobj_put_obj_read(pd);
-
 err_put_cq:
 	if (ib_srq_has_cq(cmd->srq_type))
 		rdma_lookup_put_uobject(&attr.ext.cq->uobject->uevent.uobject,
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index bf0249f76ae9..e2c9430a3ff1 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -981,15 +981,29 @@ EXPORT_SYMBOL(rdma_destroy_ah_user);
 
 /* Shared receive queues */
 
-struct ib_srq *ib_create_srq(struct ib_pd *pd,
-			     struct ib_srq_init_attr *srq_init_attr)
+/**
+ * ib_create_srq_user - Creates a SRQ associated with the specified protection
+ *   domain.
+ * @pd: The protection domain associated with the SRQ.
+ * @srq_init_attr: A list of initial attributes required to create the
+ *   SRQ.  If SRQ creation succeeds, then the attributes are updated to
+ *   the actual capabilities of the created SRQ.
+ * @uobject - uobject pointer if this is not a kernel SRQ
+ * @udata - udata pointer if this is not a kernel SRQ
+ *
+ * srq_attr->max_wr and srq_attr->max_sge are read the determine the
+ * requested size of the SRQ, and set to the actual values allocated
+ * on return.  If ib_create_srq() succeeds, then max_wr and max_sge
+ * will always be at least as large as the requested values.
+ */
+struct ib_srq *ib_create_srq_user(struct ib_pd *pd,
+				  struct ib_srq_init_attr *srq_init_attr,
+				  struct ib_usrq_object *uobject,
+				  struct ib_udata *udata)
 {
 	struct ib_srq *srq;
 	int ret;
 
-	if (!pd->device->ops.create_srq)
-		return ERR_PTR(-EOPNOTSUPP);
-
 	srq = rdma_zalloc_drv_obj(pd->device, ib_srq);
 	if (!srq)
 		return ERR_PTR(-ENOMEM);
@@ -999,6 +1013,7 @@ struct ib_srq *ib_create_srq(struct ib_pd *pd,
 	srq->event_handler = srq_init_attr->event_handler;
 	srq->srq_context = srq_init_attr->srq_context;
 	srq->srq_type = srq_init_attr->srq_type;
+	srq->uobject = uobject;
 
 	if (ib_srq_has_cq(srq->srq_type)) {
 		srq->ext.cq = srq_init_attr->ext.cq;
@@ -1010,7 +1025,7 @@ struct ib_srq *ib_create_srq(struct ib_pd *pd,
 	}
 	atomic_inc(&pd->usecnt);
 
-	ret = pd->device->ops.create_srq(srq, srq_init_attr, NULL);
+	ret = pd->device->ops.create_srq(srq, srq_init_attr, udata);
 	if (ret) {
 		atomic_dec(&srq->pd->usecnt);
 		if (srq->srq_type == IB_SRQT_XRC)
@@ -1023,7 +1038,7 @@ struct ib_srq *ib_create_srq(struct ib_pd *pd,
 
 	return srq;
 }
-EXPORT_SYMBOL(ib_create_srq);
+EXPORT_SYMBOL(ib_create_srq_user);
 
 int ib_modify_srq(struct ib_srq *srq,
 		  struct ib_srq_attr *srq_attr,
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 40f304bc199c..b8b5b5310529 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -3564,21 +3564,18 @@ static inline int rdma_destroy_ah(struct ib_ah *ah, u32 flags)
 	return rdma_destroy_ah_user(ah, flags, NULL);
 }
 
-/**
- * ib_create_srq - Creates a SRQ associated with the specified protection
- *   domain.
- * @pd: The protection domain associated with the SRQ.
- * @srq_init_attr: A list of initial attributes required to create the
- *   SRQ.  If SRQ creation succeeds, then the attributes are updated to
- *   the actual capabilities of the created SRQ.
- *
- * srq_attr->max_wr and srq_attr->max_sge are read the determine the
- * requested size of the SRQ, and set to the actual values allocated
- * on return.  If ib_create_srq() succeeds, then max_wr and max_sge
- * will always be at least as large as the requested values.
- */
-struct ib_srq *ib_create_srq(struct ib_pd *pd,
-			     struct ib_srq_init_attr *srq_init_attr);
+struct ib_srq *ib_create_srq_user(struct ib_pd *pd,
+				  struct ib_srq_init_attr *srq_init_attr,
+				  struct ib_usrq_object *uobject,
+				  struct ib_udata *udata);
+static inline struct ib_srq *
+ib_create_srq(struct ib_pd *pd, struct ib_srq_init_attr *srq_init_attr)
+{
+	if (!pd->device->ops.create_srq)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	return ib_create_srq_user(pd, srq_init_attr, NULL, NULL);
+}
 
 /**
  * ib_modify_srq - Modifies the attributes for the specified SRQ.
-- 
2.26.2

