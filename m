Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A59771E8D
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Aug 2023 12:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjHGKpc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Aug 2023 06:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbjHGKp1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Aug 2023 06:45:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFB819AB
        for <linux-rdma@vger.kernel.org>; Mon,  7 Aug 2023 03:45:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A37D9617BB
        for <linux-rdma@vger.kernel.org>; Mon,  7 Aug 2023 10:45:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96A84C4339A;
        Mon,  7 Aug 2023 10:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691405101;
        bh=UWpOZWor1Z26sBVc3qVvsN0nYxh2LhsFkiQpN6eTQn8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ggiq0yW0CVC2wQfTVVsp021H69/hMqFFVV0LYvpLj8M9RcKlLLttjXe+btXNCZbe8
         BDfKVxbk6/oTXGLnftx+3SbW/1w/EhxGs5WO6Y1Ngy5OW8Efgy2Ey2hS0Bl2G0B4ag
         cv8moFkUMC6utVwItvEF7BX2LOQkc7pAydDnIFWZUylSLbcE48EU7gRmN1dTv6Rjkr
         xRXy2WGm+ZyKWQGe40wBysz0tyjGkDQqDseZP42KZ0YX2bg2BHFzg73IlacMy3Vvhl
         6SETibCqfN5uMcyaRwlMOsXqBqjMrFr3l6DRPXS4NHBex2OCeoFbXzVSRFp9sYw786
         4sx+W4fYbKENw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>, Jakub Kicinski <kuba@kernel.org>
Cc:     Patrisious Haddad <phaddad@nvidia.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>,
        Mark Zhang <markzhang@nvidia.com>, netdev@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>, Raed Salem <raeds@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH mlx5-next 06/14] net/mlx5: Remove netdevice from MACsec steering
Date:   Mon,  7 Aug 2023 13:44:15 +0300
Message-ID: <6ab3a26a163906492d346dd4b1f914ed2cabe7e4.1691403485.git.leon@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1691403485.git.leon@kernel.org>
References: <cover.1691403485.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Patrisious Haddad <phaddad@nvidia.com>

Since MACsec steering was moved from ethernet private code to core,
remove the netdevice from the MACsec steering, and use core device
methods for error reporting instead.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 .../mellanox/mlx5/core/en_accel/macsec.c      |   2 +-
 .../mellanox/mlx5/core/lib/macsec_fs.c        | 144 +++++++++---------
 .../mellanox/mlx5/core/lib/macsec_fs.h        |   2 +-
 3 files changed, 71 insertions(+), 77 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
index 5e8ad355c67f..fb599bacbe30 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
@@ -1804,7 +1804,7 @@ int mlx5e_macsec_init(struct mlx5e_priv *priv)
 
 	macsec->mdev = mdev;
 
