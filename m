Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 745CD161DE8
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Feb 2020 00:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbgBQXdO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 Feb 2020 18:33:14 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:35105 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgBQXdO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 17 Feb 2020 18:33:14 -0500
Received: by mail-il1-f197.google.com with SMTP id h18so15572941ilc.2
        for <linux-rdma@vger.kernel.org>; Mon, 17 Feb 2020 15:33:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=QFDVh6DndK/OU8fD9C6Hc41l36lCVHDEzQ6kAXyNM18=;
        b=twscWMzL5cjoBqXaaYr2kryG+8Mrlv/o8QC8GeioCEzADENCfLeqbPIWtSoq2VVCQO
         AgGIT/WWGGLf0PSsOkIZ/rlUsGtGBx9yRGSjiZvzXp8oq1K+p7yLkB9mfzEsK7BwNFlt
         DuOYItxlZ3ebvHEtALMCvPI+9dTvP46zlBjJnzB8IIUTp+et+vSP86oKmxemDqt+IKYO
         nSUr1jtmwJW7slBA8teCt4D45gKMELgwmLXegW5uu03pbgOMuZ2E6gG1vZHSLikvdlTj
         9qIB9v6AyFGv4AL2DnN5zhTUROYn9TESO1zE/N+4fOdmlY17Vdu77EkH9RYAnwPx1vTo
         pSqA==
X-Gm-Message-State: APjAAAVaOI6vSIdKbwazkyvnpzoyY/ChtgMGGF+3amKLd34bS2+EGhDL
        bu4sJuKzlxEYzAzyfv8Rq6bemQZecWAKlLOX0guTgiTB8UYa
X-Google-Smtp-Source: APXvYqx9gUoQBk+NjbUzdZgqnAou4Wq3+phXqHQHy17mB7TB+1AL7v/L9CI1vGvukztrHFSTMCXdA7sjj+Y6VZo4NQQJitytwHaC
MIME-Version: 1.0
X-Received: by 2002:a6b:e705:: with SMTP id b5mr14605943ioh.139.1581982393876;
 Mon, 17 Feb 2020 15:33:13 -0800 (PST)
Date:   Mon, 17 Feb 2020 15:33:13 -0800
In-Reply-To: <00000000000012a4cd05854a1d0a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a0c73b059ecdfafa@google.com>
Subject: Re: KASAN: use-after-free Read in rdma_listen (2)
From:   syzbot <syzbot+adb15cf8c2798e4e0db4@syzkaller.appspotmail.com>
To:     chuck.lever@oracle.com, danielj@mellanox.com, danitg@mellanox.com,
        dledford@redhat.com, jgg@ziepe.ca, leon@kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        parav@mellanox.com, swise@opengridcomputing.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    c25a951c Add linux-next specific files for 20200217
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10df082de00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c727d8fc485ff049
dashboard link: https://syzkaller.appspot.com/bug?extid=adb15cf8c2798e4e0db4
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=112b9d6ee00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=147abb11e00000

Bisection is inconclusive: the bug happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14b80c3f200000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=16b80c3f200000
console output: https://syzkaller.appspot.com/x/log.txt?x=12b80c3f200000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+adb15cf8c2798e4e0db4@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in __list_add_valid+0x9a/0xa0 lib/list_debug.c:26
Read of size 8 at addr ffff888093bbb1e0 by task syz-executor570/10159

CPU: 1 PID: 10159 Comm: syz-executor570 Not tainted 5.6.0-rc2-next-20200217-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x197/0x210 lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0xd4/0x30b mm/kasan/report.c:374
 __kasan_report.cold+0x1b/0x32 mm/kasan/report.c:506
 kasan_report+0x12/0x20 mm/kasan/common.c:641
 __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:135
 __list_add_valid+0x9a/0xa0 lib/list_debug.c:26
 __list_add include/linux/list.h:67 [inline]
 list_add_tail include/linux/list.h:100 [inline]
 cma_listen_on_all drivers/infiniband/core/cma.c:2517 [inline]
 rdma_listen+0x6b7/0x970 drivers/infiniband/core/cma.c:3628
 ucma_listen+0x14d/0x1c0 drivers/infiniband/core/ucma.c:1092
 ucma_write+0x2d7/0x3c0 drivers/infiniband/core/ucma.c:1684
 __vfs_write+0x8a/0x110 fs/read_write.c:494
 vfs_write+0x268/0x5d0 fs/read_write.c:558
 ksys_write+0x220/0x290 fs/read_write.c:611
 __do_sys_write fs/read_write.c:623 [inline]
 __se_sys_write fs/read_write.c:620 [inline]
 __x64_sys_write+0x73/0xb0 fs/read_write.c:620
 do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x446a69
