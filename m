Return-Path: <linux-rdma+bounces-3977-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A45B693C004
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2024 12:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07A95B20ED9
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2024 10:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8C21990B3;
	Thu, 25 Jul 2024 10:37:27 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800ED198E80
	for <linux-rdma@vger.kernel.org>; Thu, 25 Jul 2024 10:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721903847; cv=none; b=eCciqhO0OJwJoLNy0MK4AfmQ9WbTmHdz4CGBpf2yERBujyXvo3cvq9fQ+ESfQiQNWX6afgY098zRL6HK1gsZba4iv9C+bmFjv98GkQD3ZY0SsSC3LaUI8BRd9jZItN9rdfXrtvnAqhisZes9ljBq3AEefFkOMwj2FyKL0vNHvpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721903847; c=relaxed/simple;
	bh=e+HgzfBixzkSmh99gsFRir3r3MIuP1EvSEc7+bTstsc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=AEebi0TFDpnS8/KnMkf1T2Y3EYxw5TLJbQpxnEWY+s1UYcQbFBI+4wVv/ZyOm2drq4Jtig7dHVxmBYp6jf7oiXa2aMh0fqEYkkLgFHj4KHqBkSDcp6FXImJ/TUkmPnmKQ8L0CA6HX6BdmvD6icpM8WcRuDn/fX5lef6YLPNdBwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7f682b4694aso122302339f.2
        for <linux-rdma@vger.kernel.org>; Thu, 25 Jul 2024 03:37:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721903845; x=1722508645;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S3qf9QcL2Ze6DFtKZYBjpyF713HONXLgftyPCH25s68=;
        b=T+TVyBu60XnhvfdfYWByvDVmf7aX2mCEmuNaFCs0pu9i8JsAcd3xOid/o9OioIXDoY
         dSD0q8QiNQUkzN6aT7nMvFqU8T0q6PZTDbCRNsqcZSoosnUPGsxjvMxHU+q55KIOwyzX
         HG38eQo2No5e/LCVc6sn8Yl+qYrDQaoch7jyj0TQMo6HMbrokV3faaFMazwCQMuGCQvn
         hEYjOv3ul6Kb1t4XU68qC8DxlyHy2aVXzGYII+eC6AbG8C+Z9DJkQnX51lEroRuP+R7O
         8T6FxL3O2Cyp3qvuFoRCjwRXWSSLtrbL9796yF7pBvnvHryD12DZEoowwrdvlYB0VVNp
         D/tQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7clubFyeQCaQNNUJuuGOUJ3Dxz6lC4hvTSdMhJOX5m5l3fTEsl5FzXE1HWqdtcTO5kqljL+zmHDAawDZ9bW4JEfVGCBF8j+ASUw==
X-Gm-Message-State: AOJu0YxWBfS2Imfy6PfC6+dlHKvDezfpU+lodJaRMSNW6fQpgTkWmSNI
	Iujaf6YpsmYFKTGT6jGGdmTIPdHsgGGl9XZZTgjUnHrV8mW3fmnoiUeCeqC/oRV0TSuIUg+q9e5
	vruPn/a2tK35Un1DYy4fmFnX6ZYLynCgD+A75Y8FQfDPi8fU0OWxTKO0=
X-Google-Smtp-Source: AGHT+IHquEr9IB4p4qNZw3ugs6DFMLLyttRQ6rcaOQPg4RE6OsaHR06OOFlSW1Ym1omKfR/j6AmiNHW+yLCH1lZNRJov0CTso4cx
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a5d:91cf:0:b0:806:f9d1:52b2 with SMTP id
 ca18e2360f4ac-81f7be70b0emr2428339f.2.1721903844566; Thu, 25 Jul 2024
 03:37:24 -0700 (PDT)
