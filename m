Return-Path: <linux-rdma+bounces-20357-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJspKxN/AWqkbQEAu9opvQ
	(envelope-from <linux-rdma+bounces-20357-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 09:02:43 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A1D508CB9
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 09:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 684E9301F5F7
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 07:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F003126CA;
	Mon, 11 May 2026 07:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nscXj4DY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD6F3112BD
	for <linux-rdma@vger.kernel.org>; Mon, 11 May 2026 07:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778482942; cv=none; b=oF2xg43Rx6Jst1jKlBHvgB5xNCNyJfpCN6+DHfIH1ZYMfuyifGajKnyjS4u2to8Sl6gqPG4puVswP7R/HuXM3clLfO9Yd0wtl43As2HAbvJP/YfL+slfb7OMZRj1EVe3SRPjzqi6toa3qRLsWwBDBC7Rtn02u2cmJsgzRvOsHho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778482942; c=relaxed/simple;
	bh=QFy4gBqDtUEsal4sJ+4y4+2D6x4MfUMpx6PYX9HGBtk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IZn8qm8sQLBhFtgFvxfQXVzuwwyJZ+r0GB3VOLAKbENRWF1P9Sj4Wsn8os9UTFEBlRxQMUin8A/2CSL8JPKLOCJFcKpmPYai3Kqg89ih6lze7ZmXam0gHepuTl/4rJjRv8Er407G9aWTWv/y3vK4tVQ6Wm8N+qY+SKKwHHVqxQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nscXj4DY; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-367c26471f5so1258286a91.1
        for <linux-rdma@vger.kernel.org>; Mon, 11 May 2026 00:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778482938; x=1779087738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gLQqNeBBoJ1TovFHZ6Y5VIkiSO2gp7MmGpfE8S7ANoU=;
        b=nscXj4DY4BJcLy1FgjrC0fAKr6tyYm+6ruQSj4zT86zlU9l0NymQGyEPv4Mng1f+1z
         06gAY+7Yb8bDDKhSeIFe/7Q/pTmOV9SBLwppIIz51jB25rVy9jw0ARS84fIhMIu1EeIa
         DT5CKMSfUGn256WtAgybdHjZF7uMxu0ZfOAiM64Kt/97889BbDN2B7moe/srKtDLa0Ie
         vI4/klkgPS2lPNg0x8UVl2Lh7fO198GLNmPM11tLMpKtQg/w7YRaP2ao6fn2jBSQFJhN
         DC6PVJH4JKMIFCQdVkL+68tG1yWTfl/sVOHfRHIF/zMog3infJc+KrlGvpsX2XalX4XJ
         ACUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778482938; x=1779087738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gLQqNeBBoJ1TovFHZ6Y5VIkiSO2gp7MmGpfE8S7ANoU=;
        b=qPsA7RAMCmLs4aVHeksc2BY36Kj+HFSAfYozMP4ueCziD875xfX4deOdyH0DZ9/3rn
         kLMZIe9x7TIOB1gGqxA+3dhZTrZnz4A8K/BQoT9tCD8DpN6OxD59GH7h0MSGHOHkjbEZ
         eUdy8JXmd/3rf9YXTUkgHMqkbOSEoiPnKGgO2WZKPq6PJPoKh4EaDUKBx49IXTDvucEQ
         nKhk4jMkWSPcomFZuWxfdOaC1SMecMMbBJJCQaSm8eQZr6I1/NN5MZpBxlQihyhA0l7Y
         FGLJtvg1dGmHK+XWqkA3Hreqju+wP3NHDdVXwnyP5SyBEvwEtLKbANazs0f66SfbcLDW
         b+eQ==
X-Forwarded-Encrypted: i=1; AFNElJ8hbDgW2I8S9fk9+dLu8gAKKgEFXft30WE+ZDh6eG7vseRHaQnuE6UTPVPsYao0QKWRQ7C2JSPDFPcf@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4RkB68GIR2ISg1IYqdvAvfpHpTeyxBn5arlR5Bbfycnb6eAU5
	lPDaiJqw4BaOaRMdawi7NM07X91zLGs+KRolqny4vVjTKWS8FMO5TLL/xwm4Eg==
X-Gm-Gg: Acq92OGEITODiuTJOnXlXNo5rBBRUZYMPwN607y9nOV/ZDXwOaqfvf49oTkflUIcq2O
	t12zm9s3CzTn3wbOtUF06PQwoV5tzY6eJSwxqr/JcYeuH0BghFX+wNXFs8s2x7jr5+2MRnchrDA
	Woa/1aOj/SDWd2OTuJOZcSeJx1QR/zPuBLXRf+1m7aQ5W5kOra6jEfL62+l4wm8INFhL3slpMgx
	YojRcjUgrGUufVnMwZXMzOdwRCPz5/kkxUs01FqcSM65DgLnw6hriTePZRT3OO3gBOdKvWcAqti
	pPM7dr0YuYtMMSGs1OeSAKt1aL+18EGe1TmII7AcYhVj2ntC3q2LN/ihedPdlGs5oXqV0GO6G/U
	ved07pj2PqqPA625KnInxI7bpozijfH8quGJZ//ZSiArIpo7PhwX2CH9a7j733UpIjWgZXchySP
	im0pbXnQh6tvRXKRKXMDkcyv4e8h40EKbskviCMa58Iw1JgJX1erO04z42
X-Received: by 2002:a17:90b:1c8b:b0:362:f860:f9ba with SMTP id 98e67ed59e1d1-365ab9b8e33mr23465932a91.1.1778482937476;
        Mon, 11 May 2026 00:02:17 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367beac2c7dsm3274292a91.5.2026.05.11.00.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 00:02:16 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
X-Google-Original-From: Maoyi Xie <maoyi.xie@ntu.edu.sg>
To: Simon Horman <horms@kernel.org>,
	Allison Henderson <achender@kernel.org>,
	netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com,
	linux-kernel@vger.kernel.org,
	Praveen Kakkolangara <praveen.kakkolangara@aumovio.com>,
	Maoyi Xie <maoyi.xie@ntu.edu.sg>
Subject: [PATCH net v3] rds: filter RDS_INFO_* getsockopt by caller's netns
Date: Mon, 11 May 2026 15:02:11 +0800
Message-Id: <20260511070211.1033178-1-maoyi.xie@ntu.edu.sg>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 01A1D508CB9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-20357-lists,linux-rdma=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,linux-rdma@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ntu.edu.sg:email,ntu.edu.sg:mid]
X-Rspamd-Action: no action

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
Suggested-by: Simon Horman <horms@kernel.org>
Reviewed-by: Allison Henderson <achender@kernel.org>
Co-developed-by: Praveen Kakkolangara <praveen.kakkolangara@aumovio.com>
Signed-off-by: Praveen Kakkolangara <praveen.kakkolangara@aumovio.com>
Signed-off-by: Maoyi Xie <maoyi.xie@ntu.edu.sg>
---
v3: Address Simon Horman's review of v2. The size precheck and the
    lens count are now both restricted to the caller's netns in
    rds_sock_info, rds6_sock_info, rds_tcp_tc_info and
    rds6_tcp_tc_info. Each handler now does a first pass under the
    list lock to count entries visible in the caller's netns, then
    short-circuits with that count if the user buffer is too small,
    then a second pass to fill data. This closes both issues Simon
    flagged: a zero-length probe no longer returns the global count,
    and a caller that sizes its buffer to the value returned by lens
    no longer hits ENOSPC on the second call.
    Re-verified on KASAN VM with the v1 PoC: attacker in fresh
    user_ns + netns sees zero RDS_INFO_SOCKETS entries; init_net
    access sees its own entries; lens returns the ns-scoped count
    on both probe and full reads.
