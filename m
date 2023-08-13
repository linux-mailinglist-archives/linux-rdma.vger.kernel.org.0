Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71A6777A716
	for <lists+linux-rdma@lfdr.de>; Sun, 13 Aug 2023 16:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjHMOwO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 13 Aug 2023 10:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbjHMOwJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 13 Aug 2023 10:52:09 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87FC41702;
        Sun, 13 Aug 2023 07:52:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2137421977;
        Sun, 13 Aug 2023 14:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1691938326; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vo3VG09P6nBkj8Z7HgwZLpS7JWI7W0+dsbUV78jVfnE=;
        b=dCUqbwY2wcddKkDz0HYY9fVTZGQNSoj6Xq8ag4fVgGKPbO/8fnEvkbtdvuRP/up8CTC3SV
        sLFwcWz6moG4mtF7S386vq6rKFrhhfzfw2AaD093SMaHQdTPVlV3WufI+rK623yQ01884F
        JWp66ttL8IRqQaYLwAwmdRJaP/LiwUo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E037513593;
        Sun, 13 Aug 2023 14:52:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2MwLNhXu2GSDFAAAMHmgww
        (envelope-from <petr.pavlu@suse.com>); Sun, 13 Aug 2023 14:52:05 +0000
From:   Petr Pavlu <petr.pavlu@suse.com>
To:     tariqt@nvidia.com, yishaih@nvidia.com, leon@kernel.org
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, jgg@ziepe.ca, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Petr Pavlu <petr.pavlu@suse.com>,
        Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCH net-next v2 09/10] mlx4: Connect the infiniband part to the auxiliary bus
Date:   Sun, 13 Aug 2023 16:51:26 +0200
Message-Id: <20230813145127.10653-10-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230813145127.10653-1-petr.pavlu@suse.com>
References: <20230813145127.10653-1-petr.pavlu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Use the auxiliary bus to perform device management of the infiniband
part of the mlx4 driver.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
Tested-by: Leon Romanovsky <leonro@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Acked-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/infiniband/hw/mlx4/main.c         | 77 ++++++++++++++++-------
 drivers/net/ethernet/mellanox/mlx4/intf.c | 13 ++++
 2 files changed, 67 insertions(+), 23 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
index 0761c465120b..d92069da2b3f 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -2609,8 +2609,11 @@ static const struct ib_device_ops mlx4_ib_dev_fs_ops = {
 	.destroy_flow = mlx4_ib_destroy_flow,
 };
 
