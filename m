Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9047F588D50
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Aug 2022 15:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233926AbiHCNkZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Aug 2022 09:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233526AbiHCNkY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 3 Aug 2022 09:40:24 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA505FE9
        for <linux-rdma@vger.kernel.org>; Wed,  3 Aug 2022 06:40:23 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id c14-20020a056e020bce00b002dd1cb7ce4dso10556873ilu.22
        for <linux-rdma@vger.kernel.org>; Wed, 03 Aug 2022 06:40:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=JBAejNxVt67YabHPJXP/y31UMn3ag+IABmrC+RpE9OM=;
        b=kfcdbvtISXMnTM/uhCDN9av82zn+dJZGN3LA2tYa/HKYvkbnEZP4ndMQmxIReFaGuR
         z1RgWnuxcp10PLhYqxE2tnStaGK318rm7dsPtlfE6fP0eY8Ro4ckowEJp6OqdiisYyob
         NuqHVihR2o/loh0ZQP8NglTbQ/YyNXgQM2ZQiIto1UEk3wwcKkye3IGSZCYr3tNTol6K
         YQvOViZqey7Sye/Wm8cPZRZalfcByEwqkdaleo9XfzsDWFLkU+4RlCHqOKDPOGXC/2P4
         mGvCq3g5WqHW/sgyta5WOA+mRZfRw77BznuwBLgW7AopmJuUlj6w57UVs7ARsmpxUH05
         QVPg==
X-Gm-Message-State: AJIora8GMFwTEHfUiXIRSkxB8IcKNwMAG6x4rau1AS3ulgTIOkuDUlKZ
        Z+fLKyq0zzIufxItZqUUb8VPCEeujgFQ67pJnx7p0j86657a
X-Google-Smtp-Source: AGRyM1vKn6C1vLX/G6Ri0XAQZkvZt0wAtHciHpTPEMab2Mww96EfhC5Mhlc84rwCmjPFAfWVl7EyfNdqXVRGIxma2Om/8H9Lzt2V
MIME-Version: 1.0
X-Received: by 2002:a02:1607:0:b0:33f:3af8:61e3 with SMTP id
 a7-20020a021607000000b0033f3af861e3mr10638206jaa.307.1659534023102; Wed, 03
 Aug 2022 06:40:23 -0700 (PDT)
Date:   Wed, 03 Aug 2022 06:40:23 -0700
In-Reply-To: <0000000000006ed46805dfaded18@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f0980c05e5565f2d@google.com>
Subject: Re: [syzbot] INFO: trying to register non-static key in rxe_cleanup_task
From:   syzbot <syzbot+833061116fa28df97f3b@syzkaller.appspotmail.com>
To:     haris.iqbal@ionos.com, jgg@nvidia.com, jgg@ziepe.ca,
        leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, rpearsonhpe@gmail.com,
        syzkaller-bugs@googlegroups.com, yanjun.zhu@linux.dev,
        zyjzyj2000@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    cb71b93c2dc3 Add linux-next specific files for 20220628
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=152d1832080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=badbc1adb2d582eb
dashboard link: https://syzkaller.appspot.com/bug?extid=833061116fa28df97f3b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13bdcf3c080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+833061116fa28df97f3b@syzkaller.appspotmail.com

infiniband syz2: set active
infiniband syz2: added gre0
INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
CPU: 0 PID: 3736 Comm: syz-executor.1 Not tainted 5.19.0-rc4-next-20220628-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 assign_lock_key kernel/locking/lockdep.c:979 [inline]
 register_lock_class+0xf30/0x1130 kernel/locking/lockdep.c:1292
 __lock_acquire+0x10a/0x5660 kernel/locking/lockdep.c:4932
 lock_acquire kernel/locking/lockdep.c:5665 [inline]
 lock_acquire+0x1ab/0x570 kernel/locking/lockdep.c:5630
 __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
 _raw_spin_lock_bh+0x2f/0x40 kernel/locking/spinlock.c:178
 spin_lock_bh include/linux/spinlock.h:365 [inline]
 rxe_cleanup_task+0x6f/0xc0 drivers/infiniband/sw/rxe/rxe_task.c:117
 rxe_qp_do_cleanup+0x88/0x8b0 drivers/infiniband/sw/rxe/rxe_qp.c:781
 execute_in_process_context+0x37/0x150 kernel/workqueue.c:3359
 rxe_elem_release drivers/infiniband/sw/rxe/rxe_pool.c:206 [inline]
 kref_put include/linux/kref.h:65 [inline]
 __rxe_put+0x107/0x1f0 drivers/infiniband/sw/rxe/rxe_pool.c:221
 rxe_create_qp+0x2a5/0x320 drivers/infiniband/sw/rxe/rxe_verbs.c:435
 create_qp+0x5ac/0x960 drivers/infiniband/core/verbs.c:1233
 ib_create_qp_kernel+0x9d/0x310 drivers/infiniband/core/verbs.c:1344
 ib_create_qp include/rdma/ib_verbs.h:3732 [inline]
 create_mad_qp+0x177/0x2d0 drivers/infiniband/core/mad.c:2910
 ib_mad_port_open drivers/infiniband/core/mad.c:2991 [inline]
 ib_mad_init_device+0xd51/0x13f0 drivers/infiniband/core/mad.c:3082
 add_client_context+0x405/0x5e0 drivers/infiniband/core/device.c:721
 enable_device_and_get+0x1cd/0x3b0 drivers/infiniband/core/device.c:1332
 ib_register_device drivers/infiniband/core/device.c:1420 [inline]
 ib_register_device+0x814/0xaf0 drivers/infiniband/core/device.c:1366
 rxe_register_device+0x2fe/0x3b0 drivers/infiniband/sw/rxe/rxe_verbs.c:1112
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
 ____sys_sendmsg+0x6eb/0x810 net/socket.c:2485
 ___sys_sendmsg+0xf3/0x170 net/socket.c:2539
 __sys_sendmsg net/socket.c:2568 [inline]
 __do_sys_sendmsg net/socket.c:2577 [inline]
 __se_sys_sendmsg net/socket.c:2575 [inline]
 __x64_sys_sendmsg+0x132/0x220 net/socket.c:2575
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7f5cc9289209
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f5cca378168 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f5cc939bf60 RCX: 00007f5cc9289209
RDX: 0000000000000000 RSI: 0000000020000100 RDI: 0000000000000003
RBP: 00007f5cc92e3161 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffcbec8964f R14: 00007f5cca378300 R15: 0000000000022000
 </TASK>
