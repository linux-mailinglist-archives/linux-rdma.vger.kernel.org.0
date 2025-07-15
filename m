Return-Path: <linux-rdma+bounces-12180-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04BA3B05319
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Jul 2025 09:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35A5A18852D0
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Jul 2025 07:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5717D273802;
	Tue, 15 Jul 2025 07:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="elt+2Xm6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8255526E717;
	Tue, 15 Jul 2025 07:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752564050; cv=none; b=WfO8AS63iGVzvEfLTC+oVxnBrvMKyM40iTnBT4GOIGLn/HXlUYzHqgontPpC69yiPO0YhnDGwZZOl5okHsMmIh+CQRu+VKN//fyTu6nXHuf087hbhRkUO1iE6xLT2EB5hTCHX6S0cCxhU3wQn4dijtLjuFetonb0NssBWBzkmGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752564050; c=relaxed/simple;
	bh=Ppuj0YnhCgF5zqOKQXUOZ7Q3+Bjzdmw1GnEY8EnTnjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XKI2paO21WdlMA4tPsar6LLxs3ZhtLVh/9b9pS83U2U/sNisIrkfIbLbly7TPXrYeBE93oDMsIVV1CPJYMshRt4ukjaL3eP9fBz+uxYQFcYRndS6UGgEg6CsB9zTbACC2qYYFcQ8oHRLHKSD7p1AZJxp27xrcf2yxStt+Wi7Jls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=elt+2Xm6; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752564048; x=1784100048;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ppuj0YnhCgF5zqOKQXUOZ7Q3+Bjzdmw1GnEY8EnTnjA=;
  b=elt+2Xm6MhLVL0j7YWaXcmUKR/onm04flHXe2lLDZm+o7ipryjx1S3Ky
   v+JSixi+cJPC/gGzlbv0lWpZS1ylPQQ/j1VBjSeCuA23AA3W9QDQ9EItO
   2ONa2KNVt6IWuHBGvu8SbPAESggUKzO9tuk+v/vQ1MAg44BJWR3U+NXq0
   3yusYrUfP/o2/LMutgZ2teDPQMS86ZMGwPUsFL/fPmIU8HqKzCIcb1HjK
   K/JaBpXh7egre5LFaa8C1Ts+1yWnNcz4X1c8Ru2rY1QHXyPdoTjTduypU
   QJ4/bn0PWqT1IVnz4PZ+yOFQo9Em8QbgzGwVn49RaDW0GBLI5K3gVznwM
   Q==;
X-CSE-ConnectionGUID: AHiX0WULS1egCZwWtCReBw==
X-CSE-MsgGUID: D8bc15Q1STei1QRfLgqrQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="72222957"
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="72222957"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 00:20:48 -0700
X-CSE-ConnectionGUID: 8nQrrZa7SjSh5n+8L/DcPA==
X-CSE-MsgGUID: nsnlIOacTIW5SgLxfcCMFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="161171117"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 00:20:44 -0700
Date: Tue, 15 Jul 2025 09:19:18 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeed@kernel.org>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, Lama Kayal <lkayal@nvidia.com>
Subject: Re: [PATCH net-next 5/6] net/mlx5e: SHAMPO, Remove
 mlx5e_shampo_get_log_hd_entry_size()
Message-ID: <aHYA563HefYzTxkt@mev-dev.igk.intel.com>
References: <1752471585-18053-1-git-send-email-tariqt@nvidia.com>
 <1752471585-18053-6-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1752471585-18053-6-git-send-email-tariqt@nvidia.com>

