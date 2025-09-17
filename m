Return-Path: <linux-rdma+bounces-13460-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9E5B81447
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Sep 2025 19:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 117AD7A6F63
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Sep 2025 17:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE26B2FF660;
	Wed, 17 Sep 2025 17:58:35 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C601C84C0
	for <linux-rdma@vger.kernel.org>; Wed, 17 Sep 2025 17:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758131915; cv=none; b=vBMoJUFXu6QFQhEUsrKus8eJmhFJ5zjcxgMLM1wt0LszLsXNVzFDrLCKi84818SKpZCo3o+VxjD0c7YHnWO2KtsvjkCgVt3pXzbd76wUqkNObNfHDlYAx6vi4F0eu0XRniPcndDo+Jsza/C7oYEdqYD963s/36sSBHdTenyDyTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758131915; c=relaxed/simple;
	bh=69OG071o7BEwF4No6eOyFMedk4HNChdK7jZDZfMpo+I=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qigxWvhUcAyX9nImuUmS7oJ92/2RvSH7SC6heD6zb/mrCWW1hgf4ME4dAtiYGd1+rtvHUq3qKrp+XKKfbdXKDzSTh+hy9Hc1Mb1+E+GD+OFgkUUeQG/E9LTuMldA+xJi9kbwLBmeob/oKX6PrRvzSJ9PH2sydJsXcIPjho7v80c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-424090abf73so193405ab.3
        for <linux-rdma@vger.kernel.org>; Wed, 17 Sep 2025 10:58:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758131913; x=1758736713;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qigWR4tgTt8PlUwu+HTH5RtNoyHT1mfFt7jRXPhJuVk=;
        b=U5aD2BGSMjI3IvFiA4Oe4YiHk4woAAIsAdRgftrsIa4Q7B9px4We882U66giIsRTq6
         uZuZlywZPaWuY5hX2SUoR+2VcG3X6RudHKec4mSuNp82XluFAp7lqwzItPgz4cnpR3A+
         N+lya5axl1XTec5ZJLI1EHHd+GwEKf2wMxyIdMxKBhNCItrDAi+eIDRUR6d1EXe3ugwM
         EribDOvLguUzVuJxmmPHtbVnbauu/h6xPqJPsf0UfozitjwlfXiNo7BUTJnXrFTl6CZ3
         MDSgKLWuGQPrW0AcypzhDOt67JcTz8oApconlEtKSD+/xEspOFRcD+ciPW5Yyw+YCHCg
         Vt1A==
X-Forwarded-Encrypted: i=1; AJvYcCXCgaIvWJC6EHsxkcZFLHnOdNbRFkxIhT1PqOTpQQKfwW+xrmaXjXZdRk4SrpS/lCSE8LW4ILq6pIfO@vger.kernel.org
X-Gm-Message-State: AOJu0YwiJMfpY7MaLKS8juNJUszrxTemsKEwmnvqlvukA3yuiylQAsME
	PoPKrzrObQaIOAaGwFymTtmAaIpwZ1A+R8YkFpefrXuyl7nJ78DtoQRfm/ML6bZlLBdlC5064wh
	H96+09t2AH/gBUvOAK/Tqz1qb7GYU9Tt3mQEfin3GEOfFyuaJJ6M1zZkr+eA=
X-Google-Smtp-Source: AGHT+IHI8JKeGFowjLy0Wq7k903HGmQnMboTuhZ97GWWaj4JMLmqqLM0pV4N9Nrzx89PQOqS034ZZG3LZBWnD5Vd6m6W/MspODLB
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1567:b0:423:fd65:ff02 with SMTP id
 e9e14a558f8ab-4241a4cfc3emr41068525ab.4.1758131911038; Wed, 17 Sep 2025
 10:58:31 -0700 (PDT)
Date: Wed, 17 Sep 2025 10:58:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68caf6c7.050a0220.2ff435.0597.GAE@google.com>
Subject: [syzbot] [smc?] general protection fault in __smc_diag_dump (4)
From: syzbot <syzbot+f775be4458668f7d220e@syzkaller.appspotmail.com>
To: alibuda@linux.alibaba.com, davem@davemloft.net, dust.li@linux.alibaba.com, 
	edumazet@google.com, guwen@linux.alibaba.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-s390@vger.kernel.org, mjambigi@linux.ibm.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, sidraya@linux.ibm.com, syzkaller-bugs@googlegroups.com, 
	tonylu@linux.alibaba.com, wenjia@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5aca7966d2a7 Merge tag 'perf-tools-fixes-for-v6.17-2025-09..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=147e2e42580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f01d8629880e620
