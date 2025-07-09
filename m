Return-Path: <linux-rdma+bounces-11991-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E29AFDC3D
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Jul 2025 02:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C58C7A2569
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Jul 2025 00:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CFA3D6F;
	Wed,  9 Jul 2025 00:12:28 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C4120E6
	for <linux-rdma@vger.kernel.org>; Wed,  9 Jul 2025 00:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752019948; cv=none; b=L9G4EGCiub4h+eQJsG9PxDXPHFAcDLHZqnCX2f2gUSdQe6Lqih8Cc/PfuuJTblSHPkVj6ndyF+xenGj7J2Vk2uBKYN6pcGeMx66ksGZzapeefPzGY1M1x5cM4TohXxehB/CTLuW1lXUMslJxWwcUOhu6S5cdmwfwjVYp5zOtDEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752019948; c=relaxed/simple;
	bh=HXWCrIaPDPLkGI1PqM06QyFKvzK4WSyMEFXcLfv3oIs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=FDsIpXt7MnuFUVA2y5G0Ek8JuKDHcJCU7pgdOMufAMeUYnvdQF3GLAzqI9RISB4RZ+dQ8LjUA7HErKyROEZpQt/7+yKr47i4a1kb5jfeUdxsUt/A3aN+0KqVHw7qg+pfSSfeZr+85G8gb+n9Jl6Y+qaFS+wn4Z2RX3f8QKoZU5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-86cfff5669bso53831539f.0
        for <linux-rdma@vger.kernel.org>; Tue, 08 Jul 2025 17:12:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752019946; x=1752624746;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BTYqsFgze3SSfnQcK8mfH3HrCc1NKzShgJGYzZ/nOVE=;
        b=QNot4/huKEzB9YFWqRfKQv8X/lnQg3V476UldAxChYIRE+TsKzXBXwPWWNq/UhyDrZ
         ERWwFwsSg1DsxLpxgbWYFQvp4GwZf5P8I7JKpEV5ZGVyfjMK3AfHKBHcjJ/TI6NUr2/9
         gVQJUxf4MvcFf5nCT6WuAoYmIYMAXYlTuw7C+jN3juF7/0v4chJxhw7XkopGFAHlks8i
         zQ0/SuDZvQFaUlMS6TaGZPwNZU8AB/F1eZczZ8qIvFh9XWAWhjnRZl9y67P3T6LlronE
         RjqJ7q70lydMIaWI4hye5l/00oLZ7/3UL7n55NIDpVCwbvF16NJ5xM4csgcxG6Cs0I8P
         xnCw==
X-Forwarded-Encrypted: i=1; AJvYcCWE3ohwEX3/jC/xmPm1+jJRJZVpNVsFzKyf3roNfrM1B+/UZAyf3Rl+44Lc1AHt3nQ6t/oF5L2EBJB1@vger.kernel.org
X-Gm-Message-State: AOJu0YyxKHRLTG4piKUSfW1d7yooXuETZz0+PvMSDh3zffEF6zm5dN05
	6eBBPZbUDq5SanoHrogm5M54FZStKVm29s3J22Bs9jTbisJzo3st052d/qQssJhBRvbszzy+Nw4
	fpC/xed4gIHYLd1fdZegC4Bf4Gf5L7q3FH8K8cAPWmBl/hc9jxDIw7a9qkUk=
X-Google-Smtp-Source: AGHT+IGDORhbTTDyzD6HqSvzBndNz7qpdJ4jdMJ2S5zPSa9IBkY2m4blDOhLPken/+YDlcZM/z4F3Qs6W6f2Kz5E2nf6vdLXkWZR
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:400f:b0:876:adc1:44e5 with SMTP id
 ca18e2360f4ac-8795c1f17a9mr35222439f.3.1752019946132; Tue, 08 Jul 2025
 17:12:26 -0700 (PDT)
