Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB2A477A71F
	for <lists+linux-rdma@lfdr.de>; Sun, 13 Aug 2023 16:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbjHMOwH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 13 Aug 2023 10:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbjHMOwF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 13 Aug 2023 10:52:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4983D170D;
        Sun, 13 Aug 2023 07:52:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E47B61F8C4;
        Sun, 13 Aug 2023 14:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1691938324; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fI8AvByIo5bSABW0DcgMCL+LN/SUaCF+2Hx1xyjMwgA=;
        b=ZZafM9K7dk//twf52fN2gzsI9DNM8SK8i6xgQrB5k+AwlRpQ6vILuMmikLw59Vvti4/Ak3
        mMmhPSaeKMgGHFPz7IgJG0qXTO7Mrn7uNqh55NFIDZbS0R1DEdEFx2N4JKQyXg61LJQK2h
        wb4/MWcHUbxqQuGrNkQYo7B/WxOQV8o=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B15301322C;
        Sun, 13 Aug 2023 14:52:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wGKPKhTu2GSDFAAAMHmgww
        (envelope-from <petr.pavlu@suse.com>); Sun, 13 Aug 2023 14:52:04 +0000
From:   Petr Pavlu <petr.pavlu@suse.com>
To:     tariqt@nvidia.com, yishaih@nvidia.com, leon@kernel.org
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, jgg@ziepe.ca, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Petr Pavlu <petr.pavlu@suse.com>,
        Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCH net-next v2 04/10] mlx4: Get rid of the mlx4_interface.activate callback
Date:   Sun, 13 Aug 2023 16:51:21 +0200
Message-Id: <20230813145127.10653-5-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230813145127.10653-1-petr.pavlu@suse.com>
References: <20230813145127.10653-1-petr.pavlu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index 77e771e97da0..263f9274927b 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_main.c
@@ -247,26 +247,6 @@ static void mlx4_en_remove(struct mlx4_dev *dev, void *endev_ptr)
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
@@ -338,6 +318,22 @@ static void *mlx4_en_add(struct mlx4_dev *dev)
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
@@ -359,7 +355,6 @@ static struct mlx4_interface mlx4_en_interface = {
 	.add		= mlx4_en_add,
 	.remove		= mlx4_en_remove,
 	.protocol	= MLX4_PROT_ETH,
-	.activate	= mlx4_en_activate,
 };
 
 static void mlx4_en_verify_params(void)
diff --git a/drivers/net/ethernet/mellanox/mlx4/intf.c b/drivers/net/ethernet/mellanox/mlx4/intf.c
index a7c3e2efa464..8b2c1404cb66 100644
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

