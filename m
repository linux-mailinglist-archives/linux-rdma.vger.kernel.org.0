Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA269532166
	for <lists+linux-rdma@lfdr.de>; Tue, 24 May 2022 05:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbiEXDCu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 May 2022 23:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234402AbiEXDB5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 May 2022 23:01:57 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528B711D
        for <linux-rdma@vger.kernel.org>; Mon, 23 May 2022 20:01:52 -0700 (PDT)
Message-ID: <be9858d2-0634-b5c5-7c60-c9b95a31cd06@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1653361310;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PQoKI1SXBw91FGw/xQIHm6+dSt+K7jYkKcLAIbcmny8=;
        b=k13IuPTKxfl0//KDX8x1jG2Md3kvy/GhAjnMDwhjn1DyOH4az9viJJ0VKGQ7t7TjjAVYt2
        TE7vJ1HGVen5hgqmA+LyJyrDdQPjDD8K49B9b93BXbVUKc+H6GFY2pBDKLLzmgoqB55K67
        FJYZ8pmb8d5ijRMG6oFOdN3X7p1dyk0=
Date:   Tue, 24 May 2022 11:01:43 +0800
MIME-Version: 1.0
Subject: Re: Fwd: [syzbot] INFO: trying to register non-static key in
 rxe_cleanup_task
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <0000000000006ed46805dfaded18@google.com>
 <441e21b1-ed83-6070-e73a-97f78972e4f4@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <441e21b1-ed83-6070-e73a-97f78972e4f4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2022/5/24 6:55, Bob Pearson 写道:
> I am not familiar with syzbot warnings but this feels like an instance of our old friend the lockdep warning
> caused by AH bleeding over into the other xa_lock users. We either have to agree to move forward to use rcu

It seems that this problem is not related with AH bleeding.

> locking or replace all the spinlocks in rxe_pool.c with spin_lock_irqsave() locks. I have a patch that does that
> but I haven't sent it in since Zhu also had a patch to do the same but it is still in limbo somewhere.

About your patch series, please fix the ah problem. Then sending them out.

Zhu Yanjun

