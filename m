Return-Path: <linux-rdma+bounces-6320-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C659E7945
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Dec 2024 20:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4262F1888149
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Dec 2024 19:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80281D5CC1;
	Fri,  6 Dec 2024 19:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RyduyTGj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4DF1C548B;
	Fri,  6 Dec 2024 19:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733514578; cv=none; b=KPehtqEf3p/MMWN9Q22TaLRSfQfcjV/YDEsIIwtMFgcY6kAYHme9yqez2xOafpmAKg3L8xERHepNoTeeDRSBn8GN4YE1ZLnJPeXMsKmdwa6DG3c7KI1X4R8G4UqcNbzWRCyVUOPfiRDYsiaJ1bJ3p4kHth9CaiDFhtjOl9Sj6Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733514578; c=relaxed/simple;
	bh=5kyEv2XzLe30oY3RVRSeRgah1pQyiiJWSvpMP2pqYwY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XR2JVndNz0Xvac2f2eWtBBJdzeN4bdFqNCH2iKfY9zPJJEsIlc32uKJsI2sRVdvktP9mgxs7q+KxdHR9CCo8CdjHAbriC7I6+HnyUV/+Tab8h9o/3izJVUvGB46oFPGbr8acfXHaQU0vkw8YMOqZ/+z2iHC6Ku8ZmcYyKs7wrOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RyduyTGj; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B69US88027778;
	Fri, 6 Dec 2024 19:49:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0foSai
	IAc2wM2z0WLUKCZiWxwHuAQ3XmtO4NM2jSHBs=; b=RyduyTGjoHVxgAAcqBOfe/
	tn4HPdoOvz4vH12uHxvCCRAZTw/tRjZuOy8m9LxeelR5N7fbGAldrT+ltWXpn+Ry
	M7dafut73xHp+GcLNU6ML7fWcz+0aq1E1t64KO2MDlDTufUpccETjI02buAlaEuf
	XZmzfPmXdMMz0d3lIM4pVBo5jXdhF7tC5XrMLG+CxZ/++pWOyL3s5kvGEzG5heEv
	l74cWYmG9nI/TbYou6aXyMrzEaEFv6f4bWWAIoVMU0CHmkpC6dARUJ5bw6mvRvUU
	3Dj69pfF8yhavN/Qd1Iff6mZlVLfNGrL74U+i3hNjxNjfehDiYLO5KjOPxSHVt2w
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43bxptjk27-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Dec 2024 19:49:29 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4B6JnSiX021895;
	Fri, 6 Dec 2024 19:49:28 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43bxptjk25-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Dec 2024 19:49:28 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B6H1pCl012745;
	Fri, 6 Dec 2024 19:49:28 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 438d1sr9ju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Dec 2024 19:49:28 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B6JnQGi32768738
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Dec 2024 19:49:26 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3E57B58056;
	Fri,  6 Dec 2024 19:49:26 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C7D0658052;
	Fri,  6 Dec 2024 19:49:23 +0000 (GMT)
Received: from [9.171.74.148] (unknown [9.171.74.148])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Dec 2024 19:49:23 +0000 (GMT)
Message-ID: <3710a042-cabe-4b6d-9caa-fd4d864b2fdc@linux.ibm.com>
Date: Fri, 6 Dec 2024 20:49:23 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] net/smc: support ipv4 mapped ipv6 addr
 client for smc-r v2
From: Wenjia Zhang <wenjia@linux.ibm.com>
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
Content-Language: en-US
In-Reply-To: <7de81edd-86f2-4cfd-95db-e273c3436eb6@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EZK63Qtj6BQdv0vF6uj6J-PaNbmnuf7v
X-Proofpoint-ORIG-GUID: gdPUPTOKqCqzo5vIYZRKoTH8yl1YdifA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412060146



