Return-Path: <linux-rdma+bounces-3361-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD19390FFDF
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2024 11:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58DCB1F234A3
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2024 09:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1DFA15ADA0;
	Thu, 20 Jun 2024 09:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QJJvqQHT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF7F628
	for <linux-rdma@vger.kernel.org>; Thu, 20 Jun 2024 09:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718874338; cv=none; b=gNs+6PxjV/2P7UOKqR6dP3veEDNXb6xzX3QjxFVXvjM15y3DTtKtrfXkLCCtWYEXlSZ6a7YXCaH5p+4mvSf4ar/q8BJLsveXsDo7H7JSuTYSzsqJeE8sHX/Tv2TNYyUg8qTbwWk9i6WFRt77B4vPgN3vcB4cT/RGjPAfJsuUCu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718874338; c=relaxed/simple;
	bh=jkKEq5JT+Lrrhve6Owgp68jjvCNnaECDynRqPxfxNt4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jOg+r2PJGE/mN71n1ORp4uLc1u1qQ54DiA/yrVsmUL4+OynkE+dYBpQwabBSs4HINa3AWvHJ+T5m5cJUHJm8IJTMrWilNV8ykqkV0GcoaTCYYTPvsNm7j0WVTd/fp/0amYUmDbF1wDKhRW5VKrcMx6yEHGx0MbVtQfWO7XBkc+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QJJvqQHT; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: leon@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718874334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UvFo5cd3E4KERCkesw8BgsGhNxyquIalxzKIE9JjvGY=;
	b=QJJvqQHTAHPtgcEoyYsp9kFBQqiswzb48TDSfzE/FHaez1zP0Hd3i+oy8qIe03ZB+kkBc5
	hiMoakj3Vo9O9PeXkYTjpp12EBINz97SlmaVH743rkUpKUKT3QhPgsWfZJmWk7sqqLVbKd
	vMNyfag0OyDFpJ+Ih22gQKl4GBB+Zk0=
X-Envelope-To: syzbot+19ec7595e3aa1a45f623@syzkaller.appspotmail.com
X-Envelope-To: jgg@ziepe.ca
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: linux-rdma@vger.kernel.org
X-Envelope-To: netdev@vger.kernel.org
X-Envelope-To: syzkaller-bugs@googlegroups.com
Message-ID: <ef2c01b5-d38b-4409-bbd4-0484564657c9@linux.dev>
Date: Thu, 20 Jun 2024 17:05:25 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [syzbot] [rdma?] WARNING in ib_uverbs_release_dev
To: Leon Romanovsky <leon@kernel.org>
Cc: syzbot <syzbot+19ec7595e3aa1a45f623@syzkaller.appspotmail.com>,
 jgg@ziepe.ca, linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000057e4c061b386e23@google.com>
 <20240619091557.GM4025@unreal>
 <94d36dd5-313b-46b3-8d43-95016175d273@linux.dev>
 <20240619174802.GP4025@unreal>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20240619174802.GP4025@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/6/20 1:48, Leon Romanovsky 写道:
