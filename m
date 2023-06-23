Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9289E73B43C
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jun 2023 11:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjFWJ6f (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Jun 2023 05:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbjFWJ6e (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 23 Jun 2023 05:58:34 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35BF910D2
        for <linux-rdma@vger.kernel.org>; Fri, 23 Jun 2023 02:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687514313; x=1719050313;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iENf/iiU5uaw3/3Q2YFd6N3f+fEw/dYrZ6aZUcw4lWg=;
  b=LkG9b3pJ9SV7jYt2wB+unUZoMbhC7K/dCXE3gaKSLEyIk3+1GRLYMu30
   e9injftIRO9ge1Hf5YzpmzBvlw+Sp4Ya4VICV88UAC57BsMooVHL+vvlo
   O57+x7LCNX5TygrpP3hAn5fRnkmZAbFCfB/Cw6KR13e/QVxiH8UPLiNYf
   /6VFvPhw9UarAxwKcVfT1pbBYnHKF6KD3AWJVEW8q+Tsephyh2rK06tjV
   f+wTV+3vb/XrxH1ePPzfdpBLP9jWypQYxGcSjFyndvBGeNUBLKIH2fQYG
   9P4Eo3lDenMdWJvptRF0Xz1Su0xMJcYG6pV5n1xyD9DF70OgZ37unvTsD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="424411362"
X-IronPort-AV: E=Sophos;i="6.01,151,1684825200"; 
   d="scan'208";a="424411362"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 02:58:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="715262995"
X-IronPort-AV: E=Sophos;i="6.01,151,1684825200"; 
   d="scan'208";a="715262995"
Received: from unknown (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by orsmga002.jf.intel.com with ESMTP; 23 Jun 2023 02:58:30 -0700
From:   Zhu Yanjun <yanjun.zhu@intel.com>
To:     zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org, parav@nvidia.com, lehrer@gmail.com,
        rpearsonhpe@gmail.com
Cc:     Zhu Yanjun <yanjun.zhu@linux.dev>,
        Rain River <rain.1986.08.12@gmail.com>
Subject: [PATCH v6 2/8] RDMA/rxe: Support more rdma links in init_net
Date:   Fri, 23 Jun 2023 17:57:43 +0800
Message-Id: <20230623095749.485873-3-yanjun.zhu@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230623095749.485873-1-yanjun.zhu@intel.com>
References: <20230623095749.485873-1-yanjun.zhu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <yanjun.zhu@linux.dev>

In init_net, when several rdma links are created with the command "rdma
link add", newlink will check whether the udp port 4791 is listening or
not.
If not, creating a sock listening on udp port 4791. If yes, increasing the
reference count of the sock.

Tested-by: Rain River <rain.1986.08.12@gmail.com>
Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/sw/rxe/rxe.c     | 12 ++++++-
 drivers/infiniband/sw/rxe/rxe_net.c | 55 +++++++++++++++++++++--------
 drivers/infiniband/sw/rxe/rxe_net.h |  1 +
 3 files changed, 52 insertions(+), 16 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index 89b24bc34299..c15d3c5d7a6f 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -8,6 +8,7 @@
 #include <net/addrconf.h>
 #include "rxe.h"
 #include "rxe_loc.h"
+#include "rxe_net.h"
 
 MODULE_AUTHOR("Bob Pearson, Frank Zago, John Groves, Kamal Heib");
 MODULE_DESCRIPTION("Soft RDMA transport");
@@ -207,14 +208,23 @@ static int rxe_newlink(const char *ibdev_name, struct net_device *ndev)
 	return err;
 }
 
-static struct rdma_link_ops rxe_link_ops = {
+struct rdma_link_ops rxe_link_ops = {
 	.type = "rxe",
 	.newlink = rxe_newlink,
 };
 
 static int __init rxe_module_init(void)
 {
+	int err;
+
 	rdma_link_register(&rxe_link_ops);
+
+	err = rxe_register_notifier();
+	if (err) {
+		pr_err("Failed to register netdev notifier\n");
+		return -1;
+	}
+
 	pr_info("loaded\n");
 	return 0;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index a38fab19bed1..141020bfcf3b 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -627,13 +627,23 @@ static struct notifier_block rxe_net_notifier = {
 
 static int rxe_net_ipv4_init(void)
 {
-	recv_sockets.sk4 = rxe_setup_udp_tunnel(&init_net,
-				htons(ROCE_V2_UDP_DPORT), false);
-	if (IS_ERR(recv_sockets.sk4)) {
-		recv_sockets.sk4 = NULL;
+	struct sock *sk;
+	struct socket *sock;
+
+	rcu_read_lock();
+	sk = udp4_lib_lookup(&init_net, 0, 0, htonl(INADDR_ANY),
+			     htons(ROCE_V2_UDP_DPORT), 0);
+	rcu_read_unlock();
+	if (sk)
+		return 0;
+
+	sock = rxe_setup_udp_tunnel(&init_net, htons(ROCE_V2_UDP_DPORT), false);
+	if (IS_ERR(sock)) {
 		pr_err("Failed to create IPv4 UDP tunnel\n");
+		recv_sockets.sk4 = NULL;
 		return -1;
 	}
+	recv_sockets.sk4 = sock;
 
 	return 0;
 }
@@ -641,24 +651,46 @@ static int rxe_net_ipv4_init(void)
 static int rxe_net_ipv6_init(void)
 {
 #if IS_ENABLED(CONFIG_IPV6)
+	struct sock *sk;
+	struct socket *sock;
+
+	rcu_read_lock();
+	sk = udp6_lib_lookup(&init_net, NULL, 0, &in6addr_any,
+			     htons(ROCE_V2_UDP_DPORT), 0);
+	rcu_read_unlock();
+	if (sk)
+		return 0;
 
-	recv_sockets.sk6 = rxe_setup_udp_tunnel(&init_net,
-						htons(ROCE_V2_UDP_DPORT), true);
-	if (PTR_ERR(recv_sockets.sk6) == -EAFNOSUPPORT) {
+	sock = rxe_setup_udp_tunnel(&init_net, htons(ROCE_V2_UDP_DPORT), true);
+	if (PTR_ERR(sock) == -EAFNOSUPPORT) {
 		recv_sockets.sk6 = NULL;
 		pr_warn("IPv6 is not supported, can not create a UDPv6 socket\n");
 		return 0;
 	}
 
-	if (IS_ERR(recv_sockets.sk6)) {
+	if (IS_ERR(sock)) {
 		recv_sockets.sk6 = NULL;
 		pr_err("Failed to create IPv6 UDP tunnel\n");
 		return -1;
 	}
+	recv_sockets.sk6 = sock;
 #endif
 	return 0;
 }
 
+int rxe_register_notifier(void)
+{
+	int err;
+
+	err = register_netdevice_notifier(&rxe_net_notifier);
+	if (err) {
+		pr_err("Failed to register netdev notifier\n");
+		return -1;
+	}
+
+	return 0;
+}
+
 void rxe_net_exit(void)
 {
 	rxe_release_udp_tunnel(recv_sockets.sk6);
@@ -670,19 +702,12 @@ int rxe_net_init(void)
 {
 	int err;
 
-	recv_sockets.sk6 = NULL;
-
 	err = rxe_net_ipv4_init();
 	if (err)
 		return err;
 	err = rxe_net_ipv6_init();
 	if (err)
 		goto err_out;
-	err = register_netdevice_notifier(&rxe_net_notifier);
-	if (err) {
-		pr_err("Failed to register netdev notifier\n");
-		goto err_out;
-	}
 	return 0;
 err_out:
 	rxe_net_exit();
diff --git a/drivers/infiniband/sw/rxe/rxe_net.h b/drivers/infiniband/sw/rxe/rxe_net.h
index 45d80d00f86b..a222c3eeae12 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.h
+++ b/drivers/infiniband/sw/rxe/rxe_net.h
@@ -18,6 +18,7 @@ struct rxe_recv_sockets {
 
 int rxe_net_add(const char *ibdev_name, struct net_device *ndev);
 
+int rxe_register_notifier(void);
 int rxe_net_init(void);
 void rxe_net_exit(void);
 
-- 
2.27.0

