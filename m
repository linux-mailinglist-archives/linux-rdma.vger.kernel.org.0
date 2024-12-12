Return-Path: <linux-rdma+bounces-6484-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02CD49EF7E8
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2024 18:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEFC5178F99
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2024 17:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18184222D6A;
	Thu, 12 Dec 2024 17:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JTRHXaZZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7851211493;
	Thu, 12 Dec 2024 17:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734024678; cv=none; b=o1+mt4qmfLq6nwxRkY4N0TF2oGGLdpGQ4UhB5Zogfx4KsfBAbi/i1xzOIkbcalyrXIOup/WkW5jIkm5Gc/AkD5OWNhl0k9kTU56evnegTORcu2cgAtK9kFCB55wctcR7ROaJVhBGniUvvJnY75sR74JVIihx/aNJFgcDCCbiZok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734024678; c=relaxed/simple;
	bh=cqSaXGVyqwsHkzoR1ON5E5Xa1cU6TA0Om7XLkH/MaSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o3xa9caLYIwOefP/udYjuxwDCEeuxS4c9HVPQLutKzhbjCxd9ezPXFGh4t0kQ3dF8ujCrWz5dT4zACVasDt1TrC19yagj9cKH+z2qDZBvGmBwIG4EuuDZ735zG/vMz138XE3D33/dkORLIXz5KMrAjWW5sFmFgXZqSv+aM2/j94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JTRHXaZZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 302CEC4CECE;
	Thu, 12 Dec 2024 17:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734024678;
	bh=cqSaXGVyqwsHkzoR1ON5E5Xa1cU6TA0Om7XLkH/MaSs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JTRHXaZZTwodoVmnWEQ3l8k985OFcuw4VlIUKXTf5iq08b4hyfNbuofpZgDv0MQGp
	 G4AtkpX/AO/8WBp/Rctis/dGuGPfSgwM1U6BhrgtpsaDbuFsWnkUMQCC6IjWsHTMhq
	 mAV9hzP9kYvSwsEJ7L7dS2+pUfDr7SQSsxk0ys12EhRmPJ2++W3r8wmgCb75QeBPB7
	 FbaY0iaHvYFamSiJkViY6YzTz5rCwvZ3/gg6MmrCsCfVr4Sea6tNSQaqEc/ZCyapzD
	 cuUQOTv4bHywH4g2jTE35Iv7Y8pSuLDrZyLJhzooM7dla8InkK5fcAmosbFuEFnLRP
	 r6za3Ozrr9iyg==
Date: Thu, 12 Dec 2024 17:31:13 +0000
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Leon Romanovsky <leonro@nvidia.com>, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	linux-rdma@vger.kernel.org, Itamar Gozlan <igozlan@nvidia.com>,
	Yevgeny Kliteynik <kliteyn@nvidia.com>
Subject: Re: [PATCH net-next 10/12] net/mlx5: DR, add support for ConnectX-8
 steering
Message-ID: <20241212173113.GF73795@kernel.org>
References: <20241211134223.389616-1-tariqt@nvidia.com>
 <20241211134223.389616-11-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211134223.389616-11-tariqt@nvidia.com>

On Wed, Dec 11, 2024 at 03:42:21PM +0200, Tariq Toukan wrote:
> From: Itamar Gozlan <igozlan@nvidia.com>
> 
> Add support for a new steering format version that is implemented by
> ConnectX-8.
> Except for several differences, the STEv3 is identical to STEv2, so
> for most callbacks STEv3 context struct will call STEv2 functions.
> 
> Signed-off-by: Itamar Gozlan <igozlan@nvidia.com>
> Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  .../net/ethernet/mellanox/mlx5/core/Makefile  |   1 +
>  .../mlx5/core/steering/sws/dr_domain.c        |   2 +-
>  .../mellanox/mlx5/core/steering/sws/dr_ste.c  |   2 +
>  .../mellanox/mlx5/core/steering/sws/dr_ste.h  |   1 +
>  .../mlx5/core/steering/sws/dr_ste_v3.c        | 221 ++++++++++++++++++
>  .../mlx5/core/steering/sws/mlx5_ifc_dr.h      |  40 ++++
>  .../mellanox/mlx5/core/steering/sws/mlx5dr.h  |   2 +-
>  7 files changed, 267 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v3.c
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
> index 79fe09de0a9f..10a763e668ed 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
> @@ -123,6 +123,7 @@ mlx5_core-$(CONFIG_MLX5_SW_STEERING) += steering/sws/dr_domain.o \
>  					steering/sws/dr_ste_v0.o \
>  					steering/sws/dr_ste_v1.o \
>  					steering/sws/dr_ste_v2.o \
> +					steering/sws/dr_ste_v3.o \
>  					steering/sws/dr_cmd.o \
>  					steering/sws/dr_fw.o \
>  					steering/sws/dr_action.o \
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c
> index 3d74109f8230..bd361ba6658c 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c
> @@ -8,7 +8,7 @@
>  #define DR_DOMAIN_SW_STEERING_SUPPORTED(dmn, dmn_type)	\
>  	((dmn)->info.caps.dmn_type##_sw_owner ||	\
>  	 ((dmn)->info.caps.dmn_type##_sw_owner_v2 &&	\
> -	  (dmn)->info.caps.sw_format_ver <= MLX5_STEERING_FORMAT_CONNECTX_7))
> +	  (dmn)->info.caps.sw_format_ver <= MLX5_STEERING_FORMAT_CONNECTX_8))

A definition for MLX5_STEERING_FORMAT_CONNECTX_8 seems to be missing
from this patch.

>  
>  bool mlx5dr_domain_is_support_ptrn_arg(struct mlx5dr_domain *dmn)
>  {

...

