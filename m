Return-Path: <linux-rdma+bounces-11762-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB821AEDA5C
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Jun 2025 12:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D2E73B819B
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Jun 2025 10:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEE6259CBF;
	Mon, 30 Jun 2025 10:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YDnEo+xN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22892475CD;
	Mon, 30 Jun 2025 10:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751281070; cv=none; b=CF5bdanhUbc1lVH+ABq5+MkfblnD9pZe/RNBzU5kLMMswI7m3tL8Hhv1cLnjcrLQAKdMOPfT9UbvmdW5KEFytvFf55j4NNhWaQ8w4wC3QKCQ0Z+imm+5AR+jTgHb4bTgZjJV6GzkmAhWfSWMXrf1dyhWXeUJ2W2+LmQnmBJ0nN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751281070; c=relaxed/simple;
	bh=pI+3L5f6Y52jlgObBsa0gHj4MZDRJ6PpUdxDZHGPRmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jIsuk8MVjeBuw84bU4/KTWHSZ15ysJ5db9Fe0Vjro/RnG8WK6Jqu1/cQjWKUMi2d0riWUukNKUDADxuaQTIata9hnzlhXhn4kEdoPuwu/Tax7g11AbByq+7Wod9CAbYkzybvc6dp2Z7Y3a+/VG69c+2HRaroPOpvDGELw+CVUt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YDnEo+xN; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751281069; x=1782817069;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pI+3L5f6Y52jlgObBsa0gHj4MZDRJ6PpUdxDZHGPRmM=;
  b=YDnEo+xNiC5G3+rSklvaWSmm8/ZGoODhVrg4S8ax1650Ngq37W6VkQdn
   ILYgaAZM+BSLUg/co3izoAaF2lary9SaGxo1lGxN1bHKgkM2yMpkhlAYc
   6U6zsfn1FcBIfynT4enkVjmqx43IqaXrME/NrfyBYkDCHO5axLGGIsBYR
   X1SXz3owobPYJzsD7iqLzrs1+uSQ1uJCH4qiw2hs3JPl/RL4LhaEdJg70
   1w640t1KvbofgJsnI5gkWazgknDdGpPujEZxrOfCs3w7iKn18O/Uz3igh
   Jcog0v0kVMnOoXqfbMp5erIVzzN8FyR7bfH1GmCHv6I8Sja9VH/twjdRy
   g==;
X-CSE-ConnectionGUID: +xpSJKsbQ3aZT4mUfDRl2g==
X-CSE-MsgGUID: ZGzTyMh9SIuezFq8qqngfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11479"; a="64197155"
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; 
   d="scan'208";a="64197155"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 03:57:48 -0700
X-CSE-ConnectionGUID: 0F39PxoMThaMpDShLc7d2Q==
X-CSE-MsgGUID: +hSTghGETvqyDztRwJrNiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; 
   d="scan'208";a="152812525"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 03:57:44 -0700
Date: Mon, 30 Jun 2025 12:56:46 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Stav Aviram <saviram@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, linux-rdma@vger.kernel.org,
	Mark Bloch <markb@mellanox.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH mlx5-next] net/mlx5: Check device memory pointer before
 usage
Message-ID: <aGJtbp/nXrCqbvbO@mev-dev.igk.intel.com>
References: <e389fa6ef075af1049cd7026b912d736ebe3ad23.1751279408.git.leonro@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e389fa6ef075af1049cd7026b912d736ebe3ad23.1751279408.git.leonro@nvidia.com>

On Mon, Jun 30, 2025 at 01:35:53PM +0300, Leon Romanovsky wrote:
> From: Stav Aviram <saviram@nvidia.com>
> 
> Add a NULL check before accessing device memory to prevent a crash if
> dev->dm allocation in mlx5_init_once() fails.
> 
> Fixes: c9b9dcb430b3 ("net/mlx5: Move device memory management to mlx5_core")
> Signed-off-by: Stav Aviram <saviram@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/mlx5/dm.c                  | 2 +-
>  drivers/net/ethernet/mellanox/mlx5/core/lib/dm.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/mlx5/dm.c b/drivers/infiniband/hw/mlx5/dm.c
> index b4c97fb62abf..9ded2b7c1e31 100644
> --- a/drivers/infiniband/hw/mlx5/dm.c
> +++ b/drivers/infiniband/hw/mlx5/dm.c
> @@ -282,7 +282,7 @@ static struct ib_dm *handle_alloc_dm_memic(struct ib_ucontext *ctx,
>  	int err;
>  	u64 address;
>  
> -	if (!MLX5_CAP_DEV_MEM(dm_db->dev, memic))
> +	if (!dm_db || !MLX5_CAP_DEV_MEM(dm_db->dev, memic))
>  		return ERR_PTR(-EOPNOTSUPP);
>  
>  	dm = kzalloc(sizeof(*dm), GFP_KERNEL);
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/dm.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/dm.c
> index 7c5516b0a844..8115071c34a4 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/dm.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/dm.c
> @@ -30,7 +30,7 @@ struct mlx5_dm *mlx5_dm_create(struct mlx5_core_dev *dev)
>  
>  	dm = kzalloc(sizeof(*dm), GFP_KERNEL);
>  	if (!dm)
> -		return ERR_PTR(-ENOMEM);
> +		return NULL;
>  
>  	spin_lock_init(&dm->lock);
>  
> @@ -96,7 +96,7 @@ struct mlx5_dm *mlx5_dm_create(struct mlx5_core_dev *dev)
>  err_steering:
>  	kfree(dm);
>  
> -	return ERR_PTR(-ENOMEM);
> +	return NULL;

In mlx5_init_once() IS_ERR is used (still). It should be consistent.
Looks like you can use IS_ERR() instead of checking just dm_db, however,
mlx5_dm_create() returns also NULL. I am not sure if it is fine (will
not cause an error in mlx5_init_once()).

Maybe the best is to change a check in mlx5_init_once() from IS_ERROR()
to just !dm.

Thanks

>  }
>  
>  void mlx5_dm_cleanup(struct mlx5_core_dev *dev)
> -- 
> 2.50.0

