Return-Path: <linux-rdma+bounces-13261-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 476EDB526A7
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Sep 2025 04:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6F3E583456
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Sep 2025 02:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D33221F0C;
	Thu, 11 Sep 2025 02:45:30 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78C01684A4
	for <linux-rdma@vger.kernel.org>; Thu, 11 Sep 2025 02:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757558730; cv=none; b=ofMHIH8F46KlWSUGlKSCOUr7catxsZzvIBp+xoXVVHOvnTgJNFQvjtKnp2joT5ytPijM4O57oH2nx5DCyNN02vaio1BWcG6B/V4Rxv2AOigYyNM7bzdm2oOK9BaXr/ZWHGivBs2064pi2fDT2RhQ3+rTU5caguHqORJ1/T9u/Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757558730; c=relaxed/simple;
	bh=Kx4XKGUt0cm1Kh3AJGbJzGLZru5R153AUrWHkFQIcn4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=DbnzEslgB7jcRDnhF9ZPqoLTcQsQr6BQlJ3Dac8Fn1cqEU060pxOUKqnG8qcn0R9ebPy0a0N6Z7eraeiXApW6Utzc1zJT4OdTWbhAOlnTsEVCZrr3zLb8f7Oucmsl8aHirB/801k5IbDAyQBmU7rNQHBemktwLSiISmd4TeeNPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-88c2ff21d59so64348039f.1
        for <linux-rdma@vger.kernel.org>; Wed, 10 Sep 2025 19:45:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757558728; x=1758163528;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6CEC/hDrL0RYvcCVpYbKdGS2Fgqi1L5qHrsPvYtgkC0=;
        b=DYmb4H2FO9WYYHhrdEokYcdUANzUHlXvFIPyy+ydUHDy6/yffdO4Nc3pH1t+qq+NyT
         J7lH+cUhnyNJAvVWHKnwxdhqT4yfHQ/FLh3pGOk3GZq8QmnsEFMbi/uip6+sSIfaFfwz
         b0FFtOrLdlLaQtGvXY1qB9H0NGQZTeCgCoTt3ZN2UWPjQLwwsKsvu4CVurSPX62reJcq
         miii1THC9h22TIkTuv/I7BHWvg96scYyrv4szNNGGofymvAcKAbzTYG8AIB7Tc/gLjhv
         izgY6nS3LPuY7XITBnPWa8VN2pNRJ/bQBWIdRxg8k8VbWqInL4Igk8q8iqMQX2pdWicC
         nUGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXUF24nlXYImmBA1T3hTkFG1IJuR9TXkQ4XUED9/sQbAWFdgCSsIrns8fawmkif9sHFcQsceUSFQUh@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ8Kw56KR3yc8fisY8pcV7IPQjxDzTzBj9HuQMNZR+x0yIUbvw
	BzV79EjRjZV7a6FD8izzPMEoZPDVErl5YsoDeP43bDCVWWvWJksqWp4pviEVRQgx/60vvZW1NN7
	GX6v0+4vmdObYT12BHxarkPBDTAQJndKdxqqyG9rdsWHCUDg0/SwpYtRqz5Q=
X-Google-Smtp-Source: AGHT+IEp9oIOa2JvRV2TLv6zUHy7G0oti8Rg0SIvm5ulajf2zyYlJIzCreGeUJ7yrZ8VcX/JNL9SFj1VpBgcXhcs0CAO1BgxR0uG
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c3:b0:409:5da6:c72b with SMTP id
 e9e14a558f8ab-4095da6c7cfmr208270705ab.4.1757558727883; Wed, 10 Sep 2025
 19:45:27 -0700 (PDT)
Date: Wed, 10 Sep 2025 19:45:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c237c7.050a0220.3c6139.0036.GAE@google.com>
Subject: [syzbot] [smc?] KASAN: use-after-free Read in __pnet_find_base_ndev
From: syzbot <syzbot+ea28e9d85be2f327b6c6@syzkaller.appspotmail.com>
To: alibuda@linux.alibaba.com, davem@davemloft.net, dust.li@linux.alibaba.com, 
	edumazet@google.com, guwen@linux.alibaba.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-s390@vger.kernel.org, mjambigi@linux.ibm.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, sidraya@linux.ibm.com, syzkaller-bugs@googlegroups.com, 
	tonylu@linux.alibaba.com, wenjia@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e0d1c55501d3 net: phy: fix phy_uses_state_machine()
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=10287562580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9c302bcfb26a48af
dashboard link: https://syzkaller.appspot.com/bug?extid=ea28e9d85be2f327b6c6
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6163bf409a9b/disk-e0d1c555.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6d13a8029999/vmlinux-e0d1c555.xz
kernel image: https://storage.googleapis.com/syzbot-assets/41adcb613128/bzImage-e0d1c555.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ea28e9d85be2f327b6c6@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in __pnet_find_base_ndev+0x1b1/0x1c0 net/smc/smc_pnet.c:926
Read of size 1 at addr ffff888036bac33a by task syz.0.3632/18609

