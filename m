Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E151782A28
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Aug 2023 15:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235318AbjHUNM7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Aug 2023 09:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235301AbjHUNM5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Aug 2023 09:12:57 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228F4100;
        Mon, 21 Aug 2023 06:12:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E4710206C2;
        Mon, 21 Aug 2023 13:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1692623562; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U+/IaM7P+6aeGaih/C39diNuw+MT+GSi2NQS+0njdzo=;
        b=kmd0ViEqt1asfAGfNrIqERcnQpv9Do1tZvfF3zVRIN3Ei5UF9XBVXU62jvEoiTSmG0MaXK
        6EEBTiA4doiS3723448lPW+LSOOvXlAYUx3YgQRgoMkJglPIIN0GtKp/Q2T89ZvXTohzsz
        ozbLXkQyjnKfhMFkpPRxcuxIunxJvd4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A2939139BC;
        Mon, 21 Aug 2023 13:12:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sM7NJspi42QUVgAAMHmgww
        (envelope-from <petr.pavlu@suse.com>); Mon, 21 Aug 2023 13:12:42 +0000
From:   Petr Pavlu <petr.pavlu@suse.com>
To:     tariqt@nvidia.com, yishaih@nvidia.com, leon@kernel.org
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, jgg@ziepe.ca, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Petr Pavlu <petr.pavlu@suse.com>,
        Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCH net-next v3 09/11] mlx4: Connect the ethernet part to the auxiliary bus
Date:   Mon, 21 Aug 2023 15:12:23 +0200
Message-Id: <20230821131225.11290-10-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230821131225.11290-1-petr.pavlu@suse.com>
References: <20230821131225.11290-1-petr.pavlu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Use the auxiliary bus to perform device management of the ethernet part
of the mlx4 driver.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
Tested-by: Leon Romanovsky <leonro@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Acked-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx4/en_main.c | 65 ++++++++++++++------
 drivers/net/ethernet/mellanox/mlx4/intf.c    | 13 +++-
 2 files changed, 58 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_main.c b/drivers/net/ethernet/mellanox/mlx4/en_main.c
index 39c9befeb638..d8f4d00ad26b 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_main.c
@@ -234,9 +234,11 @@ static int mlx4_en_event(struct notifier_block *this, unsigned long event,
 	return NOTIFY_DONE;
 }
 
-static void mlx4_en_remove(struct mlx4_dev *dev, void *endev_ptr)
+static void mlx4_en_remove(struct auxiliary_device *adev)
 {
-	struct mlx4_en_dev *mdev = endev_ptr;
+	struct mlx4_adev *madev = container_of(adev, struct mlx4_adev, adev);
+	struct mlx4_dev *dev = madev->mdev;
+	struct mlx4_en_dev *mdev = auxiliary_get_drvdata(adev);
 	int i;
 
 	mlx4_unregister_event_notifier(dev, &mdev->mlx_nb);
@@ -259,27 +261,36 @@ static void mlx4_en_remove(struct mlx4_dev *dev, void *endev_ptr)
 	kfree(mdev);
 }
 
