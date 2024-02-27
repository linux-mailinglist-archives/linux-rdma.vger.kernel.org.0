Return-Path: <linux-rdma+bounces-1147-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 231F386859C
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Feb 2024 02:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E296B235EF
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Feb 2024 01:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02974A28;
	Tue, 27 Feb 2024 01:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="TgL8J3Wf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D784A24;
	Tue, 27 Feb 2024 01:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708996339; cv=none; b=khsGHNApgKqM4IdA7/3Ak8OiYvbXgJeURkCqkeDJS2kZzs/J+OQdj+ZxiVWK5BsjGqnJIaBh9SlnwvQL+JQbmjODMBIVj+V0wK5u6xMWuBP92pVaGOL0d25W515Oapew9J/DQyyr46Qxar3C8rmHKtYAJAM6V7jF8sbBcgM+gd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708996339; c=relaxed/simple;
	bh=faYedEqqzFxcdz9VkTACgPVlcakLjAUUrrr2nYoBtKE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N30RG/HUAirR08NGuWlvulHTxY+xXoIrcX5lIf0vfY8GdFKn3CWlqX41ncGAznwyVPInzE2re13V4r0nHdLPHfUCpHrY05vTmvgnXo4Xl1QRdjNzx/4MBqKLBJYo8KSvre0IHIXioMp7TF08KsoFZiV7K0DwFQYNc9WZ0BRSkyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=TgL8J3Wf; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1708996338; x=1740532338;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ll8HhLh8iJugOBzG9xD1stZ58xcqI4hDqWg8P+gNWp8=;
  b=TgL8J3Wf7CZd+1lhaii/up4SCe2Qu5mEJI7hJvkH540FeUW505Pr6JCJ
   Ojj0bY4L9JQEBW3kMZfy2q6fl0cF8mjJF0ygFK+OK/v2FsE0+ywqDws2L
   LK6H5llHLbevUMhzGauCGBGkXGVWjhcPGTdaEUKPh8qk6BzTxTR9pj8S8
   w=;
X-IronPort-AV: E=Sophos;i="6.06,187,1705363200"; 
   d="scan'208";a="187574065"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 01:12:15 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:21469]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.60.172:2525] with esmtp (Farcaster)
 id 8c984869-3474-471e-8ea3-57733d147b9c; Tue, 27 Feb 2024 01:12:13 +0000 (UTC)
X-Farcaster-Flow-ID: 8c984869-3474-471e-8ea3-57733d147b9c
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 27 Feb 2024 01:12:13 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.101.48) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 27 Feb 2024 01:12:10 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Allison Henderson <allison.henderson@oracle.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<rds-devel@oss.oracle.com>
Subject: [PATCH v2 net 3/5] net: Convert @kern of __sock_create() to enum.
Date: Mon, 26 Feb 2024 17:10:39 -0800
Message-ID: <20240227011041.97375-4-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240227011041.97375-1-kuniyu@amazon.com>
References: <20240227011041.97375-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWA004.ant.amazon.com (10.13.139.7) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Historically, syzbot has reported many use-after-free of struct
net by kernel sockets.

In most cases, the root cause was a timer kicked by a kernel socket
which does not hold netns refcount nor clean it up during netns
dismantle.

This patch converts the @kern argument of __sock_create() to enum
so that we can pass SOCKET_KERN_NET_REF and later sk_alloc() can
hold refcount of net for kernel sockets.

We pass !!kern to security_socket(_post)?_create() but kern as is
to pf->create() because 3 functions (atalk_create(), inet_create(),
inet6_create()) use it for the following check:

  if (sock->type == SOCK_RAW && !kern && !capable(CAP_NET_RAW))

The conversion for rest of the callers of __sock_create() and
sk_alloc() will be completed in net-next.git as the change is
too large to backport.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/linux/net.h |  6 ++++++
 net/core/sock.c     |  2 +-
 net/socket.c        | 11 ++++++-----
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/include/linux/net.h b/include/linux/net.h
index c9b4a63791a4..62ef0954be75 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -245,6 +245,12 @@ enum {
 	SOCK_WAKE_URG,
 };
 
+enum socket_user {
+	SOCKET_USER,
+	SOCKET_KERN,
+	SOCKET_KERN_NET_REF,
+};
+
 int sock_wake_async(struct socket_wq *sk_wq, int how, int band);
 int sock_register(const struct net_proto_family *fam);
 void sock_unregister(int family);
diff --git a/net/core/sock.c b/net/core/sock.c
index 5e78798456fd..6f417cdbcf50 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2138,7 +2138,7 @@ struct sock *sk_alloc(struct net *net, int family, gfp_t priority,
 		sk->sk_prot = sk->sk_prot_creator = prot;
 		sk->sk_kern_sock = kern;
 		sock_lock_init(sk);
-		sk->sk_net_refcnt = kern ? 0 : 1;
+		sk->sk_net_refcnt = kern != SOCKET_KERN;
 		if (likely(sk->sk_net_refcnt)) {
 			get_net_track(net, &sk->ns_tracker, priority);
 			sock_inuse_add(net, 1);
diff --git a/net/socket.c b/net/socket.c
index ed3df2f749bf..f5ec613d9e3b 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1489,7 +1489,7 @@ EXPORT_SYMBOL(sock_wake_async);
  *	@type: communication type (SOCK_STREAM, ...)
  *	@protocol: protocol (0, ...)
  *	@res: new socket
- *	@kern: boolean for kernel space sockets
+ *	@kern: enum for kernel space sockets
  *
  *	Creates a new socket and assigns it to @res, passing through LSM.
  *	Returns 0 or an error. On failure @res is set to %NULL. @kern must
@@ -1523,7 +1523,7 @@ int __sock_create(struct net *net, int family, int type, int protocol,
 		family = PF_PACKET;
 	}
 
-	err = security_socket_create(family, type, protocol, kern);
+	err = security_socket_create(family, type, protocol, !!kern);
 	if (err)
 		return err;
 
@@ -1584,7 +1584,7 @@ int __sock_create(struct net *net, int family, int type, int protocol,
 	 * module can have its refcnt decremented
 	 */
 	module_put(pf->owner);
-	err = security_socket_post_create(sock, family, type, protocol, kern);
+	err = security_socket_post_create(sock, family, type, protocol, !!kern);
 	if (err)
 		goto out_sock_release;
 	*res = sock;
@@ -1619,7 +1619,8 @@ EXPORT_SYMBOL(__sock_create);
 
 int sock_create(int family, int type, int protocol, struct socket **res)
 {
-	return __sock_create(current->nsproxy->net_ns, family, type, protocol, res, 0);
+	return __sock_create(current->nsproxy->net_ns, family, type, protocol,
+			     res, SOCKET_USER);
 }
 EXPORT_SYMBOL(sock_create);
 
@@ -1637,7 +1638,7 @@ EXPORT_SYMBOL(sock_create);
 
 int sock_create_kern(struct net *net, int family, int type, int protocol, struct socket **res)
 {
-	return __sock_create(net, family, type, protocol, res, 1);
+	return __sock_create(net, family, type, protocol, res, SOCKET_KERN);
 }
 EXPORT_SYMBOL(sock_create_kern);
 
-- 
2.30.2


