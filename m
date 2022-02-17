Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD404BA7E6
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Feb 2022 19:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240412AbiBQSNf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Feb 2022 13:13:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235384AbiBQSNf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Feb 2022 13:13:35 -0500
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F565EBAD7
        for <linux-rdma@vger.kernel.org>; Thu, 17 Feb 2022 10:13:20 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id v123-20020a6bc581000000b0063d8771a58aso2762902iof.0
        for <linux-rdma@vger.kernel.org>; Thu, 17 Feb 2022 10:13:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Cx4MR5VyxaiDEMU1/9O/zHtFiqyQWEfm2JdWtbVvSCw=;
        b=4NZjQ4PZaBOGlI0Gz/3DjHD4B76L+Syoo2h8oOJdRVf6P4VI4tWY8DXDNjlis6kwam
         Tuk792nlyXTZeCB15GCtKbZm7aP8nX0RbxN35MnqLh0VOICH7Hy3SSRn3qHRK8wTo/cS
         INrNrjZAd/U1ATP5yvSeI7SSQAwedCtOaSCJp2VRsxay/lNaRlnhg8IT9LDJTo5eOA9w
         SXLIQwk2IHyYV977p5kM21io/pAQ6Sp53TknVDVU8D0xLjZa1lTGK2YmOCM++WOWv85W
         EdUafECt2LLgBCIFgRe2wGURJCssBCtx7s95VLEa6RGcXHJsnHQJOQdtI/w4/oL6SUHZ
         GtSw==
X-Gm-Message-State: AOAM532j4hRQj9i5DfuKma0MejdBOOF/gN8sSEaQp21qUnc1NSDatAZO
        YPUAKLNB2IsCJAjD9PGuYB5gPzccouMryEpmV07O1rk04KLP
X-Google-Smtp-Source: ABdhPJxUp3q5WGkqjiKQy3ufRuQ3Ddm00MFvhI9yNQBC8jrbSCVMRLJQd+3w7MA21GGDnP1Yp1hJQ1ethxQJRoBwpVfuPUEJHnIG
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b4c:b0:2be:aaec:271c with SMTP id
 f12-20020a056e020b4c00b002beaaec271cmr2854972ilu.219.1645121599425; Thu, 17
 Feb 2022 10:13:19 -0800 (PST)
Date:   Thu, 17 Feb 2022 10:13:19 -0800
In-Reply-To: <000000000000b772b805d8396f14@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008bcf6e05d83ab885@google.com>
Subject: Re: [syzbot] BUG: sleeping function called from invalid context in smc_pnet_apply_ib
From:   syzbot <syzbot+4f322a6d84e991c38775@syzkaller.appspotmail.com>
To:     fmdefrancesco@gmail.com, jgg@ziepe.ca, liangwenpeng@huawei.com,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        liweihang@huawei.com, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    5740d0689096 net: sched: limit TC_ACT_REPEAT loops
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=1474360e700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=88e226f0197aeba5
dashboard link: https://syzkaller.appspot.com/bug?extid=4f322a6d84e991c38775
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13dd93f2700000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16a497e2700000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4f322a6d84e991c38775@syzkaller.appspotmail.com

