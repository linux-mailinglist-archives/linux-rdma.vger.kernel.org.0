Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12955647F46
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Dec 2022 09:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbiLIIdk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Dec 2022 03:33:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiLIIdj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Dec 2022 03:33:39 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ACCD2A426
        for <linux-rdma@vger.kernel.org>; Fri,  9 Dec 2022 00:33:38 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id i7-20020a056e021b0700b003033a763270so3373118ilv.19
        for <linux-rdma@vger.kernel.org>; Fri, 09 Dec 2022 00:33:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N2ODYm1TnR+hl6/rIL8AFPuQZAHZk8y749ZuBNbrXOs=;
        b=FK7WweIXbXBRCnO81dEe+lWO9zCV71FK+/+H0Z3qYx55YRbU1Yc8oGij0DpF64oiyI
         5Ym6QlOE0y9haEuXBxI4aj43vt+sTNCo0MwqG8w1aYxh5658Po6xqn6TrPMd+kaWf6b9
         9BHrIGslOabe2CUuSovLHKy9EHvdhoZY2TAqWtbEHE1gsGkBGhHa7zhC5F0dS3vulsE7
         KMxzYUKnxkq9GPuf3sW2zwUtlW96owabengRqi06bSV4gK+cW2qerMAD3R81fZXjI1kP
         ittdTxwze6KLsCehVqsuDHGpSspWPV1mmH1GKPSTvRc/JmpbKsBVFXFr8HwBVeZwpwBr
         1O5A==
X-Gm-Message-State: ANoB5pkuAv/WTh6kGJtmabG6KF0RQ9+9uNRjkERswzCID0QwEDzTJFfx
        /n2BwPFGydquC7tZ6KoDpAgzF7Y5xKzRZGIKmrYtxFwcJcEG
X-Google-Smtp-Source: AA0mqf5zhTcWi9zeWKhdBVUTazVGoCOFIIAwrcWajIWIflqYl1edypdN3wHKC+T/pQRBESo9/DOrZCCpSeG8wjVvAhU2Uma1BEs9
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:c69:b0:303:91d0:19f2 with SMTP id
 f9-20020a056e020c6900b0030391d019f2mr622715ilj.228.1670574817543; Fri, 09 Dec
 2022 00:33:37 -0800 (PST)
Date:   Fri, 09 Dec 2022 00:33:37 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000920dde05ef6102cf@google.com>
Subject: [syzbot] WARNING: refcount bug in free_netdevs
From:   syzbot <syzbot+a1ed8ffe3121380cd5dd@syzkaller.appspotmail.com>
To:     chenzhongjin@huawei.com, gregkh@linuxfoundation.org, jgg@ziepe.ca,
        leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, penguin-kernel@I-love.SAKURA.ne.jp,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    591cd61541b9 Add linux-next specific files for 20221207
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1773a623880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8b2d3e63e054c24f
dashboard link: https://syzkaller.appspot.com/bug?extid=a1ed8ffe3121380cd5dd
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/bc862c01ec56/disk-591cd615.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8f9b93f8ed2f/vmlinux-591cd615.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9d5cb636d548/bzImage-591cd615.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a1ed8ffe3121380cd5dd@syzkaller.appspotmail.com

------------[ cut here ]------------
refcount_t: decrement hit 0; leaking memory.
WARNING: CPU: 1 PID: 33 at lib/refcount.c:31 refcount_warn_saturate+0x1d7/0x1f0 lib/refcount.c:31
Modules linked in:
CPU: 1 PID: 33 Comm: kworker/u4:2 Not tainted 6.1.0-rc8-next-20221207-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Workqueue: ib-unreg-wq ib_unregister_work
RIP: 0010:refcount_warn_saturate+0x1d7/0x1f0 lib/refcount.c:31
Code: 05 5a 60 51 0a 01 e8 35 0a b5 05 0f 0b e9 d3 fe ff ff e8 6c 9b 75 fd 48 c7 c7 c0 6d a6 8a c6 05 37 60 51 0a 01 e8 16 0a b5 05 <0f> 0b e9 b4 fe ff ff 48 89 ef e8 5a b5 c3 fd e9 5c fe ff ff 0f 1f
RSP: 0018:ffffc90000aa7b30 EFLAGS: 00010082
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff8880172f9d40 RSI: ffffffff8166b1dc RDI: fffff52000154f58
RBP: ffff88807906c600 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000001 R11: 0000000000000000 R12: 1ffff92000154f6b
R13: 0000000000000000 R14: ffff88807906c600 R15: ffff888046894000
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffe350a8ff8 CR3: 000000007a9e7000 CR4: 00000000003526e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __refcount_dec include/linux/refcount.h:344 [inline]
 refcount_dec include/linux/refcount.h:359 [inline]
 ref_tracker_free+0x539/0x6b0 lib/ref_tracker.c:118
 netdev_tracker_free include/linux/netdevice.h:4039 [inline]
 netdev_put include/linux/netdevice.h:4056 [inline]
 dev_put include/linux/netdevice.h:4082 [inline]
 free_netdevs+0x1f8/0x470 drivers/infiniband/core/device.c:2204
 __ib_unregister_device+0xa0/0x1a0 drivers/infiniband/core/device.c:1478
 ib_unregister_work+0x19/0x30 drivers/infiniband/core/device.c:1586
 process_one_work+0x9bf/0x1710 kernel/workqueue.c:2289
 worker_thread+0x669/0x1090 kernel/workqueue.c:2436
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
