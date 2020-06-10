Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 730C11F599F
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2020 19:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729274AbgFJRCN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 10 Jun 2020 13:02:13 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:52030 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbgFJRCM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 10 Jun 2020 13:02:12 -0400
Received: by mail-il1-f199.google.com with SMTP id q14so1915625ils.18
        for <linux-rdma@vger.kernel.org>; Wed, 10 Jun 2020 10:02:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=KXD6766GD3cN9nGxvoovLs8rn0gVhNreN3crce2TgnA=;
        b=ZNxrzVVMQyiGSiwwnWHWFlhYDj7kkFg57P+qZvZ5kT72FucUoPACyBbHuWdDRt0Yab
         YVOgDNY29kTFuAmQkozX9yXr8LGq/MCzmuYWNLfcROK7ie4iJnj1sHGgcF1IVlL/V+6y
         yOQGcvNhVP7Wc4QDaqfyNEhKhRZR3UTG8/39lm3JF2A5hOscTBSWdlXbUiaUm82KCV3s
         AbEKLA9jcl5E4gspCpi/qieB0/sG2sUPM2oKnaeqhJc29n5X0Aodn5/cQZtzIV/0xS1R
         R3kwu8qTKU8IGXo0rCXQiUY9kZra2KTTIMZM19CjPNx+zkSyh7ebOkdBfHCJ6Znf9tas
         yTEA==
X-Gm-Message-State: AOAM531h7hQP8U1mwM9+33ub69CQBpa99nTalAlNgmi6b/nqI3xYcTMf
        Yf454vt6WmFFerBzOT9oKCyGJdtinCxZxFf+QW1NonxSi36M
X-Google-Smtp-Source: ABdhPJxGAWjBmeknqYy52Bo1OicVq8SiBy6dnuXkgiNPFH/Cai7ErFjhIOuT/Pz/lWTZFcfmXQrpne3ioC30iF2k5vhgszJLroQC
MIME-Version: 1.0
X-Received: by 2002:a92:7414:: with SMTP id p20mr4099501ilc.77.1591808531395;
 Wed, 10 Jun 2020 10:02:11 -0700 (PDT)
Date:   Wed, 10 Jun 2020 10:02:11 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000107b4605a7bdce7d@google.com>
Subject: KASAN: use-after-free Read in addr_handler (2)
From:   syzbot <syzbot+a929647172775e335941@syzkaller.appspotmail.com>
To:     chuck.lever@oracle.com, dledford@redhat.com, jgg@ziepe.ca,
        leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, parav@mellanox.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    7ae77150 Merge tag 'powerpc-5.8-1' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16c0d3a6100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d195fe572fb15312
dashboard link: https://syzkaller.appspot.com/bug?extid=a929647172775e335941
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+a929647172775e335941@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in __mutex_lock_common kernel/locking/mutex.c:938 [inline]
BUG: KASAN: use-after-free in __mutex_lock+0x1033/0x13c0 kernel/locking/mutex.c:1103
Read of size 8 at addr ffff888088ec33b0 by task kworker/u4:5/14014

CPU: 1 PID: 14014 Comm: kworker/u4:5 Not tainted 5.7.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: ib_addr process_one_req
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x188/0x20d lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0xd3/0x413 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:530
 __mutex_lock_common kernel/locking/mutex.c:938 [inline]
 __mutex_lock+0x1033/0x13c0 kernel/locking/mutex.c:1103
 addr_handler+0xa0/0x340 drivers/infiniband/core/cma.c:3100
 process_one_req+0xfa/0x680 drivers/infiniband/core/addr.c:643
 process_one_work+0x965/0x16a0 kernel/workqueue.c:2268
 worker_thread+0x96/0xe20 kernel/workqueue.c:2414
 kthread+0x388/0x470 kernel/kthread.c:268
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:351

Allocated by task 31499:
 save_stack+0x1b/0x40 mm/kasan/common.c:48
 set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc mm/kasan/common.c:494 [inline]
 __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:467
 kmem_cache_alloc_trace+0x153/0x7d0 mm/slab.c:3551
 kmalloc include/linux/slab.h:555 [inline]
 kzalloc include/linux/slab.h:669 [inline]
 __rdma_create_id+0x5b/0x850 drivers/infiniband/core/cma.c:861
 ucma_create_id+0x1d1/0x590 drivers/infiniband/core/ucma.c:503
 ucma_write+0x285/0x350 drivers/infiniband/core/ucma.c:1729
 __vfs_write+0x76/0x100 fs/read_write.c:495
 vfs_write+0x268/0x5d0 fs/read_write.c:559
 ksys_write+0x1ee/0x250 fs/read_write.c:612
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3

Freed by task 31496:
 save_stack+0x1b/0x40 mm/kasan/common.c:48
 set_track mm/kasan/common.c:56 [inline]
 kasan_set_free_info mm/kasan/common.c:316 [inline]
 __kasan_slab_free+0xf7/0x140 mm/kasan/common.c:455
 __cache_free mm/slab.c:3426 [inline]
 kfree+0x109/0x2b0 mm/slab.c:3757
 ucma_close+0x111/0x300 drivers/infiniband/core/ucma.c:1807
 __fput+0x33e/0x880 fs/file_table.c:281
 task_work_run+0xf4/0x1b0 kernel/task_work.c:123
 tracehook_notify_resume include/linux/tracehook.h:188 [inline]
 exit_to_usermode_loop+0x2fa/0x360 arch/x86/entry/common.c:165
 prepare_exit_to_usermode arch/x86/entry/common.c:196 [inline]
 syscall_return_slowpath arch/x86/entry/common.c:279 [inline]
 do_syscall_64+0x6b1/0x7d0 arch/x86/entry/common.c:305
 entry_SYSCALL_64_after_hwframe+0x49/0xb3

The buggy address belongs to the object at ffff888088ec3000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 944 bytes inside of
 2048-byte region [ffff888088ec3000, ffff888088ec3800)
The buggy address belongs to the page:
page:ffffea000223b0c0 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0
flags: 0xfffe0000000200(slab)
raw: 00fffe0000000200 ffffea000299f588 ffffea000263d0c8 ffff8880aa000e00
raw: 0000000000000000 ffff888088ec3000 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888088ec3280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888088ec3300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888088ec3380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                     ^
 ffff888088ec3400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888088ec3480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
