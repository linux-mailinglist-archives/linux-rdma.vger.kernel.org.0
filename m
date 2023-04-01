Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 380DC6D2DAE
	for <lists+linux-rdma@lfdr.de>; Sat,  1 Apr 2023 04:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233750AbjDACSf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 31 Mar 2023 22:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233368AbjDACSe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 31 Mar 2023 22:18:34 -0400
X-Greylist: delayed 528 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 31 Mar 2023 19:18:32 PDT
Received: from out-61.mta0.migadu.com (out-61.mta0.migadu.com [91.218.175.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F5DC67E
        for <linux-rdma@vger.kernel.org>; Fri, 31 Mar 2023 19:18:32 -0700 (PDT)
Message-ID: <095b1562-0c5e-4390-adf3-59ec0ed3e97e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1680314982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EkKgLCsHkb3KLU+7/5bEY49oBe2mnx4fK27wGk4be5g=;
        b=DIJa8NfPM0T0IKHErnnvvuSKR4n0Mrtxni3tDbZS9KIooJmizoMLrgf4JqdPeGjix5ZCJs
        YtiCQwfTeRp9KDUNmGv97Ylqkj9EBKt0rIdkx7ZEmHD5FoXvCsucSR7qPr1PET6kkpYDft
        CNRg36/jEuJwyHqVgq5K8aIeoONHX+8=
Date:   Sat, 1 Apr 2023 10:09:28 +0800
MIME-Version: 1.0
Subject: Re: [syzbot] [rdma?] INFO: trying to register non-static key in
 rxe_cleanup_task (2)
To:     syzbot <syzbot+cfcc1a3c85be15a40cba@syzkaller.appspotmail.com>,
        jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        zyjzyj2000@gmail.com
References: <0000000000003ee4ee05f5c40e99@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <0000000000003ee4ee05f5c40e99@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=2.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2023/2/28 23:14, syzbot 写道:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    982818426a0f Merge tag 'arm-fixes-6.3-1' of git://git.kern..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1194800f480000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=90a4de3f96747e3f
> dashboard link: https://syzkaller.appspot.com/bug?extid=cfcc1a3c85be15a40cba
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/225d8c8e9264/disk-98281842.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/87a9e2a89842/vmlinux-98281842.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/39bdeb741f2e/bzImage-98281842.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+cfcc1a3c85be15a40cba@syzkaller.appspotmail.com
> 
> Node 1 hugepages_total=2 hugepages_free=2 hugepages_surp=0 hugepages_size=2048kB
> 14586 total pagecache pages
> 0 pages in swap cache
> Free swap  = 0kB
> Total swap = 0kB
> 2097051 pages RAM
> 0 pages HighMem/MovableOnly
> 392145 pages reserved
> 0 pages cma reserved
> INFO: trying to register non-static key.
> The code is fine but needs lockdep annotation, or maybe
> you didn't initialize this object before use?
> turning off the locking correctness validator.
> CPU: 1 PID: 5486 Comm: syz-executor.2 Not tainted 6.2.0-syzkaller-12765-g982818426a0f #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/16/2023
> Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:88 [inline]
>   dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
>   assign_lock_key kernel/locking/lockdep.c:982 [inline]
>   register_lock_class+0xdb6/0x1120 kernel/locking/lockdep.c:1295
>   __lock_acquire+0x108/0x5d40 kernel/locking/lockdep.c:4935
>   lock_acquire kernel/locking/lockdep.c:5669 [inline]
>   lock_acquire+0x1e3/0x670 kernel/locking/lockdep.c:5634
>   __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
>   _raw_spin_lock_bh+0x33/0x40 kernel/locking/spinlock.c:178
>   spin_lock_bh include/linux/spinlock.h:355 [inline]
>   rxe_cleanup_task+0x73/0xc0 drivers/infiniband/sw/rxe/rxe_task.c:119
>   rxe_qp_do_cleanup+0x8c/0x7c0 drivers/infiniband/sw/rxe/rxe_qp.c:776
>   execute_in_process_context+0x3b/0x150 kernel/workqueue.c:3458
>   __rxe_cleanup+0x21e/0x370 drivers/infiniband/sw/rxe/rxe_pool.c:233
>   rxe_create_qp+0x2c2/0x340 drivers/infiniband/sw/rxe/rxe_verbs.c:430

It took me a lot of time to reproduce this problem. And finally I can 
reproduce this problem.

The root cause is:

In this function rxe_create_qp, if some problem occur in 
rxe_qp_init_req, rxe_init_task functions are not executed.
But error handler of rxe_create_qp still calls rxe_cleanup_task. This 
problem will occur.

static int rxe_create_qp
{
   ...
   err = rxe_qp_from_init {
         ...
         err = rxe_qp_init_req {
         ... some errors occur <---This will go to the error handler of 
rxe_create_qp
         rxe_init_task(&qp->req.task, qp, rxe_requester); <---It is not 
executed.
         rxe_init_task(&qp->comp.task, qp, rxe_completer);<---It is not 
executed.
         ...
         }
         if (err)
           goto err1;
         ...
         err = rxe_qp_init_resp{
         ...
         rxe_init_task(&qp->resp.task, qp, rxe_responder);<---It is not 
executed.
         ...
         }
         if (err)
            goto err2;
         }
         if (err)
                 goto qp_init;
...
qp_init:
         rxe_cleanup(qp);  ---> rxe_cleanup_task
         return err;
}

Zhu Yanjun

>   create_qp+0x5ac/0x970 drivers/infiniband/core/verbs.c:1233
>   ib_create_qp_kernel+0xa1/0x310 drivers/infiniband/core/verbs.c:1344
>   ib_create_qp include/rdma/ib_verbs.h:3743 [inline]
>   create_mad_qp+0x177/0x380 drivers/infiniband/core/mad.c:2905
>   ib_mad_port_open drivers/infiniband/core/mad.c:2986 [inline]
>   ib_mad_init_device+0xf40/0x1a90 drivers/infiniband/core/mad.c:3077
>   add_client_context+0x405/0x5e0 drivers/infiniband/core/device.c:721
>   enable_device_and_get+0x1cd/0x3b0 drivers/infiniband/core/device.c:1332
>   ib_register_device drivers/infiniband/core/device.c:1420 [inline]
>   ib_register_device+0x8b1/0xbc0 drivers/infiniband/core/device.c:1366
>   rxe_register_device+0x317/0x3f0 drivers/infiniband/sw/rxe/rxe_verbs.c:1096
>   rxe_net_add+0x90/0xf0 drivers/infiniband/sw/rxe/rxe_net.c:524
>   rxe_newlink+0xd5/0x140 drivers/infiniband/sw/rxe/rxe.c:195
>   nldev_newlink+0x332/0x5e0 drivers/infiniband/core/nldev.c:1731
>   rdma_nl_rcv_msg+0x371/0x6a0 drivers/infiniband/core/netlink.c:195
>   rdma_nl_rcv_skb.constprop.0.isra.0+0x2fc/0x440 drivers/infiniband/core/netlink.c:239
>   netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
>   netlink_unicast+0x547/0x7f0 net/netlink/af_netlink.c:1365
>   netlink_sendmsg+0x925/0xe30 net/netlink/af_netlink.c:1942
>   sock_sendmsg_nosec net/socket.c:722 [inline]
>   sock_sendmsg+0xde/0x190 net/socket.c:745
>   ____sys_sendmsg+0x71c/0x900 net/socket.c:2504
>   ___sys_sendmsg+0x110/0x1b0 net/socket.c:2558
>   __sys_sendmsg+0xf7/0x1c0 net/socket.c:2587
>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>   do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7fd95868c0f9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fd9594b3168 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00007fd9587abf80 RCX: 00007fd95868c0f9
> RDX: 0000000000000000 RSI: 0000000020000200 RDI: 0000000000000003
> RBP: 00007fd9586e7ae9 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007fff9db7c9ef R14: 00007fd9594b3300 R15: 0000000000022000
>   </TASK>
> infiniband syz1: Couldn't create ib_mad QP1
> infiniband syz1: Couldn't open port 1
> RDS/IB: syz1: added
> smc: adding ib device syz1 with port count 1
> smc:    ib device syz1 port 1 has pnetid
> syz-executor.2 (5486) used greatest stack depth: 22840 bytes left
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

