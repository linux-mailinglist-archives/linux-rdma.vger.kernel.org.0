Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEF351413C2
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Jan 2020 22:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgAQVzv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 17 Jan 2020 16:55:51 -0500
Received: from mga07.intel.com ([134.134.136.100]:62725 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729340AbgAQVzu (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 17 Jan 2020 16:55:50 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jan 2020 13:48:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,331,1574150400"; 
   d="scan'208";a="214627116"
Received: from atorres1-mobl1.gar.corp.intel.com (HELO ssaleem-MOBL.amr.corp.intel.com) ([10.255.88.87])
  by orsmga007.jf.intel.com with ESMTP; 17 Jan 2020 13:48:49 -0800
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org,
        "Shiraz Saleem" <shiraz.saleem@intel.com>
Subject: [PATCH rdma-nxt] i40iw: Do an RCU lookup in i40iw_add_ipv4_addr
Date:   Fri, 17 Jan 2020 15:47:20 -0600
Message-Id: <20200117214720.1960-1-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: "Shiraz Saleem" <shiraz.saleem@intel.com>

The in_dev_for_each_ifa_rtnl iterator in i40iw_add_ipv4_addr
requires that the rtnl lock be held. But the rtnl_trylock/unlock
scheme in this function does not guarantee it.

Replace the rtnl locking with an RCU lookup since there are
no netdev object updates in this function.

Fixes: 8e06af711bf2 ("i40iw: add main, hdr, status")
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/hw/i40iw/i40iw_main.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/hw/i40iw/i40iw_main.c b/drivers/infiniband/hw/i40iw/i40iw_main.c
index 2386143..d7a1219 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_main.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_main.c
@@ -1212,22 +1212,19 @@ static void i40iw_add_ipv4_addr(struct i40iw_device *iwdev)
 {
 	struct net_device *dev;
 	struct in_device *idev;
-	bool got_lock = true;
 	u32 ip_addr;
 
-	if (!rtnl_trylock())
-		got_lock = false;
-
-	for_each_netdev(&init_net, dev) {
+	rcu_read_lock();
+	for_each_netdev_rcu(&init_net, dev) {
 		if ((((rdma_vlan_dev_vlan_id(dev) < 0xFFFF) &&
 		      (rdma_vlan_dev_real_dev(dev) == iwdev->netdev)) ||
 		    (dev == iwdev->netdev)) && (dev->flags & IFF_UP)) {
 			const struct in_ifaddr *ifa;
 
-			idev = in_dev_get(dev);
+			idev = __in_dev_get_rcu(dev);
 			if (!idev)
 				continue;
-			in_dev_for_each_ifa_rtnl(ifa, idev) {
+			in_dev_for_each_ifa_rcu(ifa, idev) {
 				i40iw_debug(&iwdev->sc_dev, I40IW_DEBUG_CM,
 					    "IP=%pI4, vlan_id=%d, MAC=%pM\n", &ifa->ifa_address,
 					     rdma_vlan_dev_vlan_id(dev), dev->dev_addr);
@@ -1239,12 +1236,9 @@ static void i40iw_add_ipv4_addr(struct i40iw_device *iwdev)
 						       true,
 						       I40IW_ARP_ADD);
 			}
-
-			in_dev_put(idev);
 		}
 	}
-	if (got_lock)
-		rtnl_unlock();
+	rcu_read_unlock();
 }
 
 /**
-- 
1.8.3.1

