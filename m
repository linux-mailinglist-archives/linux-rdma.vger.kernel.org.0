Return-Path: <linux-rdma+bounces-8932-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2C0A7033B
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Mar 2025 15:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32FF6188B764
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Mar 2025 14:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B70D2594B7;
	Tue, 25 Mar 2025 14:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hnDM9VFY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4450D2580C6;
	Tue, 25 Mar 2025 14:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742911477; cv=none; b=mb+R9cwP9nz1Orx5StKaRWwM5mOmZ9Z9wgJYzBZFjiFIw/h8g86+8tuUz1h8qEZbsBYBt1SDpfiJWm1L12WzVCeThI7hesq/CxfGcxzE4n14+LgsRsAvmwN4ITgBXAW0tIlLWDQfnapKjh0PvpampAv9kKBbPBd0dzA2o/lWzw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742911477; c=relaxed/simple;
	bh=eCpGgKH/0DbjMToSuoCrDG9Ex54recEd4ZozNnXJgME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JzKPKl1tetGK//VOUfYMxMkCA94kqbK6cKUyiEUsrtyozrwwUoYPZlzOFj0TUwW9PBaS4sa2SVowrM501WUh+rgSz5Vdq1Sf+6XrecHyATA0A3E2cSjoxLlYm+EPbcEKxnwmP0ngAJx+0z8/+W2bKpIJLaOrEBwzLg1ydBf6mOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hnDM9VFY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C287DC4CEE4;
	Tue, 25 Mar 2025 14:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742911476;
	bh=eCpGgKH/0DbjMToSuoCrDG9Ex54recEd4ZozNnXJgME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hnDM9VFY3BM2X5/OB0pfHu6tS/xTWJ/UGTjmPuWI26voXM+eVxvwYHzeKZCnGwZfB
	 8EXIXrA1OjVINWM2ZswXBkeg/M0N8cwBvYCRxU9Mchkdl8ufsjxJiSzQQrUg/GshHc
	 GfjCpT2YkUuVwL9FmTGbSalzLQfsYPJH3x/TP2+KJXXj0MKLYqg7tGfnDID2bmwiD/
	 vV/rIYRJ7jAV6zLjeyf+qL7bfpP41SeAHkNSauQ8HauheSh/zN2ZNgnXm8FVV4ThjX
	 K8rOVMd+we4Uv4ux2VjM/4k92e8fh1SHwPZZnbgEmvreh2LGeR1Vo6DfwkWW3oCYzY
	 Z8uCBsql9PGqg==
Date: Tue, 25 Mar 2025 14:04:31 +0000
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Moshe Shemesh <moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Lama Kayal <lkayal@nvidia.com>
Subject: Re: [PATCH net] net/mlx5e: SHAMPO, Make reserved size independent of
 page size
Message-ID: <20250325140431.GQ892515@horms.kernel.org>
References: <1742732906-166564-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1742732906-166564-1-git-send-email-tariqt@nvidia.com>

On Sun, Mar 23, 2025 at 02:28:26PM +0200, Tariq Toukan wrote:
> From: Lama Kayal <lkayal@nvidia.com>
> 
> When hw-gro is enabled, the maximum number of header entries that are
> needed per wqe (hd_per_wqe) is calculated based on the size of the
> reservations among other parameters.
> 
> Miscalculation of the size of reservations leads to incorrect
> calculation of hd_per_wqe as 0, particularly in the case of large page
> size like in aarch64, this prevents the SHAMPO header from being
> correctly initialized in the device, ultimately causing the following
> cqe err that indicates a violation of PD.

Hi Lama, Tariq, all,

If I understand things correctly, hd_per_wqe is calculated
in mlx5e_shampo_hd_per_wqe() like this:

u32 mlx5e_shampo_hd_per_wqe(struct mlx5_core_dev *mdev,
                            struct mlx5e_params *params,                                                    struct mlx5e_rq_param *rq_param)
{
        int resv_size = BIT(mlx5e_shampo_get_log_rsrv_size(mdev, params)) * PAGE_SIZE;
        u16 num_strides = BIT(mlx5e_mpwqe_get_log_num_strides(mdev, params, NULL));
        int pkt_per_resv = BIT(mlx5e_shampo_get_log_pkt_per_rsrv(mdev, params));
        u8 log_stride_sz = mlx5e_mpwqe_get_log_stride_size(mdev, params, NULL);
        int wqe_size = BIT(log_stride_sz) * num_strides;                                u32 hd_per_wqe;