infiniband syz1: set active
infiniband syz1: added lo
RDS/IB: syz1: added
smc: adding ib device syz1 with port count 1
BUG: sleeping function called from invalid context at kernel/locking/mutex.c:577
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 3589, name: syz-executor180
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
6 locks held by syz-executor180/3589:
 #0: ffffffff90865838 (&rdma_nl_types[idx].sem){.+.+}-{3:3}, at: rdma_nl_rcv_msg+0x161/0x690 drivers/infiniband/core/netlink.c:164
 #1: ffffffff8d04edf0 (link_ops_rwsem){++++}-{3:3}, at: nldev_newlink+0x25d/0x560 drivers/infiniband/core/nldev.c:1707
 #2: ffffffff8d03e650 (devices_rwsem){++++}-{3:3}, at: enable_device_and_get+0xfc/0x3b0 drivers/infiniband/core/device.c:1321
 #3: ffffffff8d03e510 (clients_rwsem){++++}-{3:3}, at: enable_device_and_get+0x15b/0x3b0 drivers/infiniband/core/device.c:1329
 #4: ffff8880790445c0 (&device->client_data_rwsem){++++}-{3:3}, at: add_client_context+0x3d0/0x5e0 drivers/infiniband/core/device.c:718
 #5: ffff88814a29c818 (&pnettable->lock){++++}-{2:2}, at: smc_pnetid_by_table_ib+0x18c/0x470 net/smc/smc_pnet.c:1159
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 0 PID: 3589 Comm: syz-executor180 Not tainted 5.17.0-rc3-syzkaller-00174-g5740d0689096 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 __might_resched.cold+0x222/0x26b kernel/sched/core.c:9576
 __mutex_lock_common kernel/locking/mutex.c:577 [inline]
 __mutex_lock+0x9f/0x12f0 kernel/locking/mutex.c:733
 smc_pnet_apply_ib+0x28/0x160 net/smc/smc_pnet.c:251
 smc_pnetid_by_table_ib+0x2ae/0x470 net/smc/smc_pnet.c:1164
 smc_ib_add_dev+0x4d7/0x900 net/smc/smc_ib.c:940
 add_client_context+0x405/0x5e0 drivers/infiniband/core/device.c:720
 enable_device_and_get+0x1cd/0x3b0 drivers/infiniband/core/device.c:1331
 ib_register_device drivers/infiniband/core/device.c:1419 [inline]
 ib_register_device+0x814/0xaf0 drivers/infiniband/core/device.c:1365
 rxe_register_device+0x2fe/0x3b0 drivers/infiniband/sw/rxe/rxe_verbs.c:1146
 rxe_add+0x1331/0x1710 drivers/infiniband/sw/rxe/rxe.c:246
 rxe_net_add+0x8c/0xe0 drivers/infiniband/sw/rxe/rxe_net.c:538
 rxe_newlink drivers/infiniband/sw/rxe/rxe.c:268 [inline]
 rxe_newlink+0xa9/0xd0 drivers/infiniband/sw/rxe/rxe.c:249
 nldev_newlink+0x30a/0x560 drivers/infiniband/core/nldev.c:1717
 rdma_nl_rcv_msg+0x36d/0x690 drivers/infiniband/core/netlink.c:195
 rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
 rdma_nl_rcv+0x2ee/0x430 drivers/infiniband/core/netlink.c:259
 netlink_unicast_kernel net/netlink/af_netlink.c:1317 [inline]
 netlink_unicast+0x539/0x7e0 net/netlink/af_netlink.c:1343
 netlink_sendmsg+0x904/0xe00 net/netlink/af_netlink.c:1919
 sock_sendmsg_nosec net/socket.c:705 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:725
 ____sys_sendmsg+0x6e8/0x810 net/socket.c:2413
 ___sys_sendmsg+0xf3/0x170 net/socket.c:2467
 __sys_sendmsg+0xe5/0x1b0 net/socket.c:2496
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f7ef25bed59
Code: 28 c3 e8 5a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcd0ce91d8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f7ef25bed59
RDX: 0000000000000000 RSI: 00000000200000c0 RDI: 0000000000000005
RBP: 00007f7ef25827c0 R08: 0000000000000014 R09: 0000000000000000
R10: 0000000000000041 R11: 0000000000000246 R12: 00007f7ef2582850
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

