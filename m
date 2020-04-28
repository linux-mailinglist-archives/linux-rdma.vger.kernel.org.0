Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8271BBEBF
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2020 15:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbgD1NPc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Apr 2020 09:15:32 -0400
Received: from relay.sw.ru ([185.231.240.75]:51234 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726764AbgD1NPc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 28 Apr 2020 09:15:32 -0400
Received: from [192.168.15.93] (helo=iris.lishka.ru)
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <den@openvz.org>)
        id 1jTQ4u-0005SY-Dh; Tue, 28 Apr 2020 16:15:12 +0300
From:   "Denis V. Lunev" <den@openvz.org>
Cc:     "Denis V. Lunev" <den@openvz.org>,
        Konstantin Khorenko <khorenko@virtuozzo.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] i40iw: remove bogus call to netdev_master_upper_dev_get
Date:   Tue, 28 Apr 2020 16:15:11 +0300
Message-Id: <20200428131511.11049-1-den@openvz.org>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Local variable netdev is not used in these calls.

It should be noted, that this change is required to work in bonded mode.
In the other case we would get the following assert:
 "RTNL: assertion failed at net/core/dev.c (5665)"
with the calltrace as follows:
	dump_stack+0x19/0x1b
	netdev_master_upper_dev_get+0x61/0x70
	i40iw_addr_resolve_neigh+0x1e8/0x220
	i40iw_make_cm_node+0x296/0x700
	? i40iw_find_listener.isra.10+0xcc/0x110
	i40iw_receive_ilq+0x3d4/0x810
	i40iw_puda_poll_completion+0x341/0x420
	i40iw_process_ceq+0xa5/0x280
	i40iw_ceq_dpc+0x1e/0x40
	tasklet_action+0x83/0x140
	__do_softirq+0x125/0x2bb
	call_softirq+0x1c/0x30
	do_softirq+0x65/0xa0
	irq_exit+0x105/0x110
	do_IRQ+0x56/0xf0
	common_interrupt+0x16a/0x16a
	? cpuidle_enter_state+0x57/0xd0
	cpuidle_idle_call+0xde/0x230
	arch_cpu_idle+0xe/0xc0
	cpu_startup_entry+0x14a/0x1e0
	start_secondary+0x1f7/0x270
	start_cpu+0x5/0x14

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Konstantin Khorenko <khorenko@virtuozzo.com>
CC: Faisal Latif <faisal.latif@intel.com>
CC: Shiraz Saleem <shiraz.saleem@intel.com>
CC: Doug Ledford <dledford@redhat.com>
CC: Jason Gunthorpe <jgg@ziepe.ca>
CC: linux-rdma@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---
 drivers/infiniband/hw/i40iw/i40iw_cm.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/infiniband/hw/i40iw/i40iw_cm.c b/drivers/infiniband/hw/i40iw/i40iw_cm.c
index bb78d3280acc..fa7a5ff498c7 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_cm.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_cm.c
@@ -1987,7 +1987,6 @@ static int i40iw_addr_resolve_neigh(struct i40iw_device *iwdev,
 	struct rtable *rt;
 	struct neighbour *neigh;
 	int rc = arpindex;
-	struct net_device *netdev = iwdev->netdev;
 	__be32 dst_ipaddr = htonl(dst_ip);
 	__be32 src_ipaddr = htonl(src_ip);
 
@@ -1997,9 +1996,6 @@ static int i40iw_addr_resolve_neigh(struct i40iw_device *iwdev,
 		return rc;
 	}
 
-	if (netif_is_bond_slave(netdev))
-		netdev = netdev_master_upper_dev_get(netdev);
-
 	neigh = dst_neigh_lookup(&rt->dst, &dst_ipaddr);
 
 	rcu_read_lock();
@@ -2065,7 +2061,6 @@ static int i40iw_addr_resolve_neigh_ipv6(struct i40iw_device *iwdev,
 {
 	struct neighbour *neigh;
 	int rc = arpindex;
-	struct net_device *netdev = iwdev->netdev;
 	struct dst_entry *dst;
 	struct sockaddr_in6 dst_addr;
 	struct sockaddr_in6 src_addr;
@@ -2086,9 +2081,6 @@ static int i40iw_addr_resolve_neigh_ipv6(struct i40iw_device *iwdev,
 		return rc;
 	}
 
-	if (netif_is_bond_slave(netdev))
-		netdev = netdev_master_upper_dev_get(netdev);
-
 	neigh = dst_neigh_lookup(dst, dst_addr.sin6_addr.in6_u.u6_addr32);
 
 	rcu_read_lock();
-- 
2.17.1

