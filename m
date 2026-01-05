Return-Path: <linux-rdma+bounces-15311-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C9ECF5D94
	for <lists+linux-rdma@lfdr.de>; Mon, 05 Jan 2026 23:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2041530318F7
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Jan 2026 22:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46592F290A;
	Mon,  5 Jan 2026 22:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BKJQmiiB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCBE2E22BE;
	Mon,  5 Jan 2026 22:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767652535; cv=none; b=KzDluudB9WSFQa75ZqVSmbgp7qmNTBqIk0y/GCQao5g7RSINTeV7MOrQPK3cVl1PO1D/nVeiZf6SQOf7di4pl32hHWwkWVMfJtRYClqHg5dghosFytM5GK8Juy3034i00xeIm8/EGSmRm0pkaqAC/FfbJjXxKSgIXJDYm4x39OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767652535; c=relaxed/simple;
	bh=s4Jx5HODf2NcnbbPfcfTeDgUjF3JZ2jvwst/LMiHEj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HyfEt0uX6jf0WJXb7rTHjOQE6Hy18h33EiwpJkXUFcTznqzmVDk/XPxQfgVssTx4aajkS8OTQP2n4ZzD6z1hGHPeGoEk/C2hDqlkRfgr22uRvp3gKVXIPhD8HFApStuRRpgFbHGkbNYreyUFCU3StnpsiEYw7kGj3gsBdu1K5S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BKJQmiiB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FF3DC16AAE;
	Mon,  5 Jan 2026 22:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767652535;
	bh=s4Jx5HODf2NcnbbPfcfTeDgUjF3JZ2jvwst/LMiHEj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BKJQmiiB7irHboKLEPkdZuevaRsIXrXPSuLWWAdCh6OXIRJZdugMpQdlUb+j/b8S1
	 9hkbq+R9CykFz3Ot62KiHcnqFm9ARcTfkXSZu33AlJNinkvyr6ABJuG8LoEnpr87UE
	 xq3Hz3mfdIKCnHlsoh9sLlgR+de2uJobQo0oMTljvC/a4Bt4g5VWYWJiYyP9MEep2N
	 O/9h2zJ98t+F4YMx1vnTKvIh0+66f+wqsgoR4pNQbWCx2345iju3hblgVOi6XoSxDS
	 5WlqNqZ6Z/3yFTGE99xkIqnEHaBGDdLyI1tOqBtKxIH8TkcZXUJja6UZt2IQfKztyl
	 Q5EpNNsz4OFdA==
From: Allison Henderson <achender@kernel.org>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	rds-devel@oss.oracle.com,
	kuba@kernel.org,
	horms@kernel.org,
	linux-rdma@vger.kernel.org,
	allison.henderson@oracle.com
Subject: [PATCH net-next v4 1/2] net/rds: Add per cp work queue
Date: Mon,  5 Jan 2026 15:35:31 -0700
Message-ID: <20260105223532.167452-2-achender@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260105223532.167452-1-achender@kernel.org>
References: <20260105223532.167452-1-achender@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Allison Henderson <allison.henderson@oracle.com>

This patch adds a per connection workqueue which can be initialized
and used independently of the globally shared rds_wq.

This patch is the first in a series that aims to address tcp ack
timeouts during the tcp socket shutdown sequence.

This initial refactoring lays the ground work needed to alleviate
queue congestion during heavy reads and writes.  The independently
managed queues will allow shutdowns and reconnects respond more quickly
before the peer(s) timeout waiting for the proper acks.

Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
---
 net/rds/connection.c |  5 +++--
 net/rds/ib_recv.c    |  2 +-
 net/rds/ib_send.c    |  2 +-
 net/rds/rds.h        |  1 +
 net/rds/send.c       |  9 +++++----
 net/rds/tcp_recv.c   |  2 +-
 net/rds/tcp_send.c   |  2 +-
 net/rds/threads.c    | 16 ++++++++--------
 8 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/net/rds/connection.c b/net/rds/connection.c
index 68bc88cce84ec..dc7323707f450 100644
--- a/net/rds/connection.c
+++ b/net/rds/connection.c
@@ -269,6 +269,7 @@ static struct rds_connection *__rds_conn_create(struct net *net,
 		__rds_conn_path_init(conn, &conn->c_path[i],
 				     is_outgoing);
 		conn->c_path[i].cp_index = i;
+		conn->c_path[i].cp_wq = rds_wq;
 	}
 	rcu_read_lock();
 	if (rds_destroy_pending(conn))
@@ -884,7 +885,7 @@ void rds_conn_path_drop(struct rds_conn_path *cp, bool destroy)
 		rcu_read_unlock();
 		return;
 	}
-	queue_work(rds_wq, &cp->cp_down_w);
+	queue_work(cp->cp_wq, &cp->cp_down_w);
 	rcu_read_unlock();
 }
 EXPORT_SYMBOL_GPL(rds_conn_path_drop);
