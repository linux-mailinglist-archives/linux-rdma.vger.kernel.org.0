Return-Path: <linux-rdma+bounces-4728-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DEFA96ACEC
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Sep 2024 01:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B24BD1C240F3
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Sep 2024 23:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0255D1D7983;
	Tue,  3 Sep 2024 23:37:29 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200A8126BFD
	for <linux-rdma@vger.kernel.org>; Tue,  3 Sep 2024 23:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725406648; cv=none; b=Rj7P6oY38cKTsfNVpbvvg6pTf/vvbC+TqeoKgOgpj1fbfeLBhduojSe970Ma8Z4FM2zRTaW8p6u3Z3Gyv8i+30SG822hbRUVj76d6CxgoOvmG1RkMRaZvdfp1NwvTSLqUhEYJFxeHqFGf8xtVQPkFglNfVlOiblPjLyx1Hi/xxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725406648; c=relaxed/simple;
	bh=WNrDY2fK2vgJ6fUWzO8EWuXPOWbHA8Tk1UBa62dPJWs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=YEMy8mLfxcqOdIED0IQhgfZ4SP9qGf6dVwMQwKfZsIkjk6lD2NuyzjLXHz4pXAKv8bHMKepHPVQkImtCm70Vj9ullED87GfXb/pfNchyzSkDIUpBNIGC5a0O62HBoN+zCeeZb/+nKm007mfFL8GVf5fmZ1obtvCWBitwQv/r3/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39d2044b532so61761515ab.0
        for <linux-rdma@vger.kernel.org>; Tue, 03 Sep 2024 16:37:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725406646; x=1726011446;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3862slMjoxApvzvkAY3Ev7BhwjDn5qC/kVgySMLD0gE=;
        b=l2/iSozznFP5qYlMeu4gaXWfe3xTZl3PtJz951SqOCw7/8gpLTZEgPdIqDGbZaFJCR
         ErqnErdSy64yLAog/QL9iW0upN4UE2W5Q6Zz0K+Z8mP2ABJLf2kV2+eawb5Yh+9onQdD
         JtlbrnfjUfpniImeUpsmPlDPSzHxLFvtIcwJQsRFesQ4zSVOtkuoNbJqIDyrRREQkfK3
         Hlj2OnAqowCZn/GG9OLvGdVKkEtnV83HhMx23pReSqFpn/49AesQ4Qctkp4hMFcgaAzh
         26OJejgK/kPIoXPGBbpx/xAYELbBUj038VOFtwApUCtg3R7ndCM0YwXLgPF1f5sFg2Wi
         CsHA==
X-Forwarded-Encrypted: i=1; AJvYcCWVBlnqhwdQJfIm4JSDgicZ4uROAUQdQg2nqhfCc+ptFTWPVroYkpjkSbUyyR9lp0teaQxg05H0Urj0@vger.kernel.org
X-Gm-Message-State: AOJu0YzVjFtQunXtUV322O1GHmVqCRu36oD7IFX4we59Y1KL1JLRx8Fx
	2na99c8wEaLBlVNRXsEMxkTzkVtGZMDw2GieK97Sl2P1iZ9WJKQIXNQSiwPqw+xqyk4JiWwnA4a
	P3zjHm9GO/cpk98B/BFwVpxAcKon8hGRBKH0RnNjs5c5vrLntpfNsruo=
X-Google-Smtp-Source: AGHT+IFI5m4RaIhbEHsFaezRyVhKy/Gg/BJdLTJcyxZQtdE0ZlCBKfF5pEIiWqWqCx2Ho0LsnLoY2UO4u6RF5GGZvR5gh23DQfB1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cda8:0:b0:39d:300f:e915 with SMTP id
 e9e14a558f8ab-39f410df0a1mr6346205ab.6.1725406645642; Tue, 03 Sep 2024
 16:37:25 -0700 (PDT)
Date: Tue, 03 Sep 2024 16:37:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000034fa0d06213f8a86@google.com>
Subject: [syzbot] [rdma?] INFO: task hung in rdma_dev_change_netns
From: syzbot <syzbot+73c5eab674c7e1e7012e@syzkaller.appspotmail.com>
To: jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5517ae241919 Merge tag 'for-net-2024-08-30' of git://git.k..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=176685b7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=996585887acdadb3
dashboard link: https://syzkaller.appspot.com/bug?extid=73c5eab674c7e1e7012e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ddded5c54678/disk-5517ae24.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ce0dfe9dbb55/vmlinux-5517ae24.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ca81d6e3361d/bzImage-5517ae24.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+73c5eab674c7e1e7012e@syzkaller.appspotmail.com

INFO: task kworker/u8:3:53 blocked for more than 143 seconds.
      Not tainted 6.11.0-rc5-syzkaller-00178-g5517ae241919 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u8:3    state:D stack:21008 pid:53    tgid:53    ppid:2      flags:0x00004000
