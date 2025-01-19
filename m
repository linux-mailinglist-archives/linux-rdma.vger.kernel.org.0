Return-Path: <linux-rdma+bounces-7077-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A20A15F65
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Jan 2025 01:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 988C83A727B
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Jan 2025 00:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C270A8F54;
	Sun, 19 Jan 2025 00:44:24 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66B1D51C
	for <linux-rdma@vger.kernel.org>; Sun, 19 Jan 2025 00:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737247464; cv=none; b=FWN/Yy1NkABHnyRMrgj0zSxxW1ZaERsWqOMq82w65/dolc9UuV/Fa9qngabnhcLlZw1sTEwk8U7EubKoAQQmZtXPw+MnmhQrIHl7bsatDIhSbfb0hf4xWbJLz3djmuw42kCZYgIGRFMQE+TfJ3Znq/9ULQEbRocHJUZylk6L8qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737247464; c=relaxed/simple;
	bh=p/DtqmrW174zOHZv6OCV2YwqB72MRhdfjiMBYOkZruA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=EXI9Db30Jefbupcv5AhWVUXFcdXQS1aDjsjZfQ3Sexqz8BuLglkaCE1ovbt2Vcz3XBJLqv4qilM3nDc7kzfbGD2v8XKxgPWeAr0lpikQryeDnpDfkMiXtJyl3BXDc0ay09CAMPUu41peEU4xAFqHTBZZDb4TEBr+yqkt6hN1fjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3ce843b51c3so64910035ab.0
        for <linux-rdma@vger.kernel.org>; Sat, 18 Jan 2025 16:44:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737247462; x=1737852262;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/hV3PwyU5Y5EMg5iIeIU3QtGfVFQWWbBMNzp+/pcluU=;
        b=eiN/jQI+3zemJcJN8Yi/CkWI+GCJaYuUmJgbbkKEbJs89ssLa3mJz7h9W1ZEYGDN6A
         9YdbOWIQsJOcQESpti83iso4GWFe6M04SA4aLRm4ci9PpReSA2vWIlp19nYwbedtzHpa
         Mrw4JSy2OfWtstYwhVpZVJaYUZTjHL2RzXsOTjDqWveMux8uQynX/w6vEvQi1CM7aVX8
         LDeTDfGC7LkgUjfdEsWhvLU8lnFfiOfcVlMayN/XRHPF4wya/f+qOrQAF/hLZoLNopeY
         25E3vNpgigTUsCfHnPhrWG4OoSr8SL+AR8y4ZxoMZW+MD5WuEtEq2cvTmYIpCk1hcqKv
         M33w==
X-Forwarded-Encrypted: i=1; AJvYcCU+ixVPrRBhPV7DMss70o11yfPqHB87Vx0MH4lndVnHecYIeTJqxvelQF0ZoI5rZIH7uoH7WBqO7hVx@vger.kernel.org
X-Gm-Message-State: AOJu0YzvePAcVl3ouj1goRk7Yv18nX9a26dT20DFLvtwYfSoB6GTtai/
	FC5LtANOOjxY3CyC74Pq3i9fsBThbj1mI6dbHHk7aWrEMOCatJIyVAcyHyCkGnby7rHHLH4J2fk
	wnZ7ro8Hr2qpjoRoCWqHTkSCwyr7UlMBIn3H6GiK/Lsiaewnuo1Bur3Q=
X-Google-Smtp-Source: AGHT+IEfpH3/hF24sveBdAFYLiIWKiZ/8kOPawt0Oq86rxSRwB3YPwV8CJPR91ndd4V3cCdWy2/OV0YRs8aWbyx2oe5hVqN5b2C8
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:164f:b0:3ce:8bae:d88b with SMTP id
 e9e14a558f8ab-3cf744969a3mr71063255ab.18.1737247462054; Sat, 18 Jan 2025
 16:44:22 -0800 (PST)
Date: Sat, 18 Jan 2025 16:44:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <678c4ae6.050a0220.303755.003b.GAE@google.com>
Subject: [syzbot] [s390?] [net?] possible deadlock in smc_pnet_find_ism_resource
From: syzbot <syzbot+f160105b2817964a0886@syzkaller.appspotmail.com>
To: agordeev@linux.ibm.com, alibuda@linux.alibaba.com, davem@davemloft.net, 
	edumazet@google.com, guwen@linux.alibaba.com, horms@kernel.org, 
	jaka@linux.ibm.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	tonylu@linux.alibaba.com, wenjia@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    665bcfc982de Merge branch 'vsock-some-fixes-due-to-transpo..
