Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABCF23983E1
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Jun 2021 10:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbhFBIML (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Jun 2021 04:12:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:35874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229583AbhFBIML (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 2 Jun 2021 04:12:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5390F613AD;
        Wed,  2 Jun 2021 08:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622621429;
        bh=9L5ZQcdejwPAf2DWna6DMU2dS3zGf08/0+kjHLh4Lyo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SCz718cnt9XzbiwFER9cwbswcWHU6VBujFjv+7lR3iKTqiNfmf5yjnPVewdesH29f
         /ti3kDxLFmFmqe0N5uFOTc36kfUR5bYKkPhkp1ft6uCEqXFT559Al7kzPt6+UZCgU4
         KLXIS6PaEd2iC7X+8XvFMEdHHT9dQHv8CDv8naAN8rOEFpElhLqPMY4I6o62cE1o7u
         VcFUP2xGTySIAierTeP3YBdT3upfYpEqc+WbH+f3dZrMkXQn/bgkwetdeYfRlzaXA4
         M7h9rTXhcry+TEP9RZIIjCzUDXuHEF+8PkMS3eIjM3Zk+ZR+MjW8COH1E+VdkWprZ2
         fMk0qr1iI0hvA==
Date:   Wed, 2 Jun 2021 11:10:24 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH for-rc] RDMA/ipoib: Fix warning caused by destroying
 non-initial netns
Message-ID: <YLc88Btu3Q8QuTka@unreal>
References: <20210525150134.139342-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210525150134.139342-1-kamalheib1@gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 25, 2021 at 06:01:34PM +0300, Kamal Heib wrote:
> After the introduce of 5ce2dced8e95 ("RDMA/ipoib: Set rtnl_link_ops for
> ipoib interfaces"), If the IPoIB device is moved to non-initial netns,
> destroying that netns lets the device vanish instead of moving it back
> to the initial netns, This is happening because default_device_exit()
> skips the interfaces due to having rtnl_link_ops set.
> 
> Steps to reporoduce:
>   ip netns add foo
>   ip link set mlx5_ib0 netns foo
>   ip netns delete foo
> 
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 704 at net/core/dev.c:11435 netdev_exit+0x3f/0x50
> Modules linked in: xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT
> nf_reject_ipv4 nft_compat nft_counter nft_chain_nat nf_nat nf_conntrack
> nf_defrag_ipv6 nf_defrag_ipv4 nf_tables nfnetlink tun d
>  fuse
> CPU: 1 PID: 704 Comm: kworker/u64:3 Tainted: G S      W  5.13.0-rc1+ #1
> Hardware name: Dell Inc. PowerEdge R630/02C2CP, BIOS 2.1.5 04/11/2016
> Workqueue: netns cleanup_net
> RIP: 0010:netdev_exit+0x3f/0x50
> Code: 48 8b bb 30 01 00 00 e8 ef 81 b1 ff 48 81 fb c0 3a 54 a1 74 13 48
> 8b 83 90 00 00 00 48 81 c3 90 00 00 00 48 39 d8 75 02 5b c3 <0f> 0b 5b
> c3 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 0f 1f 44 00
> RSP: 0018:ffffb297079d7e08 EFLAGS: 00010206
> RAX: ffff8eb542c00040 RBX: ffff8eb541333150 RCX: 000000008010000d
> RDX: 000000008010000e RSI: 000000008010000d RDI: ffff8eb440042c00
> RBP: ffffb297079d7e48 R08: 0000000000000001 R09: ffffffff9fdeac00
> R10: ffff8eb5003be000 R11: 0000000000000001 R12: ffffffffa1545620
> R13: ffffffffa1545628 R14: 0000000000000000 R15: ffffffffa1543b20
> FS:  0000000000000000(0000) GS:ffff8ed37fa00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00005601b5f4c2e8 CR3: 0000001fc8c10002 CR4: 00000000003706e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  ops_exit_list.isra.9+0x36/0x70
>  cleanup_net+0x234/0x390
>  process_one_work+0x1cb/0x360
>  ? process_one_work+0x360/0x360
>  worker_thread+0x30/0x370
>  ? process_one_work+0x360/0x360
>  kthread+0x116/0x130
>  ? kthread_park+0x80/0x80
>  ret_from_fork+0x22/0x30
> ---[ end trace 74b40f8fbd65a323 ]---
> 
> To avoid the above warning and later on the kernel panic that could
> happen on shutdown due to a null pointer dereference, Make sure to set
> the netns_refund flag that was introduced by [1] to properly restore
> the IPoIB interfaces to the initial netns.
> 
> [1] - 3a5ca857079e ("can: dev: Move device back to init netns on owning
> netns delete").
> 
> Fixes: 5ce2dced8e95 ("RDMA/ipoib: Set rtnl_link_ops for ipoib interfaces")
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> ---
>  drivers/infiniband/ulp/ipoib/ipoib_netlink.c | 1 +
>  1 file changed, 1 insertion(+)

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
