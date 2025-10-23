Return-Path: <linux-rdma+bounces-14017-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A38F2C01400
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Oct 2025 15:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4F7BB35A701
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Oct 2025 13:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CA7307AC2;
	Thu, 23 Oct 2025 13:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VcGOfBNW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830D723BCE7;
	Thu, 23 Oct 2025 13:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761224549; cv=none; b=mbBw3v7DK4g9JRmh9vp4EXpl+m42hRAhFuW7boO/B+8LxLgyO/aFCstT+TlWdCXoa67FJ/Y4xPDp1KBRU4dkxeoB5swgOAWFkm6CBJ8Sp3BakIJez3eX594amM8+V+sA7bDhRw+xIlCl0H73IqEK3R8BXqB4iVOgFUTzUcw5bOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761224549; c=relaxed/simple;
	bh=tlVYSp4/Djow8v67w0FTIRaAwQH7I1na0HdiYU3lqnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ltznqdmakX+pivCRhddBFiN51sz4sQTASqNqpktoFc4EfS5cA08fMamPF7TP/b6XB8DDWBe/KwZLQakcT4qm9Hv5PNNs5PFm3AXv6h1fcHm8on2oNgvT9rfWO64/r9QYW8Da3RO2JZIsrWR8PfPyZhNsW7nJTgg/ECE50vhlHSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VcGOfBNW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40B68C4CEE7;
	Thu, 23 Oct 2025 13:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761224549;
	bh=tlVYSp4/Djow8v67w0FTIRaAwQH7I1na0HdiYU3lqnE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VcGOfBNWX8RhzbS+aZPb0kJhScNc0qxvmkmNZ21JXOuVOKuagU2l9YJAFVNKgjRuM
	 DtL/h67JRs7wMbk+hdTtM3sXAUHEc4GirCc46ACMEqFXkk76ctiMTY1hZRzAW3WhAX
	 nG89A280F/APguWk9a1EFesQ0ttQqiM+qVl4odqL7RZ+ls+440J51J6ZtXqkZzA0EK
	 6ltLF58PJmr7bcPHWh/2EEoAIm/9cVS4TTddqZroyvPGHVWdmSQGeJYgmy3nOrUBI6
	 AAtzXM0iedqZeXNr7vETswmKzoXB95IQGKA8JedkrEpi05ioL7A8+9nv/tVrCw1eMI
	 anlld4sOedYhQ==
Date: Thu, 23 Oct 2025 14:02:24 +0100
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
	Carolina Jubran <cjubran@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next 2/7] net/mlx5e: Use TIR API in
 mlx5e_modify_tirs_lb()
Message-ID: <aPonYFV1S4N5COKZ@horms.kernel.org>
References: <1761201820-923638-1-git-send-email-tariqt@nvidia.com>
 <1761201820-923638-3-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1761201820-923638-3-git-send-email-tariqt@nvidia.com>

On Thu, Oct 23, 2025 at 09:43:35AM +0300, Tariq Toukan wrote:

...

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tir.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tir.c
> index 19499072f67f..0b55e77f19c8 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/tir.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tir.c
> @@ -146,6 +146,31 @@ void mlx5e_tir_builder_build_direct(struct mlx5e_tir_builder *builder)
>  	MLX5_SET(tirc, tirc, rx_hash_fn, MLX5_RX_HASH_FN_INVERTED_XOR8);
>  }
>  
> +static void mlx5e_tir_context_self_lb_block(void *tirc, bool enable_uc_lb,
> +					    bool enable_mc_lb)
> +{
> +	u8 lb_flags = 0;
> +
> +	if (enable_uc_lb)
> +		lb_flags = MLX5_TIRC_SELF_LB_BLOCK_BLOCK_UNICAST;
> +	if (enable_mc_lb)
> +		lb_flags |= MLX5_TIRC_SELF_LB_BLOCK_BLOCK_MULTICAST;
> +
> +	MLX5_SET(tirc, tirc, self_lb_block, lb_flags);
> +}
> +
> +void mlx5e_tir_builder_build_self_lb_block(struct mlx5e_tir_builder *builder,
> +					   bool enable_uc_lb,
> +					   bool enable_mc_lb)
> +{
> +	void *tirc = mlx5e_tir_builder_get_tirc(builder);
> +
> +	if (builder->modify)
> +		MLX5_SET(modify_tir_in, builder->in, bitmask.self_lb_en, 1);
> +
> +	mlx5e_tir_context_self_lb_block(tirc, enable_uc_lb, enable_mc_lb);
> +}
> +

...

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_common.c b/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
> index 376a018b2db1..fad6b761f622 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
> @@ -250,43 +250,30 @@ void mlx5e_destroy_mdev_resources(struct mlx5_core_dev *mdev)
>  int mlx5e_modify_tirs_lb(struct mlx5_core_dev *mdev, bool enable_uc_lb,
>  			 bool enable_mc_lb)

...

> -	if (enable_uc_lb)
> -		lb_flags = MLX5_TIRC_SELF_LB_BLOCK_BLOCK_UNICAST;
> -
> -	if (enable_mc_lb)
> -		lb_flags |= MLX5_TIRC_SELF_LB_BLOCK_BLOCK_MULTICAST;
> -
> -	if (lb_flags)
> -		MLX5_SET(modify_tir_in, in, ctx.self_lb_block, lb_flags);
> -
> -	MLX5_SET(modify_tir_in, in, bitmask.self_lb_en, 1);
> +	mlx5e_tir_builder_build_self_lb_block(builder, enable_uc_lb,
> +					      enable_mc_lb);

Hi,

Maybe I'm reading this wrong, and possibly it is not important,
but it seems to me that the update above reverses the

...
order of the MLX5_SET() invocations.

