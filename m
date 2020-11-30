Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8762C7F7B
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Nov 2020 09:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725894AbgK3IAI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Nov 2020 03:00:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:56696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbgK3IAI (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 30 Nov 2020 03:00:08 -0500
Received: from localhost (searspoint.nvidia.com [216.228.112.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF92C2086A;
        Mon, 30 Nov 2020 07:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606723144;
        bh=QGqaZp5LpmemBmY2V5aiwfmtvATDDVrnL+iCDiQd/0c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CyIOlTHvbxmoT/65+j1EZzB29BIuPGly0byYb8Iv5q+N/60rd7/9andblecCW+E3p
         SBfK9gOPuMLsbTz5oeOuObPzfIJW0ucy+GJrZYh7+ttKEyhygOuN+rQ4zKAMyTHAir
         dgdhiPpQvbAOKCsON4GwDY/Bi/gL/irB/S4gQFz8=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH rdma-next 3/5] RDMA/uverbs: Allow drivers to create a new HW object during rereg_mr
Date:   Mon, 30 Nov 2020 09:58:37 +0200
Message-Id: <20201130075839.278575-4-leon@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201130075839.278575-1-leon@kernel.org>
References: <20201130075839.278575-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>

mlx5 has an ugly flow where it tries to allocate a new MR and replace the
existing MR in the same memory during rereg. This is very complicated and
buggy. Instead of trying to replace in-place inside the driver, provide
support from uverbs to change the entire HW object assigned to a handle
during rereg_mr.

Since destroying a MR is allowed to fail (ie if a MW is pointing at it)
and can't be detected in advance, the algorithm creates a completely new
uobject to hold the new MR and swaps the IDR entries of the two objects.

The old MR in the temporary IDR entry is destroyed, and if it fails
rereg_mr succeeds and destruction is deferred to FD release. This
complexity is why this cannot live in a driver safely.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/rdma_core.c         | 51 +++++++++++++
 drivers/infiniband/core/uverbs_cmd.c        | 85 ++++++++++++++++-----
 drivers/infiniband/hw/hns/hns_roce_device.h |  7 +-
 drivers/infiniband/hw/hns/hns_roce_mr.c     | 15 ++--
 drivers/infiniband/hw/mlx4/mlx4_ib.h        |  8 +-
 drivers/infiniband/hw/mlx4/mr.c             | 16 ++--
 drivers/infiniband/hw/mlx5/mlx5_ib.h        |  6 +-
 drivers/infiniband/hw/mlx5/mr.c             | 15 ++--
 include/rdma/ib_verbs.h                     |  7 +-
 include/rdma/uverbs_types.h                 |  5 ++
 10 files changed, 160 insertions(+), 55 deletions(-)

diff --git a/drivers/infiniband/core/rdma_core.c b/drivers/infiniband/core/rdma_core.c
index 1b641106b29b..8440e34dfa01 100644
--- a/drivers/infiniband/core/rdma_core.c
+++ b/drivers/infiniband/core/rdma_core.c
@@ -595,6 +595,27 @@ static void alloc_commit_idr_uobject(struct ib_uobject *uobj)
 	WARN_ON(old != NULL);
 }

+static void swap_idr_uobjects(struct ib_uobject *obj_old,
+			     struct ib_uobject *obj_new)
+{
+	struct ib_uverbs_file *ufile = obj_old->ufile;
+	void *old;
+
+	/*
+	 * New must be an object that been allocated but not yet committed, this
+	 * moves the pre-committed state to obj_old, new still must be comitted.
+	 */
+	old = xa_cmpxchg(&ufile->idr, obj_old->id, obj_old, XA_ZERO_ENTRY,
+			 GFP_KERNEL);
+	if (WARN_ON(old != obj_old))
+		return;
+
+	swap(obj_old->id, obj_new->id);
+
+	old = xa_cmpxchg(&ufile->idr, obj_old->id, NULL, obj_old, GFP_KERNEL);
+	WARN_ON(old != NULL);
+}
+
 static void alloc_commit_fd_uobject(struct ib_uobject *uobj)
 {
 	int fd = uobj->id;
@@ -640,6 +661,35 @@ void rdma_alloc_commit_uobject(struct ib_uobject *uobj,
 	up_read(&ufile->hw_destroy_rwsem);
 }

+/*
+ * new_uobj will be assigned to the handle currently used by to_uobj, and
+ * to_uobj will be destroyed.
+ *
+ * Upon return the caller must do:
+ *    rdma_alloc_commit_uobject(new_uobj)
+ *    uobj_put_destroy(to_uobj)
+ *
+ * to_uobj must have a write get but the put mode switches to destroy once
+ * this is called.
+ */
+void rdma_assign_uobject(struct ib_uobject *to_uobj, struct ib_uobject *new_uobj,
+			struct uverbs_attr_bundle *attrs)
+{
+	assert_uverbs_usecnt(new_uobj, UVERBS_LOOKUP_WRITE);
+
+	if (WARN_ON(to_uobj->uapi_object != new_uobj->uapi_object ||
+		    !to_uobj->uapi_object->type_class->swap_uobjects))
+		return;
+
+	to_uobj->uapi_object->type_class->swap_uobjects(to_uobj, new_uobj);
+
+	/*
+	 * If this fails then the uobject is still completely valid (though with
+	 * a new ID) and we leak it until context close.
+	 */
+	uverbs_destroy_uobject(to_uobj, RDMA_REMOVE_DESTROY, attrs);
+}
+
 /*
  * This consumes the kref for uobj. It is up to the caller to unwind the HW
  * object and anything else connected to uobj before calling this.
@@ -747,6 +797,7 @@ const struct uverbs_obj_type_class uverbs_idr_class = {
 	.lookup_put = lookup_put_idr_uobject,
 	.destroy_hw = destroy_hw_idr_uobject,
 	.remove_handle = remove_handle_idr_uobject,
+	.swap_uobjects = swap_idr_uobjects,
 };
 EXPORT_SYMBOL(uverbs_idr_class);

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 291f7db6aa1e..10806f7c0bff 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -762,11 +762,14 @@ static int ib_uverbs_rereg_mr(struct uverbs_attr_bundle *attrs)
 {
 	struct ib_uverbs_rereg_mr      cmd;
 	struct ib_uverbs_rereg_mr_resp resp;
-	struct ib_pd                *pd = NULL;
 	struct ib_mr                *mr;
-	struct ib_pd		    *old_pd;
 	int                          ret;
 	struct ib_uobject	    *uobj;
+	struct ib_uobject *new_uobj;
+	struct ib_device *ib_dev;
+	struct ib_pd *orig_pd;
+	struct ib_pd *new_pd;
+	struct ib_mr *new_mr;

 	ret = uverbs_request(attrs, &cmd, sizeof(cmd));
 	if (ret)
@@ -799,31 +802,69 @@ static int ib_uverbs_rereg_mr(struct uverbs_attr_bundle *attrs)
 			goto put_uobjs;
 	}

+	orig_pd = mr->pd;
 	if (cmd.flags & IB_MR_REREG_PD) {
-		pd = uobj_get_obj_read(pd, UVERBS_OBJECT_PD, cmd.pd_handle,
-				       attrs);
-		if (!pd) {
+		new_pd = uobj_get_obj_read(pd, UVERBS_OBJECT_PD, cmd.pd_handle,
+					   attrs);
+		if (!new_pd) {
 			ret = -EINVAL;
 			goto put_uobjs;
 		}
+	} else {
+		new_pd = mr->pd;
 	}

-	old_pd = mr->pd;
-	ret = mr->device->ops.rereg_user_mr(mr, cmd.flags, cmd.start,
-					    cmd.length, cmd.hca_va,
-					    cmd.access_flags, pd,
-					    &attrs->driver_udata);
-	if (ret)
+	/*
+	 * The driver might create a new HW object as part of the rereg, we need
+	 * to have a uobject ready to hold it.
+	 */
+	new_uobj = uobj_alloc(UVERBS_OBJECT_MR, attrs, &ib_dev);
+	if (IS_ERR(new_uobj)) {
+		ret = PTR_ERR(new_uobj);
 		goto put_uobj_pd;
-
-	if (cmd.flags & IB_MR_REREG_PD) {
-		atomic_inc(&pd->usecnt);
-		mr->pd = pd;
-		atomic_dec(&old_pd->usecnt);
 	}

-	if (cmd.flags & IB_MR_REREG_TRANS)
-		mr->iova = cmd.hca_va;
+	new_mr = ib_dev->ops.rereg_user_mr(mr, cmd.flags, cmd.start, cmd.length,
+					   cmd.hca_va, cmd.access_flags, new_pd,
+					   &attrs->driver_udata);
+	if (IS_ERR(new_mr)) {
+		ret = PTR_ERR(new_mr);
+		goto put_new_uobj;
+	}
+	if (new_mr) {
+		new_mr->device = new_pd->device;
+		new_mr->pd = new_pd;
+		new_mr->type = IB_MR_TYPE_USER;
+		new_mr->dm = NULL;
+		new_mr->sig_attrs = NULL;
+		new_mr->uobject = uobj;
+		atomic_inc(&new_pd->usecnt);
+		new_mr->iova = cmd.hca_va;
+		new_uobj->object = new_mr;
+
+		rdma_restrack_new(&new_mr->res, RDMA_RESTRACK_MR);
+		rdma_restrack_set_name(&new_mr->res, NULL);
+		rdma_restrack_add(&new_mr->res);
+
+		/*
+		 * The new uobj for the new HW object is put into the same spot
+		 * in the IDR and the old uobj & HW object is deleted.
+		 */
+		rdma_assign_uobject(uobj, new_uobj, attrs);
+		rdma_alloc_commit_uobject(new_uobj, attrs);
+		uobj_put_destroy(uobj);
+		new_uobj = NULL;
+		uobj = NULL;
+		mr = new_mr;
+	} else {
+		if (cmd.flags & IB_MR_REREG_PD) {
+			atomic_dec(&orig_pd->usecnt);
+			mr->pd = new_pd;
+			atomic_inc(&new_pd->usecnt);
+		}
+		if (cmd.flags & IB_MR_REREG_TRANS)
+			mr->iova = cmd.hca_va;
+	}

 	memset(&resp, 0, sizeof(resp));
 	resp.lkey      = mr->lkey;
@@ -831,12 +872,16 @@ static int ib_uverbs_rereg_mr(struct uverbs_attr_bundle *attrs)

 	ret = uverbs_response(attrs, &resp, sizeof(resp));

+put_new_uobj:
+	if (new_uobj)
+		uobj_alloc_abort(new_uobj, attrs);
 put_uobj_pd:
 	if (cmd.flags & IB_MR_REREG_PD)
-		uobj_put_obj_read(pd);
+		uobj_put_obj_read(new_pd);

 put_uobjs:
-	uobj_put_write(uobj);
+	if (uobj)
+		uobj_put_write(uobj);

 	return ret;
 }
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 1c1deb4ff948..c9e4dd6c4bc7 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -1211,9 +1211,10 @@ struct ib_mr *hns_roce_get_dma_mr(struct ib_pd *pd, int acc);
 struct ib_mr *hns_roce_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 				   u64 virt_addr, int access_flags,
 				   struct ib_udata *udata);
-int hns_roce_rereg_user_mr(struct ib_mr *mr, int flags, u64 start, u64 length,
-			   u64 virt_addr, int mr_access_flags, struct ib_pd *pd,
-			   struct ib_udata *udata);
+struct ib_mr *hns_roce_rereg_user_mr(struct ib_mr *mr, int flags, u64 start,
+				     u64 length, u64 virt_addr,
+				     int mr_access_flags, struct ib_pd *pd,
+				     struct ib_udata *udata);
 struct ib_mr *hns_roce_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
 				u32 max_num_sg);
 int hns_roce_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg, int sg_nents,
diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index 87e2e6236c69..98671925debf 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -328,9 +328,10 @@ static int rereg_mr_trans(struct ib_mr *ibmr, int flags,
 	return ret;
 }

-int hns_roce_rereg_user_mr(struct ib_mr *ibmr, int flags, u64 start, u64 length,
-			   u64 virt_addr, int mr_access_flags, struct ib_pd *pd,
-			   struct ib_udata *udata)
+struct ib_mr *hns_roce_rereg_user_mr(struct ib_mr *ibmr, int flags, u64 start,
+				     u64 length, u64 virt_addr,
+				     int mr_access_flags, struct ib_pd *pd,
+				     struct ib_udata *udata)
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibmr->device);
 	struct ib_device *ib_dev = &hr_dev->ib_dev;
@@ -341,11 +342,11 @@ int hns_roce_rereg_user_mr(struct ib_mr *ibmr, int flags, u64 start, u64 length,
 	int ret;

 	if (!mr->enabled)
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);

 	mailbox = hns_roce_alloc_cmd_mailbox(hr_dev);
 	if (IS_ERR(mailbox))
-		return PTR_ERR(mailbox);
+		return ERR_CAST(mailbox);

 	mtpt_idx = key_to_hw_index(mr->key) & (hr_dev->caps.num_mtpts - 1);
 	ret = hns_roce_cmd_mbox(hr_dev, 0, mailbox->dma, mtpt_idx, 0,
@@ -390,12 +391,12 @@ int hns_roce_rereg_user_mr(struct ib_mr *ibmr, int flags, u64 start, u64 length,

 	hns_roce_free_cmd_mailbox(hr_dev, mailbox);

-	return 0;
+	return NULL;

 free_cmd_mbox:
 	hns_roce_free_cmd_mailbox(hr_dev, mailbox);

-	return ret;
+	return ERR_PTR(ret);
 }

 int hns_roce_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
diff --git a/drivers/infiniband/hw/mlx4/mlx4_ib.h b/drivers/infiniband/hw/mlx4/mlx4_ib.h
index 58df06492d69..78c9bb79ec75 100644
--- a/drivers/infiniband/hw/mlx4/mlx4_ib.h
+++ b/drivers/infiniband/hw/mlx4/mlx4_ib.h
@@ -908,10 +908,10 @@ int mlx4_ib_steer_qp_alloc(struct mlx4_ib_dev *dev, int count, int *qpn);
 void mlx4_ib_steer_qp_free(struct mlx4_ib_dev *dev, u32 qpn, int count);
 int mlx4_ib_steer_qp_reg(struct mlx4_ib_dev *mdev, struct mlx4_ib_qp *mqp,
 			 int is_attach);
-int mlx4_ib_rereg_user_mr(struct ib_mr *mr, int flags,
-			  u64 start, u64 length, u64 virt_addr,
-			  int mr_access_flags, struct ib_pd *pd,
-			  struct ib_udata *udata);
+struct ib_mr *mlx4_ib_rereg_user_mr(struct ib_mr *mr, int flags, u64 start,
+				    u64 length, u64 virt_addr,
+				    int mr_access_flags, struct ib_pd *pd,
+				    struct ib_udata *udata);
 int mlx4_ib_gid_index_to_real_index(struct mlx4_ib_dev *ibdev,
 				    const struct ib_gid_attr *attr);

diff --git a/drivers/infiniband/hw/mlx4/mr.c b/drivers/infiniband/hw/mlx4/mr.c
index 426fed005d53..50becc0e4b62 100644
--- a/drivers/infiniband/hw/mlx4/mr.c
+++ b/drivers/infiniband/hw/mlx4/mr.c
@@ -456,10 +456,10 @@ struct ib_mr *mlx4_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 	return ERR_PTR(err);
 }

