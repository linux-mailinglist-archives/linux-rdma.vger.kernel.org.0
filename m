Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 034F1229021
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Jul 2020 07:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbgGVFxa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Jul 2020 01:53:30 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:53918 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728318AbgGVFxV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Jul 2020 01:53:21 -0400
Received: by mail-il1-f200.google.com with SMTP id r4so289900ilq.20
        for <linux-rdma@vger.kernel.org>; Tue, 21 Jul 2020 22:53:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ceHAZ8fGtIOXmoQZi1GN0tX61tjs26U0Fk+wKnXOpRo=;
        b=QAK6fzVVUHll1rRNeT/WSLlGQZ0k10Gn+Inew+z6I/4aMcA7u8tChMfHsx7huBH/c8
         0sBteAahUDDH9nqkVQu/pN/+h/Htgccu8cjXMPWdVB3m7Rt1RjdE7wLDAeJprBYFLpUg
         EABunJl1Fz5zNbOa6+Gpswj5iZIGFdKtaaLnvO6vTcfvNuULVwWVsxwWr68kTbIi7Wl0
         TeDV1zEIFFRef8t+0C+Egl4L+qJfw6zLvcqDUdvgjvigGKXKINsGd5TZakSXXCzZnkmI
         2B6Dlc2VVs76Ti4ZLSDhwaGy8QZ/NBXEc6il8CxzxtKP2eHrEneJY3VGJEkVxQmlox/+
         +cWQ==
X-Gm-Message-State: AOAM533dGiOrNzsjYaMN7xowQy1fnIhhv67WDKqjsWaphkq4ol1QkuvS
        VdKI5XSY7X0oe/rzfIuWYAvbCyTccEN3STgbRWt3d00qHW6P
X-Google-Smtp-Source: ABdhPJw1gZlt3PeSpaXF6147x/nyTTUyGOCs5tXCi+GZ/KY+fW2xTNTIYZrrOBKXhPtNLGkYsoFW4Cck1xqNM3erTWni5t2rf7uZ
MIME-Version: 1.0
X-Received: by 2002:a92:58d6:: with SMTP id z83mr31177380ilf.186.1595397200184;
 Tue, 21 Jul 2020 22:53:20 -0700 (PDT)
Date:   Tue, 21 Jul 2020 22:53:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000648aca05ab015bd3@google.com>
Subject: KMSAN: uninit-value in ucma_connect
From:   syzbot <syzbot+7446526858b83c8828b2@syzkaller.appspotmail.com>
To:     dledford@redhat.com, glider@google.com, jgg@ziepe.ca,
        leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    14525656 compiler.h: reinstate missing KMSAN_INIT
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=124a0817100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c534a9fad6323722
dashboard link: https://syzkaller.appspot.com/bug?extid=7446526858b83c8828b2
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13db936f100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16c18d7d100000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7446526858b83c8828b2@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in ucma_connect+0x2aa/0xab0 drivers/infiniband/core/ucma.c:1091
CPU: 0 PID: 8457 Comm: syz-executor069 Not tainted 5.8.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1df/0x240 lib/dump_stack.c:118
 kmsan_report+0xf7/0x1e0 mm/kmsan/kmsan_report.c:121
 __msan_warning+0x58/0xa0 mm/kmsan/kmsan_instr.c:215
 ucma_connect+0x2aa/0xab0 drivers/infiniband/core/ucma.c:1091
 ucma_write+0x5c5/0x630 drivers/infiniband/core/ucma.c:1764
 do_loop_readv_writev fs/read_write.c:737 [inline]
 do_iter_write+0x710/0xdc0 fs/read_write.c:1020
 vfs_writev fs/read_write.c:1091 [inline]
 do_writev+0x42d/0x8f0 fs/read_write.c:1134
 __do_sys_writev fs/read_write.c:1207 [inline]
 __se_sys_writev+0x9b/0xb0 fs/read_write.c:1204
 __x64_sys_writev+0x4a/0x70 fs/read_write.c:1204
 do_syscall_64+0xb0/0x150 arch/x86/entry/common.c:386
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x4402a9
Code: Bad RIP value.
RSP: 002b:00007ffd6e4541e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 00000000004402a9
RDX: 0000000000000001 RSI: 00000000200000c0 RDI: 0000000000000005
RBP: 00000000006ca018 R08: 00000000004002c8 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000401ab0
R13: 0000000000401b40 R14: 0000000000000000 R15: 0000000000000000

Local variable ----cmd@ucma_connect created at:
 ucma_connect+0xe1/0xab0 drivers/infiniband/core/ucma.c:1082
 ucma_connect+0xe1/0xab0 drivers/infiniband/core/ucma.c:1082
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
