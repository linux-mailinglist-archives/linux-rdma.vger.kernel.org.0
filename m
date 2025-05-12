Return-Path: <linux-rdma+bounces-10305-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD72AB3DA1
	for <lists+linux-rdma@lfdr.de>; Mon, 12 May 2025 18:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F9B53ACF14
	for <lists+linux-rdma@lfdr.de>; Mon, 12 May 2025 16:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E79248F5C;
	Mon, 12 May 2025 16:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aKNMiSt3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1DD1D5178;
	Mon, 12 May 2025 16:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747067290; cv=none; b=a4EA+lxrNQSbrD7fmLXdHU9Q7r18fWrJEaMo1kuJZIHuVmG2DgDEyEO/vFmUdtLzmEswUXBDY4QtJD+sT3DCc2Wls3nndDHo2ZDBZcNedmZE4pUJg0cw33bFGwybMXtbkQgmQVMXpOGdMOO6rHT169Mp1RTeIVlFB21rbopHUFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747067290; c=relaxed/simple;
	bh=whCwiOckGFrT3Uz0c7zqJ8ew+kFLXqmZrNUj5XJHr28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cS1zVws8Id8xYN+MvRuKUHrM6Z4CYlfIZiVAz0WOUaGyFsBkPHy5wSRHpYP1dKIWhb3XpZUKin5v5UmVqnzcg1n2xI3e7rdfRXHSbK+bq2/n5gqq8kgefMntq8Xic7+ii8mAh3hkP7Wjjxq2KaRFGH1I0Mx5U3R5AxaZZE7Csoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aKNMiSt3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCADEC4CEE7;
	Mon, 12 May 2025 16:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747067289;
	bh=whCwiOckGFrT3Uz0c7zqJ8ew+kFLXqmZrNUj5XJHr28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aKNMiSt3JSgG6c21ECMPrpcOqxEucMKxFjRX6l3GG02w3FnrF4KdLpKVM8fZK2D3l
	 4riMbBkVwm51v9ekPOdKzgE6BH9MdwmbM+v9DzmRKybvyELCMpGKLaBNJCHezLS8Ly
	 wZHht66FraUobkXhDJFdPJpaxkDC9ado5+fL3C8aK5Qc5HuqwyR8inEocwBCmXmXqf
	 xBAaoLqZ6MjZgP5PA/ICRuVF1ttAmUtXcmjzKFQMOjAfEmPsHsSsrIDAXHkPJNXQEG
	 oFMRsRCSYkWGDqmEkd4C4kRIVZRdJQyk+Shq3Bm901KwTmPd7f648UuiIYo2+dFitI
	 6VE4f3osFWWYg==
Date: Mon, 12 May 2025 17:28:04 +0100
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Moshe Shemesh <moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Carolina Jubran <cjubran@nvidia.com>
Subject: Re: [PATCH net] net/mlx5e: Disable MACsec offload for uplink
 representor profile
Message-ID: <20250512162804.GR3339421@horms.kernel.org>
References: <1746958552-561295-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1746958552-561295-1-git-send-email-tariqt@nvidia.com>

