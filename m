Return-Path: <linux-rdma+bounces-6677-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C389F8DDF
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Dec 2024 09:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EA0418945EC
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Dec 2024 08:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF361A83EE;
	Fri, 20 Dec 2024 08:21:27 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB591A83EF
	for <linux-rdma@vger.kernel.org>; Fri, 20 Dec 2024 08:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734682887; cv=none; b=io31nzJcbXCUYcY7VGCAmy2beXga+8dNDyY+qQ49LGjHJslZyam97c8Xv0K6d8vCkUmksi07guAXD2v2dsD0KR2ht549a1BExwn4z5T5T/dvTTLJf65Z2o5PAerWfTgDZcFSPcUHJdbekghqYEQY+vrRhp2IbHNK0HjXrzX/8mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734682887; c=relaxed/simple;
	bh=LyqVQn4e48VyMPkIGTwZBk07jQJoE7cbeYffNeQQ9vU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Z2NqI1aNc7hJC+mIW3o2H9Na3CfTdHmCmm1dtROr0S2q1utG0aM9kbKcT2xentmCA8cHJcWEBsZcyNiBQX1FRS5bDVVGXOcd1JsKcD5o59yrxxpFV+l94uq7rcIMLS/Py2jyL/gmu7F9mYIIksc+FW58iPEyNLibjHT0aIAqgEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-847500c9b9aso287527439f.1
        for <linux-rdma@vger.kernel.org>; Fri, 20 Dec 2024 00:21:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734682883; x=1735287683;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+P+FoLpru327VOQAxh/1BswuYR1NX7BucZaLxxxV8/I=;
        b=tpZ0KigP4pQNl6VedpDavZrzbn1LsfeHdFQ9AsUWfrBu8vk70n/mLto4Kpd8OuXhIF
         hmHn4BCu5vxQh6qQ6oJFsUuoakBj/1OOaCHzM9INaIDFgX61tMlSKnAELHxHXfv6rX6R
         MyWmY9C0dQscKRySIHOGYVaLBXTH4CtGsw0vyOz9Lo641jSzjIRpLp1sTqPfg9OSX5e+
         kk1iYLoHnCCCZLhAiY2U6KUykYh6EOw7RAXg8/vKXVoAEXQar9bgN8KQA+lzMpVBaFJF
         5NL3aF9ZBuTBw3e3qNOXYMGwFrFceZEIKIpIFh7AdjOZ4LaGddFd8sfD0MOxe5EANFGS
         Jphw==
X-Forwarded-Encrypted: i=1; AJvYcCWw6hrlrXNHmRFdg8InzkjLtdNWwIv/XZ7qVUf9MpD0CC5NoKBKKmTqfqPOZo3RYJ8Bj1cFchrMq+ek@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5xzJZXiQ4tYyiKW9FF2BL7LCahFYLnoqdDdN4hqkJw5XaZzj+
	IrL/GZlMWMFZkXpI44HCrwBU6KmxQwEy6nrqXrcITM3bDUA2wIjcn/d4z+0z9HPmK3h8ta06EbN
	tJ1SmeolXQHD/U2yN6lQlecx8tcVAVP/z6+H9Vu5eDhvHLI8lisvzPf8=
X-Google-Smtp-Source: AGHT+IH264pnwTuzNMS6Cf1f81MFkSOAlkbgC3cyZpVZtFyTWPo6TmGwp0A8mYxYK2uJ9/+jy2vgXHHOOuwOuHvImsnBQkwob5g9
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3a10:b0:3a7:4674:d637 with SMTP id
 e9e14a558f8ab-3c2d1b98479mr27905805ab.3.1734682883610; Fri, 20 Dec 2024
 00:21:23 -0800 (PST)
