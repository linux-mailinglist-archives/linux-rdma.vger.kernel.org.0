Return-Path: <linux-rdma+bounces-6326-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A959E8B55
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Dec 2024 07:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C07A41885B91
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Dec 2024 06:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B2E2147FF;
	Mon,  9 Dec 2024 06:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ZlJdK2X5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0932144A9;
	Mon,  9 Dec 2024 06:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733724296; cv=none; b=gcfB7JxXJUrkR2rVZvNPFosKqUlEpZwhMLDXgCh0TEME56e/y4Xt4IBtL054Yb0N1YtcWyw89Qj902/hG5qXp2osmqRG0DTnsm7R1J2M3BXNWdr4bWrahz+5fRVZSqxGK8iWe0VWAOBskqNYyW2rYDx3Fshd+tfNipxagdBNNlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733724296; c=relaxed/simple;
	bh=bhTklaj/2PsO5Nv8UhiyX2qItpwg7Uti9kyTx3adxzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p4mMF9mYqbOA0T0jgXmiGUYMeKIepIrlnA6accTlvGibWhIgVKDc2g+7aTZIO80gL0xaxdPcvXNDCXxN80FrHejNwpvEDjW9gklFAhLD6pijBnAVmVvqJB3TrrzbCROkhbMyCb7lFLm8QKO3UOFap5pqtN5tY+L8ktv9rm4zqpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ZlJdK2X5; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733724284; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=s/c5AztEBJjv/BTvhC/ba+rQgienYOYyHkd/8hjQ3RM=;
	b=ZlJdK2X5o9qXUKtk97iWhcq2H2PtlgZ1XNW/llV/mg4PROSba0ELJAup/Xemwzt2xPmZBhKdWk9wuYXIkQkbobDaAiN1hCGdl2dZhSRNQRbM0OaIvJfFe+bBog4Wj34YPS1zTNkA45Bvp7JvjIDJOuYTKpreDzVax/Ys26fDyt8=
Received: from 30.221.100.140(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0WL36AV9_1733724281 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 09 Dec 2024 14:04:43 +0800
Message-ID: <d2af79e2-adb2-46f0-a7e3-67a9265f3adf@linux.alibaba.com>
Date: Mon, 9 Dec 2024 14:04:40 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] net/smc: support ipv4 mapped ipv6 addr
 client for smc-r v2
To: Wenjia Zhang <wenjia@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>
Cc: jaka@linux.ibm.com, alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 guwen@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dust Li <dust.li@linux.alibaba.com>
References: <20241202125203.48821-1-guangguan.wang@linux.alibaba.com>
 <20241202125203.48821-3-guangguan.wang@linux.alibaba.com>
 <894d640f-d9f6-4851-adb8-779ff3678440@linux.ibm.com>
 <20241205135833.0beafd61.pasic@linux.ibm.com>
 <5ac2c5a7-3f12-48e5-83a9-ecd3867e6125@linux.alibaba.com>
 <7de81edd-86f2-4cfd-95db-e273c3436eb6@linux.ibm.com>
 <3710a042-cabe-4b6d-9caa-fd4d864b2fdc@linux.ibm.com>
