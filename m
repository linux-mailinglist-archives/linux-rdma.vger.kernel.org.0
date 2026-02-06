Return-Path: <linux-rdma+bounces-16619-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0E4BK1NRhWmV/wMAu9opvQ
	(envelope-from <linux-rdma+bounces-16619-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Feb 2026 03:26:27 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D780F945B
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Feb 2026 03:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 64E2C3065AD2
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Feb 2026 02:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E73261B78;
	Fri,  6 Feb 2026 02:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aLswhuYs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA71425DB0D;
	Fri,  6 Feb 2026 02:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770344661; cv=none; b=sAmcuyt5ukVY0/MSZcCVnZ7BqlFCkvpTD4Gl88wwwijGEP0YNRWtSxwdj9E6VA5TRyaaChJVGhVrIkGhdhlIafbPwD9TexKKvoNHgVUl3c5iE7EplTSi3VUTbB+tX34FgVEV4hFC6CBPEU1yJPOwnDQc7qyKIvrymr/tMHa2+wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770344661; c=relaxed/simple;
	bh=q3ci+4WBbQdpDAjbx3/quH7bd6fXyWsk2mkzI+63/C0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FWSbPclN1HZUucUXCIccZRiiOuYZU5UM25Kt7Q4RYrMTwTNzgpGl2hrsyaN2nKouVRQjnZ0rm0A9hQxCft10hSy//B2jLfkHDAGJpVCXJ9UDqFfrxSKm4MOW0Hai9Cy6YVBjCBP+BGsQxkNRdMwpfww70HuIcOxz6ced6a9Bll4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aLswhuYs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08069C19423;
	Fri,  6 Feb 2026 02:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770344661;
	bh=q3ci+4WBbQdpDAjbx3/quH7bd6fXyWsk2mkzI+63/C0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aLswhuYsr5FNUnpUltTYZR+mQ9Gm3n8rVevxLhAZoRH0mgeE5MhVlamBfTgWOxMLh
	 1/mNjZWqZZvP9G7e8Vi4CJFtjktgRCJhn+sOjvJDIOg8qyfI0G62ih73wg5ZAajPCZ
	 iEFxjkkwhxzgkmfwHcsxT+SYIokLDe/4ZOrEE9MtgnblfJmXeCqYgRErOcJqcx5sbO
	 Tat1ocTv/7pREktVhIoRdyXYRAsvgdOSeKpfBm8yNqZinrcGmDnI1MYqwmfyQYppe3
	 OLDn+3E4zmAldfOJXeTqwRR6Mdy1nPw5yEhVE1a8Zg9fiYkDMdSUsB/Yu3X8MYeVfC
	 WCww4SEjcu29A==
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
Subject: [PATCH net-next v1 1/3] net/rds: Delegate fan-out to a background worker
Date: Thu,  5 Feb 2026 19:24:17 -0700
Message-ID: <20260206022419.1357513-2-achender@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260206022419.1357513-1-achender@kernel.org>
References: <20260206022419.1357513-1-achender@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-16619-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: 6D780F945B
X-Rspamd-Action: no action

From: Gerd Rausch <gerd.rausch@oracle.com>

Delegate fan-out to a background worker in order to allow
kernel_getpeername() to acquire a lock on the socket.

This has become necessary since the introduction of
commit "9dfc685e0262d ("inet: remove races in inet{6}_getname()")

The socket is already locked in the context that
"kernel_getpeername" used to get called by either
rds_tcp_recv_path" or "tcp_v{4,6}_rcv",
and therefore causing a deadlock.

Luckily, the fan-out need not happen in-context nor fast,
so we can easily just do the same in a background worker.

Also, while we're doing this, we get rid of the unused
struct members "t_conn_w", "t_send_w", "t_down_w" & "t_recv_w".

Signed-off-by: Gerd Rausch <gerd.rausch@oracle.com>
Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
---
 net/rds/tcp.c         |  3 +++
 net/rds/tcp.h         |  7 ++----
 net/rds/tcp_connect.c |  2 ++
 net/rds/tcp_listen.c  | 54 +++++++++++++++++++++++++++++++------------
 4 files changed, 46 insertions(+), 20 deletions(-)

diff --git a/net/rds/tcp.c b/net/rds/tcp.c
index 45484a93d75f..02f8f928c20b 100644
--- a/net/rds/tcp.c
+++ b/net/rds/tcp.c
@@ -358,6 +358,8 @@ static void rds_tcp_conn_free(void *arg)
 
 	rdsdebug("freeing tc %p\n", tc);
 
+	cancel_work_sync(&tc->t_fan_out_w);
+
 	spin_lock_irqsave(&rds_tcp_conn_lock, flags);
 	if (!tc->t_tcp_node_detached)
 		list_del(&tc->t_tcp_node);
@@ -384,6 +386,7 @@ static int rds_tcp_conn_alloc(struct rds_connection *conn, gfp_t gfp)
 		tc->t_tinc = NULL;
 		tc->t_tinc_hdr_rem = sizeof(struct rds_header);
 		tc->t_tinc_data_rem = 0;
+		INIT_WORK(&tc->t_fan_out_w, rds_tcp_fan_out_w);
 		init_waitqueue_head(&tc->t_recv_done_waitq);
 
 		conn->c_path[i].cp_transport_data = tc;
diff --git a/net/rds/tcp.h b/net/rds/tcp.h
index 39c86347188c..9ecb0b6b658a 100644
--- a/net/rds/tcp.h
+++ b/net/rds/tcp.h
@@ -44,11 +44,7 @@ struct rds_tcp_connection {
 	size_t			t_tinc_hdr_rem;
 	size_t			t_tinc_data_rem;
 
-	/* XXX error report? */
-	struct work_struct	t_conn_w;
-	struct work_struct	t_send_w;
-	struct work_struct	t_down_w;
-	struct work_struct	t_recv_w;
+	struct work_struct	t_fan_out_w;
 
 	/* for info exporting only */
 	struct list_head	t_list_item;
@@ -90,6 +86,7 @@ void rds_tcp_state_change(struct sock *sk);
 struct socket *rds_tcp_listen_init(struct net *net, bool isv6);
 void rds_tcp_listen_stop(struct socket *sock, struct work_struct *acceptor);
 void rds_tcp_listen_data_ready(struct sock *sk);
+void rds_tcp_fan_out_w(struct work_struct *work);
 void rds_tcp_conn_slots_available(struct rds_connection *conn, bool fan_out);
 int rds_tcp_accept_one(struct rds_tcp_net *rtn);
 void rds_tcp_keepalive(struct socket *sock);
diff --git a/net/rds/tcp_connect.c b/net/rds/tcp_connect.c
index b77c88ffb199..6954b8c479f1 100644
--- a/net/rds/tcp_connect.c
+++ b/net/rds/tcp_connect.c
@@ -115,6 +115,8 @@ int rds_tcp_conn_path_connect(struct rds_conn_path *cp)
 	if (cp->cp_index > 0 && cp->cp_conn->c_npaths < 2)
 		return -EAGAIN;
 
+	cancel_work_sync(&tc->t_fan_out_w);
+
 	mutex_lock(&tc->t_conn_path_lock);
 
 	if (rds_conn_path_up(cp)) {
diff --git a/net/rds/tcp_listen.c b/net/rds/tcp_listen.c
index 6fb5c928b8fd..8fb8f7d26683 100644
--- a/net/rds/tcp_listen.c
+++ b/net/rds/tcp_listen.c
@@ -123,27 +123,20 @@ rds_tcp_accept_one_path(struct rds_connection *conn, struct socket *sock)
 	return NULL;
 }
 
-void rds_tcp_conn_slots_available(struct rds_connection *conn, bool fan_out)
+void rds_tcp_fan_out_w(struct work_struct *work)
 {
-	struct rds_tcp_connection *tc;
-	struct rds_tcp_net *rtn;
-	struct socket *sock;
+	struct rds_tcp_connection *tc = container_of(work,
+						     struct rds_tcp_connection,
+						     t_fan_out_w);
+	struct rds_connection *conn = tc->t_cpath->cp_conn;
+	struct rds_tcp_net *rtn = tc->t_rtn;
+	struct socket *sock = tc->t_sock;
 	int sport, npaths;
 
-	if (rds_destroy_pending(conn))
-		return;
-
-	tc = conn->c_path->cp_transport_data;
-	rtn = tc->t_rtn;
-	if (!rtn)
-		return;
-
-	sock = tc->t_sock;
-
 	/* During fan-out, check that the connection we already
 	 * accepted in slot#0 carried the proper source port modulo.
 	 */
-	if (fan_out && conn->c_with_sport_idx && sock &&
+	if (conn->c_with_sport_idx && sock &&
 	    rds_addr_cmp(&conn->c_laddr, &conn->c_faddr) > 0) {
 		/* cp->cp_index is encoded in lowest bits of source-port */
 		sport = rds_tcp_get_peer_sport(sock);
@@ -167,6 +160,37 @@ void rds_tcp_conn_slots_available(struct rds_connection *conn, bool fan_out)
 	rds_tcp_accept_work(rtn);
 }
 
+void rds_tcp_conn_slots_available(struct rds_connection *conn, bool fan_out)
+{
+	struct rds_conn_path *cp0;
+	struct rds_tcp_connection *tc;
+	struct rds_tcp_net *rtn;
+
+	if (rds_destroy_pending(conn))
+		return;
+
+	cp0 = conn->c_path;
+	tc = cp0->cp_transport_data;
+	rtn = tc->t_rtn;
+	if (!rtn)
+		return;
+
+	if (fan_out)
+		/* Delegate fan-out to a background worker in order
+		 * to allow "kernel_getpeername" to acquire a lock
+		 * on the socket.
+		 * The socket is already locked in this context
+		 * by either "rds_tcp_recv_path" or "tcp_v{4,6}_rcv",
+		 * depending on the origin of the dequeue-request.
+		 */
+		queue_work(cp0->cp_wq, &tc->t_fan_out_w);
+	else
+		/* Fan-out either already happened or is unnecessary.
+		 * Just go ahead and attempt to accept more connections
+		 */
+		rds_tcp_accept_work(rtn);
+}
+
 int rds_tcp_accept_one(struct rds_tcp_net *rtn)
 {
 	struct socket *listen_sock = rtn->rds_tcp_listen_sock;
-- 
2.43.0


