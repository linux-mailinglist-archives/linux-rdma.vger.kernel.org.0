Return-Path: <linux-rdma+bounces-6327-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0289E8DCC
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Dec 2024 09:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CC631885BA7
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Dec 2024 08:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124082156F2;
	Mon,  9 Dec 2024 08:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dVwGlvj9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EA81EB3D;
	Mon,  9 Dec 2024 08:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733734178; cv=none; b=V31aKk22XjY5JzWKr456DeasaiCdHr4xf+uPu1DFDqoDBnYz3ioPKqvU4Miioc3h5daW/5twefoaWVEav2Jg9VfVRRyacMkVKfWgKF81Kt8T/tVV+wqXgl5rPSqwbFpm1GM852OpmnfG3bBb+i+Aayzn6xnx43gwW2ZlRlUJ4eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733734178; c=relaxed/simple;
	bh=KqmmiHRzzCW9f9F1wBcSg9bSN//lK87HVwO6fgaV+VM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UriJ74Chx35LeTLc8S2gSoYSdGdmj2nHojorY/0YKKC/jnmMIj6UAgK3/ovDtCf0MYDaLtG3KE+betiLx0VMcVrXRvtdHX46+oXBHeSegdvIKk0ghysbMsyehtDpJHRIYQLmM4NxEII2mqa/KyKQkbUf6IAN6VHhL8do0JWyoRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dVwGlvj9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B91IcBA008130;
	Mon, 9 Dec 2024 08:49:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=nsxT7k
	FG1dNb4AuOe8IKQe26ff3ooqWifZqh4heUycU=; b=dVwGlvj91CgWkK4T7sgQXU
	373S3u3R15Y5s5FzbCdd4biXUsk4O3NmkugjrthQ0b2WZg065qA5XUboA6AH5VPy
	5LIgJiw65t+GiCOMsgrYiJGy9GEdp+0t+zuOv6nITQsxWOn73/J2lwvV3fq/ladz
	MLnJKze85yAKGt8wwjdBsXbkP0hSLmyb5GxUdYOOaBl6NeRGQ1hhdzAgHY1+xM4p
	vtIwo9MAIGfB0Ftig8v7Ds0xTjoapMJ9oyK9cQUUjasY+vOjkCGjvCrs+K7meMDh
	f/xhLJuR6XSt570+o87OilUvodE67inSjne4LPdM9d6Rc+MXtV97nOLMlEQQlulA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43cbspyq2x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 08:49:30 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4B98i6jH017009;
	Mon, 9 Dec 2024 08:49:30 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43cbspyq2u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 08:49:30 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B96UqAq018636;
	Mon, 9 Dec 2024 08:49:29 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43d26k5ph9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 08:49:29 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B98nSAK15008426
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Dec 2024 08:49:28 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3597D58045;
	Mon,  9 Dec 2024 08:49:28 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 94FAF58054;
	Mon,  9 Dec 2024 08:49:24 +0000 (GMT)
Received: from [9.171.32.56] (unknown [9.171.32.56])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Dec 2024 08:49:24 +0000 (GMT)
Message-ID: <868f5d66-ac74-4b0a-a0d0-e44fdea3bb73@linux.ibm.com>
Date: Mon, 9 Dec 2024 09:49:23 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] net/smc: support ipv4 mapped ipv6 addr
 client for smc-r v2
To: Guangguan Wang <guangguan.wang@linux.alibaba.com>,
        Halil Pasic <pasic@linux.ibm.com>
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
 <d2af79e2-adb2-46f0-a7e3-67a9265f3adf@linux.alibaba.com>
Content-Language: en-US
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <d2af79e2-adb2-46f0-a7e3-67a9265f3adf@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: H3iMzudqsBb7qFxZZNFQQe2rE7UpxLdw
X-Proofpoint-GUID: kdfBxpjzT5ghn-1h32iaS1kp_nW-Sz8Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0
 suspectscore=0 spamscore=0 mlxscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090065



