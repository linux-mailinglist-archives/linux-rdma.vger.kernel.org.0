Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDCB35B2C5
	for <lists+linux-rdma@lfdr.de>; Sun, 11 Apr 2021 11:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235306AbhDKJcX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 11 Apr 2021 05:32:23 -0400
Received: from mga05.intel.com ([192.55.52.43]:45300 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235005AbhDKJcV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 11 Apr 2021 05:32:21 -0400
IronPort-SDR: QX7iD0WVJ8Nd6L99Di+QQOjjNzIsM98dDqf053hFdBGmN613rnXbnfNcWLCZPlsrDZzoK5WvNR
 oxCr8WjuCb8A==
X-IronPort-AV: E=McAfee;i="6000,8403,9950"; a="279300633"
X-IronPort-AV: E=Sophos;i="5.82,214,1613462400"; 
   d="scan'208";a="279300633"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2021 02:32:03 -0700
IronPort-SDR: /TyDCBT4rht3wvWncRB2S9Y/kqYcQY5kFutbcCeInbSy0IOGetuj4JtOoTMS20KELp3BZyc8sM
 8rnf+qZX3E5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,214,1613462400"; 
   d="scan'208";a="449628446"
Received: from unknown (HELO intel-86.bj.intel.com) ([10.238.154.86])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Apr 2021 02:32:01 -0700
From:   Zhu Yanjun <yanjun.zhu@intel.com>
To:     zyjzyj2000@gmail.com, dledford@redhat.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org
Cc:     Yi Zhang <yi.zhang@redhat.com>, Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCHv4 for-next 1/1] RDMA/rxe: Disable ipv6 features when ipv6.disable in cmdline
Date:   Sun, 11 Apr 2021 21:56:41 -0400
Message-Id: <20210412015641.5016-1-yanjun.zhu@intel.com>
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
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Tested-by: Yi Zhang <yi.zhang@redhat.com>
---
V3->V4: I do not know how to reproduce Jason's problem. So I just ignore
        the -EAFNOSUPPORT error. Hope this can fix Jason's problem.
V2->V3: Remove print message
V1->V2: Modify the pr_info messages
---
 drivers/infiniband/sw/rxe/rxe_net.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index 01662727dca0..b12137257af7 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -620,6 +620,11 @@ static int rxe_net_ipv6_init(void)
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

