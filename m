Return-Path: <linux-rdma+bounces-3472-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4107B91653F
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jun 2024 12:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F18C71F22A4F
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jun 2024 10:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645AE14A0BC;
	Tue, 25 Jun 2024 10:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="esiHAULv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7474143883;
	Tue, 25 Jun 2024 10:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719311314; cv=none; b=WaLA1msL7DcGM7aRblycscFzlrHVUaKwhVuiuYtxDAjpWrbNWaqiMedlFavEKbQyI+cbazXXUSsMvuGMutAkspCTVD7JEMxaWnc/89/RzwlLvR02vOSmakMu0oQc2rE5yG1IDdzYBe31a2QG3TLWpaJ9eH3Ho0nCxsS59PW3sl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719311314; c=relaxed/simple;
	bh=RI7qludrxXimz31r7XsiMrolnshXtD08wPXrkVtx1Y4=;
	h=From:To:Cc:Subject:Date:Message-Id; b=iztGP6056BWhGOB3gtMiyWBLz7hcz9UNpKnie95mO1aM7bagKgjuKRWGtBqFyAjMu1g55C5ayhDDbANwQkqU70jhL7YiQt3xQ++dW9iPusbWBJXFQVXzOnJCwEluSAkpebb3AAJCkwdERxYossq69/xkrmP7+o2kRLkenDysr0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=esiHAULv; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 61CEB20B7001;
	Tue, 25 Jun 2024 03:28:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 61CEB20B7001
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1719311312;
	bh=Py1iB/Mm9WOY3l87ATzM0up6RXYOz/P+zv8MYkZ8b+o=;
	h=From:To:Cc:Subject:Date:From;
	b=esiHAULv7jB/xxgWWzwILpS6Cxho2bhw69fri3Di2ab3fQgVBvkDUuOM8qeuO5wMA
	 9VP4P/wHNta7a0LX2ELdwWZrVCAUnfEp12nCoYOjCWG7LnuYvVA3D5Oh/2Q4zrnF5p
	 IAM5eHUvOwHH1AvFKRXq3WQkUdg1mwlHjERLiP5k=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	weh@microsoft.com,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next 1/1] RDMA/mana_ib: Set correct device into ib
Date: Tue, 25 Jun 2024 03:28:27 -0700
Message-Id: <1719311307-7920-1-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

When mc->ports[0] is not slave, use it in the set_netdev.
When mana is used in netvsc, the stored net devices in mana
are slaves and GIDs should be taken from their master devices.
In the baremetal case, the mc->ports devices will not be slaves.

Fixes: 8b184e4f1c32 ("RDMA/mana_ib: Enable RoCE on port 1")
Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
---
 drivers/infiniband/hw/mana/device.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/mana/device.c b/drivers/infiniband/hw/mana/device.c
index b07a8e2e838f..5395306a86e8 100644
--- a/drivers/infiniband/hw/mana/device.c
+++ b/drivers/infiniband/hw/mana/device.c
@@ -11,6 +11,8 @@ MODULE_DESCRIPTION("Microsoft Azure Network Adapter IB driver");
 MODULE_LICENSE("GPL");
 MODULE_IMPORT_NS(NET_MANA);
 
+#define mana_ndev_is_slave(dev)   (((dev)->flags & IFF_SLAVE) == IFF_SLAVE)
+
 static const struct ib_device_ops mana_ib_dev_ops = {
 	.owner = THIS_MODULE,
 	.driver_id = RDMA_DRIVER_MANA,
@@ -56,7 +58,7 @@ static int mana_ib_probe(struct auxiliary_device *adev,
 {
 	struct mana_adev *madev = container_of(adev, struct mana_adev, adev);
 	struct gdma_dev *mdev = madev->mdev;
-	struct net_device *upper_ndev;
+	struct net_device *ndev;
 	struct mana_context *mc;
 	struct mana_ib_dev *dev;
 	u8 mac_addr[ETH_ALEN];
@@ -85,16 +87,19 @@ static int mana_ib_probe(struct auxiliary_device *adev,
 	dev->ib_dev.dev.parent = mdev->gdma_context->dev;
 
 	rcu_read_lock(); /* required to get upper dev */
-	upper_ndev = netdev_master_upper_dev_get_rcu(mc->ports[0]);
-	if (!upper_ndev) {
+	if (mana_ndev_is_slave(mc->ports[0]))
+		ndev = netdev_master_upper_dev_get_rcu(mc->ports[0]);
+	else
+		ndev = mc->ports[0];
+	if (!ndev) {
 		rcu_read_unlock();
 		ret = -ENODEV;
-		ibdev_err(&dev->ib_dev, "Failed to get master netdev");
+		ibdev_err(&dev->ib_dev, "Failed to get netdev for port 1");
 		goto free_ib_device;
 	}
-	ether_addr_copy(mac_addr, upper_ndev->dev_addr);
-	addrconf_addr_eui48((u8 *)&dev->ib_dev.node_guid, upper_ndev->dev_addr);
-	ret = ib_device_set_netdev(&dev->ib_dev, upper_ndev, 1);
+	ether_addr_copy(mac_addr, ndev->dev_addr);
+	addrconf_addr_eui48((u8 *)&dev->ib_dev.node_guid, ndev->dev_addr);
+	ret = ib_device_set_netdev(&dev->ib_dev, ndev, 1);
 	rcu_read_unlock();
 	if (ret) {
 		ibdev_err(&dev->ib_dev, "Failed to set ib netdev, ret %d", ret);
-- 
2.43.0


