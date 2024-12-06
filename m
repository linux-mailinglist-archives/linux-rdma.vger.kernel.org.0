Return-Path: <linux-rdma+bounces-6314-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7699E6726
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Dec 2024 07:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1CA7282567
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Dec 2024 06:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95AE1D8E16;
	Fri,  6 Dec 2024 06:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="cJt5DVWG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E281D88C4;
	Fri,  6 Dec 2024 06:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733465217; cv=none; b=V+CVd1ZDEe1py4qaLt9QTHqM2stvr7kxjF2g7hg02TLord2BBadmpHHkHs5aT3jWThfZUr9GFd9Xl44NeYkpmn+1kD8LleTThsGHYqurfBgSE83fjmp4I9LTuCvdGGqZ9g0ULzIRCQPH+ZyQLRPRxA0OAj/we9JOj0rKHyyu/tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733465217; c=relaxed/simple;
	bh=igMVSjSbC2cinxn8o6z2KpyGdrUFwLzvIB2Y2TSdw1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pHGJd5xxeD+8kOKN8Opi/fkph/ZiqN7HSUXnR0i0dbkAp7gt1NvNjdSO6nlfdSJDriSBZd/pZXONdT2FUu9vDVeu4HG/HpZBT3XnYD4XbSDZsA3QIQzY7KxNPAIOg1FXh8vL6YSJMY+7KPcYH0OfSNbKyiZeINmf8OoUg4aaRug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=cJt5DVWG; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733465209; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=CqYIBO72TbpWaL+ZYCPQ9yPK0iW4NdTNpwShIH5Vwa4=;
	b=cJt5DVWGrndKMS9RpsR3DDAj9xZ1Jf/iDQnNZ5xQrxDGxDDmXUIj+HK1RSnlonqd2ytSaBdQqEpmQF23tAMnhbeddyng4kmc/yATYCynA7uJTLywKofYv49RHddYFdu1wSQKUN4CTUCSaK8UKmOvzYKrpG4+EnMHWhwEVFdYdQU=
Received: from 30.221.100.83(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0WKvQP5c_1733465207 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 06 Dec 2024 14:06:49 +0800
Message-ID: <5ac2c5a7-3f12-48e5-83a9-ecd3867e6125@linux.alibaba.com>
Date: Fri, 6 Dec 2024 14:06:46 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] net/smc: support ipv4 mapped ipv6 addr
 client for smc-r v2
To: Halil Pasic <pasic@linux.ibm.com>, Wenjia Zhang <wenjia@linux.ibm.com>
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
Content-Language: en-US
From: Guangguan Wang <guangguan.wang@linux.alibaba.com>
In-Reply-To: <20241205135833.0beafd61.pasic@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024/12/5 20:58, Halil Pasic wrote:
> On Thu, 5 Dec 2024 11:16:27 +0100
> Wenjia Zhang <wenjia@linux.ibm.com> wrote:
> 
>>> --- a/net/smc/af_smc.c
>>> +++ b/net/smc/af_smc.c
>>> @@ -1116,7 +1116,12 @@ static int smc_find_proposal_devices(struct
>>> smc_sock *smc, ini->check_smcrv2 = true;
>>>   	ini->smcrv2.saddr = smc->clcsock->sk->sk_rcv_saddr;
>>>   	if (!(ini->smcr_version & SMC_V2) ||
>>> +#if IS_ENABLED(CONFIG_IPV6)
>>> +	    (smc->clcsock->sk->sk_family != AF_INET &&
>>> +
>>> !ipv6_addr_v4mapped(&smc->clcsock->sk->sk_v6_rcv_saddr)) ||  
>> I think here you want to say !(smc->clcsock->sk->sk_family == AF_INET
>> && ipv6_addr_v4mapped(&smc->clcsock->sk->sk_v6_rcv_saddr)), right? If
>> it is, the negativ form of the logical operation (a&&b) is (!a)||(!b),
>> i.e. here should be:
>> （smc->clcsock->sk->sk_family != AF_INET）|| 
>> （!ipv6_addr_v4mapped(&smc->clcsock->sk->sk_v6_rcv_saddr)）
> 
> Wenjia, I think you happen to confuse something here. The condition
> of this if statement is supposed to evaluate as true iff we don't want
> to propose SMCRv2 because the situation is such that SMCRv2 is not
> supported.
> 
> We have a bunch of conditions we need to meet for SMCRv2 so
> logically we have (A && B && C && D). Now since the if is
> about when SMCRv2 is not supported we have a super structure
> that looks like !A || !B || !C || !D. With this patch, if
> CONFIG_IPV6 is not enabled, the sub-condition remains the same:
> if smc->clcsock->sk->sk_family is something else that AF_INET
> the we do not do SMCRv2!
> 
> But when we do have CONFIG_IPV6 then we want to do SMCRv2 for
> AF_INET6 sockets too if the addresses used are actually
> v4 mapped addresses.
> 
> Now this is where the cognitive dissonance starts on my end. I
> think the author assumes sk_family == AF_INET || sk_family == AF_INET6
> is a tautology in this context. That may be a reasonable thing to
> assume. Under that assumption 
> sk_family != AF_INET &&	!ipv6_addr_v4mapped(addr) (shortened for
> convenience)
> becomes equivalent to
> sk_family == AF_INET6 && !ipv6_addr_v4mapped(addr)
> which means in words if the socket is an IPv6 sockeet and the addr is not
> a v4 mapped v6 address then we *can not* do SMCRv2. And the condition
> when we can is sk_family != AF_INET6 || ipv6_addr_v4mapped(addr) which
> is equivalen to sk_family == AF_INET || ipv6_addr_v4mapped(addr) under
> the aforementioned assumption.

Hi, Halil

Thank you for such a detailed derivation. 

Yes, here assume that sk_family == AF_INET || sk_family == AF_INET6. Indeed,
many codes in SMC have already made this assumption, for example,
static int __smc_create(struct net *net, struct socket *sock, int protocol,
			int kern, struct socket *clcsock)
{
	int family = (protocol == SMCPROTO_SMC6) ? PF_INET6 : PF_INET;
	...
}
And I also believe it is reasonable.

Before this patch, for SMCR client, only an IPV4 socket can do SMCRv2. This patch
introduce an IPV6 socket with v4 mapped v6 address for SMCRv2. It is equivalen
to sk_family == AF_INET || ipv6_addr_v4mapped(addr) as you described.

> 
> But if we assume sk_family == AF_INET || sk_family == AF_INET6 then
> the #else does not make any sense, because I guess with IPv6 not
> available AF_INET6 is not available ant thus the else is always
> guaranteed to evaluate to false under the assumption made.
> 
You are right. The #else here does not make any sense. It's my mistake.

The condition is easier to understand and read should be like this:
 	if (!(ini->smcr_version & SMC_V2) ||
+#if IS_ENABLED(CONFIG_IPV6)
+	    (smc->clcsock->sk->sk_family == AF_INET6 &&
+	     !ipv6_addr_v4mapped(&smc->clcsock->sk->sk_v6_rcv_saddr)) ||
+#endif
 	    !smc_clc_ueid_count() ||
 	    smc_find_rdma_device(smc, ini))
 		ini->smcr_version &= ~SMC_V2;

Thanks,
Guangguan Wang


> Thus I conclude, that I am certainly missing something here. Guangguan,
> do you care to explain?
> 
> Regards,
> Halil
>  





