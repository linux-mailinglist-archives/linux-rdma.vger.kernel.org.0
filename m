Return-Path: <linux-rdma+bounces-8564-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CE7A5BA6F
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Mar 2025 09:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA4AC1890703
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Mar 2025 08:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF63224251;
	Tue, 11 Mar 2025 08:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eHZyNFsH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E602224226;
	Tue, 11 Mar 2025 08:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741680361; cv=none; b=gZCrTzSUffu+ETx/iXK4hbe4D/2WSNfmOlTIIzLpzC5FGgCqwtaOq9+iRLoIEjet2ZmCckYsPRDEqJ8gjAEKDPyczL9oHJ3XCMcjso2rR6oE8ybbqCkpe8DDTfAuxzGTNA4Vq8NvuCQReRxTuQ30MHu7y/yHBVq6SLXtDdC0ZRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741680361; c=relaxed/simple;
	bh=2/bfJ7AZhukFebD+t2CeRrmnDJGD9FS+5VQaBnSpmLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K3Mr/7UUmlXxodYpf8Dm36/9INW3F/D8+vhD8O30sDEgas0kd2CoD5Em1lRtaEYkMSYa4/g2zCOE6biSRTvrX7QbAnPtoh/dGZxAYUPFrT1Ywn+YyiyEGxtmJHDiXaUSCvKcGldyTZi1AHt6N2FXNHf9mEKsgtNqY4d+4R3liqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eHZyNFsH; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741680360; x=1773216360;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2/bfJ7AZhukFebD+t2CeRrmnDJGD9FS+5VQaBnSpmLE=;
  b=eHZyNFsH1bYQLT9dLEaRccFSAvg1jdyFF8CbgzjlB6M2wTr6gpIr3gDk
   r8hKK6r95R8Aa1KbqxdEEGQ9q5IfUi2FRmZZHFGmHmy3Lfoq/Cs7LR089
   2XY62woKyhWzFt3nKaax+KjujLFv193xHRERmGJz4gev1rN+rhZJt1Fuv
   5Cj169YvJNUUIuQk6Rs2XzvGCXBobwZ+uGywe3HRpRvxK9+ceroGBrMgX
   nRf1MGdAA7FyuwD2yZuAoS4aTDglbphyTqZ3vGvL8KgMlcvx9bXqa38F+
   qsOlb9KdgxpFolVdpIRAMQSirZCier1aP9VMHcMzR6oio6PIV2NwesxLd
   w==;
X-CSE-ConnectionGUID: t+DTi0NnSN6PPS6dHaQ95g==
X-CSE-MsgGUID: r6/HjLAxTnGWTnse7ykGwg==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="30278454"
X-IronPort-AV: E=Sophos;i="6.14,238,1736841600"; 
   d="scan'208";a="30278454"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 01:05:59 -0700
X-CSE-ConnectionGUID: fh+bWTq9S0yZQt8ATFqYAg==
X-CSE-MsgGUID: Uhy6Bgb7TH6PsaMv9VvGPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,238,1736841600"; 
   d="scan'208";a="120473826"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 01:05:55 -0700
Date: Tue, 11 Mar 2025 09:02:04 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Gal Pressman <gal@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jianbo Liu <jianbol@nvidia.com>
Subject: Re: [PATCH net 5/6] net/mlx5: Bridge, fix the crash caused by LAG
 state check
Message-ID: <Z8/t/LYlMWEwa+RL@mev-dev.igk.intel.com>
References: <1741644104-97767-1-git-send-email-tariqt@nvidia.com>
 <1741644104-97767-6-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1741644104-97767-6-git-send-email-tariqt@nvidia.com>

