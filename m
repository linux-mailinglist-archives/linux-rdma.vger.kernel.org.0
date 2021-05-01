Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A00313705BF
	for <lists+linux-rdma@lfdr.de>; Sat,  1 May 2021 07:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbhEAFtM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 1 May 2021 01:49:12 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:36645 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhEAFtM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 1 May 2021 01:49:12 -0400
Received: by mail-il1-f197.google.com with SMTP id t15-20020a92dc0f0000b029016b11675c42so401302iln.3
        for <linux-rdma@vger.kernel.org>; Fri, 30 Apr 2021 22:48:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=VM41VnBAt7GHJWqpUqrj+PUmTwLBYBfrS5Df+9Sr+3w=;
        b=rdKEh0IUhlJO7fAhd8r4hIxNtR3bUYQlC2x93lODQJWcFebX7iQ6J03FQGBWu6rXIG
         1LCFE768SogPD7vXQx6hhJkk6Pow0xeZg/THqXezU7QtPUGBRCMai+qZhH5+Sd+Z63Bs
         Mz1wZO7uX2lALfU2xLW4jb/dl6RI9QUOvsnNZDD7enbDo9P4JrudRQZ+083nqEYqwMrI
         SbWgtjzdHgTMD5/0U4FF13PhvcjKCo8PaO6lI84vhFzKOoFLTI1EIl0GBRjHsarFjGAw
         CgyeHgNYUEURDoTp0Aa+oTR1xtFLeU/YEcRHIs3qEpKzFap04N3r282sC7VdNGum9YbP
         rCnw==
X-Gm-Message-State: AOAM530dI/4GD1lLNucDZJq6gSMmVza3iA3MGLbjDTyk68cXJQATnbRM
        syRBSQWhGGMqvIYhvNsRnnlrODkgd/pkcJBH571AfmpBjmDJ
X-Google-Smtp-Source: ABdhPJwk1rLUEEBX7O5WOerj4SjwHOZ+aCB95Ff9z5C/crvJCDB3kIPUbqSz/EyOElyIyc9mAPh3XZ6dDPCkCuy/WUaB2TgT/srA
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:48b:: with SMTP id b11mr7030027ils.245.1619848102814;
 Fri, 30 Apr 2021 22:48:22 -0700 (PDT)
Date:   Fri, 30 Apr 2021 22:48:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c22a6805c13e46a8@google.com>
Subject: [syzbot] KASAN: use-after-free Read in rdma_listen (3)
From:   syzbot <syzbot+6bb0528b13611047209c@syzkaller.appspotmail.com>
To:     dledford@redhat.com, jgg@ziepe.ca, leon@kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    90c911ad Merge tag 'fixes' of git://git.kernel.org/pub/scm..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14eb4399d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9404cfa686df2c05
dashboard link: https://syzkaller.appspot.com/bug?extid=6bb0528b13611047209c

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6bb0528b13611047209c@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in __list_add_valid+0x93/0xa0 lib/list_debug.c:26
Read of size 8 at addr ffff8881546491e0 by task syz-executor.1/32204

CPU: 1 PID: 32204 Comm: syz-executor.1 Not tainted 5.12.0-rc8-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x141/0x1d7 lib/dump_stack.c:120
 print_address_description.constprop.0.cold+0x5b/0x2f8 mm/kasan/report.c:232
 __kasan_report mm/kasan/report.c:399 [inline]
 kasan_report.cold+0x7c/0xd8 mm/kasan/report.c:416
 __list_add_valid+0x93/0xa0 lib/list_debug.c:26
 __list_add include/linux/list.h:67 [inline]
 list_add_tail include/linux/list.h:100 [inline]
 cma_listen_on_all drivers/infiniband/core/cma.c:2557 [inline]
 rdma_listen+0x787/0xe00 drivers/infiniband/core/cma.c:3751
 ucma_listen+0x16a/0x210 drivers/infiniband/core/ucma.c:1102
 ucma_write+0x259/0x350 drivers/infiniband/core/ucma.c:1732
 vfs_write+0x28e/0xa30 fs/read_write.c:603
 ksys_write+0x1ee/0x250 fs/read_write.c:658
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4665f9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb4c3093188 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 000000000056bf60 RCX: 00000000004665f9
RDX: 0000000000000010 RSI: 0000000020000180 RDI: 0000000000000003
RBP: 00000000004bfbb9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056bf60
R13: 00007ffd209035df R14: 00007fb4c3093300 R15: 0000000000022000