Date: Tue, 08 Jul 2025 17:12:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686db3ea.050a0220.1ffab7.0028.GAE@google.com>
Subject: [syzbot] [rdma?] KASAN: slab-use-after-free Read in ucma_create_uevent
From: syzbot <syzbot+a6ffe86390c8a6afc818@syzkaller.appspotmail.com>
To: jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d006330be3f7 Merge tag 'sound-6.16-rc6' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13e4bf70580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8fa6c6703a4b2315
dashboard link: https://syzkaller.appspot.com/bug?extid=a6ffe86390c8a6afc818
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17e4bf70580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14f6ca8c580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-d006330b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d47418563f9c/vmlinux-d006330b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/677ac864031c/bzImage-d006330b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a6ffe86390c8a6afc818@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in ucma_create_uevent+0xadb/0xb30 drivers/infiniband/core/ucma.c:275
Read of size 8 at addr ffff888029155410 by task kworker/u32:9/1147

CPU: 3 UID: 0 PID: 1147 Comm: kworker/u32:9 Not tainted 6.16.0-rc5-syzkaller-00025-gd006330be3f7 #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: rdma_cm cma_iboe_join_work_handler
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0xcd/0x680 mm/kasan/report.c:521
 kasan_report+0xe0/0x110 mm/kasan/report.c:634
 ucma_create_uevent+0xadb/0xb30 drivers/infiniband/core/ucma.c:275
 ucma_event_handler+0x102/0x940 drivers/infiniband/core/ucma.c:351
 cma_cm_event_handler+0x97/0x300 drivers/infiniband/core/cma.c:2173
 cma_iboe_join_work_handler+0xca/0x170 drivers/infiniband/core/cma.c:3008
 process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3321 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3402
 kthread+0x3c5/0x780 kernel/kthread.c:464
 ret_from_fork+0x5d7/0x6f0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 6107:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 ucma_process_join+0x237/0xa30 drivers/infiniband/core/ucma.c:1465
 ucma_join_multicast+0xe8/0x160 drivers/infiniband/core/ucma.c:1557
 ucma_write+0x1fb/0x330 drivers/infiniband/core/ucma.c:1738
 vfs_write+0x2a0/0x1150 fs/read_write.c:684
 ksys_write+0x1f8/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 6107:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x51/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2381 [inline]
 slab_free mm/slub.c:4643 [inline]
 kfree+0x2b4/0x4d0 mm/slub.c:4842
 ucma_process_join+0x3b9/0xa30 drivers/infiniband/core/ucma.c:1516
 ucma_join_multicast+0xe8/0x160 drivers/infiniband/core/ucma.c:1557
 ucma_write+0x1fb/0x330 drivers/infiniband/core/ucma.c:1738
 vfs_write+0x2a0/0x1150 fs/read_write.c:684
 ksys_write+0x1f8/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888029155400
 which belongs to the cache kmalloc-192 of size 192
The buggy address is located 16 bytes inside of
 freed 192-byte region [ffff888029155400, ffff8880291554c0)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x29155
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff88801b8423c0 ffffea0000a60c80 dead000000000002
raw: 0000000000000000 0000000080100010 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 1, tgid 1 (swapper/0), ts 12897812541, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1c0/0x230 mm/page_alloc.c:1704
 prep_new_page mm/page_alloc.c:1712 [inline]
 get_page_from_freelist+0x1321/0x3890 mm/page_alloc.c:3669
 __alloc_frozen_pages_noprof+0x261/0x23f0 mm/page_alloc.c:4959
 alloc_pages_mpol+0x1fb/0x550 mm/mempolicy.c:2419
 alloc_slab_page mm/slub.c:2451 [inline]
 allocate_slab mm/slub.c:2619 [inline]
 new_slab+0x23b/0x330 mm/slub.c:2673
 ___slab_alloc+0xd9c/0x1940 mm/slub.c:3859
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3949
 __slab_alloc_node mm/slub.c:4024 [inline]
 slab_alloc_node mm/slub.c:4185 [inline]
 __kmalloc_cache_noprof+0xfb/0x3e0 mm/slub.c:4354
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 call_usermodehelper_setup+0xaf/0x360 kernel/umh.c:362
 kobject_uevent_env+0x1690/0x1870 lib/kobject_uevent.c:628
 driver_bound+0x164/0x230 drivers/base/dd.c:421
 really_probe+0x62b/0xa90 drivers/base/dd.c:707
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:799
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:829
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:957
 bus_for_each_drv+0x156/0x1e0 drivers/base/bus.c:462
page_owner free stack trace missing

Memory state around the buggy address:
 ffff888029155300: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888029155380: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>ffff888029155400: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                         ^
 ffff888029155480: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff888029155500: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

