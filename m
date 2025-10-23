Return-Path: <linux-rdma+bounces-14021-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA67C01B9C
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Oct 2025 16:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E13DF50684A
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Oct 2025 14:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54030328B58;
	Thu, 23 Oct 2025 14:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Teu2Xa+6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09805318146;
	Thu, 23 Oct 2025 14:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761229056; cv=none; b=roQC7gFnDzs6ESATgYZI92mezvkANZbgyOxSUdRJMybcHVMhjVw8nfD4sVaSCSEZuaYrca2hbKv4KDQRSuvFk5yb4MzIJL4YyoXPva0ZdsosDMFVbOZmjqgUJexFJxMEQIBer7mPRPy6qjaVRfT9d8+miAk7j3jQGPWJa7NO1/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761229056; c=relaxed/simple;
	bh=5z2CwcrsfghWCt50FGQg1cggIkm7cb/zWiEmyg6elfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l51Rxnwpfaej0mW6d+Hcq7W14S6s+SwhiJ0hJI8Brj/YfhJquA8RRhlO8sgihGWixHPcxxhCbWirpvdql06PDMQ0qIFjgwtGSZ64OpDyJC7uuG83mkEmvmuNCPBBR4r/eXwGgH2aIB5Dz0JIkrOHhLl+IxVK7LrizVutFdsC6Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Teu2Xa+6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E390C4CEE7;
	Thu, 23 Oct 2025 14:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761229055;
	bh=5z2CwcrsfghWCt50FGQg1cggIkm7cb/zWiEmyg6elfQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Teu2Xa+6vZBzpTMntPbR5kZX0wapbccoOmRSn+z8mj6AXv+u2UUI3XKNHUTO61/fv
	 YKMfHnUiy60PRDLwhK1U8k7zSCSCVO0eAGyJP34thG0107GBVZTkhXlU2Xb092GFg3
	 YxpfHJK/PU1yN4s+JppPDtHq7RYte8GkzAoC6AGH9MK5cEbwImqwXURQa3rjmwh0AZ
	 Fv/3IJWAa3ToYlWwkL3SIFa0JB84DK6sBx4oCXYw98zNInkIBKfe8SKHutT+5uYIpa
	 kmKeyCg7axvavMKac3nae9CzebgtYJ4S/KiNVmoa4r8c44mI+/M96/YHKJ+DznUaFd
	 EJpGO6DVmpcXw==
Date: Thu, 23 Oct 2025 07:17:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
 <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, "Patrisious
 Haddad" <phaddad@nvidia.com>
Subject: Re: [PATCH net 4/4] net/mlx5: Fix IPsec cleanup over MPV device
Message-ID: <20251023071734.3f9233cb@kernel.org>
In-Reply-To: <1761136182-918470-5-git-send-email-tariqt@nvidia.com>
References: <1761136182-918470-1-git-send-email-tariqt@nvidia.com>
	<1761136182-918470-5-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Oct 2025 15:29:42 +0300 Tariq Toukan wrote:
> BUG: kernel NULL pointer dereference, address: 0000000000000010
> PGD 146427067 P4D 146427067 PUD 146488067 PMD 0
> Oops: Oops: 0000 [#1] SMP
> CPU: 1 UID: 0 PID: 7735 Comm: devlink Tainted: GW 6.12.0-rc6_for_upstream_min_debug_2024_11_08_00_46 #1
> Tainted: [W]=WARN
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> RIP: 0010:mlx5_devcom_comp_set_ready+0x5/0x40 [mlx5_core]
> Code: 00 01 48 83 05 23 32 1e 00 01 41 b8 ed ff ff ff e9 60 ff ff ff 48 83 05 00 32 1e 00 01 eb e3 66 0f 1f 44 00 00 0f 1f 44 00 00 <48> 8b 47 10 48 83 05 5f 32 1e 00 01 48 8b 50 40 48 85 d2 74 05 40
> RSP: 0018:ffff88811a5c35f8 EFLAGS: 00010206
> RAX: ffff888106e8ab80 RBX: ffff888107d7e200 RCX: ffff88810d6f0a00
> RDX: ffff88810d6f0a00 RSI: 0000000000000001 RDI: 0000000000000000
> RBP: ffff88811a17e620 R08: 0000000000000040 R09: 0000000000000000
> R10: ffff88811a5c3618 R11: 0000000de85d51bd R12: ffff88811a17e600
> R13: ffff88810d6f0a00 R14: 0000000000000000 R15: ffff8881034bda80
> FS:  00007f27bdf89180(0000) GS:ffff88852c880000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000010 CR3: 000000010f159005 CR4: 0000000000372eb0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  ? __die+0x20/0x60
>  ? page_fault_oops+0x150/0x3e0
>  ? exc_page_fault+0x74/0x130
>  ? asm_exc_page_fault+0x22/0x30
>  ? mlx5_devcom_comp_set_ready+0x5/0x40 [mlx5_core]
>  mlx5e_devcom_event_mpv+0x42/0x60 [mlx5_core]
>  mlx5_devcom_send_event+0x8c/0x170 [mlx5_core]
>  blocking_event+0x17b/0x230 [mlx5_core]
>  notifier_call_chain+0x35/0xa0
>  blocking_notifier_call_chain+0x3d/0x60
>  mlx5_blocking_notifier_call_chain+0x22/0x30 [mlx5_core]
>  mlx5_core_mp_event_replay+0x12/0x20 [mlx5_core]
>  mlx5_ib_bind_slave_port+0x228/0x2c0 [mlx5_ib]
>  mlx5_ib_stage_init_init+0x664/0x9d0 [mlx5_ib]
>  ? idr_alloc_cyclic+0x50/0xb0
>  ? __kmalloc_cache_noprof+0x167/0x340
>  ? __kmalloc_noprof+0x1a7/0x430
>  __mlx5_ib_add+0x34/0xd0 [mlx5_ib]
>  mlx5r_probe+0xe9/0x310 [mlx5_ib]
>  ? kernfs_add_one+0x107/0x150
>  ? __mlx5_ib_add+0xd0/0xd0 [mlx5_ib]
>  auxiliary_bus_probe+0x3e/0x90
>  really_probe+0xc5/0x3a0
>  ? driver_probe_device+0x90/0x90
>  __driver_probe_device+0x80/0x160
>  driver_probe_device+0x1e/0x90
>  __device_attach_driver+0x7d/0x100
>  bus_for_each_drv+0x80/0xd0
>  __device_attach+0xbc/0x1f0
>  bus_probe_device+0x86/0xa0
>  device_add+0x62d/0x830
>  __auxiliary_device_add+0x3b/0xa0
>  ? auxiliary_device_init+0x41/0x90
>  add_adev+0xd1/0x150 [mlx5_core]
>  mlx5_rescan_drivers_locked+0x21c/0x300 [mlx5_core]
>  esw_mode_change+0x6c/0xc0 [mlx5_core]
>  mlx5_devlink_eswitch_mode_set+0x21e/0x640 [mlx5_core]
>  devlink_nl_eswitch_set_doit+0x60/0xe0
>  genl_family_rcv_msg_doit+0xd0/0x120
>  genl_rcv_msg+0x180/0x2b0
>  ? devlink_get_from_attrs_lock+0x170/0x170
>  ? devlink_nl_eswitch_get_doit+0x290/0x290
>  ? devlink_nl_pre_doit_port_optional+0x50/0x50
>  ? genl_family_rcv_msg_dumpit+0xf0/0xf0
>  netlink_rcv_skb+0x54/0x100
>  genl_rcv+0x24/0x40
>  netlink_unicast+0x1fc/0x2d0
>  netlink_sendmsg+0x1e4/0x410
>  __sock_sendmsg+0x38/0x60
>  ? sockfd_lookup_light+0x12/0x60
>  __sys_sendto+0x105/0x160
>  ? __sys_recvmsg+0x4e/0x90
>  __x64_sys_sendto+0x20/0x30
>  do_syscall_64+0x4c/0x100
>  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> RIP: 0033:0x7f27bc91b13a
> Code: bb 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 8b 05 fa 96 2c 00 45 89 c9 4c 63 d1 48 63 ff 85 c0 75 15 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 76 f3 c3 0f 1f 40 00 41 55 41 54 4d 89 c5 55
> RSP: 002b:00007fff369557e8 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
> RAX: ffffffffffffffda RBX: 0000000009c54b10 RCX: 00007f27bc91b13a
> RDX: 0000000000000038 RSI: 0000000009c54b10 RDI: 0000000000000006
> RBP: 0000000009c54920 R08: 00007f27bd0030e0 R09: 000000000000000c
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000001
>  </TASK>
> Modules linked in: mlx5_vdpa vringh vhost_iotlb vdpa xt_MASQUERADE nf_conntrack_netlink nfnetlink iptable_nat xt_addrtype xt_conntrack nf_nat br_netfilter rpcsec_gss_krb5 auth_rpcgss oid_registry overlay rpcrdma rdma_ucm ib_iser libiscsi ib_umad scsi_transport_iscsi ib_ipoib rdma_cm iw_cm ib_cm mlx5_fwctl mlx5_ib ib_uverbs ib_core mlx5_core
> CR2: 0000000000000010

Please trim the crashes in the future.

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> index 41fd5eee6306..9c46511e7b43 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> @@ -266,6 +266,7 @@ static void mlx5e_devcom_cleanup_mpv(struct mlx5e_priv *priv)
>  	}
>  
>  	mlx5_devcom_unregister_component(priv->devcom);
> +	priv->devcom = NULL;
>  }

This feels a little like it should be in patch 3. 
But I guess the two are inextricably linked anyway :\

