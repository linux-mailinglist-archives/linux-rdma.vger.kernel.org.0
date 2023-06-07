Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA90727038
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Jun 2023 23:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236233AbjFGVFt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Jun 2023 17:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236403AbjFGVE7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Jun 2023 17:04:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5782695
        for <linux-rdma@vger.kernel.org>; Wed,  7 Jun 2023 14:04:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C7EF649ED
        for <linux-rdma@vger.kernel.org>; Wed,  7 Jun 2023 21:04:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 906CFC433A4;
        Wed,  7 Jun 2023 21:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686171869;
        bh=nazBkLhFgUDUTNhrBxWBkILuuUUc4r4ig0UUvi9zxbM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ixqF92g9FtimdRl9wl2tgBtLY8lLmaL1ch7FB41Ov/AiiYq5VCNPU+NdKq8cAx4k3
         J/P46xNFwGUbXoJZSM8dbte5KSz8f9fRAujESJA0mJCf/yVR8hbTsTB6VNQcMit5uq
         ebR/ZZshcZZyTJcxD6H3eYZn/9IK8ldkXQBO3uBrWSmAMYMPUKElcHQU/hKyCbFtZG
         0LRvhtX1ALWE/FVt4bOtgbG6k0mo7uBu52GUouMtAmXxpI5i5pbhYQc0LeMfmduk5x
         OYCZwmtpFECxX5851j15k59ByRdFSAtTdX41IgD3s2G/NavKmK8ymg6tOEi0fQyq94
         03FrTO8QD/fUA==
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
Subject: [net-next V2 03/14] net/mlx5: LAG, check if all eswitches are paired for shared FDB
Date:   Wed,  7 Jun 2023 14:03:59 -0700
Message-Id: <20230607210410.88209-4-saeed@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230607210410.88209-1-saeed@kernel.org>
References: <20230607210410.88209-1-saeed@kernel.org>
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

Shared FDB LAG can only work if all eswitches are paired.
Also, whenever two eswitches are paired, devcom is marked as ready.

Therefore, in case of device with two eswitches, checking devcom was
sufficient. However, this is not correct for device with more than
two eswitches, which will be introduced in downstream patch.
Hence, check all eswitches are paired explicitly.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h | 9 +++++++++
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c | 4 +++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index c42c16d9ccbc..d3608f198e0a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -779,6 +779,13 @@ static inline int mlx5_eswitch_num_vfs(struct mlx5_eswitch *esw)
 	return 0;
 }
 
+static inline int mlx5_eswitch_get_npeers(struct mlx5_eswitch *esw)
+{
+	if (mlx5_esw_allowed(esw))
+		return esw->num_peers;
+	return 0;
+}
+
 static inline struct mlx5_flow_table *
 mlx5_eswitch_get_slow_fdb(struct mlx5_eswitch *esw)
 {
@@ -826,6 +833,8 @@ static inline void
 mlx5_eswitch_offloads_single_fdb_del_one(struct mlx5_eswitch *master_esw,
 					 struct mlx5_eswitch *slave_esw) {}
 
+static inline int mlx5_eswitch_get_npeers(struct mlx5_eswitch *esw) { return 0; }
+
 static inline int
 mlx5_eswitch_reload_reps(struct mlx5_eswitch *esw)
 {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
index c55e36e0571d..dd8a19d85617 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
@@ -828,7 +828,9 @@ bool mlx5_shared_fdb_supported(struct mlx5_lag *ldev)
 				      MLX5_DEVCOM_ESW_OFFLOADS) &&
 	    MLX5_CAP_GEN(dev1, lag_native_fdb_selection) &&
 	    MLX5_CAP_ESW(dev1, root_ft_on_other_esw) &&
-	    MLX5_CAP_ESW(dev0, esw_shared_ingress_acl))
+	    MLX5_CAP_ESW(dev0, esw_shared_ingress_acl) &&
+	    mlx5_eswitch_get_npeers(dev0->priv.eswitch) == MLX5_CAP_GEN(dev0, num_lag_ports) - 1 &&
+	    mlx5_eswitch_get_npeers(dev1->priv.eswitch) == MLX5_CAP_GEN(dev1, num_lag_ports) - 1)
 		return true;
 
 	return false;
-- 
2.40.1

