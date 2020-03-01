Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 412F3174CED
	for <lists+linux-rdma@lfdr.de>; Sun,  1 Mar 2020 12:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725874AbgCALUN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 1 Mar 2020 06:20:13 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:48172 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgCALUN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 1 Mar 2020 06:20:13 -0500
Received: by mail-il1-f199.google.com with SMTP id u14so8260116ilq.15
        for <linux-rdma@vger.kernel.org>; Sun, 01 Mar 2020 03:20:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Qx4YvZdSMNbsqVf6NVymsMcbS9Wpvdv4eBcWmfY1IYs=;
        b=fyl+KfAAF5yvuFovJT0P7znwhyrHjFk6PxWsEyRszT878k/CKZYFspcREEgqZ/j/gu
         NB5OLThMMT55zab21LcBPXG+cPyf9xgtPbMq/zzZMZLLntZyd3jEeeuoNFl0LkhHoaNM
         /n8kKSPylGqdunenvx00Pccro16oyFECvtVJLQ2Q+nM+UatrFKM1t4uV9pLaKQ1XR2wF
         IcfjoIB4QIkacOziapej25dE/08OM2/SGGJIVFzh6HlN7NhMOJ0HQ4m1CVl3habgaS6y
         uTB1MFEAPnzijO5+rF+LO6PKnycHnBzTEn9hDfTofYObhDNcq7aqsQ9PlHzg+yS2B19L
         NbjA==
X-Gm-Message-State: APjAAAWNmhDZwx/GVvdhdlXN4PhYvjW2ZQ5v6K57Qha7h+KYiyOYM0dG
        KsA2VgbDHp8tFMAXvIztSOjls9W6VXWu8dLxqOitoWxu7uph
X-Google-Smtp-Source: APXvYqwe6poPv3x76uGWJe0AWoOr/g0M3D2qVW1z2jyo5Su21oATcfuvyBKiDuEFaC9WODsRAdjYwXTg8v+DQaxihkrl3p/1vlwe
MIME-Version: 1.0
X-Received: by 2002:a02:8809:: with SMTP id r9mr9877507jai.50.1583061612140;
 Sun, 01 Mar 2020 03:20:12 -0800 (PST)
Date:   Sun, 01 Mar 2020 03:20:12 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000c9e12059fc941ff@google.com>
Subject: KASAN: use-after-free Read in rxe_query_port
From:   syzbot <syzbot+e11efb687f5ab7f01f3d@syzkaller.appspotmail.com>
To:     dledford@redhat.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, monis@mellanox.com,
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
console output: https://syzkaller.appspot.com/x/log.txt?x=132d3645e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9833e26bab355358
dashboard link: https://syzkaller.appspot.com/bug?extid=e11efb687f5ab7f01f3d
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+e11efb687f5ab7f01f3d@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in rxe_query_port+0x294/0x2e0 drivers/infiniband/sw/rxe/rxe_verbs.c:71
Read of size 4 at addr ffff8880881b4c20 by task kworker/1:194/2945

CPU: 1 PID: 2945 Comm: kworker/1:194 Not tainted 5.6.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events smc_ib_port_event_work
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x197/0x210 lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0xd4/0x30b mm/kasan/report.c:374
 __kasan_report.cold+0x1b/0x32 mm/kasan/report.c:506
 kasan_report+0x12/0x20 mm/kasan/common.c:641
 __asan_report_load4_noabort+0x14/0x20 mm/kasan/generic_report.c:134
 rxe_query_port+0x294/0x2e0 drivers/infiniband/sw/rxe/rxe_verbs.c:71
 __ib_query_port drivers/infiniband/core/device.c:2022 [inline]
 ib_query_port drivers/infiniband/core/device.c:2057 [inline]
 ib_query_port+0x523/0xac0 drivers/infiniband/core/device.c:2047
 smc_ib_remember_port_attr net/smc/smc_ib.c:219 [inline]
 smc_ib_port_event_work+0x12e/0x350 net/smc/smc_ib.c:244
 process_one_work+0xa05/0x17a0 kernel/workqueue.c:2264
 worker_thread+0x98/0xe40 kernel/workqueue.c:2410
 kthread+0x361/0x430 kernel/kthread.c:255
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

