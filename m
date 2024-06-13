Return-Path: <linux-rdma+bounces-3092-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A6E9064C7
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2024 09:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E80EF284C22
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2024 07:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561575A0F4;
	Thu, 13 Jun 2024 07:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="MxQXJsh6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB957FB;
	Thu, 13 Jun 2024 07:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718263156; cv=none; b=WNRAqLo+3sH8/b9W7KwvygkBiFZ2Bl55/aYjNZdaFcr25V+h44VZGPjQ8IJwGX40VQWjmVLkAJKSsQZDGC1UeSih3HLM7MdF7CK+1r49JSjyMZX44Y2LPk/RlTHOXwbxzOrL+9gcbRrGxbwn7l105dpdGmAstkJiAjlt/kTpeLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718263156; c=relaxed/simple;
	bh=bpXX6LlaNiPg2YVfB+CCMKceQhG66Hmc332O+CKqz4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q7smW4/hfGjUKqwelP8/1yS26L51ek3p+gS0pjPcv2v3IG3cEp7gntrmdNZTcNuiyY/hkarE4tL7cyLILykXskZ6qBB/ztfxei3f/kWLF4quZVY5B+34wUXR1Big9m5Vw1VaQKXrpPk1LO27QGyTGtihYijMuh6C9SCyEgX+L0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=MxQXJsh6; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718263149; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=uSS/HnnLu36EYiUk1VYLsstcCCEfbL6d7aU1ouqmUvA=;
	b=MxQXJsh6Arjsfbt78qOIWpW/9J16o9QRiWb7MEjyD6seDfuSYqzPhA6829pJKMrY4lCyXkP4zesWETsSycPu87HQtZXsf3r+mco2S3nB7iHydsX35AXwUc+lMWWXFbWEHVv5RjSWBeVDQ3He3DTlCS9oHWaDdi60YGjwEzr6wOg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045075189;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W8N1f5e_1718263148;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0W8N1f5e_1718263148)
          by smtp.aliyun-inc.com;
          Thu, 13 Jun 2024 15:19:09 +0800
Date: Thu, 13 Jun 2024 15:19:08 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: "D. Wythe" <alibuda@linux.alibaba.com>, kgraul@linux.ibm.com,
	wenjia@linux.ibm.com, jaka@linux.ibm.com, wintera@linux.ibm.com,
	guwen@linux.alibaba.com
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
	tonylu@linux.alibaba.com, pabeni@redhat.com, edumazet@google.com
Subject: Re: [PATCH net-next v7 1/3] net/smc: refactoring initialization of
 smc sock
Message-ID: <20240613071908.GO78725@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <1717837949-88904-1-git-send-email-alibuda@linux.alibaba.com>
 <1717837949-88904-2-git-send-email-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1717837949-88904-2-git-send-email-alibuda@linux.alibaba.com>

On 2024-06-08 17:12:27, D. Wythe wrote:
>From: "D. Wythe" <alibuda@linux.alibaba.com>
>
>This patch aims to isolate the shared components of SMC socket
>allocation by introducing smc_sk_init() for sock initialization
>and __smc_create_clcsk() for the initialization of clcsock.
>
>This is in preparation for the subsequent implementation of the
>AF_INET version of SMC.
>
>Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
>Reviewed-by: Tony Lu <tonylu@linux.alibaba.com>
>Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
>Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>
>Tested-by: Wenjia Zhang <wenjia@linux.ibm.com>

Reviewed-by: Dust Li <dust.li@linux.alibaba.com>

