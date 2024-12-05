Return-Path: <linux-rdma+bounces-6310-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 073CC9E5F48
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Dec 2024 21:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BC7B18843BB
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Dec 2024 20:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41A522F393;
	Thu,  5 Dec 2024 20:11:28 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB0522F380
	for <linux-rdma@vger.kernel.org>; Thu,  5 Dec 2024 20:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733429488; cv=none; b=ItKIuu5o3oi8Lcn4tR4+zQykZk3GYxpC+UlDYY+mt1dwDw3kxxLpIexbevLkS3q7tACyERHVdrfXGcNK0ffO0iFNwdGNMR3aUPfbaED4AGEi1zM5k1M96Tb75AyAIXD4KwX6cHZBdTBuaPZ2er+BAcM9vWw5d5Jaj9Yqk4rDcWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733429488; c=relaxed/simple;
	bh=xnl/vkrVNvEHO1zMq0ENj1hOu2p4yT/hjORcMzI0+cw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MseqS0SsYKN2Bb/NCzjEZDyP61H3997opcF2eVbl2ltpOaqIO4DTwFoSw07AOkFYGmYG9cLLM7FrBRZ90ep3VCPQwlOgfe50bMvAWn+xXoJWolqKJZngRDxodGT6Shz45nhuBCAe2Zs6gu0exT85RxIlDLAvzikgsrow6w9VNNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3a79afe7a0bso25537385ab.3
        for <linux-rdma@vger.kernel.org>; Thu, 05 Dec 2024 12:11:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733429485; x=1734034285;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JDgylDJ1ApPH3NGmRv/2GqHQIXhYGdp2AXkmFSpAsco=;
        b=kc6k1WXpOF5KmBEDuN2SZbOt812PDtdP4U+E8+LV16P4zcsn1PWIT+UxW7aIRjFM5U
         G1ZA2jmdugi2VQd43dTit81YnuW/ALdaSPguZeSQnTsUXQ9Uy7IYCg1RJESsKBysN8ro
         v6WTqWW4OEWNwnkpjdkTCn5lAvJquIdx5JKtv4ECnjhaEVR/gkoc9Wydx8m6wcdzfHs/
         tFjsCT3vLJzE9umgcQyap09p6a8JUwg8q0K4jCn42CMaqP7R2/g8hWtt4VyqjR5u2ypv
         1seq3xo3G+tFx371WXYX9nnh/QrtHKfqpapgC7MR1sa0excQzATha9xHLg32MSqp62ao
         o7EQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTRXUnnnophOko6XoOjCagyP9PPvDAJ1B354nqc2Z08lyRXYetf7rpOu+2KzEuVGSDwvo9Gw4he9iU@vger.kernel.org
X-Gm-Message-State: AOJu0YwMY2IZnVIiXbQhYZRKif2fMwAzDOg3oC1eqpUZAbgi7z93mSwG
	JAUZebSMuw8GlqZcp4Yf30c1812Bk+Yntt5JUR4spay39dp39g/2cdK/jloIOOzj7JP+Qvp1wxG
	wFgCr1V+DBtPvTN83fI/4x7PQVIWaUnmVACH+HjNubynpdEDB9O/MIRI=
X-Google-Smtp-Source: AGHT+IFffCfIMBHTeBkohMEh++gdfkEO0q8Efpuw8d2UoacUCNUCCmM7m005ksncu6TMhyXAXBsLicbk7eIk9eKGexnS6DMbSMLk
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c249:0:b0:3a7:81a4:a54d with SMTP id
 e9e14a558f8ab-3a811e03752mr9037405ab.20.1733429484895; Thu, 05 Dec 2024
 12:11:24 -0800 (PST)
Date: Thu, 05 Dec 2024 12:11:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675208ec.050a0220.b4160.01e5.GAE@google.com>
Subject: [syzbot] [rdma?] KASAN: slab-use-after-free Read in dev_get_flags
From: syzbot <syzbot+4b87489410b4efd181bf@syzkaller.appspotmail.com>
To: jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, zyjzyj2000@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9197b73fd7bb Merge tag '9p-for-6.12-rc4' of https://github..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12e7025f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=16e543edc81a3008
dashboard link: https://syzkaller.appspot.com/bug?extid=4b87489410b4efd181bf
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6c07256fc575/disk-9197b73f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9f64355d92f7/vmlinux-9197b73f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c402fba0b938/bzImage-9197b73f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4b87489410b4efd181bf@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in dev_get_flags+0x188/0x1d0 net/core/dev.c:8782
Read of size 4 at addr ffff8880554640b0 by task kworker/1:4/5295

