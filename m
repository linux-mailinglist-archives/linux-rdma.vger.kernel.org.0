Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CEDF182934
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2020 07:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387920AbgCLGhO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Mar 2020 02:37:14 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:42967 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387889AbgCLGhO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Mar 2020 02:37:14 -0400
Received: by mail-il1-f199.google.com with SMTP id j88so3212649ilg.9
        for <linux-rdma@vger.kernel.org>; Wed, 11 Mar 2020 23:37:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=FuH0nsCbwe86/j2RoJ1s3qJai4VV2bvq/TdtvNazlJE=;
        b=GQMr7i36+P7sFWEVrwCqQNjpVjXRnSxs43onVz9xiCNFoVb8woSStKmUfFKUyisQHG
         TsD4SIvWR2SICxzJIf10Lr6shDB2KXmOTHucXpDTXKklUwKIyIXavXlNEJkQYH7Fv9qH
         NchoUAAPPNGSMqlcyn+toJOvaeQx4qiZTSgiCzi4qSL3j8YCdjOBqDa9HbTCVJmjemzm
         ITdeLQmyr3QZgg8bjRRp7w/J7MBGFdpXhcFRzvKgrjMZbnq64cyh4LaVeb+Sx3BbIncR
         Layb9N/CEbYtCSrttPIXy6k/3AEHMUjT1Ne0l1B71CQkRb9NH2RrzY/bi/qpQJplqEBM
         YK5w==
X-Gm-Message-State: ANhLgQ0I+CnXwSfe6r6gNU+spXg8UzXCxouCV205QWyKSwVxWLxczeIX
        /Dveh4puH3te++0yDpCXKFmx66CvarYko0kIbeJJN/nJGceZ
X-Google-Smtp-Source: ADFU+vvZFSVb32AaAPGQNJt0QTHRGIRHmGWOfnZ9CqGWioVTITgpF3zUSoTuKs+f9tVy8KMCaJEqIWr57Fyf8zqGAot/tm+pq3Nn
MIME-Version: 1.0
X-Received: by 2002:a6b:8ec2:: with SMTP id q185mr6112676iod.180.1583995032813;
 Wed, 11 Mar 2020 23:37:12 -0700 (PDT)
Date:   Wed, 11 Mar 2020 23:37:12 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000041c6a905a0a295ef@google.com>
Subject: WARNING: ODEBUG bug in remove_client_context
From:   syzbot <syzbot+c3b8c2a85d37162cc6ab@syzkaller.appspotmail.com>
To:     dledford@redhat.com, jgg@ziepe.ca, kamalheib1@gmail.com,
        leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, parav@mellanox.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    61a09258 Merge tag 'for-linus' of git://git.kernel.org/pub..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10a6d70de00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7aef917d2e37d731
dashboard link: https://syzkaller.appspot.com/bug?extid=c3b8c2a85d37162cc6ab
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+c3b8c2a85d37162cc6ab@syzkaller.appspotmail.com

------------[ cut here ]------------
ODEBUG: free active (active state 0) object type: work_struct hint: smc_ib_port_event_work+0x0/0x340 net/smc/smc_ib.c:523
WARNING: CPU: 0 PID: 298 at lib/debugobjects.c:488 debug_print_object lib/debugobjects.c:485 [inline]
WARNING: CPU: 0 PID: 298 at lib/debugobjects.c:488 __debug_check_no_obj_freed lib/debugobjects.c:967 [inline]
WARNING: CPU: 0 PID: 298 at lib/debugobjects.c:488 debug_check_no_obj_freed+0x45c/0x640 lib/debugobjects.c:998
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 298 Comm: kworker/u4:5 Not tainted 5.6.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events_unbound ib_unregister_work
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1e9/0x30e lib/dump_stack.c:118
 panic+0x264/0x7a0 kernel/panic.c:221
 __warn+0x209/0x210 kernel/panic.c:582
 report_bug+0x1ac/0x2d0 lib/bug.c:195
 fixup_bug arch/x86/kernel/traps.c:174 [inline]
 do_error_trap+0xca/0x1c0 arch/x86/kernel/traps.c:267
 do_invalid_op+0x32/0x40 arch/x86/kernel/traps.c:286
 invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1027
RIP: 0010:debug_print_object lib/debugobjects.c:485 [inline]
RIP: 0010:__debug_check_no_obj_freed lib/debugobjects.c:967 [inline]
RIP: 0010:debug_check_no_obj_freed+0x45c/0x640 lib/debugobjects.c:998
Code: 74 08 4c 89 f7 e8 64 26 18 fe 4d 8b 06 48 c7 c7 13 08 d1 88 48 c7 c6 cf f8 ce 88 48 89 da 89 e9 4d 89 f9 31 c0 e8 14 c0 ae fd <0f> 0b 48 ba 00 00 00 00 00 fc ff df ff 05 56 28 b1 05 48 8b 5c 24
RSP: 0018:ffffc90001e07b78 EFLAGS: 00010046
RAX: 4ee5a22e59a59c00 RBX: ffffffff88d4e56a RCX: ffff8880a8a14440
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff815e16e6 R09: ffffed1015d04592
R10: ffffed1015d04592 R11: 0000000000000000 R12: ffff88809325f864
R13: ffffffff8b558e00 R14: ffffffff890d13a0 R15: ffffffff87bf6590
 kfree+0xfc/0x220 mm/slab.c:3756
 remove_client_context+0xb3/0x1e0 drivers/infiniband/core/device.c:724
 disable_device+0xec/0x2e0 drivers/infiniband/core/device.c:1268
 __ib_unregister_device+0x6c/0x160 drivers/infiniband/core/device.c:1435
 ib_unregister_work+0x15/0x30 drivers/infiniband/core/device.c:1545
 process_one_work+0x76e/0xfd0 kernel/workqueue.c:2264
 worker_thread+0xa7f/0x1450 kernel/workqueue.c:2410
 kthread+0x317/0x340 kernel/kthread.c:255
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
