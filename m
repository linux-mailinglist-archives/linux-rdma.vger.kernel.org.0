Return-Path: <linux-rdma+bounces-5146-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D749989535
	for <lists+linux-rdma@lfdr.de>; Sun, 29 Sep 2024 13:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15EBAB228DC
	for <lists+linux-rdma@lfdr.de>; Sun, 29 Sep 2024 11:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D8416C684;
	Sun, 29 Sep 2024 11:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c16J43vL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00191531F8
	for <linux-rdma@vger.kernel.org>; Sun, 29 Sep 2024 11:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727611016; cv=none; b=KFGkoZ8jPl3BY0XdV+XT6Ilye1d6NYVqzC2glE0NdBzuaDeQFvipakOq6U7gb84v2H8AJeLr99cztPXRQsUhuoNTVMaS5qegsoXV4C925cB9/HzEuQ4NsAwAP086bh+Xtl/audr/+mMjRyowj6oXkY5ezLHELd6lDEH1+nzLLDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727611016; c=relaxed/simple;
	bh=kRdlNh2IHMBzOlcxstBQXWNI19MwftyElilV8HkvdK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MwzMimX8oZvGzwAGIA0mWoK7P+45P+Zdp99IbJ7CM4vRdquTzcx4YnoapANUxYIZjOZ+5ni8QRSAbDnYpYKiTvxvKmLVtVcB4piy9vE9yBsFdl8k3ROT6+xgJ+Nj1TnRAoU8++FwFhABYoKJCKGPwRxl8QQ5zBHQnGLWSbH2Sy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=c16J43vL; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f60061bb-109a-4fa8-b419-07585cbb79e3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727611011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hAC//q1Q0snEPQ/btU6qHTHCF/zamSYZtJr8ip76b+8=;
	b=c16J43vLB2hZPHz6tqz1HC9iB1xmdlprrXdGrQVKOfjC40iLWd8pDmUjeHHwgem1CKxzGL
	Ng5nZZUJo8UqQRfBFImIqFuZFgu2gq6gdbZEYpu50omzXoS8Kf7yg0al9ZZIr83bb6Am1r
	Z2sy3Fygp6gN4K2Tke2melQjUDtFCXU=
Date: Sun, 29 Sep 2024 19:56:17 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH net-next v2] net/smc: Introduce a hook to modify
 syn_smc at runtime
To: "D. Wythe" <alibuda@linux.alibaba.com>, kgraul@linux.ibm.com,
 wenjia@linux.ibm.com, jaka@linux.ibm.com, wintera@linux.ibm.com,
 guwen@linux.alibaba.com
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
 tonylu@linux.alibaba.com, pabeni@redhat.com, edumazet@google.com,
 bpf@vger.kernel.org
