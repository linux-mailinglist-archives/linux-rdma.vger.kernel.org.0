Return-Path: <linux-rdma+bounces-20056-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHlWJOHy+mngUgMAu9opvQ
	(envelope-from <linux-rdma+bounces-20056-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 09:50:57 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E34EE4D7748
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 09:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC4573013A96
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2026 07:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624B23DF01C;
	Wed,  6 May 2026 07:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctEdym2u"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BED13DEAC8
	for <linux-rdma@vger.kernel.org>; Wed,  6 May 2026 07:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778053839; cv=none; b=tGZ/JO5ybSMBdUUDqdd7q35h/ZKmTNLfopSKcoe7pmA+fT8kkeZgkN3z9JWDtXhC94TtvtUcQbw3LszpcK5BVe4OxxBK0boCCLM5lWfKuzyFurAt6O2JdvLTKA810fTlRY45t5oSHoMka4vD+STMi1J4c8uk3BKiwECZWuBo7V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778053839; c=relaxed/simple;
	bh=AXfowDW94GQ84w9SD+iMe+SMgDXxvdAMVAXykEpsl40=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Zljc/H7KyIOgIejn5FZWR93vBjI8LTjXiCALux3Smyj/T0jnQr6KJIDAybrTovIhYQO45Pgk8P8v21muTGU4aju7gZnuLvALNwdAoTiYrb6RtBPk//02I+81sJhvQ3R+Iduf1njRpG65LOXvJcTZ4qsuGzzuc5fiMAWG2MY1hEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ctEdym2u; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8353c9f24d2so2305987b3a.3
        for <linux-rdma@vger.kernel.org>; Wed, 06 May 2026 00:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778053837; x=1778658637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WqPluHqTq1AG7q33TUqAmZ7vQqpFPEBS5YBI5kwGkN4=;
        b=ctEdym2uIt85uqCbd1QD27k0RMRVlaxj3PSg1UHVxVSBAD4qZ4jwpOw2Vh+5P9ql6K
         2EX8sSO8FK9mkkDXXSiSFf/4+HdmePWYl/FItbLr35s3plAKKxbZPRPBwcefP6g7eo9r
         O0RFtDDX0BwYPpGc33cUCPr/UGYd4YD93Ibg0umpXHFzdK+yZRV9OBxr/YI3TUR31kkj
         jrz6Xtn5CmU3rhplYoByAdjN3TL1c2hLDfOKdpTON0+sYhTTdTObJc0jzh5kx29I3hB9
         Ws5NQXag//V5d8cXjwrrDOhVwNKM80dxw5vUpidxzfMCzVi49tlHli+wsmI4eRZT59lb
         aQgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778053837; x=1778658637;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WqPluHqTq1AG7q33TUqAmZ7vQqpFPEBS5YBI5kwGkN4=;
        b=d3eri1m5MRCxIecpVZzkdx+VpWOVhOpIXEh2aGu4EjSaGwDPbyqJmt7+cyMTPBeThr
         HSUC2TSCnwTwx5I4bsfKKK6aDQRQP/Hla8r5Q4bRBrTUG8pyaL3ae75w3OypP2ry5J4Q
         pjblZM7gGIZB3GOm5RHKbJd/Ll2OA3qenUKv8fNpAT0KelKQNUjqnldYGPpsi0wTy3D0
         73LUln1E9eS1nReaSwZ5R6xKDPhtKyiFpYGTY9oUNRY8hyNwaMVjwCCkSXV6QFN/RyBo
         fWqxm9VW8JIvh6RF1Keisqv052r3Ue8paDrM4dLgsC2ONHOqvW4/p/GOqIF0d6G9ce/X
         3LJQ==
X-Forwarded-Encrypted: i=1; AFNElJ8uW5hxdjLahQr9SWF/cJXOaxEq6HbZFQ0cjxPyyYqghV7VcN4nOXpnaeEBI/Gra4Yf/Hm3v0OYmjyS@vger.kernel.org
X-Gm-Message-State: AOJu0YwZMAJQNQGGc+DM/V5cIcAlyJMVczJ5fsEUvqOn8c4GQCFG97DG
	pmAYnxNlcyfXwKCuhWNtXF2cmPlsBvHnoOLj+hzVH0F9LqlzRQ2LG0f+h797dw==
X-Gm-Gg: AeBDiesxHfDtJIdckPRmpVhKfLUvdpqnAheKR3h4c63zqcGXz3ZR2Oab8T4RO0D0YVr
	WQRNMy0S/yGFUIjqRfjXTu63kfiMHzgVUXvD3symDKILfXm67eDZlOk0PqWupikrx/ClmEFXqjQ
	FwjO0Q2JtouhwQ9zfakXUtHBOwEY4yvckGfwWdMIWuULskgjtEFTYvxWf1RxkWmK48cVulGydZe
	ML7tghacZ0pVMVuW4OzePbLkt3KUmzNOqJMjTNJNsbnWwXPKJlj7Z19XiTwe+givEcT0D6NXJDn
	p7N31k2BD+6SWmocmWFEdfcGLI+KOhCiA2wmtDvwHCeUDiril8yhUCui9OIK7Y5iy5EwZeVw+PT
	8/wQLiLplkUVQ7LDuuMPRCnsDOTkS5lKJWyZSofjGC2xz+KG4CAudG18eoHkTxBtLg6+4eBL2oF
	6tuwSBTsQacvhRbcSezfCL2ReP+JRoIr48LI3Teb4Cze2sLEmV+xKtg5OkY34=
X-Received: by 2002:a05:6a00:3e14:b0:835:6bdf:c87f with SMTP id d2e1a72fcca58-83a5b6c48e7mr2185626b3a.9.1778053836893;
        Wed, 06 May 2026 00:50:36 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839681a9e33sm5358709b3a.50.2026.05.06.00.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 00:50:36 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Allison Henderson <achender@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com,
	linux-kernel@vger.kernel.org,
	Maoyi Xie <maoyi.xie@ntu.edu.sg>,
	Praveen Kakkolangara <praveen.kakkolangara@aumovio.com>
Subject: [PATCH net] rds: filter RDS_INFO_* getsockopt by caller's netns
Date: Wed,  6 May 2026 15:50:31 +0800
Message-Id: <20260506075031.2238596-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E34EE4D7748
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20056-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,linux-rdma@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ntu.edu.sg:email]

