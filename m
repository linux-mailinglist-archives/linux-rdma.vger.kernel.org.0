Return-Path: <linux-rdma+bounces-4302-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C9794E032
	for <lists+linux-rdma@lfdr.de>; Sun, 11 Aug 2024 08:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C157281919
	for <lists+linux-rdma@lfdr.de>; Sun, 11 Aug 2024 06:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBC7199A2;
	Sun, 11 Aug 2024 06:01:21 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A9D17758
	for <linux-rdma@vger.kernel.org>; Sun, 11 Aug 2024 06:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723356081; cv=none; b=cbiHzGln8YSgufE46f5aszXhuVNClR/xi5gJkozNw3ZP2/6BbCMIfgdV8k1raXRxD3bo+3MQbm9CFH1H+aBFHzUmOOLVPlR7roEF/+AgGKojN00Kobg9XC2gff0KYXYulJXZNBCckJq6Mb9uqtK7Z0+Xb0MYZsaNswMT6jLG1sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723356081; c=relaxed/simple;
	bh=OUzTIG+Fl3PrbPCXeIsMCI8osZxo7JHQCkYvA6qdWUY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ridFpkXN57LRC1jyiz0sC95BfEXS2YYoRx4sqlBEnka4t1DC5SeyGSfoNBb/kJDK/4NPpPZzgYGWzzNef3es8exrfBG9jcUaqBEdruFVTZMaGR6MUgxn5nZYbGokdZQHD4y/ZI3zCUeaDDxQLKtMcAq/NUPuAXUF4BNrZ0moeO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39ad7e6b4deso42703595ab.2
        for <linux-rdma@vger.kernel.org>; Sat, 10 Aug 2024 23:01:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723356078; x=1723960878;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9vsBRnhg3SOv3kE+B7z/Y+oRRX8zoCKH4iOcoSYS3Sg=;
        b=QmgqLQA9PWaW76tCXBS1BCu1w0ktujSn01PKZEw6UbWv7lrr2KarIPCkgcuPHV+ARV
         hJiovJTAvyKXi37FwL8T4Z2M8dCp2RdRZdyVpC64cDjsbANL2jtKToCbRhoFOmyN/tTq
         aAiTQhsMN4A/BxZrTNPWmB+yKpEYJTs8VoYhWm7KVBkD726Bvka9xFBI5Tw84rNAvkWi
         3KMRSojYI00WBKsrzy3dvslYn2N6UWRktHfRJk3zmZHWcKoxZAGwoSYvfz9LPnvFFlj0
         8CpVmQsk8GQMqWVlDgmJfQGuGn92UZpcqMR/fdv0Dwi3gHtr5YwvIMG++LZVqthI0m8y
         7VrA==
X-Forwarded-Encrypted: i=1; AJvYcCUVJXNumPc8pZoLjTQ3GcQHdEQYUakQIj0z/SGa7zgIEJWJzAw9Navwp+TmaRs2VA/5/v/8+x2mIMRMwehJ4CY2pyW01SzP9aTvtQ==
X-Gm-Message-State: AOJu0YyhKbRz7mH/e+G/ns0oqM/fC2QZfQ5BzVsGieehAIhV7WIhOBdG
	hdxVuVZOmxzQxli8MImAsNVfHjOXqrpAku67qpO/1oe4bQKku2H7PbRvMZE3j+c65We/D0UAznv
	H3cWC3QMDxtCtDQvx5OP2xbtKd54cuvf5CbKLVFnynngR/qqOeLmArhk=
X-Google-Smtp-Source: AGHT+IE+kG9M3DKTCK6qoePs8ZDlrvby4lkA1q3uYiy1yRK+7XiBYi0mkLuryO6JYeHjIHfd7ZO24NXzLBDWADyP3vB1AI8vyohS
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18ce:b0:39a:ea7d:2a9a with SMTP id
 e9e14a558f8ab-39b8709167fmr4857235ab.6.1723356078625; Sat, 10 Aug 2024
 23:01:18 -0700 (PDT)
Date: Sat, 10 Aug 2024 23:01:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e364c9061f621a56@google.com>
Subject: [syzbot] [rdma?] possible deadlock in sock_set_reuseaddr
From: syzbot <syzbot+af5682e4f50cd6bce838@syzkaller.appspotmail.com>
To: jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d4560686726f Merge tag 'for_linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1621ea83980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=505ed4a1dd93463a
dashboard link: https://syzkaller.appspot.com/bug?extid=af5682e4f50cd6bce838
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-d4560686.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3304e311b45d/vmlinux-d4560686.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c5fa8d141fd4/bzImage-d4560686.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+af5682e4f50cd6bce838@syzkaller.appspotmail.com

