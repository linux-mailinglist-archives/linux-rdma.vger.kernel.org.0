Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA8796A5B77
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Feb 2023 16:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjB1POt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Feb 2023 10:14:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjB1POq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 Feb 2023 10:14:46 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CC31CF56
        for <linux-rdma@vger.kernel.org>; Tue, 28 Feb 2023 07:14:45 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id l7-20020a0566022dc700b0074cc9aba965so5844697iow.11
        for <linux-rdma@vger.kernel.org>; Tue, 28 Feb 2023 07:14:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r/aMelHf7Ei0qvgQkk0g/w6wUpHmD3dnt1rTP2g0+sw=;
        b=fI9StU4/MvOfLnzXLKBTDNYNsYarUkB4/3op4d9mQSUo82v9w2jrsW9woTqPOAhbU5
         t25R3Zqov+ulklrB8vbPPd6galWFkeLx1vO3/FG5bRA+Fpjj6oWNGchwubRnWYH/4eSu
         ZzPw/hdRze9zhbgr8NfMAHjPakwQ/33Bw3+5bZ0FTpkw6hJfYvE2erzcngUVTBL8E64+
         ZCraJJa6mrYWjnqGdWvG44X0aiem+4GoP+28kM0xycM3c4FDCxFBkUOOMYis24rOfzD/
         Qxkd8d0jB/eWCaViaAHkxe4fTxYCNIdRN3Sr7FUFFbwHii5PKaq8+7nrYaO7e7uj9bLv
         QUGQ==
X-Gm-Message-State: AO0yUKUrPaBpeQT4EFuqRmYLnetq/rMf/UYlm67oZfo9Rv0GO6cSNreP
        dcJO74GE8wyp1xFd7eGS1mhBhSVquhN8LSqy1EVFkUCnCXHO
X-Google-Smtp-Source: AK7set+Sg6XTovJLAE3vAhTNVY/sOQ2od/c4TBI3LfdFAw12Q8sC9j0tDmd9fWm2dgJNR9zxYVngcHawjbAzboRrk/S1KTtfdJ3k
MIME-Version: 1.0
X-Received: by 2002:a02:b10c:0:b0:3ec:dc1f:12d8 with SMTP id
 r12-20020a02b10c000000b003ecdc1f12d8mr1434977jah.4.1677597284949; Tue, 28 Feb
 2023 07:14:44 -0800 (PST)
Date:   Tue, 28 Feb 2023 07:14:44 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003ee4ee05f5c40e99@google.com>
Subject: [syzbot] [rdma?] INFO: trying to register non-static key in
 rxe_cleanup_task (2)
From:   syzbot <syzbot+cfcc1a3c85be15a40cba@syzkaller.appspotmail.com>
To:     jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        zyjzyj2000@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    982818426a0f Merge tag 'arm-fixes-6.3-1' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1194800f480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=90a4de3f96747e3f
dashboard link: https://syzkaller.appspot.com/bug?extid=cfcc1a3c85be15a40cba
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/225d8c8e9264/disk-98281842.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/87a9e2a89842/vmlinux-98281842.xz
kernel image: https://storage.googleapis.com/syzbot-assets/39bdeb741f2e/bzImage-98281842.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cfcc1a3c85be15a40cba@syzkaller.appspotmail.com

Node 1 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
14586 total pagecache pages
0 pages in swap cache
Free swap  = 0kB
Total swap = 0kB
2097051 pages RAM
0 pages HighMem/MovableOnly
392145 pages reserved
0 pages cma reserved
INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
CPU: 1 PID: 5486 Comm: syz-executor.2 Not tainted 6.2.0-syzkaller-12765-g982818426a0f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/16/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 assign_lock_key kernel/locking/lockdep.c:982 [inline]
 register_lock_class+0xdb6/0x1120 kernel/locking/lockdep.c:1295
 __lock_acquire+0x108/0x5d40 kernel/locking/lockdep.c:4935
 lock_acquire kernel/locking/lockdep.c:5669 [inline]
 lock_acquire+0x1e3/0x670 kernel/locking/lockdep.c:5634
 __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
 _raw_spin_lock_bh+0x33/0x40 kernel/locking/spinlock.c:178
 spin_lock_bh include/linux/spinlock.h:355 [inline]
 rxe_cleanup_task+0x73/0xc0 drivers/infiniband/sw/rxe/rxe_task.c:119
 rxe_qp_do_cleanup+0x8c/0x7c0 drivers/infiniband/sw/rxe/rxe_qp.c:776
 execute_in_process_context+0x3b/0x150 kernel/workqueue.c:3458
 __rxe_cleanup+0x21e/0x370 drivers/infiniband/sw/rxe/rxe_pool.c:233
 rxe_create_qp+0x2c2/0x340 drivers/infiniband/sw/rxe/rxe_verbs.c:430
 create_qp+0x5ac/0x970 drivers/infiniband/core/verbs.c:1233
 ib_create_qp_kernel+0xa1/0x310 drivers/infiniband/core/verbs.c:1344
 ib_create_qp include/rdma/ib_verbs.h:3743 [inline]
 create_mad_qp+0x177/0x380 drivers/infiniband/core/mad.c:2905
 ib_mad_port_open drivers/infiniband/core/mad.c:2986 [inline]
 ib_mad_init_device+0xf40/0x1a90 drivers/infiniband/core/mad.c:3077
 add_client_context+0x405/0x5e0 drivers/infiniband/core/device.c:721
 enable_device_and_get+0x1cd/0x3b0 drivers/infiniband/core/device.c:1332
 ib_register_device drivers/infiniband/core/device.c:1420 [inline]
 ib_register_device+0x8b1/0xbc0 drivers/infiniband/core/device.c:1366
 rxe_register_device+0x317/0x3f0 drivers/infiniband/sw/rxe/rxe_verbs.c:1096
 rxe_net_add+0x90/0xf0 drivers/infiniband/sw/rxe/rxe_net.c:524
 rxe_newlink+0xd5/0x140 drivers/infiniband/sw/rxe/rxe.c:195
 nldev_newlink+0x332/0x5e0 drivers/infiniband/core/nldev.c:1731
 rdma_nl_rcv_msg+0x371/0x6a0 drivers/infiniband/core/netlink.c:195
 rdma_nl_rcv_skb.constprop.0.isra.0+0x2fc/0x440 drivers/infiniband/core/netlink.c:239
 netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
 netlink_unicast+0x547/0x7f0 net/netlink/af_netlink.c:1365
 netlink_sendmsg+0x925/0xe30 net/netlink/af_netlink.c:1942
 sock_sendmsg_nosec net/socket.c:722 [inline]
 sock_sendmsg+0xde/0x190 net/socket.c:745
 ____sys_sendmsg+0x71c/0x900 net/socket.c:2504
 ___sys_sendmsg+0x110/0x1b0 net/socket.c:2558
 __sys_sendmsg+0xf7/0x1c0 net/socket.c:2587
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fd95868c0f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd9594b3168 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fd9587abf80 RCX: 00007fd95868c0f9
RDX: 0000000000000000 RSI: 0000000020000200 RDI: 0000000000000003
RBP: 00007fd9586e7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff9db7c9ef R14: 00007fd9594b3300 R15: 0000000000022000
 </TASK>
infiniband syz1: Couldn't create ib_mad QP1
infiniband syz1: Couldn't open port 1
RDS/IB: syz1: added
smc: adding ib device syz1 with port count 1
smc:    ib device syz1 port 1 has pnetid 
syz-executor.2 (5486) used greatest stack depth: 22840 bytes left


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
