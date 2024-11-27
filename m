Return-Path: <linux-rdma+bounces-6122-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1089DA513
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Nov 2024 10:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D0FA162584
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Nov 2024 09:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4F41946A8;
	Wed, 27 Nov 2024 09:48:34 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E4218C34B
	for <linux-rdma@vger.kernel.org>; Wed, 27 Nov 2024 09:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732700914; cv=none; b=iW+fiJkUL4W0W3rDTOnm9lln0GNkO8Gp4FOe4rUVFtcyehf6cVrh4QmD1wwmNn+fxQSquhDRqwUBCpF5IIY3Fvh/GMHopn25hldW9krZNK9oki8gDq4kgLPAZCBzisQMWDbElqDMV65xB5sHzHPsHq/K+RYkOMMhJvzTjX4KGk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732700914; c=relaxed/simple;
	bh=8m1tbHzLnfh419lvtgMgepDFyedekr9gLhex66JHS1Y=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=VNw4wPRonyhwwDX/IfiRWHaZfDKnqMqWdaYHRythPBO3kJqKByu6YXWNSJl58x4I/6uBJpKmj8zQFauPZXoOADGeJzg6PzODRbYM8IJbQyWa9S8SE9k3ul7b8wm1jVYqFSaTBtS3zant4u6OycDUu2JQKJmmsY1ABK8B7m+S/DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-8418307b4f9so359047739f.1
        for <linux-rdma@vger.kernel.org>; Wed, 27 Nov 2024 01:48:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732700911; x=1733305711;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0M3f7bGnYYHqNGnmT8wEqlX0KESHBPKOvZhRJAdXgm4=;
        b=E8dTnFQe63GUZrwC9aFqglVbl1HOsJ7tofYj/J7LAeK0zs2doKIveLcUT2299lEnWD
         Pr8msZlr7kNH+KRs0kcNSJKRknQ1q/UqyuYh+pCVKptyzHWfQsCLKhUhWsguV0iRVwgG
         LV6tmXsot/YAtC7p4CIH08qnmDki3GgnRt/tf7s0UkTmydHFZgZvY8xL8YdAeeCVKGO4
         iJ199y5rMr8yc5iz1nrRn0wXG5h27kpIR2lcp1SfvZvsfUgiW0ZrRZDuqkJ28uSrsHZb
         i78KkmLsELZEJF5YRjZbkiLyzPgqG6nX8tAGzUJvZQkmrgvFoUMffG2DTxBzpd43HFYn
         pBtA==
X-Forwarded-Encrypted: i=1; AJvYcCUuPzzR/sGz5DwiKCSoVspAt8MGe0ncu4Ad6XiBZN0TAwT5D0sLDCC2qowMDVcM4qj4xlQBk/eOYx9w@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4uSJPpvy9u45NvyYSDNy3nZ+8IYrB/OfnygXlvfn8i4+DuoU1
	0k+nNsJ5P6PIco0g6PR04y0lQOX+5RcgLW4ClzvRupL9VJUM7NhDL7H2frroMANjNKV++EiRUU4
	F6iUQvN/NQuSZedoPbtN45Kly4wTNw7FlQJxaTgP71Pm8aJzJo7XC80Q=
X-Google-Smtp-Source: AGHT+IFdSoyRTBT1hw9YbxXlzKY281vKnhmUoFRMMgt/YzQZr+xrtNekYM7VCU5MQc/09Wu44AjevTHTntVs2Q69jIYz/Ni9wlin
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4410:10b0:3a7:bc2a:2522 with SMTP id
 e9e14a558f8ab-3a7c5540a68mr14272945ab.7.1732700911769; Wed, 27 Nov 2024
 01:48:31 -0800 (PST)
Date: Wed, 27 Nov 2024 01:48:31 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6746eaef.050a0220.21d33d.0021.GAE@google.com>
Subject: [syzbot] [rdma?] KASAN: slab-use-after-free Read in siw_query_port (2)
From: syzbot <syzbot+67a887427af54ecb7c93@syzkaller.appspotmail.com>
To: bmt@zurich.ibm.com, jgg@ziepe.ca, leon@kernel.org, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5d066766c5f1 net/l2tp: fix warning in l2tp_exit_net found ..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=168e8dc0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=83e9a7f9e94ea674
dashboard link: https://syzkaller.appspot.com/bug?extid=67a887427af54ecb7c93
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11355530580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ba9b7c97759c/disk-5d066766.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/92a30584a5ad/vmlinux-5d066766.xz
kernel image: https://storage.googleapis.com/syzbot-assets/88d717deaf07/bzImage-5d066766.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+67a887427af54ecb7c93@syzkaller.appspotmail.com

xfrm0 speed is unknown, defaulting to 1000
==================================================================
BUG: KASAN: slab-use-after-free in siw_query_port+0x348/0x440 drivers/infiniband/sw/siw/siw_verbs.c:183
Read of size 4 at addr ffff88802ff88038 by task kworker/0:5/5883

