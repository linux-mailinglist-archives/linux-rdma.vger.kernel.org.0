Return-Path: <linux-rdma+bounces-13427-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6B3B59D52
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Sep 2025 18:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 154B43AC0F1
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Sep 2025 16:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A0928489E;
	Tue, 16 Sep 2025 16:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mwv+33IG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1A827B325
	for <linux-rdma@vger.kernel.org>; Tue, 16 Sep 2025 16:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758039315; cv=none; b=gk6bHvXKGR4t/B2999gNE7mqlInrwI3epWp95O7IZESdG11mIamC7eOTQ1KtWymbEowb8LenAILyeKxsY2xeBBnH9V1BXQ0I1cStAFmL031/rTKb5k3OafGd2lh63ygnOXdXQ3bBebVQZJJadcek84MCZN+v6/J+yTCkJRAEUtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758039315; c=relaxed/simple;
	bh=Fau07E6HejNdul8Szkqjw5bZVaz1B/kG8LVY6o+QQXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BDTp7rNj/kIojgcZAtTv7MEg3Mm1aKCfzPD39BvaOwx0ZjsYBJpyqfyBFKwyCnPfLD89xAR2bXJg14j25xlGG8ZTUEV5KnsYKmkT/6tgfcyw5X7ztSJDbZSGgLJZVBbr3E9pLd6jgK8r/7gXPve9Fwm2m2nCvxziQAyGD1SPv0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mwv+33IG; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <92171eea-e7ff-4cf3-a923-a4efabe6dec5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758039310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6KBC+nK2RkCVHyAeUAqIGl3Ld5/CTaXGUV+afM+Gk2Q=;
	b=mwv+33IGWF3UtH3Ox7yDBt52Th4X3q2lOv1rKUQtPNXdB3h004TYtPSCukr9bbo8jCCnJ/
	nTal+zQASg9EIoGny57dGANLfSFEb4W2fXHbsE9g9zhSBbQ5kqnACQGcjwwtLtRU8TwNuG
	PjPL0lH032Se/Ysti0VNgWgenMLsbFA=
Date: Tue, 16 Sep 2025 09:15:06 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [syzbot] [rdma?] WARNING in gid_table_release_one (3)
To: syzbot <syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com>,
 edwards@nvidia.com, jgg@ziepe.ca, leon@kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <68c2ec01.050a0220.3c6139.003f.GAE@google.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "yanjun.zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <68c2ec01.050a0220.3c6139.003f.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/11/25 8:34 AM, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    5f540c4aade9 Add linux-next specific files for 20250910
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=157dab12580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5ed48faa2cb8510d
> dashboard link: https://syzkaller.appspot.com/bug?extid=b0da83a6c0e2e2bddbd4
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15b52362580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16b41642580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/df0dfb072f52/disk-5f540c4a.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/20649042ae30/vmlinux-5f540c4a.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/4c16358268b8/bzImage-5f540c4a.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com

This problem is fixed by a fix in https://github.com/zhuyj/linux.git 
v6.17_fix_gid_table_release_one

I will make an official patch and send it out very soon.

Zhu Yanjun

> 
> ------------[ cut here ]------------
> GID entry ref leak for dev syz1 index 2 ref=615
> WARNING: drivers/infiniband/core/cache.c:809 at release_gid_table drivers/infiniband/core/cache.c:806 [inline], CPU#0: kworker/u8:2/36
> WARNING: drivers/infiniband/core/cache.c:809 at gid_table_release_one+0x346/0x4d0 drivers/infiniband/core/cache.c:886, CPU#0: kworker/u8:2/36
> Modules linked in:
> CPU: 0 UID: 0 PID: 36 Comm: kworker/u8:2 Not tainted syzkaller #0 PREEMPT(full)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
> Workqueue: ib-unreg-wq ib_unregister_work
> RIP: 0010:release_gid_table drivers/infiniband/core/cache.c:806 [inline]
> RIP: 0010:gid_table_release_one+0x346/0x4d0 drivers/infiniband/core/cache.c:886
> Code: e8 03 48 b9 00 00 00 00 00 fc ff df 0f b6 04 08 84 c0 75 3d 41 8b 0e 48 c7 c7 a0 43 91 8c 4c 89 e6 44 89 fa e8 fb 67 f5 f8 90 <0f> 0b 90 90 e9 e3 fe ff ff 44 89 e9 80 e1 07 80 c1 03 38 c1 0f 8c
> RSP: 0018:ffffc90000ac7908 EFLAGS: 00010246
> RAX: 621d731dcb27e200 RBX: ffff88806241b8d8 RCX: ffff888141289e40
> RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000002
> RBP: 1ffff1100c48371b R08: ffff8880b8724253 R09: 1ffff110170e484a
> R10: dffffc0000000000 R11: ffffed10170e484b R12: ffff888027503e00
> R13: ffff88806241b800 R14: ffff8880289a2400 R15: 0000000000000002
> FS:  0000000000000000(0000) GS:ffff8881259f0000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000555569847588 CR3: 00000000338c8000 CR4: 00000000003526f0
> Call Trace:
>   <TASK>
>   ib_device_release+0xd2/0x1c0 drivers/infiniband/core/device.c:509
>   device_release+0x99/0x1c0 drivers/base/core.c:-1
>   kobject_cleanup lib/kobject.c:689 [inline]
>   kobject_release lib/kobject.c:720 [inline]
>   kref_put include/linux/kref.h:65 [inline]
>   kobject_put+0x228/0x480 lib/kobject.c:737
>   process_one_work kernel/workqueue.c:3263 [inline]
>   process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3346
>   worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
>   kthread+0x711/0x8a0 kernel/kthread.c:463
>   ret_from_fork+0x47c/0x820 arch/x86/kernel/process.c:158
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>   </TASK>
> 
> 
> ---
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.


