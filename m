Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8835633A4E5
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Mar 2021 13:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbhCNMya (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 14 Mar 2021 08:54:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:47628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235428AbhCNMy0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 14 Mar 2021 08:54:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4D41D64DE0;
        Sun, 14 Mar 2021 12:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615726466;
        bh=DKhymGOp0dzcSdtxpB6qUmqguMVl0uZna+/bjOwGxMo=;
        h=From:To:Cc:Subject:Date:From;
        b=SDL4B7h0jkk2l4cXxBdhEz74WK5vpBSO49A5BHJIdSlPX3rBZMV6qyrFc9YrlGov/
         K1ijVQzA5zXZlVh289o/A8Hxq9QStyed9SJKmo7mI4Ox3cA9G0QR4kBumbA4LAzuXg
         f1vZSbN8dRPTNtMTJVipJeqI2yRFtPRzi/A47EuIFimiEQv1tLcfzrgNF4oZnXTjVs
         1NX8HEfff9CWindFv+PDYF6sPC/dQqU8JrnbF+kc7T891yCk+PuMZegdnRkgNbTCYQ
         wWQUkmBr9ahVCeV9HIEjn5xvMbrjV3OAsXYAj/k9tYEO6WBrqmB50ZKrEmMt/QN62g
         MluZTYtIDwYdw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Shay Drory <shayd@nvidia.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>
Subject: [PATCH rdma-next v1] RDMA/mlx5: Create ODP EQ only when ODP MR is created
Date:   Sun, 14 Mar 2021 14:54:18 +0200
Message-Id: <20210314125418.179716-1-leon@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Shay Drory <shayd@nvidia.com>

There is no need to create the ODP EQ if the user doesn't use ODP MRs.
Hence, create it only when the first ODP MR is created. This EQ will be
destroyed only when the device is unloaded.
This will decrease the number of EQs created per device. for example: If
we creates 1K devices (SF/VF/etc'), than we will decrease the num of EQs
by 1K.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Maor Gottlieb <maorg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 Changelog:
 v1:
 * Delete optimization
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  7 +++++++
 drivers/infiniband/hw/mlx5/mr.c      |  3 +++
 drivers/infiniband/hw/mlx5/odp.c     | 29 ++++++++++++++++++----------
 3 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 544a41fec9cd..a31097538dc7 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1080,6 +1080,7 @@ struct mlx5_ib_dev {
 	struct mutex			slow_path_mutex;
 	struct ib_odp_caps	odp_caps;
 	u64			odp_max_size;
+	struct mutex		odp_eq_mutex;
 	struct mlx5_ib_pf_eq	odp_pf_eq;

 	struct xarray		odp_mkeys;
@@ -1358,6 +1359,7 @@ struct ib_mr *mlx5_ib_reg_dm_mr(struct ib_pd *pd, struct ib_dm *dm,
 #ifdef CONFIG_INFINIBAND_ON_DEMAND_PAGING
 void mlx5_ib_internal_fill_odp_caps(struct mlx5_ib_dev *dev);
 int mlx5_ib_odp_init_one(struct mlx5_ib_dev *ibdev);
+int mlx5r_odp_create_eq(struct mlx5_ib_dev *dev, struct mlx5_ib_pf_eq *eq);
 void mlx5_ib_odp_cleanup_one(struct mlx5_ib_dev *ibdev);
 int __init mlx5_ib_odp_init(void);
 void mlx5_ib_odp_cleanup(void);
@@ -1377,6 +1379,11 @@ static inline void mlx5_ib_internal_fill_odp_caps(struct mlx5_ib_dev *dev)
 }

 static inline int mlx5_ib_odp_init_one(struct mlx5_ib_dev *ibdev) { return 0; }
+static inline int mlx5r_odp_create_eq(struct mlx5_ib_dev *dev,
+				      struct mlx5_ib_pf_eq *eq)
+{
+	return 0;
+}
 static inline void mlx5_ib_odp_cleanup_one(struct mlx5_ib_dev *ibdev) {}
 static inline int mlx5_ib_odp_init(void) { return 0; }
 static inline void mlx5_ib_odp_cleanup(void)				    {}
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 86ffc7e5ef96..6700286cc05a 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1500,6 +1500,9 @@ static struct ib_mr *create_user_odp_mr(struct ib_pd *pd, u64 start, u64 length,
 	if (!IS_ENABLED(CONFIG_INFINIBAND_ON_DEMAND_PAGING))
 		return ERR_PTR(-EOPNOTSUPP);

+	err = mlx5r_odp_create_eq(dev, &dev->odp_pf_eq);
+	if (err)
+		return ERR_PTR(err);
 	if (!start && length == U64_MAX) {
 		if (iova != 0)
 			return ERR_PTR(-EINVAL);
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 3008d1539ad4..a0b9111b508a 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -1531,20 +1531,24 @@ enum {
 	MLX5_IB_NUM_PF_DRAIN	= 64,
 };

-static int
-mlx5_ib_create_pf_eq(struct mlx5_ib_dev *dev, struct mlx5_ib_pf_eq *eq)
+int mlx5r_odp_create_eq(struct mlx5_ib_dev *dev, struct mlx5_ib_pf_eq *eq)
 {
 	struct mlx5_eq_param param = {};
-	int err;
+	int err = 0;

+	mutex_lock(&dev->odp_eq_mutex);
+	if (eq->core)
+		goto unlock;
 	INIT_WORK(&eq->work, mlx5_ib_eq_pf_action);
 	spin_lock_init(&eq->lock);
 	eq->dev = dev;

 	eq->pool = mempool_create_kmalloc_pool(MLX5_IB_NUM_PF_DRAIN,
 					       sizeof(struct mlx5_pagefault));
-	if (!eq->pool)
-		return -ENOMEM;
+	if (!eq->pool) {
+		err = -ENOMEM;
+		goto unlock;
+	}

 	eq->wq = alloc_workqueue("mlx5_ib_page_fault",
 				 WQ_HIGHPRI | WQ_UNBOUND | WQ_MEM_RECLAIM,
@@ -1555,7 +1559,7 @@ mlx5_ib_create_pf_eq(struct mlx5_ib_dev *dev, struct mlx5_ib_pf_eq *eq)
 	}

 	eq->irq_nb.notifier_call = mlx5_ib_eq_pf_int;
-	param = (struct mlx5_eq_param) {
+	param = (struct mlx5_eq_param){
 		.irq_index = 0,
 		.nent = MLX5_IB_NUM_PF_EQE,
 	};
@@ -1571,21 +1575,27 @@ mlx5_ib_create_pf_eq(struct mlx5_ib_dev *dev, struct mlx5_ib_pf_eq *eq)
 		goto err_eq;
 	}

+	mutex_unlock(&dev->odp_eq_mutex);
 	return 0;
 err_eq:
 	mlx5_eq_destroy_generic(dev->mdev, eq->core);
 err_wq:
+	eq->core = NULL;
 	destroy_workqueue(eq->wq);
 err_mempool:
 	mempool_destroy(eq->pool);
+unlock:
+	mutex_unlock(&dev->odp_eq_mutex);
 	return err;
 }

 static int
-mlx5_ib_destroy_pf_eq(struct mlx5_ib_dev *dev, struct mlx5_ib_pf_eq *eq)
+mlx5_ib_odp_destroy_eq(struct mlx5_ib_dev *dev, struct mlx5_ib_pf_eq *eq)
 {
 	int err;

+	if (!eq->core)
+		return 0;
 	mlx5_eq_disable(dev->mdev, eq->core, &eq->irq_nb);
 	err = mlx5_eq_destroy_generic(dev->mdev, eq->core);
 	cancel_work_sync(&eq->work);
@@ -1642,8 +1652,7 @@ int mlx5_ib_odp_init_one(struct mlx5_ib_dev *dev)
 		}
 	}

-	ret = mlx5_ib_create_pf_eq(dev, &dev->odp_pf_eq);
-
+	mutex_init(&dev->odp_eq_mutex);
 	return ret;
 }

@@ -1652,7 +1661,7 @@ void mlx5_ib_odp_cleanup_one(struct mlx5_ib_dev *dev)
 	if (!(dev->odp_caps.general_caps & IB_ODP_SUPPORT))
 		return;

-	mlx5_ib_destroy_pf_eq(dev, &dev->odp_pf_eq);
+	mlx5_ib_odp_destroy_eq(dev, &dev->odp_pf_eq);
 }

 int mlx5_ib_odp_init(void)
--
2.30.2

