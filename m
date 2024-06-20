Return-Path: <linux-rdma+bounces-3355-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 622CB90FCA4
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2024 08:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48FF81C233D4
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2024 06:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1B939FFE;
	Thu, 20 Jun 2024 06:25:22 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36B71CFA9
	for <linux-rdma@vger.kernel.org>; Thu, 20 Jun 2024 06:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718864722; cv=none; b=ljw0GNAQnPQm7VtZ3eWn4baiHka8wJUSLgonWQojsyVf91GRPHEPdbIzu6xzkmYKVa4LCy0kw0u6u2AjWvq2RvCmRtR+gusI3okOEkzOqvPXD9svvJ9o+xjVCmdyXfZ0H4mwfRb6EsRwa1AcUlzPbulvkzho8v1Czz1OC6lKgsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718864722; c=relaxed/simple;
	bh=6Ls4XYrTe5Xr7nKooWf65gclYifriyDk8xedY6uwVXY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MH2zjLbEJp9tUdtF3XWM7MeXcvWNreyH70itn9hBV69Dle8CaoEvjh5Zr9KGssecw6MrNKssq3zeEgAGgqgjCJGnV9xJ7C36iYuCG+ByD2sPdqK1Z5IsOMenQ7SJp9NWtLM7BMuOSbxc+IpUY2ohoqRufIcUuNCcVrKtPJpk8YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3761cec5b39so5183245ab.0
        for <linux-rdma@vger.kernel.org>; Wed, 19 Jun 2024 23:25:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718864720; x=1719469520;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9AkqDmFbOYmP7G8PlT0VReaJo1PdTS/f1hBoRWmc/Xs=;
        b=APBrdln8yzzuQ8xicWu5kD3SNFDBy0dKRDG9zLyrkxCOt+GYTOBB1KhhvcTlTx4SDG
         Vsln1TacqjgB2xoNJ1PhJajuMIok+WJBHuMfPPb+x8NfHFYwkjwLtlPsU80Ux0cqB7kx
         y7VjhEVDNz0DJpPudyq8RTMA9IvDObU7yd/5CCy6XWxxDrrzpHa7vWWHwNGIVaQhXwws
         xDfeUVsLX/D8gRPSa55mjFiC10Vt6IjPt4bi1qOzD/LYnqUQJY74Q6zLHc2A4gmxhn8j
         5BQ8m94D3j1mdLHh4pQE4caBqwwauROl0evAcx01bXpq3Cl+m+1wl088KxWFJdp1+WnA
         uOvg==
X-Forwarded-Encrypted: i=1; AJvYcCXmfCmfWF3G79Gd3jtf7CRFmGVVw6JiKKbVo5gLzT+NZXdiJn3um0AVK7db4hObIDik72rfw4ZAXYNewzg0ZjHI8XQXyd3gPDOTmQ==
X-Gm-Message-State: AOJu0YyEijcuNA8jt8bvteTokRyoJvr9FjEwEHlgNFENe3kf/iTr4KKa
	gTry90a6TtS1QJoqT7+KCZSJvtnxT2cCkL+Xj/Fx4phqVI0MCozvgegpygqgST31yovoqXGSSqd
	IOQJ2SRVqJcFHBduJl3bMGtjZClC6UGWDuWDspaZXvNgfnKduDWNdXDM=
X-Google-Smtp-Source: AGHT+IElMrpy4IljIE819J4nSDomF7NiLzLJce/SlkO3ussCk682pBZZZOBr5+0JsjnyjbFLiGBg3hQR7Oa4vl3KnbY8VGA0TfEm
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c85:b0:374:70ae:e86e with SMTP id
 e9e14a558f8ab-3761d77047amr2864395ab.6.1718864719966; Wed, 19 Jun 2024
 23:25:19 -0700 (PDT)
Date: Wed, 19 Jun 2024 23:25:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000d0237061b4c6108@google.com>
Subject: [syzbot] [rdma?] WARNING in gid_table_release_one
From: syzbot <syzbot+a35b4afb1f00c45977d0@syzkaller.appspotmail.com>
To: jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a957267fa7e9 Add linux-next specific files for 20240611
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15a085de980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9a880e96898e79f8
dashboard link: https://syzkaller.appspot.com/bug?extid=a35b4afb1f00c45977d0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6451759a606b/disk-a957267f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7f635dbe5b8a/vmlinux-a957267f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/33eafd1b8aec/bzImage-a957267f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a35b4afb1f00c45977d0@syzkaller.appspotmail.com

infiniband syz1: ib_query_port failed (-19)
infiniband syz1: Couldn't set up InfiniBand P_Key/GID cache
------------[ cut here ]------------
GID entry ref leak for dev syz1 index 0 ref=1
WARNING: CPU: 1 PID: 12182 at drivers/infiniband/core/cache.c:809 release_gid_table drivers/infiniband/core/cache.c:806 [inline]
WARNING: CPU: 1 PID: 12182 at drivers/infiniband/core/cache.c:809 gid_table_release_one+0x33f/0x4d0 drivers/infiniband/core/cache.c:886
Modules linked in:
CPU: 1 PID: 12182 Comm: syz-executor.2 Not tainted 6.10.0-rc3-next-20240611-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
RIP: 0010:release_gid_table drivers/infiniband/core/cache.c:806 [inline]
RIP: 0010:gid_table_release_one+0x33f/0x4d0 drivers/infiniband/core/cache.c:886
Code: 03 48 b9 00 00 00 00 00 fc ff df 0f b6 04 08 84 c0 75 3e 41 8b 0c 24 48 c7 c7 40 2b a7 8c 48 89 de 44 89 fa e8 e2 2b d0 f8 90 <0f> 0b 90 90 e9 d3 fe ff ff 44 89 e9 80 e1 07 80 c1 03 38 c1 0f 8c
RSP: 0018:ffffc9000301efe8 EFLAGS: 00010246
RAX: 5c9e4656a81bd600 RBX: ffff88802919e6a0 RCX: 0000000000040000
RDX: ffffc90003581000 RSI: 000000000003b835 RDI: 000000000003b836
RBP: ffff8880294ed0d8 R08: ffffffff81552c42 R09: fffffbfff1c39b10
R10: dffffc0000000000 R11: fffffbfff1c39b10 R12: ffff88801a3b7d00
R13: ffff8880294ed000 R14: 1ffff1100529da1b R15: 0000000000000000
FS:  00007fe09bba36c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b32824000 CR3: 0000000060abc000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ib_device_release+0xd0/0x1b0 drivers/infiniband/core/device.c:498
 device_release+0x99/0x1c0
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x22f/0x480 lib/kobject.c:737
 rxe_net_add+0x93/0xd0 drivers/infiniband/sw/rxe/rxe_net.c:543
 rxe_newlink+0xde/0x1a0 drivers/infiniband/sw/rxe/rxe.c:197
 nldev_newlink+0x5d0/0x640 drivers/infiniband/core/nldev.c:1778
 rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
 rdma_nl_rcv+0x6dd/0x9e0 drivers/infiniband/core/netlink.c:259
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8db/0xcb0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2585
 ___sys_sendmsg net/socket.c:2639 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2668
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe09ae7cea9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe09bba30c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fe09afb3f80 RCX: 00007fe09ae7cea9
RDX: 0000000000000000 RSI: 00000000200002c0 RDI: 0000000000000005
RBP: 00007fe09aeebff4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fe09afb3f80 R15: 00007ffc7e55f608
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

