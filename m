Return-Path: <linux-rdma+bounces-19097-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHY5D5sa1Wli0wcAu9opvQ
	(envelope-from <linux-rdma+bounces-19097-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Apr 2026 16:54:19 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F753B06B8
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Apr 2026 16:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B848930B2F21
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Apr 2026 14:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C2031E833;
	Tue,  7 Apr 2026 14:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="Xx3RXmsa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C211E31D75E;
	Tue,  7 Apr 2026 14:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775573275; cv=none; b=PSprweTeR7ZGrcuqxg1/jK3YqSKI+UoeZrGl/fBe4hcQv77Moggo5oEcy0AroedjLbP2jOvsaENYV+sjVu1cKeJH4hnVfS3nO+LIU9zzXbLLlwE/G/BH00FSORDnnc207zOjYH3VeZzk6HDTX2VRkEIVQhgH5p4QtQy0Vjg/r18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775573275; c=relaxed/simple;
	bh=R2fi9jfNGCmEa2UTj605KIX/CDVli+KSD2VOhFhUuTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=quQ/P7u30vuIYx2SGynmzvhEDySPyenNqZ18ROK5Ec6xUK4ZGBLzFg8qPhM2jE1yRe7yRqis02R1C57sKvA9qamqW/dbHSwQDFCDX83s8xlwz/qKbVzhpSBqMF76nQVZ7yvSCBoUHIBzGFtnNhxI3HgrPvXpUtNOUYhcuFUuAPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=Xx3RXmsa; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Message-ID:Date:Cc:To:From;
	bh=4qor25fDclrX4Tl2iTvjhE+2WdvSIagxoKLaDTejWrY=; b=Xx3RXmsaYFifQqQsF6rXmATthr
	mnpGPXyvBxQAstinyZJzYrgroWI11pW/bFFwyc0SRAqoXQVr5dIeULjITyYYkS6Uhj2hX1p03P1Wt
	g9huFfo5PPryvujlvRt8BmR3T9vn2T8VlTNhwifyIcg1dCLcQx3QDYRFaCampTfaEBtigChA1IC3X
	e2W3UDQB7HTCmjDD4mqYv8xIibupEtkauUR+ksdL42G6OflaE7z56Bg45esmyPFTr+iPnL+7DzfAc
	+xBrPcKG2kpt15rTBGyqEaRNCg0uZUzCYqcCPrlJgC9IZZWTKZaW9KTOOAK5/gk9QB27pkT+pS+m4
	oZk4k/bwMziRqKiJrntrgapPiKAumGnfPzEwU2jT1gYSGkeCKZHjXw5f6kUykUkRMDuDAdBnP0ldV
	YQ/wIwQm69lFp7QNnM/3LK9k7zg8MoCs2TzyfN1wqKSt1p5WGdNw9e/DNjY0zEmAv48Er26OL5KSc
	J8hZNlTkNV0t/FbVRxqBNmjg;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1wA7iT-00000007WSV-48OV;
	Tue, 07 Apr 2026 14:47:46 +0000
From: Stefan Metzmacher <metze@samba.org>
To: linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org
Cc: metze@samba.org,
	Steve French <smfrench@gmail.com>,
	Tom Talpey <tom@talpey.com>,
	Long Li <longli@microsoft.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Henrique Carvalho <henrique.carvalho@suse.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	netdev@vger.kernel.org,
	Xin Long <lucien.xin@gmail.com>,
	quic@lists.linux.dev,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] smb: client: make use of IPPROTO_SMBDIRECT sockets
