Return-Path: <linux-rdma+bounces-4449-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6339595F7
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2024 09:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E3551F27407
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2024 07:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93069192D7E;
	Wed, 21 Aug 2024 07:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="tfl1nfU9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55035192D6A;
	Wed, 21 Aug 2024 07:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724224896; cv=none; b=karUb7rS+Dew/QTeK3mU4DHxbrOq3ApTFehqEuFrAFrRODaUEip6DphOtQ/OameqRrqqqxBcU4DbMfrt5aSvtQNRtnrrN+rpKuN4UiECLN+A8VBO5e8Gr9YgIgXA9Lh7Gi/EUaKkbaEDxBAyYJdZ4gTDMq3gsfXhNth2JDOdxbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724224896; c=relaxed/simple;
	bh=qem4JFOAPo7pnTdvLYmz7d6aS7GCgEX9RwpTAjEWzGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IlgeVs1pWbgP5+we5423hxMrqDUT6oAxQlzljgf5zBuGc7i9GoGEsaFwn1TS5UGXW3FaLH60slNWhu0Md4hnj5NmgzHxC8TsRpFasVHo0VY/i+J+RqB6ikiwHoUKiaHXhzXZ4lU86r//ESPWJn0C+sBOvaZQiGG9bkJeD1Fq5IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=tfl1nfU9; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724224884; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=UW8mOOqoz+NzPBI/v1IyqHl4Qr4pnSSE8aw2p4yjuoI=;
	b=tfl1nfU9XVFUABj6b6W3DiUWd2siwVzfrS4lppkNQb1JHBUm3H7+h9aE7iEKA40VuEaUzYo+dABHj7SV2bTAOUE6shwxNfKIu0s8zpAlW6OCAJINXPam+yYwHwzE5rd6CZdQXQlEaqPgiHdyG6w+esz2cRt9LJ3+gcHwNHyy4Ik=
Received: from 30.221.129.37(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0WDL2XV8_1724224882)
          by smtp.aliyun-inc.com;
          Wed, 21 Aug 2024 15:21:23 +0800
Message-ID: <c516f91d-9db4-4948-a5dc-df1660948f85@linux.alibaba.com>
Date: Wed, 21 Aug 2024 15:21:22 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net/smc: add sysctl for smc_limit_hs
To: "D. Wythe" <alibuda@linux.alibaba.com>, kgraul@linux.ibm.com,
 wenjia@linux.ibm.com, jaka@linux.ibm.com, wintera@linux.ibm.com
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
 tonylu@linux.alibaba.com, pabeni@redhat.com, edumazet@google.com
References: <1724207797-79030-1-git-send-email-alibuda@linux.alibaba.com>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <1724207797-79030-1-git-send-email-alibuda@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/8/21 10:36, D. Wythe wrote:
> From: "D. Wythe" <alibuda@linux.alibaba.com>
> 
> In commit 48b6190a0042 ("net/smc: Limit SMC visits when handshake workqueue congested"),
> we introduce a mechanism to put constraint on SMC connections visit
> according to the pressure of SMC handshake process.
> 
> At that time, we believed that controlling the feature through netlink
> was sufficient. However, most people have realized now that netlink is
> not convenient in container scenarios, and sysctl is a more suitable
> approach.
> 
> In addition, since commit 462791bbfa35 ("net/smc: add sysctl interface for SMC")
> had introcuded smc_sysctl_net_init(), it is reasonable for us to
> initialize limit_smc_hs in it instead of initializing it in
> smc_pnet_net_int().
> 
> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>

LGTM. Thanks!

Reviewed-by: Wen Gu <guwen@linux.alibaba.com>

> ---
> v1 -> v2:
> 
> Modified the description in the commit and removed the incorrect
> spelling.
> 
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

