Return-Path: <linux-rdma+bounces-7237-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C9A6A1D1D9
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Jan 2025 08:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E625A3A3071
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Jan 2025 07:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E58A1FCCE7;
	Mon, 27 Jan 2025 07:59:23 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43821155751
	for <linux-rdma@vger.kernel.org>; Mon, 27 Jan 2025 07:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737964763; cv=none; b=rlP9ba7aM7+Of9GpJrdXaIx7jbl+ggrWhSSYEhqtFhujvF2t/k6vpAedMztFvp6uWOxCExoLqqiXQ3/2P9SkCOuMaq5J3L1tp0iR+YJitUd/CSH1CN+Okx/I0YFG5aB7H45UuU7nvSpZS4s3e5i4aV9aOlUxNI5iZa7uX4yUpME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737964763; c=relaxed/simple;
	bh=Tx4CSbsxbkdjd3ftpNcEHsrs3U+dpxaBchxukQhfDFQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=UbUGVvVEvT8X+KEKXf2ChxKKv8QkvNhPQneVfeztk8DzJCn8VsymoI0Im2RZ2ERriscFXOneKKOxC3HBql39jGTqWNjeSVPXzLok8yPkx+s0gFvIIMSyVakPGC0yuKptpLNPRs0b2T6WGsrn/UZc8N7c5ZTFs+ojbzZQOxLordU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3cfc08132adso60790475ab.3
        for <linux-rdma@vger.kernel.org>; Sun, 26 Jan 2025 23:59:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737964760; x=1738569560;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ph1p0BdxTRtIVgV7v4nyb6Kwxh11GNpsEsdkgDxaZko=;
        b=iIbINBCh8YNKHiAScGIrq87JWq38Iw1cVPkiPOyxokl1lls6VyZnsHxL4SsCFIuJjl
         IaYd2XxyO3lpWp/igDk6n7L8dKUeXdvZFnl6wgoNFibuPHDLcBUlAFEH7LmxbA3tJw7e
         hSGoZSdsR5nmz+Bu+s78t8Ga9i1afZ/O662wHlb7apjII0eNXdcVt57PRmSCquDQYh9O
         H5NSXvTo6ys72Qxdte2DZuz4zipBm3MM4VtdkUv6bft+A0qjUjFwXvvkjXJ4LemJHZK8
         f7GCn9kqEIMc4ud1iwjABTTfMdMv1PZIq2vLv2WOp0MKhyNmUXu7qOXT3LHwAvO0oFlP
         +vFg==
X-Forwarded-Encrypted: i=1; AJvYcCWmxj+uhOiGXN/lL/nPuvE0sSuvdDw54FvuZI8FJ/IB3br0XOAmoNJrmuJWJSaJOgy4UMD3I9G4v43y@vger.kernel.org
X-Gm-Message-State: AOJu0YzCh7KJfl9qJloH4lZq45zW6Q3h8w/Uzq/8U2tXjtiJ627cQA6d
	mbsZSKXdUrATOdzqM/R0HcRbPnLMuuYAHxYKzUNGv7IwmlNjbZYj4VYSFnuDOHhQBtTL7aD9bUL
	hHXVetN9CaPzxic0XSd+dqLivarUQk+3duq+AkNHzGou/yR+0NvVKugc=
X-Google-Smtp-Source: AGHT+IGtN1EvaecoYCucbNRerVKSjAnKkYAfNWISqjofwx5IjcJ4Hz0FBtIE5jSwSlObTn5RpOVokcTwjgDHiPhSYJZ7yyxKMj2S
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1f09:b0:3cf:cedd:b5bd with SMTP id
 e9e14a558f8ab-3cfceddb8efmr98530065ab.1.1737964760438; Sun, 26 Jan 2025
 23:59:20 -0800 (PST)
Date: Sun, 26 Jan 2025 23:59:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67973cd8.050a0220.2eae65.0043.GAE@google.com>
Subject: [syzbot] [net?] [s390?] KASAN: slab-use-after-free Read in
 __pnet_find_base_ndev (2)