Content-Language: en-US
From: Guangguan Wang <guangguan.wang@linux.alibaba.com>
In-Reply-To: <3710a042-cabe-4b6d-9caa-fd4d864b2fdc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024/12/7 03:49, Wenjia Zhang wrote:
> 
> 
> On 06.12.24 11:51, Wenjia Zhang wrote:
>>
>>
>> On 06.12.24 07:06, Guangguan Wang wrote:
>>>
>>>
>>> On 2024/12/5 20:58, Halil Pasic wrote:
>>>> On Thu, 5 Dec 2024 11:16:27 +0100
>>>> Wenjia Zhang <wenjia@linux.ibm.com> wrote:
>>>>
>>>>>> --- a/net/smc/af_smc.c
>>>>>> +++ b/net/smc/af_smc.c
>>>>>> @@ -1116,7 +1116,12 @@ static int smc_find_proposal_devices(struct
>>>>>> smc_sock *smc, ini->check_smcrv2 = true;
>>>>>>        ini->smcrv2.saddr = smc->clcsock->sk->sk_rcv_saddr;
>>>>>>        if (!(ini->smcr_version & SMC_V2) ||
>>>>>> +#if IS_ENABLED(CONFIG_IPV6)
>>>>>> +        (smc->clcsock->sk->sk_family != AF_INET &&
>>>>>> +
>>>>>> !ipv6_addr_v4mapped(&smc->clcsock->sk->sk_v6_rcv_saddr)) ||
>>>>> I think here you want to say !(smc->clcsock->sk->sk_family == AF_INET
>>>>> && ipv6_addr_v4mapped(&smc->clcsock->sk->sk_v6_rcv_saddr)), right? If
>>>>> it is, the negativ form of the logical operation (a&&b) is (!a)||(!b),
>>>>> i.e. here should be:
>>>>> （smc->clcsock->sk->sk_family != AF_INET）||
>>>>> （!ipv6_addr_v4mapped(&smc->clcsock->sk->sk_v6_rcv_saddr)）
>>>>
>>>> Wenjia, I think you happen to confuse something here. The condition
>>>> of this if statement is supposed to evaluate as true iff we don't want
>>>> to propose SMCRv2 because the situation is such that SMCRv2 is not
>>>> supported.
>>>>
>>>> We have a bunch of conditions we need to meet for SMCRv2 so
>>>> logically we have (A && B && C && D). Now since the if is
>>>> about when SMCRv2 is not supported we have a super structure
>>>> that looks like !A || !B || !C || !D. With this patch, if
>>>> CONFIG_IPV6 is not enabled, the sub-condition remains the same:
>>>> if smc->clcsock->sk->sk_family is something else that AF_INET
>>>> the we do not do SMCRv2!
>>>>
>>>> But when we do have CONFIG_IPV6 then we want to do SMCRv2 for
>>>> AF_INET6 sockets too if the addresses used are actually
>>>> v4 mapped addresses.
>>>>
>>>> Now this is where the cognitive dissonance starts on my end. I
>>>> think the author assumes sk_family == AF_INET || sk_family == AF_INET6
>>>> is a tautology in this context. That may be a reasonable thing to
>>>> assume. Under that assumption
>>>> sk_family != AF_INET &&    !ipv6_addr_v4mapped(addr) (shortened for
>>>> convenience)
>>>> becomes equivalent to
>>>> sk_family == AF_INET6 && !ipv6_addr_v4mapped(addr)
>>>> which means in words if the socket is an IPv6 sockeet and the addr is not
>>>> a v4 mapped v6 address then we *can not* do SMCRv2. And the condition
>>>> when we can is sk_family != AF_INET6 || ipv6_addr_v4mapped(addr) which
>>>> is equivalen to sk_family == AF_INET || ipv6_addr_v4mapped(addr) under
>>>> the aforementioned assumption.
>>>
>>> Hi, Halil
>>>
>>> Thank you for such a detailed derivation.
>>>
>>> Yes, here assume that sk_family == AF_INET || sk_family == AF_INET6. Indeed,
>>> many codes in SMC have already made this assumption, for example,
>>> static int __smc_create(struct net *net, struct socket *sock, int protocol,
>>>             int kern, struct socket *clcsock)
>>> {
>>>     int family = (protocol == SMCPROTO_SMC6) ? PF_INET6 : PF_INET;
>>>     ...
>>> }
>>> And I also believe it is reasonable.
>>>
>>> Before this patch, for SMCR client, only an IPV4 socket can do SMCRv2. This patch
>>> introduce an IPV6 socket with v4 mapped v6 address for SMCRv2. It is equivalen
>>> to sk_family == AF_INET || ipv6_addr_v4mapped(addr) as you described.
>>>
>>>>
>>>> But if we assume sk_family == AF_INET || sk_family == AF_INET6 then
>>>> the #else does not make any sense, because I guess with IPv6 not
>>>> available AF_INET6 is not available ant thus the else is always
>>>> guaranteed to evaluate to false under the assumption made.
>>>>
>>> You are right. The #else here does not make any sense. It's my mistake.
>>>
>>> The condition is easier to understand and read should be like this:
>>>       if (!(ini->smcr_version & SMC_V2) ||
>>> +#if IS_ENABLED(CONFIG_IPV6)
>>> +        (smc->clcsock->sk->sk_family == AF_INET6 &&
>>> +         !ipv6_addr_v4mapped(&smc->clcsock->sk->sk_v6_rcv_saddr)) ||
>>> +#endif
>>>           !smc_clc_ueid_count() ||
>>>           smc_find_rdma_device(smc, ini))
>>>           ini->smcr_version &= ~SMC_V2;
>>>
>>
>> sorry, I still don't agree on this version. You removed the condition
>> "
>> smc->clcsock->sk->sk_family != AF_INET ||
>> "
>> completely. What about the socket with neither AF_INET nor AF_INET6 family?
>>
>> Thanks,
>> Wenjia
>>
> I think the main problem in the original version was that
> (sk_family != AF_INET) is not equivalent to (sk_family == AF_INET6).
> Since you already in the new version above used sk_family == AF_INET6,
> the else condition could stay as it is. My suggestion:
> 
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index 8e3093938cd2..5f205a41fc48 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -1116,7 +1116,12 @@ static int smc_find_proposal_devices(struct smc_sock *smc,
>         ini->check_smcrv2 = true;
>         ini->smcrv2.saddr = smc->clcsock->sk->sk_rcv_saddr;
>         if (!(ini->smcr_version & SMC_V2) ||
> +#if IS_ENABLED(CONFIG_IPV6)
> +           (smc->clcsock->sk->sk_family == AF_INET6 &&
> +            !ipv6_addr_v4mapped(&smc->clcsock->sk->sk_v6_rcv_saddr)) ||
> +#else
>             smc->clcsock->sk->sk_family != AF_INET ||
> +#endif
>             !smc_clc_ueid_count() ||
>             smc_find_rdma_device(smc, ini))
>                 ini->smcr_version &= ~SMC_V2;
> 
> Thanks,
> Wenjia

The RFC7609 have confined SMC to socket applications using stream (i.e., TCP) sockets over IPv4 or IPv6.
https://datatracker.ietf.org/doc/html/rfc7609#page-26:~:text=It%20is%20confined%20to%20socket%20applications%20using%20stream%0A%20%20%20(i.e.%2C%20TCP)%20sockets%20over%20IPv4%20or%20IPv6

Both in the smc-tools and in smc kernel module, we can see codes that the sk_family is either AF_INET or AF_INET6.
The codes here:
https://raw.githubusercontent.com/ibm-s390-linux/smc-tools/refs/heads/main/smc-preload.c#:~:text=if%20((domain%20%3D%3D%20AF_INET%20%7C%7C%20domain%20%3D%3D%20AF_INET6)%20%26%26
and
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/net/smc/af_smc.c#:~:text=(sk%2D%3Esk_family%20!%3D%20AF_INET%20%26%26%20sk%2D%3Esk_family%20!%3D%20AF_INET6))
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/net/smc/af_smc.c#:~:text=int%20family%20%3D%20(protocol%20%3D%3D%20SMCPROTO_SMC6)%20%3F%20PF_INET6%20%3A%20PF_INET%3B 
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/net/smc/af_smc.c#:~:text=%2D%3Esin_family%20!%3D-,AF_INET,-%26%26%0A%09%20%20%20%20addr%2D%3E
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/net/smc/af_smc.c#:~:text=%2D%3Esa_family%20!%3D-,AF_INET6,-)%0A%09%09goto%20out_err
...

I wonder if SMC-R can support other address famliy rather than AF_INET AF_INET6 in design？
And IBM has any plan to support other address family in future?  Wenjia, can you help explain
this?

If the answer is positive, the code should be like this:
        if (!(ini->smcr_version & SMC_V2) ||
+#if IS_ENABLED(CONFIG_IPV6)
+           !(smc->clcsock->sk->sk_family == AF_INET || (smc->clcsock->sk->sk_family == AF_INET6 &&
+            ipv6_addr_v4mapped(&smc->clcsock->sk->sk_v6_rcv_saddr))) ||
+#else
             smc->clcsock->sk->sk_family != AF_INET ||
+#endif
             !smc_clc_ueid_count() ||
             smc_find_rdma_device(smc, ini))
                 ini->smcr_version &= ~SMC_V2;

Otherwise, the code below is reasonable.
      if (!(ini->smcr_version & SMC_V2) ||
+#if IS_ENABLED(CONFIG_IPV6)
+        (smc->clcsock->sk->sk_family == AF_INET6 &&
+         !ipv6_addr_v4mapped(&smc->clcsock->sk->sk_v6_rcv_saddr)) ||
+#endif
          !smc_clc_ueid_count() ||
          smc_find_rdma_device(smc, ini))
          ini->smcr_version &= ~SMC_V2;

Thanks,
Guangguan Wang

