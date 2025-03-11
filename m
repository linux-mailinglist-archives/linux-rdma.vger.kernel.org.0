Return-Path: <linux-rdma+bounces-8558-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2CCDA5B6FB
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Mar 2025 03:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3A221715ED
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Mar 2025 02:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8701D1E520B;
	Tue, 11 Mar 2025 02:55:57 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB211DF25C;
	Tue, 11 Mar 2025 02:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741661757; cv=none; b=oOjixcC6lqiwfvRDES3RFdXpK/ixuf+sEmcKfUeXx5vzFBs98t2B/KlOKYrMqnooV+rSonFwK1jtbcuip7BvwN22Mg8HPHacp23Dufo1gqAknL6EcVwXTLLGQb2gvWcNKifaf81qaUBBhu1cGxs13gqHbC+xuE/JVSc+WFpN3ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741661757; c=relaxed/simple;
	bh=qulKWfGRj75Ztmb5Ay0oSmZ3IY74NDesIjdaXhKxh4c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=i+kdBckkh6WNDSdCVUHsVUIHbdU42uOzxa29ylb/JhK4OOBgLXJo2xkVbdCjntMVSx+X3k3BFzuKI6egYDmGA4LgFQ+GtYy/BQq4T9gM5nQVnRRBId29DYpo8rpEB8mTkDIF8FpTkkYcbpDWJd1Rx6CgrL19gC1wHhuOYXN51rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4ZBdZB6btjz1ltYv;
	Tue, 11 Mar 2025 10:51:30 +0800 (CST)
