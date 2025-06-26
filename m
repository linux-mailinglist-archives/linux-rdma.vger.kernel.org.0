Return-Path: <linux-rdma+bounces-11702-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 918B4AEAA20
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Jun 2025 00:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6EBE1885236
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jun 2025 22:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF33201113;
	Thu, 26 Jun 2025 22:54:06 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAF61917FB
	for <linux-rdma@vger.kernel.org>; Thu, 26 Jun 2025 22:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750978446; cv=none; b=Df0REytCkYs6dAmERd4IKMrKrp/HSWVc3i5QxG3r44xb5vzSnc6ZQQErWclBSoNOvhREBn87A5X7MjEwnEDKmbpLRBykWB4P6Iim73e2ft0b9IAwGDSNsLSUwG9Xia3zYDWM98abK+npfOBxREHRDAwIUkiqKlorxPnVHgRcdUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750978446; c=relaxed/simple;
	bh=QlETPmLKJ5wuuOZ0mip2MITO1Lvw1vGgGhJsAXrwaoM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=B/nA/tDWycxdLBtcDs5MvZsqnIefJa+Rx8CNVQjmn0GDKTjVbKGgPlk6aTbOUzH5ir50BQjMzorhNoU71sFbb8k4j2L1ppgkOuO0B1wmmJxExz63nu8W0PgABfs+mHteNonkKMS2WAHwejNj6dERBxkQIMr9tY1KQZwNaC1r0Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3ddc147611fso35410005ab.3
        for <linux-rdma@vger.kernel.org>; Thu, 26 Jun 2025 15:54:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750978444; x=1751583244;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cNpfT6ibDRY0Y1o29N5gMsrBI9DUrvOGsxJBMGuBz4c=;
        b=nXj9QjzwSCNx6CCvYtabJxa9PKRl/QxYVZVDrMTzxVBmmddsZiAfDvpPTSFUeCY9Es
         wlH9CbMdnh7WxpOvs4rG/jFKWXgcFM5zd8feHQKScQ/7pwCOG94eD6apM/zwFrr9g458
         ofhiF7wBqBD7vlh0/Oh7qQqQvhckR9U+8Y/qLpd//24HnDNmSsMiCuwDKZ95d/NNdDSH
         Yf2dLhgn9Xiy2V7KgXUCRUfdCSntwetR+lpcFzyhptfLqwQD/bLazli4TZ+L3UQxHAZ0
         n0iVgi0lBJbl9C2f96wXyx7xieYOsqAsEhFJTnEamj+vIp408bbB0wHvbHlmqe29/+xX
         mF1w==
X-Forwarded-Encrypted: i=1; AJvYcCXndVn+1e0iq74sMDylXXnyLtMxU3T544Ho6Gc7spPqXLE8ToT0v1cphLYUqXU5n57SqhYYpAKJlJZK@vger.kernel.org
X-Gm-Message-State: AOJu0YzFbby8GZXvFy+AVWYnPrmqm8ldsyt/bXOP46a5C5RdrpaU53kO
	I9dPb0+YOl1zpSUD3aZPhBhsRb7VhQy5k8pLTfknAhALHNlflCKZ56knW64OVw6UGzPtJRU3yMy
	YC6TvOlgUdPodb73gh9cG11hdk5Pa1X38wnuBQdggNySCTIe/9iOiVTCixD4=
X-Google-Smtp-Source: AGHT+IHxGXrwL2GZPqC8dWhafW/ishAVfJhDvJUIN+TmKhFXbzw1bS/15W/YG6sDtN3g8OxoavAn3JYsyw81O4zqJXNf3MXhckEM
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c2a:b0:3dd:b523:7abe with SMTP id
 e9e14a558f8ab-3df4abafbe6mr18925865ab.18.1750978444108; Thu, 26 Jun 2025
 15:54:04 -0700 (PDT)
Date: Thu, 26 Jun 2025 15:54:04 -0700
In-Reply-To: <f59b4048-a4e3-4d7d-8aa9-5a3ad42db8b7@linux.dev>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <685dcf8c.a00a0220.2e5631.038a.GAE@google.com>
Subject: Re: [syzbot] [rdma?] WARNING in rxe_skb_tx_dtor
From: syzbot <syzbot+8425ccfb599521edb153@syzkaller.appspotmail.com>
To: jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	yanjun.zhu@linux.dev, zyjzyj2000@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in rxe_skb_tx_dtor

------------[ cut here ]------------
WARNING: CPU: 0 PID: 1093 at drivers/infiniband/sw/rxe/rxe_net.c:357 rxe_skb_tx_dtor+0x8b/0x2a0 drivers/infiniband/sw/rxe/rxe_net.c:357
Modules linked in:
CPU: 0 UID: 0 PID: 1093 Comm: kworker/u4:9 Not tainted 6.15.0-rc4-syzkaller-00150-ge382eacdcc20 #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: rxe_wq do_work
RIP: 0010:rxe_skb_tx_dtor+0x8b/0x2a0 drivers/infiniband/sw/rxe/rxe_net.c:357
Code: 80 3c 20 00 74 08 4c 89 ff e8 91 fd 89 f9 4d 8b 37 44 89 f6 83 e6 01 31 ff e8 61 41 27 f9 41 f6 c6 01 75 0e e8 76 3c 27 f9 90 <0f> 0b 90 e9 b4 01 00 00 4c 89 ff e8 85 0d fb 01 48 89 c7 be 0e 00
RSP: 0018:ffffc90000007a08 EFLAGS: 00010246
RAX: ffffffff8898ce3a RBX: ffff888043ae33c0 RCX: ffff88803513a440
RDX: 0000000000000100 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: ffffffff88723ee4 R12: dffffc0000000000
R13: 1ffff1100875c683 R14: 0000000000025820 R15: ffff888035198000
FS:  0000000000000000(0000) GS:ffff88808d6b1000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f31350a7fc8 CR3: 0000000059b8c000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 skb_release_head_state+0xfe/0x250 net/core/skbuff.c:1149
 napi_consume_skb+0xd2/0x1e0 net/core/skbuff.c:-1
 e1000_unmap_and_free_tx_resource drivers/net/ethernet/intel/e1000/e1000_main.c:1972 [inline]
 e1000_clean_tx_irq drivers/net/ethernet/intel/e1000/e1000_main.c:3864 [inline]
 e1000_clean+0x49d/0x2b00 drivers/net/ethernet/intel/e1000/e1000_main.c:3805
 __napi_poll+0xc4/0x480 net/core/dev.c:7324
 napi_poll net/core/dev.c:7388 [inline]
 net_rx_action+0x6ea/0xdf0 net/core/dev.c:7510
 handle_softirqs+0x283/0x870 kernel/softirq.c:579
 do_softirq+0xec/0x180 kernel/softirq.c:480
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x17d/0x1c0 kernel/softirq.c:407
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 rcu_read_unlock_bh include/linux/rcupdate.h:910 [inline]
 __dev_queue_xmit+0x1cd7/0x3a70 net/core/dev.c:4656
 neigh_output include/net/neighbour.h:539 [inline]
 ip6_finish_output2+0x11fb/0x16a0 net/ipv6/ip6_output.c:141
 __ip6_finish_output net/ipv6/ip6_output.c:-1 [inline]
 ip6_finish_output+0x234/0x7d0 net/ipv6/ip6_output.c:226
 rxe_send drivers/infiniband/sw/rxe/rxe_net.c:391 [inline]
 rxe_xmit_packet+0x79e/0xa30 drivers/infiniband/sw/rxe/rxe_net.c:450
 rxe_requester+0x1fea/0x3d20 drivers/infiniband/sw/rxe/rxe_req.c:805
 rxe_sender+0x16/0x50 drivers/infiniband/sw/rxe/rxe_req.c:839
 do_task+0x1ad/0x6b0 drivers/infiniband/sw/rxe/rxe_task.c:127
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xadb/0x17a0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


Tested on:

commit:         e382eacd RDNA/rxe: Fix rxe_skb_tx_dtor problem
git tree:       https://github.com/zhuyj/linux.git linux-6.15-rc4-fix-rxe_skb_tx_dtor
console output: https://syzkaller.appspot.com/x/log.txt?x=14a83b70580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bf156ad608427e4b
dashboard link: https://syzkaller.appspot.com/bug?extid=8425ccfb599521edb153
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6

Note: no patches were applied.

