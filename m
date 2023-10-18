Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A3C7CD7A0
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Oct 2023 11:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjJRJPx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Oct 2023 05:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjJRJPw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Oct 2023 05:15:52 -0400
Received: from mail-oa1-f80.google.com (mail-oa1-f80.google.com [209.85.160.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B66F10B
        for <linux-rdma@vger.kernel.org>; Wed, 18 Oct 2023 02:15:50 -0700 (PDT)
Received: by mail-oa1-f80.google.com with SMTP id 586e51a60fabf-1d66b019a27so8863046fac.0
        for <linux-rdma@vger.kernel.org>; Wed, 18 Oct 2023 02:15:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697620550; x=1698225350;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rnf7mxU5ljq5PJpqjMzySXNNyUScoKkMxLEuUfdA8+0=;
        b=hM3gYmN5oZv1blk+yQOdHQrG6w3tE2pGxHiiRnyNpjvSpdn2TneJr1jInOGXyrAvBF
         9+6fheHE/NqWASmGu+A6AEA6mw+jGr4iugev/wlZEq3gNvBz3ZXa98ru2yH4j1afkX+u
         P765Gwzr4JvUUX5HN7K+atyGTO4d/Qw/lU1eC10VkXxz9TM5xxcqHwaSxrnYwEHz0NMK
         2H29fpHYyE3vdfdmczkq5U82hEfvRaH+Z1xb0JT0GsDVBw372ekvZA0qtCTrgzuzuKbd
         bcZQU0g+iZ3fN0sxrgh8EdfIF40kvj1jqQtHRDhu2eot5XUePWfkSth/1Tp2qf0YwUD7
         HAVA==
X-Gm-Message-State: AOJu0YyjFtYhYkabfR1egDnEP+gow8gWkOTO8GjrhlGEUjrly+ZUe6Io
        kVBwxup+IU2MUN1hGjHw14fhMtENHgPulKdPHTaH/goF8aoL
X-Google-Smtp-Source: AGHT+IEVyOpzK0ciUkUl8pn15LkIrJ8+nZaZyVv+YpJTW6P3ZFsyCiCzeN+C9hCwesLkD1y4lMba0bHLzEuoXGWcYMP7LQdzCAk6
MIME-Version: 1.0
X-Received: by 2002:a05:6870:6586:b0:1e1:2f43:1dc6 with SMTP id
 fp6-20020a056870658600b001e12f431dc6mr2262117oab.1.1697620549825; Wed, 18 Oct
 2023 02:15:49 -0700 (PDT)
Date:   Wed, 18 Oct 2023 02:15:49 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d5fbc80607fa152b@google.com>
Subject: [syzbot] [rds?] KCSAN: data-race in rds_sendmsg / rds_sendmsg
From:   syzbot <syzbot+00563755980a79a575f6@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        rds-devel@oss.oracle.com, santosh.shilimkar@oracle.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    401644852d0b Merge tag 'fs_for_v6.6-rc6' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10bbf9ce680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=70d8e328e7a4e377
dashboard link: https://syzkaller.appspot.com/bug?extid=00563755980a79a575f6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/32193fa290fa/disk-40164485.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/45596bbf452b/vmlinux-40164485.xz
kernel image: https://storage.googleapis.com/syzbot-assets/930999dd8dfc/bzImage-40164485.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+00563755980a79a575f6@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in rds_sendmsg / rds_sendmsg

write to 0xffff8881039110f8 of 8 bytes by task 15969 on cpu 0:
 rds_sendmsg+0xbc6/0x1410 net/rds/send.c:1304
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 ____sys_sendmsg+0x37c/0x4d0 net/socket.c:2558
 ___sys_sendmsg net/socket.c:2612 [inline]
 __sys_sendmsg+0x1e9/0x270 net/socket.c:2641
 __do_sys_sendmsg net/socket.c:2650 [inline]
 __se_sys_sendmsg net/socket.c:2648 [inline]
 __x64_sys_sendmsg+0x46/0x50 net/socket.c:2648
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

read to 0xffff8881039110f8 of 8 bytes by task 15973 on cpu 1:
 rds_sendmsg+0xa51/0x1410 net/rds/send.c:1291
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 ____sys_sendmsg+0x37c/0x4d0 net/socket.c:2558
 ___sys_sendmsg net/socket.c:2612 [inline]
 __sys_sendmsg+0x1e9/0x270 net/socket.c:2641
 __do_sys_sendmsg net/socket.c:2650 [inline]
 __se_sys_sendmsg net/socket.c:2648 [inline]
 __x64_sys_sendmsg+0x46/0x50 net/socket.c:2648
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

value changed: 0x0000000000000000 -> 0xffff888137df17e8

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 PID: 15973 Comm: syz-executor.0 Not tainted 6.6.0-rc5-syzkaller-00072-g401644852d0b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
