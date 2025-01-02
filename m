Return-Path: <linux-rdma+bounces-6780-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D89529FF8E9
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jan 2025 12:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 059193A110B
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jan 2025 11:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46531AF0B9;
	Thu,  2 Jan 2025 11:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jqshaQOb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFA5A95E;
	Thu,  2 Jan 2025 11:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735817789; cv=none; b=Q1PjxMTW09V832OfFQGW9SDjG7HtNu4q+dc3ByU76k2r2pNrsERHe7LGgSJsLW+eolV5vGiCCHwUrSZpXfB/1K0GRW7hbbROfysK/s3H3x+xZPLPssAqzOTB9Y2QZjL1oL00rMw0aL0SZy+tA8gvZ1wTXsWKEZ0cu2Os0SW9EpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735817789; c=relaxed/simple;
	bh=ppGDMEb+m27awcR8mcuKL5QE0e253ExWJlInEelY84Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tEptSjJmQpjb63QujiQCprt0yEqA48nJmhSd563yc8zJMmjG1vMNwjQIy6EPuMts6qNMaa+bcIniILQUkuXZ1g+Suk08oNfOAFP2j0KM1O3OImGZgxGwfV7Gi7ah7EVdhWPq2QGfM1GRZ44HcuFTHps++JkP3XNx60IashGzBsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jqshaQOb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 087A9C4CED0;
	Thu,  2 Jan 2025 11:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735817789;
	bh=ppGDMEb+m27awcR8mcuKL5QE0e253ExWJlInEelY84Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jqshaQObjGwRYxwXEIo1uGKBdNFiRpm/Mks0poY5YINiK8/HO+oPpCtu8Y6vJiC/K
	 2Qhqm2OKfz4yR6NOPhmHsCZOkb0MaAHorLuUGNmuCZlpWtWWRqsb8JixN5mcp8TaHe
	 OBVq7iAwO3gE16I0YSZGBaML/pxk5iy0G7D9P0IeBuQwL/rSJSKjIsG2lar+WoruAY
	 7owRlxq5h12+Htpk5gTJJVqLWIosq7R9OF5Tnfa7IY/LsQGJ94kj3GVdsMKWzqSLG6
	 rFsGlZW7XaJ3/IKbaJyyNUdBlaFgNsaxS4qHmaX/hoDG7PeosT4k2O2TM9ftEnBcfV
	 YGQEPFRI7qCaA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Patrisious Haddad <phaddad@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-rdma@vger.kernel.org,
	Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH mlx5-next 2/3] net/mlx5: fs, add RDMA TRANSPORT steering domain support
Date: Thu,  2 Jan 2025 13:36:06 +0200
Message-ID: <27799a1503e49643e07fc74ce45d047e950922e8.1735817449.git.leon@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1735817449.git.leon@kernel.org>
References: <cover.1735817449.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Patrisious Haddad <phaddad@nvidia.com>

Add RX and TX RDMA_TRANSPORT flow table namespace, and the ability
to create flow tables in those namespaces.

The RDMA_TRANSPORT RX and TX are per vport.

Packets will traverse through RDMA_TRANSPORT_RX after RDMA_RX and through
RDMA_TRANSPORT_TX before RDMA_TX, ensuring proper control and management.

RDMA_TRANSPORT domains are managed by the vport group manager.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 .../mellanox/mlx5/core/esw/acl/helper.c       |   2 +-
 .../mellanox/mlx5/core/eswitch_offloads.c     |   6 +-
 .../net/ethernet/mellanox/mlx5/core/fs_cmd.c  |   2 +
 .../net/ethernet/mellanox/mlx5/core/fs_core.c | 178 ++++++++++++++++--
 .../net/ethernet/mellanox/mlx5/core/fs_core.h |  12 +-
 include/linux/mlx5/device.h                   |   6 +
 include/linux/mlx5/fs.h                       |  11 +-
 7 files changed, 196 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/acl/helper.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/acl/helper.c
