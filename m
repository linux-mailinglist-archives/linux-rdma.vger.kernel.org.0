Return-Path: <linux-rdma+bounces-7223-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 650AFA1C830
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Jan 2025 14:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DC907A2E18
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Jan 2025 13:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AAD41487F4;
	Sun, 26 Jan 2025 13:59:24 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422F456446
	for <linux-rdma@vger.kernel.org>; Sun, 26 Jan 2025 13:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737899964; cv=none; b=DRKXZGWWR5DZCIgZ773ufo5KhBvagCIcJzYH/uXsMW3aX8gASMz/uWCw5Ens2dwIu4sArM394Sa9JIaAyeIpD7yS3DDG96Bfyja7zkE7pfwQ7+W/rJtB9GxJMkALAE2PFAUWwFVp4RGFf9c8MW+OYify/VsqD2Y/2PjTEQSC7dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737899964; c=relaxed/simple;
	bh=P+UMFG+e31zCpJVDnpUmqnTorckC9UuKiEJx8iAhAfE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ajKF3jf7CUG+rrFxuHu+YXQ67f4iNUg7BMT7k93NyM0l32FxQDvnpNGg1A+vmPMplciN1tjzUQ+LxSb9ZYCkEqU3zwP1JvZeSxU8UvMm264cr5zqwqpycshxI63G9DanFf0JGsYWrEjwrLP4GACMk+CGWGu3Ld9LisE/QWop0lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3cfba1ca53bso26123325ab.3
        for <linux-rdma@vger.kernel.org>; Sun, 26 Jan 2025 05:59:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737899961; x=1738504761;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BsXybfNGAizvjgp3GJiXaZSbLzKmPZggkqsDGAboXqE=;
        b=N75zsCpJDCHh8cy+VxEtHiG18TqVDuHS8rXIA6+FGfdcusIxPm0rLRZhsylX3161Hh
         87wBsHFoBt3FzA9a9SHLHbWyTic791Gne0pk+pHgdAs4e8GYWmNaaILEzjXqjE8ZMgLM
         tbaarbqQY1dW9Dfa/G+BLMzL2zkBoSLSqR4EpK6lEL7C++hS3ZBn6Nk85dqhYjlFaexA
         l1rK/sTQSbwMkxJ1PPt3vF4h6N8m2MYvkk3l5guw5bQljpbxTnHreZAZWtPZ6s4/Q/2O
         BHFpqCD0dNdEfu8Mj0cWiMvOUWd5s+KjyWWsN2j0NaVJO8zXRXG363aso7hRQ8yJBnN5
         u0Og==
X-Forwarded-Encrypted: i=1; AJvYcCWrkMUQ4TNobRhBFX9Qq3/5JW7IbnnHOC8Aqm5Tbdmg68+vRV2DCNN4KnIzTUmv76NenwQwEI3VHkYl@vger.kernel.org
X-Gm-Message-State: AOJu0YxxTWsn5EXCYmtDWZ+9+M5N0NaZCFU/em2UIk4IRuNRD7Aiw7a+
	tDdSOVJvpQUQlqH+g/mTm8OfeGNDwwyw0HJparj7h6xNP0ICVhJE9PbhcyFV1oS+mWwcv2cXqxT
	J4cUIZx3wZCgXOXNkF2U8uyD1VNWzqVMPZ99fkWkTQ/oYakQPzVqM0lE=
X-Google-Smtp-Source: AGHT+IEbMftfrZaTzbr9gSiQX9fmJj6oZnybe8imsFPCa522q/o7bWqWxZXXNenqFJnlF888h7VVXJCPVuC1WSDkXF/1PnFUqOd6
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca4c:0:b0:3cf:cbfb:b509 with SMTP id
 e9e14a558f8ab-3cfcbfbb7camr76237005ab.2.1737899961376; Sun, 26 Jan 2025
 05:59:21 -0800 (PST)
Date: Sun, 26 Jan 2025 05:59:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67963fb9.050a0220.11b1bb.0076.GAE@google.com>
Subject: [syzbot] [net?] [s390?] possible deadlock in smc_shutdown (2)
From: syzbot <syzbot+3667d719a932ebc28119@syzkaller.appspotmail.com>
To: agordeev@linux.ibm.com, alibuda@linux.alibaba.com, davem@davemloft.net, 
	edumazet@google.com, guwen@linux.alibaba.com, horms@kernel.org, 
	jaka@linux.ibm.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	tonylu@linux.alibaba.com, wenjia@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c4b9570cfb63 Merge tag 'audit-pr-20250121' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=122d4ab0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c857c6065c39b1e2
