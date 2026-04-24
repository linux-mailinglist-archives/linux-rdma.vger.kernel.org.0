Return-Path: <linux-rdma+bounces-19531-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JebHGSx62mRQQAAu9opvQ
	(envelope-from <linux-rdma+bounces-19531-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Apr 2026 20:07:32 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 116EE462457
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Apr 2026 20:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C48530137B7
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Apr 2026 18:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81A93EDAA2;
	Fri, 24 Apr 2026 18:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sa+iDPnT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560FF3ED128;
	Fri, 24 Apr 2026 18:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777054041; cv=none; b=rU4tryWPP3lYWhNLf6VeOyOovtK6vOZ5onmmrOaiVrD1BZVwEqeJBrXYS8bqSbzd4cy+xRptu54elWG8qpUtcUoSUz9BiQvvzyJeC5ou1swtC96Dz3CDMsZe14NWAknNQovIH6OCxUhOFaozC3NNgn0ZJOyNVo25PJRV1tWeYu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777054041; c=relaxed/simple;
	bh=Uwb+zIgMoJhu4VicNyQxcRWEEOfzcAwZNp6AJGN+IwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ALW1MWMKxI+9MDE9UAJ49Z4RS/wo5axh8MTPkqaxwvFZh8N6roIBDFxYdcjustCPKJHiYLHWifE8owIhMBfTmKv+e5SylUCMoR3hDc1+/iqBYJgosJiCDTKjjshcp9OJRXz/luxluEQohHz84lDzIp8IQFcKbBYGEecsZZRjHTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sa+iDPnT; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777054040; x=1808590040;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Uwb+zIgMoJhu4VicNyQxcRWEEOfzcAwZNp6AJGN+IwE=;
  b=Sa+iDPnTu49BaKlgbkj9eJ+dInzI8CaPbgMsVyvy0oBs4JO3X12rl6B0
   +FNHd/YCrbCVpAV9UyXeefEwp0sVoj08D9SwVLHHkjc/OStVXawud2Sjq
   VxxyueWmXW7156EEjIOMQJ5AlvvNuYdXGwxHHlmARULI+ysc7G+3aIyZH
   YqHJSzqU31eUWYAU765IKagLlSgAkXleleZlvWi16KXjf3dCT9yt/VSZc
   GMdInup8tNWtP2E9h/h+yg7Oao23Hoyieg8b5G1836TnZAUpfBd2w/4N1
   mFYVO4POv4wLco6UyN/zBEJnAOfB0ruXiGqQojV7wkzXDRbtjTzsYG1GE
   A==;
X-CSE-ConnectionGUID: 5LQO5MpoRliMbWjb8T/GWA==
X-CSE-MsgGUID: 4BCGh9+yRhO1e+0lcCV3rQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11766"; a="100693265"
X-IronPort-AV: E=Sophos;i="6.23,197,1770624000"; 
   d="scan'208";a="100693265"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 11:07:19 -0700
X-CSE-ConnectionGUID: MXBCtw1pT9S+dRCNA+vhiA==
X-CSE-MsgGUID: /bxsZXZIRK6ESMr9tTn3jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,197,1770624000"; 
   d="scan'208";a="256524742"
Received: from arjan-box.jf.intel.com ([10.88.27.153])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 11:07:18 -0700
From: Arjan van de Ven <arjan@linux.intel.com>
To: netdev@vger.kernel.org
Cc: syzbot+d8f76778263ab65c2b21@syzkaller.appspotmail.com,
	dsahern@kernel.org,
	edumazet@google.com,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	Arjan van de Ven <arjan@linux.intel.com>,
	linux-rdma@vger.kernel.org,
	Zhu Yanjun <zyjzyj2000@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Subject: Re: [syzbot] [net?] general protection fault in kernel_sock_shutdown (4)
Date: Fri, 24 Apr 2026 11:08:21 -0700
Message-ID: <20260424180835.357916-1-arjan@linux.intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <69ea344f.a00a0220.17a17.0040.GAE@google.com>
References: <69ea344f.a00a0220.17a17.0040.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 116EE462457
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[syzkaller.appspotmail.com,kernel.org,google.com,linux-foundation.org,vger.kernel.org,googlegroups.com,linux.intel.com,gmail.com,ziepe.ca];
	TAGGED_FROM(0.00)[bounces-19531-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	URIBL_MULTI_FAIL(0.00)[linux.intel.com:server fail,fenrus.org:server fail,intel.com:server fail,ziepe.ca:server fail,sea.lore.kernel.org:server fail];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arjan@linux.intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma,d8f76778263ab65c2b21];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[]


Unfortunately the AI had a burp and did not write out the proper URL
for analysis data; it should have been

http://oops.fenrus.org/reports/lkml/69ea344f.a00a0220.17a17.0040.GAE_google.com/report.html

and in addition, it made a candidate patch (below)

















From: Arjan van de Ven <arjan@linux.intel.com>
Subject: [PATCH] RDMA/rxe: fix double-release race on UDP tunnel socket teardown

This patch is based on a BUG as reported at
https://lore.kernel.org/r/69ea344f.a00a0220.17a17.0040.GAE@google.com.

The Soft RoCE (RXE) driver stores per-network-namespace UDP tunnel
sockets for IPv4 and IPv6 encapsulation. Two independent code paths
tear these sockets down: rxe_ns_exit(), called when a network
namespace is destroyed, and rxe_net_del(), called when an RDMA link
is deleted via netlink. Both paths read the per-namespace socket
pointer and call udp_tunnel_sock_release() on it.

A time-of-check/time-of-use (TOCTOU) race exists in rxe_net_del().
It reads the socket pointer via rxe_ns_pernet_sk4(), then passes it
to rxe_sock_put() for release. If rxe_ns_exit() runs concurrently
between the read and the release, it clears the pointer and calls
udp_tunnel_sock_release() first, causing sock_release() to set
sock->ops = NULL. When rxe_net_del() then calls
udp_tunnel_sock_release() on the same socket, kernel_sock_shutdown()
dereferences the now-NULL sock->ops, triggering a KASAN null-ptr-deref
at offset 0x68 (the shutdown function pointer in struct proto_ops).

A minimal alternative would guard against NULL sock->ops inside
udp_tunnel_sock_release() before calling kernel_sock_shutdown(). That
treats the symptom rather than the root cause and leaves the
double-release of socket state intact.

Add rxe_ns_pernet_take_sk4() and rxe_ns_pernet_take_sk6() which use
xchg() to atomically swap the per-namespace socket pointer to NULL
and return the old value. Replace the non-atomic reads in
rxe_net_del() with these take variants, and release the socket
directly via udp_tunnel_sock_release() without going through
rxe_sock_put().

Whichever teardown path executes take first claims ownership of the
socket; the second caller gets NULL and skips the release, closing
the double-release window.

Link: https://lore.kernel.org/r/69ea344f.a00a0220.17a17.0040.GAE@google.com
Oops-Analysis: http://oops.fenrus.org/reports/lkml/69ea344f.a00a0220.17a17.0040.GAE_google.com/report.html
Fixes: 13f2a53c2a71 ("RDMA/rxe: Add net namespace support for IPv4/IPv6 sockets")
Fixes: f1327abd6abe ("RDMA/rxe: Support RDMA link creation and destruction per net namespace")
Assisted-by: GitHub Copilot patcher:claude linux-kernel-oops-x86.
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
Cc: linux-rdma@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Zhu Yanjun <zyjzyj2000@gmail.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>

---
 drivers/infiniband/sw/rxe/rxe_net.c |    8 ++++----
 drivers/infiniband/sw/rxe/rxe_ns.c  |   14 ++++++++++++++
 drivers/infiniband/sw/rxe/rxe_ns.h  |    7 +++++++
 3 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index 50a2cb5405e22..4f604636cb7b4 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -655,13 +655,13 @@ void rxe_net_del(struct ib_device *dev)
 
 	net = dev_net(ndev);
 
-	sk = rxe_ns_pernet_sk4(net);
+	sk = rxe_ns_pernet_take_sk4(net);
 	if (sk)
-		rxe_sock_put(sk, rxe_ns_pernet_set_sk4, net);
+		udp_tunnel_sock_release(sk->sk_socket);
 
-	sk = rxe_ns_pernet_sk6(net);
+	sk = rxe_ns_pernet_take_sk6(net);
 	if (sk)
-		rxe_sock_put(sk, rxe_ns_pernet_set_sk6, net);
+		udp_tunnel_sock_release(sk->sk_socket);
 
 	dev_put(ndev);
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_ns.c b/drivers/infiniband/sw/rxe/rxe_ns.c
index 8b9d734229b24..d9d376e3c670f 100644
--- a/drivers/infiniband/sw/rxe/rxe_ns.c
+++ b/drivers/infiniband/sw/rxe/rxe_ns.c
@@ -91,6 +91,13 @@ void rxe_ns_pernet_set_sk4(struct net *net, struct sock *sk)
 	synchronize_rcu();
 }
 
