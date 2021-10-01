Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7987241ECED
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Oct 2021 14:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354242AbhJAMKH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 1 Oct 2021 08:10:07 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:46701 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354151AbhJAMKG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 1 Oct 2021 08:10:06 -0400
Received: by mail-il1-f200.google.com with SMTP id j10-20020a056e02154a00b002589ce2af7dso7254743ilu.13
        for <linux-rdma@vger.kernel.org>; Fri, 01 Oct 2021 05:08:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=BmTI3ElpkZdx5lGw2N4XR7ZckKKkNC5vFZJ3yCXtc8A=;
        b=rJ+HOEzgriagGvcnrNJhP3aiOwMocxKGe69u/l70nDw3igLO6IX9D1yYal57XXktOS
         41QiZFflpplYAFakMtTEOEfSpngaOzqADtN9bgZA86/VEJWpfUPIxWVsPahvxdG4vVEH
         I7jz4QngdiT08OQdhS+Y59F0PPuaVLjJf4ovjI8W7uuHvmPHI2WUleS6x+3Hw1W6vkzY
         UdnJosw6zFG6K6LAnWKJ2EzzoGiyL0kTzcOTekm65eWnzUpZJxeX89XgXoPfWn5e3ajK
         3aQZt2j2URdrmWvff+3M3ioTup1NhVBCWzSZqz22sfmN6R/QhnFmPxxTLmpQGwRbGWjR
         AY5Q==
X-Gm-Message-State: AOAM533rtKLWbf90P6erlwa+OS8NmZBbie2tYLuKODpKsUw/ER97DZXm
        GkhomDaY0OfJXM79aBIM5T9mhPptyqz6oX6ZrpiE2qbZEdWB
X-Google-Smtp-Source: ABdhPJzSmTHvx9WMGX+4RLfTsd9gUQmPzvoVppjO+tc3P27PgZXpcm9fefbxkWYRpCP7F7iT48AYhCRUT6Gf/Ld3Ao9b9WIhVVaY
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1402:: with SMTP id n2mr3445479ilo.208.1633090102561;
 Fri, 01 Oct 2021 05:08:22 -0700 (PDT)
Date:   Fri, 01 Oct 2021 05:08:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000073132c05cd496b83@google.com>
Subject: [syzbot] KASAN: use-after-free Read in addr_handler (5)
From:   syzbot <syzbot+ae4de2b6e34e89637fc2@syzkaller.appspotmail.com>
To:     avihaih@nvidia.com, dledford@redhat.com, haakon.bugge@oracle.com,
        jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    5816b3e6577e Linux 5.15-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13519b5f300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9290a409049988d4
dashboard link: https://syzkaller.appspot.com/bug?extid=ae4de2b6e34e89637fc2
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ae4de2b6e34e89637fc2@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in __mutex_lock_common kernel/locking/mutex.c:575 [inline]
BUG: KASAN: use-after-free in __mutex_lock+0x105b/0x12f0 kernel/locking/mutex.c:729
Read of size 8 at addr ffff88803045c3b0 by task kworker/u4:3/158

CPU: 0 PID: 158 Comm: kworker/u4:3 Not tainted 5.15.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: ib_addr process_one_req
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description.constprop.0.cold+0x6c/0x309 mm/kasan/report.c:256
 __kasan_report mm/kasan/report.c:442 [inline]
 kasan_report.cold+0x83/0xdf mm/kasan/report.c:459
 __mutex_lock_common kernel/locking/mutex.c:575 [inline]
 __mutex_lock+0x105b/0x12f0 kernel/locking/mutex.c:729
 addr_handler+0xac/0x470 drivers/infiniband/core/cma.c:3247
 process_one_req+0xfa/0x680 drivers/infiniband/core/addr.c:647
 process_one_work+0x9bf/0x16b0 kernel/workqueue.c:2297
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2444
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

Allocated by task 2219:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:46 [inline]
 set_alloc_info mm/kasan/common.c:434 [inline]
 ____kasan_kmalloc mm/kasan/common.c:513 [inline]
 ____kasan_kmalloc mm/kasan/common.c:472 [inline]
 __kasan_kmalloc+0xa4/0xd0 mm/kasan/common.c:522
 kmalloc include/linux/slab.h:591 [inline]
 kzalloc include/linux/slab.h:721 [inline]
 __rdma_create_id+0x5b/0x550 drivers/infiniband/core/cma.c:839
 rdma_create_user_id+0x79/0xd0 drivers/infiniband/core/cma.c:893
 ucma_create_id+0x162/0x360 drivers/infiniband/core/ucma.c:461
 ucma_write+0x25c/0x350 drivers/infiniband/core/ucma.c:1732
 vfs_write+0x28e/0xae0 fs/read_write.c:592
 ksys_write+0x1ee/0x250 fs/read_write.c:647
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Freed by task 2215:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track+0x1c/0x30 mm/kasan/common.c:46
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:360
 ____kasan_slab_free mm/kasan/common.c:366 [inline]
 ____kasan_slab_free mm/kasan/common.c:328 [inline]
 __kasan_slab_free+0xff/0x130 mm/kasan/common.c:374
 kasan_slab_free include/linux/kasan.h:230 [inline]
 slab_free_hook mm/slub.c:1700 [inline]
 slab_free_freelist_hook+0x81/0x190 mm/slub.c:1725
 slab_free mm/slub.c:3483 [inline]
 kfree+0xe4/0x530 mm/slub.c:4543
 ucma_close_id drivers/infiniband/core/ucma.c:185 [inline]
 ucma_destroy_private_ctx+0x8b3/0xb70 drivers/infiniband/core/ucma.c:576
 ucma_close+0x10a/0x180 drivers/infiniband/core/ucma.c:1797
 __fput+0x288/0x9f0 fs/file_table.c:280
 task_work_run+0xdd/0x1a0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:175 [inline]
 exit_to_user_mode_prepare+0x27e/0x290 kernel/entry/common.c:207
 __syscall_exit_to_user_mode_work kernel/entry/common.c:289 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:300
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Last potentially related work creation:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_record_aux_stack+0xe9/0x110 mm/kasan/generic.c:348
 kvfree_call_rcu+0x74/0x990 kernel/rcu/tree.c:3552
 drop_sysctl_table+0x3c0/0x4e0 fs/proc/proc_sysctl.c:1647
 unregister_sysctl_table fs/proc/proc_sysctl.c:1685 [inline]
 unregister_sysctl_table+0xc2/0x190 fs/proc/proc_sysctl.c:1660
 __addrconf_sysctl_unregister net/ipv6/addrconf.c:7045 [inline]
 addrconf_exit_net+0x9f/0x2a0 net/ipv6/addrconf.c:7153
 ops_exit_list+0xb0/0x160 net/core/net_namespace.c:168
 cleanup_net+0x4ea/0xb00 net/core/net_namespace.c:591
 process_one_work+0x9bf/0x16b0 kernel/workqueue.c:2297
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2444
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

Second to last potentially related work creation:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_record_aux_stack+0xe9/0x110 mm/kasan/generic.c:348
 __call_rcu kernel/rcu/tree.c:2987 [inline]
 call_rcu+0xb1/0x750 kernel/rcu/tree.c:3067
 netlink_release+0xdd4/0x1dd0 net/netlink/af_netlink.c:812
 __sock_release+0xcd/0x280 net/socket.c:649
 sock_close+0x18/0x20 net/socket.c:1314
 __fput+0x288/0x9f0 fs/file_table.c:280
 task_work_run+0xdd/0x1a0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:175 [inline]
 exit_to_user_mode_prepare+0x27e/0x290 kernel/entry/common.c:207
 __syscall_exit_to_user_mode_work kernel/entry/common.c:289 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:300
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x44/0xae

The buggy address belongs to the object at ffff88803045c000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 944 bytes inside of
 2048-byte region [ffff88803045c000, ffff88803045c800)
The buggy address belongs to the page:
page:ffffea0000c11600 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x30458
head:ffffea0000c11600 order:3 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 dead000000000100 dead000000000122 ffff888010c42000
raw: 0000000000000000 0000000080080008 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 23309, ts 828421614337, free_ts 828403938080
 prep_new_page mm/page_alloc.c:2424 [inline]
 get_page_from_freelist+0xa72/0x2f80 mm/page_alloc.c:4153
 __alloc_pages+0x1b2/0x500 mm/page_alloc.c:5375
 alloc_pages+0x1a7/0x300 mm/mempolicy.c:2197
 alloc_slab_page mm/slub.c:1763 [inline]
 allocate_slab mm/slub.c:1900 [inline]
 new_slab+0x319/0x490 mm/slub.c:1963
 ___slab_alloc+0x921/0xfe0 mm/slub.c:2994
 __slab_alloc.constprop.0+0x4d/0xa0 mm/slub.c:3081
 slab_alloc_node mm/slub.c:3172 [inline]
 slab_alloc mm/slub.c:3214 [inline]
 __kmalloc_track_caller+0x2f1/0x310 mm/slub.c:4905
 kmemdup+0x23/0x50 mm/util.c:128
 kmemdup include/linux/fortify-string.h:270 [inline]
 neigh_sysctl_register+0x9a/0x680 net/core/neighbour.c:3637
 addrconf_sysctl_register+0xb6/0x1d0 net/ipv6/addrconf.c:7059
 ipv6_add_dev+0x96e/0x1170 net/ipv6/addrconf.c:453
 addrconf_notify+0x60e/0x1bb0 net/ipv6/addrconf.c:3505
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:1996
 call_netdevice_notifiers_extack net/core/dev.c:2008 [inline]
 call_netdevice_notifiers net/core/dev.c:2022 [inline]
 register_netdevice+0x1075/0x1500 net/core/dev.c:10330
 veth_newlink+0x58c/0xb20 drivers/net/veth.c:1726
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1338 [inline]
 free_pcp_prepare+0x2c5/0x780 mm/page_alloc.c:1389
 free_unref_page_prepare mm/page_alloc.c:3315 [inline]
 free_unref_page+0x19/0x690 mm/page_alloc.c:3394
 __unfreeze_partials+0x340/0x360 mm/slub.c:2495
 qlink_free mm/kasan/quarantine.c:146 [inline]
 qlist_free_all+0x5a/0xc0 mm/kasan/quarantine.c:165
 kasan_quarantine_reduce+0x180/0x200 mm/kasan/quarantine.c:272
 __kasan_slab_alloc+0x95/0xb0 mm/kasan/common.c:444
 kasan_slab_alloc include/linux/kasan.h:254 [inline]
 slab_post_alloc_hook mm/slab.h:519 [inline]
 slab_alloc_node mm/slub.c:3206 [inline]
 slab_alloc mm/slub.c:3214 [inline]
 kmem_cache_alloc_trace+0x1f1/0x2b0 mm/slub.c:3231
 kmalloc include/linux/slab.h:591 [inline]
 netdevice_queue_work drivers/infiniband/core/roce_gid_mgmt.c:643 [inline]
 netdevice_event+0x1a8/0x8a0 drivers/infiniband/core/roce_gid_mgmt.c:802
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:1996
 call_netdevice_notifiers_extack net/core/dev.c:2008 [inline]
 call_netdevice_notifiers net/core/dev.c:2022 [inline]
 unregister_netdevice_many+0x951/0x1790 net/core/dev.c:11043
 ieee80211_remove_interfaces+0x394/0x820 net/mac80211/iface.c:2140
 ieee80211_unregister_hw+0x47/0x1f0 net/mac80211/main.c:1391
 mac80211_hwsim_del_radio drivers/net/wireless/mac80211_hwsim.c:3457 [inline]
 hwsim_exit_net+0x50e/0xca0 drivers/net/wireless/mac80211_hwsim.c:4217
 ops_exit_list+0xb0/0x160 net/core/net_namespace.c:168
 cleanup_net+0x4ea/0xb00 net/core/net_namespace.c:591

Memory state around the buggy address:
 ffff88803045c280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88803045c300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88803045c380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                     ^
 ffff88803045c400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88803045c480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
