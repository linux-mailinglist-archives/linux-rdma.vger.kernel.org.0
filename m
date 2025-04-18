Return-Path: <linux-rdma+bounces-9586-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC01FA936D4
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Apr 2025 14:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBD7E176FB5
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Apr 2025 12:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5C32741A9;
	Fri, 18 Apr 2025 12:08:24 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5FC268FF2
	for <linux-rdma@vger.kernel.org>; Fri, 18 Apr 2025 12:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744978104; cv=none; b=Vs2N9pgMI5IyStTzBph6mMeAwqzLUSfGWrB9fZZwDSEDM9ZeFCOPi1k6UHVQ+3GlBTV2gL9Ux4utPO1VrMHZ4IpKfN6jqIdUAMsUOOc3qLn3MnTUihvxPgDrdZIxsZnuC9msoK92JKYvkwN417NNK3bF01EssyVAWEAVZjLYcIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744978104; c=relaxed/simple;
	bh=8pK6dbXeXw9Tyu/wII90qV0dGtq0tr/qLdp/d2oTNzs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=jXWhpe5D4N36pXlpcCVfQGKg38iadlqDvSSmxf4JFt8gmWYeP4ANlIJbL3vNgfEMnS9TNRQDJ5OHrxurdrAvYT12osTb5lcBK2VRGtCPZTpW7Hvh8SEDXRyLaRBmnNrV+g3IphyYIPOHz8HvkDkCIlz8h5ipWs+107+niVJgVF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3d6e10e3644so18158135ab.1
        for <linux-rdma@vger.kernel.org>; Fri, 18 Apr 2025 05:08:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744978102; x=1745582902;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AzUzRjao+FxUJfZ6bBzW7/hvxHgDfmg7AtciXtp40m4=;
        b=YZcrTIsOk5n92C+bvNOq4zV5lucIwlJcFqdecfK2V5j4eoddX85q3Ex2z0eflpI4Jh
         gQG570xh0r8TZJmOFf5UVpx70zfkJylNc6HmtTMTjhjB2pgcyqMpE0hxATNiposh5g8F
         BcnFsH4RqDQkO3GJ8LMsYPQMoyXbr9LgsyxBf166eH30vhpoHqsvXa+KRHIl/f7bPLjb
         bf46b6eCg0TYKwrLCSbj8I5YI61k7T8WzYp7QQIuwxMoSZN8NFcIpYSZGbQssst+eGIX
         DYlZwRu99iogA3KzYmSb423IA3+Sn/+zpCPeY9y/D21Vj2O3bK1iDFhU2i7OkB0Pi6sZ
         OnTA==
X-Forwarded-Encrypted: i=1; AJvYcCXq/VKjE3ZUsSDOoQpUOHVGO3vuofjpSBujJU3MEHjEJCDZIECk+zFVfv0VD0T/iU2dwfJoGyWIGdaR@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq3abpMn2sc9arsbF72Mdjfd1Yi14vW8bz8lS4w2PxR5N9/wfn
	M1AxQrmmfOJwC11S8JfRtAE+YeMIvXqVPza938hQsWJ2M72YmRup/hWOyHQyGMOHaAYx24H8GDV
	/CjoUbZ4A402H/NxEv494uIQZCkKRS5cqmDRYKX4SMwjEqPLtD4m/h1o=
X-Google-Smtp-Source: AGHT+IFbx+v9AvwPwRG5r5l+UCCFypKNmbwwiW7Eh1a/sww4AnAEeR62RC4ucUFADbLKcyRLJ484OCRw0cFo6BNGLwlLEXWwJ+D8
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1569:b0:3cf:bac5:d90c with SMTP id
 e9e14a558f8ab-3d89417d9bemr23198105ab.18.1744978101966; Fri, 18 Apr 2025
 05:08:21 -0700 (PDT)
Date: Fri, 18 Apr 2025 05:08:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <680240b5.050a0220.297747.0007.GAE@google.com>
Subject: [syzbot] [rdma?] INFO: trying to register non-static key in rxe_qp_do_cleanup
From: syzbot <syzbot+4edb496c3cad6e953a31@syzkaller.appspotmail.com>
To: jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	zyjzyj2000@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8ffd015db85f Linux 6.15-rc2
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16bc20cc580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=51ecb841db3b3687
dashboard link: https://syzkaller.appspot.com/bug?extid=4edb496c3cad6e953a31
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7aa92e6fb2e5/disk-8ffd015d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1458d069253c/vmlinux-8ffd015d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fe6dd8111695/bzImage-8ffd015d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4edb496c3cad6e953a31@syzkaller.appspotmail.com

INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
CPU: 1 UID: 0 PID: 1151 Comm: kworker/u8:8 Not tainted 6.15.0-rc2-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Workqueue: rdma_cm cma_work_handler
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 assign_lock_key kernel/locking/lockdep.c:986 [inline]
 register_lock_class+0x4a3/0x4c0 kernel/locking/lockdep.c:1300
 __lock_acquire+0x99/0x1ba0 kernel/locking/lockdep.c:5110
 lock_acquire kernel/locking/lockdep.c:5866 [inline]
 lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5823
 __timer_delete_sync+0x152/0x1b0 kernel/time/timer.c:1644
 rxe_qp_do_cleanup+0x5c3/0x7e0 drivers/infiniband/sw/rxe/rxe_qp.c:815
 execute_in_process_context+0x3a/0x160 kernel/workqueue.c:4596
 __rxe_cleanup+0x267/0x3c0 drivers/infiniband/sw/rxe/rxe_pool.c:232
 rxe_create_qp+0x3f7/0x5f0 drivers/infiniband/sw/rxe/rxe_verbs.c:604
 create_qp+0x62d/0xa80 drivers/infiniband/core/verbs.c:1250
 ib_create_qp_kernel+0x9f/0x310 drivers/infiniband/core/verbs.c:1361
 ib_create_qp include/rdma/ib_verbs.h:3803 [inline]
 rdma_create_qp+0x10c/0x340 drivers/infiniband/core/cma.c:1144
 rds_ib_setup_qp+0xc86/0x19a0 net/rds/ib_cm.c:600
 rds_ib_cm_initiate_connect+0x1e8/0x3d0 net/rds/ib_cm.c:944
 rds_rdma_cm_event_handler_cmn+0x61f/0x8c0 net/rds/rdma_transport.c:109
 cma_cm_event_handler+0x94/0x300 drivers/infiniband/core/cma.c:2184
 cma_work_handler+0x15b/0x230 drivers/infiniband/core/cma.c:3042
 process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
 kthread+0x3c2/0x780 kernel/kthread.c:464
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
------------[ cut here ]------------
ODEBUG: assert_init not available (active state 0) object: ffff8880541d8a58 object type: timer_list hint: 0x0
WARNING: CPU: 1 PID: 1151 at lib/debugobjects.c:612 debug_print_object+0x1a2/0x2b0 lib/debugobjects.c:612
Modules linked in:
CPU: 1 UID: 0 PID: 1151 Comm: kworker/u8:8 Not tainted 6.15.0-rc2-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Workqueue: rdma_cm cma_work_handler
RIP: 0010:debug_print_object+0x1a2/0x2b0 lib/debugobjects.c:612
Code: fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 75 54 41 56 48 8b 14 dd e0 73 f4 8b 4c 89 e6 48 c7 c7 60 68 f4 8b e8 1f db a5 fc 90 <0f> 0b 90 90 58 83 05 76 9b b1 0b 01 48 83 c4 18 5b 5d 41 5c 41 5d
RSP: 0018:ffffc90003eb73e8 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000005 RCX: ffffffff817acff8
RDX: ffff888027be8000 RSI: ffffffff817ad005 RDI: 0000000000000001
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffffffff8bf46f40
R13: ffffffff8b8fc880 R14: 0000000000000000 R15: ffffc90003eb74a8
FS:  0000000000000000(0000) GS:ffff888124ab2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c32628d CR3: 000000000e182000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 debug_object_assert_init+0x1ec/0x2f0 lib/debugobjects.c:1020
 debug_timer_assert_init kernel/time/timer.c:845 [inline]
 debug_assert_init kernel/time/timer.c:890 [inline]
 __try_to_del_timer_sync+0x7f/0x170 kernel/time/timer.c:1499
 __timer_delete_sync+0xf4/0x1b0 kernel/time/timer.c:1662
 rxe_qp_do_cleanup+0x5c3/0x7e0 drivers/infiniband/sw/rxe/rxe_qp.c:815
 execute_in_process_context+0x3a/0x160 kernel/workqueue.c:4596
 __rxe_cleanup+0x267/0x3c0 drivers/infiniband/sw/rxe/rxe_pool.c:232
 rxe_create_qp+0x3f7/0x5f0 drivers/infiniband/sw/rxe/rxe_verbs.c:604
 create_qp+0x62d/0xa80 drivers/infiniband/core/verbs.c:1250
 ib_create_qp_kernel+0x9f/0x310 drivers/infiniband/core/verbs.c:1361
 ib_create_qp include/rdma/ib_verbs.h:3803 [inline]
 rdma_create_qp+0x10c/0x340 drivers/infiniband/core/cma.c:1144
 rds_ib_setup_qp+0xc86/0x19a0 net/rds/ib_cm.c:600
 rds_ib_cm_initiate_connect+0x1e8/0x3d0 net/rds/ib_cm.c:944
 rds_rdma_cm_event_handler_cmn+0x61f/0x8c0 net/rds/rdma_transport.c:109
 cma_cm_event_handler+0x94/0x300 drivers/infiniband/core/cma.c:2184
 cma_work_handler+0x15b/0x230 drivers/infiniband/core/cma.c:3042
 process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
 kthread+0x3c2/0x780 kernel/kthread.c:464
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
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

