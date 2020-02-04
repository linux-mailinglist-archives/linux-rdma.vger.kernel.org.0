Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0541516FF
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Feb 2020 09:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbgBDIYq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Feb 2020 03:24:46 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9689 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727180AbgBDIYq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 4 Feb 2020 03:24:46 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A8308ACBC8048A1EA7A0;
        Tue,  4 Feb 2020 16:24:44 +0800 (CST)
Received: from SZA160416817.china.huawei.com (10.46.14.205) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Tue, 4 Feb 2020 16:24:35 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH RFC v2 for-next 6/7] RDMA/core: support send port event
Date:   Tue, 4 Feb 2020 16:24:07 +0800
Message-ID: <20200204082408.18728-7-liweihang@huawei.com>
X-Mailer: git-send-email 2.10.0.windows.1
In-Reply-To: <20200204082408.18728-1-liweihang@huawei.com>
References: <20200204082408.18728-1-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.46.14.205]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lang Cheng <chenglang@huawei.com>

For the process of handling the link event of the net device, the driver
of each provider is similar, so it can be integrated into the ib_core for
unified processing.

Signed-off-by: Lang Cheng <chenglang@huawei.com>
---
 drivers/infiniband/core/device.c        |  1 +
 drivers/infiniband/core/roce_gid_mgmt.c | 45 +++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 84dd74f..0427a4d 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2225,6 +2225,7 @@ struct net_device *ib_device_get_netdev(struct ib_device *ib_dev,
 
 	return res;
 }
+EXPORT_SYMBOL(ib_device_get_netdev);
 
 /**
  * ib_device_get_by_netdev - Find an IB device associated with a netdev
diff --git a/drivers/infiniband/core/roce_gid_mgmt.c b/drivers/infiniband/core/roce_gid_mgmt.c
index 2860def..4170ba3 100644
--- a/drivers/infiniband/core/roce_gid_mgmt.c
+++ b/drivers/infiniband/core/roce_gid_mgmt.c
@@ -751,6 +751,12 @@ static int netdevice_event(struct notifier_block *this, unsigned long event,
 	struct net_device *ndev = netdev_notifier_info_to_dev(ptr);
 	struct netdev_event_work_cmd cmds[ROCE_NETDEV_CALLBACK_SZ] = { {NULL} };
 
+	enum ib_port_state last_state;
+	enum ib_port_state curr_state;
+	struct ib_device *device;
+	struct ib_event ibev;
+	unsigned int port;
+
 	if (ndev->type != ARPHRD_ETHER)
 		return NOTIFY_DONE;
 
@@ -762,6 +768,45 @@ static int netdevice_event(struct notifier_block *this, unsigned long event,
 		cmds[2] = add_cmd;
 		break;
 
+	case NETDEV_CHANGE:
+	case NETDEV_DOWN:
+		device = ib_device_get_by_netdev(ndev, RDMA_DRIVER_UNKNOWN);
+		if (!device)
+			break;
+
+		rdma_for_each_port (device, port) {
+			if (ib_device_get_netdev(device, port) != ndev)
+				continue;
+
+			if (ib_get_cached_port_inactive_status(device, port))
+				break;
+
+			ib_get_cached_port_state(device, port, &last_state);
+			curr_state =
+				netif_running(ndev) && netif_carrier_ok(ndev) ?
+					IB_PORT_ACTIVE :
+					IB_PORT_DOWN;
+
+			if (last_state == curr_state)
+				break;
+
+			if (curr_state == IB_PORT_DOWN)
+				ibev.event = IB_EVENT_PORT_ERR;
+			else if (curr_state == IB_PORT_ACTIVE)
+				ibev.event = IB_EVENT_PORT_ACTIVE;
+			else
+				break;
+
+			ibev.device = device;
+			ibev.element.port_num = port;
+			ib_dispatch_event(&ibev);
+			ibdev_dbg(ibev.device, "core send %s\n",
+				  ib_event_msg(ibev.event));
+		}
+
+		ib_device_put(device);
+		break;
+
 	case NETDEV_UNREGISTER:
 		if (ndev->reg_state < NETREG_UNREGISTERED)
 			cmds[0] = del_cmd;
-- 
2.8.1


