Return-Path: <linux-rdma+bounces-8610-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94618A5DE02
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Mar 2025 14:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7E6116C7CD
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Mar 2025 13:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91BDC12FF69;
	Wed, 12 Mar 2025 13:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xjNCMxKe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996A72AD21;
	Wed, 12 Mar 2025 13:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741786230; cv=none; b=nZoO2OZVVi1XIjTTxZJ5OxfQxE5Bdb5P4uefFXEOqnrJYMcLaQTg+avZmmYp1trLEvQjcifbLrixX0Md8B7O/NTEw/tcWwdwnMbtzHta/WdKludmdyKc9H9oe5y1q9huDqMEBxWuwykPPLrp5BrYQkZUb/qR10aKQt9ghhiyc0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741786230; c=relaxed/simple;
	bh=4KZAmteVCiPQZKXa6RixXdbPA2A1lVG6qAGUPw9jYGY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J8l5mX1/xKFtJtba+apDelSNEQKA5drvA+qZwiQZvnXexUyH9vYTeS7ceYjaWG0ihDeLLbXF3fPq/DxW3HuZoWiuggFnArWL6Icr3VYKDxXUm1WiYNNC0DAv8LbCeGYOHnzv+VV1PIbj2YXJz1o5UTfIbjca+XlDVtjOeomnjoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xjNCMxKe; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1741786220; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=snu8++Ueu+hpkYG+qKz0qWfUxpdd8LRIN9HJR73fE80=;
	b=xjNCMxKecAjZ+9Hs47+vPxdqOZmmu52PbLse0zFDFckZpSCjYOdtptTf7BgJTTUGduHJqoIFBN00ZhxSYfudR5BfPS83I8v7hlos7I28xmc10KJPJkRXfLpkF2v3WlqJipL5sddwbHbQ3GgOY2Sdzdcu4sIhxg+1bwIXazrd6Yw=
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WRD.2t6_1741786214 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 12 Mar 2025 21:30:20 +0800
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
Subject: [RFC PATCH net-next] net/smc: avoid conflict with sockmap after fallback
Date: Wed, 12 Mar 2025 21:30:14 +0800
Message-ID: <20250312133014.35775-1-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, after fallback, SMC will occupy the sk_user_data of the TCP sock(clcsk) to
forward events. As a result, we cannot use sockmap after that, since sockmap also
requires the use of the sk_user_data. Even more, in some cases, this may result in
abnormal panic.

To enable sockmap after SMC fallback , we need to avoid using sk_user_data and
instead introduce an additional smc_ctx in tcp_sock to index from TCP sock to SMC sock.

Additionally, we bind the lifecycle of the SMC sock to that of the TCP sock, ensuring
that the indexing to the SMC sock remains valid throughout the lifetime of the TCP sock.

