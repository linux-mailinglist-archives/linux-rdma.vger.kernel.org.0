Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB54771E78
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Aug 2023 12:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbjHGKot (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Aug 2023 06:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231752AbjHGKos (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Aug 2023 06:44:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3268F1711
        for <linux-rdma@vger.kernel.org>; Mon,  7 Aug 2023 03:44:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B25D617A3
        for <linux-rdma@vger.kernel.org>; Mon,  7 Aug 2023 10:44:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F23C6C433C7;
        Mon,  7 Aug 2023 10:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691405081;
        bh=XN56Ip23zkQS1exzVT/J93ml8tACn7JlD80tF/m1Yhw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P0caJ/ngHKaodBVwWFmvJGnTROOYoY5CcEMcqi0jnziP3Wh7ajZ+yuHWEnrUeQMir
         85bVw0tfMRvwhN9lTeYn5X+p6q1hVNyid11veNhszYEDwT7/F4uGBrqkkIuJdnTtkm
         vwToshCkJTHP2qb7HRH7kF4XDinUiwMIlFI83GZhegarjqJao+ZhTOTO+qYVlsnKea
         WifYp8peQuiko92wbMgR9NyMxw1sEZAGET9h06jceusrcsn4noqO3WzSm7Repyma7G
         9FVL4HmLMtrkiHDbhDqO2BO9d1HgNn4saTDKr+i8N7TQvWQ2Y2oBbuM7inkjqLwN+9
         db1JmosA0p6Ew==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>, Jakub Kicinski <kuba@kernel.org>
Cc:     Patrisious Haddad <phaddad@nvidia.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>,
        Mark Zhang <markzhang@nvidia.com>, netdev@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>, Raed Salem <raeds@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH mlx5-next 04/14] net/mlx5e: Rename MACsec flow steering functions/parameters to suit core naming style
Date:   Mon,  7 Aug 2023 13:44:13 +0300
Message-ID: <d891e893a0df8500df17b5b4a55c306f4027ff3c.1691403485.git.leon@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1691403485.git.leon@kernel.org>
References: <cover.1691403485.git.leon@kernel.org>
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

Rename MACsec flow steering(macsec_fs) functions and parameters from
ethernet(core/en_accel) naming convention to core naming convention.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 .../mellanox/mlx5/core/en_accel/macsec.c      |  22 +--
 .../mellanox/mlx5/core/en_accel/macsec.h      |   2 +-
 .../mlx5/core/en_accel/macsec_stats.c         |  16 +-
 .../mellanox/mlx5/core/lib/macsec_fs.c        | 168 +++++++++---------
 .../mellanox/mlx5/core/lib/macsec_fs.h        |  30 ++--
 5 files changed, 119 insertions(+), 119 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
index b26044efdec6..831d83094abd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
@@ -67,7 +67,7 @@ struct mlx5e_macsec_sa {
 
 	struct rhash_head hash;
 	u32 fs_id;
-	union mlx5e_macsec_rule *macsec_rule;
+	union mlx5_macsec_rule *macsec_rule;
 	struct rcu_head rcu_head;
 	struct mlx5e_macsec_epn_state epn_state;
 };
@@ -124,7 +124,7 @@ struct mlx5e_macsec_device {
 struct mlx5e_macsec {
 	struct list_head macsec_device_list_head;
 	int num_of_devices;
-	struct mlx5e_macsec_fs *macsec_fs;
+	struct mlx5_macsec_fs *macsec_fs;
 	struct mutex lock; /* Protects mlx5e_macsec internal contexts */
 
 	/* Tx sci -> fs id mapping handling */
@@ -136,7 +136,7 @@ struct mlx5e_macsec {
 	struct mlx5_core_dev *mdev;
 
 	/* Stats manage */
-	struct mlx5e_macsec_stats stats;
+	struct mlx5_macsec_stats stats;
 
 	/* ASO */
 	struct mlx5e_macsec_aso aso;
@@ -343,7 +343,7 @@ static void mlx5e_macsec_cleanup_sa(struct mlx5e_macsec *macsec,
 	if (!sa->macsec_rule)
 		return;
 
-	mlx5e_macsec_fs_del_rule(macsec->macsec_fs, sa->macsec_rule, action);
+	mlx5_macsec_fs_del_rule(macsec->macsec_fs, sa->macsec_rule, action);
 	mlx5e_macsec_destroy_object(macsec->mdev, sa->macsec_obj_id);
 	sa->macsec_rule = NULL;
 }
@@ -358,7 +358,7 @@ static int mlx5e_macsec_init_sa(struct macsec_context *ctx,
 	struct mlx5_macsec_rule_attrs rule_attrs;
 	struct mlx5_core_dev *mdev = priv->mdev;
 	struct mlx5_macsec_obj_attrs obj_attrs;
-	union mlx5e_macsec_rule *macsec_rule;
+	union mlx5_macsec_rule *macsec_rule;
 	int err;
 
 	obj_attrs.next_pn = sa->next_pn;
@@ -386,7 +386,7 @@ static int mlx5e_macsec_init_sa(struct macsec_context *ctx,
 	rule_attrs.action = (is_tx) ? MLX5_ACCEL_MACSEC_ACTION_ENCRYPT :
 				      MLX5_ACCEL_MACSEC_ACTION_DECRYPT;
 
-	macsec_rule = mlx5e_macsec_fs_add_rule(macsec->macsec_fs, ctx, &rule_attrs, &sa->fs_id);
+	macsec_rule = mlx5_macsec_fs_add_rule(macsec->macsec_fs, ctx, &rule_attrs, &sa->fs_id);
 	if (!macsec_rule) {
 		err = -ENOMEM;
 		goto destroy_macsec_object;
@@ -1679,10 +1679,10 @@ bool mlx5e_is_macsec_device(const struct mlx5_core_dev *mdev)
 
 void mlx5e_macsec_get_stats_fill(struct mlx5e_macsec *macsec, void *macsec_stats)
 {
-	mlx5e_macsec_fs_get_stats_fill(macsec->macsec_fs, macsec_stats);
+	mlx5_macsec_fs_get_stats_fill(macsec->macsec_fs, macsec_stats);
 }
 
-struct mlx5e_macsec_stats *mlx5e_macsec_get_stats(struct mlx5e_macsec *macsec)
+struct mlx5_macsec_stats *mlx5e_macsec_get_stats(struct mlx5e_macsec *macsec)
 {
 	if (!macsec)
 		return NULL;
@@ -1781,7 +1781,7 @@ int mlx5e_macsec_init(struct mlx5e_priv *priv)
 {
 	struct mlx5_core_dev *mdev = priv->mdev;
 	struct mlx5e_macsec *macsec = NULL;
-	struct mlx5e_macsec_fs *macsec_fs;
+	struct mlx5_macsec_fs *macsec_fs;
 	int err;
 
 	if (!mlx5e_is_macsec_device(priv->mdev)) {
@@ -1821,7 +1821,7 @@ int mlx5e_macsec_init(struct mlx5e_priv *priv)
 
 	macsec->mdev = mdev;
 
-	macsec_fs = mlx5e_macsec_fs_init(mdev, priv->netdev);
+	macsec_fs = mlx5_macsec_fs_init(mdev, priv->netdev);
 	if (!macsec_fs) {
 		err = -ENOMEM;
 		goto err_out;
@@ -1857,7 +1857,7 @@ void mlx5e_macsec_cleanup(struct mlx5e_priv *priv)
 		return;
 
 	mlx5_notifier_unregister(mdev, &macsec->nb);
-	mlx5e_macsec_fs_cleanup(macsec->macsec_fs);
+	mlx5_macsec_fs_cleanup(macsec->macsec_fs);
 	destroy_workqueue(macsec->wq);
 	mlx5e_macsec_aso_cleanup(&macsec->aso, mdev);
 	rhashtable_destroy(&macsec->sci_hash);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.h
index 1f9c4a2723b2..47dc1d4448d9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.h
@@ -38,7 +38,7 @@ void mlx5e_macsec_offload_handle_rx_skb(struct net_device *netdev, struct sk_buf
 					struct mlx5_cqe64 *cqe);
 bool mlx5e_is_macsec_device(const struct mlx5_core_dev *mdev);
 void mlx5e_macsec_get_stats_fill(struct mlx5e_macsec *macsec, void *macsec_stats);
-struct mlx5e_macsec_stats *mlx5e_macsec_get_stats(struct mlx5e_macsec *macsec);
+struct mlx5_macsec_stats *mlx5e_macsec_get_stats(struct mlx5e_macsec *macsec);
 
 #else
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec_stats.c
index e50a2e3f3d18..8326a593b3fb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec_stats.c
@@ -8,14 +8,14 @@
 #include "en_accel/macsec.h"
 
 static const struct counter_desc mlx5e_macsec_hw_stats_desc[] = {
-	{ MLX5E_DECLARE_STAT(struct mlx5e_macsec_stats, macsec_rx_pkts) },
-	{ MLX5E_DECLARE_STAT(struct mlx5e_macsec_stats, macsec_rx_bytes) },
-	{ MLX5E_DECLARE_STAT(struct mlx5e_macsec_stats, macsec_rx_pkts_drop) },
-	{ MLX5E_DECLARE_STAT(struct mlx5e_macsec_stats, macsec_rx_bytes_drop) },
-	{ MLX5E_DECLARE_STAT(struct mlx5e_macsec_stats, macsec_tx_pkts) },
-	{ MLX5E_DECLARE_STAT(struct mlx5e_macsec_stats, macsec_tx_bytes) },
-	{ MLX5E_DECLARE_STAT(struct mlx5e_macsec_stats, macsec_tx_pkts_drop) },
-	{ MLX5E_DECLARE_STAT(struct mlx5e_macsec_stats, macsec_tx_bytes_drop) },
+	{ MLX5E_DECLARE_STAT(struct mlx5_macsec_stats, macsec_rx_pkts) },
+	{ MLX5E_DECLARE_STAT(struct mlx5_macsec_stats, macsec_rx_bytes) },
+	{ MLX5E_DECLARE_STAT(struct mlx5_macsec_stats, macsec_rx_pkts_drop) },
+	{ MLX5E_DECLARE_STAT(struct mlx5_macsec_stats, macsec_rx_bytes_drop) },
+	{ MLX5E_DECLARE_STAT(struct mlx5_macsec_stats, macsec_tx_pkts) },
+	{ MLX5E_DECLARE_STAT(struct mlx5_macsec_stats, macsec_tx_bytes) },
+	{ MLX5E_DECLARE_STAT(struct mlx5_macsec_stats, macsec_tx_pkts_drop) },
+	{ MLX5E_DECLARE_STAT(struct mlx5_macsec_stats, macsec_tx_bytes_drop) },
 };
 
 #define NUM_MACSEC_HW_COUNTERS ARRAY_SIZE(mlx5e_macsec_hw_stats_desc)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c
index ace6b67f1c97..8feb7db6a220 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c
@@ -50,7 +50,7 @@ struct mlx5_sectag_header {
 	u8 sci[MACSEC_SCI_LEN]; /* optional */
 }  __packed;
 
-struct mlx5e_macsec_tx_rule {
+struct mlx5_macsec_tx_rule {
 	struct mlx5_flow_handle *rule;
 	struct mlx5_pkt_reformat *pkt_reformat;
 	u32 fs_id;
@@ -62,7 +62,7 @@ struct mlx5_macsec_flow_table {
 	struct mlx5_flow_group **g;
 };
 
-struct mlx5e_macsec_tables {
+struct mlx5_macsec_tables {
 	struct mlx5_macsec_flow_table ft_crypto;
 	struct mlx5_flow_handle *crypto_miss_rule;
 
@@ -75,37 +75,37 @@ struct mlx5e_macsec_tables {
 	u32 refcnt;
 };
 
-struct mlx5e_macsec_tx {
+struct mlx5_macsec_tx {
 	struct mlx5_flow_handle *crypto_mke_rule;
 	struct mlx5_flow_handle *check_rule;
 
 	struct ida tx_halloc;
 
-	struct mlx5e_macsec_tables tables;
+	struct mlx5_macsec_tables tables;
 };
 
-struct mlx5e_macsec_rx_rule {
+struct mlx5_macsec_rx_rule {
 	struct mlx5_flow_handle *rule[RX_NUM_OF_RULES_PER_SA];
 	struct mlx5_modify_hdr *meta_modhdr;
 };
 
-struct mlx5e_macsec_rx {
+struct mlx5_macsec_rx {
 	struct mlx5_flow_handle *check_rule[2];
 	struct mlx5_pkt_reformat *check_rule_pkt_reformat[2];
 
-	struct mlx5e_macsec_tables tables;
+	struct mlx5_macsec_tables tables;
 };
 
-union mlx5e_macsec_rule {
-	struct mlx5e_macsec_tx_rule tx_rule;
-	struct mlx5e_macsec_rx_rule rx_rule;
+union mlx5_macsec_rule {
+	struct mlx5_macsec_tx_rule tx_rule;
+	struct mlx5_macsec_rx_rule rx_rule;
 };
 
-struct mlx5e_macsec_fs {
+struct mlx5_macsec_fs {
 	struct mlx5_core_dev *mdev;
 	struct net_device *netdev;
-	struct mlx5e_macsec_tx *tx_fs;
-	struct mlx5e_macsec_rx *rx_fs;
+	struct mlx5_macsec_tx *tx_fs;
+	struct mlx5_macsec_rx *rx_fs;
 };
 
 static void macsec_fs_destroy_groups(struct mlx5_macsec_flow_table *ft)
@@ -128,10 +128,10 @@ static void macsec_fs_destroy_flow_table(struct mlx5_macsec_flow_table *ft)
 	ft->t = NULL;
 }
 
-static void macsec_fs_tx_destroy(struct mlx5e_macsec_fs *macsec_fs)
+static void macsec_fs_tx_destroy(struct mlx5_macsec_fs *macsec_fs)
 {
-	struct mlx5e_macsec_tx *tx_fs = macsec_fs->tx_fs;
-	struct mlx5e_macsec_tables *tx_tables;
+	struct mlx5_macsec_tx *tx_fs = macsec_fs->tx_fs;
+	struct mlx5_macsec_tables *tx_tables;
 
 	tx_tables = &tx_fs->tables;
 
@@ -261,14 +261,14 @@ static struct mlx5_flow_table
 	return fdb;
 }
 
-static int macsec_fs_tx_create(struct mlx5e_macsec_fs *macsec_fs)
+static int macsec_fs_tx_create(struct mlx5_macsec_fs *macsec_fs)
 {
 	int inlen = MLX5_ST_SZ_BYTES(create_flow_group_in);
-	struct mlx5e_macsec_tx *tx_fs = macsec_fs->tx_fs;
+	struct mlx5_macsec_tx *tx_fs = macsec_fs->tx_fs;
 	struct net_device *netdev = macsec_fs->netdev;
 	struct mlx5_flow_table_attr ft_attr = {};
 	struct mlx5_flow_destination dest = {};
-	struct mlx5e_macsec_tables *tx_tables;
+	struct mlx5_macsec_tables *tx_tables;
 	struct mlx5_flow_act flow_act = {};
 	struct mlx5_macsec_flow_table *ft_crypto;
 	struct mlx5_flow_table *flow_table;
@@ -414,10 +414,10 @@ static int macsec_fs_tx_create(struct mlx5e_macsec_fs *macsec_fs)
 	return err;
 }
 
-static int macsec_fs_tx_ft_get(struct mlx5e_macsec_fs *macsec_fs)
+static int macsec_fs_tx_ft_get(struct mlx5_macsec_fs *macsec_fs)
 {
-	struct mlx5e_macsec_tx *tx_fs = macsec_fs->tx_fs;
-	struct mlx5e_macsec_tables *tx_tables;
+	struct mlx5_macsec_tx *tx_fs = macsec_fs->tx_fs;
+	struct mlx5_macsec_tables *tx_tables;
 	int err = 0;
 
 	tx_tables = &tx_fs->tables;
@@ -433,9 +433,9 @@ static int macsec_fs_tx_ft_get(struct mlx5e_macsec_fs *macsec_fs)
 	return err;
 }
 
-static void macsec_fs_tx_ft_put(struct mlx5e_macsec_fs *macsec_fs)
+static void macsec_fs_tx_ft_put(struct mlx5_macsec_fs *macsec_fs)
 {
-	struct mlx5e_macsec_tables *tx_tables = &macsec_fs->tx_fs->tables;
+	struct mlx5_macsec_tables *tx_tables = &macsec_fs->tx_fs->tables;
 
 	if (--tx_tables->refcnt)
 		return;
@@ -443,13 +443,13 @@ static void macsec_fs_tx_ft_put(struct mlx5e_macsec_fs *macsec_fs)
 	macsec_fs_tx_destroy(macsec_fs);
 }
 
-static int macsec_fs_tx_setup_fte(struct mlx5e_macsec_fs *macsec_fs,
+static int macsec_fs_tx_setup_fte(struct mlx5_macsec_fs *macsec_fs,
 				  struct mlx5_flow_spec *spec,
 				  struct mlx5_flow_act *flow_act,
 				  u32 macsec_obj_id,
 				  u32 *fs_id)
 {
-	struct mlx5e_macsec_tx *tx_fs = macsec_fs->tx_fs;
+	struct mlx5_macsec_tx *tx_fs = macsec_fs->tx_fs;
 	int err = 0;
 	u32 id;
 
@@ -512,8 +512,8 @@ static void macsec_fs_tx_create_sectag_header(const struct macsec_context *ctx,
 	memcpy(reformatbf, &sectag, *reformat_size);
 }
 
-static void macsec_fs_tx_del_rule(struct mlx5e_macsec_fs *macsec_fs,
-				  struct mlx5e_macsec_tx_rule *tx_rule)
+static void macsec_fs_tx_del_rule(struct mlx5_macsec_fs *macsec_fs,
+				  struct mlx5_macsec_tx_rule *tx_rule)
 {
 	if (tx_rule->rule) {
 		mlx5_del_flow_rules(tx_rule->rule);
@@ -537,20 +537,20 @@ static void macsec_fs_tx_del_rule(struct mlx5e_macsec_fs *macsec_fs,
 
 #define MLX5_REFORMAT_PARAM_ADD_MACSEC_OFFSET_4_BYTES 1
 
-static union mlx5e_macsec_rule *
-macsec_fs_tx_add_rule(struct mlx5e_macsec_fs *macsec_fs,
+static union mlx5_macsec_rule *
+macsec_fs_tx_add_rule(struct mlx5_macsec_fs *macsec_fs,
 		      const struct macsec_context *macsec_ctx,
 		      struct mlx5_macsec_rule_attrs *attrs,
 		      u32 *sa_fs_id)
 {
 	char reformatbf[MLX5_MACSEC_TAG_LEN + MACSEC_SCI_LEN];
 	struct mlx5_pkt_reformat_params reformat_params = {};
-	struct mlx5e_macsec_tx *tx_fs = macsec_fs->tx_fs;
+	struct mlx5_macsec_tx *tx_fs = macsec_fs->tx_fs;
 	struct net_device *netdev = macsec_fs->netdev;
-	union mlx5e_macsec_rule *macsec_rule = NULL;
+	union mlx5_macsec_rule *macsec_rule = NULL;
 	struct mlx5_flow_destination dest = {};
-	struct mlx5e_macsec_tables *tx_tables;
-	struct mlx5e_macsec_tx_rule *tx_rule;
+	struct mlx5_macsec_tables *tx_tables;
+	struct mlx5_macsec_tx_rule *tx_rule;
 	struct mlx5_flow_act flow_act = {};
 	struct mlx5_flow_handle *rule;
 	struct mlx5_flow_spec *spec;
@@ -631,11 +631,11 @@ macsec_fs_tx_add_rule(struct mlx5e_macsec_fs *macsec_fs,
 	return macsec_rule;
 }
 
-static void macsec_fs_tx_cleanup(struct mlx5e_macsec_fs *macsec_fs)
+static void macsec_fs_tx_cleanup(struct mlx5_macsec_fs *macsec_fs)
 {
-	struct mlx5e_macsec_tx *tx_fs = macsec_fs->tx_fs;
+	struct mlx5_macsec_tx *tx_fs = macsec_fs->tx_fs;
 	struct mlx5_core_dev *mdev = macsec_fs->mdev;
-	struct mlx5e_macsec_tables *tx_tables;
+	struct mlx5_macsec_tables *tx_tables;
 
 	if (!tx_fs)
 		return;
@@ -664,12 +664,12 @@ static void macsec_fs_tx_cleanup(struct mlx5e_macsec_fs *macsec_fs)
 	macsec_fs->tx_fs = NULL;
 }
 
-static int macsec_fs_tx_init(struct mlx5e_macsec_fs *macsec_fs)
+static int macsec_fs_tx_init(struct mlx5_macsec_fs *macsec_fs)
 {
 	struct net_device *netdev = macsec_fs->netdev;
 	struct mlx5_core_dev *mdev = macsec_fs->mdev;
-	struct mlx5e_macsec_tables *tx_tables;
-	struct mlx5e_macsec_tx *tx_fs;
+	struct mlx5_macsec_tables *tx_tables;
+	struct mlx5_macsec_tx *tx_fs;
 	struct mlx5_fc *flow_counter;
 	int err;
 
@@ -716,10 +716,10 @@ static int macsec_fs_tx_init(struct mlx5e_macsec_fs *macsec_fs)
 	return err;
 }
 
-static void macsec_fs_rx_destroy(struct mlx5e_macsec_fs *macsec_fs)
+static void macsec_fs_rx_destroy(struct mlx5_macsec_fs *macsec_fs)
 {
-	struct mlx5e_macsec_rx *rx_fs = macsec_fs->rx_fs;
-	struct mlx5e_macsec_tables *rx_tables;
+	struct mlx5_macsec_rx *rx_fs = macsec_fs->rx_fs;
+	struct mlx5_macsec_tables *rx_tables;
 	int i;
 
 	/* Rx check table */
@@ -844,7 +844,7 @@ static int macsec_fs_rx_create_crypto_table_groups(struct mlx5_macsec_flow_table
 	return err;
 }
 
-static int macsec_fs_rx_create_check_decap_rule(struct mlx5e_macsec_fs *macsec_fs,
+static int macsec_fs_rx_create_check_decap_rule(struct mlx5_macsec_fs *macsec_fs,
 						struct mlx5_flow_destination *dest,
 						struct mlx5_flow_act *flow_act,
 						struct mlx5_flow_spec *spec,
@@ -853,9 +853,9 @@ static int macsec_fs_rx_create_check_decap_rule(struct mlx5e_macsec_fs *macsec_f
 	int rule_index = (reformat_param_size == MLX5_SECTAG_HEADER_SIZE_WITH_SCI) ? 0 : 1;
 	u8 mlx5_reformat_buf[MLX5_SECTAG_HEADER_SIZE_WITH_SCI];
 	struct mlx5_pkt_reformat_params reformat_params = {};
-	struct mlx5e_macsec_rx *rx_fs = macsec_fs->rx_fs;
+	struct mlx5_macsec_rx *rx_fs = macsec_fs->rx_fs;
 	struct net_device *netdev = macsec_fs->netdev;
-	struct mlx5e_macsec_tables *rx_tables;
+	struct mlx5_macsec_tables *rx_tables;
 	struct mlx5_flow_handle *rule;
 	int err = 0;
 
@@ -915,15 +915,15 @@ static int macsec_fs_rx_create_check_decap_rule(struct mlx5e_macsec_fs *macsec_f
 	return 0;
 }
 
-static int macsec_fs_rx_create(struct mlx5e_macsec_fs *macsec_fs)
+static int macsec_fs_rx_create(struct mlx5_macsec_fs *macsec_fs)
 {
 	int inlen = MLX5_ST_SZ_BYTES(create_flow_group_in);
-	struct mlx5e_macsec_rx *rx_fs = macsec_fs->rx_fs;
+	struct mlx5_macsec_rx *rx_fs = macsec_fs->rx_fs;
 	struct net_device *netdev = macsec_fs->netdev;
 	struct mlx5_macsec_flow_table *ft_crypto;
 	struct mlx5_flow_table_attr ft_attr = {};
 	struct mlx5_flow_destination dest = {};
-	struct mlx5e_macsec_tables *rx_tables;
+	struct mlx5_macsec_tables *rx_tables;
 	struct mlx5_flow_table *flow_table;
 	struct mlx5_flow_group *flow_group;
 	struct mlx5_flow_act flow_act = {};
@@ -1043,9 +1043,9 @@ static int macsec_fs_rx_create(struct mlx5e_macsec_fs *macsec_fs)
 	return err;
 }
 
-static int macsec_fs_rx_ft_get(struct mlx5e_macsec_fs *macsec_fs)
+static int macsec_fs_rx_ft_get(struct mlx5_macsec_fs *macsec_fs)
 {
-	struct mlx5e_macsec_tables *rx_tables = &macsec_fs->rx_fs->tables;
+	struct mlx5_macsec_tables *rx_tables = &macsec_fs->rx_fs->tables;
 	int err = 0;
 
 	if (rx_tables->refcnt)
@@ -1060,9 +1060,9 @@ static int macsec_fs_rx_ft_get(struct mlx5e_macsec_fs *macsec_fs)
 	return err;
 }
 
-static void macsec_fs_rx_ft_put(struct mlx5e_macsec_fs *macsec_fs)
+static void macsec_fs_rx_ft_put(struct mlx5_macsec_fs *macsec_fs)
 {
-	struct mlx5e_macsec_tables *rx_tables = &macsec_fs->rx_fs->tables;
+	struct mlx5_macsec_tables *rx_tables = &macsec_fs->rx_fs->tables;
 
 	if (--rx_tables->refcnt)
 		return;
@@ -1070,8 +1070,8 @@ static void macsec_fs_rx_ft_put(struct mlx5e_macsec_fs *macsec_fs)
 	macsec_fs_rx_destroy(macsec_fs);
 }
 
-static void macsec_fs_rx_del_rule(struct mlx5e_macsec_fs *macsec_fs,
-				  struct mlx5e_macsec_rx_rule *rx_rule)
+static void macsec_fs_rx_del_rule(struct mlx5_macsec_fs *macsec_fs,
+				  struct mlx5_macsec_rx_rule *rx_rule)
 {
 	int i;
 
@@ -1138,20 +1138,20 @@ static void macsec_fs_rx_setup_fte(struct mlx5_flow_spec *spec,
 	crypto_params->obj_id = attrs->macsec_obj_id;
 }
 
-static union mlx5e_macsec_rule *
-macsec_fs_rx_add_rule(struct mlx5e_macsec_fs *macsec_fs,
+static union mlx5_macsec_rule *
+macsec_fs_rx_add_rule(struct mlx5_macsec_fs *macsec_fs,
 		      struct mlx5_macsec_rule_attrs *attrs,
 		      u32 fs_id)
 {
 	u8 action[MLX5_UN_SZ_BYTES(set_add_copy_action_in_auto)] = {};
-	struct mlx5e_macsec_rx *rx_fs = macsec_fs->rx_fs;
+	struct mlx5_macsec_rx *rx_fs = macsec_fs->rx_fs;
 	struct net_device *netdev = macsec_fs->netdev;
-	union mlx5e_macsec_rule *macsec_rule = NULL;
+	union mlx5_macsec_rule *macsec_rule = NULL;
 	struct mlx5_modify_hdr *modify_hdr = NULL;
 	struct mlx5_macsec_flow_table *ft_crypto;
 	struct mlx5_flow_destination dest = {};
-	struct mlx5e_macsec_tables *rx_tables;
-	struct mlx5e_macsec_rx_rule *rx_rule;
+	struct mlx5_macsec_tables *rx_tables;
+	struct mlx5_macsec_rx_rule *rx_rule;
 	struct mlx5_flow_act flow_act = {};
 	struct mlx5_flow_handle *rule;
 	struct mlx5_flow_spec *spec;
@@ -1250,12 +1250,12 @@ macsec_fs_rx_add_rule(struct mlx5e_macsec_fs *macsec_fs,
 	return macsec_rule;
 }
 
-static int macsec_fs_rx_init(struct mlx5e_macsec_fs *macsec_fs)
+static int macsec_fs_rx_init(struct mlx5_macsec_fs *macsec_fs)
 {
 	struct net_device *netdev = macsec_fs->netdev;
 	struct mlx5_core_dev *mdev = macsec_fs->mdev;
-	struct mlx5e_macsec_tables *rx_tables;
-	struct mlx5e_macsec_rx *rx_fs;
+	struct mlx5_macsec_tables *rx_tables;
+	struct mlx5_macsec_rx *rx_fs;
 	struct mlx5_fc *flow_counter;
 	int err;
 
@@ -1300,11 +1300,11 @@ static int macsec_fs_rx_init(struct mlx5e_macsec_fs *macsec_fs)
 	return err;
 }
 
-static void macsec_fs_rx_cleanup(struct mlx5e_macsec_fs *macsec_fs)
+static void macsec_fs_rx_cleanup(struct mlx5_macsec_fs *macsec_fs)
 {
-	struct mlx5e_macsec_rx *rx_fs = macsec_fs->rx_fs;
+	struct mlx5_macsec_rx *rx_fs = macsec_fs->rx_fs;
 	struct mlx5_core_dev *mdev = macsec_fs->mdev;
-	struct mlx5e_macsec_tables *rx_tables;
+	struct mlx5_macsec_tables *rx_tables;
 
 	if (!rx_fs)
 		return;
@@ -1332,11 +1332,11 @@ static void macsec_fs_rx_cleanup(struct mlx5e_macsec_fs *macsec_fs)
 	macsec_fs->rx_fs = NULL;
 }
 
-void mlx5e_macsec_fs_get_stats_fill(struct mlx5e_macsec_fs *macsec_fs, void *macsec_stats)
+void mlx5_macsec_fs_get_stats_fill(struct mlx5_macsec_fs *macsec_fs, void *macsec_stats)
 {
-	struct mlx5e_macsec_stats *stats = (struct mlx5e_macsec_stats *)macsec_stats;
-	struct mlx5e_macsec_tables *tx_tables = &macsec_fs->tx_fs->tables;
-	struct mlx5e_macsec_tables *rx_tables = &macsec_fs->rx_fs->tables;
+	struct mlx5_macsec_stats *stats = (struct mlx5_macsec_stats *)macsec_stats;
+	struct mlx5_macsec_tables *tx_tables = &macsec_fs->tx_fs->tables;
+	struct mlx5_macsec_tables *rx_tables = &macsec_fs->rx_fs->tables;
 	struct mlx5_core_dev *mdev = macsec_fs->mdev;
 
 	if (tx_tables->check_rule_counter)
@@ -1356,38 +1356,38 @@ void mlx5e_macsec_fs_get_stats_fill(struct mlx5e_macsec_fs *macsec_fs, void *mac
 			      &stats->macsec_rx_pkts_drop, &stats->macsec_rx_bytes_drop);
 }
 
-union mlx5e_macsec_rule *
-mlx5e_macsec_fs_add_rule(struct mlx5e_macsec_fs *macsec_fs,
-			 const struct macsec_context *macsec_ctx,
-			 struct mlx5_macsec_rule_attrs *attrs,
-			 u32 *sa_fs_id)
+union mlx5_macsec_rule *
+mlx5_macsec_fs_add_rule(struct mlx5_macsec_fs *macsec_fs,
+			const struct macsec_context *macsec_ctx,
+			struct mlx5_macsec_rule_attrs *attrs,
+			u32 *sa_fs_id)
 {
 	return (attrs->action == MLX5_ACCEL_MACSEC_ACTION_ENCRYPT) ?
 		macsec_fs_tx_add_rule(macsec_fs, macsec_ctx, attrs, sa_fs_id) :
 		macsec_fs_rx_add_rule(macsec_fs, attrs, *sa_fs_id);
 }
 
-void mlx5e_macsec_fs_del_rule(struct mlx5e_macsec_fs *macsec_fs,
-			      union mlx5e_macsec_rule *macsec_rule,
-			      int action)
+void mlx5_macsec_fs_del_rule(struct mlx5_macsec_fs *macsec_fs,
+			     union mlx5_macsec_rule *macsec_rule,
+			     int action)
 {
 	(action == MLX5_ACCEL_MACSEC_ACTION_ENCRYPT) ?
 		macsec_fs_tx_del_rule(macsec_fs, &macsec_rule->tx_rule) :
 		macsec_fs_rx_del_rule(macsec_fs, &macsec_rule->rx_rule);
 }
 
-void mlx5e_macsec_fs_cleanup(struct mlx5e_macsec_fs *macsec_fs)
+void mlx5_macsec_fs_cleanup(struct mlx5_macsec_fs *macsec_fs)
 {
 	macsec_fs_rx_cleanup(macsec_fs);
 	macsec_fs_tx_cleanup(macsec_fs);
 	kfree(macsec_fs);
 }
 
-struct mlx5e_macsec_fs *
-mlx5e_macsec_fs_init(struct mlx5_core_dev *mdev,
-		     struct net_device *netdev)
+struct mlx5_macsec_fs *
+mlx5_macsec_fs_init(struct mlx5_core_dev *mdev,
+		    struct net_device *netdev)
 {
-	struct mlx5e_macsec_fs *macsec_fs;
+	struct mlx5_macsec_fs *macsec_fs;
 	int err;
 
 	macsec_fs = kzalloc(sizeof(*macsec_fs), GFP_KERNEL);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.h
index b282c0850e16..6a749e036e68 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.h
@@ -14,8 +14,8 @@
 
 #define MLX5_MACSEC_NUM_OF_SUPPORTED_INTERFACES 16
 
-struct mlx5e_macsec_fs;
-union mlx5e_macsec_rule;
+struct mlx5_macsec_fs;
+union mlx5_macsec_rule;
 
 struct mlx5_macsec_rule_attrs {
 	sci_t sci;
@@ -24,7 +24,7 @@ struct mlx5_macsec_rule_attrs {
 	int action;
 };
 
-struct mlx5e_macsec_stats {
+struct mlx5_macsec_stats {
 	u64 macsec_rx_pkts;
 	u64 macsec_rx_bytes;
 	u64 macsec_rx_pkts_drop;
@@ -40,22 +40,22 @@ enum mlx5_macsec_action {
 	MLX5_ACCEL_MACSEC_ACTION_DECRYPT,
 };
 
-void mlx5e_macsec_fs_cleanup(struct mlx5e_macsec_fs *macsec_fs);
+void mlx5_macsec_fs_cleanup(struct mlx5_macsec_fs *macsec_fs);
 
-struct mlx5e_macsec_fs *
-mlx5e_macsec_fs_init(struct mlx5_core_dev *mdev, struct net_device *netdev);
+struct mlx5_macsec_fs *
+mlx5_macsec_fs_init(struct mlx5_core_dev *mdev, struct net_device *netdev);
 
-union mlx5e_macsec_rule *
-mlx5e_macsec_fs_add_rule(struct mlx5e_macsec_fs *macsec_fs,
-			 const struct macsec_context *ctx,
-			 struct mlx5_macsec_rule_attrs *attrs,
-			 u32 *sa_fs_id);
+union mlx5_macsec_rule *
+mlx5_macsec_fs_add_rule(struct mlx5_macsec_fs *macsec_fs,
+			const struct macsec_context *ctx,
+			struct mlx5_macsec_rule_attrs *attrs,
+			u32 *sa_fs_id);
 
-void mlx5e_macsec_fs_del_rule(struct mlx5e_macsec_fs *macsec_fs,
-			      union mlx5e_macsec_rule *macsec_rule,
-			      int action);
+void mlx5_macsec_fs_del_rule(struct mlx5_macsec_fs *macsec_fs,
+			     union mlx5_macsec_rule *macsec_rule,
+			     int action);
 
-void mlx5e_macsec_fs_get_stats_fill(struct mlx5e_macsec_fs *macsec_fs, void *macsec_stats);
+void mlx5_macsec_fs_get_stats_fill(struct mlx5_macsec_fs *macsec_fs, void *macsec_stats);
 
 #endif
 
-- 
2.41.0

