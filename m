Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 471064C4ACB
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Feb 2022 17:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243026AbiBYQdi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Feb 2022 11:33:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243028AbiBYQdh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 25 Feb 2022 11:33:37 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484A3A8ED3
        for <linux-rdma@vger.kernel.org>; Fri, 25 Feb 2022 08:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645806784; x=1677342784;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QxrYUTe911VxA2W2rv0F03weHZDyydjAiDZ90ttHcWY=;
  b=YNwQ+r/MmPRifdEhAVsKfmq8IsyixdiMESswgGqzO7MPM5CkG/tZ/vCo
   /j7jIyakQUBNVA/nin//PmTDDH24ywgffvY4Msii/DuugddKZjtKaPVPh
   3SlkGtp7OoYQAoZkRcoL0/Sr3X2T5hPfgvvyjEQIK43h4oW3JIwJxWdsv
   QwD2yhADl8zP9xbL1MCcsB8pOKOZ6/+7nbLlenlEH8PdG017+D2P360RE
   AwnsuQ99UvoI3vgUxGVYSeE3EaZiJ4BrTy2jUsf5vjtaFJ+6ijnBa8TFu
   YBA9aXtZv57eSiXD34XbgSHtnuciEYoJXpKke1TA2zhdCGqWnI/tjzfF/
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="315744247"
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="315744247"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 08:33:01 -0800
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="549321873"
Received: from ssaleem-mobl.amr.corp.intel.com ([10.255.32.70])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 08:33:01 -0800
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     jgg@nvidia.com, linux-rdma@vger.kernel.org
Cc:     Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH rdma-rc v1 1/3] RDMA/irdma: Fix netdev notifications for vlan's
Date:   Fri, 25 Feb 2022 10:32:09 -0600
Message-Id: <20220225163211.127-2-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220225163211.127-1-shiraz.saleem@intel.com>
References: <20220225163211.127-1-shiraz.saleem@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mustafa Ismail <mustafa.ismail@intel.com>

Currently, events on vlan netdevs are being ignored. Fix
this by finding the real netdev and processing the
notifications for vlan netdevs.