-static void *mlx4_ib_add(struct mlx4_dev *dev)
+static int mlx4_ib_probe(struct auxiliary_device *adev,
+			 const struct auxiliary_device_id *id)
 {
+	struct mlx4_adev *madev = container_of(adev, struct mlx4_adev, adev);
+	struct mlx4_dev *dev = madev->mdev;
 	struct mlx4_ib_dev *ibdev;
 	int num_ports = 0;
 	int i, j;
@@ -2630,27 +2633,31 @@ static void *mlx4_ib_add(struct mlx4_dev *dev)
 
 	/* No point in registering a device with no ports... */
 	if (num_ports == 0)
-		return NULL;
+		return -ENODEV;
 
 	ibdev = ib_alloc_device(mlx4_ib_dev, ib_dev);
 	if (!ibdev) {
 		dev_err(&dev->persist->pdev->dev,
 			"Device struct alloc failed\n");
-		return NULL;
+		return -ENOMEM;
 	}
 
 	iboe = &ibdev->iboe;
 
-	if (mlx4_pd_alloc(dev, &ibdev->priv_pdn))
+	err = mlx4_pd_alloc(dev, &ibdev->priv_pdn);
+	if (err)
 		goto err_dealloc;
 
-	if (mlx4_uar_alloc(dev, &ibdev->priv_uar))
+	err = mlx4_uar_alloc(dev, &ibdev->priv_uar);
+	if (err)
 		goto err_pd;
 
 	ibdev->uar_map = ioremap((phys_addr_t) ibdev->priv_uar.pfn << PAGE_SHIFT,
 				 PAGE_SIZE);
-	if (!ibdev->uar_map)
+	if (!ibdev->uar_map) {
+		err = -ENOMEM;
 		goto err_uar;
+	}
 	MLX4_INIT_DOORBELL_LOCK(&ibdev->uar_lock);
 
 	ibdev->dev = dev;
@@ -2694,7 +2701,8 @@ static void *mlx4_ib_add(struct mlx4_dev *dev)
 
 	spin_lock_init(&iboe->lock);
 
-	if (init_node_data(ibdev))
+	err = init_node_data(ibdev);
+	if (err)
 		goto err_map;
 	mlx4_init_sl2vl_tbl(ibdev);
 
@@ -2726,6 +2734,7 @@ static void *mlx4_ib_add(struct mlx4_dev *dev)
 		new_counter_index = kmalloc(sizeof(*new_counter_index),
 					    GFP_KERNEL);
 		if (!new_counter_index) {
+			err = -ENOMEM;
 			if (allocated)
 				mlx4_counter_free(ibdev->dev, counter_index);
 			goto err_counter;
@@ -2743,8 +2752,10 @@ static void *mlx4_ib_add(struct mlx4_dev *dev)
 			new_counter_index =
 					kmalloc(sizeof(struct counter_index),
 						GFP_KERNEL);
-			if (!new_counter_index)
+			if (!new_counter_index) {
+				err = -ENOMEM;
 				goto err_counter;
+			}
 			new_counter_index->index = counter_index;
 			new_counter_index->allocated = 0;
 			list_add_tail(&new_counter_index->list,
@@ -2773,8 +2784,10 @@ static void *mlx4_ib_add(struct mlx4_dev *dev)
 
 		ibdev->ib_uc_qpns_bitmap = bitmap_alloc(ibdev->steer_qpn_count,
 							GFP_KERNEL);
-		if (!ibdev->ib_uc_qpns_bitmap)
+		if (!ibdev->ib_uc_qpns_bitmap) {
+			err = -ENOMEM;
 			goto err_steer_qp_release;
+		}
 
 		if (dev->caps.flags2 & MLX4_DEV_CAP_FLAG2_DMFS_IPOIB) {
 			bitmap_zero(ibdev->ib_uc_qpns_bitmap,
@@ -2794,17 +2807,21 @@ static void *mlx4_ib_add(struct mlx4_dev *dev)
 	for (j = 1; j <= ibdev->dev->caps.num_ports; j++)
 		atomic64_set(&iboe->mac[j - 1], ibdev->dev->caps.def_mac[j]);
 
-	if (mlx4_ib_alloc_diag_counters(ibdev))
+	err = mlx4_ib_alloc_diag_counters(ibdev);
+	if (err)
 		goto err_steer_free_bitmap;
 
-	if (ib_register_device(&ibdev->ib_dev, "mlx4_%d",
-			       &dev->persist->pdev->dev))
+	err = ib_register_device(&ibdev->ib_dev, "mlx4_%d",
+				 &dev->persist->pdev->dev);
+	if (err)
 		goto err_diag_counters;
 
-	if (mlx4_ib_mad_init(ibdev))
+	err = mlx4_ib_mad_init(ibdev);
+	if (err)
 		goto err_reg;
 
-	if (mlx4_ib_init_sriov(ibdev))
+	err = mlx4_ib_init_sriov(ibdev);
+	if (err)
 		goto err_mad;
 
 	if (!iboe->nb.notifier_call) {
@@ -2844,7 +2861,8 @@ static void *mlx4_ib_add(struct mlx4_dev *dev)
 	err = mlx4_register_event_notifier(dev, &ibdev->mlx_nb);
 	WARN(err, "failed to register mlx4 event notifier (%d)", err);
 
-	return ibdev;
+	auxiliary_set_drvdata(adev, ibdev);
+	return 0;
 
 err_notif:
 	if (ibdev->iboe.nb.notifier_call) {
@@ -2888,7 +2906,7 @@ static void *mlx4_ib_add(struct mlx4_dev *dev)
 err_dealloc:
 	ib_dealloc_device(&ibdev->ib_dev);
 
-	return NULL;
+	return err;
 }
 
 int mlx4_ib_steer_qp_alloc(struct mlx4_ib_dev *dev, int count, int *qpn)
@@ -2955,9 +2973,11 @@ int mlx4_ib_steer_qp_reg(struct mlx4_ib_dev *mdev, struct mlx4_ib_qp *mqp,
 	return err;
 }
 
-static void mlx4_ib_remove(struct mlx4_dev *dev, void *ibdev_ptr)
+static void mlx4_ib_remove(struct auxiliary_device *adev)
 {
-	struct mlx4_ib_dev *ibdev = ibdev_ptr;
+	struct mlx4_adev *madev = container_of(adev, struct mlx4_adev, adev);
+	struct mlx4_dev *dev = madev->mdev;
+	struct mlx4_ib_dev *ibdev = auxiliary_get_drvdata(adev);
 	int p;
 	int i;
 
@@ -3298,9 +3318,20 @@ static int mlx4_ib_event(struct notifier_block *this, unsigned long event,
 	return NOTIFY_DONE;
 }
 
-static struct mlx4_interface mlx4_ib_interface = {
-	.add		= mlx4_ib_add,
-	.remove		= mlx4_ib_remove,
+static const struct auxiliary_device_id mlx4_ib_id_table[] = {
+	{ .name = MLX4_ADEV_NAME ".ib" },
+	{},
+};
+
+MODULE_DEVICE_TABLE(auxiliary, mlx4_ib_id_table);
+
+static struct mlx4_adrv mlx4_ib_adrv = {
+	.adrv = {
+		.name	= "ib",
+		.probe	= mlx4_ib_probe,
+		.remove	= mlx4_ib_remove,
+		.id_table = mlx4_ib_id_table,
+	},
 	.protocol	= MLX4_PROT_IB_IPV6,
 	.flags		= MLX4_INTFF_BONDING
 };
@@ -3325,7 +3356,7 @@ static int __init mlx4_ib_init(void)
 	if (err)
 		goto clean_cm;
 
-	err = mlx4_register_interface(&mlx4_ib_interface);
+	err = mlx4_register_auxiliary_driver(&mlx4_ib_adrv);
 	if (err)
 		goto clean_mcg;
 
@@ -3347,7 +3378,7 @@ static int __init mlx4_ib_init(void)
 
 static void __exit mlx4_ib_cleanup(void)
 {
-	mlx4_unregister_interface(&mlx4_ib_interface);
+	mlx4_unregister_auxiliary_driver(&mlx4_ib_adrv);
 	mlx4_ib_mcg_destroy();
 	mlx4_ib_cm_destroy();
 	mlx4_ib_qp_event_cleanup();
diff --git a/drivers/net/ethernet/mellanox/mlx4/intf.c b/drivers/net/ethernet/mellanox/mlx4/intf.c
index 0a27820ece2e..16b2c99ff737 100644
--- a/drivers/net/ethernet/mellanox/mlx4/intf.c
+++ b/drivers/net/ethernet/mellanox/mlx4/intf.c
@@ -59,11 +59,24 @@ static bool is_eth_supported(struct mlx4_dev *dev)
 	return false;
 }
 
+static bool is_ib_supported(struct mlx4_dev *dev)
+{
+	for (int port = 1; port <= dev->caps.num_ports; port++)
+		if (dev->caps.port_type[port] == MLX4_PORT_TYPE_IB)
+			return true;
+
+	if (dev->caps.flags & MLX4_DEV_CAP_FLAG_IBOE)
+		return true;
+
+	return false;
+}
+
 static const struct mlx4_adev_device {
 	const char *suffix;
 	bool (*is_supported)(struct mlx4_dev *dev);
 } mlx4_adev_devices[] = {
 	{ "eth", is_eth_supported },
+	{ "ib", is_ib_supported },
 };
 
 int mlx4_adev_init(struct mlx4_dev *dev)
-- 
2.35.3

