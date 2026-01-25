Return-Path: <linux-rdma+bounces-15963-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFmRIlnBdWmMIQEAu9opvQ
	(envelope-from <linux-rdma+bounces-15963-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 08:08:09 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A0C7FF34
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 08:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A277E3003832
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 07:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD02270575;
	Sun, 25 Jan 2026 07:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r7PrPJIj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22775267714;
	Sun, 25 Jan 2026 07:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769324819; cv=none; b=sIKjLsVIkkLLpdKem0S+J/0s3EGyTKy6DHvKbQDjf3+3i1wl3e9x7Lnqn4ZHkp9/ypd8qfZExQhe1nk0ArlDw7kE0Q27tCY6vPReWu///lzyIBHelW8YoocsjTLU2xMCTyWKTWRUwjU4mpe6RjuZi609aLlzNxGFVj7Xako6R5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769324819; c=relaxed/simple;
	bh=xbd6U4JHrAFcQHHoCGlz+VS4uQEsds5Zv0ofj3hGToo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zl+05GePhsVDbe/uItJb1EsrcE+S9EImIJiVrM4rqV+prv39Ij+dMzddThWL06HRYuy3E7enUX0xKiP39MXXPQIOF+DOWblvZ/TrjFidRe1mA+dQWUdF/+DIg0CrINFt2+6uVIoJeIxj86Tr89Y27HXOyi+SohRq0RMG9jraKsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r7PrPJIj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F0BDC2BCB0;
	Sun, 25 Jan 2026 07:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769324818;
	bh=xbd6U4JHrAFcQHHoCGlz+VS4uQEsds5Zv0ofj3hGToo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r7PrPJIjLXK2WouKm1OlD4XB+HmK8sM1tvVUvc9rOqD2PxkrpUryaz3gOek55K2Ti
	 zx5mxX7lyiP+/Dy5dkg3EsUcPB8D3TcowFO1Mtzuy/MNvPYIvz2oViadFmsMFvkcl/
	 2IAJ9kI3RRGlPTQacMmsRiDQFXHD8dKwOnE93+sXHG9dW8vipqAb0Uv2MUklPOtI/7
	 e4G0MZysIb8ACOHLyEZD9dBeMtP7xMMJG4JxU8kBa+2o9LJc8RvS7DaE/7gpGOKfDs
	 EwtPNkj/gdgk/j4DrFs/Fyjx4F0SRww7CiRYDq8JPvlPAWAM2+jDs9K6htl4Uj0kmj
	 MP+GtDOKCejxA==
From: Allison Henderson <achender@kernel.org>
To: netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	rds-devel@oss.oracle.com,
	kuba@kernel.org,
	horms@kernel.org,
	linux-rdma@vger.kernel.org,
	allison.henderson@oracle.com
Subject: [PATCH net-next v1 7/7] net/rds: Trigger rds_send_ping() more than once
Date: Sun, 25 Jan 2026 00:06:51 -0700
Message-ID: <20260125070651.207042-8-achender@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260125070651.207042-1-achender@kernel.org>
References: <20260125070651.207042-1-achender@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-15963-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C6A0C7FF34
X-Rspamd-Action: no action

From: Gerd Rausch <gerd.rausch@oracle.com>

Even though a peer may have already received a
non-zero value for "RDS_EXTHDR_NPATHS" from a node in the past,
the current peer may not.

Therefore it is important to initiate another rds_send_ping()
after a re-connect to any peer:
It is unknown at that time if we're still talking to the same
instance of RDS kernel modules on the other side.

Otherwise, the peer may just operate on a single lane
("c_npaths == 0"), not knowing that more lanes are available.

However, if "c_with_sport_idx" is supported,
we also need to check that the connection we accepted on lane#0
meets the proper source port modulo requirement, as we fan out:

Since the exchange of "RDS_EXTHDR_NPATHS" and "RDS_EXTHDR_SPORT_IDX"
is asynchronous, initially we have no choice but to accept an incoming
connection (via "accept") in the first slot ("cp_index == 0")
for backwards compatibility.

But that very connection may have come from a different lane
with "cp_index != 0", since the peer thought that we already understood
and handled "c_with_sport_idx" properly, as indicated by a previous
exchange before a module was reloaded.

In short:
If a module gets reloaded, we recover from that, but do *not*
allow a downgrade to support fewer lanes.

Downgrades would require us to merge messages from separate lanes,
which is rather tricky with the current RDS design.
Each lane has its own sequence number space and all messages
would need to be re-sequenced as we merge, all while
handling "RDS_FLAG_RETRANSMITTED" and "cp_retrans" properly.

Signed-off-by: Gerd Rausch <gerd.rausch@oracle.com>
Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
---
 net/rds/connection.c |  5 +++-
 net/rds/rds.h        |  2 +-
 net/rds/recv.c       |  7 +++++-
 net/rds/send.c       | 17 ++++++++++++++
 net/rds/tcp.h        |  2 +-
 net/rds/tcp_listen.c | 55 +++++++++++++++++++++++++++++++++-----------
 6 files changed, 71 insertions(+), 17 deletions(-)

diff --git a/net/rds/connection.c b/net/rds/connection.c
index 4b7715eb2111c..185f73b016941 100644
--- a/net/rds/connection.c
+++ b/net/rds/connection.c
@@ -447,13 +447,16 @@ void rds_conn_shutdown(struct rds_conn_path *cp)
 	rcu_read_lock();
 	if (!hlist_unhashed(&conn->c_hash_node)) {
 		rcu_read_unlock();
+		if (conn->c_trans->t_mp_capable &&
+		    cp->cp_index == 0)
+			rds_send_ping(conn, 0);
 		rds_queue_reconnect(cp);
 	} else {
 		rcu_read_unlock();
 	}
 
 	if (conn->c_trans->conn_slots_available)
-		conn->c_trans->conn_slots_available(conn);
+		conn->c_trans->conn_slots_available(conn, false);
 }
 
 /* destroy a single rds_conn_path. rds_conn_destroy() iterates over
diff --git a/net/rds/rds.h b/net/rds/rds.h
index f78477912e7c1..eab396ef2c2d0 100644
--- a/net/rds/rds.h
+++ b/net/rds/rds.h
@@ -548,7 +548,7 @@ struct rds_transport {
 	 * messages received on the new socket are not discarded when no
 	 * connection path was available at the time.
 	 */
-	void (*conn_slots_available)(struct rds_connection *conn);
+	void (*conn_slots_available)(struct rds_connection *conn, bool fan_out);
 	int (*conn_path_connect)(struct rds_conn_path *cp);
 
 	/*
diff --git a/net/rds/recv.c b/net/rds/recv.c
index 889a5b7935e5c..4b3f9e4a8bfda 100644
--- a/net/rds/recv.c
+++ b/net/rds/recv.c
@@ -209,6 +209,7 @@ static void rds_recv_hs_exthdrs(struct rds_header *hdr,
 	bool new_with_sport_idx = false;
 	u32 new_peer_gen_num = 0;
 	int new_npaths;
+	bool fan_out;
 
 	new_npaths = conn->c_npaths;
 
@@ -248,7 +249,11 @@ static void rds_recv_hs_exthdrs(struct rds_header *hdr,
 		spin_lock_irqsave(&cp0->cp_lock, flags);
 		conn->c_cp0_mprds_catchup_tx_seq = cp0->cp_next_tx_seq;
 		spin_unlock_irqrestore(&cp0->cp_lock, flags);
+		fan_out = true;
+	} else {
+		fan_out = false;
 	}
+
 	/* if RDS_EXTHDR_NPATHS was not found, default to a single-path */
 	conn->c_npaths = max_t(int, new_npaths, 1);
 
@@ -257,7 +262,7 @@ static void rds_recv_hs_exthdrs(struct rds_header *hdr,
 
 	if (conn->c_npaths > 1 &&
 	    conn->c_trans->conn_slots_available)
-		conn->c_trans->conn_slots_available(conn);
+		conn->c_trans->conn_slots_available(conn, fan_out);
 }
 
 /* rds_start_mprds() will synchronously start multiple paths when appropriate.
diff --git a/net/rds/send.c b/net/rds/send.c
index ea3b57e9191b1..8e7ece085ff1c 100644
--- a/net/rds/send.c
+++ b/net/rds/send.c
@@ -1328,6 +1328,23 @@ int rds_sendmsg(struct socket *sock, struct msghdr *msg, size_t payload_len)
 		cpath = &conn->c_path[0];
 	}
 
+	/* c_npaths == 0 if we have not talked to this peer
+	 * before.  Initiate a connection request to the
+	 * peer right away.
+	 */
+	if (conn->c_trans->t_mp_capable &&
+	    !rds_conn_path_up(&conn->c_path[0])) {
+		/* Ensures that only one request is queued.  And
+		 * rds_send_ping() ensures that only one ping is
+		 * outstanding.
+		 */
+		if (!test_and_set_bit(RDS_RECONNECT_PENDING,
+				      &conn->c_path[0].cp_flags))
+			queue_delayed_work(conn->c_path[0].cp_wq,
+					   &conn->c_path[0].cp_conn_w, 0);
+		rds_send_ping(conn, 0);
+	}
+
 	rm->m_conn_path = cpath;
 
 	/* Parse any control messages the user may have included. */
diff --git a/net/rds/tcp.h b/net/rds/tcp.h
index b36af0865a078..39c86347188c1 100644
--- a/net/rds/tcp.h
+++ b/net/rds/tcp.h
@@ -90,7 +90,7 @@ void rds_tcp_state_change(struct sock *sk);
 struct socket *rds_tcp_listen_init(struct net *net, bool isv6);
 void rds_tcp_listen_stop(struct socket *sock, struct work_struct *acceptor);
 void rds_tcp_listen_data_ready(struct sock *sk);
