Return-Path: <linux-rdma+bounces-16277-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJ4EIiZafWmBRgIAu9opvQ
	(envelope-from <linux-rdma+bounces-16277-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 31 Jan 2026 02:25:58 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 29122BFFC8
	for <lists+linux-rdma@lfdr.de>; Sat, 31 Jan 2026 02:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7111E3041BE7
	for <lists+linux-rdma@lfdr.de>; Sat, 31 Jan 2026 01:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C494132C933;
	Sat, 31 Jan 2026 01:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDDzMXks"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D2432ABF7;
	Sat, 31 Jan 2026 01:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769822711; cv=none; b=kDvUD4BuCe6d3nRC1uiaE6hjRQ+hLt3FtqUCoIuiIBHF730cIt9vZs+73Jfb0UCkJxkoxDHattxJPZ43qDGOyCweQBAhINZXCN6sCsf4PI78xWj9PknBPB78dycZO+ISRyE8du7FHTlxLW2DcRQAwxLnlJ/GntJf2ews22MnZPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769822711; c=relaxed/simple;
	bh=1wuptZomyDfVsTQG5kJvE7ATtBfaNCFCyJaz8zcD8AA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z2iDdrMMsIUNS+ozL6gLVDnjnKSWgjgS2/vLMgFGwOpptAQ76QHYfXE/TaGZgO0cM3HlCrZcvvk+s3EoUs6OPtQJIOkvaVw7JXaXK8cKrc3ZcjRf7WE5TvfEHWnjNMmyxXSe5aArWXQljEDeq4PCBW3O2tfGZ3UygjyXSSnRcUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YDDzMXks; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6013CC116C6;
	Sat, 31 Jan 2026 01:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769822711;
	bh=1wuptZomyDfVsTQG5kJvE7ATtBfaNCFCyJaz8zcD8AA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YDDzMXksGwOcAg5SMvan3TwYqLFHKgKDEOR2s2tdD3ikagbSlxiWQhdhbLwM+QV8y
	 p4ATSh7eurjt79tXFh5QW9dCOxnYV89v8Gv3z6jeAo4VseDTnX63ZvzNUXI2fvYdOR
	 7xbeORjLUIhC3e8fX4Vz6gp8o+cwlej5dd3dbK/Yp0vaVrUFWNgnpRKZZF0OmWzJ6w
	 62wsxQ7tU+u91N7ro0eEmeYCyfvRCseKVjIReP1EJlMX+Yzhk4kgAp1Vt00Uu4Y52v
	 k+bulYflE7iMYdV+9V6rxIgbwUDw11wd3WCz+P3eXQyNZ1MewT0PTK+dQwnUOz+Uxj
	 e5Lpdy+vrVYkQ==
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
Subject: [PATCH net-next v4 2/8] net/rds: Encode cp_index in TCP source port
Date: Fri, 30 Jan 2026 18:25:01 -0700
Message-ID: <20260131012507.814119-3-achender@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-16277-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 29122BFFC8
X-Rspamd-Action: no action

From: Gerd Rausch <gerd.rausch@oracle.com>

Upon "sendmsg", RDS/TCP selects a backend connection based
on a hash calculated from the source-port ("RDS_MPATH_HASH").

However, "rds_tcp_accept_one" accepts connections
in the order they arrive, which is non-deterministic.

Therefore the mapping of the sender's "cp->cp_index"
to that of the receiver changes if the backend
connections are dropped and reconnected.

However, connection state that's preserved across reconnects
(e.g. "cp_next_rx_seq") relies on that sender<->receiver
mapping to never change.

So we make sure that client and server of the TCP connection
have the exact same "cp->cp_index" across reconnects by
encoding "cp->cp_index" in the lower three bits of the
client's TCP source port.

A new extension "RDS_EXTHDR_SPORT_IDX" is introduced,
that allows the server to tell the difference between
clients that do the "cp->cp_index" encoding, and
legacy clients that pick source ports randomly.

Signed-off-by: Gerd Rausch <gerd.rausch@oracle.com>
Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
---
 net/rds/message.c     |  1 +
 net/rds/rds.h         |  3 +++
 net/rds/recv.c        |  7 +++++++
 net/rds/send.c        |  4 ++++
 net/rds/tcp.h         |  1 +
 net/rds/tcp_connect.c | 23 +++++++++++++++++++++-
 net/rds/tcp_listen.c  | 45 +++++++++++++++++++++++++++++++++++++------
 7 files changed, 77 insertions(+), 7 deletions(-)

diff --git a/net/rds/message.c b/net/rds/message.c
index 591a27c9c62f..54fd000806ea 100644
--- a/net/rds/message.c
+++ b/net/rds/message.c
@@ -47,6 +47,7 @@ static unsigned int	rds_exthdr_size[__RDS_EXTHDR_MAX] = {
 [RDS_EXTHDR_RDMA_BYTES] = sizeof(struct rds_ext_header_rdma_bytes),
 [RDS_EXTHDR_NPATHS]	= sizeof(__be16),
 [RDS_EXTHDR_GEN_NUM]	= sizeof(__be32),
+[RDS_EXTHDR_SPORT_IDX]	= 1,
 };
 
 void rds_message_addref(struct rds_message *rm)
diff --git a/net/rds/rds.h b/net/rds/rds.h
index 4b6bf523b412..5b5fb53b1fc5 100644
--- a/net/rds/rds.h
+++ b/net/rds/rds.h
@@ -147,6 +147,7 @@ struct rds_connection {
 				c_ping_triggered:1,
 				c_pad_to_32:29;
 	int			c_npaths;
+	bool			c_with_sport_idx;
 	struct rds_connection	*c_passive;
 	struct rds_transport	*c_trans;
 
@@ -278,8 +279,10 @@ struct rds_ext_header_rdma_bytes {
  */
 #define RDS_EXTHDR_NPATHS	5
 #define RDS_EXTHDR_GEN_NUM	6
+#define RDS_EXTHDR_SPORT_IDX    8
 
 #define __RDS_EXTHDR_MAX	16 /* for now */
+
 #define RDS_RX_MAX_TRACES	(RDS_MSG_RX_DGRAM_TRACE_MAX + 1)
 #define	RDS_MSG_RX_HDR		0
 #define	RDS_MSG_RX_START	1
diff --git a/net/rds/recv.c b/net/rds/recv.c
index 66680f652e74..ddf128a02347 100644
--- a/net/rds/recv.c
+++ b/net/rds/recv.c
@@ -204,7 +204,9 @@ static void rds_recv_hs_exthdrs(struct rds_header *hdr,
 		struct rds_ext_header_version version;
 		__be16 rds_npaths;
 		__be32 rds_gen_num;
+		u8 dummy;
 	} buffer;
+	bool new_with_sport_idx = false;
 	u32 new_peer_gen_num = 0;
 
 	while (1) {
@@ -221,11 +223,16 @@ static void rds_recv_hs_exthdrs(struct rds_header *hdr,
 		case RDS_EXTHDR_GEN_NUM:
 			new_peer_gen_num = be32_to_cpu(buffer.rds_gen_num);
 			break;
+		case RDS_EXTHDR_SPORT_IDX:
+			new_with_sport_idx = true;
+			break;
 		default:
 			pr_warn_ratelimited("ignoring unknown exthdr type "
 					     "0x%x\n", type);
 		}
 	}
+
+	conn->c_with_sport_idx = new_with_sport_idx;
 	/* if RDS_EXTHDR_NPATHS was not found, default to a single-path */
 	conn->c_npaths = max_t(int, conn->c_npaths, 1);
 	conn->c_ping_triggered = 0;
diff --git a/net/rds/send.c b/net/rds/send.c
index 306785fa7065..85e1c5352ad8 100644
--- a/net/rds/send.c
+++ b/net/rds/send.c
@@ -1457,12 +1457,16 @@ rds_send_probe(struct rds_conn_path *cp, __be16 sport,
 	    cp->cp_conn->c_trans->t_mp_capable) {
 		__be16 npaths = cpu_to_be16(RDS_MPATH_WORKERS);
 		__be32 my_gen_num = cpu_to_be32(cp->cp_conn->c_my_gen_num);
+		u8 dummy = 0;
 
 		rds_message_add_extension(&rm->m_inc.i_hdr,
 					  RDS_EXTHDR_NPATHS, &npaths);
 		rds_message_add_extension(&rm->m_inc.i_hdr,
 					  RDS_EXTHDR_GEN_NUM,
 					  &my_gen_num);
+		rds_message_add_extension(&rm->m_inc.i_hdr,
+					  RDS_EXTHDR_SPORT_IDX,
+					  &dummy);
 	}
 	spin_unlock_irqrestore(&cp->cp_lock, flags);
 
diff --git a/net/rds/tcp.h b/net/rds/tcp.h
index 7d07128593b7..7c91974fcde7 100644
--- a/net/rds/tcp.h
+++ b/net/rds/tcp.h
@@ -34,6 +34,7 @@ struct rds_tcp_connection {
 	 */
 	struct mutex		t_conn_path_lock;
 	struct socket		*t_sock;
+	u32			t_client_port_group;
 	struct rds_tcp_net	*t_rtn;
 	void			*t_orig_write_space;
 	void			*t_orig_data_ready;
diff --git a/net/rds/tcp_connect.c b/net/rds/tcp_connect.c
index 92891b0d224d..4947ee73bad0 100644
--- a/net/rds/tcp_connect.c
+++ b/net/rds/tcp_connect.c
@@ -93,6 +93,8 @@ int rds_tcp_conn_path_connect(struct rds_conn_path *cp)
 	struct sockaddr_in6 sin6;
 	struct sockaddr_in sin;
 	struct sockaddr *addr;
+	int port_low, port_high, port;
+	int port_groups, groups_left;
 	int addrlen;
 	bool isv6;
 	int ret;
@@ -145,7 +147,26 @@ int rds_tcp_conn_path_connect(struct rds_conn_path *cp)
 		addrlen = sizeof(sin);
 	}
 
-	ret = kernel_bind(sock, (struct sockaddr_unsized *)addr, addrlen);
+	/* encode cp->cp_index in lowest bits of source-port */
+	inet_get_local_port_range(rds_conn_net(conn), &port_low, &port_high);
+	port_low = ALIGN(port_low, RDS_MPATH_WORKERS);
+	port_groups = (port_high - port_low + 1) / RDS_MPATH_WORKERS;
+	ret = -EADDRINUSE;
+	groups_left = port_groups;
+	while (groups_left-- > 0 && ret) {
+		if (++tc->t_client_port_group >= port_groups)
+			tc->t_client_port_group = 0;
+		port =  port_low +
+			tc->t_client_port_group * RDS_MPATH_WORKERS +
+			cp->cp_index;
+
+		if (isv6)
+			sin6.sin6_port = htons(port);
+		else
+			sin.sin_port = htons(port);
+		ret = kernel_bind(sock, (struct sockaddr_unsized *)addr,
+				  addrlen);
+	}
 	if (ret) {
 		rdsdebug("bind failed with %d at address %pI6c\n",
 			 ret, &conn->c_laddr);
diff --git a/net/rds/tcp_listen.c b/net/rds/tcp_listen.c
index 551c847f2890..8129ea9da31c 100644
--- a/net/rds/tcp_listen.c
+++ b/net/rds/tcp_listen.c
@@ -62,19 +62,52 @@ void rds_tcp_keepalive(struct socket *sock)
  * we special case cp_index 0 is to allow the rds probe ping itself to itself
  * get through efficiently.
  */
-static
-struct rds_tcp_connection *rds_tcp_accept_one_path(struct rds_connection *conn)
+static struct rds_tcp_connection *
+rds_tcp_accept_one_path(struct rds_connection *conn, struct socket *sock)
 {
-	int i;
-	int npaths = max_t(int, 1, conn->c_npaths);
+	union {
+		struct sockaddr_storage storage;
+		struct sockaddr addr;
+		struct sockaddr_in sin;
+		struct sockaddr_in6 sin6;
+	} saddr;
+	int sport, npaths, i_min, i_max, i;
+
+	if (conn->c_with_sport_idx &&
+	    kernel_getpeername(sock, &saddr.addr) >= 0) {
+		/* cp->cp_index is encoded in lowest bits of source-port */
+		switch (saddr.addr.sa_family) {
+		case AF_INET:
+			sport = ntohs(saddr.sin.sin_port);
+			break;
+		case AF_INET6:
+			sport = ntohs(saddr.sin6.sin6_port);
+			break;
+		default:
+			sport = -1;
+		}
+	} else {
+		sport = -1;
+	}
+
+	npaths = max_t(int, 1, conn->c_npaths);
 
-	for (i = 0; i < npaths; i++) {
+	if (sport >= 0) {
+		i_min = sport % npaths;
+		i_max = i_min;
+	} else {
+		i_min = 0;
+		i_max = npaths - 1;
+	}
+
+	for (i = i_min; i <= i_max; i++) {
 		struct rds_conn_path *cp = &conn->c_path[i];
 
 		if (rds_conn_path_transition(cp, RDS_CONN_DOWN,
 					     RDS_CONN_CONNECTING))
 			return cp->cp_transport_data;
 	}
+
 	return NULL;
 }
 
@@ -199,7 +232,7 @@ int rds_tcp_accept_one(struct rds_tcp_net *rtn)
 		 * to and discarded by the sender.
 		 * We must not throw those away!
 		 */
-		rs_tcp = rds_tcp_accept_one_path(conn);
+		rs_tcp = rds_tcp_accept_one_path(conn, new_sock);
 		if (!rs_tcp) {
 			/* It's okay to stash "new_sock", since
 			 * "rds_tcp_conn_slots_available" triggers
-- 
2.43.0


