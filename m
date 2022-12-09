Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60AE9647FF4
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Dec 2022 10:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbiLIJNO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Dec 2022 04:13:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiLIJMq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Dec 2022 04:12:46 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE46B1DA;
        Fri,  9 Dec 2022 01:12:44 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id b2so10015668eja.7;
        Fri, 09 Dec 2022 01:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1j9Yr1RIjpGvZEtIAy8mEFHdRZ2CDcp4NXS/Wjewf1I=;
        b=E4o2sxWizAqOC0ns9Pfq8gAruQ1FDOHnIP6fXG1TBBemXxGiaCYgeEsIqkg2TTDXdo
         AflVYVA8pjID/BdhCK2rG6KA5pH75W5oIubcFVnRP4Egk4RDjMk5lIBxZfu/j1bJo1hy
         N7SPaaYCrJfBZKUBvY6WDXUy2Xfj+8w4wzEaB6si/4IFaifeWi2gXvH+ToS5mtixphLq
         wOWaB3rC8+C1YNAKM/WbsySP1CNxNh0phsEKPlHE7hhXNdrkJiHDfN0pJjUjanPOa89o
         MTGhuArejFG7l7IzV9yOQQO6FJVzFFzuCS1r3C7xQVU8GJt2+AcjkrqziLz8HdWv6hOm
         uXfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1j9Yr1RIjpGvZEtIAy8mEFHdRZ2CDcp4NXS/Wjewf1I=;
        b=se9SuAm9pbSMf7y/ziSOZkBmdL27hJrzOQk8gr/DTnKyx6bfak4ao48Z5FPlpnXA0U
         3r649Mi4/8sRSz0hrAXS0O4GPTA2cfwyzynjGHbryOxnfENbsPJ63ezcPvU/7nMBR08X
         ggOLY1Q2RVqUG+Su01vlw7pmX6P5W/LuJpUWe1Qf6odQIWN9/3+a97LvUVioMl9sntVz
         8veBcn5RR+xKYi03RUVzyWI50X8GRNgW1YGueRQZ5+EbHRP2bR5afgvx2coUvAiMEwDD
         9gOC+EtUl6QSx6tGVWURiEH+CdyM4K7c/mXUl0jgKwihD7J0WsZ0Cn8DoAVA3MEtLYg/
         p6pw==
X-Gm-Message-State: ANoB5pl0hJU1p3R1+AwBIEUNm7mP/GfAyB9/7fdNINP5z1OCCishEwOF
        avUs515GA3ffA6Se2yePier2xUCY8aBvNTGJZXc=
X-Google-Smtp-Source: AA0mqf7yis0sbxRF6DepgNY2whxTQU/V8gu9J1o6W/IUv4D65yVhLopAVXayq3DRii5Ery0oUILWYsdzEkL7Buqa8tM=
X-Received: by 2002:a17:906:3ad6:b0:7ae:40b7:7fbe with SMTP id
 z22-20020a1709063ad600b007ae40b77fbemr77351413ejd.371.1670577162393; Fri, 09
 Dec 2022 01:12:42 -0800 (PST)
MIME-Version: 1.0
From:   Wei Chen <harperchen1110@gmail.com>
Date:   Fri, 9 Dec 2022 17:12:06 +0800
Message-ID: <CAO4mrfdFMT5KLTOnyrC1+zLywfLmQJc4HNia=4zxYxZ+5+70Dw@mail.gmail.com>
Subject: BUG: corrupted list in rdma_resolve_route and _destroy_id
To:     jgg@ziepe.ca, leon@kernel.org, markzhang@nvidia.com,
        keescook@chromium.org, Jason@zx2c4.com, haakon.bugge@oracle.com,
        phaddad@nvidia.com, maorg@nvidia.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzbot <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Dear Linux Developers,

Recently, we found two corrupted list crashes in cma_add_id_to_tree
and cma_remove_id_from_tree. The information of the linux system is
listed below. I'm wondering if id_priv->id_list_entry is not properly
locked to avoid data race.

HEAD commit: 147307c69ba
git tree: linux-next
compiler: clang 12.0.0
kernel config: https://drive.google.com/file/d/1NAf4S43d9VOKD52xbrqw-PUP1Mbj8z-S/view?usp=share_link

console output for BUG: corrupted list in rdma_resolve_route:
https://drive.google.com/file/d/1Y3RbuLMBPAZw6K80NZMEsfMpqidpGEjA/view?usp=share_link

console output for BUG: corrupted list in _destroy_id:
https://drive.google.com/file/d/1azgrBtv7Yjibhiwfh3CdF2nSnm7Zlein/view?usp=share_link

Unfortunately, I didn't have a reproducer for these two crashes.

IMPORTANT: if you fix these two bugs, please add the following tag to
the commit:
Reported-by: Wei Chen <harperchen1110@gmail.com>

BUG: corrupted list in rdma_resolve_route

