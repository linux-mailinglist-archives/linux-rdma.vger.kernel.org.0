Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A35D6462E1
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Dec 2022 21:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiLGUxs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Dec 2022 15:53:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbiLGUxc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Dec 2022 15:53:32 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D7283265
        for <linux-rdma@vger.kernel.org>; Wed,  7 Dec 2022 12:51:40 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id i7-20020a056e021b0700b003033a763270so16311077ilv.19
        for <linux-rdma@vger.kernel.org>; Wed, 07 Dec 2022 12:51:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HyvDeG6Y2UoKzWcZcDaELbnX5GhOusiE9HkxBScn33c=;
        b=W/yBr8oiHB4rjG9fdTscBW3o71JsXfawRPb/gwkhD/M6G+XUy3MC7SZ1kHSHYqz3Vi
         ZiH5X9nFurIF8eYHHv0PU566xRZ7NPjIkbTd58LCdjFIMZKJLoKhtBHgRhfln85KVqRs
         mKr9vgxLXq1dAkBQCGufBmLT+4IASTPTwBqdXPqFh05S7AC6vO4060RMtb2Lvjtue0Ug
         tEWNzMJz8Qu9Qdcc33/25Vhat3c4gJvNHVfqzJsMhCvpPtWEizacXAn7I6hTcKqWvgiW
         1YdwtHwzPC2xuVU5GaVr+lOE6syZ0KaXesd3JlNPukVPjzJxzQhLOcCYz2eRyk2MQrGn
         Jf2A==
X-Gm-Message-State: ANoB5plaMYanVPwJJpTuxfkUZxRTVu20MoG7Y1UqaQVV/5vU1RjZoKZj
        /aT2pD2pNPWZMCX/OulqTbqALg3I9IdQluK3bmaKYfV7Exi/
X-Google-Smtp-Source: AA0mqf7bOULAPk0zMt+Rt++BFFDspzE/DiYVBxLj04TBMNQWKAPcbig10p2+brjyCAjC0Db04TB11X+osWwOKr+Dh1OKS8TN18MG
MIME-Version: 1.0
X-Received: by 2002:a5d:97c9:0:b0:6a2:e3df:a40e with SMTP id
 k9-20020a5d97c9000000b006a2e3dfa40emr42762720ios.113.1670446299732; Wed, 07
 Dec 2022 12:51:39 -0800 (PST)
Date:   Wed, 07 Dec 2022 12:51:39 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004fe6c005ef43161d@google.com>
Subject: [syzbot] WARNING: refcount bug in nldev_newlink
From:   syzbot <syzbot+3fd8326d9a0812d19218@syzkaller.appspotmail.com>
To:     jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, markzhang@nvidia.com,
        ohartoov@nvidia.com, syzkaller-bugs@googlegroups.com
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
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11aeafad880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8b2d3e63e054c24f
dashboard link: https://syzkaller.appspot.com/bug?extid=3fd8326d9a0812d19218
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=112536fb880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16aa2e6d880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/bc862c01ec56/disk-591cd615.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8f9b93f8ed2f/vmlinux-591cd615.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9d5cb636d548/bzImage-591cd615.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3fd8326d9a0812d19218@syzkaller.appspotmail.com

WARNING: CPU: 0 PID: 5156 at lib/refcount.c:31 refcount_warn_saturate+0x1d7/0x1f0 lib/refcount.c:31
Modules linked in:
CPU: 0 PID: 5156 Comm: syz-executor773 Not tainted 6.1.0-rc8-next-20221207-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:refcount_warn_saturate+0x1d7/0x1f0 lib/refcount.c:31
Code: 05 5a 60 51 0a 01 e8 35 0a b5 05 0f 0b e9 d3 fe ff ff e8 6c 9b 75 fd 48 c7 c7 c0 6d a6 8a c6 05 37 60 51 0a 01 e8 16 0a b5 05 <0f> 0b e9 b4 fe ff ff 48 89 ef e8 5a b5 c3 fd e9 5c fe ff ff 0f 1f
RSP: 0018:ffffc90003ebf0d8 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff88802bfcba80 RSI: ffffffff8166b1dc RDI: fffff520007d7e0d
RBP: ffff888070296600 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000000 R12: 1ffff920007d7e20
R13: 0000000000000000 R14: ffff888070296600 R15: ffffc90003ebf608
FS:  000055555600f300(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffed185b004 CR3: 00000000265db000 CR4: 00000000003506f0
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
 nldev_newlink+0x360/0x5d0 drivers/infiniband/core/nldev.c:1733
 rdma_nl_rcv_msg+0x371/0x6a0 drivers/infiniband/core/netlink.c:195
 rdma_nl_rcv_skb.constprop.0.isra.0+0x2fc/0x440 drivers/infiniband/core/netlink.c:239
 netlink_unicast_kernel net/netlink/af_netlink.c:1330 [inline]
 netlink_unicast+0x547/0x7f0 net/netlink/af_netlink.c:1356
 netlink_sendmsg+0x91b/0xe10 net/netlink/af_netlink.c:1932
 sock_sendmsg_nosec net/socket.c:714 [inline]
 sock_sendmsg+0xd3/0x120 net/socket.c:734
 ____sys_sendmsg+0x712/0x8c0 net/socket.c:2476
 ___sys_sendmsg+0x110/0x1b0 net/socket.c:2530
 __sys_sendmsg+0xf7/0x1c0 net/socket.c:2559
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fd5bc473699
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 41 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffed185aff8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fd5bc473699
RDX: 0000000000000000 RSI: 0000000020000340 RDI: 0000000000000003
RBP: 0000000000000000 R08: 000000000000000d R09: 000000000000000d
R10: 00007ffed185aa70 R11: 0000000000000246 R12: 00007ffed185b010
R13: 00000000000f4240 R14: 0000000000011fc1 R15: 00007ffed185b004
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
