Return-Path: <linux-rdma+bounces-3350-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DE790F572
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2024 19:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5261E1F22C87
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2024 17:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6632A156997;
	Wed, 19 Jun 2024 17:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uyoX0gdT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8F8558B7;
	Wed, 19 Jun 2024 17:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718819287; cv=none; b=uqYj8hs/0uokf6Cdq6MvGhmmqlo2uItM62wcIPdNjOgdED3x29821A6kd/V1XyrqfkI7Vv5vg1AaNVKe89ibb2tgcqYaBla3EbZL6uCjTAeIai04wmtX96M9Fcck/wYKQlatwWvWokgCC5aSuNCQpwoAn5MEAHkhEZkwiRVNKpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718819287; c=relaxed/simple;
	bh=/5Qv+AEeszorG0L47DcO/FGyk0LMfrafP15mmT3/QD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i8kTDKIny/Xo3PnYgCaxKTPSE4yiWGUAPR2sFu8hmB7TOilYvJc8/o/E8qNWDM+RvrEu9LnIiPfJUDW9XOZbYGfln26CFVgAzbrIAT4/zduo459n44nMrwAkK/vcv9qF8bQrv4FvGVZP1v0cSuj3Sik65zSeaZUpncU3QDHAdhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uyoX0gdT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D9F8C4AF08;
	Wed, 19 Jun 2024 17:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718819286;
	bh=/5Qv+AEeszorG0L47DcO/FGyk0LMfrafP15mmT3/QD8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uyoX0gdTshdKUUryRN9V/Gk0B1r8fR06Qau0XrUDXYLTifCHcPl/CKy3zObVFhKub
	 X8qMhaV+YFsvWfJn7KiSWNXXmr382JQBIQGYjUqZ4YgC5j4o35Hw7D+uzMnz9E8srT
	 JMddXhMc6hMMrSuEVXg2kNZ3YZjwYW77WBntKSqZjgepbI42OZ2AgyiQI0Kys4BEPx
	 HUmR01fbaOzqXvYRLNzky7mc7BfrglyPDpksAv/ZfcMog2QEJSaVvGDzBvJodw7/Nx
	 ympY5t9NE12m53OwPBr3o1Lwo1ytwovdlyE44kdIBlLN6Eh0RLKH4m+ZkfkaV5cg5Q
	 dsHBHgs67Ym8A==
Date: Wed, 19 Jun 2024 20:48:02 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: syzbot <syzbot+19ec7595e3aa1a45f623@syzkaller.appspotmail.com>,
	jgg@ziepe.ca, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [rdma?] WARNING in ib_uverbs_release_dev
Message-ID: <20240619174802.GP4025@unreal>
References: <000000000000057e4c061b386e23@google.com>
 <20240619091557.GM4025@unreal>
 <94d36dd5-313b-46b3-8d43-95016175d273@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <94d36dd5-313b-46b3-8d43-95016175d273@linux.dev>

