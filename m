Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB1E4723885
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Jun 2023 09:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234820AbjFFHM7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Jun 2023 03:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbjFFHMh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Jun 2023 03:12:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FF0E55
        for <linux-rdma@vger.kernel.org>; Tue,  6 Jun 2023 00:12:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1009562DDD
        for <linux-rdma@vger.kernel.org>; Tue,  6 Jun 2023 07:12:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56547C4339B;
        Tue,  6 Jun 2023 07:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686035554;
        bh=2tH5pXqTe8ZHLy54wGRb6ISNgLPdS2xR27Yl4ICKcYQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XZU32f2IpwQUg1PDMWILd5tB6gVMDqo5djhl0JQYbRW7N+pBIvHbFfn8yd11AJMHb
         KOs9LFMNh30Z3PzrltsdnjFv3xyjUNEmOiNy1xIJDQMdD0BEyFitdhrDJutJ5FA1SV
         A/c0uCDuCV8mjq6FkW4KewdFFrihMso/LdAZraVRi0GEcTiy0QEKGY6uz9SrnqQhMF
         V5w8MabteVxkZwRgCTMGJIJycD8yCqr63Ttn/oWSIUzLMy+UCitd6DHBsGtn1AiZ7n
         Z4XprwTwwi22iN0oARI0biSgetqWeQ1TuSzQDflT5AHA8GoNJdU381vO6mUXuDkI+N
         /OmSdPv7yf46w==
From:   Saeed Mahameed <saeed@kernel.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>
Cc:     Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
        Tariq Toukan <tariqt@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        linux-rdma@vger.kernel.org, Shay Drory <shayd@nvidia.com>,
        Mark Bloch <mbloch@nvidia.com>
Subject: [net-next 04/15] net/mlx5: LAG, generalize handling of shared FDB
Date:   Tue,  6 Jun 2023 00:12:08 -0700
Message-Id: <20230606071219.483255-5-saeed@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230606071219.483255-1-saeed@kernel.org>
References: <20230606071219.483255-1-saeed@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Shay Drory <shayd@nvidia.com>

Shared FDB handling is using the assumption that shared FDB can only
be created from two devices.
In order to support shared FDB of more than two devices, iterate over
all LAG ports instead of hard coding only the first two LAG ports
whenever handling shared FDB.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/lag/lag.c | 66 +++++++++++--------
 1 file changed, 38 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
