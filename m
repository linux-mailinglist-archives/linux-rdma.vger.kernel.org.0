Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6504ADE8F
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Feb 2022 17:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383515AbiBHQqU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Feb 2022 11:46:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352380AbiBHQqU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Feb 2022 11:46:20 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FDAC061578
        for <linux-rdma@vger.kernel.org>; Tue,  8 Feb 2022 08:46:19 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id k12-20020a92c24c000000b002bc9876bf27so11705335ilo.21
        for <linux-rdma@vger.kernel.org>; Tue, 08 Feb 2022 08:46:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=04stNfTA8owtchC8dwIElu8+6DIjBdqEAIbIB7WQr1g=;
        b=3ab/Jrr5Z2WUm0zlhrRfchfx5gI9lYfwRqGcifaHTGZW4u+xJkGYcdnSn0eVWocWHb
         G6xR2MzahSRNb0tAOMYcpVDJJSCn3NNO1aEsi+WXZdOnmwPrY1vcH8VOlFyccy/v2e5e
         Q525iHLmpBEXwvz7weWrZNhhSu9e2IDh7cqrqWY3ISmNNtktjrxAywdPu939x9XNLDQF
         UGsjuZrj8f9LzriFnyhHqls7hJS/Qd1jusbm1LhfK3elitdxRJw6NPXsYQ4eVahVLnzU
         CZYlALZFxj0PRoyxVUoQpG48CRwvnf/sVyKvU5YBXhC9axXOFn6rbkAI+bi1lX8XKUmU
         IkWg==
X-Gm-Message-State: AOAM530jrF9M9HsDGNvhmtnHxQwNXrBwxlBHaB46Z5fhRX1gUUGsHyAN
        UWfRfZ/kqoasMmfhEFUes5PI8cDryMUQ3kAV72Jqcsufb2B0
X-Google-Smtp-Source: ABdhPJzoxPhAVs+NLpIAxk0klhk3tC4wwLDe8d+FGHLQF00JVyXcHz2lNoy1U1FAZBwoO/UX88EBn2NH13f/G24b2D3LjSFvwpd+
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a05:: with SMTP id s5mr2640669ild.231.1644338778980;
 Tue, 08 Feb 2022 08:46:18 -0800 (PST)
Date:   Tue, 08 Feb 2022 08:46:18 -0800
In-Reply-To: <000000000000c3eace05d24f0189@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cfc8ab05d78474c4@google.com>
Subject: Re: [syzbot] BUG: corrupted list in rdma_listen (2)
From:   syzbot <syzbot+c94a3675a626f6333d74@syzkaller.appspotmail.com>
To:     avihaih@nvidia.com, dledford@redhat.com, dvyukov@google.com,
        fgheet255t@gmail.com, haakon.bugge@oracle.com, jgg@ziepe.ca,
        leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    555f3d7be91a Merge tag '5.17-rc3-ksmbd-server-fixes' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16c4c44fb00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=266de9da75c71a45
dashboard link: https://syzkaller.appspot.com/bug?extid=c94a3675a626f6333d74
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=137e0c77b00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=140b1eaa700000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c94a3675a626f6333d74@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in __list_add_valid+0x93/0xa0 lib/list_debug.c:26
Read of size 8 at addr ffff88807d24c1e0 by task syz-executor341/3597

CPU: 1 PID: 3597 Comm: syz-executor341 Not tainted 5.17.0-rc3-syzkaller-00020-g555f3d7be91a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description.constprop.0.cold+0x8d/0x336 mm/kasan/report.c:255
 __kasan_report mm/kasan/report.c:442 [inline]
 kasan_report.cold+0x83/0xdf mm/kasan/report.c:459
 __list_add_valid+0x93/0xa0 lib/list_debug.c:26
 __list_add include/linux/list.h:69 [inline]
 list_add_tail include/linux/list.h:102 [inline]
 cma_listen_on_all drivers/infiniband/core/cma.c:2593 [inline]
 rdma_listen+0x86e/0xde0 drivers/infiniband/core/cma.c:3862
 ucma_listen+0x16a/0x210 drivers/infiniband/core/ucma.c:1105
 ucma_write+0x25c/0x350 drivers/infiniband/core/ucma.c:1744
 vfs_write+0x28e/0xae0 fs/read_write.c:588
 ksys_write+0x1ee/0x250 fs/read_write.c:643
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f0aca906fb9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffc9f11448 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f0aca906fb9
RDX: 0000000000000010 RSI: 0000000020000040 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007fffc9f115e8 R09: 00007fffc9f115e8
R10: 00007fffc9f115e8 R11: 0000000000000246 R12: 00007fffc9f1145c
R13: 431bde82d7b634db R14: 0000000000000000 R15: 0000000000000000
 </TASK>