list_add corruption. prev->next should be next (ffff8881300cfd40), but
was ffff888130d1aa30. (prev=ffff888130d1aa30).
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:32!
invalid opcode: 0000 [#1] PREEMPT SMP
CPU: 0 PID: 1127 Comm: syz-executor.0 Not tainted 6.1.0-rc5-next-20221118 #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.13.0-48-gd9c812dda519-prebuilt.qemu.org 04/01/2014
RIP: 0010:__list_add_valid+0xaf/0xc0 lib/list_debug.c:30
Code: 48 c7 c7 2c cf 64 85 48 89 de 4c 89 f1 31 c0 e8 87 cd 00 03 0f
0b 48 c7 c7 7e cf 64 85 4c 89 f6 48 89 d9 31 c0 e8 71 cd 00 03 <0f> 0b
66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 41 57 41 56 53
RSP: 0018:ffffc900047d7c60 EFLAGS: 00010046
RAX: 0000000000000075 RBX: ffff888130d1aa30 RCX: 2af912f2a8e0bb00
RDX: ffffc90000b25000 RSI: 000000000000064a RDI: 000000000000064b
RBP: ffff888130d1aa30 R08: ffffffff8117bd89 R09: 0000000000000000
R10: 0001ffffffffffff R11: 000188813bc1b3d8 R12: ffff888130d1aa30
R13: ffff888130d1a800 R14: ffff8881300cfd40 R15: ffff888130d1aa30
FS:  00007f9c07271700(0000) GS:ffff88813bc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000072d390 CR3: 00000001306be000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __list_add include/linux/list.h:69 [inline]
 list_add_tail include/linux/list.h:102 [inline]
 cma_add_id_to_tree drivers/infiniband/core/cma.c:516 [inline]
 rdma_resolve_route+0x1657/0x1720 drivers/infiniband/core/cma.c:3349
 ucma_resolve_route+0x226/0x350 drivers/infiniband/core/ucma.c:746
 ucma_write+0x198/0x230 drivers/infiniband/core/ucma.c:1744
 vfs_write+0x31f/0x800 fs/read_write.c:582
 ksys_write+0xd9/0x190 fs/read_write.c:637
 __do_sys_write fs/read_write.c:649 [inline]
 __se_sys_write fs/read_write.c:646 [inline]
 __x64_sys_write+0x3e/0x50 fs/read_write.c:646
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x4697f9
Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9c07270c48 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 000000000077bf80 RCX: 00000000004697f9
RDX: 0000000000000010 RSI: 0000000020000500 RDI: 0000000000000003
RBP: 00000000004d29e9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000077bf80
R13: 0000000000000000 R14: 000000000077bf80 R15: 00007ffcf6c943d0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---


Crash report for BUG: corrupted list in _destroy_id
list_del corruption. prev->next should be ffff888130bfae30, but was
ffff8881318234c0. (prev=ffff888131baea30)
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:61!
invalid opcode: 0000 [#1] PREEMPT SMP
CPU: 0 PID: 21921 Comm: syz-executor.0 Not tainted 6.1.0-rc5-next-20221118 #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.13.0-48-gd9c812dda519-prebuilt.qemu.org 04/01/2014
RIP: 0010:__list_del_entry_valid+0xcc/0xf0 lib/list_debug.c:59
Code: 03 0f 0b 48 c7 c7 91 d0 64 85 4c 89 f6 31 c0 e8 aa cc 00 03 0f
0b 48 c7 c7 c9 d0 64 85 4c 89 f6 48 89 d9 31 c0 e8 94 cc 00 03 <0f> 0b
48 c7 c7 13 d1 64 85 4c 89 f6 4c 89 f9 31 c0 e8 7e cc 00 03
RSP: 0018:ffffc90008997ce8 EFLAGS: 00010046
RAX: 000000000000006d RBX: ffff888131baea30 RCX: 6956480ee224fe00
RDX: 0000000000000000 RSI: 0000000080000001 RDI: 0000000000000000
RBP: ffff888130bfae30 R08: ffffffff8117bd89 R09: 0000000000000000
R10: 0001ffffffffffff R11: 000188813bc1b3d8 R12: ffff888130a37180
R13: ffff888130a3d0a0 R14: ffff888130bfae30 R15: ffff888130a37180
FS:  00000000021b3940(0000) GS:ffff88813bc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004e4bb0 CR3: 00000001322cc000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __list_del_entry include/linux/list.h:134 [inline]
 list_del_init include/linux/list.h:206 [inline]
 cma_remove_id_from_tree drivers/infiniband/core/cma.c:570 [inline]
 _destroy_id+0x5be/0xcc0 drivers/infiniband/core/cma.c:2008
 destroy_id_handler_unlock drivers/infiniband/core/cma.c:2060 [inline]
 rdma_destroy_id+0x7b/0x130 drivers/infiniband/core/cma.c:2069
 ucma_close_id drivers/infiniband/core/ucma.c:187 [inline]
 ucma_destroy_private_ctx+0xc9/0x620 drivers/infiniband/core/ucma.c:579
 ucma_close+0x9f/0xe0 drivers/infiniband/core/ucma.c:1809
 __fput+0x2a2/0x560 fs/file_table.c:320
 ____fput+0x11/0x20 fs/file_table.c:348
 task_work_run+0xde/0x110 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
 exit_to_user_mode_prepare+0x11a/0x130 kernel/entry/common.c:203
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x20/0x40 kernel/entry/common.c:296
 do_syscall_64+0x37/0x70 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x418a57
Code: 00 00 0f 05 48 3d 00 f0 ff ff 77 3f f3 c3 0f 1f 44 00 00 53 89
fb 48 83 ec 10 e8 f4 fb ff ff 89 df 89 c2 b8 03 00 00 00 0f 05 <48> 3d
00 f0 ff ff 77 2b 89 d7 89 44 24 0c e8 36 fc ff ff 8b 44 24
RSP: 002b:00007ffe285e5430 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000004 RCX: 0000000000418a57
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000004
RBP: 0000000000000005 R08: 0000000000001a7e R09: 00000000d8ee1a81
R10: 00007ffe285e5570 R11: 0000000000000293 R12: 000000000006a9e1
R13: 000000000070c880 R14: 000000000077bf80 R15: 000000000006a9dc
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---

Best,
Wei
