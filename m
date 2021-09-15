Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49EA640BD7D
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Sep 2021 04:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbhIOCE4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Sep 2021 22:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhIOCEz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Sep 2021 22:04:55 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94838C061574;
        Tue, 14 Sep 2021 19:03:37 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id k23-20020a17090a591700b001976d2db364so1089955pji.2;
        Tue, 14 Sep 2021 19:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=lNJjnkP/poN6EucwYAGHg4wNILhVqw/q5t1Cljx2oOo=;
        b=XRdGL+sMwvE3o10OzzA2iY9EtoJEgJ/12Hkd/LgAsJ4lOGSUzKLDB1tamHvA0mvAWD
         GIzk/g0zZwdcatX/cwDLHQbpWet0opbF5tF/58iRtxgrkD4ZY5rGitLMosG2DunvEBF+
         t1RfSqPH1hNJKk82bir+Q0Piz64FeIYtHWs8Lz3XY/zOIk2A/KFeLmlfzmFNtXWQCrgP
         cTQLlx6dSs3rfvqXFgMXi1ttItA6xbgvuJsolwt/BbXjyFQSuCo9inZF2pWCkAjF6io3
         LF6f0qCHckOHh31rWJUEHHRCrkRrDFukbkYxziJC0Lf8IVm6u2fSTQI+wgnN4e03obfh
         enyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=lNJjnkP/poN6EucwYAGHg4wNILhVqw/q5t1Cljx2oOo=;
        b=5MthHnvK6cYVyqI6reJejR8HYRgyPpKIGuVivxU4M3G6WYsN/6AYm/nUhRkdqCvW54
         VxzZxA5c/ZwnDPWTLUS2++BI99Dede2HKqSy56OKwTYwC8cRrkTPOyufUiLWjTwYvo1o
         1th7n6EMUPIOeLHg+8uKvotb8FFFbFbKc8AvJlk9L95iegXnmQAS92d3qc4zf8+U7um4
         IEteK64YqKw7UvaUUMOn8sLLDVE6DvqAPG+4tv+wTbBD91d+w+6EP5VhNTsJ+RRrkzWA
         GhFZXTGefZunx4dtxnZs56EzdrHfez97f5AlwIFPMnsNYKNSZfjj1IeHqTVPbr7oVaHI
         dh+A==
X-Gm-Message-State: AOAM531LXbnrdEL2/S60xBHy2hJtn7jX4WFtObYzjCrlSHxiAON7EZKy
        lGJbCb589ouChyRt92yPhgpWNf1Vz8xR8v3mcg==
X-Google-Smtp-Source: ABdhPJzjyoD5Iz+JbO/4+yDsWbWEH/gtGdpfvLsZrftiSc14lazzcp6I0LtQ5quDbD6KMV17oplSjZ4d42YKiL0mm5g=
X-Received: by 2002:a17:90a:b794:: with SMTP id m20mr5655916pjr.178.1631671416547;
 Tue, 14 Sep 2021 19:03:36 -0700 (PDT)
MIME-Version: 1.0
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Wed, 15 Sep 2021 10:03:25 +0800
Message-ID: <CACkBjsbDQOG9MCEGsbOojyMSv+ffU-PSdA-4fbHSw_8cEYZfNw@mail.gmail.com>
Subject: INFO: task hung in ib_uverbs_remove_one
To:     akpm@linux-foundation.org, jannh@google.com, joe@perches.com,
        leon@kernel.org, liweihang@huawei.com
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello,

When using Healer to fuzz the latest Linux kernel, the following crash
was triggered.

HEAD commit: 6880fa6c5660 Linux 5.15-rc1
git tree: upstream
console output:
https://drive.google.com/file/d/1cvXE8YTjJ1QBb8lPLwE_Ck4tVTNmYNM-/view?usp=sharing
kernel config: https://drive.google.com/file/d/1rUzyMbe5vcs6khA3tL9EHTLJvsUdWcgB/view?usp=sharing

Sorry, I don't have a reproducer for this crash, hope the symbolized
report can help.
If you fix this issue, please add the following tag to the commit:
Reported-by: Hao Sun <sunhao.th@gmail.com>

