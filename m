Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 096B444B9E0
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Nov 2021 02:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbhKJBRe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 9 Nov 2021 20:17:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhKJBRd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 9 Nov 2021 20:17:33 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343F8C061764;
        Tue,  9 Nov 2021 17:14:47 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id e65so690254pgc.5;
        Tue, 09 Nov 2021 17:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=f4BZg+zyCuQL92ovVYa1yKqseugsqgPz8oII3/CBUSc=;
        b=CZFnY+KLVOTR+98ZTaydCx/Tuf2uYe2FWa3TNau2/NehbBlX5b0Aw5+2np1Lep/wL3
         xaWbvlZxlXmu+IaMk5qf6Xww/K2cOgdx3CgcRuziSy6JdYQHlIEL+Rghton28aDypobA
         zbDgsERG66qlSo5DsqtI5xOZiYAqOjsh3VueNra/+zz/HUffLvGq7/KKcVtotnl9oNpW
         NkUN9QZvLtxlvpLFui3dOw1bxjokOVLHuXpGqUGeyCzA0lAksrxxBi8YrgxQvUgwYodW
         7fcsvrVz1knLQZlv5L6k7+6U3N77aaUM/lMMlGB9QoOqU1amL83JuM383lsyQhsMp+eK
         kTCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=f4BZg+zyCuQL92ovVYa1yKqseugsqgPz8oII3/CBUSc=;
        b=Bqplab4cHtBukJU0sjlX2zeeQ0tv/zVCW6Ami/fqotynxpyiZR/unT08jPcwQzAWUK
         wssCa4gIZQKN/1L1N7t4D48AvZnTxBBkGnP0uyxJ3TySAKrsk2wFqgX4GFBZA7d7u04S
         i+yHAOs7QDMHHZvbTYqIvBwYULkP47Dv82QseEXIrTjZHCSsS2LYyNPLFxi02rjhB87/
         EYqUg59q82JruEqZo3h6P61FuTPYO/bsBB/PP0oF9BlqDyuFpueme3YDCRCShW5a0rIn
         si+Kr31mDb2FcruP7mCEypaQgwA0aaex/rTIByxyAwyko+ygfliaPBBHgIhj0Gcb4INr
         ocVw==
X-Gm-Message-State: AOAM533sBkAR4gCq6hvH0rQEpDj9ZWgMiMmT6HGEnrRyAFxZvLC7PLpe
        Z7byC+Oo83SGisSC2wWAMKYQUYyJAvKYDa82eA==
X-Google-Smtp-Source: ABdhPJzjD6NtynVSvg5/181v9m8T+KkmO3MGawTfwv/3hE7er/3o8zWj11JA/BojpKgnmCYrODVaVYscoL1ta5hmO2c=
X-Received: by 2002:a05:6a00:1413:b0:47d:2415:a021 with SMTP id
 l19-20020a056a00141300b0047d2415a021mr12776194pfu.43.1636506886541; Tue, 09
 Nov 2021 17:14:46 -0800 (PST)
MIME-Version: 1.0
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Wed, 10 Nov 2021 09:14:36 +0800
Message-ID: <CACkBjsbrf1W=FWBE3PSDoGXK2j+ZaRYdRmMy5AVgJbryWa4+jA@mail.gmail.com>
Subject: KASAN: use-after-free Read in rxe_queue_cleanup
To:     Zhu Yanjun <zyjzyj2000@gmail.com>, dledford@redhat.com,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello,

When using Healer to fuzz the latest Linux kernel, the following crash
was triggered.

HEAD commit: 6b75d88fa81b Merge branch 'i2c/for-current'
git tree: upstream
console output: https://paste.ubuntu.com/p/tfT6HTv37Q/
kernel config: https://paste.ubuntu.com/p/b62Hp7BfJn/

Sorry, I don't have a reproducer for this crash, hope the symbolized
report can help.
If you fix this issue, please add the following tag to the commit:
Reported-by: Hao Sun <sunhao.th@gmail.com>

