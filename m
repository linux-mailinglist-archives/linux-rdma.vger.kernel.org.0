Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E55A723886
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Jun 2023 09:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbjFFHNA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Jun 2023 03:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235919AbjFFHMh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Jun 2023 03:12:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669C3E5B
        for <linux-rdma@vger.kernel.org>; Tue,  6 Jun 2023 00:12:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4598C62DE4
        for <linux-rdma@vger.kernel.org>; Tue,  6 Jun 2023 07:12:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81333C43443;
        Tue,  6 Jun 2023 07:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686035555;
        bh=FNM51TLwVFHesXXwp2j/Sy3SQ1DLOAGSc+DrGiAmQCc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=afxpEyQv3xx5K0hmMo1GN+LHudXxeXTZsNnD+yPM4y8Iy1/VxrXvzGBZO7s7u6bZp
         LoMRbAwgxdf3TQjyEQV0DFdsiQsOoNEeTed7ybNTS2ZBfNPWZmOz8RWX9rNqRL7xZn
         hrA2Lw1+75OULjcxzd/k0CYGyzBi+w+2Rlsn/spn+LqCLuwWLsiF61JGNYFQSA87aP
         i1vfWVM9IcAew7goXkVzQNLdttLZ/xXIYTNdJ3dp0PEJHE5iBAjaHYviiJJoqiRaAc
         Bxvncmkjkk+uE7ey4s75LEEb7+e0XQYYKeplUXgb/mrHR2FdpztapV5OqbfEJYDmMa
         qFpSFbEHL8azw==
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
Subject: [net-next 05/15] net/mlx5: LAG, change mlx5_shared_fdb_supported() to static
Date:   Tue,  6 Jun 2023 00:12:09 -0700
Message-Id: <20230606071219.483255-6-saeed@kernel.org>
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