From: Maoyi Xie <maoyi.xie@ntu.edu.sg>

The RDS_INFO_* family of getsockopt(2) options reads several
file-scope global lists that are not per-netns:

  rds_sock_info / rds6_sock_info,
  rds_sock_inc_info / rds6_sock_inc_info        -> rds_sock_list
  rds_tcp_tc_info / rds6_tcp_tc_info            -> rds_tcp_tc_list
  rds_conn_info / rds6_conn_info,
  rds_conn_message_info_cmn (for the *_SEND_MESSAGES and
  *_RETRANS_MESSAGES variants),
  rds_for_each_conn_info (for RDS_INFO_IB_CONNECTIONS)
                                                -> rds_conn_hash[]

The handlers do not filter by the caller's network namespace.
rds_info_getsockopt() has no netns or capable() check, and
rds_create() has no capable() check, so AF_RDS is reachable from
an unprivileged user namespace. As a result, an unprivileged
caller in a fresh user_ns plus netns can read the bound address
and sock inode of every RDS socket on the host, the peer address
of incoming messages on every RDS socket on the host, the peer
address and TCP sequence numbers of every rds-tcp connection on
the host, and the peer address and RDS sequence numbers of every
RDS connection on the host.

The rds-tcp transport is reachable from a non-initial netns (see
rds_set_transport()), so a one-shot init_net gate at
rds_info_getsockopt() would deny legitimate per-netns visibility
to rds-tcp callers. Instead, filter at each handler by comparing
the netns of the caller's socket to the netns of the list entry,
or to rds_conn_net(conn) for connection paths. Only copy entries
whose netns matches the caller. Counters (RDS_INFO_COUNTERS) are
aggregate statistics and remain global.