On Sun, May 11, 2025 at 01:15:52PM +0300, Tariq Toukan wrote:
> From: Carolina Jubran <cjubran@nvidia.com>
> 
> MACsec offload is not supported in switchdev mode for uplink
> representors. When switching to the uplink representor profile, the
> MACsec offload feature must be cleared from the netdevice's features.
> 
> If left enabled, attempts to add offloads result in a null pointer
> dereference, as the uplink representor does not support MACsec offload
> even though the feature bit remains set.
> 
> Clear NETIF_F_HW_MACSEC in mlx5e_fix_uplink_rep_features().
> 
> Kernel log:
> 
> Oops: general protection fault, probably for non-canonical address 0xdffffc000000000f: 0000 [#1] SMP KASAN
> KASAN: null-ptr-deref in range [0x0000000000000078-0x000000000000007f]
> CPU: 29 UID: 0 PID: 4714 Comm: ip Not tainted 6.14.0-rc4_for_upstream_debug_2025_03_02_17_35 #1
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> RIP: 0010:__mutex_lock+0x128/0x1dd0
> Code: d0 7c 08 84 d2 0f 85 ad 15 00 00 8b 35 91 5c fe 03 85 f6 75 29 49 8d 7e 60 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 a6 15 00 00 4d 3b 76 60 0f 85 fd 0b 00 00 65 ff
> RSP: 0018:ffff888147a4f160 EFLAGS: 00010206
> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000001
> RDX: 000000000000000f RSI: 0000000000000000 RDI: 0000000000000078
> RBP: ffff888147a4f2e0 R08: ffffffffa05d2c19 R09: 0000000000000000
> R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
> R13: dffffc0000000000 R14: 0000000000000018 R15: ffff888152de0000
> FS:  00007f855e27d800(0000) GS:ffff88881ee80000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000004e5768 CR3: 000000013ae7c005 CR4: 0000000000372eb0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  ? die_addr+0x3d/0xa0
>  ? exc_general_protection+0x144/0x220
>  ? asm_exc_general_protection+0x22/0x30
>  ? mlx5e_macsec_add_secy+0xf9/0x700 [mlx5_core]
>  ? __mutex_lock+0x128/0x1dd0
>  ? lockdep_set_lock_cmp_fn+0x190/0x190
>  ? mlx5e_macsec_add_secy+0xf9/0x700 [mlx5_core]
>  ? mutex_lock_io_nested+0x1ae0/0x1ae0
>  ? lock_acquire+0x1c2/0x530
>  ? macsec_upd_offload+0x145/0x380
>  ? lockdep_hardirqs_on_prepare+0x400/0x400
>  ? kasan_save_stack+0x30/0x40
>  ? kasan_save_stack+0x20/0x40
>  ? kasan_save_track+0x10/0x30
>  ? __kasan_kmalloc+0x77/0x90
>  ? __kmalloc_noprof+0x249/0x6b0
>  ? genl_family_rcv_msg_attrs_parse.constprop.0+0xb5/0x240
>  ? mlx5e_macsec_add_secy+0xf9/0x700 [mlx5_core]
>  mlx5e_macsec_add_secy+0xf9/0x700 [mlx5_core]
>  ? mlx5e_macsec_add_rxsa+0x11a0/0x11a0 [mlx5_core]
>  macsec_update_offload+0x26c/0x820
>  ? macsec_set_mac_address+0x4b0/0x4b0
>  ? lockdep_hardirqs_on_prepare+0x284/0x400
>  ? _raw_spin_unlock_irqrestore+0x47/0x50
>  macsec_upd_offload+0x2c8/0x380
>  ? macsec_update_offload+0x820/0x820
>  ? __nla_parse+0x22/0x30
>  ? genl_family_rcv_msg_attrs_parse.constprop.0+0x15e/0x240
>  genl_family_rcv_msg_doit+0x1cc/0x2a0
>  ? genl_family_rcv_msg_attrs_parse.constprop.0+0x240/0x240
>  ? cap_capable+0xd4/0x330
>  genl_rcv_msg+0x3ea/0x670
>  ? genl_family_rcv_msg_dumpit+0x2a0/0x2a0
>  ? lockdep_set_lock_cmp_fn+0x190/0x190
>  ? macsec_update_offload+0x820/0x820
>  netlink_rcv_skb+0x12b/0x390
>  ? genl_family_rcv_msg_dumpit+0x2a0/0x2a0
>  ? netlink_ack+0xd80/0xd80
>  ? rwsem_down_read_slowpath+0xf90/0xf90
>  ? netlink_deliver_tap+0xcd/0xac0
>  ? netlink_deliver_tap+0x155/0xac0
>  ? _copy_from_iter+0x1bb/0x12c0
>  genl_rcv+0x24/0x40
>  netlink_unicast+0x440/0x700
>  ? netlink_attachskb+0x760/0x760
>  ? lock_acquire+0x1c2/0x530
>  ? __might_fault+0xbb/0x170
>  netlink_sendmsg+0x749/0xc10
>  ? netlink_unicast+0x700/0x700
>  ? __might_fault+0xbb/0x170
>  ? netlink_unicast+0x700/0x700
>  __sock_sendmsg+0xc5/0x190
>  ____sys_sendmsg+0x53f/0x760
>  ? import_iovec+0x7/0x10
>  ? kernel_sendmsg+0x30/0x30
>  ? __copy_msghdr+0x3c0/0x3c0
>  ? filter_irq_stacks+0x90/0x90
>  ? stack_depot_save_flags+0x28/0xa30
>  ___sys_sendmsg+0xeb/0x170
>  ? kasan_save_stack+0x30/0x40
>  ? copy_msghdr_from_user+0x110/0x110
>  ? do_syscall_64+0x6d/0x140
>  ? lock_acquire+0x1c2/0x530
>  ? __virt_addr_valid+0x116/0x3b0
>  ? __virt_addr_valid+0x1da/0x3b0
>  ? lock_downgrade+0x680/0x680
>  ? __delete_object+0x21/0x50
>  __sys_sendmsg+0xf7/0x180
>  ? __sys_sendmsg_sock+0x20/0x20
>  ? kmem_cache_free+0x14c/0x4e0
>  ? __x64_sys_close+0x78/0xd0
>  do_syscall_64+0x6d/0x140
>  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> RIP: 0033:0x7f855e113367
> Code: 0e 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b9 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 89 54 24 1c 48 89 74 24 10
> RSP: 002b:00007ffd15e90c88 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f855e113367
> RDX: 0000000000000000 RSI: 00007ffd15e90cf0 RDI: 0000000000000004
> RBP: 00007ffd15e90dbc R08: 0000000000000028 R09: 000000000045d100
> R10: 00007f855e011dd8 R11: 0000000000000246 R12: 0000000000000019
> R13: 0000000067c6b785 R14: 00000000004a1e80 R15: 0000000000000000
>  </TASK>
> Modules linked in: 8021q garp mrp sch_ingress openvswitch nsh mlx5_ib mlx5_fwctl mlx5_dpll mlx5_core rpcrdma rdma_ucm ib_iser libiscsi scsi_transport_iscsi ib_umad rdma_cm ib_ipoib iw_cm ib_cm ib_uverbs ib_core xt_conntrack xt_MASQUERADE nf_conntrack_netlink nfnetlink xt_addrtype iptable_nat nf_nat br_netfilter rpcsec_gss_krb5 auth_rpcgss oid_registry overlay zram zsmalloc fuse [last unloaded: mlx5_core]
> ---[ end trace 0000000000000000 ]---
> 
> Fixes: 8ff0ac5be144 ("net/mlx5: Add MACsec offload Tx command support")
> Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


