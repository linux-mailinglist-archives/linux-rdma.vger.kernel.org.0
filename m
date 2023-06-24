Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5772773C76A
	for <lists+linux-rdma@lfdr.de>; Sat, 24 Jun 2023 09:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbjFXHk6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 24 Jun 2023 03:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbjFXHky (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 24 Jun 2023 03:40:54 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40FA2736
        for <linux-rdma@vger.kernel.org>; Sat, 24 Jun 2023 00:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687592452; x=1719128452;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MpddQuNsFe0FOMrLCQjsRjvRI1AQijZYgYZLnTOURY8=;
  b=SwlN3DzLVAH0bvVjlBQNkxI4FNm5OHsIk7O1Op1qflYV+7hBvKmQxzU/
   nv0hkdr5G60F5RaqOTbt6GMf7Tki5lbGdFHMw+XVfSL4l55PUKaUSxBr7
   9Tp6dWszR3qqntXPJzlL6NuMHI+LJyvCl+VIOJnf21oniKVdAVOSZ2Y+4
   uuC5jNYqXhSsGR2eH3bUDTxy+18QdcTgQEjJX4KxJyuGuIltYDveuwKNj
   4KsogznyX9U4aYTJff+LszrCWeNw4Asl7mnGry4bXxy8NtgsvmtZTBoLx
   6Buz/D9/Zw1w6nxGP2GW9aGURkRfCEKy4ogbzDukvr4sN/BLd2+MvHjrH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="340517896"
X-IronPort-AV: E=Sophos;i="6.01,154,1684825200"; 
   d="scan'208";a="340517896"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2023 00:40:21 -0700
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="750240728"
X-IronPort-AV: E=Sophos;i="6.01,154,1684825200"; 
   d="scan'208";a="750240728"
Received: from unknown (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by orsmga001.jf.intel.com with ESMTP; 24 Jun 2023 00:40:19 -0700
From:   Zhu Yanjun <yanjun.zhu@intel.com>
To:     zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org, parav@nvidia.com, lehrer@gmail.com,
        rpearsonhpe@gmail.com
Cc:     Zhu Yanjun <yanjun.zhu@linux.dev>,
        Rain River <rain.1986.08.12@gmail.com>
Subject: [PATCH v7 5/8] RDMA/rxe: Replace global variable with sock lookup functions
Date:   Sat, 24 Jun 2023 15:39:24 +0800
Message-Id: <20230624073927.707915-6-yanjun.zhu@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230624073927.707915-1-yanjun.zhu@intel.com>
References: <20230624073927.707915-1-yanjun.zhu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <yanjun.zhu@linux.dev>

Originally a global variable is to keep the sock of udp listening
on port 4791. In fact, sock lookup functions can be used to get
the sock.

Tested-by: Rain River <rain.1986.08.12@gmail.com>
Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/sw/rxe/rxe.c       |  1 +
 drivers/infiniband/sw/rxe/rxe_net.c   | 58 ++++++++++++++++++++-------
 drivers/infiniband/sw/rxe/rxe_net.h   |  5 ---
 drivers/infiniband/sw/rxe/rxe_verbs.h |  1 +
 4 files changed, 45 insertions(+), 20 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index ac7e7b0a9dc9..c9b3125b26d0 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -74,6 +74,7 @@ static void rxe_init_device_param(struct rxe_dev *rxe)
 			rxe->ndev->dev_addr);
 
 	rxe->max_ucontext			= RXE_MAX_UCONTEXT;
+	rxe->l_sk6				= NULL;
 }
 
 /* initialize port attributes */
diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index 632c0a5fcadb..3c8cb82d2ee5 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -18,8 +18,6 @@
 #include "rxe_net.h"
 #include "rxe_loc.h"
 
-static struct rxe_recv_sockets recv_sockets;
-
 static struct dst_entry *rxe_find_route4(struct rxe_qp *qp,
 					 struct net_device *ndev,
 					 struct in_addr *saddr,
@@ -51,6 +49,23 @@ static struct dst_entry *rxe_find_route6(struct rxe_qp *qp,
 {
 	struct dst_entry *ndst;
 	struct flowi6 fl6 = { { 0 } };
+	struct rxe_dev *rxe;
+
+	rxe = rxe_get_dev_from_net(ndev);
+	if (!rxe->l_sk6) {
+		struct sock *sk;
+
+		rcu_read_lock();
+		sk = udp6_lib_lookup(&init_net, NULL, 0, &in6addr_any, htons(ROCE_V2_UDP_DPORT), 0);
+		rcu_read_unlock();
+		if (!sk) {
+			rxe_dbg_qp(qp, "file: %s +%d, error\n", __FILE__, __LINE__);
+			return (struct dst_entry *)sk;
+		}
+		__sock_put(sk);
+		rxe->l_sk6 = sk->sk_socket;
+	}
+
 
 	memset(&fl6, 0, sizeof(fl6));
 	fl6.flowi6_oif = ndev->ifindex;
@@ -58,8 +73,8 @@ static struct dst_entry *rxe_find_route6(struct rxe_qp *qp,
 	memcpy(&fl6.daddr, daddr, sizeof(*daddr));
 	fl6.flowi6_proto = IPPROTO_UDP;
 
-	ndst = ipv6_stub->ipv6_dst_lookup_flow(sock_net(recv_sockets.sk6->sk),
-					       recv_sockets.sk6->sk, &fl6,
+	ndst = ipv6_stub->ipv6_dst_lookup_flow(dev_net(ndev),
+					       rxe->l_sk6->sk, &fl6,
 					       NULL);
 	if (IS_ERR(ndst)) {
 		rxe_dbg_qp(qp, "no route to %pI6\n", daddr);
@@ -543,15 +558,33 @@ int rxe_net_add(const char *ibdev_name, struct net_device *ndev)
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
 #undef SK_REF_FOR_TUNNEL
 
@@ -661,10 +694,8 @@ static int rxe_net_ipv4_init(void)
 	sock = rxe_setup_udp_tunnel(&init_net, htons(ROCE_V2_UDP_DPORT), false);
 	if (IS_ERR(sock)) {
 		pr_err("Failed to create IPv4 UDP tunnel\n");
-		recv_sockets.sk4 = NULL;
 		return -1;
 	}
-	recv_sockets.sk4 = sock;
 
 	return 0;
 }
@@ -684,17 +715,14 @@ static int rxe_net_ipv6_init(void)
 
 	sock = rxe_setup_udp_tunnel(&init_net, htons(ROCE_V2_UDP_DPORT), true);
 	if (PTR_ERR(sock) == -EAFNOSUPPORT) {
-		recv_sockets.sk6 = NULL;
 		pr_warn("IPv6 is not supported, can not create a UDPv6 socket\n");
 		return 0;
 	}
 
 	if (IS_ERR(sock)) {
-		recv_sockets.sk6 = NULL;
 		pr_err("Failed to create IPv6 UDP tunnel\n");
 		return -1;
 	}
-	recv_sockets.sk6 = sock;
 #endif
 	return 0;
 }
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
index 26a20f088692..0aa3817770a5 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -382,6 +382,7 @@ struct rxe_dev {
 
 	struct rxe_port		port;
 	struct crypto_shash	*tfm;
+	struct socket		*l_sk6;
 };
 
 static inline void rxe_counter_inc(struct rxe_dev *rxe, enum rxe_counters index)
-- 
2.27.0

