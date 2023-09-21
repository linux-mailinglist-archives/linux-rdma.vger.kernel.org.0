Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0F67A97A5
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Sep 2023 19:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjIUR0j (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Sep 2023 13:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjIUR0g (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Sep 2023 13:26:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2299E1728
        for <linux-rdma@vger.kernel.org>; Thu, 21 Sep 2023 10:02:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED6E5C4E665;
        Thu, 21 Sep 2023 12:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695298253;
        bh=2ZG6vMAgy7CqLO7hZ/8C6A42aJwyr6guU+ay4vXAL9k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pzW5scJedeMsydpT2yAi3ouSzuMTwxXdm0FzXPX0JKDztbGTdb+SOARb/R8pkBxvD
         lstUPZ2VdbYuK7P3II68UDZyl1Ae8vzrFymgcbbtDYRkLY6n5xW03IQFwc6dTi0vP+
         KmI8wl5Z1kPohFoYzIe+UhSTm2Dol1knCKrUFCJXFvqoFxucWQXDkSfypFS94VBfTm
         pYAOfa+82lG3hRN5dnXEyBM+2ECsdKBuHiB9pps4sQxkot9WcD3vXtjj4aAc+1yyXi
         a7m7zA72bC1yihPbT+JjjAy4yLpySaxPNgRjkiGF3xa/Lb87/KkZDBZDDBKN3mPPlH
         EES7iVWVU6x3g==
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
Subject: [PATCH mlx5-next 2/9] net/mlx5: Register mlx5e priv to devcom in MPV mode
Date:   Thu, 21 Sep 2023 15:10:28 +0300
Message-ID: <279adfa0aa3a1957a339086f2c1739a50b8e4b68.1695296682.git.leon@kernel.org>
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

If the device is in MPV mode, the ethernet driver would now register
to events from IB driver about core devices affiliation or
de-affiliation.

Use the key provided in said event to connect each mlx5e priv
instance to it's master counterpart, this way the ethernet driver
is now aware of who is his master core device and even more, such
as knowing if partner device has IPsec configured or not.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  1 +
 .../mellanox/mlx5/core/en_accel/ipsec.h       |  2 +
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 39 +++++++++++++++++++
 .../ethernet/mellanox/mlx5/core/lib/devcom.h  |  1 +
 4 files changed, 43 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 86f2690c5e01..44785a209466 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -936,6 +936,7 @@ struct mlx5e_priv {
 	struct mlx5e_htb          *htb;
 	struct mlx5e_mqprio_rl    *mqprio_rl;
 	struct dentry             *dfs_root;
+	struct mlx5_devcom_comp_dev *devcom;
 };
 
 struct mlx5e_dev {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
index 9e7c42c2f77b..06743156ffca 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
@@ -42,6 +42,8 @@
 #define MLX5E_IPSEC_SADB_RX_BITS 10
 #define MLX5E_IPSEC_ESN_SCOPE_MID 0x80000000L
 
+#define MPV_DEVCOM_MASTER_UP 1
+
 struct aes_gcm_keymat {
 	u64   seq_iv;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index a2ae791538ed..f8054da590c9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -69,6 +69,7 @@
 #include "en/htb.h"
 #include "qos.h"
 #include "en/trap.h"
+#include "lib/devcom.h"
 
 bool mlx5e_check_fragmented_striding_rq_cap(struct mlx5_core_dev *mdev, u8 page_shift,
 					    enum mlx5e_mpwrq_umr_mode umr_mode)
@@ -178,6 +179,37 @@ static void mlx5e_disable_async_events(struct mlx5e_priv *priv)
 	mlx5_notifier_unregister(priv->mdev, &priv->events_nb);
 }
 
+static int mlx5e_devcom_event_mpv(int event, void *my_data, void *event_data)
+{
+	struct mlx5e_priv *slave_priv = my_data;
+
+	mlx5_devcom_comp_set_ready(slave_priv->devcom, true);
+
+	return 0;
+}
+
+static int mlx5e_devcom_init_mpv(struct mlx5e_priv *priv, u64 *data)
+{
+	priv->devcom = mlx5_devcom_register_component(priv->mdev->priv.devc,
+						      MLX5_DEVCOM_MPV,
+						      *data,
+						      mlx5e_devcom_event_mpv,
+						      priv);
+	if (IS_ERR_OR_NULL(priv->devcom))
+		return -EOPNOTSUPP;
+
+	if (mlx5_core_is_mp_master(priv->mdev))
+		mlx5_devcom_send_event(priv->devcom, MPV_DEVCOM_MASTER_UP,
+				       MPV_DEVCOM_MASTER_UP, priv);
+
+	return 0;
+}
+
+static void mlx5e_devcom_cleanup_mpv(struct mlx5e_priv *priv)
+{
+	mlx5_devcom_unregister_component(priv->devcom);
+}
+
 static int blocking_event(struct notifier_block *nb, unsigned long event, void *data)
 {
 	struct mlx5e_priv *priv = container_of(nb, struct mlx5e_priv, blocking_events_nb);
@@ -192,6 +224,13 @@ static int blocking_event(struct notifier_block *nb, unsigned long event, void *
 			return NOTIFY_BAD;
 		}
 		break;
+	case MLX5_DRIVER_EVENT_AFFILIATION_DONE:
+		if (mlx5e_devcom_init_mpv(priv, data))
+			return NOTIFY_BAD;
+		break;
+	case MLX5_DRIVER_EVENT_AFFILIATION_REMOVED:
+		mlx5e_devcom_cleanup_mpv(priv);
+		break;
 	default:
 		return NOTIFY_DONE;
 	}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h
index 8389ac0af708..8220d180e33c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h
@@ -8,6 +8,7 @@
 
 enum mlx5_devcom_component {
 	MLX5_DEVCOM_ESW_OFFLOADS,
+	MLX5_DEVCOM_MPV,
 	MLX5_DEVCOM_NUM_COMPONENTS,
 };
 
-- 
2.41.0

