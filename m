Return-Path: <linux-rdma+bounces-17940-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKzcM9ILsWldqAIAu9opvQ
	(envelope-from <linux-rdma+bounces-17940-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 07:29:38 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F32525CD69
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 07:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1B12030300D7
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 06:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72E336C58B;
	Wed, 11 Mar 2026 06:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WGzIpPml"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0F736C0D5
	for <linux-rdma@vger.kernel.org>; Wed, 11 Mar 2026 06:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773210575; cv=none; b=K5wu7Qa97ycm1rz39hNKZKywIhxZdsfoYmmwLTIasSHEmR4cGTClczSO2uINJKBMixcI5shSx6SUYWTPCBRj30SKmsRN87HxhbNwrtwI1pWMugKpjhYRwQR9piP9vhQLSyUm7bhhI6hn8MCW7Q3b/LuAmWc8F+ryVEaWIdkfn0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773210575; c=relaxed/simple;
	bh=iKJg4KCc6FTMvAClEnQXcQWGorjYKtoMAlq6gSOjk2c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mdhxkpGq4jrMkq5CCVSg/jVJ1hHm5kmISTVwqvjPk3kw0M/G7aQeX6EM5ooOlw2S22MOHP6hEdm8H26mYgoj0JpIwz5vBxrFTGYa9S10RNGWGz95mxKhPNM/V86SQeOXy5s/rBG1V/2yTnXKMhKRH93gY9AzwuAejI3MPQt3KV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WGzIpPml; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773210571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pNfYteV4aigFk2b2EWXq5ytGjHkRK0uvrq/NZHNxcNU=;
	b=WGzIpPml/2UgybQ0osuv8+sSVKcM44rbEMBVjK94lkr3jcTUE6z+uIdaKIu3/1T3TzAgV2
	9XedsXn0y1C+tHR37rTqO4bDfrvJ3T1lWboiiunGnby2q37J+iuuTfwpO+F+SvUuEo3DaI
	ZPqIyD8SSAB4sZnLxdU7pEb75B/wp8U=
From: Zhu Yanjun <yanjun.zhu@linux.dev>
To: jgg@ziepe.ca,
	leon@kernel.org,
	zyjzyj2000@gmail.com,
	yanjun.zhu@linux.dev,
	dsahern@kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v6 3/4] RDMA/rxe: Support RDMA link creation and destruction per net namespace
Date: Tue, 10 Mar 2026 23:29:05 -0700
Message-ID: <20260311062906.1470-4-yanjun.zhu@linux.dev>
In-Reply-To: <20260311062906.1470-1-yanjun.zhu@linux.dev>
References: <20260311062906.1470-1-yanjun.zhu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 4F32525CD69
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[ziepe.ca,kernel.org,gmail.com,linux.dev,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17940-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Action: no action

After introducing dellink handling and per-net namespace management
for IPv4 and IPv6 sockets, extend rxe to create and destroy RDMA links
within each network namespace.

With this change, RDMA links can be instantiated both in init_net and
in other network namespaces. The lifecycle of the RDMA link is now tied
to the corresponding namespace and is properly cleaned up when the
namespace or link is removed.

This ensures rxe behaves correctly in multi-namespace environments and
keeps socket and RDMA link resources consistent across namespace
creation and teardown.

Reviewed-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/sw/rxe/rxe.c     |  38 +++++++-
 drivers/infiniband/sw/rxe/rxe_net.c | 144 +++++++++++++++++++++-------
 drivers/infiniband/sw/rxe/rxe_net.h |   9 +-
 3 files changed, 145 insertions(+), 46 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index e891199cbdef..b0714f9abe3d 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -8,6 +8,8 @@
 #include <net/addrconf.h>
 #include "rxe.h"
 #include "rxe_loc.h"
+#include "rxe_net.h"
+#include "rxe_ns.h"
 
 MODULE_AUTHOR("Bob Pearson, Frank Zago, John Groves, Kamal Heib");
 MODULE_DESCRIPTION("Soft RDMA transport");
@@ -200,6 +202,8 @@ void rxe_set_mtu(struct rxe_dev *rxe, unsigned int ndev_mtu)
 	port->mtu_cap = ib_mtu_enum_to_int(mtu);
 }
 
+static struct rdma_link_ops rxe_link_ops;
+
 /* called by ifc layer to create new rxe device.
  * The caller should allocate memory for rxe by calling ib_alloc_device.
  */
