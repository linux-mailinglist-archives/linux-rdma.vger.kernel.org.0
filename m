Return-Path: <linux-rdma+bounces-2618-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E05C8D1269
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2024 05:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77E5DB22622
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2024 03:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B270810A3E;
	Tue, 28 May 2024 03:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="b1VufJeH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3259479;
	Tue, 28 May 2024 03:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716865431; cv=none; b=snyV5r+6KKbuydoBP4g65RZD4kL6XdeOhP1Jo510CwkRJ7C87rlh4FBWwrmBJjLZJZ8TKBtCqjqjKTHbOQUf6lk3rR4ginI1y2qCMSqKkuViLQ8Q0P18pv8f7JoVBc7MRaYDsFoW//NJKqNFeTuy1GzTAthtt784zFP09kyyMKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716865431; c=relaxed/simple;
	bh=3xQBaucFPR5JWtSmf3WdZWBykHWrm+9/YHzPyAK7EDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SDRMnPiO8ulX7SVjvxE/Eo93pCfILBy/Y4zk6TCHWA/lijTcyfy9+OwK6SwsPVt17zxC1TfzsYHrHp/49YRs2ywM8gWHkzESLc+Uv/SnKV6RlQu/EgnuDRaxGlnovX/rodcny1sexrOk/2X1Zaqb6JdfgWAq9dzh/GVK5x/03lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=b1VufJeH; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716865420; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=jJr1eKl0mjLlvFTmOAEVDoknpjgMwzR+f+UiNuS3xI8=;
	b=b1VufJeHhs9XWO6AZIAbNNPMQpdsnHDzIyxsOIPkAPs6nQrGYOAPB6ZnekzuqUPsgulPj2C9wH/G7sOG75R09G+jO9GxukUYEpd31Cca8OmMB3BB2R2mIho3zxOVRcqs4Ch3aMkvkkbj+DThh9ip3H9eblKw4+k8DpOA2r6znHo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=tonylu@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W7O7w3t_1716865418;
Received: from localhost(mailfrom:tonylu@linux.alibaba.com fp:SMTPD_---0W7O7w3t_1716865418)
          by smtp.aliyun-inc.com;
          Tue, 28 May 2024 11:03:39 +0800
Date: Tue, 28 May 2024 11:03:37 +0800
From: Tony Lu <tonylu@linux.alibaba.com>
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
	wintera@linux.ibm.com, guwen@linux.alibaba.com, kuba@kernel.org,
	davem@davemloft.net, netdev@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
	pabeni@redhat.com, edumazet@google.com
Subject: Re: [PATCH net-next v3 1/3] net/smc: refatoring initialization of
 smc sock
Message-ID: <ZlVJib8rRvwPJJJi@TONYMAC-ALIBABA.local>
Reply-To: Tony Lu <tonylu@linux.alibaba.com>
References: <1716863394-112399-1-git-send-email-alibuda@linux.alibaba.com>
 <1716863394-112399-2-git-send-email-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1716863394-112399-2-git-send-email-alibuda@linux.alibaba.com>

In subject, refatoring -> refactoring.

On Tue, May 28, 2024 at 10:29:52AM +0800, D. Wythe wrote:
> From: "D. Wythe" <alibuda@linux.alibaba.com>
> 
> This patch aims to isolate the shared components of SMC socket
> allocation by introducing smc_sock_init() for sock initialization
> and __smc_create_clcsk() for the initialization of clcsock.
> 
> This is in preparation for the subsequent implementation of the
> AF_INET version of SMC.
> 
> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
> ---
>  net/smc/af_smc.c | 86 +++++++++++++++++++++++++++++++-------------------------
>  net/smc/smc.h    |  5 ++++
>  2 files changed, 53 insertions(+), 38 deletions(-)
> 
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index 9389f0c..d8c116e 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -361,25 +361,15 @@ static void smc_destruct(struct sock *sk)
>  		return;
>  }
>  
> -static struct sock *smc_sock_alloc(struct net *net, struct socket *sock,
> -				   int protocol)
> +void smc_sock_init(struct net *net, struct sock *sk, int protocol)
            ^^^^                       ^^^^^^^^^^^^^^^^

Using smc_sk_init to align the others' name style.