dashboard link: https://syzkaller.appspot.com/bug?extid=f775be4458668f7d220e
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17aec534580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=115a9f62580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f191b2524020/disk-5aca7966.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5aa02ba0cba2/vmlinux-5aca7966.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b9b04ddba61b/bzImage-5aca7966.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f775be4458668f7d220e@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xfbd5a5d5a0000003: 0000 [#1] SMP KASAN NOPTI
KASAN: maybe wild-memory-access in range [0xdead4ead00000018-0xdead4ead0000001f]
CPU: 1 UID: 0 PID: 6949 Comm: syz.0.335 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
RIP: 0010:smc_diag_msg_common_fill net/smc/smc_diag.c:44 [inline]
RIP: 0010:__smc_diag_dump.constprop.0+0x3ca/0x2550 net/smc/smc_diag.c:89
Code: 4c 8b b3 40 06 00 00 4d 85 f6 0f 84 f6 02 00 00 e8 6b 4f 78 f6 49 8d 7e 18 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 f6 1e 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b
RSP: 0018:ffffc90003f2f1a8 EFLAGS: 00010a06
RAX: dffffc0000000000 RBX: ffff88802a33bd40 RCX: ffffffff897ee8a4
RDX: 1bd5a9d5a0000003 RSI: ffffffff8b434dd5 RDI: dead4ead00000018
RBP: ffff888032418000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000001 R11: 0000000000000000 R12: ffff8880754915f0
R13: ffff88805d823780 R14: dead4ead00000000 R15: ffff88802a33c380
FS:  00007fec5f7dd6c0(0000) GS:ffff8881247b2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fec5f7dcf98 CR3: 000000007d646000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 smc_diag_dump_proto+0x26d/0x420 net/smc/smc_diag.c:217
 smc_diag_dump+0x27/0x90 net/smc/smc_diag.c:234
 netlink_dump+0x539/0xd30 net/netlink/af_netlink.c:2327
 __netlink_dump_start+0x6d6/0x990 net/netlink/af_netlink.c:2442
 netlink_dump_start include/linux/netlink.h:341 [inline]
 smc_diag_handler_dump+0x1f9/0x240 net/smc/smc_diag.c:251
 __sock_diag_cmd net/core/sock_diag.c:249 [inline]
 sock_diag_rcv_msg+0x438/0x790 net/core/sock_diag.c:285
 netlink_rcv_skb+0x158/0x420 net/netlink/af_netlink.c:2552
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x5a7/0x870 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x8d1/0xdd0 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg net/socket.c:729 [inline]
 ____sys_sendmsg+0xa95/0xc70 net/socket.c:2614
 ___sys_sendmsg+0x134/0x1d0 net/socket.c:2668
 __sys_sendmsg+0x16d/0x220 net/socket.c:2700
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4e0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fec6018eba9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fec5f7dd038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fec603d6090 RCX: 00007fec6018eba9
RDX: 0000000000000000 RSI: 0000200000000140 RDI: 0000000000000003
RBP: 00007fec60211e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fec603d6128 R14: 00007fec603d6090 R15: 00007ffcb0713c08
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:smc_diag_msg_common_fill net/smc/smc_diag.c:44 [inline]
RIP: 0010:__smc_diag_dump.constprop.0+0x3ca/0x2550 net/smc/smc_diag.c:89
Code: 4c 8b b3 40 06 00 00 4d 85 f6 0f 84 f6 02 00 00 e8 6b 4f 78 f6 49 8d 7e 18 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 f6 1e 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b
RSP: 0018:ffffc90003f2f1a8 EFLAGS: 00010a06
RAX: dffffc0000000000 RBX: ffff88802a33bd40 RCX: ffffffff897ee8a4
RDX: 1bd5a9d5a0000003 RSI: ffffffff8b434dd5 RDI: dead4ead00000018
RBP: ffff888032418000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000001 R11: 0000000000000000 R12: ffff8880754915f0
R13: ffff88805d823780 R14: dead4ead00000000 R15: ffff88802a33c380
FS:  00007fec5f7dd6c0(0000) GS:ffff8881247b2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fec5f7dcf98 CR3: 000000007d646000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	4c 8b b3 40 06 00 00 	mov    0x640(%rbx),%r14
   7:	4d 85 f6             	test   %r14,%r14
   a:	0f 84 f6 02 00 00    	je     0x306
  10:	e8 6b 4f 78 f6       	call   0xf6784f80
  15:	49 8d 7e 18          	lea    0x18(%r14),%rdi
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 f6 1e 00 00    	jne    0x1f2a
  34:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  3b:	fc ff df
  3e:	4d                   	rex.WRB
  3f:	8b                   	.byte 0x8b


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

