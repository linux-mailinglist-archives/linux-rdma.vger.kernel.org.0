Return-Path: <linux-rdma+bounces-3301-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A9F90E6A3
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2024 11:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E297E1F23742
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2024 09:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BE57F7C6;
	Wed, 19 Jun 2024 09:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pGZIrx7I"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F8F1869;
	Wed, 19 Jun 2024 09:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718788563; cv=none; b=ZMEZaDk4z4YKhVM8wLeuKRxUZ9ma/nqex4ko0KmIhcChSgirpz9JxxiFMFX+5dUAPePQhrs+DHLywWdKNja7ZsPt4mNNUF4TOUkwSAyu6PX1bVFGes8N/iK6QlZ151SH6oGkv9dURRnU+KMn1sm8HBhkd6E9vM/ZeTztnd2Ue+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718788563; c=relaxed/simple;
	bh=5rI/dFrzsUqaLUt8JrqSdOI5dNvwE7OblGdrys9bbbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r5T8wsr1sKpfCCYQCC8tpnOqiStwH+URWVJbK9yZCYVz7jwLPg/PknXrSqT0wKf4kOiOyj9IyoqlDSdI8acOG5PlE5eNK8WYCKGZIyiGgowaIR4BBZ+xNhoCJvsrG+veWnc2UhR//HE3t1cdv2ln1G/slSafknfSXdeZIDmK4GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pGZIrx7I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F312C32786;
	Wed, 19 Jun 2024 09:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718788562;
	bh=5rI/dFrzsUqaLUt8JrqSdOI5dNvwE7OblGdrys9bbbc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pGZIrx7IlbzyvOqcjXG9ki0emtFYuW4mgBOrYQTyANOxtv/1KFF9SxOXPhD+za3Mj
	 T1NWxO272unRBz+RVcb9stYD5qe9ewd+HM+j1VL/iZ+bQDWjUCrkIfRFdpclLkOV/5
	 Q5SmeSaqFDpMnOu02BJpHY3/QWYrMayLvd8c3mEIQ1qLLkqwxtigqz5xbJmMWsPouB
	 2nZ2xrsKmgIQZcXRi6ViK5nfpuzeCcOSYB2tg4Oo06FEET7xy5s+wyvSMErjWX0aB6
	 4M2IOdLj12FSz/8y3OqclbWXm3akf03yEXxriOeCYLVAqwSqPYnwU1AIwhSPPujTys
	 lzSLIMY9unQew==
Date: Wed, 19 Jun 2024 12:15:57 +0300
From: Leon Romanovsky <leon@kernel.org>
To: syzbot <syzbot+19ec7595e3aa1a45f623@syzkaller.appspotmail.com>,
	jgg@ziepe.ca
Cc: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [rdma?] WARNING in ib_uverbs_release_dev
Message-ID: <20240619091557.GM4025@unreal>
References: <000000000000057e4c061b386e23@google.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000057e4c061b386e23@google.com>

On Tue, Jun 18, 2024 at 11:37:18PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    2ccbdf43d5e7 Merge tag 'for-linus' of git://git.kernel.org..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=179e93fe980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=fa0ce06dcc735711
> dashboard link: https://syzkaller.appspot.com/bug?extid=19ec7595e3aa1a45f623
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/27e64d7472ce/disk-2ccbdf43.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/e1c494bb5c9c/vmlinux-2ccbdf43.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/752498985a5e/bzImage-2ccbdf43.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+19ec7595e3aa1a45f623@syzkaller.appspotmail.com
> 
> smc: removing ib device syz0
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 51 at kernel/rcu/srcutree.c:653 cleanup_srcu_struct+0x404/0x4d0 kernel/rcu/srcutree.c:653
> Modules linked in:
> CPU: 0 PID: 51 Comm: kworker/u8:3 Not tainted 6.10.0-rc3-syzkaller-00044-g2ccbdf43d5e7 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
> Workqueue: ib-unreg-wq ib_unregister_work
> RIP: 0010:cleanup_srcu_struct+0x404/0x4d0 kernel/rcu/srcutree.c:653
> Code: 12 80 00 48 c7 03 00 00 00 00 48 83 c4 48 5b 41 5c 41 5d 41 5e 41 5f 5d e9 14 67 34 0a 90 0f 0b 90 eb e7 90 0f 0b 90 eb e1 90 <0f> 0b 90 eb db 90 0f 0b 90 eb 0a 90 0f 0b 90 eb 04 90 0f 0b 90 48
> RSP: 0018:ffffc90000bb7970 EFLAGS: 00010202
> RAX: 0000000000000001 RBX: ffff88802a1bc980 RCX: 0000000000000002
> RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffe8ffffd74c58
> RBP: 0000000000000001 R08: ffffe8ffffd74c5f R09: 1ffffd1ffffae98b
> R10: dffffc0000000000 R11: fffff91ffffae98c R12: dffffc0000000000
> R13: ffff88802285b5f0 R14: ffff88802285b000 R15: ffff88802a1bc800
> FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fa3852cae10 CR3: 000000000e132000 CR4: 0000000000350ef0
> Call Trace:
>  <TASK>
>  ib_uverbs_release_dev+0x4e/0x80 drivers/infiniband/core/uverbs_main.c:136
>  device_release+0x9b/0x1c0
>  kobject_cleanup lib/kobject.c:689 [inline]
>  kobject_release lib/kobject.c:720 [inline]
>  kref_put include/linux/kref.h:65 [inline]
>  kobject_put+0x231/0x480 lib/kobject.c:737
>  remove_client_context+0xb9/0x1e0 drivers/infiniband/core/device.c:776
>  disable_device+0x13b/0x360 drivers/infiniband/core/device.c:1282
>  __ib_unregister_device+0x6d/0x170 drivers/infiniband/core/device.c:1475
>  ib_unregister_work+0x19/0x30 drivers/infiniband/core/device.c:1586
>  process_one_work kernel/workqueue.c:3231 [inline]
>  process_scheduled_works+0xa2e/0x1830 kernel/workqueue.c:3312
>  worker_thread+0x86d/0xd70 kernel/workqueue.c:3393
>  kthread+0x2f2/0x390 kernel/kthread.c:389
>  ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>  </TASK>

I see that this is caused by call to ib_unregister_device_queued() as a
response to NETDEV_UNREGISTER event, but we don't flush anything before.
How can we be sure that ib_device is not used anymore?

Thanks

