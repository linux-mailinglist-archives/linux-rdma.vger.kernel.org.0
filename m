Return-Path: <linux-rdma+bounces-7079-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FA5A16065
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Jan 2025 06:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8D401886A2F
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Jan 2025 05:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED991885A1;
	Sun, 19 Jan 2025 05:50:28 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE9A502B1
	for <linux-rdma@vger.kernel.org>; Sun, 19 Jan 2025 05:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737265828; cv=none; b=lNh2p0yd66u5Lzrp6gGa8b3jeXaOwSed6LAuACk80YE9H6Zi9/iuB/TaGq8ymaBlQ3JETIv+MTMOdx4jco6Avww6X4hUkiOPg3BtGwpTU2w55C2/7VBPKuvr6hwYpCjCYiYpxIUurblJNiCqNk24F/Lh3yCKhnrsU+63IX4BAW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737265828; c=relaxed/simple;
	bh=KtiYxz19VrU3uK87Xq6veb7Q5cbyysOLAtYiN0HIomA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=P3qAOtr1wauaWO9VsD/VjWyIZ/ZbVv6yRw2L7ZdFGeviZrXio2agcmmKem4/88pfNsb9Mw/KjhmL8SbrjndemtvVgAXtate/eLZjNSYoqR7TZfOmGUdHLgIGuKdPTdlXX+txDgbjx9ZAakMH7hzD9Hd7+shoVgDr6D5ol9jTioc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3ce81381737so58800345ab.2
        for <linux-rdma@vger.kernel.org>; Sat, 18 Jan 2025 21:50:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737265825; x=1737870625;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CGOLwG0ZYOhOJOG2wsSGObkhiF3ZcrTZyJ00Z0CuwkA=;
        b=pBoF+x22ry1EQ29Vo5+AfPTmtVs3+1H71pv/3Gy+TJUdMoNvHg4vYjsh3r4Q8r36F8
         cnUeL2fhEF8SAney4GLIyN/U3peRUIg476GjWvxHLd93StHQ6diHAe8ABAEKHYvWBAhP
         2NAQhQUM63LrnIjRSwbokEyn8qq3RknU5RuoMZtlEajLMGg8awRpaToPjExS2R4UhaKA
         y9jPYi20wu6vJJ5e4YdtyZGPtsJf6Ia6I4Qtls9isKWpY2h3pL6FMRk9vLNDkyG90owm
         5M6pZhCpZiE+jkyr5M+46N2TIViY1v81O6AOgScIZ7DUCRq6ErndvC+N6ZYoEC9gjUwD
         e+Aw==
X-Forwarded-Encrypted: i=1; AJvYcCWN4JKNfKyDLFTEuwb+yLWXJqMSRN/IdYcGos9iouO7DUENQyWKa4xkmy3/YtA9N6DZTSq+vGGBt0fY@vger.kernel.org
X-Gm-Message-State: AOJu0YwqFCiuVG4RGfjrUL3KtbvyQD9Buwh7Y27uKHwhYdsKwDoAU0Qw
	4sTo9II4S7NxCfgeQbEzNCfDN8SxsazIs5guV0ZzqAd2EtOHlZwi21CyyCI61l1pmsGu79sYsOX
	kMnEARfPIfye25MtEoqgr+i9PTnuRAmfFTvEzJrNWLEI8s6YUhetvfO4=
X-Google-Smtp-Source: AGHT+IF/7QCHZqtagmzSrRYsqMT151+fc9BUplRNPMhANA0290vDu09egR2h0tKKaOsbWYAreN15TWjDfn79X2poi5rYUymE2ehM
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fcd:b0:3a6:ad61:7ff8 with SMTP id
 e9e14a558f8ab-3cf7442a567mr71606145ab.12.1737265825444; Sat, 18 Jan 2025
 21:50:25 -0800 (PST)
Date: Sat, 18 Jan 2025 21:50:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <678c92a1.050a0220.303755.004c.GAE@google.com>
Subject: [syzbot] [s390?] [net?] possible deadlock in smc_close_non_accepted (2)
From: syzbot <syzbot+a68f8bafb37fc879d662@syzkaller.appspotmail.com>
To: agordeev@linux.ibm.com, alibuda@linux.alibaba.com, davem@davemloft.net, 
	edumazet@google.com, guwen@linux.alibaba.com, horms@kernel.org, 
	jaka@linux.ibm.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	tonylu@linux.alibaba.com, wenjia@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c3812b15000c Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=137189df980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5e182416a4b418f
