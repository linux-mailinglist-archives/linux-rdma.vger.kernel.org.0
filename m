Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06ED77A9618
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Sep 2023 19:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjIUQ6z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Sep 2023 12:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjIUQ6x (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Sep 2023 12:58:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29461FC7
        for <linux-rdma@vger.kernel.org>; Thu, 21 Sep 2023 09:58:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3904DC4E66A;
        Thu, 21 Sep 2023 12:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695298275;
        bh=WLs0faSo17z4lcvhlF10ukzTR4xjZpSkiVSD3rg8jRI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cFwAKfskVKywl8Nsgh5I0f4bzj6D8BY8MEaYq+U4oI0byKzaE309GnySLtH/59tIO
         78ZKjxK66628ffcW0XepezPq+SJj7tyaY6p6j94UaMB8x3z7DLChCnlvfSVQyzU41N
         lbYZbXtkd4tpmcKaOV65Cxr5C5j2EB5SPP898tEa9Iaw2ed/mpfT+6oo3SM2V/XrFY
         Emk41mds8iX2V4LXSQ3Nzs+C/lJ6FD0fGYQy4I04geKRrpJfi83nlXiE342iGlKj/7
         /QmWVp8cGS96YOrwl+blLhxqFnWxpni68hewR0DMlB8XrrlkqjLUBFRxepfU2E7vQW
         54KJUXT6bdZYA==
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
Subject: [PATCH mlx5-next 8/9] net/mlx5: Configure IPsec steering for ingress RoCEv2 MPV traffic
Date:   Thu, 21 Sep 2023 15:10:34 +0300
Message-ID: <d2200b53158b1e7ef30996812107dd7207485c28.1695296682.git.leon@kernel.org>
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

Add empty flow table in RDMA_RX master domain, to forward all received
traffic to it, in order to continue through the FW RoCE steering.

In order to achieve that however, first we check if the decrypted
traffic is RoCEv2, if so then forward it to RDMA_RX domain.

But in case the traffic is coming from the slave, have to first send the
traffic to an alias table in order to switch gvmi and from there we can
go to the appropriate gvmi flow table in RDMA_RX master domain.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c    |   4 +-
 .../net/ethernet/mellanox/mlx5/core/fs_core.c |   6 +-
 .../mellanox/mlx5/core/lib/ipsec_fs_roce.c    | 216 ++++++++++++++++--
 .../mellanox/mlx5/core/lib/ipsec_fs_roce.h    |   2 +-
 4 files changed, 205 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
index 38848bb7bea1..86f1542b3ab7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
@@ -264,7 +264,7 @@ static void rx_destroy(struct mlx5_core_dev *mdev, struct mlx5e_ipsec *ipsec,
 	}
 	mlx5_destroy_flow_table(rx->ft.status);
 
-	mlx5_ipsec_fs_roce_rx_destroy(ipsec->roce, family);
+	mlx5_ipsec_fs_roce_rx_destroy(ipsec->roce, family, mdev);
 }
 
 static void ipsec_rx_create_attr_set(struct mlx5e_ipsec *ipsec,
@@ -422,7 +422,7 @@ static int rx_create(struct mlx5_core_dev *mdev, struct mlx5e_ipsec *ipsec,
 err_add:
 	mlx5_destroy_flow_table(rx->ft.status);
 err_fs_ft_status:
-	mlx5_ipsec_fs_roce_rx_destroy(ipsec->roce, family);
+	mlx5_ipsec_fs_roce_rx_destroy(ipsec->roce, family, mdev);
 	return err;
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index fdb4885ae217..e6bfa7e4f146 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -114,9 +114,9 @@
 #define ETHTOOL_NUM_PRIOS 11
 #define ETHTOOL_MIN_LEVEL (KERNEL_MIN_LEVEL + ETHTOOL_NUM_PRIOS)
 /* Promiscuous, Vlan, mac, ttc, inner ttc, {UDP/ANY/aRFS/accel/{esp, esp_err}}, IPsec policy,
- * IPsec RoCE policy
+ * {IPsec RoCE MPV,Alias table},IPsec RoCE policy
  */
-#define KERNEL_NIC_PRIO_NUM_LEVELS 9
+#define KERNEL_NIC_PRIO_NUM_LEVELS 11
 #define KERNEL_NIC_NUM_PRIOS 1
 /* One more level for tc */
 #define KERNEL_MIN_LEVEL (KERNEL_NIC_PRIO_NUM_LEVELS + 1)
@@ -231,7 +231,7 @@ enum {
 };
 
 #define RDMA_RX_IPSEC_NUM_PRIOS 1
-#define RDMA_RX_IPSEC_NUM_LEVELS 2
+#define RDMA_RX_IPSEC_NUM_LEVELS 4
 #define RDMA_RX_IPSEC_MIN_LEVEL  (RDMA_RX_IPSEC_NUM_LEVELS)
 
 #define RDMA_RX_BYPASS_MIN_LEVEL MLX5_BY_PASS_NUM_REGULAR_PRIOS
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/ipsec_fs_roce.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/ipsec_fs_roce.c
index a82ccae7b614..cce2193608cd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/ipsec_fs_roce.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/ipsec_fs_roce.c
@@ -18,6 +18,11 @@ struct mlx5_ipsec_rx_roce {
 	struct mlx5_flow_table *ft;
 	struct mlx5_flow_handle *rule;
 	struct mlx5_ipsec_miss roce_miss;
+	struct mlx5_flow_table *nic_master_ft;
+	struct mlx5_flow_group *nic_master_group;
+	struct mlx5_flow_handle *nic_master_rule;
+	struct mlx5_flow_table *goto_alias_ft;
+	u32 alias_id;
 
 	struct mlx5_flow_table *ft_rdma;
 	struct mlx5_flow_namespace *ns_rdma;
@@ -119,6 +124,7 @@ ipsec_fs_roce_rx_rule_setup(struct mlx5_core_dev *mdev,
 			    struct mlx5_flow_destination *default_dst,
 			    struct mlx5_ipsec_rx_roce *roce)
 {
+	bool is_mpv_slave = mlx5_core_is_mp_slave(mdev);
 	struct mlx5_flow_destination dst = {};
 	MLX5_DECLARE_FLOW_ACT(flow_act);
 	struct mlx5_flow_handle *rule;
@@ -132,14 +138,19 @@ ipsec_fs_roce_rx_rule_setup(struct mlx5_core_dev *mdev,
 	ipsec_fs_roce_setup_udp_dport(spec, ROCE_V2_UDP_DPORT);
 
 	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_FWD_DEST;
-	dst.type = MLX5_FLOW_DESTINATION_TYPE_TABLE_TYPE;
-	dst.ft = roce->ft_rdma;
+	if (is_mpv_slave) {
+		dst.type = MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE;
+		dst.ft = roce->goto_alias_ft;
+	} else {
+		dst.type = MLX5_FLOW_DESTINATION_TYPE_TABLE_TYPE;
+		dst.ft = roce->ft_rdma;
+	}
 	rule = mlx5_add_flow_rules(roce->ft, spec, &flow_act, &dst, 1);
 	if (IS_ERR(rule)) {
 		err = PTR_ERR(rule);
 		mlx5_core_err(mdev, "Fail to add RX RoCE IPsec rule err=%d\n",
 			      err);
-		goto fail_add_rule;
+		goto out;
 	}
 
 	roce->rule = rule;
@@ -155,12 +166,30 @@ ipsec_fs_roce_rx_rule_setup(struct mlx5_core_dev *mdev,
 
 	roce->roce_miss.rule = rule;
 
+	if (!is_mpv_slave)
+		goto out;
+
+	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_FWD_DEST;
+	dst.type = MLX5_FLOW_DESTINATION_TYPE_TABLE_TYPE;
+	dst.ft = roce->ft_rdma;
+	rule = mlx5_add_flow_rules(roce->nic_master_ft, NULL, &flow_act, &dst,
+				   1);
+	if (IS_ERR(rule)) {
+		err = PTR_ERR(rule);
+		mlx5_core_err(mdev, "Fail to add RX RoCE IPsec rule for alias err=%d\n",
+			      err);
+		goto fail_add_nic_master_rule;
+	}
+	roce->nic_master_rule = rule;
+
 	kvfree(spec);
 	return 0;
 
+fail_add_nic_master_rule:
+	mlx5_del_flow_rules(roce->roce_miss.rule);
 fail_add_default_rule:
 	mlx5_del_flow_rules(roce->rule);
-fail_add_rule:
+out:
 	kvfree(spec);
 	return err;
 }
@@ -379,6 +408,141 @@ static int ipsec_fs_roce_tx_mpv_create(struct mlx5_core_dev *mdev,
 	return err;
 }
 
+static void roce_rx_mpv_destroy_tables(struct mlx5_core_dev *mdev, struct mlx5_ipsec_rx_roce *roce)
+{
+	mlx5_destroy_flow_table(roce->goto_alias_ft);
+	mlx5_cmd_alias_obj_destroy(mdev, roce->alias_id,
+				   MLX5_GENERAL_OBJECT_TYPES_FLOW_TABLE_ALIAS);
+	mlx5_destroy_flow_group(roce->nic_master_group);
+	mlx5_destroy_flow_table(roce->nic_master_ft);
+}
+
+#define MLX5_RX_ROCE_GROUP_SIZE BIT(0)
+#define MLX5_IPSEC_RX_IPV4_FT_LEVEL 3
+#define MLX5_IPSEC_RX_IPV6_FT_LEVEL 2
+
+static int ipsec_fs_roce_rx_mpv_create(struct mlx5_core_dev *mdev,
+				       struct mlx5_ipsec_fs *ipsec_roce,
+				       struct mlx5_flow_namespace *ns,
+				       u32 family, u32 level, u32 prio)
+{
+	struct mlx5_flow_namespace *roce_ns, *nic_ns;
+	struct mlx5_flow_table_attr ft_attr = {};
+	struct mlx5_devcom_comp_dev *tmp = NULL;
+	struct mlx5_ipsec_rx_roce *roce;
+	struct mlx5_flow_table next_ft;
+	struct mlx5_flow_table *ft;
+	struct mlx5_flow_group *g;
+	struct mlx5e_priv *peer_priv;
+	int ix = 0;
+	u32 *in;
+	int err;
+
+	roce = (family == AF_INET) ? &ipsec_roce->ipv4_rx :
+				     &ipsec_roce->ipv6_rx;
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
+	roce_ns = mlx5_get_flow_namespace(peer_priv->mdev, MLX5_FLOW_NAMESPACE_RDMA_RX_IPSEC);
+	if (!roce_ns) {
+		err = -EOPNOTSUPP;
+		goto release_peer;
+	}
+
+	nic_ns = mlx5_get_flow_namespace(peer_priv->mdev, MLX5_FLOW_NAMESPACE_KERNEL);
+	if (!nic_ns) {
+		err = -EOPNOTSUPP;
+		goto release_peer;
+	}
+
+	in = kvzalloc(MLX5_ST_SZ_BYTES(create_flow_group_in), GFP_KERNEL);
+	if (!in) {
+		err = -ENOMEM;
+		goto release_peer;
+	}
+
+	ft_attr.level = (family == AF_INET) ? MLX5_IPSEC_RX_IPV4_FT_LEVEL :
+					      MLX5_IPSEC_RX_IPV6_FT_LEVEL;
+	ft_attr.max_fte = 1;
+	ft = mlx5_create_flow_table(roce_ns, &ft_attr);
+	if (IS_ERR(ft)) {
+		err = PTR_ERR(ft);
+		mlx5_core_err(mdev, "Fail to create RoCE IPsec rx ft at rdma master err=%d\n", err);
+		goto free_in;
+	}
+
+	roce->ft_rdma = ft;
+
+	ft_attr.max_fte = 1;
+	ft_attr.prio = prio;
+	ft_attr.level = level + 2;
+	ft = mlx5_create_flow_table(nic_ns, &ft_attr);
+	if (IS_ERR(ft)) {
+		err = PTR_ERR(ft);
+		mlx5_core_err(mdev, "Fail to create RoCE IPsec rx ft at NIC master err=%d\n", err);
+		goto destroy_ft_rdma;
+	}
+	roce->nic_master_ft = ft;
+
+	MLX5_SET_CFG(in, start_flow_index, ix);
+	ix += 1;
+	MLX5_SET_CFG(in, end_flow_index, ix - 1);
+	g = mlx5_create_flow_group(roce->nic_master_ft, in);
+	if (IS_ERR(g)) {
+		err = PTR_ERR(g);
+		mlx5_core_err(mdev, "Fail to create RoCE IPsec rx group aliased err=%d\n", err);
+		goto destroy_nic_master_ft;
+	}
+	roce->nic_master_group = g;
+
+	err = ipsec_fs_create_aliased_ft(peer_priv->mdev, mdev, roce->nic_master_ft,
+					 &roce->alias_id);
+	if (err) {
+		mlx5_core_err(mdev, "Fail to create RoCE IPsec rx alias FT err=%d\n", err);
+		goto destroy_group;
+	}
+
+	next_ft.id = roce->alias_id;
+	ft_attr.max_fte = 1;
+	ft_attr.prio = prio;
+	ft_attr.level = roce->ft->level + 1;
+	ft_attr.flags = MLX5_FLOW_TABLE_UNMANAGED;
+	ft_attr.next_ft = &next_ft;
+	ft = mlx5_create_flow_table(ns, &ft_attr);
+	if (IS_ERR(ft)) {
+		err = PTR_ERR(ft);
+		mlx5_core_err(mdev, "Fail to create RoCE IPsec rx ft at NIC slave err=%d\n", err);
+		goto destroy_alias;
+	}
+	roce->goto_alias_ft = ft;
+
+	kvfree(in);
+	mlx5_devcom_for_each_peer_end(*ipsec_roce->devcom);
+	return 0;
+
+destroy_alias:
+	mlx5_cmd_alias_obj_destroy(mdev, roce->alias_id,
+				   MLX5_GENERAL_OBJECT_TYPES_FLOW_TABLE_ALIAS);
+destroy_group:
+	mlx5_destroy_flow_group(roce->nic_master_group);
+destroy_nic_master_ft:
+	mlx5_destroy_flow_table(roce->nic_master_ft);
+destroy_ft_rdma:
+	mlx5_destroy_flow_table(roce->ft_rdma);
+free_in:
+	kvfree(in);
+release_peer:
+	mlx5_devcom_for_each_peer_end(*ipsec_roce->devcom);
+	return err;
+}
+
 void mlx5_ipsec_fs_roce_tx_destroy(struct mlx5_ipsec_fs *ipsec_roce,
 				   struct mlx5_core_dev *mdev)
 {
@@ -493,8 +657,10 @@ struct mlx5_flow_table *mlx5_ipsec_fs_roce_ft_get(struct mlx5_ipsec_fs *ipsec_ro
 	return rx_roce->ft;
 }
 
-void mlx5_ipsec_fs_roce_rx_destroy(struct mlx5_ipsec_fs *ipsec_roce, u32 family)
+void mlx5_ipsec_fs_roce_rx_destroy(struct mlx5_ipsec_fs *ipsec_roce, u32 family,
+				   struct mlx5_core_dev *mdev)
 {
+	bool is_mpv_slave = mlx5_core_is_mp_slave(mdev);
 	struct mlx5_ipsec_rx_roce *rx_roce;
 
 	if (!ipsec_roce)
@@ -503,22 +669,25 @@ void mlx5_ipsec_fs_roce_rx_destroy(struct mlx5_ipsec_fs *ipsec_roce, u32 family)
 	rx_roce = (family == AF_INET) ? &ipsec_roce->ipv4_rx :
 					&ipsec_roce->ipv6_rx;
 
+	if (is_mpv_slave)
+		mlx5_del_flow_rules(rx_roce->nic_master_rule);
 	mlx5_del_flow_rules(rx_roce->roce_miss.rule);
 	mlx5_del_flow_rules(rx_roce->rule);
+	if (is_mpv_slave)
+		roce_rx_mpv_destroy_tables(mdev, rx_roce);
 	mlx5_destroy_flow_table(rx_roce->ft_rdma);
 	mlx5_destroy_flow_group(rx_roce->roce_miss.group);
 	mlx5_destroy_flow_group(rx_roce->g);
 	mlx5_destroy_flow_table(rx_roce->ft);
 }
 
-#define MLX5_RX_ROCE_GROUP_SIZE BIT(0)
-
 int mlx5_ipsec_fs_roce_rx_create(struct mlx5_core_dev *mdev,
 				 struct mlx5_ipsec_fs *ipsec_roce,
 				 struct mlx5_flow_namespace *ns,
 				 struct mlx5_flow_destination *default_dst,
 				 u32 family, u32 level, u32 prio)
 {
+	bool is_mpv_slave = mlx5_core_is_mp_slave(mdev);
 	struct mlx5_flow_table_attr ft_attr = {};
 	struct mlx5_ipsec_rx_roce *roce;
 	struct mlx5_flow_table *ft;
@@ -582,18 +751,28 @@ int mlx5_ipsec_fs_roce_rx_create(struct mlx5_core_dev *mdev,
 	}
 	roce->roce_miss.group = g;
 
-	memset(&ft_attr, 0, sizeof(ft_attr));
-	if (family == AF_INET)
-		ft_attr.level = 1;
-	ft = mlx5_create_flow_table(roce->ns_rdma, &ft_attr);
-	if (IS_ERR(ft)) {
-		err = PTR_ERR(ft);
-		mlx5_core_err(mdev, "Fail to create RoCE IPsec rx ft at rdma err=%d\n", err);
-		goto fail_rdma_table;
+	if (is_mpv_slave) {
+		err = ipsec_fs_roce_rx_mpv_create(mdev, ipsec_roce, ns, family, level, prio);
+		if (err) {
+			mlx5_core_err(mdev, "Fail to create RoCE IPsec rx alias err=%d\n", err);
+			goto fail_mpv_create;
+		}
+	} else {
+		memset(&ft_attr, 0, sizeof(ft_attr));
+		if (family == AF_INET)
+			ft_attr.level = 1;
+		ft_attr.max_fte = 1;
+		ft = mlx5_create_flow_table(roce->ns_rdma, &ft_attr);
+		if (IS_ERR(ft)) {
+			err = PTR_ERR(ft);
+			mlx5_core_err(mdev,
+				      "Fail to create RoCE IPsec rx ft at rdma err=%d\n", err);
+			goto fail_rdma_table;
+		}
+
+		roce->ft_rdma = ft;
 	}
 
-	roce->ft_rdma = ft;
-
 	err = ipsec_fs_roce_rx_rule_setup(mdev, default_dst, roce);
 	if (err) {
 		mlx5_core_err(mdev, "Fail to create RoCE IPsec rx rules err=%d\n", err);
@@ -604,7 +783,10 @@ int mlx5_ipsec_fs_roce_rx_create(struct mlx5_core_dev *mdev,
 	return 0;
 
 fail_setup_rule:
+	if (is_mpv_slave)
+		roce_rx_mpv_destroy_tables(mdev, roce);
 	mlx5_destroy_flow_table(roce->ft_rdma);
+fail_mpv_create:
 fail_rdma_table:
 	mlx5_destroy_flow_group(roce->roce_miss.group);
 fail_mgroup:
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/ipsec_fs_roce.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/ipsec_fs_roce.h
index ad120caf269e..435a480400e5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/ipsec_fs_roce.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/ipsec_fs_roce.h
@@ -11,7 +11,7 @@ struct mlx5_ipsec_fs;
 struct mlx5_flow_table *
 mlx5_ipsec_fs_roce_ft_get(struct mlx5_ipsec_fs *ipsec_roce, u32 family);
 void mlx5_ipsec_fs_roce_rx_destroy(struct mlx5_ipsec_fs *ipsec_roce,
-				   u32 family);
+				   u32 family, struct mlx5_core_dev *mdev);
 int mlx5_ipsec_fs_roce_rx_create(struct mlx5_core_dev *mdev,
 				 struct mlx5_ipsec_fs *ipsec_roce,
 				 struct mlx5_flow_namespace *ns,
-- 
2.41.0

