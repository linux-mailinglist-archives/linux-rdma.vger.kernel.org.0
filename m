Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B795867D43F
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jan 2023 19:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjAZSfa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Jan 2023 13:35:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjAZSf3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Jan 2023 13:35:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE954901B
        for <linux-rdma@vger.kernel.org>; Thu, 26 Jan 2023 10:35:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71AAC618D3
        for <linux-rdma@vger.kernel.org>; Thu, 26 Jan 2023 18:35:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54CB6C433EF;
        Thu, 26 Jan 2023 18:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674758122;
        bh=Kt2FDvGr68OsVJXRwHYRA+o8MW8xb1YfkBvvCnITbNo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YUrj+Qf1pfdvh0y42icbFTe1eZ0oZNXixOvp3AX6TzxScu4vA5UzCoqLOn6Ab85d+
         yl52XCzCjeJRPZS1oSxYiGMG1I3GktCGbtoK6n3XKqlNXhAfz7uAXviV3VPINuFadq
         6Nx8uJllXdNAQxYdMWrRnvQNy0DSP/CydQSNPssgZuiP/lNTE9FA/mFH919iTW+4L1
         lZ2PBAinWpo+7rL1EVZTKy1hcd7u1QHYfQWPINcQA/ehCIZUsTOclA2OPReI2pjdOb
         JdEsxy+gwOAAOYQQignQz6iAKxkDTIM2KXg8cjjHg/Q/Eat+uI2FFB6FPdaGKuxwpr
         BCZB6P1EgfkVg==
Date:   Thu, 26 Jan 2023 20:35:18 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Dragos Tatulea <dtatulea@nvidia.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-rc v2] IB/IPoIB: Fix queue count for non-enhanced
 IPoIB over netlink
Message-ID: <Y9LH5kim0d5rBKOR@unreal>
References: <95eb6b74c7cf49fa46281f9d056d685c9fa11d38.1674584576.git.leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95eb6b74c7cf49fa46281f9d056d685c9fa11d38.1674584576.git.leon@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jan 24, 2023 at 08:24:18PM +0200, Leon Romanovsky wrote:
> From: Dragos Tatulea <dtatulea@nvidia.com>
> 
> Make sure that non-enhanced IPoIB queues are configured with only
> 1 tx and rx queues over netlink. This behavior is consistent with the
> sysfs child_create configuration.
> 
> The cited commit opened up the possibility for child PKEY interface
> to have multiple tx/rx queues. It is the driver's responsibility to
> re-adjust the queue count accordingly. This patch does exactly that:
> non-enhanced IPoIB supports only 1 tx and 1 rx queue.
> 
> Fixes: dbc94a0fb817 ("IB/IPoIB: Fix queue count inconsistency for PKEY child interfaces")
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Leon Romanovsky <leon@nvidia.coma
> ---
> Changelog:
> v2:
>  * Changed implementation
> v1: https://lore.kernel.org/all/752143b0eef72a966662ce94526b1ceb5ba4bbb3.1674234106.git.leon@kernel.org
>  * Fixed typo in warning print.
> v0: https://lore.kernel.org/all/4a7ecec08ee30ad8004019818fadf1e58057e945.1674137153.git.leon@kernel.org>
> ---
>  drivers/infiniband/ulp/ipoib/ipoib_main.c | 8 ++++++++
>  1 file changed, 8 insertions(+)


Dragos pointed to me that I sent commit with "old" commit message.
The right one is below and I'll fix it locally once will apply it.

Jason, are you happy with the patch?


IB/IPoIB: Fix legacy IPoIB due to wrong number of queues

The cited commit creates child PKEY interfaces over netlink will
multiple tx and rx queues, but some devices doesn't support more than 1
tx and 1 rx queues. This causes to a crash when traffic is sent over the
PKEY interface due to the parent having a single queue but the child
having multiple queues.

This patch fixes the number of queues to 1 for legacy IPoIB at the
earliest possible point in time.

