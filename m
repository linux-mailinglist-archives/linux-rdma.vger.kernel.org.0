Return-Path: <linux-rdma+bounces-13668-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 045BDBA2FE1
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Sep 2025 10:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4A26625810
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Sep 2025 08:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4E5296BC0;
	Fri, 26 Sep 2025 08:42:45 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A1C35950;
	Fri, 26 Sep 2025 08:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758876164; cv=none; b=DExztVPYivMWQYOenkgfL4YHk57qRyfJp8RGiZZ+QiTQLODURC9D1f2Vka1Fs80mj4mM1MVSZXWSvolJyNYm9IsEQtKv49JUfxNnZ0qaKmCKaFoLM4MoAzQ1ImEzcDjQAwPcotJ+2LYORw+fzgKImyBPpihjjd+Em4Bsi6qiACo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758876164; c=relaxed/simple;
	bh=YpkXVO2Y6uKbqfDq/4Hn+poYOhVaKbGk1KU87swjoOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mAD8hU6pbgw7hSbSvjvaUiO8sUOX+IjMxDq0tNV3nHyZYEm1OWRilFom8hgiOXv8C5wNoD+Xxfu7yR5c4AhnA1SoC/c3rVAa4AixrZviBM+cytH7nb26gKX7jX1wKvnW6U9L8lTo3GXTTT3jv9oSbeF7XucnXy//xkW6c4Z2+zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4cY3r74l2NzRkDx;
	Fri, 26 Sep 2025 16:37:59 +0800 (CST)
Received: from dggpemf500016.china.huawei.com (unknown [7.185.36.197])
	by mail.maildlp.com (Postfix) with ESMTPS id 755C6180486;
	Fri, 26 Sep 2025 16:42:38 +0800 (CST)