> 
> If we do that it has the undesirable side affect of making all the allocations in xarray be GFP_ATOMIC though.
> 
> Bob
> 
> -------- Forwarded Message --------
> Subject: [syzbot] INFO: trying to register non-static key in rxe_cleanup_task
> Date: Mon, 23 May 2022 06:36:29 -0700
> From: syzbot <syzbot+833061116fa28df97f3b@syzkaller.appspotmail.com>
> To: jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com, zyjzyj2000@gmail.com
> 
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    cc63e8e92cb8 Add linux-next specific files for 20220523
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=17adae81f00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c414c5699721a60d
> dashboard link: https://syzkaller.appspot.com/bug?extid=833061116fa28df97f3b
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+833061116fa28df97f3b@syzkaller.appspotmail.com
> 
> infiniband syz1: set active
> infiniband syz1: added batadv_slave_1
> INFO: trying to register non-static key.
> INFO: trying to register non-static key.
> The code is fine but needs lockdep annotation, or maybe
> you didn't initialize this object before use?
> turning off the locking correctness validator.
> CPU: 1 PID: 8344 Comm: syz-executor.4 Not tainted 5.18.0-next-20220523-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:88 [inline]
>   dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
>   assign_lock_key kernel/locking/lockdep.c:979 [inline]
>   register_lock_class+0xf30/0x1130 kernel/locking/lockdep.c:1292
>   __lock_acquire+0x10a/0x5660 kernel/locking/lockdep.c:4932
>   lock_acquire kernel/locking/lockdep.c:5665 [inline]
>   lock_acquire+0x1ab/0x570 kernel/locking/lockdep.c:5630
>   __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
>   _raw_spin_lock_bh+0x2f/0x40 kernel/locking/spinlock.c:178
>   spin_lock_bh include/linux/spinlock.h:365 [inline]
>   rxe_cleanup_task+0x6f/0xc0 drivers/infiniband/sw/rxe/rxe_task.c:117
>   rxe_qp_do_cleanup+0x88/0x8b0 drivers/infiniband/sw/rxe/rxe_qp.c:781
>   execute_in_process_context+0x37/0x150 kernel/workqueue.c:3351
>   rxe_elem_release drivers/infiniband/sw/rxe/rxe_pool.c:206 [inline]
>   kref_put include/linux/kref.h:65 [inline]
>   __rxe_put+0x107/0x1f0 drivers/infiniband/sw/rxe/rxe_pool.c:221
>   rxe_create_qp+0x2a5/0x320 drivers/infiniband/sw/rxe/rxe_verbs.c:435
>   create_qp+0x5ac/0x960 drivers/infiniband/core/verbs.c:1233
>   ib_create_qp_kernel+0x9d/0x310 drivers/infiniband/core/verbs.c:1344
>   ib_create_qp include/rdma/ib_verbs.h:3732 [inline]
>   create_mad_qp+0x177/0x2d0 drivers/infiniband/core/mad.c:2910
>   ib_mad_port_open drivers/infiniband/core/mad.c:2991 [inline]
>   ib_mad_init_device+0xd51/0x13f0 drivers/infiniband/core/mad.c:3082
>   add_client_context+0x405/0x5e0 drivers/infiniband/core/device.c:721
>   enable_device_and_get+0x1cd/0x3b0 drivers/infiniband/core/device.c:1332
>   ib_register_device drivers/infiniband/core/device.c:1420 [inline]
>   ib_register_device+0x814/0xaf0 drivers/infiniband/core/device.c:1366
>   rxe_register_device+0x2fe/0x3b0 drivers/infiniband/sw/rxe/rxe_verbs.c:1112
>   rxe_net_add+0x8c/0xe0 drivers/infiniband/sw/rxe/rxe_net.c:521
>   rxe_newlink drivers/infiniband/sw/rxe/rxe.c:195 [inline]
>   rxe_newlink+0xa9/0xd0 drivers/infiniband/sw/rxe/rxe.c:176
>   nldev_newlink+0x32e/0x5c0 drivers/infiniband/core/nldev.c:1717
>   rdma_nl_rcv_msg+0x36d/0x690 drivers/infiniband/core/netlink.c:195
>   rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
>   rdma_nl_rcv+0x2ee/0x430 drivers/infiniband/core/netlink.c:259
>   netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
>   netlink_unicast+0x543/0x7f0 net/netlink/af_netlink.c:1345
>   netlink_sendmsg+0x917/0xe10 net/netlink/af_netlink.c:1921
>   sock_sendmsg_nosec net/socket.c:714 [inline]
>   sock_sendmsg+0xcf/0x120 net/socket.c:734
>   ____sys_sendmsg+0x6eb/0x810 net/socket.c:2492
>   ___sys_sendmsg+0xf3/0x170 net/socket.c:2546
>   __sys_sendmsg net/socket.c:2575 [inline]
>   __do_sys_sendmsg net/socket.c:2584 [inline]
>   __se_sys_sendmsg net/socket.c:2582 [inline]
>   __x64_sys_sendmsg+0x132/0x220 net/socket.c:2582
>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>   do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>   entry_SYSCALL_64_after_hwframe+0x46/0xb0
> RIP: 0033:0x7f0c6ac890e9
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f0c6be25168 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00007f0c6ad9bf60 RCX: 00007f0c6ac890e9
> RDX: 0000000000000000 RSI: 0000000020000240 RDI: 0000000000000003
> RBP: 00007f0c6ace308d R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007ffcdd7fce9f R14: 00007f0c6be25300 R15: 0000000000022000
>   </TASK>
> BUG: kernel NULL pointer dereference, address: 0000000000000000
> #PF: supervisor instruction fetch in kernel mode
> #PF: error_code(0x0010) - not-present page
> PGD 4dd1a067 P4D 4dd1a067 PUD 1ccf5067 PMD 0
> Oops: 0010 [#1] PREEMPT SMP KASAN
> CPU: 1 PID: 8344 Comm: syz-executor.4 Not tainted 5.18.0-next-20220523-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:0x0
> Code: Unable to access opcode bytes at RIP 0xffffffffffffffd6.
> RSP: 0018:ffffc9000ddf6b50 EFLAGS: 00010246
> RAX: 0000000000040000 RBX: ffff88801ae9e568 RCX: ffffc90006d16000
> RDX: 0000000000040000 RSI: ffffffff86d3e56b RDI: 0000000000000000
> RBP: ffffed10035d3cbc R08: 0000000000000001 R09: ffff88801ae9e63f
> R10: ffffed10035d3cc7 R11: 0000000000000000 R12: 0000000000000000
> R13: ffffed10035d3cbd R14: ffff88801ae9e5e0 R15: ffff88801ae9e5e8
> FS:  00007f0c6be25700(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffffffffffffd6 CR3: 0000000025396000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   <TASK>
>   __rxe_do_task+0x56/0xc0 drivers/infiniband/sw/rxe/rxe_task.c:18
>   rxe_qp_do_cleanup+0x102/0x8b0 drivers/infiniband/sw/rxe/rxe_qp.c:792
>   execute_in_process_context+0x37/0x150 kernel/workqueue.c:3351
>   rxe_elem_release drivers/infiniband/sw/rxe/rxe_pool.c:206 [inline]
>   kref_put include/linux/kref.h:65 [inline]
>   __rxe_put+0x107/0x1f0 drivers/infiniband/sw/rxe/rxe_pool.c:221
>   rxe_create_qp+0x2a5/0x320 drivers/infiniband/sw/rxe/rxe_verbs.c:435
>   create_qp+0x5ac/0x960 drivers/infiniband/core/verbs.c:1233
>   ib_create_qp_kernel+0x9d/0x310 drivers/infiniband/core/verbs.c:1344
>   ib_create_qp include/rdma/ib_verbs.h:3732 [inline]
>   create_mad_qp+0x177/0x2d0 drivers/infiniband/core/mad.c:2910
>   ib_mad_port_open drivers/infiniband/core/mad.c:2991 [inline]
>   ib_mad_init_device+0xd51/0x13f0 drivers/infiniband/core/mad.c:3082
>   add_client_context+0x405/0x5e0 drivers/infiniband/core/device.c:721
>   enable_device_and_get+0x1cd/0x3b0 drivers/infiniband/core/device.c:1332
>   ib_register_device drivers/infiniband/core/device.c:1420 [inline]
>   ib_register_device+0x814/0xaf0 drivers/infiniband/core/device.c:1366
>   rxe_register_device+0x2fe/0x3b0 drivers/infiniband/sw/rxe/rxe_verbs.c:1112
>   rxe_net_add+0x8c/0xe0 drivers/infiniband/sw/rxe/rxe_net.c:521
>   rxe_newlink drivers/infiniband/sw/rxe/rxe.c:195 [inline]
>   rxe_newlink+0xa9/0xd0 drivers/infiniband/sw/rxe/rxe.c:176
>   nldev_newlink+0x32e/0x5c0 drivers/infiniband/core/nldev.c:1717
>   rdma_nl_rcv_msg+0x36d/0x690 drivers/infiniband/core/netlink.c:195
>   rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
>   rdma_nl_rcv+0x2ee/0x430 drivers/infiniband/core/netlink.c:259
>   netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
>   netlink_unicast+0x543/0x7f0 net/netlink/af_netlink.c:1345
>   netlink_sendmsg+0x917/0xe10 net/netlink/af_netlink.c:1921
>   sock_sendmsg_nosec net/socket.c:714 [inline]
>   sock_sendmsg+0xcf/0x120 net/socket.c:734
>   ____sys_sendmsg+0x6eb/0x810 net/socket.c:2492
>   ___sys_sendmsg+0xf3/0x170 net/socket.c:2546
>   __sys_sendmsg net/socket.c:2575 [inline]
>   __do_sys_sendmsg net/socket.c:2584 [inline]
>   __se_sys_sendmsg net/socket.c:2582 [inline]
>   __x64_sys_sendmsg+0x132/0x220 net/socket.c:2582
>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>   do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>   entry_SYSCALL_64_after_hwframe+0x46/0xb0
> RIP: 0033:0x7f0c6ac890e9
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f0c6be25168 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00007f0c6ad9bf60 RCX: 00007f0c6ac890e9
> RDX: 0000000000000000 RSI: 0000000020000240 RDI: 0000000000000003
> RBP: 00007f0c6ace308d R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007ffcdd7fce9f R14: 00007f0c6be25300 R15: 0000000000022000
>   </TASK>
> Modules linked in:
> CR2: 0000000000000000
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:0x0
> Code: Unable to access opcode bytes at RIP 0xffffffffffffffd6.
> RSP: 0018:ffffc9000ddf6b50 EFLAGS: 00010246
> RAX: 0000000000040000 RBX: ffff88801ae9e568 RCX: ffffc90006d16000
> RDX: 0000000000040000 RSI: ffffffff86d3e56b RDI: 0000000000000000
> RBP: ffffed10035d3cbc R08: 0000000000000001 R09: ffff88801ae9e63f
> R10: ffffed10035d3cc7 R11: 0000000000000000 R12: 0000000000000000
> R13: ffffed10035d3cbd R14: ffff88801ae9e5e0 R15: ffff88801ae9e5e8
> FS:  00007f0c6be25700(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffffffffffffd6 CR3: 0000000025396000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

