Return-Path: <linux-rdma+bounces-4578-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB6195FFC3
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Aug 2024 05:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 545CC1C218D3
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Aug 2024 03:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66371B964;
	Tue, 27 Aug 2024 03:28:32 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCA01803D
	for <linux-rdma@vger.kernel.org>; Tue, 27 Aug 2024 03:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724729312; cv=none; b=oRNJMPHxj+0OzxngFRkEe5swN6PL08kO57gm7vqrqsiT8GYwHTtP7otPNRnRjYtvFg1dhM/3nWvvBUsQTKfqbfdudrrlsw6VIj5XLPvhS+hKqiyWWhX8kiiFWKc46H5GJo/WF7EWvv+6Xw77XOL5Umgg55qUVnK6PtHtGAIWuZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724729312; c=relaxed/simple;
	bh=JzyjHuARwzhwepCOT2bNahFeYhPaFET6Jeo8Q3lQMAE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=bVTZ2phsDVvV9bXpgQQAtlsNGq4PNvZz+IN3PlI3i2iCwlxXXSYvRAEYuszMAqzI03KifrXnL/R58TTe4ItDvakcZWk7QX2XrhlxVkj2LfxMeWHrKTwEZuwtiws3c4+DyVnY88Nkz3Ct4L0X0sUx4IkPFjCtb/z/KVUnyK4Z5nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39d4c0fc036so63220045ab.2
        for <linux-rdma@vger.kernel.org>; Mon, 26 Aug 2024 20:28:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724729309; x=1725334109;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d3xjFthS/6EQeI65pLP05Rb0vmQMjF3sKd6xX6kYOds=;
        b=fL/gWe6/BDKWK8vCh8hYzfR6KxXQIGbJQLO1ktkIZrQ08ubBfKl0e/xYNRaid/8f7O
         KuRr3udWjMX65qnUMEVOZMPr4CdPe7UrQlFxL4hoQ7wO576ngytldDpdmWlv5OY7ploC
         +uCEgT9XtgH2jbnVL6Av2ON9Cucb7Wi3CWTpxE31XuoN1IHXn5BUcGb24yXzQuVYAHk6
         PNv+wxYxhA6BOiFn9lUh+h+0FzwB0OaLIIPFJuW0wDZRWG5Dx5/pNtcislVXjP8+WG1l
         qOAZ6FqTKfSoEburRtzRL12V5MU8T6gF+yVQNYe3yBN848R/z0z/FCvnVRtL2ZhXwffa
         Nacg==
X-Forwarded-Encrypted: i=1; AJvYcCUDZr/iT1KFrTmnJuSvuEFLQ15vXv/oFabJsNB7dP8mAdkuQieT0gYVyIm7UGdoz6O8FIuHnnmdJ+qr@vger.kernel.org
X-Gm-Message-State: AOJu0YzPwBMXWPBGL/XMgqd3NkZYYL3V+pPPdzHVSqElivrfhP08dM4O
	fGLmk6O7WCfIUD9jCdrBvIIz25WM2c2zGlJ09YQldQtIC+mkDMwWnJKfMrz75EK2heeAnDchgtg
	6euBCC81cx3iVbIx4T9ayN/NTxanzjlISxx2oxkituyRap+T8GOPjnWk=
X-Google-Smtp-Source: AGHT+IFITaiq8Umo7bQ6KPVCgf8u9U/GIou4AaOFHIqclfJiDTb5qOVgGhpnBnQm0to7Yxzg7Y2c+rQ2MDHkgljHvDbd64pXmnMF
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d01:b0:381:c14:70cf with SMTP id
 e9e14a558f8ab-39e3c975718mr10848265ab.1.1724729309027; Mon, 26 Aug 2024
 20:28:29 -0700 (PDT)
Date: Mon, 26 Aug 2024 20:28:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cc73830620a1d540@google.com>
Subject: [syzbot] [rdma?] INFO: task hung in disable_device
From: syzbot <syzbot+4d0c396361b5dc5d610f@syzkaller.appspotmail.com>
To: jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    872cf28b8df9 Merge tag 'platform-drivers-x86-v6.11-4' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=138e4ff5980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df2f0ed7e30a639d
dashboard link: https://syzkaller.appspot.com/bug?extid=4d0c396361b5dc5d610f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a739b83871e7/disk-872cf28b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e1a2d875095e/vmlinux-872cf28b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/26e7dbbb9245/bzImage-872cf28b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4d0c396361b5dc5d610f@syzkaller.appspotmail.com

INFO: task kworker/u8:3:53 blocked for more than 143 seconds.
      Not tainted 6.11.0-rc4-syzkaller-00033-g872cf28b8df9 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u8:3    state:D stack:19984 pid:53    tgid:53    ppid:2      flags:0x00004000
Workqueue: ib-unreg-wq ib_unregister_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0x1800/0x4a60 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6621
 schedule_timeout+0xb0/0x310 kernel/time/timer.c:2557
 do_wait_for_common kernel/sched/completion.c:95 [inline]
 __wait_for_common kernel/sched/completion.c:116 [inline]
 wait_for_common kernel/sched/completion.c:127 [inline]
 wait_for_completion+0x355/0x620 kernel/sched/completion.c:148
 disable_device+0x1c7/0x360 drivers/infiniband/core/device.c:1295
 __ib_unregister_device+0x2ac/0x3c0 drivers/infiniband/core/device.c:1493
 ib_unregister_work+0x19/0x30 drivers/infiniband/core/device.c:1604
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2e/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd40 kernel/workqueue.c:3390
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/30:
 #0: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:326 [inline]
 #0: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #0: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6626
