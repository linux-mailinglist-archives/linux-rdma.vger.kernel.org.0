Return-Path: <linux-rdma+bounces-5750-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 003969BC2FA
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Nov 2024 03:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB6F01F22ADE
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Nov 2024 02:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F71944375;
	Tue,  5 Nov 2024 02:10:23 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5322C190
	for <linux-rdma@vger.kernel.org>; Tue,  5 Nov 2024 02:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730772622; cv=none; b=u69MTzKTuLPI/LcNgI/FLaYyIvOtrKb2n0RVE+6n4sNHgQ8/B2jcWH9uumIY09rW5Nxm62vyAz9s4gCfzRt7tRzKzQkURh9t9MVn4Rr4UNUyWaQEMWcz5eNvIFj6f22m/iPBq9QldbZfuilxwU7PI2NYTV/UqPN1N95kA4dlB88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730772622; c=relaxed/simple;
	bh=WOG2w6ROnRZSeXpBfdm1M5ozrfMG8hm2/mR6/2ljo78=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=S64jbHUzisJRFN2joRxgcaxBdIIhwu7rSYWT2mRIxMplFdUI40wFh4Sl4qhRuGNO/Rk9axwvadawA1Lp6AWGWSEgZJM0ksvW2iUECZe5226Vb1pmKfqTT9FQ9c/zyWt9MDnaksTMim9Rp4z7O178HWm5bSx/GBw0uDtEJDQp5iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3c90919a2so54049295ab.0
        for <linux-rdma@vger.kernel.org>; Mon, 04 Nov 2024 18:10:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730772620; x=1731377420;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pOwK7LgCTCkhpBtnCmrshYoV78C7UhrxMFbq+MY09GY=;
        b=JTxfyNdf+BQjC0CMIbPxQd/70/elEVtV8H0o596rYifqOYCGOXGHOcNyUJsNMqu19R
         XP6ehtnY29a8SP3khkaxz5v+OI0fm5K4OugNSjACiGuU7bgcjPw0Asdu9mYhSbAbzhdV
         w13sqiENrqhZQXsO6DZBrjEYWGDwBJUKDgmj2GAIXSU21kzzYarhNruKkD3aAEUdxZcU
         UjVKcWjFnDx8ERJPFEPNrfSZouypZVvaRoPS16hhqYGxpIvR3YkvC/rlhdBd8VgQ1BGU
         fhs03DPzLstIeNeocfxBq0npfltajXA14QDapCoQLq1cX208xhXS6ALVYWt+E7sbhQPW
         KMcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXN7SL8AYsfnaleq8AhxF9At1l9fCnyI7aUzeMD9e17GLPtX+VNyIMyOpUvGKSV7tV1Iq783B/WgtyW@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq7/lA7OdvQhhyj7uc4SMWtjLH9DgbcadKL8MU2t2fbkbV1NGJ
	QnRkCnb5CN6zJZ/pbSTOODJqfUyRnIv33rncxF9exmw4Ltv9O1VRg0PQGk5yViv1riaOEsQ8FBq
	9v+N/MmaXE8ntQG0MazIScbF8obZA5DijshZODbHta5c7QjTwboT0HOQ=
X-Google-Smtp-Source: AGHT+IFmFAjJO8uzUsuCAVpvck1Ngr6POR2cxcKVMv7earv4Zm+aMtsG/f0rRxn1JsuyuBFlvcE+i4tJFgztvHW4mdoNEuXhCN4e
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a4b:b0:39f:5e12:1dde with SMTP id
 e9e14a558f8ab-3a4ed2f2830mr327954935ab.21.1730772620239; Mon, 04 Nov 2024
 18:10:20 -0800 (PST)
Date: Mon, 04 Nov 2024 18:10:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67297e8c.050a0220.2edce.14fe.GAE@google.com>
Subject: [syzbot] [rdma?] WARNING in ib_uverbs_release_dev (2)
From: syzbot <syzbot+a617d4c5ff27f35f8255@syzkaller.appspotmail.com>
To: jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0fc810ae3ae1 x86/uaccess: Avoid barrier_nospec() in 64-bit..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15ac9340580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4aec7739e14231a7
dashboard link: https://syzkaller.appspot.com/bug?extid=a617d4c5ff27f35f8255
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d7ec34ee152e/disk-0fc810ae.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ba87040ccb6c/vmlinux-0fc810ae.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0e189a9b5a22/bzImage-0fc810ae.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a617d4c5ff27f35f8255@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 8645 at kernel/rcu/srcutree.c:656 cleanup_srcu_struct+0x404/0x4d0 kernel/rcu/srcutree.c:656
Modules linked in:
CPU: 1 UID: 0 PID: 8645 Comm: kworker/u8:11 Not tainted 6.12.0-rc5-syzkaller-00063-g0fc810ae3ae1 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: ib-unreg-wq ib_unregister_work
RIP: 0010:cleanup_srcu_struct+0x404/0x4d0 kernel/rcu/srcutree.c:656
Code: 4d 84 00 48 c7 03 00 00 00 00 48 83 c4 48 5b 41 5c 41 5d 41 5e 41 5f 5d e9 84 f4 75 0a 90 0f 0b 90 eb e7 90 0f 0b 90 eb e1 90 <0f> 0b 90 eb db 90 0f 0b 90 eb 0a 90 0f 0b 90 eb 04 90 0f 0b 90 48
RSP: 0018:ffffc90003f07930 EFLAGS: 00010202
RAX: 0000000000000001 RBX: ffff888079789980 RCX: 0000000000000002
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffe8ffffd59658
RBP: 0000000000000001 R08: ffffe8ffffd5965f R09: 1ffffd1ffffab2cb
R10: dffffc0000000000 R11: fffff91ffffab2cc R12: dffffc0000000000
R13: ffff88805bab05e8 R14: ffff88805bab0000 R15: ffff888079789800
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7b86306d58 CR3: 0000000060ea6000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 ib_uverbs_release_dev+0x4e/0x80 drivers/infiniband/core/uverbs_main.c:136
 device_release+0x9b/0x1c0
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x231/0x480 lib/kobject.c:737
 remove_client_context+0xb9/0x1e0 drivers/infiniband/core/device.c:782
 disable_device+0x13b/0x360 drivers/infiniband/core/device.c:1288
 __ib_unregister_device+0x2ac/0x3d0 drivers/infiniband/core/device.c:1518
 ib_unregister_work+0x19/0x30 drivers/infiniband/core/device.c:1630
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa65/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
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

