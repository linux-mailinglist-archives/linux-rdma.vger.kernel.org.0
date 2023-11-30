Return-Path: <linux-rdma+bounces-160-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 866767FEA57
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Nov 2023 09:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3665F28215B
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Nov 2023 08:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9B42231A;
	Thu, 30 Nov 2023 08:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lrLEGxD6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8A31AD;
	Thu, 30 Nov 2023 00:19:39 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-285c3512f37so711303a91.3;
        Thu, 30 Nov 2023 00:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701332379; x=1701937179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X6OyCWwArho/FQSjOaPN8QBeFYZ6JMiey5O4KrBMrWo=;
        b=lrLEGxD67re0xfGNBv4qYjMiAPBhv8ucEQemGb6dlSJTE7+Fm17zmi0Ga/5sMyIHvB
         v6kf0bM1L+Ggo2vq6Nw+kpBaHzxP6t8EYpGwMbyl/i4Pgsgx6nup1gAJ5mI6AZY/ipmR
         1yflm1Y5XAhtpiiA/qme77h/+jxQyg9eYUdYK9qENQqY4QPbPRukrS8XVDDTcyLnMo97
         rlXEoIChvCmxPFc9D0w2e2Zvk2Cy7eF6NNJijmcFmcL9SazKimyOmpyHyjKe+aHvL8WO
         ikssaLmnbr+rgzOH7aOBp3OjgfkY0r5V9oW/TezV038yxUfBk16+ADjtPIvpDMMRbJen
         w8ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701332379; x=1701937179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X6OyCWwArho/FQSjOaPN8QBeFYZ6JMiey5O4KrBMrWo=;
        b=HhivZEGwgKT83PwW9QbsiA6dHiN5sriJZzihB1CiKun8Vo07PnupnZpYg0VbxyG+C9
         vBypgWT48ubz629qDf4IwHF+ob6pRWKm7MqMaBrZvvAsh1hiKHY9fqgj8paUo6rK+NEG
         MzzTuiSa70ZFgt6hElgv3fx6KlXCsl/PnwmoaHr/ZU9i0Pb6wIde2P4z4vsvoAPUoIJA
         tG5OX/FPvJCg42EqGjKLe7CJLvRq8llR0nmiOKRukEWKPF0MRZ6TH042M/UWsQKfOkKL
         biE+nTKRHZdiVtYPhyZpe8N7g1rUwM8T6OoFfdowtuB7PQMKiPcgGSReYpFzyNL0iRr9
         ALmQ==
X-Gm-Message-State: AOJu0YyKTjA69rD3zR4UItmT3bK1dx09ug63352djIjfZUJNwVmNrfYI
	JoJ+HZalC4uuHlhKpElz+139OzqzXewU25jesb8c6lO90yfJhQ==
X-Google-Smtp-Source: AGHT+IFIu3C4BfI0cJoeIla2zG8EU5z7irpXTxJVCgoJPGpJEACUvZXTnVBxPpp1QJAFqKBjGTnAvn6QMJB1SJ05Z0g=
X-Received: by 2002:a17:90b:4aca:b0:285:a179:7177 with SMTP id
 mh10-20020a17090b4aca00b00285a1797177mr18638384pjb.44.1701332378662; Thu, 30
 Nov 2023 00:19:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: xingwei lee <xrivendell7@gmail.com>
Date: Thu, 30 Nov 2023 16:19:27 +0800
Message-ID: <CABOYnLwSO7zLH+KVwTUJnV2_Hk+u+5+g8DPanTfLeEg05tFEQQ@mail.gmail.com>
Subject: WARNING in cleanup_net
To: linux-kernel@vger.kernel.org
Cc: santosh.shilimkar@oracle.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, 
	syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi
I found a bug with syzkaller titled "WARNING in cleanup_net" in the
last upstream.
=3D* BUG DETAILS =3D*
kernel commit: 3b47bc037bd44f142ac09848e8d3ecccc726be99
kernel config: https://syzkaller.appspot.com/text?tag=3DKernelConfig&x=3Df2=
a9d08825f82ef3
repro.c/repro.txt:
https://gist.github.com/xrivendell7/44780af4a9dededc5ff7a7c0583ce3f1
the crash report=EF=BC=9A
[ 8584.181281][T11719] bond0 (unregistering): Released all slaves
[ 8585.839049][T11719] ref_tracker: net notrefcnt@ffff888021ba0220 has
1/1 users at
[ 8585.839049][T11719]   sk_alloc+0xaf0/0xbf0
[ 8585.839049][T11719]   inet6_create+0x39b/0x1300
[ 8585.839049][T11719]   __sock_create+0x34f/0x850
[ 8585.839049][T11719]   rds_tcp_listen_init+0xda/0x4f0
[ 8585.839049][T11719]   rds_tcp_init_net+0x147/0x400
[ 8585.839049][T11719]   ops_init+0xc4/0x680
[ 8585.839049][T11719]   setup_net+0x431/0xa80
[ 8585.839049][T11719]   copy_net_ns+0x313/0x6b0
[ 8585.839049][T11719]   create_new_namespaces+0x3fb/0xb60
[ 8585.839049][T11719]   unshare_nsproxy_namespaces+0xd0/0x200
[ 8585.839049][T11719]   ksys_unshare+0x47c/0xa30
[ 8585.839049][T11719]   __x64_sys_unshare+0x36/0x50
[ 8585.839049][T11719]   do_syscall_64+0x40/0x110
[ 8585.839049][T11719]   entry_SYSCALL_64_after_hwframe+0x63/0x6b
[ 8585.839049][T11719]
[ 8585.858614][T11719] ------------[ cut here ]------------
[ 8585.860037][T11719] WARNING: CPU: 3 PID: 11719 at
lib/ref_tracker.c:179 ref_tracker_dir_exit+0x3fa/0x6a0
[ 8585.862152][T11719] Modules linked in:
[ 8585.863038][T11719] CPU: 3 PID: 11719 Comm: kworker/u8:3 Not
tainted 6.7.0-rc1-g7475e51b8796-dirty #2
[ 8585.865268][T11719] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS 1.16.2-1.fc38 04/01/2014
[ 8585.867345][T11719] Workqueue: netns cleanup_net
[ 8585.868401][T11719] RIP: 0010:ref_tracker_dir_exit+0x3fa/0x6a0
[ 8585.869426][T11719] Code: 00 00 4d 39 f5 49 8b 06 4d 89 f7 0f 85 08
ff ff ff 48 8b 2c 24 31 ff e8 c4 09 d6 fc 48 8b 74 24 18 48 89 ef e8
67 13 32 06 90 <0f> 0b 90 48 8d 5d 44 31 ff e8 a8 09 d6 fc be 04 00 00
00 48 89 df
[ 8585.872786][T11719] RSP: 0018:ffffc9000386fb78 EFLAGS: 00010286
[ 8585.873790][T11719] RAX: 0000000080000000 RBX: dffffc0000000000
RCX: 0000000000000000
[ 8585.875085][T11719] RDX: 0000000000000001 RSI: ffffffff8b2cb900
RDI: 0000000000000001
[ 8585.876394][T11719] RBP: ffff888021ba0220 R08: 0000000000000001
R09: fffffbfff24a13e9
[ 8585.877808][T11719] R10: ffffffff92509f4f R11: 0000000000000003
R12: ffff888021ba0270
[ 8585.879138][T11719] R13: ffff888021ba0270 R14: ffff888021ba0270
R15: ffff888021ba0270
[ 8585.880481][T11719] FS: 0000000000000000(0000)
GS:ffff88823bd00000(0000) knlGS:0000000000000000
[ 8585.881965][T11719] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 8585.882719][T11719] CR2: 00007f00c5cd79f0 CR3: 000000000d377000
CR4: 0000000000750ef0
[ 8585.883536][T11719] PKRU: 55555554
[ 8585.883901][T11719] Call Trace:
[ 8585.884247][T11719] <TASK>
[ 8585.884561][T11719] ? show_regs+0x9a/0xb0
[ 8585.885005][T11719] ? __warn+0xf5/0x3c0
[ 8585.885423][T11719] ? report_bug+0x506/0x5f0
[ 8585.885900][T11719] ? ref_tracker_dir_exit+0x3fa/0x6a0
[ 8585.886466][T11719] ? report_bug+0x41c/0x5f0
[ 8585.886939][T11719] ? handle_bug+0x3d/0x70
[ 8585.887609][T11719] ? exc_invalid_op+0x17/0x40
[ 8585.888104][T11719] ? asm_exc_invalid_op+0x1a/0x20
[ 8585.888646][T11719] ? ref_tracker_dir_exit+0x3fa/0x6a0
[ 8585.889203][T11719] ? ref_tracker_dir_exit+0x3f9/0x6a0
[ 8585.889900][T11719] ? ref_tracker_dir_snprint+0xe0/0xe0
[ 8585.890465][T11719] ? __kmem_cache_free+0xc0/0x180
[ 8585.890989][T11719] cleanup_net+0x927/0xb70
[ 8585.891462][T11719] ? unregister_pernet_device+0x80/0x80
[ 8585.892038][T11719] process_one_work+0x8ab/0x1730
[ 8585.892564][T11719] ? unregister_pernet_device+0x80/0x80
[ 8585.893137][T11719] ? workqueue_congested+0x320/0x320
[ 8585.893692][T11719] ? assign_work+0x1b7/0x260
[ 8585.894177][T11719] worker_thread+0x931/0x1380
[ 8585.894683][T11719] ? process_one_work+0x1730/0x1730
[ 8585.895224][T11719] kthread+0x2d3/0x3b0
[ 8585.895664][T11719] ? _raw_spin_unlock_irq+0x23/0x50
[ 8585.896191][T11719] ? kthread_complete_and_exit+0x40/0x40
[ 8585.896779][T11719] ret_from_fork+0x4e/0x80
[ 8585.897245][T11719] ? kthread_complete_and_exit+0x40/0x40
[ 8585.897863][T11719] ret_from_fork_asm+0x11/0x20
[ 8585.898371][T11719] </TASK>
[ 8585.898702][T11719] Kernel panic - not syncing: kernel: panic_on_warn se=
t ...
[ 8585.899428][T11719] CPU: 3 PID: 11719 Comm: kworker/u8:3 Not
tainted 6.7.0-rc1-g7475e51b8796-dirty #2
[ 8585.900572][T11719] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS 1.16.2-1.fc38 04/01/2014
[ 8585.901550][T11719] Workqueue: netns cleanup_net
[ 8585.902038][T11719] Call Trace:
[ 8585.902377][T11719] <TASK>
[ 8585.902693][T11719] dump_stack_lvl+0xee/0x1e0
[ 8585.903170][T11719] panic+0x754/0x810
[ 8585.903805][T11719] ? panic_smp_self_stop+0xa0/0xa0
[ 8585.904377][T11719] ? show_trace_log_lvl+0x394/0x540
[ 8585.905159][T11719] ? check_panic_on_warn+0xa4/0xc0
[ 8585.905742][T11719] ? ref_tracker_dir_exit+0x3fa/0x6a0
[ 8585.906532][T11719] check_panic_on_warn+0xb8/0xc0
[ 8585.907108][T11719] __warn+0x101/0x3c0
[ 8585.907577][T11719] ? report_bug+0x506/0x5f0
[ 8585.908317][T11719] ? ref_tracker_dir_exit+0x3fa/0x6a0
[ 8585.909080][T11719] report_bug+0x41c/0x5f0
[ 8585.909599][T11719] handle_bug+0x3d/0x70
[ 8585.910089][T11719] exc_invalid_op+0x17/0x40
[ 8585.910571][T11719] asm_exc_invalid_op+0x1a/0x20
[ 8585.911115][T11719] RIP: 0010:ref_tracker_dir_exit+0x3fa/0x6a0
[ 8585.911798][T11719] Code: 00 00 4d 39 f5 49 8b 06 4d 89 f7 0f 85 08
ff ff ff 48 8b 2c 24 31 ff e8 c4 09 d6 fc 48 8b 74 24 18 48 89 ef e8
67 13 32 06 90 <0f> 0b 90 48 8d 5d 44 31 ff e8 a8 09 d6 fc be 04 00 00
00 48 89 df
[ 8585.914135][T11719] RSP: 0018:ffffc9000386fb78 EFLAGS: 00010286
[ 8585.914813][T11719] RAX: 0000000080000000 RBX: dffffc0000000000
RCX: 0000000000000000
[ 8585.915654][T11719] RDX: 0000000000000001 RSI: ffffffff8b2cb900
RDI: 0000000000000001
[ 8585.916556][T11719] RBP: ffff888021ba0220 R08: 0000000000000001
R09: fffffbfff24a13e9
[ 8585.917647][T11719] R10: ffffffff92509f4f R11: 0000000000000003
R12: ffff888021ba0270
[ 8585.918692][T11719] R13: ffff888021ba0270 R14: ffff888021ba0270
R15: ffff888021ba0270
[ 8585.919598][T11719] ? ref_tracker_dir_exit+0x3f9/0x6a0
[ 8585.920188][T11719] ? ref_tracker_dir_snprint+0xe0/0xe0
[ 8585.920803][T11719] ? __kmem_cache_free+0xc0/0x180
[ 8585.921387][T11719] cleanup_net+0x927/0xb70
[ 8585.921891][T11719] ? unregister_pernet_device+0x80/0x80
[ 8585.922481][T11719] process_one_work+0x8ab/0x1730
[ 8585.923093][T11719] ? unregister_pernet_device+0x80/0x80
[ 8585.923781][T11719] ? workqueue_congested+0x320/0x320
[ 8585.924385][T11719] ? assign_work+0x1b7/0x260
[ 8585.924923][T11719] worker_thread+0x931/0x1380
[ 8585.925467][T11719] ? process_one_work+0x1730/0x1730
[ 8585.926079][T11719] kthread+0x2d3/0x3b0
[ 8585.926538][T11719] ? _raw_spin_unlock_irq+0x23/0x50
[ 8585.927138][T11719] ? kthread_complete_and_exit+0x40/0x40
[ 8585.927763][T11719] ret_from_fork+0x4e/0x80
[ 8585.928256][T11719] ? kthread_complete_and_exit+0x40/0x40
[ 8585.928903][T11719] ret_from_fork_asm+0x11/0x20
[ 8585.929470][T11719] </TASK>
[ 8585.930023][T11719] Kernel Offset: disabled
[ 8585.930517][T11719] Rebooting in 86400 seconds..
=3D* OTHERS =3D*
I noticed syzbot has two similar bugs named WARNING in cleanup_net=EF=BC=9A
https://syzkaller.appspot.com/bug?extid=3D7e1e1bdb852961150198
https://syzkaller.appspot.com/bug?id=3D14c45b4081250ebeb4a9000f3774da829f7e=
43b4

