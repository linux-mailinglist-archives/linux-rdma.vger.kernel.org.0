Return-Path: <linux-rdma+bounces-12662-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE37B2032F
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Aug 2025 11:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF7F87B03EA
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Aug 2025 09:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DBA82DD5E2;
	Mon, 11 Aug 2025 09:21:30 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0212DBF40
	for <linux-rdma@vger.kernel.org>; Mon, 11 Aug 2025 09:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754904089; cv=none; b=Mk6F8IeB0W5oOJHj67oXChckRKXHPigK924wtXHQpW9avG9kCn+nbM9cZ8l1tDmMXf7caSr3cfg0v0OKF0bSMoaKIVxgwQEGKIuZ1qnvZaK0druBGvVVca+WsYOOZMlnw6ZIqZxNrkILGh6Q84mHu0SyJ5Eq50clL3Yj6BFb4aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754904089; c=relaxed/simple;
	bh=W76zloFqqtTCXXYeHwACopxIsPS5jpr5hiuh/RqyVfw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=WBQAuxzHijBsmJyie7U/gswhQ+i/HDPzZ0VYjHcR2O/mXHDbnPfIB2if4Q24jaH7hSrl8uYEgSa+fkzDku8DGbYQPSBY3swRxrYwAnl4DuwVtYdl0lM829OLzPlhy94LBNrR/xAj3INJFDC5LsV/9smSw11NV2AKmWYZgo9pw6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-881855cd566so440744139f.2
        for <linux-rdma@vger.kernel.org>; Mon, 11 Aug 2025 02:21:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754904087; x=1755508887;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JFIyLiepyehGnnd/8SdRVdnEJ3aC9IGjzOijBFjt4vM=;
        b=THUHLoZRDU1r64DW53fU5UjNM0eG1Rumz0c1ZocZapta0JXA7FrlK01lZeFqgOcQiG
         y2yhEDc+mM/CKrws5hNfAzlqdHXktUTvggI5OgSg8UViMG7eW2JiF91+yFwYBbYUTCXC
         WrvR2OCx6/lqxBqmEhTBxVhXQg/OEucEhPEGmuFW2J5iHEPnzQ5Hu71bHntXDClYfOaG
         CUkUmqAEkdpYqrYR49afkFXEzfPrz8pZWGVm6AHolhzYRDZKuKqp4WhWSiK5xjww67qH
         /EwN5HaqsopV2tOePxR1Ve9wegqGWcIGVk3bwmlpdNuP87s3ldwHPpxqG87+5kVfrX9g
         zVEA==
X-Forwarded-Encrypted: i=1; AJvYcCXo+EfSkQXoNuTbuPBCEkZl2U01+xe8yKFLqX+/gFN1gAcrJQYx7bK4tYeNBGiTUfngqvW02s1tuDwb@vger.kernel.org
X-Gm-Message-State: AOJu0YyxMeCmcGxSKEnp47PL/dYi7gYpb093a7Ui5XFjOTRqsG+31Nop
	AqaIkk8PFHroB//DCN8QCLK//bmgG6CBeZ7285XP2yP7SMC1tfCnuFDgIlsSNgjw9FDxg1pYyMw
	eghpRolv7xwi3iHWU+BWeBWEAz8+N51i5ZJYMht0FPNRWQHDIw8I8Na3yWkg=
X-Google-Smtp-Source: AGHT+IGxwbkP15zBq7Lu8UfEZIf9saKXL7GHHTZAhg7ljtDflStHZmRM1DdI2tLptCu7PLTKnU5mMyhwzL2pPL620iBu2uGVYhiN
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1691:b0:862:fe54:df4e with SMTP id
 ca18e2360f4ac-883f12051e5mr2003295339f.7.1754904086818; Mon, 11 Aug 2025
 02:21:26 -0700 (PDT)
