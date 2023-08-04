Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 134457703F4
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Aug 2023 17:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjHDPGe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Aug 2023 11:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbjHDPGP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 4 Aug 2023 11:06:15 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3634C00;
        Fri,  4 Aug 2023 08:06:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 95CE41F8B4;
        Fri,  4 Aug 2023 15:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1691161567; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XsSun1+YJlfBM79bwQX5XcjtxYEu+EP0gv5ElS+bbJk=;
        b=YTYH5IoYf36CHrfJN/titJnr6JubWgizZfXYp8u93hmKunMAbKKnoUDW/xUHSBhvF3FoKj
        otBRhiOMh8dnJjQoX6NTuxgmPpXRuiCs3JRx9cTzys8mrFrn7jmLQnj02UctbVI0+Fx9ht
        mnNvkOMuLnC99ZkbeB5IDyTcQ8XuPPk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 60517133B5;
        Fri,  4 Aug 2023 15:06:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aLC3Ft8TzWRwSQAAMHmgww
        (envelope-from <petr.pavlu@suse.com>); Fri, 04 Aug 2023 15:06:07 +0000
From:   Petr Pavlu <petr.pavlu@suse.com>
To:     tariqt@nvidia.com, yishaih@nvidia.com, leon@kernel.org
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, jgg@ziepe.ca, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH net-next 05/10] mlx4: Move the bond work to the core driver
Date:   Fri,  4 Aug 2023 17:05:22 +0200
Message-Id: <20230804150527.6117-6-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230804150527.6117-1-petr.pavlu@suse.com>
References: <20230804150527.6117-1-petr.pavlu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Function mlx4_en_queue_bond_work() is used in mlx4_en to start a bond
reconfiguration. It gathers data about a new port map setting, takes
a reference on the netdev that triggered the change and queues a work
object on mlx4_en_priv.mdev.workqueue to perform the operation. The
scheduled work is mlx4_en_bond_work() which calls
mlx4_bond()/mlx4_unbond() and consequently mlx4_do_bond().

At the same time, function mlx4_change_port_types() in mlx4_core might
be invoked to change the port type configuration. As part of its logic,
it re-registers the whole device by calling mlx4_unregister_device(),
followed by mlx4_register_device().

The two operations can result in concurrent access to the data about
currently active interfaces on the device.

Functions mlx4_register_device() and mlx4_unregister_device() lock the
intf_mutex to gain exclusive access to this data. The current
implementation of mlx4_do_bond() doesn't do that which could result in
an unexpected behavior. An updated version of mlx4_do_bond() for use
with an auxiliary bus goes and locks the intf_mutex when accessing a new
auxiliary device array.

However, doing so can then result in the following deadlock:
* A two-port mlx4 device is configured as an Ethernet bond.
* One of the ports is changed from eth to ib, for instance, by writing
  into a mlx4_port<x> sysfs attribute file.
* mlx4_change_port_types() is called to update port types. It invokes
  mlx4_unregister_device() to unregister the device which locks the
  intf_mutex and starts removing all associated interfaces.
* Function mlx4_en_remove() gets invoked and starts destroying its first
  netdev. This triggers mlx4_en_netdev_event() which recognizes that the
  configured bond is broken. It runs mlx4_en_queue_bond_work() which
  takes a reference on the netdev. Removing the netdev now cannot
  proceed until the work is completed.
* Work function mlx4_en_bond_work() gets scheduled. It calls
  mlx4_unbond() -> mlx4_do_bond(). The latter function tries to lock the
  intf_mutex but that is not possible because it is held already by
  mlx4_unregister_device().

This particular case could be possibly solved by unregistering the
mlx4_en_netdev_event() notifier in mlx4_en_remove() earlier, but it
seems better to decouple mlx4_en more and break this reference order.

