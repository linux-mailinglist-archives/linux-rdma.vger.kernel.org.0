Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C623D4683DF
	for <lists+linux-rdma@lfdr.de>; Sat,  4 Dec 2021 10:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344723AbhLDJ5n (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 4 Dec 2021 04:57:43 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:51008 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344685AbhLDJ5m (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 4 Dec 2021 04:57:42 -0500
Received: by mail-io1-f72.google.com with SMTP id e14-20020a6bf10e000000b005e23f0f5e08so4397940iog.17
        for <linux-rdma@vger.kernel.org>; Sat, 04 Dec 2021 01:54:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=OGiefsgn2KtHR6deIKaDSxA7HkbB2bKmq2vn9lWPXfA=;
        b=RESbP9n3IGKO8Dk+UrvDyCderLIgg580/xJj24dI4YXC+hqaDS/4d30aWRHFd9AOI4
         ArnpS+o9ZxGYhNS+q7Edy3IgpRlgM9vLr8gabktXVyt2Uz++zGjUPvx/fwO57TZfkWlG
         8hwr0ihbLB87tQIIWns8Ooi8ac526CgztPZ7f4axnm6pPXRRuiBUX36VN3sUrVxI9p1U
         a/sZhgIDVoFOGxuyU6QXJMGlM4hYmr7tOlD+5KgfezjAijsGuAQSLsflg+sdnXAZmYdz
         iLUJ5yeswYQkW8BVV8wZGckfGPC4q9ozq2Gc6AizBH92CXP6FlahfHm+H/BbqnDjFXyg
         a7eg==
X-Gm-Message-State: AOAM532GHHj7mXWeyU1lC4t/4fcnSDHaTJMj/bX80ggbSM7P5KjsSllG
        HKhA2o4x1t+X8GY7A1ehoswU80VHZwn1IhsxdRNaCYIr9jBC
X-Google-Smtp-Source: ABdhPJwZMaRW+iNdlY9wG40TtzxcKhpYNsr3I8V0yleAtYob9HHu/9WEEFYkd0fKWa6Pkj5KZSPG3txjPDf7D+q5TYxuG4H+njkD
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1445:: with SMTP id l5mr30081353jad.36.1638611657418;
 Sat, 04 Dec 2021 01:54:17 -0800 (PST)
Date:   Sat, 04 Dec 2021 01:54:17 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c3eace05d24f0189@google.com>
Subject: [syzbot] BUG: corrupted list in rdma_listen (2)
From:   syzbot <syzbot+c94a3675a626f6333d74@syzkaller.appspotmail.com>
To:     avihaih@nvidia.com, dledford@redhat.com, haakon.bugge@oracle.com,
        jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    bf152b0b41dc Merge tag 'for_linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=136e3a46b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4a0a845d34d07474
dashboard link: https://syzkaller.appspot.com/bug?extid=c94a3675a626f6333d74
userspace arch: arm

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c94a3675a626f6333d74@syzkaller.appspotmail.com

list_add corruption. prev->next should be next (82bbca08), but was 00000000. (prev=865e75ac).
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:26!
Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
Modules linked in:
CPU: 1 PID: 5339 Comm: syz-executor.1 Not tainted 5.12.0-rc3-syzkaller #0
Hardware name: ARM-Versatile Express
PC is at __list_add_valid+0x80/0x84 lib/list_debug.c:26
LR is at wake_up_klogd.part.0+0x7c/0xb4 kernel/printk/printk.c:3118
pc : [<808072b8>]    lr : [<802d21b0>]    psr: 60000013
sp : 86657e30  ip : 86657d60  fp : 86657e3c
r10: 81104354  r9 : 00000010  r8 : 865e75ac
r7 : 82bbca08  r6 : 865e7400  r5 : 865e75ac  r4 : 82bbc6d8
r3 : 00000000  r2 : 00000000  r1 : ddfd6688  r0 : 0000005d
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 30c5387d  Table: 86712700  DAC: 00000000
Process syz-executor.1 (pid: 5339, stack limit = 0x86656210)
Stack: (0x86657e30 to 0x86658000)
7e20:                                     86657e6c 86657e40 810e61b8 80807244
7e40: 00000010 56b92eae 86657e6c 86424900 86ca70c0 86424948 811034c0 84343b40
7e60: 86657e9c 86657e70 811035a0 810e6048 8046d9e4 00000000 00000005 56b92eae
7e80: 86ca70c0 00000010 200008c0 86ca70c0 86657ed4 86657ea0 811044a0 811034cc
7ea0: 804d8fc8 00000007 fa000008 56b92eae 00004000 00000000 86c46140 200008c0
7ec0: ffffe000 00000000 86657f64 86657ed8 804da914 81104360 853d5140 82bfd5ec
7ee0: 86c46140 81f40284 86657f3c 86657ef8 80502e64 802bf578 00000000 00000000
7f00: 80502d24 835f4000 86657f3c 81f718ac 8020d140 00000000 00000000 200008c0
7f20: 00000010 80200224 86656000 00000004 86657f4c 56b92eae 80502f48 86c46141
7f40: 86c46140 200008c0 00000010 80200224 86656000 00000004 86657f94 86657f68
7f60: 804dad30 804da838 86657f94 86657f78 828abd1c 56b92eae 00000000 00000000
7f80: ffffffff 00000004 86657fa4 86657f98 804dad78 804dac88 00000000 86657fa8
7fa0: 80200060 804dad74 00000000 00000000 00000003 200008c0 00000010 00000000
7fc0: 00000000 00000000 ffffffff 00000004 7ebc531a 76f7b6d0 7ebc54a4 76f7b20c
7fe0: 76f7b048 76f7b038 00018e9c 0004ba40 60000010 00000003 00000000 00000000
Backtrace: 
[<80807238>] (__list_add_valid) from [<810e61b8>] (__list_add include/linux/list.h:67 [inline])
[<80807238>] (__list_add_valid) from [<810e61b8>] (list_add_tail include/linux/list.h:100 [inline])
[<80807238>] (__list_add_valid) from [<810e61b8>] (cma_listen_on_all drivers/infiniband/core/cma.c:2557 [inline])
[<80807238>] (__list_add_valid) from [<810e61b8>] (rdma_listen+0x17c/0x37c drivers/infiniband/core/cma.c:3751)
[<810e603c>] (rdma_listen) from [<811035a0>] (ucma_listen+0xe0/0x130 drivers/infiniband/core/ucma.c:1102)
 r8:84343b40 r7:811034c0 r6:86424948 r5:86ca70c0 r4:86424900
[<811034c0>] (ucma_listen) from [<811044a0>] (ucma_write+0x14c/0x1b0 drivers/infiniband/core/ucma.c:1732)
 r6:86ca70c0 r5:200008c0 r4:00000010
[<81104354>] (ucma_write) from [<804da914>] (vfs_write+0xe8/0x350 fs/read_write.c:603)
 r8:00000000 r7:ffffe000 r6:200008c0 r5:86c46140 r4:00000000
[<804da82c>] (vfs_write) from [<804dad30>] (ksys_write+0xb4/0xec fs/read_write.c:658)
 r10:00000004 r9:86656000 r8:80200224 r7:00000010 r6:200008c0 r5:86c46140
 r4:86c46141
[<804dac7c>] (ksys_write) from [<804dad78>] (__do_sys_write fs/read_write.c:670 [inline])
[<804dac7c>] (ksys_write) from [<804dad78>] (sys_write+0x10/0x14 fs/read_write.c:667)
 r7:00000004 r6:ffffffff r5:00000000 r4:00000000
[<804dad68>] (sys_write) from [<80200060>] (ret_fast_syscall+0x0/0x2c arch/arm/mm/proc-v7.S:64)
Exception stack(0x86657fa8 to 0x86657ff0)
7fa0:                   00000000 00000000 00000003 200008c0 00000010 00000000
7fc0: 00000000 00000000 ffffffff 00000004 7ebc531a 76f7b6d0 7ebc54a4 76f7b20c
7fe0: 76f7b048 76f7b038 00018e9c 0004ba40
Code: e34801fa e1a02001 e1a0100c eb3ffb2e (e7f001f2) 
---[ end trace 7ea3f2e08d88cef1 ]---
----------------
Code disassembly (best guess):
   0:	e34801fa 	movt	r0, #33274	; 0x81fa
   4:	e1a02001 	mov	r2, r1
   8:	e1a0100c 	mov	r1, ip
   c:	eb3ffb2e 	bl	0xffeccc
* 10:	e7f001f2 	udf	#18 <-- trapping instruction


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
