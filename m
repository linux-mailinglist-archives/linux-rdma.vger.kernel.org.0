Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB468771EA3
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Aug 2023 12:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjHGKqE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Aug 2023 06:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbjHGKqA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Aug 2023 06:46:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFDA21735
        for <linux-rdma@vger.kernel.org>; Mon,  7 Aug 2023 03:45:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E96F617A0
        for <linux-rdma@vger.kernel.org>; Mon,  7 Aug 2023 10:45:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFD1EC433AD;
        Mon,  7 Aug 2023 10:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691405120;
        bh=UTVZ99+ysFDAzLoGeBnvQlb5LSbbHsFXgSAZFJNP76o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WaUhQLSSa35Qy2ILn1LUVhfd49TIHonEAlbYXaXPcuwgc+WGLiNO9wZKSs5msoPnh
         EESMCpeIBri9npN6TrhdT+RHsOFt8tvNNAPN3lZV/KvAohIC0MF4ceZNHAAqqTrVRw
         MdM6UY6+L6UcCwf9VT6oNA53KrVsrAiuqTWf6yFp43AtHNNYRKBktSppGs4vk69C0P
         g6qykjlZj6F3k+UVr12s20wMo8SUuGoJn72z2c0hiGTGGM7bC2UKVO1hbqYVsSubqP
         P76uT04w6+vZvCVqhPey9e8qX6Q6INtY+VY+r01RKdHGaUQsKR5btrKb11NXY6z4DE
         keMiv7yp+knlQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>, Jakub Kicinski <kuba@kernel.org>
Cc:     Patrisious Haddad <phaddad@nvidia.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>,
        Mark Zhang <markzhang@nvidia.com>, netdev@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>, Raed Salem <raeds@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH mlx5-next 14/14] RDMA/mlx5: Handles RoCE MACsec steering rules addition and deletion
Date:   Mon,  7 Aug 2023 13:44:23 +0300
Message-ID: <596a481a846e94e7544ea7349ef5ec6fe00bd802.1691403485.git.leon@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1691403485.git.leon@kernel.org>
References: <cover.1691403485.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Patrisious Haddad <phaddad@nvidia.com>

Add RoCE MACsec rules when a gid is added for the MACsec netdevice and
handle their cleanup when the gid is removed or the MACsec SA is deleted.
Also support alias IP for the MACsec device, as long as we don't have
more ips than what the gid table can hold.
In addition handle the case where a gid is added but there are still no
SAs added for the MACsec device, so the rules are added later on when
the SAs are added.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/macsec.c  | 235 +++++++++++++++++++++++++--
 drivers/infiniband/hw/mlx5/macsec.h  |   8 +-
 drivers/infiniband/hw/mlx5/main.c    |   6 +-
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  10 ++
 include/linux/mlx5/driver.h          |   4 +-
 5 files changed, 246 insertions(+), 17 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/macsec.c b/drivers/infiniband/hw/mlx5/macsec.c
index 349ad13af75d..3c56eb5eddf3 100644
--- a/drivers/infiniband/hw/mlx5/macsec.c
+++ b/drivers/infiniband/hw/mlx5/macsec.c
@@ -2,13 +2,174 @@
 /* Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES. */
 
 #include "macsec.h"
+#include <linux/mlx5/macsec.h>
 
 struct mlx5_reserved_gids {
 	int macsec_index;
 	const struct ib_gid_attr *physical_gid;
 };
 
