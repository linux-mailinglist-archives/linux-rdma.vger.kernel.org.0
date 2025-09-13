Return-Path: <linux-rdma+bounces-13334-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2F3B55FB7
	for <lists+linux-rdma@lfdr.de>; Sat, 13 Sep 2025 11:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E95D1B26EF7
	for <lists+linux-rdma@lfdr.de>; Sat, 13 Sep 2025 09:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255252EA730;
	Sat, 13 Sep 2025 09:06:29 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1E12E8E14
	for <linux-rdma@vger.kernel.org>; Sat, 13 Sep 2025 09:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757754388; cv=none; b=lqsZw7zK4FKkDHWF9+MEZr+kvQgMO50MoBbBsACE6SjaraZs7yo/RqA7yNu8cOHP8dc9+KuCyFIA/G+SJSSld0Ej+pf+7LZZm7sMA3sAMutdA7Yfz/mexe2J6nfRvC6RaXAQHCbIdpmxM4Ndu0A+qyaJ7BY36CSjPwV8zjHEyhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757754388; c=relaxed/simple;
	bh=NvQfoGlCU6JEAusaMzUd11X0SLXefGdP96y9NXQtk6s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Go7F+FpnBX/KWIF7oXglgTnCSoFBShR9h+Xw36QuRH/tUuGbW0Uhh4erWwBHbi7uTrdFEQG4gHKalrQ1BIQ5NRk+5Dh1u6lV+bYQ70EDc4BZrVq03k5hsHH8v95GvL1sAJD9p8ZwAxbpBnbrkIA+i7rJTivE6MzZ2XkUO5p3cwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4cP50y5MHCz2VRf6;
	Sat, 13 Sep 2025 17:02:58 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 744E01A016C;
	Sat, 13 Sep 2025 17:06:18 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 13 Sep 2025 17:06:17 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<huangjunxian6@hisilicon.com>, <tangchengchang@huawei.com>
Subject: [PATCH for-next 7/8] RDMA/hns: Support link state reporting for bond
Date: Sat, 13 Sep 2025 17:06:14 +0800
Message-ID: <20250913090615.212720-8-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250913090615.212720-1-huangjunxian6@hisilicon.com>
References: <20250913090615.212720-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemf100018.china.huawei.com (7.202.181.17)

The link state of bond depends on the upper device. Adapt current
link state querying flow and ib_event dispatching flow to report
correct link state of bond.

Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 10 +++
 drivers/infiniband/hw/hns/hns_roce_main.c  | 89 ++++++++++++++++------
 2 files changed, 75 insertions(+), 24 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index f1145f57bb3a..ebd0c5f38bc2 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -7386,10 +7386,20 @@ static void hns_roce_hw_v2_link_status_change(struct hnae3_handle *handle,
 {
 	struct hns_roce_dev *hr_dev = (struct hns_roce_dev *)handle->priv;
 	struct net_device *netdev = handle->rinfo.netdev;
+	struct hns_roce_bond_group *bond_grp;
+	u8 bus_num;
 
 	if (linkup || !hr_dev)
 		return;
 
+	/* For bond device, the link status depends on the upper netdev,
+	 * and the upper device's link status depends on all the slaves'
+	 * netdev but not only one. So bond device cannot get a correct
+	 * link status from this path.
+	 */
+	if (hns_roce_get_bond_grp(netdev, get_hr_bus_num(hr_dev)))
+		return;
+
 	ib_dispatch_port_state_event(&hr_dev->ib_dev, netdev);
 }
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index f7ef563d8239..eeb8c4bdae32 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -89,30 +89,66 @@ static int hns_roce_del_gid(const struct ib_gid_attr *attr, void **context)
 	return ret;
 }
 
