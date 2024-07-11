Return-Path: <linux-rdma+bounces-3823-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C98092E9B5
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2024 15:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E4CA1C20F88
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2024 13:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6393115F318;
	Thu, 11 Jul 2024 13:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="XC9fIpH/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1BD34CE09;
	Thu, 11 Jul 2024 13:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720705084; cv=none; b=lgBAkNToDJRW1th1dVlMBPWOWECUTyh5RtSQ+0z8OUqMdHCIIIvKrcNro2b1OSrjShdS4OkNd5FReHqiNrVCwTYs1RjVAjADEQuJKlBZ1MBZ5lAY024U2OIAtKWEtgiSYLV5oxYjZXb2wZZENFMs4UulwZgVyID5n/Ke4ohcXnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720705084; c=relaxed/simple;
	bh=+lpvg91EuVmo4l6WbNPi0rA3weAObdsfpM9GbOYSK4Y=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Vz9Eh7Rjb7QZoV0sge/VMMpglpp44FEE6vEl+Bs7wmWisS/aGsa6hklQcZX8YgRx6CX1fWF++ypu6P5nAbwqdTcKD8/BZDJAVY+KxbAbaOxV3ILXdyodzZB+1F3RTJqkaSb74ejIvj8l6Z8qvP2vEr/Kgzu2E9tC1b5yW1utphU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=XC9fIpH/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 32BD020B7165;
	Thu, 11 Jul 2024 06:38:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 32BD020B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1720705082;
	bh=E8vCEReVfg+1Pp/llNttYBBSJa9eYonYgDLL3JxqQxg=;
	h=From:To:Cc:Subject:Date:From;
	b=XC9fIpH/5l/+ozrdPr6ij4Q4Nrb0fheFEQZzyAhw7Z+hF9as0VuUwics1dfwKw3Vh
	 Rn92l6DuIwd+uayCTM1PYkG/CmLK+PVu1jrcLqg6uB+BbJkeP5fhxRbxe740tKBDBw
	 e/FEL/a5LmJK2pSadPNb7AafjSSuFfBWLYcSaLqI=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	pabeni@redhat.com,
	haiyangz@microsoft.com,
	kys@microsoft.com,
	edumazet@google.com,
	kuba@kernel.org,
	davem@davemloft.net,
	decui@microsoft.com,
	wei.liu@kernel.org,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH rdma-next v3 1/1] RDMA/mana_ib: Set correct device into ib
Date: Thu, 11 Jul 2024 06:37:57 -0700
Message-Id: <1720705077-322-1-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

Add mana_get_primary_netdev_rcu helper to get a primary
netdevice for a given port. When mana is used with
netvsc, the VF netdev is controlled by an upper netvsc
device. In a baremetal case, the VF netdev is the
primary device.

Use the mana_get_primary_netdev_rcu() helper in the mana_ib
to get the correct device for querying network states.

Fixes: 8b184e4f1c32 ("RDMA/mana_ib: Enable RoCE on port 1")
Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
---
I would appreciate if I could get Acks on it from:
* netvsc maintainers (e.g., Haiyang)
* net maintainers (e.g., Jakub, David, Eric, Paolo)

v1->v2:
Leon Romanovsky asked to make a helper in the net/mana and get
acks from net maintainers.
v2->v3:
Added warn on rcu lock not held. 
Use the word "primary" instead of "master"
Merged two commits into one and submitted to rdma-next

 drivers/infiniband/hw/mana/device.c           | 16 ++++++++--------
 drivers/net/ethernet/microsoft/mana/mana_en.c | 19 +++++++++++++++++++
 include/net/mana/mana.h                       |  2 ++
 3 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/mana/device.c b/drivers/infiniband/hw/mana/device.c
index b07a8e2e838f..7ac01918ef7c 100644
--- a/drivers/infiniband/hw/mana/device.c
+++ b/drivers/infiniband/hw/mana/device.c
@@ -56,7 +56,7 @@ static int mana_ib_probe(struct auxiliary_device *adev,
 {
 	struct mana_adev *madev = container_of(adev, struct mana_adev, adev);
 	struct gdma_dev *mdev = madev->mdev;
-	struct net_device *upper_ndev;
+	struct net_device *ndev;
 	struct mana_context *mc;
 	struct mana_ib_dev *dev;
 	u8 mac_addr[ETH_ALEN];
@@ -84,17 +84,17 @@ static int mana_ib_probe(struct auxiliary_device *adev,
 	dev->ib_dev.num_comp_vectors = mdev->gdma_context->max_num_queues;
 	dev->ib_dev.dev.parent = mdev->gdma_context->dev;
 
-	rcu_read_lock(); /* required to get upper dev */
-	upper_ndev = netdev_master_upper_dev_get_rcu(mc->ports[0]);
-	if (!upper_ndev) {
+	rcu_read_lock(); /* required to get primary netdev */
+	ndev = mana_get_primary_netdev_rcu(mc, 0);
+	if (!ndev) {
 		rcu_read_unlock();
 		ret = -ENODEV;
-		ibdev_err(&dev->ib_dev, "Failed to get master netdev");
+		ibdev_err(&dev->ib_dev, "Failed to get netdev for IB port 1");
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
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index b89ad4afd66e..68c2bea2c022 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -3007,3 +3007,22 @@ void mana_remove(struct gdma_dev *gd, bool suspending)
 	gd->gdma_context = NULL;
 	kfree(ac);
 }
+
+struct net_device *mana_get_primary_netdev_rcu(struct mana_context *ac, u32 port_index)
+{
+	struct net_device *ndev;
+
+	RCU_LOCKDEP_WARN(!rcu_read_lock_held(),
+			 "Taking primary netdev without holding the RCU read lock");
+	if (port_index >= ac->num_ports)
+		return NULL;
+
+	/* When mana is used in netvsc, the upper netdevice should be returned. */
+	if (ac->ports[port_index]->flags & IFF_SLAVE)
+		ndev = netdev_master_upper_dev_get_rcu(ac->ports[port_index]);
+	else
+		ndev = ac->ports[port_index];
+
+	return ndev;
+}
+EXPORT_SYMBOL_NS(mana_get_primary_netdev_rcu, NET_MANA);
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index 59823901b74f..f9b4b0dcb69f 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -797,4 +797,6 @@ void mana_destroy_wq_obj(struct mana_port_context *apc, u32 wq_type,
 int mana_cfg_vport(struct mana_port_context *apc, u32 protection_dom_id,
 		   u32 doorbell_pg_id);
 void mana_uncfg_vport(struct mana_port_context *apc);
+
+struct net_device *mana_get_primary_netdev_rcu(struct mana_context *ac, u32 port_index);
 #endif /* _MANA_H */
-- 
2.43.0


