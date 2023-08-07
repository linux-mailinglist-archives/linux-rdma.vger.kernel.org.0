Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54AB8771E7F
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Aug 2023 12:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbjHGKpI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Aug 2023 06:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbjHGKpC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Aug 2023 06:45:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5CA1BCB
        for <linux-rdma@vger.kernel.org>; Mon,  7 Aug 2023 03:44:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA28B6179A
        for <linux-rdma@vger.kernel.org>; Mon,  7 Aug 2023 10:44:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8341EC433AD;
        Mon,  7 Aug 2023 10:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691405089;
        bh=wviFDRXxE4iiWeUwfSvu6S6+Tr7fneStrPSI+4YrZ8c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cBwWIg4WJDJEmMpC4NQRi2pCo1r5DJkfA1uLcvIrQZW705y6Er/J7zSy0LBsz0KE5
         lFNQmlFOu3ZPZGiSS6vubF3pJLOA9Jb+vhUrA3uH1/z/IYCtGKSTMcS5x72f+Ab+g2
         Jk2NGoRG4o5UI/odjIl5uB2z2WR7DaQwsQ2UzD7PkfsN6ZQKLg8AjuVScPMTvjfsG+
         TMgfYWARjaa4yFPQf2Eb4O4DTpvId0UElq0jWyhgXQdhUEvxp2YWbLp5dJYPZsTDU6
         oCPER93xx7eF/ZowN2HnGZ0ameTWh5bDzwgL4tkUFJ76lF6IGSo5rsKKwWUAzhBVTR
         EPSiHFAwjWGiw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>, Jakub Kicinski <kuba@kernel.org>
Cc:     Patrisious Haddad <phaddad@nvidia.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>,
        Mark Zhang <markzhang@nvidia.com>, netdev@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>, Raed Salem <raeds@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH mlx5-next 02/14] net/mlx5e: Move MACsec flow steering operations to be used as core library
Date:   Mon,  7 Aug 2023 13:44:11 +0300
Message-ID: <55c3801810da7280a79d9dc98ad1ba6444c2e7e2.1691403485.git.leon@kernel.org>
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

Move MACsec flow steering operations(macsec_fs) from core/en_accel to
core/lib, this mandates moving MACsec statistics structure from the
general MACsec code header(en_accel/macsec.h) to macsec_fs header to
remove macsec_fs.h dependency over en_accel/macsec.h.

This to lay the ground for RoCE MACsec by moving all the data
that will need to be accessed by both ethernet MACsec and
RoCE MACsec to be shared at core.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/Kconfig   |  2 +-
 .../net/ethernet/mellanox/mlx5/core/Makefile  |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  2 +-
 .../mellanox/mlx5/core/en_accel/en_accel.h    |  4 ++--
 .../mellanox/mlx5/core/en_accel/macsec.c      |  1 -
 .../mellanox/mlx5/core/en_accel/macsec.h      | 22 +++----------------
 .../ethernet/mellanox/mlx5/core/en_stats.c    |  2 +-
 .../mlx5/core/{en_accel => lib}/macsec_fs.c   |  2 +-
 .../mlx5/core/{en_accel => lib}/macsec_fs.h   | 19 ++++++++++++++--
 9 files changed, 27 insertions(+), 29 deletions(-)
 rename drivers/net/ethernet/mellanox/mlx5/core/{en_accel => lib}/macsec_fs.c (99%)
 rename drivers/net/ethernet/mellanox/mlx5/core/{en_accel => lib}/macsec_fs.h (65%)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Kconfig b/drivers/net/ethernet/mellanox/mlx5/core/Kconfig
index bb1d7b039a7e..f3b284db1b5b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/Kconfig
+++ b/drivers/net/ethernet/mellanox/mlx5/core/Kconfig
@@ -139,7 +139,7 @@ config MLX5_CORE_IPOIB
 	help
 	  MLX5 IPoIB offloads & acceleration support.
 
-config MLX5_EN_MACSEC
+config MLX5_MACSEC
 	bool "Connect-X support for MACSec offload"
 	depends on MLX5_CORE_EN
 	depends on MACSEC
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
index 63a2f2bb80a6..7d95950eb903 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
+++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
@@ -98,7 +98,7 @@ mlx5_core-$(CONFIG_MLX5_CORE_IPOIB) += ipoib/ipoib.o ipoib/ethtool.o ipoib/ipoib
 #
 mlx5_core-$(CONFIG_MLX5_FPGA) += fpga/cmd.o fpga/core.o fpga/conn.o fpga/sdk.o
 
-mlx5_core-$(CONFIG_MLX5_EN_MACSEC) += en_accel/macsec.o en_accel/macsec_fs.o \
+mlx5_core-$(CONFIG_MLX5_MACSEC) += en_accel/macsec.o lib/macsec_fs.o \
 				      en_accel/macsec_stats.o
 
 mlx5_core-$(CONFIG_MLX5_EN_IPSEC) += en_accel/ipsec.o en_accel/ipsec_rxtx.o \
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 0f8f70b91485..955fb2428ba0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -917,7 +917,7 @@ struct mlx5e_priv {
 
 	const struct mlx5e_profile *profile;
 	void                      *ppriv;
-#ifdef CONFIG_MLX5_EN_MACSEC
+#ifdef CONFIG_MLX5_MACSEC
 	struct mlx5e_macsec       *macsec;
 #endif
 #ifdef CONFIG_MLX5_EN_IPSEC
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/en_accel.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/en_accel.h
index bac4717548c6..caa34b9c161e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/en_accel.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/en_accel.h
@@ -138,7 +138,7 @@ static inline bool mlx5e_accel_tx_begin(struct net_device *dev,
 	}
 #endif
 
-#ifdef CONFIG_MLX5_EN_MACSEC
+#ifdef CONFIG_MLX5_MACSEC
 	if (unlikely(mlx5e_macsec_skb_is_offload(skb))) {
 		struct mlx5e_priv *priv = netdev_priv(dev);
 
@@ -173,7 +173,7 @@ static inline void mlx5e_accel_tx_eseg(struct mlx5e_priv *priv,
 		mlx5e_ipsec_tx_build_eseg(priv, skb, eseg);
 #endif
 
-#ifdef CONFIG_MLX5_EN_MACSEC
+#ifdef CONFIG_MLX5_MACSEC
 	if (unlikely(mlx5e_macsec_skb_is_offload(skb)))
 		mlx5e_macsec_tx_build_eseg(priv->macsec, skb, eseg);
 #endif
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
index 592b165530ff..b26044efdec6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
@@ -10,7 +10,6 @@
 #include "lib/aso.h"
 #include "lib/crypto.h"
 #include "en_accel/macsec.h"
-#include "en_accel/macsec_fs.h"
 
 #define MLX5_MACSEC_EPN_SCOPE_MID 0x80000000L
 #define MLX5E_MACSEC_ASO_CTX_SZ MLX5_ST_SZ_BYTES(macsec_aso)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.h
index 347380a2cd9c..1f9c4a2723b2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.h
@@ -4,32 +4,16 @@
 #ifndef __MLX5_EN_ACCEL_MACSEC_H__
 #define __MLX5_EN_ACCEL_MACSEC_H__
 
-#ifdef CONFIG_MLX5_EN_MACSEC
+#ifdef CONFIG_MLX5_MACSEC
 
 #include <linux/mlx5/driver.h>
 #include <net/macsec.h>
 #include <net/dst_metadata.h>
-
-/* Bit31 - 30: MACsec marker, Bit15-0: MACsec id */
-#define MLX5_MACEC_RX_FS_ID_MAX USHRT_MAX /* Must be power of two */
-#define MLX5_MACSEC_RX_FS_ID_MASK MLX5_MACEC_RX_FS_ID_MAX
-#define MLX5_MACSEC_METADATA_MARKER(metadata)  ((((metadata) >> 30) & 0x3)  == 0x1)
-#define MLX5_MACSEC_RX_METADAT_HANDLE(metadata)  ((metadata) & MLX5_MACSEC_RX_FS_ID_MASK)
+#include "lib/macsec_fs.h"
 
 struct mlx5e_priv;
 struct mlx5e_macsec;
 
-struct mlx5e_macsec_stats {
-	u64 macsec_rx_pkts;
-	u64 macsec_rx_bytes;
-	u64 macsec_rx_pkts_drop;
-	u64 macsec_rx_bytes_drop;
-	u64 macsec_tx_pkts;
-	u64 macsec_tx_bytes;
-	u64 macsec_tx_pkts_drop;
-	u64 macsec_tx_bytes_drop;
-};
-
 void mlx5e_macsec_build_netdev(struct mlx5e_priv *priv);
 int mlx5e_macsec_init(struct mlx5e_priv *priv);
 void mlx5e_macsec_cleanup(struct mlx5e_priv *priv);
@@ -68,6 +52,6 @@ static inline void mlx5e_macsec_offload_handle_rx_skb(struct net_device *netdev,
 						      struct mlx5_cqe64 *cqe)
 {}
 static inline bool mlx5e_is_macsec_device(const struct mlx5_core_dev *mdev) { return false; }
-#endif  /* CONFIG_MLX5_EN_MACSEC */
+#endif  /* CONFIG_MLX5_MACSEC */
 
 #endif	/* __MLX5_ACCEL_EN_MACSEC_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
index 4d77055abd4b..8d7a5a815162 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
@@ -2490,7 +2490,7 @@ mlx5e_stats_grp_t mlx5e_nic_stats_grps[] = {
 	&MLX5E_STATS_GRP(per_port_buff_congest),
 	&MLX5E_STATS_GRP(ptp),
 	&MLX5E_STATS_GRP(qos),
-#ifdef CONFIG_MLX5_EN_MACSEC
+#ifdef CONFIG_MLX5_MACSEC
 	&MLX5E_STATS_GRP(macsec_hw),
 #endif
 };
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c
similarity index 99%
rename from drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec_fs.c
rename to drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c
index 414e28584881..46c0af66d72c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c
@@ -7,7 +7,7 @@
 #include <linux/if_vlan.h>
 #include "fs_core.h"
 #include "en/fs.h"
-#include "en_accel/macsec_fs.h"
+#include "lib/macsec_fs.h"
 #include "mlx5_core.h"
 
 /* MACsec TX flow steering */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec_fs.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.h
similarity index 65%
rename from drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec_fs.h
rename to drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.h
index b429648d4ee7..b282c0850e16 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec_fs.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.h
@@ -4,9 +4,13 @@
 #ifndef __MLX5_MACSEC_STEERING_H__
 #define __MLX5_MACSEC_STEERING_H__
 
-#ifdef CONFIG_MLX5_EN_MACSEC
+#ifdef CONFIG_MLX5_MACSEC
 
-#include "en_accel/macsec.h"
+/* Bit31 - 30: MACsec marker, Bit15-0: MACsec id */
+#define MLX5_MACEC_RX_FS_ID_MAX USHRT_MAX /* Must be power of two */
+#define MLX5_MACSEC_RX_FS_ID_MASK MLX5_MACEC_RX_FS_ID_MAX
+#define MLX5_MACSEC_METADATA_MARKER(metadata)  ((((metadata) >> 30) & 0x3)  == 0x1)
+#define MLX5_MACSEC_RX_METADAT_HANDLE(metadata)  ((metadata) & MLX5_MACSEC_RX_FS_ID_MASK)
 
 #define MLX5_MACSEC_NUM_OF_SUPPORTED_INTERFACES 16
 
@@ -20,6 +24,17 @@ struct mlx5_macsec_rule_attrs {
 	int action;
 };
 
+struct mlx5e_macsec_stats {
+	u64 macsec_rx_pkts;
+	u64 macsec_rx_bytes;
+	u64 macsec_rx_pkts_drop;
+	u64 macsec_rx_bytes_drop;
+	u64 macsec_tx_pkts;
+	u64 macsec_tx_bytes;
+	u64 macsec_tx_pkts_drop;
+	u64 macsec_tx_bytes_drop;
+};
+
 enum mlx5_macsec_action {
 	MLX5_ACCEL_MACSEC_ACTION_ENCRYPT,
 	MLX5_ACCEL_MACSEC_ACTION_DECRYPT,
-- 
2.41.0

