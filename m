Return-Path: <linux-rdma+bounces-9951-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED27AA6E83
	for <lists+linux-rdma@lfdr.de>; Fri,  2 May 2025 11:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2DD09A64D8
	for <lists+linux-rdma@lfdr.de>; Fri,  2 May 2025 09:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F6A23184A;
	Fri,  2 May 2025 09:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="he/Xkw6I"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DC223182E
	for <linux-rdma@vger.kernel.org>; Fri,  2 May 2025 09:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746179680; cv=none; b=eEwlnD2tCPKe7L6tKSgw4k1HasiGn/BwGGK1nIlAG6L5QloyODKjSSFUhf7F25j1i5Z5/WL4DDj53RoJNHy7vkQder/K4Ue5ndvsa1pyKJ5jM1H+dAgidkpDpZfwkRA/TpIoXYsZ/jp/33jqgPvsrga/9bS1UCVx4VW/pKNqlEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746179680; c=relaxed/simple;
	bh=3LU789saYyrutCozDG0IOlxxmIN4Z1wthUFZjP4Ozbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=P/YF4KAKi04j/zR1Y8E4Vf8FpSAJRW+iwFa1Sfc9Yk+zzlXnjF7agAdwXlqWfq+GbQPeueu4hYfV2zu/I/IXzKhhzimAXYDd1JabZnwyskoLc4N6CcoBM5ZdS666RAizwNTRBO8PE4ugli06ojR7qgdegGbY6wtp4J4ccphIPE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=he/Xkw6I; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <64c14861-c7ef-4608-9e12-4567775bc5af@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746179665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+yfmn0tK+qTWIj7LV5pZmbdVGhS233Htkxsoag4Qbfs=;
	b=he/Xkw6IHpnh5DFcegTV1kjxZyzUViCF0HeVZJfHd7nZG5VBoVd/NqeMJj7Iu4gWuiLsFY
	gFvkkKLg01jjL42Nk+vnGqzdJGhTi98/NewFAuxP5+Z3JJ319nCmIB2wemEw11z5Fzo90e
	Bh2XJ0OBcUPlVLlGKNl9KJ2eNWPaMS8=
Date: Fri, 2 May 2025 11:54:22 +0200
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
References: <6813a531.050a0220.14dd7d.0018.GAE@google.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <6813a531.050a0220.14dd7d.0018.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 01.05.25 18:45, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    8bac8898fe39 Merge tag 'mmc-v6.15-rc1' of git://git.kernel..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=16b6d774580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a9a25b7a36123454
> dashboard link: https://syzkaller.appspot.com/bug?extid=8425ccfb599521edb153
> compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-8bac8898.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/2a76d594c0f5/vmlinux-8bac8898.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/dae09c25780d/bzImage-8bac8898.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+8425ccfb599521edb153@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 1046 at drivers/infiniband/sw/rxe/rxe_net.c:357 rxe_skb_tx_dtor+0x8b/0x2a0 drivers/infiniband/sw/rxe/rxe_net.c:357

This is a known problem. It seems to be related with the following commit.

commit 1a633bdc8fd9e9e4a9f9a668ae122edfc5aacc86
Author: Bob Pearson <rpearsonhpe@gmail.com>
Date:   Fri Mar 29 09:55:15 2024 -0500

     RDMA/rxe: Let destroy qp succeed with stuck packet

     In some situations a sent packet may get queued in the NIC longer than
     than timeout of a ULP. Currently if this happens the ULP may try to 
reset
     the link by destroying the qp and setting up an alternate 
connection but
     will fail because the rxe driver is waiting for the packet to finish
     getting sent and be returned to the skb destructor function where 
the qp
     reference holding things up will be dropped. This patch modifies 
the way
     that the qp is passed to the destructor to pass the qp index and 
not a qp
     pointer.  Then the destructor will attempt to lookup the qp from 
its index
     and if it fails exit early. This requires taking a reference on the 
struct
     sock rather than the qp allowing the qp to be destroyed while the sk is
     still around waiting for the packet to finish.

     Link: 
https://lore.kernel.org/r/20240329145513.35381-15-rpearsonhpe@gmail.com
     Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
     Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Zhu Yanjun

> Modules linked in:
> CPU: 0 UID: 0 PID: 1046 Comm: kworker/u4:9 Not tainted 6.15.0-rc4-syzkaller-00040-g8bac8898fe39 #0 PREEMPT(full)
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> Workqueue: rxe_wq do_work
> RIP: 0010:rxe_skb_tx_dtor+0x8b/0x2a0 drivers/infiniband/sw/rxe/rxe_net.c:357
> Code: 80 3c 20 00 74 08 4c 89 ff e8 41 ee 8c f9 4d 8b 37 44 89 f6 83 e6 01 31 ff e8 11 fe 2a f9 41 f6 c6 01 75 0e e8 26 f9 2a f9 90 <0f> 0b 90 e9 b4 01 00 00 4c 89 ff e8 35 c4 fa 01 48 89 c7 be 0e 00
> RSP: 0018:ffffc90000007a08 EFLAGS: 00010246
> RAX: ffffffff8894c5aa RBX: ffff88803ec8d280 RCX: ffff888035088000
> RDX: 0000000000000100 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: ffffffff886e3f04 R12: dffffc0000000000
> R13: 1ffff11007d91a5b R14: 0000000000025820 R15: ffff888034060000
> FS:  0000000000000000(0000) GS:ffff88808d6cc000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f7c6d874fc8 CR3: 00000000428c8000 CR4: 0000000000352ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   <IRQ>
>   skb_release_head_state+0xfe/0x250 net/core/skbuff.c:1149
>   napi_consume_skb+0xd2/0x1e0 net/core/skbuff.c:-1
>   e1000_unmap_and_free_tx_resource drivers/net/ethernet/intel/e1000/e1000_main.c:1972 [inline]
>   e1000_clean_tx_irq drivers/net/ethernet/intel/e1000/e1000_main.c:3864 [inline]
>   e1000_clean+0x49d/0x2b00 drivers/net/ethernet/intel/e1000/e1000_main.c:3805
>   __napi_poll+0xc4/0x480 net/core/dev.c:7324
>   napi_poll net/core/dev.c:7388 [inline]
>   net_rx_action+0x6ea/0xdf0 net/core/dev.c:7510
>   handle_softirqs+0x283/0x870 kernel/softirq.c:579
>   do_softirq+0xec/0x180 kernel/softirq.c:480
>   </IRQ>
>   <TASK>
>   __local_bh_enable_ip+0x17d/0x1c0 kernel/softirq.c:407
>   local_bh_enable include/linux/bottom_half.h:33 [inline]
>   rcu_read_unlock_bh include/linux/rcupdate.h:910 [inline]
>   __dev_queue_xmit+0x1cd7/0x3a70 net/core/dev.c:4656
>   neigh_output include/net/neighbour.h:539 [inline]
>   ip6_finish_output2+0x11fb/0x16a0 net/ipv6/ip6_output.c:141
>   __ip6_finish_output net/ipv6/ip6_output.c:-1 [inline]
>   ip6_finish_output+0x234/0x7d0 net/ipv6/ip6_output.c:226
>   rxe_send drivers/infiniband/sw/rxe/rxe_net.c:391 [inline]
>   rxe_xmit_packet+0x79e/0xa30 drivers/infiniband/sw/rxe/rxe_net.c:450
>   rxe_requester+0x1fea/0x3d20 drivers/infiniband/sw/rxe/rxe_req.c:805
>   rxe_sender+0x16/0x50 drivers/infiniband/sw/rxe/rxe_req.c:839
>   do_task+0x1ad/0x6b0 drivers/infiniband/sw/rxe/rxe_task.c:127
>   process_one_work kernel/workqueue.c:3238 [inline]
>   process_scheduled_works+0xadb/0x17a0 kernel/workqueue.c:3319
>   worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
>   kthread+0x70e/0x8a0 kernel/kthread.c:464
>   ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>   </TASK>
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