Date: Thu, 25 Jul 2024 03:37:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fe34b1061e0ffa36@google.com>
Subject: [syzbot] [rdma?] WARNING: ODEBUG bug in siw_netdev_event (2)
From: syzbot <syzbot+3e6d53405f58eda0bd6c@syzkaller.appspotmail.com>
To: bmt@zurich.ibm.com, jgg@ziepe.ca, leon@kernel.org, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d7e78951a8b8 Merge tag 'net-6.11-rc0' of git://git.kernel...
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14da0779980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8d1cf7c29e32ce12
dashboard link: https://syzkaller.appspot.com/bug?extid=3e6d53405f58eda0bd6c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3c208b51873e/disk-d7e78951.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/adec146cf41c/vmlinux-d7e78951.xz
kernel image: https://storage.googleapis.com/syzbot-assets/52f09b8f7356/bzImage-d7e78951.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3e6d53405f58eda0bd6c@syzkaller.appspotmail.com

------------[ cut here ]------------
ODEBUG: init active (active state 0) object: ffff88801e645208 object type: work_struct hint: siw_netdev_down+0x0/0x1f0
WARNING: CPU: 0 PID: 5666 at lib/debugobjects.c:518 debug_print_object+0x17a/0x1f0 lib/debugobjects.c:515
Modules linked in:
CPU: 0 PID: 5666 Comm: syz.3.129 Not tainted 6.10.0-syzkaller-09703-gd7e78951a8b8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
RIP: 0010:debug_print_object+0x17a/0x1f0 lib/debugobjects.c:515
Code: e8 1b 7f 42 fd 4c 8b 0b 48 c7 c7 c0 72 20 8c 48 8b 74 24 08 48 89 ea 44 89 e1 4d 89 f8 ff 34 24 e8 db 5b 9e fc 48 83 c4 08 90 <0f> 0b 90 90 ff 05 fc 35 f8 0a 48 83 c4 10 5b 41 5c 41 5d 41 5e 41
RSP: 0018:ffffc90016e2e7b8 EFLAGS: 00010286
RAX: e1f1ce699f2edb00 RBX: ffffffff8bc9f240 RCX: ffff88801e51da00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffffff8c207440 R08: ffffffff815565a2 R09: fffffbfff1c39f60
R10: dffffc0000000000 R11: fffffbfff1c39f60 R12: 0000000000000000
R13: ffffffff8c207358 R14: dffffc0000000000 R15: ffff88801e645208
FS:  00007fda35fff6c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c352547 CR3: 000000007f7da000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __debug_object_init+0x2a9/0x400 lib/debugobjects.c:654
 siw_device_goes_down drivers/infiniband/sw/siw/siw_main.c:395 [inline]
 siw_netdev_event+0x3bd/0x620 drivers/infiniband/sw/siw/siw_main.c:422
 notifier_call_chain+0x19f/0x3e0 kernel/notifier.c:93
 call_netdevice_notifiers_extack net/core/dev.c:2032 [inline]
 call_netdevice_notifiers net/core/dev.c:2046 [inline]
 __dev_close_many+0x146/0x300 net/core/dev.c:1532
 __dev_close net/core/dev.c:1570 [inline]
 __dev_change_flags+0x30e/0x6f0 net/core/dev.c:8835
 dev_change_flags+0x8b/0x1a0 net/core/dev.c:8909
 do_setlink+0xccd/0x41f0 net/core/rtnetlink.c:2900
 rtnl_setlink+0x40d/0x5a0 net/core/rtnetlink.c:3201
 rtnetlink_rcv_msg+0x73f/0xcf0 net/core/rtnetlink.c:6647
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2550
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7f0/0x990 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 sock_write_iter+0x2dd/0x400 net/socket.c:1160
 do_iter_readv_writev+0x60a/0x890
 vfs_writev+0x37c/0xbb0 fs/read_write.c:971
 do_writev+0x1b1/0x350 fs/read_write.c:1018
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fda35175f19
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fda35fff048 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 00007fda35305f60 RCX: 00007fda35175f19
RDX: 0000000000000001 RSI: 00000000200003c0 RDI: 0000000000000006
RBP: 00007fda351e4e68 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fda35305f60 R15: 00007ffc0c742898
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

