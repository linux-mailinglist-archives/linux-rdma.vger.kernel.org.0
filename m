Return-Path: <linux-rdma+bounces-5465-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9CB9A9B40
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Oct 2024 09:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA4291C20D0D
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Oct 2024 07:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0F6152160;
	Tue, 22 Oct 2024 07:39:30 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505C214F108
	for <linux-rdma@vger.kernel.org>; Tue, 22 Oct 2024 07:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729582770; cv=none; b=UKNI0ptvTfGu62WAAhs7DU8JozhzpmmwtC/4BlzR/3mtDfJNMM6dvNTL4S5QnAWGdWMCsWISi0YNgZVJPDGgJoBuu3aOLq8/q3KmDAKqwWRhzDxo7bAi5coKNUMmOvxgJmdQ6S0sc0SJkltnMFRXaWY+5/MnRhlA2N70DMCIqPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729582770; c=relaxed/simple;
	bh=5BbWkbubTzGK4x6DQo6P+kSgJnMoPtBqIZDHft31H2Q=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=sxr4DWMFpwAkMeJM2r1pNR38YYahblqr7Rg9q+XDE4cEKOXzL7Rtg7YK9eTstPiSeucLE/skGWvgrCu0ui636qc+V6yfmoX706ICQuVufxCdVk2Ccx/EUMyVkxZ32y9Hpsc2lpENx+EE3X00UZn46we4jeef4WGySOnCJ1tb56U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-83aecd993faso18546039f.0
        for <linux-rdma@vger.kernel.org>; Tue, 22 Oct 2024 00:39:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729582767; x=1730187567;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bOxtat44Y2RYiN+LCuyvf7LYJp8zSpD54vu6eRKyxCE=;
        b=iFtp7Xm9T2iMLJb3ejDCCFH0tRB4jTmFPKbSS2wpHNykvVm7ucaNeNs8FODAtiw7ly
         QunEVIcm8K6CQwCyEryhGEmxlDC/2BrBx8ueijF9kZWWm3qgFE6w3tTeainufirD/0+O
         fEfAnYRmGC8W1P6QviXRxybsNjKq7S6dhI9xVxFjbp1pDTeNfhdksxxZMDNzZQ9SJyej
         UzMopa53iHC0wOkE2fVQB4VOREbenjMSnAs1czBP7JAT2i5aGc8vr8Vv8mS6oPbd1C0a
         HtbOFxV7MMyxO9zpL1gVRWzV5T4doT8WVvDi9PwvHVFLGM6baJvRRTTxaIMrlojj+kT0
         AkRw==
X-Forwarded-Encrypted: i=1; AJvYcCVm9bzkvSa2AyNG26Qx8xmBHXTCKCQsawHrs3bR5rPYzEBj4KcOUOvmJQXwBuvH1PQ6Fj26y5FUQE7N@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7IoGIVOnDK92VwdrSWkrM4Pv3Uv+omamrY4By/vzr9Bv6N5Q+
	S4oUnLwQ7vUw1dik5F/7TdSzqRn4L0yrrKh3tQ5KdOLb0ABNPApHbfDyVnfQDfSTYi8kf1KAzhf
	gGd7uLI6ee0b4WFqTB8fA160DEKT3K17P3Uy38UFv9DMlFQeJmfFiJMM=
X-Google-Smtp-Source: AGHT+IH/8TB3tm7NnGH/65IJRKsRVg+S/mC1enmIwM8iBc6HZgwYMvEMX7Eu5BhRypFwNUVOLldPQ9ct62GKZVTsCDpoFQ7DMpyE
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c07:b0:3a3:a5c5:38d8 with SMTP id
 e9e14a558f8ab-3a4cc018857mr16024805ab.3.1729582767419; Tue, 22 Oct 2024
 00:39:27 -0700 (PDT)
Date: Tue, 22 Oct 2024 00:39:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <671756af.050a0220.10f4f4.010f.GAE@google.com>
Subject: [syzbot] [rdma?] INFO: task hung in add_one_compat_dev (3)
From: syzbot <syzbot+6dee15fdb0606ef7b6ba@syzkaller.appspotmail.com>
To: jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    eca631b8fe80 Merge tag 'f2fs-6.12-rc4' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10d72727980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=164d2822debd8b0d
dashboard link: https://syzkaller.appspot.com/bug?extid=6dee15fdb0606ef7b6ba
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f661a00bf2ab/disk-eca631b8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d510d4326c8a/vmlinux-eca631b8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e96fd1bbbe15/bzImage-eca631b8.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6dee15fdb0606ef7b6ba@syzkaller.appspotmail.com

INFO: task syz-executor:27961 blocked for more than 143 seconds.
      Not tainted 6.12.0-rc3-syzkaller-00013-geca631b8fe80 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:24128 pid:27961 tgid:27961 ppid:1      flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0x1843/0x4ae0 kernel/sched/core.c:6682
 __schedule_loop kernel/sched/core.c:6759 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6774
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6831
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 add_one_compat_dev+0x10d/0x710 drivers/infiniband/core/device.c:949
 rdma_dev_init_net+0x1f1/0x280 drivers/infiniband/core/device.c:1191
 ops_init+0x31e/0x590 net/core/net_namespace.c:139
 setup_net+0x287/0x9e0 net/core/net_namespace.c:356
 copy_net_ns+0x33f/0x570 net/core/net_namespace.c:494
 create_new_namespaces+0x425/0x7b0 kernel/nsproxy.c:110
 unshare_nsproxy_namespaces+0x124/0x180 kernel/nsproxy.c:228
 ksys_unshare+0x57d/0xa70 kernel/fork.c:3311
 __do_sys_unshare kernel/fork.c:3382 [inline]
 __se_sys_unshare kernel/fork.c:3380 [inline]
 __x64_sys_unshare+0x38/0x40 kernel/fork.c:3380
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1be537f7f7
RSP: 002b:00007ffdf2717a78 EFLAGS: 00000206 ORIG_RAX: 0000000000000110
RAX: ffffffffffffffda RBX: 00007f1be5535f40 RCX: 00007f1be537f7f7
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000040000000
RBP: 00007f1be5536a38 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000206 R12: 000000000000000c
R13: 0000000000000003 R14: 0000000000000009 R15: 0000000000000000
 </TASK>

Showing all locks held in the system:
3 locks held by kworker/u8:0/11:
 #0: ffff88802e355148 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88802e355148 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc90000107d00 ((work_completion)(&(&net->ipv6.addr_chk_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc90000107d00 ((work_completion)(&(&net->ipv6.addr_chk_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffffffff8fcbffc8 (rtnl_mutex){+.+.}-{3:3}, at: addrconf_verify_work+0x19/0x30 net/ipv6/addrconf.c:4736
1 lock held by khungtaskd/30:
 #0: ffffffff8e937de0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8e937de0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8e937de0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6720
4 locks held by kworker/u8:2/35:
 #0: ffff88801baeb148 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88801baeb148 ((wq_completion)netns){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc90000ab7d00 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc90000ab7d00 (net_cleanup_work){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffffffff8fcb34d0 (pernet_ops_rwsem){++++}-{3:3}, at: cleanup_net+0x16a/0xcc0 net/core/net_namespace.c:580
 #3: ffffffff8fcbffc8 (rtnl_mutex){+.+.}-{3:3}, at: netdev_wait_allrefs_any net/core/dev.c:10678 [inline]
 #3: ffffffff8fcbffc8 (rtnl_mutex){+.+.}-{3:3}, at: netdev_run_todo+0x7b2/0x1000 net/core/dev.c:10797
7 locks held by kworker/1:1/51:
3 locks held by kworker/u8:4/62:
 #0: ffff88801ac89148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88801ac89148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc900015d7d00 ((linkwatch_work).work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc900015d7d00 ((linkwatch_work).work){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffffffff8fcbffc8 (rtnl_mutex){+.+.}-{3:3}, at: linkwatch_event+0xe/0x60 net/core/link_watch.c:276
3 locks held by kworker/1:2/2636:
 #0: ffff88801ac81948 ((wq_completion)events_power_efficient){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88801ac81948 ((wq_completion)events_power_efficient){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc90009ab7d00 ((reg_check_chans).work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc90009ab7d00 ((reg_check_chans).work){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffffffff8fcbffc8 (rtnl_mutex){+.+.}-{3:3}, at: reg_check_chans_work+0x99/0xfd0 net/wireless/reg.c:2480
2 locks held by getty/4972:
 #0: ffff88802ecdf0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f062f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6a6/0x1e00 drivers/tty/n_tty.c:2211
