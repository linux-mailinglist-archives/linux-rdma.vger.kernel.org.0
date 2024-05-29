Return-Path: <linux-rdma+bounces-2652-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6AEE8D2B9C
	for <lists+linux-rdma@lfdr.de>; Wed, 29 May 2024 05:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E436286E5F
	for <lists+linux-rdma@lfdr.de>; Wed, 29 May 2024 03:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4470815B569;
	Wed, 29 May 2024 03:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FwtyATCr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B27B15B0E5;
	Wed, 29 May 2024 03:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716955160; cv=none; b=jg2J3VXNSu/YdZ7u3rB2MO4slIN2Tir+SSnFxlvfiBytsk6ZrhI7zoJo30mz1odFFGzPL7N1mcGLjh0dOGpAgSlV2oBAt4OSgddo5Os3ka8Dlu012BgtDQMJtvCWtbpoFtDSqf/JTqD39NT0utOzAHZl4qyNFHSasl1urUV1k0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716955160; c=relaxed/simple;
	bh=p2Ak9FCkvL1j91PkmnW9LlfgE/xqLbJ6ALBYNwxfUao=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Gy817cwKN/Br3fwM8F3rvlTb0nw+a+GFopkl3cDyiGLzsVNiVeIkrZGFaeaCkOmcf6i7/Yqolp3F6XJKaHQxUJtvAlrZN4aCRql48C781ETdMvZQH6R++wocCQN7IUAsZKJ0JZvZA80gX1Wa2TSYkZ52IlI9vsXJ8xnfDMUYDIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FwtyATCr; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716955153; h=From:To:Subject:Date:Message-Id;
	bh=17WXZG1iMox1ZnK0yKhjzDMo9yctgRxOjDDxSXsQx+4=;
	b=FwtyATCrL90zMm6vYRIL5ryWuIiY1e99+vX70W9uIuqzGGAPWCPYYarmF5LEyO69jXeYjyw16q+ergEHZ9yYZjXlMYG4GOPlAaHY6MUrVnyo9aYFXOuVo4XXDmceMRkzY5T1SVlfpQD6fIqqImxXjVM3+c4K3IV3lxfs7OPowBA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W7RK2yM_1716955152;
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0W7RK2yM_1716955152)
          by smtp.aliyun-inc.com;
          Wed, 29 May 2024 11:59:13 +0800
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
Subject: [PATCH net-next v4 1/3] net/smc: refactoring initialization of smc sock
Date: Wed, 29 May 2024 11:59:05 +0800
Message-Id: <1716955147-88923-2-git-send-email-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1716955147-88923-1-git-send-email-alibuda@linux.alibaba.com>
References: <1716955147-88923-1-git-send-email-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: "D. Wythe" <alibuda@linux.alibaba.com>

This patch aims to isolate the shared components of SMC socket
allocation by introducing smc_sk_init() for sock initialization
and __smc_create_clcsk() for the initialization of clcsock.

This is in preparation for the subsequent implementation of the
AF_INET version of SMC.

Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
---
 net/smc/af_smc.c | 86 +++++++++++++++++++++++++++++++-------------------------
 net/smc/smc.h    |  5 ++++
 2 files changed, 53 insertions(+), 38 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index e50a286..77a9d58 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -361,25 +361,15 @@ static void smc_destruct(struct sock *sk)
 		return;
 }
 
-static struct sock *smc_sock_alloc(struct net *net, struct socket *sock,
-				   int protocol)
+void smc_sk_init(struct net *net, struct sock *sk, int protocol)
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
 	sk->sk_destruct = smc_destruct;
 	sk->sk_protocol = protocol;
 	WRITE_ONCE(sk->sk_sndbuf, 2 * READ_ONCE(net->smc.sysctl_wmem));
 	WRITE_ONCE(sk->sk_rcvbuf, 2 * READ_ONCE(net->smc.sysctl_rmem));
-	smc = smc_sk(sk);
 	INIT_WORK(&smc->tcp_listen_work, smc_tcp_listen_work);
 	INIT_WORK(&smc->connect_work, smc_connect_work);
 	INIT_DELAYED_WORK(&smc->conn.tx_work, smc_tx_work);
@@ -389,6 +379,24 @@ static struct sock *smc_sock_alloc(struct net *net, struct socket *sock,
 	sk->sk_prot->hash(sk);
 	mutex_init(&smc->clcsock_release_lock);
 	smc_init_saved_callbacks(smc);
+	smc->limit_smc_hs = net->smc.limit_smc_hs;
+	smc->use_fallback = false; /* assume rdma capability first */
+	smc->fallback_rsn = 0;
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
+	smc_sk_init(net, sk, protocol);
 
 	return sk;
 }
@@ -3321,6 +3329,31 @@ static ssize_t smc_splice_read(struct socket *sock, loff_t *ppos,
 	.splice_read	= smc_splice_read,
 };
 
+int smc_create_clcsk(struct net *net, struct sock *sk, int family)
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
@@ -3346,35 +3379,12 @@ static int __smc_create(struct net *net, struct socket *sock, int protocol,
 
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
+	if (clcsock)
 		smc->clcsock = clcsock;
-	}
-
+	else
+		rc = smc_create_clcsk(net, sk, family);
 out:
 	return rc;
 }
diff --git a/net/smc/smc.h b/net/smc/smc.h
index 18c8b78..3edec1e 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -34,6 +34,11 @@
 extern struct proto smc_proto;
 extern struct proto smc_proto6;
 
+/* smc sock initialization */
+void smc_sk_init(struct net *net, struct sock *sk, int protocol);
+/* clcsock initialization */
+int smc_create_clcsk(struct net *net, struct sock *sk, int family);
+
 #ifdef ATOMIC64_INIT
 #define KERNEL_HAS_ATOMIC64
 #endif
-- 
1.8.3.1


