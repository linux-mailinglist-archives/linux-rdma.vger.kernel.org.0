Return-Path: <linux-rdma+bounces-7086-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94171A1619F
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Jan 2025 13:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DD8A18862CE
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Jan 2025 12:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC77B1DA116;
	Sun, 19 Jan 2025 12:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NCbpr5Gx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADFC1DFD8;
	Sun, 19 Jan 2025 12:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737289524; cv=none; b=TCKljfYTx+qAZm/lZWaHCKfHcLVIby++V6+w9Eg/Q+loOn/d/1f9VS7ZTfBYzvhLKPIsZYS4ixjbBGE51Go5q62VouZkD7YQ3NzXMg83HdhWXHCnv+wDzoIvwrw3Sl7RXoY+g8B0aEac5daIIOkAmK612czwh0y1zmrOdGQIdEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737289524; c=relaxed/simple;
	bh=DOR6gmWF4R9nzPNs9Cx+JdqfyiMEvtrNRvj4n16yVzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lDvDqCLeFwAJuz09mEERUNS6RDkYL0ooUycGjHIKdGW0+bn9c7OQgghz9mjXJhNrOESatmB/wn+ToZ83sqaR7rRDRScmCofkphns7uFNvFEa2BM2pR9v5H68O1xdQX3FX1ZSYO6j0BXZNrXUcQNCLa0p+vzyrxrPqjQAC4Cle+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NCbpr5Gx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67BE4C4CED6;
	Sun, 19 Jan 2025 12:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737289523;
	bh=DOR6gmWF4R9nzPNs9Cx+JdqfyiMEvtrNRvj4n16yVzo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NCbpr5Gx7PXA1tGE77TDXUr11vY3POSB9jWhKbKdhmAehYgmNVolUH7RrvNThFkX9
	 TERImpt1k0cfSRUiqm+cwUr6LjAxQw3R9UBxa77hD9Gr+LuKi79EsOoLFDjc3go3Ou
	 1eGIcQOVDiwIBfWvd6rzbeBY0CUaERgwmo+LiZFvkT+ebrldwhOyTn7JDLF8AvmDF8
	 eao6uW8aAqtiJ2t/zTrgLzXuFUTIibgajVNJOwl/gUMDCKaGgrVGxKv1ljBVV5towK
	 CGpy0qULq5TW9ik7AzTdn/9lnBYydVOetTExM0jG4+UifJANwTJlDXBMUzafVRhQ6z
	 hv9zQMYc9ki1g==
Date: Sun, 19 Jan 2025 14:25:18 +0200
From: Leon Romanovsky <leon@kernel.org>
To: syzbot <syzbot+65a3b37f91d0382b77fd@syzkaller.appspotmail.com>
Cc: jgg@ziepe.ca, linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	linux-s390@vger.kernel.org
Subject: Re: [syzbot] [rdma?] WARNING in rdma_restrack_clean
Message-ID: <20250119122518.GD21007@unreal>
References: <678c7b69.050a0220.303755.0045.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <678c7b69.050a0220.303755.0045.GAE@google.com>

On Sat, Jan 18, 2025 at 08:11:21PM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    c3812b15000c Merge tag 'scsi-fixes' of git://git.kernel.or..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=13c2bcb0580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=aadf89e2f6db86cc
> dashboard link: https://syzkaller.appspot.com/bug?extid=65a3b37f91d0382b77fd
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-c3812b15.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/97c15b4b3ce2/vmlinux-c3812b15.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/726b9643ccee/bzImage-c3812b15.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+65a3b37f91d0382b77fd@syzkaller.appspotmail.com
> 
> smc: removing ib device syz1
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 5318 at drivers/infiniband/core/restrack.c:52 rdma_restrack_clean+0x2af/0x320 drivers/infiniband/core/restrack.c:52

This warning means that SMC module didn't clean all IB verbs objects which
were allocated.

Thanks

> Modules linked in:
> CPU: 0 UID: 0 PID: 5318 Comm: syz.0.0 Not tainted 6.13.0-rc7-syzkaller-00039-gc3812b15000c #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> RIP: 0010:rdma_restrack_clean+0x2af/0x320 drivers/infiniband/core/restrack.c:52
> Code: 02 dd f8 49 81 c7 68 02 00 00 4c 89 ff e8 59 2b 05 03 4c 89 f7 5b 41 5c 41 5d 41 5e 41 5f 5d e9 c7 cf 37 f9 e8 42 02 dd f8 90 <0f> 0b 90 e9 b3 fd ff ff e8 34 02 dd f8 90 0f 0b 90 e9 f1 fd ff ff
> RSP: 0018:ffffc9000d4b70e0 EFLAGS: 00010283
> RAX: ffffffff88c2802e RBX: ffff888052b10848 RCX: 0000000000100000
> RDX: ffffc9000ec9b000 RSI: 00000000000a1c6d RDI: 00000000000a1c6e
> RBP: 1ffff11007de21c3 R08: ffffffff88bb12d7 R09: 1ffff11007de21c5
> R10: dffffc0000000000 R11: ffffed1007de21c6 R12: dffffc0000000000
> R13: dffffc0000000000 R14: ffff888052b10800 R15: ffff88803ef10e18
> FS:  00007f056259c6c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000055d0f79a11d0 CR3: 000000003bbf4000 CR4: 0000000000352ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  ib_dealloc_device+0x168/0x200 drivers/infiniband/core/device.c:683
>  __ib_unregister_device+0x366/0x3d0 drivers/infiniband/core/device.c:1537
>  ib_unregister_device_and_put+0xb9/0xf0 drivers/infiniband/core/device.c:1584
>  nldev_dellink+0x2c6/0x310 drivers/infiniband/core/nldev.c:1825
>  rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
>  rdma_nl_rcv+0x6dd/0x9e0 drivers/infiniband/core/netlink.c:259
>  netlink_unicast_kernel net/netlink/af_netlink.c:1321 [inline]
>  netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1347
>  netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1891
>  sock_sendmsg_nosec net/socket.c:711 [inline]
>  __sock_sendmsg+0x221/0x270 net/socket.c:726
>  ____sys_sendmsg+0x52a/0x7e0 net/socket.c:2583
>  ___sys_sendmsg net/socket.c:2637 [inline]
>  __sys_sendmsg+0x269/0x350 net/socket.c:2669
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f0561785d29
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f056259c038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00007f0561976080 RCX: 00007f0561785d29
> RDX: 0000000000000000 RSI: 00000000200002c0 RDI: 0000000000000009
> RBP: 00007f0561801b08 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000000 R14: 00007f0561976080 R15: 00007ffdce037348
>  </TASK>
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
> 