> On Wed, Jun 19, 2024 at 10:16:20PM +0800, Zhu Yanjun wrote:
>> 在 2024/6/19 17:15, Leon Romanovsky 写道:
>>> On Tue, Jun 18, 2024 at 11:37:18PM -0700, syzbot wrote:
>>>> Hello,
>>>>
>>>> syzbot found the following issue on:
>>>>
>>>> HEAD commit:    2ccbdf43d5e7 Merge tag 'for-linus' of git://git.kernel.org..
>>>> git tree:       upstream
>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=179e93fe980000
>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=fa0ce06dcc735711
>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=19ec7595e3aa1a45f623
>>>> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>>>>
>>>> Unfortunately, I don't have any reproducer for this issue yet.
>>>>
>>>> Downloadable assets:
>>>> disk image: https://storage.googleapis.com/syzbot-assets/27e64d7472ce/disk-2ccbdf43.raw.xz
>>>> vmlinux: https://storage.googleapis.com/syzbot-assets/e1c494bb5c9c/vmlinux-2ccbdf43.xz
>>>> kernel image: https://storage.googleapis.com/syzbot-assets/752498985a5e/bzImage-2ccbdf43.xz
>>>>
>>>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>>>> Reported-by: syzbot+19ec7595e3aa1a45f623@syzkaller.appspotmail.com
>>>>
>>>> smc: removing ib device syz0
>>>> ------------[ cut here ]------------
>>>> WARNING: CPU: 0 PID: 51 at kernel/rcu/srcutree.c:653 cleanup_srcu_struct+0x404/0x4d0 kernel/rcu/srcutree.c:653
>>>> Modules linked in:
>>>> CPU: 0 PID: 51 Comm: kworker/u8:3 Not tainted 6.10.0-rc3-syzkaller-00044-g2ccbdf43d5e7 #0
>>>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
>>>> Workqueue: ib-unreg-wq ib_unregister_work
>>>> RIP: 0010:cleanup_srcu_struct+0x404/0x4d0 kernel/rcu/srcutree.c:653
>>>> Code: 12 80 00 48 c7 03 00 00 00 00 48 83 c4 48 5b 41 5c 41 5d 41 5e 41 5f 5d e9 14 67 34 0a 90 0f 0b 90 eb e7 90 0f 0b 90 eb e1 90 <0f> 0b 90 eb db 90 0f 0b 90 eb 0a 90 0f 0b 90 eb 04 90 0f 0b 90 48
>>>> RSP: 0018:ffffc90000bb7970 EFLAGS: 00010202
>>>> RAX: 0000000000000001 RBX: ffff88802a1bc980 RCX: 0000000000000002
>>>> RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffe8ffffd74c58
>>>> RBP: 0000000000000001 R08: ffffe8ffffd74c5f R09: 1ffffd1ffffae98b
>>>> R10: dffffc0000000000 R11: fffff91ffffae98c R12: dffffc0000000000
>>>> R13: ffff88802285b5f0 R14: ffff88802285b000 R15: ffff88802a1bc800
>>>> FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
>>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>> CR2: 00007fa3852cae10 CR3: 000000000e132000 CR4: 0000000000350ef0
>>>> Call Trace:
>>>>    <TASK>
>>>>    ib_uverbs_release_dev+0x4e/0x80 drivers/infiniband/core/uverbs_main.c:136
>>>>    device_release+0x9b/0x1c0
>>>>    kobject_cleanup lib/kobject.c:689 [inline]
>>>>    kobject_release lib/kobject.c:720 [inline]
>>>>    kref_put include/linux/kref.h:65 [inline]
>>>>    kobject_put+0x231/0x480 lib/kobject.c:737
>>>>    remove_client_context+0xb9/0x1e0 drivers/infiniband/core/device.c:776
>>>>    disable_device+0x13b/0x360 drivers/infiniband/core/device.c:1282
>>>>    __ib_unregister_device+0x6d/0x170 drivers/infiniband/core/device.c:1475
>>>>    ib_unregister_work+0x19/0x30 drivers/infiniband/core/device.c:1586
>>>>    process_one_work kernel/workqueue.c:3231 [inline]
>>>>    process_scheduled_works+0xa2e/0x1830 kernel/workqueue.c:3312
>>>>    worker_thread+0x86d/0xd70 kernel/workqueue.c:3393
>>>>    kthread+0x2f2/0x390 kernel/kthread.c:389
>>>>    ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
>>>>    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>>>>    </TASK>
>>>
>>> I see that this is caused by call to ib_unregister_device_queued() as a
>>> response to NETDEV_UNREGISTER event, but we don't flush anything before.
>>> How can we be sure that ib_device is not used anymore?
>>
>> Hi, Leon
>>
>> This is the console output:
>>
>> https://syzkaller.appspot.com/x/log.txt?x=179e93fe980000
>>
>>  From the above link, it seems that other devices or subsystems failed
>> firstly, then caused this call trace to appear. When other problem occurred,
>> the whole kernel system was in mess state.So it is not weird that some
>> problems occurred.
> 
> Which devices/subsystems failed? I grepped the log and don't see
> anything suspicious, before first "------------[ cut here ]------------"
> sentence.

Need the script to check this problem. It is an interesting problem.

Zhu Yanjun

> 
>>
>> To be simple, the root cause is not in RDMA subsystem.
>>
>> I will continue to delve into this problem.
>>
>> Zhu Yanjun
>>>
>>> Thanks
>>


