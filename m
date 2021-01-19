Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B55732FC37E
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Jan 2021 23:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbhASRoX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Jan 2021 12:44:23 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:46686 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391161AbhASRkB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Jan 2021 12:40:01 -0500
Received: by mail-io1-f71.google.com with SMTP id m14so7146734ioc.13
        for <linux-rdma@vger.kernel.org>; Tue, 19 Jan 2021 09:39:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=y8kaXTac/zHnZjOPvN43x8xNUdLTe7kCmAq1Z4neSjk=;
        b=ESr75tS01h9gHFocD0Z5aUMeOhLGHTLHOkuEROF1HM5DJN52Zcio1xPoiVuE9F6/Uw
         XjP/UTQYVrpkVWk5lshsm14RXsj/gzGBFo975bq3/ME1aXOZd9DAXS5Ixw5f18VG5qDr
         hMH6s3r4q7SzoKpiXk0B7CJUKsLKAZfivjXOGt/2feAlEoCFJZOedZyW9WglW5C4Q6Tw
         7bEyJUVa3kdekkIqkzOEEVH5OzVqf1PfEQhWBrGZBBVcFbeJ2jCe4ULbhHYDDkd9Z8t8
         DtxZySCn1BgO1KpwBOG2ff10oNgdgWSG4tUBG7xY/+Lws5sMxFtBK5QM1TCVQJysB6En
         roqw==
X-Gm-Message-State: AOAM530UTbbyXabo6wGYvamCGaJNs74qTGYTVSwX6/OdUlnqtTcDbQ1L
        Bo+LyMuJrbVTpDpuICL2hyk/nFoIjWsCDP3zcPoGjVStutMb
X-Google-Smtp-Source: ABdhPJyr7ylh9Z/6TwryrQSWL58V8638Sa5T4OoVVNyFbmwhph8jW+4h2EPUhXJyK0ekSnsil2xboF6PlPDu4L9QpYChiS6PYWdB
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:c6:: with SMTP id r6mr4246452ilq.95.1611077959908;
 Tue, 19 Jan 2021 09:39:19 -0800 (PST)
Date:   Tue, 19 Jan 2021 09:39:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000081830a05b9445165@google.com>
Subject: BUG: sleeping function called from invalid context in rxe_alloc_nl
From:   syzbot <syzbot+ec2fd72374785d0e558e@syzkaller.appspotmail.com>
To:     dledford@redhat.com, jgg@nvidia.com, jgg@ziepe.ca,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        rpearson@hpe.com, rpearsonhpe@gmail.com,
        syzkaller-bugs@googlegroups.com, zyjzyj2000@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    b4bb878f Add linux-next specific files for 20210119
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12d34e9f500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7b1ca623d7cc5ca3
dashboard link: https://syzkaller.appspot.com/bug?extid=ec2fd72374785d0e558e
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=148035af500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10eb8494d00000

The issue was bisected to:

commit 3853c35e243d56238159e8365b6aca410bdd4576
Author: Bob Pearson <rpearsonhpe@gmail.com>
Date:   Wed Dec 16 23:15:49 2020 +0000

    RDMA/rxe: Add unlocked versions of pool APIs

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=126612d0d00000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=116612d0d00000
console output: https://syzkaller.appspot.com/x/log.txt?x=166612d0d00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ec2fd72374785d0e558e@syzkaller.appspotmail.com
Fixes: 3853c35e243d ("RDMA/rxe: Add unlocked versions of pool APIs")

