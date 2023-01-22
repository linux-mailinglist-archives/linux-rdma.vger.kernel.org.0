Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8DB676CF7
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Jan 2023 13:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjAVMoo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 22 Jan 2023 07:44:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjAVMon (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 22 Jan 2023 07:44:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183F81C307
        for <linux-rdma@vger.kernel.org>; Sun, 22 Jan 2023 04:44:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D4F14B80AC6
        for <linux-rdma@vger.kernel.org>; Sun, 22 Jan 2023 12:44:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10703C4339B;
        Sun, 22 Jan 2023 12:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674391479;
        bh=gq1+5tIyY3XniCLqf//F6nUX8CgeDcNp1xLzdXG4FN4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KkVZW91tcyc0i1kdy8E+WlMRL4FSntycVpSzKnzxnE5loxpPnGmiEvwwMPxr3u5ny
         osV0Rgbvlya/2vQWdyqHNfGq/3ftX4GrFG5fVcr2czTlfhSWpRG6yIuZGRLxMoelmp
         UqX+XVUTsBWqpcJjNU44xc1fzF6xo6Av5xb8yZGKTOIwEDOVTL1UnsajXEXNAOwdW3
         1EnTjNbHh5YwwEnRpLtx6NSROKh6hKWnACmRFc9n/2+rfgZz7ThGMIOc4WszkrnmvN
         37rRGLQIQAI+EJd3R6IRPfF+uef6NU61pbu12wu2TKh3N/+dSvdZV4W+57g1THHpbM
         5Zn1KtYbetLZA==
Date:   Sun, 22 Jan 2023 14:44:35 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Dragos Tatulea <dtatulea@nvidia.com>, linux-rdma@vger.kernel.org,
        Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH rdma-rc v1] IB/IPoIB: Fix legacy IPoIB due to wrong
 number of queues
Message-ID: <Y80vs3KQ1QfB+KBf@unreal>
References: <752143b0eef72a966662ce94526b1ceb5ba4bbb3.1674234106.git.leon@kernel.org>
 <Y8r/BUdb7XMxwVN+@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8r/BUdb7XMxwVN+@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jan 20, 2023 at 04:52:21PM -0400, Jason Gunthorpe wrote:
> On Fri, Jan 20, 2023 at 07:02:48PM +0200, Leon Romanovsky wrote:
> > From: Dragos Tatulea <dtatulea@nvidia.com>
> > 
> > The cited commit creates child PKEY interfaces over netlink will multiple
> > tx and rx queues, but some devices doesn't support more than 1 tx and 1 rx
> > queues. This causes to a crash when traffic is sent over the PKEY interface
> > due to the parent having a single queue but the child having multiple queues.
> > 
> > This patch inherits the real_num_tx/rx_queues from the parent netdev.
> > 
> > BUG: kernel NULL pointer dereference, address: 000000000000036b
> > PGD 0 P4D 0
> > Oops: 0000 [#1] SMP
> > CPU: 4 PID: 209665 Comm: python3 Not tainted 6.1.0_for_upstream_min_debug_2022_12_12_17_02 #1
> > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> > RIP: 0010:kmem_cache_alloc+0xcb/0x450
> > Code: ce 7e 49 8b 50 08 49 83 78 10 00 4d 8b 28 0f 84 cb 02 00 00 4d 85 ed 0f 84 c2 02 00 00 41 8b 44 24 28 48 8d 4a 01 49 8b 3c 24 <49> 8b 5c 05 00 4c 89 e8 65 48 0f c7 0f 0f 94 c0 84 c0 74 b8 41 8b
> > RSP: 0018:ffff88822acbbab8 EFLAGS: 00010202
> > RAX: 0000000000000070 RBX: ffff8881c28e3e00 RCX: 00000000064f8dae
> > RDX: 00000000064f8dad RSI: 0000000000000a20 RDI: 0000000000030d00
> > RBP: 0000000000000a20 R08: ffff8882f5d30d00 R09: ffff888104032f40
> > R10: ffff88810fade828 R11: 736f6d6570736575 R12: ffff88810081c000
> > R13: 00000000000002fb R14: ffffffff817fc865 R15: 0000000000000000
> > FS:  00007f9324ff9700(0000) GS:ffff8882f5d00000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 000000000000036b CR3: 00000001125af004 CR4: 0000000000370ea0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  <TASK>
> >  skb_clone+0x55/0xd0
> >  ip6_finish_output2+0x3fe/0x690
> >  ip6_finish_output+0xfa/0x310
> >  ip6_send_skb+0x1e/0x60
> >  udp_v6_send_skb+0x1e5/0x420
> >  udpv6_sendmsg+0xb3c/0xe60
> >  ? ip_mc_finish_output+0x180/0x180
> >  ? __switch_to_asm+0x3a/0x60
> >  ? __switch_to_asm+0x34/0x60
> >  sock_sendmsg+0x33/0x40
> >  __sys_sendto+0x103/0x160
> >  ? _copy_to_user+0x21/0x30
> >  ? kvm_clock_get_cycles+0xd/0x10
> >  ? ktime_get_ts64+0x49/0xe0
> >  __x64_sys_sendto+0x25/0x30
> >  do_syscall_64+0x3d/0x90
> >  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> > RIP: 0033:0x7f9374f1ed14
> > Code: 42 41 f8 ff 44 8b 4c 24 2c 4c 8b 44 24 20 89 c5 44 8b 54 24 28 48 8b 54 24 18 b8 2c 00 00 00 48 8b 74 24 10 8b 7c 24 08 0f 05 <48> 3d 00 f0 ff ff 77 34 89 ef 48 89 44 24 08 e8 68 41 f8 ff 48 8b
> > RSP: 002b:00007f9324ff7bd0 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
> > RAX: ffffffffffffffda RBX: 00007f9324ff7cc8 RCX: 00007f9374f1ed14
> > RDX: 00000000000002fb RSI: 00007f93000052f0 RDI: 0000000000000030
> > RBP: 0000000000000000 R08: 00007f9324ff7d40 R09: 000000000000001c
> > R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
> > R13: 000000012a05f200 R14: 0000000000000001 R15: 00007f9374d57bdc
> >  </TASK>
> > 
> > Fixes: dbc94a0fb817 ("IB/IPoIB: Fix queue count inconsistency for PKEY child interfaces")
> > Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> > Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> > Changelog:
> > v1:
> >  * Fixed typo in warning print.
> > v0: https://lore.kernel.org/all/4a7ecec08ee30ad8004019818fadf1e58057e945.1674137153.git.leon@kernel.org
> > ---
> >  drivers/infiniband/ulp/ipoib/ipoib_netlink.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/drivers/infiniband/ulp/ipoib/ipoib_netlink.c b/drivers/infiniband/ulp/ipoib/ipoib_netlink.c
> > index 9ad8d9856275..0548735a15b5 100644
> > --- a/drivers/infiniband/ulp/ipoib/ipoib_netlink.c
> > +++ b/drivers/infiniband/ulp/ipoib/ipoib_netlink.c
> > @@ -126,6 +126,18 @@ static int ipoib_new_child_link(struct net *src_net, struct net_device *dev,
> >  	} else
> >  		child_pkey  = nla_get_u16(data[IFLA_IPOIB_PKEY]);
> >  
> > +	err = netif_set_real_num_tx_queues(dev, pdev->real_num_tx_queues);
> > +	if (err) {
> > +		ipoib_warn(ppriv, "failed setting the child tx queue count based on parent\n");
> > +		return err;
> > +	}
> > +
> > +	err = netif_set_real_num_rx_queues(dev, pdev->real_num_rx_queues);
> > +	if (err) {
> > +		ipoib_warn(ppriv, "failed setting the child rx queue count based on parent\n");
> > +		return err;
> > +	}
> 
> This still seems flawed.. Netlink does this:
> 
> 	unsigned int num_rx_queues = 1;
> 
> 	if (tb[IFLA_NUM_RX_QUEUES])
> 		num_rx_queues = nla_get_u32(tb[IFLA_NUM_RX_QUEUES]);
> 	else if (ops->get_num_rx_queues)
> 		num_rx_queues = ops->get_num_rx_queues();
> 
> So num_rx_queues can really be any value that userspaces cares to
> provide.
> 
> If pdev->real_num_rx_queues is > the user provided value then
> netif_set_real_num_rx_queues() just fails.
> 
> So at a minimum this should min the actual number of queues requested
> against the maximum number of queues the driver can provide and use
> that to set the real queues.
> 
> And the return of a really big number from ops->get_num_rx_queues is
> pretty ugly too, ideally that would be fixed to pass in some function
> arguments and obtain the ppriv so it can return the actual maximum
> number of queues and we don't waste a bunch of memory..

.get_num_rx_queues() is declared as void, so it can't have any complex
logic except returns some global define.

Thanks

> 
> Jason
