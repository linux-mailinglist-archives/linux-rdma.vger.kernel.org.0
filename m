Return-Path: <linux-rdma+bounces-1100-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E451D860FD3
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Feb 2024 11:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98A062875D7
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Feb 2024 10:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8179763104;
	Fri, 23 Feb 2024 10:51:20 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5753657CB
	for <linux-rdma@vger.kernel.org>; Fri, 23 Feb 2024 10:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708685480; cv=none; b=aCzJVbf1as7YlZS2fgqbqR+JdZtZC3Spue1OKTjMNMeEQJ98+lJsi/BbfHb20tHp3qhwR03jlmGmFR41Des9exNLkwboMHTlNIreaE48WKGpulpXHFC5euDXi4EnC1OgE8erkeJU550FafuX9ACzYAS3c0Kz6oJt5+x0Cw3GEh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708685480; c=relaxed/simple;
	bh=Ktk+K3RM1+s5Zau8nZtGgxW+aknPpV9Fw7aMk0k4to8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=BnaguZqDx3/JaV0kru98GGLvKCKj+tFEIbM0PoiLLYaZ4rF491hVxl/WxW+EeDOEF56eDJHqnMm551i7eBYlcX3vl9X/jhRGDrE/wBt9rVZ9dNA2YM0ClYnzn2tzgS4vn2wlYbhD3OK5RM3TNYUFP/PAJJUvHuKjQEh/tROwusc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7c762422c94so68539439f.1
        for <linux-rdma@vger.kernel.org>; Fri, 23 Feb 2024 02:51:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708685478; x=1709290278;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wrKKtUWe+uw62A/Ajv7hv7s+0ZnYBxFq11mGIay4N6o=;
        b=BZrXwshYw+nJpDwyXKgxsfx9suazV1WY7ZrZdyPKBOum9/ylA3VoLKpF5aKaRoNHqG
         dA2Ooohlvuuuyn6W3MNAPG/sJdPwZyFrpyTqVM+4ZDKLRaHkb1HCBjSIZsJByIxySizl
         p//h3V5mX36YaiZqCaNX/XNOzwUC3uRHIoh5LTry9zdu2Z0PnuVoBr4+8DectgxW8Hjz
         2na41mo4ux1g25Lqi7Xqjp7INyN2f6xlVZ1ypTEbx/J6S0zaU3PRInYVVh/NqIsahzEb
         jmNNxmXCY/dCDVtuXihlhL4G3ftMn1Ch0sH2KnqddNJdKq6i5e+m6YrYZgu+YpAhVNwO
         40kQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQxXypnReazTDe3F5MsxxDqxbCaQAFGQByRFNMmIW9ai4B39SR2mntOHMVoR4pDSY7YUis+AaD+kxDz+c1L/O6qMWJwBrPDXRSHA==
X-Gm-Message-State: AOJu0YzE14smFZuvWYWrf8e7YBfLQ0qQGjoH3oF+XNdiJU6ergJSN+UP
	GGl5fJEgyXF2lOAETJU4D7uTPjbEa2l2kgnFyuihT2avWeGlm94uAYVK/D41X2wQdy7Dz8ihhyh
	HEzWPhphEkWW4587W0xHa+DHiUB+5q+/dJj6Ib424T2sy3n2g3uBs1Zs=
X-Google-Smtp-Source: AGHT+IGXnJHKf0+FyLxcdPYKGsmoCUQmRfVQkoIyR8qTj4+AuDgBu8TA1H4YeLy5RmLv+liJtCgoijVJzcb5/L09DH4iNwn3GScn
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a5d:8441:0:b0:7c7:9b0a:6f97 with SMTP id
 w1-20020a5d8441000000b007c79b0a6f97mr4698ior.1.1708685478063; Fri, 23 Feb
 2024 02:51:18 -0800 (PST)
Date: Fri, 23 Feb 2024 02:51:18 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f3f42f06120a5679@google.com>
Subject: [syzbot] [rdma?] KASAN: slab-use-after-free Read in rdma_resolve_route
From: syzbot <syzbot+a2e2735f09ebb9d95bd1@syzkaller.appspotmail.com>
To: jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2c3b09aac00d Add linux-next specific files for 20240214
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1793a064180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=176d2dcbf8ba7017
dashboard link: https://syzkaller.appspot.com/bug?extid=a2e2735f09ebb9d95bd1
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ac51042b61c6/disk-2c3b09aa.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/012344301c35/vmlinux-2c3b09aa.xz
kernel image: https://storage.googleapis.com/syzbot-assets/cba3c3e5cd7c/bzImage-2c3b09aa.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a2e2735f09ebb9d95bd1@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in compare_netdev_and_ip drivers/infiniband/core/cma.c:473 [inline]
BUG: KASAN: slab-use-after-free in cma_add_id_to_tree drivers/infiniband/core/cma.c:513 [inline]
BUG: KASAN: slab-use-after-free in rdma_resolve_route+0x23f7/0x3150 drivers/infiniband/core/cma.c:3379
Read of size 4 at addr ffff88808dcf6184 by task syz-executor.4/11929

CPU: 1 PID: 11929 Comm: syz-executor.4 Not tainted 6.8.0-rc4-next-20240214-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 compare_netdev_and_ip drivers/infiniband/core/cma.c:473 [inline]
 cma_add_id_to_tree drivers/infiniband/core/cma.c:513 [inline]
 rdma_resolve_route+0x23f7/0x3150 drivers/infiniband/core/cma.c:3379
 ucma_resolve_route+0x1ba/0x330 drivers/infiniband/core/ucma.c:745
 ucma_write+0x2df/0x430 drivers/infiniband/core/ucma.c:1743
 vfs_write+0x2a4/0xcb0 fs/read_write.c:588
 ksys_write+0x1a0/0x2c0 fs/read_write.c:643
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f4eae47dda9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4eaf2cd0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f4eae5abf80 RCX: 00007f4eae47dda9
RDX: 0000000000000010 RSI: 0000000020000440 RDI: 0000000000000003
RBP: 00007f4eae4ca47a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f4eae5abf80 R15: 00007fff93bb3dc8
 </TASK>

Allocated by task 11919:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 kmalloc_trace+0x1d9/0x360 mm/slub.c:4013
 kmalloc include/linux/slab.h:590 [inline]
 kzalloc include/linux/slab.h:711 [inline]
 __rdma_create_id+0x65/0x590 drivers/infiniband/core/cma.c:993
 rdma_create_user_id+0x83/0xc0 drivers/infiniband/core/cma.c:1049
 ucma_create_id+0x2d0/0x500 drivers/infiniband/core/ucma.c:463
 ucma_write+0x2df/0x430 drivers/infiniband/core/ucma.c:1743
 vfs_write+0x2a4/0xcb0 fs/read_write.c:588
 ksys_write+0x1a0/0x2c0 fs/read_write.c:643
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

Freed by task 11915:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:586
 poison_slab_object+0xa6/0xe0 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2122 [inline]
 slab_free mm/slub.c:4296 [inline]
 kfree+0x14a/0x380 mm/slub.c:4406
 ucma_close_id drivers/infiniband/core/ucma.c:186 [inline]
 ucma_destroy_private_ctx+0x14e/0xc10 drivers/infiniband/core/ucma.c:578
 ucma_close+0xfc/0x170 drivers/infiniband/core/ucma.c:1808
 __fput+0x429/0x8a0 fs/file_table.c:411
 __do_sys_close fs/open.c:1557 [inline]
 __se_sys_close fs/open.c:1542 [inline]
 __x64_sys_close+0x7f/0x110 fs/open.c:1542
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

The buggy address belongs to the object at ffff88808dcf6000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 388 bytes inside of
 freed 2048-byte region [ffff88808dcf6000, ffff88808dcf6800)

The buggy address belongs to the physical page:
page:ffffea0002373c00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x8dcf0
head:ffffea0002373c00 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff80000000840(slab|head|node=0|zone=1|lastcpupid=0xfff)
page_type: 0xffffffff()
raw: 00fff80000000840 ffff888014c42000 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000080008 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5149, tgid 5149 (kworker/1:4), ts 205905084555, free_ts 0
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x1ea/0x210 mm/page_alloc.c:1533
 prep_new_page mm/page_alloc.c:1540 [inline]
 get_page_from_freelist+0x33ea/0x3580 mm/page_alloc.c:3311
 __alloc_pages+0x256/0x6a0 mm/page_alloc.c:4567
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_slab_page+0x5f/0x160 mm/slub.c:2191
 allocate_slab mm/slub.c:2354 [inline]
 new_slab+0x84/0x2f0 mm/slub.c:2407
 ___slab_alloc+0xc73/0x1260 mm/slub.c:3541
 __slab_alloc mm/slub.c:3626 [inline]
 __slab_alloc_node mm/slub.c:3679 [inline]
 slab_alloc_node mm/slub.c:3851 [inline]
 __do_kmalloc_node mm/slub.c:3981 [inline]
 __kmalloc_node_track_caller+0x2d4/0x4e0 mm/slub.c:4002
 kmalloc_reserve+0xf3/0x260 net/core/skbuff.c:582
 __alloc_skb+0x1b1/0x420 net/core/skbuff.c:651
 alloc_skb include/linux/skbuff.h:1296 [inline]
 alloc_skb_with_frags+0xc3/0x780 net/core/skbuff.c:6394
 sock_alloc_send_pskb+0x91a/0xa60 net/core/sock.c:2794
 sock_alloc_send_skb include/net/sock.h:1855 [inline]
 mld_newpack+0x1c3/0xa90 net/ipv6/mcast.c:1746
 add_grhead net/ipv6/mcast.c:1849 [inline]
 add_grec+0x1492/0x19a0 net/ipv6/mcast.c:1987
 mld_send_cr net/ipv6/mcast.c:2113 [inline]
 mld_ifc_work+0x6bf/0xb30 net/ipv6/mcast.c:2650
 process_one_work kernel/workqueue.c:3146 [inline]
 process_scheduled_works+0x9d7/0x1730 kernel/workqueue.c:3226
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3307
page_owner free stack trace missing

Memory state around the buggy address:
 ffff88808dcf6080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88808dcf6100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88808dcf6180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff88808dcf6200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88808dcf6280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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

