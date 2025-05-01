Return-Path: <linux-rdma+bounces-9946-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A83AA6188
	for <lists+linux-rdma@lfdr.de>; Thu,  1 May 2025 18:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77CF07B48AF
	for <lists+linux-rdma@lfdr.de>; Thu,  1 May 2025 16:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC42A20B1FC;
	Thu,  1 May 2025 16:45:40 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57EA140E34
	for <linux-rdma@vger.kernel.org>; Thu,  1 May 2025 16:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746117940; cv=none; b=IbZRHwsGERJ2sTXUDgBg63D3v5WTRLyeLJiYawP1tMwXbG1VECpspM1XicdCl6S7idiS7v8UuGEM3hNZiigR1PfPYxvNVFUWaSlcQJF6EzBVomSjZhr5Bk8UWyDSR1BML/DoagIgpIQGPNFCjl9H5v+ZqaolG3+xss8RrTEASyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746117940; c=relaxed/simple;
	bh=C1VVPB90TzzNnYgDQCDu5BN3A8tviE4ELxJz0aRmKwk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=b1pP+2CRfgaqRmWFRnhE6Ps/5qLDyXJptu2LVAJt6RialZol1+hSPeGFcX5xURIf2VtA12ssVhlyrPlbx2OTL2q079jlt8iwOepRdyCNW0U+hbzQP4hAGIj8z0eNuzSqsoyKf+BKIMa77cUwqzDGUS+ZprsaXAK+EYR0aLUh8B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3d970d75b64so11475095ab.3
        for <linux-rdma@vger.kernel.org>; Thu, 01 May 2025 09:45:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746117938; x=1746722738;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BxprK6iH2qM+XWpaAJoMda84cekxzHEVw17DIvAlGOY=;
        b=FL06AYJgA63nw0sigrw7LdfBP8C1NEt32cxNE0k9qf3uFgyBnuPpbJQdi8rS4Z5QBj
         a62t0nRqPiG6EIfQdz+K5d42MV4SAqbq9l6opvRKLWff3kE5lPkD0y0A1DULOHUbahoy
         lPCVUwAePBFkv9dX4lMW4W5LX/ID/dmItP2IwglFnxMgm4u5Ab6xTTOWWwPEDpAIpqxQ
         JvSEJ/cppNAZxp1VimNOydPpwaxOvweIoMsigqOkYWGlt/cjKAKD2UiUpL1+s1HgYxEA
         nbA+8VqL8Lm3toj2Qm68gcfDu3Fam8Tb+mfI0OJgevWK993xrOq+ufEOX5J8KzAcjsV6
         pzLw==
X-Forwarded-Encrypted: i=1; AJvYcCUiiIMQ79i1qW2OKrvjB+gF65FBTivR3MwO4Wcw0ilTHK2YLTOwuKHnTq5IPIEPp5RUgHYiF+N+OTep@vger.kernel.org
X-Gm-Message-State: AOJu0Yw51dEMN4/touoMnQmQWjPdh+4CL2YPQj6Ikzdna6wU7UbKjK20
	20HO7ZFo1rexXrcnDLUlpPBr3yMfa/mCZpri5hWhQ03cy+5olzXApJV9eh1zVvab7ed6BWAFYgo
	jmqzTpG6V3gwR31En1GwH6es99+pbylXE7j9TnjB5rAKFW5m4vh9DjUY=
X-Google-Smtp-Source: AGHT+IF63L19sf+2F9i6TF89qbQP9TwWjEUkA/I4PFZaKwcRswiMSQ3Ly82at5jkauBCtZq8Jal+XaF3fIOF7nC0PWbpCl6lAgiX
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:148f:b0:3d9:6cd9:505b with SMTP id
 e9e14a558f8ab-3d96f22f683mr47266085ab.16.1746117937938; Thu, 01 May 2025
 09:45:37 -0700 (PDT)
