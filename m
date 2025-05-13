Return-Path: <linux-rdma+bounces-10323-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E5BAB53ED
	for <lists+linux-rdma@lfdr.de>; Tue, 13 May 2025 13:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A6947A8609
	for <lists+linux-rdma@lfdr.de>; Tue, 13 May 2025 11:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B272428D8D6;
	Tue, 13 May 2025 11:35:26 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC83A28C5A7
	for <linux-rdma@vger.kernel.org>; Tue, 13 May 2025 11:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747136126; cv=none; b=gL/ILGtLXZcVF2N/Szfy5m95xNmVRXt5nK1ybH0Z8wQX0f96s/sT7f9I+ts6R54/Z9uVk/z4JSowczDP4/f/tDuU1oyHnXd+kx9R/aLsaZcud6a7MiZH9mmq93C4htgcq0kU4QsYdp306cJJdECcH9iTZhvCghCLz+7PKWBG3ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747136126; c=relaxed/simple;
	bh=orXnwULQawkLIGpLkcPXi2RjlgIYfqxirWiOTQryajw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=b2vL7MEq5TP0RRFKYvwO5OeZBQmLhuENaMQLNzmKgBFDoeC8pUXfFh40xkLh6vvLCFhr6bHakEeD5PDwCTAIaSvGdOQKXaygcD1RrlTUQ+xl7unEe7akWgQDBet2APS7+XmL6lBJHqLEnUk5aJZB6Tp7mULkgSfW7KK+UL1T8rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3d81bc9b763so96434895ab.0
        for <linux-rdma@vger.kernel.org>; Tue, 13 May 2025 04:35:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747136124; x=1747740924;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BuK+EG1w5n8FuIzGPWfhuCUKMo645OYamZBWMdR3Pa4=;
        b=wUBEPgKRTiUlyIRAu9WGGV0bUBEPcvwMXS/RKmjo5Smo0fOSkH2UWC+dnAYkxwEJiE
         E2XTZJwT6oJ81aIjSjepLayJ4WW1p1csveiIXQk0nNde/1pF0iF/V9aHIK6HjPdUblEf
         aOzxF1CY6dYs/HUxEoUD6Cxd4uQO7UtG5YjZ3eRUDQEiAl878BXXbfKtSjVrALdmcrpS
         RrBqcLnpx0Ibc4qAWd+B17/V0qENbbNE626cFRKtHaILGxkljE+7QyH+iGUD3AU+aFRN
         RKElSHmMD0dEqU5zmZ1ZW8mJ5+o/x93hu9Z95m+wgytWu001xVKjvo+R+pAwcSMgsmO7
         i5HQ==
X-Forwarded-Encrypted: i=1; AJvYcCXV2WrMC/U8u54uJZ2uUEdGHn5Jx07n5aSBPwQvueTnBD7l+Xw//u2Zl8eKdaXy2+vr8FB8IhTPnUR9@vger.kernel.org
X-Gm-Message-State: AOJu0Yzet+SJSdt8veKSI1KTagsHvSenymYzUzuj75I+IDbArVyWfBMJ
	2/+8tI57J8KQiWbR5c1Ut8fLJDXiTfKICkvteDeYGzih61l8of8WCpr19Kisf3RQmoyioE4L2QT
	OqAf5gFm1dlpHLz36OOqFP7pN4CcakC9myVPwz58aRcVjkikJ46tanM8=
X-Google-Smtp-Source: AGHT+IFaNVZy8sPC9ij4yVOwaXCnxWULPQ6Jpp/qdlhZVzaIF9BsSP63qTzmN2i/jOkP/Vj7k0VLWwdMdaFwfoayxieU+S6z6z74
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4414:10b0:3db:6c09:a60d with SMTP id
 e9e14a558f8ab-3db6c09a7cbmr5548625ab.19.1747136123861; Tue, 13 May 2025
 04:35:23 -0700 (PDT)
