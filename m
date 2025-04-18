Return-Path: <linux-rdma+bounces-9597-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34373A93D94
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Apr 2025 20:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C00019E8C41
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Apr 2025 18:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B207E2248BA;
	Fri, 18 Apr 2025 18:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qBPLsCr5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B91224240
	for <linux-rdma@vger.kernel.org>; Fri, 18 Apr 2025 18:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745001887; cv=none; b=t3gyH+2tIiJia/p02Old9cvqogFy35UAaJKquGDCOLJnyDUd4mIVbXXCUe4Bi98h365ZI8iGYi2YNgjzveacSdF1GDFf4gSupXTTje/QZTx4Keurx0yZipDPQWDiIK7QQ/NvLJXWD5P8XD7qlwtXakxd4SNq7WRlTiRA3+9so3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745001887; c=relaxed/simple;
	bh=A37SRNBh1snDmbZr+v/J41GcTBJOHQzqEBViK5exvn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tAEov1cE38KMl9+uAl82zZauT/4XeLJ2piIzKb+SYOekTHTdJP6XQuu6/IYZruBfexRXMcsEN+kY/MSafOCjFbS6ldayZGT+NJmp1mCGl6HC0oEGZuxVVi/DDlZi5mQ+C+HeAM7GE/FimQunBpputg228nafryGDoXeE6zqLm7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qBPLsCr5; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <78ff9e8a-5deb-428d-83ed-ffc7c7e4166f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745001870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3xonVTSIdvXEEvVrxgU3pVjhN9jiUTT/4w0LBQhg7kw=;
	b=qBPLsCr59vK0sdAztx/MrfGUXpi0LqSVuMUnEl9C3zEJe7S1PtypMv998G5H1/8M3cKlLl
	YvFac77v+aD6ClqQdOdXi4Z25b4qPyUmOXldA/u0dRHCTwChB/ry3t+cy+ABWT7X+V+gmb
	DrcvSOUTVjTukEmKGJYeq+UGBezGAIo=
Date: Fri, 18 Apr 2025 20:43:44 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [syzbot] [rdma?] INFO: trying to register non-static key in
 rxe_qp_do_cleanup
To: syzbot <syzbot+4edb496c3cad6e953a31@syzkaller.appspotmail.com>,
 jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 zyjzyj2000@gmail.com
References: <680240b5.050a0220.297747.0007.GAE@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <680240b5.050a0220.297747.0007.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/4/18 14:08, syzbot 写道:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    8ffd015db85f Linux 6.15-rc2
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=16bc20cc580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=51ecb841db3b3687
> dashboard link: https://syzkaller.appspot.com/bug?extid=4edb496c3cad6e953a31
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/7aa92e6fb2e5/disk-8ffd015d.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/1458d069253c/vmlinux-8ffd015d.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/fe6dd8111695/bzImage-8ffd015d.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+4edb496c3cad6e953a31@syzkaller.appspotmail.com
> 
> INFO: trying to register non-static key.
> The code is fine but needs lockdep annotation, or maybe
> you didn't initialize this object before use?
> turning off the locking correctness validator.
> CPU: 1 UID: 0 PID: 1151 Comm: kworker/u8:8 Not tainted 6.15.0-rc2-syzkaller #0 PREEMPT(full)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
> Workqueue: rdma_cm cma_work_handler
> Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:94 [inline]
>   dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
>   assign_lock_key kernel/locking/lockdep.c:986 [inline]
>   register_lock_class+0x4a3/0x4c0 kernel/locking/lockdep.c:1300
>   __lock_acquire+0x99/0x1ba0 kernel/locking/lockdep.c:5110
>   lock_acquire kernel/locking/lockdep.c:5866 [inline]
>   lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5823
>   __timer_delete_sync+0x152/0x1b0 kernel/time/timer.c:1644
>   rxe_qp_do_cleanup+0x5c3/0x7e0 drivers/infiniband/sw/rxe/rxe_qp.c:815>   execute_in_process_context+0x3a/0x160 kernel/workqueue.c:4596
>   __rxe_cleanup+0x267/0x3c0 drivers/infiniband/sw/rxe/rxe_pool.c:232
>   rxe_create_qp+0x3f7/0x5f0 drivers/infiniband/sw/rxe/rxe_verbs.c:604

In the function rxe_create_qp, the function rxe_qp_from_init is called 
to create qp, if this function rxe_qp_from_init fails, rxe_cleanup will 
be called to handle all the allocated resources, including the timers: 
retrans_timer and rnr_nak_timer.

The function rxe_qp_from_init calls the function rxe_qp_init_req to 
initialize the timers: retrans_timer and rnr_nak_timer.

But these timers are initialized in the end of rxe_qp_init_req. If some 
errors occur before the initialization of these timers, this problem 
will occur.

235 static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
236                            struct ib_qp_init_attr *init, struct 
ib_udata *udata,
237                            struct rxe_create_qp_resp __user *uresp)
238 {
..
244         err = sock_create_kern(&init_net, AF_INET, SOCK_DGRAM, 0, 
&qp->sk);
245         if (err < 0)
246                 return err;   < --- this will cause this problem
..
258         err = rxe_init_sq(qp, init, udata, uresp);
259         if (err)
260                 return err; < --- this will cause this problem
261
...
271         if (init->qp_type == IB_QPT_RC) {
272                 timer_setup(&qp->rnr_nak_timer, rnr_nak_timer, 0);
273                 timer_setup(&qp->retrans_timer, retransmit_timer, 0);
274         }
275         return 0;
276 }

