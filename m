Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7BED5E9200
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Sep 2022 12:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiIYKNs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 25 Sep 2022 06:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbiIYKNr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 25 Sep 2022 06:13:47 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45AF92C66D
        for <linux-rdma@vger.kernel.org>; Sun, 25 Sep 2022 03:13:44 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6500,9779,10480"; a="301746510"
X-IronPort-AV: E=Sophos;i="5.93,344,1654585200"; 
   d="scan'208";a="301746510"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2022 03:13:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,344,1654585200"; 
   d="scan'208";a="651481132"
Received: from unknown (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by orsmga008.jf.intel.com with ESMTP; 25 Sep 2022 03:13:42 -0700
From:   yanjun.zhu@linux.dev
To:     leonro@nvidia.com, linux-rdma@vger.kernel.org, jgg@nvidia.com,
        yanjun.zhu@linux.dev
Subject: [PATCH] rdma: not display the rdma link in other net namespace
Date:   Sun, 25 Sep 2022 22:40:33 -0400
Message-Id: <20220926024033.284341-1-yanjun.zhu@linux.dev>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <yanjun.zhu@linux.dev>

When the net devices are moved to another net namespace, the command
"rdma link" should not dispaly the rdma link about this net device.

For example, when the net device eno12399 is moved to net namespace net0
from init_net, the rdma link of eno12399 should not display in init_net.

Before this change:

Init_net:

link roceo12399/1 state DOWN physical_state DISABLED  <---should not display
link roceo12409/1 state DOWN physical_state DISABLED netdev eno12409
link rocep202s0f0/1 state DOWN physical_state DISABLED netdev ens7f0
link rocep202s0f1/1 state ACTIVE physical_state LINK_UP netdev ens7f1

net0:

link roceo12399/1 state DOWN physical_state DISABLED netdev eno12399
link roceo12409/1 state DOWN physical_state DISABLED <---should not display
link rocep202s0f0/1 state DOWN physical_state DISABLED <---should not display
link rocep202s0f1/1 state ACTIVE physical_state LINK_UP <---should not display

After this change

Init_net:

link roceo12409/1 state DOWN physical_state DISABLED netdev eno12409
link rocep202s0f0/1 state DOWN physical_state DISABLED netdev ens7f0
link rocep202s0f1/1 state ACTIVE physical_state LINK_UP netdev ens7f1

net0:

link roceo12399/1 state DOWN physical_state DISABLED netdev eno12399

Fixes: da990ab40a92 ("rdma: Add link object")
Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 rdma/link.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/rdma/link.c b/rdma/link.c
index bf24b849..449a7636 100644
--- a/rdma/link.c
+++ b/rdma/link.c
@@ -238,6 +238,9 @@ static int link_parse_cb(const struct nlmsghdr *nlh, void *data)
 		return MNL_CB_ERROR;
 	}
 
+	if (!tb[RDMA_NLDEV_ATTR_NDEV_NAME] || !tb[RDMA_NLDEV_ATTR_NDEV_INDEX])
+		return MNL_CB_OK;
+
 	idx = mnl_attr_get_u32(tb[RDMA_NLDEV_ATTR_DEV_INDEX]);
 	port = mnl_attr_get_u32(tb[RDMA_NLDEV_ATTR_PORT_INDEX]);
 	name = mnl_attr_get_str(tb[RDMA_NLDEV_ATTR_DEV_NAME]);
-- 
2.27.0

