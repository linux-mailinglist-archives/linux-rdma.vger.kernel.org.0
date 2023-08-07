Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A4A771EA5
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Aug 2023 12:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjHGKqG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Aug 2023 06:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbjHGKqD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Aug 2023 06:46:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B911721
        for <linux-rdma@vger.kernel.org>; Mon,  7 Aug 2023 03:45:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1AB28617B3
        for <linux-rdma@vger.kernel.org>; Mon,  7 Aug 2023 10:45:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0726FC433D9;
        Mon,  7 Aug 2023 10:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691405116;
        bh=LRSwFv4pI3XWzbDZ/J9hIlPITjq11MH8a2xZRUVhncI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CA/1EInu+mLbbq7SoCMaipbN1R1dcxnEaJ4UsJY0GunMyRWqxAvp7JpgrFEneryUx
         IrEpD7+e+YXiB49OhFPkFD6f1dOCTPfqCx4eEKNcL1WGI+pOewpTF2Ha37r8xSNxEA
         ks8YR1X3OyT6hRTj8vwTJ2d9xSyQdXioFX5rmLMOvPqT8/mMayg242tTrBY7CyAwxA
         PrVNRdrbvFyaEMNlSnuwHqzndijDOtqubXREmfdUhG3CgNB6zj/12vqOE41grNmlnr
         jTR3REknfS1SbwwVyOrFlf/RwOdARyHipeT2/8H5tJb8D47uXIW71I8dnlAvDqMwh9
         qiE9JyMQPbFkA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>, Jakub Kicinski <kuba@kernel.org>
Cc:     Patrisious Haddad <phaddad@nvidia.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>,
        Mark Zhang <markzhang@nvidia.com>, netdev@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>, Raed Salem <raeds@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH mlx5-next 09/14] net/mlx5: Configure MACsec steering for egress RoCEv2 traffic
Date:   Mon,  7 Aug 2023 13:44:18 +0300
Message-ID: <4e114bd19fe2cd8732c0efffa2f0f90d1dc5ec44.1691403485.git.leon@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1691403485.git.leon@kernel.org>
References: <cover.1691403485.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Patrisious Haddad <phaddad@nvidia.com>

Add steering table in RDMA_TX domain, to forward MACsec traffic
to MACsec crypto table in NIC domain.
The tables are created in a lazy manner when the first TX SA is
being created, and destroyed upon the destruction of the last SA.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 .../mellanox/mlx5/core/lib/macsec_fs.c        | 46 ++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c
index d39ca7c66542..15e7ea3ed79f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c
@@ -95,6 +95,8 @@ struct mlx5_macsec_tx {
 	struct ida tx_halloc;
 
 	struct mlx5_macsec_tables tables;
+
+	struct mlx5_flow_table *ft_rdma_tx;
 };
 
 struct mlx5_macsec_rx_rule {
@@ -173,6 +175,9 @@ static void macsec_fs_tx_destroy(struct mlx5_macsec_fs *macsec_fs)
 	struct mlx5_macsec_tx *tx_fs = macsec_fs->tx_fs;
 	struct mlx5_macsec_tables *tx_tables;
 
+	if (mlx5_is_macsec_roce_supported(macsec_fs->mdev))
+		mlx5_destroy_flow_table(tx_fs->ft_rdma_tx);
+
 	tx_tables = &tx_fs->tables;
 
 	/* Tx check table */
@@ -301,6 +306,39 @@ static struct mlx5_flow_table
 	return fdb;
 }
 
+enum {
+	RDMA_TX_MACSEC_LEVEL = 0,
+};
+
+static int macsec_fs_tx_roce_create(struct mlx5_macsec_fs *macsec_fs)
+{
+	struct mlx5_macsec_tx *tx_fs = macsec_fs->tx_fs;
+	struct mlx5_core_dev *mdev = macsec_fs->mdev;
+	struct mlx5_flow_namespace *ns;
+	struct mlx5_flow_table *ft;
+	int err;
+
+	if (!mlx5_is_macsec_roce_supported(mdev)) {
+		mlx5_core_dbg(mdev, "Failed to init RoCE MACsec, capabilities not supported\n");
+		return 0;
+	}
+
+	ns = mlx5_get_flow_namespace(mdev, MLX5_FLOW_NAMESPACE_RDMA_TX_MACSEC);
+	if (!ns)
+		return -ENOMEM;
+
+	/* Tx RoCE crypto table  */
+	ft = macsec_fs_auto_group_table_create(ns, 0, RDMA_TX_MACSEC_LEVEL, CRYPTO_NUM_MAXSEC_FTE);
+	if (IS_ERR(ft)) {
+		err = PTR_ERR(ft);
+		mlx5_core_err(mdev, "Failed to create MACsec RoCE Tx crypto table err(%d)\n", err);
+		return err;
+	}
+	tx_fs->ft_rdma_tx = ft;
+
+	return 0;
+}
+
 static int macsec_fs_tx_create(struct mlx5_macsec_fs *macsec_fs)
 {
 	int inlen = MLX5_ST_SZ_BYTES(create_flow_group_in);
@@ -443,7 +481,13 @@ static int macsec_fs_tx_create(struct mlx5_macsec_fs *macsec_fs)
 	}
 	tx_fs->check_rule = rule;
 
-	goto out_flow_group;
+	err = macsec_fs_tx_roce_create(macsec_fs);
+	if (err)
+		goto err;
+
+	kvfree(flow_group_in);
+	kvfree(spec);
+	return 0;
 
 err:
 	macsec_fs_tx_destroy(macsec_fs);
-- 
2.41.0