Date: Tue, 13 May 2025 04:35:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68232e7b.050a0220.f2294.09f6.GAE@google.com>
Subject: [syzbot] [rdma?] WARNING in gid_table_release_one (3)
From: syzbot <syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com>
To: jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c32f8dc5aaf9 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=10789768580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ea4635ffd6ad5b4a
dashboard link: https://syzkaller.appspot.com/bug?extid=b0da83a6c0e2e2bddbd4
compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15a08cf4580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b921498959d4/disk-c32f8dc5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/04e6ad946c4b/vmlinux-c32f8dc5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d4f0d8db50ee/Image-c32f8dc5.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com

--
------------[ cut here ]------------
GID entry ref leak for dev syz1 index 2 ref=573
WARNING: CPU: 1 PID: 655 at drivers/infiniband/core/cache.c:809 release_gid_table drivers/infiniband/core/cache.c:806 [inline]
WARNING: CPU: 1 PID: 655 at drivers/infiniband/core/cache.c:809 gid_table_release_one+0x284/0x3cc drivers/infiniband/core/cache.c:886
Modules linked in:
CPU: 1 UID: 0 PID: 655 Comm: kworker/u8:10 Not tainted 6.15.0-rc5-syzkaller-gc32f8dc5aaf9 #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Workqueue: ib-unreg-wq ib_unregister_work
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : release_gid_table drivers/infiniband/core/cache.c:806 [inline]
pc : gid_table_release_one+0x284/0x3cc drivers/infiniband/core/cache.c:886
lr : release_gid_table drivers/infiniband/core/cache.c:806 [inline]
lr : gid_table_release_one+0x284/0x3cc drivers/infiniband/core/cache.c:886
sp : ffff80009c927860
x29: ffff80009c9278b0 x28: ffff0000d2b52f00 x27: ffff0000d77ee8d8
x26: ffff0000d77ee800 x25: 0000000000000010 x24: 0000000000000001
x23: ffff800092818000 x22: dfff800000000000 x21: 0000000000000003
x20: 1fffe0001aefdd1b x19: 1fffe0001aefdd00 x18: 00000000ffffffff
x17: 0000000000000000 x16: ffff80008adb410c x15: 0000000000000001
x14: 1fffe000338716e2 x13: 0000000000000000 x12: 0000000000000000
x11: ffff6000338716e3 x10: 0000000000ff0100 x9 : 1b90c18326689500
x8 : 1b90c18326689500 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff80009c9271b8 x4 : ffff80008f405b40 x3 : ffff8000807b1330
x2 : 0000000000000001 x1 : 0000000100000000 x0 : 0000000000000000
Call trace:
 release_gid_table drivers/infiniband/core/cache.c:806 [inline] (P)
 gid_table_release_one+0x284/0x3cc drivers/infiniband/core/cache.c:886 (P)
 ib_cache_release_one+0x144/0x174 drivers/infiniband/core/cache.c:1636
 ib_device_release+0xc4/0x194 drivers/infiniband/core/device.c:482
 device_release+0x8c/0x1ac drivers/base/core.c:-1
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x2b0/0x438 lib/kobject.c:737
 put_device+0x28/0x40 drivers/base/core.c:3800
 ib_unregister_work+0x28/0x38 drivers/infiniband/core/device.c:1629
 process_one_work+0x7e8/0x156c kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x958/0xed8 kernel/workqueue.c:3400
 kthread+0x5fc/0x75c kernel/kthread.c:464
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:847
irq event stamp: 1499918
hardirqs last  enabled at (1499917): [<ffff80008054cc08>] __up_console_sem kernel/printk/printk.c:344 [inline]
hardirqs last  enabled at (1499917): [<ffff80008054cc08>] __console_unlock+0x70/0xc4 kernel/printk/printk.c:2885
hardirqs last disabled at (1499918): [<ffff80008adaf5e0>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:511
softirqs last  enabled at (1496318): [<ffff8000803cbf1c>] softirq_handle_end kernel/softirq.c:425 [inline]
softirqs last  enabled at (1496318): [<ffff8000803cbf1c>] handle_softirqs+0xaf8/0xc88 kernel/softirq.c:607
softirqs last disabled at (1496303): [<ffff800080020efc>] __do_softirq+0x14/0x20 kernel/softirq.c:613
---[ end trace 0000000000000000 ]---
wlan1: Created IBSS using preconfigured BSSID 50:50:50:50:50:50
wlan1: Creating new IBSS network, BSSID 50:50:50:50:50:50


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

