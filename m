Return-Path: <linux-rdma+bounces-810-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F0B84214B
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jan 2024 11:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D89231C26A50
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jan 2024 10:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D65D4CB5C;
	Tue, 30 Jan 2024 10:31:29 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B02C2AD0F
	for <linux-rdma@vger.kernel.org>; Tue, 30 Jan 2024 10:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706610689; cv=none; b=ieM5qLh3Duk74Vnd3dvrOwP5KoioBMQEi3WCacXxEtrsXyGnumZDVWpkGYM90m//Fi0AsIIop09RxNrQb5zQB+v5vCHLdVrCPuxn69JLyZ5/eqs/sQVaOjPxp+EJDeihSs9Cy4oByynvN013yH2wzng9noVVvky2Kw3/okFw2Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706610689; c=relaxed/simple;
	bh=9VqX249zSR4zy8mldC92QkdE9/T1OOtmBQIPeZGJcdg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=OLMh1HmLrQXdcaLMbSJF16dccej1lth/KuF8DwWTugkgRb5k8u54k2MAFKYF61hPsODy0msQTykN5+qT2Z9eG0ZvzNS0a+8xdTFir+QMNevK82M6iEOgsKmgLIO0nffMo9ePG4mMLfgyij7gMd9waCQ85jGYZ6otbYbooy0Z6No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3637b396e6eso11688855ab.3
        for <linux-rdma@vger.kernel.org>; Tue, 30 Jan 2024 02:31:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706610686; x=1707215486;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p8aHeenGIyYqSgmMwLbHFVeE81sUtGnJ+u332DdJ8GQ=;
        b=ThD4JW3ZTv5cxXDLjM5UA8EQnJqaaD9087PreKKiQ2cbPysa8Q7R05w5DHcViZX9T9
         cNJKZ+H/7XiN04ptwQRvPKlHwqQWZUiLov45zxIvRulAFGivaeQeEFCSzmowrs5cTUY+
         8UMFNViGs0f41fT+BsrFSlJm3+crXrh0T77KUPJhzVowCGpy17UgONp3yOVqxVcK5Nmp
         bwmOqRKhhFoinkgKVSWfqNERHONCMZgtgKEanadqUhLiabIRnVzSKpzt/zDpBUfeXHWi
         Rrky8ylNWzqWOCAPTNzxZCJvn5Qtkc2bdSz3cuzFyc28MPrGdbNBlcFcPU85AGr0W8BC
         Q0sw==
X-Gm-Message-State: AOJu0Yy32gzomE+pN9NJ8f1C4Q/DV9a2SO5hnEn5SGPwJP4R52UJbCgH
	Qgr/3Gb6BmITT1mZ28EKDVrCSqcGO87f36byIGtmEaQUYC4GW25jIALqBinWI9/g2ho+mZthftr
	N5GaWwHSAW8Y8F7m+y9fqfoPmP/4mKMAN4dzQSxRcx5hFu/59V1d2iYA=
X-Google-Smtp-Source: AGHT+IFa1Na3ucioZ1Ia+JOTK1cq4gSYvfKxMOdvcetaCMbu8f78GYAr31JEPlssc+Vn95VGAvKsil3/eZgy0xH1T8WyszfiVfz5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:338b:b0:363:8be6:2b22 with SMTP id
 bn11-20020a056e02338b00b003638be62b22mr158132ilb.1.1706610686746; Tue, 30 Jan
 2024 02:31:26 -0800 (PST)
Date: Tue, 30 Jan 2024 02:31:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c0e6af0610274383@google.com>
Subject: [syzbot] [rdma?] WARNING: ODEBUG bug in __init_work (4)
From: syzbot <syzbot+2c3c83033160c81c9af2@syzkaller.appspotmail.com>
To: bmt@zurich.ibm.com, jgg@ziepe.ca, leon@kernel.org, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    01af33cc9894 Add linux-next specific files for 20240125
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=111c74f3e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4b73726a6eef71f1
dashboard link: https://syzkaller.appspot.com/bug?extid=2c3c83033160c81c9af2
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/bd3f86d4b4a5/disk-01af33cc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/39432e805e81/vmlinux-01af33cc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ebd665cc1f02/bzImage-01af33cc.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2c3c83033160c81c9af2@syzkaller.appspotmail.com

