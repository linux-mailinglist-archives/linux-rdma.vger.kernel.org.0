Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5CFD70012A
	for <lists+linux-rdma@lfdr.de>; Fri, 12 May 2023 09:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240192AbjELHN3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 May 2023 03:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240019AbjELHND (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 12 May 2023 03:13:03 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488D2100CD
        for <linux-rdma@vger.kernel.org>; Fri, 12 May 2023 00:10:52 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-76c6c1b16d2so443977539f.1
        for <linux-rdma@vger.kernel.org>; Fri, 12 May 2023 00:10:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683875451; x=1686467451;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SMsFgq+oEOcmhbsxZ5bE3e0fF8uEzh1t5dBmZu5VzjQ=;
        b=IrHtC3bjtANiS6kvgsHnWZwII8CyE3JvZLxNVGhehowv+Z5Ld86Gm2KVUpWM9dBoTL
         vuyqU+j27OqISNSU6BYO1M7ce8rsIEg50y61iFRaWzmd4f3OiF4RehkOCgPZjyDEIZpG
         CYU2gNrB0wMXLsRBvoFO1yyM5XRFGCuSIttYlzFMIa91YF9Mik4qWQZbUNzV+yIzcJeu
         V/uJt4jaOhZvR4YtaZUMXbZnk6TrnHfRMkeFtXpTS1s6hRSM9SjJfSEL21hCm/fvW+Fp
         XBIxPIGw/iZNLnlmbkfMx3QcJAGdouO9raPqDuoqXfql2u3J7Mj7mcuXpsjUzNxEHBFY
         o0jQ==
X-Gm-Message-State: AC+VfDxguvP2QINsJJKtEFdum2WZOsmQ3RLHfqnEppDOkEMl7aaaHy5Y
        +6tz+x2VC8EXsDmL3zAFL59NmKPrY/ynb08CtjKcoNrGkQ30
X-Google-Smtp-Source: ACHHUZ64xI94OQzUOuIF7AQAPwyfjA70Je4SmZIGVHplLxqTlYZst31252zspR5SqeRkvKP8p27IRhb6zA7bHRcu06V7W9/Q1Usd
MIME-Version: 1.0
X-Received: by 2002:a02:220c:0:b0:416:7c00:b0f1 with SMTP id
 o12-20020a02220c000000b004167c00b0f1mr6234871jao.6.1683875451343; Fri, 12 May
 2023 00:10:51 -0700 (PDT)
Date:   Fri, 12 May 2023 00:10:51 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001f992805fb79ce97@google.com>
Subject: [syzbot] [rdma?] KASAN: slab-use-after-free Read in siw_query_port
From:   syzbot <syzbot+79f283f1f4ccc6e8b624@syzkaller.appspotmail.com>
To:     bmt@zurich.ibm.com, jgg@ziepe.ca, leon@kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    16a8829130ca nfs: fix another case of NULL/IS_ERR confusio..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=162c0566280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8bc832f563d8bf38
dashboard link: https://syzkaller.appspot.com/bug?extid=79f283f1f4ccc6e8b624
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f8c18a31ba47/disk-16a88291.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/03a18f29b7e7/vmlinux-16a88291.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1db2407ade1e/bzImage-16a88291.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+79f283f1f4ccc6e8b624@syzkaller.appspotmail.com

xfrm0 speed is unknown, defaulting to 1000
==================================================================
BUG: KASAN: slab-use-after-free in siw_query_port+0x37b/0x3e0 drivers/infiniband/sw/siw/siw_verbs.c:177
Read of size 4 at addr ffff888034efa0e8 by task kworker/1:4/24211

CPU: 1 PID: 24211 Comm: kworker/1:4 Not tainted 6.4.0-rc1-syzkaller-00012-g16a8829130ca #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
Workqueue: infiniband ib_cache_event_task
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 print_address_description.constprop.0+0x2c/0x3c0 mm/kasan/report.c:351
 print_report mm/kasan/report.c:462 [inline]
 kasan_report+0x11c/0x130 mm/kasan/report.c:572
 siw_query_port+0x37b/0x3e0 drivers/infiniband/sw/siw/siw_verbs.c:177
 iw_query_port drivers/infiniband/core/device.c:2049 [inline]
 ib_query_port drivers/infiniband/core/device.c:2090 [inline]
 ib_query_port+0x3c4/0x8f0 drivers/infiniband/core/device.c:2082
 ib_cache_update.part.0+0xcf/0x920 drivers/infiniband/core/cache.c:1487
 ib_cache_update drivers/infiniband/core/cache.c:1561 [inline]
 ib_cache_event_task+0x1b1/0x270 drivers/infiniband/core/cache.c:1561
 process_one_work+0x99a/0x15e0 kernel/workqueue.c:2405
 worker_thread+0x67d/0x10c0 kernel/workqueue.c:2552
 kthread+0x344/0x440 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>

Allocated by task 14304:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 ____kasan_kmalloc mm/kasan/common.c:333 [inline]
 __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:383
 kasan_kmalloc include/linux/kasan.h:196 [inline]
 __do_kmalloc_node mm/slab_common.c:966 [inline]
 __kmalloc_node+0x61/0x1a0 mm/slab_common.c:973
 kmalloc_node include/linux/slab.h:579 [inline]
 kvmalloc_node+0xa2/0x1a0 mm/util.c:604
 kvmalloc include/linux/slab.h:697 [inline]
 kvzalloc include/linux/slab.h:705 [inline]
 alloc_netdev_mqs+0x9c/0x1250 net/core/dev.c:10626
 rtnl_create_link+0xbeb/0xee0 net/core/rtnetlink.c:3315
 rtnl_newlink_create net/core/rtnetlink.c:3433 [inline]
 __rtnl_newlink+0xfd4/0x1840 net/core/rtnetlink.c:3660
 rtnl_newlink+0x68/0xa0 net/core/rtnetlink.c:3673
 rtnetlink_rcv_msg+0x43d/0xd50 net/core/rtnetlink.c:6395
 netlink_rcv_skb+0x165/0x440 net/netlink/af_netlink.c:2546
 netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
 netlink_unicast+0x547/0x7f0 net/netlink/af_netlink.c:1365
 netlink_sendmsg+0x925/0xe30 net/netlink/af_netlink.c:1913
 sock_sendmsg_nosec net/socket.c:724 [inline]
 sock_sendmsg+0xde/0x190 net/socket.c:747
 __sys_sendto+0x23a/0x340 net/socket.c:2144
 __do_sys_sendto net/socket.c:2156 [inline]
 __se_sys_sendto net/socket.c:2152 [inline]
 __x64_sys_sendto+0xe1/0x1b0 net/socket.c:2152
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 5268:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2e/0x40 mm/kasan/generic.c:521
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x160/0x1c0 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:162 [inline]
 slab_free_hook mm/slub.c:1781 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1807
 slab_free mm/slub.c:3786 [inline]
 __kmem_cache_free+0xaf/0x2d0 mm/slub.c:3799
 kvfree+0x46/0x50 mm/util.c:650
 device_release+0xa3/0x240 drivers/base/core.c:2484
 kobject_cleanup lib/kobject.c:683 [inline]
 kobject_release lib/kobject.c:714 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1c2/0x4d0 lib/kobject.c:731
 netdev_run_todo+0x762/0x1100 net/core/dev.c:10400
 xfrmi_exit_batch_net+0x2c7/0x3e0 net/xfrm/xfrm_interface_core.c:984
 ops_exit_list+0x125/0x170 net/core/net_namespace.c:175
 cleanup_net+0x4ee/0xb10 net/core/net_namespace.c:614
 process_one_work+0x99a/0x15e0 kernel/workqueue.c:2405
 worker_thread+0x67d/0x10c0 kernel/workqueue.c:2552
 kthread+0x344/0x440 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

The buggy address belongs to the object at ffff888034efa000
 which belongs to the cache kmalloc-cg-4k of size 4096
The buggy address is located 232 bytes inside of
 freed 4096-byte region [ffff888034efa000, ffff888034efb000)

The buggy address belongs to the physical page:
page:ffffea0000d3be00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x34ef8
head:ffffea0000d3be00 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff88807d3a3741
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000010200 ffff88801244f500 ffffea00005adc00 dead000000000002
raw: 0000000000000000 0000000000040004 00000001ffffffff ffff88807d3a3741
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 4668, tgid 4668 (dhcpcd), ts 914718336210, free_ts 914216762552
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2db/0x350 mm/page_alloc.c:1731
 prep_new_page mm/page_alloc.c:1738 [inline]
 get_page_from_freelist+0xf41/0x2c00 mm/page_alloc.c:3502
 __alloc_pages+0x1cb/0x4a0 mm/page_alloc.c:4768
 alloc_pages+0x1aa/0x270 mm/mempolicy.c:2279
 alloc_slab_page mm/slub.c:1851 [inline]
 allocate_slab+0x25f/0x390 mm/slub.c:1998
 new_slab mm/slub.c:2051 [inline]
 ___slab_alloc+0xa91/0x1400 mm/slub.c:3192
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3291
 __slab_alloc_node mm/slub.c:3344 [inline]
 slab_alloc_node mm/slub.c:3441 [inline]
 __kmem_cache_alloc_node+0x136/0x320 mm/slub.c:3490
 __do_kmalloc_node mm/slab_common.c:965 [inline]
 __kmalloc_node+0x51/0x1a0 mm/slab_common.c:973
 kmalloc_node include/linux/slab.h:579 [inline]
 kvmalloc_node+0xa2/0x1a0 mm/util.c:604
 kvmalloc include/linux/slab.h:697 [inline]
 seq_buf_alloc fs/seq_file.c:38 [inline]
 seq_read_iter+0x7fb/0x12d0 fs/seq_file.c:210
 kernfs_fop_read_iter+0x4ce/0x690 fs/kernfs/file.c:279
 call_read_iter include/linux/fs.h:1862 [inline]
 new_sync_read fs/read_write.c:389 [inline]
 vfs_read+0x4b1/0x8a0 fs/read_write.c:470
 ksys_read+0x12b/0x250 fs/read_write.c:613
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1302 [inline]
 free_unref_page_prepare+0x62e/0xcb0 mm/page_alloc.c:2564
 free_unref_page+0x33/0x370 mm/page_alloc.c:2659
 __unfreeze_partials+0x17c/0x1a0 mm/slub.c:2636
 qlink_free mm/kasan/quarantine.c:166 [inline]
 qlist_free_all+0x6a/0x170 mm/kasan/quarantine.c:185
 kasan_quarantine_reduce+0x195/0x220 mm/kasan/quarantine.c:292
 __kasan_slab_alloc+0x63/0x90 mm/kasan/common.c:305
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook mm/slab.h:711 [inline]
 slab_alloc_node mm/slub.c:3451 [inline]
 slab_alloc mm/slub.c:3459 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3466 [inline]
 kmem_cache_alloc+0x17c/0x3b0 mm/slub.c:3475
 getname_flags.part.0+0x50/0x4f0 fs/namei.c:140
 getname_flags+0x9e/0xe0 include/linux/audit.h:321
 vfs_fstatat+0x77/0xb0 fs/stat.c:275
 __do_sys_newfstatat+0x8a/0x110 fs/stat.c:446
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff888034ef9f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888034efa000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888034efa080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                          ^
 ffff888034efa100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888034efa180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
