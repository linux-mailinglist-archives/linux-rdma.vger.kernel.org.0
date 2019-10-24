Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 551B0E2A05
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Oct 2019 07:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436467AbfJXFlI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Oct 2019 01:41:08 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:51403 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390925AbfJXFlI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Oct 2019 01:41:08 -0400
Received: by mail-io1-f69.google.com with SMTP id x13so24785337ioa.18
        for <linux-rdma@vger.kernel.org>; Wed, 23 Oct 2019 22:41:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=qTVxFo3HdO6z5TZWXw04u3dfnIn/I3qJHsYWtua5niA=;
        b=bK/6Lacjmz7+2gyDKINEPa+MnNKbKSHjUkPVJBbHiI061UWKoQr+FzJf00wWeHYv0v
         0L3Pzoz3cv3qGzNd8Az2bk3F4F7lyLEw8UVWqGGEdVUvyIV5eHpNzhivAOSTNwZRWqnk
         yFrw9ziCiF7c3snYblZmQDxVX3z+jAn7NaenV02qhig6mu4v+8hWZVIGK+VfGJewZt7+
         FCmBv6T/BGv16N2nfRZgyHqNzazcEizH5uUnoY+bU8GaOfeVa5VfzQ64wcSwABpgRcW6
         YEeucE9npSJyKOdeS73XZ4eAOvVF6084hzQ0ofDhkAzMmkEDlRToZKHv09zQ7CCJzFSt
         t/Sw==
X-Gm-Message-State: APjAAAX2vmkjvvzWN4JMTPSee+N/iD06CkH9gGPUM7vubrouR8XxZZ9D
        SDaWB7UVYOotvt1rPN/tgFsiA+JWf2YFqKM12YzQPPqDA/QO
X-Google-Smtp-Source: APXvYqxIitDkoL/+XE9OagriX+lVJtdpL/L4jMmuCArawskq6JXSx2y80ga0/MGcZ0DkpUwvpk2az4jKKier8V13JnGRACA5nxzF
MIME-Version: 1.0
X-Received: by 2002:a02:b619:: with SMTP id h25mr13146316jam.40.1571895667272;
 Wed, 23 Oct 2019 22:41:07 -0700 (PDT)
Date:   Wed, 23 Oct 2019 22:41:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000df373f0595a17a83@google.com>
Subject: KASAN: use-after-free Read in cma_cancel_listens
From:   syzbot <syzbot+57a3b121df74c4eccbc7@syzkaller.appspotmail.com>
To:     bvanassche@acm.org, danitg@mellanox.com, dledford@redhat.com,
        jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, mhjungk@gmail.com, parav@mellanox.com,
        shamir.rabinovitch@oracle.com, swise@opengridcomputing.com,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    3b7c59a1 Merge tag 'pinctrl-v5.4-2' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12b639ff600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6c03e4d33fa96d51
dashboard link: https://syzkaller.appspot.com/bug?extid=57a3b121df74c4eccbc7
compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
80fee25776c2fb61e74c1ecb1a523375c2500b69)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+57a3b121df74c4eccbc7@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in __list_del_entry_valid+0x9c/0x100  
lib/list_debug.c:54
Read of size 8 at addr ffff888097eda1e8 by task syz-executor.2/15086

