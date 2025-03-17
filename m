Return-Path: <linux-rdma+bounces-8735-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C135EA63DAC
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Mar 2025 04:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E47916D04D
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Mar 2025 03:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C292B13A88A;
	Mon, 17 Mar 2025 03:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="eBTypSTn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E2214A4F9;
	Mon, 17 Mar 2025 03:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742183846; cv=none; b=CmR24MDpp2VwUggHLmGl/w44NuIfRCQNKzqHCfBfClVLxhDsStScrLDptytIXQJErCxKGFwzSrigjIcu7pK4aoBrsJO2IZDzixuHrF+kILou5qaoho8oaLeMODpSzIoCAwDCt8lHv2PjBVPStxS3DNpPszPxR7dXePv8/0RrmEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742183846; c=relaxed/simple;
	bh=bTXhexVaI+W5KWG7d5Svg2VmXApCu8ktNMe5tbjLp8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DsseLdG1+zizhQLJUeVtrGgvuxev/JBYpud+Y08sOOQuWKX1fbRmbvao9t8zJ3IyfqmvLb2mjUXcu8PQ+UkJruf9Xn/XZ0UXFSUciX3NudzqUgoVmHnWnJl5OG2x2MdMJYQ2iRQz6G2vS4BQR42jkTq006Sn6ID5RYYsxGBUpOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=eBTypSTn; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1742183839; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=uE6H0MBz98j5rhIzPJHfWr/CNL9ORRA0RW3EN1COpxM=;
	b=eBTypSTnXuFlhKc+ixGvt8BjmjPdCkwmmSi5/ONZA+vVIi7u0zxY+gxtzsn90B8pP9q/X0aiSwLhM1ZA3/7dcEaMOJ4vvzp0odKHubAFLWj97FnPUabEzTd8qOa3IdjlGwerbXBxwyKzk30vTfUuwLhyFwHSnOhqSfTGHDB4BsE=
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0WRYMu4H_1742183838 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 17 Mar 2025 11:57:18 +0800
Date: Mon, 17 Mar 2025 11:57:18 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: "D. Wythe" <alibuda@linux.alibaba.com>, kgraul@linux.ibm.com,
	wenjia@linux.ibm.com, jaka@linux.ibm.com, wintera@linux.ibm.com,
	guwen@linux.alibaba.com
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
	tonylu@linux.alibaba.com, pabeni@redhat.com, edumazet@google.com
Subject: Re: [RFC PATCH net-next] net/smc: avoid conflict with sockmap after
 fallback
Message-ID: <20250317035718.GD56800@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20250312133014.35775-1-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312133014.35775-1-alibuda@linux.alibaba.com>

On 2025-03-12 21:30:14, D. Wythe wrote:
>Currently, after fallback, SMC will occupy the sk_user_data of the TCP sock(clcsk) to
>forward events. As a result, we cannot use sockmap after that, since sockmap also
>requires the use of the sk_user_data. Even more, in some cases, this may result in
>abnormal panic.

Looks like this is a bugfix more then a feature.

>
>To enable sockmap after SMC fallback , we need to avoid using sk_user_data and
>instead introduce an additional smc_ctx in tcp_sock to index from TCP sock to SMC sock.
>
>Additionally, we bind the lifecycle of the SMC sock to that of the TCP sock, ensuring
>that the indexing to the SMC sock remains valid throughout the lifetime of the TCP sock.
>
>One key reason is that SMC overrides inet_connection_sock_af_ops, which introduces
>potential dependencies. We must ensure that the af_ops remain visible throughout the
>lifecycle of the TCP socket. In addition, this also resolves potential issues in some
>scenarios where the SMC sock might be invalid.
>
>Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
>---
> include/linux/tcp.h |  1 +
> net/smc/af_smc.c    | 53 ++++++++++++++++++++++-----------------------
> net/smc/smc.h       |  8 +++----
> net/smc/smc_close.c |  1 -
> 4 files changed, 30 insertions(+), 33 deletions(-)
>
>diff --git a/include/linux/tcp.h b/include/linux/tcp.h
>index f88daaa76d83..f2223b1cc0d0 100644
>--- a/include/linux/tcp.h
>+++ b/include/linux/tcp.h
>@@ -478,6 +478,7 @@ struct tcp_sock {
> #if IS_ENABLED(CONFIG_SMC)
> 	bool	syn_smc;	/* SYN includes SMC */
> 	bool	(*smc_hs_congested)(const struct sock *sk);
>+	void	*smc_ctx;
> #endif
> 
> #if defined(CONFIG_TCP_MD5SIG) || defined(CONFIG_TCP_AO)
>diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
>index bc356f77ff1d..d434105639c1 100644
>--- a/net/smc/af_smc.c
>+++ b/net/smc/af_smc.c
>@@ -127,7 +127,7 @@ static struct sock *smc_tcp_syn_recv_sock(const struct sock *sk,
> 	struct smc_sock *smc;
> 	struct sock *child;
> 
>-	smc = smc_clcsock_user_data(sk);
>+	smc = smc_sk_from_clcsk(sk);
> 
> 	if (READ_ONCE(sk->sk_ack_backlog) + atomic_read(&smc->queued_smc_hs) >
> 				sk->sk_max_ack_backlog)
>@@ -143,8 +143,6 @@ static struct sock *smc_tcp_syn_recv_sock(const struct sock *sk,
> 					       own_req);
> 	/* child must not inherit smc or its ops */
> 	if (child) {
>-		rcu_assign_sk_user_data(child, NULL);
>-
> 		/* v4-mapped sockets don't inherit parent ops. Don't restore. */
> 		if (inet_csk(child)->icsk_af_ops == inet_csk(sk)->icsk_af_ops)
> 			inet_csk(child)->icsk_af_ops = smc->ori_af_ops;
>@@ -161,10 +159,7 @@ static bool smc_hs_congested(const struct sock *sk)
> {
> 	const struct smc_sock *smc;
> 
>-	smc = smc_clcsock_user_data(sk);
>-
>-	if (!smc)
>-		return true;
>+	smc = smc_sk_from_clcsk(sk);

I don't see any users of smc in this function. Seems it is redundant here.

> 
> 	if (workqueue_congested(WORK_CPU_UNBOUND, smc_hs_wq))
> 		return true;
>@@ -250,7 +245,6 @@ static void smc_fback_restore_callbacks(struct smc_sock *smc)
> 	struct sock *clcsk = smc->clcsock->sk;
> 
> 	write_lock_bh(&clcsk->sk_callback_lock);
>-	clcsk->sk_user_data = NULL;
> 
> 	smc_clcsock_restore_cb(&clcsk->sk_state_change, &smc->clcsk_state_change);
> 	smc_clcsock_restore_cb(&clcsk->sk_data_ready, &smc->clcsk_data_ready);
>@@ -832,11 +826,10 @@ static void smc_fback_forward_wakeup(struct smc_sock *smc, struct sock *clcsk,
> 
> static void smc_fback_state_change(struct sock *clcsk)
> {
>-	struct smc_sock *smc;
>+	struct smc_sock *smc = smc_sk_from_clcsk(clcsk);
> 
> 	read_lock_bh(&clcsk->sk_callback_lock);
>-	smc = smc_clcsock_user_data(clcsk);
>-	if (smc)
>+	if (smc->clcsk_state_change)
> 		smc_fback_forward_wakeup(smc, clcsk,
> 					 smc->clcsk_state_change);

Since we checked the clcsock_callback everywhere, why not put it into
smc_fback_forward_wakeup() ?


Best regards,
Dust


