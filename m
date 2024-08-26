Return-Path: <linux-rdma+bounces-4562-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE66095E726
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Aug 2024 05:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 895BA280D1A
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Aug 2024 03:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F1329CE3;
	Mon, 26 Aug 2024 03:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FyP5Niyr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8613B782;
	Mon, 26 Aug 2024 03:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724641350; cv=none; b=NbxwFQouETs3nXQrf9MdPZQCretjfYG49okq+fobh4FACIKdYMponCHhgYiALp6DdSFqOsmhkwJsQuMvedQdww1z/pSg4Uz4j+SVnBpT++VX8L7/LJJZyiPjPP+ZIkDgXtXco6We0bCVMPP1BgoNajhW/M6yXX4ShDNCRx9qG1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724641350; c=relaxed/simple;
	bh=VjIlopdqZuw8VP4Qh1X2Kuud4Tkp4qC5l9XYPYuJ5Sk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E+ARZ+4+R2ilggKwzI7fthtULCMkWsQXQubNQhrlt/2JBomIzmPUF21KIouDYPhPX22MZ+Qx45jPjXR4BuwH0lMrzp8wyfNmt5A8GjPZ+0QL96wlfEC63HVeUK4T+ak3hZbmn+sYNCCFfUsRuy2uFBlc6XPz7Rr1T6KszAi0ynM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FyP5Niyr; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724641337; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=CvvxHfpS85d5aDu+fNL+oDEoJsL4m5S3j6OjkVmrjtI=;
	b=FyP5NiyrUheHoiCDX9KZ+U7t5S4XVO9dv7BDi6+pXsvQ2TI8fjJcRM+GPXa1sOjSYzAOxwcdYR9oZRix8IhOCAWEXK8M79cVLCc88uJCCk/MWCvG96EWIBqumtjblldo3DkJOvLNl6L7hUs0OTZ9LDIcSRW0qPxdUu4lxpZ3iHA=
Received: from 30.13.156.235(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WDaEZ5R_1724641335)
          by smtp.aliyun-inc.com;
          Mon, 26 Aug 2024 11:02:16 +0800
Message-ID: <905874a4-c000-4845-8fac-3fc4b79f43fd@linux.alibaba.com>
Date: Mon, 26 Aug 2024 11:02:14 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net/smc: add sysctl for smc_limit_hs
To: Jan Karcher <jaka@linux.ibm.com>, kgraul@linux.ibm.com,
 wenjia@linux.ibm.com, wintera@linux.ibm.com, guwen@linux.alibaba.com
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
 tonylu@linux.alibaba.com, pabeni@redhat.com, edumazet@google.com
References: <1724207797-79030-1-git-send-email-alibuda@linux.alibaba.com>
 <abd79f44-aed2-4e01-a7f8-7d806f5bc755@linux.ibm.com>
Content-Language: en-US
From: "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <abd79f44-aed2-4e01-a7f8-7d806f5bc755@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/21/24 4:03 PM, Jan Karcher wrote:
>
>
> On 21/08/2024 04:36, D. Wythe wrote:
>> From: "D. Wythe" <alibuda@linux.alibaba.com>
>>
>> In commit 48b6190a0042 ("net/smc: Limit SMC visits when handshake 
>> workqueue congested"),
>> we introduce a mechanism to put constraint on SMC connections visit
>> according to the pressure of SMC handshake process.
>>
>> At that time, we believed that controlling the feature through netlink
>> was sufficient. However, most people have realized now that netlink is
>> not convenient in container scenarios, and sysctl is a more suitable
>> approach.
>
> Hi D.
>
> thanks for your contribution.
> What i wonder is should we prefer the use of netlink > sysctl or not?
> To the upstream maintainers: Is there a prefernce for the net tree?
>
> My impression from past discussions is that netlink should be chosen 
> over sysctl.
> If so, why is it inconvenient to use netlink in containers?
> Can this be changed?
>
> Other then the general discussion the changhes look good to me.
>
> Reviewed-by: Jan Karcher <jaka@linux.ibm.com>
>

Hi Jan,

I noticed that there have been relevant discussions before, perhaps this 
will be helpful to you.

Link: https://lore.kernel.org/netdev/20220224020253.GF5443@linux.alibaba.com


Best wishes,
D. Wythe


>
>>
>> In addition, since commit 462791bbfa35 ("net/smc: add sysctl 
>> interface for SMC")
>> had introcuded smc_sysctl_net_init(), it is reasonable for us to
>> initialize limit_smc_hs in it instead of initializing it in
>> smc_pnet_net_int().
>>
>> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
>> ---
>> v1 -> v2:
>>
>> Modified the description in the commit and removed the incorrect
>> spelling.
>>
>>   net/smc/smc_pnet.c   |  3 ---
>>   net/smc/smc_sysctl.c | 11 +++++++++++
>>   2 files changed, 11 insertions(+), 3 deletions(-)
>>
>> diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
>> index 2adb92b..1dd3623 100644
>> --- a/net/smc/smc_pnet.c
>> +++ b/net/smc/smc_pnet.c
>> @@ -887,9 +887,6 @@ int smc_pnet_net_init(struct net *net)
>>         smc_pnet_create_pnetids_list(net);
>>   -    /* disable handshake limitation by default */
>> -    net->smc.limit_smc_hs = 0;
>> -
>>       return 0;
>>   }
>>   diff --git a/net/smc/smc_sysctl.c b/net/smc/smc_sysctl.c
>> index 13f2bc0..2fab645 100644
>> --- a/net/smc/smc_sysctl.c
>> +++ b/net/smc/smc_sysctl.c
>> @@ -90,6 +90,15 @@
>>           .extra1        = &conns_per_lgr_min,
>>           .extra2        = &conns_per_lgr_max,
>>       },
>> +    {
>> +        .procname    = "limit_smc_hs",
>> +        .data        = &init_net.smc.limit_smc_hs,
>> +        .maxlen        = sizeof(int),
>> +        .mode        = 0644,
>> +        .proc_handler    = proc_dointvec_minmax,
>> +        .extra1        = SYSCTL_ZERO,
>> +        .extra2        = SYSCTL_ONE,
>> +    },
>>   };
>>     int __net_init smc_sysctl_net_init(struct net *net)
>> @@ -121,6 +130,8 @@ int __net_init smc_sysctl_net_init(struct net *net)
>>       WRITE_ONCE(net->smc.sysctl_rmem, net_smc_rmem_init);
>>       net->smc.sysctl_max_links_per_lgr = SMC_LINKS_PER_LGR_MAX_PREFER;
>>       net->smc.sysctl_max_conns_per_lgr = SMC_CONN_PER_LGR_PREFER;
>> +    /* disable handshake limitation by default */
>> +    net->smc.limit_smc_hs = 0;
>>         return 0;


