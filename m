Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A466266287
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Sep 2020 17:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726021AbgIKPwO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Sep 2020 11:52:14 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:42267 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbgIKPtF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Sep 2020 11:49:05 -0400
Received: by mail-io1-f70.google.com with SMTP id v13so7128290ios.9
        for <linux-rdma@vger.kernel.org>; Fri, 11 Sep 2020 08:49:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=UyAw9auyKQ12heKGY0NjVfj47svD8TkOKeEailtA6+E=;
        b=jo98pHmVpShhRqXfx6Cy5+mgzuGOpiS64DQnSjqsUVRx+Q40Gj+LKK/QGF/1wNE8pn
         aXQYa4qW+r5g+YT30bOH3CjmBr9P/IK/5LnCkZRf+4G94SjGUMiOFrDctLJ2cB+JDbJk
         9N2xEPBqPnj71VChEMQBDSnUmHx3+dZLB5PMBsWf8l59FDyEAVY3BDQunFxkPlBONU8G
         Pp7J9jC7KbpYLn6upY7ipR43uKlNEzGsQYlhDErTsATi39IQ4k4jOkZffilKpYTLJlwk
         0cd7wdhEM9mBBnmMmP7Z0725D5ZhXJe6uWpSp1tHcFATFum9+SLu3DbETCSI7qYnL89Z
         9zBQ==
X-Gm-Message-State: AOAM530LThWIF5VaGCLFTHbw/vfXSflEIhXU3CVnSflfrN6w2RmG/fJH
        BZUcpwMQiHi63DuTp9RJ1gDIeQJtbVQ9BkvBHNWpVDAte6XA
X-Google-Smtp-Source: ABdhPJy+wrpMhNm4Pa2qxe83TrNBwES/gNGCnbDyikyXgkJjUvF/3r8mta49o3F8rIZ1vSCsiqfwzrtrb6/XL6ag/p8YCaOjPmyC
MIME-Version: 1.0
X-Received: by 2002:a6b:7a41:: with SMTP id k1mr2247429iop.187.1599839344326;
 Fri, 11 Sep 2020 08:49:04 -0700 (PDT)
Date:   Fri, 11 Sep 2020 08:49:04 -0700
In-Reply-To: <20200911120222.GT87483@ziepe.ca>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d1020c05af0b9fdc@google.com>
Subject: Re: KASAN: use-after-free Read in ucma_close (2)
From:   syzbot <syzbot+cc6fc752b3819e082d0c@syzkaller.appspotmail.com>
To:     dledford@redhat.com, jgg@ziepe.ca, leon@kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: use-after-free Read in __destroy_id

==================================================================
BUG: KASAN: use-after-free in __destroy_id+0x9f5/0xc60 drivers/infiniband/core/ucma.c:620
Read of size 4 at addr ffff88808e210128 by task syz-executor.2/11716

CPU: 1 PID: 11716 Comm: syz-executor.2 Not tainted 5.9.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0xae/0x497 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:530
 __destroy_id+0x9f5/0xc60 drivers/infiniband/core/ucma.c:620
 ucma_destroy_id+0x172/0x240 drivers/infiniband/core/ucma.c:654
 ucma_write+0x288/0x350 drivers/infiniband/core/ucma.c:1784
 vfs_write+0x2b0/0x730 fs/read_write.c:576
 ksys_write+0x1ee/0x250 fs/read_write.c:631
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45d5b9
Code: 5d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 2b b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ff28d19dc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000038340 RCX: 000000000045d5b9
RDX: 0000000000000018 RSI: 00000000200000c0 RDI: 0000000000000005
RBP: 000000000118cf80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000118cf4c
R13: 00007ffcebc2643f R14: 00007ff28d19e9c0 R15: 000000000118cf4c

Allocated by task 11716:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
 kasan_set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:461
 kmem_cache_alloc_trace+0x16e/0x2c0 mm/slab.c:3550
 kmalloc include/linux/slab.h:554 [inline]
 kzalloc include/linux/slab.h:666 [inline]
 ucma_alloc_ctx+0x41/0x330 drivers/infiniband/core/ucma.c:211
 ucma_create_id+0x10f/0x410 drivers/infiniband/core/ucma.c:497
 ucma_write+0x288/0x350 drivers/infiniband/core/ucma.c:1784
 vfs_write+0x2b0/0x730 fs/read_write.c:576
 ksys_write+0x1ee/0x250 fs/read_write.c:631
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Freed by task 11715:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
 kasan_set_track+0x1c/0x30 mm/kasan/common.c:56
 kasan_set_free_info+0x1b/0x30 mm/kasan/generic.c:355
 __kasan_slab_free+0xd8/0x120 mm/kasan/common.c:422
 __cache_free mm/slab.c:3418 [inline]
 kfree+0x103/0x2c0 mm/slab.c:3756
 ucma_free_ctx drivers/infiniband/core/ucma.c:599 [inline]
 __destroy_id+0x8a2/0xc60 drivers/infiniband/core/ucma.c:628
 ucma_close+0xe1/0x190 drivers/infiniband/core/ucma.c:1849
 __fput+0x285/0x920 fs/file_table.c:281
 task_work_run+0xdd/0x190 kernel/task_work.c:141
 tracehook_notify_resume include/linux/tracehook.h:188 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:139 [inline]
 exit_to_user_mode_prepare+0x195/0x1c0 kernel/entry/common.c:166
 syscall_exit_to_user_mode+0x59/0x2b0 kernel/entry/common.c:241
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

The buggy address belongs to the object at ffff88808e210000
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 296 bytes inside of
 512-byte region [ffff88808e210000, ffff88808e210200)
The buggy address belongs to the page:
page:000000007a3e4a58 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88808e210c00 pfn:0x8e210
flags: 0xfffe0000000200(slab)
raw: 00fffe0000000200 ffffea0002404fc8 ffffea00028aa008 ffff8880aa040600
raw: ffff88808e210c00 ffff88808e210000 0000000100000003 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88808e210000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88808e210080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88808e210100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                  ^
 ffff88808e210180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88808e210200: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


Tested on:

commit:         308571de RDMA/ucma: Do not use file->mut to lock destroying
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git
console output: https://syzkaller.appspot.com/x/log.txt?x=112f7cdd900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3d400a47d1416652
dashboard link: https://syzkaller.appspot.com/bug?extid=cc6fc752b3819e082d0c
compiler:       gcc (GCC) 10.1.0-syz 20200507

