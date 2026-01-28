Return-Path: <linux-rdma+bounces-16105-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KVUBxpjeWlhwwEAu9opvQ
	(envelope-from <linux-rdma+bounces-16105-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 02:15:06 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B761F9BD9D
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 02:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62697303428D
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 01:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C1C231A23;
	Wed, 28 Jan 2026 01:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V424HFLH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C74221F1C;
	Wed, 28 Jan 2026 01:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769562835; cv=none; b=HBAhM99lnO5iHMuq+jAhNjl4mEYFuplf/7B0MnufaurNQVNtdHd3mhIUHr7fv+sq8HXPmKc29i++k1SHu9hp8VuDjVhIH3IFKIwLl9H0i5/iZN0OfMtjAUFgFy4jdeIHjPB47ozaCxP0tt7TY/fWpNX43/OBm/2QbKGkIRWbSxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769562835; c=relaxed/simple;
	bh=mmAUfLzPmu/cqEu81fhf+txhd4Ykjwng4i+qGXZSM38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a2ZxHry6+mPJc9xDsxFIvK+jHbUk/YvRIZOGP74E8ukBlL2uSuq/ecjR22dc/E9bgg+GZyAyHduokZCUNIYB5so9Fz8J3/MGFra0P4pz/BSy4VJXV4Q0hCiNXj9hd720KsxQ9LZfWZaWED2+kab2A0h60PvmTKWibOizSH8LRZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V424HFLH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6807C116D0;
	Wed, 28 Jan 2026 01:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769562835;
	bh=mmAUfLzPmu/cqEu81fhf+txhd4Ykjwng4i+qGXZSM38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V424HFLHwraaS6GmESuqABW32uETNRTHuztl/B6mKpnVCdH7NaYrgAJt+AsOI0Tmy
	 hTzaTf2S8vNWSlmkOkZduS+IY/CzkfxCxgZBcTyogR8qOGZzFqtWNFj52Dez+ctIfd
	 tsl8Gh1dpeuQJ1No8IOlVwCN2DurkviqfbzTmAVnBsa4NIz1s+KDNn0eJArHzDEakE
	 +IBYghJZMV33O7+qhB8o3VRzK6UlJu+Fx1yTmIcya9VABMbSFy6/qAdsBhRmwFTYKb
	 drqiL6jYD2zW2rXI6X+hs6GA7DutJa6xufzV0j6OxcpqPwKYWma//WZorfmKocmd/L
	 c5RpMzTpXQInQ==
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
Subject: [PATCH net-next v2 3/7] net/rds: rds_tcp_conn_path_shutdown must not discard messages
Date: Tue, 27 Jan 2026 18:13:47 -0700
Message-ID: <20260128011351.78511-4-achender@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260128011351.78511-1-achender@kernel.org>
References: <20260128011351.78511-1-achender@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-16105-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: B761F9BD9D
X-Rspamd-Action: no action

From: Gerd Rausch <gerd.rausch@oracle.com>

RDS/TCP differs from RDS/RDMA in that message acknowledgment
is done based on TCP sequence numbers:
As soon as the last byte of a message has been acknowledged by the
TCP stack of a peer, rds_tcp_write_space() goes on to discard
prior messages from the send queue.

Which is fine, for as long as the receiver never throws any messages
away.

The dequeuing of messages in RDS/TCP is done either from the
"sk_data_ready" callback pointing to rds_tcp_data_ready()
(the most common case), or from the receive worker pointing
to rds_tcp_recv_path() which is called for as long as the
connection is "RDS_CONN_UP".

However, as soon as rds_conn_path_drop() is called for whatever reason,
including "DR_USER_RESET", "cp_state" transitions to "RDS_CONN_ERROR",
and rds_tcp_restore_callbacks() ends up restoring the callbacks
and thereby disabling message receipt.

So messages already acknowledged to the sender were dropped.

Furthermore, the "->shutdown" callback was always called
with an invalid parameter ("RCV_SHUTDOWN | SEND_SHUTDOWN == 3"),
instead of the correct pre-increment value ("SHUT_RDWR == 2").
inet_shutdown() returns "-EINVAL" in such cases, rendering
this call a NOOP.

So we change rds_tcp_conn_path_shutdown() to do the proper
"->shutdown(SHUT_WR)" call in order to signal EOF to the peer
and make it transition to "TCP_CLOSE_WAIT" (RFC 793).

This should make the peer also enter rds_tcp_conn_path_shutdown()
and do the same.

This allows us to dequeue all messages already received
and acknowledged to the peer.
We do so, until we know that the receive queue no longer has data
(skb_queue_empty()) and that we couldn't have any data
in flight anymore, because the socket transitioned to
any of the states "CLOSING", "TIME_WAIT", "CLOSE_WAIT",
"LAST_ACK", or "CLOSE" (RFC 793).

However, if we do just that, we suddenly see duplicate RDS
messages being delivered to the application.
So what gives?

Turns out that with MPRDS and its multitude of backend connections,
retransmitted messages ("RDS_FLAG_RETRANSMITTED") can outrace
the dequeuing of their original counterparts.

And the duplicate check implemented in rds_recv_local() only
discards duplicates if flag "RDS_FLAG_RETRANSMITTED" is set.

Rather curious, because a duplicate is a duplicate; it shouldn't
matter which copy is looked at and delivered first.

To avoid this entire situation, we simply make the sender discard
messages from the send-queue right from within
rds_tcp_conn_path_shutdown().  Just like rds_tcp_write_space() would
have done, were it called in time or still called.

This makes sure that we no longer have messages that we know
the receiver already dequeued sitting in our send-queue,
and therefore avoid the entire "RDS_FLAG_RETRANSMITTED" fiasco.

Now we got rid of the duplicate RDS message delivery, but we
still run into cases where RDS messages are dropped.

This time it is due to the delayed setting of the socket-callbacks
in rds_tcp_accept_one() via either rds_tcp_reset_callbacks()
or rds_tcp_set_callbacks().

By the time rds_tcp_accept_one() gets there, the socket
may already have transitioned into state "TCP_CLOSE_WAIT",
but rds_tcp_state_change() was never called.

Subsequently, "->shutdown(SHUT_WR)" did not happen either.
So the peer ends up getting stuck in state "TCP_FIN_WAIT2".

We fix that by checking for states "TCP_CLOSE_WAIT", "TCP_LAST_ACK",
or "TCP_CLOSE" and drop the freshly accepted socket in that case.

This problem is observable by running "rds-stress --reset"
frequently on either of the two sides of a RDS connection,
or both while other "rds-stress" processes are exchanging data.
Those "rds-stress" processes reported out-of-sequence
errors, with the expected sequence number being smaller
than the one actually received (due to the dropped messages).

Signed-off-by: Gerd Rausch <gerd.rausch@oracle.com>
Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
---
 net/rds/tcp.c         |  1 +
 net/rds/tcp.h         |  4 ++++
 net/rds/tcp_connect.c | 56 +++++++++++++++++++++++++++++++++++++++----
 net/rds/tcp_listen.c  | 14 +++++++++++
 net/rds/tcp_recv.c    |  4 ++++
 net/rds/tcp_send.c    |  2 +-
 6 files changed, 76 insertions(+), 5 deletions(-)

diff --git a/net/rds/tcp.c b/net/rds/tcp.c
index 31e7425e2da9..45484a93d75f 100644
--- a/net/rds/tcp.c
+++ b/net/rds/tcp.c
@@ -384,6 +384,7 @@ static int rds_tcp_conn_alloc(struct rds_connection *conn, gfp_t gfp)
 		tc->t_tinc = NULL;
 		tc->t_tinc_hdr_rem = sizeof(struct rds_header);
 		tc->t_tinc_data_rem = 0;
+		init_waitqueue_head(&tc->t_recv_done_waitq);
 
 		conn->c_path[i].cp_transport_data = tc;
 		tc->t_cpath = &conn->c_path[i];
diff --git a/net/rds/tcp.h b/net/rds/tcp.h
index 7c91974fcde7..b36af0865a07 100644
--- a/net/rds/tcp.h
+++ b/net/rds/tcp.h
@@ -55,6 +55,9 @@ struct rds_tcp_connection {
 	u32			t_last_sent_nxt;
 	u32			t_last_expected_una;
 	u32			t_last_seen_una;
+
+	/* for rds_tcp_conn_path_shutdown */
+	wait_queue_head_t	t_recv_done_waitq;
 };
 
 struct rds_tcp_statistics {
@@ -105,6 +108,7 @@ void rds_tcp_xmit_path_prepare(struct rds_conn_path *cp);
 void rds_tcp_xmit_path_complete(struct rds_conn_path *cp);
 int rds_tcp_xmit(struct rds_connection *conn, struct rds_message *rm,
 		 unsigned int hdr_off, unsigned int sg, unsigned int off);
+int rds_tcp_is_acked(struct rds_message *rm, uint64_t ack);
 void rds_tcp_write_space(struct sock *sk);
 
 /* tcp_stats.c */
diff --git a/net/rds/tcp_connect.c b/net/rds/tcp_connect.c
index 4947ee73bad0..b77c88ffb199 100644
--- a/net/rds/tcp_connect.c
+++ b/net/rds/tcp_connect.c
@@ -75,8 +75,16 @@ void rds_tcp_state_change(struct sock *sk)
 			rds_connect_path_complete(cp, RDS_CONN_CONNECTING);
 		}
 		break;
+	case TCP_CLOSING:
+	case TCP_TIME_WAIT:
+		if (wq_has_sleeper(&tc->t_recv_done_waitq))
+			wake_up(&tc->t_recv_done_waitq);
+		break;
 	case TCP_CLOSE_WAIT:
+	case TCP_LAST_ACK:
 	case TCP_CLOSE:
+		if (wq_has_sleeper(&tc->t_recv_done_waitq))
+			wake_up(&tc->t_recv_done_waitq);
 		rds_conn_path_drop(cp, false);
 		break;
 	default:
@@ -226,18 +234,58 @@ void rds_tcp_conn_path_shutdown(struct rds_conn_path *cp)
 {
 	struct rds_tcp_connection *tc = cp->cp_transport_data;
 	struct socket *sock = tc->t_sock;
+	struct sock *sk;
+	unsigned int rounds;
 
 	rdsdebug("shutting down conn %p tc %p sock %p\n",
 		 cp->cp_conn, tc, sock);
 
 	if (sock) {
+		sk = sock->sk;
 		if (rds_destroy_pending(cp->cp_conn))
-			sock_no_linger(sock->sk);
-		sock->ops->shutdown(sock, RCV_SHUTDOWN | SEND_SHUTDOWN);
-		lock_sock(sock->sk);
+			sock_no_linger(sk);
+
+		sock->ops->shutdown(sock, SHUT_WR);
+
+		/* after sending FIN,
+		 * wait until we processed all incoming messages
+		 * and we're sure that there won't be any more:
+		 * i.e. state CLOSING, TIME_WAIT, CLOSE_WAIT,
+		 * LAST_ACK, or CLOSE (RFC 793).
+		 *
+		 * Give up waiting after 5 seconds and allow messages
+		 * to theoretically get dropped, if the TCP transition
+		 * didn't happen.
+		 */
+		rounds = 0;
+		do {
+			/* we need to ensure messages are dequeued here
+			 * since "rds_recv_worker" only dispatches messages
+			 * while the connection is still in RDS_CONN_UP
+			 * and there is no guarantee that "rds_tcp_data_ready"
+			 * was called nor that "sk_data_ready" still points to
+			 * it.
+			 */
+			rds_tcp_recv_path(cp);
+		} while (!wait_event_timeout(tc->t_recv_done_waitq,
+				(sk->sk_state == TCP_CLOSING ||
+				 sk->sk_state == TCP_TIME_WAIT ||
+				 sk->sk_state == TCP_CLOSE_WAIT ||
+				 sk->sk_state == TCP_LAST_ACK ||
+				 sk->sk_state == TCP_CLOSE) &&
+				skb_queue_empty_lockless(&sk->sk_receive_queue),
+				msecs_to_jiffies(100)) &&
+			 ++rounds < 50);
+		lock_sock(sk);
+
+		/* discard messages that the peer received already */
+		tc->t_last_seen_una = rds_tcp_snd_una(tc);
+		rds_send_path_drop_acked(cp, rds_tcp_snd_una(tc),
+					 rds_tcp_is_acked);
+
 		rds_tcp_restore_callbacks(sock, tc); /* tc->tc_sock = NULL */
 
-		release_sock(sock->sk);
+		release_sock(sk);
 		sock_release(sock);
 	}
 
diff --git a/net/rds/tcp_listen.c b/net/rds/tcp_listen.c
index 900d059010a4..ec54fc4a6901 100644
--- a/net/rds/tcp_listen.c
+++ b/net/rds/tcp_listen.c
@@ -278,6 +278,20 @@ int rds_tcp_accept_one(struct rds_tcp_net *rtn)
 		rds_tcp_set_callbacks(new_sock, cp);
 		rds_connect_path_complete(cp, RDS_CONN_CONNECTING);
 	}
+
+	/* Since "rds_tcp_set_callbacks" happens this late
+	 * the connection may already have been closed without
+	 * "rds_tcp_state_change" doing its due diligence.
+	 *
+	 * If that's the case, we simply drop the path,
+	 * knowing that "rds_tcp_conn_path_shutdown" will
+	 * dequeue pending messages.
+	 */
+	if (new_sock->sk->sk_state == TCP_CLOSE_WAIT ||
+	    new_sock->sk->sk_state == TCP_LAST_ACK ||
+	    new_sock->sk->sk_state == TCP_CLOSE)
+		rds_conn_path_drop(cp, 0);
+
 	new_sock = NULL;
 	ret = 0;
 	if (conn->c_npaths == 0)
diff --git a/net/rds/tcp_recv.c b/net/rds/tcp_recv.c
index b7cf7f451430..49f96ee0c40f 100644
--- a/net/rds/tcp_recv.c
+++ b/net/rds/tcp_recv.c
@@ -278,6 +278,10 @@ static int rds_tcp_read_sock(struct rds_conn_path *cp, gfp_t gfp)
 	rdsdebug("tcp_read_sock for tc %p gfp 0x%x returned %d\n", tc, gfp,
 		 desc.error);
 
+	if (skb_queue_empty_lockless(&sock->sk->sk_receive_queue) &&
+	    wq_has_sleeper(&tc->t_recv_done_waitq))
+		wake_up(&tc->t_recv_done_waitq);
+
 	return desc.error;
 }
 
diff --git a/net/rds/tcp_send.c b/net/rds/tcp_send.c
index 4e82c9644aa6..7c52acc749cf 100644
--- a/net/rds/tcp_send.c
+++ b/net/rds/tcp_send.c
@@ -169,7 +169,7 @@ int rds_tcp_xmit(struct rds_connection *conn, struct rds_message *rm,
  * unacked byte of the TCP sequence space.  We have to do very careful
  * wrapping 32bit comparisons here.
  */
-static int rds_tcp_is_acked(struct rds_message *rm, uint64_t ack)
+int rds_tcp_is_acked(struct rds_message *rm, uint64_t ack)
 {
 	if (!test_bit(RDS_MSG_HAS_ACK_SEQ, &rm->m_flags))
 		return 0;
-- 
2.43.0