From: syzbot <syzbot+9c7519dcc554d2511da3@syzkaller.appspotmail.com>
To: agordeev@linux.ibm.com, alibuda@linux.alibaba.com, davem@davemloft.net, 
	edumazet@google.com, guwen@linux.alibaba.com, horms@kernel.org, 
	jaka@linux.ibm.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	tonylu@linux.alibaba.com, wenjia@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4395a44acb15 net: ethernet: ti: am65-cpsw: fix freeing IRQ..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=1531b1f8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aadf89e2f6db86cc
dashboard link: https://syzkaller.appspot.com/bug?extid=9c7519dcc554d2511da3
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/687378898223/disk-4395a44a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0b2b60b5197b/vmlinux-4395a44a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/743740a668ac/bzImage-4395a44a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9c7519dcc554d2511da3@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in __pnet_find_base_ndev+0x1ec/0x200 net/smc/smc_pnet.c:926
Read of size 1 at addr ffff88807be9433a by task syz.4.1247/10251

CPU: 0 UID: 0 PID: 10251 Comm: syz.4.1247 Not tainted 6.13.0-rc7-syzkaller-00116-g4395a44acb15 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:489
 kasan_report+0x143/0x180 mm/kasan/report.c:602
 __pnet_find_base_ndev+0x1ec/0x200 net/smc/smc_pnet.c:926
 pnet_find_base_ndev net/smc/smc_pnet.c:946 [inline]
 smc_pnet_find_ism_by_pnetid net/smc/smc_pnet.c:1101 [inline]
 smc_pnet_find_ism_resource+0xe9/0x510 net/smc/smc_pnet.c:1152
 smc_find_ism_device net/smc/af_smc.c:1011 [inline]
 smc_find_proposal_devices net/smc/af_smc.c:1096 [inline]
 __smc_connect+0x390/0x1850 net/smc/af_smc.c:1523
 smc_connect+0x868/0xde0 net/smc/af_smc.c:1693
 __sys_connect_file net/socket.c:2055 [inline]
 __sys_connect+0x288/0x2d0 net/socket.c:2074
 __do_sys_connect net/socket.c:2080 [inline]
 __se_sys_connect net/socket.c:2077 [inline]
 __x64_sys_connect+0x7a/0x90 net/socket.c:2077
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3902785d29
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f39034ed038 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: ffffffffffffffda RBX: 00007f3902976160 RCX: 00007f3902785d29
RDX: 0000000000000010 RSI: 0000000020000080 RDI: 0000000000000006
RBP: 00007f3902801b08 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f3902976160 R15: 00007ffeb9286148
 </TASK>

Allocated by task 5829:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4298 [inline]
 __kmalloc_node_noprof+0x290/0x4d0 mm/slub.c:4304
 __kvmalloc_node_noprof+0x72/0x190 mm/util.c:645
 alloc_netdev_mqs+0xa4/0x1080 net/core/dev.c:11228
 rtnl_create_link+0x2f9/0xc20 net/core/rtnetlink.c:3595
 rtnl_newlink_create+0x210/0xa40 net/core/rtnetlink.c:3771
 __rtnl_newlink net/core/rtnetlink.c:3897 [inline]
 rtnl_newlink+0x1c7e/0x2210 net/core/rtnetlink.c:4012
 rtnetlink_rcv_msg+0x791/0xcf0 net/core/rtnetlink.c:6922
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2542
 netlink_unicast_kernel net/netlink/af_netlink.c:1321 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1347
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1891
 sock_sendmsg_nosec net/socket.c:711 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:726
 __sys_sendto+0x363/0x4c0 net/socket.c:2197
 __do_sys_sendto net/socket.c:2204 [inline]
 __se_sys_sendto net/socket.c:2200 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2200
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 10241:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:582
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2353 [inline]
 slab_free mm/slub.c:4613 [inline]
 kfree+0x196/0x430 mm/slub.c:4761
 device_release+0x99/0x1c0
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x22f/0x480 lib/kobject.c:737
 netdev_run_todo+0xe79/0x1000 net/core/dev.c:10943
 rtnl_unlock net/core/rtnetlink.c:152 [inline]
 rtnl_net_unlock include/linux/rtnetlink.h:133 [inline]
 rtnl_dellink+0x760/0x8d0 net/core/rtnetlink.c:3526
 rtnetlink_rcv_msg+0x791/0xcf0 net/core/rtnetlink.c:6922
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2542
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

