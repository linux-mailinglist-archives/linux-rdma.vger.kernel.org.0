Return-Path: <linux-rdma+bounces-2387-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A41C08C1D56
	for <lists+linux-rdma@lfdr.de>; Fri, 10 May 2024 06:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C19141C21CD7
	for <lists+linux-rdma@lfdr.de>; Fri, 10 May 2024 04:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9107D149E08;
	Fri, 10 May 2024 04:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Tj5e0wnG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A64149C51;
	Fri, 10 May 2024 04:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715314351; cv=none; b=a9+aEwOKb3hsMC3YIewayi8hyAaYBrKv0UAtmqLensP3NVE9tX5NU31xFseLxrci9pmhIhCJSVlwlZEwfcw6scpDoPc2npd7nBYbUV/pzyz8Ut4hipizZyQVebGhvoX3C0JOTTpWrwJ0wELRWvmOeFWFMN1YpCmfxw+AT6xu+mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715314351; c=relaxed/simple;
	bh=Lc+tTRAKJAFzOMYTF7PaoVpSz5ABptYWM6HWwhVPbXw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=qmOjeUz7PC7lIBuUfac9adpq/zI4Z24EOSKlZKpCV/OVXK5X3qQ1WInUOww74SB0VVh0WCIe2ZXNLdaVbKfva2dHNU0Oy4jy9sb6IJsZWsJbP/YHpwmsNrpOzUi1hD8uNgiEP5dzl/1Y2BzTQor5Oig0RRsKD877Jn7eGyosmKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Tj5e0wnG; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715314340; h=From:To:Subject:Date:Message-Id;
	bh=c12INy9MAiWmeihmLjIh3i36/tZzQBN1aEhOXNj5Feo=;
	b=Tj5e0wnGFiw3IbKjzuxKYedNZPOgc3cuhhNanc+9QsQMjeeTaj9GfnstxtAsi8G62iiNGnJJYWu949xIRBRQe7XLAlEtSPxifFVS75sS5Jyoh6kVf488dMCH7cYUWZrjdXsW+gBu5X4XpsralJ0MJC2bCKMQFEkAkYcA8sg40iY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W68pi2j_1715314338;
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0W68pi2j_1715314338)
          by smtp.aliyun-inc.com;
          Fri, 10 May 2024 12:12:19 +0800
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
Subject: [PATCH net-next 1/2] net/smc: refatoring initialization of smc sock
Date: Fri, 10 May 2024 12:12:12 +0800
Message-Id: <1715314333-107290-2-git-send-email-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1715314333-107290-1-git-send-email-alibuda@linux.alibaba.com>
References: <1715314333-107290-1-git-send-email-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: "D. Wythe" <alibuda@linux.alibaba.com>

This patch aims to isolate the shared components of SMC socket
allocation by introducing smc_sock_init() for sock initialization
and __smc_create_clcsk() for the initialization of clcsock.

This is in preparation for the subsequent implementation of the
AF_INET version of SMC.

Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
---
 net/smc/af_smc.c | 93 +++++++++++++++++++++++++++++++-------------------------
 1 file changed, 52 insertions(+), 41 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 9389f0c..1f03724 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -361,34 +361,43 @@ static void smc_destruct(struct sock *sk)
 		return;
 }
 