CPU: 1 UID: 0 PID: 18609 Comm: syz.0.3632 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 __pnet_find_base_ndev+0x1b1/0x1c0 net/smc/smc_pnet.c:926
 pnet_find_base_ndev net/smc/smc_pnet.c:946 [inline]
 smc_pnet_find_ism_by_pnetid net/smc/smc_pnet.c:1103 [inline]
 smc_pnet_find_ism_resource+0xef/0x390 net/smc/smc_pnet.c:1154
 smc_find_ism_device net/smc/af_smc.c:1030 [inline]
 smc_find_proposal_devices net/smc/af_smc.c:1115 [inline]
 __smc_connect+0x372/0x1890 net/smc/af_smc.c:1545
 smc_connect+0x877/0xd90 net/smc/af_smc.c:1715
 __sys_connect_file net/socket.c:2086 [inline]
 __sys_connect+0x313/0x440 net/socket.c:2105
 __do_sys_connect net/socket.c:2111 [inline]
 __se_sys_connect net/socket.c:2108 [inline]
 __x64_sys_connect+0x7a/0x90 net/socket.c:2108
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f47cbf8eba9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f47ccdb1038 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: ffffffffffffffda RBX: 00007f47cc1d5fa0 RCX: 00007f47cbf8eba9
RDX: 0000000000000010 RSI: 0000200000000280 RDI: 000000000000000b
RBP: 00007f47cc011e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f47cc1d6038 R14: 00007f47cc1d5fa0 R15: 00007ffc512f8aa8
 </TASK>

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff888036bacd00 pfn:0x36bac
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 ffffea0001243d08 ffff8880b863fdc0 0000000000000000
raw: ffff888036bacd00 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 2, migratetype Unmovable, gfp_mask 0x446dc0(GFP_KERNEL_ACCOUNT|__GFP_ZERO|__GFP_NOWARN|__GFP_RETRY_MAYFAIL|__GFP_COMP), pid 16741, tgid 16741 (syz-executor), ts 343313197788, free_ts 380670750466
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1851
 prep_new_page mm/page_alloc.c:1859 [inline]
 get_page_from_freelist+0x21e4/0x22c0 mm/page_alloc.c:3858
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5148
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2416
 ___kmalloc_large_node+0x5f/0x1b0 mm/slub.c:4317
 __kmalloc_large_node_noprof+0x18/0x90 mm/slub.c:4348
 __do_kmalloc_node mm/slub.c:4364 [inline]
 __kvmalloc_node_noprof+0x6d/0x5f0 mm/slub.c:5067
 alloc_netdev_mqs+0xa3/0x11b0 net/core/dev.c:11812
 tun_set_iff+0x532/0xef0 drivers/net/tun.c:2775
 __tun_chr_ioctl+0x788/0x1df0 drivers/net/tun.c:3085
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:598 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:584
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 18610 tgid 18608 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1395 [inline]
 __free_frozen_pages+0xbc4/0xd30 mm/page_alloc.c:2895
 free_large_kmalloc+0x13a/0x1f0 mm/slub.c:4820
 device_release+0x99/0x1c0 drivers/base/core.c:-1
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x22b/0x480 lib/kobject.c:737
 netdev_run_todo+0xd2e/0xea0 net/core/dev.c:11513
 rtnl_unlock net/core/rtnetlink.c:157 [inline]
 rtnl_net_unlock include/linux/rtnetlink.h:135 [inline]
 rtnl_dellink+0x537/0x710 net/core/rtnetlink.c:3563
 rtnetlink_rcv_msg+0x7cc/0xb70 net/core/rtnetlink.c:6946
 netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2552
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x82f/0x9e0 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg+0x219/0x270 net/socket.c:729
 ____sys_sendmsg+0x505/0x830 net/socket.c:2614
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2668
 __sys_sendmsg net/socket.c:2700 [inline]
 __do_sys_sendmsg net/socket.c:2705 [inline]
 __se_sys_sendmsg net/socket.c:2703 [inline]
 __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2703
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888036bac200: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff888036bac280: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff888036bac300: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                                        ^
 ffff888036bac380: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff888036bac400: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
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

