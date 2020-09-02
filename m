Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC4AF25A795
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Sep 2020 10:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgIBIQj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Sep 2020 04:16:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:38068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbgIBIQh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 2 Sep 2020 04:16:37 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C15C52078B;
        Wed,  2 Sep 2020 08:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599034595;
        bh=UtNi0V9tZnQT4r/k+fJ0VQkwAjn9uFWq6ypX/6FHPxY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fh/w0pappUoR0qbaMQ7A0AhzY1kbjnPF4qznZNEfVoCmtZCnRozWxtfetd/1hbtG2
         eVkCSVacKXBoRXrHI3qo6iEEdoiYfBGItya/fEcNQvi0qc7W2HhCy8uv/0OSDF4jnS
         39smf9PH/BvsLfuemoa9SQRcKE4geD4oLPQ+veIw=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org,
        Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH rdma-next 2/2] RDMA: Convert RWQ table logic to ib_core allocation scheme
Date:   Wed,  2 Sep 2020 11:16:23 +0300
Message-Id: <20200902081623.746359-3-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200902081623.746359-1-leon@kernel.org>
References: <20200902081623.746359-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Move struct ib_rwq_ind_table allocation to ib_core.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/device.c           |  1 +
 drivers/infiniband/core/uverbs_cmd.c       | 25 +++++++------
 drivers/infiniband/core/uverbs_std_types.c | 12 +++++--
 drivers/infiniband/core/verbs.c            | 23 ------------
 drivers/infiniband/hw/mlx4/main.c          |  3 ++
 drivers/infiniband/hw/mlx4/mlx4_ib.h       | 17 ++++++---
 drivers/infiniband/hw/mlx4/qp.c            | 40 ++++++---------------
 drivers/infiniband/hw/mlx5/cmd.c           |  4 +--
 drivers/infiniband/hw/mlx5/cmd.h           |  2 +-
 drivers/infiniband/hw/mlx5/main.c          |  3 ++
 drivers/infiniband/hw/mlx5/mlx5_ib.h       |  6 ++--
 drivers/infiniband/hw/mlx5/qp.c            | 41 ++++++++--------------
 include/rdma/ib_verbs.h                    |  9 +++--
 13 files changed, 80 insertions(+), 106 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 7365ca8edcdf..ec3becf85cac 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2697,6 +2697,7 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
 	SET_OBJ_SIZE(dev_ops, ib_cq);
 	SET_OBJ_SIZE(dev_ops, ib_mw);
 	SET_OBJ_SIZE(dev_ops, ib_pd);
+	SET_OBJ_SIZE(dev_ops, ib_rwq_ind_table);
 	SET_OBJ_SIZE(dev_ops, ib_srq);
 	SET_OBJ_SIZE(dev_ops, ib_ucontext);
 	SET_OBJ_SIZE(dev_ops, ib_xrcd);
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 409913a2489b..408a1a4b67f6 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -3023,11 +3023,11 @@ static int ib_uverbs_ex_create_rwq_ind_table(struct uverbs_attr_bundle *attrs)
 {
 	struct ib_uverbs_ex_create_rwq_ind_table cmd;
 	struct ib_uverbs_ex_create_rwq_ind_table_resp  resp = {};
-	struct ib_uobject		  *uobj;
+	struct ib_uobject *uobj;
 	int err;
 	struct ib_rwq_ind_table_init_attr init_attr = {};
 	struct ib_rwq_ind_table *rwq_ind_tbl;
-	struct ib_wq	**wqs = NULL;
+	struct ib_wq **wqs = NULL;
 	u32 *wqs_handles = NULL;
 	struct ib_wq	*wq = NULL;
 	int i, num_read_wqs;
@@ -3085,17 +3085,15 @@ static int ib_uverbs_ex_create_rwq_ind_table(struct uverbs_attr_bundle *attrs)
 		goto put_wqs;
 	}
 
