Return-Path: <linux-rdma+bounces-22840-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SBFYBHYoTWravwEAu9opvQ
	(envelope-from <linux-rdma+bounces-22840-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Jul 2026 18:25:26 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BB671DD52
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Jul 2026 18:25:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=m7XIcgt3;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22840-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22840-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DE57F305C879
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2026 16:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290ED430CDE;
	Tue,  7 Jul 2026 16:20:30 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm2-f0.google.com (mail-wm2-f0.google.com [74.125.225.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C893732B10E
	for <linux-rdma@vger.kernel.org>; Tue,  7 Jul 2026 16:20:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783441229; cv=none; b=AOEjumTGLNtudjPqnFXSG7jyHEzDXcV1TdgcyqpaghMvy1hwR2dvAp/dtMjPdz/NFuxM2SNwpSbVZITZVMF4HakaxfjyV/PdcbjF1e1PXXc7J0yc9/Nm5/PhuQGiohc7Vl0LNtrS2TIQC7gC0PpcMiU4vRmTY+76veaHOGWUELU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783441229; c=relaxed/simple;
	bh=SDLo5xSa2fVOIn1J4Coowg+qPVkI+Ly7fmPPJzWwwKk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yj4otG/YXqy7+b6Oq+UXExD9CCbIeAQnZ4Hyt53j2/0gYPXFHudpXxhucrecp/SH0aTsK3Milys6X26LWyCouyMbF2BjZKHbCTWZjeTZ7EJbB1oCO0qtrx6SjzdnDf4eGQa3ZXUmdZx1IqEQd8V9r8Jrt02p4EqG1rOsqMfeGKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m7XIcgt3; arc=none smtp.client-ip=74.125.225.128
Received: by mail-wm2-f0.google.com with SMTP id 5b1f17b1804b1-492367e8e15so5786075e9.0
        for <linux-rdma@vger.kernel.org>; Tue, 07 Jul 2026 09:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783441226; x=1784046026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2LRYzk3x5oEpkR4nD2t4RvjUX/Tfg/wPTiIRHY6G9Pg=;
        b=m7XIcgt3MT1sVlow46eYOV6RXbor4OZ3DWJA10vAycPizvdu5eFifcwCe6LvQKODCA
         qJkS5xiR9YgYv17U9N4r+sl8/fV6j4S0hz5wRRQKAob8eSkcK90rH8F9rfHFbUj98AVt
         6EWZOjs1K3+OvFvDXqaw7BbgOxPnSmB2i2jEc1jggWM8/KqUgcRF89iMJ6UjHU1B7cAM
         FZOFpfYwoBwqQqL37b+QGsxEZIU2mnA036SKx0S4il1147DjvePFTNLU0jI/HStdN268
         eG3LoqsL91Y6cJGXi7MdZX8Awp+aBbELPL+vwIzskROqpD+AW2Wyso2uKuxEu0GU/+kv
         U51w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783441226; x=1784046026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2LRYzk3x5oEpkR4nD2t4RvjUX/Tfg/wPTiIRHY6G9Pg=;
        b=kMjnH56hfJfD5vCAUWqt3RPtQRDLbg+aFmn3sqKDHWJ/535XUF6lSVrcWZXWN2VQ4X
         Dx+SY9RMT+2B/xGFO5qZY7pMOze+X68Bp1/VN6fXWb23ZO6EePIDaJdcgcNniQPO91kL
         0Fp1zf8e2lZwHRkBF3b5ERTuE3WVkE+o7xt0RuYD4Wtq6pPM7389Yd1M6M5k8HZs0aC0
         KULJ7ys4dpMz7QRUVdEyFCKmFlaGhlXMae2fAHoNhUotwZljWxZ6oZlEucfu4wSXdfBl
         csJ9wCF3ROdEE9Rwc/oUx5e7KITVylKGL6edX4D49vfP1BTqzkIDO1SHFJcNdE5J9Gsa
         WYJA==
X-Forwarded-Encrypted: i=1; AHgh+RrPvUbUsTyISMI1M4IxbcI8vaxcbekCPwymai8j1MovIm+0IBcripsdLb8f9S6ZF4lGupssM87mlF+2@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4nqW8Hgm6TCv2CZ2smVgMXC/CJS/dY1tDbA9wZyjSpkBB56qH
	HIA66ZOQx7SJVwqtGpqoN4Pi00vfaAWXP3VWEK095Az0abOkApnKFvkm
X-Gm-Gg: AfdE7ckYq1uLcljiqCsUQhyg2cIIuKT84NFNANvjFneJTbONSiUacHNjCHuLM+Cz1GU
	au/I1iIsz8N5B0aaC/tCPwUPaBxKVTSM7+ykHFf+HrwEZVnpmp1dwgyLm7w0dcmGMQ3YbwDke4H
	Qm0ADbCKkB0LbatkVmxGxDug4fAN4DsH6cKyEmYZGzAxusSWt0nhaLXnPuZwrOXEUt7GLj+NFSZ
	tfiJIvEGNUZV8jgLpDWyqDYD5hZBggAasA1Zrj5CeExE4GKk1fmUIxO+Qf3p6T7H8rGn2tOEba+
	M5gvl6B5Vu+Sn04KKRvaTLirCoGO+D4YKtkQfscDWtEFiBPLfM9VYVzuBYG6ivMsYbIWJv1lAnR
	QFxz7pH8NYnWD166YqYwC/Wh/6bk5h+ZlNq3M/Yig7LTlrWHlZ/l9JRArCcdyafWIYpWEd30KKL
	WJgPoSA3+28Lw=
X-Received: by 2002:a05:600c:154e:b0:493:d216:ed96 with SMTP id 5b1f17b1804b1-493df0b6a8emr65405355e9.9.1783441225832;
        Tue, 07 Jul 2026 09:20:25 -0700 (PDT)
Received: from fedora ([212.253.209.56])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0fbd355sm59648495e9.13.2026.07.07.09.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 09:20:25 -0700 (PDT)
From: Serhat Kumral <serhatkumral1@gmail.com>
To: Zhu Yanjun <yanjun.zhu@linux.dev>,
	Zhu Yanjun <zyjzyj2000@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: David Ahern <dsahern@kernel.org>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+8c9eede336e3a843750e@syzkaller.appspotmail.com,
	Serhat Kumral <serhatkumral1@gmail.com>
Subject: [PATCH v3] RDMA/rxe: rework per-net tunnel socket lifetime to fix refcount underflow
Date: Tue,  7 Jul 2026 19:00:14 +0300
Message-ID: <20260707160015.18208-1-serhatkumral1@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,syzkaller.appspotmail.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22840-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:yanjun.zhu@linux.dev,m:zyjzyj2000@gmail.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:dsahern@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:syzbot+8c9eede336e3a843750e@syzkaller.appspotmail.com,m:serhatkumral1@gmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[linux.dev,gmail.com,ziepe.ca,kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[serhatkumral1@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[serhatkumral1@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,8c9eede336e3a843750e];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,appspotmail.com:email,syzkaller.appspot.com:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 76BB671DD52

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
 - rxe_net_del() is idempotent per device: RDMA_NLDEV_CMD_DELLINK
   and the NETDEV_UNREGISTER notifier can run concurrently for the
   same device, and only the first invocation drops the references.
   The put uses the net pointer recorded at device creation time
   instead of ib_device_get_netdev(), which can already return NULL
   at this point (the queued unregister clears the association), so
   the invocation that owns the put can never fail to perform it,
 - a failed rxe_newlink() now drops the references it took, so the
   counter cannot be left inflated,
 - rxe_ns_exit() performs the same coordinated teardown for
   namespace removal.

IPv4 and IPv6 sockets get separate counters since the IPv6 socket may
legitimately not exist (-EAFNOSUPPORT).

Fixes: f1327abd6abe ("RDMA/rxe: Support RDMA link creation and destruction per net namespace")
Reported-by: syzbot+8c9eede336e3a843750e@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=8c9eede336e3a843750e
Assisted-by: Claude:claude-fable-5
Signed-off-by: Serhat Kumral <serhatkumral1@gmail.com>
---
v3:
 - Fix the ordering problem Zhu Yanjun pointed out in v2: rxe_net_del()
   consumed the once-only RXE_NET_SK_PUT bit before looking up the
   netdev, so if ib_device_get_netdev() returned NULL (the queued
   unregister already cleared the association), the pernet socket
   references were never dropped. [Zhu Yanjun]
 - Instead of only reordering the bit test against the netdev lookup,
   record the struct net pointer in struct rxe_dev at creation time
   and use it for the put, so the put cannot fail at all once the bit
   is taken. I went this way because a reordered lookup still has a
   (much smaller) window where both racing paths see a NULL netdev.
   If you think this is over-engineered and would prefer the minimal
   reordering fix, I am happy to respin it that way.

v2:
 - Make rxe_net_del() idempotent per device with test_and_set_bit()
   in struct rxe_dev, so a concurrent RDMA_NLDEV_CMD_DELLINK and
   NETDEV_UNREGISTER notifier cannot drop the pernet socket
   references twice for the same device. Suggested as an alternative
   to rtnl_lock()/a global mutex. [Zhu Yanjun]
 - Add Assisted-by tag per Documentation/process/coding-assistants.rst.

 drivers/infiniband/sw/rxe/rxe.c       |   1 +
 drivers/infiniband/sw/rxe/rxe_net.c   | 117 ++++++++++-------------
 drivers/infiniband/sw/rxe/rxe_net.h   |   1 +
 drivers/infiniband/sw/rxe/rxe_ns.c    | 132 +++++++++++++++++++-------
 drivers/infiniband/sw/rxe/rxe_ns.h    |  24 ++++-
 drivers/infiniband/sw/rxe/rxe_verbs.h |   8 ++
 6 files changed, 177 insertions(+), 106 deletions(-)

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
index 3741b2c4b0bb..02c0d2be36ad 100644
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
@@ -620,6 +610,8 @@ int rxe_net_add(const char *ibdev_name, struct net_device *ndev)
 	if (!rxe)
 		return -ENOMEM;
 
+	rxe->net = dev_net(ndev);
+
 	ib_mark_name_assigned_by_user(&rxe->ib_dev);
 
 	err = rxe_add(rxe, ndev->mtu, ibdev_name, ndev);
@@ -631,40 +623,30 @@ int rxe_net_add(const char *ibdev_name, struct net_device *ndev)
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
-	struct net_device *ndev;
-	struct sock *sk;
-	struct net *net;
+	struct rxe_dev *rxe = container_of(dev, struct rxe_dev, ib_dev);
 
-	ndev = ib_device_get_netdev(dev, 1);
-	if (!ndev)
+	/*
+	 * Both RDMA_NLDEV_CMD_DELLINK and the NETDEV_UNREGISTER notifier
+	 * can get here concurrently for the same device. Only the first
+	 * one drops the pernet socket references. Use the net recorded
+	 * at rxe_net_add() time: the ib_device to netdev association may
+	 * already be gone here, so the put must not depend on it.
+	 */
+	if (test_and_set_bit(RXE_NET_SK_PUT, &rxe->net_flags))
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
-
-	dev_put(ndev);
+	rxe_ns_pernet_put_sk4(rxe->net);
+	rxe_ns_pernet_put_sk6(rxe->net);
 }
 
 static void rxe_port_event(struct rxe_dev *rxe,
@@ -753,52 +735,58 @@ static struct notifier_block rxe_net_notifier = {
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
@@ -824,7 +812,6 @@ void rxe_net_exit(void)
 int rxe_net_init(struct net_device *ndev)
 {
 	struct net *net;
-	struct sock *sk;
 	int err;
 
 	net = dev_net(ndev);
@@ -840,10 +827,8 @@ int rxe_net_init(struct net_device *ndev)
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
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 0f5ffd94643f..ffb2e2a71737 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -415,12 +415,20 @@ struct rxe_port {
 	u32			qp_gsi_index;
 };
 
+enum rxe_net_flags {
+	/* rxe_net_del() must drop the pernet socket refs exactly once */
+	RXE_NET_SK_PUT,
+};
+
 struct rxe_dev {
 	struct ib_device	ib_dev;
 	struct ib_device_attr	attr;
 	int			max_ucontext;
 	int			max_inline_data;
 	struct mutex		usdev_lock;
+	unsigned long		net_flags;
+	/* netns whose pernet socket references this device holds */
+	struct net		*net;
 
 	char			raw_gid[ETH_ALEN];
 
-- 
2.54.0


