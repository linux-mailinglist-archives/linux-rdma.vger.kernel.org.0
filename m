Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0402D5F1C17
	for <lists+linux-rdma@lfdr.de>; Sat,  1 Oct 2022 14:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiJAMPu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 1 Oct 2022 08:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiJAMPq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 1 Oct 2022 08:15:46 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A985EDDE
        for <linux-rdma@vger.kernel.org>; Sat,  1 Oct 2022 05:15:40 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="328763322"
X-IronPort-AV: E=Sophos;i="5.93,360,1654585200"; 
   d="scan'208";a="328763322"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2022 05:15:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="653848564"
X-IronPort-AV: E=Sophos;i="5.93,360,1654585200"; 
   d="scan'208";a="653848564"
Received: from unknown (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by orsmga008.jf.intel.com with ESMTP; 01 Oct 2022 05:15:38 -0700
From:   yanjun.zhu@linux.dev
To:     jgg@ziepe.ca, leon@kernel.org, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org, yanjun.zhu@linux.dev
Subject: [PATCH 5/6] RDMA/rxe: Replace global variable with sock lookup functions
Date:   Sun,  2 Oct 2022 00:41:51 -0400
Message-Id: <20221002044152.933021-6-yanjun.zhu@linux.dev>
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

Originally a global variable is to keep the sock of udp listening
port 4791. In fact, sock lookup functions can be used to get
the sock.

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/sw/rxe/rxe_net.c   | 53 ++++++++++++++++++++++-----
 drivers/infiniband/sw/rxe/rxe_net.h   |  5 ---
 drivers/infiniband/sw/rxe/rxe_verbs.h |  1 +
 3 files changed, 44 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index cbcfc0feb027..331d4a279e08 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -18,8 +18,6 @@
 #include "rxe_net.h"
 #include "rxe_loc.h"
 
-static struct rxe_recv_sockets recv_sockets;
-
 static struct dst_entry *rxe_find_route4(struct net_device *ndev,
 				  struct in_addr *saddr,
 				  struct in_addr *daddr)
@@ -49,6 +47,23 @@ static struct dst_entry *rxe_find_route6(struct net_device *ndev,
 {
 	struct dst_entry *ndst;
 	struct flowi6 fl6 = { { 0 } };
+	struct rxe_dev *rdev;
+
+	rdev = rxe_get_dev_from_net(ndev);
+	if (!rdev->l_sk6) {
+		struct sock *sk;
+
+		rcu_read_lock();
+		sk = udp6_lib_lookup(&init_net, NULL, 0, &in6addr_any, htons(ROCE_V2_UDP_DPORT), 0);
+		rcu_read_unlock();
+		if (!sk) {
+			pr_info("file: %s +%d, error\n", __FILE__, __LINE__);
+			return (struct dst_entry *)sk;
+		}
+		__sock_put(sk);
+		rdev->l_sk6 = sk->sk_socket;
+	}
+
 
 	memset(&fl6, 0, sizeof(fl6));
 	fl6.flowi6_oif = ndev->ifindex;
@@ -56,8 +71,8 @@ static struct dst_entry *rxe_find_route6(struct net_device *ndev,
 	memcpy(&fl6.daddr, daddr, sizeof(*daddr));
 	fl6.flowi6_proto = IPPROTO_UDP;
 
-	ndst = ipv6_stub->ipv6_dst_lookup_flow(sock_net(recv_sockets.sk6->sk),
-					       recv_sockets.sk6->sk, &fl6,
+	ndst = ipv6_stub->ipv6_dst_lookup_flow(dev_net(ndev),
+					       rdev->l_sk6->sk, &fl6,
 					       NULL);
 	if (IS_ERR(ndst)) {
 		pr_err_ratelimited("no route to %pI6\n", daddr);
@@ -530,15 +545,33 @@ int rxe_net_add(const char *ibdev_name, struct net_device *ndev)
 #define SK_REF_FOR_TUNNEL	2
 void rxe_net_del(struct ib_device *dev)
 {
-	if (refcount_read(&recv_sockets.sk6->sk->sk_refcnt) > SK_REF_FOR_TUNNEL)
-		__sock_put(recv_sockets.sk6->sk);
+	struct sock *sk;
+
+	rcu_read_lock();
+	sk = udp4_lib_lookup(&init_net, 0, 0, htonl(INADDR_ANY), htons(ROCE_V2_UDP_DPORT), 0);
+	rcu_read_unlock();
+	if (!sk)
+		return;
+
+	__sock_put(sk);
+
+	if (refcount_read(&sk->sk_refcnt) > SK_REF_FOR_TUNNEL)
+		__sock_put(sk);
 	else
-		rxe_release_udp_tunnel(recv_sockets.sk6);
+		rxe_release_udp_tunnel(sk->sk_socket);
+
+	rcu_read_lock();
+	sk = udp6_lib_lookup(&init_net, NULL, 0, &in6addr_any, htons(ROCE_V2_UDP_DPORT), 0);
+	rcu_read_unlock();
+	if (!sk)
+		return;
+
+	__sock_put(sk);
 
-	if (refcount_read(&recv_sockets.sk4->sk->sk_refcnt) > SK_REF_FOR_TUNNEL)
-		__sock_put(recv_sockets.sk4->sk);
+	if (refcount_read(&sk->sk_refcnt) > SK_REF_FOR_TUNNEL)
+		__sock_put(sk);
 	else
-		rxe_release_udp_tunnel(recv_sockets.sk4);
+		rxe_release_udp_tunnel(sk->sk_socket);
 }
 
 static void rxe_port_event(struct rxe_dev *rxe,
diff --git a/drivers/infiniband/sw/rxe/rxe_net.h b/drivers/infiniband/sw/rxe/rxe_net.h
index f48f22f3353b..027b20e1bab6 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.h
+++ b/drivers/infiniband/sw/rxe/rxe_net.h
@@ -11,11 +11,6 @@
 #include <net/if_inet6.h>
 #include <linux/module.h>
 
-struct rxe_recv_sockets {
-	struct socket *sk4;
-	struct socket *sk6;
-};
-
 int rxe_net_add(const char *ibdev_name, struct net_device *ndev);
 void rxe_net_del(struct ib_device *dev);
 
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 96af3e054f4d..13b12f02a52e 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -406,6 +406,7 @@ struct rxe_dev {
 
 	struct rxe_port		port;
 	struct crypto_shash	*tfm;
+	struct socket		*l_sk6;
 };
 
 static inline void rxe_counter_inc(struct rxe_dev *rxe, enum rxe_counters index)
-- 
2.25.1