However, these two seem fixed and not related to this.
Without in-depth analysis, I guess it's maybe a race condition bug and
the import part may be the refcnt_tracker in socket$rds not handled
properly but I'm not sure.

[ 8585.839049][T11719] ref_tracker: net notrefcnt@ffff888021ba0220 has
1/1 users at
[ 8585.839049][T11719]   sk_alloc+0xaf0/0xbf0
[ 8585.839049][T11719]   inet6_create+0x39b/0x1300
[ 8585.839049][T11719]   __sock_create+0x34f/0x850
[ 8585.839049][T11719]   rds_tcp_listen_init+0xda/0x4f0
[ 8585.839049][T11719]   rds_tcp_init_net+0x147/0x400
[ 8585.839049][T11719]   ops_init+0xc4/0x680
[ 8585.839049][T11719]   setup_net+0x431/0xa80
[ 8585.839049][T11719]   copy_net_ns+0x313/0x6b0
[ 8585.839049][T11719]   create_new_namespaces+0x3fb/0xb60
[ 8585.839049][T11719]   unshare_nsproxy_namespaces+0xd0/0x200
[ 8585.839049][T11719]   ksys_unshare+0x47c/0xa30
[ 8585.839049][T11719]   __x64_sys_unshare+0x36/0x50
[ 8585.839049][T11719]   do_syscall_64+0x40/0x110
[ 8585.839049][T11719]   entry_SYSCALL_64_after_hwframe+0x63/0x6b

