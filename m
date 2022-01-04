Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 907BA484098
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jan 2022 12:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbiADLOY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Jan 2022 06:14:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbiADLOY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 4 Jan 2022 06:14:24 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC65FC061761;
        Tue,  4 Jan 2022 03:14:23 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id y130so82628165ybe.8;
        Tue, 04 Jan 2022 03:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=EuQ+RDDyvgO/XiehWa0EB1W1Ey7ZO/ENGVHTtG/xS9g=;
        b=RmX1tFEtkpUXFJvwtXlnuOmlOuj8xVEjFUNvhguV/cmQkwlnEutjD3wpOTudWys5U3
         ovDn2aOQkZrT1z+ciJAsKC6QGYBlpnTrX/8tkDrMsYNySN38yYZGei81xnWHpeh5ng08
         HTPI/xNz/yUlb5pIPOWTCTiJGBFwSeQyU4hjqs6DcuxJNZWHCv3GdWCiPyH7Dc0nrgRO
         K44unYW/d5ycXRZKNq5WKdIovchNDSwt/v3yYesiei342gY2SVBehWSvjHbUobRrkNEH
         EHUcHZZ95IdKO4FJmc1Po6OsYXxLGY37ncVcv4W9B9s9+mRaTVQIJ6jSN6Y3Yv48L+Db
         YPFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=EuQ+RDDyvgO/XiehWa0EB1W1Ey7ZO/ENGVHTtG/xS9g=;
        b=2c2341Hx/0WuyCWtuTSlhvXuHde4ZU/kQedNbLbtKG0Bv1RdSVry3f7tIjIyT1SIYA
         SuT3ADkRThl+s9tS21oeTBTvft2rXrez40+dzWOOVkQ2R0kot3rOAJmN4scD9mHlpSzo
         EaFAJ5vfUt0GIdnTO/X1ncMe11WRTjwBgFsRAl/i8N2ZG41QoDjg5n22euIGHVjvCgBE
         Ij7qV3JWamdvOMWeTDxH3AdSLaG6moJsiy+8c4woIRJIYJfmRrNDNdYDOBMmlHSGbKVa
         t51UsVSxjspEGpV+gWag1C28rpOpCmWTRZp4CNndBFNWTR+yXVcwxP2oOw97NhVur0ID
         1w1Q==
X-Gm-Message-State: AOAM533KIJRxCdiMrBB0ymo+/qz6D84ZnjZ6tuWta0eGhk61Ai8OI3LR
        TdM8fR6668S+gEwm0DPBoFGLLl5EQCHYKqLFZyk=
X-Google-Smtp-Source: ABdhPJzDEQiOwOqNiwhDrfTaekzotoQPMaF47GJLIbPDoTmjZkp9XbR5D0Hu8ZJWNH7YtCIZsiuhyI0iYRi60VJ36hE=
X-Received: by 2002:a25:44c5:: with SMTP id r188mr60390475yba.160.1641294862015;
 Tue, 04 Jan 2022 03:14:22 -0800 (PST)
MIME-Version: 1.0
From:   kvartet <xyru1999@gmail.com>
Date:   Tue, 4 Jan 2022 19:14:10 +0800
Message-ID: <CAFkrUsjvvP=4xC+pY3TdfZDf4qQi9hL2o2EUw6_1C1m7-V0uRA@mail.gmail.com>
Subject: INFO: task hung in rdma_dev_exit_net
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Anand Khoje <anand.a.khoje@oracle.com>,
        Haakon Bugge <haakon.bugge@oracle.com>,
        Gal Pressman <galpress@amazon.com>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Bloch <mbloch@nvidia.com>,
        Parav Pandit <parav@nvidia.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Cc:     sunhao.th@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello,

When using Syzkaller to fuzz the latest Linux kernel, the following
crash was triggered.

HEAD commit: a7904a538933 Linux 5.16-rc6
git tree: upstream
console output: https://paste.ubuntu.com/p/7Jn9S46sR2/plain/
kernel config: https://paste.ubuntu.com/p/FDDNHDxtwz/plain/

Sorry, I don't have a reproducer for this crash, hope the symbolized
report can help.

If you fix this issue, please add the following tag to the commit:
Reported-by: Yiru Xu <xyru1999@gmail.com>

INFO: task kworker/u8:7:13982 blocked for more than 143 seconds.
      Not tainted 5.16.0-rc6 #9
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u8:7    state:D stack:26880 pid:13982 ppid:     2 flags:0x00004000
Workqueue: netns cleanup_net
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4972 [inline]
 __schedule+0xcd9/0x2530 kernel/sched/core.c:6253
 schedule+0xd2/0x260 kernel/sched/core.c:6326
 rwsem_down_write_slowpath+0x664/0x1190 kernel/locking/rwsem.c:1151
 __down_write_common kernel/locking/rwsem.c:1268 [inline]
 __down_write_common kernel/locking/rwsem.c:1265 [inline]
 __down_write kernel/locking/rwsem.c:1277 [inline]
 down_write+0x135/0x150 kernel/locking/rwsem.c:1524
 rdma_dev_exit_net+0x16b/0x4f0 drivers/infiniband/core/device.c:1122
 ops_exit_list.isra.0+0xa8/0x150 net/core/net_namespace.c:168
 cleanup_net+0x511/0xa90 net/core/net_namespace.c:593
 process_one_work+0x9df/0x16d0 kernel/workqueue.c:2298
 worker_thread+0x90/0xed0 kernel/workqueue.c:2445
 kthread+0x405/0x4f0 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>
