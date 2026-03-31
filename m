Return-Path: <linux-rdma+bounces-18862-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PAnJ74hzGnHPgYAu9opvQ
	(envelope-from <linux-rdma+bounces-18862-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 21:34:22 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 199813709E4
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 21:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9B53530AD579
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 19:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B885E3A5E8D;
	Tue, 31 Mar 2026 19:30:24 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oo1-f77.google.com (mail-oo1-f77.google.com [209.85.161.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B0838F620
	for <linux-rdma@vger.kernel.org>; Tue, 31 Mar 2026 19:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774985424; cv=none; b=Nr5T0NRiQ83ijZU2tf+wrk0T582R+gm8T+D8P0ewWBOQa4lh+jz9f8W6+s1VboTzugiOj8Ih+Iq4l2hQyXos4qsGz5muuxumdIsTOrJ/nTAehtKfsg5iyHT6FlJh9wW48FoufHlFOhiwJejSunLEPKJ9fMUk9nt7zoL26xAymR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774985424; c=relaxed/simple;
	bh=bynob4NZe4ET1Tib3vDeRyWtDTfB/zfn6B27cF7UMZs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=P1gz3pI+cI/X/AylyXvm40Tj6fnrIAZHxGPvLGa5B8o3L+87815NCW7l2pP7DZ3Z+eFmRX+j3yLJJwqM3aoS3iiaEbdxgMEdphcAZm9kZNLQnljTfXpC1Ek9PvsbGmD3KZ64hIS/wcsb2pc+dpUPofJVFGDsDviR09+GKtyJxfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f77.google.com with SMTP id 006d021491bc7-67baeba7a53so714214eaf.0
        for <linux-rdma@vger.kernel.org>; Tue, 31 Mar 2026 12:30:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774985422; x=1775590222;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qxy9MKtk8JwMijSWI4Qx2dGRtjiY1HN4Gl53xVyjn5s=;
        b=C8pw9GXH7vtcd9NWV16dSQnM5GbTA029MJG7m8jwtcN+/nDMJZOrLXJj9s2mwPJnm8
         9Lkb4voA6oj7KICflnN0hPaqOkRDCvKENgnADA7eP9gCPv6rWS1r/KI049d0DF/GNueK
         Z4IfalolvFMCe42Qg/d65pdeDAKuMud+myk6lk7YvQ2C8u6BEEPPx42Zjro7o7rz1nj0
         1zKw5xlOYyPlJGALIpY4bQqQhoNszCB60o3gKBcN+xXlng9/aun60HV29YEOGTN07YHF
         7+GpeWdsXdg7oNvt0FHHLBy7QyVm5Fg1tnwJ3NY6o9Rt4rKZwwf9qPi25PdTge7c5d64
         +r+A==
X-Forwarded-Encrypted: i=1; AJvYcCUYAus3m/fvxYzFWXHOa0DumIvQcX8CaukmTgSpxrRMHswf7FLpCdJTkxFMSfQ5iKTvEgWC8IG7QPBy@vger.kernel.org
X-Gm-Message-State: AOJu0YwLwjSlVo4cx5OFtSCYRJHvCFSKbZ2IXgH28ZQVuBj8PY3Zwj9G
	gZZ77f7WSZan2DnkLfdpnJrTZ9Hou/cv1PBr0Zn99jBnCMa4vwD/tBzyuj3DlpfiUuQBaJoOaGC
	+qQTAedkPWtKfHxSkmkXOgF0z7CuWfdS3XMa5FjI0UpA68hB5bgJMRlUbFhc=
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:701:b0:67e:411e:64dc with SMTP id
 006d021491bc7-67e411e668cmr1168281eaf.18.1774985422272; Tue, 31 Mar 2026
 12:30:22 -0700 (PDT)
Date: Tue, 31 Mar 2026 12:30:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69cc20ce.050a0220.183828.0033.GAE@google.com>
Subject: [syzbot] [rdma?] KFENCE: invalid free in gid_table_release_one
From: syzbot <syzbot+4334f9a250019c1b79b4@syzkaller.appspotmail.com>
To: jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=e5c508e55e8ef9a7];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18862-lists,linux-rdma=lfdr.de,4334f9a250019c1b79b4];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,syzkaller.appspot.com:url,googlegroups.com:email,goo.gl:url,storage.googleapis.com:url,appspotmail.com:email]
X-Rspamd-Queue-Id: 199813709E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot found the following issue on:

HEAD commit:    36ece9697e89 Add linux-next specific files for 20260331
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1415f5da580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e5c508e55e8ef9a7
dashboard link: https://syzkaller.appspot.com/bug?extid=4334f9a250019c1b79b4
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/46de62fad824/disk-36ece969.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/88dd71e1e51a/vmlinux-36ece969.xz
kernel image: https://storage.googleapis.com/syzbot-assets/51e7e482e157/bzImage-36ece969.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4334f9a250019c1b79b4@syzkaller.appspotmail.com

smbdirect: ib_dev[syz2] removed
==================================================================
BUG: KFENCE: invalid free in release_gid_table drivers/infiniband/core/cache.c:804 [inline]
BUG: KFENCE: invalid free in gid_table_release_one+0x384/0x470 drivers/infiniband/core/cache.c:877

Invalid free of 0xffff88823bf88fd8 (in kfence-#195):
 release_gid_table drivers/infiniband/core/cache.c:804 [inline]
 gid_table_release_one+0x384/0x470 drivers/infiniband/core/cache.c:877
 ib_device_release+0xd2/0x1c0 drivers/infiniband/core/device.c:482
 device_release+0xc4/0x1f0 drivers/base/core.c:-1
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x228/0x560 lib/kobject.c:737
 process_one_work kernel/workqueue.c:3278 [inline]
 process_scheduled_works+0xb5d/0x1860 kernel/workqueue.c:3361
 worker_thread+0xa53/0xfc0 kernel/workqueue.c:3442
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

kfence-#195: 0xffff88823bf88f00-0xffff88823bf88fdf, size=224, cache=kmalloc-256

allocated by task 14262 on cpu 0 at 508.565598s (487.512186s ago):
 kmalloc_noprof include/linux/slab.h:954 [inline]
 kzalloc_noprof include/linux/slab.h:1188 [inline]
 alloc_gid_table drivers/infiniband/core/cache.c:773 [inline]
 _gid_table_setup_one drivers/infiniband/core/cache.c:888 [inline]
 gid_table_setup_one drivers/infiniband/core/cache.c:916 [inline]
 ib_cache_setup_one+0x198/0x570 drivers/infiniband/core/cache.c:1606
 ib_register_device+0xfbd/0x13e0 drivers/infiniband/core/device.c:1426
 siw_device_register drivers/infiniband/sw/siw/siw_main.c:71 [inline]
 siw_newlink+0x8fe/0xde0 drivers/infiniband/sw/siw/siw_main.c:430
 nldev_newlink+0x5bc/0x650 drivers/infiniband/core/nldev.c:1812
 rdma_nl_rcv_msg drivers/infiniband/core/netlink.c:-1 [inline]
 rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
 rdma_nl_rcv+0x6d1/0xa10 drivers/infiniband/core/netlink.c:259
 netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
 netlink_unicast+0x80f/0x9b0 net/netlink/af_netlink.c:1344
 netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1894
 sock_sendmsg_nosec net/socket.c:786 [inline]
 __sock_sendmsg net/socket.c:801 [inline]
 ____sys_sendmsg+0x972/0x9f0 net/socket.c:2650
 ___sys_sendmsg+0x2a5/0x360 net/socket.c:2704
 __sys_sendmsg net/socket.c:2736 [inline]
 __do_sys_sendmsg net/socket.c:2741 [inline]
 __se_sys_sendmsg net/socket.c:2739 [inline]
 __x64_sys_sendmsg+0x1bd/0x2a0 net/socket.c:2739
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 0 UID: 0 PID: 57 Comm: kworker/u8:4 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/18/2026
Workqueue: ib-unreg-wq ib_unregister_work
==================================================================


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