One key reason is that SMC overrides inet_connection_sock_af_ops, which introduces
potential dependencies. We must ensure that the af_ops remain visible throughout the
lifecycle of the TCP socket. In addition, this also resolves potential issues in some
scenarios where the SMC sock might be invalid.

Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
---
 include/linux/tcp.h |  1 +
 net/smc/af_smc.c    | 53 ++++++++++++++++++++++-----------------------
 net/smc/smc.h       |  8 +++----
 net/smc/smc_close.c |  1 -
 4 files changed, 30 insertions(+), 33 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index f88daaa76d83..f2223b1cc0d0 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -478,6 +478,7 @@ struct tcp_sock {
 #if IS_ENABLED(CONFIG_SMC)
 	bool	syn_smc;	/* SYN includes SMC */
 	bool	(*smc_hs_congested)(const struct sock *sk);
+	void	*smc_ctx;
 #endif
 
 #if defined(CONFIG_TCP_MD5SIG) || defined(CONFIG_TCP_AO)
diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index bc356f77ff1d..d434105639c1 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -127,7 +127,7 @@ static struct sock *smc_tcp_syn_recv_sock(const struct sock *sk,
 	struct smc_sock *smc;
 	struct sock *child;
 
-	smc = smc_clcsock_user_data(sk);
+	smc = smc_sk_from_clcsk(sk);
 
 	if (READ_ONCE(sk->sk_ack_backlog) + atomic_read(&smc->queued_smc_hs) >
 				sk->sk_max_ack_backlog)
@@ -143,8 +143,6 @@ static struct sock *smc_tcp_syn_recv_sock(const struct sock *sk,
 					       own_req);
 	/* child must not inherit smc or its ops */
 	if (child) {
-		rcu_assign_sk_user_data(child, NULL);
-
 		/* v4-mapped sockets don't inherit parent ops. Don't restore. */
 		if (inet_csk(child)->icsk_af_ops == inet_csk(sk)->icsk_af_ops)
 			inet_csk(child)->icsk_af_ops = smc->ori_af_ops;
@@ -161,10 +159,7 @@ static bool smc_hs_congested(const struct sock *sk)
 {
 	const struct smc_sock *smc;
 
-	smc = smc_clcsock_user_data(sk);
-
-	if (!smc)
-		return true;
+	smc = smc_sk_from_clcsk(sk);
 
 	if (workqueue_congested(WORK_CPU_UNBOUND, smc_hs_wq))
 		return true;
@@ -250,7 +245,6 @@ static void smc_fback_restore_callbacks(struct smc_sock *smc)
 	struct sock *clcsk = smc->clcsock->sk;
 
 	write_lock_bh(&clcsk->sk_callback_lock);
-	clcsk->sk_user_data = NULL;
 
 	smc_clcsock_restore_cb(&clcsk->sk_state_change, &smc->clcsk_state_change);
 	smc_clcsock_restore_cb(&clcsk->sk_data_ready, &smc->clcsk_data_ready);
@@ -832,11 +826,10 @@ static void smc_fback_forward_wakeup(struct smc_sock *smc, struct sock *clcsk,
 
 static void smc_fback_state_change(struct sock *clcsk)
 {
-	struct smc_sock *smc;
+	struct smc_sock *smc = smc_sk_from_clcsk(clcsk);
 
 	read_lock_bh(&clcsk->sk_callback_lock);
-	smc = smc_clcsock_user_data(clcsk);
-	if (smc)
+	if (smc->clcsk_state_change)
 		smc_fback_forward_wakeup(smc, clcsk,
 					 smc->clcsk_state_change);
 	read_unlock_bh(&clcsk->sk_callback_lock);
@@ -844,11 +837,10 @@ static void smc_fback_state_change(struct sock *clcsk)
 
 static void smc_fback_data_ready(struct sock *clcsk)
 {
-	struct smc_sock *smc;
+	struct smc_sock *smc = smc_sk_from_clcsk(clcsk);
 
 	read_lock_bh(&clcsk->sk_callback_lock);
-	smc = smc_clcsock_user_data(clcsk);
-	if (smc)
+	if (smc->clcsk_data_ready)
 		smc_fback_forward_wakeup(smc, clcsk,
 					 smc->clcsk_data_ready);
 	read_unlock_bh(&clcsk->sk_callback_lock);
@@ -856,11 +848,10 @@ static void smc_fback_data_ready(struct sock *clcsk)
 
 static void smc_fback_write_space(struct sock *clcsk)
 {
-	struct smc_sock *smc;
+	struct smc_sock *smc = smc_sk_from_clcsk(clcsk);
 
 	read_lock_bh(&clcsk->sk_callback_lock);
-	smc = smc_clcsock_user_data(clcsk);
-	if (smc)
+	if (smc->clcsk_write_space)
 		smc_fback_forward_wakeup(smc, clcsk,
 					 smc->clcsk_write_space);
 	read_unlock_bh(&clcsk->sk_callback_lock);
@@ -868,11 +859,10 @@ static void smc_fback_write_space(struct sock *clcsk)
 
 static void smc_fback_error_report(struct sock *clcsk)
 {
-	struct smc_sock *smc;
+	struct smc_sock *smc = smc_sk_from_clcsk(clcsk);
 
 	read_lock_bh(&clcsk->sk_callback_lock);
-	smc = smc_clcsock_user_data(clcsk);
-	if (smc)
+	if (smc->clcsk_error_report)
 		smc_fback_forward_wakeup(smc, clcsk,
 					 smc->clcsk_error_report);
 	read_unlock_bh(&clcsk->sk_callback_lock);
@@ -883,7 +873,6 @@ static void smc_fback_replace_callbacks(struct smc_sock *smc)
 	struct sock *clcsk = smc->clcsock->sk;
 
 	write_lock_bh(&clcsk->sk_callback_lock);
-	clcsk->sk_user_data = (void *)((uintptr_t)smc | SK_USER_DATA_NOCOPY);
 
 	smc_clcsock_replace_cb(&clcsk->sk_state_change, smc_fback_state_change,
 			       &smc->clcsk_state_change);
@@ -2602,11 +2591,10 @@ static void smc_tcp_listen_work(struct work_struct *work)
 
 static void smc_clcsock_data_ready(struct sock *listen_clcsock)
 {
-	struct smc_sock *lsmc;
+	struct smc_sock *lsmc = smc_sk_from_clcsk(listen_clcsock);
 
 	read_lock_bh(&listen_clcsock->sk_callback_lock);
-	lsmc = smc_clcsock_user_data(listen_clcsock);
-	if (!lsmc)
+	if (!lsmc->clcsk_data_ready)
 		goto out;
 	lsmc->clcsk_data_ready(listen_clcsock);
 	if (lsmc->sk.sk_state == SMC_LISTEN) {
@@ -2648,8 +2636,6 @@ int smc_listen(struct socket *sock, int backlog)
 	 * smc-specific sk_data_ready function
 	 */
 	write_lock_bh(&smc->clcsock->sk->sk_callback_lock);
-	smc->clcsock->sk->sk_user_data =
-		(void *)((uintptr_t)smc | SK_USER_DATA_NOCOPY);
 	smc_clcsock_replace_cb(&smc->clcsock->sk->sk_data_ready,
 			       smc_clcsock_data_ready, &smc->clcsk_data_ready);
 	write_unlock_bh(&smc->clcsock->sk->sk_callback_lock);
@@ -2670,7 +2656,6 @@ int smc_listen(struct socket *sock, int backlog)
 		write_lock_bh(&smc->clcsock->sk->sk_callback_lock);
 		smc_clcsock_restore_cb(&smc->clcsock->sk->sk_data_ready,
 				       &smc->clcsk_data_ready);
-		smc->clcsock->sk->sk_user_data = NULL;
 		write_unlock_bh(&smc->clcsock->sk->sk_callback_lock);
 		goto out;
 	}
@@ -3323,6 +3308,15 @@ static const struct proto_ops smc_sock_ops = {
 	.splice_read	= smc_splice_read,
 };
 
+static void smc_clcsk_destruct(struct sock *clcsk)
+{
+	struct smc_sock *smc = smc_sk_from_clcsk(clcsk);
+
+	clcsk->sk_destruct = smc->clcsk_destruct;
+	clcsk->sk_destruct(clcsk);
+	sock_put(&smc->sk); /* hold in smc_create_clcsk() */
+}
+
 int smc_create_clcsk(struct net *net, struct sock *sk, int family)
 {
 	struct smc_sock *smc = smc_sk(sk);
@@ -3343,6 +3337,11 @@ int smc_create_clcsk(struct net *net, struct sock *sk, int family)
 	sk->sk_net_refcnt = 1;
 	get_net_track(net, &sk->ns_tracker, GFP_KERNEL);
 	sock_inuse_add(net, 1);
+
+	tcp_sk(sk)->smc_ctx = &smc->sk;
+	sock_hold(&smc->sk); /* put in smc_clcsk_destruct() */
+	smc->clcsk_destruct = sk->sk_destruct;
+	sk->sk_destruct = smc_clcsk_destruct;
 	return 0;
 }
 
diff --git a/net/smc/smc.h b/net/smc/smc.h
index 78ae10d06ed2..940b040ee9e8 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -296,6 +296,8 @@ struct smc_sock {				/* smc sock container */
 						/* original write_space fct. */
 	void			(*clcsk_error_report)(struct sock *sk);
 						/* original error_report fct. */
+	void			(*clcsk_destruct)(struct sock *sk);
+						/* original destruct fct. */
 	struct smc_connection	conn;		/* smc connection */
 	struct smc_sock		*listen_smc;	/* listen parent */
 	struct work_struct	connect_work;	/* handle non-blocking connect*/
@@ -340,11 +342,7 @@ static inline void smc_init_saved_callbacks(struct smc_sock *smc)
 	smc->clcsk_error_report	= NULL;
 }
 
-static inline struct smc_sock *smc_clcsock_user_data(const struct sock *clcsk)
-{
-	return (struct smc_sock *)
-	       ((uintptr_t)clcsk->sk_user_data & ~SK_USER_DATA_NOCOPY);
-}
+#define smc_sk_from_clcsk(sk)	(tcp_sk(sk)->smc_ctx)
 
 /* save target_cb in saved_cb, and replace target_cb with new_cb */
 static inline void smc_clcsock_replace_cb(void (**target_cb)(struct sock *),
diff --git a/net/smc/smc_close.c b/net/smc/smc_close.c
index 10219f55aad1..a6aa0f8a99e2 100644
--- a/net/smc/smc_close.c
+++ b/net/smc/smc_close.c
@@ -218,7 +218,6 @@ int smc_close_active(struct smc_sock *smc)
 			write_lock_bh(&smc->clcsock->sk->sk_callback_lock);
 			smc_clcsock_restore_cb(&smc->clcsock->sk->sk_data_ready,
 					       &smc->clcsk_data_ready);
-			smc->clcsock->sk->sk_user_data = NULL;
 			write_unlock_bh(&smc->clcsock->sk->sk_callback_lock);
 			rc = kernel_sock_shutdown(smc->clcsock, SHUT_RDWR);
 		}
-- 
2.45.0


