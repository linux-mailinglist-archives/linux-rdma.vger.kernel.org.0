Return-Path: <linux-rdma+bounces-9133-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 687C8A79C9A
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Apr 2025 09:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DE7F3B3E8A
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Apr 2025 07:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18AF923F415;
	Thu,  3 Apr 2025 07:09:22 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E22523F289;
	Thu,  3 Apr 2025 07:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743664161; cv=none; b=C84yd3Lo3ICXRsbH6KNEx7huGVrSbUK5GPz3cwSN+220Tcp9GiIfeuFQBBUGaqdm0pcHsVyFbVKVw+VLEQ+eREwlqIjc5k7yZaCEr2McPwhH+OXDPZ8xbbSNOyo99qCMixAsiEzpwI5fgjLYWE4CUS/th+Z/tCHO+/2Ni6ZHtVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743664161; c=relaxed/simple;
	bh=sLbbJwrNJuWZdLBKeEw5OjHjp4yxNXKpIbq8folZ0l8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rsffKESi8xoC0MetHJ/f30vIICV5G2IB8mJLtGnuism38F1U+xNSjkyNeg8O/kjNanRE5rtfSftYpwuHLFFHrWi6AaPxuIRH/TF65LBYHDgB3IY+jEHh2v8UbhLfqS7aXIUfGZ3Bbf610RyMaD+imMpjoJTBEtcjj8lROScDwNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4ZSt5R0F0nz1k1Gy;
	Thu,  3 Apr 2025 15:04:27 +0800 (CST)
Received: from kwepemg200005.china.huawei.com (unknown [7.202.181.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 44BD31A0188;
	Thu,  3 Apr 2025 15:09:16 +0800 (CST)
Received: from [10.174.176.70] (10.174.176.70) by
 kwepemg200005.china.huawei.com (7.202.181.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 3 Apr 2025 15:09:14 +0800
Message-ID: <fd31d24b-8a34-4da5-b7ed-3ebf9aa30d1d@huawei.com>
Date: Thu, 3 Apr 2025 15:09:13 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/smc: fix general protection fault in
 __smc_diag_dump
To: "D. Wythe" <alibuda@linux.alibaba.com>
CC: Paolo Abeni <pabeni@redhat.com>, <wenjia@linux.ibm.com>,
	<jaka@linux.ibm.com>, <tonylu@linux.alibaba.com>, <guwen@linux.alibaba.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<horms@kernel.org>, <ubraun@linux.vnet.ibm.com>, <yanjun.zhu@linux.dev>,
	<yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>,
	<linux-rdma@vger.kernel.org>, <linux-s390@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250331081003.1503211-1-wangliang74@huawei.com>
 <37f86471-5abc-4f04-954e-c6fb5f2b653a@redhat.com>
 <99f284be-bf1d-4bc4-a629-77b268522fff@huawei.com>
 <20250402072010.GA110656@j66a10360.sqa.eu95>
From: Wang Liang <wangliang74@huawei.com>
In-Reply-To: <20250402072010.GA110656@j66a10360.sqa.eu95>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemg200005.china.huawei.com (7.202.181.32)


在 2025/4/2 15:20, D. Wythe 写道:
> On Wed, Apr 02, 2025 at 10:37:24AM +0800, Wang Liang wrote:
>> 在 2025/4/1 19:01, Paolo Abeni 写道:
>>> On 3/31/25 10:10 AM, Wang Liang wrote:
>>>> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
>>>> index 3e6cb35baf25..454801188514 100644
>>>> --- a/net/smc/af_smc.c
>>>> +++ b/net/smc/af_smc.c
>>>> @@ -371,6 +371,7 @@ void smc_sk_init(struct net *net, struct sock *sk, int protocol)
>>>>   	sk->sk_protocol = protocol;
>>>>   	WRITE_ONCE(sk->sk_sndbuf, 2 * READ_ONCE(net->smc.sysctl_wmem));
>>>>   	WRITE_ONCE(sk->sk_rcvbuf, 2 * READ_ONCE(net->smc.sysctl_rmem));
>>>> +	smc->clcsock = NULL;
>>>>   	INIT_WORK(&smc->tcp_listen_work, smc_tcp_listen_work);
>>>>   	INIT_WORK(&smc->connect_work, smc_connect_work);
>>>>   	INIT_DELAYED_WORK(&smc->conn.tx_work, smc_tx_work);
>>> The syzkaller report has a few reproducers, have you tested this? AFAICS
>>> the smc socket is already zeroed on allocation by sk_alloc().
>>
>> Yes, I test it by the C repro:
>> https://syzkaller.appspot.com/text?tag=ReproC&x=13d2dc98580000
>>
>> The C repro is provided by the 2025/02/27 15:16 crash from
>>    https://syzkaller.appspot.com/bug?extid=271fed3ed6f24600c364
>>
>> After apply my patch, the crash no longer happens when running the C repro.
>>
>> "the smc socket is already zeroed on allocation by sk_alloc()", That
>> is right.
>> However, smc->clcsock may be modified indirectly in inet6_create().
>> The process like this:
>>
>>    __sys_socket
>>      __sys_socket_create
>>        sock_create
>>          __sock_create
>>            # pf->create
>>            inet6_create
>>              // init smc->clcsock = 0
>>              sk = sk_alloc()
>>
>>              // set smc->clcsock to invalid address
>>              inet = inet_sk(sk);
>>              inet_assign_bit(IS_ICSK, sk, INET_PROTOSW_ICSK & answer_flags);
>>              inet6_set_bit(MC6_LOOP, sk);
>>              inet6_set_bit(MC6_ALL, sk);
>>
>>              smc_inet_init_sock
>>                smc_sk_init
>>                  // add sk to smc_hash
>>                  smc_hash_sk
>>                    sk_add_node(sk, head);
>>                smc_create_clcsk
>>                  // set smc->clcsock
>>                  sock_create_kern(..., &smc->clcsock);)
>>
>> So initialize smc->clcsock to NULL explicitly in smc_sk_init() can fix
>> this crash scene. If the problem can be reproduced after this patch, I
>> guess it is not the same reason, and fix it by another patch is more
>> appropriate.
>>
> This is actually because the current smc_sock is not an inet_sock,
> leading to two modules simultaneously modifying the same offset in
> memory but interpreting its structure differently. I previously proposed
> embedding an inet(6)_sock at the beginning of smc_sock, but the
> community had some objections...
>
> I'm not sure on the community's current stance on this matter, but if a
> fix is absolutely necessary, my recommendation would still be to embed
> an inet(6)_sock within the smc_sock structure
>
> D.

At present, I think initializing the smc in smc_sk_init() may be the 
most simple and effective method. :P

>
>>> /P
>>>
>>>

