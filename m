Return-Path: <linux-rdma+bounces-6176-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7019DFF11
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Dec 2024 11:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D71F281F84
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Dec 2024 10:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C941FC0F3;
	Mon,  2 Dec 2024 10:36:26 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBD81FBE9B
	for <linux-rdma@vger.kernel.org>; Mon,  2 Dec 2024 10:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733135786; cv=none; b=CdkD6LecHCJzwE9427WZxxiRua/D+33WflxKegDHLGTGv+/zc3msaBC5Z8u6aTKZn+Sy1PgCglywPr4rRbK9ogud1SKJ0s4tA0moGGiCewFiJhT9BY4RhG4ecCGDVVvS1PcqP8wuqJRhYCKHt+gYgsqLbBJ0XZUkp3UomSnYIhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733135786; c=relaxed/simple;
	bh=2paM0tDtmAKPZ9l1dumsYD0Yt0bbSUIuK7r18zmCx+I=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=KMM56N3mnoAD6f2OgSf1xG6CCOrVfAG2V7EK8UQXwtHT/UPXrIYskWUkf5DZM7JoMPZedSDNpHV3trgjf3si/rHs7TMQC8EzRS9grYYAxCFtyHTZvpYFbfvUFFYI1AIBooTqDxBb2CSins6goMfcc5Qz1RX29AAz/t92DDZHnjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3a7cff77f99so44613065ab.3
        for <linux-rdma@vger.kernel.org>; Mon, 02 Dec 2024 02:36:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733135784; x=1733740584;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1WZRLR5olCCSh9mM2de/1y39zhhUOoM6PWUa2qri7tU=;
        b=eg5ehUMuiLRtt0RT0h/QVizkqG/TsAm/8HQbHxWKMJ7C/d0oxgIj9RwxAygYBbOkiv
         07FFpuyEz/FC5LHIjcu3PuLVk9KoSTpz1Nj6tj9JiRGemBQHEu/+RDV0aqux2XfeTKRQ
         hadAnd9DXpR0xglTQD2kwGWTNl3mz7deGu7c4dvgxgrM3ZPUg9bsqmszp/ErVxVjAOSV
         mcUaEXVEji9LBFFctAyhChD1OQI1N3FoBNXpLM//D6t1fedARwvZm5/BcwnFLgsssbku
         Zurg0nnzlRdoYOT2J2myFsR7BwIrTVv1Le3CBv6URAK0Mz+9tESAHDD3XXF3ju78PwFH
         WhXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpuLHNIx9+qg2XLl3M3UOpbz/dQb+p9GR3YqNr2U7nIkOcX0uLufPTgOiNxQChNnZKbNj/haoRShlQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxNDzLLl46FhFJBy8jWLaKmehC/l4aXF8OMqYpX8MoDYf2qLlRo
	CysSw1cV8eVk4xxXx11jv+G3V+xBTgvQaLbc7G/kW5OQx+dfjxJDR62tW8zEJi0SL7Xoz5bFZNF
	m5ishnmQGiYoUBNUKO89MFWCr04PjFMT76Qd50PcWi7PHG/zJhwT9FL0=
X-Google-Smtp-Source: AGHT+IGoHndnCq+ISeNyRfli6O9/DQSue0+QIP1w8SfCCfC8hbwagR3xGsHMv1uBu2vSAreKeiuuMl8ZHmEReLv7nwnobOANLT9B
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1526:b0:3a7:4e3e:d03a with SMTP id
 e9e14a558f8ab-3a7c55f27d4mr170688775ab.22.1733135784065; Mon, 02 Dec 2024
 02:36:24 -0800 (PST)
Date: Mon, 02 Dec 2024 02:36:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674d8da8.050a0220.ad585.004c.GAE@google.com>
Subject: [syzbot] [rdma?] KASAN: slab-use-after-free Read in ib_device_uevent
From: syzbot <syzbot+50fe89126df17c36e600@syzkaller.appspotmail.com>
To: jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f486c8aa16b8 Add linux-next specific files for 20241128
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=169579e8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e348a4873516af92
dashboard link: https://syzkaller.appspot.com/bug?extid=50fe89126df17c36e600
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/beb58ebb63cf/disk-f486c8aa.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b241b5609e64/vmlinux-f486c8aa.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c9d817f665f2/bzImage-f486c8aa.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+50fe89126df17c36e600@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in string_nocheck lib/vsprintf.c:646 [inline]
BUG: KASAN: slab-use-after-free in string+0x218/0x2b0 lib/vsprintf.c:728
Read of size 1 at addr ffff888020ec1560 by task udevd/5204