Allocated by task 32201:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:46 [inline]
 set_alloc_info mm/kasan/common.c:427 [inline]
 ____kasan_kmalloc mm/kasan/common.c:506 [inline]
 ____kasan_kmalloc mm/kasan/common.c:465 [inline]
 __kasan_kmalloc+0x99/0xc0 mm/kasan/common.c:515
 kmalloc include/linux/slab.h:554 [inline]
 kzalloc include/linux/slab.h:684 [inline]
 __rdma_create_id+0x5b/0x550 drivers/infiniband/core/cma.c:844
 rdma_create_user_id+0x79/0xd0 drivers/infiniband/core/cma.c:897
 ucma_create_id+0x162/0x370 drivers/infiniband/core/ucma.c:461
 ucma_write+0x259/0x350 drivers/infiniband/core/ucma.c:1732
 vfs_write+0x28e/0xa30 fs/read_write.c:603
 ksys_write+0x1ee/0x250 fs/read_write.c:658
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Freed by task 32201:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track+0x1c/0x30 mm/kasan/common.c:46
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:357
 ____kasan_slab_free mm/kasan/common.c:360 [inline]
 ____kasan_slab_free mm/kasan/common.c:325 [inline]
 __kasan_slab_free+0xf5/0x130 mm/kasan/common.c:367
 kasan_slab_free include/linux/kasan.h:199 [inline]
 slab_free_hook mm/slub.c:1562 [inline]
 slab_free_freelist_hook+0x92/0x210 mm/slub.c:1600
 slab_free mm/slub.c:3161 [inline]
 kfree+0xe5/0x7f0 mm/slub.c:4213
 ucma_close_id drivers/infiniband/core/ucma.c:185 [inline]
 ucma_destroy_private_ctx+0x8b3/0xb70 drivers/infiniband/core/ucma.c:576
 ucma_destroy_id+0x1e6/0x280 drivers/infiniband/core/ucma.c:614
 ucma_write+0x259/0x350 drivers/infiniband/core/ucma.c:1732
 vfs_write+0x28e/0xa30 fs/read_write.c:603
 ksys_write+0x1ee/0x250 fs/read_write.c:658
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Last potentially related work creation:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_record_aux_stack+0xe5/0x110 mm/kasan/generic.c:345
 __call_rcu kernel/rcu/tree.c:3039 [inline]
 call_rcu+0xb1/0x740 kernel/rcu/tree.c:3114
 netlink_release+0xd48/0x1cf0 net/netlink/af_netlink.c:810
 __sock_release+0xcd/0x280 net/socket.c:599
 sock_close+0x18/0x20 net/socket.c:1258
 __fput+0x288/0x920 fs/file_table.c:280
 task_work_run+0xdd/0x1a0 kernel/task_work.c:140
 exit_task_work include/linux/task_work.h:30 [inline]
 do_exit+0xbfc/0x2a60 kernel/exit.c:825
 do_group_exit+0x125/0x310 kernel/exit.c:922
 __do_sys_exit_group kernel/exit.c:933 [inline]
 __se_sys_exit_group kernel/exit.c:931 [inline]
 __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:931
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xae

The buggy address belongs to the object at ffff888154649000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 480 bytes inside of
 2048-byte region [ffff888154649000, ffff888154649800)
The buggy address belongs to the page:
page:ffffea0005519200 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x154648
head:ffffea0005519200 order:3 compound_mapcount:0 compound_pincount:0
flags: 0x57ff00000010200(slab|head)
raw: 057ff00000010200 ffffea0005474a00 0000000200000002 ffff888010442000
raw: 0000000000000000 0000000000080008 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888154649080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888154649100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888154649180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                       ^
 ffff888154649200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888154649280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
