Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8673E735AEB
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Jun 2023 17:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbjFSPOk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Jun 2023 11:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbjFSPOi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 19 Jun 2023 11:14:38 -0400
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E64D7
        for <linux-rdma@vger.kernel.org>; Mon, 19 Jun 2023 08:14:36 -0700 (PDT)
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-77e45f12b5bso26198239f.0
        for <linux-rdma@vger.kernel.org>; Mon, 19 Jun 2023 08:14:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687187675; x=1689779675;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZdVR8emX5fYwQTKiB8+qGbypEkQ5NOcZ73pGxB9Ih80=;
        b=iT0oIBF7nfs7yR87RQCO4EjeLRVeaCw+2337pRmBFblLgAT0bvDHr6OR5UK/uHVz1w
         8Qc1glsa1jD2i1BfLU+UsIfhVfuh/lmjaCB/k7qT3TZePaqiNCAmpyTt6va7BF9UHOFG
         RF7ON1X9a0hIeZoPRPE1gaHe4TdaOVwvlQzIm/hDs5xvfKjTs6RZ1Ereav9QmpAXwK96
         U5VdQ+sNF7XInhDfmjH+KB6jARzzPMY5tl+bfjIb6JrSIxKLp8npI8tr0BukoKi5z9uL
         Ts6v/PKRLNKhVSFU/ACx8SsAwqiL9E8CQSKVX6T7e6+fud30qJWGaS+gCgwNwUQZKK3P
         TzUw==
X-Gm-Message-State: AC+VfDykpj+J5O+a56No3+mb6koM1nTHW4/yUnnkD0o6G+cN3rVs3qtg
        vaQS4FvqrWStpJG3c2+ELsjyYQgMsmnB1ZCsa9qLrkfkqtKF
X-Google-Smtp-Source: ACHHUZ4nvqlLEsm0x4CZ9j2C+2khd63Dr+hL4ZTgSIob61yu5Pd9PkzC19LXbjKSnAzcxa//TPXlT6lx/I0qMl63c262AlwFYyLl
MIME-Version: 1.0
X-Received: by 2002:a02:848e:0:b0:422:f031:deb5 with SMTP id
 f14-20020a02848e000000b00422f031deb5mr2685121jai.0.1687187675598; Mon, 19 Jun
 2023 08:14:35 -0700 (PDT)
Date:   Mon, 19 Jun 2023 08:14:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000012d89205fe7cfe00@google.com>
Subject: [syzbot] [rdma?] general protection fault in rxe_completer
From:   syzbot <syzbot+2da1965168e7dbcba136@syzkaller.appspotmail.com>
To:     jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, zyjzyj2000@gmail.com
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

Hello,

syzbot found the following issue on:

HEAD commit:    0dbcac3a6dbb Merge tag 'mlx5-fixes-2023-06-16' of git://gi..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=168647cf280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ac246111fb601aec
dashboard link: https://syzkaller.appspot.com/bug?extid=2da1965168e7dbcba136
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7a5b8a7805df/disk-0dbcac3a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7aea10826aef/vmlinux-0dbcac3a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d2e6c04c44a8/bzImage-0dbcac3a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2da1965168e7dbcba136@syzkaller.appspotmail.com

infiniband syz2: set active
infiniband syz2: added wg2
general protection fault, probably for non-canonical address 0xdffffc0000000006: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000030-0x0000000000000037]
CPU: 1 PID: 20166 Comm: syz-executor.2 Not tainted 6.4.0-rc6-syzkaller-00218-g0dbcac3a6dbb #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
RIP: 0010:flush_send_queue drivers/infiniband/sw/rxe/rxe_comp.c:600 [inline]
RIP: 0010:rxe_completer+0x25c7/0x3d80 drivers/infiniband/sw/rxe/rxe_comp.c:659
Code: 80 3c 02 00 0f 85 7e 10 00 00 4c 8b ad 88 03 00 00 49 8d 45 30 48 89 c2 48 89 04 24 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <0f> b6 04 02 84 c0 74 08 3c 03 0f 8e 80 11 00 00 49 8d 45 2c 45 8b
RSP: 0018:ffffc90004ebe938 EFLAGS: 00010006
RAX: dffffc0000000000 RBX: ffffed10087e4000 RCX: ffffc900103f7000
RDX: 0000000000000006 RSI: ffffffff877fcaf5 RDI: ffff888043f20388
RBP: ffff888043f20000 R08: 0000000000000000 R09: ffff888043f2055b
R10: ffffed10087e40ab R11: 1ffffffff21a70e1 R12: 0000000000000246
R13: 0000000000000000 R14: ffff888043f201a0 R15: 0000000000000000
FS:  00007f94b8e21700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2db24000 CR3: 000000007e0d8000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 rxe_qp_do_cleanup+0x1c1/0x820 drivers/infiniband/sw/rxe/rxe_qp.c:771
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
 rxe_register_device+0x302/0x3e0 drivers/infiniband/sw/rxe/rxe_verbs.c:1486
 rxe_net_add+0x90/0xf0 drivers/infiniband/sw/rxe/rxe_net.c:534
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
RIP: 0033:0x7f94b808c389
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f94b8e21168 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f94b81abf80 RCX: 00007f94b808c389
RDX: 0000000000000000 RSI: 0000000020000380 RDI: 0000000000000003
RBP: 00007f94b80d7493 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe6f1226cf R14: 00007f94b8e21300 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:flush_send_queue drivers/infiniband/sw/rxe/rxe_comp.c:600 [inline]
RIP: 0010:rxe_completer+0x25c7/0x3d80 drivers/infiniband/sw/rxe/rxe_comp.c:659
Code: 80 3c 02 00 0f 85 7e 10 00 00 4c 8b ad 88 03 00 00 49 8d 45 30 48 89 c2 48 89 04 24 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <0f> b6 04 02 84 c0 74 08 3c 03 0f 8e 80 11 00 00 49 8d 45 2c 45 8b
RSP: 0018:ffffc90004ebe938 EFLAGS: 00010006
RAX: dffffc0000000000 RBX: ffffed10087e4000 RCX: ffffc900103f7000
RDX: 0000000000000006 RSI: ffffffff877fcaf5 RDI: ffff888043f20388
RBP: ffff888043f20000 R08: 0000000000000000 R09: ffff888043f2055b
R10: ffffed10087e40ab R11: 1ffffffff21a70e1 R12: 0000000000000246
R13: 0000000000000000 R14: ffff888043f201a0 R15: 0000000000000000
FS:  00007f94b8e21700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2db24000 CR3: 000000007e0d8000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   4:	0f 85 7e 10 00 00    	jne    0x1088
   a:	4c 8b ad 88 03 00 00 	mov    0x388(%rbp),%r13
  11:	49 8d 45 30          	lea    0x30(%r13),%rax
  15:	48 89 c2             	mov    %rax,%rdx
  18:	48 89 04 24          	mov    %rax,(%rsp)
  1c:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  23:	fc ff df
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax <-- trapping instruction
  2e:	84 c0                	test   %al,%al
  30:	74 08                	je     0x3a
  32:	3c 03                	cmp    $0x3,%al
  34:	0f 8e 80 11 00 00    	jle    0x11ba
  3a:	49 8d 45 2c          	lea    0x2c(%r13),%rax
  3e:	45                   	rex.RB
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