CPU: 1 UID: 0 PID: 5204 Comm: udevd Not tainted 6.12.0-next-20241128-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:489
 kasan_report+0x143/0x180 mm/kasan/report.c:602
 string_nocheck lib/vsprintf.c:646 [inline]
 string+0x218/0x2b0 lib/vsprintf.c:728
 vsnprintf+0x1101/0x1da0 lib/vsprintf.c:2848
 add_uevent_var+0x1c8/0x450 lib/kobject_uevent.c:679
 ib_device_uevent+0x79/0xa0 drivers/infiniband/core/device.c:519
 dev_uevent+0x4e4/0x900 drivers/base/core.c:2673
 uevent_show+0x1ba/0x340 drivers/base/core.c:2731
 dev_attr_show+0x55/0xc0 drivers/base/core.c:2423
 sysfs_kf_seq_show+0x331/0x4c0 fs/sysfs/file.c:59
 seq_read_iter+0x43f/0xd70 fs/seq_file.c:230
 new_sync_read fs/read_write.c:484 [inline]
 vfs_read+0x991/0xb70 fs/read_write.c:565
 ksys_read+0x18f/0x2b0 fs/read_write.c:708
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7fda916b6a
Code: 00 3d 00 00 41 00 75 0d 50 48 8d 3d 2d 08 0a 00 e8 ea 7d 01 00 31 c0 e9 07 ff ff ff 64 8b 04 25 18 00 00 00 85 c0 75 1b 0f 05 <48> 3d 00 f0 ff ff 76 6c 48 8b 15 8f a2 0d 00 f7 d8 64 89 02 48 83
RSP: 002b:00007ffe81eda6d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 000056079e2b19b0 RCX: 00007f7fda916b6a
RDX: 0000000000001000 RSI: 000056079e2af9f0 RDI: 000000000000000c
RBP: 000056079e2b19b0 R08: 000000000000000c R09: 0000000000000002
R10: 000000000000010f R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000003fff R14: 00007ffe81edabb8 R15: 000000000000000a
 </TASK>

Allocated by task 7741:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4283 [inline]
 __kmalloc_node_track_caller_noprof+0x28b/0x4c0 mm/slub.c:4302
 __kmemdup_nul mm/util.c:61 [inline]
 kstrdup+0x39/0xb0 mm/util.c:81
 kobject_set_name_vargs+0x61/0x120 lib/kobject.c:274
 dev_set_name+0xd5/0x120 drivers/base/core.c:3468
 assign_name drivers/infiniband/core/device.c:1219 [inline]
 ib_register_device+0x178/0x13e0 drivers/infiniband/core/device.c:1401
 siw_device_register drivers/infiniband/sw/siw/siw_main.c:72 [inline]
 siw_newlink+0x9d9/0xe50 drivers/infiniband/sw/siw/siw_main.c:452
 nldev_newlink+0x5c0/0x640 drivers/infiniband/core/nldev.c:1795
 rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
 rdma_nl_rcv+0x6dd/0x9e0 drivers/infiniband/core/netlink.c:259
 netlink_unicast_kernel net/netlink/af_netlink.c:1321 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1347
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1891
 sock_sendmsg_nosec net/socket.c:711 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:726
 ____sys_sendmsg+0x52a/0x7e0 net/socket.c:2583
 ___sys_sendmsg net/socket.c:2637 [inline]
 __sys_sendmsg+0x269/0x350 net/socket.c:2669
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 7741:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:582
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2338 [inline]
 slab_free mm/slub.c:4598 [inline]
 kfree+0x196/0x430 mm/slub.c:4746
 kobject_rename+0x38f/0x410 lib/kobject.c:524
 device_rename+0x16a/0x200 drivers/base/core.c:4570
 ib_device_rename+0x270/0x680 drivers/infiniband/core/device.c:419
 nldev_set_doit+0x2f2/0x480 drivers/infiniband/core/nldev.c:1146
 rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
 rdma_nl_rcv+0x6dd/0x9e0 drivers/infiniband/core/netlink.c:259
 netlink_unicast_kernel net/netlink/af_netlink.c:1321 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1347
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1891
 sock_sendmsg_nosec net/socket.c:711 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:726
 ____sys_sendmsg+0x52a/0x7e0 net/socket.c:2583
 ___sys_sendmsg net/socket.c:2637 [inline]
 __sys_sendmsg+0x269/0x350 net/socket.c:2669
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888020ec1560
 which belongs to the cache kmalloc-8 of size 8