INFO: task syz-executor.5:24935 blocked for more than 143 seconds.
      Not tainted 5.16.0-rc6 #9
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.5  state:D stack:25712 pid:24935 ppid: 24830 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4972 [inline]
 __schedule+0xcd9/0x2530 kernel/sched/core.c:6253
 schedule+0xd2/0x260 kernel/sched/core.c:6326
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6385
 __mutex_lock_common kernel/locking/mutex.c:680 [inline]
 __mutex_lock+0xc48/0x1610 kernel/locking/mutex.c:740
 add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
 rdma_dev_init_net+0x28b/0x480 drivers/infiniband/core/device.c:1184
 ops_init+0xaf/0x420 net/core/net_namespace.c:140
 setup_net+0x415/0xa40 net/core/net_namespace.c:326
 copy_net_ns+0x2d9/0x660 net/core/net_namespace.c:470
 create_new_namespaces.isra.0+0x3cb/0xae0 kernel/nsproxy.c:110
 copy_namespaces+0x391/0x450 kernel/nsproxy.c:178
 copy_process+0x2d37/0x73e0 kernel/fork.c:2194
 kernel_clone+0xe7/0x10c0 kernel/fork.c:2582
 __do_sys_clone3+0x1c9/0x2e0 kernel/fork.c:2857
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f781da1489d
RSP: 002b:00007f781c322c28 EFLAGS: 00000246 ORIG_RAX: 00000000000001b3
RAX: ffffffffffffffda RBX: 00007f781db341d0 RCX: 00007f781da1489d
RDX: 0000000000000000 RSI: 0000000000000058 RDI: 0000000020000340
RBP: 00007f781da8100d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff413eb89f R14: 00007f781db341d0 R15: 00007f781c322dc0
 </TASK>
INFO: task syz-executor.5:25023 blocked for more than 143 seconds.
      Not tainted 5.16.0-rc6 #9
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.5  state:D stack:25648 pid:25023 ppid: 24853 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4972 [inline]
 __schedule+0xcd9/0x2530 kernel/sched/core.c:6253
 schedule+0xd2/0x260 kernel/sched/core.c:6326
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6385
 __mutex_lock_common kernel/locking/mutex.c:680 [inline]
 __mutex_lock+0xc48/0x1610 kernel/locking/mutex.c:740
 add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
 rdma_dev_init_net+0x28b/0x480 drivers/infiniband/core/device.c:1184
 ops_init+0xaf/0x420 net/core/net_namespace.c:140
 setup_net+0x415/0xa40 net/core/net_namespace.c:326
 copy_net_ns+0x2d9/0x660 net/core/net_namespace.c:470
 create_new_namespaces.isra.0+0x3cb/0xae0 kernel/nsproxy.c:110
 copy_namespaces+0x391/0x450 kernel/nsproxy.c:178
 copy_process+0x2d37/0x73e0 kernel/fork.c:2194
 kernel_clone+0xe7/0x10c0 kernel/fork.c:2582
 __do_sys_clone3+0x1c9/0x2e0 kernel/fork.c:2857
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f781da1489d
RSP: 002b:00007f781c322c28 EFLAGS: 00000246 ORIG_RAX: 00000000000001b3
RAX: ffffffffffffffda RBX: 00007f781db341d0 RCX: 00007f781da1489d
RDX: 0000000000000000 RSI: 0000000000000058 RDI: 0000000020000340
RBP: 00007f781da8100d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff413eb89f R14: 00007f781db341d0 R15: 00007f781c322dc0
 </TASK>
INFO: task syz-executor.5:25063 blocked for more than 143 seconds.
      Not tainted 5.16.0-rc6 #9
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.5  state:D stack:25648 pid:25063 ppid: 24935 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4972 [inline]
 __schedule+0xcd9/0x2530 kernel/sched/core.c:6253
 schedule+0xd2/0x260 kernel/sched/core.c:6326
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6385
 __mutex_lock_common kernel/locking/mutex.c:680 [inline]
 __mutex_lock+0xc48/0x1610 kernel/locking/mutex.c:740
 add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
 rdma_dev_init_net+0x28b/0x480 drivers/infiniband/core/device.c:1184
 ops_init+0xaf/0x420 net/core/net_namespace.c:140
 setup_net+0x415/0xa40 net/core/net_namespace.c:326
 copy_net_ns+0x2d9/0x660 net/core/net_namespace.c:470
 create_new_namespaces.isra.0+0x3cb/0xae0 kernel/nsproxy.c:110
 copy_namespaces+0x391/0x450 kernel/nsproxy.c:178
 copy_process+0x2d37/0x73e0 kernel/fork.c:2194
 kernel_clone+0xe7/0x10c0 kernel/fork.c:2582
 __do_sys_clone3+0x1c9/0x2e0 kernel/fork.c:2857
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f781da1489d
RSP: 002b:00007f781c322c28 EFLAGS: 00000246 ORIG_RAX: 00000000000001b3
RAX: ffffffffffffffda RBX: 00007f781db341d0 RCX: 00007f781da1489d
RDX: 0000000000000000 RSI: 0000000000000058 RDI: 0000000020000340
RBP: 00007f781da8100d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff413eb89f R14: 00007f781db341d0 R15: 00007f781c322dc0
 </TASK>
