Return-Path: <linux-rdma+bounces-12294-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6AEB0A080
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Jul 2025 12:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B04E5A544B
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Jul 2025 10:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405C6299A96;
	Fri, 18 Jul 2025 10:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Zk6oHOd0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620F7218EA8;
	Fri, 18 Jul 2025 10:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752834051; cv=none; b=oiHdHpjSOyX7ts5/eJnUUbR+lURxjR1A026KlkDGkXfLGdQj577CqeKmzCHW4xtY+xM2d93kv/KjtTJcIZaKSqavpyC8wCQo3wQLiEYM7qn+BBtJBldGmkrkxAn4xen0lvsSL+FBY86tZvu3JCR51tZF3X4pAwHYhHi5t8YnQwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752834051; c=relaxed/simple;
	bh=Fc4HWWcuM5AGQrRuqZHDXysN7AmEvHaXRYlOpCWP8ss=;
	h=From:To:Cc:Subject:Date:Message-Id; b=N8OKiY5GnKCLwEH0BpzX4YuEaBkrMaz29RmJ69kxlDnySLGIM6hbDHTds6npvl/uG4cTE2wOjL6BVXqJc5PT5yn7OoUMyP2q9FidsfY43iW8Zo4ojvvA6i5P9LX9a5PtOGlDQGSMyg4J4+iYqqXKbjWORX1ZnVs5NYLDSurDwMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Zk6oHOd0; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1186)
	id AD0702114253; Fri, 18 Jul 2025 03:20:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AD0702114253
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1752834048;
	bh=2yZL1sxeUy5FJOB8LH1hmtT4+28g4InGn+OK2WmQz40=;
	h=From:To:Cc:Subject:Date:From;
	b=Zk6oHOd0k8kM4QYYpDS0FXJd0sC6AedDd/BF/Zqtbw4i0vdc41q824H6+MYNufEwE
	 xL9QKfA/9W5g4rcEJV/Xj1/tHpK4UTGyLDLWGWbQOY4p0oZD8td37zKMwLyYQY5BjT
	 HogGqwA2Y2DiDiI8lIUO4vgipseTF4+eZQYJ8cXw=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next 1/1] RDMA/mana_ib: add support of multiple ports
Date: Fri, 18 Jul 2025 03:20:48 -0700
Message-Id: <1752834048-31696-1-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

If the HW indicates support of multiple ports for rdma, create an IB device
with a port per netdev in the ethernet mana driver.

CM is only available on port 1, but RC QPs are supported on all
ports.

Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
---
 drivers/infiniband/hw/mana/device.c  | 107 +++++++++++++--------------
 drivers/infiniband/hw/mana/main.c    |  13 +++-
 drivers/infiniband/hw/mana/mana_ib.h |   1 +
 3 files changed, 64 insertions(+), 57 deletions(-)

