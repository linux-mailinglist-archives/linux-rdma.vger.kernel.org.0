Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86E5D151701
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Feb 2020 09:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgBDIYr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Feb 2020 03:24:47 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9687 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727183AbgBDIYq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 4 Feb 2020 03:24:46 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9F87ADDC258A6722C909;
        Tue,  4 Feb 2020 16:24:44 +0800 (CST)
Received: from SZA160416817.china.huawei.com (10.46.14.205) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Tue, 4 Feb 2020 16:24:36 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH RFC v2 for-next 7/7] RDMA/core: report link status when register and deregister ib device
Date:   Tue, 4 Feb 2020 16:24:08 +0800
Message-ID: <20200204082408.18728-8-liweihang@huawei.com>
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

Support send link active event for every port of ib device except bonding
backup port when ib device is being registered or deregistered.

Signed-off-by: Lang Cheng <chenglang@huawei.com>
---
 drivers/infiniband/core/device.c | 44 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 0427a4d..6cdfffa 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -1341,6 +1341,7 @@ static int enable_device_and_get(struct ib_device *device)
  */
 int ib_register_device(struct ib_device *device, const char *name)
 {
+	unsigned int port;
 	int ret;
 
 	ret = assign_name(device, name);
@@ -1405,6 +1406,28 @@ int ib_register_device(struct ib_device *device, const char *name)
 	}
 	ib_device_put(device);
 
+	rdma_for_each_port(device, port) {
+		struct net_device *netdev = ib_device_get_netdev(device, port);
+		enum ib_port_state port_state;
+		struct ib_event event;
+
+		/* not every port has a netdevice */
+		if (!netdev ||
+		    ib_get_cached_port_inactive_status(device, port))
+			continue;
+
+		ib_get_cached_port_state(device, port, &port_state);
+		if (port_state != IB_PORT_ACTIVE)
+			continue;
+
+		event.device = device;
+		event.event = IB_EVENT_PORT_ACTIVE;
+		event.element.port_num = port;
+		ib_dispatch_event(&event);
+		ibdev_dbg(device, "init event %s\n",
+			  ib_event_msg(event.event));
+	}
+
 	return 0;
 
 dev_cleanup:
@@ -1469,6 +1492,27 @@ static void __ib_unregister_device(struct ib_device *ib_dev)
  */
 void ib_unregister_device(struct ib_device *ib_dev)
 {
+	unsigned int port;
+
+	rdma_for_each_port(ib_dev, port) {
+		enum ib_port_state port_state;
+		struct ib_event event;
+
+		if (ib_get_cached_port_inactive_status(ib_dev, port))
+			continue;
+
+		ib_get_cached_port_state(ib_dev, port, &port_state);
+		if (port_state != IB_PORT_ACTIVE)
+			continue;
+
+		event.device = ib_dev;
+		event.event = IB_EVENT_PORT_ERR;
+		event.element.port_num = port;
+		ib_dispatch_event(&event);
+		ibdev_dbg(ib_dev, "init event %s\n",
+			  ib_event_msg(event.event));
+	}
+
 	get_device(&ib_dev->dev);
 	__ib_unregister_device(ib_dev);
 	put_device(&ib_dev->dev);
-- 
2.8.1