Allocated by task 10530:
 save_stack+0x23/0x90 mm/kasan/common.c:72
 set_track mm/kasan/common.c:80 [inline]
 __kasan_kmalloc mm/kasan/common.c:515 [inline]
 __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:488
 kasan_kmalloc+0x9/0x10 mm/kasan/common.c:529
 kmem_cache_alloc_trace+0x158/0x790 mm/slab.c:3551
 kmalloc include/linux/slab.h:555 [inline]
 kzalloc include/linux/slab.h:669 [inline]
 smc_ib_add_dev net/smc/smc_ib.c:541 [inline]
 smc_ib_add_dev+0xae/0x5c0 net/smc/smc_ib.c:532
 add_client_context+0x3dd/0x550 drivers/infiniband/core/device.c:681
 enable_device_and_get+0x1df/0x3c0 drivers/infiniband/core/device.c:1316
 ib_register_device drivers/infiniband/core/device.c:1382 [inline]
 ib_register_device+0xa89/0xe40 drivers/infiniband/core/device.c:1343
 rxe_register_device+0x52e/0x655 drivers/infiniband/sw/rxe/rxe_verbs.c:1231
 rxe_add+0x122b/0x1661 drivers/infiniband/sw/rxe/rxe.c:302
 rxe_net_add+0x91/0xf0 drivers/infiniband/sw/rxe/rxe_net.c:539
 rxe_newlink+0x39/0x90 drivers/infiniband/sw/rxe/rxe.c:318
 nldev_newlink+0x28a/0x430 drivers/infiniband/core/nldev.c:1538
 rdma_nl_rcv_msg drivers/infiniband/core/netlink.c:195 [inline]
 rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
 rdma_nl_rcv+0x5d9/0x980 drivers/infiniband/core/netlink.c:259
 netlink_unicast_kernel net/netlink/af_netlink.c:1303 [inline]
 netlink_unicast+0x59e/0x7e0 net/netlink/af_netlink.c:1329
 netlink_sendmsg+0x91c/0xea0 net/netlink/af_netlink.c:1918
 sock_sendmsg_nosec net/socket.c:652 [inline]
 sock_sendmsg+0xd7/0x130 net/socket.c:672
 ____sys_sendmsg+0x753/0x880 net/socket.c:2343
 ___sys_sendmsg+0x100/0x170 net/socket.c:2397
 __sys_sendmsg+0x105/0x1d0 net/socket.c:2430
 __do_sys_sendmsg net/socket.c:2439 [inline]
 __se_sys_sendmsg net/socket.c:2437 [inline]
 __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2437
 do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 83:
 save_stack+0x23/0x90 mm/kasan/common.c:72
 set_track mm/kasan/common.c:80 [inline]
 kasan_set_free_info mm/kasan/common.c:337 [inline]
 __kasan_slab_free+0x102/0x150 mm/kasan/common.c:476
 kasan_slab_free+0xe/0x10 mm/kasan/common.c:485
 __cache_free mm/slab.c:3426 [inline]
 kfree+0x10a/0x2c0 mm/slab.c:3757
 smc_ib_remove_dev+0x1a9/0x2e0 net/smc/smc_ib.c:583
 remove_client_context+0xc7/0x120 drivers/infiniband/core/device.c:724
 disable_device+0x14c/0x230 drivers/infiniband/core/device.c:1268
 __ib_unregister_device+0x9c/0x190 drivers/infiniband/core/device.c:1435
 ib_unregister_work+0x19/0x30 drivers/infiniband/core/device.c:1545
 process_one_work+0xa05/0x17a0 kernel/workqueue.c:2264
 worker_thread+0x98/0xe40 kernel/workqueue.c:2410
 kthread+0x361/0x430 kernel/kthread.c:255
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

The buggy address belongs to the object at ffff8880881b4c00
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 32 bytes inside of
 512-byte region [ffff8880881b4c00, ffff8880881b4e00)
The buggy address belongs to the page:
page:ffffea0002206d00 refcount:1 mapcount:0 mapping:ffff8880aa400a80 index:0x0
flags: 0xfffe0000000200(slab)
raw: 00fffe0000000200 ffffea00026a5208 ffffea00029ea608 ffff8880aa400a80
raw: 0000000000000000 ffff8880881b4000 0000000100000004 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8880881b4b00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880881b4b80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff8880881b4c00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                               ^
 ffff8880881b4c80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880881b4d00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
