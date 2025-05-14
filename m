Return-Path: <linux-rdma+bounces-10343-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5504AAB6691
	for <lists+linux-rdma@lfdr.de>; Wed, 14 May 2025 10:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BEF74A5994
	for <lists+linux-rdma@lfdr.de>; Wed, 14 May 2025 08:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C682206B6;
	Wed, 14 May 2025 08:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sqObPhyK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC7270838;
	Wed, 14 May 2025 08:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747212867; cv=none; b=YakT5LKkREhm+dPMZAtBLyVUsrM/FYZm45n4cUUKSLZC1RDN6fqNabQVvCtv4OyeXY5FjPJJpvPZyDOiHLi/UVBjKGQcQk1FAPCim0T63RJN++yP0Z94Z/aCh+lVpGfU/pMTy5UoppTY9u0awqpQP49VhQmkz8LDOIULITV6HSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747212867; c=relaxed/simple;
	bh=98/I6IwUBVeXLY7u6hN/KSLVSuCpn45sH8QDsTcffE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q8bDMMpAxc8F+uagfwJf+naLnc6MCCD5mElrk3GQl3ATqQpE7FPBzE6ZsOf3u3Dtd1hh/ib10nZhCNyO+EUzF94YGFuVn3OCh7rtFAaiGKIplgvkPAfYqNnUnc5n/Aw8N+X4wt4MuXPf4geDMOZdJyk2nNo/o3oLP3cEPdvSzzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sqObPhyK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50634C4CEE9;
	Wed, 14 May 2025 08:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747212866;
	bh=98/I6IwUBVeXLY7u6hN/KSLVSuCpn45sH8QDsTcffE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sqObPhyKQ1BvExlcWbFhsql5THqk3twRiFIjgu6uEQuVj4fOWbs0W8Yv4H48NpP0X
	 +FnQkEj0HVroAhZduNtxrC1kF/4BqCAyy5CkdBitd1rm8p2RU1XKcYJDtRjQxgvrjC
	 wvb0qbtuL/U5/T0KTN9YjFuOvrUkd3ewtFbZQf55CZHntMujh1W1vsOKNSgrsnF9S4
	 aarMRkIcN9PtjclloHPHOXppXhTfwhwjSePV5U/88E54t8iXGYYZ8Wsk6g6VlNvput
	 bs1bDEwtjMTTc1fhNBHwe1g6Sa1vmfoEp2wQEb42yA0iwEkW929LBnwHwv59JX4rrg
	 1xkCR1zuH2AAQ==
Date: Wed, 14 May 2025 11:54:21 +0300
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca
Cc: syzbot <syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com>,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [rdma?] WARNING in gid_table_release_one (3)
Message-ID: <20250514085421.GO22843@unreal>
References: <68232e7b.050a0220.f2294.09f6.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68232e7b.050a0220.f2294.09f6.GAE@google.com>

On Tue, May 13, 2025 at 04:35:23AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    c32f8dc5aaf9 Merge branch 'for-next/core' into for-kernelci
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=10789768580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ea4635ffd6ad5b4a
> dashboard link: https://syzkaller.appspot.com/bug?extid=b0da83a6c0e2e2bddbd4
> compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15a08cf4580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/b921498959d4/disk-c32f8dc5.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/04e6ad946c4b/vmlinux-c32f8dc5.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/d4f0d8db50ee/Image-c32f8dc5.gz.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com
> 
> --
> ------------[ cut here ]------------
> GID entry ref leak for dev syz1 index 2 ref=573

Jason,

According to repro https://syzkaller.appspot.com/x/repro.syz?x=15a08cf4580000, we joined multicast group,
but never left it. This is how we can get "ref=573".

write$RDMA_USER_CM_CMD_CREATE_ID(r1, &(0x7f00000001c0)={0x0, 0x18, 0xfa00, {0x3, &(0x7f0000000100)={<r2=>0xffffffffffffffff}, 0x13f, 0x4}}, 0x20)
write$RDMA_USER_CM_CMD_BIND_IP(r1, &(0x7f0000000180)={0x2, 0x28, 0xfa00, {0x0, {0xa, 0x4e25, 0x10001, @local, 0xb}, r2}}, 0x30)
write$RDMA_USER_CM_CMD_JOIN_MCAST(r1, &(0x7f0000000900)={0x16, 0x98, 0xfa00, {0x0, 0x5, r2, 0x10, 0x1, @in={0x2, 0x4e23, @loopback}}}, 0xa0)

