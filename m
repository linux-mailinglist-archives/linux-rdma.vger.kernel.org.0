Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6431324BAA
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Feb 2021 09:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235392AbhBYID4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Feb 2021 03:03:56 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:44696 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235342AbhBYID4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Feb 2021 03:03:56 -0500
Received: by mail-io1-f71.google.com with SMTP id v20so3679762iob.11
        for <linux-rdma@vger.kernel.org>; Thu, 25 Feb 2021 00:03:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=jlsLdlfAeeYm3GSnn7ckzgMhfO3YG8JIFGtQXqDZgPw=;
        b=M0/o61yuP/lgevGOKroJ7w3wEijVQ7p4OoA1jaFI+4k9SZuPVQwarjRap6JfS/cWxa
         FvIHKLUP3/bSR9+kDkhncEXNK5MFriRCJiwCHdAuPovR/m7D1FfDAee/lU2zPPY2LCXn
         FdC4fm5jHZ50gLv5TOg6O2GtZb94FL/Q7+ZDhp1OwjVt1SqGWLCK61Z8BRL+aBAJN1Xh
         roYEd9eOAgkgrv/i0Qb1vv2OX5Dbm7zSc90MYjaGH9zKL2zs5YwAs2lJSpiXQq8xku4y
         +fbb/ABWeco6sIC0CmqaWxvGO3Bw1dPWjK/y+QPyTFw4bdYXdqBorYLNBAyf3LHEXh0f
         EF+w==
X-Gm-Message-State: AOAM5326tx021D8ElLo4ErTUoRsUR+N+a2t/G8wUxBcKMUiAE26240WH
        aDybFbjtpAPa8Ns8O+L+mKMnY/plib7O2sVXAslkGodOI25j
X-Google-Smtp-Source: ABdhPJwRbqWkaeICViZ/G3JuiAWIWAe+uf4fp2eUam2UFWkHDIw7TtkBstWGA6OTHf4Agg1N2HD9gME93xFkLiuCuZPfjd8c6vSm
MIME-Version: 1.0
X-Received: by 2002:a6b:f708:: with SMTP id k8mr1703093iog.187.1614240195234;
 Thu, 25 Feb 2021 00:03:15 -0800 (PST)
Date:   Thu, 25 Feb 2021 00:03:15 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006b4d6e05bc2495a7@google.com>
Subject: KASAN: use-after-free Write in addr_resolve (2)
From:   syzbot <syzbot+507b7f64b139d1dfea45@syzkaller.appspotmail.com>
To:     dledford@redhat.com, jgg@ziepe.ca, leon@kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    e767b353 Merge tag 'arm-drivers-v5.12' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10915934d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5906640bbd7c47d4
dashboard link: https://syzkaller.appspot.com/bug?extid=507b7f64b139d1dfea45
compiler:       Debian clang version 11.0.1-2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+507b7f64b139d1dfea45@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in addr6_resolve drivers/infiniband/core/addr.c:439 [inline]
BUG: KASAN: use-after-free in addr_resolve+0x1844/0x1b40 drivers/infiniband/core/addr.c:590
Write of size 4 at addr ffff88802f7e01a4 by task kworker/u4:3/114

CPU: 1 PID: 114 Comm: kworker/u4:3 Not tainted 5.11.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: ib_addr process_one_req
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x137/0x1be lib/dump_stack.c:120
 print_address_description+0x5f/0x3a0 mm/kasan/report.c:230
 __kasan_report mm/kasan/report.c:396 [inline]
 kasan_report+0x15e/0x200 mm/kasan/report.c:413
 addr6_resolve drivers/infiniband/core/addr.c:439 [inline]
 addr_resolve+0x1844/0x1b40 drivers/infiniband/core/addr.c:590
 process_one_req+0x105/0x550 drivers/infiniband/core/addr.c:630
 process_one_work+0x789/0xfc0 kernel/workqueue.c:2275
 worker_thread+0xac1/0x1300 kernel/workqueue.c:2421
 kthread+0x39a/0x3c0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296

Allocated by task 13814:
 kasan_save_stack mm/kasan/common.c:38 [inline]
 kasan_set_track mm/kasan/common.c:46 [inline]
 set_alloc_info mm/kasan/common.c:401 [inline]
 ____kasan_kmalloc+0xbd/0xf0 mm/kasan/common.c:429
 kasan_kmalloc include/linux/kasan.h:219 [inline]
 kmem_cache_alloc_trace+0x200/0x300 mm/slub.c:2919
 kmalloc include/linux/slab.h:552 [inline]
 kzalloc include/linux/slab.h:682 [inline]
 __rdma_create_id+0x65/0x4f0 drivers/infiniband/core/cma.c:838
 rdma_create_user_id+0x7f/0xc0 drivers/infiniband/core/cma.c:891
 ucma_create_id+0x1de/0x5c0 drivers/infiniband/core/ucma.c:461
 ucma_write+0x279/0x350 drivers/infiniband/core/ucma.c:1732
 vfs_write+0x220/0xab0 fs/read_write.c:603
 ksys_write+0x11b/0x220 fs/read_write.c:658
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Freed by task 13811:
 kasan_save_stack mm/kasan/common.c:38 [inline]
 kasan_set_track+0x3d/0x70 mm/kasan/common.c:46
 kasan_set_free_info+0x1f/0x40 mm/kasan/generic.c:356
 ____kasan_slab_free+0xe2/0x110 mm/kasan/common.c:362
 kasan_slab_free include/linux/kasan.h:192 [inline]
 slab_free_hook mm/slub.c:1547 [inline]
 slab_free_freelist_hook+0xd6/0x1a0 mm/slub.c:1580
 slab_free mm/slub.c:3143 [inline]
 kfree+0xd1/0x2a0 mm/slub.c:4139
 ucma_close_id drivers/infiniband/core/ucma.c:185 [inline]
 ucma_destroy_private_ctx+0x111/0xa50 drivers/infiniband/core/ucma.c:576
 ucma_close+0xef/0x170 drivers/infiniband/core/ucma.c:1797
 __fput+0x34d/0x7a0 fs/file_table.c:280
 task_work_run+0x137/0x1c0 kernel/task_work.c:140
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
 exit_to_user_mode_prepare+0x10b/0x1e0 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x48/0x180 kernel/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

The buggy address belongs to the object at ffff88802f7e0000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 420 bytes inside of
 2048-byte region [ffff88802f7e0000, ffff88802f7e0800)
The buggy address belongs to the page:
page:00000000f60da0cc refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2f7e0
head:00000000f60da0cc order:3 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head)
raw: 00fff00000010200 dead000000000100 dead000000000122 ffff888011042000
raw: 0000000000000000 0000000080080008 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88802f7e0080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802f7e0100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88802f7e0180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                               ^
 ffff88802f7e0200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802f7e0280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