Date: Fri, 20 Dec 2024 00:21:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67652903.050a0220.1bfc9e.0008.GAE@google.com>
Subject: [syzbot] [rdma?] INFO: task hung in rdma_dev_exit_net (6)
From: syzbot <syzbot+3658758f38a2f0f062e7@syzkaller.appspotmail.com>
To: jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9f16d5e6f220 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=136465c0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fb680913ee293bcc
dashboard link: https://syzkaller.appspot.com/bug?extid=3658758f38a2f0f062e7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e72a74c4c0d3/disk-9f16d5e6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/940322501ec7/vmlinux-9f16d5e6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6318087c1412/bzImage-9f16d5e6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3658758f38a2f0f062e7@syzkaller.appspotmail.com

INFO: task syz-executor:15271 blocked for more than 143 seconds.
      Not tainted 6.12.0-syzkaller-09073-g9f16d5e6f220 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:22912 pid:15271 tgid:15271 ppid:1      flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5369 [inline]
 __schedule+0x1850/0x4c30 kernel/sched/core.c:6756
 __schedule_loop kernel/sched/core.c:6833 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6848
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6905
 rwsem_down_write_slowpath+0xeee/0x13b0 kernel/locking/rwsem.c:1176
 __down_write_common kernel/locking/rwsem.c:1304 [inline]
 __down_write kernel/locking/rwsem.c:1313 [inline]
 down_write+0x1d7/0x220 kernel/locking/rwsem.c:1578
 rdma_dev_exit_net+0x8e/0x350 drivers/infiniband/core/device.c:1130
 ops_exit_list net/core/net_namespace.c:172 [inline]
 setup_net+0x796/0x9e0 net/core/net_namespace.c:394
 copy_net_ns+0x33f/0x570 net/core/net_namespace.c:500
 create_new_namespaces+0x425/0x7b0 kernel/nsproxy.c:110
 unshare_nsproxy_namespaces+0x124/0x180 kernel/nsproxy.c:228
 ksys_unshare+0x57d/0xa70 kernel/fork.c:3314
 __do_sys_unshare kernel/fork.c:3385 [inline]
 __se_sys_unshare kernel/fork.c:3383 [inline]
 __x64_sys_unshare+0x38/0x40 kernel/fork.c:3383
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe049180017
RSP: 002b:00007ffc67fd06b8 EFLAGS: 00000206 ORIG_RAX: 0000000000000110
RAX: ffffffffffffffda RBX: 00007fe049335f40 RCX: 00007fe049180017
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000040000000
RBP: 00007fe049336738 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000008
R13: 0000000000000003 R14: 0000000000000009 R15: 0000000000000000
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/30:
 #0: ffffffff8e93c520 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8e93c520 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8e93c520 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6744
4 locks held by kworker/u8:3/52:
 #0: ffff88801baed948 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88801baed948 ((wq_completion)netns){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc90000bc7d00 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc90000bc7d00 (net_cleanup_work){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffffffff8fcdc850 (pernet_ops_rwsem){++++}-{4:4}, at: cleanup_net+0x16a/0xcc0 net/core/net_namespace.c:586
 #3: ffffffff8fa560f0 (rdma_nets_rwsem){++++}-{4:4}, at: rdma_dev_exit_net+0x8e/0x350 drivers/infiniband/core/device.c:1130
2 locks held by kworker/u8:8/3523:
 #0: ffff8880b863e798 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:598
 #1: ffffc9000d4a7d00 ((work_completion)(&(&bat_priv->nc.work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc9000d4a7d00 ((work_completion)(&(&bat_priv->nc.work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
1 lock held by dhcpcd/5512:
 #0: ffffffff8fce9388 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fce9388 (rtnl_mutex){+.+.}-{4:4}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6917
2 locks held by getty/5599:
 #0: ffff88814d0a00a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000330b2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x6a6/0x1e00 drivers/tty/n_tty.c:2211
3 locks held by kworker/1:6/5946:
2 locks held by syz-executor/15271:
 #0: ffffffff8fcdc850 (pernet_ops_rwsem){++++}-{4:4}, at: copy_net_ns+0x328/0x570 net/core/net_namespace.c:496
 #1: ffffffff8fa560f0 (rdma_nets_rwsem){++++}-{4:4}, at: rdma_dev_exit_net+0x8e/0x350 drivers/infiniband/core/device.c:1130
2 locks held by syz-executor/15279:
 #0: ffffffff8fcdc850 (pernet_ops_rwsem){++++}-{4:4}, at: copy_net_ns+0x328/0x570 net/core/net_namespace.c:496
 #1: ffffffff8fa560f0 (rdma_nets_rwsem){++++}-{4:4}, at: rdma_dev_exit_net+0x8e/0x350 drivers/infiniband/core/device.c:1130
2 locks held by syz-executor/15289:
 #0: ffffffff8fcdc850 (pernet_ops_rwsem){++++}-{4:4}, at: copy_net_ns+0x328/0x570 net/core/net_namespace.c:496
 #1: ffffffff8fa560f0 (rdma_nets_rwsem){++++}-{4:4}, at: rdma_dev_exit_net+0x8e/0x350 drivers/infiniband/core/device.c:1130
2 locks held by syz-executor/15293:
 #0: ffffffff8fcdc850 (pernet_ops_rwsem){++++}-{4:4}, at: copy_net_ns+0x328/0x570 net/core/net_namespace.c:496
 #1: ffffffff8fa560f0 (rdma_nets_rwsem){++++}-{4:4}, at: rdma_dev_exit_net+0x8e/0x350 drivers/infiniband/core/device.c:1130
2 locks held by syz-executor/15305:
 #0: ffffffff8fcdc850 (pernet_ops_rwsem){++++}-{4:4}, at: copy_net_ns+0x328/0x570 net/core/net_namespace.c:496
 #1: ffffffff8fa560f0 (rdma_nets_rwsem){++++}-{4:4}, at: rdma_dev_exit_net+0x8e/0x350 drivers/infiniband/core/device.c:1130
2 locks held by syz-executor/15311:
 #0: ffffffff8fcdc850 (pernet_ops_rwsem){++++}-{4:4}, at: copy_net_ns+0x328/0x570 net/core/net_namespace.c:496
 #1: ffffffff8fa560f0 (rdma_nets_rwsem){++++}-{4:4}, at: rdma_dev_exit_net+0x8e/0x350 drivers/infiniband/core/device.c:1130
4 locks held by syz-executor/15321:
 #0: ffffffff8fcdc850 (pernet_ops_rwsem){++++}-{4:4}, at: copy_net_ns+0x328/0x570 net/core/net_namespace.c:496
 #1: ffffffff8fa55f30 (devices_rwsem){++++}-{4:4}, at: rdma_dev_init_net+0x198/0x280 drivers/infiniband/core/device.c:1186
 #2: ffffffff8fa560f0 (rdma_nets_rwsem){++++}-{4:4}, at: rdma_dev_init_net+0x1e6/0x280 drivers/infiniband/core/device.c:1191
 #3: ffff888030864f40 (&device->compat_devs_mutex){+.+.}-{4:4}, at: add_one_compat_dev+0x10d/0x710 drivers/infiniband/core/device.c:950
3 locks held by syz-executor/15327:
 #0: ffffffff8fcdc850 (pernet_ops_rwsem){++++}-{4:4}, at: copy_net_ns+0x328/0x570 net/core/net_namespace.c:496
 #1: ffffffff8fce9388 (rtnl_mutex){+.+.}-{4:4}, at: setup_net+0x602/0x9e0 net/core/net_namespace.c:384
 #2: ffffffff8e7d6410 (cpu_hotplug_lock){++++}-{0:0}, at: flush_all_backlogs net/core/dev.c:6031 [inline]
 #2: ffffffff8e7d6410 (cpu_hotplug_lock){++++}-{0:0}, at: unregister_netdevice_many_notify+0x5ea/0x1da0 net/core/dev.c:11501
4 locks held by syz-executor/15330:
 #0: ffffffff8fcdc850 (pernet_ops_rwsem){++++}-{4:4}, at: copy_net_ns+0x328/0x570 net/core/net_namespace.c:496
 #1: ffffffff8fa55f30 (devices_rwsem){++++}-{4:4}, at: rdma_dev_init_net+0x198/0x280 drivers/infiniband/core/device.c:1186
 #2: ffffffff8fa560f0 (rdma_nets_rwsem){++++}-{4:4}, at: rdma_dev_init_net+0x1e6/0x280 drivers/infiniband/core/device.c:1191
 #3: ffff888030864f40 (&device->compat_devs_mutex){+.+.}-{4:4}, at: add_one_compat_dev+0x10d/0x710 drivers/infiniband/core/device.c:950
4 locks held by syz-executor/15333:
 #0: ffffffff8fcdc850 (pernet_ops_rwsem){++++}-{4:4}, at: copy_net_ns+0x328/0x570 net/core/net_namespace.c:496
 #1: ffffffff8fa55f30 (devices_rwsem){++++}-{4:4}, at: rdma_dev_init_net+0x198/0x280 drivers/infiniband/core/device.c:1186
 #2: ffffffff8fa560f0 (rdma_nets_rwsem){++++}-{4:4}, at: rdma_dev_init_net+0x1e6/0x280 drivers/infiniband/core/device.c:1191
 #3: ffff888030864f40 (&device->compat_devs_mutex){+.+.}-{4:4}, at: add_one_compat_dev+0x10d/0x710 drivers/infiniband/core/device.c:950
4 locks held by syz-executor/15336:
 #0: ffffffff8fcdc850 (pernet_ops_rwsem){++++}-{4:4}, at: copy_net_ns+0x328/0x570 net/core/net_namespace.c:496
 #1: ffffffff8fa55f30 (devices_rwsem){++++}-{4:4}, at: rdma_dev_init_net+0x198/0x280 drivers/infiniband/core/device.c:1186
 #2: ffffffff8fa560f0 (rdma_nets_rwsem){++++}-{4:4}, at: rdma_dev_init_net+0x1e6/0x280 drivers/infiniband/core/device.c:1191
 #3: ffff888030864f40 (&device->compat_devs_mutex){+.+.}-{4:4}, at: add_one_compat_dev+0x10d/0x710 drivers/infiniband/core/device.c:950
4 locks held by syz-executor/15338:
 #0: ffffffff8fcdc850 (pernet_ops_rwsem){++++}-{4:4}, at: copy_net_ns+0x328/0x570 net/core/net_namespace.c:496
 #1: ffffffff8fa55f30 (devices_rwsem){++++}-{4:4}, at: rdma_dev_init_net+0x198/0x280 drivers/infiniband/core/device.c:1186
 #2: ffffffff8fa560f0 (rdma_nets_rwsem){++++}-{4:4}, at: rdma_dev_init_net+0x1e6/0x280 drivers/infiniband/core/device.c:1191
 #3: ffff888030864f40 (&device->compat_devs_mutex){+.+.}-{4:4}, at: add_one_compat_dev+0x10d/0x710 drivers/infiniband/core/device.c:950
4 locks held by syz-executor/15391:
 #0: ffffffff8fcdc850 (pernet_ops_rwsem){++++}-{4:4}, at: copy_net_ns+0x328/0x570 net/core/net_namespace.c:496
 #1: ffffffff8fa55f30 (devices_rwsem){++++}-{4:4}, at: rdma_dev_init_net+0x198/0x280 drivers/infiniband/core/device.c:1186
 #2: ffffffff8fa560f0 (rdma_nets_rwsem){++++}-{4:4}, at: rdma_dev_init_net+0x1e6/0x280 drivers/infiniband/core/device.c:1191
 #3: ffff888030864f40 (&device->compat_devs_mutex){+.+.}-{4:4}, at: add_one_compat_dev+0x10d/0x710 drivers/infiniband/core/device.c:950
2 locks held by syz-executor/15398:
 #0: ffffffff8fcdc850 (pernet_ops_rwsem){++++}-{4:4}, at: copy_net_ns+0x328/0x570 net/core/net_namespace.c:496
 #1: ffffffff8fce9388 (rtnl_mutex){+.+.}-{4:4}, at: ppp_exit_net+0xe3/0x3d0 drivers/net/ppp/ppp_generic.c:1146
