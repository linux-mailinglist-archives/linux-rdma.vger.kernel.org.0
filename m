Return-Path: <linux-rdma+bounces-17580-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GI20GbiPqml0TQEAu9opvQ
	(envelope-from <linux-rdma+bounces-17580-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Mar 2026 09:26:32 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 10AA621D0F1
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Mar 2026 09:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44A133030E8B
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Mar 2026 08:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9749B378833;
	Fri,  6 Mar 2026 08:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ph7wThvG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907172D3727
	for <linux-rdma@vger.kernel.org>; Fri,  6 Mar 2026 08:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772785559; cv=none; b=AL3fyK3+wMqXGZojXQaBn7OZpyX47SQWGk5NsMxekFBXzcIp0nCqFYeX7gcId231gVwzjqif1+m+0bgwp7VjduxFQ58Io8W8CRhewHAZaTsj7W2QNx1w5xkGy1ncIpKoP8OaOeLB4XdPV9lUEWVvBZZ3i+14hdLeK54yyiRy9ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772785559; c=relaxed/simple;
	bh=aFAYrUhlBuFhWEeETa9iJ5gHJeWEdQHxaPlTsy1CjjI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q1oG8SW5U6KTmQBN5pP/AO8jPp5WgIroiqIZmfAZcOXXtzBir3hFJDcSqx+UxHchYt/UjwoOIk6+zZUiTUvuXcEmI4E4+l3EKXQdmVf9+517mPniSAii5DFfY+d4pbGKZ3+lhkiCqdGjA/prqD2OXyUtAK1dODkTwy58B/YaY70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ph7wThvG; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772785555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Hi1GR0iDLS9GYMviK/e6449w0OeHsrnpCzrctrQ/EE=;
	b=ph7wThvGyTs1ux/G7Ia6PAF0Gss6qleWg6FFdoaWAIKYUEBG07dgQFWWquV3e+UCQvkzxr
	DhGHhzh9egB1QoYn7rn2F1ogzISCcI9sqKAok0TvqAmi66N594YehQuhZQ3x4e3U3mVqgH
	vNiBNIUydWWCO3fjzKxs5chx05Q12oc=
From: Zhu Yanjun <yanjun.zhu@linux.dev>
To: jgg@ziepe.ca,
	leon@kernel.org,
	zyjzyj2000@gmail.com,
	yanjun.zhu@linux.dev,
	dsahern@kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 4/4] RDMA/rxe: Support RDMA link creation and destruction per net namespace
Date: Fri,  6 Mar 2026 00:24:52 -0800
Message-ID: <20260306082452.1822-5-yanjun.zhu@linux.dev>
In-Reply-To: <20260306082452.1822-1-yanjun.zhu@linux.dev>
References: <20260306082452.1822-1-yanjun.zhu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 10AA621D0F1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[ziepe.ca,kernel.org,gmail.com,linux.dev,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17580-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
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

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/sw/rxe/rxe.c     |  41 +++++++++-
 drivers/infiniband/sw/rxe/rxe_net.c | 122 +++++++++++++++++++++-------
 drivers/infiniband/sw/rxe/rxe_net.h |   9 +-
 drivers/infiniband/sw/rxe/rxe_ns.c  |  22 +++++
 4 files changed, 154 insertions(+), 40 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index e891199cbdef..f74a66948a37 100644
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
@@ -253,15 +270,29 @@ static int __init rxe_module_init(void)
 	if (err)
 		return err;
 
-	err = rxe_net_init();
+	rdma_link_register(&rxe_link_ops);
+
+	err = rxe_register_notifier();
 	if (err) {
-		rxe_destroy_wq();
-		return err;
+		pr_err("Failed to register netdev notifier\n");
+		goto err_wq;
+	}
+
+	err = rxe_namespace_init();
+	if (err) {
+		pr_err("Failed to register net namespace notifier\n");
+		goto err_notifier;;
 	}
 
-	rdma_link_register(&rxe_link_ops);
 	pr_info("loaded\n");
 	return 0;
+
+err_notifier:
+	rxe_net_exit(); /* unregister notifier */
+err_wq:
+	rdma_link_unregister(&rxe_link_ops);
+	rxe_destroy_wq();
+	return err;
 }
 
 static void __exit rxe_module_exit(void)
@@ -271,6 +302,8 @@ static void __exit rxe_module_exit(void)
 	rxe_net_exit();
 	rxe_destroy_wq();
 
+	rxe_namespace_exit();
+
 	pr_info("unloaded\n");
 }
 
diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index 0bd0902b11f7..ba5bc171a58e 100644
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
@@ -114,7 +113,7 @@ static struct dst_entry *rxe_find_route4(struct rxe_qp *qp,
 	memcpy(&fl.daddr, daddr, sizeof(*daddr));
 	fl.flowi4_proto = IPPROTO_UDP;
 
-	rt = ip_route_output_key(&init_net, &fl);
+	rt = ip_route_output_key(dev_net(ndev), &fl);
 	if (IS_ERR(rt)) {
 		rxe_dbg_qp(qp, "no route to %pI4\n", &daddr->s_addr);
 		return NULL;
@@ -138,8 +137,8 @@ static struct dst_entry *rxe_find_route6(struct rxe_qp *qp,
 	memcpy(&fl6.daddr, daddr, sizeof(*daddr));
 	fl6.flowi6_proto = IPPROTO_UDP;
 
-	ndst = ipv6_stub->ipv6_dst_lookup_flow(sock_net(recv_sockets.sk6->sk),
-					       recv_sockets.sk6->sk, &fl6,
+	ndst = ipv6_stub->ipv6_dst_lookup_flow(dev_net(ndev),
+					       rxe_ns_pernet_sk6(dev_net(ndev)), &fl6,
 					       NULL);
 	if (IS_ERR(ndst)) {
 		rxe_dbg_qp(qp, "no route to %pI6\n", daddr);
@@ -624,6 +623,43 @@ int rxe_net_add(const char *ibdev_name, struct net_device *ndev)
 	return 0;
 }
 
+#define SK_REF_FOR_TUNNEL	2
+
+static void rxe_sock_put(struct sock *sk,
+					void (*set_sk)(struct net *, struct sock *),
+					struct net_device *ndev)
+{
+	if (refcount_read(&sk->sk_refcnt) > SK_REF_FOR_TUNNEL) {
+		__sock_put(sk);
+	} else {
+		rxe_release_udp_tunnel(sk->sk_socket);
+		sk = NULL;
+		set_sk(dev_net(ndev), sk);
+	}
+}
+
+void rxe_net_del(struct ib_device *dev)
+{
+	struct rxe_dev *rxe = container_of(dev, struct rxe_dev, ib_dev);
+	struct net_device *ndev;
+	struct sock *sk;
+
+	ndev = rxe_ib_device_get_netdev(&rxe->ib_dev);
+	if (!ndev)
+		return;
+
+	sk = rxe_ns_pernet_sk4(dev_net(ndev));
+	if (sk)
+		rxe_sock_put(sk, rxe_ns_pernet_set_sk4, ndev);
+
+	sk = rxe_ns_pernet_sk6(dev_net(ndev));
+	if (sk)
+		rxe_sock_put(sk, rxe_ns_pernet_set_sk6, ndev);
+
+	dev_put(ndev);
+}
+#undef SK_REF_FOR_TUNNEL
+
 static void rxe_port_event(struct rxe_dev *rxe,
 			   enum ib_event_type event)
 {
@@ -680,6 +716,7 @@ static int rxe_notify(struct notifier_block *not_blk,
 	switch (event) {
 	case NETDEV_UNREGISTER:
 		ib_unregister_device_queued(&rxe->ib_dev);
+		rxe_net_del(&rxe->ib_dev);
 		break;
 	case NETDEV_CHANGEMTU:
 		rxe_dbg_dev(rxe, "%s changed mtu to %d\n", ndev->name, ndev->mtu);
@@ -709,66 +746,91 @@ static struct notifier_block rxe_net_notifier = {
 	.notifier_call = rxe_notify,
 };
 
-static int rxe_net_ipv4_init(void)
+static int rxe_net_ipv4_init(struct net_device *ndev)
 {
-	recv_sockets.sk4 = rxe_setup_udp_tunnel(&init_net,
-				htons(ROCE_V2_UDP_DPORT), false);
-	if (IS_ERR(recv_sockets.sk4)) {
-		recv_sockets.sk4 = NULL;
+	struct sock *sk;
+	struct socket *sock;
+
+	sk = rxe_ns_pernet_sk4(dev_net(ndev));
+	if (sk) {
+		sock_hold(sk);
+		return 0;
+	}
+
+	sock = rxe_setup_udp_tunnel(dev_net(ndev), htons(ROCE_V2_UDP_DPORT), false);
+	if (IS_ERR(sock)) {
 		pr_err("Failed to create IPv4 UDP tunnel\n");
 		return -1;
 	}
+	rxe_ns_pernet_set_sk4(dev_net(ndev), sock->sk);
 
 	return 0;
 }
 
-static int rxe_net_ipv6_init(void)
+static int rxe_net_ipv6_init(struct net_device *ndev)
 {
 #if IS_ENABLED(CONFIG_IPV6)
+	struct sock *sk;
+	struct socket *sock;
 
-	recv_sockets.sk6 = rxe_setup_udp_tunnel(&init_net,
-						htons(ROCE_V2_UDP_DPORT), true);
-	if (PTR_ERR(recv_sockets.sk6) == -EAFNOSUPPORT) {
-		recv_sockets.sk6 = NULL;
+	sk = rxe_ns_pernet_sk6(dev_net(ndev));
+	if (sk) {
+		sock_hold(sk);
+		return 0;
+	}
+
+	sock = rxe_setup_udp_tunnel(dev_net(ndev), htons(ROCE_V2_UDP_DPORT), true);
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
+	rxe_ns_pernet_set_sk6(dev_net(ndev), sock->sk);
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
 	int err;
 
-	recv_sockets.sk6 = NULL;
-
-	err = rxe_net_ipv4_init();
+	err = rxe_net_ipv4_init(ndev);
 	if (err)
 		return err;
-	err = rxe_net_ipv6_init();
+
+	err = rxe_net_ipv6_init(ndev);
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
+	udp_tunnel_sock_release(rxe_ns_pernet_sk4(dev_net(ndev))->sk_socket);
+	rxe_ns_pernet_set_sk4(dev_net(ndev), NULL);
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
diff --git a/drivers/infiniband/sw/rxe/rxe_ns.c b/drivers/infiniband/sw/rxe/rxe_ns.c
index 29d08899dcda..1ff34167a295 100644
--- a/drivers/infiniband/sw/rxe/rxe_ns.c
+++ b/drivers/infiniband/sw/rxe/rxe_ns.c
@@ -39,7 +39,9 @@ static int __net_init rxe_ns_init(struct net *net)
 	struct rxe_ns_sock *ns_sk = net_generic(net, rxe_pernet_id);
 
 	rcu_assign_pointer(ns_sk->rxe_sk4, NULL); /* initialize sock 4 socket */
+#if IS_ENABLED(CONFIG_IPV6)
 	rcu_assign_pointer(ns_sk->rxe_sk6, NULL); /* initialize sock 6 socket */
+#endif /* IPV6 */
 	synchronize_rcu();
 
 	return 0;
@@ -52,11 +54,15 @@ static void __net_exit rxe_ns_exit(struct net *net)
 	 */
 	struct rxe_ns_sock *ns_sk = net_generic(net, rxe_pernet_id);
 	struct sock *rxe_sk4 = NULL;
+#if IS_ENABLED(CONFIG_IPV6)
 	struct sock *rxe_sk6 = NULL;
+#endif
 
 	rcu_read_lock();
 	rxe_sk4 = rcu_dereference(ns_sk->rxe_sk4);
+#if IS_ENABLED(CONFIG_IPV6)
 	rxe_sk6 = rcu_dereference(ns_sk->rxe_sk6);
+#endif
 	rcu_read_unlock();
 
 	/* close socket */
@@ -66,11 +72,13 @@ static void __net_exit rxe_ns_exit(struct net *net)
 		synchronize_rcu();
 	}
 
+#if IS_ENABLED(CONFIG_IPV6)
 	if (rxe_sk6 && rxe_sk6->sk_socket) {
 		udp_tunnel_sock_release(rxe_sk6->sk_socket);
 		rcu_assign_pointer(ns_sk->rxe_sk6, NULL);
 		synchronize_rcu();
 	}
+#endif
 }
 
 /*
@@ -103,6 +111,7 @@ void rxe_ns_pernet_set_sk4(struct net *net, struct sock *sk)
 	synchronize_rcu();
 }
 
+#if IS_ENABLED(CONFIG_IPV6)
 struct sock *rxe_ns_pernet_sk6(struct net *net)
 {
 	struct rxe_ns_sock *ns_sk = net_generic(net, rxe_pernet_id);
@@ -123,6 +132,19 @@ void rxe_ns_pernet_set_sk6(struct net *net, struct sock *sk)
 	synchronize_rcu();
 }
 
+#else /* IPV6 */
+
+struct sock *rxe_ns_pernet_sk6(struct net *net)
+{
+	return NULL;
+}
+
+void rxe_ns_pernet_set_sk6(struct net *net, struct sock *sk)
+{
+}
+
+#endif /* IPV6 */
+
 int __init rxe_namespace_init(void)
 {
 	return register_pernet_subsys(&rxe_net_ops);
-- 
2.52.0


