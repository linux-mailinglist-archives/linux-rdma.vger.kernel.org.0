Return-Path: <linux-rdma+bounces-3837-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 880E192F129
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2024 23:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 100441F23452
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2024 21:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E4A1A01A1;
	Thu, 11 Jul 2024 21:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VYfOnO7G"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADB719FA79;
	Thu, 11 Jul 2024 21:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720733520; cv=none; b=aLnXXByacjDHqLWRpwVGDEZCzrZTdhwcevd3oHmiFAQGhUmVVhVbAwFp5NUa9LCtVf+VK3LllbS7rcFyM995O7BP5tI+d76ghp5hjNqb53KvAGMQXxKsKlF38C8xKD7qpUe8IhGhwbLveghH6sMyd7XnlWvu/kNoIAcrz9L0NKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720733520; c=relaxed/simple;
	bh=QJjgfTdoV7b94o4F3Xq1+2+74sBTVOAP2xE0/blK3ik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ed6s1DlRZyBydO1T2Q4AdUDqcgkOG2Y8Sc9WQyuGu+1h04MXFhlDN+HrQxovE+EdsqUonD7YeHD2Wq8yurQY9dIp60IjqoNCXedFf8MZKz8tMpwvY6fbdmhdCriBG6YPaUNdCKQpGlQt3KBil/FaB9SjvEe5samwtz7WtAX8K18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VYfOnO7G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A81FFC116B1;
	Thu, 11 Jul 2024 21:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720733519;
	bh=QJjgfTdoV7b94o4F3Xq1+2+74sBTVOAP2xE0/blK3ik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VYfOnO7GnhvHWE1t9KRyozREUCyf5iSL+SVPznMX9JXv8VPxN30iFzfJgXd8/kUk1
	 U7tG9a3MSsdPbgsFPeMKtuMzq/Cf1eqnh3kmF7TgzJSgAxah23w1Xc9IHoCjCEd6oZ
	 em4C0Ykf65WVYpIgiWycStWwVwaqD2v8meLtb4WuqjTmPY/IOrvpL6d1umSxB0ekqk
	 9H6rkv4oSQcuP3DIf5TYONKuhsMJz7VSc3cMIbGC6lIT11fOCP1FL7v59NkNIWU5Ft
	 ZUFoQUrigOGAlrfAKynnxZ4CsjYiZxplhU90nPHEiT/CDPyjcmdBORAvl6URrAMUi/
	 KEbG+stIrPDPw==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Leon Romanovsky <leonro@nvidia.com>,
	netdev@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Parav Pandit <parav@nvidia.com>,
	Shay Drory <shayd@nvidia.com>
Subject: [mlx5-next 2/2] net/mlx5: Expose SFs IRQs
Date: Thu, 11 Jul 2024 14:31:40 -0700
Message-ID: <20240711213140.256997-3-saeed@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240711213140.256997-1-saeed@kernel.org>
References: <20240711213140.256997-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shay Drory <shayd@nvidia.com>

Expose the sysfs files for the IRQs that the mlx5 PCI SFs are using.
These entries are similar to PCI PFs and VFs in 'msi_irqs' directory.

Reviewed-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>

---
v8-v9:
- add Przemek RB
v6->v7:
- remove not needed changes to mlx5 sfnum SF sysfs
v5->v6:
- fail IRQ creation in case auxiliary_device_sysfs_irq_add() failed
  (Parav and Przemek)
v2->v3:
- fix mlx5 sfnum SF sysfs

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eq.c   |  6 +++---
 .../ethernet/mellanox/mlx5/core/irq_affinity.c | 18 +++++++++++++++++-
 .../ethernet/mellanox/mlx5/core/mlx5_core.h    |  6 ++++++
 .../net/ethernet/mellanox/mlx5/core/mlx5_irq.h | 12 ++++++++----
 .../net/ethernet/mellanox/mlx5/core/pci_irq.c  | 12 +++++++++---
 5 files changed, 43 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eq.c b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
index 5693986ae656..5661f047702e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
@@ -714,7 +714,7 @@ static int create_async_eqs(struct mlx5_core_dev *dev)
 err1:
 	mlx5_cmd_allowed_opcode(dev, CMD_ALLOWED_OPCODE_ALL);
 	mlx5_eq_notifier_unregister(dev, &table->cq_err_nb);
-	mlx5_ctrl_irq_release(table->ctrl_irq);
+	mlx5_ctrl_irq_release(dev, table->ctrl_irq);
 	return err;
 }
 