6 locks held by syz-executor/15400:
 #0: ffffffff8fcdc850 (pernet_ops_rwsem){++++}-{4:4}, at: copy_net_ns+0x328/0x570 net/core/net_namespace.c:496
 #1: ffffffff8fa55f30 (devices_rwsem){++++}-{4:4}, at: rdma_dev_init_net+0x198/0x280 drivers/infiniband/core/device.c:1186
 #2: ffffffff8fa560f0 (rdma_nets_rwsem){++++}-{4:4}, at: rdma_dev_init_net+0x1e6/0x280 drivers/infiniband/core/device.c:1191
 #3: ffff888030864f40 (&device->compat_devs_mutex){+.+.}-{4:4}, at: add_one_compat_dev+0x10d/0x710 drivers/infiniband/core/device.c:950
 #4: ffff888030865238 (&rxe->usdev_lock){+.+.}-{4:4}, at: rxe_query_port+0x61/0x260 drivers/infiniband/sw/rxe/rxe_verbs.c:54
 #5: ffffffff8fce9388 (rtnl_mutex){+.+.}-{4:4}, at: ib_get_eth_speed+0x153/0x800 drivers/infiniband/core/verbs.c:1995
4 locks held by syz-executor/15403:
 #0: ffffffff8fcdc850 (pernet_ops_rwsem){++++}-{4:4}, at: copy_net_ns+0x328/0x570 net/core/net_namespace.c:496
 #1: ffffffff8fa55f30 (devices_rwsem){++++}-{4:4}, at: rdma_dev_init_net+0x198/0x280 drivers/infiniband/core/device.c:1186
 #2: ffffffff8fa560f0 (rdma_nets_rwsem){++++}-{4:4}, at: rdma_dev_init_net+0x1e6/0x280 drivers/infiniband/core/device.c:1191
 #3: ffff888030864f40 (&device->compat_devs_mutex){+.+.}-{4:4}, at: add_one_compat_dev+0x10d/0x710 drivers/infiniband/core/device.c:950
2 locks held by syz-executor/15406:
 #0: ffffffff8fcdc850 (pernet_ops_rwsem){++++}-{4:4}, at: copy_net_ns+0x328/0x570 net/core/net_namespace.c:496
 #1: ffffffff8fce9388 (rtnl_mutex){+.+.}-{4:4}, at: ip_tunnel_init_net+0x20e/0x720 net/ipv4/ip_tunnel.c:1159
4 locks held by syz-executor/15408:
 #0: ffffffff8fcdc850 (pernet_ops_rwsem){++++}-{4:4}, at: copy_net_ns+0x328/0x570 net/core/net_namespace.c:496
 #1: ffffffff8fa55f30 (devices_rwsem){++++}-{4:4}, at: rdma_dev_init_net+0x198/0x280 drivers/infiniband/core/device.c:1186
 #2: ffffffff8fa560f0 (rdma_nets_rwsem){++++}-{4:4}, at: rdma_dev_init_net+0x1e6/0x280 drivers/infiniband/core/device.c:1191
 #3: ffff888030864f40 (&device->compat_devs_mutex){+.+.}-{4:4}, at: add_one_compat_dev+0x10d/0x710 drivers/infiniband/core/device.c:950
3 locks held by syz-executor/15449:
 #0: ffffffff8fcdc850 (pernet_ops_rwsem){++++}-{4:4}, at: copy_net_ns+0x328/0x570 net/core/net_namespace.c:496
 #1: ffffffff8fa55f30 (devices_rwsem){++++}-{4:4}, at: rdma_dev_init_net+0x198/0x280 drivers/infiniband/core/device.c:1186
 #2: ffffffff8fa560f0 (rdma_nets_rwsem){++++}-{4:4}, at: rdma_dev_init_net+0x1e6/0x280 drivers/infiniband/core/device.c:1191