CPU: 1 PID: 15086 Comm: syz-executor.2 Not tainted 5.4.0-rc4+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1d8/0x2f8 lib/dump_stack.c:113
  print_address_description+0x75/0x5c0 mm/kasan/report.c:374
  __kasan_report+0x14b/0x1c0 mm/kasan/report.c:506
  kasan_report+0x26/0x50 mm/kasan/common.c:634
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:132
  __list_del_entry_valid+0x9c/0x100 lib/list_debug.c:54
  __list_del_entry include/linux/list.h:131 [inline]
  list_del include/linux/list.h:139 [inline]
  cma_cancel_listens+0x40/0x390 drivers/infiniband/core/cma.c:1750
  cma_cancel_operation drivers/infiniband/core/cma.c:1778 [inline]
  rdma_destroy_id+0x44f/0x1080 drivers/infiniband/core/cma.c:1842
  ucma_close+0x1eb/0x2c0 drivers/infiniband/core/ucma.c:1762
  __fput+0x2e4/0x740 fs/file_table.c:280
  ____fput+0x15/0x20 fs/file_table.c:313
  task_work_run+0x17e/0x1b0 kernel/task_work.c:113
  exit_task_work include/linux/task_work.h:22 [inline]
  do_exit+0x5e8/0x2190 kernel/exit.c:817
  do_group_exit+0x15c/0x2b0 kernel/exit.c:921
  get_signal+0x4ac/0x1d60 kernel/signal.c:2734
  do_signal+0x37/0x640 arch/x86/kernel/signal.c:815
  exit_to_usermode_loop arch/x86/entry/common.c:159 [inline]
  prepare_exit_to_usermode+0x303/0x580 arch/x86/entry/common.c:194
  syscall_return_slowpath+0x113/0x4a0 arch/x86/entry/common.c:274
  do_syscall_64+0x11f/0x1c0 arch/x86/entry/common.c:300
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x459ef9
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007faedb0c5cf8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 000000000075bf28 RCX: 0000000000459ef9
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 000000000075bf28
RBP: 000000000075bf20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000075bf2c
R13: 00007ffe74d4703f R14: 00007faedb0c69c0 R15: 000000000075bf2c

Allocated by task 15089:
  save_stack mm/kasan/common.c:69 [inline]
  set_track mm/kasan/common.c:77 [inline]
  __kasan_kmalloc+0x11c/0x1b0 mm/kasan/common.c:510
  kasan_kmalloc+0x9/0x10 mm/kasan/common.c:524
  kmem_cache_alloc_trace+0x221/0x2f0 mm/slab.c:3550
  kmalloc include/linux/slab.h:556 [inline]
  kzalloc include/linux/slab.h:690 [inline]
  __rdma_create_id+0x66/0x480 drivers/infiniband/core/cma.c:882
  ucma_create_id+0x250/0x540 drivers/infiniband/core/ucma.c:501
  ucma_write+0x2da/0x360 drivers/infiniband/core/ucma.c:1684
  __vfs_write+0xb8/0x740 fs/read_write.c:494
  vfs_write+0x275/0x590 fs/read_write.c:558
  ksys_write+0x117/0x220 fs/read_write.c:611
  __do_sys_write fs/read_write.c:623 [inline]
  __se_sys_write fs/read_write.c:620 [inline]
  __x64_sys_write+0x7b/0x90 fs/read_write.c:620
  do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 15272:
  save_stack mm/kasan/common.c:69 [inline]
  set_track mm/kasan/common.c:77 [inline]
  kasan_set_free_info mm/kasan/common.c:332 [inline]
  __kasan_slab_free+0x12a/0x1e0 mm/kasan/common.c:471
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:480
  __cache_free mm/slab.c:3425 [inline]
  kfree+0x115/0x200 mm/slab.c:3756
  rdma_destroy_id+0xea2/0x1080 drivers/infiniband/core/cma.c:1877
  ucma_close+0x1eb/0x2c0 drivers/infiniband/core/ucma.c:1762
  __fput+0x2e4/0x740 fs/file_table.c:280
  ____fput+0x15/0x20 fs/file_table.c:313
  task_work_run+0x17e/0x1b0 kernel/task_work.c:113
  get_signal+0x1ca8/0x1d60 kernel/signal.c:2528
  do_signal+0x37/0x640 arch/x86/kernel/signal.c:815
  exit_to_usermode_loop arch/x86/entry/common.c:159 [inline]
  prepare_exit_to_usermode+0x303/0x580 arch/x86/entry/common.c:194
  syscall_return_slowpath+0x113/0x4a0 arch/x86/entry/common.c:274
  do_syscall_64+0x11f/0x1c0 arch/x86/entry/common.c:300
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff888097eda000
  which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 488 bytes inside of
  2048-byte region [ffff888097eda000, ffff888097eda800)
The buggy address belongs to the page:
page:ffffea00025fb680 refcount:1 mapcount:0 mapping:ffff8880aa400e00  
index:0x0
flags: 0x1fffc0000000200(slab)
raw: 01fffc0000000200 ffffea0002982a08 ffffea0002561a48 ffff8880aa400e00
raw: 0000000000000000 ffff888097eda000 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff888097eda080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff888097eda100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff888097eda180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                           ^
  ffff888097eda200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff888097eda280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
