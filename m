Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 354AC21ABCF
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2020 01:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbgGIXyV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Jul 2020 19:54:21 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:52112 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbgGIXyU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 9 Jul 2020 19:54:20 -0400
Received: by mail-io1-f72.google.com with SMTP id l1so2389817ioh.18
        for <linux-rdma@vger.kernel.org>; Thu, 09 Jul 2020 16:54:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=0UXNLsbq/UixZtvdf0fufo1JIMJOuzzTXXFP27ddmWk=;
        b=fYlTd4nO/KQsosAj1O5PoRME7bxHbJFxbj3xrMNwU5QSEtzNmMGlsqMLq4Ym0sHAPw
         dlOgBEBxRylYGfysTl8F8RAZcjpA3mLcKCGrFjRBcSF5M8Iw7cwCjiAMZbIr6EWI00CX
         deL4DZuGSePJDXaexMZjyQaJm6IJvGe3WkSdFNW+FjmuGY3aRn975kjpOnhEujPfW5yn
         /Iei6u1w4/00b6xYSAsaR8S/lUjbCpL/S0qFLz+sV3tsOY+3PoDgXZlkD5AJ5thTUd+K
         wBalSkYYojW7GvJdzDwI7BYC/fnae1os2d+fWYIhIzvIl0l+LZAdLita3bWFqoxz0f4p
         SWWg==
X-Gm-Message-State: AOAM530KHZ5TGF74dheFd3aT0QBbWnassS+YkbIFfEIF7MtbX+a6ARcJ
        Kl1QmfRyX0+L1PhM5Ky3IU36BVrSqWnZzLR8hD8/MgMoYT9r
X-Google-Smtp-Source: ABdhPJzV6EaJuzSrLhBvMd6VODUjttdhB9mJx7wg3UVXb2uE1IyIjBMmsdS4IYexrk7xbuwGxX/7j4VuORiRERCKqhH3bEh7fS00
MIME-Version: 1.0
X-Received: by 2002:a05:6638:11cb:: with SMTP id g11mr11525847jas.14.1594338859259;
 Thu, 09 Jul 2020 16:54:19 -0700 (PDT)
Date:   Thu, 09 Jul 2020 16:54:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005b9fca05aa0af1b9@google.com>
Subject: KASAN: use-after-free Read in netdevice_event_work_handler
From:   syzbot <syzbot+20b90969babe05609947@syzkaller.appspotmail.com>
To:     dledford@redhat.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    0bddd227 Documentation: update for gcc 4.9 requirement
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1418afb7100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=66ad203c2bb6d8b
dashboard link: https://syzkaller.appspot.com/bug?extid=20b90969babe05609947
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12a8edff100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=167d3bb7100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+20b90969babe05609947@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in dev_put include/linux/netdevice.h:3853 [inline]
BUG: KASAN: use-after-free in netdevice_event_work_handler+0x15b/0x1b0 drivers/infiniband/core/roce_gid_mgmt.c:627
Read of size 8 at addr ffff88807b13e568 by task kworker/u4:0/7

CPU: 0 PID: 7 Comm: kworker/u4:0 Not tainted 5.8.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: gid-cache-wq netdevice_event_work_handler
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0xae/0x436 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:530
 dev_put include/linux/netdevice.h:3853 [inline]
 netdevice_event_work_handler+0x15b/0x1b0 drivers/infiniband/core/roce_gid_mgmt.c:627
 process_one_work+0x94c/0x1670 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x3b5/0x4a0 kernel/kthread.c:291
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:293

Allocated by task 13061:
 save_stack+0x1b/0x40 mm/kasan/common.c:48
 set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc.constprop.0+0xc2/0xd0 mm/kasan/common.c:494
 kmalloc_node include/linux/slab.h:578 [inline]
 kvmalloc_node+0x61/0xf0 mm/util.c:574
 kvmalloc include/linux/mm.h:753 [inline]
 kvzalloc include/linux/mm.h:761 [inline]
 alloc_netdev_mqs+0x97/0xdc0 net/core/dev.c:9938
 __ip_tunnel_create+0x201/0x580 net/ipv4/ip_tunnel.c:254
 ip_tunnel_init_net+0x32b/0x980 net/ipv4/ip_tunnel.c:1072
 ops_init+0xaf/0x470 net/core/net_namespace.c:151
 setup_net+0x2d8/0x850 net/core/net_namespace.c:341
 copy_net_ns+0x2cf/0x5e0 net/core/net_namespace.c:482
 create_new_namespaces+0x3f6/0xb10 kernel/nsproxy.c:110
 unshare_nsproxy_namespaces+0xbd/0x1f0 kernel/nsproxy.c:231
 ksys_unshare+0x36c/0x9a0 kernel/fork.c:2983
 __do_sys_unshare kernel/fork.c:3051 [inline]
 __se_sys_unshare kernel/fork.c:3049 [inline]
 __x64_sys_unshare+0x2d/0x40 kernel/fork.c:3049
 do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:384
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Freed by task 13061:
 save_stack+0x1b/0x40 mm/kasan/common.c:48
 set_track mm/kasan/common.c:56 [inline]
 kasan_set_free_info mm/kasan/common.c:316 [inline]
 __kasan_slab_free+0xf5/0x140 mm/kasan/common.c:455
 __cache_free mm/slab.c:3426 [inline]
 kfree+0x103/0x2c0 mm/slab.c:3757
 kvfree+0x42/0x50 mm/util.c:603
 device_release+0x71/0x200 drivers/base/core.c:1559
 kobject_cleanup lib/kobject.c:693 [inline]
 kobject_release lib/kobject.c:722 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1c0/0x270 lib/kobject.c:739
 put_device+0x1b/0x30 drivers/base/core.c:2779
 free_netdev+0x35d/0x480 net/core/dev.c:10054
 __ip_tunnel_create+0x48f/0x580 net/ipv4/ip_tunnel.c:274
 ip_tunnel_init_net+0x32b/0x980 net/ipv4/ip_tunnel.c:1072
 ops_init+0xaf/0x470 net/core/net_namespace.c:151
 setup_net+0x2d8/0x850 net/core/net_namespace.c:341
 copy_net_ns+0x2cf/0x5e0 net/core/net_namespace.c:482
 create_new_namespaces+0x3f6/0xb10 kernel/nsproxy.c:110
 unshare_nsproxy_namespaces+0xbd/0x1f0 kernel/nsproxy.c:231
 ksys_unshare+0x36c/0x9a0 kernel/fork.c:2983
 __do_sys_unshare kernel/fork.c:3051 [inline]
 __se_sys_unshare kernel/fork.c:3049 [inline]
 __x64_sys_unshare+0x2d/0x40 kernel/fork.c:3049
 do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:384
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

The buggy address belongs to the object at ffff88807b13e000
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 1384 bytes inside of
 4096-byte region [ffff88807b13e000, ffff88807b13f000)
The buggy address belongs to the page:
page:ffffea0001ec4f80 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 head:ffffea0001ec4f80 order:1 compound_mapcount:0
flags: 0xfffe0000010200(slab|head)
raw: 00fffe0000010200 ffffea0001ecce88 ffffea0001987988 ffff8880aa002000
raw: 0000000000000000 ffff88807b13e000 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88807b13e400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807b13e480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88807b13e500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                          ^
 ffff88807b13e580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807b13e600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