On 09.12.24 07:04, Guangguan Wang wrote:
> 
> 
> On 2024/12/7 03:49, Wenjia Zhang wrote:
>>
>>
>> On 06.12.24 11:51, Wenjia Zhang wrote:
>>>
>>>
>>> On 06.12.24 07:06, Guangguan Wang wrote:
>>>>
>>>>
>>>> On 2024/12/5 20:58, Halil Pasic wrote:
>>>>> On Thu, 5 Dec 2024 11:16:27 +0100
>>>>> Wenjia Zhang <wenjia@linux.ibm.com> wrote:
>>>>>
>>>>>>> --- a/net/smc/af_smc.c
>>>>>>> +++ b/net/smc/af_smc.c
>>>>>>> @@ -1116,7 +1116,12 @@ static int smc_find_proposal_devices(struct
>>>>>>> smc_sock *smc, ini->check_smcrv2 = true;
>>>>>>>         ini->smcrv2.saddr = smc->clcsock->sk->sk_rcv_saddr;
>>>>>>>         if (!(ini->smcr_version & SMC_V2) ||
>>>>>>> +#if IS_ENABLED(CONFIG_IPV6)
>>>>>>> +        (smc->clcsock->sk->sk_family != AF_INET &&
>>>>>>> +
>>>>>>> !ipv6_addr_v4mapped(&smc->clcsock->sk->sk_v6_rcv_saddr)) ||
>>>>>> I think here you want to say !(smc->clcsock->sk->sk_family == AF_INET
>>>>>> && ipv6_addr_v4mapped(&smc->clcsock->sk->sk_v6_rcv_saddr)), right? If
>>>>>> it is, the negativ form of the logical operation (a&&b) is (!a)||(!b),
>>>>>> i.e. here should be:
>>>>>> （smc->clcsock->sk->sk_family != AF_INET）||
>>>>>> （!ipv6_addr_v4mapped(&smc->clcsock->sk->sk_v6_rcv_saddr)）
>>>>>
>>>>> Wenjia, I think you happen to confuse something here. The condition
>>>>> of this if statement is supposed to evaluate as true iff we don't want
>>>>> to propose SMCRv2 because the situation is such that SMCRv2 is not
>>>>> supported.
>>>>>
>>>>> We have a bunch of conditions we need to meet for SMCRv2 so
>>>>> logically we have (A && B && C && D). Now since the if is
>>>>> about when SMCRv2 is not supported we have a super structure
>>>>> that looks like !A || !B || !C || !D. With this patch, if
>>>>> CONFIG_IPV6 is not enabled, the sub-condition remains the same:
>>>>> if smc->clcsock->sk->sk_family is something else that AF_INET
>>>>> the we do not do SMCRv2!
>>>>>
>>>>> But when we do have CONFIG_IPV6 then we want to do SMCRv2 for
>>>>> AF_INET6 sockets too if the addresses used are actually
>>>>> v4 mapped addresses.
>>>>>
>>>>> Now this is where the cognitive dissonance starts on my end. I
>>>>> think the author assumes sk_family == AF_INET || sk_family == AF_INET6
>>>>> is a tautology in this context. That may be a reasonable thing to
>>>>> assume. Under that assumption
>>>>> sk_family != AF_INET &&    !ipv6_addr_v4mapped(addr) (shortened for
>>>>> convenience)
>>>>> becomes equivalent to
>>>>> sk_family == AF_INET6 && !ipv6_addr_v4mapped(addr)
>>>>> which means in words if the socket is an IPv6 sockeet and the addr is not
>>>>> a v4 mapped v6 address then we *can not* do SMCRv2. And the condition
>>>>> when we can is sk_family != AF_INET6 || ipv6_addr_v4mapped(addr) which
>>>>> is equivalen to sk_family == AF_INET || ipv6_addr_v4mapped(addr) under
>>>>> the aforementioned assumption.
>>>>
>>>> Hi, Halil
>>>>
>>>> Thank you for such a detailed derivation.
>>>>
>>>> Yes, here assume that sk_family == AF_INET || sk_family == AF_INET6. Indeed,
>>>> many codes in SMC have already made this assumption, for example,
>>>> static int __smc_create(struct net *net, struct socket *sock, int protocol,
>>>>              int kern, struct socket *clcsock)
>>>> {
>>>>      int family = (protocol == SMCPROTO_SMC6) ? PF_INET6 : PF_INET;
>>>>      ...
>>>> }
>>>> And I also believe it is reasonable.
>>>>
>>>> Before this patch, for SMCR client, only an IPV4 socket can do SMCRv2. This patch
>>>> introduce an IPV6 socket with v4 mapped v6 address for SMCRv2. It is equivalen
>>>> to sk_family == AF_INET || ipv6_addr_v4mapped(addr) as you described.
>>>>
>>>>>
>>>>> But if we assume sk_family == AF_INET || sk_family == AF_INET6 then
>>>>> the #else does not make any sense, because I guess with IPv6 not
>>>>> available AF_INET6 is not available ant thus the else is always
>>>>> guaranteed to evaluate to false under the assumption made.
>>>>>
>>>> You are right. The #else here does not make any sense. It's my mistake.
>>>>
>>>> The condition is easier to understand and read should be like this:
>>>>        if (!(ini->smcr_version & SMC_V2) ||
>>>> +#if IS_ENABLED(CONFIG_IPV6)
>>>> +        (smc->clcsock->sk->sk_family == AF_INET6 &&
>>>> +         !ipv6_addr_v4mapped(&smc->clcsock->sk->sk_v6_rcv_saddr)) ||
>>>> +#endif
>>>>            !smc_clc_ueid_count() ||
>>>>            smc_find_rdma_device(smc, ini))
>>>>            ini->smcr_version &= ~SMC_V2;
>>>>
>>>
>>> sorry, I still don't agree on this version. You removed the condition
>>> "
>>> smc->clcsock->sk->sk_family != AF_INET ||
>>> "
>>> completely. What about the socket with neither AF_INET nor AF_INET6 family?
>>>
>>> Thanks,
>>> Wenjia
>>>
>> I think the main problem in the original version was that
>> (sk_family != AF_INET) is not equivalent to (sk_family == AF_INET6).
>> Since you already in the new version above used sk_family == AF_INET6,
>> the else condition could stay as it is. My suggestion:
>>
>> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
>> index 8e3093938cd2..5f205a41fc48 100644
>> --- a/net/smc/af_smc.c
>> +++ b/net/smc/af_smc.c
>> @@ -1116,7 +1116,12 @@ static int smc_find_proposal_devices(struct smc_sock *smc,
>>          ini->check_smcrv2 = true;
>>          ini->smcrv2.saddr = smc->clcsock->sk->sk_rcv_saddr;
>>          if (!(ini->smcr_version & SMC_V2) ||
>> +#if IS_ENABLED(CONFIG_IPV6)
>> +           (smc->clcsock->sk->sk_family == AF_INET6 &&
>> +            !ipv6_addr_v4mapped(&smc->clcsock->sk->sk_v6_rcv_saddr)) ||
>> +#else
>>              smc->clcsock->sk->sk_family != AF_INET ||
>> +#endif
>>              !smc_clc_ueid_count() ||
>>              smc_find_rdma_device(smc, ini))
>>                  ini->smcr_version &= ~SMC_V2;
>>
>> Thanks,
>> Wenjia
> 
> The RFC7609 have confined SMC to socket applications using stream (i.e., TCP) sockets over IPv4 or IPv6.
> https://datatracker.ietf.org/doc/html/rfc7609#page-26:~:text=It%20is%20confined%20to%20socket%20applications%20using%20stream%0A%20%20%20(i.e.%2C%20TCP)%20sockets%20over%20IPv4%20or%20IPv6
> 
> Both in the smc-tools and in smc kernel module, we can see codes that the sk_family is either AF_INET or AF_INET6.
> The codes here:
> https://raw.githubusercontent.com/ibm-s390-linux/smc-tools/refs/heads/main/smc-preload.c#:~:text=if%20((domain%20%3D%3D%20AF_INET%20%7C%7C%20domain%20%3D%3D%20AF_INET6)%20%26%26
> and
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/net/smc/af_smc.c#:~:text=(sk%2D%3Esk_family%20!%3D%20AF_INET%20%26%26%20sk%2D%3Esk_family%20!%3D%20AF_INET6))
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/net/smc/af_smc.c#:~:text=int%20family%20%3D%20(protocol%20%3D%3D%20SMCPROTO_SMC6)%20%3F%20PF_INET6%20%3A%20PF_INET%3B
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/net/smc/af_smc.c#:~:text=%2D%3Esin_family%20!%3D-,AF_INET,-%26%26%0A%09%20%20%20%20addr%2D%3E
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/net/smc/af_smc.c#:~:text=%2D%3Esa_family%20!%3D-,AF_INET6,-)%0A%09%09goto%20out_err
> ...
> 
> I wonder if SMC-R can support other address famliy rather than AF_INET AF_INET6 in design？
> And IBM has any plan to support other address family in future?  Wenjia, can you help explain
> this?
> 
The answer is no, at least in the near future. As you might be already 
aware, it depends on the implementation on z/OS.

> If the answer is positive, the code should be like this:
>          if (!(ini->smcr_version & SMC_V2) ||
> +#if IS_ENABLED(CONFIG_IPV6)
> +           !(smc->clcsock->sk->sk_family == AF_INET || (smc->clcsock->sk->sk_family == AF_INET6 &&
> +            ipv6_addr_v4mapped(&smc->clcsock->sk->sk_v6_rcv_saddr))) ||
> +#else
>               smc->clcsock->sk->sk_family != AF_INET ||
> +#endif
>               !smc_clc_ueid_count() ||
>               smc_find_rdma_device(smc, ini))
>                   ini->smcr_version &= ~SMC_V2;
> 
> Otherwise, the code below is reasonable.
>        if (!(ini->smcr_version & SMC_V2) ||
> +#if IS_ENABLED(CONFIG_IPV6)
> +        (smc->clcsock->sk->sk_family == AF_INET6 &&
> +         !ipv6_addr_v4mapped(&smc->clcsock->sk->sk_v6_rcv_saddr)) ||
> +#endif
>            !smc_clc_ueid_count() ||
>            smc_find_rdma_device(smc, ini))
>            ini->smcr_version &= ~SMC_V2;
> 
Ok, I got your point, a socket with an address family other than AF_INET 
and AF_INET6 is already pre-filtered, so that such extra condition 
checking for the smc->clcsock->sk->sk_family != AF_INET is not 
necessary, right?

Would you like to send a new version? And feel free to use this in the 
new version:

Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>

Thanks,
Wenjia


