Return-Path: <linux-rdma+bounces-22755-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id l7D8J6HjSGr3uwAAu9opvQ
	(envelope-from <linux-rdma+bounces-22755-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 04 Jul 2026 12:42:41 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2507075AB
	for <lists+linux-rdma@lfdr.de>; Sat, 04 Jul 2026 12:42:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=IROJxqDN;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22755-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22755-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8BD23015C82
	for <lists+linux-rdma@lfdr.de>; Sat,  4 Jul 2026 10:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C924C397323;
	Sat,  4 Jul 2026 10:42:37 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE56314A84
	for <linux-rdma@vger.kernel.org>; Sat,  4 Jul 2026 10:42:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783161757; cv=none; b=U+8GZhfr0lesB+8WeMeMcwyz8jnpBmHin/ABssxnC23Yi0eDgpoXwt/w9yYKhWgkdzoZf9dg8PVxkZhcZbz+pWOlNY+OBTU5SemcpGI3feDeOdQpFwflbKO+qfZdAUCpqdEczeUvwKBTMQr330yb/hV7KIbgNWqasqYnTE9IoT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783161757; c=relaxed/simple;
	bh=K8ZJXvGtZwtAC5ZhJ2lSMSFOVnJZVmdCBzA6NsHwvos=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p18gemCyVkij27aPcWiCFuY+YpgkEWQ+Zon4MoRDXYjZtWdBL6wQU4ubqTxinBHFmIlv6YjRV9gAwVJLsWMtrBRW6roqHPAJVbiJ7XwPJsgH/D+4fVEHdCvyGi4Gi9NjSxN/i84oZddzywY/GPVH+6PUmtER67aZUn/wzP97naQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IROJxqDN; arc=none smtp.client-ip=209.85.221.68
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-4799b3f7c83so935167f8f.2
        for <linux-rdma@vger.kernel.org>; Sat, 04 Jul 2026 03:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783161754; x=1783766554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uj0mlmjo8ysLWYouM9WXZnybVfYpqeQXeKLq68UG620=;
        b=IROJxqDNYELkNg4ch7d5sHqUENE+NLohA7koxGQTTPRBVnbOGYk9lBmHh79O6ZTd0M
         zo22cEXromeBBRoKYCPlwjRCxCbmRd+nUbX7vyWhgkxaon/FQcvOxWJXTlRfmHQE4zZf
         SmdU4ATlP9tRHt1o5FCb8nR5h90KgDyqkU4CLrD3cwE5amMVfn4tjgotUmL8eE43Iy+p
         1pCfQ0T4ooXASkmMrJk6DR2jdnwao9M4tcFRLl3yFiOMUXpJTjW6UJFBp+QOUk0bKXXn
         qfTIbjt6pgkrap/GS4HUpesEOI0j2ABeafX15H/6dvatv+dmb/in/fvSPeB8ZM63fOcA
         bJtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783161754; x=1783766554;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uj0mlmjo8ysLWYouM9WXZnybVfYpqeQXeKLq68UG620=;
        b=YZFLCOboE+JYOp9MqVHN3/ZNSkq8pXXp0xifke7N4YjSxEx3DGPVdkmIY5noRf8svU
         6zBoiip9uH3ZtMDUGZLcVwLQYXzowYBOuB2Zt67QsEPVRHUbZz697T9aMR+gINbwvHHu
         SatWUqjPCr7u8Ye16+qjy+C/VFATzy/wn+Cjg7lPA2np2WU0y/PAxOeYHCHEu0SrCXzf
         VywUe4eQfMvj+IXaloZcV8mniUcQvz7rEUgOfIoFbZfBFzFQ90qBj9kcHz9EzZ0+vP04
         1nMx6brvAM86kVeu8QRFjF3N8jBGml38q0NIhIFlLwS9wKcWJDOpF5iROrwPxCMyY2bq
         fPOQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpp2lt9DUVfAARh8MHD3XvakJ402qnRvFkjHiMnPLHIoYXxggChlPG3NN44V3fURiGlNxN7ig7p2ns6@vger.kernel.org
X-Gm-Message-State: AOJu0YwIWvyojCNFmPSo3rofsyhTPO3+/lUPlD23Ijr9mZK/m0waj6mG
	bZkEw+o24zZ3UetqE29qtoKpWNLFX+eKTF9Xo60c8ohBw3+08G551YeL
X-Gm-Gg: AfdE7clRZuYVRDjrnt96D5d6g6T71KpWN6LH11aj5A7lrtXXMwAr3chi5Cs1GT5p/JC
	3HPgeqhqJFZIUwfDtSxtuW0hFbrFVGdGN6P1sVYtHLVelDs+K2FnSxrG9vCk0ZpMLfBzOEzUsP9
	dojbeTBgOOUrm2SxY+yf+SVM88CmhjxUbi+YH5rIIDRwuL8OH+NRYxpPXmAjKRP6GBWNpOvGlQT
	wt+Ppqntyzf5U4igtRX2xlshka98LTKqJngHDMoJUdCYaWr+yTEY1oRw1JgJKh3m4FWoVxECM3J
	uXi3QG7hGiu79ikKiunl23NigrZn6re9tkzDP9XsbiC2c3fVIXkfOCpLH/b7bH9v/eoEClFqgMa
	3E57adO1CKXSHhLNJwXyWofx/Idcc4RlxcLP1UqHuPFJix+oaWAASbbC03vagWApVvVTPU1Rnf6
	nyGv2ElpgjRAs=
X-Received: by 2002:a05:6000:4691:b0:475:f0c2:75a3 with SMTP id ffacd0b85a97d-47aace8ea7fmr2162266f8f.52.1783161753795;
        Sat, 04 Jul 2026 03:42:33 -0700 (PDT)
Received: from fedora ([212.253.209.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1e736sm8023752f8f.7.2026.07.04.03.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 03:42:33 -0700 (PDT)
From: Serhat Kumral <serhatkumral1@gmail.com>
To: Zhu Yanjun <zyjzyj2000@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: David Ahern <dsahern@kernel.org>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+8c9eede336e3a843750e@syzkaller.appspotmail.com,
	Serhat Kumral <serhatkumral1@gmail.com>
Subject: [PATCH] RDMA/rxe: rework per-net tunnel socket lifetime to fix refcount underflow
Date: Sat,  4 Jul 2026 13:25:03 +0300
Message-ID: <20260704102503.89272-1-serhatkumral1@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[serhatkumral1@gmail.com,linux-rdma@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,syzkaller.appspotmail.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-22755-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zyjzyj2000@gmail.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:dsahern@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:syzbot+8c9eede336e3a843750e@syzkaller.appspotmail.com,m:serhatkumral1@gmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,ziepe.ca,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[serhatkumral1@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,8c9eede336e3a843750e];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,appspotmail.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EF2507075AB

syzkaller reported a refcount_t underflow / use-after-free in
sk_common_release() when tearing down an rxe device via
RDMA_NLDEV_CMD_DELLINK. The shared per-namespace UDP tunnel sockets
were released based on comparing sk->sk_refcnt against a magic
constant (SK_REF_FOR_TUNNEL), but the network stack takes transient
references on sk_refcnt of its own, so this check could pass on more
than one path concurrently (dellink, NETDEV_UNREGISTER notifier,
pernet exit), releasing the socket twice.

Stop overloading sk_refcnt for driver-level user counting. Track the
number of rxe devices using each tunnel socket with an explicit
per-socket counter in the pernet struct, serialised by a mutex:

 - creation happens under the lock via a factory callback, closing
   the create/create race,
 - release happens in exactly one place, when the counter drops to
   zero: clear the RCU pointer, wait a grace period, then call
   udp_tunnel_sock_release(),
 - a failed rxe_newlink() now drops the references it took, so the
   counter cannot be left inflated,
 - rxe_ns_exit() performs the same coordinated teardown for
   namespace removal.

IPv4 and IPv6 sockets get separate counters since the IPv6 socket may
legitimately not exist (-EAFNOSUPPORT).

Fixes: f1327abd6abe ("RDMA/rxe: Support RDMA link creation and destruction per net namespace")
Reported-by: syzbot+8c9eede336e3a843750e@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=8c9eede336e3a843750e
Signed-off-by: Serhat Kumral <serhatkumral1@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe.c     |   1 +
 drivers/infiniband/sw/rxe/rxe_net.c | 100 ++++++++-------------
 drivers/infiniband/sw/rxe/rxe_net.h |   1 +
 drivers/infiniband/sw/rxe/rxe_ns.c  | 132 ++++++++++++++++++++--------
 drivers/infiniband/sw/rxe/rxe_ns.h  |  24 ++++-
 5 files changed, 157 insertions(+), 101 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index af39209d0fcf..bcc72b96ee00 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -243,6 +243,7 @@ static int rxe_newlink(const char *ibdev_name, struct net_device *ndev)
 	err = rxe_net_add(ibdev_name, ndev);
 	if (err) {
 		rxe_err("failed to add %s\n", ndev->name);
+		rxe_net_uninit(ndev);
 		goto err;
 	}
 err:
diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index 3741b2c4b0bb..e30a9e899faa 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -19,10 +19,6 @@
 #include "rxe_loc.h"
 #include "rxe_ns.h"
 
-#ifndef SK_REF_FOR_TUNNEL
-#define SK_REF_FOR_TUNNEL	2
-#endif
-
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 /*
  * lockdep can detect false positive circular dependencies
@@ -81,9 +77,9 @@ static inline void rxe_reclassify_recv_socket(struct socket *sock)
 	 * from being called and 'rmmod rdma_rxe'
 	 * is refused because of the references.
 	 *
-	 * For the global sockets in recv_sockets,
-	 * we are sure that rxe_net_exit() will call
-	 * rxe_release_udp_tunnel -> udp_tunnel_sock_release.
+	 * For the shared per-namespace sockets, we are sure
+	 * that the pernet layer (rxe_ns_pernet_put_skX or
+	 * rxe_ns_exit) will call udp_tunnel_sock_release.
 	 *
 	 * So we don't need the additional reference to
 	 * our own (THIS_MODULE).
@@ -288,12 +284,6 @@ static struct socket *rxe_setup_udp_tunnel(struct net *net, __be16 port,
 	return sock;
 }
 
-static void rxe_release_udp_tunnel(struct sock *sk)
-{
-	if (sk)
-		udp_tunnel_sock_release(sk);
-}
-
 static void prepare_udp_hdr(struct sk_buff *skb, __be16 src_port,
 			    __be16 dst_port)
 {
@@ -631,38 +621,23 @@ int rxe_net_add(const char *ibdev_name, struct net_device *ndev)
 	return 0;
 }
 
-static void rxe_sock_put(struct sock *sk,
-					void (*set_sk)(struct net *, struct sock *),
-					struct net *net)
+void rxe_net_uninit(struct net_device *ndev)
 {
-	if (refcount_read(&sk->sk_refcnt) > SK_REF_FOR_TUNNEL) {
-		__sock_put(sk);
-	} else {
-		rxe_release_udp_tunnel(sk);
-		sk = NULL;
-		set_sk(net, sk);
-	}
+	struct net *net = dev_net(ndev);
+
+	rxe_ns_pernet_put_sk4(net);
+	rxe_ns_pernet_put_sk6(net);
 }
 
 void rxe_net_del(struct ib_device *dev)
 {
 	struct net_device *ndev;
-	struct sock *sk;
-	struct net *net;
 
 	ndev = ib_device_get_netdev(dev, 1);
 	if (!ndev)
 		return;
 
-	net = dev_net(ndev);
-
-	sk = rxe_ns_pernet_sk4(net);
-	if (sk)
-		rxe_sock_put(sk, rxe_ns_pernet_set_sk4, net);
-
-	sk = rxe_ns_pernet_sk6(net);
-	if (sk)
-		rxe_sock_put(sk, rxe_ns_pernet_set_sk6, net);
+	rxe_net_uninit(ndev);
 
 	dev_put(ndev);
 }
@@ -753,52 +728,58 @@ static struct notifier_block rxe_net_notifier = {
 	.notifier_call = rxe_notify,
 };
 
-static int rxe_net_ipv4_init(struct net *net)
+static struct sock *rxe_create_sk4(struct net *net)
 {
-	struct sock *sk;
 	struct socket *sock;
 
-	sk = rxe_ns_pernet_sk4(net);
-	if (sk) {
-		sock_hold(sk);
-		return 0;
-	}
-
 	sock = rxe_setup_udp_tunnel(net, htons(ROCE_V2_UDP_DPORT), false);
 	if (IS_ERR(sock)) {
 		pr_err("Failed to create IPv4 UDP tunnel\n");
-		return -1;
+		return ERR_CAST(sock);
 	}
-	rxe_ns_pernet_set_sk4(net, sock->sk);
 
-	return 0;
+	return sock->sk;
 }
 
-static int rxe_net_ipv6_init(struct net *net)
+static int rxe_net_ipv4_init(struct net *net)
 {
-#if IS_ENABLED(CONFIG_IPV6)
 	struct sock *sk;
-	struct socket *sock;
 
-	sk = rxe_ns_pernet_sk6(net);
-	if (sk) {
-		sock_hold(sk);
-		return 0;
-	}
+	sk = rxe_ns_pernet_hold_sk4(net, rxe_create_sk4);
+	if (IS_ERR(sk))
+		return PTR_ERR(sk);
+
+	return 0;
+}
+
+#if IS_ENABLED(CONFIG_IPV6)
+static struct sock *rxe_create_sk6(struct net *net)
+{
+	struct socket *sock;
 
 	sock = rxe_setup_udp_tunnel(net, htons(ROCE_V2_UDP_DPORT), true);
 	if (PTR_ERR(sock) == -EAFNOSUPPORT) {
 		pr_warn("IPv6 is not supported, can not create a UDPv6 socket\n");
-		return 0;
+		return NULL;
 	}
 
 	if (IS_ERR(sock)) {
 		pr_err("Failed to create IPv6 UDP tunnel\n");
-		return -1;
+		return ERR_CAST(sock);
 	}
 
-	rxe_ns_pernet_set_sk6(net, sock->sk);
+	return sock->sk;
+}
+#endif
+
+static int rxe_net_ipv6_init(struct net *net)
+{
+#if IS_ENABLED(CONFIG_IPV6)
+	struct sock *sk;
 
+	sk = rxe_ns_pernet_hold_sk6(net, rxe_create_sk6);
+	if (IS_ERR(sk))
+		return PTR_ERR(sk);
 #endif
 	return 0;
 }
@@ -824,7 +805,6 @@ void rxe_net_exit(void)
 int rxe_net_init(struct net_device *ndev)
 {
 	struct net *net;
-	struct sock *sk;
 	int err;
 
 	net = dev_net(ndev);
@@ -840,10 +820,8 @@ int rxe_net_init(struct net_device *ndev)
 	return 0;
 
 err_out:
-	/* If ipv6 error, release ipv4 resource */
-	sk = rxe_ns_pernet_sk4(net);
-	if (sk)
-		rxe_sock_put(sk, rxe_ns_pernet_set_sk4, net);
+	/* If ipv6 error, drop the ipv4 reference taken above. */
+	rxe_ns_pernet_put_sk4(net);
 
 	return err;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_net.h b/drivers/infiniband/sw/rxe/rxe_net.h
index 56249677d692..06e08a4d5897 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.h
+++ b/drivers/infiniband/sw/rxe/rxe_net.h
@@ -13,6 +13,7 @@
 
 int rxe_net_add(const char *ibdev_name, struct net_device *ndev);
 void rxe_net_del(struct ib_device *dev);
+void rxe_net_uninit(struct net_device *ndev);
 
 int rxe_register_notifier(void);
 int rxe_net_init(struct net_device *ndev);
diff --git a/drivers/infiniband/sw/rxe/rxe_ns.c b/drivers/infiniband/sw/rxe/rxe_ns.c
index 64621c89f8bf..d12099a73aa2 100644
--- a/drivers/infiniband/sw/rxe/rxe_ns.c
+++ b/drivers/infiniband/sw/rxe/rxe_ns.c
@@ -4,6 +4,8 @@
 #include <net/netns/generic.h>
 #include <net/net_namespace.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/err.h>
 #include <linux/skbuff.h>
 #include <linux/pid_namespace.h>
 #include <net/udp_tunnel.h>
@@ -11,11 +13,21 @@
 #include "rxe_ns.h"
 
 /*
- * Per network namespace data
+ * Per network namespace data.
+ *
+ * The IPv4/IPv6 UDP tunnel sockets are shared by every rxe device created in
+ * a given namespace. Their lifetime is owned here and tracked by an explicit
+ * user count (nr_skX) rather than by overloading sk->sk_refcnt: the network
+ * stack takes transient references on sk_refcnt of its own, so it can never be
+ * used to decide when the last rxe device is gone. All fields are serialised
+ * by @lock.
  */
 struct rxe_ns_sock {
+	struct mutex lock; /* protects rxe_sk4/6 and nr_sk4/6 */
 	struct sock __rcu *rxe_sk4;
 	struct sock __rcu *rxe_sk6;
+	int nr_sk4;
+	int nr_sk6;
 };
 
 /*
@@ -28,37 +40,39 @@ static unsigned int rxe_pernet_id;
  */
 static int rxe_ns_init(struct net *net)
 {
-	/* defer socket create in the namespace to the first
-	 * device create.
-	 */
+	struct rxe_ns_sock *ns_sk = net_generic(net, rxe_pernet_id);
+
+	/* Socket creation is deferred to the first device create. */
+	mutex_init(&ns_sk->lock);
 
 	return 0;
 }
 
 static void rxe_ns_exit(struct net *net)
 {
-	/* called when the network namespace is removed
-	 */
+	/* called when the network namespace is removed */
 	struct rxe_ns_sock *ns_sk = net_generic(net, rxe_pernet_id);
-	struct sock *sk;
-
-	rcu_read_lock();
-	sk = rcu_dereference(ns_sk->rxe_sk4);
-	rcu_read_unlock();
-	if (sk) {
-		rcu_assign_pointer(ns_sk->rxe_sk4, NULL);
-		udp_tunnel_sock_release(sk);
-	}
-
-#if IS_ENABLED(CONFIG_IPV6)
-	rcu_read_lock();
-	sk = rcu_dereference(ns_sk->rxe_sk6);
-	rcu_read_unlock();
-	if (sk) {
-		rcu_assign_pointer(ns_sk->rxe_sk6, NULL);
-		udp_tunnel_sock_release(sk);
-	}
-#endif
+	struct sock *sk4, *sk6;
+
+	mutex_lock(&ns_sk->lock);
+	sk4 = rcu_dereference_protected(ns_sk->rxe_sk4,
+					lockdep_is_held(&ns_sk->lock));
+	sk6 = rcu_dereference_protected(ns_sk->rxe_sk6,
+					lockdep_is_held(&ns_sk->lock));
+	rcu_assign_pointer(ns_sk->rxe_sk4, NULL);
+	rcu_assign_pointer(ns_sk->rxe_sk6, NULL);
+	ns_sk->nr_sk4 = 0;
+	ns_sk->nr_sk6 = 0;
+	mutex_unlock(&ns_sk->lock);
+
+	if (sk4 || sk6)
+		synchronize_rcu();
+	if (sk4)
+		udp_tunnel_sock_release(sk4);
+	if (sk6)
+		udp_tunnel_sock_release(sk6);
+
+	mutex_destroy(&ns_sk->lock);
 }
 
 /*
@@ -71,24 +85,64 @@ static struct pernet_operations rxe_net_ops = {
 	.size = sizeof(struct rxe_ns_sock),
 };
 
-struct sock *rxe_ns_pernet_sk4(struct net *net)
+static struct sock *rxe_ns_hold(struct rxe_ns_sock *ns_sk,
+				struct sock __rcu **skp, int *nrp,
+				struct net *net, rxe_sk_create_t create)
 {
-	struct rxe_ns_sock *ns_sk = net_generic(net, rxe_pernet_id);
 	struct sock *sk;
 
-	rcu_read_lock();
-	sk = rcu_dereference(ns_sk->rxe_sk4);
-	rcu_read_unlock();
+	mutex_lock(&ns_sk->lock);
+	sk = rcu_dereference_protected(*skp, lockdep_is_held(&ns_sk->lock));
+	if (sk) {
+		(*nrp)++;
+		mutex_unlock(&ns_sk->lock);
+		return sk;
+	}
+
+	sk = create(net);
+	if (IS_ERR_OR_NULL(sk)) {
+		mutex_unlock(&ns_sk->lock);
+		return sk;
+	}
+
+	rcu_assign_pointer(*skp, sk);
+	*nrp = 1;
+	mutex_unlock(&ns_sk->lock);
 
 	return sk;
 }
 
-void rxe_ns_pernet_set_sk4(struct net *net, struct sock *sk)
+static void rxe_ns_put(struct rxe_ns_sock *ns_sk,
+		       struct sock __rcu **skp, int *nrp)
+{
+	struct sock *sk = NULL;
+
+	mutex_lock(&ns_sk->lock);
+	if (*nrp > 0 && --(*nrp) == 0) {
+		sk = rcu_dereference_protected(*skp,
+					       lockdep_is_held(&ns_sk->lock));
+		rcu_assign_pointer(*skp, NULL);
+	}
+	mutex_unlock(&ns_sk->lock);
+
+	if (sk) {
+		synchronize_rcu();
+		udp_tunnel_sock_release(sk);
+	}
+}
+
+struct sock *rxe_ns_pernet_hold_sk4(struct net *net, rxe_sk_create_t create)
+{
+	struct rxe_ns_sock *ns_sk = net_generic(net, rxe_pernet_id);
+
+	return rxe_ns_hold(ns_sk, &ns_sk->rxe_sk4, &ns_sk->nr_sk4, net, create);
+}
+
+void rxe_ns_pernet_put_sk4(struct net *net)
 {
 	struct rxe_ns_sock *ns_sk = net_generic(net, rxe_pernet_id);
 
-	rcu_assign_pointer(ns_sk->rxe_sk4, sk);
-	synchronize_rcu();
+	rxe_ns_put(ns_sk, &ns_sk->rxe_sk4, &ns_sk->nr_sk4);
 }
 
 #if IS_ENABLED(CONFIG_IPV6)
@@ -104,12 +158,18 @@ struct sock *rxe_ns_pernet_sk6(struct net *net)
 	return sk;
 }
 
-void rxe_ns_pernet_set_sk6(struct net *net, struct sock *sk)
+struct sock *rxe_ns_pernet_hold_sk6(struct net *net, rxe_sk_create_t create)
+{
+	struct rxe_ns_sock *ns_sk = net_generic(net, rxe_pernet_id);
+
+	return rxe_ns_hold(ns_sk, &ns_sk->rxe_sk6, &ns_sk->nr_sk6, net, create);
+}
+
+void rxe_ns_pernet_put_sk6(struct net *net)
 {
 	struct rxe_ns_sock *ns_sk = net_generic(net, rxe_pernet_id);
 
-	rcu_assign_pointer(ns_sk->rxe_sk6, sk);
-	synchronize_rcu();
+	rxe_ns_put(ns_sk, &ns_sk->rxe_sk6, &ns_sk->nr_sk6);
 }
 #endif /* IPV6 */
 
diff --git a/drivers/infiniband/sw/rxe/rxe_ns.h b/drivers/infiniband/sw/rxe/rxe_ns.h
index 4da2709e6b71..fe96b8abb8dc 100644
--- a/drivers/infiniband/sw/rxe/rxe_ns.h
+++ b/drivers/infiniband/sw/rxe/rxe_ns.h
@@ -3,19 +3,35 @@
 #ifndef RXE_NS_H
 #define RXE_NS_H
 
-struct sock *rxe_ns_pernet_sk4(struct net *net);
-void rxe_ns_pernet_set_sk4(struct net *net, struct sock *sk);
+/*
+ * Factory used to create a shared per-namespace tunnel socket while the
+ * pernet lock is held. It must return:
+ *   - a valid sk on success,
+ *   - NULL if the address family is unsupported (not treated as an error),
+ *   - an ERR_PTR() on failure.
+ */
+typedef struct sock *(*rxe_sk_create_t)(struct net *net);
+
+struct sock *rxe_ns_pernet_hold_sk4(struct net *net, rxe_sk_create_t create);
+void rxe_ns_pernet_put_sk4(struct net *net);
 
 #if IS_ENABLED(CONFIG_IPV6)
-void rxe_ns_pernet_set_sk6(struct net *net, struct sock *sk);
 struct sock *rxe_ns_pernet_sk6(struct net *net);
+struct sock *rxe_ns_pernet_hold_sk6(struct net *net, rxe_sk_create_t create);
+void rxe_ns_pernet_put_sk6(struct net *net);
 #else /* IPv6 */
 static inline struct sock *rxe_ns_pernet_sk6(struct net *net)
 {
 	return NULL;
 }
 
-static inline void rxe_ns_pernet_set_sk6(struct net *net, struct sock *sk)
+static inline struct sock *rxe_ns_pernet_hold_sk6(struct net *net,
+						  rxe_sk_create_t create)
+{
+	return NULL;
+}
+
+static inline void rxe_ns_pernet_put_sk6(struct net *net)
 {
 }
 #endif /* IPv6 */
-- 
2.54.0


