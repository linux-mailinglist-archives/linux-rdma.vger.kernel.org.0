Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C45113493E
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jan 2020 18:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729756AbgAHRWk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Jan 2020 12:22:40 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:41797 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729748AbgAHRWi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Jan 2020 12:22:38 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from yishaih@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 8 Jan 2020 19:22:31 +0200
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [10.7.2.17])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 008HMVXZ009606;
        Wed, 8 Jan 2020 19:22:31 +0200
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [127.0.0.1])
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8) with ESMTP id 008HMVJL009539;
        Wed, 8 Jan 2020 19:22:31 +0200
Received: (from yishaih@localhost)
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8/Submit) id 008HMVEd009538;
        Wed, 8 Jan 2020 19:22:31 +0200
From:   Yishai Hadas <yishaih@mellanox.com>
To:     linux-rdma@vger.kernel.org, jgg@mellanox.com, dledford@redhat.com
Cc:     yishaih@mellanox.com, maorg@mellanox.com, michaelgur@mellanox.com
Subject: [PATCH rdma-next 04/14] RDMA/core: Do not allow alloc_commit to fail
Date:   Wed,  8 Jan 2020 19:21:56 +0200
Message-Id: <1578504126-9400-5-git-send-email-yishaih@mellanox.com>
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1578504126-9400-1-git-send-email-yishaih@mellanox.com>
References: <1578504126-9400-1-git-send-email-yishaih@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

This is a left over from an earlier version that creates a lot of
complexity for error unwind, particularly for FD uobjects.

The only reason this was done is so that anon_inode_get_file() could be
called with the final fops and a fully setup uobject. Both need to be
setup since unwinding anon_inode_get_file() via fput will call the
driver's release().

Now that the driver does not provide release, we no longer need to worry
about this complicated sequence, simply create the struct file at the
start and allow the core code's release function to deal with the abort
case.

This allows all the confusing error paths around commit to be removed.

Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/infiniband/core/rdma_core.c    | 116 +++++++++++++++------------------
 drivers/infiniband/core/rdma_core.h    |  21 +-----
 drivers/infiniband/core/uverbs_cmd.c   |  40 +++++++-----
 drivers/infiniband/core/uverbs_ioctl.c |  45 ++++---------
 include/rdma/uverbs_std_types.h        |  10 ---
 include/rdma/uverbs_types.h            |   6 +-
 6 files changed, 97 insertions(+), 141 deletions(-)

