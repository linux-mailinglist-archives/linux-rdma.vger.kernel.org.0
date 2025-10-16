Return-Path: <linux-rdma+bounces-13898-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6A8BE3A9F
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Oct 2025 15:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 964073AA6BE
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Oct 2025 13:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7C91FDE09;
	Thu, 16 Oct 2025 13:20:38 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC8A1F4C89
	for <linux-rdma@vger.kernel.org>; Thu, 16 Oct 2025 13:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760620838; cv=none; b=LE1lj2mkh4qF15Ylv/bzW6M5bBnpwDUB4NQphgG/gmh8K02o6ckELWDFQXkAX0agAJFmupWLBU2bgrRTSiOcsR/eGOGktBDvKn4tAu/LyDSDYCZvnB0meEUidnk9ZEmW1aS0kufsyOZWY37gRlEL6PdUzmDY96jTP1us2yeb16A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760620838; c=relaxed/simple;
	bh=5xLMZDBwWeR8NHX78ZBuXmWxHws+AouC3AiN6qslbaQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PQ+UX6z6oXA+jKKiU7nzUGxAkGAP9Zr/I8BZwxjrfTrOs+4G4GFAXrHKUCh1yjIO7Ci9eVRU8vc6+4JtHBA0K5i7e5q3Kdu9icQ0mcsszbSpd0kQIk+BSpMa3h6dU9W3e0e+7G6gMQDRIr2mSxyXVjlAmtLSGHMDYAUEgjHCD/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4cnT8Q0ZNmz1prLt;
	Thu, 16 Oct 2025 21:20:06 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 6C89F1800EB;
	Thu, 16 Oct 2025 21:20:27 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 16 Oct 2025 21:20:26 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<huangjunxian6@hisilicon.com>, <tangchengchang@huawei.com>
Subject: [PATCH v2 for-next 7/8] RDMA/hns: Support link state reporting for bond
Date: Thu, 16 Oct 2025 21:20:22 +0800
Message-ID: <20251016132023.3043538-8-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20251016132023.3043538-1-huangjunxian6@hisilicon.com>
References: <20251016132023.3043538-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
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
index a0088ec95281..6eaad58dbb2a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -7354,10 +7354,20 @@ static void hns_roce_hw_v2_link_status_change(struct hnae3_handle *handle,
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