netlink: 'syz-executor.2': attribute type 27 has an invalid length.
netlink: 4 bytes leftover after parsing attributes in process `syz-executor.2'.
------------[ cut here ]------------
ODEBUG: init active (active state 0) object: ffff88802b745128 object type: work_struct hint: siw_netdev_down+0x0/0x210 drivers/infiniband/sw/siw/siw_main.c:87
WARNING: CPU: 1 PID: 31079 at lib/debugobjects.c:514 debug_print_object+0x1a3/0x2b0 lib/debugobjects.c:514
Modules linked in:
CPU: 1 PID: 31079 Comm: syz-executor.2 Not tainted 6.8.0-rc1-next-20240125-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
RIP: 0010:debug_print_object+0x1a3/0x2b0 lib/debugobjects.c:514
Code: fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 75 54 48 8b 14 dd c0 d3 4e 8b 41 56 4c 89 e6 48 c7 c7 20 c7 4e 8b e8 3e 95 d4 fc 90 <0f> 0b 90 90 58 83 05 55 9e fe 0a 01 48 83 c4 18 5b 5d 41 5c 41 5d
RSP: 0018:ffffc9000ae3ed88 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000003 RCX: ffffc9000d729000
RDX: 0000000000040000 RSI: ffffffff81504dd6 RDI: 0000000000000001
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: fffffffffffc0828 R12: ffffffff8b4ecd80
R13: ffffffff8aebd9e0 R14: ffffffff8808d330 R15: ffffc9000ae3ee48
FS:  00007f4e39bbd6c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000002000a030 CR3: 0000000065e5a000 CR4: 00000000003506f0
Call Trace:
 <TASK>
 __debug_object_init+0x28c/0x480 lib/debugobjects.c:653
 __init_work+0x4c/0x60 kernel/workqueue.c:591
 siw_device_goes_down drivers/infiniband/sw/siw/siw_main.c:395 [inline]
 siw_netdev_event+0x24d/0x530 drivers/infiniband/sw/siw/siw_main.c:422
 notifier_call_chain+0xb9/0x3e0 kernel/notifier.c:93
 call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:1966
 call_netdevice_notifiers_extack net/core/dev.c:2004 [inline]
 call_netdevice_notifiers net/core/dev.c:2018 [inline]
 __dev_close_many+0xf4/0x310 net/core/dev.c:1504
 __dev_close net/core/dev.c:1542 [inline]
 __dev_change_flags+0x4dc/0x720 net/core/dev.c:8646
 dev_change_flags+0x8f/0x160 net/core/dev.c:8720
 do_setlink+0x1abc/0x40c0 net/core/rtnetlink.c:2903
 rtnl_group_changelink net/core/rtnetlink.c:3452 [inline]
 __rtnl_newlink+0xe11/0x1960 net/core/rtnetlink.c:3711
 rtnl_newlink+0x67/0xa0 net/core/rtnetlink.c:3748
 rtnetlink_rcv_msg+0x3c7/0xe10 net/core/rtnetlink.c:6615
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2543
 netlink_unicast_kernel net/netlink/af_netlink.c:1341 [inline]
 netlink_unicast+0x542/0x820 net/netlink/af_netlink.c:1367
 netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1908
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 ____sys_sendmsg+0xab5/0xc90 net/socket.c:2584
 ___sys_sendmsg+0x135/0x1e0 net/socket.c:2638
 __sys_sendmsg+0x117/0x1f0 net/socket.c:2667
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd2/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f4e3a87cda9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4e39bbd0c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f4e3a9ac1f0 RCX: 00007f4e3a87cda9
RDX: 0000000000000000 RSI: 0000000020006440 RDI: 0000000000000007
RBP: 00007f4e3a8c947a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f4e3a9ac1f0 R15: 00007fff46e53798
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

