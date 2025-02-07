Return-Path: <linux-rdma+bounces-7564-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4815DA2D02B
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 22:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 775313AA19A
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 21:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8212F1D8DE1;
	Fri,  7 Feb 2025 21:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b="pN/Apwzb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D6B1D5ACD;
	Fri,  7 Feb 2025 21:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738965347; cv=none; b=iZXxNoyUaKfZipGZAhEXgl3u92xSzXaA5irAsCSdTyrDGz4K+8vJnLqqiMhI8D1wYkHa/PxFxBDnt/yc5/JDs15u12Cggg1ds7X890yfhoCGRHLxQhYz//jG5OCcZcqMIdGMtTagzhwzscQDt/ByXx23NPAZvgNWhn11U8k5WjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738965347; c=relaxed/simple;
	bh=DEaQfMfCS5EbMYWZTnB/1GJqOjqgmbd3HfnVPMl6Eps=;
	h=From:To:Cc:Subject:Date:Message-Id; b=gdJ8+sWgnc/kwAlR1XA71mTiJIcF4tJOYcYmkF1E1as1OHZLCPz4Mx8tQOWL3E9TcfqGGaVVoBNGmNS9a0WtdxMmpDLmokvlMebpx8UgmlvWmCxBCtgnxYIdwu/URwnFLJGMqLdcTpr+eHp4gjHkyGVHWDSFsV+ZKLc6ql2qRYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b=pN/Apwzb; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id 230332107303; Fri,  7 Feb 2025 13:55:45 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 230332107303
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
	s=default; t=1738965345;
	bh=zGoGoi6t45nCBl+Xj4ERg8I1+Le+ahVKpWy2xKoqmCc=;
	h=From:To:Cc:Subject:Date:From;
	b=pN/ApwzbJp34FWBf77HoBAY06zmNyz6G3twEgZuj6fWxciNp+LY2bWeOGkSTzoVGI
	 VP2lSbX86mQ1K6xymBFYMjRq6fguSXlgsuxy2rayUpn06OtwHpt+owCoo96ZVQi6KJ
	 Tzq4ZVh5uy8NdhbjJTUwrx6ZpLmZNgUaiShmmCq4=
From: longli@linuxonhyperv.com
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Ajay Sharma <sharmaajay@microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	Long Li <longli@microsoft.com>
Subject: [PATCH net-next v3] hv_netvsc: Set device flags for properly indicating bonding in Hyper-V
Date: Fri,  7 Feb 2025 13:55:37 -0800
Message-Id: <1738965337-23085-1-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Long Li <longli@microsoft.com>

On Hyper-V platforms, a slave VF netdev always bonds to Netvsc and remains
as Netvsc's only active slave as long as the slave device is present. This
behavior is the same as a bonded device, but it's not user-configurable.

Some kernel APIs (e.g those in "include/linux/netdevice.h") check for
IFF_MASTER, IFF_SLAVE and IFF_BONDING for determing if those are used in
a master/slave bonded setup. Netvsc's bonding setup with its slave device
falls into this category.

The security implication of this behavior is the same as if bonding is
configured from the user-mode for the bonding device. It's an invalid
configuration if a user attempts to configure different permissions or
to setup for different containers for netvsc and its slave device, as the
bonding is mandatory for slave device to function under Hyper-V/Azure
environment. The user must assume the kernel will always bond and
configure netvsc and its slave device to the same permission/constraint
as if they are used as a single device.

Make hv_netvsc properly indicate bonding with its slave and change the
relevant kernel API to reflect this bonding setup.

Signed-off-by: Long Li <longli@microsoft.com>
---
Change log
v2: instead of re-using IFF_BOND, introduce permanent_bond in netdev
v3: rename permanent_bond to kernel_bond, add details in commit on security implications

 drivers/net/hyperv/netvsc_drv.c | 11 +++++++++++
 include/linux/netdevice.h       |  9 +++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index d6c4abfc3a28..035869b02fde 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -2204,6 +2204,10 @@ static int netvsc_vf_join(struct net_device *vf_netdev,
 		goto rx_handler_failed;
 	}
 
+	vf_netdev->kernel_bond = 1;
+	ndev->kernel_bond = 1;
+	ndev->flags |= IFF_MASTER;
+
 	ret = netdev_master_upper_dev_link(vf_netdev, ndev,
 					   NULL, NULL, NULL);
 	if (ret != 0) {
@@ -2484,6 +2488,13 @@ static int netvsc_unregister_vf(struct net_device *vf_netdev)
 
 	reinit_completion(&net_device_ctx->vf_add);
 	netdev_rx_handler_unregister(vf_netdev);
+
+	/* Unlink the slave device and clear flag */
+	vf_netdev->kernel_bond = 0;
+	ndev->kernel_bond = 0;
+	vf_netdev->flags &= ~IFF_SLAVE;
+	ndev->flags &= ~IFF_MASTER;
+
 	netdev_upper_dev_unlink(vf_netdev, ndev);
 	RCU_INIT_POINTER(net_device_ctx->vf_netdev, NULL);
 	dev_put(vf_netdev);
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index ecc686409161..5befb0e23585 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1997,6 +1997,8 @@ enum netdev_reg_state {
  *	@change_proto_down: device supports setting carrier via IFLA_PROTO_DOWN
  *	@netns_local: interface can't change network namespaces
  *	@fcoe_mtu:	device supports maximum FCoE MTU, 2158 bytes
+ *	@kernel_bond:	device is auto bonded to another device without user
+ *			configuration
  *
  *	@net_notifier_list:	List of per-net netdev notifier block
  *				that follow this device when it is moved
@@ -2402,6 +2404,7 @@ struct net_device {
 	unsigned long		change_proto_down:1;
 	unsigned long		netns_local:1;
 	unsigned long		fcoe_mtu:1;
+	unsigned long		kernel_bond:1;
 
 	struct list_head	net_notifier_list;
 
@@ -5150,12 +5153,14 @@ static inline bool netif_is_macvlan_port(const struct net_device *dev)
 
 static inline bool netif_is_bond_master(const struct net_device *dev)
 {
-	return dev->flags & IFF_MASTER && dev->priv_flags & IFF_BONDING;
+	return dev->flags & IFF_MASTER &&
+		(dev->priv_flags & IFF_BONDING || dev->kernel_bond);
 }
 
 static inline bool netif_is_bond_slave(const struct net_device *dev)
 {
-	return dev->flags & IFF_SLAVE && dev->priv_flags & IFF_BONDING;
+	return dev->flags & IFF_SLAVE &&
+		(dev->priv_flags & IFF_BONDING || dev->kernel_bond);
 }
 
 static inline bool netif_supports_nofcs(struct net_device *dev)
-- 
2.34.1


