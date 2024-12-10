Return-Path: <linux-rdma+bounces-6381-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDAAE9EAED7
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Dec 2024 11:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A573E188A694
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Dec 2024 10:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8ED2080E9;
	Tue, 10 Dec 2024 10:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="n/dhuxDm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10472080E5;
	Tue, 10 Dec 2024 10:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733828258; cv=none; b=KwHxzvA3fJHr0rXB/mkRQlo2EisRh/u8lAg41CO8mJl+ehJIIFaGBbGHCfVIMn1Wa40CxbVZ19m+Jbqyqcqg6kMP8BoJwiqQ0768eLlIOVjbaJkdL55yFFIxaqFePtzoHiTBmk0n+HqMTN2hLVHnNcRtF0ySdE9+5SimN+WBIRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733828258; c=relaxed/simple;
	bh=j1MmgnUHnOiy0oh0HNDkid08LWfd7ytR58QtPYP7wwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M84nkRjmqJ3kXBRMYV3jjRpy7Fa4K8wpdrgBWOKs+12IMzeOYHadzZ3aRxp95w4Bj54397eJCpo3X1iYw2W7kDGkSpUTxucwSne0IJmxHcf/zRx/qKfhkzG+znv8Hrc2cBFTPKhmC584wOXLXvYZZWdBqHDi80O/bk+Q6ptRMuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=n/dhuxDm; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733828252; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=za3DqWLC997CzA35yUW0weA03pexBgrTU4NPXoJrrBU=;
	b=n/dhuxDmrndTO6007L4nIXf9fOB7b5oZPXelZCnnP/ucIW0mxlyIa+KQFFhT44OvltvZhKdEYXvcXR1ZpweuM2wnvWzYPcRJW0yzIIzoT53+Zc86G51AgnRLOAEd05RHRovwm5WNsPfpkMOeuQTxT9orWAK1D2Yk+DLF3VFdQGM=
Received: from 30.221.101.48(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0WLEr7oq_1733828250 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 10 Dec 2024 18:57:31 +0800
Message-ID: <f9609fe8-f8c2-4280-acc2-515485adfc1f@linux.alibaba.com>
Date: Tue, 10 Dec 2024 18:57:28 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/2] net/smc: support ipv4 mapped ipv6 addr
 client for smc-r v2
To: Wenjia Zhang <wenjia@linux.ibm.com>, pasic@linux.ibm.com,
 jaka@linux.ibm.com, alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 guwen@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Cc: linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dust Li <dust.li@linux.alibaba.com>
References: <20241209130649.34591-1-guangguan.wang@linux.alibaba.com>
 <20241209130649.34591-3-guangguan.wang@linux.alibaba.com>
 <1fc33d2e-83c1-4651-b761-27188d22fba0@linux.ibm.com>
Content-Language: en-US
From: Guangguan Wang <guangguan.wang@linux.alibaba.com>
In-Reply-To: <1fc33d2e-83c1-4651-b761-27188d22fba0@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024/12/9 22:10, Wenjia Zhang wrote:
> 
> 
> On 09.12.24 14:06, Guangguan Wang wrote:
>> AF_INET6 is not supported for smc-r v2 client before, even if the
>> ipv6 addr is ipv4 mapped. Thus, when using AF_INET6, smc-r connection
>> will fallback to tcp, especially for java applications running smc-r.
>> This patch support ipv4 mapped ipv6 addr client for smc-r v2. Clients
>> using real global ipv6 addr is still not supported yet.
>>
>> Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
>> Reviewed-by: Wen Gu <guwen@linux.alibaba.com>
>> Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
>> Reviewed-by: D. Wythe <alibuda@linux.alibaba.com>
>> Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
>> ---
>>   net/smc/af_smc.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
>> index 9d76e902fd77..c3f9c0457418 100644
>> --- a/net/smc/af_smc.c
>> +++ b/net/smc/af_smc.c
>> @@ -1116,7 +1116,10 @@ static int smc_find_proposal_devices(struct smc_sock *smc,
>>       ini->check_smcrv2 = true;
>>       ini->smcrv2.saddr = smc->clcsock->sk->sk_rcv_saddr;
>>       if (!(ini->smcr_version & SMC_V2) ||
>> -        smc->clcsock->sk->sk_family != AF_INET ||
>> +#if IS_ENABLED(CONFIG_IPV6)
>> +        (smc->clcsock->sk->sk_family == AF_INET6 &&
>> +         !ipv6_addr_v4mapped(&smc->clcsock->sk->sk_v6_rcv_saddr)) ||
>> +#endif
>>           !smc_clc_ueid_count() ||
>>           smc_find_rdma_device(smc, ini))
>>           ini->smcr_version &= ~SMC_V2;
> 
> @Guangguan, I think Halil's point is valid, and we need to verify if checking on saddr is sufficient before this patch is applied. i.e. what about one peer with ipv4 mapped ipv6 communicates with another peer with a real ipv6 address? Is it possible? If yes, would SMCRv2 be used? I still haven't thought much on this yet, but it is worth to verify. Maybe you already have the answer?

Hi, Wenjia

I have replied the answer to the thread of v2 patch(https://lore.kernel.org/netdev/58075d86-b43a-4d58-bf64-c29418f99143@linux.alibaba.com/)

If there are still any doubts or any other points to clarification, please let me know.

Thanks,
Guangguan Wang

> 
> @Jakub, could you please give us some more time to verify the issue mentioned above?
> 
> Thanks,
> Wenjia

