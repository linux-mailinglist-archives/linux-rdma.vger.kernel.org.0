Return-Path: <linux-rdma+bounces-13868-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 198E8BDD268
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Oct 2025 09:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B77D18821A7
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Oct 2025 07:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0C92F5A1B;
	Wed, 15 Oct 2025 07:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XO7krhKl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1B92940B;
	Wed, 15 Oct 2025 07:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760513821; cv=none; b=IrSvMdzXrdwGLpQ3iMR1w5lns8ICJnUVDjGx3me3aD5OgRIxrjNyvIt3uSRAIr4tgrsa9Bx+sfeS9iKu9gXOx1cXViqWwY3UmbIKCoCRSxxuHXltjAa8VXprhDxigXQQkpRjtzzFVG0o0UVn07Eyzsxh7Hw4NzRBSLRp2d0vvQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760513821; c=relaxed/simple;
	bh=xUYNs+rDV55cZJUwQNcLxF7+DrO0kTaAPeD0v695wBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ehn/9VyQB8irw/Qxa45PSnEijnKU+UV8t5c6Kg5gRjXgKILHDj0kmnlfll9dkL6nV1AGXl4a14auAwcXneVEf19BOIgZ7kihy87yooE72dVEDCdluaf0zSX2t6GBliNEn/A+cI69j2GoZ4CukzsgUc2sDfI5hUC3tGGelQWsZCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XO7krhKl; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760513820; x=1792049820;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xUYNs+rDV55cZJUwQNcLxF7+DrO0kTaAPeD0v695wBI=;
  b=XO7krhKlBAcJHLayKwR3t+wt1RAvpMa6cA/GGpihs+yqtqWtcdNZSvlO
   +nLlhm9MwVGeXfX9Od5RQaa6H3gG8DAA0RNcWExMCjDtdqf2WRHlmkTf+
   ilUs7oDlH8fBQS6Qj5hzi7D9OKkmYFdonQju4M/9U5Zwro1Z3bkau24zq
   0lK0ge02u8Ym7c4RLiahc4AX/vxM9qrndVVIqLtKifR5Qxm67PxCx5Hdv
   aTm+34xfdOgcsnJkYld+MinceGwU87DVpfhqQRqFvGK4U0FhbI3jt30Gw
   DtNB1grBCmhIRHO0D/A+d0M7obwIk8zM1Ydg6N7fTvcH+bW1qqWIPp0ai
   A==;
X-CSE-ConnectionGUID: 13MhDIx7RZic5M1jHsJ7tg==
X-CSE-MsgGUID: C4kNerV4SzyZYIt0BVmJgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="61889657"
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="61889657"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 00:36:59 -0700
X-CSE-ConnectionGUID: o2yvRHXPQMqY5Pbs7wtZsA==
X-CSE-MsgGUID: +KNKsOnZTsuxo2EtI9TzbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="205798776"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 00:36:56 -0700
Date: Wed, 15 Oct 2025 09:34:58 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Gal Pressman <gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>
Subject: Re: [PATCH net] net/mlx5e: psp, avoid 'accel' NULL pointer
 dereference
Message-ID: <aO9OohYxdN0JzWnL@mev-dev.igk.intel.com>
References: <1760511923-890650-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1760511923-890650-1-git-send-email-tariqt@nvidia.com>

On Wed, Oct 15, 2025 at 10:05:23AM +0300, Tariq Toukan wrote:
> From: Cosmin Ratiu <cratiu@nvidia.com>
> 
> The 'accel' parameter of mlx5e_txwqe_build_eseg_csum() and the similar
> 'state' parameter of mlx5e_accel_tx_ids_len() were NULL when called
> from mlx5i_sq_xmit() and were causing kernel panics from that context.
> 
> Fix that by passing in a local empty mlx5e_accel_tx_state variable, thus
> guaranteeing that 'accel' is never NULL. Also remove an unnecessary
> check from mlx5e_tx_wqe_inline_mode().
> 
> Fixes: e5a1861a298e ("net/mlx5e: Implement PSP Tx data path")
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en_tx.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
> index b7227afcb51d..2702b3885f06 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
> @@ -256,7 +256,7 @@ mlx5e_tx_wqe_inline_mode(struct mlx5e_txqsq *sq, struct sk_buff *skb,
>  	u8 mode;
>  
>  #ifdef CONFIG_MLX5_EN_TLS
> -	if (accel && accel->tls.tls_tisn)
> +	if (accel->tls.tls_tisn)
>  		return MLX5_INLINE_MODE_TCP_UDP;
>  #endif
>  
> @@ -982,6 +982,7 @@ void mlx5i_sq_xmit(struct mlx5e_txqsq *sq, struct sk_buff *skb,
>  	struct mlx5e_tx_attr attr;
>  	struct mlx5i_tx_wqe *wqe;
>  
> +	struct mlx5e_accel_tx_state accel = {};
>  	struct mlx5_wqe_datagram_seg *datagram;
>  	struct mlx5_wqe_ctrl_seg *cseg;
>  	struct mlx5_wqe_eth_seg  *eseg;
> @@ -992,7 +993,7 @@ void mlx5i_sq_xmit(struct mlx5e_txqsq *sq, struct sk_buff *skb,
>  	int num_dma;
>  	u16 pi;
>  
> -	mlx5e_sq_xmit_prepare(sq, skb, NULL, &attr);
> +	mlx5e_sq_xmit_prepare(sq, skb, &accel, &attr);
>  	mlx5i_sq_calc_wqe_attr(skb, &attr, &wqe_attr);
>  
>  	pi = mlx5e_txqsq_get_next_pi(sq, wqe_attr.num_wqebbs);
> @@ -1009,7 +1010,7 @@ void mlx5i_sq_xmit(struct mlx5e_txqsq *sq, struct sk_buff *skb,
>  
>  	mlx5i_txwqe_build_datagram(av, dqpn, dqkey, datagram);
>  
> -	mlx5e_txwqe_build_eseg_csum(sq, skb, NULL, eseg);
> +	mlx5e_txwqe_build_eseg_csum(sq, skb, &accel, eseg);
>  
>  	eseg->mss = attr.mss;

Looks good
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

>  
> 
> base-commit: 7f0fddd817ba6daebea1445ae9fab4b6d2294fa8
> -- 
> 2.31.1

