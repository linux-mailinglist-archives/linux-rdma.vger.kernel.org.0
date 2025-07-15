Return-Path: <linux-rdma+bounces-12178-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D14B05273
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Jul 2025 09:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F7C51AA55AF
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Jul 2025 07:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8E126D4F9;
	Tue, 15 Jul 2025 07:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CqksxLSW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2461F0E47;
	Tue, 15 Jul 2025 07:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752563571; cv=none; b=FxqAAx6ko9WPJfWTCHf/KdMoxXVl+RtpKW+/MqZGufi5ehV4hnmBr/EVqa7fNNTbsQCiyPWd82R/36L1/IfXYMMwZJL8ZpqTpzl7iz74wKj3Skk72efxpUGN7f9is4MnqxUJaV6aUqkZGUYdIM1AjhdUAS44rpUJoz+mqn7uYGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752563571; c=relaxed/simple;
	bh=rZPRty/lSCX5vm6yrv0Hu71JqpZY3WP2TgGV7xhvpYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hYh/7V9cVtz1jP9rf8MD1SDwCoyUd/NDGKXUEnQSQgvxt1bl2L317ohN99sX/RxEFoLKiFo+zoHfLEl9X6Lh2hMOg4DXv8gfBaxbo6RS+tETVpqrNLCmgPckSvITwc/3db2pVw59GeG9vI+bdIBd8JogyDYhcLGGQcBjf7iHBCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CqksxLSW; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752563569; x=1784099569;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rZPRty/lSCX5vm6yrv0Hu71JqpZY3WP2TgGV7xhvpYY=;
  b=CqksxLSWCJE1i4581AZuXU0cPRC6Eh2JVFT1hoEeLAO/8Nfeitf/Nyfu
   CYNGZcEroAVrnx6yLs4vzreBNRGp7EB31BTMFnoXERX1X3rk4NzTffK7x
   0Wq2Zo/uQYnutozYZ+wFsqBi/ZhWfsfHxMqsi5Syp18tk5Q8pSNkvO+ds
   uilTaXPN4PoXh0KBGHAlW2S9U+KLLlI0b828t4PUdGfNLjAPoTkPwx2tI
   vNBWaXuxEKdR0BqVAVI1sHwe/0x8nYBKJ8Z6RzkIuVvCmW44rbJO4LPlf
   HHsfRmM+zR/K6Q6NOFrXh5zaIGcH4BHE2MopM9w9FspxzxCk02ttxUAlj
   g==;
X-CSE-ConnectionGUID: n6hTX3vHS6eul1PT+nFWrw==
X-CSE-MsgGUID: VcRguCZhQoKyI1qK5tmQXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54744391"
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="54744391"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 00:12:48 -0700
X-CSE-ConnectionGUID: 6Ae7C+vXQjqMjY7x8zb8Fw==
X-CSE-MsgGUID: BtQsFqauS320gUsLpOn0xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="162693322"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 00:12:44 -0700
Date: Tue, 15 Jul 2025 09:11:40 +0200
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
Subject: Re: [PATCH net-next 4/6] net/mlx5e: SHAMPO, Cleanup reservation size
 formula
Message-ID: <aHX/LMSuUBG3X5Ph@mev-dev.igk.intel.com>
References: <1752471585-18053-1-git-send-email-tariqt@nvidia.com>
 <1752471585-18053-5-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1752471585-18053-5-git-send-email-tariqt@nvidia.com>

On Mon, Jul 14, 2025 at 08:39:43AM +0300, Tariq Toukan wrote:
> From: Lama Kayal <lkayal@nvidia.com>
> 
> The reservation size formula can be reduced to a simple evaluation of
> MLX5E_SHAMPO_WQ_RESRV_SIZE. This leaves mlx5e_shampo_get_log_rsrv_size()
> with one single use, which can be replaced with a macro for simplicity.
> 
> Also, function mlx5e_shampo_get_log_rsrv_size() is used only throughout
> params.c, make it static.
> 
> Signed-off-by: Lama Kayal <lkayal@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en.h  |  5 +--
>  .../ethernet/mellanox/mlx5/core/en/params.c   | 34 +++++++------------
>  .../ethernet/mellanox/mlx5/core/en/params.h   |  4 ---
>  3 files changed, 15 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
> index 64e69e616b1f..019bc6ca4455 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
> @@ -85,8 +85,9 @@ struct page_pool;
>  #define MLX5E_SHAMPO_WQ_HEADER_PER_PAGE (PAGE_SIZE >> MLX5E_SHAMPO_LOG_MAX_HEADER_ENTRY_SIZE)
>  #define MLX5E_SHAMPO_LOG_WQ_HEADER_PER_PAGE (PAGE_SHIFT - MLX5E_SHAMPO_LOG_MAX_HEADER_ENTRY_SIZE)
>  #define MLX5E_SHAMPO_WQ_BASE_HEAD_ENTRY_SIZE (64)
> -#define MLX5E_SHAMPO_WQ_RESRV_SIZE (64 * 1024)
> -#define MLX5E_SHAMPO_WQ_BASE_RESRV_SIZE (4096)
> +#define MLX5E_SHAMPO_WQ_RESRV_SIZE_BASE_SHIFT (12)
> +#define MLX5E_SHAMPO_WQ_LOG_RESRV_SIZE (16)
> +#define MLX5E_SHAMPO_WQ_RESRV_SIZE BIT(MLX5E_SHAMPO_WQ_LOG_RESRV_SIZE)
>  
>  #define MLX5_MPWRQ_MIN_LOG_STRIDE_SZ(mdev) \
>  	(6 + MLX5_CAP_GEN(mdev, cache_line_128byte)) /* HW restriction */
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
> index fc945bce933a..616251ec6d69 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c

