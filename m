Return-Path: <linux-rdma+bounces-16932-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id e+wBKaqZk2mj6wEAu9opvQ
	(envelope-from <linux-rdma+bounces-16932-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Feb 2026 23:26:50 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF3E147EC0
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Feb 2026 23:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7791530066B6
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Feb 2026 22:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5355A2D46D6;
	Mon, 16 Feb 2026 22:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FoMsLmms"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127F13C2E;
	Mon, 16 Feb 2026 22:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771280805; cv=none; b=qtAKKkGc3J2GJM/qEXH6qd6r8M5BGZBkp0+CHOVah31jI6Vj3ojG4Wq4o3OEc0uFZ9VgEj1d78+TCmHvPTcZG8pIMQPD34fSgzDDRan1X+TUlKtUF/Fe6piOrCn/FXb9QPFFXt3MvSaHcn2oJtsRP/ODIJWMApeW8uJoMJWrNKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771280805; c=relaxed/simple;
	bh=L1DVbrsGFzyALm0nKzCBtpdVzc8lMjvPzRU08oHWagA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FhCtyUbAHGmOa+C99KfdRgtgax9GcHCZuS3pPGOPJXuoKf1Z+uAJFnmsmUiHwa/ZVcgeQlU1Teozj2V39YqSp9bi07uSCSW//hAPEpurJuxaawX+Id+3+X6IYXiUIWn5RKWChZNyOOqX3aqtsHv3Yottf478zAffJdGMbr6u6Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FoMsLmms; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E852EC116C6;
	Mon, 16 Feb 2026 22:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771280804;
	bh=L1DVbrsGFzyALm0nKzCBtpdVzc8lMjvPzRU08oHWagA=;
	h=From:To:Cc:Subject:Date:From;
	b=FoMsLmmsmMWunKHZt8sS3wdJhJnjy8qoAAbK+RrVLodZIChBuPSfwnHbHK/YsnPA5
	 V89+Nq9ld2pYboOuR9b9AsYMMaMZfEc5Z2c7pndHkNNpySbKxL8hWFv1SERyWq6zNw
	 SUeZmlbnTWexC/Wumdm/w3yCsiOX4lW6jj/xs+/Btw9PdwlqtY2LIrFut/N7/QbmUS
	 EzbsoAp+4GANZx1emB3m9PCTS9c40R0+KSBDhqt6bpzE+rsUbfqQhiXGCY3RvfRnZY
	 zZw3VHlwBVAJsJD6K+B1Dzmc0cUiUeyIszxlXDdtgvq6Tpkf1O51LjGI3DadAFr7c1
	 qAPBUYrrm/q2g==
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
Subject: [PATCH net] net/rds: Fix NULL pointer dereference in rds_tcp_accept_one
Date: Mon, 16 Feb 2026 15:26:43 -0700
Message-ID: <20260216222643.2391390-1-achender@kernel.org>
X-Mailer: git-send-email 2.43.0
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16932-lists,linux-rdma=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[9];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: 3DF3E147EC0
X-Rspamd-Action: no action

Save a local pointer to new_sock->sk and hold a reference before
installing callbacks in rds_tcp_accept_one. After
rds_tcp_set_callbacks() or rds_tcp_reset_callbacks(), tc->t_sock is
set to new_sock which may race with the shutdown path.  A concurrent
rds_tcp_conn_path_shutdown() may call sock_release(), which sets
new_sock->sk = NULL and may eventually free sk when the refcount
reaches zero.

Subsequent accesses to new_sock->sk->sk_state would dereference NULL,
causing the crash. The fix saves a local sk pointer before callbacks
are installed so that sk_state can be accessed safely even after
new_sock->sk is nulled, and uses sock_hold()/sock_put() to ensure
sk itself remains valid for the duration.

Fixes: 826c1004d4ae ("net/rds: rds_tcp_conn_path_shutdown must not discard messages")
Reported-by: syzbot+96046021045ffe6d7709@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=96046021045ffe6d7709
Signed-off-by: Allison Henderson <achender@kernel.org>
---
 net/rds/tcp_listen.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/net/rds/tcp_listen.c b/net/rds/tcp_listen.c
index 6fb5c928b8fd..b4ab68a1da6d 100644
--- a/net/rds/tcp_listen.c
+++ b/net/rds/tcp_listen.c
@@ -177,6 +177,7 @@ int rds_tcp_accept_one(struct rds_tcp_net *rtn)
 	struct rds_tcp_connection *rs_tcp = NULL;
 	int conn_state;
 	struct rds_conn_path *cp;
+	struct sock *sk;
 	struct in6_addr *my_addr, *peer_addr;
 #if !IS_ENABLED(CONFIG_IPV6)
 	struct in6_addr saddr, daddr;
@@ -298,6 +299,17 @@ int rds_tcp_accept_one(struct rds_tcp_net *rtn)
 		rds_conn_path_drop(cp, 0);
 		goto rst_nsk;
 	}
+	/* Save a local pointer to sk and hold a reference before setting
+	 * callbacks. Once callbacks are set, a concurrent
+	 * rds_tcp_conn_path_shutdown() may call sock_release(), which
+	 * sets new_sock->sk to NULL and drops a reference on sk.
+	 * The local pointer lets us safely access sk_state below even
+	 * if new_sock->sk has been nulled, and sock_hold() keeps sk
+	 * itself valid until we are done.
+	 */
+	sk = new_sock->sk;
+	sock_hold(sk);
+
 	if (rs_tcp->t_sock) {
 		/* Duelling SYN has been handled in rds_tcp_accept_one() */
 		rds_tcp_reset_callbacks(new_sock, cp);
@@ -316,13 +328,15 @@ int rds_tcp_accept_one(struct rds_tcp_net *rtn)
 	 * knowing that "rds_tcp_conn_path_shutdown" will
 	 * dequeue pending messages.
 	 */
-	if (new_sock->sk->sk_state == TCP_CLOSE_WAIT ||
-	    new_sock->sk->sk_state == TCP_LAST_ACK ||
-	    new_sock->sk->sk_state == TCP_CLOSE)
+	if (READ_ONCE(sk->sk_state) == TCP_CLOSE_WAIT ||
+	    READ_ONCE(sk->sk_state) == TCP_LAST_ACK ||
+	    READ_ONCE(sk->sk_state) == TCP_CLOSE)
 		rds_conn_path_drop(cp, 0);
 	else
 		queue_delayed_work(cp->cp_wq, &cp->cp_recv_w, 0);
 
+	sock_put(sk);
+
 	new_sock = NULL;
 	ret = 0;
 	if (conn->c_npaths == 0)
-- 
2.43.0


