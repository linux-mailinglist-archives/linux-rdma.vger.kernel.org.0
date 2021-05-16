Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67C4F381DD5
	for <lists+linux-rdma@lfdr.de>; Sun, 16 May 2021 12:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229465AbhEPKTo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 16 May 2021 06:19:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:37196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229437AbhEPKTn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 16 May 2021 06:19:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 94BEF61182;
        Sun, 16 May 2021 10:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621160309;
        bh=C86kXkfhqvW8bsPL1jIidirohlnXi6z8219f0/5r6ec=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SgsyI/xlIrphWV1t8vocbMG8h0rgfj1Gll75od8Y093MdY+ZQ9XwmF8iBp++UhkPi
         Ny5bV9cAX4gM6adnlotLeaUCIcLVrS9SXosqsSMH1SDIbDYwLWt79w0oKnoJSpbUdP
         msKBhumM+zqU3ikkIeEhguV6uOsp8qmxR7x7/VXlpULf4YwRd0ktOLIwjcdJzc9ioe
         rao7+MbIYfM0iSpQJwbh2SI89YX08FVXvl6rEa4wOp4+O+QUtX0uopeIwxtpYT/jCm
         iAm/8JSLEeDOW1nQFmDHMpiu509osdOABiqECQnWbP7uIJo0HrLCUFDTVQJ7l6ze/a
         evHT7B7pULFRg==
Date:   Sun, 16 May 2021 13:18:25 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, jgg@nvidia.com, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next 0/6] RDMA: Use refcount_t for reference counting
Message-ID: <YKDxcUnAux1KFyRq@unreal>
References: <1620958299-4869-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1620958299-4869-1-git-send-email-liweihang@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 14, 2021 at 10:11:33AM +0800, Weihang Li wrote:
> There are some refcnt in type of atomic_t in RDMA subsystem, almost all of
> them is wrote before the refcount_t is acheived in kernel. refcount_t is
> better than integer for reference counting, it will WARN on
> overflow/underflow and avoid use-after-free risks.
> 
> Weihang Li (6):
>   RDMA/core: Use refcount_t instead of atomic_t for reference counting
>   RDMA/hns: Use refcount_t instead of atomic_t for reference counting
>   RDMA/hns: Use refcount_t APIs for HEM
>   RDMA/cxgb4: Use refcount_t instead of atomic_t for reference counting
>   RDMA/i40iw: Use refcount_t instead of atomic_t for reference counting
>   RDMA/ipoib: Use refcount_t instead of atomic_t for reference counting

This series causes to the following splat when restarting mlx4 or mlx5 drivers.

[  227.529930] ------------[ cut here ]------------
[  227.530966] refcount_t: addition on 0; use-after-free.
[  227.531890] WARNING: CPU: 1 PID: 579 at lib/refcount.c:25 refcount_warn_saturate+0xb4/0x130
[  227.533427] Modules linked in: bonding nf_tables ipip tunnel4 geneve ip6_gre ip6_tunnel tunnel6 ip_gre gre mlx5_ib mlx5_core ptp pps_core rdma_ucm ib_uverbs ib_ipoib ib_umad openvswitch nsh xt_conntrack xt_MASQUERADE nf_conntrack_netlink nfnetlink xt_addrtype iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 br_netfilter rpcrdma ib_iser libiscsi scsi_transport_iscsi rdma_cm iw_cm ib_cm ib_core overlay fuse [last unloaded: ib_uverbs]
[  227.539872] CPU: 1 PID: 579 Comm: kworker/u20:7 Not tainted 5.13.0-rc1_2021_05_14_02_56_31_ #1
[  227.541458] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
[  227.543424] Workqueue: ipoib_wq ipoib_mcast_join_task [ib_ipoib]
[  227.544497] RIP: 0010:refcount_warn_saturate+0xb4/0x130
[  227.545515] Code: 5b c3 0f b6 1d 69 19 40 01 80 fb 01 0f 87 60 fd 52 00 83 e3 01 75 91 48 c7 c7 88 9a 57 82 c6 05 4d 19 40 01 01 e8 35 50 4e 00 <0f> 0b 5b c3 0f b6 1d 3f 19 40 01 80 fb 01 0f 87 70 fd 52 00 83 e3
[  227.548723] RSP: 0018:ffff888133d23cb0 EFLAGS: 00010082
[  227.549739] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff8882f58a78b8
[  227.551077] RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: ffff8882f58a78b0
[  227.552306] RBP: ffff888133d23d30 R08: ffffffff83b5fd40 R09: 0000000000000001
[  227.553589] R10: 0000000000000001 R11: 746e756f63666572 R12: ffff88813e00c700
[  227.554885] R13: ffff8881182a3720 R14: ffff88810d06f938 R15: ffff8881182a3600
[  227.556104] FS:  0000000000000000(0000) GS:ffff8882f5880000(0000) knlGS:0000000000000000
[  227.557594] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  227.558719] CR2: 000055fb4a2ee768 CR3: 000000010303e006 CR4: 0000000000370ea0
[  227.559940] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  227.561223] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  227.562566] Call Trace:
[  227.563088]  ib_sa_join_multicast+0x4ec/0x580 [ib_core]
[  227.564059]  ipoib_mcast_join+0x16d/0x220 [ib_ipoib]
[  227.564961]  ? ipoib_mcast_join+0x220/0x220 [ib_ipoib]
[  227.565991]  ipoib_mcast_join_task+0x16e/0x320 [ib_ipoib]
[  227.567014]  ? process_one_work+0x1d7/0x5b0
[  227.567809]  process_one_work+0x25a/0x5b0
[  227.568587]  worker_thread+0x4f/0x3e0
[  227.569349]  ? process_one_work+0x5b0/0x5b0
[  227.570210]  kthread+0x129/0x140
[  227.570874]  ? __kthread_bind_mask+0x60/0x60
[  227.571677]  ret_from_fork+0x1f/0x30
[  227.572416] irq event stamp: 150582
[  227.573190] hardirqs last  enabled at (150581): [<ffffffff81c4b337>] _raw_spin_unlock_irqrestore+0x47/0x50
[  227.575046] hardirqs last disabled at (150582): [<ffffffff81c4b130>] _raw_spin_lock_irqsave+0x50/0x60
[  227.576793] softirqs last  enabled at (150576): [<ffffffffa00bcbef>] ipoib_mcast_join_task+0xef/0x320 [ib_ipoib]
[  227.578657] softirqs last disabled at (150574): [<ffffffffa00bcb9f>] ipoib_mcast_join_task+0x9f/0x320 [ib_ipoib]
[  227.580416] ---[ end trace 52a055538498ac03 ]---

Thanks