-static struct sock *smc_sock_alloc(struct net *net, struct socket *sock,
-				   int protocol)
+static void smc_sock_init(struct net *net, struct sock *sk, int protocol)
 {
-	struct smc_sock *smc;
-	struct proto *prot;
-	struct sock *sk;
-
-	prot = (protocol == SMCPROTO_SMC6) ? &smc_proto6 : &smc_proto;
-	sk = sk_alloc(net, PF_SMC, GFP_KERNEL, prot, 0);
-	if (!sk)
-		return NULL;
+	struct smc_sock *smc = smc_sk(sk);
 
-	sock_init_data(sock, sk); /* sets sk_refcnt to 1 */
 	sk->sk_state = SMC_INIT;
-	sk->sk_destruct = smc_destruct;
 	sk->sk_protocol = protocol;
+	mutex_init(&smc->clcsock_release_lock);
 	WRITE_ONCE(sk->sk_sndbuf, 2 * READ_ONCE(net->smc.sysctl_wmem));
 	WRITE_ONCE(sk->sk_rcvbuf, 2 * READ_ONCE(net->smc.sysctl_rmem));
-	smc = smc_sk(sk);
 	INIT_WORK(&smc->tcp_listen_work, smc_tcp_listen_work);
 	INIT_WORK(&smc->connect_work, smc_connect_work);
 	INIT_DELAYED_WORK(&smc->conn.tx_work, smc_tx_work);
 	INIT_LIST_HEAD(&smc->accept_q);
 	spin_lock_init(&smc->accept_q_lock);
 	spin_lock_init(&smc->conn.send_lock);
-	sk->sk_prot->hash(sk);
-	mutex_init(&smc->clcsock_release_lock);
 	smc_init_saved_callbacks(smc);
+	smc->limit_smc_hs = net->smc.limit_smc_hs;
+	smc->use_fallback = false; /* assume rdma capability first */
+	smc->fallback_rsn = 0;
+
+	sk->sk_destruct = smc_destruct;
+	sk->sk_prot->hash(sk);
+}
+
+static struct sock *smc_sock_alloc(struct net *net, struct socket *sock,
+				   int protocol)
+{
+	struct proto *prot;
+	struct sock *sk;
+
+	prot = (protocol == SMCPROTO_SMC6) ? &smc_proto6 : &smc_proto;
+	sk = sk_alloc(net, PF_SMC, GFP_KERNEL, prot, 0);
+	if (!sk)
+		return NULL;
+
+	sock_init_data(sock, sk); /* sets sk_refcnt to 1 */
+	smc_sock_init(net, sk, protocol);
 
 	return sk;
 }
@@ -3321,6 +3330,31 @@ static ssize_t smc_splice_read(struct socket *sock, loff_t *ppos,
 	.splice_read	= smc_splice_read,
 };
 
+static int __smc_create_clcsk(struct net *net, struct sock *sk, int family)
+{
+	struct smc_sock *smc = smc_sk(sk);
+	int rc;
+
+	rc = sock_create_kern(net, family, SOCK_STREAM, IPPROTO_TCP,
+			      &smc->clcsock);
+	if (rc) {
+		sk_common_release(sk);
+		return rc;
+	}
+
+	/* smc_clcsock_release() does not wait smc->clcsock->sk's
+	 * destruction;  its sk_state might not be TCP_CLOSE after
+	 * smc->sk is close()d, and TCP timers can be fired later,
+	 * which need net ref.
+	 */
+	sk = smc->clcsock->sk;
+	__netns_tracker_free(net, &sk->ns_tracker, false);
+	sk->sk_net_refcnt = 1;
+	get_net_track(net, &sk->ns_tracker, GFP_KERNEL);
+	sock_inuse_add(net, 1);
+	return 0;
+}
+
 static int __smc_create(struct net *net, struct socket *sock, int protocol,
 			int kern, struct socket *clcsock)
 {
@@ -3346,35 +3380,12 @@ static int __smc_create(struct net *net, struct socket *sock, int protocol,
 
 	/* create internal TCP socket for CLC handshake and fallback */
 	smc = smc_sk(sk);
-	smc->use_fallback = false; /* assume rdma capability first */
-	smc->fallback_rsn = 0;
-
-	/* default behavior from limit_smc_hs in every net namespace */
-	smc->limit_smc_hs = net->smc.limit_smc_hs;
 
 	rc = 0;
-	if (!clcsock) {
-		rc = sock_create_kern(net, family, SOCK_STREAM, IPPROTO_TCP,
-				      &smc->clcsock);
-		if (rc) {
-			sk_common_release(sk);
-			goto out;
-		}
-
-		/* smc_clcsock_release() does not wait smc->clcsock->sk's
-		 * destruction;  its sk_state might not be TCP_CLOSE after
-		 * smc->sk is close()d, and TCP timers can be fired later,
-		 * which need net ref.
-		 */
-		sk = smc->clcsock->sk;
-		__netns_tracker_free(net, &sk->ns_tracker, false);
-		sk->sk_net_refcnt = 1;
-		get_net_track(net, &sk->ns_tracker, GFP_KERNEL);
-		sock_inuse_add(net, 1);
-	} else {
+	if (!clcsock)
+		rc = __smc_create_clcsk(net, sk, family);
+	else
 		smc->clcsock = clcsock;
-	}
-
 out:
 	return rc;
 }
-- 
1.8.3.1


