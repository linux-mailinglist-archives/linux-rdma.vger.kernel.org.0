Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1673A8425F
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Aug 2019 04:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbfHGCVV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Aug 2019 22:21:21 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:52294 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728772AbfHGCVU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 6 Aug 2019 22:21:20 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 87072C7BC258933B7C0F;
        Wed,  7 Aug 2019 10:21:19 +0800 (CST)
Received: from [127.0.0.1] (10.133.205.88) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Wed, 7 Aug 2019
 10:21:11 +0800
To:     <bvanassche@acm.org>, <dledford@redhat.com>, <jgg@mellanox.com>
CC:     <linux-rdma@vger.kernel.org>, <target-devel@vger.kernel.org>,
        <yebiaoxiang@huawei.com>, Xiexiangyou <xiexiangyou@huawei.com>
From:   Jiangyiwen <jiangyiwen@huawei.com>
Subject: [bug report] rdma: rtnl_lock deadlock?
Message-ID: <5D4A3597.5020406@huawei.com>
Date:   Wed, 7 Aug 2019 10:21:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.205.88]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello,

I find a scenario may cause deadlock of rtnl_lock as follows:

1. CPU1 add rtnl_lock and wait kworker finished.
CPU1 add rtnl_lock before call unregister_netdevice_queue() and
then wait sport->work(function srpt_refresh_port_work) finished
in srpt_remove_one().

[<0>] __switch_to+0x94/0xe8
[<0>] __flush_work+0x128/0x280
[<0>] __cancel_work_timer+0x13c/0x1b0
[<0>] cancel_work_sync+0x24/0x30
[<0>] srpt_remove_one+0xf0/0x530 [ib_srpt]
[<0>] ib_unregister_device+0x124/0x230 [ib_core]
[<0>] rxe_unregister_device+0x30/0x40 [rdma_rxe]
[<0>] rxe_remove+0x20/0x50 [rdma_rxe]
[<0>] rxe_notify+0xe8/0x150 [rdma_rxe]
[<0>] notifier_call_chain+0x5c/0xa0
[<0>] raw_notifier_call_chain+0x3c/0x50
[<0>] call_netdevice_notifiers_info+0x3c/0x80
[<0>] rollback_registered_many+0x35c/0x568
[<0>] rollback_registered+0x68/0xb0
[<0>] unregister_netdevice_queue+0xc0/0x110
[<0>] __tun_detach+0x25c/0x2a0 [tun]
[<0>] tun_chr_close+0x30/0x60 [tun]
[<0>] __fput+0xa4/0x1e0
[<0>] ____fput+0x20/0x30
[<0>] task_work_run+0xc0/0xf8
[<0>] do_notify_resume+0x12c/0x138
[<0>] work_pending+0x8/0x10
[<0>] 0xffffffffffffffff

2. CPU2 run sport->work and wait for rxe->usdev_lock.
CPU2 run work(sport->work function: srpt_refresh_port_work) and
wait for rxe->usdev_lock in rxe_query_port().

[<0>] __switch_to+0x94/0xe8
[<0>] rxe_query_port+0x6c/0xd0 [rdma_rxe]
[<0>] ib_query_port+0x84/0x120 [ib_core]
[<0>] srpt_refresh_port+0xa4/0x1b8 [ib_srpt]
[<0>] srpt_refresh_port_work+0x20/0x30 [ib_srpt]
[<0>] process_one_work+0x1b4/0x3f8
[<0>] worker_thread+0x54/0x470
[<0>] kthread+0x134/0x138
[<0>] ret_from_fork+0x10/0x18
[<0>] 0xffffffffffffffff

3. CPU3 add rxe->usdev_lock and wait for rtnl_lock.
CPU3 run ib_cache_task work and add rxe->usdev_lock, then wait for
rtnl_lock is unlocked.

[<0>] __switch_to+0x94/0xe8
[<0>] rtnl_lock+0x1c/0x28
[<0>] ib_get_eth_speed+0x78/0x1c0 [ib_core]
[<0>] rxe_query_port+0x80/0xd0 [rdma_rxe]
[<0>] ib_query_port+0x84/0x120 [ib_core]
[<0>] ib_cache_update.part.7+0x74/0x388 [ib_core]
[<0>] ib_cache_task+0x68/0x80 [ib_core]
[<0>] process_one_work+0x1b4/0x3f8
[<0>] worker_thread+0x54/0x470
[<0>] kthread+0x134/0x138
[<0>] ret_from_fork+0x10/0x18
[<0>] 0xffffffffffffffff

So, deadlock is produced, that is, CPU1 wait for CPU2 work is
finished, CPU2 wait for CPU3 unlock rxe->usdev_lock, CPU3 wait
for CPU1 unlock rtnl_lock.

I don't know how to solve it.

Thanks,
Yiwen.

