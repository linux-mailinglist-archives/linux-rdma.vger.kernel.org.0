Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D940B48354B
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jan 2022 18:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234901AbiACRFR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Jan 2022 12:05:17 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:57321 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiACRFR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Jan 2022 12:05:17 -0500
Received: by mail-il1-f199.google.com with SMTP id a15-20020a92d58f000000b002b452d7b5ffso18224880iln.23
        for <linux-rdma@vger.kernel.org>; Mon, 03 Jan 2022 09:05:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=eJrYaL9iIwlbn3qobiIKMv3xRvD6U04Zha2MtMJpQQs=;
        b=R8NEQX9WaWP/okP4qF+k9Pl/QuzqXrUmORNAyA6KCjK6T1SYuGbJtcVKFJEd394Hkt
         cZlG1obiUeQOGMft0rAXfKozONaMW3UscTeMb3xmzl6wiBHQkZqhH/MQADE22vZn4IYb
         1Q8l2UW6TAnR1S7iXY0wP4Ugzq2yHDc59HhZ7HSqaxazsi07Lmrff9pLZOZetIga1Gyg
         4Gsf88hkX6xeRINyD41hy2PhpJvjUqU3i5P7PSPBY/dLbMtfKg2+ABXaTxh439PXNyJ2
         ZM1kl9HeOm2qsLr2KEfAHmEobINzoSUOQKXyYdHzw0HWjmXLveuSr1EyNLmUo4c1TbgT
         RLgg==
X-Gm-Message-State: AOAM533Pr8qHwRBQHh7JAEx426mMP5ykqS9PwCMTaNCWw/OB8vQ+WFIP
        JbCNsPdvsAjZJFsDr4vIweEWMgbu7WYzfuW6PsopF+Mg5lKC
X-Google-Smtp-Source: ABdhPJyelS0DWyX1KerC86rA1GrFjbqx/nvUgZsKEOvOtKCOcRctIG/44eow+a4aIJ0NczUXGsddrbxBROLY4w6Ja34y8k3HO9UJ
MIME-Version: 1.0
X-Received: by 2002:a02:c882:: with SMTP id m2mr18896737jao.30.1641229516718;
 Mon, 03 Jan 2022 09:05:16 -0800 (PST)
Date:   Mon, 03 Jan 2022 09:05:16 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000056c61c05d4b086d4@google.com>
Subject: [syzbot] KASAN: use-after-free Read in ucma_destroy_private_ctx
From:   syzbot <syzbot+e3f96c43d19782dd14a7@syzkaller.appspotmail.com>
To:     jgg@ziepe.ca, leon@kernel.org, liangwenpeng@huawei.com,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        liweihang@huawei.com, syzkaller-bugs@googlegroups.com,
        tanxiaofei@huawei.com, yuehaibing@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    a8ad9a2434dc Merge tag 'efi-urgent-for-v5.16-2' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10cf5253b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1a86c22260afac2f
dashboard link: https://syzkaller.appspot.com/bug?extid=e3f96c43d19782dd14a7
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e3f96c43d19782dd14a7@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in ucma_cleanup_multicast drivers/infiniband/core/ucma.c:491 [inline]
BUG: KASAN: use-after-free in ucma_destroy_private_ctx+0x914/0xb70 drivers/infiniband/core/ucma.c:579
Read of size 8 at addr ffff88801bb74b00 by task syz-executor.1/25529

CPU: 0 PID: 25529 Comm: syz-executor.1 Not tainted 5.16.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description.constprop.0.cold+0x8d/0x320 mm/kasan/report.c:247
 __kasan_report mm/kasan/report.c:433 [inline]
 kasan_report.cold+0x83/0xdf mm/kasan/report.c:450
 ucma_cleanup_multicast drivers/infiniband/core/ucma.c:491 [inline]
 ucma_destroy_private_ctx+0x914/0xb70 drivers/infiniband/core/ucma.c:579
 ucma_destroy_id+0x1e6/0x280 drivers/infiniband/core/ucma.c:614
 ucma_write+0x25c/0x350 drivers/infiniband/core/ucma.c:1732
 vfs_write+0x28e/0xae0 fs/read_write.c:588
 ksys_write+0x1ee/0x250 fs/read_write.c:643
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f2fcd207e99
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2fcbb7d168 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f2fcd31af60 RCX: 00007f2fcd207e99
RDX: 0000000000000018 RSI: 00000000200000c0 RDI: 0000000000000004
RBP: 00007f2fcd261ff1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff66a135bf R14: 00007f2fcbb7d300 R15: 0000000000022000
 </TASK>

