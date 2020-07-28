Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B65D23094C
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Jul 2020 13:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729311AbgG1L72 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Jul 2020 07:59:28 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:10183 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729307AbgG1L71 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 Jul 2020 07:59:27 -0400
Received: from localhost (pvp1.blr.asicdesigners.com [10.193.80.26])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id 06SBx7U4005107;
        Tue, 28 Jul 2020 04:59:08 -0700
Date:   Tue, 28 Jul 2020 17:29:07 +0530
From:   Krishnamraju Eraparaju <krishna2@chelsio.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        bharat@chelsio.com
Subject: Re: Hang at NVME Host caused by Controller reset
Message-ID: <20200728115904.GA5508@chelsio.com>
References: <20200727181944.GA5484@chelsio.com>
 <9b8dae53-1fcc-3c03-5fcd-cfb55cd8cc80@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b8dae53-1fcc-3c03-5fcd-cfb55cd8cc80@grimberg.me>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Sagi,
With the given patch, I am no more seeing the freeze_queue_wait hang
issue, but I am seeing another hang issue:
dmesg:
[Jul28 11:01] igb 0000:03:00.0 enp3s0f0: igb: enp3s0f0 NIC Link is Up
1000 Mbps Full Duplex, Flow Control: RX
[  +0.000137] IPv6: ADDRCONF(NETDEV_CHANGE): enp3s0f0: link becomes
ready
[Jul28 11:17] cxgb4 0000:02:00.4 enp2s0f4: passive DA module inserted
[  +0.579450] cxgb4 0000:02:00.4 enp2s0f4: link up, 40Gbps, full-duplex,
Tx/Rx PAUSE
[  +0.000683] IPv6: ADDRCONF(NETDEV_CHANGE): enp2s0f4: link becomes
ready
[Jul28 11:19] nvme nvme0: Please enable CONFIG_NVME_MULTIPATH for full
support of multi-port devices.
[  +0.000159] nvme nvme0: creating 1 I/O queues.
[  +0.000350] nvme nvme0: mapped 1/0/0 default/read/poll queues.
[  +0.001316] nvme nvme0: new ctrl: NQN "nvme-ram0", addr 102.1.1.6:4420
[Jul28 11:20] DEBUG: cpu: 3: blk_queue_enter:448 process is "nvme" (pid
4011)
	q->mq_freeze_depth: 1
	(pm || (blk_pm_request_resume(q),!blk_queue_pm_only(q)))): 1
	blk_queue_dying(q): 0            
