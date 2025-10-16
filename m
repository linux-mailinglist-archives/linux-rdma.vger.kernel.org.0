Return-Path: <linux-rdma+bounces-13880-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19863BE12ED
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Oct 2025 03:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2C623B5FBF
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Oct 2025 01:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB6F1F91E3;
	Thu, 16 Oct 2025 01:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R46rJkgV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9391E5B94;
	Thu, 16 Oct 2025 01:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760578859; cv=none; b=ZNJXghxKaO1Cvj5BPgzKHTcw1ZOAxu0M+OEojmQCBOtgnlSMpHky3Pflv0vmUohPoJRaYge0Ja1X1WBDiC6S9s0CYARI8ctaZHc826uMwLXDpmfEocw1ZQ/+pk5/o5VTaWcMpJxKdT+E+xqecb9g8Sxu94NJHl6AAyEGaksqDoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760578859; c=relaxed/simple;
	bh=GynKnnHZslkBNHCGoKRahhXNtYvu8NDRoXjMS7P7C0o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kJYWMUEicdOqQV2kAFj4kN9J/hXi3USrHhpcbA3pN68Xzrlamfzl7NHnwDj9d8lU++gtH47V+QeYzUYu5YaoqH0gE/9tha9ubiK+9Y/5KoQcpAjulALk+IK2LjL9nsfwTevE4+j7m+zZ5MibVOJRILHN1PkL2hl11bxo+VarcTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R46rJkgV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E00DC4CEF8;
	Thu, 16 Oct 2025 01:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760578859;
	bh=GynKnnHZslkBNHCGoKRahhXNtYvu8NDRoXjMS7P7C0o=;
	h=From:To:Cc:Subject:Date:From;
	b=R46rJkgVW3CcWvkqbEsi/R7JYOG5mEv5pbD2wgbR4M1q5gzXcpieRPBG6gpU7HKzi
	 ob4v0Bi2TECygCcpO2CvWdEcqahrFOZAO18rgzGhFMXGnFX0XKxcQOqVtNQvjjz4S8
	 jkCcw0NsSP/l2DGrwP8zfqIH31pqcXHl+0q27sFTKUd2kHg7ZedgC6cG6VttYhSqJh
	 7+6QuNpb3zfMjuN+zBx/wYDlIndapmgI2LM1HOSVYnPEisa0iODPyXWenQnehhTK9N
	 WHRNviiWtNyCaBnfTl44sa8J3WRH9ezjAu7ykUThSqjxH76njHQNGl6E2n70Goy/og
	 7kauFsaoqAxaw==
From: Saeed Mahameed <saeed@kernel.org>
To: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH mlx5-next] {rdma,net}/mlx5: Query vports mac address from device
Date: Wed, 15 Oct 2025 18:40:55 -0700
Message-ID: <20251016014055.2040934-1-saeed@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Adithya Jayachandran <ajayachandra@nvidia.com>

Before this patch during either switchdev or legacy mode enablement we
cleared the mac address of vports between changes. This change allows us
to preserve the vports mac address between eswitch mode changes.

Signed-off-by: Adithya Jayachandran <ajayachandra@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c             |  2 +-
 .../net/ethernet/mellanox/mlx5/core/eswitch.c | 20 ++++++----------
 .../mellanox/mlx5/core/eswitch_offloads.c     |  3 +++
 .../net/ethernet/mellanox/mlx5/core/vport.c   | 24 +++++++++----------
 include/linux/mlx5/vport.h                    |  3 ++-
 5 files changed, 25 insertions(+), 27 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index fc1e86f6c409..90daa58126f4 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -842,7 +842,7 @@ static int mlx5_query_node_guid(struct mlx5_ib_dev *dev,
 		break;
 
 	case MLX5_VPORT_ACCESS_METHOD_NIC:
-		err = mlx5_query_nic_vport_node_guid(dev->mdev, &tmp);
+		err = mlx5_query_nic_vport_node_guid(dev->mdev, 0, false, &tmp);
 		break;
 
 	default:
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index e2ffb87b94cb..25af8bd7f077 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -875,13 +875,10 @@ static int esw_vport_setup(struct mlx5_eswitch *esw, struct mlx5_vport *vport)
 				      vport_num, 1,
 				      vport->info.link_state);
 
