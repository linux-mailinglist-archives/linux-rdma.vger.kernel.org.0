Return-Path: <linux-rdma+bounces-17330-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDJtDk5xomne3AQAu9opvQ
	(envelope-from <linux-rdma+bounces-17330-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 28 Feb 2026 05:38:38 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E32B1C04EA
	for <lists+linux-rdma@lfdr.de>; Sat, 28 Feb 2026 05:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6CEA73067A3B
	for <lists+linux-rdma@lfdr.de>; Sat, 28 Feb 2026 04:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5021933ADBA;
	Sat, 28 Feb 2026 04:38:33 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B563242B3
	for <linux-rdma@vger.kernel.org>; Sat, 28 Feb 2026 04:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772253513; cv=none; b=oPBiOMOoMIpnHgmVrZ5tC88oMscv36CNeKO5A7a0ZYiZk5Mj5btUYGvX1lyZziH6J2Cd2UmUpH93GxAINOZs7fG7WgPP9g2uAYOVgMxGN0VRIhDHoti6nF9ngfWCBL1Si6YwU2uHU6d1mcedJAFmTOWIt+TRAGVWc7BJuWgw6jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772253513; c=relaxed/simple;
	bh=/m/tAhYo/fjiHpCpRNcH5fsShh6TZUCc08RG5Cf1lEU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=AvxTj+m4soCzj1NOVPJd8gotT6Q5PhapS2sBUJxY1WCbKD2Kvh+TPKbL3AFYhxDNahnd2kys5wR5ZXcCz2X6SnutflWbBUzorCMKm/ZdFjUl2scOcUttVodFzV1Na0FWF6uVRpQo1aQmDH9Be8svrHcy0hwZUxOwGMZwkSeqQ40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-463905cb295so15616256b6e.2
        for <linux-rdma@vger.kernel.org>; Fri, 27 Feb 2026 20:38:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772253511; x=1772858311;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C5gzgnU3iEE7jBYFDoRuF/jg2nazHJBRv9S4PJXT0g4=;
        b=JEUzyy1YZKpWWTebouS1R97T7okWBxO79x5RIUZ04w7ug8XptSVUeNzaPKQInTMzNr
         /rnSti8uZ/DZxv7HlPwqLC2ujiSdpDYCdclPUoslPNPJD9Ubp/vQ+NYW1riiik+U6DAV
         ctpwdRaT/brEhPNm5PBb1+HpAh2j7uTLYfgTdWHoigczK+L2dQH5e9Ja/ndHZqMa4gr0
         OudjvJmGFz09fQp7Lht+53bgafShNx0FaPTJkd8FKM3vLKiV1BoLQEMrGjsfRKlQHQKD
         mOj7iaewJrlE1E6Fcw0Xfcl7M69pghLYKayu3p8me+7rtBwrlnTPFinYJvA6ak+/ta+Q
         RCLA==
X-Forwarded-Encrypted: i=1; AJvYcCXgVOgC+peA92kP7jIgl2W2aHhzI7XdcXJ38A6zLpsHz2TB8tvc9OYfDzWYZtaBR3QMxDBXDjzIE+qz@vger.kernel.org
X-Gm-Message-State: AOJu0Yws/DqXjymN3l5Ts3iilSJuzGDn5UiFiYItM8k+yDdrBjXns6nu
	hf6O753RZ1WQbH3OWnRcxmD63NzfPjDuy5efdr0JnMcbFpIoDUNyDV0S8zj2ETHnyFfuZ4AWYnv
	H4SuKNcPdxYHpSQ7Vl3u8Dvs1C6qmftllywi8/oD7ruuJX0srsbb6fq7sHwo=
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:98e:b0:66d:b183:64ed with SMTP id
 006d021491bc7-679fadf3944mr3241818eaf.25.1772253510747; Fri, 27 Feb 2026
 20:38:30 -0800 (PST)
Date: Fri, 27 Feb 2026 20:38:30 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69a27146.050a0220.3a55be.002e.GAE@google.com>
Subject: [syzbot] [rdma?] kernel BUG in ib_device_get_by_index
From: syzbot <syzbot+53cf317e7803e4ef2f33@syzkaller.appspotmail.com>
To: jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=ee920513e4deca5f];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17330-lists,linux-rdma=lfdr.de,53cf317e7803e4ef2f33];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[googlegroups.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,storage.googleapis.com:url,goo.gl:url,appspotmail.com:email,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: 7E32B1C04EA
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    779cae956c83 Add linux-next specific files for 20260223
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=172ebfb2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ee920513e4deca5f
dashboard link: https://syzkaller.appspot.com/bug?extid=53cf317e7803e4ef2f33
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0110c968351a/disk-779cae95.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/582a1d69266e/vmlinux-779cae95.xz
kernel image: https://storage.googleapis.com/syzbot-assets/13619a146558/bzImage-779cae95.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+53cf317e7803e4ef2f33@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at ./include/rdma/ib_verbs.h:4611!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 0 UID: 0 PID: 5945 Comm: syz.0.12 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
RIP: 0010:ib_device_try_get include/rdma/ib_verbs.h:4611 [inline]
RIP: 0010:ib_device_get_by_index+0x2ae/0x2b0 drivers/infiniband/core/device.c:331
Code: f9 e9 76 fe ff ff 44 89 f1 80 e1 07 80 c1 03 38 c1 0f 8c 9d fe ff ff 4c 89 f7 e8 6d 6c 88 f9 e9 90 fe ff ff e8 23 46 1e f9 90 <0f> 0b 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa
RSP: 0018:ffffc900043e6fe0 EFLAGS: 00010287
RAX: ffffffff88a79c3d RBX: ffff8880277bc000 RCX: 0000000000080000
RDX: ffffc9000d882000 RSI: 0000000000000110 RDI: 0000000000000111
RBP: ffffc900043e7090 R08: ffff88801e7ebc80 R09: 0000000000000002
R10: 0000000000000406 R11: 0000000000000002 R12: 1ffff9200087ce00
R13: dffffc0000000000 R14: ffff8880277bd104 R15: dffffc0000000000
FS:  00007f2f67eba6c0(0000) GS:ffff888125009000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000001000 CR3: 0000000076cc8000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 nldev_set_doit+0x23a/0x4c0 drivers/infiniband/core/nldev.c:1134
 rdma_nl_rcv_msg drivers/infiniband/core/netlink.c:-1 [inline]
 rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
 rdma_nl_rcv+0x6d7/0xa10 drivers/infiniband/core/netlink.c:259
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
RIP: 0033:0x7f2f66f9c629
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2f67eba028 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f2f67216090 RCX: 00007f2f66f9c629
RDX: 0000000000040810 RSI: 0000200000000140 RDI: 0000000000000004
RBP: 00007f2f67032b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f2f67216128 R14: 00007f2f67216090 R15: 00007fff55890bd8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ib_device_try_get include/rdma/ib_verbs.h:4611 [inline]
RIP: 0010:ib_device_get_by_index+0x2ae/0x2b0 drivers/infiniband/core/device.c:331
Code: f9 e9 76 fe ff ff 44 89 f1 80 e1 07 80 c1 03 38 c1 0f 8c 9d fe ff ff 4c 89 f7 e8 6d 6c 88 f9 e9 90 fe ff ff e8 23 46 1e f9 90 <0f> 0b 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa
RSP: 0018:ffffc900043e6fe0 EFLAGS: 00010287
RAX: ffffffff88a79c3d RBX: ffff8880277bc000 RCX: 0000000000080000
RDX: ffffc9000d882000 RSI: 0000000000000110 RDI: 0000000000000111
RBP: ffffc900043e7090 R08: ffff88801e7ebc80 R09: 0000000000000002
R10: 0000000000000406 R11: 0000000000000002 R12: 1ffff9200087ce00
R13: dffffc0000000000 R14: ffff8880277bd104 R15: dffffc0000000000
FS:  00007f2f67eba6c0(0000) GS:ffff888125109000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f37a17e82f8 CR3: 0000000076cc8000 CR4: 00000000003526f0


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

