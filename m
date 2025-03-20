Return-Path: <linux-rdma+bounces-8858-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 312E3A6A196
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Mar 2025 09:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0EBB3B8058
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Mar 2025 08:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AFCC213245;
	Thu, 20 Mar 2025 08:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Iz7Oyd/1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B8420FA8B
	for <linux-rdma@vger.kernel.org>; Thu, 20 Mar 2025 08:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742460091; cv=none; b=KUZSpUyYBb5pQgaWYsXG7lNpcstaMsfi/5wgoZR0H/VVn9Kbg34h5Vb9rnUITnwjNt1wZyujDBWdjA3pMrTpjVvps4WUPGe+dji+McnknvbyRMtj4AFY0IxQDSEhW64L24A4SK3ejrvasz7XNBrGBMbvP+KC+mmAHyaJ1yZh5QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742460091; c=relaxed/simple;
	bh=Xl0sN9nXKyD7XwlQ3LKCTHRWE2oPfn/jUJqZWIlcH54=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oRjzhwddf8jV9rfE6aDmpZ/eWW3tihHXfLtn3Z1qAVS9dpYhn7lTJSVzeu2kqCUGxtl4qF3tbGARKSwBJiix4rNT0icGcDgFshY40lFz9lTbttjmv5uuW5viK+lnd4MHqhWOPR929PUQFoT2uR1IrWdTT3ZPjxENHMhBeNB4Dqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Iz7Oyd/1; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c7ddbc01-f526-44dd-a7bd-69b9a38a040a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742460086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zi1iaGlhfR+TaozLS52j8nqEXg7xPT6xox5yrHMs700=;
	b=Iz7Oyd/1BoO3jnxOu5a4VU/oU80VEa69kyjdz+fDWsaZOYsSJid6vUfpZIfqofRCpWLXjs
	MfOYBeRe9eyVJRSoMYCDpO+GHnnWaXC7GcdlNErLtJdiQU9TiCtJCKZDecCE1W/yj9tDHT
	O1HpJKx9AU1ZNZKltrGbA7FL+/C8rxE=
Date: Thu, 20 Mar 2025 09:41:23 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [syzbot] [rdma?] KASAN: slab-use-after-free Read in
 ib_device_uevent (2)
To: syzbot <syzbot+17fb1664c4f5a2eeb36f@syzkaller.appspotmail.com>,
 jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <67b25ec8.050a0220.54b41.000d.GAE@google.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <67b25ec8.050a0220.54b41.000d.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 16.02.25 22:55, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    09fbf3d50205 Merge tag 'tomoyo-pr-20250211' of git://git.c..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=140563f8580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=641fe3e3cfee64bb
> dashboard link: https://syzkaller.appspot.com/bug?extid=17fb1664c4f5a2eeb36f
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-09fbf3d5.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/31b409a4b675/vmlinux-09fbf3d5.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/27f349d4d8cb/bzImage-09fbf3d5.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+17fb1664c4f5a2eeb36f@syzkaller.appspotmail.com

To this problem, I just looked through this problem which occurred on 
iwarp. I remember a similar problem which occurred on rxe.
To the problem on rxe, the solution 
https://patchwork.kernel.org/project/linux-rdma/patch/20250313092421.944658-1-wangliang74@huawei.com/ 
seems to be able to fix it.

I am not sure if this problem can also be fixed by the above solution or 
not.

Best Regards,
Zhu Yanjun

