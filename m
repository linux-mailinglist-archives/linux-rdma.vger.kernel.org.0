Return-Path: <linux-rdma+bounces-3172-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50824909E5B
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Jun 2024 18:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 009012817B8
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Jun 2024 16:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D37917C6C;
	Sun, 16 Jun 2024 16:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lWpeJx9W"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04171D54F;
	Sun, 16 Jun 2024 16:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718554144; cv=none; b=bu58Wwy8xopwD6U3Dfk0O3L4ud73QkT57fc0NtNeLBYV5u1Qg9Yp4Vxu8YTs+Pgz0hWchxgOEhQw/zxSX4F3pLGlQybhfFz+gYOgMq+sWpDsJXoRfw3hbwLeWjOmmHLiNLbwCzDpwuEuRD4hzu8KK3aOxBzntUN7XPH78h2otBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718554144; c=relaxed/simple;
	bh=fcoAk42ZmXSoDiFV9ibLWtLT2KUITpLHo2920iegKlg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lS/6z7WxIpYi7GfNJBqAzDLZtzsImEQz4DzkJjANMGOmoT2te9YpkeecAoVVXWeykUPdm/D/dbt/BXAK8+QyiW/6EjC2DkGy90bgZ1TFXMZIQr07T1GRGKn7NYjbdtWIi8sTqOt0BnQkZ1J11MPRJkJiO0cHgpX1DX6FM6f49n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lWpeJx9W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E735DC2BBFC;
	Sun, 16 Jun 2024 16:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718554143;
	bh=fcoAk42ZmXSoDiFV9ibLWtLT2KUITpLHo2920iegKlg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lWpeJx9WVwvNCsKGoAkabH47Vf33uu3rwZtfBOf5m2w1Wm9ViMufgDxTqkRY/SPX8
	 yCpvbhPyYZE0aoQUMRKFaflNjekxYk0MYf+MaK8JsYciYfWFlLJSC2pSMU9bvlWX4/
	 hr5zYo5xsRUV0nvvGPz2XFAiT7I4+zABWX0dpdQIioTg+aW3BXJ7hLp/hjOUHZ11Ls
	 vQN6qESXTq4IfnhBlYc6PgGcKJG+qvY/vCwzsSwRSyfrs+hbg0apRFXfVmV06WRk1X
	 QFFRcdAJZXpfjMZTDPOcrcQxBLEirJHa027PHDIV22Gxwt3flCopAEIrI0lKT8gktF
	 Gzgwy9i9FZPuQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Mark Zhang <markzhang@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH mlx5-next 03/12] RDMA/mlx5: Add support to multi-plane device and port
Date: Sun, 16 Jun 2024 19:08:35 +0300
Message-ID: <7e37c06c9cb243be9ac79930cd17053903785b95.1718553901.git.leon@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1718553901.git.leon@kernel.org>
References: <cover.1718553901.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mark Zhang <markzhang@nvidia.com>

When multi-plane is supported, a logical port, which is aggregation of
multiple physical plane ports, is exposed for data transmission.
Compared with a normal mlx5 IB port, this logical port supports all
functionalities except Subnet Management.