Allocated by task 3596:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:45 [inline]
 set_alloc_info mm/kasan/common.c:436 [inline]
 ____kasan_kmalloc mm/kasan/common.c:515 [inline]
 ____kasan_kmalloc mm/kasan/common.c:474 [inline]
 __kasan_kmalloc+0xa9/0xd0 mm/kasan/common.c:524
 kmalloc include/linux/slab.h:581 [inline]
 kzalloc include/linux/slab.h:715 [inline]
 __rdma_create_id+0x5b/0x5c0 drivers/infiniband/core/cma.c:845
 rdma_create_user_id+0x79/0xd0 drivers/infiniband/core/cma.c:900
 ucma_create_id+0x162/0x360 drivers/infiniband/core/ucma.c:464
 ucma_write+0x25c/0x350 drivers/infiniband/core/ucma.c:1744
 vfs_write+0x28e/0xae0 fs/read_write.c:588
 ksys_write+0x1ee/0x250 fs/read_write.c:643
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Freed by task 3596:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track+0x21/0x30 mm/kasan/common.c:45
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:370
 ____kasan_slab_free mm/kasan/common.c:366 [inline]
 ____kasan_slab_free+0x130/0x160 mm/kasan/common.c:328
 kasan_slab_free include/linux/kasan.h:236 [inline]
 slab_free_hook mm/slub.c:1728 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1754
 slab_free mm/slub.c:3509 [inline]
 kfree+0xcb/0x280 mm/slub.c:4562
 ucma_close_id drivers/infiniband/core/ucma.c:187 [inline]
 ucma_destroy_private_ctx+0x9ca/0xd20 drivers/infiniband/core/ucma.c:579
 ucma_close+0x10a/0x180 drivers/infiniband/core/ucma.c:1809
 __fput+0x286/0x9f0 fs/file_table.c:311
 task_work_run+0xdd/0x1a0 kernel/task_work.c:164
 exit_task_work include/linux/task_work.h:32 [inline]
 do_exit+0xb29/0x2a30 kernel/exit.c:806
 do_group_exit+0xd2/0x2f0 kernel/exit.c:935
 __do_sys_exit_group kernel/exit.c:946 [inline]
 __se_sys_exit_group kernel/exit.c:944 [inline]
 __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:944
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Last potentially related work creation:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 __kasan_record_aux_stack+0xbe/0xd0 mm/kasan/generic.c:348
 __call_rcu kernel/rcu/tree.c:3026 [inline]
 call_rcu+0xb1/0x740 kernel/rcu/tree.c:3106
 netlink_release+0xf08/0x1db0 net/netlink/af_netlink.c:813
 __sock_release+0xcd/0x280 net/socket.c:650
 sock_close+0x18/0x20 net/socket.c:1318
 __fput+0x286/0x9f0 fs/file_table.c:311
 task_work_run+0xdd/0x1a0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:188 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:175 [inline]
 exit_to_user_mode_prepare+0x27e/0x290 kernel/entry/common.c:207
 __syscall_exit_to_user_mode_work kernel/entry/common.c:289 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:300
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x44/0xae

The buggy address belongs to the object at ffff88807d24c000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 480 bytes inside of
 2048-byte region [ffff88807d24c000, ffff88807d24c800)
The buggy address belongs to the page:
page:ffffea0001f49200 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7d248
head:ffffea0001f49200 order:3 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 ffffea00052c7e00 dead000000000002 ffff888010c42000
raw: 0000000000000000 0000000080080008 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 2947, ts 17013492589, free_ts 15683127625
 prep_new_page mm/page_alloc.c:2434 [inline]
 get_page_from_freelist+0xa72/0x2f50 mm/page_alloc.c:4165
 __alloc_pages+0x1b2/0x500 mm/page_alloc.c:5389
 alloc_pages+0x1aa/0x310 mm/mempolicy.c:2271
 alloc_slab_page mm/slub.c:1799 [inline]
 allocate_slab mm/slub.c:1944 [inline]
 new_slab+0x28a/0x3b0 mm/slub.c:2004
 ___slab_alloc+0x87c/0xe90 mm/slub.c:3018
 __slab_alloc.constprop.0+0x4d/0xa0 mm/slub.c:3105
 slab_alloc_node mm/slub.c:3196 [inline]
 slab_alloc mm/slub.c:3238 [inline]
 __kmalloc+0x2fb/0x340 mm/slub.c:4420
 kmalloc include/linux/slab.h:586 [inline]
 sk_prot_alloc+0x110/0x290 net/core/sock.c:1923
 sk_alloc+0x32/0xa80 net/core/sock.c:1976
 __netlink_create+0x63/0x2f0 net/netlink/af_netlink.c:645
 netlink_create+0x3ad/0x5e0 net/netlink/af_netlink.c:708
 __sock_create+0x353/0x790 net/socket.c:1468
 sock_create net/socket.c:1519 [inline]
 __sys_socket+0xef/0x200 net/socket.c:1561
 __do_sys_socket net/socket.c:1570 [inline]
 __se_sys_socket net/socket.c:1568 [inline]
 __x64_sys_socket+0x6f/0xb0 net/socket.c:1568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1352 [inline]
 free_pcp_prepare+0x374/0x870 mm/page_alloc.c:1404
 free_unref_page_prepare mm/page_alloc.c:3325 [inline]
 free_unref_page+0x19/0x690 mm/page_alloc.c:3404
 free_contig_range+0xa8/0xf0 mm/page_alloc.c:9335
 destroy_args+0xa8/0x646 mm/debug_vm_pgtable.c:1018
 debug_vm_pgtable+0x298e/0x2a20 mm/debug_vm_pgtable.c:1332
 do_one_initcall+0x103/0x650 init/main.c:1300
 do_initcall_level init/main.c:1373 [inline]
 do_initcalls init/main.c:1389 [inline]
 do_basic_setup init/main.c:1408 [inline]
 kernel_init_freeable+0x6b1/0x73a init/main.c:1613
 kernel_init+0x1a/0x1d0 init/main.c:1502
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

Memory state around the buggy address:
 ffff88807d24c080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807d24c100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88807d24c180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                       ^
 ffff88807d24c200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807d24c280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

