Return-Path: <linux-rdma+bounces-4735-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C8096B485
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Sep 2024 10:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40760B27C45
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Sep 2024 08:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A604A185B4F;
	Wed,  4 Sep 2024 08:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sqfjs3n5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E21217279E;
	Wed,  4 Sep 2024 08:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725438563; cv=none; b=sKPc5U9GDri5s/Z5d34QhRDjpI4cstPJHh0vY5bUknyjMTyHHI7fMsn6eO7OkvF3puELSNjIgcQ0zF6kJVjQXdNC3gJCGEJDbpzEz/Qlrq2zkBRVjSzs5qLGDiiXs2WYoZUtWLcAWwyMNquejOuwml8eiAGecwrbjwmeOiBp/10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725438563; c=relaxed/simple;
	bh=DItLMDxS2TW6o/6g12CJyEVIDQxxNg16Gtc7lgv7AAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sFrzI9hYiJ2oEwr6xJZprZDgt6GGVpmBoNXBD8FrfcqqMdjf0eFJhWf2QpAsWGEF0ie4qG7SK5BzGYhVpAhHqJbbU/07kzHcNX4arWgp6ONxnztC/9VUXL8kiQwoqzy21mjpOSkQGHzYfK60OYtsCN6W5y3yJViERtT8vzrmqnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sqfjs3n5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B922C4CEC2;
	Wed,  4 Sep 2024 08:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725438562;
	bh=DItLMDxS2TW6o/6g12CJyEVIDQxxNg16Gtc7lgv7AAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sqfjs3n5NWQI9vjApwFd/XLyL25PYhhk1NJKeswVqXvRnWRAgNgynUMN2s5KDbhLp
	 XMpHOWt3GawNpByUlT5TwfjzusBULb5gR8oHxXA6OPHIPZJ7fVUxJrBxE9dHLZQIA7
	 DLnMrTbQ/h24k3D7VBCjJ3FxSlDWGCcHvLmjJuQjRCCGiSlzSFzil/xZTmpKHz8cRp
	 UcocHgNDIvqT6nARG2SZvLi8Gljq1N1OcvuqYgmToOVHhkArdHWQWuNb4tFRD6MnLW
	 wt5a9IYFubShOGvLW5NylL5T0lgwwWOTVI14M/bYHUHhbRwG7Imaj1Lkhs4mBEioDZ
	 Pqf1oJJ5B9IaA==
Date: Wed, 4 Sep 2024 11:29:18 +0300
From: Leon Romanovsky <leon@kernel.org>
To: syzbot <syzbot+b8b7a6774bf40cf8296b@syzkaller.appspotmail.com>
Cc: jgg@ziepe.ca, linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [rdma?] WARNING in gid_table_release_one (2)
Message-ID: <20240904082918.GL4026@unreal>
References: <000000000000d70eed06211ac86b@google.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000d70eed06211ac86b@google.com>

#syz fix: "IB/core: Fix ib_cache_setup_one error flow cleanup"

