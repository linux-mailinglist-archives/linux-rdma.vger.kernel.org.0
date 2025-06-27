Return-Path: <linux-rdma+bounces-11712-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1FAAEAE31
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Jun 2025 06:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8C047B4633
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Jun 2025 04:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779651D9A5D;
	Fri, 27 Jun 2025 04:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="n4Cv2HTp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569B81E0B91
	for <linux-rdma@vger.kernel.org>; Fri, 27 Jun 2025 04:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751000051; cv=none; b=GtJG1dSEVDzE84Ov80KuWmU2cPrFIoVNUqlCf/R5yd8l++1vV0/tY+L3jrp5lz7mWCpJyQTFsSU4flTTwqUkYz5RSD43SeoxwofMXX9ohuue1PzwJ/xP03emrjnXGCUVfyexqeB487K/n3gGsL1EvmgfGssEnsfWg3ko4h2Xyr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751000051; c=relaxed/simple;
	bh=Mn91nD8N81a4I8LV9JExL3dkijp9Nz+10fd1guOSSOs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RTa+ecIT09TEeOOYolceJQeDxCl08raFmCbevOUjlQiHhaaj/7DpbeZ+B2PIJfpzWsrVRT6Bn8BVmgLXN+OZ603PnfCE7fq5s+ivQFprL8USeiqbig0ciGa6euT0eunl+hr9q2MhTprJXZibUVA3tzIRG+2Nts6aa3/zbUBKtmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=n4Cv2HTp; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <dbcc14cc-abfa-4486-a642-2fe97b4a0ef3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751000044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9a2vQ9ByAahXjvmC4vFJM4DGyfQ2okDu7nWB7feKJaE=;
	b=n4Cv2HTpgZ1pNqF5WzeMnnw8nyricFS+9qorvbjBMQH3ClH24QQ0iCthatcYUB5USRYdJN
	x4MYqa37vwXC4fJ0d6a96l9KnH30YgSV6UVSJvuWQxY15MHFCL4xTcaXOD43iqcSyrkTHa
	g/JA9erJRhMfxhgrMhQiiQr6AuCRVrU=
Date: Thu, 26 Jun 2025 21:53:47 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [syzbot] [rdma?] WARNING in rxe_skb_tx_dtor
To: syzbot <syzbot+8425ccfb599521edb153@syzkaller.appspotmail.com>,
 jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 zyjzyj2000@gmail.com
References: <685e168e.a00a0220.2e5631.03f4.GAE@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <685e168e.a00a0220.2e5631.03f4.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

#syz test: https://github.com/zhuyj/linux.git v6.16_fix_rxe_skb_tx_dtor

在 2025/6/26 20:57, syzbot 写道:
> Hello,
>
> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> WARNING in rxe_skb_tx_dtor
>
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 3034 at drivers/infiniband/sw/rxe/rxe_net.c:357 rxe_skb_tx_dtor+0x8b/0x2a0 drivers/infiniband/sw/rxe/rxe_net.c:357
> Modules linked in:
> CPU: 0 UID: 0 PID: 3034 Comm: kworker/u4:10 Not tainted 6.16.0-rc3-syzkaller-ge9ef70b277ad #0 PREEMPT(full)
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> Workqueue: rxe_wq do_work
> RIP: 0010:rxe_skb_tx_dtor+0x8b/0x2a0 drivers/infiniband/sw/rxe/rxe_net.c:357
> Code: 80 3c 20 00 74 08 4c 89 ff e8 c1 64 81 f9 4d 8b 37 44 89 f6 83 e6 01 31 ff e8 d1 e5 1d f9 41 f6 c6 01 75 0e e8 e6 e0 1d f9 90 <0f> 0b 90 e9 b4 01 00 00 4c 89 ff e8 45 97 fd 01 48 89 c7 be 0e 00
> RSP: 0018:ffffc900000079e8 EFLAGS: 00010246
> RAX: ffffffff88a26d8a RBX: ffff8880560d4500 RCX: ffff88801f722440
> RDX: 0000000000000100 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000000000 R08: 0000000000000000 R09: ffffffff887bc1c4
> R10: dffffc0000000000 R11: ffffffff88a26d00 R12: dffffc0000000000
> R13: 1ffff1100ac1a8ab R14: 0000000000025820 R15: ffff888033440000
> FS:  0000000000000000(0000) GS:ffff88808d250000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f5e595acfc8 CR3: 0000000056029000 CR4: 0000000000352ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   <IRQ>
>   skb_release_head_state+0x101/0x250 net/core/skbuff.c:1139
>   napi_consume_skb+0xd2/0x1e0 net/core/skbuff.c:-1
>   e1000_unmap_and_free_tx_resource drivers/net/ethernet/intel/e1000/e1000_main.c:1972 [inline]
>   e1000_clean_tx_irq drivers/net/ethernet/intel/e1000/e1000_main.c:3864 [inline]
>   e1000_clean+0x49d/0x2b00 drivers/net/ethernet/intel/e1000/e1000_main.c:3805
>   __napi_poll+0xc7/0x480 net/core/dev.c:7414
>   napi_poll net/core/dev.c:7478 [inline]
>   net_rx_action+0x707/0xe30 net/core/dev.c:7605
>   handle_softirqs+0x286/0x870 kernel/softirq.c:579
>   do_softirq+0xec/0x180 kernel/softirq.c:480
>   </IRQ>
>   <TASK>
>   __local_bh_enable_ip+0x17d/0x1c0 kernel/softirq.c:407
>   local_bh_enable include/linux/bottom_half.h:33 [inline]
>   __neigh_event_send+0x9b/0x1560 net/core/neighbour.c:1194
>   neigh_event_send_probe include/net/neighbour.h:463 [inline]
>   neigh_event_send include/net/neighbour.h:469 [inline]
>   neigh_resolve_output+0x198/0x750 net/core/neighbour.c:1496
>   neigh_output include/net/neighbour.h:539 [inline]
>   ip6_finish_output2+0x11fb/0x16a0 net/ipv6/ip6_output.c:141
>   __ip6_finish_output net/ipv6/ip6_output.c:-1 [inline]
>   ip6_finish_output+0x234/0x7d0 net/ipv6/ip6_output.c:226
>   rxe_send drivers/infiniband/sw/rxe/rxe_net.c:391 [inline]
>   rxe_xmit_packet+0x79e/0xa30 drivers/infiniband/sw/rxe/rxe_net.c:450
>   rxe_requester+0x1fea/0x3d20 drivers/infiniband/sw/rxe/rxe_req.c:805
>   rxe_sender+0x16/0x50 drivers/infiniband/sw/rxe/rxe_req.c:839
>   do_task drivers/infiniband/sw/rxe/rxe_task.c:127 [inline]
>   do_work+0x1b4/0x6c0 drivers/infiniband/sw/rxe/rxe_task.c:187
>   process_one_work kernel/workqueue.c:3238 [inline]
>   process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3321
>   worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
>   kthread+0x70e/0x8a0 kernel/kthread.c:464
>   ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>   </TASK>
>
>
> Tested on:
>
> commit:         e9ef70b2 RDNA/rxe: Fix rxe_skb_tx_dtor problem
> git tree:       https://github.com/zhuyj/linux.git v6.16_fix_rxe_skb_tx_dtor
> console output: https://syzkaller.appspot.com/x/log.txt?x=122183d4580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=79da270cec5ffd65
> dashboard link: https://syzkaller.appspot.com/bug?extid=8425ccfb599521edb153
> compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
>
> Note: no patches were applied.

-- 
Best Regards,
Yanjun.Zhu