dashboard link: https://syzkaller.appspot.com/bug?extid=a68f8bafb37fc879d662
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d3f1a4960f46/disk-c3812b15.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6816bebbf8db/vmlinux-c3812b15.xz
kernel image: https://storage.googleapis.com/syzbot-assets/112bb789a175/bzImage-c3812b15.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a68f8bafb37fc879d662@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.13.0-rc7-syzkaller-00039-gc3812b15000c #0 Not tainted
------------------------------------------------------
syz.1.909/9790 is trying to acquire lock:
ffff8880325e8dd8 (sk_lock-AF_SMC){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1623 [inline]
ffff8880325e8dd8 (sk_lock-AF_SMC){+.+.}-{0:0}, at: smc_close_non_accepted+0x80/0x200 net/smc/af_smc.c:1832

but task is already holding lock:
ffff88807a380dd8 (sk_lock-AF_INET/1){+.+.}-{0:0}, at: smc_release+0x378/0x5f0 net/smc/af_smc.c:336

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 (sk_lock-AF_INET/1){+.+.}-{0:0}:
       lock_sock_nested+0x3a/0xf0 net/core/sock.c:3625
       sctp_sock_migrate+0x987/0x1270 net/sctp/socket.c:9655
       sctp_accept+0x654/0x800 net/sctp/socket.c:4899
       inet_accept+0xc4/0x180 net/ipv4/af_inet.c:781
       do_accept+0x337/0x530 net/socket.c:1941
       __sys_accept4_file net/socket.c:1981 [inline]
       __sys_accept4+0xfe/0x1b0 net/socket.c:2010
       __do_sys_accept net/socket.c:2023 [inline]
       __se_sys_accept net/socket.c:2020 [inline]
       __x64_sys_accept+0x74/0xb0 net/socket.c:2020
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #3 (sk_lock-AF_INET){+.+.}-{0:0}:
       lock_sock_nested+0x3a/0xf0 net/core/sock.c:3625
       lock_sock include/net/sock.h:1623 [inline]
       sockopt_lock_sock net/core/sock.c:1126 [inline]
       sockopt_lock_sock+0x54/0x70 net/core/sock.c:1117
       do_ip_setsockopt+0x101/0x38c0 net/ipv4/ip_sockglue.c:1078
       ip_setsockopt+0x59/0xf0 net/ipv4/ip_sockglue.c:1417
       raw_setsockopt+0xb8/0x290 net/ipv4/raw.c:845
       do_sock_setsockopt+0x222/0x480 net/socket.c:2313
       __sys_setsockopt+0x1a0/0x230 net/socket.c:2338
       __do_sys_setsockopt net/socket.c:2344 [inline]
       __se_sys_setsockopt net/socket.c:2341 [inline]
       __x64_sys_setsockopt+0xbd/0x160 net/socket.c:2341
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (rtnl_mutex){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x19b/0xa60 kernel/locking/mutex.c:735
       do_ip_setsockopt+0xf9/0x38c0 net/ipv4/ip_sockglue.c:1077
       ip_setsockopt+0x59/0xf0 net/ipv4/ip_sockglue.c:1417
       ipv6_setsockopt+0x155/0x170 net/ipv6/ipv6_sockglue.c:988
       tcp_setsockopt+0xa4/0x100 net/ipv4/tcp.c:4030
       smc_setsockopt+0x1b4/0xc00 net/smc/af_smc.c:3078
       do_sock_setsockopt+0x222/0x480 net/socket.c:2313
       __sys_setsockopt+0x1a0/0x230 net/socket.c:2338
       __do_sys_setsockopt net/socket.c:2344 [inline]
       __se_sys_setsockopt net/socket.c:2341 [inline]
       __x64_sys_setsockopt+0xbd/0x160 net/socket.c:2341
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&smc->clcsock_release_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x19b/0xa60 kernel/locking/mutex.c:735
       smc_switch_to_fallback+0x2d/0xa00 net/smc/af_smc.c:903
       smc_sendmsg+0x13d/0x520 net/smc/af_smc.c:2778
       sock_sendmsg_nosec net/socket.c:711 [inline]
       __sock_sendmsg net/socket.c:726 [inline]
       ____sys_sendmsg+0x9ae/0xb40 net/socket.c:2583
       ___sys_sendmsg+0x135/0x1e0 net/socket.c:2637
       __sys_sendmmsg+0x201/0x420 net/socket.c:2726
       __do_sys_sendmmsg net/socket.c:2753 [inline]
       __se_sys_sendmmsg net/socket.c:2750 [inline]
       __x64_sys_sendmmsg+0x9c/0x100 net/socket.c:2750
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (sk_lock-AF_SMC){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain kernel/locking/lockdep.c:3904 [inline]
       __lock_acquire+0x249e/0x3c40 kernel/locking/lockdep.c:5226
       lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5849
       lock_sock_nested+0x3a/0xf0 net/core/sock.c:3625
       lock_sock include/net/sock.h:1623 [inline]
       smc_close_non_accepted+0x80/0x200 net/smc/af_smc.c:1832
       smc_close_cleanup_listen net/smc/smc_close.c:45 [inline]
       smc_close_active+0xc3c/0x1070 net/smc/smc_close.c:225
       __smc_release+0x634/0x880 net/smc/af_smc.c:277
       smc_release+0x1fc/0x5f0 net/smc/af_smc.c:344
       __sock_release+0xb0/0x270 net/socket.c:640
       sock_close+0x1c/0x30 net/socket.c:1408
       __fput+0x3f8/0xb60 fs/file_table.c:450
       task_work_run+0x14e/0x250 kernel/task_work.c:239
       resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
       exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
       exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
       __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
       syscall_exit_to_user_mode+0x27b/0x2a0 kernel/entry/common.c:218
       do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  sk_lock-AF_SMC --> sk_lock-AF_INET --> sk_lock-AF_INET/1

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(sk_lock-AF_INET/1);
                               lock(sk_lock-AF_INET);
                               lock(sk_lock-AF_INET/1);
  lock(sk_lock-AF_SMC);

 *** DEADLOCK ***

2 locks held by syz.1.909/9790:
 #0: ffff888049c7f408 (&sb->s_type->i_mutex_key#10){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:818 [inline]
 #0: ffff888049c7f408 (&sb->s_type->i_mutex_key#10){+.+.}-{4:4}, at: __sock_release+0x86/0x270 net/socket.c:639
 #1: ffff88807a380dd8 (sk_lock-AF_INET/1){+.+.}-{0:0}, at: smc_release+0x378/0x5f0 net/smc/af_smc.c:336

stack backtrace:
CPU: 0 UID: 0 PID: 9790 Comm: syz.1.909 Not tainted 6.13.0-rc7-syzkaller-00039-gc3812b15000c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_circular_bug+0x41c/0x610 kernel/locking/lockdep.c:2074
 check_noncircular+0x31a/0x400 kernel/locking/lockdep.c:2206
 check_prev_add kernel/locking/lockdep.c:3161 [inline]
 check_prevs_add kernel/locking/lockdep.c:3280 [inline]
 validate_chain kernel/locking/lockdep.c:3904 [inline]
 __lock_acquire+0x249e/0x3c40 kernel/locking/lockdep.c:5226
 lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5849
 lock_sock_nested+0x3a/0xf0 net/core/sock.c:3625
 lock_sock include/net/sock.h:1623 [inline]
 smc_close_non_accepted+0x80/0x200 net/smc/af_smc.c:1832
 smc_close_cleanup_listen net/smc/smc_close.c:45 [inline]
 smc_close_active+0xc3c/0x1070 net/smc/smc_close.c:225
 __smc_release+0x634/0x880 net/smc/af_smc.c:277
 smc_release+0x1fc/0x5f0 net/smc/af_smc.c:344
 __sock_release+0xb0/0x270 net/socket.c:640
 sock_close+0x1c/0x30 net/socket.c:1408
 __fput+0x3f8/0xb60 fs/file_table.c:450
 task_work_run+0x14e/0x250 kernel/task_work.c:239
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x27b/0x2a0 kernel/entry/common.c:218
 do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe6cff85d29
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe6d0ce0038 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 00007fe6d0175fa0 RCX: 00007fe6cff85d29
RDX: 0000000000000000 RSI: 000000000000000a RDI: 0000000000000002
RBP: 00007fe6d0001b08 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fe6d0175fa0 R15: 00007ffd3f25a1e8
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