v2: rebased onto net/main tip (b266bacba) so patchwork can apply.
    No code changes. Carries forward Reviewed-by from v1 review.
v1: https://lore.kernel.org/r/20260506075031.2238596-1-maoyixie.tju@gmail.com

 net/rds/af_rds.c     | 42 ++++++++++++++++++++++++++++++++++++------
 net/rds/connection.c | 13 +++++++++++++
 net/rds/tcp.c        | 35 +++++++++++++++++++++++++++++++----
 3 files changed, 80 insertions(+), 10 deletions(-)

diff --git a/net/rds/af_rds.c b/net/rds/af_rds.c
index 76f625986..6e22b516b 100644
--- a/net/rds/af_rds.c
+++ b/net/rds/af_rds.c
@@ -735,6 +735,7 @@ static void rds_sock_inc_info(struct socket *sock, unsigned int len,
 			      struct rds_info_iterator *iter,
 			      struct rds_info_lengths *lens)
 {
+	struct net *net = sock_net(sock->sk);
 	struct rds_sock *rs;
 	struct rds_incoming *inc;
 	unsigned int total = 0;
@@ -744,6 +745,9 @@ static void rds_sock_inc_info(struct socket *sock, unsigned int len,
 	spin_lock_bh(&rds_sock_lock);
 
 	list_for_each_entry(rs, &rds_sock_list, rs_item) {
+		/* Only show sockets in the caller's netns. */
+		if (!net_eq(sock_net(rds_rs_to_sk(rs)), net))
+			continue;
 		/* This option only supports IPv4 sockets. */
 		if (!ipv6_addr_v4mapped(&rs->rs_bound_addr))
 			continue;
@@ -774,6 +778,7 @@ static void rds6_sock_inc_info(struct socket *sock, unsigned int len,
 			       struct rds_info_iterator *iter,
 			       struct rds_info_lengths *lens)
 {
+	struct net *net = sock_net(sock->sk);
 	struct rds_incoming *inc;
 	unsigned int total = 0;
 	struct rds_sock *rs;
@@ -783,6 +788,9 @@ static void rds6_sock_inc_info(struct socket *sock, unsigned int len,
 	spin_lock_bh(&rds_sock_lock);
 
 	list_for_each_entry(rs, &rds_sock_list, rs_item) {
+		/* Only show sockets in the caller's netns. */
+		if (!net_eq(sock_net(rds_rs_to_sk(rs)), net))
+			continue;
 		read_lock(&rs->rs_recv_lock);
 
 		list_for_each_entry(inc, &rs->rs_recv_queue, i_item) {
@@ -806,6 +814,7 @@ static void rds_sock_info(struct socket *sock, unsigned int len,
 			  struct rds_info_iterator *iter,
 			  struct rds_info_lengths *lens)
 {
+	struct net *net = sock_net(sock->sk);
 	struct rds_info_socket sinfo;
 	unsigned int cnt = 0;
 	struct rds_sock *rs;
@@ -814,12 +823,22 @@ static void rds_sock_info(struct socket *sock, unsigned int len,
 
 	spin_lock_bh(&rds_sock_lock);
 
-	if (len < rds_sock_count) {
-		cnt = rds_sock_count;
-		goto out;
+	/* First pass: count entries visible in the caller's netns. */
+	list_for_each_entry(rs, &rds_sock_list, rs_item) {
+		if (!net_eq(sock_net(rds_rs_to_sk(rs)), net))
+			continue;
+		if (!ipv6_addr_v4mapped(&rs->rs_bound_addr))
+			continue;
+		cnt++;
 	}
 
+	if (len < cnt)
+		goto out;
+
 	list_for_each_entry(rs, &rds_sock_list, rs_item) {
+		/* Only show sockets in the caller's netns. */
+		if (!net_eq(sock_net(rds_rs_to_sk(rs)), net))
+			continue;
 		/* This option only supports IPv4 sockets. */
 		if (!ipv6_addr_v4mapped(&rs->rs_bound_addr))
 			continue;
@@ -832,7 +851,6 @@ static void rds_sock_info(struct socket *sock, unsigned int len,
 		sinfo.inum = sock_i_ino(rds_rs_to_sk(rs));
 
 		rds_info_copy(iter, &sinfo, sizeof(sinfo));
-		cnt++;
 	}
 
 out:
@@ -847,17 +865,29 @@ static void rds6_sock_info(struct socket *sock, unsigned int len,
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
+	/* First pass: count entries visible in the caller's netns. */
+	list_for_each_entry(rs, &rds_sock_list, rs_item) {
+		if (!net_eq(sock_net(rds_rs_to_sk(rs)), net))
+			continue;
+		cnt++;
+	}
+
+	if (len < cnt)
 		goto out;
 
 	list_for_each_entry(rs, &rds_sock_list, rs_item) {
+		/* Only show sockets in the caller's netns. */
+		if (!net_eq(sock_net(rds_rs_to_sk(rs)), net))
+			continue;
 		sinfo6.sndbuf = rds_sk_sndbuf(rs);
 		sinfo6.rcvbuf = rds_sk_rcvbuf(rs);
 		sinfo6.bound_addr = rs->rs_bound_addr;
@@ -870,7 +900,7 @@ static void rds6_sock_info(struct socket *sock, unsigned int len,
 	}
 
  out:
-	lens->nr = rds_sock_count;
+	lens->nr = cnt;
 	lens->each = sizeof(struct rds6_info_socket);
 
 	spin_unlock_bh(&rds_sock_lock);
diff --git a/net/rds/connection.c b/net/rds/connection.c
index c10b7ed06..7c8ab8e97 100644
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
 
 			/* Zero the per-item buffer before handing it to the
 			 * visitor so any field the visitor does not write -
@@ -733,6 +741,7 @@ static void rds_walk_conn_path_info(struct socket *sock, unsigned int len,
 				    u64 *buffer,
 				    size_t item_len)
 {
+	struct net *net = sock_net(sock->sk);
 	struct hlist_head *head;
 	struct rds_connection *conn;
 	size_t i;
@@ -747,6 +756,10 @@ static void rds_walk_conn_path_info(struct socket *sock, unsigned int len,
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
index 654e23d13..105e83507 100644
--- a/net/rds/tcp.c
+++ b/net/rds/tcp.c
@@ -235,13 +235,24 @@ static void rds_tcp_tc_info(struct socket *rds_sock, unsigned int len,
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
+	/* First pass: count entries visible in the caller's netns. */
+	list_for_each_entry(tc, &rds_tcp_tc_list, t_list_item) {
+		if (tc->t_cpath->cp_conn->c_isv6)
+			continue;
+		if (!net_eq(rds_conn_net(tc->t_cpath->cp_conn), net))
+			continue;
+		cnt++;
+	}
+
+	if (len / sizeof(tsinfo) < cnt)
 		goto out;
 
 	list_for_each_entry(tc, &rds_tcp_tc_list, t_list_item) {
@@ -249,6 +260,9 @@ static void rds_tcp_tc_info(struct socket *rds_sock, unsigned int len,
 
 		if (tc->t_cpath->cp_conn->c_isv6)
 			continue;
+		/* Only show connections in the caller's netns. */
+		if (!net_eq(rds_conn_net(tc->t_cpath->cp_conn), net))
+			continue;
 
 		tsinfo.local_addr = inet->inet_saddr;
 		tsinfo.local_port = inet->inet_sport;
@@ -266,7 +280,7 @@ static void rds_tcp_tc_info(struct socket *rds_sock, unsigned int len,
 	}
 
 out:
-	lens->nr = rds_tcp_tc_count;
+	lens->nr = cnt;
 	lens->each = sizeof(tsinfo);
 
 	spin_unlock_irqrestore(&rds_tcp_tc_list_lock, flags);
@@ -281,19 +295,32 @@ static void rds6_tcp_tc_info(struct socket *sock, unsigned int len,
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
+	/* First pass: count entries visible in the caller's netns. */
+	list_for_each_entry(tc, &rds_tcp_tc_list, t_list_item) {
+		if (!net_eq(rds_conn_net(tc->t_cpath->cp_conn), net))
+			continue;
+		cnt++;
+	}
+
+	if (len / sizeof(tsinfo6) < cnt)
 		goto out;
 
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
@@ -309,7 +336,7 @@ static void rds6_tcp_tc_info(struct socket *sock, unsigned int len,
 	}
 
 out:
-	lens->nr = rds6_tcp_tc_count;
+	lens->nr = cnt;
 	lens->each = sizeof(tsinfo6);
 
 	spin_unlock_irqrestore(&rds_tcp_tc_list_lock, flags);

base-commit: b266bacba796ff5c4dcd2ae2fc08aacf7ab39153
-- 
2.34.1