==================================================================
BUG: KASAN: null-ptr-deref in instrument_atomic_read_write include/linux/instrumented.h:101 [inline]
BUG: KASAN: null-ptr-deref in atomic_dec include/linux/atomic/atomic-instrumented.h:257 [inline]
BUG: KASAN: null-ptr-deref in rxe_qp_do_cleanup+0x235/0x8b0 drivers/infiniband/sw/rxe/rxe_qp.c:807
Write of size 4 at addr 00000000000001e0 by task syz-executor.1/3736

CPU: 0 PID: 3736 Comm: syz-executor.1 Not tainted 5.19.0-rc4-next-20220628-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 kasan_report+0xbe/0x1f0 mm/kasan/report.c:495
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0x13d/0x180 mm/kasan/generic.c:189
 instrument_atomic_read_write include/linux/instrumented.h:101 [inline]
 atomic_dec include/linux/atomic/atomic-instrumented.h:257 [inline]
 rxe_qp_do_cleanup+0x235/0x8b0 drivers/infiniband/sw/rxe/rxe_qp.c:807
 execute_in_process_context+0x37/0x150 kernel/workqueue.c:3359
 rxe_elem_release drivers/infiniband/sw/rxe/rxe_pool.c:206 [inline]
 kref_put include/linux/kref.h:65 [inline]
 __rxe_put+0x107/0x1f0 drivers/infiniband/sw/rxe/rxe_pool.c:221
 rxe_create_qp+0x2a5/0x320 drivers/infiniband/sw/rxe/rxe_verbs.c:435
 create_qp+0x5ac/0x960 drivers/infiniband/core/verbs.c:1233
 ib_create_qp_kernel+0x9d/0x310 drivers/infiniband/core/verbs.c:1344
 ib_create_qp include/rdma/ib_verbs.h:3732 [inline]
 create_mad_qp+0x177/0x2d0 drivers/infiniband/core/mad.c:2910
 ib_mad_port_open drivers/infiniband/core/mad.c:2991 [inline]
 ib_mad_init_device+0xd51/0x13f0 drivers/infiniband/core/mad.c:3082
 add_client_context+0x405/0x5e0 drivers/infiniband/core/device.c:721
 enable_device_and_get+0x1cd/0x3b0 drivers/infiniband/core/device.c:1332
 ib_register_device drivers/infiniband/core/device.c:1420 [inline]
 ib_register_device+0x814/0xaf0 drivers/infiniband/core/device.c:1366
 rxe_register_device+0x2fe/0x3b0 drivers/infiniband/sw/rxe/rxe_verbs.c:1112
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
 ____sys_sendmsg+0x6eb/0x810 net/socket.c:2485
 ___sys_sendmsg+0xf3/0x170 net/socket.c:2539
 __sys_sendmsg net/socket.c:2568 [inline]
 __do_sys_sendmsg net/socket.c:2577 [inline]
 __se_sys_sendmsg net/socket.c:2575 [inline]
 __x64_sys_sendmsg+0x132/0x220 net/socket.c:2575
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7f5cc9289209
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f5cca378168 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f5cc939bf60 RCX: 00007f5cc9289209
RDX: 0000000000000000 RSI: 0000000020000100 RDI: 0000000000000003
RBP: 00007f5cc92e3161 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffcbec8964f R14: 00007f5cca378300 R15: 0000000000022000
 </TASK>
==================================================================

