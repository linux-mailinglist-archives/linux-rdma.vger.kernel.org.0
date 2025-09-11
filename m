Return-Path: <linux-rdma+bounces-13281-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3699AB537E2
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Sep 2025 17:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E992D5A19B5
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Sep 2025 15:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C76D33A03D;
	Thu, 11 Sep 2025 15:34:28 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDE5214A9B
	for <linux-rdma@vger.kernel.org>; Thu, 11 Sep 2025 15:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757604868; cv=none; b=awLtVkqrxujOj2y865Iv7+HU9sdRoBvKb5xCIA9VfGo9H/1WXtMEJuW3iMNUGZPanP40Y6/ajcYZ3ipWxuSZbFCadnrfa6v3xYHgSW7lbR32kNmehHxsLCE640hpmcaQSZXvEYtdSwV25t6prcpqjSB+HyhorMWpfFpL+BgXPBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757604868; c=relaxed/simple;
	bh=s8//uLaIyKucZnZ8MLKchIsTir7RSr+sKexuxxcUPco=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=perS4Nv46TrNt+iCGkVcOtlwk+ndJ3MUZJK9ZIS21B/cLhTTZWNPmCreAvvvbA3GCkdBEEzcU2E5CSHs9M8r/GYAcTLccEytNuGEseRlFf+NdUIZIEHDqQoyp8hvTwN85sadHUQgwM2FV3g+JTHsq0tAhfxcsQfxXwvuVTe317Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-88a7b9c831aso145755339f.0
        for <linux-rdma@vger.kernel.org>; Thu, 11 Sep 2025 08:34:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757604865; x=1758209665;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TfoQRV18n2TXavn1Lm8saXuaz+6pSqsVAdNPhzd660c=;
        b=unidJecu9u0X7Tat6PB3U+rPEKwI77UuQ+PlPe3yp+5vrHwXYdQD3vr2OLMRmWZClM
         Q/SgQH3UvvH5UAgc4wfeZ/rBoCWpc5rENOshY1OMRpRG3CXAPUV4IcoM/rIWTLIGwK8r
         ecLlov7Yw/itDzOXPWr+QKlCusDR6DhAUb1LEWFebVzDauoct15JWT0axoBYrj1pi0ZA
         9v+lZM2Se3YQA+bLUMt6SXz7w8wNMJ+n8wKQCRGwqMsK26p9QubSyA+NSdiP+RG/tghB
         +OTBffk7gbbF0jY0WLsSpFdWXDKjdKcjtpkS5kgBQOJn66fXVUsfy0huzxZPn8bdLHA+
         ZKxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXg8NgV9KlwkG2Z60fIZngP90jCApaclRuQ5fajOykP7YXnEi/x4pVFac3hmAtR1+KHQGcGs1nhnmMv@vger.kernel.org
X-Gm-Message-State: AOJu0Yw15Fif2De8OUD/WepUYIYUTyq3MtD22Q/1YRLz5UccZ6/0eo9U
	mXVcVU2LPB4+pb9/VShjWocThkcHyTpsWpq8dsB8vuG48JH8gnXfycYSSlSgYlBtxVzuGSwaA2o
	Yu/TY1KuM4HTD7AFtnvOrQ/a18UBR27fKRzMpRyUmnF9UV77C8qJA6eaw9Os=
X-Google-Smtp-Source: AGHT+IGX+yKtSj+JzzsB0n6KIsgUET53Ks5lrcXKQf7kZZ+8PzzchxgMZ6WrdhrXxq9KKZhuN+vOkxVX9QyKZIFTVuXxcDg8zjWj
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1909:b0:3e5:4e4f:65df with SMTP id
 e9e14a558f8ab-4209e64b9dfmr331225ab.9.1757604865442; Thu, 11 Sep 2025
 08:34:25 -0700 (PDT)
Date: Thu, 11 Sep 2025 08:34:25 -0700
In-Reply-To: <68232e7b.050a0220.f2294.09f6.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c2ec01.050a0220.3c6139.003f.GAE@google.com>
Subject: Re: [syzbot] [rdma?] WARNING in gid_table_release_one (3)
From: syzbot <syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com>
To: edwards@nvidia.com, jgg@ziepe.ca, leon@kernel.org, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    5f540c4aade9 Add linux-next specific files for 20250910
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=157dab12580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5ed48faa2cb8510d
dashboard link: https://syzkaller.appspot.com/bug?extid=b0da83a6c0e2e2bddbd4
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15b52362580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16b41642580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/df0dfb072f52/disk-5f540c4a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/20649042ae30/vmlinux-5f540c4a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4c16358268b8/bzImage-5f540c4a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com

------------[ cut here ]------------
GID entry ref leak for dev syz1 index 2 ref=615
WARNING: drivers/infiniband/core/cache.c:809 at release_gid_table drivers/infiniband/core/cache.c:806 [inline], CPU#0: kworker/u8:2/36
WARNING: drivers/infiniband/core/cache.c:809 at gid_table_release_one+0x346/0x4d0 drivers/infiniband/core/cache.c:886, CPU#0: kworker/u8:2/36
Modules linked in:
CPU: 0 UID: 0 PID: 36 Comm: kworker/u8:2 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
Workqueue: ib-unreg-wq ib_unregister_work
RIP: 0010:release_gid_table drivers/infiniband/core/cache.c:806 [inline]
RIP: 0010:gid_table_release_one+0x346/0x4d0 drivers/infiniband/core/cache.c:886
Code: e8 03 48 b9 00 00 00 00 00 fc ff df 0f b6 04 08 84 c0 75 3d 41 8b 0e 48 c7 c7 a0 43 91 8c 4c 89 e6 44 89 fa e8 fb 67 f5 f8 90 <0f> 0b 90 90 e9 e3 fe ff ff 44 89 e9 80 e1 07 80 c1 03 38 c1 0f 8c
RSP: 0018:ffffc90000ac7908 EFLAGS: 00010246
RAX: 621d731dcb27e200 RBX: ffff88806241b8d8 RCX: ffff888141289e40
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000002
RBP: 1ffff1100c48371b R08: ffff8880b8724253 R09: 1ffff110170e484a
R10: dffffc0000000000 R11: ffffed10170e484b R12: ffff888027503e00
R13: ffff88806241b800 R14: ffff8880289a2400 R15: 0000000000000002
FS:  0000000000000000(0000) GS:ffff8881259f0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555569847588 CR3: 00000000338c8000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 ib_device_release+0xd2/0x1c0 drivers/infiniband/core/device.c:509
 device_release+0x99/0x1c0 drivers/base/core.c:-1
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x228/0x480 lib/kobject.c:737
 process_one_work kernel/workqueue.c:3263 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3346
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x47c/0x820 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