Workqueue: netns cleanup_net
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0x1800/0x4a60 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 rdma_dev_change_netns+0x3a/0x2f0 drivers/infiniband/core/device.c:1640
 rdma_dev_exit_net+0x21e/0x350 drivers/infiniband/core/device.c:1151
 ops_exit_list net/core/net_namespace.c:173 [inline]
 cleanup_net+0x802/0xcc0 net/core/net_namespace.c:640
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd10 kernel/workqueue.c:3389
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task syz.3.1124:9442 blocked for more than 143 seconds.
      Not tainted 6.11.0-rc5-syzkaller-00178-g5517ae241919 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.3.1124      state:D stack:21624 pid:9442  tgid:9440  ppid:6033   flags:0x00004006
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
 ib_unregister_device_and_put+0xb9/0xf0 drivers/infiniband/core/device.c:1557
 nldev_dellink+0x2d6/0x320 drivers/infiniband/core/nldev.c:1824
 rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
 rdma_nl_rcv+0x6dd/0x9e0 drivers/infiniband/core/netlink.c:259
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2597
 ___sys_sendmsg net/socket.c:2651 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2680
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4e3f979eb9
RSP: 002b:00007f4e3f3de038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f4e3fb16058 RCX: 00007f4e3f979eb9
RDX: 0000000000000000 RSI: 0000000020000240 RDI: 0000000000000006
RBP: 00007f4e3f9e793e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f4e3fb16058 R15: 00007ffefbdc0c38
 </TASK>

Showing all locks held in the system:
2 locks held by ksoftirqd/1/24:
 #0: ffff8880b893e9d8 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:560
 #1: ffff8880b8928948 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: psi_task_switch+0x441/0x770 kernel/sched/psi.c:989
1 lock held by khungtaskd/30:
 #0: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:326 [inline]
 #0: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #0: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6626
4 locks held by kworker/u8:3/53:
 #0: ffff88801bae5948 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff88801bae5948 ((wq_completion)netns){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc90000bd7d00 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc90000bd7d00 (net_cleanup_work){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
 #2: ffffffff8fc7ee90 (pernet_ops_rwsem){++++}-{3:3}, at: cleanup_net+0x16a/0xcc0 net/core/net_namespace.c:594
 #3: ffff888023e006b0 (&device->unregistration_lock){+.+.}-{3:3}, at: rdma_dev_change_netns+0x3a/0x2f0 drivers/infiniband/core/device.c:1640
2 locks held by getty/4989:
 #0: ffff88803098b0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000312b2f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6ac/0x1e00 drivers/tty/n_tty.c:2211
2 locks held by syz.3.1124/9442:
 #0: ffffffff9a6e1078 (&rdma_nl_types[idx].sem){.+.+}-{3:3}, at: rdma_nl_rcv_msg drivers/infiniband/core/netlink.c:164 [inline]
 #0: ffffffff9a6e1078 (&rdma_nl_types[idx].sem){.+.+}-{3:3}, at: rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
 #0: ffffffff9a6e1078 (&rdma_nl_types[idx].sem){.+.+}-{3:3}, at: rdma_nl_rcv+0x32d/0x9e0 drivers/infiniband/core/netlink.c:259
 #1: ffff888023e006b0 (&device->unregistration_lock){+.+.}-{3:3}, at: __ib_unregister_device+0x264/0x3c0 drivers/infiniband/core/device.c:1489
3 locks held by kworker/u8:28/12113:
1 lock held by syz-executor/12207:
 #0: ffffffff8e93d5c0 (rcu_state.barrier_mutex){+.+.}-{3:3}, at: rcu_barrier+0x4c/0x530 kernel/rcu/tree.c:4486

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.11.0-rc5-syzkaller-00178-g5517ae241919 #0
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
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 12587 Comm: syz-executor Not tainted 6.11.0-rc5-syzkaller-00178-g5517ae241919 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0033:0x7f57b85781d6
Code: ff ff ff c6 44 24 0b 00 45 31 ed 48 8d 1d f2 46 09 00 48 89 04 24 66 0f 1f 44 00 00 4c 89 e9 48 c1 e1 05 49 03 4e 08 83 39 06 <49> 89 cc 0f 87 81 00 00 00 8b 01 48 63 04 83 48 01 d8 ff e0 66 0f
RSP: 002b:00007f57b928ee80 EFLAGS: 00000297
RAX: 0000000000000081 RBX: 00007f57b860c8b0 RCX: 00005555578c6d00
RDX: ffffffffffffffa8 RSI: 0000000000000007 RDI: 0000000000000081
RBP: 00007ffcf0466140 R08: 00007f57b928ef20 R09: 0000000000000000
R10: 00007f57b928ee90 R11: 0000000000000203 R12: 00005555578c6ce0
R13: 0000000000000082 R14: 00007ffcf04660f0 R15: 00007ffcf0465ea0
FS:  000055555782d500 GS:  0000000000000000


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