-	macsec_fs = mlx5_macsec_fs_init(mdev, priv->netdev);
+	macsec_fs = mlx5_macsec_fs_init(mdev);
 	if (!macsec_fs) {
 		err = -ENOMEM;
 		goto err_out;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c
index 8c19c6e16ecf..afa48b339e4a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c
@@ -2,7 +2,6 @@
 /* Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
 
 #include <net/macsec.h>
-#include <linux/netdevice.h>
 #include <linux/mlx5/qp.h>
 #include <linux/if_vlan.h>
 #include "fs_core.h"
@@ -103,7 +102,6 @@ union mlx5_macsec_rule {
 
 struct mlx5_macsec_fs {
 	struct mlx5_core_dev *mdev;
-	struct net_device *netdev;
 	struct mlx5_macsec_tx *tx_fs;
 	struct mlx5_macsec_rx *rx_fs;
 
@@ -268,7 +266,7 @@ static int macsec_fs_tx_create(struct mlx5_macsec_fs *macsec_fs)
 {
 	int inlen = MLX5_ST_SZ_BYTES(create_flow_group_in);
 	struct mlx5_macsec_tx *tx_fs = macsec_fs->tx_fs;
-	struct net_device *netdev = macsec_fs->netdev;
+	struct mlx5_core_dev *mdev = macsec_fs->mdev;
 	struct mlx5_flow_table_attr ft_attr = {};
 	struct mlx5_flow_destination dest = {};
 	struct mlx5_macsec_tables *tx_tables;
@@ -282,7 +280,7 @@ static int macsec_fs_tx_create(struct mlx5_macsec_fs *macsec_fs)
 	u32 *flow_group_in;
 	int err;
 
-	ns = mlx5_get_flow_namespace(macsec_fs->mdev, MLX5_FLOW_NAMESPACE_EGRESS_MACSEC);
+	ns = mlx5_get_flow_namespace(mdev, MLX5_FLOW_NAMESPACE_EGRESS_MACSEC);
 	if (!ns)
 		return -ENOMEM;
 
@@ -307,7 +305,7 @@ static int macsec_fs_tx_create(struct mlx5_macsec_fs *macsec_fs)
 	flow_table = mlx5_create_flow_table(ns, &ft_attr);
 	if (IS_ERR(flow_table)) {
 		err = PTR_ERR(flow_table);
-		netdev_err(netdev, "Failed to create MACsec Tx crypto table err(%d)\n", err);
+		mlx5_core_err(mdev, "Failed to create MACsec Tx crypto table err(%d)\n", err);
 		goto out_flow_group;
 	}
 	ft_crypto->t = flow_table;
@@ -315,9 +313,9 @@ static int macsec_fs_tx_create(struct mlx5_macsec_fs *macsec_fs)
 	/* Tx crypto table groups */
 	err = macsec_fs_tx_create_crypto_table_groups(ft_crypto);
 	if (err) {
-		netdev_err(netdev,
-			   "Failed to create default flow group for MACsec Tx crypto table err(%d)\n",
-			   err);
+		mlx5_core_err(mdev,
+			      "Failed to create default flow group for MACsec Tx crypto table err(%d)\n",
+			      err);
 		goto err;
 	}
 
@@ -331,7 +329,7 @@ static int macsec_fs_tx_create(struct mlx5_macsec_fs *macsec_fs)
 	rule = mlx5_add_flow_rules(ft_crypto->t, spec, &flow_act, NULL, 0);
 	if (IS_ERR(rule)) {
 		err = PTR_ERR(rule);
-		netdev_err(netdev, "Failed to add MACsec TX MKE rule, err=%d\n", err);
+		mlx5_core_err(mdev, "Failed to add MACsec TX MKE rule, err=%d\n", err);
 		goto err;
 	}
 	tx_fs->crypto_mke_rule = rule;
@@ -342,7 +340,7 @@ static int macsec_fs_tx_create(struct mlx5_macsec_fs *macsec_fs)
 	rule = mlx5_add_flow_rules(ft_crypto->t, NULL, &flow_act, NULL, 0);
 	if (IS_ERR(rule)) {
 		err = PTR_ERR(rule);
-		netdev_err(netdev, "Failed to add MACsec Tx table default miss rule %d\n", err);
+		mlx5_core_err(mdev, "Failed to add MACsec Tx table default miss rule %d\n", err);
 		goto err;
 	}
 	tx_tables->crypto_miss_rule = rule;
@@ -352,7 +350,7 @@ static int macsec_fs_tx_create(struct mlx5_macsec_fs *macsec_fs)
 						       TX_CHECK_TABLE_NUM_FTE);
 	if (IS_ERR(flow_table)) {
 		err = PTR_ERR(flow_table);
-		netdev_err(netdev, "fail to create MACsec TX check table, err(%d)\n", err);
+		mlx5_core_err(mdev, "Fail to create MACsec TX check table, err(%d)\n", err);
 		goto err;
 	}
 	tx_tables->ft_check = flow_table;
@@ -364,9 +362,9 @@ static int macsec_fs_tx_create(struct mlx5_macsec_fs *macsec_fs)
 	flow_group = mlx5_create_flow_group(tx_tables->ft_check, flow_group_in);
 	if (IS_ERR(flow_group)) {
 		err = PTR_ERR(flow_group);
-		netdev_err(netdev,
-			   "Failed to create default flow group for MACsec Tx crypto table err(%d)\n",
-			   err);
+		mlx5_core_err(mdev,
+			      "Failed to create default flow group for MACsec Tx crypto table err(%d)\n",
+			      err);
 		goto err;
 	}
 	tx_tables->ft_check_group = flow_group;
@@ -380,7 +378,7 @@ static int macsec_fs_tx_create(struct mlx5_macsec_fs *macsec_fs)
 	rule = mlx5_add_flow_rules(tx_tables->ft_check,  NULL, &flow_act, &dest, 1);
 	if (IS_ERR(rule)) {
 		err = PTR_ERR(rule);
-		netdev_err(netdev, "Failed to added MACsec tx check drop rule, err(%d)\n", err);
+		mlx5_core_err(mdev, "Failed to added MACsec tx check drop rule, err(%d)\n", err);
 		goto err;
 	}
 	tx_tables->check_miss_rule = rule;
@@ -401,7 +399,7 @@ static int macsec_fs_tx_create(struct mlx5_macsec_fs *macsec_fs)
 	rule = mlx5_add_flow_rules(tx_tables->ft_check, spec, &flow_act, &dest, 1);
 	if (IS_ERR(rule)) {
 		err = PTR_ERR(rule);
-		netdev_err(netdev, "Failed to add MACsec check rule, err=%d\n", err);
+		mlx5_core_err(mdev, "Failed to add MACsec check rule, err=%d\n", err);
 		goto err;
 	}
 	tx_fs->check_rule = rule;
@@ -549,7 +547,7 @@ macsec_fs_tx_add_rule(struct mlx5_macsec_fs *macsec_fs,
 	char reformatbf[MLX5_MACSEC_TAG_LEN + MACSEC_SCI_LEN];
 	struct mlx5_pkt_reformat_params reformat_params = {};
 	struct mlx5_macsec_tx *tx_fs = macsec_fs->tx_fs;
-	struct net_device *netdev = macsec_fs->netdev;
+	struct mlx5_core_dev *mdev = macsec_fs->mdev;
 	union mlx5_macsec_rule *macsec_rule = NULL;
 	struct mlx5_flow_destination dest = {};
 	struct mlx5_macsec_tables *tx_tables;
@@ -589,21 +587,21 @@ macsec_fs_tx_add_rule(struct mlx5_macsec_fs *macsec_fs,
 	if (is_vlan_dev(macsec_ctx->netdev))
 		reformat_params.param_0 = MLX5_REFORMAT_PARAM_ADD_MACSEC_OFFSET_4_BYTES;
 
-	flow_act.pkt_reformat = mlx5_packet_reformat_alloc(macsec_fs->mdev,
+	flow_act.pkt_reformat = mlx5_packet_reformat_alloc(mdev,
 							   &reformat_params,
 							   MLX5_FLOW_NAMESPACE_EGRESS_MACSEC);
 	if (IS_ERR(flow_act.pkt_reformat)) {
 		err = PTR_ERR(flow_act.pkt_reformat);
-		netdev_err(netdev, "Failed to allocate MACsec Tx reformat context err=%d\n",  err);
+		mlx5_core_err(mdev, "Failed to allocate MACsec Tx reformat context err=%d\n",  err);
 		goto err;
 	}
 	tx_rule->pkt_reformat = flow_act.pkt_reformat;
 
 	err = macsec_fs_tx_setup_fte(macsec_fs, spec, &flow_act, attrs->macsec_obj_id, &fs_id);
 	if (err) {
-		netdev_err(netdev,
-			   "Failed to add packet reformat for MACsec TX crypto rule, err=%d\n",
-			   err);
+		mlx5_core_err(mdev,
+			      "Failed to add packet reformat for MACsec TX crypto rule, err=%d\n",
+			      err);
 		goto err;
 	}
 
@@ -618,7 +616,7 @@ macsec_fs_tx_add_rule(struct mlx5_macsec_fs *macsec_fs,
 	rule = mlx5_add_flow_rules(tx_tables->ft_crypto.t, spec, &flow_act, &dest, 1);
 	if (IS_ERR(rule)) {
 		err = PTR_ERR(rule);
-		netdev_err(netdev, "Failed to add MACsec TX crypto rule, err=%d\n", err);
+		mlx5_core_err(mdev, "Failed to add MACsec TX crypto rule, err=%d\n", err);
 		goto err;
 	}
 	tx_rule->rule = rule;
@@ -645,9 +643,9 @@ static void macsec_fs_tx_cleanup(struct mlx5_macsec_fs *macsec_fs)
 
 	tx_tables = &tx_fs->tables;
 	if (tx_tables->refcnt) {
-		netdev_err(macsec_fs->netdev,
-			   "Can't destroy MACsec offload tx_fs, refcnt(%u) isn't 0\n",
-			   tx_tables->refcnt);
+		mlx5_core_err(mdev,
+			      "Can't destroy MACsec offload tx_fs, refcnt(%u) isn't 0\n",
+			      tx_tables->refcnt);
 		return;
 	}
 
@@ -669,7 +667,6 @@ static void macsec_fs_tx_cleanup(struct mlx5_macsec_fs *macsec_fs)
 
 static int macsec_fs_tx_init(struct mlx5_macsec_fs *macsec_fs)
 {
-	struct net_device *netdev = macsec_fs->netdev;
 	struct mlx5_core_dev *mdev = macsec_fs->mdev;
 	struct mlx5_macsec_tables *tx_tables;
 	struct mlx5_macsec_tx *tx_fs;
@@ -685,9 +682,9 @@ static int macsec_fs_tx_init(struct mlx5_macsec_fs *macsec_fs)
 	flow_counter = mlx5_fc_create(mdev, false);
 	if (IS_ERR(flow_counter)) {
 		err = PTR_ERR(flow_counter);
-		netdev_err(netdev,
-			   "Failed to create MACsec Tx encrypt flow counter, err(%d)\n",
-			   err);
+		mlx5_core_err(mdev,
+			      "Failed to create MACsec Tx encrypt flow counter, err(%d)\n",
+			      err);
 		goto err_encrypt_counter;
 	}
 	tx_tables->check_rule_counter = flow_counter;
@@ -695,9 +692,9 @@ static int macsec_fs_tx_init(struct mlx5_macsec_fs *macsec_fs)
 	flow_counter = mlx5_fc_create(mdev, false);
 	if (IS_ERR(flow_counter)) {
 		err = PTR_ERR(flow_counter);
-		netdev_err(netdev,
-			   "Failed to create MACsec Tx drop flow counter, err(%d)\n",
-			   err);
+		mlx5_core_err(mdev,
+			      "Failed to create MACsec Tx drop flow counter, err(%d)\n",
+			      err);
 		goto err_drop_counter;
 	}
 	tx_tables->check_miss_rule_counter = flow_counter;
@@ -857,7 +854,7 @@ static int macsec_fs_rx_create_check_decap_rule(struct mlx5_macsec_fs *macsec_fs
 	u8 mlx5_reformat_buf[MLX5_SECTAG_HEADER_SIZE_WITH_SCI];
 	struct mlx5_pkt_reformat_params reformat_params = {};
 	struct mlx5_macsec_rx *rx_fs = macsec_fs->rx_fs;
-	struct net_device *netdev = macsec_fs->netdev;
+	struct mlx5_core_dev *mdev = macsec_fs->mdev;
 	struct mlx5_macsec_tables *rx_tables;
 	struct mlx5_flow_handle *rule;
 	int err = 0;
@@ -872,12 +869,12 @@ static int macsec_fs_rx_create_check_decap_rule(struct mlx5_macsec_fs *macsec_fs
 	reformat_params.type = MLX5_REFORMAT_TYPE_DEL_MACSEC;
 	reformat_params.size = reformat_param_size;
 	reformat_params.data = mlx5_reformat_buf;
-	flow_act->pkt_reformat = mlx5_packet_reformat_alloc(macsec_fs->mdev,
+	flow_act->pkt_reformat = mlx5_packet_reformat_alloc(mdev,
 							    &reformat_params,
 							    MLX5_FLOW_NAMESPACE_KERNEL_RX_MACSEC);
 	if (IS_ERR(flow_act->pkt_reformat)) {
 		err = PTR_ERR(flow_act->pkt_reformat);
-		netdev_err(netdev, "Failed to allocate MACsec Rx reformat context err=%d\n", err);
+		mlx5_core_err(mdev, "Failed to allocate MACsec Rx reformat context err=%d\n", err);
 		return err;
 	}
 	rx_fs->check_rule_pkt_reformat[rule_index] = flow_act->pkt_reformat;
@@ -909,7 +906,7 @@ static int macsec_fs_rx_create_check_decap_rule(struct mlx5_macsec_fs *macsec_fs
 	rule = mlx5_add_flow_rules(rx_tables->ft_check, spec, flow_act, dest, 1);
 	if (IS_ERR(rule)) {
 		err = PTR_ERR(rule);
-		netdev_err(netdev, "Failed to add MACsec Rx check rule, err=%d\n", err);
+		mlx5_core_err(mdev, "Failed to add MACsec Rx check rule, err=%d\n", err);
 		return err;
 	}
 
@@ -922,7 +919,7 @@ static int macsec_fs_rx_create(struct mlx5_macsec_fs *macsec_fs)
 {
 	int inlen = MLX5_ST_SZ_BYTES(create_flow_group_in);
 	struct mlx5_macsec_rx *rx_fs = macsec_fs->rx_fs;
-	struct net_device *netdev = macsec_fs->netdev;
+	struct mlx5_core_dev *mdev = macsec_fs->mdev;
 	struct mlx5_macsec_flow_table *ft_crypto;
 	struct mlx5_flow_table_attr ft_attr = {};
 	struct mlx5_flow_destination dest = {};
@@ -936,7 +933,7 @@ static int macsec_fs_rx_create(struct mlx5_macsec_fs *macsec_fs)
 	u32 *flow_group_in;
 	int err;
 
-	ns = mlx5_get_flow_namespace(macsec_fs->mdev, MLX5_FLOW_NAMESPACE_KERNEL_RX_MACSEC);
+	ns = mlx5_get_flow_namespace(mdev, MLX5_FLOW_NAMESPACE_KERNEL_RX_MACSEC);
 	if (!ns)
 		return -ENOMEM;
 
@@ -960,7 +957,7 @@ static int macsec_fs_rx_create(struct mlx5_macsec_fs *macsec_fs)
 	flow_table = mlx5_create_flow_table(ns, &ft_attr);
 	if (IS_ERR(flow_table)) {
 		err = PTR_ERR(flow_table);
-		netdev_err(netdev, "Failed to create MACsec Rx crypto table err(%d)\n", err);
+		mlx5_core_err(mdev, "Failed to create MACsec Rx crypto table err(%d)\n", err);
 		goto out_flow_group;
 	}
 	ft_crypto->t = flow_table;
@@ -968,9 +965,9 @@ static int macsec_fs_rx_create(struct mlx5_macsec_fs *macsec_fs)
 	/* Rx crypto table groups */
 	err = macsec_fs_rx_create_crypto_table_groups(ft_crypto);
 	if (err) {
-		netdev_err(netdev,
-			   "Failed to create default flow group for MACsec Tx crypto table err(%d)\n",
-			   err);
+		mlx5_core_err(mdev,
+			      "Failed to create default flow group for MACsec Tx crypto table err(%d)\n",
+			      err);
 		goto err;
 	}
 
@@ -978,9 +975,9 @@ static int macsec_fs_rx_create(struct mlx5_macsec_fs *macsec_fs)
 	rule = mlx5_add_flow_rules(ft_crypto->t, NULL, &flow_act, NULL, 0);
 	if (IS_ERR(rule)) {
 		err = PTR_ERR(rule);
-		netdev_err(netdev,
-			   "Failed to add MACsec Rx crypto table default miss rule %d\n",
-			   err);
+		mlx5_core_err(mdev,
+			      "Failed to add MACsec Rx crypto table default miss rule %d\n",
+			      err);
 		goto err;
 	}
 	rx_tables->crypto_miss_rule = rule;
@@ -992,7 +989,7 @@ static int macsec_fs_rx_create(struct mlx5_macsec_fs *macsec_fs)
 						       RX_CHECK_TABLE_NUM_FTE);
 	if (IS_ERR(flow_table)) {
 		err = PTR_ERR(flow_table);
-		netdev_err(netdev, "fail to create MACsec RX check table, err(%d)\n", err);
+		mlx5_core_err(mdev, "Fail to create MACsec RX check table, err(%d)\n", err);
 		goto err;
 	}
 	rx_tables->ft_check = flow_table;
@@ -1003,9 +1000,9 @@ static int macsec_fs_rx_create(struct mlx5_macsec_fs *macsec_fs)
 	flow_group = mlx5_create_flow_group(rx_tables->ft_check, flow_group_in);
 	if (IS_ERR(flow_group)) {
 		err = PTR_ERR(flow_group);
-		netdev_err(netdev,
-			   "Failed to create default flow group for MACsec Rx check table err(%d)\n",
-			   err);
+		mlx5_core_err(mdev,
+			      "Failed to create default flow group for MACsec Rx check table err(%d)\n",
+			      err);
 		goto err;
 	}
 	rx_tables->ft_check_group = flow_group;
@@ -1019,7 +1016,7 @@ static int macsec_fs_rx_create(struct mlx5_macsec_fs *macsec_fs)
 	rule = mlx5_add_flow_rules(rx_tables->ft_check,  NULL, &flow_act, &dest, 1);
 	if (IS_ERR(rule)) {
 		err = PTR_ERR(rule);
-		netdev_err(netdev, "Failed to added MACsec Rx check drop rule, err(%d)\n", err);
+		mlx5_core_err(mdev, "Failed to added MACsec Rx check drop rule, err(%d)\n", err);
 		goto err;
 	}
 	rx_tables->check_miss_rule = rule;
@@ -1148,7 +1145,7 @@ macsec_fs_rx_add_rule(struct mlx5_macsec_fs *macsec_fs,
 {
 	u8 action[MLX5_UN_SZ_BYTES(set_add_copy_action_in_auto)] = {};
 	struct mlx5_macsec_rx *rx_fs = macsec_fs->rx_fs;
-	struct net_device *netdev = macsec_fs->netdev;
+	struct mlx5_core_dev *mdev = macsec_fs->mdev;
 	union mlx5_macsec_rule *macsec_rule = NULL;
 	struct mlx5_modify_hdr *modify_hdr = NULL;
 	struct mlx5_macsec_flow_table *ft_crypto;
@@ -1186,11 +1183,11 @@ macsec_fs_rx_add_rule(struct mlx5_macsec_fs *macsec_fs,
 	MLX5_SET(set_action_in, action, offset, 0);
 	MLX5_SET(set_action_in, action, length, 32);
 
-	modify_hdr = mlx5_modify_header_alloc(macsec_fs->mdev, MLX5_FLOW_NAMESPACE_KERNEL_RX_MACSEC,
+	modify_hdr = mlx5_modify_header_alloc(mdev, MLX5_FLOW_NAMESPACE_KERNEL_RX_MACSEC,
 					      1, action);
 	if (IS_ERR(modify_hdr)) {
 		err = PTR_ERR(modify_hdr);
-		netdev_err(netdev, "fail to alloc MACsec set modify_header_id err=%d\n", err);
+		mlx5_core_err(mdev, "Fail to alloc MACsec set modify_header_id err=%d\n", err);
 		modify_hdr = NULL;
 		goto err;
 	}
@@ -1209,9 +1206,9 @@ macsec_fs_rx_add_rule(struct mlx5_macsec_fs *macsec_fs,
 	rule = mlx5_add_flow_rules(ft_crypto->t, spec, &flow_act, &dest, 1);
 	if (IS_ERR(rule)) {
 		err = PTR_ERR(rule);
-		netdev_err(netdev,
-			   "Failed to add SA with SCI rule to Rx crypto rule, err=%d\n",
-			   err);
+		mlx5_core_err(mdev,
+			      "Failed to add SA with SCI rule to Rx crypto rule, err=%d\n",
+			      err);
 		goto err;
 	}
 	rx_rule->rule[0] = rule;
@@ -1234,9 +1231,9 @@ macsec_fs_rx_add_rule(struct mlx5_macsec_fs *macsec_fs,
 		rule = mlx5_add_flow_rules(ft_crypto->t, spec, &flow_act, &dest, 1);
 		if (IS_ERR(rule)) {
 			err = PTR_ERR(rule);
-			netdev_err(netdev,
-				   "Failed to add SA without SCI rule to Rx crypto rule, err=%d\n",
-				   err);
+			mlx5_core_err(mdev,
+				      "Failed to add SA without SCI rule to Rx crypto rule, err=%d\n",
+				      err);
 			goto err;
 		}
 		rx_rule->rule[1] = rule;
@@ -1255,7 +1252,6 @@ macsec_fs_rx_add_rule(struct mlx5_macsec_fs *macsec_fs,
 
 static int macsec_fs_rx_init(struct mlx5_macsec_fs *macsec_fs)
 {
-	struct net_device *netdev = macsec_fs->netdev;
 	struct mlx5_core_dev *mdev = macsec_fs->mdev;
 	struct mlx5_macsec_tables *rx_tables;
 	struct mlx5_macsec_rx *rx_fs;
@@ -1269,9 +1265,9 @@ static int macsec_fs_rx_init(struct mlx5_macsec_fs *macsec_fs)
 	flow_counter = mlx5_fc_create(mdev, false);
 	if (IS_ERR(flow_counter)) {
 		err = PTR_ERR(flow_counter);
-		netdev_err(netdev,
-			   "Failed to create MACsec Rx encrypt flow counter, err(%d)\n",
-			   err);
+		mlx5_core_err(mdev,
+			      "Failed to create MACsec Rx encrypt flow counter, err(%d)\n",
+			      err);
 		goto err_encrypt_counter;
 	}
 
@@ -1281,9 +1277,9 @@ static int macsec_fs_rx_init(struct mlx5_macsec_fs *macsec_fs)
 	flow_counter = mlx5_fc_create(mdev, false);
 	if (IS_ERR(flow_counter)) {
 		err = PTR_ERR(flow_counter);
-		netdev_err(netdev,
-			   "Failed to create MACsec Rx drop flow counter, err(%d)\n",
-			   err);
+		mlx5_core_err(mdev,
+			      "Failed to create MACsec Rx drop flow counter, err(%d)\n",
+			      err);
 		goto err_drop_counter;
 	}
 	rx_tables->check_miss_rule_counter = flow_counter;
@@ -1315,9 +1311,9 @@ static void macsec_fs_rx_cleanup(struct mlx5_macsec_fs *macsec_fs)
 	rx_tables = &rx_fs->tables;
 
 	if (rx_tables->refcnt) {
-		netdev_err(macsec_fs->netdev,
-			   "Can't destroy MACsec offload rx_fs, refcnt(%u) isn't 0\n",
-			   rx_tables->refcnt);
+		mlx5_core_err(mdev,
+			      "Can't destroy MACsec offload rx_fs, refcnt(%u) isn't 0\n",
+			      rx_tables->refcnt);
 		return;
 	}
 
@@ -1395,8 +1391,7 @@ void mlx5_macsec_fs_cleanup(struct mlx5_macsec_fs *macsec_fs)
 }
 
 struct mlx5_macsec_fs *
-mlx5_macsec_fs_init(struct mlx5_core_dev *mdev,
-		    struct net_device *netdev)
+mlx5_macsec_fs_init(struct mlx5_core_dev *mdev)
 {
 	struct mlx5_macsec_fs *macsec_fs;
 	int err;
@@ -1406,17 +1401,16 @@ mlx5_macsec_fs_init(struct mlx5_core_dev *mdev,
 		return NULL;
 
 	macsec_fs->mdev = mdev;
-	macsec_fs->netdev = netdev;
 
 	err = macsec_fs_tx_init(macsec_fs);
 	if (err) {
-		netdev_err(netdev, "MACsec offload: Failed to init tx_fs, err=%d\n", err);
+		mlx5_core_err(mdev, "MACsec offload: Failed to init tx_fs, err=%d\n", err);
 		goto err;
 	}
 
 	err = macsec_fs_rx_init(macsec_fs);
 	if (err) {
-		netdev_err(netdev, "MACsec offload: Failed to init tx_fs, err=%d\n", err);
+		mlx5_core_err(mdev, "MACsec offload: Failed to init tx_fs, err=%d\n", err);
 		goto tx_cleanup;
 	}
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.h
index c0c28d08eae5..f007c33369c2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.h
@@ -43,7 +43,7 @@ enum mlx5_macsec_action {
 void mlx5_macsec_fs_cleanup(struct mlx5_macsec_fs *macsec_fs);
 
 struct mlx5_macsec_fs *
-mlx5_macsec_fs_init(struct mlx5_core_dev *mdev, struct net_device *netdev);
+mlx5_macsec_fs_init(struct mlx5_core_dev *mdev);
 
 union mlx5_macsec_rule *
 mlx5_macsec_fs_add_rule(struct mlx5_macsec_fs *macsec_fs,
-- 
2.41.0