>---
> net/smc/af_smc.c | 86 +++++++++++++++++++++++++++++++-------------------------
> net/smc/smc.h    |  5 ++++
> 2 files changed, 53 insertions(+), 38 deletions(-)
>
>diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
>index e50a286..77a9d58 100644
>--- a/net/smc/af_smc.c
>+++ b/net/smc/af_smc.c
>@@ -361,25 +361,15 @@ static void smc_destruct(struct sock *sk)
> 		return;
> }
> 
>-static struct sock *smc_sock_alloc(struct net *net, struct socket *sock,
>-				   int protocol)
>+void smc_sk_init(struct net *net, struct sock *sk, int protocol)
> {
>-	struct smc_sock *smc;
>-	struct proto *prot;
>-	struct sock *sk;
>-
>-	prot = (protocol == SMCPROTO_SMC6) ? &smc_proto6 : &smc_proto;
>-	sk = sk_alloc(net, PF_SMC, GFP_KERNEL, prot, 0);
>-	if (!sk)
>-		return NULL;
>+	struct smc_sock *smc = smc_sk(sk);
> 
>-	sock_init_data(sock, sk); /* sets sk_refcnt to 1 */
> 	sk->sk_state = SMC_INIT;
> 	sk->sk_destruct = smc_destruct;
> 	sk->sk_protocol = protocol;
> 	WRITE_ONCE(sk->sk_sndbuf, 2 * READ_ONCE(net->smc.sysctl_wmem));
> 	WRITE_ONCE(sk->sk_rcvbuf, 2 * READ_ONCE(net->smc.sysctl_rmem));
>-	smc = smc_sk(sk);
> 	INIT_WORK(&smc->tcp_listen_work, smc_tcp_listen_work);
> 	INIT_WORK(&smc->connect_work, smc_connect_work);
> 	INIT_DELAYED_WORK(&smc->conn.tx_work, smc_tx_work);
>@@ -389,6 +379,24 @@ static struct sock *smc_sock_alloc(struct net *net, struct socket *sock,
> 	sk->sk_prot->hash(sk);
> 	mutex_init(&smc->clcsock_release_lock);
> 	smc_init_saved_callbacks(smc);
>+	smc->limit_smc_hs = net->smc.limit_smc_hs;
>+	smc->use_fallback = false; /* assume rdma capability first */
>+	smc->fallback_rsn = 0;
>+}
>+
>+static struct sock *smc_sock_alloc(struct net *net, struct socket *sock,
>+				   int protocol)
>+{
>+	struct proto *prot;
>+	struct sock *sk;
>+
>+	prot = (protocol == SMCPROTO_SMC6) ? &smc_proto6 : &smc_proto;
>+	sk = sk_alloc(net, PF_SMC, GFP_KERNEL, prot, 0);
>+	if (!sk)
>+		return NULL;
>+
>+	sock_init_data(sock, sk); /* sets sk_refcnt to 1 */
>+	smc_sk_init(net, sk, protocol);
> 
> 	return sk;
> }
>@@ -3321,6 +3329,31 @@ static ssize_t smc_splice_read(struct socket *sock, loff_t *ppos,
> 	.splice_read	= smc_splice_read,
> };
> 
>+int smc_create_clcsk(struct net *net, struct sock *sk, int family)
>+{
>+	struct smc_sock *smc = smc_sk(sk);
>+	int rc;
>+
>+	rc = sock_create_kern(net, family, SOCK_STREAM, IPPROTO_TCP,
>+			      &smc->clcsock);
>+	if (rc) {
>+		sk_common_release(sk);
>+		return rc;
>+	}
>+
>+	/* smc_clcsock_release() does not wait smc->clcsock->sk's
>+	 * destruction;  its sk_state might not be TCP_CLOSE after
>+	 * smc->sk is close()d, and TCP timers can be fired later,
>+	 * which need net ref.
>+	 */
>+	sk = smc->clcsock->sk;
>+	__netns_tracker_free(net, &sk->ns_tracker, false);
>+	sk->sk_net_refcnt = 1;
>+	get_net_track(net, &sk->ns_tracker, GFP_KERNEL);
>+	sock_inuse_add(net, 1);
>+	return 0;
>+}
>+
> static int __smc_create(struct net *net, struct socket *sock, int protocol,
> 			int kern, struct socket *clcsock)
> {
>@@ -3346,35 +3379,12 @@ static int __smc_create(struct net *net, struct socket *sock, int protocol,
> 
> 	/* create internal TCP socket for CLC handshake and fallback */
> 	smc = smc_sk(sk);
>-	smc->use_fallback = false; /* assume rdma capability first */
>-	smc->fallback_rsn = 0;
>-
>-	/* default behavior from limit_smc_hs in every net namespace */
>-	smc->limit_smc_hs = net->smc.limit_smc_hs;
> 
> 	rc = 0;
>-	if (!clcsock) {
>-		rc = sock_create_kern(net, family, SOCK_STREAM, IPPROTO_TCP,
>-				      &smc->clcsock);
>-		if (rc) {
>-			sk_common_release(sk);
>-			goto out;
>-		}
>-
>-		/* smc_clcsock_release() does not wait smc->clcsock->sk's
>-		 * destruction;  its sk_state might not be TCP_CLOSE after
>-		 * smc->sk is close()d, and TCP timers can be fired later,
>-		 * which need net ref.
>-		 */
>-		sk = smc->clcsock->sk;
>-		__netns_tracker_free(net, &sk->ns_tracker, false);
>-		sk->sk_net_refcnt = 1;
>-		get_net_track(net, &sk->ns_tracker, GFP_KERNEL);
>-		sock_inuse_add(net, 1);
>-	} else {
>+	if (clcsock)
> 		smc->clcsock = clcsock;
>-	}
>-
>+	else
>+		rc = smc_create_clcsk(net, sk, family);
> out:
> 	return rc;
> }
>diff --git a/net/smc/smc.h b/net/smc/smc.h
>index 18c8b78..3edec1e 100644
>--- a/net/smc/smc.h
>+++ b/net/smc/smc.h
>@@ -34,6 +34,11 @@
> extern struct proto smc_proto;
> extern struct proto smc_proto6;
> 
>+/* smc sock initialization */
>+void smc_sk_init(struct net *net, struct sock *sk, int protocol);
>+/* clcsock initialization */
>+int smc_create_clcsk(struct net *net, struct sock *sk, int family);
>+
> #ifdef ATOMIC64_INIT
> #define KERNEL_HAS_ATOMIC64
> #endif
>-- 
>1.8.3.1
>