On 06.12.24 11:51, Wenjia Zhang wrote:
> 
> 
> On 06.12.24 07:06, Guangguan Wang wrote:
>>
>>
>> On 2024/12/5 20:58, Halil Pasic wrote:
>>> On Thu, 5 Dec 2024 11:16:27 +0100
>>> Wenjia Zhang <wenjia@linux.ibm.com> wrote:
>>>
>>>>> --- a/net/smc/af_smc.c
>>>>> +++ b/net/smc/af_smc.c
>>>>> @@ -1116,7 +1116,12 @@ static int smc_find_proposal_devices(struct
>>>>> smc_sock *smc, ini->check_smcrv2 = true;
>>>>>        ini->smcrv2.saddr = smc->clcsock->sk->sk_rcv_saddr;
>>>>>        if (!(ini->smcr_version & SMC_V2) ||
>>>>> +#if IS_ENABLED(CONFIG_IPV6)
>>>>> +        (smc->clcsock->sk->sk_family != AF_INET &&
>>>>> +
>>>>> !ipv6_addr_v4mapped(&smc->clcsock->sk->sk_v6_rcv_saddr)) ||
>>>> I think here you want to say !(smc->clcsock->sk->sk_family == AF_INET
>>>> && ipv6_addr_v4mapped(&smc->clcsock->sk->sk_v6_rcv_saddr)), right? If
>>>> it is, the negativ form of the logical operation (a&&b) is (!a)||(!b),
>>>> i.e. here should be:
>>>> （smc->clcsock->sk->sk_family != AF_INET）||
>>>> （!ipv6_addr_v4mapped(&smc->clcsock->sk->sk_v6_rcv_saddr)）
>>>
>>> Wenjia, I think you happen to confuse something here. The condition
>>> of this if statement is supposed to evaluate as true iff we don't want
>>> to propose SMCRv2 because the situation is such that SMCRv2 is not
>>> supported.
>>>
>>> We have a bunch of conditions we need to meet for SMCRv2 so
>>> logically we have (A && B && C && D). Now since the if is
>>> about when SMCRv2 is not supported we have a super structure
>>> that looks like !A || !B || !C || !D. With this patch, if
>>> CONFIG_IPV6 is not enabled, the sub-condition remains the same:
>>> if smc->clcsock->sk->sk_family is something else that AF_INET
>>> the we do not do SMCRv2!
>>>
>>> But when we do have CONFIG_IPV6 then we want to do SMCRv2 for
>>> AF_INET6 sockets too if the addresses used are actually
>>> v4 mapped addresses.
>>>
>>> Now this is where the cognitive dissonance starts on my end. I
>>> think the author assumes sk_family == AF_INET || sk_family == AF_INET6
>>> is a tautology in this context. That may be a reasonable thing to
>>> assume. Under that assumption
>>> sk_family != AF_INET &&    !ipv6_addr_v4mapped(addr) (shortened for
>>> convenience)
>>> becomes equivalent to
>>> sk_family == AF_INET6 && !ipv6_addr_v4mapped(addr)
>>> which means in words if the socket is an IPv6 sockeet and the addr is 
>>> not
>>> a v4 mapped v6 address then we *can not* do SMCRv2. And the condition
>>> when we can is sk_family != AF_INET6 || ipv6_addr_v4mapped(addr) which
>>> is equivalen to sk_family == AF_INET || ipv6_addr_v4mapped(addr) under
>>> the aforementioned assumption.
>>
>> Hi, Halil
>>
>> Thank you for such a detailed derivation.
>>
>> Yes, here assume that sk_family == AF_INET || sk_family == AF_INET6. 
>> Indeed,
>> many codes in SMC have already made this assumption, for example,
>> static int __smc_create(struct net *net, struct socket *sock, int 
>> protocol,
>>             int kern, struct socket *clcsock)
>> {
>>     int family = (protocol == SMCPROTO_SMC6) ? PF_INET6 : PF_INET;
>>     ...
>> }
>> And I also believe it is reasonable.
>>
>> Before this patch, for SMCR client, only an IPV4 socket can do SMCRv2. 
>> This patch
>> introduce an IPV6 socket with v4 mapped v6 address for SMCRv2. It is 
>> equivalen
>> to sk_family == AF_INET || ipv6_addr_v4mapped(addr) as you described.
>>
>>>
>>> But if we assume sk_family == AF_INET || sk_family == AF_INET6 then
>>> the #else does not make any sense, because I guess with IPv6 not
>>> available AF_INET6 is not available ant thus the else is always
>>> guaranteed to evaluate to false under the assumption made.
>>>
>> You are right. The #else here does not make any sense. It's my mistake.
>>
>> The condition is easier to understand and read should be like this:
>>       if (!(ini->smcr_version & SMC_V2) ||
>> +#if IS_ENABLED(CONFIG_IPV6)
>> +        (smc->clcsock->sk->sk_family == AF_INET6 &&
>> +         !ipv6_addr_v4mapped(&smc->clcsock->sk->sk_v6_rcv_saddr)) ||
>> +#endif
>>           !smc_clc_ueid_count() ||
>>           smc_find_rdma_device(smc, ini))
>>           ini->smcr_version &= ~SMC_V2;
>>
> 
> sorry, I still don't agree on this version. You removed the condition
> "
> smc->clcsock->sk->sk_family != AF_INET ||
> "
> completely. What about the socket with neither AF_INET nor AF_INET6 family?
> 
> Thanks,
> Wenjia
> 
I think the main problem in the original version was that
(sk_family != AF_INET) is not equivalent to (sk_family == AF_INET6).
Since you already in the new version above used sk_family == AF_INET6,
the else condition could stay as it is. My suggestion:

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 8e3093938cd2..5f205a41fc48 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1116,7 +1116,12 @@ static int smc_find_proposal_devices(struct 
smc_sock *smc,
         ini->check_smcrv2 = true;
         ini->smcrv2.saddr = smc->clcsock->sk->sk_rcv_saddr;
         if (!(ini->smcr_version & SMC_V2) ||
+#if IS_ENABLED(CONFIG_IPV6)
+           (smc->clcsock->sk->sk_family == AF_INET6 &&
+            !ipv6_addr_v4mapped(&smc->clcsock->sk->sk_v6_rcv_saddr)) ||
+#else
             smc->clcsock->sk->sk_family != AF_INET ||
+#endif
             !smc_clc_ueid_count() ||
             smc_find_rdma_device(smc, ini))
                 ini->smcr_version &= ~SMC_V2;

Thanks,
Wenjia