References: <1727408549-106551-1-git-send-email-alibuda@linux.alibaba.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <1727408549-106551-1-git-send-email-alibuda@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/9/27 11:42, D. Wythe 写道:
> From: "D. Wythe" <alibuda@linux.alibaba.com>
> 
> The introduction of IPPROTO_SMC enables eBPF programs to determine
> whether to use SMC based on the context of socket creation, such as
> network namespaces, PID and comm name, etc.
> 
> As a subsequent enhancement, this patch introduces a new hook for eBPF
> programs that allows decisions on whether to use SMC or not at runtime,
> including but not limited to local/remote IP address or ports. In
> simpler words, this feature allows modifications to syn_smc through eBPF
> programs before the TCP three-way handshake got established.
> 
> Thanks to kfunc for making it easier for us to implement this feature in
> SMC.
> 
> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
> 
> ---
> v1 -> v2:
> 1. Fix wrong use of ireq->smc_ok, should be rx_opt->smc_ok.
> 2. Fix compile error when CONFIG_IPV6 or CONFIG_BPF_SYSCALL was not set.
> 
> ---
>   include/linux/tcp.h  |  4 ++-
>   net/ipv4/tcp_input.c |  4 +--
>   net/smc/af_smc.c     | 75 ++++++++++++++++++++++++++++++++++++++++++++++------
>   3 files changed, 72 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> index 6a5e08b..d028d76 100644
> --- a/include/linux/tcp.h
> +++ b/include/linux/tcp.h
> @@ -478,7 +478,9 @@ struct tcp_sock {
>   #endif
>   #if IS_ENABLED(CONFIG_SMC)
>   	bool	syn_smc;	/* SYN includes SMC */
> -	bool	(*smc_hs_congested)(const struct sock *sk);
> +	void	(*smc_openreq_init)(struct request_sock *req,
> +			     const struct tcp_options_received *rx_opt,
> +			     struct sk_buff *skb, const struct sock *sk);
>   #endif
>   
>   #if defined(CONFIG_TCP_MD5SIG) || defined(CONFIG_TCP_AO)
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 9f314df..99f34f5 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -7036,8 +7036,8 @@ static void tcp_openreq_init(struct request_sock *req,
>   	ireq->ir_num = ntohs(tcp_hdr(skb)->dest);
>   	ireq->ir_mark = inet_request_mark(sk, skb);
>   #if IS_ENABLED(CONFIG_SMC)
> -	ireq->smc_ok = rx_opt->smc_ok && !(tcp_sk(sk)->smc_hs_congested &&
> -			tcp_sk(sk)->smc_hs_congested(sk));
> +	if (rx_opt->smc_ok && tcp_sk(sk)->smc_openreq_init)
> +		tcp_sk(sk)->smc_openreq_init(req, rx_opt, skb, sk);
>   #endif
>   }
>   
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index 0316217..fdac7e2b 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -70,6 +70,15 @@
>   static void smc_tcp_listen_work(struct work_struct *);
>   static void smc_connect_work(struct work_struct *);
>   
> +__bpf_hook_start();
> +
> +__weak noinline int select_syn_smc(const struct sock *sk, struct sockaddr *peer)
> +{
> +	return 1;
> +}
> +
> +__bpf_hook_end();
> +
>   int smc_nl_dump_hs_limitation(struct sk_buff *skb, struct netlink_callback *cb)
>   {
>   	struct smc_nl_dmp_ctx *cb_ctx = smc_nl_dmp_ctx(cb);
> @@ -156,19 +165,43 @@ static struct sock *smc_tcp_syn_recv_sock(const struct sock *sk,
>   	return NULL;
>   }
>   
> -static bool smc_hs_congested(const struct sock *sk)
> +static void smc_openreq_init(struct request_sock *req,
> +			     const struct tcp_options_received *rx_opt,
> +			     struct sk_buff *skb, const struct sock *sk)
>   {
> +	struct inet_request_sock *ireq = inet_rsk(req);
> +	struct sockaddr_storage rmt_sockaddr = {0};

A trivial problem.

The following should be better?

struct sockaddr_storage rmt_sockaddr = {};

I think, we have discussed this problem in RDMA maillist for several times.

Zhu Yanjun

>   	const struct smc_sock *smc;
>   
>   	smc = smc_clcsock_user_data(sk);
>   
>   	if (!smc)
> -		return true;
> +		return;
>   
> -	if (workqueue_congested(WORK_CPU_UNBOUND, smc_hs_wq))
> -		return true;
> +	if (smc->limit_smc_hs && workqueue_congested(WORK_CPU_UNBOUND, smc_hs_wq))
> +		goto out_no_smc;
>   
> -	return false;
> +	rmt_sockaddr.ss_family = sk->sk_family;
> +
> +	if (rmt_sockaddr.ss_family == AF_INET) {
> +		struct sockaddr_in *rmt4_sockaddr =  (struct sockaddr_in *)&rmt_sockaddr;
> +
> +		rmt4_sockaddr->sin_addr.s_addr = ireq->ir_rmt_addr;
> +		rmt4_sockaddr->sin_port	= ireq->ir_rmt_port;
> +#if IS_ENABLED(CONFIG_IPV6)
> +	} else {
> +		struct sockaddr_in6 *rmt6_sockaddr =  (struct sockaddr_in6 *)&rmt_sockaddr;
> +
> +		rmt6_sockaddr->sin6_addr = ireq->ir_v6_rmt_addr;
> +		rmt6_sockaddr->sin6_port = ireq->ir_rmt_port;
> +#endif /* CONFIG_IPV6 */
> +	}
> +
> +	ireq->smc_ok = select_syn_smc(sk, (struct sockaddr *)&rmt_sockaddr);
> +	return;
> +out_no_smc:
> +	ireq->smc_ok = 0;
> +	return;
>   }
>   
>   struct smc_hashinfo smc_v4_hashinfo = {
> @@ -1671,7 +1704,7 @@ int smc_connect(struct socket *sock, struct sockaddr *addr,
>   	}
>   
>   	smc_copy_sock_settings_to_clc(smc);
> -	tcp_sk(smc->clcsock->sk)->syn_smc = 1;
> +	tcp_sk(smc->clcsock->sk)->syn_smc = select_syn_smc(sk, addr);
>   	if (smc->connect_nonblock) {
>   		rc = -EALREADY;
>   		goto out;
> @@ -2650,8 +2683,7 @@ int smc_listen(struct socket *sock, int backlog)
>   
>   	inet_csk(smc->clcsock->sk)->icsk_af_ops = &smc->af_ops;
>   
> -	if (smc->limit_smc_hs)
> -		tcp_sk(smc->clcsock->sk)->smc_hs_congested = smc_hs_congested;
> +	tcp_sk(smc->clcsock->sk)->smc_openreq_init = smc_openreq_init;
>   
>   	rc = kernel_listen(smc->clcsock, backlog);
>   	if (rc) {
> @@ -3475,6 +3507,24 @@ static void __net_exit smc_net_stat_exit(struct net *net)
>   	.exit = smc_net_stat_exit,
>   };
>   
> +#if IS_ENABLED(CONFIG_BPF_SYSCALL)
> +BTF_SET8_START(bpf_smc_fmodret_ids)
> +BTF_ID_FLAGS(func, select_syn_smc)
> +BTF_SET8_END(bpf_smc_fmodret_ids)
> +
> +static const struct btf_kfunc_id_set bpf_smc_fmodret_set = {
> +	.owner = THIS_MODULE,
> +	.set   = &bpf_smc_fmodret_ids,
> +};
> +
> +static int bpf_smc_kfunc_init(void)
> +{
> +	return register_btf_fmodret_id_set(&bpf_smc_fmodret_set);
> +}
> +#else
> +static inline int bpf_smc_kfunc_init(void) { return 0; }
> +#endif /* CONFIG_BPF_SYSCALL */
> +
>   static int __init smc_init(void)
>   {
>   	int rc;
> @@ -3574,8 +3624,17 @@ static int __init smc_init(void)
>   		pr_err("%s: smc_inet_init fails with %d\n", __func__, rc);
>   		goto out_ulp;
>   	}
> +
> +	rc = bpf_smc_kfunc_init();
> +	if (rc) {
> +		pr_err("%s: bpf_smc_kfunc_init fails with %d\n", __func__, rc);
> +		goto out_inet;
> +	}
> +
>   	static_branch_enable(&tcp_have_smc);
>   	return 0;
> +out_inet:
> +	smc_inet_exit();
>   out_ulp:
>   	tcp_unregister_ulp(&smc_ulp_ops);
>   out_lo:


