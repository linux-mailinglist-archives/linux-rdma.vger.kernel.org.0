Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6262D215729
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jul 2020 14:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729013AbgGFMYv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Jul 2020 08:24:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:54610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729015AbgGFMYv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 6 Jul 2020 08:24:51 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4104F206E6;
        Mon,  6 Jul 2020 12:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594038289;
        bh=Sx1HDT/E1wkqP+QiJnkLiO2omyqZPoQ2w7H/R0W+FkE=;
        h=From:To:Cc:Subject:Date:From;
        b=GkCzr9THPwjHWXXHKNiAaGIm5Y/R9pq1DaC/rAQzu0/ov5NAz7zf+sJxHYdt1HGaF
         42LpkP0Bg9fowaE7ew/3sj1CHZ+6HsNQnSy+1V1D85bJI91qufe2HPsi4jXZnrXXBd
         dfCAQVWeqdxSTuCRHGVZEjG2MMv+psdcjDdujBl0=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next] RDMA: Move ib_dm allocation to be under ib_core responsibility
Date:   Mon,  6 Jul 2020 15:24:44 +0300
Message-Id: <20200706122444.646892-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Convert struct ib_dm to general allocation/release scheme.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/device.c              |  1 +
 drivers/infiniband/core/uverbs_std_types_dm.c | 11 ++--
 drivers/infiniband/hw/mlx5/main.c             | 59 +++++++------------
 drivers/infiniband/hw/mlx5/mlx5_ib.h          |  9 ++-
 include/rdma/ib_verbs.h                       | 10 ++--
 5 files changed, 37 insertions(+), 53 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index cb61542af03f..5685acfd55fc 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2689,6 +2689,7 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
 	SET_OBJ_SIZE(dev_ops, ib_ah);
 	SET_OBJ_SIZE(dev_ops, ib_counters);
 	SET_OBJ_SIZE(dev_ops, ib_cq);
+	SET_OBJ_SIZE(dev_ops, ib_dm);
 	SET_OBJ_SIZE(dev_ops, ib_mw);
 	SET_OBJ_SIZE(dev_ops, ib_pd);
 	SET_OBJ_SIZE(dev_ops, ib_srq);
