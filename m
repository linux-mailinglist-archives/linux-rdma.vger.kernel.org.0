Return-Path: <linux-rdma+bounces-1065-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA7E85B387
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Feb 2024 08:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B64841F229ED
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Feb 2024 07:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52055C8E3;
	Tue, 20 Feb 2024 07:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ZKkQN6dQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF2D5B5CE;
	Tue, 20 Feb 2024 07:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708412530; cv=none; b=tyJRU0Lw33qCl/EcJpeM21kuaStP1/SaSIzk+J+uQfdz4a7ZWveTDMGAfzEIBzPtpI/fsGFvHsM0vQfeLSRDCaFkzQenAd16Hgol8mp8EZWBuJF9oWqK3mE2VQ1a3ORgGaH8rQCgVDD2UHYH0iAznH8tMYKQb/tB3/iK/MjLJ9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708412530; c=relaxed/simple;
	bh=cWRc+mkbWG2n0PDtOYSRZHIkGo13jr4Tdym5T/s3jaE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cRQsZRtYr0siLFSqQ12NOMXCULR9Lm2QlaDUKxLjE8L5CA75TeoF59ASDx+UZOtr3yT6bEB0ZRHe1RcumyL1uCjgeVa8f+KIFl1LXL5SndbDDIDdbf6twfs0YQghV4+UIGEQ8xKAzD7TzdYBUB++aXa6sO/qW8x7UK7jFdcAm+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ZKkQN6dQ; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708412522; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=v0ywznRTPj7Wn1FFiwpPP6LD+OKCgbhW6KYJevfE9Nk=;
	b=ZKkQN6dQjOM/htmJKPxb/UuDpP7ucPlTDTqRF/iEqOh2aOVNgnyZr1/en68KkI5atgdI09patKLJ30xqB/AzXEOGXE1zlZfUS2C/OIDKeNU16AW0UAh1eHPebbjbsO2bD1QFj9msl5KYBzgMCRFcqrEH5WmP6vULj+Qd+3HJfH8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W0vuXhs_1708412522;
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0W0vuXhs_1708412522)
          by smtp.aliyun-inc.com;
          Tue, 20 Feb 2024 15:02:02 +0800
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
Subject: [RFC net-next 19/20] net/smc: support smc inet with merge socks
Date: Tue, 20 Feb 2024 15:01:44 +0800
Message-Id: <1708412505-34470-20-git-send-email-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1708412505-34470-1-git-send-email-alibuda@linux.alibaba.com>
References: <1708412505-34470-1-git-send-email-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: "D. Wythe" <alibuda@linux.alibaba.com>

This patch mainly implements how AF_INET works under one single
sock.

Unlike the AF_SMC sock, the inet smc can directly fallback to TCP
under the IRQ context, no need to start a work in workqueue. The
inet smc start the listen work only when the peer has syn_smc set.
It accelerates the efficiency of establishing connections whom prove
to be SMC unsupported.