-static void *mlx4_en_add(struct mlx4_dev *dev)
+static int mlx4_en_probe(struct auxiliary_device *adev,
+			 const struct auxiliary_device_id *id)
 {
+	struct mlx4_adev *madev = container_of(adev, struct mlx4_adev, adev);
+	struct mlx4_dev *dev = madev->mdev;
 	struct mlx4_en_dev *mdev;
 	int err, i;
 
 	printk_once(KERN_INFO "%s", mlx4_en_version);
 
 	mdev = kzalloc(sizeof(*mdev), GFP_KERNEL);
-	if (!mdev)
+	if (!mdev) {
+		err = -ENOMEM;
 		goto err_free_res;
+	}
 
-	if (mlx4_pd_alloc(dev, &mdev->priv_pdn))
+	err = mlx4_pd_alloc(dev, &mdev->priv_pdn);
+	if (err)
 		goto err_free_dev;
 
-	if (mlx4_uar_alloc(dev, &mdev->priv_uar))
+	err = mlx4_uar_alloc(dev, &mdev->priv_uar);
+	if (err)
 		goto err_pd;
 
 	mdev->uar_map = ioremap((phys_addr_t) mdev->priv_uar.pfn << PAGE_SHIFT,
 				PAGE_SIZE);
-	if (!mdev->uar_map)
+	if (!mdev->uar_map) {
+		err = -ENOMEM;
 		goto err_uar;
+	}
 	spin_lock_init(&mdev->uar_lock);
 
 	mdev->dev = dev;
@@ -291,13 +302,15 @@ static void *mlx4_en_add(struct mlx4_dev *dev)
 	if (!mdev->LSO_support)
 		mlx4_warn(mdev, "LSO not supported, please upgrade to later FW version to enable LSO\n");
 
-	if (mlx4_mr_alloc(mdev->dev, mdev->priv_pdn, 0, ~0ull,
-			 MLX4_PERM_LOCAL_WRITE |  MLX4_PERM_LOCAL_READ,
-			 0, 0, &mdev->mr)) {
+	err = mlx4_mr_alloc(mdev->dev, mdev->priv_pdn, 0, ~0ull,
+			    MLX4_PERM_LOCAL_WRITE | MLX4_PERM_LOCAL_READ, 0, 0,
+			    &mdev->mr);
+	if (err) {
 		mlx4_err(mdev, "Failed allocating memory region\n");
 		goto err_map;
 	}
-	if (mlx4_mr_enable(mdev->dev, &mdev->mr)) {
+	err = mlx4_mr_enable(mdev->dev, &mdev->mr);
+	if (err) {
 		mlx4_err(mdev, "Failed enabling memory region\n");
 		goto err_mr;
 	}
@@ -317,8 +330,10 @@ static void *mlx4_en_add(struct mlx4_dev *dev)
 	 * Note: we cannot use the shared workqueue because of deadlocks caused
 	 *       by the rtnl lock */
 	mdev->workqueue = create_singlethread_workqueue("mlx4_en");
-	if (!mdev->workqueue)
+	if (!mdev->workqueue) {
+		err = -ENOMEM;
 		goto err_mr;
+	}
 
 	/* At this stage all non-port specific tasks are complete:
 	 * mark the card state as up */
@@ -346,7 +361,8 @@ static void *mlx4_en_add(struct mlx4_dev *dev)
 		mlx4_err(mdev, "Failed to create netdev notifier\n");
 	}
 
-	return mdev;
+	auxiliary_set_drvdata(adev, mdev);
+	return 0;
 
 err_mr:
 	(void) mlx4_mr_free(dev, &mdev->mr);
@@ -360,12 +376,23 @@ static void *mlx4_en_add(struct mlx4_dev *dev)
 err_free_dev:
 	kfree(mdev);
 err_free_res:
-	return NULL;
+	return err;
 }
 
-static struct mlx4_interface mlx4_en_interface = {
-	.add		= mlx4_en_add,
-	.remove		= mlx4_en_remove,
+static const struct auxiliary_device_id mlx4_en_id_table[] = {
+	{ .name = MLX4_ADEV_NAME ".eth" },
+	{},
+};
+
+MODULE_DEVICE_TABLE(auxiliary, mlx4_en_id_table);
+
+static struct mlx4_adrv mlx4_en_adrv = {
+	.adrv = {
+		.name	= "eth",
+		.probe	= mlx4_en_probe,
+		.remove	= mlx4_en_remove,
+		.id_table = mlx4_en_id_table,
+	},
 	.protocol	= MLX4_PROT_ETH,
 };
 
@@ -395,12 +422,12 @@ static int __init mlx4_en_init(void)
 	mlx4_en_verify_params();
 	mlx4_en_init_ptys2ethtool_map();
 
-	return mlx4_register_interface(&mlx4_en_interface);
+	return mlx4_register_auxiliary_driver(&mlx4_en_adrv);
 }
 
 static void __exit mlx4_en_cleanup(void)
 {
-	mlx4_unregister_interface(&mlx4_en_interface);
+	mlx4_unregister_auxiliary_driver(&mlx4_en_adrv);
 }
 
 module_init(mlx4_en_init);
diff --git a/drivers/net/ethernet/mellanox/mlx4/intf.c b/drivers/net/ethernet/mellanox/mlx4/intf.c
index 79b1eaa62ac2..95ff0ea435e2 100644
--- a/drivers/net/ethernet/mellanox/mlx4/intf.c
+++ b/drivers/net/ethernet/mellanox/mlx4/intf.c
@@ -50,10 +50,21 @@ static LIST_HEAD(dev_list);
 static DEFINE_MUTEX(intf_mutex);
 static DEFINE_IDA(mlx4_adev_ida);
 
+static bool is_eth_supported(struct mlx4_dev *dev)
+{
+	for (int port = 1; port <= dev->caps.num_ports; port++)
+		if (dev->caps.port_type[port] == MLX4_PORT_TYPE_ETH)
+			return true;
+
+	return false;
+}
+
 static const struct mlx4_adev_device {
 	const char *suffix;
 	bool (*is_supported)(struct mlx4_dev *dev);
-} mlx4_adev_devices[1] = {};
+} mlx4_adev_devices[] = {
+	{ "eth", is_eth_supported },
+};
 
 int mlx4_adev_init(struct mlx4_dev *dev)
 {
-- 
2.35.3

