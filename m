Return-Path: <linux-rdma+bounces-13920-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9789EBE6FDE
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Oct 2025 09:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1CF0735B3D7
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Oct 2025 07:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF6F259C9A;
	Fri, 17 Oct 2025 07:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="P9FNiTIH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6653D2550D5;
	Fri, 17 Oct 2025 07:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760687149; cv=none; b=h/0jkkbCHuCQNPTI1z98WT9OnMLz0fUrriGOWc3UbdwS/ZCadYfgvicOEevLEk0H1ATs0ZxqGUnRJ0MeTVImQkzLQk0zP3ccIn8sLSvttriWT/+LzrRGJwngUQ50ey1m49cjTNSej6fhRxmoHkrSjmb9YpN1Tmow3mamKVyKmA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760687149; c=relaxed/simple;
	bh=Xy8tQ6z9q1+b8QlGnXUAhw4J1Hdss29/peYK3Rr/gWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KnP7AiHzsENFWL2rqRKLDrU9L40GRPZNWDPYZ4EC8B/0ObaEHm5snphIKGwrZrDrQAi0rgBKmzFRSpqAptO2LG4FskuRIGOlcW2XXE1ZHBkotYvYCkSf79sx755kuvzTnmAY6uq+E5I8PFXCWZupM7sNBwKIvwA7TsV1V6K6c7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=P9FNiTIH; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=NYSt968XvTx34dKez/5OXfwcS9OE8mZYevsTppAeHLE=;
	b=P9FNiTIH+9BnY/d+q/cBGWYFxm+qmm+QWc34kaTtLlFB0lgg7rjxI1gt4wIVlERd9sYNeCxq6
	A7NLU79HKAKZjb5kNLFEUHCCvsYPri3N9jKItNY8eCNaaXbOU7bZkoP2DAlKj4S16c69+HZPFF5
	bYmRwZJYd0DGflIMPFgxhRY=
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4cnxgk1xtBzLlVc;
	Fri, 17 Oct 2025 15:45:22 +0800 (CST)
Received: from dggpemf500016.china.huawei.com (unknown [7.185.36.197])
	by mail.maildlp.com (Postfix) with ESMTPS id BB2D4180042;
	Fri, 17 Oct 2025 15:45:43 +0800 (CST)