Signed-off-by: Mark Zhang <markzhang@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c             | 60 ++++++++++++++++---
 drivers/infiniband/hw/mlx5/mlx5_ib.h          |  2 +
 .../net/ethernet/mellanox/mlx5/core/vport.c   |  1 +
 include/linux/mlx5/driver.h                   |  1 +
 4 files changed, 55 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index a7003316d438..55eb60715b48 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -1388,7 +1388,13 @@ static int mlx5_query_hca_port(struct ib_device *ibdev, u32 port,
 	props->sm_sl		= rep->sm_sl;
 	props->state		= rep->vport_state;
 	props->phys_state	= rep->port_physical_state;
-	props->port_cap_flags	= rep->cap_mask1;
+
+	props->port_cap_flags = rep->cap_mask1;
+	if (dev->num_plane) {
+		props->port_cap_flags |= IB_PORT_SM_DISABLED;
+		props->port_cap_flags &= ~IB_PORT_SM;
+	}
+
 	props->gid_tbl_len	= mlx5_get_gid_table_len(MLX5_CAP_GEN(mdev, gid_table_size));
 	props->max_msg_sz	= 1 << MLX5_CAP_GEN(mdev, log_max_msg);
 	props->pkey_tbl_len	= mlx5_to_sw_pkey_sz(MLX5_CAP_GEN(mdev, pkey_table_size));
@@ -2807,6 +2813,23 @@ static int mlx5_ib_event_slave_port(struct notifier_block *nb,
 	return NOTIFY_OK;
 }
 
+static int mlx5_ib_get_plane_num(struct mlx5_core_dev *mdev, u8 *num_plane)
+{
+	struct mlx5_hca_vport_context vport_ctx;
+	int err;
+
+	*num_plane = 0;
+	if (!MLX5_CAP_GEN(mdev, ib_virt))
+		return 0;
+
+	err = mlx5_query_hca_vport_context(mdev, 0, 1, 0, &vport_ctx);
+	if (err)
+		return err;
+
+	*num_plane = vport_ctx.num_plane;
+	return 0;
+}
+
 static int set_has_smi_cap(struct mlx5_ib_dev *dev)
 {
 	struct mlx5_hca_vport_context vport_ctx;
@@ -2817,10 +2840,14 @@ static int set_has_smi_cap(struct mlx5_ib_dev *dev)
 		return 0;
 
 	for (port = 1; port <= dev->num_ports; port++) {
-		if (!MLX5_CAP_GEN(dev->mdev, ib_virt)) {
+		if (dev->num_plane) {
+			dev->port_caps[port - 1].has_smi = false;
+			continue;
+		} else if (!MLX5_CAP_GEN(dev->mdev, ib_virt)) {
 			dev->port_caps[port - 1].has_smi = true;
 			continue;
 		}
+
 		err = mlx5_query_hca_vport_context(dev->mdev, 0, port, 0,
 						   &vport_ctx);
 		if (err) {
@@ -3026,6 +3053,11 @@ static u32 get_core_cap_flags(struct ib_device *ibdev,
 	if (rep->grh_required)
 		ret |= RDMA_CORE_CAP_IB_GRH_REQUIRED;
 
+	if (dev->num_plane)
+		return ret | RDMA_CORE_CAP_PROT_IB | RDMA_CORE_CAP_IB_MAD |
+			RDMA_CORE_CAP_IB_CM | RDMA_CORE_CAP_IB_SA |
+			RDMA_CORE_CAP_AF_IB;
+
 	if (ll == IB_LINK_LAYER_INFINIBAND)
 		return ret | RDMA_CORE_PORT_IBA_IB;
 
@@ -4507,11 +4539,18 @@ static int mlx5r_probe(struct auxiliary_device *adev,
 	dev = ib_alloc_device(mlx5_ib_dev, ib_dev);
 	if (!dev)
 		return -ENOMEM;
+
+	if (ll == IB_LINK_LAYER_INFINIBAND) {
+		ret = mlx5_ib_get_plane_num(mdev, &dev->num_plane);
+		if (ret)
+			goto fail;
+	}
+
 	dev->port = kcalloc(num_ports, sizeof(*dev->port),
 			     GFP_KERNEL);
 	if (!dev->port) {
-		ib_dealloc_device(&dev->ib_dev);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto fail;
 	}
 
 	dev->mdev = mdev;
@@ -4523,14 +4562,17 @@ static int mlx5r_probe(struct auxiliary_device *adev,
 		profile = &pf_profile;
 
 	ret = __mlx5_ib_add(dev, profile);
-	if (ret) {
-		kfree(dev->port);
-		ib_dealloc_device(&dev->ib_dev);
-		return ret;
-	}
+	if (ret)
+		goto fail_ib_add;
 
 	auxiliary_set_drvdata(adev, dev);
 	return 0;
+
+fail_ib_add:
+	kfree(dev->port);
+fail:
+	ib_dealloc_device(&dev->ib_dev);
+	return ret;
 }
 
 static void mlx5r_remove(struct auxiliary_device *adev)
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index a6f2b679a7e9..d97d6bc2dbaa 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1189,6 +1189,8 @@ struct mlx5_ib_dev {
 #ifdef CONFIG_MLX5_MACSEC
 	struct mlx5_macsec macsec;
 #endif
+
+	u8 num_plane;
 };
 
 static inline struct mlx5_ib_cq *to_mibcq(struct mlx5_core_cq *mcq)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/vport.c b/drivers/net/ethernet/mellanox/mlx5/core/vport.c
index 1005bb6935b6..0d5f750faa45 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/vport.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/vport.c
@@ -737,6 +737,7 @@ int mlx5_query_hca_vport_context(struct mlx5_core_dev *dev,
 	rep->grh_required = MLX5_GET_PR(hca_vport_context, ctx, grh_required);
 	rep->sys_image_guid = MLX5_GET64_PR(hca_vport_context, ctx,
 					    system_image_guid);
+	rep->num_plane = MLX5_GET_PR(hca_vport_context, ctx, num_port_plane);
 
 ex:
 	kvfree(out);
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 145e2fb1b832..2889ece6c808 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -917,6 +917,7 @@ struct mlx5_hca_vport_context {
 	u16			qkey_violation_counter;
 	u16			pkey_violation_counter;
 	bool			grh_required;
+	u8			num_plane;
 };
 
 #define STRUCT_FIELD(header, field) \
-- 
2.45.2


