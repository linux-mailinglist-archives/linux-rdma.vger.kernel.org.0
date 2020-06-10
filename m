Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7751F59A6
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2020 19:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729321AbgFJRDR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 10 Jun 2020 13:03:17 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:35001 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729319AbgFJRDQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 10 Jun 2020 13:03:16 -0400
Received: by mail-il1-f198.google.com with SMTP id a4so1946904ilq.2
        for <linux-rdma@vger.kernel.org>; Wed, 10 Jun 2020 10:03:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=/8VyyvbY0MFmxASLFri+epDf3FVjEyIxf2Tr+Kql3lM=;
        b=qTxmujh/iDuMD5JVGOU9pw5tRAHhMVB4RT77tivr4237obUSxhpbAtfh/nNF+XeoRx
         e3soeWUlRJmgx/YQXzqHnr85z/R6XXTmqVqU79DeF85dkHRM7T8L6M5wk+plqLHHo3ki
         BMi540DT/eS+B5gLemhzpWogHJwC7eWtpFIaVvRAI8q4STtzUiDrNwJNrAu0lWq0FRSL
         4+oAz5aCtAWAmP72pVMGkz8iDzsqESLDTPLOgdr8nd1jjWmZgTpBwNn/fuw/n08inEKG
         Bz6NfinazPLw8ofGU+Y99y5D92Esq2IQAgwcokLXiUFS6AtSFfbVxunytBbIQNhoK717
         MMzA==
X-Gm-Message-State: AOAM532a4KXTHBnnLgnWqEtxZelVQONrBRfUx2ufdSJQjz0q/N+Q12HZ
        ZuoOYRzY61ZjoAMD36fIcP8w14v3Yfd6EYO/yEkybm++u0u6
X-Google-Smtp-Source: ABdhPJwssfMvZieRng2tWlnci9pP1EMl9a4PyHFsIl6L45bueEtxS8TmDDjXcTkA85tYHu508W2HqYc9iQweETK+pLyaFa86NqcQ
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:49:: with SMTP id i9mr4000965ilr.236.1591808596058;
 Wed, 10 Jun 2020 10:03:16 -0700 (PDT)
Date:   Wed, 10 Jun 2020 10:03:16 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000eb293205a7bdd19a@google.com>
Subject: KASAN: use-after-free Write in addr_resolve
From:   syzbot <syzbot+08092148130652a6faae@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dledford@redhat.com, dsahern@gmail.com,
        haakon.bugge@oracle.com, jgg@ziepe.ca, kuba@kernel.org,
        leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, parav@mellanox.com, sd@queasysnail.net,
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
console output: https://syzkaller.appspot.com/x/log.txt?x=15fc1c7a100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=be4578b3f1083656
dashboard link: https://syzkaller.appspot.com/bug?extid=08092148130652a6faae
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+08092148130652a6faae@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in addr6_resolve drivers/infiniband/core/addr.c:437 [inline]
BUG: KASAN: use-after-free in addr_resolve+0x1871/0x1b80 drivers/infiniband/core/addr.c:588
Write of size 4 at addr ffff8880938d31a4 by task kworker/u4:0/7

CPU: 1 PID: 7 Comm: kworker/u4:0 Not tainted 5.7.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: ib_addr process_one_req
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1e9/0x30e lib/dump_stack.c:118
 print_address_description+0x66/0x5a0 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report+0x132/0x1d0 mm/kasan/report.c:530
 addr6_resolve drivers/infiniband/core/addr.c:437 [inline]
 addr_resolve+0x1871/0x1b80 drivers/infiniband/core/addr.c:588
 process_one_req+0xfb/0x570 drivers/infiniband/core/addr.c:628
 process_one_work+0x76e/0xfd0 kernel/workqueue.c:2268
 worker_thread+0xa7f/0x1450 kernel/workqueue.c:2414
 kthread+0x353/0x380 kernel/kthread.c:268
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:351

Allocated by task 3840:
 save_stack mm/kasan/common.c:48 [inline]
 set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc+0x103/0x140 mm/kasan/common.c:494
 kmem_cache_alloc_trace+0x234/0x300 mm/slab.c:3551
 kmalloc include/linux/slab.h:555 [inline]
 kzalloc include/linux/slab.h:669 [inline]
 __rdma_create_id+0x63/0x4f0 drivers/infiniband/core/cma.c:861
 ucma_create_id+0x259/0x540 drivers/infiniband/core/ucma.c:503
 ucma_write+0x2d3/0x350 drivers/infiniband/core/ucma.c:1729
 __vfs_write+0x9c/0x6e0 fs/read_write.c:495
 vfs_write+0x274/0x580 fs/read_write.c:559
 ksys_write+0x11b/0x220 fs/read_write.c:612
 do_syscall_64+0xf3/0x1b0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3

Freed by task 3832:
 save_stack mm/kasan/common.c:48 [inline]
 set_track mm/kasan/common.c:56 [inline]
 kasan_set_free_info mm/kasan/common.c:316 [inline]
 __kasan_slab_free+0x114/0x170 mm/kasan/common.c:455
 __cache_free mm/slab.c:3426 [inline]
 kfree+0x10a/0x220 mm/slab.c:3757
 ucma_close+0x228/0x310 drivers/infiniband/core/ucma.c:1807
 __fput+0x2ed/0x750 fs/file_table.c:281
 task_work_run+0x147/0x1d0 kernel/task_work.c:123
 tracehook_notify_resume include/linux/tracehook.h:188 [inline]
 exit_to_usermode_loop arch/x86/entry/common.c:165 [inline]
 prepare_exit_to_usermode+0x48e/0x600 arch/x86/entry/common.c:196
 entry_SYSCALL_64_after_hwframe+0x49/0xb3

The buggy address belongs to the object at ffff8880938d3000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 420 bytes inside of
 2048-byte region [ffff8880938d3000, ffff8880938d3800)
The buggy address belongs to the page:
page:ffffea00024e34c0 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0
flags: 0xfffe0000000200(slab)
raw: 00fffe0000000200 ffffea00024f7188 ffffea00029aed48 ffff8880aa400e00
raw: 0000000000000000 ffff8880938d3000 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8880938d3080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880938d3100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff8880938d3180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                               ^
 ffff8880938d3200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880938d3280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
