Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 494F738253A
	for <lists+linux-rdma@lfdr.de>; Mon, 17 May 2021 09:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234308AbhEQHWj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Mon, 17 May 2021 03:22:39 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3708 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235246AbhEQHWb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 17 May 2021 03:22:31 -0400
Received: from dggems702-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fk9TY05Pjz16Qgb;
        Mon, 17 May 2021 15:18:25 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (7.185.36.21) by
 dggems702-chm.china.huawei.com (10.3.19.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 17 May 2021 15:21:09 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 17 May 2021 15:21:08 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.2176.012;
 Mon, 17 May 2021 15:21:08 +0800
From:   liweihang <liweihang@huawei.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH for-next 0/6] RDMA: Use refcount_t for reference counting
Thread-Topic: [PATCH for-next 0/6] RDMA: Use refcount_t for reference counting
Thread-Index: AQHXSGaCtckp0olnxEaAcLoGloXJ7A==
Date:   Mon, 17 May 2021 07:21:08 +0000
Message-ID: <cd1776c9f0674471a4a7029d15fe256a@huawei.com>
References: <1620958299-4869-1-git-send-email-liweihang@huawei.com>
 <YKDxcUnAux1KFyRq@unreal>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.100.165]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2021/5/16 18:18, Leon Romanovsky wrote:
> On Fri, May 14, 2021 at 10:11:33AM +0800, Weihang Li wrote:
>> There are some refcnt in type of atomic_t in RDMA subsystem, almost all of
>> them is wrote before the refcount_t is acheived in kernel. refcount_t is
>> better than integer for reference counting, it will WARN on
>> overflow/underflow and avoid use-after-free risks.
>>
>> Weihang Li (6):
>>   RDMA/core: Use refcount_t instead of atomic_t for reference counting
>>   RDMA/hns: Use refcount_t instead of atomic_t for reference counting
>>   RDMA/hns: Use refcount_t APIs for HEM
>>   RDMA/cxgb4: Use refcount_t instead of atomic_t for reference counting
>>   RDMA/i40iw: Use refcount_t instead of atomic_t for reference counting
>>   RDMA/ipoib: Use refcount_t instead of atomic_t for reference counting
> 
> This series causes to the following splat when restarting mlx4 or mlx5 drivers.
> 
> [  227.529930] ------------[ cut here ]------------
> [  227.530966] refcount_t: addition on 0; use-after-free.
> [  227.531890] WARNING: CPU: 1 PID: 579 at lib/refcount.c:25 refcount_warn_saturate+0xb4/0x130
> [  227.533427] Modules linked in: bonding nf_tables ipip tunnel4 geneve ip6_gre ip6_tunnel tunnel6 ip_gre gre mlx5_ib mlx5_core ptp pps_core rdma_ucm ib_uverbs ib_ipoib ib_umad openvswitch nsh xt_conntrack xt_MASQUERADE nf_conntrack_netlink nfnetlink xt_addrtype iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 br_netfilter rpcrdma ib_iser libiscsi scsi_transport_iscsi rdma_cm iw_cm ib_cm ib_core overlay fuse [last unloaded: ib_uverbs]
> [  227.539872] CPU: 1 PID: 579 Comm: kworker/u20:7 Not tainted 5.13.0-rc1_2021_05_14_02_56_31_ #1
> [  227.541458] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> [  227.543424] Workqueue: ipoib_wq ipoib_mcast_join_task [ib_ipoib]
> [  227.544497] RIP: 0010:refcount_warn_saturate+0xb4/0x130
> [  227.545515] Code: 5b c3 0f b6 1d 69 19 40 01 80 fb 01 0f 87 60 fd 52 00 83 e3 01 75 91 48 c7 c7 88 9a 57 82 c6 05 4d 19 40 01 01 e8 35 50 4e 00 <0f> 0b 5b c3 0f b6 1d 3f 19 40 01 80 fb 01 0f 87 70 fd 52 00 83 e3
> [  227.548723] RSP: 0018:ffff888133d23cb0 EFLAGS: 00010082
> [  227.549739] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff8882f58a78b8
> [  227.551077] RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: ffff8882f58a78b0
> [  227.552306] RBP: ffff888133d23d30 R08: ffffffff83b5fd40 R09: 0000000000000001
> [  227.553589] R10: 0000000000000001 R11: 746e756f63666572 R12: ffff88813e00c700
> [  227.554885] R13: ffff8881182a3720 R14: ffff88810d06f938 R15: ffff8881182a3600
> [  227.556104] FS:  0000000000000000(0000) GS:ffff8882f5880000(0000) knlGS:0000000000000000
> [  227.557594] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  227.558719] CR2: 000055fb4a2ee768 CR3: 000000010303e006 CR4: 0000000000370ea0
> [  227.559940] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  227.561223] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  227.562566] Call Trace:
> [  227.563088]  ib_sa_join_multicast+0x4ec/0x580 [ib_core]
> [  227.564059]  ipoib_mcast_join+0x16d/0x220 [ib_ipoib]
> [  227.564961]  ? ipoib_mcast_join+0x220/0x220 [ib_ipoib]
> [  227.565991]  ipoib_mcast_join_task+0x16e/0x320 [ib_ipoib]
> [  227.567014]  ? process_one_work+0x1d7/0x5b0
> [  227.567809]  process_one_work+0x25a/0x5b0
> [  227.568587]  worker_thread+0x4f/0x3e0
> [  227.569349]  ? process_one_work+0x5b0/0x5b0
> [  227.570210]  kthread+0x129/0x140
> [  227.570874]  ? __kthread_bind_mask+0x60/0x60
> [  227.571677]  ret_from_fork+0x1f/0x30
> [  227.572416] irq event stamp: 150582
> [  227.573190] hardirqs last  enabled at (150581): [<ffffffff81c4b337>] _raw_spin_unlock_irqrestore+0x47/0x50
> [  227.575046] hardirqs last disabled at (150582): [<ffffffff81c4b130>] _raw_spin_lock_irqsave+0x50/0x60
> [  227.576793] softirqs last  enabled at (150576): [<ffffffffa00bcbef>] ipoib_mcast_join_task+0xef/0x320 [ib_ipoib]
> [  227.578657] softirqs last disabled at (150574): [<ffffffffa00bcb9f>] ipoib_mcast_join_task+0x9f/0x320 [ib_ipoib]
> [  227.580416] ---[ end trace 52a055538498ac03 ]---
> 
> Thanks
> 

Hi Leon,

Thanks for the test, it seems that the problem is caused by the refcount of
mcast_group. I will reply to this email once I have made progress.

Weihang
