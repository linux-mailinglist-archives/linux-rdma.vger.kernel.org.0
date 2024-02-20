Return-Path: <linux-rdma+bounces-1058-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9068385B373
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Feb 2024 08:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4664E1F2290A
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Feb 2024 07:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875FE5B661;
	Tue, 20 Feb 2024 07:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="HFa9YrTt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82A75A4D3;
	Tue, 20 Feb 2024 07:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708412525; cv=none; b=moowzByhZaiFmfURXbN+88setO2wmFMpatwHROXsxiaWq2pPrSAITjLyW++Y4I1XFNlQDtDxQ9V83qPBbKw5bMm1XKRj4xwcYEN2qfBzTBLb62o6CbVDRWrHkvvQO5WLd5Woo7oKG49r9lRBhVTuFEcRqwpBV7aZpvpW6fmplCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708412525; c=relaxed/simple;
	bh=jYEq85wOIB9G9ChiwfDhIZbbzmqSualEHfDNqFfY8lE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=dmDp9e8WsQ4gYkvtzwLKbz61SyLdSKV5uC8X4MBYqnIXKyehWbSkA8v9O3zT+pxzoQCXdKEIz47eaQyj0j/gj4wVn3rICpjtnFelv8Qxaxncoh1966c1NDOnF90zAqdh0FUfkLZxxNiCSZMMEDn7h7uNJTYyU7PptUPhPu4LPw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=HFa9YrTt; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708412514; h=From:To:Subject:Date:Message-Id;
	bh=x+0fR1Jr6Fhs41cI45xUAC3ALCYq4HJIKp2WfWH9HB4=;
	b=HFa9YrTtF7UOatdbU+9dAhForFrmpG7xpHsHd5JxP6X5EpWBevWPVfGRUHYqH8jZu1yHVd8ryz17FF954cV9fGam2JqrIYLcOXpJGJTDpbSVFe+XjiM7GGz7U9dDGBRMCt9cEBBOGWBOx/dszTxC2IokQvHjerfD6SdF9SjCBNw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R361e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W0vuXeS_1708412513;
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0W0vuXeS_1708412513)
          by smtp.aliyun-inc.com;
          Tue, 20 Feb 2024 15:01:54 +0800
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
Subject: [RFC net-next 07/20] net/smc: refactor sock_flag/sock_set_flag
Date: Tue, 20 Feb 2024 15:01:32 +0800
Message-Id: <1708412505-34470-8-git-send-email-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1708412505-34470-1-git-send-email-alibuda@linux.alibaba.com>
References: <1708412505-34470-1-git-send-email-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: "D. Wythe" <alibuda@linux.alibaba.com>

Use a unified new macro to access the flag of the sock,
so that we can easily modify the behavior of a specific flag
instead of modifying the original function.

Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
---
 net/smc/af_smc.c    | 4 ++--
 net/smc/smc.h       | 2 ++
 net/smc/smc_cdc.c   | 2 +-
 net/smc/smc_close.c | 8 ++++----
 net/smc/smc_rx.c    | 8 ++++----
 5 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 40cf0569..66306b7 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -358,7 +358,7 @@ static void smc_destruct(struct sock *sk)
 {
 	if (smc_sk_state(sk) != SMC_CLOSED)
 		return;
-	if (!sock_flag(sk, SOCK_DEAD))
+	if (!smc_sock_flag(sk, SOCK_DEAD))
 		return;
 }
 
@@ -1623,7 +1623,7 @@ static void smc_connect_work(struct work_struct *work)
 		smc->sk.sk_err = -rc;
 
 out:
