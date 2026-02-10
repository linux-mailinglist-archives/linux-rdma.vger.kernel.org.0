Return-Path: <linux-rdma+bounces-16699-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMIpK5T2imn2OwAAu9opvQ
	(envelope-from <linux-rdma+bounces-16699-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Feb 2026 10:12:52 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8AA118AE2
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Feb 2026 10:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1F0923038F3F
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Feb 2026 09:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C9E33F8BE;
	Tue, 10 Feb 2026 09:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="olEwCvWv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEF633F390;
	Tue, 10 Feb 2026 09:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770714757; cv=none; b=ATPsO8hg+5Ckh1Ng6INWxlpmhOUOgPl+gYvc/0KXzi439y/gZRt6IdOxIZZCb3Vy4b2DJ68mmGtBrJ9zKmEJHLDmPP53ubwnmMNPPn+5FIGqIUtrw578mxN5HcZWQb8MkXx4UdgZSZIuWdPybahqHINkXCVKXyaYwscCH9gvnEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770714757; c=relaxed/simple;
	bh=ijOCOOs+VBP5e9+pJYzOfq3GJwbZJv9UY/eDzecCYfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FiKgSgre70CsTd4cMqn240ylQjoljDRTO6jy0Jr2YxAr/v8s5pB/3n1BTRBNV2xIp7Qjdb9X5hyL943ha8NQAXsnhla3PWpUgdX9DKH45qP43oL+WCwJI6UF2McPKvSvsiKXv9yAeNhsHf69qi+p8VJaea8yjUoQGjc1EmZic5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=olEwCvWv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40DDEC19425;
	Tue, 10 Feb 2026 09:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770714757;
	bh=ijOCOOs+VBP5e9+pJYzOfq3GJwbZJv9UY/eDzecCYfU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=olEwCvWvwW+FwfKc1ETSzPFZfFDxqpqPzYsgNkSgblY/pGNY6VK2yZESgNRN+QOqw
	 9pzkkf3egln2f/tr8iLS3sXSXAooDYzGmJx3+nmVXFAU6fv1pMNhAJEJiMe7XWM8gC
	 1rZQrf7UkseQoijwUGTo+0ky3cfbNuzWCrTAcf95bsolL+WFjSCQnogNXLGtD8xYFU
	 TgbA0qKIuNUY/ty2UHadfLlwVk3PHi+gptv2yaV+7ey3L01xQBecEGSt5gBMaLDrY4
	 qwpjbot3fG/+odDmAWj9snaOCN1CpYhaQcQDK1PltwYNDllzdQrOFn1AoADoSu1w3C
	 OhJhiRJ1Awm9A==
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
Subject: [PATCH net-next v3 1/4] net/rds: Fix NULL pointer dereference in rds_tcp_accept_one
Date: Tue, 10 Feb 2026 02:12:32 -0700
Message-ID: <20260210091235.1817860-2-achender@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260210091235.1817860-1-achender@kernel.org>
References: <20260210091235.1817860-1-achender@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16699-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,appspotmail.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6E8AA118AE2
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