INFO: task kworker/u9:4:2890 blocked for more than 143 seconds.
      Not tainted 5.15.0-rc1 #16
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u9:4    state:D stack:12376 pid: 2890 ppid:     2 flags:0x00004000
Workqueue: events_unbound ib_unregister_work
Call Trace:
 context_switch kernel/sched/core.c:4940 [inline]
 __schedule+0x323/0xae0 kernel/sched/core.c:6287
 schedule+0x36/0xe0 kernel/sched/core.c:6366
 schedule_timeout+0x189/0x430 kernel/time/timer.c:1857
 do_wait_for_common kernel/sched/completion.c:85 [inline]
 __wait_for_common kernel/sched/completion.c:106 [inline]
 wait_for_common kernel/sched/completion.c:117 [inline]
 wait_for_completion+0xb4/0x110 kernel/sched/completion.c:138
 ib_uverbs_remove_one+0xec/0x260 drivers/infiniband/core/uverbs_main.c:1235
 remove_client_context+0x98/0xf0 drivers/infiniband/core/device.c:775
 disable_device+0x96/0x150 drivers/infiniband/core/device.c:1281
 __ib_unregister_device+0x4c/0xb0 drivers/infiniband/core/device.c:1474
 ib_unregister_work+0x18/0x30 drivers/infiniband/core/device.c:1585
 process_one_work+0x359/0x850 kernel/workqueue.c:2297
 worker_thread+0x41/0x4d0 kernel/workqueue.c:2444
 kthread+0x178/0x1b0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
INFO: task syz-executor:12507 blocked for more than 143 seconds.
      Not tainted 5.15.0-rc1 #16
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:13400 pid:12507 ppid: 11859 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:4940 [inline]
 __schedule+0x323/0xae0 kernel/sched/core.c:6287
 schedule+0x36/0xe0 kernel/sched/core.c:6366
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6425
 __mutex_lock_common kernel/locking/mutex.c:669 [inline]
 __mutex_lock+0x496/0xa50 kernel/locking/mutex.c:729
 rdma_dev_change_netns+0x27/0x160 drivers/infiniband/core/device.c:1621
 rdma_dev_exit_net+0x183/0x310 drivers/infiniband/core/device.c:1144
 ops_exit_list.isra.8+0x49/0x80 net/core/net_namespace.c:168
 setup_net+0x28a/0x3f0 net/core/net_namespace.c:349
 copy_net_ns+0x29b/0x360 net/core/net_namespace.c:470
 create_new_namespaces.isra.5+0x12b/0x410 kernel/nsproxy.c:110
 unshare_nsproxy_namespaces+0x80/0x100 kernel/nsproxy.c:226
 ksys_unshare+0x273/0x4d0 kernel/fork.c:3077
 __do_sys_unshare kernel/fork.c:3151 [inline]
 __se_sys_unshare kernel/fork.c:3149 [inline]
 __x64_sys_unshare+0x12/0x20 kernel/fork.c:3149
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x34/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x46ae99
RSP: 002b:00007f5bdb51cc48 EFLAGS: 00000246 ORIG_RAX: 0000000000000110
RAX: ffffffffffffffda RBX: 000000000078c210 RCX: 000000000046ae99
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000040060400
RBP: 00000000004e4809 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000078c210
R13: 0000000000000000 R14: 000000000078c210 R15: 00007ffd9ae969c0

Showing all locks held in the system:
1 lock held by khungtaskd/39:
 #0: ffffffff85a1d560 (rcu_read_lock){....}-{1:2}, at:
debug_show_all_locks+0xe/0x1a0 kernel/locking/lockdep.c:6446
3 locks held by kworker/u9:4/2890:
 #0: ffff888008c5c938 ((wq_completion)events_unbound){+.+.}-{0:0}, at:
set_work_data kernel/workqueue.c:633 [inline]
 #0: ffff888008c5c938 ((wq_completion)events_unbound){+.+.}-{0:0}, at:
set_work_pool_and_clear_pending kernel/workqueue.c:661 [inline]
 #0: ffff888008c5c938 ((wq_completion)events_unbound){+.+.}-{0:0}, at:
process_one_work+0x2a0/0x850 kernel/workqueue.c:2268
 #1: ffffc9000acebe70
((work_completion)(&device->unregistration_work)){+.+.}-{0:0}, at:
set_work_data kernel/workqueue.c:633 [inline]
 #1: ffffc9000acebe70
((work_completion)(&device->unregistration_work)){+.+.}-{0:0}, at:
set_work_pool_and_clear_pending kernel/workqueue.c:661 [inline]
 #1: ffffc9000acebe70
