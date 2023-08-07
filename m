Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0EFE771E74
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Aug 2023 12:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbjHGKom (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Aug 2023 06:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbjHGKok (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Aug 2023 06:44:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2429A1703
        for <linux-rdma@vger.kernel.org>; Mon,  7 Aug 2023 03:44:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74348617AD
        for <linux-rdma@vger.kernel.org>; Mon,  7 Aug 2023 10:44:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5755BC433CC;
        Mon,  7 Aug 2023 10:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691405077;
        bh=FQpnXBy3lpmnpp/A+mHfD0R/otAhVk9p/iMKoBiQYZs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uThEFBFDa/VaG+jbTJ9SooX66CCXOgwFDg+LFOWEGom9yWlgV86tNSPzbPmDtK0f7
         52FwPjoPA8olONAJsWq0+RFkoORjoPmnb972ThXd/O9scN7usq4pRQ2FvC522ceBh3
         NqmzO1pm7xmpX0DwJbH4wWOd4tUdIqPICMf8mSEmhF37ULcDqyQontDmm8sV2riYO/
         VF7gHMJWwcAh50jts2VNDAHtx1jVjEG+d/ALf+zCOxaq1dTUcKCXkTvONvSJPwSKYR
         koXR8nLComUp88A81hmo/R8nywzASklMQRxdGcVTfnozqeMQ0hvRYbJ9icVdLuNn9N
         9mgDHiRvX18jQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>, Jakub Kicinski <kuba@kernel.org>
Cc:     Patrisious Haddad <phaddad@nvidia.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>,
        Mark Zhang <markzhang@nvidia.com>, netdev@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>, Raed Salem <raeds@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH mlx5-next 03/14] net/mlx5: Remove dependency of macsec flow steering on ethernet
Date:   Mon,  7 Aug 2023 13:44:12 +0300
Message-ID: <1f979fc87a79b116258534a61d08384a54a4fa06.1691403485.git.leon@kernel.org>
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

Since macsec flow steering was moved to core, it should be independent
of all ethernet code and structures hence we remove all ethernet header
includes and redefine ethernet structs internally for macsec_fs usage
where needed.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 .../mellanox/mlx5/core/lib/macsec_fs.c        | 43 +++++++++++++++----
 1 file changed, 34 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c
index 46c0af66d72c..ace6b67f1c97 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c
@@ -6,7 +6,6 @@
 #include <linux/mlx5/qp.h>
 #include <linux/if_vlan.h>
 #include "fs_core.h"
-#include "en/fs.h"
 #include "lib/macsec_fs.h"
 #include "mlx5_core.h"
 
@@ -57,8 +56,14 @@ struct mlx5e_macsec_tx_rule {
 	u32 fs_id;
 };
 
+struct mlx5_macsec_flow_table {
+	int num_groups;
+	struct mlx5_flow_table *t;
+	struct mlx5_flow_group **g;
+};
+
 struct mlx5e_macsec_tables {
-	struct mlx5e_flow_table ft_crypto;
+	struct mlx5_macsec_flow_table ft_crypto;
 	struct mlx5_flow_handle *crypto_miss_rule;
 
 	struct mlx5_flow_table *ft_check;
@@ -103,6 +108,26 @@ struct mlx5e_macsec_fs {
 	struct mlx5e_macsec_rx *rx_fs;
 };
 
+static void macsec_fs_destroy_groups(struct mlx5_macsec_flow_table *ft)
+{
+	int i;
+
+	for (i = ft->num_groups - 1; i >= 0; i--) {
+		if (!IS_ERR_OR_NULL(ft->g[i]))
+			mlx5_destroy_flow_group(ft->g[i]);
+		ft->g[i] = NULL;
+	}
+	ft->num_groups = 0;
+}
+
+static void macsec_fs_destroy_flow_table(struct mlx5_macsec_flow_table *ft)
+{
+	macsec_fs_destroy_groups(ft);
+	kfree(ft->g);
+	mlx5_destroy_flow_table(ft->t);
+	ft->t = NULL;
+}
+
 static void macsec_fs_tx_destroy(struct mlx5e_macsec_fs *macsec_fs)
 {
 	struct mlx5e_macsec_tx *tx_fs = macsec_fs->tx_fs;
@@ -142,10 +167,10 @@ static void macsec_fs_tx_destroy(struct mlx5e_macsec_fs *macsec_fs)
 		tx_tables->crypto_miss_rule = NULL;
 	}
 
-	mlx5e_destroy_flow_table(&tx_tables->ft_crypto);
+	macsec_fs_destroy_flow_table(&tx_tables->ft_crypto);
 }
 
-static int macsec_fs_tx_create_crypto_table_groups(struct mlx5e_flow_table *ft)
+static int macsec_fs_tx_create_crypto_table_groups(struct mlx5_macsec_flow_table *ft)
 {
 	int inlen = MLX5_ST_SZ_BYTES(create_flow_group_in);
 	int mclen = MLX5_ST_SZ_BYTES(fte_match_param);
@@ -245,7 +270,7 @@ static int macsec_fs_tx_create(struct mlx5e_macsec_fs *macsec_fs)
 	struct mlx5_flow_destination dest = {};
 	struct mlx5e_macsec_tables *tx_tables;
 	struct mlx5_flow_act flow_act = {};
-	struct mlx5e_flow_table *ft_crypto;
+	struct mlx5_macsec_flow_table *ft_crypto;
 	struct mlx5_flow_table *flow_table;
 	struct mlx5_flow_group *flow_group;
 	struct mlx5_flow_namespace *ns;
@@ -734,10 +759,10 @@ static void macsec_fs_rx_destroy(struct mlx5e_macsec_fs *macsec_fs)
 		rx_tables->crypto_miss_rule = NULL;
 	}
 
-	mlx5e_destroy_flow_table(&rx_tables->ft_crypto);
+	macsec_fs_destroy_flow_table(&rx_tables->ft_crypto);
 }
 
