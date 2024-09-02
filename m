Return-Path: <linux-rdma+bounces-4681-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5438967E46
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Sep 2024 05:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AE6A2821C2
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Sep 2024 03:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8059B14D6F7;
	Mon,  2 Sep 2024 03:46:25 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DCB14AD0A
	for <linux-rdma@vger.kernel.org>; Mon,  2 Sep 2024 03:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725248785; cv=none; b=B+Qv3dxfN2mSEMxADtMJ0I9bx24NgfHwL6YecJm7KNjaeGMvqzskk3+9zDEVSLEZrZG7MqU/LDvhwubWAsmbXmPst0Z6bMIa0q2A2lr3OFsjfxRNU/InK3+xwonZmS0bFdPLypaqBaW4m215pifzB2FsSXHygLROezPbIoL7040=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725248785; c=relaxed/simple;
	bh=ccfd46cBpkEjSM2LjxDI9Y3nT+UHkBr7tm4He8LYYxk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MX06V3zLI68LOPGWnx6eDbEsuKB7bnk+bGO/gu57IGJwToaWYQ+7Yqr52EQyWwzor4bY3DnAd/SbSVbJUfwjoKOlFOtuJkaRzUqIdRCS4P+UIw+P5oPfOy1WABtHu9p7+PFhCV03o6smjo54sxpVxyPAsxZj6Yw6/RQtwqvc7Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82a25b03bb8so386906539f.1
        for <linux-rdma@vger.kernel.org>; Sun, 01 Sep 2024 20:46:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725248782; x=1725853582;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BwEEwZlFL12BxbuJwWxETv9001e1owLvuM6P6c3qF+g=;
        b=SzF5+Bodb/kWBng/BqojwsbRr2TMh0pCcqTwFgRKJi5gpQ3XpcHQlDITDjgro4zWyV
         OWlTR5J0Yi5CRqBUCN/8b2DHhu6rzlRVWBzMq6u8otBbezJW8vbpftbwdRch6eTGRoQ1
         6CBC5X3icac5cLdWX1C7J976Co3LVk/gr8oL4cQ6paCdCH5XnHYWxn536BnkC+o9IXrX
         8dJWUwA5GGrta2NZjO/2Agl0kFTIYsfdKs3lppegCd7N+MRsnJljdHPiB2a15NJCbSD1
         0vvfrKfKXqAdJJZA4tffsuks7UL24HTFenmF71onGvOZryTiNPoY304smoRLTwKPmdpG
         da1g==
X-Forwarded-Encrypted: i=1; AJvYcCVaYXMppsa1LKFTlAlYUagvgS+ZZ577Rotp9yK1XpjRw08bK/4kJWvYXHpSs2ObIVBDdgg02MbXXVV1@vger.kernel.org
X-Gm-Message-State: AOJu0YwS9AOs1QCPm2/ViMihALLPKhicAOO1olduC1S5xqoGv9luHuUD
	dlb7OexcXRzECi1V9+8rYZuLUsWdGCme8RP07gRP20bu7R7sLK3aHWvKevDaYEnsqO+ioNd7OtU
	XFamTMCtPLeQaypsBNuMvrUXkherRhuEBtqRTP3KANBG4A8fzgTIDIQk=
X-Google-Smtp-Source: AGHT+IFLdLRoi5//frYibdpTuTcxxkcR9pFtIa6ASZ15A2L7b4Bo6Q4hmLk86urFgqWGjvTZO2J2lYICLgBYhqTjqdU1RLr8GLn7
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4118:b0:4c0:a90d:4a7c with SMTP id
 8926c6da1cb9f-4d017f16606mr534687173.6.1725248782661; Sun, 01 Sep 2024
 20:46:22 -0700 (PDT)
Date: Sun, 01 Sep 2024 20:46:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d70eed06211ac86b@google.com>
Subject: [syzbot] [rdma?] WARNING in gid_table_release_one (2)
From: syzbot <syzbot+b8b7a6774bf40cf8296b@syzkaller.appspotmail.com>
To: jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    928f79a188aa Merge tag 'loongarch-fixes-6.11-2' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14089643980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9e8c6a00ef394bcf
dashboard link: https://syzkaller.appspot.com/bug?extid=b8b7a6774bf40cf8296b
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-928f79a1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5bf719d3bbf5/vmlinux-928f79a1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/88527595ba7c/bzImage-928f79a1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b8b7a6774bf40cf8296b@syzkaller.appspotmail.com

