Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD8677A711
	for <lists+linux-rdma@lfdr.de>; Sun, 13 Aug 2023 16:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbjHMOwL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 13 Aug 2023 10:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbjHMOwH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 13 Aug 2023 10:52:07 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC08A1704;
        Sun, 13 Aug 2023 07:52:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5C5FB1F8CC;
        Sun, 13 Aug 2023 14:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1691938326; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SOXs92XpDZ2m8VCK5Qf/JTvBeaJd0cZxFhhssMI3N5Y=;
        b=Qq8EvmW2arMIp3J0zjij8yFcTZJbSFYWK8Ip6xMkr5/A+t8T57epyqGqZjcQqV4Cn6hXzI
        qd80Wc4FGQ2D8S3bwpzhVSXU4kX6mNspizZ8WnnmyKwTSoyvkJGIHd2AfWRMjciMeLLQWc
        JYlV9kHtmhShmGUJ/6/Sve6M2GXOGiE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 263DD1322C;
        Sun, 13 Aug 2023 14:52:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OO2aCBbu2GSDFAAAMHmgww
        (envelope-from <petr.pavlu@suse.com>); Sun, 13 Aug 2023 14:52:06 +0000
From:   Petr Pavlu <petr.pavlu@suse.com>
To:     tariqt@nvidia.com, yishaih@nvidia.com, leon@kernel.org
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, jgg@ziepe.ca, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Petr Pavlu <petr.pavlu@suse.com>,
        Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCH net-next v2 10/10] mlx4: Delete custom device management logic
Date:   Sun, 13 Aug 2023 16:51:27 +0200
Message-Id: <20230813145127.10653-11-petr.pavlu@suse.com>
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

After the conversion to use the auxiliary bus, the custom device
management is not needed anymore and can be deleted.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
Tested-by: Leon Romanovsky <leonro@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Acked-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx4/intf.c | 125 ----------------------
 drivers/net/ethernet/mellanox/mlx4/main.c |  28 -----
 drivers/net/ethernet/mellanox/mlx4/mlx4.h |   3 -
 include/linux/mlx4/driver.h               |  10 --
 4 files changed, 166 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/intf.c b/drivers/net/ethernet/mellanox/mlx4/intf.c
index 16b2c99ff737..c7697ee0dd05 100644
--- a/drivers/net/ethernet/mellanox/mlx4/intf.c
+++ b/drivers/net/ethernet/mellanox/mlx4/intf.c
@@ -38,15 +38,6 @@
 
 #include "mlx4.h"
 
-struct mlx4_device_context {
-	struct list_head	list;
-	struct list_head	bond_list;
-	struct mlx4_interface  *intf;
-	void		       *context;
-};
-
-static LIST_HEAD(intf_list);
-static LIST_HEAD(dev_list);
 static DEFINE_MUTEX(intf_mutex);
 static DEFINE_IDA(mlx4_adev_ida);
 
@@ -156,77 +147,6 @@ static void del_adev(struct auxiliary_device *adev)
 	auxiliary_device_uninit(adev);
 }
 