dashboard link: https://syzkaller.appspot.com/bug?extid=3667d719a932ebc28119
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-c4b9570c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f4f88f09e44f/vmlinux-c4b9570c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bb4658fd4384/bzImage-c4b9570c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3667d719a932ebc28119@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.13.0-syzkaller-02526-gc4b9570cfb63 #0 Not tainted
------------------------------------------------------
syz.2.21908/20249 is trying to acquire lock:
ffff88804fb90dd8 (sk_lock-AF_SMC){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1623 [inline]
ffff88804fb90dd8 (sk_lock-AF_SMC){+.+.}-{0:0}, at: smc_shutdown+0x65/0x7f0 net/smc/af_smc.c:2927

but task is already holding lock:
ffff88806efb3c70 (&nsock->tx_lock){+.+.}-{4:4}, at: sock_shutdown+0x16f/0x280 drivers/block/nbd.c:410

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #7 (&nsock->tx_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x19b/0xb10 kernel/locking/mutex.c:730
       sock_shutdown+0x16f/0x280 drivers/block/nbd.c:410
       nbd_clear_sock drivers/block/nbd.c:1415 [inline]
       nbd_clear_sock_ioctl drivers/block/nbd.c:1553 [inline]
       __nbd_ioctl drivers/block/nbd.c:1581 [inline]
       nbd_ioctl+0x49b/0xd60 drivers/block/nbd.c:1641
       compat_blkdev_ioctl+0x2f7/0x750 block/ioctl.c:749
       __do_compat_sys_ioctl+0x1cb/0x2c0 fs/ioctl.c:1004
       do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
       __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
       do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
       entry_SYSENTER_compat_after_hwframe+0x84/0x8e

-> #6 (&nbd->config_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x19b/0xb10 kernel/locking/mutex.c:730
       refcount_dec_and_mutex_lock+0x51/0xc0 lib/refcount.c:118
       nbd_config_put+0x31/0x750 drivers/block/nbd.c:1422
       nbd_release+0xb7/0x190 drivers/block/nbd.c:1734
       blkdev_put_whole+0xad/0xf0 block/bdev.c:679
       bdev_release+0x47e/0x6d0 block/bdev.c:1102
       blkdev_release+0x15/0x20 block/fops.c:660
       __fput+0x3f8/0xb60 fs/file_table.c:450
       __fput_sync+0xa1/0xc0 fs/file_table.c:536
       __do_sys_close fs/open.c:1547 [inline]
       __se_sys_close fs/open.c:1532 [inline]
       __x64_sys_close+0x86/0x100 fs/open.c:1532
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #5 (&disk->open_mutex){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x19b/0xb10 kernel/locking/mutex.c:730
       bdev_open+0x41a/0xe20 block/bdev.c:903
       bdev_file_open_by_dev block/bdev.c:1017 [inline]
       bdev_file_open_by_dev+0x17d/0x210 block/bdev.c:992
       disk_scan_partitions+0x1ed/0x320 block/genhd.c:374
       add_disk_fwnode+0x1006/0x1320 block/genhd.c:526
       pmem_attach_disk+0x9a1/0x13e0 drivers/nvdimm/pmem.c:576
       nd_pmem_probe+0x1a9/0x1f0 drivers/nvdimm/pmem.c:649
       nvdimm_bus_probe+0x169/0x5d0 drivers/nvdimm/bus.c:94
       call_driver_probe drivers/base/dd.c:579 [inline]
       really_probe+0x23e/0xa90 drivers/base/dd.c:658
       __driver_probe_device+0x1de/0x440 drivers/base/dd.c:800
       driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:830
       __driver_attach+0x283/0x580 drivers/base/dd.c:1216
       bus_for_each_dev+0x13c/0x1d0 drivers/base/bus.c:370
       bus_add_driver+0x2e9/0x690 drivers/base/bus.c:675
       driver_register+0x15c/0x4b0 drivers/base/driver.c:246
       __nd_driver_register+0x103/0x1a0 drivers/nvdimm/bus.c:622
       do_one_initcall+0x128/0x630 init/main.c:1267
       do_initcall_level init/main.c:1329 [inline]
       do_initcalls init/main.c:1345 [inline]
       do_basic_setup init/main.c:1364 [inline]
       kernel_init_freeable+0x58f/0x8b0 init/main.c:1578
       kernel_init+0x1c/0x2b0 init/main.c:1467
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:148
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #4 (&nvdimm_namespace_key){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x19b/0xb10 kernel/locking/mutex.c:730
       device_lock include/linux/device.h:1014 [inline]
       uevent_show+0x188/0x3b0 drivers/base/core.c:2729
       dev_attr_show+0x53/0xe0 drivers/base/core.c:2423
       sysfs_kf_seq_show+0x223/0x3e0 fs/sysfs/file.c:59
       seq_read_iter+0x4f4/0x12b0 fs/seq_file.c:230
       kernfs_fop_read_iter+0x414/0x580 fs/kernfs/file.c:279
       new_sync_read fs/read_write.c:484 [inline]
       vfs_read+0x87f/0xbe0 fs/read_write.c:565
       ksys_read+0x12b/0x250 fs/read_write.c:708
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #3 (kn->active#5){++++}-{0:0}:
       kernfs_drain+0x48f/0x590 fs/kernfs/dir.c:500
       __kernfs_remove+0x281/0x670 fs/kernfs/dir.c:1486
       kernfs_remove_by_name_ns+0xb2/0x130 fs/kernfs/dir.c:1694
       sysfs_remove_file include/linux/sysfs.h:794 [inline]
       device_remove_file drivers/base/core.c:3047 [inline]
       device_remove_file drivers/base/core.c:3043 [inline]
       device_del+0x381/0x9f0 drivers/base/core.c:3852
       unregister_netdevice_many_notify+0x105d/0x1e60 net/core/dev.c:11581
       unregister_netdevice_many net/core/dev.c:11609 [inline]
       unregister_netdevice_queue+0x307/0x3f0 net/core/dev.c:11481
       unregister_netdevice include/linux/netdevice.h:3192 [inline]
       unregister_netdev+0x1c/0x30 net/core/dev.c:11627
       slcan_close+0x76/0x1a0 drivers/net/can/slcan/slcan-core.c:866
       tty_ldisc_close+0x111/0x1a0 drivers/tty/tty_ldisc.c:455
       tty_ldisc_kill+0x8e/0x150 drivers/tty/tty_ldisc.c:613
       tty_ldisc_release+0x116/0x2a0 drivers/tty/tty_ldisc.c:781
       tty_release_struct+0x23/0xe0 drivers/tty/tty_io.c:1690
       tty_release+0xe25/0x1410 drivers/tty/tty_io.c:1861
       __fput+0x3f8/0xb60 fs/file_table.c:450
       task_work_run+0x14e/0x250 kernel/task_work.c:239
       resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
       exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
       exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
       __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
       syscall_exit_to_user_mode+0x27b/0x2a0 kernel/entry/common.c:218
       __do_fast_syscall_32+0x80/0x120 arch/x86/entry/common.c:389
       do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
       entry_SYSENTER_compat_after_hwframe+0x84/0x8e

-> #2 (rtnl_mutex){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x19b/0xb10 kernel/locking/mutex.c:730
       start_sync_thread+0x12d/0x2740 net/netfilter/ipvs/ip_vs_sync.c:1761
       do_ip_vs_set_ctl+0x41c/0x1070 net/netfilter/ipvs/ip_vs_ctl.c:2732
       nf_setsockopt+0x8a/0xf0 net/netfilter/nf_sockopt.c:101
       ip_setsockopt+0xcb/0xf0 net/ipv4/ip_sockglue.c:1424
       tcp_setsockopt+0xa4/0x100 net/ipv4/tcp.c:4030
       smc_setsockopt+0x1b4/0xc00 net/smc/af_smc.c:3078
       do_sock_setsockopt+0x222/0x480 net/socket.c:2313
       __sys_setsockopt+0x1a0/0x230 net/socket.c:2338
       __do_sys_setsockopt net/socket.c:2344 [inline]
       __se_sys_setsockopt net/socket.c:2341 [inline]
       __ia32_sys_setsockopt+0xbc/0x160 net/socket.c:2341
       do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
       __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
       do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
       entry_SYSENTER_compat_after_hwframe+0x84/0x8e

-> #1 (&smc->clcsock_release_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x19b/0xb10 kernel/locking/mutex.c:730
       smc_switch_to_fallback+0x2d/0xa00 net/smc/af_smc.c:903
       smc_setsockopt+0xa7b/0xc00 net/smc/af_smc.c:3101
       do_sock_setsockopt+0x222/0x480 net/socket.c:2313
       __sys_setsockopt+0x1a0/0x230 net/socket.c:2338
       __do_sys_setsockopt net/socket.c:2344 [inline]
       __se_sys_setsockopt net/socket.c:2341 [inline]
       __ia32_sys_setsockopt+0xbc/0x160 net/socket.c:2341
       do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
       __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
       do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
       entry_SYSENTER_compat_after_hwframe+0x84/0x8e

-> #0 (sk_lock-AF_SMC){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3163 [inline]
       check_prevs_add kernel/locking/lockdep.c:3282 [inline]
       validate_chain kernel/locking/lockdep.c:3906 [inline]
       __lock_acquire+0x249e/0x3c40 kernel/locking/lockdep.c:5228
       lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5851
       lock_sock_nested+0x3a/0xf0 net/core/sock.c:3625
       lock_sock include/net/sock.h:1623 [inline]
       smc_shutdown+0x65/0x7f0 net/smc/af_smc.c:2927
       nbd_mark_nsock_dead+0xae/0x5d0 drivers/block/nbd.c:318
       sock_shutdown+0x17c/0x280 drivers/block/nbd.c:411
       nbd_clear_sock drivers/block/nbd.c:1415 [inline]
       nbd_clear_sock_ioctl drivers/block/nbd.c:1553 [inline]
       __nbd_ioctl drivers/block/nbd.c:1581 [inline]
       nbd_ioctl+0x49b/0xd60 drivers/block/nbd.c:1641
       compat_blkdev_ioctl+0x2f7/0x750 block/ioctl.c:749
       __do_compat_sys_ioctl+0x1cb/0x2c0 fs/ioctl.c:1004
       do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
       __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
       do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
       entry_SYSENTER_compat_after_hwframe+0x84/0x8e

other info that might help us debug this:

Chain exists of:
  sk_lock-AF_SMC --> &nbd->config_lock --> &nsock->tx_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&nsock->tx_lock);
                               lock(&nbd->config_lock);
                               lock(&nsock->tx_lock);
  lock(sk_lock-AF_SMC);

 *** DEADLOCK ***