diff --git a/drivers/infiniband/hw/mana/device.c b/drivers/infiniband/hw/mana/device.c
index 65d0af740..f322f0d17 100644
--- a/drivers/infiniband/hw/mana/device.c
+++ b/drivers/infiniband/hw/mana/device.c
@@ -77,28 +77,30 @@ static int mana_ib_netdev_event(struct notifier_block *this,
 	struct gdma_context *gc = dev->gdma_dev->gdma_context;
 	struct mana_context *mc = gc->mana.driver_data;
 	struct net_device *ndev;
+	int i;
 
 	/* Only process events from our parent device */
-	if (event_dev != mc->ports[0])
-		return NOTIFY_DONE;
-
-	switch (event) {
-	case NETDEV_CHANGEUPPER:
-		ndev = mana_get_primary_netdev(mc, 0, &dev->dev_tracker);
-		/*
-		 * RDMA core will setup GID based on updated netdev.
-		 * It's not possible to race with the core as rtnl lock is being
-		 * held.
-		 */
-		ib_device_set_netdev(&dev->ib_dev, ndev, 1);
-
-		/* mana_get_primary_netdev() returns ndev with refcount held */
-		netdev_put(ndev, &dev->dev_tracker);
-
-		return NOTIFY_OK;
-	default:
-		return NOTIFY_DONE;
-	}
+	for (i = 0; i < dev->ib_dev.phys_port_cnt; i++)
+		if (event_dev == mc->ports[i]) {
+			switch (event) {
+			case NETDEV_CHANGEUPPER:
+				ndev = mana_get_primary_netdev(mc, i, &dev->dev_tracker);
+				/*
+				 * RDMA core will setup GID based on updated netdev.
+				 * It's not possible to race with the core as rtnl lock is being
+				 * held.
+				 */
+				ib_device_set_netdev(&dev->ib_dev, ndev, i + 1);
+
+				/* mana_get_primary_netdev() returns ndev with refcount held */
+				netdev_put(ndev, &dev->dev_tracker);
+
+				return NOTIFY_OK;
+			default:
+				return NOTIFY_DONE;
+			}
+		}
+	return NOTIFY_DONE;
 }
 
 static int mana_ib_probe(struct auxiliary_device *adev,
@@ -111,7 +113,7 @@ static int mana_ib_probe(struct auxiliary_device *adev,
 	struct net_device *ndev;
 	struct mana_ib_dev *dev;
 	u8 mac_addr[ETH_ALEN];
-	int ret;
+	int ret, i;
 
 	dev = ib_alloc_device(mana_ib_dev, ib_dev);
 	if (!dev)
@@ -126,34 +128,11 @@ static int mana_ib_probe(struct auxiliary_device *adev,
 
 	if (mana_ib_is_rnic(dev)) {
 		dev->ib_dev.phys_port_cnt = 1;
-		ndev = mana_get_primary_netdev(mc, 0, &dev->dev_tracker);
-		if (!ndev) {
-			ret = -ENODEV;
-			ibdev_err(&dev->ib_dev, "Failed to get netdev for IB port 1");
-			goto free_ib_device;
-		}
-		ether_addr_copy(mac_addr, ndev->dev_addr);
-		addrconf_addr_eui48((u8 *)&dev->ib_dev.node_guid, ndev->dev_addr);
-		ret = ib_device_set_netdev(&dev->ib_dev, ndev, 1);
-		/* mana_get_primary_netdev() returns ndev with refcount held */
-		netdev_put(ndev, &dev->dev_tracker);
-		if (ret) {
-			ibdev_err(&dev->ib_dev, "Failed to set ib netdev, ret %d", ret);
-			goto free_ib_device;
-		}
-
-		dev->nb.notifier_call = mana_ib_netdev_event;
-		ret = register_netdevice_notifier(&dev->nb);
-		if (ret) {
-			ibdev_err(&dev->ib_dev, "Failed to register net notifier, %d",
-				  ret);
-			goto free_ib_device;
-		}
-
+		addrconf_addr_eui48((u8 *)&dev->ib_dev.node_guid, mc->ports[0]->dev_addr);
 		ret = mana_ib_gd_query_adapter_caps(dev);
 		if (ret) {
 			ibdev_err(&dev->ib_dev, "Failed to query device caps, ret %d", ret);
-			goto deregister_net_notifier;
+			goto free_ib_device;
 		}
 
 		ib_set_device_ops(&dev->ib_dev, &mana_ib_stats_ops);
@@ -163,16 +142,36 @@ static int mana_ib_probe(struct auxiliary_device *adev,
 		ret = mana_ib_create_eqs(dev);
 		if (ret) {
 			ibdev_err(&dev->ib_dev, "Failed to create EQs, ret %d", ret);
-			goto deregister_net_notifier;
+			goto free_ib_device;
 		}
 
 		ret = mana_ib_gd_create_rnic_adapter(dev);
 		if (ret)
 			goto destroy_eqs;
 
-		ret = mana_ib_gd_config_mac(dev, ADDR_OP_ADD, mac_addr);
+		if (dev->adapter_caps.feature_flags & MANA_IB_FEATURE_MULTI_PORTS_SUPPORT)
+			dev->ib_dev.phys_port_cnt = mc->num_ports;
+
+		for (i = 0; i < dev->ib_dev.phys_port_cnt; i++) {
+			ndev = mana_get_primary_netdev(mc, i, &dev->dev_tracker);
+			ether_addr_copy(mac_addr, ndev->dev_addr);
+			ret = ib_device_set_netdev(&dev->ib_dev, ndev, i + 1);
+			/* mana_get_primary_netdev() returns ndev with refcount held */
+			netdev_put(ndev, &dev->dev_tracker);
+			if (ret) {
+				ibdev_err(&dev->ib_dev, "Failed to set ib netdev, ret %d", ret);
+				goto destroy_rnic;
+			}
+			ret = mana_ib_gd_config_mac(dev, ADDR_OP_ADD, mac_addr);
+			if (ret) {
+				ibdev_err(&dev->ib_dev, "Failed to add Mac address, ret %d", ret);
+				goto destroy_rnic;
+			}
+		}
+		dev->nb.notifier_call = mana_ib_netdev_event;
+		ret = register_netdevice_notifier(&dev->nb);
 		if (ret) {
-			ibdev_err(&dev->ib_dev, "Failed to add Mac address, ret %d", ret);
+			ibdev_err(&dev->ib_dev, "Failed to register net notifier, %d", ret);
 			goto destroy_rnic;
 		}
 	} else {
@@ -188,7 +187,7 @@ static int mana_ib_probe(struct auxiliary_device *adev,
 				       MANA_AV_BUFFER_SIZE, 0);
 	if (!dev->av_pool) {
 		ret = -ENOMEM;
-		goto destroy_rnic;
+		goto deregister_net_notifier;
 	}
 
 	ibdev_dbg(&dev->ib_dev, "mdev=%p id=%d num_ports=%d\n", mdev,
@@ -205,15 +204,15 @@ static int mana_ib_probe(struct auxiliary_device *adev,
 
 deallocate_pool:
 	dma_pool_destroy(dev->av_pool);
+deregister_net_notifier:
+	if (mana_ib_is_rnic(dev))
+		unregister_netdevice_notifier(&dev->nb);
 destroy_rnic:
 	if (mana_ib_is_rnic(dev))
 		mana_ib_gd_destroy_rnic_adapter(dev);
 destroy_eqs:
 	if (mana_ib_is_rnic(dev))
 		mana_ib_destroy_eqs(dev);
-deregister_net_notifier:
-	if (mana_ib_is_rnic(dev))
-		unregister_netdevice_notifier(&dev->nb);
 free_ib_device:
 	xa_destroy(&dev->qp_table_wq);
 	ib_dealloc_device(&dev->ib_dev);
@@ -227,9 +226,9 @@ static void mana_ib_remove(struct auxiliary_device *adev)
 	ib_unregister_device(&dev->ib_dev);
 	dma_pool_destroy(dev->av_pool);
 	if (mana_ib_is_rnic(dev)) {
+		unregister_netdevice_notifier(&dev->nb);
 		mana_ib_gd_destroy_rnic_adapter(dev);
 		mana_ib_destroy_eqs(dev);
-		unregister_netdevice_notifier(&dev->nb);
 	}
 	xa_destroy(&dev->qp_table_wq);
 	ib_dealloc_device(&dev->ib_dev);
diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index 41a24a186..6a2471f2e 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -563,8 +563,14 @@ int mana_ib_get_port_immutable(struct ib_device *ibdev, u32 port_num,
 	immutable->gid_tbl_len = attr.gid_tbl_len;
 
 	if (mana_ib_is_rnic(dev)) {
-		immutable->core_cap_flags = RDMA_CORE_PORT_IBA_ROCE_UDP_ENCAP;
-		immutable->max_mad_size = IB_MGMT_MAD_SIZE;
+		if (port_num == 1) {
+			immutable->core_cap_flags = RDMA_CORE_PORT_IBA_ROCE_UDP_ENCAP;
+			immutable->max_mad_size = IB_MGMT_MAD_SIZE;
+		} else {
+			immutable->core_cap_flags = RDMA_CORE_CAP_PROT_ROCE_UDP_ENCAP
+						    | RDMA_CORE_CAP_ETH_AH;
+			immutable->max_mad_size = 0;
+		}
 	} else {
 		immutable->core_cap_flags = RDMA_CORE_PORT_RAW_PACKET;
 	}
@@ -633,8 +639,9 @@ int mana_ib_query_port(struct ib_device *ibdev, u32 port,
 	props->pkey_tbl_len = 1;
 	if (mana_ib_is_rnic(dev)) {
 		props->gid_tbl_len = 16;
-		props->port_cap_flags = IB_PORT_CM_SUP;
 		props->ip_gids = true;
+		if (port == 1)
+			props->port_cap_flags = IB_PORT_CM_SUP;
 	}
 
 	return 0;
diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index 369825fde..e782dc7f1 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -220,6 +220,7 @@ struct mana_ib_query_adapter_caps_req {
 enum mana_ib_adapter_features {
 	MANA_IB_FEATURE_CLIENT_ERROR_CQE_SUPPORT = BIT(4),
 	MANA_IB_FEATURE_DEV_COUNTERS_SUPPORT = BIT(5),
+	MANA_IB_FEATURE_MULTI_PORTS_SUPPORT = BIT(6),
 };
 
 struct mana_ib_query_adapter_caps_resp {
-- 
2.43.0


