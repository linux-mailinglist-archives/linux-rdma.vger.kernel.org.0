Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE95173B440
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jun 2023 11:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbjFWJ6v (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Jun 2023 05:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbjFWJ6r (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 23 Jun 2023 05:58:47 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664AA1A3
        for <linux-rdma@vger.kernel.org>; Fri, 23 Jun 2023 02:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687514325; x=1719050325;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mNvcMF5hZgoubXeH1rnMEegqssZgCZ4e+zYFWMPaV3U=;
  b=fJWlgnAIhM5JqtPu/D++S4PcxKaA/tFMvDz1VzzOn2iPDDX5X/BZ6OAi
   i9p9oCwP6MgGwoqXrQw83ByhhCSkX6JHGXC/QBKx1o/Dau3+XP+fSxSfL
   wPGmvL7axcwFzyk+Ubpw0CSaM0OQBkcEVzrNIEfS/mHbO96LUsuhEW4a+
   q/WQ0uwUACZDtYKFTbSkg8eO4YiCddgeI7tLzjSbvh3oOlSlWByLPM2o+
   HZR2aql2FAFVr2FjOvJeZ/vHDi0MWhgYukc51jeWIKRxCU0CE+V6bGpOU
   gRgw0vJt6f6triqofb4K3Hn6D/iilNCMJlNU/VfJdXDKlS2+VtusQfUBd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="424411427"
X-IronPort-AV: E=Sophos;i="6.01,151,1684825200"; 
   d="scan'208";a="424411427"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 02:58:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="715263030"
X-IronPort-AV: E=Sophos;i="6.01,151,1684825200"; 
   d="scan'208";a="715263030"
Received: from unknown (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by orsmga002.jf.intel.com with ESMTP; 23 Jun 2023 02:58:42 -0700
From:   Zhu Yanjun <yanjun.zhu@intel.com>
To:     zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org, parav@nvidia.com, lehrer@gmail.com,
        rpearsonhpe@gmail.com
Cc:     Zhu Yanjun <yanjun.zhu@linux.dev>,
        Rain River <rain.1986.08.12@gmail.com>
Subject: [PATCH v6 6/8] RDMA/rxe: add the support of net namespace
Date:   Fri, 23 Jun 2023 17:57:47 +0800
Message-Id: <20230623095749.485873-7-yanjun.zhu@intel.com>
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

Originally init_net is used to indicate the current net namespace.
Currently more net namespaces are supported.

Tested-by: Rain River <rain.1986.08.12@gmail.com>
Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/sw/rxe/rxe.c     |  2 +-
 drivers/infiniband/sw/rxe/rxe_net.c | 33 +++++++++++++++++------------
 drivers/infiniband/sw/rxe/rxe_net.h |  2 +-
 3 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index c9b3125b26d0..ef632be05e38 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -198,7 +198,7 @@ static int rxe_newlink(const char *ibdev_name, struct net_device *ndev)
 		goto err;
 	}
 
-	err = rxe_net_init();
+	err = rxe_net_init(ndev);
 	if (err)
 		return err;
 
diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index 85ca842f3bad..607382a41e82 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -32,7 +32,7 @@ static struct dst_entry *rxe_find_route4(struct rxe_qp *qp,
 	memcpy(&fl.daddr, daddr, sizeof(*daddr));
 	fl.flowi4_proto = IPPROTO_UDP;
 
-	rt = ip_route_output_key(&init_net, &fl);
+	rt = ip_route_output_key(dev_net(ndev), &fl);
 	if (IS_ERR(rt)) {
 		rxe_dbg_qp(qp, "no route to %pI4\n", &daddr->s_addr);
 		return NULL;
@@ -56,7 +56,8 @@ static struct dst_entry *rxe_find_route6(struct rxe_qp *qp,
 		struct sock *sk;
 
 		rcu_read_lock();
-		sk = udp6_lib_lookup(&init_net, NULL, 0, &in6addr_any, htons(ROCE_V2_UDP_DPORT), 0);
+		sk = udp6_lib_lookup(dev_net(ndev), NULL, 0, &in6addr_any,
+				     htons(ROCE_V2_UDP_DPORT), 0);
 		rcu_read_unlock();
 		if (!sk) {
 			rxe_dbg_qp(qp, "file: %s +%d, error\n", __FILE__, __LINE__);
@@ -553,9 +554,13 @@ int rxe_net_add(const char *ibdev_name, struct net_device *ndev)
 void rxe_net_del(struct ib_device *dev)
 {
 	struct sock *sk;
+	struct rxe_dev *rxe;
+
+	rxe = container_of(dev, struct rxe_dev, ib_dev);
 
 	rcu_read_lock();
-	sk = udp4_lib_lookup(&init_net, 0, 0, htonl(INADDR_ANY), htons(ROCE_V2_UDP_DPORT), 0);
+	sk = udp4_lib_lookup(dev_net(rxe->ndev), 0, 0, htonl(INADDR_ANY),
+			     htons(ROCE_V2_UDP_DPORT), 0);
 	rcu_read_unlock();
 	if (!sk)
 		return;
@@ -568,7 +573,8 @@ void rxe_net_del(struct ib_device *dev)
 		rxe_release_udp_tunnel(sk->sk_socket);
 
 	rcu_read_lock();
-	sk = udp6_lib_lookup(&init_net, NULL, 0, &in6addr_any, htons(ROCE_V2_UDP_DPORT), 0);
+	sk = udp6_lib_lookup(dev_net(rxe->ndev), NULL, 0, &in6addr_any,
+			     htons(ROCE_V2_UDP_DPORT), 0);
 	rcu_read_unlock();
 	if (!sk)
 		return;
@@ -640,6 +646,7 @@ static int rxe_notify(struct notifier_block *not_blk,
 	switch (event) {
 	case NETDEV_UNREGISTER:
 		ib_unregister_device_queued(&rxe->ib_dev);
+		rxe_net_del(&rxe->ib_dev);
 		break;
 	case NETDEV_UP:
 		rxe_port_up(rxe);
@@ -673,19 +680,19 @@ static struct notifier_block rxe_net_notifier = {
 	.notifier_call = rxe_notify,
 };
 
-static int rxe_net_ipv4_init(void)
+static int rxe_net_ipv4_init(struct net_device *ndev)
 {
 	struct sock *sk;
 	struct socket *sock;
 
 	rcu_read_lock();
-	sk = udp4_lib_lookup(&init_net, 0, 0, htonl(INADDR_ANY),
+	sk = udp4_lib_lookup(dev_net(ndev), 0, 0, htonl(INADDR_ANY),
 			     htons(ROCE_V2_UDP_DPORT), 0);
 	rcu_read_unlock();
 	if (sk)
 		return 0;
 
-	sock = rxe_setup_udp_tunnel(&init_net, htons(ROCE_V2_UDP_DPORT), false);
+	sock = rxe_setup_udp_tunnel(dev_net(ndev), htons(ROCE_V2_UDP_DPORT), false);
 	if (IS_ERR(sock)) {
 		pr_err("Failed to create IPv4 UDP tunnel\n");
 		return -1;
@@ -694,20 +701,20 @@ static int rxe_net_ipv4_init(void)
 	return 0;
 }
 
-static int rxe_net_ipv6_init(void)
+static int rxe_net_ipv6_init(struct net_device *ndev)
 {
 #if IS_ENABLED(CONFIG_IPV6)
 	struct sock *sk;
 	struct socket *sock;
 
 	rcu_read_lock();
-	sk = udp6_lib_lookup(&init_net, NULL, 0, &in6addr_any,
+	sk = udp6_lib_lookup(dev_net(ndev), NULL, 0, &in6addr_any,
 			     htons(ROCE_V2_UDP_DPORT), 0);
 	rcu_read_unlock();
 	if (sk)
 		return 0;
 
-	sock = rxe_setup_udp_tunnel(&init_net, htons(ROCE_V2_UDP_DPORT), true);
+	sock = rxe_setup_udp_tunnel(dev_net(ndev), htons(ROCE_V2_UDP_DPORT), true);
 	if (PTR_ERR(sock) == -EAFNOSUPPORT) {
 		pr_warn("IPv6 is not supported, can not create a UDPv6 socket\n");
 		return 0;
@@ -739,14 +746,14 @@ void rxe_net_exit(void)
 	unregister_netdevice_notifier(&rxe_net_notifier);
 }
 
-int rxe_net_init(void)
+int rxe_net_init(struct net_device *ndev)
 {
 	int err;
 
-	err = rxe_net_ipv4_init();
+	err = rxe_net_ipv4_init(ndev);
 	if (err)
 		return err;
-	err = rxe_net_ipv6_init();
+	err = rxe_net_ipv6_init(ndev);
 	if (err)
 		goto err_out;
 	return 0;
diff --git a/drivers/infiniband/sw/rxe/rxe_net.h b/drivers/infiniband/sw/rxe/rxe_net.h
index 027b20e1bab6..56249677d692 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.h
+++ b/drivers/infiniband/sw/rxe/rxe_net.h
@@ -15,7 +15,7 @@ int rxe_net_add(const char *ibdev_name, struct net_device *ndev);
 void rxe_net_del(struct ib_device *dev);
 
 int rxe_register_notifier(void);
-int rxe_net_init(void);
+int rxe_net_init(struct net_device *ndev);
 void rxe_net_exit(void);
 
 #endif /* RXE_NET_H */
-- 
2.27.0

