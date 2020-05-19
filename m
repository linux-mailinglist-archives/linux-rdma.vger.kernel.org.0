Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B86751D90FA
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2020 09:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgESH1W (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 May 2020 03:27:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:52482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728260AbgESH1W (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 19 May 2020 03:27:22 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC8B220709;
        Tue, 19 May 2020 07:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589873241;
        bh=+bb7IRu7uveat58up6DTIkeQjWkaLqaiWcnCyiQXvrA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UkuOuLExzspBCOuQtYQFnNyJbD9F3hR7/4+sAmxgnHucKHfKg2U1F8ydR4pUptflc
         BiiePBIOq1jg2yj0MLToFWGL5cLEbgY7tmP2I1IfrsRKOcyrzTFr24dwZCp7606/0b
         +J35i5HsHlDl0OZfMI8oF5CKDaDs6nGP7SHSA/SM=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org, Yishai Hadas <yishaih@mellanox.com>
Subject: [PATCH rdma-next v2 1/7] RDMA/core: Allow the ioctl layer to abort a fully created uobject
Date:   Tue, 19 May 2020 10:27:05 +0300
Message-Id: <20200519072711.257271-2-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200519072711.257271-1-leon@kernel.org>
References: <20200519072711.257271-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

While creating a uobject every create reaches a point where the uobject is
fully initialized. For ioctls that go on to copy_to_user this means they
need to open code the destruction of a fully created uobject - ie the
RDMA_REMOVE_DESTROY sort of flow.

Open coding this creates bugs, eg the CQ does not properly flush the
events list when it does its error unwind.

Provide a uverbs_finalize_uobj_create() function which indicates that the
uobject is fully initialized and that abort should call to destroy_hw to
destroy the uobj->object and related.

Methods can call this function if they go on to have error cases after
setting uobj->object. Once done those error cases can simply do return,
without an error unwind.

Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/rdma_core.c           | 25 +++++++++++++++----
 drivers/infiniband/core/rdma_core.h           |  4 +--
 drivers/infiniband/core/uverbs_cmd.c          |  2 +-
 drivers/infiniband/core/uverbs_ioctl.c        | 22 ++++++++++++++--
 drivers/infiniband/core/uverbs_std_types_cq.c |  8 ++----
 drivers/infiniband/core/uverbs_std_types_mr.c | 12 +++------
 drivers/infiniband/hw/mlx5/devx.c             | 10 +++-----
 drivers/infiniband/hw/mlx5/main.c             | 24 +++++-------------
 drivers/infiniband/hw/mlx5/qos.c              | 13 ++++------
 include/rdma/ib_verbs.h                       |  5 ++++
 include/rdma/uverbs_ioctl.h                   |  3 +++
 include/rdma/uverbs_std_types.h               |  2 +-
 include/rdma/uverbs_types.h                   |  3 ++-
 13 files changed, 74 insertions(+), 59 deletions(-)

diff --git a/drivers/infiniband/core/rdma_core.c b/drivers/infiniband/core/rdma_core.c
index 5128cb16bb48..ed34e6ba22e8 100644
--- a/drivers/infiniband/core/rdma_core.c
+++ b/drivers/infiniband/core/rdma_core.c
@@ -130,6 +130,17 @@ static int uverbs_destroy_uobject(struct ib_uobject *uobj,
 	lockdep_assert_held(&ufile->hw_destroy_rwsem);
 	assert_uverbs_usecnt(uobj, UVERBS_LOOKUP_WRITE);
 
+	if (reason == RDMA_REMOVE_ABORT_HWOBJ) {
+		reason = RDMA_REMOVE_ABORT;
+		ret = uobj->uapi_object->type_class->destroy_hw(uobj, reason,
+								attrs);
+		/*
+		 * Drivers are not permitted to ignore RDMA_REMOVE_ABORT, see
+		 * ib_is_destroy_retryable, cleanup_retryable == false here.
+		 */
+		WARN_ON(ret);
+	}
+
 	if (reason == RDMA_REMOVE_ABORT) {
 		WARN_ON(!list_empty(&uobj->list));
 		WARN_ON(!uobj->context);
@@ -647,11 +658,15 @@ void rdma_alloc_commit_uobject(struct ib_uobject *uobj,
  * object and anything else connected to uobj before calling this.
  */
 void rdma_alloc_abort_uobject(struct ib_uobject *uobj,
-			      struct uverbs_attr_bundle *attrs)
+			      struct uverbs_attr_bundle *attrs,
+			      bool hw_obj_valid)
 {
 	struct ib_uverbs_file *ufile = uobj->ufile;
 
-	uverbs_destroy_uobject(uobj, RDMA_REMOVE_ABORT, attrs);
+	uverbs_destroy_uobject(uobj,
+			       hw_obj_valid ? RDMA_REMOVE_ABORT_HWOBJ :
+					      RDMA_REMOVE_ABORT,
+			       attrs);
 
 	/* Matches the down_read in rdma_alloc_begin_uobject */
 	up_read(&ufile->hw_destroy_rwsem);
@@ -921,8 +936,8 @@ uverbs_get_uobject_from_file(u16 object_id, enum uverbs_obj_access access,
 }
 
 void uverbs_finalize_object(struct ib_uobject *uobj,
-			    enum uverbs_obj_access access, bool commit,
-			    struct uverbs_attr_bundle *attrs)
+			    enum uverbs_obj_access access, bool hw_obj_valid,
+			    bool commit, struct uverbs_attr_bundle *attrs)
 {
 	/*
 	 * refcounts should be handled at the object level and not at the
@@ -945,7 +960,7 @@ void uverbs_finalize_object(struct ib_uobject *uobj,
 		if (commit)
 			rdma_alloc_commit_uobject(uobj, attrs);
 		else
-			rdma_alloc_abort_uobject(uobj, attrs);
+			rdma_alloc_abort_uobject(uobj, attrs, hw_obj_valid);
 		break;
 	default:
 		WARN_ON(true);
diff --git a/drivers/infiniband/core/rdma_core.h b/drivers/infiniband/core/rdma_core.h
index 33978e0f1262..2b529233e159 100644
--- a/drivers/infiniband/core/rdma_core.h
+++ b/drivers/infiniband/core/rdma_core.h
@@ -64,8 +64,8 @@ uverbs_get_uobject_from_file(u16 object_id, enum uverbs_obj_access access,
 			     s64 id, struct uverbs_attr_bundle *attrs);
 
 void uverbs_finalize_object(struct ib_uobject *uobj,
-			    enum uverbs_obj_access access, bool commit,
-			    struct uverbs_attr_bundle *attrs);
+			    enum uverbs_obj_access access, bool hw_obj_valid,
+			    bool commit, struct uverbs_attr_bundle *attrs);
 
 int uverbs_output_written(const struct uverbs_attr_bundle *bundle, size_t idx);
 
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index d5642bcf93ee..86c97221872d 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -311,7 +311,7 @@ static int ib_uverbs_get_context(struct uverbs_attr_bundle *attrs)
 	return 0;
 
 err_uobj:
-	rdma_alloc_abort_uobject(uobj, attrs);
+	rdma_alloc_abort_uobject(uobj, attrs, false);
 err_ucontext:
 	kfree(attrs->context);
 	attrs->context = NULL;
diff --git a/drivers/infiniband/core/uverbs_ioctl.c b/drivers/infiniband/core/uverbs_ioctl.c
index 538affbc517e..42c5696f03bd 100644
--- a/drivers/infiniband/core/uverbs_ioctl.c
+++ b/drivers/infiniband/core/uverbs_ioctl.c
@@ -58,6 +58,7 @@ struct bundle_priv {
 
 	DECLARE_BITMAP(uobj_finalize, UVERBS_API_ATTR_BKEY_LEN);
 	DECLARE_BITMAP(spec_finalize, UVERBS_API_ATTR_BKEY_LEN);
+	DECLARE_BITMAP(uobj_hw_obj_valid, UVERBS_API_ATTR_BKEY_LEN);
 
 	/*
 	 * Must be last. bundle ends in a flex array which overlaps
@@ -230,7 +231,8 @@ static void uverbs_free_idrs_array(const struct uverbs_api_attr *attr_uapi,
 
 	for (i = 0; i != attr->len; i++)
 		uverbs_finalize_object(attr->uobjects[i],
-				       spec->u2.objs_arr.access, commit, attrs);
+				       spec->u2.objs_arr.access, false, commit,
+				       attrs);
 }
 
 static int uverbs_process_attr(struct bundle_priv *pbundle,
@@ -502,7 +504,9 @@ static void bundle_destroy(struct bundle_priv *pbundle, bool commit)
 
 		uverbs_finalize_object(
 			attr->obj_attr.uobject,
-			attr->obj_attr.attr_elm->spec.u.obj.access, commit,
+			attr->obj_attr.attr_elm->spec.u.obj.access,
+			test_bit(i, pbundle->uobj_hw_obj_valid),
+			commit,
 			&pbundle->bundle);
 	}
 
@@ -590,6 +594,8 @@ static int ib_uverbs_cmd_verbs(struct ib_uverbs_file *ufile,
 	       sizeof(pbundle->bundle.attr_present));
 	memset(pbundle->uobj_finalize, 0, sizeof(pbundle->uobj_finalize));
 	memset(pbundle->spec_finalize, 0, sizeof(pbundle->spec_finalize));
+	memset(pbundle->uobj_hw_obj_valid, 0,
+	       sizeof(pbundle->uobj_hw_obj_valid));
 
 	ret = ib_uverbs_run_method(pbundle, hdr->num_attrs);
 	bundle_destroy(pbundle, ret == 0);
@@ -784,3 +790,15 @@ int uverbs_copy_to_struct_or_zero(const struct uverbs_attr_bundle *bundle,
 	}
 	return uverbs_copy_to(bundle, idx, from, size);
 }
+
+/* Once called an abort will call through to the type's destroy_hw() */
+void uverbs_finalize_uobj_create(const struct uverbs_attr_bundle *bundle,
+				 u16 idx)
+{
+	struct bundle_priv *pbundle =
+		container_of(bundle, struct bundle_priv, bundle);
+
+	__set_bit(uapi_bkey_attr(uapi_key_attr(idx)),
+		  pbundle->uobj_hw_obj_valid);
+}
+EXPORT_SYMBOL(uverbs_finalize_uobj_create);
diff --git a/drivers/infiniband/core/uverbs_std_types_cq.c b/drivers/infiniband/core/uverbs_std_types_cq.c
index da4110a0eea2..73fbbeb2586c 100644
--- a/drivers/infiniband/core/uverbs_std_types_cq.c
+++ b/drivers/infiniband/core/uverbs_std_types_cq.c
@@ -129,16 +129,12 @@ static int UVERBS_HANDLER(UVERBS_METHOD_CQ_CREATE)(
 	obj->uevent.uobject.object = cq;
 	obj->uevent.uobject.user_handle = user_handle;
 	rdma_restrack_uadd(&cq->res);
+	uverbs_finalize_uobj_create(attrs, UVERBS_ATTR_CREATE_CQ_HANDLE);
 
 	ret = uverbs_copy_to(attrs, UVERBS_ATTR_CREATE_CQ_RESP_CQE, &cq->cqe,
 			     sizeof(cq->cqe));
-	if (ret)
-		goto err_cq;
+	return ret;
 
-	return 0;
-err_cq:
-	ib_destroy_cq_user(cq, uverbs_get_cleared_udata(attrs));
-	cq = NULL;
 err_free:
 	kfree(cq);
 err_event_file:
diff --git a/drivers/infiniband/core/uverbs_std_types_mr.c b/drivers/infiniband/core/uverbs_std_types_mr.c
index c1286a52dc84..a2722ef8496e 100644
--- a/drivers/infiniband/core/uverbs_std_types_mr.c
+++ b/drivers/infiniband/core/uverbs_std_types_mr.c
@@ -136,21 +136,15 @@ static int UVERBS_HANDLER(UVERBS_METHOD_DM_MR_REG)(
 
 	uobj->object = mr;
 
+	uverbs_finalize_uobj_create(attrs, UVERBS_ATTR_REG_DM_MR_HANDLE);
+
 	ret = uverbs_copy_to(attrs, UVERBS_ATTR_REG_DM_MR_RESP_LKEY, &mr->lkey,
 			     sizeof(mr->lkey));
 	if (ret)
-		goto err_dereg;
+		return ret;
 
 	ret = uverbs_copy_to(attrs, UVERBS_ATTR_REG_DM_MR_RESP_RKEY,
 			     &mr->rkey, sizeof(mr->rkey));
-	if (ret)
-		goto err_dereg;
-
-	return 0;
-
-err_dereg:
-	ib_dereg_mr_user(mr, uverbs_get_cleared_udata(attrs));
-
 	return ret;
 }
 
diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
index 1d7feed6d3cb..e11fa7cde254 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -2217,14 +2217,12 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_DEVX_UMEM_REG)(
 	obj->mdev = dev->mdev;
 	uobj->object = obj;
 	devx_obj_build_destroy_cmd(cmd.in, cmd.out, obj->dinbox, &obj->dinlen, &obj_id);
-	err = uverbs_copy_to(attrs, MLX5_IB_ATTR_DEVX_UMEM_REG_OUT_ID, &obj_id, sizeof(obj_id));
-	if (err)
-		goto err_umem_destroy;
+	uverbs_finalize_uobj_create(attrs, MLX5_IB_ATTR_DEVX_UMEM_REG_HANDLE);
 
-	return 0;
+	err = uverbs_copy_to(attrs, MLX5_IB_ATTR_DEVX_UMEM_REG_OUT_ID, &obj_id,
+			     sizeof(obj_id));
+	return err;
 
-err_umem_destroy:
-	mlx5_cmd_exec(obj->mdev, obj->dinbox, obj->dinlen, cmd.out, sizeof(cmd.out));
 err_umem_release:
 	ib_umem_release(obj->umem);
 err_obj_free:
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 26f0b39c7f74..623d7898ae6d 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -6187,26 +6187,20 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_VAR_OBJ_ALLOC)(
 	mmap_offset = mlx5_entry_to_mmap_offset(entry);
 	length = entry->rdma_entry.npages * PAGE_SIZE;
 	uobj->object = entry;
+	uverbs_finalize_uobj_create(attrs, MLX5_IB_ATTR_VAR_OBJ_ALLOC_HANDLE);
 
 	err = uverbs_copy_to(attrs, MLX5_IB_ATTR_VAR_OBJ_ALLOC_MMAP_OFFSET,
 			     &mmap_offset, sizeof(mmap_offset));
 	if (err)
-		goto err;
+		return err;
 
 	err = uverbs_copy_to(attrs, MLX5_IB_ATTR_VAR_OBJ_ALLOC_PAGE_ID,
 			     &entry->page_idx, sizeof(entry->page_idx));
 	if (err)
-		goto err;
+		return err;
 
 	err = uverbs_copy_to(attrs, MLX5_IB_ATTR_VAR_OBJ_ALLOC_MMAP_LENGTH,
 			     &length, sizeof(length));
-	if (err)
-		goto err;
-
-	return 0;
-
-err:
-	rdma_user_mmap_entry_remove(&entry->rdma_entry);
 	return err;
 }
 
@@ -6320,26 +6314,20 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_UAR_OBJ_ALLOC)(
 	mmap_offset = mlx5_entry_to_mmap_offset(entry);
 	length = entry->rdma_entry.npages * PAGE_SIZE;
 	uobj->object = entry;
+	uverbs_finalize_uobj_create(attrs, MLX5_IB_ATTR_UAR_OBJ_ALLOC_HANDLE);
 
 	err = uverbs_copy_to(attrs, MLX5_IB_ATTR_UAR_OBJ_ALLOC_MMAP_OFFSET,
 			     &mmap_offset, sizeof(mmap_offset));
 	if (err)
-		goto err;
+		return err;
 
 	err = uverbs_copy_to(attrs, MLX5_IB_ATTR_UAR_OBJ_ALLOC_PAGE_ID,
 			     &entry->page_idx, sizeof(entry->page_idx));
 	if (err)
-		goto err;
+		return err;
 
 	err = uverbs_copy_to(attrs, MLX5_IB_ATTR_UAR_OBJ_ALLOC_MMAP_LENGTH,
 			     &length, sizeof(length));
-	if (err)
-		goto err;
-
-	return 0;
-
-err:
-	rdma_user_mmap_entry_remove(&entry->rdma_entry);
 	return err;
 }
 
diff --git a/drivers/infiniband/hw/mlx5/qos.c b/drivers/infiniband/hw/mlx5/qos.c
index cac878a70edb..dce92554142a 100644
--- a/drivers/infiniband/hw/mlx5/qos.c
+++ b/drivers/infiniband/hw/mlx5/qos.c
@@ -69,17 +69,14 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_PP_OBJ_ALLOC)(
 	if (err)
 		goto err;
 
-	err = uverbs_copy_to(attrs, MLX5_IB_ATTR_PP_OBJ_ALLOC_INDEX,
-			     &pp_entry->index, sizeof(pp_entry->index));
-	if (err)
-		goto clean;
-
 	pp_entry->mdev = dev->mdev;
 	uobj->object = pp_entry;
-	return 0;
+	uverbs_finalize_uobj_create(attrs, MLX5_IB_ATTR_PP_OBJ_ALLOC_HANDLE);
+
+	err = uverbs_copy_to(attrs, MLX5_IB_ATTR_PP_OBJ_ALLOC_INDEX,
+			     &pp_entry->index, sizeof(pp_entry->index));
+	return err;
 
-clean:
-	mlx5_rl_remove_rate_raw(dev->mdev, pp_entry->index);
 err:
 	kfree(pp_entry);
 	return err;
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index db58f11552f1..b8b5b5310529 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1463,6 +1463,11 @@ enum rdma_remove_reason {
 	RDMA_REMOVE_DRIVER_REMOVE,
 	/* uobj is being cleaned-up before being committed */
 	RDMA_REMOVE_ABORT,
+	/*
+	 * uobj has been fully created, with the uobj->object set, but is being
+	 * cleaned up before being comitted
+	 */
+	RDMA_REMOVE_ABORT_HWOBJ,
 };
 
 struct ib_rdmacg_object {
diff --git a/include/rdma/uverbs_ioctl.h b/include/rdma/uverbs_ioctl.h
index 9f3b1e004046..5bd2b037e914 100644
--- a/include/rdma/uverbs_ioctl.h
+++ b/include/rdma/uverbs_ioctl.h
@@ -737,6 +737,9 @@ uverbs_attr_get_len(const struct uverbs_attr_bundle *attrs_bundle, u16 idx)
 	return attr->ptr_attr.len;
 }
 
+void uverbs_finalize_uobj_create(const struct uverbs_attr_bundle *attrs_bundle,
+				 u16 idx);
+
 /*
  * uverbs_attr_ptr_get_array_size() - Get array size pointer by a ptr
  * attribute.
diff --git a/include/rdma/uverbs_std_types.h b/include/rdma/uverbs_std_types.h
index 1b28ce1aba07..d6784be27e4b 100644
--- a/include/rdma/uverbs_std_types.h
+++ b/include/rdma/uverbs_std_types.h
@@ -107,7 +107,7 @@ static inline void uobj_put_write(struct ib_uobject *uobj)
 static inline void uobj_alloc_abort(struct ib_uobject *uobj,
 				    struct uverbs_attr_bundle *attrs)
 {
-	rdma_alloc_abort_uobject(uobj, attrs);
+	rdma_alloc_abort_uobject(uobj, attrs, false);
 }
 
 static inline struct ib_uobject *
diff --git a/include/rdma/uverbs_types.h b/include/rdma/uverbs_types.h
index f1cbdae67250..c15b298aa62f 100644
--- a/include/rdma/uverbs_types.h
+++ b/include/rdma/uverbs_types.h
@@ -139,7 +139,8 @@ void rdma_lookup_put_uobject(struct ib_uobject *uobj,
 struct ib_uobject *rdma_alloc_begin_uobject(const struct uverbs_api_object *obj,
 					    struct uverbs_attr_bundle *attrs);
 void rdma_alloc_abort_uobject(struct ib_uobject *uobj,
-			      struct uverbs_attr_bundle *attrs);
+			      struct uverbs_attr_bundle *attrs,
+			      bool hw_obj_valid);
 void rdma_alloc_commit_uobject(struct ib_uobject *uobj,
 			       struct uverbs_attr_bundle *attrs);
 
-- 
2.26.2

