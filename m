Return-Path: <linux-rdma+bounces-13043-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50474B40D2B
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Sep 2025 20:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D5923BDB44
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Sep 2025 18:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED5E34DCD5;
	Tue,  2 Sep 2025 18:31:35 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1DD2DF132
	for <linux-rdma@vger.kernel.org>; Tue,  2 Sep 2025 18:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756837894; cv=none; b=j56ukNBTMwNkGJtsQtCvAJLcDB9UIbbhtlInU9fMxcYkWJezoPgatbtcB/nxrtmxwHbC/lY/Y3ON7TnGXiWF8oCXgP60nw3ffI0q5FJ5ZFFd+wZcQkKVboFaOzfWBSUH/27HN4YDrVbBolJYmaEId2m2mmtfY4RkR+H0VckZurg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756837894; c=relaxed/simple;
	bh=/2pxvEOdkohmjbfdvXTkARBrRsVWTRZQkcVOeZ1pJAQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ihc64qWS3X9cX2vF1JPd/gJM62BhZaQkZ/Sj/90sBe6MCX5YvS0H3fU7O7mqYtEwtBYr6sEE4tWF8+zDF97zAhkt+RBQXIyDJQXJ08qwYZxM/8198b1BYzUi4ykGENQBygslhy1G/62ldCrMYP1F6+/taCsTtLAI7LjqkSdTV0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3f0b5f6aa32so69873335ab.3
        for <linux-rdma@vger.kernel.org>; Tue, 02 Sep 2025 11:31:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756837892; x=1757442692;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aGeh+7PdN4ZfcRyxnJ180Gy5tl3gFBb+lsQE6RCd7L8=;
        b=InpTQE/ykFNQ1jPI5zXIzPeMWMI9uzVbP5ceZulEx4AYoZdmSBfS9ksiE8LY5dJjem
         9Ds47SV1fpcjX2ofDuLs8qts44bEmT862dFKMMnH3zNqtkiZMmGXkkpoo9h0mCYsGN6q
         wxQ7/kEGTrX0+Of7PGPeBY19iqsu6mZ0AfIKhs6okRFjH4wghqEOAKTq3mOkOsr19E5K
         a0YKl5WbvklteiBDmllan9Vr2eU337mXktAs/4402Mh4myjhgN62I6OIpG1Eg5JrxRVO
         +DTsASePMhDnDqrRTuQ+ucEzQZ7TPj+G4ueUl04GTu2Vo+xAHKiPD/HARfvuqUCOE0zD
         lLgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVa+vd3JiR97xgz/d4qxDpBrVhm5PlpYaCSM++YuNV9WejBTP1JEjDX6s6bPv5uocqNNBufOJ0nTSLn@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3Bk6PHD0gdIKenoRlSai9f2OdwO3e2PHXaB0ZHIFhzbLha1n1
	8zotdMfoIeLkj6ORyn4wxSssBHTJN7+p+aU12YM37kHyoeCvCiDhKKv4/21kvydUXgQwMS4bHFB
	YE1NxZvd/bZtahD2KNXzgZHYx7EMqbCO3/BRsuyTjAPuqKeSS54XQQp+L6LM=
X-Google-Smtp-Source: AGHT+IFqOy39DQx/VKLuQX0edQ2GIjcA8ipB5EnCxLpu6fD2vfMptRbyXW+wA2E85+THSNoA3eP+J5TUJRYR0SwD0AwwaQX2DKIk
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1687:b0:3f6:5e71:1519 with SMTP id
 e9e14a558f8ab-3f65e711889mr15608745ab.4.1756837892204; Tue, 02 Sep 2025
 11:31:32 -0700 (PDT)
