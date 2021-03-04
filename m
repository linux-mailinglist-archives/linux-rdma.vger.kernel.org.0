Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2F932D380
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Mar 2021 13:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbhCDMqm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Mar 2021 07:46:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:39896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231294AbhCDMqN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 4 Mar 2021 07:46:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5DDA064F32;
        Thu,  4 Mar 2021 12:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614861933;
        bh=54dfQxtUTqf0T21WjMHQisGlfvBPwYxZeLjR2YRbcG8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qt+HEwp/eCQGw+wnzdSK26H685UA7Oo1fFoGYcjQEFlvvH+rRmYTOq9FjzI/c9r2N
         o2LbEFIQXQcl2SgrJgMwgXRPh1giyze166/jQ/T5IhX02LiZFwt9sFTFDKd35h+Y61
         Yxv38rcP6efd6KmatOUXSxYNL3jIN2zZKz/hOwOiZpe3N9czxswAg5BnMVgPHx41O5
         X23yHIxS1ETOq5Pn9zMIpN+6O/zT7JA7cfghRLmpll7WcZ3vv1Qs1D8PCW/jOLn20z
         wJ0Ytu7mlACqtoUNbQGXruoHZVZ88AtppROuMUM2rZZJLylxlVSi4lcj3ig/y60yy7
         Ae6ttrz00yPag==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Shay Drory <shayd@nvidia.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>
Subject: [PATCH rdma-next 2/3] RDMA/mlx5: Create ODP EQ only when ODP MR is created
Date:   Thu,  4 Mar 2021 14:45:16 +0200
Message-Id: <20210304124517.1100608-3-leon@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210304124517.1100608-1-leon@kernel.org>
References: <20210304124517.1100608-1-leon@kernel.org>
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
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  7 ++++++
 drivers/infiniband/hw/mlx5/mr.c      |  3 +++
 drivers/infiniband/hw/mlx5/odp.c     | 32 +++++++++++++++++++---------
 3 files changed, 32 insertions(+), 10 deletions(-)

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
index 3008d1539ad4..a73e22dd4b2a 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -1531,20 +1531,27 @@ enum {
 	MLX5_IB_NUM_PF_DRAIN	= 64,
 };
 
-static int
-mlx5_ib_create_pf_eq(struct mlx5_ib_dev *dev, struct mlx5_ib_pf_eq *eq)
+int mlx5r_odp_create_eq(struct mlx5_ib_dev *dev, struct mlx5_ib_pf_eq *eq)
 {
 	struct mlx5_eq_param param = {};
-	int err;
+	int err = 0;
 
+	if (eq->core)
+		return 0;
+
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
@@ -1555,7 +1562,7 @@ mlx5_ib_create_pf_eq(struct mlx5_ib_dev *dev, struct mlx5_ib_pf_eq *eq)
 	}
 
 	eq->irq_nb.notifier_call = mlx5_ib_eq_pf_int;
-	param = (struct mlx5_eq_param) {
+	param = (struct mlx5_eq_param){
 		.irq_index = 0,
 		.nent = MLX5_IB_NUM_PF_EQE,
 	};
@@ -1571,21 +1578,27 @@ mlx5_ib_create_pf_eq(struct mlx5_ib_dev *dev, struct mlx5_ib_pf_eq *eq)
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
@@ -1642,8 +1655,7 @@ int mlx5_ib_odp_init_one(struct mlx5_ib_dev *dev)
 		}
 	}
 
-	ret = mlx5_ib_create_pf_eq(dev, &dev->odp_pf_eq);
-
+	mutex_init(&dev->odp_eq_mutex);
 	return ret;
 }
 
@@ -1652,7 +1664,7 @@ void mlx5_ib_odp_cleanup_one(struct mlx5_ib_dev *dev)
 	if (!(dev->odp_caps.general_caps & IB_ODP_SUPPORT))
 		return;
 
-	mlx5_ib_destroy_pf_eq(dev, &dev->odp_pf_eq);
+	mlx5_ib_odp_destroy_eq(dev, &dev->odp_pf_eq);
 }
 
 int mlx5_ib_odp_init(void)
-- 
2.29.2

