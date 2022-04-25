Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD8F950E7F1
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Apr 2022 20:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240925AbiDYSUX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Apr 2022 14:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244283AbiDYSUW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 Apr 2022 14:20:22 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0F93B297
        for <linux-rdma@vger.kernel.org>; Mon, 25 Apr 2022 11:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650910637; x=1682446637;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wsCBqUyEsgptXEVyPY0aIeCxZWrZQwX9pGgCuybLr5o=;
  b=LSkLaJuYi0mT6SjENgYNNjMCFyx3dNGKn0FB2MtFJ6ufDG89hTOkjtw7
   XG3reBqeMlJydtBKe/AT/IV8YV0w5nHSAUo+gXZSDuCACiWUNlt+8QO1E
   nRhUqcFBBLZCYPYKq7cMS4VCNq7m/sVB7zEVvQgvTkGrG3kA0/t0sS2+F
   sco0b3VmNkCnV0kwfTfQpsDCdUFRUqg0lSFJmcxIynSkgjiDAljhI7AHh
   RevEdnWW3CmviK6DC+z3uPvHZOsHSNFzuQG2s5fMDdQakA+Vp8FZdo///
   Utqisg1y7VCKsifIC/X0CIXJ7JQIYKozD4xj6CyWWGWDXzcQVnaCsA2kI
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="252697324"
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="252697324"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 11:17:15 -0700
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="537708115"
Received: from ssaleem-mobl1.amr.corp.intel.com ([10.212.50.71])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 11:17:15 -0700
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     jgg@nvidia.com, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH for-rc 3/3] RDMA/irdma: Fix possible crash due to NULL netdev in notifier
Date:   Mon, 25 Apr 2022 13:17:03 -0500
Message-Id: <20220425181703.1634-4-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220425181703.1634-1-shiraz.saleem@intel.com>
References: <20220425181703.1634-1-shiraz.saleem@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mustafa Ismail <mustafa.ismail@intel.com>

For some net events in irdma_net_event notifier, the netdev can be NULL
which will cause a crash in rdma_vlan_dev_real_dev.
Fix this by moving all processing to the NETEVENT_NEIGH_UPDATE case where
the netdev is guaranteed to not be NULL.

Fixes: 6702bc147448 ("RDMA/irdma: Fix netdev notifications for vlan's")
Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/hw/irdma/utils.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/utils.c b/drivers/infiniband/hw/irdma/utils.c
index 346c2c5..8176041 100644
--- a/drivers/infiniband/hw/irdma/utils.c
+++ b/drivers/infiniband/hw/irdma/utils.c
@@ -258,18 +258,16 @@ int irdma_net_event(struct notifier_block *notifier, unsigned long event,
 	u32 local_ipaddr[4] = {};
 	bool ipv4 = true;
 
-	real_dev = rdma_vlan_dev_real_dev(netdev);
-	if (!real_dev)
-		real_dev = netdev;
-
-	ibdev = ib_device_get_by_netdev(real_dev, RDMA_DRIVER_IRDMA);
-	if (!ibdev)
-		return NOTIFY_DONE;
-
-	iwdev = to_iwdev(ibdev);
-
 	switch (event) {
 	case NETEVENT_NEIGH_UPDATE:
+		real_dev = rdma_vlan_dev_real_dev(netdev);
+		if (!real_dev)
+			real_dev = netdev;
+		ibdev = ib_device_get_by_netdev(real_dev, RDMA_DRIVER_IRDMA);
+		if (!ibdev)
+			return NOTIFY_DONE;
+
+		iwdev = to_iwdev(ibdev);
 		p = (__be32 *)neigh->primary_key;
 		if (neigh->tbl->family == AF_INET6) {
 			ipv4 = false;
@@ -290,13 +288,12 @@ int irdma_net_event(struct notifier_block *notifier, unsigned long event,
 			irdma_manage_arp_cache(iwdev->rf, neigh->ha,
 					       local_ipaddr, ipv4,
 					       IRDMA_ARP_DELETE);
+		ib_device_put(ibdev);
 		break;
 	default:
 		break;
 	}
 
-	ib_device_put(ibdev);
-
 	return NOTIFY_DONE;
 }
 
-- 
1.8.3.1

