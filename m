Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C509484082
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jan 2022 12:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbiADLLR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Jan 2022 06:11:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiADLLR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 4 Jan 2022 06:11:17 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B37C061761;
        Tue,  4 Jan 2022 03:11:16 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id o185so79912980ybo.12;
        Tue, 04 Jan 2022 03:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=dN0FvnFGsngaC9OeFuJer7Ga5iYsBAKAL6ACJIOhADU=;
        b=HodNA+xDFxxRnz04+RhPd7itwc1KNLsadIz+sOEcf498YyLEXGeNAonk8fUZ+Hk7Th
         UA9GM3PsvYfCy8mAMtu5M1jT/hbfcDhIjsVSvawI13PTFHkNK+340lt0R0Vih8X9h3J0
         26CbGeMv4reAMjHtpBwzIBs8BXlKx4db6WeqyfZvfJmU9rHLlJxWiVIrhUEtROP3X+jj
         GfxrQy7n44+kfblL0o7bUcK23LRRoiF/rPQLtP3U4QyLkR0xI4CqxG60NjkZ2qQYV4rU
         m4FmZXY3/qDKCI1GX2ukQUxV3LzAvAC+WEFVrguNDmiECCLxZskK3LGiVc1RtZwZLPh7
         7huw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=dN0FvnFGsngaC9OeFuJer7Ga5iYsBAKAL6ACJIOhADU=;
        b=kSlKDw2ouJ4GE2IyJvq0S2emS4q1NGAg5b62ovHLpml5mduvcUm998/piAByNzAPvi
         /+H/HwD+gnY9X7ffQOIn43fLwg9nE+nsCRtpjrFKFelDI7HJwtbxNiVgIPXND2zukjoR
         7XyN1/4xwnI7BxOfEeNAJwgveDoNdVuCNQQQ2VHfUri/diB9ZdlXCHzpS1Ez4jSGj+Vd
         dymWclVT2r82PgNhQRTLtETmFcH1kMkohI0Pq8HwKBd3cgNdYPCb870uMO2cSCY3bEOi
         /3aSr04m9xE4L2FYPRzNnKjWUBHlnVcojHTrVlA/oqrM8lztG34qdgnIURqUTgydSDOi
         /U/g==
X-Gm-Message-State: AOAM532VxGMqUEyRFqJO7OPTPXqGouZ+ZTEVfmU/mYRHFBEKwukQz0BY
        OYEZFxbbCKpPyJBqE1qf4kd/6JG2v8KNTXzNPPShPizOi9rVSHN7
X-Google-Smtp-Source: ABdhPJwCFIPt/XEa1+6jJrsmcOERuanjLDk36pLt0gm2p6wZTlC0Po9saAxeMrCEXQnJfR8FTSMzSD3Pt9ZMcba6hq4=
X-Received: by 2002:a25:9c44:: with SMTP id x4mr48175162ybo.84.1641294675231;
 Tue, 04 Jan 2022 03:11:15 -0800 (PST)
MIME-Version: 1.0
From:   kvartet <xyru1999@gmail.com>
Date:   Tue, 4 Jan 2022 19:11:04 +0800
Message-ID: <CAFkrUsizocCypDTb059euzP9g0WEq+MOsjYEOZRpk17-=eDW_g@mail.gmail.com>
Subject: INFO: task hung in add_one_compat_dev
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Anand Khoje <anand.a.khoje@oracle.com>,
        Gal Pressman <galpress@amazon.com>,
        Haakon Bugge <haakon.bugge@oracle.com>,
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
console output: https://paste.ubuntu.com/p/b6z4q5NnV6/plain/
kernel config: https://paste.ubuntu.com/p/FDDNHDxtwz/plain/

Sorry, I don't have a reproducer for this crash, hope the symbolized
report can help.

If you fix this issue, please add the following tag to the commit:
Reported-by: Yiru Xu <xyru1999@gmail.com>


INFO: task syz-executor.5:32436 blocked for more than 143 seconds.
      Not tainted 5.16.0-rc6 #9
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.5  state:D stack:24768 pid:32436 ppid:  6788 flags:0x00004000
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
RIP: 0033:0x7ff4fe91489d
RSP: 002b:00007ff4fd285c28 EFLAGS: 00000246 ORIG_RAX: 00000000000001b3
RAX: ffffffffffffffda RBX: 00007ff4fea33f60 RCX: 00007ff4fe91489d
RDX: 0000000000000000 RSI: 0000000000000058 RDI: 0000000020000440
RBP: 00007ff4fe98100d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff3b67e98f R14: 00007ff4fea33f60 R15: 00007ff4fd285dc0
 </TASK>
