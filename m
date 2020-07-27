Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05E4422F79A
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Jul 2020 20:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729611AbgG0STz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Jul 2020 14:19:55 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:10161 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729489AbgG0STz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 27 Jul 2020 14:19:55 -0400
Received: from localhost (pvp1.blr.asicdesigners.com [10.193.80.26])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id 06RIJkef001926;
        Mon, 27 Jul 2020 11:19:51 -0700
Date:   Mon, 27 Jul 2020 23:49:45 +0530
From:   Krishnamraju Eraparaju <krishna2@chelsio.com>
To:     linux-nvme@lists.infradead.org
Cc:     linux-rdma@vger.kernel.org
Subject: Hang at NVME Host caused by Controller reset
Message-ID: <20200727181944.GA5484@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


kernel hang observed on NVME Host(TCP) while running iozone with link
toggle:

    
[ +42.773018] INFO: task kworker/u24:5:1243 blocked for more than 122
seconds.
[  +0.000124]       Not tainted 5.8.0-rc4ekr+ #19
[  +0.000105] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  +0.000164] kworker/u24:5   D12600  1243      2 0x00004000
[  +0.000114] Workqueue: nvme-reset-wq nvme_reset_ctrl_work [nvme_tcp]
[  +0.000109] Call Trace:
[  +0.000105]  __schedule+0x270/0x5d0
[  +0.000105]  schedule+0x45/0xb0
[  +0.000125]  blk_mq_freeze_queue_wait+0x41/0xa0
[  +0.000122]  ? wait_woken+0x80/0x80
[  +0.000116]  blk_mq_update_nr_hw_queues+0x8a/0x380
[  +0.000109]  nvme_tcp_setup_ctrl+0x345/0x510 [nvme_tcp]
[  +0.000108]  nvme_reset_ctrl_work+0x45/0x60 [nvme_tcp]
[  +0.000135]  process_one_work+0x149/0x380
[  +0.000107]  worker_thread+0x1ae/0x3a0
[  +0.000107]  ? process_one_work+0x380/0x380
[  +0.000108]  kthread+0xf7/0x130
[  +0.000135]  ? kthread_bind+0x10/0x10
[  +0.000121]  ret_from_fork+0x22/0x30
[  +0.000134] INFO: task bash:6000 blocked for more than 122 seconds.
[  +0.000122]       Not tainted 5.8.0-rc4ekr+ #19
[  +0.000109] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  +0.000195] bash            D14232  6000   5967 0x00000080
[  +0.000115] Call Trace:
[  +0.000106]  __schedule+0x270/0x5d0
[  +0.000138]  ? terminate_walk+0x8a/0x90
[  +0.000123]  schedule+0x45/0xb0
[  +0.000108]  schedule_timeout+0x1d6/0x290
[  +0.000121]  wait_for_completion+0x82/0xe0
[  +0.000120]  __flush_work.isra.37+0x10c/0x180
[  +0.000115]  ? flush_workqueue_prep_pwqs+0x110/0x110
[  +0.000119]  nvme_reset_ctrl_sync+0x1c/0x30 [nvme_core]
[  +0.000110]  nvme_sysfs_reset+0xd/0x20 [nvme_core]
[  +0.000137]  kernfs_fop_write+0x10a/0x1a0
[  +0.000124]  vfs_write+0xa8/0x1a0
[  +0.000122]  ksys_write+0x50/0xc0
[  +0.000117]  do_syscall_64+0x3e/0x70
[  +0.000108]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  +0.000111] RIP: 0033:0x7f4ed689dc60
[  +0.000107] Code: Bad RIP value.
[  +0.000105] RSP: 002b:00007ffe636b6fe8 EFLAGS: 00000246 ORIG_RAX:
0000000000000001
[  +0.000188] RAX: ffffffffffffffda RBX: 0000000000000002 RCX:
00007f4ed689dc60
----

This issue got uncovered after commit fe35ec58f0d3, which does
freeze-queue operation if set->nr_maps is greater than '1'(all nvmef
trasnports sets nr_maps to '2' by default). 
  
Issue will not occur with multipath enabled.
Issue observed with RDMA transports also.

Steps to reproduce: 
nvme connect -t tcp -a 102.1.1.6 -s 4420 -n nvme-ram0 -i 1

Run below each while loop in different terminals parallelly, to reprodue
instantaneously.
while [ 1 ]; do echo 1 > /sys/block/nvme0n1/device/reset_controller;
done
while [ 1 ]; do  nvme write-zeroes /dev/nvme0n1 -s 1 -c 1; done



My understanding is: while performing reset-controller, nvme-write task
tries to submit IO/blk_queue_enter, but fails at blk_mq_run_hw_queue()
after seeing blk_queue_quiesced.
And never succeeded to blk_queue_exit, may be due to out-of-sync percpu
counter operations(q_usage_counter), causing this hang at freeze_queue.

Thanks,
Krishna.
