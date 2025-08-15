Return-Path: <linux-rdma+bounces-12782-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0F1B2869E
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Aug 2025 21:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC56B1CC8C46
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Aug 2025 19:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15AD82BE03F;
	Fri, 15 Aug 2025 19:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sRuukM2M"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6225217F34;
	Fri, 15 Aug 2025 19:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755287347; cv=none; b=g2ZkUQ8LAnTrkWu92CRAbe14x+0Q5Yz4ueJl6v71FPsS4vsWO+vSDxHIBWL+ejZ0wl4oS8pHLzx6w6tWo7wScmWSBW2+ePa6N7IgeT7kMpIKBMFJylT9zCccU60civQfYmXkqRdsnv6K+XOLZzYjWsyrUNt3/2P1XD0Ui0Lf/OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755287347; c=relaxed/simple;
	bh=rkGx+lRC/7erdVeOn1owLQLQFyp2otzUOtAD0mzwRoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HL1xD0MfoQMzshnsxBLHlzfT3iklAxulihZ0dBKil8MSLzeAt+IilVvz2oY0rzX6Pt8jrdjzsgKILhOkexCnK891lxPHB4R7BwrpNBz6iIZWSVZ16VCOJ9edh88/rWOaXm9wYsrvQDL1qwJX8QOtRckHIXLpBSpbhoEZr+QTIXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sRuukM2M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 475EDC4CEEB;
	Fri, 15 Aug 2025 19:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755287347;
	bh=rkGx+lRC/7erdVeOn1owLQLQFyp2otzUOtAD0mzwRoY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sRuukM2MXBzNlHSeEW/BCbgxbfk4+zKWyypSxU4EfNTjcxVidZTnVOhyYq05rzCdu
	 bX7JfyMkPO68rJyqezs3DhIc/EOvm/eYs37X5hC2DBOAgCg2qCanjKouXgomFJ7Kds
	 fCE5YXWqOfQSKCIjZtMAH6qNwDGaNBxetS8Gl/GXmkVO2CSZEcMI20wsQb/YHWwoOD
	 1R433P1uMYlVZ1o7OMrgUHNIW8UW4Qj2q4n0b12HRuzBnDLI41wbaS1dBnbZWe5suj
	 qATAo0lWto8hTZ23dwBj7b8eK4XUGjDgnwES/6zvoMYChmU2/c5wxoS0WBlE7wZ87f
	 1MjPf6LHHpDvw==
From: Saeed Mahameed <saeed@kernel.org>
To: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Parav Pandit <parav@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Alexei Lazar <alazar@nvidia.com>,
	Feng Liu <feliu@nvidia.com>
Subject: [PATCH mlx5-next 2/4] net/mlx5: E-Switch, Cache vport vhca id on first cap query
Date: Fri, 15 Aug 2025 12:48:59 -0700
Message-ID: <20250815194901.298689-3-saeed@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815194901.298689-1-saeed@kernel.org>
References: <20250815194901.298689-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