____sys_sendmsg+0x6e8/0x810 net/socket.c:2409
 ___sys_sendmsg+0x100/0x170 net/socket.c:2463
 __sys_sendmsg+0xe5/0x1b0 net/socket.c:2492
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f0bc939bc4d
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0bc6903c58 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f0bc94c20a0 RCX: 00007f0bc939bc4d
RDX: 000000000004c084 RSI: 0000000020001240 RDI: 0000000000000006
RBP: 00007f0bc9414d80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f0bc94c20a0
R13: 00007ffc009b097f R14: 00007ffc009b0b20 R15: 00007f0bc6903dc0
 </TASK>
Mem-Info:
active_anon:238 inactive_anon:9082 isolated_anon:0
 active_file:23399 inactive_file:5490 isolated_file:0
 unevictable:768 dirty:0 writeback:1
 slab_reclaimable:20646 slab_unreclaimable:53628
 mapped:13097 shmem:6261 pagetables:541 bounce:0
 kernel_misc_reclaimable:0
 free:621846 free_pcp:12564 free_cma:0
Node 0 active_anon:756kB inactive_anon:30820kB active_file:78692kB
inactive_file:17060kB unevictable:1536kB isolated(anon):0kB
isolated(file):0kB mapped:46296kB dirty:0kB writeback:0kB
shmem:19304kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 4096kB
writeback_tmp:0kB kernel_stack:7536kB pagetables:1940kB
all_unreclaimable? no
Node 1 active_anon:196kB inactive_anon:5508kB active_file:14904kB
inactive_file:4900kB unevictable:1536kB isolated(anon):0kB
isolated(file):0kB mapped:6092kB dirty:0kB writeback:4kB shmem:5740kB
shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB
kernel_stack:1236kB pagetables:224kB all_unreclaimable? no
Node 0 DMA free:15280kB boost:0kB min:424kB low:528kB high:632kB
reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB
active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB
present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB
local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 1336 1336 1336 1336
Node 0 DMA32 free:858724kB boost:0kB min:38056kB low:47568kB
high:57080kB reserved_highatomic:0KB active_anon:756kB
inactive_anon:30820kB active_file:78692kB inactive_file:17060kB
unevictable:1536kB writepending:0kB present:2080768kB
managed:1375804kB mlocked:0kB bounce:0kB free_pcp:31720kB
local_pcp:5268kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 1 DMA32 free:982908kB boost:0kB min:27340kB low:34172kB
high:41004kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB
active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB
present:1048444kB managed:982908kB mlocked:0kB bounce:0kB free_pcp:0kB
local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 0 852 852 852
Node 1 Normal free:628680kB boost:0kB min:24284kB low:30352kB
high:36420kB reserved_highatomic:0KB active_anon:196kB
inactive_anon:5508kB active_file:14904kB inactive_file:4900kB
unevictable:1536kB writepending:4kB present:1048576kB managed:873036kB
mlocked:0kB bounce:0kB free_pcp:18892kB local_pcp:6628kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0
Node 0 DMA: 0*4kB 0*8kB 1*16kB (U) 1*32kB (U) 0*64kB 1*128kB (U)
1*256kB (U) 1*512kB (U) 0*1024kB 1*2048kB (M) 3*4096kB (M) = 15280kB
Node 0 DMA32: 125*4kB (UME) 408*8kB (UME) 215*16kB (UME) 622*32kB
(UME) 102*64kB (UME) 76*128kB (UME) 35*256kB (UME) 15*512kB (UME)
6*1024kB (UM) 5*2048kB (UME) 191*4096kB (UM) = 858724kB
Node 1 DMA32: 1*4kB (M) 1*8kB (M) 1*16kB (M) 1*32kB (M) 1*64kB (M)
0*128kB 1*256kB (M) 1*512kB (M) 1*1024kB (M) 1*2048kB (M) 239*4096kB
(M) = 982908kB
Node 1 Normal: 680*4kB (UME) 257*8kB (UME) 222*16kB (UME) 43*32kB (ME)
255*64kB (UME) 131*128kB (UME) 58*256kB (UME) 36*512kB (UME) 17*1024kB
(UM) 7*2048kB (UME) 127*4096kB (M) = 628008kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0
hugepages_size=1048576kB
Node 0 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0
hugepages_size=1048576kB
Node 1 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
35151 total pagecache pages
0 pages in swap cache
Swap cache stats: add 0, delete 0, find 0/0
Free swap  = 0kB
Total swap = 0kB
1048445 pages RAM
0 pages HighMem/MovableOnly
236668 pages reserved
0 pages cma reserved
==================================================================
BUG: KASAN: use-after-free in rxe_queue_cleanup+0xf4/0x100
drivers/infiniband/sw/rxe/rxe_queue.c:193
Read of size 8 at addr ffff888016d4e410 by task syz-executor/26230

