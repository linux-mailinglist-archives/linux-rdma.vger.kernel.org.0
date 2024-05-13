Return-Path: <linux-rdma+bounces-2441-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F30638C3A29
	for <lists+linux-rdma@lfdr.de>; Mon, 13 May 2024 04:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A210C2810B3
	for <lists+linux-rdma@lfdr.de>; Mon, 13 May 2024 02:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E4012F5A4;
	Mon, 13 May 2024 02:22:31 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351FD4C81
	for <linux-rdma@vger.kernel.org>; Mon, 13 May 2024 02:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715566951; cv=none; b=HYuqahdU9OieoSqxp3xvM9maWRtfl880ewgp/z9H8aTa3Ou7hbYxvxd+VXoNut4xuWcD4IfsETrT90GVq4Oa0/1jIm3ag54hQ7pu+cE+G4gadYmPKQAbk2OZHVEnB00JQqfSPcCHYEsldrBM5fqQgezbFtUHn5ixwuWKdVsT6wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715566951; c=relaxed/simple;
	bh=BGOYuBstjzxCkYy/YBDDh8zadeO+Bf9CctAwwCzTC18=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MLZPYnT6q8v00WzkJ5aO+kElfWDRGASi4DGeuNgsdf4j1smQbbnibBOJwWF7L54ings4e2Y2tDPRN5m36KY3V/NHxjF+Y9sHsorl+ugZST9hvk0KVBRdXF6BLQzLVSIJ+owBzODi8hfcU6N4/nWUOZeZGzVit+QAbMKTlzeFRAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-7e1de4c052aso82915439f.0
        for <linux-rdma@vger.kernel.org>; Sun, 12 May 2024 19:22:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715566949; x=1716171749;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PCE4N6Qz1/EQEvgJRRs6zAjC2i17W0y0F9XWU5WUP+g=;
        b=fQnKLewAE4tlj8b5xLjtfKdK1kGlYstsMOO2oGaCsbvk+s5C5WRFFS6LyAq1YqhAkX
         y6UruAM+13C4WQ+c5MaW0L7wFpU8KmIbgHE4r2FQhCi4T9A7nAtkJdyBWBSdvWKH6Ygz
         +uaIyBYYtng5sJMv3x6Yct2j3+Ubrb05aliosCoxKA1qRViyTfv8pypVvpPlDV3rXAmB
         MqCUrZZNbsUMd2KmK81PpBa04UYhD69TYGyL95a2FlZGctyEpVbdjPxauUlQniZYthY5
         D1FaGFjVgvgek15gtiINvGbwtxHv+4iOAfNP07bezBUPDIZsgCPpubN7KfGp/MatY79J
         GRbA==
X-Forwarded-Encrypted: i=1; AJvYcCVX420MJLgM8Hu74VkBQduKE68Pgnf9AsC4GklnOOvhX7t7amy0zvxPcia9jELVJcKFjemVB/Qy//ctyH4ymhgkD4QCy0YqMbkjew==
X-Gm-Message-State: AOJu0YwrQ4NIZNkw0YFOq67T6ymmoE8IUyR2gGoM47bF8ArboClY35BC
	n3c7thkZ9khp1z4D2BpEu3gQML8orF9kd7RCfrxZnl2nH+36F+hi/EMTNZMYCeAsb1YfucfhaGM
	UBBnD0TmzcnJmHSBI4MnWaplX7A3kug2+c9rFHE+DH58QRK9hd4wXnV0=
X-Google-Smtp-Source: AGHT+IEJhT+L2K5Ugq1wKDm5t/n5gRJbo4ypMsYYL0pww2XxnNHs71i0DrjKLJHo4pRiPSGYicnWlYrOATONzbwNS3VfjizdwuZY
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:168b:b0:488:5bf6:f8ff with SMTP id
 8926c6da1cb9f-48959248773mr821530173.6.1715566948039; Sun, 12 May 2024
 19:22:28 -0700 (PDT)
Date: Sun, 12 May 2024 19:22:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000086d0e406184c8e78@google.com>
Subject: [syzbot] [rdma?] WARNING in rxe_pool_cleanup
From: syzbot <syzbot+221e213bf17f17e0d6cd@syzkaller.appspotmail.com>
To: jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, zyjzyj2000@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6d7ddd805123 Merge tag 'soc-fixes-6.9-3' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1567aa6c980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7144b4fe7fbf5900
dashboard link: https://syzkaller.appspot.com/bug?extid=221e213bf17f17e0d6cd
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-6d7ddd80.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/64e247bdde82/vmlinux-6d7ddd80.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b78396634af8/bzImage-6d7ddd80.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+221e213bf17f17e0d6cd@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 2 PID: 11465 at drivers/infiniband/sw/rxe/rxe_pool.c:116 rxe_pool_cleanup+0x41/0x60 drivers/infiniband/sw/rxe/rxe_pool.c:116
Modules linked in:
CPU: 2 PID: 11465 Comm: syz-executor.2 Not tainted 6.9.0-rc7-syzkaller-00023-g6d7ddd805123 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:rxe_pool_cleanup+0x41/0x60 drivers/infiniband/sw/rxe/rxe_pool.c:116
Code: 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 75 1f 48 83 bb 80 00 00 00 00 75 06 5b e9 95 28 73 f9 e8 90 28 73 f9 90 <0f> 0b 90 5b e9 86 28 73 f9 e8 81 75 ce f9 eb da 66 66 2e 0f 1f 84
RSP: 0018:ffffc90003baf170 EFLAGS: 00010246
RAX: 0000000000040000 RBX: ffff8880471b5228 RCX: ffffc90003f99000
RDX: 0000000000040000 RSI: ffffffff881aa460 RDI: ffff8880471b52a8
RBP: ffffffff88190dd0 R08: 0000000000000005 R09: 0000000000000000
R10: 00000000ffffffed R11: 0000000000000000 R12: ffffc90003baf600
R13: ffffc90003baf600 R14: ffff88804570c000 R15: 0000000000000000
FS:  00007fedd04706c0(0000) GS:ffff88806b400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1c5125dd58 CR3: 000000003df64000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 rxe_dealloc+0x26/0x110 drivers/infiniband/sw/rxe/rxe.c:24
 ib_dealloc_device+0x46/0x230 drivers/infiniband/core/device.c:657
 rxe_net_add+0xb2/0xe0 drivers/infiniband/sw/rxe/rxe_net.c:536
 rxe_newlink+0x70/0x190 drivers/infiniband/sw/rxe/rxe.c:197
 nldev_newlink+0x396/0x670 drivers/infiniband/core/nldev.c:1763
 rdma_nl_rcv_msg+0x388/0x6e0 drivers/infiniband/core/netlink.c:195
 rdma_nl_rcv_skb.constprop.0.isra.0+0x2e6/0x450 drivers/infiniband/core/netlink.c:239
 netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
 netlink_unicast+0x542/0x820 net/netlink/af_netlink.c:1361
 netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1905
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 ____sys_sendmsg+0xab5/0xc90 net/socket.c:2584
 ___sys_sendmsg+0x135/0x1e0 net/socket.c:2638
 __sys_sendmsg+0x117/0x1f0 net/socket.c:2667
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fedcf67dd69
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fedd04700c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fedcf7abf80 RCX: 00007fedcf67dd69
RDX: 0000000000000000 RSI: 00000000200001c0 RDI: 0000000000000004
RBP: 00007fedcf6ca49e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fedcf7abf80 R15: 00007ffcb1bc3058
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

