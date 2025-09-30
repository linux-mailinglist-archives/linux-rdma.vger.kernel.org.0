Return-Path: <linux-rdma+bounces-13747-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 652DDBAE8AD
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Sep 2025 22:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFE8B1893DBE
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Sep 2025 20:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4D527E07A;
	Tue, 30 Sep 2025 20:29:35 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1834D20C038
	for <linux-rdma@vger.kernel.org>; Tue, 30 Sep 2025 20:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759264175; cv=none; b=kAw2So4HSCD4TM5qkg35f45BDw2mDC4G1Ju75aaar4iD2awQTK6IKBgbTYjmMyTvDIolbWwyLLF25bMrh6dobCUx7y75ZsdRpGHtsbTbKfjzsEN2koFl9GZ3CzcgMnd/KR7D/DGh52OX9tuePeFp+KHx7xM8GVPZZGRO1YXFEI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759264175; c=relaxed/simple;
	bh=JWDPpUdmrq8kFuCinsRqhhI6vHfCxCFas1mQMZ+q478=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ZWe+YNhQa3V659b51tAhkpotm75fS0H9FkGhx/s/bAnDd+KJZSzlBJTT73g8L2KncS0motLHYDZPbU2R6mHoqweKZybsDVz+ziZmvS96HO2OKcRULxVzECuNJyBcIzNLLoWrHX16Nnun7EjjSRBJYZYyQizMpHQT3/7BHzD3TYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-4284df6ceaaso123129395ab.1
        for <linux-rdma@vger.kernel.org>; Tue, 30 Sep 2025 13:29:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759264172; x=1759868972;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PwZGXRreT4dh1LQQqf850vLqtz1BFdUD5wU0nKR0gU0=;
        b=GIkljXiWRhVU8ICUcYmTk+XgTo9Q0GxOpa235xDkqf7lOmmYfrPiLdCo43n5bwXo2n
         CeAN8C3C30s1VK+tJWvNV+9mQ1JAbjN4XOkvtUdAtLf0vuEluvTDuKLWwPUe8Jtmtngr
         KhghmZWvOWA7y16IR6DmdPu+5wm97q3Uj73GjuhEYINhGCw8G7SRquBbh0u8Ycs5jTJg
         weLd85KnozeVBF6+yi+gm0CF+1mjmXZ5wljmPEmYYbgYkJNLiunJrN3WPOwPk3u2ok1Z
         PVC/5sBE8AL9Nhm9AxPSQu9j7UtKElS8seYIdNqAQJYFkHzpCy+fMcO5shgqAu1t3XD2
         oFHg==
X-Forwarded-Encrypted: i=1; AJvYcCWH5GAw6g2dAop7sR+AGMXOzFisBxa3q3wt9yewbMSIzGSaLKx6pnCLFOrMUu1NYKpyTh6/KB/hrKDI@vger.kernel.org
X-Gm-Message-State: AOJu0YxPIAJKnmRRn1LsssxWftIJhrh6cMuUJqnFNte6Aj31O24M4zXp
	v3vXiKE7JD3/IJDrwxXPfBC3MJrj0Ka816BgaCgZl0iH1PEo697bmqZNSkuwUjzC+hcNgFmqDnl
	991eXOYsUBej+fN3IQ69tp8eJbTEnJdMXC2Z8ErtGCRkhKLrV55Qytg78sew=
X-Google-Smtp-Source: AGHT+IH0G7HvVsaEFQQ3avovgw55Cppirm/bVwCVV7M9ntN5teSIZwn4rXKTPEQBBjrreziX+bY2D4val9odavdG6PoGqniJzhQ/
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a23:b0:425:70c5:61b3 with SMTP id
 e9e14a558f8ab-42d81647952mr19723125ab.27.1759264172207; Tue, 30 Sep 2025
 13:29:32 -0700 (PDT)
