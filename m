Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB172647F45
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Dec 2022 09:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiLIIdk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Dec 2022 03:33:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiLIIdj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Dec 2022 03:33:39 -0500
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05AA2935D
        for <linux-rdma@vger.kernel.org>; Fri,  9 Dec 2022 00:33:37 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id y5-20020a056602120500b006cf628c14ddso1735650iot.15
        for <linux-rdma@vger.kernel.org>; Fri, 09 Dec 2022 00:33:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O6Ac0Wnu4CmfbheuAUxnbR8nGtcttoRlSYyWR+77izE=;
        b=oKYjtWxGWidYydyS7AuA24/eJdmQRt/pO8QZc02yDgvotvlq9y5lf/DOOT8pbNWEZV
         3HG18Sf9tG9fFhUiEGG0N8VfpQIjsfqOkPUsVJi5FmuQtx7vM0BLFQ98hkIWuI6GVCOe
         GhxISh3dtsvzPV6/Lt3ZXQauuQtAw9dfT7iAO+QD6IaYvz7y3NH4XrxaH6u01uKuRPI6
         jkG+m9eixiiSjwzPNdHNwvkLR6GUAg4JnhfO51w7grx3utn9IsslakIHwYmk2AT1SnfL
         J5cfBR/4vTxH/qmjJnvHm06yeXjaTjm+kIC4hCuiiQjHJQQxLMzLms4rCUeG3AB3C6P5
         W7XQ==
X-Gm-Message-State: ANoB5pnwRZ9BXZCbRDhEBBRxRkJjWYz2jw+vXO3QzlYJqx0ei7KAsgsL
        ojzi7Bx8AkJJojr0IMTU9nSXdyIIfwU6ZJZEscdp8LQBOY5X
X-Google-Smtp-Source: AA0mqf4ms9WrDVHLNril2XjRwbkh571KQeML8q+O2kdmAGKGG9A0iPLtCSLncoZKobEdgSQ9dH4B8w+c14KRXGmJC+oFMZpM4Iai
MIME-Version: 1.0
X-Received: by 2002:a02:c603:0:b0:387:bdd5:a05d with SMTP id
 i3-20020a02c603000000b00387bdd5a05dmr33531434jan.136.1670574817295; Fri, 09
 Dec 2022 00:33:37 -0800 (PST)
Date:   Fri, 09 Dec 2022 00:33:37 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008e452905ef610270@google.com>
Subject: [syzbot] WARNING: refcount bug in put_gid_ndev
From:   syzbot <syzbot+8d0a099c8a6d1e4e601c@syzkaller.appspotmail.com>
To:     avihaih@nvidia.com, jgg@ziepe.ca, kuba@kernel.org, leon@kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, wangjianli@cdjrlc.com
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

Hello,

syzbot found the following issue on:

HEAD commit:    591cd61541b9 Add linux-next specific files for 20221207
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=130a3b83880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8b2d3e63e054c24f
dashboard link: https://syzkaller.appspot.com/bug?extid=8d0a099c8a6d1e4e601c
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/bc862c01ec56/disk-591cd615.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8f9b93f8ed2f/vmlinux-591cd615.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9d5cb636d548/bzImage-591cd615.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8d0a099c8a6d1e4e601c@syzkaller.appspotmail.com