Date: Tue, 02 Sep 2025 11:31:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b73804.050a0220.3db4df.01d8.GAE@google.com>
Subject: [syzbot] [smc?] possible deadlock in smc_diag_dump_proto
From: syzbot <syzbot+50603c05bbdf4dfdaffa@syzkaller.appspotmail.com>
To: alibuda@linux.alibaba.com, davem@davemloft.net, dust.li@linux.alibaba.com, 
	edumazet@google.com, guwen@linux.alibaba.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-s390@vger.kernel.org, mjambigi@linux.ibm.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, sidraya@linux.ibm.com, syzkaller-bugs@googlegroups.com, 
	tonylu@linux.alibaba.com, wenjia@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8d245acc1e88 Merge tag 'char-misc-6.17-rc3' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=176fa7bc580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e1e1566c7726877e
dashboard link: https://syzkaller.appspot.com/bug?extid=50603c05bbdf4dfdaffa
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14e42062580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12e42062580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/096739d8f0ec/disk-8d245acc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/83a21aa9b978/vmlinux-8d245acc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7e7f165a3b29/bzImage-8d245acc.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+50603c05bbdf4dfdaffa@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
syz.0.17/6109 is trying to acquire lock:
ffff8880b8823d90 ((softirq_ctrl.lock)){+.+.}-{3:3}, at: spin_lock include/linux/spinlock_rt.h:44 [inline]
ffff8880b8823d90 ((softirq_ctrl.lock)){+.+.}-{3:3}, at: __local_bh_disable_ip+0x264/0x400 kernel/softirq.c:168

