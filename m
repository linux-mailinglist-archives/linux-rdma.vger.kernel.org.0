Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAAC8232DC3
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Jul 2020 10:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729884AbgG3IOS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Jul 2020 04:14:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:52118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729690AbgG3IMr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 30 Jul 2020 04:12:47 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38F03208A9;
        Thu, 30 Jul 2020 08:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596096766;
        bh=VQT90ehm774arNpOiP1flkbGseZqYae+c7kP+kPrSpc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jSZkBFxHBZmYXDMhB2QFkCCqBJcSuyJLMgYtP6o6sciBnd+lPYyQKq5Jz4Cz0GH72
         cy57K2wA5AsSgjcG7L7Q74wt0momzWE9j1dCuYZZ9hZRIDOY1AK1znSJnETfDMitRv
         GIbNuRBLKZNt6Y3ZB3owhBrQ4XOyjaMTb6Bvskqk=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 1/3] RDMA/mlx5: Simplify multiple else-if cases with switch keyword
Date:   Thu, 30 Jul 2020 11:12:33 +0300
Message-Id: <20200730081235.1581127-2-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200730081235.1581127-1-leon@kernel.org>
References: <20200730081235.1581127-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Improve readability of fs.c by converting multiple else-if constructions
to be implemented with switch keyword.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/fs.c | 124 +++++++++++++++++++-------------
 1 file changed, 75 insertions(+), 49 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/fs.c b/drivers/infiniband/hw/mlx5/fs.c
