Return-Path: <linux-rdma+bounces-9103-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB831A78674
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Apr 2025 04:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88B5D16E3A3
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Apr 2025 02:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2EC7DA6A;
	Wed,  2 Apr 2025 02:37:32 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3204645;
	Wed,  2 Apr 2025 02:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743561452; cv=none; b=HTfnnkvFGyiGUmW82IpYoNlsybTQe8igYEG+FiAwMTAoO/hh4sQJilLk60ueEZO8wgySRBCrYJd99GNB7RsoOgPjRXchuhk5WS0I21eclpbI+m++Ag7f2bKQjWzzaLKsODQiJkn33CzjiqRXG9sl5Q7VdaB+a02LDXhbzTtdzKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743561452; c=relaxed/simple;
	bh=1CGnMiOLhMZRbCjloWLFTYj3L6woZGpixy8OmUHIQZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OXRX9w7XvEQ37skxIJt8lGckoE+uOsUVaiX1cF8R0BLpe/bbhGmo3pwGN2+n9MkZ6gsGAo3FKonBbHxot9SHTCMoQ07jGTzTIsLVYppFpUbq0UsKeAjdjVuAunVGHcBNQSHVCJr7J3rrtMZSd23eMcjZUS9czROQvIZ76eY1NVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ZS8CC4xg5z13LPw;
	Wed,  2 Apr 2025 10:36:55 +0800 (CST)
Received: from kwepemg200005.china.huawei.com (unknown [7.202.181.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 125F61402CF;
	Wed,  2 Apr 2025 10:37:27 +0800 (CST)
Received: from [10.174.176.70] (10.174.176.70) by
 kwepemg200005.china.huawei.com (7.202.181.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 2 Apr 2025 10:37:25 +0800
Message-ID: <99f284be-bf1d-4bc4-a629-77b268522fff@huawei.com>
Date: Wed, 2 Apr 2025 10:37:24 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/smc: fix general protection fault in
 __smc_diag_dump
To: Paolo Abeni <pabeni@redhat.com>, <wenjia@linux.ibm.com>,
	<jaka@linux.ibm.com>, <alibuda@linux.alibaba.com>,
	<tonylu@linux.alibaba.com>, <guwen@linux.alibaba.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <horms@kernel.org>,
	<ubraun@linux.vnet.ibm.com>, <yanjun.zhu@linux.dev>
CC: <yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>,
	<linux-rdma@vger.kernel.org>, <linux-s390@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250331081003.1503211-1-wangliang74@huawei.com>
 <37f86471-5abc-4f04-954e-c6fb5f2b653a@redhat.com>
From: Wang Liang <wangliang74@huawei.com>
In-Reply-To: <37f86471-5abc-4f04-954e-c6fb5f2b653a@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemg200005.china.huawei.com (7.202.181.32)


在 2025/4/1 19:01, Paolo Abeni 写道:
> On 3/31/25 10:10 AM, Wang Liang wrote:
>> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
>> index 3e6cb35baf25..454801188514 100644
>> --- a/net/smc/af_smc.c
>> +++ b/net/smc/af_smc.c
>> @@ -371,6 +371,7 @@ void smc_sk_init(struct net *net, struct sock *sk, int protocol)
>>   	sk->sk_protocol = protocol;
>>   	WRITE_ONCE(sk->sk_sndbuf, 2 * READ_ONCE(net->smc.sysctl_wmem));
>>   	WRITE_ONCE(sk->sk_rcvbuf, 2 * READ_ONCE(net->smc.sysctl_rmem));
>> +	smc->clcsock = NULL;
>>   	INIT_WORK(&smc->tcp_listen_work, smc_tcp_listen_work);
>>   	INIT_WORK(&smc->connect_work, smc_connect_work);
>>   	INIT_DELAYED_WORK(&smc->conn.tx_work, smc_tx_work);
> The syzkaller report has a few reproducers, have you tested this? AFAICS
> the smc socket is already zeroed on allocation by sk_alloc().


Yes, I test it by the C repro:
https://syzkaller.appspot.com/text?tag=ReproC&x=13d2dc98580000

The C repro is provided by the 2025/02/27 15:16 crash from
   https://syzkaller.appspot.com/bug?extid=271fed3ed6f24600c364

After apply my patch, the crash no longer happens when running the C repro.

"the smc socket is already zeroed on allocation by sk_alloc()", That is 
right.
However, smc->clcsock may be modified indirectly in inet6_create().
The process like this:

   __sys_socket
     __sys_socket_create
       sock_create
         __sock_create
           # pf->create
           inet6_create
             // init smc->clcsock = 0
             sk = sk_alloc()

             // set smc->clcsock to invalid address
             inet = inet_sk(sk);
             inet_assign_bit(IS_ICSK, sk, INET_PROTOSW_ICSK & answer_flags);
             inet6_set_bit(MC6_LOOP, sk);
             inet6_set_bit(MC6_ALL, sk);

             smc_inet_init_sock
               smc_sk_init
                 // add sk to smc_hash
                 smc_hash_sk
                   sk_add_node(sk, head);
               smc_create_clcsk
                 // set smc->clcsock
                 sock_create_kern(..., &smc->clcsock);)

So initialize smc->clcsock to NULL explicitly in smc_sk_init() can fix
this crash scene. If the problem can be reproduced after this patch, I
guess it is not the same reason, and fix it by another patch is more
appropriate.

>
> /P
>
>