Please comment on the above.

Zhu Yanjun


>   create_qp+0x62d/0xa80 drivers/infiniband/core/verbs.c:1250
>   ib_create_qp_kernel+0x9f/0x310 drivers/infiniband/core/verbs.c:1361
>   ib_create_qp include/rdma/ib_verbs.h:3803 [inline]
>   rdma_create_qp+0x10c/0x340 drivers/infiniband/core/cma.c:1144
>   rds_ib_setup_qp+0xc86/0x19a0 net/rds/ib_cm.c:600
>   rds_ib_cm_initiate_connect+0x1e8/0x3d0 net/rds/ib_cm.c:944
>   rds_rdma_cm_event_handler_cmn+0x61f/0x8c0 net/rds/rdma_transport.c:109
>   cma_cm_event_handler+0x94/0x300 drivers/infiniband/core/cma.c:2184
>   cma_work_handler+0x15b/0x230 drivers/infiniband/core/cma.c:3042
>   process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3238
>   process_scheduled_works kernel/workqueue.c:3319 [inline]
>   worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
>   kthread+0x3c2/0x780 kernel/kthread.c:464
>   ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:153
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>   </TASK>
> ------------[ cut here ]------------
> ODEBUG: assert_init not available (active state 0) object: ffff8880541d8a58 object type: timer_list hint: 0x0
> WARNING: CPU: 1 PID: 1151 at lib/debugobjects.c:612 debug_print_object+0x1a2/0x2b0 lib/debugobjects.c:612
> Modules linked in:
> CPU: 1 UID: 0 PID: 1151 Comm: kworker/u8:8 Not tainted 6.15.0-rc2-syzkaller #0 PREEMPT(full)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
> Workqueue: rdma_cm cma_work_handler
> RIP: 0010:debug_print_object+0x1a2/0x2b0 lib/debugobjects.c:612
> Code: fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 75 54 41 56 48 8b 14 dd e0 73 f4 8b 4c 89 e6 48 c7 c7 60 68 f4 8b e8 1f db a5 fc 90 <0f> 0b 90 90 58 83 05 76 9b b1 0b 01 48 83 c4 18 5b 5d 41 5c 41 5d
> RSP: 0018:ffffc90003eb73e8 EFLAGS: 00010282
> RAX: 0000000000000000 RBX: 0000000000000005 RCX: ffffffff817acff8
> RDX: ffff888027be8000 RSI: ffffffff817ad005 RDI: 0000000000000001
> RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000001 R11: 0000000000000001 R12: ffffffff8bf46f40
> R13: ffffffff8b8fc880 R14: 0000000000000000 R15: ffffc90003eb74a8
> FS:  0000000000000000(0000) GS:ffff888124ab2000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000110c32628d CR3: 000000000e182000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   <TASK>
>   debug_object_assert_init+0x1ec/0x2f0 lib/debugobjects.c:1020
>   debug_timer_assert_init kernel/time/timer.c:845 [inline]
>   debug_assert_init kernel/time/timer.c:890 [inline]
>   __try_to_del_timer_sync+0x7f/0x170 kernel/time/timer.c:1499
>   __timer_delete_sync+0xf4/0x1b0 kernel/time/timer.c:1662
>   rxe_qp_do_cleanup+0x5c3/0x7e0 drivers/infiniband/sw/rxe/rxe_qp.c:815
>   execute_in_process_context+0x3a/0x160 kernel/workqueue.c:4596
>   __rxe_cleanup+0x267/0x3c0 drivers/infiniband/sw/rxe/rxe_pool.c:232
>   rxe_create_qp+0x3f7/0x5f0 drivers/infiniband/sw/rxe/rxe_verbs.c:604
>   create_qp+0x62d/0xa80 drivers/infiniband/core/verbs.c:1250
>   ib_create_qp_kernel+0x9f/0x310 drivers/infiniband/core/verbs.c:1361
>   ib_create_qp include/rdma/ib_verbs.h:3803 [inline]
>   rdma_create_qp+0x10c/0x340 drivers/infiniband/core/cma.c:1144
>   rds_ib_setup_qp+0xc86/0x19a0 net/rds/ib_cm.c:600
>   rds_ib_cm_initiate_connect+0x1e8/0x3d0 net/rds/ib_cm.c:944
>   rds_rdma_cm_event_handler_cmn+0x61f/0x8c0 net/rds/rdma_transport.c:109
>   cma_cm_event_handler+0x94/0x300 drivers/infiniband/core/cma.c:2184
>   cma_work_handler+0x15b/0x230 drivers/infiniband/core/cma.c:3042
>   process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3238
>   process_scheduled_works kernel/workqueue.c:3319 [inline]
>   worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
>   kthread+0x3c2/0x780 kernel/kthread.c:464
>   ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:153
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>   </TASK>
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup


