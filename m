Return-Path: <linux-rdma+bounces-9713-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEBBFA98729
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Apr 2025 12:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3793C3BC910
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Apr 2025 10:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694F425C822;
	Wed, 23 Apr 2025 10:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mqhp07Ph"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428AC1F4C8C;
	Wed, 23 Apr 2025 10:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745403505; cv=none; b=m3xYc97qm5uzRQzjkJeCDy+Dv9ro9dIZglQAreNzEW9mb727+5jp1ZSq6QF2fKE3EX78u/7IKeh5rowCRoG7HSSU+EBcLK+OSjRuKMrmCyhYmtQoodegenEB0AiJTU7ledZpMnFNYTru6DgSAfD+p/LGpHoBKLBOdm4oC2i9TlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745403505; c=relaxed/simple;
	bh=yNOd3U+49t8lqUpUY0h8t4lLvgZ7zTt+Q2t+fwKR9ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZMrNMSj9A3pJ4DiMfmvjgTeSYpvYtqRCGDjArNO+GZUmiHd+WT14XhIfEWkjdi0N7cnc1sVwYB6Stb4vf9f+6hDcGOZzFbRQWi5JVtG84uPf8Re0AG4oGu2I/ICNiXxfC/G+XVZuewzkqq8FZrz+2OTaYtygmWU0CUbI/eJxpMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mqhp07Ph; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745403503; x=1776939503;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yNOd3U+49t8lqUpUY0h8t4lLvgZ7zTt+Q2t+fwKR9ew=;
  b=mqhp07Phy46BEFtvQqqQJTxgS1nsS92//Ww4A5u5Gs3qJvnIi40MwW9v
   3BXKxIunwasAguPb/YKeqOtjMcJv/vzeFHVq7okf2PD0kvA+6slbAoZol
   JQ7altwWYi56ra79Z8mol3I0nNA/eHz28zLr0r6cdv9JmIDy8aKoRqZE6
   4rI7Atn8NiuMpFzbuJ3Srhb+VJqZ2BOfVp4nkrBdOI9SRw3fbxSTknShU
   iMouR6KDTjQo31HBeKfIDZD/nG733nQrGe9Cx2C6As6TZnDmoryI9ljdR
   jjPj8+JYyPfV8bf7VBCo7XB3hSWSxXnFMH4rmezX1PSXYEIUjWWNpg1Wy
   A==;
X-CSE-ConnectionGUID: HfWMRZjNT2ilk3wV9XrSVA==
X-CSE-MsgGUID: JWuohtBAT+GFRc5gpvCi5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="69478674"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="69478674"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 03:18:20 -0700
X-CSE-ConnectionGUID: StqWFCi3QuWFEaGrfg+wAg==
X-CSE-MsgGUID: bUTllSDtT1mP0ZsC2ae3MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="132118956"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 03:18:17 -0700
Date: Wed, 23 Apr 2025 12:17:56 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Mark Bloch <mbloch@nvidia.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, Chris Mi <cmi@nvidia.com>,
	Roi Dayan <roid@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>
Subject: Re: [PATCH net 5/5] net/mlx5: E-switch, Fix error handling for
 enabling roce
Message-ID: <aAi+VAcQEYOhQSnF@mev-dev.igk.intel.com>
References: <20250423083611.324567-1-mbloch@nvidia.com>
 <20250423083611.324567-6-mbloch@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423083611.324567-6-mbloch@nvidia.com>

On Wed, Apr 23, 2025 at 11:36:11AM +0300, Mark Bloch wrote:
> From: Chris Mi <cmi@nvidia.com>
> 
> The cited commit assumes enabling roce always succeeds. But it is
> not true. Add error handling for it.
> 
> Fixes: 80f09dfc237f ("net/mlx5: Eswitch, enable RoCE loopback traffic")
> Signed-off-by: Chris Mi <cmi@nvidia.com>
> Reviewed-by: Roi Dayan <roid@nvidia.com>
> Reviewed-by: Maor Gottlieb <maorg@nvidia.com>
> Signed-off-by: Mark Bloch <mbloch@nvidia.com>
> ---
>  .../net/ethernet/mellanox/mlx5/core/eswitch_offloads.c   | 5 ++++-
>  drivers/net/ethernet/mellanox/mlx5/core/rdma.c           | 9 +++++----
>  drivers/net/ethernet/mellanox/mlx5/core/rdma.h           | 4 ++--
>  3 files changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
> index a6a8eea5980c..0e3a977d5332 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
> @@ -3533,7 +3533,9 @@ int esw_offloads_enable(struct mlx5_eswitch *esw)
>  	int err;
>  
>  	mutex_init(&esw->offloads.termtbl_mutex);
> -	mlx5_rdma_enable_roce(esw->dev);
> +	err = mlx5_rdma_enable_roce(esw->dev);
> +	if (err)
> +		goto err_roce;
>  
>  	err = mlx5_esw_host_number_init(esw);
>  	if (err)
> @@ -3594,6 +3596,7 @@ int esw_offloads_enable(struct mlx5_eswitch *esw)
>  	esw_offloads_metadata_uninit(esw);
>  err_metadata:
>  	mlx5_rdma_disable_roce(esw->dev);
> +err_roce:
>  	mutex_destroy(&esw->offloads.termtbl_mutex);
>  	return err;
>  }
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/rdma.c b/drivers/net/ethernet/mellanox/mlx5/core/rdma.c
> index f585ef5a3424..5c552b71e371 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/rdma.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/rdma.c
> @@ -140,17 +140,17 @@ void mlx5_rdma_disable_roce(struct mlx5_core_dev *dev)
>  	mlx5_nic_vport_disable_roce(dev);
>  }
>  
> -void mlx5_rdma_enable_roce(struct mlx5_core_dev *dev)
> +int mlx5_rdma_enable_roce(struct mlx5_core_dev *dev)
>  {
>  	int err;
>  
>  	if (!MLX5_CAP_GEN(dev, roce))
> -		return;
> +		return 0;
>  
>  	err = mlx5_nic_vport_enable_roce(dev);
>  	if (err) {
>  		mlx5_core_err(dev, "Failed to enable RoCE: %d\n", err);
> -		return;
> +		return err;
>  	}
>  
>  	err = mlx5_rdma_add_roce_addr(dev);
> @@ -165,10 +165,11 @@ void mlx5_rdma_enable_roce(struct mlx5_core_dev *dev)
>  		goto del_roce_addr;
>  	}
>  
> -	return;
> +	return err;
>  
>  del_roce_addr:
>  	mlx5_rdma_del_roce_addr(dev);
>  disable_roce:
>  	mlx5_nic_vport_disable_roce(dev);
> +	return err;
>  }
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/rdma.h b/drivers/net/ethernet/mellanox/mlx5/core/rdma.h
> index 750cff2a71a4..3d9e76c3d42f 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/rdma.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/rdma.h
> @@ -8,12 +8,12 @@
>  
>  #ifdef CONFIG_MLX5_ESWITCH
>  
> -void mlx5_rdma_enable_roce(struct mlx5_core_dev *dev);
> +int mlx5_rdma_enable_roce(struct mlx5_core_dev *dev);
>  void mlx5_rdma_disable_roce(struct mlx5_core_dev *dev);
>  
>  #else /* CONFIG_MLX5_ESWITCH */
>  
> -static inline void mlx5_rdma_enable_roce(struct mlx5_core_dev *dev) {}
> +static inline int mlx5_rdma_enable_roce(struct mlx5_core_dev *dev) { return 0; }
>  static inline void mlx5_rdma_disable_roce(struct mlx5_core_dev *dev) {}
>  
>  #endif /* CONFIG_MLX5_ESWITCH */

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

> -- 
> 2.34.1

