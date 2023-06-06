Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF74723889
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Jun 2023 09:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235952AbjFFHNC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Jun 2023 03:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235996AbjFFHMm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Jun 2023 03:12:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C19E69
        for <linux-rdma@vger.kernel.org>; Tue,  6 Jun 2023 00:12:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C92EA62DE4
        for <linux-rdma@vger.kernel.org>; Tue,  6 Jun 2023 07:12:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07739C4339B;
        Tue,  6 Jun 2023 07:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686035560;
        bh=mrByyCHRUD3MFLkEdjFLeU+JfKMp9/Y7nWbhtLMYeb0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y1pOkl43Tfsu3YCyJJ+aj0B0/XqtpwVuNSQ+p2nkl7Ohs7eM+LER8KOZgbBJ/0/x7
         iP8OrRrsBVlZFUFdEnxCePZX0TJKc2Oy8g8b3XhQzCVOk/kFupw2nDIGEXFU2zi/32
         3ZretHyjFHz404Gxygg/qk7CNKofttQ15rDnvrKD+DwWxIp9fYhNY67kG9G3MdU2x7
         GHyxWWib8xeohcVlHasg3Q/psJwYtc+Suo9s+RU+s9FBYEe46gA63y+codsp1DUqCx
         crGVu4Y+Zw0QvP4XqgDuPLm+1/dCVDbCUHcy/LDgS8O+D3LegFHKq+Shn4K766qyLw
         88VA6K7nIBJTg==
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
Subject: [net-next 08/15] net/mlx5: Enable 4 ports VF LAG
Date:   Tue,  6 Jun 2023 00:12:12 -0700
Message-Id: <20230606071219.483255-9-saeed@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230606071219.483255-1-saeed@kernel.org>
References: <20230606071219.483255-1-saeed@kernel.org>
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

Now, after all preparation are done, enable 4 ports VF LAG

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c    | 4 ++--
 drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c | 5 +++--
 drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h | 2 +-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
index 6ce71c42c755..ffd7e17b8ebe 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
@@ -711,7 +711,7 @@ int mlx5_deactivate_lag(struct mlx5_lag *ldev)
 	return 0;
 }
 
-#define MLX5_LAG_OFFLOADS_SUPPORTED_PORTS 2
+#define MLX5_LAG_OFFLOADS_SUPPORTED_PORTS 4
 bool mlx5_lag_check_prereq(struct mlx5_lag *ldev)
 {
 #ifdef CONFIG_MLX5_ESWITCH
@@ -737,7 +737,7 @@ bool mlx5_lag_check_prereq(struct mlx5_lag *ldev)
 		if (mlx5_eswitch_mode(ldev->pf[i].dev) != mode)
 			return false;
 
-	if (mode == MLX5_ESWITCH_OFFLOADS && ldev->ports != MLX5_LAG_OFFLOADS_SUPPORTED_PORTS)
+	if (mode == MLX5_ESWITCH_OFFLOADS && ldev->ports > MLX5_LAG_OFFLOADS_SUPPORTED_PORTS)
 		return false;
 #else
 	for (i = 0; i < ldev->ports; i++)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
index 8472bbb3cd58..78c94b22bdc0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
@@ -75,13 +75,14 @@ struct mlx5_devcom *mlx5_devcom_register_device(struct mlx5_core_dev *dev)
 
 	if (!mlx5_core_is_pf(dev))
 		return NULL;
-	if (MLX5_CAP_GEN(dev, num_lag_ports) != MLX5_DEVCOM_PORTS_SUPPORTED)
+	if (MLX5_CAP_GEN(dev, num_lag_ports) > MLX5_DEVCOM_PORTS_SUPPORTED)
 		return NULL;
 
 	mlx5_dev_list_lock();
 	sguid0 = mlx5_query_nic_system_image_guid(dev);
 	list_for_each_entry(iter, &devcom_list, list) {
-		struct mlx5_core_dev *tmp_dev = NULL;
+		/* There is at least one device in iter */
+		struct mlx5_core_dev *tmp_dev;
 
 		idx = -1;
 		for (i = 0; i < MLX5_DEVCOM_PORTS_SUPPORTED; i++) {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h
index bb1970ba8730..d953a01b8eaa 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h
@@ -6,7 +6,7 @@
 
 #include <linux/mlx5/driver.h>
 
-#define MLX5_DEVCOM_PORTS_SUPPORTED 2
+#define MLX5_DEVCOM_PORTS_SUPPORTED 4
 
 enum mlx5_devcom_components {
 	MLX5_DEVCOM_ESW_OFFLOADS,
-- 
2.40.1

