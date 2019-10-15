Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C138D700C
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Oct 2019 09:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbfJOHVE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Oct 2019 03:21:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:35666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbfJOHVE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 15 Oct 2019 03:21:04 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCFC220659;
        Tue, 15 Oct 2019 07:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571124063;
        bh=Hs5G2JTTPu4ww1QHWJjQucLxjlEtqvVN8gcmowvHJF0=;
        h=From:To:Cc:Subject:Date:From;
        b=bKOuiensWNBw4GF8WEOvM40IOrfhm8nECMKbx2Y6RiH/YIYiCybUUjtyJnG19CU90
         0o6lH6PZDeFm653SCM5Og1aal/y3PsTQDVDDmSwJ3ua6DmuXD3Rg+uDyhyHLxaJAlN
         M8vLQM6SqO9zdQoF5F5pHqwl3+bbUPuJGU475lec=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Parav Pandit <parav@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: [PATCH rdma-next v1] IB/cma: Honor traffic class from lower netdevice for RoCE
Date:   Tue, 15 Oct 2019 10:20:58 +0300
Message-Id: <20191015072058.17347-1-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Parav Pandit <parav@mellanox.com>

When macvlan netdevice is used for RoCE, consider the tos->prio->tc
mapping as SL using its lower netdevice.
1. If lower netdevice is VLAN netdevice, consider such VLAN netdevice
and it's parent netdevice for mapping
2. If lower netdevice is not a VLAN netdevice, consider tc mapping
directly from such lower netdevice

Signed-off-by: Parav Pandit <parav@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
Changelog:
v0->v1: https://lore.kernel.org/linux-rdma/20191002121959.17444-1-leon@kernel.org
 - Protect call to netdev_walk_all_lower_dev_rcu with rcu
----
 drivers/infiniband/core/cma.c | 61 +++++++++++++++++++++++++++++------
 1 file changed, 52 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 0e3cf3461999..c8566a423719 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -2827,22 +2827,65 @@ static int cma_resolve_iw_route(struct rdma_id_private *id_priv)
 	return 0;
 }

-static int iboe_tos_to_sl(struct net_device *ndev, int tos)
+static int get_vlan_ndev_tc(struct net_device *vlan_ndev, int prio)
 {
-	int prio;
 	struct net_device *dev;

-	prio = rt_tos2priority(tos);
-	dev = is_vlan_dev(ndev) ? vlan_dev_real_dev(ndev) : ndev;
+	dev = vlan_dev_real_dev(vlan_ndev);
 	if (dev->num_tc)
 		return netdev_get_prio_tc_map(dev, prio);

-#if IS_ENABLED(CONFIG_VLAN_8021Q)
+	return (vlan_dev_get_egress_qos_mask(vlan_ndev, prio) &
+		VLAN_PRIO_MASK) >> VLAN_PRIO_SHIFT;
+}
+
+struct iboe_prio_tc_map {
+	int input_prio;
+	int output_tc;
+	bool found;
+};
+
+static int get_lower_vlan_dev_tc(struct net_device *dev, void *data)
+{
+	struct iboe_prio_tc_map *map = data;
+
+	if (is_vlan_dev(dev))
+		map->output_tc = get_vlan_ndev_tc(dev, map->input_prio);
+	else if (dev->num_tc)
+		map->output_tc = netdev_get_prio_tc_map(dev, map->input_prio);
+	else
+		map->output_tc = 0;
+	/* We are interested only in first level VLAN device, so always
+	 * return 1 to stop iterating over next level devices.
+	 */
+	map->found = true;
+	return 1;
+}
+
+static int iboe_tos_to_sl(struct net_device *ndev, int tos)
+{
+	struct iboe_prio_tc_map prio_tc_map = {};
+	int prio = rt_tos2priority(tos);
+
+	/* If VLAN device, get it directly from the VLAN netdev */
 	if (is_vlan_dev(ndev))
-		return (vlan_dev_get_egress_qos_mask(ndev, prio) &
-			VLAN_PRIO_MASK) >> VLAN_PRIO_SHIFT;
-#endif
-	return 0;
+		return get_vlan_ndev_tc(ndev, prio);
+
+	prio_tc_map.input_prio = prio;
+	rcu_read_lock();
+	netdev_walk_all_lower_dev_rcu(ndev,
+				      get_lower_vlan_dev_tc,
+				      &prio_tc_map);
+	rcu_read_unlock();
+	/* If map is found from lower device, use it; Otherwise
+	 * continue with the current netdevice to get priority to tc map.
+	 */
+	if (prio_tc_map.found)
+		return prio_tc_map.output_tc;
+	else if (ndev->num_tc)
+		return netdev_get_prio_tc_map(ndev, prio);
+	else
+		return 0;
 }

 static int cma_resolve_iboe_route(struct rdma_id_private *id_priv)
--
2.20.1

