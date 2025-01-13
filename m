Return-Path: <linux-rdma+bounces-6991-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6FFA0C1BD
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jan 2025 20:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5A6F7A376A
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jan 2025 19:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEA81C549F;
	Mon, 13 Jan 2025 19:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sLblRrrz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9935B1BD504
	for <linux-rdma@vger.kernel.org>; Mon, 13 Jan 2025 19:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736797576; cv=none; b=RNoYKSB3MLxBB0DnTOgclTVAJEHCS8hic9iZuospwWjBsLeRq5r32ii8seyu6QHOnwfldKH4H5ToWlRMN4Ur9hvafIE8RBzRK1V9LWOma0y83Dz0O0gWJPB++ip7IjBr6XJMlUNzeSjbc3Kcn5XPHW9s2hQ0wYML47pMJ1MempY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736797576; c=relaxed/simple;
	bh=JVHkaoDsVuZIg3QCf/N2LfE3VmU7gjeiAKPnGouztD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SPxPKADW9uSGyFSsalXC89RCs8hvU8mSmpxBzZOFvY90/b/MMrfzJ+7Yc3bGAbIQjYvDEuE9H77PTY3cp047m1vLE2bBCHevMFLyfswIzxdY4qb/aYcMvP1uGfoYx5XfQDCb0rzX4N6i1sJDtrlqnwhKZKqhLfqkyc56v3neDxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sLblRrrz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23DC5C4CED6;
	Mon, 13 Jan 2025 19:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736797576;
	bh=JVHkaoDsVuZIg3QCf/N2LfE3VmU7gjeiAKPnGouztD8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sLblRrrzM6xhNl3D4mQBkDA1xIpK8Hg5Ao+2XiHhwrdsI4SmrsyYt1C6TTKgp/hKp
	 fbgO0ao0mv+H7CaME2rQkL0q6J5LnlPOvtqCpyTqZljjQiFEmJ76XpXHbyUv1Ye79D
	 P68Sm5CaudHKaea20JLim17X2UhqrIwQQnT7bftQHVLtM8YVNxbKRk211gFjVcmbPo
	 4oyRbyfscAP4ghiZrZuFvliW0APQ1jPp880O2XOtTfTuGu7chF4JzEU3pmSlonLChE
	 Vxc7dYFva4T2A2DxATOxkFr9N7G++IHloI9FQsar0n85PlHqRQTjGrMvlAqv5YHpez
	 yvurPvBH0NFmw==
Date: Mon, 13 Jan 2025 21:46:08 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Patrisious Haddad <phaddad@nvidia.com>,
	Artemy Kovalyov <artemyko@mellanox.com>, linux-rdma@vger.kernel.org,
	Michael Guralnik <michaelgur@nvidia.com>
Subject: Re: [PATCH rdma-next] RDMA/mlx5: Fix implicit ODP use after free
Message-ID: <20250113194608.GD3146852@unreal>
References: <84ecb15d9f251dd760377e53da0de9eb385ea65c.1736251907.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84ecb15d9f251dd760377e53da0de9eb385ea65c.1736251907.git.leon@kernel.org>

On Tue, Jan 07, 2025 at 02:12:53PM +0200, Leon Romanovsky wrote:
> From: Patrisious Haddad <phaddad@nvidia.com>
> 
> Prevent double queueing of implicit ODP mr destroy work by adding a bit
> to the MR indicating if this MR is already queued for destruction.
> 
> Without this bit, we could try to invalidate this mr twice, which in
> turn could result in queuing a MR work destroy twice, and eventually the
> second work could execute after the MR was freed due to the first work,
> causing a user after free and trace below.
> 
> refcount_t: underflow; use-after-free.
> WARNING: CPU: 2 PID: 12178 at lib/refcount.c:28 refcount_warn_saturate+0x12b/0x130
> Modules linked in: bonding ib_ipoib vfio_pci ip_gre geneve nf_tables ip6_gre gre ip6_tunnel tunnel6 ipip tunnel4 ib_umad rdma_ucm mlx5_vfio_pci vfio_pci_core vfio_iommu_type1 mlx5_ib vfio ib_uverbs mlx5_core iptable_raw openvswitch nsh rpcrdma ib_iser libiscsi scsi_transport_iscsi rdma_cm iw_cm ib_cm ib_core xt_conntrack xt_MASQUERADE nf_conntrack_netlink nfnetlink xt_addrtype iptable_nat nf_nat br_netfilter rpcsec_gss_krb5 auth_rpcgss oid_registry overlay zram zsmalloc fuse [last unloaded: ib_uverbs]
> CPU: 2 PID: 12178 Comm: kworker/u20:5 Not tainted 6.5.0-rc1_net_next_mlx5_58c644e #1
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> Workqueue: events_unbound free_implicit_child_mr_work [mlx5_ib]
> RIP: 0010:refcount_warn_saturate+0x12b/0x130
> Code: 48 c7 c7 38 95 2a 82 c6 05 bc c6 fe 00 01 e8 0c 66 aa ff 0f 0b 5b c3 48 c7 c7 e0 94 2a 82 c6 05 a7 c6 fe 00 01 e8 f5 65 aa ff <0f> 0b 5b c3 90 8b 07 3d 00 00 00 c0 74 12 83 f8 01 74 13 8d 50 ff
> RSP: 0018:ffff8881008e3e40 EFLAGS: 00010286
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000027
> RDX: ffff88852c91b5c8 RSI: 0000000000000001 RDI: ffff88852c91b5c0
> RBP: ffff8881dacd4e00 R08: 00000000ffffffff R09: 0000000000000019
> R10: 000000000000072e R11: 0000000063666572 R12: ffff88812bfd9e00
> R13: ffff8881c792d200 R14: ffff88810011c005 R15: ffff8881002099c0
> FS:  0000000000000000(0000) GS:ffff88852c900000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f5694b5e000 CR3: 00000001153f6003 CR4: 0000000000370ea0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  ? __warn+0x79/0x120
>  ? refcount_warn_saturate+0x12b/0x130
>  ? report_bug+0x17c/0x190
>  ? handle_bug+0x3c/0x60
>  ? exc_invalid_op+0x14/0x70
>  ? asm_exc_invalid_op+0x16/0x20
>  ? refcount_warn_saturate+0x12b/0x130
>  free_implicit_child_mr_work+0x180/0x1b0 [mlx5_ib]
>  ? try_to_wake_up+0x5d/0x450
>  ? destroy_sched_domains_rcu+0x30/0x30
>  process_one_work+0x1cc/0x3c0
>  worker_thread+0x218/0x3c0
>  ? process_one_work+0x3c0/0x3c0
>  kthread+0xc6/0xf0
>  ? kthread_complete_and_exit+0x20/0x20
>  ret_from_fork+0x1f/0x30
>  </TASK>
> ---[ end trace 0000000000000000 ]---
> 
> Fixes: 5256edcb98a1 ("RDMA/mlx5: Rework implicit ODP destroy")
> Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
> Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/mlx5/mlx5_ib.h | 2 ++
>  drivers/infiniband/hw/mlx5/odp.c     | 4 ++++
>  2 files changed, 6 insertions(+)

I'm dropping this patch, need to rewrite it.

Thanks

