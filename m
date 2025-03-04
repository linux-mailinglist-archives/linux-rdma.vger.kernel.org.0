Return-Path: <linux-rdma+bounces-8286-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBF7A4D4BA
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 08:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3728B18911DC
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 07:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2736F1FC7F2;
	Tue,  4 Mar 2025 07:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TuO/UDwO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1304B1FBEB3;
	Tue,  4 Mar 2025 07:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741072585; cv=none; b=r6WS2AaAIXRnoWoGftfmOCvLjLJF7Nn0h/Vrzr5Ag+DuO87d+Qest5niy71rK44jCzpBwwlwUIIQVwLyZvjmWqJHMQ/86ZhfnVCYtMGurkAaKh+j1OVs4IeRUQtu4FqwRLZ9FFdfrbwDMiOCxtwlQXuNkg7hQSThfOjkNpiJ4h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741072585; c=relaxed/simple;
	bh=vA1PHVGyKBsZXGTUFJhLoHOtf7WUBd9NEZ6psAdExJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FzfzCurRN7DaGwJ4u6Vx/Q17FVBFwa5uO/SrQ67cwvZovV+x4yAfmPmN4Cm58oYU9NfUl/KD3PQ0WG31vX0hEgCht7rJ4TJjQOgO4lHHAkWMHnGbG/7GG+Uxx5eECz9IcoODviQPseWMWxVMfX0aINJ8EhPSKGaBHt+RE6iQAY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TuO/UDwO; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741072584; x=1772608584;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vA1PHVGyKBsZXGTUFJhLoHOtf7WUBd9NEZ6psAdExJo=;
  b=TuO/UDwO7TDlfSQdj6WYQehiVCSkfRA4ISXOJVnPhJTxs8o8oedJCgYG
   pc4CJysAlN8WTjt62OjwafW6ffkKSju5KAzBhx8NKdohe4rdD+3+wGoEV
   bMChCTpKAeIXGxAt/bUs6kc0Ikdmj2DzvQC+eEoN1KvDI2mZo6uuEb6nW
   KwUiTxNQkvae4xEV9dkL0hc8RB5yAnJWn/VQrbBXLSVlkPLIcMvM77rA1
   IdEXgXGlaairSie+ygUNnh3fP7DjQxzqL4zJqFJ2CChtaMUp01OtD+HpT
   H4s+fAxQ5lrd1rGoO9gwqIzfKNGGCgyyadTnYb5OalMlEgFESTUZSIOLv
   w==;
X-CSE-ConnectionGUID: iYFu+B1sRkmUWH7cub0c7Q==
X-CSE-MsgGUID: 5niIKDU+T+yhRdVBpmMAtQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="44784277"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="44784277"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 23:16:23 -0800
X-CSE-ConnectionGUID: ErItsbA0TaGriciw0SFmDg==
X-CSE-MsgGUID: TbASbV78QoSmaKexCGnnIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="118447613"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 23:16:20 -0800
Date: Tue, 4 Mar 2025 08:12:32 +0100
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
	Amir Tzin <amirtz@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: Re: [PATCH net-next 4/6] net/mlx5: Lag, Enable Multiport E-Switch
 offloads on 8 ports LAG
Message-ID: <Z8an4KmSILuK4mmv@mev-dev.igk.intel.com>
References: <20250226114752.104838-1-tariqt@nvidia.com>
 <20250226114752.104838-5-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226114752.104838-5-tariqt@nvidia.com>

On Wed, Feb 26, 2025 at 01:47:50PM +0200, Tariq Toukan wrote:
> From: Amir Tzin <amirtz@nvidia.com>
> 
> Patch [1] added mlx5 driver support for 8 ports HCAs which are available
> since ConnectX-8. Now that Multiport E-Switch is tested, we can enable
> it by removing flag MLX5_LAG_MPESW_OFFLOADS_SUPPORTED_PORTS.
> 
> [1]
> commit e0e6adfe8c20 ("net/mlx5: Enable 8 ports LAG")
> 
> Signed-off-by: Amir Tzin <amirtz@nvidia.com>
> Signed-off-by: Mark Bloch <mbloch@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
> index ffac0bd6c895..cbde54324059 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
> @@ -65,7 +65,6 @@ static int mlx5_mpesw_metadata_set(struct mlx5_lag *ldev)
>  	return err;
>  }
>  
> -#define MLX5_LAG_MPESW_OFFLOADS_SUPPORTED_PORTS 4
>  static int enable_mpesw(struct mlx5_lag *ldev)
>  {
>  	int idx = mlx5_lag_get_dev_index_by_seq(ldev, MLX5_LAG_P1);
> @@ -77,9 +76,6 @@ static int enable_mpesw(struct mlx5_lag *ldev)
>  		return -EINVAL;
>  
>  	dev0 = ldev->pf[idx].dev;
> -	if (ldev->ports > MLX5_LAG_MPESW_OFFLOADS_SUPPORTED_PORTS)
> -		return -EOPNOTSUPP;
> -
>  	if (mlx5_eswitch_mode(dev0) != MLX5_ESWITCH_OFFLOADS ||
>  	    !MLX5_CAP_PORT_SELECTION(dev0, port_select_flow_table) ||
>  	    !MLX5_CAP_GEN(dev0, create_lag_when_not_master_up) ||

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

> -- 
> 2.45.0