3 locks held by syz-executor/15454:
 #0: ffffffff8fcdc850 (pernet_ops_rwsem){++++}-{4:4}, at: copy_net_ns+0x328/0x570 net/core/net_namespace.c:496
 #1: ffffffff8fa55f30 (devices_rwsem){++++}-{4:4}, at: rdma_dev_init_net+0x198/0x280 drivers/infiniband/core/device.c:1186
 #2: ffffffff8fa560f0 (rdma_nets_rwsem){++++}-{4:4}, at: rdma_dev_init_net+0x1e6/0x280 drivers/infiniband/core/device.c:1191
3 locks held by syz-executor/15458:
 #0: ffffffff8fcdc850 (pernet_ops_rwsem){++++}-{4:4}, at: copy_net_ns+0x328/0x570 net/core/net_namespace.c:496
 #1: ffffffff8fa55f30 (devices_rwsem){++++}-{4:4}, at: rdma_dev_init_net+0x198/0x280 drivers/infiniband/core/device.c:1186
 #2: ffffffff8fa560f0 (rdma_nets_rwsem){++++}-{4:4}, at: rdma_dev_init_net+0x1e6/0x280 drivers/infiniband/core/device.c:1191
3 locks held by syz-executor/15461:
 #0: ffffffff8fcdc850 (pernet_ops_rwsem){++++}-{4:4}, at: copy_net_ns+0x328/0x570 net/core/net_namespace.c:496
 #1: ffffffff8fa55f30 (devices_rwsem){++++}-{4:4}, at: rdma_dev_init_net+0x198/0x280 drivers/infiniband/core/device.c:1186
 #2: ffffffff8fa560f0 (rdma_nets_rwsem){++++}-{4:4}, at: rdma_dev_init_net+0x1e6/0x280 drivers/infiniband/core/device.c:1191
3 locks held by syz-executor/15464:
 #0: ffffffff8fcdc850 (pernet_ops_rwsem){++++}-{4:4}, at: copy_net_ns+0x328/0x570 net/core/net_namespace.c:496
 #1: ffffffff8fa55f30 (devices_rwsem){++++}-{4:4}, at: rdma_dev_init_net+0x198/0x280 drivers/infiniband/core/device.c:1186
 #2: ffffffff8fa560f0 (rdma_nets_rwsem){++++}-{4:4}, at: rdma_dev_init_net+0x1e6/0x280 drivers/infiniband/core/device.c:1191
