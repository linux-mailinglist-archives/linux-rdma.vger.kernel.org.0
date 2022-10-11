Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351085F9A8C
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Oct 2022 09:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbiJJH7r (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Oct 2022 03:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbiJJH7p (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 Oct 2022 03:59:45 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C1AD13E
        for <linux-rdma@vger.kernel.org>; Mon, 10 Oct 2022 00:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665388783; x=1696924783;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=p1pm/29yx2niWV38BYUgm8iBKYt9eoW+aW2wL183rO4=;
  b=evW7QhpyRX21Xx7brnokI8oWW/xcBkHH/OPFNUXxQyY61t4FTWl6WJWd
   smHJJ3vGXCT89svar5yluI8D9T0JqZYLEwyAxKtCZLgcf6//JqH7n3wMU
   7SNt+3P4C+ALm/dtTqLH5ZQM2cbE/hVpUN126NtAjH2uBDUPZqgiqCVi8
   eb/U83OeS15PxNfAHHa+wAE6gEm+vtxEuDKr/uImVulA5symZfFiDMvV+
   LulRLDFDmIR1V1m9sa155FDfhpEXCqvxpIulRGZUDybAEzLvJgAiuYl8V
   H4o0xQWxH7294oaV8oaG5TKR6lKBLGewSsimmyQKSdS/nkFKqOEJnoiMt
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10495"; a="390474613"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="390474613"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 00:59:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10495"; a="620939991"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="620939991"
Received: from unknown (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by orsmga007.jf.intel.com with ESMTP; 10 Oct 2022 00:59:40 -0700
From:   Zhu Yanjun <yanjun.zhu@intel.com>
To:     yanjun.zhu@linux.dev, jgg@nvidia.com, leo@kernel.org,
        linux-rdma@vger.kernel.org
Subject: [RFC PATCH 1/1] RDMA/core: Fix a problem from rdma link in exclusive mode
Date:   Mon, 10 Oct 2022 20:25:45 -0400
Message-Id: <20221011002545.1410247-1-yanjun.zhu@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <Yz/FaiYZO5Y0R7QP@unreal>
References: <Yz/FaiYZO5Y0R7QP@unreal>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <yanjun.zhu@linux.dev>

This is not an official commit. In rdma net namespace, the rdma device
is separate from the net device. For example, a rdma device A is in net
namespace A1 while the related net device B is in net namespace B1.

I am curious how to make perftest and rping tests on the above
scenario. The ip address of net device B is in net namespace B1
while the rdma device is in net namespace A1.

From my perspective, the rdma device and related net device should
be in the same net namespace. When a net device is moved from one net
namespace to another net namespace, the rdma device should be in the
same net namespace with the net device.

In this commit, when all the ib devices are parsed in exclusive mode,
if the ib devices and related net devices are not in the same net
namespace, the link information will not be reported to user space.

This commit is a RFC.

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/core/device.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index d275db195f1a..9cdd313e4603 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2352,6 +2352,16 @@ int ib_enum_all_devs(nldev_callback nldev_cb, struct sk_buff *skb,
 		if (!rdma_dev_access_netns(dev, sock_net(skb->sk)))
 			continue;
 
+		if (!ib_devices_shared_netns) {
+			int port = rdma_start_port(dev);
+			struct net_device *ndev = NULL;
+
+			ndev = ib_device_get_netdev(dev, port);
+
+			if (ndev && !net_eq(dev_net(ndev), sock_net(skb->sk)))
+				continue;
+		}
+
 		ret = nldev_cb(dev, skb, cb, idx);
 		if (ret)
 			break;
-- 
2.27.0

