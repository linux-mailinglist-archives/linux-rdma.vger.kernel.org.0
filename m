Return-Path: <linux-rdma+bounces-2418-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC348C313F
	for <lists+linux-rdma@lfdr.de>; Sat, 11 May 2024 14:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF2D01C20C0F
	for <lists+linux-rdma@lfdr.de>; Sat, 11 May 2024 12:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779A256448;
	Sat, 11 May 2024 12:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TlLqps4Q"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D85355C29
	for <linux-rdma@vger.kernel.org>; Sat, 11 May 2024 12:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715430099; cv=none; b=pQFab66SnXk1/xuxnuUO90FKSbgxZeoQ21tPpzk22bNy7syO4cLOjxVm4wQ7Uu7gG9di0EZXsPq8trIqUe5h04eb7qXbfm1uFKgbpShXigxqt3cdQOwM4uZ+s5EzCMA9BHMlAVhFBYsY9svK+DqGkHovVI9elMFTmiR3p9IjYZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715430099; c=relaxed/simple;
	bh=/s/EJ4Je67SgUx8knRzcJnnkEqUgDovl83UXXVmO9NM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CGRQTwn+WumR6lyF4gnX3DVBc1dS3HJl1omaMp/FlUCTlYoNe7IuGseGx7dGiH9g6huNvf+NldWKb0fFIMeO5PgMH47h5F4SJ6fUKJivkVOQOcGzxJUAr0ObJbEzBmW7yPeswiNHx7Hnsy1DxcdlOIAX6J3Tdr5Fwf7mWg2vaTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TlLqps4Q; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <11f7d33c-80b1-40db-87c0-566ed24c389e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715430093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tlvf+UlQ8ivFvfmxIaptV3Ron15h1w/sRKGEJBxcYgc=;
	b=TlLqps4QtC+iBmiJlBJAtOvBjiHGZqg3Q+ulvm29I6tV0AwhEVhfKTHlGd+7C95A8FfTeX
	D8wZc6KevLkBHzx4MwuaFOgSK23JMMUXEkcu1NUbo1NIboMLTFB1yDdPtzF4QaO4dIdRxs
	HlLHgqQlO72H1Y4THirO1Nb+sa9+veM=
Date: Sat, 11 May 2024 14:21:28 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 1/2] net/smc: refatoring initialization of smc
 sock
To: "D. Wythe" <alibuda@linux.alibaba.com>, kgraul@linux.ibm.com,
 wenjia@linux.ibm.com, jaka@linux.ibm.com, wintera@linux.ibm.com,
 guwen@linux.alibaba.com
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
 tonylu@linux.alibaba.com, pabeni@redhat.com, edumazet@google.com
References: <1715314333-107290-1-git-send-email-alibuda@linux.alibaba.com>
 <1715314333-107290-2-git-send-email-alibuda@linux.alibaba.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <1715314333-107290-2-git-send-email-alibuda@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/5/10 6:12, D. Wythe 写道:
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
>   net/smc/af_smc.c | 93 +++++++++++++++++++++++++++++++-------------------------
>   1 file changed, 52 insertions(+), 41 deletions(-)
> 
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index 9389f0c..1f03724 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -361,34 +361,43 @@ static void smc_destruct(struct sock *sk)
>   		return;
>   }
>   
> -static struct sock *smc_sock_alloc(struct net *net, struct socket *sock,
> -				   int protocol)
> +static void smc_sock_init(struct net *net, struct sock *sk, int protocol)
>   {
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
>   	sk->sk_state = SMC_INIT;
> -	sk->sk_destruct = smc_destruct;
>   	sk->sk_protocol = protocol;
> +	mutex_init(&smc->clcsock_release_lock);

Please add mutex_destroy(&smc->clcsock_release_lock); when 
smc->clcsock_release_lock is no longer used.

Or else some tools will notify errors.

Zhu Yanjun

>   	WRITE_ONCE(sk->sk_sndbuf, 2 * READ_ONCE(net->smc.sysctl_wmem));
>   	WRITE_ONCE(sk->sk_rcvbuf, 2 * READ_ONCE(net->smc.sysctl_rmem));
> -	smc = smc_sk(sk);
>   	INIT_WORK(&smc->tcp_listen_work, smc_tcp_listen_work);
>   	INIT_WORK(&smc->connect_work, smc_connect_work);
>   	INIT_DELAYED_WORK(&smc->conn.tx_work, smc_tx_work);
>   	INIT_LIST_HEAD(&smc->accept_q);
>   	spin_lock_init(&smc->accept_q_lock);
>   	spin_lock_init(&smc->conn.send_lock);
> -	sk->sk_prot->hash(sk);
> -	mutex_init(&smc->clcsock_release_lock);
>   	smc_init_saved_callbacks(smc);
> +	smc->limit_smc_hs = net->smc.limit_smc_hs;
> +	smc->use_fallback = false; /* assume rdma capability first */
> +	smc->fallback_rsn = 0;
> +
> +	sk->sk_destruct = smc_destruct;
> +	sk->sk_prot->hash(sk);
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
>   	return sk;
>   }
> @@ -3321,6 +3330,31 @@ static ssize_t smc_splice_read(struct socket *sock, loff_t *ppos,
>   	.splice_read	= smc_splice_read,
>   };
>   
> +static int __smc_create_clcsk(struct net *net, struct sock *sk, int family)
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
>   static int __smc_create(struct net *net, struct socket *sock, int protocol,
>   			int kern, struct socket *clcsock)
>   {
> @@ -3346,35 +3380,12 @@ static int __smc_create(struct net *net, struct socket *sock, int protocol,
>   
>   	/* create internal TCP socket for CLC handshake and fallback */
>   	smc = smc_sk(sk);
> -	smc->use_fallback = false; /* assume rdma capability first */
> -	smc->fallback_rsn = 0;
> -
> -	/* default behavior from limit_smc_hs in every net namespace */
> -	smc->limit_smc_hs = net->smc.limit_smc_hs;
>   
>   	rc = 0;
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
> +		rc = __smc_create_clcsk(net, sk, family);
> +	else
>   		smc->clcsock = clcsock;
> -	}
> -
>   out:
>   	return rc;
>   }


