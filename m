Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19CA140C56C
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Sep 2021 14:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbhIOMmm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Sep 2021 08:42:42 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:51040 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbhIOMml (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Sep 2021 08:42:41 -0400
Received: by mail-io1-f70.google.com with SMTP id b202-20020a6bb2d3000000b005b7fb465c4aso1631470iof.17
        for <linux-rdma@vger.kernel.org>; Wed, 15 Sep 2021 05:41:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=qAE2IWWczXJTjGpVWAU7E2xON9L9Fj3nVi9xTOys97w=;
        b=LLbC5a7DZQ6y2K7n0EaWqQqXoyYbA7FW0RJ6zz5x9Tsj1p12ejFNaYm0VEty5CCTku
         +o7wOXhFyc15qlbKTv2POdg1enwEYlBJVygRbt2Ld2jBHMGJQSkw2IOIaVxohoj/3IfM
         SM5HeGIp2vMrx/R33r7FEJVUWlO2IcmB84eBrXXR5tvoAoGCNBk1HNa+bfqOwR7hWx8d
         nmgdfgtMHEdXSuQFPNORFUglqPs/qwRi2Xd8fFQaCzKCd0VAqvTyvBvtKRtIBO5jfPeA
         xgOZq5WmzQ8C9Fr1h2omvI0UgNEy+VjpfnPwpRNROAnVaHv6CDUY3GuHzDMdMYk5+mN7
         eFWA==
X-Gm-Message-State: AOAM532qvAvvQQ8PTG0Zu4dlLYCwQXoxbvbbunD5qphMElCJhZIOWt+U
        kl0B4NzZZJ8xJv3AgZI14Kb9/Vf4GxD50AdE8EQL/mjF8riB
X-Google-Smtp-Source: ABdhPJx/hw58PExDz7X+uS++p/cQNy4OfJ8vIwseUnRlnQsn3rrE2Rp69ej9RIUk/oFBYQ1CplEMJCo2BvLTYsXggWqIJZYkbJA1
MIME-Version: 1.0
X-Received: by 2002:a92:8702:: with SMTP id m2mr15491997ild.250.1631709682454;
 Wed, 15 Sep 2021 05:41:22 -0700 (PDT)
Date:   Wed, 15 Sep 2021 05:41:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ffdae005cc08037e@google.com>
Subject: [syzbot] KASAN: use-after-free Read in addr_handler (4)
From:   syzbot <syzbot+dc3dfba010d7671e05f5@syzkaller.appspotmail.com>
To:     dledford@redhat.com, jgg@ziepe.ca, leon@kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    926de8c4326c Merge tag 'acpi-5.15-rc1-3' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11fd67ed300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=37df9ef5660a8387
dashboard link: https://syzkaller.appspot.com/bug?extid=dc3dfba010d7671e05f5
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dc3dfba010d7671e05f5@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in __mutex_lock_common kernel/locking/mutex.c:575 [inline]
BUG: KASAN: use-after-free in __mutex_lock+0x105b/0x12f0 kernel/locking/mutex.c:729
Read of size 8 at addr ffff88803991f3b0 by task kworker/u4:3/158

CPU: 0 PID: 158 Comm: kworker/u4:3 Not tainted 5.14.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: ib_addr process_one_req
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description.constprop.0.cold+0x6c/0x309 mm/kasan/report.c:256
 __kasan_report mm/kasan/report.c:442 [inline]
 kasan_report.cold+0x83/0xdf mm/kasan/report.c:459
 __mutex_lock_common kernel/locking/mutex.c:575 [inline]
 __mutex_lock+0x105b/0x12f0 kernel/locking/mutex.c:729
 addr_handler+0xac/0x470 drivers/infiniband/core/cma.c:3247
 process_one_req+0xfa/0x680 drivers/infiniband/core/addr.c:647
 process_one_work+0x9bf/0x16b0 kernel/workqueue.c:2297
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2444
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

Allocated by task 2916:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:46 [inline]
 set_alloc_info mm/kasan/common.c:434 [inline]
 ____kasan_kmalloc mm/kasan/common.c:513 [inline]
 ____kasan_kmalloc mm/kasan/common.c:472 [inline]
 __kasan_kmalloc+0xa4/0xd0 mm/kasan/common.c:522
 kmalloc include/linux/slab.h:591 [inline]
 kzalloc include/linux/slab.h:721 [inline]
 __rdma_create_id+0x5b/0x550 drivers/infiniband/core/cma.c:839
 rdma_create_user_id+0x79/0xd0 drivers/infiniband/core/cma.c:893
 ucma_create_id+0x162/0x360 drivers/infiniband/core/ucma.c:461
 ucma_write+0x25c/0x350 drivers/infiniband/core/ucma.c:1732
 vfs_write+0x28e/0xae0 fs/read_write.c:592
 ksys_write+0x1ee/0x250 fs/read_write.c:647
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Freed by task 2916:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track+0x1c/0x30 mm/kasan/common.c:46
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:360
 ____kasan_slab_free mm/kasan/common.c:366 [inline]
 ____kasan_slab_free mm/kasan/common.c:328 [inline]
 __kasan_slab_free+0xff/0x130 mm/kasan/common.c:374
 kasan_slab_free include/linux/kasan.h:230 [inline]
 slab_free_hook mm/slub.c:1700 [inline]
 slab_free_freelist_hook+0x81/0x190 mm/slub.c:1725
 slab_free mm/slub.c:3483 [inline]
 kfree+0xe4/0x530 mm/slub.c:4543
 ucma_close_id drivers/infiniband/core/ucma.c:185 [inline]
 ucma_destroy_private_ctx+0x8b3/0xb70 drivers/infiniband/core/ucma.c:576
 ucma_destroy_id+0x1e6/0x280 drivers/infiniband/core/ucma.c:614
 ucma_write+0x25c/0x350 drivers/infiniband/core/ucma.c:1732
 vfs_write+0x28e/0xae0 fs/read_write.c:592
 ksys_write+0x1ee/0x250 fs/read_write.c:647
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Last potentially related work creation:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_record_aux_stack+0xe9/0x110 mm/kasan/generic.c:348
 __call_rcu kernel/rcu/tree.c:2987 [inline]
 call_rcu+0xb1/0x750 kernel/rcu/tree.c:3067
 netlink_release+0xdd4/0x1dd0 net/netlink/af_netlink.c:812
 __sock_release+0xcd/0x280 net/socket.c:649
 sock_close+0x18/0x20 net/socket.c:1314
 __fput+0x288/0x9f0 fs/file_table.c:280
 task_work_run+0xdd/0x1a0 kernel/task_work.c:164
 exit_task_work include/linux/task_work.h:32 [inline]
 do_exit+0xbae/0x2a30 kernel/exit.c:825
 do_group_exit+0x125/0x310 kernel/exit.c:922
 __do_sys_exit_group kernel/exit.c:933 [inline]
 __se_sys_exit_group kernel/exit.c:931 [inline]
 __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:931
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

The buggy address belongs to the object at ffff88803991f000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 944 bytes inside of
 2048-byte region [ffff88803991f000, ffff88803991f800)
The buggy address belongs to the page:
page:ffffea0000e64600 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x39918
head:ffffea0000e64600 order:3 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 dead000000000100 dead000000000122 ffff888010c42000
raw: 0000000000000000 0000000000080008 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 6632, ts 274175306325, free_ts 0
 prep_new_page mm/page_alloc.c:2424 [inline]
 get_page_from_freelist+0xa72/0x2f80 mm/page_alloc.c:4153
 __alloc_pages+0x1b2/0x500 mm/page_alloc.c:5375
 alloc_pages+0x1a7/0x300 mm/mempolicy.c:2197
 alloc_slab_page mm/slub.c:1763 [inline]
 allocate_slab mm/slub.c:1900 [inline]
 new_slab+0x319/0x490 mm/slub.c:1963
 ___slab_alloc+0x921/0xfe0 mm/slub.c:2994
 __slab_alloc.constprop.0+0x4d/0xa0 mm/slub.c:3081
 slab_alloc_node mm/slub.c:3172 [inline]
 slab_alloc mm/slub.c:3214 [inline]
 __kmalloc+0x305/0x320 mm/slub.c:4387
 kmalloc_array include/linux/slab.h:631 [inline]
 kcalloc include/linux/slab.h:660 [inline]
 veth_alloc_queues drivers/net/veth.c:1314 [inline]
 veth_dev_init+0x114/0x2e0 drivers/net/veth.c:1341
 register_netdevice+0x51e/0x1500 net/core/dev.c:10225
 veth_newlink+0x58c/0xb20 drivers/net/veth.c:1726
 __rtnl_newlink+0x106d/0x1750 net/core/rtnetlink.c:3458
 rtnl_newlink+0x64/0xa0 net/core/rtnetlink.c:3506
 rtnetlink_rcv_msg+0x413/0xb80 net/core/rtnetlink.c:5572
 netlink_rcv_skb+0x153/0x420 net/netlink/af_netlink.c:2504
 netlink_unicast_kernel net/netlink/af_netlink.c:1314 [inline]
 netlink_unicast+0x533/0x7d0 net/netlink/af_netlink.c:1340
 netlink_sendmsg+0x86d/0xdb0 net/netlink/af_netlink.c:1929
page_owner free stack trace missing

Memory state around the buggy address:
 ffff88803991f280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88803991f300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88803991f380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                     ^
 ffff88803991f400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88803991f480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
