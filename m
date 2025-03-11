Return-Path: <linux-rdma+bounces-8565-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F653A5BA85
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Mar 2025 09:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6FFA16EC94
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Mar 2025 08:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA10B224227;
	Tue, 11 Mar 2025 08:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XOdhGi4S"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB701DE894;
	Tue, 11 Mar 2025 08:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741680722; cv=none; b=LiY8XZKKiHVj+5TSCHEbYoT8gCm2rEd/5mSg9WFo9Fl7ItWof5YbYB/Ez0pEoPWHcGNSfgqpxHh9gACuLOBjuXMw2WRJlZ9qeibFcSfFHbI4RHWChq1gOo6phxbyxZwXwsLn1VsMRqrzLQGZr/vZUXGZeVSP/3b66jOD4ox3cro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741680722; c=relaxed/simple;
	bh=vA06Rl2ek5wsWLgUNf9K2XAhCsBQfUsYoPC1Dx7H0os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nI662eA1qRbXRSoK8ZWwCHRU+k2EPourxgQyftpWCe9AKLHmV05YBGtADFzo5zz6+673bhl7cqnYPqFsMvMhJK3NxViFVoJiQ/R0WSnZMvuoggWiG6u4MBP0ucBF4tH1vob25wSaxHieYafwRtXRG3k4mlOZHXm+2sytloRbCZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XOdhGi4S; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741680720; x=1773216720;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vA06Rl2ek5wsWLgUNf9K2XAhCsBQfUsYoPC1Dx7H0os=;
  b=XOdhGi4SzWDlbCN4Zzr4Ag2BdzRTMuKpxUqJBv6Pqd4zVTQAvAjTQk2e
   KwEIqCGq3R5mg+XWkSVPe6pTFbjJV/jW0LHI4YqbLn4q4KnFOGOi4UFjo
   Tg0dtZ+5EYfOY3qRpzhvA3UYWOq88LIPrpJQg7d1a313Iw6v2BNWLS+yW
   /B3pj2ZCEz7ybCI2DBB0OzUE11uOHQMUhrnWY7LjSDwj9cHN24CX0UMDJ
   O3uPPPB+TeCxVtHJIRw0230NHx7NMD3JDsDYwVcERKa17SZTCDi+ZfCs8
   cr1q6scGv34aqA3f2+Dedk3c9YjGngDz9FWfaDEf12onh1Ci44GgnUNk5
   g==;
X-CSE-ConnectionGUID: E+Z0r5nvSaC5/6eJ5D39Yw==
X-CSE-MsgGUID: QrJ0vETuQlWFxv35VwMj4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="45491357"
X-IronPort-AV: E=Sophos;i="6.14,238,1736841600"; 
   d="scan'208";a="45491357"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 01:12:00 -0700
X-CSE-ConnectionGUID: M6GakZ3hRaaph7ZMRwMV/w==
X-CSE-MsgGUID: bSPH9ntvQPOnyoB8aL8geA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,238,1736841600"; 
   d="scan'208";a="157464742"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 01:11:56 -0700
Date: Tue, 11 Mar 2025 09:08:03 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Gal Pressman <gal@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Carolina Jubran <cjubran@nvidia.com>
Subject: Re: [PATCH net 6/6] net/mlx5e: Prevent bridge link show failure for
 non-eswitch-allowed devices
Message-ID: <Z8/vY+fEb/CeDwtw@mev-dev.igk.intel.com>
References: <1741644104-97767-1-git-send-email-tariqt@nvidia.com>
 <1741644104-97767-7-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1741644104-97767-7-git-send-email-tariqt@nvidia.com>

On Tue, Mar 11, 2025 at 12:01:44AM +0200, Tariq Toukan wrote:
> From: Carolina Jubran <cjubran@nvidia.com>
> 
> mlx5_eswitch_get_vepa returns -EPERM if the device lacks
> eswitch_manager capability, blocking mlx5e_bridge_getlink from
> retrieving VEPA mode. Since mlx5e_bridge_getlink implements
> ndo_bridge_getlink, returning -EPERM causes bridge link show to fail
> instead of skipping devices without this capability.
> 
> To avoid this, return -EOPNOTSUPP from mlx5e_bridge_getlink when
> mlx5_eswitch_get_vepa fails, ensuring the command continues processing
> other devices while ignoring those without the necessary capability.
> 
> Fixes: 4b89251de024 ("net/mlx5: Support ndo bridge_setlink and getlink")
> Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
> Reviewed-by: Jianbo Liu <jianbol@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> index a814b63ed97e..8fcaee381b0e 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> @@ -5132,11 +5132,9 @@ static int mlx5e_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
>  	struct mlx5e_priv *priv = netdev_priv(dev);
>  	struct mlx5_core_dev *mdev = priv->mdev;
>  	u8 mode, setting;
> -	int err;
>  
> -	err = mlx5_eswitch_get_vepa(mdev->priv.eswitch, &setting);
> -	if (err)
> -		return err;
> +	if (mlx5_eswitch_get_vepa(mdev->priv.eswitch, &setting))
> +		return -EOPNOTSUPP;
>  	mode = setting ? BRIDGE_MODE_VEPA : BRIDGE_MODE_VEB;
>  	return ndo_dflt_bridge_getlink(skb, pid, seq, dev,
>  				       mode,

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

> -- 
> 2.31.1

