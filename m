Return-Path: <linux-rdma+bounces-11713-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 143DBAEAE5E
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Jun 2025 07:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BE7A7A6065
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Jun 2025 05:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE391E25F8;
	Fri, 27 Jun 2025 05:09:06 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506C01DE896
	for <linux-rdma@vger.kernel.org>; Fri, 27 Jun 2025 05:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751000945; cv=none; b=BApRzZErPZs2idqy06dq2FTPKX5qBsUjRhA8iYfR92/Jf4wNU84VjTyUsMo6x/nAhVuauxBMEJ4mv1Y4YxXHL+cP939VaTOBqa5YQMihsBvy58nNmPRA7pyF/uuSxvLqdmlx8KpF4r3PHqml0kAxxm+G1L59Y60T3+/l/Erstmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751000945; c=relaxed/simple;
	bh=tS91fUKJnG7xEbHUuJba73xjgk1END/TdxZYugArOqs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=URPY82ZVDwNAhcBa96ZoI64K/bcyszb/1sZtiILL5mCqK4IxWYIWpuFsuYoLyh0tfmajqLc23G5/5lZFC/5h/S+3Ker3ED1tzZVH+V0q5wxa+hrBNws+XPtZm1R1E+wnvmWHdGadKSUFRSdHpk+PJ7gR7kVswH443pUI/WESNQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3ddcc7e8266so25865135ab.0
        for <linux-rdma@vger.kernel.org>; Thu, 26 Jun 2025 22:09:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751000943; x=1751605743;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7SjSHWtKKAWBkyHw90coRJONi4bokcUWVgqJ/CVLeS8=;
        b=eGK/MlFyZDoFf8LQC9wUXbalNE0t3Srfppjr5IJcv8zpYUkV6tSVptN40sODoiLwiu
         CPNqUu3rLvKoSh08X/FPe45MipcFA38dkglnSX6YHBz3o9kUuk4EOaNQfpT0dQCN1+GR
         bT6NgjtapPzZq3gAf3Rhfmz2hv5q6DCdDFAo1b2FmCGsmeQoNEtcsGQMN9naOmLdtDyi
         PEZMCsL4LmYjgdbK81g3dct2IqUyHQLu4NMGuXncz99z4i4IMvPXQ5BBJ5jZgwHU0Ut5
         sKQuBlgJDsV1C9fTlp7PXflTdOPpP3E+eGZrKU0rYZ070670srx1Z0NxODN5fsxrP4cU
         02kw==
X-Forwarded-Encrypted: i=1; AJvYcCWNS6+Q69mslgfKrojnqA+3eQLCobkaHPlg+lgK2OoSA9b5awM23s+AuUcVDvKUK5RrOYpFLjQwCov+@vger.kernel.org
X-Gm-Message-State: AOJu0YxyKeW154oj5HwcJLHYbb496UKpHKRUlNocwoAndp5mquBtQyQU
	Ms1ZA6u+r+yRl6ZkVKff7ahh+MD55rx3rF35Gr/cUKbwR441WWK2pP83UAthul8wOe3Tqzj3/j7
	OgpWI9YPi1vnknHkIJtHNbkUi3YiVf1HrQgysyPcCvqedG/Fr9Fro9aSGnp4=
X-Google-Smtp-Source: AGHT+IFwHpgIzqV9CHS/eJjXj6F4wpRY5pxFrBgLLyDgH8bnh7YnwXfXbWvfrWiBBG37D+yFkuzMfL2lT24ZUbgorOFDPxgEXCeP
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3708:b0:3dd:f02d:2d26 with SMTP id
 e9e14a558f8ab-3df4b3b6f61mr25048595ab.2.1751000943281; Thu, 26 Jun 2025
 22:09:03 -0700 (PDT)
Date: Thu, 26 Jun 2025 22:09:03 -0700
In-Reply-To: <dbcc14cc-abfa-4486-a642-2fe97b4a0ef3@linux.dev>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <685e276f.a00a0220.2e5631.0408.GAE@google.com>
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
WARNING: CPU: 0 PID: 1039 at drivers/infiniband/sw/rxe/rxe_net.c:360 rxe_skb_tx_dtor+0x94/0x2b0 drivers/infiniband/sw/rxe/rxe_net.c:360
Modules linked in:
CPU: 0 UID: 0 PID: 1039 Comm: kworker/u4:7 Not tainted 6.16.0-rc3-syzkaller-gc2b99574e921 #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: rxe_wq do_work
RIP: 0010:rxe_skb_tx_dtor+0x94/0x2b0 drivers/infiniband/sw/rxe/rxe_net.c:360
Code: 80 3c 20 00 74 08 4c 89 ff e8 b8 64 81 f9 4d 8b 37 44 89 f6 83 e6 01 31 ff e8 c8 e5 1d f9 41 f6 c6 01 75 0e e8 dd e0 1d f9 90 <0f> 0b 90 e9 b4 01 00 00 4c 89 ff e8 4c 97 fd 01 48 89 c7 be 0e 00
RSP: 0018:ffffc900000079e8 EFLAGS: 00010246
RAX: ffffffff88a26d93 RBX: ffff88804844d000 RCX: ffff88800037a440
RDX: 0000000000000100 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: ffffffff887bc1c4
R10: dffffc0000000000 R11: ffffffff88a26d00 R12: dffffc0000000000
R13: 1ffff11009089a0b R14: 0000000000025820 R15: ffff8880333d0000
FS:  0000000000000000(0000) GS:ffff88808d250000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f12ddf0ffc8 CR3: 00000000550c0000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 skb_release_head_state+0xfe/0x250 net/core/skbuff.c:1139
 napi_consume_skb+0xd2/0x1e0 net/core/skbuff.c:-1
 e1000_unmap_and_free_tx_resource drivers/net/ethernet/intel/e1000/e1000_main.c:1972 [inline]
 e1000_clean_tx_irq drivers/net/ethernet/intel/e1000/e1000_main.c:3864 [inline]
 e1000_clean+0x49d/0x2b00 drivers/net/ethernet/intel/e1000/e1000_main.c:3805
 __napi_poll+0xc4/0x480 net/core/dev.c:7414
 napi_poll net/core/dev.c:7478 [inline]
 net_rx_action+0x707/0xe30 net/core/dev.c:7605
 handle_softirqs+0x286/0x870 kernel/softirq.c:579
 do_softirq+0xec/0x180 kernel/softirq.c:480
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x17d/0x1c0 kernel/softirq.c:407
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 __neigh_event_send+0x9b/0x1560 net/core/neighbour.c:1194
 neigh_event_send_probe include/net/neighbour.h:463 [inline]
 neigh_event_send include/net/neighbour.h:469 [inline]
 neigh_resolve_output+0x198/0x750 net/core/neighbour.c:1496
 neigh_output include/net/neighbour.h:539 [inline]
 ip6_finish_output2+0x11fb/0x16a0 net/ipv6/ip6_output.c:141
 __ip6_finish_output net/ipv6/ip6_output.c:-1 [inline]
 ip6_finish_output+0x234/0x7d0 net/ipv6/ip6_output.c:226
 rxe_send drivers/infiniband/sw/rxe/rxe_net.c:394 [inline]
 rxe_xmit_packet+0x79e/0xa30 drivers/infiniband/sw/rxe/rxe_net.c:453
 rxe_requester+0x1fea/0x3d20 drivers/infiniband/sw/rxe/rxe_req.c:805
 rxe_sender+0x16/0x50 drivers/infiniband/sw/rxe/rxe_req.c:839
 do_task drivers/infiniband/sw/rxe/rxe_task.c:127 [inline]
 do_work+0x1b4/0x6c0 drivers/infiniband/sw/rxe/rxe_task.c:187
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3321
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


Tested on:

commit:         c2b99574 RDNA/rxe: Fix rxe_skb_tx_dtor problem
git tree:       https://github.com/zhuyj/linux.git v6.16_fix_rxe_skb_tx_dtor
console output: https://syzkaller.appspot.com/x/log.txt?x=12e983d4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=79da270cec5ffd65
dashboard link: https://syzkaller.appspot.com/bug?extid=8425ccfb599521edb153
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6

Note: no patches were applied.

