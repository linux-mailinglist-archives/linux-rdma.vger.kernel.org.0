Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED7502BAE53
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Nov 2020 16:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729321AbgKTPPX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Nov 2020 10:15:23 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:40061 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729308AbgKTPPW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Nov 2020 10:15:22 -0500
Received: by mail-io1-f71.google.com with SMTP id c2so7651725ioq.7
        for <linux-rdma@vger.kernel.org>; Fri, 20 Nov 2020 07:15:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=7/dZixkNqi1prU3kfXpv45sZpmPqgqtvqYjBW2WoVDg=;
        b=UcI33MekTve7fNeyuOZavpsb2a1L7Pp24Nmwcj+UA5whIbjDbPwJKEveizoJnDQ2fJ
         Po7MHK2Qkny3Q6hK8UMjDhzoxYsztZqxrphnOJsDOm1in/8kGdW3GvUg8fM8sK9Yovi1
         AKmrJrrfShXHaVZcvD44iSSxcdYXJ6YCXdhheO7Y8f/Kzi3zF3udC55zlwngWrT7pFCp
         hGvNRdE2l1qSJNYxXuoN4z62l9ncfJAiiU4ZKbUyZg36qAHCZz6/o9GVBC1bCZ4gxy3v
         BQhiN6cXzFb5JAuZ0xwiQ3hCfpVJOdDgv/VSn+Qfj9hYmsx3yVQlVyTw3dUk4cKe71jn
         tD5A==
X-Gm-Message-State: AOAM5332m2aRVf3JY25YhZmhC+S8Z1tGJ3wc1BaQ4w6nAmjejs089keR
        N4/CnBY0ZS2UIf41R1DMgcVzm14JGI9OHu+uIq0nNXE+iTYp
X-Google-Smtp-Source: ABdhPJzUdwa9R8K5m6+nA5eA0geHc7RTDH2nfamLiggDkWInvMpPxVCaN4GK+Ojac3N8y48FuVJU27bq74oAN5cEmSD3lvet8S9d
MIME-Version: 1.0
X-Received: by 2002:a02:a985:: with SMTP id q5mr18031319jam.56.1605885321694;
 Fri, 20 Nov 2020 07:15:21 -0800 (PST)
Date:   Fri, 20 Nov 2020 07:15:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002653f805b48b50f5@google.com>
Subject: possible deadlock in rdma_destroy_id
From:   syzbot <syzbot+76c931ae5fdee51fff5b@syzkaller.appspotmail.com>
To:     dledford@redhat.com, jgg@ziepe.ca, leon@kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        parav@mellanox.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    20529233 Add linux-next specific files for 20201118
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=124ae36e500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2c4fb58b6526b3c1
dashboard link: https://syzkaller.appspot.com/bug?extid=76c931ae5fdee51fff5b
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+76c931ae5fdee51fff5b@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.10.0-rc4-next-20201118-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor.0/14971 is trying to acquire lock:
ffff88801923e3b8 (&id_priv->handler_mutex){+.+.}-{3:3}, at: rdma_destroy_id+0x17/0x20 drivers/infiniband/core/cma.c:1904