-int mlx4_ib_rereg_user_mr(struct ib_mr *mr, int flags,
-			  u64 start, u64 length, u64 virt_addr,
-			  int mr_access_flags, struct ib_pd *pd,
-			  struct ib_udata *udata)
+struct ib_mr *mlx4_ib_rereg_user_mr(struct ib_mr *mr, int flags, u64 start,
+				    u64 length, u64 virt_addr,
+				    int mr_access_flags, struct ib_pd *pd,
+				    struct ib_udata *udata)
 {
 	struct mlx4_ib_dev *dev = to_mdev(mr->device);
 	struct mlx4_ib_mr *mmr = to_mmr(mr);
@@ -472,9 +472,8 @@ int mlx4_ib_rereg_user_mr(struct ib_mr *mr, int flags,
 	 * race exists.
 	 */
 	err =  mlx4_mr_hw_get_mpt(dev->dev, &mmr->mmr, &pmpt_entry);
-
 	if (err)
-		return err;
+		return ERR_PTR(err);

 	if (flags & IB_MR_REREG_PD) {
 		err = mlx4_mr_hw_change_pd(dev->dev, *pmpt_entry,
@@ -542,8 +541,9 @@ int mlx4_ib_rereg_user_mr(struct ib_mr *mr, int flags,

 release_mpt_entry:
 	mlx4_mr_hw_put_mpt(dev->dev, pmpt_entry);
-
-	return err;
+	if (err)
+		return ERR_PTR(err);
+	return NULL;
 }

 static int
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 718e59fce006..ab84d4efbda3 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1254,9 +1254,9 @@ struct mlx5_ib_mr *mlx5_ib_alloc_implicit_mr(struct mlx5_ib_pd *pd,
 					     int access_flags);
 void mlx5_ib_free_implicit_mr(struct mlx5_ib_mr *mr);
 void mlx5_ib_fence_odp_mr(struct mlx5_ib_mr *mr);
-int mlx5_ib_rereg_user_mr(struct ib_mr *ib_mr, int flags, u64 start,
-			  u64 length, u64 virt_addr, int access_flags,
-			  struct ib_pd *pd, struct ib_udata *udata);
+struct ib_mr *mlx5_ib_rereg_user_mr(struct ib_mr *ib_mr, int flags, u64 start,
+				    u64 length, u64 virt_addr, int access_flags,
+				    struct ib_pd *pd, struct ib_udata *udata);
 int mlx5_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata);
 struct ib_mr *mlx5_ib_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
 			       u32 max_num_sg);
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 4ce878ce3584..5200e93944e7 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1621,9 +1621,10 @@ static int rereg_umr(struct ib_pd *pd, struct mlx5_ib_mr *mr,
 	return err;
 }

-int mlx5_ib_rereg_user_mr(struct ib_mr *ib_mr, int flags, u64 start,
-			  u64 length, u64 virt_addr, int new_access_flags,
-			  struct ib_pd *new_pd, struct ib_udata *udata)
+struct ib_mr *mlx5_ib_rereg_user_mr(struct ib_mr *ib_mr, int flags, u64 start,
+				    u64 length, u64 virt_addr,
+				    int new_access_flags, struct ib_pd *new_pd,
+				    struct ib_udata *udata)
 {
 	struct mlx5_ib_dev *dev = to_mdev(ib_mr->device);
 	struct mlx5_ib_mr *mr = to_mmr(ib_mr);
@@ -1639,10 +1640,10 @@ int mlx5_ib_rereg_user_mr(struct ib_mr *ib_mr, int flags, u64 start,
 		    start, virt_addr, length, access_flags);

 	if (!mr->umem)
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);

 	if (is_odp_mr(mr))
-		return -EOPNOTSUPP;
+		return ERR_PTR(-EOPNOTSUPP);

 	if (flags & IB_MR_REREG_TRANS) {
 		addr = virt_addr;
@@ -1718,14 +1719,14 @@ int mlx5_ib_rereg_user_mr(struct ib_mr *ib_mr, int flags, u64 start,

 	set_mr_fields(dev, mr, len, access_flags);

-	return 0;
+	return NULL;

 err:
 	ib_umem_release(mr->umem);
 	mr->umem = NULL;

 	clean_mr(dev, mr);
-	return err;
+	return ERR_PTR(err);
 }

 static int
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 4fcbc6d3d0e0..3be1d1194a17 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2433,9 +2433,10 @@ struct ib_device_ops {
 	struct ib_mr *(*reg_user_mr)(struct ib_pd *pd, u64 start, u64 length,
 				     u64 virt_addr, int mr_access_flags,
 				     struct ib_udata *udata);
-	int (*rereg_user_mr)(struct ib_mr *mr, int flags, u64 start, u64 length,
-			     u64 virt_addr, int mr_access_flags,
-			     struct ib_pd *pd, struct ib_udata *udata);
+	struct ib_mr *(*rereg_user_mr)(struct ib_mr *mr, int flags, u64 start,
+				       u64 length, u64 virt_addr,
+				       int mr_access_flags, struct ib_pd *pd,
+				       struct ib_udata *udata);
 	int (*dereg_mr)(struct ib_mr *mr, struct ib_udata *udata);
 	struct ib_mr *(*alloc_mr)(struct ib_pd *pd, enum ib_mr_type mr_type,
 				  u32 max_num_sg);
diff --git a/include/rdma/uverbs_types.h b/include/rdma/uverbs_types.h
index a27e9fb4903f..ccd11631c167 100644
--- a/include/rdma/uverbs_types.h
+++ b/include/rdma/uverbs_types.h
@@ -71,6 +71,8 @@ struct uverbs_obj_type_class {
 				       enum rdma_remove_reason why,
 				       struct uverbs_attr_bundle *attrs);
 	void (*remove_handle)(struct ib_uobject *uobj);
+	void (*swap_uobjects)(struct ib_uobject *obj_old,
+			      struct ib_uobject *obj_new);
 };

 struct uverbs_obj_type {
@@ -116,6 +118,9 @@ void rdma_alloc_abort_uobject(struct ib_uobject *uobj,
 			      bool hw_obj_valid);
 void rdma_alloc_commit_uobject(struct ib_uobject *uobj,
 			       struct uverbs_attr_bundle *attrs);
+void rdma_assign_uobject(struct ib_uobject *to_uobj,
+			 struct ib_uobject *new_uobj,
+			 struct uverbs_attr_bundle *attrs);

 /*
  * uverbs_uobject_get is called in order to increase the reference count on
--
2.28.0

