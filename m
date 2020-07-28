Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09CCD23110F
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Jul 2020 19:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732053AbgG1Rmx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Jul 2020 13:42:53 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:58861 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732035AbgG1Rmw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 Jul 2020 13:42:52 -0400
Received: from localhost (pvp1.blr.asicdesigners.com [10.193.80.26])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id 06SHgRqb005947;
        Tue, 28 Jul 2020 10:42:28 -0700
Date:   Tue, 28 Jul 2020 23:12:27 +0530
From:   Krishnamraju Eraparaju <krishna2@chelsio.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        bharat@chelsio.com
Subject: Re: Hang at NVME Host caused by Controller reset
Message-ID: <20200728174224.GA5497@chelsio.com>
References: <20200727181944.GA5484@chelsio.com>
 <9b8dae53-1fcc-3c03-5fcd-cfb55cd8cc80@grimberg.me>
 <20200728115904.GA5508@chelsio.com>
 <4d87ffbb-24a2-9342-4507-cabd9e3b76c2@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d87ffbb-24a2-9342-4507-cabd9e3b76c2@grimberg.me>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



Sagi,

Yes, Multipath is disabled.
This time, with "nvme-fabrics: allow to queue requests for live queues"
patch applied, I see hang only at blk_queue_enter():
[Jul28 17:25] INFO: task nvme:21119 blocked for more than 122 seconds.
[  +0.000061]       Not tainted 5.8.0-rc7ekr+ #2
[  +0.000052] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  +0.000059] nvme            D14392 21119   2456 0x00004000
[  +0.000059] Call Trace:
[  +0.000110]  __schedule+0x32b/0x670
[  +0.000108]  schedule+0x45/0xb0
[  +0.000107]  blk_queue_enter+0x1e9/0x250
[  +0.000109]  ? wait_woken+0x70/0x70
[  +0.000110]  blk_mq_alloc_request+0x53/0xc0
[  +0.000111]  nvme_alloc_request+0x61/0x70 [nvme_core]
[  +0.000121]  nvme_submit_user_cmd+0x50/0x310 [nvme_core]
[  +0.000118]  nvme_user_cmd+0x12e/0x1c0 [nvme_core]
[  +0.000163]  ? _copy_to_user+0x22/0x30
[  +0.000113]  blkdev_ioctl+0x100/0x250
[  +0.000115]  block_ioctl+0x34/0x40
[  +0.000110]  ksys_ioctl+0x82/0xc0
[  +0.000109]  __x64_sys_ioctl+0x11/0x20
[  +0.000109]  do_syscall_64+0x3e/0x70
[  +0.000120]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  +0.000112] RIP: 0033:0x7fbe9cdbb67b
[  +0.000110] Code: Bad RIP value.
[  +0.000124] RSP: 002b:00007ffd61ff5778 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[  +0.000170] RAX: ffffffffffffffda RBX: 0000000000000003 RCX:
00007fbe9cdbb67b
[  +0.000114] RDX: 00007ffd61ff5780 RSI: 00000000c0484e43 RDI:
0000000000000003
[  +0.000113] RBP: 0000000000000000 R08: 0000000000000001 R09:
0000000000000000
[  +0.000115] R10: 0000000000000000 R11: 0000000000000246 R12:
00007ffd61ff7219
[  +0.000123] R13: 0000000000000006 R14: 00007ffd61ff5e30 R15:
000055e09c1854a0
[  +0.000115] Kernel panic - not syncing: hung_task: blocked tasks

You could easily reproduce this by running below, parallelly, for 10min:
 while [ 1 ]; do  nvme write-zeroes /dev/nvme0n1 -s 1 -c 1; done
 while [ 1 ]; do echo 1 > /sys/block/nvme0n1/device/reset_controller;
done
 while [ 1 ]; do ifconfig enp2s0f4 down; sleep 24; ifconfig enp2s0f4 up;
sleep 28; done
 
 Not sure using nvme-write this way is valid or not..
 
 Thanks,
 Krishna.
On Tuesday, July 07/28/20, 2020 at 08:54:18 -0700, Sagi Grimberg wrote:
> 
> 
> On 7/28/20 4:59 AM, Krishnamraju Eraparaju wrote:
> >Sagi,
> >With the given patch, I am no more seeing the freeze_queue_wait hang
> >issue, but I am seeing another hang issue:
> 
> The trace suggest that you are not running with multipath right?
> 
> I think you need the patch:
> [PATCH] nvme-fabrics: allow to queue requests for live queues
> 
> You can find it in linux-nvme
