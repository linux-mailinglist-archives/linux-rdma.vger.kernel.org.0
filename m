Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6AF229022
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Jul 2020 07:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728524AbgGVFxe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Jul 2020 01:53:34 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:34446 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726696AbgGVFxU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Jul 2020 01:53:20 -0400
Received: by mail-io1-f69.google.com with SMTP id 127so1134172iou.1
        for <linux-rdma@vger.kernel.org>; Tue, 21 Jul 2020 22:53:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=vMI+b0QwNKlbP0/ucj1u+tlneVHkQXvpxz2P0D6PK8s=;
        b=TlqGQ2MqIIHU7ppYZiCoTobMKlP5EGdMHtmnUHFQPCeryN53Q5VD0Ps+vc1NF73nn6
         ym7gcGukLAseXy5CvsynMoUxhBfNRUZLx4ec7Isqg4RXUgdgO0IETPzXk2E/4M0zDjo4
         GaOVMBuQTjb0Zxa8z+bex4JWs0OBXqrjD25zHbO7s5wmj2CNZf8eY+xnJG7KM6lN9HCU
         /adZuZkMwlrc7n5M99ucNsKBiFUqV1+35Sob+M64lzqLmDUm0DxSRtBqfgRftrsD1uOb
         b/H5RXaXjH9Q6GZgr39QqIGZQeAjp2It9SlbaDWJgS4WdN9QkagWjbKWDmsuYy/DLhCK
         mptw==
X-Gm-Message-State: AOAM530opfF4Ew3kT2CNn+wl28Y5HRHKjBKnqu02sjdiUpT1d/qoIHC1
        uPS3gIQTDT3y6R0kr0PoMQZC73aH+80NBsvpn4H0XTsHZdXc
X-Google-Smtp-Source: ABdhPJw35bTKefxEro2HR8zMrQL+kwCYSOF3wnVLtRlBV7cZn8JvkcKXN8Tk+aXwpnMZnpwBNCMdMKNProUSNTiikyw1qYRmmEsG
MIME-Version: 1.0
X-Received: by 2002:a02:95ca:: with SMTP id b68mr36860918jai.0.1595397199619;
 Tue, 21 Jul 2020 22:53:19 -0700 (PDT)
Date:   Tue, 21 Jul 2020 22:53:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005be99c05ab015bd0@google.com>
Subject: KMSAN: uninit-value in xa_load
From:   syzbot <syzbot+086ab5ca9eafd2379aa6@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=105d7320900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c534a9fad6323722
dashboard link: https://syzkaller.appspot.com/bug?extid=086ab5ca9eafd2379aa6
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1303736f100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12096087100000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+086ab5ca9eafd2379aa6@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in xas_start lib/xarray.c:190 [inline]
BUG: KMSAN: uninit-value in xas_load lib/xarray.c:233 [inline]
BUG: KMSAN: uninit-value in xa_load+0x83b/0x8a0 lib/xarray.c:1305
CPU: 0 PID: 8440 Comm: syz-executor560 Not tainted 5.8.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1df/0x240 lib/dump_stack.c:118
 kmsan_report+0xf7/0x1e0 mm/kmsan/kmsan_report.c:121
 __msan_warning+0x58/0xa0 mm/kmsan/kmsan_instr.c:215
 xas_start lib/xarray.c:190 [inline]
 xas_load lib/xarray.c:233 [inline]
 xa_load+0x83b/0x8a0 lib/xarray.c:1305
 _ucma_find_context drivers/infiniband/core/ucma.c:139 [inline]
 ucma_get_ctx+0x7f/0x310 drivers/infiniband/core/ucma.c:152
 ucma_get_ctx_dev drivers/infiniband/core/ucma.c:175 [inline]
 ucma_accept+0x259/0xc90 drivers/infiniband/core/ucma.c:1148
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
RIP: 0033:0x4402e9
Code: Bad RIP value.
RSP: 002b:00007fffa058a4f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 00000000004402e9
RDX: 0000000000000001 RSI: 00000000200000c0 RDI: 0000000000000003
RBP: 00000000006ca018 R08: 0000000000000000 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000401af0
R13: 0000000000401b80 R14: 0000000000000000 R15: 0000000000000000

Local variable ----cmd@ucma_accept created at:
 ucma_accept+0x95/0xc90 drivers/infiniband/core/ucma.c:1137
 ucma_accept+0x95/0xc90 drivers/infiniband/core/ucma.c:1137
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