CPU: 3 PID: 26230 Comm: syz-executor Not tainted 5.15.0+ #6
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description.constprop.0.cold+0x93/0x337 mm/kasan/report.c:256
 __kasan_report mm/kasan/report.c:442 [inline]
 kasan_report.cold+0x83/0xdf mm/kasan/report.c:459
 rxe_queue_cleanup+0xf4/0x100 drivers/infiniband/sw/rxe/rxe_queue.c:193
 rxe_qp_do_cleanup+0x5c/0x720 drivers/infiniband/sw/rxe/rxe_qp.c:804
 execute_in_process_context+0x37/0x150 kernel/workqueue.c:3359
 rxe_elem_release+0x9f/0x180 drivers/infiniband/sw/rxe/rxe_pool.c:407
 kref_put include/linux/kref.h:65 [inline]
 rxe_create_qp+0x32c/0x3b0 drivers/infiniband/sw/rxe/rxe_verbs.c:450
 create_qp+0x50c/0x880 drivers/infiniband/core/verbs.c:1238
 ib_create_qp_kernel+0x9d/0x310 drivers/infiniband/core/verbs.c:1349
 ib_create_qp include/rdma/ib_verbs.h:3722 [inline]
 create_mad_qp+0x171/0x2c0 drivers/infiniband/core/mad.c:2910
 ib_mad_port_open drivers/infiniband/core/mad.c:2991 [inline]
 ib_mad_init_device+0xa16/0xfa0 drivers/infiniband/core/mad.c:3082
 add_client_context+0x3fb/0x5e0 drivers/infiniband/core/device.c:720
 enable_device_and_get+0x1cd/0x3b0 drivers/infiniband/core/device.c:1331
 ib_register_device drivers/infiniband/core/device.c:1419 [inline]
 ib_register_device+0x823/0xb10 drivers/infiniband/core/device.c:1365
 rxe_register_device+0x2fe/0x3b0 drivers/infiniband/sw/rxe/rxe_verbs.c:1146
 rxe_add+0x12b6/0x16f0 drivers/infiniband/sw/rxe/rxe.c:248
 rxe_net_add+0x8c/0xe0 drivers/infiniband/sw/rxe/rxe_net.c:543
 rxe_newlink drivers/infiniband/sw/rxe/rxe.c:270 [inline]
 rxe_newlink+0xb7/0xe0 drivers/infiniband/sw/rxe/rxe.c:251
 nldev_newlink+0x292/0x440 drivers/infiniband/core/nldev.c:1717
 rdma_nl_rcv_msg drivers/infiniband/core/netlink.c:195 [inline]
 rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
 rdma_nl_rcv+0x3a8/0xa60 drivers/infiniband/core/netlink.c:259
 netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
 netlink_unicast+0x533/0x740 net/netlink/af_netlink.c:1345
 netlink_sendmsg+0x86d/0xda0 net/netlink/af_netlink.c:1916
 sock_sendmsg_nosec net/socket.c:704 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:724
 ____sys_sendmsg+0x6e8/0x810 net/socket.c:2409
 ___sys_sendmsg+0x100/0x170 net/socket.c:2463
 __sys_sendmsg+0xe5/0x1b0 net/socket.c:2492
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f0bc939bc4d
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0bc6903c58 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f0bc94c20a0 RCX: 00007f0bc939bc4d
RDX: 000000000004c084 RSI: 0000000020001240 RDI: 0000000000000006
RBP: 00007f0bc9414d80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f0bc94c20a0
R13: 00007ffc009b097f R14: 00007ffc009b0b20 R15: 00007f0bc6903dc0
 </TASK>