Date: Tue,  7 Apr 2026 16:46:33 +0200
Message-ID: <3d447904e3a370f61d4d4fe8aaee8bfdbb299c9c.1775571957.git.metze@samba.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1775571957.git.metze@samba.org>
References: <cover.1775571957.git.metze@samba.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[samba.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[samba.org:s=42];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[samba.org,gmail.com,talpey.com,microsoft.com,kernel.org,redhat.com,suse.com,davemloft.net,google.com,vger.kernel.org,lists.linux.dev];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-19097-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[metze@samba.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[samba.org:+];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B3F753B06B8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This reduces the function calls for special smbdirect features to
- smbdirect_socket_from_sock()
- smbdirect_socket_set_logging()
- smbdirect_socket_set_initial_parameters()
- smbdirect_socket_set_kernel_settings()
- smbdirect_socket_get_current_parameters()
- smbdirect_connection_is_connected()
- smbdirect_connection_send_single_iter()
- smbdirect_connection_send_wait_zero_pending()
- smbdirect_connection_register_mr_io()
- smbdirect_mr_io_fill_buffer_descriptor()
- smbdirect_connection_deregister_mr_io()
- smbdirect_connection_legacy_debug_proc_show()

In future with modifications from David Howells
we'll also be able to use sock_sendmsg() and avoid
direct calls to smbdirect_connection_send_single_iter() and
smbdirect_connection_send_wait_zero_pending().

This will also make it easier to implement the QUIC
transport Henrique Carvalho is working on.

In the end the core smb handling should just make
use of a SOCK_STREAM socket, after the initial setup.

There's still a way to go, but almost all changes
will be done within the smbdirect code, e.g.
adding MSG_SPLICE_PAGES support or
splice_read/read_sock/read_skb.

But it's a good start, which will make changes
much easier.

Cc: Steve French <smfrench@gmail.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: Long Li <longli@microsoft.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>
Cc: David Howells <dhowells@redhat.com>
Cc: Henrique Carvalho <henrique.carvalho@suse.com>
Cc: linux-cifs@vger.kernel.org
Cc: samba-technical@lists.samba.org
Cc: David S. Miller <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Willem de Bruijn <willemb@google.com>
Cc: netdev@vger.kernel.org
Cc: Xin Long <lucien.xin@gmail.com>
Cc: quic@lists.linux.dev
Cc: linux-rdma@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Stefan Metzmacher <metze@samba.org>
---
 fs/smb/client/cifs_debug.c |   2 +-
 fs/smb/client/cifsfs.c     |   2 +-
 fs/smb/client/cifsglob.h   |   7 +-
 fs/smb/client/connect.c    | 123 +++++++++--------
 fs/smb/client/file.c       |   8 +-
 fs/smb/client/sess.c       |   4 +-
 fs/smb/client/smb2ops.c    |   8 +-
 fs/smb/client/smb2pdu.c    |  10 +-
 fs/smb/client/smbdirect.c  | 275 +++++++++++--------------------------
 fs/smb/client/smbdirect.h  |  27 +---
 fs/smb/client/transport.c  |   2 +-
 11 files changed, 170 insertions(+), 298 deletions(-)

diff --git a/fs/smb/client/cifs_debug.c b/fs/smb/client/cifs_debug.c
index 0691d2a3e04b..70f30b1f8cda 100644
--- a/fs/smb/client/cifs_debug.c
+++ b/fs/smb/client/cifs_debug.c
@@ -481,7 +481,7 @@ static int cifs_debug_data_proc_show(struct seq_file *m, void *v)
 
 		seq_printf(m, "\nServer capabilities: 0x%x", server->capabilities);
 
-		if (server->rdma)
+		if (cifs_rdma_enabled(server))
 			seq_printf(m, "\nRDMA ");
 		seq_printf(m, "\nTCP status: %d Instance: %d"
 				"\nLocal Users To Server: %d SecMode: 0x%x Req On Wire: %d",
diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index 32d0305a1239..12986050e16c 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -529,7 +529,7 @@ cifs_show_address(struct seq_file *s, struct TCP_Server_Info *server)
 	default:
 		seq_puts(s, "(unknown)");
 	}
-	if (server->rdma)
+	if (cifs_rdma_enabled(server))
 		seq_puts(s, ",rdma");
 }
 
diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 709e96e07791..f7b62bcaadd9 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -35,6 +35,7 @@
 #define SMB_PATH_MAX 260
 #define CIFS_PORT 445
 #define RFC1001_PORT 139
+#define SMBD_IWARP_PORT 5445
 
 /*
  * The sizes of various internal tables and strings
@@ -759,10 +760,8 @@ struct TCP_Server_Info {
 	bool	sec_mskerberos;		/* supports legacy MS Kerberos */
 	bool	sec_iakerb;		/* supports pass-through auth for Kerberos (krb5 proxy) */
 	bool	large_buf;		/* is current buffer large? */
-	/* use SMBD connection instead of socket */
-	bool	rdma;
-	/* point to the SMBD connection if RDMA is used instead of socket */
-	struct smbd_connection *smbd_conn;
+	int	ipproto; /* IPPROTO_TCP or IPOROTO_SMBDIRECT */
+#define cifs_rdma_enabled(__server)	((__server)->ipproto == IPPROTO_SMBDIRECT)
 	struct delayed_work	echo; /* echo ping workqueue job */
 	char	*smallbuf;	/* pointer to current "small" buffer */
 	char	*bigbuf;	/* pointer to current "big" buffer */
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 69b38f0ccf2b..d42abe1d3772 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -313,8 +313,6 @@ cifs_abort_connection(struct TCP_Server_Info *server)
 			 server->ssocket->flags);
 		sock_release(server->ssocket);
 		server->ssocket = NULL;
-	} else if (cifs_rdma_enabled(server)) {
-		smbd_destroy(server);
 	}
 	server->sequence_number = 0;
 	server->session_estab = false;
@@ -408,10 +406,7 @@ static int __cifs_reconnect(struct TCP_Server_Info *server,
 			cifs_dbg(FYI, "%s: reconn_set_ipaddr_from_hostname: rc=%d\n", __func__, rc);
 		}
 
-		if (cifs_rdma_enabled(server))
-			rc = smbd_reconnect(server);
-		else
-			rc = generic_ip_connect(server);
+		rc = generic_ip_connect(server);
 		if (rc) {
 			cifs_server_unlock(server);
 			cifs_dbg(FYI, "%s: reconnect error %d\n", __func__, rc);
@@ -468,10 +463,7 @@ static int __reconnect_target_locked(struct TCP_Server_Info *server,
 		cifs_dbg(FYI, "%s: reconn_set_ipaddr_from_hostname: rc=%d\n", __func__, rc);
 	}
 	/* Reconnect the socket */
-	if (cifs_rdma_enabled(server))
-		rc = smbd_reconnect(server);
-	else
-		rc = generic_ip_connect(server);
+	rc = generic_ip_connect(server);
 
 	return rc;
 }
@@ -746,10 +738,7 @@ cifs_readv_from_socket(struct TCP_Server_Info *server, struct msghdr *smb_msg)
 
 		if (server_unresponsive(server))
 			return -ECONNABORTED;
