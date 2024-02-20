Return-Path: <linux-rdma+bounces-1051-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFAAF85B35F
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Feb 2024 08:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A618B216AF
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Feb 2024 07:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8B25A11C;
	Tue, 20 Feb 2024 07:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="X8rUuBmV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EA35A0EC;
	Tue, 20 Feb 2024 07:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708412517; cv=none; b=OF2DkH9vnFu9nnz8yBlLgpF4s0jGYKtclZQFN6GYTk9uh6GxVoC7XhvLM5SRJUjFfVV/ej5tLhjO0xm20DJlFhMSFLeXhHsMAhgtL9W/ga55EdzxFx0BmLO9jH2BfacRCxDjY8/c8PYgjDSmyKBeXNbr+E57Qqq7i6HaThlTw0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708412517; c=relaxed/simple;
	bh=zztptK6/enp6zp3WltsgDWhkOi40dsLromLKXWt3ZE4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=OM9uNLmd1wliwrKuYthTw1wVZa51aS2WJNQYiordTtgHQHHlqaFHjtRy5LEdKrdSQ9ZuzqPohGOADMvl3zVnPOoxKQukRqXi8Lo9qGTXlhllc/g9AOzhD4XmsobW8kJm0gtgUVMe/baXtFmcMYSupDCqEREGcjj6q8L7m1WSTXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=X8rUuBmV; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708412511; h=From:To:Subject:Date:Message-Id;
	bh=z0rBls4/DVw7umnR4vhKntk5sCoGWjqNnpPfFi4kifc=;
	b=X8rUuBmVlmZGhTAMu4DGnWi0NgZQ2kYUxsiBbTAWrGDcb1luPPERgi6WTAaxDCzbcnemZ3fW6qLVuzMdv0TBPVIMO8DhrxgqUhiUcae50AqonRhQRUmqw1b3eFVBoNdbYR4bvJ6K2L7OH+G3ow1jIM4Xc4HT0TYFus5/lyjQ5Ho=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W0vuXdQ_1708412510;
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0W0vuXdQ_1708412510)
          by smtp.aliyun-inc.com;
          Tue, 20 Feb 2024 15:01:50 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com>
To: kgraul@linux.ibm.com,
	wenjia@linux.ibm.com,
	jaka@linux.ibm.com,
	wintera@linux.ibm.com,
	guwen@linux.alibaba.com
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	tonylu@linux.alibaba.com,
	pabeni@redhat.com,
	edumazet@google.com
Subject: [RFC net-next 02/20] net/smc: read&write sock state via unified macros
Date: Tue, 20 Feb 2024 15:01:27 +0800
Message-Id: <1708412505-34470-3-git-send-email-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1708412505-34470-1-git-send-email-alibuda@linux.alibaba.com>
References: <1708412505-34470-1-git-send-email-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: "D. Wythe" <alibuda@linux.alibaba.com>

In order to merge SMC sock and TCP sock, the state field of sock will be
shared by TCP protocol stack and SMC protocol statck. Unfortunately,
the state defined by SMC coincides with state defined in TCP.

Easier way is to redefine the state of SMC sock, however, this will
confuse some of smc tools because they are using the old
state definition.

So we have to use a new field for SMC implementation to read and write
status after merging sock, In consideration of compatibility and subsequent
extensibility, we decied to make all read & write operations related to
be replaced by a unified macro. In this way, we can just modify this macro
to switch state access between different fields.

This patch only goes into code reorganization, replacing all read and
write operations on socks state with unified macros. In theory, it should
have no impact on anything, and all subsequent reading or writing
operations on state should via it.

Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
---
 net/smc/af_smc.c    | 195 ++++++++++++++++++++++++++--------------------------
 net/smc/smc.h       |   3 +
 net/smc/smc_close.c |  98 +++++++++++++-------------
 net/smc/smc_core.c  |  24 +++----
 net/smc/smc_diag.c  |   2 +-
 net/smc/smc_rx.c    |  16 ++---
 net/smc/smc_tx.c    |   2 +-
 7 files changed, 171 insertions(+), 169 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 4b52b3b..bdb6dd7 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -278,16 +278,16 @@ static int __smc_release(struct smc_sock *smc)
 		smc_sock_set_flag(sk, SOCK_DEAD);
 		sk->sk_shutdown |= SHUTDOWN_MASK;
 	} else {
-		if (sk->sk_state != SMC_CLOSED) {
-			if (sk->sk_state != SMC_LISTEN &&
-			    sk->sk_state != SMC_INIT)
+		if (smc_sk_state(sk) != SMC_CLOSED) {
+			if (smc_sk_state(sk) != SMC_LISTEN &&
+			    smc_sk_state(sk) != SMC_INIT)
 				sock_put(sk); /* passive closing */
-			if (sk->sk_state == SMC_LISTEN) {
+			if (smc_sk_state(sk) == SMC_LISTEN) {
 				/* wake up clcsock accept */
 				rc = kernel_sock_shutdown(smc->clcsock,
 							  SHUT_RDWR);
 			}
-			sk->sk_state = SMC_CLOSED;
+			smc_sk_set_state(sk, SMC_CLOSED);
 			sk->sk_state_change(sk);
 		}
 		smc_restore_fallback_changes(smc);
@@ -295,7 +295,7 @@ static int __smc_release(struct smc_sock *smc)
 
 	sk->sk_prot->unhash(sk);
 
-	if (sk->sk_state == SMC_CLOSED) {
+	if (smc_sk_state(sk) == SMC_CLOSED) {
 		if (smc->clcsock) {
 			release_sock(sk);
 			smc_clcsock_release(smc);
@@ -320,7 +320,7 @@ static int smc_release(struct socket *sock)
 	sock_hold(sk); /* sock_put below */
 	smc = smc_sk(sk);
 
-	old_state = sk->sk_state;
+	old_state = smc_sk_state(sk);
 
 	/* cleanup for a dangling non-blocking connect */
 	if (smc->connect_nonblock && old_state == SMC_INIT)
@@ -329,7 +329,7 @@ static int smc_release(struct socket *sock)
 	if (cancel_work_sync(&smc->connect_work))
 		sock_put(&smc->sk); /* sock_hold in smc_connect for passive closing */
 
-	if (sk->sk_state == SMC_LISTEN)
+	if (smc_sk_state(sk) == SMC_LISTEN)
 		/* smc_close_non_accepted() is called and acquires
 		 * sock lock for child sockets again
 		 */
@@ -337,7 +337,7 @@ static int smc_release(struct socket *sock)
 	else
 		lock_sock(sk);
 
-	if (old_state == SMC_INIT && sk->sk_state == SMC_ACTIVE &&
+	if (old_state == SMC_INIT && smc_sk_state(sk) == SMC_ACTIVE &&
 	    !smc->use_fallback)
 		smc_close_active_abort(smc);
 
@@ -356,7 +356,7 @@ static int smc_release(struct socket *sock)
 
 static void smc_destruct(struct sock *sk)
 {
-	if (sk->sk_state != SMC_CLOSED)
+	if (smc_sk_state(sk) != SMC_CLOSED)
 		return;
 	if (!sock_flag(sk, SOCK_DEAD))
 		return;
@@ -375,7 +375,7 @@ static struct sock *smc_sock_alloc(struct net *net, struct socket *sock,
 		return NULL;
 
 	sock_init_data(sock, sk); /* sets sk_refcnt to 1 */
-	sk->sk_state = SMC_INIT;
+	smc_sk_set_state(sk, SMC_INIT);
 	sk->sk_destruct = smc_destruct;
 	sk->sk_protocol = protocol;
 	WRITE_ONCE(sk->sk_sndbuf, 2 * READ_ONCE(net->smc.sysctl_wmem));
@@ -423,7 +423,7 @@ static int smc_bind(struct socket *sock, struct sockaddr *uaddr,
 
 	/* Check if socket is already active */
 	rc = -EINVAL;
-	if (sk->sk_state != SMC_INIT || smc->connect_nonblock)
+	if (smc_sk_state(sk) != SMC_INIT || smc->connect_nonblock)
 		goto out_rel;
 
 	smc->clcsock->sk->sk_reuse = sk->sk_reuse;
@@ -946,14 +946,14 @@ static int smc_connect_fallback(struct smc_sock *smc, int reason_code)
 	rc = smc_switch_to_fallback(smc, reason_code);
 	if (rc) { /* fallback fails */
 		this_cpu_inc(net->smc.smc_stats->clnt_hshake_err_cnt);
-		if (smc->sk.sk_state == SMC_INIT)
+		if (smc_sk_state(&smc->sk) == SMC_INIT)
 			sock_put(&smc->sk); /* passive closing */
 		return rc;
 	}
 	smc_copy_sock_settings_to_clc(smc);
 	smc->connect_nonblock = 0;
-	if (smc->sk.sk_state == SMC_INIT)
-		smc->sk.sk_state = SMC_ACTIVE;
+	if (smc_sk_state(&smc->sk) == SMC_INIT)
+		smc_sk_set_state(&smc->sk, SMC_ACTIVE);
 	return 0;
 }
 
@@ -966,7 +966,7 @@ static int smc_connect_decline_fallback(struct smc_sock *smc, int reason_code,
 
 	if (reason_code < 0) { /* error, fallback is not possible */
 		this_cpu_inc(net->smc.smc_stats->clnt_hshake_err_cnt);
-		if (smc->sk.sk_state == SMC_INIT)
+		if (smc_sk_state(&smc->sk) == SMC_INIT)
 			sock_put(&smc->sk); /* passive closing */
 		return reason_code;
 	}
@@ -974,7 +974,7 @@ static int smc_connect_decline_fallback(struct smc_sock *smc, int reason_code,
 		rc = smc_clc_send_decline(smc, reason_code, version);
 		if (rc < 0) {
 			this_cpu_inc(net->smc.smc_stats->clnt_hshake_err_cnt);
-			if (smc->sk.sk_state == SMC_INIT)
+			if (smc_sk_state(&smc->sk) == SMC_INIT)
 				sock_put(&smc->sk); /* passive closing */
 			return rc;
 		}
@@ -1357,8 +1357,8 @@ static int smc_connect_rdma(struct smc_sock *smc,
 
 	smc_copy_sock_settings_to_clc(smc);
 	smc->connect_nonblock = 0;
-	if (smc->sk.sk_state == SMC_INIT)
-		smc->sk.sk_state = SMC_ACTIVE;
+	if (smc_sk_state(&smc->sk) == SMC_INIT)
+		smc_sk_set_state(&smc->sk, SMC_ACTIVE);
 
 	return 0;
 connect_abort:
@@ -1452,8 +1452,8 @@ static int smc_connect_ism(struct smc_sock *smc,
 
 	smc_copy_sock_settings_to_clc(smc);
 	smc->connect_nonblock = 0;
-	if (smc->sk.sk_state == SMC_INIT)
-		smc->sk.sk_state = SMC_ACTIVE;
+	if (smc_sk_state(&smc->sk) == SMC_INIT)
+		smc_sk_set_state(&smc->sk, SMC_ACTIVE);
 
 	return 0;
 connect_abort:
@@ -1607,7 +1607,7 @@ static void smc_connect_work(struct work_struct *work)
 	release_sock(smc->clcsock->sk);
 	lock_sock(&smc->sk);
 	if (rc != 0 || smc->sk.sk_err) {
-		smc->sk.sk_state = SMC_CLOSED;
+		smc_sk_set_state(&smc->sk, SMC_CLOSED);
 		if (rc == -EPIPE || rc == -EAGAIN)
 			smc->sk.sk_err = EPIPE;
 		else if (rc == -ECONNREFUSED)
@@ -1655,10 +1655,10 @@ static int smc_connect(struct socket *sock, struct sockaddr *addr,
 		rc = -EINVAL;
 		goto out;
 	case SS_CONNECTED:
-		rc = sk->sk_state == SMC_ACTIVE ? -EISCONN : -EINVAL;
+		rc = smc_sk_state(sk) == SMC_ACTIVE ? -EISCONN : -EINVAL;
 		goto out;
 	case SS_CONNECTING:
-		if (sk->sk_state == SMC_ACTIVE)
+		if (smc_sk_state(sk) == SMC_ACTIVE)
 			goto connected;
 		break;
 	case SS_UNCONNECTED:
@@ -1666,7 +1666,7 @@ static int smc_connect(struct socket *sock, struct sockaddr *addr,
 		break;
 	}
 
-	switch (sk->sk_state) {
+	switch (smc_sk_state(sk)) {
 	default:
 		goto out;
 	case SMC_CLOSED:
@@ -1740,11 +1740,11 @@ static int smc_clcsock_accept(struct smc_sock *lsmc, struct smc_sock **new_smc)
 	lock_sock(lsk);
 	if  (rc < 0 && rc != -EAGAIN)
 		lsk->sk_err = -rc;
-	if (rc < 0 || lsk->sk_state == SMC_CLOSED) {
+	if (rc < 0 || smc_sk_state(lsk) == SMC_CLOSED) {
 		new_sk->sk_prot->unhash(new_sk);
 		if (new_clcsock)
 			sock_release(new_clcsock);
-		new_sk->sk_state = SMC_CLOSED;
+		smc_sk_set_state(new_sk, SMC_CLOSED);
 		smc_sock_set_flag(new_sk, SOCK_DEAD);
 		sock_put(new_sk); /* final */
 		*new_smc = NULL;
@@ -1812,7 +1812,7 @@ struct sock *smc_accept_dequeue(struct sock *parent,
 		new_sk = (struct sock *)isk;
 
 		smc_accept_unlink(new_sk);
-		if (new_sk->sk_state == SMC_CLOSED) {
+		if (smc_sk_state(new_sk) == SMC_CLOSED) {
 			new_sk->sk_prot->unhash(new_sk);
 			if (isk->clcsock) {
 				sock_release(isk->clcsock);
@@ -1911,7 +1911,7 @@ static void smc_listen_out(struct smc_sock *new_smc)
 	if (tcp_sk(new_smc->clcsock->sk)->syn_smc)
 		atomic_dec(&lsmc->queued_smc_hs);
 
-	if (lsmc->sk.sk_state == SMC_LISTEN) {
+	if (smc_sk_state(&lsmc->sk) == SMC_LISTEN) {
 		lock_sock_nested(&lsmc->sk, SINGLE_DEPTH_NESTING);
 		smc_accept_enqueue(&lsmc->sk, newsmcsk);
 		release_sock(&lsmc->sk);
@@ -1929,8 +1929,8 @@ static void smc_listen_out_connected(struct smc_sock *new_smc)
 {
 	struct sock *newsmcsk = &new_smc->sk;
 
-	if (newsmcsk->sk_state == SMC_INIT)
-		newsmcsk->sk_state = SMC_ACTIVE;
+	if (smc_sk_state(newsmcsk) == SMC_INIT)
+		smc_sk_set_state(newsmcsk, SMC_ACTIVE);
 
 	smc_listen_out(new_smc);
 }
@@ -1942,9 +1942,9 @@ static void smc_listen_out_err(struct smc_sock *new_smc)
 	struct net *net = sock_net(newsmcsk);
 
 	this_cpu_inc(net->smc.smc_stats->srv_hshake_err_cnt);
-	if (newsmcsk->sk_state == SMC_INIT)
+	if (smc_sk_state(newsmcsk) == SMC_INIT)
 		sock_put(&new_smc->sk); /* passive closing */
-	newsmcsk->sk_state = SMC_CLOSED;
+	smc_sk_set_state(newsmcsk, SMC_CLOSED);
 
 	smc_listen_out(new_smc);
 }
@@ -2432,7 +2432,7 @@ static void smc_listen_work(struct work_struct *work)
 	u8 accept_version;
 	int rc = 0;
 
-	if (new_smc->listen_smc->sk.sk_state != SMC_LISTEN)
+	if (smc_sk_state(&new_smc->listen_smc->sk) != SMC_LISTEN)
 		return smc_listen_out_err(new_smc);
 
 	if (new_smc->use_fallback) {
@@ -2564,7 +2564,7 @@ static void smc_tcp_listen_work(struct work_struct *work)
 	int rc = 0;
 
 	lock_sock(lsk);
-	while (lsk->sk_state == SMC_LISTEN) {
+	while (smc_sk_state(lsk) == SMC_LISTEN) {
 		rc = smc_clcsock_accept(lsmc, &new_smc);
 		if (rc) /* clcsock accept queue empty or error */
 			goto out;
@@ -2599,7 +2599,7 @@ static void smc_clcsock_data_ready(struct sock *listen_clcsock)
 	if (!lsmc)
 		goto out;
 	lsmc->clcsk_data_ready(listen_clcsock);
-	if (lsmc->sk.sk_state == SMC_LISTEN) {
+	if (smc_sk_state(&lsmc->sk) == SMC_LISTEN) {
 		sock_hold(&lsmc->sk); /* sock_put in smc_tcp_listen_work() */
 		if (!queue_work(smc_tcp_ls_wq, &lsmc->tcp_listen_work))
 			sock_put(&lsmc->sk);
@@ -2618,12 +2618,12 @@ static int smc_listen(struct socket *sock, int backlog)
 	lock_sock(sk);
 
 	rc = -EINVAL;
-	if ((sk->sk_state != SMC_INIT && sk->sk_state != SMC_LISTEN) ||
+	if ((smc_sk_state(sk) != SMC_INIT && smc_sk_state(sk) != SMC_LISTEN) ||
 	    smc->connect_nonblock || sock->state != SS_UNCONNECTED)
 		goto out;
 
 	rc = 0;
-	if (sk->sk_state == SMC_LISTEN) {
+	if (smc_sk_state(sk) == SMC_LISTEN) {
 		sk->sk_max_ack_backlog = backlog;
 		goto out;
 	}
@@ -2666,7 +2666,7 @@ static int smc_listen(struct socket *sock, int backlog)
 	}
 	sk->sk_max_ack_backlog = backlog;
 	sk->sk_ack_backlog = 0;
-	sk->sk_state = SMC_LISTEN;
+	smc_sk_set_state(sk, SMC_LISTEN);
 
 out:
 	release_sock(sk);
@@ -2686,7 +2686,7 @@ static int smc_accept(struct socket *sock, struct socket *new_sock,
 	sock_hold(sk); /* sock_put below */
 	lock_sock(sk);
 
-	if (lsmc->sk.sk_state != SMC_LISTEN) {
+	if (smc_sk_state(&lsmc->sk) != SMC_LISTEN) {
 		rc = -EINVAL;
 		release_sock(sk);
 		goto out;
@@ -2748,8 +2748,8 @@ static int smc_getname(struct socket *sock, struct sockaddr *addr,
 {
 	struct smc_sock *smc;
 
-	if (peer && (sock->sk->sk_state != SMC_ACTIVE) &&
-	    (sock->sk->sk_state != SMC_APPCLOSEWAIT1))
+	if (peer && (smc_sk_state(sock->sk) != SMC_ACTIVE) &&
+	    (smc_sk_state(sock->sk) != SMC_APPCLOSEWAIT1))
 		return -ENOTCONN;
 
 	smc = smc_sk(sock->sk);
@@ -2769,7 +2769,7 @@ static int smc_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 	/* SMC does not support connect with fastopen */
 	if (msg->msg_flags & MSG_FASTOPEN) {
 		/* not connected yet, fallback */
-		if (sk->sk_state == SMC_INIT && !smc->connect_nonblock) {
+		if (smc_sk_state(sk) == SMC_INIT && !smc->connect_nonblock) {
 			rc = smc_switch_to_fallback(smc, SMC_CLC_DECL_OPTUNSUPP);
 			if (rc)
 				goto out;
@@ -2777,9 +2777,9 @@ static int smc_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 			rc = -EINVAL;
 			goto out;
 		}
-	} else if ((sk->sk_state != SMC_ACTIVE) &&
-		   (sk->sk_state != SMC_APPCLOSEWAIT1) &&
-		   (sk->sk_state != SMC_INIT)) {
+	} else if ((smc_sk_state(sk) != SMC_ACTIVE) &&
+		   (smc_sk_state(sk) != SMC_APPCLOSEWAIT1) &&
+		   (smc_sk_state(sk) != SMC_INIT)) {
 		rc = -EPIPE;
 		goto out;
 	}
@@ -2804,17 +2804,17 @@ static int smc_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 
 	smc = smc_sk(sk);
 	lock_sock(sk);
-	if (sk->sk_state == SMC_CLOSED && (sk->sk_shutdown & RCV_SHUTDOWN)) {
+	if (smc_sk_state(sk) == SMC_CLOSED && (sk->sk_shutdown & RCV_SHUTDOWN)) {
 		/* socket was connected before, no more data to read */
 		rc = 0;
 		goto out;
 	}
-	if ((sk->sk_state == SMC_INIT) ||
-	    (sk->sk_state == SMC_LISTEN) ||
-	    (sk->sk_state == SMC_CLOSED))
+	if ((smc_sk_state(sk) == SMC_INIT) ||
+	    (smc_sk_state(sk) == SMC_LISTEN) ||
+	    (smc_sk_state(sk) == SMC_CLOSED))
 		goto out;
 
-	if (sk->sk_state == SMC_PEERFINCLOSEWAIT) {
+	if (smc_sk_state(sk) == SMC_PEERFINCLOSEWAIT) {
 		rc = 0;
 		goto out;
 	}
@@ -2861,14 +2861,14 @@ static __poll_t smc_poll(struct file *file, struct socket *sock,
 		mask = smc->clcsock->ops->poll(file, smc->clcsock, wait);
 		sk->sk_err = smc->clcsock->sk->sk_err;
 	} else {
-		if (sk->sk_state != SMC_CLOSED)
+		if (smc_sk_state(sk) != SMC_CLOSED)
 			sock_poll_wait(file, sock, wait);
 		if (sk->sk_err)
 			mask |= EPOLLERR;
 		if ((sk->sk_shutdown == SHUTDOWN_MASK) ||
-		    (sk->sk_state == SMC_CLOSED))
+		    (smc_sk_state(sk) == SMC_CLOSED))
 			mask |= EPOLLHUP;
-		if (sk->sk_state == SMC_LISTEN) {
+		if (smc_sk_state(sk) == SMC_LISTEN) {
 			/* woken up by sk_data_ready in smc_listen_work() */
 			mask |= smc_accept_poll(sk);
 		} else if (smc->use_fallback) { /* as result of connect_work()*/
@@ -2876,7 +2876,7 @@ static __poll_t smc_poll(struct file *file, struct socket *sock,
 							   wait);
 			sk->sk_err = smc->clcsock->sk->sk_err;
 		} else {
-			if ((sk->sk_state != SMC_INIT &&
+			if ((smc_sk_state(sk) != SMC_INIT &&
 			     atomic_read(&smc->conn.sndbuf_space)) ||
 			    sk->sk_shutdown & SEND_SHUTDOWN) {
 				mask |= EPOLLOUT | EPOLLWRNORM;
@@ -2888,7 +2888,7 @@ static __poll_t smc_poll(struct file *file, struct socket *sock,
 				mask |= EPOLLIN | EPOLLRDNORM;
 			if (sk->sk_shutdown & RCV_SHUTDOWN)
 				mask |= EPOLLIN | EPOLLRDNORM | EPOLLRDHUP;
-			if (sk->sk_state == SMC_APPCLOSEWAIT1)
+			if (smc_sk_state(sk) == SMC_APPCLOSEWAIT1)
 				mask |= EPOLLIN;
 			if (smc->conn.urg_state == SMC_URG_VALID)
 				mask |= EPOLLPRI;
@@ -2915,29 +2915,29 @@ static int smc_shutdown(struct socket *sock, int how)
 	lock_sock(sk);
 
 	if (sock->state == SS_CONNECTING) {
-		if (sk->sk_state == SMC_ACTIVE)
+		if (smc_sk_state(sk) == SMC_ACTIVE)
 			sock->state = SS_CONNECTED;
-		else if (sk->sk_state == SMC_PEERCLOSEWAIT1 ||
-			 sk->sk_state == SMC_PEERCLOSEWAIT2 ||
-			 sk->sk_state == SMC_APPCLOSEWAIT1 ||
-			 sk->sk_state == SMC_APPCLOSEWAIT2 ||
-			 sk->sk_state == SMC_APPFINCLOSEWAIT)
+		else if (smc_sk_state(sk) == SMC_PEERCLOSEWAIT1 ||
+			 smc_sk_state(sk) == SMC_PEERCLOSEWAIT2 ||
+			 smc_sk_state(sk) == SMC_APPCLOSEWAIT1 ||
+			 smc_sk_state(sk) == SMC_APPCLOSEWAIT2 ||
+			 smc_sk_state(sk) == SMC_APPFINCLOSEWAIT)
 			sock->state = SS_DISCONNECTING;
 	}
 
 	rc = -ENOTCONN;
-	if ((sk->sk_state != SMC_ACTIVE) &&
-	    (sk->sk_state != SMC_PEERCLOSEWAIT1) &&
-	    (sk->sk_state != SMC_PEERCLOSEWAIT2) &&
-	    (sk->sk_state != SMC_APPCLOSEWAIT1) &&
-	    (sk->sk_state != SMC_APPCLOSEWAIT2) &&
-	    (sk->sk_state != SMC_APPFINCLOSEWAIT))
+	if ((smc_sk_state(sk) != SMC_ACTIVE) &&
+	    (smc_sk_state(sk) != SMC_PEERCLOSEWAIT1) &&
+	    (smc_sk_state(sk) != SMC_PEERCLOSEWAIT2) &&
+	    (smc_sk_state(sk) != SMC_APPCLOSEWAIT1) &&
+	    (smc_sk_state(sk) != SMC_APPCLOSEWAIT2) &&
+	    (smc_sk_state(sk) != SMC_APPFINCLOSEWAIT))
 		goto out;
 	if (smc->use_fallback) {
 		rc = kernel_sock_shutdown(smc->clcsock, how);
 		sk->sk_shutdown = smc->clcsock->sk->sk_shutdown;
 		if (sk->sk_shutdown == SHUTDOWN_MASK) {
-			sk->sk_state = SMC_CLOSED;
+			smc_sk_set_state(sk, SMC_CLOSED);
 			sk->sk_socket->state = SS_UNCONNECTED;
 			sock_put(sk);
 		}
@@ -2945,10 +2945,10 @@ static int smc_shutdown(struct socket *sock, int how)
 	}
 	switch (how) {
 	case SHUT_RDWR:		/* shutdown in both directions */
-		old_state = sk->sk_state;
+		old_state = smc_sk_state(sk);
 		rc = smc_close_active(smc);
 		if (old_state == SMC_ACTIVE &&
-		    sk->sk_state == SMC_PEERCLOSEWAIT1)
+		    smc_sk_state(sk) == SMC_PEERCLOSEWAIT1)
 			do_shutdown = false;
 		break;
 	case SHUT_WR:
@@ -2964,7 +2964,7 @@ static int smc_shutdown(struct socket *sock, int how)
 	/* map sock_shutdown_cmd constants to sk_shutdown value range */
 	sk->sk_shutdown |= how + 1;
 
-	if (sk->sk_state == SMC_CLOSED)
+	if (smc_sk_state(sk) == SMC_CLOSED)
 		sock->state = SS_UNCONNECTED;
 	else
 		sock->state = SS_DISCONNECTING;
@@ -3085,16 +3085,15 @@ static int smc_setsockopt(struct socket *sock, int level, int optname,
 	case TCP_FASTOPEN_KEY:
 	case TCP_FASTOPEN_NO_COOKIE:
 		/* option not supported by SMC */
-		if (sk->sk_state == SMC_INIT && !smc->connect_nonblock) {
+		if (smc_sk_state(sk) == SMC_INIT && !smc->connect_nonblock)
 			rc = smc_switch_to_fallback(smc, SMC_CLC_DECL_OPTUNSUPP);
-		} else {
+		else
 			rc = -EINVAL;
-		}
 		break;
 	case TCP_NODELAY:
-		if (sk->sk_state != SMC_INIT &&
-		    sk->sk_state != SMC_LISTEN &&
-		    sk->sk_state != SMC_CLOSED) {
+		if (smc_sk_state(sk) != SMC_INIT &&
+		    smc_sk_state(sk) != SMC_LISTEN &&
+		    smc_sk_state(sk) != SMC_CLOSED) {
 			if (val) {
 				SMC_STAT_INC(smc, ndly_cnt);
 				smc_tx_pending(&smc->conn);
@@ -3103,9 +3102,9 @@ static int smc_setsockopt(struct socket *sock, int level, int optname,
 		}
 		break;
 	case TCP_CORK:
-		if (sk->sk_state != SMC_INIT &&
-		    sk->sk_state != SMC_LISTEN &&
-		    sk->sk_state != SMC_CLOSED) {
+		if (smc_sk_state(sk) != SMC_INIT &&
+		    smc_sk_state(sk) != SMC_LISTEN &&
+		    smc_sk_state(sk) != SMC_CLOSED) {
 			if (!val) {
 				SMC_STAT_INC(smc, cork_cnt);
 				smc_tx_pending(&smc->conn);
@@ -3173,24 +3172,24 @@ static int smc_ioctl(struct socket *sock, unsigned int cmd,
 	}
 	switch (cmd) {
 	case SIOCINQ: /* same as FIONREAD */
-		if (smc->sk.sk_state == SMC_LISTEN) {
+		if (smc_sk_state(&smc->sk) == SMC_LISTEN) {
 			release_sock(&smc->sk);
 			return -EINVAL;
 		}
-		if (smc->sk.sk_state == SMC_INIT ||
-		    smc->sk.sk_state == SMC_CLOSED)
+		if (smc_sk_state(&smc->sk) == SMC_INIT ||
+		    smc_sk_state(&smc->sk) == SMC_CLOSED)
 			answ = 0;
 		else
 			answ = atomic_read(&smc->conn.bytes_to_rcv);
 		break;
 	case SIOCOUTQ:
 		/* output queue size (not send + not acked) */
-		if (smc->sk.sk_state == SMC_LISTEN) {
+		if (smc_sk_state(&smc->sk) == SMC_LISTEN) {
 			release_sock(&smc->sk);
 			return -EINVAL;
 		}
-		if (smc->sk.sk_state == SMC_INIT ||
-		    smc->sk.sk_state == SMC_CLOSED)
+		if (smc_sk_state(&smc->sk) == SMC_INIT ||
+		    smc_sk_state(&smc->sk) == SMC_CLOSED)
 			answ = 0;
 		else
 			answ = smc->conn.sndbuf_desc->len -
@@ -3198,23 +3197,23 @@ static int smc_ioctl(struct socket *sock, unsigned int cmd,
 		break;
 	case SIOCOUTQNSD:
 		/* output queue size (not send only) */
-		if (smc->sk.sk_state == SMC_LISTEN) {
+		if (smc_sk_state(&smc->sk) == SMC_LISTEN) {
 			release_sock(&smc->sk);
 			return -EINVAL;
 		}
-		if (smc->sk.sk_state == SMC_INIT ||
-		    smc->sk.sk_state == SMC_CLOSED)
+		if (smc_sk_state(&smc->sk) == SMC_INIT ||
+		    smc_sk_state(&smc->sk) == SMC_CLOSED)
 			answ = 0;
 		else
 			answ = smc_tx_prepared_sends(&smc->conn);
 		break;
 	case SIOCATMARK:
-		if (smc->sk.sk_state == SMC_LISTEN) {
+		if (smc_sk_state(&smc->sk) == SMC_LISTEN) {
 			release_sock(&smc->sk);
 			return -EINVAL;
 		}
-		if (smc->sk.sk_state == SMC_INIT ||
-		    smc->sk.sk_state == SMC_CLOSED) {
+		if (smc_sk_state(&smc->sk) == SMC_INIT ||
+		    smc_sk_state(&smc->sk) == SMC_CLOSED) {
 			answ = 0;
 		} else {
 			smc_curs_copy(&cons, &conn->local_tx_ctrl.cons, conn);
@@ -3248,17 +3247,17 @@ static ssize_t smc_splice_read(struct socket *sock, loff_t *ppos,
 
 	smc = smc_sk(sk);
 	lock_sock(sk);
-	if (sk->sk_state == SMC_CLOSED && (sk->sk_shutdown & RCV_SHUTDOWN)) {
+	if (smc_sk_state(sk) == SMC_CLOSED && (sk->sk_shutdown & RCV_SHUTDOWN)) {
 		/* socket was connected before, no more data to read */
 		rc = 0;
 		goto out;
 	}
-	if (sk->sk_state == SMC_INIT ||
-	    sk->sk_state == SMC_LISTEN ||
-	    sk->sk_state == SMC_CLOSED)
+	if (smc_sk_state(sk) == SMC_INIT ||
+	    smc_sk_state(sk) == SMC_LISTEN ||
+	    smc_sk_state(sk) == SMC_CLOSED)
 		goto out;
 
-	if (sk->sk_state == SMC_PEERFINCLOSEWAIT) {
+	if (smc_sk_state(sk) == SMC_PEERFINCLOSEWAIT) {
 		rc = 0;
 		goto out;
 	}
diff --git a/net/smc/smc.h b/net/smc/smc.h
index 18c8b78..6b651b5 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -38,6 +38,9 @@
 #define KERNEL_HAS_ATOMIC64
 #endif
 
+#define smc_sk_state(sk)		((sk)->sk_state)
+#define smc_sk_set_state(sk, state)	(smc_sk_state(sk) = (state))
+
 enum smc_state {		/* possible states of an SMC socket */
 	SMC_ACTIVE	= 1,
 	SMC_INIT	= 2,
diff --git a/net/smc/smc_close.c b/net/smc/smc_close.c
index 10219f5..9210d1f 100644
--- a/net/smc/smc_close.c
+++ b/net/smc/smc_close.c
@@ -130,41 +130,41 @@ void smc_close_active_abort(struct smc_sock *smc)
 	struct sock *sk = &smc->sk;
 	bool release_clcsock = false;
 
-	if (sk->sk_state != SMC_INIT && smc->clcsock && smc->clcsock->sk) {
+	if (smc_sk_state(sk) != SMC_INIT && smc->clcsock && smc->clcsock->sk) {
 		sk->sk_err = ECONNABORTED;
 		if (smc->clcsock && smc->clcsock->sk)
 			tcp_abort(smc->clcsock->sk, ECONNABORTED);
 	}
-	switch (sk->sk_state) {
+	switch (smc_sk_state(sk)) {
 	case SMC_ACTIVE:
 	case SMC_APPCLOSEWAIT1:
 	case SMC_APPCLOSEWAIT2:
-		sk->sk_state = SMC_PEERABORTWAIT;
+		smc_sk_set_state(sk, SMC_PEERABORTWAIT);
 		smc_close_cancel_work(smc);
-		if (sk->sk_state != SMC_PEERABORTWAIT)
+		if (smc_sk_state(sk) != SMC_PEERABORTWAIT)
 			break;
-		sk->sk_state = SMC_CLOSED;
+		smc_sk_set_state(sk, SMC_CLOSED);
 		sock_put(sk); /* (postponed) passive closing */
 		break;
 	case SMC_PEERCLOSEWAIT1:
 	case SMC_PEERCLOSEWAIT2:
 	case SMC_PEERFINCLOSEWAIT:
-		sk->sk_state = SMC_PEERABORTWAIT;
+		smc_sk_set_state(sk, SMC_PEERABORTWAIT);
 		smc_close_cancel_work(smc);
-		if (sk->sk_state != SMC_PEERABORTWAIT)
+		if (smc_sk_state(sk) != SMC_PEERABORTWAIT)
 			break;
-		sk->sk_state = SMC_CLOSED;
+		smc_sk_set_state(sk, SMC_CLOSED);
 		smc_conn_free(&smc->conn);
 		release_clcsock = true;
 		sock_put(sk); /* passive closing */
 		break;
 	case SMC_PROCESSABORT:
 	case SMC_APPFINCLOSEWAIT:
-		sk->sk_state = SMC_PEERABORTWAIT;
+		smc_sk_set_state(sk, SMC_PEERABORTWAIT);
 		smc_close_cancel_work(smc);
-		if (sk->sk_state != SMC_PEERABORTWAIT)
+		if (smc_sk_state(sk) != SMC_PEERABORTWAIT)
 			break;
-		sk->sk_state = SMC_CLOSED;
+		smc_sk_set_state(sk, SMC_CLOSED);
 		smc_conn_free(&smc->conn);
 		release_clcsock = true;
 		break;
@@ -205,14 +205,14 @@ int smc_close_active(struct smc_sock *smc)
 		  0 : sock_flag(sk, SOCK_LINGER) ?
 		      sk->sk_lingertime : SMC_MAX_STREAM_WAIT_TIMEOUT;
 
-	old_state = sk->sk_state;
+	old_state = smc_sk_state(sk);
 again:
-	switch (sk->sk_state) {
+	switch (smc_sk_state(sk)) {
 	case SMC_INIT:
-		sk->sk_state = SMC_CLOSED;
+		smc_sk_set_state(sk, SMC_CLOSED);
 		break;
 	case SMC_LISTEN:
-		sk->sk_state = SMC_CLOSED;
+		smc_sk_set_state(sk, SMC_CLOSED);
 		sk->sk_state_change(sk); /* wake up accept */
 		if (smc->clcsock && smc->clcsock->sk) {
 			write_lock_bh(&smc->clcsock->sk->sk_callback_lock);
@@ -232,10 +232,10 @@ int smc_close_active(struct smc_sock *smc)
 		release_sock(sk);
 		cancel_delayed_work_sync(&conn->tx_work);
 		lock_sock(sk);
-		if (sk->sk_state == SMC_ACTIVE) {
+		if (smc_sk_state(sk) == SMC_ACTIVE) {
 			/* send close request */
 			rc = smc_close_final(conn);
-			sk->sk_state = SMC_PEERCLOSEWAIT1;
+			smc_sk_set_state(sk, SMC_PEERCLOSEWAIT1);
 
 			/* actively shutdown clcsock before peer close it,
 			 * prevent peer from entering TIME_WAIT state.
@@ -257,7 +257,7 @@ int smc_close_active(struct smc_sock *smc)
 			/* just shutdown wr done, send close request */
 			rc = smc_close_final(conn);
 		}
-		sk->sk_state = SMC_CLOSED;
+		smc_sk_set_state(sk, SMC_CLOSED);
 		break;
 	case SMC_APPCLOSEWAIT1:
 	case SMC_APPCLOSEWAIT2:
@@ -266,18 +266,18 @@ int smc_close_active(struct smc_sock *smc)
 		release_sock(sk);
 		cancel_delayed_work_sync(&conn->tx_work);
 		lock_sock(sk);
-		if (sk->sk_state != SMC_APPCLOSEWAIT1 &&
-		    sk->sk_state != SMC_APPCLOSEWAIT2)
+		if (smc_sk_state(sk) != SMC_APPCLOSEWAIT1 &&
+		    smc_sk_state(sk) != SMC_APPCLOSEWAIT2)
 			goto again;
 		/* confirm close from peer */
 		rc = smc_close_final(conn);
 		if (smc_cdc_rxed_any_close(conn)) {
 			/* peer has closed the socket already */
-			sk->sk_state = SMC_CLOSED;
+			smc_sk_set_state(sk, SMC_CLOSED);
 			sock_put(sk); /* postponed passive closing */
 		} else {
 			/* peer has just issued a shutdown write */
-			sk->sk_state = SMC_PEERFINCLOSEWAIT;
+			smc_sk_set_state(sk, SMC_PEERFINCLOSEWAIT);
 		}
 		break;
 	case SMC_PEERCLOSEWAIT1:
@@ -294,17 +294,17 @@ int smc_close_active(struct smc_sock *smc)
 		break;
 	case SMC_PROCESSABORT:
 		rc = smc_close_abort(conn);
-		sk->sk_state = SMC_CLOSED;
+		smc_sk_set_state(sk, SMC_CLOSED);
 		break;
 	case SMC_PEERABORTWAIT:
-		sk->sk_state = SMC_CLOSED;
+		smc_sk_set_state(sk, SMC_CLOSED);
 		break;
 	case SMC_CLOSED:
 		/* nothing to do, add tracing in future patch */
 		break;
 	}
 
-	if (old_state != sk->sk_state)
+	if (old_state != smc_sk_state(sk))
 		sk->sk_state_change(sk);
 	return rc;
 }
@@ -315,33 +315,33 @@ static void smc_close_passive_abort_received(struct smc_sock *smc)
 		&smc->conn.local_tx_ctrl.conn_state_flags;
 	struct sock *sk = &smc->sk;
 
-	switch (sk->sk_state) {
+	switch (smc_sk_state(sk)) {
 	case SMC_INIT:
 	case SMC_ACTIVE:
 	case SMC_APPCLOSEWAIT1:
-		sk->sk_state = SMC_PROCESSABORT;
+		smc_sk_set_state(sk, SMC_PROCESSABORT);
 		sock_put(sk); /* passive closing */
 		break;
 	case SMC_APPFINCLOSEWAIT:
-		sk->sk_state = SMC_PROCESSABORT;
+		smc_sk_set_state(sk, SMC_PROCESSABORT);
 		break;
 	case SMC_PEERCLOSEWAIT1:
 	case SMC_PEERCLOSEWAIT2:
 		if (txflags->peer_done_writing &&
 		    !smc_close_sent_any_close(&smc->conn))
 			/* just shutdown, but not yet closed locally */
-			sk->sk_state = SMC_PROCESSABORT;
+			smc_sk_set_state(sk, SMC_PROCESSABORT);
 		else
-			sk->sk_state = SMC_CLOSED;
+			smc_sk_set_state(sk, SMC_CLOSED);
 		sock_put(sk); /* passive closing */
 		break;
 	case SMC_APPCLOSEWAIT2:
 	case SMC_PEERFINCLOSEWAIT:
-		sk->sk_state = SMC_CLOSED;
+		smc_sk_set_state(sk, SMC_CLOSED);
 		sock_put(sk); /* passive closing */
 		break;
 	case SMC_PEERABORTWAIT:
-		sk->sk_state = SMC_CLOSED;
+		smc_sk_set_state(sk, SMC_CLOSED);
 		break;
 	case SMC_PROCESSABORT:
 	/* nothing to do, add tracing in future patch */
@@ -365,7 +365,7 @@ static void smc_close_passive_work(struct work_struct *work)
 	int old_state;
 
 	lock_sock(sk);
-	old_state = sk->sk_state;
+	old_state = smc_sk_state(sk);
 
 	rxflags = &conn->local_rx_ctrl.conn_state_flags;
 	if (rxflags->peer_conn_abort) {
@@ -377,19 +377,19 @@ static void smc_close_passive_work(struct work_struct *work)
 		goto wakeup;
 	}
 
-	switch (sk->sk_state) {
+	switch (smc_sk_state(sk)) {
 	case SMC_INIT:
-		sk->sk_state = SMC_APPCLOSEWAIT1;
+		smc_sk_set_state(sk, SMC_APPCLOSEWAIT1);
 		break;
 	case SMC_ACTIVE:
-		sk->sk_state = SMC_APPCLOSEWAIT1;
+		smc_sk_set_state(sk, SMC_APPCLOSEWAIT1);
 		/* postpone sock_put() for passive closing to cover
 		 * received SEND_SHUTDOWN as well
 		 */
 		break;
 	case SMC_PEERCLOSEWAIT1:
 		if (rxflags->peer_done_writing)
-			sk->sk_state = SMC_PEERCLOSEWAIT2;
+			smc_sk_set_state(sk, SMC_PEERCLOSEWAIT2);
 		fallthrough;
 		/* to check for closing */
 	case SMC_PEERCLOSEWAIT2:
@@ -398,16 +398,16 @@ static void smc_close_passive_work(struct work_struct *work)
 		if (sock_flag(sk, SOCK_DEAD) &&
 		    smc_close_sent_any_close(conn)) {
 			/* smc_release has already been called locally */
-			sk->sk_state = SMC_CLOSED;
+			smc_sk_set_state(sk, SMC_CLOSED);
 		} else {
 			/* just shutdown, but not yet closed locally */
-			sk->sk_state = SMC_APPFINCLOSEWAIT;
+			smc_sk_set_state(sk, SMC_APPFINCLOSEWAIT);
 		}
 		sock_put(sk); /* passive closing */
 		break;
 	case SMC_PEERFINCLOSEWAIT:
 		if (smc_cdc_rxed_any_close(conn)) {
-			sk->sk_state = SMC_CLOSED;
+			smc_sk_set_state(sk, SMC_CLOSED);
 			sock_put(sk); /* passive closing */
 		}
 		break;
@@ -429,9 +429,9 @@ static void smc_close_passive_work(struct work_struct *work)
 	sk->sk_data_ready(sk); /* wakeup blocked rcvbuf consumers */
 	sk->sk_write_space(sk); /* wakeup blocked sndbuf producers */
 
-	if (old_state != sk->sk_state) {
+	if (old_state != smc_sk_state(sk)) {
 		sk->sk_state_change(sk);
-		if ((sk->sk_state == SMC_CLOSED) &&
+		if ((smc_sk_state(sk) == SMC_CLOSED) &&
 		    (sock_flag(sk, SOCK_DEAD) || !sk->sk_socket)) {
 			smc_conn_free(conn);
 			if (smc->clcsock)
@@ -456,19 +456,19 @@ int smc_close_shutdown_write(struct smc_sock *smc)
 		  0 : sock_flag(sk, SOCK_LINGER) ?
 		      sk->sk_lingertime : SMC_MAX_STREAM_WAIT_TIMEOUT;
 
-	old_state = sk->sk_state;
+	old_state = smc_sk_state(sk);
 again:
-	switch (sk->sk_state) {
+	switch (smc_sk_state(sk)) {
 	case SMC_ACTIVE:
 		smc_close_stream_wait(smc, timeout);
 		release_sock(sk);
 		cancel_delayed_work_sync(&conn->tx_work);
 		lock_sock(sk);
-		if (sk->sk_state != SMC_ACTIVE)
+		if (smc_sk_state(sk) != SMC_ACTIVE)
 			goto again;
 		/* send close wr request */
 		rc = smc_close_wr(conn);
-		sk->sk_state = SMC_PEERCLOSEWAIT1;
+		smc_sk_set_state(sk, SMC_PEERCLOSEWAIT1);
 		break;
 	case SMC_APPCLOSEWAIT1:
 		/* passive close */
@@ -477,11 +477,11 @@ int smc_close_shutdown_write(struct smc_sock *smc)
 		release_sock(sk);
 		cancel_delayed_work_sync(&conn->tx_work);
 		lock_sock(sk);
-		if (sk->sk_state != SMC_APPCLOSEWAIT1)
+		if (smc_sk_state(sk) != SMC_APPCLOSEWAIT1)
 			goto again;
 		/* confirm close from peer */
 		rc = smc_close_wr(conn);
-		sk->sk_state = SMC_APPCLOSEWAIT2;
+		smc_sk_set_state(sk, SMC_APPCLOSEWAIT2);
 		break;
 	case SMC_APPCLOSEWAIT2:
 	case SMC_PEERFINCLOSEWAIT:
@@ -494,7 +494,7 @@ int smc_close_shutdown_write(struct smc_sock *smc)
 		break;
 	}
 
-	if (old_state != sk->sk_state)
+	if (old_state != smc_sk_state(sk))
 		sk->sk_state_change(sk);
 	return rc;
 }
diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 9b84d58..b852c09 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -1010,8 +1010,8 @@ static int smc_switch_cursor(struct smc_sock *smc, struct smc_cdc_tx_pend *pend,
 	/* recalculate, value is used by tx_rdma_writes() */
 	atomic_set(&smc->conn.peer_rmbe_space, smc_write_space(conn));
 
-	if (smc->sk.sk_state != SMC_INIT &&
-	    smc->sk.sk_state != SMC_CLOSED) {
+	if (smc_sk_state(&smc->sk) != SMC_INIT &&
+	    smc_sk_state(&smc->sk) != SMC_CLOSED) {
 		rc = smcr_cdc_msg_send_validation(conn, pend, wr_buf);
 		if (!rc) {
 			queue_delayed_work(conn->lgr->tx_wq, &conn->tx_work, 0);
@@ -1072,17 +1072,17 @@ struct smc_link *smc_switch_conns(struct smc_link_group *lgr,
 			continue;
 		smc = container_of(conn, struct smc_sock, conn);
 		/* conn->lnk not yet set in SMC_INIT state */
-		if (smc->sk.sk_state == SMC_INIT)
+		if (smc_sk_state(&smc->sk) == SMC_INIT)
 			continue;
-		if (smc->sk.sk_state == SMC_CLOSED ||
-		    smc->sk.sk_state == SMC_PEERCLOSEWAIT1 ||
-		    smc->sk.sk_state == SMC_PEERCLOSEWAIT2 ||
-		    smc->sk.sk_state == SMC_APPFINCLOSEWAIT ||
-		    smc->sk.sk_state == SMC_APPCLOSEWAIT1 ||
-		    smc->sk.sk_state == SMC_APPCLOSEWAIT2 ||
-		    smc->sk.sk_state == SMC_PEERFINCLOSEWAIT ||
-		    smc->sk.sk_state == SMC_PEERABORTWAIT ||
-		    smc->sk.sk_state == SMC_PROCESSABORT) {
+		if (smc_sk_state(&smc->sk) == SMC_CLOSED ||
+		    smc_sk_state(&smc->sk) == SMC_PEERCLOSEWAIT1 ||
+		    smc_sk_state(&smc->sk) == SMC_PEERCLOSEWAIT2 ||
+		    smc_sk_state(&smc->sk) == SMC_APPFINCLOSEWAIT ||
+		    smc_sk_state(&smc->sk) == SMC_APPCLOSEWAIT1 ||
+		    smc_sk_state(&smc->sk) == SMC_APPCLOSEWAIT2 ||
+		    smc_sk_state(&smc->sk) == SMC_PEERFINCLOSEWAIT ||
+		    smc_sk_state(&smc->sk) == SMC_PEERABORTWAIT ||
+		    smc_sk_state(&smc->sk) == SMC_PROCESSABORT) {
 			spin_lock_bh(&conn->send_lock);
 			smc_switch_link_and_count(conn, to_lnk);
 			spin_unlock_bh(&conn->send_lock);
diff --git a/net/smc/smc_diag.c b/net/smc/smc_diag.c
index 6fdb2d9..59a18ec 100644
--- a/net/smc/smc_diag.c
+++ b/net/smc/smc_diag.c
@@ -87,7 +87,7 @@ static int __smc_diag_dump(struct sock *sk, struct sk_buff *skb,
 
 	r = nlmsg_data(nlh);
 	smc_diag_msg_common_fill(r, sk);
-	r->diag_state = sk->sk_state;
+	r->diag_state = smc_sk_state(sk);
 	if (smc->use_fallback)
 		r->diag_mode = SMC_DIAG_MODE_FALLBACK_TCP;
 	else if (smc_conn_lgr_valid(&smc->conn) && smc->conn.lgr->is_smcd)
diff --git a/net/smc/smc_rx.c b/net/smc/smc_rx.c
index 9a2f363..32fd7db 100644
--- a/net/smc/smc_rx.c
+++ b/net/smc/smc_rx.c
@@ -44,7 +44,7 @@ static void smc_rx_wake_up(struct sock *sk)
 						EPOLLRDNORM | EPOLLRDBAND);
 	sk_wake_async(sk, SOCK_WAKE_WAITD, POLL_IN);
 	if ((sk->sk_shutdown == SHUTDOWN_MASK) ||
-	    (sk->sk_state == SMC_CLOSED))
+	    (smc_sk_state(sk) == SMC_CLOSED))
 		sk_wake_async(sk, SOCK_WAKE_WAITD, POLL_HUP);
 	rcu_read_unlock();
 }
@@ -119,9 +119,9 @@ static void smc_rx_pipe_buf_release(struct pipe_inode_info *pipe,
 	struct smc_connection *conn;
 	struct sock *sk = &smc->sk;
 
-	if (sk->sk_state == SMC_CLOSED ||
-	    sk->sk_state == SMC_PEERFINCLOSEWAIT ||
-	    sk->sk_state == SMC_APPFINCLOSEWAIT)
+	if (smc_sk_state(sk) == SMC_CLOSED ||
+	    smc_sk_state(sk) == SMC_PEERFINCLOSEWAIT ||
+	    smc_sk_state(sk) == SMC_APPFINCLOSEWAIT)
 		goto out;
 	conn = &smc->conn;
 	lock_sock(sk);
@@ -316,7 +316,7 @@ static int smc_rx_recv_urg(struct smc_sock *smc, struct msghdr *msg, int len,
 		return rc ? -EFAULT : len;
 	}
 
-	if (sk->sk_state == SMC_CLOSED || sk->sk_shutdown & RCV_SHUTDOWN)
+	if (smc_sk_state(sk) == SMC_CLOSED || sk->sk_shutdown & RCV_SHUTDOWN)
 		return 0;
 
 	return -EAGAIN;
@@ -361,7 +361,7 @@ int smc_rx_recvmsg(struct smc_sock *smc, struct msghdr *msg,
 		return -EINVAL; /* future work for sk.sk_family == AF_SMC */
 
 	sk = &smc->sk;
-	if (sk->sk_state == SMC_LISTEN)
+	if (smc_sk_state(sk) == SMC_LISTEN)
 		return -ENOTCONN;
 	if (flags & MSG_OOB)
 		return smc_rx_recv_urg(smc, msg, len, flags);
@@ -398,7 +398,7 @@ int smc_rx_recvmsg(struct smc_sock *smc, struct msghdr *msg,
 
 		if (read_done) {
 			if (sk->sk_err ||
-			    sk->sk_state == SMC_CLOSED ||
+			    smc_sk_state(sk) == SMC_CLOSED ||
 			    !timeo ||
 			    signal_pending(current))
 				break;
@@ -407,7 +407,7 @@ int smc_rx_recvmsg(struct smc_sock *smc, struct msghdr *msg,
 				read_done = sock_error(sk);
 				break;
 			}
-			if (sk->sk_state == SMC_CLOSED) {
+			if (smc_sk_state(sk) == SMC_CLOSED) {
 				if (!sock_flag(sk, SOCK_DONE)) {
 					/* This occurs when user tries to read
 					 * from never connected socket.
diff --git a/net/smc/smc_tx.c b/net/smc/smc_tx.c
index 214ac3c..75b532d 100644
--- a/net/smc/smc_tx.c
+++ b/net/smc/smc_tx.c
@@ -198,7 +198,7 @@ int smc_tx_sendmsg(struct smc_sock *smc, struct msghdr *msg, size_t len)
 		goto out_err;
 	}
 
-	if (sk->sk_state == SMC_INIT)
+	if (smc_sk_state(sk) == SMC_INIT)
 		return -ENOTCONN;
 
 	if (len > conn->sndbuf_desc->len)
-- 
1.8.3.1