CPU: 0 UID: 0 PID: 5883 Comm: kworker/0:5 Not tainted 6.12.0-syzkaller-05491-g5d066766c5f1 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: infiniband ib_cache_event_task
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 siw_query_port+0x348/0x440 drivers/infiniband/sw/siw/siw_verbs.c:183
 ib_cache_update+0x1a9/0xb80 drivers/infiniband/core/cache.c:1494
 ib_cache_event_task+0xf3/0x1e0 drivers/infiniband/core/cache.c:1568
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 10564:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:257 [inline]
 __do_kmalloc_node mm/slub.c:4264 [inline]
 __kmalloc_node_noprof+0x22a/0x440 mm/slub.c:4270
 __kvmalloc_node_noprof+0x72/0x190 mm/util.c:658
 alloc_netdev_mqs+0xa4/0x1080 net/core/dev.c:11203
 rtnl_create_link+0x2f9/0xc20 net/core/rtnetlink.c:3595
 rtnl_newlink_create+0x210/0xa30 net/core/rtnetlink.c:3770
 __rtnl_newlink net/core/rtnetlink.c:3897 [inline]
 rtnl_newlink+0x17dd/0x24f0 net/core/rtnetlink.c:4007
 rtnetlink_rcv_msg+0x791/0xcf0 net/core/rtnetlink.c:6917
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2542
 netlink_unicast_kernel net/netlink/af_netlink.c:1321 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1347
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1891
 sock_sendmsg_nosec net/socket.c:711 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:726
 __sys_sendto+0x363/0x4c0 net/socket.c:2197
 __do_sys_sendto net/socket.c:2204 [inline]
 __se_sys_sendto net/socket.c:2200 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2200
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 35:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:230 [inline]
 slab_free_hook mm/slub.c:2342 [inline]
 slab_free mm/slub.c:4579 [inline]
 kfree+0x1a0/0x440 mm/slub.c:4727
 device_release+0x99/0x1c0
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x22f/0x480 lib/kobject.c:737
 netdev_run_todo+0xe79/0x1000 net/core/dev.c:10918
 cleanup_net+0x762/0xcc0 net/core/net_namespace.c:628
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

The buggy address belongs to the object at ffff88802ff88000
 which belongs to the cache kmalloc-cg-4k of size 4096
The buggy address is located 56 bytes inside of
 freed 4096-byte region [ffff88802ff88000, ffff88802ff89000)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2ff88
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff888031975541
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801b04f500 ffffea0001f8f800 dead000000000002
raw: 0000000000000000 0000000000040004 00000001f5000000 ffff888031975541
head: 00fff00000000040 ffff88801b04f500 ffffea0001f8f800 dead000000000002
head: 0000000000000000 0000000000040004 00000001f5000000 ffff888031975541
head: 00fff00000000003 ffffea0000bfe201 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 7294, tgid 7294 (udevd), ts 104300491113, free_ts 104288279948
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
 prep_new_page mm/page_alloc.c:1564 [inline]
 get_page_from_freelist+0x3649/0x3790 mm/page_alloc.c:3474
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4751
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 alloc_slab_page+0x6a/0x140 mm/slub.c:2412
 allocate_slab+0x5a/0x2f0 mm/slub.c:2578
 new_slab mm/slub.c:2631 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3818
 __slab_alloc+0x58/0xa0 mm/slub.c:3908
 __slab_alloc_node mm/slub.c:3961 [inline]
 slab_alloc_node mm/slub.c:4122 [inline]
 __do_kmalloc_node mm/slub.c:4263 [inline]
 __kmalloc_node_noprof+0x286/0x440 mm/slub.c:4270
 __kvmalloc_node_noprof+0x72/0x190 mm/util.c:658
 seq_buf_alloc fs/seq_file.c:38 [inline]
 seq_read_iter+0x20c/0xd70 fs/seq_file.c:210
 new_sync_read fs/read_write.c:484 [inline]
 vfs_read+0x991/0xb70 fs/read_write.c:565
 ksys_read+0x18f/0x2b0 fs/read_write.c:708
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 7342 tgid 7342 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_page+0xdf9/0x1140 mm/page_alloc.c:2657
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
 kmem_cache_alloc_lru_noprof+0x139/0x2b0 mm/slub.c:4153
 sock_alloc_inode+0x28/0xc0 net/socket.c:307
 alloc_inode+0x65/0x1a0 fs/inode.c:336
 sock_alloc net/socket.c:615 [inline]
 __sock_create+0x127/0xa30 net/socket.c:1522
 sock_create net/socket.c:1616 [inline]
 __sys_socket_create net/socket.c:1653 [inline]
 __sys_socket+0x150/0x3c0 net/socket.c:1700
 __do_sys_socket net/socket.c:1714 [inline]
 __se_sys_socket net/socket.c:1712 [inline]
 __x64_sys_socket+0x7a/0x90 net/socket.c:1712
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88802ff87f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88802ff87f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88802ff88000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                        ^
 ffff88802ff88080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802ff88100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

