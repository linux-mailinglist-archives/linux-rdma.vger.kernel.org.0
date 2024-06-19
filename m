Return-Path: <linux-rdma+bounces-3292-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0036590E399
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2024 08:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 795261F24686
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2024 06:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B4E6F2F1;
	Wed, 19 Jun 2024 06:37:20 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109294C98
	for <linux-rdma@vger.kernel.org>; Wed, 19 Jun 2024 06:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718779040; cv=none; b=Y6nPM5j2GORVpDeOnydo29of/dEaL0U7aiu5c+o4i3f8LCCo/C9WcXZgYUqXCj08T4SjU1XobQb8xrIn4Jyek/PfXFrML4h79jqvWjYONP0BtUjrCxPQORRKyzjDhMAfXNAhhCupOq2rNXGnOvcvfCnR0MeuiwH474TDDF08Baw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718779040; c=relaxed/simple;
	bh=0z64VV3tdxabQq7QXHNJZwW0mSURlemtbgmNNUvtcqc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=PMCeG+STE2SkJKR1UGoYSu4qQ4qtNkw5gxMwARF80rCEtb07e+9lp3jajEIs4dvQgtAf/bOfI9YAK4cG6gsHDWvDFMU+jeAtU7UKDaAHnnNksCslM5mSIkbzu8/IwkRClcAoIlhckPzzU5A1wX6yD2Bdu39aDxilWBfaJR+6n4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3761cec5b39so8330495ab.0
        for <linux-rdma@vger.kernel.org>; Tue, 18 Jun 2024 23:37:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718779038; x=1719383838;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lKRR7Pu4ur95ahqOkWUJajla0ZS5PHik9EHx/Q1niso=;
        b=xIRHHpVlDMJLztCxBfQQs/PCeoJaY068T/QSjyqY/MITgUosS5k8qDoLUmf1JQC7Dl
         XIdtS8w48eOff5FReegP7gupBI9ylXjmb8v/EAw/yDXxoKZmEWHxuOxwIMWV6eVED8Qu
         nRObrk7GEvyVe4yJi5tK3OIbxMSK0jS0kQAqbTvZqV6VKHhDymQiHt2gRndECwdZUSSz
         TLHp61XkFEh9ZpjDpPlBP7RaIy4y+/ObfBIs28JiXGb973QFtK/H+heGv4iojz4CtzW8
         wY1WClfhYMdTbKrmalAVHWIIbSvSTq5cvyGmbfrN1R6Kn1ZiBZevqnmPMNxgU1OGS/PI
         wPOw==
X-Forwarded-Encrypted: i=1; AJvYcCXumwZGsP7q6+ecLr1ho44d8hBeCb+Efx0zffOSnharwCcoVb3Z74T8xAZ1zcT2x/e6wc/y5rSZ428KHGoVTNP9bdXuLP6Ql9c83w==
X-Gm-Message-State: AOJu0YycZecr+5IfZqLXKZsM2f/1gkm/DEA6D42bntZ+9FIzn6FikyWG
	vUnXwV6qxOOuLRnUWs6UIsbe1NvMByI8zL7IuBg4LWAk5WqUW2QhGC05YO8xqQAq8wJgZ9PgyTf
	cgxeSCx2rG4SDWiHfxQzkeBrnTQxVQO9E4DJCDvHh0eQPyD1aD8xw1hE=
X-Google-Smtp-Source: AGHT+IFVjj07L1AdLCCar8TpedvGivk7nJb+5deA/qD8EzAkCU8m/tTFpv4F88j0t+6hmFG8svdjcnlN9922Vb353k5um2B5lnhh
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20ed:b0:375:e04f:55d0 with SMTP id
 e9e14a558f8ab-3761d6665aemr1055475ab.2.1718779038231; Tue, 18 Jun 2024
 23:37:18 -0700 (PDT)
Date: Tue, 18 Jun 2024 23:37:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000057e4c061b386e23@google.com>
Subject: [syzbot] [rdma?] WARNING in ib_uverbs_release_dev
From: syzbot <syzbot+19ec7595e3aa1a45f623@syzkaller.appspotmail.com>
To: jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2ccbdf43d5e7 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=179e93fe980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa0ce06dcc735711
dashboard link: https://syzkaller.appspot.com/bug?extid=19ec7595e3aa1a45f623
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/27e64d7472ce/disk-2ccbdf43.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e1c494bb5c9c/vmlinux-2ccbdf43.xz
kernel image: https://storage.googleapis.com/syzbot-assets/752498985a5e/bzImage-2ccbdf43.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+19ec7595e3aa1a45f623@syzkaller.appspotmail.com

smc: removing ib device syz0
------------[ cut here ]------------
WARNING: CPU: 0 PID: 51 at kernel/rcu/srcutree.c:653 cleanup_srcu_struct+0x404/0x4d0 kernel/rcu/srcutree.c:653
Modules linked in:
CPU: 0 PID: 51 Comm: kworker/u8:3 Not tainted 6.10.0-rc3-syzkaller-00044-g2ccbdf43d5e7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Workqueue: ib-unreg-wq ib_unregister_work
RIP: 0010:cleanup_srcu_struct+0x404/0x4d0 kernel/rcu/srcutree.c:653
Code: 12 80 00 48 c7 03 00 00 00 00 48 83 c4 48 5b 41 5c 41 5d 41 5e 41 5f 5d e9 14 67 34 0a 90 0f 0b 90 eb e7 90 0f 0b 90 eb e1 90 <0f> 0b 90 eb db 90 0f 0b 90 eb 0a 90 0f 0b 90 eb 04 90 0f 0b 90 48
RSP: 0018:ffffc90000bb7970 EFLAGS: 00010202
RAX: 0000000000000001 RBX: ffff88802a1bc980 RCX: 0000000000000002
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffe8ffffd74c58
RBP: 0000000000000001 R08: ffffe8ffffd74c5f R09: 1ffffd1ffffae98b
R10: dffffc0000000000 R11: fffff91ffffae98c R12: dffffc0000000000
R13: ffff88802285b5f0 R14: ffff88802285b000 R15: ffff88802a1bc800
FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa3852cae10 CR3: 000000000e132000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 ib_uverbs_release_dev+0x4e/0x80 drivers/infiniband/core/uverbs_main.c:136
 device_release+0x9b/0x1c0
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x231/0x480 lib/kobject.c:737
 remove_client_context+0xb9/0x1e0 drivers/infiniband/core/device.c:776
 disable_device+0x13b/0x360 drivers/infiniband/core/device.c:1282
 __ib_unregister_device+0x6d/0x170 drivers/infiniband/core/device.c:1475
 ib_unregister_work+0x19/0x30 drivers/infiniband/core/device.c:1586
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2e/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3393
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
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