@@ -208,6 +212,7 @@ int rxe_add(struct rxe_dev *rxe, unsigned int mtu, const char *ibdev_name,
 {
 	rxe_init(rxe, ndev);
 	rxe_set_mtu(rxe, mtu);
+	rxe->ib_dev.link_ops = &rxe_link_ops;
 
 	return rxe_register_device(rxe, ibdev_name, ndev);
 }
@@ -231,6 +236,10 @@ static int rxe_newlink(const char *ibdev_name, struct net_device *ndev)
 		goto err;
 	}
 
+	err = rxe_net_init(ndev);
+	if (err)
+		return err;
+
 	err = rxe_net_add(ibdev_name, ndev);
 	if (err) {
 		rxe_err("failed to add %s\n", ndev->name);
@@ -240,9 +249,17 @@ static int rxe_newlink(const char *ibdev_name, struct net_device *ndev)
 	return err;
 }
 
+static int rxe_dellink(struct ib_device *dev)
+{
+	rxe_net_del(dev);
+
+	return 0;
+}
+
 static struct rdma_link_ops rxe_link_ops = {
 	.type = "rxe",
 	.newlink = rxe_newlink,
+	.dellink = rxe_dellink,
 };
 
 static int __init rxe_module_init(void)
@@ -253,15 +270,24 @@ static int __init rxe_module_init(void)
 	if (err)
 		return err;
 
-	err = rxe_net_init();
-	if (err) {
-		rxe_destroy_wq();
-		return err;
-	}
+	err = rxe_namespace_init();
+	if (err)
+		goto err_destroy_wq;
+
+	err = rxe_register_notifier();
+	if (err)
+		goto err_namespace_exit;
 
 	rdma_link_register(&rxe_link_ops);
+
 	pr_info("loaded\n");
 	return 0;
+
+err_namespace_exit:
+	rxe_namespace_exit();
+err_destroy_wq:
+	rxe_destroy_wq();
+	return err;
 }
 
 static void __exit rxe_module_exit(void)
@@ -271,6 +297,8 @@ static void __exit rxe_module_exit(void)
 	rxe_net_exit();
 	rxe_destroy_wq();
 
+	rxe_namespace_exit();
+
 	pr_info("unloaded\n");
 }
 
diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index 0bd0902b11f7..92b0c8d598a0 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -17,8 +17,7 @@
 #include "rxe.h"
 #include "rxe_net.h"
 #include "rxe_loc.h"
