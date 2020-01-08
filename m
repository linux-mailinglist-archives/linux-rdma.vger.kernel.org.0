Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74C9E134935
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jan 2020 18:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729760AbgAHRWh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Jan 2020 12:22:37 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:41822 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729766AbgAHRWh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Jan 2020 12:22:37 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from yishaih@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 8 Jan 2020 19:22:32 +0200
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [10.7.2.17])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 008HMWZM009634;
        Wed, 8 Jan 2020 19:22:32 +0200
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [127.0.0.1])
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8) with ESMTP id 008HMWmP009575;
        Wed, 8 Jan 2020 19:22:32 +0200
Received: (from yishaih@localhost)
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8/Submit) id 008HMWrd009574;
        Wed, 8 Jan 2020 19:22:32 +0200
From:   Yishai Hadas <yishaih@mellanox.com>
To:     linux-rdma@vger.kernel.org, jgg@mellanox.com, dledford@redhat.com
Cc:     yishaih@mellanox.com, maorg@mellanox.com, michaelgur@mellanox.com
Subject: [PATCH rdma-next 12/14] RDMA/core: Remove the ufile arg from rdma_alloc_begin_uobject
Date:   Wed,  8 Jan 2020 19:22:04 +0200
Message-Id: <1578504126-9400-13-git-send-email-yishaih@mellanox.com>
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1578504126-9400-1-git-send-email-yishaih@mellanox.com>
References: <1578504126-9400-1-git-send-email-yishaih@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

Now that all callers provide a non-NULL attrs the ufile is redundant.
Adjust things so that the context handling is done inside alloc_uobj,
and the ib_uverbs_get_ucontext_file() is avoided if we already have the
context.

Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/infiniband/core/rdma_core.c | 36 +++++++++++++++++++-----------------
 include/rdma/uverbs_std_types.h     |  3 +--
 include/rdma/uverbs_types.h         |  3 +--
 3 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/infiniband/core/rdma_core.c b/drivers/infiniband/core/rdma_core.c
index 8ad6883..f839b93 100644
--- a/drivers/infiniband/core/rdma_core.c
+++ b/drivers/infiniband/core/rdma_core.c
@@ -262,15 +262,20 @@ int __uobj_perform_destroy(const struct uverbs_api_object *obj, u32 id,
 }
 
 /* alloc_uobj must be undone by uverbs_destroy_uobject() */