git tree:       net
console+strace: https://syzkaller.appspot.com/x/log.txt?x=125a89df980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4ef22c4fce5135b4
dashboard link: https://syzkaller.appspot.com/bug?extid=f160105b2817964a0886
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=150c6a18580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=110cbcb0580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7b7bcc1c7152/disk-665bcfc9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fe966ace24a0/vmlinux-665bcfc9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b5ac36708dde/bzImage-665bcfc9.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f160105b2817964a0886@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.13.0-rc6-syzkaller-00147-g665bcfc982de #0 Not tainted
------------------------------------------------------
syz-executor304/5836 is trying to acquire lock:
ffffffff8fcb2dc8 (rtnl_mutex){+.+.}-{4:4}, at: pnet_find_base_ndev net/smc/smc_pnet.c:945 [inline]
ffffffff8fcb2dc8 (rtnl_mutex){+.+.}-{4:4}, at: smc_pnet_find_ism_by_pnetid net/smc/smc_pnet.c:1101 [inline]
ffffffff8fcb2dc8 (rtnl_mutex){+.+.}-{4:4}, at: smc_pnet_find_ism_resource+0xe1/0x510 net/smc/smc_pnet.c:1152

but task is already holding lock:
ffff888077140258 (sk_lock-AF_INET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1623 [inline]
ffff888077140258 (sk_lock-AF_INET){+.+.}-{0:0}, at: smc_connect+0xb7/0xde0 net/smc/af_smc.c:1641

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (sk_lock-AF_INET){+.+.}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       lock_sock_nested+0x48/0x100 net/core/sock.c:3625
       do_ip_setsockopt+0x1a2d/0x3cd0 net/ipv4/ip_sockglue.c:1078
       ip_setsockopt+0x63/0x100 net/ipv4/ip_sockglue.c:1417
       dccp_setsockopt+0x17c/0x12c0 net/dccp/proto.c:579
       do_sock_setsockopt+0x3af/0x720 net/socket.c:2313
       __sys_setsockopt net/socket.c:2338 [inline]
       __do_sys_setsockopt net/socket.c:2344 [inline]
       __se_sys_setsockopt net/socket.c:2341 [inline]
       __x64_sys_setsockopt+0x1ee/0x280 net/socket.c:2341
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (rtnl_mutex){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
       __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
       pnet_find_base_ndev net/smc/smc_pnet.c:945 [inline]
       smc_pnet_find_ism_by_pnetid net/smc/smc_pnet.c:1101 [inline]
       smc_pnet_find_ism_resource+0xe1/0x510 net/smc/smc_pnet.c:1152
       smc_find_ism_device net/smc/af_smc.c:1011 [inline]
       smc_find_proposal_devices net/smc/af_smc.c:1096 [inline]
       __smc_connect+0x390/0x1850 net/smc/af_smc.c:1523
       smc_connect+0x868/0xde0 net/smc/af_smc.c:1693
       __sys_connect_file net/socket.c:2055 [inline]
       __sys_connect+0x288/0x2d0 net/socket.c:2074
       __do_sys_connect net/socket.c:2080 [inline]
       __se_sys_connect net/socket.c:2077 [inline]
       __x64_sys_connect+0x7a/0x90 net/socket.c:2077
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(sk_lock-AF_INET);
                               lock(rtnl_mutex);
                               lock(sk_lock-AF_INET);
  lock(rtnl_mutex);

 *** DEADLOCK ***

1 lock held by syz-executor304/5836:
 #0: ffff888077140258 (sk_lock-AF_INET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1623 [inline]
 #0: ffff888077140258 (sk_lock-AF_INET){+.+.}-{0:0}, at: smc_connect+0xb7/0xde0 net/smc/af_smc.c:1641

stack backtrace:
CPU: 1 UID: 0 PID: 5836 Comm: syz-executor304 Not tainted 6.13.0-rc6-syzkaller-00147-g665bcfc982de #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_circular_bug+0x13a/0x1b0 kernel/locking/lockdep.c:2074
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2206
 check_prev_add kernel/locking/lockdep.c:3161 [inline]
 check_prevs_add kernel/locking/lockdep.c:3280 [inline]
 validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
 __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
 __mutex_lock_common kernel/locking/mutex.c:585 [inline]
 __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
 pnet_find_base_ndev net/smc/smc_pnet.c:945 [inline]
 smc_pnet_find_ism_by_pnetid net/smc/smc_pnet.c:1101 [inline]
 smc_pnet_find_ism_resource+0xe1/0x510 net/smc/smc_pnet.c:1152
 smc_find_ism_device net/smc/af_smc.c:1011 [inline]
 smc_find_proposal_devices net/smc/af_smc.c:1096 [inline]
 __smc_connect+0x390/0x1850 net/smc/af_smc.c:1523
 smc_connect+0x868/0xde0 net/smc/af_smc.c:1693
 __sys_connect_file net/socket.c:2055 [inline]
 __sys_connect+0x288/0x2d0 net/socket.c:2074
 __do_sys_connect net/socket.c:2080 [inline]
 __se_sys_connect net/socket.c:2077 [inline]
 __x64_sys_connect+0x7a/0x90 net/socket.c:2077
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f00e4558799
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff72e40d38 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: ffffffffffffffda RBX: 00007f00e45a5490 RCX: 00007f00e4558799
RDX: 0000000000000010 RSI: 0000000020000080 RDI: 0000000000000004
RBP: 00007f00e45a5460 R08: 0000555500000000 R09: 0000555500000000
R10: 0000000000000010 R11: 0000000000000246 R12: 00007f00e45a53e5
R13: 0000000000000001 R14: 00007fff72e40d80 R15: 0000000000000003
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

