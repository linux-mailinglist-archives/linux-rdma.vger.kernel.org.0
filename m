Return-Path: <linux-rdma+bounces-5137-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C147F988A13
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Sep 2024 20:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2F8DB2124E
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Sep 2024 18:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A691C1AC7;
	Fri, 27 Sep 2024 18:26:30 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB79136E37
	for <linux-rdma@vger.kernel.org>; Fri, 27 Sep 2024 18:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727461590; cv=none; b=dozq3W0AeqFy4b5PtbjiJRrgcAfFhuBgacaLJusRnT+AMrcZ0/jZffF6cL5jqRZyVTMOJdN4KcfrlaJ6mkuG8Obqk1/QGEIHOES6ebQ+bO1rdleUEllreKutC0vGCctK7oPojZ5AsUQ9PALaVkKrYf4YF33c9V44mvPxZ+PIt/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727461590; c=relaxed/simple;
	bh=e5hQak0chZwvl7v7RwAx6op/faaKi4je81NKY6u5Hvs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YfsKJASpUwn2DmmgosvF+68bL050H5eM+9Gl4Idx3CK6Rs5ymFvjl8W8Ssq0u7NUJ8Sa+I5Sv9sQ514w8JjhxHDv+yI/gbJ/AiUva15zMrKa5S2WIRC2ckuUJABND5dkN818BXGBTPSfIB6tG4/OBrFo7bU/zSVhynORh6futZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a342620d49so19187285ab.3
        for <linux-rdma@vger.kernel.org>; Fri, 27 Sep 2024 11:26:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727461587; x=1728066387;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/WOm9hat/ybPpbjB2jJkY1uRAxZ82q+VbX+LaSZoKxM=;
        b=emwdDZsvXbEwMSBwQDGc868npAaeMovq2f5lgUu3XfqrJ+wst3sn2NH0awCoo1Plxd
         XqG31fJa6N4VjUZdy6GoUi/7qHRZycoN+/B+PP+SkMgCZf582duTuDEHKxeoOFuqgk+4
         FM3P0AAcW/rOUYnrNqpSqtCpsOxbxAGk02S0e+d0ddN7i7LuYjiXOnFNTJnNxy/bSX4Q
         9CAdJPyRntqgffntXNBg8W5AG9f9JKWHfCF2pA6CReVT2NbtfF8wqU+YpJTFDsWdUMda
         wNlL4S7ubOBdcnO2E4H4kQGx1u2ax7c1cF/sVZvwjaXedqhY7QoUE/AkgkZpjsRcpK9H
         MEUg==
X-Forwarded-Encrypted: i=1; AJvYcCVn5D/ZCp0YSXpI0U7hkD71vdhk9AizME23feqzkHwGSEOE88KCmMUP8KCu40yjAEfLhqLUTdx+Oy5E@vger.kernel.org
X-Gm-Message-State: AOJu0YzIefDzFOJgxOf/fL8e61+4J6IxP0VPNqiCET/8cjt8i8bc3O60
	PWV4aWN1RFUhSGzCWgBG5C+CvjbJfNdecSEn4fu1CvmY8qLdGumOK9fpgH1b9trufwrBHGKmU1G
	qJgd5BxyvGt6SyM47mvARXLB94VR5pYEa1pPFfXg887m127IRaDzJk74=
X-Google-Smtp-Source: AGHT+IGUEtKqG6MsRCREZAJlpbrzHNUtHJMpcG2iqyaDAenG3wLPcyUSSEj/ctp07O8llgi3Xm5znffae62yTUQObPrw3HO/q4El
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a0c:b0:3a0:a385:911d with SMTP id
 e9e14a558f8ab-3a344fcc3e1mr43356875ab.0.1727461587643; Fri, 27 Sep 2024
 11:26:27 -0700 (PDT)
Date: Fri, 27 Sep 2024 11:26:27 -0700
In-Reply-To: <000000000000657ecd0614456af8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f6f8d3.050a0220.38ace9.002e.GAE@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in __ethtool_get_link_ksettings
From: syzbot <syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com>
To: davem@davemloft.net, dkirjanov@suse.de, edumazet@google.com, jgg@ziepe.ca, 
	kirjanov@gmail.com, kuba@kernel.org, leon@kernel.org, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, naveenm@marvell.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, rkannoth@marvell.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    d505d3593b52 net: wwan: qcom_bam_dmux: Fix missing pm_runt..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=105286a9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b2d4fdf18a83ec0b
dashboard link: https://syzkaller.appspot.com/bug?extid=5fe14f2ff4ccbace9a26
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=150d959f980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0286a1cf90df/disk-d505d359.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b573fa96ab33/vmlinux-d505d359.xz
kernel image: https://storage.googleapis.com/syzbot-assets/cdd9993102ed/bzImage-d505d359.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in __ethtool_get_link_ksettings+0x6e/0x190 net/ethtool/ioctl.c:442
Read of size 8 at addr ffff88806ea3a308 by task kworker/1:1/60

CPU: 1 UID: 0 PID: 60 Comm: kworker/1:1 Not tainted 6.11.0-syzkaller-11503-gd505d3593b52 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: events smc_ib_port_event_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 __ethtool_get_link_ksettings+0x6e/0x190 net/ethtool/ioctl.c:442
 ib_get_eth_speed+0x160/0x800 drivers/infiniband/core/verbs.c:1996
 rxe_query_port+0x76/0x260 drivers/infiniband/sw/rxe/rxe_verbs.c:55
 __ib_query_port drivers/infiniband/core/device.c:2111 [inline]
 ib_query_port+0x166/0x7d0 drivers/infiniband/core/device.c:2143
 smc_ib_remember_port_attr net/smc/smc_ib.c:364 [inline]
 smc_ib_port_event_work+0x14e/0xa50 net/smc/smc_ib.c:388
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 5335:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:257 [inline]
 __do_kmalloc_node mm/slub.c:4265 [inline]
 __kmalloc_node_noprof+0x22a/0x440 mm/slub.c:4271
 __kvmalloc_node_noprof+0x72/0x190 mm/util.c:658
 alloc_netdev_mqs+0x9b/0x1000 net/core/dev.c:11093
 rtnl_create_link+0x2f9/0xc20 net/core/rtnetlink.c:3374
 rtnl_newlink_create net/core/rtnetlink.c:3500 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3730 [inline]
 rtnl_newlink+0x1423/0x20a0 net/core/rtnetlink.c:3743
 rtnetlink_rcv_msg+0x73f/0xcf0 net/core/rtnetlink.c:6646
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2550
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 __sys_sendto+0x39b/0x4f0 net/socket.c:2210
 __do_sys_sendto net/socket.c:2222 [inline]
 __se_sys_sendto net/socket.c:2218 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2218
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 1583:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:230 [inline]
 slab_free_hook mm/slub.c:2343 [inline]
 slab_free mm/slub.c:4580 [inline]
 kfree+0x1a0/0x440 mm/slub.c:4728
 device_release+0x99/0x1c0
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x22f/0x480 lib/kobject.c:737
 netdev_run_todo+0xe79/0x1000 net/core/dev.c:10812
 default_device_exit_batch+0xa24/0xaa0 net/core/dev.c:11945
 ops_exit_list net/core/net_namespace.c:178 [inline]
 cleanup_net+0x89d/0xcc0 net/core/net_namespace.c:626
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

The buggy address belongs to the object at ffff88806ea3a000
 which belongs to the cache kmalloc-cg-4k of size 4096
The buggy address is located 776 bytes inside of
 freed 4096-byte region [ffff88806ea3a000, ffff88806ea3b000)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x6ea38
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff88802c1c9001
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801ac4f500 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000040004 00000001f5000000 ffff88802c1c9001
head: 00fff00000000040 ffff88801ac4f500 dead000000000122 0000000000000000
head: 0000000000000000 0000000000040004 00000001f5000000 ffff88802c1c9001
head: 00fff00000000003 ffffea0001ba8e01 ffffffffffffffff 0000000000000000
head: 0000000700000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5335, tgid 5335 (syz-executor), ts 184149259579, free_ts 182141357499
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1545 [inline]
 get_page_from_freelist+0x3045/0x3190 mm/page_alloc.c:3457
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4733
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 alloc_slab_page+0x6a/0x120 mm/slub.c:2413
 allocate_slab+0x5a/0x2f0 mm/slub.c:2579
 new_slab mm/slub.c:2632 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3819
 __slab_alloc+0x58/0xa0 mm/slub.c:3909
 __slab_alloc_node mm/slub.c:3962 [inline]
 slab_alloc_node mm/slub.c:4123 [inline]
 __do_kmalloc_node mm/slub.c:4264 [inline]
 __kmalloc_noprof+0x25a/0x400 mm/slub.c:4277
 kmalloc_noprof include/linux/slab.h:882 [inline]
 kzalloc_noprof include/linux/slab.h:1014 [inline]
 __register_sysctl_table+0x65/0x1550 fs/proc/proc_sysctl.c:1368
 __addrconf_sysctl_register+0x234/0x3a0 net/ipv6/addrconf.c:7224
 addrconf_sysctl_register+0x167/0x1c0 net/ipv6/addrconf.c:7272
 ipv6_add_dev+0xcf6/0x1220 net/ipv6/addrconf.c:456
 addrconf_notify+0x6a7/0x1020 net/ipv6/addrconf.c:3655
 notifier_call_chain+0x19f/0x3e0 kernel/notifier.c:93
 call_netdevice_notifiers_extack net/core/dev.c:2034 [inline]
 call_netdevice_notifiers net/core/dev.c:2048 [inline]
 register_netdevice+0x167f/0x1b00 net/core/dev.c:10520
page last free pid 5308 tgid 5308 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_page+0xcfb/0xf20 mm/page_alloc.c:2638
 vfree+0x186/0x2e0 mm/vmalloc.c:3361
 kcov_put kernel/kcov.c:439 [inline]
 kcov_close+0x28/0x50 kernel/kcov.c:535
 __fput+0x23f/0x880 fs/file_table.c:431
 task_work_run+0x24f/0x310 kernel/task_work.c:228
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0xa2f/0x28e0 kernel/exit.c:939
 do_group_exit+0x207/0x2c0 kernel/exit.c:1088
 get_signal+0x176f/0x1810 kernel/signal.c:2936
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xc9/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88806ea3a200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88806ea3a280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88806ea3a300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                      ^
 ffff88806ea3a380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88806ea3a400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