-		if (cifs_rdma_enabled(server) && server->smbd_conn)
-			length = smbd_recv(server->smbd_conn, smb_msg);
-		else
-			length = sock_recvmsg(server->ssocket, smb_msg, 0);
+		length = sock_recvmsg(server->ssocket, smb_msg, 0);
 
 		spin_lock(&server->srv_lock);
 		if (server->tcpStatus == CifsExiting) {
@@ -1088,8 +1077,6 @@ clean_demultiplex_info(struct TCP_Server_Info *server)
 	wake_up_all(&server->request_q);
 	/* give those requests time to exit */
 	msleep(125);
-	if (cifs_rdma_enabled(server))
-		smbd_destroy(server);
 	if (server->ssocket) {
 		sock_release(server->ssocket);
 		server->ssocket = NULL;
@@ -1542,7 +1529,7 @@ match_port(struct TCP_Server_Info *server, struct sockaddr *addr)
 	__be16 port, *sport;
 
 	/* SMBDirect manages its own ports, don't match it here */
-	if (server->rdma)
+	if (cifs_rdma_enabled(server))
 		return true;
 
 	switch (addr->sa_family) {
@@ -1649,7 +1636,7 @@ static int match_server(struct TCP_Server_Info *server,
 	if (server->echo_interval != ctx->echo_interval * HZ)
 		return 0;
 
-	if (server->rdma != ctx->rdma)
+	if (cifs_rdma_enabled(server) != ctx->rdma)
 		return 0;
 
 	if (server->ignore_signature != ctx->ignore_signature)
@@ -1791,7 +1778,7 @@ cifs_get_tcp_session(struct smb3_fs_context *ctx,
 	tcp_ses->noblocksnd = ctx->noblocksnd || ctx->rootfs;
 	tcp_ses->noautotune = ctx->noautotune;
 	tcp_ses->tcp_nodelay = ctx->sockopt_tcp_nodelay;
-	tcp_ses->rdma = ctx->rdma;
+	tcp_ses->ipproto = ctx->rdma ? IPPROTO_SMBDIRECT : IPPROTO_TCP;
 	tcp_ses->in_flight = 0;
 	tcp_ses->max_in_flight = 0;
 	tcp_ses->credits = 1;
@@ -1844,29 +1831,18 @@ cifs_get_tcp_session(struct smb3_fs_context *ctx,
 	++tcp_ses->srv_count;
 	tcp_ses->echo_interval = ctx->echo_interval * HZ;
 
-	if (tcp_ses->rdma) {
-#ifndef CONFIG_CIFS_SMB_DIRECT
-		cifs_dbg(VFS, "CONFIG_CIFS_SMB_DIRECT is not enabled\n");
-		rc = -ENOENT;
-		goto out_err_crypto_release;
-#endif
-		tcp_ses->smbd_conn = smbd_get_connection(
-			tcp_ses, (struct sockaddr *)&ctx->dstaddr);
-		if (tcp_ses->smbd_conn) {
-			cifs_dbg(VFS, "RDMA transport established\n");
-			rc = 0;
-			goto smbd_connected;
-		} else {
+	rc = ip_connect(tcp_ses);
+	if (rc < 0) {
+		if (cifs_rdma_enabled(tcp_ses) && rc == -EPROTONOSUPPORT) {
+			cifs_dbg(VFS, "CONFIG_CIFS_SMB_DIRECT is not enabled\n");
 			rc = -ENOENT;
 			goto out_err_crypto_release;
 		}
-	}
-	rc = ip_connect(tcp_ses);
-	if (rc < 0) {
 		cifs_dbg(VFS, "Error connecting to socket. Aborting operation.\n");
 		goto out_err_crypto_release;
 	}
-smbd_connected:
+	if (cifs_rdma_enabled(tcp_ses))
+		cifs_dbg(VFS, "RDMA transport established\n");
 	/*
 	 * since we're in a cifs function already, we know that
 	 * this will succeed. No need for try_module_get().
@@ -3331,6 +3307,7 @@ generic_ip_connect(struct TCP_Server_Info *server)
 	struct sockaddr *saddr;
 	struct socket *socket;
 	int slen, sfamily;
+	const char *pname = cifs_rdma_enabled(server) ? "smbdirect" : "tcp";
 	__be16 sport;
 	int rc = 0;
 
@@ -3342,28 +3319,32 @@ generic_ip_connect(struct TCP_Server_Info *server)
 		sport = ipv6->sin6_port;
 		slen = sizeof(struct sockaddr_in6);
 		sfamily = AF_INET6;
-		cifs_dbg(FYI, "%s: connecting to [%pI6]:%d\n", __func__, &ipv6->sin6_addr,
-				ntohs(sport));
+		cifs_dbg(FYI, "%s: connecting with %s to [%pI6]:%d\n",
+			 __func__, pname, &ipv6->sin6_addr, ntohs(sport));
 	} else {
 		struct sockaddr_in *ipv4 = (struct sockaddr_in *)&server->dstaddr;
 
 		sport = ipv4->sin_port;
 		slen = sizeof(struct sockaddr_in);
 		sfamily = AF_INET;
-		cifs_dbg(FYI, "%s: connecting to %pI4:%d\n", __func__, &ipv4->sin_addr,
-				ntohs(sport));
+		cifs_dbg(FYI, "%s: connecting with %s to %pI4:%d\n",
+			 __func__, pname, &ipv4->sin_addr, ntohs(sport));
 	}
 
 	if (server->ssocket) {
-		socket = server->ssocket;
-	} else {
+		sock_release(server->ssocket);
+		server->ssocket = NULL;
+	}
+
+	{
 		struct net *net = cifs_net_ns(server);
 		struct sock *sk;
 
 		rc = sock_create_kern(net, sfamily, SOCK_STREAM,
-				      IPPROTO_TCP, &server->ssocket);
+				      server->ipproto, &server->ssocket);
 		if (rc < 0) {
-			cifs_server_dbg(VFS, "Error %d creating socket\n", rc);
+			cifs_server_dbg(VFS, "Error %d creating %s socket\n",
+					rc, pname);
 			return rc;
 		}
 
@@ -3371,7 +3352,7 @@ generic_ip_connect(struct TCP_Server_Info *server)
 		sk_net_refcnt_upgrade(sk);
 
 		/* BB other socket options to set KEEPALIVE, NODELAY? */
-		cifs_dbg(FYI, "Socket created\n");
+		cifs_dbg(FYI, "%s socket created\n", pname);
 		socket = server->ssocket;
 		socket->sk->sk_allocation = GFP_NOFS;
 		socket->sk->sk_use_task_frag = false;
@@ -3382,8 +3363,10 @@ generic_ip_connect(struct TCP_Server_Info *server)
 	}
 
 	rc = bind_socket(server);
-	if (rc < 0)
-		return rc;
+	if (rc < 0) {
+		cifs_dbg(FYI, "Error %d bind_socket() %s\n", rc, pname);
+		goto close_socket;
+	}
 
 	/*
 	 * Eventually check for other socket options to change from
@@ -3404,6 +3387,17 @@ generic_ip_connect(struct TCP_Server_Info *server)
 	if (server->tcp_nodelay)
 		tcp_sock_set_nodelay(socket->sk);
 
+	switch (server->ipproto) {
+	case IPPROTO_SMBDIRECT:
+		rc = smbd_prepare_socket(server, ntohs(sport));
+		if (rc < 0) {
+			cifs_dbg(FYI, "Error %d from smbd_prepare_socket(port=%u)\n",
+				 rc, ntohs(sport));
+			goto close_socket;
+		}
+		break;
+	}
+
 	cifs_dbg(FYI, "sndbuf %d rcvbuf %d rcvtimeo 0x%lx\n",
 		 socket->sk->sk_sndbuf,
 		 socket->sk->sk_rcvbuf, socket->sk->sk_rcvtimeo);
@@ -3418,11 +3412,8 @@ generic_ip_connect(struct TCP_Server_Info *server)
 	if (server->noblockcnt && rc == -EINPROGRESS)
 		rc = 0;
 	if (rc < 0) {
-		cifs_dbg(FYI, "Error %d connecting to server\n", rc);
-		trace_smb3_connect_err(server->hostname, server->conn_id, &server->dstaddr, rc);
-		sock_release(socket);
-		server->ssocket = NULL;
-		return rc;
+		cifs_dbg(FYI, "Error %d connecting with %s to server\n", rc, pname);
+		goto close_socket;
 	}
 	trace_smb3_connect_done(server->hostname, server->conn_id, &server->dstaddr);
 
@@ -3434,9 +3425,20 @@ generic_ip_connect(struct TCP_Server_Info *server)
 	 */
 	if (server->with_rfc1001 ||
 	    server->rfc1001_sessinit == 1 ||
-	    (server->rfc1001_sessinit == -1 && sport == htons(RFC1001_PORT)))
+	    (server->rfc1001_sessinit == -1 && sport == htons(RFC1001_PORT))) {
 		rc = ip_rfc1001_connect(server);
+		if (rc < 0) {
+			cifs_dbg(FYI, "Error %d from ip_rfc1001_connect\n", rc);
+			goto close_socket;
+		}
+	}
+
+	return rc;
 
+close_socket:
+	trace_smb3_connect_err(server->hostname, server->conn_id, &server->dstaddr, rc);
+	sock_release(socket);
+	server->ssocket = NULL;
 	return rc;
 }
 
@@ -3446,6 +3448,13 @@ ip_connect(struct TCP_Server_Info *server)
 	__be16 *sport;
 	struct sockaddr_in6 *addr6 = (struct sockaddr_in6 *)&server->dstaddr;
 	struct sockaddr_in *addr = (struct sockaddr_in *)&server->dstaddr;
+	u16 port1 = CIFS_PORT;
+	u16 port2 = RFC1001_PORT;
+
+	if (cifs_rdma_enabled(server)) {
+		port1 = SMBD_IWARP_PORT;
+		port2 = CIFS_PORT;
+	}
 
 	if (server->dstaddr.ss_family == AF_INET6)
 		sport = &addr6->sin6_port;
@@ -3455,15 +3464,15 @@ ip_connect(struct TCP_Server_Info *server)
 	if (*sport == 0) {
 		int rc;
 
-		/* try with 445 port at first */
-		*sport = htons(CIFS_PORT);
+		/* try with port1 at first */
+		*sport = htons(port1);
 
 		rc = generic_ip_connect(server);
 		if (rc >= 0)
 			return rc;
 
-		/* if it failed, try with 139 port */
-		*sport = htons(RFC1001_PORT);
+		/* if it failed, try with port2 */
+		*sport = htons(port2);
 	}
 
 	return generic_ip_connect(server);
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index a69e05f86d7e..8ca9f60ff429 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -97,9 +97,9 @@ static void cifs_prepare_write(struct netfs_io_subrequest *subreq)
 			      cifs_trace_rw_credits_write_prepare);
 
 #ifdef CONFIG_CIFS_SMB_DIRECT
-	if (server->smbd_conn) {
+	if (cifs_rdma_enabled(server)) {
 		const struct smbdirect_socket_parameters *sp =
-			smbd_get_parameters(server->smbd_conn);
+			smbd_get_parameters(server);
 
 		stream->sreq_max_segs = sp->max_frmr_depth;
 	}
@@ -191,9 +191,9 @@ static int cifs_prepare_read(struct netfs_io_subrequest *subreq)
 			      cifs_trace_rw_credits_read_submit);
 
 #ifdef CONFIG_CIFS_SMB_DIRECT
-	if (server->smbd_conn) {
+	if (cifs_rdma_enabled(server)) {
 		const struct smbdirect_socket_parameters *sp =
-			smbd_get_parameters(server->smbd_conn);
+			smbd_get_parameters(server);
 
 		rreq->io_streams[0].sreq_max_segs = sp->max_frmr_depth;
 	}
diff --git a/fs/smb/client/sess.c b/fs/smb/client/sess.c
index 698bd27119ae..9e79439002e6 100644
--- a/fs/smb/client/sess.c
+++ b/fs/smb/client/sess.c
@@ -207,7 +207,7 @@ int cifs_try_adding_channels(struct cifs_ses *ses)
 		list_for_each_entry_safe_from(iface, niface, &ses->iface_list,
 				    iface_head) {
 			/* do not mix rdma and non-rdma interfaces */
-			if (iface->rdma_capable != ses->server->rdma)
+			if (iface->rdma_capable != cifs_rdma_enabled(ses->server))
 				continue;
 
 			/* skip ifaces that are unusable */
@@ -395,7 +395,7 @@ cifs_chan_update_iface(struct cifs_ses *ses, struct TCP_Server_Info *server)
 		}
 
 		/* do not mix rdma and non-rdma interfaces */
-		if (iface->rdma_capable != server->rdma)
+		if (iface->rdma_capable != cifs_rdma_enabled(server))
 			continue;
 
 		if (!iface->is_active ||
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 509fcea28a42..208797de0c31 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -503,9 +503,9 @@ smb3_negotiate_wsize(struct cifs_tcon *tcon, struct smb3_fs_context *ctx)
 	wsize = ctx->got_wsize ? ctx->vol_wsize : SMB3_DEFAULT_IOSIZE;
 	wsize = min_t(unsigned int, wsize, server->max_write);
 #ifdef CONFIG_CIFS_SMB_DIRECT
-	if (server->rdma) {
+	if (cifs_rdma_enabled(server)) {
 		const struct smbdirect_socket_parameters *sp =
-			smbd_get_parameters(server->smbd_conn);
+			smbd_get_parameters(server);
 
 		if (server->sign)
 			/*
@@ -554,9 +554,9 @@ smb3_negotiate_rsize(struct cifs_tcon *tcon, struct smb3_fs_context *ctx)
 	rsize = ctx->got_rsize ? ctx->vol_rsize : SMB3_DEFAULT_IOSIZE;
 	rsize = min_t(unsigned int, rsize, server->max_read);
 #ifdef CONFIG_CIFS_SMB_DIRECT
-	if (server->rdma) {
+	if (cifs_rdma_enabled(server)) {
 		const struct smbdirect_socket_parameters *sp =
-			smbd_get_parameters(server->smbd_conn);
+			smbd_get_parameters(server);
 
 		if (server->sign)
 			/*
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 957aca2222b5..e954c75b36da 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -4472,7 +4472,7 @@ static inline bool smb3_use_rdma_offload(struct cifs_io_parms *io_parms)
 		return false;
 
 	/* we can only offload on an rdma connection */
-	if (!server->rdma || !server->smbd_conn)
+	if (!cifs_rdma_enabled(server))
 		return false;
 
 	/* we don't support signed offload yet */
@@ -4483,6 +4483,10 @@ static inline bool smb3_use_rdma_offload(struct cifs_io_parms *io_parms)
 	if (smb3_encryption_required(tcon))
 		return false;
 
+	/* this implicitly sets up server->rdma_readwrite_threshold */
+	if (!smbd_get_parameters(server))
+		return false;
+
 	/* offload also has its overhead, so only do it if desired */
 	if (io_parms->length < server->rdma_readwrite_threshold)
 		return false;
@@ -4540,7 +4544,7 @@ smb2_new_read_req(void **buf, unsigned int *total_len,
 		struct smbdirect_buffer_descriptor_v1 *v1;
 		bool need_invalidate = server->dialect == SMB30_PROT_ID;
 
-		rdata->mr = smbd_register_mr(server->smbd_conn, &rdata->subreq.io_iter,
+		rdata->mr = smbd_register_mr(server, &rdata->subreq.io_iter,
 					     true, need_invalidate);
 		if (!rdata->mr)
 			return -EAGAIN;
@@ -5134,7 +5138,7 @@ smb2_async_writev(struct cifs_io_subrequest *wdata)
 		struct smbdirect_buffer_descriptor_v1 *v1;
 		bool need_invalidate = server->dialect == SMB30_PROT_ID;
 
-		wdata->mr = smbd_register_mr(server->smbd_conn, &wdata->subreq.io_iter,
+		wdata->mr = smbd_register_mr(server, &wdata->subreq.io_iter,
 					     false, need_invalidate);
 		if (!wdata->mr) {
 			rc = -EAGAIN;
diff --git a/fs/smb/client/smbdirect.c b/fs/smb/client/smbdirect.c
index 9e67adcdc7d3..7d4fa896efc0 100644
--- a/fs/smb/client/smbdirect.c
+++ b/fs/smb/client/smbdirect.c
@@ -11,10 +11,6 @@
 #include "smb2proto.h"
 #include "../common/smbdirect/smbdirect_public.h"
 
-/* Port numbers for SMBD transport */
-#define SMB_PORT	445
-#define SMBD_PORT	5445
-
 /* Address lookup and resolve timeout in ms */
 #define RDMA_RESOLVE_TIMEOUT	5000
 
@@ -81,18 +77,9 @@ int rdma_readwrite_threshold = 4096;
 /* Transport logging functions
  * Logging are defined as classes. They can be OR'ed to define the actual
  * logging level via module parameter smbd_logging_class
- * e.g. cifs.smbd_logging_class=0xa0 will log all log_rdma_recv() and
- * log_rdma_event()
+ * e.g. cifs.smbd_logging_class=0xa0 will log all SMBDIRECT_LOG_RDMA_RECV and
+ * SMBDIRECT_LOG_RDMA_EVENT
  */
-#define LOG_OUTGOING			0x1
-#define LOG_INCOMING			0x2
-#define LOG_READ			0x4
-#define LOG_WRITE			0x8
-#define LOG_RDMA_SEND			0x10
-#define LOG_RDMA_RECV			0x20
-#define LOG_KEEP_ALIVE			0x40
-#define LOG_RDMA_EVENT			0x80
-#define LOG_RDMA_MR			0x100
 static unsigned int smbd_logging_class;
 module_param(smbd_logging_class, uint, 0644);
 MODULE_PARM_DESC(smbd_logging_class,
@@ -114,17 +101,6 @@ static bool smbd_logging_needed(struct smbdirect_socket *sc,
 	BUILD_BUG_SAME(ERR);
 	BUILD_BUG_SAME(INFO);
 #undef BUILD_BUG_SAME
-#define BUILD_BUG_SAME(x) BUILD_BUG_ON(x != SMBDIRECT_ ##x)
-	BUILD_BUG_SAME(LOG_OUTGOING);
-	BUILD_BUG_SAME(LOG_INCOMING);
-	BUILD_BUG_SAME(LOG_READ);
-	BUILD_BUG_SAME(LOG_WRITE);
-	BUILD_BUG_SAME(LOG_RDMA_SEND);
-	BUILD_BUG_SAME(LOG_RDMA_RECV);
-	BUILD_BUG_SAME(LOG_KEEP_ALIVE);
-	BUILD_BUG_SAME(LOG_RDMA_EVENT);
-	BUILD_BUG_SAME(LOG_RDMA_MR);
-#undef BUILD_BUG_SAME
 
 	if (lvl <= smbd_logging_level || cls & smbd_logging_class)
 		return true;
@@ -148,22 +124,7 @@ do {									\
 		cifs_dbg(VFS, "%s:%d " fmt, __func__, __LINE__, ##args);\
 } while (0)
 
-#define log_outgoing(level, fmt, args...) \
-		log_rdma(level, LOG_OUTGOING, fmt, ##args)
-#define log_incoming(level, fmt, args...) \
-		log_rdma(level, LOG_INCOMING, fmt, ##args)
-#define log_read(level, fmt, args...)	log_rdma(level, LOG_READ, fmt, ##args)
-#define log_write(level, fmt, args...)	log_rdma(level, LOG_WRITE, fmt, ##args)
-#define log_rdma_send(level, fmt, args...) \
-		log_rdma(level, LOG_RDMA_SEND, fmt, ##args)
-#define log_rdma_recv(level, fmt, args...) \
-		log_rdma(level, LOG_RDMA_RECV, fmt, ##args)
-#define log_keep_alive(level, fmt, args...) \
-		log_rdma(level, LOG_KEEP_ALIVE, fmt, ##args)
-#define log_rdma_event(level, fmt, args...) \
-		log_rdma(level, LOG_RDMA_EVENT, fmt, ##args)
-#define log_rdma_mr(level, fmt, args...) \
-		log_rdma(level, LOG_RDMA_MR, fmt, ##args)
+#define log_write(level, fmt, args...)	log_rdma(level, SMBDIRECT_LOG_WRITE, fmt, ##args)
 
 static int smbd_post_send_full_iter(struct smbdirect_socket *sc,
 				    struct smbdirect_send_batch *batch,
@@ -195,82 +156,24 @@ static int smbd_post_send_full_iter(struct smbdirect_socket *sc,
 	return bytes;
 }
 
-/*
- * Destroy the transport and related RDMA and memory resources
- * Need to go through all the pending counters and make sure on one is using
- * the transport while it is destroyed
- */
-void smbd_destroy(struct TCP_Server_Info *server)
-{
-	struct smbd_connection *info = server->smbd_conn;
-
-	if (!info) {
-		log_rdma_event(INFO, "rdma session already destroyed\n");
-		return;
-	}
-
-	smbdirect_socket_release(info->socket);
-
-	kfree(info);
-	server->smbd_conn = NULL;
-}
-
-/*
- * Reconnect this SMBD connection, called from upper layer
- * return value: 0 on success, or actual error code
- */
-int smbd_reconnect(struct TCP_Server_Info *server)
-{
-	log_rdma_event(INFO, "reconnecting rdma session\n");
-
-	if (!server->smbd_conn) {
-		log_rdma_event(INFO, "rdma session already destroyed\n");
-		goto create_conn;
-	}
-
-	/*
-	 * This is possible if transport is disconnected and we haven't received
-	 * notification from RDMA, but upper layer has detected timeout
-	 */
-	log_rdma_event(INFO, "disconnecting transport\n");
-	smbd_destroy(server);
-
-create_conn:
-	log_rdma_event(INFO, "creating rdma session\n");
-	server->smbd_conn = smbd_get_connection(
-		server, (struct sockaddr *) &server->dstaddr);
-
-	if (server->smbd_conn) {
-		cifs_dbg(VFS, "RDMA transport re-established\n");
-		trace_smb3_smbd_connect_done(server->hostname, server->conn_id, &server->dstaddr);
-		return 0;
-	}
-	trace_smb3_smbd_connect_err(server->hostname, server->conn_id, &server->dstaddr);
-	return -ENOENT;
-}
-
 /* Create a SMBD connection, called by upper layer */
-static struct smbd_connection *_smbd_get_connection(
-	struct TCP_Server_Info *server, struct sockaddr *dstaddr, int port)
+int smbd_prepare_socket(struct TCP_Server_Info *server, int port)
 {
-	struct net *net = cifs_net_ns(server);
-	struct smbd_connection *info;
-	struct smbdirect_socket *sc;
+	struct smbdirect_socket *sc = NULL;
 	struct smbdirect_socket_parameters init_params = {};
 	struct smbdirect_socket_parameters *sp;
-	__be16 *sport;
 	u64 port_flags = 0;
 	int ret;
 
 	switch (port) {
-	case SMBD_PORT:
+	case SMBD_IWARP_PORT:
 		/*
 		 * only allow iWarp devices
 		 * for port 5445.
 		 */
 		port_flags |= SMBDIRECT_FLAG_PORT_RANGE_ONLY_IW;
 		break;
-	case SMB_PORT:
+	case CIFS_PORT:
 		/*
 		 * only allow InfiniBand, RoCEv1 or RoCEv2
 		 * devices for port 445.
@@ -281,6 +184,12 @@ static struct smbd_connection *_smbd_get_connection(
 		break;
 	}
 
+	if (server && cifs_rdma_enabled(server) && server->ssocket)
+		sc = smbdirect_socket_from_sock(server->ssocket);
+
+	if (WARN_ON_ONCE(!sc))
+		return -ENOTCONN;
+
 	/*
 	 * Create the initial parameters
 	 */
@@ -301,107 +210,40 @@ static struct smbd_connection *_smbd_get_connection(
 	sp->keepalive_interval_msec = smbd_keep_alive_interval * 1000;
 	sp->keepalive_timeout_msec = KEEPALIVE_RECV_TIMEOUT * 1000;
 
-	info = kzalloc_obj(*info);
-	if (!info)
-		return NULL;
-	ret = smbdirect_socket_create_kern(net, &sc);
-	if (ret)
-		goto socket_init_failed;
 	smbdirect_socket_set_logging(sc, NULL, smbd_logging_needed, smbd_logging_vaprintf);
 	ret = smbdirect_socket_set_initial_parameters(sc, sp);
 	if (ret)
-		goto set_params_failed;
+		return ret;
 	ret = smbdirect_socket_set_kernel_settings(sc, IB_POLL_SOFTIRQ, GFP_KERNEL);
 	if (ret)
-		goto set_settings_failed;
-
-	if (dstaddr->sa_family == AF_INET6)
-		sport = &((struct sockaddr_in6 *)dstaddr)->sin6_port;
-	else
-		sport = &((struct sockaddr_in *)dstaddr)->sin_port;
-
-	*sport = htons(port);
+		return ret;
 
-	ret = smbdirect_connect_sync(sc, dstaddr);
-	if (ret) {
-		log_rdma_event(ERR, "connect to %pISpsfc failed: %1pe\n",
-			       dstaddr, ERR_PTR(ret));
-		goto connect_failed;
-	}
-
-	info->socket = sc;
-	return info;
-
-connect_failed:
-set_settings_failed:
-set_params_failed:
-	smbdirect_socket_release(sc);
-socket_init_failed:
-	kfree(info);
-	return NULL;
+	return 0;
 }
 
-const struct smbdirect_socket_parameters *smbd_get_parameters(struct smbd_connection *conn)
+const struct smbdirect_socket_parameters *smbd_get_parameters(struct TCP_Server_Info *server)
 {
-	if (unlikely(!conn->socket)) {
-		static const struct smbdirect_socket_parameters zero_params;
+	struct smbdirect_socket *sc = NULL;
+	const struct smbdirect_socket_parameters *sp = NULL;
 
-		return &zero_params;
-	}
-
-	return smbdirect_socket_get_current_parameters(conn->socket);
-}
+	if (server && cifs_rdma_enabled(server) && server->ssocket)
+		sc = smbdirect_socket_from_sock(server->ssocket);
 
-struct smbd_connection *smbd_get_connection(
-	struct TCP_Server_Info *server, struct sockaddr *dstaddr)
-{
-	struct smbd_connection *ret;
-	const struct smbdirect_socket_parameters *sp;
-	int port = SMBD_PORT;
-
-try_again:
-	ret = _smbd_get_connection(server, dstaddr, port);
+	if (!sc) {
+		static const struct smbdirect_socket_parameters zero_params;
 
-	/* Try SMB_PORT if SMBD_PORT doesn't work */
-	if (!ret && port == SMBD_PORT) {
-		port = SMB_PORT;
-		goto try_again;
+		return &zero_params;
 	}
-	if (!ret)
-		return NULL;
 
-	sp = smbd_get_parameters(ret);
+	sp = smbdirect_socket_get_current_parameters(sc);
 
-	server->rdma_readwrite_threshold =
-		rdma_readwrite_threshold > sp->max_fragmented_send_size ?
-		sp->max_fragmented_send_size :
-		rdma_readwrite_threshold;
+	if (server->rdma_readwrite_threshold == 0)
+		server->rdma_readwrite_threshold =
+			rdma_readwrite_threshold > sp->max_fragmented_send_size ?
+			sp->max_fragmented_send_size :
+			rdma_readwrite_threshold;
 
-	return ret;
-}
-
-/*
- * Receive data from the transport's receive reassembly queue
- * All the incoming data packets are placed in reassembly queue
- * iter: the buffer to read data into
- * size: the length of data to read
- * return value: actual data read
- *
- * Note: this implementation copies the data from reassembly queue to receive
- * buffers used by upper layer. This is not the optimal code path. A better way
- * to do it is to not have upper layer allocate its receive buffers but rather
- * borrow the buffer from reassembly queue, and return it after data is
- * consumed. But this will require more changes to upper layer code, and also
- * need to consider packet boundaries while they still being reassembled.
- */
-int smbd_recv(struct smbd_connection *info, struct msghdr *msg)
-{
-	struct smbdirect_socket *sc = info->socket;
-
-	if (!smbdirect_connection_is_connected(sc))
-		return -ENOTCONN;
-
-	return smbdirect_connection_recvmsg(sc, msg, 0);
+	return sp;
 }
 
 /*
@@ -410,12 +252,11 @@ int smbd_recv(struct smbd_connection *info, struct msghdr *msg)
  * rqst: the data to write
  * return value: 0 if successfully write, otherwise error code
  */
-int smbd_send(struct TCP_Server_Info *server,
+static int smbd_send_locked(struct TCP_Server_Info *server,
 	int num_rqst, struct smb_rqst *rqst_array)
 {
-	struct smbd_connection *info = server->smbd_conn;
-	struct smbdirect_socket *sc = info->socket;
-	const struct smbdirect_socket_parameters *sp = smbd_get_parameters(info);
+	struct smbdirect_socket *sc = NULL;
+	const struct smbdirect_socket_parameters *sp = smbd_get_parameters(server);
 	struct smb_rqst *rqst;
 	struct iov_iter iter;
 	struct smbdirect_send_batch_storage bstorage;
@@ -424,6 +265,9 @@ int smbd_send(struct TCP_Server_Info *server,
 	int rc, i, rqst_idx;
 	int error = 0;
 
+	if (server && cifs_rdma_enabled(server) && server->ssocket)
+		sc = smbdirect_socket_from_sock(server->ssocket);
+
 	if (!smbdirect_connection_is_connected(sc))
 		return -EAGAIN;
 
@@ -508,6 +352,28 @@ int smbd_send(struct TCP_Server_Info *server,
 	return 0;
 }
 
+int smbd_send(struct TCP_Server_Info *server,
+	int num_rqst, struct smb_rqst *rqst_array)
+{
+	struct smbdirect_socket *sc = NULL;
+	struct sock *sk = NULL;
+	int ret;
+
+	if (server && cifs_rdma_enabled(server) && server->ssocket) {
+		sc = smbdirect_socket_from_sock(server->ssocket);
+		sk = server->ssocket->sk;
+	}
+
+	if (!smbdirect_connection_is_connected(sc))
+		return -EAGAIN;
+
+	lock_sock(sk);
+	ret = smbd_send_locked(server, num_rqst, rqst_array);
+	release_sock(sk);
+
+	return ret;
+}
+
 /*
  * Register memory for RDMA read/write
  * iter: the buffer to register memory with
@@ -515,11 +381,14 @@ int smbd_send(struct TCP_Server_Info *server,
  * need_invalidate: true if this MR needs to be locally invalidated after I/O
  * return value: the MR registered, NULL if failed.
  */
-struct smbdirect_mr_io *smbd_register_mr(struct smbd_connection *info,
+struct smbdirect_mr_io *smbd_register_mr(struct TCP_Server_Info *server,
 				 struct iov_iter *iter,
 				 bool writing, bool need_invalidate)
 {
-	struct smbdirect_socket *sc = info->socket;
+	struct smbdirect_socket *sc = NULL;
+
+	if (server && cifs_rdma_enabled(server) && server->ssocket)
+		sc = smbdirect_socket_from_sock(server->ssocket);
 
 	if (!smbdirect_connection_is_connected(sc))
 		return NULL;
@@ -546,15 +415,25 @@ void smbd_deregister_mr(struct smbdirect_mr_io *mr)
 
 void smbd_debug_proc_show(struct TCP_Server_Info *server, struct seq_file *m)
 {
-	if (!server->rdma)
+	struct smbdirect_socket *sc = NULL;
+
+	if (!cifs_rdma_enabled(server))
 		return;
 
-	if (!server->smbd_conn) {
+	if (server->ssocket) {
+		sc = smbdirect_socket_from_sock(server->ssocket);
+		/*
+		 * setup server->rdma_readwrite_threshold is required
+		 */
+		(void) smbd_get_parameters(server);
+	}
+
+	if (!sc) {
 		seq_puts(m, "\nSMBDirect transport not available");
 		return;
 	}
 
-	smbdirect_connection_legacy_debug_proc_show(server->smbd_conn->socket,
+	smbdirect_connection_legacy_debug_proc_show(sc,
 						    server->rdma_readwrite_threshold,
 						    m);
 }
diff --git a/fs/smb/client/smbdirect.h b/fs/smb/client/smbdirect.h
index 0017d5b2de44..44b37234d87c 100644
--- a/fs/smb/client/smbdirect.h
+++ b/fs/smb/client/smbdirect.h
@@ -8,7 +8,6 @@
 #define _SMBDIRECT_H
 
 #ifdef CONFIG_CIFS_SMB_DIRECT
-#define cifs_rdma_enabled(server)	((server)->rdma)
 
 #include "cifsglob.h"
 
@@ -23,29 +22,18 @@ extern int smbd_max_send_size;
 extern int smbd_send_credit_target;
 extern int smbd_receive_credit_max;
 
-struct smbd_connection {
-	struct smbdirect_socket *socket;
-};
+/* prepare a SMBDirect session */
+int smbd_prepare_socket(struct TCP_Server_Info *server, int port);
 
-/* Create a SMBDirect session */
-struct smbd_connection *smbd_get_connection(
-	struct TCP_Server_Info *server, struct sockaddr *dstaddr);
-
-const struct smbdirect_socket_parameters *smbd_get_parameters(struct smbd_connection *conn);
-
-/* Reconnect SMBDirect session */
-int smbd_reconnect(struct TCP_Server_Info *server);
-/* Destroy SMBDirect session */
-void smbd_destroy(struct TCP_Server_Info *server);
+const struct smbdirect_socket_parameters *smbd_get_parameters(struct TCP_Server_Info *server);
 
 /* Interface for carrying upper layer I/O through send/recv */
-int smbd_recv(struct smbd_connection *info, struct msghdr *msg);
 int smbd_send(struct TCP_Server_Info *server,
 	int num_rqst, struct smb_rqst *rqst);
 
 /* Interfaces to register and deregister MR for RDMA read/write */
 struct smbdirect_mr_io *smbd_register_mr(
-	struct smbd_connection *info, struct iov_iter *iter,
+	struct TCP_Server_Info *server, struct iov_iter *iter,
 	bool writing, bool need_invalidate);
 void smbd_mr_fill_buffer_descriptor(struct smbdirect_mr_io *mr,
 				    struct smbdirect_buffer_descriptor_v1 *v1);
@@ -54,13 +42,6 @@ void smbd_deregister_mr(struct smbdirect_mr_io *mr);
 void smbd_debug_proc_show(struct TCP_Server_Info *server, struct seq_file *m);
 
 #else
-#define cifs_rdma_enabled(server)	0
-struct smbd_connection {};
-static inline void *smbd_get_connection(
-	struct TCP_Server_Info *server, struct sockaddr *dstaddr) {return NULL;}
-static inline int smbd_reconnect(struct TCP_Server_Info *server) {return -1; }
-static inline void smbd_destroy(struct TCP_Server_Info *server) {}
-static inline int smbd_recv(struct smbd_connection *info, struct msghdr *msg) {return -1; }
 static inline int smbd_send(struct TCP_Server_Info *server, int num_rqst, struct smb_rqst *rqst) {return -1; }
 #endif
 
diff --git a/fs/smb/client/transport.c b/fs/smb/client/transport.c
index 05f8099047e1..e64becee928f 100644
--- a/fs/smb/client/transport.c
+++ b/fs/smb/client/transport.c
@@ -253,7 +253,7 @@ int __smb_send_rqst(struct TCP_Server_Info *server, int num_rqst,
 	if (cifs_rdma_enabled(server)) {
 		/* return -EAGAIN when connecting or reconnecting */
 		rc = -EAGAIN;
-		if (server->smbd_conn)
+		if (ssocket)
 			rc = smbd_send(server, num_rqst, rqst);
 		goto smbd_done;
 	}
-- 
2.43.0


