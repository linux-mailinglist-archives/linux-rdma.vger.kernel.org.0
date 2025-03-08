Return-Path: <linux-rdma+bounces-8489-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2E7A5767C
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Mar 2025 01:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87C43162327
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Mar 2025 00:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED39A12E7E;
	Sat,  8 Mar 2025 00:02:25 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E43E2B9CF
	for <linux-rdma@vger.kernel.org>; Sat,  8 Mar 2025 00:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741392145; cv=none; b=hNz1OE/AGqCMeXBL2QhzjJVlw74h4blijXUZxJVBhSzbzNQhIODVtf7Ohw7VRe1Fe3XHxW/xNlnWbr4O2aU+9xRU2cp2a0Q47P//HbrJjJQjU5n3rlfZk5NWnDicGhw1uvSa3rnI/u/8eUw0WQZMOOkLb3ys8CrVAUhHchvoErU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741392145; c=relaxed/simple;
	bh=fObEnXAg5jsjYy3qkxbdriQ5mNWOHN5qGd+w/wA6llY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=SBjNp7/oWpmzq3gQc4IzfymJvVWL72wTHaedLNUoGJIvjR96eFUAxm01ChrvciJezylJCOMDgimbSh1cg0uszNgriILrkZdUmsHF7Y4sTC2x9thkV8b5e8EZ/6s/gOvVE6AIJCkEn77t/IWAaMZ8tf1iuaYCSLtx54U/7s++duY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3d2a1d6747aso22009145ab.0
        for <linux-rdma@vger.kernel.org>; Fri, 07 Mar 2025 16:02:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741392143; x=1741996943;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=67yxaripNAOdJdg5+dSaxSoYpXuKj+Ayupt/L0ZZGCQ=;
        b=OtVIfoA4CpVd4qOOsP4e64nd9oM2XL3f0akVldy2CS5UHpt8yBPJX0sXki6spvWx3X
         bqXfCNEu39mbWq4u+Im/165/VBlyBVyKlg0GDMpXT8FZunPl73J9CazufJMmOcANYUU4
         VkDkNBlELTutS00RMVdrL+g5h5uSvFOv7BjGFizj6vdIRH8tz1QQHMTfgjY5pRTwfcjM
         uSWrCXmHNdM/dd7hvFwtlxU68ZDIE2kDcmVn4Hb0kmL5qwoRIDGBY+cH/SPuAXVN83Zd
         /nl7MLXlWTPoc5bejLbRAvimZvXo2GHXqptT6BPmkQLITon+VmEm2B6fAo4Ul8BhUhMO
         w2rA==
X-Forwarded-Encrypted: i=1; AJvYcCWNCK9LfBPRcdhYotKEnyH4wgsZALORg49chwecnIVJ9ItB8TlraccRNAFyC4PE16VVDWLvMB5eeAGq@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/0YLLDIiBDLItS4kLSpka7IBJJULG4SruezCChg/Dko5b0MnI
	uu3dHQPxpGkjyAR0nLuJRWTqy2+i4USmSEoPNvFkFHLzSti07c9pwXitBDcjK73mMoU42k17E0r
	BjZAiBVCH+aRcEvAKPVMPr9DWbBV0aI7nY6XsWfWEbCZkauHiG31zMy0=
X-Google-Smtp-Source: AGHT+IF3DwIJMt8Mc6/F+4qf1TYtJraNWFTV7WkqzecM3g8hUknoFG6DlXMel01ydyJi4CAnbgNCouQTfi2Rylr3RTlWfua8hS26
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:378e:b0:3d4:2ea4:6b87 with SMTP id
 e9e14a558f8ab-3d44af34fd9mr11621625ab.11.1741392142556; Fri, 07 Mar 2025
 16:02:22 -0800 (PST)
Date: Fri, 07 Mar 2025 16:02:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67cb890e.050a0220.d8275.022f.GAE@google.com>
Subject: [syzbot] [rdma?] KASAN: slab-use-after-free Read in nla_put (2)
From: syzbot <syzbot+f60349ba1f9f08df349f@syzkaller.appspotmail.com>
To: jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f77f12010f67 Merge branch 'add-usb-net-support-for-telit-c..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=114dcfb8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1770b825960d3ae8
dashboard link: https://syzkaller.appspot.com/bug?extid=f60349ba1f9f08df349f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a2c507ff7038/disk-f77f1201.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5abb8efa39e3/vmlinux-f77f1201.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7d947a5dd280/bzImage-f77f1201.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f60349ba1f9f08df349f@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in nla_put+0xd3/0x150 lib/nlattr.c:1099
Read of size 5 at addr ffff888140ea1c60 by task syz.0.988/10025