-static struct ib_uobject *alloc_uobj(struct ib_uverbs_file *ufile,
+static struct ib_uobject *alloc_uobj(struct uverbs_attr_bundle *attrs,
 				     const struct uverbs_api_object *obj)
 {
+	struct ib_uverbs_file *ufile = attrs->ufile;
 	struct ib_uobject *uobj;
-	struct ib_ucontext *ucontext;
 
-	ucontext = ib_uverbs_get_ucontext_file(ufile);
-	if (IS_ERR(ucontext))
-		return ERR_CAST(ucontext);
+	if (!attrs->context) {
+		struct ib_ucontext *ucontext =
+			ib_uverbs_get_ucontext_file(ufile);
+
+		if (IS_ERR(ucontext))
+			return ERR_CAST(ucontext);
+		attrs->context = ucontext;
+	}
 
 	uobj = kzalloc(obj->type_attrs->obj_size, GFP_KERNEL);
 	if (!uobj)
@@ -280,7 +285,7 @@ static struct ib_uobject *alloc_uobj(struct ib_uverbs_file *ufile,
 	 * The object is added to the list in the commit stage.
 	 */
 	uobj->ufile = ufile;
-	uobj->context = ucontext;
+	uobj->context = attrs->context;
 	INIT_LIST_HEAD(&uobj->list);
 	uobj->uapi_object = obj;
 	/*
@@ -423,12 +428,12 @@ struct ib_uobject *rdma_lookup_get_uobject(const struct uverbs_api_object *obj,
 
 static struct ib_uobject *
 alloc_begin_idr_uobject(const struct uverbs_api_object *obj,
-			struct ib_uverbs_file *ufile)
+			struct uverbs_attr_bundle *attrs)
 {
 	int ret;
 	struct ib_uobject *uobj;
 
-	uobj = alloc_uobj(ufile, obj);
+	uobj = alloc_uobj(attrs, obj);
 	if (IS_ERR(uobj))
 		return uobj;
 
@@ -444,7 +449,7 @@ struct ib_uobject *rdma_lookup_get_uobject(const struct uverbs_api_object *obj,
 	return uobj;
 
 remove:
-	xa_erase(&ufile->idr, uobj->id);
+	xa_erase(&attrs->ufile->idr, uobj->id);
 uobj_put:
 	uverbs_uobject_put(uobj);
 	return ERR_PTR(ret);
@@ -452,7 +457,7 @@ struct ib_uobject *rdma_lookup_get_uobject(const struct uverbs_api_object *obj,
 
 static struct ib_uobject *
 alloc_begin_fd_uobject(const struct uverbs_api_object *obj,
-		       struct ib_uverbs_file *ufile)
+		       struct uverbs_attr_bundle *attrs)
 {
 	const struct uverbs_obj_fd_type *fd_type =
 		container_of(obj->type_attrs, struct uverbs_obj_fd_type, type);
@@ -467,7 +472,7 @@ struct ib_uobject *rdma_lookup_get_uobject(const struct uverbs_api_object *obj,
 	if (new_fd < 0)
 		return ERR_PTR(new_fd);
 
-	uobj = alloc_uobj(ufile, obj);
+	uobj = alloc_uobj(attrs, obj);
 	if (IS_ERR(uobj))
 		goto err_fd;
 
@@ -481,7 +486,6 @@ struct ib_uobject *rdma_lookup_get_uobject(const struct uverbs_api_object *obj,
 	uobj->object = filp;
 
 	uobj->id = new_fd;
-	uobj->ufile = ufile;
 	return uobj;
 
 err_uobj:
@@ -492,9 +496,9 @@ struct ib_uobject *rdma_lookup_get_uobject(const struct uverbs_api_object *obj,
 }
 
 struct ib_uobject *rdma_alloc_begin_uobject(const struct uverbs_api_object *obj,
-					    struct ib_uverbs_file *ufile,
 					    struct uverbs_attr_bundle *attrs)
 {
+	struct ib_uverbs_file *ufile = attrs->ufile;
 	struct ib_uobject *ret;
 
 	if (IS_ERR(obj))
@@ -508,13 +512,11 @@ struct ib_uobject *rdma_alloc_begin_uobject(const struct uverbs_api_object *obj,
 	if (!down_read_trylock(&ufile->hw_destroy_rwsem))
 		return ERR_PTR(-EIO);
 
-	ret = obj->type_class->alloc_begin(obj, ufile);
+	ret = obj->type_class->alloc_begin(obj, attrs);
 	if (IS_ERR(ret)) {
 		up_read(&ufile->hw_destroy_rwsem);
 		return ret;
 	}
-	if (attrs)
-		attrs->context = ret->context;
 	return ret;
 }
 
@@ -949,7 +951,7 @@ struct ib_uobject *
 		return rdma_lookup_get_uobject(obj, attrs->ufile, id,
 					       UVERBS_LOOKUP_WRITE, attrs);
 	case UVERBS_ACCESS_NEW:
-		return rdma_alloc_begin_uobject(obj, attrs->ufile, attrs);
+		return rdma_alloc_begin_uobject(obj, attrs);
 	default:
 		WARN_ON(true);
 		return ERR_PTR(-EOPNOTSUPP);
diff --git a/include/rdma/uverbs_std_types.h b/include/rdma/uverbs_std_types.h
index c6bcaad..1b28ce1 100644
--- a/include/rdma/uverbs_std_types.h
+++ b/include/rdma/uverbs_std_types.h
@@ -114,8 +114,7 @@ static inline void uobj_alloc_abort(struct ib_uobject *uobj,
 __uobj_alloc(const struct uverbs_api_object *obj,
 	     struct uverbs_attr_bundle *attrs, struct ib_device **ib_dev)
 {
-	struct ib_uobject *uobj =
-		rdma_alloc_begin_uobject(obj, attrs->ufile, attrs);
+	struct ib_uobject *uobj = rdma_alloc_begin_uobject(obj, attrs);
 
 	if (!IS_ERR(uobj))
 		*ib_dev = attrs->context->device;
diff --git a/include/rdma/uverbs_types.h b/include/rdma/uverbs_types.h
index 0532588..ded608b 100644
--- a/include/rdma/uverbs_types.h
+++ b/include/rdma/uverbs_types.h
@@ -83,7 +83,7 @@ enum rdma_lookup_mode {
  */
 struct uverbs_obj_type_class {
 	struct ib_uobject *(*alloc_begin)(const struct uverbs_api_object *obj,
-					  struct ib_uverbs_file *ufile);
+					  struct uverbs_attr_bundle *attrs);
 	/* This consumes the kref on uobj */
 	void (*alloc_commit)(struct ib_uobject *uobj);
 	/* This does not consume the kref on uobj */
@@ -138,7 +138,6 @@ struct ib_uobject *rdma_lookup_get_uobject(const struct uverbs_api_object *obj,
 void rdma_lookup_put_uobject(struct ib_uobject *uobj,
 			     enum rdma_lookup_mode mode);
 struct ib_uobject *rdma_alloc_begin_uobject(const struct uverbs_api_object *obj,
-					    struct ib_uverbs_file *ufile,
 					    struct uverbs_attr_bundle *attrs);
 void rdma_alloc_abort_uobject(struct ib_uobject *uobj,
 			      struct uverbs_attr_bundle *attrs);
-- 
1.8.3.1

