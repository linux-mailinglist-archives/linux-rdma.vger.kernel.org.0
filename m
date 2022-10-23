Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62727609157
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Oct 2022 07:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiJWFja (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 23 Oct 2022 01:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiJWFj3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 23 Oct 2022 01:39:29 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC7EB486
        for <linux-rdma@vger.kernel.org>; Sat, 22 Oct 2022 22:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666503567; x=1698039567;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2q3QpFqKE5bWbCs0311mgQ/14WERgw/u4rVVASWiS1U=;
  b=PXGSpYJ0xN4sX/wWgV1nXE4Rvurhx7jrf0wbLxxuaqvDVPVWP4+hLOXY
   L8WcFducr/iwUR4zE/dOw+EANkkP4lPyOodK8ekmBqJ0UzLdHg5MSdtLi
   p6hRVymSBTj8CG0539tFrI9M1AjMLtyt0G2D9abuhF2Mxih5jTIXGqzgq
   JrQiCWXayFJEqU6uctDf3uM2ebnOvNAf8bt9erjhDmHuYWyn5KGs0vapT
   SndJ7C+GzY7hsJ/i6WBdglve0Q0uwuiNWf5/1N/dtNTvMcyQqcN9Ir5mU
   oDsXcNzEW+B0N4OgCo05CBSDFlz9nr4nqb0Mi9T4Le254kr0bgzK8MB9G
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10508"; a="294632905"
X-IronPort-AV: E=Sophos;i="5.95,206,1661842800"; 
   d="scan'208";a="294632905"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2022 22:39:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10508"; a="662046998"
X-IronPort-AV: E=Sophos;i="5.95,206,1661842800"; 
   d="scan'208";a="662046998"
Received: from unknown (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by orsmga008.jf.intel.com with ESMTP; 22 Oct 2022 22:39:25 -0700
From:   Zhu Yanjun <yanjun.zhu@intel.com>
To:     jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org,
        yanjun.zhu@linux.dev, yanjun.zhu@intel.com
Subject: [PATCH 0/3] RDMA net namespace
Date:   Sun, 23 Oct 2022 18:04:47 -0400
Message-Id: <20221023220450.2287909-1-yanjun.zhu@intel.com>
X-Mailer: git-send-email 2.27.0
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

There are shared and exclusive modes in RDMA net namespace. After
discussion with Leon, the above modes are compatible with legacy IB
device. 

To the RoCE and iWARP devices, the ib devices should be in the same net
namespace with the related net devices regardless of in shared or
exclusive mode.

In the first commit, when the net devices are moved to a new net
namespace, the related ib devices are also moved to the same net
namespace.

In the second commit, the shared/exclusive modes still work with legacy
ib devices. To the RoCE and iWARP devices, these modes will not be
considered.

Because MLX4/5 do not call the function ib_device_set_netdev to map ib
devices and the related net devices, the function ib_device_get_by_netdev
can not get ib devices from net devices. In the third commit, all the
registered ib devices are parsed to get the net devices, then compared
with the given net devices.

The steps to make tests:
1) Create a new net namespace net0

   ip netns add net0

2) Show the rdma links in init_net

   rdma link

   "
   link mlx5_0/1 state DOWN physical_state DISABLED netdev enp7s0np1
   "

3) Move the net device to net namespace net0

   ip link set enp7s0np1 netns net0

4) Show the rdma links in init_net again

   rdma link

   There is no rdma links

5) Show the rdma links in net0

   ip netns exec net0 rdma link

   "
   link mlx5_0/1 state DOWN physical_state DISABLED netdev enp7s0np1
   "

We can confirm that rdma links are moved to the same net namespace with
the net devices.

Zhu Yanjun (3):
  RDMA/core: Move ib device to the same net namespace with net device
  RDMA/core: The legacy IB devices still work with shared/exclusive mode
  RDMA/core: Get all the ib devices from net devices

 drivers/infiniband/core/device.c | 107 ++++++++++++++++++++++++++++++-
 1 file changed, 105 insertions(+), 2 deletions(-)

-- 
2.27.0