ip6gretap0 speed is unknown, defaulting to 1000
ip6gretap0 speed is unknown, defaulting to 1000
iwpm_register_pid: Unable to send a nlmsg (client = 2)
======================================================
WARNING: possible circular locking dependency detected
6.11.0-rc2-syzkaller-00013-gd4560686726f #0 Not tainted
------------------------------------------------------
syz.0.201/6238 is trying to acquire lock:
ffff888024153658 (sk_lock-AF_INET6){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1607 [inline]
ffff888024153658 (sk_lock-AF_INET6){+.+.}-{0:0}, at: sock_set_reuseaddr+0x17/0x60 net/core/sock.c:782

but task is already holding lock:
ffffffff8f68af68 (lock#8){+.+.}-{3:3}, at: cma_add_one+0x674/0xdd0 drivers/infiniband/core/cma.c:5354

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (lock#8){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
       cma_init+0x1d/0x150 drivers/infiniband/core/cma.c:5438
       do_one_initcall+0x128/0x700 init/main.c:1267
       do_initcall_level init/main.c:1329 [inline]
       do_initcalls init/main.c:1345 [inline]
       do_basic_setup init/main.c:1364 [inline]
       kernel_init_freeable+0x69d/0xca0 init/main.c:1578
       kernel_init+0x1c/0x2b0 init/main.c:1467
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #1 (rtnl_mutex){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
       smc_vlan_by_tcpsk+0x251/0x620 net/smc/smc_core.c:1853
       __smc_connect+0x44d/0x4830 net/smc/af_smc.c:1522
       smc_connect+0x2fc/0x760 net/smc/af_smc.c:1702
       __sys_connect_file+0x15f/0x1a0 net/socket.c:2061
       __sys_connect+0x149/0x170 net/socket.c:2078
       __do_sys_connect net/socket.c:2088 [inline]
       __se_sys_connect net/socket.c:2085 [inline]
       __x64_sys_connect+0x72/0xb0 net/socket.c:2085
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (sk_lock-AF_INET6){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3133 [inline]
       check_prevs_add kernel/locking/lockdep.c:3252 [inline]
       validate_chain kernel/locking/lockdep.c:3868 [inline]
       __lock_acquire+0x24ed/0x3cb0 kernel/locking/lockdep.c:5142
       lock_acquire kernel/locking/lockdep.c:5759 [inline]
       lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5724
       lock_sock_nested+0x3a/0xf0 net/core/sock.c:3543
       lock_sock include/net/sock.h:1607 [inline]
       sock_set_reuseaddr+0x17/0x60 net/core/sock.c:782
       siw_create_listen+0x1ab/0x11f0 drivers/infiniband/sw/siw/siw_cm.c:1776
       iw_cm_listen+0x16a/0x1f0 drivers/infiniband/core/iwcm.c:585
       cma_iw_listen drivers/infiniband/core/cma.c:2668 [inline]
       rdma_listen+0x7ef/0xe20 drivers/infiniband/core/cma.c:3953
       cma_listen_on_dev+0x4dc/0x810 drivers/infiniband/core/cma.c:2727
       cma_add_one+0x78b/0xdd0 drivers/infiniband/core/cma.c:5357
       add_client_context+0x3dd/0x590 drivers/infiniband/core/device.c:727
       enable_device_and_get+0x1d5/0x3f0 drivers/infiniband/core/device.c:1338
       ib_register_device drivers/infiniband/core/device.c:1426 [inline]
       ib_register_device+0x880/0xbf0 drivers/infiniband/core/device.c:1372
       siw_device_register drivers/infiniband/sw/siw/siw_main.c:72 [inline]
       siw_newlink drivers/infiniband/sw/siw/siw_main.c:489 [inline]
       siw_newlink+0xc13/0xe90 drivers/infiniband/sw/siw/siw_main.c:465
       nldev_newlink+0x392/0x660 drivers/infiniband/core/nldev.c:1794
       rdma_nl_rcv_msg+0x388/0x6e0 drivers/infiniband/core/netlink.c:195
       rdma_nl_rcv_skb.constprop.0.isra.0+0x2e6/0x450 drivers/infiniband/core/netlink.c:239
       netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
       netlink_unicast+0x544/0x830 net/netlink/af_netlink.c:1357
       netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1901
       sock_sendmsg_nosec net/socket.c:730 [inline]
       __sock_sendmsg net/socket.c:745 [inline]
       ____sys_sendmsg+0xab5/0xc90 net/socket.c:2597
       ___sys_sendmsg+0x135/0x1e0 net/socket.c:2651
       __sys_sendmsg+0x117/0x1f0 net/socket.c:2680
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  sk_lock-AF_INET6 --> rtnl_mutex --> lock#8

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(lock#8);
                               lock(rtnl_mutex);
                               lock(lock#8);
  lock(sk_lock-AF_INET6);

 *** DEADLOCK ***

6 locks held by syz.0.201/6238:
 #0: ffffffff9522c4d8 (&rdma_nl_types[idx].sem){.+.+}-{3:3}, at: rdma_nl_rcv_msg+0x16a/0x6e0 drivers/infiniband/core/netlink.c:164
 #1: ffffffff8f672c90 (link_ops_rwsem){++++}-{3:3}, at: nldev_newlink+0x2d7/0x660 drivers/infiniband/core/nldev.c:1784
 #2: ffffffff8f65f3f0 (devices_rwsem){++++}-{3:3}, at: enable_device_and_get+0x104/0x3f0 drivers/infiniband/core/device.c:1328
 #3: ffffffff8f65f2b0 (clients_rwsem){++++}-{3:3}, at: enable_device_and_get+0x163/0x3f0 drivers/infiniband/core/device.c:1336
 #4: ffff8880474285d0 (&device->client_data_rwsem){++++}-{3:3}, at: add_client_context+0x3a9/0x590 drivers/infiniband/core/device.c:725
 #5: ffffffff8f68af68 (lock#8){+.+.}-{3:3}, at: cma_add_one+0x674/0xdd0 drivers/infiniband/core/cma.c:5354

stack backtrace:
CPU: 1 UID: 0 PID: 6238 Comm: syz.0.201 Not tainted 6.11.0-rc2-syzkaller-00013-gd4560686726f #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:119
 check_noncircular+0x31a/0x400 kernel/locking/lockdep.c:2186
 check_prev_add kernel/locking/lockdep.c:3133 [inline]
 check_prevs_add kernel/locking/lockdep.c:3252 [inline]
 validate_chain kernel/locking/lockdep.c:3868 [inline]
 __lock_acquire+0x24ed/0x3cb0 kernel/locking/lockdep.c:5142
 lock_acquire kernel/locking/lockdep.c:5759 [inline]
 lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5724
 lock_sock_nested+0x3a/0xf0 net/core/sock.c:3543
 lock_sock include/net/sock.h:1607 [inline]
 sock_set_reuseaddr+0x17/0x60 net/core/sock.c:782
 siw_create_listen+0x1ab/0x11f0 drivers/infiniband/sw/siw/siw_cm.c:1776
 iw_cm_listen+0x16a/0x1f0 drivers/infiniband/core/iwcm.c:585
 cma_iw_listen drivers/infiniband/core/cma.c:2668 [inline]
 rdma_listen+0x7ef/0xe20 drivers/infiniband/core/cma.c:3953
 cma_listen_on_dev+0x4dc/0x810 drivers/infiniband/core/cma.c:2727
 cma_add_one+0x78b/0xdd0 drivers/infiniband/core/cma.c:5357
 add_client_context+0x3dd/0x590 drivers/infiniband/core/device.c:727
 enable_device_and_get+0x1d5/0x3f0 drivers/infiniband/core/device.c:1338
 ib_register_device drivers/infiniband/core/device.c:1426 [inline]
 ib_register_device+0x880/0xbf0 drivers/infiniband/core/device.c:1372
 siw_device_register drivers/infiniband/sw/siw/siw_main.c:72 [inline]
 siw_newlink drivers/infiniband/sw/siw/siw_main.c:489 [inline]
 siw_newlink+0xc13/0xe90 drivers/infiniband/sw/siw/siw_main.c:465
 nldev_newlink+0x392/0x660 drivers/infiniband/core/nldev.c:1794
 rdma_nl_rcv_msg+0x388/0x6e0 drivers/infiniband/core/netlink.c:195
 rdma_nl_rcv_skb.constprop.0.isra.0+0x2e6/0x450 drivers/infiniband/core/netlink.c:239
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x544/0x830 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 ____sys_sendmsg+0xab5/0xc90 net/socket.c:2597
 ___sys_sendmsg+0x135/0x1e0 net/socket.c:2651
 __sys_sendmsg+0x117/0x1f0 net/socket.c:2680
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f83257779f9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f83264f5038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f8325906058 RCX: 00007f83257779f9
RDX: 0000000000000000 RSI: 0000000020000280 RDI: 0000000000000008
RBP: 00007f83257e58ee R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f8325906058 R15: 00007ffc662de808
 </TASK>
infiniband syz2: RDMA CMA: cma_listen_on_dev, error -98
ip6gretap0 speed is unknown, defaulting to 1000
ip6gretap0 speed is unknown, defaulting to 1000
ip6gretap0 speed is unknown, defaulting to 1000
ip6gretap0 speed is unknown, defaulting to 1000


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

