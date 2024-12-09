Return-Path: <linux-rdma+bounces-6333-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B879E9687
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Dec 2024 14:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63B55282474
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Dec 2024 13:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0D61BEF70;
	Mon,  9 Dec 2024 13:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IxDSiINT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D501A23B6
	for <linux-rdma@vger.kernel.org>; Mon,  9 Dec 2024 13:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733750346; cv=none; b=MiYWV1/htmANkSI9eH5AEiO9mbtFz5DNZ24yWniUP82WXek1wXuC7THt6JlouSGr9cTT3VIEHt2ylivNiZHIKskolOg0/N/qYGp5lwIcNJ/aOW8ZPNVDLZXplGpgV40MrF/zChEkvs6gBSjP+8UoBK3GwPUyryUwXYofxUv/2bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733750346; c=relaxed/simple;
	bh=A3wgN6Kmf6nysCbtsRq8SLu5j1mjOVVTat/bA/hL3Iw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ezF+8l8DQ3bgA9DCQEEdRY0Fj5fxzQXg3q6Z2d9zQb6M/0l6E51pcwGuYD20u8h0XdEX0dNCLNzshlLf+Fn0K6JtVJXxl08A/x0boiXFuqTvtEDmNOjexkZzwY+1C6UtEBqXBewXOP8R7s6Z7k6gu+w+eYALL8bp3IXg4v7A17g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IxDSiINT; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0b1bf937-04ef-4fd6-9f7d-932ca4bb60ed@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733750340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+9vU5x+vixUCgPHKQ5xe9vKto7LbAeiDlpG2wHBeXVs=;
	b=IxDSiINT/JaoV6zRcTllXVGxB/i4qM8hSFG/aXEme6Id4Y6dDESBzsMNPE7BnQFR0OovSf
	jvPMkHYRnJ4Fp/4ycLmzcxXry2H+gB/cYLdjPde6CEkg2PwPis8qqR5pIKU26ZE6Nk69bj
	io3OZWXxHOWHzVr63ZtxprnFrMFSYTg=
Date: Mon, 9 Dec 2024 14:18:55 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [syzbot] [rdma?] KASAN: slab-use-after-free Read in dev_get_flags
To: syzbot <syzbot+4b87489410b4efd181bf@syzkaller.appspotmail.com>,
 jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, zyjzyj2000@gmail.com
References: <675208ec.050a0220.b4160.01e5.GAE@google.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <675208ec.050a0220.b4160.01e5.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 05.12.24 21:11, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    9197b73fd7bb Merge tag '9p-for-6.12-rc4' of https://github..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=12e7025f980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=16e543edc81a3008
> dashboard link: https://syzkaller.appspot.com/bug?extid=4b87489410b4efd181bf
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/6c07256fc575/disk-9197b73f.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/9f64355d92f7/vmlinux-9197b73f.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/c402fba0b938/bzImage-9197b73f.xz
> 

 From the following Call Trace, I assume that the test is based on net 
namespace based on this "create_new_namespaces+0x425/0x7b0 
kernel/nsproxy.c:110".
And the netdev is veth based on this "veth_newlink+0x2c5/0xce0 
drivers/net/veth.c:1815".
Then rxe is created based on veth based on this "[  839.350575][  T930] 
infiniband syz2: set down" in the link 
https://syzkaller.appspot.com/x/log.txt?x=12e7025f980000.

Because rxe can not work well with net namespace without the patchset 
"https://patchwork.kernel.org/project/linux-rdma/cover/20230624073927.707915-1-yanjun.zhu@intel.com/", 
it should be the root cause of this problem.

When I delved into this problem, I found the following timeline.
1). In the link https://syzkaller.appspot.com/x/log.txt?x=12e7025f980000,

"
[  839.350575][  T930] infiniband syz2: set down
"

This means that on 839.350575, the event ib_cache_event_task was sent 
and queued in ib_wq.

2). In the link https://syzkaller.appspot.com/x/log.txt?x=12e7025f980000,

"
[  843.251853][  T930] team0 (unregistering): Port device team_slave_0 
removed
"

It indicates that before 843.251853, T930 should free veth.

3). In the link https://syzkaller.appspot.com/x/log.txt?x=12e7025f980000,

"
[  850.559070][ T5295] BUG: KASAN: slab-use-after-free in 
dev_get_flags+0x188/0x1d0
"
This means that on 850.559070, this slab-use-after-free occured.

In all, on 839.350575, the event ib_cache_event_task was sent and queued 
in ib_wq, on 850.559070, this event was executed.

And before 843.251853, the netdev veth was freed by T930.

The above should be the direct reason of this problem.

It is interesting that an event was queued in ib_wq for so long time.
Need more information to find out why.

If I am missing something, please feel free to let me know.

Zhu Yanjun

> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+4b87489410b4efd181bf@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KASAN: slab-use-after-free in dev_get_flags+0x188/0x1d0 net/core/dev.c:8782
> Read of size 4 at addr ffff8880554640b0 by task kworker/1:4/5295
> 
> CPU: 1 UID: 0 PID: 5295 Comm: kworker/1:4 Not tainted 6.12.0-rc3-syzkaller-00399-g9197b73fd7bb #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> Workqueue: infiniband ib_cache_event_task
> Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:94 [inline]
>   dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>   print_address_description mm/kasan/report.c:377 [inline]
>   print_report+0x169/0x550 mm/kasan/report.c:488
>   kasan_report+0x143/0x180 mm/kasan/report.c:601
>   dev_get_flags+0x188/0x1d0 net/core/dev.c:8782
>   rxe_query_port+0x12d/0x260 drivers/infiniband/sw/rxe/rxe_verbs.c:60
>   __ib_query_port drivers/infiniband/core/device.c:2111 [inline]
>   ib_query_port+0x168/0x7d0 drivers/infiniband/core/device.c:2143
>   ib_cache_update+0x1a9/0xb80 drivers/infiniband/core/cache.c:1494
>   ib_cache_event_task+0xf3/0x1e0 drivers/infiniband/core/cache.c:1568
>   process_one_work kernel/workqueue.c:3229 [inline]
>   process_scheduled_works+0xa65/0x1850 kernel/workqueue.c:3310
>   worker_thread+0x870/0xd30 kernel/workqueue.c:3391
>   kthread+0x2f2/0x390 kernel/kthread.c:389
>   ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>   </TASK>
> 
> Allocated by task 10264:
>   kasan_save_stack mm/kasan/common.c:47 [inline]
>   kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>   poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
>   __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
>   kasan_kmalloc include/linux/kasan.h:257 [inline]
>   __do_kmalloc_node mm/slub.c:4264 [inline]
>   __kmalloc_node_noprof+0x22a/0x440 mm/slub.c:4270
>   __kvmalloc_node_noprof+0x72/0x190 mm/util.c:658
>   alloc_netdev_mqs+0x9b/0x1000 net/core/dev.c:11097
>   rtnl_create_link+0x2f9/0xc20 net/core/rtnetlink.c:3403
>   veth_newlink+0x2c5/0xce0 drivers/net/veth.c:1815
>   rtnl_newlink_create net/core/rtnetlink.c:3539 [inline]
>   __rtnl_newlink net/core/rtnetlink.c:3759 [inline]
>   rtnl_newlink+0x1593/0x20a0 net/core/rtnetlink.c:3772
>   rtnetlink_rcv_msg+0x741/0xcf0 net/core/rtnetlink.c:6675
>   netlink_rcv_skb+0x1e5/0x430 net/netlink/af_netlink.c:2551
>   netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
>   netlink_unicast+0x7f8/0x990 net/netlink/af_netlink.c:1357
>   netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
>   sock_sendmsg_nosec net/socket.c:729 [inline]
>   __sock_sendmsg+0x223/0x270 net/socket.c:744
>   __sys_sendto+0x39b/0x4f0 net/socket.c:2214
>   __do_sys_sendto net/socket.c:2226 [inline]
>   __se_sys_sendto net/socket.c:2222 [inline]
>   __x64_sys_sendto+0xde/0x100 net/socket.c:2222
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Freed by task 930:
>   kasan_save_stack mm/kasan/common.c:47 [inline]
>   kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>   kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
>   poison_slab_object mm/kasan/common.c:247 [inline]
>   __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
>   kasan_slab_free include/linux/kasan.h:230 [inline]
>   slab_free_hook mm/slub.c:2342 [inline]
>   slab_free mm/slub.c:4579 [inline]
>   kfree+0x1a0/0x440 mm/slub.c:4727
>   device_release+0x9b/0x1c0
>   kobject_cleanup lib/kobject.c:689 [inline]
>   kobject_release lib/kobject.c:720 [inline]
>   kref_put include/linux/kref.h:65 [inline]
>   kobject_put+0x231/0x480 lib/kobject.c:737
>   netdev_run_todo+0xe79/0x1000 net/core/dev.c:10816
>   default_device_exit_batch+0xa24/0xaa0 net/core/dev.c:11949
>   ops_exit_list net/core/net_namespace.c:178 [inline]
>   cleanup_net+0x89f/0xcc0 net/core/net_namespace.c:626
>   process_one_work kernel/workqueue.c:3229 [inline]
>   process_scheduled_works+0xa65/0x1850 kernel/workqueue.c:3310
>   worker_thread+0x870/0xd30 kernel/workqueue.c:3391
>   kthread+0x2f2/0x390 kernel/kthread.c:389
>   ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> 
> The buggy address belongs to the object at ffff888055464000
>   which belongs to the cache kmalloc-cg-4k of size 4096
> The buggy address is located 176 bytes inside of
>   freed 4096-byte region [ffff888055464000, ffff888055465000)
> 
> The buggy address belongs to the physical page:
> page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff888055462000 pfn:0x55460
> head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> memcg:ffff88805f4cbd01
> flags: 0xfff00000000240(workingset|head|node=0|zone=1|lastcpupid=0x7ff)
> page_type: f5(slab)
> raw: 00fff00000000240 ffff88801ac4f500 ffffea0000e93610 ffffea0001b0de10
> raw: ffff888055462000 0000000000040001 00000001f5000000 ffff88805f4cbd01
> head: 00fff00000000240 ffff88801ac4f500 ffffea0000e93610 ffffea0001b0de10
> head: ffff888055462000 0000000000040001 00000001f5000000 ffff88805f4cbd01
> head: 00fff00000000003 ffffea0001551801 ffffffffffffffff 0000000000000000
> head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd60c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_RETRY_MAYFAIL|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 6569, tgid 6569 (syz-executor), ts 312665355465, free_ts 312602647734
>   set_page_owner include/linux/page_owner.h:32 [inline]
>   post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1537
>   prep_new_page mm/page_alloc.c:1545 [inline]
>   get_page_from_freelist+0x3045/0x3190 mm/page_alloc.c:3457
>   __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4733
>   alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
>   alloc_slab_page+0x6a/0x120 mm/slub.c:2412
>   allocate_slab+0x5a/0x2f0 mm/slub.c:2578
>   new_slab mm/slub.c:2631 [inline]
>   ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3818
>   __slab_alloc+0x58/0xa0 mm/slub.c:3908
>   __slab_alloc_node mm/slub.c:3961 [inline]
>   slab_alloc_node mm/slub.c:4122 [inline]
>   __do_kmalloc_node mm/slub.c:4263 [inline]
>   __kmalloc_node_noprof+0x286/0x440 mm/slub.c:4270
>   __kvmalloc_node_noprof+0x72/0x190 mm/util.c:658
>   alloc_netdev_mqs+0x9b/0x1000 net/core/dev.c:11097
>   vti6_init_net+0x104/0x2f0 net/ipv6/ip6_vti.c:1143
>   ops_init+0x320/0x590 net/core/net_namespace.c:139
>   setup_net+0x287/0x9e0 net/core/net_namespace.c:356
>   copy_net_ns+0x33f/0x570 net/core/net_namespace.c:494
>   create_new_namespaces+0x425/0x7b0 kernel/nsproxy.c:110
> page last free pid 6543 tgid 6543 stack trace:
>   reset_page_owner include/linux/page_owner.h:25 [inline]
>   free_pages_prepare mm/page_alloc.c:1108 [inline]
>   free_unref_page+0xcfb/0xf20 mm/page_alloc.c:2638
>   discard_slab mm/slub.c:2677 [inline]
>   __put_partials+0xeb/0x130 mm/slub.c:3145
>   put_cpu_partial+0x17c/0x250 mm/slub.c:3220
>   __slab_free+0x2ea/0x3d0 mm/slub.c:4449
>   qlink_free mm/kasan/quarantine.c:163 [inline]
>   qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
>   kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
>   __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:329
>   kasan_slab_alloc include/linux/kasan.h:247 [inline]
>   slab_post_alloc_hook mm/slub.c:4085 [inline]
>   slab_alloc_node mm/slub.c:4134 [inline]
>   __kmalloc_cache_noprof+0x132/0x2c0 mm/slub.c:4290
>   kmalloc_noprof include/linux/slab.h:878 [inline]
>   kzalloc_noprof include/linux/slab.h:1014 [inline]
>   ref_tracker_alloc+0x14b/0x490 lib/ref_tracker.c:203
>   __netdev_tracker_alloc include/linux/netdevice.h:4050 [inline]
>   netdev_hold include/linux/netdevice.h:4079 [inline]
>   netdev_queue_add_kobject net/core/net-sysfs.c:1786 [inline]
>   netdev_queue_update_kobjects+0x181/0x550 net/core/net-sysfs.c:1841
>   register_queue_kobjects net/core/net-sysfs.c:1903 [inline]
>   netdev_register_kobject+0x265/0x310 net/core/net-sysfs.c:2143
>   register_netdevice+0x12c5/0x1b00 net/core/dev.c:10491
>   rtnl_newlink_create net/core/rtnetlink.c:3541 [inline]
>   __rtnl_newlink net/core/rtnetlink.c:3759 [inline]
>   rtnl_newlink+0x1728/0x20a0 net/core/rtnetlink.c:3772
>   rtnetlink_rcv_msg+0x741/0xcf0 net/core/rtnetlink.c:6675
>   netlink_rcv_skb+0x1e5/0x430 net/netlink/af_netlink.c:2551
>   netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
>   netlink_unicast+0x7f8/0x990 net/netlink/af_netlink.c:1357
> 
> Memory state around the buggy address:
>   ffff888055463f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>   ffff888055464000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>> ffff888055464080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                                       ^
>   ffff888055464100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>   ffff888055464180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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