The buggy address belongs to the object at ffff88807be94000
 which belongs to the cache kmalloc-cg-4k of size 4096
The buggy address is located 826 bytes inside of
 freed 4096-byte region [ffff88807be94000, ffff88807be95000)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7be90
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801ac4f500 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000040004 00000001f5000000 0000000000000000
head: 00fff00000000040 ffff88801ac4f500 dead000000000122 0000000000000000
head: 0000000000000000 0000000000040004 00000001f5000000 0000000000000000
head: 00fff00000000003 ffffea0001efa401 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5829, tgid 5829 (syz-executor), ts 74456277146, free_ts 74426671785
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1558
 prep_new_page mm/page_alloc.c:1566 [inline]
 get_page_from_freelist+0x365c/0x37a0 mm/page_alloc.c:3476
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4753
 alloc_pages_mpol_noprof+0x3e1/0x780 mm/mempolicy.c:2269
 alloc_slab_page+0x6a/0x110 mm/slub.c:2423
 allocate_slab+0x5a/0x2b0 mm/slub.c:2589
 new_slab mm/slub.c:2642 [inline]
 ___slab_alloc+0xc27/0x14a0 mm/slub.c:3830
 __slab_alloc+0x58/0xa0 mm/slub.c:3920
 __slab_alloc_node mm/slub.c:3995 [inline]
 slab_alloc_node mm/slub.c:4156 [inline]
 __do_kmalloc_node mm/slub.c:4297 [inline]
 __kmalloc_node_track_caller_noprof+0x2e9/0x4c0 mm/slub.c:4317
 kmemdup_noprof+0x2a/0x60 mm/util.c:135
 __addrconf_sysctl_register+0xb1/0x3a0 net/ipv6/addrconf.c:7221
 addrconf_sysctl_register+0x167/0x1c0 net/ipv6/addrconf.c:7287
 ipv6_add_dev+0xcf6/0x1220 net/ipv6/addrconf.c:456
 addrconf_notify+0x6a7/0x1020 net/ipv6/addrconf.c:3674
 notifier_call_chain+0x1a5/0x3f0 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2064 [inline]
 call_netdevice_notifiers net/core/dev.c:2078 [inline]
 register_netdevice+0x167f/0x1b00 net/core/dev.c:10651
page last free pid 5837 tgid 5837 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_page+0xd3f/0x1010 mm/page_alloc.c:2659
 discard_slab mm/slub.c:2688 [inline]
 __put_partials+0x160/0x1c0 mm/slub.c:3157
 put_cpu_partial+0x17c/0x250 mm/slub.c:3232
 __slab_free+0x290/0x380 mm/slub.c:4483
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4119 [inline]
 slab_alloc_node mm/slub.c:4168 [inline]
 kmem_cache_alloc_node_noprof+0x1d9/0x380 mm/slub.c:4220
 __alloc_skb+0x1c3/0x440 net/core/skbuff.c:668
 alloc_skb include/linux/skbuff.h:1323 [inline]
 nlmsg_new include/net/netlink.h:1018 [inline]
 inet6_netconf_notify_devconf+0xfc/0x1c0 net/ipv6/addrconf.c:589
 __addrconf_sysctl_register+0x337/0x3a0 net/ipv6/addrconf.c:7250
 addrconf_sysctl_register+0x167/0x1c0 net/ipv6/addrconf.c:7287
 ipv6_add_dev+0xcf6/0x1220 net/ipv6/addrconf.c:456
 addrconf_notify+0x6a7/0x1020 net/ipv6/addrconf.c:3674
 notifier_call_chain+0x1a5/0x3f0 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2064 [inline]
 call_netdevice_notifiers net/core/dev.c:2078 [inline]
 register_netdevice+0x167f/0x1b00 net/core/dev.c:10651

Memory state around the buggy address:
 ffff88807be94200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807be94280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88807be94300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                        ^
 ffff88807be94380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807be94400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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

