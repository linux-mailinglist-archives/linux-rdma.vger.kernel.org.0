Return-Path: <linux-rdma+bounces-16283-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEj1BaRafWmBRgIAu9opvQ
	(envelope-from <linux-rdma+bounces-16283-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 31 Jan 2026 02:28:04 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F28C0020
	for <lists+linux-rdma@lfdr.de>; Sat, 31 Jan 2026 02:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 451453066434
	for <lists+linux-rdma@lfdr.de>; Sat, 31 Jan 2026 01:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B8C3346A6;
	Sat, 31 Jan 2026 01:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HT69voow"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3EB32B9BE;
	Sat, 31 Jan 2026 01:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769822717; cv=none; b=gagATlyNALLSqkGL3r7AOn4i/KAQmilkKzRxlf7+kyymWGCzexIk4Di51cz8P8aSOwcdbnoLd6xsgUxdbAzBZIYo5eo8jh4cwoBuEA0ie3HKKBlgaWQ4aF/yKtpm0veGRnDasDiGUaYJlaUf9FQApgVp8Ug3KjuUlJj+pFBg3A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769822717; c=relaxed/simple;
	bh=9cKpNKd985w4dA4LqASMf31OJjqTjQzRadKCmrGgVzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DfzblHVsAmX6cqC4aM8TF1i7SmBPkz+nwZQyk8QtSLKCeLp1Kz67rGPd+cQS1po+Vl9EqT3YaDLbgZacIbOEg6bdkGTTvuCDeFWRgFUiDJvMy0Lgg0C8WJrQ+op3gzAkZ12vZhiiSIbbWig3ivUrk34VPhFIqNUOj3iPzXJ8DSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HT69voow; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABB42C4CEF7;
	Sat, 31 Jan 2026 01:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769822716;
	bh=9cKpNKd985w4dA4LqASMf31OJjqTjQzRadKCmrGgVzY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HT69voowptdrLTcvhSxzm7KfzkxZB1sA0x2dOkfMiSsOsGJaXIkDHUmEKu+bDWKMq
	 xEVrOmxsTD5S6Obe0B45gTL5KyooSw+6RENBxZKx3d3UCRqeNF1jJ4nBfV2YBwtWCW
	 jv2+buuF41skkhROEO3WSlDrNy9aZzTMhbYE6/ULAKJGrA/4wJYmiSb3pHxX3SEI2z
	 OaThZ9qIozmzlFaQRk+TLlYOrSfnk3Cu0hb+Sk66ETDOAM880jg+HARlEp1tGh+ls5
	 KqDiilNrKpQlb3AmLTJlHbeeVxH3rhv3NJu9wN5vRm6U3co0IJFHvRHqSRbOC7P3Cg
	 AQW37Zj+9gf4Q==
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
Subject: [PATCH net-next v4 8/8] net/rds: Trigger rds_send_ping() more than once
Date: Fri, 30 Jan 2026 18:25:07 -0700
Message-ID: <20260131012507.814119-9-achender@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260131012507.814119-1-achender@kernel.org>
References: <20260131012507.814119-1-achender@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-16283-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: B1F28C0020
X-Rspamd-Action: no action

From: Original Author <email@example.com>

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
 net/rds/send.c       | 18 +++++++++++++++
 net/rds/tcp.h        |  2 +-
 net/rds/tcp_listen.c | 55 +++++++++++++++++++++++++++++++++-----------
 6 files changed, 72 insertions(+), 17 deletions(-)

diff --git a/net/rds/connection.c b/net/rds/connection.c
index 4b7715eb2111..185f73b01694 100644
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
index 6d9f4a08b0ee..6e0790e4b570 100644
--- a/net/rds/rds.h
+++ b/net/rds/rds.h
@@ -549,7 +549,7 @@ struct rds_transport {
 	 * messages received on the new socket are not discarded when no
 	 * connection path was available at the time.
 	 */
-	void (*conn_slots_available)(struct rds_connection *conn);
+	void (*conn_slots_available)(struct rds_connection *conn, bool fan_out);
 	int (*conn_path_connect)(struct rds_conn_path *cp);
 
 	/*
diff --git a/net/rds/recv.c b/net/rds/recv.c
index 889a5b7935e5..4b3f9e4a8bfd 100644
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
index 599c2cfb7a1d..6e96f108473e 100644
--- a/net/rds/send.c
+++ b/net/rds/send.c
@@ -1339,6 +1339,24 @@ int rds_sendmsg(struct socket *sock, struct msghdr *msg, size_t payload_len)
 		cpath = &conn->c_path[0];
 	}
 
+	 /* If we're multipath capable and path 0 is down, queue reconnect
+	  * and send a ping. This initiates the multipath handshake through
+	  * rds_send_probe(), which sends RDS_EXTHDR_NPATHS to the peer,
+	  * starting multipath capability negotiation.
+	  */
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
index b36af0865a07..39c86347188c 100644
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
index b5786227623c..6fb5c928b8fd 100644
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
-	    kernel_getpeername(sock, &saddr.addr) >= 0) {
-		/* cp->cp_index is encoded in lowest bits of source-port */
+	if (kernel_getpeername(sock, &saddr.addr) >= 0) {
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