infiniband syz1: ib_query_port failed (-19)
infiniband syz1: Couldn't set up InfiniBand P_Key/GID cache
------------[ cut here ]------------
GID entry ref leak for dev syz1 index 0 ref=1
WARNING: CPU: 0 PID: 19837 at drivers/infiniband/core/cache.c:806 release_gid_table drivers/infiniband/core/cache.c:806 [inline]
WARNING: CPU: 0 PID: 19837 at drivers/infiniband/core/cache.c:806 gid_table_release_one+0x387/0x4b0 drivers/infiniband/core/cache.c:886
Modules linked in:
CPU: 0 UID: 0 PID: 19837 Comm: syz.1.3934 Not tainted 6.11.0-rc5-syzkaller-00079-g928f79a188aa #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:release_gid_table drivers/infiniband/core/cache.c:806 [inline]
RIP: 0010:gid_table_release_one+0x387/0x4b0 drivers/infiniband/core/cache.c:886
Code: 78 07 00 00 48 85 f6 74 2a 48 89 74 24 38 e8 b0 0a 76 f9 48 8b 74 24 38 44 89 f9 89 da 48 c7 c7 c0 69 51 8c e8 5a c3 38 f9 90 <0f> 0b 90 90 e9 6f fe ff ff e8 8b 0a 76 f9 49 8d bc 24 28 07 00 00
RSP: 0018:ffffc900042b7080 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffc9002811e000
RDX: 0000000000040000 RSI: ffffffff814dd406 RDI: 0000000000000001
RBP: ffff88807ebaaf00 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffff888051860000
R13: dffffc0000000000 R14: ffffed100fd755fb R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff88802c000000(0063) knlGS:00000000f56c6b40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 000000002effcff8 CR3: 0000000060c5e000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ib_device_release+0xef/0x1e0 drivers/infiniband/core/device.c:498
 device_release+0xa1/0x240 drivers/base/core.c:2582
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1e4/0x5a0 lib/kobject.c:737
 put_device+0x1f/0x30 drivers/base/core.c:3790
 rxe_net_add+0xe0/0x110 drivers/infiniband/sw/rxe/rxe_net.c:544
 rxe_newlink+0x70/0x190 drivers/infiniband/sw/rxe/rxe.c:197
 nldev_newlink+0x373/0x5e0 drivers/infiniband/core/nldev.c:1794
 rdma_nl_rcv_msg+0x388/0x6e0 drivers/infiniband/core/netlink.c:195
 rdma_nl_rcv_skb.constprop.0.isra.0+0x2e6/0x450 drivers/infiniband/core/netlink.c:239
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x53c/0x7f0 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 ____sys_sendmsg+0x9b4/0xb50 net/socket.c:2597
 ___sys_sendmsg+0x135/0x1e0 net/socket.c:2651
 __sys_sendmsg+0x117/0x1f0 net/socket.c:2680
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf7f20579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f56c656c EFLAGS: 00000296 ORIG_RAX: 0000000000000172
RAX: ffffffffffffffda RBX: 0000000000000008 RCX: 00000000200003c0
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000296 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	10 06                	adc    %al,(%rsi)
   2:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
   6:	10 07                	adc    %al,(%rdi)
   8:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   c:	10 08                	adc    %cl,(%rax)
   e:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  1e:	00 51 52             	add    %dl,0x52(%rcx)
  21:	55                   	push   %rbp
  22:	89 e5                	mov    %esp,%ebp
  24:	0f 34                	sysenter
  26:	cd 80                	int    $0x80
* 28:	5d                   	pop    %rbp <-- trapping instruction
  29:	5a                   	pop    %rdx
  2a:	59                   	pop    %rcx
  2b:	c3                   	ret
  2c:	90                   	nop
  2d:	90                   	nop
  2e:	90                   	nop
  2f:	90                   	nop
  30:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  37:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi


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