+struct sock *rxe_ns_pernet_take_sk4(struct net *net)
+{
+	struct rxe_ns_sock *ns_sk = net_generic(net, rxe_pernet_id);
+
+	return xchg((__force struct sock **)&ns_sk->rxe_sk4, NULL);
+}
+
 #if IS_ENABLED(CONFIG_IPV6)
 struct sock *rxe_ns_pernet_sk6(struct net *net)
 {
@@ -111,6 +118,13 @@ void rxe_ns_pernet_set_sk6(struct net *net, struct sock *sk)
 	rcu_assign_pointer(ns_sk->rxe_sk6, sk);
 	synchronize_rcu();
 }
+
+struct sock *rxe_ns_pernet_take_sk6(struct net *net)
+{
+	struct rxe_ns_sock *ns_sk = net_generic(net, rxe_pernet_id);
+
+	return xchg((__force struct sock **)&ns_sk->rxe_sk6, NULL);
+}
 #endif /* IPV6 */
 
 int rxe_namespace_init(void)
diff --git a/drivers/infiniband/sw/rxe/rxe_ns.h b/drivers/infiniband/sw/rxe/rxe_ns.h
index 4da2709e6b714..9d9a5106b77c8 100644
--- a/drivers/infiniband/sw/rxe/rxe_ns.h
+++ b/drivers/infiniband/sw/rxe/rxe_ns.h
@@ -5,10 +5,17 @@
 
 struct sock *rxe_ns_pernet_sk4(struct net *net);
 void rxe_ns_pernet_set_sk4(struct net *net, struct sock *sk);
+struct sock *rxe_ns_pernet_take_sk4(struct net *net);
 
 #if IS_ENABLED(CONFIG_IPV6)
 void rxe_ns_pernet_set_sk6(struct net *net, struct sock *sk);
 struct sock *rxe_ns_pernet_sk6(struct net *net);
+struct sock *rxe_ns_pernet_take_sk6(struct net *net);
 #else /* IPv6 */
 static inline struct sock *rxe_ns_pernet_sk6(struct net *net)
 {
@@ -18,6 +25,10 @@ static inline void rxe_ns_pernet_set_sk6(struct net *net, struct sock *sk)
 {
 }
 
+static inline struct sock *rxe_ns_pernet_take_sk6(struct net *net)
+{
+	return NULL;
+}
 #endif /* IPv6 */
 
 int rxe_namespace_init(void);

