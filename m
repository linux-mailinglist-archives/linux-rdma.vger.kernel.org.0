Return-Path: <linux-rdma+bounces-8150-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C0FA45FFE
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 14:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58D713A7106
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 13:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9A1213235;
	Wed, 26 Feb 2025 13:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JUU47i5F"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3E2149C50;
	Wed, 26 Feb 2025 13:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740574914; cv=none; b=qhwBFGvmqgchprcQvyM63Oa9AwNv0SBY2X4+LGgBdaRUA9mZ6/jlQ5n5g3P7A3uUwBb3soGnRUmmdkI0WnCwiwJfu5PrGdt3lz9WKU6BIu19IJey1PW7k5k6S7itqMvqdc6Yrnqry6tSYN42s+Jbx1ud5WWrejXogNyitVf46Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740574914; c=relaxed/simple;
	bh=LZthb+nAmbm5nHQKjSpvG21hEq4apLNLftAkGq/zHUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J4rRIuqLy3etK6Xgs3YWqT7Wc/7Un6cnLQtgt5TN6YzLWuQPct7SEPGgLjNgukmSAal71/mtvkisZ22ytWWKfOpokoStz56s9Qw95hiVi76plhymbC+1GoMxAnIPY8NHULDBvyj5UEfCyGyGQow/YT1cbH5R0SPLOLLUllrVZ/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JUU47i5F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F343AC4CED6;
	Wed, 26 Feb 2025 13:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740574913;
	bh=LZthb+nAmbm5nHQKjSpvG21hEq4apLNLftAkGq/zHUk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JUU47i5F0NMlZrELKqb9OCVQ/4/csb6HN2MShNbIyWeCtcAzUmIURQase6jM/BArL
	 d04ahWrOV3zgQpaGg96wtB9LkFbahu2hmtbY3ulOgW+1JZ1aGuBmSgShR7Xqk662D+
	 nJZ1TrDjaE8mXpNqXPQDBM7RRnWg5VUkhDjDsLtkdcQqNM8slRMD3HFPtLnMD1As+G
	 r7wiG7u0OsVMtnbHoQ3MhGeQ9tnzp3A63pbIcO/3gE4b4aoWnJDpkbPiNC1da3Iy9F
	 eQIDuraW6xIIb0v3m9xgq42YU4qNZ56d4ZEBB7CoxH2rqFj+6mtHNAktTtQOfsiywQ
	 VOkOOfpDHfarA==
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
Subject: [PATCH mlx5-next 5/5] net/mlx5: fs, add RDMA TRANSPORT steering domain support
Date: Wed, 26 Feb 2025 15:01:09 +0200
Message-ID: <a6b550d9859a197eafa804b9a8d76916ca481da9.1740574103.git.leon@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740574103.git.leon@kernel.org>
References: <cover.1740574103.git.leon@kernel.org>
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
 include/linux/mlx5/fs.h                       |  10 +-
 7 files changed, 195 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/acl/helper.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/acl/helper.c