@@ -909,7 +910,7 @@ void rds_conn_path_connect_if_down(struct rds_conn_path *cp)
 	}
 	if (rds_conn_path_state(cp) == RDS_CONN_DOWN &&
 	    !test_and_set_bit(RDS_RECONNECT_PENDING, &cp->cp_flags))
-		queue_delayed_work(rds_wq, &cp->cp_conn_w, 0);
+		queue_delayed_work(cp->cp_wq, &cp->cp_conn_w, 0);
 	rcu_read_unlock();
 }
 EXPORT_SYMBOL_GPL(rds_conn_path_connect_if_down);
diff --git a/net/rds/ib_recv.c b/net/rds/ib_recv.c
index 4248dfa816ebf..357128d34a546 100644
--- a/net/rds/ib_recv.c
+++ b/net/rds/ib_recv.c
@@ -457,7 +457,7 @@ void rds_ib_recv_refill(struct rds_connection *conn, int prefill, gfp_t gfp)
 	    (must_wake ||
 	    (can_wait && rds_ib_ring_low(&ic->i_recv_ring)) ||
 	    rds_ib_ring_empty(&ic->i_recv_ring))) {
-		queue_delayed_work(rds_wq, &conn->c_recv_w, 1);
+		queue_delayed_work(conn->c_path->cp_wq, &conn->c_recv_w, 1);
 	}
 	if (can_wait)
 		cond_resched();
diff --git a/net/rds/ib_send.c b/net/rds/ib_send.c
index 4190b90ff3b18..e35bbb6ffb689 100644
--- a/net/rds/ib_send.c
+++ b/net/rds/ib_send.c
@@ -419,7 +419,7 @@ void rds_ib_send_add_credits(struct rds_connection *conn, unsigned int credits)
 
 	atomic_add(IB_SET_SEND_CREDITS(credits), &ic->i_credits);
 	if (test_and_clear_bit(RDS_LL_SEND_FULL, &conn->c_flags))
-		queue_delayed_work(rds_wq, &conn->c_send_w, 0);
+		queue_delayed_work(conn->c_path->cp_wq, &conn->c_send_w, 0);
 
 	WARN_ON(IB_GET_SEND_CREDITS(credits) >= 16384);
 
diff --git a/net/rds/rds.h b/net/rds/rds.h
index a029e5fcdea72..b35afa2658cc4 100644
--- a/net/rds/rds.h
+++ b/net/rds/rds.h
@@ -118,6 +118,7 @@ struct rds_conn_path {
 
 	void			*cp_transport_data;
 
+	struct workqueue_struct	*cp_wq;
 	atomic_t		cp_state;
 	unsigned long		cp_send_gen;
 	unsigned long		cp_flags;
diff --git a/net/rds/send.c b/net/rds/send.c
index 0b3d0ef2f008b..3e3d028bc21ee 100644
--- a/net/rds/send.c
+++ b/net/rds/send.c
@@ -458,7 +458,8 @@ int rds_send_xmit(struct rds_conn_path *cp)
 			if (rds_destroy_pending(cp->cp_conn))
 				ret = -ENETUNREACH;
 			else
-				queue_delayed_work(rds_wq, &cp->cp_send_w, 1);
+				queue_delayed_work(cp->cp_wq,
+						   &cp->cp_send_w, 1);
 			rcu_read_unlock();
 		} else if (raced) {
 			rds_stats_inc(s_send_lock_queue_raced);
@@ -1380,7 +1381,7 @@ int rds_sendmsg(struct socket *sock, struct msghdr *msg, size_t payload_len)
 		if (rds_destroy_pending(cpath->cp_conn))
 			ret = -ENETUNREACH;
 		else
-			queue_delayed_work(rds_wq, &cpath->cp_send_w, 1);
+			queue_delayed_work(cpath->cp_wq, &cpath->cp_send_w, 1);
 		rcu_read_unlock();
 	}
 	if (ret)
