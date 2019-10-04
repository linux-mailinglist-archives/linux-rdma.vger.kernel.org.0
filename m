Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB8FCB84F
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2019 12:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729921AbfJDKcr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Oct 2019 06:32:47 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:49808 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729891AbfJDKcr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 4 Oct 2019 06:32:47 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 125E97242EFB431761C9;
        Fri,  4 Oct 2019 18:32:45 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Fri, 4 Oct 2019 18:32:36 +0800
From:   Weihang Li <liweihang@hisilicon.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH for-next 1/2] {topost} RDMA/hns: Deliver net device event to ofed
Date:   Fri, 4 Oct 2019 18:29:13 +0800
Message-ID: <1570184954-21384-2-git-send-email-liweihang@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1570184954-21384-1-git-send-email-liweihang@hisilicon.com>
References: <1570184954-21384-1-git-send-email-liweihang@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lang Cheng <chenglang@huawei.com>

Driver can notify ULP with IB event when net link down/up.

Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Weihang Li <liweihang@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h | 12 +++++++++
 drivers/infiniband/hw/hns/hns_roce_main.c   | 40 +++++++++++++++++++++--------
 2 files changed, 42 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 05d375a..47c209f 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -711,6 +711,7 @@ struct hns_roce_ib_iboe {
 	struct net_device      *netdevs[HNS_ROCE_MAX_PORTS];
 	struct notifier_block	nb;
 	u8			phy_port[HNS_ROCE_MAX_PORTS];
+	enum ib_port_state	port_state[HNS_ROCE_MAX_PORTS];
 };
 
 enum {
@@ -1135,6 +1136,17 @@ static inline void *hns_roce_buf_offset(struct hns_roce_buf *buf, int offset)
 		       (offset & (page_size - 1));
 }
 
+static inline u8 to_rdma_port_num(u8 phy_port_num)
+{
+	return phy_port_num + 1;
+}
+
+static inline enum ib_port_state get_port_state(struct net_device *net_dev)
+{
+	return (netif_running(net_dev) && netif_carrier_ok(net_dev)) ?
+		IB_PORT_ACTIVE : IB_PORT_DOWN;
+}
+
 int hns_roce_init_uar_table(struct hns_roce_dev *dev);
 int hns_roce_uar_alloc(struct hns_roce_dev *dev, struct hns_roce_uar *uar);
 void hns_roce_uar_free(struct hns_roce_dev *dev, struct hns_roce_uar *uar);
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 665ce24..742a36e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -103,10 +103,13 @@ static int hns_roce_del_gid(const struct ib_gid_attr *attr, void **context)
 }
 
 static int handle_en_event(struct hns_roce_dev *hr_dev, u8 port,
-			   unsigned long event)
+			   unsigned long dev_event)
 {
 	struct device *dev = hr_dev->dev;
+	enum ib_port_state port_state;
 	struct net_device *netdev;
+	struct ib_event event;
+	unsigned long flags;
 	int ret = 0;
 
 	netdev = hr_dev->iboe.netdevs[port];
@@ -115,20 +118,38 @@ static int handle_en_event(struct hns_roce_dev *hr_dev, u8 port,
 		return -ENODEV;
 	}
 
-	switch (event) {
-	case NETDEV_UP:
-	case NETDEV_CHANGE:
+	switch (dev_event) {
 	case NETDEV_REGISTER:
 	case NETDEV_CHANGEADDR:
 		ret = hns_roce_set_mac(hr_dev, port, netdev->dev_addr);
 		break;
+	case NETDEV_UP:
+	case NETDEV_CHANGE:
+		ret = hns_roce_set_mac(hr_dev, port, netdev->dev_addr);
+		if (ret)
+			return ret;
+		/* port up/down events need send ib events */
 	case NETDEV_DOWN:
-		/*
-		 * In v1 engine, only support all ports closed together.
-		 */
+		port_state = get_port_state(netdev);
+
+		spin_lock_irqsave(&hr_dev->iboe.lock, flags);
+		if (hr_dev->iboe.port_state[port] == port_state) {
+			spin_unlock_irqrestore(&hr_dev->iboe.lock, flags);
+			return NOTIFY_DONE;
+		}
+		hr_dev->iboe.port_state[port] = port_state;
+		spin_unlock_irqrestore(&hr_dev->iboe.lock, flags);
+
+		event.device = &hr_dev->ib_dev;
+		event.event = (port_state == IB_PORT_ACTIVE) ?
+			      IB_EVENT_PORT_ACTIVE : IB_EVENT_PORT_ERR;
+		event.element.port_num = to_rdma_port_num(port);
+		ib_dispatch_event(&event);
+		break;
+	case NETDEV_UNREGISTER:
 		break;
 	default:
-		dev_dbg(dev, "NETDEV event = 0x%x!\n", (u32)(event));
+		dev_dbg(dev, "NETDEV event = 0x%x!\n", (u32)(dev_event));
 		break;
 	}
 
@@ -259,8 +280,7 @@ static int hns_roce_query_port(struct ib_device *ib_dev, u8 port_num,
 
 	mtu = iboe_get_mtu(net_dev->mtu);
 	props->active_mtu = mtu ? min(props->max_mtu, mtu) : IB_MTU_256;
-	props->state = (netif_running(net_dev) && netif_carrier_ok(net_dev)) ?
-			IB_PORT_ACTIVE : IB_PORT_DOWN;
+	props->state = get_port_state(net_dev);
 	props->phys_state = (props->state == IB_PORT_ACTIVE) ?
 			     IB_PORT_PHYS_STATE_LINK_UP :
 			     IB_PORT_PHYS_STATE_DISABLED;
-- 
2.8.1

