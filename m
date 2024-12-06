Return-Path: <linux-rdma+bounces-6317-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D41B9E6C90
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Dec 2024 11:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63516167035
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Dec 2024 10:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F59B641;
	Fri,  6 Dec 2024 10:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gGVGUYRf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10B51AAE10;
	Fri,  6 Dec 2024 10:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733482298; cv=none; b=CVIA9WjcJCDcwsxZa6N2KF1cKQ7+a4qY6dff1QCFgKi+lytr8NiD/OJbplV1rDw3RCmkRUqFHp3gossscZy9D3pErEqdT5pn6Ttm1sY/rX55W1nZD+tG1Hah8DtNLo5oJjrX0x4+dy6GzvP3hAM27IlLwtPMzbnb4e2InQIH2wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733482298; c=relaxed/simple;
	bh=CouLME7orFdsU+8T/hW1JlX7rf7refWTSmCp9wD1qvo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kT3JJQdlHbFeCMpWmWLn/YTIFb4g6vWqUwNnjKFwLC6xoBrr0Sdh4aOK0RM9v1YvcT+nevQjPHDH5R9S803b6vhaFyOxQs3G/aMRHlBZN5SG8ghJOiwCj1cQ6eStaP/4P2nCjemt95ANteaqLjMfeqq5dGJsxtbf9ZsFdkzo5gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gGVGUYRf; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B627O4i030944;
	Fri, 6 Dec 2024 10:51:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=hgsoxT
	LPhEfkhPwnpiSSF2RRyng1pMSplvj6kwx2bBc=; b=gGVGUYRfLWDYqzLIlh6Qnh
	Cg/GV01JosqKo+PTHS/pz5jDejKBIc/+THAXubsPeHWpBpzNRgzhZZP8j9Zn+Y2U
	acEseQk2gk6aBG3VZtAO0r9O8JEG795ewQLDDkLrpmG+uI3H1EjQaixZXhzC2CVl
	1CqK9ZwRQBOE7rD2j61KtCukVOFztpWnefCqMXIgGdmQh89I08GtUnJZ87lpXGn5
	/dJJngcK8VG0TeG9i/s3FiSB6jn2o7ApK4un7/4WCbCBpjmbEoG3JYZM1NCS0oY1
	X/5gxhniGXzi7vSE/dWAkmlpiGJED16Tg2nGkM0eI3PsBAGYWyj98z0bfbYSrysg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43b6hb7mdc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Dec 2024 10:51:31 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4B6AkUFR020759;
	Fri, 6 Dec 2024 10:51:30 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43b6hb7md8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Dec 2024 10:51:30 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B67G1vf005213;
	Fri, 6 Dec 2024 10:51:29 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43a2kxw0e1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Dec 2024 10:51:29 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B6ApSgS18612872
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Dec 2024 10:51:28 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E484858067;
	Fri,  6 Dec 2024 10:51:27 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 81BFE5805D;
	Fri,  6 Dec 2024 10:51:25 +0000 (GMT)
Received: from [9.171.74.148] (unknown [9.171.74.148])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Dec 2024 10:51:25 +0000 (GMT)
Message-ID: <7de81edd-86f2-4cfd-95db-e273c3436eb6@linux.ibm.com>
Date: Fri, 6 Dec 2024 11:51:24 +0100
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
Content-Language: en-US
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <5ac2c5a7-3f12-48e5-83a9-ecd3867e6125@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: v9iop3K27SzZta1MsyvdopGoIWgTM3xl
X-Proofpoint-GUID: pE9rWIVZVP_Kh0eMFGqNfeh1mWLq_Ezt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxlogscore=910 clxscore=1015 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412060076



