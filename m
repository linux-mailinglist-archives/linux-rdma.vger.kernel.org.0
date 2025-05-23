Return-Path: <linux-rdma+bounces-10609-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B59AC1BA8
	for <lists+linux-rdma@lfdr.de>; Fri, 23 May 2025 06:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CE461C02AB6
	for <lists+linux-rdma@lfdr.de>; Fri, 23 May 2025 04:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6009D224224;
	Fri, 23 May 2025 04:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mVjheUK3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468092DCBF2;
	Fri, 23 May 2025 04:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747975952; cv=none; b=NLit7wEhZr/T3tR/QlPqXe453FdvOPrlvxWkieUvxxfGWSeAVXmFX3dhWcjrgikKtKHgi2vXA29MRNQR7hj6/yuqDZx10Tb1FD+q3BxSHTMkXV7wOSvmtI4AkKE9LgCd7xs4TXyqJXHA/2BGCJ8mcSf2/I9vmopRn+76RokmYUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747975952; c=relaxed/simple;
	bh=0c+kIPvS6RoW+r58sZUF2YO2NBcXGNhW3/L80dui7hc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NcS32Lc98gqGF2Ih5t3Ycv0yvlR4JaaooNazJhYU9Q4k5BuIT2c32AGQTM3jFMXUeWdj4HezW/Ezj1nlLhMiSJ5WzfSLXCtrwpwzXi1c6MEjkrCMw5PlH3+XJskNtQwzMSSGxONjNRcQHH40KhJz0eiBp/xPkdLziHFWv9fRe/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mVjheUK3; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747975950; x=1779511950;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0c+kIPvS6RoW+r58sZUF2YO2NBcXGNhW3/L80dui7hc=;
  b=mVjheUK3mwsowQKZJVWIFZsUd2Z2REmtUlXaujU9Qo/r5zOL9Jlodqfa
   7eQsN84Mnj77DPWKSmuh+yyFMCvYRKA8YOOFscj3XvsXiMBpmDfKgvmyw
   g+aiuwU49vLYNHAtcPgm1M/RshoWg5bMCDXjeropLiFmhbf5EYPDCpWW3
   YAxd/W+bpOLJpcXGGoOuiNfORMK/CjNIOW2pPKh2ewHYNFnjvFHs3KPf8
   9NTo+dBq6mUIT1F08xc9cO2YbEYjT0u/ZcQwqT614z77y65yU5xy+PnP1
   0bxJ7rIkQJFGUFXaogf+sK8oEFlpUzNv/pDeEMpc1zUr58DAQscguxN5G
   A==;
X-CSE-ConnectionGUID: GN8dG0vQTpGHbaJCKfXpgg==
X-CSE-MsgGUID: v8qPSW82SBWKrdyqh9cssg==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="60677841"
X-IronPort-AV: E=Sophos;i="6.15,307,1739865600"; 
   d="scan'208";a="60677841"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 21:52:29 -0700
X-CSE-ConnectionGUID: cMHTX6XNQqqVWyAzImDssg==
X-CSE-MsgGUID: yOUfxNrBQkeGo40IKOXGdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,307,1739865600"; 
   d="scan'208";a="140825990"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 21:52:26 -0700
Date: Fri, 23 May 2025 06:51:51 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4] net/mlx5: Add error handling in
 mlx5_query_nic_vport_node_guid()
Message-ID: <aC/+51369a/LgCdU@mev-dev.igk.intel.com>
References: <20250523024304.1216-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523024304.1216-1-vulab@iscas.ac.cn>

On Fri, May 23, 2025 at 10:43:04AM +0800, Wentao Liang wrote:
> The function mlx5_query_nic_vport_node_guid() calls the function
> mlx5_query_nic_vport_context() but does not check its return value.
> A proper implementation can be found in mlx5_nic_vport_query_local_lb().
> 
> Add error handling for mlx5_query_nic_vport_context(). If it fails, free
> the out buffer via kvfree() and return error code.
> 
> Fixes: 9efa75254593 ("net/mlx5_core: Introduce access functions to query vport RoCE fields")
> Cc: stable@vger.kernel.org # v4.5
> Target: net

You forgot to drop this tag (Simon replay to v3:
https://lore.kernel.org/netdev/20250522154057.GI365796@horms.kernel.org/#R)

> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
> v4: Fix code error.
> v3: Explicitly mention target branch. Change improper code.
> v2: Remove redundant reassignment. Fix typo error.
> 
>  drivers/net/ethernet/mellanox/mlx5/core/vport.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/vport.c b/drivers/net/ethernet/mellanox/mlx5/core/vport.c
> index 0d5f750faa45..c34cd9a1a79b 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/vport.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/vport.c
> @@ -465,19 +465,22 @@ int mlx5_query_nic_vport_node_guid(struct mlx5_core_dev *mdev, u64 *node_guid)
>  {
>  	u32 *out;
>  	int outlen = MLX5_ST_SZ_BYTES(query_nic_vport_context_out);
> +	int err;
>  
>  	out = kvzalloc(outlen, GFP_KERNEL);
>  	if (!out)
>  		return -ENOMEM;
>  
> -	mlx5_query_nic_vport_context(mdev, 0, out);
> +	err = mlx5_query_nic_vport_context(mdev, 0, out);
> +	if (err)
> +		goto out;
>  
>  	*node_guid = MLX5_GET64(query_nic_vport_context_out, out,
>  				nic_vport_context.node_guid);
> -
> +out:
>  	kvfree(out);
>  
> -	return 0;
> +	return err;
>  }
>  EXPORT_SYMBOL_GPL(mlx5_query_nic_vport_node_guid);
>  
> -- 
> 2.42.0.windows.2

