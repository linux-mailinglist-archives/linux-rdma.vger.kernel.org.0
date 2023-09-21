Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4322B7A97DE
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Sep 2023 19:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjIUR2S (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Sep 2023 13:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjIUR1q (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Sep 2023 13:27:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025A92125
        for <linux-rdma@vger.kernel.org>; Thu, 21 Sep 2023 10:02:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5DD3C4E66C;
        Thu, 21 Sep 2023 12:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695298271;
        bh=nQbecW5KmlTkWdndJhZ6rqRN2QTdw4WnEiNBWTXDovM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j6RzQF5hidF88T/JYOINtc1A7d+Yx/zYvZv+7vOy/7gWCvdQhCDHe4Ypg6+I+9Myj
         5LFhWwFI+zLpWJIz59gLTvV9Mio3rgQgDSqKYRqdbKTxF85ZUPqEfb76+2UWxTSXpW
         zLJFY7t64WpHn2w21b4xk6Zb8Y2mCpob71UCqfYJuqbhw1Cj09GDk396p5MyiThmhf
         xfA1dwSx6bPVuP4sQRGPNmScFapuygkgN0u64ePuvvIDL9KO8UgmWY258IJ9BQ2yIm
         O2nvAlAH3XEyeG0CCUfen25J4j0SwDW7VEqxsmPrRDFBG59BPxJFn1smrW5Uh36dCD
         oAfb0QBuWQGiQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Patrisious Haddad <phaddad@nvidia.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-rdma@vger.kernel.org,
        Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Simon Horman <horms@kernel.org>
Subject: [PATCH mlx5-next 7/9] net/mlx5: Configure IPsec steering for egress RoCEv2 MPV traffic
Date:   Thu, 21 Sep 2023 15:10:33 +0300
Message-ID: <7ca5cf1ac5c6979359b8726e97510574e2b3d44d.1695296682.git.leon@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1695296682.git.leon@kernel.org>
References: <cover.1695296682.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Patrisious Haddad <phaddad@nvidia.com>

Add steering tables/rules in RDMA_TX master domain, to forward all traffic
to IPsec crypto table in NIC domain.
But in case the traffic is coming from the slave, have to first send the
traffic to an alias table in order to switch gvmi and from there we can
go to the appropriate gvmi crypto table in NIC domain.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c    |   2 +-
 .../net/ethernet/mellanox/mlx5/core/fs_core.c |   4 +-
 .../mellanox/mlx5/core/lib/ipsec_fs_roce.c    | 223 +++++++++++++++++-
 .../mellanox/mlx5/core/lib/ipsec_fs_roce.h    |   3 +-
 4 files changed, 225 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
index 4315e4f3d6cd..38848bb7bea1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
@@ -562,7 +562,7 @@ static int ipsec_counter_rule_tx(struct mlx5_core_dev *mdev, struct mlx5e_ipsec_
 static void tx_destroy(struct mlx5e_ipsec *ipsec, struct mlx5e_ipsec_tx *tx,
 		       struct mlx5_ipsec_fs *roce)
 {
-	mlx5_ipsec_fs_roce_tx_destroy(roce);
+	mlx5_ipsec_fs_roce_tx_destroy(roce, ipsec->mdev);
 	if (tx->chains) {
 		ipsec_chains_destroy(tx->chains);
 	} else {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index a13b9c2bd144..fdb4885ae217 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -137,7 +137,7 @@
 #define LAG_MIN_LEVEL (OFFLOADS_MIN_LEVEL + KERNEL_RX_MACSEC_MIN_LEVEL + 1)
 
 #define KERNEL_TX_IPSEC_NUM_PRIOS  1
-#define KERNEL_TX_IPSEC_NUM_LEVELS 3
+#define KERNEL_TX_IPSEC_NUM_LEVELS 4
 #define KERNEL_TX_IPSEC_MIN_LEVEL        (KERNEL_TX_IPSEC_NUM_LEVELS)
 
 #define KERNEL_TX_MACSEC_NUM_PRIOS  1
@@ -288,7 +288,7 @@ enum {
 #define RDMA_TX_BYPASS_MIN_LEVEL MLX5_BY_PASS_NUM_PRIOS
 #define RDMA_TX_COUNTERS_MIN_LEVEL (RDMA_TX_BYPASS_MIN_LEVEL + 1)
 
-#define RDMA_TX_IPSEC_NUM_PRIOS 1
+#define RDMA_TX_IPSEC_NUM_PRIOS 2
 #define RDMA_TX_IPSEC_PRIO_NUM_LEVELS 1
 #define RDMA_TX_IPSEC_MIN_LEVEL  (RDMA_TX_COUNTERS_MIN_LEVEL + RDMA_TX_IPSEC_NUM_PRIOS)
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/ipsec_fs_roce.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/ipsec_fs_roce.c
index 648f3d7ab68b..a82ccae7b614 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/ipsec_fs_roce.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/ipsec_fs_roce.c
@@ -2,6 +2,8 @@
 /* Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
 
 #include "fs_core.h"
+#include "fs_cmd.h"
+#include "en.h"
 #include "lib/ipsec_fs_roce.h"
 #include "mlx5_core.h"
 #include <linux/random.h>
@@ -25,6 +27,8 @@ struct mlx5_ipsec_tx_roce {
 	struct mlx5_flow_group *g;
 	struct mlx5_flow_table *ft;
 	struct mlx5_flow_handle *rule;
+	struct mlx5_flow_table *goto_alias_ft;
+	u32 alias_id;
 	struct mlx5_flow_namespace *ns;
 };
 
@@ -187,9 +191,200 @@ static int ipsec_fs_roce_tx_rule_setup(struct mlx5_core_dev *mdev,
 	return err;
 }
 
-void mlx5_ipsec_fs_roce_tx_destroy(struct mlx5_ipsec_fs *ipsec_roce)
+static int ipsec_fs_roce_tx_mpv_rule_setup(struct mlx5_core_dev *mdev,
+					   struct mlx5_ipsec_tx_roce *roce,
+					   struct mlx5_flow_table *pol_ft)
 {
+	struct mlx5_flow_destination dst = {};
+	MLX5_DECLARE_FLOW_ACT(flow_act);
+	struct mlx5_flow_handle *rule;
+	struct mlx5_flow_spec *spec;
+	int err = 0;
+
+	spec = kvzalloc(sizeof(*spec), GFP_KERNEL);
+	if (!spec)
+		return -ENOMEM;
+
+	spec->match_criteria_enable = MLX5_MATCH_MISC_PARAMETERS;
+	MLX5_SET_TO_ONES(fte_match_param, spec->match_criteria, misc_parameters.source_vhca_port);
+	MLX5_SET(fte_match_param, spec->match_value, misc_parameters.source_vhca_port,
+		 MLX5_CAP_GEN(mdev, native_port_num));
+
+	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_FWD_DEST;
+	dst.type = MLX5_FLOW_DESTINATION_TYPE_TABLE_TYPE;
+	dst.ft = roce->goto_alias_ft;
+	rule = mlx5_add_flow_rules(roce->ft, spec, &flow_act, &dst, 1);
+	if (IS_ERR(rule)) {
+		err = PTR_ERR(rule);
+		mlx5_core_err(mdev, "Fail to add TX RoCE IPsec rule err=%d\n",
+			      err);
+		goto out;
+	}
+	roce->rule = rule;
+
+	/* No need for miss rule, since on miss we go to next PRIO, in which
+	 * if master is configured, he will catch the traffic to go to his
+	 * encryption table.
+	 */
+
+out:
+	kvfree(spec);
+	return err;
+}
+
+#define MLX5_TX_ROCE_GROUP_SIZE BIT(0)
+#define MLX5_IPSEC_RDMA_TX_FT_LEVEL 0
+#define MLX5_IPSEC_NIC_GOTO_ALIAS_FT_LEVEL 3 /* Since last used level in NIC ipsec is 2 */
+
+static int ipsec_fs_roce_tx_mpv_create_ft(struct mlx5_core_dev *mdev,
+					  struct mlx5_ipsec_tx_roce *roce,
+					  struct mlx5_flow_table *pol_ft,
+					  struct mlx5e_priv *peer_priv)
+{
+	struct mlx5_flow_namespace *roce_ns, *nic_ns;
+	struct mlx5_flow_table_attr ft_attr = {};
+	struct mlx5_flow_table next_ft;
+	struct mlx5_flow_table *ft;
+	int err;
+
+	roce_ns = mlx5_get_flow_namespace(peer_priv->mdev, MLX5_FLOW_NAMESPACE_RDMA_TX_IPSEC);
+	if (!roce_ns)
+		return -EOPNOTSUPP;
+
+	nic_ns = mlx5_get_flow_namespace(peer_priv->mdev, MLX5_FLOW_NAMESPACE_EGRESS_IPSEC);
+	if (!nic_ns)
+		return -EOPNOTSUPP;
+
+	err = ipsec_fs_create_aliased_ft(mdev, peer_priv->mdev, pol_ft, &roce->alias_id);
+	if (err)
+		return err;
+
+	next_ft.id = roce->alias_id;
+	ft_attr.max_fte = 1;
+	ft_attr.next_ft = &next_ft;
+	ft_attr.level = MLX5_IPSEC_NIC_GOTO_ALIAS_FT_LEVEL;
+	ft_attr.flags = MLX5_FLOW_TABLE_UNMANAGED;
+	ft = mlx5_create_flow_table(nic_ns, &ft_attr);
+	if (IS_ERR(ft)) {
+		err = PTR_ERR(ft);
+		mlx5_core_err(mdev, "Fail to create RoCE IPsec goto alias ft err=%d\n", err);
+		goto destroy_alias;
+	}
+
+	roce->goto_alias_ft = ft;
+
+	memset(&ft_attr, 0, sizeof(ft_attr));
+	ft_attr.max_fte = 1;
+	ft_attr.level = MLX5_IPSEC_RDMA_TX_FT_LEVEL;
+	ft = mlx5_create_flow_table(roce_ns, &ft_attr);
+	if (IS_ERR(ft)) {
+		err = PTR_ERR(ft);
+		mlx5_core_err(mdev, "Fail to create RoCE IPsec tx ft err=%d\n", err);
+		goto destroy_alias_ft;
+	}
+
+	roce->ft = ft;
+
+	return 0;
+
+destroy_alias_ft:
+	mlx5_destroy_flow_table(roce->goto_alias_ft);
+destroy_alias:
+	mlx5_cmd_alias_obj_destroy(peer_priv->mdev, roce->alias_id,
+				   MLX5_GENERAL_OBJECT_TYPES_FLOW_TABLE_ALIAS);
+	return err;
+}
+
+static int ipsec_fs_roce_tx_mpv_create_group_rules(struct mlx5_core_dev *mdev,
+						   struct mlx5_ipsec_tx_roce *roce,
+						   struct mlx5_flow_table *pol_ft,
+						   u32 *in)
+{
+	struct mlx5_flow_group *g;
+	int ix = 0;
+	int err;
+	u8 *mc;
+
+	mc = MLX5_ADDR_OF(create_flow_group_in, in, match_criteria);
+	MLX5_SET_TO_ONES(fte_match_param, mc, misc_parameters.source_vhca_port);
+	MLX5_SET_CFG(in, match_criteria_enable, MLX5_MATCH_MISC_PARAMETERS);
+
+	MLX5_SET_CFG(in, start_flow_index, ix);
+	ix += MLX5_TX_ROCE_GROUP_SIZE;
+	MLX5_SET_CFG(in, end_flow_index, ix - 1);
+	g = mlx5_create_flow_group(roce->ft, in);
+	if (IS_ERR(g)) {
+		err = PTR_ERR(g);
+		mlx5_core_err(mdev, "Fail to create RoCE IPsec tx group err=%d\n", err);
+		return err;
+	}
+	roce->g = g;
+
+	err = ipsec_fs_roce_tx_mpv_rule_setup(mdev, roce, pol_ft);
+	if (err) {
+		mlx5_core_err(mdev, "Fail to create RoCE IPsec tx rules err=%d\n", err);
+		goto destroy_group;
+	}
+
+	return 0;
+
+destroy_group:
+	mlx5_destroy_flow_group(roce->g);
+	return err;
+}
+
+static int ipsec_fs_roce_tx_mpv_create(struct mlx5_core_dev *mdev,
+				       struct mlx5_ipsec_fs *ipsec_roce,
+				       struct mlx5_flow_table *pol_ft,
+				       u32 *in)
+{
+	struct mlx5_devcom_comp_dev *tmp = NULL;
+	struct mlx5_ipsec_tx_roce *roce;
+	struct mlx5e_priv *peer_priv;
+	int err;
+
+	if (!mlx5_devcom_for_each_peer_begin(*ipsec_roce->devcom))
+		return -EOPNOTSUPP;
+
+	peer_priv = mlx5_devcom_get_next_peer_data(*ipsec_roce->devcom, &tmp);
+	if (!peer_priv) {
+		err = -EOPNOTSUPP;
+		goto release_peer;
+	}
+
+	roce = &ipsec_roce->tx;
+
+	err = ipsec_fs_roce_tx_mpv_create_ft(mdev, roce, pol_ft, peer_priv);
+	if (err) {
+		mlx5_core_err(mdev, "Fail to create RoCE IPsec tables err=%d\n", err);
+		goto release_peer;
+	}
+
+	err = ipsec_fs_roce_tx_mpv_create_group_rules(mdev, roce, pol_ft, in);
+	if (err) {
+		mlx5_core_err(mdev, "Fail to create RoCE IPsec tx group/rule err=%d\n", err);
+		goto destroy_tables;
+	}
+
+	mlx5_devcom_for_each_peer_end(*ipsec_roce->devcom);
+	return 0;
+
+destroy_tables:
+	mlx5_destroy_flow_table(roce->ft);
+	mlx5_destroy_flow_table(roce->goto_alias_ft);
+	mlx5_cmd_alias_obj_destroy(peer_priv->mdev, roce->alias_id,
+				   MLX5_GENERAL_OBJECT_TYPES_FLOW_TABLE_ALIAS);
+release_peer:
+	mlx5_devcom_for_each_peer_end(*ipsec_roce->devcom);
+	return err;
+}
+
+void mlx5_ipsec_fs_roce_tx_destroy(struct mlx5_ipsec_fs *ipsec_roce,
+				   struct mlx5_core_dev *mdev)
+{
+	struct mlx5_devcom_comp_dev *tmp = NULL;
 	struct mlx5_ipsec_tx_roce *tx_roce;
+	struct mlx5e_priv *peer_priv;
 
 	if (!ipsec_roce)
 		return;
@@ -199,9 +394,24 @@ void mlx5_ipsec_fs_roce_tx_destroy(struct mlx5_ipsec_fs *ipsec_roce)
 	mlx5_del_flow_rules(tx_roce->rule);
 	mlx5_destroy_flow_group(tx_roce->g);
 	mlx5_destroy_flow_table(tx_roce->ft);
-}
 
-#define MLX5_TX_ROCE_GROUP_SIZE BIT(0)
+	if (!mlx5_core_is_mp_slave(mdev))
+		return;
+
+	if (!mlx5_devcom_for_each_peer_begin(*ipsec_roce->devcom))
+		return;
+
+	peer_priv = mlx5_devcom_get_next_peer_data(*ipsec_roce->devcom, &tmp);
+	if (!peer_priv) {
+		mlx5_devcom_for_each_peer_end(*ipsec_roce->devcom);
+		return;
+	}
+
+	mlx5_destroy_flow_table(tx_roce->goto_alias_ft);
+	mlx5_cmd_alias_obj_destroy(peer_priv->mdev, tx_roce->alias_id,
+				   MLX5_GENERAL_OBJECT_TYPES_FLOW_TABLE_ALIAS);
+	mlx5_devcom_for_each_peer_end(*ipsec_roce->devcom);
+}
 
 int mlx5_ipsec_fs_roce_tx_create(struct mlx5_core_dev *mdev,
 				 struct mlx5_ipsec_fs *ipsec_roce,
@@ -224,7 +434,14 @@ int mlx5_ipsec_fs_roce_tx_create(struct mlx5_core_dev *mdev,
 	if (!in)
 		return -ENOMEM;
 
+	if (mlx5_core_is_mp_slave(mdev)) {
+		err = ipsec_fs_roce_tx_mpv_create(mdev, ipsec_roce, pol_ft, in);
+		goto free_in;
+	}
+
 	ft_attr.max_fte = 1;
+	ft_attr.prio = 1;
+	ft_attr.level = MLX5_IPSEC_RDMA_TX_FT_LEVEL;
 	ft = mlx5_create_flow_table(roce->ns, &ft_attr);
 	if (IS_ERR(ft)) {
 		err = PTR_ERR(ft);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/ipsec_fs_roce.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/ipsec_fs_roce.h
index 75475e126181..ad120caf269e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/ipsec_fs_roce.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/ipsec_fs_roce.h
@@ -17,7 +17,8 @@ int mlx5_ipsec_fs_roce_rx_create(struct mlx5_core_dev *mdev,
 				 struct mlx5_flow_namespace *ns,
 				 struct mlx5_flow_destination *default_dst,
 				 u32 family, u32 level, u32 prio);
-void mlx5_ipsec_fs_roce_tx_destroy(struct mlx5_ipsec_fs *ipsec_roce);
+void mlx5_ipsec_fs_roce_tx_destroy(struct mlx5_ipsec_fs *ipsec_roce,
+				   struct mlx5_core_dev *mdev);
 int mlx5_ipsec_fs_roce_tx_create(struct mlx5_core_dev *mdev,
 				 struct mlx5_ipsec_fs *ipsec_roce,
 				 struct mlx5_flow_table *pol_ft);
-- 
2.41.0