-	init_attr.log_ind_tbl_size = cmd.log_ind_tbl_size;
-	init_attr.ind_tbl = wqs;
-
-	rwq_ind_tbl = ib_dev->ops.create_rwq_ind_table(ib_dev, &init_attr,
-						       &attrs->driver_udata);
-
-	if (IS_ERR(rwq_ind_tbl)) {
-		err = PTR_ERR(rwq_ind_tbl);
+	rwq_ind_tbl = rdma_zalloc_drv_obj(ib_dev, ib_rwq_ind_table);
+	if (!rwq_ind_tbl) {
+		err = -ENOMEM;
 		goto err_uobj;
 	}
 
+	init_attr.log_ind_tbl_size = cmd.log_ind_tbl_size;
+	init_attr.ind_tbl = wqs;
+
 	rwq_ind_tbl->ind_tbl = wqs;
 	rwq_ind_tbl->log_ind_tbl_size = init_attr.log_ind_tbl_size;
 	rwq_ind_tbl->uobject = uobj;
@@ -3103,6 +3101,11 @@ static int ib_uverbs_ex_create_rwq_ind_table(struct uverbs_attr_bundle *attrs)
 	rwq_ind_tbl->device = ib_dev;
 	atomic_set(&rwq_ind_tbl->usecnt, 0);
 
+	err = ib_dev->ops.create_rwq_ind_table(rwq_ind_tbl, &init_attr,
+					       &attrs->driver_udata);
+	if (err)
+		goto err_create;
+
 	for (i = 0; i < num_wq_handles; i++)
 		rdma_lookup_put_uobject(&wqs[i]->uobject->uevent.uobject,
 					UVERBS_LOOKUP_READ);
@@ -3114,6 +3117,8 @@ static int ib_uverbs_ex_create_rwq_ind_table(struct uverbs_attr_bundle *attrs)
 	resp.response_length = uverbs_response_length(attrs, sizeof(resp));
 	return uverbs_response(attrs, &resp, sizeof(resp));
 
+err_create:
+	kfree(rwq_ind_tbl);
 err_uobj:
 	uobj_alloc_abort(uobj, attrs);
 put_wqs:
diff --git a/drivers/infiniband/core/uverbs_std_types.c b/drivers/infiniband/core/uverbs_std_types.c
index 2932e832f48f..0658101fca00 100644
--- a/drivers/infiniband/core/uverbs_std_types.c
+++ b/drivers/infiniband/core/uverbs_std_types.c
@@ -81,12 +81,20 @@ static int uverbs_free_rwq_ind_tbl(struct ib_uobject *uobject,
 {
 	struct ib_rwq_ind_table *rwq_ind_tbl = uobject->object;
 	struct ib_wq **ind_tbl = rwq_ind_tbl->ind_tbl;
-	int ret;
+	u32 table_size = (1 << rwq_ind_tbl->log_ind_tbl_size);
+	int ret, i;
+
+	if (atomic_read(&rwq_ind_tbl->usecnt))
+		return -EBUSY;
 
-	ret = ib_destroy_rwq_ind_table(rwq_ind_tbl);
+	ret = rwq_ind_tbl->device->ops.destroy_rwq_ind_table(rwq_ind_tbl);
 	if (ib_is_destroy_retryable(ret, why, uobject))
 		return ret;
 
+	for (i = 0; i < table_size; i++)
+		atomic_dec(&ind_tbl[i]->usecnt);
+
+	kfree(rwq_ind_tbl);
 	kfree(ind_tbl);
 	return ret;
 }
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index b9990297e4b0..7663bf38f18d 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -2484,29 +2484,6 @@ int ib_modify_wq(struct ib_wq *wq, struct ib_wq_attr *wq_attr,
 }
 EXPORT_SYMBOL(ib_modify_wq);
 
-/*
- * ib_destroy_rwq_ind_table - Destroys the specified Indirection Table.
- * @wq_ind_table: The Indirection Table to destroy.
-*/
-int ib_destroy_rwq_ind_table(struct ib_rwq_ind_table *rwq_ind_table)
-{
-	int err, i;
-	u32 table_size = (1 << rwq_ind_table->log_ind_tbl_size);
-	struct ib_wq **ind_tbl = rwq_ind_table->ind_tbl;
-
-	if (atomic_read(&rwq_ind_table->usecnt))
-		return -EBUSY;
-
-	err = rwq_ind_table->device->ops.destroy_rwq_ind_table(rwq_ind_table);
-	if (!err) {
-		for (i = 0; i < table_size; i++)
-			atomic_dec(&ind_tbl[i]->usecnt);
-	}
-
-	return err;
-}
-EXPORT_SYMBOL(ib_destroy_rwq_ind_table);
-
 int ib_check_mr_status(struct ib_mr *mr, u32 check_mask,
 		       struct ib_mr_status *mr_status)
 {
diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
index 41c419928a00..753c70402498 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -2578,6 +2578,9 @@ static const struct ib_device_ops mlx4_ib_dev_wq_ops = {
 	.destroy_rwq_ind_table = mlx4_ib_destroy_rwq_ind_table,
 	.destroy_wq = mlx4_ib_destroy_wq,
 	.modify_wq = mlx4_ib_modify_wq,
+
+	INIT_RDMA_OBJ_SIZE(ib_rwq_ind_table, mlx4_ib_rwq_ind_table,
+			   ib_rwq_ind_tbl),
 };
 
 static const struct ib_device_ops mlx4_ib_dev_mw_ops = {
diff --git a/drivers/infiniband/hw/mlx4/mlx4_ib.h b/drivers/infiniband/hw/mlx4/mlx4_ib.h
index 4e304f48157d..70636f70dd8c 100644
--- a/drivers/infiniband/hw/mlx4/mlx4_ib.h
+++ b/drivers/infiniband/hw/mlx4/mlx4_ib.h
@@ -367,6 +367,10 @@ struct mlx4_ib_ah {
 	union mlx4_ext_av       av;
 };
 
+struct mlx4_ib_rwq_ind_table {
+	struct ib_rwq_ind_table ib_rwq_ind_tbl;
+};
+
 /****************************************/
 /* alias guid support */
 /****************************************/
@@ -902,11 +906,14 @@ int mlx4_ib_destroy_wq(struct ib_wq *wq, struct ib_udata *udata);
 int mlx4_ib_modify_wq(struct ib_wq *wq, struct ib_wq_attr *wq_attr,
 		      u32 wq_attr_mask, struct ib_udata *udata);
 
-struct ib_rwq_ind_table
-*mlx4_ib_create_rwq_ind_table(struct ib_device *device,
-			      struct ib_rwq_ind_table_init_attr *init_attr,
-			      struct ib_udata *udata);
-int mlx4_ib_destroy_rwq_ind_table(struct ib_rwq_ind_table *wq_ind_table);
+int mlx4_ib_create_rwq_ind_table(struct ib_rwq_ind_table *ib_rwq_ind_tbl,
+				 struct ib_rwq_ind_table_init_attr *init_attr,
+				 struct ib_udata *udata);
+static inline int
+mlx4_ib_destroy_rwq_ind_table(struct ib_rwq_ind_table *wq_ind_table)
+{
+	return 0;
+}
 int mlx4_ib_umem_calc_optimal_mtt_size(struct ib_umem *umem, u64 start_va,
 				       int *num_of_mtts);
 
diff --git a/drivers/infiniband/hw/mlx4/qp.c b/drivers/infiniband/hw/mlx4/qp.c
index b7a0c3f97713..51012c7abf45 100644
--- a/drivers/infiniband/hw/mlx4/qp.c
+++ b/drivers/infiniband/hw/mlx4/qp.c
@@ -4341,34 +4341,32 @@ int mlx4_ib_destroy_wq(struct ib_wq *ibwq, struct ib_udata *udata)
 	return 0;
 }
 
-struct ib_rwq_ind_table
-*mlx4_ib_create_rwq_ind_table(struct ib_device *device,
-			      struct ib_rwq_ind_table_init_attr *init_attr,
-			      struct ib_udata *udata)
+int mlx4_ib_create_rwq_ind_table(struct ib_rwq_ind_table *rwq_ind_table,
+				 struct ib_rwq_ind_table_init_attr *init_attr,
+				 struct ib_udata *udata)
 {
-	struct ib_rwq_ind_table *rwq_ind_table;
 	struct mlx4_ib_create_rwq_ind_tbl_resp resp = {};
 	unsigned int ind_tbl_size = 1 << init_attr->log_ind_tbl_size;
+	struct ib_device *device = rwq_ind_table->device;
 	unsigned int base_wqn;
 	size_t min_resp_len;
-	int i;
-	int err;
+	int i, err = 0;
 
 	if (udata->inlen > 0 &&
 	    !ib_is_udata_cleared(udata, 0,
 				 udata->inlen))
-		return ERR_PTR(-EOPNOTSUPP);
+		return -EOPNOTSUPP;
 
 	min_resp_len = offsetof(typeof(resp), reserved) + sizeof(resp.reserved);
 	if (udata->outlen && udata->outlen < min_resp_len)
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 
 	if (ind_tbl_size >
 	    device->attrs.rss_caps.max_rwq_indirection_table_size) {
 		pr_debug("log_ind_tbl_size = %d is bigger than supported = %d\n",
 			 ind_tbl_size,
 			 device->attrs.rss_caps.max_rwq_indirection_table_size);
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 	}
 
 	base_wqn = init_attr->ind_tbl[0]->wq_num;
@@ -4376,39 +4374,23 @@ struct ib_rwq_ind_table
 	if (base_wqn % ind_tbl_size) {
 		pr_debug("WQN=0x%x isn't aligned with indirection table size\n",
 			 base_wqn);
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 	}
 
 	for (i = 1; i < ind_tbl_size; i++) {
 		if (++base_wqn != init_attr->ind_tbl[i]->wq_num) {
 			pr_debug("indirection table's WQNs aren't consecutive\n");
-			return ERR_PTR(-EINVAL);
+			return -EINVAL;
 		}
 	}
 
-	rwq_ind_table = kzalloc(sizeof(*rwq_ind_table), GFP_KERNEL);
-	if (!rwq_ind_table)
-		return ERR_PTR(-ENOMEM);
-
 	if (udata->outlen) {
 		resp.response_length = offsetof(typeof(resp), response_length) +
 					sizeof(resp.response_length);
 		err = ib_copy_to_udata(udata, &resp, resp.response_length);
-		if (err)
-			goto err;
 	}
 
-	return rwq_ind_table;
-
-err:
-	kfree(rwq_ind_table);
-	return ERR_PTR(err);
-}
-
-int mlx4_ib_destroy_rwq_ind_table(struct ib_rwq_ind_table *ib_rwq_ind_tbl)
-{
-	kfree(ib_rwq_ind_tbl);
-	return 0;
+	return err;
 }
 
 struct mlx4_ib_drain_cqe {
diff --git a/drivers/infiniband/hw/mlx5/cmd.c b/drivers/infiniband/hw/mlx5/cmd.c
index f5aac53cebf0..234f29912ba9 100644
--- a/drivers/infiniband/hw/mlx5/cmd.c
+++ b/drivers/infiniband/hw/mlx5/cmd.c
@@ -168,14 +168,14 @@ void mlx5_cmd_destroy_tis(struct mlx5_core_dev *dev, u32 tisn, u16 uid)
 	mlx5_cmd_exec_in(dev, destroy_tis, in);
 }
 
-void mlx5_cmd_destroy_rqt(struct mlx5_core_dev *dev, u32 rqtn, u16 uid)
+int mlx5_cmd_destroy_rqt(struct mlx5_core_dev *dev, u32 rqtn, u16 uid)
 {
 	u32 in[MLX5_ST_SZ_DW(destroy_rqt_in)] = {};
 
 	MLX5_SET(destroy_rqt_in, in, opcode, MLX5_CMD_OP_DESTROY_RQT);
 	MLX5_SET(destroy_rqt_in, in, rqtn, rqtn);
 	MLX5_SET(destroy_rqt_in, in, uid, uid);
-	mlx5_cmd_exec_in(dev, destroy_rqt, in);
+	return mlx5_cmd_exec_in(dev, destroy_rqt, in);
 }
 
 int mlx5_cmd_alloc_transport_domain(struct mlx5_core_dev *dev, u32 *tdn,
diff --git a/drivers/infiniband/hw/mlx5/cmd.h b/drivers/infiniband/hw/mlx5/cmd.h
index ca3afa7d73a3..88ea6ef8f2cb 100644
--- a/drivers/infiniband/hw/mlx5/cmd.h
+++ b/drivers/infiniband/hw/mlx5/cmd.h
@@ -47,7 +47,7 @@ void mlx5_cmd_dealloc_memic(struct mlx5_dm *dm, phys_addr_t addr, u64 length);
 int mlx5_cmd_dealloc_pd(struct mlx5_core_dev *dev, u32 pdn, u16 uid);
 void mlx5_cmd_destroy_tir(struct mlx5_core_dev *dev, u32 tirn, u16 uid);
 void mlx5_cmd_destroy_tis(struct mlx5_core_dev *dev, u32 tisn, u16 uid);
-void mlx5_cmd_destroy_rqt(struct mlx5_core_dev *dev, u32 rqtn, u16 uid);
+int mlx5_cmd_destroy_rqt(struct mlx5_core_dev *dev, u32 rqtn, u16 uid);
 int mlx5_cmd_alloc_transport_domain(struct mlx5_core_dev *dev, u32 *tdn,
 				    u16 uid);
 void mlx5_cmd_dealloc_transport_domain(struct mlx5_core_dev *dev, u32 tdn,
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index d197df0280f8..99dbef0bccbc 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -4259,6 +4259,9 @@ static const struct ib_device_ops mlx5_ib_dev_common_roce_ops = {
 	.destroy_wq = mlx5_ib_destroy_wq,
 	.get_netdev = mlx5_ib_get_netdev,
 	.modify_wq = mlx5_ib_modify_wq,
+
+	INIT_RDMA_OBJ_SIZE(ib_rwq_ind_table, mlx5_ib_rwq_ind_table,
+			   ib_rwq_ind_tbl),
 };
 
 static int mlx5_ib_roce_init(struct mlx5_ib_dev *dev)
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 67985ddbfcb0..184abd5f493c 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1243,9 +1243,9 @@ struct ib_wq *mlx5_ib_create_wq(struct ib_pd *pd,
 int mlx5_ib_destroy_wq(struct ib_wq *wq, struct ib_udata *udata);
 int mlx5_ib_modify_wq(struct ib_wq *wq, struct ib_wq_attr *wq_attr,
 		      u32 wq_attr_mask, struct ib_udata *udata);
-struct ib_rwq_ind_table *mlx5_ib_create_rwq_ind_table(struct ib_device *device,
-						      struct ib_rwq_ind_table_init_attr *init_attr,
-						      struct ib_udata *udata);
+int mlx5_ib_create_rwq_ind_table(struct ib_rwq_ind_table *ib_rwq_ind_table,
+				 struct ib_rwq_ind_table_init_attr *init_attr,
+				 struct ib_udata *udata);
 int mlx5_ib_destroy_rwq_ind_table(struct ib_rwq_ind_table *wq_ind_table);
 struct ib_dm *mlx5_ib_alloc_dm(struct ib_device *ibdev,
 			       struct ib_ucontext *context,
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 8a754a8e2558..22280ea92006 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -5099,12 +5099,13 @@ int mlx5_ib_destroy_wq(struct ib_wq *wq, struct ib_udata *udata)
 	return ret;
 }
 
-struct ib_rwq_ind_table *mlx5_ib_create_rwq_ind_table(struct ib_device *device,
-						      struct ib_rwq_ind_table_init_attr *init_attr,
-						      struct ib_udata *udata)
+int mlx5_ib_create_rwq_ind_table(struct ib_rwq_ind_table *ib_rwq_ind_table,
+				 struct ib_rwq_ind_table_init_attr *init_attr,
+				 struct ib_udata *udata)
 {
-	struct mlx5_ib_dev *dev = to_mdev(device);
-	struct mlx5_ib_rwq_ind_table *rwq_ind_tbl;
+	struct mlx5_ib_rwq_ind_table *rwq_ind_tbl =
+		to_mrwq_ind_table(ib_rwq_ind_table);
+	struct mlx5_ib_dev *dev = to_mdev(ib_rwq_ind_table->device);
 	int sz = 1 << init_attr->log_ind_tbl_size;
 	struct mlx5_ib_create_rwq_ind_tbl_resp resp = {};
 	size_t min_resp_len;
@@ -5117,31 +5118,25 @@ struct ib_rwq_ind_table *mlx5_ib_create_rwq_ind_table(struct ib_device *device,
 	if (udata->inlen > 0 &&
 	    !ib_is_udata_cleared(udata, 0,
 				 udata->inlen))
-		return ERR_PTR(-EOPNOTSUPP);
+		return -EOPNOTSUPP;
 
 	if (init_attr->log_ind_tbl_size >
 	    MLX5_CAP_GEN(dev->mdev, log_max_rqt_size)) {
 		mlx5_ib_dbg(dev, "log_ind_tbl_size = %d is bigger than supported = %d\n",
 			    init_attr->log_ind_tbl_size,
 			    MLX5_CAP_GEN(dev->mdev, log_max_rqt_size));
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 	}
 
 	min_resp_len =
 		offsetofend(struct mlx5_ib_create_rwq_ind_tbl_resp, reserved);
 	if (udata->outlen && udata->outlen < min_resp_len)
-		return ERR_PTR(-EINVAL);
-
-	rwq_ind_tbl = kzalloc(sizeof(*rwq_ind_tbl), GFP_KERNEL);
-	if (!rwq_ind_tbl)
-		return ERR_PTR(-ENOMEM);
+		return -EINVAL;
 
 	inlen = MLX5_ST_SZ_BYTES(create_rqt_in) + sizeof(u32) * sz;
 	in = kvzalloc(inlen, GFP_KERNEL);
-	if (!in) {
-		err = -ENOMEM;
-		goto err;
-	}
+	if (!in)
+		return -ENOMEM;
 
 	rqtc = MLX5_ADDR_OF(create_rqt_in, in, rqt_context);
 
@@ -5156,9 +5151,8 @@ struct ib_rwq_ind_table *mlx5_ib_create_rwq_ind_table(struct ib_device *device,
 
 	err = mlx5_core_create_rqt(dev->mdev, in, inlen, &rwq_ind_tbl->rqtn);
 	kvfree(in);
-
 	if (err)
-		goto err;
+		return err;
 
 	rwq_ind_tbl->ib_rwq_ind_tbl.ind_tbl_num = rwq_ind_tbl->rqtn;
 	if (udata->outlen) {
@@ -5170,13 +5164,11 @@ struct ib_rwq_ind_table *mlx5_ib_create_rwq_ind_table(struct ib_device *device,
 			goto err_copy;
 	}
 
-	return &rwq_ind_tbl->ib_rwq_ind_tbl;
+	return 0;
 
 err_copy:
 	mlx5_cmd_destroy_rqt(dev->mdev, rwq_ind_tbl->rqtn, rwq_ind_tbl->uid);
-err:
-	kfree(rwq_ind_tbl);
-	return ERR_PTR(err);
+	return err;
 }
 
 int mlx5_ib_destroy_rwq_ind_table(struct ib_rwq_ind_table *ib_rwq_ind_tbl)
@@ -5184,10 +5176,7 @@ int mlx5_ib_destroy_rwq_ind_table(struct ib_rwq_ind_table *ib_rwq_ind_tbl)
 	struct mlx5_ib_rwq_ind_table *rwq_ind_tbl = to_mrwq_ind_table(ib_rwq_ind_tbl);
 	struct mlx5_ib_dev *dev = to_mdev(ib_rwq_ind_tbl->device);
 
-	mlx5_cmd_destroy_rqt(dev->mdev, rwq_ind_tbl->rqtn, rwq_ind_tbl->uid);
-
-	kfree(rwq_ind_tbl);
-	return 0;
+	return mlx5_cmd_destroy_rqt(dev->mdev, rwq_ind_tbl->rqtn, rwq_ind_tbl->uid);
 }
 
 int mlx5_ib_modify_wq(struct ib_wq *wq, struct ib_wq_attr *wq_attr,
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 18e861f38295..73738fe91e5b 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2488,10 +2488,9 @@ struct ib_device_ops {
 	int (*destroy_wq)(struct ib_wq *wq, struct ib_udata *udata);
 	int (*modify_wq)(struct ib_wq *wq, struct ib_wq_attr *attr,
 			 u32 wq_attr_mask, struct ib_udata *udata);
-	struct ib_rwq_ind_table *(*create_rwq_ind_table)(
-		struct ib_device *device,
-		struct ib_rwq_ind_table_init_attr *init_attr,
-		struct ib_udata *udata);
+	int (*create_rwq_ind_table)(struct ib_rwq_ind_table *ib_rwq_ind_table,
+				    struct ib_rwq_ind_table_init_attr *init_attr,
+				    struct ib_udata *udata);
 	int (*destroy_rwq_ind_table)(struct ib_rwq_ind_table *wq_ind_table);
 	struct ib_dm *(*alloc_dm)(struct ib_device *device,
 				  struct ib_ucontext *context,
@@ -2615,6 +2614,7 @@ struct ib_device_ops {
 	DECLARE_RDMA_OBJ_SIZE(ib_cq);
 	DECLARE_RDMA_OBJ_SIZE(ib_mw);
 	DECLARE_RDMA_OBJ_SIZE(ib_pd);
+	DECLARE_RDMA_OBJ_SIZE(ib_rwq_ind_table);
 	DECLARE_RDMA_OBJ_SIZE(ib_srq);
 	DECLARE_RDMA_OBJ_SIZE(ib_ucontext);
 	DECLARE_RDMA_OBJ_SIZE(ib_xrcd);
@@ -4331,7 +4331,6 @@ struct ib_wq *ib_create_wq(struct ib_pd *pd,
 int ib_destroy_wq_user(struct ib_wq *wq, struct ib_udata *udata);
 int ib_modify_wq(struct ib_wq *wq, struct ib_wq_attr *attr,
 		 u32 wq_attr_mask);
-int ib_destroy_rwq_ind_table(struct ib_rwq_ind_table *wq_ind_table);
 
 int ib_map_mr_sg(struct ib_mr *mr, struct scatterlist *sg, int sg_nents,
 		 unsigned int *sg_offset, unsigned int page_size);
-- 
2.26.2

