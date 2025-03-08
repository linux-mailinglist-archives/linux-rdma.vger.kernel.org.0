Return-Path: <linux-rdma+bounces-8494-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB22A57C95
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Mar 2025 19:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DA4D1891CA7
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Mar 2025 18:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD711EB5C5;
	Sat,  8 Mar 2025 18:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bALZpQ3l"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E02A1F16B
	for <linux-rdma@vger.kernel.org>; Sat,  8 Mar 2025 18:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741457052; cv=none; b=LJiytvE27/VA3ZlzCm/S7Z765N6jTbFVB7nKrXynAKfb1NUVP7GdK4tMpPiyUQU2Da+wDSyOPUl1QlB6Ll0OrhVXTwL9rnWIDTsdz3oK3YTdiycKGZtC85roR7aqp3UkZBFV0MxiHsd5NnNkl5Yeu3Uwo84wIfUYuDHpgeXK4xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741457052; c=relaxed/simple;
	bh=nTe/1FKrZ61wPMXwoiIXUSHwUYTDM2kvMZA2ZukMWhY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JKuNJDwc86yBDxb666jrs2J90kWKwbgecVzoYDyJlxVBDNo+ICr+Ctg3K3Ti2uiQsYKzCHvi3ccZCsxfwCJmyGAJINyFCffyFmLAPudaIJ/zZ2cePjen9k83hktPfu9N6gEBa/EnMUJ9aLSAFPimXOzYExluET2w5Jf9uznboks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bALZpQ3l; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <662c734d-6b5a-4435-8eb4-4d912ba37cf6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741457037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NmpQgy86E1gD6AfEtQJs4ondCL2qcMbQBKlrVz00Ka0=;
	b=bALZpQ3lifquJythjAjppqtV99PwvNHvVJKB+Wv80juisPtGtPzG1oQ8YLY9UfldNm2fPO
	UrmC+N3GAUn0mOfPl8Jv+5uYlI9/b8RQM07tBoHeRGbXvkC50H5iu57nHKbcH30TLk5Eaz
	KVNeUYMbm0zZPK3dZcjP54OdOBGMNUE=
Date: Sat, 8 Mar 2025 19:03:52 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [syzbot] [rdma?] WARNING in rxe_pool_cleanup
To: syzbot <syzbot+221e213bf17f17e0d6cd@syzkaller.appspotmail.com>,
 jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, zyjzyj2000@gmail.com
References: <67a59df3.050a0220.2b1e6.0011.GAE@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <67a59df3.050a0220.2b1e6.0011.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/2/7 6:45, syzbot 写道:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    bb066fe812d6 Merge tag 'pci-v6.14-fixes-2' of git://git.ke..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=16a973df980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=1909f2f0d8e641ce
> dashboard link: https://syzkaller.appspot.com/bug?extid=221e213bf17f17e0d6cd
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11a01df8580000
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-bb066fe8.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/ac7155966351/vmlinux-bb066fe8.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/92d6cbf35949/bzImage-bb066fe8.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+221e213bf17f17e0d6cd@syzkaller.appspotmail.com
> 
> smc: removing ib device syz0
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 5645 at drivers/infiniband/sw/rxe/rxe_pool.c:116 rxe_pool_cleanup+0x47/0x50 drivers/infiniband/sw/rxe/rxe_pool.c:116

Hi, all

I delved into this problem. I found the following in the link 
https://syzkaller.appspot.com/x/log.txt?x=16a973df980000

"
[   73.687051][ T5401] infiniband syz0: set active
[   73.688993][ T5401] infiniband syz0: added bond0
[   73.724619][ T5401] RDS/IB: syz0: added 
   < --- It seems that RDS also used this rxe device in this test.
[   73.726492][ T5401] smc: adding ib device syz0 with port count 1
[   73.729145][ T5401] smc:    ib device syz0 port 1 has pnetid
"

But when smc releases rxe device, RDS does not release rxe device.

The logs are as below
"
[   76.652232][ T5401] smc: removing ib device syz0
[   76.952936][ T5401] ------------[ cut here ]------------
[   76.955199][ T5401] WARNING: CPU: 0 PID: 5401 at 
drivers/infiniband/sw/rxe/rxe_pool.c:116 rxe_pool_cleanup+0x47/0x50
"
I have no idea about the whole test script. So I just suggest whether 
this test script remove this RDS initialization because RDS does not do 
any work in this script.

Or before smc removes ib device syz0, let RDS also release rxe device.

Then let us know whether this problem still occur or not.

Thanks a lot.
Zhu Yanjun

> Modules linked in:
> CPU: 0 UID: 0 PID: 5645 Comm: syz.0.16 Not tainted 6.14.0-rc1-syzkaller-00081-gbb066fe812d6 #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> RIP: 0010:rxe_pool_cleanup+0x47/0x50 drivers/infiniband/sw/rxe/rxe_pool.c:116
> Code: 00 00 fc ff df 80 3c 08 00 74 08 48 89 df e8 10 aa 1a f9 48 83 3b 00 75 0b e8 95 11 b4 f8 5b c3 cc cc cc cc e8 8a 11 b4 f8 90 <0f> 0b 90 5b c3 cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90
> RSP: 0018:ffffc9000ce370e8 EFLAGS: 00010293
> RAX: ffffffff890b4c96 RBX: ffff888052855380 RCX: ffff88801f3e8000
> RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffff888052855300
> RBP: 0000000000000002 R08: ffffffff88e3bcc3 R09: 1ffff1100a50a8ee
> R10: dffffc0000000000 R11: ffffffff89096000 R12: dffffc0000000000
> R13: dffffc0000000000 R14: ffff888052854658 R15: dffffc0000000000
> FS:  00007fc32943e6c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fc32943dfe0 CR3: 00000000405a6000 CR4: 0000000000352ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   <TASK>
>   rxe_dealloc+0x33/0x100 drivers/infiniband/sw/rxe/rxe.c:24
>   ib_dealloc_device+0x50/0x200 drivers/infiniband/core/device.c:647
>   __ib_unregister_device+0x366/0x3d0 drivers/infiniband/core/device.c:1520
>   ib_unregister_device_and_put+0xb9/0xf0 drivers/infiniband/core/device.c:1567
>   nldev_dellink+0x2c6/0x310 drivers/infiniband/core/nldev.c:1825
>   rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
>   rdma_nl_rcv+0x6dd/0x9e0 drivers/infiniband/core/netlink.c:259
>   netlink_unicast_kernel net/netlink/af_netlink.c:1322 [inline]
>   netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1348
>   netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1892
>   sock_sendmsg_nosec net/socket.c:713 [inline]
>   __sock_sendmsg+0x221/0x270 net/socket.c:728
>   ____sys_sendmsg+0x52a/0x7e0 net/socket.c:2568
>   ___sys_sendmsg net/socket.c:2622 [inline]
>   __sys_sendmsg+0x269/0x350 net/socket.c:2654
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fc32858cde9
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fc32943e038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00007fc3287a6160 RCX: 00007fc32858cde9
> RDX: 0000000020000000 RSI: 0000200000000000 RDI: 0000000000000004
> RBP: 00007fc32860e2a0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000000 R14: 00007fc3287a6160 R15: 00007ffc02559df8
>   </TASK>
> 
> 
> ---
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.