INFO: task syz-executor.5:25149 blocked for more than 143 seconds.
      Not tainted 5.16.0-rc6 #9
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.5  state:D stack:25200 pid:25149 ppid: 24782 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4972 [inline]
 __schedule+0xcd9/0x2530 kernel/sched/core.c:6253
 schedule+0xd2/0x260 kernel/sched/core.c:6326
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6385
 __mutex_lock_common kernel/locking/mutex.c:680 [inline]
 __mutex_lock+0xc48/0x1610 kernel/locking/mutex.c:740
 add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
 rdma_dev_init_net+0x28b/0x480 drivers/infiniband/core/device.c:1184
 ops_init+0xaf/0x420 net/core/net_namespace.c:140
 setup_net+0x415/0xa40 net/core/net_namespace.c:326
 copy_net_ns+0x2d9/0x660 net/core/net_namespace.c:470
 create_new_namespaces.isra.0+0x3cb/0xae0 kernel/nsproxy.c:110
 copy_namespaces+0x391/0x450 kernel/nsproxy.c:178
 copy_process+0x2d37/0x73e0 kernel/fork.c:2194
 kernel_clone+0xe7/0x10c0 kernel/fork.c:2582
 __do_sys_clone3+0x1c9/0x2e0 kernel/fork.c:2857
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f781da1489d
RSP: 002b:00007f781c322c28 EFLAGS: 00000246 ORIG_RAX: 00000000000001b3
RAX: ffffffffffffffda RBX: 00007f781db341d0 RCX: 00007f781da1489d
RDX: 0000000000000000 RSI: 0000000000000058 RDI: 0000000020000340
RBP: 00007f781da8100d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff413eb89f R14: 00007f781db341d0 R15: 00007f781c322dc0
 </TASK>
INFO: task syz-executor.5:25234 blocked for more than 143 seconds.
      Not tainted 5.16.0-rc6 #9
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.5  state:D stack:25264 pid:25234 ppid: 24853 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4972 [inline]
 __schedule+0xcd9/0x2530 kernel/sched/core.c:6253
 schedule+0xd2/0x260 kernel/sched/core.c:6326
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6385
 __mutex_lock_common kernel/locking/mutex.c:680 [inline]
 __mutex_lock+0xc48/0x1610 kernel/locking/mutex.c:740
 add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
 rdma_dev_init_net+0x28b/0x480 drivers/infiniband/core/device.c:1184
 ops_init+0xaf/0x420 net/core/net_namespace.c:140
 setup_net+0x415/0xa40 net/core/net_namespace.c:326
 copy_net_ns+0x2d9/0x660 net/core/net_namespace.c:470
 create_new_namespaces.isra.0+0x3cb/0xae0 kernel/nsproxy.c:110
 copy_namespaces+0x391/0x450 kernel/nsproxy.c:178
 copy_process+0x2d37/0x73e0 kernel/fork.c:2194
 kernel_clone+0xe7/0x10c0 kernel/fork.c:2582
 __do_sys_clone3+0x1c9/0x2e0 kernel/fork.c:2857
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f781da1489d
RSP: 002b:00007f781c322c28 EFLAGS: 00000246 ORIG_RAX: 00000000000001b3
RAX: ffffffffffffffda RBX: 00007f781db341d0 RCX: 00007f781da1489d
RDX: 0000000000000000 RSI: 0000000000000058 RDI: 0000000020000340
RBP: 00007f781da8100d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff413eb89f R14: 00007f781db341d0 R15: 00007f781c322dc0
 </TASK>
INFO: task syz-executor.5:25259 blocked for more than 143 seconds.
      Not tainted 5.16.0-rc6 #9
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.5  state:D stack:25712 pid:25259 ppid: 25149 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4972 [inline]
 __schedule+0xcd9/0x2530 kernel/sched/core.c:6253
 schedule+0xd2/0x260 kernel/sched/core.c:6326
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6385
 __mutex_lock_common kernel/locking/mutex.c:680 [inline]
 __mutex_lock+0xc48/0x1610 kernel/locking/mutex.c:740
 add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
 rdma_dev_init_net+0x28b/0x480 drivers/infiniband/core/device.c:1184
 ops_init+0xaf/0x420 net/core/net_namespace.c:140
 setup_net+0x415/0xa40 net/core/net_namespace.c:326
 copy_net_ns+0x2d9/0x660 net/core/net_namespace.c:470
 create_new_namespaces.isra.0+0x3cb/0xae0 kernel/nsproxy.c:110
 copy_namespaces+0x391/0x450 kernel/nsproxy.c:178
 copy_process+0x2d37/0x73e0 kernel/fork.c:2194
 kernel_clone+0xe7/0x10c0 kernel/fork.c:2582
 __do_sys_clone3+0x1c9/0x2e0 kernel/fork.c:2857
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f781da1489d
RSP: 002b:00007f781c322c28 EFLAGS: 00000246 ORIG_RAX: 00000000000001b3
RAX: ffffffffffffffda RBX: 00007f781db341d0 RCX: 00007f781da1489d
RDX: 0000000000000000 RSI: 0000000000000058 RDI: 0000000020000340
RBP: 00007f781da8100d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff413eb89f R14: 00007f781db341d0 R15: 00007f781c322dc0
 </TASK>
