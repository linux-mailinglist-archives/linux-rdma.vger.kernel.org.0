Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13CBF72702A
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Jun 2023 23:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235920AbjFGVFj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Jun 2023 17:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236644AbjFGVFG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Jun 2023 17:05:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C4D2D6A
        for <linux-rdma@vger.kernel.org>; Wed,  7 Jun 2023 14:04:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E42F649F0
        for <linux-rdma@vger.kernel.org>; Wed,  7 Jun 2023 21:04:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BD58C433AC;
        Wed,  7 Jun 2023 21:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686171872;
        bh=FNM51TLwVFHesXXwp2j/Sy3SQ1DLOAGSc+DrGiAmQCc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mzcK4MujV3UmS6VQZqNc6gsnTZZIZIBKMqQJFWE9MY3ojtLD5jVZmTinwJBSPpbYD
         UZBtOhdNSOXY0xSODHkUh+67O30B4k3/Ey04ldGwcpI+HikoslhmoNFdAeD1dck4MH
         OT9crWf5Cb2ONdCW9haxSTDH/lORea94I55reTYjPFnQlkuRQjXELx5QCkZOo4WCy0
         mIsZm9xjaWk8dHAPAKCZfl68wC2PhARApaMS3zlZQW6INnUh7MmYd0HJ5YhxCL8j+q
         jwZLRs3tTo/j3Z9JCCcPq17RXRahkTGlPG/M+1hEIBx/Cf0wdqfARSbxx9DManlBnJ
         X8cDfy4vJrmEw==
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
Subject: [net-next V2 05/14] net/mlx5: LAG, change mlx5_shared_fdb_supported() to static
Date:   Wed,  7 Jun 2023 14:04:01 -0700
Message-Id: <20230607210410.88209-6-saeed@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230607210410.88209-1-saeed@kernel.org>
References: <20230607210410.88209-1-saeed@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Shay Drory <shayd@nvidia.com>

mlx5_shared_fdb_supported() is used only in a single file. Change the
function to be static.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
index 00773aab9d20..6ce71c42c755 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
@@ -815,7 +815,7 @@ void mlx5_disable_lag(struct mlx5_lag *ldev)
 				mlx5_eswitch_reload_reps(ldev->pf[i].dev->priv.eswitch);
 }
 
-bool mlx5_shared_fdb_supported(struct mlx5_lag *ldev)
+static bool mlx5_shared_fdb_supported(struct mlx5_lag *ldev)
 {
 	struct mlx5_core_dev *dev;
 	int i;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
index bc1f1dd3e283..d7e7fa2348a5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
@@ -111,7 +111,6 @@ int mlx5_activate_lag(struct mlx5_lag *ldev,
 		      bool shared_fdb);
 int mlx5_lag_dev_get_netdev_idx(struct mlx5_lag *ldev,
 				struct net_device *ndev);
-bool mlx5_shared_fdb_supported(struct mlx5_lag *ldev);
 
 char *mlx5_get_str_port_sel_mode(enum mlx5_lag_mode mode, unsigned long flags);
 void mlx5_infer_tx_enabled(struct lag_tracker *tracker, u8 num_ports,
-- 
2.40.1