netdevsim netdevsim0 netdevsim1: set [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim0 netdevsim2: set [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim0 netdevsim3: set [1, 0] type 2 family 0 port 6081 - 0
infiniband syz2: set active
infiniband syz2: added bond_slave_0
BUG: sleeping function called from invalid context at drivers/infiniband/sw/rxe/rxe_pool.c:346
in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 8459, name: syz-executor401
6 locks held by syz-executor401/8459:
 #0: ffffffff8fc4a418 (&rdma_nl_types[idx].sem){.+.+}-{3:3}, at: rdma_nl_rcv_msg+0x161/0x690 drivers/infiniband/core/netlink.c:164
 #1: ffffffff8c78ced0 (link_ops_rwsem){++++}-{3:3}, at: nldev_newlink+0x261/0x540 drivers/infiniband/core/nldev.c:1545
 #2: ffffffff8c77c470 (devices_rwsem){++++}-{3:3}, at: enable_device_and_get+0xfc/0x3b0 drivers/infiniband/core/device.c:1307
 #3: ffffffff8c77c330 (clients_rwsem){++++}-{3:3}, at: enable_device_and_get+0x15b/0x3b0 drivers/infiniband/core/device.c:1315
 #4: ffff88802adc8598 (&device->client_data_rwsem){++++}-{3:3}, at: add_client_context+0x3d0/0x5e0 drivers/infiniband/core/device.c:715
 #5: ffff88802adc9640 (&pool->pool_lock){....}-{2:2}, at: rxe_alloc+0x1b/0x40 drivers/infiniband/sw/rxe/rxe_pool.c:384
irq event stamp: 138912
hardirqs last  enabled at (138911): [<ffffffff88fe5c72>] __raw_read_unlock_irqrestore include/linux/rwlock_api_smp.h:235 [inline]
hardirqs last  enabled at (138911): [<ffffffff88fe5c72>] _raw_read_unlock_irqrestore+0x42/0x50 kernel/locking/spinlock.c:263
hardirqs last disabled at (138912): [<ffffffff88fe5955>] __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:157 [inline]
hardirqs last disabled at (138912): [<ffffffff88fe5955>] _raw_read_lock_irqsave+0x85/0x90 kernel/locking/spinlock.c:231
softirqs last  enabled at (138886): [<ffffffff89000eaf>] asm_call_irq_on_stack+0xf/0x20
softirqs last disabled at (138843): [<ffffffff89000eaf>] asm_call_irq_on_stack+0xf/0x20
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 1 PID: 8459 Comm: syz-executor401 Not tainted 5.11.0-rc4-next-20210119-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:120
 ___might_sleep.cold+0x1f1/0x237 kernel/sched/core.c:8083
 rxe_alloc_nl+0x55c/0x710 drivers/infiniband/sw/rxe/rxe_pool.c:346
 rxe_alloc+0x26/0x40 drivers/infiniband/sw/rxe/rxe_pool.c:385
 rxe_get_dma_mr+0x49/0x110 drivers/infiniband/sw/rxe/rxe_verbs.c:870
 __ib_alloc_pd+0x277/0x6d0 drivers/infiniband/core/verbs.c:299
 ib_mad_port_open drivers/infiniband/core/mad.c:2981 [inline]
 ib_mad_init_device+0xc78/0x1400 drivers/infiniband/core/mad.c:3092
 add_client_context+0x405/0x5e0 drivers/infiniband/core/device.c:717
 enable_device_and_get+0x1cd/0x3b0 drivers/infiniband/core/device.c:1317
 ib_register_device drivers/infiniband/core/device.c:1399 [inline]
 ib_register_device+0x7c7/0xa50 drivers/infiniband/core/device.c:1351
 rxe_register_device+0x3b2/0x480 drivers/infiniband/sw/rxe/rxe_verbs.c:1147
 rxe_add+0x12fe/0x16d0 drivers/infiniband/sw/rxe/rxe.c:247
 rxe_net_add+0x8c/0xe0 drivers/infiniband/sw/rxe/rxe_net.c:489
 rxe_newlink drivers/infiniband/sw/rxe/rxe.c:269 [inline]
 rxe_newlink+0xb7/0xe0 drivers/infiniband/sw/rxe/rxe.c:250
 nldev_newlink+0x30e/0x540 drivers/infiniband/core/nldev.c:1555
 rdma_nl_rcv_msg+0x36d/0x690 drivers/infiniband/core/netlink.c:195
 rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
 rdma_nl_rcv+0x2ee/0x430 drivers/infiniband/core/netlink.c:259
 netlink_unicast_kernel net/netlink/af_netlink.c:1304 [inline]
 netlink_unicast+0x533/0x7d0 net/netlink/af_netlink.c:1330
 netlink_sendmsg+0x856/0xd90 net/netlink/af_netlink.c:1919
 sock_sendmsg_nosec net/socket.c:652 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:672
 ____sys_sendmsg+0x6e8/0x810 net/socket.c:2345
 ___sys_sendmsg+0xf3/0x170 net/socket.c:2399
 __sys_sendmsg+0xe5/0x1b0 net/socket.c:2432
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x443689
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 eb 0d fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffd92ed8ec8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000443689
RDX: 0000000000000000 RSI: 0000000020000240 RDI: 0000000000000003
RBP: 00007ffd92ed8ed0 R08: 0000000001bbbbbb R09: 0000000001bbbbbb
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffd92ed8ee0
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
RDS/IB: syz2: added
smc: adding ib device syz2 with port count 1
smc:    ib device syz2 port 1 has pnetid 


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