INFO: task syz-executor.5:25282 blocked for more than 143 seconds.
      Not tainted 5.16.0-rc6 #9
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.5  state:D stack:25552 pid:25282 ppid: 25023 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4972 [inline]
 __schedule+0xcd9/0x2530 kernel/sched/core.c:6253
 schedule+0xd2/0x260 kernel/sched/core.c:6326
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6385
 __mutex_lock_common kernel/locking/mutex.c:680 [inline]
 __mutex_lock+0xc48/0x1610 kernel/locking/mutex.c:740
 add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
 rdma_dev_init_net+0x28b/0x480 drivers/infiniband/core/device.c:1184
 ops_init+0xaf/0x420 net/core/net_namespace.c:140
 setup_net+0x415/0xa40 net/core/net_namespace.c:326
 copy_net_ns+0x2d9/0x660 net/core/net_namespace.c:470
 create_new_namespaces.isra.0+0x3cb/0xae0 kernel/nsproxy.c:110
 copy_namespaces+0x391/0x450 kernel/nsproxy.c:178
 copy_process+0x2d37/0x73e0 kernel/fork.c:2194
 kernel_clone+0xe7/0x10c0 kernel/fork.c:2582
 __do_sys_clone3+0x1c9/0x2e0 kernel/fork.c:2857
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f781da1489d
RSP: 002b:00007f781c322c28 EFLAGS: 00000246 ORIG_RAX: 00000000000001b3
RAX: ffffffffffffffda RBX: 00007f781db341d0 RCX: 00007f781da1489d
RDX: 0000000000000000 RSI: 0000000000000058 RDI: 0000000020000340
RBP: 00007f781da8100d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff413eb89f R14: 00007f781db341d0 R15: 00007f781c322dc0
 </TASK>
INFO: task syz-executor.5:25306 blocked for more than 143 seconds.
      Not tainted 5.16.0-rc6 #9
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.5  state:D stack:25648 pid:25306 ppid: 24935 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4972 [inline]
 __schedule+0xcd9/0x2530 kernel/sched/core.c:6253
 schedule+0xd2/0x260 kernel/sched/core.c:6326
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6385
 __mutex_lock_common kernel/locking/mutex.c:680 [inline]
 __mutex_lock+0xc48/0x1610 kernel/locking/mutex.c:740
 add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
 rdma_dev_init_net+0x28b/0x480 drivers/infiniband/core/device.c:1184
 ops_init+0xaf/0x420 net/core/net_namespace.c:140
 setup_net+0x415/0xa40 net/core/net_namespace.c:326
 copy_net_ns+0x2d9/0x660 net/core/net_namespace.c:470
 create_new_namespaces.isra.0+0x3cb/0xae0 kernel/nsproxy.c:110
 copy_namespaces+0x391/0x450 kernel/nsproxy.c:178
 copy_process+0x2d37/0x73e0 kernel/fork.c:2194
 kernel_clone+0xe7/0x10c0 kernel/fork.c:2582
 __do_sys_clone3+0x1c9/0x2e0 kernel/fork.c:2857
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f781da1489d
RSP: 002b:00007f781c322c28 EFLAGS: 00000246 ORIG_RAX: 00000000000001b3
RAX: ffffffffffffffda RBX: 00007f781db341d0 RCX: 00007f781da1489d
RDX: 0000000000000000 RSI: 0000000000000058 RDI: 0000000020000340
RBP: 00007f781da8100d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff413eb89f R14: 00007f781db341d0 R15: 00007f781c322dc0
 </TASK>
INFO: task syz-executor.5:25619 blocked for more than 143 seconds.
      Not tainted 5.16.0-rc6 #9
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.5  state:D stack:25920 pid:25619 ppid: 24853 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4972 [inline]
 __schedule+0xcd9/0x2530 kernel/sched/core.c:6253
 schedule+0xd2/0x260 kernel/sched/core.c:6326
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6385
 __mutex_lock_common kernel/locking/mutex.c:680 [inline]
 __mutex_lock+0xc48/0x1610 kernel/locking/mutex.c:740
 add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
 rdma_dev_init_net+0x28b/0x480 drivers/infiniband/core/device.c:1184
 ops_init+0xaf/0x420 net/core/net_namespace.c:140
 setup_net+0x415/0xa40 net/core/net_namespace.c:326
 copy_net_ns+0x2d9/0x660 net/core/net_namespace.c:470
 create_new_namespaces.isra.0+0x3cb/0xae0 kernel/nsproxy.c:110
 copy_namespaces+0x391/0x450 kernel/nsproxy.c:178
 copy_process+0x2d37/0x73e0 kernel/fork.c:2194
 kernel_clone+0xe7/0x10c0 kernel/fork.c:2582
 __do_sys_clone3+0x1c9/0x2e0 kernel/fork.c:2857
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f781da1489d
RSP: 002b:00007f781c322c28 EFLAGS: 00000246 ORIG_RAX: 00000000000001b3
RAX: ffffffffffffffda RBX: 00007f781db341d0 RCX: 00007f781da1489d
RDX: 0000000000000000 RSI: 0000000000000058 RDI: 0000000020000340
RBP: 00007f781da8100d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff413eb89f R14: 00007f781db341d0 R15: 00007f781c322dc0
 </TASK>

