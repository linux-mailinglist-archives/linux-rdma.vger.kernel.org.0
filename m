Return-Path: <linux-rdma+bounces-9935-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA930AA47DE
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Apr 2025 12:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 180D79A755D
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Apr 2025 10:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F9B23BD0E;
	Wed, 30 Apr 2025 10:09:34 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08982222587
	for <linux-rdma@vger.kernel.org>; Wed, 30 Apr 2025 10:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746007774; cv=none; b=VYnxIUI6Wyt3kQTEfN3abdj2p3B+q7CfKrFSIhKET0n988SOHPqptGvpdGjZ5xnHEosyo8kuP6xplYS8m7caao2ZIm7acujyWd0H2Ik8dQwe6M21e/B1Khl4FOADw+NtuUo3Ghe2p4tdI6zqH3P7cyCXA+1x4uKK5f8ZyS9y9IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746007774; c=relaxed/simple;
	bh=Xiwn4m1y1/4XK4GhXH1XarKpwDgevcijcV6nHGnhUfo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=NBtj31TtquHS+UZ4fxDgeQJngEWelwwgSyEELa/UZh/xBsmkJAtIGxPIKhq0P0CMtnnsO8F0OpgrLtmwxzt+ixSIAo01+F53n7Ur4A9uYNiAIFEA610UBZacvAPAvLiGwFx8RiwUkvvYX0MMqLej+9cKNfLznmUXv8XR+6ie2WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-8610d7ec4d3so1092898839f.0
        for <linux-rdma@vger.kernel.org>; Wed, 30 Apr 2025 03:09:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746007772; x=1746612572;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=owYoddgXi49+mdnoF9Q7fo85eH1J3O6rJZlwx4Gv0dc=;
        b=U5eqA0NS1f4cLRnbxJ0WMTc3gBAysNgEF6xD/wEQYDRfpipE5zLrlVSzeX2QhwTsM6
         AOuakpmI1E2VwLk4bUtTXxYXa/LseWdLU/s8fXuEgLiS8gs2AZUL0JeVwjn+CIJB5vy3
         9zRaihROnhx0l6RC/rMkhqL/dasCvigI735f3K2CiiTNkawc9ZyopehOVYnqr49ZssEz
         Dh8Cgul+UGzoG3qXm+9GcvvbMOlZRvGgaUclUJXjZzIQ1GY5Yfe1I24YlIaTXe5IcGqc
         okdKkCB+A3ugX+D6mdisDgvhssjf2ZuB6DfkF3N5dnBzPPT7ACFgC3JmyPl3l6zrDpv3
         UEaA==
X-Forwarded-Encrypted: i=1; AJvYcCX1gG4Tgt0K7uKLWs93HsFQs5dAZvqXwyrv8BkdukhD+Hcf9T/7+zJQNwze4KOyH/gorOF58dG0HvgG@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9yb8bU3eC+dp+h1pZgktc9L7nwhNC9USOHAZL94jxBbRroAYi
	eqLWwpBQhhQ/53ovtVZBvUFIHNAXI6edds/lcDhEGdGCSjP0E73sKIJPQaWTr8I793kaFCJUCok
	ZED6yVHDa5TqUIR0gszoQmFQBhr9ZQ9mhWzv20dOHmd4C00fpTdihTtQ=
X-Google-Smtp-Source: AGHT+IGnPmmFwGOzCY1fGYkrchQc0kdSjqWR9z0eYAVNyscxrnQDRyxIQzruMZ988cZzNbNF6RHRst4FH2A78EXT3Ybtnh4sauZJ
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:4811:b0:864:6799:6059 with SMTP id
 ca18e2360f4ac-86495e1aeadmr343016339f.3.1746007772115; Wed, 30 Apr 2025
 03:09:32 -0700 (PDT)
Date: Wed, 30 Apr 2025 03:09:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6811f6dc.050a0220.39e3a1.0d0d.GAE@google.com>
Subject: [syzbot] [rdma?] KASAN: slab-use-after-free Read in ib_register_device
From: syzbot <syzbot+e2ce9e275ecc70a30b72@syzkaller.appspotmail.com>
To: jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    02ddfb981de8 Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11434368580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9f5bd2a76d9d0b4e
dashboard link: https://syzkaller.appspot.com/bug?extid=e2ce9e275ecc70a30b72
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/37d29bf0bb8b/disk-02ddfb98.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/04b17f9932d8/vmlinux-02ddfb98.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a1c7813f1b54/bzImage-02ddfb98.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e2ce9e275ecc70a30b72@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in strlen+0x93/0xa0 lib/string.c:420
Read of size 1 at addr ffff88801e6cfea1 by task syz.2.292/7048

CPU: 1 UID: 0 PID: 7048 Comm: syz.2.292 Not tainted 6.15.0-rc3-syzkaller-00094-g02ddfb981de8 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/19/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0xc3/0x670 mm/kasan/report.c:521
 kasan_report+0xe0/0x110 mm/kasan/report.c:634
 strlen+0x93/0xa0 lib/string.c:420
 __fortify_strlen include/linux/fortify-string.h:268 [inline]
 get_kobj_path_length lib/kobject.c:118 [inline]
 kobject_get_path+0x3f/0x2a0 lib/kobject.c:158
 kobject_uevent_env+0x289/0x1870 lib/kobject_uevent.c:545
 ib_register_device drivers/infiniband/core/device.c:1472 [inline]
 ib_register_device+0x8cf/0xe00 drivers/infiniband/core/device.c:1393
 rxe_register_device+0x275/0x320 drivers/infiniband/sw/rxe/rxe_verbs.c:1552
 rxe_net_add+0x8e/0xe0 drivers/infiniband/sw/rxe/rxe_net.c:550
 rxe_newlink+0x70/0x190 drivers/infiniband/sw/rxe/rxe.c:225
 nldev_newlink+0x3a3/0x680 drivers/infiniband/core/nldev.c:1796
 rdma_nl_rcv_msg+0x387/0x6e0 drivers/infiniband/core/netlink.c:195
 rdma_nl_rcv_skb.constprop.0.isra.0+0x2e5/0x450 drivers/infiniband/core/netlink.c:239
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0x53a/0x7f0 net/netlink/af_netlink.c:1339
 netlink_sendmsg+0x8d1/0xdd0 net/netlink/af_netlink.c:1883
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg net/socket.c:727 [inline]
 ____sys_sendmsg+0xa95/0xc70 net/socket.c:2566
 ___sys_sendmsg+0x134/0x1d0 net/socket.c:2620
 __sys_sendmsg+0x16d/0x220 net/socket.c:2652
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb12658e969
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb127391038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fb1267b6080 RCX: 00007fb12658e969
RDX: 0000000000000000 RSI: 0000200000000240 RDI: 0000000000000009
RBP: 00007fb126610ab1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fb1267b6080 R15: 00007ffe92b5e748
 </TASK>

Allocated by task 7048:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4341 [inline]
 __kmalloc_node_track_caller_noprof+0x221/0x510 mm/slub.c:4360
 __kmemdup_nul mm/util.c:63 [inline]
 kstrdup+0x53/0x100 mm/util.c:83
 kstrdup_const+0x63/0x80 mm/util.c:103
 kvasprintf_const+0x164/0x1a0 lib/kasprintf.c:46
 kobject_set_name_vargs+0x5a/0x140 lib/kobject.c:274
 dev_set_name+0xc7/0x100 drivers/base/core.c:3469
 assign_name drivers/infiniband/core/device.c:1211 [inline]
 ib_register_device+0x7df/0xe00 drivers/infiniband/core/device.c:1398
 rxe_register_device+0x275/0x320 drivers/infiniband/sw/rxe/rxe_verbs.c:1552
 rxe_net_add+0x8e/0xe0 drivers/infiniband/sw/rxe/rxe_net.c:550
 rxe_newlink+0x70/0x190 drivers/infiniband/sw/rxe/rxe.c:225
 nldev_newlink+0x3a3/0x680 drivers/infiniband/core/nldev.c:1796
 rdma_nl_rcv_msg+0x387/0x6e0 drivers/infiniband/core/netlink.c:195
 rdma_nl_rcv_skb.constprop.0.isra.0+0x2e5/0x450 drivers/infiniband/core/netlink.c:239
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0x53a/0x7f0 net/netlink/af_netlink.c:1339
 netlink_sendmsg+0x8d1/0xdd0 net/netlink/af_netlink.c:1883
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg net/socket.c:727 [inline]
 ____sys_sendmsg+0xa95/0xc70 net/socket.c:2566
 ___sys_sendmsg+0x134/0x1d0 net/socket.c:2620
 __sys_sendmsg+0x16d/0x220 net/socket.c:2652
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 7111:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x51/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2398 [inline]
 slab_free mm/slub.c:4656 [inline]
 kfree+0x2b6/0x4d0 mm/slub.c:4855
 kfree_const+0x55/0x60 mm/util.c:45
 kobject_rename+0x178/0x260 lib/kobject.c:524
 device_rename+0x130/0x230 drivers/base/core.c:4526
 ib_device_rename+0x113/0x5c0 drivers/infiniband/core/device.c:402
 nldev_set_doit+0x3d7/0x4e0 drivers/infiniband/core/nldev.c:1147
 rdma_nl_rcv_msg+0x387/0x6e0 drivers/infiniband/core/netlink.c:195
 rdma_nl_rcv_skb.constprop.0.isra.0+0x2e5/0x450 drivers/infiniband/core/netlink.c:239
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0x53a/0x7f0 net/netlink/af_netlink.c:1339
 netlink_sendmsg+0x8d1/0xdd0 net/netlink/af_netlink.c:1883
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg net/socket.c:727 [inline]
 ____sys_sendmsg+0xa95/0xc70 net/socket.c:2566
 ___sys_sendmsg+0x134/0x1d0 net/socket.c:2620
 __sys_sendmsg+0x16d/0x220 net/socket.c:2652
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88801e6cfea0
 which belongs to the cache kmalloc-8 of size 8
