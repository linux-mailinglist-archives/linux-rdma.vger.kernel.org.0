Return-Path: <linux-rdma+bounces-3592-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D3691E00E
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jul 2024 15:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA4E51C22361
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jul 2024 13:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7D315AD95;
	Mon,  1 Jul 2024 13:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="YtxkMS04"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D43F12A14C;
	Mon,  1 Jul 2024 13:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719838812; cv=none; b=ZAzVDfpHqAaTGmlnKP/xIgqCEjhhuLJXPLUM4BxQCO4kjSOqWJvhoLeM4Abf6RAIHS5qU/XhVzlcAw7zqPLBhiXG07SQvf7wB/XBhOUdjY071SelDhvZKqdNXUUB95UFst+wuelOLXVIT1B/onN5oO9rC7N/6vZfmHY2fVPa+f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719838812; c=relaxed/simple;
	bh=fvg55UAyCbixNpWDhBwp70HzeuqTEa86y9ptiLaOTe0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=p8WYXBCDaJZMxT/rluHn7acePKHMEuBqz+7zAxdUjmcGcWr1xjp8wxeI1UNW214noSyvFl6GVT//wLUeP11KH/PK98fdhwf7B5P2I+KvdInsqYzaieafOK+ylxYqS2NJGaxZ3HhhorGBQrqw7yc2NAfAXLa5gAdSn2wizw9vjGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=YtxkMS04; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5480620B7007;
	Mon,  1 Jul 2024 06:00:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5480620B7007
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1719838805;
	bh=L9t7pIPzPufTt4OieYYA15R2jzazJD091E+gG3PzcXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YtxkMS04czy92mDOIpdew7JTqIuD27Bt9N1CmgaVm7c8AquCuQf2g3AE6SjhD4OTD
	 deDiQ3jrjTzSrpOCWlaj4lCjwo20U4lWRWFAbE/3VLt3WgcwgU0ZL7B2d3BtWUrHz0
	 SNyebq+itERDTDmYD69RRY+eF94deBCVdA3PhlRk=
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
Subject: [PATCH net-next v2 2/2] RDMA/mana_ib: Set correct device into ib
Date: Mon,  1 Jul 2024 05:58:56 -0700
Message-Id: <1719838736-20338-3-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1719838736-20338-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1719838736-20338-1-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

Use the mana_get_master_netdev_rcu() helper to get
a master netdevice for querying network states.
The helper allows the mana_ib transparently
support baremetal and netvsc deployment cases.

Fixes: 8b184e4f1c32 ("RDMA/mana_ib: Enable RoCE on port 1")
Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
---
 drivers/infiniband/hw/mana/device.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/mana/device.c b/drivers/infiniband/hw/mana/device.c
index b07a8e2..ec849ac 100644
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
+	rcu_read_lock(); /* required to get master dev */
+	ndev = mana_get_master_netdev_rcu(mc, 0);
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
-- 
2.43.0


