Return-Path: <linux-rdma+bounces-6329-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3659E9469
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Dec 2024 13:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14353166B10
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Dec 2024 12:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A0D227570;
	Mon,  9 Dec 2024 12:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="bTTEruUY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out199-18.us.a.mail.aliyun.com (out199-18.us.a.mail.aliyun.com [47.90.199.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4E6227562;
	Mon,  9 Dec 2024 12:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733747826; cv=none; b=sbo+edoIww5LxSi8IujDtZoic1wf4St8VI45i2mqCPUQu9eqm9UbZt/pMrbNXZMpby2Y4pfVp4nNjitYkORduPJG/HTGl7UsiF1xd0q2QCa1pCi9PrawBVjlsVcC1fWmBWvyvVv3tQQfD3rdbHSLbc4CrNKyLTMzRMRo7NufxTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733747826; c=relaxed/simple;
	bh=i/Onhqwmf/fv4z4xdhqlB8vf3AAv71umzV18RWniTmE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g2UJwzfZ3xOoCGo6BnpvB5eyNnHimza9lq3hSlZ1KS41fCR/8OMsotZYaRz8ncQ9JpKnwigLQvolxC2QKhZES2EUQyfvrHyW5H4x6QnX9QeQQaUdqoePM3r3AI3Jv+691rBEas9B4QkP4k4zyvVYJEJZkxspKrEwcPwaQBhN8bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=bTTEruUY; arc=none smtp.client-ip=47.90.199.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733747809; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=jBO5y5aXzjlJWjCNlZv6s3UK+baFjQ/lEjyaBwH35+c=;
	b=bTTEruUY7ZlKtD8ENpy5JX7DaIdI0rpTTNMMuAN7lXig2cyVFkY7iVU9gh3Sc6fcmcqiaT9D7dal08Sf8e6TjRwzW4B7ho7ieI5yihS8Qz2tWdFjGTDxB3UplqMNqOW0xAJD838xhNYBzmJhFvaFnEWpt/mqc/o+qc5aRjusHLg=
Received: from 30.221.100.140(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0WL8e8RW_1733747806 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 09 Dec 2024 20:36:48 +0800
Message-ID: <85d1c6e1-0fe3-4c71-af4e-8015270b90dc@linux.alibaba.com>
Date: Mon, 9 Dec 2024 20:36:45 +0800
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
 <5ac2c5a7-3f12-48e5-83a9-ecd3867e6125@linux.alibaba.com>
 <7de81edd-86f2-4cfd-95db-e273c3436eb6@linux.ibm.com>
 <3710a042-cabe-4b6d-9caa-fd4d864b2fdc@linux.ibm.com>
 <d2af79e2-adb2-46f0-a7e3-67a9265f3adf@linux.alibaba.com>
 <868f5d66-ac74-4b0a-a0d0-e44fdea3bb73@linux.ibm.com>
 <20241209104647.5c36c429.pasic@linux.ibm.com>
Content-Language: en-US
From: Guangguan Wang <guangguan.wang@linux.alibaba.com>
In-Reply-To: <20241209104647.5c36c429.pasic@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024/12/9 17:46, Halil Pasic wrote:
> On Mon, 9 Dec 2024 09:49:23 +0100
> Wenjia Zhang <wenjia@linux.ibm.com> wrote:
> 
>>> Otherwise, the code below is reasonable.
>>>        if (!(ini->smcr_version & SMC_V2) ||
>>> +#if IS_ENABLED(CONFIG_IPV6)
>>> +        (smc->clcsock->sk->sk_family == AF_INET6 &&
>>> +         !ipv6_addr_v4mapped(&smc->clcsock->sk->sk_v6_rcv_saddr)) ||
>>> +#endif
>>>            !smc_clc_ueid_count() ||
>>>            smc_find_rdma_device(smc, ini))
>>>            ini->smcr_version &= ~SMC_V2;
>>>   
>> Ok, I got your point, a socket with an address family other than AF_INET 
>> and AF_INET6 is already pre-filtered, so that such extra condition 
>> checking for the smc->clcsock->sk->sk_family != AF_INET is not 
>> necessary, right?
>>
>> Would you like to send a new version? And feel free to use this in the 
>> new version:
>>
>> Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
> 
> I believe we would like to have a v3 here. Also I'm not sure
> checking on saddr is sufficient, but I didn't do my research on
> that question yet.
> 
> Regards,
> Halil

Did you mean to research whether the daddr should be checked too?

Thanks,
Guangguan Wang

