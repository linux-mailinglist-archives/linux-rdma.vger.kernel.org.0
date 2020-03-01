Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B37E174F21
	for <lists+linux-rdma@lfdr.de>; Sun,  1 Mar 2020 20:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgCATNQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 1 Mar 2020 14:13:16 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:39102 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbgCATNQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 1 Mar 2020 14:13:16 -0500
Received: by mail-il1-f198.google.com with SMTP id x2so3936288ila.6
        for <linux-rdma@vger.kernel.org>; Sun, 01 Mar 2020 11:13:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=0Dcjl1wj+PD0Lgt+OXmYkTb151pyTMwnRKiof57JFPA=;
        b=HcqO9xG0rPh7/Rlb2CLc4gXWaT+o08cubBGtJ1atzowzw2xmLJDE2/WBAhsBdkaP4A
         6dkQcIy51FD1c71gAGow7uRAmdyRgQWMrj2HWqE/RyELe+X9JMU/Hi5awtgZAk3Gm/H/
         j50K0c0aaUxN7VdUfZTWyzXujwRS7YvK3bByjdmY9J9gEvXH/E2AMyUaf3+BftzhoNL4
         RUDzNQad6KAhBlghkuEGu21vHNSnv8B4Sz7mnAEWv+6Nio/Rvlu9k+8PdmJ7y05wO4PU
         4lNXq5TKinIAKtW55BGhWSH/Xb1qoGu19jC9HvaXBM9JV7ldWZMXHwmMDdm6b9ZAMOYq
         y4Dg==
X-Gm-Message-State: APjAAAWZc6pyjxf/l0qPvtTc/JUGc1GftrB7rO6hNkyqyTX1tBlA6Bqs
        Zz7+J2Her8SteKCE3g/3U4HHvCODlyD4K7mKzM/LodziMmHb
X-Google-Smtp-Source: APXvYqwIfvSV79V1rpkNS6OvT+OANMpVQMBxs83UpQuVgpV3f5+v1w6F6FaGchmLG2IcammC7uSBfWBZ2rTBDn39leb0HPsUGxN3
MIME-Version: 1.0
X-Received: by 2002:a02:908a:: with SMTP id x10mr11405673jaf.16.1583089995211;
 Sun, 01 Mar 2020 11:13:15 -0800 (PST)
Date:   Sun, 01 Mar 2020 11:13:15 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cfed90059fcfdccb@google.com>
Subject: BUG: corrupted list in _cma_attach_to_dev
From:   syzbot <syzbot+06b50ee4a9bd73e8b89f@syzkaller.appspotmail.com>
To:     chuck.lever@oracle.com, dledford@redhat.com, jgg@ziepe.ca,
        leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, parav@mellanox.com,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    63623fd4 Merge tag 'for-linus' of git://git.kernel.org/pub..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16a8fa81e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9833e26bab355358
dashboard link: https://syzkaller.appspot.com/bug?extid=06b50ee4a9bd73e8b89f
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14e804f9e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15d6fd29e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+06b50ee4a9bd73e8b89f@syzkaller.appspotmail.com

list_add corruption. prev->next should be next (ffff888092dbd570), but was ffffffff8a5d2f20. (prev=ffff8880965fb1e0).
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:26!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 10633 Comm: syz-executor222 Not tainted 5.6.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__list_add_valid.cold+0x3a/0x3c lib/list_debug.c:26
Code: 0b 48 89 f2 4c 89 e1 4c 89 ee 48 c7 c7 80 da 91 88 e8 29 3a b8 fd 0f 0b 48 89 f1 48 c7 c7 00 da 91 88 4c 89 e6 e8 15 3a b8 fd <0f> 0b 4c 89 f6 48 c7 c7 a0 db 91 88 e8 04 3a b8 fd 0f 0b 4c 89 ea
RSP: 0018:ffffc90002197b70 EFLAGS: 00010286
RAX: 0000000000000075 RBX: ffff88809db2b000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff815ebe46 RDI: fffff52000432f60
RBP: ffffc90002197b88 R08: 0000000000000075 R09: ffffed1015d26659
R10: ffffed1015d26658 R11: ffff8880ae9332c7 R12: ffff888092dbd570
R13: ffff88809db2b1e0 R14: ffff8880965fb1e0 R15: ffff88809db2b1e0
FS:  00007f32e8400700(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffff600400 CR3: 00000000a71ef000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 __list_add include/linux/list.h:67 [inline]
 list_add_tail include/linux/list.h:100 [inline]
 _cma_attach_to_dev+0x150/0x2f0 drivers/infiniband/core/cma.c:471
 cma_listen_on_dev+0x252/0x6a0 drivers/infiniband/core/cma.c:2493
 cma_listen_on_all drivers/infiniband/core/cma.c:2514 [inline]
 rdma_listen+0x772/0x970 drivers/infiniband/core/cma.c:3622
 ucma_listen+0x14d/0x1c0 drivers/infiniband/core/ucma.c:1092
 ucma_write+0x2d7/0x3c0 drivers/infiniband/core/ucma.c:1684
 __vfs_write+0x8a/0x110 fs/read_write.c:494
 vfs_write+0x268/0x5d0 fs/read_write.c:558
 ksys_write+0x220/0x290 fs/read_write.c:611
 __do_sys_write fs/read_write.c:623 [inline]
 __se_sys_write fs/read_write.c:620 [inline]
 __x64_sys_write+0x73/0xb0 fs/read_write.c:620
 do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4495e9
Code: e8 8c e7 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 fb 07 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f32e83ffda8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00000000006dec68 RCX: 00000000004495e9
RDX: 0000000000000010 RSI: 0000000020000100 RDI: 0000000000000004
RBP: 00000000006dec60 R08: 00007f32e8400700 R09: 0000000000000000
R10: 00007f32e8400700 R11: 0000000000000246 R12: 00000000006dec6c
R13: 0000000000000000 R14: 0000000000006f6c R15: 00000000006dec6c
Modules linked in:
---[ end trace 55770a30f050c228 ]---
RIP: 0010:__list_add_valid.cold+0x3a/0x3c lib/list_debug.c:26
Code: 0b 48 89 f2 4c 89 e1 4c 89 ee 48 c7 c7 80 da 91 88 e8 29 3a b8 fd 0f 0b 48 89 f1 48 c7 c7 00 da 91 88 4c 89 e6 e8 15 3a b8 fd <0f> 0b 4c 89 f6 48 c7 c7 a0 db 91 88 e8 04 3a b8 fd 0f 0b 4c 89 ea
RSP: 0018:ffffc90002197b70 EFLAGS: 00010286
RAX: 0000000000000075 RBX: ffff88809db2b000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff815ebe46 RDI: fffff52000432f60
RBP: ffffc90002197b88 R08: 0000000000000075 R09: ffffed1015d26659
R10: ffffed1015d26658 R11: ffff8880ae9332c7 R12: ffff888092dbd570
R13: ffff88809db2b1e0 R14: ffff8880965fb1e0 R15: ffff88809db2b1e0
FS:  00007f32e8400700(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffff600400 CR3: 00000000a71ef000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