        /* Assumption: hd_per_wqe % 8 == 0. */
        hd_per_wqe = (wqe_size / resv_size) * pkt_per_resv;                             mlx5_core_dbg(mdev, "%s hd_per_wqe = %d rsrv_size = %d wqe_size = %d pkt_per_resv = %d\n",                                                                                    __func__, hd_per_wqe, resv_size, wqe_size, pkt_per_resv);
        return hd_per_wqe;
}

I can see that if PAGE_SIZE was some multiple of 4k, and thus
larger than wqe_size, then this could lead to hd_per_wqe being zero.

But I note that mlx5e_mpwqe_get_log_stride_size() may return PAGE_SHIFT.
And I wonder if that leads to wqe_size being larger than expected by this
patch in cases where the PAGE_SIZE is greater than 4k.

Likewise in mlx5e_shampo_get_log_cq_size(), which seems to have a large overlap
codewise with mlx5e_shampo_hd_per_wqe().

> 
>  mlx5_core 0000:00:08.0 eth2: ERR CQE on RQ: 0x1180
>  mlx5_core 0000:00:08.0 eth2: Error cqe on cqn 0x510, ci 0x0, qn 0x1180, opcode 0xe, syndrome  0x4, vendor syndrome 0x32
>  00000000: 00 00 00 00 04 4a 00 00 00 00 00 00 20 00 93 32
>  00000010: 55 00 00 00 fb cc 00 00 00 00 00 00 07 18 00 00
>  00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 4a
>  00000030: 00 00 00 9a 93 00 32 04 00 00 00 00 00 00 da e1
> 
> Use the correct formula for calculating the size of reservations,
> precisely it shouldn't be dependent on page size, instead use the
> correct multiply of MLX5E_SHAMPO_WQ_BASE_RESRV_SIZE.
> 
> Fixes: e5ca8fb08ab2 ("net/mlx5e: Add control path for SHAMPO feature")
> Signed-off-by: Lama Kayal <lkayal@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en/params.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
> index 64b62ed17b07..31eb99f09c63 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
> @@ -423,7 +423,7 @@ u8 mlx5e_shampo_get_log_pkt_per_rsrv(struct mlx5_core_dev *mdev,
>  				     struct mlx5e_params *params)
>  {
>  	u32 resrv_size = BIT(mlx5e_shampo_get_log_rsrv_size(mdev, params)) *
> -			 PAGE_SIZE;
> +			 MLX5E_SHAMPO_WQ_BASE_RESRV_SIZE;
>  
>  	return order_base_2(DIV_ROUND_UP(resrv_size, params->sw_mtu));
>  }
> @@ -827,7 +827,8 @@ static u32 mlx5e_shampo_get_log_cq_size(struct mlx5_core_dev *mdev,
>  					struct mlx5e_params *params,
>  					struct mlx5e_xsk_param *xsk)
>  {
> -	int rsrv_size = BIT(mlx5e_shampo_get_log_rsrv_size(mdev, params)) * PAGE_SIZE;
> +	int rsrv_size = BIT(mlx5e_shampo_get_log_rsrv_size(mdev, params)) *
> +		MLX5E_SHAMPO_WQ_BASE_RESRV_SIZE;
>  	u16 num_strides = BIT(mlx5e_mpwqe_get_log_num_strides(mdev, params, xsk));
>  	int pkt_per_rsrv = BIT(mlx5e_shampo_get_log_pkt_per_rsrv(mdev, params));
>  	u8 log_stride_sz = mlx5e_mpwqe_get_log_stride_size(mdev, params, xsk);
> @@ -1036,7 +1037,8 @@ u32 mlx5e_shampo_hd_per_wqe(struct mlx5_core_dev *mdev,
>  			    struct mlx5e_params *params,
>  			    struct mlx5e_rq_param *rq_param)
>  {
> -	int resv_size = BIT(mlx5e_shampo_get_log_rsrv_size(mdev, params)) * PAGE_SIZE;
> +	int resv_size = BIT(mlx5e_shampo_get_log_rsrv_size(mdev, params)) *
> +		MLX5E_SHAMPO_WQ_BASE_RESRV_SIZE;
>  	u16 num_strides = BIT(mlx5e_mpwqe_get_log_num_strides(mdev, params, NULL));
>  	int pkt_per_resv = BIT(mlx5e_shampo_get_log_pkt_per_rsrv(mdev, params));
>  	u8 log_stride_sz = mlx5e_mpwqe_get_log_stride_size(mdev, params, NULL);
> 
> base-commit: ed3ba9b6e280e14cc3148c1b226ba453f02fa76c
> -- 
> 2.31.1
> 
> 

