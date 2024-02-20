Return-Path: <linux-rdma+bounces-1056-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6284385B36D
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Feb 2024 08:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 152EE1F2295B
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Feb 2024 07:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326305B5BB;
	Tue, 20 Feb 2024 07:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="bYaTxERB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603415B5B3;
	Tue, 20 Feb 2024 07:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708412524; cv=none; b=NadZT70T/jajERfqQHCTtIwNLrDKfRYawDeDort/eCqyZX+W6Rx+gqu+9aJzvZc3Fm+ROS6ZPgjQ861l+molf+sEwJ3S4Ms9bBbr+Dtg6M1a6LRl3rRZraY1T/Hfbmu6c7K1riY+dR628mNcshPY6IMnbugy9gAZTcmnUk4XD8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708412524; c=relaxed/simple;
	bh=uynprvzz2AbAKrOJMac5dPZJ0gH2wTRRdmgU8YlBESE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=OruoMZinirEg37jIirERQdvY7Dn4jmdxP9EQfgaoNm2WxTAdqJspRk0V3QrmxHWsemZ+zhu9TJxONnXDchYrsi3wD5y1fZdEhbIOjvF+nxofr3nvjG9Me5HT5qWiVNwrStnqOHvGEtmkIT6wjO3sXtDVZ8LiY/XaqC1pTWAxAS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=bYaTxERB; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708412519; h=From:To:Subject:Date:Message-Id;
	bh=sNwHuATEVbDgcOGggJ4aYilgn556khxa9K+HduugkGs=;
	b=bYaTxERBJQyS305dEjY09TeV9/aRz4AVTKlWD7UjrfhkhNxPTOfPAf/tgVYdNYC4WY3E2utZHAvnxu9llMbMYtqkh/QN7E6Y6rLB+4KBsm8yMYeyAridYxnpYSSgl0zVZNuH+yikBwz3qzZhCJYzyk0lQoR6r56iJ7iTw97/HC8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W0vuXfw_1708412517;
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0W0vuXfw_1708412517)
          by smtp.aliyun-inc.com;
          Tue, 20 Feb 2024 15:01:57 +0800
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
Subject: [RFC net-next 12/20] net/smc: refatoring initialization of smc sock
Date: Tue, 20 Feb 2024 15:01:37 +0800
Message-Id: <1708412505-34470-13-git-send-email-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1708412505-34470-1-git-send-email-alibuda@linux.alibaba.com>
References: <1708412505-34470-1-git-send-email-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: "D. Wythe" <alibuda@linux.alibaba.com>

This patch try extract the common part of smc sock
initialization, use smc_sock_init() for active open sock
initialization, smc_sock_init_passive() for passive
open sock initialization. This is a preparation to
implement the inet version of SMC.

Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
---
 net/smc/af_smc.c | 58 +++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 41 insertions(+), 17 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index e0505d6..97e3951 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -362,10 +362,48 @@ static void smc_destruct(struct sock *sk)
 		return;
 }
 
+static inline void smc_sock_init_common(struct sock *sk)
+{
+	struct smc_sock *smc = smc_sk(sk);
+
+	smc_sk_set_state(sk, SMC_INIT);
+	INIT_DELAYED_WORK(&smc->conn.tx_work, smc_tx_work);
+	spin_lock_init(&smc->conn.send_lock);
+	mutex_init(&smc->clcsock_release_lock);
+}
+
+static void smc_sock_init_passive(struct sock *par, struct sock *sk)
+{
+	struct smc_sock *parent = smc_sk(par);
+	struct sock *clcsk;
+
+	smc_sock_init_common(sk);
+	smc_sk(sk)->listen_smc = parent;
+
+	clcsk = smc_sock_is_inet_sock(sk) ? sk : smc_sk(sk)->clcsock->sk;
+	if (tcp_sk(clcsk)->syn_smc)
+		atomic_inc(&parent->queued_smc_hs);
+}
+
+static void smc_sock_init(struct sock *sk, struct net *net)
+{
+	struct smc_sock *smc = smc_sk(sk);
+
+	smc_sock_init_common(sk);
+	WRITE_ONCE(sk->sk_sndbuf, 2 * READ_ONCE(net->smc.sysctl_wmem));
+	WRITE_ONCE(sk->sk_rcvbuf, 2* READ_ONCE(net->smc.sysctl_rmem));
+	INIT_WORK(&smc->tcp_listen_work, smc_tcp_listen_work);
+	INIT_WORK(&smc->connect_work, smc_connect_work);
+	INIT_LIST_HEAD(&smc->accept_q);
+	spin_lock_init(&smc->accept_q_lock);
+	smc_init_saved_callbacks(smc);
+
+	sk->sk_destruct = smc_destruct;
+}
+
 static struct sock *smc_sock_alloc(struct net *net, struct socket *sock,
 				   int protocol)
 {
-	struct smc_sock *smc;
 	struct proto *prot;
 	struct sock *sk;
 
@@ -375,21 +413,9 @@ static struct sock *smc_sock_alloc(struct net *net, struct socket *sock,
 		return NULL;
 
 	sock_init_data(sock, sk); /* sets sk_refcnt to 1 */
-	smc_sk_set_state(sk, SMC_INIT);
-	sk->sk_destruct = smc_destruct;
 	sk->sk_protocol = protocol;
-	WRITE_ONCE(sk->sk_sndbuf, 2 * READ_ONCE(net->smc.sysctl_wmem));
-	WRITE_ONCE(sk->sk_rcvbuf, 2 * READ_ONCE(net->smc.sysctl_rmem));
-	smc = smc_sk(sk);
-	INIT_WORK(&smc->tcp_listen_work, smc_tcp_listen_work);
-	INIT_WORK(&smc->connect_work, smc_connect_work);
-	INIT_DELAYED_WORK(&smc->conn.tx_work, smc_tx_work);
-	INIT_LIST_HEAD(&smc->accept_q);
-	spin_lock_init(&smc->accept_q_lock);
-	spin_lock_init(&smc->conn.send_lock);
+	smc_sock_init(sk, net);
 	sk->sk_prot->hash(sk);
-	mutex_init(&smc->clcsock_release_lock);
-	smc_init_saved_callbacks(smc);
 
 	return sk;
 }
@@ -2573,10 +2599,8 @@ static void smc_tcp_listen_work(struct work_struct *work)
 		if (!new_smc)
 			continue;
 
-		if (tcp_sk(new_smc->clcsock->sk)->syn_smc)
-			atomic_inc(&lsmc->queued_smc_hs);
+		smc_sock_init_passive(lsk, &new_smc->sk);
 
-		new_smc->listen_smc = lsmc;
 		new_smc->use_fallback = lsmc->use_fallback;
 		new_smc->fallback_rsn = lsmc->fallback_rsn;
 		sock_hold(lsk); /* sock_put in smc_listen_work */
-- 
1.8.3.1