((work_completion)(&device->unregistration_work)){+.+.}-{0:0}, at:
process_one_work+0x2a0/0x850 kernel/workqueue.c:2268
 #2: ffff88810e230698 (&device->unregistration_lock){+.+.}-{3:3}, at:
__ib_unregister_device+0x1d/0xb0 drivers/infiniband/core/device.c:1470
1 lock held by in:imklog/6193:
 #0: ffff888105ca10f0 (&f->f_pos_lock){+.+.}-{3:3}, at:
__fdget_pos+0x55/0x60 fs/file.c:990
3 locks held by kworker/u8:4/8206:
 #0: ffff8881000ba938 ((wq_completion)netns){+.+.}-{0:0}, at:
set_work_data kernel/workqueue.c:633 [inline]
 #0: ffff8881000ba938 ((wq_completion)netns){+.+.}-{0:0}, at:
set_work_pool_and_clear_pending kernel/workqueue.c:661 [inline]
 #0: ffff8881000ba938 ((wq_completion)netns){+.+.}-{0:0}, at:
process_one_work+0x2a0/0x850 kernel/workqueue.c:2268
 #1: ffffc9000147be70 (net_cleanup_work){+.+.}-{0:0}, at:
set_work_data kernel/workqueue.c:633 [inline]
 #1: ffffc9000147be70 (net_cleanup_work){+.+.}-{0:0}, at:
set_work_pool_and_clear_pending kernel/workqueue.c:661 [inline]
 #1: ffffc9000147be70 (net_cleanup_work){+.+.}-{0:0}, at:
process_one_work+0x2a0/0x850 kernel/workqueue.c:2268
 #2: ffffffff85e92d50 (pernet_ops_rwsem){++++}-{3:3}, at:
cleanup_net+0x4f/0x4e0 net/core/net_namespace.c:553
2 locks held by syz-executor/12507:
 #0: ffffffff85e92d50 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x140/0x360 net/core/net_namespace.c:466
 #1: ffff88810e230698 (&device->unregistration_lock){+.+.}-{3:3}, at:
rdma_dev_change_netns+0x27/0x160 drivers/infiniband/core/device.c:1621
1 lock held by syz-executor/16545:

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 39 Comm: khungtaskd Not tainted 5.15.0-rc1 #16
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x8d/0xcf lib/dump_stack.c:106
 nmi_cpu_backtrace+0x1e9/0x210 lib/nmi_backtrace.c:105
 nmi_trigger_cpumask_backtrace+0x120/0x180 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:210 [inline]
 watchdog+0x4e1/0x980 kernel/hung_task.c:295
 kthread+0x178/0x1b0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