>  {
> -	struct smc_sock *smc;
> -	struct proto *prot;
> -	struct sock *sk;
> -
> -	prot = (protocol == SMCPROTO_SMC6) ? &smc_proto6 : &smc_proto;
> -	sk = sk_alloc(net, PF_SMC, GFP_KERNEL, prot, 0);
> -	if (!sk)
> -		return NULL;
> +	struct smc_sock *smc = smc_sk(sk);
>  
> -	sock_init_data(sock, sk); /* sets sk_refcnt to 1 */
>  	sk->sk_state = SMC_INIT;
>  	sk->sk_destruct = smc_destruct;
>  	sk->sk_protocol = protocol;
>  	WRITE_ONCE(sk->sk_sndbuf, 2 * READ_ONCE(net->smc.sysctl_wmem));
>  	WRITE_ONCE(sk->sk_rcvbuf, 2 * READ_ONCE(net->smc.sysctl_rmem));
> -	smc = smc_sk(sk);
>  	INIT_WORK(&smc->tcp_listen_work, smc_tcp_listen_work);
>  	INIT_WORK(&smc->connect_work, smc_connect_work);
>  	INIT_DELAYED_WORK(&smc->conn.tx_work, smc_tx_work);
> @@ -389,6 +379,24 @@ static struct sock *smc_sock_alloc(struct net *net, struct socket *sock,
>  	sk->sk_prot->hash(sk);
>  	mutex_init(&smc->clcsock_release_lock);
>  	smc_init_saved_callbacks(smc);
> +	smc->limit_smc_hs = net->smc.limit_smc_hs;
> +	smc->use_fallback = false; /* assume rdma capability first */
> +	smc->fallback_rsn = 0;
> +}
> +
> +static struct sock *smc_sock_alloc(struct net *net, struct socket *sock,
> +				   int protocol)
> +{
> +	struct proto *prot;
> +	struct sock *sk;
> +
> +	prot = (protocol == SMCPROTO_SMC6) ? &smc_proto6 : &smc_proto;
> +	sk = sk_alloc(net, PF_SMC, GFP_KERNEL, prot, 0);
> +	if (!sk)
> +		return NULL;
> +
> +	sock_init_data(sock, sk); /* sets sk_refcnt to 1 */
> +	smc_sock_init(net, sk, protocol);
>  
>  	return sk;
>  }
> @@ -3321,6 +3329,31 @@ static ssize_t smc_splice_read(struct socket *sock, loff_t *ppos,
>  	.splice_read	= smc_splice_read,
>  };
>  
> +int smc_create_clcsk(struct net *net, struct sock *sk, int family)
> +{
> +	struct smc_sock *smc = smc_sk(sk);
> +	int rc;
> +
> +	rc = sock_create_kern(net, family, SOCK_STREAM, IPPROTO_TCP,
> +			      &smc->clcsock);
> +	if (rc) {
> +		sk_common_release(sk);
> +		return rc;
> +	}
> +
> +	/* smc_clcsock_release() does not wait smc->clcsock->sk's
> +	 * destruction;  its sk_state might not be TCP_CLOSE after
> +	 * smc->sk is close()d, and TCP timers can be fired later,
> +	 * which need net ref.
> +	 */
> +	sk = smc->clcsock->sk;
> +	__netns_tracker_free(net, &sk->ns_tracker, false);
> +	sk->sk_net_refcnt = 1;
> +	get_net_track(net, &sk->ns_tracker, GFP_KERNEL);
> +	sock_inuse_add(net, 1);
> +	return 0;
> +}
> +
>  static int __smc_create(struct net *net, struct socket *sock, int protocol,
>  			int kern, struct socket *clcsock)
>  {
> @@ -3346,35 +3379,12 @@ static int __smc_create(struct net *net, struct socket *sock, int protocol,
>  
>  	/* create internal TCP socket for CLC handshake and fallback */
>  	smc = smc_sk(sk);
> -	smc->use_fallback = false; /* assume rdma capability first */
> -	smc->fallback_rsn = 0;
> -
> -	/* default behavior from limit_smc_hs in every net namespace */
> -	smc->limit_smc_hs = net->smc.limit_smc_hs;
>  
>  	rc = 0;
> -	if (!clcsock) {
> -		rc = sock_create_kern(net, family, SOCK_STREAM, IPPROTO_TCP,
> -				      &smc->clcsock);
> -		if (rc) {
> -			sk_common_release(sk);
> -			goto out;
> -		}
> -
> -		/* smc_clcsock_release() does not wait smc->clcsock->sk's
> -		 * destruction;  its sk_state might not be TCP_CLOSE after
> -		 * smc->sk is close()d, and TCP timers can be fired later,
> -		 * which need net ref.
> -		 */
> -		sk = smc->clcsock->sk;
> -		__netns_tracker_free(net, &sk->ns_tracker, false);
> -		sk->sk_net_refcnt = 1;
> -		get_net_track(net, &sk->ns_tracker, GFP_KERNEL);
> -		sock_inuse_add(net, 1);
> -	} else {
> +	if (!clcsock)
> +		rc = smc_create_clcsk(net, sk, family);
> +	else
>  		smc->clcsock = clcsock;
> -	}

Using if (clcsock) is more intuitive.

> -
>  out:
>  	return rc;
>  }
> diff --git a/net/smc/smc.h b/net/smc/smc.h
> index 18c8b78..a0accb5 100644
> --- a/net/smc/smc.h
> +++ b/net/smc/smc.h
> @@ -34,6 +34,11 @@
>  extern struct proto smc_proto;
>  extern struct proto smc_proto6;
>  
> +/* smc sock initialization */
> +void smc_sock_init(struct net *net, struct sock *sk, int protocol);
> +/* clcsock initialization */
> +int smc_create_clcsk(struct net *net, struct sock *sk, int family);
> +
>  #ifdef ATOMIC64_INIT
>  #define KERNEL_HAS_ATOMIC64
>  #endif
> -- 
> 1.8.3.1