Date: Mon, 11 Aug 2025 02:21:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6899b616.050a0220.7f033.00f2.GAE@google.com>
Subject: [syzbot] [rdma?] general protection fault in kobj_kset_leave
From: syzbot <syzbot+9d2945f0705b91485559@syzkaller.appspotmail.com>
To: jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6e64f4580381 Merge tag 'input-for-v6.17-rc0' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16f46434580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5f2996d42fef6c09
dashboard link: https://syzkaller.appspot.com/bug?extid=9d2945f0705b91485559
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5166c0e1d4f0/disk-6e64f458.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0d6654192cf8/vmlinux-6e64f458.xz
kernel image: https://storage.googleapis.com/syzbot-assets/239aaa681481/bzImage-6e64f458.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9d2945f0705b91485559@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc001fffe005: 0000 [#1] SMP KASAN NOPTI
KASAN: probably user-memory-access in range [0x00000000ffff0028-0x00000000ffff002f]
CPU: 1 UID: 0 PID: 19011 Comm: kworker/u8:21 Not tainted 6.16.0-syzkaller-11952-g6e64f4580381 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Workqueue: netns cleanup_net
RIP: 0010:kasan_byte_accessible+0x15/0x30 mm/kasan/generic.c:199
Code: 00 00 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00 48 b8 00 00 00 00 00 fc ff df 48 c1 ef 03 48 01 c7 <0f> b6 07 3c 07 0f 96 c0 e9 8e c1 73 09 66 66 2e 0f 1f 84 00 00 00
RSP: 0018:ffffc90003337890 EFLAGS: 00010286
RAX: dffffc0000000000 RBX: 00000000ffff0028 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8b95536e RDI: dffffc001fffe005
RBP: 00000000ffff0028 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000002c10 R12: ffffffff8b95536e
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8881247c4000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b3011cff8 CR3: 00000000685cb000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000003706
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __kasan_check_byte+0x13/0x50 mm/kasan/common.c:567
 kasan_check_byte include/linux/kasan.h:399 [inline]
 lock_acquire kernel/locking/lockdep.c:5842 [inline]
 lock_acquire+0xfc/0x350 kernel/locking/lockdep.c:5825
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:351 [inline]
 kobj_kset_leave+0x50/0x200 lib/kobject.c:191
 __kobject_del+0x11d/0x1f0 lib/kobject.c:608
 kobject_del lib/kobject.c:627 [inline]
 kobject_del+0x3f/0x60 lib/kobject.c:619
 destroy_gid_attrs drivers/infiniband/core/sysfs.c:1183 [inline]
 ib_free_port_attrs+0x280/0x490 drivers/infiniband/core/sysfs.c:1407
 remove_one_compat_dev drivers/infiniband/core/device.c:1038 [inline]
 rdma_dev_exit_net+0x2b5/0x590 drivers/infiniband/core/device.c:1176
 ops_exit_list net/core/net_namespace.c:198 [inline]
 ops_undo_list+0x2ee/0xab0 net/core/net_namespace.c:251
 cleanup_net+0x408/0x890 net/core/net_namespace.c:682
 process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3236
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
 kthread+0x3c5/0x780 kernel/kthread.c:463
 ret_from_fork+0x5d4/0x6f0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:kasan_byte_accessible+0x15/0x30 mm/kasan/generic.c:199
Code: 00 00 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00 48 b8 00 00 00 00 00 fc ff df 48 c1 ef 03 48 01 c7 <0f> b6 07 3c 07 0f 96 c0 e9 8e c1 73 09 66 66 2e 0f 1f 84 00 00 00
RSP: 0018:ffffc90003337890 EFLAGS: 00010286
RAX: dffffc0000000000 RBX: 00000000ffff0028 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8b95536e RDI: dffffc001fffe005
RBP: 00000000ffff0028 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000002c10 R12: ffffffff8b95536e
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8881247c4000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b3011cff8 CR3: 00000000685cb000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000003706
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	00 00                	add    %al,(%rax)
   2:	0f 1f 00             	nopl   (%rax)
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	90                   	nop
   9:	90                   	nop
   a:	90                   	nop
   b:	90                   	nop
   c:	90                   	nop
   d:	90                   	nop
   e:	90                   	nop
   f:	90                   	nop
  10:	90                   	nop
  11:	90                   	nop
  12:	90                   	nop
  13:	90                   	nop
  14:	90                   	nop
  15:	66 0f 1f 00          	nopw   (%rax)
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	48 c1 ef 03          	shr    $0x3,%rdi
  27:	48 01 c7             	add    %rax,%rdi
* 2a:	0f b6 07             	movzbl (%rdi),%eax <-- trapping instruction
  2d:	3c 07                	cmp    $0x7,%al
  2f:	0f 96 c0             	setbe  %al
  32:	e9 8e c1 73 09       	jmp    0x973c1c5
  37:	66                   	data16
  38:	66                   	data16
  39:	2e                   	cs
  3a:	0f                   	.byte 0xf
  3b:	1f                   	(bad)
  3c:	84 00                	test   %al,(%rax)


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

