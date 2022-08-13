Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B686591946
	for <lists+linux-rdma@lfdr.de>; Sat, 13 Aug 2022 09:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238439AbiHMHc2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 13 Aug 2022 03:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237787AbiHMHc1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 13 Aug 2022 03:32:27 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B59F82FBA
        for <linux-rdma@vger.kernel.org>; Sat, 13 Aug 2022 00:32:26 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id h203-20020a6bb7d4000000b006804b1617f2so1741521iof.17
        for <linux-rdma@vger.kernel.org>; Sat, 13 Aug 2022 00:32:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=Vc6ISdGCIAree8edDXhxCI+8cTiNUQZGcG9Culoutxw=;
        b=RQa9RqWe8g3gHYkr6a5aAKfDYcOIQH4Nhb1jSU16Ep5bu3/OAjJEEsgrBPuOC3bshd
         fuqHqfaGEmyFi0lniMvPan7p0wDfWThQnnezvRxCsx2cO8uGewvMuGqXIF8WJKjKM4RV
         B7gRs8SKfA96NgaAYH14E/FrusSr/yh5+aQH5OcJObdcoyF/kCqXwd5PPBxd442B5oxw
         FMO4ZM3l8Jp3lRsdre2JF9qAppUl7z3jgLH6JBkksY879cFKZt3oq41WRqb1cSWV+OS8
         CwyifZ99riklIHN8t62j2KoBiu9HApQ4UeSLY62Wz/oYAM15+pbwFENQzPmCnTPGghDQ
         AZYQ==
X-Gm-Message-State: ACgBeo0vgzaTrAKHELDwYumpTrLPm03OVDYng6C3NvfbwwyLO5+i8dNr
        T7VqeyBqY0oDJnqJcCZ6icccW3v2Vh125sR/k3pqxdKv4Uu/
X-Google-Smtp-Source: AA6agR5ix42whR+ZnzPIJm4+lUkxNZi71yzzTRsfyf7U3Ro9A4LOiQ3iVcmfIMzL+jrrqi2ud26Zy9oHHNBrpWSW/kYzmTnLAtws
MIME-Version: 1.0
X-Received: by 2002:a5d:9d83:0:b0:67c:bb80:3f63 with SMTP id
 ay3-20020a5d9d83000000b0067cbb803f63mr3060319iob.90.1660375945639; Sat, 13
 Aug 2022 00:32:25 -0700 (PDT)
Date:   Sat, 13 Aug 2022 00:32:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006efbd905e61a66f1@google.com>
Subject: [syzbot] BUG: unable to handle kernel NULL pointer dereference in __rxe_do_task
From:   syzbot <syzbot+ab99dc4c6e961eed8b8e@syzkaller.appspotmail.com>
To:     jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        zyjzyj2000@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    7ebfc85e2cd7 Merge tag 'net-6.0-rc1' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10a0a03d080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=924833c12349a8c0
dashboard link: https://syzkaller.appspot.com/bug?extid=ab99dc4c6e961eed8b8e
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ab99dc4c6e961eed8b8e@syzkaller.appspotmail.com

infiniband syz2: set active
infiniband syz2: added batadv_slave_1
BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor instruction fetch in kernel mode
#PF: error_code(0x0010) - not-present page
PGD 70431067 P4D 70431067 PUD 1f748067 PMD 0 
Oops: 0010 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 6103 Comm: syz-executor.5 Not tainted 5.19.0-syzkaller-13930-g7ebfc85e2cd7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
RIP: 0010:0x0
Code: Unable to access opcode bytes at RIP 0xffffffffffffffd6.
RSP: 0018:ffffc90003e6eb40 EFLAGS: 00010246
RAX: 0000000000040000 RBX: ffff88807caf65c8 RCX: ffffc9000b042000
RDX: 0000000000040000 RSI: ffffffff86d4bfcb RDI: 0000000000000000
RBP: ffffed100f95ecc8 R08: 0000000000000001 R09: ffff88807caf669f
R10: ffffed100f95ecd3 R11: 0000000000000000 R12: 0000000000000000
R13: ffffed100f95ecc9 R14: ffff88807caf6640 R15: ffff88807caf6648
FS:  00007fa5efd65700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 000000006ec84000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 __rxe_do_task+0x56/0xc0 drivers/infiniband/sw/rxe/rxe_task.c:18
 rxe_qp_do_cleanup+0x102/0x770 drivers/infiniband/sw/rxe/rxe_qp.c:800
 execute_in_process_context+0x37/0x150 kernel/workqueue.c:3359
 __rxe_cleanup+0x21a/0x400 drivers/infiniband/sw/rxe/rxe_pool.c:276
 rxe_create_qp+0x2be/0x340 drivers/infiniband/sw/rxe/rxe_verbs.c:441
 create_qp+0x5ac/0x960 drivers/infiniband/core/verbs.c:1233
 ib_create_qp_kernel+0x9d/0x310 drivers/infiniband/core/verbs.c:1344
 ib_create_qp include/rdma/ib_verbs.h:3732 [inline]
 create_mad_qp+0x177/0x2d0 drivers/infiniband/core/mad.c:2910
 ib_mad_port_open drivers/infiniband/core/mad.c:2991 [inline]
 ib_mad_init_device+0xd51/0x13f0 drivers/infiniband/core/mad.c:3082
 add_client_context+0x405/0x5e0 drivers/infiniband/core/device.c:721
 enable_device_and_get+0x1cd/0x3b0 drivers/infiniband/core/device.c:1332
 ib_register_device drivers/infiniband/core/device.c:1420 [inline]
 ib_register_device+0x83e/0xb20 drivers/infiniband/core/device.c:1366
 rxe_register_device+0x2fe/0x3b0 drivers/infiniband/sw/rxe/rxe_verbs.c:1138
 rxe_net_add+0x8c/0xe0 drivers/infiniband/sw/rxe/rxe_net.c:521
 rxe_newlink drivers/infiniband/sw/rxe/rxe.c:195 [inline]
 rxe_newlink+0xa9/0xd0 drivers/infiniband/sw/rxe/rxe.c:176
 nldev_newlink+0x32e/0x5c0 drivers/infiniband/core/nldev.c:1717
 rdma_nl_rcv_msg+0x36d/0x690 drivers/infiniband/core/netlink.c:195
 rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
 rdma_nl_rcv+0x2ee/0x430 drivers/infiniband/core/netlink.c:259
 netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
 netlink_unicast+0x543/0x7f0 net/netlink/af_netlink.c:1345
 netlink_sendmsg+0x917/0xe10 net/netlink/af_netlink.c:1921
 sock_sendmsg_nosec net/socket.c:714 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:734
 ____sys_sendmsg+0x6eb/0x810 net/socket.c:2482
 ___sys_sendmsg+0x110/0x1b0 net/socket.c:2536
 __sys_sendmsg+0xf3/0x1c0 net/socket.c:2565
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fa5eec89279
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa5efd65168 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fa5eed9bf80 RCX: 00007fa5eec89279
RDX: 0000000000000000 RSI: 0000000020000200 RDI: 0000000000000003
RBP: 00007fa5eece3189 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffcc2ee4ccf R14: 00007fa5efd65300 R15: 0000000000022000
 </TASK>
Modules linked in:
CR2: 0000000000000000
---[ end trace 0000000000000000 ]---
RIP: 0010:0x0
Code: Unable to access opcode bytes at RIP 0xffffffffffffffd6.
RSP: 0018:ffffc90003e6eb40 EFLAGS: 00010246
RAX: 0000000000040000 RBX: ffff88807caf65c8 RCX: ffffc9000b042000
RDX: 0000000000040000 RSI: ffffffff86d4bfcb RDI: 0000000000000000
RBP: ffffed100f95ecc8 R08: 0000000000000001 R09: ffff88807caf669f
R10: ffffed100f95ecd3 R11: 0000000000000000 R12: 0000000000000000
R13: ffffed100f95ecc9 R14: ffff88807caf6640 R15: ffff88807caf6648
FS:  00007fa5efd65700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 000000006ec84000 CR4: 0000000000350ef0


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