3 locks held by kworker/1:5/5287:
2 locks held by syz-executor/27947:
 #0: ffffffff8fcb34d0 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x328/0x570 net/core/net_namespace.c:490
 #1: ffffffff8fcbffc8 (rtnl_mutex){+.+.}-{3:3}, at: ip_tunnel_init_net+0x20e/0x720 net/ipv4/ip_tunnel.c:1159
6 locks held by syz-executor/27955:
 #0: ffffffff8fcb34d0 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x328/0x570 net/core/net_namespace.c:490
 #1: ffffffff8fa2f1d0 (devices_rwsem){++++}-{3:3}, at: rdma_dev_init_net+0x198/0x280 drivers/infiniband/core/device.c:1185
 #2: ffffffff8fa2f390 (rdma_nets_rwsem){++++}-{3:3}, at: rdma_dev_init_net+0x1e6/0x280 drivers/infiniband/core/device.c:1190
 #3: ffff8880246fcf38 (&device->compat_devs_mutex){+.+.}-{3:3}, at: add_one_compat_dev+0x10d/0x710 drivers/infiniband/core/device.c:949
 #4: ffff8880246fd230 (&rxe->usdev_lock){+.+.}-{3:3}, at: rxe_query_port+0x61/0x260 drivers/infiniband/sw/rxe/rxe_verbs.c:54
 #5: ffffffff8fcbffc8 (rtnl_mutex){+.+.}-{3:3}, at: ib_get_eth_speed+0x153/0x800 drivers/infiniband/core/verbs.c:1995
1 lock held by syz-executor/27959:
 #0: ffffffff8fcbffc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fcbffc8 (rtnl_mutex){+.+.}-{3:3}, at: __rtnl_newlink net/core/rtnetlink.c:3749 [inline]
 #0: ffffffff8fcbffc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_newlink+0xab7/0x20a0 net/core/rtnetlink.c:3772
4 locks held by syz-executor/27961:
 #0: ffffffff8fcb34d0 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x328/0x570 net/core/net_namespace.c:490
 #1: ffffffff8fa2f1d0 (devices_rwsem){++++}-{3:3}, at: rdma_dev_init_net+0x198/0x280 drivers/infiniband/core/device.c:1185
 #2: ffffffff8fa2f390 (rdma_nets_rwsem){++++}-{3:3}, at: rdma_dev_init_net+0x1e6/0x280 drivers/infiniband/core/device.c:1190
 #3: ffff8880246fcf38 (&device->compat_devs_mutex){+.+.}-{3:3}, at: add_one_compat_dev+0x10d/0x710 drivers/infiniband/core/device.c:949
7 locks held by syz-executor/27963:
 #0: ffff88802d15e420 (sb_writers#8){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2931 [inline]
 #0: ffff88802d15e420 (sb_writers#8){.+.+}-{0:0}, at: vfs_write+0x224/0xc90 fs/read_write.c:679
 #1: ffff88807d74cc88 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x1ea/0x500 fs/kernfs/file.c:325
 #2: ffff888027b63e18 (kn->active#49){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x20e/0x500 fs/kernfs/file.c:326
 #3: ffffffff8f55e0a8 (nsim_bus_dev_list_lock){+.+.}-{3:3}, at: del_device_store+0xfc/0x480 drivers/net/netdevsim/bus.c:216
 #4: ffff88807b3540e8 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #4: ffff88807b3540e8 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1095 [inline]
 #4: ffff88807b3540e8 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0xce/0x7c0 drivers/base/dd.c:1293
 #5: ffff88807b355250 (&devlink->lock_key#4){+.+.}-{3:3}, at: nsim_drv_remove+0x50/0x160 drivers/net/netdevsim/dev.c:1672
 #6: ffffffff8fcbffc8 (rtnl_mutex){+.+.}-{3:3}, at: nsim_destroy+0x71/0x5c0 drivers/net/netdevsim/netdev.c:773
1 lock held by syz-executor/27984:
 #0: ffffffff8fcbffc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fcbffc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6672
1 lock held by syz-executor/27993:
 #0: ffffffff8fcbffc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fcbffc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6672
1 lock held by syz-executor/27994:
 #0: ffffffff8fcbffc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fcbffc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6672
1 lock held by syz-executor/28001:
 #0: ffffffff8fcbffc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fcbffc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6672
1 lock held by syz-executor/28005:
 #0: ffffffff8fcbffc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fcbffc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6672
