Return-Path: <linux-rdma+bounces-16772-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJSoFxRmjWlI2AAAu9opvQ
	(envelope-from <linux-rdma+bounces-16772-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Feb 2026 06:33:08 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0075012A72E
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Feb 2026 06:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10FC9312E1B7
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Feb 2026 05:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8931E2877F7;
	Thu, 12 Feb 2026 05:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcst5Qy6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEE028751D;
	Thu, 12 Feb 2026 05:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770874353; cv=none; b=OQMs4iultR7T4APw0U//dQG+PsfrN1fRtsuiuQZ5czspVU9w34mAdx52kmkcSnWSXLHfKSf2qMRDSAl0SF1LoGCGSmlO94l/T+ZB2a3WjZpKICfuEoVUMp+K3ezXJCBp4WkGVt0uHjWn3B+y0O2XwlBlx71GZbw5zuZjZSfEfXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770874353; c=relaxed/simple;
	bh=ijOCOOs+VBP5e9+pJYzOfq3GJwbZJv9UY/eDzecCYfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mi0Gg2cATmO3U/DNMn9XLClcbAPGFiMmA1bwY7tNYZpIn+oGOnvvfAG6t0jitOWviqOqcV+K5QcCckkLPj1i9I0PNLRbJfhWqoDi0b+kLZnoXYCo7V9AG5/exQzV7cGzIXWDzaUGwQrc4vY1tqG59Y6lgTL19Ui65JuqtwPckSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kcst5Qy6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C6E2C19421;
	Thu, 12 Feb 2026 05:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770874353;
	bh=ijOCOOs+VBP5e9+pJYzOfq3GJwbZJv9UY/eDzecCYfU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kcst5Qy6v3jTqUFmOJ9iP0jv9PxDBoQMSjW87r6iHz2gGM5drdHICLdXYXi+gAotx
	 gMbDf1Ydl5I1jVGkg7Rhy48hFb60QK8wuCVQNFafLg7Y6wBn9CopdLD6qEaY3PG9rr
	 N0h/ZKUN/z6t41e8qAbmnEZhcpzwm07lo/T/li0JA6WJUrbZ9vEpjLmtM28J+l+pLE
	 EP7robqfXYUdRTwqReZx/KKSBn9ugempTollPKw+3QkdjQDG29zbvjeCi5kWr1/liW
	 O6G/Tr7gk8xVqV84qiZ5WxbwR5oNCeDOBkrNW3jPWdW5InU07ttHCPPOyjXLgWs+rk
	 ivfC0HLe/yf1g==
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
Subject: [PATCH net-next v4 1/4] net/rds: Fix NULL pointer dereference in rds_tcp_accept_one
Date: Wed, 11 Feb 2026 22:32:27 -0700
Message-ID: <20260212053230.1921241-2-achender@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260212053230.1921241-1-achender@kernel.org>
References: <20260212053230.1921241-1-achender@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16772-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: 0075012A72E
X-Rspamd-Action: no action

Hold a local reference to new_sock->sk before installing callbacks
in rds_tcp_accept_one. After rds_tcp_set_callbacks() or
rds_tcp_reset_callbacks(), tc->t_sock is set to new_sock which
may race with the shutdown path.  A concurrent
rds_tcp_conn_path_shutdown() may call sock_release(), which sets
new_sock->sk = NULL and frees sk.

Subsequent accesses to new_sock->sk->sk_state dereference NULL,
causing the null dereference. So a local sock reference with
sock_hold() before installing callbacks will prevent the race.

Fixes: 826c1004d4ae ("net/rds: rds_tcp_conn_path_shutdown must not discard messages")
Reported-by: syzbot+96046021045ffe6d7709@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=96046021045ffe6d7709
Signed-off-by: Allison Henderson <achender@kernel.org>
---
 net/rds/tcp_listen.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/net/rds/tcp_listen.c b/net/rds/tcp_listen.c
index 6fb5c928b8fd..cdc86473a1ba 100644
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
@@ -298,6 +299,14 @@ int rds_tcp_accept_one(struct rds_tcp_net *rtn)
 		rds_conn_path_drop(cp, 0);
 		goto rst_nsk;
 	}
+	/* Hold a local reference to sk before setting callbacks. Once callbacks
+	 * are set, it is possible for a concurrent rds_tcp_conn_path_shutdown
+	 * call to release the new_sock->sk and set it to NULL.  So we use
+	 * a local sk here to avoid racing with callbacks
+	 */
+	sk = new_sock->sk;
+	sock_hold(sk);
+
 	if (rs_tcp->t_sock) {
 		/* Duelling SYN has been handled in rds_tcp_accept_one() */
 		rds_tcp_reset_callbacks(new_sock, cp);
@@ -316,13 +325,15 @@ int rds_tcp_accept_one(struct rds_tcp_net *rtn)
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