but task is already holding lock:
ffffffff8efa6608 (smc_v6_hashinfo.lock){++.+}-{3:3}, at: read_lock include/linux/rwlock_rt.h:37 [inline]
ffffffff8efa6608 (smc_v6_hashinfo.lock){++.+}-{3:3}, at: smc_diag_dump_proto+0x174/0x1fb0 net/smc/smc_diag.c:207

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (smc_v6_hashinfo.lock){++.+}-{3:3}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       rt_write_lock+0x6a/0x110 kernel/locking/spinlock_rt.c:242
       write_lock_bh include/linux/rwlock_rt.h:99 [inline]
       smc_hash_sk+0x8f/0x2a0 net/smc/af_smc.c:193
       smc_sk_init+0x5a1/0x7f0 net/smc/af_smc.c:399
       smc_sock_alloc net/smc/af_smc.c:420 [inline]
       __smc_create+0x10d/0x280 net/smc/af_smc.c:3382
       __sock_create+0x4b3/0x9f0 net/socket.c:1589
       sock_create net/socket.c:1647 [inline]
       __sys_socket_create net/socket.c:1684 [inline]
       __sys_socket+0xd7/0x1b0 net/socket.c:1731
       __do_sys_socket net/socket.c:1745 [inline]
       __se_sys_socket net/socket.c:1743 [inline]
       __x64_sys_socket+0x7a/0x90 net/socket.c:1743
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 ((softirq_ctrl.lock)){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3908
       __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5237
       reacquire_held_locks+0x127/0x1d0 kernel/locking/lockdep.c:5385
       __lock_release kernel/locking/lockdep.c:5574 [inline]
       lock_release+0x1b4/0x3e0 kernel/locking/lockdep.c:5889
       __local_bh_enable_ip+0x10c/0x270 kernel/softirq.c:228
       local_bh_enable include/linux/bottom_half.h:33 [inline]
       sock_i_ino+0xa9/0xc0 net/core/sock.c:2800
       smc_diag_msg_attrs_fill net/smc/smc_diag.c:68 [inline]
       __smc_diag_dump net/smc/smc_diag.c:98 [inline]
       smc_diag_dump_proto+0xa4c/0x1fb0 net/smc/smc_diag.c:217
       smc_diag_dump+0x59/0xa0 net/smc/smc_diag.c:236
       netlink_dump+0x6e4/0xe90 net/netlink/af_netlink.c:2327
       __netlink_dump_start+0x5cb/0x7e0 net/netlink/af_netlink.c:2442
       netlink_dump_start include/linux/netlink.h:341 [inline]
       smc_diag_handler_dump+0x178/0x210 net/smc/smc_diag.c:251
       sock_diag_rcv_msg+0x4c9/0x600 net/core/sock_diag.c:-1
       netlink_rcv_skb+0x205/0x470 net/netlink/af_netlink.c:2552
       netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
       netlink_unicast+0x843/0xa10 net/netlink/af_netlink.c:1346
       netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
       sock_sendmsg_nosec net/socket.c:714 [inline]
       __sock_sendmsg+0x219/0x270 net/socket.c:729
       ____sys_sendmsg+0x508/0x820 net/socket.c:2614
       ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2668
       __sys_sendmsg net/socket.c:2700 [inline]
       __do_sys_sendmsg net/socket.c:2705 [inline]
       __se_sys_sendmsg net/socket.c:2703 [inline]
       __x64_sys_sendmsg+0x1a1/0x260 net/socket.c:2703
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(smc_v6_hashinfo.lock);
                               lock((softirq_ctrl.lock));
                               lock(smc_v6_hashinfo.lock);
  lock((softirq_ctrl.lock));

 *** DEADLOCK ***

3 locks held by syz.0.17/6109:
 #0: ffff888035fbe908 (nlk_cb_mutex-SOCK_DIAG){+.+.}-{4:4}, at: __netlink_dump_start+0xfe/0x7e0 net/netlink/af_netlink.c:2406
 #1: ffffffff8efa6608 (smc_v6_hashinfo.lock){++.+}-{3:3}, at: read_lock include/linux/rwlock_rt.h:37 [inline]
 #1: ffffffff8efa6608 (smc_v6_hashinfo.lock){++.+}-{3:3}, at: smc_diag_dump_proto+0x174/0x1fb0 net/smc/smc_diag.c:207
 #2: ffffffff8d9a8b80 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #2: ffffffff8d9a8b80 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #2: ffffffff8d9a8b80 (rcu_read_lock){....}-{1:3}, at: rt_read_lock+0x1f8/0x360 kernel/locking/spinlock_rt.c:234

stack backtrace:
CPU: 0 UID: 0 PID: 6109 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_circular_bug+0x2ee/0x310 kernel/locking/lockdep.c:2043
 check_noncircular+0x134/0x160 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3165 [inline]
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3908
 __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5237
 reacquire_held_locks+0x127/0x1d0 kernel/locking/lockdep.c:5385
 __lock_release kernel/locking/lockdep.c:5574 [inline]
 lock_release+0x1b4/0x3e0 kernel/locking/lockdep.c:5889
 __local_bh_enable_ip+0x10c/0x270 kernel/softirq.c:228
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 sock_i_ino+0xa9/0xc0 net/core/sock.c:2800
 smc_diag_msg_attrs_fill net/smc/smc_diag.c:68 [inline]
 __smc_diag_dump net/smc/smc_diag.c:98 [inline]
 smc_diag_dump_proto+0xa4c/0x1fb0 net/smc/smc_diag.c:217
 smc_diag_dump+0x59/0xa0 net/smc/smc_diag.c:236
 netlink_dump+0x6e4/0xe90 net/netlink/af_netlink.c:2327
 __netlink_dump_start+0x5cb/0x7e0 net/netlink/af_netlink.c:2442
 netlink_dump_start include/linux/netlink.h:341 [inline]
 smc_diag_handler_dump+0x178/0x210 net/smc/smc_diag.c:251
 sock_diag_rcv_msg+0x4c9/0x600 net/core/sock_diag.c:-1
 netlink_rcv_skb+0x205/0x470 net/netlink/af_netlink.c:2552
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x843/0xa10 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg+0x219/0x270 net/socket.c:729
 ____sys_sendmsg+0x508/0x820 net/socket.c:2614
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2668
 __sys_sendmsg net/socket.c:2700 [inline]
 __do_sys_sendmsg net/socket.c:2705 [inline]
 __se_sys_sendmsg net/socket.c:2703 [inline]
 __x64_sys_sendmsg+0x1a1/0x260 net/socket.c:2703
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe07d70ebe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe932c2428 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fe07d935fa0 RCX: 00007fe07d70ebe9
RDX: 0000000000004000 RSI: 0000200000000140 RDI: 0000000000000004
RBP: 00007fe07d791e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fe07d935fa0 R14: 00007fe07d935fa0 R15: 0000000000000003
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

