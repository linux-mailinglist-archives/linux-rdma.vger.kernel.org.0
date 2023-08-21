Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D128782A1A
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Aug 2023 15:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235257AbjHUNMw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Aug 2023 09:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235276AbjHUNMw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Aug 2023 09:12:52 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3318AF4;
        Mon, 21 Aug 2023 06:12:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C679E2208F;
        Mon, 21 Aug 2023 13:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1692623561; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L8x9w82Z8aEgZifrI6JcH/JdzXmZ2Ssp/vWi4NElA70=;
        b=n1H8qcUJSRXtLTkA/2nB77XinOAD+k+L5AslkxzUzb96MHPA+YIdGmU/A0/1tY9Cc732mS
        K/3CwmaTuTbnSNpIIHl7JZkN9kkvaNXrSREZrGa9q++dNgD1gLhkkhriZmbKlQFWHyQT0w
        p+Wq3kkUonZUFTKS/4G0mpV2CJI6tn0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8570513421;
        Mon, 21 Aug 2023 13:12:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MKJ3H8li42QUVgAAMHmgww
        (envelope-from <petr.pavlu@suse.com>); Mon, 21 Aug 2023 13:12:41 +0000
From:   Petr Pavlu <petr.pavlu@suse.com>
To:     tariqt@nvidia.com, yishaih@nvidia.com, leon@kernel.org
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, jgg@ziepe.ca, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Petr Pavlu <petr.pavlu@suse.com>,
        Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCH net-next v3 05/11] mlx4: Get rid of the mlx4_interface.activate callback
Date:   Mon, 21 Aug 2023 15:12:19 +0200
Message-Id: <20230821131225.11290-6-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230821131225.11290-1-petr.pavlu@suse.com>
References: <20230821131225.11290-1-petr.pavlu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The mlx4_interface.activate callback was introduced in commit
79857cd31fe7 ("net/mlx4: Postpone the registration of net_device"). It
dealt with a situation when a netdev notifier received a NETDEV_REGISTER
event for a new net_device created by mlx4_en but the same device was
not yet visible to mlx4_get_protocol_dev(). The callback can be removed
now that mlx4_get_protocol_dev() is gone.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
Tested-by: Leon Romanovsky <leonro@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Acked-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx4/en_main.c | 37 +++++++++-----------
 drivers/net/ethernet/mellanox/mlx4/intf.c    |  2 --
 include/linux/mlx4/driver.h                  |  1 -
 3 files changed, 16 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_main.c b/drivers/net/ethernet/mellanox/mlx4/en_main.c
index 31bf625b8158..39c9befeb638 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_main.c
@@ -259,26 +259,6 @@ static void mlx4_en_remove(struct mlx4_dev *dev, void *endev_ptr)
 	kfree(mdev);
 }
 
-static void mlx4_en_activate(struct mlx4_dev *dev, void *ctx)
-{
-	int i;
-	struct mlx4_en_dev *mdev = ctx;
-
-	/* Create a netdev for each port */
-	mlx4_foreach_port(i, dev, MLX4_PORT_TYPE_ETH) {
-		mlx4_info(mdev, "Activating port:%d\n", i);
-		if (mlx4_en_init_netdev(mdev, i, &mdev->profile.prof[i]))
-			mdev->pndev[i] = NULL;
-	}
-
-	/* register netdev notifier */
-	mdev->netdev_nb.notifier_call = mlx4_en_netdev_event;
-	if (register_netdevice_notifier(&mdev->netdev_nb)) {
-		mdev->netdev_nb.notifier_call = NULL;
-		mlx4_err(mdev, "Failed to create netdev notifier\n");
-	}
-}
-
 static void *mlx4_en_add(struct mlx4_dev *dev)
 {
 	struct mlx4_en_dev *mdev;
@@ -350,6 +330,22 @@ static void *mlx4_en_add(struct mlx4_dev *dev)
 	err = mlx4_register_event_notifier(dev, &mdev->mlx_nb);
 	WARN(err, "failed to register mlx4 event notifier (%d)", err);
 
+	/* Setup ports */
+
+	/* Create a netdev for each port */
+	mlx4_foreach_port(i, dev, MLX4_PORT_TYPE_ETH) {
+		mlx4_info(mdev, "Activating port:%d\n", i);
+		if (mlx4_en_init_netdev(mdev, i, &mdev->profile.prof[i]))
+			mdev->pndev[i] = NULL;
+	}
+
+	/* register netdev notifier */
+	mdev->netdev_nb.notifier_call = mlx4_en_netdev_event;
+	if (register_netdevice_notifier(&mdev->netdev_nb)) {
+		mdev->netdev_nb.notifier_call = NULL;
+		mlx4_err(mdev, "Failed to create netdev notifier\n");
+	}
+
 	return mdev;
 
 err_mr:
@@ -371,7 +367,6 @@ static struct mlx4_interface mlx4_en_interface = {
 	.add		= mlx4_en_add,
 	.remove		= mlx4_en_remove,
 	.protocol	= MLX4_PROT_ETH,
-	.activate	= mlx4_en_activate,
 };
 
 static void mlx4_en_verify_params(void)
diff --git a/drivers/net/ethernet/mellanox/mlx4/intf.c b/drivers/net/ethernet/mellanox/mlx4/intf.c
index fecb63e69607..8cbc1bcdfe77 100644
--- a/drivers/net/ethernet/mellanox/mlx4/intf.c
+++ b/drivers/net/ethernet/mellanox/mlx4/intf.c
@@ -64,8 +64,6 @@ static void mlx4_add_device(struct mlx4_interface *intf, struct mlx4_priv *priv)
 		spin_lock_irq(&priv->ctx_lock);
 		list_add_tail(&dev_ctx->list, &priv->ctx_list);
 		spin_unlock_irq(&priv->ctx_lock);
-		if (intf->activate)
-			intf->activate(&priv->dev, dev_ctx->context);
 	} else
 		kfree(dev_ctx);
 
diff --git a/include/linux/mlx4/driver.h b/include/linux/mlx4/driver.h
index 228da8ed7e75..0f8c9ba4c574 100644
--- a/include/linux/mlx4/driver.h
+++ b/include/linux/mlx4/driver.h
@@ -58,7 +58,6 @@ enum {
 struct mlx4_interface {
 	void *			(*add)	 (struct mlx4_dev *dev);
 	void			(*remove)(struct mlx4_dev *dev, void *context);
-	void			(*activate)(struct mlx4_dev *dev, void *context);
 	struct list_head	list;
 	enum mlx4_protocol	protocol;
 	int			flags;
-- 
2.35.3

