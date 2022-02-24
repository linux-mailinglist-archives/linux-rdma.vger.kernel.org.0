Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4EC4C21C7
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Feb 2022 03:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbiBXCZQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Feb 2022 21:25:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiBXCZQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Feb 2022 21:25:16 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E1822C6FE
        for <linux-rdma@vger.kernel.org>; Wed, 23 Feb 2022 18:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645669487; x=1677205487;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2XBMnGbStjTg9/DSJhMMdw34aQ7TIH2KQZv+E1OlKyw=;
  b=hVZFfvXzqK2vYMFulvA8vzqHuZi1LTNfz3gzbpOiKti3Caci/6Lzpwlo
   aoutnNcOxE7L+Oajj9kv2M+UjuNpva+sX8UYMgyfAkOQ/IWa4YGr+aRY+
   RFYHHqhxz5cs22jB8Cu7or8Le91M0bD2DkmnJ3prpgfUrMZ6sV5+37Jyk
   NIhdIXbRfoYvhFI/L7uDRjzALope66mfXWFJ7zTAus8mjgsR8aq8xi+Fj
   loCbjS4igW/4yUDxZxYnNruOni6u4V+LA1EUUoTkWRM7+k3Wt5spwPSMd
   S6OzhEixh4HI2o7CUppjEZWFA27BJx2SCPp3nKFfI7MrY1Oa7jKmALuKR
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="235627964"
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="235627964"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 16:58:51 -0800
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="548513122"
Received: from ssaleem-mobl.amr.corp.intel.com ([10.255.38.207])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 16:58:50 -0800
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     jgg@nvidia.com, linux-rdma@vger.kernel.org
Cc:     Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH rdma-rc 1/3] RDMA/irdma: Fix netdev notifications for vlan's
Date:   Wed, 23 Feb 2022 18:58:40 -0600
Message-Id: <20220224005842.1707-2-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220224005842.1707-1-shiraz.saleem@intel.com>
References: <20220224005842.1707-1-shiraz.saleem@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
 drivers/infiniband/hw/irdma/utils.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/utils.c b/drivers/infiniband/hw/irdma/utils.c
index 398736d..26407d8 100644
--- a/drivers/infiniband/hw/irdma/utils.c
+++ b/drivers/infiniband/hw/irdma/utils.c
@@ -155,6 +155,8 @@ int irdma_inetaddr_event(struct notifier_block *notifier, unsigned long event,
 	struct ib_device *ibdev;
 	u32 local_ipaddr;
 
+	if (is_vlan_dev(netdev))
+		netdev = vlan_dev_real_dev(netdev);
 	ibdev = ib_device_get_by_netdev(netdev, RDMA_DRIVER_IRDMA);
 	if (!ibdev)
 		return NOTIFY_DONE;
@@ -201,6 +203,8 @@ int irdma_inet6addr_event(struct notifier_block *notifier, unsigned long event,
 	struct ib_device *ibdev;
 	u32 local_ipaddr6[4];
 
+	if (is_vlan_dev(netdev))
+		netdev = vlan_dev_real_dev(netdev);
 	ibdev = ib_device_get_by_netdev(netdev, RDMA_DRIVER_IRDMA);
 	if (!ibdev)
 		return NOTIFY_DONE;
@@ -243,14 +247,16 @@ int irdma_net_event(struct notifier_block *notifier, unsigned long event,
 		    void *ptr)
 {
 	struct neighbour *neigh = ptr;
+	struct net_device *netdev = (struct net_device *)neigh->dev;
 	struct irdma_device *iwdev;
 	struct ib_device *ibdev;
 	__be32 *p;
 	u32 local_ipaddr[4] = {};
 	bool ipv4 = true;
 
-	ibdev = ib_device_get_by_netdev((struct net_device *)neigh->dev,
-					RDMA_DRIVER_IRDMA);
+	if (is_vlan_dev(netdev))
+		netdev = vlan_dev_real_dev(netdev);
+	ibdev = ib_device_get_by_netdev(netdev, RDMA_DRIVER_IRDMA);
 	if (!ibdev)
 		return NOTIFY_DONE;
 
-- 
1.8.3.1