CPU: 0 UID: 0 PID: 10025 Comm: syz.0.988 Not tainted 6.14.0-rc4-syzkaller-00859-gf77f12010f67 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0x16e/0x5b0 mm/kasan/report.c:521
 kasan_report+0x143/0x180 mm/kasan/report.c:634
 kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
 __asan_memcpy+0x29/0x70 mm/kasan/shadow.c:105
 nla_put+0xd3/0x150 lib/nlattr.c:1099
 nla_put_string include/net/netlink.h:1621 [inline]
 fill_nldev_handle+0x16e/0x200 drivers/infiniband/core/nldev.c:265
 rdma_nl_notify_event+0x561/0xef0 drivers/infiniband/core/nldev.c:2857
 ib_device_notify_register+0x22/0x230 drivers/infiniband/core/device.c:1344
 ib_register_device+0x1292/0x1460 drivers/infiniband/core/device.c:1460
 rxe_register_device+0x233/0x350 drivers/infiniband/sw/rxe/rxe_verbs.c:1540
 rxe_net_add+0x74/0xf0 drivers/infiniband/sw/rxe/rxe_net.c:550
 rxe_newlink+0xde/0x1a0 drivers/infiniband/sw/rxe/rxe.c:212
 nldev_newlink+0x5ea/0x680 drivers/infiniband/core/nldev.c:1795
 rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
 rdma_nl_rcv+0x6dd/0x9e0 drivers/infiniband/core/netlink.c:259
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1339
 netlink_sendmsg+0x8de/0xcb0 net/netlink/af_netlink.c:1883
 sock_sendmsg_nosec net/socket.c:709 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:724
 ____sys_sendmsg+0x53a/0x860 net/socket.c:2564
 ___sys_sendmsg net/socket.c:2618 [inline]
 __sys_sendmsg+0x269/0x350 net/socket.c:2650
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f42d1b8d169
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f42d2960038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f42d1da6320 RCX: 00007f42d1b8d169
RDX: 0000000000000000 RSI: 00004000000002c0 RDI: 000000000000000c
RBP: 00007f42d1c0e2a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f42d1da6320 R15: 00007ffe399344a8
 </TASK>

Allocated by task 10025:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4294 [inline]
 __kmalloc_node_track_caller_noprof+0x28b/0x4c0 mm/slub.c:4313
 __kmemdup_nul mm/util.c:61 [inline]
 kstrdup+0x42/0x100 mm/util.c:81
 kobject_set_name_vargs+0x61/0x120 lib/kobject.c:274
 dev_set_name+0xd5/0x120 drivers/base/core.c:3468
 assign_name drivers/infiniband/core/device.c:1202 [inline]
 ib_register_device+0x178/0x1460 drivers/infiniband/core/device.c:1384
 rxe_register_device+0x233/0x350 drivers/infiniband/sw/rxe/rxe_verbs.c:1540
 rxe_net_add+0x74/0xf0 drivers/infiniband/sw/rxe/rxe_net.c:550
 rxe_newlink+0xde/0x1a0 drivers/infiniband/sw/rxe/rxe.c:212
 nldev_newlink+0x5ea/0x680 drivers/infiniband/core/nldev.c:1795
 rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
 rdma_nl_rcv+0x6dd/0x9e0 drivers/infiniband/core/netlink.c:259
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1339
 netlink_sendmsg+0x8de/0xcb0 net/netlink/af_netlink.c:1883
 sock_sendmsg_nosec net/socket.c:709 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:724
 ____sys_sendmsg+0x53a/0x860 net/socket.c:2564
 ___sys_sendmsg net/socket.c:2618 [inline]
 __sys_sendmsg+0x269/0x350 net/socket.c:2650
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 10035:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2353 [inline]
 slab_free mm/slub.c:4609 [inline]
 kfree+0x196/0x430 mm/slub.c:4757
 kobject_rename+0x38f/0x410 lib/kobject.c:524
 device_rename+0x16a/0x200 drivers/base/core.c:4525
 ib_device_rename+0x270/0x710 drivers/infiniband/core/device.c:402
 nldev_set_doit+0x30e/0x4c0 drivers/infiniband/core/nldev.c:1146
 rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
 rdma_nl_rcv+0x6dd/0x9e0 drivers/infiniband/core/netlink.c:259
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1339
 netlink_sendmsg+0x8de/0xcb0 net/netlink/af_netlink.c:1883
 sock_sendmsg_nosec net/socket.c:709 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:724
 ____sys_sendmsg+0x53a/0x860 net/socket.c:2564
 ___sys_sendmsg net/socket.c:2618 [inline]
 __sys_sendmsg+0x269/0x350 net/socket.c:2650
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888140ea1c60
 which belongs to the cache kmalloc-8 of size 8