On Wed, Jun 19, 2024 at 10:16:20PM +0800, Zhu Yanjun wrote:
> 在 2024/6/19 17:15, Leon Romanovsky 写道:
> > On Tue, Jun 18, 2024 at 11:37:18PM -0700, syzbot wrote:
> > > Hello,
> > > 
> > > syzbot found the following issue on:
> > > 
> > > HEAD commit:    2ccbdf43d5e7 Merge tag 'for-linus' of git://git.kernel.org..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=179e93fe980000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=fa0ce06dcc735711
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=19ec7595e3aa1a45f623
> > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > > 
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > > 
> > > Downloadable assets:
> > > disk image: https://storage.googleapis.com/syzbot-assets/27e64d7472ce/disk-2ccbdf43.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/e1c494bb5c9c/vmlinux-2ccbdf43.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/752498985a5e/bzImage-2ccbdf43.xz
> > > 
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+19ec7595e3aa1a45f623@syzkaller.appspotmail.com
> > > 
> > > smc: removing ib device syz0
> > > ------------[ cut here ]------------
> > > WARNING: CPU: 0 PID: 51 at kernel/rcu/srcutree.c:653 cleanup_srcu_struct+0x404/0x4d0 kernel/rcu/srcutree.c:653
> > > Modules linked in:
> > > CPU: 0 PID: 51 Comm: kworker/u8:3 Not tainted 6.10.0-rc3-syzkaller-00044-g2ccbdf43d5e7 #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
> > > Workqueue: ib-unreg-wq ib_unregister_work
> > > RIP: 0010:cleanup_srcu_struct+0x404/0x4d0 kernel/rcu/srcutree.c:653
> > > Code: 12 80 00 48 c7 03 00 00 00 00 48 83 c4 48 5b 41 5c 41 5d 41 5e 41 5f 5d e9 14 67 34 0a 90 0f 0b 90 eb e7 90 0f 0b 90 eb e1 90 <0f> 0b 90 eb db 90 0f 0b 90 eb 0a 90 0f 0b 90 eb 04 90 0f 0b 90 48
> > > RSP: 0018:ffffc90000bb7970 EFLAGS: 00010202
> > > RAX: 0000000000000001 RBX: ffff88802a1bc980 RCX: 0000000000000002
> > > RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffe8ffffd74c58
> > > RBP: 0000000000000001 R08: ffffe8ffffd74c5f R09: 1ffffd1ffffae98b
> > > R10: dffffc0000000000 R11: fffff91ffffae98c R12: dffffc0000000000
> > > R13: ffff88802285b5f0 R14: ffff88802285b000 R15: ffff88802a1bc800
> > > FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: 00007fa3852cae10 CR3: 000000000e132000 CR4: 0000000000350ef0
> > > Call Trace:
> > >   <TASK>
> > >   ib_uverbs_release_dev+0x4e/0x80 drivers/infiniband/core/uverbs_main.c:136
> > >   device_release+0x9b/0x1c0
> > >   kobject_cleanup lib/kobject.c:689 [inline]
> > >   kobject_release lib/kobject.c:720 [inline]
> > >   kref_put include/linux/kref.h:65 [inline]
> > >   kobject_put+0x231/0x480 lib/kobject.c:737
> > >   remove_client_context+0xb9/0x1e0 drivers/infiniband/core/device.c:776
> > >   disable_device+0x13b/0x360 drivers/infiniband/core/device.c:1282
> > >   __ib_unregister_device+0x6d/0x170 drivers/infiniband/core/device.c:1475
> > >   ib_unregister_work+0x19/0x30 drivers/infiniband/core/device.c:1586
> > >   process_one_work kernel/workqueue.c:3231 [inline]
> > >   process_scheduled_works+0xa2e/0x1830 kernel/workqueue.c:3312
> > >   worker_thread+0x86d/0xd70 kernel/workqueue.c:3393
> > >   kthread+0x2f2/0x390 kernel/kthread.c:389
> > >   ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
> > >   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> > >   </TASK>
> > 
> > I see that this is caused by call to ib_unregister_device_queued() as a
> > response to NETDEV_UNREGISTER event, but we don't flush anything before.
> > How can we be sure that ib_device is not used anymore?
> 
> Hi, Leon
> 
> This is the console output:
> 
> https://syzkaller.appspot.com/x/log.txt?x=179e93fe980000
> 
> From the above link, it seems that other devices or subsystems failed
> firstly, then caused this call trace to appear. When other problem occurred,
> the whole kernel system was in mess state.So it is not weird that some
> problems occurred.

Which devices/subsystems failed? I grepped the log and don't see
anything suspicious, before first "------------[ cut here ]------------"
sentence.

> 
> To be simple, the root cause is not in RDMA subsystem.
> 
> I will continue to delve into this problem.
> 
> Zhu Yanjun
> > 
> > Thanks
> 

