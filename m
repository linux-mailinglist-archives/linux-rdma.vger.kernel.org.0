Return-Path: <linux-rdma+bounces-4382-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79619953F3F
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Aug 2024 04:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB13C1C21DB9
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Aug 2024 02:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C462BD04;
	Fri, 16 Aug 2024 02:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="nwjEBr4e"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0D844366;
	Fri, 16 Aug 2024 02:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723773985; cv=none; b=nKAzOWujmKxv3cc/ujuqNbEu1at396IPPLZC69NFWkoFEmgcfij3kRQtVKumr3oTCbYYyU9EYk4b2OeZTH95GM3aM8Sf0g04khw9AaDOzKhXLI5IXwZtXSEgb4RtVYVdauSq3grSddzX+1lvoztlX1kbVN3s2uW1SFRGZVxgzmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723773985; c=relaxed/simple;
	bh=47+fk56Tyj0GO2N5YHYnzl40/6J2rlo+UehdDXrrluM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O7GgLrxCiBbbp64Av/qYyJMPLDVKOF52Lh2yahXGutzdBzv4wIhNmIHdMv2o500NwyPHtpo1owMvPM08F+h1BUnxAArMXHMUgaIR29tAChYy/y3IjuVknhvWpuDV5ax5ySwNtQugVj9BjzRZWiqlPzr8Cjyxcuak+9yMsPvuZho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=nwjEBr4e; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723773974; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=JpK1Qzyay7Udu8ko5NS0kM+1qIGbwme3O6OhStcAsw0=;
	b=nwjEBr4eyQGX5STUZ7kWeOX7rK3PXPjdl39TZ1QgeuV5MQ1knZEdGpVKiEdf3L/Vyey4A/LMEiCrjeQJJib4FEHshyb2TFhbv1+7IdtVlpf4NxHCZg7LwLJxDTDQeuFbfTGyQDU6Z+vbFralgVEc8YWKNoi09PJuzQ2JurRIe4g=
Received: from 30.221.149.18(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WCyRxl9_1723773972)
          by smtp.aliyun-inc.com;
          Fri, 16 Aug 2024 10:06:13 +0800
Message-ID: <d21add89-7298-4574-9873-44c8e9dd8075@linux.alibaba.com>
Date: Fri, 16 Aug 2024 10:06:12 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/smc: add sysctl for smc_limit_hs
To: Wen Gu <guwen@linux.alibaba.com>, kgraul@linux.ibm.com,
 wenjia@linux.ibm.com, jaka@linux.ibm.com, wintera@linux.ibm.com
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
 tonylu@linux.alibaba.com, pabeni@redhat.com, edumazet@google.com
References: <1723726988-78651-1-git-send-email-alibuda@linux.alibaba.com>
 <67a37386-6d88-43b4-8cd4-fdbe263addb7@linux.alibaba.com>
Content-Language: en-US
From: "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <67a37386-6d88-43b4-8cd4-fdbe263addb7@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/15/24 9:14 PM, Wen Gu wrote:
>
>
> On 2024/8/15 21:03, D. Wythe wrote:
>> From: "D. Wythe" <alibuda@linux.alibaba.com>
>>
>> In commit 48b6190a0042 ("net/smc: Limit SMC visits when handshake 
>> workqueue congested"),
>> we introduce a mechanism to put constraint on SMC connections visit 
>> according to
>> the pressure of SMC handshake process.
>>
>> At that time, we believed that controlling the feature through 
>> netlink was sufficient,
>> However, most people have realized now that netlink is not convenient in
>> container scenarios, and sysctl is a more suitable approach.
>>
>> In addition, it is not reasonable for us to initialize limit_smc_hs in
>> smc_pnet_net_init, we made a mistable before. It should be initialized
>
> nit: mistable -> mistake?

Take it. Also, I suddenly realized that the reason for initializing 
limit_smc_hs in smc_pnet_net_init before
was because there was no smc_sysctl_net_init at that time ...

D. Wythe

>
>> in smc_sysctl_net_init(), just like other systcl.
>>
>> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
>> ---
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


