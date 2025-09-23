Return-Path: <linux-rdma+bounces-13594-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC2DB95F4F
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Sep 2025 15:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3E273ADEB2
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Sep 2025 13:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81641326D6C;
	Tue, 23 Sep 2025 13:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uxTvbuAS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1844F326D4D;
	Tue, 23 Sep 2025 13:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758633013; cv=none; b=tvqqANh4LDHzfJJxwzv+vL+aSCHmIMqc7fuZQJokEap3XUsEnXSB5eVaaz+JtkvatQfgjTjrONMaCNV5Cm2P98BN2r71CkQt2LWiVIzJGcPy4NZ6ZBdrq6PxTCwg3ccVmiOUJSa6+MD+9dBnAnewzx++Yn/NibP/4mYR3z+2BFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758633013; c=relaxed/simple;
	bh=3eTEM5iteMPKpUUiayTkYaX7myBwc3OUeGnJqH5onNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N9ERFZwc8Z0d8l6tnfAoOveYBYPiFMSuMYM9bIycb8Pq68WAqf1Z8EIYquW5S9j5XRiIVH7fDE0XuSFAvCryvNS9RZcylNhcNv/PaNX6vLX2OP+NlERqN7uEWqBK5FZXGXvo49txG3INvcIcDX/m27oVfb6+X3YlhWUS+tzlAz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uxTvbuAS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EAC7C4CEF5;
	Tue, 23 Sep 2025 13:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758633011;
	bh=3eTEM5iteMPKpUUiayTkYaX7myBwc3OUeGnJqH5onNw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uxTvbuASkvlEqAuHBYNx3FhRWzQd1sr6u8f3MwHB20Eeci9+PGh1yQh1c525P7zi6
	 tFvlD4NIm8Xl+43c58KqPIREiZAi7/IwK9hqLgKGIizsJR5+BmmrXUkTA9we+Lq8iz
	 A0GP3mUWKZNPlybZwogmBOUnZdeFY/q6JIKSnj1EblWryF7L07UEk8Id9yeqiY3QER
	 oxGlbFTUtLEO2Pv+ItLS24AgG0Btp3gz2FNrn0rqSnPBqOc8XJYpX7lUzOUY2mJhMV
	 yTEan4n/dV1S2/X4ebR7ShUPVsYa3gm0W2mFLvAcJAA2+2Jrpv1XnAZrlL6d/ou1Xb
	 gzvb7Y2FQ+J/w==
Date: Tue, 23 Sep 2025 14:10:06 +0100
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next 2/2] net/mlx5e: Clamp page_pool size to max
Message-ID: <20250923131006.GK836419@horms.kernel.org>
References: <1758532715-820422-1-git-send-email-tariqt@nvidia.com>
 <1758532715-820422-3-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1758532715-820422-3-git-send-email-tariqt@nvidia.com>

On Mon, Sep 22, 2025 at 12:18:35PM +0300, Tariq Toukan wrote:
> From: Dragos Tatulea <dtatulea@nvidia.com>
> 
> When the user configures a large ring size (8K) and a large MTU (9000)
> in HW-GRO mode, the queue will fail to allocate due to the size of the
> page_pool going above the limit.
> 
> This change clamps the pool_size to the limit.
> 
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> index 5e007bb3bad1..e56052895776 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> @@ -989,6 +989,8 @@ static int mlx5e_alloc_rq(struct mlx5e_params *params,
>  		/* Create a page_pool and register it with rxq */
>  		struct page_pool_params pp_params = { 0 };
>  
> +		pool_size = min_t(u32, pool_size, PAGE_POOL_SIZE_LIMIT);

pool_size is u32 and PAGE_POOL_SIZE_LIMIT is a constant.
AFAIK min() would work just fine here.

> +
>  		pp_params.order     = 0;
>  		pp_params.flags     = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
>  		pp_params.pool_size = pool_size;
> -- 
> 2.31.1
> 
> 

