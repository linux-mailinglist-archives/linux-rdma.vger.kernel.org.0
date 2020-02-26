Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0883916F848
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2020 08:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgBZHAO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Feb 2020 02:00:14 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:34959 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbgBZHAO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 Feb 2020 02:00:14 -0500
Received: by mail-io1-f72.google.com with SMTP id w16so2172240iot.2
        for <linux-rdma@vger.kernel.org>; Tue, 25 Feb 2020 23:00:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ZM4zSFD0p9Gcy0AqqOMlHJsUTIk3c+UXG36FqEVlS20=;
        b=QDaILoZ9Y48mVgld05SiujtXTc2xP4yc+BtZBzgqzJg+7MzYNWSpN4IJD8W9n6oHXv
         so24ZAVXo6tgz/Fz1UBqtK9/auq7EH9BtwLITzw9Yx7UoNhI121KE+1a+zVF/c7B8gIw
         u2VLcDPnoowCXCoKQ8543Eulxo+gKSNAHm0PZvOQj+YhK8jrbZyXJmnVcJGQ2OasYUlB
         OuDFbZGRpNtNu3oVdMiWtIo+ScbUyJHhz+md0EFVXeMYi3UDXlNvdOsoFBQVdjqjUtKw
         seFIufHT8CIWNQr2uGxundkPMEGcndB6OCjL3UiaiGWdMcOb5XgINHJ2nzc5z7mP+5cc
         GQIg==
X-Gm-Message-State: APjAAAUADPndyof22fE8VfMm6RFDfLv6G27Ox/IPzhH9w8fXMgtSaPU5
        uJE8VzSangz6eroAzWM1exH+NcsbygHwUTYDFc/waZFtiN+r
X-Google-Smtp-Source: APXvYqxHoH7MV3i7PnOB7/GHzEDVXOK0je2QH77Mv1rHBMF223xfndpSk4uDYq2/wKcS4BMm3s6tamQ4zszOyl2GQJPyNKWQgCqS
MIME-Version: 1.0
X-Received: by 2002:a92:3cd7:: with SMTP id j84mr3100660ilf.176.1582700413125;
 Tue, 25 Feb 2020 23:00:13 -0800 (PST)
Date:   Tue, 25 Feb 2020 23:00:13 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e908c5059f752767@google.com>
Subject: KASAN: use-after-free Read in iwcm_deref_id
From:   syzbot <syzbot+cb0c054eabfba4342146@syzkaller.appspotmail.com>
To:     bmt@zurich.ibm.com, dledford@redhat.com, jgg@ziepe.ca,
        kamalheib1@gmail.com, krishna2@chelsio.com,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    f8788d86 Linux 5.6-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=164503d9e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5d2e033af114153f
dashboard link: https://syzkaller.appspot.com/bug?extid=cb0c054eabfba4342146
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+cb0c054eabfba4342146@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in dealloc_work_entries drivers/infiniband/core/iwcm.c:162 [inline]
BUG: KASAN: use-after-free in free_cm_id drivers/infiniband/core/iwcm.c:202 [inline]
BUG: KASAN: use-after-free in iwcm_deref_id+0xf6/0x170 drivers/infiniband/core/iwcm.c:215
Read of size 8 at addr ffff8880a0d05978 by task syz-executor.2/15428

CPU: 1 PID: 15428 Comm: syz-executor.2 Not tainted 5.6.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1fb/0x318 lib/dump_stack.c:118
 print_address_description+0x74/0x5c0 mm/kasan/report.c:374
 __kasan_report+0x149/0x1c0 mm/kasan/report.c:506
 kasan_report+0x26/0x50 mm/kasan/common.c:641
 __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:135
 dealloc_work_entries drivers/infiniband/core/iwcm.c:162 [inline]
 free_cm_id drivers/infiniband/core/iwcm.c:202 [inline]
 iwcm_deref_id+0xf6/0x170 drivers/infiniband/core/iwcm.c:215
 destroy_cm_id+0x4b2/0x5b0 drivers/infiniband/core/iwcm.c:442
 iw_destroy_cm_id+0x15/0x20 drivers/infiniband/core/iwcm.c:453
 cma_iw_listen drivers/infiniband/core/cma.c:2453 [inline]
 rdma_listen+0x6dc/0x9a0 drivers/infiniband/core/cma.c:3614
 cma_listen_on_dev+0x678/0x8e0 drivers/infiniband/core/cma.c:2501
 cma_listen_on_all drivers/infiniband/core/cma.c:2514 [inline]
 rdma_listen+0x43b/0x9a0 drivers/infiniband/core/cma.c:3622
 ucma_listen+0x245/0x300 drivers/infiniband/core/ucma.c:1092
 ucma_write+0x2da/0x360 drivers/infiniband/core/ucma.c:1684
 __vfs_write+0xb8/0x740 fs/read_write.c:494
 vfs_write+0x270/0x580 fs/read_write.c:558
 ksys_write+0x117/0x220 fs/read_write.c:611
 __do_sys_write fs/read_write.c:623 [inline]
 __se_sys_write fs/read_write.c:620 [inline]
 __x64_sys_write+0x7b/0x90 fs/read_write.c:620
 do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45c449
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fe499194c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fe4991956d4 RCX: 000000000045c449
RDX: 0000000000000010 RSI: 0000000020000000 RDI: 0000000000000003
RBP: 000000000076bf20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000008
R13: 0000000000000cbe R14: 00000000004cea14 R15: 0000000000000007