index d599e50af346..3ce455c2535c 100644
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
index 20cc01ceee8a..1ee5791573d8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -2828,9 +2828,9 @@ static int esw_set_master_egress_rule(struct mlx5_core_dev *master,
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
index ae20c061e0fb..a47c29571f64 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
@@ -1142,6 +1142,8 @@ const struct mlx5_flow_cmds *mlx5_fs_cmd_get_default(enum fs_flow_table_type typ
 	case FS_FT_RDMA_RX:
 	case FS_FT_RDMA_TX:
 	case FS_FT_PORT_SEL:
+	case FS_FT_RDMA_TRANSPORT_RX:
+	case FS_FT_RDMA_TRANSPORT_TX:
 		return mlx5_fs_cmd_get_fw_cmds();
 	default:
 		return mlx5_fs_cmd_get_stub_cmds();
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index 22dc23d991d2..6163bc98d94a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -1456,7 +1456,7 @@ mlx5_create_auto_grouped_flow_table(struct mlx5_flow_namespace *ns,
 	struct mlx5_flow_table *ft;
 	int autogroups_max_fte;
 
-	ft = mlx5_create_flow_table(ns, ft_attr);
+	ft = mlx5_create_vport_flow_table(ns, ft_attr, ft_attr->vport);
 	if (IS_ERR(ft))
 		return ft;
 
@@ -2764,9 +2764,9 @@ struct mlx5_flow_namespace *mlx5_get_flow_namespace(struct mlx5_core_dev *dev,
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
 
@@ -2775,25 +2775,43 @@ struct mlx5_flow_namespace *mlx5_get_flow_vport_acl_namespace(struct mlx5_core_d
 
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
@@ -3199,6 +3217,127 @@ static int init_rdma_tx_root_ns(struct mlx5_flow_steering *steering)
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
@@ -3631,6 +3770,7 @@ void mlx5_fs_core_cleanup(struct mlx5_core_dev *dev)
 	cleanup_root_ns(steering->rdma_rx_root_ns);
 	cleanup_root_ns(steering->rdma_tx_root_ns);
 	cleanup_root_ns(steering->egress_root_ns);
+	cleanup_rdma_transport_roots_ns(steering);
 
 	devl_params_unregister(priv_to_devlink(dev), mlx5_fs_params,
 			       ARRAY_SIZE(mlx5_fs_params));
@@ -3700,6 +3840,18 @@ int mlx5_fs_core_init(struct mlx5_core_dev *dev)
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
@@ -3850,8 +4002,10 @@ mlx5_get_root_namespace(struct mlx5_core_dev *dev, enum mlx5_flow_namespace_type
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
index 20837e526679..dbe747e93841 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
@@ -115,7 +115,9 @@ enum fs_flow_table_type {
 	FS_FT_PORT_SEL		= 0X9,
 	FS_FT_FDB_RX		= 0xa,
 	FS_FT_FDB_TX		= 0xb,
-	FS_FT_MAX_TYPE = FS_FT_FDB_TX,
+	FS_FT_RDMA_TRANSPORT_RX	= 0xd,
+	FS_FT_RDMA_TRANSPORT_TX	= 0xe,
+	FS_FT_MAX_TYPE = FS_FT_RDMA_TRANSPORT_TX,
 };
 
 enum fs_flow_table_op_mod {
@@ -158,6 +160,10 @@ struct mlx5_flow_steering {
 	struct mlx5_flow_root_namespace	*port_sel_root_ns;
 	int esw_egress_acl_vports;
 	int esw_ingress_acl_vports;
+	struct mlx5_flow_root_namespace **rdma_transport_rx_root_ns;
+	struct mlx5_flow_root_namespace **rdma_transport_tx_root_ns;
+	int rdma_transport_rx_vports;
+	int rdma_transport_tx_vports;
 };
 
 struct fs_node {
@@ -434,7 +440,9 @@ struct mlx5_flow_root_namespace *find_root(struct fs_node *node);
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
index 0ae6d69c5221..8fe56d0362c6 100644
--- a/include/linux/mlx5/device.h
+++ b/include/linux/mlx5/device.h
@@ -1346,6 +1346,12 @@ enum mlx5_qcam_feature_groups {
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
index 01cb72d68c23..fd62b2b1611d 100644
--- a/include/linux/mlx5/fs.h
+++ b/include/linux/mlx5/fs.h
@@ -40,6 +40,7 @@
 
 #define MLX5_SET_CFG(p, f, v) MLX5_SET(create_flow_group_in, p, f, v)
 
+#define MLX5_RDMA_TRANSPORT_BYPASS_PRIO 0
 #define MLX5_FS_MAX_POOL_SIZE BIT(30)
 
 enum mlx5_flow_destination_type {
@@ -110,6 +111,8 @@ enum mlx5_flow_namespace_type {
 	MLX5_FLOW_NAMESPACE_RDMA_TX_IPSEC,
 	MLX5_FLOW_NAMESPACE_RDMA_RX_MACSEC,
 	MLX5_FLOW_NAMESPACE_RDMA_TX_MACSEC,
+	MLX5_FLOW_NAMESPACE_RDMA_TRANSPORT_RX,
+	MLX5_FLOW_NAMESPACE_RDMA_TRANSPORT_TX,
 };
 
 enum {
@@ -194,9 +197,9 @@ struct mlx5_flow_namespace *
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
@@ -204,6 +207,7 @@ struct mlx5_flow_table_attr {
 	u32 level;
 	u32 flags;
 	u16 uid;
+	u16 vport;
 	struct mlx5_flow_table *next_ft;
 
 	struct {
-- 
2.48.1