The buggy address is located 0 bytes inside of
 freed 8-byte region [ffff888020ec1560, ffff888020ec1568)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x20ec1
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff88801ac41500 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000800080 00000001f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 1, tgid 1 (swapper/0), ts 2779255619, free_ts 2778733938
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
 prep_new_page mm/page_alloc.c:1564 [inline]
 get_page_from_freelist+0x3738/0x3880 mm/page_alloc.c:3510
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4787
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 alloc_slab_page+0x6a/0x140 mm/slub.c:2408
 allocate_slab+0x5a/0x2f0 mm/slub.c:2574
 new_slab mm/slub.c:2627 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3815
 __slab_alloc+0x58/0xa0 mm/slub.c:3905
 __slab_alloc_node mm/slub.c:3980 [inline]
 slab_alloc_node mm/slub.c:4141 [inline]
 __do_kmalloc_node mm/slub.c:4282 [inline]
 __kmalloc_node_track_caller_noprof+0x2e9/0x4c0 mm/slub.c:4302
 __kmemdup_nul mm/util.c:61 [inline]
 kstrdup+0x39/0xb0 mm/util.c:81
 __kernfs_new_node+0x9d/0x870 fs/kernfs/dir.c:620
 kernfs_new_node+0x137/0x240 fs/kernfs/dir.c:700
 __kernfs_create_file+0x49/0x2e0 fs/kernfs/file.c:1034
 sysfs_add_bin_file_mode_ns+0x220/0x400 fs/sysfs/file.c:354
 sysfs_create_bin_file+0x1b4/0x2e0 fs/sysfs/file.c:595
 acpi_table_attr_init+0x4ee/0x700 drivers/acpi/sysfs.c:379
page last free pid 1 tgid 1 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_page+0xdef/0x1130 mm/page_alloc.c:2693
 __kmem_cache_do_shrink+0x344/0x3b0 mm/slub.c:5876
 acpi_os_purge_cache+0x15/0x20 drivers/acpi/osl.c:1585
 acpi_purge_cached_objects+0xb8/0xc0 drivers/acpi/acpica/utxface.c:240
 acpi_initialize_objects+0x2e/0xa0 drivers/acpi/acpica/utxfinit.c:250
 acpi_bus_init+0xda/0xbc0 drivers/acpi/bus.c:1367
 acpi_init+0xb4/0x240 drivers/acpi/bus.c:1454
 do_one_initcall+0x248/0x870 init/main.c:1266
 do_initcall_level+0x157/0x210 init/main.c:1328
 do_initcalls+0x3f/0x80 init/main.c:1344
 kernel_init_freeable+0x435/0x5d0 init/main.c:1577
 kernel_init+0x1d/0x2b0 init/main.c:1466
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Memory state around the buggy address:
 ffff888020ec1400: fa fc fc fc 06 fc fc fc 05 fc fc fc 05 fc fc fc
 ffff888020ec1480: 05 fc fc fc 00 fc fc fc 00 fc fc fc fa fc fc fc
>ffff888020ec1500: 05 fc fc fc fa fc fc fc fa fc fc fc fa fc fc fc
                                                       ^
 ffff888020ec1580: fa fc fc fc 05 fc fc fc 06 fc fc fc 05 fc fc fc
 ffff888020ec1600: fa fc fc fc 05 fc fc fc 04 fc fc fc 04 fc fc fc
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

