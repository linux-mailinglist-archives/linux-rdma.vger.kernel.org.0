Return-Path: <linux-rdma+bounces-21912-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lGjzAsABJWrJCgIAu9opvQ
	(envelope-from <linux-rdma+bounces-21912-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 07 Jun 2026 07:29:36 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D34664EDA4
	for <lists+linux-rdma@lfdr.de>; Sun, 07 Jun 2026 07:29:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21912-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21912-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=appspotmail.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BDCDA3018BDD
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Jun 2026 05:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E0C2BE642;
	Sun,  7 Jun 2026 05:29:29 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oo1-f79.google.com (mail-oo1-f79.google.com [209.85.161.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A806F1A08AF
	for <linux-rdma@vger.kernel.org>; Sun,  7 Jun 2026 05:29:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780810169; cv=none; b=mtcrb84JnbTdvS5OB0dKF/7GfM9ZQFQgM1E+/2ufVWNULoP4AHMhegG3ChcbGNwSWaYBFpOR5OylA4Ip39kGANiGrQkxrFi3MQ7m3kIbVrEkZAwgrr/1MO31mvj5hE0QhsZ/RAAthLTbcqeoctVdaoKDUMuEi86tvgUmOxftWdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780810169; c=relaxed/simple;
	bh=mPlxepmJb7ZqNYj/s0qRBHRLElZTfo8jR2UZuGH/Eug=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ZT92ahdZ5mixij9sUc8wdtz0HFYl8NI8uUoaHpOkwwGfmmptl23TaK/JTHDCwvr35PyVoSiES2Jx4IWSR8ZcuYloS1lRqgwaTIz5Pzp2JdpH594CxPo3gEQmmIdM63Om03DdoCsXkES87mo5taVYIiQ2fOQH/Y345ZtoQp3HEDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.79
Received: by mail-oo1-f79.google.com with SMTP id 006d021491bc7-69e87ffce0fso520693eaf.1
        for <linux-rdma@vger.kernel.org>; Sat, 06 Jun 2026 22:29:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780810166; x=1781414966;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hlOZ5yR2tplNmNUIcqFAUXi+mMoLNEmUG/K66pwGvhU=;
        b=Y4DuH7EcGsQJYruTnwl9wU/kI1SCJ4CDcoB0TlTMOGehzBaJow9YdN9oqm3+sf9yax
         UwOnaHNZy3ooGvEEfvbTF8b4fmr5pUrRzOq0MIyf2kVJ0udIe0/2eLm+IjUf0e1qBstN
         Z57lzRlmjrgWRTOODGfcGAlKHhAWclQevpls0CyJ6WtWie7VCCm+QYN8G5OIPxBzzgxZ
         MM/oDkodGsrpqYwEVaVX+B4DZdLJlR6JAM+lrVoGCrnF3bOXD/fPfNs2Fp7ghUnQo4eJ
         fMmOfocTofO6OnsEauefZSKgxMzqMwzb+fN3c77896MuLGV7mZIgUhgWoI2VsseDbpeE
         6BVQ==
X-Forwarded-Encrypted: i=1; AFNElJ8dYi0VH+shKqPZXYx4RxBqMTR1e0AsOXrHQDe04NUsrwxtOaIj3hmKCpkhKMnYAzFrU7uqVSkZTmsk@vger.kernel.org
X-Gm-Message-State: AOJu0YzTOd95VpN8s/4uzwHMIHOJiZ8WVGFTkGdq+Wgc9ergUmwFqTBJ
	rMHo7vNp/m3yaxMIpPEWGoZmekpxqIbHbcYGrlFOG/EpUzEFoAEjYjuNnaDu70zo8xpkLXX1TpM
	dbswkYLBBzzgBNtyge8UBWrR1g7R3IrT0YOhqzfibf6jRL6ujQlsSuvScfS8=
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:180a:b0:696:8e8b:2097 with SMTP id
 006d021491bc7-69e68b5e9camr5977540eaf.21.1780810166701; Sat, 06 Jun 2026
 22:29:26 -0700 (PDT)
Date: Sat, 06 Jun 2026 22:29:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a2501b6.39669fcc.33b062.000a.GAE@google.com>
Subject: [syzbot] [rdma?] WARNING in rdma_restrack_clean (2)
From: syzbot <syzbot+47c9ad191991e1bb459b@syzkaller.appspotmail.com>
To: jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.36 / 15.00];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=f52fb4a6d220c448];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21912-lists,linux-rdma=lfdr.de,47c9ad191991e1bb459b];
	RCVD_TLS_LAST(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:syzkaller-bugs@googlegroups.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[syzbot@syzkaller.appspotmail.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,googlegroups.com:email,storage.googleapis.com:url,goo.gl:url,appspotmail.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4D34664EDA4

Hello,

syzbot found the following issue on:

HEAD commit:    4b4362973b6f Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1463617a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f52fb4a6d220c448
dashboard link: https://syzkaller.appspot.com/bug?extid=47c9ad191991e1bb459b
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/cdc9dd8cab69/disk-4b436297.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6bb74747f86d/vmlinux-4b436297.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a20d7153214f/Image-4b436297.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+47c9ad191991e1bb459b@syzkaller.appspotmail.com

siw: device registration error -23
smc: removing ib device syz2
------------[ cut here ]------------
WARNING: drivers/infiniband/core/restrack.c:52 at rdma_restrack_clean+0xa4/0xd4 drivers/infiniband/core/restrack.c:52, CPU#0: syz.6.395/6673
Modules linked in:
CPU: 0 UID: 0 PID: 6673 Comm: syz.6.395 Tainted: G             L      syzkaller #0 PREEMPT 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/18/2026
pstate: 63400005 (nZCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : rdma_restrack_clean+0xa4/0xd4 drivers/infiniband/core/restrack.c:52
lr : rdma_restrack_clean+0xa4/0xd4 drivers/infiniband/core/restrack.c:52
sp : ffff800097046ed0
x29: ffff800097046ed0 x28: ffff800097047500 x27: ffff800087543780
x26: 0000000000000005 x25: ffff0000f6f8a000 x24: 0000000000000048
x23: 1fffe0001a7d49da x22: dfff800000000000 x21: ffff0000f6f8a048
x20: ffff0000f6f8a000 x19: ffff0000d3ea4ed0 x18: 00000000ffffffff
x17: ffff80008a186c80 x16: ffff80008a56f938 x15: ffff800084b03e18
x14: 000000008679e8e0 x13: 0000000000000001 x12: 0000000000000000
x11: 0000000000000000 x10: 0000000000080000 x9 : 0000000000080000
x8 : ffff80009b59b000 x7 : 0000000000000000 x6 : 0000000000000000
x5 : 0000000000000001 x4 : 0000000000000008 x3 : ffff80008433288c
x2 : 0000000000000000 x1 : ffff0000c8ee8000 x0 : 0000000000000001
Call trace:
 rdma_restrack_clean+0xa4/0xd4 drivers/infiniband/core/restrack.c:52 (P)
 ib_dealloc_device+0x14c/0x1e0 drivers/infiniband/core/device.c:686
 __ib_unregister_device+0x2b4/0x334 drivers/infiniband/core/device.c:1546
 ib_unregister_device_and_put+0x5c/0x80 drivers/infiniband/core/device.c:1593
 nldev_dellink+0x2e4/0x328 drivers/infiniband/core/nldev.c:1854
 rdma_nl_rcv_msg drivers/infiniband/core/netlink.c:-1 [inline]
 rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
 rdma_nl_rcv+0x568/0x828 drivers/infiniband/core/netlink.c:259
 netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
 netlink_unicast+0x610/0x800 net/netlink/af_netlink.c:1344
 netlink_sendmsg+0x63c/0x920 net/netlink/af_netlink.c:1894
 sock_sendmsg_nosec net/socket.c:787 [inline]
 __sock_sendmsg+0xc8/0x138 net/socket.c:802
 ____sys_sendmsg+0x418/0x70c net/socket.c:2698
 ___sys_sendmsg+0x198/0x224 net/socket.c:2752
 __sys_sendmsg+0x160/0x214 net/socket.c:2784
 __do_sys_sendmsg net/socket.c:2789 [inline]
 __se_sys_sendmsg net/socket.c:2787 [inline]
 __arm64_sys_sendmsg+0x80/0x94 net/socket.c:2787
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x244 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0xe8/0x23c arch/arm64/kernel/syscall.c:121
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:140
 el0_svc+0x64/0x260 arch/arm64/kernel/entry-common.c:740
 el0t_64_sync_handler+0x48/0x148 arch/arm64/kernel/entry-common.c:759
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:594
irq event stamp: 227244
hardirqs last  enabled at (227243): [<ffff8000867c300c>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:178 [inline]
hardirqs last  enabled at (227243): [<ffff8000867c300c>] _raw_spin_unlock_irqrestore+0x38/0x98 kernel/locking/spinlock.c:198
hardirqs last disabled at (227244): [<ffff80008679e6f8>] el1_brk64+0x20/0x54 arch/arm64/kernel/entry-common.c:429
softirqs last  enabled at (227122): [<ffff800084b2768c>] __alloc_skb+0x1c0/0x5f8 net/core/skbuff.c:696
softirqs last disabled at (227118): [<ffff800084b27674>] local_bh_disable include/linux/bottom_half.h:20 [inline]
softirqs last disabled at (227118): [<ffff800084b27674>] __alloc_skb+0x1a8/0x5f8 net/core/skbuff.c:695
---[ end trace 0000000000000000 ]---


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

