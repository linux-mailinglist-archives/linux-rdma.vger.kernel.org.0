Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554C96F5376
	for <lists+linux-rdma@lfdr.de>; Wed,  3 May 2023 10:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjECIkB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 May 2023 04:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjECIj3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 3 May 2023 04:39:29 -0400
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99B659E1
        for <linux-rdma@vger.kernel.org>; Wed,  3 May 2023 01:39:04 -0700 (PDT)
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-763537830d9so312178539f.0
        for <linux-rdma@vger.kernel.org>; Wed, 03 May 2023 01:39:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683103062; x=1685695062;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jPRMWoLcs+ASF/LIKiNmZ04rKvhKgWnI7QDSe6eqfN4=;
        b=Oc4q2Tg9lai7rHyF5niZbSikV9zpuqMLCQSq9bTl8eBCeLJN+syzrC5mE5dGfS74ii
         nxuTGtl1M5r1l5cvZdn2vvg2LxKHZLW+o9aoz7J26NpjCMy0lUoAs06irQcgppe7cYsB
         blIwuA5FWyiakEQWcBLOrKP++K5auZFu7YESlk+ObiTRYarecOPN3crqYl+5p64KeC4J
         u5oYJ40zgbN4OBoenhcvtrJpA6aJsPRKjGT+IriyXhWsMitAlwvdzeuHNWKxYnMOFd/w
         zltEYdjgvMq8UpP+cbW7zyy2NMpY8pOwjvpmeZj3YXp7UystWylv3IbfEZFwX/Ia0rrp
         Ss6w==
X-Gm-Message-State: AC+VfDy2bXfFC++x47rqLF6B5aeocy88nZm9vKBcIXGPAQiKNXpCnrzO
        Tp9nB7s+y60PWkQt2+DKO1Ri50cPpSoDRYgn0EnjY1++txZo
X-Google-Smtp-Source: ACHHUZ63ZYCbqb1SXaCOuzEPj4rSgyC9Xys0Od9cgzlh7upnRHx3vwot02YIUZWqHnk9CprIaxq44DqOgj1XncyuSatcOv2DpRjb
MIME-Version: 1.0
X-Received: by 2002:a02:9505:0:b0:40f:b3a8:6e43 with SMTP id
 y5-20020a029505000000b0040fb3a86e43mr9321430jah.6.1683103062119; Wed, 03 May
 2023 01:37:42 -0700 (PDT)
Date:   Wed, 03 May 2023 01:37:42 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000235bce05fac5f850@google.com>
Subject: [syzbot] [rdma?] INFO: trying to register non-static key in
 skb_dequeue (2)
From:   syzbot <syzbot+eba589d8f49c73d356da@syzkaller.appspotmail.com>
To:     jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        zyjzyj2000@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    348551ddaf31 Merge tag 'pinctrl-v6.4-1' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1375fdf8280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=35e09b26aabb80e5
dashboard link: https://syzkaller.appspot.com/bug?extid=eba589d8f49c73d356da
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/adddf809a67d/disk-348551dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/266c56354fa2/vmlinux-348551dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e0fc2088acd1/bzImage-348551dd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+eba589d8f49c73d356da@syzkaller.appspotmail.com

infiniband syz2: set active
infiniband syz2: added bond_slave_1
INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
CPU: 1 PID: 31038 Comm: syz-executor.3 Not tainted 6.3.0-syzkaller-12728-g348551ddaf31 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 assign_lock_key kernel/locking/lockdep.c:982 [inline]
 register_lock_class+0xdb6/0x1120 kernel/locking/lockdep.c:1295
 __lock_acquire+0x10a/0x5df0 kernel/locking/lockdep.c:4951
 lock_acquire kernel/locking/lockdep.c:5691 [inline]
 lock_acquire+0x1b1/0x520 kernel/locking/lockdep.c:5656
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x3d/0x60 kernel/locking/spinlock.c:162
 skb_dequeue+0x20/0x180 net/core/skbuff.c:3631
 drain_resp_pkts drivers/infiniband/sw/rxe/rxe_comp.c:555 [inline]
 rxe_completer+0x250d/0x3cc0 drivers/infiniband/sw/rxe/rxe_comp.c:652
 rxe_qp_do_cleanup+0x1be/0x820 drivers/infiniband/sw/rxe/rxe_qp.c:761
 execute_in_process_context+0x3b/0x150 kernel/workqueue.c:3473
 __rxe_cleanup+0x21e/0x370 drivers/infiniband/sw/rxe/rxe_pool.c:233
 rxe_create_qp+0x3f6/0x5f0 drivers/infiniband/sw/rxe/rxe_verbs.c:583
 create_qp+0x5ac/0x970 drivers/infiniband/core/verbs.c:1235
 ib_create_qp_kernel+0xa1/0x310 drivers/infiniband/core/verbs.c:1346
 ib_create_qp include/rdma/ib_verbs.h:3743 [inline]
 create_mad_qp+0x177/0x380 drivers/infiniband/core/mad.c:2905
 ib_mad_port_open drivers/infiniband/core/mad.c:2986 [inline]
 ib_mad_init_device+0xf40/0x1a90 drivers/infiniband/core/mad.c:3077
 add_client_context+0x405/0x5e0 drivers/infiniband/core/device.c:721
 enable_device_and_get+0x1cd/0x3b0 drivers/infiniband/core/device.c:1332
 ib_register_device drivers/infiniband/core/device.c:1420 [inline]
 ib_register_device+0x8b1/0xbc0 drivers/infiniband/core/device.c:1366
 rxe_register_device+0x302/0x3e0 drivers/infiniband/sw/rxe/rxe_verbs.c:1485
 rxe_net_add+0x90/0xf0 drivers/infiniband/sw/rxe/rxe_net.c:527
 rxe_newlink+0xf0/0x1b0 drivers/infiniband/sw/rxe/rxe.c:197
 nldev_newlink+0x332/0x5e0 drivers/infiniband/core/nldev.c:1731
 rdma_nl_rcv_msg+0x371/0x6a0 drivers/infiniband/core/netlink.c:195
 rdma_nl_rcv_skb.constprop.0.isra.0+0x2fc/0x440 drivers/infiniband/core/netlink.c:239
 netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
 netlink_unicast+0x547/0x7f0 net/netlink/af_netlink.c:1365
 netlink_sendmsg+0x925/0xe30 net/netlink/af_netlink.c:1913
 sock_sendmsg_nosec net/socket.c:724 [inline]
 sock_sendmsg+0xde/0x190 net/socket.c:747
 ____sys_sendmsg+0x71c/0x900 net/socket.c:2503
 ___sys_sendmsg+0x110/0x1b0 net/socket.c:2557
 __sys_sendmsg+0xf7/0x1c0 net/socket.c:2586
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7feddf48c169
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fede029f168 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007feddf5abf80 RCX: 00007feddf48c169
RDX: 0000000000000000 RSI: 0000000020000240 RDI: 0000000000000003
RBP: 00007feddf4e7ca1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe1bb3e01f R14: 00007fede029f300 R15: 0000000000022000
 </TASK>
general protection fault, probably for non-canonical address 0xdffffc0000000006: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000030-0x0000000000000037]
CPU: 1 PID: 31038 Comm: syz-executor.3 Not tainted 6.3.0-syzkaller-12728-g348551ddaf31 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
RIP: 0010:flush_send_queue drivers/infiniband/sw/rxe/rxe_comp.c:597 [inline]
RIP: 0010:rxe_completer+0x255c/0x3cc0 drivers/infiniband/sw/rxe/rxe_comp.c:653
Code: 80 3c 02 00 0f 85 81 10 00 00 49 8b af 88 03 00 00 48 8d 45 30 48 89 c2 48 89 04 24 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <0f> b6 04 02 84 c0 74 08 3c 03 0f 8e 83 11 00 00 48 8d 45 2c 44 8b
RSP: 0018:ffffc90003526938 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: ffffed100e3fe800 RCX: ffffc9000b403000
RDX: 0000000000000006 RSI: ffffffff877e467a RDI: ffff888071ff4388
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: fffffbfff1cf3682 R11: fffffffffffda5b0 R12: ffff888071ff41a0
R13: 0000000000000000 R14: 0000000000000000 R15: ffff888071ff4000
FS:  00007fede029f700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2d822000 CR3: 000000002c7e6000 CR4: 00000000003506e0
Call Trace:
 <TASK>
 rxe_qp_do_cleanup+0x1be/0x820 drivers/infiniband/sw/rxe/rxe_qp.c:761
 execute_in_process_context+0x3b/0x150 kernel/workqueue.c:3473
 __rxe_cleanup+0x21e/0x370 drivers/infiniband/sw/rxe/rxe_pool.c:233
 rxe_create_qp+0x3f6/0x5f0 drivers/infiniband/sw/rxe/rxe_verbs.c:583
 create_qp+0x5ac/0x970 drivers/infiniband/core/verbs.c:1235
 ib_create_qp_kernel+0xa1/0x310 drivers/infiniband/core/verbs.c:1346
 ib_create_qp include/rdma/ib_verbs.h:3743 [inline]
 create_mad_qp+0x177/0x380 drivers/infiniband/core/mad.c:2905
 ib_mad_port_open drivers/infiniband/core/mad.c:2986 [inline]
 ib_mad_init_device+0xf40/0x1a90 drivers/infiniband/core/mad.c:3077
 add_client_context+0x405/0x5e0 drivers/infiniband/core/device.c:721
 enable_device_and_get+0x1cd/0x3b0 drivers/infiniband/core/device.c:1332
 ib_register_device drivers/infiniband/core/device.c:1420 [inline]
 ib_register_device+0x8b1/0xbc0 drivers/infiniband/core/device.c:1366
 rxe_register_device+0x302/0x3e0 drivers/infiniband/sw/rxe/rxe_verbs.c:1485
 rxe_net_add+0x90/0xf0 drivers/infiniband/sw/rxe/rxe_net.c:527
 rxe_newlink+0xf0/0x1b0 drivers/infiniband/sw/rxe/rxe.c:197
 nldev_newlink+0x332/0x5e0 drivers/infiniband/core/nldev.c:1731
 rdma_nl_rcv_msg+0x371/0x6a0 drivers/infiniband/core/netlink.c:195
 rdma_nl_rcv_skb.constprop.0.isra.0+0x2fc/0x440 drivers/infiniband/core/netlink.c:239
 netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
 netlink_unicast+0x547/0x7f0 net/netlink/af_netlink.c:1365
 netlink_sendmsg+0x925/0xe30 net/netlink/af_netlink.c:1913
 sock_sendmsg_nosec net/socket.c:724 [inline]
 sock_sendmsg+0xde/0x190 net/socket.c:747
 ____sys_sendmsg+0x71c/0x900 net/socket.c:2503
 ___sys_sendmsg+0x110/0x1b0 net/socket.c:2557
 __sys_sendmsg+0xf7/0x1c0 net/socket.c:2586
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7feddf48c169
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fede029f168 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007feddf5abf80 RCX: 00007feddf48c169
RDX: 0000000000000000 RSI: 0000000020000240 RDI: 0000000000000003
RBP: 00007feddf4e7ca1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe1bb3e01f R14: 00007fede029f300 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:flush_send_queue drivers/infiniband/sw/rxe/rxe_comp.c:597 [inline]
RIP: 0010:rxe_completer+0x255c/0x3cc0 drivers/infiniband/sw/rxe/rxe_comp.c:653
Code: 80 3c 02 00 0f 85 81 10 00 00 49 8b af 88 03 00 00 48 8d 45 30 48 89 c2 48 89 04 24 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <0f> b6 04 02 84 c0 74 08 3c 03 0f 8e 83 11 00 00 48 8d 45 2c 44 8b
RSP: 0018:ffffc90003526938 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: ffffed100e3fe800 RCX: ffffc9000b403000
RDX: 0000000000000006 RSI: ffffffff877e467a RDI: ffff888071ff4388
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: fffffbfff1cf3682 R11: fffffffffffda5b0 R12: ffff888071ff41a0
R13: 0000000000000000 R14: 0000000000000000 R15: ffff888071ff4000
FS:  00007fede029f700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2d822000 CR3: 000000002c7e6000 CR4: 00000000003506e0
----------------
Code disassembly (best guess):
   0:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   4:	0f 85 81 10 00 00    	jne    0x108b
   a:	49 8b af 88 03 00 00 	mov    0x388(%r15),%rbp
  11:	48 8d 45 30          	lea    0x30(%rbp),%rax
  15:	48 89 c2             	mov    %rax,%rdx
  18:	48 89 04 24          	mov    %rax,(%rsp)
  1c:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  23:	fc ff df
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax <-- trapping instruction
  2e:	84 c0                	test   %al,%al
  30:	74 08                	je     0x3a
  32:	3c 03                	cmp    $0x3,%al
  34:	0f 8e 83 11 00 00    	jle    0x11bd
  3a:	48 8d 45 2c          	lea    0x2c(%rbp),%rax
  3e:	44                   	rex.R
  3f:	8b                   	.byte 0x8b


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