3 locks held by kworker/u8:3/53:
 #0: ffff888015f8c148 ((wq_completion)ib-unreg-wq){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff888015f8c148 ((wq_completion)ib-unreg-wq){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc90000bd7d00 ((work_completion)(&device->unregistration_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc90000bd7d00 ((work_completion)(&device->unregistration_work)){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
 #2: ffff888071b5c6b0 (&device->unregistration_lock){+.+.}-{3:3}, at: __ib_unregister_device+0x264/0x3c0 drivers/infiniband/core/device.c:1489
2 locks held by kworker/u8:7/1067:
 #0: ffff888015881148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff888015881148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc900040a7d00 ((work_completion)(&sub_info->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc900040a7d00 ((work_completion)(&sub_info->work)){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
2 locks held by getty/4975:
 #0: ffff88802b2ea0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc900031332f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6ac/0x1e00 drivers/tty/n_tty.c:2211
4 locks held by kworker/u8:2/12786:
 #0: ffff8880166e5948 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff8880166e5948 ((wq_completion)netns){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc9000353fd00 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc9000353fd00 (net_cleanup_work){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
 #2: ffffffff8fc77a10 (pernet_ops_rwsem){++++}-{3:3}, at: cleanup_net+0x16a/0xcc0 net/core/net_namespace.c:594
 #3: ffffffff8e93d5c0 (rcu_state.barrier_mutex){+.+.}-{3:3}, at: rcu_barrier+0x4c/0x530 kernel/rcu/tree.c:4486
5 locks held by kworker/1:12/17513:
3 locks held by kworker/0:10/17565:
 #0: ffff888015878948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff888015878948 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc90004207d00 ((work_completion)(&data->fib_event_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc90004207d00 ((work_completion)(&data->fib_event_work)){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
 #2: ffff88807c173240 (&data->fib_lock){+.+.}-{3:3}, at: nsim_fib_event_work+0x2d1/0x4130 drivers/net/netdevsim/fib.c:1489
2 locks held by syz.2.8079/23259:
3 locks held by kworker/u8:5/23442:
1 lock held by syz.5.9191/26178:
1 lock held by syz.4.9349/26557:
2 locks held by syz.1.9359/26583:
6 locks held by syz.3.9361/26591:
2 locks held by udevadm/26600:
1 lock held by modprobe/26606:

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.11.0-rc4-syzkaller-00033-g872cf28b8df9 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xff4/0x1040 kernel/hung_task.c:379
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 26178 Comm: syz.5.9191 Not tainted 6.11.0-rc4-syzkaller-00033-g872cf28b8df9 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:lockdep_recursion_finish kernel/locking/lockdep.c:466 [inline]
RIP: 0010:lock_acquire+0x1f1/0x550 kernel/locking/lockdep.c:5761
Code: 7c 24 20 44 89 f6 8b 54 24 1c 48 8b 4c 24 30 4c 8b 44 24 38 6a 00 6a 00 6a 00 ff 75 10 ff 74 24 48 e8 c3 04 00 00 48 83 c4 28 <48> c7 c7 e0 e6 0a 8c e8 a3 09 47 0a b8 ff ff ff ff 65 0f c1 05 b6
RSP: 0018:ffffc9000310f900 EFLAGS: 00000096
RAX: 0000000000000001 RBX: ffffc9000310f960 RCX: 0ae94b015512b200
RDX: dffffc0000000000 RSI: 0000000000000008 RDI: ffffffff93733a30
RBP: ffffc9000310fa48 R08: ffffffff93733a37 R09: 1ffffffff26e6746
R10: dffffc0000000000 R11: fffffbfff26e6747 R12: 1ffff92000621f28
R13: dffffc0000000000 R14: 0000000000000000 R15: 0000000000000046
FS:  00007fd04b14d6c0(0000) GS:ffff8880b9200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2ba2c6a018 CR3: 0000000054a6c000 CR4: 0000000000350ef0
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
 __wake_up_common_lock+0x25/0x1e0 kernel/sched/wait.c:105
 io_cqring_wake io_uring/io_uring.h:274 [inline]
 io_cq_unlock_post io_uring/io_uring.c:595 [inline]
 __io_cqring_overflow_flush+0x504/0x690 io_uring/io_uring.c:633
 io_cqring_do_overflow_flush io_uring/io_uring.c:645 [inline]
 io_cqring_wait io_uring/io_uring.c:2486 [inline]
 __do_sys_io_uring_enter io_uring/io_uring.c:3255 [inline]
 __se_sys_io_uring_enter+0x1c36/0x2670 io_uring/io_uring.c:3147
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd04a379e79
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd04b14d038 EFLAGS: 00000246 ORIG_RAX: 00000000000001aa
RAX: ffffffffffffffda RBX: 00007fd04a515f80 RCX: 00007fd04a379e79
RDX: 0000000000400000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007fd04a3e7916 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fd04a515f80 R15: 00007ffe6d4a4928
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