Showing all locks held in the system:
2 locks held by kworker/u9:0/9:
 #0: ffff888010c71138 ((wq_completion)events_unbound){+.+.}-{0:0}, at:
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888010c71138 ((wq_completion)events_unbound){+.+.}-{0:0}, at:
arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888010c71138 ((wq_completion)events_unbound){+.+.}-{0:0}, at:
atomic_long_set include/linux/atomic/atomic-instrumented.h:1198
[inline]
 #0: ffff888010c71138 ((wq_completion)events_unbound){+.+.}-{0:0}, at:
set_work_data kernel/workqueue.c:635 [inline]
 #0: ffff888010c71138 ((wq_completion)events_unbound){+.+.}-{0:0}, at:
set_work_pool_and_clear_pending kernel/workqueue.c:662 [inline]
 #0: ffff888010c71138 ((wq_completion)events_unbound){+.+.}-{0:0}, at:
process_one_work+0x8c3/0x16d0 kernel/workqueue.c:2269
 #1: ffffc900006c7dc8 ((kfence_timer).work){+.+.}-{0:0}, at:
process_one_work+0x8f7/0x16d0 kernel/workqueue.c:2273
3 locks held by kworker/2:0/28:
1 lock held by khungtaskd/39:
 #0: ffffffff8bb80e20 (rcu_read_lock){....}-{1:2}, at:
debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6458
1 lock held by systemd-journal/3050:
 #0: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #0: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #0: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
3 locks held by kworker/2:2/3061:
 #0: ffff88810b931538 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at:
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88810b931538 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at:
arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88810b931538 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at:
atomic_long_set include/linux/atomic/atomic-instrumented.h:1198
[inline]
 #0: ffff88810b931538 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at:
set_work_data kernel/workqueue.c:635 [inline]
 #0: ffff88810b931538 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at:
set_work_pool_and_clear_pending kernel/workqueue.c:662 [inline]
 #0: ffff88810b931538 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at:
process_one_work+0x8c3/0x16d0 kernel/workqueue.c:2269
 #1: ffffc9000114fdc8 ((addr_chk_work).work){+.+.}-{0:0}, at:
process_one_work+0x8f7/0x16d0 kernel/workqueue.c:2273
 #2: ffffffff8d302968 (rtnl_mutex){+.+.}-{3:3}, at:
addrconf_verify_work+0xa/0x20 net/ipv6/addrconf.c:4595
1 lock held by systemd-timesyn/3128:
 #0: ffff8880163be940 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_invalidate_lock_shared include/linux/fs.h:838 [inline]
 #0: ffff8880163be940 (mapping.invalidate_lock){++++}-{3:3}, at:
page_cache_ra_unbounded+0x1bc/0x950 mm/readahead.c:194
2 locks held by sd-resolve/3130:
 #0: ffff8880163be940 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_invalidate_lock_shared include/linux/fs.h:838 [inline]
 #0: ffff8880163be940 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_fault+0x1537/0x2400 mm/filemap.c:3096
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
1 lock held by in:imklog/6749:
 #0: ffff8880163bd550 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_invalidate_lock_shared include/linux/fs.h:838 [inline]
 #0: ffff8880163bd550 (mapping.invalidate_lock){++++}-{3:3}, at:
page_cache_ra_unbounded+0x1bc/0x950 mm/readahead.c:194
2 locks held by syz-fuzzer/6687:
 #0: ffff88802754c160 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_invalidate_lock_shared include/linux/fs.h:838 [inline]
 #0: ffff88802754c160 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_fault+0x1537/0x2400 mm/filemap.c:3096
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
1 lock held by syz-fuzzer/6691:
 #0: ffff88802754c160 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_invalidate_lock_shared include/linux/fs.h:838 [inline]
 #0: ffff88802754c160 (mapping.invalidate_lock){++++}-{3:3}, at:
page_cache_ra_unbounded+0x1bc/0x950 mm/readahead.c:194
2 locks held by syz-fuzzer/6701:
 #0: ffff88802754c160 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_invalidate_lock_shared include/linux/fs.h:838 [inline]
 #0: ffff88802754c160 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_fault+0x1537/0x2400 mm/filemap.c:3096
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
1 lock held by syz-fuzzer/6702:
 #0: ffff88802754c160 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_invalidate_lock_shared include/linux/fs.h:838 [inline]
 #0: ffff88802754c160 (mapping.invalidate_lock){++++}-{3:3}, at:
page_cache_ra_unbounded+0x1bc/0x950 mm/readahead.c:194
2 locks held by syz-fuzzer/6781:
 #0: ffff88802754c160 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_invalidate_lock_shared include/linux/fs.h:838 [inline]
 #0: ffff88802754c160 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_fault+0x1537/0x2400 mm/filemap.c:3096
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #1: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
4 locks held by kworker/0:5/11179:
4 locks held by kworker/u8:7/13982:
 #0: ffff8881000ad938 ((wq_completion)netns){+.+.}-{0:0}, at:
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8881000ad938 ((wq_completion)netns){+.+.}-{0:0}, at:
arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff8881000ad938 ((wq_completion)netns){+.+.}-{0:0}, at:
atomic_long_set include/linux/atomic/atomic-instrumented.h:1198
[inline]
 #0: ffff8881000ad938 ((wq_completion)netns){+.+.}-{0:0}, at:
