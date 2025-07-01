Return-Path: <linux-rdma+bounces-11808-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E762AF03F3
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Jul 2025 21:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0ED01C07729
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Jul 2025 19:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC71128314D;
	Tue,  1 Jul 2025 19:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FTLGOU1P"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7977A27BF95;
	Tue,  1 Jul 2025 19:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751398743; cv=none; b=YU8ciOAVMijm54jWGiSZxylVlTGA1wjuixwvgGimKaLeOzsFlqyjXFn8xiY0R1cP7nst0RL/KOOrdyMwa8klXj3b8k4hqTTe/EjRQb2tEvdHzRtqXstx1EI0AbQ8W/WgZyh8sbTL9BCM2ErZEgrZMTtoaggZRsLRSfQHmyyC4pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751398743; c=relaxed/simple;
	bh=Ed025CxpWSPP6daJsGglhqW98uwy5F6d/hMXtJMezqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LKAMNGpI31G5862YZwBFAT7IFnm9O8QCzKJ9GqgNFt/7jaAxd6rqY9+4SdTaD+H7eaI3W9tzRzJYOHlOb+NDHV8ImG6Y+L2DciOwEYE/hHLNEuQziRN+iBeWggI0PQRXiSaemVK5ykVBODhGBy4d2YMhgDuUVImD1OTdXkGZPgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FTLGOU1P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94E6CC4CEEE;
	Tue,  1 Jul 2025 19:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751398743;
	bh=Ed025CxpWSPP6daJsGglhqW98uwy5F6d/hMXtJMezqE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FTLGOU1PdCGypePZ3j/6y9Ckj80gCs2rbEZiMQPMT7WCu24k9TeCh4pfHezNB8CtH
	 KUCMi8cy6fjswPFQUTmxkyPiHkfaNAKwCBFU9e97Fnl7g1fEVyajuE88Qfg2XqcgY+
	 yYlUIrJ/1Y0qmDBEgkN/I0pe2qLD1FjYBkjM6NrDg0REPymy3sGOMYIuldU2Qdvdor
	 bd/9jG7rhhioBoJiRxQI2qeToQLH4KcUDdmrDcP0kNzt2MARjFQkbRlh/y3cXQgyqb
	 T7wm20R9rBeHN1FM0hY44NgnqD6GMa26gBNX2aYRjU3yYC+WiNLVprEpbZ1Mi0DJHf
	 ZCwmIRRmfly2w==
Date: Tue, 1 Jul 2025 20:38:58 +0100
From: Simon Horman <horms@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Stav Aviram <saviram@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, linux-rdma@vger.kernel.org,
	Mark Bloch <markb@mellanox.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: Re: [PATCH mlx5-next v1] net/mlx5: Check device memory pointer
 before usage
Message-ID: <20250701193858.GA41770@horms.kernel.org>
References: <c88711327f4d74d5cebc730dc629607e989ca187.1751370035.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c88711327f4d74d5cebc730dc629607e989ca187.1751370035.git.leon@kernel.org>

On Tue, Jul 01, 2025 at 03:08:12PM +0300, Leon Romanovsky wrote:
> From: Stav Aviram <saviram@nvidia.com>
> 
> Add a NULL check before accessing device memory to prevent a crash if
> dev->dm allocation in mlx5_init_once() fails.
> 
> Fixes: c9b9dcb430b3 ("net/mlx5: Move device memory management to mlx5_core")
> Signed-off-by: Stav Aviram <saviram@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
> Changelog:
> v1:
>  * Removed extra IS_ERR(dm) check.
> v0:
> https://lore.kernel.org/all/e389fa6ef075af1049cd7026b912d736ebe3ad23.1751279408.git.leonro@nvidia.com
> ---
>  drivers/infiniband/hw/mlx5/dm.c                  | 2 +-
>  drivers/net/ethernet/mellanox/mlx5/core/lib/dm.c | 4 ++--
>  drivers/net/ethernet/mellanox/mlx5/core/main.c   | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/mlx5/dm.c b/drivers/infiniband/hw/mlx5/dm.c
> index b4c97fb62abf..9ded2b7c1e31 100644
> --- a/drivers/infiniband/hw/mlx5/dm.c
> +++ b/drivers/infiniband/hw/mlx5/dm.c
> @@ -282,7 +282,7 @@ static struct ib_dm *handle_alloc_dm_memic(struct ib_ucontext *ctx,
>  	int err;
>  	u64 address;
>  
> -	if (!MLX5_CAP_DEV_MEM(dm_db->dev, memic))
> +	if (!dm_db || !MLX5_CAP_DEV_MEM(dm_db->dev, memic))
>  		return ERR_PTR(-EOPNOTSUPP);

nit: -EOPNOTSUPP doesn't feel like the right error code
     in the !dm_db case.

>  
>  	dm = kzalloc(sizeof(*dm), GFP_KERNEL);

...

