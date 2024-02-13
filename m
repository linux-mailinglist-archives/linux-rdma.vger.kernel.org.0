Return-Path: <linux-rdma+bounces-1015-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD20C8531A9
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Feb 2024 14:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57BFF1F252B4
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Feb 2024 13:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CAA355C0B;
	Tue, 13 Feb 2024 13:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d9xuhffK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB26C5579B;
	Tue, 13 Feb 2024 13:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707830501; cv=none; b=Bi3t8VVo1jncjZCrOhr/eL4wIeZgXbOA8w8ivQn3MNRDCdjEfcAz0yPlGhZNNCOgo8Rf05VN61zJEcYEKv/pEyKHyN0rMR6h33ND1YbGh+Nf5dIxB6I7mBu3u2WI6HsQu4hMK5KmOWx+ipWMPLrQN7F6t4FwiUywECz4AIn9hzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707830501; c=relaxed/simple;
	bh=a7SgM9dqyhqfQT8PrJFg33YJpwN0HjzTzvri4oG63X4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GowbVh62Bsbnjxssp61UUufKFN7qgxkQEcP8PGPN0dNql2Zcy/ecd+Sp49XgTTvLrx/ZdHxtbI+Vz2r9rNXfqKrVXn850Yxu+f1c/betMTOTLR5r+cLDUPdYOrCyTYJzfdGQz249v1Z6cGbDtJiwt0AWodNlvmvDHfb5U+K3rPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d9xuhffK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96567C433F1;
	Tue, 13 Feb 2024 13:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707830501;
	bh=a7SgM9dqyhqfQT8PrJFg33YJpwN0HjzTzvri4oG63X4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d9xuhffKRBV1e3d5bIGmIYYckMGkAWTW6kAogG+CbrnBoiDnp+hsnW7J5uf/4pyiL
	 OluB6+qqHShvmgk5A74ez6iDuQEObpnfOmxkF6oHZ0xl2Y1Fun66ONH4RDYsXr/1NG
	 kI371xeJ/G5DRJw7LwcxQNuK8M/7IQmZCd/A1EdDnaKaGNP80SujJDsdSVgtKxam7U
	 9K2V1FDAn1c5h8If66cUE32FANjI2JbDcN+S4LwxkgVD3GKJ94bRHxmCFey2vc5bNZ
	 Aqd6rSSYSIi7Ej3t/K2x5aEDYALa2G3Pc5UgfQRyb2EXTLnv8WWvGjPgMliGCjqY9e
	 S2cq8X1SiKtxg==
Date: Tue, 13 Feb 2024 15:21:36 +0200
From: Leon Romanovsky <leon@kernel.org>
To: bmt@zurich.ibm.com
Cc: syzbot <syzbot+e7c51d3be3a5ddfa0d7a@syzkaller.appspotmail.com>,
	jgg@ziepe.ca, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [rdma?] WARNING: ODEBUG bug in siw_netdev_event
Message-ID: <20240213132136.GC52640@unreal>
References: <000000000000b18dd106112cb53c@google.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <000000000000b18dd106112cb53c@google.com>