-static void mlx4_add_device(struct mlx4_interface *intf, struct mlx4_priv *priv)
-{
-	struct mlx4_device_context *dev_ctx;
-
-	dev_ctx = kmalloc(sizeof(*dev_ctx), GFP_KERNEL);
-	if (!dev_ctx)
-		return;
-
-	dev_ctx->intf    = intf;
-	dev_ctx->context = intf->add(&priv->dev);
-
-	if (dev_ctx->context) {
-		spin_lock_irq(&priv->ctx_lock);
-		list_add_tail(&dev_ctx->list, &priv->ctx_list);
-		spin_unlock_irq(&priv->ctx_lock);
-	} else
-		kfree(dev_ctx);
-
-}
-
-static void mlx4_remove_device(struct mlx4_interface *intf, struct mlx4_priv *priv)
-{
-	struct mlx4_device_context *dev_ctx;
-
-	list_for_each_entry(dev_ctx, &priv->ctx_list, list)
-		if (dev_ctx->intf == intf) {
-			spin_lock_irq(&priv->ctx_lock);
-			list_del(&dev_ctx->list);
-			spin_unlock_irq(&priv->ctx_lock);
-
-			intf->remove(&priv->dev, dev_ctx->context);
-			kfree(dev_ctx);
-			return;
-		}
-}
-
-int mlx4_register_interface(struct mlx4_interface *intf)
-{
-	struct mlx4_priv *priv;
-
-	if (!intf->add || !intf->remove)
-		return -EINVAL;
-
-	mutex_lock(&intf_mutex);
-
-	list_add_tail(&intf->list, &intf_list);
-	list_for_each_entry(priv, &dev_list, dev_list) {
-		mlx4_add_device(intf, priv);
-	}
-
-	mutex_unlock(&intf_mutex);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(mlx4_register_interface);
-
-void mlx4_unregister_interface(struct mlx4_interface *intf)
-{
-	struct mlx4_priv *priv;
-
-	mutex_lock(&intf_mutex);
-
-	list_for_each_entry(priv, &dev_list, dev_list)
-		mlx4_remove_device(intf, priv);
-
-	list_del(&intf->list);
-
-	mutex_unlock(&intf_mutex);
-}
-EXPORT_SYMBOL_GPL(mlx4_unregister_interface);
-
 int mlx4_register_auxiliary_driver(struct mlx4_adrv *madrv)
 {
 	return auxiliary_driver_register(&madrv->adrv);
@@ -242,10 +162,7 @@ EXPORT_SYMBOL_GPL(mlx4_unregister_auxiliary_driver);
 int mlx4_do_bond(struct mlx4_dev *dev, bool enable)
 {
 	struct mlx4_priv *priv = mlx4_priv(dev);
-	struct mlx4_device_context *dev_ctx = NULL, *temp_dev_ctx;
-	unsigned long flags;
 	int i, ret;
-	LIST_HEAD(bond_list);
 
 	if (!(dev->caps.flags2 & MLX4_DEV_CAP_FLAG2_PORT_REMAP))
 		return -EOPNOTSUPP;
@@ -267,36 +184,6 @@ int mlx4_do_bond(struct mlx4_dev *dev, bool enable)
 		dev->flags &= ~MLX4_FLAG_BONDED;
 	}
 
-	spin_lock_irqsave(&priv->ctx_lock, flags);
-	list_for_each_entry_safe(dev_ctx, temp_dev_ctx, &priv->ctx_list, list) {
-		if (!(dev_ctx->intf->flags & MLX4_INTFF_BONDING))
-			continue;
-
-		if (mlx4_is_mfunc(dev)) {
-			mlx4_dbg(dev,
-				 "SRIOV, disabled HA mode for intf proto %d\n",
-				 dev_ctx->intf->protocol);
-			continue;
-		}
-
-		list_add_tail(&dev_ctx->bond_list, &bond_list);
-		list_del(&dev_ctx->list);
-	}
-	spin_unlock_irqrestore(&priv->ctx_lock, flags);
-
-	list_for_each_entry(dev_ctx, &bond_list, bond_list) {
-		dev_ctx->intf->remove(dev, dev_ctx->context);
-		dev_ctx->context =  dev_ctx->intf->add(dev);
-
-		spin_lock_irqsave(&priv->ctx_lock, flags);
-		list_add_tail(&dev_ctx->list, &priv->ctx_list);
-		spin_unlock_irqrestore(&priv->ctx_lock, flags);
-
-		mlx4_dbg(dev, "Interface for protocol %d restarted with bonded mode %s\n",
-			 dev_ctx->intf->protocol, enable ?
-			 "enabled" : "disabled");
-	}
-
 	mutex_lock(&intf_mutex);
 
 	for (i = 0; i < ARRAY_SIZE(mlx4_adev_devices); i++) {
@@ -447,16 +334,11 @@ static int rescan_drivers_locked(struct mlx4_dev *dev)
 
 int mlx4_register_device(struct mlx4_dev *dev)
 {
-	struct mlx4_priv *priv = mlx4_priv(dev);
-	struct mlx4_interface *intf;
 	int ret;
 
 	mutex_lock(&intf_mutex);
 
 	dev->persist->interface_state |= MLX4_INTERFACE_STATE_UP;
-	list_add_tail(&priv->dev_list, &dev_list);
-	list_for_each_entry(intf, &intf_list, list)
-		mlx4_add_device(intf, priv);
 
 	ret = rescan_drivers_locked(dev);
 
@@ -474,9 +356,6 @@ int mlx4_register_device(struct mlx4_dev *dev)
 
 void mlx4_unregister_device(struct mlx4_dev *dev)
 {
-	struct mlx4_priv *priv = mlx4_priv(dev);
-	struct mlx4_interface *intf;
-
 	if (!(dev->persist->interface_state & MLX4_INTERFACE_STATE_UP))
 		return;
 
@@ -495,10 +374,6 @@ void mlx4_unregister_device(struct mlx4_dev *dev)
 	}
 	mutex_lock(&intf_mutex);
 
-	list_for_each_entry(intf, &intf_list, list)
-		mlx4_remove_device(intf, priv);
-
-	list_del(&priv->dev_list);
 	dev->persist->interface_state &= ~MLX4_INTERFACE_STATE_UP;
 
 	rescan_drivers_locked(dev);
diff --git a/drivers/net/ethernet/mellanox/mlx4/main.c b/drivers/net/ethernet/mellanox/mlx4/main.c
index c4ec7377aa71..2581226836b5 100644
--- a/drivers/net/ethernet/mellanox/mlx4/main.c
+++ b/drivers/net/ethernet/mellanox/mlx4/main.c
@@ -42,7 +42,6 @@
 #include <linux/slab.h>
 #include <linux/io-mapping.h>
 #include <linux/delay.h>
-#include <linux/kmod.h>
 #include <linux/etherdevice.h>
 #include <net/devlink.h>
 
@@ -1091,27 +1090,6 @@ static int mlx4_slave_cap(struct mlx4_dev *dev)
 	return err;
 }
 
-static void mlx4_request_modules(struct mlx4_dev *dev)
-{
-	int port;
-	int has_ib_port = false;
-	int has_eth_port = false;
-#define EN_DRV_NAME	"mlx4_en"
-#define IB_DRV_NAME	"mlx4_ib"
-
-	for (port = 1; port <= dev->caps.num_ports; port++) {
-		if (dev->caps.port_type[port] == MLX4_PORT_TYPE_IB)
-			has_ib_port = true;
-		else if (dev->caps.port_type[port] == MLX4_PORT_TYPE_ETH)
-			has_eth_port = true;
-	}
-
-	if (has_eth_port)
-		request_module_nowait(EN_DRV_NAME);
-	if (has_ib_port || (dev->caps.flags & MLX4_DEV_CAP_FLAG_IBOE))
-		request_module_nowait(IB_DRV_NAME);
-}
-
 /*
  * Change the port configuration of the device.
  * Every user of this function must hold the port mutex.
@@ -1147,7 +1125,6 @@ int mlx4_change_port_types(struct mlx4_dev *dev,
 			mlx4_err(dev, "Failed to register device\n");
 			goto out;
 		}
-		mlx4_request_modules(dev);
 	}
 
 out:
@@ -3426,9 +3403,6 @@ static int mlx4_load_one(struct pci_dev *pdev, int pci_dev_data,
 	devl_assert_locked(devlink);
 	dev = &priv->dev;
 
-	INIT_LIST_HEAD(&priv->ctx_list);
-	spin_lock_init(&priv->ctx_lock);
-
 	err = mlx4_adev_init(dev);
 	if (err)
 		return err;
@@ -3732,8 +3706,6 @@ static int mlx4_load_one(struct pci_dev *pdev, int pci_dev_data,
 	if (err)
 		goto err_port;
 
-	mlx4_request_modules(dev);
-
 	mlx4_sense_init(dev);
 	mlx4_start_sense(dev);
 
diff --git a/drivers/net/ethernet/mellanox/mlx4/mlx4.h b/drivers/net/ethernet/mellanox/mlx4/mlx4.h
index d5050bfb342f..d707b790536f 100644
--- a/drivers/net/ethernet/mellanox/mlx4/mlx4.h
+++ b/drivers/net/ethernet/mellanox/mlx4/mlx4.h
@@ -882,9 +882,6 @@ enum {
 struct mlx4_priv {
 	struct mlx4_dev		dev;
 
-	struct list_head	dev_list;
-	struct list_head	ctx_list;
-	spinlock_t		ctx_lock;
 	struct mlx4_adev	**adev;
 	int			adev_idx;
 	struct atomic_notifier_head event_nh;
diff --git a/include/linux/mlx4/driver.h b/include/linux/mlx4/driver.h
index 9cf157d381c6..69825223081f 100644
--- a/include/linux/mlx4/driver.h
+++ b/include/linux/mlx4/driver.h
@@ -58,22 +58,12 @@ enum {
 	MLX4_INTFF_BONDING	= 1 << 0
 };
 
-struct mlx4_interface {
-	void *			(*add)	 (struct mlx4_dev *dev);
-	void			(*remove)(struct mlx4_dev *dev, void *context);
-	struct list_head	list;
-	enum mlx4_protocol	protocol;
-	int			flags;
-};
-
 struct mlx4_adrv {
 	struct auxiliary_driver	adrv;
 	enum mlx4_protocol	protocol;
 	int			flags;
 };
 
-int mlx4_register_interface(struct mlx4_interface *intf);
-void mlx4_unregister_interface(struct mlx4_interface *intf);
 int mlx4_register_auxiliary_driver(struct mlx4_adrv *madrv);
 void mlx4_unregister_auxiliary_driver(struct mlx4_adrv *madrv);
 
-- 
2.35.3

