Return-Path: <linux-rdma+bounces-9729-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E00EA98791
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Apr 2025 12:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABC0144450F
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Apr 2025 10:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA65278E6A;
	Wed, 23 Apr 2025 10:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kIHy7eJP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6724326C398;
	Wed, 23 Apr 2025 10:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745404342; cv=none; b=cLS6swyIa9iaAnJY+6p3SHGil5UqlLBEueoli+NdxVp1/wyE7n9u5CawaCQzorZADNxsjoVXbAMFkcTf3Zs0YAWGfIzyMiiemDJLZaCLC8lEwJxZ7O3XfdtsKKZy1HL0jhDqtzfciyyTAWWjyPA+yLM6NlAop07fqsvE7yd/uQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745404342; c=relaxed/simple;
	bh=nw/p7Xy5WmOEAJlHd65+ffN6eoeLZ/9XqWltZaMdVAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mkllLwjqYN/kEf0w26B4FWMy8KNGHUDj1r7i2YXh+wXWF7Fs4I2XDcpgbuWZVoZZ5cO2V4WXm1IsXYNPG89M1Rz1lXtkJgLR4iNIMcla7p9fTfZHampvkEJcNf19s3XHZ12CPL3Rf+MtPnfJuOJIXx/q4XMpn1tgsy1wlfdnhio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kIHy7eJP; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745404340; x=1776940340;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nw/p7Xy5WmOEAJlHd65+ffN6eoeLZ/9XqWltZaMdVAw=;
  b=kIHy7eJP1691/0+YobxuXSNLhqdqTfdUAtAeQGyPtqt7UmUXBoSFuG+V
   uaIVzBO3G2hQwHtGh/wmKjMLBolQjB8qFkZV4BWcr5MgUgHf229fEkQmH
   WEogJg9YMIiWhvKQLZubksQmqjHGomaoGV194dNBiwS8YwJ8RGCVmRwUN
   R6ouuU3MbJs/jFzSm/76YukuGs51AUDrxTMYMDbozZyEJCwgGb4hCMYNF
   5y6DHiQcQcdNzCaKFffS1TB+bw1OPfCwid5S8bN45lSWNopFRUCEdKchX
   tRjGg1VX6F2r+XoMqVPzJuqgXCZDD0U0I5e1/zv+p+nbq86UiI1xpRuZC
   Q==;
X-CSE-ConnectionGUID: VkI0e29IQI+nPwd9PDskVw==
X-CSE-MsgGUID: miDXymn4TdWOYNohP2D9/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="57184532"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="57184532"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 03:32:11 -0700
X-CSE-ConnectionGUID: i2EOFrxjTZSz4x068QHG8g==
X-CSE-MsgGUID: WkHdQpcpTs6xSi1iKqZKiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="132587733"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 03:32:08 -0700
Date: Wed, 23 Apr 2025 12:31:47 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Mark Bloch <mbloch@nvidia.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, Maor Gottlieb <maorg@nvidia.com>
Subject: Re: [PATCH net 2/5] net/mlx5: E-Switch, Initialize MAC Address for
 Default GID
Message-ID: <aAjBk5gX27FtnE3f@mev-dev.igk.intel.com>
References: <20250423083611.324567-1-mbloch@nvidia.com>
 <20250423083611.324567-3-mbloch@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423083611.324567-3-mbloch@nvidia.com>

On Wed, Apr 23, 2025 at 11:36:08AM +0300, Mark Bloch wrote:
> From: Maor Gottlieb <maorg@nvidia.com>
> 
> Initialize the source MAC address when creating the default GID entry.
> Since this entry is used only for loopback traffic, it only needs to
> be a unicast address. A zeroed-out MAC address is sufficient for this
> purpose.
> Without this fix, random bits would be assigned as the source address.
> If these bits formed a multicast address, the firmware would return an
> error, preventing the user from switching to switchdev mode:
> 
> Error: mlx5_core: Failed setting eswitch to offloads.
> kernel answers: Invalid argument
> 
> Fixes: 80f09dfc237f ("net/mlx5: Eswitch, enable RoCE loopback traffic")
> Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
> Signed-off-by: Mark Bloch <mbloch@nvidia.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/rdma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/rdma.c b/drivers/net/ethernet/mellanox/mlx5/core/rdma.c
> index a42f6cd99b74..f585ef5a3424 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/rdma.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/rdma.c
> @@ -118,8 +118,8 @@ static void mlx5_rdma_make_default_gid(struct mlx5_core_dev *dev, union ib_gid *
>  
>  static int mlx5_rdma_add_roce_addr(struct mlx5_core_dev *dev)
>  {
> +	u8 mac[ETH_ALEN] = {};

Won't it be helpful to add comment that it needs to be unicast and 0 is
a valid MAC?

Anyway,
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

hw_id in mlx5_rdma_make_default_gid() is also used without assigining.
Is it fine to have random bits there?

Thanks

>  	union ib_gid gid;
> -	u8 mac[ETH_ALEN];
>  
>  	mlx5_rdma_make_default_gid(dev, &gid);
>  	return mlx5_core_roce_gid_set(dev, 0,
> -- 
> 2.34.1