On Mon, Feb 12, 2024 at 02:26:24AM -0800, syzbot wrote:
> Hello,
>=20
> syzbot found the following issue on:
>=20
> HEAD commit:    b1d3a0e70c38 Add linux-next specific files for 20240208
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1325c020180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dbb693ba195662=
a06
> dashboard link: https://syzkaller.appspot.com/bug?extid=3De7c51d3be3a5ddf=
a0d7a
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
>=20
> Unfortunately, I don't have any reproducer for this issue yet.
>=20
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/176a6b395bbe/dis=
k-b1d3a0e7.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/02d7d46f81bd/vmlinu=
x-b1d3a0e7.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/18a5a5030e19/b=
zImage-b1d3a0e7.xz
>=20
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+e7c51d3be3a5ddfa0d7a@syzkaller.appspotmail.com
>=20
> netlink: 'syz-executor.1': attribute type 27 has an invalid length.
> netlink: 4 bytes leftover after parsing attributes in process `syz-execut=
or.1'.
> =1F: port 3(erspan0) entered disabled state
> ------------[ cut here ]------------
> ODEBUG: init active (active state 0) object: ffff88802de95128 object type=
: work_struct hint: siw_netdev_down+0x0/0x1f0

It means that you are trying to reinitalize work_struct. I'm not sure
that SIW should listen to NETDEV_GOING_DOWN event.

Thanks

> WARNING: CPU: 1 PID: 16397 at lib/debugobjects.c:517 debug_print_object+0=
x17a/0x1f0 lib/debugobjects.c:514
> Modules linked in:
> CPU: 1 PID: 16397 Comm: syz-executor.1 Not tainted 6.8.0-rc3-next-2024020=
8-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 01/25/2024
> RIP: 0010:debug_print_object+0x17a/0x1f0 lib/debugobjects.c:514
> Code: e8 1b e3 4d fd 4c 8b 0b 48 c7 c7 00 89 fe 8b 48 8b 74 24 08 48 89 e=
a 44 89 e1 4d 89 f8 ff 34 24 e8 2b 97 ae fc 48 83 c4 08 90 <0f> 0b 90 90 ff=
 05 bc 2f dd 0a 48 83 c4 10 5b 41 5c 41 5d 41 5e 41
> RSP: 0018:ffffc90014536758 EFLAGS: 00010282
> RAX: 5f296badc3198f00 RBX: ffffffff8ba9e6a0 RCX: 0000000000040000
> RDX: ffffc90004f8b000 RSI: 000000000003ffff RDI: 0000000000040000
> RBP: ffffffff8bfe8a80 R08: ffffffff8157b862 R09: fffffbfff1bf95c4
> R10: dffffc0000000000 R11: fffffbfff1bf95c4 R12: 0000000000000000
> R13: ffffffff8bfe8998 R14: dffffc0000000000 R15: ffff88802de95128
> FS:  00007fc00b12a6c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fa1fd40f000 CR3: 000000003e1a6000 CR4: 00000000003506f0
> DR0: 000000000000d8dd DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  __debug_object_init+0x2a9/0x400 lib/debugobjects.c:653
>  siw_device_goes_down drivers/infiniband/sw/siw/siw_main.c:395 [inline]
>  siw_netdev_event+0x3bd/0x620 drivers/infiniband/sw/siw/siw_main.c:422
>  notifier_call_chain+0x18f/0x3b0 kernel/notifier.c:93
>  call_netdevice_notifiers_extack net/core/dev.c:2012 [inline]
>  call_netdevice_notifiers net/core/dev.c:2026 [inline]
>  __dev_close_many+0x146/0x300 net/core/dev.c:1512
>  __dev_close net/core/dev.c:1550 [inline]
>  __dev_change_flags+0x30e/0x6f0 net/core/dev.c:8683
>  dev_change_flags+0x8b/0x1a0 net/core/dev.c:8757
>  do_setlink+0xcb0/0x41c0 net/core/rtnetlink.c:2894
>  rtnl_group_changelink net/core/rtnetlink.c:3443 [inline]
>  __rtnl_newlink net/core/rtnetlink.c:3702 [inline]
>  rtnl_newlink+0x1117/0x20a0 net/core/rtnetlink.c:3739
>  rtnetlink_rcv_msg+0x885/0x1040 net/core/rtnetlink.c:6606
>  netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2543
>  netlink_unicast_kernel net/netlink/af_netlink.c:1341 [inline]
>  netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1367
>  netlink_sendmsg+0xa3c/0xd70 net/netlink/af_netlink.c:1908
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  __sock_sendmsg+0x221/0x270 net/socket.c:745
>  ____sys_sendmsg+0x525/0x7d0 net/socket.c:2584
>  ___sys_sendmsg net/socket.c:2638 [inline]
>  __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2667
>  do_syscall_64+0xfb/0x240
>  entry_SYSCALL_64_after_hwframe+0x6d/0x75
> RIP: 0033:0x7fc00a47dda9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fc00b12a0c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00007fc00a5ac1f0 RCX: 00007fc00a47dda9
> RDX: 0000000000000000 RSI: 0000000020006440 RDI: 0000000000000005
> RBP: 00007fc00a4ca47a R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 000000000000006e R14: 00007fc00a5ac1f0 R15: 00007fff19fc38d8
>  </TASK>
>=20
>=20
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>=20
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>=20
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>=20
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>=20
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>=20
> If you want to undo deduplication, reply with:
> #syz undup
>=20