------------[ cut here ]------------
refcount_t: decrement hit 0; leaking memory.
WARNING: CPU: 1 PID: 5735 at lib/refcount.c:31 refcount_warn_saturate+0x1d7/0x1f0 lib/refcount.c:31
Modules linked in:
CPU: 1 PID: 5735 Comm: kworker/u4:13 Not tainted 6.1.0-rc8-next-20221207-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Workqueue: bat_events batadv_nc_worker
RIP: 0010:refcount_warn_saturate+0x1d7/0x1f0 lib/refcount.c:31
Code: 05 5a 60 51 0a 01 e8 35 0a b5 05 0f 0b e9 d3 fe ff ff e8 6c 9b 75 fd 48 c7 c7 c0 6d a6 8a c6 05 37 60 51 0a 01 e8 16 0a b5 05 <0f> 0b e9 b4 fe ff ff 48 89 ef e8 5a b5 c3 fd e9 5c fe ff ff 0f 1f
RSP: 0000:ffffc900001e0ce8 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff88802803d7c0 RSI: ffffffff8166b1dc RDI: fffff5200003c18f
RBP: ffff88807bcf6600 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000100 R11: 0000000000000001 R12: 1ffff9200003c1a2
R13: 0000000000000000 R14: ffff88807bcf6600 R15: 0000000000000007
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f3f259b9c80 CR3: 000000000c48e000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 __refcount_dec include/linux/refcount.h:344 [inline]
 refcount_dec include/linux/refcount.h:359 [inline]
 ref_tracker_free+0x539/0x6b0 lib/ref_tracker.c:118
 netdev_tracker_free include/linux/netdevice.h:4039 [inline]
 netdev_put include/linux/netdevice.h:4056 [inline]
 dev_put include/linux/netdevice.h:4082 [inline]
 put_gid_ndev+0x5a/0xc0 drivers/infiniband/core/cache.c:233
 rcu_do_batch kernel/rcu/tree.c:2244 [inline]
 rcu_core+0x81f/0x1980 kernel/rcu/tree.c:2504
 __do_softirq+0x1fb/0xadc kernel/softirq.c:571
 invoke_softirq kernel/softirq.c:445 [inline]
 __irq_exit_rcu+0x123/0x180 kernel/softirq.c:650
 irq_exit_rcu+0x9/0x20 kernel/softirq.c:662
 sysvec_apic_timer_interrupt+0x97/0xc0 arch/x86/kernel/apic/apic.c:1107
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:649
RIP: 0010:lock_acquire+0x227/0x630 kernel/locking/lockdep.c:5636
Code: 53 9e 7e 83 f8 01 0f 85 3a 03 00 00 9c 58 f6 c4 02 0f 85 25 03 00 00 48 83 7c 24 08 00 74 01 fb 48 b8 00 00 00 00 00 fc ff df <48> 01 c3 48 c7 03 00 00 00 00 48 c7 43 08 00 00 00 00 48 8b 84 24
RSP: 0000:ffffc9000b177b90 EFLAGS: 00000206
RAX: dffffc0000000000 RBX: 1ffff9200162ef75 RCX: 98121ce21b20504b
RDX: 1ffff11005007c3e RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: ffffffff9132eac7
R10: fffffbfff2265d58 R11: 0000000000000000 R12: 0000000000000002
R13: 0000000000000000 R14: ffffffff8c791900 R15: 0000000000000000
 rcu_lock_acquire include/linux/rcupdate.h:325 [inline]
 rcu_read_lock include/linux/rcupdate.h:764 [inline]
 batadv_nc_purge_orig_hash net/batman-adv/network-coding.c:408 [inline]
 batadv_nc_worker+0x131/0xfa0 net/batman-adv/network-coding.c:719
 process_one_work+0x9bf/0x1710 kernel/workqueue.c:2289
 worker_thread+0x669/0x1090 kernel/workqueue.c:2436
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
----------------
Code disassembly (best guess):
   0:	53                   	push   %rbx
   1:	9e                   	sahf
   2:	7e 83                	jle    0xffffff87
   4:	f8                   	clc
   5:	01 0f                	add    %ecx,(%rdi)
   7:	85 3a                	test   %edi,(%rdx)
   9:	03 00                	add    (%rax),%eax
   b:	00 9c 58 f6 c4 02 0f 	add    %bl,0xf02c4f6(%rax,%rbx,2)
  12:	85 25 03 00 00 48    	test   %esp,0x48000003(%rip)        # 0x4800001b
  18:	83 7c 24 08 00       	cmpl   $0x0,0x8(%rsp)
  1d:	74 01                	je     0x20
  1f:	fb                   	sti
  20:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  27:	fc ff df
* 2a:	48 01 c3             	add    %rax,%rbx <-- trapping instruction
  2d:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
  34:	48 c7 43 08 00 00 00 	movq   $0x0,0x8(%rbx)
  3b:	00
  3c:	48                   	rex.W
  3d:	8b                   	.byte 0x8b
  3e:	84                   	.byte 0x84
  3f:	24                   	.byte 0x24


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
