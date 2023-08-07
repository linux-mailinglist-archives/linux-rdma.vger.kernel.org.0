Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5D0771E81
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Aug 2023 12:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbjHGKpQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Aug 2023 06:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbjHGKpD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Aug 2023 06:45:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC5919B5
        for <linux-rdma@vger.kernel.org>; Mon,  7 Aug 2023 03:44:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BE98617B2
        for <linux-rdma@vger.kernel.org>; Mon,  7 Aug 2023 10:44:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 322DCC433AD;
        Mon,  7 Aug 2023 10:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691405085;
        bh=1olxSa6/GVEvtf7qOZ8RdeK9nsio98ZgymSUELgiJ2g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aoOztcF2ZmM+86rFuGkrHbSa7uKtO4Cj2W2gkn680CdJIOuMEa81ANYhLLnDYTK66
         YHHWpvbKCT9eknM9VXDhau6q4HrtWOJbbULM+uiAVilosq5mWgEBMHrzIynKcCLwg8
         1EvBxSezjv4NicpQ+uP2A/Q3m3K5AgXERw6OkaAy8ORwXv/qLg85PXBl5dq+utqCRs
         Js9aHu0WnNU+L5455KsXo35vIMuFCx2EVV3t+eegRTQD77a11BpTxsjpqsDzyrKFHQ
         7sjPLlXo9fGzsb8MpI4HdlEFOQASl+wxtZXK7XqszEPeEDm8HV+qEhoPLjrBEu1Q7E
         s7OG2yB6ALRMw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>, Jakub Kicinski <kuba@kernel.org>
Cc:     Patrisious Haddad <phaddad@nvidia.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>,
        Mark Zhang <markzhang@nvidia.com>, netdev@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>, Raed Salem <raeds@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH mlx5-next 05/14] net/mlx5e: Move MACsec flow steering and statistics database from ethernet to core
Date:   Mon,  7 Aug 2023 13:44:14 +0300
Message-ID: <e1601c7142d81af558d5b53564cf93011db9fb62.1691403485.git.leon@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1691403485.git.leon@kernel.org>
References: <cover.1691403485.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Patrisious Haddad <phaddad@nvidia.com>

Since now MACsec flow steering (macsec_fs) and MACsec statistics (stats)
are maintained by the core driver, move their data as well to be saved
inside core structures instead of staying part of ethernet MACsec database.

In addition cleanup all MACsec stats functions from the ethernet MACsec
code and move what's needed to be part of macsec_fs instead.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 .../mellanox/mlx5/core/en_accel/macsec.c      | 25 +++----------------
 .../mellanox/mlx5/core/en_accel/macsec.h      |  2 --
 .../mlx5/core/en_accel/macsec_stats.c         |  6 +++--
 .../mellanox/mlx5/core/lib/macsec_fs.c        | 11 ++++++++
 .../mellanox/mlx5/core/lib/macsec_fs.h        |  1 +
 include/linux/mlx5/driver.h                   |  3 +++
 6 files changed, 23 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
