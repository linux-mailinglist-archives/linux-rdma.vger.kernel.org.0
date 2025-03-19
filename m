Return-Path: <linux-rdma+bounces-8806-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B478A685AA
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 08:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8ABD179E99
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 07:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1338120E31B;
	Wed, 19 Mar 2025 07:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W40kJmi/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385B222094;
	Wed, 19 Mar 2025 07:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742368664; cv=none; b=WkjPPbEVqGfl578VpkoXL7pKofIbXrWkCr9OPaqEgHYK1u7/4FGmff3l+0HuWPQmSa1/6VSya1hM0d/qNcHLElMfReThB/xW+FqJ+K1o0/DvORI5LCoXiaK0tWcNjwntQRBDjupxAR59Q8hoz0kful8V66b8Mr0pVRX8KSswoAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742368664; c=relaxed/simple;
	bh=r9UE/8PziKGr+LZNll1AVokZJ3AjvWGm29slTNTelVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xs+96AMzI5TZx8zMTFDXX7qYQ0rL69r9XmdPR9Vw9OS5oMa6V1JMzzDOy18+z8qyGsPl+QXpaTVEQ3np5kZccMl5GvyDH5zzMnFqMnozgVeY7acuBlhsOJ1hdsyxYynM+zKbFvwor6QihKOfq2Ie3APg+CmH3x5labr+boFpDsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W40kJmi/; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742368663; x=1773904663;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=r9UE/8PziKGr+LZNll1AVokZJ3AjvWGm29slTNTelVw=;
  b=W40kJmi/tDeZ9zqUnQR1Q+SitOFrZeDo3c6Lky1IRVtoZWjioNlXxxTI
   njdh71QRVeHdojMsyPwvAFrWfgEzzxxUfupGzVSc60beobIB/nSYhZnPr
   gS4Dm5LV4LJSFRJPqGMtjbFKm7GxD8a/BpeTI80NwRK2eETC4cCM2hgF0
   YUptPhXS64qzrTL2PZR7CuhI3fApkuAq3s/p1cqGxP6Pw1AYR5rzOAizd
   Mcm118j33VZr39P0064o4R1GY4Mgv5tOGVVOba/Cz9UgvZlQwf10dnsFt
   ZT27TMRpqL50iGJdSjgI3JBAj1pGY4ALfCZANa7Cy7rRAJR0hHe0L36fH
   g==;
X-CSE-ConnectionGUID: 2yFjDwlkRQ2v8R4Ly7EYcg==
X-CSE-MsgGUID: eVG/+coSSTW687+gQjI21w==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="47188154"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="47188154"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 00:17:41 -0700
X-CSE-ConnectionGUID: jQRGYjyKT22VKSCU5Qukcg==
X-CSE-MsgGUID: lhPi0grLSiaCNRNQFl+6jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="122663228"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 00:17:38 -0700
Date: Wed, 19 Mar 2025 08:13:43 +0100
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
Subject: Re: [PATCH net 1/2] net/mlx5: LAG, reload representors on LAG
 creation failure
Message-ID: <Z9pupzJz9ArXrtrt@mev-dev.igk.intel.com>
References: <1742331077-102038-1-git-send-email-tariqt@nvidia.com>
 <1742331077-102038-2-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1742331077-102038-2-git-send-email-tariqt@nvidia.com>

On Tue, Mar 18, 2025 at 10:51:16PM +0200, Tariq Toukan wrote:
> From: Mark Bloch <mbloch@nvidia.com>
> 
> When LAG creation fails, the driver reloads the RDMA devices. If RDMA
> representors are present, they should also be reloaded. This step was
> missed in the cited commit.
> 
> Fixes: 598fe77df855 ("net/mlx5: Lag, Create shared FDB when in switchdev mode")
> Signed-off-by: Mark Bloch <mbloch@nvidia.com>
> Reviewed-by: Shay Drori <shayd@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
> index ed2ba272946b..6c9737c53734 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
> @@ -1052,6 +1052,10 @@ static void mlx5_do_bond(struct mlx5_lag *ldev)
>  		if (err) {
>  			if (shared_fdb || roce_lag)
>  				mlx5_lag_add_devices(ldev);
> +			if (shared_fdb) {
> +				mlx5_ldev_for_each(i, 0, ldev)
> +					mlx5_eswitch_reload_ib_reps(ldev->pf[i].dev->priv.eswitch);
> +			}
>  
>  			return;
>  		} else if (roce_lag) {
> -- 

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

> 2.31.1

