Return-Path: <linux-rdma+bounces-17182-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDwSDeEwn2lXZQQAu9opvQ
	(envelope-from <linux-rdma+bounces-17182-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 18:26:57 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D2919B866
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 18:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 66DAF3022915
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 17:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508EB3D905A;
	Wed, 25 Feb 2026 17:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="STUiFrt/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B363C1998
	for <linux-rdma@vger.kernel.org>; Wed, 25 Feb 2026 17:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772040385; cv=none; b=KLvkhaW3VnHzvYFT5J0nDCAINdZFvapedDhwAMUbiLpibDhcIzNC3qN+gP2oZUpg1vcA9eDeUw7K7s+xtBhWIrH/vhCSOh+df9HdBVhkrDR+npOmRl9vx6nTzSLEQ2T03WU2Qat98rAZCQZf/nCeOSPfPQppvjyrpmGDo//N8Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772040385; c=relaxed/simple;
	bh=irPtqkEmIrEl9xzY3PuxpCgOf6EWjE32iZp2k+kYSEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YQMiohMFvo/Sf2DRA9P0eAFmRX7K7BykuUSv7F+oRczhmD6mFWAeNQjakPtHgbxWeYQDH3I0zRbCMKbOn04VFP0NYdQV+35wtqqJDu9q5XDee+CbEh0cJ1gRJ/Yxdl4OrzkO/PJe45Z75ZDWAwqcUdQnicZ9InkwRxddRI+zdG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=STUiFrt/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D31CC116D0;
	Wed, 25 Feb 2026 17:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772040384;
	bh=irPtqkEmIrEl9xzY3PuxpCgOf6EWjE32iZp2k+kYSEQ=;
	h=From:To:Cc:Subject:Date:From;
	b=STUiFrt/YVVfmu5fO+VjG1aXLS4xalrfSdorAu4st8CGEOEX1pXi6/mld0+GK8ECJ
	 NHT5QmaiAjQOe+stExIbZueDVvqz6l5PkI1DNERetbGTWsJnk5FqZxfO4QPuNeVkw4
	 Jo3fYDPefBc9mzpp4lfrGHv1kAU5M1mJ+e42yd77azlBXYkkHyaLopb4iaACEyRVDy
	 SuSaNrR84OArjgHbXIvzIsGCgX1S825swE4l6WyO8nzME/RzsMMHOm0WvVbw9QhgB8
	 yXv3tJQ/Aa/V/XiP3SvIMrXRnYuKVpGlm+fSapETX5+oX/jY+aR4ZAuYUVHDAv6Sr6
	 El/GElwN564vA==
From: David Ahern <dsahern@kernel.org>
To: zyjzyj2000@gmail.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	David Ahern <dsahern@kernel.org>
Subject: [PATCH] RDMA/rxe: Add network namespace support
Date: Wed, 25 Feb 2026 10:26:21 -0700
Message-ID: <20260225172622.7589-1-dsahern@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17182-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,ziepe.ca,kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D0D2919B866
X-Rspamd-Action: no action

Allow rxe to work across network namespaces by making the sockets
per namespace using net_generic. Defer socket initialization until
a device is created in the namespace.

Signed-off-by: David Ahern <dsahern@kernel.org>
---
 drivers/infiniband/sw/rxe/rxe_net.c | 123 ++++++++++++++++++++--------
 1 file changed, 88 insertions(+), 35 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index 0bd0902b11f7..f51afc38c9df 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -18,7 +18,10 @@
 #include "rxe_net.h"
 #include "rxe_loc.h"
 
-static struct rxe_recv_sockets recv_sockets;
+static int __rxe_netns_init(struct net *net,
+			    struct rxe_recv_sockets *sockets);
+
+static unsigned int rxe_net_id;
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 /*
@@ -105,6 +108,7 @@ static struct dst_entry *rxe_find_route4(struct rxe_qp *qp,
 					 struct in_addr *saddr,
 					 struct in_addr *daddr)
 {
+	struct net *net = dev_net(ndev);
 	struct rtable *rt;
 	struct flowi4 fl = { { 0 } };
 
@@ -114,7 +118,7 @@ static struct dst_entry *rxe_find_route4(struct rxe_qp *qp,
 	memcpy(&fl.daddr, daddr, sizeof(*daddr));
 	fl.flowi4_proto = IPPROTO_UDP;
 
-	rt = ip_route_output_key(&init_net, &fl);
+	rt = ip_route_output_key(net, &fl);
 	if (IS_ERR(rt)) {
 		rxe_dbg_qp(qp, "no route to %pI4\n", &daddr->s_addr);
 		return NULL;
@@ -129,6 +133,8 @@ static struct dst_entry *rxe_find_route6(struct rxe_qp *qp,
 					 struct in6_addr *saddr,
 					 struct in6_addr *daddr)
 {
+	struct net *net = dev_net(ndev);
+	struct rxe_recv_sockets *recv_socket = net_generic(net, rxe_net_id);
 	struct dst_entry *ndst;
 	struct flowi6 fl6 = { { 0 } };
 
@@ -138,9 +144,8 @@ static struct dst_entry *rxe_find_route6(struct rxe_qp *qp,
 	memcpy(&fl6.daddr, daddr, sizeof(*daddr));
 	fl6.flowi6_proto = IPPROTO_UDP;
 
-	ndst = ipv6_stub->ipv6_dst_lookup_flow(sock_net(recv_sockets.sk6->sk),
-					       recv_sockets.sk6->sk, &fl6,
-					       NULL);
+	ndst = ipv6_stub->ipv6_dst_lookup_flow(net, recv_socket->sk6->sk,
+					       &fl6, NULL);
 	if (IS_ERR(ndst)) {
 		rxe_dbg_qp(qp, "no route to %pI6\n", daddr);
 		return NULL;
@@ -606,8 +611,16 @@ const char *rxe_parent_name(struct rxe_dev *rxe, unsigned int port_num)
 
 int rxe_net_add(const char *ibdev_name, struct net_device *ndev)
 {
-	int err;
+	struct net *net = dev_net(ndev);
+	struct rxe_recv_sockets *sockets = net_generic(net, rxe_net_id);
 	struct rxe_dev *rxe = NULL;
+	int err;
+
+	if (!sockets->sk4) {
+		err = __rxe_netns_init(net, sockets);
+		if (err)
+			return err;
+	}
 
 	rxe = ib_alloc_device(rxe_dev, ib_dev);
 	if (!rxe)
@@ -709,12 +722,13 @@ static struct notifier_block rxe_net_notifier = {
 	.notifier_call = rxe_notify,
 };
 
-static int rxe_net_ipv4_init(void)
+static int rxe_net_ipv4_init(struct net *net,
+			     struct rxe_recv_sockets *sockets)
 {
-	recv_sockets.sk4 = rxe_setup_udp_tunnel(&init_net,
-				htons(ROCE_V2_UDP_DPORT), false);
-	if (IS_ERR(recv_sockets.sk4)) {
-		recv_sockets.sk4 = NULL;
+	sockets->sk4 = rxe_setup_udp_tunnel(net, htons(ROCE_V2_UDP_DPORT),
+					    false);
+	if (IS_ERR(sockets->sk4)) {
+		sockets->sk4 = NULL;
 		pr_err("Failed to create IPv4 UDP tunnel\n");
 		return -1;
 	}
@@ -722,31 +736,74 @@ static int rxe_net_ipv4_init(void)
 	return 0;
 }
 
-static int rxe_net_ipv6_init(void)
-{
 #if IS_ENABLED(CONFIG_IPV6)
-
-	recv_sockets.sk6 = rxe_setup_udp_tunnel(&init_net,
-						htons(ROCE_V2_UDP_DPORT), true);
-	if (PTR_ERR(recv_sockets.sk6) == -EAFNOSUPPORT) {
-		recv_sockets.sk6 = NULL;
-		pr_warn("IPv6 is not supported, can not create a UDPv6 socket\n");
-		return 0;
-	}
-
-	if (IS_ERR(recv_sockets.sk6)) {
-		recv_sockets.sk6 = NULL;
+static int rxe_net_ipv6_init(struct net *net,
+			     struct rxe_recv_sockets *sockets)
+{
+	sockets->sk6 = rxe_setup_udp_tunnel(net, htons(ROCE_V2_UDP_DPORT),
+					    true);
+	if (IS_ERR(sockets->sk6)) {
+		sockets->sk6 = NULL;
 		pr_err("Failed to create IPv6 UDP tunnel\n");
 		return -1;
 	}
+	return 0;
+}
+#endif
+
+/* Initialize per network namespace state */
+static int __rxe_netns_init(struct net *net,
+			    struct rxe_recv_sockets *sockets)
+{
+	int err;
+
+	err = rxe_net_ipv4_init(net, sockets);
+	if (err)
+		return err;
+
+#if IS_ENABLED(CONFIG_IPV6)
+	err = rxe_net_ipv6_init(net, sockets);
+	if (err) {
+		rxe_release_udp_tunnel(sockets->sk4);
+		return err;
+	}
 #endif
+
+	return 0;
+}
+
+static int __net_init rxe_netns_init(struct net *net)
+{
+	/* defer socket create in the namespace to the first
+	 * device create.
+	 */
 	return 0;
 }
 
+static void __net_exit rxe_netns_exit(struct net *net)
+{
+	struct rxe_recv_sockets *sockets;
+
+	sockets = net_generic(net, rxe_net_id);
+
+#if IS_ENABLED(CONFIG_IPV6)
+	if (sockets->sk6)
+		rxe_release_udp_tunnel(sockets->sk6);
+#endif
+	if (sockets->sk4)
+		rxe_release_udp_tunnel(sockets->sk4);
+}
+
+static struct pernet_operations rxe_net_ops __net_initdata = {
+	.init = rxe_netns_init,
+	.exit = rxe_netns_exit,
+	.id   = &rxe_net_id,
+	.size = sizeof(struct rxe_recv_sockets),
+};
+
 void rxe_net_exit(void)
 {
-	rxe_release_udp_tunnel(recv_sockets.sk6);
-	rxe_release_udp_tunnel(recv_sockets.sk4);
+	unregister_pernet_device(&rxe_net_ops);
 	unregister_netdevice_notifier(&rxe_net_notifier);
 }
 
@@ -754,21 +811,17 @@ int rxe_net_init(void)
 {
 	int err;
 
-	recv_sockets.sk6 = NULL;
-
-	err = rxe_net_ipv4_init();
-	if (err)
-		return err;
-	err = rxe_net_ipv6_init();
-	if (err)
-		goto err_out;
 	err = register_netdevice_notifier(&rxe_net_notifier);
 	if (err) {
 		pr_err("Failed to register netdev notifier\n");
 		goto err_out;
 	}
+	err = register_pernet_device(&rxe_net_ops);
+	if (err)
+		goto err_out;
+
 	return 0;
 err_out:
-	rxe_net_exit();
+	unregister_netdevice_notifier(&rxe_net_notifier);
 	return err;
 }
-- 
2.43.0