The buggy address is located 1 bytes inside of
 freed 8-byte region [ffff88801e6cfea0, ffff88801e6cfea8)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1e6cf
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff88801b441500 ffffea00009f5200 dead000000000002
raw: 0000000000000000 0000000000800080 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 1, tgid 1 (swapper/0), ts 2371251963, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x181/0x1b0 mm/page_alloc.c:1718
 prep_new_page mm/page_alloc.c:1726 [inline]
 get_page_from_freelist+0x135c/0x3920 mm/page_alloc.c:3688
 __alloc_frozen_pages_noprof+0x263/0x23a0 mm/page_alloc.c:4970
 alloc_pages_mpol+0x1fb/0x550 mm/mempolicy.c:2301
 alloc_slab_page mm/slub.c:2468 [inline]
 allocate_slab mm/slub.c:2632 [inline]
 new_slab+0x244/0x340 mm/slub.c:2686
 ___slab_alloc+0xd9c/0x1940 mm/slub.c:3872
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3962
 __slab_alloc_node mm/slub.c:4037 [inline]
 slab_alloc_node mm/slub.c:4198 [inline]
 __do_kmalloc_node mm/slub.c:4340 [inline]
 __kmalloc_noprof+0x2f2/0x510 mm/slub.c:4353
 kmalloc_noprof include/linux/slab.h:909 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 acpi_ns_internalize_name+0x144/0x220 drivers/acpi/acpica/nsutils.c:331
 acpi_ns_get_node_unlocked+0x163/0x310 drivers/acpi/acpica/nsutils.c:666
 acpi_ns_get_node+0x4c/0x70 drivers/acpi/acpica/nsutils.c:726
 acpi_ns_evaluate+0x6ef/0xca0 drivers/acpi/acpica/nseval.c:62
 acpi_evaluate_object+0x1fa/0xa90 drivers/acpi/acpica/nsxfeval.c:354
 acpi_evaluate_dsm+0x194/0x290 drivers/acpi/utils.c:797
 acpi_check_dsm+0x51/0x260 drivers/acpi/utils.c:830
 device_has_acpi_name drivers/pci/pci-label.c:44 [inline]
 acpi_attr_is_visible+0xb3/0x130 drivers/pci/pci-label.c:221
page_owner free stack trace missing

Memory state around the buggy address:
 ffff88801e6cfd80: fa fc fc fc fa fc fc fc fa fc fc fc fa fc fc fc
 ffff88801e6cfe00: fa fc fc fc fa fc fc fc fa fc fc fc 00 fc fc fc
>ffff88801e6cfe80: 00 fc fc fc fa fc fc fc 02 fc fc fc 04 fc fc fc
                               ^
 ffff88801e6cff00: fa fc fc fc 02 fc fc fc fa fc fc fc fa fc fc fc
 ffff88801e6cff80: fa fc fc fc fa fc fc fc fa fc fc fc fa fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

