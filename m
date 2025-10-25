Return-Path: <linux-rdma+bounces-14047-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 641D5C09BAE
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Oct 2025 18:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A3EE1AA732D
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Oct 2025 16:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B04305047;
	Sat, 25 Oct 2025 16:40:25 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96963225A3D
	for <linux-rdma@vger.kernel.org>; Sat, 25 Oct 2025 16:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761410425; cv=none; b=j79By+nnyPgkpe7FtpCDxJyJa5vPP/4vmw3UDoTMmbdSZLPZ9NEXHJtD5GBxo8RU6ZtVOolwCmPzcCL3j2KS1NzCO3GtkoPKrzIMzivakstE9HMQIapRnEeGktJyWacpb2BCsgZ3386ALQjEUciQaAcnrBrp2U1s6ZeAgSEACTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761410425; c=relaxed/simple;
	bh=IRBVnuQ2FKr6cm1CrZpwpIEDNABcXIhOzTRZSSkbA4o=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=tovNCwBOk9gc0egRYm1oekbDtlIOLHrb+PbC7d04IIJ09yKfU/6mf1kUWWnkL8Cpu/zvCsPS/QA3ZdqQzMqXv2owzCdDz1u7kraDxrpFsiV2bQQwDSspS4Yy6h/XXDdgfat60a1k2nEYUfhKgh4MsQwI4jMmgzvQdeueVesX6iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-93e8db8badeso332365339f.3
        for <linux-rdma@vger.kernel.org>; Sat, 25 Oct 2025 09:40:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761410422; x=1762015222;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f09ReGk/rcCE84mTMJ810aYtA5hb5qGQWaYl+no6AWs=;
        b=fXc2D6aHGUQkK4PGm+NIs2vjbWFOLAwRiCigrSXhJxqjx3BRQ+G/Ect2zKsmlDygja
         L8YqMTYnjB2CieHX/O4IRsAsQxLp/eZJdnQ51+hzVopH1gYLLoXsjtHg+yvkXjVdimVo
         Xb2Fzg2Dy/OE8yXQ8DhEREgQlDzOtwI0hEFVwfCSm5n68ek8sm4dKgx1S2sZ8ywde0i5
         AH+qeG2xPRS0Ope/2sz5lMpGcfzEX4fUbtjxKV6TQ1enRFls5UKJ1FdphoCk+Fm9njRh
         bz972QWkpVREFXZFZsAJub4mZGXHhdkKs5trZPiV+px7bFKsIWkn/6ENGj9jGua2Z/ui
         T7Zg==
X-Forwarded-Encrypted: i=1; AJvYcCURDUJl/x3h6zUZPoO+G8rjfKOuLhAg5x/TEZmuBqXzqDIVKbHbvNre1Z3wwkVISj+KwKULDgBjCjMZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxOCZzSiu820ljLJOVl/QtZuHu3/WedCDavDqt/gMJllKBMV9fB
	Le3VNBs/0KHkmayxvpegxCaKxTSjPN27wGzIXvXmqCf7UFwDsIX4ju0yotEEpAiLBqys5V1jBwe
	nuYq3xPoTkteBoBAq1ybdDPZWaMpwKenM8YHgLE+r2lwi8pSYEkf4rE6BnLY=
X-Google-Smtp-Source: AGHT+IEizQRhbwzsT0ggg2NbSvLb9A6mZiSSmAn0Yfk/ZQAxOcHAEaCQbj3upjiHzCayK+nIiXCaAoQeo8YggenpKLKisWYRQsuC
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2197:b0:42f:87c1:cc3f with SMTP id
 e9e14a558f8ab-430c526b099mr477214245ab.18.1761410421784; Sat, 25 Oct 2025
 09:40:21 -0700 (PDT)
Date: Sat, 25 Oct 2025 09:40:21 -0700
In-Reply-To: <68dc3dac.a00a0220.102ee.004f.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fcfd75.050a0220.346f24.02ff.GAE@google.com>
Subject: Re: [syzbot] [rdma?] KMSAN: uninit-value in ib_nl_handle_ip_res_resp
From: syzbot <syzbot+938fcd548c303fe33c1a@syzkaller.appspotmail.com>
To: enjuk@amazon.com, jgg@ziepe.ca, leon@kernel.org, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, yanjun.zhu@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    566771afc7a8 Merge tag 'v6.18-rc2-smb-server-fixes' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12f017e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dce7eac4016da338
dashboard link: https://syzkaller.appspot.com/bug?extid=938fcd548c303fe33c1a
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13714be2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=100b5d2f980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/bc5e0bc7a5d9/disk-566771af.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6b2be7ad3b45/vmlinux-566771af.xz
kernel image: https://storage.googleapis.com/syzbot-assets/09a4929333f1/bzImage-566771af.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+938fcd548c303fe33c1a@syzkaller.appspotmail.com

netlink: 8 bytes leftover after parsing attributes in process `syz.0.18'.
=====================================================
BUG: KMSAN: uninit-value in hex_byte_pack include/linux/hex.h:13 [inline]
BUG: KMSAN: uninit-value in ip6_string+0xef4/0x13a0 lib/vsprintf.c:1490
 hex_byte_pack include/linux/hex.h:13 [inline]
 ip6_string+0xef4/0x13a0 lib/vsprintf.c:1490
 ip6_addr_string+0x18a/0x3e0 lib/vsprintf.c:1509
 ip_addr_string+0x245/0xee0 lib/vsprintf.c:1633
 pointer+0xc09/0x1bd0 lib/vsprintf.c:2542
 vsnprintf+0xf8a/0x1bd0 lib/vsprintf.c:2930
 vprintk_store+0x3ae/0x1530 kernel/printk/printk.c:2252
 vprintk_emit+0x21a/0xb60 kernel/printk/printk.c:2399
 vprintk_default+0x3f/0x50 kernel/printk/printk.c:2438
 vprintk+0x36/0x50 kernel/printk/printk_safe.c:82
 _printk+0x17e/0x1b0 kernel/printk/printk.c:2448
 ib_nl_process_good_ip_rsep drivers/infiniband/core/addr.c:128 [inline]
 ib_nl_handle_ip_res_resp+0x963/0x9d0 drivers/infiniband/core/addr.c:141
 rdma_nl_rcv_msg drivers/infiniband/core/netlink.c:-1 [inline]
 rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
 rdma_nl_rcv+0xefa/0x11c0 drivers/infiniband/core/netlink.c:259
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0xf04/0x12b0 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x10b3/0x1250 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg+0x333/0x3d0 net/socket.c:742
 ____sys_sendmsg+0x7e0/0xd80 net/socket.c:2630
 ___sys_sendmsg+0x271/0x3b0 net/socket.c:2684
 __sys_sendmsg net/socket.c:2716 [inline]
 __do_sys_sendmsg net/socket.c:2721 [inline]
 __se_sys_sendmsg net/socket.c:2719 [inline]
 __x64_sys_sendmsg+0x211/0x3e0 net/socket.c:2719
 x64_sys_call+0x1dfd/0x3e30 arch/x86/include/generated/asm/syscalls_64.h:47
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Local variable gid.i created at:
 ib_nl_process_good_ip_rsep drivers/infiniband/core/addr.c:102 [inline]
 ib_nl_handle_ip_res_resp+0x254/0x9d0 drivers/infiniband/core/addr.c:141
 rdma_nl_rcv_msg drivers/infiniband/core/netlink.c:-1 [inline]
 rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
 rdma_nl_rcv+0xefa/0x11c0 drivers/infiniband/core/netlink.c:259

CPU: 0 UID: 0 PID: 6093 Comm: syz.0.18 Not tainted syzkaller #0 PREEMPT(none) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
=====================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

