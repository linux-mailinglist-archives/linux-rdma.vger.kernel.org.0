Return-Path: <linux-rdma+bounces-17333-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHXINo6aomlI4QQAu9opvQ
	(envelope-from <linux-rdma+bounces-17333-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 28 Feb 2026 08:34:38 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A51D1C1121
	for <lists+linux-rdma@lfdr.de>; Sat, 28 Feb 2026 08:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D5C4B30501A9
	for <lists+linux-rdma@lfdr.de>; Sat, 28 Feb 2026 07:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2687336EABE;
	Sat, 28 Feb 2026 07:34:34 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932691A9FAF
	for <linux-rdma@vger.kernel.org>; Sat, 28 Feb 2026 07:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772264074; cv=none; b=dtsNyTyaItnJaq8TzVjRUCn+N06SvDQ8ZVwnIWEayVPE0KAy0CW8dGVAPjQGiUrBPDz3qnVmj8lNM2XVU+3wFPVceZ8NQgTxDXiiPRrzuFFNbEkRCssT6sAgDMHJulP6y6hmdfUfUUZj9qjwYlHs1GH/Q6TfjKe9qdEeuArEglo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772264074; c=relaxed/simple;
	bh=Mrp4TgoPfSaUTanVGAs0KEesojJezHE2qCPFPcCJPXQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=mavgM8PEAD2SIUV5818O/iU4wd9+9vUvx0D76myoLO+crq8ScaPYe46DYkYYnmJSMSSc6h7YBH8juDxYeu+q3FVVniwlZ3ua+fKmg//x6/yMkVIQJLg/SX6NCvupKZ+6MYEGXE3U+8Gncm5UcNlH2So9T6EqbI5OtzJHDGetk+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-679c29b437cso25021262eaf.2
        for <linux-rdma@vger.kernel.org>; Fri, 27 Feb 2026 23:34:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772264071; x=1772868871;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R27OMY8NQ/84Gwe4R5rhN9Q+86t/niigV0jo5326yEk=;
        b=vGrhgO86DwTsn02w+6DAdGQkmyw7yV9Lw7bbEmzHKbjE6dVYuNfZc9SDmII4K7uZNR
         2+FI0v3tGOI6JL0DSheOm5MPLIaYSo3/CxQM/JkWHlr/2jx3xOsg7F08rbtjGnymRrKp
         heyU1XGZjqnmSglXWTWqqa77FsUZECyDI8lavPUIcpSKv1uFRQBcsHu+q2C5BIZnqBhw
         9We5W7k6Uw5d9lKwKMzo62WPHMSEJNgm4cSiRk39JXa8Afma9G76mgXKyFuFCi2sAAoz
         5rMiiR+m+esMmaAlVxG9cW8GFftzBipnEEWnrMB3MTsED1wu2xd8t15wuMhL8FWSISmt
         g5TA==
X-Forwarded-Encrypted: i=1; AJvYcCX+kw0z012J1ApjD3DP86mnbq7jgk6XqaM/fzsmuVHGktTajAaHsBdcQD5c11j4gWSJjuj7QKfMzRCS@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6rtgRhh4Y1V8Q+l6Iysxez0lsxps9UxQe6pU0YZU7NQDIoetu
	5c9hgPLGH5T7rIKd6d0+9/hv6dedj7+BxFzR11o+CyGIZSXgDS0nxThxhZyh9JwKf9mFSgarmPr
	ZFOGyGlVPm8RI1iHXXuIUk6z/Zdes1ahIfuNKPVX0pn5HF/oD/Mc+sbaoFS0=
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4dce:b0:676:96fa:299e with SMTP id
 006d021491bc7-679fadf3c00mr3521374eaf.27.1772264071693; Fri, 27 Feb 2026
 23:34:31 -0800 (PST)
Date: Fri, 27 Feb 2026 23:34:31 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69a29a87.050a0220.3a55be.0033.GAE@google.com>
Subject: [syzbot] [rdma?] kernel BUG in ib_device_get_by_netdev
From: syzbot <syzbot+d4b5f56fae098a9ff611@syzkaller.appspotmail.com>
To: jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=a3fcc8cba4273681];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17333-lists,linux-rdma=lfdr.de,d4b5f56fae098a9ff611];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma];
	R_DKIM_NA(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 3A51D1C1121
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    779cae956c83 Add linux-next specific files for 20260223
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13be455a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a3fcc8cba4273681
dashboard link: https://syzkaller.appspot.com/bug?extid=d4b5f56fae098a9ff611
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8e60025d7912/disk-779cae95.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a9dd1cf82d19/vmlinux-779cae95.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3c0e344b536d/bzImage-779cae95.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d4b5f56fae098a9ff611@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at ./include/rdma/ib_verbs.h:4611!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 1 UID: 0 PID: 7532 Comm: syz.1.433 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
RIP: 0010:ib_device_try_get include/rdma/ib_verbs.h:4611 [inline]
RIP: 0010:ib_device_get_by_netdev+0x529/0x530 drivers/infiniband/core/device.c:2356
Code: 28 f9 48 8b 44 24 38 42 80 3c 30 00 74 08 4c 89 e7 e8 1b ad 92 f9 4d 8b 3c 24 e9 fd fe ff ff e8 2d e4 10 03 e8 28 85 28 f9 90 <0f> 0b 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc9000493e640 EFLAGS: 00010283
RAX: ffffffff889d0d38 RBX: ffff88806d3e5104 RCX: 0000000000080000
RDX: ffffc9000d311000 RSI: 0000000000031136 RDI: 0000000000031137
RBP: ffffc9000493e720 R08: ffffffff889d0891 R09: ffffffff8e7602e0
R10: dffffc0000000000 R11: ffffffff88c6ab20 R12: ffff88807d7251b8
R13: ffff88806d3e4000 R14: dffffc0000000000 R15: 1ffff92000927cd0
FS:  00007fdd927f66c0(0000) GS:ffff88812555e000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055558fbca4e8 CR3: 00000000796b6000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 siw_netdev_event+0x4c/0x170 drivers/infiniband/sw/siw/siw_main.c:374
 notifier_call_chain+0x1be/0x400 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2288 [inline]
 call_netdevice_notifiers net/core/dev.c:2302 [inline]
 netdev_features_change net/core/dev.c:1590 [inline]
 netdev_change_features net/core/dev.c:11097 [inline]
 netdev_compute_master_upper_features+0x91e/0xac0 net/core/dev.c:12869
 bond_enslave+0x21cc/0x3c40 drivers/net/bonding/bond_main.c:2226
 do_set_master+0x533/0x6d0 net/core/rtnetlink.c:2963
 do_setlink+0x1018/0x4590 net/core/rtnetlink.c:3165
 rtnl_changelink net/core/rtnetlink.c:3776 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3935 [inline]
 rtnl_newlink+0x15a9/0x1be0 net/core/rtnetlink.c:4072
 rtnetlink_rcv_msg+0x7d5/0xbe0 net/core/rtnetlink.c:6958
 netlink_rcv_skb+0x232/0x4b0 net/netlink/af_netlink.c:2550
 netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
 netlink_unicast+0x80f/0x9b0 net/netlink/af_netlink.c:1344
 netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1894
 sock_sendmsg_nosec+0x18f/0x1d0 net/socket.c:737
 __sock_sendmsg net/socket.c:752 [inline]
 ____sys_sendmsg+0x589/0x8c0 net/socket.c:2610
 ___sys_sendmsg+0x2a5/0x360 net/socket.c:2664
 __sys_sendmsg net/socket.c:2696 [inline]
 __do_sys_sendmsg net/socket.c:2701 [inline]
 __se_sys_sendmsg net/socket.c:2699 [inline]
 __x64_sys_sendmsg+0x1bd/0x2a0 net/socket.c:2699
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fdd9459c629
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fdd927f6028 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fdd94815fa0 RCX: 00007fdd9459c629
RDX: 0000000000000010 RSI: 0000200000000600 RDI: 0000000000000004
RBP: 00007fdd94632b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fdd94816038 R14: 00007fdd94815fa0 R15: 00007ffc8f7a8198
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ib_device_try_get include/rdma/ib_verbs.h:4611 [inline]
RIP: 0010:ib_device_get_by_netdev+0x529/0x530 drivers/infiniband/core/device.c:2356
Code: 28 f9 48 8b 44 24 38 42 80 3c 30 00 74 08 4c 89 e7 e8 1b ad 92 f9 4d 8b 3c 24 e9 fd fe ff ff e8 2d e4 10 03 e8 28 85 28 f9 90 <0f> 0b 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc9000493e640 EFLAGS: 00010283
RAX: ffffffff889d0d38 RBX: ffff88806d3e5104 RCX: 0000000000080000
RDX: ffffc9000d311000 RSI: 0000000000031136 RDI: 0000000000031137
RBP: ffffc9000493e720 R08: ffffffff889d0891 R09: ffffffff8e7602e0
R10: dffffc0000000000 R11: ffffffff88c6ab20 R12: ffff88807d7251b8
R13: ffff88806d3e4000 R14: dffffc0000000000 R15: 1ffff92000927cd0
FS:  00007fdd927f66c0(0000) GS:ffff88812545e000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f8d20bc3484 CR3: 00000000796b6000 CR4: 00000000003526f0


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