Received: from kwepemg200005.china.huawei.com (unknown [7.202.181.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 977BD1A0188;
	Tue, 11 Mar 2025 10:55:50 +0800 (CST)
Received: from [10.174.176.70] (10.174.176.70) by
 kwepemg200005.china.huawei.com (7.202.181.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 11 Mar 2025 10:55:49 +0800
Message-ID: <946cac23-6348-4b18-bb94-58f470bb5a6c@huawei.com>
Date: Tue, 11 Mar 2025 10:55:42 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] infiniband: fix use-after-free when rename device
 name
To: Leon Romanovsky <leon@kernel.org>
CC: <jgg@ziepe.ca>, <cmeiohas@nvidia.com>, <michaelgur@nvidia.com>,
	<huangjunxian6@hisilicon.com>, <liyuyu6@huawei.com>, <markzhang@nvidia.com>,
	<linux@treblig.org>, <jbi.octave@gmail.com>, <dsahern@kernel.org>,
	<yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250310064516.3633612-1-wangliang74@huawei.com>
 <20250310101410.GB7027@unreal>
From: Wang Liang <wangliang74@huawei.com>
In-Reply-To: <20250310101410.GB7027@unreal>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemg200005.china.huawei.com (7.202.181.32)


在 2025/3/10 18:14, Leon Romanovsky 写道:
> On Mon, Mar 10, 2025 at 02:45:16PM +0800, Wang Liang wrote:
>> Syzbot reported a slab-use-after-free with the following call trace:
>>
>> ==================================================================
>> BUG: KASAN: slab-use-after-free in nla_put+0xd3/0x150 lib/nlattr.c:1099
>> Read of size 5 at addr ffff888140ea1c60 by task syz.0.988/10025
>>
>> CPU: 0 UID: 0 PID: 10025 Comm: syz.0.988 Not tainted 6.14.0-rc4-syzkaller-00859-gf77f12010f67 #0
>> Hardware name: Google Compute Engine, BIOS Google 02/12/2025
>> Call Trace:
>>   <TASK>
>>   __dump_stack lib/dump_stack.c:94 [inline]
>>   dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>>   print_address_description mm/kasan/report.c:408 [inline]
>>   print_report+0x16e/0x5b0 mm/kasan/report.c:521
>>   kasan_report+0x143/0x180 mm/kasan/report.c:634
>>   kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
>>   __asan_memcpy+0x29/0x70 mm/kasan/shadow.c:105
>>   nla_put+0xd3/0x150 lib/nlattr.c:1099
>>   nla_put_string include/net/netlink.h:1621 [inline]
>>   fill_nldev_handle+0x16e/0x200 drivers/infiniband/core/nldev.c:265
>>   rdma_nl_notify_event+0x561/0xef0 drivers/infiniband/core/nldev.c:2857
>>   ib_device_notify_register+0x22/0x230 drivers/infiniband/core/device.c:1344
>>   ib_register_device+0x1292/0x1460 drivers/infiniband/core/device.c:1460
>>   rxe_register_device+0x233/0x350 drivers/infiniband/sw/rxe/rxe_verbs.c:1540
>>   rxe_net_add+0x74/0xf0 drivers/infiniband/sw/rxe/rxe_net.c:550
>>   rxe_newlink+0xde/0x1a0 drivers/infiniband/sw/rxe/rxe.c:212
>>   nldev_newlink+0x5ea/0x680 drivers/infiniband/core/nldev.c:1795
>>   rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
>>   rdma_nl_rcv+0x6dd/0x9e0 drivers/infiniband/core/netlink.c:259
>>   netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
>>   netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1339
>>   netlink_sendmsg+0x8de/0xcb0 net/netlink/af_netlink.c:1883
>>   sock_sendmsg_nosec net/socket.c:709 [inline]
>>   __sock_sendmsg+0x221/0x270 net/socket.c:724
>>   ____sys_sendmsg+0x53a/0x860 net/socket.c:2564
>>   ___sys_sendmsg net/socket.c:2618 [inline]
>>   __sys_sendmsg+0x269/0x350 net/socket.c:2650
>>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>> RIP: 0033:0x7f42d1b8d169
>> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 ...
>> RSP: 002b:00007f42d2960038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
>> RAX: ffffffffffffffda RBX: 00007f42d1da6320 RCX: 00007f42d1b8d169
>> RDX: 0000000000000000 RSI: 00004000000002c0 RDI: 000000000000000c
>> RBP: 00007f42d1c0e2a0 R08: 0000000000000000 R09: 0000000000000000
>> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
>> R13: 0000000000000000 R14: 00007f42d1da6320 R15: 00007ffe399344a8
>>   </TASK>
>>
>> Allocated by task 10025:
>>   kasan_save_stack mm/kasan/common.c:47 [inline]
>>   kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>>   poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
>>   __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
>>   kasan_kmalloc include/linux/kasan.h:260 [inline]
>>   __do_kmalloc_node mm/slub.c:4294 [inline]
>>   __kmalloc_node_track_caller_noprof+0x28b/0x4c0 mm/slub.c:4313
>>   __kmemdup_nul mm/util.c:61 [inline]
>>   kstrdup+0x42/0x100 mm/util.c:81
>>   kobject_set_name_vargs+0x61/0x120 lib/kobject.c:274
>>   dev_set_name+0xd5/0x120 drivers/base/core.c:3468
>>   assign_name drivers/infiniband/core/device.c:1202 [inline]
>>   ib_register_device+0x178/0x1460 drivers/infiniband/core/device.c:1384
>>   rxe_register_device+0x233/0x350 drivers/infiniband/sw/rxe/rxe_verbs.c:1540
>>   rxe_net_add+0x74/0xf0 drivers/infiniband/sw/rxe/rxe_net.c:550
>>   rxe_newlink+0xde/0x1a0 drivers/infiniband/sw/rxe/rxe.c:212
>>   nldev_newlink+0x5ea/0x680 drivers/infiniband/core/nldev.c:1795
>>   rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
>>   rdma_nl_rcv+0x6dd/0x9e0 drivers/infiniband/core/netlink.c:259
>>   netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
>>   netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1339
>>   netlink_sendmsg+0x8de/0xcb0 net/netlink/af_netlink.c:1883
>>   sock_sendmsg_nosec net/socket.c:709 [inline]
>>   __sock_sendmsg+0x221/0x270 net/socket.c:724
>>   ____sys_sendmsg+0x53a/0x860 net/socket.c:2564
>>   ___sys_sendmsg net/socket.c:2618 [inline]
>>   __sys_sendmsg+0x269/0x350 net/socket.c:2650
>>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>
>> Freed by task 10035:
>>   kasan_save_stack mm/kasan/common.c:47 [inline]
>>   kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>>   kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:576
>>   poison_slab_object mm/kasan/common.c:247 [inline]
>>   __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
>>   kasan_slab_free include/linux/kasan.h:233 [inline]
>>   slab_free_hook mm/slub.c:2353 [inline]
>>   slab_free mm/slub.c:4609 [inline]
>>   kfree+0x196/0x430 mm/slub.c:4757
>>   kobject_rename+0x38f/0x410 lib/kobject.c:524
>>   device_rename+0x16a/0x200 drivers/base/core.c:4525
>>   ib_device_rename+0x270/0x710 drivers/infiniband/core/device.c:402
>>   nldev_set_doit+0x30e/0x4c0 drivers/infiniband/core/nldev.c:1146
>>   rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
>>   rdma_nl_rcv+0x6dd/0x9e0 drivers/infiniband/core/netlink.c:259
>>   netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
>>   netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1339
>>   netlink_sendmsg+0x8de/0xcb0 net/netlink/af_netlink.c:1883
>>   sock_sendmsg_nosec net/socket.c:709 [inline]
>>   __sock_sendmsg+0x221/0x270 net/socket.c:724
>>   ____sys_sendmsg+0x53a/0x860 net/socket.c:2564
>>   ___sys_sendmsg net/socket.c:2618 [inline]
>>   __sys_sendmsg+0x269/0x350 net/socket.c:2650
>>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>
>> This is because if rename device happens, the old name is freed in
>> ib_device_rename() with lock, but fill_nldev_handle() may visit the dev
>> name locklessly triggered by rxe_newlink().
>>
>> Fix this by add lock around rdma_nl_notify_event() in
>> ib_device_notify_register().
>>
>> Reported-by: syzbot+f60349ba1f9f08df349f@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=25bc6f0ed2b88b9eb9b8
>> Fixes: 9cbed5aab5ae ("RDMA/nldev: Add support for RDMA monitoring")
>> Signed-off-by: Wang Liang <wangliang74@huawei.com>
>> ---
>>   drivers/infiniband/core/device.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
>> index 0ded91f056f3..4536621ada0d 100644
>> --- a/drivers/infiniband/core/device.c
>> +++ b/drivers/infiniband/core/device.c
>> @@ -1341,7 +1341,9 @@ static void ib_device_notify_register(struct ib_device *device)
>>   	u32 port;
>>   	int ret;
>>   
>> +	down_write(&devices_rwsem);
> The analysis looks correct to me, however this should be down_read(&devices_rwsem)
> together with comment about possible race with RDMA netlink, which can change
> internals of struct ib_device.
>
> I wonder if this read semaphore should be hold for whole
> ib_device_notify_register() function and not only for RDMA_REGISTER_EVENT event.
>
> Thanks
Yes, you are right! The RDMA_NETDEV_ATTACH_EVENT event in function
ib_device_notify_register() can also visit the dev name locklessly:

rxe_newlink
     ...
     ib_device_notify_register
         rdma_nl_notify_event(RDMA_NETDEV_ATTACH_EVENT)
             fill_mon_netdev_association
                 // visit dev_name without devices_rwsem

What's more, the following trace may also trigger the issue when function
nldev_set_doit() rename device:

(1)
RDMA_NLDEV_CMD_GET
     nldev_get_doit
         fill_dev_info
             fill_nldev_handle
                 // visit dev_name without devices_rwsem

(2)
RDMA_NLDEV_CMD_PORT_GET
     nldev_port_get_doit
         fill_port_info
             fill_nldev_handle
                 // visit dev_name without devices_rwsem

(3)
RDMA_NLDEV_CMD_RES_GET
     nldev_res_get_doit
         fill_res_info
             fill_nldev_handle
                 // visit dev_name without devices_rwsem

And more...

However, some scenarios hold devices_rwsem, like function 
nldev_get_dumpit(),
which was modified by 921eab1143aa("RDMA/devices: Re-organize device.c 
locking"):

RDMA_NLDEV_CMD_GET
     nldev_get_dumpit
         ib_enum_all_devs
             down_read(&devices_rwsem); // hold devices_rwsem read
                 _nldev_get_dumpit
                     fill_dev_info
                         fill_nldev_handle
                             // visit dev_name with devices_rwsem
             up_read(&devices_rwsem);

So only hold devices_rwsem for whole ib_device_notify_register() may be 
not enough.

How about add down_read(&devices_rwsem) around 
fill_dev_info()/fill_port_info()/
fill_res_info()/ib_device_notify_register().

Looking forward to more replies. Thanks.
>>   	ret = rdma_nl_notify_event(device, 0, RDMA_REGISTER_EVENT);
>> +	up_write(&devices_rwsem);
>>   	if (ret)
>>   		return;
>>   
>> -- 
>> 2.34.1
>>
>>