The complex logic here is that we need to dynamically sort the reqsk in
TCP, and try to move ahead the syn_smc with 0 as much as possible, which
allows for faster fallback connections. However, due to the timing issue
of accept, we cannot always guarantee this condition.

Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
---
 include/linux/tcp.h |   1 +
 net/smc/af_smc.c    | 942 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 net/smc/smc.h       |   7 +
 net/smc/smc_cdc.h   |   8 +
 net/smc/smc_clc.h   |   1 +
 net/smc/smc_close.c |  16 +-
 net/smc/smc_inet.c  | 215 +++++++++---
 net/smc/smc_inet.h  |  98 ++++++
 net/smc/smc_rx.c    |   6 +-
 9 files changed, 1236 insertions(+), 58 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index a1c47a6..8546ae9 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -479,6 +479,7 @@ struct tcp_sock {
 #if IS_ENABLED(CONFIG_SMC)
 	bool	(*smc_hs_congested)(const struct sock *sk);
 	bool	syn_smc;	/* SYN includes SMC */
+	bool	is_smc;		/* is this sock also a smc sock */
 #endif
 
 #if defined(CONFIG_TCP_MD5SIG) || defined(CONFIG_TCP_AO)
diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 390fe6c..b66a199 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -72,6 +72,8 @@
 static void smc_tcp_listen_work(struct work_struct *);
 static void smc_connect_work(struct work_struct *);
 
+static int smc_inet_sock_do_handshake(struct sock *sk, bool sk_locked, bool sync);
+
 int smc_nl_dump_hs_limitation(struct sk_buff *skb, struct netlink_callback *cb)
 {
 	struct smc_nl_dmp_ctx *cb_ctx = smc_nl_dmp_ctx(cb);
@@ -360,6 +362,9 @@ static int smc_release(struct socket *sock)
 
 static void smc_destruct(struct sock *sk)
 {
+	if (smc_sk(sk)->original_sk_destruct)
+		smc_sk(sk)->original_sk_destruct(sk);
+
 	if (smc_sk_state(sk) != SMC_CLOSED)
 		return;
 	if (!smc_sock_flag(sk, SOCK_DEAD))
@@ -402,6 +407,9 @@ static void smc_sock_init(struct sock *sk, struct net *net)
 	spin_lock_init(&smc->accept_q_lock);
 	smc_init_saved_callbacks(smc);
 
+	/* already set (for inet sock), save the original */
+	if (sk->sk_destruct)
+		smc->original_sk_destruct = sk->sk_destruct;
 	sk->sk_destruct = smc_destruct;
 }
 
@@ -518,6 +526,10 @@ static void smc_adjust_sock_bufsizes(struct sock *nsk, struct sock *osk,
 static void smc_copy_sock_settings(struct sock *nsk, struct sock *osk,
 				   unsigned long mask)
 {
+	/* no need for inet smc */
+	if (smc_sock_is_inet_sock(nsk))
+		return;
+
 	/* options we don't get control via setsockopt for */
 	nsk->sk_type = osk->sk_type;
 	nsk->sk_sndtimeo = osk->sk_sndtimeo;
@@ -945,6 +957,11 @@ static int smc_switch_to_fallback(struct smc_sock *smc, int reason_code)
 	smc_stat_fallback(smc);
 	trace_smc_switch_to_fallback(smc, reason_code);
 
+	/* inet sock  */
+	if (smc_sock_is_inet_sock(&smc->sk))
+		return 0;
+
+	/* smc sock */
 	mutex_lock(&smc->clcsock_release_lock);
 	if (!smc->clcsock) {
 		rc = -EBADF;
@@ -1712,12 +1729,28 @@ static int smc_connect(struct socket *sock, struct sockaddr *addr,
 		break;
 	}
 
-	smc_copy_sock_settings_to_clc(smc);
-	tcp_sk(smc->clcsock->sk)->syn_smc = 1;
 	if (smc->connect_nonblock) {
 		rc = -EALREADY;
 		goto out;
 	}
+
+	smc_copy_sock_settings_to_clc(smc);
+
+	if (smc_sock_is_inet_sock(sk)) {
+		write_lock_bh(&sk->sk_callback_lock);
+		if (smc_inet_sock_set_syn_smc_locked(sk, 1)) {
+			if (flags & O_NONBLOCK)
+				smc_clcsock_replace_cb(&sk->sk_state_change,
+						       smc_inet_sock_state_change,
+						       &smc->clcsk_state_change);
+		} else if (!tcp_sk(sk)->syn_smc && !smc->use_fallback) {
+			smc_switch_to_fallback(smc, SMC_CLC_DECL_OPTUNSUPP);
+		}
+		write_unlock_bh(&sk->sk_callback_lock);
+	} else {
+		tcp_sk(smc->clcsock->sk)->syn_smc = 1;
+	}
+
 	rc = kernel_connect(smc->clcsock, addr, alen, flags);
 	if (rc && rc != -EINPROGRESS)
 		goto out;
@@ -1726,6 +1759,56 @@ static int smc_connect(struct socket *sock, struct sockaddr *addr,
 		sock->state = rc ? SS_CONNECTING : SS_CONNECTED;
 		goto out;
 	}
+
+	/* for inet sock */
+	if (smc_sock_is_inet_sock(sk)) {
+		if (flags & O_NONBLOCK) {
+			write_lock_bh(&sk->sk_callback_lock);
+			if (smc_inet_sock_check_smc(sk) || smc_inet_sock_check_fallback(sk)) {
+				rc = 0;
+			} else {
+				smc->connect_nonblock = 1;
+				rc = -EINPROGRESS;
+			}
+			write_unlock_bh(&sk->sk_callback_lock);
+		} else {
+			write_lock_bh(&sk->sk_callback_lock);
+again:
+			switch (isck_smc_negotiation_load(smc)) {
+			case SMC_NEGOTIATION_TBD:
+				/* already abort */
+				if (isck_smc_negotiation_get_flags(smc_sk(sk)) &
+								   SMC_NEGOTIATION_ABORT_FLAG) {
+					rc = -ECONNABORTED;
+					break;
+				}
+				smc_inet_sock_move_state_locked(sk, SMC_NEGOTIATION_TBD,
+								SMC_NEGOTIATION_PREPARE_SMC);
+				write_unlock_bh(&sk->sk_callback_lock);
+do_handshake:
+				rc = smc_inet_sock_do_handshake(sk, /* sk_locked */ true,
+								true);
+				write_lock_bh(&sk->sk_callback_lock);
+				break;
+			case SMC_NEGOTIATION_PREPARE_SMC:
+				write_unlock_bh(&sk->sk_callback_lock);
+				/* cancel success */
+				if (cancel_work_sync(&smc->connect_work))
+					goto do_handshake;
+				write_lock_bh(&sk->sk_callback_lock);
+				goto again;
+			case SMC_NEGOTIATION_NO_SMC:
+			case SMC_NEGOTIATION_SMC:
+				rc = 0;
+				break;
+			}
+			write_unlock_bh(&sk->sk_callback_lock);
+			if (!rc)
+				goto connected;
+		}
+		goto out;
+	}
+
 	sock_hold(&smc->sk); /* sock put in passive closing */
 	if (flags & O_NONBLOCK) {
 		if (queue_work(smc_hs_wq, &smc->connect_work))
@@ -1816,7 +1899,8 @@ static void smc_accept_enqueue(struct sock *parent, struct sock *sk)
 	spin_lock(&par->accept_q_lock);
 	list_add_tail(&smc_sk(sk)->accept_q, &par->accept_q);
 	spin_unlock(&par->accept_q_lock);
-	sk_acceptq_added(parent);
+	if (!smc_sock_is_inet_sock(sk))
+		sk_acceptq_added(parent);
 }
 
 /* remove a socket from the accept queue of its parental listening socket */
@@ -1827,7 +1911,8 @@ static void smc_accept_unlink(struct sock *sk)
 	spin_lock(&par->accept_q_lock);
 	list_del_init(&smc_sk(sk)->accept_q);
 	spin_unlock(&par->accept_q_lock);
-	sk_acceptq_removed(&smc_sk(sk)->listen_smc->sk);
+	if (!smc_sock_is_inet_sock(sk))
+		sk_acceptq_removed(&smc_sk(sk)->listen_smc->sk);
 	sock_put(sk); /* sock_hold in smc_accept_enqueue */
 }
 
@@ -1845,6 +1930,10 @@ struct sock *smc_accept_dequeue(struct sock *parent,
 
 		smc_accept_unlink(new_sk);
 		if (smc_sk_state(new_sk) == SMC_CLOSED) {
+			if (smc_sock_is_inet_sock(parent)) {
+				tcp_close(new_sk, 0);
+				continue;
+			}
 			new_sk->sk_prot->unhash(new_sk);
 			if (isk->clcsock) {
 				sock_release(isk->clcsock);
@@ -1873,13 +1962,25 @@ void smc_close_non_accepted(struct sock *sk)
 
 	sock_hold(sk); /* sock_put below */
 	lock_sock(sk);
-	if (!sk->sk_lingertime)
-		/* wait for peer closing */
-		WRITE_ONCE(sk->sk_lingertime, SMC_MAX_STREAM_WAIT_TIMEOUT);
-	__smc_release(smc);
+	if (smc_sock_is_inet_sock(sk)) {
+		if (!smc_inet_sock_check_fallback(sk))
+			smc_close_active(smc);
+		smc_sock_set_flag(sk, SOCK_DEAD);
+		release_sock(sk);
+		tcp_close(sk, 0);
+		lock_sock(sk);
+		if (smc_sk_state(sk) == SMC_CLOSED)
+			smc_conn_free(&smc->conn);
+	} else {
+		if (!sk->sk_lingertime)
+			/* wait for peer closing */
+			sk->sk_lingertime = SMC_MAX_STREAM_WAIT_TIMEOUT;
+		__smc_release(smc);
+	}
 	release_sock(sk);
 	sock_put(sk); /* sock_hold above */
-	sock_put(sk); /* final sock_put */
+	if (!smc_sock_is_inet_sock(sk))
+		sock_put(sk); /* final sock_put */
 }
 
 static int smcr_serv_conf_first_link(struct smc_sock *smc)
@@ -1943,6 +2044,14 @@ static void smc_listen_out(struct smc_sock *new_smc)
 	if (tcp_sk(new_smc->clcsock->sk)->syn_smc)
 		atomic_dec(&lsmc->queued_smc_hs);
 
+	if (smc_sock_is_inet_sock(newsmcsk))
+		smc_inet_sock_move_state(newsmcsk,
+					 SMC_NEGOTIATION_PREPARE_SMC,
+					 new_smc->use_fallback &&
+					 smc_sk_state(newsmcsk) == SMC_ACTIVE ?
+					 SMC_NEGOTIATION_NO_SMC :
+					 SMC_NEGOTIATION_SMC);
+
 	if (smc_sk_state(&lsmc->sk) == SMC_LISTEN) {
 		lock_sock_nested(&lsmc->sk, SINGLE_DEPTH_NESTING);
 		smc_accept_enqueue(&lsmc->sk, newsmcsk);
@@ -2855,7 +2964,7 @@ static int smc_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 
 	smc = smc_sk(sk);
 	lock_sock(sk);
-	if (smc_sk_state(sk) == SMC_CLOSED && (sk->sk_shutdown & RCV_SHUTDOWN)) {
+	if (smc_sk_state(sk) == SMC_CLOSED && smc_has_rcv_shutdown(sk)) {
 		/* socket was connected before, no more data to read */
 		rc = 0;
 		goto out;
@@ -2936,7 +3045,7 @@ static __poll_t smc_poll(struct file *file, struct socket *sock,
 			}
 			if (atomic_read(&smc->conn.bytes_to_rcv))
 				mask |= EPOLLIN | EPOLLRDNORM;
-			if (sk->sk_shutdown & RCV_SHUTDOWN)
+			if (smc_has_rcv_shutdown(sk))
 				mask |= EPOLLIN | EPOLLRDNORM | EPOLLRDHUP;
 			if (smc_sk_state(sk) == SMC_APPCLOSEWAIT1)
 				mask |= EPOLLIN;
@@ -3347,7 +3456,7 @@ static ssize_t smc_splice_read(struct socket *sock, loff_t *ppos,
 
 	smc = smc_sk(sk);
 	lock_sock(sk);
-	if (smc_sk_state(sk) == SMC_CLOSED && (sk->sk_shutdown & RCV_SHUTDOWN)) {
+	if (smc_sk_state(sk) == SMC_CLOSED && (smc_has_rcv_shutdown(sk))) {
 		/* socket was connected before, no more data to read */
 		rc = 0;
 		goto out;
@@ -3573,6 +3682,815 @@ static void __net_exit smc_net_stat_exit(struct net *net)
 	.exit = smc_net_stat_exit,
 };
 
+static inline struct request_sock *smc_inet_reqsk_get_safe_tail_0(struct sock *parent)
+{
+	struct request_sock_queue *queue = &inet_csk(parent)->icsk_accept_queue;
+	struct request_sock *req = queue->rskq_accept_head;
+
+	if (req && smc_sk(req->sk)->ordered && tcp_sk(req->sk)->syn_smc == 0)
+		return smc_sk(parent)->tail_0;
+
+	return NULL;
+}
+
+static inline struct request_sock *smc_inet_reqsk_get_safe_tail_1(struct sock *parent)
+{
+	struct request_sock_queue *queue = &inet_csk(parent)->icsk_accept_queue;
+	struct request_sock *tail_0 = smc_inet_reqsk_get_safe_tail_0(parent);
+	struct request_sock *req;
+
+	if (tail_0)
+		req = tail_0->dl_next;
+	else
+		req = queue->rskq_accept_head;
+
+	if (req && smc_sk(req->sk)->ordered && tcp_sk(req->sk)->syn_smc)
+		return smc_sk(parent)->tail_1;
+
+	return NULL;
+}
+
+static inline void smc_reqsk_queue_remove_locked(struct request_sock_queue *queue)
+{
+	struct request_sock *req;
+
+	req = queue->rskq_accept_head;
+	if (req) {
+		WRITE_ONCE(queue->rskq_accept_head, req->dl_next);
+		if (!queue->rskq_accept_head)
+			queue->rskq_accept_tail = NULL;
+	}
+}
+
+static inline void smc_reqsk_queue_add_locked(struct request_sock_queue *queue,
+					      struct request_sock *req)
+{
+	req->dl_next = NULL;
+	if (!queue->rskq_accept_head)
+		WRITE_ONCE(queue->rskq_accept_head, req);
+	else
+		queue->rskq_accept_tail->dl_next = req;
+	queue->rskq_accept_tail = req;
+}
+
+static inline void smc_reqsk_queue_join_locked(struct request_sock_queue *to,
+					       struct request_sock_queue *from)
+{
+	if (reqsk_queue_empty(from))
+		return;
+
+	if (reqsk_queue_empty(to)) {
+		to->rskq_accept_head = from->rskq_accept_head;
+		to->rskq_accept_tail = from->rskq_accept_tail;
+	} else {
+		to->rskq_accept_tail->dl_next = from->rskq_accept_head;
+		to->rskq_accept_tail = from->rskq_accept_tail;
+	}
+
+	from->rskq_accept_head = NULL;
+	from->rskq_accept_tail = NULL;
+}
+
+static inline void smc_reqsk_queue_cut_locked(struct request_sock_queue *queue,
+					      struct request_sock *tail,
+					      struct request_sock_queue *split)
+{
+	if (!tail) {
+		split->rskq_accept_tail = queue->rskq_accept_tail;
+		split->rskq_accept_head = queue->rskq_accept_head;
+		queue->rskq_accept_tail = NULL;
+		queue->rskq_accept_head = NULL;
+		return;
+	}
+
+	if (tail == queue->rskq_accept_tail) {
+		split->rskq_accept_tail = NULL;
+		split->rskq_accept_head = NULL;
+		return;
+	}
+
+	split->rskq_accept_head = tail->dl_next;
+	split->rskq_accept_tail = queue->rskq_accept_tail;
+	queue->rskq_accept_tail = tail;
+	tail->dl_next = NULL;
+}
+
+static inline void __smc_inet_sock_sort_csk_queue(struct sock *parent, int *tcp_cnt, int *smc_cnt)
+{
+	struct request_sock_queue  queue_smc, queue_free;
+	struct smc_sock *par = smc_sk(parent);
+	struct request_sock_queue *queue;
+	struct request_sock *req;
+	int cnt0, cnt1;
+
+	queue = &inet_csk(parent)->icsk_accept_queue;
+
+	spin_lock_bh(&queue->rskq_lock);
+
+	par->tail_0 = smc_inet_reqsk_get_safe_tail_0(parent);
+	par->tail_1 = smc_inet_reqsk_get_safe_tail_1(parent);
+
+	cnt0 = par->tail_0 ? smc_sk(par->tail_0->sk)->queued_cnt : 0;
+	cnt1 = par->tail_1 ? smc_sk(par->tail_1->sk)->queued_cnt : 0;
+
+	smc_reqsk_queue_cut_locked(queue, par->tail_0, &queue_smc);
+	smc_reqsk_queue_cut_locked(&queue_smc, par->tail_1, &queue_free);
+
+	/* scan all queue_free and re-add it */
+	while ((req = queue_free.rskq_accept_head)) {
+		smc_sk(req->sk)->ordered = 1;
+		smc_reqsk_queue_remove_locked(&queue_free);
+		/* It's not good at timecast, but better to understand */
+		if (tcp_sk(req->sk)->syn_smc) {
+			smc_reqsk_queue_add_locked(&queue_smc, req);
+			cnt1++;
+		} else {
+			smc_reqsk_queue_add_locked(queue, req);
+			cnt0++;
+		}
+	}
+	/* update tail */
+	par->tail_0 = queue->rskq_accept_tail;
+	par->tail_1 = queue_smc.rskq_accept_tail;
+
+	/* join queue */
+	smc_reqsk_queue_join_locked(queue, &queue_smc);
+
+	if (par->tail_0)
+		smc_sk(par->tail_0->sk)->queued_cnt = cnt0;
+
+	if (par->tail_1)
+		smc_sk(par->tail_1->sk)->queued_cnt = cnt1;
+
+	*tcp_cnt = cnt0;
+	*smc_cnt = cnt1;
+
+	spin_unlock_bh(&queue->rskq_lock);
+}
+
+static int smc_inet_sock_sort_csk_queue(struct sock *parent)
+{
+	int smc_cnt, tcp_cnt;
+	int mask = 0;
+
+	__smc_inet_sock_sort_csk_queue(parent, &tcp_cnt, &smc_cnt);
+	if (tcp_cnt)
+		mask |= SMC_REQSK_TCP;
+	if (smc_cnt)
+		mask |= SMC_REQSK_SMC;
+
+	return mask;
+}
+
+static void smc_inet_listen_work(struct work_struct *work)
+{
+	struct smc_sock *smc = container_of(work, struct smc_sock,
+					smc_listen_work);
+	struct sock *sk = &smc->sk;
+
+	/* Initialize accompanying socket */
+	smc_inet_sock_init_accompany_socket(sk);
+
+	/* current smc sock has not bee accept yet. */
+	rcu_assign_pointer(sk->sk_wq, &smc_sk(sk)->accompany_socket.wq);
+	smc_listen_work(work);
+}
+
+/* Wait for an incoming connection, avoid race conditions. This must be called
+ * with the socket locked.
+ */
+static int smc_inet_csk_wait_for_connect(struct sock *sk, long *timeo)
+{
+	struct inet_connection_sock *icsk = inet_csk(sk);
+	DEFINE_WAIT(wait);
+	int err;
+
+	lock_sock(sk);
+
+	/* True wake-one mechanism for incoming connections: only
+	 * one process gets woken up, not the 'whole herd'.
+	 * Since we do not 'race & poll' for established sockets
+	 * anymore, the common case will execute the loop only once.
+	 *
+	 * Subtle issue: "add_wait_queue_exclusive()" will be added
+	 * after any current non-exclusive waiters, and we know that
+	 * it will always _stay_ after any new non-exclusive waiters
+	 * because all non-exclusive waiters are added at the
+	 * beginning of the wait-queue. As such, it's ok to "drop"
+	 * our exclusiveness temporarily when we get woken up without
+	 * having to remove and re-insert us on the wait queue.
+	 */
+	for (;;) {
+		prepare_to_wait_exclusive(sk_sleep(sk), &wait,
+					  TASK_INTERRUPTIBLE);
+		release_sock(sk);
+		if (smc_accept_queue_empty(sk) && reqsk_queue_empty(&icsk->icsk_accept_queue))
+			*timeo = schedule_timeout(*timeo);
+		sched_annotate_sleep();
+		lock_sock(sk);
+		err = 0;
+		if (!reqsk_queue_empty(&icsk->icsk_accept_queue))
+			break;
+		if (!smc_accept_queue_empty(sk))
+			break;
+		err = -EINVAL;
+		if (sk->sk_state != TCP_LISTEN)
+			break;
+		err = sock_intr_errno(*timeo);
+		if (signal_pending(current))
+			break;
+		err = -EAGAIN;
+		if (!*timeo)
+			break;
+	}
+	finish_wait(sk_sleep(sk), &wait);
+	release_sock(sk);
+	return err;
+}
+
+struct sock *__smc_inet_csk_accept(struct sock *sk, int flags, int *err, bool kern, int next_state)
+{
+	struct sock *child;
+	int cur;
+
+	child = inet_csk_accept(sk, flags | O_NONBLOCK, err, kern);
+	if (child) {
+		smc_sk(child)->listen_smc = smc_sk(sk);
+
+		/* depends on syn_smc if next_state not specify */
+		if (next_state == SMC_NEGOTIATION_TBD)
+			next_state = tcp_sk(child)->syn_smc ? SMC_NEGOTIATION_PREPARE_SMC :
+				SMC_NEGOTIATION_NO_SMC;
+
+		cur = smc_inet_sock_move_state(child, SMC_NEGOTIATION_TBD,
+					       next_state);
+		switch (cur) {
+		case SMC_NEGOTIATION_NO_SMC:
+			smc_sk_set_state(child, SMC_ACTIVE);
+			smc_switch_to_fallback(smc_sk(child), SMC_CLC_DECL_PEERNOSMC);
+			break;
+		case SMC_NEGOTIATION_PREPARE_SMC:
+			/* init as passive open smc sock */
+			smc_sock_init_passive(sk, child);
+			break;
+		default:
+			break;
+		}
+	}
+	return child;
+}
+
+struct sock *smc_inet_csk_accept(struct sock *sk, int flags, int *err, bool kern)
+{
+	struct sock *child;
+	long timeo;
+
+	timeo = sock_rcvtimeo(sk, flags & O_NONBLOCK);
+
+again:
+	/* has smc sock */
+	if (!smc_accept_queue_empty(sk)) {
+		child = __smc_accept(sk, NULL, flags | O_NONBLOCK, err, kern);
+		if (child)
+			return child;
+	}
+
+	child = __smc_inet_csk_accept(sk, flags | O_NONBLOCK, err, kern, SMC_NEGOTIATION_TBD);
+	if (child) {
+		/* not smc sock */
+		if (smc_inet_sock_check_fallback_fast(child))
+			return child;
+		/* smc sock */
+		smc_inet_sock_do_handshake(child, /* sk not locked */ false, /* sync */ false);
+		*err = -EAGAIN;
+		child = NULL;
+	}
+
+	if (*err == -EAGAIN && timeo) {
+		*err = smc_inet_csk_wait_for_connect(sk, &timeo);
+		if (*err == 0)
+			goto again;
+	}
+
+	return NULL;
+}
+
+static void smc_inet_tcp_listen_work(struct work_struct *work)
+{
+	struct smc_sock *lsmc = container_of(work, struct smc_sock,
+					     tcp_listen_work);
+	struct sock *lsk = &lsmc->sk;
+	struct sock *child;
+	int error = 0;
+
+	while (smc_sk_state(lsk) == SMC_LISTEN &&
+	       (smc_inet_sock_sort_csk_queue(lsk) & SMC_REQSK_SMC)) {
+		child = __smc_inet_csk_accept(lsk, O_NONBLOCK, &error, 1,
+					      SMC_NEGOTIATION_PREPARE_SMC);
+		if (!child || error)
+			break;
+
+		/* run handshake for child
+		 * If child is a fallback connection, run a sync handshake to eliminate
+		 * the impact of queue_work().
+		 */
+		smc_inet_sock_do_handshake(child, /* sk not locked */ false,
+					   !tcp_sk(child)->syn_smc);
+	}
+}
+
+static void smc_inet_sock_data_ready(struct sock *sk)
+{
+	struct smc_sock *smc = smc_sk(sk);
+	int mask;
+
+	if (inet_sk_state_load(sk) == TCP_LISTEN) {
+		mask = smc_inet_sock_sort_csk_queue(sk);
+		if (mask & SMC_REQSK_TCP || !smc_accept_queue_empty(sk))
+			smc->clcsk_data_ready(sk);
+		if (mask & SMC_REQSK_SMC)
+			queue_work(smc_tcp_ls_wq, &smc->tcp_listen_work);
+	} else {
+		write_lock_bh(&sk->sk_callback_lock);
+		sk->sk_data_ready = smc->clcsk_data_ready;
+		write_unlock_bh(&sk->sk_callback_lock);
+		smc->clcsk_data_ready(sk);
+	}
+}
+
+int smc_inet_listen(struct socket *sock, int backlog)
+{
+	struct sock *sk = sock->sk;
+	bool need_init = false;
+	struct smc_sock *smc;
+
+	smc = smc_sk(sk);
+
+	write_lock_bh(&sk->sk_callback_lock);
+	/* still wish to accept smc sock */
+	if (isck_smc_negotiation_load(smc) == SMC_NEGOTIATION_TBD) {
+		need_init = tcp_sk(sk)->syn_smc = 1;
+		isck_smc_negotiation_set_flags(smc, SMC_NEGOTIATION_LISTEN_FLAG);
+	}
+	write_unlock_bh(&sk->sk_callback_lock);
+
+	if (need_init) {
+		lock_sock(sk);
+		if (smc_sk_state(sk) == SMC_INIT)  {
+			smc_init_listen(smc);
+			INIT_WORK(&smc->tcp_listen_work, smc_inet_tcp_listen_work);
+			smc_clcsock_replace_cb(&sk->sk_data_ready, smc_inet_sock_data_ready,
+					       &smc->clcsk_data_ready);
+			smc_sk_set_state(sk, SMC_LISTEN);
+		}
+		release_sock(sk);
+	}
+	return inet_listen(sock, backlog);
+}
+
+static int __smc_inet_connect_work_locked(struct smc_sock *smc)
+{
+	int rc;
+
+	rc = __smc_connect(smc);
+	if (rc < 0)
+		smc->sk.sk_err = -rc;
+
+	smc_inet_sock_move_state(&smc->sk, SMC_NEGOTIATION_PREPARE_SMC,
+				 (smc->use_fallback &&
+				 smc_sk_state(&smc->sk) == SMC_ACTIVE) ?
+				 SMC_NEGOTIATION_NO_SMC : SMC_NEGOTIATION_SMC);
+
+	if (!smc_sock_flag(&smc->sk, SOCK_DEAD)) {
+		if (smc->sk.sk_err)
+			smc->sk.sk_state_change(&smc->sk);
+		else
+			smc->sk.sk_write_space(&smc->sk);
+	}
+
+	return rc;
+}
+
+static void smc_inet_connect_work(struct work_struct *work)
+{
+	struct smc_sock *smc = container_of(work, struct smc_sock,
+					connect_work);
+
+	sock_hold(&smc->sk);		/* sock put bellow */
+	lock_sock(&smc->sk);
+	__smc_inet_connect_work_locked(smc);
+	release_sock(&smc->sk);
+	sock_put(&smc->sk);			/* sock hold above */
+}
+
+/* caller MUST not access sk after smc_inet_sock_do_handshake
+ * is invoked unless a sock_hold() has performed beforehand.
+ */
+static int smc_inet_sock_do_handshake(struct sock *sk, bool sk_locked, bool sync)
+{
+	struct smc_sock *smc = smc_sk(sk);
+	int rc = 0;
+
+	if (smc_inet_sock_is_active_open(sk)) {
+		INIT_WORK(&smc->connect_work, smc_inet_connect_work);
+		if (!sync) {
+			queue_work(smc_hs_wq, &smc->connect_work);
+			return 0;
+		}
+		if (sk_locked)
+			return __smc_inet_connect_work_locked(smc);
+		lock_sock(sk);
+		rc = __smc_inet_connect_work_locked(smc);
+		release_sock(sk);
+		return rc;
+	}
+
+	INIT_WORK(&smc->smc_listen_work, smc_inet_listen_work);
+	/* protected listen_smc during smc_inet_listen_work */
+	sock_hold(&smc->listen_smc->sk);
+
+	if (!sync)
+		queue_work(smc_hs_wq, &smc->smc_listen_work);
+	else
+		smc_inet_listen_work(&smc->smc_listen_work);
+
+	/* listen work has no retval */
+	return 0;
+}
+
+void smc_inet_sock_state_change(struct sock *sk)
+{
+	struct smc_sock *smc = smc_sk(sk);
+	int cur;
+
+	if (sk->sk_err || (1 << sk->sk_state) & (TCPF_CLOSE_WAIT | TCPF_ESTABLISHED)) {
+		write_lock_bh(&sk->sk_callback_lock);
+
+		/* resume sk_state_change */
+		sk->sk_state_change = smc->clcsk_state_change;
+
+		/* cause by abort */
+		if (isck_smc_negotiation_get_flags(smc_sk(sk)) & SMC_NEGOTIATION_ABORT_FLAG)
+			goto out_unlock;
+
+		if (isck_smc_negotiation_load(smc) != SMC_NEGOTIATION_TBD)
+			goto out_unlock;
+
+		cur = smc_inet_sock_move_state_locked(sk, SMC_NEGOTIATION_TBD,
+						      (tcp_sk(sk)->syn_smc &&
+						      !sk->sk_err) ?
+						      SMC_NEGOTIATION_PREPARE_SMC :
+						      SMC_NEGOTIATION_NO_SMC);
+
+		if (cur == SMC_NEGOTIATION_PREPARE_SMC) {
+			smc_inet_sock_do_handshake(sk, /* not locked */ false, /* async */ false);
+		} else if (cur == SMC_NEGOTIATION_NO_SMC) {
+			smc->use_fallback = true;
+			smc->fallback_rsn = SMC_CLC_DECL_PEERNOSMC;
+			smc_stat_fallback(smc);
+			trace_smc_switch_to_fallback(smc, SMC_CLC_DECL_PEERNOSMC);
+			smc->connect_nonblock = 0;
+			smc_sk_set_state(&smc->sk, SMC_ACTIVE);
+		}
+out_unlock:
+		write_unlock_bh(&sk->sk_callback_lock);
+	}
+
+	smc->clcsk_state_change(sk);
+}
+
+int smc_inet_init_sock(struct sock *sk)
+{
+	struct smc_sock *smc = smc_sk(sk);
+	int rc;
+
+	tcp_sk(sk)->is_smc = 1;
+
+	/* Call tcp init sock first */
+	rc = smc_inet_get_tcp_prot(sk->sk_family)->init(sk);
+	if (rc)
+		return rc;
+
+	/* init common smc sock */
+	smc_sock_init(sk, sock_net(sk));
+
+	/* IPPROTO_SMC does not exist in network, we MUST
+	 * reset it to IPPROTO_TCP before connect.
+	 */
+	sk->sk_protocol = IPPROTO_TCP;
+
+	/* Initialize smc_sock state */
+	smc_sk_set_state(sk, SMC_INIT);
+
+	/* built link */
+	smc_inet_sock_init_accompany_socket(sk);
+
+	/* Initialize negotiation state, see more details in
+	 * enum smc_inet_sock_negotiation_state.
+	 */
+	isck_smc_negotiation_store(smc, SMC_NEGOTIATION_TBD);
+
+	return 0;
+}
+
+void smc_inet_sock_proto_release_cb(struct sock *sk)
+{
+	tcp_release_cb(sk);
+
+	/* smc_release_cb only works for socks who identified
+	 * as SMC. Note listen sock will also return here.
+	 */
+	if (!smc_inet_sock_check_smc(sk))
+		return;
+
+	smc_release_cb(sk);
+}
+
+int smc_inet_connect(struct socket *sock, struct sockaddr *addr,
+		     int alen, int flags)
+{
+	return smc_connect(sock, addr, alen, flags);
+}
+
+int smc_inet_setsockopt(struct socket *sock, int level, int optname,
+			sockptr_t optval, unsigned int optlen)
+{
+	struct sock *sk = sock->sk;
+	struct smc_sock *smc;
+	bool fallback;
+	int rc;
+
+	smc = smc_sk(sk);
+	fallback = smc_inet_sock_check_fallback(sk);
+
+	if (level == SOL_SMC)
+		return __smc_setsockopt(sock, level, optname, optval, optlen);
+
+	/* Note that we always need to check if it's an unsupported
+	 * options before set it to the given value via sock_common_setsockopt().
+	 * This is because if we set it after we found it is not supported to smc and
+	 * we have no idea to fallback, we have to report this error to userspace.
+	 * However, the user might find it is set correctly via sock_common_getsockopt().
+	 */
+	if (!fallback && level == SOL_TCP && smc_is_unsupport_tcp_sockopt(optname)) {
+		/* can not fallback, but with not-supported option */
+		if (!smc_inet_sock_try_disable_smc(sk, SMC_NEGOTIATION_NOT_SUPPORT_FLAG))
+			return -EOPNOTSUPP;
+		fallback = true;
+		smc_switch_to_fallback(smc_sk(sk), SMC_CLC_DECL_OPTUNSUPP);
+	}
+
+	/* call original setsockopt */
+	rc = sock_common_setsockopt(sock, level, optname, optval, optlen);
+	if (rc)
+		return rc;
+
+	/* already be fallback */
+	if (fallback)
+		return 0;
+
+	/* deliver to smc if needed */
+	return smc_setsockopt_common(sock, level, optname, optval, optlen);
+}
+
+int smc_inet_getsockopt(struct socket *sock, int level, int optname,
+			char __user *optval, int __user *optlen)
+{
+	if (level == SOL_SMC)
+		return __smc_getsockopt(sock, level, optname, optval, optlen);
+
+	/* smc_getsockopt is just a wrap on sock_common_getsockopt
+	 * So we don't need to reuse it.
+	 */
+	return sock_common_getsockopt(sock, level, optname, optval, optlen);
+}
+
+int smc_inet_ioctl(struct socket *sock, unsigned int cmd,
+		   unsigned long arg)
+{
+	struct sock *sk = sock->sk;
+	int rc;
+
+	if (smc_inet_sock_check_fallback(sk))
+fallback:
+		return smc_call_inet_sock_ops(sk, inet_ioctl, inet6_ioctl, sock, cmd, arg);
+
+	rc = smc_ioctl(sock, cmd, arg);
+	if (unlikely(smc_sk(sk)->use_fallback))
+		goto fallback;
+
+	return rc;
+}
+
+int smc_inet_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
+{
+	struct sock *sk = sock->sk;
+	struct smc_sock *smc;
+	int rc;
+
+	smc = smc_sk(sk);
+
+	/* Send before connected, might be fastopen or user's incorrect usage, but
+	 * whatever, in either case, we do not need to replace it with SMC any more.
+	 * If it dues to user's incorrect usage, then it is also an error for TCP.
+	 * Users should correct that error themselves.
+	 */
+	if (smc_inet_sock_rectify_state(sk) == SMC_NEGOTIATION_NO_SMC)
+		goto no_smc;
+
+	rc = smc_sendmsg(sock, msg, len);
+	if (likely(!smc->use_fallback))
+		return rc;
+
+	/* Fallback during smc_sendmsg */
+no_smc:
+	return smc_call_inet_sock_ops(sk, inet_sendmsg, inet6_sendmsg, sock, msg, len);
+}
+
+int smc_inet_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
+		     int flags)
+{
+	struct sock *sk = sock->sk;
+	struct smc_sock *smc;
+	int rc;
+
+	smc = smc_sk(sk);
+
+	/* Recv before connection goes established, it's okay for TCP but not
+	 * support in SMC（see smc_recvmsg), we should try our best to fallback
+	 * if passible.
+	 */
+	if (smc_inet_sock_rectify_state(sk) == SMC_NEGOTIATION_NO_SMC)
+		goto no_smc;
+
+	rc = smc_recvmsg(sock, msg, len, flags);
+	if (likely(!smc->use_fallback))
+		return rc;
+
+	/* Fallback during smc_recvmsg */
+no_smc:
+	return smc_call_inet_sock_ops(sk, inet_recvmsg, inet6_recvmsg, sock, msg, len, flags);
+}
+
+ssize_t smc_inet_splice_read(struct socket *sock, loff_t *ppos,
+			     struct pipe_inode_info *pipe, size_t len,
+			     unsigned int flags)
+{
+	struct sock *sk = sock->sk;
+	struct smc_sock *smc;
+	int rc;
+
+	smc = smc_sk(sk);
+
+	if (smc_inet_sock_rectify_state(sk) == SMC_NEGOTIATION_NO_SMC)
+		goto no_smc;
+
+	rc = smc_splice_read(sock, ppos, pipe, len, flags);
+	if (likely(!smc->use_fallback))
+		return rc;
+
+	/* Fallback during smc_splice_read */
+no_smc:
+	return tcp_splice_read(sock, ppos, pipe, len, flags);
+}
+
+static inline __poll_t smc_inet_listen_poll(struct file *file, struct socket *sock,
+					    poll_table *wait)
+{
+	__poll_t mask;
+
+	mask = tcp_poll(file, sock, wait);
+	/* no tcp sock */
+	if (!(smc_inet_sock_sort_csk_queue(sock->sk) & SMC_REQSK_TCP))
+		mask &= ~(EPOLLIN | EPOLLRDNORM);
+	mask |= smc_accept_poll(sock->sk);
+	return mask;
+}
+
+__poll_t smc_inet_poll(struct file *file, struct socket *sock, poll_table *wait)
+{
+	struct sock *sk = sock->sk;
+	__poll_t mask;
+
+	if (smc_inet_sock_check_fallback_fast(sk))
+no_smc:
+		return tcp_poll(file, sock, wait);
+
+	/* special case */
+	if (inet_sk_state_load(sk) == TCP_LISTEN)
+		return smc_inet_listen_poll(file, sock, wait);
+
+	mask = smc_poll(file, sock, wait);
+	if (smc_sk(sk)->use_fallback)
+		goto no_smc;
+
+	return mask;
+}
+
+int smc_inet_shutdown(struct socket *sock, int how)
+{
+	struct sock *sk = sock->sk;
+	struct smc_sock *smc;
+	int rc;
+
+	smc = smc_sk(sk);
+
+	/* All state changes of sock are handled by inet_shutdown,
+	 * smc only needs to be responsible for
+	 * executing the corresponding semantics.
+	 */
+	rc = inet_shutdown(sock, how);
+	if (rc)
+		return rc;
+
+	/* shutdown during SMC_NEGOTIATION_TBD, we can force it to be
+	 * fallback.
+	 */
+	if (smc_inet_sock_try_disable_smc(sk, SMC_NEGOTIATION_ABORT_FLAG))
+		return 0;
+
+	/* executing the corresponding semantics if can not be fallback */
+	lock_sock(sk);
+	switch (how) {
+	case SHUT_RDWR:		/* shutdown in both directions */
+		rc = smc_close_active(smc);
+		break;
+	case SHUT_WR:
+		rc = smc_close_shutdown_write(smc);
+		break;
+	case SHUT_RD:
+		rc = 0;
+		/* nothing more to do because peer is not involved */
+		break;
+	}
+	release_sock(sk);
+	return rc;
+}
+
+int smc_inet_release(struct socket *sock)
+{
+	struct sock *sk = sock->sk;
+	struct smc_sock *smc;
+	int old_state, rc;
+	bool do_free = false;
+
+	if (!sk)
+		return 0;
+
+	smc = smc_sk(sk);
+
+	old_state = smc_sk_state(sk);
+
+	sock_hold(sk);	/* sock put bellow */
+
+	smc_inet_sock_try_disable_smc(sk, SMC_NEGOTIATION_ABORT_FLAG);
+
+	/* check fallback ? */
+	if (smc_inet_sock_check_fallback(sk)) {
+		if (smc_sk_state(sk) == SMC_ACTIVE)
+			sock_put(sk);	/* sock put for passive closing */
+		smc_sock_set_flag(sk, SOCK_DEAD);
+		smc_sk_set_state(sk, SMC_CLOSED);
+		goto out;
+	}
+
+	if (smc->connect_nonblock && cancel_work_sync(&smc->connect_work))
+		sock_put(&smc->sk); /* sock_hold for passive closing */
+
+	if (smc_sk_state(sk) == SMC_LISTEN)
+		/* smc_close_non_accepted() is called and acquires
+		 * sock lock for child sockets again
+		 */
+		lock_sock_nested(sk, SINGLE_DEPTH_NESTING);
+	else
+		lock_sock(sk);
+
+	if (!smc->use_fallback) {
+		/* ret of smc_close_active do not need return to userspace */
+		smc_close_active(smc);
+		do_free = true;
+	} else {
+		if (smc_sk_state(sk) == SMC_ACTIVE)
+			sock_put(sk);	 /* sock put for passive closing */
+		smc_sk_set_state(sk, SMC_CLOSED);
+	}
+	smc_sock_set_flag(sk, SOCK_DEAD);
+
+	release_sock(sk);
+out:
+	/* release tcp sock */
+	rc = smc_call_inet_sock_ops(sk, inet_release, inet6_release, sock);
+
+	if (do_free) {
+		lock_sock(sk);
+		if (smc_sk_state(sk) == SMC_CLOSED)
+			smc_conn_free(&smc->conn);
+		release_sock(sk);
+	}
+	sock_put(sk);	/* sock hold above */
+	return rc;
+}
+
 static int __init smc_init(void)
 {
 	int rc;
diff --git a/net/smc/smc.h b/net/smc/smc.h
index 538920f..0507e98 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -251,9 +251,14 @@ struct smc_sock {				/* smc sock container */
 		struct sock sk;
 	};
 	struct socket		*clcsock;	/* internal tcp socket */
+	struct socket		accompany_socket;
 	unsigned char		smc_state;	/* smc state used in smc via inet_sk */
 	unsigned int		isck_smc_negotiation;
 	unsigned long		smc_sk_flags;	/* smc sock flags used for inet sock */
+	unsigned int	queued_cnt;
+	struct request_sock	*tail_0;
+	struct request_sock	*tail_1;
+	struct request_sock	*reqsk;
 	void			(*clcsk_state_change)(struct sock *sk);
 						/* original stat_change fct. */
 	void			(*clcsk_data_ready)(struct sock *sk);
@@ -262,6 +267,7 @@ struct smc_sock {				/* smc sock container */
 						/* original write_space fct. */
 	void			(*clcsk_error_report)(struct sock *sk);
 						/* original error_report fct. */
+	void			(*original_sk_destruct)(struct sock *sk);
 	struct smc_connection	conn;		/* smc connection */
 	struct smc_sock		*listen_smc;	/* listen parent */
 	struct work_struct	connect_work;	/* handle non-blocking connect*/
@@ -290,6 +296,7 @@ struct smc_sock {				/* smc sock container */
 						/* non-blocking connect in
 						 * flight
 						 */
+	u8			ordered : 1;
 	struct mutex            clcsock_release_lock;
 						/* protects clcsock of a listen
 						 * socket
diff --git a/net/smc/smc_cdc.h b/net/smc/smc_cdc.h
index 696cc11..4b33947a 100644
--- a/net/smc/smc_cdc.h
+++ b/net/smc/smc_cdc.h
@@ -302,4 +302,12 @@ int smcr_cdc_msg_send_validation(struct smc_connection *conn,
 int smc_cdc_init(void) __init;
 void smcd_cdc_rx_init(struct smc_connection *conn);
 
+static inline bool smc_has_rcv_shutdown(struct sock *sk)
+{
+	if (smc_sock_is_inet_sock(sk))
+		return smc_cdc_rxed_any_close_or_senddone(&smc_sk(sk)->conn);
+	else
+		return sk->sk_shutdown & RCV_SHUTDOWN;
+}
+
 #endif /* SMC_CDC_H */
diff --git a/net/smc/smc_clc.h b/net/smc/smc_clc.h
index 7cc7070..5bcd7a3 100644
--- a/net/smc/smc_clc.h
+++ b/net/smc/smc_clc.h
@@ -35,6 +35,7 @@
 #define SMC_CLC_DECL_TIMEOUT_AL	0x02020000  /* timeout w4 QP add link	      */
 #define SMC_CLC_DECL_CNFERR	0x03000000  /* configuration error            */
 #define SMC_CLC_DECL_PEERNOSMC	0x03010000  /* peer did not indicate SMC      */
+#define SMC_CLC_DECL_ACTIVE		0x03010001	/* local active fallback */
 #define SMC_CLC_DECL_IPSEC	0x03020000  /* IPsec usage		      */
 #define SMC_CLC_DECL_NOSMCDEV	0x03030000  /* no SMC device found (R or D)   */
 #define SMC_CLC_DECL_NOSMCDDEV	0x03030001  /* no SMC-D device found	      */
diff --git a/net/smc/smc_close.c b/net/smc/smc_close.c
index 8d9512e..098b123 100644
--- a/net/smc/smc_close.c
+++ b/net/smc/smc_close.c
@@ -19,6 +19,7 @@
 #include "smc_tx.h"
 #include "smc_cdc.h"
 #include "smc_close.h"
+#include "smc_inet.h"
 
 /* release the clcsock that is assigned to the smc_sock */
 void smc_clcsock_release(struct smc_sock *smc)
@@ -27,6 +28,10 @@ void smc_clcsock_release(struct smc_sock *smc)
 
 	if (smc->listen_smc && current_work() != &smc->smc_listen_work)
 		cancel_work_sync(&smc->smc_listen_work);
+
+	if (smc_sock_is_inet_sock(&smc->sk))
+		return;
+
 	mutex_lock(&smc->clcsock_release_lock);
 	if (smc->clcsock) {
 		tcp = smc->clcsock;
@@ -130,11 +135,16 @@ void smc_close_active_abort(struct smc_sock *smc)
 	struct sock *sk = &smc->sk;
 	bool release_clcsock = false;
 
-	if (smc_sk_state(sk) != SMC_INIT && smc->clcsock && smc->clcsock->sk) {
-		sk->sk_err = ECONNABORTED;
-		if (smc->clcsock && smc->clcsock->sk)
+	if (smc_sk_state(sk) != SMC_INIT) {
+		/* sock locked */
+		if (smc_sock_is_inet_sock(sk)) {
+			smc_inet_sock_abort(sk);
+		} else if (smc->clcsock && smc->clcsock->sk) {
+			sk->sk_err = ECONNABORTED;
 			tcp_abort(smc->clcsock->sk, ECONNABORTED);
+		}
 	}
+
 	switch (smc_sk_state(sk)) {
 	case SMC_ACTIVE:
 	case SMC_APPCLOSEWAIT1:
diff --git a/net/smc/smc_inet.c b/net/smc/smc_inet.c
index d35b567..353f6a8 100644
--- a/net/smc/smc_inet.c
+++ b/net/smc/smc_inet.c
@@ -36,7 +36,7 @@ struct proto smc_inet_prot = {
 	.name			= "SMC",
 	.owner			= THIS_MODULE,
 	.close			= tcp_close,
-	.pre_connect		= NULL,
+	.pre_connect	= NULL,
 	.connect		= tcp_v4_connect,
 	.disconnect		= tcp_disconnect,
 	.accept			= smc_inet_csk_accept,
@@ -121,7 +121,7 @@ struct proto smc_inet6_prot = {
 	.name			= "SMCv6",
 	.owner			= THIS_MODULE,
 	.close			= tcp_close,
-	.pre_connect		= NULL,
+	.pre_connect	= NULL,
 	.connect		= NULL,
 	.disconnect		= tcp_disconnect,
 	.accept			= smc_inet_csk_accept,
@@ -145,6 +145,7 @@ struct proto smc_inet6_prot = {
 	.stream_memory_free	= tcp_stream_memory_free,
 	.sockets_allocated	= &tcp_sockets_allocated,
 	.memory_allocated	= &tcp_memory_allocated,
+	.per_cpu_fw_alloc       = &tcp_memory_per_cpu_fw_alloc,
 	.memory_pressure	= &tcp_memory_pressure,
 	.orphan_count		= &tcp_orphan_count,
 	.sysctl_mem		= sysctl_tcp_mem,
@@ -203,6 +204,54 @@ struct inet_protosw smc_inet6_protosw = {
 };
 #endif
 
+int smc_inet_sock_move_state(struct sock *sk, int except, int target)
+{
+	int rc;
+
+	write_lock_bh(&sk->sk_callback_lock);
+	rc = smc_inet_sock_move_state_locked(sk, except, target);
+	write_unlock_bh(&sk->sk_callback_lock);
+	return rc;
+}
+
+int smc_inet_sock_move_state_locked(struct sock *sk, int except, int target)
+{
+	struct smc_sock *smc = smc_sk(sk);
+	int cur;
+
+	cur = isck_smc_negotiation_load(smc);
+	if (cur != except)
+		return cur;
+
+	switch (cur) {
+	case SMC_NEGOTIATION_TBD:
+		switch (target) {
+		case SMC_NEGOTIATION_PREPARE_SMC:
+		case SMC_NEGOTIATION_NO_SMC:
+			isck_smc_negotiation_store(smc, target);
+			sock_hold(sk);	/* sock hold for passive closing */
+			return target;
+		default:
+			break;
+		}
+		break;
+	case SMC_NEGOTIATION_PREPARE_SMC:
+		switch (target) {
+		case SMC_NEGOTIATION_NO_SMC:
+		case SMC_NEGOTIATION_SMC:
+			isck_smc_negotiation_store(smc, target);
+			return target;
+		default:
+			break;
+		}
+		break;
+	default:
+		break;
+	}
+
+	return cur;
+}
+
 int smc_inet_sock_init(void)
 {
 	struct proto *tcp_v4prot;
@@ -231,6 +280,7 @@ int smc_inet_sock_init(void)
 	 * ensure consistency with TCP. Some symbols here have not been exported,
 	 * so that we have to assign it here.
 	 */
+
 	smc_inet_prot.pre_connect = tcp_v4prot->pre_connect;
 
 #if IS_ENABLED(CONFIG_IPV6)
@@ -243,73 +293,158 @@ int smc_inet_sock_init(void)
 	return 0;
 }
 
-int smc_inet_init_sock(struct sock *sk) { return  0; }
+static int smc_inet_clcsock_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
+{
+	struct sock *sk = sock->sk;
+	struct smc_sock *smc;
 
-void smc_inet_sock_proto_release_cb(struct sock *sk) {}
+	smc = smc_sk(sock->sk);
 
-int smc_inet_connect(struct socket *sock, struct sockaddr *addr,
-		     int alen, int flags)
-{
-	return -EOPNOTSUPP;
-}
+	if (current_work() == &smc->smc_listen_work)
+		return tcp_sendmsg(sk, msg, len);
 
-int smc_inet_setsockopt(struct socket *sock, int level, int optname,
-			sockptr_t optval, unsigned int optlen)
-{
-	return -EOPNOTSUPP;
-}
+	/* smc_inet_clcsock_sendmsg only works for smc handshaking
+	 * fallback sendmsg should process by smc_inet_sendmsg.
+	 * see more details in smc_inet_sendmsg().
+	 */
+	if (smc->use_fallback)
+		return -EOPNOTSUPP;
 
-int smc_inet_getsockopt(struct socket *sock, int level, int optname,
-			char __user *optval, int __user *optlen)
-{
-	return -EOPNOTSUPP;
+	/* It is difficult for us to determine whether the current sk is locked.
+	 * Therefore, we rely on the implementation of conenct_work() implementation, which
+	 * is locked always.
+	 */
+	return tcp_sendmsg_locked(sk, msg, len);
 }
 
-int smc_inet_ioctl(struct socket *sock, unsigned int cmd,
-		   unsigned long arg)
+int smc_sk_wait_tcp_data(struct sock *sk, long *timeo, const struct sk_buff *skb)
 {
-	return -EOPNOTSUPP;
+	DEFINE_WAIT_FUNC(wait, woken_wake_function);
+	int rc;
+
+	lock_sock(sk);
+	add_wait_queue(sk_sleep(sk), &wait);
+	sk_set_bit(SOCKWQ_ASYNC_WAITDATA, sk);
+	rc = sk_wait_event(sk, timeo, skb_peek_tail(&sk->sk_receive_queue) != skb ||
+			   isck_smc_negotiation_get_flags(smc_sk(sk)) & SMC_NEGOTIATION_ABORT_FLAG,
+			   &wait);
+	sk_clear_bit(SOCKWQ_ASYNC_WAITDATA, sk);
+	remove_wait_queue(sk_sleep(sk), &wait);
+	release_sock(sk);
+	return rc;
 }
 
-int smc_inet_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
+static int smc_inet_clcsock_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
+				    int flags)
 {
-	return -EOPNOTSUPP;
+	struct sock *sk = sock->sk;
+	struct smc_sock *smc;
+	int addr_len, err;
+	long timeo;
+
+	smc = smc_sk(sock->sk);
+
+	/* smc_inet_clcsock_recvmsg only works for smc handshaking
+	 * fallback recvmsg should process by smc_inet_recvmsg.
+	 */
+	if (smc->use_fallback)
+		return -EOPNOTSUPP;
+
+	if (likely(!(flags & MSG_ERRQUEUE)))
+		sock_rps_record_flow(sk);
+
+	timeo = sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
+
+	/* Locked, see more details in smc_inet_clcsock_sendmsg() */
+	if (current_work() != &smc->smc_listen_work)
+		release_sock(sock->sk);
+again:
+	/* recv nonblock */
+	err = tcp_recvmsg(sk, msg, len, flags | MSG_DONTWAIT, &addr_len);
+	if (err != -EAGAIN || !timeo)
+		goto out;
+
+	smc_sk_wait_tcp_data(sk, &timeo, NULL);
+	if (isck_smc_negotiation_get_flags(smc_sk(sk)) & SMC_NEGOTIATION_ABORT_FLAG) {
+		err = -ECONNABORTED;
+		goto out;
+	}
+	goto again;
+out:
+	if (current_work() != &smc->smc_listen_work) {
+		lock_sock(sock->sk);
+		/* since we release sock before, there might be state changed */
+		if (err >= 0 && smc_sk_state(&smc->sk) != SMC_INIT)
+			err = -EPIPE;
+	}
+	if (err >= 0)
+		msg->msg_namelen = addr_len;
+	return err;
 }
 
-int smc_inet_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
-		     int flags)
+static ssize_t smc_inet_clcsock_splice_read(struct socket *sock, loff_t *ppos,
+					    struct pipe_inode_info *pipe, size_t len,
+					    unsigned int flags)
 {
+	/* fallback splice_read should process by smc_inet_splice_read.  */
 	return -EOPNOTSUPP;
 }
 
-ssize_t smc_inet_splice_read(struct socket *sock, loff_t *ppos,
-			     struct pipe_inode_info *pipe, size_t len,
-			     unsigned int flags)
+static int smc_inet_clcsock_connect(struct socket *sock, struct sockaddr *addr,
+				    int alen, int flags)
 {
-	return -EOPNOTSUPP;
+	/* smc_connect will lock the sock->sk */
+	return __inet_stream_connect(sock, addr, alen, flags, 0);
 }
 
-__poll_t smc_inet_poll(struct file *file, struct socket *sock, poll_table *wait)
+static int smc_inet_clcsock_shutdown(struct socket *sock, int how)
 {
+	/* shutdown could call from smc_close_active, we should
+	 * not fail it.
+	 */
 	return 0;
 }
 
-struct sock *smc_inet_csk_accept(struct sock *sk, int flags, int *err, bool kern)
+static int smc_inet_clcsock_release(struct socket *sock)
 {
-	return NULL;
+	/* shutdown could call from smc_close_active, we should
+	 * not fail it.
+	 */
+	return 0;
 }
 
-int smc_inet_listen(struct socket *sock, int backlog)
+static int smc_inet_clcsock_getname(struct socket *sock, struct sockaddr *addr,
+				    int peer)
 {
-	return -EOPNOTSUPP;
-}
+	int rc;
 
-int smc_inet_shutdown(struct socket *sock, int how)
-{
-	return -EOPNOTSUPP;
+	release_sock(sock->sk);
+	rc = sock->sk->sk_family == PF_INET ? inet_getname(sock, addr, peer) :
+#if IS_ENABLED(CONFIG_IPV6)
+		inet6_getname(sock, addr, peer);
+#else
+		-EINVAL;
+#endif
+	lock_sock(sock->sk);
+	return rc;
 }
 
-int smc_inet_release(struct socket *sock)
+static __poll_t smc_inet_clcsock_poll(struct file *file, struct socket *sock,
+				      poll_table *wait)
 {
-	return -EOPNOTSUPP;
+	return 0;
 }
+
+const struct proto_ops smc_inet_clcsock_ops = {
+	.family			= PF_UNSPEC,
+	/* It is not a real ops, its lifecycle is bound to the SMC module. */
+	.owner			= NULL,
+	.release		= smc_inet_clcsock_release,
+	.getname		= smc_inet_clcsock_getname,
+	.connect		= smc_inet_clcsock_connect,
+	.shutdown		= smc_inet_clcsock_shutdown,
+	.sendmsg		= smc_inet_clcsock_sendmsg,
+	.recvmsg		= smc_inet_clcsock_recvmsg,
+	.splice_read	= smc_inet_clcsock_splice_read,
+	.poll			= smc_inet_clcsock_poll,
+};
diff --git a/net/smc/smc_inet.h b/net/smc/smc_inet.h
index 1f182c0..a8c3c11 100644
--- a/net/smc/smc_inet.h
+++ b/net/smc/smc_inet.h
@@ -30,6 +30,10 @@
 extern struct inet_protosw smc_inet_protosw;
 extern struct inet_protosw smc_inet6_protosw;
 
+extern const struct proto_ops smc_inet_clcsock_ops;
+
+void smc_inet_sock_state_change(struct sock *sk);
+
 enum smc_inet_sock_negotiation_state {
 	/* When creating an AF_SMC sock, the state field will be initialized to 0 by default,
 	 * which is only for logical compatibility with that situation
@@ -64,6 +68,7 @@ enum smc_inet_sock_negotiation_state {
 	/* flags */
 	SMC_NEGOTIATION_LISTEN_FLAG = 0x01,
 	SMC_NEGOTIATION_ABORT_FLAG = 0x02,
+	SMC_NEGOTIATION_NOT_SUPPORT_FLAG = 0x04,
 };
 
 static __always_inline void isck_smc_negotiation_store(struct smc_sock *smc,
@@ -123,6 +128,96 @@ static inline void smc_inet_sock_abort(struct sock *sk)
 	sk->sk_error_report(sk);
 }
 
+int smc_inet_sock_move_state(struct sock *sk, int except, int target);
+int smc_inet_sock_move_state_locked(struct sock *sk, int except, int target);
+
+static inline int smc_inet_sock_set_syn_smc_locked(struct sock *sk, int value)
+{
+	int flags;
+
+	/* not set syn smc */
+	if (value == 0) {
+		if (smc_sk_state(sk) != SMC_LISTEN) {
+			smc_inet_sock_move_state_locked(sk, SMC_NEGOTIATION_TBD,
+							SMC_NEGOTIATION_NO_SMC);
+			smc_sk_set_state(sk, SMC_ACTIVE);
+		}
+		return 0;
+	}
+	/* set syn smc */
+	flags = isck_smc_negotiation_get_flags(smc_sk(sk));
+	if (isck_smc_negotiation_load(smc_sk(sk)) != SMC_NEGOTIATION_TBD)
+		return 0;
+	if (flags & SMC_NEGOTIATION_ABORT_FLAG)
+		return 0;
+	if (flags & SMC_NEGOTIATION_NOT_SUPPORT_FLAG)
+		return 0;
+	tcp_sk(sk)->syn_smc = 1;
+	return 1;
+}
+
+static inline int smc_inet_sock_try_disable_smc(struct sock *sk, int flag)
+{
+	struct smc_sock *smc = smc_sk(sk);
+	int success = 0;
+
+	write_lock_bh(&sk->sk_callback_lock);
+	switch (isck_smc_negotiation_load(smc)) {
+	case SMC_NEGOTIATION_TBD:
+		/* can not disable now */
+		if (flag != SMC_NEGOTIATION_ABORT_FLAG && tcp_sk(sk)->syn_smc)
+			break;
+		isck_smc_negotiation_set_flags(smc_sk(sk), flag);
+		fallthrough;
+	case SMC_NEGOTIATION_NO_SMC:
+		success = 1;
+	default:
+		break;
+	}
+	write_unlock_bh(&sk->sk_callback_lock);
+	return success;
+}
+
+static inline int smc_inet_sock_rectify_state(struct sock *sk)
+{
+	int cur = isck_smc_negotiation_load(smc_sk(sk));
+
+	switch (cur) {
+	case SMC_NEGOTIATION_TBD:
+		if (!smc_inet_sock_try_disable_smc(sk, SMC_NEGOTIATION_NOT_SUPPORT_FLAG))
+			break;
+		fallthrough;
+	case SMC_NEGOTIATION_NO_SMC:
+		return SMC_NEGOTIATION_NO_SMC;
+	default:
+		break;
+	}
+	return cur;
+}
+
+static __always_inline void smc_inet_sock_init_accompany_socket(struct sock *sk)
+{
+	struct smc_sock *smc = smc_sk(sk);
+
+	smc->accompany_socket.sk = sk;
+	init_waitqueue_head(&smc->accompany_socket.wq.wait);
+	smc->accompany_socket.ops = &smc_inet_clcsock_ops;
+	smc->accompany_socket.state = SS_UNCONNECTED;
+
+	smc->clcsock = &smc->accompany_socket;
+}
+
+#if IS_ENABLED(CONFIG_IPV6)
+#define smc_call_inet_sock_ops(sk, inet, inet6, ...) ({		\
+	(sk)->sk_family == PF_INET ? inet(__VA_ARGS__) :	\
+		inet6(__VA_ARGS__);				\
+})
+#else
+#define smc_call_inet_sock_ops(sk, inet, inet6, ...)	inet(__VA_ARGS__)
+#endif
+#define SMC_REQSK_SMC	0x01
+#define SMC_REQSK_TCP	0x02
+
 /* obtain TCP proto via sock family */
 static __always_inline struct proto *smc_inet_get_tcp_prot(int family)
 {
@@ -179,4 +274,7 @@ ssize_t smc_inet_splice_read(struct socket *sock, loff_t *ppos,
 int smc_inet_shutdown(struct socket *sock, int how);
 int smc_inet_release(struct socket *sock);
 
+int smc_inet_sock_pre_connect(struct sock *sk, struct sockaddr *uaddr,
+			    int addr_len);
+
 #endif // __SMC_INET
diff --git a/net/smc/smc_rx.c b/net/smc/smc_rx.c
index 684caae..cf9542b 100644
--- a/net/smc/smc_rx.c
+++ b/net/smc/smc_rx.c
@@ -269,7 +269,7 @@ int smc_rx_wait(struct smc_sock *smc, long *timeo,
 	rc = sk_wait_event(sk, timeo,
 			   READ_ONCE(sk->sk_err) ||
 			   cflags->peer_conn_abort ||
-			   READ_ONCE(sk->sk_shutdown) & RCV_SHUTDOWN ||
+			   smc_has_rcv_shutdown(sk) ||
 			   conn->killed ||
 			   fcrit(conn),
 			   &wait);
@@ -316,7 +316,7 @@ static int smc_rx_recv_urg(struct smc_sock *smc, struct msghdr *msg, int len,
 		return rc ? -EFAULT : len;
 	}
 
-	if (smc_sk_state(sk) == SMC_CLOSED || sk->sk_shutdown & RCV_SHUTDOWN)
+	if (smc_sk_state(sk) == SMC_CLOSED || smc_has_rcv_shutdown(sk))
 		return 0;
 
 	return -EAGAIN;
@@ -387,7 +387,7 @@ int smc_rx_recvmsg(struct smc_sock *smc, struct msghdr *msg,
 		if (smc_rx_recvmsg_data_available(smc))
 			goto copy;
 
-		if (sk->sk_shutdown & RCV_SHUTDOWN) {
+		if (smc_has_rcv_shutdown(sk)) {
 			/* smc_cdc_msg_recv_action() could have run after
 			 * above smc_rx_recvmsg_data_available()
 			 */
-- 
1.8.3.1


