Return-Path: <linux-rdma+bounces-17680-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Np/NEIcrGnPkwEAu9opvQ
	(envelope-from <linux-rdma+bounces-17680-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 07 Mar 2026 13:38:26 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 431F422BB6E
	for <lists+linux-rdma@lfdr.de>; Sat, 07 Mar 2026 13:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8026C3016811
	for <lists+linux-rdma@lfdr.de>; Sat,  7 Mar 2026 12:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0660D36AB6D;
	Sat,  7 Mar 2026 12:38:23 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C382C11E8
	for <linux-rdma@vger.kernel.org>; Sat,  7 Mar 2026 12:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772887102; cv=none; b=I82XMPzGGwDSkwJYM6GJo1mNNtBQqPH00oEY1RcAauzNxcvBQ/Ie3zXNmGP4EcMukAwFDajMCOl7UWubkUvmvGch4fnDe+xijvJ2XchK1LEWWwNF7O6IS3kzVKdkuLYM+k+FOaxxXyMQDDONpkSLsKDBJZcP8Bfa6Ti4sHLPhDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772887102; c=relaxed/simple;
	bh=Uk429HTane2NEyFMKtXdB+HdlpN0dACT094dvqzw1uY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=DhWU/NHlhPw6mhofK2U095vtDKTnXyJhxyFTrf5iv3BEzCeGt96aQ/58yKtgm9gX3+QDM8BxJCkxnWsEFYNzOAqnQMD1hRK+ADTxPYF8baHm7GfXOXhb4fAPLjBx9jJ0MFq2ma1RpGa8PoTXyDLTYtWR85d5rx6wqwQ0koitpXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-67995e1ecacso152380733eaf.0
        for <linux-rdma@vger.kernel.org>; Sat, 07 Mar 2026 04:38:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772887100; x=1773491900;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gd/nFEaSvpYQRm8eA7KxZy5l02Oibh4aag+PQSoHFMs=;
        b=FzGu70zBrCyJxXd3uOnln/m3ZMCRHgSYyKY7YcLyV78UbVXa/jvN7xeHXM8iRnHmB9
         u9J86Tdxqwa08S8AXtz3P729a7/i3GkTG8nw/owVd8KrBcG2o2l+fqEaqmvDKkyrgd79
         dq+CNNLwth1mPFT5bSkDd97dPGwp4XHmGccN/xjnP2tek6FcX//WAzV9P2D822+33qKU
         gJLMnfbB1HwzX4Z6TP2u9oqgz3SHRFqKqiw4j2aePfOMIcd51OUbc5caoaQYNy8ZyDe/
         1407O3DvKS7d36zUY7UUJcpyoxFPvBmq7izA/RM4QrI8GIiYxe4H2B5r3Ze2K6aBUWZy
         9JFA==
X-Forwarded-Encrypted: i=1; AJvYcCXJ1F0q5jb5cq1by643vYn+HYsvHGWy6ZySaPtUGmut8URkBmnUaDJIWytdt9CdBrSmf61tVAnMVHz7@vger.kernel.org
X-Gm-Message-State: AOJu0YwV1zzEz3UU+NA5jwWyqq6S4AvOr9ryi8J2qO7blI8WAhWi9DJH
	tLNSUY0IwW/OL7mJdvH5mTNUOcEGRS8La6Sqe350swaRQd/8T3ceX2bh5NwtdilIf0elYHAh7PS
	R1fQbi8MPDwNf9PQtf8eqq/bEIVxtYGFWWWpzNw1FBQ9/ZNuLzRprmzc25Z4=
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:f027:b0:664:85db:66bf with SMTP id
 006d021491bc7-67b9bd6515cmr3315566eaf.66.1772887100606; Sat, 07 Mar 2026
 04:38:20 -0800 (PST)
Date: Sat, 07 Mar 2026 04:38:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69ac1c3c.050a0220.13f275.0052.GAE@google.com>
Subject: [syzbot] [rdma?] WARNING in gid_table_release_one (4)
From: syzbot <syzbot+0e8fa99d40c1f50c1527@syzkaller.appspotmail.com>
To: jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 431F422BB6E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=c5c49ee0942d1cdb];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17680-lists,linux-rdma=lfdr.de,0e8fa99d40c1f50c1527];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[goo.gl:url,googlegroups.com:email,storage.googleapis.com:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,appspotmail.com:email];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.958];
	TAGGED_RCPT(0.00)[linux-rdma];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    af4e9ef3d784 uaccess: Fix scoped_user_read_access() for 'p..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=131cc952580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c5c49ee0942d1cdb
dashboard link: https://syzkaller.appspot.com/bug?extid=0e8fa99d40c1f50c1527
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-af4e9ef3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/162b63d580f6/vmlinux-af4e9ef3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1a13a91475a2/bzImage-af4e9ef3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0e8fa99d40c1f50c1527@syzkaller.appspotmail.com