Allocated by task 15428:
 save_stack mm/kasan/common.c:72 [inline]
 set_track mm/kasan/common.c:80 [inline]
 __kasan_kmalloc+0x118/0x1c0 mm/kasan/common.c:515
 kasan_kmalloc+0x9/0x10 mm/kasan/common.c:529
 kmem_cache_alloc_trace+0x221/0x2f0 mm/slab.c:3551
 kmalloc include/linux/slab.h:555 [inline]
 alloc_work_entries drivers/infiniband/core/iwcm.c:172 [inline]
 iw_cm_listen+0xdd/0x4a0 drivers/infiniband/core/iwcm.c:571
 cma_iw_listen drivers/infiniband/core/cma.c:2450 [inline]
 rdma_listen+0x698/0x9a0 drivers/infiniband/core/cma.c:3614
 cma_listen_on_dev+0x678/0x8e0 drivers/infiniband/core/cma.c:2501
 cma_listen_on_all drivers/infiniband/core/cma.c:2514 [inline]
 rdma_listen+0x43b/0x9a0 drivers/infiniband/core/cma.c:3622
 ucma_listen+0x245/0x300 drivers/infiniband/core/ucma.c:1092
 ucma_write+0x2da/0x360 drivers/infiniband/core/ucma.c:1684
 __vfs_write+0xb8/0x740 fs/read_write.c:494
 vfs_write+0x270/0x580 fs/read_write.c:558
 ksys_write+0x117/0x220 fs/read_write.c:611
 __do_sys_write fs/read_write.c:623 [inline]
 __se_sys_write fs/read_write.c:620 [inline]
 __x64_sys_write+0x7b/0x90 fs/read_write.c:620
 do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 15428:
 save_stack mm/kasan/common.c:72 [inline]
 set_track mm/kasan/common.c:80 [inline]
 kasan_set_free_info mm/kasan/common.c:337 [inline]
 __kasan_slab_free+0x12e/0x1e0 mm/kasan/common.c:476
 kasan_slab_free+0xe/0x10 mm/kasan/common.c:485
 __cache_free mm/slab.c:3426 [inline]
 kfree+0x10d/0x220 mm/slab.c:3757
 dealloc_work_entries drivers/infiniband/core/iwcm.c:163 [inline]
 alloc_work_entries drivers/infiniband/core/iwcm.c:174 [inline]
 iw_cm_listen+0x288/0x4a0 drivers/infiniband/core/iwcm.c:571
 cma_iw_listen drivers/infiniband/core/cma.c:2450 [inline]
 rdma_listen+0x698/0x9a0 drivers/infiniband/core/cma.c:3614
 cma_listen_on_dev+0x678/0x8e0 drivers/infiniband/core/cma.c:2501
 cma_listen_on_all drivers/infiniband/core/cma.c:2514 [inline]
 rdma_listen+0x43b/0x9a0 drivers/infiniband/core/cma.c:3622
 ucma_listen+0x245/0x300 drivers/infiniband/core/ucma.c:1092
 ucma_write+0x2da/0x360 drivers/infiniband/core/ucma.c:1684
 __vfs_write+0xb8/0x740 fs/read_write.c:494
 vfs_write+0x270/0x580 fs/read_write.c:558
 ksys_write+0x117/0x220 fs/read_write.c:611
 __do_sys_write fs/read_write.c:623 [inline]
 __se_sys_write fs/read_write.c:620 [inline]
 __x64_sys_write+0x7b/0x90 fs/read_write.c:620
 do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8880a0d05800
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 376 bytes inside of
 512-byte region [ffff8880a0d05800, ffff8880a0d05a00)
The buggy address belongs to the page:
page:ffffea0002834140 refcount:1 mapcount:0 mapping:ffff8880aa400a80 index:0x0
flags: 0xfffe0000000200(slab)
raw: 00fffe0000000200 ffffea0001019988 ffffea000280e088 ffff8880aa400a80
raw: 0000000000000000 ffff8880a0d05000 0000000100000004 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8880a0d05800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880a0d05880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff8880a0d05900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                                ^
 ffff8880a0d05980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880a0d05a00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