Reproducer (KASAN VM, rds and rds_tcp loaded): an AF_RDS socket
binds 127.0.0.1:4242 in init_net as root. A child process enters
a fresh user_ns plus netns and opens AF_RDS there, then calls
getsockopt(SOL_RDS, RDS_INFO_SOCKETS). Before this change, the
child sees the init_net socket. After this change, the child
sees zero entries.

Suggested-by: Allison Henderson <achender@kernel.org>
Co-developed-by: Praveen Kakkolangara <praveen.kakkolangara@aumovio.com>
Signed-off-by: Praveen Kakkolangara <praveen.kakkolangara@aumovio.com>
Signed-off-by: Maoyi Xie <maoyi.xie@ntu.edu.sg>
---
 net/rds/af_rds.c     | 24 ++++++++++++++++++++++--
 net/rds/connection.c | 13 +++++++++++++
 net/rds/tcp.c        | 25 +++++++++++++++++++++----
 3 files changed, 56 insertions(+), 6 deletions(-)

diff --git a/net/rds/af_rds.c b/net/rds/af_rds.c
index b396c673d..469891131 100644
--- a/net/rds/af_rds.c
+++ b/net/rds/af_rds.c
@@ -729,6 +729,7 @@ static void rds_sock_inc_info(struct socket *sock, unsigned int len,
 			      struct rds_info_iterator *iter,
 			      struct rds_info_lengths *lens)
 {
+	struct net *net = sock_net(sock->sk);
 	struct rds_sock *rs;
 	struct rds_incoming *inc;
 	unsigned int total = 0;
@@ -738,6 +739,9 @@ static void rds_sock_inc_info(struct socket *sock, unsigned int len,
 	spin_lock_bh(&rds_sock_lock);
 
 	list_for_each_entry(rs, &rds_sock_list, rs_item) {
+		/* Only show sockets in the caller's netns. */
+		if (!net_eq(sock_net(rds_rs_to_sk(rs)), net))
+			continue;
 		/* This option only supports IPv4 sockets. */
 		if (!ipv6_addr_v4mapped(&rs->rs_bound_addr))
 			continue;
@@ -768,6 +772,7 @@ static void rds6_sock_inc_info(struct socket *sock, unsigned int len,
 			       struct rds_info_iterator *iter,
 			       struct rds_info_lengths *lens)
 {
+	struct net *net = sock_net(sock->sk);
 	struct rds_incoming *inc;
 	unsigned int total = 0;
 	struct rds_sock *rs;
@@ -777,6 +782,9 @@ static void rds6_sock_inc_info(struct socket *sock, unsigned int len,
 	spin_lock_bh(&rds_sock_lock);
 
 	list_for_each_entry(rs, &rds_sock_list, rs_item) {
+		/* Only show sockets in the caller's netns. */
+		if (!net_eq(sock_net(rds_rs_to_sk(rs)), net))
+			continue;
 		read_lock(&rs->rs_recv_lock);
 
 		list_for_each_entry(inc, &rs->rs_recv_queue, i_item) {
@@ -800,6 +808,7 @@ static void rds_sock_info(struct socket *sock, unsigned int len,
 			  struct rds_info_iterator *iter,
 			  struct rds_info_lengths *lens)
 {
+	struct net *net = sock_net(sock->sk);
 	struct rds_info_socket sinfo;
 	unsigned int cnt = 0;
 	struct rds_sock *rs;
@@ -814,6 +823,9 @@ static void rds_sock_info(struct socket *sock, unsigned int len,
 	}
 
 	list_for_each_entry(rs, &rds_sock_list, rs_item) {
+		/* Only show sockets in the caller's netns. */
+		if (!net_eq(sock_net(rds_rs_to_sk(rs)), net))
+			continue;
 		/* This option only supports IPv4 sockets. */
 		if (!ipv6_addr_v4mapped(&rs->rs_bound_addr))
 			continue;
@@ -841,17 +853,24 @@ static void rds6_sock_info(struct socket *sock, unsigned int len,
 			   struct rds_info_iterator *iter,
 			   struct rds_info_lengths *lens)
 {
+	struct net *net = sock_net(sock->sk);
 	struct rds6_info_socket sinfo6;
+	unsigned int cnt = 0;
 	struct rds_sock *rs;
 
 	len /= sizeof(struct rds6_info_socket);
 
 	spin_lock_bh(&rds_sock_lock);
 
-	if (len < rds_sock_count)
+	if (len < rds_sock_count) {
+		cnt = rds_sock_count;
 		goto out;
+	}
 
 	list_for_each_entry(rs, &rds_sock_list, rs_item) {
+		/* Only show sockets in the caller's netns. */
+		if (!net_eq(sock_net(rds_rs_to_sk(rs)), net))
+			continue;
 		sinfo6.sndbuf = rds_sk_sndbuf(rs);
 		sinfo6.rcvbuf = rds_sk_rcvbuf(rs);
 		sinfo6.bound_addr = rs->rs_bound_addr;
@@ -861,10 +880,11 @@ static void rds6_sock_info(struct socket *sock, unsigned int len,
 		sinfo6.inum = sock_i_ino(rds_rs_to_sk(rs));
 
 		rds_info_copy(iter, &sinfo6, sizeof(sinfo6));
+		cnt++;
 	}
 
  out:
-	lens->nr = rds_sock_count;
+	lens->nr = cnt;
 	lens->each = sizeof(struct rds6_info_socket);
 
 	spin_unlock_bh(&rds_sock_lock);
diff --git a/net/rds/connection.c b/net/rds/connection.c
index 412441aaa..a73554816 100644
--- a/net/rds/connection.c
+++ b/net/rds/connection.c
@@ -568,6 +568,7 @@ static void rds_conn_message_info_cmn(struct socket *sock, unsigned int len,
 				      struct rds_info_lengths *lens,
 				      int want_send, bool isv6)
 {
+	struct net *net = sock_net(sock->sk);
 	struct hlist_head *head;
 	struct list_head *list;
 	struct rds_connection *conn;
@@ -590,6 +591,9 @@ static void rds_conn_message_info_cmn(struct socket *sock, unsigned int len,
 			struct rds_conn_path *cp;
 			int npaths;
 
+			/* Only show connections in the caller's netns. */
+			if (!net_eq(rds_conn_net(conn), net))
+				continue;
 			if (!isv6 && conn->c_isv6)
 				continue;
 
@@ -688,6 +692,7 @@ void rds_for_each_conn_info(struct socket *sock, unsigned int len,
 			  u64 *buffer,
 			  size_t item_len)
 {
+	struct net *net = sock_net(sock->sk);
 	struct hlist_head *head;
 	struct rds_connection *conn;
 	size_t i;
@@ -700,6 +705,9 @@ void rds_for_each_conn_info(struct socket *sock, unsigned int len,
 	for (i = 0, head = rds_conn_hash; i < ARRAY_SIZE(rds_conn_hash);
 	     i++, head++) {
 		hlist_for_each_entry_rcu(conn, head, c_hash_node) {
+			/* Only show connections in the caller's netns. */
+			if (!net_eq(rds_conn_net(conn), net))
+				continue;
 
 			/* XXX no c_lock usage.. */
 			if (!visitor(conn, buffer))
@@ -726,6 +734,7 @@ static void rds_walk_conn_path_info(struct socket *sock, unsigned int len,
 				    u64 *buffer,
 				    size_t item_len)
 {
+	struct net *net = sock_net(sock->sk);
 	struct hlist_head *head;
 	struct rds_connection *conn;
 	size_t i;
@@ -740,6 +749,10 @@ static void rds_walk_conn_path_info(struct socket *sock, unsigned int len,
 		hlist_for_each_entry_rcu(conn, head, c_hash_node) {
 			struct rds_conn_path *cp;
 
+			/* Only show connections in the caller's netns. */
+			if (!net_eq(rds_conn_net(conn), net))
+				continue;
+
 			/* XXX We only copy the information from the first
 			 * path for now.  The problem is that if there are
 			 * more than one underlying paths, we cannot report
diff --git a/net/rds/tcp.c b/net/rds/tcp.c
index 654e23d13..ef9e958ca 100644
--- a/net/rds/tcp.c
+++ b/net/rds/tcp.c
@@ -235,20 +235,27 @@ static void rds_tcp_tc_info(struct socket *rds_sock, unsigned int len,
 			    struct rds_info_iterator *iter,
 			    struct rds_info_lengths *lens)
 {
+	struct net *net = sock_net(rds_sock->sk);
 	struct rds_info_tcp_socket tsinfo;
 	struct rds_tcp_connection *tc;
+	unsigned int cnt = 0;
 	unsigned long flags;
 
 	spin_lock_irqsave(&rds_tcp_tc_list_lock, flags);
 
-	if (len / sizeof(tsinfo) < rds_tcp_tc_count)
+	if (len / sizeof(tsinfo) < rds_tcp_tc_count) {
+		cnt = rds_tcp_tc_count;
 		goto out;
+	}
 
 	list_for_each_entry(tc, &rds_tcp_tc_list, t_list_item) {
 		struct inet_sock *inet = inet_sk(tc->t_sock->sk);
 
 		if (tc->t_cpath->cp_conn->c_isv6)
 			continue;
+		/* Only show connections in the caller's netns. */
+		if (!net_eq(rds_conn_net(tc->t_cpath->cp_conn), net))
+			continue;
 
 		tsinfo.local_addr = inet->inet_saddr;
 		tsinfo.local_port = inet->inet_sport;
@@ -263,10 +270,11 @@ static void rds_tcp_tc_info(struct socket *rds_sock, unsigned int len,
 		tsinfo.tos = tc->t_cpath->cp_conn->c_tos;
 
 		rds_info_copy(iter, &tsinfo, sizeof(tsinfo));
+		cnt++;
 	}
 
 out:
-	lens->nr = rds_tcp_tc_count;
+	lens->nr = cnt;
 	lens->each = sizeof(tsinfo);
 
 	spin_unlock_irqrestore(&rds_tcp_tc_list_lock, flags);
@@ -281,19 +289,27 @@ static void rds6_tcp_tc_info(struct socket *sock, unsigned int len,
 			     struct rds_info_iterator *iter,
 			     struct rds_info_lengths *lens)
 {
+	struct net *net = sock_net(sock->sk);
 	struct rds6_info_tcp_socket tsinfo6;
 	struct rds_tcp_connection *tc;
+	unsigned int cnt = 0;
 	unsigned long flags;
 
 	spin_lock_irqsave(&rds_tcp_tc_list_lock, flags);
 
-	if (len / sizeof(tsinfo6) < rds6_tcp_tc_count)
+	if (len / sizeof(tsinfo6) < rds6_tcp_tc_count) {
+		cnt = rds6_tcp_tc_count;
 		goto out;
+	}
 
 	list_for_each_entry(tc, &rds_tcp_tc_list, t_list_item) {
 		struct sock *sk = tc->t_sock->sk;
 		struct inet_sock *inet = inet_sk(sk);
 
+		/* Only show connections in the caller's netns. */
+		if (!net_eq(rds_conn_net(tc->t_cpath->cp_conn), net))
+			continue;
+
 		tsinfo6.local_addr = sk->sk_v6_rcv_saddr;
 		tsinfo6.local_port = inet->inet_sport;
 		tsinfo6.peer_addr = sk->sk_v6_daddr;
@@ -306,10 +322,11 @@ static void rds6_tcp_tc_info(struct socket *sock, unsigned int len,
 		tsinfo6.last_seen_una = tc->t_last_seen_una;
 
 		rds_info_copy(iter, &tsinfo6, sizeof(tsinfo6));
+		cnt++;
 	}
 
 out:
-	lens->nr = rds6_tcp_tc_count;
+	lens->nr = cnt;
 	lens->each = sizeof(tsinfo6);
 
 	spin_unlock_irqrestore(&rds_tcp_tc_list_lock, flags);

base-commit: 028ef9c96e96197026887c0f092424679298aae8
-- 
2.34.1


