Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFE44B163D
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Feb 2022 20:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343946AbiBJT1V (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Feb 2022 14:27:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234293AbiBJT1U (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Feb 2022 14:27:20 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FB11020
        for <linux-rdma@vger.kernel.org>; Thu, 10 Feb 2022 11:27:20 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id s13-20020a056602168d00b00639a3edcae8so900555iow.15
        for <linux-rdma@vger.kernel.org>; Thu, 10 Feb 2022 11:27:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=LMMDOFylVquYF0n4sN4O1PCJ0tpDWdxtYU0vmJFDpqU=;
        b=e0sm0505z4egYl7lN1VJlwmqoQW9+YncyG0lZEDKXa2pMGpys+fn8kovkq3kyW4LQP
         /H3FoXuv2pLEZ+81U/iEueC5wl0DHXrmiaWljOaR8g/FdM4uHnU80kcvUdFHSYaCSPTp
         doGjaGRc0yPQPAGMr1gO+EjEJhPkaehECWVPBehkrC9FSTdJycsG0GkX+pNRy+uSKRAh
         iwCw/iUn+4w4YZ8blldznnrwxe7k3lihhYUPIhmTIX6C9nkdN5Ug5dhfAFqaeCYlbprn
         nCNaCh7mfA00cnspXGfyWC8lfdzEzgdWt+rFnufENASYi+Dd9Q3FtR2qrhAxexFwmF8g
         PHng==
X-Gm-Message-State: AOAM531/OuX0Skl8Py26F1nsIdbLQ1YxfcEsaGTX+8FOk0m/aIJnnll3
        fSgckjs1cA6QLE7YhScUYEcXLeqyzrTYiDGzCIvBSkNO/875
X-Google-Smtp-Source: ABdhPJyWKbD6+INMHE7mpzXw2Oh5v203nGMEGZRKfzlLwea4FVTMG93Oh2cK/bAN8DpkTgJ5afuSHIJ83kCRLm9AltSGa+TiwfBV
MIME-Version: 1.0
X-Received: by 2002:a92:cd84:: with SMTP id r4mr4886368ilb.180.1644521240227;
 Thu, 10 Feb 2022 11:27:20 -0800 (PST)
Date:   Thu, 10 Feb 2022 11:27:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005975a605d7aef05e@google.com>
Subject: [syzbot] possible deadlock in worker_thread
From:   syzbot <syzbot+831661966588c802aae9@syzkaller.appspotmail.com>
To:     bvanassche@acm.org, jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    d8ad2ce873ab Merge tag 'ext4_for_linus_stable' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17823662700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6f043113811433a5
dashboard link: https://syzkaller.appspot.com/bug?extid=831661966588c802aae9
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+831661966588c802aae9@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.17.0-rc2-syzkaller-00398-gd8ad2ce873ab #0 Not tainted
------------------------------------------------------
kworker/0:7/17139 is trying to acquire lock:
ffff888077a89938 ((wq_completion)loop1){+.+.}-{0:0}, at: flush_workqueue+0xe1/0x13a0 kernel/workqueue.c:2824

but task is already holding lock:
ffffc9000fa07db8 ((work_completion)(&lo->rundown_work)){+.+.}-{0:0}, at: process_one_work+0x8c4/0x1650 kernel/workqueue.c:2282

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #7 ((work_completion)(&lo->rundown_work)){+.+.}-{0:0}:
       process_one_work+0x91b/0x1650 kernel/workqueue.c:2283
       worker_thread+0x657/0x1110 kernel/workqueue.c:2454
       kthread+0x2e9/0x3a0 kernel/kthread.c:377
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

-> #6 ((wq_completion)events_long){+.+.}-{0:0}:
       flush_workqueue+0x110/0x13a0 kernel/workqueue.c:2827
       srp_remove_one+0x1cf/0x320 drivers/infiniband/ulp/srp/ib_srp.c:4052
       remove_client_context+0xbe/0x110 drivers/infiniband/core/device.c:775
       disable_device+0x13b/0x270 drivers/infiniband/core/device.c:1281
       __ib_unregister_device+0x98/0x1a0 drivers/infiniband/core/device.c:1474
       ib_unregister_device_and_put+0x57/0x80 drivers/infiniband/core/device.c:1538
       nldev_dellink+0x1fb/0x300 drivers/infiniband/core/nldev.c:1747
       rdma_nl_rcv_msg+0x36d/0x690 drivers/infiniband/core/netlink.c:195
       rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
       rdma_nl_rcv+0x2ee/0x430 drivers/infiniband/core/netlink.c:259
       netlink_unicast_kernel net/netlink/af_netlink.c:1317 [inline]
       netlink_unicast+0x539/0x7e0 net/netlink/af_netlink.c:1343
       netlink_sendmsg+0x904/0xe00 net/netlink/af_netlink.c:1919
       sock_sendmsg_nosec net/socket.c:705 [inline]
       sock_sendmsg+0xcf/0x120 net/socket.c:725
       ____sys_sendmsg+0x6e8/0x810 net/socket.c:2413
       ___sys_sendmsg+0xf3/0x170 net/socket.c:2467
       __sys_sendmsg+0xe5/0x1b0 net/socket.c:2496
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #5 (&device->unregistration_lock){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:600 [inline]
       __mutex_lock+0x12f/0x12f0 kernel/locking/mutex.c:733
       __ib_unregister_device+0x25/0x1a0 drivers/infiniband/core/device.c:1470
       ib_unregister_device_and_put+0x57/0x80 drivers/infiniband/core/device.c:1538
       nldev_dellink+0x1fb/0x300 drivers/infiniband/core/nldev.c:1747
       rdma_nl_rcv_msg+0x36d/0x690 drivers/infiniband/core/netlink.c:195
       rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
       rdma_nl_rcv+0x2ee/0x430 drivers/infiniband/core/netlink.c:259
       netlink_unicast_kernel net/netlink/af_netlink.c:1317 [inline]
       netlink_unicast+0x539/0x7e0 net/netlink/af_netlink.c:1343
       netlink_sendmsg+0x904/0xe00 net/netlink/af_netlink.c:1919
       sock_sendmsg_nosec net/socket.c:705 [inline]
       sock_sendmsg+0xcf/0x120 net/socket.c:725
       ____sys_sendmsg+0x6e8/0x810 net/socket.c:2413
       ___sys_sendmsg+0xf3/0x170 net/socket.c:2467
       __sys_sendmsg+0xe5/0x1b0 net/socket.c:2496
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #4 (&rdma_nl_types[idx].sem){.+.+}-{3:3}:
       down_read+0x98/0x440 kernel/locking/rwsem.c:1461
       rdma_nl_rcv_msg+0x161/0x690 drivers/infiniband/core/netlink.c:164
       rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
       rdma_nl_rcv+0x2ee/0x430 drivers/infiniband/core/netlink.c:259
       netlink_unicast_kernel net/netlink/af_netlink.c:1317 [inline]
       netlink_unicast+0x539/0x7e0 net/netlink/af_netlink.c:1343
       netlink_sendmsg+0x904/0xe00 net/netlink/af_netlink.c:1919
       sock_sendmsg_nosec net/socket.c:705 [inline]
       sock_sendmsg+0xcf/0x120 net/socket.c:725
       sock_no_sendpage+0xf6/0x140 net/core/sock.c:3091
       kernel_sendpage.part.0+0x1a0/0x340 net/socket.c:3492
       kernel_sendpage net/socket.c:3489 [inline]
       sock_sendpage+0xe5/0x140 net/socket.c:1007
       pipe_to_sendpage+0x2ad/0x380 fs/splice.c:364
       splice_from_pipe_feed fs/splice.c:418 [inline]
       __splice_from_pipe+0x43e/0x8a0 fs/splice.c:562
       splice_from_pipe fs/splice.c:597 [inline]
       generic_splice_sendpage+0xd4/0x140 fs/splice.c:746
       do_splice_from fs/splice.c:767 [inline]
       do_splice+0xb7e/0x1960 fs/splice.c:1079
       __do_splice+0x134/0x250 fs/splice.c:1144
       __do_sys_splice fs/splice.c:1350 [inline]
       __se_sys_splice fs/splice.c:1332 [inline]
       __x64_sys_splice+0x198/0x250 fs/splice.c:1332
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #3 (&pipe->mutex/1){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:600 [inline]
       __mutex_lock+0x12f/0x12f0 kernel/locking/mutex.c:733
       pipe_lock_nested fs/pipe.c:82 [inline]
       pipe_lock+0x5a/0x70 fs/pipe.c:90
       iter_file_splice_write+0x15a/0xc10 fs/splice.c:635
       do_splice_from fs/splice.c:767 [inline]
       do_splice+0xb7e/0x1960 fs/splice.c:1079
       __do_splice+0x134/0x250 fs/splice.c:1144
       __do_sys_splice fs/splice.c:1350 [inline]
       __se_sys_splice fs/splice.c:1332 [inline]
       __x64_sys_splice+0x198/0x250 fs/splice.c:1332
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #2 (sb_writers#3){.+.+}-{0:0}:
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1722 [inline]
       sb_start_write include/linux/fs.h:1792 [inline]
       file_start_write include/linux/fs.h:2937 [inline]
       lo_write_bvec drivers/block/loop.c:242 [inline]
       lo_write_simple drivers/block/loop.c:265 [inline]
       do_req_filebacked drivers/block/loop.c:494 [inline]
       loop_handle_cmd drivers/block/loop.c:1853 [inline]
       loop_process_work+0x1499/0x1db0 drivers/block/loop.c:1893
       process_one_work+0x9ac/0x1650 kernel/workqueue.c:2307
       worker_thread+0x657/0x1110 kernel/workqueue.c:2454
       kthread+0x2e9/0x3a0 kernel/kthread.c:377
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

-> #1 ((work_completion)(&worker->work)){+.+.}-{0:0}:
       process_one_work+0x91b/0x1650 kernel/workqueue.c:2283
       worker_thread+0x657/0x1110 kernel/workqueue.c:2454
       kthread+0x2e9/0x3a0 kernel/kthread.c:377
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

-> #0 ((wq_completion)loop1){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3063 [inline]
       check_prevs_add kernel/locking/lockdep.c:3186 [inline]
       validate_chain kernel/locking/lockdep.c:3801 [inline]
       __lock_acquire+0x2a2c/0x5470 kernel/locking/lockdep.c:5027
       lock_acquire kernel/locking/lockdep.c:5639 [inline]
       lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5604
       flush_workqueue+0x110/0x13a0 kernel/workqueue.c:2827
       drain_workqueue+0x1a5/0x3c0 kernel/workqueue.c:2992
       destroy_workqueue+0x71/0x800 kernel/workqueue.c:4429
       __loop_clr_fd+0x19b/0xd80 drivers/block/loop.c:1118
       loop_rundown_workfn+0x6f/0x150 drivers/block/loop.c:1185
       process_one_work+0x9ac/0x1650 kernel/workqueue.c:2307
       worker_thread+0x657/0x1110 kernel/workqueue.c:2454
       kthread+0x2e9/0x3a0 kernel/kthread.c:377
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

other info that might help us debug this:

Chain exists of:
  (wq_completion)loop1 --> (wq_completion)events_long --> (work_completion)(&lo->rundown_work)

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock((work_completion)(&lo->rundown_work));
                               lock((wq_completion)events_long);
                               lock((work_completion)(&lo->rundown_work));
  lock((wq_completion)loop1);

 *** DEADLOCK ***

2 locks held by kworker/0:7/17139:
 #0: ffff888010c73538 ((wq_completion)events_long){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888010c73538 ((wq_completion)events_long){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888010c73538 ((wq_completion)events_long){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff888010c73538 ((wq_completion)events_long){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:631 [inline]
 #0: ffff888010c73538 ((wq_completion)events_long){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:658 [inline]
 #0: ffff888010c73538 ((wq_completion)events_long){+.+.}-{0:0}, at: process_one_work+0x890/0x1650 kernel/workqueue.c:2278
 #1: ffffc9000fa07db8 ((work_completion)(&lo->rundown_work)){+.+.}-{0:0}, at: process_one_work+0x8c4/0x1650 kernel/workqueue.c:2282

stack backtrace:
CPU: 0 PID: 17139 Comm: kworker/0:7 Not tainted 5.17.0-rc2-syzkaller-00398-gd8ad2ce873ab #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events_long loop_rundown_workfn
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2143
 check_prev_add kernel/locking/lockdep.c:3063 [inline]
 check_prevs_add kernel/locking/lockdep.c:3186 [inline]
 validate_chain kernel/locking/lockdep.c:3801 [inline]
 __lock_acquire+0x2a2c/0x5470 kernel/locking/lockdep.c:5027
 lock_acquire kernel/locking/lockdep.c:5639 [inline]
 lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5604
 flush_workqueue+0x110/0x13a0 kernel/workqueue.c:2827
 drain_workqueue+0x1a5/0x3c0 kernel/workqueue.c:2992
 destroy_workqueue+0x71/0x800 kernel/workqueue.c:4429
 __loop_clr_fd+0x19b/0xd80 drivers/block/loop.c:1118
 loop_rundown_workfn+0x6f/0x150 drivers/block/loop.c:1185
 process_one_work+0x9ac/0x1650 kernel/workqueue.c:2307
 worker_thread+0x657/0x1110 kernel/workqueue.c:2454
 kthread+0x2e9/0x3a0 kernel/kthread.c:377
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>
usb 4-1: new high-speed USB device number 63 using dummy_hcd
usb 4-1: New USB device found, idVendor=0af0, idProduct=d058, bcdDevice= 0.00
usb 4-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 4-1: Product: syz
usb 4-1: Manufacturer: syz
usb 4-1: SerialNumber: syz
usb 4-1: config 0 descriptor??
usb-storage 4-1:0.0: USB Mass Storage device detected
usb 1-1: new high-speed USB device number 103 using dummy_hcd
usb 1-1: New USB device found, idVendor=0af0, idProduct=d058, bcdDevice= 0.00
usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 1-1: Product: syz
usb 1-1: Manufacturer: syz
usb 1-1: SerialNumber: syz
usb 1-1: config 0 descriptor??
usb-storage 1-1:0.0: USB Mass Storage device detected
usb 4-1: USB disconnect, device number 65


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