set_work_data kernel/workqueue.c:635 [inline]
 #0: ffff8881000ad938 ((wq_completion)netns){+.+.}-{0:0}, at:
set_work_pool_and_clear_pending kernel/workqueue.c:662 [inline]
 #0: ffff8881000ad938 ((wq_completion)netns){+.+.}-{0:0}, at:
process_one_work+0x8c3/0x16d0 kernel/workqueue.c:2269
 #1: ffffc9000f13fdc8 (net_cleanup_work){+.+.}-{0:0}, at:
process_one_work+0x8f7/0x16d0 kernel/workqueue.c:2273
 #2: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
cleanup_net+0x9b/0xa90 net/core/net_namespace.c:555
 #3: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_exit_net+0x16b/0x4f0 drivers/infiniband/core/device.c:1122
3 locks held by syz-executor.5/24782:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/24830:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
2 locks held by syz-executor.5/24853:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d302968 (rtnl_mutex){+.+.}-{3:3}, at:
wg_netns_pre_exit+0x17/0x210 drivers/net/wireguard/device.c:403
4 locks held by syz-executor.5/24935:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
3 locks held by syz-executor.5/24975:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
4 locks held by syz-executor.5/25023:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/25063:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
3 locks held by syz-executor.5/25121:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
4 locks held by syz-executor.5/25149:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
3 locks held by syz-executor.5/25185:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/25208:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
4 locks held by syz-executor.5/25234:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/25259:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/25282:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/25306:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
3 locks held by syz-executor.5/25329:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/25351:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/25427:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/25492:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/25537:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/25571:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/25595:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
4 locks held by syz-executor.5/25619:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/25650:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/25673:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/25701:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/25725:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/25749:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/25777:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/25804:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/25828:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/25851:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
3 locks held by syz-executor.5/25877:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/25901:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/25924:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/25948:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/25972:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/26023:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/26063:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/26112:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/26146:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/26178:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/26206:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/26234:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/26258:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
4 locks held by syz-executor.5/26279:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/26306:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/26336:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/26364:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/26386:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/26412:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/26436:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/26473:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/26508:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/26545:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/26565:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/26611:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/26643:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/26673:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/26721:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/26726:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/26754:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/26779:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
3 locks held by syz-executor.5/26801:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/26829:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/26854:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/26877:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/26901:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/26928:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/26949:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/26980:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/27004:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/27044:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/27083:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/27129:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/27163:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/27198:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/27225:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/27250:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/27287:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/27319:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/27359:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/27386:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/27425:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/27438:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/27484:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/27515:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/27565:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/27610:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/27659:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/27697:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
6 locks held by syz-executor.5/27726:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
 #4: ffff888049a75210 (&rxe->usdev_lock){+.+.}-{3:3}, at:
rxe_query_port+0x129/0x2d0 drivers/infiniband/sw/rxe/rxe_verbs.c:37
 #5: ffffffff8d302968 (rtnl_mutex){+.+.}-{3:3}, at:
ib_get_eth_speed+0xd1/0x560 drivers/infiniband/core/verbs.c:1903
4 locks held by syz-executor.5/27757:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/27796:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/27818:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/27847:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/27891:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/27921:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/27944:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/27968:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/28004:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/28015:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/28051:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/28103:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/28154:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/28201:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/28239:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/28305:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/28348:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/28372:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/28407:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/28434:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/28487:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/28548:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/28620:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/28688:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/28698:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/28727:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/28777:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/28850:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/28874:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/28897:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/28920:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/28943:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/28966:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/28989:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/29010:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/29072:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/29100:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
3 locks held by syz-executor.5/29146:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/29170:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/29194:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/29218:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/29243:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/29267:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/29302:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/29325:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/29348:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/29372:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/29395:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/29418:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/29441:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/29464:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/29487:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/29510:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/29533:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/29556:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/29575:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/29602:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/29628:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/29652:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/29679:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/29696:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/29721:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/29744:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/29767:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/29788:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/29811:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/29836:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/29859:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/29882:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/29905:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/29924:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/29951:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/29974:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/29997:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/30020:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/30043:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/30064:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/30089:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/30114:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/30131:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/30158:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/30181:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/30201:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/30227:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/30250:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/30273:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/30294:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/30318:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/30338:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/30365:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/30411:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/30434:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/30465:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
2 locks held by syz-executor.5/30476:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d302968 (rtnl_mutex){+.+.}-{3:3}, at:
register_nexthop_notifier+0x17/0x70 net/ipv4/nexthop.c:3619
3 locks held by syz-executor.5/30503:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d302968 (rtnl_mutex){+.+.}-{3:3}, at:
ip_tunnel_init_net+0x310/0xa20 net/ipv4/ip_tunnel.c:1069
 #2: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #2: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #2: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