Avoid then this scenario by recognizing that the bond reconfiguration
operates only on a mlx4_dev. The logic to queue and execute the bond
work can be moved into the mlx4_core driver. Only a reference on the
respective mlx4_dev object is needed to be taken during the work's
lifetime. This removes a call from mlx4_en that can directly result in
needing to lock the intf_mutex, it remains a privilege of the core
driver.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
Tested-by: Leon Romanovsky <leon@kernel.org>
---
 .../net/ethernet/mellanox/mlx4/en_netdev.c    | 62 +-----------------
 drivers/net/ethernet/mellanox/mlx4/main.c     | 65 +++++++++++++++++--
 drivers/net/ethernet/mellanox/mlx4/mlx4.h     |  5 ++
 include/linux/mlx4/device.h                   | 13 ++++
 include/linux/mlx4/driver.h                   | 19 ------
 5 files changed, 77 insertions(+), 87 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
index 7066c426b95c..33bbcced8105 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
@@ -2894,63 +2894,6 @@ static const struct xdp_metadata_ops mlx4_xdp_metadata_ops = {
 	.xmo_rx_hash			= mlx4_en_xdp_rx_hash,
 };
 
-struct mlx4_en_bond {
-	struct work_struct work;
-	struct mlx4_en_priv *priv;
-	int is_bonded;
-	struct mlx4_port_map port_map;
-};
-
-static void mlx4_en_bond_work(struct work_struct *work)
-{
-	struct mlx4_en_bond *bond = container_of(work,
-						     struct mlx4_en_bond,
-						     work);
-	int err = 0;
-	struct mlx4_dev *dev = bond->priv->mdev->dev;
-
-	if (bond->is_bonded) {
-		if (!mlx4_is_bonded(dev)) {
-			err = mlx4_bond(dev);
-			if (err)
-				en_err(bond->priv, "Fail to bond device\n");
-		}
-		if (!err) {
-			err = mlx4_port_map_set(dev, &bond->port_map);
-			if (err)
-				en_err(bond->priv, "Fail to set port map [%d][%d]: %d\n",
-				       bond->port_map.port1,
-				       bond->port_map.port2,
-				       err);
-		}
-	} else if (mlx4_is_bonded(dev)) {
-		err = mlx4_unbond(dev);
-		if (err)
-			en_err(bond->priv, "Fail to unbond device\n");
-	}
-	dev_put(bond->priv->dev);
-	kfree(bond);
-}
-
-static int mlx4_en_queue_bond_work(struct mlx4_en_priv *priv, int is_bonded,
-				   u8 v2p_p1, u8 v2p_p2)
-{
-	struct mlx4_en_bond *bond;
-
-	bond = kzalloc(sizeof(*bond), GFP_ATOMIC);
-	if (!bond)
-		return -ENOMEM;
-
-	INIT_WORK(&bond->work, mlx4_en_bond_work);
-	bond->priv = priv;
-	bond->is_bonded = is_bonded;
-	bond->port_map.port1 = v2p_p1;
-	bond->port_map.port2 = v2p_p2;
-	dev_hold(priv->dev);
-	queue_work(priv->mdev->workqueue, &bond->work);
-	return 0;
-}
-
 int mlx4_en_netdev_event(struct notifier_block *this,
 			 unsigned long event, void *ptr)
 {
@@ -2960,7 +2903,6 @@ int mlx4_en_netdev_event(struct notifier_block *this,
 	struct mlx4_dev *dev;
 	int i, num_eth_ports = 0;
 	bool do_bond = true;
-	struct mlx4_en_priv *priv;
 	u8 v2p_port1 = 0;
 	u8 v2p_port2 = 0;
 
@@ -2995,7 +2937,6 @@ int mlx4_en_netdev_event(struct notifier_block *this,
 	if ((do_bond && (event != NETDEV_BONDING_INFO)) || !port)
 		return NOTIFY_DONE;
 
-	priv = netdev_priv(ndev);
 	if (do_bond) {
 		struct netdev_notifier_bonding_info *notifier_info = ptr;
 		struct netdev_bonding_info *bonding_info =
@@ -3062,8 +3003,7 @@ int mlx4_en_netdev_event(struct notifier_block *this,
 		}
 	}
 
-	mlx4_en_queue_bond_work(priv, do_bond,
-				v2p_port1, v2p_port2);
+	mlx4_queue_bond_work(dev, do_bond, v2p_port1, v2p_port2);
 
 	return NOTIFY_DONE;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx4/main.c b/drivers/net/ethernet/mellanox/mlx4/main.c
index 5f3ba8385e23..0ed490b99163 100644
--- a/drivers/net/ethernet/mellanox/mlx4/main.c
+++ b/drivers/net/ethernet/mellanox/mlx4/main.c
@@ -1441,7 +1441,7 @@ static int mlx4_mf_unbond(struct mlx4_dev *dev)
 	return ret;
 }
 
-int mlx4_bond(struct mlx4_dev *dev)
+static int mlx4_bond(struct mlx4_dev *dev)
 {
 	int ret = 0;
 	struct mlx4_priv *priv = mlx4_priv(dev);
@@ -1467,9 +1467,8 @@ int mlx4_bond(struct mlx4_dev *dev)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(mlx4_bond);
 
-int mlx4_unbond(struct mlx4_dev *dev)
+static int mlx4_unbond(struct mlx4_dev *dev)
 {
 	int ret = 0;
 	struct mlx4_priv *priv = mlx4_priv(dev);
@@ -1496,10 +1495,8 @@ int mlx4_unbond(struct mlx4_dev *dev)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(mlx4_unbond);
 
-
-int mlx4_port_map_set(struct mlx4_dev *dev, struct mlx4_port_map *v2p)
+static int mlx4_port_map_set(struct mlx4_dev *dev, struct mlx4_port_map *v2p)
 {
 	u8 port1 = v2p->port1;
 	u8 port2 = v2p->port2;
@@ -1541,7 +1538,61 @@ int mlx4_port_map_set(struct mlx4_dev *dev, struct mlx4_port_map *v2p)
 	mutex_unlock(&priv->bond_mutex);
 	return err;
 }
-EXPORT_SYMBOL_GPL(mlx4_port_map_set);
+
+struct mlx4_bond {
+	struct work_struct work;
+	struct mlx4_dev *dev;
+	int is_bonded;
+	struct mlx4_port_map port_map;
+};
+
+static void mlx4_bond_work(struct work_struct *work)
+{
+	struct mlx4_bond *bond = container_of(work, struct mlx4_bond, work);
+	int err = 0;
+
+	if (bond->is_bonded) {
+		if (!mlx4_is_bonded(bond->dev)) {
+			err = mlx4_bond(bond->dev);
+			if (err)
+				mlx4_err(bond->dev, "Fail to bond device\n");
+		}
+		if (!err) {
+			err = mlx4_port_map_set(bond->dev, &bond->port_map);
+			if (err)
+				mlx4_err(bond->dev,
+					 "Fail to set port map [%d][%d]: %d\n",
+					 bond->port_map.port1,
+					 bond->port_map.port2, err);
+		}
+	} else if (mlx4_is_bonded(bond->dev)) {
+		err = mlx4_unbond(bond->dev);
+		if (err)
+			mlx4_err(bond->dev, "Fail to unbond device\n");
+	}
+	put_device(&bond->dev->persist->pdev->dev);
+	kfree(bond);
+}
+
+int mlx4_queue_bond_work(struct mlx4_dev *dev, int is_bonded, u8 v2p_p1,
+			 u8 v2p_p2)
+{
+	struct mlx4_bond *bond;
+
+	bond = kzalloc(sizeof(*bond), GFP_ATOMIC);
+	if (!bond)
+		return -ENOMEM;
+
+	INIT_WORK(&bond->work, mlx4_bond_work);
+	get_device(&dev->persist->pdev->dev);
+	bond->dev = dev;
+	bond->is_bonded = is_bonded;
+	bond->port_map.port1 = v2p_p1;
+	bond->port_map.port2 = v2p_p2;
+	queue_work(mlx4_wq, &bond->work);
+	return 0;
+}
+EXPORT_SYMBOL(mlx4_queue_bond_work);
 
 static int mlx4_load_fw(struct mlx4_dev *dev)
 {
diff --git a/drivers/net/ethernet/mellanox/mlx4/mlx4.h b/drivers/net/ethernet/mellanox/mlx4/mlx4.h
index 10f12e4992f1..ece9acb6a869 100644
--- a/drivers/net/ethernet/mellanox/mlx4/mlx4.h
+++ b/drivers/net/ethernet/mellanox/mlx4/mlx4.h
@@ -863,6 +863,11 @@ struct mlx4_steer {
 	struct list_head steer_entries[MLX4_NUM_STEERS];
 };
 
+struct mlx4_port_map {
+	u8	port1;
+	u8	port2;
+};
+
 enum {
 	MLX4_PCI_DEV_IS_VF		= 1 << 0,
 	MLX4_PCI_DEV_FORCE_SENSE_PORT	= 1 << 1,
diff --git a/include/linux/mlx4/device.h b/include/linux/mlx4/device.h
index 6646634a0b9d..049d8a4b044d 100644
--- a/include/linux/mlx4/device.h
+++ b/include/linux/mlx4/device.h
@@ -1087,6 +1087,19 @@ static inline void *mlx4_buf_offset(struct mlx4_buf *buf, int offset)
 			(offset & (PAGE_SIZE - 1));
 }
 
+static inline int mlx4_is_bonded(struct mlx4_dev *dev)
+{
+	return !!(dev->flags & MLX4_FLAG_BONDED);
+}
+
+static inline int mlx4_is_mf_bonded(struct mlx4_dev *dev)
+{
+	return (mlx4_is_bonded(dev) && mlx4_is_mfunc(dev));
+}
+
+int mlx4_queue_bond_work(struct mlx4_dev *dev, int is_bonded, u8 v2p_p1,
+			 u8 v2p_p2);
+
 int mlx4_pd_alloc(struct mlx4_dev *dev, u32 *pdn);
 void mlx4_pd_free(struct mlx4_dev *dev, u32 pdn);
 int mlx4_xrcd_alloc(struct mlx4_dev *dev, u32 *xrcdn);
diff --git a/include/linux/mlx4/driver.h b/include/linux/mlx4/driver.h
index 0f8c9ba4c574..781d5a0c2faa 100644
--- a/include/linux/mlx4/driver.h
+++ b/include/linux/mlx4/driver.h
@@ -66,25 +66,6 @@ struct mlx4_interface {
 int mlx4_register_interface(struct mlx4_interface *intf);
 void mlx4_unregister_interface(struct mlx4_interface *intf);
 
-int mlx4_bond(struct mlx4_dev *dev);
-int mlx4_unbond(struct mlx4_dev *dev);
-static inline int mlx4_is_bonded(struct mlx4_dev *dev)
-{
-	return !!(dev->flags & MLX4_FLAG_BONDED);
-}
-
-static inline int mlx4_is_mf_bonded(struct mlx4_dev *dev)
-{
-	return (mlx4_is_bonded(dev) && mlx4_is_mfunc(dev));
-}
-
-struct mlx4_port_map {
-	u8	port1;
-	u8	port2;
-};
-
-int mlx4_port_map_set(struct mlx4_dev *dev, struct mlx4_port_map *v2p);
-
 int mlx4_register_event_notifier(struct mlx4_dev *dev,
 				 struct notifier_block *nb);
 int mlx4_unregister_event_notifier(struct mlx4_dev *dev,
-- 
2.35.3

