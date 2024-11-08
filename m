Return-Path: <linux-rdma+bounces-5869-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D219C2013
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Nov 2024 16:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ED671C21721
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Nov 2024 15:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D031F5822;
	Fri,  8 Nov 2024 15:10:25 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF651F4299
	for <linux-rdma@vger.kernel.org>; Fri,  8 Nov 2024 15:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731078624; cv=none; b=ZJ3FULMctccPwk0vjLA9JjAxo3TbzGtrYC6U+9Sd2kqY1Q0bYbbHmH6/QhyVrWYNrIc0Aoqg6VygMDh8Wvul3G9nZBe2351ZvXtylt5WipWl6QA7iV0MehPavgt0Mre7h77bLzck1lz7tFo8/+mLDgcW+Z7g8F/mhbWnxqhylOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731078624; c=relaxed/simple;
	bh=bH6FFgTxmqkn0hT9sBUQG8HCNVpGUO5eEIDp3xRX7EY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bayZXneVit7JguDXu1aURisn0VD+xcCXERVz6cpw+4Mxsuq6/FrwbTzWsdZpwRg5CClSuyrixtor94lfwgg7FIllD11qkgNJ/im1CAyJ3OaxgXTLXJg7w0JCOZ8hkAP9BNzwIxE4spcTlqUTiHJmFlHs9sOjEasshyM+s2u5fss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3cb771556so27886525ab.3
        for <linux-rdma@vger.kernel.org>; Fri, 08 Nov 2024 07:10:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731078622; x=1731683422;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yb7jdZSha+BmQFM62PKABMMReWo6t+QSwbbNWs+C1mA=;
        b=kEC+zHtO18GNYKhcahy1hL1p463V6mK7pNJgCG5uSOQ7Tzaph6y+OzzIwMk++jaE3c
         I77yU/T+tjseyBEsQzXCQm6eTQN5HGZhKQI6FrJWaR8GC/oulov2fRQoFqjemSEJQqpD
         2NbNIz+BWtcaXmTS4zyrPUBsVz6SRY/qmjKIQ26NhPO2LdpUJcTBtakglZgXDfyrop8w
         8mGDa1Jo6i2uzoKZ3FdVWSM6FZUuz7q1Apxw+kLjRzsNzkCbq5iP7i95bhptXZO2Z+px
         6xR6wNZGoFZuQRplpoEB5yH2CPbLlGr/aYRMvjktpu3kURqnIH/gJxRq479WBEO8P0/3
         Gaow==
X-Forwarded-Encrypted: i=1; AJvYcCW+Ptap30QNHHsDRrFb/JUOIYIlOfEM7eiSuV8oatY2H+IOUn+HRHmMF7TlofB9IlRWs8LKgdeuMtO9@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh05yb2ID5yyxRHIKwqUl+EPeXsOVoq1LCx3coRzRZIEq31R+8
	XCilYGGcggcxOOIlVXTJOa1VVl4TprBzvZd4uQChXlQMr2pXm3qszeZ49kzs1QWWPBrPsojoeDG
	JGdSRyKPOOxk1gUlm3EzaMnlWx5pb/4/dJcKcjGgC6eXKWqraOjFUkHE=
X-Google-Smtp-Source: AGHT+IFeXEQBxvCHql7zgQ2f0c8TnJfEh+lA845yjuY0rpgm/pcZIyvcBlQU498eIYqSEWPKoFRBdN4rmHdbmyOYzKsOGayvtdAE
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b07:b0:3a6:af3c:56ae with SMTP id
 e9e14a558f8ab-3a6f1a09adamr43995055ab.11.1731078622275; Fri, 08 Nov 2024
 07:10:22 -0800 (PST)
Date: Fri, 08 Nov 2024 07:10:22 -0800
In-Reply-To: <000000000000e364c9061f621a56@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672e29de.050a0220.69fce.0018.GAE@google.com>
Subject: Re: [syzbot] [rdma?] possible deadlock in sock_set_reuseaddr
From: syzbot <syzbot+af5682e4f50cd6bce838@syzkaller.appspotmail.com>
To: jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    2696e451dfb0 Merge git://git.kernel.org/pub/scm/linux/kern..
git tree:       net-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=110a3d87980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ea5200d154f868aa
dashboard link: https://syzkaller.appspot.com/bug?extid=af5682e4f50cd6bce838
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17f7cea7980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13bbee30580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d35511e1cf15/disk-2696e451.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a547f0432d8f/vmlinux-2696e451.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9d3fb709c982/bzImage-2696e451.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+af5682e4f50cd6bce838@syzkaller.appspotmail.com