3 locks held by syz-executor/15467:
 #0: ffffffff8fcdc850 (pernet_ops_rwsem){++++}-{4:4}, at: copy_net_ns+0x328/0x570 net/core/net_namespace.c:496
 #1: ffffffff8fa55f30 (devices_rwsem){++++}-{4:4}, at: rdma_dev_init_net+0x198/0x280 drivers/infiniband/core/device.c:1186
 #2: ffffffff8fa560f0 (rdma_nets_rwsem){++++}-{4:4}, at: rdma_dev_init_net+0x1e6/0x280 drivers/infiniband/core/device.c:1191

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.12.0-syzkaller-09073-g9f16d5e6f220 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xff4/0x1040 kernel/hung_task.c:379
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 5946 Comm: kworker/1:6 Not tainted 6.12.0-syzkaller-09073-g9f16d5e6f220 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: events_power_efficient neigh_periodic_work
RIP: 0010:lockdep_hardirqs_off+0x80/0x110 kernel/locking/lockdep.c:4508
Code: 8b 05 ec 51 30 74 85 c0 74 54 65 48 8b 1c 25 c0 d4 03 00 48 c7 c7 a0 d8 0a 8c e8 2b 1c 00 00 65 c7 05 c8 51 30 74 00 00 00 00 <4c> 89 b3 88 0a 00 00 8b 83 78 0a 00 00 ff c0 89 83 78 0a 00 00 89
RSP: 0018:ffffc90000a17288 EFLAGS: 00000086
RAX: 0000000000000001 RBX: ffff888030fbbc00 RCX: ffffc90000a17203
RDX: 0000000000000005 RSI: ffffffff8c0ad8a0 RDI: ffffffff8c6154a0
RBP: ffffc90000a17370 R08: ffffffff901e4037 R09: 1ffffffff203c806
R10: dffffc0000000000 R11: fffffbfff203c807 R12: dffffc0000000000
R13: 1ffff92000142e60 R14: ffffffff81583326 R15: 0000000000000200
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055555b78a608 CR3: 000000000e738000 CR4: 0000000000350ef0
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 trace_hardirqs_off+0x12/0x40 kernel/trace/trace_preemptirq.c:73
 __local_bh_enable_ip+0x106/0x200 kernel/softirq.c:364
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 rcu_read_unlock_bh include/linux/rcupdate.h:919 [inline]
 __dev_queue_xmit+0x1775/0x3f50 net/core/dev.c:4461
 dev_queue_xmit include/linux/netdevice.h:3168 [inline]
 br_dev_queue_push_xmit+0x726/0x900 net/bridge/br_forward.c:53
 NF_HOOK+0x702/0x7c0 include/linux/netfilter.h:314
 br_nf_post_routing+0xa20/0xe80 net/bridge/br_netfilter_hooks.c:997
 nf_hook_entry_hookfn include/linux/netfilter.h:154 [inline]
 nf_hook_slow+0xc5/0x220 net/netfilter/core.c:626
 nf_hook include/linux/netfilter.h:269 [inline]
 NF_HOOK+0x2a7/0x460 include/linux/netfilter.h:312
 br_forward_finish+0xd8/0x130 net/bridge/br_forward.c:66
 br_nf_forward_finish+0xb49/0xfb0 net/bridge/br_netfilter_hooks.c:693
 NF_HOOK+0x702/0x7c0 include/linux/netfilter.h:314
 br_nf_forward_ip+0x61e/0x7b0 net/bridge/br_netfilter_hooks.c:747
 nf_hook_entry_hookfn include/linux/netfilter.h:154 [inline]
 nf_hook_slow+0xc5/0x220 net/netfilter/core.c:626
 nf_hook include/linux/netfilter.h:269 [inline]
 NF_HOOK+0x2a7/0x460 include/linux/netfilter.h:312
 __br_forward+0x489/0x660 net/bridge/br_forward.c:115
 deliver_clone net/bridge/br_forward.c:131 [inline]
 maybe_deliver+0xb3/0x150 net/bridge/br_forward.c:190
 br_flood+0x2e4/0x660 net/bridge/br_forward.c:236
 br_handle_frame_finish+0x18ba/0x1fe0 net/bridge/br_input.c:215
 br_nf_hook_thresh+0x474/0x590
 br_nf_pre_routing_finish_ipv6+0xaa0/0xdd0
 NF_HOOK include/linux/netfilter.h:314 [inline]
 br_nf_pre_routing_ipv6+0x379/0x770 net/bridge/br_netfilter_ipv6.c:184
 nf_hook_entry_hookfn include/linux/netfilter.h:154 [inline]
 nf_hook_bridge_pre net/bridge/br_input.c:277 [inline]
 br_handle_frame+0x9ff/0x1530 net/bridge/br_input.c:424
 __netif_receive_skb_core+0x14ed/0x4690 net/core/dev.c:5566
 __netif_receive_skb_one_core net/core/dev.c:5670 [inline]
 __netif_receive_skb+0x12f/0x650 net/core/dev.c:5785
 process_backlog+0x662/0x15b0 net/core/dev.c:6117
 __napi_poll+0xcd/0x490 net/core/dev.c:6877
 napi_poll net/core/dev.c:6946 [inline]
 net_rx_action+0x89b/0x1240 net/core/dev.c:7068
 handle_softirqs+0x2c7/0x980 kernel/softirq.c:554
 do_softirq+0x11b/0x1e0 kernel/softirq.c:455
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x1bb/0x200 kernel/softirq.c:382
 neigh_periodic_work+0xbcb/0xde0 net/core/neighbour.c:968
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa65/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
net_ratelimit: 8442 callbacks suppressed
bridge0: received packet on veth0_to_bridge with own address as source address (addr:5e:30:90:49:37:cb, vlan:0)


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