Code: e8 5c b3 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 0b 08 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fdd8433eda8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00000000006dbc28 RCX: 0000000000446a69
RDX: 0000000000000010 RSI: 00000000200001c0 RDI: 0000000000000004
RBP: 00000000006dbc20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc2c
R13: 0000000000000000 R14: 0000000000000000 R15: 20c49ba5e353f7cf

Allocated by task 10155:
 save_stack+0x23/0x90 mm/kasan/common.c:72
 set_track mm/kasan/common.c:80 [inline]
 __kasan_kmalloc mm/kasan/common.c:515 [inline]
 __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:488
 kasan_kmalloc+0x9/0x10 mm/kasan/common.c:529
 kmem_cache_alloc_trace+0x158/0x790 mm/slab.c:3551
 kmalloc include/linux/slab.h:555 [inline]
 kzalloc include/linux/slab.h:669 [inline]
 __rdma_create_id+0x5e/0x870 drivers/infiniband/core/cma.c:861
 ucma_create_id+0x1de/0x620 drivers/infiniband/core/ucma.c:501
 ucma_write+0x2d7/0x3c0 drivers/infiniband/core/ucma.c:1684
 __vfs_write+0x8a/0x110 fs/read_write.c:494
 vfs_write+0x268/0x5d0 fs/read_write.c:558
 ksys_write+0x220/0x290 fs/read_write.c:611
 __do_sys_write fs/read_write.c:623 [inline]
 __se_sys_write fs/read_write.c:620 [inline]
 __x64_sys_write+0x73/0xb0 fs/read_write.c:620
 do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 10157:
 save_stack+0x23/0x90 mm/kasan/common.c:72
 set_track mm/kasan/common.c:80 [inline]
 kasan_set_free_info mm/kasan/common.c:337 [inline]
 __kasan_slab_free+0x102/0x150 mm/kasan/common.c:476
 kasan_slab_free+0xe/0x10 mm/kasan/common.c:485
 __cache_free mm/slab.c:3426 [inline]
 kfree+0x10a/0x2c0 mm/slab.c:3757
 rdma_destroy_id+0x7c6/0xdd0 drivers/infiniband/core/cma.c:1866
 ucma_close+0x115/0x310 drivers/infiniband/core/ucma.c:1762
 __fput+0x2ff/0x890 fs/file_table.c:280
 ____fput+0x16/0x20 fs/file_table.c:313
 task_work_run+0x145/0x1c0 kernel/task_work.c:113
 exit_task_work include/linux/task_work.h:22 [inline]
 do_exit+0xbcb/0x3030 kernel/exit.c:802
 do_group_exit+0x135/0x360 kernel/exit.c:900
 get_signal+0x47c/0x24f0 kernel/signal.c:2734
 do_signal+0x87/0x1700 arch/x86/kernel/signal.c:813
 exit_to_usermode_loop+0x286/0x380 arch/x86/entry/common.c:160
 prepare_exit_to_usermode arch/x86/entry/common.c:195 [inline]
 syscall_return_slowpath arch/x86/entry/common.c:278 [inline]
 do_syscall_64+0x676/0x790 arch/x86/entry/common.c:304
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff888093bbb000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 480 bytes inside of
 2048-byte region [ffff888093bbb000, ffff888093bbb800)
The buggy address belongs to the page:
page:ffffea00024eeec0 refcount:1 mapcount:0 mapping:00000000f8d67f88 index:0x0
flags: 0xfffe0000000200(slab)
raw: 00fffe0000000200 ffffea00026b2908 ffffea00024eee88 ffff8880aa400e00
raw: 0000000000000000 ffff888093bbb000 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888093bbb080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888093bbb100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888093bbb180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                       ^
 ffff888093bbb200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888093bbb280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

