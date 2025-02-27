Return-Path: <linux-rdma+bounces-8182-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED579A475B0
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Feb 2025 07:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1AD93AB2C8
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Feb 2025 06:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A3721B9F0;
	Thu, 27 Feb 2025 06:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F0YN2OtI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C626321B9DD;
	Thu, 27 Feb 2025 06:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740636035; cv=none; b=tG5v+Tk2evrPYGOruozB6qwAaM+tSjXRheCD9cU2gf7KfdL4Dn3S2olHqzE0csxpiKfsJId82ArkYdWK2jlgTD646omdBffJ0OnjFQyvoBrXZmb3VOc9/iqdAApMPR1n+AtqGRrRYIX1ZQyJrSa6zN4W8PjuY+CIUrWlRq2KdSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740636035; c=relaxed/simple;
	bh=wghXbd5IbpTMH6PzuvfZWZWny5yH0iTqVnlU3Razxj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CnIu8e4qaZSZyPFiCBDlnmQ1QhV4fk+rouN+0vTY1+xv9AvwPgCS5a/OPA7rcnNkykB/7z/UDF6/GHxaDzlcjsnRYadH0XYp51xtyOhAmVooSH64Td+CgIy8FMQwaToyYKAT9quaLdYNqCTEKdFiqK8DU+hbo9N6/cjeUgqPXMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F0YN2OtI; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740636034; x=1772172034;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wghXbd5IbpTMH6PzuvfZWZWny5yH0iTqVnlU3Razxj8=;
  b=F0YN2OtI50FOUioZ28r4RCf+Xytmjy82+mBMfPeytXqU9tahYG04wFZ9
   EMfQdiXPqlaAVfZoiakmkuN8+IP/h86fMZIvSIusAcfKJoQSST/tgY8Sm
   W/+D3d8g3BEA9SE/faE5rYIindLNxA23a1zaChPBycFKmZLKDhIUJns5c
   7Y5DY2FV3frDkf3G+21dBXOJUiOdYX4rQy78kPaREhpMcmrOST1Up7q+2
   aX3psAHbddFLfOqEln9ePoeEM5b2188Lc3NTh92gQC7fLt2rzTexWcEuv
   qdsnCZkXqzBH3I56ijaGVBmRh35BuOqxmLC8eW9ROZ2CX24EZCUjXCaps
   w==;
X-CSE-ConnectionGUID: 3/e05AYDTTizWMmtuN2xDA==
X-CSE-MsgGUID: tQH+W898TSa+RUgBRmopdw==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="52149070"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="52149070"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 22:00:26 -0800
X-CSE-ConnectionGUID: tzi6/lT1TmCx8F+X9J7WyA==
X-CSE-MsgGUID: 8rgcTR3WTLO693wDEZ0llA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="116719266"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 22:00:22 -0800
Date: Thu, 27 Feb 2025 06:56:39 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Shahar Shitrit <shshitrit@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>
Subject: Re: [PATCH net-next 3/4] net/mlx5: Expose crr in health buffer
Message-ID: <Z7/+lxTndCRC6OtE@mev-dev.igk.intel.com>
References: <20250226122543.147594-1-tariqt@nvidia.com>
 <20250226122543.147594-4-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226122543.147594-4-tariqt@nvidia.com>

On Wed, Feb 26, 2025 at 02:25:42PM +0200, Tariq Toukan wrote:
> From: Shahar Shitrit <shshitrit@nvidia.com>
> 
> Expose crr bit in struct health buffer. When set, it indicates that
> the error cannot be recovered without flow involving a cold reset.
> Add its value to the health buffer info log.
> 
> Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
> Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/health.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/health.c b/drivers/net/ethernet/mellanox/mlx5/core/health.c
> index 665cbce89175..c7ff646e0865 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/health.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/health.c
> @@ -96,6 +96,11 @@ static int mlx5_health_get_rfr(u8 rfr_severity)
>  	return rfr_severity >> MLX5_RFR_BIT_OFFSET;
>  }
>  
> +static int mlx5_health_get_crr(u8 rfr_severity)
> +{
> +	return (rfr_severity >> MLX5_CRR_BIT_OFFSET) & 0x01;
> +}
> +
>  static bool sensor_fw_synd_rfr(struct mlx5_core_dev *dev)
>  {
>  	struct mlx5_core_health *health = &dev->priv.health;
> @@ -442,12 +447,15 @@ static void print_health_info(struct mlx5_core_dev *dev)
>  	mlx5_log(dev, severity, "time %u\n", ioread32be(&h->time));
>  	mlx5_log(dev, severity, "hw_id 0x%08x\n", ioread32be(&h->hw_id));
>  	mlx5_log(dev, severity, "rfr %d\n", mlx5_health_get_rfr(rfr_severity));
> +	mlx5_log(dev, severity, "crr %d\n", mlx5_health_get_crr(rfr_severity));
>  	mlx5_log(dev, severity, "severity %d (%s)\n", severity, mlx5_loglevel_str(severity));
>  	mlx5_log(dev, severity, "irisc_index %d\n", ioread8(&h->irisc_index));
>  	mlx5_log(dev, severity, "synd 0x%x: %s\n", ioread8(&h->synd),
>  		 hsynd_str(ioread8(&h->synd)));
>  	mlx5_log(dev, severity, "ext_synd 0x%04x\n", ioread16be(&h->ext_synd));
>  	mlx5_log(dev, severity, "raw fw_ver 0x%08x\n", ioread32be(&h->fw_ver));
> +	if (mlx5_health_get_crr(rfr_severity))
> +		mlx5_core_warn(dev, "Cold reset is required\n");
I wonder if it shouldn't be right after the print about crr value to
tell the user that cold reset is required because of that value.

Patch looks fine, thanks.
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

>  }

>  
>  static int
> -- 
> 2.45.0

