Return-Path: <linux-rdma+bounces-9316-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C736A83716
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Apr 2025 05:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E818442637
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Apr 2025 03:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80991EF09C;
	Thu, 10 Apr 2025 03:11:33 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6E71519B9;
	Thu, 10 Apr 2025 03:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744254693; cv=none; b=PmrB9MgHs2Psn0aoJAy0POixsWYd9uxhqihi2zHdfmsrzkZXnucredS0rOMlP3XUKIHUmPq3B7+K+e0oVzKCL4/R5BW/PFpLpCYzejbr407rFiObuG4OjpWMaE0QJ4NmDdsaLf4KaUGzr0/AcJBBO9dzMIPzinua+K8pdEBMogI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744254693; c=relaxed/simple;
	bh=cHDX/RTaNZvt7XEJz/mLC8SY2k4IjAHwq86v2CvUVTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Kj3BTb7diokBvNzkinCxSMiwWjPpGqTTqVkpM8cfpt7zr5sNV5A5ZONcvSUh7W3a3BvAAhPRrF7WjxY+4xycFrj4E/EnqkkKz1fnS+o/iQXXY+G5qXprAe0VwxJ54xUhuIoBEQKoYtv3Ksa13n95Cnl7xt66ytKcVo9GJ/44a8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ZY4ZZ1Hw9z13LTG;
	Thu, 10 Apr 2025 11:10:46 +0800 (CST)
Received: from kwepemg200005.china.huawei.com (unknown [7.202.181.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 00411180B4E;
	Thu, 10 Apr 2025 11:11:28 +0800 (CST)
Received: from [10.174.176.70] (10.174.176.70) by
 kwepemg200005.china.huawei.com (7.202.181.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 10 Apr 2025 11:11:26 +0800
Message-ID: <cd82f1ea-85a5-48a1-b528-b879e91dde1c@huawei.com>
Date: Thu, 10 Apr 2025 11:11:25 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/smc: fix general protection fault in
 __smc_diag_dump
To: Wenjia Zhang <wenjia@linux.ibm.com>, <jaka@linux.ibm.com>,
	<alibuda@linux.alibaba.com>, <tonylu@linux.alibaba.com>,
	<guwen@linux.alibaba.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<ubraun@linux.vnet.ibm.com>, Sidraya Jayagond <sidraya@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>
CC: <yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>,
	<linux-rdma@vger.kernel.org>, <linux-s390@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250331081003.1503211-1-wangliang74@huawei.com>
 <d1771c61-b2bb-4eb4-aaad-0fc01d578848@linux.ibm.com>
From: Wang Liang <wangliang74@huawei.com>
In-Reply-To: <d1771c61-b2bb-4eb4-aaad-0fc01d578848@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemg200005.china.huawei.com (7.202.181.32)


在 2025/4/3 19:55, Wenjia Zhang 写道:
>
>
> On 31.03.25 10:10, Wang Liang wrote:
>> Syzbot reported a general protection fault:
>>
>>    CPU: 0 UID: 0 PID: 5830 Comm: syz-executor600 Not tainted 
>> 6.14.0-rc4-syzkaller-00090-gdd83757f6e68 #0
>>    RIP: 0010:smc_diag_msg_common_fill net/smc/smc_diag.c:44 [inline]
>>    RIP: 0010:__smc_diag_dump.constprop.0+0x3de/0x23d0 
>> net/smc/smc_diag.c:89
>>    Call Trace:
>>     <TASK>
>>     smc_diag_dump_proto+0x26d/0x420 net/smc/smc_diag.c:217
>>     smc_diag_dump+0x84/0x90 net/smc/smc_diag.c:236
>>     netlink_dump+0x53c/0xd00 net/netlink/af_netlink.c:2318
>>     __netlink_dump_start+0x6ca/0x970 net/netlink/af_netlink.c:2433
>>     netlink_dump_start include/linux/netlink.h:340 [inline]
>>     smc_diag_handler_dump+0x1fb/0x240 net/smc/smc_diag.c:251
>>     __sock_diag_cmd net/core/sock_diag.c:249 [inline]
>>     sock_diag_rcv_msg+0x437/0x790 net/core/sock_diag.c:287
>>     netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2543
>>     netlink_unicast_kernel net/netlink/af_netlink.c:1322 [inline]
>>     netlink_unicast+0x53c/0x7f0 net/netlink/af_netlink.c:1348
>>     netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1892
>>     sock_sendmsg_nosec net/socket.c:718 [inline]
>>     __sock_sendmsg net/socket.c:733 [inline]
>>     ____sys_sendmsg+0xaaf/0xc90 net/socket.c:2573
>>     ___sys_sendmsg+0x135/0x1e0 net/socket.c:2627
>>     __sys_sendmsg+0x16e/0x220 net/socket.c:2659
>>     do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>>     do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>>     entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>     </TASK>
>>
>> When create smc socket, smc_inet_init_sock() first add sk to the 
>> smc_hash
>> by smc_hash_sk(), then create smc->clcsock. it is possible that, after
>> smc_diag_dump_proto() traverses the smc_hash, smc->clcsock is not 
>> created
>> when the function visit it.
>>
>> The process like this:
>>
>>    (CPU1)                         | (CPU2)
>>    inet6_create()                 |
>>      smc_inet_init_sock()         |
>>        smc_sk_init()              |
>>          smc_hash_sk()            |
>>            head = &smc_hash->ht;  |
>>            sk_add_node(sk, head); |
>>                                   | smc_diag_dump_proto
>>                                   |   head = &smc_hash->ht;
>>                                   |     sk_for_each(sk, head)
>>                                   |       __smc_diag_dump()
>>                                   |         visit smc->clcsock
>>        smc_create_clcsk()         |
>>            set smc->clcsock       |
>>
>> Fix this by initialize smc->clcsock to NULL before add sk to smc_hash in
>> smc_sk_init().
>>
>> Reported-by: syzbot+271fed3ed6f24600c364@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=271fed3ed6f24600c364
>> Fixes: f16a7dd5cf27 ("smc: netlink interface for SMC sockets")
>> Signed-off-by: Wang Liang <wangliang74@huawei.com>
>> ---
>>   net/smc/af_smc.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
>> index 3e6cb35baf25..454801188514 100644
>> --- a/net/smc/af_smc.c
>> +++ b/net/smc/af_smc.c
>> @@ -371,6 +371,7 @@ void smc_sk_init(struct net *net, struct sock 
>> *sk, int protocol)
>>       sk->sk_protocol = protocol;
>>       WRITE_ONCE(sk->sk_sndbuf, 2 * READ_ONCE(net->smc.sysctl_wmem));
>>       WRITE_ONCE(sk->sk_rcvbuf, 2 * READ_ONCE(net->smc.sysctl_rmem));
>> +    smc->clcsock = NULL;
>>       INIT_WORK(&smc->tcp_listen_work, smc_tcp_listen_work);
>>       INIT_WORK(&smc->connect_work, smc_connect_work);
>>       INIT_DELAYED_WORK(&smc->conn.tx_work, smc_tx_work);
>
> I have to agree with this workaround, even though I see that is not 
> the best solution. Thus, I'd like to give my R-b:
>
> Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
>
> Btw. @D. Wythe, would you mind sending me the link of your proposal 
> you mentioned please? Let me have a look. It seems like I missed it.
>
> Thanks,
> Wenjia
>

Hello, is this patch rejected?
If there are some new fix patchs, please let me know.
Thanks.

>
>