Allocated by task 25524:
 kasan_save_stack+0x1e/0x50 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:46 [inline]
 set_alloc_info mm/kasan/common.c:434 [inline]
 ____kasan_kmalloc mm/kasan/common.c:513 [inline]
 ____kasan_kmalloc mm/kasan/common.c:472 [inline]
 __kasan_kmalloc+0xa9/0xd0 mm/kasan/common.c:522
 kmalloc include/linux/slab.h:590 [inline]
 kzalloc include/linux/slab.h:724 [inline]
 ucma_process_join+0x22a/0x6f0 drivers/infiniband/core/ucma.c:1461
 ucma_join_multicast+0xd5/0x140 drivers/infiniband/core/ucma.c:1546
 ucma_write+0x25c/0x350 drivers/infiniband/core/ucma.c:1732
 vfs_write+0x28e/0xae0 fs/read_write.c:588
 ksys_write+0x1ee/0x250 fs/read_write.c:643
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Freed by task 25521:
 kasan_save_stack+0x1e/0x50 mm/kasan/common.c:38
 kasan_set_track+0x21/0x30 mm/kasan/common.c:46
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:370
 ____kasan_slab_free mm/kasan/common.c:366 [inline]
 ____kasan_slab_free mm/kasan/common.c:328 [inline]
 __kasan_slab_free+0xff/0x130 mm/kasan/common.c:374
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:1723 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1749
 slab_free mm/slub.c:3513 [inline]
 kfree+0xf6/0x560 mm/slub.c:4561
 ucma_cleanup_multicast drivers/infiniband/core/ucma.c:498 [inline]
 ucma_destroy_private_ctx+0x7a3/0xb70 drivers/infiniband/core/ucma.c:579
 ucma_close+0x10a/0x180 drivers/infiniband/core/ucma.c:1797
 __fput+0x286/0x9f0 fs/file_table.c:280
 task_work_run+0xdd/0x1a0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:175 [inline]
 exit_to_user_mode_prepare+0x27e/0x290 kernel/entry/common.c:207
 __syscall_exit_to_user_mode_work kernel/entry/common.c:289 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:300
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Last potentially related work creation:
 kasan_save_stack+0x1e/0x50 mm/kasan/common.c:38
 __kasan_record_aux_stack+0xf5/0x120 mm/kasan/generic.c:348
 insert_work+0x48/0x370 kernel/workqueue.c:1354
 __queue_work+0x5ca/0xee0 kernel/workqueue.c:1520
 queue_work_on+0xee/0x110 kernel/workqueue.c:1547
 cma_resolve_loopback drivers/infiniband/core/cma.c:3330 [inline]
 rdma_resolve_addr drivers/infiniband/core/cma.c:3433 [inline]
 rdma_resolve_addr+0x86d/0x2300 drivers/infiniband/core/cma.c:3421
 ucma_resolve_ip+0x14e/0x200 drivers/infiniband/core/ucma.c:692
 ucma_write+0x25c/0x350 drivers/infiniband/core/ucma.c:1732
 vfs_write+0x28e/0xae0 fs/read_write.c:588
 ksys_write+0x1ee/0x250 fs/read_write.c:643
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Second to last potentially related work creation:
 kasan_save_stack+0x1e/0x50 mm/kasan/common.c:38
 __kasan_record_aux_stack+0xf5/0x120 mm/kasan/generic.c:348
 insert_work+0x48/0x370 kernel/workqueue.c:1354
 __queue_work+0x5ca/0xee0 kernel/workqueue.c:1520
 queue_work_on+0xee/0x110 kernel/workqueue.c:1547
 cma_resolve_loopback drivers/infiniband/core/cma.c:3330 [inline]
 rdma_resolve_addr drivers/infiniband/core/cma.c:3433 [inline]
 rdma_resolve_addr+0x86d/0x2300 drivers/infiniband/core/cma.c:3421
 ucma_resolve_ip+0x14e/0x200 drivers/infiniband/core/ucma.c:692
 ucma_write+0x25c/0x350 drivers/infiniband/core/ucma.c:1732
 vfs_write+0x28e/0xae0 fs/read_write.c:588
 ksys_write+0x1ee/0x250 fs/read_write.c:643
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