[ +21.511514] cxgb4 0000:02:00.4: Port 0 link down, reason: Link Down
[  +0.560355] cxgb4 0000:02:00.4 enp2s0f4: link up, 40Gbps, full-duplex,
Tx/Rx PAUSE
[  +0.000941] IPv6: ADDRCONF(NETDEV_CHANGE): enp2s0f4: link becomes
ready
[Jul28 11:21] cxgb4 0000:02:00.4: Port 0 link down, reason: Link Down
[  +0.552934] cxgb4 0000:02:00.4 enp2s0f4: link up, 40Gbps, full-duplex,
Tx/Rx PAUSE
[  +0.001076] IPv6: ADDRCONF(NETDEV_CHANGE): enp2s0f4: link becomes
ready
[Jul28 11:22] cxgb4 0000:02:00.4: Port 0 link down, reason: Link Down
[  +0.615365] cxgb4 0000:02:00.4 enp2s0f4: link up, 40Gbps, full-duplex,
Tx/Rx PAUSE
[  +0.000886] IPv6: ADDRCONF(NETDEV_CHANGE): enp2s0f4: link becomes
ready
[Jul28 11:23] cxgb4 0000:02:00.4: Port 0 link down, reason: Link Down
[  +0.556661] cxgb4 0000:02:00.4 enp2s0f4: link up, 40Gbps, full-duplex,
Tx/Rx PAUSE
[  +0.000837] IPv6: ADDRCONF(NETDEV_CHANGE): enp2s0f4: link becomes
ready
[  +3.765550] INFO: task bash:3014 blocked for more than 122 seconds.
[  +0.000067]       Not tainted 5.8.0-rc7ekr+ #2
[  +0.000057] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  +0.000064] bash            D14272  3014   2417 0x00000000
[  +0.000066] Call Trace:
[  +0.000064]  __schedule+0x32b/0x670
[  +0.000060]  schedule+0x45/0xb0
[  +0.000059]  schedule_timeout+0x216/0x330
[  +0.000060]  ? enqueue_task_fair+0x196/0x7e0
[  +0.000059]  wait_for_completion+0x81/0xe0
[  +0.000061]  __flush_work+0x114/0x1c0
[  +0.000058]  ? flush_workqueue_prep_pwqs+0x130/0x130
[  +0.000066]  nvme_reset_ctrl_sync+0x25/0x40 [nvme_core]
[  +0.000125]  nvme_sysfs_reset+0xd/0x20 [nvme_core]
[  +0.000137]  kernfs_fop_write+0xbc/0x1a0
[  +0.000114]  vfs_write+0xc2/0x1f0
[  +0.000120]  ksys_write+0x5a/0xd0
[  +0.000106]  do_syscall_64+0x3e/0x70
[  +0.000122]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  +0.000115] RIP: 0033:0x7f8124b93317
[  +0.000110] Code: Bad RIP value.
[  +0.000109] RSP: 002b:00007ffdbbbff1c8 EFLAGS: 00000246 ORIG_RAX:
0000000000000001
[  +0.000182] RAX: ffffffffffffffda RBX: 0000000000000002 RCX:
00007f8124b93317
[  +0.000138] RDX: 0000000000000002 RSI: 0000559345c156d0 RDI:
0000000000000001
[  +0.000125] RBP: 0000559345c156d0 R08: 000000000000000a R09:
0000000000000001
[  +0.000117] R10: 00005593453d1471 R11: 0000000000000246 R12:
0000000000000002
[  +0.000116] R13: 00007f8124c6d6a0 R14: 00007f8124c6e4a0 R15:
00007f8124c6d8a0
[  +0.000121] INFO: task nvme:4011 blocked for more than 122 seconds.
[  +0.000118]       Not tainted 5.8.0-rc7ekr+ #2
[  +0.000114] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  +0.000190] nvme            D14392  4011   2326 0x00004000
[  +0.000132] Call Trace:
[  +0.000117]  __schedule+0x32b/0x670
[  +0.000109]  schedule+0x45/0xb0
[  +0.000108]  blk_queue_enter+0x1e9/0x250
[  +0.000109]  ? wait_woken+0x70/0x70
[  +0.000108]  blk_mq_alloc_request+0x53/0xc0
[  +0.000112]  nvme_alloc_request+0x61/0x70 [nvme_core]
[  +0.000118]  nvme_submit_user_cmd+0x50/0x310 [nvme_core]
[  +0.000126]  nvme_user_cmd+0x12e/0x1c0 [nvme_core]
[  +0.000124]  ? _copy_to_user+0x22/0x30
[  +0.000108]  blkdev_ioctl+0x100/0x250
[  +0.000109]  block_ioctl+0x34/0x40
[  +0.000110]  ksys_ioctl+0x82/0xc0
[  +0.000106]  __x64_sys_ioctl+0x11/0x20
[  +0.000126]  do_syscall_64+0x3e/0x70
[  +0.000113]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  +0.000132] RIP: 0033:0x7fed0bd2967b
[  +0.000134] Code: Bad RIP value.
[  +0.000107] RSP: 002b:00007fff55b568a8 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[  +0.000172] RAX: ffffffffffffffda RBX: 0000000000000003 RCX:
00007fed0bd2967b
[  +0.000112] RDX: 00007fff55b568b0 RSI: 00000000c0484e43 RDI:
0000000000000003
[  +0.000113] RBP: 0000000000000000 R08: 0000000000000001 R09:
0000000000000000
[  +0.000130] R10: 0000000000000000 R11: 0000000000000246 R12:
00007fff55b5878a
[  +0.000119] R13: 0000000000000006 R14: 00007fff55b56f60 R15:
00005595f54554a0
[  +0.000135] Kernel panic - not syncing: hung_task: blocked tasks
[  +0.000141] CPU: 8 PID: 520 Comm: khungtaskd Not tainted 5.8.0-rc7ekr+
#2



Testcase:
 while [ 1 ]; do  nvme write-zeroes /dev/nvme0n1 -s 1 -c 1; done
 while [ 1 ]; do echo 1 > /sys/block/nvme0n1/device/reset_controller;
done
 while [ 1 ]; do ifconfig enp2s0f4 down; sleep 24; ifconfig enp2s0f4 up;
sleep 28;  done


