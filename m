Return-Path: <linux-rdma+bounces-175-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A25A87FF92D
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Nov 2023 19:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8EB11C20A9F
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Nov 2023 18:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B545916B;
	Thu, 30 Nov 2023 18:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ixUGTZ7o"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7183059157;
	Thu, 30 Nov 2023 18:16:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16FF6C433C7;
	Thu, 30 Nov 2023 18:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701368176;
	bh=AFEzbF1z7UbchGJ9i+iyxS5WSGhDqZAgfMLscUGThOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ixUGTZ7oZsPGSxbixIqgAqFnYOr3KAOI3I+NT5nuuTEawJg0RH/fS87lHQDueP6Il
	 7uGczCrpvITZyjgetChwz76kSpCzrrhccXsyowGiuwxgfHnS6W9Rh+T5r+QiTRSj4L
	 LVfXLjtXRMoOw7WJax/X9WYMUoyssoNTjxMMNMVYSX5sSU9Md6VnPRM6hNZaCRvySq
	 FoC47bYi5T8fxFvWN3WP5vHfPCDLwo4BofdzDmFdipGeE8dEYkRrN1lfOYhEFnKfcs
	 odXnWMQLX6LIV7PBsBWl7ASM5t/OifSjr0WKQrRNFR5vsR3bJmv9Rwgj2WCLS0elES
	 WYHqUdf4qfkgQ==
Date: Thu, 30 Nov 2023 18:16:11 +0000
From: Simon Horman <horms@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Shun Hao <shunh@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH mlx5-next 2/5] net/mlx5: Manage ICM type of SW encap
Message-ID: <20231130181611.GL32077@kernel.org>
References: <cover.1701172481.git.leon@kernel.org>
 <37dc4fd78dfa3374ff53aa602f038a2ec76eb069.1701172481.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37dc4fd78dfa3374ff53aa602f038a2ec76eb069.1701172481.git.leon@kernel.org>

On Tue, Nov 28, 2023 at 02:29:46PM +0200, Leon Romanovsky wrote:
> From: Shun Hao <shunh@nvidia.com>
> 
> Support allocate/deallocate the new SW encap ICM type memory.
> The new ICM type is used for encap context allocation managed by SW,
> instead FW. It can increase encap context maximum number and allocation
> speed
> 
> Signed-off-by: Shun Hao <shunh@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

...

> @@ -164,6 +188,13 @@ int mlx5_dm_sw_icm_alloc(struct mlx5_core_dev *dev, enum mlx5_sw_icm_type type,
>  						log_header_modify_pattern_sw_icm_size);
>  		block_map = dm->header_modify_pattern_sw_icm_alloc_blocks;
>  		break;
> +	case MLX5_SW_ICM_TYPE_SW_ENCAP:
> +		icm_start_addr = MLX5_CAP64_DEV_MEM(dev,
> +						    indirect_encap_sw_icm_start_address);
> +		log_icm_size = MLX5_CAP_DEV_MEM(dev,
> +						log_indirect_encap_sw_icm_size);
> +		block_map = dm->header_encap_sw_icm_alloc_blocks;
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -242,6 +273,11 @@ int mlx5_dm_sw_icm_dealloc(struct mlx5_core_dev *dev, enum mlx5_sw_icm_type type
>  						    header_modify_pattern_sw_icm_start_address);
>  		block_map = dm->header_modify_pattern_sw_icm_alloc_blocks;
>  		break;
> +	case MLX5_SW_ICM_TYPE_SW_ENCAP:
> +		icm_start_addr = MLX5_CAP64_DEV_MEM(dev,
> +						    indirect_encap_sw_icm_start_address);
> +		block_map = dm->header_encap_sw_icm_alloc_blocks;
> +		break;
>  	default:
>  		return -EINVAL;
>  	}

Hi Leon and Shun,

a minor nit from my side: this patch uses MLX5_SW_ICM_TYPE_SW_ENCAP,
but that enum value isn't present until the following patch.


