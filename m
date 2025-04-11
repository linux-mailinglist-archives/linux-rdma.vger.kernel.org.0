Return-Path: <linux-rdma+bounces-9365-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 362ECA8531A
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Apr 2025 07:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 648184A75B6
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Apr 2025 05:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F6726FA47;
	Fri, 11 Apr 2025 05:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XSGpiGpL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3CD1EFF91;
	Fri, 11 Apr 2025 05:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744349688; cv=none; b=pMGRMRkg4UVUHMGhGkpUpQoPI+2bRYi12kV9uUaspOpD6Qu3XkF7HuET/m2tNzRlcoz5qDrKpT4CVhh5wZE0TrjI/+DDrHFstlLkaQ9HAiKJvaBgudWuGtbIkIl1znzP2gBpoFhf46X4w01cj664sniO2rUeAk19cpnr+XRKL0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744349688; c=relaxed/simple;
	bh=H2Qqw27rWurJ/QM/BRFlhS3OhPfOdj1QefRWTHpFEf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BOdxwWriEjRV13lJPOBiDGJ5A9eG18nIGYrb/kGZw9Ww3gNUGgK9AkJd7PtZMZyxWrDfMEo1E02n5UPxQLR5EK9uEs2rJhYzOtumzyqGy0jp28i6btqM/slEiNfL9lOf2vXoR7xknFqrk1wX5Hhys4y7nf2dqfBfs7FfZBABy44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XSGpiGpL; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744349687; x=1775885687;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=H2Qqw27rWurJ/QM/BRFlhS3OhPfOdj1QefRWTHpFEf0=;
  b=XSGpiGpLbqJ9HQn5QJZahS9A5NeE+RzsrvQm2iQIV9kN/rCXDJ+6Ps8q
   0srjKRm4NMPfFsNVkb3Vfgd0Dk59alpliuxAmIiFBGEKi/lwQ7xOgSeNx
   +fNvrEebf/oLeyTRy/UtYRhVGt+oMwXn1w9gziM0dzVUatX1g1gylzlzI
   MJsL5xpizpUx6UdTqtNCbemICDrGCEND6skOdl36jtiX2QBbUPlCSyPbP
   uF9UKt+Oer1DFVFTyePsck2L1lMhBoXsdPrxNplL6FAC8ysTpzVRizIX5
   uYna87QWeXfq2SUXiZHBVqOW5QHF5aAhpK4dPhKs+UoBocTrEdKFxPL8b
   Q==;
X-CSE-ConnectionGUID: wqtrFZMPR467xaiWGgrBaA==
X-CSE-MsgGUID: EckEgiJuTI+3B4T948wLnA==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="49545162"
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="49545162"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 22:34:46 -0700
X-CSE-ConnectionGUID: /AJKS0U2ScCcxWfmtWg1wQ==
X-CSE-MsgGUID: CCkP4B5KTQur8nrJAkgQxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="166293792"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 22:34:43 -0700
Date: Fri, 11 Apr 2025 07:34:27 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Henry Martin <bsdhenrymartin@gmail.com>
Cc: saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
	netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	amirtz@nvidia.com, ayal@nvidia.com, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] net/mlx5: Fix null-ptr-deref in
 mlx5_create_{inner_,}ttc_table()
Message-ID: <Z/ip4y2qSYcn93U/@mev-dev.igk.intel.com>
References: <20250411022916.44698-1-bsdhenrymartin@gmail.com>
 <20250411022916.44698-2-bsdhenrymartin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411022916.44698-2-bsdhenrymartin@gmail.com>

On Fri, Apr 11, 2025 at 10:29:16AM +0800, Henry Martin wrote:
> Add NULL check for mlx5_get_flow_namespace() returns in
> mlx5_create_inner_ttc_table() and mlx5_create_ttc_table() to prevent
> NULL pointer dereference.
> 
> Fixes: 137f3d50ad2a ("net/mlx5: Support matching on l4_type for ttc_table")
> Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
> ---
> V2 -> V3: No functional changes, just gathering the patches in a series.
> V1 -> V2: Add a empty line after the return statement.
> 
>  drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c
> index eb3bd9c7f66e..18cc6960a5c1 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c
> @@ -655,6 +655,9 @@ struct mlx5_ttc_table *mlx5_create_inner_ttc_table(struct mlx5_core_dev *dev,
>  	}
>  
>  	ns = mlx5_get_flow_namespace(dev, params->ns_type);
> +	if (!ns)
> +		return ERR_PTR(-EOPNOTSUPP);

There is ttc = kvzalloc() before. I think you should call kvfree(ttc)
before returning. It looks like the same leak is already when
params->ns_type is unknown.

> +
>  	groups = use_l4_type ? &inner_ttc_groups[TTC_GROUPS_USE_L4_TYPE] :
>  			       &inner_ttc_groups[TTC_GROUPS_DEFAULT];
>  
> @@ -728,6 +731,9 @@ struct mlx5_ttc_table *mlx5_create_ttc_table(struct mlx5_core_dev *dev,
>  	}
>  
>  	ns = mlx5_get_flow_namespace(dev, params->ns_type);
> +	if (!ns)
> +		return ERR_PTR(-EOPNOTSUPP);

The same here.

> +
>  	groups = use_l4_type ? &ttc_groups[TTC_GROUPS_USE_L4_TYPE] :
>  			       &ttc_groups[TTC_GROUPS_DEFAULT];
>  
> -- 
> 2.34.1

