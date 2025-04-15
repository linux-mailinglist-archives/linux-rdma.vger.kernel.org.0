Return-Path: <linux-rdma+bounces-9440-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEE1A896FB
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Apr 2025 10:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BE437A54DC
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Apr 2025 08:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B760D27F72C;
	Tue, 15 Apr 2025 08:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PYlsRpYi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB37F1AF0AE;
	Tue, 15 Apr 2025 08:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744706609; cv=none; b=h778TppLzjMw9gJxDuRjwYa1VBhgvxkjCYZKeiDkMP+LY22Pnj+Pxt5riOgEGfZKDqwGF27RZs/oIGztWgX0mr63A6z9zXol5nhAQ+YyMiIeww2gdtQa/TAhJidayMZZDSOVSTqeHH/rELz81MJZGb19AbdPyQ+buJt01MNdoH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744706609; c=relaxed/simple;
	bh=bqVy4cE5Zj6YhNLsiG6Ni3/flTkFOehuJyaTktuTw8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HiwFpu7nQrORWuTWn/aW/uAEbIwoJbEtU5RzwoWM9UXsp109JHAD/4IneVngughTYg4veaUyL26dNlIrMhwgcoZoifHQ9w/ZIC9faXo8gZc7gogCIIUraSBHwzETGSBGFH6IR0CVF2gJyp0jsWMHVOLS3F0cTRM0kLfDf3Yiwh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PYlsRpYi; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744706607; x=1776242607;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bqVy4cE5Zj6YhNLsiG6Ni3/flTkFOehuJyaTktuTw8U=;
  b=PYlsRpYiSNNdOgkKJ0Y2RaKkE0SSWeMxxSNcLtIEykO0m57Asl7iiJjZ
   jLGxrUPc/nTX5ybHo5Hdq5vVtwbIXb0aEfT4Slm+T9LPOBwgOSXX3x/BB
   HOG3pswZOMUNqFcbDF7i+FKWPHVE3WZuq37k2+GsZsAiLlnFiRdnITv1b
   sTNpE6vdzte7hGgqZFwy1Uj2BbyYmJzORa6+CAILU2CNM1SL/gmduqTTk
   9eNKDnDlvjGfbVyzskBQMo1fKCS0GzkNbaIvHTlsFmarsEtP8uRieAy+K
   +mptbK9SdT7ayiwcCfCI9MK/hxD1tUD5jAPlD6gs2sLus+sDdhO+5OGhf
   g==;
X-CSE-ConnectionGUID: 78cmM3JyTte1z+ahX+cECg==
X-CSE-MsgGUID: XtPQZG5VTw2PYc1X/7+bBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="46333922"
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="46333922"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 01:42:20 -0700
X-CSE-ConnectionGUID: HnqHzjShTlKUyNcLOiNO1g==
X-CSE-MsgGUID: mBmnoFvZTgaMt8H91teEdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="129827887"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 01:42:16 -0700
Date: Tue, 15 Apr 2025 10:41:58 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Henry Martin <bsdhenrymartin@gmail.com>
Cc: saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
	netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	amirtz@nvidia.com, ayal@nvidia.com, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] net/mlx5: Fix null-ptr-deref in
 mlx5_create_{inner_,}ttc_table()
Message-ID: <Z/4b1hUpp6FMjfR9@mev-dev.igk.intel.com>
References: <20250411131431.46537-1-bsdhenrymartin@gmail.com>
 <20250411131431.46537-2-bsdhenrymartin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411131431.46537-2-bsdhenrymartin@gmail.com>

On Fri, Apr 11, 2025 at 09:14:31PM +0800, Henry Martin wrote:
> Add NULL check for mlx5_get_flow_namespace() returns in
> mlx5_create_inner_ttc_table() and mlx5_create_ttc_table() to prevent
> NULL pointer dereference.
> 
> Fixes: 137f3d50ad2a ("net/mlx5: Support matching on l4_type for ttc_table")
> Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
> ---
> V3 -> V4: Fix potential memory leak.
> V2 -> V3: No functional changes, just gathering the patches in a series.
> V1 -> V2: Add a empty line after the return statement.
> 
>  drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c
> index eb3bd9c7f66e..077fe908bf86 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c
> @@ -651,10 +651,16 @@ struct mlx5_ttc_table *mlx5_create_inner_ttc_table(struct mlx5_core_dev *dev,
>  			MLX5_CAP_NIC_RX_FT_FIELD_SUPPORT_2(dev, inner_l4_type);
>  		break;
>  	default:
> +		kvfree(ttc);
>  		return ERR_PTR(-EINVAL);
>  	}
>  
>  	ns = mlx5_get_flow_namespace(dev, params->ns_type);
> +	if (!ns) {
> +		kvfree(ttc);
> +		return ERR_PTR(-EOPNOTSUPP);
> +	}
> +
>  	groups = use_l4_type ? &inner_ttc_groups[TTC_GROUPS_USE_L4_TYPE] :
>  			       &inner_ttc_groups[TTC_GROUPS_DEFAULT];
>  
> @@ -724,10 +730,16 @@ struct mlx5_ttc_table *mlx5_create_ttc_table(struct mlx5_core_dev *dev,
>  			MLX5_CAP_NIC_RX_FT_FIELD_SUPPORT_2(dev, outer_l4_type);
>  		break;
>  	default:
> +		kvfree(ttc);
>  		return ERR_PTR(-EINVAL);
>  	}
>  
>  	ns = mlx5_get_flow_namespace(dev, params->ns_type);
> +	if (!ns){
> +		kvfree(ttc);
> +		return ERR_PTR(-EOPNOTSUPP);
> +	}
> +
>  	groups = use_l4_type ? &ttc_groups[TTC_GROUPS_USE_L4_TYPE] :
>  			       &ttc_groups[TTC_GROUPS_DEFAULT];

Thanks for addressing leak
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

>  
> -- 
> 2.34.1