We need vhca_id to set up the vhca_id to vport mapping for every vport,
for that we query the firmware in mlx5_esw_vport_vhca_id_set, and it is
redundant since in esw_vport_setup, we already query hca caps which has
the vhca_id, cache it there and save 2 extra fw queries per vport.

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Alexei Lazar <alazar@nvidia.com>
Reviewed-by: Feng Liu <feliu@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/eswitch.c |  6 ++--
 .../net/ethernet/mellanox/mlx5/core/eswitch.h | 12 +++++--
 .../mellanox/mlx5/core/eswitch_offloads.c     | 34 +++++++++----------
 3 files changed, 31 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index 4917d185d0c3..eeffe9c4aa56 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -820,6 +820,7 @@ static int mlx5_esw_vport_caps_get(struct mlx5_eswitch *esw, struct mlx5_vport *
 
 	hca_caps = MLX5_ADDR_OF(query_hca_cap_out, query_ctx, capability);
 	vport->info.roce_enabled = MLX5_GET(cmd_hca_cap, hca_caps, roce);
+	vport->vhca_id = MLX5_GET(cmd_hca_cap, hca_caps, vhca_id);
 
 	if (!MLX5_CAP_GEN_MAX(esw->dev, hca_cap_2))
 		goto out_free;
@@ -929,7 +930,7 @@ int mlx5_esw_vport_enable(struct mlx5_eswitch *esw, struct mlx5_vport *vport,
 
 	if (!mlx5_esw_is_manager_vport(esw, vport_num) &&
 	    MLX5_CAP_GEN(esw->dev, vhca_resource_manager)) {
-		ret = mlx5_esw_vport_vhca_id_set(esw, vport_num);
+		ret = mlx5_esw_vport_vhca_id_map(esw, vport);
 		if (ret)
 			goto err_vhca_mapping;
 	}
@@ -973,7 +974,7 @@ void mlx5_esw_vport_disable(struct mlx5_eswitch *esw, struct mlx5_vport *vport)
 
 	if (!mlx5_esw_is_manager_vport(esw, vport_num) &&
 	    MLX5_CAP_GEN(esw->dev, vhca_resource_manager))
-		mlx5_esw_vport_vhca_id_clear(esw, vport_num);
+		mlx5_esw_vport_vhca_id_unmap(esw, vport);
 
 	if (vport->vport != MLX5_VPORT_PF &&
 	    (vport->info.ipsec_crypto_enabled || vport->info.ipsec_packet_enabled))
@@ -1710,6 +1711,7 @@ static int mlx5_esw_vport_alloc(struct mlx5_eswitch *esw,
 	vport->vport = vport_num;
 	vport->index = index;
 	vport->info.link_state = MLX5_VPORT_ADMIN_STATE_AUTO;
+	vport->vhca_id = MLX5_VHCA_ID_INVALID;
 	INIT_WORK(&vport->vport_change_handler, esw_vport_change_handler);
 	err = xa_insert(&esw->vports, vport_num, vport, GFP_KERNEL);
 	if (err)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index b0b8ef3ec3c4..7f6bfaae5f5f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -197,6 +197,11 @@ static inline struct mlx5_vport *mlx5_devlink_port_vport_get(struct devlink_port
 	return mlx5_devlink_port_get(dl_port)->vport;
 }
 
+#define MLX5_VHCA_ID_INVALID (-1)
+
+#define MLX5_VPORT_INVAL_VHCA_ID(vport) \
+	((vport)->vhca_id == MLX5_VHCA_ID_INVALID)
+
 struct mlx5_vport {
 	struct mlx5_core_dev    *dev;
 	struct hlist_head       uc_list[MLX5_L2_ADDR_HASH_SIZE];
@@ -209,6 +214,7 @@ struct mlx5_vport {
 	struct vport_egress     egress;
 	u32                     default_metadata;
 	u32                     metadata;
+	int                     vhca_id;
 
 	struct mlx5_vport_info  info;
 
@@ -822,8 +828,10 @@ struct devlink_port *mlx5_esw_offloads_devlink_port(struct mlx5_eswitch *esw, u1
 
 int mlx5_esw_sf_max_hpf_functions(struct mlx5_core_dev *dev, u16 *max_sfs, u16 *sf_base_id);
 
-int mlx5_esw_vport_vhca_id_set(struct mlx5_eswitch *esw, u16 vport_num);
-void mlx5_esw_vport_vhca_id_clear(struct mlx5_eswitch *esw, u16 vport_num);
+int mlx5_esw_vport_vhca_id_map(struct mlx5_eswitch *esw,
+			       struct mlx5_vport *vport);
+void mlx5_esw_vport_vhca_id_unmap(struct mlx5_eswitch *esw,
+				  struct mlx5_vport *vport);
 int mlx5_eswitch_vhca_id_to_vport(struct mlx5_eswitch *esw, u16 vhca_id, u16 *vport_num);
 
 /**
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index bee906661282..19decaa8a96e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -4161,23 +4161,28 @@ u32 mlx5_eswitch_get_vport_metadata_for_match(struct mlx5_eswitch *esw,
 }
 EXPORT_SYMBOL(mlx5_eswitch_get_vport_metadata_for_match);
 
-int mlx5_esw_vport_vhca_id_set(struct mlx5_eswitch *esw, u16 vport_num)
+int mlx5_esw_vport_vhca_id_map(struct mlx5_eswitch *esw,
+			       struct mlx5_vport *vport)
 {
 	u16 *old_entry, *vhca_map_entry, vhca_id;
-	int err;
 
-	err = mlx5_vport_get_vhca_id(esw->dev, vport_num, &vhca_id);
-	if (err) {
-		esw_warn(esw->dev, "Getting vhca_id for vport failed (vport=%u,err=%d)\n",
-			 vport_num, err);
-		return err;
+	if (WARN_ONCE(MLX5_VPORT_INVAL_VHCA_ID(vport),
+		      "vport %d vhca_id is not set", vport->vport)) {
+		int err;
+
+		err = mlx5_vport_get_vhca_id(vport->dev, vport->vport,
+					     &vhca_id);
+		if (err)
+			return err;
+		vport->vhca_id = vhca_id;
 	}
 
+	vhca_id = vport->vhca_id;
 	vhca_map_entry = kmalloc(sizeof(*vhca_map_entry), GFP_KERNEL);
 	if (!vhca_map_entry)
 		return -ENOMEM;
 
-	*vhca_map_entry = vport_num;
+	*vhca_map_entry = vport->vport;
 	old_entry = xa_store(&esw->offloads.vhca_map, vhca_id, vhca_map_entry, GFP_KERNEL);
 	if (xa_is_err(old_entry)) {
 		kfree(vhca_map_entry);
@@ -4187,17 +4192,12 @@ int mlx5_esw_vport_vhca_id_set(struct mlx5_eswitch *esw, u16 vport_num)
 	return 0;
 }
 
-void mlx5_esw_vport_vhca_id_clear(struct mlx5_eswitch *esw, u16 vport_num)
+void mlx5_esw_vport_vhca_id_unmap(struct mlx5_eswitch *esw,
+				  struct mlx5_vport *vport)
 {
-	u16 *vhca_map_entry, vhca_id;
-	int err;
-
-	err = mlx5_vport_get_vhca_id(esw->dev, vport_num, &vhca_id);
-	if (err)
-		esw_warn(esw->dev, "Getting vhca_id for vport failed (vport=%hu,err=%d)\n",
-			 vport_num, err);
+	u16 *vhca_map_entry;
 
-	vhca_map_entry = xa_erase(&esw->offloads.vhca_map, vhca_id);
+	vhca_map_entry = xa_erase(&esw->offloads.vhca_map, vport->vhca_id);
 	kfree(vhca_map_entry);
 }
 
-- 
2.50.1