On Sun, Sep 01, 2024 at 08:46:22PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    928f79a188aa Merge tag 'loongarch-fixes-6.11-2' of git://g..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=14089643980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=9e8c6a00ef394bcf
> dashboard link: https://syzkaller.appspot.com/bug?extid=b8b7a6774bf40cf8296b
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: i386
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-928f79a1.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/5bf719d3bbf5/vmlinux-928f79a1.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/88527595ba7c/bzImage-928f79a1.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+b8b7a6774bf40cf8296b@syzkaller.appspotmail.com
> 
> infiniband syz1: ib_query_port failed (-19)
> infiniband syz1: Couldn't set up InfiniBand P_Key/GID cache
> ------------[ cut here ]------------
> GID entry ref leak for dev syz1 index 0 ref=1
> WARNING: CPU: 0 PID: 19837 at drivers/infiniband/core/cache.c:806 release_gid_table drivers/infiniband/core/cache.c:806 [inline]
> WARNING: CPU: 0 PID: 19837 at drivers/infiniband/core/cache.c:806 gid_table_release_one+0x387/0x4b0 drivers/infiniband/core/cache.c:886
> Modules linked in:
> CPU: 0 UID: 0 PID: 19837 Comm: syz.1.3934 Not tainted 6.11.0-rc5-syzkaller-00079-g928f79a188aa #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> RIP: 0010:release_gid_table drivers/infiniband/core/cache.c:806 [inline]
> RIP: 0010:gid_table_release_one+0x387/0x4b0 drivers/infiniband/core/cache.c:886
> Code: 78 07 00 00 48 85 f6 74 2a 48 89 74 24 38 e8 b0 0a 76 f9 48 8b 74 24 38 44 89 f9 89 da 48 c7 c7 c0 69 51 8c e8 5a c3 38 f9 90 <0f> 0b 90 90 e9 6f fe ff ff e8 8b 0a 76 f9 49 8d bc 24 28 07 00 00
> RSP: 0018:ffffc900042b7080 EFLAGS: 00010286
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffc9002811e000
> RDX: 0000000000040000 RSI: ffffffff814dd406 RDI: 0000000000000001
> RBP: ffff88807ebaaf00 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000001 R11: 0000000000000000 R12: ffff888051860000
> R13: dffffc0000000000 R14: ffffed100fd755fb R15: 0000000000000001
> FS:  0000000000000000(0000) GS:ffff88802c000000(0063) knlGS:00000000f56c6b40
> CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
> CR2: 000000002effcff8 CR3: 0000000060c5e000 CR4: 0000000000350ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  ib_device_release+0xef/0x1e0 drivers/infiniband/core/device.c:498
>  device_release+0xa1/0x240 drivers/base/core.c:2582
>  kobject_cleanup lib/kobject.c:689 [inline]
>  kobject_release lib/kobject.c:720 [inline]
>  kref_put include/linux/kref.h:65 [inline]
>  kobject_put+0x1e4/0x5a0 lib/kobject.c:737
>  put_device+0x1f/0x30 drivers/base/core.c:3790
>  rxe_net_add+0xe0/0x110 drivers/infiniband/sw/rxe/rxe_net.c:544
>  rxe_newlink+0x70/0x190 drivers/infiniband/sw/rxe/rxe.c:197
>  nldev_newlink+0x373/0x5e0 drivers/infiniband/core/nldev.c:1794
>  rdma_nl_rcv_msg+0x388/0x6e0 drivers/infiniband/core/netlink.c:195
>  rdma_nl_rcv_skb.constprop.0.isra.0+0x2e6/0x450 drivers/infiniband/core/netlink.c:239
>  netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
>  netlink_unicast+0x53c/0x7f0 net/netlink/af_netlink.c:1357
>  netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1901
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  __sock_sendmsg net/socket.c:745 [inline]
>  ____sys_sendmsg+0x9b4/0xb50 net/socket.c:2597
>  ___sys_sendmsg+0x135/0x1e0 net/socket.c:2651
>  __sys_sendmsg+0x117/0x1f0 net/socket.c:2680
>  do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
>  __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
>  do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
>  entry_SYSENTER_compat_after_hwframe+0x84/0x8e
> RIP: 0023:0xf7f20579
> Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
> RSP: 002b:00000000f56c656c EFLAGS: 00000296 ORIG_RAX: 0000000000000172
> RAX: ffffffffffffffda RBX: 0000000000000008 RCX: 00000000200003c0
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000296 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>  </TASK>
> ----------------
> Code disassembly (best guess), 2 bytes skipped:
>    0:	10 06                	adc    %al,(%rsi)
>    2:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
>    6:	10 07                	adc    %al,(%rdi)
>    8:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
>    c:	10 08                	adc    %cl,(%rax)
>    e:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
>   1e:	00 51 52             	add    %dl,0x52(%rcx)
>   21:	55                   	push   %rbp
>   22:	89 e5                	mov    %esp,%ebp
>   24:	0f 34                	sysenter
>   26:	cd 80                	int    $0x80
> * 28:	5d                   	pop    %rbp <-- trapping instruction
>   29:	5a                   	pop    %rdx
>   2a:	59                   	pop    %rcx
>   2b:	c3                   	ret
>   2c:	90                   	nop
>   2d:	90                   	nop
>   2e:	90                   	nop
>   2f:	90                   	nop
>   30:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
>   37:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
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