Date: Thu, 01 May 2025 09:45:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6813a531.050a0220.14dd7d.0018.GAE@google.com>
Subject: [syzbot] [rdma?] WARNING in rxe_skb_tx_dtor
From: syzbot <syzbot+8425ccfb599521edb153@syzkaller.appspotmail.com>
To: jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	zyjzyj2000@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8bac8898fe39 Merge tag 'mmc-v6.15-rc1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16b6d774580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a9a25b7a36123454
dashboard link: https://syzkaller.appspot.com/bug?extid=8425ccfb599521edb153
compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-8bac8898.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2a76d594c0f5/vmlinux-8bac8898.xz
kernel image: https://storage.googleapis.com/syzbot-assets/dae09c25780d/bzImage-8bac8898.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8425ccfb599521edb153@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 1046 at drivers/infiniband/sw/rxe/rxe_net.c:357 rxe_skb_tx_dtor+0x8b/0x2a0 drivers/infiniband/sw/rxe/rxe_net.c:357
Modules linked in:
CPU: 0 UID: 0 PID: 1046 Comm: kworker/u4:9 Not tainted 6.15.0-rc4-syzkaller-00040-g8bac8898fe39 #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: rxe_wq do_work
RIP: 0010:rxe_skb_tx_dtor+0x8b/0x2a0 drivers/infiniband/sw/rxe/rxe_net.c:357
Code: 80 3c 20 00 74 08 4c 89 ff e8 41 ee 8c f9 4d 8b 37 44 89 f6 83 e6 01 31 ff e8 11 fe 2a f9 41 f6 c6 01 75 0e e8 26 f9 2a f9 90 <0f> 0b 90 e9 b4 01 00 00 4c 89 ff e8 35 c4 fa 01 48 89 c7 be 0e 00
RSP: 0018:ffffc90000007a08 EFLAGS: 00010246
RAX: ffffffff8894c5aa RBX: ffff88803ec8d280 RCX: ffff888035088000
RDX: 0000000000000100 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: ffffffff886e3f04 R12: dffffc0000000000
R13: 1ffff11007d91a5b R14: 0000000000025820 R15: ffff888034060000
FS:  0000000000000000(0000) GS:ffff88808d6cc000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7c6d874fc8 CR3: 00000000428c8000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 skb_release_head_state+0xfe/0x250 net/core/skbuff.c:1149
 napi_consume_skb+0xd2/0x1e0 net/core/skbuff.c:-1
 e1000_unmap_and_free_tx_resource drivers/net/ethernet/intel/e1000/e1000_main.c:1972 [inline]
 e1000_clean_tx_irq drivers/net/ethernet/intel/e1000/e1000_main.c:3864 [inline]
 e1000_clean+0x49d/0x2b00 drivers/net/ethernet/intel/e1000/e1000_main.c:3805
 __napi_poll+0xc4/0x480 net/core/dev.c:7324
 napi_poll net/core/dev.c:7388 [inline]
 net_rx_action+0x6ea/0xdf0 net/core/dev.c:7510
 handle_softirqs+0x283/0x870 kernel/softirq.c:579
 do_softirq+0xec/0x180 kernel/softirq.c:480
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x17d/0x1c0 kernel/softirq.c:407
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 rcu_read_unlock_bh include/linux/rcupdate.h:910 [inline]
 __dev_queue_xmit+0x1cd7/0x3a70 net/core/dev.c:4656
 neigh_output include/net/neighbour.h:539 [inline]
 ip6_finish_output2+0x11fb/0x16a0 net/ipv6/ip6_output.c:141
 __ip6_finish_output net/ipv6/ip6_output.c:-1 [inline]
 ip6_finish_output+0x234/0x7d0 net/ipv6/ip6_output.c:226
 rxe_send drivers/infiniband/sw/rxe/rxe_net.c:391 [inline]
 rxe_xmit_packet+0x79e/0xa30 drivers/infiniband/sw/rxe/rxe_net.c:450
 rxe_requester+0x1fea/0x3d20 drivers/infiniband/sw/rxe/rxe_req.c:805
 rxe_sender+0x16/0x50 drivers/infiniband/sw/rxe/rxe_req.c:839
 do_task+0x1ad/0x6b0 drivers/infiniband/sw/rxe/rxe_task.c:127
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xadb/0x17a0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
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

