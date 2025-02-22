Return-Path: <linux-rdma+bounces-8014-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0821DA40BBD
	for <lists+linux-rdma@lfdr.de>; Sat, 22 Feb 2025 22:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E2123BA0AC
	for <lists+linux-rdma@lfdr.de>; Sat, 22 Feb 2025 21:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907A82045B6;
	Sat, 22 Feb 2025 21:28:21 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F56220125B
	for <linux-rdma@vger.kernel.org>; Sat, 22 Feb 2025 21:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740259701; cv=none; b=ZM/MIo34AClZGbmRqzsW9j4CfV8pPzGmreqyfVWSYBMA6m15U4pxbizTudYujx8yRD7sSJLrzdezzVQ1gvT7GcRVWOKeWSQeci4C672fpV06fZSlHB41+e0MCZsWqZhukrYtjJfRAr3AnhIWboAkWNCPWd5CHepp10SMWmLbSuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740259701; c=relaxed/simple;
	bh=rrUPmthSZymIJllcQ+NtdBq8igi0G5OV3N5Dh2FAI2A=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Mwdc1XalZkls2sHRTEOYgPeIzCWbeQ8tB3vmdUpmQahBqmsA+r/iF/IPGaFHStHgXiU32aEGERgZ1XVjv4/FwG7xZkZJIK9Q7GvmySw/SmTwBJjjHHXbx98q69OZGziBMg9f+F86RPjp6qP/llRU9XU8bldEa0IKsNgimWS2r18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3ce8cdf1898so25020405ab.1
        for <linux-rdma@vger.kernel.org>; Sat, 22 Feb 2025 13:28:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740259698; x=1740864498;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nMvR6VQwoiSvHdEtmggzmS+ZR2UuWrCXxkffOuRiO/8=;
        b=FIIgFs2KyRZ0TqGXfuM8NXvsT3oZI1oNQ1rnLEc9qlGSGaRkOitSHP/UNQA/3ncSc5
         zp/FeKi7/xhCcef5zsLuaVzv3v/kh4/A2yRnTZlp/mnOMmti2z2dZoHp7pT5snXCaRkF
         ejHD9m6qBHAlTWhnOY3sXWdLJgk+0y4P+pG1TjACU0fkIxCmXDlVRBBDX/1vhNadk4/5
         SasARn3gk//ySD98fjQbg1t1Sc7AwO6OeUhokmC33zrdn8POILQlrAPeJHaWUyziRGv4
         WK6pvGiwuecEDE7bR9ZXinf44ly1nGTryHoi2mWZj9iWYspRTnRRaALtaoSrcdZPUhvK
         4sPw==
X-Forwarded-Encrypted: i=1; AJvYcCXOwbaygsFEcqlPzz42ehGgiNEI7p6Txcnp5Xr8KfLHpqsIjt9AxeZbSysQfcfL8BZXNAnWs1YNmgsw@vger.kernel.org
X-Gm-Message-State: AOJu0YycFMgimnbxuoAUrRC83poL8LT/Vk3VvR8Ensbz4FQdHdvG79tA
	of5yrGIYBUXiRbzzdD61ISHLl7Nq28dU/T9wPw+O5Nz4xZXJkGG+rvkFMjcsbDx33uFl1M33F2p
	L1bmJBX0jXwaXkxiSaVbJdOSXobXvOM6n0ctOUmctaNbMPWwERdXf3/Y=
X-Google-Smtp-Source: AGHT+IEwB438rF8gnGs3M3wvUu+QC7cusa+f51xI7QQ0r2qdtyma4J6xKMgS5JWlLazsdO4Rxtq3+o/3xtOXEDZiny34oww5fZV/
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3dc4:b0:3ce:4b12:fa17 with SMTP id
 e9e14a558f8ab-3d2cb52d4bfmr76842325ab.19.1740259698500; Sat, 22 Feb 2025
 13:28:18 -0800 (PST)
Date: Sat, 22 Feb 2025 13:28:18 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67ba4172.050a0220.bbfd1.0001.GAE@google.com>
Subject: [syzbot] [net?] [s390?] possible deadlock in smc_sendmsg
From: syzbot <syzbot+6cc62f8d77a830dba3a7@syzkaller.appspotmail.com>
To: agordeev@linux.ibm.com, alibuda@linux.alibaba.com, davem@davemloft.net, 
	edumazet@google.com, guwen@linux.alibaba.com, horms@kernel.org, 
	jaka@linux.ibm.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	tonylu@linux.alibaba.com, wenjia@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6537cfb395f3 Merge tag 'sound-6.14-rc4' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=146177df980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f4f6914bcba459be
dashboard link: https://syzkaller.appspot.com/bug?extid=6cc62f8d77a830dba3a7
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-6537cfb3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c6f2faba4c42/vmlinux-6537cfb3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/16fc32b66fc0/bzImage-6537cfb3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6cc62f8d77a830dba3a7@syzkaller.appspotmail.com