-
-static struct rxe_recv_sockets recv_sockets;
+#include "rxe_ns.h"
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 /*
@@ -101,20 +100,20 @@ static inline void rxe_reclassify_recv_socket(struct socket *sock)
 }
 
 static struct dst_entry *rxe_find_route4(struct rxe_qp *qp,
+					 struct net *net,
 					 struct net_device *ndev,
 					 struct in_addr *saddr,
 					 struct in_addr *daddr)
 {
 	struct rtable *rt;
-	struct flowi4 fl = { { 0 } };
+	struct flowi4 fl = {};
 
-	memset(&fl, 0, sizeof(fl));
 	fl.flowi4_oif = ndev->ifindex;
 	memcpy(&fl.saddr, saddr, sizeof(*saddr));
 	memcpy(&fl.daddr, daddr, sizeof(*daddr));
 	fl.flowi4_proto = IPPROTO_UDP;
 
-	rt = ip_route_output_key(&init_net, &fl);
+	rt = ip_route_output_key(net, &fl);
 	if (IS_ERR(rt)) {
 		rxe_dbg_qp(qp, "no route to %pI4\n", &daddr->s_addr);
 		return NULL;
@@ -125,21 +124,21 @@ static struct dst_entry *rxe_find_route4(struct rxe_qp *qp,
 
 #if IS_ENABLED(CONFIG_IPV6)
 static struct dst_entry *rxe_find_route6(struct rxe_qp *qp,
+					 struct net *net,
 					 struct net_device *ndev,
 					 struct in6_addr *saddr,
 					 struct in6_addr *daddr)
 {
 	struct dst_entry *ndst;
-	struct flowi6 fl6 = { { 0 } };
+	struct flowi6 fl6 = {};
 
-	memset(&fl6, 0, sizeof(fl6));
 	fl6.flowi6_oif = ndev->ifindex;
 	memcpy(&fl6.saddr, saddr, sizeof(*saddr));
 	memcpy(&fl6.daddr, daddr, sizeof(*daddr));
 	fl6.flowi6_proto = IPPROTO_UDP;
 
-	ndst = ipv6_stub->ipv6_dst_lookup_flow(sock_net(recv_sockets.sk6->sk),
-					       recv_sockets.sk6->sk, &fl6,
+	ndst = ipv6_stub->ipv6_dst_lookup_flow(net,
+					       rxe_ns_pernet_sk6(net), &fl6,
 					       NULL);
 	if (IS_ERR(ndst)) {
 		rxe_dbg_qp(qp, "no route to %pI6\n", daddr);
@@ -160,6 +159,7 @@ static struct dst_entry *rxe_find_route6(struct rxe_qp *qp,
 #else
 
 static struct dst_entry *rxe_find_route6(struct rxe_qp *qp,
+					 struct net *net,
 					 struct net_device *ndev,
 					 struct in6_addr *saddr,
 					 struct in6_addr *daddr)
@@ -174,6 +174,7 @@ static struct dst_entry *rxe_find_route(struct net_device *ndev,
 					struct rxe_av *av)
 {
 	struct dst_entry *dst = NULL;
+	struct net *net;
 
 	if (qp_type(qp) == IB_QPT_RC)
 		dst = sk_dst_get(qp->sk->sk);
@@ -182,20 +183,22 @@ static struct dst_entry *rxe_find_route(struct net_device *ndev,
 		if (dst)
 			dst_release(dst);
 
+		net = dev_net(ndev);
+
 		if (av->network_type == RXE_NETWORK_TYPE_IPV4) {
 			struct in_addr *saddr;
 			struct in_addr *daddr;
 
 			saddr = &av->sgid_addr._sockaddr_in.sin_addr;
 			daddr = &av->dgid_addr._sockaddr_in.sin_addr;
-			dst = rxe_find_route4(qp, ndev, saddr, daddr);
+			dst = rxe_find_route4(qp, net, ndev, saddr, daddr);
 		} else if (av->network_type == RXE_NETWORK_TYPE_IPV6) {
 			struct in6_addr *saddr6;
 			struct in6_addr *daddr6;
 
 			saddr6 = &av->sgid_addr._sockaddr_in6.sin6_addr;
 			daddr6 = &av->dgid_addr._sockaddr_in6.sin6_addr;
-			dst = rxe_find_route6(qp, ndev, saddr6, daddr6);
+			dst = rxe_find_route6(qp, net, ndev, saddr6, daddr6);
 #if IS_ENABLED(CONFIG_IPV6)
 			if (dst)
 				qp->dst_cookie =
@@ -624,6 +627,45 @@ int rxe_net_add(const char *ibdev_name, struct net_device *ndev)
 	return 0;
 }
 
+static void rxe_sock_put(struct sock *sk,
+					void (*set_sk)(struct net *, struct sock *),
+					struct net *net)
+{
+#define SK_REF_FOR_TUNNEL	2
+	if (refcount_read(&sk->sk_refcnt) > SK_REF_FOR_TUNNEL) {
+		__sock_put(sk);
+	} else {
+		rxe_release_udp_tunnel(sk->sk_socket);
+		sk = NULL;
+		set_sk(net, sk);
+	}
+#undef SK_REF_FOR_TUNNEL
+}
+
+void rxe_net_del(struct ib_device *dev)
+{
+	struct rxe_dev *rxe = container_of(dev, struct rxe_dev, ib_dev);
+	struct net_device *ndev;
+	struct sock *sk;
+	struct net *net;
+
+	ndev = rxe_ib_device_get_netdev(&rxe->ib_dev);
+	if (!ndev)
+		return;
+
+	net = dev_net(ndev);
+
+	sk = rxe_ns_pernet_sk4(net);
+	if (sk)
+		rxe_sock_put(sk, rxe_ns_pernet_set_sk4, net);
+
+	sk = rxe_ns_pernet_sk6(net);
+	if (sk)
+		rxe_sock_put(sk, rxe_ns_pernet_set_sk6, net);
+
+	dev_put(ndev);
+}
+
 static void rxe_port_event(struct rxe_dev *rxe,
 			   enum ib_event_type event)
 {
@@ -680,6 +722,7 @@ static int rxe_notify(struct notifier_block *not_blk,
 	switch (event) {
 	case NETDEV_UNREGISTER:
 		ib_unregister_device_queued(&rxe->ib_dev);
+		rxe_net_del(&rxe->ib_dev);
 		break;
 	case NETDEV_CHANGEMTU:
 		rxe_dbg_dev(rxe, "%s changed mtu to %d\n", ndev->name, ndev->mtu);
@@ -709,66 +752,97 @@ static struct notifier_block rxe_net_notifier = {
 	.notifier_call = rxe_notify,
 };
 
-static int rxe_net_ipv4_init(void)
+static int rxe_net_ipv4_init(struct net *net)
 {
-	recv_sockets.sk4 = rxe_setup_udp_tunnel(&init_net,
-				htons(ROCE_V2_UDP_DPORT), false);
-	if (IS_ERR(recv_sockets.sk4)) {
-		recv_sockets.sk4 = NULL;
+	struct sock *sk;
+	struct socket *sock;
+
+	sk = rxe_ns_pernet_sk4(net);
+	if (sk) {
+		sock_hold(sk);
+		return 0;
+	}
+
+	sock = rxe_setup_udp_tunnel(net, htons(ROCE_V2_UDP_DPORT), false);
+	if (IS_ERR(sock)) {
 		pr_err("Failed to create IPv4 UDP tunnel\n");
 		return -1;
 	}
+	rxe_ns_pernet_set_sk4(net, sock->sk);
 
 	return 0;
 }
 
-static int rxe_net_ipv6_init(void)
+static int rxe_net_ipv6_init(struct net *net)
 {
 #if IS_ENABLED(CONFIG_IPV6)
+	struct sock *sk;
+	struct socket *sock;
 
-	recv_sockets.sk6 = rxe_setup_udp_tunnel(&init_net,
-						htons(ROCE_V2_UDP_DPORT), true);
-	if (PTR_ERR(recv_sockets.sk6) == -EAFNOSUPPORT) {
-		recv_sockets.sk6 = NULL;
+	sk = rxe_ns_pernet_sk6(net);
+	if (sk) {
+		sock_hold(sk);
+		return 0;
+	}
+
+	sock = rxe_setup_udp_tunnel(net, htons(ROCE_V2_UDP_DPORT), true);
+	if (PTR_ERR(sock) == -EAFNOSUPPORT) {
 		pr_warn("IPv6 is not supported, can not create a UDPv6 socket\n");
 		return 0;
 	}
 
-	if (IS_ERR(recv_sockets.sk6)) {
-		recv_sockets.sk6 = NULL;
+	if (IS_ERR(sock)) {
 		pr_err("Failed to create IPv6 UDP tunnel\n");
 		return -1;
 	}
+
+	rxe_ns_pernet_set_sk6(net, sock->sk);
+
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
-	rxe_release_udp_tunnel(recv_sockets.sk6);
-	rxe_release_udp_tunnel(recv_sockets.sk4);
 	unregister_netdevice_notifier(&rxe_net_notifier);
 }
 
-int rxe_net_init(void)
+int rxe_net_init(struct net_device *ndev)
 {
+	struct net *net;
 	int err;
 
-	recv_sockets.sk6 = NULL;
+	net = dev_net(ndev);
 
-	err = rxe_net_ipv4_init();
+	err = rxe_net_ipv4_init(net);
 	if (err)
 		return err;
-	err = rxe_net_ipv6_init();
+
+	err = rxe_net_ipv6_init(net);
 	if (err)
 		goto err_out;
-	err = register_netdevice_notifier(&rxe_net_notifier);
-	if (err) {
-		pr_err("Failed to register netdev notifier\n");
-		goto err_out;
-	}
+
 	return 0;
+
 err_out:
-	rxe_net_exit();
+	/* If ipv6 error, release ipv4 resource */
+	struct sock *sk = rxe_ns_pernet_sk4(net);
+
+	if (sk)
+		rxe_sock_put(sk, rxe_ns_pernet_set_sk4, net);
+
 	return err;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_net.h b/drivers/infiniband/sw/rxe/rxe_net.h
index 45d80d00f86b..56249677d692 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.h
+++ b/drivers/infiniband/sw/rxe/rxe_net.h
@@ -11,14 +11,11 @@
 #include <net/if_inet6.h>
 #include <linux/module.h>
 
-struct rxe_recv_sockets {
-	struct socket *sk4;
-	struct socket *sk6;
-};
-
 int rxe_net_add(const char *ibdev_name, struct net_device *ndev);
+void rxe_net_del(struct ib_device *dev);
 
-int rxe_net_init(void);
+int rxe_register_notifier(void);
+int rxe_net_init(struct net_device *ndev);
 void rxe_net_exit(void);
 
 #endif /* RXE_NET_H */
-- 
2.52.0