-static int handle_en_event(struct hns_roce_dev *hr_dev, u32 port,
-			   unsigned long event)
+static int get_upper_port_state(struct hns_roce_dev *hr_dev,
+				enum ib_port_state *state)
 {
+	struct net_device *net_dev = get_hr_netdev(hr_dev, 0);
+	struct hns_roce_bond_group *bond_grp;
+	u8 bus_num = get_hr_bus_num(hr_dev);
+
+	bond_grp = hns_roce_get_bond_grp(net_dev, bus_num);
+	if (!bond_grp)
+		return -ENODEV;
+
+	*state = ib_get_curr_port_state(bond_grp->upper_dev);
+
+	return 0;
+}
+
+static int handle_en_event(struct net_device *netdev,
+			   struct hns_roce_dev *hr_dev,
+			   u32 port, unsigned long event)
+{
+	struct ib_device *ibdev = &hr_dev->ib_dev;
 	struct device *dev = hr_dev->dev;
-	struct net_device *netdev;
+	enum ib_port_state curr_state;
+	struct ib_event ibevent;
 	int ret = 0;
 
-	netdev = hr_dev->iboe.netdevs[port];
 	if (!netdev) {
 		dev_err(dev, "can't find netdev on port(%u)!\n", port);
 		return -ENODEV;
 	}
 
 	switch (event) {
-	case NETDEV_UP:
-	case NETDEV_CHANGE:
 	case NETDEV_REGISTER:
 	case NETDEV_CHANGEADDR:
 		ret = hns_roce_set_mac(hr_dev, port, netdev->dev_addr);
 		break;
+	case NETDEV_UP:
+	case NETDEV_CHANGE:
+		ret = hns_roce_set_mac(hr_dev, port, netdev->dev_addr);
+		if (ret)
+			return ret;
+		fallthrough;
 	case NETDEV_DOWN:
-		/*
-		 * In v1 engine, only support all ports closed together.
-		 */
+		if (!netif_is_lag_master(netdev))
+			break;
+		curr_state = ib_get_curr_port_state(netdev);
+
+		write_lock_irq(&ibdev->cache_lock);
+		if (ibdev->port_data[port].cache.last_port_state == curr_state) {
+			write_unlock_irq(&ibdev->cache_lock);
+			return 0;
+		}
+		ibdev->port_data[port].cache.last_port_state = curr_state;
+		write_unlock_irq(&ibdev->cache_lock);
+
+		ibevent.event = (curr_state == IB_PORT_DOWN) ?
+				IB_EVENT_PORT_ERR : IB_EVENT_PORT_ACTIVE;
+		ibevent.device = ibdev;
+		ibevent.element.port_num = port + 1;
+		ib_dispatch_event(&ibevent);
 		break;
 	default:
 		dev_dbg(dev, "NETDEV event = 0x%x!\n", (u32)(event));
@@ -126,17 +162,25 @@ static int hns_roce_netdev_event(struct notifier_block *self,
 				 unsigned long event, void *ptr)
 {
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
+	struct hns_roce_bond_group *bond_grp;
 	struct hns_roce_ib_iboe *iboe = NULL;
 	struct hns_roce_dev *hr_dev = NULL;
+	struct net_device *upper = NULL;
 	int ret;
 	u32 port;
 
 	hr_dev = container_of(self, struct hns_roce_dev, iboe.nb);
 	iboe = &hr_dev->iboe;
+	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_BOND) {
+		bond_grp = hns_roce_get_bond_grp(get_hr_netdev(hr_dev, 0),
+						 get_hr_bus_num(hr_dev));
+		upper = bond_grp ? bond_grp->upper_dev : NULL;
+	}
 
 	for (port = 0; port < hr_dev->caps.num_ports; port++) {
-		if (dev == iboe->netdevs[port]) {
-			ret = handle_en_event(hr_dev, port, event);
+		if ((!upper && dev == iboe->netdevs[port]) ||
+		    (upper && dev == upper)) {
+			ret = handle_en_event(dev, hr_dev, port, event);
 			if (ret)
 				return NOTIFY_DONE;
 			break;
@@ -222,9 +266,7 @@ static int hns_roce_query_port(struct ib_device *ib_dev, u32 port_num,
 			       struct ib_port_attr *props)
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(ib_dev);
-	struct device *dev = hr_dev->dev;
 	struct net_device *net_dev;
-	unsigned long flags;
 	enum ib_mtu mtu;
 	u32 port;
 	int ret;
@@ -245,25 +287,24 @@ static int hns_roce_query_port(struct ib_device *ib_dev, u32 port_num,
 	if (ret)
 		ibdev_warn(ib_dev, "failed to get speed, ret = %d.\n", ret);
 
-	spin_lock_irqsave(&hr_dev->iboe.lock, flags);
-
-	net_dev = get_hr_netdev(hr_dev, port);
+	net_dev = ib_device_get_netdev(ib_dev, port_num);
 	if (!net_dev) {
-		spin_unlock_irqrestore(&hr_dev->iboe.lock, flags);
-		dev_err(dev, "find netdev %u failed!\n", port);
-		return -EINVAL;
+		ibdev_err(ib_dev, "failed to get net_dev.\n");
+		return -ENODEV;
 	}
 
 	mtu = iboe_get_mtu(net_dev->mtu);
 	props->active_mtu = mtu ? min(props->max_mtu, mtu) : IB_MTU_256;
-	props->state = netif_running(net_dev) && netif_carrier_ok(net_dev) ?
-			       IB_PORT_ACTIVE :
-			       IB_PORT_DOWN;
+
+	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_BOND)
+		ret = get_upper_port_state(hr_dev, &props->state);
+	if (ret)
+		props->state = ib_get_curr_port_state(net_dev);
+
 	props->phys_state = props->state == IB_PORT_ACTIVE ?
 				    IB_PORT_PHYS_STATE_LINK_UP :
 				    IB_PORT_PHYS_STATE_DISABLED;
-
-	spin_unlock_irqrestore(&hr_dev->iboe.lock, flags);
+	dev_put(net_dev);
 
 	return 0;
 }
-- 
2.33.0