-	if (!sock_flag(&smc->sk, SOCK_DEAD)) {
+	if (!smc_sock_flag(&smc->sk, SOCK_DEAD)) {
 		if (smc->sk.sk_err) {
 			smc->sk.sk_state_change(&smc->sk);
 		} else { /* allow polling before and after fallback decision */
diff --git a/net/smc/smc.h b/net/smc/smc.h
index 6b651b5..fce6a7a 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -388,4 +388,6 @@ static inline void smc_sock_set_flag(struct sock *sk, enum sock_flags flag)
 	set_bit(flag, &sk->sk_flags);
 }
 
+#define smc_sock_flag(sk, flag)	sock_flag(sk, flag)
+
 #endif	/* __SMC_H */
diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
index 3c06625..7614545 100644
--- a/net/smc/smc_cdc.c
+++ b/net/smc/smc_cdc.c
@@ -285,7 +285,7 @@ static void smc_cdc_handle_urg_data_arrival(struct smc_sock *smc,
 	/* new data included urgent business */
 	smc_curs_copy(&conn->urg_curs, &conn->local_rx_ctrl.prod, conn);
 	conn->urg_state = SMC_URG_VALID;
-	if (!sock_flag(&smc->sk, SOCK_URGINLINE))
+	if (!smc_sock_flag(&smc->sk, SOCK_URGINLINE))
 		/* we'll skip the urgent byte, so don't account for it */
 		(*diff_prod)--;
 	base = (char *)conn->rmb_desc->cpu_addr + conn->rx_off;
diff --git a/net/smc/smc_close.c b/net/smc/smc_close.c
index 9210d1f..8d9512e 100644
--- a/net/smc/smc_close.c
+++ b/net/smc/smc_close.c
@@ -202,7 +202,7 @@ int smc_close_active(struct smc_sock *smc)
 	int rc1 = 0;
 
 	timeout = current->flags & PF_EXITING ?
-		  0 : sock_flag(sk, SOCK_LINGER) ?
+		  0 : smc_sock_flag(sk, SOCK_LINGER) ?
 		      sk->sk_lingertime : SMC_MAX_STREAM_WAIT_TIMEOUT;
 
 	old_state = smc_sk_state(sk);
@@ -395,7 +395,7 @@ static void smc_close_passive_work(struct work_struct *work)
 	case SMC_PEERCLOSEWAIT2:
 		if (!smc_cdc_rxed_any_close(conn))
 			break;
-		if (sock_flag(sk, SOCK_DEAD) &&
+		if (smc_sock_flag(sk, SOCK_DEAD) &&
 		    smc_close_sent_any_close(conn)) {
 			/* smc_release has already been called locally */
 			smc_sk_set_state(sk, SMC_CLOSED);
@@ -432,7 +432,7 @@ static void smc_close_passive_work(struct work_struct *work)
 	if (old_state != smc_sk_state(sk)) {
 		sk->sk_state_change(sk);
 		if ((smc_sk_state(sk) == SMC_CLOSED) &&
-		    (sock_flag(sk, SOCK_DEAD) || !sk->sk_socket)) {
+		    (smc_sock_flag(sk, SOCK_DEAD) || !sk->sk_socket)) {
 			smc_conn_free(conn);
 			if (smc->clcsock)
 				release_clcsock = true;
@@ -453,7 +453,7 @@ int smc_close_shutdown_write(struct smc_sock *smc)
 	int rc = 0;
 
 	timeout = current->flags & PF_EXITING ?
-		  0 : sock_flag(sk, SOCK_LINGER) ?
+		  0 : smc_sock_flag(sk, SOCK_LINGER) ?
 		      sk->sk_lingertime : SMC_MAX_STREAM_WAIT_TIMEOUT;
 
 	old_state = smc_sk_state(sk);
diff --git a/net/smc/smc_rx.c b/net/smc/smc_rx.c
index 32fd7db..684caae 100644
--- a/net/smc/smc_rx.c
+++ b/net/smc/smc_rx.c
@@ -70,7 +70,7 @@ static int smc_rx_update_consumer(struct smc_sock *smc,
 	if (conn->urg_state == SMC_URG_VALID || conn->urg_rx_skip_pend) {
 		diff = smc_curs_comp(conn->rmb_desc->len, &cons,
 				     &conn->urg_curs);
-		if (sock_flag(sk, SOCK_URGINLINE)) {
+		if (smc_sock_flag(sk, SOCK_URGINLINE)) {
 			if (diff == 0) {
 				force = true;
 				rc = 1;
@@ -286,7 +286,7 @@ static int smc_rx_recv_urg(struct smc_sock *smc, struct msghdr *msg, int len,
 	struct sock *sk = &smc->sk;
 	int rc = 0;
 
-	if (sock_flag(sk, SOCK_URGINLINE) ||
+	if (smc_sock_flag(sk, SOCK_URGINLINE) ||
 	    !(conn->urg_state == SMC_URG_VALID) ||
 	    conn->urg_state == SMC_URG_READ)
 		return -EINVAL;
@@ -408,7 +408,7 @@ int smc_rx_recvmsg(struct smc_sock *smc, struct msghdr *msg,
 				break;
 			}
 			if (smc_sk_state(sk) == SMC_CLOSED) {
-				if (!sock_flag(sk, SOCK_DONE)) {
+				if (!smc_sock_flag(sk, SOCK_DONE)) {
 					/* This occurs when user tries to read
 					 * from never connected socket.
 					 */
@@ -449,7 +449,7 @@ int smc_rx_recvmsg(struct smc_sock *smc, struct msghdr *msg,
 		if (splbytes)
 			smc_curs_add(conn->rmb_desc->len, &cons, splbytes);
 		if (conn->urg_state == SMC_URG_VALID &&
-		    sock_flag(&smc->sk, SOCK_URGINLINE) &&
+		    smc_sock_flag(&smc->sk, SOCK_URGINLINE) &&
 		    readable > 1)
 			readable--;	/* always stop at urgent Byte */
 		/* not more than what user space asked for */
-- 
1.8.3.1