-int mlx5r_macsec_alloc_gids(struct mlx5_ib_dev *dev)
+struct mlx5_roce_gids {
+	struct list_head roce_gid_list_entry;
+	u16 gid_idx;
+	union {
+		struct sockaddr_in  sockaddr_in;
+		struct sockaddr_in6 sockaddr_in6;
+	} addr;
+};
+
+struct mlx5_macsec_device {
+	struct list_head macsec_devices_list_entry;
+	void *macdev;
+	struct list_head macsec_roce_gids;
+	struct list_head tx_rules_list;
+	struct list_head rx_rules_list;
+};
+
+static void cleanup_macsec_device(struct mlx5_macsec_device *macsec_device)
+{
+	if (!list_empty(&macsec_device->tx_rules_list) ||
+	    !list_empty(&macsec_device->rx_rules_list) ||
+	    !list_empty(&macsec_device->macsec_roce_gids))
+		return;
+
+	list_del(&macsec_device->macsec_devices_list_entry);
+	kfree(macsec_device);
+}
+
+static struct mlx5_macsec_device *get_macsec_device(void *macdev,
+						    struct list_head *macsec_devices_list)
+{
+	struct mlx5_macsec_device *iter, *macsec_device = NULL;
+
+	list_for_each_entry(iter, macsec_devices_list, macsec_devices_list_entry) {
+		if (iter->macdev == macdev) {
+			macsec_device = iter;
+			break;
+		}
+	}
+
+	if (macsec_device)
+		return macsec_device;
+
+	macsec_device = kzalloc(sizeof(*macsec_device), GFP_KERNEL);
+	if (!macsec_device)
+		return NULL;
+
+	macsec_device->macdev = macdev;
+	INIT_LIST_HEAD(&macsec_device->tx_rules_list);
+	INIT_LIST_HEAD(&macsec_device->rx_rules_list);
+	INIT_LIST_HEAD(&macsec_device->macsec_roce_gids);
+	list_add(&macsec_device->macsec_devices_list_entry, macsec_devices_list);
+
+	return macsec_device;
+}
+
+static void mlx5_macsec_del_roce_gid(struct mlx5_macsec_device *macsec_device, u16 gid_idx)
+{
+	struct mlx5_roce_gids *current_gid, *next_gid;
+
+	list_for_each_entry_safe(current_gid, next_gid, &macsec_device->macsec_roce_gids,
+				 roce_gid_list_entry)
+		if (current_gid->gid_idx == gid_idx) {
+			list_del(&current_gid->roce_gid_list_entry);
+			kfree(current_gid);
+		}
+}
+
+static void mlx5_macsec_save_roce_gid(struct mlx5_macsec_device *macsec_device,
+				      const struct sockaddr *addr, u16 gid_idx)
+{
+	struct mlx5_roce_gids *roce_gids;
+
+	roce_gids = kzalloc(sizeof(*roce_gids), GFP_KERNEL);
+	if (!roce_gids)
+		return;
+
+	roce_gids->gid_idx = gid_idx;
+	if (addr->sa_family == AF_INET)
+		memcpy(&roce_gids->addr.sockaddr_in, addr, sizeof(roce_gids->addr.sockaddr_in));
+	else
+		memcpy(&roce_gids->addr.sockaddr_in6, addr, sizeof(roce_gids->addr.sockaddr_in6));
+
+	list_add_tail(&roce_gids->roce_gid_list_entry, &macsec_device->macsec_roce_gids);
+}
+
+static void handle_macsec_gids(struct list_head *macsec_devices_list,
+			       struct mlx5_macsec_event_data *data)
+{
+	struct mlx5_macsec_device *macsec_device;
+	struct mlx5_roce_gids *gid;
+
+	macsec_device = get_macsec_device(data->macdev, macsec_devices_list);
+	if (!macsec_device)
+		return;
+
+	list_for_each_entry(gid, &macsec_device->macsec_roce_gids, roce_gid_list_entry) {
+		mlx5_macsec_add_roce_sa_rules(data->fs_id, (struct sockaddr *)&gid->addr,
+					      gid->gid_idx, &macsec_device->tx_rules_list,
+					      &macsec_device->rx_rules_list, data->macsec_fs,
+					      data->is_tx);
+	}
+}
+
+static void del_sa_roce_rule(struct list_head *macsec_devices_list,
+			     struct mlx5_macsec_event_data *data)
+{
+	struct mlx5_macsec_device *macsec_device;
+
+	macsec_device = get_macsec_device(data->macdev, macsec_devices_list);
+	WARN_ON(!macsec_device);
+
+	mlx5_macsec_del_roce_sa_rules(data->fs_id, data->macsec_fs,
+				      &macsec_device->tx_rules_list,
+				      &macsec_device->rx_rules_list, data->is_tx);
+}
+
+static int macsec_event(struct notifier_block *nb, unsigned long event, void *data)
+{
+	struct mlx5_macsec *macsec = container_of(nb, struct mlx5_macsec, blocking_events_nb);
+
+	mutex_lock(&macsec->lock);
+	switch (event) {
+	case MLX5_DRIVER_EVENT_MACSEC_SA_ADDED:
+		handle_macsec_gids(&macsec->macsec_devices_list, data);
+		break;
+	case MLX5_DRIVER_EVENT_MACSEC_SA_DELETED:
+		del_sa_roce_rule(&macsec->macsec_devices_list, data);
+		break;
+	default:
+		mutex_unlock(&macsec->lock);
+		return NOTIFY_DONE;
+	}
+	mutex_unlock(&macsec->lock);
+	return NOTIFY_OK;
+}
+
+void mlx5r_macsec_event_register(struct mlx5_ib_dev *dev)
+{
+	if (!mlx5_is_macsec_roce_supported(dev->mdev)) {
+		mlx5_ib_dbg(dev, "RoCE MACsec not supported due to capabilities\n");
+		return;
+	}
+
+	dev->macsec.blocking_events_nb.notifier_call = macsec_event;
+	blocking_notifier_chain_register(&dev->mdev->macsec_nh,
+					 &dev->macsec.blocking_events_nb);
+}
+
+void mlx5r_macsec_event_unregister(struct mlx5_ib_dev *dev)
+{
+	if (!mlx5_is_macsec_roce_supported(dev->mdev)) {
+		mlx5_ib_dbg(dev, "RoCE MACsec not supported due to capabilities\n");
+		return;
+	}
+
+	blocking_notifier_chain_unregister(&dev->mdev->macsec_nh,
+					   &dev->macsec.blocking_events_nb);
+}
+
+int mlx5r_macsec_init_gids_and_devlist(struct mlx5_ib_dev *dev)
 {
 	int i, j, max_gids;
 
@@ -29,6 +190,9 @@ int mlx5r_macsec_alloc_gids(struct mlx5_ib_dev *dev)
 			dev->port[i].reserved_gids[j].macsec_index = -1;
 	}
 