On Tue, Mar 11, 2025 at 12:01:43AM +0200, Tariq Toukan wrote:
> From: Jianbo Liu <jianbol@nvidia.com>
> 
> When removing LAG device from bridge, NETDEV_CHANGEUPPER event is
> triggered. Driver finds the lower devices (PFs) to flush all the
> offloaded entries. And mlx5_lag_is_shared_fdb is checked, it returns
> false if one of PF is unloaded. In such case,
> mlx5_esw_bridge_lag_rep_get() and its caller return NULL, instead of
> the alive PF, and the flush is skipped.
> 
> Besides, the bridge fdb entry's lastuse is updated in mlx5 bridge
> event handler. But this SWITCHDEV_FDB_ADD_TO_BRIDGE event can be
> ignored in this case because the upper interface for bond is deleted,
> and the entry will never be aged because lastuse is never updated.
> 
> To make things worse, as the entry is alive, mlx5 bridge workqueue
> keeps sending that event, which is then handled by kernel bridge
> notifier. It causes the following crash when accessing the passed bond
> netdev which is already destroyed.
> 
> To fix this issue, remove such checks. LAG state is already checked in
> commit 15f8f168952f ("net/mlx5: Bridge, verify LAG state when adding
> bond to bridge"), driver still need to skip offload if LAG becomes
> invalid state after initialization.
> 
>  Oops: stack segment: 0000 [#1] SMP
>  CPU: 3 UID: 0 PID: 23695 Comm: kworker/u40:3 Tainted: G           OE      6.11.0_mlnx #1
>  Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
>  Workqueue: mlx5_bridge_wq mlx5_esw_bridge_update_work [mlx5_core]
>  RIP: 0010:br_switchdev_event+0x2c/0x110 [bridge]
>  Code: 44 00 00 48 8b 02 48 f7 00 00 02 00 00 74 69 41 54 55 53 48 83 ec 08 48 8b a8 08 01 00 00 48 85 ed 74 4a 48 83 fe 02 48 89 d3 <4c> 8b 65 00 74 23 76 49 48 83 fe 05 74 7e 48 83 fe 06 75 2f 0f b7
>  RSP: 0018:ffffc900092cfda0 EFLAGS: 00010297
>  RAX: ffff888123bfe000 RBX: ffffc900092cfe08 RCX: 00000000ffffffff
>  RDX: ffffc900092cfe08 RSI: 0000000000000001 RDI: ffffffffa0c585f0
>  RBP: 6669746f6e690a30 R08: 0000000000000000 R09: ffff888123ae92c8
>  R10: 0000000000000000 R11: fefefefefefefeff R12: ffff888123ae9c60
>  R13: 0000000000000001 R14: ffffc900092cfe08 R15: 0000000000000000
>  FS:  0000000000000000(0000) GS:ffff88852c980000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 00007f15914c8734 CR3: 0000000002830005 CR4: 0000000000770ef0
>  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>  PKRU: 55555554
>  Call Trace:
>   <TASK>
>   ? __die_body+0x1a/0x60
>   ? die+0x38/0x60
>   ? do_trap+0x10b/0x120
>   ? do_error_trap+0x64/0xa0
>   ? exc_stack_segment+0x33/0x50
>   ? asm_exc_stack_segment+0x22/0x30
>   ? br_switchdev_event+0x2c/0x110 [bridge]
>   ? sched_balance_newidle.isra.149+0x248/0x390
>   notifier_call_chain+0x4b/0xa0
>   atomic_notifier_call_chain+0x16/0x20
>   mlx5_esw_bridge_update+0xec/0x170 [mlx5_core]
>   mlx5_esw_bridge_update_work+0x19/0x40 [mlx5_core]
>   process_scheduled_works+0x81/0x390
>   worker_thread+0x106/0x250
>   ? bh_worker+0x110/0x110
>   kthread+0xb7/0xe0
>   ? kthread_park+0x80/0x80
>   ret_from_fork+0x2d/0x50
>   ? kthread_park+0x80/0x80
>   ret_from_fork_asm+0x11/0x20
>   </TASK>
> 
> Fixes: ff9b7521468b ("net/mlx5: Bridge, support LAG")
> Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
> Reviewed-by: Vlad Buslov <vladbu@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  .../net/ethernet/mellanox/mlx5/core/en/rep/bridge.c  | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c
> index 5d128c5b4529..0f5d7ea8956f 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c
> @@ -48,15 +48,10 @@ mlx5_esw_bridge_lag_rep_get(struct net_device *dev, struct mlx5_eswitch *esw)
>  	struct list_head *iter;
>  
>  	netdev_for_each_lower_dev(dev, lower, iter) {
> -		struct mlx5_core_dev *mdev;
> -		struct mlx5e_priv *priv;
> -
>  		if (!mlx5e_eswitch_rep(lower))
>  			continue;
>  
> -		priv = netdev_priv(lower);
> -		mdev = priv->mdev;
> -		if (mlx5_lag_is_shared_fdb(mdev) && mlx5_esw_bridge_dev_same_esw(lower, esw))
> +		if (mlx5_esw_bridge_dev_same_esw(lower, esw))
>  			return lower;
>  	}
>  
> @@ -125,7 +120,7 @@ static bool mlx5_esw_bridge_is_local(struct net_device *dev, struct net_device *
>  	priv = netdev_priv(rep);
>  	mdev = priv->mdev;
>  	if (netif_is_lag_master(dev))
> -		return mlx5_lag_is_shared_fdb(mdev) && mlx5_lag_is_master(mdev);
> +		return mlx5_lag_is_master(mdev);
>  	return true;
>  }
>  
> @@ -455,6 +450,9 @@ static int mlx5_esw_bridge_switchdev_event(struct notifier_block *nb,
>  	if (!rep)
>  		return NOTIFY_DONE;
>  
> +	if (netif_is_lag_master(dev) && !mlx5_lag_is_shared_fdb(esw->dev))
> +		return NOTIFY_DONE;
> +
>  	switch (event) {
>  	case SWITCHDEV_FDB_ADD_TO_BRIDGE:
>  		fdb_info = container_of(info,

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

> -- 
> 2.31.1

