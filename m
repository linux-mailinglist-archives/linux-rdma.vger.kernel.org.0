Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D30741E6406
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2020 16:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391206AbgE1OdU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 May 2020 10:33:20 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:48916 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391060AbgE1OdS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 28 May 2020 10:33:18 -0400
Received: by mail-il1-f199.google.com with SMTP id v1so154599ilo.15
        for <linux-rdma@vger.kernel.org>; Thu, 28 May 2020 07:33:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=r0HKqgdhJtwK3Rn/nnQIp8bGjfzLHtJg42Ae12c/0QQ=;
        b=khDOs7iWZKkJktiD8zBFgbXThg+q1MdRicy4aMWqpGwMCYRXPJu3ansMiOa8Pbayda
         sXBysXvbMmM7x9mQNPBI4PLctCUyd2KQOZPBNvbyUU9+AdJA30Lrng4xwCH5PNsiapzB
         f1/7fnbDUXtOou3LDXgs3yEAsttjty4YwaF7znK/aBGZlD3b4EM0lwlFo69EghqX9c6J
         esbpq6ku23SAJ2vRoM5VHBZIEpJqfalhl7PKUOIdzEtaOM6QmfFwoI51n1xnTtM8XHN2
         6AKAQqDy+aravL93ysLxq9D4JSQTaqXynp1QkNGpbEsozFA1TsJRNa5WVekbxagMroZo
         olpw==
X-Gm-Message-State: AOAM532SHvIFy1SnWgcv/heIfeH1DSwitV6Jieaf0K+MCuyEfuqwnaoM
        JRNI/p9STBTFhSGZ4w+awaXWQhc/4phVoi+m9uRlFWdOjyyB
X-Google-Smtp-Source: ABdhPJx9kpqfzbPuMCftGy8LLav34z4f4x3zyYa6HVRLXwZnvN0CfDOS1sivogwnV9c8myhyctGERG/HqSSPL2s4xBezdC+AeIow
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:49:: with SMTP id i9mr3075622ilr.236.1590676396785;
 Thu, 28 May 2020 07:33:16 -0700 (PDT)
Date:   Thu, 28 May 2020 07:33:16 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000095442505a6b63551@google.com>
Subject: KASAN: use-after-free Read in ib_uverbs_remove_one
From:   syzbot <syzbot+478fd0d54412b8759e0d@syzkaller.appspotmail.com>
To:     dledford@redhat.com, jgg@ziepe.ca, leon@kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        michal.kalderon@marvell.com, syzkaller-bugs@googlegroups.com,
        yishaih@mellanox.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    c11d28ab Add linux-next specific files for 20200522
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12fc3e72100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3f6dbdea4159fb66
dashboard link: https://syzkaller.appspot.com/bug?extid=478fd0d54412b8759e0d
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+478fd0d54412b8759e0d@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in ib_uverbs_remove_one+0x411/0x4e0 drivers/infiniband/core/uverbs_main.c:1210
Read of size 4 at addr ffff888096324578 by task syz-executor.2/15847

CPU: 1 PID: 15847 Comm: syz-executor.2 Not tainted 5.7.0-rc6-next-20200522-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0xd3/0x413 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:530
 ib_uverbs_remove_one+0x411/0x4e0 drivers/infiniband/core/uverbs_main.c:1210
 remove_client_context+0xbe/0x110 drivers/infiniband/core/device.c:732
 disable_device+0x13b/0x230 drivers/infiniband/core/device.c:1278
 __ib_unregister_device+0x91/0x180 drivers/infiniband/core/device.c:1445
 ib_unregister_device_and_put+0x57/0x80 drivers/infiniband/core/device.c:1508
 nldev_dellink+0x20a/0x310 drivers/infiniband/core/nldev.c:1571
 rdma_nl_rcv_msg drivers/infiniband/core/netlink.c:195 [inline]
 rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
 rdma_nl_rcv+0x586/0x900 drivers/infiniband/core/netlink.c:259
 netlink_unicast_kernel net/netlink/af_netlink.c:1303 [inline]
 netlink_unicast+0x537/0x740 net/netlink/af_netlink.c:1329
 netlink_sendmsg+0x882/0xe10 net/netlink/af_netlink.c:1918
 sock_sendmsg_nosec net/socket.c:652 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:672
 ____sys_sendmsg+0x6e6/0x810 net/socket.c:2352
 ___sys_sendmsg+0x100/0x170 net/socket.c:2406
 __sys_sendmsg+0xe5/0x1b0 net/socket.c:2439
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
RIP: 0033:0x45ca29
Code: 0d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 db b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fd6764d1c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00000000004ffa00 RCX: 000000000045ca29
RDX: 0000000000000000 RSI: 0000000020000180 RDI: 0000000000000003
RBP: 000000000078bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000000009af R14: 00000000004d61b0 R15: 00007fd6764d26d4

Allocated by task 9061:
 save_stack+0x1b/0x40 mm/kasan/common.c:48
 set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc mm/kasan/common.c:494 [inline]
 __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:467
 kmem_cache_alloc_trace+0x153/0x7d0 mm/slab.c:3551
 kmalloc include/linux/slab.h:555 [inline]
 kzalloc include/linux/slab.h:669 [inline]
 ib_uverbs_add_one+0x80/0x7c0 drivers/infiniband/core/uverbs_main.c:1107
 add_client_context+0x400/0x5e0 drivers/infiniband/core/device.c:677
 enable_device_and_get+0x1cd/0x3b0 drivers/infiniband/core/device.c:1326
 ib_register_device drivers/infiniband/core/device.c:1392 [inline]
 ib_register_device+0xa12/0xda0 drivers/infiniband/core/device.c:1353
 siw_device_register drivers/infiniband/sw/siw/siw_main.c:70 [inline]
 siw_newlink drivers/infiniband/sw/siw/siw_main.c:565 [inline]
 siw_newlink+0xd37/0x1240 drivers/infiniband/sw/siw/siw_main.c:542
 nldev_newlink+0x29e/0x420 drivers/infiniband/core/nldev.c:1541
 rdma_nl_rcv_msg drivers/infiniband/core/netlink.c:195 [inline]
 rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
 rdma_nl_rcv+0x586/0x900 drivers/infiniband/core/netlink.c:259
 netlink_unicast_kernel net/netlink/af_netlink.c:1303 [inline]
 netlink_unicast+0x537/0x740 net/netlink/af_netlink.c:1329
 netlink_sendmsg+0x882/0xe10 net/netlink/af_netlink.c:1918
 sock_sendmsg_nosec net/socket.c:652 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:672
 ____sys_sendmsg+0x6e6/0x810 net/socket.c:2352
 ___sys_sendmsg+0x100/0x170 net/socket.c:2406
 __sys_sendmsg+0xe5/0x1b0 net/socket.c:2439
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3

Freed by task 15847:
 save_stack+0x1b/0x40 mm/kasan/common.c:48
 set_track mm/kasan/common.c:56 [inline]
 kasan_set_free_info mm/kasan/common.c:316 [inline]
 __kasan_slab_free+0xf7/0x140 mm/kasan/common.c:455
 __cache_free mm/slab.c:3426 [inline]
 kfree+0x109/0x2b0 mm/slab.c:3757
 device_release+0x71/0x200 drivers/base/core.c:1541
 kobject_cleanup lib/kobject.c:701 [inline]
 kobject_release lib/kobject.c:732 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1c8/0x2f0 lib/kobject.c:749
 cdev_device_del+0x69/0x80 fs/char_dev.c:575
 ib_uverbs_remove_one+0x31/0x4e0 drivers/infiniband/core/uverbs_main.c:1209
 remove_client_context+0xbe/0x110 drivers/infiniband/core/device.c:732
 disable_device+0x13b/0x230 drivers/infiniband/core/device.c:1278
 __ib_unregister_device+0x91/0x180 drivers/infiniband/core/device.c:1445
 ib_unregister_device_and_put+0x57/0x80 drivers/infiniband/core/device.c:1508
 nldev_dellink+0x20a/0x310 drivers/infiniband/core/nldev.c:1571
 rdma_nl_rcv_msg drivers/infiniband/core/netlink.c:195 [inline]
 rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
 rdma_nl_rcv+0x586/0x900 drivers/infiniband/core/netlink.c:259
 netlink_unicast_kernel net/netlink/af_netlink.c:1303 [inline]
 netlink_unicast+0x537/0x740 net/netlink/af_netlink.c:1329
 netlink_sendmsg+0x882/0xe10 net/netlink/af_netlink.c:1918
 sock_sendmsg_nosec net/socket.c:652 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:672
 ____sys_sendmsg+0x6e6/0x810 net/socket.c:2352
 ___sys_sendmsg+0x100/0x170 net/socket.c:2406
 __sys_sendmsg+0xe5/0x1b0 net/socket.c:2439
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3

The buggy address belongs to the object at ffff888096324000
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 1400 bytes inside of
 4096-byte region [ffff888096324000, ffff888096325000)
The buggy address belongs to the page:
page:ffffea000258c900 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 head:ffffea000258c900 order:1 compound_mapcount:0
flags: 0xfffe0000010200(slab|head)
raw: 00fffe0000010200 ffffea0002429c08 ffffea000173f988 ffff8880aa002000
raw: 0000000000000000 ffff888096324000 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888096324400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888096324480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888096324500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                                ^
 ffff888096324580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888096324600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
