Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A0F609158
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Oct 2022 07:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiJWFje (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 23 Oct 2022 01:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiJWFje (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 23 Oct 2022 01:39:34 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7920ABC9A
        for <linux-rdma@vger.kernel.org>; Sat, 22 Oct 2022 22:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666503569; x=1698039569;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=25b1xYV5TYWhqHzmUN6NIa4uHhOhs6nndlUOxy/wtLk=;
  b=nPIH+LqpUeDmmzO0fGXflmay+wGd6dHciZLWSKa9dJsB9Z4EG8h7M6J8
   PESxrk/PR2ZxQJF7riyoYLuBCCxwfoh1iYi7mMclyd4lASbeHU6uKlqGl
   1mmGXMJkzOxK2Pp3h0ZBJ4UCWxPVFR+ddWu/YdrPE1JL+GWYsUBPTl4XS
   7SO+3ZcoJdIM1ytto8CoYs+YTjSSdjXUXoPbhI+t/8To612bVehn1FU/6
   BkomH6atqBSVsH0fPHO70+g/8PViZpSVdKJHoaIZr7TbMiAyelNI2L6MR
   BUaDuWqyiiHuJ8czxTLeqO1TK7QtlejxVkO238fjhLIQ2YdGmkPoeYi0h
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10508"; a="294632906"
X-IronPort-AV: E=Sophos;i="5.95,206,1661842800"; 
   d="scan'208";a="294632906"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2022 22:39:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10508"; a="662047003"
X-IronPort-AV: E=Sophos;i="5.95,206,1661842800"; 
   d="scan'208";a="662047003"
Received: from unknown (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by orsmga008.jf.intel.com with ESMTP; 22 Oct 2022 22:39:27 -0700
From:   Zhu Yanjun <yanjun.zhu@intel.com>
To:     jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org,
        yanjun.zhu@linux.dev, yanjun.zhu@intel.com
Subject: [PATCH 1/3] RDMA/core: Move ib device to the same net namespace with net device
Date:   Sun, 23 Oct 2022 18:04:48 -0400
Message-Id: <20221023220450.2287909-2-yanjun.zhu@intel.com>
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

When a net device is moved from a net namespace to another net namespace,
the related ib device should also be moved to the same net namespace.

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/core/device.c | 57 ++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index d275db195f1a..59784fd10876 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2735,6 +2735,54 @@ int ib_dma_virt_map_sg(struct ib_device *dev, struct scatterlist *sg, int nents)
 EXPORT_SYMBOL(ib_dma_virt_map_sg);
 #endif /* CONFIG_INFINIBAND_VIRT_DMA */
 
+static int rdma_netns_notify(struct notifier_block *not_blk,
+			     unsigned long event, void *arg)
+{
+	struct net_device *ndev = netdev_notifier_info_to_dev(arg);
+	struct ib_device *ibdev = ib_device_get_by_netdev(ndev, RDMA_DRIVER_UNKNOWN);
+
+	if (!ibdev)
+		return NOTIFY_OK;
+
+	switch (event) {
+	case NETDEV_REGISTER:
+		ib_device_put(ibdev);
+		if (!net_eq(read_pnet(&ibdev->coredev.rdma_net), dev_net(ndev))) {
+			int ret = 0;
+
+			get_device(&ibdev->dev);
+			ret = rdma_dev_change_netns(ibdev,
+						    read_pnet(&ibdev->coredev.rdma_net),
+						    dev_net(ndev));
+			if (ret) {
+				put_device(&ibdev->dev);
+				return NOTIFY_OK;
+			}
+			put_device(&ibdev->dev);
+		}
+		break;
+	case NETDEV_UNREGISTER:
+		ib_device_put(ibdev);
+		break;
+	case NETDEV_REBOOT:
+	case NETDEV_GOING_DOWN:
+	case NETDEV_CHANGEADDR:
+	case NETDEV_CHANGENAME:
+	case NETDEV_FEAT_CHANGE:
+	default:
+		ib_device_put(ibdev);
+		pr_info("ignoring netdev event = %ld for %s\n",
+			event, ndev->name);
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block rdma_netns_notifier = {
+	.notifier_call = rdma_netns_notify,
+};
+
 static const struct rdma_nl_cbs ibnl_ls_cb_table[RDMA_NL_LS_NUM_OPS] = {
 	[RDMA_NL_LS_OP_RESOLVE] = {
 		.doit = ib_nl_handle_resolve_resp,
@@ -2817,8 +2865,16 @@ static int __init ib_core_init(void)
 	rdma_nl_register(RDMA_NL_LS, ibnl_ls_cb_table);
 	roce_gid_mgmt_init();
 
+	ret = register_netdevice_notifier(&rdma_netns_notifier);
+	if (ret) {
+		pr_err("Failed to register netdev notifier\n");
+		goto err_netdevice;
+	}
+
 	return 0;
 
+err_netdevice:
+	unregister_pernet_device(&rdma_dev_net_ops);
 err_compat:
 	unregister_blocking_lsm_notifier(&ibdev_lsm_nb);
 err_sa:
@@ -2842,6 +2898,7 @@ static int __init ib_core_init(void)
 
 static void __exit ib_core_cleanup(void)
 {
+	unregister_netdevice_notifier(&rdma_netns_notifier);
 	roce_gid_mgmt_cleanup();
 	nldev_exit();
 	rdma_nl_unregister(RDMA_NL_LS);
-- 
2.27.0