Received: from [10.174.177.19] (10.174.177.19) by
 dggpemf500016.china.huawei.com (7.185.36.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 26 Sep 2025 16:42:36 +0800
Message-ID: <8ab4d343-d287-4b42-94f7-511f46e131d3@huawei.com>
Date: Fri, 26 Sep 2025 16:42:35 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/smc: fix general protection fault in
 __smc_diag_dump
To: Kuniyuki Iwashima <kuniyu@google.com>, Eric Dumazet <edumazet@google.com>
CC: <alibuda@linux.alibaba.com>, <dust.li@linux.alibaba.com>,
	<sidraya@linux.ibm.com>, <wenjia@linux.ibm.com>, <mjambigi@linux.ibm.com>,
	<tonylu@linux.alibaba.com>, <guwen@linux.alibaba.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-s390@vger.kernel.org>
References: <20250922121818.654011-1-wangliang74@huawei.com>
 <CANn89iLOyFnwD+monMHCmTgfZEAPWmhrZu-=8mvtMGyM9FG49g@mail.gmail.com>
 <CAAVpQUBxoWW_4U2an4CZNoSi95OduUhArezHnzKgpV3oOYs5Jg@mail.gmail.com>
 <CANn89i+V847kRTTFW43ouZXXuaBs177fKv5_bqfbvRutpg+s6g@mail.gmail.com>
 <CAAVpQUBriJFUhq2MpfwFTBLkF0rJfaVp1gaJ3wdhZuD7NWOaXw@mail.gmail.com>
 <CANn89i+Ntwzm2A=NSHbKdFuGVR6kar00AjrJE91Lu0e5BUsVow@mail.gmail.com>
 <CAAVpQUAd1oba6cy-hSub-iS0cnh7WH=HXgVnUwj8MXZLyU=a+w@mail.gmail.com>
From: Wang Liang <wangliang74@huawei.com>
In-Reply-To: <CAAVpQUAd1oba6cy-hSub-iS0cnh7WH=HXgVnUwj8MXZLyU=a+w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500016.china.huawei.com (7.185.36.197)


在 2025/9/26 3:51, Kuniyuki Iwashima 写道:
> On Thu, Sep 25, 2025 at 12:37 PM Eric Dumazet <edumazet@google.com> wrote:
>> On Thu, Sep 25, 2025 at 12:25 PM Kuniyuki Iwashima <kuniyu@google.com> wrote:
>>> On Thu, Sep 25, 2025 at 11:54 AM Eric Dumazet <edumazet@google.com> wrote:
>>>> On Thu, Sep 25, 2025 at 11:46 AM Kuniyuki Iwashima <kuniyu@google.com> wrote:
>>>>> Thanks Eric for CCing me.
>>>>>
>>>>> On Thu, Sep 25, 2025 at 7:32 AM Eric Dumazet <edumazet@google.com> wrote:
>>>>>> On Mon, Sep 22, 2025 at 4:57 AM Wang Liang <wangliang74@huawei.com> wrote:
>>>>>>> The syzbot report a crash:
>>>>>>>
>>>>>>>    Oops: general protection fault, probably for non-canonical address 0xfbd5a5d5a0000003: 0000 [#1] SMP KASAN NOPTI
>>>>>>>    KASAN: maybe wild-memory-access in range [0xdead4ead00000018-0xdead4ead0000001f]
>>>>>>>    CPU: 1 UID: 0 PID: 6949 Comm: syz.0.335 Not tainted syzkaller #0 PREEMPT(full)
>>>>>>>    Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
>>>>>>>    RIP: 0010:smc_diag_msg_common_fill net/smc/smc_diag.c:44 [inline]
>>>>>>>    RIP: 0010:__smc_diag_dump.constprop.0+0x3ca/0x2550 net/smc/smc_diag.c:89
>>>>>>>    Call Trace:
>>>>>>>     <TASK>
>>>>>>>     smc_diag_dump_proto+0x26d/0x420 net/smc/smc_diag.c:217
>>>>>>>     smc_diag_dump+0x27/0x90 net/smc/smc_diag.c:234
>>>>>>>     netlink_dump+0x539/0xd30 net/netlink/af_netlink.c:2327
>>>>>>>     __netlink_dump_start+0x6d6/0x990 net/netlink/af_netlink.c:2442
>>>>>>>     netlink_dump_start include/linux/netlink.h:341 [inline]
>>>>>>>     smc_diag_handler_dump+0x1f9/0x240 net/smc/smc_diag.c:251
>>>>>>>     __sock_diag_cmd net/core/sock_diag.c:249 [inline]
>>>>>>>     sock_diag_rcv_msg+0x438/0x790 net/core/sock_diag.c:285
>>>>>>>     netlink_rcv_skb+0x158/0x420 net/netlink/af_netlink.c:2552
>>>>>>>     netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
>>>>>>>     netlink_unicast+0x5a7/0x870 net/netlink/af_netlink.c:1346
>>>>>>>     netlink_sendmsg+0x8d1/0xdd0 net/netlink/af_netlink.c:1896
>>>>>>>     sock_sendmsg_nosec net/socket.c:714 [inline]
>>>>>>>     __sock_sendmsg net/socket.c:729 [inline]
>>>>>>>     ____sys_sendmsg+0xa95/0xc70 net/socket.c:2614
>>>>>>>     ___sys_sendmsg+0x134/0x1d0 net/socket.c:2668
>>>>>>>     __sys_sendmsg+0x16d/0x220 net/socket.c:2700
>>>>>>>     do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>>>>>>>     do_syscall_64+0xcd/0x4e0 arch/x86/entry/syscall_64.c:94
>>>>>>>     entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>>>>>>     </TASK>
>>>>>>>
>>>>>>> The process like this:
>>>>>>>
>>>>>>>                 (CPU1)              |             (CPU2)
>>>>>>>    ---------------------------------|-------------------------------
>>>>>>>    inet_create()                    |
>>>>>>>      // init clcsock to NULL        |
>>>>>>>      sk = sk_alloc()                |
>>>>>>>                                     |
>>>>>>>      // unexpectedly change clcsock |
>>>>>>>      inet_init_csk_locks()          |
>>>>>>>                                     |
>>>>>>>      // add sk to hash table        |
>>>>>>>      smc_inet_init_sock()           |
>>>>>>>        smc_sk_init()                |
>>>>>>>          smc_hash_sk()              |
>>>>>>>                                     | // traverse the hash table
>>>>>>>                                     | smc_diag_dump_proto
>>>>>>>                                     |   __smc_diag_dump()
>>>>>>>                                     |     // visit wrong clcsock
>>>>>>>                                     |     smc_diag_msg_common_fill()
>>>>>>>      // alloc clcsock               |
>>>>>>>      smc_create_clcsk               |
>>>>>>>        sock_create_kern             |
>>>>>>>
>>>>>>> With CONFIG_DEBUG_LOCK_ALLOC=y, the smc->clcsock is unexpectedly changed
>>>>>>> in inet_init_csk_locks(), because the struct smc_sock does not have struct
>>>>>>> inet_connection_sock as the first member.
>>>>>>>
>>>>>>> Previous commit 60ada4fe644e ("smc: Fix various oops due to inet_sock type
>>>>>>> confusion.") add inet_sock as the first member of smc_sock. For protocol
>>>>>>> with INET_PROTOSW_ICSK, use inet_connection_sock instead of inet_sock is
>>>>>>> more appropriate.
>>>>> Why is INET_PROTOSW_ICSK necessary in the first place ?
>>>>>
>>>>> I don't see a clear reason because smc_clcsock_accept() allocates
>>>>> a new sock by smc_sock_alloc() and does not use inet_accept().
>>>>>
>>>>> Or is there any other path where smc_sock is cast to
>>>>> inet_connection_sock ?
>>>> What I saw in this code was a missing protection.
>>>>
>>>> smc_diag_msg_common_fill() runs without socket lock being held.
>>>>
>>>> I was thinking of this fix, but apparently syzbot still got crashes.
>>> Looking at the test result,
>>>
>>> https://syzkaller.appspot.com/x/report.txt?x=15944c7c580000
>>> KASAN: maybe wild-memory-access in range [0xdead4ead00000018-0xdead4ead0000001f]
>>>
>>> the top half of the address is SPINLOCK_MAGIC (0xdead4ead),
>>> so the type confusion mentioned in the commit message makes
>>> sense to me.
>>>
>>> $ pahole -C inet_connection_sock vmlinux
>>> struct inet_connection_sock {
>>> ...
>>>      struct request_sock_queue  icsk_accept_queue;    /*   992    80 */
>>>
>>> $ pahole -C smc_sock vmlinux
>>> struct smc_sock {
>>> ...
>>>      struct socket *            clcsock;              /*   992     8 */
>>>
>>> The option is 1) let inet_init_csk_locks() init inet_connection_sock
>>> or 2) avoid inet_init_csk_locks(), and I guess 2) could be better to
>>> avoid potential issues in IS_ICSK branches.
>>>
>> I definitely vote to remove INET_PROTOSW_ICSK from smc.
>>
>> We want to reserve inet_connection_sock to TCP only, so that we can
>> move fields to better
>> cache friendly locations in tcp_sock hopefully for linux-6.19
> Fully agreed.
>
> Wang: please squash the revert of 6fd27ea183c2 for
> INET_PROTOSW_ICSK removal.  This is for one of
> IS_ICSK branches.


Thanks for your suggestions, they are helpful!

I will remove INET_PROTOSW_ICSK from smc_inet_protosw and smc_inet6_protosw,

and revert 6fd27ea183c2 ("net/smc: fix lacks of icsk_syn_mss with 
IPPROTO_SMC")

in one patchset later.

------
Best regards
Wang Liang