Allocated by task 26230:
 kasan_save_stack+0x1e/0x50 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:46 [inline]
 set_alloc_info mm/kasan/common.c:434 [inline]
 ____kasan_kmalloc mm/kasan/common.c:513 [inline]
 ____kasan_kmalloc mm/kasan/common.c:472 [inline]
 __kasan_kmalloc+0xa9/0xd0 mm/kasan/common.c:522
 kasan_kmalloc include/linux/kasan.h:269 [inline]
 kmem_cache_alloc_trace+0x198/0x390 mm/slub.c:3261
 kmalloc include/linux/slab.h:590 [inline]
 kzalloc include/linux/slab.h:724 [inline]
 rxe_queue_init+0x98/0x500 drivers/infiniband/sw/rxe/rxe_queue.c:66
 rxe_qp_init_req drivers/infiniband/sw/rxe/rxe_qp.c:233 [inline]
 rxe_qp_from_init+0x91c/0x1bc0 drivers/infiniband/sw/rxe/rxe_qp.c:347
 rxe_create_qp+0x231/0x3b0 drivers/infiniband/sw/rxe/rxe_verbs.c:442
 create_qp+0x50c/0x880 drivers/infiniband/core/verbs.c:1238
 ib_create_qp_kernel+0x9d/0x310 drivers/infiniband/core/verbs.c:1349
 ib_create_qp include/rdma/ib_verbs.h:3722 [inline]
 create_mad_qp+0x171/0x2c0 drivers/infiniband/core/mad.c:2910
 ib_mad_port_open drivers/infiniband/core/mad.c:2991 [inline]
 ib_mad_init_device+0xa16/0xfa0 drivers/infiniband/core/mad.c:3082
 add_client_context+0x3fb/0x5e0 drivers/infiniband/core/device.c:720
 enable_device_and_get+0x1cd/0x3b0 drivers/infiniband/core/device.c:1331
 ib_register_device drivers/infiniband/core/device.c:1419 [inline]
 ib_register_device+0x823/0xb10 drivers/infiniband/core/device.c:1365
 rxe_register_device+0x2fe/0x3b0 drivers/infiniband/sw/rxe/rxe_verbs.c:1146
 rxe_add+0x12b6/0x16f0 drivers/infiniband/sw/rxe/rxe.c:248
 rxe_net_add+0x8c/0xe0 drivers/infiniband/sw/rxe/rxe_net.c:543
 rxe_newlink drivers/infiniband/sw/rxe/rxe.c:270 [inline]
 rxe_newlink+0xb7/0xe0 drivers/infiniband/sw/rxe/rxe.c:251
 nldev_newlink+0x292/0x440 drivers/infiniband/core/nldev.c:1717
 rdma_nl_rcv_msg drivers/infiniband/core/netlink.c:195 [inline]
 rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
 rdma_nl_rcv+0x3a8/0xa60 drivers/infiniband/core/netlink.c:259
 netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
 netlink_unicast+0x533/0x740 net/netlink/af_netlink.c:1345
 netlink_sendmsg+0x86d/0xda0 net/netlink/af_netlink.c:1916
 sock_sendmsg_nosec net/socket.c:704 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:724
 ____sys_sendmsg+0x6e8/0x810 net/socket.c:2409
 ___sys_sendmsg+0x100/0x170 net/socket.c:2463
 __sys_sendmsg+0xe5/0x1b0 net/socket.c:2492
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Freed by task 26230:
 kasan_save_stack+0x1e/0x50 mm/kasan/common.c:38
 kasan_set_track+0x21/0x30 mm/kasan/common.c:46
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:370
 ____kasan_slab_free mm/kasan/common.c:366 [inline]
 ____kasan_slab_free mm/kasan/common.c:328 [inline]
 __kasan_slab_free+0x100/0x140 mm/kasan/common.c:374
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:1723 [inline]
 slab_free_freelist_hook mm/slub.c:1749 [inline]
 slab_free mm/slub.c:3513 [inline]
 kfree+0x107/0x4c0 mm/slub.c:4561
 rxe_qp_from_init+0x11c5/0x1bc0 drivers/infiniband/sw/rxe/rxe_qp.c:361
 rxe_create_qp+0x231/0x3b0 drivers/infiniband/sw/rxe/rxe_verbs.c:442
 create_qp+0x50c/0x880 drivers/infiniband/core/verbs.c:1238
 ib_create_qp_kernel+0x9d/0x310 drivers/infiniband/core/verbs.c:1349
 ib_create_qp include/rdma/ib_verbs.h:3722 [inline]
 create_mad_qp+0x171/0x2c0 drivers/infiniband/core/mad.c:2910
 ib_mad_port_open drivers/infiniband/core/mad.c:2991 [inline]
 ib_mad_init_device+0xa16/0xfa0 drivers/infiniband/core/mad.c:3082
 add_client_context+0x3fb/0x5e0 drivers/infiniband/core/device.c:720
 enable_device_and_get+0x1cd/0x3b0 drivers/infiniband/core/device.c:1331
 ib_register_device drivers/infiniband/core/device.c:1419 [inline]
 ib_register_device+0x823/0xb10 drivers/infiniband/core/device.c:1365
 rxe_register_device+0x2fe/0x3b0 drivers/infiniband/sw/rxe/rxe_verbs.c:1146
 rxe_add+0x12b6/0x16f0 drivers/infiniband/sw/rxe/rxe.c:248
 rxe_net_add+0x8c/0xe0 drivers/infiniband/sw/rxe/rxe_net.c:543
 rxe_newlink drivers/infiniband/sw/rxe/rxe.c:270 [inline]
 rxe_newlink+0xb7/0xe0 drivers/infiniband/sw/rxe/rxe.c:251
 nldev_newlink+0x292/0x440 drivers/infiniband/core/nldev.c:1717
 rdma_nl_rcv_msg drivers/infiniband/core/netlink.c:195 [inline]
 rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
 rdma_nl_rcv+0x3a8/0xa60 drivers/infiniband/core/netlink.c:259
 netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
 netlink_unicast+0x533/0x740 net/netlink/af_netlink.c:1345
 netlink_sendmsg+0x86d/0xda0 net/netlink/af_netlink.c:1916
 sock_sendmsg_nosec net/socket.c:704 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:724
 ____sys_sendmsg+0x6e8/0x810 net/socket.c:2409
 ___sys_sendmsg+0x100/0x170 net/socket.c:2463
 __sys_sendmsg+0xe5/0x1b0 net/socket.c:2492
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Last potentially related work creation:
 kasan_save_stack+0x1e/0x50 mm/kasan/common.c:38
 __kasan_record_aux_stack+0xf5/0x120 mm/kasan/generic.c:348
 kvfree_call_rcu+0x74/0xab0 kernel/rcu/tree.c:3550
 dropmon_net_event+0x229/0x480 net/core/drop_monitor.c:1578
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
 call_netdevice_notifiers_info net/core/dev.c:2002 [inline]
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:1987
 call_netdevice_notifiers_extack net/core/dev.c:2014 [inline]
 call_netdevice_notifiers net/core/dev.c:2028 [inline]
 unregister_netdevice_many+0x930/0x14e0 net/core/dev.c:11074
 default_device_exit_batch+0x302/0x3c0 net/core/dev.c:11604
 ops_exit_list.isra.0+0x103/0x150 net/core/net_namespace.c:171
 cleanup_net+0x511/0xa90 net/core/net_namespace.c:593
 process_one_work+0x9df/0x16d0 kernel/workqueue.c:2298
 worker_thread+0x90/0xed0 kernel/workqueue.c:2445
 kthread+0x405/0x4f0 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