Thanks

> WARNING: CPU: 1 PID: 655 at drivers/infiniband/core/cache.c:809 release_gid_table drivers/infiniband/core/cache.c:806 [inline]
> WARNING: CPU: 1 PID: 655 at drivers/infiniband/core/cache.c:809 gid_table_release_one+0x284/0x3cc drivers/infiniband/core/cache.c:886
> Modules linked in:
> CPU: 1 UID: 0 PID: 655 Comm: kworker/u8:10 Not tainted 6.15.0-rc5-syzkaller-gc32f8dc5aaf9 #0 PREEMPT 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
> Workqueue: ib-unreg-wq ib_unregister_work
> pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : release_gid_table drivers/infiniband/core/cache.c:806 [inline]
> pc : gid_table_release_one+0x284/0x3cc drivers/infiniband/core/cache.c:886
> lr : release_gid_table drivers/infiniband/core/cache.c:806 [inline]
> lr : gid_table_release_one+0x284/0x3cc drivers/infiniband/core/cache.c:886
> sp : ffff80009c927860
> x29: ffff80009c9278b0 x28: ffff0000d2b52f00 x27: ffff0000d77ee8d8
> x26: ffff0000d77ee800 x25: 0000000000000010 x24: 0000000000000001
> x23: ffff800092818000 x22: dfff800000000000 x21: 0000000000000003
> x20: 1fffe0001aefdd1b x19: 1fffe0001aefdd00 x18: 00000000ffffffff
> x17: 0000000000000000 x16: ffff80008adb410c x15: 0000000000000001
> x14: 1fffe000338716e2 x13: 0000000000000000 x12: 0000000000000000
> x11: ffff6000338716e3 x10: 0000000000ff0100 x9 : 1b90c18326689500
> x8 : 1b90c18326689500 x7 : 0000000000000001 x6 : 0000000000000001
> x5 : ffff80009c9271b8 x4 : ffff80008f405b40 x3 : ffff8000807b1330
> x2 : 0000000000000001 x1 : 0000000100000000 x0 : 0000000000000000
> Call trace:
>  release_gid_table drivers/infiniband/core/cache.c:806 [inline] (P)
>  gid_table_release_one+0x284/0x3cc drivers/infiniband/core/cache.c:886 (P)
>  ib_cache_release_one+0x144/0x174 drivers/infiniband/core/cache.c:1636
>  ib_device_release+0xc4/0x194 drivers/infiniband/core/device.c:482
>  device_release+0x8c/0x1ac drivers/base/core.c:-1
>  kobject_cleanup lib/kobject.c:689 [inline]
>  kobject_release lib/kobject.c:720 [inline]
>  kref_put include/linux/kref.h:65 [inline]
>  kobject_put+0x2b0/0x438 lib/kobject.c:737
>  put_device+0x28/0x40 drivers/base/core.c:3800
>  ib_unregister_work+0x28/0x38 drivers/infiniband/core/device.c:1629
>  process_one_work+0x7e8/0x156c kernel/workqueue.c:3238
>  process_scheduled_works kernel/workqueue.c:3319 [inline]
>  worker_thread+0x958/0xed8 kernel/workqueue.c:3400
>  kthread+0x5fc/0x75c kernel/kthread.c:464
>  ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:847
> irq event stamp: 1499918
> hardirqs last  enabled at (1499917): [<ffff80008054cc08>] __up_console_sem kernel/printk/printk.c:344 [inline]
> hardirqs last  enabled at (1499917): [<ffff80008054cc08>] __console_unlock+0x70/0xc4 kernel/printk/printk.c:2885
> hardirqs last disabled at (1499918): [<ffff80008adaf5e0>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:511
> softirqs last  enabled at (1496318): [<ffff8000803cbf1c>] softirq_handle_end kernel/softirq.c:425 [inline]
> softirqs last  enabled at (1496318): [<ffff8000803cbf1c>] handle_softirqs+0xaf8/0xc88 kernel/softirq.c:607
> softirqs last disabled at (1496303): [<ffff800080020efc>] __do_softirq+0x14/0x20 kernel/softirq.c:613
> ---[ end trace 0000000000000000 ]---
> wlan1: Created IBSS using preconfigured BSSID 50:50:50:50:50:50
> wlan1: Creating new IBSS network, BSSID 50:50:50:50:50:50
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
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
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