Sending NMI from CPU 1 to CPUs 0,2-3:
NMI backtrace for cpu 0
CPU: 0 PID: 3017 Comm: systemd-journal Not tainted 5.15.0-rc1 #16
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
RIP: 0010:check_preemption_disabled+0x4/0x110 lib/smp_processor_id.c:13
Code: 42 bb 06 fd eb 9d 0f 1f 44 00 00 0f 0b e9 dc fe ff ff 0f 1f 44
00 00 0f 0b e9 0f ff ff ff cc cc cc cc cc cc cc cc 41 55 41 54 <49> 89
f4 55 48 89 fd 53 0f 1f 44 00 00 65 8b 1d f0 6f dc 7b 65 8b
RSP: 0018:ffffc90000897ee8 EFLAGS: 00000093
RAX: 0000000000000000 RBX: ffff888012f92240 RCX: 0000000000000000
RDX: ffff888012f92240 RSI: ffffffff8555af8e RDI: ffffffff852d80e6
RBP: ffffc90000897f58 R08: 0000000000000001 R09: 0000000000000001
R10: ffffc90000897ea0 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  00007fb31e95d8c0(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb31bef4018 CR3: 000000000fc2f000 CR4: 0000000000750ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 fpregs_assert_state_consistent+0x2f/0x70 arch/x86/kernel/fpu/core.c:435
 arch_exit_to_user_mode_prepare arch/x86/include/asm/entry-common.h:56 [inline]
 exit_to_user_mode_prepare+0x55/0x280 kernel/entry/common.c:211
 __syscall_exit_to_user_mode_work kernel/entry/common.c:291 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:302
 do_syscall_64+0x40/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fb31deed840
Code: 73 01 c3 48 8b 0d 68 77 20 00 f7 d8 64 89 01 48 83 c8 ff c3 66
0f 1f 44 00 00 83 3d 89 bb 20 00 00 75 10 b8 02 00 00 00 0f 05 <48> 3d
01 f0 ff ff 73 31 c3 48 83 ec 08 e8 1e f6 ff ff 48 89 04 24
RSP: 002b:00007ffc66c57f58 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: fffffffffffffffe RBX: 00007ffc66c58260 RCX: 00007fb31deed840
RDX: 00000000000001a0 RSI: 0000000000080042 RDI: 00005597bfc64930
RBP: 000000000000000d R08: 000000000000c0c1 R09: 00000000ffffffff
R10: 0000000000000069 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00005597bfc56040 R14: 00007ffc66c58220 R15: 00005597bfc646e0
NMI backtrace for cpu 2 skipped: idling at native_safe_halt
arch/x86/include/asm/irqflags.h:51 [inline]
NMI backtrace for cpu 2 skipped: idling at arch_safe_halt
arch/x86/include/asm/irqflags.h:89 [inline]
NMI backtrace for cpu 2 skipped: idling at default_idle+0xb/0x10
arch/x86/kernel/process.c:716
NMI backtrace for cpu 3
CPU: 3 PID: 16545 Comm: syz-executor Not tainted 5.15.0-rc1 #16
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
RIP: 0010:do_syscall_x64 arch/x86/entry/common.c:49 [inline]
RIP: 0010:do_syscall_64+0x1c/0xb0 arch/x86/entry/common.c:80
Code: 48 c7 43 50 da ff ff ff eb 8d 0f 1f 40 00 55 48 89 e5 53 48 89
fb 66 90 48 63 f6 48 89 df e8 0b 59 00 00 3d c0 01 00 00 77 4d <89> c2
48 81 fa c1 01 00 00 48 19 d2 21 d0 48 89 df ff 14 c5 e0 02
RSP: 0018:ffffc90003d1bf40 EFLAGS: 00000283
RAX: 0000000000000084 RBX: ffffc90003d1bf58 RCX: ffffc9000c5e3000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff853cbec6
RBP: ffffc90003d1bf48 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  00007fee445c8700(0000) GS:ffff88813dd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000003 CR3: 0000000114c84000 CR4: 0000000000750ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x200000ca
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 98 4a 2a e9 2c b8 b6 4c 0f 05 <bf> 00
00 40 00 c4 a3 7b f0 c5 01 41 e2 e9 c4 22 e9 aa bb 3c 00 00
RSP: 002b:00007fee445c7ba8 EFLAGS: 00000a87 ORIG_RAX: 0000000000000084
RAX: ffffffffffffffda RBX: 0000000000000009 RCX: 00000000200000ca
RDX: 0000000000004c01 RSI: 0000000000000003 RDI: 0000000000400000
RBP: 00000000000000af R08: 0000000000000005 R09: 0000000000000006
R10: 0000000000000007 R11: 0000000000000a87 R12: 000000000000000b
R13: 000000000000000c R14: 000000000000000d R15: 00007ffd839e8810
----------------
Code disassembly (best guess):
   0: 42 bb 06 fd eb 9d    rex.X mov $0x9debfd06,%ebx
   6: 0f 1f 44 00 00        nopl   0x0(%rax,%rax,1)
   b: 0f 0b                ud2
   d: e9 dc fe ff ff        jmpq   0xfffffeee
  12: 0f 1f 44 00 00        nopl   0x0(%rax,%rax,1)
  17: 0f 0b                ud2
  19: e9 0f ff ff ff        jmpq   0xffffff2d
  1e: cc                    int3
  1f: cc                    int3
  20: cc                    int3
  21: cc                    int3
  22: cc                    int3
  23: cc                    int3
  24: cc                    int3
  25: cc                    int3
  26: 41 55                push   %r13
  28: 41 54                push   %r12
* 2a: 49 89 f4              mov    %rsi,%r12 <-- trapping instruction
  2d: 55                    push   %rbp
  2e: 48 89 fd              mov    %rdi,%rbp
  31: 53                    push   %rbx
  32: 0f 1f 44 00 00        nopl   0x0(%rax,%rax,1)
  37: 65 8b 1d f0 6f dc 7b mov    %gs:0x7bdc6ff0(%rip),%ebx        # 0x7bdc702e
  3e: 65                    gs
  3f: 8b                    .byte 0x8b