Fixes: 915cc7ac0f8e ("RDMA/irdma: Add miscellaneous utility definitions")
Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/hw/irdma/utils.c | 48 +++++++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 18 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/utils.c b/drivers/infiniband/hw/irdma/utils.c
index 398736d..e81b74a 100644
--- a/drivers/infiniband/hw/irdma/utils.c
+++ b/drivers/infiniband/hw/irdma/utils.c
@@ -150,31 +150,35 @@ int irdma_inetaddr_event(struct notifier_block *notifier, unsigned long event,
 			 void *ptr)
 {
 	struct in_ifaddr *ifa = ptr;
-	struct net_device *netdev = ifa->ifa_dev->dev;
+	struct net_device *real_dev, *netdev = ifa->ifa_dev->dev;
 	struct irdma_device *iwdev;
 	struct ib_device *ibdev;
 	u32 local_ipaddr;
 
-	ibdev = ib_device_get_by_netdev(netdev, RDMA_DRIVER_IRDMA);
+	real_dev = rdma_vlan_dev_real_dev(netdev);
+	if (!real_dev)
+		real_dev = netdev;
+
+	ibdev = ib_device_get_by_netdev(real_dev, RDMA_DRIVER_IRDMA);
 	if (!ibdev)
 		return NOTIFY_DONE;
 
 	iwdev = to_iwdev(ibdev);
 	local_ipaddr = ntohl(ifa->ifa_address);
 	ibdev_dbg(&iwdev->ibdev,
-		  "DEV: netdev %p event %lu local_ip=%pI4 MAC=%pM\n", netdev,
-		  event, &local_ipaddr, netdev->dev_addr);
+		  "DEV: netdev %p event %lu local_ip=%pI4 MAC=%pM\n", real_dev,
+		  event, &local_ipaddr, real_dev->dev_addr);
 	switch (event) {
 	case NETDEV_DOWN:
-		irdma_manage_arp_cache(iwdev->rf, netdev->dev_addr,
+		irdma_manage_arp_cache(iwdev->rf, real_dev->dev_addr,
 				       &local_ipaddr, true, IRDMA_ARP_DELETE);
-		irdma_if_notify(iwdev, netdev, &local_ipaddr, true, false);
+		irdma_if_notify(iwdev, real_dev, &local_ipaddr, true, false);
 		irdma_gid_change_event(&iwdev->ibdev);
 		break;
 	case NETDEV_UP:
 	case NETDEV_CHANGEADDR:
-		irdma_add_arp(iwdev->rf, &local_ipaddr, true, netdev->dev_addr);
-		irdma_if_notify(iwdev, netdev, &local_ipaddr, true, true);
+		irdma_add_arp(iwdev->rf, &local_ipaddr, true, real_dev->dev_addr);
+		irdma_if_notify(iwdev, real_dev, &local_ipaddr, true, true);
 		irdma_gid_change_event(&iwdev->ibdev);
 		break;
 	default:
@@ -196,32 +200,36 @@ int irdma_inet6addr_event(struct notifier_block *notifier, unsigned long event,
 			  void *ptr)
 {
 	struct inet6_ifaddr *ifa = ptr;
-	struct net_device *netdev = ifa->idev->dev;
+	struct net_device *real_dev, *netdev = ifa->idev->dev;
 	struct irdma_device *iwdev;
 	struct ib_device *ibdev;
 	u32 local_ipaddr6[4];
 
-	ibdev = ib_device_get_by_netdev(netdev, RDMA_DRIVER_IRDMA);
+	real_dev = rdma_vlan_dev_real_dev(netdev);
+	if (!real_dev)
+		real_dev = netdev;
+
+	ibdev = ib_device_get_by_netdev(real_dev, RDMA_DRIVER_IRDMA);
 	if (!ibdev)
 		return NOTIFY_DONE;
 
 	iwdev = to_iwdev(ibdev);
 	irdma_copy_ip_ntohl(local_ipaddr6, ifa->addr.in6_u.u6_addr32);
 	ibdev_dbg(&iwdev->ibdev,
-		  "DEV: netdev %p event %lu local_ip=%pI6 MAC=%pM\n", netdev,
-		  event, local_ipaddr6, netdev->dev_addr);
+		  "DEV: netdev %p event %lu local_ip=%pI6 MAC=%pM\n", real_dev,
+		  event, local_ipaddr6, real_dev->dev_addr);
 	switch (event) {
 	case NETDEV_DOWN:
-		irdma_manage_arp_cache(iwdev->rf, netdev->dev_addr,
+		irdma_manage_arp_cache(iwdev->rf, real_dev->dev_addr,
 				       local_ipaddr6, false, IRDMA_ARP_DELETE);
-		irdma_if_notify(iwdev, netdev, local_ipaddr6, false, false);
+		irdma_if_notify(iwdev, real_dev, local_ipaddr6, false, false);
 		irdma_gid_change_event(&iwdev->ibdev);
 		break;
 	case NETDEV_UP:
 	case NETDEV_CHANGEADDR:
 		irdma_add_arp(iwdev->rf, local_ipaddr6, false,
-			      netdev->dev_addr);
-		irdma_if_notify(iwdev, netdev, local_ipaddr6, false, true);
+			      real_dev->dev_addr);
+		irdma_if_notify(iwdev, real_dev, local_ipaddr6, false, true);
 		irdma_gid_change_event(&iwdev->ibdev);
 		break;
 	default:
@@ -243,14 +251,18 @@ int irdma_net_event(struct notifier_block *notifier, unsigned long event,
 		    void *ptr)
 {
 	struct neighbour *neigh = ptr;
+	struct net_device *real_dev, *netdev = (struct net_device *)neigh->dev;
 	struct irdma_device *iwdev;
 	struct ib_device *ibdev;
 	__be32 *p;
 	u32 local_ipaddr[4] = {};
 	bool ipv4 = true;
 
-	ibdev = ib_device_get_by_netdev((struct net_device *)neigh->dev,
-					RDMA_DRIVER_IRDMA);
+	real_dev = rdma_vlan_dev_real_dev(netdev);
+	if (!real_dev)
+		real_dev = netdev;
+
+	ibdev = ib_device_get_by_netdev(real_dev, RDMA_DRIVER_IRDMA);
 	if (!ibdev)
 		return NOTIFY_DONE;
 
-- 
1.8.3.1

