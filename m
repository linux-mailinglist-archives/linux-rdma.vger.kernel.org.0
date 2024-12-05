Return-Path: <linux-rdma+bounces-6273-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB329E54E3
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Dec 2024 13:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A005C166148
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Dec 2024 12:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D4F21770A;
	Thu,  5 Dec 2024 12:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="JbHJ55t9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37635217677;
	Thu,  5 Dec 2024 12:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733400168; cv=none; b=fx8SC5CANkLVqmmkJXCA+J3UU0mKB4owohH+SpTExrBN1XrB142gp2U++Lp03kllTMxjuZAKSWOZZ8WVUScO8GDbAZ76i+lzW9EcJfO0PEefH/ZRMkrMcFLybi4Bpml7tMWK3rRiEPrbbZl4rCAe9JPXayIGwuNw2eJ0pIsjcZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733400168; c=relaxed/simple;
	bh=u77Vv3jDD6O3Mdctw1zm04s6sTUEqR+uEJ4fb3IrtsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J71B4A2F6iqldE2xTvzTv/Iq8Hdq85ic0F0tSgx2MgSl0W40GH8cDBxvJmF8F5vzxxM8jLFDCBysehwZb5Z6j6Bb/aqkc2Yw9S2/kl+AdcgrhRqf8L84icpOqNFwVTYZHjv4yt+dV1RX0DQkGYKVgdwPOFgxnmC0RP7CcyqCTuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=JbHJ55t9; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733400162; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=nxoEgdhRHGmWj3cebeyEiaDTUJHx/zizItatstHS8Uw=;
	b=JbHJ55t9RH5BLmvGoX5By4KPnEgC7F1bvMqIvsVqPO4qvSGIZV7snc/4fVSLQ0o2+0xqrzDGYDC4/DxpJP4tpLOIY6pinVlcJi7aPIUFpLh/VF3Mny4uWeES2XUWKLY80bKWC1z6sp3+MinHc5mnnVRNndeYDS/gNFptQXmK/RY=
Received: from 30.221.98.81(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0WKtI0FI_1733400160 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 05 Dec 2024 20:02:42 +0800
Message-ID: <6711d96c-6c8c-4b9d-be07-759bfdab7875@linux.alibaba.com>
Date: Thu, 5 Dec 2024 20:02:39 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] net/smc: support ipv4 mapped ipv6 addr
 client for smc-r v2
To: Wenjia Zhang <wenjia@linux.ibm.com>, jaka@linux.ibm.com,
 alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 guwen@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Cc: linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dust Li <dust.li@linux.alibaba.com>
References: <20241202125203.48821-1-guangguan.wang@linux.alibaba.com>
 <20241202125203.48821-3-guangguan.wang@linux.alibaba.com>
 <894d640f-d9f6-4851-adb8-779ff3678440@linux.ibm.com>
Content-Language: en-US
From: Guangguan Wang <guangguan.wang@linux.alibaba.com>
In-Reply-To: <894d640f-d9f6-4851-adb8-779ff3678440@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024/12/5 18:16, Wenjia Zhang wrote:
> 
> 
> On 02.12.24 13:52, Guangguan Wang wrote:
>> AF_INET6 is not supported for smc-r v2 client before, event if the
> %s/event/even/g
> 

I will fix it in the next version.

>> ipv6 addr is ipv4 mapped. Thus, when using AF_INET6, smc-r connection
>> will fallback to tcp, especially for java applications running smc-r.
>> This patch support ipv4 mapped ipv6 addr client for smc-r v2. Clients
>> using real global ipv6 addr is still not supported yet.
>>
>> Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
>> Reviewed-by: Wen Gu <guwen@linux.alibaba.com>
>> Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
>> Reviewed-by: D. Wythe <alibuda@linux.alibaba.com>
>> ---
>>   net/smc/af_smc.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
>> index 9d76e902fd77..5b13dd759766 100644
>> --- a/net/smc/af_smc.c
>> +++ b/net/smc/af_smc.c
>> @@ -1116,7 +1116,12 @@ static int smc_find_proposal_devices(struct smc_sock *smc,
>>       ini->check_smcrv2 = true;
>>       ini->smcrv2.saddr = smc->clcsock->sk->sk_rcv_saddr;
>>       if (!(ini->smcr_version & SMC_V2) ||
>> +#if IS_ENABLED(CONFIG_IPV6)
>> +        (smc->clcsock->sk->sk_family != AF_INET &&
>> +         !ipv6_addr_v4mapped(&smc->clcsock->sk->sk_v6_rcv_saddr)) ||
> I think here you want to say !(smc->clcsock->sk->sk_family == AF_INET && ipv6_addr_v4mapped(&smc->clcsock->sk->sk_v6_rcv_saddr)), right? If it is, the negativ form of the logical operation (a&&b) is (!a)||(!b), i.e. here should be:
> （smc->clcsock->sk->sk_family != AF_INET）|| （!ipv6_addr_v4mapped(&smc->clcsock->sk->sk_v6_rcv_saddr)）
> 

(smc->clcsock->sk->sk_family != AF_INET && !ipv6_addr_v4mapped(&smc->clcsock->sk->sk_v6_rcv_saddr)) not equls to !(smc->clcsock->sk->sk_family == AF_INET && ipv6_addr_v4mapped(&smc->clcsock->sk->sk_v6_rcv_saddr))

Following your logic, here also can be: 
!(smc->clcsock->sk->sk_family == AF_INET || ipv6_addr_v4mapped(&smc->clcsock->sk->sk_v6_rcv_saddr))

I think both is acceptable. But in order to keep consistent with the code when IPV6 is not enabled, I prefer (smc->clcsock->sk->sk_family != AF_INET && !ipv6_addr_v4mapped(&smc->clcsock->sk->sk_v6_rcv_saddr)).

>> +#else
>>           smc->clcsock->sk->sk_family != AF_INET ||
>> +#endif
>>           !smc_clc_ueid_count() ||
>>           smc_find_rdma_device(smc, ini))
>>           ini->smcr_version &= ~SMC_V2;

