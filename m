Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3983A5F1C13
	for <lists+linux-rdma@lfdr.de>; Sat,  1 Oct 2022 14:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiJAMPg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 1 Oct 2022 08:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiJAMPf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 1 Oct 2022 08:15:35 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714F35D118
        for <linux-rdma@vger.kernel.org>; Sat,  1 Oct 2022 05:15:34 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="328763296"
X-IronPort-AV: E=Sophos;i="5.93,360,1654585200"; 
   d="scan'208";a="328763296"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2022 05:15:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="653848537"
X-IronPort-AV: E=Sophos;i="5.93,360,1654585200"; 
   d="scan'208";a="653848537"
Received: from unknown (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by orsmga008.jf.intel.com with ESMTP; 01 Oct 2022 05:15:32 -0700
From:   yanjun.zhu@linux.dev
To:     jgg@ziepe.ca, leon@kernel.org, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org, yanjun.zhu@linux.dev
Subject: [PATCH 2/6] RDMA/rxe: Support more rdma links in init_net
Date:   Sun,  2 Oct 2022 00:41:48 -0400
Message-Id: <20221002044152.933021-3-yanjun.zhu@linux.dev>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20221002044152.933021-1-yanjun.zhu@linux.dev>
References: <20221002044152.933021-1-yanjun.zhu@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
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

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/sw/rxe/rxe.c     |  9 ++++-
 drivers/infiniband/sw/rxe/rxe_net.c | 57 +++++++++++++++++++++--------
 drivers/infiniband/sw/rxe/rxe_net.h |  1 +
 3 files changed, 50 insertions(+), 17 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index a22ff2207b42..84a07638f8df 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -8,6 +8,7 @@
 #include <net/addrconf.h>
 #include "rxe.h"
 #include "rxe_loc.h"
+#include "rxe_net.h"
 
 MODULE_AUTHOR("Bob Pearson, Frank Zago, John Groves, Kamal Heib");
 MODULE_DESCRIPTION("Soft RDMA transport");
@@ -205,7 +206,7 @@ static int rxe_newlink(const char *ibdev_name, struct net_device *ndev)
 	return err;
 }
 
-static struct rdma_link_ops rxe_link_ops = {
+struct rdma_link_ops rxe_link_ops = {
 	.type = "rxe",
 	.newlink = rxe_newlink,
 };
@@ -215,6 +216,12 @@ static int __init rxe_module_init(void)
 	int err;
 
 	rdma_link_register(&rxe_link_ops);
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
index c53f4529f098..a20c60d78b50 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -614,19 +614,29 @@ static int rxe_notify(struct notifier_block *not_blk,
 	return NOTIFY_OK;
 }
 
-static struct notifier_block rxe_net_notifier = {
+struct notifier_block rxe_net_notifier = {
 	.notifier_call = rxe_notify,
 };
 
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
@@ -634,24 +644,46 @@ static int rxe_net_ipv4_init(void)
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
@@ -663,19 +695,12 @@ int rxe_net_init(void)
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
2.25.1

