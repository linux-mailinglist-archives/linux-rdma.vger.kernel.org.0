Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6661CB851
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2019 12:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729891AbfJDKcr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Oct 2019 06:32:47 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:49810 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729880AbfJDKcr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 4 Oct 2019 06:32:47 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 16B7168EEB48804A1646;
        Fri,  4 Oct 2019 18:32:45 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Fri, 4 Oct 2019 18:32:36 +0800
From:   Weihang Li <liweihang@hisilicon.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH for-next 2/2] {topost} RDMA/hns: Add support for sending port down event quickly
Date:   Fri, 4 Oct 2019 18:29:14 +0800
Message-ID: <1570184954-21384-3-git-send-email-liweihang@hisilicon.com>
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

When the netdev port status changes, the roce driver sends a port down
event by parsing the netdev event dispatched by IB_CORE, which takes about
a few hundred milliseconds. It is not fast enough for ULP sometimes.

The HNS NIC driver can directly notify the ROCE driver to send port event
via callback function, which will only take a few milliseconds.
This patch implements above callback function.

Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Weihang Li <liweihang@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 34 ++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 20918f8..3196a11 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -6727,9 +6727,43 @@ static int hns_roce_hw_v2_reset_notify(struct hnae3_handle *handle,
 	return ret;
 }
 
+static void hns_roce_hw_v2_link_status_change(struct hnae3_handle *handle,
+					      bool linkup)
+{
+	struct hns_roce_dev *hr_dev = (struct hns_roce_dev *)handle->priv;
+	struct net_device *netdev = handle->rinfo.netdev;
+	struct ib_event event;
+	unsigned long flags;
+	u8 phy_port;
+
+	if (linkup || !hr_dev)
+		return;
+
+	for (phy_port = 0; phy_port < hr_dev->caps.num_ports; phy_port++)
+		if (netdev == hr_dev->iboe.netdevs[phy_port])
+			break;
+
+	if (phy_port == hr_dev->caps.num_ports)
+		return;
+
+	spin_lock_irqsave(&hr_dev->iboe.lock, flags);
+	if (hr_dev->iboe.port_state[phy_port] == IB_PORT_DOWN) {
+		spin_unlock_irqrestore(&hr_dev->iboe.lock, flags);
+		return;
+	}
+	hr_dev->iboe.port_state[phy_port] = IB_PORT_DOWN;
+	spin_unlock_irqrestore(&hr_dev->iboe.lock, flags);
+
+	event.device = &hr_dev->ib_dev;
+	event.element.port_num = to_rdma_port_num(phy_port);
+	event.event = IB_EVENT_PORT_ERR;
+	ib_dispatch_event(&event);
+}
+
 static const struct hnae3_client_ops hns_roce_hw_v2_ops = {
 	.init_instance = hns_roce_hw_v2_init_instance,
 	.uninit_instance = hns_roce_hw_v2_uninit_instance,
+	.link_status_change = hns_roce_hw_v2_link_status_change,
 	.reset_notify = hns_roce_hw_v2_reset_notify,
 };
 
-- 
2.8.1

