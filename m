Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48446348C25
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Mar 2021 10:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhCYJDO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Mar 2021 05:03:14 -0400
Received: from mga05.intel.com ([192.55.52.43]:27743 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229617AbhCYJDL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 25 Mar 2021 05:03:11 -0400
IronPort-SDR: 3kJma+e7uM18fR7WBK9RDEW6l1XVxHDtuti49sD0bxgh3/I49ZTGWzOral70RE0/q/WIffmBpG
 13laLws87Jlg==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="276011801"
X-IronPort-AV: E=Sophos;i="5.81,277,1610438400"; 
   d="scan'208";a="276011801"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2021 02:03:10 -0700
IronPort-SDR: px1i2j0Xj6TAPgQfC7ipHpCwN5f3Pcjh80AVqA2uW/2XAsjmxVf6PvzGTjcGlo2zyzgIz4YSOc
 sXJ1cAUe9WFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,277,1610438400"; 
   d="scan'208";a="391646254"
Received: from unknown (HELO intel-86.bj.intel.com) ([10.238.154.86])
  by orsmga002.jf.intel.com with ESMTP; 25 Mar 2021 02:03:07 -0700
From:   Zhu Yanjun <yanjun.zhu@intel.com>
To:     dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        leon@kernel.org
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>, Yi Zhang <yi.zhang@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCHv3 for-next 1/1] RDMA/rxe: Disable ipv6 features when ipv6.disable set in cmdline
Date:   Thu, 25 Mar 2021 21:27:23 -0400
Message-Id: <20210326012723.41769-1-yanjun.zhu@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <zyjzyj2000@gmail.com>

When ipv6.disable=1 is set in cmdline, ipv6 is actually disabled
in the stack. As such, the operations of ipv6 in RXE will fail.
So ipv6 features in RXE should also be disabled in RXE.

Fixes: 8700e3e7c4857 ("Soft RoCE driver")
Reported-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Zhu Yanjun <zyjzyj2000@gmail.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Tested-by: Yi Zhang <yi.zhang@redhat.com>
---
V2->V3: Remove print message
V1->V2: Modify the pr_info messages
---
---
 drivers/infiniband/sw/rxe/rxe_net.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index 01662727dca0..3b8ed007e8af 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -72,6 +72,9 @@ static struct dst_entry *rxe_find_route6(struct net_device *ndev,
 	struct dst_entry *ndst;
 	struct flowi6 fl6 = { { 0 } };
 
+	if (!ipv6_mod_enabled())
+		return NULL;
+
 	memset(&fl6, 0, sizeof(fl6));
 	fl6.flowi6_oif = ndev->ifindex;
 	memcpy(&fl6.saddr, saddr, sizeof(*saddr));
@@ -616,6 +619,8 @@ static int rxe_net_ipv4_init(void)
 static int rxe_net_ipv6_init(void)
 {
 #if IS_ENABLED(CONFIG_IPV6)
+	if (!ipv6_mod_enabled())
+		return 0;
 
 	recv_sockets.sk6 = rxe_setup_udp_tunnel(&init_net,
 						htons(ROCE_V2_UDP_DPORT), true);
-- 
2.27.0

