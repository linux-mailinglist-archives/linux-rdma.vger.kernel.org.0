Return-Path: <linux-rdma+bounces-4376-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DC0952EDF
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Aug 2024 15:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 813BA1C23E33
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Aug 2024 13:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDEB19E7DB;
	Thu, 15 Aug 2024 13:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="nxbPYXDc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB9219DFA4;
	Thu, 15 Aug 2024 13:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723727705; cv=none; b=MoUoHxUhapg6YCCXM+a11DVxqHPwU/1iRd3YI7Fg8AOVZNCdlcDVrdfSL9RPSXjO4nth/SufF7uRRriDrtmDes/jSipUShP909Ncy7vx1hZo5bQA4qgMtHZc4S5EztaG5puS/mg4qJHMIchN3I9bJY6QH8kkRDnw6+ixRrP4YPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723727705; c=relaxed/simple;
	bh=JRQl+0ZEFmGsUtBjXY/ysbNQyqzwoKtRYv6O7By/lJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ibIhwL+m6IbjptN1pMk1TOo5cU6Mvc5o7a6qkdUdxD8rhDeTrnsWG1nr1PGCBe56zTw+C+J20Gc1WfSgyqCcvatZwt2I9wyooMjZ8nl4KV//EdZn4zyl8lX84OJ0kphn8eTf8Ww6RDvdw6WhD3+DCfJL7LAVq+ZoG1PHC+UBrrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=nxbPYXDc; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723727694; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=pWBh4p9yI2moDU/VfvO40E3xJpS6Qt9QfhRqxfqTYYg=;
	b=nxbPYXDcz7T36OfiJ6BSIzelJJAhtnMdwseW9yHg3FGz73hklf3nbpQLjfQ7IpdFZJmWqIQYUrmQb+AtqhpAqfZRiy7SL+E6Ux4uC2SNdJNBQ1oU5XfMfsx5XaGufEFPN9OrYG0XVcgVTxjabiZo1iNJwIr1q5qDFI4sDVI7J5I=
Received: from 30.221.130.128(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0WCwrPf4_1723727692)
          by smtp.aliyun-inc.com;
          Thu, 15 Aug 2024 21:14:53 +0800
Message-ID: <67a37386-6d88-43b4-8cd4-fdbe263addb7@linux.alibaba.com>
Date: Thu, 15 Aug 2024 21:14:51 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/smc: add sysctl for smc_limit_hs
To: "D. Wythe" <alibuda@linux.alibaba.com>, kgraul@linux.ibm.com,
 wenjia@linux.ibm.com, jaka@linux.ibm.com, wintera@linux.ibm.com
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
 tonylu@linux.alibaba.com, pabeni@redhat.com, edumazet@google.com
References: <1723726988-78651-1-git-send-email-alibuda@linux.alibaba.com>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <1723726988-78651-1-git-send-email-alibuda@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/8/15 21:03, D. Wythe wrote:
> From: "D. Wythe" <alibuda@linux.alibaba.com>
> 
> In commit 48b6190a0042 ("net/smc: Limit SMC visits when handshake workqueue congested"),
> we introduce a mechanism to put constraint on SMC connections visit according to
> the pressure of SMC handshake process.
> 
> At that time, we believed that controlling the feature through netlink was sufficient,
> However, most people have realized now that netlink is not convenient in
> container scenarios, and sysctl is a more suitable approach.
> 
> In addition, it is not reasonable for us to initialize limit_smc_hs in
> smc_pnet_net_init, we made a mistable before. It should be initialized

nit: mistable -> mistake?

> in smc_sysctl_net_init(), just like other systcl.
> 
> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
> ---
>   net/smc/smc_pnet.c   |  3 ---
>   net/smc/smc_sysctl.c | 11 +++++++++++
>   2 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
> index 2adb92b..1dd3623 100644
> --- a/net/smc/smc_pnet.c
> +++ b/net/smc/smc_pnet.c
> @@ -887,9 +887,6 @@ int smc_pnet_net_init(struct net *net)
>   
>   	smc_pnet_create_pnetids_list(net);
>   
> -	/* disable handshake limitation by default */
> -	net->smc.limit_smc_hs = 0;
> -
>   	return 0;
>   }
>   
> diff --git a/net/smc/smc_sysctl.c b/net/smc/smc_sysctl.c
> index 13f2bc0..2fab645 100644
> --- a/net/smc/smc_sysctl.c
> +++ b/net/smc/smc_sysctl.c
> @@ -90,6 +90,15 @@
>   		.extra1		= &conns_per_lgr_min,
>   		.extra2		= &conns_per_lgr_max,
>   	},
> +	{
> +		.procname	= "limit_smc_hs",
> +		.data		= &init_net.smc.limit_smc_hs,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec_minmax,
> +		.extra1		= SYSCTL_ZERO,
> +		.extra2		= SYSCTL_ONE,
> +	},
>   };
>   
>   int __net_init smc_sysctl_net_init(struct net *net)
> @@ -121,6 +130,8 @@ int __net_init smc_sysctl_net_init(struct net *net)
>   	WRITE_ONCE(net->smc.sysctl_rmem, net_smc_rmem_init);
>   	net->smc.sysctl_max_links_per_lgr = SMC_LINKS_PER_LGR_MAX_PREFER;
>   	net->smc.sysctl_max_conns_per_lgr = SMC_CONN_PER_LGR_PREFER;
> +	/* disable handshake limitation by default */
> +	net->smc.limit_smc_hs = 0;
>   
>   	return 0;
>   

