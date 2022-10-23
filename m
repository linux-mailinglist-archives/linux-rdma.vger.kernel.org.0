Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50FB460915A
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Oct 2022 07:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiJWFjj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 23 Oct 2022 01:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbiJWFjh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 23 Oct 2022 01:39:37 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BDD15A39
        for <linux-rdma@vger.kernel.org>; Sat, 22 Oct 2022 22:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666503574; x=1698039574;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=k0hNa9sSqDuaDoEKGYzhyGC+62vA6BwjfQQq0pLVRfY=;
  b=OJsinB5uX0qV3kPs9HEkWGEgNIba7+eMwATVIGEkZw+xyyOoupEbzFAY
   pYk3c0lB9avoBOnVESps7dajVWOGc0xLQX1MZ39q0SSQvYbYWnaZu5mTM
   5WgqYNw5ppSDo/OaSY6+Hhnl43SMONYFu3Kir8W/5bvBP7GIhyIr04vWM
   mZv14kUkmOHapWKJJCtv46nwAF1VvX/E/8BAtOAzxS/h/g+xGuMyIBN3I
   1XmF/wiBdiz3xyoioVAIKzhw6PYjIj29RZyu2ftzHFG1YuuiZaCxLObA8
   V/380HepW2vo6CEuQDU63elT6HNbUWohq5MFo2ewvYqpMK4fDDDLSU7Eb
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10508"; a="294632912"
X-IronPort-AV: E=Sophos;i="5.95,206,1661842800"; 
   d="scan'208";a="294632912"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2022 22:39:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10508"; a="662047012"
X-IronPort-AV: E=Sophos;i="5.95,206,1661842800"; 
   d="scan'208";a="662047012"
Received: from unknown (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by orsmga008.jf.intel.com with ESMTP; 22 Oct 2022 22:39:30 -0700
From:   Zhu Yanjun <yanjun.zhu@intel.com>
To:     jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org,
        yanjun.zhu@linux.dev, yanjun.zhu@intel.com
Subject: [PATCH 3/3] RDMA/core: Get all the ib devices from net devices
Date:   Sun, 23 Oct 2022 18:04:50 -0400
Message-Id: <20221023220450.2287909-4-yanjun.zhu@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20221023220450.2287909-1-yanjun.zhu@intel.com>
References: <20221023220450.2287909-1-yanjun.zhu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <yanjun.zhu@linux.dev>

To mlx4/5, the function ib_device_get_by_netdev can not get
ib devices from net devices.

So this function parses all the ib devices to get all the net
devices, then compares the net devices with the given net device.

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/core/device.c | 39 ++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index d38eb1fc2ed7..55e2d75d752e 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2740,14 +2740,49 @@ int ib_dma_virt_map_sg(struct ib_device *dev, struct scatterlist *sg, int nents)
 EXPORT_SYMBOL(ib_dma_virt_map_sg);
 #endif /* CONFIG_INFINIBAND_VIRT_DMA */
 
+static struct ib_device *get_ibdev_from_ndev(struct net_device *ndev)
+{
+	unsigned long index;
+	struct ib_device *dev;
+	int i;
+
+	down_read(&devices_rwsem);
+	xa_for_each_marked(&devices, index, dev, DEVICE_REGISTERED) {
+		if (!dev->ops.get_netdev)
+			continue;
+
+		for (i = 0; i < dev->phys_port_cnt; i++) {
+			struct net_device *netdev;
+
+			netdev = dev->ops.get_netdev(dev, i+1);
+			if (!netdev)
+				continue;
+
+			dev_put(netdev);
+			if (ndev == netdev) {
+				up_read(&devices_rwsem);
+				if (!ib_device_try_get(dev))
+					dev = NULL;
+				return dev;
+			}
+		}
+	}
+	up_read(&devices_rwsem);
+	return NULL;
+}
+
 static int rdma_netns_notify(struct notifier_block *not_blk,
 			     unsigned long event, void *arg)
 {
 	struct net_device *ndev = netdev_notifier_info_to_dev(arg);
 	struct ib_device *ibdev = ib_device_get_by_netdev(ndev, RDMA_DRIVER_UNKNOWN);
 
-	if (!ibdev)
-		return NOTIFY_OK;
+	if (!ibdev) {
+		/* This is for MLX4/5 */
+		ibdev = get_ibdev_from_ndev(ndev);
+		if (!ibdev)
+			return NOTIFY_OK;
+	}
 
 	/* This will exclude IB device */
 	if (rdma_protocol_ib(ibdev, rdma_start_port(ibdev))) {
-- 
2.27.0

