Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 873BD178AC9
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Mar 2020 07:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725283AbgCDGpO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Mar 2020 01:45:14 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:42477 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbgCDGpN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Mar 2020 01:45:13 -0500
Received: by mail-io1-f69.google.com with SMTP id v23so814989iob.9
        for <linux-rdma@vger.kernel.org>; Tue, 03 Mar 2020 22:45:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=IMywZvFG6p+ip79cZuRM2xcG7m2agPGtSHOIoegKuNs=;
        b=tiuC009C9U+EdDt4rPhslee3WiizjTHRXZ4AsOksPmKBsvsDKeNCuM/GbnMa7FCFFB
         u9SvI92Vdy2yIEARpPb7unGnwkWvLerPcLT97mlcokxMHNjEIoEv8Ozl7FiHiy9vOLut
         fPUp51IX17dHz/ESoxywOiWaQBMKbUeKRXR5Exdrwj2D2xCLBhMT6H3paSWQKfNXxEoq
         aD7NkZ5K1OvpNe7KzX1i2RW4BvXgz1ZSrrF+hSlLGwofqzyrbgpUoziUc3WNIuloyQl1
         LGDsf0Erw+MyjhANJ+uB9lfk4xij04wU1pgDiXtcHbBqywxKsERfDM1HUjAHZGNreCD8
         KlAA==
X-Gm-Message-State: ANhLgQ0usqdkR82B+s2r5+o+mX36Y58pNmj6+ok6s+1xZbOnYIGOWHQK
        i7SILzQo12kFOdxKzpnpdBW73L5gTLxxz3jBaHuA0TXYFGkQ
X-Google-Smtp-Source: ADFU+vu8cnYsSAuHf7MHGAz1BhlVrMFJdZwFJMQaXsSUIKF8R6ygFEZqWW55p34aWYOSLMTkbdgIGcnJ1hv95se6XXdtErJYypBR
MIME-Version: 1.0
X-Received: by 2002:a6b:ef0a:: with SMTP id k10mr1012869ioh.302.1583304312667;
 Tue, 03 Mar 2020 22:45:12 -0800 (PST)
Date:   Tue, 03 Mar 2020 22:45:12 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000020c5d205a001c308@google.com>
Subject: BUG: corrupted list in cma_listen_on_dev
From:   syzbot <syzbot+2b10b240fbbed30f10fb@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=11123e65e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5d2e033af114153f
dashboard link: https://syzkaller.appspot.com/bug?extid=2b10b240fbbed30f10fb
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10d3b329e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16291291e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+2b10b240fbbed30f10fb@syzkaller.appspotmail.com

list_add corruption. prev->next should be next (ffff8880a96d3470), but was ffffffff89543330. (prev=ffff8880a660a1e0).
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:28!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 9161 Comm: syz-executor219 Not tainted 5.6.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__list_add_valid+0xbb/0xc0 lib/list_debug.c:26
Code: 48 c7 c7 37 e9 f0 88 4c 89 e6 4c 89 f1 31 c0 e8 be 0d bb fd 0f 0b 48 c7 c7 9a e9 f0 88 4c 89 f6 4c 89 e1 31 c0 e8 a8 0d bb fd <0f> 0b 0f 1f 00 55 48 89 e5 41 57 41 56 41 54 53 49 89 fe 49 bc 00
RSP: 0018:ffffc90002217ba8 EFLAGS: 00010246
RAX: 0000000000000075 RBX: ffff8880a96d3478 RCX: 8fbfbd6f3e068e00
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffc90002217bd0 R08: ffffffff81601324 R09: ffffed1015d46618
R10: ffffed1015d46618 R11: 0000000000000000 R12: ffff8880a660a1e0
R13: dffffc0000000000 R14: ffff8880a96d3470 R15: ffff8880a7f691e0
FS:  00007f2670a0f700(0000) GS:ffff8880aea00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f70fb63c000 CR3: 00000000a6af6000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 __list_add include/linux/list.h:67 [inline]
 list_add_tail include/linux/list.h:100 [inline]
 _cma_attach_to_dev drivers/infiniband/core/cma.c:471 [inline]
 cma_listen_on_dev+0x359/0x8e0 drivers/infiniband/core/cma.c:2493
 cma_listen_on_all drivers/infiniband/core/cma.c:2514 [inline]
 rdma_listen+0x43b/0x9a0 drivers/infiniband/core/cma.c:3622
 ucma_listen+0x245/0x300 drivers/infiniband/core/ucma.c:1092
 ucma_write+0x2da/0x360 drivers/infiniband/core/ucma.c:1684
 __vfs_write+0xb8/0x740 fs/read_write.c:494
 vfs_write+0x270/0x580 fs/read_write.c:558
 ksys_write+0x117/0x220 fs/read_write.c:611
 __do_sys_write fs/read_write.c:623 [inline]
 __se_sys_write fs/read_write.c:620 [inline]
 __x64_sys_write+0x7b/0x90 fs/read_write.c:620
 do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4495e9
Code: e8 8c e7 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 fb 07 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f2670a0eda8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00000000006dec68 RCX: 00000000004495e9
RDX: 0000000000000010 RSI: 0000000020000100 RDI: 0000000000000004
RBP: 00000000006dec60 R08: 00007f2670a0f700 R09: 0000000000000000
R10: 00007f2670a0f700 R11: 0000000000000246 R12: 00000000006dec6c
R13: 0000000000000000 R14: 0000000000006f6c R15: 00000000006dec6c
Modules linked in:
---[ end trace 4b9dfed7ba7e8985 ]---
RIP: 0010:__list_add_valid+0xbb/0xc0 lib/list_debug.c:26
Code: 48 c7 c7 37 e9 f0 88 4c 89 e6 4c 89 f1 31 c0 e8 be 0d bb fd 0f 0b 48 c7 c7 9a e9 f0 88 4c 89 f6 4c 89 e1 31 c0 e8 a8 0d bb fd <0f> 0b 0f 1f 00 55 48 89 e5 41 57 41 56 41 54 53 49 89 fe 49 bc 00
RSP: 0018:ffffc90002217ba8 EFLAGS: 00010246
RAX: 0000000000000075 RBX: ffff8880a96d3478 RCX: 8fbfbd6f3e068e00
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffc90002217bd0 R08: ffffffff81601324 R09: ffffed1015d46618
R10: ffffed1015d46618 R11: 0000000000000000 R12: ffff8880a660a1e0
R13: dffffc0000000000 R14: ffff8880a96d3470 R15: ffff8880a7f691e0
FS:  00007f2670a0f700(0000) GS:ffff8880aea00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f70fb63c000 CR3: 00000000a6af6000 CR4: 00000000001406f0
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