On 06.12.24 07:06, Guangguan Wang wrote:
> 
> 
> On 2024/12/5 20:58, Halil Pasic wrote:
>> On Thu, 5 Dec 2024 11:16:27 +0100
>> Wenjia Zhang <wenjia@linux.ibm.com> wrote:
>>
>>>> --- a/net/smc/af_smc.c
>>>> +++ b/net/smc/af_smc.c
>>>> @@ -1116,7 +1116,12 @@ static int smc_find_proposal_devices(struct
>>>> smc_sock *smc, ini->check_smcrv2 = true;
>>>>    	ini->smcrv2.saddr = smc->clcsock->sk->sk_rcv_saddr;
>>>>    	if (!(ini->smcr_version & SMC_V2) ||
>>>> +#if IS_ENABLED(CONFIG_IPV6)
>>>> +	    (smc->clcsock->sk->sk_family != AF_INET &&
>>>> +
>>>> !ipv6_addr_v4mapped(&smc->clcsock->sk->sk_v6_rcv_saddr)) ||
>>> I think here you want to say !(smc->clcsock->sk->sk_family == AF_INET
>>> && ipv6_addr_v4mapped(&smc->clcsock->sk->sk_v6_rcv_saddr)), right? If
>>> it is, the negativ form of the logical operation (a&&b) is (!a)||(!b),
>>> i.e. here should be:
>>> （smc->clcsock->sk->sk_family != AF_INET）||
>>> （!ipv6_addr_v4mapped(&smc->clcsock->sk->sk_v6_rcv_saddr)）
>>
>> Wenjia, I think you happen to confuse something here. The condition
>> of this if statement is supposed to evaluate as true iff we don't want
>> to propose SMCRv2 because the situation is such that SMCRv2 is not
>> supported.
>>
>> We have a bunch of conditions we need to meet for SMCRv2 so
>> logically we have (A && B && C && D). Now since the if is
>> about when SMCRv2 is not supported we have a super structure
>> that looks like !A || !B || !C || !D. With this patch, if
>> CONFIG_IPV6 is not enabled, the sub-condition remains the same:
>> if smc->clcsock->sk->sk_family is something else that AF_INET
>> the we do not do SMCRv2!
>>
>> But when we do have CONFIG_IPV6 then we want to do SMCRv2 for
>> AF_INET6 sockets too if the addresses used are actually
>> v4 mapped addresses.
>>
>> Now this is where the cognitive dissonance starts on my end. I
>> think the author assumes sk_family == AF_INET || sk_family == AF_INET6
>> is a tautology in this context. That may be a reasonable thing to
>> assume. Under that assumption
>> sk_family != AF_INET &&	!ipv6_addr_v4mapped(addr) (shortened for
>> convenience)
>> becomes equivalent to
>> sk_family == AF_INET6 && !ipv6_addr_v4mapped(addr)
>> which means in words if the socket is an IPv6 sockeet and the addr is not
>> a v4 mapped v6 address then we *can not* do SMCRv2. And the condition
>> when we can is sk_family != AF_INET6 || ipv6_addr_v4mapped(addr) which
>> is equivalen to sk_family == AF_INET || ipv6_addr_v4mapped(addr) under
>> the aforementioned assumption.
> 
> Hi, Halil
> 
> Thank you for such a detailed derivation.
> 
> Yes, here assume that sk_family == AF_INET || sk_family == AF_INET6. Indeed,
> many codes in SMC have already made this assumption, for example,
> static int __smc_create(struct net *net, struct socket *sock, int protocol,
> 			int kern, struct socket *clcsock)
> {
> 	int family = (protocol == SMCPROTO_SMC6) ? PF_INET6 : PF_INET;
> 	...
> }
> And I also believe it is reasonable.
> 
> Before this patch, for SMCR client, only an IPV4 socket can do SMCRv2. This patch
> introduce an IPV6 socket with v4 mapped v6 address for SMCRv2. It is equivalen
> to sk_family == AF_INET || ipv6_addr_v4mapped(addr) as you described.
> 
>>
>> But if we assume sk_family == AF_INET || sk_family == AF_INET6 then
>> the #else does not make any sense, because I guess with IPv6 not
>> available AF_INET6 is not available ant thus the else is always
>> guaranteed to evaluate to false under the assumption made.
>>
> You are right. The #else here does not make any sense. It's my mistake.
> 
> The condition is easier to understand and read should be like this:
>   	if (!(ini->smcr_version & SMC_V2) ||
> +#if IS_ENABLED(CONFIG_IPV6)
> +	    (smc->clcsock->sk->sk_family == AF_INET6 &&
> +	     !ipv6_addr_v4mapped(&smc->clcsock->sk->sk_v6_rcv_saddr)) ||
> +#endif
>   	    !smc_clc_ueid_count() ||
>   	    smc_find_rdma_device(smc, ini))
>   		ini->smcr_version &= ~SMC_V2;
> 

sorry, I still don't agree on this version. You removed the condition
"
smc->clcsock->sk->sk_family != AF_INET ||
"
completely. What about the socket with neither AF_INET nor AF_INET6 family?

Thanks,
Wenjia