The buggy address belongs to the object at ffff88801bb74b00
 which belongs to the cache kmalloc-192 of size 192
The buggy address is located 0 bytes inside of
 192-byte region [ffff88801bb74b00, ffff88801bb74bc0)
The buggy address belongs to the page:
page:ffffea00006edd00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1bb74
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 dead000000000100 dead000000000122 ffff888010c41a00
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12c00(GFP_NOIO|__GFP_NOWARN|__GFP_NORETRY), pid 50, ts 7738663409, free_ts 7737390927
 prep_new_page mm/page_alloc.c:2418 [inline]
 get_page_from_freelist+0xa72/0x2f50 mm/page_alloc.c:4149
 __alloc_pages+0x1b2/0x500 mm/page_alloc.c:5369
 __alloc_pages_node include/linux/gfp.h:570 [inline]
 alloc_slab_page mm/slub.c:1795 [inline]
 allocate_slab mm/slub.c:1930 [inline]
 new_slab+0xab/0x4a0 mm/slub.c:1993
 ___slab_alloc+0x918/0xfe0 mm/slub.c:3022
 __slab_alloc.constprop.0+0x4d/0xa0 mm/slub.c:3109
 slab_alloc_node mm/slub.c:3200 [inline]
 __kmalloc_node+0x2cb/0x390 mm/slub.c:4467
 kmalloc_array_node include/linux/slab.h:686 [inline]
 kcalloc_node include/linux/slab.h:691 [inline]
 sbitmap_init_node+0x1c3/0x6f0 lib/sbitmap.c:114
 blk_mq_alloc_hctx block/blk-mq.c:3214 [inline]
 blk_mq_alloc_and_init_hctx block/blk-mq.c:3620 [inline]
 blk_mq_realloc_hw_ctxs+0xc20/0x1530 block/blk-mq.c:3672
 blk_mq_init_allocated_queue+0x324/0x12c0 block/blk-mq.c:3731
 blk_mq_init_queue_data block/blk-mq.c:3568 [inline]
 blk_mq_init_queue+0x75/0xd0 block/blk-mq.c:3578
 scsi_alloc_sdev+0x814/0xd60 drivers/scsi/scsi_scan.c:288
 scsi_probe_and_add_lun+0x200b/0x3590 drivers/scsi/scsi_scan.c:1122
 __scsi_scan_target+0x21f/0xdb0 drivers/scsi/scsi_scan.c:1604
 scsi_scan_channel drivers/scsi/scsi_scan.c:1692 [inline]
 scsi_scan_channel+0x148/0x1e0 drivers/scsi/scsi_scan.c:1668
 scsi_scan_host_selected+0x2df/0x3b0 drivers/scsi/scsi_scan.c:1721
 do_scsi_scan_host+0x1e8/0x260 drivers/scsi/scsi_scan.c:1860
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1338 [inline]
 free_pcp_prepare+0x374/0x870 mm/page_alloc.c:1389
 free_unref_page_prepare mm/page_alloc.c:3309 [inline]
 free_unref_page+0x19/0x690 mm/page_alloc.c:3388
 __vunmap+0x781/0xb70 mm/vmalloc.c:2632
 free_work+0x58/0x70 mm/vmalloc.c:95
 process_one_work+0x9b2/0x1660 kernel/workqueue.c:2298
 worker_thread+0x65d/0x1130 kernel/workqueue.c:2445
 kthread+0x405/0x4f0 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

Memory state around the buggy address:
 ffff88801bb74a00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88801bb74a80: 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc
>ffff88801bb74b00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff88801bb74b80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff88801bb74c00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
