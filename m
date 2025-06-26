Return-Path: <linux-rdma+bounces-11699-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F3AAEA992
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Jun 2025 00:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12A2C1C43CF5
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jun 2025 22:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1402262D14;
	Thu, 26 Jun 2025 22:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RgG1P6iD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C028C2185AC
	for <linux-rdma@vger.kernel.org>; Thu, 26 Jun 2025 22:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750976560; cv=none; b=W9DOAXvffeyIiiiECJMtoBrg7O9g9uydqMq+xviZu+qtYr8UZ/db73ks/mDEfHvV5ZxozLYz9X93doWyHnhoJ0j7+GqQK+F+PXkB7ZePSSQsKJQlj4SZFJpW14Le0aGWibxenhec67NyfQv614nBnNg69OswKjhkQKh+u5i9v7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750976560; c=relaxed/simple;
	bh=fBdqLi2zh8cgE2smZ2prRBWP5Fb7RYAI+pYgkD2qyFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cGvrB0hlSE8EgFVCq1WgLJ44Z/Xb4dZ+Gu998G+s0HhWDgdrmzBRYGwcg39g5hAg5aXPzpFV+h82fMaucicmYKMORWU+q+Bgt9oNA2aHHDpkP5njRJJ+b7Bh3yAvuk8jrfUNgFW/FPLiPfi2WWKfdb9xeXWYWdMy2Jz3oQhBS24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RgG1P6iD; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c6528a69-f229-470c-aa60-012049d7287f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750976554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LgMWyO64jmjwOX0CQ6au9/Uu+T+Vqow9qeNtLOchaqw=;
	b=RgG1P6iDuXQQAvlB4p3BTRPgCb+smEyIxB+aYsPWlaX1O+kR2v9ZANpp2p+4pmVHsGw2o3
	Pg7ansE5Snfd5kria53L8YLR7j7bQ/jNXcEtA27OZEoGTDlaci43iLe6HVk5AlHluPToVV
	noIP3LbELFgFNZZ6sKoZylk1lIV/+lU=
Date: Thu, 26 Jun 2025 15:22:25 -0700
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
References: <685db3be.a00a0220.2e5631.0362.GAE@google.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Yanjun.Zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <685db3be.a00a0220.2e5631.0362.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

#syz test: git@github.com:zhuyj/linux.git linux-6.15-rc4-fix-rxe_skb_tx_dtor

On 6/26/25 1:55 PM, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
>
> HEAD commit:    ee88bddf7f2f Merge tag 'bpf-fixes' of git://git.kernel.org..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=14367182580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=79da270cec5ffd65
> dashboard link: https://syzkaller.appspot.com/bug?extid=8425ccfb599521edb153
> compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10e9008c580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10c12f0c580000
>
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-ee88bddf.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/258fe65055ba/vmlinux-ee88bddf.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/06b784a6d799/bzImage-ee88bddf.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/59084afab8b5/mount_2.gz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+8425ccfb599521edb153@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 1088 at drivers/infiniband/sw/rxe/rxe_net.c:357 rxe_skb_tx_dtor+0x8b/0x2a0 drivers/infiniband/sw/rxe/rxe_net.c:357
> Modules linked in:
> CPU: 0 UID: 0 PID: 1088 Comm: kworker/u4:9 Not tainted 6.16.0-rc3-syzkaller-00072-gee88bddf7f2f #0 PREEMPT(full)
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> Workqueue: rxe_wq do_work
> RIP: 0010:rxe_skb_tx_dtor+0x8b/0x2a0 drivers/infiniband/sw/rxe/rxe_net.c:357
> Code: 80 3c 20 00 74 08 4c 89 ff e8 61 65 81 f9 4d 8b 37 44 89 f6 83 e6 01 31 ff e8 71 e6 1d f9 41 f6 c6 01 75 0e e8 86 e1 1d f9 90 <0f> 0b 90 e9 b4 01 00 00 4c 89 ff e8 75 89 fd 01 48 89 c7 be 0e 00
> RSP: 0018:ffffc900000079e8 EFLAGS: 00010246
> RAX: ffffffff88a26cea RBX: ffff888048886000 RCX: ffff8880330b4880
> RDX: 0000000000000100 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000000000 R08: 0000000000000000 R09: ffffffff887bc1c4
> R10: dffffc0000000000 R11: ffffffff88a26c60 R12: dffffc0000000000
> R13: 1ffff11009110c0b R14: 0000000000025820 R15: ffff888033430000
> FS:  0000000000000000(0000) GS:ffff88808d251000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ffd7005cfa8 CR3: 0000000047588000 CR4: 0000000000352ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   <IRQ>
>   skb_release_head_state+0xfe/0x250 net/core/skbuff.c:1139
>   napi_consume_skb+0xd2/0x1e0 net/core/skbuff.c:-1
>   e1000_unmap_and_free_tx_resource drivers/net/ethernet/intel/e1000/e1000_main.c:1972 [inline]
>   e1000_clean_tx_irq drivers/net/ethernet/intel/e1000/e1000_main.c:3864 [inline]
>   e1000_clean+0x49d/0x2b00 drivers/net/ethernet/intel/e1000/e1000_main.c:3805
>   __napi_poll+0xc4/0x480 net/core/dev.c:7414
>   napi_poll net/core/dev.c:7478 [inline]
>   net_rx_action+0x707/0xe30 net/core/dev.c:7605
>   handle_softirqs+0x286/0x870 kernel/softirq.c:579
>   do_softirq+0xec/0x180 kernel/softirq.c:480
>   </IRQ>
>   <TASK>
>   __local_bh_enable_ip+0x17d/0x1c0 kernel/softirq.c:407
>   local_bh_enable include/linux/bottom_half.h:33 [inline]
>   rcu_read_unlock_bh include/linux/rcupdate.h:910 [inline]
>   __dev_queue_xmit+0x1cd7/0x3a70 net/core/dev.c:4740
>   neigh_output include/net/neighbour.h:539 [inline]
>   ip6_finish_output2+0x11fb/0x16a0 net/ipv6/ip6_output.c:141
>   __ip6_finish_output net/ipv6/ip6_output.c:-1 [inline]
>   ip6_finish_output+0x234/0x7d0 net/ipv6/ip6_output.c:226
>   rxe_send drivers/infiniband/sw/rxe/rxe_net.c:391 [inline]
>   rxe_xmit_packet+0x79e/0xa30 drivers/infiniband/sw/rxe/rxe_net.c:450
>   rxe_requester+0x1fea/0x3d20 drivers/infiniband/sw/rxe/rxe_req.c:805
>   rxe_sender+0x16/0x50 drivers/infiniband/sw/rxe/rxe_req.c:839
>   do_task drivers/infiniband/sw/rxe/rxe_task.c:127 [inline]
>   do_work+0x1b1/0x6c0 drivers/infiniband/sw/rxe/rxe_task.c:187
>   process_one_work kernel/workqueue.c:3238 [inline]
>   process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3321
>   worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
>   kthread+0x70e/0x8a0 kernel/kthread.c:464
>   ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>   </TASK>
>
>
> ---
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.