+	INIT_LIST_HEAD(&dev->macsec.macsec_devices_list);
+	mutex_init(&dev->macsec.lock);
+
 	return 0;
 err:
 	while (i >= 0) {
@@ -47,15 +211,22 @@ void mlx5r_macsec_dealloc_gids(struct mlx5_ib_dev *dev)
 
 	for (i = 0; i < dev->num_ports; i++)
 		kfree(dev->port[i].reserved_gids);
+
+	mutex_destroy(&dev->macsec.lock);
 }
 
 int mlx5r_add_gid_macsec_operations(const struct ib_gid_attr *attr)
 {
 	struct mlx5_ib_dev *dev = to_mdev(attr->device);
+	struct mlx5_macsec_device *macsec_device;
 	const struct ib_gid_attr *physical_gid;
 	struct mlx5_reserved_gids *mgids;
 	struct net_device *ndev;
 	int ret = 0;
+	union {
+		struct sockaddr_in  sockaddr_in;
+		struct sockaddr_in6 sockaddr_in6;
+	} addr;
 
 	if (attr->gid_type != IB_GID_TYPE_ROCE_UDP_ENCAP)
 		return 0;
@@ -76,34 +247,62 @@ int mlx5r_add_gid_macsec_operations(const struct ib_gid_attr *attr)
 		rcu_read_unlock();
 		return 0;
 	}
+	dev_hold(ndev);
 	rcu_read_unlock();
 
+	mutex_lock(&dev->macsec.lock);
+	macsec_device = get_macsec_device(ndev, &dev->macsec.macsec_devices_list);
+	if (!macsec_device) {
+		ret = -ENOMEM;
+		goto dev_err;
+	}
+
 	physical_gid = rdma_find_gid(attr->device, &attr->gid,
 				     attr->gid_type, NULL);
-	if (IS_ERR(physical_gid))
-		return 0;
+	if (!IS_ERR(physical_gid)) {
+		ret = set_roce_addr(to_mdev(physical_gid->device),
+				    physical_gid->port_num,
+				    physical_gid->index, NULL,
+				    physical_gid);
+		if (ret)
+			goto gid_err;
 
-	ret = set_roce_addr(to_mdev(physical_gid->device),
-			    physical_gid->port_num,
-			    physical_gid->index, NULL,
-			    physical_gid);
-	if (ret)
-		goto gid_err;
+		mgids = &dev->port[attr->port_num - 1].reserved_gids[physical_gid->index];
+		mgids->macsec_index = attr->index;
+		mgids->physical_gid = physical_gid;
+	}
 
-	mgids = &dev->port[attr->port_num - 1].reserved_gids[physical_gid->index];
-	mgids->macsec_index = attr->index;
-	mgids->physical_gid = physical_gid;
+	/* Proceed with adding steering rules, regardless if there was gid ambiguity or not.*/
+	rdma_gid2ip((struct sockaddr *)&addr, &attr->gid);
+	ret = mlx5_macsec_add_roce_rule(ndev, (struct sockaddr *)&addr, attr->index,
+					&macsec_device->tx_rules_list,
+					&macsec_device->rx_rules_list, dev->mdev->macsec_fs);
+	if (ret && !IS_ERR(physical_gid))
+		goto rule_err;
 
-	return 0;
+	mlx5_macsec_save_roce_gid(macsec_device, (struct sockaddr *)&addr, attr->index);
+
+	dev_put(ndev);
+	mutex_unlock(&dev->macsec.lock);
+	return ret;
 
+rule_err:
+	set_roce_addr(to_mdev(physical_gid->device), physical_gid->port_num,
+		      physical_gid->index, &physical_gid->gid, physical_gid);
+	mgids->macsec_index = -1;
 gid_err:
 	rdma_put_gid_attr(physical_gid);
+	cleanup_macsec_device(macsec_device);
+dev_err:
+	dev_put(ndev);
+	mutex_unlock(&dev->macsec.lock);
 	return ret;
 }
 
 void mlx5r_del_gid_macsec_operations(const struct ib_gid_attr *attr)
 {
 	struct mlx5_ib_dev *dev = to_mdev(attr->device);
+	struct mlx5_macsec_device *macsec_device;
 	struct mlx5_reserved_gids *mgids;
 	struct net_device *ndev;
 	int i, max_gids;
@@ -134,8 +333,10 @@ void mlx5r_del_gid_macsec_operations(const struct ib_gid_attr *attr)
 		rcu_read_unlock();
 		return;
 	}
+	dev_hold(ndev);
 	rcu_read_unlock();
 
+	mutex_lock(&dev->macsec.lock);
 	max_gids = MLX5_CAP_ROCE(dev->mdev, roce_address_table_size);
 	for (i = 0; i < max_gids; i++) { /* Checking if macsec gid has ambiguous IP */
 		mgids = &dev->port[attr->port_num - 1].reserved_gids[i];
@@ -152,4 +353,12 @@ void mlx5r_del_gid_macsec_operations(const struct ib_gid_attr *attr)
 			break;
 		}
 	}
+	macsec_device = get_macsec_device(ndev, &dev->macsec.macsec_devices_list);
+	mlx5_macsec_del_roce_rule(attr->index, dev->mdev->macsec_fs,
+				  &macsec_device->tx_rules_list, &macsec_device->rx_rules_list);
+	mlx5_macsec_del_roce_gid(macsec_device, attr->index);
+	cleanup_macsec_device(macsec_device);
+
+	dev_put(ndev);
+	mutex_unlock(&dev->macsec.lock);
 }
diff --git a/drivers/infiniband/hw/mlx5/macsec.h b/drivers/infiniband/hw/mlx5/macsec.h
index b60f8f046d6f..9b77ba90f0f4 100644
--- a/drivers/infiniband/hw/mlx5/macsec.h
+++ b/drivers/infiniband/hw/mlx5/macsec.h
@@ -14,12 +14,16 @@ struct mlx5_reserved_gids;
 
 int mlx5r_add_gid_macsec_operations(const struct ib_gid_attr *attr);
 void mlx5r_del_gid_macsec_operations(const struct ib_gid_attr *attr);
-int mlx5r_macsec_alloc_gids(struct mlx5_ib_dev *dev);
+int mlx5r_macsec_init_gids_and_devlist(struct mlx5_ib_dev *dev);
 void mlx5r_macsec_dealloc_gids(struct mlx5_ib_dev *dev);