=============================
[ BUG: Invalid wait context ]
5.17.0-rc3-syzkaller-00174-g5740d0689096 #0 Tainted: G        W        
-----------------------------
syz-executor180/3589 is trying to lock:
ffffffff8d7100d8 (smc_ib_devices.mutex){+.+.}-{3:3}, at: smc_pnet_apply_ib+0x28/0x160 net/smc/smc_pnet.c:251
other info that might help us debug this:
context-{4:4}
6 locks held by syz-executor180/3589:
 #0: ffffffff90865838 (&rdma_nl_types[idx].sem){.+.+}-{3:3}, at: rdma_nl_rcv_msg+0x161/0x690 drivers/infiniband/core/netlink.c:164
 #1: ffffffff8d04edf0 (link_ops_rwsem){++++}-{3:3}, at: nldev_newlink+0x25d/0x560 drivers/infiniband/core/nldev.c:1707
 #2: ffffffff8d03e650 (devices_rwsem){++++}-{3:3}, at: enable_device_and_get+0xfc/0x3b0 drivers/infiniband/core/device.c:1321
 #3: ffffffff8d03e510 (clients_rwsem){++++}-{3:3}, at: enable_device_and_get+0x15b/0x3b0 drivers/infiniband/core/device.c:1329
 #4: ffff8880790445c0 (&device->client_data_rwsem){++++}-{3:3}, at: add_client_context+0x3d0/0x5e0 drivers/infiniband/core/device.c:718
 #5: ffff88814a29c818 (&pnettable->lock){++++}-{2:2}, at: smc_pnetid_by_table_ib+0x18c/0x470 net/smc/smc_pnet.c:1159
stack backtrace:
CPU: 0 PID: 3589 Comm: syz-executor180 Tainted: G        W         5.17.0-rc3-syzkaller-00174-g5740d0689096 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_lock_invalid_wait_context kernel/locking/lockdep.c:4678 [inline]
 check_wait_context kernel/locking/lockdep.c:4739 [inline]
 __lock_acquire.cold+0x213/0x3ab kernel/locking/lockdep.c:4977
 lock_acquire kernel/locking/lockdep.c:5639 [inline]
 lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5604
 __mutex_lock_common kernel/locking/mutex.c:600 [inline]
 __mutex_lock+0x12f/0x12f0 kernel/locking/mutex.c:733
 smc_pnet_apply_ib+0x28/0x160 net/smc/smc_pnet.c:251
 smc_pnetid_by_table_ib+0x2ae/0x470 net/smc/smc_pnet.c:1164
 smc_ib_add_dev+0x4d7/0x900 net/smc/smc_ib.c:940
 add_client_context+0x405/0x5e0 drivers/infiniband/core/device.c:720
 enable_device_and_get+0x1cd/0x3b0 drivers/infiniband/core/device.c:1331
 ib_register_device drivers/infiniband/core/device.c:1419 [inline]
 ib_register_device+0x814/0xaf0 drivers/infiniband/core/device.c:1365
 rxe_register_device+0x2fe/0x3b0 drivers/infiniband/sw/rxe/rxe_verbs.c:1146
 rxe_add+0x1331/0x1710 drivers/infiniband/sw/rxe/rxe.c:246
 rxe_net_add+0x8c/0xe0 drivers/infiniband/sw/rxe/rxe_net.c:538
 rxe_newlink drivers/infiniband/sw/rxe/rxe.c:268 [inline]
 rxe_newlink+0xa9/0xd0 drivers/infiniband/sw/rxe/rxe.c:249
 nldev_newlink+0x30a/0x560 drivers/infiniband/core/nldev.c:1717
 rdma_nl_rcv_msg+0x36d/0x690 drivers/infiniband/core/netlink.c:195
 rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
 rdma_nl_rcv+0x2ee/0x430 drivers/infiniband/core/netlink.c:259
 netlink_unicast_kernel net/netlink/af_netlink.c:1317 [inline]
 netlink_unicast+0x539/0x7e0 net/netlink/af_netlink.c:1343
 netlink_sendmsg+0x904/0xe00 net/netlink/af_netlink.c:1919
 sock_sendmsg_nosec net/socket.c:705 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:725
 ____sys_sendmsg+0x6e8/0x810 net/socket.c:2413
 ___sys_sendmsg+0xf3/0x170 net/socket.c:2467
 __sys_sendmsg+0xe5/0x1b0 net/socket.c:2496
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f7ef25bed59
Code: 28 c3 e8 5a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcd0ce91d8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f7ef25bed59
RDX: 0000000000000000 RSI: 00000000200000c0 RDI: 0000000000000005
RBP: 00007f7ef25827c0 R08: 0000000000000014 R09: 0000000000000000
R10: 0000000000000041 R11: 0000000000000246 R12: 00007f7ef2582850
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
smc:    ib device syz1 port 1 has pnetid SYZ2 (user defined)

