Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB4126FA1B4
	for <lists+linux-rdma@lfdr.de>; Mon,  8 May 2023 09:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233301AbjEHH6L (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 8 May 2023 03:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233651AbjEHH6I (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 8 May 2023 03:58:08 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6EC9EFE
        for <linux-rdma@vger.kernel.org>; Mon,  8 May 2023 00:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683532680; x=1715068680;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e2wZ1GSb/c+S5rrGWT0XVZ9c/OmqNX0dETAkJ8gdOW0=;
  b=RWcV4g1JqBY9r/W11e9DsgZVYEZ2Gtilbu5meAiWT3ZJL7rr5FtydZ4e
   Z8GkjT1Dws/T8yOlMM9Th9sPcwVWVguaD7nW5SdNX1x3Ah0eovjkpMuY1
   E+j5qfekE73rB/g06o7aL26bjO1PeVuzfxQXsNImjRNLpf6K/MV1t05sb
   ChnsstSZSIGy3o0RfxpC5uoEcsRgt/Bx3XwwYgwesVYwpHIJBRUVp2tmd
   g64/Xj8B2y0UpOnL6oC4aVH+9XGGSF5XSIfU5owd0+1yvKu9J5yK+cjhG
   LX9toVyRgHCJZTsIe4iDIyP8aKWuimN5FcYhHX242Guz7rUYcrEJ27XF9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="415143129"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="415143129"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 00:57:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="763297482"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="763297482"
Received: from unknown (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by fmsmga008.fm.intel.com with ESMTP; 08 May 2023 00:57:56 -0700
From:   Zhu Yanjun <yanjun.zhu@intel.com>
To:     zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org, parav@nvidia.com, lehrer@gmail.com
Cc:     Zhu Yanjun <yanjun.zhu@linux.dev>,
        Rain River <rain.1986.08.12@gmail.com>
Subject: [PATCH v6.4-rc1 v5 5/8] RDMA/rxe: Replace global variable with sock lookup functions
Date:   Mon,  8 May 2023 15:56:33 +0800
Message-Id: <20230508075636.352138-6-yanjun.zhu@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230508075636.352138-1-yanjun.zhu@intel.com>
References: <20230508075636.352138-1-yanjun.zhu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
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
index 6071533d67c8..87af6a65a291 100644
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
@@ -58,8 +73,8 @@ static struct dst_entry *rxe_find_route6(struct rxe_qp *qp,
 	memcpy(&fl6.daddr, daddr, sizeof(*daddr));
 	fl6.flowi6_proto = IPPROTO_UDP;
 
-	ndst = ipv6_stub->ipv6_dst_lookup_flow(sock_net(recv_sockets.sk6->sk),
-					       recv_sockets.sk6->sk, &fl6,
+	ndst = ipv6_stub->ipv6_dst_lookup_flow(dev_net(ndev),
+					       rdev->l_sk6->sk, &fl6,
 					       NULL);
 	if (IS_ERR(ndst)) {
 		rxe_dbg_qp(qp, "no route to %pI6\n", daddr);
@@ -536,15 +551,33 @@ int rxe_net_add(const char *ibdev_name, struct net_device *ndev)
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
 
@@ -654,10 +687,8 @@ static int rxe_net_ipv4_init(void)
 	sock = rxe_setup_udp_tunnel(&init_net, htons(ROCE_V2_UDP_DPORT), false);
 	if (IS_ERR(sock)) {
 		pr_err("Failed to create IPv4 UDP tunnel\n");
-		recv_sockets.sk4 = NULL;
 		return -1;
 	}
-	recv_sockets.sk4 = sock;
 
 	return 0;
 }
@@ -677,17 +708,14 @@ static int rxe_net_ipv6_init(void)
 
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