Date: Tue, 30 Sep 2025 13:29:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68dc3dac.a00a0220.102ee.004f.GAE@google.com>
Subject: [syzbot] [rdma?] KMSAN: uninit-value in ib_nl_handle_ip_res_resp
From: syzbot <syzbot+938fcd548c303fe33c1a@syzkaller.appspotmail.com>
To: jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    1896ce8eb6c6 Merge tag 'fsverity-for-linus' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=153d0092580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6eca10e0cdef44f
dashboard link: https://syzkaller.appspot.com/bug?extid=938fcd548c303fe33c1a
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d0fbab3c0b62/disk-1896ce8e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/71c7b444e106/vmlinux-1896ce8e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/96a4aa63999d/bzImage-1896ce8e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+938fcd548c303fe33c1a@syzkaller.appspotmail.com

netlink: 8 bytes leftover after parsing attributes in process `syz.8.3246'.
=====================================================
BUG: KMSAN: uninit-value in hex_byte_pack include/linux/hex.h:13 [inline]
BUG: KMSAN: uninit-value in ip6_string+0xef4/0x13a0 lib/vsprintf.c:1490
 hex_byte_pack include/linux/hex.h:13 [inline]
 ip6_string+0xef4/0x13a0 lib/vsprintf.c:1490
 ip6_addr_string+0x18a/0x3e0 lib/vsprintf.c:1509
 ip_addr_string+0x245/0xee0 lib/vsprintf.c:1633
 pointer+0xc09/0x1bd0 lib/vsprintf.c:2542
 vsnprintf+0xf8a/0x1bd0 lib/vsprintf.c:2930
 vprintk_store+0x3ae/0x1530 kernel/printk/printk.c:2279
 vprintk_emit+0x307/0xcd0 kernel/printk/printk.c:2426
 vprintk_default+0x3f/0x50 kernel/printk/printk.c:2465
 vprintk+0x36/0x50 kernel/printk/printk_safe.c:82
 _printk+0x17e/0x1b0 kernel/printk/printk.c:2475
 ib_nl_process_good_ip_rsep drivers/infiniband/core/addr.c:128 [inline]
 ib_nl_handle_ip_res_resp+0x963/0x9d0 drivers/infiniband/core/addr.c:141
 rdma_nl_rcv_msg drivers/infiniband/core/netlink.c:-1 [inline]
 rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
 rdma_nl_rcv+0xefa/0x11c0 drivers/infiniband/core/netlink.c:259
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0xf04/0x12b0 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x10b3/0x1250 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg+0x333/0x3d0 net/socket.c:729
 ____sys_sendmsg+0x7e0/0xd80 net/socket.c:2617
 ___sys_sendmsg+0x271/0x3b0 net/socket.c:2671
 __sys_sendmsg+0x1aa/0x300 net/socket.c:2703
 __compat_sys_sendmsg net/compat.c:346 [inline]
 __do_compat_sys_sendmsg net/compat.c:353 [inline]
 __se_compat_sys_sendmsg net/compat.c:350 [inline]
 __ia32_compat_sys_sendmsg+0xa4/0x100 net/compat.c:350
 ia32_sys_call+0x3f6c/0x4310 arch/x86/include/generated/asm/syscalls_32.h:371
 do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
 __do_fast_syscall_32+0xb0/0x150 arch/x86/entry/syscall_32.c:306
 do_fast_syscall_32+0x38/0x80 arch/x86/entry/syscall_32.c:331
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/syscall_32.c:369
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e

Local variable gid.i created at:
 ib_nl_process_good_ip_rsep drivers/infiniband/core/addr.c:102 [inline]
 ib_nl_handle_ip_res_resp+0x254/0x9d0 drivers/infiniband/core/addr.c:141
 rdma_nl_rcv_msg drivers/infiniband/core/netlink.c:-1 [inline]
 rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
 rdma_nl_rcv+0xefa/0x11c0 drivers/infiniband/core/netlink.c:259

CPU: 0 UID: 0 PID: 17455 Comm: syz.8.3246 Not tainted syzkaller #0 PREEMPT(none) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
=====================================================


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