Received: from [10.174.177.19] (10.174.177.19) by
 dggpemf500016.china.huawei.com (7.185.36.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 17 Oct 2025 15:45:42 +0800
Message-ID: <ecd158c4-5af7-415c-9d29-d5ec8fec49a2@huawei.com>
Date: Fri, 17 Oct 2025 15:45:41 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net/smc: fix general protection fault in
 __smc_diag_dump
To: Kuniyuki Iwashima <kuniyu@google.com>
CC: <alibuda@linux.alibaba.com>, <davem@davemloft.net>,
	<dust.li@linux.alibaba.com>, <edumazet@google.com>,
	<guwen@linux.alibaba.com>, <horms@kernel.org>, <kuba@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-s390@vger.kernel.org>, <mjambigi@linux.ibm.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <sidraya@linux.ibm.com>,
	<tonylu@linux.alibaba.com>, <wenjia@linux.ibm.com>, <yuehaibing@huawei.com>,
	<zhangchangzhong@huawei.com>
References: <20251017024827.3137512-1-wangliang74@huawei.com>
 <20251017055106.3603987-1-kuniyu@google.com>
From: Wang Liang <wangliang74@huawei.com>
In-Reply-To: <20251017055106.3603987-1-kuniyu@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500016.china.huawei.com (7.185.36.197)


在 2025/10/17 13:48, Kuniyuki Iwashima 写道:
> From: Wang Liang <wangliang74@huawei.com>
> Date: Fri, 17 Oct 2025 10:48:27 +0800
>> The syzbot report a crash:
>>
>>    Oops: general protection fault, probably for non-canonical address 0xfbd5a5d5a0000003: 0000 [#1] SMP KASAN NOPTI
>>    KASAN: maybe wild-memory-access in range [0xdead4ead00000018-0xdead4ead0000001f]
>>    CPU: 1 UID: 0 PID: 6949 Comm: syz.0.335 Not tainted syzkaller #0 PREEMPT(full)
>>    Hardware name: Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
>>    RIP: 0010:smc_diag_msg_common_fill net/smc/smc_diag.c:44 [inline]
>>    RIP: 0010:__smc_diag_dump.constprop.0+0x3ca/0x2550 net/smc/smc_diag.c:89
>>    Call Trace:
>>     <TASK>
>>     smc_diag_dump_proto+0x26d/0x420 net/smc/smc_diag.c:217
>>     smc_diag_dump+0x27/0x90 net/smc/smc_diag.c:234
>>     netlink_dump+0x539/0xd30 net/netlink/af_netlink.c:2327
>>     __netlink_dump_start+0x6d6/0x990 net/netlink/af_netlink.c:2442
>>     netlink_dump_start include/linux/netlink.h:341 [inline]
>>     smc_diag_handler_dump+0x1f9/0x240 net/smc/smc_diag.c:251
>>     __sock_diag_cmd net/core/sock_diag.c:249 [inline]
>>     sock_diag_rcv_msg+0x438/0x790 net/core/sock_diag.c:285
>>     netlink_rcv_skb+0x158/0x420 net/netlink/af_netlink.c:2552
>>     netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
>>     netlink_unicast+0x5a7/0x870 net/netlink/af_netlink.c:1346
>>     netlink_sendmsg+0x8d1/0xdd0 net/netlink/af_netlink.c:1896
>>     sock_sendmsg_nosec net/socket.c:714 [inline]
>>     __sock_sendmsg net/socket.c:729 [inline]
>>     ____sys_sendmsg+0xa95/0xc70 net/socket.c:2614
>>     ___sys_sendmsg+0x134/0x1d0 net/socket.c:2668
>>     __sys_sendmsg+0x16d/0x220 net/socket.c:2700
>>     do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>>     do_syscall_64+0xcd/0x4e0 arch/x86/entry/syscall_64.c:94
>>     entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>     </TASK>
>>
>> The process like this:
>>
>>                 (CPU1)              |             (CPU2)
>>    ---------------------------------|-------------------------------
>>    inet_create()                    |
>>      // init clcsock to NULL        |
>>      sk = sk_alloc()                |
>>                                     |
>>      // unexpectedly change clcsock |
>>      inet_init_csk_locks()          |
>>                                     |
>>      // add sk to hash table        |
>>      smc_inet_init_sock()           |
>>        smc_sk_init()                |
>>          smc_hash_sk()              |
>>                                     | // traverse the hash table
>>                                     | smc_diag_dump_proto
>>                                     |   __smc_diag_dump()
>>                                     |     // visit wrong clcsock
>>                                     |     smc_diag_msg_common_fill()
>>      // alloc clcsock               |
>>      smc_create_clcsk               |
>>        sock_create_kern             |
>>
>> With CONFIG_DEBUG_LOCK_ALLOC=y, the smc->clcsock is unexpectedly changed
>> in inet_init_csk_locks(). The INET_PROTOSW_ICSK flag is no need by smc,
>> just remove it.
>>
>> After removing the INET_PROTOSW_ICSK flag, this patch alse revert
>> commit 6fd27ea183c2 ("net/smc: fix lacks of icsk_syn_mss with IPPROTO_SMC")
>> to avoid casting smc_sock to inet_connection_sock.
>>
>> Reported-by: syzbot+f775be4458668f7d220e@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=f775be4458668f7d220e
>> Tested-by: syzbot+f775be4458668f7d220e@syzkaller.appspotmail.com
> nit: looks like this diff is not tested by syzbot, you may
> want to send diff to syzbot.
>

Thank you for the reminder!

I just sent this diff to syzbot, and the test return OK:
https://lore.kernel.org/netdev/b76f348d-61d3-404b-81c6-57621a14046b@huawei.com/T/#t

------
Best regards
Wang Liang

>> Fixes: d25a92ccae6b ("net/smc: Introduce IPPROTO_SMC")
>> Signed-off-by: Wang Liang <wangliang74@huawei.com>
> Change itself looks good.
>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
>
> Thanks!