@@ -1470,10 +1471,10 @@ rds_send_probe(struct rds_conn_path *cp, __be16 sport,
 	rds_stats_inc(s_send_queued);
 	rds_stats_inc(s_send_pong);
 
-	/* schedule the send work on rds_wq */
+	/* schedule the send work on cp_wq */
 	rcu_read_lock();
 	if (!rds_destroy_pending(cp->cp_conn))
-		queue_delayed_work(rds_wq, &cp->cp_send_w, 1);
+		queue_delayed_work(cp->cp_wq, &cp->cp_send_w, 1);
 	rcu_read_unlock();
 
 	rds_message_put(rm);
diff --git a/net/rds/tcp_recv.c b/net/rds/tcp_recv.c
index 7997a19d1da30..b7cf7f451430d 100644
--- a/net/rds/tcp_recv.c
+++ b/net/rds/tcp_recv.c
@@ -327,7 +327,7 @@ void rds_tcp_data_ready(struct sock *sk)
 	if (rds_tcp_read_sock(cp, GFP_ATOMIC) == -ENOMEM) {
 		rcu_read_lock();
 		if (!rds_destroy_pending(cp->cp_conn))
-			queue_delayed_work(rds_wq, &cp->cp_recv_w, 0);
+			queue_delayed_work(cp->cp_wq, &cp->cp_recv_w, 0);
 		rcu_read_unlock();
 	}
 out:
diff --git a/net/rds/tcp_send.c b/net/rds/tcp_send.c
index 7d284ac7e81a5..4e82c9644aa6a 100644
--- a/net/rds/tcp_send.c
+++ b/net/rds/tcp_send.c
@@ -201,7 +201,7 @@ void rds_tcp_write_space(struct sock *sk)
 	rcu_read_lock();
 	if ((refcount_read(&sk->sk_wmem_alloc) << 1) <= sk->sk_sndbuf &&
 	    !rds_destroy_pending(cp->cp_conn))
-		queue_delayed_work(rds_wq, &cp->cp_send_w, 0);
+		queue_delayed_work(cp->cp_wq, &cp->cp_send_w, 0);
 	rcu_read_unlock();
 
 out:
diff --git a/net/rds/threads.c b/net/rds/threads.c
index 1f424cbfcbb47..639302bab51ef 100644
--- a/net/rds/threads.c
+++ b/net/rds/threads.c
@@ -89,8 +89,8 @@ void rds_connect_path_complete(struct rds_conn_path *cp, int curr)
 	set_bit(0, &cp->cp_conn->c_map_queued);
 	rcu_read_lock();
 	if (!rds_destroy_pending(cp->cp_conn)) {
-		queue_delayed_work(rds_wq, &cp->cp_send_w, 0);
-		queue_delayed_work(rds_wq, &cp->cp_recv_w, 0);
+		queue_delayed_work(cp->cp_wq, &cp->cp_send_w, 0);
+		queue_delayed_work(cp->cp_wq, &cp->cp_recv_w, 0);
 	}
 	rcu_read_unlock();
 	cp->cp_conn->c_proposed_version = RDS_PROTOCOL_VERSION;
@@ -140,7 +140,7 @@ void rds_queue_reconnect(struct rds_conn_path *cp)
 		cp->cp_reconnect_jiffies = rds_sysctl_reconnect_min_jiffies;
 		rcu_read_lock();
 		if (!rds_destroy_pending(cp->cp_conn))
-			queue_delayed_work(rds_wq, &cp->cp_conn_w, 0);
+			queue_delayed_work(cp->cp_wq, &cp->cp_conn_w, 0);
 		rcu_read_unlock();
 		return;
 	}
@@ -151,7 +151,7 @@ void rds_queue_reconnect(struct rds_conn_path *cp)
 		 conn, &conn->c_laddr, &conn->c_faddr);
 	rcu_read_lock();
 	if (!rds_destroy_pending(cp->cp_conn))
-		queue_delayed_work(rds_wq, &cp->cp_conn_w,
+		queue_delayed_work(cp->cp_wq, &cp->cp_conn_w,
 				   rand % cp->cp_reconnect_jiffies);
 	rcu_read_unlock();
 
@@ -203,11 +203,11 @@ void rds_send_worker(struct work_struct *work)
 		switch (ret) {
 		case -EAGAIN:
 			rds_stats_inc(s_send_immediate_retry);
-			queue_delayed_work(rds_wq, &cp->cp_send_w, 0);
+			queue_delayed_work(cp->cp_wq, &cp->cp_send_w, 0);
 			break;
 		case -ENOMEM:
 			rds_stats_inc(s_send_delayed_retry);
-			queue_delayed_work(rds_wq, &cp->cp_send_w, 2);
+			queue_delayed_work(cp->cp_wq, &cp->cp_send_w, 2);
 			break;
 		default:
 			break;
@@ -228,11 +228,11 @@ void rds_recv_worker(struct work_struct *work)
 		switch (ret) {
 		case -EAGAIN:
 			rds_stats_inc(s_recv_immediate_retry);
-			queue_delayed_work(rds_wq, &cp->cp_recv_w, 0);
+			queue_delayed_work(cp->cp_wq, &cp->cp_recv_w, 0);
 			break;
 		case -ENOMEM:
 			rds_stats_inc(s_recv_delayed_retry);
-			queue_delayed_work(rds_wq, &cp->cp_recv_w, 2);
+			queue_delayed_work(cp->cp_wq, &cp->cp_recv_w, 2);
 			break;
 		default:
 			break;
-- 
2.43.0


