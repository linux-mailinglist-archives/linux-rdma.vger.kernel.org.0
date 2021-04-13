Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D62535D8BC
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Apr 2021 09:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239088AbhDMHSl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Apr 2021 03:18:41 -0400
Received: from mga05.intel.com ([192.55.52.43]:6927 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237684AbhDMHSj (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 13 Apr 2021 03:18:39 -0400
IronPort-SDR: 59CQZwUQdQERuRW4E3ohrKV3rov/7amY8mcrd1vH5pje85DLrEOpqwQqWwuaKK0Dd2NAFdtcSn
 jkyl4gfVxQqA==
X-IronPort-AV: E=McAfee;i="6200,9189,9952"; a="279660696"
X-IronPort-AV: E=Sophos;i="5.82,218,1613462400"; 
   d="scan'208";a="279660696"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2021 00:18:20 -0700
IronPort-SDR: zlQ6KXpA7Ie1UVz+AlJ4njKjdP2Uid03KUd/n7NqYl6HIRjTxW6uBZIIBJkhjzGktD1Ihq9ySU
 0SInBFThCb7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,218,1613462400"; 
   d="scan'208";a="381880531"
Received: from unknown (HELO intel-86.bj.intel.com) ([10.238.154.86])
  by orsmga003.jf.intel.com with ESMTP; 13 Apr 2021 00:18:17 -0700
From:   Zhu Yanjun <yanjun.zhu@intel.com>
To:     zyjzyj2000@gmail.com, dledford@redhat.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org
Cc:     Yi Zhang <yi.zhang@redhat.com>
Subject: [PATCHv5 for-next 1/1] RDMA/rxe: Disable ipv6 features when ipv6.disable in cmdline
Date:   Tue, 13 Apr 2021 19:42:52 -0400
Message-Id: <20210413234252.12209-1-yanjun.zhu@intel.com>
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

Link: https://lore.kernel.org/linux-rdma/880d7b59-4b17-a44f-1a91-88257bfc3aaa@redhat.com/T/#t
Fixes: 8700e3e7c4857 ("Soft RoCE driver")
Reported-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Zhu Yanjun <zyjzyj2000@gmail.com>
---
V4->V5: Clean up signature block and remove error message
V3->V4: Check the returned value instead of ipv6 module
V2->V3: Remove print message
V1->V2: Modify the pr_info messages
---
 drivers/infiniband/sw/rxe/rxe_net.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index 01662727dca0..984c3ac449bd 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -208,7 +208,13 @@ static struct socket *rxe_setup_udp_tunnel(struct net *net, __be16 port,
 	/* Create UDP socket */
 	err = udp_sock_create(net, &udp_cfg, &sock);
 	if (err < 0) {
-		pr_err("failed to create udp socket. err = %d\n", err);
+		/* If UDP tunnel over ipv6 fails with -EAFNOSUPPORT, the tunnel
+		 * over ipv4 still works. This error message will not pop out.
+		 * If UDP tunnle over ipv4 fails or other errors with ipv6
+		 * tunnel, this error should pop out.
+		 */
+		if (!((err == -EAFNOSUPPORT) && (ipv6)))
+			pr_err("failed to create udp socket. err = %d\n", err);
 		return ERR_PTR(err);
 	}
 
@@ -620,6 +626,11 @@ static int rxe_net_ipv6_init(void)
 	recv_sockets.sk6 = rxe_setup_udp_tunnel(&init_net,
 						htons(ROCE_V2_UDP_DPORT), true);
 	if (IS_ERR(recv_sockets.sk6)) {
+		/* Though IPv6 is not supported, IPv4 still needs to continue
+		 */
+		if (PTR_ERR(recv_sockets.sk6) == -EAFNOSUPPORT)
+			return 0;
+
 		recv_sockets.sk6 = NULL;
 		pr_err("Failed to create IPv6 UDP tunnel\n");
 		return -1;
-- 
2.27.0

