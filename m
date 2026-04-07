Return-Path: <linux-rdma+bounces-19098-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECt0Mrka1WmZ0wcAu9opvQ
	(envelope-from <linux-rdma+bounces-19098-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Apr 2026 16:54:49 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 532053B06E1
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Apr 2026 16:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 806F030C815C
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Apr 2026 14:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EF3328B56;
	Tue,  7 Apr 2026 14:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="IruX2oPJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3258D30E84D;
	Tue,  7 Apr 2026 14:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775573278; cv=none; b=JbdjHn9wamrITwOrfkzgKffZ33+mNQp0H/s4c+zNhg4+e0S23DSW4FC41As2K9m5bh0VjXWcOFODIspuijTbz5R7j8TON/Ns/XlJkqG0+Joy0xqHJtutF1w8/W6Q2aDGQfYvW2+bDoTg73TBgS7P693vGoTf+0qWZHL7M046l6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775573278; c=relaxed/simple;
	bh=2dq2P+0tdbsbjZz2u/DeRU8PxALkmPrOdEZzk4yADsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kCj7D5Pb689rKiKFfJV/5PaB3BPLkmZOfmvU0FXdjlwjy9mGzyM/tqPfon8lmGGO1uqJ2/70allMp9Lspu7EN61vI4YkoMQKKu49/xOxr4t1vgXhpYs12rtAceoYRw7J1u8Ox8jHmYeU1Nph2cpXT57quPHsntajnF/0qexHs3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=IruX2oPJ; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Message-ID:Date:Cc:To:From;
	bh=ZZvdJM7m8CwmDYuF3I+bBNMABHxGKhrdyV5j+jSjLAw=; b=IruX2oPJmWUD91PA2Qmj99TRw0
	fZ1Hg2rJrtq4sTrTJda7uGgSy8toTHCBd7quynm8ktkEfBsFNP988bkCCRz2q3xZkVXiA5bos/vrw
	nkCpNma/IlCmD8bKm2nAe8SKXXomnqx2U0k5t/t1cE83Or/3Rr657+54GGxcSnSgc78L+PBWD45fS
	BHf37mKku9NYbi8VfPnwJo7PSSNSwcgMA+Q/QWotfEfngct76DTnkMgu4gol1SAJgmxC1ulq+zamy
	6gxEx7RywbcgcxcswXLsJyyKrRCSPTEcBmfrlldEc618j7bCvObONRjPcknrodhYt+n34pMtQ89zV
	gLEwySw3R2HtjxVXWWvjindUftapZs6jlFyh9nhZH4a5TNHaHc/QdOhFxHsqcEiuOhl/4x8Lt4SYc
	bmwV+d5ioKaSEDXDO8UxKfg8m27oEasmL0BCOwqjv/I6sj4j73kMDnPfY3BnuftHrnB35nmdlJQkg
	AdGFm+yJWmfCTaPMTbTPt6hN;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1wA7iZ-00000007WTu-3ZuH;
	Tue, 07 Apr 2026 14:47:51 +0000
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
Subject: [PATCH 8/8] smb: server: make use of IPPROTO_SMBDIRECT sockets
Date: Tue,  7 Apr 2026 16:46:34 +0200
Message-ID: <e1972e6f1fda9842c5724b7daf4a2aa7779901a5.1775571957.git.metze@samba.org>
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
	TAGGED_FROM(0.00)[bounces-19098-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: 532053B06E1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This reduces the function calls for special smbdirect features to
- smbdirect_socket_from_sock()
- smbdirect_socket_set_logging()
- smbdirect_socket_set_initial_parameters()
- smbdirect_socket_set_kernel_settings()
- smbdirect_socket_get_current_parameters()
- smbdirect_connection_is_connected()
- smbdirect_connection_rdma_xmit()

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
 fs/smb/server/transport_rdma.c | 119 +++++++++++++++++++--------------
 1 file changed, 70 insertions(+), 49 deletions(-)

diff --git a/fs/smb/server/transport_rdma.c b/fs/smb/server/transport_rdma.c
index 706a2c897948..64be48165cda 100644
--- a/fs/smb/server/transport_rdma.c
+++ b/fs/smb/server/transport_rdma.c
@@ -82,13 +82,13 @@ static struct smb_direct_listener {
 
 	struct task_struct	*thread;
 
-	struct smbdirect_socket *socket;
+	struct socket		*sock;
 } smb_direct_ib_listener, smb_direct_iw_listener;
 
 struct smb_direct_transport {
 	struct ksmbd_transport	transport;
 
-	struct smbdirect_socket *socket;
+	struct socket		*sock;
 };
 
 static bool smb_direct_logging_needed(struct smbdirect_socket *sc,
@@ -165,18 +165,23 @@ void init_smbd_max_io_size(unsigned int sz)
 unsigned int get_smbd_max_read_write_size(struct ksmbd_transport *kt)
 {
 	struct smb_direct_transport *t;
+	struct smbdirect_socket *sc;
 	const struct smbdirect_socket_parameters *sp;
 
 	if (kt->ops != &ksmbd_smb_direct_transport_ops)
 		return 0;
 
 	t = SMBD_TRANS(kt);
-	sp = smbdirect_socket_get_current_parameters(t->socket);
+	sc = smbdirect_socket_from_sock(t->sock);
+
+	if (!smbdirect_connection_is_connected(sc))
+		return 0;
+	sp = smbdirect_socket_get_current_parameters(sc);
 
 	return sp->max_read_write_size;
 }
 
-static struct smb_direct_transport *alloc_transport(struct smbdirect_socket *sc)
+static struct smb_direct_transport *alloc_transport(struct socket *client_sock)
 {
 	struct smb_direct_transport *t;
 	struct ksmbd_conn *conn;
@@ -184,7 +189,7 @@ static struct smb_direct_transport *alloc_transport(struct smbdirect_socket *sc)
 	t = kzalloc_obj(*t, KSMBD_DEFAULT_GFP);
 	if (!t)
 		return NULL;
-	t->socket = sc;
+	t->sock = client_sock;
 
 	conn = ksmbd_conn_alloc();
 	if (!conn)
@@ -209,13 +214,13 @@ static void smb_direct_free_transport(struct ksmbd_transport *kt)
 {
 	struct smb_direct_transport *t = SMBD_TRANS(kt);
 
-	smbdirect_socket_release(t->socket);
+	sock_release(t->sock);
 	kfree(t);
 }
 
 static void free_transport(struct smb_direct_transport *t)
 {
-	smbdirect_socket_shutdown(t->socket);
+	kernel_sock_shutdown(t->sock, SHUT_RDWR);
 	ksmbd_conn_free(KSMBD_TRANS(t)->conn);
 }
 
@@ -223,7 +228,6 @@ static int smb_direct_read(struct ksmbd_transport *t, char *buf,
 			   unsigned int size, int unused)
 {
 	struct smb_direct_transport *st = SMBD_TRANS(t);
-	struct smbdirect_socket *sc = st->socket;
 	struct msghdr msg = { .msg_flags = 0, };
 	struct kvec iov = {
 		.iov_base = buf,
@@ -231,9 +235,7 @@ static int smb_direct_read(struct ksmbd_transport *t, char *buf,
 	};
 	int ret;
 
-	iov_iter_kvec(&msg.msg_iter, ITER_DEST, &iov, 1, size);
-
-	ret = smbdirect_connection_recvmsg(sc, &msg, 0);
+	ret = kernel_recvmsg(st->sock, &msg, &iov, 1, size, 0);
 	if (ret == -ERESTARTSYS)
 		ret = -EINTR;
 	return ret;
@@ -244,13 +246,14 @@ static int smb_direct_writev(struct ksmbd_transport *t,
 			     bool need_invalidate, unsigned int remote_key)
 {
 	struct smb_direct_transport *st = SMBD_TRANS(t);
-	struct smbdirect_socket *sc = st->socket;
-	struct iov_iter iter;
+	struct msghdr msg = { .msg_flags = MSG_NOSIGNAL, };
+	struct smbdirect_cmsg_buffer cbuffer = { .msg_control = {0, }, };
+	u32 _remote_token = remote_key;
+	const u32 *remote_token = need_invalidate ? &_remote_token : NULL;
 
-	iov_iter_kvec(&iter, ITER_SOURCE, iov, niovs, buflen);
+	smbdirect_buffer_remote_invalidate_cmsg_prepare(&msg, &cbuffer, remote_token);
 
-	return smbdirect_connection_send_iter(sc, &iter, 0,
-					      need_invalidate, remote_key);
+	return kernel_sendmsg(st->sock, &msg, iov, niovs, buflen);
 }
 
 static int smb_direct_rdma_write(struct ksmbd_transport *t,
@@ -259,7 +262,10 @@ static int smb_direct_rdma_write(struct ksmbd_transport *t,
 				 unsigned int desc_len)
 {
 	struct smb_direct_transport *st = SMBD_TRANS(t);
-	struct smbdirect_socket *sc = st->socket;
+	struct smbdirect_socket *sc = smbdirect_socket_from_sock(st->sock);
+
+	if (!smbdirect_connection_is_connected(sc))
+		return -ENOTCONN;
 
 	return smbdirect_connection_rdma_xmit(sc, buf, buflen,
 					      desc, desc_len, false);
@@ -271,7 +277,10 @@ static int smb_direct_rdma_read(struct ksmbd_transport *t,
 				unsigned int desc_len)
 {
 	struct smb_direct_transport *st = SMBD_TRANS(t);
-	struct smbdirect_socket *sc = st->socket;
+	struct smbdirect_socket *sc = smbdirect_socket_from_sock(st->sock);
+
+	if (!smbdirect_connection_is_connected(sc))
+		return -ENOTCONN;
 
 	return smbdirect_connection_rdma_xmit(sc, buf, buflen,
 					      desc, desc_len, true);
@@ -280,7 +289,7 @@ static int smb_direct_rdma_read(struct ksmbd_transport *t,
 static void smb_direct_disconnect(struct ksmbd_transport *t)
 {
 	struct smb_direct_transport *st = SMBD_TRANS(t);
-	struct smbdirect_socket *sc = st->socket;
+	struct smbdirect_socket *sc = smbdirect_socket_from_sock(st->sock);
 
 	ksmbd_debug(RDMA, "Disconnecting sc=%p\n", sc);
 
@@ -290,23 +299,23 @@ static void smb_direct_disconnect(struct ksmbd_transport *t)
 static void smb_direct_shutdown(struct ksmbd_transport *t)
 {
 	struct smb_direct_transport *st = SMBD_TRANS(t);
-	struct smbdirect_socket *sc = st->socket;
+	struct smbdirect_socket *sc = smbdirect_socket_from_sock(st->sock);
 
 	ksmbd_debug(RDMA, "smb-direct shutdown sc=%p\n", sc);
 
-	smbdirect_socket_shutdown(sc);
+	kernel_sock_shutdown(st->sock, SHUT_RDWR);
 }
 
 static int smb_direct_new_connection(struct smb_direct_listener *listener,
-				     struct smbdirect_socket *client_sc)
+				     struct socket *client_sock)
 {
 	struct smb_direct_transport *t;
 	struct task_struct *handler;
 	int ret;
 
-	t = alloc_transport(client_sc);
+	t = alloc_transport(client_sock);
 	if (!t) {
-		smbdirect_socket_release(client_sc);
+		sock_release(client_sock);
 		return -ENOMEM;
 	}
 
@@ -328,22 +337,21 @@ static int smb_direct_new_connection(struct smb_direct_listener *listener,
 static int smb_direct_listener_kthread_fn(void *p)
 {
 	struct smb_direct_listener *listener = (struct smb_direct_listener *)p;
-	struct smbdirect_socket *client_sc = NULL;
+	struct socket *client_sock = NULL;
 
 	while (!kthread_should_stop()) {
-		struct proto_accept_arg arg = { .err = -EINVAL, };
-		long timeo = MAX_SCHEDULE_TIMEOUT;
+		int ret;
 
-		if (!listener->socket)
+		if (!listener->sock)
 			break;
-		client_sc = smbdirect_socket_accept(listener->socket, timeo, &arg);
-		if (!client_sc && arg.err == -EINVAL)
+		ret = kernel_accept(listener->sock, &client_sock, 0);
+		if (ret == -EINVAL)
 			break;
-		if (!client_sc)
+		if (ret)
 			continue;
 
 		ksmbd_debug(CONN, "connect success: accepted new connection\n");
-		smb_direct_new_connection(listener, client_sc);
+		smb_direct_new_connection(listener, client_sock);
 	}
 
 	ksmbd_debug(CONN, "releasing socket\n");
@@ -354,8 +362,12 @@ static void smb_direct_listener_destroy(struct smb_direct_listener *listener)
 {
 	int ret;
 
-	if (listener->socket)
-		smbdirect_socket_shutdown(listener->socket);
+	if (listener->sock) {
+		ret = kernel_sock_shutdown(listener->sock, SHUT_RDWR);
+		if (ret)
+			pr_err("Failed to shutdown socket: %d %1pe\n",
+			       ret, ERR_PTR(ret));
+	}
 
 	if (listener->thread) {
 		ret = kthread_stop(listener->thread);
@@ -364,9 +376,9 @@ static void smb_direct_listener_destroy(struct smb_direct_listener *listener)
 		listener->thread = NULL;
 	}
 
-	if (listener->socket) {
-		smbdirect_socket_release(listener->socket);
-		listener->socket = NULL;
+	if (listener->sock) {
+		sock_release(listener->sock);
+		listener->sock = NULL;
 	}
 
 	listener->port = 0;
@@ -376,6 +388,7 @@ static int smb_direct_listen(struct smb_direct_listener *listener,
 			     int port)
 {
 	struct net *net = current->nsproxy->net_ns;
+	struct socket *ksmbd_socket;
 	struct task_struct *kthread;
 	struct sockaddr_in sin = {
 		.sin_family		= AF_INET,
@@ -410,13 +423,21 @@ static int smb_direct_listen(struct smb_direct_listener *listener,
 		return -ENODEV;
 	}
 
-	ret = smbdirect_socket_create_kern(net, &sc);
+	ret = sock_create_kern(net, PF_INET, SOCK_STREAM, IPPROTO_SMBDIRECT,
+			       &ksmbd_socket);
 	if (ret) {
-		pr_err("smbdirect_socket_create_kern() failed: %d %1pe\n",
+		pr_err("Can't create IPPROTO_SMBDIRECT socket: %d %1pe\n",
 		       ret, ERR_PTR(ret));
 		return ret;
 	}
 
+	sc = smbdirect_socket_from_sock(ksmbd_socket);
+	if (WARN_ON_ONCE(!sc)) {
+		ret = -EINVAL;
+		pr_err("smbdirect_socket_from_sock returned NULL\n");
+		goto err;
+	}
+
 	/*
 	 * Create the initial parameters
 	 */
@@ -450,22 +471,22 @@ static int smb_direct_listen(struct smb_direct_listener *listener,
 		goto err;
 	}
 
-	ret = smbdirect_socket_bind(sc, (struct sockaddr *)&sin);
+	ret = kernel_bind(ksmbd_socket, (struct sockaddr_unsized *)&sin, sizeof(sin));
 	if (ret) {
-		pr_err("smbdirect_socket_bind() failed: %d %1pe\n",
+		pr_err("Failed to bind IPPROTO_SMBDIRECT socket: %d %1pe\n",
 		       ret, ERR_PTR(ret));
 		goto err;
 	}
 
-	ret = smbdirect_socket_listen(sc, 10);
+	ret = kernel_listen(ksmbd_socket, 10);
 	if (ret) {
-		pr_err("Port[%d] smbdirect_socket_listen() failed: %d %1pe\n",
+		pr_err("Port[%d] kernel_listen() error: %d %1pe\n",
 		       port, ret, ERR_PTR(ret));
 		goto err;
 	}
 
 	listener->port = port;
-	listener->socket = sc;
+	listener->sock = ksmbd_socket;
 
 	kthread = kthread_run(smb_direct_listener_kthread_fn,
 			      listener,
@@ -489,7 +510,7 @@ int ksmbd_rdma_init(void)
 	int ret;
 
 	smb_direct_ib_listener = smb_direct_iw_listener = (struct smb_direct_listener) {
-		.socket = NULL,
+		.sock = NULL,
 	};
 
 	ret = smb_direct_listen(&smb_direct_ib_listener,
@@ -499,8 +520,8 @@ int ksmbd_rdma_init(void)
 		goto err;
 	}
 
-	ksmbd_debug(RDMA, "InfiniBand/RoCEv1/RoCEv2 RDMA listener. socket=%p\n",
-		    smb_direct_ib_listener.socket);
+	ksmbd_debug(RDMA, "InfiniBand/RoCEv1/RoCEv2 RDMA listener. sock=%p\n",
+		    smb_direct_ib_listener.sock);
 
 	ret = smb_direct_listen(&smb_direct_iw_listener,
 				SMB_DIRECT_PORT_IWARP);
@@ -509,8 +530,8 @@ int ksmbd_rdma_init(void)
 		goto err;
 	}
 
-	ksmbd_debug(RDMA, "iWarp RDMA listener. socket=%p\n",
-		    smb_direct_iw_listener.socket);
+	ksmbd_debug(RDMA, "iWarp RDMA listener. sock=%p\n",
+		    smb_direct_iw_listener.sock);
 
 	return 0;
 err:
-- 
2.43.0