On Mon, Jul 14, 2025 at 08:39:44AM +0300, Tariq Toukan wrote:
> From: Lama Kayal <lkayal@nvidia.com>
> 
> Refactor mlx5e_shampo_get_log_hd_entry_size() as macro, for more
> simplicity.
> 
> Signed-off-by: Lama Kayal <lkayal@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en.h        | 2 +-
>  drivers/net/ethernet/mellanox/mlx5/core/en/params.c | 9 ++-------
>  drivers/net/ethernet/mellanox/mlx5/core/en/params.h | 2 --
>  3 files changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
> index 019bc6ca4455..22098c852570 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
> @@ -84,7 +84,7 @@ struct page_pool;
>  #define MLX5E_SHAMPO_LOG_MAX_HEADER_ENTRY_SIZE (9)
>  #define MLX5E_SHAMPO_WQ_HEADER_PER_PAGE (PAGE_SIZE >> MLX5E_SHAMPO_LOG_MAX_HEADER_ENTRY_SIZE)
>  #define MLX5E_SHAMPO_LOG_WQ_HEADER_PER_PAGE (PAGE_SHIFT - MLX5E_SHAMPO_LOG_MAX_HEADER_ENTRY_SIZE)
> -#define MLX5E_SHAMPO_WQ_BASE_HEAD_ENTRY_SIZE (64)
> +#define MLX5E_SHAMPO_WQ_BASE_HEAD_ENTRY_SIZE_SHIFT (6)
>  #define MLX5E_SHAMPO_WQ_RESRV_SIZE_BASE_SHIFT (12)
>  #define MLX5E_SHAMPO_WQ_LOG_RESRV_SIZE (16)
>  #define MLX5E_SHAMPO_WQ_RESRV_SIZE BIT(MLX5E_SHAMPO_WQ_LOG_RESRV_SIZE)
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
> index 616251ec6d69..de5c97ea4dd8 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
> @@ -414,12 +414,6 @@ u8 mlx5e_mpwqe_get_log_rq_size(struct mlx5_core_dev *mdev,
>  	return params->log_rq_mtu_frames - log_pkts_per_wqe;
>  }
>  
> -u8 mlx5e_shampo_get_log_hd_entry_size(struct mlx5_core_dev *mdev,
> -				      struct mlx5e_params *params)
> -{
> -	return order_base_2(DIV_ROUND_UP(MLX5E_RX_MAX_HEAD, MLX5E_SHAMPO_WQ_BASE_HEAD_ENTRY_SIZE));
> -}
> -
>  static u8 mlx5e_shampo_get_log_pkt_per_rsrv(struct mlx5e_params *params)
>  {
>  	return order_base_2(DIV_ROUND_UP(MLX5E_SHAMPO_WQ_RESRV_SIZE,
> @@ -928,7 +922,8 @@ int mlx5e_build_rq_param(struct mlx5_core_dev *mdev,
>  			 log_max_num_of_packets_per_reservation,
>  			 mlx5e_shampo_get_log_pkt_per_rsrv(params));
>  		MLX5_SET(wq, wq, log_headers_entry_size,
> -			 mlx5e_shampo_get_log_hd_entry_size(mdev, params));
> +			 MLX5E_SHAMPO_LOG_HEADER_ENTRY_SIZE -
> +			 MLX5E_SHAMPO_WQ_BASE_HEAD_ENTRY_SIZE_SHIFT);

We had 2 here, now it is 8 - 6, so it is fine, it wasn't obvious for me.
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

>  		lro_timeout =
>  			mlx5e_choose_lro_timeout(mdev,
>  						 MLX5E_DEFAULT_SHAMPO_TIMEOUT);
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.h b/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
> index 919895f64dcd..488ccdbc1e2c 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
> @@ -95,8 +95,6 @@ bool mlx5e_rx_mpwqe_is_linear_skb(struct mlx5_core_dev *mdev,
>  u8 mlx5e_mpwqe_get_log_rq_size(struct mlx5_core_dev *mdev,
>  			       struct mlx5e_params *params,
>  			       struct mlx5e_xsk_param *xsk);
> -u8 mlx5e_shampo_get_log_hd_entry_size(struct mlx5_core_dev *mdev,
> -				      struct mlx5e_params *params);
>  u32 mlx5e_shampo_hd_per_wqe(struct mlx5_core_dev *mdev,
>  			    struct mlx5e_params *params,
>  			    struct mlx5e_rq_param *rq_param);
> -- 
> 2.40.1
> 

