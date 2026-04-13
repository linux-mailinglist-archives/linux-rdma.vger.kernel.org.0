Return-Path: <linux-rdma+bounces-19263-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPSBIhgz3GlMOAkAu9opvQ
	(envelope-from <linux-rdma+bounces-19263-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 02:04:40 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB7A3E6713
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 02:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BFB35300C025
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 00:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10AF3125D0;
	Mon, 13 Apr 2026 00:04:35 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oi1-f208.google.com (mail-oi1-f208.google.com [209.85.167.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93912256D
	for <linux-rdma@vger.kernel.org>; Mon, 13 Apr 2026 00:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776038674; cv=none; b=OZG7NIEN+TnfdTG7g7pxexnY0U8of9A79g/yjVPBW9UJG+Lfuu66G29EoEqAL04z0pFr8MdSco4W6XKwMf5DnOWJcmMixW45AOqrZmhGVBFBwG6hiPFfey0VE5xZJeye+wPEFUlLWtM5i3G4M4VfYol/cdyOG8sBSQGxhhQ2Rk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776038674; c=relaxed/simple;
	bh=MWUJx1V+5VpSpWKKTFvXqcAGEEC994baHy9CpepjCXw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=prCm6WkX6N3c83fGyDvXmgmfHrlXuCGLsMbCZWW6PHeynq8mDcEDToigZUfuW396feA2xlUaeayvR2DpauKsfjMlIaZDE7BniHmqoBWzImMJPeldCdqGhfnNTVwyJVxeZr7QBbOcQ6LtrQ7t3gH5q3pv4EIoI0aqx0MCnvy++Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f208.google.com with SMTP id 5614622812f47-463ee33f9b2so2131098b6e.3
        for <linux-rdma@vger.kernel.org>; Sun, 12 Apr 2026 17:04:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776038672; x=1776643472;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p2eJ0fho1jTALd5M7XFCO9YJ4jGgTlsPgXpXtRrUmBo=;
        b=FeJKAlW28uLkj6vlbQSmVO1yZubkzmbeu6QSdLZ+Z8EoUNgzMxEdp+N5Zzy7W1a9NU
         1AHlabPw1EL69k4LuEGNQ47PNijFhNn/Cm5uDxpaEngSfqNOm55j/HeWPdZ6DTksEPb8
         03cD8s1xaHAzDu/SLkuJdFwd2rKFcS94LU0mW78MXBRmCZMPuoRejA+JpUqTxu4aFFOP
         7G0pQHDu+HPbrE7NVVwrXzvUA653CR1ZVK2NGfVlKD6K04X0sx+73/1JLHOTJf/ve39U
         Iw4KeHKgBYYfB2oEOKf9LXGYIx9Z/mNGXRWbwEZy4VPdTcuMzTnX0WWZMK/UI8JX5fzG
         qIDQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/vZ623bT5Y5Dh2vWtWroetnDhGv02PuGhjh7shTpXQ3dK5/5lYMlCOSKBvHCaDu6rXhmxEFi8wt4K@vger.kernel.org
X-Gm-Message-State: AOJu0YwzEoN28geRxJoON3uHbZrps8dpn4v7K58RWDIUKcWxflNEhOEv
	CfsZB5Ux3dgCMzkBgq8bNeoiYDeZW43FgtEW/UBu+wHVAUWdE5DGnUkPfpMss59yObUunGTjzAe
	kw6lPfTvEdXOTktE5DQ7zE1A2+hxbFULW+jLLcoEv5sxtDxJQEL4bsYaKhxg=
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1626:b0:68e:1120:d4aa with SMTP id
 006d021491bc7-68e1120d593mr2818974eaf.11.1776038672634; Sun, 12 Apr 2026
 17:04:32 -0700 (PDT)
Date: Sun, 12 Apr 2026 17:04:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69dc3310.a00a0220.475f0.0018.GAE@google.com>
Subject: [syzbot] [rdma?] WARNING in ib_dealloc_device
From: syzbot <syzbot+03393ff6c35fd2cc43de@syzkaller.appspotmail.com>
To: jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=45cb3c58fd963c27];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19263-lists,linux-rdma=lfdr.de,03393ff6c35fd2cc43de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[goo.gl:url,storage.googleapis.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DFB7A3E6713
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot found the following issue on:

HEAD commit:    7f87a5ea75f0 Merge tag 'hid-for-linus-2026040801' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11778eba580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=45cb3c58fd963c27
dashboard link: https://syzkaller.appspot.com/bug?extid=03393ff6c35fd2cc43de
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0f5deca1373e/disk-7f87a5ea.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6aea6c1c6b6e/vmlinux-7f87a5ea.xz
kernel image: https://storage.googleapis.com/syzbot-assets/61444b289e96/bzImage-7f87a5ea.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+03393ff6c35fd2cc43de@syzkaller.appspotmail.com

------------[ cut here ]------------
!xa_empty(&device->compat_devs)
WARNING: drivers/infiniband/core/device.c:682 at ib_dealloc_device+0x187/0x200 drivers/infiniband/core/device.c:682, CPU#0: kworker/u8:37/4856
Modules linked in:
CPU: 0 UID: 0 PID: 4856 Comm: kworker/u8:37 Tainted: G             L      syzkaller #0 PREEMPT_{RT,(full)} 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/18/2026
Workqueue: ib-unreg-wq ib_unregister_work
RIP: 0010:ib_dealloc_device+0x187/0x200 drivers/infiniband/core/device.c:682
Code: e8 de ec ad f9 48 89 df e8 56 59 07 00 48 81 c3 30 08 00 00 48 89 df 5b 41 5c 41 5e 41 5f 5d e9 0f 09 60 fd e8 ba ec ad f9 90 <0f> 0b 90 e9 72 ff ff ff e8 ac ec ad f9 90 0f 0b 90 eb 8f e8 a1 ec
RSP: 0018:ffffc9000f49fa18 EFLAGS: 00010293
RAX: ffffffff88169536 RBX: ffff888039d40000 RCX: ffff88806a691e80
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff888039d41308 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: fffffbfff1ed4eb7 R12: 1ffff110073a81fd
R13: dffffc0000000000 R14: ffff888039d41268 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff888126332000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff6d2897e9c CR3: 0000000022382000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000f1ffffdf
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __ib_unregister_device+0x393/0x3f0 drivers/infiniband/core/device.c:1545
 ib_unregister_work+0x19/0x30 drivers/infiniband/core/device.c:1639
 process_one_work kernel/workqueue.c:3276 [inline]
 process_scheduled_works+0xb6e/0x18c0 kernel/workqueue.c:3359
 worker_thread+0xa53/0xfc0 kernel/workqueue.c:3440
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
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

