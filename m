Return-Path: <linux-rdma+bounces-12097-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE9FB03457
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Jul 2025 04:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B35E5189375B
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Jul 2025 02:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CAE01A4F3C;
	Mon, 14 Jul 2025 02:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qQTNrpWx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F9E42AA3;
	Mon, 14 Jul 2025 02:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752458685; cv=none; b=Jwv6pYD2fPlAGJ+3oYTt+TXCUJnJEli0B1yBgxOYCLjFY8SQeaPQmDqIC1Hoc0YMliRWC2CTlNfCUbe0+5Fw6ESmfYRrkk3d/SIhF+lE8PCl9iJO0/cc35ERqgkwte9Qpg4PSAUfncTy2guCk+pk+Sd+3iuOy7BXjfp48oUy7pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752458685; c=relaxed/simple;
	bh=Swel8+Ssrwv3a4vwdbEnGp6NgWxE//blgcf/Z2L7iE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AkUKkiEf3Lu9EJ/LhXrRx61q4d+qvFjwJf1TtO0SbdD10ZfmK6AK2iS1qCAJyuRXgyNT2QQh5nNCRM0zXl0Dpys8FHa+97d+vvr7anvezAGk+kQKZlpyAdw0Mi/J/WqVXc7C9uFFEacI83kIvg+B2RPHEDLqZS1T8ALCTYTKRaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qQTNrpWx; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752458673; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=4vT8g91Gf2D7R076tAvxSVhUHFc0rhxTelmW9aX06s4=;
	b=qQTNrpWxgOiOTQw+RwVJizdTSlvSKLFHcy+eKCmqlSf21QLkEcrF4qNxNfbqKkuHjSMHEdzCXzu4CW23GC6D7xYK0u4yZ/R/wzs5jvNheu03SBi24jnOHiHkqztEoigFb3+Cwm2uGzJOD3T+fBBg0qsGP7u0EC/gn2A/QuH9N7s=
Received: from localhost(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0Wio9yUM_1752458672 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 14 Jul 2025 10:04:33 +0800
Date: Mon, 14 Jul 2025 10:04:32 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com    >
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "D. Wythe" <alibuda@linux.alibaba.com>,
	Dust Li <dust.li@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>, Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
	syzbot+40bf00346c3fe40f90f2@syzkaller.appspotmail.com,
	syzbot+f22031fad6cbe52c70e7@syzkaller.appspotmail.com,
	syzbot+271fed3ed6f24600c364@syzkaller.appspotmail.com
Subject: Re: [PATCH v1 net] smc: Fix various oops due to inet_sock type
 confusion.
Message-ID: <20250714020432.GA90524@j66a10360.sqa.eu95>
References: <20250711060808.2977529-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711060808.2977529-1-kuniyu@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Fri, Jul 11, 2025 at 06:07:52AM +0000, Kuniyuki Iwashima wrote:
> syzbot reported weird splats [0][1] in cipso_v4_sock_setattr() while
> freeing inet_sk(sk)->inet_opt.
> 
> The address was freed multiple times even though it was read-only memory.
> 
> cipso_v4_sock_setattr() did nothing wrong, and the root cause was type
> confusion.
> 
> The cited commit made it possible to create smc_sock as an INET socket.
> 
> The issue is that struct smc_sock does not have struct inet_sock as the
> first member but hijacks AF_INET and AF_INET6 sk_family, which confuses
> various places.
> 
> In this case, inet_sock.inet_opt was actually smc_sock.clcsk_data_ready(),
> which is an address of a function in the text segment.
> 
>   $ pahole -C inet_sock vmlinux
>   struct inet_sock {
>   ...
>           struct ip_options_rcu *    inet_opt;             /*   784     8 */
> 
>   $ pahole -C smc_sock vmlinux
>   struct smc_sock {
>   ...
>           void                       (*clcsk_data_ready)(struct sock *); /*   784     8 */
> 
> 
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index 3760131f14845..1882bab8e00e7 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -30,6 +30,10 @@
>  #include <linux/splice.h>
>  
>  #include <net/sock.h>
> +#include <net/inet_common.h>
> +#if IS_ENABLED(CONFIG_IPV6)
> +#include <net/ipv6.h>
> +#endif
>  #include <net/tcp.h>
>  #include <net/smc.h>
>  #include <asm/ioctls.h>
> @@ -360,6 +364,16 @@ static void smc_destruct(struct sock *sk)
>  		return;
>  	if (!sock_flag(sk, SOCK_DEAD))
>  		return;
> +	switch (sk->sk_family) {
> +	case AF_INET:
> +		inet_sock_destruct(sk);
> +		break;
> +#if IS_ENABLED(CONFIG_IPV6)
> +	case AF_INET6:
> +		inet6_sock_destruct(sk);
> +		break;
> +#endif
> +	}
>  }
>  
>  static struct lock_class_key smc_key;
> diff --git a/net/smc/smc.h b/net/smc/smc.h
> index 78ae10d06ed2e..2c90849637398 100644
> --- a/net/smc/smc.h
> +++ b/net/smc/smc.h
> @@ -283,10 +283,10 @@ struct smc_connection {
>  };
>  
>  struct smc_sock {				/* smc sock container */
> -	struct sock		sk;
> -#if IS_ENABLED(CONFIG_IPV6)
> -	struct ipv6_pinfo	*pinet6;
> -#endif
> +	union {
> +		struct sock		sk;
> +		struct inet_sock	icsk_inet;
> +	};
>  	struct socket		*clcsock;	/* internal tcp socket */
>  	void			(*clcsk_state_change)(struct sock *sk);
>  						/* original stat_change fct. */
> -- 

LGTM. This is what we should have resolved a long time ago. Thank
you for your report and repair!

Reviewed-by: D. Wythe <alibuda@linux.alibaba.com>

> 2.50.0.727.gbf7dc18ff4-goog