but task is already holding lock:
ffffffff8c684748 (lock#6){+.+.}-{3:3}, at: cma_add_one+0x55c/0xce0 drivers/infiniband/core/cma.c:4902

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (lock#6){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:956 [inline]
       __mutex_lock+0x134/0x1110 kernel/locking/mutex.c:1103
       cma_acquire_dev_by_src_ip+0x1af/0x960 drivers/infiniband/core/cma.c:625
       addr_handler+0x3d9/0x480 drivers/infiniband/core/cma.c:3160
       process_one_req+0xfa/0x680 drivers/infiniband/core/addr.c:645
       process_one_work+0x933/0x15a0 kernel/workqueue.c:2272
       worker_thread+0x64c/0x1120 kernel/workqueue.c:2418
       kthread+0x3af/0x4a0 kernel/kthread.c:292
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296

-> #0 (&id_priv->handler_mutex){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:2866 [inline]
       check_prevs_add kernel/locking/lockdep.c:2991 [inline]
       validate_chain kernel/locking/lockdep.c:3606 [inline]
       __lock_acquire+0x2ca6/0x5c00 kernel/locking/lockdep.c:4830
       lock_acquire kernel/locking/lockdep.c:5435 [inline]
       lock_acquire+0x2a3/0x8c0 kernel/locking/lockdep.c:5400
       __mutex_lock_common kernel/locking/mutex.c:956 [inline]
       __mutex_lock+0x134/0x1110 kernel/locking/mutex.c:1103
       rdma_destroy_id+0x17/0x20 drivers/infiniband/core/cma.c:1904
       cma_listen_on_dev.cold+0x168/0x16d drivers/infiniband/core/cma.c:2535
       cma_add_one+0x667/0xce0 drivers/infiniband/core/cma.c:4905
       add_client_context+0x405/0x5e0 drivers/infiniband/core/device.c:712
       enable_device_and_get+0x1d5/0x3c0 drivers/infiniband/core/device.c:1333
       ib_register_device drivers/infiniband/core/device.c:1408 [inline]
       ib_register_device+0x7a0/0xa30 drivers/infiniband/core/device.c:1367
       siw_device_register drivers/infiniband/sw/siw/siw_main.c:72 [inline]
       siw_newlink drivers/infiniband/sw/siw/siw_main.c:545 [inline]
       siw_newlink+0xddb/0x1340 drivers/infiniband/sw/siw/siw_main.c:522
       nldev_newlink+0x30e/0x540 drivers/infiniband/core/nldev.c:1555
       rdma_nl_rcv_msg+0x367/0x690 drivers/infiniband/core/netlink.c:195
       rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
       rdma_nl_rcv+0x2f2/0x440 drivers/infiniband/core/netlink.c:259
       netlink_unicast_kernel net/netlink/af_netlink.c:1304 [inline]
       netlink_unicast+0x533/0x7d0 net/netlink/af_netlink.c:1330
       netlink_sendmsg+0x856/0xd90 net/netlink/af_netlink.c:1919
       sock_sendmsg_nosec net/socket.c:650 [inline]
       sock_sendmsg+0xcf/0x120 net/socket.c:670
       ____sys_sendmsg+0x6e8/0x810 net/socket.c:2339
       ___sys_sendmsg+0xf3/0x170 net/socket.c:2393
       __sys_sendmsg+0xe5/0x1b0 net/socket.c:2426
       do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(lock#6);
                               lock(&id_priv->handler_mutex);
                               lock(lock#6);
  lock(&id_priv->handler_mutex);

 *** DEADLOCK ***

6 locks held by syz-executor.0/14971:
 #0: ffffffff8fa76958 (&rdma_nl_types[idx].sem){.+.+}-{3:3}, at: rdma_nl_rcv_msg+0x15b/0x690 drivers/infiniband/core/netlink.c:164
 #1: ffffffff8c66c490 (link_ops_rwsem){++++}-{3:3}, at: nldev_newlink+0x261/0x540 drivers/infiniband/core/nldev.c:1545
 #2: ffffffff8c65bd90 (devices_rwsem){++++}-{3:3}, at: enable_device_and_get+0xfc/0x3c0 drivers/infiniband/core/device.c:1321
 #3: ffffffff8c65bc50 (clients_rwsem){++++}-{3:3}, at: enable_device_and_get+0x163/0x3c0 drivers/infiniband/core/device.c:1331
 #4: ffff88806dbc8598 (&device->client_data_rwsem){++++}-{3:3}, at: add_client_context+0x3d0/0x5e0 drivers/infiniband/core/device.c:710
 #5: ffffffff8c684748 (lock#6){+.+.}-{3:3}, at: cma_add_one+0x55c/0xce0 drivers/infiniband/core/cma.c:4902

stack backtrace:
CPU: 1 PID: 14971 Comm: syz-executor.0 Not tainted 5.10.0-rc4-next-20201118-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:120
 check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2115
 check_prev_add kernel/locking/lockdep.c:2866 [inline]
 check_prevs_add kernel/locking/lockdep.c:2991 [inline]
 validate_chain kernel/locking/lockdep.c:3606 [inline]
 __lock_acquire+0x2ca6/0x5c00 kernel/locking/lockdep.c:4830
 lock_acquire kernel/locking/lockdep.c:5435 [inline]
 lock_acquire+0x2a3/0x8c0 kernel/locking/lockdep.c:5400
 __mutex_lock_common kernel/locking/mutex.c:956 [inline]
 __mutex_lock+0x134/0x1110 kernel/locking/mutex.c:1103
 rdma_destroy_id+0x17/0x20 drivers/infiniband/core/cma.c:1904
 cma_listen_on_dev.cold+0x168/0x16d drivers/infiniband/core/cma.c:2535
 cma_add_one+0x667/0xce0 drivers/infiniband/core/cma.c:4905
 add_client_context+0x405/0x5e0 drivers/infiniband/core/device.c:712
 enable_device_and_get+0x1d5/0x3c0 drivers/infiniband/core/device.c:1333
 ib_register_device drivers/infiniband/core/device.c:1408 [inline]
 ib_register_device+0x7a0/0xa30 drivers/infiniband/core/device.c:1367
 siw_device_register drivers/infiniband/sw/siw/siw_main.c:72 [inline]
 siw_newlink drivers/infiniband/sw/siw/siw_main.c:545 [inline]
 siw_newlink+0xddb/0x1340 drivers/infiniband/sw/siw/siw_main.c:522
 nldev_newlink+0x30e/0x540 drivers/infiniband/core/nldev.c:1555
 rdma_nl_rcv_msg+0x367/0x690 drivers/infiniband/core/netlink.c:195
 rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
 rdma_nl_rcv+0x2f2/0x440 drivers/infiniband/core/netlink.c:259
 netlink_unicast_kernel net/netlink/af_netlink.c:1304 [inline]
 netlink_unicast+0x533/0x7d0 net/netlink/af_netlink.c:1330
 netlink_sendmsg+0x856/0xd90 net/netlink/af_netlink.c:1919
 sock_sendmsg_nosec net/socket.c:650 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:670
 ____sys_sendmsg+0x6e8/0x810 net/socket.c:2339
 ___sys_sendmsg+0xf3/0x170 net/socket.c:2393
 __sys_sendmsg+0xe5/0x1b0 net/socket.c:2426
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45deb9
Code: 0d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 db b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f6cfdcbac78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 000000000002d040 RCX: 000000000045deb9
RDX: 0000000000000000 RSI: 0000000020000200 RDI: 0000000000000004
RBP: 000000000118bf60 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000118bf2c
R13: 00007fff0f7c1c9f R14: 00007f6cfdcbb9c0 R15: 000000000118bf2c


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