-void rds_tcp_conn_slots_available(struct rds_connection *conn);
+void rds_tcp_conn_slots_available(struct rds_connection *conn, bool fan_out);
 int rds_tcp_accept_one(struct rds_tcp_net *rtn);
 void rds_tcp_keepalive(struct socket *sock);
 void *rds_tcp_listen_sock_def_readable(struct net *net);
diff --git a/net/rds/tcp_listen.c b/net/rds/tcp_listen.c
index c628f62421d4e..04fafdf59d722 100644
--- a/net/rds/tcp_listen.c
+++ b/net/rds/tcp_listen.c
@@ -56,14 +56,8 @@ void rds_tcp_keepalive(struct socket *sock)
 	tcp_sock_set_keepintvl(sock->sk, keepidle);
 }
 
-/* rds_tcp_accept_one_path(): if accepting on cp_index > 0, make sure the
- * client's ipaddr < server's ipaddr. Otherwise, close the accepted
- * socket and force a reconneect from smaller -> larger ip addr. The reason
- * we special case cp_index 0 is to allow the rds probe ping itself to itself
- * get through efficiently.
- */
-static struct rds_tcp_connection *
-rds_tcp_accept_one_path(struct rds_connection *conn, struct socket *sock)
+static int
+rds_tcp_get_peer_sport(struct socket *sock)
 {
 	union {
 		struct sockaddr_storage storage;
@@ -71,11 +65,9 @@ rds_tcp_accept_one_path(struct rds_connection *conn, struct socket *sock)
 		struct sockaddr_in sin;
 		struct sockaddr_in6 sin6;
 	} saddr;
-	int sport, npaths, i_min, i_max, i;
+	int sport;
 
-	if (conn->c_with_sport_idx &&
-	    kernel_getpeername(sock, &saddr.addr) == 0) {
-		/* cp->cp_index is encoded in lowest bits of source-port */
+	if (kernel_getpeername(sock, &saddr.addr) == 0) {
 		switch (saddr.addr.sa_family) {
 		case AF_INET:
 			sport = ntohs(saddr.sin.sin_port);
@@ -90,6 +82,26 @@ rds_tcp_accept_one_path(struct rds_connection *conn, struct socket *sock)
 		sport = -1;
 	}
 
+	return sport;
+}
+
+/* rds_tcp_accept_one_path(): if accepting on cp_index > 0, make sure the
+ * client's ipaddr < server's ipaddr. Otherwise, close the accepted
+ * socket and force a reconneect from smaller -> larger ip addr. The reason
+ * we special case cp_index 0 is to allow the rds probe ping itself to itself
+ * get through efficiently.
+ */
+static struct rds_tcp_connection *
+rds_tcp_accept_one_path(struct rds_connection *conn, struct socket *sock)
+{
+	int sport, npaths, i_min, i_max, i;
+
+	if (conn->c_with_sport_idx)
+		/* cp->cp_index is encoded in lowest bits of source-port */
+		sport = rds_tcp_get_peer_sport(sock);
+	else
+		sport = -1;
+
 	npaths = max_t(int, 1, conn->c_npaths);
 
 	if (sport >= 0) {
@@ -111,10 +123,12 @@ rds_tcp_accept_one_path(struct rds_connection *conn, struct socket *sock)
 	return NULL;
 }
 
-void rds_tcp_conn_slots_available(struct rds_connection *conn)
+void rds_tcp_conn_slots_available(struct rds_connection *conn, bool fan_out)
 {
 	struct rds_tcp_connection *tc;
 	struct rds_tcp_net *rtn;
+	struct socket *sock;
+	int sport, npaths;
 
 	if (rds_destroy_pending(conn))
 		return;
@@ -124,6 +138,21 @@ void rds_tcp_conn_slots_available(struct rds_connection *conn)
 	if (!rtn)
 		return;
 
+	sock = tc->t_sock;
+
+	/* During fan-out, check that the connection we already
+	 * accepted in slot#0 carried the proper source port modulo.
+	 */
+	if (fan_out && conn->c_with_sport_idx && sock &&
+	    rds_addr_cmp(&conn->c_laddr, &conn->c_faddr) > 0) {
+		/* cp->cp_index is encoded in lowest bits of source-port */
+		sport = rds_tcp_get_peer_sport(sock);
+		npaths = max_t(int, 1, conn->c_npaths);
+		if (sport >= 0 && sport % npaths != 0)
+			/* peer initiated with a non-#0 lane first */
+			rds_conn_path_drop(conn->c_path, 0);
+	}
+
 	/* As soon as a connection went down,
 	 * it is safe to schedule a "rds_tcp_accept_one"
 	 * attempt even if there are no connections pending:
-- 
2.43.0