INFO: task syz-executor.5:32460 blocked for more than 143 seconds.
      Not tainted 5.16.0-rc6 #9
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.5  state:D stack:25568 pid:32460 ppid:  6788 flags:0x00004000
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
RIP: 0033:0x7ff4fe91489d
RSP: 002b:00007ff4fd285c28 EFLAGS: 00000246 ORIG_RAX: 00000000000001b3
RAX: ffffffffffffffda RBX: 00007ff4fea33f60 RCX: 00007ff4fe91489d
RDX: 0000000000000000 RSI: 0000000000000058 RDI: 0000000020000440
RBP: 00007ff4fe98100d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff3b67e98f R14: 00007ff4fea33f60 R15: 00007ff4fd285dc0
 </TASK>
INFO: task syz-executor.5:32484 blocked for more than 143 seconds.
      Not tainted 5.16.0-rc6 #9
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.5  state:D stack:25552 pid:32484 ppid: 32436 flags:0x00004000
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
RIP: 0033:0x7ff4fe91489d
RSP: 002b:00007ff4fd285c28 EFLAGS: 00000246 ORIG_RAX: 00000000000001b3
RAX: ffffffffffffffda RBX: 00007ff4fea33f60 RCX: 00007ff4fe91489d
RDX: 0000000000000000 RSI: 0000000000000058 RDI: 0000000020000440
RBP: 00007ff4fe98100d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff3b67e98f R14: 00007ff4fea33f60 R15: 00007ff4fd285dc0
 </TASK>
INFO: task syz-executor.5:32507 blocked for more than 143 seconds.
      Not tainted 5.16.0-rc6 #9
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.5  state:D stack:25472 pid:32507 ppid:  6788 flags:0x00004000
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
RIP: 0033:0x7ff4fe91489d
RSP: 002b:00007ff4fd285c28 EFLAGS: 00000246 ORIG_RAX: 00000000000001b3
RAX: ffffffffffffffda RBX: 00007ff4fea33f60 RCX: 00007ff4fe91489d
RDX: 0000000000000000 RSI: 0000000000000058 RDI: 0000000020000440
RBP: 00007ff4fe98100d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff3b67e98f R14: 00007ff4fea33f60 R15: 00007ff4fd285dc0
 </TASK>
INFO: task syz-executor.5:32530 blocked for more than 143 seconds.
      Not tainted 5.16.0-rc6 #9
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.5  state:D stack:25472 pid:32530 ppid: 32460 flags:0x00000000
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
RIP: 0033:0x7ff4fe91489d
RSP: 002b:00007ff4fd285c28 EFLAGS: 00000246 ORIG_RAX: 00000000000001b3
RAX: ffffffffffffffda RBX: 00007ff4fea33f60 RCX: 00007ff4fe91489d
RDX: 0000000000000000 RSI: 0000000000000058 RDI: 0000000020000440
RBP: 00007ff4fe98100d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff3b67e98f R14: 00007ff4fea33f60 R15: 00007ff4fd285dc0
 </TASK>
INFO: task syz-executor.5:32553 blocked for more than 143 seconds.
      Not tainted 5.16.0-rc6 #9
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.5  state:D stack:25568 pid:32553 ppid: 32436 flags:0x00004000
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
RIP: 0033:0x7ff4fe91489d
RSP: 002b:00007ff4fd285c28 EFLAGS: 00000246 ORIG_RAX: 00000000000001b3
RAX: ffffffffffffffda RBX: 00007ff4fea33f60 RCX: 00007ff4fe91489d
RDX: 0000000000000000 RSI: 0000000000000058 RDI: 0000000020000440
RBP: 00007ff4fe98100d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff3b67e98f R14: 00007ff4fea33f60 R15: 00007ff4fd285dc0
 </TASK>
INFO: task syz-executor.5:32664 blocked for more than 143 seconds.
      Not tainted 5.16.0-rc6 #9
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.5  state:D stack:25424 pid:32664 ppid: 32507 flags:0x00004000
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
RIP: 0033:0x7ff4fe91489d
RSP: 002b:00007ff4fd285c28 EFLAGS: 00000246 ORIG_RAX: 00000000000001b3
RAX: ffffffffffffffda RBX: 00007ff4fea33f60 RCX: 00007ff4fe91489d
RDX: 0000000000000000 RSI: 0000000000000058 RDI: 0000000020000440
RBP: 00007ff4fe98100d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff3b67e98f R14: 00007ff4fea33f60 R15: 00007ff4fd285dc0
 </TASK>