[...]

>  
>  u8 mlx5e_mpwqe_get_log_stride_size(struct mlx5_core_dev *mdev,
> @@ -834,10 +825,9 @@ static u32 mlx5e_shampo_get_log_cq_size(struct mlx5_core_dev *mdev,
>  					struct mlx5e_params *params,
>  					struct mlx5e_xsk_param *xsk)
>  {
> -	int rsrv_size = BIT(mlx5e_shampo_get_log_rsrv_size(mdev, params)) *
> -		MLX5E_SHAMPO_WQ_BASE_RESRV_SIZE;
> +	int rsrv_size = MLX5E_SHAMPO_WQ_RESRV_SIZE;

Broken RCT, you can use MLX5E_SHAMPO_WQ_RESRV_SIZE directly in
order_base_2() call.

>  	u16 num_strides = BIT(mlx5e_mpwqe_get_log_num_strides(mdev, params, xsk));
> -	int pkt_per_rsrv = BIT(mlx5e_shampo_get_log_pkt_per_rsrv(mdev, params));
> +	int pkt_per_rsrv = BIT(mlx5e_shampo_get_log_pkt_per_rsrv(params));
>  	u8 log_stride_sz = mlx5e_mpwqe_get_log_stride_size(mdev, params, xsk);
>  	int wq_size = BIT(mlx5e_mpwqe_get_log_rq_size(mdev, params, xsk));
>  	int wqe_size = BIT(log_stride_sz) * num_strides;
> @@ -932,10 +922,11 @@ int mlx5e_build_rq_param(struct mlx5_core_dev *mdev,
>  
>  		MLX5_SET(wq, wq, shampo_enable, true);
>  		MLX5_SET(wq, wq, log_reservation_size,
> -			 mlx5e_shampo_get_log_rsrv_size(mdev, params));
> +			 MLX5E_SHAMPO_WQ_LOG_RESRV_SIZE -
> +			 MLX5E_SHAMPO_WQ_RESRV_SIZE_BASE_SHIFT);
>  		MLX5_SET(wq, wq,
>  			 log_max_num_of_packets_per_reservation,
> -			 mlx5e_shampo_get_log_pkt_per_rsrv(mdev, params));
> +			 mlx5e_shampo_get_log_pkt_per_rsrv(params));
>  		MLX5_SET(wq, wq, log_headers_entry_size,
>  			 mlx5e_shampo_get_log_hd_entry_size(mdev, params));
>  		lro_timeout =
> @@ -1048,18 +1039,17 @@ u32 mlx5e_shampo_hd_per_wqe(struct mlx5_core_dev *mdev,
>  			    struct mlx5e_params *params,
>  			    struct mlx5e_rq_param *rq_param)
>  {
> -	int resv_size = BIT(mlx5e_shampo_get_log_rsrv_size(mdev, params)) *
> -		MLX5E_SHAMPO_WQ_BASE_RESRV_SIZE;
> +	int rsrv_size = MLX5E_SHAMPO_WQ_RESRV_SIZE;

Can be moved down to have RCT.

>  	u16 num_strides = BIT(mlx5e_mpwqe_get_log_num_strides(mdev, params, NULL));
> -	int pkt_per_resv = BIT(mlx5e_shampo_get_log_pkt_per_rsrv(mdev, params));
> +	int pkt_per_resv = BIT(mlx5e_shampo_get_log_pkt_per_rsrv(params));
>  	u8 log_stride_sz = mlx5e_mpwqe_get_log_stride_size(mdev, params, NULL);
>  	int wqe_size = BIT(log_stride_sz) * num_strides;
>  	u32 hd_per_wqe;
>  
>  	/* Assumption: hd_per_wqe % 8 == 0. */
> -	hd_per_wqe = (wqe_size / resv_size) * pkt_per_resv;
> +	hd_per_wqe = (wqe_size / rsrv_size) * pkt_per_resv;
>  	mlx5_core_dbg(mdev, "%s hd_per_wqe = %d rsrv_size = %d wqe_size = %d pkt_per_resv = %d\n",
> -		      __func__, hd_per_wqe, resv_size, wqe_size, pkt_per_resv);
> +		      __func__, hd_per_wqe, rsrv_size, wqe_size, pkt_per_resv);
>  	return hd_per_wqe;
>  }
>  
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.h b/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
> index bd5877acc5b1..919895f64dcd 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
> @@ -97,10 +97,6 @@ u8 mlx5e_mpwqe_get_log_rq_size(struct mlx5_core_dev *mdev,
>  			       struct mlx5e_xsk_param *xsk);
>  u8 mlx5e_shampo_get_log_hd_entry_size(struct mlx5_core_dev *mdev,
>  				      struct mlx5e_params *params);
> -u8 mlx5e_shampo_get_log_rsrv_size(struct mlx5_core_dev *mdev,
> -				  struct mlx5e_params *params);
> -u8 mlx5e_shampo_get_log_pkt_per_rsrv(struct mlx5_core_dev *mdev,
> -				     struct mlx5e_params *params);
>  u32 mlx5e_shampo_hd_per_wqe(struct mlx5_core_dev *mdev,
>  			    struct mlx5e_params *params,
>  			    struct mlx5e_rq_param *rq_param);

Just small nits, otherwise:
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

> -- 
> 2.40.1