The buggy address belongs to the object at ffff888016d4e400
 which belongs to the cache kmalloc-64 of size 64
The buggy address is located 16 bytes inside of
 64-byte region [ffff888016d4e400, ffff888016d4e440)
The buggy address belongs to the page:
page:ffffea00005b5380 refcount:1 mapcount:0 mapping:0000000000000000
index:0x0 pfn:0x16d4e
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 ffffea000061aa40 dead000000000002 ffff888010c42640
raw: 0000000000000000 0000000080200020 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask
0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 1, ts 22769224362,
free_ts 22695025907
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook mm/page_alloc.c:2412 [inline]
 prep_new_page+0x1a5/0x240 mm/page_alloc.c:2418
 get_page_from_freelist+0x1eed/0x3b50 mm/page_alloc.c:4149
 __alloc_pages+0x306/0x6e0 mm/page_alloc.c:5369
 alloc_page_interleave+0x1e/0x250 mm/mempolicy.c:2036
 alloc_pages+0x1e4/0x240 mm/mempolicy.c:2186
 alloc_slab_page mm/slub.c:1793 [inline]
 allocate_slab mm/slub.c:1930 [inline]
 new_slab+0x35e/0x4b0 mm/slub.c:1993
 ___slab_alloc+0xae6/0x1120 mm/slub.c:3022
 __slab_alloc.isra.0+0x4d/0xa0 mm/slub.c:3109
 slab_alloc_node mm/slub.c:3200 [inline]
 slab_alloc mm/slub.c:3242 [inline]
 kmem_cache_alloc_trace+0x334/0x390 mm/slub.c:3259
 kmalloc include/linux/slab.h:590 [inline]
 kzalloc include/linux/slab.h:724 [inline]
 rtnl_register_internal+0x4b0/0x5b0 net/core/rtnetlink.c:202
 ipv6_addr_label_rtnl_register+0x5f/0xa8 net/ipv6/addrlabel.c:642
 addrconf_init+0x337/0x3b5 net/ipv6/addrconf.c:7285
 inet6_init+0x368/0x72e net/ipv6/af_inet6.c:1149
 do_one_initcall+0x103/0x650 init/main.c:1295
 do_initcall_level init/main.c:1368 [inline]
 do_initcalls init/main.c:1384 [inline]
 do_basic_setup init/main.c:1403 [inline]
 kernel_init_freeable+0x6c3/0x74c init/main.c:1608
 kernel_init+0x1a/0x1d0 init/main.c:1497
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1338 [inline]
 free_pcp_prepare+0x473/0x9f0 mm/page_alloc.c:1389
 free_unref_page_prepare mm/page_alloc.c:3309 [inline]
 free_unref_page+0x19/0x5b0 mm/page_alloc.c:3388
 __unfreeze_partials+0x343/0x360 mm/slub.c:2527
 qlink_free mm/kasan/quarantine.c:146 [inline]
 qlist_free_all+0x5a/0xc0 mm/kasan/quarantine.c:165
 kasan_quarantine_reduce+0x13d/0x180 mm/kasan/quarantine.c:272
 __kasan_slab_alloc+0xa2/0xc0 mm/kasan/common.c:444
 kasan_slab_alloc include/linux/kasan.h:259 [inline]
 slab_post_alloc_hook+0x4d/0x4a0 mm/slab.h:519
 slab_alloc_node mm/slub.c:3234 [inline]
 slab_alloc mm/slub.c:3242 [inline]
 kmem_cache_alloc_trace+0x157/0x390 mm/slub.c:3259
 kmalloc include/linux/slab.h:590 [inline]
 kzalloc include/linux/slab.h:724 [inline]
 bus_add_driver+0xd4/0x630 drivers/base/bus.c:602
 driver_register+0x1c4/0x330 drivers/base/driver.c:171
 usb_register_driver+0x249/0x460 drivers/usb/core/driver.c:1061
 do_one_initcall+0x103/0x650 init/main.c:1295
 do_initcall_level init/main.c:1368 [inline]
 do_initcalls init/main.c:1384 [inline]
 do_basic_setup init/main.c:1403 [inline]
 kernel_init_freeable+0x6c3/0x74c init/main.c:1608
 kernel_init+0x1a/0x1d0 init/main.c:1497
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

Memory state around the buggy address:
 ffff888016d4e300: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
 ffff888016d4e380: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>ffff888016d4e400: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
                         ^
 ffff888016d4e480: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff888016d4e500: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
==================================================================