> 
> ==================================================================
> BUG: KASAN: slab-use-after-free in string_nocheck lib/vsprintf.c:632 [inline]
> BUG: KASAN: slab-use-after-free in string+0x4a6/0x4f0 lib/vsprintf.c:714
> Read of size 1 at addr ffff88803e895ea0 by task udevd/6903
> 
> CPU: 1 UID: 0 PID: 6903 Comm: udevd Not tainted 6.14.0-rc2-syzkaller-00039-g09fbf3d50205 #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:94 [inline]
>   dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
>   print_address_description mm/kasan/report.c:378 [inline]
>   print_report+0xc3/0x620 mm/kasan/report.c:489
>   kasan_report+0xd9/0x110 mm/kasan/report.c:602
>   string_nocheck lib/vsprintf.c:632 [inline]
>   string+0x4a6/0x4f0 lib/vsprintf.c:714
>   vsnprintf+0x4c8/0x1180 lib/vsprintf.c:2843
>   add_uevent_var+0x17c/0x3a0 lib/kobject_uevent.c:679
>   ib_device_uevent+0x4e/0xb0 drivers/infiniband/core/device.c:502
>   dev_uevent+0x28b/0x770 drivers/base/core.c:2673
>   uevent_show+0x1d8/0x3b0 drivers/base/core.c:2731
>   dev_attr_show+0x53/0xe0 drivers/base/core.c:2423
>   sysfs_kf_seq_show+0x23e/0x410 fs/sysfs/file.c:59
>   seq_read_iter+0x4f4/0x12b0 fs/seq_file.c:230
>   kernfs_fop_read_iter+0x414/0x580 fs/kernfs/file.c:279
>   new_sync_read fs/read_write.c:484 [inline]
>   vfs_read+0x886/0xbf0 fs/read_write.c:565
>   ksys_read+0x12b/0x250 fs/read_write.c:708
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f7681378b6a
> Code: 00 3d 00 00 41 00 75 0d 50 48 8d 3d 2d 08 0a 00 e8 ea 7d 01 00 31 c0 e9 07 ff ff ff 64 8b 04 25 18 00 00 00 85 c0 75 1b 0f 05 <48> 3d 00 f0 ff ff 76 6c 48 8b 15 8f a2 0d 00 f7 d8 64 89 02 48 83
> RSP: 002b:00007ffcbdf9d038 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> RAX: ffffffffffffffda RBX: 000055efbec7de20 RCX: 00007f7681378b6a
> RDX: 0000000000001000 RSI: 000055efbeca9490 RDI: 0000000000000008
> RBP: 000055efbec7de20 R08: 0000000000000008 R09: 0000000000020000
> R10: 000000000000010f R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000003fff R14: 00007ffcbdf9d518 R15: 000000000000000a
>   </TASK>
> 
> Allocated by task 12483:
>   kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
>   kasan_save_track+0x14/0x30 mm/kasan/common.c:68
>   poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
>   __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
>   kasan_kmalloc include/linux/kasan.h:260 [inline]
>   __do_kmalloc_node mm/slub.c:4294 [inline]
>   __kmalloc_node_track_caller_noprof+0x222/0x510 mm/slub.c:4313
>   __kmemdup_nul mm/util.c:61 [inline]
>   kstrdup+0x53/0x100 mm/util.c:81
>   kstrdup_const+0x63/0x80 mm/util.c:101
>   kvasprintf_const+0x164/0x1a0 lib/kasprintf.c:46
>   kobject_set_name_vargs+0x5a/0x140 lib/kobject.c:274
>   dev_set_name+0xc8/0x100 drivers/base/core.c:3468
>   assign_name drivers/infiniband/core/device.c:1202 [inline]
>   ib_register_device+0x7e0/0xdf0 drivers/infiniband/core/device.c:1384
>   siw_device_register drivers/infiniband/sw/siw/siw_main.c:72 [inline]
>   siw_newlink drivers/infiniband/sw/siw/siw_main.c:431 [inline]
>   siw_newlink+0xb60/0xd70 drivers/infiniband/sw/siw/siw_main.c:413
>   nldev_newlink+0x38e/0x660 drivers/infiniband/core/nldev.c:1795
>   rdma_nl_rcv_msg+0x388/0x6e0 drivers/infiniband/core/netlink.c:195
>   rdma_nl_rcv_skb.constprop.0.isra.0+0x2e6/0x450 drivers/infiniband/core/netlink.c:239
>   netlink_unicast_kernel net/netlink/af_netlink.c:1322 [inline]
>   netlink_unicast+0x53c/0x7f0 net/netlink/af_netlink.c:1348
>   netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1892
>   sock_sendmsg_nosec net/socket.c:718 [inline]
>   __sock_sendmsg net/socket.c:733 [inline]
>   ____sys_sendmsg+0xaaf/0xc90 net/socket.c:2573
>   ___sys_sendmsg+0x135/0x1e0 net/socket.c:2627
>   __sys_sendmsg+0x16e/0x220 net/socket.c:2659
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Freed by task 12485:
>   kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
>   kasan_save_track+0x14/0x30 mm/kasan/common.c:68
>   kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:576
>   poison_slab_object mm/kasan/common.c:247 [inline]
>   __kasan_slab_free+0x51/0x70 mm/kasan/common.c:264
>   kasan_slab_free include/linux/kasan.h:233 [inline]
>   slab_free_hook mm/slub.c:2353 [inline]
>   slab_free mm/slub.c:4609 [inline]
>   kfree+0x2c4/0x4d0 mm/slub.c:4757
>   kfree_const+0x55/0x60 mm/util.c:43
>   kobject_rename+0x179/0x260 lib/kobject.c:524
>   device_rename+0x130/0x230 drivers/base/core.c:4525
>   ib_device_rename+0x114/0x5c0 drivers/infiniband/core/device.c:402
>   nldev_set_doit+0x3be/0x4c0 drivers/infiniband/core/nldev.c:1146
>   rdma_nl_rcv_msg+0x388/0x6e0 drivers/infiniband/core/netlink.c:195
>   rdma_nl_rcv_skb.constprop.0.isra.0+0x2e6/0x450 drivers/infiniband/core/netlink.c:239
>   netlink_unicast_kernel net/netlink/af_netlink.c:1322 [inline]
>   netlink_unicast+0x53c/0x7f0 net/netlink/af_netlink.c:1348
>   netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1892
>   sock_sendmsg_nosec net/socket.c:718 [inline]
>   __sock_sendmsg net/socket.c:733 [inline]
>   ____sys_sendmsg+0xaaf/0xc90 net/socket.c:2573
>   ___sys_sendmsg+0x135/0x1e0 net/socket.c:2627
>   __sys_sendmsg+0x16e/0x220 net/socket.c:2659
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> The buggy address belongs to the object at ffff88803e895ea0
>   which belongs to the cache kmalloc-8 of size 8
> The buggy address is located 0 bytes inside of
>   freed 8-byte region [ffff88803e895ea0, ffff88803e895ea8)
> 
> The buggy address belongs to the physical page:
> page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x3e895
> flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
> page_type: f5(slab)
> raw: 00fff00000000000 ffff88801b042500 ffffea0000a05a00 dead000000000002
> raw: 0000000000000000 0000000000800080 00000000f5000000 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 11986, tgid 11985 (syz.1.1513), ts 150711065425, free_ts 150704805794
>   set_page_owner include/linux/page_owner.h:32 [inline]
>   post_alloc_hook+0x181/0x1b0 mm/page_alloc.c:1551
>   prep_new_page mm/page_alloc.c:1559 [inline]
>   get_page_from_freelist+0xfce/0x2f80 mm/page_alloc.c:3477
>   __alloc_frozen_pages_noprof+0x221/0x2470 mm/page_alloc.c:4739
>   alloc_pages_mpol+0x1fc/0x540 mm/mempolicy.c:2270
>   alloc_slab_page mm/slub.c:2423 [inline]
>   allocate_slab mm/slub.c:2587 [inline]
>   new_slab+0x23d/0x330 mm/slub.c:2640
>   ___slab_alloc+0xc5d/0x1720 mm/slub.c:3826
>   __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3916
>   __slab_alloc_node mm/slub.c:3991 [inline]
>   slab_alloc_node mm/slub.c:4152 [inline]
>   __do_kmalloc_node mm/slub.c:4293 [inline]
>   __kmalloc_node_noprof+0x2f0/0x510 mm/slub.c:4300
>   __kvmalloc_node_noprof+0xad/0x1a0 mm/util.c:662
>   kvmalloc_array_node_noprof include/linux/slab.h:1063 [inline]
>   __ptr_ring_init_queue_alloc_noprof include/linux/ptr_ring.h:471 [inline]
>   ptr_ring_resize_multiple_bh_noprof include/linux/ptr_ring.h:634 [inline]
>   skb_array_resize_multiple_bh_noprof include/linux/skb_array.h:208 [inline]
>   pfifo_fast_change_tx_queue_len+0x157/0xbb0 net/sched/sch_generic.c:909
>   qdisc_change_tx_queue_len net/sched/sch_generic.c:1410 [inline]
>   dev_qdisc_change_tx_queue_len+0x166/0x380 net/sched/sch_generic.c:1457
>   dev_change_tx_queue_len+0x1a3/0x1e0 net/core/dev.c:9362
>   dev_ifsioc+0xdfe/0x10d0 net/core/dev_ioctl.c:608
>   dev_ioctl+0x224/0x10c0 net/core/dev_ioctl.c:826
>   sock_do_ioctl+0x19e/0x280 net/socket.c:1213
>   sock_ioctl+0x228/0x6c0 net/socket.c:1318
> page last free pid 11986 tgid 11985 stack trace:
>   reset_page_owner include/linux/page_owner.h:25 [inline]
>   free_pages_prepare mm/page_alloc.c:1127 [inline]
>   free_frozen_pages+0x6db/0xfb0 mm/page_alloc.c:2660
>   __put_partials+0x14c/0x170 mm/slub.c:3153
>   qlink_free mm/kasan/quarantine.c:163 [inline]
>   qlist_free_all+0x4e/0x120 mm/kasan/quarantine.c:179
>   kasan_quarantine_reduce+0x195/0x1e0 mm/kasan/quarantine.c:286
>   __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:329
>   kasan_slab_alloc include/linux/kasan.h:250 [inline]
>   slab_post_alloc_hook mm/slub.c:4115 [inline]
>   slab_alloc_node mm/slub.c:4164 [inline]
>   __kmalloc_cache_noprof+0x243/0x410 mm/slub.c:4320
>   kmalloc_noprof include/linux/slab.h:901 [inline]
>   kmalloc_array_noprof include/linux/slab.h:945 [inline]
>   ptr_ring_resize_multiple_bh_noprof include/linux/ptr_ring.h:629 [inline]
>   skb_array_resize_multiple_bh_noprof include/linux/skb_array.h:208 [inline]
>   pfifo_fast_change_tx_queue_len+0xe1/0xbb0 net/sched/sch_generic.c:909
>   qdisc_change_tx_queue_len net/sched/sch_generic.c:1410 [inline]
>   dev_qdisc_change_tx_queue_len+0x166/0x380 net/sched/sch_generic.c:1457
>   dev_change_tx_queue_len+0x1a3/0x1e0 net/core/dev.c:9362
>   dev_ifsioc+0xdfe/0x10d0 net/core/dev_ioctl.c:608
>   dev_ioctl+0x224/0x10c0 net/core/dev_ioctl.c:826
>   sock_do_ioctl+0x19e/0x280 net/socket.c:1213
>   sock_ioctl+0x228/0x6c0 net/socket.c:1318
>   vfs_ioctl fs/ioctl.c:51 [inline]
>   __do_sys_ioctl fs/ioctl.c:906 [inline]
>   __se_sys_ioctl fs/ioctl.c:892 [inline]
>   __x64_sys_ioctl+0x190/0x200 fs/ioctl.c:892
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Memory state around the buggy address:
>   ffff88803e895d80: 05 fc fc fc fa fc fc fc 05 fc fc fc fa fc fc fc
>   ffff88803e895e00: 05 fc fc fc 00 fc fc fc 05 fc fc fc fa fc fc fc
>> ffff88803e895e80: 05 fc fc fc fa fc fc fc 05 fc fc fc 00 fc fc fc
>                                 ^
>   ffff88803e895f00: 05 fc fc fc 05 fc fc fc 05 fc fc fc fa fc fc fc
>   ffff88803e895f80: 05 fc fc fc 00 fc fc fc 05 fc fc fc fa fc fc fc
> ==================================================================
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup


