Return-Path: <linux-rdma+bounces-7507-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A78A2BAD0
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 06:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0527E3A7D44
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 05:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A0B1422A8;
	Fri,  7 Feb 2025 05:45:25 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4A1233D85
	for <linux-rdma@vger.kernel.org>; Fri,  7 Feb 2025 05:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738907125; cv=none; b=d4XvnHmZfWY6UKtZ9dWptqliBCST8OiYqAGESkSbNskErpQ0osaGLpAyhm44Oh0/6UfDaTcJKpwWryX7kgnV3/K5+6hQkayCFfzzIhTffpT/tMqdUMJk1aHA1fliBa/Ob7XO88Oqsajr1CJBw988iXB8MkdTYGDhLKZk+6Idb3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738907125; c=relaxed/simple;
	bh=yNAklZeUoXRJTrPWxkmW/j1+cyi+Qc/2qy0zSBz6qMg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mCYwS2PBjharWhayD1wRp98r4XhrORf6r11NmKGW1qzqNP6PcdwRnUCYIlMA3Mn3UuOXx6MrqI6NWHq9clkC7xGj8bgao2tFwxiqQGvgq269Ui0RiKdmrbHg2mDgzXSMCkC/l6aT/q8EzI5/bID32f66m36kROxd9VSjplROhIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-849d26dd331so197454639f.1
        for <linux-rdma@vger.kernel.org>; Thu, 06 Feb 2025 21:45:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738907123; x=1739511923;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/aJk6I7huKkph+gkza4v3eeiMOL1KM+4rXTTfmnphr4=;
        b=qAxeGTPx+31qTrApFkGByNPcBQSC2w9wEhOpB6DWIc3AVEhgfIMZHCQUfe/1/u0EPR
         n05rCpnox100AvT0LhP6UgHxkjBfEjOysspSpbfYeM+hrrqp+Yxbz0IXpXveG5K27Hw+
         3PqaCTfWhDSh+8r4Na4BeAdrRHlHl40bali8g+QSpihovGnqVMPel8aQnU1w0Vz0yNrb
         5BYwsTm5HoKAhs8qYs/JmMWhM7EjYazwKT1t56529sqasuMOOpmfIU2RZfu2+53QoFBP
         7GiG/wwtgNfAXDv58DhMhFbDrh72yGVcvQc4rC8NkWONSu3z8w0ovjGRMYRo0cScEqVM
         3UMw==
X-Forwarded-Encrypted: i=1; AJvYcCXXiPNkAJRkW7s65dHmBkSRtnDMPUSMNgk72nZXvOvZ2ui+N5WlxjK3mERd9KDJBoeGe5q92GD9HStj@vger.kernel.org
X-Gm-Message-State: AOJu0YzDzUcVndF/5VwfH2uxnttteFzqcWiTT7OjSwXjOA8lRM6Zzejh
	1yqZjEpf0b9uiF3Qmzk2A7HqUYHakWxaxYW98QL/aXe0yM1LREptzkR90/NBAEKbLTInTFBmMCP
	GxUyPiwjRyWD20/g/LviYia8VlYnJeUiYm4usDn/Ju6nidJn2ZtnY8lM=
X-Google-Smtp-Source: AGHT+IGFIGmrTvw1U5QxWHgPk02dBW1cRvFUdYDrEASXoksl0fVn8jXzYyE8WJ+HzAkGg6+1iBYHsfaHo1/LhvYWBwas8BhadUaM
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a01:b0:3a9:cde3:2ecc with SMTP id
 e9e14a558f8ab-3d05a689690mr53786515ab.6.1738907123178; Thu, 06 Feb 2025
 21:45:23 -0800 (PST)
Date: Thu, 06 Feb 2025 21:45:23 -0800
In-Reply-To: <00000000000086d0e406184c8e78@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67a59df3.050a0220.2b1e6.0011.GAE@google.com>
Subject: Re: [syzbot] [rdma?] WARNING in rxe_pool_cleanup
From: syzbot <syzbot+221e213bf17f17e0d6cd@syzkaller.appspotmail.com>
To: jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, yanjun.zhu@linux.dev, zyjzyj2000@gmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    bb066fe812d6 Merge tag 'pci-v6.14-fixes-2' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16a973df980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1909f2f0d8e641ce
dashboard link: https://syzkaller.appspot.com/bug?extid=221e213bf17f17e0d6cd
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11a01df8580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-bb066fe8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ac7155966351/vmlinux-bb066fe8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/92d6cbf35949/bzImage-bb066fe8.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+221e213bf17f17e0d6cd@syzkaller.appspotmail.com

smc: removing ib device syz0
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5645 at drivers/infiniband/sw/rxe/rxe_pool.c:116 rxe_pool_cleanup+0x47/0x50 drivers/infiniband/sw/rxe/rxe_pool.c:116
Modules linked in:
CPU: 0 UID: 0 PID: 5645 Comm: syz.0.16 Not tainted 6.14.0-rc1-syzkaller-00081-gbb066fe812d6 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:rxe_pool_cleanup+0x47/0x50 drivers/infiniband/sw/rxe/rxe_pool.c:116
Code: 00 00 fc ff df 80 3c 08 00 74 08 48 89 df e8 10 aa 1a f9 48 83 3b 00 75 0b e8 95 11 b4 f8 5b c3 cc cc cc cc e8 8a 11 b4 f8 90 <0f> 0b 90 5b c3 cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc9000ce370e8 EFLAGS: 00010293
RAX: ffffffff890b4c96 RBX: ffff888052855380 RCX: ffff88801f3e8000
RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffff888052855300
RBP: 0000000000000002 R08: ffffffff88e3bcc3 R09: 1ffff1100a50a8ee
R10: dffffc0000000000 R11: ffffffff89096000 R12: dffffc0000000000
R13: dffffc0000000000 R14: ffff888052854658 R15: dffffc0000000000
FS:  00007fc32943e6c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc32943dfe0 CR3: 00000000405a6000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 rxe_dealloc+0x33/0x100 drivers/infiniband/sw/rxe/rxe.c:24
 ib_dealloc_device+0x50/0x200 drivers/infiniband/core/device.c:647
 __ib_unregister_device+0x366/0x3d0 drivers/infiniband/core/device.c:1520
 ib_unregister_device_and_put+0xb9/0xf0 drivers/infiniband/core/device.c:1567
 nldev_dellink+0x2c6/0x310 drivers/infiniband/core/nldev.c:1825
 rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
 rdma_nl_rcv+0x6dd/0x9e0 drivers/infiniband/core/netlink.c:259
 netlink_unicast_kernel net/netlink/af_netlink.c:1322 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1348
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1892
 sock_sendmsg_nosec net/socket.c:713 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:728
 ____sys_sendmsg+0x52a/0x7e0 net/socket.c:2568
 ___sys_sendmsg net/socket.c:2622 [inline]
 __sys_sendmsg+0x269/0x350 net/socket.c:2654
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc32858cde9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc32943e038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fc3287a6160 RCX: 00007fc32858cde9
RDX: 0000000020000000 RSI: 0000200000000000 RDI: 0000000000000004
RBP: 00007fc32860e2a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fc3287a6160 R15: 00007ffc02559df8
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