-static int macsec_fs_rx_create_crypto_table_groups(struct mlx5e_flow_table *ft)
+static int macsec_fs_rx_create_crypto_table_groups(struct mlx5_macsec_flow_table *ft)
 {
 	int inlen = MLX5_ST_SZ_BYTES(create_flow_group_in);
 	int mclen = MLX5_ST_SZ_BYTES(fte_match_param);
@@ -895,10 +920,10 @@ static int macsec_fs_rx_create(struct mlx5e_macsec_fs *macsec_fs)
 	int inlen = MLX5_ST_SZ_BYTES(create_flow_group_in);
 	struct mlx5e_macsec_rx *rx_fs = macsec_fs->rx_fs;
 	struct net_device *netdev = macsec_fs->netdev;
+	struct mlx5_macsec_flow_table *ft_crypto;
 	struct mlx5_flow_table_attr ft_attr = {};
 	struct mlx5_flow_destination dest = {};
 	struct mlx5e_macsec_tables *rx_tables;
-	struct mlx5e_flow_table *ft_crypto;
 	struct mlx5_flow_table *flow_table;
 	struct mlx5_flow_group *flow_group;
 	struct mlx5_flow_act flow_act = {};
@@ -1123,11 +1148,11 @@ macsec_fs_rx_add_rule(struct mlx5e_macsec_fs *macsec_fs,
 	struct net_device *netdev = macsec_fs->netdev;
 	union mlx5e_macsec_rule *macsec_rule = NULL;
 	struct mlx5_modify_hdr *modify_hdr = NULL;
+	struct mlx5_macsec_flow_table *ft_crypto;
 	struct mlx5_flow_destination dest = {};
 	struct mlx5e_macsec_tables *rx_tables;
 	struct mlx5e_macsec_rx_rule *rx_rule;
 	struct mlx5_flow_act flow_act = {};
-	struct mlx5e_flow_table *ft_crypto;
 	struct mlx5_flow_handle *rule;
 	struct mlx5_flow_spec *spec;
 	int err = 0;
-- 
2.41.0