index dd8a19d85617..00773aab9d20 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
@@ -512,8 +512,11 @@ static void mlx5_lag_set_port_sel_mode_offloads(struct mlx5_lag *ldev,
 		return;
 
 	if (MLX5_CAP_PORT_SELECTION(dev0->dev, port_select_flow_table) &&
-	    tracker->tx_type == NETDEV_LAG_TX_TYPE_HASH)
+	    tracker->tx_type == NETDEV_LAG_TX_TYPE_HASH) {
+		if (ldev->ports > 2)
+			ldev->buckets = MLX5_LAG_MAX_HASH_BUCKETS;
 		set_bit(MLX5_LAG_MODE_FLAG_HASH_BASED, flags);
+	}
 }
 
 static int mlx5_lag_set_flags(struct mlx5_lag *ldev, enum mlx5_lag_mode mode,
@@ -782,7 +785,6 @@ void mlx5_disable_lag(struct mlx5_lag *ldev)
 {
 	bool shared_fdb = test_bit(MLX5_LAG_MODE_FLAG_SHARED_FDB, &ldev->mode_flags);
 	struct mlx5_core_dev *dev0 = ldev->pf[MLX5_LAG_P1].dev;
-	struct mlx5_core_dev *dev1 = ldev->pf[MLX5_LAG_P2].dev;
 	bool roce_lag;
 	int err;
 	int i;
@@ -807,30 +809,35 @@ void mlx5_disable_lag(struct mlx5_lag *ldev)
 	if (shared_fdb || roce_lag)
 		mlx5_lag_add_devices(ldev);
 
-	if (shared_fdb) {
-		if (!(dev0->priv.flags & MLX5_PRIV_FLAGS_DISABLE_ALL_ADEV))
-			mlx5_eswitch_reload_reps(dev0->priv.eswitch);
-		if (!(dev1->priv.flags & MLX5_PRIV_FLAGS_DISABLE_ALL_ADEV))
-			mlx5_eswitch_reload_reps(dev1->priv.eswitch);
-	}
+	if (shared_fdb)
+		for (i = 0; i < ldev->ports; i++)
+			if (!(ldev->pf[i].dev->priv.flags & MLX5_PRIV_FLAGS_DISABLE_ALL_ADEV))
+				mlx5_eswitch_reload_reps(ldev->pf[i].dev->priv.eswitch);
 }
 
 bool mlx5_shared_fdb_supported(struct mlx5_lag *ldev)
 {
-	struct mlx5_core_dev *dev0 = ldev->pf[MLX5_LAG_P1].dev;
-	struct mlx5_core_dev *dev1 = ldev->pf[MLX5_LAG_P2].dev;
-
-	if (is_mdev_switchdev_mode(dev0) &&
-	    is_mdev_switchdev_mode(dev1) &&
-	    mlx5_eswitch_vport_match_metadata_enabled(dev0->priv.eswitch) &&
-	    mlx5_eswitch_vport_match_metadata_enabled(dev1->priv.eswitch) &&
-	    mlx5_devcom_comp_is_ready(dev0->priv.devcom,
-				      MLX5_DEVCOM_ESW_OFFLOADS) &&
-	    MLX5_CAP_GEN(dev1, lag_native_fdb_selection) &&
-	    MLX5_CAP_ESW(dev1, root_ft_on_other_esw) &&
-	    MLX5_CAP_ESW(dev0, esw_shared_ingress_acl) &&
-	    mlx5_eswitch_get_npeers(dev0->priv.eswitch) == MLX5_CAP_GEN(dev0, num_lag_ports) - 1 &&
-	    mlx5_eswitch_get_npeers(dev1->priv.eswitch) == MLX5_CAP_GEN(dev1, num_lag_ports) - 1)
+	struct mlx5_core_dev *dev;
+	int i;
+
+	for (i = MLX5_LAG_P1 + 1; i < ldev->ports; i++) {
+		dev = ldev->pf[i].dev;
+		if (is_mdev_switchdev_mode(dev) &&
+		    mlx5_eswitch_vport_match_metadata_enabled(dev->priv.eswitch) &&
+		    MLX5_CAP_GEN(dev, lag_native_fdb_selection) &&
+		    MLX5_CAP_ESW(dev, root_ft_on_other_esw) &&
+		    mlx5_eswitch_get_npeers(dev->priv.eswitch) ==
+		    MLX5_CAP_GEN(dev, num_lag_ports) - 1)
+			continue;
+		return false;
+	}
+
+	dev = ldev->pf[MLX5_LAG_P1].dev;
+	if (is_mdev_switchdev_mode(dev) &&
+	    mlx5_eswitch_vport_match_metadata_enabled(dev->priv.eswitch) &&
+	    mlx5_devcom_comp_is_ready(dev->priv.devcom, MLX5_DEVCOM_ESW_OFFLOADS) &&
+	    MLX5_CAP_ESW(dev, esw_shared_ingress_acl) &&
+	    mlx5_eswitch_get_npeers(dev->priv.eswitch) == MLX5_CAP_GEN(dev, num_lag_ports) - 1)
 		return true;
 
 	return false;
@@ -867,7 +874,6 @@ static bool mlx5_lag_should_disable_lag(struct mlx5_lag *ldev, bool do_bond)
 static void mlx5_do_bond(struct mlx5_lag *ldev)
 {
 	struct mlx5_core_dev *dev0 = ldev->pf[MLX5_LAG_P1].dev;
-	struct mlx5_core_dev *dev1 = ldev->pf[MLX5_LAG_P2].dev;
 	struct lag_tracker tracker = { };
 	bool do_bond, roce_lag;
 	int err;
@@ -908,20 +914,24 @@ static void mlx5_do_bond(struct mlx5_lag *ldev)
 			for (i = 1; i < ldev->ports; i++)
 				mlx5_nic_vport_enable_roce(ldev->pf[i].dev);
 		} else if (shared_fdb) {
+			int i;
+
 			dev0->priv.flags &= ~MLX5_PRIV_FLAGS_DISABLE_IB_ADEV;
 			mlx5_rescan_drivers_locked(dev0);
 
-			err = mlx5_eswitch_reload_reps(dev0->priv.eswitch);
-			if (!err)
-				err = mlx5_eswitch_reload_reps(dev1->priv.eswitch);
+			for (i = 0; i < ldev->ports; i++) {
+				err = mlx5_eswitch_reload_reps(ldev->pf[i].dev->priv.eswitch);
+				if (err)
+					break;
+			}
 
 			if (err) {
 				dev0->priv.flags |= MLX5_PRIV_FLAGS_DISABLE_IB_ADEV;
 				mlx5_rescan_drivers_locked(dev0);
 				mlx5_deactivate_lag(ldev);
 				mlx5_lag_add_devices(ldev);
-				mlx5_eswitch_reload_reps(dev0->priv.eswitch);
-				mlx5_eswitch_reload_reps(dev1->priv.eswitch);
+				for (i = 0; i < ldev->ports; i++)
+					mlx5_eswitch_reload_reps(ldev->pf[i].dev->priv.eswitch);
 				mlx5_core_err(dev0, "Failed to enable lag\n");
 				return;
 			}
-- 
2.40.1