diff --git a/drivers/infiniband/core/uverbs_std_types_dm.c b/drivers/infiniband/core/uverbs_std_types_dm.c
index d5a1de33c2c9..e73c9ac3d138 100644
--- a/drivers/infiniband/core/uverbs_std_types_dm.c
+++ b/drivers/infiniband/core/uverbs_std_types_dm.c
@@ -45,7 +45,8 @@ static int uverbs_free_dm(struct ib_uobject *uobject,
 	if (ret)
 		return ret;
 
-	return dm->device->ops.dealloc_dm(dm, attrs);
+	dm->device->ops.dealloc_dm(dm, attrs);
+	return 0;
 }
 
 static int UVERBS_HANDLER(UVERBS_METHOD_DM_ALLOC)(
@@ -72,9 +73,9 @@ static int UVERBS_HANDLER(UVERBS_METHOD_DM_ALLOC)(
 	if (ret)
 		return ret;
 
-	dm = ib_dev->ops.alloc_dm(ib_dev, attrs->context, &attr, attrs);
-	if (IS_ERR(dm))
-		return PTR_ERR(dm);
+	dm = rdma_zalloc_drv_obj(ib_dev, ib_dm);
+	if (!dm)
+		return -ENOMEM;
 
 	dm->device  = ib_dev;
 	dm->length  = attr.length;
@@ -83,7 +84,7 @@ static int UVERBS_HANDLER(UVERBS_METHOD_DM_ALLOC)(
 
 	uobj->object = dm;
 
-	return 0;
+	return ib_dev->ops.alloc_dm(dm, attrs->context, &attr, attrs);
 }
 
 DECLARE_UVERBS_NAMED_METHOD(
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 988b5f5bd6e0..28704560f66d 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -2447,12 +2447,11 @@ static int handle_alloc_dm_sw_icm(struct ib_ucontext *ctx,
 	return err;
 }
 
-struct ib_dm *mlx5_ib_alloc_dm(struct ib_device *ibdev,
-			       struct ib_ucontext *context,
-			       struct ib_dm_alloc_attr *attr,
-			       struct uverbs_attr_bundle *attrs)
+int mlx5_ib_alloc_dm(struct ib_dm *ibdm, struct ib_ucontext *context,
+		     struct ib_dm_alloc_attr *attr,
+		     struct uverbs_attr_bundle *attrs)
 {
-	struct mlx5_ib_dm *dm;
+	struct mlx5_ib_dm *dm = to_mdm(ibdm);
 	enum mlx5_ib_uapi_dm_type type;
 	int err;
 
@@ -2460,18 +2459,16 @@ struct ib_dm *mlx5_ib_alloc_dm(struct ib_device *ibdev,
 				       MLX5_IB_ATTR_ALLOC_DM_REQ_TYPE,
 				       MLX5_IB_UAPI_DM_TYPE_MEMIC);
 	if (err)
-		return ERR_PTR(err);
+		return err;
 
-	mlx5_ib_dbg(to_mdev(ibdev), "alloc_dm req: dm_type=%d user_length=0x%llx log_alignment=%d\n",
-		    type, attr->length, attr->alignment);
+	mlx5_ib_dbg(
+		to_mdev(ibdm->device),
+		"alloc_dm req: dm_type=%d user_length=0x%llx log_alignment=%d\n",
+		type, attr->length, attr->alignment);
 
-	err = check_dm_type_support(to_mdev(ibdev), type);
+	err = check_dm_type_support(to_mdev(ibdm->device), type);
 	if (err)
-		return ERR_PTR(err);
-
-	dm = kzalloc(sizeof(*dm), GFP_KERNEL);
-	if (!dm)
-		return ERR_PTR(-ENOMEM);
+		return err;
 
 	dm->type = type;
 
@@ -2495,49 +2492,33 @@ struct ib_dm *mlx5_ib_alloc_dm(struct ib_device *ibdev,
 		err = -EOPNOTSUPP;
 	}
 
-	if (err)
-		goto err_free;
-
-	return &dm->ibdm;
-
-err_free:
-	kfree(dm);
-	return ERR_PTR(err);
+	return err;
 }
 
-int mlx5_ib_dealloc_dm(struct ib_dm *ibdm, struct uverbs_attr_bundle *attrs)
+void mlx5_ib_dealloc_dm(struct ib_dm *ibdm, struct uverbs_attr_bundle *attrs)
 {
 	struct mlx5_ib_ucontext *ctx = rdma_udata_to_drv_context(
 		&attrs->driver_udata, struct mlx5_ib_ucontext, ibucontext);
 	struct mlx5_core_dev *dev = to_mdev(ibdm->device)->mdev;
 	struct mlx5_ib_dm *dm = to_mdm(ibdm);
-	int ret;
 
 	switch (dm->type) {
 	case MLX5_IB_UAPI_DM_TYPE_MEMIC:
 		rdma_user_mmap_entry_remove(&dm->mentry.rdma_entry);
-		return 0;
+		return;
 	case MLX5_IB_UAPI_DM_TYPE_STEERING_SW_ICM:
-		ret = mlx5_dm_sw_icm_dealloc(dev, MLX5_SW_ICM_TYPE_STEERING,
+		mlx5_dm_sw_icm_dealloc(dev, MLX5_SW_ICM_TYPE_STEERING,
 					     dm->size, ctx->devx_uid, dm->dev_addr,
 					     dm->icm_dm.obj_id);
-		if (ret)
-			return ret;
-		break;
+		return;
 	case MLX5_IB_UAPI_DM_TYPE_HEADER_MODIFY_SW_ICM:
-		ret = mlx5_dm_sw_icm_dealloc(dev, MLX5_SW_ICM_TYPE_HEADER_MODIFY,
+		mlx5_dm_sw_icm_dealloc(dev, MLX5_SW_ICM_TYPE_HEADER_MODIFY,
 					     dm->size, ctx->devx_uid, dm->dev_addr,
 					     dm->icm_dm.obj_id);
-		if (ret)
-			return ret;
-		break;
+		return;
 	default:
-		return -EOPNOTSUPP;
+		return;
 	}
-
-	kfree(dm);
-
-	return 0;
 }
 
 static int mlx5_ib_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
@@ -4116,6 +4097,8 @@ static const struct ib_device_ops mlx5_ib_dev_dm_ops = {
 	.alloc_dm = mlx5_ib_alloc_dm,
 	.dealloc_dm = mlx5_ib_dealloc_dm,
 	.reg_dm_mr = mlx5_ib_reg_dm_mr,
+
+	INIT_RDMA_OBJ_SIZE(ib_dm, mlx5_ib_dm, ibdm),
 };
 
 static int mlx5_ib_init_var_table(struct mlx5_ib_dev *dev)
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 3e8116544c47..8f2ea4d196ba 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1249,11 +1249,10 @@ struct ib_rwq_ind_table *mlx5_ib_create_rwq_ind_table(struct ib_device *device,
 						      struct ib_rwq_ind_table_init_attr *init_attr,
 						      struct ib_udata *udata);
 int mlx5_ib_destroy_rwq_ind_table(struct ib_rwq_ind_table *wq_ind_table);
-struct ib_dm *mlx5_ib_alloc_dm(struct ib_device *ibdev,
-			       struct ib_ucontext *context,
-			       struct ib_dm_alloc_attr *attr,
-			       struct uverbs_attr_bundle *attrs);
-int mlx5_ib_dealloc_dm(struct ib_dm *ibdm, struct uverbs_attr_bundle *attrs);
+int mlx5_ib_alloc_dm(struct ib_dm *dm, struct ib_ucontext *context,
+		     struct ib_dm_alloc_attr *attr,
+		     struct uverbs_attr_bundle *attrs);
+void mlx5_ib_dealloc_dm(struct ib_dm *ibdm, struct uverbs_attr_bundle *attrs);
 struct ib_mr *mlx5_ib_reg_dm_mr(struct ib_pd *pd, struct ib_dm *dm,
 				struct ib_dm_mr_attr *attr,
 				struct uverbs_attr_bundle *attrs);
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index a7f68e005fde..6e83353eb60b 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2531,11 +2531,10 @@ struct ib_device_ops {
 		struct ib_rwq_ind_table_init_attr *init_attr,
 		struct ib_udata *udata);
 	int (*destroy_rwq_ind_table)(struct ib_rwq_ind_table *wq_ind_table);
-	struct ib_dm *(*alloc_dm)(struct ib_device *device,
-				  struct ib_ucontext *context,
-				  struct ib_dm_alloc_attr *attr,
-				  struct uverbs_attr_bundle *attrs);
-	int (*dealloc_dm)(struct ib_dm *dm, struct uverbs_attr_bundle *attrs);
+	int (*alloc_dm)(struct ib_dm *ib_dm, struct ib_ucontext *context,
+			struct ib_dm_alloc_attr *attr,
+			struct uverbs_attr_bundle *attrs);
+	void (*dealloc_dm)(struct ib_dm *dm, struct uverbs_attr_bundle *attrs);
 	struct ib_mr *(*reg_dm_mr)(struct ib_pd *pd, struct ib_dm *dm,
 				   struct ib_dm_mr_attr *attr,
 				   struct uverbs_attr_bundle *attrs);
@@ -2651,6 +2650,7 @@ struct ib_device_ops {
 	DECLARE_RDMA_OBJ_SIZE(ib_ah);
 	DECLARE_RDMA_OBJ_SIZE(ib_counters);
 	DECLARE_RDMA_OBJ_SIZE(ib_cq);
+	DECLARE_RDMA_OBJ_SIZE(ib_dm);
 	DECLARE_RDMA_OBJ_SIZE(ib_mw);
 	DECLARE_RDMA_OBJ_SIZE(ib_pd);
 	DECLARE_RDMA_OBJ_SIZE(ib_srq);
-- 
2.26.2