INFO: task syz-executor.5:32704 blocked for more than 143 seconds.
      Not tainted 5.16.0-rc6 #9
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.5  state:D stack:25552 pid:32704 ppid: 32530 flags:0x00004000
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
RIP: 0033:0x7ff4fe91489d
RSP: 002b:00007ff4fd285c28 EFLAGS: 00000246 ORIG_RAX: 00000000000001b3
RAX: ffffffffffffffda RBX: 00007ff4fea33f60 RCX: 00007ff4fe91489d
RDX: 0000000000000000 RSI: 0000000000000058 RDI: 0000000020000440
RBP: 00007ff4fe98100d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff3b67e98f R14: 00007ff4fea33f60 R15: 00007ff4fd285dc0
 </TASK>
INFO: task syz-executor.5:32747 blocked for more than 143 seconds.
      Not tainted 5.16.0-rc6 #9
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.5  state:D stack:26016 pid:32747 ppid: 32460 flags:0x00004000
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
RIP: 0033:0x7ff4fe91489d
RSP: 002b:00007ff4fd285c28 EFLAGS: 00000246 ORIG_RAX: 00000000000001b3
RAX: ffffffffffffffda RBX: 00007ff4fea33f60 RCX: 00007ff4fe91489d
RDX: 0000000000000000 RSI: 0000000000000058 RDI: 0000000020000440
RBP: 00007ff4fe98100d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff3b67e98f R14: 00007ff4fea33f60 R15: 00007ff4fd285dc0
 </TASK>
INFO: task syz-executor.5:347 blocked for more than 143 seconds.
      Not tainted 5.16.0-rc6 #9
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.5  state:D stack:25112 pid:  347 ppid: 32553 flags:0x00004000
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
RIP: 0033:0x7ff4fe91489d
RSP: 002b:00007ff4fd285c28 EFLAGS: 00000246 ORIG_RAX: 00000000000001b3
RAX: ffffffffffffffda RBX: 00007ff4fea33f60 RCX: 00007ff4fe91489d
RDX: 0000000000000000 RSI: 0000000000000058 RDI: 0000000020000440
RBP: 00007ff4fe98100d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff3b67e98f R14: 00007ff4fea33f60 R15: 00007ff4fd285dc0
 </TASK>

Showing all locks held in the system:
1 lock held by systemd/1:
 #0: ffff888106d75550 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_invalidate_lock_shared include/linux/fs.h:838 [inline]
 #0: ffff888106d75550 (mapping.invalidate_lock){++++}-{3:3}, at:
page_cache_ra_unbounded+0x1bc/0x950 mm/readahead.c:194
1 lock held by khungtaskd/39:
 #0: ffffffff8bb80e20 (rcu_read_lock){....}-{1:2}, at:
debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6458
1 lock held by in:imklog/6750:
 #0: ffff88801d03d550 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_invalidate_lock_shared include/linux/fs.h:838 [inline]
 #0: ffff88801d03d550 (mapping.invalidate_lock){++++}-{3:3}, at:
page_cache_ra_unbounded+0x1bc/0x950 mm/readahead.c:194
1 lock held by syz-fuzzer/6693:
 #0: ffff88810e053768 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_invalidate_lock_shared include/linux/fs.h:838 [inline]
 #0: ffff88810e053768 (mapping.invalidate_lock){++++}-{3:3}, at:
page_cache_ra_unbounded+0x1bc/0x950 mm/readahead.c:194
1 lock held by syz-fuzzer/6698:
 #0: ffff88810e053768 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_invalidate_lock_shared include/linux/fs.h:838 [inline]
 #0: ffff88810e053768 (mapping.invalidate_lock){++++}-{3:3}, at:
page_cache_ra_unbounded+0x1bc/0x950 mm/readahead.c:194
1 lock held by syz-fuzzer/6699:
 #0: ffff88810e053768 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_invalidate_lock_shared include/linux/fs.h:838 [inline]
 #0: ffff88810e053768 (mapping.invalidate_lock){++++}-{3:3}, at:
page_cache_ra_unbounded+0x1bc/0x950 mm/readahead.c:194
1 lock held by syz-fuzzer/6721:
 #0: ffff88810e053768 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_invalidate_lock_shared include/linux/fs.h:838 [inline]
 #0: ffff88810e053768 (mapping.invalidate_lock){++++}-{3:3}, at:
page_cache_ra_unbounded+0x1bc/0x950 mm/readahead.c:194
4 locks held by kworker/u8:4/8695:
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
 #1: ffffc90014a47dc8 (net_cleanup_work){+.+.}-{0:0}, at:
process_one_work+0x8f7/0x16d0 kernel/workqueue.c:2273
 #2: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
cleanup_net+0x9b/0xa90 net/core/net_namespace.c:555
 #3: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_exit_net+0x16b/0x4f0 drivers/infiniband/core/device.c:1122
4 locks held by syz-executor.5/32436:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/32460:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/32484:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/32507:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/32530:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/32553:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
3 locks held by syz-executor.5/32576:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
4 locks held by syz-executor.5/32664:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/32704:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/32747:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
2 locks held by syz-executor.5/344:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_exit_net+0x16b/0x4f0 drivers/infiniband/core/device.c:1122
4 locks held by syz-executor.5/347:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/360:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/392:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/415:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/436:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/465:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/488:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/511:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/540:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/563:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/586:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/609:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/622:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/655:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/678:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/699:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
3 locks held by syz-executor.5/724:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
4 locks held by syz-executor.5/747:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/771:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/795:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/818:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/841:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/864:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/890:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/921:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/949:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/972:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/999:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/1033:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/1054:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/1091:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/1112:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/1137:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
3 locks held by syz-executor.5/1161:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
2 locks held by syz-executor.5/1186:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_exit_net+0x16b/0x4f0 drivers/infiniband/core/device.c:1122
3 locks held by syz-executor.5/1209:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/1234:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
5 locks held by syz-executor.5/1258:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
 #4: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
mm/page_alloc.c:4585 [inline]
 #4: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim mm/page_alloc.c:4609 [inline]
 #4: ffffffff8bca5140 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath.constprop.0+0x760/0x21b0 mm/page_alloc.c:5007
4 locks held by syz-executor.5/1278:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/1308:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/1333:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/1414:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/1446:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/1492:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/1493:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/1543:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/1546:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/1575:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/1600:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/1622:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/1649:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/1665:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/1691:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/1721:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/1744:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/1767:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/1790:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/1820:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/1843:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/1866:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/1902:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/1908:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/1933:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/1954:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/1981:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/2004:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/2028:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/2057:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/2086:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/2115:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/2141:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/2170:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/2199:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/2225:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/2254:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/2281:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/2306:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/2329:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/2359:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/2398:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/2422:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/2445:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/2472:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
3 locks held by syz-executor.5/2491:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/2512:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/2538:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
2 locks held by syz-executor.5/2561:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_exit_net+0x16b/0x4f0 drivers/infiniband/core/device.c:1122
3 locks held by syz-executor.5/2586:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/2604:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/2650:
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
4 locks held by syz-executor.5/2708:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/2748:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/2781:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/2811:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/2839:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/2864:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/2887:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/2910:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/2933:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/2956:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/2981:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/3006:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/3031:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/3056:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/3102:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/3103:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/3135:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/3158:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/3181:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/3204:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/3227:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/3248:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/3273:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/3296:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/3319:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/3342:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/3365:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/3388:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/3411:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/3434:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/3457:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/3480:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/3503:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/3525:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/3554:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/3586:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/3587:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/3637:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/3638:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/3659:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/3688:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/3711:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/3734:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/3757:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/3778:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/3803:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/3826:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/3849:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/3876:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/3917:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/3978:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/4012:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/4057:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/4140:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/4209:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/4224:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/4253:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/4333:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.0/4367:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/4372:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/4404:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/4429:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/4448:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/4530:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/4538:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/4558:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/4591:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/4614:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/4639:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/4663:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/4687:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/4706:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/4733:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/4756:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/4775:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/4794:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/4826:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/4849:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/4866:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/4891:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/4916:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/4941:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/4964:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/4987:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/5011:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/5034:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/5053:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/5081:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/5101:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/5127:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/5150:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/5171:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/5200:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/5219:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/5246:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/5268:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/5289:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/5314:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/5338:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/5366:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/5385:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/5408:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/5429:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/5454:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
4 locks held by syz-executor.5/5473:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev drivers/infiniband/core/device.c:942 [inline]
 #3: ffff88804c980fe8 (&device->compat_devs_mutex){+.+.}-{3:3}, at:
add_one_compat_dev+0xea/0x7f0 drivers/infiniband/core/device.c:919
3 locks held by syz-executor.5/5502:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/5525:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/5548:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/5571:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/5590:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/5618:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/5699:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/5739:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/5746:
 #0: ffffffff8d2eeb90 (pernet_ops_rwsem){++++}-{3:3}, at:
copy_net_ns+0x2b6/0x660 net/core/net_namespace.c:466
 #1: ffffffff8d01ceb0 (devices_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x20d/0x480 drivers/infiniband/core/device.c:1178
 #2: ffffffff8d01cc30 (rdma_nets_rwsem){++++}-{3:3}, at:
rdma_dev_init_net+0x280/0x480 drivers/infiniband/core/device.c:1183
3 locks held by syz-executor.5/5765:
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
CPU: 0 PID: 1036 Comm: kworker/u9:4 Not tainted 5.16.0-rc6 #9
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Workqueue: events_unbound toggle_allocation_gate
RIP: 0010:lookup_object lib/debugobjects.c:196 [inline]
RIP: 0010:debug_object_activate+0x1a0/0x410 lib/debugobjects.c:663
Code: 80 3c 11 00 0f 85 f6 01 00 00 4d 3b 6c 24 18 0f 84 f3 00 00 00
4c 89 e0 48 c1 e8 03 80 3c 10 00 0f 85 ff 01 00 00 4d 8b 24 24 <4d> 85
e4 75 c1 44 39 3d bc e7 a9 09 7d 07 44 89 3d b3 e7 a9 09 4c
RSP: 0018:ffffc90006d7fa50 EFLAGS: 00000046
RAX: 1ffff11015de54b6 RBX: 1ffff92000daff4c RCX: 1ffff11015de54b9
RDX: dffffc0000000000 RSI: 0000000000000016 RDI: ffff8880aef2a5c8
RBP: ffffc90006d7fb28 R08: ffffffff90660d18 R09: fffff52000daff39
R10: 0000000000000003 R11: fffff52000daff38 R12: ffff8880b19bac78
R13: ffffffff8bcc99a8 R14: ffffffff89adf720 R15: 0000000000000002
FS:  0000000000000000(0000) GS:ffff888063e00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055ce1f8d9780 CR3: 000000000b88e000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 debug_timer_activate kernel/time/timer.c:729 [inline]
 __mod_timer kernel/time/timer.c:1050 [inline]
 add_timer+0x4a9/0x7c0 kernel/time/timer.c:1144
 __queue_delayed_work+0x1a7/0x270 kernel/workqueue.c:1678
 queue_delayed_work_on+0x105/0x120 kernel/workqueue.c:1703
 queue_delayed_work include/linux/workqueue.h:517 [inline]
 toggle_allocation_gate mm/kfence/core.c:748 [inline]
 toggle_allocation_gate+0x1c8/0x390 mm/kfence/core.c:724
 process_one_work+0x9df/0x16d0 kernel/workqueue.c:2298
 worker_thread+0x90/0xed0 kernel/workqueue.c:2445
 kthread+0x405/0x4f0 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>
NMI backtrace for cpu 2 skipped: idling at native_safe_halt
arch/x86/include/asm/irqflags.h:51 [inline]
NMI backtrace for cpu 2 skipped: idling at arch_safe_halt
arch/x86/include/asm/irqflags.h:89 [inline]
NMI backtrace for cpu 2 skipped: idling at default_idle+0xb/0x10
arch/x86/kernel/process.c:733
NMI backtrace for cpu 1 skipped: idling at native_safe_halt
arch/x86/include/asm/irqflags.h:51 [inline]
NMI backtrace for cpu 1 skipped: idling at arch_safe_halt
arch/x86/include/asm/irqflags.h:89 [inline]
NMI backtrace for cpu 1 skipped: idling at default_idle+0xb/0x10
arch/x86/kernel/process.c:733
----------------
Code disassembly (best guess):
   0: 80 3c 11 00          cmpb   $0x0,(%rcx,%rdx,1)
   4: 0f 85 f6 01 00 00    jne    0x200
   a: 4d 3b 6c 24 18        cmp    0x18(%r12),%r13
   f: 0f 84 f3 00 00 00    je     0x108
  15: 4c 89 e0              mov    %r12,%rax
  18: 48 c1 e8 03          shr    $0x3,%rax
  1c: 80 3c 10 00          cmpb   $0x0,(%rax,%rdx,1)
  20: 0f 85 ff 01 00 00    jne    0x225
  26: 4d 8b 24 24          mov    (%r12),%r12
* 2a: 4d 85 e4              test   %r12,%r12 <-- trapping instruction
  2d: 75 c1                jne    0xfffffff0
  2f: 44 39 3d bc e7 a9 09 cmp    %r15d,0x9a9e7bc(%rip)        # 0x9a9e7f2
  36: 7d 07                jge    0x3f
  38: 44 89 3d b3 e7 a9 09 mov    %r15d,0x9a9e7b3(%rip)        # 0x9a9e7f2
  3f: 4c                    rex.WR


Best Regards,
Yiru
