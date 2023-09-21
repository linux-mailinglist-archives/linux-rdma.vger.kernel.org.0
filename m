Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C0C7A9670
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Sep 2023 19:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjIURCi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Sep 2023 13:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjIURCH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Sep 2023 13:02:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8AB1BFA
        for <linux-rdma@vger.kernel.org>; Thu, 21 Sep 2023 10:01:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44D75C4E668;
        Thu, 21 Sep 2023 12:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695298267;
        bh=5s0TNHVNIGX2PdXzgRwpxXcV3ee6qY167sWDIzLvnns=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CIGPj46LOZjOK8oEq1JbX+YF7C1ZsALj0lAaQTeAQS7N2vEKnoTU195tve58jAcPx
         C8cx4FWt3zPBdLSdOoQVjJbbT4t0sOZKfkmzzGdlW0CKus8WKbL5IGi4C4Iyu6o+8c
         Vn81MCCwRZBJJKwvz48An+jUPCVuzTM3AlA8V4BLqPlz93LBjVdEv+16RHPnq2IjB+
         dq3FrOOlzZhrk2vyxunaQkDwW6t3aiaTtRbqF+fFt91wIQ87SZWNwQHRRLW4lV6RT9
         fHltTYQuhnJFDQSlif+sIPVDK0m/afIlA6uvv5qYt2bs+8ABV3CleHdxy3VpAEtvbA
         9t/oXmWN2nxfA==
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
Subject: [PATCH mlx5-next 3/9] net/mlx5: Store devcom pointer inside IPsec RoCE
Date:   Thu, 21 Sep 2023 15:10:29 +0300
Message-ID: <5bb3160ceeb07523542302886da54c78eef0d2af.1695296682.git.leon@kernel.org>
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

Store the mlx5e priv devcom component within IPsec RoCE to enable
the IPsec RoCE code to access the other device's private information.
This includes retrieving the necessary device information and
the IPsec database, which helps determine if IPsec is configured or not.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c    | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h    | 3 ++-
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c | 5 +++--
 drivers/net/ethernet/mellanox/mlx5/core/lib/ipsec_fs_roce.c | 6 +++++-
 drivers/net/ethernet/mellanox/mlx5/core/lib/ipsec_fs_roce.h | 5 ++++-
 5 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
index 7d4ceb9b9c16..49354bc036ad 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
@@ -870,7 +870,7 @@ void mlx5e_ipsec_init(struct mlx5e_priv *priv)
 	}
 
 	ipsec->is_uplink_rep = mlx5e_is_uplink_rep(priv);
-	ret = mlx5e_accel_ipsec_fs_init(ipsec);
+	ret = mlx5e_accel_ipsec_fs_init(ipsec, &priv->devcom);
 	if (ret)
 		goto err_fs_init;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
index 06743156ffca..dc8e539dc20e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
@@ -38,6 +38,7 @@
 #include <net/xfrm.h>
 #include <linux/idr.h>
 #include "lib/aso.h"
+#include "lib/devcom.h"
 
 #define MLX5E_IPSEC_SADB_RX_BITS 10
 #define MLX5E_IPSEC_ESN_SCOPE_MID 0x80000000L
@@ -304,7 +305,7 @@ void mlx5e_ipsec_cleanup(struct mlx5e_priv *priv);
 void mlx5e_ipsec_build_netdev(struct mlx5e_priv *priv);
 
 void mlx5e_accel_ipsec_fs_cleanup(struct mlx5e_ipsec *ipsec);
-int mlx5e_accel_ipsec_fs_init(struct mlx5e_ipsec *ipsec);
+int mlx5e_accel_ipsec_fs_init(struct mlx5e_ipsec *ipsec, struct mlx5_devcom_comp_dev **devcom);
 int mlx5e_accel_ipsec_fs_add_rule(struct mlx5e_ipsec_sa_entry *sa_entry);
 void mlx5e_accel_ipsec_fs_del_rule(struct mlx5e_ipsec_sa_entry *sa_entry);
 int mlx5e_accel_ipsec_fs_add_pol(struct mlx5e_ipsec_pol_entry *pol_entry);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
index 7dba4221993f..4315e4f3d6cd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
@@ -1888,7 +1888,8 @@ void mlx5e_accel_ipsec_fs_cleanup(struct mlx5e_ipsec *ipsec)
 	}
 }
 
-int mlx5e_accel_ipsec_fs_init(struct mlx5e_ipsec *ipsec)
+int mlx5e_accel_ipsec_fs_init(struct mlx5e_ipsec *ipsec,
+			      struct mlx5_devcom_comp_dev **devcom)
 {
 	struct mlx5_core_dev *mdev = ipsec->mdev;
 	struct mlx5_flow_namespace *ns, *ns_esw;
@@ -1940,7 +1941,7 @@ int mlx5e_accel_ipsec_fs_init(struct mlx5e_ipsec *ipsec)
 		ipsec->tx_esw->ns = ns_esw;
 		xa_init_flags(&ipsec->rx_esw->ipsec_obj_id_map, XA_FLAGS_ALLOC1);
 	} else if (mlx5_ipsec_device_caps(mdev) & MLX5_IPSEC_CAP_ROCE) {
-		ipsec->roce = mlx5_ipsec_fs_roce_init(mdev);
+		ipsec->roce = mlx5_ipsec_fs_roce_init(mdev, devcom);
 	}
 
 	return 0;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/ipsec_fs_roce.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/ipsec_fs_roce.c
index 6e3f178d6f84..6176680c470c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/ipsec_fs_roce.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/ipsec_fs_roce.c
@@ -31,6 +31,7 @@ struct mlx5_ipsec_fs {
 	struct mlx5_ipsec_rx_roce ipv4_rx;
 	struct mlx5_ipsec_rx_roce ipv6_rx;
 	struct mlx5_ipsec_tx_roce tx;
+	struct mlx5_devcom_comp_dev **devcom;
 };
 
 static void ipsec_fs_roce_setup_udp_dport(struct mlx5_flow_spec *spec,
@@ -337,7 +338,8 @@ void mlx5_ipsec_fs_roce_cleanup(struct mlx5_ipsec_fs *ipsec_roce)
 	kfree(ipsec_roce);
 }
 
-struct mlx5_ipsec_fs *mlx5_ipsec_fs_roce_init(struct mlx5_core_dev *mdev)
+struct mlx5_ipsec_fs *mlx5_ipsec_fs_roce_init(struct mlx5_core_dev *mdev,
+					      struct mlx5_devcom_comp_dev **devcom)
 {
 	struct mlx5_ipsec_fs *roce_ipsec;
 	struct mlx5_flow_namespace *ns;
@@ -363,6 +365,8 @@ struct mlx5_ipsec_fs *mlx5_ipsec_fs_roce_init(struct mlx5_core_dev *mdev)
 
 	roce_ipsec->tx.ns = ns;
 
+	roce_ipsec->devcom = devcom;
+
 	return roce_ipsec;
 
 err_tx:
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/ipsec_fs_roce.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/ipsec_fs_roce.h
index 9712d705fe48..75475e126181 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/ipsec_fs_roce.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/ipsec_fs_roce.h
@@ -4,6 +4,8 @@
 #ifndef __MLX5_LIB_IPSEC_H__
 #define __MLX5_LIB_IPSEC_H__
 
+#include "lib/devcom.h"
+
 struct mlx5_ipsec_fs;
 
 struct mlx5_flow_table *
@@ -20,6 +22,7 @@ int mlx5_ipsec_fs_roce_tx_create(struct mlx5_core_dev *mdev,
 				 struct mlx5_ipsec_fs *ipsec_roce,
 				 struct mlx5_flow_table *pol_ft);
 void mlx5_ipsec_fs_roce_cleanup(struct mlx5_ipsec_fs *ipsec_roce);
-struct mlx5_ipsec_fs *mlx5_ipsec_fs_roce_init(struct mlx5_core_dev *mdev);
+struct mlx5_ipsec_fs *mlx5_ipsec_fs_roce_init(struct mlx5_core_dev *mdev,
+					      struct mlx5_devcom_comp_dev **devcom);
 
 #endif /* __MLX5_LIB_IPSEC_H__ */
-- 
2.41.0