index d599e50af346b..3ce455c2535c4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/acl/helper.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/acl/helper.c
@@ -27,7 +27,7 @@ esw_acl_table_create(struct mlx5_eswitch *esw, struct mlx5_vport *vport, int ns,
 	esw_debug(dev, "Create vport[%d] %s ACL table\n", vport_num,
 		  ns == MLX5_FLOW_NAMESPACE_ESW_INGRESS ? "ingress" : "egress");
 
-	root_ns = mlx5_get_flow_vport_acl_namespace(dev, ns, vport->index);
+	root_ns = mlx5_get_flow_vport_namespace(dev, ns, vport->index);
 	if (!root_ns) {
 		esw_warn(dev, "Failed to get E-Switch root namespace for vport (%d)\n",
 			 vport_num);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index d5b42b3a19fdf..fdbb79a83c900 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -2831,9 +2831,9 @@ static int esw_set_master_egress_rule(struct mlx5_core_dev *master,
 	if (IS_ERR(vport))
 		return PTR_ERR(vport);
 
-	egress_ns = mlx5_get_flow_vport_acl_namespace(master,
-						      MLX5_FLOW_NAMESPACE_ESW_EGRESS,
-						      vport->index);
+	egress_ns = mlx5_get_flow_vport_namespace(master,
+						  MLX5_FLOW_NAMESPACE_ESW_EGRESS,
+						  vport->index);
 	if (!egress_ns)
 		return -EINVAL;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
index 676005854dad4..86f9c0fbed928 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
@@ -1141,6 +1141,8 @@ const struct mlx5_flow_cmds *mlx5_fs_cmd_get_default(enum fs_flow_table_type typ
 	case FS_FT_RDMA_RX:
 	case FS_FT_RDMA_TX:
 	case FS_FT_PORT_SEL:
+	case FS_FT_RDMA_TRANSPORT_RX:
+	case FS_FT_RDMA_TRANSPORT_TX:
 		return mlx5_fs_cmd_get_fw_cmds();
 	default:
 		return mlx5_fs_cmd_get_stub_cmds();
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index 2eabfcc247c6a..879c36a88a26c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -1449,7 +1449,7 @@ mlx5_create_auto_grouped_flow_table(struct mlx5_flow_namespace *ns,
 	struct mlx5_flow_table *ft;
 	int autogroups_max_fte;
 
-	ft = mlx5_create_flow_table(ns, ft_attr);
+	ft = mlx5_create_vport_flow_table(ns, ft_attr, ft_attr->vport);
 	if (IS_ERR(ft))
 		return ft;
 
@@ -2756,9 +2756,9 @@ struct mlx5_flow_namespace *mlx5_get_flow_namespace(struct mlx5_core_dev *dev,
 }
 EXPORT_SYMBOL(mlx5_get_flow_namespace);
 
-struct mlx5_flow_namespace *mlx5_get_flow_vport_acl_namespace(struct mlx5_core_dev *dev,
-							      enum mlx5_flow_namespace_type type,
-							      int vport)
+struct mlx5_flow_namespace *
+mlx5_get_flow_vport_namespace(struct mlx5_core_dev *dev,
+			      enum mlx5_flow_namespace_type type, int vport_idx)
 {
 	struct mlx5_flow_steering *steering = dev->priv.steering;
 
@@ -2767,25 +2767,43 @@ struct mlx5_flow_namespace *mlx5_get_flow_vport_acl_namespace(struct mlx5_core_d
 
 	switch (type) {
 	case MLX5_FLOW_NAMESPACE_ESW_EGRESS:
-		if (vport >= steering->esw_egress_acl_vports)
+		if (vport_idx >= steering->esw_egress_acl_vports)
 			return NULL;
 		if (steering->esw_egress_root_ns &&
-		    steering->esw_egress_root_ns[vport])
-			return &steering->esw_egress_root_ns[vport]->ns;
+		    steering->esw_egress_root_ns[vport_idx])
+			return &steering->esw_egress_root_ns[vport_idx]->ns;
 		else
 			return NULL;
 	case MLX5_FLOW_NAMESPACE_ESW_INGRESS:
-		if (vport >= steering->esw_ingress_acl_vports)
+		if (vport_idx >= steering->esw_ingress_acl_vports)
 			return NULL;
 		if (steering->esw_ingress_root_ns &&
-		    steering->esw_ingress_root_ns[vport])
-			return &steering->esw_ingress_root_ns[vport]->ns;
+		    steering->esw_ingress_root_ns[vport_idx])
+			return &steering->esw_ingress_root_ns[vport_idx]->ns;
+		else
+			return NULL;
+	case MLX5_FLOW_NAMESPACE_RDMA_TRANSPORT_RX:
+		if (vport_idx >= steering->rdma_transport_rx_vports)
+			return NULL;
+		if (steering->rdma_transport_rx_root_ns &&
+		    steering->rdma_transport_rx_root_ns[vport_idx])
+			return &steering->rdma_transport_rx_root_ns[vport_idx]->ns;
+		else
+			return NULL;
+	case MLX5_FLOW_NAMESPACE_RDMA_TRANSPORT_TX:
+		if (vport_idx >= steering->rdma_transport_tx_vports)
+			return NULL;
+
+		if (steering->rdma_transport_tx_root_ns &&
+		    steering->rdma_transport_tx_root_ns[vport_idx])
+			return &steering->rdma_transport_tx_root_ns[vport_idx]->ns;
 		else
 			return NULL;
 	default:
 		return NULL;
 	}
 }
+EXPORT_SYMBOL(mlx5_get_flow_vport_namespace);
 
 static struct fs_prio *_fs_create_prio(struct mlx5_flow_namespace *ns,
 				       unsigned int prio,
@@ -3191,6 +3209,127 @@ static int init_rdma_tx_root_ns(struct mlx5_flow_steering *steering)
 	return err;
 }
 
+static int
+init_rdma_transport_rx_root_ns_one(struct mlx5_flow_steering *steering,
+				   int vport_idx)
+{
+	struct fs_prio *prio;
+
+	steering->rdma_transport_rx_root_ns[vport_idx] =
+		create_root_ns(steering, FS_FT_RDMA_TRANSPORT_RX);
+	if (!steering->rdma_transport_rx_root_ns[vport_idx])
+		return -ENOMEM;
+
+	/* create 1 prio*/
+	prio = fs_create_prio(&steering->rdma_transport_rx_root_ns[vport_idx]->ns,
+			      MLX5_RDMA_TRANSPORT_BYPASS_PRIO, 1);
+	return PTR_ERR_OR_ZERO(prio);
+}
+
+static int
+init_rdma_transport_tx_root_ns_one(struct mlx5_flow_steering *steering,
+				   int vport_idx)
+{
+	struct fs_prio *prio;
+
+	steering->rdma_transport_tx_root_ns[vport_idx] =
+		create_root_ns(steering, FS_FT_RDMA_TRANSPORT_TX);
+	if (!steering->rdma_transport_tx_root_ns[vport_idx])
+		return -ENOMEM;
+
+	/* create 1 prio*/
+	prio = fs_create_prio(&steering->rdma_transport_tx_root_ns[vport_idx]->ns,
+			      MLX5_RDMA_TRANSPORT_BYPASS_PRIO, 1);
+	return PTR_ERR_OR_ZERO(prio);
+}
+
+static int init_rdma_transport_rx_root_ns(struct mlx5_flow_steering *steering)
+{
+	struct mlx5_core_dev *dev = steering->dev;
+	int total_vports;
+	int err;
+	int i;
+
+	/* In case eswitch not supported and working in legacy mode */
+	total_vports = mlx5_eswitch_get_total_vports(dev) ?: 1;
+
+	steering->rdma_transport_rx_root_ns =
+			kcalloc(total_vports,
+				sizeof(*steering->rdma_transport_rx_root_ns),
+				GFP_KERNEL);
+	if (!steering->rdma_transport_rx_root_ns)
+		return -ENOMEM;
+
+	for (i = 0; i < total_vports; i++) {
+		err = init_rdma_transport_rx_root_ns_one(steering, i);
+		if (err)
+			goto cleanup_root_ns;
+	}
+	steering->rdma_transport_rx_vports = total_vports;
+	return 0;
+
+cleanup_root_ns:
+	while (i--)
+		cleanup_root_ns(steering->rdma_transport_rx_root_ns[i]);
+	kfree(steering->rdma_transport_rx_root_ns);
+	steering->rdma_transport_rx_root_ns = NULL;
+	return err;
+}
+
+static int init_rdma_transport_tx_root_ns(struct mlx5_flow_steering *steering)
+{
+	struct mlx5_core_dev *dev = steering->dev;
+	int total_vports;
+	int err;
+	int i;
+
+	/* In case eswitch not supported and working in legacy mode */
+	total_vports = mlx5_eswitch_get_total_vports(dev) ?: 1;
+
+	steering->rdma_transport_tx_root_ns =
+			kcalloc(total_vports,
+				sizeof(*steering->rdma_transport_tx_root_ns),
+				GFP_KERNEL);
+	if (!steering->rdma_transport_tx_root_ns)
+		return -ENOMEM;
+
+	for (i = 0; i < total_vports; i++) {
+		err = init_rdma_transport_tx_root_ns_one(steering, i);
+		if (err)
+			goto cleanup_root_ns;
+	}
+	steering->rdma_transport_tx_vports = total_vports;
+	return 0;
+
+cleanup_root_ns:
+	while (i--)
+		cleanup_root_ns(steering->rdma_transport_tx_root_ns[i]);
+	kfree(steering->rdma_transport_tx_root_ns);
+	steering->rdma_transport_tx_root_ns = NULL;
+	return err;
+}
+
+static void cleanup_rdma_transport_roots_ns(struct mlx5_flow_steering *steering)
+{
+	int i;
+
+	if (steering->rdma_transport_rx_root_ns) {
+		for (i = 0; i < steering->rdma_transport_rx_vports; i++)
+			cleanup_root_ns(steering->rdma_transport_rx_root_ns[i]);
+
+		kfree(steering->rdma_transport_rx_root_ns);
+		steering->rdma_transport_rx_root_ns = NULL;
+	}
+
+	if (steering->rdma_transport_tx_root_ns) {
+		for (i = 0; i < steering->rdma_transport_tx_vports; i++)
+			cleanup_root_ns(steering->rdma_transport_tx_root_ns[i]);
+
+		kfree(steering->rdma_transport_tx_root_ns);
+		steering->rdma_transport_tx_root_ns = NULL;
+	}
+}
+
 /* FT and tc chains are stored in the same array so we can re-use the
  * mlx5_get_fdb_sub_ns() and tc api for FT chains.
  * When creating a new ns for each chain store it in the first available slot.
@@ -3607,6 +3746,7 @@ void mlx5_fs_core_cleanup(struct mlx5_core_dev *dev)
 	cleanup_root_ns(steering->rdma_rx_root_ns);
 	cleanup_root_ns(steering->rdma_tx_root_ns);
 	cleanup_root_ns(steering->egress_root_ns);
+	cleanup_rdma_transport_roots_ns(steering);
 
 	devl_params_unregister(priv_to_devlink(dev), mlx5_fs_params,
 			       ARRAY_SIZE(mlx5_fs_params));
@@ -3677,6 +3817,18 @@ int mlx5_fs_core_init(struct mlx5_core_dev *dev)
 			goto err;
 	}
 
+	if (MLX5_CAP_FLOWTABLE_RDMA_TRANSPORT_RX(dev, ft_support)) {
+		err = init_rdma_transport_rx_root_ns(steering);
+		if (err)
+			goto err;
+	}
+
+	if (MLX5_CAP_FLOWTABLE_RDMA_TRANSPORT_TX(dev, ft_support)) {
+		err = init_rdma_transport_tx_root_ns(steering);
+		if (err)
+			goto err;
+	}
+
 	return 0;
 
 err:
@@ -3827,8 +3979,10 @@ mlx5_get_root_namespace(struct mlx5_core_dev *dev, enum mlx5_flow_namespace_type
 	struct mlx5_flow_namespace *ns;
 
 	if (ns_type == MLX5_FLOW_NAMESPACE_ESW_EGRESS ||
-	    ns_type == MLX5_FLOW_NAMESPACE_ESW_INGRESS)
-		ns = mlx5_get_flow_vport_acl_namespace(dev, ns_type, 0);
+	    ns_type == MLX5_FLOW_NAMESPACE_ESW_INGRESS ||
+	    ns_type == MLX5_FLOW_NAMESPACE_RDMA_TRANSPORT_TX ||
+	    ns_type == MLX5_FLOW_NAMESPACE_RDMA_TRANSPORT_RX)
+		ns = mlx5_get_flow_vport_namespace(dev, ns_type, 0);
 	else
 		ns = mlx5_get_flow_namespace(dev, ns_type);
 	if (!ns)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
index bad2df0715ecc..6da60e679dcb4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
@@ -112,7 +112,9 @@ enum fs_flow_table_type {
 	FS_FT_PORT_SEL		= 0X9,
 	FS_FT_FDB_RX		= 0xa,
 	FS_FT_FDB_TX		= 0xb,
-	FS_FT_MAX_TYPE = FS_FT_FDB_TX,
+	FS_FT_RDMA_TRANSPORT_RX	= 0xd,
+	FS_FT_RDMA_TRANSPORT_TX	= 0xe,
+	FS_FT_MAX_TYPE = FS_FT_RDMA_TRANSPORT_TX,
 };
 
 enum fs_flow_table_op_mod {
@@ -154,6 +156,10 @@ struct mlx5_flow_steering {
 	struct mlx5_flow_root_namespace	*port_sel_root_ns;
 	int esw_egress_acl_vports;
 	int esw_ingress_acl_vports;
+	struct mlx5_flow_root_namespace **rdma_transport_rx_root_ns;
+	struct mlx5_flow_root_namespace **rdma_transport_tx_root_ns;
+	int rdma_transport_rx_vports;
+	int rdma_transport_tx_vports;
 };
 
 struct fs_node {
@@ -382,7 +388,9 @@ struct mlx5_flow_root_namespace *find_root(struct fs_node *node);
 	(type == FS_FT_PORT_SEL) ? MLX5_CAP_FLOWTABLE_PORT_SELECTION(mdev, cap) :      \
 	(type == FS_FT_FDB_RX) ? MLX5_CAP_ESW_FLOWTABLE_FDB(mdev, cap) :      \
 	(type == FS_FT_FDB_TX) ? MLX5_CAP_ESW_FLOWTABLE_FDB(mdev, cap) :      \
-	(BUILD_BUG_ON_ZERO(FS_FT_FDB_TX != FS_FT_MAX_TYPE))\
+	(type == FS_FT_RDMA_TRANSPORT_RX) ? MLX5_CAP_FLOWTABLE_RDMA_TRANSPORT_RX(mdev, cap) :      \
+	(type == FS_FT_RDMA_TRANSPORT_TX) ? MLX5_CAP_FLOWTABLE_RDMA_TRANSPORT_TX(mdev, cap) :      \
+	(BUILD_BUG_ON_ZERO(FS_FT_RDMA_TRANSPORT_TX != FS_FT_MAX_TYPE))\
 	)
 
 #endif
diff --git a/include/linux/mlx5/device.h b/include/linux/mlx5/device.h
index da5bcde853da3..e33ea22463424 100644
--- a/include/linux/mlx5/device.h
+++ b/include/linux/mlx5/device.h
@@ -1344,6 +1344,12 @@ enum mlx5_qcam_feature_groups {
 #define MLX5_CAP_FLOWTABLE_RDMA_TX(mdev, cap) \
 	MLX5_CAP_FLOWTABLE(mdev, flow_table_properties_nic_transmit_rdma.cap)
 
+#define MLX5_CAP_FLOWTABLE_RDMA_TRANSPORT_RX(mdev, cap) \
+	MLX5_CAP_ADV_RDMA(mdev, rdma_transport_rx_flow_table_properties.cap)
+
+#define MLX5_CAP_FLOWTABLE_RDMA_TRANSPORT_TX(mdev, cap) \
+	MLX5_CAP_ADV_RDMA(mdev, rdma_transport_tx_flow_table_properties.cap)
+
 #define MLX5_CAP_ESW_FLOWTABLE(mdev, cap) \
 	MLX5_GET(flow_table_eswitch_cap, \
 		 mdev->caps.hca[MLX5_CAP_ESWITCH_FLOW_TABLE]->cur, cap)
diff --git a/include/linux/mlx5/fs.h b/include/linux/mlx5/fs.h
index 438db888bde0d..45c60a9ae8de3 100644
--- a/include/linux/mlx5/fs.h
+++ b/include/linux/mlx5/fs.h
@@ -40,6 +40,8 @@
 
 #define MLX5_SET_CFG(p, f, v) MLX5_SET(create_flow_group_in, p, f, v)
 
+#define MLX5_RDMA_TRANSPORT_BYPASS_PRIO 0
+
 enum mlx5_flow_destination_type {
 	MLX5_FLOW_DESTINATION_TYPE_NONE,
 	MLX5_FLOW_DESTINATION_TYPE_VPORT,
@@ -108,6 +110,8 @@ enum mlx5_flow_namespace_type {
 	MLX5_FLOW_NAMESPACE_RDMA_TX_IPSEC,
 	MLX5_FLOW_NAMESPACE_RDMA_RX_MACSEC,
 	MLX5_FLOW_NAMESPACE_RDMA_TX_MACSEC,
+	MLX5_FLOW_NAMESPACE_RDMA_TRANSPORT_RX,
+	MLX5_FLOW_NAMESPACE_RDMA_TRANSPORT_TX,
 };
 
 enum {
@@ -192,9 +196,9 @@ struct mlx5_flow_namespace *
 mlx5_get_flow_namespace(struct mlx5_core_dev *dev,
 			enum mlx5_flow_namespace_type type);
 struct mlx5_flow_namespace *
-mlx5_get_flow_vport_acl_namespace(struct mlx5_core_dev *dev,
-				  enum mlx5_flow_namespace_type type,
-				  int vport);
+mlx5_get_flow_vport_namespace(struct mlx5_core_dev *dev,
+			      enum mlx5_flow_namespace_type type,
+			      int vport_idx);
 
 struct mlx5_flow_table_attr {
 	int prio;
@@ -202,6 +206,7 @@ struct mlx5_flow_table_attr {
 	u32 level;
 	u32 flags;
 	u16 uid;
+	u16 vport;
 	struct mlx5_flow_table *next_ft;
 
 	struct {
-- 
2.47.1


