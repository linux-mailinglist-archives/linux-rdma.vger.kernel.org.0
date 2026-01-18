Return-Path: <linux-rdma+bounces-15666-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AF6D39248
	for <lists+linux-rdma@lfdr.de>; Sun, 18 Jan 2026 03:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 227323031363
	for <lists+linux-rdma@lfdr.de>; Sun, 18 Jan 2026 02:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF5A21D3F0;
	Sun, 18 Jan 2026 02:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJmggslq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E7021C160;
	Sun, 18 Jan 2026 02:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768704556; cv=none; b=CvGQTx5Zc1bkeyZg/E11YaqJ6Fc/jIpJ+L+lZgd2OH5ZbtS0aRDbim4t9G4iGPBUTFlibvFRM8++uX8RfkjgKebypmFhqt9F3aUjF2JQRrOG1wBE4FvRVzaXXbsY0ONYvw6ZjNOTYINr905UPNyXdSxAtCVbTf5Q8G8CpQhO604=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768704556; c=relaxed/simple;
	bh=lkP0fbOOKsPf+A5WYeLDwQbM1iFOsfHLLqxX/mVfzHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CBzobuPOewbgZi7DX/BioTt9ZXqCeoqIdMIPJkFRoKF0Uw/9K0whNOZ5txWtXBoG3ZlXblOEZIQ9OSwpVkDQs7GXXIcIwd6chV7bLftfFPtxKTNISF0ShukJZcnixNVlw9OPmN9rE8Jexz9r7ny/xtFNMr4+IKBDJP30Q/0KJHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SJmggslq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69316C19423;
	Sun, 18 Jan 2026 02:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768704556;
	bh=lkP0fbOOKsPf+A5WYeLDwQbM1iFOsfHLLqxX/mVfzHs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SJmggslq5HbJroE4kls1Hq9pAm+IGmMDs3q3ynx3R1piMGDgT4ujO9m+kKPGJ39Z0
	 k2lX+0hpPt0WBSHmUPVWkhhJFbVoVQ0WMLcOu9EbikF/hFtMp1OpaR8knud1dXD6Zc
	 wEaAtph8CoCioPzl9Fd/lyvX/B4gs0ze8dgpHTKi1/3ZFdW6tKMsl9VUkdvLvTPIF+
	 UVm42qYbzwFJ4PC1e5n1a6kh48GEQFAKrg8QT6Rn83B9OpBE/H/nxUQ79oaAFWTPp7
	 MTMZWHX9WW3fLuqXv5gMkHVoBnOhZ+q7MSARIyxfBVMaSb8/ZRRJuGKphGgJepBetM
	 XvRsFccfZx12g==
From: Allison Henderson <achender@kernel.org>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	rds-devel@oss.oracle.com,
	kuba@kernel.org,
	horms@kernel.org,
	linux-rdma@vger.kernel.org,
	allison.henderson@oracle.com
Subject: [PATCH net-next v1 3/3] net/rds: rds_tcp_accept_one ought to not discard messages
Date: Sat, 17 Jan 2026 19:49:11 -0700
Message-ID: <20260118024911.1203224-4-achender@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260118024911.1203224-1-achender@kernel.org>
References: <20260118024911.1203224-1-achender@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gerd Rausch <gerd.rausch@oracle.com>

RDS/TCP differs from RDS/RDMA in that message acknowledgment
is done based on TCP sequence numbers:
As soon as the last byte of a message has been acknowledged
by the TCP stack of a peer, "rds_tcp_write_space()" goes on
to discard prior messages from the send queue.

Which is fine, for as long as the receiver never throws any messages away.

Unfortunately, that is *not* the case since the introduction of MPRDS:
commit 1a0e100fb2c96 "RDS: TCP: Enable multipath RDS for TCP"

A new function "rds_tcp_accept_one_path" was introduced,
which is entitled to return "NULL", if no connection path is currently
available.

Unfortunately, this happens after the "->accept()" call, and the new socket
often already contains messages, since the peer already transitioned
to "RDS_CONN_UP" on behalf of "TCP_ESTABLISHED".

That's also the case after this [1]:
commit 1a0e100fb2c96 "RDS: TCP: Force every connection to be initiated by
numerically smaller IP address"

which tried to address the situation of pending data by only transitioning
connections from a smaller IP address to "RDS_CONN_UP".

But even in those cases, and in particular if the "RDS_EXTHDR_NPATHS"
handshake has not occurred yet, and therefore we're working with
"c_npaths <= 1", "c_conn[0]" may be in a state distinct from
"RDS_CONN_DOWN", and therefore all messages on the just accepted socket
will be tossed away.

This fix changes "rds_tcp_accept_one":

* If connected from a peer with a larger IP address, the new socket
  will continue to get closed right away.
  With commit [1] above, there should not be any messages
  in the socket receive buffer, since the peer never transitioned
  to "RDS_CONN_UP".
  Therefore it should be okay to not make any efforts to dispatch
  the socket receive buffer.

* If connected from a peer with a smaller IP address,
  we call "rds_tcp_accept_one_path" to find a free slot/"path".
  If found, business goes on as usual.
  If none was found, we save/stash the newly accepted socket
  into "rds_tcp_accepted_sock", in order to not lose any
  messages that may have arrived already.
  We then return from "rds_tcp_accept_one" with "-ENOBUFS".
  Later on, when a slot/"path" does become available again
  (e.g. state transitioned to "RDS_CONN_DOWN",
   or HS extension header was received with "c_npaths > 1")
  we call "rds_tcp_conn_slots_available" that simply re-issues
  a "rds_tcp_accept_one_path" worker-callback and picks
  up the new socket from "rds_tcp_accepted_sock", and thereby
  continuing where it left with "-ENOBUFS" last time.
  Since a new slot has become available, those messages
  won't be lost, since processing proceeds as if that slot
  had been available the first time around.

Signed-off-by: Gerd Rausch <gerd.rausch@oracle.com>
Signed-off-by: Jack Vogel <jack.vogel@oracle.com>
Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
---
 net/rds/connection.c |   3 ++
 net/rds/rds.h        |  65 +++++++++++++----------
 net/rds/recv.c       |   4 ++
 net/rds/tcp.c        |  27 ++++------
 net/rds/tcp.h        |  22 +++++++-
 net/rds/tcp_listen.c | 123 ++++++++++++++++++++++++++++++++-----------
 6 files changed, 168 insertions(+), 76 deletions(-)

diff --git a/net/rds/connection.c b/net/rds/connection.c
index 4a9d80d56f56..3f26a67f3180 100644
--- a/net/rds/connection.c
+++ b/net/rds/connection.c
@@ -449,6 +449,9 @@ void rds_conn_shutdown(struct rds_conn_path *cp)
 	} else {
 		rcu_read_unlock();
 	}
+
+	if (conn->c_trans->conn_slots_available)
+		conn->c_trans->conn_slots_available(conn);
 }
 
 /* destroy a single rds_conn_path. rds_conn_destroy() iterates over
diff --git a/net/rds/rds.h b/net/rds/rds.h
index b35afa2658cc..e989af1d1dc0 100644
--- a/net/rds/rds.h
+++ b/net/rds/rds.h
@@ -506,33 +506,6 @@ struct rds_notifier {
  */
 #define	RDS_TRANS_LOOP	3
 
-/**
- * struct rds_transport -  transport specific behavioural hooks
- *
- * @xmit: .xmit is called by rds_send_xmit() to tell the transport to send
- *        part of a message.  The caller serializes on the send_sem so this
- *        doesn't need to be reentrant for a given conn.  The header must be
- *        sent before the data payload.  .xmit must be prepared to send a
- *        message with no data payload.  .xmit should return the number of
- *        bytes that were sent down the connection, including header bytes.
- *        Returning 0 tells the caller that it doesn't need to perform any
- *        additional work now.  This is usually the case when the transport has
- *        filled the sending queue for its connection and will handle
- *        triggering the rds thread to continue the send when space becomes
- *        available.  Returning -EAGAIN tells the caller to retry the send
- *        immediately.  Returning -ENOMEM tells the caller to retry the send at
- *        some point in the future.
- *
- * @conn_shutdown: conn_shutdown stops traffic on the given connection.  Once
- *                 it returns the connection can not call rds_recv_incoming().
- *                 This will only be called once after conn_connect returns
- *                 non-zero success and will The caller serializes this with
- *                 the send and connecting paths (xmit_* and conn_*).  The
- *                 transport is responsible for other serialization, including
- *                 rds_recv_incoming().  This is called in process context but
- *                 should try hard not to block.
- */
-
 struct rds_transport {
 	char			t_name[TRANSNAMSIZ];
 	struct list_head	t_item;
@@ -545,10 +518,48 @@ struct rds_transport {
 			   __u32 scope_id);
 	int (*conn_alloc)(struct rds_connection *conn, gfp_t gfp);
 	void (*conn_free)(void *data);
+
+	/*
+	 * conn_slots_available is invoked when a previously unavailable connection slot
+	 * becomes available again. rds_tcp_accept_one_path may return -ENOBUFS if it
+	 * cannot find an available slot, and then stashes the new socket in
+	 * "rds_tcp_accepted_sock". This function re-issues `rds_tcp_accept_one_path`,
+	 * which picks up the stashed socket and continuing where it left with "-ENOBUFS"
+	 * last time.  This ensures messages received on the new socket are not discarded
+	 * when no connection path was available at the time.
+	 */
+	void (*conn_slots_available)(struct rds_connection *conn);
 	int (*conn_path_connect)(struct rds_conn_path *cp);
+
+	/*
+	 * conn_shutdown stops traffic on the given connection.  Once
+	 * it returns the connection can not call rds_recv_incoming().
+	 * This will only be called once after conn_connect returns
+	 * non-zero success and will The caller serializes this with
+	 * the send and connecting paths (xmit_* and conn_*).  The
+	 * transport is responsible for other serialization, including
+	 * rds_recv_incoming().  This is called in process context but
+	 * should try hard not to block.
+	 */
 	void (*conn_path_shutdown)(struct rds_conn_path *conn);
 	void (*xmit_path_prepare)(struct rds_conn_path *cp);
 	void (*xmit_path_complete)(struct rds_conn_path *cp);
+
+	/*
+	 * .xmit is called by rds_send_xmit() to tell the transport to send
+	 * part of a message.  The caller serializes on the send_sem so this
+	 * doesn't need to be reentrant for a given conn.  The header must be
+	 * sent before the data payload.  .xmit must be prepared to send a
+	 * message with no data payload.  .xmit should return the number of
+	 * bytes that were sent down the connection, including header bytes.
+	 * Returning 0 tells the caller that it doesn't need to perform any
+	 * additional work now.  This is usually the case when the transport has
+	 * filled the sending queue for its connection and will handle
+	 * triggering the rds thread to continue the send when space becomes
+	 * available.  Returning -EAGAIN tells the caller to retry the send
+	 * immediately.  Returning -ENOMEM tells the caller to retry the send at
+	 * some point in the future.
+	 */
 	int (*xmit)(struct rds_connection *conn, struct rds_message *rm,
 		    unsigned int hdr_off, unsigned int sg, unsigned int off);
 	int (*xmit_rdma)(struct rds_connection *conn, struct rm_rdma_op *op);
diff --git a/net/rds/recv.c b/net/rds/recv.c
index 66205d6924bf..66680f652e74 100644
--- a/net/rds/recv.c
+++ b/net/rds/recv.c
@@ -230,6 +230,10 @@ static void rds_recv_hs_exthdrs(struct rds_header *hdr,
 	conn->c_npaths = max_t(int, conn->c_npaths, 1);
 	conn->c_ping_triggered = 0;
 	rds_conn_peer_gen_update(conn, new_peer_gen_num);
+
+	if (conn->c_npaths > 1 &&
+	    conn->c_trans->conn_slots_available)
+		conn->c_trans->conn_slots_available(conn);
 }
 
 /* rds_start_mprds() will synchronously start multiple paths when appropriate.
diff --git a/net/rds/tcp.c b/net/rds/tcp.c
index 3cc2f303bf78..31e7425e2da9 100644
--- a/net/rds/tcp.c
+++ b/net/rds/tcp.c
@@ -213,6 +213,8 @@ void rds_tcp_set_callbacks(struct socket *sock, struct rds_conn_path *cp)
 		sock->sk->sk_data_ready = sock->sk->sk_user_data;
 
 	tc->t_sock = sock;
+	if (!tc->t_rtn)
+		tc->t_rtn = net_generic(sock_net(sock->sk), rds_tcp_netid);
 	tc->t_cpath = cp;
 	tc->t_orig_data_ready = sock->sk->sk_data_ready;
 	tc->t_orig_write_space = sock->sk->sk_write_space;
@@ -378,6 +380,7 @@ static int rds_tcp_conn_alloc(struct rds_connection *conn, gfp_t gfp)
 		}
 		mutex_init(&tc->t_conn_path_lock);
 		tc->t_sock = NULL;
+		tc->t_rtn = NULL;
 		tc->t_tinc = NULL;
 		tc->t_tinc_hdr_rem = sizeof(struct rds_header);
 		tc->t_tinc_data_rem = 0;
@@ -458,6 +461,7 @@ struct rds_transport rds_tcp_transport = {
 	.recv_path		= rds_tcp_recv_path,
 	.conn_alloc		= rds_tcp_conn_alloc,
 	.conn_free		= rds_tcp_conn_free,
+	.conn_slots_available	= rds_tcp_conn_slots_available,
 	.conn_path_connect	= rds_tcp_conn_path_connect,
 	.conn_path_shutdown	= rds_tcp_conn_path_shutdown,
 	.inc_copy_to_user	= rds_tcp_inc_copy_to_user,
@@ -473,17 +477,7 @@ struct rds_transport rds_tcp_transport = {
 	.t_unloading		= rds_tcp_is_unloading,
 };
 
-static unsigned int rds_tcp_netid;
-
-/* per-network namespace private data for this module */
-struct rds_tcp_net {
-	struct socket *rds_tcp_listen_sock;
-	struct work_struct rds_tcp_accept_w;
-	struct ctl_table_header *rds_tcp_sysctl;
-	struct ctl_table *ctl_table;
-	int sndbuf_size;
-	int rcvbuf_size;
-};
+int rds_tcp_netid;
 
 /* All module specific customizations to the RDS-TCP socket should be done in
  * rds_tcp_tune() and applied after socket creation.
@@ -526,15 +520,12 @@ static void rds_tcp_accept_worker(struct work_struct *work)
 					       struct rds_tcp_net,
 					       rds_tcp_accept_w);
 
-	while (rds_tcp_accept_one(rtn->rds_tcp_listen_sock) == 0)
+	while (rds_tcp_accept_one(rtn) == 0)
 		cond_resched();
 }
 
-void rds_tcp_accept_work(struct sock *sk)
+void rds_tcp_accept_work(struct rds_tcp_net *rtn)
 {
-	struct net *net = sock_net(sk);
-	struct rds_tcp_net *rtn = net_generic(net, rds_tcp_netid);
-
 	queue_work(rds_wq, &rtn->rds_tcp_accept_w);
 }
 
@@ -546,6 +537,8 @@ static __net_init int rds_tcp_init_net(struct net *net)
 
 	memset(rtn, 0, sizeof(*rtn));
 
+	mutex_init(&rtn->rds_tcp_accept_lock);
+
 	/* {snd, rcv}buf_size default to 0, which implies we let the
 	 * stack pick the value, and permit auto-tuning of buffer size.
 	 */
@@ -609,6 +602,8 @@ static void rds_tcp_kill_sock(struct net *net)
 
 	rtn->rds_tcp_listen_sock = NULL;
 	rds_tcp_listen_stop(lsock, &rtn->rds_tcp_accept_w);
+	if (rtn->rds_tcp_accepted_sock)
+		sock_release(rtn->rds_tcp_accepted_sock);
 	spin_lock_irq(&rds_tcp_conn_lock);
 	list_for_each_entry_safe(tc, _tc, &rds_tcp_conn_list, t_tcp_node) {
 		struct net *c_net = read_pnet(&tc->t_cpath->cp_conn->c_net);
diff --git a/net/rds/tcp.h b/net/rds/tcp.h
index 053aa7da87ef..2000f4acd57a 100644
--- a/net/rds/tcp.h
+++ b/net/rds/tcp.h
@@ -4,6 +4,21 @@
 
 #define RDS_TCP_PORT	16385
 
+/* per-network namespace private data for this module */
+struct rds_tcp_net {
+	/* serialize "rds_tcp_accept_one" with "rds_tcp_accept_lock"
+	 * to protect "rds_tcp_accepted_sock"
+	 */
+	struct mutex		rds_tcp_accept_lock;
+	struct socket		*rds_tcp_listen_sock;
+	struct socket		*rds_tcp_accepted_sock;
+	struct work_struct	rds_tcp_accept_w;
+	struct ctl_table_header	*rds_tcp_sysctl;
+	struct ctl_table	*ctl_table;
+	int			sndbuf_size;
+	int			rcvbuf_size;
+};
+
 struct rds_tcp_incoming {
 	struct rds_incoming	ti_inc;
 	struct sk_buff_head	ti_skb_list;
@@ -19,6 +34,7 @@ struct rds_tcp_connection {
 	 */
 	struct mutex		t_conn_path_lock;
 	struct socket		*t_sock;
+	struct rds_tcp_net	*t_rtn;
 	void			*t_orig_write_space;
 	void			*t_orig_data_ready;
 	void			*t_orig_state_change;
@@ -49,6 +65,7 @@ struct rds_tcp_statistics {
 };
 
 /* tcp.c */
+extern int rds_tcp_netid;
 bool rds_tcp_tune(struct socket *sock);
 void rds_tcp_set_callbacks(struct socket *sock, struct rds_conn_path *cp);
 void rds_tcp_reset_callbacks(struct socket *sock, struct rds_conn_path *cp);
@@ -57,7 +74,7 @@ void rds_tcp_restore_callbacks(struct socket *sock,
 u32 rds_tcp_write_seq(struct rds_tcp_connection *tc);
 u32 rds_tcp_snd_una(struct rds_tcp_connection *tc);
 extern struct rds_transport rds_tcp_transport;
-void rds_tcp_accept_work(struct sock *sk);
+void rds_tcp_accept_work(struct rds_tcp_net *rtn);
 int rds_tcp_laddr_check(struct net *net, const struct in6_addr *addr,
 			__u32 scope_id);
 /* tcp_connect.c */
@@ -69,7 +86,8 @@ void rds_tcp_state_change(struct sock *sk);
 struct socket *rds_tcp_listen_init(struct net *net, bool isv6);
 void rds_tcp_listen_stop(struct socket *sock, struct work_struct *acceptor);
 void rds_tcp_listen_data_ready(struct sock *sk);
-int rds_tcp_accept_one(struct socket *sock);
+void rds_tcp_conn_slots_available(struct rds_connection *conn);
+int rds_tcp_accept_one(struct rds_tcp_net *rtn);
 void rds_tcp_keepalive(struct socket *sock);
 void *rds_tcp_listen_sock_def_readable(struct net *net);
 
diff --git a/net/rds/tcp_listen.c b/net/rds/tcp_listen.c
index 27b6107ddc28..7433f2b46a98 100644
--- a/net/rds/tcp_listen.c
+++ b/net/rds/tcp_listen.c
@@ -35,6 +35,8 @@
 #include <linux/in.h>
 #include <net/tcp.h>
 #include <trace/events/sock.h>
+#include <net/net_namespace.h>
+#include <net/netns/generic.h>
 
 #include "rds.h"
 #include "tcp.h"
@@ -66,32 +68,46 @@ struct rds_tcp_connection *rds_tcp_accept_one_path(struct rds_connection *conn)
 	int i;
 	int npaths = max_t(int, 1, conn->c_npaths);
 
-	/* for mprds, all paths MUST be initiated by the peer
-	 * with the smaller address.
-	 */
-	if (rds_addr_cmp(&conn->c_faddr, &conn->c_laddr) >= 0) {
-		/* Make sure we initiate at least one path if this
-		 * has not already been done; rds_start_mprds() will
-		 * take care of additional paths, if necessary.
-		 */
-		if (npaths == 1)
-			rds_conn_path_connect_if_down(&conn->c_path[0]);
-		return NULL;
-	}
-
 	for (i = 0; i < npaths; i++) {
 		struct rds_conn_path *cp = &conn->c_path[i];
 
 		if (rds_conn_path_transition(cp, RDS_CONN_DOWN,
-					     RDS_CONN_CONNECTING)) {
+					     RDS_CONN_CONNECTING))
 			return cp->cp_transport_data;
-		}
 	}
 	return NULL;
 }
 
-int rds_tcp_accept_one(struct socket *sock)
+void rds_tcp_conn_slots_available(struct rds_connection *conn)
 {
+	struct rds_tcp_connection *tc;
+	struct rds_tcp_net *rtn;
+
+	if (rds_destroy_pending(conn))
+		return;
+
+	tc = conn->c_path->cp_transport_data;
+	rtn = tc->t_rtn;
+	if (!rtn)
+		return;
+
+	/* As soon as a connection went down,
+	 * it is safe to schedule a "rds_tcp_accept_one"
+	 * attempt even if there are no connections pending:
+	 * Function "rds_tcp_accept_one" won't block
+	 * but simply return -EAGAIN in that case.
+	 *
+	 * Doing so is necessary to address the case where an
+	 * incoming connection on "rds_tcp_listen_sock" is ready
+	 * to be acccepted prior to a free slot being available:
+	 * the -ENOBUFS case in "rds_tcp_accept_one".
+	 */
+	rds_tcp_accept_work(rtn);
+}
+
+int rds_tcp_accept_one(struct rds_tcp_net *rtn)
+{
+	struct socket *listen_sock = rtn->rds_tcp_listen_sock;
 	struct socket *new_sock = NULL;
 	struct rds_connection *conn;
 	int ret;
@@ -105,17 +121,23 @@ int rds_tcp_accept_one(struct socket *sock)
 #endif
 	int dev_if = 0;
 
-	if (!sock) /* module unload or netns delete in progress */
+	if (!listen_sock) /* module unload or netns delete in progress */
 		return -ENETUNREACH;
 
-	ret = kernel_accept(sock, &new_sock, O_NONBLOCK);
-	if (ret)
-		return ret;
+	mutex_lock(&rtn->rds_tcp_accept_lock);
+	new_sock = rtn->rds_tcp_accepted_sock;
+	rtn->rds_tcp_accepted_sock = NULL;
 
-	rds_tcp_keepalive(new_sock);
-	if (!rds_tcp_tune(new_sock)) {
-		ret = -EINVAL;
-		goto out;
+	if (!new_sock) {
+		ret = kernel_accept(listen_sock, &new_sock, O_NONBLOCK);
+		if (ret)
+			goto out;
+
+		rds_tcp_keepalive(new_sock);
+		if (!rds_tcp_tune(new_sock)) {
+			ret = -EINVAL;
+			goto out;
+		}
 	}
 
 	inet = inet_sk(new_sock->sk);
@@ -130,7 +152,7 @@ int rds_tcp_accept_one(struct socket *sock)
 	peer_addr = &daddr;
 #endif
 	rdsdebug("accepted family %d tcp %pI6c:%u -> %pI6c:%u\n",
-		 sock->sk->sk_family,
+		 listen_sock->sk->sk_family,
 		 my_addr, ntohs(inet->inet_sport),
 		 peer_addr, ntohs(inet->inet_dport));
 
@@ -150,13 +172,13 @@ int rds_tcp_accept_one(struct socket *sock)
 	}
 #endif
 
-	if (!rds_tcp_laddr_check(sock_net(sock->sk), peer_addr, dev_if)) {
+	if (!rds_tcp_laddr_check(sock_net(listen_sock->sk), peer_addr, dev_if)) {
 		/* local address connection is only allowed via loopback */
 		ret = -EOPNOTSUPP;
 		goto out;
 	}
 
-	conn = rds_conn_create(sock_net(sock->sk),
+	conn = rds_conn_create(sock_net(listen_sock->sk),
 			       my_addr, peer_addr,
 			       &rds_tcp_transport, 0, GFP_KERNEL, dev_if);
 
@@ -169,15 +191,51 @@ int rds_tcp_accept_one(struct socket *sock)
 	 * If the client reboots, this conn will need to be cleaned up.
 	 * rds_tcp_state_change() will do that cleanup
 	 */
-	rs_tcp = rds_tcp_accept_one_path(conn);
-	if (!rs_tcp)
+	if (rds_addr_cmp(&conn->c_faddr, &conn->c_laddr) < 0) {
+		/* Try to obtain a free connection slot.
+		 * If unsuccessful, we need to preserve "new_sock"
+		 * that we just accepted, since its "sk_receive_queue"
+		 * may contain messages already that have been acknowledged
+		 * to and discarded by the sender.
+		 * We must not throw those away!
+		 */
+		rs_tcp = rds_tcp_accept_one_path(conn);
+		if (!rs_tcp) {
+			/* It's okay to stash "new_sock", since
+			 * "rds_tcp_conn_slots_available" triggers "rds_tcp_accept_one"
+			 * again as soon as one of the connection slots
+			 * becomes available again
+			 */
+			rtn->rds_tcp_accepted_sock = new_sock;
+			new_sock = NULL;
+			ret = -ENOBUFS;
+			goto out;
+		}
+	} else {
+		/* This connection request came from a peer with
+		 * a larger address.
+		 * Function "rds_tcp_state_change" makes sure
+		 * that the connection doesn't transition
+		 * to state "RDS_CONN_UP", and therefore
+		 * we should not have received any messages
+		 * on this socket yet.
+		 * This is the only case where it's okay to
+		 * not dequeue messages from "sk_receive_queue".
+		 */
+		if (conn->c_npaths <= 1)
+			rds_conn_path_connect_if_down(&conn->c_path[0]);
+		rs_tcp = NULL;
 		goto rst_nsk;
+	}
+
 	mutex_lock(&rs_tcp->t_conn_path_lock);
 	cp = rs_tcp->t_cpath;
 	conn_state = rds_conn_path_state(cp);
 	WARN_ON(conn_state == RDS_CONN_UP);
-	if (conn_state != RDS_CONN_CONNECTING && conn_state != RDS_CONN_ERROR)
+	if (conn_state != RDS_CONN_CONNECTING && conn_state != RDS_CONN_ERROR) {
+		rds_conn_path_drop(cp, 0);
 		goto rst_nsk;
+	}
 	if (rs_tcp->t_sock) {
 		/* Duelling SYN has been handled in rds_tcp_accept_one() */
 		rds_tcp_reset_callbacks(new_sock, cp);
@@ -207,6 +265,9 @@ int rds_tcp_accept_one(struct socket *sock)
 		mutex_unlock(&rs_tcp->t_conn_path_lock);
 	if (new_sock)
 		sock_release(new_sock);
+
+	mutex_unlock(&rtn->rds_tcp_accept_lock);
+
 	return ret;
 }
 
@@ -234,7 +295,7 @@ void rds_tcp_listen_data_ready(struct sock *sk)
 	 * the listen socket is being torn down.
 	 */
 	if (sk->sk_state == TCP_LISTEN)
-		rds_tcp_accept_work(sk);
+		rds_tcp_accept_work(net_generic(sock_net(sk), rds_tcp_netid));
 	else
 		ready = rds_tcp_listen_sock_def_readable(sock_net(sk));
 
-- 
2.43.0


