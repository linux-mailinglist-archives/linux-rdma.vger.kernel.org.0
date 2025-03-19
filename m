Return-Path: <linux-rdma+bounces-8817-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4870CA688A7
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 10:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83C3D3AA64E
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 09:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D89255221;
	Wed, 19 Mar 2025 09:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UxRpwZqr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB85A253F09;
	Wed, 19 Mar 2025 09:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742377269; cv=none; b=nB2eUyF4uEtpEIXJyKs3rRqhj3FeoiumPeKihvfobpdF/xn6otLqkwA3JpAykYtuYRGoFagrPNzApM1GXpD27+HjDaoJ2iZoIc/31Dc8z3U3or/qyB1pE3QPpOUEPsXB7fRwLmEi4+K6OK9DwpuKUMEdV4e6gjeNSlfb1KtBAB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742377269; c=relaxed/simple;
	bh=PJ7H4hxlsVt4HnZ26XPNszbRIKovfbpjMkYUm9hcA2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tLjWKomYCLthUm3LtK5ERMsGsKl7IcL/6CvER3JQiVzagrxh14SgC9q1an9bk0HHIK0fDGg7BVDRU3DMsI4jDJ0gCHXybyEmHWdJxYtShNI3juPMycXb/OuWQpMVWPWG389kyZLlrZcKkYxFk+MQZoWGEaD+lWQihaXfDPYfAhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UxRpwZqr; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742377268; x=1773913268;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PJ7H4hxlsVt4HnZ26XPNszbRIKovfbpjMkYUm9hcA2w=;
  b=UxRpwZqrYw/XaJeNnoWUPe8fQO/h3GcmlqixiEN68KYwiPa/AfdYwRnB
   jaZhgcfaO+RMGHTThE4qJ5ZZSHYl0iZ9O2O4+nZJ2tMieU8vvE1vV3jx2
   SICtP17AE762gAB1wP+DUR6QZLvRdb6CSCUVInEp6LPZ96DAJhOhwVCCu
   szp4vhbQzpzqpUa9/kkJCbM16oAwfsg6exVI/d6wAmUy/zKST8GBsSq8u
   U4b6hAEwnT33RzRmvN9MzSBvZTcYgTRLNNWxE0SR6dmOjVmoYbfE4HYhe
   nuv+qYATaEPnm8whj2ooze7gXvA1nOgXBMx2WpmdFG60lVteGyGfpZn3u
   w==;
X-CSE-ConnectionGUID: mFJ8xhVqQz6SkEOLf1Dk6A==
X-CSE-MsgGUID: gp5wc2QXSpiVKSZWpTFn5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="43658684"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="43658684"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 02:40:56 -0700
X-CSE-ConnectionGUID: 5D0h7bGjRNGNDKS2yrwXHg==
X-CSE-MsgGUID: ZwOtwQZVQCSFoVZm2GVxWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="122545409"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 02:40:53 -0700
Date: Wed, 19 Mar 2025 10:36:53 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Moshe Shemesh <moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: Re: [PATCH net 2/2] net/mlx5: Start health poll after enable hca
Message-ID: <Z9qQNe/M7IAkpR33@mev-dev.igk.intel.com>
References: <1742331077-102038-1-git-send-email-tariqt@nvidia.com>
 <1742331077-102038-3-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1742331077-102038-3-git-send-email-tariqt@nvidia.com>

On Tue, Mar 18, 2025 at 10:51:17PM +0200, Tariq Toukan wrote:
> From: Moshe Shemesh <moshe@nvidia.com>
> 
> The health poll mechanism performs periodic checks to detect firmware
> errors. One of the checks verifies the function is still enabled on
> firmware side, but the function is enabled only after enable_hca command
> completed. Start health poll after enable_hca command to avoid a race
> between function enabled and first health polling.
> 
> Fixes: 9b98d395b85d ("net/mlx5: Start health poll at earlier stage of driver load")
> Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
> Reviewed-by: Shay Drori <shayd@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/main.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
> index ec956c4bcebd..7c3312d6aed9 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
> @@ -1205,24 +1205,24 @@ static int mlx5_function_enable(struct mlx5_core_dev *dev, bool boot, u64 timeou
>  	dev->caps.embedded_cpu = mlx5_read_embedded_cpu(dev);
>  	mlx5_cmd_set_state(dev, MLX5_CMDIF_STATE_UP);
>  
> -	mlx5_start_health_poll(dev);
> -
>  	err = mlx5_core_enable_hca(dev, 0);
>  	if (err) {
>  		mlx5_core_err(dev, "enable hca failed\n");
> -		goto stop_health_poll;
> +		goto err_cmd_cleanup;
>  	}
>  
> +	mlx5_start_health_poll(dev);
> +
>  	err = mlx5_core_set_issi(dev);
>  	if (err) {
>  		mlx5_core_err(dev, "failed to set issi\n");
> -		goto err_disable_hca;
> +		goto stop_health_poll;
>  	}
>  
>  	err = mlx5_satisfy_startup_pages(dev, 1);
>  	if (err) {
>  		mlx5_core_err(dev, "failed to allocate boot pages\n");
> -		goto err_disable_hca;
> +		goto stop_health_poll;
>  	}
>  
>  	err = mlx5_tout_query_dtor(dev);
> @@ -1235,10 +1235,9 @@ static int mlx5_function_enable(struct mlx5_core_dev *dev, bool boot, u64 timeou
>  
>  reclaim_boot_pages:
>  	mlx5_reclaim_startup_pages(dev);
> -err_disable_hca:
> -	mlx5_core_disable_hca(dev, 0);
>  stop_health_poll:
>  	mlx5_stop_health_poll(dev, boot);
> +	mlx5_core_disable_hca(dev, 0);
>  err_cmd_cleanup:
>  	mlx5_cmd_set_state(dev, MLX5_CMDIF_STATE_DOWN);
>  	mlx5_cmd_disable(dev);
> @@ -1249,8 +1248,8 @@ static int mlx5_function_enable(struct mlx5_core_dev *dev, bool boot, u64 timeou
>  static void mlx5_function_disable(struct mlx5_core_dev *dev, bool boot)
>  {
>  	mlx5_reclaim_startup_pages(dev);
> -	mlx5_core_disable_hca(dev, 0);
>  	mlx5_stop_health_poll(dev, boot);
> +	mlx5_core_disable_hca(dev, 0);
>  	mlx5_cmd_set_state(dev, MLX5_CMDIF_STATE_DOWN);
>  	mlx5_cmd_disable(dev);
>  }

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

> -- 
> 2.31.1