4 locks held by syz-executor.5/30526:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/30549:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/30572:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/30595:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/30614:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/30641:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/30660:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/30687:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/30712:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/30731:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/30756:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/30779:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/30802:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/30825:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/30846:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/30871:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/30894:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/30919:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/30940:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/30963:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/30986:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/31009:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/31032:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/31055:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/31078:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/31112:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/31122:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/31147:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/31168:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/31193:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/31216:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/31239:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/31262:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/31285:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/31308:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/31329:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/31350:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/31377:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/31400:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/31421:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/31446:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/31467:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/31492:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/31515:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/31538:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/31559:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/31584:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/31607:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/31628:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/31653:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/31672:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/31699:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/31718:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/31745:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/31768:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/31791:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/31814:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/31837:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/31860:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/31879:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/31906:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/31929:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/31952:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/31973:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/31996:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/32021:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/32044:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/32067:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/32090:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/32113:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/32136:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/32159:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/32180:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/32205:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/32228:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/32251:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/32274:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/32297:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/32320:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/32352:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/32362:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/32408:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.1/32428:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/32466:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/32500:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/32542:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/32564:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff888049a74fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
3 locks held by syz-executor.5/32583:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/32612:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/32637:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/32661:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/32684:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/32719:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/32742:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/32765:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/322:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/358:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/364:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/391:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/414:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/437:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/460:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/483:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/506:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/529:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/552:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/573:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/600:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/625:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/646:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/671:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/692:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/717:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/740:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/763:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/789:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/809:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/836:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/859:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/882:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/910:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/944:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/968:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/993:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/1023:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/1054:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/1079:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/1107:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/1124:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/1149:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/1173:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/1197:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/1221:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/1245:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/1268:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/1296:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/1324:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/1342:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/1367:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/1390:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/1423:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/1432:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/1459:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/1500:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/1501:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/1524:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/1551:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/1574:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/1597:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/1621:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/1644:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/1665:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/1684:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/1699:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/1736:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/1755:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/1774:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/1809:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/1824:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/1843:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/1875:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/1898:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/1919:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/1940:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/1963:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/1988:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/2018:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/2033:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/2069:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/2104:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/2124:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/2153:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/2179:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/2208:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/2235:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/2266:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/2290:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/2321:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/2336:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/2372:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/2403:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/2431:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/2454:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/2477:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/2500:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/2529:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/2544:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/2569:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/2592:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/2637:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/2683:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/2718:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/2727:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/2754:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/2777:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/2801:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183

=============================================

NMI backtrace for cpu 3
CPU: 3 PID: 39 Comm: khungtaskd Not tainted 5.16.0-rc6 #9
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 nmi_cpu_backtrace.cold+0x47/0x144 lib/nmi_backtrace.c:111
 nmi_trigger_cpumask_backtrace+0x1a1/0x1e0 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:210 [inline]
 watchdog+0xcc8/0x1010 kernel/hung_task.c:295
 kthread+0x405/0x4f0 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>
Sending NMI from CPU 3 to CPUs 0-2:
NMI backtrace for cpu 0
CPU: 0 PID: 10 Comm: kworker/u8:1 Not tainted 5.16.0-rc6 #9
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Workqueue: bat_events batadv_nc_worker
RIP: 0010:hlock_class kernel/locking/lockdep.c:194 [inline]
RIP: 0010:check_wait_context kernel/locking/lockdep.c:4725 [inline]
RIP: 0010:__lock_acquire+0x6c0/0x57e0 kernel/locking/lockdep.c:4977
Code: 9d 18 0a 00 00 0f 8d 9d 00 00 00 48 8b 0c 24 48 63 c3 48 8d 04
80 48 8d 2c c1 48 8d 7d 20 48 89 fa 48 c1 ea 03 42 0f b6 14 32 <84> d2
74 09 80 fa 03 0f 8e e4 2a 00 00 0f b7 55 20 66 81 e2 ff 1f
RSP: 0018:ffffc900006d7a80 EFLAGS: 00000012
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff8880116126e0
RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff888011612700
RBP: ffff8880116126e0 R08: 1ffff110022c24e5 R09: 0000000000000000
R10: ffffffff8ff70947 R11: fffffbfff1fee128 R12: 0000000000000004
R13: ffff888011611cc0 R14: dffffc0000000000 R15: 0000000000000007
FS:  0000000000000000(0000) GS:ffff888063e00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004665e0 CR3: 000000000b88e000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 lock_acquire kernel/locking/lockdep.c:5637 [inline]
 lock_acquire+0x1ab/0x520 kernel/locking/lockdep.c:5602
 rcu_lock_acquire include/linux/rcupdate.h:268 [inline]
 rcu_read_lock include/linux/rcupdate.h:688 [inline]
 batadv_nc_purge_orig_hash net/batman-adv/network-coding.c:412 [inline]
 batadv_nc_worker+0x114/0x770 net/batman-adv/network-coding.c:723
 process_one_work+0x9df/0x16d0 kernel/workqueue.c:2298
 worker_thread+0x90/0xed0 kernel/workqueue.c:2445
 kthread+0x405/0x4f0 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>