The buggy address is located 0 bytes inside of
 freed 8-byte region [ffff888140ea1c60, ffff888140ea1c68)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x140ea1
flags: 0x57ff00000000000(node=1|zone=2|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 057ff00000000000 ffff88801b041500 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000800080 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 1, tgid 1 (swapper/0), ts 3099873211, free_ts 3013711200
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f4/0x240 mm/page_alloc.c:1551
 prep_new_page mm/page_alloc.c:1559 [inline]
 get_page_from_freelist+0x365c/0x37a0 mm/page_alloc.c:3477
 __alloc_frozen_pages_noprof+0x292/0x710 mm/page_alloc.c:4739
 alloc_pages_mpol+0x311/0x660 mm/mempolicy.c:2270
 alloc_slab_page mm/slub.c:2423 [inline]
 allocate_slab+0x8f/0x3a0 mm/slub.c:2587
 new_slab mm/slub.c:2640 [inline]
 ___slab_alloc+0xc27/0x14a0 mm/slub.c:3826
 __slab_alloc+0x58/0xa0 mm/slub.c:3916
 __slab_alloc_node mm/slub.c:3991 [inline]
 slab_alloc_node mm/slub.c:4152 [inline]
 __do_kmalloc_node mm/slub.c:4293 [inline]
 __kmalloc_node_track_caller_noprof+0x2e9/0x4c0 mm/slub.c:4313
 __kmemdup_nul mm/util.c:61 [inline]
 kstrdup+0x42/0x100 mm/util.c:81
 acpi_add_id drivers/acpi/scan.c:1343 [inline]
 acpi_set_pnp_ids drivers/acpi/scan.c:1415 [inline]
 acpi_init_device_object+0x12bd/0x31f0 drivers/acpi/scan.c:1828
 acpi_add_single_object+0x106/0x1e00 drivers/acpi/scan.c:1879
 acpi_bus_check_add+0x32b/0x980 drivers/acpi/scan.c:2180
 acpi_ns_walk_namespace+0x294/0x4f0
 acpi_walk_namespace+0xeb/0x130 drivers/acpi/acpica/nsxfeval.c:606
 acpi_bus_scan+0x4c1/0x560 drivers/acpi/scan.c:2594
 acpi_scan_init+0x267/0x730 drivers/acpi/scan.c:2746
page last free pid 1 tgid 1 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_frozen_pages+0xe0d/0x10e0 mm/page_alloc.c:2660
 discard_slab mm/slub.c:2684 [inline]
 __put_partials+0x160/0x1c0 mm/slub.c:3153
 put_cpu_partial+0x17c/0x250 mm/slub.c:3228
 __slab_free+0x290/0x380 mm/slub.c:4479
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_remove_cache+0x15d/0x180 mm/kasan/quarantine.c:378
 kmem_cache_shrink+0xd/0x20 mm/slab_common.c:565
 acpi_os_purge_cache+0x15/0x20 drivers/acpi/osl.c:1605
 acpi_purge_cached_objects+0x8f/0xc0 drivers/acpi/acpica/utxface.c:239
 acpi_initialize_objects+0x2e/0xa0 drivers/acpi/acpica/utxfinit.c:250
 acpi_bus_init+0xda/0xbc0 drivers/acpi/bus.c:1367
 acpi_init+0xb4/0x240 drivers/acpi/bus.c:1454
 do_one_initcall+0x248/0x930 init/main.c:1257
 do_initcall_level+0x157/0x210 init/main.c:1319
 do_initcalls+0x71/0xd0 init/main.c:1335
 kernel_init_freeable+0x435/0x5d0 init/main.c:1568

Memory state around the buggy address:
 ffff888140ea1b00: 05 fc fc fc 06 fc fc fc 06 fc fc fc 06 fc fc fc
 ffff888140ea1b80: fa fc fc fc 05 fc fc fc 00 fc fc fc 00 fc fc fc
>ffff888140ea1c00: 05 fc fc fc 05 fc fc fc fa fc fc fc fa fc fc fc
                                                       ^
 ffff888140ea1c80: fa fc fc fc fa fc fc fc fa fc fc fc fa fc fc fc
 ffff888140ea1d00: fa fc fc fc fa fc fc fc fa fc fc fc 05 fc fc fc
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

