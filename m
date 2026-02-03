Return-Path: <linux-rdma+bounces-16404-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLLOKY6OgWl/HAMAu9opvQ
	(envelope-from <linux-rdma+bounces-16404-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 06:58:38 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 236B6D4E6E
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 06:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DBB043057E56
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 05:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D0B36AB6F;
	Tue,  3 Feb 2026 05:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Re1xrT4w"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EE6369961;
	Tue,  3 Feb 2026 05:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770098253; cv=none; b=l2ep+XY5dNkNWeLCY31k/eZDZFTf1g1RM4GMCILK0bZRJu+FsPuzAPhOtdTxyyIQI8+86Xno8hdhrtVuBxOkS2qpgk7EsFLbFUXJIdQ6WO7Qp3BAhjmkQckLRi8DUBNP/+X9BSCRwmhWrPyHvMuC0N3fXL/1hSgR32HMNc/XJMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770098253; c=relaxed/simple;
	bh=MAt3G96qHX/7/df4jX2radtzLNDLsYJ5G2SeCXXCLow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m3Zg45mWgluDQIVT/avB+qum5+Hh9oomg1sr/SdocIfdvxEsI4cJUu0PudDsOAqNbBOJrKHDoqKirLnyXp7gjsZ9kBgWkpaaIkJM+Zs3of9347RXKn+gSqepJMWqnKS4FotAGMhRKYKVYRotiUOGkcjDJU85/lOS0hLCRRxvhr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Re1xrT4w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6062EC19425;
	Tue,  3 Feb 2026 05:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770098253;
	bh=MAt3G96qHX/7/df4jX2radtzLNDLsYJ5G2SeCXXCLow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Re1xrT4wNxpohB8p93BSnUvbFcMqraRAUQNcy37ifSf3QXU64jOoe9dfSq4thtWfq
	 tXj6mGNFZrATqoidOY4kOGmzS3rTCScj9WUI/lb4ZfxVjc2oIAqzipZxQvfqOAUfkN
	 yRoVocUNID0rM+wdaExk1gIibRJja99safn52ElyVIBSaYfko2n0dCtW9frQNwVLTr
	 g6k+b2rU77KLoT8XPKhffbb9pyAWfox/YZmPUInseY9mGEI4pmLymZ2C1VzPkM7TNg
	 FJL77Uvou10nAfSI+6pOw0N2XKs3hlxqTqTvblmfXUfaJe4ayXH6kJBan+Wm3g7ZvW
	 4Ju89F2465t0Q==
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
Subject: [PATCH net-next v5 7/8] net/rds: Use the first lane until RDS_EXTHDR_NPATHS arrives
Date: Mon,  2 Feb 2026 22:57:22 -0700
Message-ID: <20260203055723.1085751-8-achender@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260203055723.1085751-1-achender@kernel.org>
References: <20260203055723.1085751-1-achender@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-16404-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 236B6D4E6E
X-Rspamd-Action: no action

From: Gerd Rausch <gerd.rausch@oracle.com>

Instead of just blocking the sender until "c_npaths" is known
(it gets updated upon the receipt of a MPRDS PONG message),
simply use the first lane (cp_index#0).

But just using the first lane isn't enough.

As soon as we enqueue messages on a different lane, we'd run the risk
of out-of-order delivery of RDS messages.

Earlier messages enqueued on "cp_index == 0" could be delivered later
than more recent messages enqueued on "cp_index > 0", mostly because of
possible head of line blocking issues causing the first lane to be
slower.

To avoid that, we simply take a snapshot of "cp_next_tx_seq" at the
time we're about to fan-out to more lanes.

Then we delay the transmission of messages enqueued on other lanes
with "cp_index > 0" until cp_index#0 caught up with the delivery of
new messages (from "cp_send_queue") as well as in-flight
messages (from "cp_retrans") that haven't been acknowledged yet
by the receiver.

We also add a new counter "mprds_catchup_tx0_retries" to keep track
of how many times "rds_send_xmit" had to suspend activities,
because it was waiting for the first lane to catch up.

Signed-off-by: Gerd Rausch <gerd.rausch@oracle.com>
Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
---
 net/rds/rds.h   |   3 ++
 net/rds/recv.c  |  23 +++++++++--
 net/rds/send.c  | 102 +++++++++++++++++++++++++++++++-----------------
 net/rds/stats.c |   1 +
 4 files changed, 90 insertions(+), 39 deletions(-)

diff --git a/net/rds/rds.h b/net/rds/rds.h
index 333065a051ea..6d9f4a08b0ee 100644
--- a/net/rds/rds.h
+++ b/net/rds/rds.h
@@ -170,6 +170,8 @@ struct rds_connection {
 
 	u32			c_my_gen_num;
 	u32			c_peer_gen_num;
+
+	u64			c_cp0_mprds_catchup_tx_seq;
 };
 
 static inline
@@ -749,6 +751,7 @@ struct rds_statistics {
 	u64	s_recv_bytes_added_to_socket;
 	u64	s_recv_bytes_removed_from_socket;
 	u64	s_send_stuck_rm;
+	u64	s_mprds_catchup_tx0_retries;
 };
 
 /* af_rds.c */
diff --git a/net/rds/recv.c b/net/rds/recv.c
index ddf128a02347..889a5b7935e5 100644
--- a/net/rds/recv.c
+++ b/net/rds/recv.c
@@ -208,6 +208,9 @@ static void rds_recv_hs_exthdrs(struct rds_header *hdr,
 	} buffer;
 	bool new_with_sport_idx = false;
 	u32 new_peer_gen_num = 0;
+	int new_npaths;
+
+	new_npaths = conn->c_npaths;
 
 	while (1) {
 		len = sizeof(buffer);
@@ -217,8 +220,8 @@ static void rds_recv_hs_exthdrs(struct rds_header *hdr,
 		/* Process extension header here */
 		switch (type) {
 		case RDS_EXTHDR_NPATHS:
-			conn->c_npaths = min_t(int, RDS_MPATH_WORKERS,
-					       be16_to_cpu(buffer.rds_npaths));
+			new_npaths = min_t(int, RDS_MPATH_WORKERS,
+					   be16_to_cpu(buffer.rds_npaths));
 			break;
 		case RDS_EXTHDR_GEN_NUM:
 			new_peer_gen_num = be32_to_cpu(buffer.rds_gen_num);
@@ -233,8 +236,22 @@ static void rds_recv_hs_exthdrs(struct rds_header *hdr,
 	}
 
 	conn->c_with_sport_idx = new_with_sport_idx;
+
+	if (new_npaths > 1 && new_npaths != conn->c_npaths) {
+		/* We're about to fan-out.
+		 * Make sure that messages from cp_index#0
+		 * are sent prior to handling other lanes.
+		 */
+		struct rds_conn_path *cp0 = conn->c_path;
+		unsigned long flags;
+
+		spin_lock_irqsave(&cp0->cp_lock, flags);
+		conn->c_cp0_mprds_catchup_tx_seq = cp0->cp_next_tx_seq;
+		spin_unlock_irqrestore(&cp0->cp_lock, flags);
+	}
 	/* if RDS_EXTHDR_NPATHS was not found, default to a single-path */
-	conn->c_npaths = max_t(int, conn->c_npaths, 1);
+	conn->c_npaths = max_t(int, new_npaths, 1);
+
 	conn->c_ping_triggered = 0;
 	rds_conn_peer_gen_update(conn, new_peer_gen_num);
 
diff --git a/net/rds/send.c b/net/rds/send.c
index 85e1c5352ad8..599c2cfb7a1d 100644
--- a/net/rds/send.c
+++ b/net/rds/send.c
@@ -119,6 +119,57 @@ static void release_in_xmit(struct rds_conn_path *cp)
 		wake_up_all(&cp->cp_waitq);
 }
 
+/*
+ * Helper function for multipath fanout to ensure lane 0 transmits queued
+ * messages before other lanes to prevent out-of-order delivery.
+ *
+ * Returns true if lane 0 still has messages or false otherwise
+ */
+static bool rds_mprds_cp0_catchup(struct rds_connection *conn)
+{
+	struct rds_conn_path *cp0 = conn->c_path;
+	struct rds_message *rm0;
+	unsigned long flags;
+	bool ret = false;
+
+	spin_lock_irqsave(&cp0->cp_lock, flags);
+
+	/* the oldest / first message in the retransmit queue
+	 * has to be at or beyond c_cp0_mprds_catchup_tx_seq
+	 */
+	if (!list_empty(&cp0->cp_retrans)) {
+		rm0 = list_entry(cp0->cp_retrans.next, struct rds_message,
+				 m_conn_item);
+		if (be64_to_cpu(rm0->m_inc.i_hdr.h_sequence) <
+		    conn->c_cp0_mprds_catchup_tx_seq) {
+			/* the retransmit queue of cp_index#0 has not
+			 * quite caught up yet
+			 */
+			ret = true;
+			goto unlock;
+		}
+	}
+
+	/* the oldest / first message of the send queue
+	 * has to be at or beyond c_cp0_mprds_catchup_tx_seq
+	 */
+	rm0 = cp0->cp_xmit_rm;
+	if (!rm0 && !list_empty(&cp0->cp_send_queue))
+		rm0 = list_entry(cp0->cp_send_queue.next, struct rds_message,
+				 m_conn_item);
+	if (rm0 && be64_to_cpu(rm0->m_inc.i_hdr.h_sequence) <
+	    conn->c_cp0_mprds_catchup_tx_seq) {
+		/* the send queue of cp_index#0 has not quite
+		 * caught up yet
+		 */
+		ret = true;
+	}
+
+unlock:
+	spin_unlock_irqrestore(&cp0->cp_lock, flags);
+	return ret;
+}
+
 /*
  * We're making the conscious trade-off here to only send one message
  * down the connection at a time.
@@ -248,6 +299,14 @@ int rds_send_xmit(struct rds_conn_path *cp)
 			if (batch_count >= send_batch_count)
 				goto over_batch;
 
+			/* make sure cp_index#0 caught up during fan-out in
+			 * order to avoid lane races
+			 */
+			if (cp->cp_index > 0 && rds_mprds_cp0_catchup(conn)) {
+				rds_stats_inc(s_mprds_catchup_tx0_retries);
+				goto over_batch;
+			}
+
 			spin_lock_irqsave(&cp->cp_lock, flags);
 
 			if (!list_empty(&cp->cp_send_queue)) {
@@ -1042,39 +1101,6 @@ static int rds_cmsg_send(struct rds_sock *rs, struct rds_message *rm,
 	return ret;
 }
 
-static int rds_send_mprds_hash(struct rds_sock *rs,
-			       struct rds_connection *conn, int nonblock)
-{
-	int hash;
-
-	if (conn->c_npaths == 0)
-		hash = RDS_MPATH_HASH(rs, RDS_MPATH_WORKERS);
-	else
-		hash = RDS_MPATH_HASH(rs, conn->c_npaths);
-	if (conn->c_npaths == 0 && hash != 0) {
-		rds_send_ping(conn, 0);
-
-		/* The underlying connection is not up yet.  Need to wait
-		 * until it is up to be sure that the non-zero c_path can be
-		 * used.  But if we are interrupted, we have to use the zero
-		 * c_path in case the connection ends up being non-MP capable.
-		 */
-		if (conn->c_npaths == 0) {
-			/* Cannot wait for the connection be made, so just use
-			 * the base c_path.
-			 */
-			if (nonblock)
-				return 0;
-			if (wait_event_interruptible(conn->c_hs_waitq,
-						     conn->c_npaths != 0))
-				hash = 0;
-		}
-		if (conn->c_npaths == 1)
-			hash = 0;
-	}
-	return hash;
-}
-
 static int rds_rdma_bytes(struct msghdr *msg, size_t *rdma_bytes)
 {
 	struct rds_rdma_args *args;
@@ -1304,10 +1330,14 @@ int rds_sendmsg(struct socket *sock, struct msghdr *msg, size_t payload_len)
 		rs->rs_conn = conn;
 	}
 
-	if (conn->c_trans->t_mp_capable)
-		cpath = &conn->c_path[rds_send_mprds_hash(rs, conn, nonblock)];
-	else
+	if (conn->c_trans->t_mp_capable) {
+		/* Use c_path[0] until we learn that
+		 * the peer supports more (c_npaths > 1)
+		 */
+		cpath = &conn->c_path[RDS_MPATH_HASH(rs, conn->c_npaths ? : 1)];
+	} else {
 		cpath = &conn->c_path[0];
+	}
 
 	rm->m_conn_path = cpath;
 
diff --git a/net/rds/stats.c b/net/rds/stats.c
index cb2e3d2cdf73..24ee22d09e8c 100644
--- a/net/rds/stats.c
+++ b/net/rds/stats.c
@@ -79,6 +79,7 @@ static const char *const rds_stat_names[] = {
 	"recv_bytes_added_to_sock",
 	"recv_bytes_freed_fromsock",
 	"send_stuck_rm",
+	"mprds_catchup_tx0_retries",
 };
 
 void rds_stats_info_copy(struct rds_info_iterator *iter,
-- 
2.43.0