diff --git a/drivers/infiniband/core/rdma_core.c b/drivers/infiniband/core/rdma_core.c
index e8ee89d..8ad6883 100644
--- a/drivers/infiniband/core/rdma_core.c
+++ b/drivers/infiniband/core/rdma_core.c
@@ -136,7 +136,11 @@ static int uverbs_destroy_uobject(struct ib_uobject *uobj,
 	lockdep_assert_held(&ufile->hw_destroy_rwsem);
 	assert_uverbs_usecnt(uobj, UVERBS_LOOKUP_WRITE);
 
-	if (uobj->object) {
+	if (reason == RDMA_REMOVE_ABORT) {
+		WARN_ON(!list_empty(&uobj->list));
+		WARN_ON(!uobj->context);
+		uobj->uapi_object->type_class->alloc_abort(uobj);
+	} else if (uobj->object) {
 		ret = uobj->uapi_object->type_class->destroy_hw(uobj, reason,
 								attrs);
 		if (ret) {
@@ -152,12 +156,6 @@ static int uverbs_destroy_uobject(struct ib_uobject *uobj,
 		uobj->object = NULL;
 	}
 
-	if (reason == RDMA_REMOVE_ABORT) {
-		WARN_ON(!list_empty(&uobj->list));
-		WARN_ON(!uobj->context);
-		uobj->uapi_object->type_class->alloc_abort(uobj);
-	}
-
 	uobj->context = NULL;
 
 	/*
@@ -456,22 +454,40 @@ struct ib_uobject *rdma_lookup_get_uobject(const struct uverbs_api_object *obj,
 alloc_begin_fd_uobject(const struct uverbs_api_object *obj,
 		       struct ib_uverbs_file *ufile)
 {
+	const struct uverbs_obj_fd_type *fd_type =
+		container_of(obj->type_attrs, struct uverbs_obj_fd_type, type);
 	int new_fd;
 	struct ib_uobject *uobj;
+	struct file *filp;
+
+	if (WARN_ON(fd_type->fops->release != &uverbs_uobject_fd_release))
+		return ERR_PTR(-EINVAL);
 
 	new_fd = get_unused_fd_flags(O_CLOEXEC);
 	if (new_fd < 0)
 		return ERR_PTR(new_fd);
 
 	uobj = alloc_uobj(ufile, obj);
-	if (IS_ERR(uobj)) {
-		put_unused_fd(new_fd);
-		return uobj;
+	if (IS_ERR(uobj))
+		goto err_fd;
+
+	/* Note that uverbs_uobject_fd_release() is called during abort */
+	filp = anon_inode_getfile(fd_type->name, fd_type->fops, NULL,
+				  fd_type->flags);
+	if (IS_ERR(filp)) {
+		uobj = ERR_CAST(filp);
+		goto err_uobj;
 	}
+	uobj->object = filp;
 
 	uobj->id = new_fd;
 	uobj->ufile = ufile;
+	return uobj;
 
+err_uobj:
+	uverbs_uobject_put(uobj);
+err_fd:
+	put_unused_fd(new_fd);
 	return uobj;
 }
 
@@ -545,6 +561,9 @@ static void remove_handle_idr_uobject(struct ib_uobject *uobj)
 
 static void alloc_abort_fd_uobject(struct ib_uobject *uobj)
 {
+	struct file *filp = uobj->object;
+
+	fput(filp);
 	put_unused_fd(uobj->id);
 }
 
@@ -566,7 +585,7 @@ static void remove_handle_fd_uobject(struct ib_uobject *uobj)
 {
 }
 
-static int alloc_commit_idr_uobject(struct ib_uobject *uobj)
+static void alloc_commit_idr_uobject(struct ib_uobject *uobj)
 {
 	struct ib_uverbs_file *ufile = uobj->ufile;
 	void *old;
@@ -580,31 +599,12 @@ static int alloc_commit_idr_uobject(struct ib_uobject *uobj)
 	 */
 	old = xa_store(&ufile->idr, uobj->id, uobj, GFP_KERNEL);
 	WARN_ON(old != NULL);
-
-	return 0;
 }
 
-static int alloc_commit_fd_uobject(struct ib_uobject *uobj)
+static void alloc_commit_fd_uobject(struct ib_uobject *uobj)
 {
-	const struct uverbs_obj_fd_type *fd_type = container_of(
-		uobj->uapi_object->type_attrs, struct uverbs_obj_fd_type, type);
 	int fd = uobj->id;
-	struct file *filp;
-
-	/*
-	 * The kref for uobj is moved into filp->private data and put in
-	 * uverbs_close_fd(). Once alloc_commit() succeeds
-	 * uverbs_uobject_fd_release() must be guaranteed to be called from
-	 * the provided fops release callback.
-	 */
-	filp = anon_inode_getfile(fd_type->name,
-				  fd_type->fops,
-				  uobj,
-				  fd_type->flags);
-	if (IS_ERR(filp))
-		return PTR_ERR(filp);
-
-	uobj->object = filp;
+	struct file *filp = uobj->object;
 
 	/* Matching put will be done in uverbs_uobject_fd_release() */
 	kref_get(&uobj->ufile->ref);
@@ -616,9 +616,8 @@ static int alloc_commit_fd_uobject(struct ib_uobject *uobj)
 	 * NOTE: Once we install the file we loose ownership of our kref on
 	 * uobj. It will be put by uverbs_uobject_fd_release()
 	 */
+	filp->private_data = uobj;
 	fd_install(fd, filp);
-
-	return 0;
 }
 
 /*
@@ -626,19 +625,13 @@ static int alloc_commit_fd_uobject(struct ib_uobject *uobj)
  * caller can no longer assume uobj is valid. If this function fails it
  * destroys the uboject, including the attached HW object.
  */
-int __must_check rdma_alloc_commit_uobject(struct ib_uobject *uobj,
-					   struct uverbs_attr_bundle *attrs)
+void rdma_alloc_commit_uobject(struct ib_uobject *uobj,
+			       struct uverbs_attr_bundle *attrs)
 {
 	struct ib_uverbs_file *ufile = attrs->ufile;
-	int ret;
 
 	/* alloc_commit consumes the uobj kref */
-	ret = uobj->uapi_object->type_class->alloc_commit(uobj);
-	if (ret) {
-		uverbs_destroy_uobject(uobj, RDMA_REMOVE_ABORT, attrs);
-		up_read(&ufile->hw_destroy_rwsem);
-		return ret;
-	}
+	uobj->uapi_object->type_class->alloc_commit(uobj);
 
 	/* kref is held so long as the uobj is on the uobj list. */
 	uverbs_uobject_get(uobj);
@@ -651,8 +644,6 @@ int __must_check rdma_alloc_commit_uobject(struct ib_uobject *uobj,
 
 	/* Matches the down_read in rdma_alloc_begin_uobject */
 	up_read(&ufile->hw_destroy_rwsem);
-
-	return 0;
 }
 
 /*
@@ -664,7 +655,6 @@ void rdma_alloc_abort_uobject(struct ib_uobject *uobj,
 {
 	struct ib_uverbs_file *ufile = uobj->ufile;
 
-	uobj->object = NULL;
 	uverbs_destroy_uobject(uobj, RDMA_REMOVE_ABORT, attrs);
 
 	/* Matches the down_read in rdma_alloc_begin_uobject */
@@ -771,14 +761,21 @@ void release_ufile_idr_uobject(struct ib_uverbs_file *ufile)
  */
 int uverbs_uobject_fd_release(struct inode *inode, struct file *filp)
 {
-	struct ib_uobject *uobj = filp->private_data;
-	struct ib_uverbs_file *ufile = uobj->ufile;
-	struct uverbs_attr_bundle attrs = {
-		.context = uobj->context,
-		.ufile = ufile,
-	};
+	struct ib_uverbs_file *ufile;
+	struct ib_uobject *uobj;
+
+	/* This can only happen if the fput came from alloc_abort_fd_uobject() */
+	if (!filp->private_data)
+		return 0;
+	uobj = filp->private_data;
+	ufile = uobj->ufile;
 
 	if (down_read_trylock(&ufile->hw_destroy_rwsem)) {
+		struct uverbs_attr_bundle attrs = {
+			.context = uobj->context,
+			.ufile = ufile,
+		};
+
 		/*
 		 * lookup_get_fd_uobject holds the kref on the struct file any
 		 * time a FD uobj is locked, which prevents this release
@@ -790,7 +787,7 @@ int uverbs_uobject_fd_release(struct inode *inode, struct file *filp)
 		up_read(&ufile->hw_destroy_rwsem);
 	}
 
-	/* Matches the get in alloc_begin_fd_uobject */
+	/* Matches the get in alloc_commit_fd_uobject() */
 	kref_put(&ufile->ref, ib_uverbs_release_file);
 
 	/* Pairs with filp->private_data in alloc_begin_fd_uobject */
@@ -959,12 +956,10 @@ struct ib_uobject *
 	}
 }
 
-int uverbs_finalize_object(struct ib_uobject *uobj,
-			   enum uverbs_obj_access access, bool commit,
-			   struct uverbs_attr_bundle *attrs)
+void uverbs_finalize_object(struct ib_uobject *uobj,
+			    enum uverbs_obj_access access, bool commit,
+			    struct uverbs_attr_bundle *attrs)
 {
-	int ret = 0;
-
 	/*
 	 * refcounts should be handled at the object level and not at the
 	 * uobject level. Refcounts of the objects themselves are done in
@@ -984,14 +979,11 @@ int uverbs_finalize_object(struct ib_uobject *uobj,
 		break;
 	case UVERBS_ACCESS_NEW:
 		if (commit)
-			ret = rdma_alloc_commit_uobject(uobj, attrs);
+			rdma_alloc_commit_uobject(uobj, attrs);
 		else
 			rdma_alloc_abort_uobject(uobj, attrs);
 		break;
 	default:
 		WARN_ON(true);
-		ret = -EOPNOTSUPP;
 	}
-
-	return ret;
 }
diff --git a/drivers/infiniband/core/rdma_core.h b/drivers/infiniband/core/rdma_core.h
index 9269425..29f905e 100644
--- a/drivers/infiniband/core/rdma_core.h
+++ b/drivers/infiniband/core/rdma_core.h
@@ -63,24 +63,9 @@ struct ib_uobject *
 uverbs_get_uobject_from_file(u16 object_id, enum uverbs_obj_access access,
 			     s64 id, struct uverbs_attr_bundle *attrs);
 
-/*
- * Note that certain finalize stages could return a status:
- *   (a) alloc_commit could return a failure if the object is committed at the
- *       same time when the context is destroyed.
- *   (b) remove_commit could fail if the object wasn't destroyed successfully.
- * Since multiple objects could be finalized in one transaction, it is very NOT
- * recommended to have several finalize actions which have side effects.
- * For example, it's NOT recommended to have a certain action which has both
- * a commit action and a destroy action or two destroy objects in the same
- * action. The rule of thumb is to have one destroy or commit action with
- * multiple lookups.
- * The first non zero return value of finalize_object is returned from this
- * function. For example, this could happen when we couldn't destroy an
- * object.
- */
-int uverbs_finalize_object(struct ib_uobject *uobj,
-			   enum uverbs_obj_access access, bool commit,
-			   struct uverbs_attr_bundle *attrs);
+void uverbs_finalize_object(struct ib_uobject *uobj,
+			    enum uverbs_obj_access access, bool commit,
+			    struct uverbs_attr_bundle *attrs);
 
 int uverbs_output_written(const struct uverbs_attr_bundle *bundle, size_t idx);
 
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 06ed32c..74f6ae4 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -446,7 +446,8 @@ static int ib_uverbs_alloc_pd(struct uverbs_attr_bundle *attrs)
 	if (ret)
 		goto err_copy;
 
-	return uobj_alloc_commit(uobj, attrs);
+	rdma_alloc_commit_uobject(uobj, attrs);
+	return 0;
 
 err_copy:
 	ib_dealloc_pd_user(pd, uverbs_get_cleared_udata(attrs));
@@ -642,7 +643,8 @@ static int ib_uverbs_open_xrcd(struct uverbs_attr_bundle *attrs)
 
 	mutex_unlock(&ibudev->xrcd_tree_mutex);
 
-	return uobj_alloc_commit(&obj->uobject, attrs);
+	rdma_alloc_commit_uobject(&obj->uobject, attrs);
+	return 0;
 
 err_copy:
 	if (inode) {
@@ -774,7 +776,8 @@ static int ib_uverbs_reg_mr(struct uverbs_attr_bundle *attrs)
 
 	uobj_put_obj_read(pd);
 
-	return uobj_alloc_commit(uobj, attrs);
+	rdma_alloc_commit_uobject(uobj, attrs);
+	return 0;
 
 err_copy:
 	ib_dereg_mr_user(mr, uverbs_get_cleared_udata(attrs));
@@ -928,7 +931,8 @@ static int ib_uverbs_alloc_mw(struct uverbs_attr_bundle *attrs)
 		goto err_copy;
 
 	uobj_put_obj_read(pd);
-	return uobj_alloc_commit(uobj, attrs);
+	rdma_alloc_commit_uobject(uobj, attrs);
+	return 0;
 
 err_copy:
 	uverbs_dealloc_mw(mw);
@@ -980,7 +984,8 @@ static int ib_uverbs_create_comp_channel(struct uverbs_attr_bundle *attrs)
 		return ret;
 	}
 
-	return uobj_alloc_commit(uobj, attrs);
+	rdma_alloc_commit_uobject(uobj, attrs);
+	return 0;
 }
 
 static struct ib_ucq_object *create_cq(struct uverbs_attr_bundle *attrs,
@@ -1049,9 +1054,7 @@ static struct ib_ucq_object *create_cq(struct uverbs_attr_bundle *attrs,
 	if (ret)
 		goto err_cb;
 
-	ret = uobj_alloc_commit(&obj->uobject, attrs);
-	if (ret)
-		return ERR_PTR(ret);
+	rdma_alloc_commit_uobject(&obj->uobject, attrs);
 	return obj;
 
 err_cb:
@@ -1491,7 +1494,8 @@ static int create_qp(struct uverbs_attr_bundle *attrs,
 	if (ind_tbl)
 		uobj_put_obj_read(ind_tbl);
 
-	return uobj_alloc_commit(&obj->uevent.uobject, attrs);
+	rdma_alloc_commit_uobject(&obj->uevent.uobject, attrs);
+	return 0;
 err_cb:
 	ib_destroy_qp_user(qp, uverbs_get_cleared_udata(attrs));
 
@@ -1623,7 +1627,8 @@ static int ib_uverbs_open_qp(struct uverbs_attr_bundle *attrs)
 	qp->uobject = &obj->uevent.uobject;
 	uobj_put_read(xrcd_uobj);
 
-	return uobj_alloc_commit(&obj->uevent.uobject, attrs);
+	rdma_alloc_commit_uobject(&obj->uevent.uobject, attrs);
+	return 0;
 
 err_destroy:
 	ib_destroy_qp_user(qp, uverbs_get_cleared_udata(attrs));
@@ -2465,7 +2470,8 @@ static int ib_uverbs_create_ah(struct uverbs_attr_bundle *attrs)
 		goto err_copy;
 
 	uobj_put_obj_read(pd);
-	return uobj_alloc_commit(uobj, attrs);
+	rdma_alloc_commit_uobject(uobj, attrs);
+	return 0;
 
 err_copy:
 	rdma_destroy_ah_user(ah, RDMA_DESTROY_AH_SLEEPABLE,
@@ -2977,7 +2983,8 @@ static int ib_uverbs_ex_create_wq(struct uverbs_attr_bundle *attrs)
 
 	uobj_put_obj_read(pd);
 	uobj_put_obj_read(cq);
-	return uobj_alloc_commit(&obj->uevent.uobject, attrs);
+	rdma_alloc_commit_uobject(&obj->uevent.uobject, attrs);
+	return 0;
 
 err_copy:
 	ib_destroy_wq(wq, uverbs_get_cleared_udata(attrs));
@@ -3151,7 +3158,8 @@ static int ib_uverbs_ex_create_rwq_ind_table(struct uverbs_attr_bundle *attrs)
 	for (j = 0; j < num_read_wqs; j++)
 		uobj_put_obj_read(wqs[j]);
 
-	return uobj_alloc_commit(uobj, attrs);
+	rdma_alloc_commit_uobject(uobj, attrs);
+	return 0;
 
 err_copy:
 	ib_destroy_rwq_ind_table(rwq_ind_tbl);
@@ -3329,7 +3337,8 @@ static int ib_uverbs_ex_create_flow(struct uverbs_attr_bundle *attrs)
 	kfree(flow_attr);
 	if (cmd.flow_attr.num_of_specs)
 		kfree(kern_flow_attr);
-	return uobj_alloc_commit(uobj, attrs);
+	rdma_alloc_commit_uobject(uobj, attrs);
+	return 0;
 err_copy:
 	if (!qp->device->ops.destroy_flow(flow_id))
 		atomic_dec(&qp->usecnt);
@@ -3477,7 +3486,8 @@ static int __uverbs_create_xsrq(struct uverbs_attr_bundle *attrs,
 		uobj_put_obj_read(attr.ext.cq);
 
 	uobj_put_obj_read(pd);
-	return uobj_alloc_commit(&obj->uevent.uobject, attrs);
+	rdma_alloc_commit_uobject(&obj->uevent.uobject, attrs);
+	return 0;
 
 err_copy:
 	ib_destroy_srq_user(srq, uverbs_get_cleared_udata(attrs));
diff --git a/drivers/infiniband/core/uverbs_ioctl.c b/drivers/infiniband/core/uverbs_ioctl.c
index 269938f..538affb 100644
--- a/drivers/infiniband/core/uverbs_ioctl.c
+++ b/drivers/infiniband/core/uverbs_ioctl.c
@@ -220,24 +220,17 @@ static int uverbs_process_idrs_array(struct bundle_priv *pbundle,
 	return ret;
 }
 
-static int uverbs_free_idrs_array(const struct uverbs_api_attr *attr_uapi,
-				  struct uverbs_objs_arr_attr *attr,
-				  bool commit, struct uverbs_attr_bundle *attrs)
+static void uverbs_free_idrs_array(const struct uverbs_api_attr *attr_uapi,
+				   struct uverbs_objs_arr_attr *attr,
+				   bool commit,
+				   struct uverbs_attr_bundle *attrs)
 {
 	const struct uverbs_attr_spec *spec = &attr_uapi->spec;
-	int current_ret;
-	int ret = 0;
 	size_t i;
 
-	for (i = 0; i != attr->len; i++) {
-		current_ret = uverbs_finalize_object(attr->uobjects[i],
-						     spec->u2.objs_arr.access,
-						     commit, attrs);
-		if (!ret)
-			ret = current_ret;
-	}
-
-	return ret;
+	for (i = 0; i != attr->len; i++)
+		uverbs_finalize_object(attr->uobjects[i],
+				       spec->u2.objs_arr.access, commit, attrs);
 }
 
 static int uverbs_process_attr(struct bundle_priv *pbundle,
@@ -495,26 +488,22 @@ static int ib_uverbs_run_method(struct bundle_priv *pbundle,
 	return ret;
 }
 
-static int bundle_destroy(struct bundle_priv *pbundle, bool commit)
+static void bundle_destroy(struct bundle_priv *pbundle, bool commit)
 {
 	unsigned int key_bitmap_len = pbundle->method_elm->key_bitmap_len;
 	struct bundle_alloc_head *memblock;
 	unsigned int i;
-	int ret = 0;
 
 	/* fast path for simple uobjects */
 	i = -1;
 	while ((i = find_next_bit(pbundle->uobj_finalize, key_bitmap_len,
 				  i + 1)) < key_bitmap_len) {
 		struct uverbs_attr *attr = &pbundle->bundle.attrs[i];
-		int current_ret;
 
-		current_ret = uverbs_finalize_object(
+		uverbs_finalize_object(
 			attr->obj_attr.uobject,
 			attr->obj_attr.attr_elm->spec.u.obj.access, commit,
 			&pbundle->bundle);
-		if (!ret)
-			ret = current_ret;
 	}
 
 	i = -1;
@@ -523,7 +512,6 @@ static int bundle_destroy(struct bundle_priv *pbundle, bool commit)
 		struct uverbs_attr *attr = &pbundle->bundle.attrs[i];
 		const struct uverbs_api_attr *attr_uapi;
 		void __rcu **slot;
-		int current_ret;
 
 		slot = uapi_get_attr_for_method(
 			pbundle,
@@ -534,11 +522,8 @@ static int bundle_destroy(struct bundle_priv *pbundle, bool commit)
 		attr_uapi = rcu_dereference_protected(*slot, true);
 
 		if (attr_uapi->spec.type == UVERBS_ATTR_TYPE_IDRS_ARRAY) {
-			current_ret = uverbs_free_idrs_array(
-				attr_uapi, &attr->objs_arr_attr, commit,
-				&pbundle->bundle);
-			if (!ret)
-				ret = current_ret;
+			uverbs_free_idrs_array(attr_uapi, &attr->objs_arr_attr,
+					       commit, &pbundle->bundle);
 		}
 	}
 
@@ -548,8 +533,6 @@ static int bundle_destroy(struct bundle_priv *pbundle, bool commit)
 		memblock = memblock->next;
 		kvfree(tmp);
 	}
-
-	return ret;
 }
 
 static int ib_uverbs_cmd_verbs(struct ib_uverbs_file *ufile,
@@ -562,7 +545,6 @@ static int ib_uverbs_cmd_verbs(struct ib_uverbs_file *ufile,
 	struct bundle_priv *pbundle;
 	struct bundle_priv onstack;
 	void __rcu **slot;
-	int destroy_ret;
 	int ret;
 
 	if (unlikely(hdr->driver_id != uapi->driver_id))
@@ -610,10 +592,7 @@ static int ib_uverbs_cmd_verbs(struct ib_uverbs_file *ufile,
 	memset(pbundle->spec_finalize, 0, sizeof(pbundle->spec_finalize));
 
 	ret = ib_uverbs_run_method(pbundle, hdr->num_attrs);
-	destroy_ret = bundle_destroy(pbundle, ret == 0);
-	if (unlikely(destroy_ret && !ret))
-		return destroy_ret;
-
+	bundle_destroy(pbundle, ret == 0);
 	return ret;
 }
 
diff --git a/include/rdma/uverbs_std_types.h b/include/rdma/uverbs_std_types.h
index 05eabfd..c6bcaad 100644
--- a/include/rdma/uverbs_std_types.h
+++ b/include/rdma/uverbs_std_types.h
@@ -104,16 +104,6 @@ static inline void uobj_put_write(struct ib_uobject *uobj)
 	rdma_lookup_put_uobject(uobj, UVERBS_LOOKUP_WRITE);
 }
 
-static inline int __must_check
-uobj_alloc_commit(struct ib_uobject *uobj, struct uverbs_attr_bundle *attrs)
-{
-	int ret = rdma_alloc_commit_uobject(uobj, attrs);
-
-	if (ret)
-		return ret;
-	return 0;
-}
-
 static inline void uobj_alloc_abort(struct ib_uobject *uobj,
 				    struct uverbs_attr_bundle *attrs)
 {
diff --git a/include/rdma/uverbs_types.h b/include/rdma/uverbs_types.h
index 657c313..0532588 100644
--- a/include/rdma/uverbs_types.h
+++ b/include/rdma/uverbs_types.h
@@ -85,7 +85,7 @@ struct uverbs_obj_type_class {
 	struct ib_uobject *(*alloc_begin)(const struct uverbs_api_object *obj,
 					  struct ib_uverbs_file *ufile);
 	/* This consumes the kref on uobj */
-	int (*alloc_commit)(struct ib_uobject *uobj);
+	void (*alloc_commit)(struct ib_uobject *uobj);
 	/* This does not consume the kref on uobj */
 	void (*alloc_abort)(struct ib_uobject *uobj);
 
@@ -142,8 +142,8 @@ struct ib_uobject *rdma_alloc_begin_uobject(const struct uverbs_api_object *obj,
 					    struct uverbs_attr_bundle *attrs);
 void rdma_alloc_abort_uobject(struct ib_uobject *uobj,
 			      struct uverbs_attr_bundle *attrs);
-int __must_check rdma_alloc_commit_uobject(struct ib_uobject *uobj,
-					   struct uverbs_attr_bundle *attrs);
+void rdma_alloc_commit_uobject(struct ib_uobject *uobj,
+			       struct uverbs_attr_bundle *attrs);
 
 /*
  * uverbs_uobject_get is called in order to increase the reference count on
-- 
1.8.3.1