NMI backtrace for cpu 1 skipped: idling at native_safe_halt
arch/x86/include/asm/irqflags.h:51 [inline]
NMI backtrace for cpu 1 skipped: idling at arch_safe_halt
arch/x86/include/asm/irqflags.h:89 [inline]
NMI backtrace for cpu 1 skipped: idling at default_idle+0xb/0x10
arch/x86/kernel/process.c:733
NMI backtrace for cpu 2
CPU: 2 PID: 28 Comm: kworker/2:0 Not tainted 5.16.0-rc6 #9
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Workqueue: events_freezable_power_ disk_events_workfn
RIP: 0010:__kasan_check_read+0x4/0x10 mm/kasan/shadow.c:31
Code: 42 07 48 85 db 0f 85 39 a4 43 07 48 83 c4 60 5b 5d 41 5c 41 5d
c3 c3 e9 39 a5 43 07 cc cc cc cc cc cc cc cc cc cc 48 8b 0c 24 <89> f6
31 d2 e9 03 fa ff ff 0f 1f 00 48 8b 0c 24 89 f6 ba 01 00 00
RSP: 0018:ffffc9000082f000 EFLAGS: 00000056
RAX: 0000000000000000 RBX: 0000000000000007 RCX: ffffffff815c27f3
RDX: 0000000000000004 RSI: 0000000000000008 RDI: ffffffff8ff70940
RBP: ffff8880116ac418 R08: 1ffff110022d5882 R09: fffffbfff1fee129
R10: 0000000000000001 R11: fffffbfff1fee128 R12: 0000000000000003
R13: ffff8880116ab980 R14: dffffc0000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff888063f00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004665e0 CR3: 0000000017fe7000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 instrument_atomic_read include/linux/instrumented.h:71 [inline]
 test_bit include/asm-generic/bitops/instrumented-non-atomic.h:134 [inline]
 __lock_acquire+0x1193/0x57e0 kernel/locking/lockdep.c:4997
 lock_acquire kernel/locking/lockdep.c:5637 [inline]
 lock_acquire+0x1ab/0x520 kernel/locking/lockdep.c:5602
 rcu_lock_acquire include/linux/rcupdate.h:268 [inline]
 rcu_read_lock include/linux/rcupdate.h:688 [inline]
 list_lru_count_one+0x61/0x370 mm/list_lru.c:187
 list_lru_shrink_count include/linux/list_lru.h:123 [inline]
 super_cache_count+0x149/0x2d0 fs/super.c:147
 do_shrink_slab+0x7e/0xbe0 mm/vmscan.c:720
 shrink_slab mm/vmscan.c:933 [inline]
 shrink_slab+0x17c/0x6f0 mm/vmscan.c:906
 shrink_node_memcgs mm/vmscan.c:3131 [inline]
 shrink_node+0x883/0x1df0 mm/vmscan.c:3252
 shrink_zones mm/vmscan.c:3485 [inline]
 do_try_to_free_pages+0x4f6/0x1440 mm/vmscan.c:3541
 try_to_free_pages+0x2a6/0x760 mm/vmscan.c:3776
 __perform_reclaim mm/page_alloc.c:4588 [inline]
 __alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 __alloc_pages_slowpath.constprop.0+0x807/0x21b0 mm/page_alloc.c:5007
 __alloc_pages+0x5ab/0x6e0 mm/page_alloc.c:5382
 alloc_pages+0x115/0x240 mm/mempolicy.c:2191
 bio_copy_kern block/blk-map.c:449 [inline]
 blk_rq_map_kern+0x4db/0x750 block/blk-map.c:640
 __scsi_execute+0x4b4/0x5f0 drivers/scsi/scsi_lib.c:229
 scsi_execute_req include/scsi/scsi_device.h:470 [inline]
 sr_get_events drivers/scsi/sr.c:214 [inline]
 sr_check_events+0x184/0xa70 drivers/scsi/sr.c:254
 cdrom_update_events drivers/cdrom/cdrom.c:1490 [inline]
 cdrom_check_events+0x5f/0x100 drivers/cdrom/cdrom.c:1500
 sr_block_check_events+0x1ac/0x2c0 drivers/scsi/sr.c:607
 disk_check_events+0xc0/0x380 block/disk-events.c:193
 process_one_work+0x9df/0x16d0 kernel/workqueue.c:2298
 worker_thread+0x90/0xed0 kernel/workqueue.c:2445
 kthread+0x405/0x4f0 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>
----------------
Code disassembly (best guess):
   0: 9d                    popfq
   1: 18 0a                sbb    %cl,(%rdx)
   3: 00 00                add    %al,(%rax)
   5: 0f 8d 9d 00 00 00    jge    0xa8
   b: 48 8b 0c 24          mov    (%rsp),%rcx
   f: 48 63 c3              movslq %ebx,%rax
  12: 48 8d 04 80          lea    (%rax,%rax,4),%rax
  16: 48 8d 2c c1          lea    (%rcx,%rax,8),%rbp
  1a: 48 8d 7d 20          lea    0x20(%rbp),%rdi
  1e: 48 89 fa              mov    %rdi,%rdx
  21: 48 c1 ea 03          shr    $0x3,%rdx
  25: 42 0f b6 14 32        movzbl (%rdx,%r14,1),%edx
* 2a: 84 d2                test   %dl,%dl <-- trapping instruction
  2c: 74 09                je     0x37
  2e: 80 fa 03              cmp    $0x3,%dl
  31: 0f 8e e4 2a 00 00    jle    0x2b1b
  37: 0f b7 55 20          movzwl 0x20(%rbp),%edx
  3b: 66 81 e2 ff 1f        and    $0x1fff,%dx




Best Regards,
Yiru