infiniband syz1: set active
infiniband syz1: added syz_tun
RDS/IB: syz1: added
smc: adding ib device syz1 with port count 1
smc:    ib device syz1 port 1 has no pnetid
smc: removing ib device syz1
------------[ cut here ]------------
GID entry ref leak for dev syz1 index 2 ref=1
WARNING: drivers/infiniband/core/cache.c:808 at release_gid_table drivers/infiniband/core/cache.c:805 [inline], CPU#0: syz.0.0/5321
WARNING: drivers/infiniband/core/cache.c:808 at gid_table_release_one+0x1fa/0x440 drivers/infiniband/core/cache.c:885, CPU#0: syz.0.0/5321
Modules linked in:
CPU: 0 UID: 0 PID: 5321 Comm: syz.0.0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:release_gid_table drivers/infiniband/core/cache.c:805 [inline]
RIP: 0010:gid_table_release_one+0x2aa/0x440 drivers/infiniband/core/cache.c:885
Code: 00 48 89 ef be 04 00 00 00 e8 f2 0e 92 f9 48 89 e8 48 c1 e8 03 42 0f b6 04 28 84 c0 75 54 8b 4d 00 48 89 df 4c 89 fe 44 89 e2 <67> 48 0f b9 3a 4d 89 ef 4c 8b 6c 24 68 48 8b 44 24 70 42 0f b6 04
RSP: 0018:ffffc9000ec06fd0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffffffff901fbac0 RCX: 0000000000000001
RDX: 0000000000000002 RSI: ffff88801f36c160 RDI: ffffffff901fbac0
RBP: ffff888034720900 R08: ffff888034720903 R09: 1ffff110068e4120
R10: dffffc0000000000 R11: ffffed10068e4121 R12: 0000000000000002
R13: dffffc0000000000 R14: ffff8880443a5ed8 R15: ffff88801f36c160
FS:  00007f2c6167e6c0(0000) GS:ffff88808ca59000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005558b587a000 CR3: 00000000420e0000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 ib_device_release+0xd2/0x1c0 drivers/infiniband/core/device.c:482
 device_release+0x9e/0x1d0 drivers/base/core.c:-1
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x228/0x560 lib/kobject.c:737
 nldev_dellink+0x288/0x320 drivers/infiniband/core/nldev.c:1827
 rdma_nl_rcv_msg drivers/infiniband/core/netlink.c:-1 [inline]
 rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
 rdma_nl_rcv+0x6d7/0xa10 drivers/infiniband/core/netlink.c:259
 netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
 netlink_unicast+0x80f/0x9b0 net/netlink/af_netlink.c:1344
 netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1894
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg net/socket.c:742 [inline]
 ____sys_sendmsg+0xa68/0xad0 net/socket.c:2592
 ___sys_sendmsg+0x2a5/0x360 net/socket.c:2646
 __sys_sendmsg net/socket.c:2678 [inline]
 __do_sys_sendmsg net/socket.c:2683 [inline]
 __se_sys_sendmsg net/socket.c:2681 [inline]
 __x64_sys_sendmsg+0x1bd/0x2a0 net/socket.c:2681
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2c6079c799
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2c6167dfe8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f2c60a15fa0 RCX: 00007f2c6079c799
RDX: 0000000000000000 RSI: 00002000000002c0 RDI: 0000000000000008
RBP: 00007f2c60832bd9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f2c60a16038 R14: 00007f2c60a15fa0 R15: 00007ffebd9d0d58
 </TASK>
----------------
Code disassembly (best guess):
   0:	00 48 89             	add    %cl,-0x77(%rax)
   3:	ef                   	out    %eax,(%dx)
   4:	be 04 00 00 00       	mov    $0x4,%esi
   9:	e8 f2 0e 92 f9       	call   0xf9920f00
   e:	48 89 e8             	mov    %rbp,%rax
  11:	48 c1 e8 03          	shr    $0x3,%rax
  15:	42 0f b6 04 28       	movzbl (%rax,%r13,1),%eax
  1a:	84 c0                	test   %al,%al
  1c:	75 54                	jne    0x72
  1e:	8b 4d 00             	mov    0x0(%rbp),%ecx
  21:	48 89 df             	mov    %rbx,%rdi
  24:	4c 89 fe             	mov    %r15,%rsi
  27:	44 89 e2             	mov    %r12d,%edx
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	4d 89 ef             	mov    %r13,%r15
  32:	4c 8b 6c 24 68       	mov    0x68(%rsp),%r13
  37:	48 8b 44 24 70       	mov    0x70(%rsp),%rax
  3c:	42                   	rex.X
  3d:	0f                   	.byte 0xf
  3e:	b6 04                	mov    $0x4,%dh


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