index 831d83094abd..5e8ad355c67f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
@@ -124,7 +124,6 @@ struct mlx5e_macsec_device {
 struct mlx5e_macsec {
 	struct list_head macsec_device_list_head;
 	int num_of_devices;
-	struct mlx5_macsec_fs *macsec_fs;
 	struct mutex lock; /* Protects mlx5e_macsec internal contexts */
 
 	/* Tx sci -> fs id mapping handling */
@@ -135,9 +134,6 @@ struct mlx5e_macsec {
 
 	struct mlx5_core_dev *mdev;
 
-	/* Stats manage */
-	struct mlx5_macsec_stats stats;
-
 	/* ASO */
 	struct mlx5e_macsec_aso aso;
 
@@ -343,7 +339,7 @@ static void mlx5e_macsec_cleanup_sa(struct mlx5e_macsec *macsec,
 	if (!sa->macsec_rule)
 		return;
 
-	mlx5_macsec_fs_del_rule(macsec->macsec_fs, sa->macsec_rule, action);
+	mlx5_macsec_fs_del_rule(macsec->mdev->macsec_fs, sa->macsec_rule, action);
 	mlx5e_macsec_destroy_object(macsec->mdev, sa->macsec_obj_id);
 	sa->macsec_rule = NULL;
 }
@@ -386,7 +382,7 @@ static int mlx5e_macsec_init_sa(struct macsec_context *ctx,
 	rule_attrs.action = (is_tx) ? MLX5_ACCEL_MACSEC_ACTION_ENCRYPT :
 				      MLX5_ACCEL_MACSEC_ACTION_DECRYPT;
 
-	macsec_rule = mlx5_macsec_fs_add_rule(macsec->macsec_fs, ctx, &rule_attrs, &sa->fs_id);
+	macsec_rule = mlx5_macsec_fs_add_rule(mdev->macsec_fs, ctx, &rule_attrs, &sa->fs_id);
 	if (!macsec_rule) {
 		err = -ENOMEM;
 		goto destroy_macsec_object;
@@ -1677,19 +1673,6 @@ bool mlx5e_is_macsec_device(const struct mlx5_core_dev *mdev)
 	return true;
 }
 
-void mlx5e_macsec_get_stats_fill(struct mlx5e_macsec *macsec, void *macsec_stats)
-{
-	mlx5_macsec_fs_get_stats_fill(macsec->macsec_fs, macsec_stats);
-}
-
-struct mlx5_macsec_stats *mlx5e_macsec_get_stats(struct mlx5e_macsec *macsec)
-{
-	if (!macsec)
-		return NULL;
-
-	return &macsec->stats;
-}
-
 static const struct macsec_ops macsec_offload_ops = {
 	.mdo_add_txsa = mlx5e_macsec_add_txsa,
 	.mdo_upd_txsa = mlx5e_macsec_upd_txsa,
@@ -1827,7 +1810,7 @@ int mlx5e_macsec_init(struct mlx5e_priv *priv)
 		goto err_out;
 	}
 
-	macsec->macsec_fs = macsec_fs;
+	mdev->macsec_fs = macsec_fs;
 
 	macsec->nb.notifier_call = macsec_obj_change_event;
 	mlx5_notifier_register(mdev, &macsec->nb);
@@ -1857,7 +1840,7 @@ void mlx5e_macsec_cleanup(struct mlx5e_priv *priv)
 		return;
 
 	mlx5_notifier_unregister(mdev, &macsec->nb);
-	mlx5_macsec_fs_cleanup(macsec->macsec_fs);
+	mlx5_macsec_fs_cleanup(mdev->macsec_fs);
 	destroy_workqueue(macsec->wq);
 	mlx5e_macsec_aso_cleanup(&macsec->aso, mdev);
 	rhashtable_destroy(&macsec->sci_hash);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.h
index 47dc1d4448d9..2ecd769585f4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.h
@@ -37,8 +37,6 @@ static inline bool mlx5e_macsec_is_rx_flow(struct mlx5_cqe64 *cqe)
 void mlx5e_macsec_offload_handle_rx_skb(struct net_device *netdev, struct sk_buff *skb,
 					struct mlx5_cqe64 *cqe);
 bool mlx5e_is_macsec_device(const struct mlx5_core_dev *mdev);
-void mlx5e_macsec_get_stats_fill(struct mlx5e_macsec *macsec, void *macsec_stats);
-struct mlx5_macsec_stats *mlx5e_macsec_get_stats(struct mlx5e_macsec *macsec);
 
 #else
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec_stats.c
index 8326a593b3fb..4559ee16a11a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec_stats.c
@@ -52,6 +52,7 @@ static MLX5E_DECLARE_STATS_GRP_OP_FILL_STRS(macsec_hw)
 
 static MLX5E_DECLARE_STATS_GRP_OP_FILL_STATS(macsec_hw)
 {
+	struct mlx5_macsec_fs *macsec_fs;
 	int i;
 
 	if (!priv->macsec)
@@ -60,9 +61,10 @@ static MLX5E_DECLARE_STATS_GRP_OP_FILL_STATS(macsec_hw)
 	if (!mlx5e_is_macsec_device(priv->mdev))
 		return idx;
 
-	mlx5e_macsec_get_stats_fill(priv->macsec, mlx5e_macsec_get_stats(priv->macsec));
+	macsec_fs = priv->mdev->macsec_fs;
+	mlx5_macsec_fs_get_stats_fill(macsec_fs, mlx5_macsec_fs_get_stats(macsec_fs));
 	for (i = 0; i < NUM_MACSEC_HW_COUNTERS; i++)
-		data[idx++] = MLX5E_READ_CTR64_CPU(mlx5e_macsec_get_stats(priv->macsec),
+		data[idx++] = MLX5E_READ_CTR64_CPU(mlx5_macsec_fs_get_stats(macsec_fs),
 						   mlx5e_macsec_hw_stats_desc,
 						   i);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c
index 8feb7db6a220..8c19c6e16ecf 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c
@@ -106,6 +106,9 @@ struct mlx5_macsec_fs {
 	struct net_device *netdev;
 	struct mlx5_macsec_tx *tx_fs;
 	struct mlx5_macsec_rx *rx_fs;
+
+	/* Stats manage */
+	struct mlx5_macsec_stats stats;
 };
 
 static void macsec_fs_destroy_groups(struct mlx5_macsec_flow_table *ft)
@@ -1356,6 +1359,14 @@ void mlx5_macsec_fs_get_stats_fill(struct mlx5_macsec_fs *macsec_fs, void *macse
 			      &stats->macsec_rx_pkts_drop, &stats->macsec_rx_bytes_drop);
 }
 
+struct mlx5_macsec_stats *mlx5_macsec_fs_get_stats(struct mlx5_macsec_fs *macsec_fs)
+{
+	if (!macsec_fs)
+		return NULL;
+
+	return &macsec_fs->stats;
+}
+
 union mlx5_macsec_rule *
 mlx5_macsec_fs_add_rule(struct mlx5_macsec_fs *macsec_fs,
 			const struct macsec_context *macsec_ctx,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.h
index 6a749e036e68..c0c28d08eae5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.h
@@ -56,6 +56,7 @@ void mlx5_macsec_fs_del_rule(struct mlx5_macsec_fs *macsec_fs,
 			     int action);
 
 void mlx5_macsec_fs_get_stats_fill(struct mlx5_macsec_fs *macsec_fs, void *macsec_stats);
+struct mlx5_macsec_stats *mlx5_macsec_fs_get_stats(struct mlx5_macsec_fs *macsec_fs);
 
 #endif
 
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index fa70c25423b2..541c292373e6 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -808,6 +808,9 @@ struct mlx5_core_dev {
 	struct mlx5_thermal	*thermal;
 	u64			num_block_tc;
 	u64			num_block_ipsec;
+#ifdef CONFIG_MLX5_MACSEC
+	struct mlx5_macsec_fs *macsec_fs;
+#endif
 };
 
 struct mlx5_db {
-- 
2.41.0