CPU: 1 UID: 0 PID: 5295 Comm: kworker/1:4 Not tainted 6.12.0-rc3-syzkaller-00399-g9197b73fd7bb #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: infiniband ib_cache_event_task
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 dev_get_flags+0x188/0x1d0 net/core/dev.c:8782
 rxe_query_port+0x12d/0x260 drivers/infiniband/sw/rxe/rxe_verbs.c:60
 __ib_query_port drivers/infiniband/core/device.c:2111 [inline]
 ib_query_port+0x168/0x7d0 drivers/infiniband/core/device.c:2143
 ib_cache_update+0x1a9/0xb80 drivers/infiniband/core/cache.c:1494
 ib_cache_event_task+0xf3/0x1e0 drivers/infiniband/core/cache.c:1568
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa65/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 10264:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:257 [inline]
 __do_kmalloc_node mm/slub.c:4264 [inline]
 __kmalloc_node_noprof+0x22a/0x440 mm/slub.c:4270
 __kvmalloc_node_noprof+0x72/0x190 mm/util.c:658
 alloc_netdev_mqs+0x9b/0x1000 net/core/dev.c:11097
 rtnl_create_link+0x2f9/0xc20 net/core/rtnetlink.c:3403
 veth_newlink+0x2c5/0xce0 drivers/net/veth.c:1815
 rtnl_newlink_create net/core/rtnetlink.c:3539 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3759 [inline]
 rtnl_newlink+0x1593/0x20a0 net/core/rtnetlink.c:3772
 rtnetlink_rcv_msg+0x741/0xcf0 net/core/rtnetlink.c:6675
 netlink_rcv_skb+0x1e5/0x430 net/netlink/af_netlink.c:2551
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7f8/0x990 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:729 [inline]
 __sock_sendmsg+0x223/0x270 net/socket.c:744
 __sys_sendto+0x39b/0x4f0 net/socket.c:2214
 __do_sys_sendto net/socket.c:2226 [inline]
 __se_sys_sendto net/socket.c:2222 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2222
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 930:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:230 [inline]
 slab_free_hook mm/slub.c:2342 [inline]
 slab_free mm/slub.c:4579 [inline]
 kfree+0x1a0/0x440 mm/slub.c:4727
 device_release+0x9b/0x1c0
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x231/0x480 lib/kobject.c:737
 netdev_run_todo+0xe79/0x1000 net/core/dev.c:10816
 default_device_exit_batch+0xa24/0xaa0 net/core/dev.c:11949
 ops_exit_list net/core/net_namespace.c:178 [inline]
 cleanup_net+0x89f/0xcc0 net/core/net_namespace.c:626
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa65/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

The buggy address belongs to the object at ffff888055464000
 which belongs to the cache kmalloc-cg-4k of size 4096
The buggy address is located 176 bytes inside of
 freed 4096-byte region [ffff888055464000, ffff888055465000)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff888055462000 pfn:0x55460
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff88805f4cbd01
flags: 0xfff00000000240(workingset|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000240 ffff88801ac4f500 ffffea0000e93610 ffffea0001b0de10
raw: ffff888055462000 0000000000040001 00000001f5000000 ffff88805f4cbd01
head: 00fff00000000240 ffff88801ac4f500 ffffea0000e93610 ffffea0001b0de10
head: ffff888055462000 0000000000040001 00000001f5000000 ffff88805f4cbd01
head: 00fff00000000003 ffffea0001551801 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd60c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_RETRY_MAYFAIL|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 6569, tgid 6569 (syz-executor), ts 312665355465, free_ts 312602647734
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1545 [inline]
 get_page_from_freelist+0x3045/0x3190 mm/page_alloc.c:3457
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4733
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 alloc_slab_page+0x6a/0x120 mm/slub.c:2412
 allocate_slab+0x5a/0x2f0 mm/slub.c:2578
 new_slab mm/slub.c:2631 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3818
 __slab_alloc+0x58/0xa0 mm/slub.c:3908
 __slab_alloc_node mm/slub.c:3961 [inline]
 slab_alloc_node mm/slub.c:4122 [inline]
 __do_kmalloc_node mm/slub.c:4263 [inline]
 __kmalloc_node_noprof+0x286/0x440 mm/slub.c:4270
 __kvmalloc_node_noprof+0x72/0x190 mm/util.c:658
 alloc_netdev_mqs+0x9b/0x1000 net/core/dev.c:11097
 vti6_init_net+0x104/0x2f0 net/ipv6/ip6_vti.c:1143
 ops_init+0x320/0x590 net/core/net_namespace.c:139
 setup_net+0x287/0x9e0 net/core/net_namespace.c:356
 copy_net_ns+0x33f/0x570 net/core/net_namespace.c:494
 create_new_namespaces+0x425/0x7b0 kernel/nsproxy.c:110
page last free pid 6543 tgid 6543 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_page+0xcfb/0xf20 mm/page_alloc.c:2638
 discard_slab mm/slub.c:2677 [inline]
 __put_partials+0xeb/0x130 mm/slub.c:3145
 put_cpu_partial+0x17c/0x250 mm/slub.c:3220
 __slab_free+0x2ea/0x3d0 mm/slub.c:4449
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:247 [inline]
 slab_post_alloc_hook mm/slub.c:4085 [inline]
 slab_alloc_node mm/slub.c:4134 [inline]
 __kmalloc_cache_noprof+0x132/0x2c0 mm/slub.c:4290
 kmalloc_noprof include/linux/slab.h:878 [inline]
 kzalloc_noprof include/linux/slab.h:1014 [inline]
 ref_tracker_alloc+0x14b/0x490 lib/ref_tracker.c:203
 __netdev_tracker_alloc include/linux/netdevice.h:4050 [inline]
 netdev_hold include/linux/netdevice.h:4079 [inline]
 netdev_queue_add_kobject net/core/net-sysfs.c:1786 [inline]
 netdev_queue_update_kobjects+0x181/0x550 net/core/net-sysfs.c:1841
 register_queue_kobjects net/core/net-sysfs.c:1903 [inline]
 netdev_register_kobject+0x265/0x310 net/core/net-sysfs.c:2143
 register_netdevice+0x12c5/0x1b00 net/core/dev.c:10491
 rtnl_newlink_create net/core/rtnetlink.c:3541 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3759 [inline]
 rtnl_newlink+0x1728/0x20a0 net/core/rtnetlink.c:3772
 rtnetlink_rcv_msg+0x741/0xcf0 net/core/rtnetlink.c:6675
 netlink_rcv_skb+0x1e5/0x430 net/netlink/af_netlink.c:2551
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7f8/0x990 net/netlink/af_netlink.c:1357

Memory state around the buggy address:
 ffff888055463f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888055464000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888055464080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                     ^
 ffff888055464100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888055464180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