-	/* Host PF has its own mac/guid. */
-	if (vport_num) {
-		mlx5_modify_nic_vport_mac_address(esw->dev, vport_num,
-						  vport->info.mac);
-		mlx5_modify_nic_vport_node_guid(esw->dev, vport_num,
-						vport->info.node_guid);
-	}
+	mlx5_query_nic_vport_mac_address(esw->dev, vport_num, true,
+					 vport->info.mac);
+	mlx5_query_nic_vport_node_guid(esw->dev, vport_num, true,
+				       &vport->info.node_guid);
 
 	flags = (vport->info.vlan || vport->info.qos) ?
 		SET_VLAN_STRIP | SET_VLAN_INSERT : 0;
@@ -947,12 +944,6 @@ int mlx5_esw_vport_enable(struct mlx5_eswitch *esw, struct mlx5_vport *vport,
 			goto err_vhca_mapping;
 	}
 
-	/* External controller host PF has factory programmed MAC.
-	 * Read it from the device.
-	 */
-	if (mlx5_core_is_ecpf(esw->dev) && vport_num == MLX5_VPORT_PF)
-		mlx5_query_nic_vport_mac_address(esw->dev, vport_num, true, vport->info.mac);
-
 	esw_vport_change_handle_locked(vport);
 
 	esw->enabled_vports++;
@@ -2235,6 +2226,9 @@ int mlx5_eswitch_get_vport_config(struct mlx5_eswitch *esw,
 	ivi->vf = vport - 1;
 
 	mutex_lock(&esw->state_lock);
+
+	mlx5_query_nic_vport_mac_address(esw->dev, vport, true,
+					 evport->info.mac);
 	ether_addr_copy(ivi->mac, evport->info.mac);
 	ivi->linkstate = evport->info.link_state;
 	ivi->vlan = evport->info.vlan;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 4cf995be127d..880e238497b1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -4303,6 +4303,9 @@ int mlx5_devlink_port_fn_hw_addr_get(struct devlink_port *port,
 	struct mlx5_vport *vport = mlx5_devlink_port_vport_get(port);
 
 	mutex_lock(&esw->state_lock);
+
+	mlx5_query_nic_vport_mac_address(esw->dev, vport->vport, true,
+					 vport->info.mac);
 	ether_addr_copy(hw_addr, vport->info.mac);
 	*hw_addr_len = ETH_ALEN;
 	mutex_unlock(&esw->state_lock);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/vport.c b/drivers/net/ethernet/mellanox/mlx5/core/vport.c
index 2ed2e530b07d..d1483f66cd0c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/vport.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/vport.c
@@ -78,15 +78,14 @@ int mlx5_modify_vport_admin_state(struct mlx5_core_dev *mdev, u8 opmod,
 }
 
 static int mlx5_query_nic_vport_context(struct mlx5_core_dev *mdev, u16 vport,
-					u32 *out)
+					bool other_vport, u32 *out)
 {
 	u32 in[MLX5_ST_SZ_DW(query_nic_vport_context_in)] = {};
 
 	MLX5_SET(query_nic_vport_context_in, in, opcode,
 		 MLX5_CMD_OP_QUERY_NIC_VPORT_CONTEXT);
 	MLX5_SET(query_nic_vport_context_in, in, vport_number, vport);
-	if (vport)
-		MLX5_SET(query_nic_vport_context_in, in, other_vport, 1);
+	MLX5_SET(query_nic_vport_context_in, in, other_vport, other_vport);
 
 	return mlx5_cmd_exec_inout(mdev, query_nic_vport_context, in, out);
 }
@@ -97,7 +96,7 @@ int mlx5_query_nic_vport_min_inline(struct mlx5_core_dev *mdev,
 	u32 out[MLX5_ST_SZ_DW(query_nic_vport_context_out)] = {};
 	int err;
 
-	err = mlx5_query_nic_vport_context(mdev, vport, out);
+	err = mlx5_query_nic_vport_context(mdev, vport, vport > 0, out);
 	if (!err)
 		*min_inline = MLX5_GET(query_nic_vport_context_out, out,
 				       nic_vport_context.min_wqe_inline_mode);
@@ -219,7 +218,7 @@ int mlx5_query_nic_vport_mtu(struct mlx5_core_dev *mdev, u16 *mtu)
 	if (!out)
 		return -ENOMEM;
 
-	err = mlx5_query_nic_vport_context(mdev, 0, out);
+	err = mlx5_query_nic_vport_context(mdev, 0, false, out);
 	if (!err)
 		*mtu = MLX5_GET(query_nic_vport_context_out, out,
 				nic_vport_context.mtu);
@@ -429,7 +428,7 @@ int mlx5_query_nic_vport_system_image_guid(struct mlx5_core_dev *mdev,
 	if (!out)
 		return -ENOMEM;
 
-	err = mlx5_query_nic_vport_context(mdev, 0, out);
+	err = mlx5_query_nic_vport_context(mdev, 0, false, out);
 	if (err)
 		goto out;
 
@@ -451,7 +450,7 @@ int mlx5_query_nic_vport_sd_group(struct mlx5_core_dev *mdev, u8 *sd_group)
 	if (!out)
 		return -ENOMEM;
 
-	err = mlx5_query_nic_vport_context(mdev, 0, out);
+	err = mlx5_query_nic_vport_context(mdev, 0, false, out);
 	if (err)
 		goto out;
 
@@ -462,7 +461,8 @@ int mlx5_query_nic_vport_sd_group(struct mlx5_core_dev *mdev, u8 *sd_group)
 	return err;
 }
 
-int mlx5_query_nic_vport_node_guid(struct mlx5_core_dev *mdev, u64 *node_guid)
+int mlx5_query_nic_vport_node_guid(struct mlx5_core_dev *mdev,
+				   u16 vport, bool other_vport, u64 *node_guid)
 {
 	u32 *out;
 	int outlen = MLX5_ST_SZ_BYTES(query_nic_vport_context_out);
@@ -472,7 +472,7 @@ int mlx5_query_nic_vport_node_guid(struct mlx5_core_dev *mdev, u64 *node_guid)
 	if (!out)
 		return -ENOMEM;
 
-	err = mlx5_query_nic_vport_context(mdev, 0, out);
+	err = mlx5_query_nic_vport_context(mdev, vport, other_vport, out);
 	if (err)
 		goto out;
 
@@ -529,7 +529,7 @@ int mlx5_query_nic_vport_qkey_viol_cntr(struct mlx5_core_dev *mdev,
 	if (!out)
 		return -ENOMEM;
 
-	err = mlx5_query_nic_vport_context(mdev, 0, out);
+	err = mlx5_query_nic_vport_context(mdev, 0, false, out);
 	if (err)
 		goto out;
 
@@ -804,7 +804,7 @@ int mlx5_query_nic_vport_promisc(struct mlx5_core_dev *mdev,
 	if (!out)
 		return -ENOMEM;
 
-	err = mlx5_query_nic_vport_context(mdev, vport, out);
+	err = mlx5_query_nic_vport_context(mdev, vport, vport > 0, out);
 	if (err)
 		goto out;
 
@@ -908,7 +908,7 @@ int mlx5_nic_vport_query_local_lb(struct mlx5_core_dev *mdev, bool *status)
 	if (!out)
 		return -ENOMEM;
 
-	err = mlx5_query_nic_vport_context(mdev, 0, out);
+	err = mlx5_query_nic_vport_context(mdev, 0, false, out);
 	if (err)
 		goto out;
 
diff --git a/include/linux/mlx5/vport.h b/include/linux/mlx5/vport.h
index c87b9507cfa1..f876bfc0669c 100644
--- a/include/linux/mlx5/vport.h
+++ b/include/linux/mlx5/vport.h
@@ -73,7 +73,8 @@ int mlx5_modify_nic_vport_mtu(struct mlx5_core_dev *mdev, u16 mtu);
 int mlx5_query_nic_vport_system_image_guid(struct mlx5_core_dev *mdev,
 					   u64 *system_image_guid);
 int mlx5_query_nic_vport_sd_group(struct mlx5_core_dev *mdev, u8 *sd_group);
-int mlx5_query_nic_vport_node_guid(struct mlx5_core_dev *mdev, u64 *node_guid);
+int mlx5_query_nic_vport_node_guid(struct mlx5_core_dev *mdev,
+				   u16 vport, bool other_vport, u64 *node_guid);
 int mlx5_modify_nic_vport_node_guid(struct mlx5_core_dev *mdev,
 				    u16 vport, u64 node_guid);
 int mlx5_query_nic_vport_qkey_viol_cntr(struct mlx5_core_dev *mdev,
-- 
2.51.0