2 locks held by syz.2.21908/20249:
 #0: ffff888024364998 (&nbd->config_lock){+.+.}-{4:4}, at: nbd_ioctl+0x151/0xd60 drivers/block/nbd.c:1634
 #1: ffff88806efb3c70 (&nsock->tx_lock){+.+.}-{4:4}, at: sock_shutdown+0x16f/0x280 drivers/block/nbd.c:410

stack backtrace:
CPU: 3 UID: 0 PID: 20249 Comm: syz.2.21908 Not tainted 6.13.0-syzkaller-02526-gc4b9570cfb63 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_circular_bug+0x490/0x760 kernel/locking/lockdep.c:2076
 check_noncircular+0x31a/0x400 kernel/locking/lockdep.c:2208
 check_prev_add kernel/locking/lockdep.c:3163 [inline]
 check_prevs_add kernel/locking/lockdep.c:3282 [inline]
 validate_chain kernel/locking/lockdep.c:3906 [inline]
 __lock_acquire+0x249e/0x3c40 kernel/locking/lockdep.c:5228
 lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5851
 lock_sock_nested+0x3a/0xf0 net/core/sock.c:3625
 lock_sock include/net/sock.h:1623 [inline]
 smc_shutdown+0x65/0x7f0 net/smc/af_smc.c:2927
 nbd_mark_nsock_dead+0xae/0x5d0 drivers/block/nbd.c:318
 sock_shutdown+0x17c/0x280 drivers/block/nbd.c:411
 nbd_clear_sock drivers/block/nbd.c:1415 [inline]
 nbd_clear_sock_ioctl drivers/block/nbd.c:1553 [inline]
 __nbd_ioctl drivers/block/nbd.c:1581 [inline]
 nbd_ioctl+0x49b/0xd60 drivers/block/nbd.c:1641
 compat_blkdev_ioctl+0x2f7/0x750 block/ioctl.c:749
 __do_compat_sys_ioctl+0x1cb/0x2c0 fs/ioctl.c:1004
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf7f0f579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f506655c EFLAGS: 00000296 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 000000000000ab04
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000296 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
block nbd2: shutting down sockets
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	10 06                	adc    %al,(%rsi)
   2:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
   6:	10 07                	adc    %al,(%rdi)
   8:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   c:	10 08                	adc    %cl,(%rax)
   e:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  1e:	00 51 52             	add    %dl,0x52(%rcx)
  21:	55                   	push   %rbp
  22:	89 e5                	mov    %esp,%ebp
  24:	0f 34                	sysenter
  26:	cd 80                	int    $0x80
* 28:	5d                   	pop    %rbp <-- trapping instruction
  29:	5a                   	pop    %rdx
  2a:	59                   	pop    %rcx
  2b:	c3                   	ret
  2c:	90                   	nop
  2d:	90                   	nop
  2e:	90                   	nop
  2f:	90                   	nop
  30:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  37:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi


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