1 lock held by syz-executor/28008:
 #0: ffffffff8fcbffc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fcbffc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6672
1 lock held by syz-executor/28014:
 #0: ffffffff8fcbffc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fcbffc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6672
1 lock held by syz-executor/28018:
 #0: ffffffff8fcbffc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fcbffc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6672
1 lock held by syz-executor/28020:
 #0: ffffffff8fcbffc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fcbffc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6672
1 lock held by syz-executor/28022:
 #0: ffffffff8fcbffc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fcbffc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6672

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.12.0-rc3-syzkaller-00013-geca631b8fe80 #0
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
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 51 Comm: kworker/1:1 Not tainted 6.12.0-rc3-syzkaller-00013-geca631b8fe80 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: events nsim_dev_trap_report_work
RIP: 0010:unwind_next_frame+0x4a5/0x22d0 arch/x86/kernel/unwind_orc.c:512
Code: 89 44 24 70 42 0f b6 04 20 84 c0 48 89 54 24 10 0f 85 79 16 00 00 48 89 d8 48 c1 e8 03 42 0f b6 04 20 84 c0 0f 85 8a 16 00 00 <41> 0f b7 1f c1 eb 0b 80 e3 01 48 8b 44 24 28 42 0f b6 04 20 84 c0
RSP: 0018:ffffc90000a17a30 EFLAGS: 00000246
RAX: 0000000000000000 RBX: ffffffff90a22953 RCX: ffffffff902cc150
RDX: ffffffff90a2294e RSI: ffffffff90a22942 RDI: 0000000000000001
RBP: ffffc90000a17b50 R08: 0000000000000007 R09: ffffc90000a17bf0
R10: ffffc90000a17b50 R11: ffffffff8180a090 R12: dffffc0000000000
R13: ffffc90000a17b00 R14: ffffffff90a22953 R15: ffffffff90a22952
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2eb1bff8 CR3: 000000000e734000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 arch_stack_walk+0x11c/0x150 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:257 [inline]
 __do_kmalloc_node mm/slub.c:4264 [inline]
 __kmalloc_node_track_caller_noprof+0x225/0x440 mm/slub.c:4283
 kmalloc_reserve+0x111/0x2a0 net/core/skbuff.c:609
 __alloc_skb+0x1f3/0x440 net/core/skbuff.c:678
 alloc_skb include/linux/skbuff.h:1322 [inline]
 synproxy_send_client_synack+0x1ba/0xf30 net/netfilter/nf_synproxy_core.c:460
 nft_synproxy_eval_v4+0x3ca/0x610 net/netfilter/nft_synproxy.c:59
 nft_synproxy_do_eval+0x362/0xa60 net/netfilter/nft_synproxy.c:141
 expr_call_ops_eval net/netfilter/nf_tables_core.c:240 [inline]
 nft_do_chain+0x4ad/0x1da0 net/netfilter/nf_tables_core.c:288
 nft_do_chain_inet+0x418/0x6b0 net/netfilter/nft_chain_filter.c:161
 nf_hook_entry_hookfn include/linux/netfilter.h:154 [inline]
 nf_hook_slow+0xc3/0x220 net/netfilter/core.c:626
 nf_hook include/linux/netfilter.h:269 [inline]
 NF_HOOK+0x29e/0x450 include/linux/netfilter.h:312
 NF_HOOK+0x3a4/0x450 include/linux/netfilter.h:314
 __netif_receive_skb_one_core net/core/dev.c:5666 [inline]
 __netif_receive_skb+0x2bf/0x650 net/core/dev.c:5779
 process_backlog+0x662/0x15b0 net/core/dev.c:6111
 __napi_poll+0xcb/0x490 net/core/dev.c:6775
 napi_poll net/core/dev.c:6844 [inline]
 net_rx_action+0x89b/0x1240 net/core/dev.c:6966
 handle_softirqs+0x2c5/0x980 kernel/softirq.c:554
 do_softirq+0x11b/0x1e0 kernel/softirq.c:455
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x1bb/0x200 kernel/softirq.c:382
 spin_unlock_bh include/linux/spinlock.h:396 [inline]
 nsim_dev_trap_report drivers/net/netdevsim/dev.c:820 [inline]
 nsim_dev_trap_report_work+0x75d/0xaa0 drivers/net/netdevsim/dev.c:850
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
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