BUG: kernel NULL pointer dereference, address: 000000000000036b
PGD 0 P4D 0
Oops: 0000 [#1] SMP
CPU: 4 PID: 209665 Comm: python3 Not tainted 6.1.0_for_upstream_min_debug_2022_12_12_17_02 #1
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
RIP: 0010:kmem_cache_alloc+0xcb/0x450
Code: ce 7e 49 8b 50 08 49 83 78 10 00 4d 8b 28 0f 84 cb 02 00 00 4d 85 ed 0f 84 c2 02 00 00 41 8b 44 24 28 48 8d 4a 01 49 8b 3c 24 <49> 8b 5c 05 00 4c 89 e8 65 48 0f c7 0f 0f 94 c0 84 c0 74 b8 41 8b
RSP: 0018:ffff88822acbbab8 EFLAGS: 00010202
RAX: 0000000000000070 RBX: ffff8881c28e3e00 RCX: 00000000064f8dae
RDX: 00000000064f8dad RSI: 0000000000000a20 RDI: 0000000000030d00
RBP: 0000000000000a20 R08: ffff8882f5d30d00 R09: ffff888104032f40
R10: ffff88810fade828 R11: 736f6d6570736575 R12: ffff88810081c000
R13: 00000000000002fb R14: ffffffff817fc865 R15: 0000000000000000
FS:  00007f9324ff9700(0000) GS:ffff8882f5d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000000036b CR3: 00000001125af004 CR4: 0000000000370ea0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 skb_clone+0x55/0xd0
 ip6_finish_output2+0x3fe/0x690
 ip6_finish_output+0xfa/0x310
 ip6_send_skb+0x1e/0x60
 udp_v6_send_skb+0x1e5/0x420
 udpv6_sendmsg+0xb3c/0xe60
 ? ip_mc_finish_output+0x180/0x180
 ? __switch_to_asm+0x3a/0x60
 ? __switch_to_asm+0x34/0x60
 sock_sendmsg+0x33/0x40
 __sys_sendto+0x103/0x160
 ? _copy_to_user+0x21/0x30
 ? kvm_clock_get_cycles+0xd/0x10
 ? ktime_get_ts64+0x49/0xe0
 __x64_sys_sendto+0x25/0x30
 do_syscall_64+0x3d/0x90
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7f9374f1ed14
Code: 42 41 f8 ff 44 8b 4c 24 2c 4c 8b 44 24 20 89 c5 44 8b 54 24 28 48 8b 54 24 18 b8 2c 00 00 00 48 8b 74 24 10 8b 7c 24 08 0f 05 <48> 3d 00 f0 ff ff 77 34 89 ef 48 89 44 24 08 e8 68 41 f8 ff 48 8b
RSP: 002b:00007f9324ff7bd0 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f9324ff7cc8 RCX: 00007f9374f1ed14
RDX: 00000000000002fb RSI: 00007f93000052f0 RDI: 0000000000000030
RBP: 0000000000000000 R08: 00007f9324ff7d40 R09: 000000000000001c
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 000000012a05f200 R14: 0000000000000001 R15: 00007f9374d57bdc
 </TASK>



> 
> diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
> index ac25fc80fb33..f10d4bcf87d2 100644
> --- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
> +++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
> @@ -2200,6 +2200,14 @@ int ipoib_intf_init(struct ib_device *hca, u32 port, const char *name,
>  		rn->attach_mcast = ipoib_mcast_attach;
>  		rn->detach_mcast = ipoib_mcast_detach;
>  		rn->hca = hca;
> +
> +		rc = netif_set_real_num_tx_queues(dev, 1);
> +		if (rc)
> +			goto out;
> +
> +		rc = netif_set_real_num_rx_queues(dev, 1);
> +		if (rc)
> +			goto out;
>  	}
>  
>  	priv->rn_ops = dev->netdev_ops;
> -- 
> 2.39.1
> 