@@ -730,7 +730,7 @@ static void destroy_async_eqs(struct mlx5_core_dev *dev)
 	cleanup_async_eq(dev, &table->cmd_eq, "cmd");
 	mlx5_cmd_allowed_opcode(dev, CMD_ALLOWED_OPCODE_ALL);
 	mlx5_eq_notifier_unregister(dev, &table->cq_err_nb);
-	mlx5_ctrl_irq_release(table->ctrl_irq);
+	mlx5_ctrl_irq_release(dev, table->ctrl_irq);
 }
 
 struct mlx5_eq *mlx5_get_async_eq(struct mlx5_core_dev *dev)
@@ -918,7 +918,7 @@ static int comp_irq_request_sf(struct mlx5_core_dev *dev, u16 vecidx)
 	af_desc.is_managed = 1;
 	cpumask_copy(&af_desc.mask, cpu_online_mask);
 	cpumask_andnot(&af_desc.mask, &af_desc.mask, &table->used_cpus);
-	irq = mlx5_irq_affinity_request(pool, &af_desc);
+	irq = mlx5_irq_affinity_request(dev, pool, &af_desc);
 	if (IS_ERR(irq))
 		return PTR_ERR(irq);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c b/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c
index 612e666ec263..f7b01b3f0cba 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c
@@ -112,15 +112,18 @@ irq_pool_find_least_loaded(struct mlx5_irq_pool *pool, const struct cpumask *req
 
 /**
  * mlx5_irq_affinity_request - request an IRQ according to the given mask.
+ * @dev: mlx5 core device which is requesting the IRQ.
  * @pool: IRQ pool to request from.
  * @af_desc: affinity descriptor for this IRQ.
  *
  * This function returns a pointer to IRQ, or ERR_PTR in case of error.
  */
 struct mlx5_irq *
-mlx5_irq_affinity_request(struct mlx5_irq_pool *pool, struct irq_affinity_desc *af_desc)
+mlx5_irq_affinity_request(struct mlx5_core_dev *dev, struct mlx5_irq_pool *pool,
+			  struct irq_affinity_desc *af_desc)
 {
 	struct mlx5_irq *least_loaded_irq, *new_irq;
+	int ret;
 
 	mutex_lock(&pool->lock);
 	least_loaded_irq = irq_pool_find_least_loaded(pool, &af_desc->mask);
@@ -153,6 +156,16 @@ mlx5_irq_affinity_request(struct mlx5_irq_pool *pool, struct irq_affinity_desc *
 			      mlx5_irq_read_locked(least_loaded_irq) / MLX5_EQ_REFS_PER_IRQ);
 unlock:
 	mutex_unlock(&pool->lock);
+	if (mlx5_irq_pool_is_sf_pool(pool)) {
+		ret = auxiliary_device_sysfs_irq_add(mlx5_sf_coredev_to_adev(dev),
+						     mlx5_irq_get_irq(least_loaded_irq));
+		if (ret) {
+			mlx5_core_err(dev, "Failed to create sysfs entry for irq %d, ret = %d\n",
+				      mlx5_irq_get_irq(least_loaded_irq), ret);
+			mlx5_irq_put(least_loaded_irq);
+			least_loaded_irq = ERR_PTR(ret);
+		}
+	}
 	return least_loaded_irq;
 }
 
@@ -164,6 +177,9 @@ void mlx5_irq_affinity_irq_release(struct mlx5_core_dev *dev, struct mlx5_irq *i
 	cpu = cpumask_first(mlx5_irq_get_affinity_mask(irq));
 	synchronize_irq(pci_irq_vector(pool->dev->pdev,
 				       mlx5_irq_get_index(irq)));
+	if (mlx5_irq_pool_is_sf_pool(pool))
+		auxiliary_device_sysfs_irq_remove(mlx5_sf_coredev_to_adev(dev),
+						  mlx5_irq_get_irq(irq));
 	if (mlx5_irq_put(irq))
 		if (pool->irqs_per_cpu)
 			cpu_put(pool, cpu);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
index c38342b9f320..e764b720d9b2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
@@ -320,6 +320,12 @@ static inline bool mlx5_core_is_sf(const struct mlx5_core_dev *dev)
 	return dev->coredev_type == MLX5_COREDEV_SF;
 }
 
+static inline struct auxiliary_device *
+mlx5_sf_coredev_to_adev(struct mlx5_core_dev *mdev)
+{
+	return container_of(mdev->device, struct auxiliary_device, dev);
+}
+
 int mlx5_mdev_init(struct mlx5_core_dev *dev, int profile_idx);
 void mlx5_mdev_uninit(struct mlx5_core_dev *dev);
 int mlx5_init_one(struct mlx5_core_dev *dev);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_irq.h b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_irq.h
index 1088114e905d..0881e961d8b1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_irq.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_irq.h
@@ -25,7 +25,7 @@ int mlx5_set_msix_vec_count(struct mlx5_core_dev *dev, int devfn,
 int mlx5_get_default_msix_vec_count(struct mlx5_core_dev *dev, int num_vfs);
 
 struct mlx5_irq *mlx5_ctrl_irq_request(struct mlx5_core_dev *dev);
-void mlx5_ctrl_irq_release(struct mlx5_irq *ctrl_irq);
+void mlx5_ctrl_irq_release(struct mlx5_core_dev *dev, struct mlx5_irq *ctrl_irq);
 struct mlx5_irq *mlx5_irq_request(struct mlx5_core_dev *dev, u16 vecidx,
 				  struct irq_affinity_desc *af_desc,
 				  struct cpu_rmap **rmap);
@@ -36,13 +36,15 @@ int mlx5_irq_attach_nb(struct mlx5_irq *irq, struct notifier_block *nb);
 int mlx5_irq_detach_nb(struct mlx5_irq *irq, struct notifier_block *nb);
 struct cpumask *mlx5_irq_get_affinity_mask(struct mlx5_irq *irq);
 int mlx5_irq_get_index(struct mlx5_irq *irq);
+int mlx5_irq_get_irq(const struct mlx5_irq *irq);
 
 struct mlx5_irq_pool;
 #ifdef CONFIG_MLX5_SF
 struct mlx5_irq *mlx5_irq_affinity_irq_request_auto(struct mlx5_core_dev *dev,
 						    struct cpumask *used_cpus, u16 vecidx);
-struct mlx5_irq *mlx5_irq_affinity_request(struct mlx5_irq_pool *pool,
-					   struct irq_affinity_desc *af_desc);
+struct mlx5_irq *
+mlx5_irq_affinity_request(struct mlx5_core_dev *dev, struct mlx5_irq_pool *pool,
+			  struct irq_affinity_desc *af_desc);
 void mlx5_irq_affinity_irq_release(struct mlx5_core_dev *dev, struct mlx5_irq *irq);
 #else
 static inline
@@ -53,7 +55,8 @@ struct mlx5_irq *mlx5_irq_affinity_irq_request_auto(struct mlx5_core_dev *dev,
 }
 
 static inline struct mlx5_irq *
-mlx5_irq_affinity_request(struct mlx5_irq_pool *pool, struct irq_affinity_desc *af_desc)
+mlx5_irq_affinity_request(struct mlx5_core_dev *dev, struct mlx5_irq_pool *pool,
+			  struct irq_affinity_desc *af_desc)
 {
 	return ERR_PTR(-EOPNOTSUPP);
 }
@@ -61,6 +64,7 @@ mlx5_irq_affinity_request(struct mlx5_irq_pool *pool, struct irq_affinity_desc *
 static inline
 void mlx5_irq_affinity_irq_release(struct mlx5_core_dev *dev, struct mlx5_irq *irq)
 {
+	mlx5_irq_release_vector(irq);
 }
 #endif
 #endif /* __MLX5_IRQ_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
index fb8787e30d3f..ac7c3a76b4cf 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
@@ -367,6 +367,11 @@ struct cpumask *mlx5_irq_get_affinity_mask(struct mlx5_irq *irq)
 	return irq->mask;
 }
 
+int mlx5_irq_get_irq(const struct mlx5_irq *irq)
+{
+	return irq->map.virq;
+}
+
 int mlx5_irq_get_index(struct mlx5_irq *irq)
 {
 	return irq->map.index;
@@ -440,11 +445,12 @@ static void _mlx5_irq_release(struct mlx5_irq *irq)
 
 /**
  * mlx5_ctrl_irq_release - release a ctrl IRQ back to the system.
+ * @dev: mlx5 device that releasing the IRQ.
  * @ctrl_irq: ctrl IRQ to be released.
  */
-void mlx5_ctrl_irq_release(struct mlx5_irq *ctrl_irq)
+void mlx5_ctrl_irq_release(struct mlx5_core_dev *dev, struct mlx5_irq *ctrl_irq)
 {
-	_mlx5_irq_release(ctrl_irq);
+	mlx5_irq_affinity_irq_release(dev, ctrl_irq);
 }
 
 /**
@@ -473,7 +479,7 @@ struct mlx5_irq *mlx5_ctrl_irq_request(struct mlx5_core_dev *dev)
 		/* Allocate the IRQ in index 0. The vector was already allocated */
 		irq = irq_pool_request_vector(pool, 0, &af_desc, NULL);
 	} else {
-		irq = mlx5_irq_affinity_request(pool, &af_desc);
+		irq = mlx5_irq_affinity_request(dev, pool, &af_desc);
 	}
 
 	return irq;
-- 
2.45.2