iwpm_register_pid: Unable to send a nlmsg (client = 2)
======================================================
WARNING: possible circular locking dependency detected
6.12.0-rc6-syzkaller-01219-g2696e451dfb0 #0 Not tainted
------------------------------------------------------
syz-executor331/5847 is trying to acquire lock:
ffff888024303558 (sk_lock-AF_INET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1617 [inline]
ffff888024303558 (sk_lock-AF_INET){+.+.}-{0:0}, at: sock_set_reuseaddr+0x17/0x60 net/core/sock.c:781

but task is already holding lock:
ffffffff8fa64d48 (lock#7){+.+.}-{3:3}, at: cma_add_one+0x6bc/0xcd0 drivers/infiniband/core/cma.c:5354

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (lock#7){+.+.}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       cma_init+0x1e/0x140 drivers/infiniband/core/cma.c:5438
       do_one_initcall+0x248/0x880 init/main.c:1269
       do_initcall_level+0x157/0x210 init/main.c:1331
       do_initcalls+0x3f/0x80 init/main.c:1347
       kernel_init_freeable+0x435/0x5d0 init/main.c:1580
       kernel_init+0x1d/0x2b0 init/main.c:1469
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #2 (rtnl_mutex){+.+.}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       do_ip_setsockopt+0x127d/0x3cd0 net/ipv4/ip_sockglue.c:1077
       ip_setsockopt+0x63/0x100 net/ipv4/ip_sockglue.c:1417
       smc_setsockopt+0x275/0xe50 net/smc/af_smc.c:3064
       do_sock_setsockopt+0x3af/0x720 net/socket.c:2336
       __sys_setsockopt+0x1a2/0x250 net/socket.c:2359
       __do_sys_setsockopt net/socket.c:2368 [inline]
       __se_sys_setsockopt net/socket.c:2365 [inline]
       __x64_sys_setsockopt+0xb5/0xd0 net/socket.c:2365
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&smc->clcsock_release_lock){+.+.}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       smc_switch_to_fallback+0x35/0xdb0 net/smc/af_smc.c:902
       smc_sendmsg+0x11f/0x530 net/smc/af_smc.c:2771
       sock_sendmsg_nosec net/socket.c:729 [inline]
       __sock_sendmsg+0x221/0x270 net/socket.c:744
       __sys_sendto+0x39b/0x4f0 net/socket.c:2216
       __do_sys_sendto net/socket.c:2228 [inline]
       __se_sys_sendto net/socket.c:2224 [inline]
       __x64_sys_sendto+0xde/0x100 net/socket.c:2224
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (sk_lock-AF_INET){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
       __lock_acquire+0x1384/0x2050 kernel/locking/lockdep.c:5202
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
       lock_sock_nested+0x48/0x100 net/core/sock.c:3616
       lock_sock include/net/sock.h:1617 [inline]
       sock_set_reuseaddr+0x17/0x60 net/core/sock.c:781
       siw_create_listen+0x196/0xfe0 drivers/infiniband/sw/siw/siw_cm.c:1776
       iw_cm_listen+0x15e/0x230 drivers/infiniband/core/iwcm.c:585
       cma_iw_listen drivers/infiniband/core/cma.c:2668 [inline]
       rdma_listen+0x941/0xd60 drivers/infiniband/core/cma.c:3953
       cma_listen_on_dev+0x3e3/0x6f0 drivers/infiniband/core/cma.c:2727
       cma_add_one+0x7d7/0xcd0 drivers/infiniband/core/cma.c:5357
       add_client_context+0x536/0x8b0 drivers/infiniband/core/device.c:727
       enable_device_and_get+0x1e6/0x440 drivers/infiniband/core/device.c:1338
       ib_register_device+0x10d4/0x13e0 drivers/infiniband/core/device.c:1449
       siw_device_register drivers/infiniband/sw/siw/siw_main.c:72 [inline]
       siw_newlink+0x9d9/0xe50 drivers/infiniband/sw/siw/siw_main.c:452
       nldev_newlink+0x5c0/0x640 drivers/infiniband/core/nldev.c:1795
       rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
       rdma_nl_rcv+0x6dd/0x9e0 drivers/infiniband/core/netlink.c:259
       netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
       netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1357
       netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
       sock_sendmsg_nosec net/socket.c:729 [inline]
       __sock_sendmsg+0x221/0x270 net/socket.c:744
       ____sys_sendmsg+0x52a/0x7e0 net/socket.c:2609
       ___sys_sendmsg net/socket.c:2663 [inline]
       __sys_sendmsg+0x292/0x380 net/socket.c:2692
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  sk_lock-AF_INET --> rtnl_mutex --> lock#7

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(lock#7);
                               lock(rtnl_mutex);
                               lock(lock#7);
  lock(sk_lock-AF_INET);

 *** DEADLOCK ***

6 locks held by syz-executor331/5847:
 #0: ffffffff9a7a1918 (&rdma_nl_types[idx].sem){.+.+}-{3:3}, at: rdma_nl_rcv_msg drivers/infiniband/core/netlink.c:164 [inline]
 #0: ffffffff9a7a1918 (&rdma_nl_types[idx].sem){.+.+}-{3:3}, at: rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
 #0: ffffffff9a7a1918 (&rdma_nl_types[idx].sem){.+.+}-{3:3}, at: rdma_nl_rcv+0x32d/0x9e0 drivers/infiniband/core/netlink.c:259
 #1: ffffffff8fa50fb0 (link_ops_rwsem){++++}-{3:3}, at: nldev_newlink+0x42a/0x640 drivers/infiniband/core/nldev.c:1785
 #2: ffffffff8fa43bd0 (devices_rwsem){++++}-{3:3}, at: enable_device_and_get+0x12e/0x440 drivers/infiniband/core/device.c:1328
 #3: ffffffff8fa43ed0 (clients_rwsem){++++}-{3:3}, at: enable_device_and_get+0x196/0x440 drivers/infiniband/core/device.c:1336
 #4: ffff88807fc405d0 (&device->client_data_rwsem){++++}-{3:3}, at: add_client_context+0x4f4/0x8b0 drivers/infiniband/core/device.c:725
 #5: ffffffff8fa64d48 (lock#7){+.+.}-{3:3}, at: cma_add_one+0x6bc/0xcd0 drivers/infiniband/core/cma.c:5354

stack backtrace:
CPU: 0 UID: 0 PID: 5847 Comm: syz-executor331 Not tainted 6.12.0-rc6-syzkaller-01219-g2696e451dfb0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_circular_bug+0x13a/0x1b0 kernel/locking/lockdep.c:2074
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2206
 check_prev_add kernel/locking/lockdep.c:3161 [inline]
 check_prevs_add kernel/locking/lockdep.c:3280 [inline]
 validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
 __lock_acquire+0x1384/0x2050 kernel/locking/lockdep.c:5202
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
 lock_sock_nested+0x48/0x100 net/core/sock.c:3616
 lock_sock include/net/sock.h:1617 [inline]
 sock_set_reuseaddr+0x17/0x60 net/core/sock.c:781
 siw_create_listen+0x196/0xfe0 drivers/infiniband/sw/siw/siw_cm.c:1776
 iw_cm_listen+0x15e/0x230 drivers/infiniband/core/iwcm.c:585
 cma_iw_listen drivers/infiniband/core/cma.c:2668 [inline]
 rdma_listen+0x941/0xd60 drivers/infiniband/core/cma.c:3953
 cma_listen_on_dev+0x3e3/0x6f0 drivers/infiniband/core/cma.c:2727
 cma_add_one+0x7d7/0xcd0 drivers/infiniband/core/cma.c:5357
 add_client_context+0x536/0x8b0 drivers/infiniband/core/device.c:727
 enable_device_and_get+0x1e6/0x440 drivers/infiniband/core/device.c:1338
 ib_register_device+0x10d4/0x13e0 drivers/infiniband/core/device.c:1449
 siw_device_register drivers/infiniband/sw/siw/siw_main.c:72 [inline]
 siw_newlink+0x9d9/0xe50 drivers/infiniband/sw/siw/siw_main.c:452
 nldev_newlink+0x5c0/0x640 drivers/infiniband/core/nldev.c:1795
 rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
 rdma_nl_rcv+0x6dd/0x9e0 drivers/infiniband/core/netlink.c:259
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:729 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:744
 ____sys_sendmsg+0x52a/0x7e0 net/socket.c:2609
 ___sys_sendmsg net/socket.c:2663 [inline]
 __sys_sendmsg+0x292/0x380 net/socket.c:2692
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6a537db819
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe43eb0c48 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f6a53829482 RCX: 00007f6a537db819
RDX: 00000000200040c0 RSI: 00000000200004c0 RDI: 0000000000000005
RBP: 00007f6a53829460 R08: 0000555500000000 R09: 0000555500000000
R10: 0000555500000000 R11: 000000


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

