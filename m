Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF626F1455
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Apr 2023 11:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345455AbjD1JnV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Apr 2023 05:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345647AbjD1JnS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Apr 2023 05:43:18 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18814497
        for <linux-rdma@vger.kernel.org>; Fri, 28 Apr 2023 02:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682674996; x=1714210996;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nf5Yt83EKZZkQIh0jhf/TC6dBZyOWMBU0KB8yTkxmbc=;
  b=ZEoVlOGORvFgNtC+wRL3CAJGVocpuejLlvM9sceYPoUY9RmZUQYak+uA
   1piJZIvUHI0RcbL5WzFMW+XjYnn9+Oxvjkb3O3GkEqRJxuihHb//huFbi
   BdnfKKrJTNtTPaaa8J9inaLl91iV9JakjlEg+6C/+7dSW/9NYO4al5mZq
   yqSstPEfGuTFjdKQFmW4vk2R02j86rHNNceyDdJ8beOWkRnxN4/ajaC1d
   TrXdjani9I7n8tPjMdA2hBlLsAkXKsJZc74+URAUeCDbPB7kQT7+R7DvT
   tBJqlwwIgqU+aqcgDE1vhMj9SEnI4uf5rILtTHMzNl2r3yBy2ASei+xYD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="328035192"
X-IronPort-AV: E=Sophos;i="5.99,234,1677571200"; 
   d="scan'208";a="328035192"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 02:43:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="764220429"
X-IronPort-AV: E=Sophos;i="5.99,234,1677571200"; 
   d="scan'208";a="764220429"
Received: from unknown (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by fmsmga004.fm.intel.com with ESMTP; 28 Apr 2023 02:43:14 -0700
From:   Zhu Yanjun <yanjun.zhu@intel.com>
To:     zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org, parav@nvidia.com, lehrer@gmail.com
Cc:     Zhu Yanjun <yanjun.zhu@linux.dev>,
        Rain River <rain.1986.08.12@gmail.com>
Subject: [PATCHv5 for-rc1 v5 6/8] RDMA/rxe: add the support of net namespace
Date:   Fri, 28 Apr 2023 17:39:12 +0800
Message-Id: <20230428093914.2121131-7-yanjun.zhu@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230428093914.2121131-1-yanjun.zhu@intel.com>
References: <20230428093914.2121131-1-yanjun.zhu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index e81c2164d77f..4a17e4a003f5 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -196,7 +196,7 @@ static int rxe_newlink(const char *ibdev_name, struct net_device *ndev)
 		goto err;
 	}
 
-	err = rxe_net_init();
+	err = rxe_net_init(ndev);
 	if (err)
 		return err;
 
diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index b56e2c32fbf7..9af90587642a 100644
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
 			pr_info("file: %s +%d, error\n", __FILE__, __LINE__);
@@ -549,9 +550,13 @@ int rxe_net_add(const char *ibdev_name, struct net_device *ndev)
 void rxe_net_del(struct ib_device *dev)
 {
 	struct sock *sk;
+	struct rxe_dev *rdev;
+
+	rdev = container_of(dev, struct rxe_dev, ib_dev);
 
 	rcu_read_lock();
-	sk = udp4_lib_lookup(&init_net, 0, 0, htonl(INADDR_ANY), htons(ROCE_V2_UDP_DPORT), 0);
+	sk = udp4_lib_lookup(dev_net(rdev->ndev), 0, 0, htonl(INADDR_ANY),
+			     htons(ROCE_V2_UDP_DPORT), 0);
 	rcu_read_unlock();
 	if (!sk)
 		return;
@@ -564,7 +569,8 @@ void rxe_net_del(struct ib_device *dev)
 		rxe_release_udp_tunnel(sk->sk_socket);
 
 	rcu_read_lock();
-	sk = udp6_lib_lookup(&init_net, NULL, 0, &in6addr_any, htons(ROCE_V2_UDP_DPORT), 0);
+	sk = udp6_lib_lookup(dev_net(rdev->ndev), NULL, 0, &in6addr_any,
+			     htons(ROCE_V2_UDP_DPORT), 0);
 	rcu_read_unlock();
 	if (!sk)
 		return;
@@ -636,6 +642,7 @@ static int rxe_notify(struct notifier_block *not_blk,
 	switch (event) {
 	case NETDEV_UNREGISTER:
 		ib_unregister_device_queued(&rxe->ib_dev);
+		rxe_net_del(&rxe->ib_dev);
 		break;
 	case NETDEV_UP:
 		rxe_port_up(rxe);
@@ -669,19 +676,19 @@ static struct notifier_block rxe_net_notifier = {
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
@@ -690,20 +697,20 @@ static int rxe_net_ipv4_init(void)
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
@@ -735,14 +742,14 @@ void rxe_net_exit(void)
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

