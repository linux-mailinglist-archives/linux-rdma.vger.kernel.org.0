Return-Path: <linux-rdma+bounces-999-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 459BE8510CE
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Feb 2024 11:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F887B24E9D
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Feb 2024 10:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF8237179;
	Mon, 12 Feb 2024 10:26:27 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CBB2C870
	for <linux-rdma@vger.kernel.org>; Mon, 12 Feb 2024 10:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707733587; cv=none; b=rH7cMuQb54FchcD0yZhiixv/R2W4lflDJcyx/q7DZ0hZanJp2enMXRHvnKlvkqRGBRhnmLDigKvJYnwfDXqjSgHV5+wZm4CD9ZUkNYr6duwkhq1ZckaCYCagfBiHDe2W7Yo1eIf9c153Gg+AeK1RZnw13id90/MGs4LRyEKYPnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707733587; c=relaxed/simple;
	bh=+mjFm5nuMFtGmd7VSuVSWTR7s1VOXRYw4CPk4dsKHBw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=tpJ3d56qhXtGVn7eZRMtxm2BLDJVfN8/QC2rH50bKdsAwV1xXcFR2hHCqe9CGcZYmZVruOLL2hJtGQi8+3jLPBT6LrvGCLRQ3QY596BLvuub4FD2f3DoDF0Eq5Nu/osdQq+xgSBOLXHE2fuxIF4QVK/ySm5CE5L6UPcMnZkuyDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-363d6348a07so26687795ab.3
        for <linux-rdma@vger.kernel.org>; Mon, 12 Feb 2024 02:26:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707733584; x=1708338384;
        h=content-transfer-encoding:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vDurUD372HRJxmeXSQF7cfLsM+JRV83tAlhXhyo/df0=;
        b=F3N2TcG2IbJRSq4vxsGYHnEzQdn7aCWQNzgOfwRKNyKvPKO6qn70TIN0dG/PWAsVUp
         OPPa/cyHuzeQMR3BOPqm6Ax7yTn3k6KHViHi66BKDvE5y+PsJt9HToae6e/V19n6wwKT
         D/0NHVVO92VxcmnMRTQjiaBDlbLA919Ajog9Mr8scdUyFwlvXMlWRe6WmCM4YbJ0DFwN
         x1qJzVdWvcvQ+Ar+5CCeotkY5WLolINklMPlA+miOEo+oUrVl10wiSZ5/N0htjdG2cuR
         IjIqccpxjXSkelMC6g3U+FgYbfJLrpWyQfKHFDPOd98pXFtb0bmIYLR2wNX829HGYjya
         D56g==
X-Forwarded-Encrypted: i=1; AJvYcCUOJ66VV1uGtYww59CxQ6Gi1hKiEELo4YOH7Ed5QWeH3KQw7xXqVKThqhRhAXj1c3pcnV/IbTkjrh5PK+cBijFS7azMR6BdRGyZew==
X-Gm-Message-State: AOJu0YxUiK9QcdpjJCwe+mqFUK6QYrr7btelpetzQ8DzJNxLG+ki3oGf
	suahhrxhMLO3Ite1CLm4fZaN9zgAsbnFeCcjbmRfcbYxMFPJL4huGvzca2mLiHnT4uN1Z2dyFZ7
	Js2ZpgGLT5ZYFOMT8I4o/kdzTv6gIiRCOak5Wvm4qHzVXR0wsknjqCU8=
X-Google-Smtp-Source: AGHT+IFOg0dq76d8mUpJQh2S5UBdwB8eUZtsYdpCGHHlhw7n2SnBCSMtgzF25Xofz1YTxEEB3nsNVYPmiXDaVI+RZBQamxdH69Gg
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1bc7:b0:363:e134:a158 with SMTP id
 x7-20020a056e021bc700b00363e134a158mr454179ilv.5.1707733584807; Mon, 12 Feb
 2024 02:26:24 -0800 (PST)
Date: Mon, 12 Feb 2024 02:26:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b18dd106112cb53c@google.com>
Subject: [syzbot] [rdma?] WARNING: ODEBUG bug in siw_netdev_event
From: syzbot <syzbot+e7c51d3be3a5ddfa0d7a@syzkaller.appspotmail.com>
To: bmt@zurich.ibm.com, jgg@ziepe.ca, leon@kernel.org, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot found the following issue on:

HEAD commit:    b1d3a0e70c38 Add linux-next specific files for 20240208
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=3D1325c020180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dbb693ba195662a0=
6
dashboard link: https://syzkaller.appspot.com/bug?extid=3De7c51d3be3a5ddfa0=
d7a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/176a6b395bbe/disk-=
b1d3a0e7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/02d7d46f81bd/vmlinux-=
b1d3a0e7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/18a5a5030e19/bzI=
mage-b1d3a0e7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit=
:
Reported-by: syzbot+e7c51d3be3a5ddfa0d7a@syzkaller.appspotmail.com

netlink: 'syz-executor.1': attribute type 27 has an invalid length.
netlink: 4 bytes leftover after parsing attributes in process `syz-executor=
.1'.
=1F: port 3(erspan0) entered disabled state
------------[ cut here ]------------
ODEBUG: init active (active state 0) object: ffff88802de95128 object type: =
work_struct hint: siw_netdev_down+0x0/0x1f0
WARNING: CPU: 1 PID: 16397 at lib/debugobjects.c:517 debug_print_object+0x1=
7a/0x1f0 lib/debugobjects.c:514
Modules linked in:
CPU: 1 PID: 16397 Comm: syz-executor.1 Not tainted 6.8.0-rc3-next-20240208-=
syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 01/25/2024
RIP: 0010:debug_print_object+0x17a/0x1f0 lib/debugobjects.c:514
Code: e8 1b e3 4d fd 4c 8b 0b 48 c7 c7 00 89 fe 8b 48 8b 74 24 08 48 89 ea =
44 89 e1 4d 89 f8 ff 34 24 e8 2b 97 ae fc 48 83 c4 08 90 <0f> 0b 90 90 ff 0=
5 bc 2f dd 0a 48 83 c4 10 5b 41 5c 41 5d 41 5e 41
RSP: 0018:ffffc90014536758 EFLAGS: 00010282
RAX: 5f296badc3198f00 RBX: ffffffff8ba9e6a0 RCX: 0000000000040000
RDX: ffffc90004f8b000 RSI: 000000000003ffff RDI: 0000000000040000
RBP: ffffffff8bfe8a80 R08: ffffffff8157b862 R09: fffffbfff1bf95c4
R10: dffffc0000000000 R11: fffffbfff1bf95c4 R12: 0000000000000000
R13: ffffffff8bfe8998 R14: dffffc0000000000 R15: ffff88802de95128
FS:  00007fc00b12a6c0(0000) GS:ffff8880b9500000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa1fd40f000 CR3: 000000003e1a6000 CR4: 00000000003506f0
DR0: 000000000000d8dd DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __debug_object_init+0x2a9/0x400 lib/debugobjects.c:653
 siw_device_goes_down drivers/infiniband/sw/siw/siw_main.c:395 [inline]
 siw_netdev_event+0x3bd/0x620 drivers/infiniband/sw/siw/siw_main.c:422
 notifier_call_chain+0x18f/0x3b0 kernel/notifier.c:93
 call_netdevice_notifiers_extack net/core/dev.c:2012 [inline]
 call_netdevice_notifiers net/core/dev.c:2026 [inline]
 __dev_close_many+0x146/0x300 net/core/dev.c:1512
 __dev_close net/core/dev.c:1550 [inline]
 __dev_change_flags+0x30e/0x6f0 net/core/dev.c:8683
 dev_change_flags+0x8b/0x1a0 net/core/dev.c:8757
 do_setlink+0xcb0/0x41c0 net/core/rtnetlink.c:2894
 rtnl_group_changelink net/core/rtnetlink.c:3443 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3702 [inline]
 rtnl_newlink+0x1117/0x20a0 net/core/rtnetlink.c:3739
 rtnetlink_rcv_msg+0x885/0x1040 net/core/rtnetlink.c:6606
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2543
 netlink_unicast_kernel net/netlink/af_netlink.c:1341 [inline]
 netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1367
 netlink_sendmsg+0xa3c/0xd70 net/netlink/af_netlink.c:1908
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2584
 ___sys_sendmsg net/socket.c:2638 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2667
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7fc00a47dda9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 =
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff f=
f 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc00b12a0c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fc00a5ac1f0 RCX: 00007fc00a47dda9
RDX: 0000000000000000 RSI: 0000000020006440 RDI: 0000000000000005
RBP: 00007fc00a4ca47a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007fc00a5ac1f0 R15: 00007fff19fc38d8
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