block nbd4: NBD_DISCONNECT
======================================================
WARNING: possible circular locking dependency detected
6.14.0-rc3-syzkaller-00060-g6537cfb395f3 #0 Not tainted
------------------------------------------------------
syz.4.3048/15507 is trying to acquire lock:
ffff88804ed2bbd8 (sk_lock-AF_SMC){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1624 [inline]
ffff88804ed2bbd8 (sk_lock-AF_SMC){+.+.}-{0:0}, at: smc_sendmsg+0x47/0x520 net/smc/af_smc.c:2775

but task is already holding lock:
ffff888028f74e70 (&nsock->tx_lock){+.+.}-{4:4}, at: send_disconnects drivers/block/nbd.c:1394 [inline]
ffff888028f74e70 (&nsock->tx_lock){+.+.}-{4:4}, at: nbd_disconnect+0x321/0x540 drivers/block/nbd.c:1410

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #6 (&nsock->tx_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x19b/0xb10 kernel/locking/mutex.c:730
       sock_shutdown+0x16f/0x280 drivers/block/nbd.c:410
       nbd_clear_sock drivers/block/nbd.c:1416 [inline]
       nbd_config_put+0x1e6/0x750 drivers/block/nbd.c:1440
       nbd_release+0xb7/0x190 drivers/block/nbd.c:1735
       blkdev_put_whole+0xad/0xf0 block/bdev.c:679
       bdev_release+0x47e/0x6d0 block/bdev.c:1102
       blkdev_release+0x15/0x20 block/fops.c:660
       __fput+0x3ff/0xb70 fs/file_table.c:464
       task_work_run+0x14e/0x250 kernel/task_work.c:227
       resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
       exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
       exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
       __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
       syscall_exit_to_user_mode+0x27b/0x2a0 kernel/entry/common.c:218
       do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #5 (&nbd->config_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x19b/0xb10 kernel/locking/mutex.c:730
       refcount_dec_and_mutex_lock+0x51/0xc0 lib/refcount.c:118
       nbd_config_put+0x31/0x750 drivers/block/nbd.c:1423
       nbd_release+0xb7/0x190 drivers/block/nbd.c:1735
       blkdev_put_whole+0xad/0xf0 block/bdev.c:679
       bdev_release+0x47e/0x6d0 block/bdev.c:1102
       blkdev_release+0x15/0x20 block/fops.c:660
       __fput+0x3ff/0xb70 fs/file_table.c:464
       __fput_sync+0xa1/0xc0 fs/file_table.c:550
       __do_sys_close fs/open.c:1580 [inline]
       __se_sys_close fs/open.c:1565 [inline]
       __x64_sys_close+0x86/0x100 fs/open.c:1565
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #4 (&disk->open_mutex){+.+.}-{4:4}:
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
       bus_add_driver+0x2e9/0x690 drivers/base/bus.c:678
       driver_register+0x15c/0x4b0 drivers/base/driver.c:249
       __nd_driver_register+0x103/0x1a0 drivers/nvdimm/bus.c:622
       do_one_initcall+0x128/0x700 init/main.c:1257
       do_initcall_level init/main.c:1319 [inline]
       do_initcalls init/main.c:1335 [inline]
       do_basic_setup init/main.c:1354 [inline]
       kernel_init_freeable+0x5c7/0x900 init/main.c:1568
       kernel_init+0x1c/0x2b0 init/main.c:1457
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:148
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #3 (&nvdimm_namespace_key){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x19b/0xb10 kernel/locking/mutex.c:730
       device_lock include/linux/device.h:1030 [inline]
       uevent_show+0x188/0x3b0 drivers/base/core.c:2729
       dev_attr_show+0x53/0xe0 drivers/base/core.c:2423
       sysfs_kf_seq_show+0x23e/0x410 fs/sysfs/file.c:59
       seq_read_iter+0x4f4/0x12b0 fs/seq_file.c:230
       kernfs_fop_read_iter+0x414/0x580 fs/kernfs/file.c:279
       new_sync_read fs/read_write.c:484 [inline]
       vfs_read+0x886/0xbf0 fs/read_write.c:565
       ksys_read+0x12b/0x250 fs/read_write.c:708
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (kn->active#5){++++}-{0:0}:
       kernfs_drain+0x48f/0x590 fs/kernfs/dir.c:500
       __kernfs_remove+0x281/0x670 fs/kernfs/dir.c:1487
       kernfs_remove_by_name_ns+0xb2/0x130 fs/kernfs/dir.c:1695
       sysfs_remove_file include/linux/sysfs.h:794 [inline]
       device_remove_file drivers/base/core.c:3047 [inline]
       device_remove_file drivers/base/core.c:3043 [inline]
       device_del+0x381/0x9f0 drivers/base/core.c:3852
       unregister_netdevice_many_notify+0x13aa/0x1f30 net/core/dev.c:11838
       unregister_netdevice_many net/core/dev.c:11866 [inline]
       unregister_netdevice_queue+0x307/0x3f0 net/core/dev.c:11736
       unregister_netdevice include/linux/netdevice.h:3335 [inline]
       unregister_netdev+0x21/0x30 net/core/dev.c:11886
       sixpack_close+0x1e7/0x2f0 drivers/net/hamradio/6pack.c:661
       tty_ldisc_close+0x111/0x1a0 drivers/tty/tty_ldisc.c:455
       tty_ldisc_kill+0x8e/0x150 drivers/tty/tty_ldisc.c:613
       tty_ldisc_release+0x116/0x2a0 drivers/tty/tty_ldisc.c:781
       tty_release_struct+0x23/0xe0 drivers/tty/tty_io.c:1690
       tty_release+0xe25/0x1410 drivers/tty/tty_io.c:1861
       __fput+0x3ff/0xb70 fs/file_table.c:464
       task_work_run+0x14e/0x250 kernel/task_work.c:227
       resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
       exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
       exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
       __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
       syscall_exit_to_user_mode+0x27b/0x2a0 kernel/entry/common.c:218
       do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (rtnl_mutex){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x19b/0xb10 kernel/locking/mutex.c:730
       smc_vlan_by_tcpsk+0x251/0x620 net/smc/smc_core.c:1908
       __smc_connect+0x44d/0x4890 net/smc/af_smc.c:1520
       smc_connect+0x2fc/0x760 net/smc/af_smc.c:1696
       __sys_connect_file+0x13e/0x1a0 net/socket.c:2045
       __sys_connect+0x14f/0x170 net/socket.c:2064
       __do_sys_connect net/socket.c:2070 [inline]
       __se_sys_connect net/socket.c:2067 [inline]
       __x64_sys_connect+0x72/0xb0 net/socket.c:2067
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (sk_lock-AF_SMC){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3163 [inline]
       check_prevs_add kernel/locking/lockdep.c:3282 [inline]
       validate_chain kernel/locking/lockdep.c:3906 [inline]
       __lock_acquire+0x249e/0x3c40 kernel/locking/lockdep.c:5228
       lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5851
       lock_sock_nested+0x3a/0xf0 net/core/sock.c:3645
       lock_sock include/net/sock.h:1624 [inline]
       smc_sendmsg+0x47/0x520 net/smc/af_smc.c:2775
       sock_sendmsg_nosec net/socket.c:718 [inline]
       __sock_sendmsg net/socket.c:733 [inline]
       sock_sendmsg+0x3d3/0x490 net/socket.c:756
       __sock_xmit+0x1e8/0x4f0 drivers/block/nbd.c:574
       sock_xmit drivers/block/nbd.c:602 [inline]
       send_disconnects drivers/block/nbd.c:1395 [inline]
       nbd_disconnect+0x390/0x540 drivers/block/nbd.c:1410
       __nbd_ioctl drivers/block/nbd.c:1580 [inline]
       nbd_ioctl+0x8d1/0xd60 drivers/block/nbd.c:1642
       blkdev_ioctl+0x276/0x6d0 block/ioctl.c:693
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:906 [inline]
       __se_sys_ioctl fs/ioctl.c:892 [inline]
       __x64_sys_ioctl+0x190/0x200 fs/ioctl.c:892
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

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

2 locks held by syz.4.3048/15507:
 #0: ffff888026642198 (&nbd->config_lock){+.+.}-{4:4}, at: nbd_ioctl+0x151/0xd60 drivers/block/nbd.c:1635
 #1: ffff888028f74e70 (&nsock->tx_lock){+.+.}-{4:4}, at: send_disconnects drivers/block/nbd.c:1394 [inline]
 #1: ffff888028f74e70 (&nsock->tx_lock){+.+.}-{4:4}, at: nbd_disconnect+0x321/0x540 drivers/block/nbd.c:1410

stack backtrace:
CPU: 1 UID: 0 PID: 15507 Comm: syz.4.3048 Not tainted 6.14.0-rc3-syzkaller-00060-g6537cfb395f3 #0
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
 lock_sock_nested+0x3a/0xf0 net/core/sock.c:3645
 lock_sock include/net/sock.h:1624 [inline]
 smc_sendmsg+0x47/0x520 net/smc/af_smc.c:2775
 sock_sendmsg_nosec net/socket.c:718 [inline]
 __sock_sendmsg net/socket.c:733 [inline]
 sock_sendmsg+0x3d3/0x490 net/socket.c:756
 __sock_xmit+0x1e8/0x4f0 drivers/block/nbd.c:574
 sock_xmit drivers/block/nbd.c:602 [inline]
 send_disconnects drivers/block/nbd.c:1395 [inline]
 nbd_disconnect+0x390/0x540 drivers/block/nbd.c:1410
 __nbd_ioctl drivers/block/nbd.c:1580 [inline]
 nbd_ioctl+0x8d1/0xd60 drivers/block/nbd.c:1642
 blkdev_ioctl+0x276/0x6d0 block/ioctl.c:693
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl fs/ioctl.c:892 [inline]
 __x64_sys_ioctl+0x190/0x200 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0b5198cde9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0b52883038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f0b51ba6080 RCX: 00007f0b5198cde9
RDX: 0000000000000000 RSI: 000000000000ab08 RDI: 0000000000000006
RBP: 00007f0b51a0e2a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f0b51ba6080 R15: 00007ffce7c4c0d8
 </TASK>
block nbd4: Send disconnect failed -107
block nbd4: Disconnected due to user request.
block nbd4: shutting down sockets


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

