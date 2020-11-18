Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B05802B7F5F
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Nov 2020 15:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgKRO0V (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Nov 2020 09:26:21 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:50385 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgKRO0U (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Nov 2020 09:26:20 -0500
Received: by mail-il1-f197.google.com with SMTP id f66so1636767ilh.17
        for <linux-rdma@vger.kernel.org>; Wed, 18 Nov 2020 06:26:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=l2YGKnIiac0LtUxDygHJD2CNY6JUGYnAhg9eqNKMueU=;
        b=GmQ4MmpWUsjRKhuXNtRgdGmOBNaBv7yJEl8vkHoQkzzNZrDrMJX6giIxKI0x/Hsd7q
         oJEQLVHiH5zC9OMKP55WySMxVdZ7OT9KX7ZNbR/osxsbdUl0V9oqL0poCg0LQ2FQ47H8
         BS+47/2RfDRtfxUtPXN9ghlt/ECJkQp6hBcZ7JA7pc0ppECiBPE1E44kyMMx6UoAmW+D
         q6K7JCepwMkx9lLaf7pk6w3EHqEAI2pvX+7nSMAh36RaqrabEwEpug9ISwaVPmwuvnRd
         nowoNoZveN0qo062B4bfN5JfLADzzMmttT53zndG3SRmbewun3oBlpzVu/5pj4lQiIGU
         y4qQ==
X-Gm-Message-State: AOAM531gxlpY2++NbapBJBO83Unx16P5dzecIZc3DhjaJsIrr8pY1Tz7
        d+OR4dpVvdujyWpsFKz9n240zlGcFAq9ASHEKTQe/yK/7Xkj
X-Google-Smtp-Source: ABdhPJzpRHimeeP85L7WZavrx3Idc0otWW5TjKG26EYleneNHbqK05WPbK2gCDuhZJ+S2rqdldfIIwyQi/TPF2sHeETXQ/SJ85Ss
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1305:: with SMTP id h5mr15473303iov.41.1605709579395;
 Wed, 18 Nov 2020 06:26:19 -0800 (PST)
Date:   Wed, 18 Nov 2020 06:26:19 -0800
In-Reply-To: <0000000000004129c705b45fa8f2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000017a55905b4626510@google.com>
Subject: Re: possible deadlock in _destroy_id
From:   syzbot <syzbot+1bc48bf7f78253f664a9@syzkaller.appspotmail.com>
To:     dledford@redhat.com, jgg@ziepe.ca, leon@kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        parav@mellanox.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    20529233 Add linux-next specific files for 20201118
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16ce97be500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2c4fb58b6526b3c1
dashboard link: https://syzkaller.appspot.com/bug?extid=1bc48bf7f78253f664a9
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10b53981500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10e94c7e500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1bc48bf7f78253f664a9@syzkaller.appspotmail.com

wlan1 speed is unknown, defaulting to 1000
iwpm_register_pid: Unable to send a nlmsg (client = 2)
infiniband syz2: RDMA CMA: cma_listen_on_dev, error -98
============================================
WARNING: possible recursive locking detected
5.10.0-rc4-next-20201118-syzkaller #0 Not tainted
--------------------------------------------
syz-executor872/8502 is trying to acquire lock:
ffffffff8c684748 (lock#6){+.+.}-{3:3}, at: cma_release_dev drivers/infiniband/core/cma.c:476 [inline]
ffffffff8c684748 (lock#6){+.+.}-{3:3}, at: _destroy_id+0x299/0xa00 drivers/infiniband/core/cma.c:1852

but task is already holding lock:
ffffffff8c684748 (lock#6){+.+.}-{3:3}, at: cma_add_one+0x55c/0xce0 drivers/infiniband/core/cma.c:4902

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(lock#6);
  lock(lock#6);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

6 locks held by syz-executor872/8502:
 #0: ffffffff8fa76958 (&rdma_nl_types[idx].sem){.+.+}-{3:3}, at: rdma_nl_rcv_msg+0x15b/0x690 drivers/infiniband/core/netlink.c:164
 #1: ffffffff8c66c490 (link_ops_rwsem){++++}-{3:3}, at: nldev_newlink+0x261/0x540 drivers/infiniband/core/nldev.c:1545
 #2: ffffffff8c65bd90 (devices_rwsem){++++}-{3:3}, at: enable_device_and_get+0xfc/0x3c0 drivers/infiniband/core/device.c:1321
 #3: ffffffff8c65bc50 (clients_rwsem){++++}-{3:3}, at: enable_device_and_get+0x163/0x3c0 drivers/infiniband/core/device.c:1331
 #4: ffff888026f28598 (&device->client_data_rwsem){++++}-{3:3}, at: add_client_context+0x3d0/0x5e0 drivers/infiniband/core/device.c:710
 #5: ffffffff8c684748 (lock#6){+.+.}-{3:3}, at: cma_add_one+0x55c/0xce0 drivers/infiniband/core/cma.c:4902

stack backtrace:
CPU: 1 PID: 8502 Comm: syz-executor872 Not tainted 5.10.0-rc4-next-20201118-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:120
 print_deadlock_bug kernel/locking/lockdep.c:2759 [inline]
 check_deadlock kernel/locking/lockdep.c:2802 [inline]
 validate_chain kernel/locking/lockdep.c:3593 [inline]
 __lock_acquire.cold+0x115/0x39f kernel/locking/lockdep.c:4830
 lock_acquire kernel/locking/lockdep.c:5435 [inline]
 lock_acquire+0x2a3/0x8c0 kernel/locking/lockdep.c:5400
 __mutex_lock_common kernel/locking/mutex.c:956 [inline]
 __mutex_lock+0x134/0x1110 kernel/locking/mutex.c:1103
 cma_release_dev drivers/infiniband/core/cma.c:476 [inline]
 _destroy_id+0x299/0xa00 drivers/infiniband/core/cma.c:1852
 cma_listen_on_dev.cold+0x168/0x16d drivers/infiniband/core/cma.c:2535
 cma_add_one+0x667/0xce0 drivers/infiniband/core/cma.c:4905
 add_client_context+0x405/0x5e0 drivers/infiniband/core/device.c:712
 enable_device_and_get+0x1d5/0x3c0 drivers/infiniband/core/device.c:1333
 ib_register_device drivers/infiniband/core/device.c:1408 [inline]
 ib_register_device+0x7a0/0xa30 drivers/infiniband/core/device.c:1367
 siw_device_register drivers/infiniband/sw/siw/siw_main.c:72 [inline]
 siw_newlink drivers/infiniband/sw/siw/siw_main.c:545 [inline]
 siw_newlink+0xddb/0x1340 drivers/infiniband/sw/siw/siw_main.c:522
 nldev_newlink+0x30e/0x540 drivers/infiniband/core/nldev.c:1555
 rdma_nl_rcv_msg+0x367/0x690 drivers/infiniband/core/netlink.c:195
 rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
 rdma_nl_rcv+0x2f2/0x440 drivers/infiniband/core/netlink.c:259
 netlink_unicast_kernel net/netlink/af_netlink.c:1304 [inline]
 netlink_unicast+0x533/0x7d0 net/netlink/af_netlink.c:1330
 netlink_sendmsg+0x856/0xd90 net/netlink/af_netlink.c:1919
 sock_sendmsg_nosec net/socket.c:650 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:670
 ____sys_sendmsg+0x6e8/0x810 net/socket.c:2339
 ___sys_sendmsg+0xf3/0x170 net/socket.c:2393
 __sys_sendmsg+0xe5/0x1b0 net/socket.c:2426
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x440339
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fff91ac9ae8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440339
RDX: 0000000000000000 RSI: 00000000200002c0 RDI: 0000000000000003
RBP: 00000000006ca018 R08: 0000000000000014 R09: 00000000004002c8
R10: 0000000000000041 R11: 0000000000000246 R12: 0000000000401b40
R13: 0000000000401bd0 R14: 0000000000000000 R15: 0000000000000000