index d75f461eba50..922037b55393 100644
--- a/drivers/infiniband/hw/mlx5/fs.c
+++ b/drivers/infiniband/hw/mlx5/fs.c
@@ -767,6 +767,7 @@ static struct mlx5_ib_flow_prio *get_flow_table(struct mlx5_ib_dev *dev,
 {
 	bool dont_trap = flow_attr->flags & IB_FLOW_ATTR_FLAGS_DONT_TRAP;
 	struct mlx5_flow_namespace *ns = NULL;
+	enum mlx5_flow_namespace_type fn_type;
 	struct mlx5_ib_flow_prio *prio;
 	struct mlx5_flow_table *ft;
 	int max_table_size;
@@ -780,11 +781,9 @@ static struct mlx5_ib_flow_prio *get_flow_table(struct mlx5_ib_dev *dev,
 						       log_max_ft_size));
 	esw_encap = mlx5_eswitch_get_encap_mode(dev->mdev) !=
 		DEVLINK_ESWITCH_ENCAP_MODE_NONE;
-	if (flow_attr->type == IB_FLOW_ATTR_NORMAL) {
-		enum mlx5_flow_namespace_type fn_type;
-
-		if (flow_is_multicast_only(flow_attr) &&
-		    !dont_trap)
+	switch (flow_attr->type) {
+	case IB_FLOW_ATTR_NORMAL:
+		if (flow_is_multicast_only(flow_attr) && !dont_trap)
 			priority = MLX5_IB_FLOW_MCAST_PRIO;
 		else
 			priority = ib_prio_to_core_prio(flow_attr->priority,
@@ -797,12 +796,11 @@ static struct mlx5_ib_flow_prio *get_flow_table(struct mlx5_ib_dev *dev,
 				flags |= MLX5_FLOW_TABLE_TUNNEL_EN_DECAP;
 			if (!dev->is_rep && !esw_encap &&
 			    MLX5_CAP_FLOWTABLE_NIC_RX(dev->mdev,
-					reformat_l3_tunnel_to_l2))
+						      reformat_l3_tunnel_to_l2))
 				flags |= MLX5_FLOW_TABLE_TUNNEL_EN_REFORMAT;
 		} else {
-			max_table_size =
-				BIT(MLX5_CAP_FLOWTABLE_NIC_TX(dev->mdev,
-							      log_max_ft_size));
+			max_table_size = BIT(MLX5_CAP_FLOWTABLE_NIC_TX(
+				dev->mdev, log_max_ft_size));
 			fn_type = MLX5_FLOW_NAMESPACE_EGRESS;
 			prio = &dev->flow_db->egress_prios[priority];
 			if (!dev->is_rep && !esw_encap &&
@@ -812,27 +810,31 @@ static struct mlx5_ib_flow_prio *get_flow_table(struct mlx5_ib_dev *dev,
 		ns = mlx5_get_flow_namespace(dev->mdev, fn_type);
 		num_entries = MLX5_FS_MAX_ENTRIES;
 		num_groups = MLX5_FS_MAX_TYPES;
-	} else if (flow_attr->type == IB_FLOW_ATTR_ALL_DEFAULT ||
-		   flow_attr->type == IB_FLOW_ATTR_MC_DEFAULT) {
+		break;
+	case IB_FLOW_ATTR_ALL_DEFAULT:
+	case IB_FLOW_ATTR_MC_DEFAULT:
 		ns = mlx5_get_flow_namespace(dev->mdev,
 					     MLX5_FLOW_NAMESPACE_LEFTOVERS);
-		build_leftovers_ft_param(&priority,
-					 &num_entries,
-					 &num_groups);
+		build_leftovers_ft_param(&priority, &num_entries, &num_groups);
 		prio = &dev->flow_db->prios[MLX5_IB_FLOW_LEFTOVERS_PRIO];
-	} else if (flow_attr->type == IB_FLOW_ATTR_SNIFFER) {
+		break;
+	case IB_FLOW_ATTR_SNIFFER:
 		if (!MLX5_CAP_FLOWTABLE(dev->mdev,
 					allow_sniffer_and_nic_rx_shared_tir))
 			return ERR_PTR(-EOPNOTSUPP);
 
-		ns = mlx5_get_flow_namespace(dev->mdev, ft_type == MLX5_IB_FT_RX ?
-					     MLX5_FLOW_NAMESPACE_SNIFFER_RX :
-					     MLX5_FLOW_NAMESPACE_SNIFFER_TX);
+		ns = mlx5_get_flow_namespace(
+			dev->mdev, ft_type == MLX5_IB_FT_RX ?
+					   MLX5_FLOW_NAMESPACE_SNIFFER_RX :
+					   MLX5_FLOW_NAMESPACE_SNIFFER_TX);
 
 		prio = &dev->flow_db->sniffer[ft_type];
 		priority = 0;
 		num_entries = 1;
 		num_groups = 1;
+		break;
+	default:
+		break;
 	}
 
 	if (!ns)
@@ -1246,19 +1248,22 @@ static struct ib_flow *mlx5_ib_create_flow(struct ib_qp *qp,
 			dst->tir_num = mqp->raw_packet_qp.rq.tirn;
 	}
 
-	if (flow_attr->type == IB_FLOW_ATTR_NORMAL) {
+	switch (flow_attr->type) {
+	case IB_FLOW_ATTR_NORMAL:
 		underlay_qpn = (mqp->flags & IB_QP_CREATE_SOURCE_QPN) ?
 				       mqp->underlay_qpn :
 				       0;
 		handler = _create_flow_rule(dev, ft_prio, flow_attr, dst,
 					    underlay_qpn, ucmd);
-	} else if (flow_attr->type == IB_FLOW_ATTR_ALL_DEFAULT ||
-		   flow_attr->type == IB_FLOW_ATTR_MC_DEFAULT) {
-		handler = create_leftovers_rule(dev, ft_prio, flow_attr,
-						dst);
-	} else if (flow_attr->type == IB_FLOW_ATTR_SNIFFER) {
+		break;
+	case IB_FLOW_ATTR_ALL_DEFAULT:
+	case IB_FLOW_ATTR_MC_DEFAULT:
+		handler = create_leftovers_rule(dev, ft_prio, flow_attr, dst);
+		break;
+	case IB_FLOW_ATTR_SNIFFER:
 		handler = create_sniffer_rule(dev, ft_prio, ft_prio_tx, dst);
-	} else {
+		break;
+	default:
 		err = -EINVAL;
 		goto destroy_ft;
 	}
@@ -1306,39 +1311,47 @@ _get_flow_table(struct mlx5_ib_dev *dev,
 
 	esw_encap = mlx5_eswitch_get_encap_mode(dev->mdev) !=
 		DEVLINK_ESWITCH_ENCAP_MODE_NONE;
-	if (fs_matcher->ns_type == MLX5_FLOW_NAMESPACE_BYPASS) {
-		max_table_size = BIT(MLX5_CAP_FLOWTABLE_NIC_RX(dev->mdev,
-					log_max_ft_size));
+	switch (fs_matcher->ns_type) {
+	case MLX5_FLOW_NAMESPACE_BYPASS:
+		max_table_size = BIT(
+			MLX5_CAP_FLOWTABLE_NIC_RX(dev->mdev, log_max_ft_size));
 		if (MLX5_CAP_FLOWTABLE_NIC_RX(dev->mdev, decap) && !esw_encap)
 			flags |= MLX5_FLOW_TABLE_TUNNEL_EN_DECAP;
 		if (MLX5_CAP_FLOWTABLE_NIC_RX(dev->mdev,
 					      reformat_l3_tunnel_to_l2) &&
 		    !esw_encap)
 			flags |= MLX5_FLOW_TABLE_TUNNEL_EN_REFORMAT;
-	} else if (fs_matcher->ns_type == MLX5_FLOW_NAMESPACE_EGRESS) {
+		break;
+	case MLX5_FLOW_NAMESPACE_EGRESS:
 		max_table_size = BIT(
 			MLX5_CAP_FLOWTABLE_NIC_TX(dev->mdev, log_max_ft_size));
-		if (MLX5_CAP_FLOWTABLE_NIC_TX(dev->mdev, reformat) && !esw_encap)
+		if (MLX5_CAP_FLOWTABLE_NIC_TX(dev->mdev, reformat) &&
+		    !esw_encap)
 			flags |= MLX5_FLOW_TABLE_TUNNEL_EN_REFORMAT;
-	} else if (fs_matcher->ns_type == MLX5_FLOW_NAMESPACE_FDB) {
+		break;
+	case MLX5_FLOW_NAMESPACE_FDB:
 		max_table_size = BIT(
 			MLX5_CAP_ESW_FLOWTABLE_FDB(dev->mdev, log_max_ft_size));
 		if (MLX5_CAP_ESW_FLOWTABLE_FDB(dev->mdev, decap) && esw_encap)
 			flags |= MLX5_FLOW_TABLE_TUNNEL_EN_DECAP;
-		if (MLX5_CAP_ESW_FLOWTABLE_FDB(dev->mdev, reformat_l3_tunnel_to_l2) &&
+		if (MLX5_CAP_ESW_FLOWTABLE_FDB(dev->mdev,
+					       reformat_l3_tunnel_to_l2) &&
 		    esw_encap)
 			flags |= MLX5_FLOW_TABLE_TUNNEL_EN_REFORMAT;
 		priority = FDB_BYPASS_PATH;
-	} else if (fs_matcher->ns_type == MLX5_FLOW_NAMESPACE_RDMA_RX) {
-		max_table_size =
-			BIT(MLX5_CAP_FLOWTABLE_RDMA_RX(dev->mdev,
-						       log_max_ft_size));
+		break;
+	case MLX5_FLOW_NAMESPACE_RDMA_RX:
+		max_table_size = BIT(
+			MLX5_CAP_FLOWTABLE_RDMA_RX(dev->mdev, log_max_ft_size));
 		priority = fs_matcher->priority;
-	} else if (fs_matcher->ns_type == MLX5_FLOW_NAMESPACE_RDMA_TX) {
-		max_table_size =
-			BIT(MLX5_CAP_FLOWTABLE_RDMA_TX(dev->mdev,
-						       log_max_ft_size));
+		break;
+	case MLX5_FLOW_NAMESPACE_RDMA_TX:
+		max_table_size = BIT(
+			MLX5_CAP_FLOWTABLE_RDMA_TX(dev->mdev, log_max_ft_size));
 		priority = fs_matcher->priority;
+		break;
+	default:
+		break;
 	}
 
 	max_table_size = min_t(int, max_table_size, MLX5_FS_MAX_ENTRIES);
@@ -1347,16 +1360,24 @@ _get_flow_table(struct mlx5_ib_dev *dev,
 	if (!ns)
 		return ERR_PTR(-EOPNOTSUPP);
 
-	if (fs_matcher->ns_type == MLX5_FLOW_NAMESPACE_BYPASS)
+	switch (fs_matcher->ns_type) {
+	case MLX5_FLOW_NAMESPACE_BYPASS:
 		prio = &dev->flow_db->prios[priority];
-	else if (fs_matcher->ns_type == MLX5_FLOW_NAMESPACE_EGRESS)
+		break;
+	case MLX5_FLOW_NAMESPACE_EGRESS:
 		prio = &dev->flow_db->egress_prios[priority];
-	else if (fs_matcher->ns_type == MLX5_FLOW_NAMESPACE_FDB)
+		break;
+	case MLX5_FLOW_NAMESPACE_FDB:
 		prio = &dev->flow_db->fdb;
-	else if (fs_matcher->ns_type == MLX5_FLOW_NAMESPACE_RDMA_RX)
+		break;
+	case MLX5_FLOW_NAMESPACE_RDMA_RX:
 		prio = &dev->flow_db->rdma_rx[priority];
-	else if (fs_matcher->ns_type == MLX5_FLOW_NAMESPACE_RDMA_TX)
+		break;
+	case MLX5_FLOW_NAMESPACE_RDMA_TX:
 		prio = &dev->flow_db->rdma_tx[priority];
+		break;
+	default: return ERR_PTR(-EINVAL);
+	}
 
 	if (!prio)
 		return ERR_PTR(-EINVAL);
@@ -1489,20 +1510,25 @@ static struct mlx5_ib_flow_handler *raw_fs_rule_add(
 		goto unlock;
 	}
 
-	if (dest_type == MLX5_FLOW_DESTINATION_TYPE_TIR) {
+	switch (dest_type) {
+	case MLX5_FLOW_DESTINATION_TYPE_TIR:
 		dst[dst_num].type = dest_type;
 		dst[dst_num++].tir_num = dest_id;
 		flow_act->action |= MLX5_FLOW_CONTEXT_ACTION_FWD_DEST;
-	} else if (dest_type == MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE) {
+		break;
+	case MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE:
 		dst[dst_num].type = MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE_NUM;
 		dst[dst_num++].ft_num = dest_id;
 		flow_act->action |= MLX5_FLOW_CONTEXT_ACTION_FWD_DEST;
-	} else  if (dest_type == MLX5_FLOW_DESTINATION_TYPE_PORT) {
+		break;
+	case MLX5_FLOW_DESTINATION_TYPE_PORT:
 		dst[dst_num++].type = MLX5_FLOW_DESTINATION_TYPE_PORT;
 		flow_act->action |= MLX5_FLOW_CONTEXT_ACTION_ALLOW;
+		break;
+	default:
+		break;
 	}
 
-
 	if (flow_act->action & MLX5_FLOW_CONTEXT_ACTION_COUNT) {
 		dst[dst_num].type = MLX5_FLOW_DESTINATION_TYPE_COUNTER;
 		dst[dst_num].counter_id = counter_id;
-- 
2.26.2