+void mlx5r_macsec_event_register(struct mlx5_ib_dev *dev);
+void mlx5r_macsec_event_unregister(struct mlx5_ib_dev *dev);
 #else
 static inline int mlx5r_add_gid_macsec_operations(const struct ib_gid_attr *attr) { return 0; }
 static inline void mlx5r_del_gid_macsec_operations(const struct ib_gid_attr *attr) {}
-static inline int mlx5r_macsec_alloc_gids(struct mlx5_ib_dev *dev) { return 0; }
+static inline int mlx5r_macsec_init_gids_and_devlist(struct mlx5_ib_dev *dev) { return 0; }
 static inline void mlx5r_macsec_dealloc_gids(struct mlx5_ib_dev *dev) {}
+static inline void mlx5r_macsec_event_register(struct mlx5_ib_dev *dev) {}
+static inline void mlx5r_macsec_event_unregister(struct mlx5_ib_dev *dev) {}
 #endif
 #endif /* __MLX5_MACSEC_H__ */
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index f463cf8b7501..b4cc16a19757 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -3684,7 +3684,7 @@ static int mlx5_ib_stage_init_init(struct mlx5_ib_dev *dev)
 	if (err)
 		return err;
 
-	err = mlx5r_macsec_alloc_gids(dev);
+	err = mlx5r_macsec_init_gids_and_devlist(dev);
 	if (err)
 		return err;
 
@@ -4125,11 +4125,15 @@ static int mlx5_ib_stage_dev_notifier_init(struct mlx5_ib_dev *dev)
 {
 	dev->mdev_events.notifier_call = mlx5_ib_event;
 	mlx5_notifier_register(dev->mdev, &dev->mdev_events);
+
+	mlx5r_macsec_event_register(dev);
+
 	return 0;
 }
 
 static void mlx5_ib_stage_dev_notifier_cleanup(struct mlx5_ib_dev *dev)
 {
+	mlx5r_macsec_event_unregister(dev);
 	mlx5_notifier_unregister(dev->mdev, &dev->mdev_events);
 }
 
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index a4b940b5035f..16713baf0d06 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1090,6 +1090,12 @@ struct mlx5_special_mkeys {
 	__be32 terminate_scatter_list_mkey;
 };
 
+struct mlx5_macsec {
+	struct mutex lock; /* Protects mlx5_macsec internal contexts */
+	struct list_head macsec_devices_list;
+	struct notifier_block blocking_events_nb;
+};
+
 struct mlx5_ib_dev {
 	struct ib_device		ib_dev;
 	struct mlx5_core_dev		*mdev;
@@ -1149,6 +1155,10 @@ struct mlx5_ib_dev {
 	u16 pkey_table_len;
 	u8 lag_ports;
 	struct mlx5_special_mkeys mkeys;
+
+#ifdef CONFIG_MLX5_MACSEC
+	struct mlx5_macsec macsec;
+#endif
 };
 
 static inline struct mlx5_ib_cq *to_mibcq(struct mlx5_core_cq *mcq)
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 848993823ba5..38412457c617 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -1328,6 +1328,7 @@ static inline bool mlx5_get_roce_state(struct mlx5_core_dev *dev)
 	return mlx5_is_roce_on(dev);
 }
 
+#ifdef CONFIG_MLX5_MACSEC
 static inline bool mlx5e_is_macsec_device(const struct mlx5_core_dev *mdev)
 {
 	if (!(MLX5_CAP_GEN_64(mdev, general_obj_types) &
@@ -1366,11 +1367,12 @@ static inline bool mlx5_is_macsec_roce_supported(struct mlx5_core_dev *mdev)
 	if (((MLX5_CAP_GEN_2(mdev, flow_table_type_2_type) &
 	     NIC_RDMA_BOTH_DIRS_CAPS) != NIC_RDMA_BOTH_DIRS_CAPS) ||
 	     !MLX5_CAP_FLOWTABLE_RDMA_TX(mdev, max_modify_header_actions) ||
-	     !mlx5e_is_macsec_device(mdev))
+	     !mlx5e_is_macsec_device(mdev) || !mdev->macsec_fs)
 		return false;
 
 	return true;
 }
+#endif
 
 enum {
 	MLX5_OCTWORD = 16,
-- 
2.41.0

